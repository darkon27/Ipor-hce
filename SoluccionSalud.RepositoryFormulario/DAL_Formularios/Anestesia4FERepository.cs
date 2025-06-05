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
    public class Anestesia4FERepository
    {
        public List<SS_HC_Anestesia_Farmaco_FE> Lista_Cabecera(SS_HC_Anestesia_Farmaco_FE ObjSC)
        {

            List<SS_HC_Anestesia_Farmaco_FE> objCabecera = null;
            using (var context = new ModelFormularios())
            {

                objCabecera = context.SP_SS_HC_Anestesia_Farmaco_FE_Listar(
                    ObjSC.UnidadReplicacion,
                    ObjSC.IdEpisodioAtencion,
                    ObjSC.IdPaciente,
                    ObjSC.EpisodioClinico,
                    ObjSC.Accion).ToList();

            }


            return objCabecera;
        }
        public List<SS_HC_Anestesia_Farmacos_Detalle_FE> Listar_Soluciones(SS_HC_Anestesia_Farmacos_Detalle_FE obj)
        {

            List<SS_HC_Anestesia_Farmacos_Detalle_FE> objExamen = null;

            using (var context = new ModelFormularios())
            {

                objExamen = context.SP_SS_HC_Anestesia_Farmacos_Detalle_FE_Listar(
                                     obj.UnidadReplicacion, obj.IdEpisodioAtencion
                                     , obj.IdPaciente
                                     , obj.EpisodioClinico
                                     , obj.Tipo, obj.Accion
                                    ).ToList();
            }
            return objExamen;

        }


        public int setMantenimiento(SS_HC_Anestesia_Farmaco_FE objSC, List<SS_HC_Anestesia_Farmacos_Detalle_FE> detalle1)
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
                            iReturnValue = context.SP_SS_HC_Anestesia_Farmaco_FE(
                                       objSC.UnidadReplicacion.Trim(),
                                       objSC.IdEpisodioAtencion,
                                       objSC.IdPaciente,
                                       objSC.EpisodioClinico,
                                       objSC.Ingresos1,
                                       objSC.Ingresos2,
                                       objSC.Ingresos3,
                                       objSC.Ingresos4,
                                       objSC.Ingresos5,
                                       objSC.Ingresos6,
                                       objSC.Ingresos7,
                                       objSC.Ingresos8,
                                       objSC.IngresosCantidad1,
                                       objSC.IngresosCantidad2,
                                       objSC.IngresosCantidad3,
                                       objSC.IngresosCantidad4,
                                       objSC.IngresosCantidad5,
                                       objSC.IngresosCantidad6,
                                       objSC.IngresosCantidad7,
                                       objSC.IngresosCantidad8,
                                       objSC.IngresosHorario1,
                                       objSC.IngresosHorario2,
                                       objSC.IngresosHorario3,
                                       objSC.IngresosHorario4,
                                       objSC.IngresosHorario5,
                                       objSC.IngresosHorario6,
                                       objSC.IngresosHorario7,
                                       objSC.IngresosHorario8,
                                       objSC.TotalIngresos,
                                       objSC.Perdidas1,
                                       objSC.Perdidas2,
                                       objSC.Perdidas3,
                                       objSC.Perdidas4,
                                       objSC.Perdidas5,
                                       objSC.Perdidas6,
                                       objSC.PerdidasCantidad1,
                                       objSC.PerdidasCantidad2,
                                       objSC.PerdidasCantidad3,
                                       objSC.PerdidasCantidad4,
                                       objSC.PerdidasCantidad5,
                                       objSC.PerdidasCantidad6,
                                       objSC.PerdidasHorario1,
                                       objSC.PerdidasHorario2,
                                       objSC.PerdidasHorario3,
                                       objSC.PerdidasHorario4,
                                       objSC.PerdidasHorario5,
                                       objSC.PerdidasHorario6,
                                       objSC.TotalPerdidas,
                                       objSC.BalanceHidrico,
                                       objSC.UsuarioCreacion,
                                       objSC.FechaCreacion,
                                       objSC.UsuarioModificacion,
                                        objSC.FechaModificacion,
                                        objSC.Accion,
                                         objSC.Version).SingleOrDefault();

                            int secuenciaMedico = Convert.ToInt32(iReturnValue.ToString().Trim());
                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                        }


                        if (detalle1 != null)
                        {
                            foreach (var ObjTrace in detalle1)
                            {



                                iReturnValue = context.SP_SS_HC_Anestesia_Farmaco_Detalle_FE(
                                   ObjTrace.UnidadReplicacion.Trim(), ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente, ObjTrace.EpisodioClinico, ObjTrace.Secuencia,
                                   ObjTrace.Tipo, ObjTrace.TipoVia, ObjTrace.FarmacoDescripcion, ObjTrace.Dosis, ObjTrace.Horario,
                                   ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version
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
