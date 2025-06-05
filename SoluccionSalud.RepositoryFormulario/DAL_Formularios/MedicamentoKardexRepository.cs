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
    public class MedicamentoKardexRepository
    {
        Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();  //Agregado auditoria --> N° 1

        public int setEliminarMedicamentoKardekProgramdos(SS_HC_Medicamento_Kardex ObjTrace)
        {

            int secuenciaMax = 0;
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new ModelFormularios())
            {
                try
                {

                  
                        context.SP_SS_HC_Medicamento_Kardex_Insert(
                            ObjTrace.UnidadReplicacion, Convert.ToInt32(ObjTrace.IdEpisodioAtencion),
                            ObjTrace.IdPaciente,
                            ObjTrace.EpisodioClinico,
                            ObjTrace.Secuencia, ObjTrace.IdMedicacion, ObjTrace.Medicacion,
                            ObjTrace.Dosis, ObjTrace.Frecuencia, ObjTrace.DiasTratamiento, ObjTrace.DiaTratamiento,
                            ObjTrace.HoraInicio, ObjTrace.HoraAdministracion, ObjTrace.Hora0, ObjTrace.Hora1,
                            ObjTrace.Hora2, ObjTrace.Hora3, ObjTrace.Hora4, ObjTrace.Hora5, ObjTrace.Hora6,
                            ObjTrace.Hora7, ObjTrace.Hora8, ObjTrace.Hora9, ObjTrace.Hora10, ObjTrace.Hora11,
                            ObjTrace.Hora12, ObjTrace.Hora13, ObjTrace.Hora14, ObjTrace.Hora15, ObjTrace.Hora16,
                            ObjTrace.Hora17, ObjTrace.Hora18, ObjTrace.Hora19, ObjTrace.Hora20, ObjTrace.Hora21,
                            ObjTrace.Hora22, ObjTrace.Hora23,
                            ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                            ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version);
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
                            objAudit = Control.AddAudita(new SS_HC_Medicamento_Kardex(), new SS_HC_Medicamento_Kardex(), DataKey, objAudit.Type);
                            objAudit.TableName = "SS_HC_Medicamento_Kardex";
                            objAudit.Type = ObjTrace.Accion.Substring(0, 1);
                            objAudit.Accion = ObjTrace.Accion;
                            contextEnty.Entry(objAudit).State = EntityState.Added;
                            contextEnty.SaveChanges();
                        }
                    valorRetorno = 1;
                }

                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return valorRetorno;
        }

        
        public int setMantenimiento(List<SS_HC_Medicamento_Kardex> ObjTrace)
        {

            int secuenciaMax = 0;
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new ModelFormularios())
            {
                try
                {
                
                   

                    foreach (SS_HC_Medicamento_Kardex obj in ObjTrace)
                    {
                        secuenciaMax = context.SS_HC_Medicamento_Kardex
                                         .DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);
                        var secuMax = secuenciaMax + 1;
                        

                        context.SP_SS_HC_Medicamento_Kardex_Insert(
                            obj.UnidadReplicacion, Convert.ToInt32(obj.IdEpisodioAtencion),
                            obj.IdPaciente,
                            obj.EpisodioClinico,
                            obj.Secuencia, obj.IdMedicacion, obj.Medicacion,
                            obj.Dosis, obj.Frecuencia, obj.DiasTratamiento, obj.DiaTratamiento,
                            obj.HoraInicio, obj.HoraAdministracion, obj.Hora0, obj.Hora1,
                            obj.Hora2, obj.Hora3, obj.Hora4, obj.Hora5, obj.Hora6,
                            obj.Hora7, obj.Hora8, obj.Hora9, obj.Hora10, obj.Hora11,
                            obj.Hora12, obj.Hora13, obj.Hora14, obj.Hora15, obj.Hora16,
                            obj.Hora17, obj.Hora18, obj.Hora19, obj.Hora20, obj.Hora21,
                            obj.Hora22, obj.Hora23,
                            obj.Estado, obj.UsuarioCreacion, obj.FechaCreacion, obj.UsuarioModificacion,
                            obj.FechaModificacion, obj.Accion, obj.Version);
                        using (var contextEnty = new WEB_ERPSALUDEntities())
                        {
                            SS_HC_AuditRoyal objAuditoria = new SS_HC_AuditRoyal();
                            List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                            dynamic DataKeyy;
                            DataKey = new
                            {
                                UnidadReplicacion = obj.UnidadReplicacion,
                                IdEpisodioAtencion = obj.IdEpisodioAtencion,
                                EpisodioClinico = obj.EpisodioClinico,
                                IdPaciente = obj.IdPaciente
                            };

                            string tempType = objAudit.Type;
                            objAudit = Control.AddAudita(new SS_HC_Medicamento_Kardex(), new SS_HC_Medicamento_Kardex(), DataKey, objAudit.Type);
                            objAudit.TableName = "SS_HC_Medicamento_Kardex";
                            objAudit.Type = obj.Accion.Substring(0, 1);
                            objAudit.Accion = obj.Accion;
                            contextEnty.Entry(objAudit).State = EntityState.Added;
                            contextEnty.SaveChanges();
                        }
                        //--
                    }
                    valorRetorno = 1;
                }

                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return valorRetorno;
        }




        public int setMantMedicamentoSinCabezeraFE(List<SS_HC_Medicamento_Kardex_FE> ObjTrace)
        {
            var secuenciaMax = 0;
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new ModelFormularios())
            {
                try
                {
                    
                        if (ObjTrace.Count > 0)
                        {
                          
                            foreach (SS_HC_Medicamento_Kardex_FE obj in ObjTrace)
                            {
                                secuenciaMax = context.SS_HC_Medicamento_Kardex
                                          .DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);
                                var secuMax = secuenciaMax + 1;

                                context.SP_SS_HC_Medicamento_Kardex_FE_Insert(
                                    obj.UnidadReplicacion, Convert.ToInt32(obj.IdEpisodioAtencion),
                                    obj.IdPaciente,
                                    obj.EpisodioClinico,
                                    obj.Secuencia, obj.CodigoComponente, obj.IdVia, obj.Dosis, obj.DiasTratamiento,
                                    obj.Frecuencia, obj.Cantidad, obj.Descripcion, obj.TipoComida, obj.VolumenDia, obj.FrecuenciaToma,
                                    obj.Periodo, obj.UnidadTiempo, obj.IndicadorAuditoria, obj.UsuarioAuditoria, obj.HoraInicio,
                                    obj.HoraAdministracion,
                                    obj.Estado, obj.UsuarioCreacion, obj.FechaCreacion, obj.UsuarioModificacion,
                                    obj.FechaModificacion, obj.Accion, obj.Version);


                                using (var contextEnty = new WEB_ERPSALUDEntities())
                                {
                                    SS_HC_AuditRoyal objAuditoria = new SS_HC_AuditRoyal();
                                    List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                                    dynamic DataKeyy;
                                    DataKey = new
                                    {
                                        UnidadReplicacion = obj.UnidadReplicacion,
                                        IdEpisodioAtencion = obj.IdEpisodioAtencion,
                                        EpisodioClinico = obj.EpisodioClinico,
                                        IdPaciente = obj.IdPaciente
                                    };

                                    string tempType = objAudit.Type;
                                    objAudit = Control.AddAudita(new SS_HC_Medicamento_Kardex_FE(), new SS_HC_Medicamento_Kardex_FE(), DataKey, objAudit.Type);
                                    objAudit.TableName = "SS_HC_Medicamento_Kardex_FE";
                                    objAudit.Type = obj.Accion.Substring(0, 1);
                                    objAudit.Accion = obj.Accion;
                                    contextEnty.Entry(objAudit).State = EntityState.Added;
                                    contextEnty.SaveChanges();
                                }
                            }
                            //--
                        }
                    valorRetorno = 1;
                }

                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return valorRetorno;
        }
       

        public int setMantenimientoMedicamento(List<SS_HC_Kardex1_FE> Obj, List<SS_HC_Medicamento_Kardex_FE> ObjTrace)
        {
            var secuenciaMax = 0;
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new ModelFormularios())
            {
                try
                {
                    if (Obj.Count > 0)
                    {

                        foreach (SS_HC_Kardex1_FE obj in Obj)
                        {
                            context.SP_SS_HC_Kardex1_FE_Insert(
                                obj.UnidadReplicacion, Convert.ToInt32(obj.IdEpisodioAtencion),
                                obj.IdPaciente,
                                obj.EpisodioClinico, obj.IdMedico, obj.CMP, obj.Estado, obj.NombreMedico, obj.Religion,
                                obj.Ayuno, obj.UsuarioCreacion, obj.FechaCreacion, obj.UsuarioModificacion,
                                obj.FechaModificacion, obj.Accion, obj.Version);


                            using (var contextEnty = new WEB_ERPSALUDEntities())
                            {
                                SS_HC_AuditRoyal objAuditoria = new SS_HC_AuditRoyal();
                                List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                                dynamic DataKeyy;
                                DataKey = new
                                {
                                    UnidadReplicacion = obj.UnidadReplicacion,
                                    IdEpisodioAtencion = obj.IdEpisodioAtencion,
                                    EpisodioClinico = obj.EpisodioClinico,
                                    IdPaciente = obj.IdPaciente
                                };

                                string tempType = objAudit.Type;
                                objAudit = Control.AddAudita(new SS_HC_Kardex1_FE(), new SS_HC_Kardex1_FE(), DataKey, objAudit.Type);
                                objAudit.TableName = "SS_HC_Kardex1_FE";
                                objAudit.Type = obj.Accion.Substring(0, 1);
                                objAudit.Accion = obj.Accion;
                                contextEnty.Entry(objAudit).State = EntityState.Added;
                                contextEnty.SaveChanges();
                            }
                        }
                        if (ObjTrace.Count > 0)
                        {
                          
                            foreach (SS_HC_Medicamento_Kardex_FE obj in ObjTrace)
                            {
                                secuenciaMax = context.SS_HC_Medicamento_Kardex
                                          .DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);
                                var secuMax = secuenciaMax + 1;

                                context.SP_SS_HC_Medicamento_Kardex_FE_Insert(
                                    obj.UnidadReplicacion, Convert.ToInt32(obj.IdEpisodioAtencion),
                                    obj.IdPaciente,
                                    obj.EpisodioClinico,
                                    obj.Secuencia, obj.CodigoComponente, obj.IdVia, obj.Dosis, obj.DiasTratamiento,
                                    obj.Frecuencia, obj.Cantidad, obj.Descripcion, obj.TipoComida, obj.VolumenDia, obj.FrecuenciaToma,
                                    obj.Periodo, obj.UnidadTiempo, obj.IndicadorAuditoria, obj.UsuarioAuditoria, obj.HoraInicio,
                                    obj.HoraAdministracion,
                                    obj.Estado, obj.UsuarioCreacion, obj.FechaCreacion, obj.UsuarioModificacion,
                                    obj.FechaModificacion, obj.Accion, obj.Version);


                                using (var contextEnty = new WEB_ERPSALUDEntities())
                                {
                                    SS_HC_AuditRoyal objAuditoria = new SS_HC_AuditRoyal();
                                    List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                                    dynamic DataKeyy;
                                    DataKey = new
                                    {
                                        UnidadReplicacion = obj.UnidadReplicacion,
                                        IdEpisodioAtencion = obj.IdEpisodioAtencion,
                                        EpisodioClinico = obj.EpisodioClinico,
                                        IdPaciente = obj.IdPaciente
                                    };

                                    string tempType = objAudit.Type;
                                    objAudit = Control.AddAudita(new SS_HC_Medicamento_Kardex_FE(), new SS_HC_Medicamento_Kardex_FE(), DataKey, objAudit.Type);
                                    objAudit.TableName = "SS_HC_Medicamento_Kardex_FE";
                                    objAudit.Type = obj.Accion.Substring(0, 1);
                                    objAudit.Accion = obj.Accion;
                                    contextEnty.Entry(objAudit).State = EntityState.Added;
                                    contextEnty.SaveChanges();
                                }
                            }
                            //--
                        }
                    }
                    valorRetorno = 1;
                }

                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return valorRetorno;
        }
       
        
        
        public int setMantenimientoMedicamento(List<SS_HC_Medicamento_Kardex_FE> ObjTrace)
        {


            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new ModelFormularios())
            {
                try
                {

                    foreach (SS_HC_Medicamento_Kardex_FE obj in ObjTrace)
                    {
                        context.SP_SS_HC_Medicamento_Kardex_FE_Insert(
                            obj.UnidadReplicacion, Convert.ToInt32(obj.IdEpisodioAtencion),
                            obj.IdPaciente,
                            obj.EpisodioClinico,
                            obj.Secuencia, obj.CodigoComponente, obj.IdVia, obj.Dosis, obj.DiasTratamiento,
                            obj.Frecuencia, obj.Cantidad, obj.Descripcion, obj.TipoComida, obj.VolumenDia, obj.FrecuenciaToma,
                            obj.Periodo, obj.UnidadTiempo, obj.IndicadorAuditoria, obj.UsuarioAuditoria, obj.HoraInicio,
                            obj.HoraAdministracion,
                            obj.Estado, obj.UsuarioCreacion, obj.FechaCreacion, obj.UsuarioModificacion,
                            obj.FechaModificacion, obj.Accion, obj.Version);


                        using (var contextEnty = new WEB_ERPSALUDEntities())
                        {
                            SS_HC_AuditRoyal objAuditoria = new SS_HC_AuditRoyal();
                            List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                            dynamic DataKeyy;
                            DataKey = new
                            {
                                UnidadReplicacion = obj.UnidadReplicacion,
                                IdEpisodioAtencion = obj.IdEpisodioAtencion,
                                EpisodioClinico = obj.EpisodioClinico,
                                IdPaciente = obj.IdPaciente
                            };

                            string tempType = objAudit.Type;
                            objAudit = Control.AddAudita(new SS_HC_Medicamento_Kardex_FE(), new SS_HC_Medicamento_Kardex_FE(), DataKey, objAudit.Type);
                            objAudit.TableName = "SS_HC_Medicamento_Kardex_FE";
                            objAudit.Type = obj.Accion.Substring(0, 1);
                            objAudit.Accion = obj.Accion;
                            contextEnty.Entry(objAudit).State = EntityState.Added;
                            contextEnty.SaveChanges();
                        }
                        //--
                    }
                    valorRetorno = 1;
                }

                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return valorRetorno;
        }


        public List<SS_HC_Kardex1_FE> ListarKardex1(SS_HC_Kardex1_FE ObjTrace)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;
            List<SS_HC_Kardex1_FE> objLista = new List<SS_HC_Kardex1_FE>();
            using (var context = new ModelFormularios())
            {
                objLista = context.SP_SS_HC_Kardex1_Listar(ObjTrace.UnidadReplicacion, ObjTrace.IdPaciente,
                   ObjTrace.EpisodioClinico,
                   ObjTrace.IdEpisodioAtencion, ObjTrace.Accion).ToList();
                DataKey = new
                {
                    UnidadReplicacion = ObjTrace.UnidadReplicacion,
                    IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                    EpisodioClinico = ObjTrace.EpisodioClinico,
                    IdPaciente = ObjTrace.IdPaciente,
                };


                //Agregado auditoria --> N° 2
                using (var contextEnty = new WEB_ERPSALUDEntities())
                {

                    List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();

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
                    objAudit = Control.AddAudita(new SS_HC_Kardex1_FE(), new SS_HC_Kardex1_FE(), DataKey, objAudit.Type);
                    String xlmIn = XMLStringK(objLista, "SS_HC_Kardex1_FE");
                    objAudit.TableName = "SS_HC_Kardex1_FE";
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

        public List<SS_HC_Medicamento_Kardex> listarProgramacionKardex(SS_HC_Medicamento_Kardex ObjTrace)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;
            List<SS_HC_Medicamento_Kardex> objLista = new List<SS_HC_Medicamento_Kardex>();
            using (var context = new ModelFormularios())
            {
                objLista = context.SP_SS_Medicamento_Programacion_Kardex_Listar(ObjTrace.UnidadReplicacion, ObjTrace.IdPaciente,
                   ObjTrace.EpisodioClinico,
                   ObjTrace.IdEpisodioAtencion, ObjTrace.Accion).ToList();
                DataKey = new
                {
                    UnidadReplicacion = ObjTrace.UnidadReplicacion,
                    IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                    EpisodioClinico = ObjTrace.EpisodioClinico,
                    IdPaciente = ObjTrace.IdPaciente,

                };


                //Agregado auditoria --> N° 2
                using (var contextEnty = new WEB_ERPSALUDEntities())
                {

                    List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();

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
                    objAudit = Control.AddAudita(new SS_HC_Medicamento_Kardex(), new SS_HC_Medicamento_Kardex(), DataKey, objAudit.Type);
                    String xlmIn = XMLString(objLista, "SS_HC_Medicamento_Kardex");
                    objAudit.TableName = "SS_HC_Medicamento_Kardex";
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

        //public int MedicamentoIndicaciones(SS_HC_Indicaciones_FE ObjTrace)
        //{
        //    System.Nullable<int> iReturnValue;
        //    int valorRetorno = 0;
        //    using (var context = new ModelFormularios())
        //    {
        //        iReturnValue = context.USP_IndicacionesFE(
        //            ObjTrace.UnidadReplicacion, ObjTrace.IdPaciente,
        //            ObjTrace.EpisodioClinico, ObjTrace.IdEpisodioAtencion, ObjTrace.SecuenciaMedicamento, ObjTrace.Secuencia, ObjTrace.TipoRegistro, ObjTrace.Correlativo,
        //            ObjTrace.IdTipoIndicacion, ObjTrace.Descripcion, ObjTrace.GrupoMedicamento, ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion,
        //            ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version).SingleOrDefault();
        //        valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
        //    }

        //    return valorRetorno;
        //}

        //public List<SS_HC_Indicaciones_FE> MedicamentoIndicacionesListar(SS_HC_Indicaciones_FE ObjTrace)
        //{
        //    SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
        //    dynamic DataKey;
        //    List<SS_HC_Indicaciones_FE> objLista = new List<SS_HC_Indicaciones_FE>();
        //    using (var context = new ModelFormularios())
        //    {
        //        objLista = context.USP_IndicacionesListarFE(ObjTrace.UnidadReplicacion, ObjTrace.IdPaciente,
        //            ObjTrace.EpisodioClinico, ObjTrace.IdEpisodioAtencion, ObjTrace.SecuenciaMedicamento, ObjTrace.Secuencia, ObjTrace.TipoRegistro, ObjTrace.Correlativo,
        //            ObjTrace.IdTipoIndicacion, ObjTrace.Descripcion, ObjTrace.GrupoMedicamento, ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion,
        //            ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version).ToList();
        //        DataKey = new
        //        {
        //            UnidadReplicacion = ObjTrace.UnidadReplicacion,
        //            IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
        //            EpisodioClinico = ObjTrace.EpisodioClinico,
        //            IdPaciente = ObjTrace.IdPaciente,
        //            SecuenciaMedicamento = ObjTrace.SecuenciaMedicamento,
        //            Secuencia = ObjTrace.Secuencia
        //        };
        //        SS_HC_Medicamento_FE objFiltro = new SS_HC_Medicamento_FE();
        //        objFiltro.UnidadReplicacion = ObjTrace.UnidadReplicacion;
        //        objFiltro.IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion;
        //        objFiltro.EpisodioClinico = ObjTrace.EpisodioClinico;
        //        objFiltro.IdPaciente = ObjTrace.IdPaciente;
        //        objFiltro.Secuencia = ObjTrace.SecuenciaMedicamento;
        //        List<SS_HC_Medicamento_FE> listaFiltro = new List<SS_HC_Medicamento_FE>();
        //        listaFiltro.Add(objFiltro);

        //        //objAudit.Type = "V";
        //        //if (objLista.Count > 1) objAudit.Type = "L";
        //        //string tempType = objAudit.Type;
        //        //objAudit = AddAudita(new SS_HC_Indicaciones(), new SS_HC_Indicaciones(), DataKey, objAudit.Type);
        //        //String xlmIn = XMLString(listaFiltro, new List<SS_HC_Medicamento>(), "SS_HC_Indicaciones");
        //        //objAudit.TableName = "SS_HC_Indicaciones";
        //        //objAudit.Type = tempType;
        //        //objAudit.VistaData = xlmIn;
        //        //context.Entry(objAudit).State = EntityState.Added;
        //        //context.SaveChanges();

        //    }
        //    return objLista;
        //}

        //public int setMantenimientoNutriente(List<SS_HC_Medicamento_FE> listaCabecera01, List<SS_HC_Medicamento_FE> listaCabecera02)
        //{
        //    dynamic DataKey = null;
        //    SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
        //    System.Nullable<int> iReturnValue;
        //    int valorRetorno = 0;
        //    using (var context = new ModelFormularios())
        //    {
        //        using (var dbContextTransaction = context.Database.BeginTransaction())
        //        {
        //            try
        //            {
        //                if (listaCabecera01 != null)
        //                {
        //                    foreach (SS_HC_Medicamento_FE ObjTrace in listaCabecera01)
        //                    {
        //                        if (ObjTrace.Accion == "DELETEINDIV")
        //                        {
        //                            //context.Entry(ObjTrace).State = EntityState.Deleted;
        //                            //Agregado auditoria --> Eliminar
        //                            //dynamic DataKey = null;
        //                            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
        //                            #region AuditoriaEliminar
        //                            using (var contextEnty = new WEB_ERPSALUDEntities())
        //                            {
        //                                SS_HC_AuditRoyal objAuditoria = new SS_HC_AuditRoyal();
        //                                List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
        //                                dynamic DataKeyy;
        //                                DataKey = new
        //                                {
        //                                    UnidadReplicacion = ObjTrace.UnidadReplicacion,
        //                                    IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
        //                                    EpisodioClinico = ObjTrace.EpisodioClinico,
        //                                    IdPaciente = ObjTrace.IdPaciente
        //                                };

        //                                string tempType = objAudit.Type;
        //                                objAudit = Control.AddAudita(new SS_HC_Medicamento_FE(), new SS_HC_Medicamento_FE(), DataKey, objAudit.Type);
        //                                objAudit.TableName = "SS_HC_Medicamento_FE";
        //                                objAudit.Type = "D";
        //                                objAudit.Accion = "DELETE";
        //                                contextEnty.Entry(objAudit).State = EntityState.Added;
        //                                contextEnty.SaveChanges();
        //                            }
        //                            //--
        //                            #endregion
        //                        }

        //                        var secuenciaCabPrevia = ObjTrace.Secuencia;
        //                        iReturnValue = context.USP_SS_GE_Medicamento_FE(
        //                         ObjTrace.UnidadReplicacion, ObjTrace.IdPaciente,
        //                         ObjTrace.EpisodioClinico,
        //                         ObjTrace.IdEpisodioAtencion,
        //                         ObjTrace.Secuencia, ObjTrace.TipoMedicamento, ObjTrace.IdUnidadMedida,
        //                         ObjTrace.Linea, ObjTrace.Familia, ObjTrace.SubFamilia, ObjTrace.TipoComponente,
        //                         ObjTrace.CodigoComponente, ObjTrace.IdVia, ObjTrace.Dosis, ObjTrace.DiasTratamiento,
        //                         ObjTrace.Frecuencia, ObjTrace.Cantidad, ObjTrace.IndicadorEPS, ObjTrace.TipoReceta,
        //                         ObjTrace.Forma, ObjTrace.GrupoMedicamento, ObjTrace.Comentario, ObjTrace.IndicadorAuditoria, ObjTrace.UsuarioAuditoria,
        //                         ObjTrace.TipoComida,
        //                         ObjTrace.VolumenDia, ObjTrace.FrecuenciaToma, ObjTrace.Presentacion, ObjTrace.Hora,
        //                         ObjTrace.Periodo, ObjTrace.UnidadTiempo, ObjTrace.Indicacion,
        //                         ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
        //                         ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version, ObjTrace.IdPadreNutriente, ObjTrace.IdHijoNutriente).SingleOrDefault();

        //                        int secuenciaMedico = Convert.ToInt32(iReturnValue.ToString().Trim());
        //                        valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

        //                        #region AuditoriaUpdate
        //                        using (var contextEnty = new WEB_ERPSALUDEntities())
        //                        {
        //                            SS_HC_AuditRoyal objAuditoria = new SS_HC_AuditRoyal();
        //                            List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
        //                            dynamic DataKeyy;
        //                            DataKey = new
        //                            {
        //                                UnidadReplicacion = ObjTrace.UnidadReplicacion,
        //                                IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
        //                                EpisodioClinico = ObjTrace.EpisodioClinico,
        //                                IdPaciente = ObjTrace.IdPaciente
        //                            };

        //                            string tempType = objAudit.Type;
        //                            objAudit = Control.AddAudita(new SS_HC_Medicamento_FE(), new SS_HC_Medicamento_FE(), DataKey, objAudit.Type);
        //                            objAudit.TableName = "SS_HC_Medicamento_FE";
        //                            objAudit.Type = ObjTrace.Accion.Substring(0, 1);
        //                            objAudit.Accion = ObjTrace.Accion;
        //                            contextEnty.Entry(objAudit).State = EntityState.Added;
        //                            contextEnty.SaveChanges();
        //                        }
        //                        #endregion
        //                    }

        //                }
        //                if (listaCabecera02 != null)
        //                {
        //                    foreach (SS_HC_Medicamento_FE ObjTrace in listaCabecera02)
        //                    {
        //                        iReturnValue = context.USP_SS_GE_Medicamento_FE(
        //                         ObjTrace.UnidadReplicacion, ObjTrace.IdPaciente,
        //                         ObjTrace.EpisodioClinico,
        //                         ObjTrace.IdEpisodioAtencion,
        //                         ObjTrace.Secuencia, ObjTrace.TipoMedicamento, ObjTrace.IdUnidadMedida,
        //                         ObjTrace.Linea, ObjTrace.Familia, ObjTrace.SubFamilia, ObjTrace.TipoComponente,
        //                         ObjTrace.CodigoComponente, ObjTrace.IdVia, ObjTrace.Dosis, ObjTrace.DiasTratamiento,
        //                         ObjTrace.Frecuencia, ObjTrace.Cantidad, ObjTrace.IndicadorEPS, ObjTrace.TipoReceta,
        //                         ObjTrace.Forma, ObjTrace.GrupoMedicamento, ObjTrace.Comentario, ObjTrace.IndicadorAuditoria, ObjTrace.UsuarioAuditoria,
        //                         ObjTrace.TipoComida, ObjTrace.VolumenDia, ObjTrace.FrecuenciaToma, ObjTrace.Presentacion, ObjTrace.Hora,
        //                         ObjTrace.Periodo, ObjTrace.UnidadTiempo, ObjTrace.Indicacion,
        //                         ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
        //                         ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version, ObjTrace.IdPadreNutriente, ObjTrace.IdHijoNutriente).SingleOrDefault();
        //                        valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
        //                    }
        //                }




        //                context.SaveChanges();
        //                dbContextTransaction.Commit();
        //            }
        //            catch (Exception ex)
        //            {
        //                dbContextTransaction.Rollback();
        //                throw ex;
        //            }
        //        }
        //    }
        //    return valorRetorno;
        //}

        //public int setMantenimientoGrupo(SS_HC_Medicamento_FE ObjTraces, List<SS_HC_Medicamento_FE> listaCabecera01, List<SS_HC_Medicamento_FE> listaCabecera02, List<SS_HC_Indicaciones_FE> listaTraceDetalle01, List<SS_HC_Indicaciones_FE> listaDetalle01)
        //{
        //    dynamic DataKey = null;
        //    SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
        //    System.Nullable<int> iReturnValue;
        //    int valorRetorno = 0;
        //    using (var context = new ModelFormularios())
        //    {
        //        using (var dbContextTransaction = context.Database.BeginTransaction())
        //        {
        //            try
        //            {
        //                if (listaCabecera01 != null)
        //                {
        //                    foreach (var ObjTrace in listaCabecera01)
        //                    {
        //                        var InformacionObj = (from t in context.SS_HC_Medicamento_FE
        //                                              where t.IdPaciente == ObjTrace.IdPaciente
        //                                              && t.EpisodioClinico == ObjTrace.EpisodioClinico
        //                                              && t.IdEpisodioAtencion == ObjTrace.IdEpisodioAtencion
        //                                              && t.Secuencia == ObjTrace.Secuencia
        //                                              orderby t.IdEpisodioAtencion descending
        //                                              select t).SingleOrDefault();
        //                        if (InformacionObj == null) InformacionObj = new SS_HC_Medicamento_FE();

        //                        var secuenciaCabPrevia = ObjTrace.Secuencia;
        //                        iReturnValue = context.USP_SS_GE_Medicamento_FE(
        //                           ObjTrace.UnidadReplicacion.Trim(), ObjTrace.IdPaciente,
        //                           ObjTrace.EpisodioClinico,
        //                           ObjTrace.IdEpisodioAtencion,
        //                           ObjTrace.Secuencia, ObjTrace.TipoMedicamento, ObjTrace.IdUnidadMedida,
        //                           ObjTrace.Linea.Trim(), ObjTrace.Familia.Trim(), ObjTrace.SubFamilia.Trim(), ObjTrace.TipoComponente,
        //                           ObjTrace.CodigoComponente, ObjTrace.IdVia, ObjTrace.Dosis, ObjTrace.DiasTratamiento,
        //                           ObjTrace.Frecuencia, ObjTrace.Cantidad, ObjTrace.IndicadorEPS, ObjTrace.TipoReceta,
        //                           ObjTrace.Forma, ObjTrace.GrupoMedicamento, ObjTrace.Comentario, ObjTrace.IndicadorAuditoria, ObjTrace.UsuarioAuditoria,
        //                           ObjTrace.TipoComida, ObjTrace.VolumenDia, ObjTrace.FrecuenciaToma, ObjTrace.Presentacion, ObjTrace.Hora,
        //                           ObjTrace.Periodo, ObjTrace.UnidadTiempo, ObjTrace.Indicacion,
        //                           ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
        //                           ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version, ObjTrace.IdPadreNutriente, ObjTrace.IdHijoNutriente
        //                        ).SingleOrDefault();

        //                        int secuenciaMedico = Convert.ToInt32(iReturnValue.ToString().Trim());
        //                        valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

        //                        DataKey = new
        //                        {
        //                            UnidadReplicacion = ObjTrace.UnidadReplicacion,
        //                            IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
        //                            EpisodioClinico = ObjTrace.EpisodioClinico,
        //                            IdPaciente = ObjTrace.IdPaciente,
        //                            Secuencia = ObjTrace.Secuencia,
        //                            TipoMedicamento = ObjTrace.TipoMedicamento
        //                        };
        //                        // Audit

        //                        //objAudit = AddAudita(InformacionObj, ObjTrace, DataKey, ObjTrace.Accion.Substring(0, 1));
        //                        //objAudit.TableName = "SS_HC_Medicamento";
        //                        //objAudit.Type = ObjTrace.Accion.Substring(0, 1);
        //                        //context.Entry(objAudit).State = EntityState.Added;


        //                        //detalle
        //                        if (listaTraceDetalle01 != null)
        //                        {
        //                            foreach (var ObjTraceDetalle01 in listaTraceDetalle01)
        //                            {
        //                                if (ObjTraceDetalle01.SecuenciaMedicamento == secuenciaCabPrevia)
        //                                {
        //                                    var InformacionObjDell = (from t in context.SS_HC_Indicaciones_FE
        //                                                              where t.IdPaciente == ObjTraceDetalle01.IdPaciente
        //                                                              && t.EpisodioClinico == ObjTraceDetalle01.EpisodioClinico
        //                                                              && t.IdEpisodioAtencion == ObjTraceDetalle01.IdEpisodioAtencion
        //                                                              && t.SecuenciaMedicamento == ObjTraceDetalle01.SecuenciaMedicamento
        //                                                              && t.Secuencia == ObjTraceDetalle01.Secuencia

        //                                                              orderby t.IdEpisodioAtencion descending
        //                                                              select t).SingleOrDefault();
        //                                    if (InformacionObjDell == null) InformacionObjDell = new SS_HC_Indicaciones_FE();

        //                                    ObjTraceDetalle01.SecuenciaMedicamento = secuenciaMedico;
        //                                    iReturnValue = context.USP_IndicacionesFE(
        //                                    ObjTraceDetalle01.UnidadReplicacion.Trim(), ObjTraceDetalle01.IdPaciente,
        //                                    ObjTraceDetalle01.EpisodioClinico, ObjTraceDetalle01.IdEpisodioAtencion, ObjTraceDetalle01.SecuenciaMedicamento, ObjTraceDetalle01.Secuencia, ObjTraceDetalle01.TipoRegistro, ObjTraceDetalle01.Correlativo,
        //                                    ObjTraceDetalle01.IdTipoIndicacion, ObjTraceDetalle01.Descripcion, ObjTraceDetalle01.GrupoMedicamento, ObjTraceDetalle01.Estado, ObjTraceDetalle01.UsuarioCreacion, ObjTraceDetalle01.FechaCreacion,
        //                                    ObjTraceDetalle01.UsuarioModificacion, ObjTraceDetalle01.FechaModificacion, ObjTraceDetalle01.Accion, ObjTraceDetalle01.Version).SingleOrDefault();
        //                                    valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
        //                                    DataKey = new
        //                                    {
        //                                        UnidadReplicacion = ObjTraceDetalle01.UnidadReplicacion,
        //                                        IdEpisodioAtencion = ObjTraceDetalle01.IdEpisodioAtencion,
        //                                        EpisodioClinico = ObjTraceDetalle01.EpisodioClinico,
        //                                        IdPaciente = ObjTraceDetalle01.IdPaciente,
        //                                        SecuenciaMedicamento = ObjTraceDetalle01.SecuenciaMedicamento,
        //                                        Secuencia = ObjTraceDetalle01.Secuencia


        //                                    };
        //                                    //objAudit = AddAudita(InformacionObjDell, ObjTraceDetalle01, DataKey, ObjTraceDetalle01.Accion.Substring(0, 1));
        //                                    //objAudit.TableName = "SS_HC_Indicaciones";
        //                                    //objAudit.Type = ObjTraceDetalle01.Accion.Substring(0, 1);
        //                                    //context.Entry(objAudit).State = EntityState.Added;
        //                                }
        //                            }
        //                        }

        //                        if (listaDetalle01 != null)
        //                        {
        //                            foreach (var objDetalle01 in listaDetalle01)
        //                            {
        //                                if (objDetalle01.SecuenciaMedicamento == secuenciaCabPrevia)
        //                                {
        //                                    objDetalle01.SecuenciaMedicamento = secuenciaMedico;
        //                                    iReturnValue = context.USP_IndicacionesFE(
        //                                    objDetalle01.UnidadReplicacion.Trim(), objDetalle01.IdPaciente,
        //                                    objDetalle01.EpisodioClinico, objDetalle01.IdEpisodioAtencion, objDetalle01.SecuenciaMedicamento, objDetalle01.Secuencia, objDetalle01.TipoRegistro, objDetalle01.Correlativo,
        //                                    objDetalle01.IdTipoIndicacion, objDetalle01.Descripcion, objDetalle01.GrupoMedicamento, objDetalle01.Estado, objDetalle01.UsuarioCreacion, objDetalle01.FechaCreacion,
        //                                    objDetalle01.UsuarioModificacion, objDetalle01.FechaModificacion, objDetalle01.Accion, objDetalle01.Version).SingleOrDefault();
        //                                    valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
        //                                }

        //                            }
        //                        }
        //                    }
        //                }
        //                if (listaCabecera02 != null)
        //                {
        //                    foreach (var ObjTrace in listaCabecera02)
        //                    {
        //                        iReturnValue = context.USP_SS_GE_Medicamento_FE(
        //                           ObjTrace.UnidadReplicacion.Trim(), ObjTrace.IdPaciente,
        //                           ObjTrace.EpisodioClinico,
        //                           ObjTrace.IdEpisodioAtencion,
        //                           ObjTrace.Secuencia, ObjTrace.TipoMedicamento, ObjTrace.IdUnidadMedida,
        //                           ObjTrace.Linea.Trim(), ObjTrace.Familia.Trim(), ObjTrace.SubFamilia.Trim(), ObjTrace.TipoComponente,
        //                           ObjTrace.CodigoComponente, ObjTrace.IdVia, ObjTrace.Dosis, ObjTrace.DiasTratamiento,
        //                           ObjTrace.Frecuencia, ObjTrace.Cantidad, ObjTrace.IndicadorEPS, ObjTrace.TipoReceta,
        //                           ObjTrace.Forma, ObjTrace.GrupoMedicamento, ObjTrace.Comentario, ObjTrace.IndicadorAuditoria, ObjTrace.UsuarioAuditoria,
        //                           ObjTrace.TipoComida, ObjTrace.VolumenDia, ObjTrace.FrecuenciaToma, ObjTrace.Presentacion, ObjTrace.Hora,
        //                           ObjTrace.Periodo, ObjTrace.UnidadTiempo, ObjTrace.Indicacion,
        //                           ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
        //                           ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version, ObjTrace.IdPadreNutriente, ObjTrace.IdHijoNutriente
        //                        ).SingleOrDefault();
        //                        valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
        //                    }
        //                }
        //                context.SaveChanges();
        //                dbContextTransaction.Commit();
        //            }
        //            catch (Exception ex)
        //            {
        //                dbContextTransaction.Rollback();
        //                throw ex;
        //            }
        //        }
        //    }
        //    return valorRetorno;
        //}

        ////Agregado auditoria --> N° 4
        public virtual String XMLString(List<SS_HC_Medicamento_Kardex> obPadre, String TablaID)
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

        public virtual String XMLStringK(List<SS_HC_Kardex1_FE> obPadre, String TablaID)
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
