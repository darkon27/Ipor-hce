using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Model;


namespace SoluccionSalud.Repository.DALUsuario
{
    public class UsuarioRepository : GenericDataRepository<USUARIO>, IUsuarioRepository
    {
        public List<USUARIO> listarUsuario(USUARIO objSC)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                //NUMEROLOGINSDISPONIBLE y NUMEROLOGINSUSADOS usados auxiliarmente como inicio y fin.
                return context.USP_USUARIOS_LISTAR(objSC.USUARIO1, objSC.CLAVE, objSC.USUARIOPERFIL, objSC.PERSONA,
                  objSC.NOMBRE, objSC.ESTADO, objSC.NUMEROLOGINSDISPONIBLE, objSC.NUMEROLOGINSUSADOS, objSC.ACCION ).ToList();
            }
        }

       public int setMantenimiento(USUARIO objSC)
       {
           System.Nullable<int> iReturnValue;
           int valorRetorno = 0; //ERROR
           using (var context = new WEB_ERPSALUDEntities())
           {               
               iReturnValue = context.USP_USUARIO(
               objSC.USUARIO1,objSC.USUARIOPERFIL, objSC.PERSONA, objSC.TIPOPERSONA, 
                objSC.NOMBRE,  objSC.CLAVE,  objSC.EXPIRARPASSWORDFLAG,  objSC.FECHAEXPIRACION, 
                 objSC.ULTIMOLOGIN,  objSC.NUMEROLOGINSDISPONIBLE,  objSC.NUMEROLOGINSUSADOS,  objSC.USUARIORED, 
                  objSC.SQLLOGIN,  objSC.SQLPASSWORD, objSC.ESTADO,  objSC.ULTIMOUSUARIO,  objSC.ULTIMAFECHAMODIF,
                   objSC.ACCION).SingleOrDefault();
               valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
           }
           return valorRetorno;
       }

    }
}
