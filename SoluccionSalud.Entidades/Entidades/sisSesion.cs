using System.Web.Security;
using System.Collections.Generic;
using System.Web;


namespace SoluccionSalud.Entidades.Entidades
{
    public partial class sisSesion
    {
#region "Propiedades"

        public static object ErrorManualController
        {
            get { return Obtener(sisConstante.Session_ErrorManualController); }
            set { Asignar(sisConstante.Session_ErrorManualController, value); }
        }
        public static object ErrorManualAction
        {
            get { return Obtener(sisConstante.Session_ErrorManualAction); }
            set { Asignar(sisConstante.Session_ErrorManualAction, value); }
        }
        public static object ErrorManualNumero
        {
            get { return Obtener(sisConstante.Session_ErrorManualNumero); }
            set { Asignar(sisConstante.Session_ErrorManualNumero, value); }
        }
        public static object ErrorManualDescripcion
        {
            get { return Obtener(sisConstante.Session_ErrorManualDescripcion); }
            set { Asignar(sisConstante.Session_ErrorManualDescripcion, value); }
        }


#endregion

        #region "Metodos Privados"
        private static void Asignar(string nomRecurso, object valor)
        {
            HttpContext.Current.Session[nomRecurso] = valor;
        }

        private static object Obtener(string nomRecurso)
        {
        if (HttpContext.Current.Session[nomRecurso]==null) {
            Asignar(nomRecurso, null);
        }
        return HttpContext.Current.Session[nomRecurso];
        }

        #endregion

        #region "Metodos públicos"
        public static string GetErrorManual(string strMessage)
        {
        switch(strMessage){
            case sisConstante.ManejoErrorSinSesion: 
                /*sisSesion.ErrorManualDescripcion = "";*/
                return "Ud. ha perdido la sesión.";
            case sisConstante.ManejoErrorRolInvalido:
                /*sisSesion.ErrorManualDescripcion = "";*/
                return "Rol Inválido.";
            case sisConstante.ManejoErrorBaseDatos:
                /*sisSesion.ErrorManualDescripcion = "";*/
                return "Error de Base de Datos.";
            case sisConstante.ManejoErrorUnAutorizado:
                /*sisSesion.ErrorManualDescripcion = "";*/
                return "Página Prohibida.";
            case sisConstante.ManejoErrorNoAutorizado:
                /*sisSesion.ErrorManualDescripcion = "";*/
                return "Ud. no está autorizado.";
            case sisConstante.ManejoErrorPaginaNoExiste:
                /*sisSesion.ErrorManualDescripcion = "";*/
                return "Página no existe.";
        }
       
        return "";
   }

        public static string VSD(object pValor) 
        {
            if (pValor == null)
            {
                return "@";
            }
            else 
            {
                return pValor.ToString();
            }
        
        }

        #endregion
    }
}
