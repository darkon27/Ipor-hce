using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALUsuario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLUsuario
{
    public class UsuarioBLL
    {
        public List<USUARIO> listarUsuario(USUARIO objSC)
        {
            return new UsuarioRepository().listarUsuario(objSC);
        }

        public int setMantenimiento(USUARIO ObjTrace)
        {
            return new UsuarioRepository().setMantenimiento(ObjTrace);
        }

    }
}
