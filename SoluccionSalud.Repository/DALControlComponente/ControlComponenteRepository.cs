using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Repository.DALControlComponente
{
    public class ControlComponenteRepository : GenericDataRepository<SS_HC_ControlComponente>
    {
        public List<SS_HC_ControlComponente> listarControlComponente(SS_HC_ControlComponente objSC, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_SS_HC_ControlComponente_Lista(objSC.IdComponente, objSC.Nombre, objSC.Tipo,
                    objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion,
                    objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Accion, objSC.Version
                    , inicio
                    , final).ToList();
            }
        }
        public int setMantenimiento(SS_HC_ControlComponente objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        iReturnValue = context.USP_SS_HC_ControlComponente(objSC.IdComponente, objSC.Nombre, objSC.Tipo,
                            objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion,
                            objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Accion, objSC.Version).SingleOrDefault();
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
