//using SoluccionSalud.Bussines.BLLTablaMaestroConcepto;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.TablaMaestroConceptoService
{
    public class SvcTablaMaestroConcepto
    {
        //public static List<CM_CO_TablaMaestroConcepto> listarTablaMaestroConcepto(CM_CO_TablaMaestroConcepto objSC)
        //{
        //    return new TablaMaestroConceptoBLL().listarTablaMaestroConcepto(objSC);
        //}

        public static List<CM_CO_TablaMaestroConcepto> listarTablaMaestroConcepto(CM_CO_TablaMaestroConcepto objSC, String accion)
        {
            if (objSC == null)
            {
                objSC = new CM_CO_TablaMaestroConcepto();
            }
            objSC.Accion = accion;
            return null;
        }
    }
}
