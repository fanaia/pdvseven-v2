/*
   segunda-feira, 25 de setembro de 201718:26:23
   Usuário: 
   Servidor: .\sqlexpress
   Banco de Dados: pdv7
   Aplicativo: 
*/

/* Para impedir possíveis problemas de perda de dados, analise este script detalhadamente antes de executá-lo fora do contexto do designer de banco de dados.*/
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
ALTER TABLE dbo.tbPainelModificacao ADD
	IDTipoItem int NULL,
	IDValorUtilizado int NULL,
	IgnorarValorItem bit NULL
GO
DECLARE @v sql_variant 
SET @v = N'1=modificação, 2=produto, 3=categoria'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'SCHEMA', N'dbo', N'TABLE', N'tbPainelModificacao', N'COLUMN', N'IDTipoItem'
GO
DECLARE @v sql_variant 
SET @v = N'1=soma, 2=maior, 3=média'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'SCHEMA', N'dbo', N'TABLE', N'tbPainelModificacao', N'COLUMN', N'IDValorUtilizado'
GO
ALTER TABLE dbo.tbPainelModificacao SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
