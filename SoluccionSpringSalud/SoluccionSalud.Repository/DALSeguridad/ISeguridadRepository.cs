using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Entidades.IRepository;

namespace SoluccionSalud.Repository.DALSeguridad
{
 

    public interface ISeguridadRepository : IGenericDataRepository<SEGURIDADCONCEPTO>
    {
        List<SEGURIDADCONCEPTO> GetAll();
        List<SEGURIDADCONCEPTO> GetSelect(params object[] items);
        List<SEGURIDADCONCEPTO> GetSelectSP(SEGURIDADCONCEPTO objSC);
        List<SEGURIDADGRUPO> GetSelectSeguridadGrupo(SEGURIDADGRUPO objSC);
        
    }
}
