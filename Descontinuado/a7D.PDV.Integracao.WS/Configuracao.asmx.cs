﻿using a7D.PDV.BLL;
using a7D.PDV.BLL.Entity;
using a7D.PDV.EF.Enum;
using System;
using System.Web.Services;
using System.Xml.Serialization;

namespace a7D.PDV.Integracao.WS
{
    /// <summary>
    /// Summary description for Configuracao
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class Configuracao : System.Web.Services.WebService
    {
        // Numero das versões OBRIGATÓRIA!!!
        string versaoComanda = "1.13.1";
        string versaoCardapio = "1.8.0";

        [WebMethod]
        [SoapInclude(typeof(ConfiguracoesComandaTerminal))]
        [SoapInclude(typeof(ConfiguracoesCardapio))]
        [XmlInclude(typeof(ConfiguracoesComandaTerminal))]
        [XmlInclude(typeof(ConfiguracoesCardapio))]
        public object ReceberConfiguracoes(string chaveHardware, int idTipoPdv, string versaoAPP)
        {
            try
            {
                if (versaoAPP == null)
                    throw new ExceptionPDV(CodigoErro.C000);
                else if(idTipoPdv==0)
                    throw new ExceptionPDV(CodigoErro.C101);
                else
                {
                    var app = new Version(versaoAPP);
                    if (idTipoPdv == (int)ETipoPDV.CARDAPIO_DIGITAL && app < new Version(versaoCardapio))
                        return "download:release/cardapio-" + versaoCardapio + ".apk";
                    else if (idTipoPdv != (int)ETipoPDV.CARDAPIO_DIGITAL && app < new Version(versaoComanda))
                        return "download:release/comanda-" + versaoComanda + ".apk";
                }

                using (var pdvServico = new Licencas())
                {
                    var idPDV = pdvServico.Carregar((ETipoPDV)idTipoPdv, chaveHardware).IDPDV.Value;
                    switch (idTipoPdv)
                    {
                        case (int)ETipoPDV.TERMINAL_TAB:
                            return new ConfiguracoesComandaTerminal(idPDV, ETipoPDV.TERMINAL_TAB, Util.Versao);
                        case (int)ETipoPDV.COMANDA_ELETRONICA:
                            return new ConfiguracoesComandaTerminal(idPDV, ETipoPDV.COMANDA_ELETRONICA, Util.Versao);
                        case (int)ETipoPDV.CARDAPIO_DIGITAL:
                            return new ConfiguracoesCardapio(idPDV, Util.Versao);
                        default:
                            return null;
                    }
                }
            }
            catch (Exception ex)
            {
                ex.Data.Add("chaveHardware", chaveHardware);
                ex.Data.Add("idTipoPdv", idTipoPdv);
                ex.Data.Add("versaoAPP", versaoAPP);
                BLL.LOG.Erro(ex);
                return $"{ex.Message}\n {ex.InnerException?.Message}";
            }
            finally
            {
                Licencas.Revalidar();
            }
        }
    }
}
