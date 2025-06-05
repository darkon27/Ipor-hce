using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLSeguridadConcepto;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.SeguridadService
{
  
    public class SvcSeguridadConcepto
    {
        public static List<SEGURIDADCONCEPTO> GetSelectSP(SEGURIDADCONCEPTO objSC)
        {
            return new SeguridadConceptoBLL().GetSelectSP(objSC);

        }

        public static List<SEGURIDADGRUPO> GetSelectSeguridadGrupo(SEGURIDADGRUPO objSC)
        {
            return new SeguridadConceptoBLL().GetSelectSeguridadGrupo(objSC);

        }
        
    }
}
