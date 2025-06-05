using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Ext.Net;
using Ext.Net.MVC;

using Apache.NMS;
using Apache.NMS.ActiveMQ;
using Apache.NMS.Util;
 

using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Service.SeguridadService;
using SoluccionSalud.Service.DiccionarioService;
 
namespace AppSaludMVC.Controllers
{
    using AppSaludMVC.Models;
    using SoluccionSalud.Service.PersonaMastService;
    using SvcDiccionario = SoluccionSalud.Service.DiccionarioService.SvcDiccionario;
    using SvcSeguridad = SoluccionSalud.Service.SeguridadService.SvcSeguridadConcepto;
    using SoluccionSalud.Componentes;
    public class LPacientesController : System.Web.Mvc.Controller
    {

        // GET: /LPacientes/
        public System.Web.Mvc.ActionResult Index()
        {
            // reciever();
           // InitConsumer();
            
            //inicializa();
            ENTITY_GLOBAL.Instance.PacienteID = null;

            return View();
        }
        private IConnectionFactory factory;

        public void InitProducer()
        {
            try
            {
                //初始化工厂，这里默认的URL是不需要修改的
                factory = new ConnectionFactory("tcp://10.10.2.125:61616");

            }
            catch
            {
                // lbMessage.Text = "初始化失败!!";
            }
        }
        public void ConsultaCita()
        {
            InitProducer();

            using (IConnection connection = factory.CreateConnection())
            {
                //通过连接创建Session会话
                using (ISession session = connection.CreateSession())
                {
                    //通过会话创建生产者，方法里面new出来的是MQ中的Queue
                    IMessageProducer prod = session.CreateProducer(new Apache.NMS.ActiveMQ.Commands.ActiveMQQueue("ConsultaCita"));
                    //创建一个发送的消息对象
                    ITextMessage message = prod.CreateTextMessage();
                    //给这个对象赋实际的消息
                    message.Text = "Consultas....";
                    //设置消息对象的属性，这个很重要哦，是Queue的过滤条件，也是P2P消息的唯一指定属性
                    message.Properties.SetString("filter", "demo");
                    //生产者把消息发送出去，几个枚举参数MsgDeliveryMode是否长链，MsgPriority消息优先级别，发送最小单位，当然还有其他重载
                    prod.Send(message, MsgDeliveryMode.NonPersistent, MsgPriority.Normal, TimeSpan.MinValue);
                }
            }
        }
        public System.Web.Mvc.ActionResult SelectPaciente(string selection)
        {
   
            ENTITY_GLOBAL.Instance.PacienteID = Convert.ToInt32(selection.Trim());
    
            return this.Direct();
        }
        public void InitConsumer()
        {
            //创建连接工厂
            IConnectionFactory factory = new ConnectionFactory("tcp://10.10.2.125:61616");
            //通过工厂构建连接
            IConnection connection = factory.CreateConnection();
            //这个是连接的客户端名称标识
            connection.ClientId = "ConsultaCita";
            //启动连接，监听的话要主动启动连接
            connection.Start();
            //通过连接创建一个会话
            ISession session = connection.CreateSession();
            //通过会话创建一个消费者，这里就是Queue这种会话类型的监听参数设置
            IMessageConsumer consumer = session.CreateConsumer(new Apache.NMS.ActiveMQ.Commands.ActiveMQQueue("RetornoCita"), "filter='demo'");
            //注册监听事件
            consumer.Listener += new MessageListener(consumer_Listener);
            //connection.Stop();
            //connection.Close();  

        }
        public  void consumer_Listener(IMessage message)
        { 
            ITextMessage msg = (ITextMessage)message;
          
            Session["LLEGO"] = msg.Text.Trim();
           // ENTITY_GLOBAL.Instance.GRUPO = msg.Text.Trim();
           // Response.RedirectToRoute("/LPacientes/GrillaListadoPacientesActualiza/", null);
  


          //  RedirectToAction("GrillaListadoPacientesActualiza", "LPacientes");


            //RedirectToAction("Salvador");
             /* 
            •RenderViewResult, retornado cuando se llama desde el controlador a RenderView().
            •ActionRedirectResult, retornado al llamar a RedirectToAction()
            •HttpRedirectResult, que será la respuesta a un Redirect()
            */

           // GrillaListadoPacientesActualiza(1, 1, "", "", "", "", "", "");
            //异步调用下，否则无法回归主线程
            

        }
        public System.Web.Mvc.ActionResult Salvador()
        {

            return this.Direct();
        }
        public delegate void DelegateRevMessage(ITextMessage message);

