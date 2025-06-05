using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALFormularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLFormularios
{ 
    public class ProblemasBLL
    {
        public int setMantenimiento(SS_HC_Problema objSC)
        {
            return new ProblemasRepository().setMantenimiento(objSC);
        }
        public List<SS_HC_Problema> ProblemasListar(SS_HC_Problema ObjTrace)
        {
            return new ProblemasRepository().ProblemasListar(ObjTrace);
        }
    }
}
