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
    
    public partial class HC_SubProceso
    {
        public HC_SubProceso()
        {
            this.HC_SubProcesoHijo = new HashSet<HC_SubProcesoHijo>();
        }
    
        public string SubProceso { get; set; }
        public string Proceso { get; set; }
        public Nullable<int> Nivel { get; set; }
        public string Descripcion { get; set; }
        public string EsPapaFlag { get; set; }
        public string Icono { get; set; }
        public string NombreInterfaz { get; set; }
    
        public virtual HC_Proceso HC_Proceso { get; set; }
        public virtual ICollection<HC_SubProcesoHijo> HC_SubProcesoHijo { get; set; }
    }
}
