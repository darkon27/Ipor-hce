using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALNocNanda;

namespace SoluccionSalud.Bussines.BLLNocNanda
{
    public class NocNandaBLL
    {
             public List<SS_HC_NandaNoc> listarNocNanda(SS_HC_NandaNoc objSC, int inicio, int final)
            {
                return new NocNandaRepository().listarNocNanda(objSC, inicio, final);
            }

            public int setMantenimientoNanNoc(SS_HC_NandaNoc ObjTrace)
            {
                return new NocNandaRepository().setMantenimientoNanNoc(ObjTrace);
            }

            public int setMantenimientoNanNoc(List<SS_HC_NandaNoc> listaObjSC)
            {
                return new NocNandaRepository().setMantenimientoNanNoc(listaObjSC);
            }

        
    }
}
