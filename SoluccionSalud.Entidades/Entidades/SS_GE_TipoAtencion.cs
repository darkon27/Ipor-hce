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
    public partial class SS_GE_TipoAtencion
    {
        public SS_GE_TipoAtencion()
        {
            this.SG_Opcion = new HashSet<SG_Opcion>();
            this.SS_HC_CatalogoUnidadServicio_TipoAtencion = new HashSet<SS_HC_CatalogoUnidadServicio_TipoAtencion>();
        }
    
        public int IdTipoAtencion { get; set; }
        public string Codigo { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public Nullable<int> Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public string ClasificadorMovimiento { get; set; }
        public string Accion { get; set; }
        public string Version { get; set; }
    
        public virtual ICollection<SG_Opcion> SG_Opcion { get; set; }
        public virtual ICollection<SS_HC_CatalogoUnidadServicio_TipoAtencion> SS_HC_CatalogoUnidadServicio_TipoAtencion { get; set; }
    }
    
}
