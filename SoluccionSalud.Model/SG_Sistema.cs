//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace SoluccionSalud.Model
{
    using System;
    using System.Collections.Generic;
    
    public partial class SG_Sistema
    {
        public SG_Sistema()
        {
            this.SG_Modulo = new HashSet<SG_Modulo>();
        }
    
        public string Sistema { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public Nullable<int> Plataforma { get; set; }
        public string UrlSistema { get; set; }
        public Nullable<int> Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
    
        public virtual ICollection<SG_Modulo> SG_Modulo { get; set; }
    }
}
