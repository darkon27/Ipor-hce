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
    public class SvcAnamnesisAFFEService
    {

        public static List<SS_HC_Anamnesis_AFAM_CAB_FE> listarEntidad(SS_HC_Anamnesis_AFAM_CAB_FE objSC)
        {
            return new AnamnesisAFFERepository().listarEntidad(objSC);
        }
        public static List<SS_HC_Anamnesis_AFAM_FE> AnamnesisAFListar(SS_HC_Anamnesis_AFAM_FE ObjTrace)
        {
            //return new AnamnesisAFBLL().AnamnesisAFListar(ObjTrace);
            return new AnamnesisAFFERepository().AnamnesisAFListar(ObjTrace);
        }

        public static List<SS_HC_Anamnesis_AFAM_FE> AnamnesisAFListarTOP(SS_HC_Anamnesis_AFAM_FE ObjTrace)
        {
            //return new AnamnesisAFBLL().AnamnesisAFListar(ObjTrace);
            return new AnamnesisAFFERepository().AnamnesisAFListarTOP(ObjTrace);
        }
        public static long setMantAnamnesisAF(SS_HC_Anamnesis_AFAM_CAB_FE ObjTraces, SS_HC_Anamnesis_AFAM_FE objSC, List<SS_HC_Anamnesis_AFAM_FE> Cabecera, List<SS_HC_Anamnesis_AFAM_Enfermedad_FE> Detalle)
        {
            return new AnamnesisAFFERepository().setMantAnamnesisAF(ObjTraces, objSC, Cabecera, Detalle);
        }
        public static List<SS_HC_Anamnesis_AFAM_CAB_FE> listarEntidadTOP(SS_HC_Anamnesis_AFAM_CAB_FE objSC)
        {
            return new AnamnesisAFFERepository().listarEntidadTOP(objSC);
        }
    }
}
