using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public partial class SS_IT_SaludProcedimientoIngreso
    {
        public int IdOrdenAtencion { get; set; }
        public Nullable<int> LineaOrdenAtencionConsulta { get; set; }
        public Nullable<int> LineaOrdenAtencion { get; set; }
        public string Componente { get; set; }
        public Nullable<int> Cantidad { get; set; }
        public Nullable<int> IndicadorEPS { get; set; }
        public Nullable<int> Especialidad { get; set; }
        public Nullable<int> IdMedico { get; set; }
        public Nullable<System.DateTime> FechaProcedimiento { get; set; }
        public Nullable<int> IdCita { get; set; }
        public Nullable<int> EstadoDocumento { get; set; }
        public string UnidadReplicacion { get; set; }
        public Nullable<int> IdEpisodioAtencion { get; set; }
        public Nullable<int> IdPaciente { get; set; }
        public Nullable<int> EpisodioClinico { get; set; }
        public Nullable<int> Secuencia { get; set; }
        public Nullable<int> Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public Nullable<int> IndicadorRecepcion { get; set; }
        public Nullable<System.DateTime> FechaRecepcion { get; set; }
        public Nullable<int> IndicadorProcesado { get; set; }
        public Nullable<System.DateTime> FechaProcesado { get; set; }
        public Nullable<int> idtipoordenatencion { get; set; }
        public string Observacion { get; set; }
        public string SecuencialHCE { get; set; }
    }
}
