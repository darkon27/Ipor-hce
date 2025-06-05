using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLSeguridadConcepto;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALSeguridad;

namespace SoluccionSalud.Bussines.BLLSeguridadConcepto
{
    public class SeguridadConceptoBLL : ISeguridadConceptoBLL
    {
        public List<SEGURIDADCONCEPTO> GetAll()
        {
            throw new NotImplementedException();
        }

        public List<SEGURIDADCONCEPTO> GetSelect(params object[] items)
        {
            throw new NotImplementedException();
        }

        public List<SEGURIDADCONCEPTO> GetSelectSP(SEGURIDADCONCEPTO objSC)
        {
            return new SeguridadRepository().GetSelectSP(objSC);
            
        }
        public List<SEGURIDADGRUPO> GetSelectSeguridadGrupo(SEGURIDADGRUPO objSC)
        {
            return new SeguridadRepository().GetSelectSeguridadGrupo(objSC);

        }
  
    }
}
