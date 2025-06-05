using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Model;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;

namespace SoluccionSalud.Repository.DALDiccionario
{

    public class DiccionarioRepository : GenericDataRepository<SS_CE_DICCIONARIO>, IDiccionarioRepository
    {
       
 
        public List<SS_CE_DICCIONARIO> GetSelectDiccionario(SS_CE_DICCIONARIO objSC)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return null;
            }
        }
    }
}
