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

BEGIN TRAN A
BEGIN TRY

ALTER TABLE dbo.tbPedidoProduto
  DROP CONSTRAINT FK_tbPedidoProduto_tbUsuario1

ALTER TABLE dbo.tbPedidoProduto
  DROP CONSTRAINT FK_tbPedidoProduto_tbUsuario2

ALTER TABLE dbo.tbUsuario SET (LOCK_ESCALATION = TABLE)


ALTER TABLE dbo.tbPedidoProduto
  DROP CONSTRAINT FK_tbPedidoProduto_tbProduto2

ALTER TABLE dbo.tbProduto SET (LOCK_ESCALATION = TABLE)


ALTER TABLE dbo.tbPedidoProduto
  DROP CONSTRAINT FK_tbPedidoProduto_tbPDV

ALTER TABLE dbo.tbPedidoProduto
  DROP CONSTRAINT FK_tbPedidoProduto_tbPDV1

ALTER TABLE dbo.tbPDV SET (LOCK_ESCALATION = TABLE)


ALTER TABLE dbo.tbPedidoProduto
  DROP CONSTRAINT FK_tbPedidoProduto_tbMotivoCancelamento

ALTER TABLE dbo.tbMotivoCancelamento SET (LOCK_ESCALATION = TABLE)


ALTER TABLE dbo.tbPedidoProduto
  DROP CONSTRAINT FK_tbPedidoItem_tbPedido

ALTER TABLE dbo.tbPedido SET (LOCK_ESCALATION = TABLE)


ALTER TABLE dbo.tbPedidoProduto
  DROP CONSTRAINT FK_tbPedidoProduto_tbPainelModificacao

ALTER TABLE dbo.tbPainelModificacao SET (LOCK_ESCALATION = TABLE)


ALTER TABLE dbo.tbPedidoProduto
  DROP CONSTRAINT DF_tbPedidoProduto_RetornarAoEstoque

CREATE TABLE dbo.Tmp_tbPedidoProduto
  (
  IDPedidoProduto int NOT NULL IDENTITY (1, 1),
  IDPedido int NOT NULL,
  IDProduto int NOT NULL,
  IDPedidoProduto_pai int NULL,
  IDPDV int NULL,
  IDUsuario int NULL,
  IDPDV_cancelamento int NULL,
  IDUsuario_cancelamento int NULL,
  IDMotivoCancelamento int NULL,
  Quantidade decimal(18, 3) NOT NULL,
  ValorUnitario decimal(18, 2) NOT NULL,
  ValorAliquota decimal(18, 2) NULL,
  CodigoAliquota varchar(50) NULL,
  Notas varchar(MAX) NULL,
  Cancelado bit NOT NULL,
  DtInclusao datetime NULL,
  DtAlteracao datetime NULL,
  ObservacoesCancelamento varchar(500) NULL,
  DtCancelamento datetime NULL,
  GUIDControleDuplicidade varchar(50) NULL,
  RetornarAoEstoque bit NOT NULL,
  IDPainelModificacao int NULL,
  ValorDesconto decimal(18, 2) NULL
  )  ON [PRIMARY]
   TEXTIMAGE_ON [PRIMARY]

ALTER TABLE dbo.Tmp_tbPedidoProduto SET (LOCK_ESCALATION = TABLE)

ALTER TABLE dbo.Tmp_tbPedidoProduto ADD CONSTRAINT
  DF_tbPedidoProduto_RetornarAoEstoque DEFAULT ((0)) FOR RetornarAoEstoque

SET IDENTITY_INSERT dbo.Tmp_tbPedidoProduto ON

