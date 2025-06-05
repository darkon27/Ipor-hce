using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLGrupoFam;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.GrupoFamService
{
    public class SvcGrupoFam
    {
        public static List<SS_HC_GrupoFamiliar> listarGrupoFam(SS_HC_GrupoFamiliar objSC, int inicio, int final)
        {
            return new GrupoFamBLL().listarGrupoFam(objSC, inicio, final);
        }
        public static int setMantenimiento(SS_HC_GrupoFamiliar ObjTrace)
        {
            return new GrupoFamBLL().setMantenimiento(ObjTrace);
        }
    }
}
