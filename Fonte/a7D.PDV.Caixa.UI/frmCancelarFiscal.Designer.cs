﻿namespace a7D.PDV.Caixa.UI
{
    partial class frmCancelarFiscal
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

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle3 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle4 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle5 = new System.Windows.Forms.DataGridViewCellStyle();
            this.dgvPrincipal = new System.Windows.Forms.DataGridView();
            this.btnCancelarSAT = new System.Windows.Forms.Button();
            this.IDRetornoSAT = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.DtPedidoFechamento = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.DocumentoCliente = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ValorTotal = new System.Windows.Forms.DataGridViewTextBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.dgvPrincipal)).BeginInit();
            this.SuspendLayout();
            // 
            // dgvPrincipal
            // 
            this.dgvPrincipal.AllowUserToAddRows = false;
            this.dgvPrincipal.AllowUserToDeleteRows = false;
            this.dgvPrincipal.AllowUserToResizeColumns = false;
            this.dgvPrincipal.AllowUserToResizeRows = false;
            dataGridViewCellStyle1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(235)))), ((int)(((byte)(239)))), ((int)(((byte)(240)))));
            this.dgvPrincipal.AlternatingRowsDefaultCellStyle = dataGridViewCellStyle1;
            this.dgvPrincipal.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.dgvPrincipal.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.dgvPrincipal.BackgroundColor = System.Drawing.Color.FromArgb(((int)(((byte)(237)))), ((int)(((byte)(237)))), ((int)(((byte)(237)))));
            this.dgvPrincipal.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.dgvPrincipal.CellBorderStyle = System.Windows.Forms.DataGridViewCellBorderStyle.None;
            this.dgvPrincipal.ClipboardCopyMode = System.Windows.Forms.DataGridViewClipboardCopyMode.Disable;
            this.dgvPrincipal.ColumnHeadersBorderStyle = System.Windows.Forms.DataGridViewHeaderBorderStyle.None;
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle2.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(155)))), ((int)(((byte)(193)))), ((int)(((byte)(207)))));
            dataGridViewCellStyle2.Font = new System.Drawing.Font("Arial", 11F);
            dataGridViewCellStyle2.ForeColor = System.Drawing.Color.White;
            dataGridViewCellStyle2.Padding = new System.Windows.Forms.Padding(5);
            dataGridViewCellStyle2.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgvPrincipal.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle2;
            this.dgvPrincipal.ColumnHeadersHeight = 40;
            this.dgvPrincipal.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.IDRetornoSAT,
            this.DtPedidoFechamento,
            this.DocumentoCliente,
            this.ValorTotal});
            dataGridViewCellStyle3.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle3.BackColor = System.Drawing.SystemColors.Window;
            dataGridViewCellStyle3.Font = new System.Drawing.Font("Arial", 11F);
            dataGridViewCellStyle3.ForeColor = System.Drawing.SystemColors.ControlText;
            dataGridViewCellStyle3.Padding = new System.Windows.Forms.Padding(5);
            dataGridViewCellStyle3.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle3.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle3.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
            this.dgvPrincipal.DefaultCellStyle = dataGridViewCellStyle3;
            this.dgvPrincipal.EnableHeadersVisualStyles = false;
            this.dgvPrincipal.Location = new System.Drawing.Point(12, 84);
            this.dgvPrincipal.Name = "dgvPrincipal";
            this.dgvPrincipal.RowHeadersBorderStyle = System.Windows.Forms.DataGridViewHeaderBorderStyle.None;
            dataGridViewCellStyle4.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle4.Font = new System.Drawing.Font("Arial", 11F);
            dataGridViewCellStyle4.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle4.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle4.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle4.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgvPrincipal.RowHeadersDefaultCellStyle = dataGridViewCellStyle4;
            this.dgvPrincipal.RowHeadersVisible = false;
            dataGridViewCellStyle5.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(231)))), ((int)(((byte)(234)))));
            dataGridViewCellStyle5.Padding = new System.Windows.Forms.Padding(5);
            this.dgvPrincipal.RowsDefaultCellStyle = dataGridViewCellStyle5;
            this.dgvPrincipal.RowTemplate.DividerHeight = 1;
            this.dgvPrincipal.RowTemplate.Height = 36;
            this.dgvPrincipal.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.dgvPrincipal.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvPrincipal.Size = new System.Drawing.Size(1000, 448);
            this.dgvPrincipal.TabIndex = 1;
            // 
            // btnCancelarSAT
            // 
            this.btnCancelarSAT.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.btnCancelarSAT.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(140)))), ((int)(((byte)(198)))), ((int)(((byte)(63)))));
            this.btnCancelarSAT.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.btnCancelarSAT.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnCancelarSAT.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnCancelarSAT.ForeColor = System.Drawing.Color.White;
            this.btnCancelarSAT.Location = new System.Drawing.Point(12, 539);
            this.btnCancelarSAT.Margin = new System.Windows.Forms.Padding(4);
            this.btnCancelarSAT.Name = "btnCancelarSAT";
            this.btnCancelarSAT.Size = new System.Drawing.Size(1000, 59);
            this.btnCancelarSAT.TabIndex = 2;
            this.btnCancelarSAT.Text = "CANCELAR";
            this.btnCancelarSAT.UseVisualStyleBackColor = false;
            this.btnCancelarSAT.Click += new System.EventHandler(this.btnCancelarSat_Click);
            // 
            // IDRetornoSAT
            // 
            this.IDRetornoSAT.DataPropertyName = "IDRetornoSAT";
            this.IDRetornoSAT.HeaderText = "IDRetornoSAT";
            this.IDRetornoSAT.Name = "IDRetornoSAT";
            this.IDRetornoSAT.ReadOnly = true;
            this.IDRetornoSAT.Visible = false;
            // 
            // DtPedidoFechamento
            // 
            this.DtPedidoFechamento.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.DtPedidoFechamento.DataPropertyName = "DtPedidoFechamento";
            this.DtPedidoFechamento.HeaderText = "Data Pedido";
            this.DtPedidoFechamento.Name = "DtPedidoFechamento";
            this.DtPedidoFechamento.ReadOnly = true;
            this.DtPedidoFechamento.Width = 121;
            // 
            // DocumentoCliente
            // 
            this.DocumentoCliente.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.DocumentoCliente.DataPropertyName = "DocumentoCliente";
            this.DocumentoCliente.HeaderText = "CPF/CNPJ";
            this.DocumentoCliente.Name = "DocumentoCliente";
            this.DocumentoCliente.ReadOnly = true;
            // 
            // ValorTotal
            // 
            this.ValorTotal.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.ValorTotal.DataPropertyName = "ValorTotal";
            this.ValorTotal.HeaderText = "Valor (R$)";
            this.ValorTotal.Name = "ValorTotal";
            this.ValorTotal.ReadOnly = true;
            this.ValorTotal.Width = 106;
            // 
            // frmCancelarFiscal
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 17F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.ClientSize = new System.Drawing.Size(1024, 611);
            this.Controls.Add(this.btnCancelarSAT);
            this.Controls.Add(this.dgvPrincipal);
            this.Font = new System.Drawing.Font("Arial", 11F);
            this.Margin = new System.Windows.Forms.Padding(4);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "frmCancelarFiscal";
            this.Text = "CANCELAR CUPOM";
            this.Load += new System.EventHandler(this.frmCancelarSAT_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvPrincipal)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.DataGridView dgvPrincipal;
        private System.Windows.Forms.Button btnCancelarSAT;
        private System.Windows.Forms.DataGridViewTextBoxColumn IDRetornoSAT;
        private System.Windows.Forms.DataGridViewTextBoxColumn DtPedidoFechamento;
        private System.Windows.Forms.DataGridViewTextBoxColumn DocumentoCliente;
        private System.Windows.Forms.DataGridViewTextBoxColumn ValorTotal;
    }
}