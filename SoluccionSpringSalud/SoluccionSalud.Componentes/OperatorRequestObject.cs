using System;
using System.Collections.Generic;
 
using System.Text;
 

namespace SoluccionSalud.Componentes
{
     [Serializable]
    public class OperatorRequestObject
    {
        string shortcode;

        public string Shortcode
        {
            get { return shortcode; }
            set { shortcode = value; }
        }

    }
}
