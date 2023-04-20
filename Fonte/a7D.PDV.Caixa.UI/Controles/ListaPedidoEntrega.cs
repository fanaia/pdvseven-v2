﻿using System;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using a7D.PDV.BLL;
using Humanizer;
using System.Globalization;
using a7D.PDV.EF.Enum;
using a7D.PDV.Caixa.UI.Properties;
using a7D.PDV.Componentes;
using a7D.PDV.Model;
using System.ComponentModel;

namespace a7D.PDV.Caixa.UI.Controles
{
    public partial class ListaPedidoEntrega : UserControl
    {
        public delegate void PedidoSelecionadoEventHandler(object sender, System.EventArgs e);
        public event PedidoSelecionadoEventHandler PedidoSelecionado;

        public string GUIDIdentificacao_selecionado;
        DataTable ListaEntregas;
        private static readonly CultureInfo _culture = CultureInfo.GetCultureInfo("pt-BR");
        private readonly static Color darkYellow = Color.FromArgb(255, 232, 232, 192);

        public ListaPedidoEntrega()
        {
            InitializeComponent();
        }

        public void AtualizarLista()
        {
            ListaEntregas = Pedido.ListarDeliveryPendentes();
            ExibirLista();
        }

        private void ExibirLista()
        {
            // Suspender atualização visual do DataGridView
            dgvEntregas.SuspendLayout();

            // Salvar ordenação atual
            DataGridViewColumn colunaOrdenada = dgvEntregas.SortedColumn;
            SortOrder ordemOrdenada = dgvEntregas.SortOrder;

            string chave = txtPesquisarEntrega.Text.ToLower();
            Object[] row;

            var list = from l in ListaEntregas.AsEnumerable()
                       where
                           (
                                l.Field<int>("Telefone1Numero").ToString().Contains(chave) ||
                                l.Field<string>("NomeCompleto").ToLower().Contains(chave) ||
                                l.Field<string>("Endereco").ToLower().Contains(chave)
                           )
                       select new
                       {
                           GUIDIdentificacao = l.Field<string>("GUIDIdentificacao"),
                           IDStatusPedido = l.Field<int>("IDStatusPedido"),
                           StatusPedido = ObterStatus(l.Field<int>("IDStatusPedido"), l.Field<string>("StatusPedido"), l.Field<DateTime>("DtPedido"), l.Field<DateTime?>("DtEnvio")),
                           NomeCompleto = l.Field<string>("NomeCompleto"),
                           Telefone1Numero = l.Field<int>("Telefone1Numero"),
                           DataPedido = l.Field<DateTime>("DtPedido").ToUniversalTime().Humanize(utcDate: true, culture: _culture),
                           Endereco = l.Field<string>("Endereco"),
                           EnderecoNumero = l.Field<string>("EnderecoNumero"),
                           Observacao = l.Field<string>("Observacao"),
                           Bairro = l.Field<string>("Bairro"),
                           Cidade = l.Field<string>("Cidade"),
                           IDOrigemPedido = l.Field<int?>("IDOrigemPedido")
                       };

            // Converter SortOrder em ListSortDirection
            ListSortDirection ordem;
            switch (dgvEntregas.SortOrder)
            {
                case SortOrder.Ascending:
                    ordem = ListSortDirection.Ascending;
                    break;
                case SortOrder.Descending:
                    ordem = ListSortDirection.Descending;
                    break;
                default:
                    ordem = ListSortDirection.Ascending; // Valor padrão
                    break;
            }

            var saveRow = -1;
            if (dgvEntregas.Rows.Count > 0)
                saveRow = dgvEntregas.FirstDisplayedCell.RowIndex;

            dgvEntregas.Rows.Clear();
            foreach (var item in list)
            {
                row = new Object[]
                {
                    item.StatusPedido,
                    item.DataPedido,
                    item.NomeCompleto,
                    ObterEndereco(item.Endereco, item.EnderecoNumero, item.Bairro, item.Cidade, item.Observacao),
                    item.Telefone1Numero,
                    item.GUIDIdentificacao,
                    item.IDStatusPedido,
                    item.IDOrigemPedido
                };

                dgvEntregas.Rows.Add(row);
            }

            AtualizarStatus();
            if (saveRow >= 0)
            {
                try
                {
                    dgvEntregas.FirstDisplayedScrollingRowIndex = saveRow;
                }
                catch (ArgumentOutOfRangeException)
                {

                }
            }

            // Restaurar ordenação
            if (colunaOrdenada != null)
                dgvEntregas.Sort(colunaOrdenada, ordem);
        
            // Retomar atualização visual do DataGridView
                    dgvEntregas.ResumeLayout();
        }

