using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public class ViewResponse
    {
        public Boolean ok { get; set; }
        public Object msg { get; set; }
        public Nullable<int> valor { get; set; }
        public string tokem { get; set; }
    }

    public class ViewResponseContenido
    {
        public Boolean ok { get; set; }
        public Object msg { get; set; }
        public List<ExamenQur> contenido { get; set; }
        public Nullable<int> valor { get; set; }
        public string tokem { get; set; }

    }

    public class ViewResponseContenidoPaginado
    {
        public Boolean ok { get; set; }
        public Object msg { get; set; }
        public List<ExamenQur> contenido { get; set; }
        public Nullable<int> valor { get; set; }
        public string tokem { get; set; }
        public int total { get; set; }

    }


    public class ViewResponseContenidoMsg
    {
        public Boolean ok { get; set; }
        public Object msg { get; set; }
        public Nullable<int> valor { get; set; }
        public string tokem { get; set; }

    }
}
