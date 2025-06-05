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
    public class SvnOrdenIntervencionQuirurgicaService
    {

        public static int setMantenimientoActualizado(SS_HC_OrdenIntervencionQuirurgicaCab_FE ObjTraces, List<SS_HC_OrdenInterQuiruDiagnosticoDetalle_FE> ObjDetalle,
            List<SS_HC_OrdenInterQuiruExamenApoyoDetalle_FE> ObjDetalle2,
            List<SS_HC_OrdenInterQuiruExamenApoyoDetalle_FE> ObjDetalleDos,
            List<SS_HC_OrdenInterQuiruExamenApoyoDetalle_FE> ObjDetalleUsoEqui,
                 List<SS_HC_OrdenInterQuiruExamenApoyoDetalle_FE> ObjDetalleMatEspe,string tiempo, string fechainter
            )
        {
            return new OrdenIntervencionQuirurgica_FERepository().SetMantenimientoActualizado(ObjTraces, ObjDetalle, ObjDetalle2, ObjDetalleDos, ObjDetalleUsoEqui, ObjDetalleMatEspe, tiempo, fechainter);
        }

        public static List<SS_HC_OrdenIntervencionQuirurgicaCab_FE> listarEntidad(SS_HC_OrdenIntervencionQuirurgicaCab_FE objSC)
        {
            return new OrdenIntervencionQuirurgica_FERepository().listarEntidad(objSC);
        }

        public static List<SS_HC_OrdenIntervencionQuirurgicaCab_FE> listarOrdenIntervencion(SS_HC_OrdenIntervencionQuirurgicaCab_FE objSC)
        {
            return new OrdenIntervencionQuirurgica_FERepository().listarOrdenIntervencion(objSC);
        }
        


    }
}
