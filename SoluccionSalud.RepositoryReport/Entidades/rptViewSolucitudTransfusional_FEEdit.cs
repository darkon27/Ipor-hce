using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.RepositoryReport.Entidades
{
    public partial class rptViewSolucitudTransfusional_FEEdit
    {
        public string UnidadReplicacion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public System.DateTime FechaSolicitud { get; set; }
        public System.DateTime HoraSolicitud { get; set; }
        public string TransfusionesPrevias { get; set; }
        public string ReaccionesTransfusionalesAnteriores { get; set; }
        public string EmbarazosPrevios { get; set; }
        public string EmbarazosPreviosEspecificar { get; set; }
        public string Abortos { get; set; }
        public string AbortosEspecificar { get; set; }
        public string IncompatMaternoFetal { get; set; }
        public string IncompatMaternoFetalEspecificar { get; set; }
        public int DiagnosticoEnfermedad { get; set; }
        public decimal Hb { get; set; }
        public decimal Hcto { get; set; }
        public decimal Plaquetas { get; set; }
        public string SangreTotalFlag { get; set; }
        public decimal SangreTotalCantidad { get; set; }
        public string PaqueteGlobularFlag { get; set; }
        public decimal PaqueteGlobularCantidad { get; set; }
        public string PlasmaFrescoCongeladoFlag { get; set; }
        public decimal PlasmaFrescoCongeladoCantidad { get; set; }
        public string CrioprecipitadoFlag { get; set; }
        public decimal CrioprecipitadoCantidad { get; set; }
        public string PlaquetasFlag { get; set; }
        public decimal PlaquetasCantidad { get; set; }
        public string FraccionPediatricasFlag { get; set; }
        public decimal FraccionPediatricasCantidad { get; set; }
        public string RequerimientoEspecialFlag { get; set; }
        public decimal RequerimientoCantidad { get; set; }
        public string DesleucocitadoFlag { get; set; }
        public decimal DesleucocitadoCantidad { get; set; }
        public string IrradiadoFlag { get; set; }
        public decimal IrradiadoCantidad { get; set; }
        public string OtrosFlag { get; set; }
        public string OtrosEspecificar { get; set; }
        public decimal OtrosCantidad { get; set; }
        public string Requisito { get; set; }
        public string PersonaBanco { get; set; }
        public System.DateTime FechaRecepcion { get; set; }
        public System.DateTime HoraRecepcion { get; set; }
        public int Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public System.DateTime FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public System.DateTime FechaModificacion { get; set; }
        public string Accion { get; set; }
        public string Version { get; set; }
        public string Diagnostico { get; set; }

    }
}
