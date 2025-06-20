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
using System.Globalization;

namespace SoluccionSalud.Entidades.Entidades
{
    public partial class SS_FA_SolicitudProductoDetalle
    {
        public string UnidadReplicacion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public int IdSolicitudProducto { get; set; }
        public int Secuencia { get; set; }
        public string UnidadReplicacionReferencia { get; set; }
        public Nullable<long> IdEpisodioAtencionReferencia { get; set; }
        public Nullable<int> IdPacienteReferencia { get; set; }
        public Nullable<int> EpisodioClinicoReferencia { get; set; }
        public Nullable<decimal> Cantidad { get; set; }
        public string Linea { get; set; }
        public string Familia { get; set; }
        public string SubFamilia { get; set; }
        public string TipoComponente { get; set; }
        public string CodigoComponente { get; set; }
        public Nullable<int> IdOrdenAtencion { get; set; }
        public Nullable<int> Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public string Accion { get; set; }
        public string Version { get; set; }
        public string Medicamento { get; set; }
        public Nullable<int> GrupoMedicamento { get; set; }
        public string indicaciones { get; set; }
        public string SecuencialHCE { get; set; }
        public Nullable<int> LineaOrdenAtencion { get; set; }
        public string Action { get; set; }
    }
    
}
