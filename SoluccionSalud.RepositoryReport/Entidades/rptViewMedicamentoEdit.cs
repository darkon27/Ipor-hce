using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.RepositoryReport.Entidades
{
    public partial class rptViewMedicamentoEdit
    {
        public string UnidadReplicacion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int Secuencia { get; set; }
        public string Linea { get; set; }
        public string Familia { get; set; }
        public string SubFamilia { get; set; }
        public string CodigoComponente { get; set; }
        public string TipoComponente { get; set; }
        public int IdVia { get; set; }
        public decimal Dosis { get; set; }
        public decimal DiasTratamiento { get; set; }
        public decimal Frecuencia { get; set; }
        public decimal Cantidad { get; set; }
        public int IndicadorEPS { get; set; }
        public string Comentario { get; set; }
        public int TipoComida { get; set; }
        public int Estado { get; set; }
        public int TipoMedicamento { get; set; }
        public string MED_DCI { get; set; }
        public string ViaDesc { get; set; }
        public string UnidMedDesc { get; set; }
        public string GrupoMed { get; set; }
        public string IndicacionesDesc { get; set; }
        public int SecuenciaMedIndicacion { get; set; }
        public int SecuenciaIndicacion { get; set; }
        public string IndicadorRecetaDesc { get; set; }
        public string TipoRegistroMedDesc { get; set; }
        public string ApellidoPaterno { get; set; }
        public string ApellidoMaterno { get; set; }
        public string Nombres { get; set; }
        public string NombreCompleto { get; set; }
        public string Busqueda { get; set; }
        public string TipoDocumento { get; set; }
        public string Documento { get; set; }
        public System.DateTime FechaNacimiento { get; set; }
        public string Sexo { get; set; }
        public string EstadoCivil { get; set; }
        public int PersonaEdad { get; set; }
        public int IdOrdenAtencion { get; set; }
        public string CodigoOA { get; set; }
        public int LineaOrdenAtencion { get; set; }
        public int TipoOrdenAtencion { get; set; }
        public int TipoAtencion { get; set; }
        public string TipoTrabajador { get; set; }
        public int IdEstablecimientoSalud { get; set; }
        public int IdUnidadServicio { get; set; }
        public int IdPersonalSalud { get; set; }
        public System.DateTime FechaRegistro { get; set; }
        public System.DateTime FechaAtencion { get; set; }
        public int IdEspecialidad { get; set; }
        public int IdTipoOrden { get; set; }
        public int estadoEpiAtencion { get; set; }
        public string Expr101 { get; set; }
        public string Expr102 { get; set; }
        public string Expr103 { get; set; }
        public string Expr104 { get; set; }
        public string TipoAtencionDesc { get; set; }
        public string TipoTrabajadorDesc { get; set; }
        public string EstablecimientoCodigo { get; set; }
        public string EstablecimientoDesc { get; set; }
        public string UnidadServicioCodigo { get; set; }
        public string UnidadServicioDesc { get; set; }
        public string PersMedicoNombreCompleto { get; set; }
        public string PersMedicoNombreDocumento { get; set; }
        public string EspecialidadCodigo { get; set; }
        public string EspecialidadDesc { get; set; }

    }
}
