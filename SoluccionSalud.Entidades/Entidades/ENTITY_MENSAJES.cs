using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace SoluccionSalud.Entidades.Entidades
{
    [Serializable()]
    public partial class ENTITY_MENSAJES
    {
        public Nullable<int> IDMSG { get; set; }
        public String TIPOMSG { get; set; }
        public String DESCRIPCION { get; set; }
        public String TITULO { get; set; }
        public String IDCOMPONENTE { get; set; }

        public String ICON { get; set; }
        public String USUARIO { get; set; }
        public String EXCEPTION { get; set; }
        public Nullable<int> ESTADORETORNO { get; set; }
        public Nullable<bool> ESTADOBOOL { get; set; }
        public Nullable<int> NIVEL { get; set; }
        public Object OBJETO_DATA { get; set; }

        public static ENTITY_MENSAJES Instance
        {
            get
            {
                ENTITY_MENSAJES obj = (ENTITY_MENSAJES)HttpContext.Current.Session["ENTITY_MENSAJES"];
                return obj;
            }
        }
    }
}
