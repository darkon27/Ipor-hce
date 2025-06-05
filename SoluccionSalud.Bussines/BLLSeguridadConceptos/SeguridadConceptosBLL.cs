using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALSeguridadConcepto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLSeguridadConceptos
{
    public class SeguridadConceptosBLL
    {

       
         public List<SS_CHE_VistaSeguridad> ListarSeguridadOpcion(SS_CHE_VistaSeguridad objSC, int inicio, int final)
        {
            return new SeguridadConceptoRepository().ListarSeguridadOpcion(objSC, inicio, final);
        }
        public List<SEGURIDADCONCEPTO> listarSeguridadConcepto(SEGURIDADCONCEPTO objSC, int inicio, int final)
        {
            return new SeguridadConceptoRepository().listarSeguridadConcepto(objSC, inicio, final);
        }

        public int setMantenimiento(SEGURIDADCONCEPTO ObjTrace)
        {
            return new SeguridadConceptoRepository().setMantenimiento(ObjTrace);
        }
    }
}
