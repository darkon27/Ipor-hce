using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SPRING_Restaurantes_RestServer1.Entidades
{
    public class HceInterconsultaBean
    {
        public string UnidadReplicacion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public int Secuencia { get; set; }
        public string ProximaAtencionFlag { get; set; }
        public Nullable<System.DateTime> FechaSolicitada { get; set; }
        public Nullable<System.DateTime> FechaPlaneada { get; set; }
        public Nullable<int> IdEspecialidad { get; set; }
        public Nullable<int> IdEstablecimientoSalud { get; set; }
        public Nullable<int> IdTipoInterConsulta { get; set; }
        public Nullable<int> IdTipoReferencia { get; set; }
        public string Observacion { get; set; }
        public Nullable<int> IdProcedimiento { get; set; }
        public string CodigoComponente { get; set; }
        public Nullable<int> TipoOrdenAtencion { get; set; }
        public Nullable<int> IndicadorEPS { get; set; }
        public Nullable<int> IdPersonalSalud { get; set; }
        public Nullable<int> IdDiagnostico { get; set; }
        public string ProcedimientoText { get; set; }
        public string DiagnosticoText { get; set; }
        public string Accion { get; set; }
        public string Version { get; set; }
        public Nullable<int> Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }


    }
}