using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;
using Newtonsoft.Json;

namespace SoluccionSalud.Repository.DALCAMPOFORMATO
{
    public class CampoFormatoRepository : AuditGenerico<VW_FORMATOCAMPO, VW_FORMATOCAMPO>
    {
        public List<VW_FORMATOCAMPO> listarVWFormatoCampo(VW_FORMATOCAMPO objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<VW_FORMATOCAMPO> objLista = new List<VW_FORMATOCAMPO>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_VW_FORMATOCAMPO_LISTA(
                     objSC.IdFormato,
                     objSC.CodigoFormato,
                     objSC.DescripcionFormato,
                     objSC.SecuenciaCampo,
                     objSC.DescripFormatoCampo,
                     objSC.Formula,
                     objSC.Modulo,
                     objSC.IndicadorObligatorio,
                     objSC.Estado,
                     objSC.Accion, 
                     objSC.Version, inicio, final).ToList();

                DataKey = new
                {
                    IdFormato = objSC.IdFormato,
                    SecuenciaCampo = objSC.SecuenciaCampo
                };
                // Audit
              //  String xlmIn = XMLString(objLista, new List<VW_FORMATOCAMPO>(), "VW_FORMATOCAMPO");
                String xlmIn = JsonConvert.SerializeObject(objLista);  // 2018/01/09 ---Jordan Mateo
                objAudit = AddAudita(new VW_FORMATOCAMPO(), objSC, DataKey, "L");
                objAudit.TableName = "VW_FORMATOCAMPO";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
            }
            return objLista;
        }
        public int setMantenimiento(VW_FORMATOCAMPO objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_VW_FORMATOCAMPO(objSC.IdFormato,
                     objSC.CodigoFormato,
                     objSC.DescripcionFormato,
                     objSC.SecuenciaCampo,
                     objSC.DescripFormatoCampo,
                     objSC.Formula,
                     objSC.Modulo,
                     objSC.IndicadorObligatorio,
                     objSC.Estado,
                     objSC.Accion,
                     objSC.Version).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
