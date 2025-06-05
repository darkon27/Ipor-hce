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
    public class MedicamentoFERepository
    {
        Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();  //Agregado auditoria --> N° 1
        public int setMantenimiento(SS_HC_Medicamento_FE ObjTrace)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new ModelFormularios())
            {
                try
                {

                    iReturnValue = context.USP_SS_GE_Medicamento_FE(
                       ObjTrace.UnidadReplicacion, ObjTrace.IdPaciente,
                       ObjTrace.EpisodioClinico,
                       ObjTrace.IdEpisodioAtencion,
                       ObjTrace.Secuencia, ObjTrace.TipoMedicamento, ObjTrace.IdUnidadMedida,
                       ObjTrace.Linea, ObjTrace.Familia, ObjTrace.SubFamilia, ObjTrace.TipoComponente,
                       ObjTrace.CodigoComponente, ObjTrace.IdVia, ObjTrace.Dosis, ObjTrace.DiasTratamiento,
                       ObjTrace.Frecuencia, ObjTrace.Cantidad, ObjTrace.IndicadorEPS, ObjTrace.TipoReceta,
                       ObjTrace.Forma, ObjTrace.GrupoMedicamento, ObjTrace.Comentario, ObjTrace.IndicadorAuditoria, ObjTrace.UsuarioAuditoria,
                       ObjTrace.TipoComida,
                       ObjTrace.VolumenDia, ObjTrace.FrecuenciaToma, ObjTrace.Presentacion, ObjTrace.Hora,
                       ObjTrace.Periodo, ObjTrace.UnidadTiempo, ObjTrace.Indicacion,
                       ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                       ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version, ObjTrace.IdPadreNutriente, ObjTrace.IdHijoNutriente, ObjTrace.SecuencialHCE, ObjTrace.CodAlmacen).SingleOrDefault();
                    valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                    //using (var contextEnty = new WEB_ERPSALUDEntities())
                    //{
                    //    SS_HC_AuditRoyal objAuditoria = new SS_HC_AuditRoyal();
                    //    List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                    //    dynamic DataKeyy;
                    //    DataKey = new
                    //    {
                    //        UnidadReplicacion = ObjTrace.UnidadReplicacion,
                    //        IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                    //        EpisodioClinico = ObjTrace.EpisodioClinico,
                    //        IdPaciente = ObjTrace.IdPaciente
                    //    };

                    //    string tempType = objAudit.Type;
                    //    objAudit = Control.AddAudita(new SS_HC_Medicamento_FE(), new SS_HC_Medicamento_FE(), DataKey, objAudit.Type);
                    //    objAudit.TableName = "SS_HC_Medicamento_FE";
                    //    objAudit.Type = ObjTrace.Accion.Substring(0, 1);
                    //    objAudit.Accion = ObjTrace.Accion;
                    //    contextEnty.Entry(objAudit).State = EntityState.Added;
                    //    contextEnty.SaveChanges();
                    //}
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return valorRetorno;
        }

        public List<SS_HC_Medicamento_FE> MedicamentoListar(SS_HC_Medicamento_FE ObjTrace)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;
            List<SS_HC_Medicamento_FE> objLista = new List<SS_HC_Medicamento_FE>();
            using (var context = new ModelFormularios())
            {
                objLista = context.USP_SS_GE_Medicamento_FEListar(ObjTrace.UnidadReplicacion, ObjTrace.IdPaciente,
                   ObjTrace.EpisodioClinico,
                   ObjTrace.IdEpisodioAtencion,
                   ObjTrace.Secuencia, ObjTrace.TipoMedicamento, ObjTrace.IdUnidadMedida,
                   ObjTrace.Linea, ObjTrace.Familia, ObjTrace.SubFamilia, ObjTrace.TipoComponente,
                   ObjTrace.CodigoComponente, ObjTrace.IdVia, ObjTrace.Dosis, ObjTrace.DiasTratamiento,
                   ObjTrace.Frecuencia, ObjTrace.Cantidad, ObjTrace.IndicadorEPS, ObjTrace.TipoReceta,
                   ObjTrace.Forma, ObjTrace.GrupoMedicamento, ObjTrace.Comentario, ObjTrace.IndicadorAuditoria, ObjTrace.UsuarioAuditoria,
                   ObjTrace.TipoComida, ObjTrace.VolumenDia, ObjTrace.FrecuenciaToma, ObjTrace.Presentacion, ObjTrace.Hora,
                    ObjTrace.Periodo, ObjTrace.UnidadTiempo, ObjTrace.Indicacion,
                   ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                   ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version, ObjTrace.IdPadreNutriente, ObjTrace.IdHijoNutriente).ToList();
                DataKey = new
                {
                    UnidadReplicacion = ObjTrace.UnidadReplicacion,
                    IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                    EpisodioClinico = ObjTrace.EpisodioClinico,
                    IdPaciente = ObjTrace.IdPaciente,
                    Secuencia = ObjTrace.Secuencia,
                    TipoMedicamento = ObjTrace.TipoMedicamento

                };

                //Agregado auditoria --> N° 2
                //using (var contextEnty = new WEB_ERPSALUDEntities())
                //{             
                //    List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();             
                //    DataKey = new
                //    {
                //        UnidadReplicacion = ObjTrace.UnidadReplicacion,
                //        IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                //        EpisodioClinico = ObjTrace.EpisodioClinico,
                //        IdPaciente = ObjTrace.IdPaciente,
                //        Secuencia = ObjTrace.Secuencia
                //    };
                //    if (objLista.Count > 1)
                //    {
                //        objAudit.Type = "L";
                //    }
                //    else
                //    {
                //        objAudit.Type = "V";
                //    }

                //    string tempType = objAudit.Type;
                //    objAudit = Control.AddAudita(new SS_HC_Medicamento_FE(), new SS_HC_Medicamento_FE(), DataKey, objAudit.Type);
                //    String xlmIn = XMLString(objLista, "SS_HC_Medicamento_FE");
                //    objAudit.TableName = "SS_HC_Medicamento_FE";
                //    objAudit.Type = tempType;
                //    objAudit.VistaData = xlmIn;
                //    objAudit.Accion = ObjTrace.Accion;
                //    contextEnty.Entry(objAudit).State = EntityState.Added;
                //    contextEnty.SaveChanges();
                //}
            }
            return objLista;
        }

        public List<SS_HC_Medicamento_FE_Epi2> MedicamentoListarEPICRISIS(SS_HC_Medicamento_FE_Epi2 ObjTrace)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;
            List<SS_HC_Medicamento_FE_Epi2> objLista = new List<SS_HC_Medicamento_FE_Epi2>();
            using (var context = new ModelFormularios())
            {
                objLista = context.USP_SS_GE_Medicamento_FEListarEPICRISIS(ObjTrace.UnidadReplicacion, ObjTrace.IdPaciente,
                   ObjTrace.EpisodioClinico,
                   ObjTrace.IdEpisodioAtencion,
                   ObjTrace.Secuencia, ObjTrace.TipoMedicamento, ObjTrace.IdUnidadMedida,
                   ObjTrace.Linea, ObjTrace.Familia, ObjTrace.SubFamilia, ObjTrace.TipoComponente,
                   ObjTrace.CodigoComponente, ObjTrace.IdVia, ObjTrace.Dosis, ObjTrace.DiasTratamiento,
                   ObjTrace.Frecuencia, ObjTrace.Cantidad, ObjTrace.IndicadorEPS, ObjTrace.TipoReceta,
                   ObjTrace.Forma, ObjTrace.GrupoMedicamento, ObjTrace.Comentario, ObjTrace.IndicadorAuditoria, ObjTrace.UsuarioAuditoria,
                   ObjTrace.TipoComida, ObjTrace.VolumenDia, ObjTrace.FrecuenciaToma, ObjTrace.Presentacion, ObjTrace.Hora,
                    ObjTrace.Periodo, ObjTrace.UnidadTiempo, ObjTrace.Indicacion,
                   ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                   ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version, ObjTrace.IdPadreNutriente, ObjTrace.IdHijoNutriente).ToList();
                DataKey = new
                {
                    UnidadReplicacion = ObjTrace.UnidadReplicacion,
                    IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                    EpisodioClinico = ObjTrace.EpisodioClinico,
                    IdPaciente = ObjTrace.IdPaciente,
                    Secuencia = ObjTrace.Secuencia,
                    TipoMedicamento = ObjTrace.TipoMedicamento

                };

                //objAudit.Type = "V";
                //if (objLista.Count > 1) objAudit.Type = "L";
                //string tempType = objAudit.Type;
                //objAudit = AddAudita(new SS_HC_Medicamento(), new SS_HC_Medicamento(), DataKey, objAudit.Type);
                //String xlmIn = XMLString(objLista, new List<SS_HC_Medicamento>(), "SS_HC_Medicamento");
                //objAudit.TableName = "SS_HC_Medicamento";
                //objAudit.Type = tempType;
                //objAudit.VistaData = xlmIn;
                //context.Entry(objAudit).State = EntityState.Added;
                //context.SaveChanges();

                //Agregado auditoria --> N° 2
                //using (var contextEnty = new WEB_ERPSALUDEntities())
                //{
                //    //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                //    List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                //    //dynamic DataKey;
                //    DataKey = new
                //    {
                //        UnidadReplicacion = ObjTrace.UnidadReplicacion,
                //        IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                //        EpisodioClinico = ObjTrace.EpisodioClinico,
                //        IdPaciente = ObjTrace.IdPaciente,
                //        Secuencia = ObjTrace.Secuencia
                //    };

                //    if (objLista.Count > 1)
                //    {
                //        objAudit.Type = "L";
                //    }
                //    else
                //    {
                //        objAudit.Type = "V";
                //    }

                //    string tempType = objAudit.Type;
                //    objAudit = Control.AddAudita(new SS_HC_Medicamento_FE_Epi2(), new SS_HC_Medicamento_FE_Epi2(), DataKey, objAudit.Type);
                //    String xlmIn = XMLStringEpi(objLista, "SS_HC_Medicamento_FE_Epi2");
                //    objAudit.TableName = "SS_HC_Medicamento_FE";
                //    objAudit.Type = tempType;
                //    objAudit.VistaData = xlmIn;
                //    objAudit.Accion = ObjTrace.Accion;
                //    contextEnty.Entry(objAudit).State = EntityState.Added;
                //    contextEnty.SaveChanges();
                //}
                //--

            }
            return objLista;
        }

        public List<SS_HC_Medicamento_FE_Epi2> MedicamentoListarEpicrisis(SS_HC_Medicamento_FE_Epi2 ObjTrace)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;
            List<SS_HC_Medicamento_FE_Epi2> objLista = new List<SS_HC_Medicamento_FE_Epi2>();
            using (var context = new ModelFormularios())
            {
                objLista = context.USP_SS_GE_Medicamento_FEListarEPICRISIS(ObjTrace.UnidadReplicacion, ObjTrace.IdPaciente,
                   ObjTrace.EpisodioClinico,
                   ObjTrace.IdEpisodioAtencion,
                   ObjTrace.Secuencia, ObjTrace.TipoMedicamento, ObjTrace.IdUnidadMedida,
                   ObjTrace.Linea, ObjTrace.Familia, ObjTrace.SubFamilia, ObjTrace.TipoComponente,
                   ObjTrace.CodigoComponente, ObjTrace.IdVia, ObjTrace.Dosis, ObjTrace.DiasTratamiento,
                   ObjTrace.Frecuencia, ObjTrace.Cantidad, ObjTrace.IndicadorEPS, ObjTrace.TipoReceta,
                   ObjTrace.Forma, ObjTrace.GrupoMedicamento, ObjTrace.Comentario, ObjTrace.IndicadorAuditoria, ObjTrace.UsuarioAuditoria,
                   ObjTrace.TipoComida, ObjTrace.VolumenDia, ObjTrace.FrecuenciaToma, ObjTrace.Presentacion, ObjTrace.Hora,
                    ObjTrace.Periodo, ObjTrace.UnidadTiempo, ObjTrace.Indicacion,
                   ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                   ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version, ObjTrace.IdPadreNutriente, ObjTrace.IdHijoNutriente).ToList();



                DataKey = new
                {
                    UnidadReplicacion = ObjTrace.UnidadReplicacion,
                    IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                    EpisodioClinico = ObjTrace.EpisodioClinico,
                    IdPaciente = ObjTrace.IdPaciente,
                    Secuencia = ObjTrace.Secuencia,
                    TipoMedicamento = ObjTrace.TipoMedicamento

                };

                //objAudit.Type = "V";
                //if (objLista.Count > 1) objAudit.Type = "L";
                //string tempType = objAudit.Type;
                //objAudit = AddAudita(new SS_HC_Medicamento(), new SS_HC_Medicamento(), DataKey, objAudit.Type);
                //String xlmIn = XMLString(objLista, new List<SS_HC_Medicamento>(), "SS_HC_Medicamento");
                //objAudit.TableName = "SS_HC_Medicamento";
                //objAudit.Type = tempType;
                //objAudit.VistaData = xlmIn;
                //context.Entry(objAudit).State = EntityState.Added;
                //context.SaveChanges();

                //Agregado auditoria --> N° 2
                using (var contextEnty = new WEB_ERPSALUDEntities())
                {
                    //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                    List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                    //dynamic DataKey;
                    DataKey = new
                    {
                        UnidadReplicacion = ObjTrace.UnidadReplicacion,
                        IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                        EpisodioClinico = ObjTrace.EpisodioClinico,
                        IdPaciente = ObjTrace.IdPaciente,
                        Secuencia = ObjTrace.Secuencia
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
                    objAudit = Control.AddAudita(new SS_HC_Medicamento_FE_Epi2(), new SS_HC_Medicamento_FE_Epi2(), DataKey, objAudit.Type);
                    String xlmIn = XMLStringEpicri(objLista, "SS_HC_Medicamento_FE");
                    objAudit.TableName = "SS_HC_Medicamento_FE_Epi2";
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

        public virtual String XMLStringEpi(List<SS_HC_Medicamento_FE_Epi2> obPadre, String TablaID)
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

        public int MedicamentoIndicaciones(SS_HC_Indicaciones_FE ObjTrace)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new ModelFormularios())
            {
                iReturnValue = context.USP_IndicacionesFE(
                    ObjTrace.UnidadReplicacion, ObjTrace.IdPaciente,
                    ObjTrace.EpisodioClinico, ObjTrace.IdEpisodioAtencion, ObjTrace.SecuenciaMedicamento, ObjTrace.Secuencia, ObjTrace.TipoRegistro, ObjTrace.Correlativo,
                    ObjTrace.IdTipoIndicacion, ObjTrace.Descripcion, ObjTrace.GrupoMedicamento, ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion,
                    ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }

            return valorRetorno;
        }

        public List<SS_HC_Indicaciones_FE> MedicamentoIndicacionesListar(SS_HC_Indicaciones_FE ObjTrace)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;
            List<SS_HC_Indicaciones_FE> objLista = new List<SS_HC_Indicaciones_FE>();
            using (var context = new ModelFormularios())
            {
                objLista = context.USP_IndicacionesListarFE(ObjTrace.UnidadReplicacion, ObjTrace.IdPaciente,
                    ObjTrace.EpisodioClinico, ObjTrace.IdEpisodioAtencion, ObjTrace.SecuenciaMedicamento, ObjTrace.Secuencia, ObjTrace.TipoRegistro, ObjTrace.Correlativo,
                    ObjTrace.IdTipoIndicacion, ObjTrace.Descripcion, ObjTrace.GrupoMedicamento, ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion,
                    ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version).ToList();
                DataKey = new
                {
                    UnidadReplicacion = ObjTrace.UnidadReplicacion,
                    IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                    EpisodioClinico = ObjTrace.EpisodioClinico,
                    IdPaciente = ObjTrace.IdPaciente,
                    SecuenciaMedicamento = ObjTrace.SecuenciaMedicamento,
                    Secuencia = ObjTrace.Secuencia
                };
                SS_HC_Medicamento_FE objFiltro = new SS_HC_Medicamento_FE();
                objFiltro.UnidadReplicacion = ObjTrace.UnidadReplicacion;
                objFiltro.IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion;
                objFiltro.EpisodioClinico = ObjTrace.EpisodioClinico;
                objFiltro.IdPaciente = ObjTrace.IdPaciente;
                objFiltro.Secuencia = ObjTrace.SecuenciaMedicamento;
                List<SS_HC_Medicamento_FE> listaFiltro = new List<SS_HC_Medicamento_FE>();
                listaFiltro.Add(objFiltro);

                //objAudit.Type = "V";
                //if (objLista.Count > 1) objAudit.Type = "L";
                //string tempType = objAudit.Type;
                //objAudit = AddAudita(new SS_HC_Indicaciones(), new SS_HC_Indicaciones(), DataKey, objAudit.Type);
                //String xlmIn = XMLString(listaFiltro, new List<SS_HC_Medicamento>(), "SS_HC_Indicaciones");
                //objAudit.TableName = "SS_HC_Indicaciones";
                //objAudit.Type = tempType;
                //objAudit.VistaData = xlmIn;
                //context.Entry(objAudit).State = EntityState.Added;
                //context.SaveChanges();

            }
            return objLista;
        }

        public int setMantenimientoNutriente(List<SS_HC_Medicamento_FE> listaCabecera01, List<SS_HC_Medicamento_FE> listaCabecera02)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        if (listaCabecera01 != null)
                        {
                            foreach (SS_HC_Medicamento_FE ObjTrace in listaCabecera01)
                            {
                                if (ObjTrace.Accion == "DELETEINDIV")
                                {
                                    //context.Entry(ObjTrace).State = EntityState.Deleted;
                                    //Agregado auditoria --> Eliminar
                                    //dynamic DataKey = null;
                                    //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                                    #region AuditoriaEliminar
                                    using (var contextEnty = new WEB_ERPSALUDEntities())
                                    {
                                        SS_HC_AuditRoyal objAuditoria = new SS_HC_AuditRoyal();
                                        List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                                        dynamic DataKeyy;
                                        DataKey = new
                                        {
                                            UnidadReplicacion = ObjTrace.UnidadReplicacion,
                                            IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                                            EpisodioClinico = ObjTrace.EpisodioClinico,
                                            IdPaciente = ObjTrace.IdPaciente
                                        };

                                        string tempType = objAudit.Type;
                                        objAudit = Control.AddAudita(new SS_HC_Medicamento_FE(), new SS_HC_Medicamento_FE(), DataKey, objAudit.Type);
                                        objAudit.TableName = "SS_HC_Medicamento_FE";
                                        objAudit.Type = "D";
                                        objAudit.Accion = "DELETE";
                                        contextEnty.Entry(objAudit).State = EntityState.Added;
                                        contextEnty.SaveChanges();
                                    }
                                    //--
                                    #endregion
                                }

                                var secuenciaCabPrevia = ObjTrace.Secuencia;
                                iReturnValue = context.USP_SS_GE_Medicamento_FE(
                                 ObjTrace.UnidadReplicacion, ObjTrace.IdPaciente,
                                 ObjTrace.EpisodioClinico,
                                 ObjTrace.IdEpisodioAtencion,
                                 ObjTrace.Secuencia, ObjTrace.TipoMedicamento, ObjTrace.IdUnidadMedida,
                                 ObjTrace.Linea, ObjTrace.Familia, ObjTrace.SubFamilia, ObjTrace.TipoComponente,
                                 ObjTrace.CodigoComponente, ObjTrace.IdVia, ObjTrace.Dosis, ObjTrace.DiasTratamiento,
                                 ObjTrace.Frecuencia, ObjTrace.Cantidad, ObjTrace.IndicadorEPS, ObjTrace.TipoReceta,
                                 ObjTrace.Forma, ObjTrace.GrupoMedicamento, ObjTrace.Comentario, ObjTrace.IndicadorAuditoria, ObjTrace.UsuarioAuditoria,
                                 ObjTrace.TipoComida,
                                 ObjTrace.VolumenDia, ObjTrace.FrecuenciaToma, ObjTrace.Presentacion, ObjTrace.Hora,
                                 ObjTrace.Periodo, ObjTrace.UnidadTiempo, ObjTrace.Indicacion,
                                 ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                                 ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version, ObjTrace.IdPadreNutriente, ObjTrace.IdHijoNutriente, ObjTrace.SecuencialHCE, ObjTrace.CodAlmacen).SingleOrDefault();

                                int secuenciaMedico = Convert.ToInt32(iReturnValue.ToString().Trim());
                                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                                #region AuditoriaUpdate
                                using (var contextEnty = new WEB_ERPSALUDEntities())
                                {
                                    SS_HC_AuditRoyal objAuditoria = new SS_HC_AuditRoyal();
                                    List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                                    dynamic DataKeyy;
                                    DataKey = new
                                    {
                                        UnidadReplicacion = ObjTrace.UnidadReplicacion,
                                        IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                                        EpisodioClinico = ObjTrace.EpisodioClinico,
                                        IdPaciente = ObjTrace.IdPaciente
                                    };

                                    string tempType = objAudit.Type;
                                    objAudit = Control.AddAudita(new SS_HC_Medicamento_FE(), new SS_HC_Medicamento_FE(), DataKey, objAudit.Type);
                                    objAudit.TableName = "SS_HC_Medicamento_FE";
                                    objAudit.Type = ObjTrace.Accion.Substring(0, 1);
                                    objAudit.Accion = ObjTrace.Accion;
                                    contextEnty.Entry(objAudit).State = EntityState.Added;
                                    contextEnty.SaveChanges();
                                }
                                #endregion
                            }

                        }
                        if (listaCabecera02 != null)
                        {
                            foreach (SS_HC_Medicamento_FE ObjTrace in listaCabecera02)
                            {
                                iReturnValue = context.USP_SS_GE_Medicamento_FE(
                                 ObjTrace.UnidadReplicacion, ObjTrace.IdPaciente,
                                 ObjTrace.EpisodioClinico,
                                 ObjTrace.IdEpisodioAtencion,
                                 ObjTrace.Secuencia, ObjTrace.TipoMedicamento, ObjTrace.IdUnidadMedida,
                                 ObjTrace.Linea, ObjTrace.Familia, ObjTrace.SubFamilia, ObjTrace.TipoComponente,
                                 ObjTrace.CodigoComponente, ObjTrace.IdVia, ObjTrace.Dosis, ObjTrace.DiasTratamiento,
                                 ObjTrace.Frecuencia, ObjTrace.Cantidad, ObjTrace.IndicadorEPS, ObjTrace.TipoReceta,
                                 ObjTrace.Forma, ObjTrace.GrupoMedicamento, ObjTrace.Comentario, ObjTrace.IndicadorAuditoria, ObjTrace.UsuarioAuditoria,
                                 ObjTrace.TipoComida, ObjTrace.VolumenDia, ObjTrace.FrecuenciaToma, ObjTrace.Presentacion, ObjTrace.Hora,
                                 ObjTrace.Periodo, ObjTrace.UnidadTiempo, ObjTrace.Indicacion,
                                 ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                                 ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version, ObjTrace.IdPadreNutriente, ObjTrace.IdHijoNutriente, ObjTrace.SecuencialHCE, ObjTrace.CodAlmacen).SingleOrDefault();
                                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                            }
                        }
                        context.SaveChanges();
                        dbContextTransaction.Commit();
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

        public int setMantenimientoGrupoCopia(SS_HC_Medicamento_FE ObjTraces, List<SS_HC_Medicamento_FE> listaCabecera01, List<SS_HC_Medicamento_FE> listaCabecera02, List<SS_HC_Indicaciones_FE> listaTraceDetalle01, List<SS_HC_Indicaciones_FE> listaDetalle01)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        if (listaCabecera01 != null)
                        {
                            foreach (var ObjTrace in listaCabecera01)
                            {

                                ObjTrace.GrupoMedicamento = 0;

                                var InformacionObj = (from t in context.SS_HC_Medicamento_FE
                                                      where t.IdPaciente == ObjTrace.IdPaciente
                                                      && t.EpisodioClinico == ObjTrace.EpisodioClinico
                                                      && t.IdEpisodioAtencion == ObjTrace.IdEpisodioAtencion
                                                      && t.Secuencia == ObjTrace.Secuencia
                                                      orderby t.IdEpisodioAtencion descending
                                                      select t).SingleOrDefault();
                                if (InformacionObj == null) InformacionObj = new SS_HC_Medicamento_FE();

                                ObjTrace.Version = "CCEPF101";

                                var secuenciaCabPrevia = ObjTrace.Secuencia;
                                iReturnValue = context.USP_SS_GE_Medicamento_FE(
                                   ObjTrace.UnidadReplicacion.Trim(), ObjTrace.IdPaciente,
                                   ObjTrace.EpisodioClinico,
                                   ObjTrace.IdEpisodioAtencion,
                                   ObjTrace.Secuencia, ObjTrace.TipoMedicamento, ObjTrace.IdUnidadMedida,
                                   ObjTrace.Linea.Trim(), ObjTrace.Familia.Trim(), ObjTrace.SubFamilia.Trim(), ObjTrace.TipoComponente,
                                   ObjTrace.CodigoComponente, ObjTrace.IdVia, ObjTrace.Dosis, ObjTrace.DiasTratamiento,
                                   ObjTrace.Frecuencia, ObjTrace.Cantidad, ObjTrace.IndicadorEPS, ObjTrace.TipoReceta,
                                   ObjTrace.Forma, ObjTrace.GrupoMedicamento, ObjTrace.Comentario, ObjTrace.IndicadorAuditoria, ObjTrace.UsuarioAuditoria,
                                   ObjTrace.TipoComida, ObjTrace.VolumenDia, ObjTrace.FrecuenciaToma, ObjTrace.Presentacion, ObjTrace.Hora,
                                   ObjTrace.Periodo, ObjTrace.UnidadTiempo, ObjTrace.Indicacion,
                                   ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                                   ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version, ObjTrace.IdPadreNutriente, ObjTrace.IdHijoNutriente, ObjTrace.SecuencialHCE, ObjTrace.CodAlmacen
                                ).SingleOrDefault();

                                int secuenciaMedico = Convert.ToInt32(iReturnValue.ToString().Trim());
                                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                                
                                //detalle
                                if (listaTraceDetalle01 != null)
                                {
                                    foreach (var ObjTraceDetalle01 in listaTraceDetalle01)
                                    {
                                        if (ObjTraceDetalle01.SecuenciaMedicamento == secuenciaCabPrevia)
                                        {
                                            var InformacionObjDell = (from t in context.SS_HC_Indicaciones_FE
                                                                      where t.IdPaciente == ObjTraceDetalle01.IdPaciente
                                                                      && t.EpisodioClinico == ObjTraceDetalle01.EpisodioClinico
                                                                      && t.IdEpisodioAtencion == ObjTraceDetalle01.IdEpisodioAtencion
                                                                      && t.SecuenciaMedicamento == ObjTraceDetalle01.SecuenciaMedicamento
                                                                      && t.Secuencia == ObjTraceDetalle01.Secuencia

                                                                      orderby t.IdEpisodioAtencion descending
                                                                      select t).SingleOrDefault();
                                            if (InformacionObjDell == null) InformacionObjDell = new SS_HC_Indicaciones_FE();
                                            ObjTraceDetalle01.Version = "CCEPF101";
                                            ObjTraceDetalle01.SecuenciaMedicamento = secuenciaMedico;
                                            iReturnValue = context.USP_IndicacionesFE(
                                            ObjTraceDetalle01.UnidadReplicacion.Trim(), ObjTraceDetalle01.IdPaciente,
                                            ObjTraceDetalle01.EpisodioClinico, ObjTraceDetalle01.IdEpisodioAtencion, ObjTraceDetalle01.SecuenciaMedicamento, ObjTraceDetalle01.Secuencia, ObjTraceDetalle01.TipoRegistro, ObjTraceDetalle01.Correlativo,
                                            ObjTraceDetalle01.IdTipoIndicacion, ObjTraceDetalle01.Descripcion, ObjTraceDetalle01.GrupoMedicamento, ObjTraceDetalle01.Estado, ObjTraceDetalle01.UsuarioCreacion, ObjTraceDetalle01.FechaCreacion,
                                            ObjTraceDetalle01.UsuarioModificacion, ObjTraceDetalle01.FechaModificacion, ObjTraceDetalle01.Accion, ObjTraceDetalle01.Version).SingleOrDefault();
                                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                                            DataKey = new
                                            {
                                                UnidadReplicacion = ObjTraceDetalle01.UnidadReplicacion,
                                                IdEpisodioAtencion = ObjTraceDetalle01.IdEpisodioAtencion,
                                                EpisodioClinico = ObjTraceDetalle01.EpisodioClinico,
                                                IdPaciente = ObjTraceDetalle01.IdPaciente,
                                                SecuenciaMedicamento = ObjTraceDetalle01.SecuenciaMedicamento,
                                                Secuencia = ObjTraceDetalle01.Secuencia


                                            };
                                        }
                                    }
                                }

                                if (listaDetalle01 != null)
                                {
                                    foreach (var objDetalle01 in listaDetalle01)
                                    {
                                        if (objDetalle01.SecuenciaMedicamento == secuenciaCabPrevia)
                                        {
                                            objDetalle01.Version = "CCEPF101";

                                            objDetalle01.SecuenciaMedicamento = secuenciaMedico;
                                            iReturnValue = context.USP_IndicacionesFE(
                                            objDetalle01.UnidadReplicacion.Trim(), objDetalle01.IdPaciente,
                                            objDetalle01.EpisodioClinico, objDetalle01.IdEpisodioAtencion, objDetalle01.SecuenciaMedicamento, objDetalle01.Secuencia, objDetalle01.TipoRegistro, objDetalle01.Correlativo,
                                            objDetalle01.IdTipoIndicacion, objDetalle01.Descripcion, objDetalle01.GrupoMedicamento, objDetalle01.Estado, objDetalle01.UsuarioCreacion, objDetalle01.FechaCreacion,
                                            objDetalle01.UsuarioModificacion, objDetalle01.FechaModificacion, objDetalle01.Accion, objDetalle01.Version).SingleOrDefault();
                                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                                        }

                                    }
                                }
                            }
                        }
                        if (listaCabecera02 != null)
                        {
                            foreach (var ObjTrace in listaCabecera02)
                            {
                                ObjTrace.Version = "CCEPF101";

                                iReturnValue = context.USP_SS_GE_Medicamento_FE(
                                   ObjTrace.UnidadReplicacion.Trim(), ObjTrace.IdPaciente,
                                   ObjTrace.EpisodioClinico,
                                   ObjTrace.IdEpisodioAtencion,
                                   ObjTrace.Secuencia, ObjTrace.TipoMedicamento, ObjTrace.IdUnidadMedida,
                                   ObjTrace.Linea.Trim(), ObjTrace.Familia.Trim(), ObjTrace.SubFamilia.Trim(), ObjTrace.TipoComponente,
                                   ObjTrace.CodigoComponente, ObjTrace.IdVia, ObjTrace.Dosis, ObjTrace.DiasTratamiento,
                                   ObjTrace.Frecuencia, ObjTrace.Cantidad, ObjTrace.IndicadorEPS, ObjTrace.TipoReceta,
                                   ObjTrace.Forma, ObjTrace.GrupoMedicamento, ObjTrace.Comentario, ObjTrace.IndicadorAuditoria, ObjTrace.UsuarioAuditoria,
                                   ObjTrace.TipoComida, ObjTrace.VolumenDia, ObjTrace.FrecuenciaToma, ObjTrace.Presentacion, ObjTrace.Hora,
                                   ObjTrace.Periodo, ObjTrace.UnidadTiempo, ObjTrace.Indicacion,
                                   ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                                   ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version, ObjTrace.IdPadreNutriente, ObjTrace.IdHijoNutriente, ObjTrace.SecuencialHCE, ObjTrace.CodAlmacen
                                ).SingleOrDefault();
                                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                            }
                        }
                        context.SaveChanges();
                        dbContextTransaction.Commit();
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

        public int setMantenimientoNotificaciones(int flat, List<SS_HC_Medicamento_FE> listaCabecera01, SS_FA_SolicitudProductoDetalle objEntity2)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            SS_FA_Notificacion cabnotificacion = new SS_FA_Notificacion();

            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        if (flat == 1)
                        {
                            List<SS_HC_Medicamento_FE> LISTNEWCAB = listaCabecera01.Where(x => x.Accion == "NUEVO").ToList();
                            cabnotificacion.IdNotificacion = 0;
                            if (LISTNEWCAB.Count > 0)
                            {
                                cabnotificacion.UnidadReplicacion = LISTNEWCAB[0].UnidadReplicacion;
                                cabnotificacion.IdEpisodioAtencion = LISTNEWCAB[0].IdEpisodioAtencion;
                                cabnotificacion.IdPaciente = LISTNEWCAB[0].IdPaciente;
                                cabnotificacion.EpisodioClinico = LISTNEWCAB[0].EpisodioClinico;
                                //cabnotificacion.Observacion = LISTNEWCAB[0].Comentario.Substring(200);
                                cabnotificacion.Accion = "NUEVO";
                                cabnotificacion.Estado = 2;
                                cabnotificacion.FechaCreacion = DateTime.Now;
                                cabnotificacion.UsuarioCreacion = LISTNEWCAB[0].UsuarioCreacion;
                                if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA")
                                {
                                    List<SS_FA_Notificacion> objCountnoti = context.SS_FA_Notificacion
                                           .Where(t => t.UnidadReplicacion == cabnotificacion.UnidadReplicacion &&
                                               t.IdPaciente == cabnotificacion.IdPaciente &&
                                               t.EpisodioClinico == cabnotificacion.EpisodioClinico &&
                                               t.IdEpisodioAtencion == cabnotificacion.IdEpisodioAtencion)
                                               .OrderByDescending(x => x.IdNotificacion)
                                               .ToList();

                                    string strNoche = DateTime.Today.ToShortDateString() + " 00:00";
                                    DateTime consulfec = Convert.ToDateTime(strNoche);
                                    var objCount = context.SS_FA_Notificacion.Where(x => x.FechaCreacion > consulfec).ToList()
                                        .DefaultIfEmpty().Count();

                                    if (objCountnoti.Count == 0)
                                        cabnotificacion.IdNotificacion = 1;
                                    else
                                        cabnotificacion.IdNotificacion = objCountnoti[0].IdNotificacion + 1;

                                    String diaInString = DateTime.Now.ToString("dd");
                                    String mesInString = DateTime.Now.ToString("MM");
                                    String yearInString = DateTime.Now.ToString("yyyy");

                                    String nro_informe = "";
                                    string ini = yearInString + mesInString + diaInString + "0000";
                                    objCount = objCount + 1;
                                    nro_informe = ini + objCount;
                                    cabnotificacion.NumeroDocumento = nro_informe.Substring(0, 13);
                                    cabnotificacion.Version = "CCEPF101";
                                    //context.Entry(cabnotificacion).State = EntityState.Added;

                                    valorRetorno = context.Database.ExecuteSqlCommand("INSERT INTO SS_FA_Notificacion (UnidadReplicacion " +
                                       " ,IdEpisodioAtencion,IdPaciente,EpisodioClinico,IdNotificacion," +
                                       " NumeroDocumento,Observacion,Estado,UsuarioCreacion," +
                                       " FechaCreacion,UsuarioModificacion,FechaModificacion,Accion,Version)" +
                                       " values('" + cabnotificacion.UnidadReplicacion + "'," + cabnotificacion.IdEpisodioAtencion + "," +
                                           +cabnotificacion.IdPaciente + "," + cabnotificacion.EpisodioClinico + "," +
                                           +cabnotificacion.IdNotificacion + "," +
                                       "'" + cabnotificacion.NumeroDocumento + "','" + cabnotificacion.Observacion + "'," +
                                           +cabnotificacion.Estado + ", '" + cabnotificacion.UsuarioCreacion + "'," +
                                       "'" + DateTime.Now.ToString("yyyy-MM-dd hh:mm") + "', '" + cabnotificacion.UsuarioModificacion + "'," +
                                       "'" + DateTime.Now.ToString("yyyy-MM-dd hh:mm") + "', '" + cabnotificacion.Accion + "'," +
                                       "'" + cabnotificacion.Version + "')");
                                }

                                foreach (var ObjTrace in listaCabecera01)
                                {
                                    ObjTrace.GrupoMedicamento = 0;
                                    //NOTIFICAION DETALLE
                                    if (ObjTrace.Accion == "NUEVO")
                                    {
                                        SS_FA_NotificacionDetalle detalleNoti = new SS_FA_NotificacionDetalle();
                                        detalleNoti.UnidadReplicacion = ObjTrace.UnidadReplicacion;
                                        detalleNoti.IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion;
                                        detalleNoti.IdPaciente = ObjTrace.IdPaciente;
                                        detalleNoti.EpisodioClinico = ObjTrace.EpisodioClinico;
                                        detalleNoti.IdNotificacion = cabnotificacion.IdNotificacion;
                                        ObjTrace.Estado = 2;
                                        //obtener secuencia
                                        var secuenciaMax = context.SS_FA_NotificacionDetalle.Where(t =>
                                            t.IdPaciente == detalleNoti.IdPaciente && t.IdNotificacion == detalleNoti.IdNotificacion
                                            ).DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);
                                        detalleNoti.Secuencia = secuenciaMax + 1;
                                        valorRetorno = context.Database.ExecuteSqlCommand("INSERT INTO SS_FA_NotificacionDetalle (UnidadReplicacion " +
                                           " ,IdEpisodioAtencion,IdPaciente,EpisodioClinico,IdNotificacion,Secuencia," +
                                           " NumeroDocumento,Cantidad,Linea,Familia,SubFamilia,TipoComponente,CodigoComponente," +
                                           " GrupoMedicamento,Estado,UsuarioCreacion," +
                                           " FechaCreacion,UsuarioModificacion,FechaModificacion,Accion," +
                                           " Version,codigoauxiliar4,SecuencialHCE)" +
                                           " values('" + ObjTrace.UnidadReplicacion + "'," + ObjTrace.IdEpisodioAtencion + "," +
                                                +ObjTrace.IdPaciente + ", " + ObjTrace.EpisodioClinico + "," +
                                                +cabnotificacion.IdNotificacion + "," + detalleNoti.Secuencia + "," +
                                           "'" + cabnotificacion.NumeroDocumento + "', " + ObjTrace.Cantidad + "," +
                                           "'" + ObjTrace.Linea + "', '" + ObjTrace.Familia + "'," +
                                           "'" + ObjTrace.SubFamilia + "', '" + ObjTrace.TipoComponente + "'," +
                                           "'" + ObjTrace.CodigoComponente + "'," + ObjTrace.GrupoMedicamento + "," +
                                               +ObjTrace.Estado + ", '" + ObjTrace.UsuarioCreacion + "'," +
                                           "'" + DateTime.Now.ToString("yyyy-MM-dd hh:mm") + "', '" + ObjTrace.UsuarioModificacion + "'," +
                                           "'" + DateTime.Now.ToString("yyyy-MM-dd hh:mm") + "', '" + ObjTrace.Accion + "'," +
                                           "'" + ObjTrace.Version + "', '" + ObjTrace.SecuencialHCE + "'," +
                                           "'" + ObjTrace.SecuencialHCE + "')");

                                        //detalleNoti.Secuencia = secuenciaMax + 1;
                                        //detalleNoti.NumeroDocumento = cabnotificacion.NumeroDocumento;
                                        //detalleNoti.Cantidad = ObjTrace.Cantidad;
                                        //detalleNoti.Linea = ObjTrace.Linea;
                                        //detalleNoti.Familia = ObjTrace.Familia;
                                        //detalleNoti.SubFamilia = ObjTrace.SubFamilia;
                                        //detalleNoti.CodigoComponente = ObjTrace.CodigoComponente;
                                        //detalleNoti.GrupoMedicamento = ObjTrace.GrupoMedicamento;
                                        //detalleNoti.Estado = 2;
                                        //detalleNoti.UsuarioCreacion = ObjTrace.UsuarioCreacion;
                                        //detalleNoti.FechaCreacion = DateTime.Now;
                                        //detalleNoti.codigoauxiliar4 = ObjTrace.SecuencialHCE;
                                        //detalleNoti.SecuencialHCE = ObjTrace.SecuencialHCE;
                                        //detalleNoti.UsuarioModificacion = ObjTrace.UsuarioModificacion;
                                        //detalleNoti.FechaModificacion = DateTime.Now;
                                        //detalleNoti.Accion = ObjTrace.Accion;
                                        //detalleNoti.Version = "CCEPF101";
                                        //context.Entry(detalleNoti).State = EntityState.Added;
                                    }
                                }
                            }
                        }
                        if (flat == 2)
                        {
                            if (objEntity2.SecuencialHCE.Length > 0)
                            {
                                //  var ObjeDetalle = context.SS_FA_NotificacionDetalle.Where(x => x.codigoauxiliar4 == objEntity2.SecuencialHCE).ToList();
                                //using (var ctx = new WEB_ERPSALUDEntities())
                                //{
                                valorRetorno = context.Database.ExecuteSqlCommand("UPDATE SS_FA_NotificacionDetalle  SET ESTADO =3 where SecuencialHCE = '" + objEntity2.SecuencialHCE + "'");
                                //}
                            }

                        }

                        context.SaveChanges();
                        dbContextTransaction.Commit();
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

        public int setMantenimientoMedicamentosAuditoria(int IndEvento, SS_HC_Medicamento_FE ObjTrace)
        {
            //IndEvento indica si es 1==nuevo o 2==update   System.Nullable<int> iReturnValue;
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            System.Nullable<int> valorRetorno = 0;      
            try
            {
                using (var contextEnty = new WEB_ERPSALUDEntities())
                {
                    SS_HC_AuditRoyal objAuditoria = new SS_HC_AuditRoyal();
                    List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                    DataKey = new
                    {
                        UnidadReplicacion = ObjTrace.UnidadReplicacion,
                        IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                        EpisodioClinico = ObjTrace.EpisodioClinico,
                        IdPaciente = ObjTrace.IdPaciente
                    };
                    string tempType = objAudit.Type;
                    objAudit = Control.AddAudita(new SS_HC_Medicamento_FE(), ObjTrace, DataKey, objAudit.Type);
                    if (IndEvento == 1)
                    {
                        objAudit.Accion = ObjTrace.Accion;
                    }
                    else
                    {
                        objAudit.Accion = "UPDATE";
                    }
                    objAudit.TableName = "SS_HC_Medicamento_FE";
                    objAudit.Type = objAudit.Accion.Substring(0, 1);
                    contextEnty.Entry(objAudit).State = EntityState.Added;
                    contextEnty.SaveChanges();
                    valorRetorno = 1;
                }
            }
            catch (Exception ex)
            {
                // dbContextTransaction.Rollback();
                valorRetorno = -1;
                throw ex;
            }

            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        ObjTrace.GrupoMedicamento = 0;
                        var secuenciaCabPrevia = ObjTrace.Secuencia;
                        valorRetorno = context.USP_SS_GE_Medicamento_FE(
                           ObjTrace.UnidadReplicacion.Trim(), ObjTrace.IdPaciente,
                           ObjTrace.EpisodioClinico, ObjTrace.IdEpisodioAtencion,                          
                           ObjTrace.Secuencia, ObjTrace.TipoMedicamento, ObjTrace.IdUnidadMedida,
                           ObjTrace.Linea.Trim(), ObjTrace.Familia.Trim(), ObjTrace.SubFamilia.Trim(), ObjTrace.TipoComponente,
                           ObjTrace.CodigoComponente, ObjTrace.IdVia, ObjTrace.Dosis, ObjTrace.DiasTratamiento,
                           ObjTrace.Frecuencia, ObjTrace.Cantidad, ObjTrace.IndicadorEPS, ObjTrace.TipoReceta,
                           ObjTrace.Forma, ObjTrace.GrupoMedicamento, ObjTrace.Comentario, ObjTrace.IndicadorAuditoria, ObjTrace.UsuarioAuditoria,
                           ObjTrace.TipoComida, ObjTrace.VolumenDia, ObjTrace.FrecuenciaToma, ObjTrace.Presentacion, ObjTrace.Hora,
                           ObjTrace.Periodo, ObjTrace.UnidadTiempo, ObjTrace.Indicacion,ObjTrace.Estado, ObjTrace.UsuarioCreacion,
                           ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version,
                           ObjTrace.IdPadreNutriente, ObjTrace.IdHijoNutriente, ObjTrace.SecuencialHCE, ObjTrace.CodAlmacen
                        ).SingleOrDefault();
                        context.SaveChanges();
                        dbContextTransaction.Commit();
                    }
                    catch (Exception ex)
                    {
                        valorRetorno = 0;
                        dbContextTransaction.Rollback();
                        throw ex;
                    }
                }
            }
    
            return Convert.ToInt32(valorRetorno);
        }

        public int setMantenimientoGrupo(SS_HC_Medicamento_FE ObjTraces, List<SS_HC_Medicamento_FE> listaCabecera01, List<SS_HC_Medicamento_FE> listaCabecera02, List<SS_HC_Indicaciones_FE> listaTraceDetalle01, List<SS_HC_Indicaciones_FE> listaDetalle01)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            SS_FA_Notificacion cabnotificacion = new SS_FA_Notificacion();

            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        if (listaCabecera01 != null)
                        {
                            foreach (var ObjTrace in listaCabecera01)
                            {
                                int contadorDet = 0;
                                ObjTrace.GrupoMedicamento = 0;

                                var InformacionObj = (from t in context.SS_HC_Medicamento_FE
                                                      where t.IdPaciente == ObjTrace.IdPaciente
                                                      && t.EpisodioClinico == ObjTrace.EpisodioClinico
                                                      && t.IdEpisodioAtencion == ObjTrace.IdEpisodioAtencion
                                                      && t.Secuencia == ObjTrace.Secuencia
                                                      orderby t.IdEpisodioAtencion descending
                                                      select t).SingleOrDefault();
                                if (InformacionObj == null) InformacionObj = new SS_HC_Medicamento_FE();

                                var secuenciaCabPrevia = ObjTrace.Secuencia;
                                iReturnValue = context.USP_SS_GE_Medicamento_FE(
                                   ObjTrace.UnidadReplicacion.Trim(), ObjTrace.IdPaciente,    ObjTrace.EpisodioClinico,   ObjTrace.IdEpisodioAtencion, 
                                   ObjTrace.Secuencia, ObjTrace.TipoMedicamento, ObjTrace.IdUnidadMedida,
                                   ObjTrace.Linea.Trim(), ObjTrace.Familia.Trim(), ObjTrace.SubFamilia.Trim(), ObjTrace.TipoComponente,
                                   ObjTrace.CodigoComponente, ObjTrace.IdVia, ObjTrace.Dosis, ObjTrace.DiasTratamiento,
                                   ObjTrace.Frecuencia, ObjTrace.Cantidad, ObjTrace.IndicadorEPS, ObjTrace.TipoReceta,
                                   ObjTrace.Forma, ObjTrace.GrupoMedicamento, ObjTrace.Comentario, ObjTrace.IndicadorAuditoria, ObjTrace.UsuarioAuditoria,
                                   ObjTrace.TipoComida, ObjTrace.VolumenDia, ObjTrace.FrecuenciaToma, ObjTrace.Presentacion, ObjTrace.Hora,
                                   ObjTrace.Periodo, ObjTrace.UnidadTiempo, ObjTrace.Indicacion,
                                   ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                                   ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version, ObjTrace.IdPadreNutriente, ObjTrace.IdHijoNutriente, ObjTrace.SecuencialHCE, ObjTrace.CodAlmacen
                                ).SingleOrDefault();

                                int secuenciaMedico = Convert.ToInt32(iReturnValue.ToString().Trim());
                                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                                //using (var contextEnty = new WEB_ERPSALUDEntities())
                                //{
                                //    SS_HC_AuditRoyal objAuditoria = new SS_HC_AuditRoyal();
                                //    List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                                //    DataKey = new
                                //    {
                                //        UnidadReplicacion = ObjTrace.UnidadReplicacion,
                                //        IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                                //        EpisodioClinico = ObjTrace.EpisodioClinico,
                                //        IdPaciente = ObjTrace.IdPaciente
                                //    };

                                //    string tempType = objAudit.Type;
                                //    objAudit = Control.AddAudita(ObjTrace, new SS_HC_Medicamento_FE(), DataKey, objAudit.Type);
                                //    objAudit.TableName = "SS_HC_Medicamento_FE";
                                //    objAudit.Type = ObjTrace.Accion.Substring(0, 1);
                                //    objAudit.Accion = ObjTrace.Accion;
                                //    contextEnty.Entry(objAudit).State = EntityState.Added;
                                //    contextEnty.SaveChanges();
                                //}


                                //detalle
                                if (listaTraceDetalle01 != null)
                                {
                                    foreach (var ObjTraceDetalle01 in listaTraceDetalle01)
                                    {
                                        if (ObjTraceDetalle01.SecuenciaMedicamento == secuenciaCabPrevia)
                                        {
                                            var InformacionObjDell = (from t in context.SS_HC_Indicaciones_FE
                                                                      where t.IdPaciente == ObjTraceDetalle01.IdPaciente
                                                                      && t.EpisodioClinico == ObjTraceDetalle01.EpisodioClinico
                                                                      && t.IdEpisodioAtencion == ObjTraceDetalle01.IdEpisodioAtencion
                                                                      && t.SecuenciaMedicamento == ObjTraceDetalle01.SecuenciaMedicamento
                                                                      && t.Secuencia == ObjTraceDetalle01.Secuencia

                                                                      orderby t.IdEpisodioAtencion descending
                                                                      select t).SingleOrDefault();
                                            if (InformacionObjDell == null) InformacionObjDell = new SS_HC_Indicaciones_FE();

                                            ObjTraceDetalle01.SecuenciaMedicamento = secuenciaMedico;
                                            iReturnValue = context.USP_IndicacionesFE(
                                            ObjTraceDetalle01.UnidadReplicacion.Trim(), ObjTraceDetalle01.IdPaciente,
                                            ObjTraceDetalle01.EpisodioClinico, ObjTraceDetalle01.IdEpisodioAtencion, ObjTraceDetalle01.SecuenciaMedicamento, ObjTraceDetalle01.Secuencia, ObjTraceDetalle01.TipoRegistro, ObjTraceDetalle01.Correlativo,
                                            ObjTraceDetalle01.IdTipoIndicacion, ObjTraceDetalle01.Descripcion, ObjTraceDetalle01.GrupoMedicamento, ObjTraceDetalle01.Estado, ObjTraceDetalle01.UsuarioCreacion, ObjTraceDetalle01.FechaCreacion,
                                            ObjTraceDetalle01.UsuarioModificacion, ObjTraceDetalle01.FechaModificacion, ObjTraceDetalle01.Accion, ObjTraceDetalle01.Version).SingleOrDefault();
                                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                                            //DataKey = new
                                            //{
                                            //    UnidadReplicacion = ObjTraceDetalle01.UnidadReplicacion,
                                            //    IdEpisodioAtencion = ObjTraceDetalle01.IdEpisodioAtencion,
                                            //    EpisodioClinico = ObjTraceDetalle01.EpisodioClinico,
                                            //    IdPaciente = ObjTraceDetalle01.IdPaciente,
                                            //    SecuenciaMedicamento = ObjTraceDetalle01.SecuenciaMedicamento,
                                            //    Secuencia = ObjTraceDetalle01.Secuencia
                                            //};
                                            //objAudit = AddAudita(InformacionObjDell, ObjTraceDetalle01, DataKey, ObjTraceDetalle01.Accion.Substring(0, 1));
                                            //objAudit.TableName = "SS_HC_Indicaciones";
                                            //objAudit.Type = ObjTraceDetalle01.Accion.Substring(0, 1);
                                            //context.Entry(objAudit).State = EntityState.Added;
                                        }
                                    }
                                }

                                if (listaDetalle01 != null)
                                {
                                    foreach (var objDetalle01 in listaDetalle01)
                                    {
                                        if (objDetalle01.SecuenciaMedicamento == secuenciaCabPrevia)
                                        {
                                            objDetalle01.SecuenciaMedicamento = secuenciaMedico;
                                            iReturnValue = context.USP_IndicacionesFE(
                                            objDetalle01.UnidadReplicacion.Trim(), objDetalle01.IdPaciente,
                                            objDetalle01.EpisodioClinico, objDetalle01.IdEpisodioAtencion, objDetalle01.SecuenciaMedicamento, objDetalle01.Secuencia, objDetalle01.TipoRegistro, objDetalle01.Correlativo,
                                            objDetalle01.IdTipoIndicacion, objDetalle01.Descripcion, objDetalle01.GrupoMedicamento, objDetalle01.Estado, objDetalle01.UsuarioCreacion, objDetalle01.FechaCreacion,
                                            objDetalle01.UsuarioModificacion, objDetalle01.FechaModificacion, objDetalle01.Accion, objDetalle01.Version).SingleOrDefault();
                                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                                        }
                                    }
                                }
                            }
                        }
                        if (listaCabecera02 != null)
                        {
                            foreach (var ObjTrace in listaCabecera02)
                            {
                                iReturnValue = context.USP_SS_GE_Medicamento_FE(
                                   ObjTrace.UnidadReplicacion.Trim(), ObjTrace.IdPaciente,
                                   ObjTrace.EpisodioClinico,
                                   ObjTrace.IdEpisodioAtencion,
                                   ObjTrace.Secuencia, ObjTrace.TipoMedicamento, ObjTrace.IdUnidadMedida,
                                   ObjTrace.Linea.Trim(), ObjTrace.Familia.Trim(), ObjTrace.SubFamilia.Trim(), ObjTrace.TipoComponente,
                                   ObjTrace.CodigoComponente, ObjTrace.IdVia, ObjTrace.Dosis, ObjTrace.DiasTratamiento,
                                   ObjTrace.Frecuencia, ObjTrace.Cantidad, ObjTrace.IndicadorEPS, ObjTrace.TipoReceta,
                                   ObjTrace.Forma, ObjTrace.GrupoMedicamento, ObjTrace.Comentario, ObjTrace.IndicadorAuditoria, ObjTrace.UsuarioAuditoria,
                                   ObjTrace.TipoComida, ObjTrace.VolumenDia, ObjTrace.FrecuenciaToma, ObjTrace.Presentacion, ObjTrace.Hora,
                                   ObjTrace.Periodo, ObjTrace.UnidadTiempo, ObjTrace.Indicacion,
                                   ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                                   ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version, ObjTrace.IdPadreNutriente, ObjTrace.IdHijoNutriente, ObjTrace.SecuencialHCE, ObjTrace.CodAlmacen
                                ).SingleOrDefault();
                                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                            }
                        }
                        context.SaveChanges();
                        dbContextTransaction.Commit();
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


        public virtual String XMLStringEpicri(List<SS_HC_Medicamento_FE_Epi2> obPadre, String TablaID)
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

        //Agregado auditoria --> N° 4
        public virtual String XMLString(List<SS_HC_Medicamento_FE> obPadre, String TablaID)
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
        public int setMantenimientoEpi2(SS_HC_Medicamento_FE ObjTraces, List<SS_HC_Medicamento_FE> listaCabecera01, List<SS_HC_Medicamento_FE> listaCabecera02, List<SS_HC_Indicaciones_FE> listaTraceDetalle01, List<SS_HC_Indicaciones_FE> listaDetalle01)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new ModelFormularios())
            {
                //using (var dbContextTransaction = context.Database.BeginTransaction())
                //{
                try
                {
                    if (listaCabecera01 != null)
                    {
                        foreach (var ObjTrace in listaCabecera01)
                        {
                            var InformacionObj = (from t in context.SS_HC_Medicamento_FE_Epi2
                                                  where t.IdPaciente == ObjTrace.IdPaciente
                                                  && t.EpisodioClinico == ObjTrace.EpisodioClinico
                                                  && t.IdEpisodioAtencion == ObjTrace.IdEpisodioAtencion
                                                  && t.Secuencia == ObjTrace.Secuencia
                                                  orderby t.IdEpisodioAtencion descending
                                                  select t).SingleOrDefault();
                            if (InformacionObj == null) InformacionObj = new SS_HC_Medicamento_FE_Epi2();

                            var secuenciaCabPrevia = ObjTrace.Secuencia;
                            iReturnValue = context.SP_SS_GE_Medicamento_FE_Epi2(
                               ObjTrace.UnidadReplicacion.Trim(), ObjTrace.IdPaciente,
                               ObjTrace.EpisodioClinico,
                               ObjTrace.IdEpisodioAtencion,
                               ObjTrace.Secuencia, ObjTrace.TipoMedicamento, ObjTrace.IdUnidadMedida,
                               ObjTrace.Linea.Trim(), ObjTrace.Familia.Trim(), ObjTrace.SubFamilia.Trim(), ObjTrace.TipoComponente,
                               ObjTrace.CodigoComponente, ObjTrace.IdVia, ObjTrace.Dosis, ObjTrace.DiasTratamiento,
                               ObjTrace.Frecuencia, ObjTrace.Cantidad, ObjTrace.IndicadorEPS, ObjTrace.TipoReceta,
                               ObjTrace.Forma, ObjTrace.GrupoMedicamento, ObjTrace.Comentario, ObjTrace.IndicadorAuditoria, ObjTrace.UsuarioAuditoria,
                               ObjTrace.TipoComida, ObjTrace.VolumenDia, ObjTrace.FrecuenciaToma, ObjTrace.Presentacion, ObjTrace.Hora,
                               ObjTrace.Periodo, ObjTrace.UnidadTiempo, ObjTrace.Indicacion,
                               ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                               ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version, ObjTrace.IdPadreNutriente, ObjTrace.IdHijoNutriente
                            ).SingleOrDefault();

                            int secuenciaMedico = Convert.ToInt32(iReturnValue.ToString().Trim());
                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                            DataKey = new
                            {
                                UnidadReplicacion = ObjTrace.UnidadReplicacion,
                                IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                                EpisodioClinico = ObjTrace.EpisodioClinico,
                                IdPaciente = ObjTrace.IdPaciente,
                                Secuencia = ObjTrace.Secuencia,
                                TipoMedicamento = ObjTrace.TipoMedicamento
                            };

                        }
                    }
                    if (listaCabecera02 != null)
                    {
                        foreach (var ObjTrace in listaCabecera02)
                        {
                            iReturnValue = context.USP_SS_GE_Medicamento_FE(
                               ObjTrace.UnidadReplicacion.Trim(), ObjTrace.IdPaciente,
                               ObjTrace.EpisodioClinico,
                               ObjTrace.IdEpisodioAtencion,
                               ObjTrace.Secuencia, ObjTrace.TipoMedicamento, ObjTrace.IdUnidadMedida,
                               ObjTrace.Linea.Trim(), ObjTrace.Familia.Trim(), ObjTrace.SubFamilia.Trim(), ObjTrace.TipoComponente,
                               ObjTrace.CodigoComponente, ObjTrace.IdVia, ObjTrace.Dosis, ObjTrace.DiasTratamiento,
                               ObjTrace.Frecuencia, ObjTrace.Cantidad, ObjTrace.IndicadorEPS, ObjTrace.TipoReceta,
                               ObjTrace.Forma, ObjTrace.GrupoMedicamento, ObjTrace.Comentario, ObjTrace.IndicadorAuditoria, ObjTrace.UsuarioAuditoria,
                               ObjTrace.TipoComida, ObjTrace.VolumenDia, ObjTrace.FrecuenciaToma, ObjTrace.Presentacion, ObjTrace.Hora,
                               ObjTrace.Periodo, ObjTrace.UnidadTiempo, ObjTrace.Indicacion,
                               ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                               ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version, ObjTrace.IdPadreNutriente, ObjTrace.IdHijoNutriente, ObjTrace.SecuencialHCE, ObjTrace.CodAlmacen
                            ).SingleOrDefault();
                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                        }
                    }
                    context.SaveChanges();
                    //dbContextTransaction.Commit();
                }
                catch (Exception ex)
                {
                    //dbContextTransaction.Rollback();
                    throw ex;
                }
                //}
            }
            return valorRetorno;
        }


    }
}
