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
    public class SvcVigilanciaCateterUrinarioFEService
    {
        public static int setMantenimiento(SS_HC_ENFER_VIGI_CATETERURINARIO_FE ObjSave)
        {
            return new VigilanciaCateterUrinarioFERepository().setMantenimiento(ObjSave);
        }

        public static List<SS_HC_ENFER_VIGI_CATETERURINARIO_FE> listarSS_HC_ENFER_VIGI_CATETERURINARIO_FE(SS_HC_ENFER_VIGI_CATETERURINARIO_FE objSC)
        {
            return new VigilanciaCateterUrinarioFERepository().listarSS_HC_ENFER_VIGI_CATETERURINARIO_FE(objSC);
        }

    }
}