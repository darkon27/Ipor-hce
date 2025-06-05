using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public partial class SS_HC_AnestesiaDiagnosticoDetalle_FE
    {
        public string UnidadReplicacion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public int Secuencia { get; set; }
        public string DiagnosticoDescripcion { get; set; }
        public string Codigo { get; set; }
        public int TipoDiag { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public string Accion { get; set; }
        public string Version { get; set; }
        public string DeterminacionDiagnostica { get; set; }
        public Nullable<int> IdDiagnosticoPrincipal { get; set; }
        public string GradoAfeccion { get; set; }
        public string TiempoEmfer { get; set; }
        public Nullable<int> Estado { get; set; }
      

    }
}
