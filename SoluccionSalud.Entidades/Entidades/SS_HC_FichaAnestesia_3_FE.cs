using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public partial class SS_HC_FichaAnestesia_3_FE
    {
        public string UnidadReplicacion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
		public Nullable<int> VisualizacionaAnestesia { get; set; }
		public Nullable<int> MonitorizacionAnestesia { get; set; }
		public Nullable<decimal> PresionArterial15_1 { get; set; }
		public Nullable<decimal> PresionArterial15_2 { get; set; }
		public Nullable<decimal> PresionArterial30_1 { get; set; }
		public Nullable<decimal> PresionArterial30_2 { get; set; }
		public Nullable<decimal> PresionArterial45_1 { get; set; }
		public Nullable<decimal> PresionArterial45_2 { get; set; }
		public Nullable<decimal> PresionArterial60_1 { get; set; }
		public Nullable<decimal> PresionArterial60_2 { get; set; }
		public string AnestesiaEKG15 { get; set; }
		public string AnestesiaEKG30 { get; set; }
		public string AnestesiaEKG45 { get; set; }
		public string AnestesiaEKG60 { get; set; }
		public Nullable<decimal> PresionS0215 { get; set; }
		public Nullable<decimal> PresionS0230 { get; set; }
		public Nullable<decimal> PresionS0245 { get; set; }
		public Nullable<decimal> PresionS0260 { get; set; }
		public Nullable<decimal> PresionETC0215 { get; set; }
		public Nullable<decimal> PresionETC0230 { get; set; }
		public Nullable<decimal> PresionETC0245 { get; set; }
		public Nullable<decimal> PresionETC0260 { get; set; }
		public Nullable<decimal> PresionT15 { get; set; }
		public Nullable<decimal> PresionT30 { get; set; }
		public Nullable<decimal> PresionT45 { get; set; }
		public Nullable<decimal> PresionT60 { get; set; }
		public string PresionPAN15 { get; set; }
		public string PresionPAN30 { get; set; }
		public string PresionPAN45 { get; set; }
		public string PresionPAN60 { get; set; }
		public string PresionPANI15 { get; set; }
		public string PresionPANI30 { get; set; }
		public string PresionPANI45 { get; set; }
		public string PresionPANI60 { get; set; }
		public string PresionPVC15 { get; set; }
		public string PresionPVC30 { get; set; }
		public string PresionPVC45 { get; set; }
		public string PresionPVC60 { get; set; }
		public string PresionBIS15 { get; set; }
		public string PresionBIS30 { get; set; }
		public string PresionBIS45 { get; set; }
		public string PresionBIS60 { get; set; }
		public string PresionRespiEspontanea15 { get; set; }
		public string PresionRespiEspontanea30 { get; set; }
		public string PresionRespiEspontanea45 { get; set; }
		public string PresionRespiEspontanea60 { get; set; }
		public string PresionRespiAsistida15 { get; set; }
		public string PresionRespiAsistida30 { get; set; }
		public string PresionRespiAsistida45 { get; set; }
		public string PresionRespiAsistida60 { get; set; }
		public string PresionRespiControlado15 { get; set; }
		public string PresionRespiControlado30 { get; set; }
		public string PresionRespiControlado45 { get; set; }
		public string PresionRespiControlado60 { get; set; }
		public string AGASodio15 { get; set; }
		public string AGASodio30 { get; set; }
		public string AGASodio45 { get; set; }
		public string AGASodio60 { get; set; }
		public string AGAPotasio15 { get; set; }
		public string AGAPotasio30 { get; set; }
		public string AGAPotasio45 { get; set; }
		public string AGAPotasio60 { get; set; }
		public string AGABicarbonato15 { get; set; }
		public string AGABicarbonato30 { get; set; }
		public string AGABicarbonato45 { get; set; }
		public string AGABicarbonato60 { get; set; }
		public string AGABh15 { get; set; }
		public string AGABh30 { get; set; }
		public string AGABh45 { get; set; }
		public string AGABh60 { get; set; }
		public string AGAFiO15 { get; set; }
		public string AGAFiO30 { get; set; }
		public string AGAFiO45 { get; set; }
		public string AGAFiO60 { get; set; }
		public string AGAHemoglobina15 { get; set; }
		public string AGAHemoglobina30 { get; set; }
		public string AGAHemoglobina45 { get; set; }
		public string AGAHemoglobina60 { get; set; }
		public string AGAHematogrito15 { get; set; }
		public string AGAHematogrito30 { get; set; }
		public string AGAHematogrito45 { get; set; }
		public string AGAHematogrito60 { get; set; }

		public Nullable<int> Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public string Accion { get; set; }
        public string Version { get; set; }
    }
}
