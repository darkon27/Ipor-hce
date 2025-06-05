using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace SoluccionSalud.Componentes
{
    public class UtilMVC
    {
        public static string ObtenerIP()
        {
            string IP = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            if (!string.IsNullOrEmpty(IP) && !IP.ToLower().Equals("unknown"))
            {
                string[] IPs = IP.Split(',');
                IP = IPs[0].Trim();
            }
            else
            {
                IP = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
            }

            return IP;
        }
        public static byte[] LeerArchivo(string pRutaArchivo)
        {
            byte[] buffer;
            System.IO.FileStream fileStream = new System.IO.FileStream(pRutaArchivo, System.IO.FileMode.Open, System.IO.FileAccess.Read);
            try
            {
                int tamano = (int)fileStream.Length;
                buffer = new byte[tamano];            // Crear buffer.
                int conteo;                            // Número actual de bytes leídos.
                int suma = 0;                          // Numero total de bytes leídos.

                // Leer hasta que el método de lectura regrese 0 (Se alcanzó el fin del stream, normalmente se consigue en la primera leída).
                while ((conteo = fileStream.Read(buffer, suma, tamano - suma)) > 0)
                    suma += conteo;
            }
            finally
            {
                fileStream.Close();
            }
            return buffer;
        }

        /// <summary>Método para obtener un tamaño normalizado de acuerdo a bytes.</summary>
        /// <param name="bytes"></param>
        /// <returns></returns>
        public static string ToByteString(long bytes)
        {
            if (bytes > terabyte) return (bytes / terabyte).ToString("0.00 TB");
            else if (bytes > gigabyte) return (bytes / gigabyte).ToString("0.00 GB");
            else if (bytes > megabyte) return (bytes / megabyte).ToString("0.00 MB");
            else if (bytes > kilobyte) return (bytes / kilobyte).ToString("0.00 KB");
            else return bytes + " Byte(s)";
        }

        #region Variables Privadas

        public static readonly float kilobyte = 1024;
        public static readonly float megabyte = 1024 * kilobyte;
        public static readonly float gigabyte = 1024 * megabyte;
        public static readonly float terabyte = 1024 * gigabyte;

        #endregion
    }
}
