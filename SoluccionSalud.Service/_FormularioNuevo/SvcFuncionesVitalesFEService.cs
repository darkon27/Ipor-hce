using Newtonsoft.Json;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;
using System;
using System.Collections.Generic;
using System.Linq;  
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization; 

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvcFuncionesVitalesFEService
    {

        public static int setMantenimiento(SS_HC_FuncionesVitales_FE objSC)
        {
            return new FuncionesVitalesFERepository().setMantenimiento(objSC);
        }

        public static int setMantenimientoCopia(Object item2)
        {
            var json = new JavaScriptSerializer().Serialize(item2);           
            SS_HC_FuncionesVitales_FEClaas objSCNuevo = JsonConvert.DeserializeObject<SS_HC_FuncionesVitales_FEClaas>(json);            
            return new FuncionesVitalesFERepository().setMantenimientoCopia(objSCNuevo);
        }       


        public static   SS_HC_FuncionesVitales_FE getdataFunciones(SS_HC_FuncionesVitales_FE objreqs)
        {
            return new FuncionesVitalesFERepository().obj(objreqs);
        }

        public static SS_HC_EnfermedadActual_FE getDataEnfermedadActual(SS_HC_EnfermedadActual_FE objreqs)
        {
            return new FuncionesVitalesFERepository().getDataEnfermedadActualCab(objreqs);
        }
        public static List<SS_HC_EnfermedadActualDetalle_FE> getDataEnfermedadActualDetalle(SS_HC_EnfermedadActual_FE objreqs)
        {
            return new FuncionesVitalesFERepository().getDataEnfermedadActualDet(objreqs);
        }
        
        public static List<SS_HC_FuncionesVitales_FE> listarEntidad(SS_HC_FuncionesVitales_FE objSC)
        {

            return new FuncionesVitalesFERepository().listarEntidad(objSC);
        }
                public static List<SS_HC_FuncionesVitales_FE> listarEntidadAnteFuncionesVitales(SS_HC_FuncionesVitales_FE objSC)
        {

            return new FuncionesVitalesFERepository().listarEntidadAnteFuncionesVitales(objSC);
        }

    }
}
