using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALDetalleMiscelaneo;

namespace SoluccionSalud.Bussines.BLLDetalleMiscelaneo
{
    public class MiscelaneoHeaderBLL
    {
        public List<MA_MiscelaneosHeader> listarHeaderMiscelaneo(MA_MiscelaneosHeader objSC, int inicio, int final)
        {
            return new MiscelaneoHeaderRepository().listarHeaderMiscelaneo(objSC, inicio, final);
        }

        public int setMantenimiento(MA_MiscelaneosHeader ObjTrace)
        {
            return new MiscelaneoHeaderRepository().setMantenimiento(ObjTrace);
        }
    }
}