        private static string ObterStatus(int idStatusPedido, string status, DateTime dataPedido, DateTime? dataEnvio)
        {
            string texto = status;
            if (idStatusPedido == (int)EStatusPedido.NaoConfirmado)
                texto = "Não Confirmado a " + dataPedido.ToUniversalTime().Humanize(utcDate: true, culture: _culture);
            else if (idStatusPedido == (int)EStatusPedido.Enviado)
                texto += " " + dataEnvio?.ToUniversalTime().Humanize(utcDate: true, culture: _culture);
            else
                texto += " " + dataPedido.ToUniversalTime().Humanize(utcDate: true, culture: _culture);

            return texto;
        }

        private static string ObterEndereco(string rua, string numero, string bairro, string cidade, string observacao)
        {
            var sb = new StringBuilder();

            sb.Append(rua);
            sb.Append(!string.IsNullOrWhiteSpace(numero) ? $", {numero}" : string.Empty);
            sb.Append(!string.IsNullOrWhiteSpace(bairro) ? $", {bairro}" : string.Empty);
            sb.Append(!string.IsNullOrWhiteSpace(cidade) ? $", {cidade}" : string.Empty);
            sb.Append(!string.IsNullOrWhiteSpace(observacao) ? $", {observacao}" : string.Empty);

            return sb.ToString();
        }

        private void AtualizarStatus()
        {
            //ComandaInformation comanda;
            dgvEntregas.ClearSelection();

            foreach (DataGridViewRow item in dgvEntregas.Rows)
            {
                if (item.Cells["GUIDIdentificacao"].Value.ToString() == GUIDIdentificacao_selecionado)
                    item.Selected = true;

                item.Cells[0].Style.Font = new Font(this.Font, FontStyle.Bold);

                DataGridViewImageCell icone = (DataGridViewImageCell)item.Cells["Icone"];
                icone.Value = Resources.semImagem;
                switch (Convert.ToInt32(item.Cells["IDOrigemPedido"].Value))
                {
                    case (int)EOrigemPedido.ifood:
                        icone.Value = Resources.ifood;
                        break;
                    case (int)EOrigemPedido.deliveryOnline:
                        icone.Value = Resources.ico_pdv7;
                        break;
                }

                if (Convert.ToInt32(item.Cells["IDStatusPedido"].Value) == (int)EStatusPedido.NaoConfirmado)
                {
                    for (var i = 0; i < item.Cells.Count; i++)
                    {
                        item.Cells[i].Style.SelectionForeColor = Color.Black;
                        item.Cells[i].Style.BackColor = Color.LightPink;
                        item.Cells[i].Style.SelectionBackColor = Color.Red;
                    }
                }
                else if (Convert.ToInt32(item.Cells["IDStatusPedido"].Value) == (int)EStatusPedido.Enviado)
                {
                    for (var i = 0; i < item.Cells.Count; i++)
                    {
                        item.Cells[i].Style.SelectionForeColor = Color.Black;
                        item.Cells[i].Style.BackColor = Color.LightYellow;
                        item.Cells[i].Style.SelectionBackColor = darkYellow;
                    }
                }
            }
        }

        private void btnNovoPedidoEntrega_Click(object sender, EventArgs e)
        {
            using (var frm = frmNovoDelivery.NovoPedidoDelivery())
            {
                frm.ShowDialog();
            }

            AtualizarLista();
        }

        private void SelecionarPedido(int linhaSelecionada)
        {
            if (linhaSelecionada >= 0)
            {
                GUIDIdentificacao_selecionado = dgvEntregas.Rows[linhaSelecionada].Cells["GUIDIdentificacao"].Value.ToString();
            }
            else
            {
                GUIDIdentificacao_selecionado = null;
            }

            ExibirLista();
            AtualizarStatus();
        }

