using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALSeguridadGrupo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLSeguridadgrupo
{
    public class SeguridadGruposBLL
    {
        public List<SEGURIDADGRUPO> listarSeguridadGrupo(SEGURIDADGRUPO objSC)
        {
            return new SeguridadGrupoRepository().listarSeguridadGrupo(objSC);
        }

        public int setMantenimiento(SEGURIDADGRUPO ObjTrace)
        {
            return new SeguridadGrupoRepository().setMantenimiento(ObjTrace);
        }
    }
}
