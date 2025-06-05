using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace SoluccionSalud.Repository.DALEpisodioAtencion
{
    public class EpisodioAtencionRepository : AuditGenerico<SS_HC_EpisodioAtencion, SS_HC_EpisodioAtencion> 
    {
        public List<SS_HC_EpisodioAtencion> listarSS_HC_EpisodioAtencion(SS_HC_EpisodioAtencion objSC, int inicio, int final)
        {
            try
            {
                /////
                using (var context = new WEB_ERPSALUDEntities())
                {
                    return context.USP_SS_HC_EpisodioAtencionListar(
                        objSC.UnidadReplicacion
                        , objSC.IdEpisodioAtencion
                        , objSC.UnidadReplicacionEC
                        , objSC.IdPaciente
                        , objSC.EpisodioClinico
                        , objSC.IdEstablecimientoSalud
                        , objSC.IdUnidadServicio
                        , objSC.IdPersonalSalud
                        , null
                        , objSC.EpisodioAtencion
                        , objSC.FechaRegistro
                        , objSC.FechaAtencion
                        , objSC.TipoAtencion
                        , objSC.IdOrdenAtencion
                        , objSC.LineaOrdenAtencion
                        , objSC.TipoOrdenAtencion
                        , objSC.Estado
                        , objSC.UsuarioCreacion
                        , objSC.FechaCreacion
                        , objSC.UsuarioModificacion
                        , objSC.FechaModificacion
                        , objSC.IdEspecialidad
                        , objSC.CodigoOA
                        , objSC.ProximaAtencionFlag
                        , objSC.IdEspecialidadProxima
                        , objSC.IdEstablecimientoSaludProxima
                        , objSC.IdTipoInterConsulta
                        , objSC.IdTipoReferencia
                        , objSC.ObservacionProxima
                        , objSC.DescansoMedico
                        , objSC.DiasDescansoMedico
                        , objSC.FechaInicioDescansoMedico
                        , objSC.FechaFinDescansoMedico
                        , objSC.FechaOrden
                        , objSC.IdProcedimiento
                        , objSC.ObservacionOrden
                        , objSC.IdTipoOrden
                        , objSC.Version
                        , objSC.FlagFirma
                        , objSC.FechaFirma
                        , objSC.idMedicoFirma
                        , objSC.ObservacionFirma
                        , objSC.KeyPrivada
                        , objSC.KeyPublica
                        , objSC.TipoTrabajador
                        , objSC.TipoEpisodio
                        , objSC.TipoUbicacion
                        , objSC.IdUbicacion
                        , objSC.Accion
                    ).ToList();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public long setMantenimiento(SS_HC_EpisodioAtencion objSC)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;

            System.Nullable<long> iReturnValue;
            long valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        SS_HC_EpisodioAtencion objAnterior = new SS_HC_EpisodioAtencion();
                        if (objSC.Accion != "EPISODIOCLINICO")
                        {
                            objAnterior = (from t in context.SS_HC_EpisodioAtencion
                                           where t.UnidadReplicacion == objSC.UnidadReplicacion
                                           && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                          && t.EpisodioClinico == objSC.EpisodioClinico
                                          && t.IdPaciente == objSC.IdPaciente
                                           orderby t.IdEpisodioAtencion descending
                                           select t).SingleOrDefault();
                        }

                        iReturnValue = context.USP_SS_HC_EpisodioAtencion(
                            objSC.UnidadReplicacion
                            , objSC.IdEpisodioAtencion
                            , objSC.UnidadReplicacionEC
                            , objSC.IdPaciente
                            , objSC.EpisodioClinico
                            , objSC.IdEstablecimientoSalud
                            , objSC.IdUnidadServicio
                            , objSC.IdPersonalSalud
                            , null
                            , objSC.EpisodioAtencion
                            , objSC.FechaRegistro
                            , objSC.FechaAtencion
                            , objSC.TipoAtencion
                            , objSC.IdOrdenAtencion
                            , objSC.LineaOrdenAtencion
                            , objSC.TipoOrdenAtencion
                            , objSC.Estado
                            , objSC.UsuarioCreacion
                            , objSC.FechaCreacion
                            , objSC.UsuarioModificacion
                            , objSC.FechaModificacion
                            , objSC.IdEspecialidad
                            , objSC.CodigoOA
                            , objSC.ProximaAtencionFlag
                            , objSC.IdEspecialidadProxima
                            , objSC.IdEstablecimientoSaludProxima
                            , objSC.IdTipoInterConsulta
                            , objSC.IdTipoReferencia
                            , objSC.ObservacionProxima
                            , objSC.DescansoMedico
                            , objSC.DiasDescansoMedico
                            , objSC.FechaInicioDescansoMedico
                            , objSC.FechaFinDescansoMedico
                            , objSC.FechaOrden
                            , objSC.IdProcedimiento
                            , objSC.ObservacionOrden
                            , objSC.IdTipoOrden
                            , objSC.Version
                            , objSC.FlagFirma
                            , objSC.FechaFirma
                            , objSC.idMedicoFirma
                            , objSC.ObservacionFirma
                            , objSC.KeyPrivada
                            , objSC.KeyPublica
                            , objSC.TipoTrabajador
                            , objSC.TipoEpisodio
                            , objSC.TipoUbicacion
                            , objSC.IdUbicacion
                            , objSC.Accion
                            ).SingleOrDefault();
                        valorRetorno = Convert.ToInt64(iReturnValue.ToString().Trim());

                        if (objSC.Accion != "EPISODIOCLINICO")
                        {
                            //*  Registra Audit/
                            DataKey = new
                            {
                                UnidadReplicacion = objSC.UnidadReplicacion,
                                IdEpisodioAtencion = objSC.IdEpisodioAtencion,
                                IdPaciente = objSC.IdPaciente,
                                EpisodioClinico = objSC.EpisodioClinico
                            };
                            if (objAnterior == null) objAnterior = new SS_HC_EpisodioAtencion();
                            objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                            objAudit.TableName = "SS_HC_EpisodioAtencion";
                            if (objSC.Accion == "INSERT" || objSC.Accion == "CONTINUAR")
                            {
                                objAudit.Type = "I";
                            }
                            else
                            {
                                objAudit.Type = "U";
                            }
                            if (valorRetorno > 0)
                            {
                                if (objAudit.Type != "L")
                                {
                                    context.Entry(objAudit).State = EntityState.Added;
                                    context.SaveChanges();
                                }
                            }
                        }                        
                        dbContextTransaction.Commit();
                    }
                    catch (Exception ex)
                    {
                        dbContextTransaction.Rollback();
                        //throw ex;
                    }
                }
            }
            return valorRetorno;
        }

        /****/
        public long setCopiarEpisodio(SS_HC_EpisodioAtencion objSC, int idOpcion,String codigoFormato)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;

            System.Nullable<long> iReturnValue;
            long valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        iReturnValue = context.USP_SS_HC_Copiar_EpisodioAtencion(
                            objSC.UnidadReplicacion
                            , objSC.IdPaciente
                            , objSC.EpisodioClinico
                            , objSC.IdEpisodioAtencion
                            , objSC.UnidadReplicacionEC
                            , idOpcion
                            ,0
                            ,codigoFormato
                            ,null
                            ,objSC.UsuarioCreacion                         
                            , objSC.Accion
                            ).SingleOrDefault();
                        valorRetorno = Convert.ToInt64(iReturnValue.ToString().Trim());                      
                        dbContextTransaction.Commit();
                    }
                    catch (Exception ex)
                    {
                        dbContextTransaction.Rollback();
                        //throw ex;
                    }
                }
            }
            return valorRetorno;
        }

        /****/
        public int setPreMantenimiento(PERSONAMAST ObjPersona, SS_GE_Paciente objPaciente,
            SS_HC_AsignacionMedico ObjAsigmedico, SS_HC_EpisodioClinico ObjEpiClinico,
            List<SS_HC_EpisodioAtencion> listaEpiAtencion)
        {
            //  Aquiles MH  : 09/07/2015
            //  Eventos     : Transacciones
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;
            System.Nullable<int> iReturnValue;
            System.Nullable<long> longReturnValue;
            
            int valorRetorno = ObjPersona.Persona;
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        //var InforPersona = (from t in context.PERSONAMASTs
                        //                      where t.Persona == ObjPersona.Persona 
                        //                      orderby t.Persona descending
                        //                      select t.Persona).SingleOrDefault();
                        //if (InforPersona == 0) context.Entry(ObjPersona).State = EntityState.Added;

                        //var InforPaciente = (from t in context.SS_GE_Paciente
                        //                      where t.IdPaciente == objPaciente.IdPaciente
                        //                      orderby t.IdPaciente descending
                        //                      select t.IdPaciente).SingleOrDefault();
                        //if (InforPaciente == 0) context.Entry(objPaciente).State = EntityState.Added;


                        context.SaveChanges();

                        /*****************************/
                        if (listaEpiAtencion.Count>0)
                        {
                            SS_HC_EpisodioAtencion objSC = new SS_HC_EpisodioAtencion();
                            objSC = listaEpiAtencion[0];
                            objSC.Accion = "CARGAADICIONAL";
                            longReturnValue = context.USP_SS_HC_EpisodioAtencion(
                                    objSC.UnidadReplicacion
                                    , objSC.IdEpisodioAtencion
                                    , objSC.UnidadReplicacionEC
                                    , objSC.IdPaciente
                                    , objSC.EpisodioClinico
                                    , objSC.IdEstablecimientoSalud
                                    , objSC.IdUnidadServicio
                                    , objSC.IdPersonalSalud
                                    , null
                                    , objSC.EpisodioAtencion
                                    , objSC.FechaRegistro
                                    , objSC.FechaAtencion
                                    , objSC.TipoAtencion
                                    , objSC.IdOrdenAtencion
                                    , objSC.LineaOrdenAtencion
                                    , objSC.TipoOrdenAtencion
                                    , objSC.Estado
                                    , objSC.UsuarioCreacion
                                    , objSC.FechaCreacion
                                    , objSC.UsuarioModificacion
                                    , objSC.FechaModificacion
                                    , objSC.IdEspecialidad
                                    , objSC.CodigoOA
                                    , objSC.ProximaAtencionFlag
                                    , objSC.IdEspecialidadProxima
                                    , objSC.IdEstablecimientoSaludProxima
                                    , objSC.IdTipoInterConsulta
                                    , objSC.IdTipoReferencia
                                    , objSC.ObservacionProxima
                                    , objSC.DescansoMedico
                                    , objSC.DiasDescansoMedico
                                    , objSC.FechaInicioDescansoMedico
                                    , objSC.FechaFinDescansoMedico
                                    , objSC.FechaOrden
                                    , objSC.IdProcedimiento
                                    , objSC.ObservacionOrden
                                    , objSC.IdTipoOrden
                                    , objSC.Version
                                    , objSC.FlagFirma
                                    , objSC.FechaFirma
                                    , objSC.idMedicoFirma
                                    , objSC.ObservacionFirma
                                    , objSC.KeyPrivada
                                    , objSC.KeyPublica
                                    , objSC.TipoTrabajador
                                    , objSC.TipoEpisodio
                                    , objSC.TipoUbicacion
                                    , objSC.IdUbicacion
                                    , objSC.Accion
                                    ).SingleOrDefault();
                           
                        }

                        /*****************************/
                        
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


    }
}
