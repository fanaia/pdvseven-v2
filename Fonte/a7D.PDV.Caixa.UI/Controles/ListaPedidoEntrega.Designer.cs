using System.Drawing;
using System.Windows.Forms;

namespace a7D.PDV.Caixa.UI.Controles
{
    partial class ListaPedidoEntrega
    {
        /// <summary> 
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle3 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle4 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle5 = new System.Windows.Forms.DataGridViewCellStyle();
            this.txtPesquisarEntrega = new System.Windows.Forms.TextBox();
            this.dgvEntregas = new System.Windows.Forms.DataGridView();
            this.StatusPedido = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Data = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.NomeCompleto = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Endereco = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Telefone1Numero = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.GUIDIdentificacao = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.IDStatusPedido = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Icone = new System.Windows.Forms.DataGridViewImageColumn();
            this.contextMenuStrip1 = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.toolstripMenuCancelarPedido = new System.Windows.Forms.ToolStripMenuItem();
            this.btnNovoPedidoEntrega = new System.Windows.Forms.Button();
            this.label4 = new System.Windows.Forms.Label();
            this.dataGridViewImageColumn1 = new System.Windows.Forms.DataGridViewImageColumn();
            this.btnNovoPedidoRetirada = new System.Windows.Forms.Button();
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            ((System.ComponentModel.ISupportInitialize)(this.dgvEntregas)).BeginInit();
            this.contextMenuStrip1.SuspendLayout();
            this.tableLayoutPanel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // txtPesquisarEntrega
            // 
            this.txtPesquisarEntrega.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.txtPesquisarEntrega.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            this.txtPesquisarEntrega.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.txtPesquisarEntrega.Font = new System.Drawing.Font("Arial", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
<<<<<<< Updated upstream
            this.txtPesquisarEntrega.Location = new System.Drawing.Point(190, 95);
=======
            this.txtPesquisarEntrega.Location = new System.Drawing.Point(190, 62);
>>>>>>> Stashed changes
            this.txtPesquisarEntrega.Margin = new System.Windows.Forms.Padding(5);
            this.txtPesquisarEntrega.Name = "txtPesquisarEntrega";
            this.txtPesquisarEntrega.Size = new System.Drawing.Size(335, 28);
            this.txtPesquisarEntrega.TabIndex = 74;
            this.txtPesquisarEntrega.TextChanged += new System.EventHandler(this.txtPesquisarEntrega_TextChanged);
            // 
            // dgvEntregas
            // 
            this.dgvEntregas.AllowUserToAddRows = false;
            this.dgvEntregas.AllowUserToDeleteRows = false;
            this.dgvEntregas.AllowUserToResizeRows = false;
            dataGridViewCellStyle1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(235)))), ((int)(((byte)(239)))), ((int)(((byte)(240)))));
            this.dgvEntregas.AlternatingRowsDefaultCellStyle = dataGridViewCellStyle1;
            this.dgvEntregas.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.dgvEntregas.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.dgvEntregas.BackgroundColor = System.Drawing.Color.FromArgb(((int)(((byte)(237)))), ((int)(((byte)(237)))), ((int)(((byte)(237)))));
            this.dgvEntregas.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.dgvEntregas.CellBorderStyle = System.Windows.Forms.DataGridViewCellBorderStyle.None;
            this.dgvEntregas.ClipboardCopyMode = System.Windows.Forms.DataGridViewClipboardCopyMode.Disable;
            this.dgvEntregas.ColumnHeadersBorderStyle = System.Windows.Forms.DataGridViewHeaderBorderStyle.None;
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle2.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(155)))), ((int)(((byte)(193)))), ((int)(((byte)(207)))));
            dataGridViewCellStyle2.Font = new System.Drawing.Font("Arial", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle2.ForeColor = System.Drawing.Color.White;
            dataGridViewCellStyle2.Padding = new System.Windows.Forms.Padding(5);
            dataGridViewCellStyle2.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgvEntregas.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle2;
            this.dgvEntregas.ColumnHeadersHeight = 40;
            this.dgvEntregas.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.StatusPedido,
            this.Data,
            this.NomeCompleto,
            this.Endereco,
            this.Telefone1Numero,
            this.GUIDIdentificacao,
            this.IDStatusPedido,
            this.Icone});
            this.dgvEntregas.ContextMenuStrip = this.contextMenuStrip1;
            dataGridViewCellStyle3.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle3.BackColor = System.Drawing.SystemColors.Window;
            dataGridViewCellStyle3.Font = new System.Drawing.Font("Arial", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle3.ForeColor = System.Drawing.SystemColors.ControlText;
            dataGridViewCellStyle3.Padding = new System.Windows.Forms.Padding(5);
            dataGridViewCellStyle3.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle3.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle3.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
            this.dgvEntregas.DefaultCellStyle = dataGridViewCellStyle3;
            this.dgvEntregas.EditMode = System.Windows.Forms.DataGridViewEditMode.EditProgrammatically;
            this.dgvEntregas.EnableHeadersVisualStyles = false;
            this.dgvEntregas.Location = new System.Drawing.Point(0, 149);
            this.dgvEntregas.Margin = new System.Windows.Forms.Padding(5);
            this.dgvEntregas.Name = "dgvEntregas";
            this.dgvEntregas.ReadOnly = true;
            this.dgvEntregas.RowHeadersBorderStyle = System.Windows.Forms.DataGridViewHeaderBorderStyle.None;
            dataGridViewCellStyle4.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle4.Font = new System.Drawing.Font("Arial", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle4.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle4.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle4.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle4.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgvEntregas.RowHeadersDefaultCellStyle = dataGridViewCellStyle4;
            this.dgvEntregas.RowHeadersVisible = false;
            dataGridViewCellStyle5.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(231)))), ((int)(((byte)(234)))));
            dataGridViewCellStyle5.Padding = new System.Windows.Forms.Padding(5);
            this.dgvEntregas.RowsDefaultCellStyle = dataGridViewCellStyle5;
            this.dgvEntregas.RowTemplate.DividerHeight = 1;
            this.dgvEntregas.RowTemplate.Height = 36;
            this.dgvEntregas.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.dgvEntregas.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvEntregas.Size = new System.Drawing.Size(525, 284);
            this.dgvEntregas.TabIndex = 73;
            this.dgvEntregas.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvEntregas_CellClick);
            this.dgvEntregas.CellContentDoubleClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvEntregas_CellContentDoubleClick);
            this.dgvEntregas.CellDoubleClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvEntregas_CellDoubleClick);
            this.dgvEntregas.CellFormatting += new System.Windows.Forms.DataGridViewCellFormattingEventHandler(this.dgvEntregas_CellFormatting);
            // 
            // StatusPedido
            // 
            this.StatusPedido.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.StatusPedido.DataPropertyName = "StatusPedido";
            this.StatusPedido.HeaderText = "Status";
            this.StatusPedido.Name = "StatusPedido";
            this.StatusPedido.ReadOnly = true;
            this.StatusPedido.Width = 83;
            // 
            // Data
            // 
            this.Data.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.Data.DataPropertyName = "DataPedido";
            this.Data.HeaderText = "Dt Pedido";
            this.Data.Name = "Data";
            this.Data.ReadOnly = true;
            this.Data.Visible = false;
            this.Data.Width = 107;
            // 
            // NomeCompleto
            // 
            this.NomeCompleto.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.NomeCompleto.DataPropertyName = "NomeCompleto";
            this.NomeCompleto.FillWeight = 200F;
            this.NomeCompleto.HeaderText = "Cliente";
            this.NomeCompleto.Name = "NomeCompleto";
            this.NomeCompleto.ReadOnly = true;
            this.NomeCompleto.Width = 86;
            // 
            // Endereco
            // 
            this.Endereco.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Endereco.DataPropertyName = "Endereco";
            this.Endereco.FillWeight = 22.79017F;
            this.Endereco.HeaderText = "Endereço";
            this.Endereco.Name = "Endereco";
            this.Endereco.ReadOnly = true;
            // 
            // Telefone1Numero
            // 
            this.Telefone1Numero.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.Telefone1Numero.FillWeight = 150F;
            this.Telefone1Numero.HeaderText = "Telefone";
            this.Telefone1Numero.Name = "Telefone1Numero";
            this.Telefone1Numero.ReadOnly = true;
            this.Telefone1Numero.Width = 95;
            // 
            // GUIDIdentificacao
            // 
            this.GUIDIdentificacao.DataPropertyName = "GUIDIdentificacao";
            this.GUIDIdentificacao.HeaderText = "GUIDIdentificacao";
            this.GUIDIdentificacao.Name = "GUIDIdentificacao";
            this.GUIDIdentificacao.ReadOnly = true;
            this.GUIDIdentificacao.Visible = false;
            // 
            // IDStatusPedido
            // 
            this.IDStatusPedido.DataPropertyName = "IDStatusPedido";
            this.IDStatusPedido.HeaderText = "IDStatusPedido";
            this.IDStatusPedido.Name = "IDStatusPedido";
            this.IDStatusPedido.ReadOnly = true;
            this.IDStatusPedido.Visible = false;
            // 
            // Icone
            // 
            this.Icone.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.None;
            this.Icone.HeaderText = "";
            this.Icone.Name = "Icone";
            this.Icone.ReadOnly = true;
            this.Icone.Width = 60;
            // 
            // contextMenuStrip1
            // 
            this.contextMenuStrip1.ImageScalingSize = new System.Drawing.Size(20, 20);
            this.contextMenuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolstripMenuCancelarPedido});
            this.contextMenuStrip1.Name = "contextMenuStrip1";
            this.contextMenuStrip1.Size = new System.Drawing.Size(188, 30);
            // 
            // toolstripMenuCancelarPedido
            // 
            this.toolstripMenuCancelarPedido.Font = new System.Drawing.Font("Segoe UI", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.toolstripMenuCancelarPedido.Image = global::a7D.PDV.Caixa.UI.Properties.Resources.btnExcluir1;
            this.toolstripMenuCancelarPedido.Name = "toolstripMenuCancelarPedido";
            this.toolstripMenuCancelarPedido.Size = new System.Drawing.Size(187, 26);
            this.toolstripMenuCancelarPedido.Text = "Cancelar Pedido";
            this.toolstripMenuCancelarPedido.Click += new System.EventHandler(this.toolstripMenuCancelarPedido_Click);
            // 
            // btnNovoPedidoEntrega
            // 
<<<<<<< Updated upstream
            this.btnNovoPedidoEntrega.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
=======
            this.btnNovoPedidoEntrega.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
>>>>>>> Stashed changes
            | System.Windows.Forms.AnchorStyles.Right)));
            this.btnNovoPedidoEntrega.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(140)))), ((int)(((byte)(198)))), ((int)(((byte)(63)))));
            this.btnNovoPedidoEntrega.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnNovoPedidoEntrega.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnNovoPedidoEntrega.ForeColor = System.Drawing.Color.White;
            this.btnNovoPedidoEntrega.Location = new System.Drawing.Point(0, 0);
            this.btnNovoPedidoEntrega.Margin = new System.Windows.Forms.Padding(0);
            this.btnNovoPedidoEntrega.Name = "btnNovoPedidoEntrega";
