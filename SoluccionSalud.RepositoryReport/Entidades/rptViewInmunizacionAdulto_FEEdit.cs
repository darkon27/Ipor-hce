using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.RepositoryReport.Entidades
{
    public partial class rptViewInmunizacionAdulto_FEEdit
    {
        public string UnidadReplicacion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public int CodigoSecuencia { get; set; }
        public string SI { get; set; }
        public string NO { get; set; }
        public string DPT_1era { get; set; }
        public string DPT_2da { get; set; }
        public string DPT_3era { get; set; }
        public string DPT_NoRecuerda { get; set; }
        public string SRP_1era { get; set; }
        public string SRP_NoRecuerda { get; set; }
        public string VARICELA_1era { get; set; }
        public string VARICELA_NoRecuerda { get; set; }
        public string HEPATITISB_1era { get; set; }
        public string HEPATITISB_2da { get; set; }
        public string HEPATITISB_3era { get; set; }
        public string HEPATITISB_1erRef { get; set; }
        public string HEPATITISB_NoRecuerda { get; set; }
        public string HEPATITISA_1era { get; set; }
        public string HEPATITISA_2da { get; set; }
        public string HEPATITISA_NoRecuerda { get; set; }
        public string NEUMOCOCO_1era { get; set; }
        public string NEUMOCOCO_2da { get; set; }
        public string NEUMOCOCO_3era { get; set; }
        public string NEUMOCOCO_NoRecuerda { get; set; }
        public string Antitetanica_1era { get; set; }
        public string Antitetanica_2da { get; set; }
        public string Antitetanica_3era { get; set; }
        public string Antitetanica_NoRecuerda { get; set; }
        public string Papiloma_1era { get; set; }
        public string Papiloma_2da { get; set; }
        public string Papiloma_3era { get; set; }
        public string Papiloma_NoRecuerda { get; set; }
        public System.DateTime INFLUENZA { get; set; }
        public int Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public System.DateTime FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public System.DateTime FechaModificacion { get; set; }
        public string Accion { get; set; }
        public string Version { get; set; }
        public long IdEpisodioAtencionDet { get; set; }
        public int IdPacienteDet { get; set; }
        public int EpisodioClinicoDet { get; set; }
        public string UnidadReplicacionDet { get; set; }
        public int Secuencia { get; set; }
        public string OtrasVacunas { get; set; }
        public string UsuarioCreacionDet { get; set; }
        public System.DateTime FechaCreacionDet { get; set; }
        public string UsuarioModificacionDet { get; set; }
        public System.DateTime FechaModificacionDet { get; set; }
        public string AccionDet { get; set; }
        public string VersionDet { get; set; }
    }
}
