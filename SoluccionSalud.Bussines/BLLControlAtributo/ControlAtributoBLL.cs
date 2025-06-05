using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALControlAtributo;

namespace SoluccionSalud.Bussines.BLLControlAtributo
{
    public class ControlAtributoBLL
    {
        public List<SS_HC_ControlAtributo> listarControlAtributo(SS_HC_ControlAtributo objSC, int inicio, int final)
        {
            return new ControlAtributoRepository().listarControlAtributo(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_ControlAtributo ObjTrace)
        {
            return new ControlAtributoRepository().setMantenimiento(ObjTrace);
        }
    }
}
