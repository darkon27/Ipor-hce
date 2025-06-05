using SoluccionSalud.Bussines.BLLSG_Grupo;
using SoluccionSalud.Entidades.Entidades;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.SG_GrupoService
{
    public class SvcSG_Grupo
    {
        public static List<SG_Grupo> listarSG_Grupo(SG_Grupo objSC, int inicio, int final)
        {
            return new SG_GrupoBLL().listarSG_Grupo(objSC, inicio, final);
        }

        public static int setMantenimiento(SG_Grupo ObjTrace)
        {
            return new SG_GrupoBLL().setMantenimiento(ObjTrace);
        }
    }
}