IF EXISTS(SELECT * FROM dbo.tbPedidoProduto)
   EXEC('INSERT INTO dbo.Tmp_tbPedidoProduto (IDPedidoProduto, IDPedido, IDProduto, IDPedidoProduto_pai, IDPDV, IDUsuario, IDPDV_cancelamento, IDUsuario_cancelamento, IDMotivoCancelamento, Quantidade, ValorUnitario, ValorAliquota, CodigoAliquota, Notas, Cancelado, DtInclusao, DtAlteracao, ObservacoesCancelamento, DtCancelamento, GUIDControleDuplicidade, RetornarAoEstoque, IDPainelModificacao, ValorDesconto)
    SELECT IDPedidoProduto, IDPedido, IDProduto, IDPedidoProduto_pai, IDPDV, IDUsuario, IDPDV_cancelamento, IDUsuario_cancelamento, IDMotivoCancelamento, Quantidade, ValorUnitario, ValorAliquota, CodigoAliquota, Notas, Cancelado, DtInclusao, DtAlteracao, ObservacoesCancelamento, DtCancelamento, GUIDControleDuplicidade, RetornarAoEstoque, IDPainelModificacao, ValorDesconto FROM dbo.tbPedidoProduto WITH (HOLDLOCK TABLOCKX)')
SET IDENTITY_INSERT dbo.Tmp_tbPedidoProduto OFF
ALTER TABLE dbo.tbPedidoProduto
  DROP CONSTRAINT FK_tbPedidoProduto_tbPedidoProduto
DROP TABLE dbo.tbPedidoProduto
EXECUTE sp_rename N'dbo.Tmp_tbPedidoProduto', N'tbPedidoProduto', 'OBJECT' 
ALTER TABLE dbo.tbPedidoProduto ADD CONSTRAINT
  PK_tbPedidoItem PRIMARY KEY CLUSTERED 
  (
  IDPedidoProduto
  ) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

ALTER TABLE dbo.tbPedidoProduto ADD CONSTRAINT
  FK_tbPedidoProduto_tbPainelModificacao FOREIGN KEY
  (
  IDPainelModificacao
  ) REFERENCES dbo.tbPainelModificacao
  (
  IDPainelModificacao
  ) ON UPDATE  NO ACTION 
   ON DELETE  NO ACTION 
  
ALTER TABLE dbo.tbPedidoProduto ADD CONSTRAINT
  FK_tbPedidoItem_tbPedido FOREIGN KEY
  (
  IDPedido
  ) REFERENCES dbo.tbPedido
  (
  IDPedido
  ) ON UPDATE  NO ACTION 
   ON DELETE  NO ACTION 
  
ALTER TABLE dbo.tbPedidoProduto ADD CONSTRAINT
  FK_tbPedidoProduto_tbMotivoCancelamento FOREIGN KEY
  (
  IDMotivoCancelamento
  ) REFERENCES dbo.tbMotivoCancelamento
  (
  IDMotivoCancelamento
  ) ON UPDATE  NO ACTION 
   ON DELETE  NO ACTION 
  
ALTER TABLE dbo.tbPedidoProduto ADD CONSTRAINT
  FK_tbPedidoProduto_tbPDV FOREIGN KEY
  (
  IDPDV
  ) REFERENCES dbo.tbPDV
  (
  IDPDV
  ) ON UPDATE  NO ACTION 
   ON DELETE  NO ACTION 
  
ALTER TABLE dbo.tbPedidoProduto ADD CONSTRAINT
  FK_tbPedidoProduto_tbPDV1 FOREIGN KEY
  (
  IDPDV_cancelamento
  ) REFERENCES dbo.tbPDV
  (
  IDPDV
  ) ON UPDATE  NO ACTION 
   ON DELETE  NO ACTION 
  
ALTER TABLE dbo.tbPedidoProduto ADD CONSTRAINT
  FK_tbPedidoProduto_tbPedidoProduto FOREIGN KEY
  (
  IDPedidoProduto_pai
  ) REFERENCES dbo.tbPedidoProduto
  (
  IDPedidoProduto
  ) ON UPDATE  NO ACTION 
   ON DELETE  NO ACTION 
  
ALTER TABLE dbo.tbPedidoProduto ADD CONSTRAINT
  FK_tbPedidoProduto_tbProduto2 FOREIGN KEY
  (
  IDProduto
  ) REFERENCES dbo.tbProduto
  (
  IDProduto
  ) ON UPDATE  NO ACTION 
   ON DELETE  NO ACTION 
  
ALTER TABLE dbo.tbPedidoProduto ADD CONSTRAINT
  FK_tbPedidoProduto_tbUsuario1 FOREIGN KEY
  (
  IDUsuario_cancelamento
  ) REFERENCES dbo.tbUsuario
  (
  IDUsuario
  ) ON UPDATE  NO ACTION 
   ON DELETE  NO ACTION 
  
ALTER TABLE dbo.tbPedidoProduto ADD CONSTRAINT
  FK_tbPedidoProduto_tbUsuario2 FOREIGN KEY
  (
  IDUsuario
  ) REFERENCES dbo.tbUsuario
  (
  IDUsuario
  ) ON UPDATE  NO ACTION 
   ON DELETE  NO ACTION 
  
ALTER TABLE dbo.tbPedido ADD
  IDUsuarioDesconto int NULL,
  IDUsuarioTaxaServico int NULL

ALTER TABLE dbo.tbPedido ADD CONSTRAINT
  FK_tbPedido_tbUsuario1 FOREIGN KEY
  (
  IDUsuarioDesconto
  ) REFERENCES dbo.tbUsuario
  (
  IDUsuario
  ) ON UPDATE  NO ACTION 
   ON DELETE  NO ACTION 
  
ALTER TABLE dbo.tbPedido ADD CONSTRAINT
  FK_tbPedido_tbUsuario2 FOREIGN KEY
  (
  IDUsuarioTaxaServico
  ) REFERENCES dbo.tbUsuario
  (
  IDUsuario
  ) ON UPDATE  NO ACTION 
   ON DELETE  NO ACTION 

ALTER TABLE dbo.tbPedidoProduto ADD
  IDUsuarioDesconto int NULL,
  IDTipoDesconto int NULL

ALTER TABLE dbo.tbPedidoProduto ADD CONSTRAINT
  FK_tbPedidoProduto_tbUsuario FOREIGN KEY
  (
  IDUsuarioDesconto
  ) REFERENCES dbo.tbUsuario
  (
  IDUsuario
  ) ON UPDATE  NO ACTION 
   ON DELETE  NO ACTION 
  
ALTER TABLE dbo.tbPedidoProduto ADD CONSTRAINT
  FK_tbPedidoProduto_tbTipoDesconto FOREIGN KEY
  (
  IDTipoDesconto
  ) REFERENCES dbo.tbTipoDesconto
  (
  IDTipoDesconto
  ) ON UPDATE  NO ACTION 
   ON DELETE  NO ACTION 

IF NOT EXISTS (SELECT 1 from tbConfiguracao where chave = 'SolicitarTipoDescontoItem')
  INSERT INTO tbConfiguracao (chave, valor, descricao) values ('SolicitarTipoDescontoItem', '0', null)

IF NOT EXISTS (SELECT 1 FROM tbSTatusComanda WHERE IDStatusComanda = 50)
  begin
    INSERT INTO tbStatusComanda(IDStatusComanda, Nome) values (50, 'Conta solicitada')
  end

update tbRelatorio set QuerySQL = 'SELECT tp.Nome ''Tipo pagamento'' ,
               COUNT(DISTINCT(pp.IDTipoPagamento)) AS ''Qtd.'' ,
               SUM(pp.Valor) ''Valor total (R$)''
FROM tbCaixa c
LEFT JOIN tbPedido p ON p.idCaixa=c.idCaixa
LEFT JOIN tbPedidoPagamento pp ON pp.idPedido=p.idPedido
LEFT JOIN tbTipoPagamento tp ON tp.idTipoPagamento=pp.idTipoPagamento
WHERE idFechamento=@idFechamento
  AND pp.idTipoPagamento IS NOT NULL
  and p.idStatusPedido = 40
GROUP BY tp.Nome' where IDRelatorio = 4

update tbRelatorio set QuerySQL = 'SELECT
  (SELECT TOP 1 c.Nome
   FROM tbProdutoCategoriaProduto pcp
   INNER JOIN tbCategoriaProduto c ON c.IDCategoriaProduto = pcp.IDCategoriaProduto
   AND pcp.IDProduto = p.IDProduto) AS ''Categoria'' ,
       p.Nome AS ''Item'' ,
       pp.Quantidade AS ''Qtd.'' ,
       pp.ValorUnitario AS ''Valor unit.'' ,
       CAST((pp.ValorUnitario*pp.Quantidade) AS DECIMAL(18, 2)) ''Valor total'' ,
                                                                pp.DtInclusao AS ''Data'' ,
                                                                u.Nome AS ''Vendedor''
FROM tbPedidoProduto pp
INNER JOIN tbProduto p ON p.IDProduto=pp.IDProduto
INNER JOIN tbUsuario u ON u.IDUsuario=pp.IDUsuario
inner join tbpedido pd on pd.IDPedido = pp.IDPedido
WHERE pp.Cancelado=0
  AND DtInclusao BETWEEN @dtInicio AND @dtFim
  and pd.IDStatusPedido = 40'
  where IDRelatorio = 13

update tbRelatorio set QuerySQL = 'SELECT CASE cl.Sexo
           WHEN ''m'' THEN ''Homem''
           WHEN ''f'' THEN ''Mulher''
       END ''Tipo'' ,COUNT(DISTINCT(p.idPedido)) AS ''Qtd.'' ,
  (SELECT SUM(ValorUnitario*Quantidade)
   FROM tbPedidoProduto pp1
   INNER JOIN tbPedido p1 ON p1.idPedido=pp1.idPedido
   INNER JOIN tbCaixa c1 ON c1.IDCaixa=p1.IDCaixa
   INNER JOIN tbCliente cl1 ON cl1.idCliente=p1.idCliente
   WHERE pp1.Cancelado=0
     AND c1.idFechamento=@idFechamento
     AND cl1.Sexo=cl.Sexo
     AND p1.idstatuspedido = 40
     AND pp1.idProduto NOT IN (2,
                               3)) ''Valor produto (R$)'' ,
  (SELECT SUM(ValorUnitario*Quantidade)
   FROM tbPedidoProduto pp1
   INNER JOIN tbPedido p1 ON p1.idPedido=pp1.idPedido
   INNER JOIN tbCaixa c1 ON c1.IDCaixa=p1.IDCaixa
   INNER JOIN tbCliente cl1 ON cl1.idCliente=p1.idCliente
   WHERE pp1.Cancelado=0
     AND c1.idFechamento=@idFechamento
     AND cl1.Sexo=cl.Sexo
     AND p1.idstatuspedido = 40
     AND pp1.idProduto IN (2,
                           3)) ''Valor entrada (R$)'' ,
                               SUM(p.ValorServico) ''Valor servi??o (R$)'' ,
                                                   SUM(p.ValorDesconto) ''Valor desconto (R$)'' ,(
                                                                                                  (SELECT SUM(ValorUnitario*Quantidade)
                                                                                                   FROM tbPedidoProduto pp1
                                                                                                   INNER JOIN tbPedido p1 ON p1.idPedido=pp1.idPedido
                                                                                                   INNER JOIN tbCaixa c1 ON c1.IDCaixa=p1.IDCaixa
                                                                                                   INNER JOIN tbCliente cl1 ON cl1.idCliente=p1.idCliente
                                                                                                   WHERE pp1.Cancelado=0
                                                                                                     AND p1.idstatuspedido = 40
                                                                                                     AND c1.idFechamento=@idFechamento
                                                                                                     AND cl1.Sexo=cl.Sexo) + SUM(p.ValorServico) - SUM(p.ValorDesconto)) ''Valor total (R$)''
FROM tbPedido p (NOLOCK)
LEFT JOIN tbCaixa c (NOLOCK) ON c.IDCaixa=p.IDCaixa
LEFT JOIN tbCliente cl (NOLOCK) ON cl.idCliente=p.idCliente
WHERE c.idFechamento=@idFechamento
  AND p.idstatuspedido = 40
  AND Sexo IS NOT NULL
GROUP BY cl.Sexo'
  where IDRelatorio = 2

update tbRelatorio set QuerySQL = 'SELECT
  (SELECT TOP 1 c.Nome
   FROM tbProdutoCategoriaProduto pcp
   INNER JOIN tbCategoriaProduto c ON c.IDCategoriaProduto = pcp.IDCategoriaProduto
   AND pcp.IDProduto = p.IDProduto) AS ''Categoria'' ,
       p.Nome AS ''Item'' ,
       SUM(pp.Quantidade) AS ''Qtd.'' ,
       CAST(SUM(pp.ValorUnitario*pp.Quantidade) AS DECIMAL(18, 2)) ''Valor total''
FROM tbPedidoProduto pp
INNER JOIN tbProduto p ON p.IDProduto=pp.IDProduto
INNER JOIN tbUsuario u ON u.IDUsuario=pp.IDUsuario
INNER JOIn tbPedido pd ON pd.IDPedido=pp.IDPedido
WHERE pp.Cancelado=0
  AND DtInclusao BETWEEN @dtInicio AND @dtFim
  AND pd.IDStatusPedido = 40
GROUP BY p.IDProduto ,
         p.Nome
ORDER BY p.Nome'
  where IDRelatorio = 14

update tbRelatorio set QuerySQL = 'SELECT p.IDPedido AS ''C??d. Pedido'' ,
       u.Nome AS ''Usu??rio fechamento'' ,
       cl.NomeCompleto AS ''Cliente'' ,
       ISNULL(
                (SELECT SUM(ValorUnitario*Quantidade)
                 FROM tbPedidoProduto
                 WHERE idPedido=p.idPedido
                   AND idProduto NOT IN (2, 3)), 0) AS ''Valor produto (R$)'' ,
       ISNULL(
                (SELECT SUM(ValorUnitario*Quantidade)
                 FROM tbPedidoProduto
                 WHERE idPedido=p.idPedido
                   AND idProduto IN (2, 3)), 0) AS ''Valor entrada (R$)'' ,
       ISNULL(p.ValorServico, 0) AS ''Valor servi??o (R$)'' ,
       ISNULL(p.ValorDesconto, 0) AS ''Valor desconto (R$)'' ,
       (ISNULL(
                 (SELECT SUM(ValorUnitario*Quantidade)
                  FROM tbPedidoProduto
                  WHERE idPedido=p.idPedido), 0) + ISNULL(p.ValorServico, 0) - ISNULL(p.ValorDesconto, 0)) AS ''Valor total (R$)'' ,
       p.Observacoes
FROM tbPedido p
INNER JOIN tbCaixa ca ON ca.idCaixa=p.idCaixa
LEFT JOIN tbCliente cl ON cl.idCliente=p.idCliente
LEFT JOIN tbUsuario u ON u.idUsuario=ca.idUsuario
WHERE ca.idFechamento=@idFechamento
  AND p.IDStatusPedido = 40
  AND p.ValorDesconto>0'
  where IDRelatorio = 5

update tbRelatorio set QuerySQL = 'SELECT p.IDPedido AS ''C??d. Pedido'' ,
       u.Nome AS ''Usu??rio fechamento'' ,
       cl.NomeCompleto AS ''Cliente'' ,
       ISNULL(
                (SELECT SUM(ValorUnitario*Quantidade)
                 FROM tbPedidoProduto
                 WHERE idPedido=p.idPedido
                   AND idProduto NOT IN (2, 3)), 0) AS ''Valor produto (R$)'' ,
       ISNULL(
                (SELECT SUM(ValorUnitario*Quantidade)
                 FROM tbPedidoProduto
                 WHERE idPedido=p.idPedido
                   AND idProduto IN (2, 3)), 0) AS ''Valor entrada (R$)'' ,
       ISNULL(p.ValorServico, 0) AS ''Valor servi??o (R$)'' ,
       ISNULL(p.ValorDesconto, 0) AS ''Valor desconto (R$)'' ,
       (ISNULL(
                 (SELECT SUM(ValorUnitario*Quantidade)
                  FROM tbPedidoProduto
                  WHERE idPedido=p.idPedido), 0) + ISNULL(p.ValorServico, 0) - ISNULL(p.ValorDesconto, 0)) AS ''Valor total (R$)'' ,
       p.Observacoes
FROM tbPedido p
INNER JOIN tbCaixa ca ON ca.idCaixa=p.idCaixa
LEFT JOIN tbCliente cl ON cl.idCliente=p.idCliente
LEFT JOIN tbUsuario u ON u.idUsuario=ca.idUsuario
WHERE ca.idFechamento=@idFechamento
and p.idstatuspedido = 40'
  where IDRelatorio = 6

update tbRelatorio set QuerySQL = 'SELECT p.idPedido AS ''C??d. Pedido'' ,
       cl.NomeCompleto AS ''Cliente'' ,
       p1.Nome AS ''PDV lan??amento'' ,
       u1.Nome AS ''Usu??rio lan??amento'' ,
       pp.DtInclusao AS ''Data lan??amento'' ,
  (SELECT TOP 1 c.Nome
   FROM tbProdutoCategoriaProduto pcp
   INNER JOIN tbCategoriaProduto c ON c.IDCategoriaProduto = pcp.IDCategoriaProduto
   AND pcp.IDProduto = pp.IDProduto) AS ''Categoria'' ,
       pr.Nome AS ''Produto'' ,
       pp.Quantidade AS ''Qtd.'' ,
       pp.ValorUnitario AS ''Valor unit??rio (R$)'' ,
       (pp.ValorUnitario*pp.Quantidade) AS ''Valor total (R$)''
FROM tbPedidoProduto pp
LEFT JOIN tbPedido p ON p.idPedido=pp.idPedido
LEFT JOIN tbCliente cl ON cl.idCliente=p.idCliente
LEFT JOIN tbUsuario u1 ON u1.idUsuario=pp.idUsuario
LEFT JOIN tbPDV p1 ON p1.idPDV=pp.idPDV
LEFT JOIN tbUsuario u2 ON u2.idUsuario=pp.idUsuario_cancelamento
LEFT JOIN tbPDV p2 ON p2.idPDV=pp.idPDV_cancelamento
LEFT JOIN tbProduto pr ON pr.idProduto=pp.idProduto
LEFT JOIN tbCaixa c ON c.idCaixa=p.idCaixa
WHERE c.idFechamento=@idFechamento
  AND pp.Cancelado=0
  AND p.idStatusPedido = 40'
  where IDRelatorio = 10

update tbRelatorio set QuerySQL = 'SELECT
  (SELECT TOP 1 c.Nome
   FROM tbProdutoCategoriaProduto pcp
   INNER JOIN tbCategoriaProduto c ON c.IDCategoriaProduto = pcp.IDCategoriaProduto
   AND pcp.IDProduto = pp.IDProduto) AS ''Categoria'' ,
       pr.Nome AS ''Produto'' ,
       SUM(pp.Quantidade) AS ''Qtd.'' ,
       SUM(pp.ValorUnitario*pp.Quantidade) AS ''Valor total (R$)''
FROM tbPedidoProduto pp
LEFT JOIN tbPedido p ON p.idPedido=pp.idPedido
LEFT JOIN tbCliente cl ON cl.idCliente=p.idCliente
LEFT JOIN tbUsuario u1 ON u1.idUsuario=pp.idUsuario
LEFT JOIN tbPDV p1 ON p1.idPDV=pp.idPDV
LEFT JOIN tbUsuario u2 ON u2.idUsuario=pp.idUsuario_cancelamento
LEFT JOIN tbPDV p2 ON p2.idPDV=pp.idPDV_cancelamento
LEFT JOIN tbProduto pr ON pr.idProduto=pp.idProduto
LEFT JOIN tbCaixa c ON c.idCaixa=p.idCaixa
WHERE c.idFechamento=@idFechamento
  AND pp.Cancelado=0
  AND p.IDStatusPedido = 40
GROUP BY pp.IDProduto,
         pr.Nome'
  where IDRelatorio = 11

insert into tbRelatorio (IDTipoRelatorio, Nome, QuerySQL, Ordem) values (2, 'Taxa de servi??o por gar??om', 'SELECT
   u.Nome
  ,CAST(SUM(pp.ValorUnitario*pp.Quantidade) as money) as ''Vendido''
  ,CAST(SUM(pp.ValorUnitario*pp.Quantidade*0.1) as money) as ''Servi??o''  
  ,CAST(SUM(pp.ValorUnitario*pp.Quantidade*(1-pp.valorDesconto/ValorTotal)) as money) as ''Vendido com Desconto''
  ,CAST(SUM(pp.ValorUnitario*pp.Quantidade*(1-pp.valorDesconto/ValorTotal)*0.1) as money) as ''Servi??o com Desconto''
FROM 
  tbPedido p
  LEFT JOIN tbPedidoProduto pp ON pp.IDPedido=p.IDPedido AND pp.Cancelado=0 AND pp.IDProduto<>4
  LEFT JOIN tbUsuario u ON u.IDUsuario=pp.IDUsuario
WHERE 
    p.DtPedidoFechamento BETWEEN @dtInicio AND @dtFim
    AND
  IDStatusPedido=40
  AND
  ValorTotal>0
  AND
  ValorServico>0
GROUP BY  
  u.IDUsuario, u.Nome
ORDER BY
  u.Nome', '100')

insert into tbRelatorio (IDTipoRelatorio, Nome, QuerySQL, Ordem) values (2, 'Taxa de Entrega Delivery', 'SELECT

  c.Nome as ''Nome Entregador''
  ,pp.Valor as ''Valor da Taxa''
  ,COUNT (p.ValorEntrega) as ''Quantidade''
  ,SUM (p.ValorEntrega) as ''Valor Total''
  
FROM
  tbpedido p
  INNER JOIN tbTaxaEntrega pp ON p.IDTaxaEntrega=pp.IDTaxaEntrega
  INNER JOIN tbEntregador c ON p.IDEntregador=c.IDEntregador

WHERE
  p.IDStatusPedido=40
  AND
  p.IDTipoPedido=30
  AND
  p.DtPedido BETWEEN @dtInicio AND @dtFim
GROUP BY
  c.Nome
  ,pp.Valor
  ,p.ValorEntrega
  ,ValorEntrega', '110')

insert into tbRelatorio (IDTipoRelatorio, Nome, QuerySQL, Ordem) values (1, 'Motivos de Desconto', 'SELECT 
   p.IDPedido as ''C??d. Pedido''
  ,u.Nome as ''Usu??rio fechamento''
  ,cl.NomeCompleto as ''Cliente''
  ,ISNULL((SELECT SUM(ValorUnitario*Quantidade) FROM tbPedidoProduto WHERE idPedido=p.idPedido AND idProduto NOT IN (2, 3)), 0) as ''Valor produto (R$)''
  ,ISNULL((SELECT SUM(ValorUnitario*Quantidade) FROM tbPedidoProduto WHERE idPedido=p.idPedido AND idProduto IN (2, 3)), 0) as ''Valor entrada (R$)''
  ,ISNULL(p.ValorServico, 0) as ''Valor servi??o (R$)''
  ,ISNULL(p.ValorDesconto, 0) as ''Valor desconto (R$)''
  ,(ISNULL((SELECT SUM(ValorUnitario*Quantidade) FROM tbPedidoProduto WHERE idPedido=p.idPedido), 0) + ISNULL(p.ValorServico, 0) - ISNULL(p.ValorDesconto, 0)) as ''Valor total (R$)''
  ,p.Observacoes as ''Observa????es''
  ,a.Nome as ''Tipo Desconto''
  ,p.DtPedidoFechamento as ''Data''
FROM 
  tbPedido p 
  INNER JOIN tbCaixa ca ON ca.idCaixa=p.idCaixa
  LEFT JOIN tbCliente cl ON cl.idCliente=p.idCliente
  LEFT JOIN tbUsuario u ON u.idUsuario=ca.idUsuario
  LEFT JOIN tbTipoDesconto a ON p.IDTipoDesconto=a.IDTipoDesconto
WHERE 
  ca.idFechamento=@idFechamento
  AND
  p.IDStatusPedido = 40
  AND
  p.ValorDesconto>0
  AND
  p.idtipodesconto is not NULL', '120')

insert into tbRelatorio (IDTipoRelatorio, Nome, QuerySQL, Ordem) values (1, '', 'SELECT 
   p.IDPedido as ''C??d. Pedido''
  ,u.Nome as ''Usu??rio fechamento''
  ,cl.NomeCompleto as ''Cliente''
  ,ISNULL((SELECT SUM(ValorUnitario*Quantidade) FROM tbPedidoProduto WHERE idPedido=p.idPedido AND idProduto NOT IN (2, 3)), 0) as ''Valor produto (R$)''
  ,ISNULL((SELECT SUM(ValorUnitario*Quantidade) FROM tbPedidoProduto WHERE idPedido=p.idPedido AND idProduto IN (2, 3)), 0) as ''Valor entrada (R$)''
  ,ISNULL(p.ValorServico, 0) as ''Valor servi??o (R$)''
  ,ISNULL(p.ValorDesconto, 0) as ''Valor desconto (R$)''
  ,(ISNULL((SELECT SUM(ValorUnitario*Quantidade) FROM tbPedidoProduto WHERE idPedido=p.idPedido), 0) + ISNULL(p.ValorServico, 0) - ISNULL(p.ValorDesconto, 0)) as ''Valor total (R$)''
  ,p.Observacoes as ''Observa????es''
  ,a.Nome as ''Tipo Desconto''
  ,p.DtPedidoFechamento as ''Data''
FROM 
  tbPedido p 
  INNER JOIN tbCaixa ca ON ca.idCaixa=p.idCaixa
  LEFT JOIN tbCliente cl ON cl.idCliente=p.idCliente
  LEFT JOIN tbUsuario u ON u.idUsuario=ca.idUsuario
  LEFT JOIN tbTipoDesconto a ON p.IDTipoDesconto=a.IDTipoDesconto
WHERE 
  ca.idFechamento=@idFechamento
  AND
  p.IDTipoPedido = 40
  AND
  p.ValorDesconto>0
  AND
  p.idtipodesconto is not NULL', '130')


CREATE TABLE dbo.tbConfiguracaoBD
  (
  IDConfiguracaoBD int NOT NULL IDENTITY (1, 1),
  IDTipoPDV int NULL,
  IDPDV int NULL,
  Chave varchar(100) NULL,
  Valor varchar(1000) NULL,
  ValoresAceitos varchar(1000) NULL,
  Obrigatorio bit NOT NULL,
  Titulo varchar(1000) NULL
  )  ON [PRIMARY]
ALTER TABLE dbo.tbConfiguracaoBD ADD CONSTRAINT
  DF_tbConfiguracaoBD_Obrigatorio DEFAULT (0) FOR Obrigatorio
ALTER TABLE dbo.tbConfiguracaoBD ADD CONSTRAINT
  PK_tbConfiguracaoBD PRIMARY KEY CLUSTERED 
  (
  IDConfiguracaoBD
  ) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

ALTER TABLE dbo.tbConfiguracaoBD ADD CONSTRAINT
  FK_tbConfiguracaoBD_tbTipoPDV FOREIGN KEY
  (
  IDTipoPDV
  ) REFERENCES dbo.tbTipoPDV
  (
  IDTipoPDV
  ) ON UPDATE  NO ACTION 
   ON DELETE  NO ACTION 
  
ALTER TABLE dbo.tbConfiguracaoBD ADD CONSTRAINT
  FK_tbConfiguracaoBD_tbPDV FOREIGN KEY
  (
  IDPDV
  ) REFERENCES dbo.tbPDV
  (
  IDPDV
  ) ON UPDATE  NO ACTION 
   ON DELETE  NO ACTION 
  
ALTER TABLE dbo.tbConfiguracaoBD SET (LOCK_ESCALATION = TABLE)

insert into tbTipoPDV(IDTipoPDV, Nome)
values
(80, 'Gerenciador de Impressao'),
(90, 'Integra????o Tiny'),
(100, 'WebService')


IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'AliquotaPadrao')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'AliquotaPadrao', 'II', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'autSempre')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'autSempre', '1', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'chaveAtivacao')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'chaveAtivacao', NULL, NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'comandaComCheckin')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'comandaComCheckin', '1', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'creditoPadrao')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'creditoPadrao', '0', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'DDDPadrao')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'DDDPadrao', '11', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'dtUltimaVerificacao')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'dtUltimaVerificacao', NULL, NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'dtValidade')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'dtValidade', NULL, NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'ImagemProdutoAltura')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'ImagemProdutoAltura', '800', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'ImagemProdutoAlturaThumb')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'ImagemProdutoAlturaThumb', '80', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'ImagemProdutoLargura')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'ImagemProdutoLargura', '1280', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'ImagemProdutoLarguraThumb')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'ImagemProdutoLarguraThumb', '128', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'imprimirPedidosDescontoFechamento')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'imprimirPedidosDescontoFechamento', '1', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'imprimirProdutosCanceladosFechamento')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'imprimirProdutosCanceladosFechamento', '1', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'imprimirProdutosVendidosFechamento')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'imprimirProdutosVendidosFechamento', '1', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'infCFe_codigoAtivacao')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'infCFe_codigoAtivacao', '123456789', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'infCFe_det_prod_indRegra')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'infCFe_det_prod_indRegra', 'A', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'infCFe_emit_CNPJ')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'infCFe_emit_CNPJ', '14200166000166', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'infCFe_emit_cRegTrib')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'infCFe_emit_cRegTrib', '1', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'infCFe_emit_cRegTribISSQN')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'infCFe_emit_cRegTribISSQN', '1', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'infCFe_emit_IE')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'infCFe_emit_IE', '111111111111', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'infCFe_emit_IM')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'infCFe_emit_IM', '111111', NULL, 0, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'infCFe_emit_indRatISSQN')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'infCFe_emit_indRatISSQN', 'N', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'infCFe_ide_CNPJ')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'infCFe_ide_CNPJ', '23487403000102', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'infCFe_ide_signAC')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'infCFe_ide_signAC', NULL, NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'infCFe_versaoDadosEnt')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'infCFe_versaoDadosEnt', '0.07', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'integracao1')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'integracao1', '0', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'integracao2')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'integracao2', '0', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'limiteComanda')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'limiteComanda', '300', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'msgCupom')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'msgCupom', 'Sistema PDV7  www.pdvseven.com.br', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'PermitirPedidoModificacaoInvalido')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'PermitirPedidoModificacaoInvalido', '0', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'PossuiCardapio')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'PossuiCardapio', '0', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'PossuiSAT')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'PossuiSAT', '1', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'RelatorioFechamento-PedidosDescontoDetalhe')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'RelatorioFechamento-PedidosDescontoDetalhe', '1', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'RelatorioFechamento-PedidosDescontoResumo')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'RelatorioFechamento-PedidosDescontoResumo', '1', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'RelatorioFechamento-ProdutosAbertos')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'RelatorioFechamento-ProdutosAbertos', '1', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'RelatorioFechamento-ProdutosCancelados')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'RelatorioFechamento-ProdutosCancelados', '1', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'RelatorioFechamento-ProdutosVendidos')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'RelatorioFechamento-ProdutosVendidos', '1', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'RelatorioFechamento-ResumoCaixa')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'RelatorioFechamento-ResumoCaixa', '1', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'RelatorioFechamento-ResumoTipoPagamento')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'RelatorioFechamento-ResumoTipoPagamento', '1', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'SolicitarSenhaDesconto')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'SolicitarSenhaDesconto', '1', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'SolicitarTipoDesconto')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'SolicitarTipoDesconto', '0', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'SolicitarTipoDescontoItem')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'SolicitarTipoDescontoItem', '0', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'taxaServicoBalcao')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'taxaServicoBalcao', '0', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'taxaServicoComanda')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'taxaServicoComanda', '0', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'taxaServicoEntrega')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'taxaServicoEntrega', '0', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'taxaServicoMesa')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'taxaServicoMesa', '10', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'toleranciaPagamento')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'toleranciaPagamento', '0', NULL, 1, NULL)
  END
