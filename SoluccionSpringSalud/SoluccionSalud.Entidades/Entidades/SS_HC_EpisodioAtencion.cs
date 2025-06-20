//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Collections.Generic;

namespace SoluccionSalud.Entidades.Entidades
{
    public partial class SS_HC_EpisodioAtencion
    {
        public SS_HC_EpisodioAtencion()
        {
            this.SS_HC_Diagnostico = new HashSet<SS_HC_Diagnostico>();
            this.SS_HC_ExamenSolicitado = new HashSet<SS_HC_ExamenSolicitado>();
        }
    
        public string UnidadReplicacion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public string UnidadReplicacionEC { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public Nullable<int> IdEstablecimientoSalud { get; set; }
        public Nullable<int> IdUnidadServicio { get; set; }
        public Nullable<int> IdPersonalSalud { get; set; }
        public Nullable<int> aaaaAtencion { get; set; }
        public Nullable<int> EpisodioAtencion { get; set; }
        public Nullable<System.DateTime> FechaRegistro { get; set; }
        public Nullable<System.DateTime> FechaAtencion { get; set; }
        public Nullable<int> TipoAtencion { get; set; }
        public Nullable<int> IdOrdenAtencion { get; set; }
        public Nullable<int> LineaOrdenAtencion { get; set; }
        public Nullable<int> TipoOrdenAtencion { get; set; }
        public Nullable<int> Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public Nullable<int> IdEspecialidad { get; set; }
        public string CodigoOA { get; set; }
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
        public string Accion { get; set; }
        public string Version { get; set; }
    
        public virtual SS_HC_Anamnesis_AP SS_HC_Anamnesis_AP { get; set; }
        public virtual SS_HC_Anamnesis_EA SS_HC_Anamnesis_EA { get; set; }
        public virtual ICollection<SS_HC_Diagnostico> SS_HC_Diagnostico { get; set; }
        public virtual SS_HC_Procedimiento SS_HC_Procedimiento { get; set; }
        public virtual SS_HC_UnidadServicio SS_HC_UnidadServicio { get; set; }
        public virtual SS_HC_EpisodioClinico SS_HC_EpisodioClinico { get; set; }
        public virtual SS_HC_EstablecimientoSalud SS_HC_EstablecimientoSalud { get; set; }
        public virtual SS_HC_PersonalSalud SS_HC_PersonalSalud { get; set; }
        public virtual ICollection<SS_HC_ExamenSolicitado> SS_HC_ExamenSolicitado { get; set; }
    }
    
}