<<<<<<< Updated upstream
            this.btnNovoPedidoEntrega.Size = new System.Drawing.Size(525, 43);
=======
            this.btnNovoPedidoEntrega.Size = new System.Drawing.Size(262, 57);
>>>>>>> Stashed changes
            this.btnNovoPedidoEntrega.TabIndex = 75;
            this.btnNovoPedidoEntrega.Text = "&NOVO PEDIDO ENTREGA";
            this.btnNovoPedidoEntrega.UseVisualStyleBackColor = false;
            this.btnNovoPedidoEntrega.Click += new System.EventHandler(this.btnNovoPedidoEntrega_Click);
            // 
            // label4
            // 
<<<<<<< Updated upstream
            this.label4.Location = new System.Drawing.Point(0, 95);
=======
            this.label4.Location = new System.Drawing.Point(0, 62);
>>>>>>> Stashed changes
            this.label4.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(181, 28);
            this.label4.TabIndex = 76;
            this.label4.Text = "Cliente/Endereço";
            this.label4.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // dataGridViewImageColumn1
            // 
            this.dataGridViewImageColumn1.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.None;
            this.dataGridViewImageColumn1.FillWeight = 40F;
            this.dataGridViewImageColumn1.HeaderText = "";
            this.dataGridViewImageColumn1.Image = global::a7D.PDV.Caixa.UI.Properties.Resources.btnExcluir1;
            this.dataGridViewImageColumn1.Name = "dataGridViewImageColumn1";
            this.dataGridViewImageColumn1.ReadOnly = true;
            this.dataGridViewImageColumn1.Resizable = System.Windows.Forms.DataGridViewTriState.False;
            this.dataGridViewImageColumn1.Width = 40;
            // 
            // btnNovoPedidoRetirada
            // 
