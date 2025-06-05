using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLPacDoc;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.PacDocService
{
    public class SvcPacDoc
    {
        public static List<SS_HC_PacienteDocumentos> listarPacDoc(SS_HC_PacienteDocumentos objSC, int inicio, int final)
        {
            return new PacDocBLL().listarPacDoc(objSC, inicio, final);
        }
        public static int setMantenimiento(SS_HC_PacienteDocumentos ObjTrace)
        {
            return new PacDocBLL().setMantenimiento(ObjTrace);
        }
    }
}
