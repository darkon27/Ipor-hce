using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLNanda;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.NandaService
{
    public class SvcNanda
    {
        public static List<SS_HC_NANDA> listarNanda(SS_HC_NANDA objSC, int inicio, int final)
        {
            return new NandaBLL().listarNanda(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_NANDA ObjTrace)
        {
            return new NandaBLL().setMantenimiento(ObjTrace);
        }

        public static int setMantenimiento(SS_HC_NANDA ObjTraces, List<SS_HC_NANDA> listaCabecera,
                   List<SS_HC_NANDA> listaDetalle)
        {
            return new NandaBLL().setMantenimiento(ObjTraces, listaCabecera, listaDetalle);
        }

    }
}
