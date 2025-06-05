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
using System.Data.Entity.Validation;

namespace SoluccionSalud.RepositoryFormulario.DAL_Formularios
{
    public class AntePerGinecoObstetricosFERepository
    {
        Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();  //Agregado auditoria --> N° 1
        public List<SS_HC_AntePerGinecoObstetricos_FE> listarEntidad(SS_HC_AntePerGinecoObstetricos_FE ObjTrace)
        {
            try
            {
                List<SS_HC_AntePerGinecoObstetricos_FE> objLista = new List<SS_HC_AntePerGinecoObstetricos_FE>();
                using (var context = new ModelFormularios())
                {
                    objLista = context.USP_AntePerGinecoObstetricosListarFE(
                                ObjTrace.UnidadReplicacion,
                                ObjTrace.IdEpisodioAtencion,
                                ObjTrace.IdPaciente,
                                ObjTrace.EpisodioClinico,
                                ObjTrace.IdGinecoobstetricos,

                                ObjTrace.UsuarioCreacion,
                                ObjTrace.FechaCreacion,
                                ObjTrace.UsuarioModificacion,
                                ObjTrace.FechaModificacion,
                                ObjTrace.Version,
                                ObjTrace.Accion
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
                            IdGinecoobstetricos = ObjTrace.IdGinecoobstetricos
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
                        objAudit = Control.AddAudita(new SS_HC_AntePerGinecoObstetricos_FE(), new SS_HC_AntePerGinecoObstetricos_FE(), DataKey, objAudit.Type);
                        String xlmIn = XMLString(objLista, "SS_HC_AntePerGinecoObstetricos_FE");
                        objAudit.TableName = "SS_HC_AntePerGinecoObstetricos_FE";
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

        public List<SS_HC_AntePerGinecoObstetricosCatalogoCirugia_FE> listarCatalogoDetalle(SS_HC_AntePerGinecoObstetricosCatalogoCirugia_FE objSC, int inicio, int final)
        {
            List<SS_HC_AntePerGinecoObstetricosCatalogoCirugia_FE> objLista = new List<SS_HC_AntePerGinecoObstetricosCatalogoCirugia_FE>();
            using (var context = new ModelFormularios())
            {
                objLista = context.USP_SS_HC_AntePerGinecoObstetricosCatalogoCirugia_Listar_FE(
                    objSC.UnidadReplicacion,
                    objSC.IdEpisodioAtencion,
                    objSC.IdPaciente,
                    objSC.EpisodioClinico,
                    objSC.IdGinecoobstetricos,
                    objSC.Accion).ToList();
            }
            return objLista;
        }

        public int setMantenimiento(SS_HC_AntePerGinecoObstetricos_FE objSC, List<SS_HC_AntePerGinecoObstetricosCatalogoCirugia_FE> Detalle, List<SS_HC_GINECOOBSTETRICOS_Diagnostico_FE> DetalleDos)
        {

            int valorRetorno = -1; //ERROR
            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        Dictionary<String, int> mapSecuencia = new Dictionary<String, int>();

                        if (objSC != null)
                        {
                            int objCount = 0;
                            SS_HC_AntePerGinecoObstetricos_FE objAnterior = null;
                            if (objSC.Accion == null) objSC.Accion = "X";
                            if ((objSC.Accion.Substring(0, 1) != "I") && (objSC.Accion.Substring(0, 1) != "N"))
                            {
                                objCount = context.SS_HC_AntePerGinecoObstetricos_FE
                                             .Where(t =>
                                                   t.IdPaciente == objSC.IdPaciente
                                                   && t.UnidadReplicacion == objSC.UnidadReplicacion
                                                   && t.EpisodioClinico == objSC.EpisodioClinico
                                                   && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                               )
                                             .DefaultIfEmpty()
                                             .Count();
                                //objAnterior = (from t in context.SS_HC_AntePerGinecoObstetricos_FE
                                //               where
                                //               t.UnidadReplicacion == objSC.UnidadReplicacion
                                //               && t.IdPaciente == objSC.IdPaciente
                                //               && t.EpisodioClinico == objSC.EpisodioClinico
                                //               && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                //               && t.IdGinecoobstetricos == objSC.IdGinecoobstetricos
                                //               orderby t.IdEpisodioAtencion descending
                                //               select t).SingleOrDefault();
                            }
                            /**TRANSACCIÓN*/
                            if (objCount > 0)
                            {
                                if (objSC.Accion == "UPDATE")
                                {
                                    //objSC.Accion = "CCEPF005";
                                    objSC.Accion = "UPDATE";
                                    context.Entry(objSC).State = EntityState.Modified;
                                }
                            }
                            else
                            {
                                if (objSC.Accion == "NUEVO")
                                {
                                    //objSC.Accion = "CCEPF005";
                                    objSC.Accion = "NUEVO";
                                    context.Entry(objSC).State = EntityState.Added;
                                }

                            }


                            //context.SaveChanges();
                            //dbContextTransaction.Commit();
                            valorRetorno = 1;
                        }
                        else
                        {
                            //valorRetorno = -1;
                        }
                        /*********GUARDAR DETALLE 1 ***************/
                        if (Detalle != null)
                        {
                            int contadorDet = 0;
                            /**obtener la última secuencia*/
                            var secuenciaMax = context.SS_HC_AntePerGinecoObstetricosCatalogoCirugia_FE
                                    .Where(t =>
                                            t.IdPaciente == objSC.IdPaciente
                                            && t.UnidadReplicacion == objSC.UnidadReplicacion
                                            && t.EpisodioClinico == objSC.EpisodioClinico
                                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                            && t.IdGinecoobstetricos == objSC.IdGinecoobstetricos
                                    ).DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

                            foreach (SS_HC_AntePerGinecoObstetricosCatalogoCirugia_FE objDetalle in Detalle)
                            {
                                int secuenciaAux = objDetalle.Secuencia;
                                if (objDetalle.Accion == "DETALLE") // Insertar Detalle
                                {
                                    contadorDet++;
                                    objDetalle.Secuencia = secuenciaMax + contadorDet;
                                    objDetalle.Version = "CCEPF005";
                                    //objDetalle.Accion = "NUEVO";
                                    context.Entry(objDetalle).State = EntityState.Added;
                                }
                                else if (objDetalle.Accion == "UPDATEDETALLE") // Actualizar Detalle
                                {

                                    objDetalle.Version = "CCEPF005";
                                    objDetalle.Accion = "UPDATE";
                                    context.Entry(objDetalle).State = EntityState.Modified;
                                    mapSecuencia.Add("" + secuenciaAux, objDetalle.Secuencia);

                                }
                                else if (objDetalle.Accion == "DELETEDETALLE")  // Eliminar Detalle
                                {
                                    context.Entry(objDetalle).State = EntityState.Deleted;
                                    //** Agregado auditoria -->Eliminar
                                    using (var contextEnty = new WEB_ERPSALUDEntities())
                                    {
                                        SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                                        List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                                        dynamic DataKey;
                                        DataKey = new
                                        {
                                            UnidadReplicacion = objSC.UnidadReplicacion,
                                            IdEpisodioAtencion = objSC.IdEpisodioAtencion,
                                            EpisodioClinico = objSC.EpisodioClinico,
                                            IdPaciente = objSC.IdPaciente,
                                            IdGinecoobstetricos = objSC.IdGinecoobstetricos
                                        };
                                        string tempType = objAudit.Type;
                                        objAudit = Control.AddAudita(new SS_HC_AntePerGinecoObstetricos_FE(), new SS_HC_AntePerGinecoObstetricos_FE(), DataKey, objAudit.Type);
                                        objAudit.TableName = "SS_HC_AntePerGinecoObstetricos_FE";
                                        objAudit.Type = "D";
                                        objAudit.Accion = "DELETEDETALLE";
                                        contextEnty.Entry(objAudit).State = EntityState.Added;
                                        contextEnty.SaveChanges();
                                    }
                                    //**
                                }

                            }

                        }

                        /*********GUARDAR DETALLE 2 ***************/
                        if (DetalleDos != null)
                        {
                            int contadorDetDos = 0;
                            /**obtener la última secuencia*/
                            var secuenciaMaxDos = context.SS_HC_GINECOOBSTETRICOS_Diagnostico_FE
                                    .Where(t =>
                                            t.IdPaciente == objSC.IdPaciente
                                            && t.UnidadReplicacion == objSC.UnidadReplicacion
                                            && t.EpisodioClinico == objSC.EpisodioClinico
                                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                            && t.IdGinecoobstetricos == objSC.IdGinecoobstetricos
                                    ).DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

                            foreach (SS_HC_GINECOOBSTETRICOS_Diagnostico_FE objDetalleDos in DetalleDos)
                            {
                                //int secuenciaAuxDos = objDetalleDos.Secuencia;
                                if (objDetalleDos.Accion == "DETALLE") // Insertar Detalle
                                {
                                    contadorDetDos++;
                                    objDetalleDos.Secuencia = secuenciaMaxDos + contadorDetDos;
                                    context.Entry(objDetalleDos).State = EntityState.Added;
                                }
                                else if (objDetalleDos.Accion == "UPDATEDETALLE") // Actualizar Detalle
                                {
                                    context.Entry(objDetalleDos).State = EntityState.Modified;
                                    //mapSecuencia.Add("" + secuenciaAuxDos, objDetalleDos.Secuencia);

                                }
                                else if (objDetalleDos.Accion == "DELETEDETALLE")  // Eliminar Detalle
                                {
                                    context.Entry(objDetalleDos).State = EntityState.Deleted;

                                    //** Agregado auditoria -->Eliminar
                                    using (var contextEnty = new WEB_ERPSALUDEntities())
                                    {
                                        SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                                        List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                                        dynamic DataKey;
                                        DataKey = new
                                        {
                                            UnidadReplicacion = objSC.UnidadReplicacion,
                                            IdEpisodioAtencion = objSC.IdEpisodioAtencion,
                                            EpisodioClinico = objSC.EpisodioClinico,
                                            IdPaciente = objSC.IdPaciente,
                                            IdGinecoobstetricos = objSC.IdGinecoobstetricos
                                        };
                                        string tempType = objAudit.Type;
                                        objAudit = Control.AddAudita(new SS_HC_AntePerGinecoObstetricos_FE(), new SS_HC_AntePerGinecoObstetricos_FE(), DataKey, objAudit.Type);
                                        objAudit.TableName = "SS_HC_AntePerGinecoObstetricos_FE ";
                                        objAudit.Type = "D";
                                        objAudit.Accion = "DELETEDETALLE";
                                        contextEnty.Entry(objAudit).State = EntityState.Added;
                                        contextEnty.SaveChanges();
                                    }
                                    //**
                                }

                            }

                        }

                        //** Agregado auditoria --> N° 3
                        using (var contextEnty = new WEB_ERPSALUDEntities())
                        {
                            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                            List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                            dynamic DataKey;
                            DataKey = new
                            {
                                UnidadReplicacion = objSC.UnidadReplicacion,
                                IdEpisodioAtencion = objSC.IdEpisodioAtencion,
                                EpisodioClinico = objSC.EpisodioClinico,
                                IdPaciente = objSC.IdPaciente,
                                IdGinecoobstetricos = objSC.IdGinecoobstetricos
                            };
                            string tempType = objAudit.Type;
                            objAudit = Control.AddAudita(new SS_HC_AntePerGinecoObstetricos_FE(), new SS_HC_AntePerGinecoObstetricos_FE(), DataKey, objAudit.Type);
                            objAudit.TableName = "SS_HC_AntePerGinecoObstetricos_FE ";
                            objAudit.Type = objSC.Accion.Substring(0, 1);
                            objAudit.Accion = objSC.Accion;
                            contextEnty.Entry(objAudit).State = EntityState.Added;
                            contextEnty.SaveChanges();
                        }
                        //**

                        /*******************************/
                        context.SaveChanges();
                        dbContextTransaction.Commit();


                    } 
                    catch (DbEntityValidationException ex)
                    {
                        string msj = "Ocurrió un error al registrar los datos. Inténtelo de nuevo.";
                        string msjson = "";
                        foreach (var validationErrors in ex.EntityValidationErrors)
                        {
                            foreach (var validationError in validationErrors.ValidationErrors)
                            {
                                // Mostrar el error en la consola o registrarlo en un log
                                msjson += "  Property: "+ validationError.PropertyName +" Error: " + validationError.ErrorMessage;
                            }
                        }
                        //HClinicaController.GinecoLog(this, msjson);
                        dbContextTransaction.Rollback();

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

        //Agregado auditoria --> N° 4
        public virtual String XMLString(List<SS_HC_AntePerGinecoObstetricos_FE> obPadre, String TablaID)
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
