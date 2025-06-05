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
    public class ApoyoDiagnosticoFERepository
    {

        Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();  //Agregado auditoria --> N° 1
        public int setMantenimiento(SS_HC_ApoyoDiagnostico_FE objSC, List<SS_HC_ApoyoDiagnosticoDet_FE> Detalle)
        {

            int valorRetorno = -1; //ERROR
            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {   SS_HC_ApoyoDiagnostico_FE objAnterior = null;
                        Dictionary<String, int> mapSecuencia = new Dictionary<String, int>();
                        if (objSC != null)
                        {
                         
                            if (objSC.Accion == null) objSC.Accion = "X";
                            if ((objSC.Accion.Substring(0, 1) != "I") && (objSC.Accion.Substring(0, 1) != "N"))
                            {
                                objAnterior = context.SS_HC_ApoyoDiagnostico_FE
                                                         .Where(t =>
                                                             t.UnidadReplicacion == objSC.UnidadReplicacion
                                                               && t.IdPaciente == objSC.IdPaciente
                                                               && t.EpisodioClinico == objSC.EpisodioClinico
                                                               && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                          ).SingleOrDefault();



                                
                            }
                            /**TRANSACCIÓN*/
                            if (objAnterior != null)
                            {
                                if (objSC.Accion == "UPDATE")
                                {
                                    objSC.Version = "CCEPF154";
                                    objAnterior.FechaSolicitada = objSC.FechaSolicitada;
                                    objAnterior.Observacion = objSC.Observacion;
                                    objAnterior.Nombre = objSC.Nombre;
                                    objAnterior.RutaInforme = objSC.RutaInforme;
                                    
                                    //objSC.FechaCreacion = objAnterior.FechaCreacion;
                                    context.Entry(objAnterior).State = EntityState.Modified;
                                }
                            }
                            else
                            {
                                if (objSC.Accion == "NUEVO")
                                {
                                    
                                    objSC.Version = "CCEPF154";
                                    String nro_informe = "";
                                    string ini = "0000";

                                 

                                     var idepisodio = context.SS_HC_ApoyoDiagnostico_FE
                                                         .Where(t =>
                                                             t.UnidadReplicacion == objSC.UnidadReplicacion
                                                          ).Count();

                                    idepisodio++;

                                    //if (idepisodio > 0)
                                    //{
                                    //    idepisodio = (from t in context.SS_HC_ApoyoDiagnostico_FE
                                    //                  where
                                    //                  t.UnidadReplicacion == objSC.UnidadReplicacion

                                    //                  select Convert.ToInt32(t.NroInforme)).Max();
                                    //    idepisodio++;
                                    //}
                                    //else
                                    //{
                                    //    idepisodio++;
                                    //}

                                    nro_informe = ini + idepisodio;
                                    objSC.NroInforme = nro_informe.Substring(0, 5);
                                    context.Entry(objSC).State = EntityState.Added;
                                    //objSC.Accion = objSC.Version;
                                  
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

                        /*********GUARDAR DETALLE***************/
                        if (Detalle != null)
                        {
                            int contadorDet = 0;
                            /**obtener la última secuencia*/
                            var secuenciaMax = context.SS_HC_ApoyoDiagnosticoDet_FE
                                    .Where(t =>
                                            t.IdPaciente == objSC.IdPaciente
                                            && t.UnidadReplicacion == objSC.UnidadReplicacion
                                            && t.EpisodioClinico == objSC.EpisodioClinico
                                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                    ).DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

                            SS_HC_ApoyoDiagnosticoDet_FE objDet = new SS_HC_ApoyoDiagnosticoDet_FE();
                            foreach (SS_HC_ApoyoDiagnosticoDet_FE objDetalle in Detalle)
                            {
                                objDet = new SS_HC_ApoyoDiagnosticoDet_FE();
                                //Nullable<int> secuenciaAux = objDetalle.SecuenciaCab;
                                objDet.IdPaciente = objSC.IdPaciente;
                                objDet.UnidadReplicacion = objSC.UnidadReplicacion;
                                objDet.EpisodioClinico = objSC.EpisodioClinico;
                                objDet.IdEpisodioAtencion = objSC.IdEpisodioAtencion;
                                objDet.Version = objSC.Version;
                                objDet.Secuencia = Convert.ToInt32(objDetalle.Secuencia);
                                objDet.IdProcedimiento = objDetalle.IdProcedimiento;
                                objDet.IdEspecialidad = objDetalle.IdEspecialidad;
                                objDet.TipoOrdenAtencion = objDetalle.TipoOrdenAtencion;
                                objDet.CodigoComponente = objDetalle.CodigoComponente;
                                objDet.IdDiagnostico = objDetalle.IdDiagnostico;
                                objDet.ProcedimientoText = objDetalle.ProcedimientoText;

                                objDet.DiagnosticoText = objDetalle.DiagnosticoText;
                                objDet.UsuarioCreacion = objDetalle.UsuarioCreacion;
                                objDet.UsuarioModificacion = objDetalle.UsuarioModificacion;
                               
                                
                                objDet.Version = "CCEPF154";
                                objDet.Accion = objDetalle.Accion;

                                if (objDet.Accion == "NUEVO") // Insertar Detalle
                                {

                                    objDet.FechaCreacion = objDetalle.FechaCreacion;
                                    objDet.FechaModificacion = objDetalle.FechaModificacion;
                                    contadorDet++;
                                    objDet.Secuencia = secuenciaMax + contadorDet;
                                    //objDet.Accion = "NUEVO";
                                    //COrresponde al código CPT
                                    //if (objDet.CodigoComponente == null || objExamSol.CodigoComponenteCab == "")
                                    //{
                                    //    objDet.CodigoComponenteCab = objEntity.ValorCodigo7; //CASO SEGUS
                                    //}
                                    //objDet.Descripcion = objDetalle.DescripcionExtranjera;
                                    context.Entry(objDet).State = EntityState.Added;
                                }
                                else if (objDet.Accion == "UPDATE") // Actualizar Detalle
                                {
                                    objDet.FechaCreacion = objAnterior.FechaCreacion;
                                    objDet.FechaModificacion = objDetalle.FechaModificacion;
                                    context.Entry(objDet).State = EntityState.Modified;
                                    //mapSecuencia.Add("" + secuenciaAux, objDet.Secuencia);
                                }
                                else if (objDet.Accion == "DELETE")  // Eliminar Detalle
                                {

                                    context.Entry(objDet).State = EntityState.Deleted;

                                    //** Agregado auditoria --> Eliminar
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
                                            IdPaciente = objSC.IdPaciente
                                        };

                                        string tempType = objAudit.Type;



                                        objAudit = Control.AddAudita(new SS_HC_ApoyoDiagnosticoDet_FE(), new SS_HC_ApoyoDiagnosticoDet_FE(), DataKey, objAudit.Type);
                                        objAudit.TableName = "SS_HC_ApoyoDiagnosticoDet_FE ";
                                        objAudit.Type = objSC.Accion.Substring(0, 1); ;
                                        objAudit.Accion = objSC.Accion;
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
                                IdPaciente = objSC.IdPaciente
                            };
                            string tempType = objAudit.Type;
                            objAudit = Control.AddAudita(new SS_HC_ApoyoDiagnostico_FE(), new SS_HC_ApoyoDiagnostico_FE(), DataKey, objAudit.Type);
                            objAudit.TableName = "SS_HC_ApoyoDiagnostico_FE ";
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
                    catch (Exception ex)
                    {
                        dbContextTransaction.Rollback();
                        throw ex;
                    }
                }
            }
            return valorRetorno;
        }


        public int setMantenimiento2(SS_HC_ApoyoDiagnostico_FE objSC, List<SS_HC_ApoyoDiagnosticoDet_FE> Detalle, List<SS_HC_ApoyoDiagnosticoFile_FE> Detalle2)
        {

            int valorRetorno = -1; //ERROR
            System.Nullable<int> iReturnValue;
            string numero = "";

            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        SS_HC_ApoyoDiagnostico_FE objAnterior = null;
                        Dictionary<String, int> mapSecuencia = new Dictionary<String, int>();
                        if (objSC != null)
                        {

                            if (objSC.Accion == null) objSC.Accion = "X";
                            if ((objSC.Accion.Substring(0, 1) != "I") && (objSC.Accion.Substring(0, 1) != "N"))
                            {
                                objAnterior = context.SS_HC_ApoyoDiagnostico_FE
                                                         .Where(t =>
                                                             t.UnidadReplicacion == objSC.UnidadReplicacion
                                                               && t.IdPaciente == objSC.IdPaciente
                                                               && t.EpisodioClinico == objSC.EpisodioClinico
                                                               && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                          ).SingleOrDefault();




                            }
                            /**TRANSACCIÓN*/
                            if (objAnterior != null)
                            {
                                if (objSC.Accion == "UPDATE")
                                {
                                    objSC.Version = "CCEPF154";
                                    objAnterior.FechaSolicitada = objSC.FechaSolicitada;
                                    objAnterior.Observacion = objSC.Observacion;
                                    objAnterior.Nombre = objSC.Nombre;
                                    objAnterior.RutaInforme = objSC.RutaInforme;

                                    //objSC.FechaCreacion = objAnterior.FechaCreacion;
                                    context.Entry(objAnterior).State = EntityState.Modified;
                                }
                            }
                            else
                            {
                                if (objSC.Accion == "NUEVO")
                                {

                                    objSC.Version = "CCEPF154";
                                    String nro_informe = "";
                                    string ini = "0000";

                                
                                    var idepisodio = context.SS_HC_ApoyoDiagnostico_FE
                                                        .Where(t =>
                                                            t.UnidadReplicacion == objSC.UnidadReplicacion &
                                                            t.EpisodioClinico == objSC.EpisodioClinico &
                                                            t.IdPaciente == objSC.IdPaciente

                                                         ).Count();

                                    idepisodio++;

                                    //if (idepisodio > 0)
                                    //{
                                    //    idepisodio = (from t in context.SS_HC_ApoyoDiagnostico_FE
                                    //                  where
                                    //                  t.UnidadReplicacion == objSC.UnidadReplicacion

                                    //                  select Convert.ToInt32(t.NroInforme)).Max();
                                    //    idepisodio++;
                                    //}
                                    //else
                                    //{
                                    //    idepisodio++;
                                    //}

                                    //nro_informe = ini + idepisodio;
                                    nro_informe = idepisodio.ToString("D5");
                                    objSC.NroInforme = nro_informe.Substring(0, 5);
                                    numero = nro_informe.Substring(0, 5);
                                    context.Entry(objSC).State = EntityState.Added;
                                    //objSC.Accion = objSC.Version;

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

                        /*********GUARDAR DETALLE***************/
                        if (Detalle != null)
                        {
                            int contadorDet = 0;
                            /**obtener la última secuencia*/
                            var secuenciaMax = context.SS_HC_ApoyoDiagnosticoDet_FE
                                    .Where(t =>
                                            t.IdPaciente == objSC.IdPaciente
                                            && t.UnidadReplicacion == objSC.UnidadReplicacion
                                            && t.EpisodioClinico == objSC.EpisodioClinico
                                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                    ).DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

                            SS_HC_ApoyoDiagnosticoDet_FE objDet = new SS_HC_ApoyoDiagnosticoDet_FE();
                            foreach (SS_HC_ApoyoDiagnosticoDet_FE objDetalle in Detalle)
                            {
                                objDet = new SS_HC_ApoyoDiagnosticoDet_FE();
                                //Nullable<int> secuenciaAux = objDetalle.SecuenciaCab;
                                objDet.IdPaciente = objSC.IdPaciente;
                                objDet.UnidadReplicacion = objSC.UnidadReplicacion;
                                objDet.EpisodioClinico = objSC.EpisodioClinico;
                                objDet.IdEpisodioAtencion = objSC.IdEpisodioAtencion;
                                objDet.Version = objSC.Version;
                                objDet.Secuencia = Convert.ToInt32(objDetalle.Secuencia);
                                objDet.IdProcedimiento = objDetalle.IdProcedimiento;
                                objDet.IdEspecialidad = objDetalle.IdEspecialidad;
                                objDet.TipoOrdenAtencion = objDetalle.TipoOrdenAtencion;
                                objDet.CodigoComponente = objDetalle.CodigoComponente;
                                objDet.IdDiagnostico = objDetalle.IdDiagnostico;
                                objDet.ProcedimientoText = objDetalle.ProcedimientoText;
                                objDet.FechaCreacion = objDetalle.FechaModificacion;
                                
                                objDet.DiagnosticoText = objDetalle.DiagnosticoText;
                                objDet.UsuarioCreacion = objDetalle.UsuarioCreacion;
                                objDet.UsuarioModificacion = objDetalle.UsuarioModificacion;
                                objDet.FechaModificacion = objDetalle.FechaModificacion;

                                objDet.Version = "CCEPF154";
                                objDet.Accion = objDetalle.Accion;

                                if (objDet.Accion == "NUEVO") // Insertar Detalle
                                {

                                    objDet.FechaCreacion = Convert.ToDateTime(objDetalle.FechaModificacion);
                                    objDet.FechaModificacion = objDetalle.FechaModificacion;
                                    objDet.UsuarioModificacion = objDetalle.UsuarioModificacion;
                                    objDet.FechaModificacion = objDetalle.FechaModificacion;
                                    contadorDet++;
                                    objDet.Secuencia = secuenciaMax + contadorDet;
                                    //objDet.Accion = "NUEVO";
                                    //COrresponde al código CPT
                                    //if (objDet.CodigoComponente == null || objExamSol.CodigoComponenteCab == "")
                                    //{
                                    //    objDet.CodigoComponenteCab = objEntity.ValorCodigo7; //CASO SEGUS
                                    //}
                                    //objDet.Descripcion = objDetalle.DescripcionExtranjera;
                                    context.Entry(objDet).State = EntityState.Added;
                                }
                                else if (objDet.Accion == "UPDATE") // Actualizar Detalle
                                {
                                    objDet.FechaCreacion = objAnterior.FechaCreacion;
                                    objDet.FechaModificacion = objDetalle.FechaModificacion;
                                    context.Entry(objDet).State = EntityState.Modified;
                                    //mapSecuencia.Add("" + secuenciaAux, objDet.Secuencia);
                                }
                                else if (objDet.Accion == "DELETE")  // Eliminar Detalle
                                {

                                    context.Entry(objDet).State = EntityState.Deleted;

                                    //** Agregado auditoria --> Eliminar
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
                                            IdPaciente = objSC.IdPaciente
                                        };

                                        string tempType = objAudit.Type;



                                        objAudit = Control.AddAudita(new SS_HC_ApoyoDiagnosticoDet_FE(), new SS_HC_ApoyoDiagnosticoDet_FE(), DataKey, objAudit.Type);
                                        objAudit.TableName = "SS_HC_ApoyoDiagnosticoDet_FE ";
                                        objAudit.Type = objSC.Accion.Substring(0, 1); ;
                                        objAudit.Accion = objSC.Accion;
                                        contextEnty.Entry(objAudit).State = EntityState.Added;
                                        contextEnty.SaveChanges();
                                    }
                                    //**

                                }
                            }
                        }
                        /*********GUARDAR ARCHIVOS***************/
                        if (Detalle2 != null)
                        {
                            string numeroTemp = "";

                            if (objSC.NroInforme != null)
                            {
                                numeroTemp = objSC.NroInforme;
                            }
                            else 
                            {
                                numeroTemp = numero;
                            }

                            foreach (var ObjTrace in Detalle2)
                            {
                                iReturnValue = context.SP_SS_HC_ApoyoDiagnosticoFile_FE(
                                   ObjTrace.UnidadReplicacion.Trim(),
                                   ObjTrace.IdEpisodioAtencion,
                                   ObjTrace.IdPaciente,
                                   ObjTrace.EpisodioClinico,
                                   numeroTemp,
                                   /*ObjTrace.NroInforme,*/
                                   ObjTrace.Secuencia,
                                   ObjTrace.Nombre,
                                   
                                   ObjTrace.RutaInforme,
                                   ObjTrace.Estado
                                  
                                     , ObjTrace.UsuarioCreacion
                                     , ObjTrace.FechaCreacion
                                     , ObjTrace.UsuarioModificacion
                                     , ObjTrace.FechaModificacion
                                     , ObjTrace.Accion
                                     , ObjTrace.Version
                                ).SingleOrDefault();

                                int secuenciaMedico = Convert.ToInt32(iReturnValue.ToString().Trim());
                                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                            }
                            
                        }
                        /*****/

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
                                IdPaciente = objSC.IdPaciente
                            };
                            string tempType = objAudit.Type;
                            objAudit = Control.AddAudita(new SS_HC_ApoyoDiagnostico_FE(), new SS_HC_ApoyoDiagnostico_FE(), DataKey, objAudit.Type);
                            objAudit.TableName = "SS_HC_ApoyoDiagnostico_FE ";
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
                    catch (Exception ex)
                    {
                        dbContextTransaction.Rollback();
                        throw ex;
                    }
                }
            }
            return valorRetorno;
        }

        public List<SS_HC_ApoyoDiagnostico_FE> ApoyoCabecera_Listar(SS_HC_ApoyoDiagnostico_FE ObjTrace)
        {
            try
            {

                List<SS_HC_ApoyoDiagnostico_FE> objLista = new List<SS_HC_ApoyoDiagnostico_FE>();
                using (var context = new ModelFormularios())
                {


                    objLista = context.SS_HC_ApoyoDiagnostico_FE
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

        ///
        public SS_HC_ApoyoDiagnosticoDet_FE ApoyoDetalle_Listar(SS_HC_ApoyoDiagnosticoDet_FE ObjTrace)
        {
            SS_HC_ApoyoDiagnosticoDet_FE objResult = null;
            try
            {
                using (var context = new ModelFormularios())
                {
                    SS_HC_ApoyoDiagnosticoDet_FE objConsulta = (from t in context.SS_HC_ApoyoDiagnosticoDet_FE
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

        public List<SS_HC_ApoyoDiagnosticoFile_FE> Archivos_Listar(SS_HC_ApoyoDiagnosticoFile_FE obj)
        {
            try
            {

                List<SS_HC_ApoyoDiagnosticoFile_FE> objLista = new List<SS_HC_ApoyoDiagnosticoFile_FE>();
                using (var context = new ModelFormularios())
                {


                    objLista = context.SP_SS_HC_ApoyoDiagnosticoFileListar_FE(
                                     obj.UnidadReplicacion
                                     , obj.IdEpisodioAtencion
                                     , obj.IdPaciente
                                     , obj.EpisodioClinico

                                     , obj.NroInforme
                                     , obj.Secuencia
                                     
                                     , obj.Nombre
                                     , obj.RutaInforme
                                     , obj.Estado

                                     , obj.UsuarioCreacion
                                     , obj.FechaCreacion
                                     , obj.UsuarioModificacion
                                     , obj.FechaModificacion
                                     , obj.Accion
                                     , obj.Version
                                        ).ToList();

                    

                }

                return objLista;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //Agregado auditoria --> N° 4
        public virtual String XMLString(List<SS_HC_ApoyoDiagnostico_FE> obPadre, String TablaID)
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
        //--

    }
}
