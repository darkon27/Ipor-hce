using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;

namespace SoluccionSalud.Repository.DALOrdAtenPreexistencia
{
    public class OrdAtenPreexistenciaRepository : GenericDataRepository<SS_AD_OrdenAtencionPreexistencia>
    {
        public List<SS_AD_OrdenAtencionPreexistencia> listarOrdAtePreexistencia(SS_AD_OrdenAtencionPreexistencia objSC, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_SS_AD_OrdenAtencionPreexistenciaListar(objSC.Secuencial, objSC.IdOrdenAtencion, 
                    objSC.IdDiagnostico,objSC.CodigoDiagnostico, objSC.NombreDiagnostico, objSC.Observacion,
                    objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion,objSC.UsuarioModificacion, 
                    objSC.FechaModificacion,objSC.accion, inicio, final
                    ).ToList();
            }
        }

        public int setMantenimiento(SS_AD_OrdenAtencionPreexistencia objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_SS_AD_OrdenAtencionPreexistencia(objSC.Secuencial, objSC.IdOrdenAtencion,
                    objSC.IdDiagnostico, objSC.CodigoDiagnostico, objSC.NombreDiagnostico, objSC.Observacion,
                    objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.UsuarioModificacion,
                    objSC.FechaModificacion, objSC.accion).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
