using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALSG_Grupo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLSG_Grupo
{
    public class SG_GrupoBLL
    {
        public List<SG_Grupo> listarSG_Grupo(SG_Grupo objSC, int inicio, int final)
        {
            return new SG_GrupoRepository().listarSG_Grupo(objSC, inicio, final);
        }

        public int setMantenimiento(SG_Grupo ObjTrace)
        {
            return new SG_GrupoRepository().setMantenimiento(ObjTrace);
        }
    }
}
