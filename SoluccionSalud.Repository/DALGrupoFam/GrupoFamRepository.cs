using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Model;

namespace SoluccionSalud.Repository.DALGrupoFam
{
    public class GrupoFamRepository
    {
        public List<SS_HC_GrupoFamiliar> listarGrupoFam(SS_HC_GrupoFamiliar objSC, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_SS_HC_GrupoFamiliarListar(objSC.IdPaciente, objSC.IdPacienteFamiliar, objSC.TipoFamiliar
                    , objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion
                    , objSC.Accion, inicio, final).ToList();
            }
        }
        public int setMantenimiento(SS_HC_GrupoFamiliar objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; 
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_SS_HC_GrupoFamiliar(objSC.IdPaciente, objSC.IdPacienteFamiliar, objSC.TipoFamiliar
                    , objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion
                    , objSC.Accion).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
