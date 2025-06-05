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
    public class BalanceHidroelectroFERepository
    {
        public List<SS_HC_BalanceHidroElect_FE> Lista_Cabecera(SS_HC_BalanceHidroElect_FE ObjSC)
        {

            List<SS_HC_BalanceHidroElect_FE> objCabecera = null;
            using (var context = new ModelFormularios())
            {

                objCabecera = context.SP_SS_HC_BalanceHidroElect_FE_Listar(
                    ObjSC.UnidadReplicacion,
                    ObjSC.IdEpisodioAtencion,
                    ObjSC.IdPaciente,
                    ObjSC.EpisodioClinico,
                    ObjSC.TipoBalance,
                    ObjSC.FechaControl,
                    ObjSC.Turno,
                    ObjSC.Drenaje,
                    ObjSC.Autolisis,
                    ObjSC.Peso,
                    ObjSC.Hora,
                    ObjSC.AlimentacionOral,
                    ObjSC.SNG,
                    ObjSC.DetalleSNG,
                    ObjSC.TotalIngresos,
                    ObjSC.PerdidaInsensible,
                    ObjSC.PerdidaCantidad,
                    ObjSC.Orina,
                    ObjSC.Heces,
                    ObjSC.Vomitos,
                    ObjSC.Temperatura,
                    ObjSC.TemperaturaDescripcion,
                    ObjSC.SuperficieCorporal,
                    ObjSC.SuperficieDescripion,
                    ObjSC.Succion,
                    ObjSC.PerdidaSNG,
                    ObjSC.TotalEgresos,
                    ObjSC.BalanceHidrico,
                    ObjSC.BalanceAcumulado,
                    ObjSC.UsuarioCreacion,
                    ObjSC.FechaCreacion,
                    ObjSC.UsuarioModificacion,
                    ObjSC.FechaModificacion,
                    ObjSC.Accion,
                    ObjSC.Version
                     ).ToList();

            }

            //Agregado auditoria --> N° 2
            /*  using (var contextEnty = new WEB_ERPSALUDEntities())
              {
                  SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                  List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                  dynamic DataKey;
                  DataKey = new
                  {
                      UnidadReplicacion = ObjSC.UnidadReplicacion,
                      IdEpisodioAtencion = ObjSC.IdEpisodioAtencion,
                      EpisodioClinico = ObjSC.EpisodioClinico,
                      IdPaciente = ObjSC.IdPaciente,
                  };

                  if (objCabecera.Count > 1)
                  {
                      objAudit.Type = "L";
                  }
                  else
                  {
                      objAudit.Type = "V";
                  }

                  contextEnty.Entry(objAudit).State = EntityState.Added;
                  contextEnty.SaveChanges();
              }*/
            //--
            return objCabecera;
        }
        public List<SS_HC_BalanceHidroElectDetalle_FE> Listar_Soluciones(SS_HC_BalanceHidroElectDetalle_FE obj)
        {

            List<SS_HC_BalanceHidroElectDetalle_FE> objExamen = null;

            using (var context = new ModelFormularios())
            {

                objExamen = context.SP_SS_HC_BalanceHidroElectDetalle_FE_Listar(
                                     obj.UnidadReplicacion
                                     , obj.IdEpisodioAtencion
                                     , obj.IdPaciente
                                     , obj.EpisodioClinico
                                     , obj.TipoBalance
                                     , obj.Secuencia
                                     , obj.Tipo
                                     , obj.TipoSolucion
                                     , obj.SolucionDescripcion
                                     , obj.CantidadCC
                                     , obj.Especificacion
                                     , obj.UsuarioCreacion
                                     , obj.FechaCreacion
                                     , obj.UsuarioModificacion
                                     , obj.FechaModificacion
                                     , obj.Accion
                                     , obj.Version
                                        ).ToList();
            }
            return objExamen;

        }


        public int setMantenimiento(SS_HC_BalanceHidroElect_FE objSC, List<SS_HC_BalanceHidroElectDetalle_FE> detalle1)
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

                        if (objSC != null)
                        {
                            iReturnValue = context.SP_SS_HC_BalanceHidroElect_FE(
                                       objSC.UnidadReplicacion.Trim(),
                                       objSC.IdEpisodioAtencion,
                                       objSC.IdPaciente,
                                       objSC.EpisodioClinico,
                                       objSC.TipoBalance,
                                       objSC.FechaControl,
                                       objSC.Turno,
                                       objSC.Peso,
                                       objSC.Hora,
                                       objSC.AlimentacionOral,
                                       objSC.SNG,
                                       objSC.DetalleSNG,
                                       objSC.TotalIngresos,
                                       objSC.PerdidaInsensible,
                                       objSC.PerdidaCantidad,
                                       objSC.Orina,
                                       objSC.Heces,
                                       objSC.Vomitos,
                                       objSC.Temperatura,
                                       objSC.TemperaturaDescripcion,
                                       objSC.SuperficieCorporal,
                                       objSC.SuperficieDescripion,
                                       objSC.Succion,
                                       objSC.PerdidaSNG,
                                       objSC.TotalEgresos,
                                       objSC.BalanceHidrico,
                                       objSC.BalanceAcumulado

                                         , objSC.UsuarioCreacion
                                         , objSC.FechaCreacion
                                         , objSC.UsuarioModificacion
                                         , objSC.FechaModificacion
                                         , objSC.Accion
                                         , objSC.Version
                                         ,objSC.Drenaje
                                         ,objSC.Autolisis
                                    ).SingleOrDefault();

                            int secuenciaMedico = Convert.ToInt32(iReturnValue.ToString().Trim());
                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                        }


                        if (detalle1 != null)
                        {
                            foreach (var ObjTrace in detalle1)
                            {



                                iReturnValue = context.SP_SS_HC_BalanceHidroElectDetalle_FE(
                                   ObjTrace.UnidadReplicacion.Trim(),
                                   ObjTrace.IdEpisodioAtencion,
                                   ObjTrace.IdPaciente,
                                   ObjTrace.EpisodioClinico,
                                   ObjTrace.TipoBalance,
                                   ObjTrace.Secuencia,
                                   ObjTrace.Tipo,
                                   ObjTrace.TipoSolucion,
                                   ObjTrace.SolucionDescripcion,
                                   ObjTrace.CantidadCC,
                                   ObjTrace.Especificacion
                                     , ObjTrace.UsuarioCreacion
                                     , ObjTrace.FechaCreacion
                                     , ObjTrace.UsuarioModificacion
                                     , ObjTrace.FechaModificacion
                                     , ObjTrace.Accion
                                     , ObjTrace.Version
                                ).SingleOrDefault();

                                int secuenciaMedico = Convert.ToInt32(iReturnValue.ToString().Trim());
                                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                                /*  DataKey = new
                                  {
                                      UnidadReplicacion = ObjTrace.UnidadReplicacion,
                                      IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                                      EpisodioClinico = ObjTrace.EpisodioClinico,
                                      IdPaciente = ObjTrace.IdPaciente,
                                      Secuencia = ObjTrace.Secuencia,
                                      Tipo = ObjTrace.Tipo
                                  };*/
                                // Audit

                                //objAudit = AddAudita(InformacionObj, ObjTrace, DataKey, ObjTrace.Accion.Substring(0, 1));
                                //objAudit.TableName = "SS_HC_Medicamento";
                                //objAudit.Type = ObjTrace.Accion.Substring(0, 1);
                                //context.Entry(objAudit).State = EntityState.Added;



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


    }
}
