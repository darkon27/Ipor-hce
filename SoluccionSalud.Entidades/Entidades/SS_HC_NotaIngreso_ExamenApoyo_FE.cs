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
    public partial class SS_HC_NotaIngreso_ExamenApoyo_FE
    {
        public string UnidadReplicacion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public int Secuencia { get; set; }
        public string CodigoSegus { get; set; }
        public Nullable<int> TipoOrdenAtencion { get; set; }
        public Nullable<int> IndicadorEPS { get; set; }
        public string CodigoComponente { get; set; }
        public string ExamenDescripcion { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public string Accion { get; set; }
        public string Version { get; set; }
    
        public virtual SS_HC_Nota_Ingreso_FE SS_HC_Nota_Ingreso_FE { get; set; }
    }
    
}
