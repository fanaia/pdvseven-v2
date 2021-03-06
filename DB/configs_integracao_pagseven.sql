/****** Script for SelectTopNRows command from SSMS  ******/

insert into tbConfiguracaoBD (Chave,Valor, Obrigatorio,Titulo)
 values ('dtUltimaConsultaPagSeven','2000-01-01T00:00:00',1,'Data da ultima obteção de consultas do PagSeven Server')

 insert into tbConfiguracaoBD (Chave,Valor, Obrigatorio,Titulo)
 values ('HabilitaPagSeven','0',1,' Flag que habilita integração com PagSeven')

 insert into tbConfiguracaoBD (Chave,Valor, Obrigatorio,Titulo)
 values ('IntervaloSyncConsultasPagSeven','60',1,'Intervalo de consultas em segundos')

  insert into tbConfiguracaoBD (Chave,Valor, Obrigatorio,Titulo)
 values ('IDEstabelecimentoPDV7','1',1,'Número de identificação do estabelecimento')

  insert into tbConfiguracaoBD (Chave,Valor, Obrigatorio,Titulo)
 values ('dtFechamentoUltimoPedidoFechadoPag7','',0,'Data do ultimo pedido fechado enviado ao PagSeven (01/01/2000 00:00:00)')






SELECT TOP (1000) [IDConfiguracaoBD]
      ,[IDTipoPDV]
      ,[IDPDV]
      ,[Chave]
      ,[Valor]
      ,[ValoresAceitos]
      ,[Obrigatorio]
      ,[Titulo]
  FROM [pdv7].[dbo].[tbConfiguracaoBD]