using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALDetalleMiscelaneo;

namespace SoluccionSalud.Bussines.BLLDetalleMiscelaneo
{
    public class DetalleMiscelaneoBLL
    {
        public List<MA_MiscelaneosDetalle> listarDetalleMiscelaneo(MA_MiscelaneosDetalle objSC, int inicio, int final)
        {
            return new DetalleMiscelaneoRepository().listarDetalleMiscelaneo(objSC, inicio, final);
        }

        public int setMantenimiento(MA_MiscelaneosDetalle ObjTrace)
        {
            return new DetalleMiscelaneoRepository().setMantenimiento(ObjTrace);
        }
    }
}
