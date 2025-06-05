using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.DALAuditoria;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using System.Data.Entity.Core.Objects.DataClasses;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;


namespace SoluccionSalud.Repository.DALFormularios
{

    public class AnamnesisEARepository : AuditGenerico<SS_HC_Anamnesis_EA, SS_HC_Anamnesis_EA_Sintoma> 
    {

        public int setMantenimiento(SS_HC_Anamnesis_EA ObjTraces, List<SS_HC_Anamnesis_EA> Cabecera, List<SS_HC_Anamnesis_EA> Detalle)
        {
            //  Aquiles MH  : 09/07/2015
            //  Eventos     : Transacciones
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            SS_HC_Anamnesis_EA_Sintoma objAnamSintoma;
            SS_HC_Anamnesis_EA_Sintoma InforDetalleObj = new SS_HC_Anamnesis_EA_Sintoma();
            InforDetalleObj.SS_HC_Anamnesis_EA = null;
            dynamic DataKey;
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        foreach (SS_HC_Anamnesis_EA ObjTrace in Cabecera)
                        {
                            var InformacionObj = (from t in context.SS_HC_Anamnesis_EA
                                                  where t.IdPaciente == ObjTrace.IdPaciente
                                                  && t.UnidadReplicacion== ObjTrace.UnidadReplicacion  /*SE AGREGO ESTE CAMPO*/
                                                  && t.EpisodioClinico == ObjTrace.EpisodioClinico
                                                  && t.IdEpisodioAtencion == ObjTrace.IdEpisodioAtencion
                                                  orderby t.IdEpisodioAtencion descending
                                                  select t).SingleOrDefault();
                            if (InformacionObj == null) InformacionObj = new SS_HC_Anamnesis_EA();

                            iReturnValue = context.USP_Anamnesis_EA(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente, ObjTrace.EpisodioClinico,
                              ObjTrace.MotivoConsulta, ObjTrace.IdFormaInicio, ObjTrace.IdCursoEnfermedad, ObjTrace.TiempoEnfermedad,
                              ObjTrace.RelatoCronologico, ObjTrace.Apetito, ObjTrace.Sed, ObjTrace.Orina, ObjTrace.Deposiciones, ObjTrace.Sueno,
                              ObjTrace.PesoAnterior, ObjTrace.Infancia, ObjTrace.EvaluacionAlimentacionActual, ObjTrace.Estado, ObjTrace.UsuarioCreacion,
                              ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion, ObjTrace.ComentarioAdicional, ObjTrace.Prioridad, ObjTrace.Accion).SingleOrDefault();
                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                            
                            //*  Registra Audit/
                            DataKey = new {
                                UnidadReplicacion = ObjTrace.UnidadReplicacion,
                                IdPaciente = ObjTrace.IdPaciente, 
                                EpisodioClinico = ObjTrace.EpisodioClinico, 
                                IdEpisodioAtencion = ObjTrace.
                                IdEpisodioAtencion 
                            };
                            objAudit = AddAudita(InformacionObj, ObjTrace, DataKey, ObjTrace.Accion.Substring(0, 1));
                            objAudit.TableName = "SS_HC_Anamnesis_EA";
                            objAudit.Type = ObjTrace.Accion.Substring(0, 1);
                            context.Entry(objAudit).State = EntityState.Added;
                            //*/
                            foreach (SS_HC_Anamnesis_EA ObjTraceDell in Detalle)
                            {
                                //var maxSecuencia = context.SS_HC_Anamnesis_EA_Sintoma.Select(r => r.Secuencia).DefaultIfEmpty(0).Max();
                                var virtualObj = (from t in context.SS_HC_Anamnesis_EA_Sintoma
                                                       where t.IdPaciente == ObjTraceDell.IdPaciente
                                                      && t.EpisodioClinico == ObjTraceDell.EpisodioClinico
                                                      && t.IdEpisodioAtencion == ObjTraceDell.IdEpisodioAtencion
                                                      && t.Secuencia == ObjTraceDell.IdFormaInicio
                                                       orderby t.IdEpisodioAtencion descending
                                                       select t).SingleOrDefault();
                                if (virtualObj != null) InforDetalleObj = virtualObj;

                                //InforDetalleObj.SS_HC_Anamnesis_EA = null;
                                //var MaxObj = (from t in context.SS_HC_Anamnesis_EA_Sintoma select t.Secuencia).DefaultIfEmpty(0).Max();
                                objAnamSintoma = new SS_HC_Anamnesis_EA_Sintoma();
                                objAnamSintoma.UnidadReplicacion = ObjTraceDell.UnidadReplicacion;
                                objAnamSintoma.IdPaciente = ObjTraceDell.IdPaciente;
                                objAnamSintoma.EpisodioClinico = ObjTraceDell.EpisodioClinico;
                                objAnamSintoma.IdEpisodioAtencion = ObjTraceDell.IdEpisodioAtencion;
                                if (ObjTraceDell.IdFormaInicio != null) objAnamSintoma.Secuencia= (int)ObjTraceDell.IdFormaInicio;
                                objAnamSintoma.IdCIAP2 = Convert.ToInt32(ObjTraceDell.IdCursoEnfermedad);
                               // if (ObjTraceDell.Accion == "DETALLE") {
                                    context.USP_Anamnesis_EA(ObjTraceDell.UnidadReplicacion, ObjTraceDell.IdEpisodioAtencion, ObjTraceDell.IdPaciente, ObjTraceDell.EpisodioClinico,
                                          ObjTraceDell.MotivoConsulta, ObjTraceDell.IdFormaInicio, ObjTraceDell.IdCursoEnfermedad, ObjTraceDell.TiempoEnfermedad,
                                          ObjTraceDell.RelatoCronologico, ObjTraceDell.Apetito, ObjTraceDell.Sed, ObjTraceDell.Orina, ObjTraceDell.Deposiciones, ObjTraceDell.Sueno,
                                          ObjTraceDell.PesoAnterior, ObjTraceDell.Infancia, ObjTraceDell.EvaluacionAlimentacionActual, ObjTraceDell.Estado, ObjTraceDell.UsuarioCreacion,
                                          ObjTraceDell.FechaCreacion, ObjTraceDell.UsuarioModificacion, ObjTraceDell.FechaModificacion, ObjTrace.ComentarioAdicional, ObjTrace.Prioridad, ObjTraceDell.Accion).SingleOrDefault();
                                //}
                                //if (ObjTraceDell.Accion == "DETALLE") context.Entry(objAnamSintoma).State = EntityState.Added;
                               // if (ObjTraceDell.Accion == "UPDATEDETALLE") context.Entry(objAnamSintoma).State = EntityState.Modified;
                               // if (ObjTraceDell.Accion == "DELETE") context.Entry(objAnamSintoma).State = EntityState.Deleted;



                                if (ObjTraceDell.Accion == "DETALLE")
                                {
                                    objAudit.Type = "N";
                                }
                                else {
                                    objAudit.Type = ObjTraceDell.Accion.Substring(0, 1);
                                }
                                String tempoType = objAudit.Type;
                                //*  Registra Audit/
                                        DataKey = new
                                        {
                                            UnidadReplicacion = objAnamSintoma.UnidadReplicacion,
                                            IdPaciente = objAnamSintoma.IdPaciente,
                                            EpisodioClinico = objAnamSintoma.EpisodioClinico,
                                            IdEpisodioAtencion = objAnamSintoma.IdEpisodioAtencion,
                                            Secuencia = objAnamSintoma.Secuencia
                                        };
                                        objAudit = AddAudita(InforDetalleObj, objAnamSintoma, DataKey, ObjTraceDell.Accion.Substring(0, 1));
                                        objAudit.TableName = "SS_HC_Anamnesis_EA_Sintoma";
                                        objAudit.Type = tempoType;
                                        if (((objAudit.OldData.Trim().Length != 0) || (objAudit.NewData.Trim().Length != 0)) || (objAudit.Type=="D"))
                                        {
                                            context.Entry(objAudit).State = EntityState.Added;
                                        } 
                                  //*/
                            }
                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                        }
                        context.SaveChanges();
                        dbContextTransaction.Commit();
                    }
                    catch (Exception ex)
                    {
                        var sqlException = ex.InnerException as SqlException;
                        dbContextTransaction.Rollback();
                        throw ex;
                    }
                }
            }
            return valorRetorno;
        }
        public int setMantenimiento(SS_HC_Anamnesis_EA ObjTrace)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new WEB_ERPSALUDEntities())
             { 
                     try
                     {
                         iReturnValue = context.USP_Anamnesis_EA(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente, ObjTrace.EpisodioClinico,
                           ObjTrace.MotivoConsulta, ObjTrace.IdFormaInicio, ObjTrace.IdCursoEnfermedad, ObjTrace.TiempoEnfermedad,
                           ObjTrace.RelatoCronologico, ObjTrace.Apetito, ObjTrace.Sed, ObjTrace.Orina, ObjTrace.Deposiciones, ObjTrace.Sueno,
                           ObjTrace.PesoAnterior, ObjTrace.Infancia, ObjTrace.EvaluacionAlimentacionActual, ObjTrace.Estado, ObjTrace.UsuarioCreacion,
                           ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion, ObjTrace.ComentarioAdicional, ObjTrace.Prioridad, ObjTrace.Accion).SingleOrDefault();
                         valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                         
                     }
                     catch (Exception ex)
                     {
                          
                         throw ex;
                     }
                
     
            }
            return valorRetorno;
        }
        
                
        public List<SS_HC_Anamnesis_EA>  Anamnesis_EA_Listar(SS_HC_Anamnesis_EA ObjTrace)
        {
            try
            {
                dynamic DataKey = null;
                SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                List<SS_HC_Anamnesis_EA> objLista = new List<SS_HC_Anamnesis_EA>();
                using (var context = new WEB_ERPSALUDEntities())
                {

                    objLista = context.USP_Anamnesis_EA_Listar(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente, ObjTrace.EpisodioClinico,
                         ObjTrace.MotivoConsulta, ObjTrace.IdFormaInicio, ObjTrace.IdCursoEnfermedad, ObjTrace.TiempoEnfermedad,
                         ObjTrace.RelatoCronologico, ObjTrace.Apetito, ObjTrace.Sed, ObjTrace.Orina, ObjTrace.Deposiciones, ObjTrace.Sueno,
                         ObjTrace.PesoAnterior, ObjTrace.Infancia, ObjTrace.EvaluacionAlimentacionActual, ObjTrace.Estado, ObjTrace.UsuarioCreacion,
                         ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion, ObjTrace.ComentarioAdicional, ObjTrace.Prioridad, ObjTrace.Accion).ToList();


                    //if (InformacionObj == null) InformacionObj = new SS_HC_Anamnesis_EA();
                    //var objListaTemp = new List<SS_HC_Anamnesis_EA>();
                    //foreach (SS_HC_Anamnesis_EA obIn in objLista) {
                    //    obIn.SS_HC_Anamnesis_EA_Sintoma = null;
                    //    objListaTemp.Add(obIn);
                    //}
                    //*  Registra Audit/
                    DataKey = new
                    {
                        UnidadReplicacion = ObjTrace.UnidadReplicacion,
                        IdPaciente = ObjTrace.IdPaciente,
                        EpisodioClinico = ObjTrace.EpisodioClinico,
                        IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion

                    };
                    // Audit
                    objAudit.Type = "V";
                    if (objLista.Count > 1) objAudit.Type = "L";
                    String xlmIn = XMLString(objLista, new List<SS_HC_Anamnesis_EA_Sintoma>(), "SS_HC_Anamnesis_EA");
                    objAudit = AddAudita(new SS_HC_Anamnesis_EA(), new SS_HC_Anamnesis_EA(), DataKey, objAudit.Type);
                    objAudit.TableName = "SS_HC_Anamnesis_EA";
                    objAudit.Accion = "INSERT";
                    objAudit.Type = "V";
                    objAudit.VistaData = xlmIn;
                    //context.Entry(objAudit).State = EntityState.Added;
                    //context.SaveChanges();
                }

                AuditoriaRepository xx = new AuditoriaRepository();
                xx.Save_ChangesTraking(objAudit);
                //*/
                return objLista;
            }
            catch (Exception ex)
            {
                throw ex;
            }	
        }
       
    }
}


/*
 var ojbV = new V_SS_HC_Anamnesis_EA();
                foreach (SS_HC_Anamnesis_EA otmp in objLista) {
                    ojbV = new V_SS_HC_Anamnesis_EA();
                    
                }

                DataTable dt = new DataTable();

                if (objLista.Count != 0)
                {
                    objEntidad = objLista[0];
                    PropertyInfo[] properties = objLista.GetType().GetProperties();
                    foreach (PropertyInfo property in properties)
                    {
                        DataColumn dc = new DataColumn(property.Name);
                        dc.DataType = property.PropertyType; dt.Columns.Add(dc);
                    }
                    foreach (Object o in objLista)
                    {
                        DataRow dr = dt.NewRow();
                        foreach (PropertyInfo property in properties)
                        {
                            dr[property.Name] = property.GetValue(o, null);
                        }
                        dt.Rows.Add(dr);
                    }
                }
                List<V_SS_HC_Anamnesis_EA> ObjListas = new List<V_SS_HC_Anamnesis_EA>();
                //ObjListas = ConvertDataTable(dt);

                //Object[] objectArray = List<object>.ToSpecifiedObject<Object>(dt.DataSet);

*/