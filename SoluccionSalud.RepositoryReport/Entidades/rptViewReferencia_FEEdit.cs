using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.RepositoryReport.Entidades
{
    public class rptViewReferencia_FEEdit
    {
        public int EpisodioClinico { get; set; }
        public string UnidadReplicacion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public string NroReferencia { get; set; }
        public string P_UNO { get; set; }
        public string P_DOS { get; set; }
        public string P_TRES { get; set; }
        public string P_CUATRO { get; set; }
        public string EstablecimientoOri { get; set; }
        public string ServicioOri { get; set; }
        public string EstablecimientoDest { get; set; }
        public string ServicioDest { get; set; }
        public string IdentificacionUsu { get; set; }
        public string Anamnesis { get; set; }
        public string EstadoGeneral { get; set; }
        public string Glasgow { get; set; }
        public string FV_T { get; set; }
        public string FV_PA { get; set; }
        public string FV_FR { get; set; }
        public string FV_FC { get; set; }
        public string Exam_aux { get; set; }
        public string Motivo { get; set; }
        public string DR_EMERGENCIA { get; set; }
        public string DR_CONSULTA_EXTERNA { get; set; }
        public string DR_HOSPITALIZACION { get; set; }
        public string FechaReferencia { get; set; }
        public string HoraReferencia { get; set; }
        public string PersonaAtiende { get; set; }
        public string CS_ESTABLE { get; set; }
        public string CS_INESTABLE { get; set; }
        public string MedicoSanna { get; set; }
        public string MedicoAtencion { get; set; }
        public string Respon_ref { get; set; }
        public string Colegiatura_ref { get; set; }
        public string Respon_serv { get; set; }
        public string Colegiatura_ser { get; set; }
        public string Respon_acomp { get; set; }
        public string Colegiatura_acomp { get; set; }
        public string Respon_recibe { get; set; }
        public string Colegiatura_recib { get; set; }
        public string CLL_ESTABLE { get; set; }
        public string CLL_INESTABLE { get; set; }
        public string CLL_FALLECIDO { get; set; }
        public string DIAGNOSTICO { get; set; }
    }
}
