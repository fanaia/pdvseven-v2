﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using a7D.PDV.Model;
using a7D.PDV.BLL;

namespace a7D.PDV.BackOffice.UI
{
    public partial class frmTipoEntrada : Form
    {
        List<TipoEntradaInformation> Lista;

        public frmTipoEntrada()
        {
            InitializeComponent();
        }

        private void frmTipoEntrada_Load(object sender, EventArgs e)
        {
            GA.Post(this);
            CarregarLista();
            AtualizarGrid();
        }

        private void CarregarLista()
        {
            Lista = TipoEntrada.Listar();
        }

        private void AtualizarGrid()
        {
            if (Lista != null)
            {
                var lista = from l in Lista
                            where l.Nome.ToLower().Contains(txtPesquisa.Text.ToLower())
                            orderby l.Nome
                            select new { l.IDTipoEntrada, l.Nome, l.ValorEntrada, l.ValorConsumacaoMinima, ComandaPadrao = l.Padrao, l.Ativo };

                dgvPrincipal.DataSource = lista.ToArray();
                dgvPrincipal.ClearSelection();
            }
        }

        private void txtPesquisa_TextChanged(object sender, EventArgs e)
        {
            AtualizarGrid();
        }

        private void btnAdicionar_Click(object sender, EventArgs e)
        {
            frmTipoEntradaEditar frm = new frmTipoEntradaEditar();
            frm.ShowDialog();

            CarregarLista();
            AtualizarGrid();
        }

        private void btnAlterar_Click(object sender, EventArgs e)
        {
            Alterar();
        }

        private void btnExcluir_Click(object sender, EventArgs e)
        {
            if (dgvPrincipal.SelectedRows.Count > 0)
            {
                Int32 idTipoEntrada = Convert.ToInt32(dgvPrincipal.SelectedRows[0].Cells["IDTipoEntrada"].Value);
                var tipoEntrada = TipoEntrada.Carregar(idTipoEntrada);
                if (tipoEntrada.Padrao == true)
                {
                    MessageBox.Show("Não é possível excluir o tipo de entrada padrão");
                    return;
                }
                DialogResult r = MessageBox.Show("Tem certeza que deseja excluir esse item?", "ATENÇÃO", MessageBoxButtons.YesNo, MessageBoxIcon.Question);

                if (r == DialogResult.Yes)
                {
                    try
                    {
                        TipoEntrada.Excluir(idTipoEntrada);

                        CarregarLista();
                        AtualizarGrid();
                    }
                    catch (Exception ex)
                    {
                        Logs.ErroBox(CodigoErro.E013, ex);
                    }
                }
            }
            else
            {
                MessageBox.Show("Selecione o item que deseja excluir!", "ATENÇÃO", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void dgvPrincipal_CellContentDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            Alterar();
        }

        private void Alterar()
        {
            if (dgvPrincipal.SelectedRows.Count > 0)
            {
                Int32 idTipoEntrada = Convert.ToInt32(dgvPrincipal.SelectedRows[0].Cells["IDTipoEntrada"].Value);

                frmTipoEntradaEditar frm = new frmTipoEntradaEditar(idTipoEntrada);
                frm.ShowDialog();

                CarregarLista();
                AtualizarGrid();
            }
            else
            {
                MessageBox.Show("Selecione o item que deseja alterar!", "ATENÇÃO", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }


    }
}