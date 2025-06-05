using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AppSaludMVC.Models
{
    public class ClassLdap
    {
        public string ClassName { get; set; }
        public string Message { get; set; }
        public string Data { get; set; }
        public string InnerException { get; set; }
        public string HelpURL { get; set; }
        public string StackTraceString { get; set; }
        public string RemoteStackTraceString { get; set; }
        public string ExceptionMethod { get; set; }
        public string Source { get; set; }
        public string WatsonBuckets { get; set; }
        public int RemoteStackIndex { get; set; }
        public long HResult { get; set; }
    }
}