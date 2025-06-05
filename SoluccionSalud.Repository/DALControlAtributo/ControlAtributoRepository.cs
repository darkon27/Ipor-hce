using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Repository.DALControlAtributo
{
    public class ControlAtributoRepository : GenericDataRepository<SS_HC_ControlAtributo>
    {
        public List<SS_HC_ControlAtributo> listarControlAtributo(SS_HC_ControlAtributo objSC, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_SS_HC_ControlAtributo_Lista(objSC.IdAtributo, objSC.Nombre,
                    objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion,
                    objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Accion, objSC.Version
                    , inicio
                    , final).ToList();
            }
        }
        public int setMantenimiento(SS_HC_ControlAtributo objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        iReturnValue = context.USP_SS_HC_ControlAtributo(objSC.IdAtributo, objSC.Nombre,
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
