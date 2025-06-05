using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALSEGURIDADPERFILUSUARIO;

namespace SoluccionSalud.Bussines.BLLSEGURIDADPERFILUSUARIO
{
    public class SeguridadPerfilUsuarioBLL
    {
        public List<SEGURIDADPERFILUSUARIO> listarSeguridadPerfilUsuario(SEGURIDADPERFILUSUARIO objSC)
        {
            return new SeguridadPerfilUsuarioRepository().listarSeguridadPerfilUsuario(objSC);
        }

        public int setMantenimiento(SEGURIDADPERFILUSUARIO ObjTrace)
        {
            return new SeguridadPerfilUsuarioRepository().setMantenimiento(ObjTrace);
        }
        /**NUEVOS HCE**/
        public List<SG_PerfilUsuario> listarSeguridadPerfilUsuario(SG_PerfilUsuario objSC,int ini,int fin)
        {
            return new SeguridadPerfilUsuarioRepository().listarSeguridadPerfilUsuario(objSC,ini,fin);
        }

        public int setMantenimiento(SG_PerfilUsuario ObjTrace)
        {
            return new SeguridadPerfilUsuarioRepository().setMantenimiento(ObjTrace);
        }
    }
}
