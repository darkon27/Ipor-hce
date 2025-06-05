using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class Svc_EpidemiologiaCovid19ServiceFE
    {



        public static List<SS_HC_Epidemiologia_FE> listarEntidad(SS_HC_Epidemiologia_FE objSC)
        {

            return new EpidemiologiaCovid19FERepository().listarEntidad(objSC);
        }


        public static int setMantenimiento(SS_HC_Epidemiologia_FE objSC, List<SS_HC_EpidemiologiaDetalleLugar_FE> ObjDetalle, List<SS_HC_EpidemiologiaDetalleCasos_FE> ObjCasosDetalle2)
        {
            return new EpidemiologiaCovid19FERepository().setMantenimiento(objSC, ObjDetalle, ObjCasosDetalle2);
        }



    }
}
