using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Model;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.IRepository;

namespace SoluccionSalud.Repository.DALHC_CIAP2
{
    public interface IHC_CIAP2Repository : IGenericDataRepository<SS_HC_CIAP2>
    {
        List<SS_HC_CIAP2> listarSS_HC_CIAP2(SS_HC_CIAP2 objSC);
    }

}
