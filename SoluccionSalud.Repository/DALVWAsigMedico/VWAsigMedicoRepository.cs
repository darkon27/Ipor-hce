using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;

namespace SoluccionSalud.Repository.DALVWAsigMedico
{
    public class VWAsigMedicoRepository : GenericDataRepository<VW_SS_HC_ASIGNACIONMEDICO>
    {
        public List<VW_SS_HC_ASIGNACIONMEDICO> listarVWAsigMedico(VW_SS_HC_ASIGNACIONMEDICO objSC, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_VW_SS_HC_AsignacionMedicoListar(objSC.unidadreplicacion,objSC.idpaciente, 
                    objSC.idasignacionmedico, objSC.tipoasignacion,objSC.observaciones, objSC.estado, 
                    objSC.usuariocreacion, objSC.fechacreacion,objSC.usuariomodificacion, objSC.fechamodificacion, 
                    objSC.medico1,objSC.nombrecompleto, objSC.servicio, objSC.codigohc, objSC.codigohcanterior, 
                    objSC.CodigoOA,objSC.fecinidiscamec, objSC.fecfindiscamec, objSC.secuencia, 
                    objSC.secuenciaReferida, objSC.accion, inicio, final
                    ).ToList();
            }
        }

        public int setMantenimiento(VW_SS_HC_ASIGNACIONMEDICO objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; 
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_VW_SS_HC_AsignacionMedico(
                    objSC.unidadreplicacion, objSC.idpaciente, objSC.idasignacionmedico, 
                    objSC.tipoasignacion, objSC.observaciones, objSC.estado, objSC.usuariocreacion, 
                    objSC.fechacreacion,objSC.usuariomodificacion, objSC.fechamodificacion, objSC.medico1, 
                    objSC.nombrecompleto, objSC.servicio,objSC.codigohc,objSC.codigohcanterior,objSC.CodigoOA, 
                    objSC.fecinidiscamec, objSC.fecfindiscamec,objSC.secuencia, objSC.secuenciaReferida, objSC.accion).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
