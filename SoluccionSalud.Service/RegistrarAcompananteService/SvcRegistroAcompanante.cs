using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLRegistrarAcompanante;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.RegistrarAcompananteService
{
    public class SvcRegistroAcompanante
    {
        public static List<SS_HC_RegistroAcompanante> listarRegistroAcompanante(SS_HC_RegistroAcompanante objSC, int inicio, int final)
        {
            return new RegistroAcompananteBLL().listarRegistroAcompanante(objSC, inicio, final);
        }

        public static int setMantenimientoRegistroAcompanante(SS_HC_RegistroAcompanante ObjTrace)
        {
            return new RegistroAcompananteBLL().setMantenimientoRegistroAcompanante(ObjTrace);
        }
    }
}
