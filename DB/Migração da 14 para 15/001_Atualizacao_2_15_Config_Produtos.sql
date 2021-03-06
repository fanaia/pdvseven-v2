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

begin tran a
BEGIN TRY
       		
	INSERT [dbo].[tbConfiguracao] ([Chave], [Valor], [Descricao]) VALUES (N'PainelModificacaoAvancado', N'0', NULL);
	INSERT [dbo].[tbConfiguracao] ([Chave], [Valor], [Descricao]) VALUES (N'ExibirItensZeradosCaixaPreConta', N'0', NULL);

	INSERT [dbo].[tbConfiguracaoBD] ([IDTipoPDV], [IDPDV], [Chave], [Valor], [ValoresAceitos], [Obrigatorio], [Titulo]) VALUES (NULL, NULL, N'PainelModificacaoAvancado', N'0', N'0|1', 0, N'Exibir Painel de Modificação Avançado')
	INSERT [dbo].[tbConfiguracaoBD] ([IDTipoPDV], [IDPDV], [Chave], [Valor], [ValoresAceitos], [Obrigatorio], [Titulo]) VALUES (NULL, NULL, N'ExibirItensZeradosCaixaPreConta', N'0', N'0|1', 0, N'Exibir itens com valor zero no caixa e pre-conta')
	
	ALTER TABLE dbo.tbProduto ADD
		 ValorUnitario2 decimal(18, 2) NULL,
		 ValorUnitario3 decimal(18, 2) NULL,
		 AssistenteModificacoes bit NULL;

	commit tran a		

END TRY
BEGIN CATCH	
	rollback tran a
	SELECT ERROR_MESSAGE() as 'ERROR_MESSAGE', ERROR_SEVERITY() as 'ERROR_SEVERITY', ERROR_STATE() as 'ERROR_STATE'
END CATCH

