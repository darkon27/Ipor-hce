using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public class A_SP_SS_HCE_ListaServiciosAuxiliares_Result
    {
        public int Secuencial { get; set; }
        public string Descripcion { get; set; }
        public string Nombre { get; set; }
        public int IdOrdenAtencion { get; set; }
        public int Linea { get; set; }
        public Nullable<int> TipoOrdenAtencion { get; set; }
        public Nullable<int> IdConsultaExterna { get; set; }
        public Nullable<int> lineaconsulta { get; set; }
        public string CodigoOA { get; set; }
        public Nullable<System.DateTime> FechaPreparacion { get; set; }
        public Nullable<System.DateTime> FechaInicio { get; set; }
        public Nullable<System.DateTime> FechaFinal { get; set; }
        public Nullable<int> TipoAtencion { get; set; }
        public Nullable<int> TipoPaciente { get; set; }
        public Nullable<int> IdServicio { get; set; }
        public Nullable<int> IdPaciente { get; set; }
        public Nullable<int> IdEmpresaAseguradora { get; set; }
        public Nullable<int> EstadoDocumento { get; set; }
        public Nullable<int> EstadoDocumentoAnterior { get; set; }
        public Nullable<int> Estado { get; set; }
        public string IdServicio_Nombre { get; set; }
        public string IdGrupoAtencion_Nombre { get; set; }
        public Nullable<int> IdGrupoAtencion { get; set; }
        public string IdEspecialidad_Nombre { get; set; }
        public Nullable<int> Especialidad { get; set; }
        public string Componente_Nombre { get; set; }
        public Nullable<int> IndicadorEPS { get; set; }
        public string Observacion { get; set; }
    }
}
