using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.RepositoryReport.Reportes_Service
{
    public class ServiceReportes
    {
        public static List<rptViewAnamnesisEA> ReporteAnamnesisEA(SS_HC_Anamnesis_EA objSC, int inicio, int final)
        {

            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewAnamnesisEA> objLista = new List<rptViewAnamnesisEA>();
            SS_HC_ImpresionHC obAuditImp = new SS_HC_ImpresionHC();
            SS_HC_ImpresionHC_Detalle obAuditImp2 = new SS_HC_ImpresionHC_Detalle();



            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.RPT_AnamnesisEA_Reportes(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion,
                objSC.IdPaciente, objSC.EpisodioClinico, objSC.MotivoConsulta, objSC.IdFormaInicio, objSC.IdCursoEnfermedad, objSC.Accion).ToList();

                System.Nullable<int> iReturnValue;
                /*
                //aqui me kede falta mapear
                int valorRetorno = 0; //ERROR
                obAuditImp.Accion = "INSERT_TOTAL";
                obAuditImp.UnidadReplicacion = objSC.UnidadReplicacion;
                obAuditImp.HostImpresion = ENTITY_GLOBAL.Instance.HostName;
                obAuditImp.IdPaciente = objSC.IdPaciente;
                obAuditImp.FechaImpresion = DateTime.Now;
                obAuditImp.UsuarioImpresion = ENTITY_GLOBAL.Instance.USUARIO;
                obAuditImp2.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                obAuditImp2.IdOpcion = Convert.ToInt32(ENTITY_GLOBAL.Instance.IDOPCION_ACTUAL);
                obAuditImp2.EpisodioClinico = objSC.EpisodioClinico;
                obAuditImp2.EpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencionPrim;
                obAuditImp2.CodigoOpcion = ENTITY_GLOBAL.Instance.CODOPCION_PAGINA_ACTUAL;
                obAuditImp2.IdFormato = Convert.ToInt32(ENTITY_GLOBAL.Instance.IDFORMATO);
                //obAuditImp2.TipoAtencion = objSelecc.TipoAtencion;
                //obAuditImp2.IdUnidadServicio = objSelecc.IdUnidadServicio;
                //obAuditImp2.IdPersonalSalud = objSelecc.IdPersonalSalud;               
                //obAuditImp2.TipoAtencion 
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    iReturnValue = context.SP_SS_HC_ImpresionHC(obAuditImp.IdImpresion,
                             obAuditImp.UnidadReplicacion, obAuditImp.IdPaciente, obAuditImp.HostImpresion,
                             obAuditImp.UsuarioImpresion, obAuditImp.FechaImpresion, obAuditImp.Accion,
                             obAuditImp2.Secuencial, obAuditImp2.IdEpisodioAtencion, obAuditImp2.IdOpcion,
                             obAuditImp2.EpisodioClinico, obAuditImp2.EpisodioAtencion, obAuditImp2.CodigoOpcion,
                             obAuditImp2.IdFormato, obAuditImp2.TipoAtencion, obAuditImp2.IdUnidadServicio,
                             obAuditImp2.IdPersonalSalud).SingleOrDefault();
                    valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                    context.SaveChanges();
                    dbContextTransaction.Commit();
                }                                 
                */
            }

            return objLista;

        }

        public static List<rptViewSolicitudProducto> ReporteSolicitudProducto(SS_FA_SolicitudProducto objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewSolicitudProducto> objLista = new List<rptViewSolicitudProducto>();
            SS_HC_ImpresionHC obAuditImp = new SS_HC_ImpresionHC();
            SS_HC_ImpresionHC_Detalle obAuditImp2 = new SS_HC_ImpresionHC_Detalle();



            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.RPT_SolicitudProducto_Reportes(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion,
                objSC.IdPaciente, objSC.EpisodioClinico, objSC.Accion).ToList();

                

            }

            return objLista;

        }
        public static List<rptViewAnamnesisAF> ReporteAnamnesisAF(SS_HC_Anamnesis_AF objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewAnamnesisAF> objLista = new List<rptViewAnamnesisAF>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.RPT_AnamnesisAF_Reportes(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion,
                    objSC.IdPaciente, objSC.EpisodioClinico, objSC.Edad, objSC.IdTipoParentesco, objSC.Accion).ToList();

            }
            return objLista;
        }
        public static List<rptViewExamenTriajeFisico> ReporteExamenFisico_Triaje(SS_HC_ExamenFisico_Triaje objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewExamenTriajeFisico> objLista = new List<rptViewExamenTriajeFisico>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.RPT_ExamenFisico_Triaje_Reportes(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion,
                    objSC.IdPaciente, objSC.EpisodioClinico, objSC.Version, objSC.Accion).ToList();

            }
            return objLista;

        }
        public static List<rptViewExamenFisicoRegional> ReporteExamenFisicoRegional(SS_HC_ExamenFisico_Regional objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewExamenFisicoRegional> objLista = new List<rptViewExamenFisicoRegional>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.RPT_ExamenFisico_Regional_Reportes(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion,
                    objSC.IdPaciente, objSC.EpisodioClinico, objSC.Version, objSC.Accion).ToList();

            }
            return objLista;

        }
        public static List<rptViewDiagnostico> ReporteDiagnostico(SS_HC_Diagnostico objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewDiagnostico> objLista = new List<rptViewDiagnostico>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.RPT_Diagnostico_Reportes(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion,
                    objSC.IdPaciente, objSC.EpisodioClinico, objSC.Version, objSC.Accion).ToList();

            }
            return objLista;

        }
        public static List<rptViewEvolucionObjetiva> ReporteEvolucionObjetiva(SS_HC_EvolucionObjetiva objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewEvolucionObjetiva> objLista = new List<rptViewEvolucionObjetiva>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.RPT_EvolucionObjetiva_Reportes(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion,
                    objSC.IdPaciente, objSC.EpisodioClinico, objSC.Version, objSC.Accion).ToList();

            }
            return objLista;

        }
        public static List<rptViewExamenSolicitado> ReporteExamenSolicitado(SS_HC_ExamenSolicitado objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewExamenSolicitado> objLista = new List<rptViewExamenSolicitado>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.RPT_ExamenSolicitado_Reportes(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion,
                    objSC.IdPaciente, objSC.EpisodioClinico, objSC.Version, objSC.Accion).ToList();

            }
            return objLista;

        }
        public static List<rptViewMedicamento> ReporteMedicamento(SS_HC_Medicamento objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewMedicamento> objLista = new List<rptViewMedicamento>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.RPT_Medicamentos_Reportes(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion,
                    objSC.IdPaciente, objSC.EpisodioClinico, objSC.Version, objSC.Accion).ToList();

            }
            return objLista;

        }
        public static List<rptViewMedicamento> ReporteMedicamento(SS_HC_ExamenSolicitado objMedicamento, int p1, int p2)
        {
            throw new NotImplementedException();
        }
        public static List<rptViewAnamnesisAP> ReporteAnamnesisAP(SS_HC_Anamnesis_AP objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewAnamnesisAP> objLista = new List<rptViewAnamnesisAP>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.RPT_AnamnesisAP_Reportes(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion,
                    objSC.IdPaciente, objSC.EpisodioClinico, objSC.UsuarioModificacion, objSC.Accion).ToList();

            }
            return objLista;

        }
        public static List<rptViewEmitirDescansoMedico> ReporteEmitirDescansoMedico(SS_HC_DescansoMedico objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewEmitirDescansoMedico> objLista = new List<rptViewEmitirDescansoMedico>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.RPT_EmitirDescansoMedico_Reportes(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion,
                    objSC.IdPaciente, objSC.EpisodioClinico, objSC.UsuarioModificacion, objSC.Accion).ToList();

            }
            return objLista;

        }
        public static List<rptViewProximaAtencion> ReporteProximaAtencion(SS_HC_ProximaAtencion objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewProximaAtencion> objLista = new List<rptViewProximaAtencion>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.RPT_ProximaAtencion_Reportes(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion,
                    objSC.IdPaciente, objSC.EpisodioClinico, objSC.UsuarioModificacion, objSC.Accion).ToList();

            }
            return objLista;

        }
        public static List<rptViewSolicitarReferencia> ReporteSolicitarReferencia(SS_HC_ProximaAtencion objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewSolicitarReferencia> objLista = new List<rptViewSolicitarReferencia>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.RPT_SolicitarReferencias_Reportes(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion,
                    objSC.IdPaciente, objSC.EpisodioClinico, objSC.UsuarioModificacion, objSC.Accion).ToList();

            }
            return objLista;

        }
        public static List<rptViewExamenApoyoDiagnostico_FE> ReporteExamenApoyoDiagnostico_FE(SS_HC_ExamenSolicitadoFE objRF, int inicio, int final)
        {
            List<rptViewExamenApoyoDiagnostico_FE> objLista = new List<rptViewExamenApoyoDiagnostico_FE>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = (from t in context.rptViewExamenApoyoDiagnostico_FE
                            where
                            t.UnidadReplicacion == objRF.UnidadReplicacion
                            && t.IdPaciente == objRF.IdPaciente
                            && t.EpisodioClinico == objRF.EpisodioClinico
                            && t.IdEpisodioAtencion == objRF.IdEpisodioAtencion
                            orderby t.IdEpisodioAtencion descending
                            select t).ToList();
            }
            return objLista;
        }
        public static List<rptViewCuidadosPreventivo> ReporteCuidadosPreventivo(SS_HC_SeguimientoRiesgo objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewCuidadosPreventivo> objLista = new List<rptViewCuidadosPreventivo>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.RPT_CuidadosPreventivos_Reportes(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion,
                    objSC.IdPaciente, objSC.EpisodioClinico, objSC.UsuarioModificacion, objSC.Accion).ToList();

            }
            return objLista;

        }

        /**LISTA POR ENTITY FW*/
        public static List<rptViewAgrupador> ReporteViewAgrupador(rptViewAgrupador objSC)
        {
            List<rptViewAgrupador> objLista = new List<rptViewAgrupador>();
            using (var context = new WEB_ERPSALUDEntities())
            {

                List<rptViewAgrupador> objConsultas = (from t in context.rptViewAgrupadors
                                                       where
                                                       t.UnidadReplicacion == objSC.UnidadReplicacion
                                                       && t.IdPaciente == objSC.IdPaciente
                                                       && t.EpisodioClinico == objSC.EpisodioClinico
                                                       && t.IdEpisodioAtencion == objSC.EpisodioAtencion
                                                       orderby t.EpisodioAtencion descending
                                                       /*&& t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                       orderby t.IdEpisodioAtencion descending*/
                                                       select t).ToList();



                if (objConsultas != null)
                {
                    objLista.AddRange(objConsultas);
                }
            }
            return objLista;

        }
        // *** FORMULARIOS (EXTRAS) ***
        public static List<rptViewDiagnostico_FE> ReporteDiagnostico_FE(SS_HC_Diagnostico_FE objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewDiagnostico_FE> objLista = new List<rptViewDiagnostico_FE>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                //objLista = context.RPT_Diagnostico_Reportes_FE(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion,
                //    objSC.IdPaciente, objSC.EpisodioClinico, objSC.Version, objSC.Accion).ToList();
                objLista = (from t in context.rptViewDiagnostico_FE
                            where
                            t.UnidadReplicacion == objSC.UnidadReplicacion
                            && t.IdPaciente == objSC.IdPaciente
                            && t.EpisodioClinico == objSC.EpisodioClinico
                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                            orderby t.IdEpisodioAtencion descending
                            select t).ToList();

            }
            return objLista;

        }
        public static List<rptViewEmitirDescansoMedico_FE> ReporteEmitirDescansoMedico_FE(SS_HC_DescansoMedico_FE objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewEmitirDescansoMedico_FE> objLista = new List<rptViewEmitirDescansoMedico_FE>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.RPT_EmitirDescansoMedico_Reportes_FE(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion,
                    objSC.IdPaciente, objSC.EpisodioClinico, objSC.Version, objSC.Accion).ToList();

            }
            return objLista;

        }
        public static List<rptView_ValoracionFuncionalAM_FE> ReporteValoracionAM_FE(SS_HC_ValoracionAM_FE objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptView_ValoracionFuncionalAM_FE> objLista = new List<rptView_ValoracionFuncionalAM_FE>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = (from t in context.rptView_ValoracionFuncionalAM_FE
                            where
                            t.Unidadreplicacion == objSC.UnidadReplicacion
                            && t.Idpaciente == objSC.IdPaciente
                            && t.EpisodioClinico == objSC.EpisodioClinico
                            && t.idEpisodioAtencion == objSC.IdEpisodioAtencion

                            select t).ToList();
            }
            return objLista;

        }
        public static List<rptViewProximaAtencion_FE> ReporteProximaAtencion_FE(SS_HC_ProximaAtencion_FE objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewProximaAtencion_FE> objLista = new List<rptViewProximaAtencion_FE>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = (from t in context.rptViewProximaAtencion_FE
                            where
                            t.UnidadReplicacion == objSC.UnidadReplicacion
                            && t.IdPaciente == objSC.IdPaciente
                            && t.EpisodioClinico == objSC.EpisodioClinico
                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion

                            select t).ToList();
            }
            return objLista;
        }        
        public static List<rptViewAlergias_FE> ReporteAlergia_FE(SS_HC_Alergia_FE objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewAlergias_FE> objLista = new List<rptViewAlergias_FE>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                //objLista = context.rptViewAlergias_FE(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion,
                //    objSC.IdPaciente, objSC.EpisodioClinico, objSC.Version, objSC.Accion).ToList();
                objLista = (from t in context.rptViewAlergias_FE
                            where
                            t.UnidadReplicacion == objSC.UnidadReplicacion
                            && t.IdPaciente == objSC.IdPaciente
                            && t.EpisodioClinico == objSC.EpisodioClinico
                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                            orderby t.IdEpisodioAtencion descending
                            select t).ToList();
            }
            return objLista;

        }
        public static List<rptViewReferencia_FE> ReporteReferencia_FE(SS_HC_Referencia_FE objRF, int inicio, int final)
        {
            List<rptViewReferencia_FE> objLista = new List<rptViewReferencia_FE>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = (from t in context.rptViewReferencia_FE
                            where
                            t.UnidadReplicacion == objRF.UnidadReplicacion
                            && t.IdPaciente == objRF.IdPaciente
                            && t.EpisodioClinico == objRF.EpisodioClinico
                            && t.IdEpisodioAtencion == objRF.IdEpisodioAtencion
                            orderby t.IdEpisodioAtencion descending
                            select t).ToList();
            }
            return objLista;

        }
        public static List<rptViewInmunizacionNinio_FE> ReporteInmunizacionNinio_FE(SS_HC_AntecedentesPersonalesIN_FE objSC, int inicio, int final)
        {

            List<rptViewInmunizacionNinio_FE> objLista = new List<rptViewInmunizacionNinio_FE>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                //objLista = (from t in context.rptViewInmunizacionNinio_FE
                //            where
                //            t.UnidadReplicacion == objSC.UnidadReplicacion
                //            && t.IdPaciente == objSC.IdPaciente
                //            && t.EpisodioClinico == objSC.EpisodioClinico
                //            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                //            orderby t.IdEpisodioAtencion descending
                //            select t).ToList();
                objLista = context.RPT_ImunizacionNinio_Reportes_FE(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion,
                    objSC.IdPaciente, objSC.EpisodioClinico, objSC.Accion, objSC.Version).ToList();

            }
            return objLista;

        }
        public static List<rptViewInmunizacionAdulto_FE> ReporteInmunizacionAdulto_FE(SS_HC_AntecedentesPersonalesIAdul_FE objSC, int inicio, int final)
        {
            List<rptViewInmunizacionAdulto_FE> objLista = new List<rptViewInmunizacionAdulto_FE>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = (from t in context.rptViewInmunizacionAdulto_FE
                            where
                            t.UnidadReplicacion == objSC.UnidadReplicacion
                            && t.IdPaciente == objSC.IdPaciente
                            && t.EpisodioClinico == objSC.EpisodioClinico
                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                            orderby t.IdEpisodioAtencion descending
                            select t).ToList();

                //objLista = context.RPT_ImunizacionNinio_Reportes_FE(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion,
                //    objSC.IdPaciente, objSC.EpisodioClinico, objSC.Accion, objSC.Version).ToList();

            }
            return objLista;

        }
        public static List<rptViewApoyoDiagnostico_FE> ReporteApoyoDiagnostico_FE(SS_HC_ApoyoDiagnostico_FE objSC, int inicio, int final)
        {

            List<rptViewApoyoDiagnostico_FE> objLista = new List<rptViewApoyoDiagnostico_FE>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = (from t in context.rptViewApoyoDiagnostico_FE
                            where
                            t.UnidadReplicacion == objSC.UnidadReplicacion
                            && t.IdPaciente == objSC.IdPaciente
                            && t.EpisodioClinico == objSC.EpisodioClinico
                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                            orderby t.IdEpisodioAtencion descending
                            select t).ToList();

                //objLista = context.RPT_ImunizacionNinio_Reportes_FE(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion,
                //    objSC.IdPaciente, objSC.EpisodioClinico, objSC.Accion, objSC.Version).ToList();

            }
            return objLista;

        }                   
        public static List<rptViewValoracionAM_FE> rptViewValoracionAM_FE(SS_HC_ValoracionAM_FE objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewValoracionAM_FE> objLista = new List<rptViewValoracionAM_FE>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = (from t in context.rptViewValoracionAM_FE
                            where
                            t.UnidadReplicacion == objSC.UnidadReplicacion
                            && t.IdPaciente == objSC.IdPaciente
                            && t.EpisodioClinico == objSC.EpisodioClinico
                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion

                            select t).ToList();
            }
            return objLista;
        }
        public static List<rptViewValoracionMentalAM_FE> rptViewValoracionMentalAM_FE(SS_HC_ValoracionMentalAM_FE objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewValoracionMentalAM_FE> objLista = new List<rptViewValoracionMentalAM_FE>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = (from t in context.rptViewValoracionMentalAM_FE
                            where
                            t.UnidadReplicacion == objSC.UnidadReplicacion
                            && t.IdPaciente == objSC.IdPaciente
                            && t.EpisodioClinico == objSC.EpisodioClinico
                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion

                            select t).ToList();
            }
            return objLista;
        }
        public static List<rptViewEvolucionMedica_FE> rptViewEvolucionMedica_FE(SS_HC_EvolucionMedica_FE objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewEvolucionMedica_FE> objLista = new List<rptViewEvolucionMedica_FE>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = (from t in context.rptViewEvolucionMedica_FE
                            where
                            t.UnidadReplicacion == objSC.UnidadReplicacion
                            && t.IdPaciente == objSC.IdPaciente
                            && t.EpisodioClinico == objSC.EpisodioClinico
                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion

                            select t).ToList();
            }
            return objLista;
        }     
        public static List<rptViewInterconsulta_FE> rptViewInterconsulta_FE(SS_HC_InterConsulta_FE objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewInterconsulta_FE> objLista = new List<rptViewInterconsulta_FE>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = (from t in context.rptViewInterconsulta_FE
                            where
                            t.UnidadReplicacion == objSC.UnidadReplicacion
                            && t.IdPaciente == objSC.IdPaciente
                            && t.EpisodioClinico == objSC.EpisodioClinico
                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion

                            select t).ToList();
            }
            return objLista;
        }
        public static List<rptViewValoracionSocioFamAM_FE> rptViewValoracionSocioFamAM_FE(SS_HC_ValoracionSocioFamAM_FE objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewValoracionSocioFamAM_FE> objLista = new List<rptViewValoracionSocioFamAM_FE>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = (from t in context.rptViewValoracionSocioFamAM_FE
                            where
                            t.UnidadReplicacion == objSC.UnidadReplicacion
                            && t.IdPaciente == objSC.IdPaciente
                            && t.EpisodioClinico == objSC.EpisodioClinico
                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion

                            select t).ToList();
            }
            return objLista;
        }
        public static List<rptViewAnamnesis_AFAM_FE> rptViewAnamnesis_AFAM_FE(SS_HC_Anamnesis_AFAM_CAB_FE objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewAnamnesis_AFAM_FE> objLista = new List<rptViewAnamnesis_AFAM_FE>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = (from t in context.rptViewAnamnesis_AFAM_FE
                            where
                            t.UnidadReplicacion == objSC.UnidadReplicacion
                            && t.IdPaciente == objSC.IdPaciente
                            && t.EpisodioClinico == objSC.EpisodioClinico
                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion

                            select t).ToList();
            }
            return objLista;
        }
        public static List<rptViewContrarReferencia_FE> rptViewContrarReferencia_FE(SS_HC_CONTRARREFERENCIA_FE objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewContrarReferencia_FE> objLista = new List<rptViewContrarReferencia_FE>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = (from t in context.rptViewContrarReferencia_FE
                            where
                            t.UnidadReplicacion == objSC.UnidadReplicacion
                            && t.IdPaciente == objSC.IdPaciente
                            && t.EpisodioClinico == objSC.EpisodioClinico
                            && t.idEpisodioAtencion == objSC.IdEpisodioAtencion

                            select t).ToList();
            }
            return objLista;
        }
        public static List<rptViewSolicitudTransfusional_FE> rptViewSolicitudTranfusional_FE(SS_HC_SolucitudTransfusional_FE objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewSolicitudTransfusional_FE> objLista = new List<rptViewSolicitudTransfusional_FE>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = (from t in context.rptViewSolicitudTransfusional_FE
                            where
                            t.UnidadReplicacion == objSC.UnidadReplicacion
                            && t.IdPaciente == objSC.IdPaciente
                            && t.EpisodioClinico == objSC.EpisodioClinico
                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                            select t).ToList();
            }
            return objLista;
        }
        public static List<rptViewMedicamentos_FE> rptViewMedicamentos_FE(SS_HC_Medicamento_FE objSC, int inicio, int final, int tipomedicamento)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewMedicamentos_FE> objLista = new List<rptViewMedicamentos_FE>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                if (tipomedicamento == 0)
                {

                    objLista = (from t in context.rptViewMedicamentos_FE
                                where
                                t.UnidadReplicacion == objSC.UnidadReplicacion
                                && t.IdPaciente == objSC.IdPaciente
                                && t.EpisodioClinico == objSC.EpisodioClinico
                                && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                && t.GrupoMedicamento == 0 ///objSC.GrupoMedicamento
                                select t).ToList();
                }
                else
                {
                    objLista = (from t in context.rptViewMedicamentos_FE
                                where
                                t.UnidadReplicacion == objSC.UnidadReplicacion
                                && t.IdPaciente == objSC.IdPaciente
                                && t.EpisodioClinico == objSC.EpisodioClinico
                                && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                && t.TipoMedicamento == tipomedicamento
                                && t.GrupoMedicamento == 0 ///objSC.GrupoMedicamento
                                select t).ToList();
                }
            }
            return objLista;
        }
        public static List<rptViewDieta_FE> rptViewDieta_FE(SS_HC_Medicamento_FE objSC, int inicio, int final,int tipomedicamento)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewDieta_FE> objLista = new List<rptViewDieta_FE>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                if (tipomedicamento == 0) { 

                objLista = (from t in context.rptViewDieta_FE
                            where
                            t.UnidadReplicacion == objSC.UnidadReplicacion
                            && t.IdPaciente == objSC.IdPaciente
                            && t.EpisodioClinico == objSC.EpisodioClinico
                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion

                            select t).ToList();
                }
                else
                {
                    objLista = (from t in context.rptViewDieta_FE
                                where
                                t.UnidadReplicacion == objSC.UnidadReplicacion
                                && t.IdPaciente == objSC.IdPaciente
                                && t.EpisodioClinico == objSC.EpisodioClinico
                                && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                && t.TipoMedicamento == tipomedicamento
                                select t).ToList();


                }
            }
            return objLista;
        }


        public static List<rptViewAntecedentesPersonalesFisiologicos_FE> rptViewAntecedentesFisiologicos_FE(SS_HC_AntecedentesPersonalesFisiologicos_FE objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewAntecedentesPersonalesFisiologicos_FE> objLista = new List<rptViewAntecedentesPersonalesFisiologicos_FE>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = (from t in context.rptViewAntecedentesPersonalesFisiologicos_FE
                            where
                            t.UnidadReplicacion == objSC.UnidadReplicacion
                            && t.IdPaciente == objSC.IdPaciente
                            && t.EpisodioClinico == objSC.EpisodioClinico
                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion

                            select t).ToList();
            }
            return objLista;
        }





        public static List<rptViewAntFisiologicoPediatricoFE> rptViewAntFisiologicoPediatricoFE(SS_HC_Ant_Fisiologico_Pediatrico_FE objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewAntFisiologicoPediatricoFE> objLista = new List<rptViewAntFisiologicoPediatricoFE>();
            using (var context = new WEB_ERPSALUDEntities())
            {

                objLista = (from t in context.rptViewAntFisiologicoPediatricoFE
                            where
                            t.UnidadReplicacion == objSC.UnidadReplicacion
                            && t.IdPaciente == objSC.IdPaciente
                            && t.EpisodioClinico == objSC.EpisodioClinico
                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion

                            select t).ToList();
            }
            return objLista;
        }

        public static List<rptViewAntecedentesPersonalesPatologicosGenerales_FE> rptViewPatologicosGenerales_FE(SS_HC_Anam_AP_PatologicosGenerales_FE objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewAntecedentesPersonalesPatologicosGenerales_FE> objLista = new List<rptViewAntecedentesPersonalesPatologicosGenerales_FE>();
            using (var context = new WEB_ERPSALUDEntities())
            {

                objLista = (from t in context.rptViewAntecedentesPersonalesPatologicosGenerales_FE
                            where
                            t.UnidadReplicacion == objSC.UnidadReplicacion
                            && t.IdPaciente == objSC.IdPaciente
                            && t.EpisodioClinico == objSC.EpisodioClinico
                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion

                            select t).ToList();
            }
            return objLista;
        }

        public static List<rptViewSeguridadCirugia_FE> rptViewSeguridadCirugia_FE(SS_HC_SeguridadCirugia_FE objSC, int inicio, int final,int tipocirugia)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewSeguridadCirugia_FE> objLista = new List<rptViewSeguridadCirugia_FE>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = (from t in context.rptViewSeguridadCirugia_FE
                            where
                            t.UnidadReplicacion == objSC.UnidadReplicacion
                            && t.IdPaciente == objSC.IdPaciente
                            && t.EpisodioClinico == objSC.EpisodioClinico
                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                            && t.TipoCirugia == tipocirugia

                            select t).ToList();
            }
            return objLista;
        }

        public static List<rptViewEscalaStewart_FE> rptViewEscalaStewart_FE(SS_HC_EscalaStewart_FE objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewEscalaStewart_FE> objLista = new List<rptViewEscalaStewart_FE>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = (from t in context.rptViewEscalaStewart_FE
                            where
                            t.UnidadReplicacion == objSC.UnidadReplicacion
                            && t.IdPaciente == objSC.IdPaciente
                            && t.EpisodioClinico == objSC.EpisodioClinico
                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                            select t).ToList();
            }
            return objLista;
        }

        public static List<rptViewMedicamentos_Epi2_FE> rptViewMedicamentos_Epi2_FE(SS_HC_Medicamento_FE objSC, int inicio, int final, int tipomedicamento)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<rptViewMedicamentos_Epi2_FE> objLista = new List<rptViewMedicamentos_Epi2_FE>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                if (tipomedicamento == 0)
                {

                    objLista = (from t in context.rptViewMedicamentos_Epi2_FE
                                where
                                t.UnidadReplicacion == objSC.UnidadReplicacion
                                && t.IdPaciente == objSC.IdPaciente
                                && t.EpisodioClinico == objSC.EpisodioClinico
                                && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                && t.GrupoMedicamento == 0
                                select t).ToList();
                }
                else
                {
                    objLista = (from t in context.rptViewMedicamentos_Epi2_FE
                                where
                                t.UnidadReplicacion == objSC.UnidadReplicacion
                                && t.IdPaciente == objSC.IdPaciente
                                && t.EpisodioClinico == objSC.EpisodioClinico
                                && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                //&& t.TipoMedicamento == tipomedicamento
                                //&& t.GrupoMedicamento == 0 ///objSC.GrupoMedicamento
                                select t).ToList();
                }

            }
            return objLista;
        }


        // FIN FORMULARIOS (EXTRAS)
    }
}
