using Newtonsoft.Json;
using SoluccionSalud.Repository.DALAuditoria;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Serialization;

namespace SoluccionSalud.Repository.Repository
{
    public class AuditGenerico<T, P> : IAuditGenerico<T, P> where T : class 
    { 
        public virtual List<T> ConvertDataTable(DataTable dt)
        {
            List<T> data = new List<T>();
            foreach (DataRow row in dt.Rows)
            {
                T item = GetItem(row);
                data.Add(item);
            }
            return data;
        }
        public virtual T GetItem(DataRow dr)
        {
            Type temp = typeof(T);
            T obj = Activator.CreateInstance<T>();

            foreach (DataColumn column in dr.Table.Columns)
            {
                foreach (PropertyInfo pro in temp.GetProperties())
                {
                    if (pro.Name == column.ColumnName)
                        pro.SetValue(obj, dr[column.ColumnName], null);
                    else
                        continue;
                }
            }
            return obj;
        }

        public virtual String XMLString(ICollection<T> obPadre, ICollection<P> objHijo, String TablaID)
        {
            string jsons = JsonConvert.SerializeObject(new[] { obPadre }, Newtonsoft.Json.Formatting.Indented);
            // string jsonss = JsonConvert.SerializeXmlNode(new[] { obPadre }, Newtonsoft.Json.Formatting.Indented);
            jsons = jsons.Trim().Substring(1, jsons.Length-2);
            char coma = '"';

            string json = @"{ " + coma + "TRACKING_CHE" + coma + " : { ";

            //string str1 = coma + TablaID + coma + ": []";
            //string str1_1 = coma + TablaID + coma + ": null";
            
            string str1 = ": []";
            string str1_1 =  ": null";
            jsons = jsons.Replace(str1, str1_1);
            // jsons =  jsons.Replace("[","");
            //  jsons =  jsons.Replace("]","");




            var xmlDocument = new XmlDocument();
            var d = xmlDocument.CreateXmlDeclaration("1.0", "utf-16", "yes");
            //System.Xml.XmlTextWriter xtWriter = new System.Xml.XmlTextWriter(jsons, Encoding.UTF8);
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
        public virtual String XMLString(ICollection<T> objList)
        {
            var xmlSerializer = new XmlSerializer(objList.GetType());
            var stringBuilder = new StringBuilder();
            var xmlTextWriter = XmlTextWriter.Create(stringBuilder,
                new XmlWriterSettings { NewLineChars = "\r\n", Indent = true });
            xmlSerializer.Serialize(xmlTextWriter, objList);
            var finalXml = stringBuilder.ToString();
            return finalXml;
        }
        public virtual SS_HC_AuditRoyal AddAudita(object itemsA, object itemsB, dynamic itemsC, String Type)
        {
            Type myType = itemsA.GetType();
            Type myKey = itemsC.GetType();
            List<T> obj = new List<T>();

            IList<PropertyInfo> props = new List<PropertyInfo>(myType.GetProperties());
            IList<PropertyInfo> Keys = new List<PropertyInfo>(myKey.GetProperties());

            StringBuilder newData = new StringBuilder();
            StringBuilder oldData = new StringBuilder();
            StringBuilder KeysData = new StringBuilder();
            SS_HC_AuditRoyal objAud = new SS_HC_AuditRoyal();
            foreach (PropertyInfo Key in Keys)
            {
                string KeyName = Key.Name;
                object KeyValue = Key.GetValue(itemsC, null);
                KeysData.AppendFormat("{0}={1} || ", KeyName.Trim(), KeyValue);
            }
            foreach (PropertyInfo prop in props)
            {
                string propertyNameA = prop.Name;
                object propValueA = prop.GetValue(itemsA, null);
                string propertyNameB = prop.Name;
                object propValueB = prop.GetValue(itemsB, null);
                if (propertyNameA.Trim() == propertyNameB.Trim())
                {
                    string auxilA = "";
                    string auxilB = "";
                    if (propValueA != null) auxilA = propValueA.ToString().Trim();
                    if (propValueB != null) auxilB = propValueB.ToString().Trim();
                    if (Type == "D")
                    {
                        oldData.AppendFormat("{0}={1} || ", propertyNameA.Trim(), propValueA);
                    }
                    if (auxilA.ToString().Trim() != auxilB.ToString().Trim())
                    {

                        if ((Type == "N") || (Type == "I"))
                        {
                            newData.AppendFormat("{0}={1} || ", propertyNameB.Trim(), propValueB);
                        }
                        else if (Type == "L")
                        {
                            newData.AppendFormat("{0}={1} || ", propertyNameB.Trim(), propValueB);
                        }
                        else
                        {
                            var valorEntidad = "";
                            if (propValueA != null)
                            {
                                string[] temporalArray = propValueA.ToString().Trim().Split('.');
                                if (temporalArray.Length > 0) valorEntidad = temporalArray[temporalArray.Length - 1];
                            }


                            if ((propertyNameB.Trim() != "FechaCreacion") && (propertyNameB.Trim() != "Accion")
                                && (propertyNameB.Trim() != valorEntidad.Trim())) //Excepciones
                            {
                                newData.AppendFormat("{0}={1} || ", propertyNameB.Trim(), propValueB);
                                oldData.AppendFormat("{0}={1} || ", propertyNameA.Trim(), propValueA);
                            }
                        }

                    }
                }
                objAud.OldData = oldData.ToString();
                objAud.NewData = newData.ToString();
                objAud.Aplicacion = ENTITY_GLOBAL.Instance.APPCODIGO;
                objAud.Modulo = ENTITY_GLOBAL.Instance.MODULO;
                objAud.Usuario = ENTITY_GLOBAL.Instance.USUARIO;
                objAud.HostName = ENTITY_GLOBAL.Instance.HostName;
                objAud.PrimaryKeyData = KeysData.ToString();
                objAud.UpdateDate = DateTime.Now;
                // object propValuex = prop.GetValue(propertyName, null);
                // Do something with propValue
            }
            return objAud;
        }
        public virtual int Add(params object[] items)
        {
            throw new NotImplementedException();
        }

        public virtual int Update(params object[] items)
        {
            throw new NotImplementedException();
        }

        public virtual int Delete(object items)
        {
            throw new NotImplementedException();
        }

        public virtual bool Buscar(params object[] items)
        {
            throw new NotImplementedException();
        }

        public virtual List<T> GetSelectAll()
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.Set<T>().ToList();
            }

        }

