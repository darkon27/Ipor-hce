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
    
    public partial class SS_HC_Indicaciones
    {
        public string UnidadReplicacion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public int SecuenciaMedicamento { get; set; }
        public int Secuencia { get; set; }
        public string TipoRegistro { get; set; }
        public Nullable<int> Correlativo { get; set; }
        public Nullable<int> IdTipoIndicacion { get; set; }
        public string Descripcion { get; set; }
        public Nullable<int> Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public string Accion { get; set; }
        public string Version { get; set; }
    
        public virtual SS_HC_Medicamento SS_HC_Medicamento { get; set; }
    }
}
