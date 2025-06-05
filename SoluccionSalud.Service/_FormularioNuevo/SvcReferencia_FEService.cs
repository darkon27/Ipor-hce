using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using SoluccionSalud.Bussines;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvcReferencia_FEService
    {
        public static int setMantenimiento(SS_HC_Referencia_FE ObjTraces, List<SS_HC_ReferenciaDetalle_FE> ObjDetalle)
        {
            return new Referencia_FERepository().setMantenimiento(ObjTraces, ObjDetalle);
        }
        public static int setMantenimientoCabecera(SS_HC_Referencia_FE ObjTraces)
        {
            return new Referencia_FERepository().setMantenimientoCabecera(ObjTraces);
        }
        public static List<SS_HC_Referencia_FE> listarEntidad(SS_HC_Referencia_FE objSC)
        {
            return new Referencia_FERepository().listarEntidad(objSC);
        }
    }
}
