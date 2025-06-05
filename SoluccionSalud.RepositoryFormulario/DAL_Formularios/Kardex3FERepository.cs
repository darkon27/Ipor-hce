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
    public class Kardex3FERepository
    {
        Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();  //Agregado auditoria --> N° 1
        public int setMantenimiento(List<SS_HC_Examen_Kardex_FE> Detalle, List<SS_HC_InterConsulta_Kardex_FE> Detalle1)
        {

            int valorRetorno = -1; //ERROR

            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    int IdPaciente1 = 1;
                    string UnidadReplicacion1 = "";
                    int EpisodioClinico1 = 1;
                    long IdEpisodioAtencion1 = new long();
                    string Accion1 = "";
                    try
                    {
                        Dictionary<String, int> mapSecuencia = new Dictionary<String, int>();
                        Dictionary<String, int> mapSecuencia1 = new Dictionary<String, int>();


                        /*********GUARDAR DETALLES***************/
                        #region Detalle

                        if (Detalle != null)
                        {
                            int contadorDet = 0;
                            /**obtener la última secuencia*/
                            var secuenciaMax = context.SS_HC_Examen_Kardex_FE
                                    .DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

                            SS_HC_Examen_Kardex_FE objDet = new SS_HC_Examen_Kardex_FE();

                            foreach (SS_HC_Examen_Kardex_FE objDetalle in Detalle)
                            {
                                objDet = new SS_HC_Examen_Kardex_FE();

                                Nullable<int> secuenciaAux = objDetalle.Secuencia;

                                objDet.IdPaciente = objDetalle.IdPaciente;
                                objDet.UnidadReplicacion = objDetalle.UnidadReplicacion;
                                objDet.EpisodioClinico = objDetalle.EpisodioClinico;
                                objDet.IdEpisodioAtencion = objDetalle.IdEpisodioAtencion;
                                objDet.Version = objDetalle.Version;
                                objDet.Secuencia = Convert.ToInt32(objDetalle.Secuencia);

                                objDet.IdProcedimiento = objDetalle.IdProcedimiento;
                                objDet.IdEspecialidad = objDetalle.IdEspecialidad;
                                objDet.FechaSolicitada = objDetalle.FechaSolicitada;
                                objDet.Cantidad = objDetalle.Cantidad;
                                objDet.Observacion = objDetalle.Observacion;
                                objDet.UsuarioCreacion = objDetalle.UsuarioCreacion;
                                objDet.UsuarioModificacion = objDetalle.UsuarioModificacion;
                                objDet.IndicadorEPS = objDetalle.IndicadorEPS;
                                objDet.TipoCodigo = objDetalle.TipoCodigo;
                                objDet.CodigoSegus = objDetalle.CodigoSegus;
                                objDet.DescripcionCodigo = objDetalle.DescripcionCodigo;
                                objDet.IdProcedimiento = objDetalle.IdProcedimiento;
                                //objDet.CodigoComponente = objDetalle.CodigoComponenteCab;
                                objDet.Realizado = objDetalle.Realizado;
                                objDet.Detalle = objDetalle.Detalle;
                                objDet.Especificaciones = objDetalle.Especificaciones;
                                objDet.Accion = objDetalle.Accion;
                                objDet.FechaModificacion = objDetalle.FechaModificacion;
                                Accion1 = objDet.Accion;

                                IdPaciente1 = objDetalle.IdPaciente;
                                UnidadReplicacion1 = objDetalle.UnidadReplicacion;
                                EpisodioClinico1 = objDetalle.EpisodioClinico;
                                IdEpisodioAtencion1 = objDetalle.IdEpisodioAtencion;

                                if (objDetalle.Accion == "DETALLE" || objDetalle.Accion == "NUEVO") // Insertar Detalle
                                {
                                    contadorDet++;
                                    objDet.Secuencia = secuenciaMax + contadorDet;
                                    objDet.UsuarioCreacion = objDetalle.UsuarioCreacion;
                                    objDet.FechaCreacion = objDetalle.FechaCreacion;
                                    objDet.Accion = "NUEVO";
                                    Accion1 = objDet.Accion;

                                    context.Entry(objDet).State = EntityState.Added;
                                }
                                else if (objDetalle.Accion == "UPDATEDETALLE") // Actualizar Detalle
                                {
                                    SS_HC_Examen_Kardex_FE objAnterior = null;

                                    objAnterior = (from t in context.SS_HC_Examen_Kardex_FE
                                                   where
                                                   t.UnidadReplicacion == objDetalle.UnidadReplicacion
                                                   && t.IdPaciente == objDetalle.IdPaciente
                                                   && t.EpisodioClinico == objDetalle.EpisodioClinico
                                                   && t.IdEpisodioAtencion == objDetalle.IdEpisodioAtencion
                                                   orderby t.IdEpisodioAtencion descending
                                                   select t).FirstOrDefault();

                                    objDet.UsuarioCreacion = objAnterior.UsuarioCreacion;
                                    objDet.FechaCreacion = objAnterior.FechaCreacion;

                                    context.Entry(objDet).State = EntityState.Modified;
                                   // mapSecuencia.Add("" + secuenciaAux, objDet.Secuencia);
                                }
                                else if (objDetalle.Accion == "DELETE")  // Eliminar Detalle
                                {
                                    context.Entry(objDet).State = EntityState.Deleted;


                                }

                                if (objDetalle.Accion.Length > 0)
                                {
                                    //** Agregado auditoria --> Eliminar
                                    using (var contextEnty = new WEB_ERPSALUDEntities())
                                    {
                                        SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                                        List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                                        dynamic DataKey;
                                        DataKey = new
                                        {
                                            UnidadReplicacion = objDetalle.UnidadReplicacion,
                                            IdEpisodioAtencion = objDetalle.IdEpisodioAtencion,
                                            EpisodioClinico = objDetalle.EpisodioClinico,
                                            IdPaciente = objDetalle.IdPaciente
                                        };
                                        string tempType = objAudit.Type;
                                        objAudit = Control.AddAudita(new SS_HC_Examen_Kardex_FE(), new SS_HC_Examen_Kardex_FE(), DataKey, objAudit.Type);
                                        objAudit.TableName = "SS_HC_Examen_Kardex_FE ";
                                        objAudit.Type = objDetalle.Accion.Substring(0, 1);
                                        objAudit.Accion = objDetalle.Accion;
                                        contextEnty.Entry(objAudit).State = EntityState.Added;
                                        contextEnty.SaveChanges();
                                    }
                                    //**
                                }
                            }
                        }
                        #endregion
                        /*********GUARDAR DETALLE1***************/
                        #region Detalle1

                        if (Detalle1 != null)
                        {
                            int contadorDet = 0;
                            /**obtener la última secuencia*/
                            var secuenciaMax = context.SS_HC_InterConsulta_Kardex_FE
                                    .DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

                            SS_HC_InterConsulta_Kardex_FE objDet = new SS_HC_InterConsulta_Kardex_FE();

                            foreach (SS_HC_InterConsulta_Kardex_FE objDetalle in Detalle1)
                            {
                                objDet = new SS_HC_InterConsulta_Kardex_FE();

                                Nullable<int> secuenciaAux = objDetalle.Secuencia;

                                objDet.IdPaciente = objDetalle.IdPaciente;
                                objDet.UnidadReplicacion = objDetalle.UnidadReplicacion;
                                objDet.EpisodioClinico = objDetalle.EpisodioClinico;
                                objDet.IdEpisodioAtencion = objDetalle.IdEpisodioAtencion;
                                objDet.Version = objDetalle.Version;
                                objDet.Secuencia = Convert.ToInt32(objDetalle.Secuencia);

                                objDet.IdEspecialidad = objDetalle.IdEspecialidad;
                                objDet.FechaSolicitada = objDetalle.FechaSolicitada;
                                objDet.Observacion = objDetalle.Observacion;
                                objDet.UsuarioCreacion = objDetalle.UsuarioCreacion;
                                objDet.UsuarioModificacion = objDetalle.UsuarioModificacion;

                                objDet.Realizado = objDetalle.Realizado;
                                objDet.Detalle = objDetalle.Detalle;
                                objDet.IdTipoInterConsulta = objDetalle.IdTipoInterConsulta;
                                objDet.Accion = objDetalle.Accion;
                                objDet.FechaModificacion = objDetalle.FechaModificacion;
                                objDet.FechaPlaneada = objDetalle.FechaPlaneada;

                                if (objDetalle.Accion == "DETALLE" || objDetalle.Accion == "NUEVO") // Insertar Detalle
                                {
                                    contadorDet++;
                                    objDet.Secuencia = secuenciaMax + contadorDet;
                                    objDet.UsuarioCreacion = objDetalle.UsuarioCreacion;
                                    objDet.FechaCreacion = objDetalle.FechaCreacion;
                                    objDet.Accion = "NUEVO";
                                    //COrresponde al código CPT
                                    //if (objDet.CodigoComponente == null || objExamSol.CodigoComponenteCab == "")
                                    //{
                                    //    objDet.CodigoComponenteCab = objEntity.ValorCodigo7; //CASO SEGUS
                                    //}
                                    //objDet.Descripcion = objDetalle.DescripcionExtranjera;
                                    context.Entry(objDet).State = EntityState.Added;
                                }
                                else if (objDetalle.Accion == "UPDATEDETALLE") // Actualizar Detalle
                                {
                                    SS_HC_InterConsulta_Kardex_FE objAnterior = null;

                                    objAnterior = (from t in context.SS_HC_InterConsulta_Kardex_FE
                                                   where
                                                   t.UnidadReplicacion == objDetalle.UnidadReplicacion
                                                   && t.IdPaciente == objDetalle.IdPaciente
                                                   && t.EpisodioClinico == objDetalle.EpisodioClinico
                                                   && t.IdEpisodioAtencion == objDetalle.IdEpisodioAtencion
                                                   orderby t.IdEpisodioAtencion descending
                                                   select t).FirstOrDefault();

                                    objDet.UsuarioCreacion = objAnterior.UsuarioCreacion;
                                    objDet.FechaCreacion = objAnterior.FechaCreacion;
                                    context.Entry(objDet).State = EntityState.Modified;
                                   // mapSecuencia1.Add("" + secuenciaAux, objDet.Secuencia);
                                }
                                else if (objDetalle.Accion == "DELETE")  // Eliminar Detalle
                                {
                                    context.Entry(objDet).State = EntityState.Deleted;
                                }
                                if (objDetalle.Accion.Length > 0)
                                {
                                    //** Agregado auditoria 
                                    using (var contextEnty = new WEB_ERPSALUDEntities())
                                    {
                                        SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                                        List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                                        dynamic DataKey;
                                        DataKey = new
                                        {
                                            UnidadReplicacion = objDetalle.UnidadReplicacion,
                                            IdEpisodioAtencion = objDetalle.IdEpisodioAtencion,
                                            EpisodioClinico = objDetalle.EpisodioClinico,
                                            IdPaciente = objDetalle.IdPaciente
                                        };
                                        string tempType = objAudit.Type;
                                        objAudit = Control.AddAudita(new SS_HC_InterConsulta_Kardex_FE(), new SS_HC_InterConsulta_Kardex_FE(), DataKey, objAudit.Type);
                                        objAudit.TableName = "SS_HC_InterConsulta_Kardex_FE ";
                                        objAudit.Type = objDetalle.Accion.Substring(0, 1);
                                        objAudit.Accion = objDetalle.Accion;
                                        contextEnty.Entry(objAudit).State = EntityState.Added;
                                        contextEnty.SaveChanges();
                                    }
                                    //**
                                }
                            }
                        }
                        #endregion



                        /*******************************/

                        context.SaveChanges();
                        //dbContextTransaction.Commit();

                        #region ValidarDetalle


                        context.SaveChanges();

                        dbContextTransaction.Commit();
                        valorRetorno = 1;
                        #endregion


                    }
                    catch (Exception ex)
                    {
                        dbContextTransaction.Rollback();
                        throw ex;
                    }
                }
            }
            return valorRetorno;
        }

        public List<SS_HC_Kardex3FE> Examen_Listar(SS_HC_Kardex3FE ObjTrace)
        {
            try
            {

                List<SS_HC_Kardex3FE> objLista = new List<SS_HC_Kardex3FE>();
                using (var context = new ModelFormularios())
                {


                    objLista = context.SS_HC_Kardex3FE.Where(t => t.EpisodioClinico == ObjTrace.EpisodioClinico
                                                            && t.UnidadReplicacion == ObjTrace.UnidadReplicacion
                                                            && t.IdPaciente == ObjTrace.IdPaciente
                                                            && t.IdEpisodioAtencion == ObjTrace.IdEpisodioAtencion).ToList();

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
                        objAudit = Control.AddAudita(new SS_HC_Kardex3FE(), new SS_HC_Kardex3FE(), DataKey, objAudit.Type);
                        String xlmIn = XMLString(objLista, "SS_HC_Kardex3FE");
                        objAudit.TableName = "SS_HC_Kardex3FE";
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

        ///
        //public SS_HC_ExamenSolicitadoDet_FE ExamenSol_Listar(SS_HC_ExamenSolicitadoDet_FE ObjTrace)
        //{
        //    SS_HC_ExamenSolicitadoDet_FE objResult = null;
        //    try
        //    {
        //        using (var context = new ModelFormularios())
        //        {
        //            SS_HC_ExamenSolicitadoDet_FE objConsulta = (from t in context.SS_HC_ExamenSolicitadoDet_FE
        //                                                        where
        //                                                        t.UnidadReplicacion == ObjTrace.UnidadReplicacion
        //                                                        && t.IdPaciente == ObjTrace.IdPaciente
        //                                                        && t.EpisodioClinico == ObjTrace.EpisodioClinico
        //                                                        && t.IdEpisodioAtencion == ObjTrace.IdEpisodioAtencion
        //                                                        && t.CodigoSegus == ObjTrace.CodigoSegus
        //                                                        orderby t.Secuencia descending
        //                                                        select t).SingleOrDefault();

        //            if (objConsulta != null)
        //            {
        //                objResult = objConsulta;
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //    }
        //    return objResult;
        //}



        //Agregado auditoria --> N° 4
        public virtual String XMLString(List<SS_HC_Kardex3FE> obPadre, String TablaID)
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
