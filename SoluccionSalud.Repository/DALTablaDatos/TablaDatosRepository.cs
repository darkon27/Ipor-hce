using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALTablaDatos
{
    public class TablaDatosRepository : AuditGenerico<CM_CO_TablaMaestro, CM_CO_TablaMaestro> 
    {
        public List<CM_CO_TablaMaestro> listarTablaDatos(CM_CO_TablaMaestro objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<CM_CO_TablaMaestro> objLista = new List<CM_CO_TablaMaestro>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista =  context.USP_CM_HC_CO_TablaMaestroListar(objSC.IdTablaMaestro, objSC.CodigoTabla, objSC.Nombre,
                    objSC.Descripcion, objSC.Version, objSC.Estado, objSC.UsuarioCreacion,
                    objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Accion, inicio, final
                   ).ToList();
                DataKey = new
                {
                    IdTablaMaestro = objSC.IdTablaMaestro
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<CM_CO_TablaMaestro>(), "CM_CO_TablaMaestro");
                objAudit = AddAudita(new CM_CO_TablaMaestro(), new CM_CO_TablaMaestro(), DataKey, "L");
                objAudit.TableName = "CM_CO_TablaMaestro";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
            }
            return objLista;
        }
        public int setMantenimiento(CM_CO_TablaMaestro objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_CM_HC_CO_TablaMaestro(objSC.IdTablaMaestro, objSC.CodigoTabla, objSC.Nombre,
                    objSC.Descripcion, objSC.Version, objSC.Estado, objSC.UsuarioCreacion,objSC.FechaCreacion, 
                    objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Accion).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
