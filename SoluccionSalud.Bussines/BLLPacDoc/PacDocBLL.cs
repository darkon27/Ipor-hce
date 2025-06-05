using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALPacDoc;

namespace SoluccionSalud.Bussines.BLLPacDoc
{
    public class PacDocBLL
    {
        public List<SS_HC_PacienteDocumentos> listarPacDoc(SS_HC_PacienteDocumentos objSC, int inicio, int final)
        {
            return new PacDocRepository().listarPacDoc(objSC, inicio, final);
        }
        public int setMantenimiento(SS_HC_PacienteDocumentos ObjTrace)
        {
            return new PacDocRepository().setMantenimiento(ObjTrace);
        }
    }
}
