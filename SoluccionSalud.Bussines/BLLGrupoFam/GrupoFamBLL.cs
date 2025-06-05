using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALGrupoFam;

namespace SoluccionSalud.Bussines.BLLGrupoFam
{
    public class GrupoFamBLL
    {
        public List<SS_HC_GrupoFamiliar> listarGrupoFam(SS_HC_GrupoFamiliar objSC, int inicio, int final)
        {
            return new GrupoFamRepository().listarGrupoFam(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_GrupoFamiliar ObjTrace)
        {
            return new GrupoFamRepository().setMantenimiento(ObjTrace);
        }
    }
}
