using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
 

namespace SoluccionSalud.Bussines
{
    public interface ICategoriasBLL
    {
        List<SEGURIDADCONCEPTO> Mostrar();
        int Eliminar(params object[] parameters);

    }
}
