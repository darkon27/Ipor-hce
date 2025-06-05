using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLTablaDatos;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.TablaDatosService
{
    public class SvcTablaDatos
    {
        public static List<CM_CO_TablaMaestro> listarTablaDatos(CM_CO_TablaMaestro objSC, int inicio, int final)
        {
            return new TablaDatosBLL().listarTablaDatos(objSC, inicio, final);
        }

        public static int setMantenimiento(CM_CO_TablaMaestro ObjTrace)
        {
            return new TablaDatosBLL().setMantenimiento(ObjTrace);
        }
    }
}
