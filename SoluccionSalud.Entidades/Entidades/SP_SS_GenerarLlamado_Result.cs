using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public class SP_SS_GenerarLlamado_Result
    {
        public Nullable<int> IdCita { get; set; } 
        public Nullable<int> Secuencia { get; set; }
        public string Usuario { get; set; }
        public string Observacion { get; set; }
    }
}
