using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALWH_ClaseLinea;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLWH_ClaseLinea
{
    public class WH_ClaseLineaBLL
    {
        public List<WH_ClaseLinea> listarWH_ClaseLinea(WH_ClaseLinea objSC, int inicio, int final)
        {
            return new WH_ClaseLineaRepository().listarWH_ClaseLinea(objSC, inicio, final);
        }

        public int setMantenimiento(WH_ClaseLinea ObjTrace)
        {
            return new WH_ClaseLineaRepository().setMantenimiento(ObjTrace);
        }
    }
}
