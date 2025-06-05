using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Bussines.BLLSeguridadConcepto
{
    public interface ISeguridadConceptoBLL
    {
        List<SEGURIDADCONCEPTO> GetAll();
        List<SEGURIDADCONCEPTO> GetSelect(params object[] items);
        List<SEGURIDADCONCEPTO> GetSelectSP(SEGURIDADCONCEPTO objSC);
        List<SEGURIDADGRUPO> GetSelectSeguridadGrupo(SEGURIDADGRUPO objSC);
    }
}
