using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public class DataBandeja
    {
        public string UnidadReplicacion { get; set; }
        public string PacienteNombre { get; set; }
        public string DocumentoIdentidad { get; set; }

        public string AccionFiltro { get; set; }
        public string NroHC { get; set; }
        public Nullable<System.DateTime> FechaInicio { get; set; }
        public Nullable<System.DateTime> FechaFin { get; set; }
        public Nullable<int> Prioridad { get; set; }
        public Nullable<int> Estado { get; set; }
        public Nullable<int> IdEspecialidad { get; set; }
        public string HistoriaClinica { get; set; }
    }
}
