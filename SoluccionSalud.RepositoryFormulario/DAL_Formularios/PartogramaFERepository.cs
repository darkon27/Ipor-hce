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
    public class PartogramaFERepository
    {
        public List<SS_HC_Partograma_FE> Listar(SS_HC_Partograma_FE ObjSC)
        {

            List<SS_HC_Partograma_FE> objCabecera = null;
            using (var context = new ModelFormularios())
            {

                objCabecera = context.SS_HC_Partograma_FE.Where(
                                                        t => t.EpisodioClinico == ObjSC.EpisodioClinico
                                                            && t.UnidadReplicacion == ObjSC.UnidadReplicacion
                                                            && t.IdPaciente == ObjSC.IdPaciente
                                                            && t.IdEpisodioAtencion == ObjSC.IdEpisodioAtencion
                                                               ).ToList();

            }

           
            return objCabecera;
        }

        public List<SS_HC_Partograma_FE> Listar_graficos(SS_HC_Partograma_FE obj)
        {

            List<SS_HC_Partograma_FE> objExamen = null;

            using (var context = new ModelFormularios())
            {

                objExamen = context.SP_SS_HC_Partograma_FE_Listar(
                                     obj.UnidadReplicacion
                                     , obj.IdEpisodioAtencion
                                     , obj.IdPaciente
                                     , obj.EpisodioClinico

                                     , obj.Fecha
                                     , obj.FrecCardiacaFetal
                                     , obj.Membranas
                                     , obj.Liquido
                                     , obj.DilatacionCuelloUt
                                     , obj.DescensoCefalico
                                     , obj.TactosVaginales

                                     , obj.DuracionContracciones
                                     , obj.ContracTEENmin
                                     , obj.Oxitocina

                                     , obj.FVPulso
                                     , obj.FVPresionArterial
                                     , obj.FVPresionArterialD
                                     , obj.FVTemperatura

                                     , obj.Proteina
                                     , obj.Acetona
                                     , obj.Volumen

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


        public List<SS_HC_PartogramaDetalle_FE> Listar_Medicamento(SS_HC_PartogramaDetalle_FE obj)
        {

            List<SS_HC_PartogramaDetalle_FE> objExamen = null;

            using (var context = new ModelFormularios())
            {

                objExamen = context.SP_SS_HC_PartogramaDetalleListar_FE(
                                     obj.UnidadReplicacion
                                     , obj.IdEpisodioAtencion
                                     , obj.IdPaciente
                                     , obj.EpisodioClinico

                                     , obj.Secuencia
                                     , obj.Medicamento
                                     , obj.Hora                                     

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


        public int setMantenimiento(SS_HC_Partograma_FE objSC, List<SS_HC_PartogramaDetalle_FE> detalle1)
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
                            iReturnValue = context.SP_SS_HC_Partograma_FE(
                                       objSC.UnidadReplicacion.Trim(),
                                       objSC.IdEpisodioAtencion,
                                       objSC.IdPaciente,
                                       objSC.EpisodioClinico,
                                       objSC.Fecha,
                                       objSC.FrecCardiacaFetal,
                                       objSC.Membranas,
                                       objSC.Liquido,
                                       objSC.DilatacionCuelloUt,
                                       objSC.DescensoCefalico,
                                       objSC.TactosVaginales,
                                       objSC.DuracionContracciones,
                                       objSC.ContracTEENmin,
                                       objSC.Oxitocina,
                                       objSC.FVPulso,
                                       objSC.FVPresionArterial,
                                       objSC.FVPresionArterialD,
                                       objSC.FVTemperatura,
                                       objSC.Proteina,
                                       objSC.Acetona,
                                       objSC.Volumen,
                                       objSC.UsuarioCreacion,                                                                           
                                          objSC.FechaCreacion
                                         , objSC.UsuarioModificacion
                                         , objSC.FechaModificacion
                                         , objSC.Accion
                                         , objSC.Version
                                    ).SingleOrDefault();

                            int secuenciaMedico = Convert.ToInt32(iReturnValue.ToString().Trim());
                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                        }


                        if (detalle1 != null)
                        {
                            foreach (var ObjTrace in detalle1)
                            {



                                iReturnValue = context.SP_SS_HC_PartogramaDetalle_FE(
                                   ObjTrace.UnidadReplicacion.Trim(),
                                   ObjTrace.IdEpisodioAtencion,
                                   ObjTrace.IdPaciente,
                                   ObjTrace.EpisodioClinico,
                                 
                                   ObjTrace.Secuencia,
                                   ObjTrace.Medicamento,
                                   ObjTrace.Hora
                                   
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
