using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.RepositoryReport.Entidades
{
    public partial class rptViewApoyoDiagnostico_FEEdit
    {
        public string UnidadReplicacion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public string NroInforme { get; set; }
        public System.DateTime FechaSolicitada { get; set; }
        public int IdEspecialidad { get; set; }
        public int IdProcedimiento { get; set; }
        public int TipoOrdenAtencion { get; set; }
        public string CodigoComponente { get; set; }
        public string ProcedimientoText { get; set; }
        public string Observacion { get; set; }
        public string Accion { get; set; }
        public string Version { get; set; }
        public int Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public string Nombre { get; set; }
        public string RutaInforme { get; set; }
        public string Diagnostico { get; set; }
    }
}
