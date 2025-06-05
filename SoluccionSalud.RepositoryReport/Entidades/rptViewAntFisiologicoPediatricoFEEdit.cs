using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.RepositoryReport.Entidades
{
    public partial class rptViewAntFisiologicoPediatricoFEEdit
    {

        public string UnidadReplicacion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public int IdAntFiPediatrico { get; set; }
        public int EdadMaterna { get; set; }
        public int Paridad_1 { get; set; }
        public int Paridad_2 { get; set; }
        public int Paridad_3 { get; set; }
        public int Paridad_4 { get; set; }
        public int Gravidez { get; set; }
        public int ControlPrenatal { get; set; }
        public string Complicaciones { get; set; }
        public int TipoParto { get; set; }
        public string MotivoCesarea { get; set; }
        public string LugarNacimiento { get; set; }
        public decimal Peso { get; set; }
        public int PesoNR { get; set; }
        public decimal Talla { get; set; }
        public int TallaNR { get; set; }
        public decimal PCNacer { get; set; }
        public int PCNacerNR { get; set; }
        public int APGAR { get; set; }
        public string DesApgar1 { get; set; }
        public string DesApgar2 { get; set; }
        public string DesApgar3 { get; set; }
        public string DesApgar4 { get; set; }
        public int Reanimacion { get; set; }
        public int Lactancia { get; set; }
        public System.DateTime InicioAblactansia { get; set; }
        public string AlimentosActuales { get; set; }
        public int Vigilancia { get; set; }
        public int Psicomotor { get; set; }
        public string DetallarPsicomotor { get; set; }
        public int Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public System.DateTime FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public System.DateTime FechaModificacion { get; set; }
        public string Accion { get; set; }
        public string Version { get; set; }
    }
}
