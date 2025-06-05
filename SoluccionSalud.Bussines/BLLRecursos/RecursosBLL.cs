using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALRecursos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLRecursos
{
    public class RecursosBLL
    {
        public List<SS_HC_FormatoRecursoCampo> listarRecursos(SS_HC_FormatoRecursoCampo objSC, int inicio, int final)
        {
            return new RecursosRepository().listarRecursos(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_FormatoRecursoCampo ObjTrace)
        {
            return new RecursosRepository().setMantenimiento(ObjTrace);
        }
    }
}
