using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLControlAtributo;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.ControlAtributoService
{
    public class SvcControlAtributo
    {
        public static List<SS_HC_ControlAtributo> listarControlAtributo(SS_HC_ControlAtributo objSC, int inicio, int final)
        {
            return new ControlAtributoBLL().listarControlAtributo(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_ControlAtributo ObjTrace)
        {
            return new ControlAtributoBLL().setMantenimiento(ObjTrace);
        }
    }
}
