/*
   sexta-feira, 18 de agosto de 201715:05:52
   User: pdv7
   Server: .\SQLEXPRESS
   Database: pdv7
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
USE PDV7
GO

BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.tbCategoriaProduto SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.tbPainelModificacao SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.tbPainelModificacaoCategoria
	(
	IDPainelModificacaoCategoria int NOT NULL IDENTITY(1,1),
	IDPainelModificacao int NOT NULL,
	IDCategoriaProduto int NOT NULL,
	Ordem int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.tbPainelModificacaoCategoria ADD CONSTRAINT
	DF_tbPainelModificacaoCategoria_Ordem DEFAULT 0 FOR Ordem
GO
ALTER TABLE dbo.tbPainelModificacaoCategoria ADD CONSTRAINT
	PK_tbPainelModificacaoCategoria PRIMARY KEY CLUSTERED 
	(
	IDPainelModificacaoCategoria
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.tbPainelModificacaoCategoria ADD CONSTRAINT
	FK_PainelModificacao_PainelModificacaoCategoria FOREIGN KEY
	(
	IDPainelModificacao
	) REFERENCES dbo.tbPainelModificacao
	(
	IDPainelModificacao
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.tbPainelModificacaoCategoria ADD CONSTRAINT
	FK_CategoriaProduto_PainelModificacaoCategoria FOREIGN KEY
	(
	IDCategoriaProduto
	) REFERENCES dbo.tbCategoriaProduto
	(
	IDCategoriaProduto
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.tbPainelModificacaoCategoria SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
