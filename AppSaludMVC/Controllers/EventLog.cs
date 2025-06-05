using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.UI;
using System.Text;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using System.Diagnostics;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
using System.Data.SqlClient;    
using System.Web.Security;
using System.Web.Caching;
using System.Web.Configuration;
using System.Web.Routing;
using System.Web.SessionState;
using Ext.Net;
using Serilog;

namespace AppSaludMVC.Controllers
{

    public class EventLog
    {
        static string sLogFormat;
        public static void GenerarLogError(Exception vobjException)
        {
            var sqlException = vobjException.InnerException as SqlException;
            LogEntry entry = new LogEntry();
            if (sqlException != null)
            {
                entry.Message = sqlException.ToString();
            }
            else
            {
                entry.Message = vobjException.ToString();
            }
            //Logger.Write(entry);
        }
        public static void LogError(Exception vobjException)
        {
            LogError(vobjException, string.Empty);
        }

        public static void LogError(Exception vobjException, string vstrAdditionalInfo)
        {
            string strMessage = "ERROR MESSAGE: {0}" +
                             Environment.NewLine + Environment.NewLine +
                             "STACKTRACE: {1}" +
                             Environment.NewLine + Environment.NewLine +
                             "ADDITIONAL INFO: {2}";

            if (string.IsNullOrEmpty(vstrAdditionalInfo))
            {
                vstrAdditionalInfo = "None";
            }

            LogData(string.Format(strMessage, vobjException.Message, vobjException.StackTrace,
                    vstrAdditionalInfo), TraceEventType.Error);

            Exception objInnerException = vobjException.InnerException;
            while (objInnerException != null)
            {
                objInnerException = objInnerException.InnerException;

                LogData(string.Format(strMessage, objInnerException.Message, objInnerException.StackTrace,
                    vstrAdditionalInfo), TraceEventType.Error);
            }
        }

        public static void LogData(string vstrMessage, TraceEventType enmEventType)
        {

            StreamWriter log;
            FileStream fileStream = null;
            DirectoryInfo logDirInfo = null;
            FileInfo logFileInfo;

            string logFilePath = Path.GetFullPath("\\Logs\\");
            logFilePath = logFilePath + "Log-" + System.DateTime.Today.ToString("dd-MM-yyyy") + "." + "txt";
            logFileInfo = new FileInfo(logFilePath);
            logDirInfo = new DirectoryInfo(logFileInfo.DirectoryName);
            if (!logDirInfo.Exists) logDirInfo.Create();
            if (!logFileInfo.Exists)
            {
                fileStream = logFileInfo.Create();
            }
            else
            {
                fileStream = new FileStream(logFilePath, FileMode.Append);
            }
            log = new StreamWriter(fileStream);
            log.WriteLine(System.DateTime.Now + " | " + vstrMessage);
            log.Close();
            //CreateLogFiles();           
            //StreamWriter sw = new StreamWriter("Error" + sErrorTime, true);
            //sw.WriteLine(sLogFormat + vstrMessage);
            //sw.Flush();
            //sw.Close();

            //  string pagina;
            //Exception Err = Server.GetLastError();
            //Server.ClearError();
            //// pass exception to the page via url paramters 
            //CreateLogFiles RegistraLog = new CreateLogFiles();
            ////pagina = Request.Url.ToString();
            ////pagina = pagina + " -> " + Err.Message;
            //pagina = " -> " + Err.StackTrace;
            //string paths = "~/resources/DocumentosAdjuntos/";
            //paths = Server.MapPath(paths);

            //RegistraLog.ErrorLog(Server.MapPath("../../ErrorLog"), pagina);
            //Response.Redirect(Request.Url.ToString() + "?Erro = " + Err.Message);

            /*  Logger.SetLogWriter(new LogWriterFactory().Create());
               LogEntry entry = new LogEntry();
               entry.Message = "I am logging";
               Logger.Write(entry);
             
               LogEntry objLog = new LogEntry();
               objLog.Message = vstrMessage;
               objLog.Categories.Add("General");
               objLog.Severity = enmEventType;
               objLog.EventId = 100;
               objLog.Priority = 1;
               Logger.SetLogWriter(objLog, true);
                Logger.Write(objLog,
                /* */
        }
        //private static void logSeri()
        //{
        //    var log = new LoggerConfiguration()
        //    .WriteTo.Console()
        //    .WriteTo.File("logs\\myapp.txt", rollingInterval: )
        //    .CreateLogger();
        //    log.Information("Prueba Informacion");
        //    log.Debug("Prueba Debug");
        //    log.Warning("Prueba Warning");
        //    log.Error("Prueba Error");
        //    log.Fatal("Prueba Fatal");
        //}

        public static void CreateLogFiles()
        {
            
            string sErrorTime;

            //sLogFormat used to create log files format :
            // dd/mm/yyyy hh:mm:ss AM/PM ==> Log Message
            sLogFormat = DateTime.Now.ToShortDateString().ToString() + " " + DateTime.Now.ToLongTimeString().ToString() + " ==> ";

            //this variable used to create log filename format "
            //for example filename : ErrorLogYYYYMMDD
            string sYear = DateTime.Now.Year.ToString();
            string sMonth = DateTime.Now.Month.ToString();
            string sDay = DateTime.Now.Day.ToString();
            sErrorTime = sYear + sMonth + sDay;

            //return sErrorTime;
        }
    }
}