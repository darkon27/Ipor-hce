using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALSS_HC_NANDA;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace SoluccionSalud.Bussines.BLLSS_HC_NANDA
{
    public class SS_HC_NANDABLL
    {
        public List<SS_HC_NANDA> listarSS_HC_NANDA(SS_HC_NANDA objSC, int inicio, int final)
        {
            return new SS_HC_NANDARepository().listarSS_HC_NANDA(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_NANDA ObjTrace)
        {
            return new SS_HC_NANDARepository().setMantenimiento(ObjTrace);
        }
    }
}
