using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALNANDA;

namespace SoluccionSalud.Bussines.BLLNanda
{
    public class NandaBLL
    {
        public List<SS_HC_NANDA> listarNanda(SS_HC_NANDA objSC, int inicio, int final)
        {
            return new NandaRepository().listarNanda(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_NANDA ObjTrace)
        {
            return new NandaRepository().setMantenimiento(ObjTrace);
        }


        public int setMantenimiento(SS_HC_NANDA ObjTraces, List<SS_HC_NANDA> listaCabecera,
           List<SS_HC_NANDA> listaDetalle)
        {
            return new NandaRepository().setMantenimiento(ObjTraces, listaCabecera, listaDetalle);
        }
    }
}
