using SoluccionSalud.Bussines.BLLRecursos;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.RecursosService
{
    public class SvcRecursos
    {
        public static List<SS_HC_FormatoRecursoCampo> listarRecursos(SS_HC_FormatoRecursoCampo objSC, int inicio, int final)
        {
            return new RecursosBLL().listarRecursos(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_FormatoRecursoCampo ObjTrace)
        {
            return new RecursosBLL().setMantenimiento(ObjTrace);
        }
    }
}
