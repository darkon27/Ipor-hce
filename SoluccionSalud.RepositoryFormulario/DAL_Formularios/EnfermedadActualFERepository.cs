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
using System.IO;

namespace SoluccionSalud.RepositoryFormulario.DAL_Formularios
{
    public class EnfermedadActualFERepository
    {
        Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();  //Agregado auditoria --> N° 1

        public int setMantenimiento(SS_HC_EnfermedadActual_FE objSC, List<SS_HC_EnfermedadActualDetalle_FE> Detalle)
        {

            int valorRetorno = -1; //ERROR
            using (var context = new ModelFormularios())
            {
                //using (var dbContextTransaction = context.Database.BeginTransaction())
                //{
                try
                {
                    //SS_HC_EnfermedadActual_FE objAnterior = null;
                    Dictionary<String, int> mapSecuencia = new Dictionary<String, int>();
                    if (objSC != null)
                    {
                        int objCount = 0;
                        //int valor = 0;
                        if (objSC.Accion == null) objSC.Accion = "X";
                        if ((objSC.Accion.Substring(0, 1) != "I") && (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            //objAnterior = context.SS_HC_EnfermedadActual_FE
                            //                         .Where(t =>
                            //                             t.UnidadReplicacion == objSC.UnidadReplicacion
                            //                               && t.IdPaciente == objSC.IdPaciente
                            //                               && t.EpisodioClinico == objSC.EpisodioClinico
                            //                               && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                            //                          ).SingleOrDefault();

                            objCount = context.SS_HC_EnfermedadActual_FE
                                        .Where(t =>
                                            t.UnidadReplicacion == objSC.UnidadReplicacion
                                            && t.IdPaciente == objSC.IdPaciente
                                            && t.EpisodioClinico == objSC.EpisodioClinico
                                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                            )
                                        .DefaultIfEmpty()
                                        .Count();
                        }
                        //valor = context.SS_HC_EnfermedadActual_FE.Count();
                        /**TRANSACCIÓN*/
                        if (objCount > 0)
                        {
                            if (objSC.Accion == "UPDATE")
                            {
                                objSC.Version = "CCEPF001";
                                objSC.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
                                context.Entry(objSC).State = EntityState.Modified;
                            }
                        }
                        else
                        {
                            if (objSC.Accion == "NUEVO")
                            {
                                objSC.Version = "CCEPF001";
                                var idepisodio = context.SS_HC_EnfermedadActual_FE
                                                    .Where(t => t.UnidadReplicacion == objSC.UnidadReplicacion).Count();
                                objSC.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
                                context.Entry(objSC).State = EntityState.Added;

                            }
                        }
                        valorRetorno = 1;
                    }

                    /*********GUARDAR DETALLE***************/
                    if (Detalle != null)
                    {
                        int contadorDet = 0;

                        if (Detalle.Count > 0)
                        {
                            SS_HC_EnfermedadActualDetalle_FE objDet = new SS_HC_EnfermedadActualDetalle_FE();
                            foreach (SS_HC_EnfermedadActualDetalle_FE objDetalle in Detalle)
                            {
                                objDet = new SS_HC_EnfermedadActualDetalle_FE();
                                objDet.IdPaciente = objSC.IdPaciente;
                                objDet.UnidadReplicacion = objSC.UnidadReplicacion;
                                objDet.EpisodioClinico = objSC.EpisodioClinico;
                                objDet.IdEpisodioAtencion = objSC.IdEpisodioAtencion;
                                objDet.Version = "CCEPF001";
                                objDet.Estado = 2;
                                objDet = objDetalle;
                                //objDet.Sintomas = objDetalle.Sintomas;
                                //objDet.Version = "CCEPF001";
                                //objDet.Accion = objDetalle.Accion;

                                if (objDet.Accion == "NUEVO") // Insertar Detalle
                                {
                                    /**obtener la última secuencia*/
                                    var secuenciaMax = context.SS_HC_EnfermedadActualDetalle_FE
                                            .Where(t =>
                                                    t.IdPaciente == objSC.IdPaciente
                                                    && t.UnidadReplicacion == objSC.UnidadReplicacion
                                                    && t.EpisodioClinico == objSC.EpisodioClinico
                                                    && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                            ).DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

                                    //objDet.UsuarioCreacion = objDetalle.UsuarioCreacion;
                                    //objDet.FechaCreacion = objDetalle.FechaCreacion;
                                    //objDet.UsuarioModificacion = objDetalle.UsuarioModificacion;
                                    //objDet.FechaModificacion = objDetalle.FechaModificacion;
                                    contadorDet++;
                                    foreach (SS_HC_EnfermedadActualDetalle_FE objDetValida in Detalle)
                                    {
                                        if (objDetValida.Secuencia == secuenciaMax + contadorDet && objDet.Accion == "DELETE")
                                        {
                                            contadorDet = contadorDet + 1;
                                        }
                                    }
                                    objDet.Secuencia = secuenciaMax + contadorDet;
                                    context.Entry(objDet).State = EntityState.Added;
                                }
                                else if (objDet.Accion == "UPDATE") // Actualizar Detalle
                                {
                                    int varr = objDet.Secuencia;
                                    objDet.Secuencia = objDetalle.Secuencia;
                                    //objDet.UsuarioCreacion = objDetalle.UsuarioCreacion;
                                    //objDet.FechaCreacion = objDetalle.FechaCreacion;
                                    //objDet.UsuarioModificacion = objDetalle.UsuarioModificacion;
                                    //objDet.FechaModificacion = objDetalle.FechaModificacion;
                                    context.Entry(objDet).State = EntityState.Modified;
                                    // mapSecuencia.Add("" + secuenciaAux, objDet.Secuencia);

                                }

                                else if (objDet.Accion == "DELETE")  // Eliminar Detalle
                                {
                                    objDet.Secuencia = Convert.ToInt32(objDetalle.Secuencia);
                                    context.Entry(objDet).State = EntityState.Deleted;
                                    //** Agregado auditoria --> Eliminar
                                    using (var contextEnty = new WEB_ERPSALUDEntities())
                                    {
                                        SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                                        //List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                                        dynamic DataKey;
                                        DataKey = new
                                        {
                                            UnidadReplicacion = objSC.UnidadReplicacion,
                                            IdEpisodioAtencion = objSC.IdEpisodioAtencion,
                                            EpisodioClinico = objSC.EpisodioClinico,
                                            IdPaciente = objSC.IdPaciente
                                        };

                                        string tempType = objAudit.Type;

                                        objAudit = Control.AddAudita(new SS_HC_EnfermedadActualDetalle_FE(), new SS_HC_EnfermedadActualDetalle_FE(), DataKey, objAudit.Type);
                                        objAudit.TableName = "SS_HC_EnfermedadActualDetalle_FE ";
                                        objAudit.Type = objSC.Accion.Substring(0, 1); ;
                                        objAudit.Accion = objSC.Accion;
                                        contextEnty.Entry(objAudit).State = EntityState.Added;
                                        contextEnty.SaveChanges();
                                    }
                                }
                            }
                        }
                    }
                    using (var contextEnty = new WEB_ERPSALUDEntities())
                    {
                        SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                        dynamic DataKey;
                        DataKey = new
                        {
                            UnidadReplicacion = objSC.UnidadReplicacion,
                            IdEpisodioAtencion = objSC.IdEpisodioAtencion,
                            EpisodioClinico = objSC.EpisodioClinico,
                            IdPaciente = objSC.IdPaciente
                        };
                        string tempType = objAudit.Type;
                    }

                    context.SaveChanges();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return valorRetorno;
        }



        public int setMantenimientoCopia(SS_HC_EnfermedadActual_FE objSC, List<SS_HC_EnfermedadActualDetalle_FE> Detalle)
        {

            objSC.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            objSC.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
            objSC.IdEpisodioAtencion = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioAtencion);
            objSC.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);

            foreach (var item in Detalle)
            {
                item.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                item.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                item.IdEpisodioAtencion = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioAtencion);
                item.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);

                item.UsuarioCreacion = objSC.UsuarioCreacion;
                item.UsuarioModificacion = objSC.UsuarioModificacion;
                item.FechaCreacion = objSC.FechaCreacion;
                item.FechaModificacion = objSC.FechaModificacion;
            }

