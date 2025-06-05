using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Bussines.BLLDetalleMiscelaneo;

namespace SoluccionSalud.Service.DetalleMiscelaneoService
{
    public class SvcMiscelaneoHeader
    {
        public static List<MA_MiscelaneosHeader> listarHeaderMiscelaneo(MA_MiscelaneosHeader objSC, int inicio, int final)
        {
            return new MiscelaneoHeaderBLL().listarHeaderMiscelaneo(objSC, inicio, final);
        }

        public static int setMantenimiento(MA_MiscelaneosHeader ObjTrace)
        {
            return new MiscelaneoHeaderBLL().setMantenimiento(ObjTrace);
        }
    }
}
