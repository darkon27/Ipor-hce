using SoluccionSalud.Bussines.BLLDetalleMiscelaneo;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.DetalleMiscelaneoService
{
    public class SvcDetalleMiscelaneo
    {
        public static List<MA_MiscelaneosDetalle> listarDetalleMiscelaneo(MA_MiscelaneosDetalle objSC, int inicio, int final)
        {
            return new DetalleMiscelaneoBLL().listarDetalleMiscelaneo(objSC, inicio, final);
        }

        public static int setMantenimiento(MA_MiscelaneosDetalle ObjTrace)
        {
            return new DetalleMiscelaneoBLL().setMantenimiento(ObjTrace);
        }
    }
}
