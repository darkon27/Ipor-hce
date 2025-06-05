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
    public class SvcVigilanciaCateterPerifericoFEService
    {
        public static int setMantenimiento(SS_HC_ENFER_VIGI_CateterPeriferico_FE ObjSave)
        {
            return new VigilanciaCateterPerifericoFERepository().setMantenimiento(ObjSave);
        }

        public static List<SS_HC_ENFER_VIGI_CateterPeriferico_FE> listarSS_HC_ENFER_VIGI_CateterPeriferico_FE(SS_HC_ENFER_VIGI_CateterPeriferico_FE objSC)
        {
            return new VigilanciaCateterPerifericoFERepository().listarSS_HC_ENFER_VIGI_CateterPeriferico_FE(objSC);
        }
    }
}