IF NOT EXISTS (SELECT 1 FROM tbConfiguracaoBD WHERE Chave = 'ValidarPedidoModificacaoInvalido')
  BEGIN
    INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo)
    VALUES(NULL, NULL, 'ValidarPedidoModificacaoInvalido', '0', NULL, 1, NULL)
  END

INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(10, NULL, 'AbrirGaveta', '0', '0|1', 1, 'Abrir gaveta ap??s cada venda')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(40, NULL, 'area', NULL, NULL, 1, '??rea de produ????o padr??o (ID)')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(60, NULL, 'area', NULL, NULL, 0, '??rea de produ????o padr??o (ID)')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(60, NULL, 'askprice', '0', '0|1', 1, 'Solicitar pre??o quando pre??o ?? 0')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(40, NULL, 'askprice', '0', '0|1', 1, 'Solicitar pre??o quando pre??o ?? 0')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(30, NULL, 'AutenticarSempre', '0', '0|1', 1, 'Sempre Solicitar Autentica????o')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(60, NULL, 'autenticarsempre', '0', '0|1', 1, 'Sempre solicitar autentica????o')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(40, NULL, 'autenticarsempre', '0', '0|1', 1, 'Sempre solicitar autentica????o')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(NULL, NULL, 'CaminhoXmlSat', 'C:\\PDVSeven\\SAT', '', 1, 'Caminho para salvar os XMLs do S@T')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(90, NULL, 'codigo', '1', '0:C??digo do Produto|1:C??digo de Integra????o 1|2:C??digo de Integra????o 2', 1, 'C??digo para utilizar na integra????o')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(30, NULL, 'CodigoBarras', '1', '0|1', 1, 'Leitura de c??digo de barras')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(60, NULL, 'config', '2606', NULL, 1, 'Senha para configurar o programa')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(40, NULL, 'config', '2606', NULL, 1, 'Senha para configurar o programa')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(10, NULL, 'CupomSAT', 'elgin', 'elgin:Elgin|bematech:Bematech', 1, 'Modelo do Cupom S@T')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(80, NULL, 'CupomSat', 'elgin', 'elgin:Elgin|bematech:Bematech', 1, 'Modelo do Cupom S@T')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(10, NULL, 'digitosCodigo', '4', NULL, 1, 'Quantidade de D??gitos para o C??digo do produto')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(30, NULL, 'digitosCodigo', '4', NULL, 1, 'Quantidade de D??gitos para o C??digo do produto')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(30, NULL, 'EsconderComanda', '0', '0|1', 1, 'Esconder Comanda')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(30, NULL, 'EsconderMesa', '0', '0|1', 1, 'Esconder Mesa')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(10, NULL, 'etiquetaBalanca', '0', '0|1', 1, 'Utiliza Balan??a Etiquetadora')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(30, NULL, 'etiquetaBalanca', '0', '0|1', 1, 'Utiliza Balan??a Etiquetadora')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(10, NULL, 'GerarTicketPrePago', '0', '0|1', 1, 'Gerar Ticket Pr?? Pago')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(40, NULL, 'impressaoconta', '0', '0|1', 1, 'Definir local imp. conta')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(60, NULL, 'impressaoconta', '0', '0|1', 1, 'Definir local imp. conta')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(NULL, NULL, 'ImprimirViaControleDelivery', '0', '0|1', 1, 'Imprimir Via de Controle no Delivery')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(NULL, NULL, 'infCFe_12741', '1', '0|1', 1, 'Imprimir Lei da Transpar??ncia no Cupom S@T')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(NULL, NULL, 'infCFe_UF', '35', '11:RO|12:AC|13:AM|14:RR|15:PA|16:AP|17:TO|21:MA|22:PI|23:CE|24:RN|25:PB|26:PE|27:AL|28:SE|29:BA|31:MG|32:ES|33:RJ|35:SP|41:PR|42:SC|43:RS|50:MS|51:MT|52:GO|53:DF', 0, 'UF')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(NULL, NULL, 'infCFe_urlServicoSAT', NULL, NULL, 0, 'URL do WS S@T')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(90, NULL, 'intervalo', '1', NULL, 1, 'Intervalo (em minutos) de cada sincroniza????o')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(40, NULL, 'listimpressaoconta', '-1', NULL, 1, 'Local de impress??o de conta (ID)')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(60, NULL, 'listimpressaoconta', '-1', NULL, 1, 'Local de impress??o de conta (ID)')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(30, NULL, 'Log', 'C:\\PDV7\\log', NULL, 1, 'Caminho Log')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(10, NULL, 'Log', 'C:\\PDV7\\log\\teste', NULL, 1, 'Caminho Log')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(10, NULL, 'LogAtivado', '1', '0|1', 1, 'Log Ativado')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(NULL, NULL, 'ManterImpressaoPorDias', '0', NULL, 1, 'Dias Para manter Ordens de Impress??o No BD')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(10, NULL, 'ManterPosicaoLista', '0', '0|1', 1, 'Manter posi????o selecionada na lista')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(10, NULL, 'ModeloImpressora', '', NULL, 0, 'Nome da Impressora')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(10, NULL, 'ModoFiscal', '1', '0|1', 1, 'Modo Fiscal')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(40, NULL, 'mostrarlista', '0', '0|1', 1, 'Exibir lista de produtos')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(60, NULL, 'mostrarlista', '0', '0|1', 1, 'Exibir lista de produtos')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(60, NULL, 'mostrarresumo', '1', '0|1', 1, 'Exibir resumo do pedido')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(40, NULL, 'mostrarresumo', '1', '0|1', 1, 'Exibir resumo do pedido')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(NULL, NULL, 'MsgTicketPrePago', NULL, NULL, 0, 'Mensagem do Ticket Pr??-Pago')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(30, NULL, 'OrdemImpressao', '1', '0|1', 1, 'Ordem Impress??o')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(10, NULL, 'OrdemImpressao', '1', '0|1', 1, 'Ordem Impress??o')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(100, NULL, 'OrdemImpressao', '1', '0|1', 1, 'Ordem Impress??o')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(10, NULL, 'PortaBalanca', 'COM1', NULL, 1, 'Porta da Balan??a')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(30, NULL, 'PortaBalanca', 'COM1', NULL, 1, 'Porta da Balan??a')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(10, NULL, 'PortaImpressora', 'USB001', NULL, 1, 'Porta da Impressora')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(10, NULL, 'precoPeso', 'peso', 'peso:Peso|preco:Pre??o', 1, 'O que est?? sendo impresso na etiqueta')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(30, NULL, 'precoPeso', 'peso', 'peso:Peso|preco:Pre??o', 1, 'O que est?? sendo impresso na etiqueta')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(10, NULL, 'ProtocoloBalanca', 'TOLEDO', 'TOLEDO|FILIZOLA', 1, 'Protocolo de comunica????o da Balan??a')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(30, NULL, 'ProtocoloBalanca', 'TOLEDO', 'TOLEDO|FILIZOLA', 1, 'Protocolo de comunica????o da Balan??a')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(100, NULL, 'SalvarXMLPedido', '0', '0|1', 1, 'Salvar XML da Pedido')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(100, NULL, 'SalvarXMLRequisicoes', '0', '0|1', 1, 'Salvar XML da Requisi????o')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(NULL, NULL, 'SalvarXmlSat', '0', '0|1', 1, 'Salvar XMLs do S@T')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(40, NULL, 'senha', '9999', NULL, 1, 'Senha para sair do programa')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(60, NULL, 'senha', '9999', NULL, 1, 'Senha para sair do programa')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(60, NULL, 'senhamesa', '555', NULL, 1, 'Senha para definir mesa')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(60, NULL, 'solicitarpessoas', '0', '0|1', 1, 'Solicitar info de fechamento')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(40, NULL, 'solicitarpessoas', '0', '0|1', 1, 'Solicitar info de fechamento')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(40, NULL, 'solicitarref', '0', '0|1', 1, 'Solicitar Refer??ncia')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(60, NULL, 'solicitarref', '0', '0|1', 1, 'Solicitar Refer??ncia')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(40, NULL, 'terminal', '0', '0|1', 1, 'Usar Modo Terminal (Tablet)')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(60, NULL, 'terminal', '0', '0|1', 1, 'Usar Modo Terminal (Tablet)')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(60, NULL, 'tipocliente', '0', '0:CPF/CNPJ|1:E-mail|2:Telefone', 1, 'Chave cliente')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(40, NULL, 'tipocliente', '0', '0:CPF/CNPJ|1:E-mail|2:Telefone', 1, 'Chave cliente')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(10, NULL, 'TipoGerenciadorImpressao', '4', '0:Sem Impressora|1:Impressora Windows|2:ACBr|4:S@T', 1, 'Tipo Gerenciador Impress??o')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(10, NULL, 'TipoImpressaoSat', 'Novo', 'Novo|Antigo', 1, 'Tipo Impress??o S@T')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(80, NULL, 'TipoImpressaoSat', 'Novo', 'Novo|Antigo', 1, 'Tipo Impress??o S@T')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(10, NULL, 'TipoPedidoPadrao', '10', '10:Mesa|20:Comanda|30:Delivery|40:Balc??o', 0, NULL)
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(90, NULL, 'token', '', NULL, 1, 'Token de Integra????o do TinyERP')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(40, NULL, 'usarareas', '0', '0|1', 1, 'Usar ??reas de produ????o')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(60, NULL, 'usarareas', '0', '0|1', 1, 'Usar ??reas de produ????o')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(60, NULL, 'usuario', '2010', NULL, 1, 'ID do Usu??rio do card??pio')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(10, NULL, 'VelocidadeImpressora', '115200', '9600:Serial|115200:USB', 1, 'Velocidade da Impressora')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(60, NULL, 'verifimagens', '0', '0|1', 1, 'Verificar por novas imagens')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(60, NULL, 'wifi', '1', '0|1', 1, 'Extender Timeout')
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(40, NULL, 'wifi', '1', '0|1', 1, 'Extender Timeout')

INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(10, NULL, 'tipoPedidoBalcao', '1', NULL, 1, NULL)
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(10, NULL, 'tipoPedidoComanda', '1', NULL, 1, NULL)
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(10, NULL, 'tipoPedidoEntrega', '1', NULL, 1, NULL)
INSERT INTO tbConfiguracaoBD(IDTipoPDV, IDPDV, Chave, Valor, ValoresAceitos, Obrigatorio, Titulo) VALUES(10, NULL, 'tipoPedidoMesa', '1', NULL, 1, NULL)

UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Al??quota Padr??o' WHERE IDTipoPDV IS NULL AND Chave = 'AliquotaPadrao'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Atualizado 2.11' WHERE IDTipoPDV IS NULL AND Chave = 'atualizado211'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = NULL WHERE IDTipoPDV IS NULL AND Chave = 'autSempre'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Chave de Ativa????o' WHERE IDTipoPDV IS NULL AND Chave = 'chaveAtivacao'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Comanda com Checkin' WHERE IDTipoPDV IS NULL AND Chave = 'comandaComCheckin'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Cr??dito Padr??o' WHERE IDTipoPDV IS NULL AND Chave = 'creditoPadrao'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'DDD Padr??o' WHERE IDTipoPDV IS NULL AND Chave = 'DDDPadrao'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = NULL WHERE IDTipoPDV IS NULL AND Chave = 'dtUltimaVerificacao'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = NULL WHERE IDTipoPDV IS NULL AND Chave = 'dtValidade'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Altura da Imagem do Produto' WHERE IDTipoPDV IS NULL AND Chave = 'ImagemProdutoAltura'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Altura da Thumbnail da Imagem do Produto' WHERE IDTipoPDV IS NULL AND Chave = 'ImagemProdutoAlturaThumb'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Largura da Imagem do Produto' WHERE IDTipoPDV IS NULL AND Chave = 'ImagemProdutoLargura'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Largura da Thumbnail da Imagem do Produto' WHERE IDTipoPDV IS NULL AND Chave = 'ImagemProdutoLarguraThumb'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Imprimir pedidos com desconto no Fechamento' WHERE IDTipoPDV IS NULL AND Chave = 'imprimirPedidosDescontoFechamento'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Imprimir Produtos Cancelados no Fechamento' WHERE IDTipoPDV IS NULL AND Chave = 'imprimirProdutosCanceladosFechamento'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Imprimir Produtos Vendidos no Fechamento' WHERE IDTipoPDV IS NULL AND Chave = 'imprimirProdutosVendidosFechamento'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'C??digo de Ativa????o' WHERE IDTipoPDV IS NULL AND Chave = 'infCFe_codigoAtivacao'
UPDATE tbConfiguracaoBD SET ValoresAceitos = 'A:Arredondamento|T:Truncamento', Titulo = 'Regra de Arredondamento' WHERE IDTipoPDV IS NULL AND Chave = 'infCFe_det_prod_indRegra'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'CNPJ do Emitente' WHERE IDTipoPDV IS NULL AND Chave = 'infCFe_emit_CNPJ'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Regime Tribut??rio' WHERE IDTipoPDV IS NULL AND Chave = 'infCFe_emit_cRegTrib'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Regime especial de tributa????o' WHERE IDTipoPDV IS NULL AND Chave = 'infCFe_emit_cRegTribISSQN'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'IE do Emitente' WHERE IDTipoPDV IS NULL AND Chave = 'infCFe_emit_IE'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'IM do Emitente' WHERE IDTipoPDV IS NULL AND Chave = 'infCFe_emit_IM'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Indicador de rateio do Desconto sobre subtotal entre itens sujeitos ?? tributa????o pelo ISSQN' WHERE IDTipoPDV IS NULL AND Chave = 'infCFe_emit_indRatISSQN'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'CNPJ da Softwarehouse' WHERE IDTipoPDV IS NULL AND Chave = 'infCFe_ide_CNPJ'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = NULL WHERE IDTipoPDV IS NULL AND Chave = 'infCFe_ide_signAC'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0.06:Vers??o 6|0.07:Vers??o 7|0.08:Vers??o 8', Titulo = 'Vers??o do XML' WHERE IDTipoPDV IS NULL AND Chave = 'infCFe_versaoDadosEnt'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Habilitar Integra????o 1' WHERE IDTipoPDV IS NULL AND Chave = 'integracao1'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Habilitar Integra????o 2' WHERE IDTipoPDV IS NULL AND Chave = 'integracao2'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Limite de gastos para Comanda' WHERE IDTipoPDV IS NULL AND Chave = 'limiteComanda'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Mensagem do Cupom Fiscal' WHERE IDTipoPDV IS NULL AND Chave = 'msgCupom'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Permitir Pedidos com Modifica????es Inv??lidas no Caixa' WHERE IDTipoPDV IS NULL AND Chave = 'PermitirPedidoModificacaoInvalido'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Possui Card??pio' WHERE IDTipoPDV IS NULL AND Chave = 'PossuiCardapio'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Possui S@T' WHERE IDTipoPDV IS NULL AND Chave = 'PossuiSAT'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Exibir Detalhes de Descontos' WHERE IDTipoPDV IS NULL AND Chave = 'RelatorioFechamento-PedidosDescontoDetalhe'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Exibir Resumo de Descontos' WHERE IDTipoPDV IS NULL AND Chave = 'RelatorioFechamento-PedidosDescontoResumo'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Exibir Produtos em Aberto' WHERE IDTipoPDV IS NULL AND Chave = 'RelatorioFechamento-ProdutosAbertos'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Exibir Produtos Cancelados' WHERE IDTipoPDV IS NULL AND Chave = 'RelatorioFechamento-ProdutosCancelados'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Exibir Produtos Vendidos' WHERE IDTipoPDV IS NULL AND Chave = 'RelatorioFechamento-ProdutosVendidos'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Exibir Resumo por Caixa' WHERE IDTipoPDV IS NULL AND Chave = 'RelatorioFechamento-ResumoCaixa'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Exibir Resumo por Tipo de Pagamento' WHERE IDTipoPDV IS NULL AND Chave = 'RelatorioFechamento-ResumoTipoPagamento'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Solicitar senha de gerente para Desconto' WHERE IDTipoPDV IS NULL AND Chave = 'SolicitarSenhaDesconto'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Solicitar tipo de Desconto' WHERE IDTipoPDV IS NULL AND Chave = 'SolicitarTipoDesconto'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Solicitar tipo de Desconto no Desconto por Item' WHERE IDTipoPDV IS NULL AND Chave = 'SolicitarTipoDescontoItem'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Taxa de Servi??o Balc??o %' WHERE IDTipoPDV IS NULL AND Chave = 'taxaServicoBalcao'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Taxa de Servi??o Comanda %' WHERE IDTipoPDV IS NULL AND Chave = 'taxaServicoComanda'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Taxa de Servi??o Delivery %' WHERE IDTipoPDV IS NULL AND Chave = 'taxaServicoEntrega'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Taxa de Servi??o Mesa %' WHERE IDTipoPDV IS NULL AND Chave = 'taxaServicoMesa'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Toler??ncia no Pagamento' WHERE IDTipoPDV IS NULL AND Chave = 'toleranciaPagamento'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Validar Limites de Modifica????es no Caixa' WHERE IDTipoPDV IS NULL AND Chave = 'ValidarPedidoModificacaoInvalido'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Mensagem do Ticket Pr??-Pago' WHERE IDTipoPDV IS NULL AND Chave = 'MsgTicketPrePago'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Imprimir Via de Controle no Delivery' WHERE IDTipoPDV IS NULL AND Chave = 'ImprimirViaControleDelivery'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'URL do WS S@T' WHERE IDTipoPDV IS NULL AND Chave = 'infCFe_urlServicoSAT'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '11:RO|12:AC|13:AM|14:RR|15:PA|16:AP|17:TO|21:MA|22:PI|23:CE|24:RN|25:PB|26:PE|27:AL|28:SE|29:BA|31:MG|32:ES|33:RJ|35:SP|41:PR|42:SC|43:RS|50:MS|51:MT|52:GO|53:DF', Titulo = 'UF' WHERE IDTipoPDV IS NULL AND Chave = 'infCFe_UF'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Imprimir Lei da Transpar??ncia no Cupom S@T' WHERE IDTipoPDV IS NULL AND Chave = 'infCFe_12741'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Salvar XMLs do S@T' WHERE IDTipoPDV IS NULL AND Chave = 'SalvarXmlSat'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '', Titulo = 'Caminho para salvar os XMLs do S@T' WHERE IDTipoPDV IS NULL AND Chave = 'CaminhoXmlSat'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Dias Para manter Ordens de Impress??o No BD' WHERE IDTipoPDV IS NULL AND Chave = 'ManterImpressaoPorDias'

UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Habilitar Tipo de Pedido Balc??o' WHERE IDTipoPDV = 10 AND Chave = 'tipoPedidoBalcao'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Habilitar Tipo de Pedido Comanda' WHERE IDTipoPDV = 10 AND Chave = 'tipoPedidoComanda'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Habilitar Tipo de Pedido Delivery' WHERE IDTipoPDV = 10 AND Chave = 'tipoPedidoEntrega'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Habilitar Tipo de Pedido Mesa' WHERE IDTipoPDV = 10 AND Chave = 'tipoPedidoMesa'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Log Ativado' WHERE IDTipoPDV = 10 AND Chave = 'LogAtivado'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Ordem Impress??o' WHERE IDTipoPDV = 10 AND Chave = 'OrdemImpressao'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Caminho Log' WHERE IDTipoPDV = 10 AND Chave = 'Log'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0:Sem Impressora|1:Impressora Windows|2:ACBr|4:S@T', Titulo = 'Tipo Gerenciador Impress??o' WHERE IDTipoPDV = 10 AND Chave = 'TipoGerenciadorImpressao'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Modo Fiscal' WHERE IDTipoPDV = 10 AND Chave = 'ModoFiscal'
UPDATE tbConfiguracaoBD SET ValoresAceitos = 'Novo|Antigo', Titulo = 'Tipo Impress??o S@T' WHERE IDTipoPDV = 10 AND Chave = 'TipoImpressaoSat'
UPDATE tbConfiguracaoBD SET ValoresAceitos = 'elgin:Elgin|bematech:Bematech', Titulo = 'Modelo do Cupom S@T' WHERE IDTipoPDV = 10 AND Chave = 'CupomSAT'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Nome da Impressora' WHERE IDTipoPDV = 10 AND Chave = 'ModeloImpressora'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Porta da Impressora' WHERE IDTipoPDV = 10 AND Chave = 'PortaImpressora'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '9600:Serial|115200:USB', Titulo = 'Velocidade da Impressora' WHERE IDTipoPDV = 10 AND Chave = 'VelocidadeImpressora'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Abrir gaveta ap??s cada venda' WHERE IDTipoPDV = 10 AND Chave = 'AbrirGaveta'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Porta da Balan??a' WHERE IDTipoPDV = 10 AND Chave = 'PortaBalanca'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Gerar Ticket Pr?? Pago' WHERE IDTipoPDV = 10 AND Chave = 'GerarTicketPrePago'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Manter posi????o selecionada na lista' WHERE IDTipoPDV = 10 AND Chave = 'ManterPosicaoLista'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Utiliza Balan??a Etiquetadora' WHERE IDTipoPDV = 10 AND Chave = 'etiquetaBalanca'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Quantidade de D??gitos para o C??digo do produto' WHERE IDTipoPDV = 10 AND Chave = 'digitosCodigo'
UPDATE tbConfiguracaoBD SET ValoresAceitos = 'peso:Peso|preco:Pre??o', Titulo = 'O que est?? sendo impresso na etiqueta' WHERE IDTipoPDV = 10 AND Chave = 'precoPeso'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Ordem Impress??o' WHERE IDTipoPDV = 30 AND Chave = 'OrdemImpressao'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Caminho Log' WHERE IDTipoPDV = 30 AND Chave = 'Log'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Porta da Balan??a' WHERE IDTipoPDV = 30 AND Chave = 'PortaBalanca'
UPDATE tbConfiguracaoBD SET ValoresAceitos = 'TOLEDO|FILIZOLA', Titulo = 'Protocolo de comunica????o da Balan??a' WHERE IDTipoPDV = 10 AND Chave = 'ProtocoloBalanca'
UPDATE tbConfiguracaoBD SET ValoresAceitos = 'TOLEDO|FILIZOLA', Titulo = 'Protocolo de comunica????o da Balan??a' WHERE IDTipoPDV = 30 AND Chave = 'ProtocoloBalanca'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Leitura de c??digo de barras' WHERE IDTipoPDV = 30 AND Chave = 'CodigoBarras'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Sempre Solicitar Autentica????o' WHERE IDTipoPDV = 30 AND Chave = 'AutenticarSempre'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Esconder Mesa' WHERE IDTipoPDV = 30 AND Chave = 'EsconderMesa'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Esconder Comanda' WHERE IDTipoPDV = 30 AND Chave = 'EsconderComanda'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Utiliza Balan??a Etiquetadora' WHERE IDTipoPDV = 30 AND Chave = 'etiquetaBalanca'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Quantidade de D??gitos para o C??digo do produto' WHERE IDTipoPDV = 30 AND Chave = 'digitosCodigo'
UPDATE tbConfiguracaoBD SET ValoresAceitos = 'peso:Peso|preco:Pre??o', Titulo = 'O que est?? sendo impresso na etiqueta' WHERE IDTipoPDV = 30 AND Chave = 'precoPeso'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Extender Timeout' WHERE IDTipoPDV = 40 AND Chave = 'wifi'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Sempre solicitar autentica????o' WHERE IDTipoPDV = 40 AND Chave = 'autenticarsempre'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Solicitar Refer??ncia' WHERE IDTipoPDV = 40 AND Chave = 'solicitarref'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Exibir resumo do pedido' WHERE IDTipoPDV = 40 AND Chave = 'mostrarresumo'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Exibir lista de produtos' WHERE IDTipoPDV = 40 AND Chave = 'mostrarlista'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Solicitar info de fechamento' WHERE IDTipoPDV = 40 AND Chave = 'solicitarpessoas'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0:CPF/CNPJ|1:E-mail|2:Telefone', Titulo = 'Chave cliente' WHERE IDTipoPDV = 40 AND Chave = 'tipocliente'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Senha para sair do programa' WHERE IDTipoPDV = 40 AND Chave = 'senha'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Senha para configurar o programa' WHERE IDTipoPDV = 40 AND Chave = 'config'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Solicitar pre??o quando pre??o ?? 0' WHERE IDTipoPDV = 40 AND Chave = 'askprice'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Usar Modo Terminal (Tablet)' WHERE IDTipoPDV = 40 AND Chave = 'terminal'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Usar ??reas de produ????o' WHERE IDTipoPDV = 40 AND Chave = 'usarareas'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = '??rea de produ????o padr??o (ID)' WHERE IDTipoPDV = 40 AND Chave = 'area'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Definir local imp. conta' WHERE IDTipoPDV = 40 AND Chave = 'impressaoconta'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Local de impress??o de conta (ID)' WHERE IDTipoPDV = 40 AND Chave = 'listimpressaoconta'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Extender Timeout' WHERE IDTipoPDV = 60 AND Chave = 'wifi'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Sempre solicitar autentica????o' WHERE IDTipoPDV = 60 AND Chave = 'autenticarsempre'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Solicitar Refer??ncia' WHERE IDTipoPDV = 60 AND Chave = 'solicitarref'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Exibir resumo do pedido' WHERE IDTipoPDV = 60 AND Chave = 'mostrarresumo'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Exibir lista de produtos' WHERE IDTipoPDV = 60 AND Chave = 'mostrarlista'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Solicitar info de fechamento' WHERE IDTipoPDV = 60 AND Chave = 'solicitarpessoas'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0:CPF/CNPJ|1:E-mail|2:Telefone', Titulo = 'Chave cliente' WHERE IDTipoPDV = 60 AND Chave = 'tipocliente'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Senha para sair do programa' WHERE IDTipoPDV = 60 AND Chave = 'senha'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Senha para configurar o programa' WHERE IDTipoPDV = 60 AND Chave = 'config'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Solicitar pre??o quando pre??o ?? 0' WHERE IDTipoPDV = 60 AND Chave = 'askprice'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Usar Modo Terminal (Tablet)' WHERE IDTipoPDV = 60 AND Chave = 'terminal'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Usar ??reas de produ????o' WHERE IDTipoPDV = 60 AND Chave = 'usarareas'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = '??rea de produ????o padr??o (ID)' WHERE IDTipoPDV = 60 AND Chave = 'area'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Definir local imp. conta' WHERE IDTipoPDV = 60 AND Chave = 'impressaoconta'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Local de impress??o de conta (ID)' WHERE IDTipoPDV = 60 AND Chave = 'listimpressaoconta'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Verificar por novas imagens' WHERE IDTipoPDV = 60 AND Chave = 'verifimagens'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Senha para definir mesa' WHERE IDTipoPDV = 60 AND Chave = 'senhamesa'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'ID do Usu??rio do card??pio' WHERE IDTipoPDV = 60 AND Chave = 'usuario'
UPDATE tbConfiguracaoBD SET ValoresAceitos = 'Novo|Antigo', Titulo = 'Tipo Impress??o S@T' WHERE IDTipoPDV = 80 AND Chave = 'TipoImpressaoSat'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Token de Integra????o do TinyERP' WHERE IDTipoPDV = 90 AND Chave = 'token'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0:C??digo do Produto|1:C??digo de Integra????o 1|2:C??digo de Integra????o 2', Titulo = 'C??digo para utilizar na integra????o' WHERE IDTipoPDV = 90 AND Chave = 'codigo'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Ordem Impress??o' WHERE IDTipoPDV = 100 AND Chave = 'OrdemImpressao'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Salvar XML da Pedido' WHERE IDTipoPDV = 100 AND Chave = 'SalvarXMLPedido'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '0|1', Titulo = 'Salvar XML da Requisi????o' WHERE IDTipoPDV = 100 AND Chave = 'SalvarXMLRequisicoes'
UPDATE tbConfiguracaoBD SET ValoresAceitos = 'elgin:Elgin|bematech:Bematech', Titulo = 'Modelo do Cupom S@T' WHERE IDTipoPDV = 80 AND Chave = 'CupomSat'
UPDATE tbConfiguracaoBD SET ValoresAceitos = NULL, Titulo = 'Intervalo (em minutos) de cada sincroniza????o' WHERE IDTipoPDV = 90 AND Chave = 'intervalo'
UPDATE tbConfiguracaoBD SET ValoresAceitos = '10:Mesa|20:Comanda|30:Delivery|40:Balc??o', Titulo = 'Tipo de pedido Padr??o' WHERE IDTipoPDV = 10 AND Chave = 'TipoPedidoPadrao'

update tbConfiguracaoBD set
valor = cf.valor
from tbConfiguracao cf 
where cf.Chave = 'chaveAtivacao'
and tbConfiguracaoBD.Chave = 'chaveAtivacao'

update tbConfiguracaoBD set
valor = cf.valor
from tbConfiguracao cf 
where cf.Chave = 'dtUltimaVerificacao'
and tbConfiguracaoBD.Chave = 'dtUltimaVerificacao'

update tbConfiguracaoBD set
valor = cf.valor
from tbConfiguracao cf 
where cf.Chave = 'dtValidade'
and tbConfiguracaoBD.Chave = 'dtValidade'

COMMIT TRAN A

END TRY
BEGIN CATCH 
  rollback TRAN A
  SELECT ERROR_MESSAGE() as 'ERROR_MESSAGE', ERROR_SEVERITY() as 'ERROR_SEVERITY', ERROR_STATE() as 'ERROR_STATE', ERROR_LINE() as 'ERROR_LINE', ERROR_PROCEDURE() as 'ERROR_PROCEDURE'
END CATCH