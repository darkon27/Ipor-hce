using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALClase;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLClase
{
    public class ClaseBLL
    {
        public List<SS_HC_ClasePAE> listarclase(SS_HC_ClasePAE objSC, int inicio, int final)
        {
            return new claseRepository().listarclase(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_ClasePAE ObjTrace)
        {
            return new claseRepository().setMantenimiento(ObjTrace);
        }

    }
}
