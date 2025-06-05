using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using SoluccionSalud.ModelERP_FORM;
using SoluccionSalud.Model;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository;
using System.Data.Entity; //Entity Framework
using System.Xml;
using System.Xml.Serialization;
using SoluccionSalud.Repository.Repository;
using Newtonsoft.Json;

namespace SoluccionSalud.RepositoryFormulario.DAL_Formularios
{
    public class EvolucionMedicaFERepository
    {
        Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository(); 
        public List<SS_HC_EvolucionMedica_FE> listarEvolucion(SS_HC_EvolucionMedica_FE ObjTrace)
        {

             List<SS_HC_EvolucionMedica_FE> objLista = new List<SS_HC_EvolucionMedica_FE>();
                using (var context = new ModelFormularios())
                {


                    objLista = context.USP_EvolucionMedica_FE(ObjTrace.UnidadReplicacion, Convert.ToInt32(ObjTrace.IdEpisodioAtencion),
                    ObjTrace.IdPaciente, ObjTrace.EpisodioClinico, ObjTrace.CodigoSecuencia, ObjTrace.IdOrdenAtencion,
                    ObjTrace.FechaIngreso, ObjTrace.DictamenRiesgo, ObjTrace.EvolucionObjetiva, ObjTrace.ObservacionesAdicionales,
                    ObjTrace.Medico, ObjTrace.Especialidad, ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion,
                    ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version).ToList();

                    //Agregado auditoria --> N° 2
                    using (var contextEnty = new WEB_ERPSALUDEntities())
                    {
                        SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                        List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                        dynamic DataKey;
                        DataKey = new
                        {
                            UnidadReplicacion = ObjTrace.UnidadReplicacion,
                            IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                            EpisodioClinico = ObjTrace.EpisodioClinico,
                            IdPaciente = ObjTrace.IdPaciente,
                        };

                        if (objLista.Count > 1)
                        {
                            objAudit.Type = "L";
                        }
                        else
                        {
                            objAudit.Type = "V";
                        }


                        string tempType = objAudit.Type;
                        objAudit = Control.AddAudita(new SS_HC_EvolucionMedica_FE(), new SS_HC_EvolucionMedica_FE(), DataKey, objAudit.Type);
                        String xlmIn = XMLString(objLista, "SS_HC_EvolucionMedica_FE");
                        objAudit.TableName = "SS_HC_EvolucionMedica_FE";
                        objAudit.Type = tempType;
                        objAudit.VistaData = xlmIn;
                        objAudit.Accion = ObjTrace.Accion;
                        contextEnty.Entry(objAudit).State = EntityState.Added;
                        contextEnty.SaveChanges();


          
                }
                //--

            }
            return objLista;

        }
        public virtual String XMLString(List<SS_HC_EvolucionMedica_FE> obPadre, String TablaID)
        {
            string jsons = JsonConvert.SerializeObject(new[] { obPadre }, Newtonsoft.Json.Formatting.Indented);
            jsons = jsons.Trim().Substring(1, jsons.Length - 2);
            char coma = '"';
            string json = @"{ " + coma + "TRACKING_CHE" + coma + " : { ";
            string str1 = ": []";
            string str1_1 = ": null";
            jsons = jsons.Replace(str1, str1_1);
            var xmlDocument = new XmlDocument();
            var d = xmlDocument.CreateXmlDeclaration("1.0", "utf-16", "yes");
            xmlDocument.AppendChild(d);
            if (obPadre.Count == 0)
            {
                jsons = json + TablaID + "" + ": {" + coma + "Estado" + coma + ":" + coma + "No hay información" + coma + " }" + "} }";
            }
            else
            {
                jsons = json + TablaID + "" + ":" + jsons + "} }";

            }
            var xml = JsonConvert.DeserializeXmlNode(jsons);
            var root = xmlDocument.ImportNode(xml.DocumentElement, true);
            xmlDocument.AppendChild(root);
            return xmlDocument.OuterXml.ToString();
        }
        //--

    }
     

    }

