using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public class SS_AD_OrdenAtencionAttach
    {
        public string CodigoOA { get; set; }
        public Nullable<int> IdPaciente { get; set; }
        public string Descripcion { get; set; }

        public Nullable<int> IdOrdenAtencion { get; set; }
        public Nullable<int> Secuencial { get; set; }
        public Nullable<int> Id { get; set; }
        public string Ruta { get; set; }
        public Nullable<int> IndicadorIncluirFacturacion { get; set; }
        public Nullable<int> Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public string UnidadReplicacion { get; set; }
        public string Sucursal { get; set; }
        public string Accion { get; set; }
    }
}
