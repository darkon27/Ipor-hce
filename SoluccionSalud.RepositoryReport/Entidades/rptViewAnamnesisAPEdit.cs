﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.RepositoryReport.Entidades
{
    public class rptViewAnamnesisAPEdit
    {
        public string UnidadReplicacion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public short IdTipoEmbarazo { get; set; }
        public string PatologiaGestacion { get; set; }
        public short IdControlPrenatal { get; set; }
        public short CPnumeroControles { get; set; }
        public short CPnumeroEmbarazos { get; set; }
        public string LugarControl { get; set; }
        public short IdTipoParto { get; set; }
        public string ComplicacionesParto { get; set; }
        public short IdLugarParto { get; set; }
        public short IdPartoAtendidoPor { get; set; }
        public string AntecentesPatologicos { get; set; }
        public short SemanasGestacionNacer { get; set; }
        public int PesoAlNacerGR { get; set; }
        public decimal TallaAlNacerCM { get; set; }
        public decimal PerimetroCefalicoCM { get; set; }
        public string PatologiasPernatales { get; set; }
        public short DiasHospitalizacion { get; set; }
        public short IdTipoLecheHasta6meses { get; set; }
        public string AntecLactancia { get; set; }
        public short EdadInicioAblactanciaMeses { get; set; }
        public string DesarrolloSicomotriz { get; set; }
        public System.DateTime FechaUltimaRegla { get; set; }
        public System.DateTime FechaUltimoPeriodo { get; set; }
        public string MetodosAnticonceptivos { get; set; }
        public string Menarquia { get; set; }
        public string Menopausia { get; set; }
        public string CaracteristicasMenstruaciones { get; set; }
        public string InformacionEmbarazos { get; set; }
        public string Transfusiones { get; set; }
        public System.DateTime DeinmunizFechaAproximada { get; set; }
        public int DeinmunizEdadAproximada { get; set; }
        public string Alcohol { get; set; }
        public string Tabaco { get; set; }
        public string Drogas { get; set; }
        public string ActividadFisica { get; set; }
        public string ConsumoVerduras { get; set; }
        public string ConsumoFrutas { get; set; }
        public string Medicamentos { get; set; }
        public string Alimentos { get; set; }
        public string SustanciasEnElAmbiente { get; set; }
        public string SustanciasContactoConPiel { get; set; }
        public string ContactoPersonaEnferma { get; set; }
        public string CrianzaAnimalesDomesticos { get; set; }
        public string AguaPotable { get; set; }
        public string DisposicionExcretas { get; set; }
        public string ReaccionAdversaMedicamentos { get; set; }
        public string SaludBucal { get; set; }
        public string VigilanciaDeCrecimiento { get; set; }
        public string VigilanciaDelDesarrollo { get; set; }
        public short IdValoracionFuncional1 { get; set; }
        public short IdValoracionFuncional2 { get; set; }
        public short IdValoracionFuncional3 { get; set; }
        public short IdValoracionFuncional4 { get; set; }
        public short IdValoracionFuncional5 { get; set; }
        public short IdValoracionFuncional6 { get; set; }
        public short DiagnosticoFuncional { get; set; }
        public short IdEstadoCognitivo1 { get; set; }
        public short IdEstadoCognitivo2 { get; set; }
        public short IdEstadoCognitivo3 { get; set; }
        public short IdEstadoCognitivo4 { get; set; }
        public short IdEstadoCognitivo5 { get; set; }
        public short IdEstadoCognitivo6 { get; set; }
        public short IdEstadoCognitivo7 { get; set; }
        public short IdEstadoCognitivo8 { get; set; }
        public short IdEstadoCognitivo9 { get; set; }
        public short IdEstadoCognitivo10 { get; set; }
        public short ValoracionCognitiva { get; set; }
        public short IdEstadoAfectivo1 { get; set; }
        public short IdEstadoAfectivo2 { get; set; }
        public short IdEstadoAfectivo3 { get; set; }
        public short IdEstadoAfectivo4 { get; set; }
        public short ConManifestacionesDepresivas { get; set; }
        public short ValoracionSocioFamiliar1 { get; set; }
        public short ValoracionSocioFamiliar2 { get; set; }
        public short ValoracionSocioFamiliar3 { get; set; }
        public short ValoracionSocioFamiliar4 { get; set; }
        public short ValoracionSocioFamiliar5 { get; set; }
        public short ValoracionSocioFamiliar { get; set; }
        public short IdCategoriaAdutoMayor { get; set; }
        public short Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public System.DateTime FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public System.DateTime FechaModificacion { get; set; }
        public string Accion { get; set; }
        public int Secuencia { get; set; }
        public System.DateTime Fecha { get; set; }
        public int IdTabla { get; set; }
        public int IdTipoAlergia { get; set; }
        public string Nombre { get; set; }
        public string Lugar { get; set; }
        public string Dosis { get; set; }
        public string Observaciones { get; set; }
        public int Expr5 { get; set; }
        public string Expr6 { get; set; }
        public System.DateTime Expr7 { get; set; }
        public string Expr8 { get; set; }
        public System.DateTime Expr9 { get; set; }
        public string TipoRegistro { get; set; }
        public string GrupoTipoDiagnosticoDesc { get; set; }
        public string GrupoTipoDiagnostico { get; set; }
        public string DiagnosticoDesc { get; set; }
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
        public string Expr104 { get; set; }
    }
}
