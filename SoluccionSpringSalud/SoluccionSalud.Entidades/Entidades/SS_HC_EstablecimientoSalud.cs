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
    public partial class SS_HC_EstablecimientoSalud
    {
        public SS_HC_EstablecimientoSalud()
        {
            this.SS_HC_UnidadServicio = new HashSet<SS_HC_UnidadServicio>();
            this.SS_HC_EpisodioAtencion = new HashSet<SS_HC_EpisodioAtencion>();
        }
    
        public int IdEstablecimientoSalud { get; set; }
        public string CodigoEstablecimientoSalud { get; set; }
        public Nullable<int> IdEstablecimientoSaludPadre { get; set; }
        public string TipoEstablecimientoSalud { get; set; }
        public string NombreComercial { get; set; }
        public string NombreAnterior { get; set; }
        public string Subsector { get; set; }
        public string Categoria { get; set; }
        public string ResolucionCategorizacion { get; set; }
        public string ResolucionHabilitacion { get; set; }
        public Nullable<System.DateTime> FechaCreacionEmpresa { get; set; }
        public Nullable<System.DateTime> FechaInicioActividades { get; set; }
        public Nullable<int> Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
    
        public virtual PERSONAMAST PERSONAMAST { get; set; }
        public virtual ICollection<SS_HC_UnidadServicio> SS_HC_UnidadServicio { get; set; }
        public virtual ICollection<SS_HC_EpisodioAtencion> SS_HC_EpisodioAtencion { get; set; }
    }
    
}
