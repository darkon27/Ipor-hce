using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALNocIndicador;

namespace SoluccionSalud.Bussines.BLLNocIndicador
{
    public class NocIndicadorBLL
    {
        public List<SS_HC_NOCIndicador> listarNocIndicador(SS_HC_NOCIndicador objSC, int inicio, int final)
        {
            return new NocIndicadorRepository().listarNocIndicador(objSC, inicio, final);
        }

        public int setMantenimientoNocIndicador(SS_HC_NOCIndicador ObjTrace)
        {
            return new NocIndicadorRepository().setMantenimientoNocIndicador(ObjTrace);
        }

        public int setMantenimientoNocIndicador(List<SS_HC_NOCIndicador> listaObjSC)
        {
            return new NocIndicadorRepository().setMantenimientoNocIndicador(listaObjSC);
        }
    }
}