        public void RevMessage(ITextMessage message)
        {
           // tbReceiveMessage.Text += string.Format(@"接收到:{0}{1}", message.Text, Environment.NewLine);
        }

        
        public System.Web.Mvc.ActionResult ActivaModuloHCE(string containerId)
        {
            if (ENTITY_GLOBAL.Instance.PacienteID != null)
            {
               
                return this.RedirectToAction("Index", "HClinica");
            }
            else {
                X.Msg.Alert("Mensage", "Seleccione a un Paciente", new MessageBoxButtonsConfig
                {
                    Yes = new MessageBoxButtonConfig
                    {
                        //Handler = "CompanyX.MessageBox_Basic.DoYes()",
                        Text = "Aceptar"
                    } 
                }).Show();
            }

            return this.Direct();
        }
        public System.Web.Mvc.ActionResult GrillaListadoPacientes(int start, int limit, string txtHC,
            string txtFecha1,string txtFecha2,string txtHCA,string txtCodigoOA,string txtPaciente)
        {
            ENTITY_GLOBAL.Instance.GRUPO = "";
            //ConsultaCita();
            var field = X.GetCmp<TextField>("txtPaciente");
            var Listar = new List<PERSONAMAST>();
            System.Collections.IEnumerable dtoArray;
            int total;
            var LocalEnty = new PERSONAMAST();
            LocalEnty.ACCION = "LISTAR";
            LocalEnty.Estado = "";

            if (ENTITY_GLOBAL.Instance.GRUPO.Length > 0) {
                var llego = "";
            } 
           // LocalEnty.NombreCompleto = txtPaciente.Trim();
            Listar = SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList();
           // Listar = SvcPersonaMast.GetSelectPersonaCitas(LocalEnty).ToList();
            //ENTITY_GLOBAL obj = (ENTITY_GLOBAL)HttpContext.Current.Session["ENTITY_GLOBAL"];
            Session["ENTITY_PACIENTE"] = Listar;
            return this.Store(Listar);
        }

        public System.Web.Mvc.ActionResult GrillaListadoPacientesActualiza()
        { 
            var field = X.GetCmp<TextField>("txtPaciente");
            var Listar = new List<PERSONAMAST>();
            System.Collections.IEnumerable dtoArray;
            int total;
            var LocalEnty = new PERSONAMAST();
            LocalEnty.ACCION = "LISTAR";
            LocalEnty.Estado = "";

            // LocalEnty.NombreCompleto = txtPaciente.Trim();
            Listar = SvcPersonaMast.GetSelectPersonaCitas(LocalEnty).ToList();
            //ENTITY_GLOBAL obj = (ENTITY_GLOBAL)HttpContext.Current.Session["ENTITY_GLOBAL"];
            Session["ENTITY_PACIENTE"] = Listar;
            return this.Store(Listar);
        }
        public System.Web.Mvc.ActionResult PanelPacientes()
        {
            return View();
        }
    
        public static void inicializa()
        {
            ENTITY_GLOBAL.Instance.PacienteID = null;
            var chHC = X.GetCmp<Checkbox>("chHC");
            chHC.Checked = true;
            var txtHC = X.GetCmp<TextField>("txtHC");
            txtHC.Disabled = true;
        }
        public PartialViewResult PanelNorth(string containerId)
        {
            return new PartialViewResult
            {
                ContainerId = containerId,
                ViewName = "PanelNorth",
                WrapByScriptTag = false
            };
        }
        public PartialViewResult PanelWest(string containerId)
        {
            return new PartialViewResult
            {
                RenderMode = RenderMode.AddTo,
                ContainerId = containerId,
                WrapByScriptTag = false // we load the view via Loader with Script mode therefore script tags is not required
            };
        }
        public PartialViewResult PanelCenter(string containerId)
        {
            return new PartialViewResult
            {
                ContainerId = containerId,
                ViewName = "PanelCenter",
                WrapByScriptTag = false,
                ClearContainer = true,
                RenderMode = RenderMode.AddTo
            };
        }
   

        public PartialViewResult PanelCentralPacientes(string containerId)
        {
            return new PartialViewResult
            {
                ContainerId = containerId,
                ViewName = "PanelCentralPacientes",
                WrapByScriptTag = false
            };
        }
        

        public PartialViewResult PanelEast(string containerId)
        {
            return new PartialViewResult
            {
                Model = ENTITY_GLOBAL.Instance,
                RenderMode = RenderMode.AddTo,
                ContainerId = containerId,
                WrapByScriptTag = false // we load the view via Loader with Script mode therefore script tags is not required
            };
        }

    }
}
