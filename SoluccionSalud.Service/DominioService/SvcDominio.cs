using SoluccionSalud.Bussines.BLLDominio;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace SoluccionSalud.Service.DominioService
{   
    public class SvcDominio

    {
        public static List<SS_HC_DominioPAE> listardominio(SS_HC_DominioPAE objSC, int inicio, int final)
        {
            return new DominioBLL().listardominio(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_DominioPAE ObjTrace)
        {
            return new DominioBLL().setMantenimiento(ObjTrace);
        }
        
    }
}
