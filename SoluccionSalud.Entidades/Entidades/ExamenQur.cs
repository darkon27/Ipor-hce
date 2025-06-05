using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public class ExamenQur
    {
        public int Id { get; set; }

        public string Descripcion { get; set; }

        public Nullable<int> Tipo { get; set; }

        public string Sucursal { get; set; }

        public string CodigoMedi { get; set; }
        public string ACCION { get; set; }
    }
}
