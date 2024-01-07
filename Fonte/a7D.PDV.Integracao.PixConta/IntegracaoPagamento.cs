﻿using a7D.Fmk.CRUD.DAL;
using a7D.PDV.BLL;
using a7D.PDV.DAL;
using a7D.PDV.EF.Enum;
using a7D.PDV.Integracao.PixConta.Model;
using a7D.PDV.Model;
using System;
using System.Data;
using System.Data.SqlClient;

namespace a7D.PDV.Integracao.PixConta
{
    public partial class IntegraPixConta
    {
        private void VerificarPagamentosPendentes()
        {
            var pedidos = ListarPedidosFaturaPendente();

            foreach (var pedido in pedidos)
            {
                Int32 idPedido = Convert.ToInt32(((DataRow)pedido)["IDPedido"]);
                string guidMovimentacao = ((DataRow)pedido)["guidMovimentacao"].ToString();
                string fatura = ((DataRow)pedido)["fatura"].ToString();

                Model.InvoiceInformation invoice = APIInvoice.ConsultarStatus(fatura);
                decimal valorDecimal = (decimal)invoice.total_cents / 100;

                switch (invoice.status)
                {
                    case "paid":
                    case "paid_external":
                        RegistrarPagamento(idPedido, valorDecimal);
                        Tag.Alterar(guidMovimentacao, "FaturaPixConta_ContaCliente_Status", "pago");

                        if (Pedido.TotalPago(idPedido))
                            FecharPedido(idPedido);
                        break;
                    case "pending":
                        VerificarValidadeFatura(idPedido, guidMovimentacao, valorDecimal);
                        break;
                }
            }
        }

        private void VerificarValidadeFatura(int idPedido, string guidMovimentacao, decimal valorFatura)
        {
            //Se valor pendente do pedido diferente do valor da fatura
            if(Pedido.ValorPendente(idPedido) != valorFatura)
            {
                //Chama API cancelando a fatura


                Int32 idTag_fatura = Tag.Carregar(guidMovimentacao, "FaturaPixConta_ContaCliente_ID").IDTag.Value;
                Int32 idTag_status = Tag.Carregar(guidMovimentacao, "FaturaPixConta_ContaCliente_Status").IDTag.Value;
                Tag.Excluir(idTag_fatura);
                Tag.Excluir(idTag_status);
            }
        }

        private void RegistrarPagamento(int idPedido, decimal valor)
        {
            PedidoPagamentoInformation pedidoPagamento = new PedidoPagamentoInformation();

            pedidoPagamento.TipoPagamento = new TipoPagamentoInformation();
            pedidoPagamento.TipoPagamento.IDTipoPagamento = 6;

            pedidoPagamento.Pedido = new PedidoInformation();
            pedidoPagamento.Pedido.IDPedido = idPedido;

            pedidoPagamento.UsuarioPagamento = new UsuarioInformation();
            pedidoPagamento.UsuarioPagamento.IDUsuario = 1;

            pedidoPagamento.Valor = valor;
            pedidoPagamento.DataPagamento = DateTime.Now;

            pedidoPagamento.Excluido = false;

            pedidoPagamento.MeioPagamentoSAT = new MeioPagamentoSATInformation();
            pedidoPagamento.MeioPagamentoSAT.IDMeioPagamentoSAT = 1;

            pedidoPagamento.IDGateway = 5;

            CRUD.Adicionar(pedidoPagamento);
        }

        private void FecharPedido(int idPedido)
        {
            PedidoInformation pedido = Pedido.CarregarCompleto(idPedido);
            CaixaInformation caixa = new CaixaInformation();
            caixa.IDCaixa = 1;

            Int32 idUsuario = 1;

            Pedido.FecharVendaDB(pedido, caixa, idUsuario);
            switch (pedido.TipoPedido.TipoPedido)
            {
                case ETipoPedido.Mesa:
                    var mesa = Mesa.CarregarPorGUID(pedido.GUIDIdentificacao);
                    Mesa.AlterarStatus(pedido.GUIDIdentificacao, EStatusMesa.Liberada);
                    break;
                case ETipoPedido.Comanda:
                    var comanda = Comanda.CarregarPorGUID(pedido.GUIDIdentificacao);
                    Comanda.AlterarStatus(pedido.GUIDIdentificacao, EStatusComanda.Liberada);
                    break;
            }
        }

        private DataRowCollection ListarPedidosFaturaPendente()
        {
            SqlDataAdapter da;
            DataSet ds = new DataSet();

            String querySql = @"
            SELECT
                p.IDPedido,
            	p.GUIDMovimentacao,
	            status.Valor as status,
	            (SELECT Valor FROM tbTag fatura WHERE fatura.GUIDIdentificacao = p.GUIDMovimentacao AND fatura.Chave = 'FaturaPixConta_ContaCliente_ID') as fatura
            FROM
                tbPedido p
                LEFT JOIN tbTag status ON status.GUIDIdentificacao = p.GUIDMovimentacao AND status.Chave = 'FaturaPixConta_ContaCliente_Status'
            WHERE

                status.Valor = 'pendente'
            ";

            da = new SqlDataAdapter(querySql, DB.ConnectionString);
            da.Fill(ds);

            return ds.Tables[0].Rows;
        }
    }
}