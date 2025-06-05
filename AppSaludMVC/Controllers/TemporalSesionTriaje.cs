using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AppSaludMVC.Controllers
{
    public class TemporalSesionTriaje
    {
        public string UnidadReplicacion { get; set; }
        public Nullable<int> IdPaciente { get; set; }
        public Nullable<int> IdEpisodioTriaje { get; set; }
        public string CodigoOT { get; set; }
        public Nullable<int> IdPersonalSalud { get; set; }
        public Nullable<System.DateTime> FechaAtencion { get; set; }


        public Nullable<int> IdEspecialidad { get; set; }

        public string Nombre { get; set; }
        public int IdPrioridad { get; set; }
        public Nullable<System.DateTime> FechaFirma { get; set; }


        public int IdMedicoFirma { get; set; }
        public string ObservacionFirma { get; set; }

        public string Accion { get; set; }
        public string Version { get; set; }
        public int Estado { get; set; }
        public string UsuarioCreacion { get; set; }

        public string UsuarioModificacion { get; set; }

        public Nullable<System.DateTime> FechaModificacion { get; set; }

        public int EpisodioClinico { get; set; }
        public int TipoAtencion { get; set; }
        public string CodigoOA { get; set; }
        public int Cama { get; set; }
        public string MedicoNombre { get; set; }
        public int IdOrdenAtencion { get; set; }

        public int LineaOrdenAtencion { get; set; }
        public int Modalidad { get; set; }
        public int Comentarios { get; set; }
        public int IdMedico { get; set; }
        public int EstadoEpiAtencion { get; set; }
        public string PacienteNombre { get; set; }

        public string NombreEspecialidad { get; set; }
        public int EpisodioClinicoHCE { get; set; }



    }

}
