using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALWH_ClaseLinea
{
    public class WH_ClaseLineaRepository : AuditGenerico<WH_ClaseLinea, WH_ClaseLinea> 
    {
        public List<WH_ClaseLinea> listarWH_ClaseLinea(WH_ClaseLinea objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<WH_ClaseLinea> objLista = new List<WH_ClaseLinea>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista =  context.USP_WH_ClaseLinea_Listado(
                         objSC.Linea
                        , objSC.DescripcionLocal
                        , objSC.DescripcionIngles
                        , objSC.GrupoLinea
                        , objSC.ManejoColorSerieFlag
                        , objSC.Estado
                        , objSC.UltimaFechaModif
                        , objSC.UltimoUsuario                                            
                        , objSC.Accion
                    , inicio, final
                    ).ToList();

                DataKey = new
                {
                    Linea = objSC.Linea
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<WH_ClaseLinea>(), "WH_ClaseLinea");
                objAudit = AddAudita(new WH_ClaseLinea(), new WH_ClaseLinea(), DataKey, "L");
                objAudit.TableName = "WH_ClaseLinea";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
            }
            return objLista;
        }

        public int setMantenimiento(WH_ClaseLinea objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_SS_WH_ClaseLinea(
                         objSC.Linea
                        , objSC.DescripcionLocal
                        , objSC.DescripcionIngles
                        , objSC.GrupoLinea
                        , objSC.ManejoColorSerieFlag
                        , objSC.Estado
                        , objSC.UltimaFechaModif
                        , objSC.UltimoUsuario
                        , objSC.Accion
                     ).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
