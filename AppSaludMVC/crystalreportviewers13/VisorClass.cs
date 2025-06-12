using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AppSaludMVC.Controllers
{
    class VisorClass
    {
        public int Accion { get; set; }
        public string tipoDocumento { get; set; }
        public string Documento { get; set; }
        public string IdOrdenAtencion { get; set; }
        public string cod_sucursal { get; set; }
        public DateTime FechaInicio { get; set; }
        public DateTime FechaFin { get; set; }
    }
}
