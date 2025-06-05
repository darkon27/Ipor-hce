using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.RepositoryReport.Entidades
{
    public class rptViewEscalaStewart_FEEdit
    {
        public string UnidadReplicacion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public int IdEscalaStewart { get; set; }
        public System.DateTime FechaIngreso { get; set; }
        public System.DateTime HoraIngreso { get; set; }
        public int FlagParametro1 { get; set; }
        public int FlagParametro2 { get; set; }
        public int FlagParametro3 { get; set; }
        public int FlagParametro4 { get; set; }
        public int FlagParametro5 { get; set; }
        public int FlagParametro6 { get; set; }
        public int FlagParametro7 { get; set; }
        public int FlagParametro8 { get; set; }
        public int FlagParametro9 { get; set; }
        public int Adicional1 { get; set; }
        public string Adicional2 { get; set; }
        public int Total { get; set; }
        public int Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public System.DateTime FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public System.DateTime FechaModificacion { get; set; }
        public string Accion { get; set; }
        public string Version { get; set; }

    }
}