        public virtual List<T> GetSelect(params object[] items)
        {
            throw new NotImplementedException();

        }

        public virtual List<T> GetSelectSP(string sqlCommand, params object[] parameters)
        {

            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.Database.SqlQuery<T>(sqlCommand, parameters).ToList();
            }

        }
        public virtual int ExecuteNonQuery(string sqlCommand, params object[] parameters)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.Database.ExecuteSqlCommand(sqlCommand, parameters);

            }
        }

        public int AddEntity(params T[] items)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                foreach (T item in items)
                {
                    context.Entry(item).State = EntityState.Added;
                }
                return context.SaveChanges();
            }
        }
        public int UpdateEntity(params T[] items)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                foreach (T item in items)
                {
                    context.Entry(item).State = EntityState.Modified;
                }
                return context.SaveChanges();
            }
        }

        public int DeleteEntity(params T[] items)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                foreach (T item in items)
                {
                    context.Entry(item).State = EntityState.Deleted;
                }
                return context.SaveChanges();
            }
        }


        public string XMLString(ICollection<P> objList, ICollection<T> objLists)
        {
            throw new NotImplementedException();
        }

        /**PARA el SET DE AUDITORÍA*/
        public int setAuditoriaListado(object objAnterior, object objSC, String accion, String nombreTabla,
            SS_HC_AuditRoyal objAudit, dynamic DataKey, String xmlIn)
        {
            int result = 0;
            try
            {
                objAudit = AddAudita(objAnterior, objSC, DataKey, accion);
                objAudit.TableName = nombreTabla;
                objAudit.Accion = "INSERT";
                objAudit.Type = accion;
                objAudit.VistaData = xmlIn;
                AuditoriaRepository xx = new AuditoriaRepository();
                xx.Save_ChangesTraking(objAudit);
                result = 1;
            }
            catch (Exception ex)
            {

            }

            return result;
        }

        public int setAuditoria(object objAnterior, object objSC, String accion, String nombreTabla,
            SS_HC_AuditRoyal objAudit, dynamic DataKey, WEB_ERPSALUDEntities context)
        {
            int result = 0;
            objAudit = AddAudita(objAnterior, objSC, DataKey, accion.Substring(0, 1));
            objAudit.TableName = nombreTabla;
            objAudit.Type = accion.Substring(0, 1);
            if (((objAudit.OldData.Trim().Length != 0) || (objAudit.NewData.Trim().Length != 0)) || (objAudit.Type == "D"))
            {
                if (objAudit.Type != "L")
                {
                    context.Entry(objAudit).State = EntityState.Added;
                    //context.SaveChanges();
                    result = 1;
                }
            }
            return result;
        }

    }
}


/*

 
            var jsonSerializer = new JsonSerializer
            {
                NullValueHandling = NullValueHandling.Ignore,
                MissingMemberHandling = MissingMemberHandling.Ignore,
                ReferenceLoopHandling = ReferenceLoopHandling.Serialize
            };

            var sb = new StringBuilder();
            using (var sw = new StringWriter(sb))
            using (var jtw = new JsonTextWriter(sw))
                jsonSerializer.Serialize(jtw, obPadre);
            var result = sb.ToString();
            string jsons = JsonConvert.SerializeObject(new[] { obPadre }, Newtonsoft.Json.Formatting.Indented);
           // string jsonss = JsonConvert.SerializeXmlNode(new[] { obPadre }, Newtonsoft.Json.Formatting.Indented);
            jsons =  jsons.Replace("[","");
            jsons =  jsons.Replace("]","");

            jsons = @"{""TABLA"":" + jsons + "}";
            var json = @"{""page"":  {""mode"": ""2"", ""ref"": ""user""}}";
            var xmlDocument = new XmlDocument();
            var d = xmlDocument.CreateXmlDeclaration("1.0", "utf-8", "yes");
            xmlDocument.AppendChild(d);
            var xml = JsonConvert.DeserializeXmlNode(json);
            var root = xmlDocument.ImportNode(xml.DocumentElement, true);
            xmlDocument.AppendChild(root);
            Console.WriteLine(xmlDocument.OuterXml);
            xml = JsonConvert.DeserializeXmlNode(jsons);
            root = xmlDocument.ImportNode(xml.DocumentElement, true);
            xmlDocument.AppendChild(root);
            Console.WriteLine(xmlDocument.OuterXml);
 
            var xmlSerializer = new XmlSerializer(typeof(T));
            // var xmlSerializer = new XmlSerializer(objList.GetType());
            var stringBuilder = new StringBuilder();
            var xmlTextWriter = XmlTextWriter.Create(stringBuilder,
                new XmlWriterSettings { NewLineChars = "\r\n", Indent = true });
            xmlSerializer.Serialize(xmlTextWriter, obPadre);
            var finalXml = stringBuilder.ToString(); 

            
*/