<<<<<<< Updated upstream
            this.btnNovoPedidoRetirada.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
=======
            this.btnNovoPedidoRetirada.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
>>>>>>> Stashed changes
            | System.Windows.Forms.AnchorStyles.Right)));
            this.btnNovoPedidoRetirada.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(140)))), ((int)(((byte)(198)))), ((int)(((byte)(63)))));
            this.btnNovoPedidoRetirada.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnNovoPedidoRetirada.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnNovoPedidoRetirada.ForeColor = System.Drawing.Color.White;
<<<<<<< Updated upstream
            this.btnNovoPedidoRetirada.Location = new System.Drawing.Point(0, 40);
            this.btnNovoPedidoRetirada.Margin = new System.Windows.Forms.Padding(7);
            this.btnNovoPedidoRetirada.Name = "btnNovoPedidoRetirada";
            this.btnNovoPedidoRetirada.Size = new System.Drawing.Size(525, 43);
            this.btnNovoPedidoRetirada.TabIndex = 77;
            this.btnNovoPedidoRetirada.Text = "NOVO PEDIDO &RETIRADA";
=======
            this.btnNovoPedidoRetirada.Location = new System.Drawing.Point(262, 0);
            this.btnNovoPedidoRetirada.Margin = new System.Windows.Forms.Padding(0);
            this.btnNovoPedidoRetirada.Name = "btnNovoPedidoRetirada";
            this.btnNovoPedidoRetirada.Size = new System.Drawing.Size(263, 57);
            this.btnNovoPedidoRetirada.TabIndex = 77;
            this.btnNovoPedidoRetirada.Text = "&NOVO PEDIDO RETIRADA";
