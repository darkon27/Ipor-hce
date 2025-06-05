

using SoluccionSalud.Bussines.BLLFormularios;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace SoluccionSalud.Service.FormulariosService
{ 
    public class SvcProblemasService
    {
        public static int setMantenimiento(SS_HC_Problema objSC)
        {
            return new ProblemasBLL().setMantenimiento(objSC);
        }
        public static List<SS_HC_Problema> ProblemasListar(SS_HC_Problema ObjTrace)
        {
            return new ProblemasBLL().ProblemasListar(ObjTrace);
        }
    }
}
