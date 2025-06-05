using SoluccionSalud.Bussines.BLLTabla;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.TablaService
{
    public class SvcTabla
    {
        public static List<SS_HC_Tabla> listarTabla(SS_HC_Tabla objSC, int inicio, int final)
        {
            return new TablaBLL().listarTabla(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_Tabla ObjTrace)
        {
            return new TablaBLL().setMantenimiento(ObjTrace);
        }
    }
}
