using SoluccionSalud.Bussines.BLLSeguridadConceptos;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.SeguridadConceptoService
{
    public class SvcSeguridadConcepto
    {
        public static List<SS_CHE_VistaSeguridad> ListarSeguridadOpcion(SS_CHE_VistaSeguridad objSC, int inicio, int final)
        {
            return new SeguridadConceptosBLL().ListarSeguridadOpcion(objSC, inicio, final);
        }
        public static List<SS_CHE_VistaSeguridad> ListarSeguridadOpcion(SS_CHE_VistaSeguridad objSC)
        {
            if (objSC == null)
            {
                objSC = new SS_CHE_VistaSeguridad();
            }
            objSC.Accion= "LISTAPROCESOGENERAL";
            return new SeguridadConceptosBLL().ListarSeguridadOpcion(objSC,0,0);
        }
        public static List<SEGURIDADCONCEPTO> listarSeguridadConcepto(SEGURIDADCONCEPTO objSC, int inicio, int final)
        {
            return new SeguridadConceptosBLL().listarSeguridadConcepto(objSC, inicio, final);
        }
        public static int setMantenimiento(SEGURIDADCONCEPTO ObjTrace)
        {
            return new SeguridadConceptosBLL().setMantenimiento(ObjTrace);
        }

        public static List<SEGURIDADCONCEPTO> listarSeguridadConceptoAccion(SEGURIDADCONCEPTO objSC, String accion)
        {
            if (objSC == null)
            {
                objSC = new SEGURIDADCONCEPTO();
            }
            objSC.ACCION = accion;
            return new SeguridadConceptosBLL().listarSeguridadConcepto(objSC,0,0);
        }
    }
}
