using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace SPRING_Restaurantes_RestServer1
{
    public static class Bd_Configuracion
    {
        public static string cadenaSQL = WebConfigurationManager.ConnectionStrings["ClinicaElGolfEntities"].ConnectionString;



    }
}