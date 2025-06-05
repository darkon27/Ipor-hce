using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    [Serializable()]
    public partial class BE_ENFERMEDADACTUAL
    {
        public string EACT_MOTIVOCONSULTA { get; set; }
        public string EACT_FORMAINICIO { get; set; }
        public string EACT_CURSOENFERMEDAD { get; set; }
        public string EACT_TIEMPOENFERMEDA { get; set; }
        public string EACT_SINTOMASSIGNOS { get; set; }
        public string EACT_RELATOCRONOLOG { get; set; }
        public string EACT_APETITO { get; set; }
        public string EACT_SET { get; set; }
        public string EACT_ORINA { get; set; }

        public string EACT_DEPOSICIONES { get; set; }
        public string EACT_SUENO { get; set; }
        public string EACT_PESOANTERIOR { get; set; }
        public string EACT_PROBLEMASINFANCIA { get; set; }
        public string EACT_EVALALIMENTACIONACT { get; set; }
 
    }


}
