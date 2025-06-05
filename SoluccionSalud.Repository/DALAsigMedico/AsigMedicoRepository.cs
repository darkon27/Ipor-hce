using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;

namespace SoluccionSalud.Repository.DALAsigMedico
{
    public class AsigMedicoRepository : GenericDataRepository<SS_HC_AsignacionMedico>
    {
        public List<SS_HC_AsignacionMedico> listarAsigMedico(SS_HC_AsignacionMedico objSC, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_SS_HC_AsignacionMedicoListar(objSC.UnidadReplicacion, objSC.IdPaciente,
                    objSC.TipoAsignacion, objSC.IdAsignacionMedico, objSC.Secuencia,  objSC.SecuenciaReferida,
                    objSC.Observaciones,objSC.UsuarioCreacion, objSC.FechaCreacion,
                    objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Estado, objSC.accion, inicio, final
                    ).ToList();
            }
        }

        public int setMantenimiento(SS_HC_AsignacionMedico objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        iReturnValue = context.USP_SS_HC_AsignacionMedico(objSC.UnidadReplicacion, objSC.IdPaciente,
                        objSC.TipoAsignacion, objSC.IdAsignacionMedico, objSC.Secuencia, objSC.SecuenciaReferida,
                        objSC.Observaciones, objSC.UsuarioCreacion, objSC.FechaCreacion,
                        objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Estado, objSC.accion).SingleOrDefault();
                                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                        dbContextTransaction.Commit();
                    }
                    catch (Exception ex)
                    {
                        dbContextTransaction.Rollback();
                        throw ex;
                    }
                }
            }
            return valorRetorno;
        }
    }
}
