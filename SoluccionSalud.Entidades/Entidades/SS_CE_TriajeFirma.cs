using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public class SS_CE_TriajeFirma
    {
        public Nullable<int> IdTriaje { get; set; }
        public Nullable<int> Tipo { get; set; }
        public string RutaFoto { get; set; }
        public Nullable<int> Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public Nullable<int> TamañoImagen { get; set; }
        public Nullable<int> IdEpisodioTriajeHCE { get; set; }

    }
}
