using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.ModelPAE;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Entidades.Entidades;


namespace SoluccionSalud.Repository.DAL_PSpring
{
    public class ProcedimientoSpringRepository : AuditGenerico<SS_HC_ProcedimientoInformeSPRING, SS_HC_ProcedimientoInformeSPRING> 
    {

        public List<SS_HC_ProcedimientoInformeSPRING> ListarProcedimientoInformeSPRING(SS_HC_ProcedimientoInformeSPRING objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_ProcedimientoInformeSPRING> objLista = new List<SS_HC_ProcedimientoInformeSPRING>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.SP_SS_HC_ProcedimientoInformeSPRING_LISTAR(
                    objSC.IdProcedimiento,
                    objSC.NombreArchivo,
                    objSC.RutaInforme,
                    objSC.IdPaciente,
                    objSC.Paciente,
                    objSC.CodigoOA,
                    objSC.CodigoComponente,
                    objSC.DescripcionComponente,
                    objSC.IdOrdenAtencion,
                    objSC.LineaOA,
                    objSC.TipoOrdenAtencion,
                    objSC.Medico,
                    objSC.Observacion,
                    objSC.FechaProcedimiento,
                    objSC.FechaCreacion,
                    objSC.UsuarioCreacion,
                    objSC.FechaModificacion,
                    objSC.UsuarioModificacion,
                    objSC.Contador_filas
                    ,inicio
                    ,final,
                    objSC.Accion     
                    
                   
                ).ToList();

                
            }
            return objLista;
        }
    }
}
