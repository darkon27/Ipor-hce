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
    public partial class SS_HC_Selector
    {
        public string AplicacionCodigo { get; set; }
        public string Grupo { get; set; }
        public string Concepto { get; set; }
        public int Secuencia { get; set; }
        public string Descripcion { get; set; }
        public string DescripcionExtranjera { get; set; }
        public string NombreTabla { get; set; }
        public string UltimoUsuario { get; set; }
        public Nullable<System.DateTime> UltimaFechaModif { get; set; }
    
        public virtual SEGURIDADCONCEPTO SEGURIDADCONCEPTO { get; set; }
    }
    
}
