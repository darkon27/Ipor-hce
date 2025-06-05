using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALControlComponente;

namespace SoluccionSalud.Bussines.BLLControlComponente
{
   public class ControlComponenteBLL
    {
       public List<SS_HC_ControlComponente> listarControlComponente(SS_HC_ControlComponente objSC, int inicio, int final)
        {
            return new ControlComponenteRepository().listarControlComponente(objSC, inicio, final);
        }

       public int setMantenimiento(SS_HC_ControlComponente ObjTrace)
        {
            return new ControlComponenteRepository().setMantenimiento(ObjTrace);
        }
    }
}
