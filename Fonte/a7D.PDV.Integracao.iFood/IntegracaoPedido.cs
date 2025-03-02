﻿using a7D.Fmk.CRUD.DAL;
using a7D.PDV.BLL;
using a7D.PDV.DAL;
using a7D.PDV.EF.Enum;
using a7D.PDV.Fiscal.Services;
using a7D.PDV.Model;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace a7D.PDV.Integracao.iFood
{
    public partial class IntegraIFood
    {
        private void ConfirmarCancelamentoPedido(Model.Order.Event evento)
        {
            PedidoInformation pedido = CarregarPedidoPorOrderId(evento.orderId);
            if (pedido != null && pedido.IDPedido != null)
            {
                AlterarStatusPedido(pedido.IDPedido.Value, EStatusPedido.Cancelado);
            }
            else
            {
                AddLog("  >> Pedido " + evento.orderId + " não encontrado!");
            }
        }

        private void CancelarPedido(Model.Order.Event evento)
        {
            PedidoInformation pedido = CarregarPedidoPorOrderId(evento.orderId);

            if (pedido != null && pedido.IDPedido != null)
            {
                if (pedido.StatusPedido.StatusPedido == EStatusPedido.Aberto)
                {
                    AlterarStatusPedido(pedido.IDPedido.Value, EStatusPedido.EmCancelamento);
                }
                else
                {
                    AlterarStatusPedido(pedido.IDPedido.Value, EStatusPedido.Cancelado);
                }

                TagInformation tagStatus = new TagInformation();
                tagStatus.GUIDIdentificacao = pedido.GUIDIdentificacao;
                tagStatus.Chave = "ifood-status";
                CRUD.Carregar(tagStatus);

                tagStatus.Valor = evento.code;
                CRUD.Alterar(tagStatus);
            }
            else
            {
                AddLog("  >> Pedido " + evento.orderId + " não encontrado!");
            }
        }

        private void FinalizarPedido(Model.Order.Event evento)
        {
            PedidoInformation pedido = CarregarPedidoPorOrderId(evento.orderId);

            if (pedido != null && pedido.IDPedido != null)
            {
                if (ConfigIFood.FinalizacaoAutomatica)
                {
                    AlterarStatusPedido(pedido.IDPedido.Value, EStatusPedido.Finalizado);
                }

                TagInformation tagStatus = new TagInformation();
                tagStatus.GUIDIdentificacao = pedido.GUIDIdentificacao;
                tagStatus.Chave = "ifood-status";
                CRUD.Carregar(tagStatus);

                tagStatus.Valor = "CON";
                CRUD.Alterar(tagStatus);
            }
            else
            {
                AddLog("  >> Pedido " + evento.orderId + " não encontrado!");
            }
        }

        private void AdicionarPedido(Model.Order.Event evento)
        {
            PedidoInformation pedido = new PedidoInformation();
            string voucherDesconto;
            string tipoTaxaAdicional;

            var orderDetails = APIOrder.OrderDetails(evento.orderId);
            AddLog("  >> " + JsonConvert.SerializeObject(orderDetails));

            TagInformation tagVerificacaoDuplicado = Tag.CarregarPorChaveValor("ifood-orderId", orderDetails.id);

            if (tagVerificacaoDuplicado.IDTag != null)
            {
                AddLog("Pedido " + orderDetails.id + "duplicado");
                return;
            }

            pedido.Cliente = AdicionarCliente(orderDetails);
            pedido.Observacoes += "Cliente: " + pedido.Cliente.NomeCompleto + "\r\n\r\n";
            pedido.Observacoes += "Endereço: " + pedido.Cliente.EnderecoCompleto + "\r\n\r\n";

            pedido.DocumentoCliente = orderDetails.customer.documentNumber;

            pedido.TipoPedido = new TipoPedidoInformation();
            pedido.TipoPedido.IDTipoPedido = 30;

            pedido.StatusPedido = new StatusPedidoInformation();
            pedido.StatusPedido.IDStatusPedido = (int)EStatusPedido.NaoConfirmado;

            pedido.OrigemPedido = new OrigemPedidoInformation();
            pedido.OrigemPedido.IDOrigemPedido = (int)EOrigemPedido.ifood;

            pedido.Caixa = CaixaIFood;

            pedido.GUIDMovimentacao = Guid.NewGuid().ToString();
            pedido.GUIDIdentificacao = Guid.NewGuid().ToString();
            pedido.DocumentoCliente = orderDetails.customer.documentNumber;
            pedido.DtPedido = DateTime.Now;
            pedido.PermitirAlterar = false;

            pedido.TaxaEntrega = new TaxaEntregaInformation();
            pedido.TaxaEntrega = TaxaEntregaIFood;
            pedido.ValorEntrega = Convert.ToDecimal(orderDetails.total.deliveryFee);
            pedido.TaxaServicoPadrao = Convert.ToDecimal(ConfiguracoesSistema.Valores.TaxaServicoEntrega);

            if (orderDetails.total.benefits > 0)
            {
                pedido.TipoDesconto = TipoDescontoIFood;

                voucherDesconto = "VOUCHER DE DESCONTO\r\n";
                foreach (var benefit in orderDetails.benefits)
                {
                    foreach (var sponsorship in benefit.sponsorshipValues)
                    {
                        if (sponsorship.value > 0)
                            voucherDesconto += " > " + sponsorship.name + ": R$ " + sponsorship.value.ToString("#,##0.00") + "\r\n";
                    }

                }

                pedido.Observacoes += voucherDesconto + "\r\n";
                pedido.ObservacaoCupom += voucherDesconto + "\r\n";
            }

            pedido.ValorDesconto = orderDetails.total.benefits;

            pedido.ValorServico = orderDetails.total.additionalFees;
            pedido.ValorTotal = orderDetails.total.orderAmount;

            if (orderDetails.orderTiming == "SCHEDULED")
            {
                pedido.Observacoes += "AGENDADO PARA " + orderDetails.schedule.deliveryDateTimeEnd + "\r\n\r\n";
                pedido.ObservacaoCupom += "AGENDADO PARA " + orderDetails.schedule.deliveryDateTimeEnd + "\r\n\r\n";
                AddLog("AGENDADO PARA " + orderDetails.schedule.deliveryDateTimeEnd);
            }

            if (orderDetails.customer.ordersCountOnMerchant == 0)
            {
                pedido.Observacoes += "NOVO CLIENTE " + "\r\n\r\n";
                pedido.ObservacaoCupom += "NOVO CLIENTE " + "\r\n\r\n";
            }
            else
            {
                pedido.Observacoes += "FIDELIDADE " + orderDetails.customer.ordersCountOnMerchant.ToString() + "\r\n\r\n";
                pedido.ObservacaoCupom += "FIDELIDADE " + orderDetails.customer.ordersCountOnMerchant.ToString() + "\r\n\r\n";
            }

            CRUD.Adicionar(pedido);

            Tag.Adicionar(pedido.GUIDIdentificacao, "ifood-orderId", orderDetails.id);
            Tag.Adicionar(pedido.GUIDIdentificacao, "ifood-displayId", orderDetails.displayId);
            Tag.Adicionar(pedido.GUIDIdentificacao, "ifood-orderTiming", orderDetails.orderTiming);
            Tag.Adicionar(pedido.GUIDIdentificacao, "ifood-orderType", orderDetails.orderType);
            Tag.Adicionar(pedido.GUIDIdentificacao, "ifood-status", "PLC");

            if (orderDetails.total.additionalFees > 0)
            {
                pedido.Observacoes += "TAXAS ADICIONAIS\r\n";
                foreach (var fee in orderDetails.additionalFees)
                {
                    tipoTaxaAdicional = CarregarTipoTaxaAdicional(fee.type);
                    AdicionarPedidoProduto(pedido.IDPedido.Value, null, TaxaAdicional.IDProduto.ToString(), tipoTaxaAdicional, fee.value, 1, tipoTaxaAdicional);
                    pedido.Observacoes += " - " + tipoTaxaAdicional + ": R$ " + fee.value.ToString("#,##0.00") + "\r\n";
                }

                pedido.Observacoes += "\r\n";
            }

            pedido.Observacoes += "ITENS\r\n";
            foreach (var item in orderDetails.items)
            {
                Int32 idPedidoProduto = AdicionarPedidoProduto(pedido.IDPedido.Value, null, item.externalCode, item.name, item.unitPrice, item.quantity, item.observations);
                pedido.Observacoes += " - " + item.name + " (qtd " + item.quantity + ")\r\n";

                if (item.options != null)
                {
                    foreach (var modificacoes in item.options)
                    {
                        AdicionarPedidoProduto(pedido.IDPedido.Value, idPedidoProduto, modificacoes.externalCode, modificacoes.name, modificacoes.unitPrice, modificacoes.quantity, "");
                        pedido.Observacoes += "   -- " + modificacoes.name + " (qtd " + modificacoes.quantity + ")\r\n";
                    }
                }
            }

            foreach (var pagamento in orderDetails.payments.methods)
            {
                AdicionarPedidoPagamento(pedido.IDPedido.Value, pagamento);
            }

            CRUD.Salvar(pedido);

            if (ConfigIFood.AprovarIFood == true)
            {
                ConfirmarPedido(evento);
            }
        }

        private string CarregarTipoTaxaAdicional(string feeType)
        {
            string descricao;
            switch (feeType)
            {
                case "SMALL_ORDER_FEE":
                    descricao = "pedido abaixo do valor mínimo";
                    break;
                default:
                    descricao = feeType;
                    break;
            }

            return descricao;
        }

        public void GerarOrdemProducao(Int32 idPedido)
        {
            try
            {
                PedidoInformation pedido = Pedido.CarregarCompleto(idPedido);
                OrdemProducaoServices.GerarOrdemProducao(pedido.ListaProduto, false);
                AddLog("Confirmação automatica e Ordem de Produção gerada!");

                if (ConfiguracoesSistema.Valores.ImprimirViaExpedicao == "NOVO") // IFOOD - Aprovação automatica
                {
                    OrdemProducaoServices.GerarViaExpedicao(pedido.IDPedido.Value, ConfiguracoesSistema.Valores.IDAreaViaExpedicao);
                    AddLog("Via de expedição gerada!");
                }
            }
            catch (Exception ex)
            {
                AddLog("Erro: " + ex.Message);
            }
        }

        private ClienteInformation AdicionarCliente(Model.Order.OrderDetails orderDetails)
        {
            bool novoCliente = false;
            ClienteInformation cliente = CarregarCliente(orderDetails.customer.id);

            if (cliente.IDCliente == null)
            {
                novoCliente = true;
                cliente.GUIDIdentificacao = Guid.NewGuid().ToString();
                cliente.DtInclusao = DateTime.Now;
            }

            cliente.NomeCompleto = orderDetails.customer.name;
            cliente.Telefone1Numero = Convert.ToInt32(orderDetails.customer.phone.localizer);
            cliente.Documento1 = orderDetails.customer.documentNumber;

            if (orderDetails.orderType == "DELIVERY")
            {
                cliente.Endereco = orderDetails.delivery.deliveryAddress.streetName;
                cliente.EnderecoNumero = orderDetails.delivery.deliveryAddress.streetNumber;
                cliente.Complemento = orderDetails.delivery.deliveryAddress.complement;
                cliente.Bairro = orderDetails.delivery.deliveryAddress.neighborhood;
                cliente.Cidade = orderDetails.delivery.deliveryAddress.city;
                cliente.CEP = Convert.ToInt32(orderDetails.delivery.deliveryAddress.postalCode);
                cliente.EnderecoReferencia = orderDetails.delivery.deliveryAddress.reference;
            }
            else if (orderDetails.orderType == "TAKEOUT")
            {
                cliente.Endereco = "RETIRADA";
                cliente.EnderecoNumero = "";
                cliente.Complemento = "";
                cliente.Bairro = "";
                cliente.Cidade = "";
                cliente.CEP = 0;
                cliente.EnderecoReferencia = "";
            }
            else if (orderDetails.orderType == "INDOOR")
            {
                cliente.Endereco = "PEDIDO NA MESA " + orderDetails.indoor.table;
                cliente.EnderecoNumero = "";
                cliente.Complemento = "";
                cliente.Bairro = "";
                cliente.Cidade = "";
                cliente.CEP = 0;
                cliente.EnderecoReferencia = "";
            }
            cliente.Bloqueado = false;

            CRUD.Salvar(cliente);

            if (novoCliente)
            {
                Tag.Adicionar(cliente.GUIDIdentificacao, "ifood-customerId", orderDetails.customer.id);
            }

            return cliente;
        }

        private ClienteInformation CarregarCliente(string customerId)
        {
            ClienteInformation cliente = new ClienteInformation();

            SqlDataAdapter da;
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();

            String querySql = @"
                SELECT 
                    IDCliente
                FROM
                    tbCliente c
                    INNER JOIN tbTag t ON t.GUIDIdentificacao = c.GUIDIdentificacao
                WHERE
                    Chave = 'ifood-customerId' AND
                    Valor = @customerId
            ";

            da = new SqlDataAdapter(querySql, DB.ConnectionString);
            da.SelectCommand.Parameters.AddWithValue("@customerId", customerId);

            da.Fill(ds);
            dt = ds.Tables[0];

            if (dt.Rows.Count > 0)
            {
                cliente.IDCliente = Convert.ToInt32(dt.Rows[0]["IDCliente"]);
                CRUD.Carregar(cliente);
            }

            return cliente;
        }

        private Int32 AdicionarPedidoProduto(Int32 idPedido, Int32? idPedidoProduto_pai, string externalCode, string nome, decimal valorUnitario, decimal quantidade, string notas)
        {
            PedidoProdutoInformation pedidoProduto = new PedidoProdutoInformation();
            Int32 idProduto = 0;
            String observacaoProduto = "";

            CarregarProduto(externalCode, nome, out idProduto, out observacaoProduto);

            pedidoProduto.Produto = new ProdutoInformation();
            pedidoProduto.Produto.IDProduto = idProduto;

            pedidoProduto.Pedido = new PedidoInformation();
            pedidoProduto.Pedido.IDPedido = idPedido;

            if (idPedidoProduto_pai != null)
            {
                pedidoProduto.PedidoProdutoPai = new PedidoProdutoInformation();
                pedidoProduto.PedidoProdutoPai.IDPedidoProduto = idPedidoProduto_pai;
            }

            pedidoProduto.PDV = PDVIFood;
            pedidoProduto.Usuario = UsuarioIfood;

            pedidoProduto.Quantidade = quantidade;
            pedidoProduto.ValorUnitario = valorUnitario;
            pedidoProduto.DtInclusao = DateTime.Now;
            pedidoProduto.CodigoAliquota = "";

            if (!String.IsNullOrWhiteSpace(observacaoProduto))
            {
                pedidoProduto.Notas = observacaoProduto + "\r\n" + notas;
            }
            else
            {
                pedidoProduto.Notas = notas;
            }

            pedidoProduto.Cancelado = false;
            pedidoProduto.RetornarAoEstoque = false;

            CRUD.Adicionar(pedidoProduto);

            return pedidoProduto.IDPedidoProduto.Value;
        }

        private void CarregarProduto(string externalCode, string nome, out Int32 idProduto, out String observacaoProduto)
        {
            if (externalCode == "")
            {
                idProduto = 1;
                observacaoProduto = $"(sem código: {nome})";
                return;
            }

            ProdutoInformation produto = Produto.Carregar(Convert.ToInt32(externalCode));

            if (produto == null || produto.Nome == null)
            {
                idProduto = 1;
                observacaoProduto = $"(não existe: {nome})";
                //log += $"\r\n{idPdod}: {notaProduto}";
            }
            else if (produto.Excluido == true)
            {
                idProduto = 1;
                observacaoProduto = $"(excluido: {nome})";
                //log += $"\r\n{idPdod}: {notaProduto}";
            }
            else if (produto.Ativo == false)
            {
                idProduto = 1;
                observacaoProduto = $"(inativo: {nome})";
                //log += $"\r\n{idPdod}: {notaProduto}";
            }
            else
            {
                idProduto = produto.IDProduto.Value;
                observacaoProduto = "";
            }
        }

        private void AdicionarPedidoPagamento(Int32 idPedido, Model.Order.PaymentMethod paymentMethod)
        {
            PedidoPagamentoInformation pedidoPagamento = new PedidoPagamentoInformation();

            pedidoPagamento.TipoPagamento = CarregarTipoPagamento(paymentMethod.type, paymentMethod.method);

            pedidoPagamento.Pedido = new PedidoInformation();
            pedidoPagamento.Pedido.IDPedido = idPedido;

            pedidoPagamento.Valor = paymentMethod.value;
            pedidoPagamento.DataPagamento = DateTime.Now;
            pedidoPagamento.UsuarioPagamento = UsuarioIfood;
            pedidoPagamento.Excluido = false;

            pedidoPagamento.MeioPagamentoSAT = pedidoPagamento.TipoPagamento.MeioPagamentoSAT;
            pedidoPagamento.IDGateway = (int?)pedidoPagamento.TipoPagamento.Gateway;

            if (paymentMethod.method == "CASH" && paymentMethod.cash.changeFor > 0)
                pedidoPagamento.Valor = paymentMethod.cash.changeFor;

            CRUD.Adicionar(pedidoPagamento);
        }

        private TipoPagamentoInformation CarregarTipoPagamento(string type, string method)
        {
            TipoPagamentoInformation tipoPagamento = new TipoPagamentoInformation();

            if (type == "OFFLINE")
            {
                switch (method)
                {
                    case "DEBIT":
                        tipoPagamento = PagamentoDebito;
                        break;
                    case "CREDIT":
                        tipoPagamento = PagamentoCredito;
                        break;
                    case "CASH":
                        tipoPagamento = PagamentoDinheiro;
                        break;
                    case "MEAL_VOUCHER":
                        tipoPagamento = PagamentoRefeicao;
                        break;
                    default:
                        tipoPagamento = PagamentoOutros;
                        break;
                }
            }
            else
            {
                tipoPagamento = PagamentoIFood;
            }

            return tipoPagamento;
        }

        public void EnviaConfirmacao()
        {
            string ret;
            int qtdConfirmacaoEnviada = 0;

            try
            {
                var pedidos = BLL.Pedido.ListarDelivery6Horas();

                if (pedidos.Count == 0)
                {
                    AddLog("Sem confirmações para serem enviadas!");
                    return;
                }

                foreach (var pedido in pedidos)
                {
                    try
                    {
                        if (pedido.IDOrigemPedido != 2)
                            continue;

                        TagInformation tagOrderId = Tag.Carregar(pedido.GUIDIdentificacao, "ifood-orderId");
                        TagInformation tagDisplayId = Tag.Carregar(pedido.GUIDIdentificacao, "ifood-displayId");
                        TagInformation tagStatus = Tag.Carregar(pedido.GUIDIdentificacao, "ifood-status");
                        TagInformation tagOrderType = Tag.Carregar(pedido.GUIDIdentificacao, "ifood-orderType");

                        if (pedido.IDStatusPedido == (int)EStatusPedido.NaoConfirmado)
                        {
                            continue;
                        }
                        else if (pedido.IDStatusPedido == (int)EStatusPedido.Aberto && tagStatus.Valor != "CFM")
                        {
                            ret = APIOrder.Confirm(tagOrderId.Valor);
                            qtdConfirmacaoEnviada++;

                            if (ret == null)
                            {
                                tagStatus = Tag.Alterar(tagStatus.GUIDIdentificacao, tagStatus.Chave, "CFM");

                                AddLog("  > Pedido " + tagDisplayId.Valor + " (DisplayID) confirmado (CFM)");
                            }
                            else
                            {
                                AddLog("  > Erro confirmando envio " + tagDisplayId.Valor + " (DisplayID) (CFM)!");
                            }
                        }
                        else if (pedido.IDStatusPedido == (int)EStatusPedido.Enviado && tagStatus.Valor != "DSP" && tagOrderType.Valor == "DELIVERY")
                        {
                            ret = APIOrder.Dispatch(tagOrderId.Valor);
                            qtdConfirmacaoEnviada++;

                            if (ret == null)
                            {
                                tagStatus.Valor = "DSP";
                                CRUD.Alterar(tagStatus);
                                AddLog("  > Pedido " + tagDisplayId.Valor + " (DisplayID) despachado (DSP)");
                            }
                            else
                            {
                                AddLog("  > Erro confirmando envio " + tagDisplayId.Valor + " (DisplayID) (DSP)!");
                            }
                        }
                        else if (pedido.IDStatusPedido == (int)EStatusPedido.Enviado && tagStatus.Valor != "RTP" &&
                            (tagOrderType.Valor == "TAKEOUT" || tagOrderType.Valor == "INDOOR"))
                        {
                            ret = APIOrder.ReadyToPickup(tagOrderId.Valor);
                            qtdConfirmacaoEnviada++;

                            if (ret == null)
                            {
                                tagStatus.Valor = "RTP";
                                CRUD.Alterar(tagStatus);
                                AddLog("  > Pedido " + tagDisplayId.Valor + " (DisplayID) pronto para retirada (RTP)");
                            }
                            else
                            {
                                AddLog("  > Erro confirmando pronto para retirada " + tagDisplayId.Valor + " (DisplayID) (RTP)!");
                            }
                        }
                        else if (pedido.IDStatusPedido == (int)EStatusPedido.Cancelado && tagStatus.Valor == "requestCancellation")
                        {
                            TagInformation tagCancellationCode = Tag.Carregar(pedido.GUIDIdentificacao, "ifood-cancellationCode");

                            ret = APIOrder.RequestCancellation(tagOrderId.Valor, tagCancellationCode.Valor);
                            qtdConfirmacaoEnviada++;

                            if (ret == null)
                            {
                                tagStatus.Valor = "CAN";
                                CRUD.Alterar(tagStatus);
                                AddLog("  > Pedido " + tagDisplayId.Valor + " (DisplayID) cancelado (CAN)");
                            }
                            else
                            {
                                AddLog("  > Erro confirmando cancelamento " + tagDisplayId.Valor + " (DisplayID) (CAN)!");
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        AddLog("  > Erro confirmando pedido " + pedido.IDPedido + " (IDPedido): " + ex.Message);
                    }
                }
            }
            catch (Exception ex)
            {
                AddLog("  > Erro verificando pedidos para confirmação " + ex.Message);
            }

            if (qtdConfirmacaoEnviada == 0)
                AddLog("Sem confirmações para serem enviadas!");
        }

        private void AlterarStatusPedido(int idPedido, EStatusPedido statusPedido)
        {
            var query = @"UPDATE tbPedido set IDStatusPedido=@idStatusPedido, IDCaixa=@idCaixa WHERE idPedido=@idPedido";

            using (var conn = new SqlConnection(DB.ConnectionString))
            {
                conn.Open();
                using (var cmd = conn.CreateCommand())
                {
                    cmd.CommandText = query;
                    cmd.Parameters.AddWithValue("@idPedido", idPedido);
                    cmd.Parameters.AddWithValue("@idStatusPedido", (int)statusPedido);
                    cmd.Parameters.AddWithValue("@idCaixa", CaixaIFood.IDCaixa.Value);

                    cmd.ExecuteNonQuery();
                }
            }
        }

        private PedidoInformation CarregarPedidoPorOrderId(string orderId)
        {
            PedidoInformation pedido = new PedidoInformation();

            SqlDataAdapter da;
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();

            String querySql = @"
                SELECT 
                    IDPedido
                FROM
                    tbPedido p
                    INNER JOIN tbTag t ON t.GUIDIdentificacao = p.GUIDIdentificacao
                WHERE
                    Chave = 'ifood-orderId' AND
                    Valor = @orderId
            ";

            da = new SqlDataAdapter(querySql, DB.ConnectionString);
            da.SelectCommand.Parameters.AddWithValue("@orderId", orderId);

            da.Fill(ds);
            dt = ds.Tables[0];

            if (dt.Rows.Count > 0)
            {
                pedido = Pedido.Carregar(Convert.ToInt32(dt.Rows[0]["IDPedido"]));
                return pedido;
            }
            else
            {
                return null;
            }
        }

        private void ConfirmarPedido(Model.Order.Event evento)
        {
            PedidoInformation pedido = CarregarPedidoPorOrderId(evento.orderId);

            if (pedido != null && pedido.IDPedido != null)
            {
                if (pedido.StatusPedido.StatusPedido != EStatusPedido.Aberto)
                {
                    AlterarStatusPedido(pedido.IDPedido.Value, EStatusPedido.Aberto);
                    GerarOrdemProducao(pedido.IDPedido.Value);
                }
                else
                {
                    AddLog("Pedido já estava confirmado");
                }
            }
        }


        public List<MotivoCancelamentoInformation> ListarMotivosCancelamento(string id)
        {
            List<MotivoCancelamentoInformation> list = new List<MotivoCancelamentoInformation>();
            ConfigIFood = new ConfiguracoesIFood();

            Autenticar();
            APIOrder = new API.Order(AccessToken);

            var listaMotivosCancelamento = APIOrder.CancellationReasons(id);

            foreach (var motivoCancelamento in listaMotivosCancelamento)
            {
                list.Add(new MotivoCancelamentoInformation { IDMotivoCancelamento = Convert.ToInt32(motivoCancelamento.cancelCodeId), Nome = motivoCancelamento.description });
            }

            return list;
        }
    }
}