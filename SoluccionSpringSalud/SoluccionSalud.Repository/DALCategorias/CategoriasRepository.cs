using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;

namespace SoluccionSalud.Repository.DALCategorias
{
    public class CategoriasRepository : GenericDataRepository<SEGURIDADCONCEPTO>, ICategoriasRepository, IMantenimiento
    {
        public List<SEGURIDADCONCEPTO> GetAll()
        {
            return base.GetSelectAll();
        }
 

       public  int Eliminar(params object[] parameters)
        {
            return base.ExecuteNonQuery("exec SP_ELIMINAR {0}", parameters);
           
        }
    }
    
}
