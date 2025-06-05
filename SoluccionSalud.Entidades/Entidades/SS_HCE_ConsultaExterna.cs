using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public class SS_HCE_ConsultaExterna
    {
        public string UnidadReplicacion { get; set; }
        public Nullable<Int32> IdEpisodioAtencion { get; set; }
        public Nullable<Int32> IdPaciente { get; set; }
        public Nullable<Int32> EpisodioClinico { get; set; }
        public Nullable<Int32> IdConsultaExterna { get; set; }
        public Nullable<Int32> IdOrdenAtencion { get; set; }
        public Nullable<Int32> Linea { get; set; }
        public Nullable<Int32> LineaOrdenAtencion { get; set; }
        public Nullable<Int32> TipoOrdenMedica { get; set; }
        public string Componente { get; set; }
        public Nullable<Int32> TipoInterConsulta { get; set; }
        public Nullable<Int32> Medico { get; set; }
        public Nullable<Int32> Especialidad { get; set; }
        public Nullable<Int32> EstadoDocumento { get; set; }
        public Nullable<Int32> IndicadorEPS { get; set; }
        public Nullable<Int32> Estado { get; set; }
        public Nullable<Int32> MedicoResponsable { get; set; }
        public string UsuarioCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public string SecuenciaHCE { get; set; }
        public Nullable<DateTime> FechaCreacion { get; set; }
        public Nullable<DateTime> FechaModificacion { get; set; }
        public string Accion { get; set; }
        public string Version { get; set; }


    }
}
