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
    public partial class SS_GE_PAGINA
    {
        public SS_GE_PAGINA()
        {
            this.SS_GE_PAGINADETALLE = new HashSet<SS_GE_PAGINADETALLE>();
        }
        public string CONCEPTO { get; set; }
        public int IDPAGINA { get; set; }
        public string NOMBREPAGINA { get; set; }
        public string PAGINACSHTML { get; set; }
        public string USUARIOCREACION { get; set; }
        public string USUARIOMODIFICACION { get; set; }
        public Nullable<System.DateTime> FECHACREACION { get; set; }
        public Nullable<System.DateTime> FECHAMODIFICACION { get; set; }
        public Nullable<int> ESTADO { get; set; }
    
        public virtual ICollection<SS_GE_PAGINADETALLE> SS_GE_PAGINADETALLE { get; set; }
    }
    
}
