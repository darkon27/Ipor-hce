using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALCuidadoPreventivo;

namespace SoluccionSalud.Bussines.BLLCuidadoPreventivo
{
    public class CuidadoPreventivoBLL
    {
        public List<SS_HC_CuidadoPreventivo> listarCuidadoPreventivo(SS_HC_CuidadoPreventivo objSC, int inicio, int final)
        {
            return new CuidadoPreventivoRepository().listarCuidadoPreventivo(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_CuidadoPreventivo ObjTrace)
        {
            return new CuidadoPreventivoRepository().setMantenimiento(ObjTrace);
        }
    }
}
