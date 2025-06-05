using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.Formularios
{
    
    public class SvcEnfermedadActual
    {
        public static List<MA_MiscelaneosDetalle> GetTabla01FI(MA_MiscelaneosDetalle objSC)
        {

            return new List<MA_MiscelaneosDetalle>
            {
                new MA_MiscelaneosDetalle {  CodigoElemento = "1", DescripcionLocal = "Department A" },
                new MA_MiscelaneosDetalle { CodigoElemento = "2", DescripcionLocal = "Department B" },
                new MA_MiscelaneosDetalle { CodigoElemento = "3", DescripcionLocal = "Department C" }
            };
        
        }

    }
}