>>>>>>> Stashed changes
            this.btnNovoPedidoRetirada.UseVisualStyleBackColor = false;
            this.btnNovoPedidoRetirada.Click += new System.EventHandler(this.btnNovoPedidoRetirada_Click);
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.tableLayoutPanel1.ColumnCount = 2;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel1.Controls.Add(this.btnNovoPedidoRetirada, 1, 0);
            this.tableLayoutPanel1.Controls.Add(this.btnNovoPedidoEntrega, 0, 0);
            this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 3);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 1;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 20F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(525, 57);
            this.tableLayoutPanel1.TabIndex = 78;
            // 
            // ListaPedidoEntrega
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 17F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.Controls.Add(this.tableLayoutPanel1);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.txtPesquisarEntrega);
            this.Controls.Add(this.dgvEntregas);
            this.Font = new System.Drawing.Font("Arial", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Margin = new System.Windows.Forms.Padding(4);
            this.Name = "ListaPedidoEntrega";
            this.Size = new System.Drawing.Size(525, 433);
            ((System.ComponentModel.ISupportInitialize)(this.dgvEntregas)).EndInit();
            this.contextMenuStrip1.ResumeLayout(false);
            this.tableLayoutPanel1.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox txtPesquisarEntrega;
        private System.Windows.Forms.DataGridView dgvEntregas;
        private System.Windows.Forms.Button btnNovoPedidoEntrega;
        private System.Windows.Forms.DataGridViewImageColumn dataGridViewImageColumn1;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.ContextMenuStrip contextMenuStrip1;
        private System.Windows.Forms.ToolStripMenuItem toolstripMenuCancelarPedido;
        private System.Windows.Forms.DataGridViewTextBoxColumn StatusPedido;
        private System.Windows.Forms.DataGridViewTextBoxColumn Data;
        private System.Windows.Forms.DataGridViewTextBoxColumn NomeCompleto;
        private System.Windows.Forms.DataGridViewTextBoxColumn Endereco;
        private System.Windows.Forms.DataGridViewTextBoxColumn Telefone1Numero;
        private System.Windows.Forms.DataGridViewTextBoxColumn GUIDIdentificacao;
        private System.Windows.Forms.DataGridViewTextBoxColumn IDStatusPedido;
        private System.Windows.Forms.DataGridViewImageColumn Icone;
        private System.Windows.Forms.Button btnNovoPedidoRetirada;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
    }
}
