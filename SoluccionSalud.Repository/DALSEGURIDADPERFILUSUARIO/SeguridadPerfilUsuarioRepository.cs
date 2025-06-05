using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Model;

namespace SoluccionSalud.Repository.DALSEGURIDADPERFILUSUARIO
{
    public class SeguridadPerfilUsuarioRepository
    {
        public List<SEGURIDADPERFILUSUARIO> listarSeguridadPerfilUsuario(SEGURIDADPERFILUSUARIO objSC)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                //NUMEROLOGINSDISPONIBLE y NUMEROLOGINSUSADOS usados auxiliarmente como inicio y fin.
                return context.USP_SEGURIDADPERFILUSUARIO_LISTAR(objSC.PERFIL, objSC.USUARIO, objSC.ESTADO,
                    objSC.ULTIMOUSUARIO, null, null, objSC.ACCION).ToList();
            }
        }

        public int setMantenimiento(SEGURIDADPERFILUSUARIO objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_SEGURIDADPERFILUSUARIO(
                objSC.PERFIL, objSC.USUARIO, objSC.ESTADO, objSC.ULTIMOUSUARIO,
                  objSC.ULTIMAFECHAMODIF,objSC.ACCION).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
        /**NUEVOS HCE**/
        public List<SG_PerfilUsuario> listarSeguridadPerfilUsuario(SG_PerfilUsuario objSC, int ini,int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {                
                return context.USP_SS_HC_SG_PerfilUsuario_LISTAR(
                    objSC.IdPerfil
                    ,objSC.IdUsuario
                    ,objSC.Estado
                    ,objSC.UsuarioCreacion
                    ,objSC.FechaCreacion
                    ,objSC.UsuarioModificacion
                    ,objSC.FechaModificacion
                    ,ini,final
                    ,objSC.Accion                    
                    ).ToList();
            }
        }

        public int setMantenimiento(SG_PerfilUsuario objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_SS_HC_SG_PerfilUsuario(
                    objSC.IdPerfil
                    , objSC.IdUsuario
                    , objSC.Estado
                    , objSC.UsuarioCreacion
                    , objSC.FechaCreacion
                    , objSC.UsuarioModificacion
                    , objSC.FechaModificacion                    
                    , objSC.Accion                    
                  ).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }

    }



}
