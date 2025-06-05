using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Repository.Repository
{
    public interface IMantenimiento 
    {
      int Eliminar(params object[] parameters);
    }
}
