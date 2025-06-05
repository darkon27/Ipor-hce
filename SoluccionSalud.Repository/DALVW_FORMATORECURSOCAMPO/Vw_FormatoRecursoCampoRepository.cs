using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Model;
using System.Data.Entity;


namespace SoluccionSalud.Repository.DALVW_FORMATORECURSOCAMPO
{
    public class Vw_FormatoRecursoCampoRepository : AuditGenerico<VW_FORMATORECURSOCAMPO, VW_FORMATORECURSOCAMPO> 
    {
        public List<VW_FORMATORECURSOCAMPO> listarVW_FORMATORECURSOCAMPO(VW_FORMATORECURSOCAMPO objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<VW_FORMATORECURSOCAMPO> objLista = new List<VW_FORMATORECURSOCAMPO>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_VW_SS_HC_FORMATORECURSOCAMPO_LISTAR(
                    objSC.IdFormato,
                    objSC.CodigoFormato,
                    objSC.DescripcionFormato,
                    objSC.SecuenciaCampo,
                    objSC.DescripFormatoCampo,
                    objSC.Formula,
                    objSC.IdFavoritoTabla,
                    objSC.DescripcionTabla,
                    objSC.DescripTablaCampo,
                    objSC.Estado,
                     objSC.Accion, inicio, final
                    ).ToList();

                DataKey = new
                {
                    IdFormato = objSC.IdFormato,
                    SecuenciaCampo = objSC.SecuenciaCampo
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<VW_FORMATORECURSOCAMPO>(), "VW_FORMATORECURSOCAMPO");
                objAudit = AddAudita(new VW_FORMATORECURSOCAMPO(), new VW_FORMATORECURSOCAMPO(), DataKey, "L");
                objAudit.TableName = "VW_FORMATORECURSOCAMPO";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();

            }

            return objLista;
        }

        public int setMantenimiento(VW_FORMATORECURSOCAMPO objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_VW_SS_HC_FORMATORECURSOCAMPO_Mantenimiento(

                    objSC.IdFormato,
                    objSC.CodigoFormato,
                    objSC.DescripcionFormato,
                    objSC.SecuenciaCampo,
                    objSC.DescripFormatoCampo,
                    objSC.Formula,
                    objSC.IdFavoritoTabla,
                    objSC.DescripcionTabla,
                    objSC.DescripTablaCampo,
                    objSC.Estado,
                     objSC.Accion

                     ).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