            int valorRetorno = -1; //ERROR
            using (var context = new ModelFormularios())
            {             
                try
                {               
                    Dictionary<String, int> mapSecuencia = new Dictionary<String, int>();
                    if (objSC != null)
                    {
                        int objCount = 0;                
                        //if (objSC.Accion == null) objSC.Accion = "X";              

                            objCount = context.SS_HC_EnfermedadActual_FE
                                   .Where(t =>
                                       t.UnidadReplicacion == objSC.UnidadReplicacion
                                       && t.IdPaciente == objSC.IdPaciente
                                       && t.EpisodioClinico == objSC.EpisodioClinico
                                       && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                       )
                                   .Count();           
                        /**TRANSACCIÓN*/
                        if (objCount > 0)
                        {
                                objSC.Version = "CCEPF001";
                                objSC.Accion = "UPDATE";                        
                                context.Entry(objSC).State = EntityState.Modified;            
                             
                        }
                        else
                        {

                            objSC.Accion = "NUEVO";
                            objSC.Version = "CCEPF001";                          
                            var idepisodio = context.SS_HC_EnfermedadActual_FE
                                                    .Where(t => t.UnidadReplicacion == objSC.UnidadReplicacion).Count();
                                objSC.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
                                context.Entry(objSC).State = EntityState.Added;

                           
                        }
                        valorRetorno = 1;
                    }

                    /*********GUARDAR DETALLE***************/
                    if (Detalle != null)
                    {
                        int contadorDet = 0;
                        if (Detalle.Count > 0)
                        {
                            SS_HC_EnfermedadActualDetalle_FE objDet = new SS_HC_EnfermedadActualDetalle_FE();
                            foreach (SS_HC_EnfermedadActualDetalle_FE objDetalle in Detalle)
                            {
                                objDet = new SS_HC_EnfermedadActualDetalle_FE();
                                objDet.IdPaciente = objSC.IdPaciente;
                                objDet.UnidadReplicacion = objSC.UnidadReplicacion;
                                objDet.EpisodioClinico = objSC.EpisodioClinico;
                                objDet.IdEpisodioAtencion = objSC.IdEpisodioAtencion;
                                objDet.Version = "CCEPF001";
                                objDet.Estado = 2;
                                objDet = objDetalle;
                                var secuenciaMaxvalida = context.SS_HC_EnfermedadActualDetalle_FE
                                          .Where(t =>
                                                  t.IdPaciente == objSC.IdPaciente
                                                  && t.UnidadReplicacion == objSC.UnidadReplicacion
                                                  && t.EpisodioClinico == objSC.EpisodioClinico
                                                  && t.Secuencia == objDet.Secuencia
                                                  && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                          ).DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);
                                if (secuenciaMaxvalida != 0)
                                {
                                    int varr = objDet.Secuencia;
                                    objDet.Secuencia = objDetalle.Secuencia;
                                    objDet.Accion = "UPDATE"; 
                                    context.Entry(objDet).State = EntityState.Modified;
                                }
                                else
                                {

                                    var secuenciaMax = context.SS_HC_EnfermedadActualDetalle_FE
                                            .Where(t =>
                                                    t.IdPaciente == objSC.IdPaciente
                                                    && t.UnidadReplicacion == objSC.UnidadReplicacion
                                                    && t.EpisodioClinico == objSC.EpisodioClinico
                                                    && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                            ).DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);


                                    contadorDet++;
                                    foreach (SS_HC_EnfermedadActualDetalle_FE objDetValida in Detalle)
                                    {
                                        if (objDetValida.Secuencia == secuenciaMax + contadorDet && objDet.Accion == "DELETE")
                                        {
                                            contadorDet = contadorDet + 1;
                                        }
                                    }
                                    objDet.Secuencia = secuenciaMax + contadorDet;
                                    context.Entry(objDet).State = EntityState.Added;

                                }
                            }
                        }
                    }
                    using (var contextEnty = new WEB_ERPSALUDEntities())
                    {
                        SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                        dynamic DataKey;
                        DataKey = new
                        {
                            UnidadReplicacion = objSC.UnidadReplicacion,
                            IdEpisodioAtencion = objSC.IdEpisodioAtencion,
                            EpisodioClinico = objSC.EpisodioClinico,
                            IdPaciente = objSC.IdPaciente
                        };
                        string tempType = objAudit.Type;
                    }

