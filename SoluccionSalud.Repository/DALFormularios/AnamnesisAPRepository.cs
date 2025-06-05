using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System.Data.Entity.Core;
using System.Data.SqlClient;




using System.Data.Entity;
using System.Data.Entity.Infrastructure;

using System.Data.Entity.Core.Objects;

using System.Data.Common;

namespace SoluccionSalud.Repository.DALFormularios
{
    public class AnamnesisAPRepository : AuditGenerico<SS_HC_Anamnesis_AP, SS_HC_Anamnesis_AP>
    {


        public int registraAnamnesis(SS_HC_Anamnesis_AP ObjTrace)
        {
            // ObjTrace.EpisodioClinico = -1;
            //ObjTrace.IdEpisodioAtencion = 55;

            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        iReturnValue = context.USP_ANAMNESIS_AP(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente, ObjTrace.EpisodioClinico,
                          ObjTrace.IdTipoEmbarazo,
                          ObjTrace.PatologiaGestacion, ObjTrace.IdControlPrenatal, ObjTrace.CPnumeroControles, ObjTrace.CPnumeroEmbarazos, ObjTrace.LugarControl,
                          ObjTrace.IdTipoParto, ObjTrace.ComplicacionesParto, ObjTrace.IdLugarParto, ObjTrace.IdPartoAtendidoPor, ObjTrace.AntecentesPatologicos,
                          ObjTrace.SemanasGestacionNacer, ObjTrace.PesoAlNacerGR, ObjTrace.TallaAlNacerCM, ObjTrace.PerimetroCefalicoCM, ObjTrace.PatologiasPernatales,
                          ObjTrace.DiasHospitalizacion, ObjTrace.IdTipoLecheHasta6meses, ObjTrace.AntecLactancia, ObjTrace.EdadInicioAblactanciaMeses,
                          ObjTrace.DesarrolloSicomotriz, ObjTrace.FechaUltimaRegla, ObjTrace.FechaUltimoPeriodo, ObjTrace.MetodosAnticonceptivos,
                          ObjTrace.Menarquia, ObjTrace.Menopausia, ObjTrace.CaracteristicasMenstruaciones, ObjTrace.InformacionEmbarazos, ObjTrace.Transfusiones,
                          ObjTrace.DeinmunizFechaAproximada, ObjTrace.DeinmunizEdadAproximada, ObjTrace.Alcohol, ObjTrace.Tabaco, ObjTrace.Drogas,
                          ObjTrace.ActividadFisica, ObjTrace.ConsumoVerduras, ObjTrace.ConsumoFrutas, ObjTrace.Medicamentos, ObjTrace.Alimentos,
                          ObjTrace.SustanciasEnElAmbiente, ObjTrace.SustanciasContactoConPiel, ObjTrace.ContactoPersonaEnferma, ObjTrace.CrianzaAnimalesDomesticos,
                          ObjTrace.AguaPotable, ObjTrace.DisposicionExcretas, ObjTrace.ReaccionAdversaMedicamentos, ObjTrace.SaludBucal, ObjTrace.VigilanciaDeCrecimiento,
                          ObjTrace.VigilanciaDelDesarrollo, ObjTrace.IdValoracionFuncional1, ObjTrace.IdValoracionFuncional2, ObjTrace.IdValoracionFuncional3,
                          ObjTrace.IdValoracionFuncional4, ObjTrace.IdValoracionFuncional5, ObjTrace.IdValoracionFuncional6, ObjTrace.DiagnosticoFuncional,
                          ObjTrace.IdEstadoCognitivo1, ObjTrace.IdEstadoCognitivo2, ObjTrace.IdEstadoCognitivo3, ObjTrace.IdEstadoCognitivo4,
                          ObjTrace.IdEstadoCognitivo5, ObjTrace.IdEstadoCognitivo6, ObjTrace.IdEstadoCognitivo7, ObjTrace.IdEstadoCognitivo8, ObjTrace.IdEstadoCognitivo9,
                          ObjTrace.IdEstadoCognitivo10, ObjTrace.ValoracionCognitiva, ObjTrace.IdEstadoAfectivo1, ObjTrace.IdEstadoAfectivo2, ObjTrace.IdEstadoAfectivo3,
                          ObjTrace.IdEstadoAfectivo4, ObjTrace.ConManifestacionesDepresivas, ObjTrace.ValoracionSocioFamiliar1, ObjTrace.ValoracionSocioFamiliar2,
                          ObjTrace.ValoracionSocioFamiliar3, ObjTrace.ValoracionSocioFamiliar4, ObjTrace.ValoracionSocioFamiliar5, ObjTrace.ValoracionSocioFamiliar,
                          ObjTrace.IdCategoriaAdutoMayor, ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                          ObjTrace.FechaModificacion, ObjTrace.Accion).SingleOrDefault();

                        valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
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
        public int setMantAnamnesisAP(SS_HC_Anamnesis_AP ObjTrace)
        {
            //ObjTrace.EpisodioClinico = -1;
            //ObjTrace.IdEpisodioAtencion = 55;
            System.Nullable<int> iReturnValue;
            //  var scope = new TransactionScope(TransactionScopeOption.RequiresNew,new TransactionOptions()
            //    {
            //        IsolationLevel = IsolationLevel.ReadUncommitted
            //    }
            //);

            int valorRetorno = 0;
            try
            {
                using (var context = new WEB_ERPSALUDEntities())
                {
                    iReturnValue = context.USP_ANAMNESIS_AP(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente, ObjTrace.EpisodioClinico,
                        ObjTrace.IdTipoEmbarazo,
                        ObjTrace.PatologiaGestacion, ObjTrace.IdControlPrenatal, ObjTrace.CPnumeroControles, ObjTrace.CPnumeroEmbarazos, ObjTrace.LugarControl,
                        ObjTrace.IdTipoParto, ObjTrace.ComplicacionesParto, ObjTrace.IdLugarParto, ObjTrace.IdPartoAtendidoPor, ObjTrace.AntecentesPatologicos,
                        ObjTrace.SemanasGestacionNacer, ObjTrace.PesoAlNacerGR, ObjTrace.TallaAlNacerCM, ObjTrace.PerimetroCefalicoCM, ObjTrace.PatologiasPernatales,
                        ObjTrace.DiasHospitalizacion, ObjTrace.IdTipoLecheHasta6meses, ObjTrace.AntecLactancia, ObjTrace.EdadInicioAblactanciaMeses,
                        ObjTrace.DesarrolloSicomotriz, ObjTrace.FechaUltimaRegla, ObjTrace.FechaUltimoPeriodo, ObjTrace.MetodosAnticonceptivos,
                        ObjTrace.Menarquia, ObjTrace.Menopausia, ObjTrace.CaracteristicasMenstruaciones, ObjTrace.InformacionEmbarazos, ObjTrace.Transfusiones,
                        ObjTrace.DeinmunizFechaAproximada, ObjTrace.DeinmunizEdadAproximada, ObjTrace.Alcohol, ObjTrace.Tabaco, ObjTrace.Drogas,
                        ObjTrace.ActividadFisica, ObjTrace.ConsumoVerduras, ObjTrace.ConsumoFrutas, ObjTrace.Medicamentos, ObjTrace.Alimentos,
                        ObjTrace.SustanciasEnElAmbiente, ObjTrace.SustanciasContactoConPiel, ObjTrace.ContactoPersonaEnferma, ObjTrace.CrianzaAnimalesDomesticos,
                        ObjTrace.AguaPotable, ObjTrace.DisposicionExcretas, ObjTrace.ReaccionAdversaMedicamentos, ObjTrace.SaludBucal, ObjTrace.VigilanciaDeCrecimiento,
                        ObjTrace.VigilanciaDelDesarrollo, ObjTrace.IdValoracionFuncional1, ObjTrace.IdValoracionFuncional2, ObjTrace.IdValoracionFuncional3,
                        ObjTrace.IdValoracionFuncional4, ObjTrace.IdValoracionFuncional5, ObjTrace.IdValoracionFuncional6, ObjTrace.DiagnosticoFuncional,
                        ObjTrace.IdEstadoCognitivo1, ObjTrace.IdEstadoCognitivo2, ObjTrace.IdEstadoCognitivo3, ObjTrace.IdEstadoCognitivo4,
                        ObjTrace.IdEstadoCognitivo5, ObjTrace.IdEstadoCognitivo6, ObjTrace.IdEstadoCognitivo7, ObjTrace.IdEstadoCognitivo8, ObjTrace.IdEstadoCognitivo9,
                        ObjTrace.IdEstadoCognitivo10, ObjTrace.ValoracionCognitiva, ObjTrace.IdEstadoAfectivo1, ObjTrace.IdEstadoAfectivo2, ObjTrace.IdEstadoAfectivo3,
                        ObjTrace.IdEstadoAfectivo4, ObjTrace.ConManifestacionesDepresivas, ObjTrace.ValoracionSocioFamiliar1, ObjTrace.ValoracionSocioFamiliar2,
                        ObjTrace.ValoracionSocioFamiliar3, ObjTrace.ValoracionSocioFamiliar4, ObjTrace.ValoracionSocioFamiliar5, ObjTrace.ValoracionSocioFamiliar,
                        ObjTrace.IdCategoriaAdutoMayor, ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                        ObjTrace.FechaModificacion, ObjTrace.Accion).SingleOrDefault();
                    valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                    // context.Database.Log = Console.Write;

                }
            }
            catch (Exception ex)
            {
                //var sqlException = ex.InnerException as SqlException;
                throw ex;
            }

            return valorRetorno;
        }
        public List<SS_HC_Anamnesis_AP> AnamnesisAP_Listar(SS_HC_Anamnesis_AP ObjTrace)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_Anamnesis_AP> objLista = new List<SS_HC_Anamnesis_AP>();
            try
            {
                using (var context = new WEB_ERPSALUDEntities())
                {
                    objLista = context.USP_Anamnesis_AP_Listar(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente, ObjTrace.EpisodioClinico,
                       ObjTrace.IdTipoEmbarazo,
                       ObjTrace.PatologiaGestacion, ObjTrace.IdControlPrenatal, ObjTrace.CPnumeroControles, ObjTrace.CPnumeroEmbarazos, ObjTrace.LugarControl,
                       ObjTrace.IdTipoParto, ObjTrace.ComplicacionesParto, ObjTrace.IdLugarParto, ObjTrace.IdPartoAtendidoPor, ObjTrace.AntecentesPatologicos,
                       ObjTrace.SemanasGestacionNacer, ObjTrace.PesoAlNacerGR, ObjTrace.TallaAlNacerCM, ObjTrace.PerimetroCefalicoCM, ObjTrace.PatologiasPernatales,
                       ObjTrace.DiasHospitalizacion, ObjTrace.IdTipoLecheHasta6meses, ObjTrace.AntecLactancia, ObjTrace.EdadInicioAblactanciaMeses,
                       ObjTrace.DesarrolloSicomotriz, ObjTrace.FechaUltimaRegla, ObjTrace.FechaUltimoPeriodo, ObjTrace.MetodosAnticonceptivos,
                       ObjTrace.Menarquia, ObjTrace.Menopausia, ObjTrace.CaracteristicasMenstruaciones, ObjTrace.InformacionEmbarazos, ObjTrace.Transfusiones,
                       ObjTrace.DeinmunizFechaAproximada, ObjTrace.DeinmunizEdadAproximada, ObjTrace.Alcohol, ObjTrace.Tabaco, ObjTrace.Drogas,
                       ObjTrace.ActividadFisica, ObjTrace.ConsumoVerduras, ObjTrace.ConsumoFrutas, ObjTrace.Medicamentos, ObjTrace.Alimentos,
                       ObjTrace.SustanciasEnElAmbiente, ObjTrace.SustanciasContactoConPiel, ObjTrace.ContactoPersonaEnferma, ObjTrace.CrianzaAnimalesDomesticos,
                       ObjTrace.AguaPotable, ObjTrace.DisposicionExcretas, ObjTrace.ReaccionAdversaMedicamentos, ObjTrace.SaludBucal, ObjTrace.VigilanciaDeCrecimiento,
                       ObjTrace.VigilanciaDelDesarrollo, ObjTrace.IdValoracionFuncional1, ObjTrace.IdValoracionFuncional2, ObjTrace.IdValoracionFuncional3,
                       ObjTrace.IdValoracionFuncional4, ObjTrace.IdValoracionFuncional5, ObjTrace.IdValoracionFuncional6, ObjTrace.DiagnosticoFuncional,
                       ObjTrace.IdEstadoCognitivo1, ObjTrace.IdEstadoCognitivo2, ObjTrace.IdEstadoCognitivo3, ObjTrace.IdEstadoCognitivo4,
                       ObjTrace.IdEstadoCognitivo5, ObjTrace.IdEstadoCognitivo6, ObjTrace.IdEstadoCognitivo7, ObjTrace.IdEstadoCognitivo8, ObjTrace.IdEstadoCognitivo9,
                       ObjTrace.IdEstadoCognitivo10, ObjTrace.ValoracionCognitiva, ObjTrace.IdEstadoAfectivo1, ObjTrace.IdEstadoAfectivo2, ObjTrace.IdEstadoAfectivo3,
                       ObjTrace.IdEstadoAfectivo4, ObjTrace.ConManifestacionesDepresivas, ObjTrace.ValoracionSocioFamiliar1, ObjTrace.ValoracionSocioFamiliar2,
                       ObjTrace.ValoracionSocioFamiliar3, ObjTrace.ValoracionSocioFamiliar4, ObjTrace.ValoracionSocioFamiliar5, ObjTrace.ValoracionSocioFamiliar,
                       ObjTrace.IdCategoriaAdutoMayor, ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                       ObjTrace.FechaModificacion, ObjTrace.Accion).ToList();

                    DataKey = new
                    {
                        UnidadReplicacion = ObjTrace.UnidadReplicacion,
                        IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                        EpisodioClinico = ObjTrace.EpisodioClinico,
                        IdPaciente = ObjTrace.IdPaciente
                    };
                    objAudit.Type = "V";
                    if (objLista.Count > 1) objAudit.Type = "L";
                    objAudit = AddAudita(new SS_HC_Anamnesis_AP(), new SS_HC_Anamnesis_AP(), DataKey, objAudit.Type);
                    //String xlmIn = XMLString(objLista);
                    String xlmIn = XMLString(objLista, new List<SS_HC_Anamnesis_AP>(), "SS_HC_Anamnesis_AP");
                    objAudit.TableName = "SS_HC_Anamnesis_AP";
                    objAudit.Type = "V";
                    objAudit.VistaData = xlmIn;
                    context.Entry(objAudit).State = EntityState.Added;
                    context.SaveChanges();
                    //*/
                    return objLista;
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int setMantAnamnesisAP(SS_HC_Anamnesis_AP objCabecera, List<SS_HC_Anamnesis_AP> listaDetalle,
                   List<SS_HC_Anamnesis_AP_Detalle> listaDetalle2)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        var InformacionObj = (from t in context.SS_HC_Anamnesis_AP
                                              where t.IdPaciente == objCabecera.IdPaciente
                                              && t.EpisodioClinico == objCabecera.EpisodioClinico
                                              && t.IdEpisodioAtencion == objCabecera.IdEpisodioAtencion
                                              orderby t.IdEpisodioAtencion descending
                                              select t).SingleOrDefault();
                        if (InformacionObj == null) InformacionObj = new SS_HC_Anamnesis_AP();

                        iReturnValue = context.USP_ANAMNESIS_AP(objCabecera.UnidadReplicacion, objCabecera.IdEpisodioAtencion, objCabecera.IdPaciente, objCabecera.EpisodioClinico,
                          objCabecera.IdTipoEmbarazo,
                          objCabecera.PatologiaGestacion, objCabecera.IdControlPrenatal, objCabecera.CPnumeroControles, objCabecera.CPnumeroEmbarazos, objCabecera.LugarControl,
                          objCabecera.IdTipoParto, objCabecera.ComplicacionesParto, objCabecera.IdLugarParto, objCabecera.IdPartoAtendidoPor, objCabecera.AntecentesPatologicos,
                          objCabecera.SemanasGestacionNacer, objCabecera.PesoAlNacerGR, objCabecera.TallaAlNacerCM, objCabecera.PerimetroCefalicoCM, objCabecera.PatologiasPernatales,
                          objCabecera.DiasHospitalizacion, objCabecera.IdTipoLecheHasta6meses, objCabecera.AntecLactancia, objCabecera.EdadInicioAblactanciaMeses,
                          objCabecera.DesarrolloSicomotriz, objCabecera.FechaUltimaRegla, objCabecera.FechaUltimoPeriodo, objCabecera.MetodosAnticonceptivos,
                          objCabecera.Menarquia, objCabecera.Menopausia, objCabecera.CaracteristicasMenstruaciones, objCabecera.InformacionEmbarazos, objCabecera.Transfusiones,
                          objCabecera.DeinmunizFechaAproximada, objCabecera.DeinmunizEdadAproximada, objCabecera.Alcohol, objCabecera.Tabaco, objCabecera.Drogas,
                          objCabecera.ActividadFisica, objCabecera.ConsumoVerduras, objCabecera.ConsumoFrutas, objCabecera.Medicamentos, objCabecera.Alimentos,
                          objCabecera.SustanciasEnElAmbiente, objCabecera.SustanciasContactoConPiel, objCabecera.ContactoPersonaEnferma, objCabecera.CrianzaAnimalesDomesticos,
                          objCabecera.AguaPotable, objCabecera.DisposicionExcretas, objCabecera.ReaccionAdversaMedicamentos, objCabecera.SaludBucal, objCabecera.VigilanciaDeCrecimiento,
                          objCabecera.VigilanciaDelDesarrollo, objCabecera.IdValoracionFuncional1, objCabecera.IdValoracionFuncional2, objCabecera.IdValoracionFuncional3,
                          objCabecera.IdValoracionFuncional4, objCabecera.IdValoracionFuncional5, objCabecera.IdValoracionFuncional6, objCabecera.DiagnosticoFuncional,
                          objCabecera.IdEstadoCognitivo1, objCabecera.IdEstadoCognitivo2, objCabecera.IdEstadoCognitivo3, objCabecera.IdEstadoCognitivo4,
                          objCabecera.IdEstadoCognitivo5, objCabecera.IdEstadoCognitivo6, objCabecera.IdEstadoCognitivo7, objCabecera.IdEstadoCognitivo8, objCabecera.IdEstadoCognitivo9,
                          objCabecera.IdEstadoCognitivo10, objCabecera.ValoracionCognitiva, objCabecera.IdEstadoAfectivo1, objCabecera.IdEstadoAfectivo2, objCabecera.IdEstadoAfectivo3,
                          objCabecera.IdEstadoAfectivo4, objCabecera.ConManifestacionesDepresivas, objCabecera.ValoracionSocioFamiliar1, objCabecera.ValoracionSocioFamiliar2,
                          objCabecera.ValoracionSocioFamiliar3, objCabecera.ValoracionSocioFamiliar4, objCabecera.ValoracionSocioFamiliar5, objCabecera.ValoracionSocioFamiliar,
                          objCabecera.IdCategoriaAdutoMayor, objCabecera.Estado, objCabecera.UsuarioCreacion, objCabecera.FechaCreacion, objCabecera.UsuarioModificacion,
                          objCabecera.FechaModificacion, objCabecera.Accion).SingleOrDefault();

                        DataKey = new
                        {
                            UnidadReplicacion = objCabecera.UnidadReplicacion,
                            IdEpisodioAtencion = objCabecera.IdEpisodioAtencion,
                            EpisodioClinico = objCabecera.EpisodioClinico,
                            IdPaciente = objCabecera.IdPaciente
                        };
                        // Audit

                        objAudit = AddAudita(InformacionObj, objCabecera, DataKey, objCabecera.Accion.Substring(0, 1));
                        objAudit.TableName = "SS_HC_Anamnesis_AP";
                        objAudit.Type = objCabecera.Accion.Substring(0, 1);
                        context.Entry(objAudit).State = EntityState.Added;
                        context.SaveChanges();

                        valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                        if (valorRetorno > 0)
                        {
                            if (listaDetalle != null)
                            {
                                SS_HC_Anamnesis_AP_Detalle objDetallobj;
                                foreach (SS_HC_Anamnesis_AP objDetalle in listaDetalle)
                                {
                                    objDetallobj = new SS_HC_Anamnesis_AP_Detalle();
                                    objDetallobj.Fecha = objDetalle.FechaUltimoPeriodo;
                                    objDetallobj.IdTabla = objDetalle.IdEstadoCognitivo1;
                                    objDetallobj.IdTipoAlergia = objDetalle.IdEstadoCognitivo2;
                                    objDetallobj.Nombre = objDetalle.Alcohol;
                                    objDetallobj.Lugar = objDetalle.Tabaco;
                                    objDetallobj.Dosis = objDetalle.Drogas;
                                    objDetallobj.Observaciones = objDetalle.Alimentos;
                                    objDetallobj.UsuarioCreacion = objDetalle.UsuarioCreacion;
                                    objDetallobj.UsuarioModificacion = objDetalle.UsuarioModificacion;
                                    objDetallobj.FechaModificacion = objDetalle.FechaModificacion;

                                    var InformacionObjDell = (from t in context.SS_HC_Anamnesis_AP_Detalle
                                                              where t.IdPaciente == objDetalle.IdPaciente
                                                              && t.EpisodioClinico == objDetalle.EpisodioClinico
                                                              && t.IdEpisodioAtencion == objDetalle.IdEpisodioAtencion
                                                              && t.Secuencia == objDetalle.DeinmunizEdadAproximada
                                                              orderby t.IdEpisodioAtencion descending
                                                              select t).SingleOrDefault();
                                    if (InformacionObjDell == null) InformacionObjDell = new SS_HC_Anamnesis_AP_Detalle();

                                    iReturnValue = context.USP_ANAMNESIS_AP(objDetalle.UnidadReplicacion, objDetalle.IdEpisodioAtencion, objDetalle.IdPaciente, objDetalle.EpisodioClinico,
                                      objDetalle.IdTipoEmbarazo,
                                      objDetalle.PatologiaGestacion, objDetalle.IdControlPrenatal, objDetalle.CPnumeroControles, objDetalle.CPnumeroEmbarazos, objDetalle.LugarControl,
                                      objDetalle.IdTipoParto, objDetalle.ComplicacionesParto, objDetalle.IdLugarParto, objDetalle.IdPartoAtendidoPor, objDetalle.AntecentesPatologicos,
                                      objDetalle.SemanasGestacionNacer, objDetalle.PesoAlNacerGR, objDetalle.TallaAlNacerCM, objDetalle.PerimetroCefalicoCM, objDetalle.PatologiasPernatales,
                                      objDetalle.DiasHospitalizacion, objDetalle.IdTipoLecheHasta6meses, objDetalle.AntecLactancia, objDetalle.EdadInicioAblactanciaMeses,
                                      objDetalle.DesarrolloSicomotriz, objDetalle.FechaUltimaRegla, objDetalle.FechaUltimoPeriodo, objDetalle.MetodosAnticonceptivos,
                                      objDetalle.Menarquia, objDetalle.Menopausia, objDetalle.CaracteristicasMenstruaciones, objDetalle.InformacionEmbarazos, objDetalle.Transfusiones,
                                      objDetalle.DeinmunizFechaAproximada, objDetalle.DeinmunizEdadAproximada, objDetalle.Alcohol, objDetalle.Tabaco, objDetalle.Drogas,
                                      objDetalle.ActividadFisica, objDetalle.ConsumoVerduras, objDetalle.ConsumoFrutas, objDetalle.Medicamentos, objDetalle.Alimentos,
                                      objDetalle.SustanciasEnElAmbiente, objDetalle.SustanciasContactoConPiel, objDetalle.ContactoPersonaEnferma, objDetalle.CrianzaAnimalesDomesticos,
                                      objDetalle.AguaPotable, objDetalle.DisposicionExcretas, objDetalle.ReaccionAdversaMedicamentos, objDetalle.SaludBucal, objDetalle.VigilanciaDeCrecimiento,
                                      objDetalle.VigilanciaDelDesarrollo, objDetalle.IdValoracionFuncional1, objDetalle.IdValoracionFuncional2, objDetalle.IdValoracionFuncional3,
                                      objDetalle.IdValoracionFuncional4, objDetalle.IdValoracionFuncional5, objDetalle.IdValoracionFuncional6, objDetalle.DiagnosticoFuncional,
                                      objDetalle.IdEstadoCognitivo1, objDetalle.IdEstadoCognitivo2, objDetalle.IdEstadoCognitivo3, objDetalle.IdEstadoCognitivo4,
                                      objDetalle.IdEstadoCognitivo5, objDetalle.IdEstadoCognitivo6, objDetalle.IdEstadoCognitivo7, objDetalle.IdEstadoCognitivo8, objDetalle.IdEstadoCognitivo9,
                                      objDetalle.IdEstadoCognitivo10, objDetalle.ValoracionCognitiva, objDetalle.IdEstadoAfectivo1, objDetalle.IdEstadoAfectivo2, objDetalle.IdEstadoAfectivo3,
                                      objDetalle.IdEstadoAfectivo4, objDetalle.ConManifestacionesDepresivas, objDetalle.ValoracionSocioFamiliar1, objDetalle.ValoracionSocioFamiliar2,
                                      objDetalle.ValoracionSocioFamiliar3, objDetalle.ValoracionSocioFamiliar4, objDetalle.ValoracionSocioFamiliar5, objDetalle.ValoracionSocioFamiliar,
                                      objDetalle.IdCategoriaAdutoMayor, objDetalle.Estado, objDetalle.UsuarioCreacion, objDetalle.FechaCreacion, objDetalle.UsuarioModificacion,
                                      objDetalle.FechaModificacion, objDetalle.Accion).SingleOrDefault();
                                    valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                                    //*  Registra Audit/
                                    DataKey = new
                                    {
                                        UnidadReplicacion = objDetalle.UnidadReplicacion,
                                        IdPaciente = objDetalle.IdPaciente,
                                        EpisodioClinico = objDetalle.EpisodioClinico,
                                        IdEpisodioAtencion = objDetalle.IdEpisodioAtencion,
                                        Secuencia = objDetalle.DeinmunizEdadAproximada
                                    };
                                    if (objDetalle.Accion == "DETALLE")
                                    { objAudit.Type = "N";
                                    }else if (objDetalle.Accion == "DELETEDETALLE")
                                    { objAudit.Type = "D"; 
                                    }else {
                                        objAudit.Type = objCabecera.Accion.Substring(0, 1);
                                    }
                                    String tempoType = objAudit.Type;
                                    objAudit = AddAudita(InformacionObjDell, objDetallobj, DataKey, objAudit.Type);
                                    objAudit.Type =tempoType  ;
                                    objAudit.TableName = "SS_HC_Anamnesis_AP_Detalle";
                                    context.Entry(objAudit).State = EntityState.Added;

                                    //*/
                                }
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
