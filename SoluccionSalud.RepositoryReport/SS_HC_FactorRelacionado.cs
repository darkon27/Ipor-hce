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

namespace SoluccionSalud.RepositoryReport
{
    public partial class SS_HC_FactorRelacionado
    {
        public int IdFactorRelacionado { get; set; }
        public string Codigo { get; set; }
        public string CodigoPadre { get; set; }
        public string Descripcion { get; set; }
        public string DescripcionCorta { get; set; }
        public Nullable<int> Nivel { get; set; }
        public string CadenaRecursiva { get; set; }
        public Nullable<int> Orden { get; set; }
        public Nullable<int> Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public string Accion { get; set; }
        public string Version { get; set; }
    }
    
}
