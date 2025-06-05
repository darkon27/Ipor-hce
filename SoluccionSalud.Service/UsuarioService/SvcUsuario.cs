using SoluccionSalud.Bussines.BLLUsuario;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.UsuarioService
{
    public class SvcUsuario
    {
        public static List<USUARIO> listarUsuario(USUARIO objSC)
        {
            return new UsuarioBLL().listarUsuario(objSC);
        }
        public static int setMantenimiento(USUARIO ObjTrace)
        {
            return new UsuarioBLL().setMantenimiento(ObjTrace);
        }

        public static List<USUARIO> listarUsuarioAccion(USUARIO objSC, String accion)
        {
            if (objSC == null)
            {
                objSC = new USUARIO();
            }
            objSC.ACCION = accion;
            return new UsuarioBLL().listarUsuario(objSC);
        }
    }
}