                    context.SaveChanges();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return valorRetorno;
        }

        public List<SS_HC_EnfermedadActual_FE> Apoyo_Listar(SS_HC_EnfermedadActual_FE ObjTrace)
        {
            try
            {
                List<SS_HC_EnfermedadActual_FE> objLista = new List<SS_HC_EnfermedadActual_FE>();
                using (var context = new ModelFormularios())
                {
                    objLista = context.SS_HC_EnfermedadActual_FE
                                    .Where(t =>
                                            t.IdPaciente == ObjTrace.IdPaciente
                                            && t.UnidadReplicacion == ObjTrace.UnidadReplicacion
                                            && t.EpisodioClinico == ObjTrace.EpisodioClinico
                                            && t.IdEpisodioAtencion == ObjTrace.IdEpisodioAtencion
                                    ).ToList();

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
                        objAudit = Control.AddAudita(new SS_HC_ApoyoDiagnostico_FE(), new SS_HC_ApoyoDiagnostico_FE(), DataKey, objAudit.Type);
                        String xlmIn = XMLString(objLista, "SS_HC_ApoyoDiagnostico_FE");
                        objAudit.TableName = "SS_HC_ApoyoDiagnostico_FE";
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
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public SS_HC_EnfermedadActualDetalle_FE ApoyoDetalle_Listar(SS_HC_EnfermedadActualDetalle_FE ObjTrace)
        {
            SS_HC_EnfermedadActualDetalle_FE objResult = null;
            try
            {
                using (var context = new ModelFormularios())
                {
                    SS_HC_EnfermedadActualDetalle_FE objConsulta = (from t in context.SS_HC_EnfermedadActualDetalle_FE
                                                                    where
                                                                    t.UnidadReplicacion == ObjTrace.UnidadReplicacion
                                                                    && t.IdPaciente == ObjTrace.IdPaciente
                                                                    && t.EpisodioClinico == ObjTrace.EpisodioClinico
                                                                    && t.IdEpisodioAtencion == ObjTrace.IdEpisodioAtencion

                                                                    orderby t.Secuencia descending
                                                                    select t).SingleOrDefault();

                    if (objConsulta != null)
                    {
                        objResult = objConsulta;
                    }
                }
            }
            catch (Exception ex)
            {
            }
            return objResult;
        }

        //public static string GetXMLFromObject(object o)
        //{
        //    try
        //    {
        //        XmlSerializer serializer = new XmlSerializer(o.GetType());
        //        StringWriter sw = new StringWriter();
        //        XmlTextWriter tw = new XmlTextWriter(sw);
        //        serializer.Serialize(tw, o);
        //        return sw.ToString();
        //    }
        //    catch (Exception ex)
        //    {
        //        //Handle Exception Code   
        //        return "";
        //    }
        //    //finally
        //    //{
        //    //    sw.close();
        //    //    tw.close();

        //    //}
        //}

        public virtual String XMLString(List<SS_HC_EnfermedadActual_FE> obPadre, String TablaID)
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

    }
}
