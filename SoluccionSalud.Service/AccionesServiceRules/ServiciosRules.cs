//using SoluccionSalud.Business.Rule.Rules;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.AccionesServiceRules
{
    public class ServiciosRules
    {
        
        public static MA_MiscelaneosDetalleRule POSaludDiagnosticoInformado(MA_MiscelaneosDetalleRule objtrace)
        {
            return null;
            //return new BusinessRule().POSaludDiagnosticoInformado(objtrace);
        }
        public static MA_MiscelaneosDetalleRule POSaludConsultaMes(MA_MiscelaneosDetalleRule objtrace)
        {
            return null;
            //return new BusinessRule().POSaludConsultaMes(objtrace);
        }
            public static MA_MiscelaneosDetalleRule POSaludExamenLaboratorio(MA_MiscelaneosDetalleRule objtrace)
        {
            return null;
            //return new BusinessRule().POSaludExamenLaboratorio(objtrace);
        }
        public static MA_MiscelaneosDetalleRule POSaludEmergenciaEspera(MA_MiscelaneosDetalleRule objtrace)
        {
            return null;
            //return new BusinessRule().POSaludEmergenciaEspera(objtrace);
        }
        public static MA_MiscelaneosDetalleRule POSaludFirmaMedico(MA_MiscelaneosDetalleRule objtrace)
        {
            return null;
            //return new BusinessRule().POSaludFirmaMedico(objtrace);
        }
        public static MA_MiscelaneosDetalleRule POSaludControlGinecologia(MA_MiscelaneosDetalleRule objtrace)
        {
            return null;
            //return new usinessRule().POSaludControlGinecologia(objtrace);
        }
        public static MA_MiscelaneosDetalleRule POSaludDescansoMedico(MA_MiscelaneosDetalleRule objtrace)
        {
            //return new BusinessRule().POSaludDescansoMedico(objtrace);
            return null;
        }


        public static int getResultRule(MA_MiscelaneosDetalle objtrace)
        {
            return 0;
            //return new BusinessRule().getReglaActivaReal(objtrace);
        }
        public static int getReglaActivaReal(MA_MiscelaneosDetalle objtrace)
        {
            return 0;
            //return new BusinessRule().getReglaActivaReal(objtrace);
        }
        public static int getReglaResultadoIntero(MA_MiscelaneosDetalle objtrace)
        {
            return 0;
            //return new BusinessRule().getReglaResultadoIntero(objtrace);
        }
    }
}
