using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using System.Diagnostics;


namespace SoluccionSalud.Componentes
{
    public class EventLog
    {
        public void LogError(Exception vobjException)
        {
            this.LogError(vobjException, string.Empty);
        }

        public void LogError(Exception vobjException, string vstrAdditionalInfo)
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

            this.LogData(string.Format(strMessage, vobjException.Message, vobjException.StackTrace,
                    vstrAdditionalInfo), TraceEventType.Error);

            Exception objInnerException = vobjException.InnerException;
            while (objInnerException != null)
            {
                objInnerException = objInnerException.InnerException;

                this.LogData(string.Format(strMessage, objInnerException.Message, objInnerException.StackTrace,
                    vstrAdditionalInfo), TraceEventType.Error);
            }
        }
        public void LogData(string vstrMessage, TraceEventType enmEventType)
        {
            LogEntry objLog = new LogEntry();
            objLog.Message = vstrMessage;
            objLog.Categories.Add("General");
            objLog.Severity = enmEventType;
            objLog.EventId = 100;
            objLog.Priority = 1;

            Microsoft.Practices.EnterpriseLibrary.Logging.Logger.Write(objLog);

        }
    }
}
