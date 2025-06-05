using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    [Serializable()]
    public partial class AV_SOA_Service
    {
        public Nullable<int> IdCita { get; set; }
        public Nullable<System.DateTime> FechaCita { get; set; }
        public Nullable<int> IndicadorExcedente { get; set; }
        public int INDICADORHISTORIACLINICA { get; set; }
        public Nullable<int> TipoCita { get; set; }
        public Nullable<decimal> DuracionPromedio { get; set; }
        public Nullable<decimal> DuracionReal { get; set; }
        public string Comentario { get; set; }
        public Nullable<int> Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public int PacientesIDS { get; set; }
        public string IDPACIENTE_NOMBRE { get; set; }
        public string Direccion { get; set; }
        public string Telefono { get; set; }
        public string Celular { get; set; }
        public string ApellidoPaterno { get; set; }
        public string ApellidoMaterno { get; set; }
        public string Nombres { get; set; }
        public string CodigoHC { get; set; }
        public string CodigoHCAnterior { get; set; }
        public string RutaFoto { get; set; }
        public string TipoTurno { get; set; }
        public Nullable<int> Medico { get; set; }
        public Nullable<int> Periodo { get; set; }
        public Nullable<int> IdConsultorio { get; set; }
        public string IDCONSULTORIO_CODIGO { get; set; }
        public string MEDICO_NOMBRE { get; set; }
        public int IdOrdenAtencion { get; set; }
        public Nullable<int> EstadoDocumento { get; set; }
        public Nullable<int> TipoAtencion { get; set; }
        public Nullable<int> Modalidad { get; set; }
        public string GRUPOATENCION_NOMBRE { get; set; }
        public int Linea { get; set; }
        public Nullable<int> Especialidad { get; set; }
        public string ESPECIALIDAD_NOMBRE { get; set; }
        public Nullable<int> IndicadorSeguimiento { get; set; }
        public Nullable<int> IdConsultaExternaInicial { get; set; }
        public Nullable<int> IdConsultaExterna { get; set; }
        public Nullable<int> TipoPaciente { get; set; }
        public string Situacion { get; set; }
        public Nullable<System.DateTime> FechaConsulta { get; set; }
        public Nullable<int> Pool { get; set; }
        public Nullable<int> IdServicio { get; set; }
        public string CodigoOA { get; set; }
        public Nullable<System.DateTime> FechaInicio { get; set; }
        public Nullable<int> INDTOPICO { get; set; }
        public Nullable<int> IdTopico { get; set; }
        public Nullable<int> IndHospitalizado { get; set; }
        public string UnidadReplicacion { get; set; }
        public Nullable<int> TomoActual { get; set; }
        public Nullable<int> Prioridad { get; set; }
        public Nullable<System.DateTime> FechaFinal { get; set; }
        public Nullable<int> IdPolizaPlan { get; set; }
        public Nullable<int> IdEmpresaAseguradora { get; set; }
        public Nullable<int> IdContrato { get; set; }
        public Nullable<int> IdPoliza { get; set; }
        public Nullable<int> IdPlan { get; set; }
        public Nullable<int> IdCobertura { get; set; }
        public Nullable<int> IdHorario { get; set; }
        public Nullable<int> IdCitaRelacionada { get; set; }
        public Nullable<System.DateTime> FechaCitaFecha { get; set; }
        public Nullable<int> MotivoCita { get; set; }
        public Nullable<int> IdTurno { get; set; }
        public Nullable<System.DateTime> HoraInicio { get; set; }
        public Nullable<System.DateTime> HoraFin { get; set; }
        public Nullable<int> EstadoDocumentoCita { get; set; }
        public Nullable<int> TipoParentesco { get; set; }
        public Nullable<int> EstadoOrdenServicio { get; set; }
        public Nullable<System.DateTime> Expr1 { get; set; }
        public Nullable<System.DateTime> FechaFin { get; set; }
        public Nullable<System.DateTime> FechaInicioHorario { get; set; }
        public Nullable<System.DateTime> FechaFinHorario { get; set; }
        public Nullable<int> TipoOrdenAtencion { get; set; }
        public Nullable<int> IndicadorDisponible { get; set; }
        public int IdPaciente { get; set; }
        public Nullable<int> Persona { get; set; }
    }

}

