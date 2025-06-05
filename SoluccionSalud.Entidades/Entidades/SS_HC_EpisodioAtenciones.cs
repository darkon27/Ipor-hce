using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
  
   public partial class SS_HC_EpisodioAtenciones
 
    {
        public string UnidadReplicacion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public Nullable<long> EpisodioAtencion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public Nullable<int> IdOrdenAtencion { get; set; }
        public Nullable<int> LineaOrdenAtencion { get; set; }
        public string CodigoOA { get; set; }
        public Nullable<int> TipoAtencion { get; set; }
        public string UnidadReplicacionEC { get; set; }
        public Nullable<int> TipoOrdenAtencion { get; set; }
        public string TipoTrabajador { get; set; }
        public string TipoEpisodio { get; set; }
        public string IdEpisodioAtencionCodigo { get; set; }
        public Nullable<int> IdEstablecimientoSalud { get; set; }
        public Nullable<int> IdUnidadServicio { get; set; }
        public Nullable<int> IdPersonalSalud { get; set; }
        public Nullable<System.DateTime> FechaRegistro { get; set; }
        public Nullable<System.DateTime> FechaAtencion { get; set; }
        public Nullable<int> Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public Nullable<int> IdEspecialidad { get; set; }
        public string ProximaAtencionFlag { get; set; }
        public Nullable<int> IdEspecialidadProxima { get; set; }
        public Nullable<int> IdEstablecimientoSaludProxima { get; set; }
        public Nullable<int> IdTipoInterConsulta { get; set; }
        public Nullable<int> IdTipoReferencia { get; set; }
        public string ObservacionProxima { get; set; }
        public string DescansoMedico { get; set; }
        public Nullable<int> DiasDescansoMedico { get; set; }
        public Nullable<System.DateTime> FechaInicioDescansoMedico { get; set; }
        public Nullable<System.DateTime> FechaFinDescansoMedico { get; set; }
        public Nullable<System.DateTime> FechaOrden { get; set; }
        public Nullable<int> IdProcedimiento { get; set; }
        public string ObservacionOrden { get; set; }
        public Nullable<int> IdTipoOrden { get; set; }
        public Nullable<int> FlagFirma { get; set; }
        public Nullable<System.DateTime> FechaFirma { get; set; }
        public Nullable<int> idMedicoFirma { get; set; }
        public string ObservacionFirma { get; set; }
        public string KeyPrivada { get; set; }
        public string KeyPublica { get; set; }
        public string Accion { get; set; }
        public string Version { get; set; }
        public string Url { get; set; }
        public string Reg { get; set; }
        public string IdForm { get; set; }
        public string IdOpcion { get; set; }
        public string Usuario { get; set; }
        public string TransID { get; set; }
        public string Lectura { get; set; }
        public string CONCEPTO { get; set; }
        public string DESCRIPCION { get; set; }
        public string GRUPO { get; set; }
        public string WORKFLAG { get; set; }
        public Nullable<int> URLFLAG { get; set; }
        public string ESTADOFORMULARIO { get; set; }
        
        public virtual SS_HC_EpisodioAtencionMaster SS_HC_EpisodioAtencionMaster { get; set; }
        public virtual SS_HC_Procedimiento SS_HC_Procedimiento { get; set; }
        public virtual SS_HC_EstablecimientoSalud SS_HC_EstablecimientoSalud { get; set; }
        public virtual SS_HC_PersonalSalud SS_HC_PersonalSalud { get; set; }
        public virtual SS_HC_EpisodioClinico SS_HC_EpisodioClinico { get; set; }
    }

}
