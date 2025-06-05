using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AppSaludMVC.Models
{
    public class SP_SS_HC_SG_Agente_LISTAR_Result
    {
        public int IdAgente { get; set; }
        public Nullable<int> IdGrupo { get; set; }
        public Nullable<int> IdOrganizacion { get; set; }
        public Nullable<int> TipoAgente { get; set; }
        public string CodigoAgente { get; set; }
        public Nullable<int> IdEmpleado { get; set; }
        public Nullable<int> IndicadorMultiple { get; set; }
        public string Clave { get; set; }
        public Nullable<int> ExpiraClave { get; set; }
        public Nullable<System.DateTime> FechaInicio { get; set; }
        public Nullable<System.DateTime> FechaFin { get; set; }
        public Nullable<System.DateTime> FechaExpiracion { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public Nullable<int> Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public Nullable<int> IdGrupoTransaccion { get; set; }
        public Nullable<int> TipoTransaccion { get; set; }
        public Nullable<int> IdOpcionDefecto { get; set; }
        public string ACCION { get; set; }
        public string Plataforma { get; set; }
        public string tipotrabajador { get; set; }
        public Nullable<int> IdCodigo { get; set; }
        public Nullable<int> Almacen { get; set; }
        public Nullable<int> flatUsuGenerico { get; set; }
        public Nullable<int> FlatAgente { get; set; }
    }
}