using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALHC_CIAP2;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLHC_CIAP2
{
    public class HC_CIAP2BLL
    {
        public List<SS_HC_CIAP2> listarSS_HC_CIAP2(SS_HC_CIAP2 objSC, int inicio, int final)
        {
            return new HC_CIAP2Repository().listarSS_HC_CIAP2(objSC,inicio,final); 
        }

        public int setMantenimiento(SS_HC_CIAP2 ObjTrace)
        {
            return new HC_CIAP2Repository().setMantenimiento(ObjTrace);
        }
    }
}
