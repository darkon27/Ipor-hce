using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALWH_ClaseSubFamilia
{
    public class WH_ClaseSubFamiliaRepository : AuditGenerico<WH_ClaseSubFamilia, WH_ClaseSubFamilia> 
    {
    public List<WH_ClaseSubFamilia> listarWH_ClaseSubFamilia(WH_ClaseSubFamilia objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<WH_ClaseSubFamilia> objLista = new List<WH_ClaseSubFamilia>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_SS_WH_ClaseSubFamiliaListar(
                        objSC.Linea
                        , objSC.Familia
                        , objSC.SubFamilia
                        , objSC.DescripcionLocal
                        , objSC.DescripcionIngles
                        , objSC.DescripcionCompleta
                        , objSC.ItemTipo
                        , objSC.TransaccionOperacion
                        , objSC.Estado
                        , objSC.UltimaFechaModif
                        , objSC.UltimoUsuario
                        , objSC.Accion  
                    , inicio, final                   
                    ).ToList();


                DataKey = new
                {
                    Linea = objSC.Linea,
                    Familia = objSC.Familia,
                    SubFamilia = objSC.SubFamilia
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<WH_ClaseSubFamilia>(), "WH_ClaseSubFamilia");
                objAudit = AddAudita(new WH_ClaseSubFamilia(), new WH_ClaseSubFamilia(), DataKey, "L");
                objAudit.TableName = "WH_ClaseSubFamilia";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
            }
            return objLista;
        }

    public int setMantenimiento(WH_ClaseSubFamilia objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_SS_WH_ClaseSubFamilia(
                         objSC.Linea
                        , objSC.Familia
                        , objSC.SubFamilia
                        , objSC.DescripcionLocal
                        , objSC.DescripcionIngles
                        , objSC.DescripcionCompleta
                        , objSC.ItemTipo
                        , objSC.TransaccionOperacion
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
