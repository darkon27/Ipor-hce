using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.RepositoryReport.Entidades
{
    public partial class rptViewSolicitudTransfusional_FEEdit
    {
        public string UnidadReplicacion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public DateTime FechaSolicitud { get; set; }
        public DateTime HoraSolicitud { get; set; }
        public string Nombres_Paciente { get; set; }
        public string Sexo_Paciente { get; set; }
        public int Edad_paciente { get; set; }
        public string CodigoHC { get; set; }
        public string Nro_cama { get; set; }
        public string UnidadServicioCodigo { get; set; }
        public string UnidadServicioDesc { get; set; }
        public string TransfusionesPrevias { get; set; }
        public string ReaccionesTransfusionalesAnteriores { get; set; }
        public string EmbarazosPrevios { get; set; }
        public string EmbarazosPreviosEspecificar { get; set; }
        public string Abortos { get; set; }
        public string AbortosEspecificar { get; set; }
        public string IncompatMaternoFetal { get; set; }
        public string IncompatMaternoFetalEspecificar { get; set; }
        public string DiagnosticoEnfermedad { get; set; }
        public decimal Hb { get; set; }
        public decimal Hcto { get; set; }
        public decimal Plaquetas { get; set; }
        public string SangreTotalFlag { get; set; }
        public decimal SangreTotalCantidad { get; set; }
        public decimal FraccionPediatricasCantidad { get; set; }
        public string FraccionPediatricasFlag { get; set; }
        public string PaqueteGlobularFlag { get; set; }
        public decimal PaqueteGlobularCantidad { get; set; }
        public decimal RequerimientoCantidad { get; set; }
        public string RequerimientoEspecialFlag { get; set; }
        public string PlasmaFrescoCongeladoFlag { get; set; }
        public decimal PlasmaFrescoCongeladoCantidad { get; set; }
        public decimal DesleucocitadoCantidad { get; set; }
        public string DesleucocitadoFlag { get; set; }
        public string CrioprecipitadoFlag { get; set; }
        public decimal CrioprecipitadoCantidad { get; set; }
        public decimal IrradiadoCantidad { get; set; }
        public string IrradiadoFlag { get; set; }
        public string PlaquetasFlag { get; set; }
        public decimal PlaquetasCantidad { get; set; }
        public decimal OtrosCantidad { get; set; }
        public string OtrosEspecificar { get; set; }
        public string OtrosFlag { get; set; }
        public string Requisito { get; set; }
        public string PersonaBanco { get; set; }
        public string FechaRecepcion { get; set; }
        public string HoraRecepcion { get; set; }
        public string PersMedicoNombreCompleto { get; set; }
        public string Expr104 { get; set; }
    }
}
