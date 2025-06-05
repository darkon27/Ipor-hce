using System.Configuration;

namespace SoluccionSalud.Entidades.Entidades
{
    public class sisConstante
    {
        public const string Session_ErrorManualController = "Session_ErrorManualController";
        public const string Session_ErrorManualAction = "Session_ErrorManualAction";
        public const string Session_ErrorManualNumero = "Session_ErrorManualNumero";
        public const string Session_ErrorManualDescripcion = "Session_ErrorManualDescripcion";


        //Control de errores
        public const int InternalServerError = 500;
        public const string ManejoErrorSinSesion = "0@";
        public const string ManejoErrorRolInvalido = "1@";
        public const string ManejoErrorBaseDatos = "2@";
        public const string ManejoErrorUnAutorizado = "401@";
        public const string ManejoErrorNoAutorizado = "403@";
        public const string ManejoErrorPaginaNoExiste = "404@";
        public const string ManejoErrorJSon = "ErrorJSON@";
        public const string ErrorJSON01 = "65000@";


    }
}
