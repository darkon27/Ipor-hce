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
    public partial class SS_HC_Procedimiento
    {
        public SS_HC_Procedimiento()
        {
            this.SS_HC_AnatomiaPatologica = new HashSet<SS_HC_AnatomiaPatologica>();
            this.SS_HC_EpisodioAtencion = new HashSet<SS_HC_EpisodioAtencion>();
            this.SS_HC_Imagen = new HashSet<SS_HC_Imagen>();
            this.SS_HC_IntervencionQuirurgica = new HashSet<SS_HC_IntervencionQuirurgica>();
            this.SS_HC_Procedimiento1 = new HashSet<SS_HC_Procedimiento>();
        }
    
        public int IdProcedimiento { get; set; }
        public Nullable<int> IdProcedimientoPadre { get; set; }
        public string Descripcion { get; set; }
        public string DescripcionExtranjera { get; set; }
        public Nullable<int> Nivel { get; set; }
        public string UltimoNivelFlag { get; set; }
        public string CadenaRecursiva { get; set; }
        public Nullable<int> Orden { get; set; }
        public string Icono { get; set; }
        public string NombreInterfaz { get; set; }
    
        public virtual ICollection<SS_HC_AnatomiaPatologica> SS_HC_AnatomiaPatologica { get; set; }
        public virtual ICollection<SS_HC_EpisodioAtencion> SS_HC_EpisodioAtencion { get; set; }
        public virtual ICollection<SS_HC_Imagen> SS_HC_Imagen { get; set; }
        public virtual ICollection<SS_HC_IntervencionQuirurgica> SS_HC_IntervencionQuirurgica { get; set; }
        public virtual ICollection<SS_HC_Procedimiento> SS_HC_Procedimiento1 { get; set; }
        public virtual SS_HC_Procedimiento SS_HC_Procedimiento2 { get; set; }
    }
    
}