        private void AbrirPedido(Int32 linhaSelecionada)
        {
            if (linhaSelecionada >= 0)
            {
                GUIDIdentificacao_selecionado = dgvEntregas.Rows[linhaSelecionada].Cells["GUIDIdentificacao"].Value.ToString();

                PedidoInformation pedido = new PedidoInformation();
                pedido = Pedido.CarregarPorIdentificacao(GUIDIdentificacao_selecionado);

                if (pedido.PermitirAlterar != false)
                {
                    using (var frm = frmNovoDelivery.EditarPedidoDelivery(GUIDIdentificacao_selecionado))
                    {
                        frm.ShowDialog();
                    }
                }
                else
                {
                    MessageBox.Show("Esse pedido de Delivery não pode ser alterado");
                }
            }
            else
            {
                GUIDIdentificacao_selecionado = null;
            }

            ExibirLista();
            AtualizarStatus();
        }

        private void dgvEntregas_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            AbrirPedido(e.RowIndex);
            PedidoSelecionado(sender, e);
        }

        private void dgvEntregas_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            SelecionarPedido(e.RowIndex);
            PedidoSelecionado(sender, e);
        }

        private void txtPesquisarEntrega_TextChanged(object sender, EventArgs e)
        {
            PesquisarPedido(sender, e);
        }

        private void PesquisarPedido(object sender, EventArgs e)
        {
            ExibirLista();

            if (dgvEntregas.Rows.Count == 1)
            {
                GUIDIdentificacao_selecionado = dgvEntregas.Rows[0].Cells["GUIDIdentificacao"].Value.ToString();
                AtualizarStatus();
            }
            else
            {
                GUIDIdentificacao_selecionado = null;
            }

            PedidoSelecionado(sender, e);
        }

        private void dgvEntregas_CellFormatting(object sender, DataGridViewCellFormattingEventArgs e)
        {
            if (e.ColumnIndex == dgvEntregas.Columns["Endereco"].Index)
            {
                var cellEndereco = dgvEntregas.Rows[e.RowIndex].Cells[e.ColumnIndex];
                if (string.IsNullOrWhiteSpace(cellEndereco.Value as string) == false)
                {
                    cellEndereco.ToolTipText = cellEndereco.Value as string;
                }
            }
        }



        private void clickTimer_tick(object sender, EventArgs e)
        {
            if (dgvEntregas.SelectedRows.Count >= 0)
            {
                Cursor = Cursors.WaitCursor;
                Refresh();
                GUIDIdentificacao_selecionado = dgvEntregas.SelectedRows[0].Cells["GUIDIdentificacao"].Value.ToString();
                AtualizarStatus();

                PedidoSelecionado(sender, e);

                Cursor = Cursors.Default;
                Refresh();
            }
        }

        private void toolstripMenuCancelarPedido_Click(object sender, EventArgs e)
        {
            if (dgvEntregas.SelectedRows.Count > 0)
            {
                if (NormalOuTouch.Autenticacao(false, true, false, false, out UsuarioInformation usuario) == DialogResult.OK)
                {
                    using (var form = new frmCancelarPedido(usuario.IDUsuario.Value, GUIDIdentificacao_selecionado))
                    {
                        if (form.ShowDialog() == DialogResult.OK)
                        {
                            GUIDIdentificacao_selecionado = null;
                        }
                    }
                    ExibirLista();
                    AtualizarStatus();

                    PedidoSelecionado(sender, e);
                }
            }
        }

        private void dgvEntregas_SelectionChanged(object sender, EventArgs e)
        {
            //Cursor = Cursors.WaitCursor;
            //Refresh();
            //if (dgvEntregas.SelectedRows.Count >= 0)
            //{
            //    try
            //    {
            //        GUIDIdentificacao_selecionado = dgvEntregas.SelectedRows[0].Cells["GUIDIdentificacao"].Value.ToString();
            //        AtualizarStatus();
            //        PedidoSelecionado(sender, e);
            //    }
            //    catch { }
            //}

            //Cursor = Cursors.Default;
            //Refresh();
        }

        private void btnNovoPedidoRetirada_Click(object sender, EventArgs e)
        {
            using (var frm = frmNovoDelivery.NovoPedidoDelivery())
            {
                frm.ShowDialog();
            }

            AtualizarLista();
        }
    }
}
