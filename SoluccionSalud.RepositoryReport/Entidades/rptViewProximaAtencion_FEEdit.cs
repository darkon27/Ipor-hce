using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.RepositoryReport.Entidades
{
    public partial class rptViewProximaAtencion_FEEdit
    {

        public string UnidadReplicacion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public int Secuencia { get; set; }
        public string ProximaAtencionFlag { get; set; }
        public System.DateTime  FechaSolicitada { get; set; }
        public System.DateTime  FechaPlaneada { get; set; }
        public int  IdEspecialidad { get; set; }
        public int  IdEstablecimientoSalud { get; set; }
        public int  IdTipoInterConsulta { get; set; }
        public int  IdTipoReferencia { get; set; }
        public string Observacion { get; set; }
        public int  IdProcedimiento { get; set; }
        public string CodigoComponente { get; set; }
        public int  TipoOrdenAtencion { get; set; }
        public int  IndicadorEPS { get; set; }
        public int  IdPersonalSalud { get; set; }
        public int  IdDiagnostico { get; set; }
        public string ProcedimientoText { get; set; }
        public string DiagnosticoText { get; set; }
        public string Accion { get; set; }
        public string Version { get; set; }
        public int  Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public System.DateTime  FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public System.DateTime  FechaModificacion { get; set; }
        public string Descripcion { get; set; }
    }
}

