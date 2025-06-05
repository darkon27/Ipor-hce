using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using SoluccionSalud.Repository.Repository;
using System.Data.Entity;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryReport;
namespace SoluccionSalud.Repository.DALUnidadMedidaMinsa
{
    public class UnidadMedidaMinsaRepository : AuditGenerico<SS_HC_UnidadMedidaMinsa, SS_HC_UnidadMedidaMinsa> 
    {
        public List<SS_HC_UnidadMedidaMinsa> listarUnidadMedidaMinsa(SS_HC_UnidadMedidaMinsa objSC, int inicio, int final)
        {
            dynamic DataKey = null;
        //    SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_UnidadMedidaMinsa> objLista = new List<SS_HC_UnidadMedidaMinsa>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.SP_SS_HC_UnidadMedidaMinsa_LISTAR(objSC.IdUnidadMedida, objSC.Codigo, objSC.Nombre,
                    objSC.Simbolo, objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion,
                    objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Accion, objSC.Version, inicio, final
                   ).ToList();

               
             
            }

            return objLista;
        }
        public int setMantenimientoUMM(SS_HC_UnidadMedidaMinsa objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.SP_SS_HC_UnidadMedidaMinsa(objSC.IdUnidadMedida, objSC.Codigo, objSC.Nombre,
                    objSC.Simbolo, objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion,
                    objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Accion, objSC.Version).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }


}
