using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALCategorias;
using SoluccionSalud.Repository.Repository;

namespace SoluccionSalud.Bussines
{
    public class CategoriasBLL : ICategoriasBLL 

    {

        public List<SEGURIDADCONCEPTO> Mostrar()
        {
            return new CategoriasRepository().GetAll();
        }


        public int Eliminar(params object[] parameters)
        {
            return new CategoriasRepository().Eliminar(parameters);
        }
   
    }
}
