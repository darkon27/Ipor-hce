using Newtonsoft.Json;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.ModelERP_FORM;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace SoluccionSalud.RepositoryFormulario.DAL_Formularios
{
    public partial class FuncionesVitalesFERepository
    {
        Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();  //Agregado auditoria --> N° 1

        public List<SS_HC_FuncionesVitales_FE> listarEntidad(SS_HC_FuncionesVitales_FE objSC)
        {
            List<SS_HC_FuncionesVitales_FE> objLista = new List<SS_HC_FuncionesVitales_FE>();
            using (var context = new ModelFormularios())
            {
                List<SS_HC_FuncionesVitales_FE> objConsultas = (from t in context.SS_HC_FuncionesVitales_FE
                                                             where
                                                             t.UnidadReplicacion == objSC.UnidadReplicacion
                                                             && t.IdPaciente == objSC.IdPaciente
                                                             && t.EpisodioClinico == objSC.EpisodioClinico
                                                             && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                             orderby t.IdEpisodioAtencion descending
                                                             select t).ToList();

                if (objConsultas != null)
                {
                    objLista.AddRange(objConsultas);
                }

                //Agregado auditoria --> N° 2
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
                    objAudit = Control.AddAudita(new SS_HC_FuncionesVitales_FE(), new SS_HC_FuncionesVitales_FE(), DataKey, objAudit.Type);
                    String xlmIn = XMLString(objLista, "SS_HC_FuncionesVitales_FE");
                    objAudit.TableName = "SS_HC_FuncionesVitales_FE";
                    objAudit.Type = tempType;
                    objAudit.VistaData = xlmIn;
                    objAudit.Accion = objSC.Accion;
                    contextEnty.Entry(objAudit).State = EntityState.Added;
                    contextEnty.SaveChanges();
                }
                //--
            }
            return objLista;
        }

        public List<SS_HC_FuncionesVitales_FE> listarEntidadAnteFuncionesVitales(SS_HC_FuncionesVitales_FE objSC)
        {
            List<SS_HC_FuncionesVitales_FE> objLista = new List<SS_HC_FuncionesVitales_FE>();
            using (var context = new ModelFormularios())
            {
                List<SS_HC_FuncionesVitales_FE> objConsultas = (from t in context.SS_HC_FuncionesVitales_FE
                                                                where
                                                                t.IdPaciente == objSC.IdPaciente
                                                                orderby t.IdEpisodioAtencion descending
                                                                select t).ToList();

                if (objConsultas != null)
                {
                    objLista.AddRange(objConsultas);
                }
           
            }
            return objLista;
        }


        public SS_HC_FuncionesVitales_FE obj(SS_HC_FuncionesVitales_FE objreqs)
        {
            SS_HC_FuncionesVitales_FE objSavefunciones = new SS_HC_FuncionesVitales_FE();
            using (var context = new ModelFormularios())
            {


                
                objSavefunciones = context.SS_HC_FuncionesVitales_FE.Where(t =>
                                                        t.UnidadReplicacion == objreqs.UnidadReplicacion
                                                        && t.IdPaciente == objreqs.IdPaciente
                                                        && t.EpisodioClinico == objreqs.EpisodioClinico
                                                        && t.IdEpisodioAtencion == objreqs.IdEpisodioAtencion

                                                     ).SingleOrDefault();
            }
           

            return objSavefunciones;

        }

        public SS_HC_EnfermedadActual_FE getDataEnfermedadActualCab(SS_HC_EnfermedadActual_FE objreqs)
        {
            SS_HC_EnfermedadActual_FE objSavefunciones = new SS_HC_EnfermedadActual_FE();
            using (var context = new ModelFormularios())
            { 
                objSavefunciones = context.SS_HC_EnfermedadActual_FE.Where(t =>
                                                        t.UnidadReplicacion == objreqs.UnidadReplicacion
                                                        && t.IdPaciente == objreqs.IdPaciente
                                                        && t.EpisodioClinico == objreqs.EpisodioClinico
                                                        && t.IdEpisodioAtencion == objreqs.IdEpisodioAtencion

                                                     ).SingleOrDefault();
            } 

            return objSavefunciones;

        }

        public List<SS_HC_EnfermedadActualDetalle_FE> getDataEnfermedadActualDet(SS_HC_EnfermedadActual_FE objreqs)
        {
            List<SS_HC_EnfermedadActualDetalle_FE> lstListaDetalle = new List<SS_HC_EnfermedadActualDetalle_FE>();
            using (var context = new ModelFormularios())
            {
                lstListaDetalle = context.SS_HC_EnfermedadActualDetalle_FE.Where(t =>
                                                        t.UnidadReplicacion == objreqs.UnidadReplicacion
                                                        && t.IdPaciente == objreqs.IdPaciente
                                                        && t.EpisodioClinico == objreqs.EpisodioClinico
                                                        && t.IdEpisodioAtencion == objreqs.IdEpisodioAtencion

                                                     ).ToList();
            }

            return lstListaDetalle;

        }

        public int setMantenimiento(SS_HC_FuncionesVitales_FE objSC)
        {
            int valorRetorno = 0; //ERROR
            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        if (objSC != null)
                        {
                            int objCount = 0;
                            int valor = 0;
                            if (objSC.Accion == null) objSC.Accion = "X";
                            if ((objSC.Accion.Substring(0, 1) != "I") && (objSC.Accion.Substring(0, 1) != "N"))
                            {
                                objCount = context.SS_HC_FuncionesVitales_FE
                                                .Where(t =>
                                                    t.UnidadReplicacion == objSC.UnidadReplicacion
                                                    && t.IdPaciente == objSC.IdPaciente
                                                    && t.EpisodioClinico == objSC.EpisodioClinico
                                                    && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                   
                                                 )
                                               .DefaultIfEmpty()
                                               .Count();
                            }
                            //valor = context.SS_HC_FuncionesVitales_FE.Count();
                            /**TRANSACCIÓN*/
                            if (objCount > 0)
                            {
                                if (objSC.Accion == "UPDATE")
                                {
                                    objSC.Version = "CCEPF051";
                                    context.Entry(objSC).State = EntityState.Modified;
                                }
                            }
                            else
                            {
                                if (objSC.Accion == "NUEVO")
                                {
                                    var secuenciaMax = context.SS_HC_FuncionesVitales_FE
                                                     .DefaultIfEmpty().Max(t => t == null ? 0 : t.IdFuncionVital);
                                    objSC.IdFuncionVital = secuenciaMax + 1;
                                    objSC.Version = "CCEPF051";
                                    context.Entry(objSC).State = EntityState.Added;
                                }
                                //InformacionObj = new SS_HC_MiscelaneosPacienteGeneral();
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
                                    //IdSeguridad = objSC.IdSeguridadPausa,
                                };
                                string tempType = objAudit.Type;
                                objAudit = Control.AddAudita(new SS_HC_FuncionesVitales_FE(), new SS_HC_FuncionesVitales_FE(), DataKey, objAudit.Type);
                                objAudit.TableName = "SS_HC_FuncionesVitales_FE ";
                                objAudit.Type = objSC.Accion.Substring(0, 1);
                                objAudit.Accion = objSC.Accion;
                                contextEnty.Entry(objAudit).State = EntityState.Added;
                                contextEnty.SaveChanges();
                            }
                            //**

                            /*************/

                            context.SaveChanges();
                            dbContextTransaction.Commit();
                            valorRetorno = 1;
                        }
                        else
                        {
                            valorRetorno = -1;
                        }
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

        public int setMantenimientoCopia(SS_HC_FuncionesVitales_FEClaas objSCNuevo)
        {

            SS_HC_FuncionesVitales_FE item = new SS_HC_FuncionesVitales_FE();
            objSCNuevo.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            objSCNuevo.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            objSCNuevo.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            objSCNuevo.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            item.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            item.Estado = objSCNuevo.Estado;
            item.Fecha = objSCNuevo.Fecha;
            item.FechaCreacion = objSCNuevo.FechaCreacion;
            item.FechaModificacion = objSCNuevo.FechaModificacion;
            item.Fi02 = objSCNuevo.Fi02;
            item.FrecuenciaCardFetal_Flag = objSCNuevo.FrecuenciaCardFetal_Flag;
            item.FrecuenciaCardiaca = objSCNuevo.FrecuenciaCardiaca;
            item.FrecuenciaCard_FetalAdd = objSCNuevo.FrecuenciaCard_FetalAdd;
            item.FrecuenciaRespiratoria = objSCNuevo.FrecuenciaRespiratoria;
            item.Hora = objSCNuevo.Hora;
            item.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            item.IdFuncionVital = objSCNuevo.IdFuncionVital;
            item.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            item.IMC = objSCNuevo.IMC;
            item.Peso = objSCNuevo.Peso;
            item.PresionArterialMS2 = objSCNuevo.PresionArterialMS2;
            item.PresionArterialMSD1 = objSCNuevo.PresionArterialMSD1;
            item.PresionArterialMSD2 = objSCNuevo.PresionArterialMSD2;
            item.PresionArterialMSI = objSCNuevo.PresionArterialMSI;
            item.SaturacionOxigeno = objSCNuevo.SaturacionOxigeno;
            item.Talla = objSCNuevo.Talla;
            item.Temperatura = objSCNuevo.Temperatura;
            item.UnidadReplicacion =   ENTITY_GLOBAL.Instance.UnidadReplicacion;
            item.UsuarioCreacion = objSCNuevo.UsuarioCreacion;
            item.UsuarioModificacion = objSCNuevo.UsuarioModificacion;
            item.Version = objSCNuevo.Version;


            int valorRetorno = 0; //ERROR
            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        if (objSCNuevo != null)
                        { 
                            if (objSCNuevo.Accion == null) objSCNuevo.Accion = "X";
                            var Otabla = context.SS_HC_FuncionesVitales_FE.SingleOrDefault(t =>
                               t.UnidadReplicacion == objSCNuevo.UnidadReplicacion
                                                && t.IdPaciente == objSCNuevo.IdPaciente
                                                && t.EpisodioClinico == objSCNuevo.EpisodioClinico
                                                && t.IdEpisodioAtencion == objSCNuevo.IdEpisodioAtencion);
                            if (Otabla != null)
                            {
                                Otabla.Accion = "UPDATE";
                                Otabla.Estado = objSCNuevo.Estado;
                                Otabla.Fecha = objSCNuevo.Fecha;
                                Otabla.FechaCreacion = objSCNuevo.FechaCreacion;
                                Otabla.FechaModificacion = objSCNuevo.FechaModificacion;
                                Otabla.Fi02 = objSCNuevo.Fi02;
                                Otabla.FrecuenciaCardFetal_Flag = objSCNuevo.FrecuenciaCardFetal_Flag;
                                Otabla.FrecuenciaCardiaca = objSCNuevo.FrecuenciaCardiaca;
                                Otabla.FrecuenciaCard_FetalAdd = objSCNuevo.FrecuenciaCard_FetalAdd;
                                Otabla.FrecuenciaRespiratoria = objSCNuevo.FrecuenciaRespiratoria;
                                Otabla.Hora = objSCNuevo.Hora; 
                                //Otabla.IdFuncionVital = objSCNuevo.IdFuncionVital; 
                                Otabla.IMC = objSCNuevo.IMC;
                                Otabla.Peso = objSCNuevo.Peso;
                                Otabla.PresionArterialMS2 = objSCNuevo.PresionArterialMS2;
                                Otabla.PresionArterialMSD1 = objSCNuevo.PresionArterialMSD1;
                                Otabla.PresionArterialMSD2 = objSCNuevo.PresionArterialMSD2;
                                Otabla.PresionArterialMSI = objSCNuevo.PresionArterialMSI;
                                Otabla.SaturacionOxigeno = objSCNuevo.SaturacionOxigeno;
                                Otabla.Talla = objSCNuevo.Talla;
                                Otabla.Temperatura = objSCNuevo.Temperatura; 
                                Otabla.UsuarioCreacion = objSCNuevo.UsuarioCreacion;
                                Otabla.UsuarioModificacion = objSCNuevo.UsuarioModificacion;
                                Otabla.Version = objSCNuevo.Version;
                                context.Entry(Otabla).State = System.Data.Entity.EntityState.Modified;
                                context.SaveChanges();
                                dbContextTransaction.Commit();
                            }
                            else
                            {

                                item.Accion = "NUEVO";
                                var secuenciaMax = context.SS_HC_FuncionesVitales_FE
                                                 .DefaultIfEmpty().Max(t => t == null ? 0 : t.IdFuncionVital);
                                item.IdFuncionVital = secuenciaMax + 1;
                                item.Version = "CCEPF051";
                                context.Entry(item).State = EntityState.Added;
                                context.SaveChanges();
                                dbContextTransaction.Commit();
                            }

                            //valor = context.SS_HC_FuncionesVitales_FE.Count();
                            /**TRANSACCIÓN*/


                            //** Agregado auditoria --> N° 3
                            using (var contextEnty = new WEB_ERPSALUDEntities())
                            {
                                SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                                List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                                dynamic DataKey;
                                DataKey = new
                                {
                                    UnidadReplicacion = objSCNuevo.UnidadReplicacion,
                                    IdEpisodioAtencion = objSCNuevo.IdEpisodioAtencion,
                                    EpisodioClinico = objSCNuevo.EpisodioClinico,
                                    IdPaciente = objSCNuevo.IdPaciente,
                                    //IdSeguridad = objSCNuevo.IdSeguridadPausa,
                                };
                                string tempType = objAudit.Type;
                                objAudit = Control.AddAudita(new SS_HC_FuncionesVitales_FE(), new SS_HC_FuncionesVitales_FE(), DataKey, objAudit.Type);
                                objAudit.TableName = "SS_HC_FuncionesVitales_FE ";
                                objAudit.Type = objSCNuevo.Accion.Substring(0, 1);
                                objAudit.Accion = objSCNuevo.Accion;
                                contextEnty.Entry(objAudit).State = EntityState.Added;
                                contextEnty.SaveChanges();
                            }
                            //**

                            /*************/

                            //context.SaveChanges();
                            //dbContextTransaction.Commit();
                            valorRetorno = 1;
                        }
                        else
                        {
                            valorRetorno = -1;
                        }
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

        public virtual String XMLString(List<SS_HC_FuncionesVitales_FE> obPadre, String TablaID)
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
