using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALControlValidacion;

namespace SoluccionSalud.Bussines.BLLControlValidacion
{
    public class ControlValidacionBLL
    {
        public List<SS_HC_ControlValidacion> listarControlValidacion(SS_HC_ControlValidacion objSC, int inicio, int final)
        {
            return new ControlValidacionRepository().listarControlValidacion(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_ControlValidacion ObjTrace)
        {
            return new ControlValidacionRepository().setMantenimiento(ObjTrace);
        }
    }
}
