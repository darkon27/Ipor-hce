using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;

namespace SoluccionSalud.Repository.DALPersonaMast
{
    public class PersonaMastRepository : GenericDataRepository<PERSONAMAST>, IPersonaMastRepository
    {

        public List<PERSONAMAST> GetSelectPersonaMast(PERSONAMAST objSC)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_PERSONAMAST(objSC.Persona, objSC.NombreCompleto, objSC.Estado, objSC.ACCION).ToList();
            }
        }
 
    }
}
