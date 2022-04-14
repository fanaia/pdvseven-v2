﻿using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Threading.Tasks;

namespace a7D.PDV.Integracao.Pagamento.StoneTEF
{
    public class PinpadStoneTEF : ITEF
    {
        public string Mensagem { get; private set; }
        public string Autorizacao { get; private set; }
        public string Bandeira { get; private set; }
        public string Adquirente { get; private set; }
        public bool Debito { get; private set; }
        public string ViaEstabelecimento { get; private set; }
        public string ViaCliente { get; private set; }
        public decimal Valor { get; private set; }
        public bool HasAlcoholicDrink { get; private set; }
        public Exception Erro { get; private set; }
        public bool PrecisaSelecionar => atkCancelamento == null;
        public string Log => log.ToString();

        private bool abort = false;
        private int ID;
        private string atkCancelamento;
        private StringBuilder log;
        Task process;

        public static string StoneCode { get; set; }
        
        const string LojaPDV = "PDVSeven";

        public bool PagamentoConfirmado
        {
            get
            {
                if (!String.IsNullOrWhiteSpace(Autorizacao))
                    return true;
                else
                    return false;
            }
        }

        public PinpadStoneTEF(int identificador, decimal valor, string autorizacaoCancelamento, bool hasAlcoholicDrink)
        {
            process = null;

            if (String.IsNullOrEmpty(autorizacaoCancelamento))
                log = new StringBuilder("Nova Venda: " + identificador);
            else
                log = new StringBuilder("Cancelamento de transação: " + autorizacaoCancelamento);

            if (string.IsNullOrEmpty(StoneCode))
                throw new Exception("Configure o StoneCode");

            ID = identificador;
            Valor = valor;
            atkCancelamento = autorizacaoCancelamento;
            HasAlcoholicDrink = hasAlcoholicDrink;
        }

        public void DefinirMetodoPagamento(MetodoPagamento metodo, int parcelas)
        {
            Debito = metodo == MetodoPagamento.Debito;
        }

        private void AddLog(string info)
        {
            log.AppendLine($"{DateTime.Now.ToString("HH:mm:ss")} {info}");
        }

        public bool Processando()
        {
            if (process == null)
            {
                process = Task.Factory.StartNew(() =>
                {
                    try
                    {
                        Mensagem = "Iniciando Stone";
                        AddLog("Ativando");

                        if (AuthorizationCore.TryActivate(StoneCode, LojaPDV))
                        {
                            if (atkCancelamento != null)
                            {
                                Mensagem = "Cancelando";
                                AddLog("Cancelando: " + atkCancelamento);
                                if (AuthorizationCore.Cancel(atkCancelamento, Valor, out string result))
                                {
                                    Autorizacao = "OK";
                                    Mensagem = "Cancelado";
                                }
                                else
                                {
                                    Autorizacao = result;
                                    Mensagem = "Erro " + result;
                                }
                                AddLog(Mensagem);
                            }
                            else
                            {
                                Mensagem = "Insira o cartão";
                                AddLog("Autorizando");
                                var result = AuthorizationCore.Authorize(ID, Valor, Debito, null, HasAlcoholicDrink, (s) =>
                                {
                                    if (abort)
                                        throw new Exception("Operação cancelada pelo operador");
                                    if (Mensagem.Length > 20)
                                    {
                                        int i = Mensagem.IndexOf("\r\n");
                                        if (i > 0)
                                            Mensagem = Mensagem.Substring(i + 2);
                                    }
                                    Mensagem += "\r\n" + s;
                                });

                                if (result != null)
                                {
                                    AddLog(result.ToString());
                                    Autorizacao = result.Autorizacao;
                                    Bandeira = result.Bandeira;
                                    Adquirente = result.ContaRecebivel;
                                    ViaCliente = result.ViaCliente;
                                    ViaEstabelecimento = result.ViaEstabelecimento;
                                }
                                else
                                    AuthorizationCore.Reset();
                            }
                        }
                        else
                            Mensagem = "Erro ao inicializar";
                    }
                    catch (Exception ex)
                    {
                        Mensagem = ex.Message;
                        AddLog("ERRO: " + ex.Message);
                        ex.Data.Add("log", log);
                        System.Threading.Thread.Sleep(1500);
                        AuthorizationCore.Reset();
                        throw ex;
                    }
                    finally
                    {
                        try
                        {
                            AddLog("Desligando Pinpad");
                            Task.Delay(1000);
                            AuthorizationCore.ClosePinpad();
                        }
                        catch (Exception)
                        {
                        }
                        AddLog("Fim");
                    }
                });
            }
            return !process.IsCompleted;
        }

        public ITEF IniciaVenda()
        {
            return this;
        }

        public void Cancelar()
        {
            Mensagem = "Cancelando...";
            abort = true;
            try
            {
                if (process != null && !process.IsCompleted)
                    Task.WaitAll(new Task[] { process }, 1000);

                AuthorizationCore.ClosePinpad();
            }
            catch (Exception)
            {
            }
        }

        public void Estornar()
        {
        }

        public async Task AguardaTransacao(StatusUpdateCallBack respostaTEF)
        {
            bool emProcesso;
            do
            {
                emProcesso = Processando();
                respostaTEF?.Invoke(this);
                await Task.Delay(250);
            } while (emProcesso);
        }
    }
}
