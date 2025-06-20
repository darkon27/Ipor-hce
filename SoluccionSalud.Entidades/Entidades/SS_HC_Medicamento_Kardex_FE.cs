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
    public partial class SS_HC_Medicamento_Kardex_FE
    {
        public string UnidadReplicacion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public int Secuencia { get; set; }
        public string CodigoComponente { get; set; }
        public Nullable<int> IdVia { get; set; }
        public string Dosis { get; set; }
        public Nullable<decimal> DiasTratamiento { get; set; }
        public Nullable<decimal> Frecuencia { get; set; }
        public Nullable<decimal> Cantidad { get; set; }
        public string Descripcion { get; set; }
        public Nullable<int> TipoComida { get; set; }
        public string VolumenDia { get; set; }
        public string FrecuenciaToma { get; set; }
        public string Periodo { get; set; }
        public Nullable<int> UnidadTiempo { get; set; }
        public Nullable<int> IndicadorAuditoria { get; set; }
        public string UsuarioAuditoria { get; set; }
        public Nullable<System.DateTime> HoraInicio { get; set; }
        public Nullable<System.DateTime> HoraAdministracion { get; set; }
        public Nullable<int> Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public string Accion { get; set; }
        public string Version { get; set; }
        public string SecuencialHCE { get; set; }
        public string CodAlmacen { get; set; }

        public Nullable<int> Hora0 { get; set; }
    }
    
}
