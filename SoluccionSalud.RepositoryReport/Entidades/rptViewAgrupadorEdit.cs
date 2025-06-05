using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.RepositoryReport.Entidades
{
    public partial class rptViewAgrupadorEdit
    {
        public string UnidadReplicacion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public long EpisodioAtencion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public string UnidadReplicacionEC { get; set; }
        public string TipoEpisodio { get; set; }
        public string IdEpisodioAtencionCodigo { get; set; }
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
        public int edad { get; set; }
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
        public string codigoHC { get; set; }
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
        public string ServicioExtra { get; set; }
    }
    
}
