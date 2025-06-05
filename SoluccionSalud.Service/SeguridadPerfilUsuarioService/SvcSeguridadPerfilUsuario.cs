using SoluccionSalud.Bussines.BLLSEGURIDADPERFILUSUARIO;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.SeguridadPerfilUsuarioService
{
    public class SvcSeguridadPerfilUsuario
    {
        public static List<SEGURIDADPERFILUSUARIO> listarSeguridadPerfilUsuario(SEGURIDADPERFILUSUARIO objSC)
        {
            return new SeguridadPerfilUsuarioBLL().listarSeguridadPerfilUsuario(objSC);
        }
        public static int setMantenimiento(SEGURIDADPERFILUSUARIO ObjTrace)
        {
            return new SeguridadPerfilUsuarioBLL().setMantenimiento(ObjTrace);
        }
        public static List<SEGURIDADPERFILUSUARIO> listarSeguridadPerfilUsuarioAccion(SEGURIDADPERFILUSUARIO objSC,String accion)
        {
            if (objSC == null)
            {
                objSC = new SEGURIDADPERFILUSUARIO();
            }
            objSC.ACCION = accion;                
            return new SeguridadPerfilUsuarioBLL().listarSeguridadPerfilUsuario(objSC);
        }

        /**NUEVOS HCE**/
        public static List<SG_PerfilUsuario> listarSeguridadPerfilUsuario(SG_PerfilUsuario objSC, int ini, int final)
        {
            return new SeguridadPerfilUsuarioBLL().listarSeguridadPerfilUsuario(objSC, ini, final);
        }
        public static int setMantenimiento(SG_PerfilUsuario ObjTrace)
        {
            return new SeguridadPerfilUsuarioBLL().setMantenimiento(ObjTrace);
        }
        public static List<SG_PerfilUsuario> listarSeguridadPerfilUsuarioAccion(SG_PerfilUsuario objSC, String accion)
        {
            if (objSC == null)
            {
                objSC = new SG_PerfilUsuario();
            }
            objSC.Accion = accion;
            return new SeguridadPerfilUsuarioBLL().listarSeguridadPerfilUsuario(objSC,0,0);
        }
    }
}
