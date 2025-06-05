using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using CrystalDecisions.Shared;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.ReportSource;

using System.Data;
using System.Drawing.Printing;
using SoluccionSalud.Entidades.Entidades;
using System.IO;
using SoluccionSalud.RepositoryReport;
using SoluccionSalud.RepositoryReport.Reportes_Service;
using SoluccionSalud.Componentes;


namespace AppSaludMVC.Reportes
{
    using SvcAuditoriaImpresion = SoluccionSalud.Service.AuditoriaImpresionService.SvcAuditoriaImpresion;
    using System.Data.SqlClient;
    using System.Configuration;
    using System.Diagnostics;
    using SoluccionSalud.Service._FormularioNuevo;
    using AppSaludMVC.Models;
    using System.ComponentModel;
    using Serilog;
    using System.Collections;

    public partial class VisorReportesHCE : System.Web.UI.Page
    {
        #region Variables Publicas
        public DataTable objTabla1 = new DataTable(); //Recibe Datos para armar el reporte
        public PrintDocument Prd = new PrintDocument();
        public ReportDocument Rpt = new ReportDocument();//crystal report
        public DataSet dsRptViewer = new DataSet();//Para Crear el xml de los reportes
        public string imgIzquierda = "";//Logos  

        public string imgAnestesia1 = "";// Imagen anestesia 1 
        public string imgAnestesia2 = "";//Imagen anestesia 2  
        public string imgAnestesia3 = "";//Imagen anestesia 3  
        public string imgAnestesia4 = "";//Imagen anestesia 4  


        public string imgDolor = "";//Logos
        public string imgDerecha = "";//Logos
        public string imgDF = "";//Diagnostico funcional
        public string imgValor = "";
        public string imgEstado = "";
        public string imgValoracionSocio = "";
        public string firma = "";//firma digital
        public string imgFirma = "";
        public string imgFirma2 = "";
        public string imgFirmaContrare = "";
        public string imgFirmaDieta = "";
        public string imgFirmaTransfuncional = "";
        public string imgFirmaRetiro = "";

        public string nombrmedico = "";
        #endregion

        /***CONSTANTES**/
        #region Constantes de Form VERSION I REPORTES


        static string FORM_REPORT_EXPORT = "pdf";

        static string FORM_0000 = AppSaludMVC.Controllers.UTILES_MENSAJES.FORM_ANAMNESIS_EA_F1;
        static string FORM_0001 = "CCEP0306";
        static string FORM_0002 = "CCEP0102";
        static string FORM_0003 = "CCEP0304";
        static string FORM_0004 = "CCEP0104";
        static string FORM_0005 = "CCEP2010";
        static string FORM_0006 = "CCEP0055";
        static string FORM_0007 = "CCEP0253";
        static string FORM_0008 = "CCEP0004";
        static string FORM_0009 = "CCEP0313";
        static string FORM_0010 = "CCEP0311";
        static string FORM_0011 = "CCEP0315";
        static string FORM_0012 = "CCEP0302";


        /* Formularios Extras*/

        static string FORMFE_0001 = "CCEPF012";
        static string FORMFE_0002 = "CCEPF013";
        static string FORMFE_0003 = "CCEP00F3";
        static string FORMFE_0004 = "CCEPF004";
        static string FORMFE_153 = "CCEPF153";

        static string FORMFE_328 = "CCEPF328";

        static string FORMFE_103 = "CCEPF103";
        static string FORMFE_330 = "CCEPF330"; // FORMULARIO DINAMICO   A  FIJO


        static string FORMFE_510 = "CCEPF510";//

        static string FORMFE_202 = "CCEPF202";

        static string FORMFE_511 = "CCEPF422";
        static string FORMFE_512 = "CCEPF420";
        static string FORMFE_521 = "CCEPF424";
        static string FORMFE_513 = "CCEPF425";
        static string FORMFE_514 = "CCEPF432";
        static string FORMFE_515 = "CCEPF444";
        static string FORMFE_561 = "CCEPF446";
        static string FORMFE_560 = "CCEPF443";


        static string FORMFE_562 = "CCEPF448";

        static string FORMFE_563 = "CCEPF435";
        static string FORMFE_564 = "CCEPF431";




        static string FORMFE_516 = "CCEPF447";
        static string FORMFE_517 = "CCEPF460_1";
        static string FORMFE_518 = "CCEPF460_2";

        static string FORMFE_519 = "CCEPF400";
        static string FORMFE_519_2 = "CCEPF400";
        static string FORMFE_519_3 = "CCEPF400";
        static string FORMFE_519_4 = "CCEPF400";
        static string FORMFE_519_5 = "CCEPF400";


        static string FORMFE_520 = "CCEPF203b";


        static string FORMFE_522 = "CCEPF631";

        static string FORMFE_523 = "CCEPF200";
        static string FORMFE_524 = "CCEPF200";
        static string FORMFE_525 = "CCEPF200";
        static string FORMFE_526 = "CCEPF200";


        static string FORMFE_527 = "CCEPF630";
        static string FORMFE_528 = "CCEPF630";
        static string FORMFE_529 = "CCEPF630";

        static string FORMFE_527_2 = "CCEPF630";
        static string FORMFE_527_3 = "CCEPF630";


        static string FORMFE_530 = "CCEPF301b";
        static string FORMFE_531 = "CCEPF449";
        static string FORMFE_532 = "CCEPF430";



        static string FORMFE_305 = "CCEPF305";


        // static string FORMFE_0005 = "CCEPF005";
        static string FORMFE_0005CABGINECO = "CCEPF005";
        static string FORMFE_0005DETGINECO = "CCEPF005";

        static string FORMFE_402CABHELECT1 = "CCEPF402";
        static string FORMFE_402CABHELECT2 = "CCEPF402";
        static string FORMFE_402CABHELECT3 = "CCEPF402";
        static string FORMFE_402DETHELECT1 = "CCEPF402";
        static string FORMFE_402DETHELECT2 = "CCEPF402";

        static string FORMFE_401CABHELECT1 = "CCEPF401";
        static string FORMFE_401CABHELECT2 = "CCEPF401";
        static string FORMFE_401CABHELECT3 = "CCEPF401";
        static string FORMFE_401DETHELECT1 = "CCEPF401";
        static string FORMFE_401DETHELECT2 = "CCEPF401";




        static string FORMFE_302CABHOJA = "CCEPF302";
        static string FORMFE_302DETHOJA = "CCEPF302";

        static string FORMFE_461CIRUENTRADA = "CCEPF461";

        static string FORMFE_462CIRUPAUSA = "CCEPF462";
        static string FORMFE_463CIRUSALIDA = "CCEPF463";


        static string FORMFE_464 = "CCEPF464";

        static string FORMFE_323_1CABANESTESIA = "CCEPF323_1";

        static string FORMFE_323_1CABANESTESIA2 = "CCEPF323_1";


        static string FORMFE_323_1DET1_ANESTESIA = "CCEPF323_1"; //DETALLE EXAMEN 1

        static string FORMFE_323_1DET1_ANESDIAG1 = "CCEPF323_1";
        static string FORMFE_323_1DET1_ANESEXAM2 = "CCEPF323_1"; //DETALLE EXAMEN 2

        static string FORMFE_323_1DET1_ANESDIAG2 = "CCEPF323_1";
        static string FORMFE_323_1DET1_ANESEXAM3 = "CCEPF323_1"; //DETALLE EXAMEN 3

        static string FORMFE_323_1CABANESTESIA3 = "CCEPF323_1";


        //static string FORMFE_323_1DET2_GINECO = "CCEPF323_1";
        //static string FORMFE_323_1DET3_GINECO = "CCEPF323_1";
        //static string FORMFE_323_1DET4_GINECO = "CCEPF323_1";
        //static string FORMFE_323_1DET5_GINECO = "CCEPF323_1";




        static string FORMFE_323_3CAB_ANESTESIA3 = "CCEPF323_3";


        static string FORMFE_0005CAB = "CCEPF006";
        static string FORMFE_0005DET = "CCEPF006";

        static string FORMFE_327CAB = "CCEPF327";
        static string FORMFE_327CAB2 = "CCEPF327";
        static string FORMFE_327CAB3 = "CCEPF327";
        static string FORMFE_327DIAG = "CCEPF327";
        static string FORMFE_327CIRUGIAPRO = "CCEPF327";
        static string FORMFE_327EXAMEN1 = "CCEPF327";
        static string FORMFE_327EXAMEN2 = "CCEPF327";
        static string FORMFE_327EXAMEN3 = "CCEPF327";


        static string FORMFE_319CAB1 = "CCEPF319";
        static string FORMFE_319CAB2 = "CCEPF319";
        static string FORMFE_319CAB3 = "CCEPF319";
        static string FORMFE_319DIAG = "CCEPF319";
        static string FORMFE_319EXAMEN1 = "CCEPF319";

        static string FORMFE_502TOCOLOSIS = "CCEPF502";

        static string FORMFE_0006 = "CCEP00F2";
        static string FORMFE_0007 = "CCEPF014";
        static string FORMFE_0008 = "CCEPF015";
        static string FORMFE_0009 = "CCEPF016";
        static string FORMFE_0010 = "CCEPF017";
        static string FORMFE_0011 = "CCEPF018";
        static string FORMFE_0012 = "CCEP0F90";
        static string FORMFE_0013 = "CCEPF150";
        static string FORMFE_0014 = "CCEPF151";
        static string FORMFE_0015 = "CCEPF152";
        static string FORMFE_0016 = "CCEPF154";
        static string FORMFE_0017 = "CCEPF###";
        static string FORMFE_0018DET1 = "CCEPF100";
        static string FORMFE_0018DET2 = "CCEPF100";
        static string FORMFE_0018DET3 = "CCEPF100";

        static string FORMFE_0019 = "CCEPF101";
        static string FORMFE_0019GRUPAL = "CCEP9919";
        static string FORMFE_0019DET1 = "CCEPF101";
        static string FORMFE_0019DET2 = "CCEPF101";
        static string FORMFE_0019DET3 = "CCEPF101"; //Firmas(Imprimir todos)
        static string FORMFE_0020 = "CCEPF300";
        static string FORMFE_0021 = "CCEPF080";

        /* Formularios FED*/
        static string FORMFE_0030 = "CCEPF###";
        static string FORMFE_0031 = "CCEPF###";
        static string FORMFE_0032 = "CCEPF###";
        static string FORMFE_0033 = "CCEPF###";
        static string FORMFE_0034 = "CCEPF###";
        static string FORMFE_0035 = "CCEPF###";
        static string FORMFE_0036 = "CCEPF###";
        static string FORMFE_0037 = "CCEPF###";
        static string FORMFE_0038 = "CCEPF440";
        static string FORMFE_0039 = "CCEPF441";
        static string FORMFE_0040 = "CCEPF442";
        static string FORMFE_0041 = "CCEPF445";
        static string FORMFE_0042 = "CCEPF447";
        static string FORMFE_0043 = "CCEPF204";
        static string FORMFE_0044 = "CCEPF051";
        static string FORMFE_0045 = "CCEPF001";
        static string FORMFE_0046 = "CCEPF###";
        static string FORMFE_0099 = "CCEPF460_1";
        static string FORMFE_0105 = "CCEPF460_2";
        static string FORMFE_0103 = "CCEPF403_3";
        static string FORMFE_0101 = "CCEPF323_2";
        static string FORMFE_0100 = "CCEPF323_5";
        static string FORMFE_0106 = "CCEPF201_2";
        static string FORMFE_0107 = "CCEPF323_4";
        static string FORMFE_0108 = "CCEPF201_3";
        //static string FORMFE_0109 = "CCEPF403_2";
        static string FORMFE_0110 = "CCEPF403_2";
        //static string FORMFE_0111 = "CCEPF403_1";
        static string FORMFE_600 = "CCEPF403";
        static string FORMFE_600_1 = "CCEPF403";
        static string FORMFE_600_2 = "CCEPF403";
        static string FORMFE_600_3 = "CCEPF403";
        static string FORMFE_600_4 = "CCEPF403";















        #endregion

        protected void Page_Init(object sender, EventArgs e)
        {
            // ReportViewer.ReportSource = ViewData["ReportData"];

            /*
             * Agregado
             * */
            Log.Information("VisorReportesHCE - Page_Init - Entrar");
            try
            {


                if (Request.QueryString["ReportID"] != null)
                {
                    // Agregados: REPORTE INICIAL
                    string reportID = Request.QueryString["ReportID"].ToString();
                    string Visor = Request.QueryString["Visor"].ToString();
                    // AGREGADOS : REPORTE GENERICOS
                    string unidRep = Request.QueryString["UR"];
                    string epiClinico = Request.QueryString["EC"];
                    string epiAten = Request.QueryString["EA"];
                    string paciente = Request.QueryString["PA"];
                    string formatos = Request.QueryString["FOR"];
                    string usuario = Request.QueryString["US"];
                    string nombreFileExp = Request.QueryString["FI"];
                    //string usuarioActual = (ENTITY_GLOBAL.Instance != null ? ENTITY_GLOBAL.Instance.USUARIO : usuario);
                    string usuarioActual = usuario;
                    //CCEP0102
                    switch (reportID)
                    {
                        case "CCEP0003": GenerarReporterptViewAnamnesisEA(Visor);
                            break;
                        case "CCEP0055": GenerarReporterptViewAnamnesisAF(Visor);
                            break;
                        case "CCEP0004": GenerarReporterptViewAnamnesisAP(Visor);
                            break;
                        case "CCEP0102": GenerarReporterptViewExamenTriajeFisico(Visor);
                            break;
                        case "CCEP0104": GenerarReporterptViewExamenFisicoRegional(Visor);
                            break;
                        case "CCEP0253": GenerarReporterptViewDiagnostico(Visor);
                            break;
                        case "CCEP2010": GenerarReporterptViewEvolucionObjetiva(Visor);
                            break;
                        case "CCEP0306": GenerarReporterptViewExamenSolicitado(Visor);
                            break;
                        case "CCEP0304": GenerarReporterptViewMedicamento(Visor);
                            break;
                        case "CCEP0313": GenerarReporterptViewEmitirDescansoMedico(Visor);
                            break;
                        case "CCEP0311": GenerarReporterptViewProximaAtencion(Visor);
                            break;

                        case "CCEP0315": GenerarReporterptViewSolicitarReferencia(Visor);
                            break;

                        case "CCEP0302": GenerarReporterptViewCuidadosPreventivos(Visor);
                            break;

                        case "TOTALHC": GenerarReporterptViewTotalHCE(Visor);
                            break;

                        case "TOTALHCTRIAJE": GenerarReporterptViewTotalTriajeHCE(Visor);
                            break;

                        case "GENERICO_HCE": GenerarReporterptViewGeneralHCE(Visor, unidRep, epiClinico, epiAten, paciente, formatos, usuarioActual, nombreFileExp);
                            break;
                        case "ReportExamenes": GenerarReporteReceta("");
                            break;
                        /**** INICIO FORMULARIO DINAMICO - FIJO: (MEDICOS) ***/
                        case "CCEPF330": GenerarReporterptViewInformeConsultaExterna_FE(Visor);
                            break;
                        // *** FORMULARIOS (EXTRAS) ***
                        case "CCEP0F90": GenerarReporterptViewDiagnostico_FE(Visor);
                            break;
                        case "CCEPF012": GenerarReporterptViewInmunizacionNinio_FE(Visor);
                            break;
                        case "CCEPF300": GenerarReporterptViewEmitirDescansoMedico_FE(Visor);
                            break;
                        case "CCEP00F2": GenerarReporterptViewAlergia_FE(Visor);
                            break;
                        case "CCEPF015": GenerarReporterptViewValoracionFuncionalAM_FE(Visor);
                            break;
                        case "CCEPF152": GenerarReporterptViewProximaAtencion_FE(Visor);
                            break;
                        case "CCEPF013": GenerarReporterptViewInmunizacionAdulto_FE(Visor);
                            break;
                        case "CCEPF154": GenerarReporterptViewApoyoDiagnostico_FE(Visor);
                            break;
                        case "CCEPF202": GenerarReporterptViewReferencia_FE(Visor);
                            break;
                        case "CCEPF150": GenerarReporterptViewExamenApoyoDiagnostico_FE(Visor);
                            break;
                        case "CCEPF153": GenerarReporterptViewExamenClinico_FE(Visor);
                            break;
                        case "CCEPF510": GenerarReporterptViewOftalmologico_FE(Visor);
                            break;
                        case "CCEPF018": GenerarReporterptValoracionAM_FE(Visor);
                            break;
                        case "CCEPF016": GenerarReporteValoracionMentalAM_FE(Visor);
                            break;
                        case "CCEPF080": GenerarReporteEvolucuionMedica_FE(Visor);
                            break;
                        case "CCEPF101": GenerarReporteMedicamentos_Fe(Visor);
                            break;
                        case "CCEP9919": GenerarReporteMedicamentosGrupal_Fe(Visor);
                            break;
                        case "CCEPF151": GenerarReporteInterconsulta_FE(Visor);
                            break;
                        case "CCEPF017": GenerarReporteValoracionSocioFamAM_FE(Visor);
                            break;
                        case "CCEPF014": GenerarReporteAnamnesis_ANTFAM_FE(Visor);
                            break;
                        case "CCEPF203b": GenerarReporteContrarReferencia_FE(Visor);
                            break;
                        case "CCEPF301b": GenerarReporteSolicitudTransfusional_FE(Visor);
                            break;
                        case "CCEPF360": GenerarReporteSolicitudTransfusional2_FE(Visor);
                            break;
                        case "CCEPF100": GenerarReporteDieta_FE(Visor);
                            break;
                        case "CCEP9918": GenerarReporterptViewSolicitudProducto(Visor);
                            break;
                        case "CCEP9923": GenerarReporterptViewSolicitudDespacho(Visor);
                            break;
                        case "CCEP00F3": GenerarReporterptViewAntecedentesPersonalesFisiologico(Visor);
                            break;
                        case "CCEPF004": GenerarReporteAntFisiologicoPediatrico_FE(Visor);
                            break;
                        case "CCEPF005": GenerarReporterptViewAntecedentePersGinecObstetrico(Visor);
                            break;
                        case "CCEPF006": GenerarReporteAntecedentesGeneralesPatologicos_FE(Visor);
                            break;
                        // Nuevos Formulario
                        case "CCEPF461": GenerarReporterptViewSeguridadCirugiaEntrada_FE(Visor);
                            break;
                        case "CCEPF463": GenerarReporterptViewSeguridadCirugiaSalida_FE(Visor);
                            break;
                        case "CCEPF462": GenerarReporterptViewSeguridadCirugiaPausa_FE(Visor);
                            break;
                        case "CCEPF464": GenerarReporterptViewEscalaAltaCirugiaAmbulatoria_FE(Visor);
                            break;
                        case "CCEPF444": GenerarReporterptViewEscalaAldrete_FE(Visor);
                            break;
                        case "CCEPF435": GenerarReporterptViewGradoDependencia_FE(Visor);
                            break;
                        case "CCEPF448": GenerarReporterptViewEscalaSedacionRass_FE(Visor);
                            break;
                        case "CCEPF449": GenerarReporterptViewEscalaWoodDownes_FE(Visor);
                            break;
                        case "CCEPF440": GenerarReporterptViewEscalaGlasgow_FE(Visor);
                            break;
                        case "CCEPF441": GenerarReporterptViewEscalaGlasgowPreEscolar_FE(Visor);
                            break;
                        case "CCEPF442": GenerarReporterptViewEscalaGlasgowLactante_FE(Visor);
                            break;
                        case "CCEPF443": GenerarReporterptViewEscalaNorton_FE(Visor);
                            break;
                        case "CCEPF445": GenerarReporterptViewEscalaStewart_FE(Visor);
                            break;
                        case "CCEPF447": GenerarReporterptViewEscalaRamsay_FE(Visor);
                            break;
                        case "CCEPF204": GenerarReporterptViewRetiroVoluntario2_FE(Visor);
                            break;
                        case "CCEPF446": GenerarReporterptViewEscalaBromage_FE(Visor);
                            break;
                        case "CCEPF431": GenerarReporterptViewDolorEvaAdulto_FE(Visor);
                            break;
                        case "CCEPF432": GenerarReporterptViewDolorEvaNinios_FE(Visor);
                            break;
                        case "CCEPF051": GenerarReporterptViewFuncionesVitales_FE(Visor);
                            break;
                        case "CCEPF001": GenerarReporterptViewEnfermedadActual_FE(Visor);
                            break;
                        case "CCEPF328": GenerarReporterptViewNotaEnfermera_FE(Visor);
                            break;
                        case "CCEPF103": GenerarReporterptViewIndicaNoFarmacolog_FE(Visor);
                            break;
                        case "CCEPF501": GenerarReporteEvolucionObstetricaPuerperio_FE(Visor);
                            break;
                        case "CCEPF425": GenerarReporteVigilanciaDispositivos_FE(Visor);
                            break;
                        case "CCEPF200": GenerarReporteInformeAlta_FE(Visor);
                            break;
                        case "CCEPF201": GenerarReporteInformeAlta2_FE(Visor);
                            break;
                        case "CCEPF327": GenerarReporteOrdenIntervencionQuirurgica_FE(Visor);
                            break;
                        case "CCEPF323_1": GenerarReporteFichaAnestesia_1_FE(Visor);
                            break;
                        case "CCEPF323_3": GenerarReporteFichaAnestesia_3_FE(Visor);
                            break;
                        case "CCEPF402": GenerarReporteBalanceHidroElectrolitico_FE(Visor, 1); //EN NEO
                            break;
                        case "CCEPF401": GenerarReporteBalanceHidroElectrolitico_FE(Visor, 2);  //EN SOP
                            break;
                        case "CCEPF403": GenerarReporteBalanceHidroElectrolitico_FE(Visor, 3);  //PEDIATRICO
                            break;
                        case "CCEPF400": GenerarReporteBalanceHidroElectrolitico_FE(Visor, 4);  //NORMAL
                            break;
                        case "CCEPF460_1": GenerarReporterptViewPreOperatorio1(Visor);  //NORMAL
                            break;
                        case "CCEPF460_2": GenerarReporterptViewPreOperatorio2(Visor);  //NORMAL
                            break;
                        case "CCEPF403_3": GenerarReporterptViewKardex3(Visor);  //NORMAL
                            break;
                        case "CCEPF323_2": GenerarReporteFichadeAnestesia2(Visor);  //NORMAL  
                            break;
                        case "CCEPF323_5": GenerarReporteFichadeAnestesia5(Visor);  //NORMAL
                            break;
                        case "CCEPF201_1": GenerarReporteEpicrisis_1FE(Visor);
                            break;
                        case "CCEPF201_2": GenerarReporteEpicrisis2_Fe(Visor);
                            break;
                        case "CCEPF323_4": GenerarReporteAnestesia4_Fe(Visor);
                            break;
                        case "CCEPF201_3": GenerarReporterptViewEpicrisis3(Visor);  //NORMAL
                            break;
                        case "CCEPF403_2": GenerarReporterptViewKardex2(Visor);  //NORMAL
                            break;
                        case "CCEPF403_1": GenerarReporterptViewKardex1(Visor);
                            break;
                        case "CCEPF302": GenerarReporterptViewHojaRecienNacido(Visor);
                            break;
                        case "CCEPF404": GenerarReporterptViewPartograma(Visor);
                            break;
                        case "CCEPF505": GenerarReporterptViewResumenParto(Visor);
                            break;
                        case "CCEPF505_2": GenerarReporterptViewResumenParto2_FE(Visor);
                            break;
                        case "CCEPF505_3": GenerarReporterptViewResumenParto3_FE(Visor);
                            break;
                        case "CCEPF319": GenerarReporterptViewNota_Ingreso_FE(Visor);
                            break;
                        case "CCEPF502": GenerarReporterptViewTocolosisInduccionAcentuacion_FE(Visor);
                            break;
                        case "CCEPF420": GenerarReporterptViewVigilanciaCateterUrinario_FE(Visor);
                            break;
                        case "CCEPF424": GenerarReporterptViewVigilanciaVentilacionMecanica_FE(Visor);
                            break;
                        case "CCEPF430": GenerarReporterptViewEvaluacionDolorEvaNeonatosPrematuros_FE(Visor);
                            break;
                        case "CCEPF422": GenerarReporterptViewVigilanciaCateterPeriferico_FE(Visor);
                            break;
                        case "CCEPF631": GenerarReporterptViewTriajeEmergencia_FE(Visor);
                            break;
                        case "CCEPF630": GenerarReporterptViewTriajeAlergias_FE(Visor);
                            break;
                        case "CCEPF305": GenerarReporterptViewEpidemiologiaCovid_FE(Visor);
                            break;

                        // ***  FIN FORMULARIOS (EXTRAS) ***

                    }

                    Rpt.DataSourceConnections.Clear();
                    System.Web.HttpContext.Current.Response.Buffer = false;
                    System.Web.HttpContext.Current.Response.ClearContent();
                    System.Web.HttpContext.Current.Response.ClearHeaders();

                    //Rpt.ExportToStream(ExportFormatType.PortableDocFormat);
                    Response.ContentType = "application/pdf";

                    var rutac = "C:/PDF/";
                    if (!Directory.Exists(rutac))
                    {
                        DirectoryInfo di = Directory.CreateDirectory(rutac);
                    }

                    Rpt.ExportToDisk(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, "C:/PDF/Reporte.pdf");

                    var Ruta = "C:/PDF/Reporte.pdf";
                    System.IO.FileInfo fi = new System.IO.FileInfo(Ruta);

                    var NombreServidor = fi.Name;
                    var rutaServidor = Server.MapPath("../resources/DocumentosAdjuntos/");
                    if (!Directory.Exists(rutaServidor))
                    {
                        DirectoryInfo di = Directory.CreateDirectory(rutaServidor);
                    }
                    var PathServidor = rutaServidor + NombreServidor;
                    System.IO.File.Copy(Ruta, PathServidor, true);
                    var PathOri = "../resources/DocumentosAdjuntos/" + NombreServidor;
                    Rpt.Close();
                    Rpt.Dispose();
                    Response.Redirect(PathOri);
                    Response.End();

                }

            }
            catch (Exception ex)
            {

                LOGgineco(this, ex);
            }

        }
        protected void Page_Unload(object sender, EventArgs e)
        {
            //  ((AllJobsSummaryReportLayout)ViewData["ReportData"]).Close();
            //  ((AllJobsSummaryReportLayout)ViewData["ReportData"]).Dispose();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            // if (!Page.IsPostBack)
            //  {


            // }
        }
        private void GenerarReporteReceta(String tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteReceta - Entrar");
            if (Request.QueryString["ReportID"] != null)
            {
                // Agregados
                string reportID = Request.QueryString["ReportID"].ToString();
                string Visor = Request.QueryString["Visor"].ToString();

                //CCEP0102    

                switch (reportID)
                {
                    case "CCEP0003": GenerarReporterptViewAnamnesisEA(Visor);
                        break;
                    case "CCEP0005": GenerarReporterptViewAnamnesisAF(Visor);
                        break;
                    case "CCEP0102": GenerarReporterptViewExamenTriajeFisico(Visor);
                        break;
                    case "CCEP0104": GenerarReporterptViewExamenFisicoRegional(Visor);
                        break;
                    case "CCEP0253": GenerarReporterptViewDiagnostico(Visor);
                        break;
                    case "CCEP2010": GenerarReporterptViewEvolucionObjetiva(Visor);
                        break;
                    case "CCEP0306": GenerarReporterptViewExamenSolicitado(Visor);
                        break;

                    case "CCEP0311": GenerarReporterptViewEmitirDescansoMedico(Visor);
                        break;

                    case "CCEP0314": GenerarReporterptViewSolicitarReferencia(Visor);
                        break;

                    case "ReportExamenes": GenerarReporteReceta("");
                        break;

                }
            }

        }
        /**************/


        private void GenerarReporterptViewAnamnesisEA(String tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewAnamnesisEA - Entrar");

            String nombreRpt = "Enfermedad_Actual";
            string tura = Server.MapPath("rptReports/rptViewAnamnesisEA.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewAnamnesisEA.rpt"));
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisEAEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisEAEdit>();
            listaRPT = getDatarptViewAnamnesisEA("REPORTEA");
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, nombreRpt);
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }

            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }

        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisEAEdit>

        getDatarptViewAnamnesisEA(String accion)
        {
            Log.Information("VisorReportesHCE - getDatarptViewAnamnesisEA - Entrar");

            List<rptViewAnamnesisEA> rptViewListaDB = new List<rptViewAnamnesisEA>();
            SS_HC_Anamnesis_EA objRptFiltro = new SS_HC_Anamnesis_EA();
            objRptFiltro.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            objRptFiltro.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            objRptFiltro.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            objRptFiltro.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            objRptFiltro.Accion = "REPORTEA";
            rptViewListaDB = ServiceReportes.ReporteAnamnesisEA(objRptFiltro, 0, 0);

            objTabla1 = new System.Data.DataTable();
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisEAEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisEAEdit>();
            SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisEAEdit objRPT;
            if (rptViewListaDB != null)
            {
                if (rptViewListaDB.Count > 0)
                {
                    ///////////////////////////////                    
                    //PARA LA AUDITORIA DE IMPRESION                    
                    setDataImpresionAuditoria(accion, 0, null, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
                    ///////////////////////////////            
                }

                foreach (rptViewAnamnesisEA objReport in rptViewListaDB) // Loop through List with foreach.
                {
                    objRPT = getObjetoReporteAnamnesisEA(objReport);
                    //objRPT.NombreCompleto = objReport.NombreCompleto;
                    //objRPT.Accion = "~/resources/images/logohce.png";
                    listaRPT.Add(objRPT);
                }
            }
            return listaRPT;
        }

        private void GenerarReporterptViewAnamnesisAF(String tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewAnamnesisAF - Entrar");
            string tura = Server.MapPath("rptReports/rptViewAnamnesisAF.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewAnamnesisAF.rpt"));
            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisAFEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisAFEdit>();
            //listaRPT = getDatarptViewAnamnesisAF("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            //dsRptViewer.Tables.Add(objTabla1.Copy());
            //dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewAnamnesisAF", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {

                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "ANAMNESISAF");
                    }
                    catch (Exception ex)
                    {
                        throw;
                    }
                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            //Rpt.SetParameterValue("imgDerecha", imgDerecha);
        }

        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisAFEdit>

        getDatarptViewAnamnesisAF(
            String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
            , SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog,
            string codFormato, string codUsuario
            )
        {
            Log.Information("VisorReportesHCE - getDatarptViewAnamnesisAF - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisAFEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisAFEdit>();

            List<rptViewAnamnesisAF> rptViewAnamnesisAF = new List<rptViewAnamnesisAF>();
            SS_HC_Anamnesis_AF objAnamnesisAF = new SS_HC_Anamnesis_AF();
            objAnamnesisAF.UnidadReplicacion = unidadReplicacion;
            objAnamnesisAF.IdPaciente = idPaciente;
            objAnamnesisAF.EpisodioClinico = epiClinico;
            objAnamnesisAF.IdEpisodioAtencion = idEpiAtencion;
            objAnamnesisAF.Accion = "REPORTEA";
            rptViewAnamnesisAF = ServiceReportes.ReporteAnamnesisAF(objAnamnesisAF, 0, 0);

            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisAFEdit objRPT;
            if (rptViewAnamnesisAF != null)
            {
                foreach (rptViewAnamnesisAF objReport in rptViewAnamnesisAF) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisAFEdit();

                    objRPT.Expr103 = objReport.Expr103;
                    objRPT.Expr101 = objReport.Expr101;
                    objRPT.Expr3 = objReport.Expr3;

                    objRPT.Descripcion = objReport.Descripcion;
                    objRPT.Observaciones = objReport.Observaciones;


                    //GENERALES
                    objRPT.NombreCompleto = objReport.NombreCompleto;
                    objRPT.Sexo = objReport.Sexo;
                    if (objReport.Edad != null)
                    {
                        objRPT.Edad = Convert.ToInt32(objReport.Edad);
                    }
                    objRPT.TipoTrabajadorDesc = objReport.TipoTrabajadorDesc;
                    objRPT.CodigoOA = objReport.CodigoOA;
                    objRPT.UnidadServicioDesc = objReport.UnidadServicioDesc;
                    objRPT.Expr104 = objReport.Expr104;
                    listaRPT.Add(objRPT);
                }

                ///////////////////////////////                    
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewAnamnesisAF.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }
            return listaRPT;
        }

        private void GenerarReporterptViewExamenTriajeFisico(String tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewExamenTriajeFisico - Entrar");
            string tura = Server.MapPath("rptReports/rptViewExamenTriajeFisico.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewExamenTriajeFisico.rpt"));

            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewExamenTriajeFisico", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenTriajeFisicoEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenTriajeFisicoEdit>();
            //listaRPT = getDatarptViewExamenTriajeFisico("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //DataSet obj = new DataSet();
            //dsRptViewer.Tables.Add(objTabla1.Copy());
            //dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "TRIAJE");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }

            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            //Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            //Rpt.SetParameterValue("imgDerecha", imgDerecha);
        }


        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenTriajeFisicoEdit>

        getDatarptViewExamenTriajeFisico(
            String tipoVista, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
            , SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog,
            string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewExamenTriajeFisico - Entrar");
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenTriajeFisicoEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenTriajeFisicoEdit>();

            List<rptViewExamenTriajeFisico> rptViewExamenTriajeFisico = new List<rptViewExamenTriajeFisico>();
            SS_HC_ExamenFisico_Triaje objExamenTriajeFisico = new SS_HC_ExamenFisico_Triaje();
            objExamenTriajeFisico.UnidadReplicacion = unidadReplicacion;
            objExamenTriajeFisico.IdPaciente = idPaciente;
            objExamenTriajeFisico.EpisodioClinico = epiClinico;
            objExamenTriajeFisico.IdEpisodioAtencion = idEpiAtencion;
            objExamenTriajeFisico.Accion = "REPORTEA";
            rptViewExamenTriajeFisico = ServiceReportes.ReporteExamenFisico_Triaje(objExamenTriajeFisico, 0, 0);

            objTabla1 = new System.Data.DataTable();
            SoluccionSalud.RepositoryReport.Entidades.rptViewExamenTriajeFisicoEdit objRPT;
            if (rptViewExamenTriajeFisico != null)
            {
                foreach (rptViewExamenTriajeFisico objReport in rptViewExamenTriajeFisico) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewExamenTriajeFisicoEdit();

                    if (objReport.PresionMinima != null)
                    {
                        objRPT.PresionMinima = Convert.ToInt32(objReport.PresionMinima);
                    }


                    if (objReport.PresionMaxima != null)
                    {
                        objRPT.PresionMaxima = Convert.ToInt32(objReport.PresionMaxima);
                    }



                    if (objReport.FrecuenciaRespiratoria != null)
                    {
                        objRPT.FrecuenciaRespiratoria = Convert.ToInt32(objReport.FrecuenciaRespiratoria);
                    }

                    if (objReport.FrecuenciaCardiaca != null)
                    {
                        objRPT.FrecuenciaCardiaca = Convert.ToInt32(objReport.FrecuenciaCardiaca);
                    }

                    if (objReport.Temperatura != null)
                    {
                        objRPT.Temperatura = Convert.ToDecimal(objReport.Temperatura);
                    }

                    if (objReport.Peso != null)
                    {
                        objRPT.Peso = Convert.ToDecimal(objReport.Peso);
                    }

                    if (objReport.Talla != null)
                    {
                        objRPT.Talla = Convert.ToDecimal(objReport.Talla);
                    }

                    if (objReport.IndiceMasaCorporal != null)
                    {
                        objRPT.IndiceMasaCorporal = Convert.ToDecimal(objReport.IndiceMasaCorporal);
                    }


                    objRPT.Expr02 = objReport.Expr02;
                    objRPT.Expr01 = objReport.Expr01;
                    objRPT.Expr03 = objReport.Expr03;
                    objRPT.Expr04 = objReport.Expr04;
                    objRPT.Expr102 = objReport.Expr102;

                    objRPT.NombreCompleto = objReport.NombreCompleto;
                    objRPT.Sexo = objReport.Sexo;
                    if (objReport.PersonaEdad != null)
                    {
                        objRPT.PersonaEdad = Convert.ToInt32(objReport.PersonaEdad);
                    }
                    objRPT.TipoAtencionDesc = objReport.TipoAtencionDesc;
                    objRPT.CodigoOA = objReport.CodigoOA;
                    objRPT.UnidadServicioDesc = objReport.UnidadServicioDesc;

                    objRPT.Expr104 = objReport.Expr104;

                    listaRPT.Add(objRPT);
                }
                ///////////////////////////////                    
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewExamenTriajeFisico.Count > 0)
                {
                    setDataImpresionAuditoria(tipoVista, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }

            return listaRPT;
        }

        private void GenerarReporterptViewExamenFisicoRegional(String tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewExamenFisicoRegional - Entrar");
            string tura = Server.MapPath("rptReports/rptViewExamenFisicoRegional.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewExamenFisicoRegional.rpt"));

            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewExamenFisicoRegional", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenFisicoRegionalEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenFisicoRegionalEdit>();
            //listaRPT = getDatarptViewExamenFisicoRegional("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //DataSet obj = new DataSet();
            //dsRptViewer.Tables.Add(objTabla1.Copy());
            //dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "REGIONAL");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }

            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            //Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            //Rpt.SetParameterValue("imgDerecha", imgDerecha);
        }

        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenFisicoRegionalEdit>
        getDatarptViewExamenFisicoRegional(
            String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
            , SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog,
            string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewExamenFisicoRegional - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenFisicoRegionalEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenFisicoRegionalEdit>();

            List<rptViewExamenFisicoRegional> rptViewExamenFisicoRegional = new List<rptViewExamenFisicoRegional>();
            SS_HC_ExamenFisico_Regional objExamenFisicoRegional = new SS_HC_ExamenFisico_Regional();
            objExamenFisicoRegional.UnidadReplicacion = unidadReplicacion;
            objExamenFisicoRegional.IdPaciente = idPaciente;
            objExamenFisicoRegional.EpisodioClinico = epiClinico;
            objExamenFisicoRegional.IdEpisodioAtencion = idEpiAtencion;
            objExamenFisicoRegional.Accion = "REPORTEA";
            rptViewExamenFisicoRegional = ServiceReportes.ReporteExamenFisicoRegional(objExamenFisicoRegional, 0, 0);

            objTabla1 = new System.Data.DataTable();
            SoluccionSalud.RepositoryReport.Entidades.rptViewExamenFisicoRegionalEdit objRPT;
            if (rptViewExamenFisicoRegional != null)
            {
                foreach (rptViewExamenFisicoRegional objReport in rptViewExamenFisicoRegional) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewExamenFisicoRegionalEdit();
                    objRPT.CuerpoHumanoDesc = objReport.CuerpoHumanoDesc;
                    objRPT.Comentarios = objReport.Comentarios;

                    objRPT.NombreCompleto = objReport.NombreCompleto;
                    objRPT.Sexo = objReport.Sexo;
                    if (objReport.PersonaEdad != null)
                    {
                        objRPT.PersonaEdad = Convert.ToInt32(objReport.PersonaEdad);
                    }
                    objRPT.TipoAtencionDesc = objReport.TipoAtencionDesc;
                    objRPT.CodigoOA = objReport.CodigoOA;
                    objRPT.UnidadServicioDesc = objReport.UnidadServicioDesc;
                    objRPT.Expr104 = objReport.Expr104;

                    listaRPT.Add(objRPT);


                }

                ///////////////////////////////                    
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewExamenFisicoRegional.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }
            return listaRPT;
        }


        private void GenerarReporterptViewEvolucionObjetiva(String tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewEvolucionObjetiva - Entrar");
            string tura = Server.MapPath("rptReports/rptViewEvolucionObjetiva.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewEvolucionObjetiva.rpt"));

            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewEvolucionObjetiva", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewEvolucionObjetivaEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewEvolucionObjetivaEdit>();
            //listaRPT = getDatarptViewEvolucionObjetiva("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //DataSet obj = new DataSet();
            //dsRptViewer.Tables.Add(objTabla1.Copy());
            //dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "EVOLUCION");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }

        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewEvolucionObjetivaEdit>

        getDatarptViewEvolucionObjetiva(
            String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
            , SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog,
            string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewEvolucionObjetiva - Entrar");
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewEvolucionObjetivaEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewEvolucionObjetivaEdit>();

            List<rptViewEvolucionObjetiva> rptViewEvolucionObjetiva = new List<rptViewEvolucionObjetiva>();
            SS_HC_EvolucionObjetiva objEvolucionObjetiva = new SS_HC_EvolucionObjetiva();
            objEvolucionObjetiva.UnidadReplicacion = unidadReplicacion;
            objEvolucionObjetiva.IdPaciente = idPaciente;
            objEvolucionObjetiva.EpisodioClinico = epiClinico;
            objEvolucionObjetiva.IdEpisodioAtencion = idEpiAtencion;
            objEvolucionObjetiva.Accion = "REPORTEA";
            rptViewEvolucionObjetiva = ServiceReportes.ReporteEvolucionObjetiva(objEvolucionObjetiva, 0, 0);

            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewEvolucionObjetivaEdit objRPT;
            if (rptViewEvolucionObjetiva != null)
            {
                foreach (rptViewEvolucionObjetiva objReport in rptViewEvolucionObjetiva) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewEvolucionObjetivaEdit();

                    objRPT.FechaIngreso = Convert.ToDateTime(objReport.FechaIngreso);

                    objRPT.FechaAtencion = Convert.ToDateTime(objReport.FechaAtencion);

                    objRPT.EvolucionObjetiva = objReport.EvolucionObjetiva;

                    objRPT.Expr104 = objReport.Expr104;

                    objRPT.NombreCompleto = objReport.NombreCompleto;
                    objRPT.Sexo = objReport.Sexo;
                    if (objReport.PersonaEdad != null)
                    {
                        objRPT.PersonaEdad = Convert.ToInt32(objReport.PersonaEdad);
                    }
                    objRPT.TipoAtencionDesc = objReport.TipoAtencionDesc;
                    objRPT.CodigoOA = objReport.CodigoOA;
                    objRPT.UnidadServicioDesc = objReport.UnidadServicioDesc;
                    listaRPT.Add(objRPT);
                }
                ///////////////////////////////                    
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewEvolucionObjetiva.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }

            return listaRPT;

        }

        private void GenerarReporterptViewEmitirDescansoMedico(String tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewEmitirDescansoMedico - Entrar");
            string tura = Server.MapPath("rptReports/rptViewEmitirDescansoMedico.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewEmitirDescansoMedico.rpt"));

            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewEmitirDescansoMedico", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewEmitirDescansoMedicoEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewEmitirDescansoMedicoEdit>();
            //listaRPT = getDatarptViewEmitirDescansoMedico("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //DataSet obj = new DataSet();
            //dsRptViewer.Tables.Add(objTabla1.Copy());
            //dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }

            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }


        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewEmitirDescansoMedicoEdit> getDatarptViewEmitirDescansoMedico(
            String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion, SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog, string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewEmitirDescansoMedico - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewEmitirDescansoMedicoEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewEmitirDescansoMedicoEdit>();

            List<rptViewEmitirDescansoMedico> rptViewEmitirDescansoMedico = new List<rptViewEmitirDescansoMedico>();
            SS_HC_DescansoMedico objEmitirDescansoMedico = new SS_HC_DescansoMedico();
            objEmitirDescansoMedico.UnidadReplicacion = unidadReplicacion;
            objEmitirDescansoMedico.IdPaciente = idPaciente;
            objEmitirDescansoMedico.EpisodioClinico = epiClinico;
            objEmitirDescansoMedico.IdEpisodioAtencion = idEpiAtencion;
            objEmitirDescansoMedico.Accion = "REPORTEA";
            rptViewEmitirDescansoMedico = ServiceReportes.ReporteEmitirDescansoMedico(objEmitirDescansoMedico, 0, 0);

            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewEmitirDescansoMedicoEdit objRPT;
            if (rptViewEmitirDescansoMedico != null)
            {
                foreach (rptViewEmitirDescansoMedico objReport in rptViewEmitirDescansoMedico) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewEmitirDescansoMedicoEdit();

                    objRPT.Observacion = objReport.Observacion;

                    objRPT.FechaInicioDescanso = Convert.ToDateTime(objReport.FechaInicioDescanso);

                    objRPT.FechaFinDescanso = Convert.ToDateTime(objReport.FechaFinDescanso);

                    objRPT.Dias = Convert.ToInt32(objReport.Dias);

                    objRPT.Expr104 = objReport.Expr104;

                    objRPT.NombreCompleto = objReport.NombreCompleto;
                    objRPT.Sexo = objReport.Sexo;
                    if (objReport.PersonaEdad != null)
                    {
                        objRPT.PersonaEdad = Convert.ToInt32(objReport.PersonaEdad);
                    }
                    objRPT.TipoAtencionDesc = objReport.TipoAtencionDesc;
                    objRPT.CodigoOA = objReport.CodigoOA;
                    objRPT.UnidadServicioDesc = objReport.UnidadServicioDesc;
                    listaRPT.Add(objRPT);
                }
                ///////////////////////////////                    
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewEmitirDescansoMedico.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }
            return listaRPT;
        }

        private void GenerarReporterptViewProximaAtencion(String tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewProximaAtencion - Entrar");
            string tura = Server.MapPath("rptReports/rptViewProximaAtencion.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewProximaAtencion.rpt"));

            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewProximaAtencion", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewProximaAtencionEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewProximaAtencionEdit>();
            //listaRPT = getDatarptViewProximaAtencion("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //DataSet obj = new DataSet();
            //dsRptViewer.Tables.Add(objTabla1.Copy());
            //dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "PROXIMACITA");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }

        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewProximaAtencionEdit>

        getDatarptViewProximaAtencion(
            String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
            , SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog,
            string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewProximaAtencion - Entrar");
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewProximaAtencionEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewProximaAtencionEdit>();

            List<rptViewProximaAtencion> rptViewProximaAtencion = new List<rptViewProximaAtencion>();
            SS_HC_ProximaAtencion objProximaAtencion = new SS_HC_ProximaAtencion();
            objProximaAtencion.UnidadReplicacion = unidadReplicacion;
            objProximaAtencion.IdPaciente = idPaciente;
            objProximaAtencion.EpisodioClinico = epiClinico;
            objProximaAtencion.IdEpisodioAtencion = idEpiAtencion;
            objProximaAtencion.Accion = "REPORTEA";
            rptViewProximaAtencion = ServiceReportes.ReporteProximaAtencion(objProximaAtencion, 0, 0);

            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewProximaAtencionEdit objRPT;
            if (rptViewProximaAtencion != null)
            {
                foreach (rptViewProximaAtencion objReport in rptViewProximaAtencion) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewProximaAtencionEdit();



                    objRPT.FechaSolicitada = Convert.ToDateTime(objReport.FechaSolicitada);
                    objRPT.EspecialidadDesc = objReport.EspecialidadDesc;
                    objRPT.IdPersonalSalud = Convert.ToInt32(objReport.IdPersonalSalud);
                    objRPT.Observacion = objReport.Observacion;
                    objRPT.CMP = objReport.CMP;
                    objRPT.PersMedicoNombreCompleto = objReport.PersMedicoNombreCompleto;
                    objRPT.TipoTrabajadorDesc = objReport.TipoTrabajadorDesc;

                    objRPT.Expr104 = objReport.Expr104;

                    objRPT.NombreCompleto = objReport.NombreCompleto;
                    objRPT.Sexo = objReport.Sexo;
                    if (objReport.PersonaEdad != null)
                    {
                        objRPT.PersonaEdad = Convert.ToInt32(objReport.PersonaEdad);
                    }
                    objRPT.TipoAtencionDesc = objReport.TipoAtencionDesc;
                    objRPT.CodigoOA = objReport.CodigoOA;
                    objRPT.UnidadServicioDesc = objReport.UnidadServicioDesc;
                    listaRPT.Add(objRPT);
                }
                ///////////////////////////////                    
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewProximaAtencion.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }
            return listaRPT;
        }

        private void GenerarReporterptViewCuidadosPreventivos(String tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewCuidadosPreventivos - Entrar");
            string tura = Server.MapPath("rptReports/rptViewCuidadosPreventivos.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewCuidadosPreventivos.rpt"));

            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewCuidadosPreventivos", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewCuidadosPreventivoEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewCuidadosPreventivoEdit>();
            //listaRPT = getDatarptViewCuidadosPreventivo("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //DataSet obj = new DataSet();
            //dsRptViewer.Tables.Add(objTabla1.Copy());
            //dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "CUIDADOPREVENTIVO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }

        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewCuidadosPreventivoEdit> getDatarptViewCuidadosPreventivo(
            String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
            , SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog, string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewCuidadosPreventivo - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewCuidadosPreventivoEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewCuidadosPreventivoEdit>();

            List<rptViewCuidadosPreventivo> rptViewCuidadosPreventivo = new List<rptViewCuidadosPreventivo>();
            SS_HC_SeguimientoRiesgo objCuidadosPreventivo = new SS_HC_SeguimientoRiesgo();
            objCuidadosPreventivo.UnidadReplicacion = unidadReplicacion;
            objCuidadosPreventivo.IdPaciente = idPaciente;
            objCuidadosPreventivo.EpisodioClinico = epiClinico;
            objCuidadosPreventivo.IdEpisodioAtencion = idEpiAtencion;
            objCuidadosPreventivo.Accion = "REPORTEA";
            rptViewCuidadosPreventivo = ServiceReportes.ReporteCuidadosPreventivo(objCuidadosPreventivo, 0, 0);

            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewCuidadosPreventivoEdit objRPT;
            if (rptViewCuidadosPreventivo != null)
            {
                foreach (rptViewCuidadosPreventivo objReport in rptViewCuidadosPreventivo) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewCuidadosPreventivoEdit();



                    objRPT.FechaAtencion = Convert.ToDateTime(objReport.FechaAtencion);
                    objRPT.FechaSeguimiento = Convert.ToDateTime(objReport.FechaSeguimiento);
                    objRPT.EspecialidadDesc = objReport.EspecialidadDesc;
                    objRPT.IdPersonalSalud = Convert.ToInt32(objReport.IdPersonalSalud);
                    objRPT.Descripcion = objReport.Descripcion;
                    objRPT.Nombre = objReport.Nombre;
                    objRPT.Comentario = objReport.Comentario;
                    objRPT.Nombre = objReport.Nombre;
                    objRPT.PersMedicoNombreCompleto = objReport.PersMedicoNombreCompleto;
                    objRPT.TipoTrabajadorDesc = objReport.TipoTrabajadorDesc;
                    objRPT.IdCuidadoPreventivo = Convert.ToInt32(objReport.IdCuidadoPreventivo);
                    objRPT.Expr104 = objReport.Expr104;
                    objRPT.Secuencia = objReport.Secuencia;
                    objRPT.NombreCompleto = objReport.NombreCompleto;
                    objRPT.Sexo = objReport.Sexo;
                    if (objReport.PersonaEdad != null)
                    {
                        objRPT.PersonaEdad = Convert.ToInt32(objReport.PersonaEdad);
                    }
                    objRPT.TipoAtencionDesc = objReport.TipoAtencionDesc;
                    objRPT.CodigoOA = objReport.CodigoOA;

                    objRPT.UnidadServicioDesc = objReport.UnidadServicioDesc;

                    listaRPT.Add(objRPT);
                }
                ///////////////////////////////                    
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewCuidadosPreventivo.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }

            return listaRPT;


        }

        private void GenerarReporterptViewSolicitarReferencia(String tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewSolicitarReferencia - Entrar");

            string tura = Server.MapPath("rptReports/rptViewSolicitarReferencia.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewSolicitarReferencia.rpt"));

            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewSolicitarReferencias", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewSolicitarReferenciaEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewSolicitarReferenciaEdit>();
            //listaRPT = getDatarptViewSolicitarReferencia("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //DataSet obj = new DataSet();
            //dsRptViewer.Tables.Add(objTabla1.Copy());
            //dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "REFERENCIA");
                    }
                    catch (Exception ex)
                    {
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }

            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            //Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            //Rpt.SetParameterValue("imgDerecha", imgDerecha);
        }


        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewSolicitarReferenciaEdit>

        getDatarptViewSolicitarReferencia(
            String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
            , SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog,
            string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewSolicitarReferencia - Entrar");


            List<SoluccionSalud.RepositoryReport.Entidades.rptViewSolicitarReferenciaEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewSolicitarReferenciaEdit>();

            List<rptViewSolicitarReferencia> rptViewSolicitarReferencia = new List<rptViewSolicitarReferencia>();
            SS_HC_ProximaAtencion objSolicitarReferencia = new SS_HC_ProximaAtencion();
            objSolicitarReferencia.UnidadReplicacion = unidadReplicacion;
            objSolicitarReferencia.IdPaciente = idPaciente;
            objSolicitarReferencia.EpisodioClinico = epiClinico;
            objSolicitarReferencia.IdEpisodioAtencion = idEpiAtencion;
            objSolicitarReferencia.Accion = "REPORTEA";
            rptViewSolicitarReferencia = ServiceReportes.ReporteSolicitarReferencia(objSolicitarReferencia, 0, 0);

            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewSolicitarReferenciaEdit objRPT;
            if (rptViewSolicitarReferencia != null)
            {
                foreach (rptViewSolicitarReferencia objReport in rptViewSolicitarReferencia) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewSolicitarReferenciaEdit();



                    objRPT.FechaSolicitada = Convert.ToDateTime(objReport.FechaSolicitada);
                    objRPT.EspecialidadDesc = objReport.EspecialidadDesc;
                    //  objRPT.IdPersonalSalud = Convert.ToInt32(objReport.IdPersonalSalud);
                    objRPT.Observacion = objReport.Observacion;
                    objRPT.EstablecimientoDesc = objReport.EstablecimientoDesc;
                    objRPT.PersMedicoNombreCompleto = objReport.PersMedicoNombreCompleto;
                    objRPT.TipoTrabajadorDesc = objReport.TipoTrabajadorDesc;

                    objRPT.Expr104 = objReport.Expr104;

                    objRPT.NombreCompleto = objReport.NombreCompleto;
                    objRPT.Sexo = objReport.Sexo;
                    if (objReport.PersonaEdad != null)
                    {
                        objRPT.PersonaEdad = Convert.ToInt32(objReport.PersonaEdad);
                    }
                    objRPT.TipoAtencionDesc = objReport.TipoAtencionDesc;
                    objRPT.CodigoOA = objReport.CodigoOA;
                    objRPT.UnidadServicioDesc = objReport.UnidadServicioDesc;
                    listaRPT.Add(objRPT);
                }
                ///////////////////////////////                    
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewSolicitarReferencia.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }

            return listaRPT;


        }



        private void GenerarReporterptViewDiagnostico(String tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewDiagnostico - Entrar");

            string tura = Server.MapPath("rptReports/rptViewDiagnostico.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewDiagnostico.rpt"));
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewDiagnosticoEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewDiagnosticoEdit>();
            listaRPT = getDatarptViewDiagnostico("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {

                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DIAGNOSTICO");
                    }
                    catch (Exception ex)
                    {
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }


        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewDiagnosticoEdit> getDatarptViewDiagnostico(String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
            , SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog, string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewDiagnostico - Entrar");
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewDiagnosticoEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewDiagnosticoEdit>();

            List<rptViewDiagnostico> rptViewDiagnostico = new List<rptViewDiagnostico>();
            SS_HC_Diagnostico objDiagnostico = new SS_HC_Diagnostico();
            objDiagnostico.UnidadReplicacion = unidadReplicacion;
            objDiagnostico.IdPaciente = idPaciente;
            objDiagnostico.EpisodioClinico = epiClinico;
            objDiagnostico.IdEpisodioAtencion = idEpiAtencion;
            objDiagnostico.Accion = "REPORTEA";
            rptViewDiagnostico = ServiceReportes.ReporteDiagnostico(objDiagnostico, 0, 0);

            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewDiagnosticoEdit objRPT;
            if (rptViewDiagnostico != null)
            {
                foreach (rptViewDiagnostico objReport in rptViewDiagnostico) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewDiagnosticoEdit();


                    objRPT.DiagnosticoDesc = objReport.DiagnosticoDesc;
                    objRPT.DeterminacionDiagnosticaDesc = objReport.DeterminacionDiagnosticaDesc;
                    objRPT.DiagnosticoPrincipalDesc = objReport.DiagnosticoPrincipalDesc;
                    objRPT.GradoAfeccion = objReport.GradoAfeccion;
                    objRPT.TipoAntecedenteDesc = objReport.TipoAntecedenteDesc;
                    objRPT.IndicadorPreExistenciaDesc = objReport.IndicadorPreExistenciaDesc;
                    objRPT.IndicadorCronicoDesc = objReport.IndicadorCronicoDesc;
                    objRPT.IndicadorNuevoDesc = objReport.IndicadorNuevoDesc;
                    objRPT.Observacion = objReport.Observacion;

                    //AUX
                    //objRPT.Expr101 = objReport.Expr101;
                    //GENERALES
                    objRPT.NombreCompleto = objReport.NombreCompleto;
                    objRPT.Sexo = objReport.Sexo;
                    if (objReport.PersonaEdad != null)
                    {
                        objRPT.PersonaEdad = Convert.ToInt32(objReport.PersonaEdad);
                    }
                    objRPT.TipoAtencionDesc = objReport.TipoAtencionDesc;
                    objRPT.CodigoOA = objReport.CodigoOA;
                    objRPT.UnidadServicioDesc = objReport.UnidadServicioDesc;

                    objRPT.Expr104 = objReport.Expr104;

                    listaRPT.Add(objRPT);
                }
                ///////////////////////////////                    
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewDiagnostico.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }
            return listaRPT;
        }

        private void GenerarReporterptViewExamenSolicitado(String tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewExamenSolicitado - Entrar");

            string tura = Server.MapPath("rptReports/rptViewExamenSolicitado.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewExamenSolicitado.rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewExamenSolicitado", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenSolicitadoEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenSolicitadoEdit>();
            //listaRPT = getDatarptViewExamenSolicitado("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //DataSet obj = new DataSet();
            //dsRptViewer.Tables.Add(objTabla1.Copy());
            //dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "EXAMEN");
                    }
                    catch (Exception ex)
                    {
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }

            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            //Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            //Rpt.SetParameterValue("imgDerecha", imgDerecha);
        }

        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenSolicitadoEdit>

        getDatarptViewExamenSolicitado(
            String tipoVista, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
            , SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog,
            string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewExamenSolicitado - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenSolicitadoEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenSolicitadoEdit>();

            List<rptViewExamenSolicitado> rptViewExamenSolicitado = new List<rptViewExamenSolicitado>();
            SS_HC_ExamenSolicitado objExamenSolicitado = new SS_HC_ExamenSolicitado();
            objExamenSolicitado.UnidadReplicacion = unidadReplicacion;
            objExamenSolicitado.IdPaciente = idPaciente;
            objExamenSolicitado.EpisodioClinico = epiClinico;
            objExamenSolicitado.IdEpisodioAtencion = idEpiAtencion;
            objExamenSolicitado.Accion = "REPORTEA";
            rptViewExamenSolicitado = ServiceReportes.ReporteExamenSolicitado(objExamenSolicitado, 0, 0);

            objTabla1 = new System.Data.DataTable();
            SoluccionSalud.RepositoryReport.Entidades.rptViewExamenSolicitadoEdit objRPT;
            if (rptViewExamenSolicitado != null)
            {
                foreach (rptViewExamenSolicitado objReport in rptViewExamenSolicitado) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewExamenSolicitadoEdit();

                    objRPT.ProcedimientoMedicoDesc = objReport.ProcedimientoMedicoDesc;

                    objRPT.FechaSolitada = Convert.ToDateTime(objReport.FechaSolitada);

                    objRPT.CodigoComponente = objReport.CodigoComponente;

                    objRPT.IdTipoExamen = Convert.ToInt32(objReport.IdTipoExamen);

                    objRPT.Cantidad = Convert.ToInt32(objReport.Cantidad);

                    objRPT.Observacion = objReport.Observacion;

                    objRPT.NombreCompleto = objReport.NombreCompleto;

                    objRPT.Sexo = objReport.Sexo;
                    if (objReport.PersonaEdad != null)
                    {
                        objRPT.PersonaEdad = Convert.ToInt32(objReport.PersonaEdad);
                    }
                    objRPT.TipoAtencionDesc = objReport.TipoAtencionDesc;

                    objRPT.CodigoOA = objReport.CodigoOA;

                    objRPT.UnidadServicioDesc = objReport.UnidadServicioDesc;

                    objRPT.Expr104 = objReport.Expr104;

                    listaRPT.Add(objRPT);
                }
                ///////////////////////////////                    
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewExamenSolicitado.Count > 0)
                {
                    setDataImpresionAuditoria(tipoVista, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }
            return listaRPT;
        }

        private void GenerarReporterptViewMedicamento(String tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewMedicamento - Entrar");

            string tura = Server.MapPath("rptReports/rptViewMedicamento.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewMedicamento.rpt"));

            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewMedicamentos", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentoEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentoEdit>();
            //listaRPT = getDatarptViewMedicamento("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //DataSet obj = new DataSet();
            //dsRptViewer.Tables.Add(objTabla1.Copy());
            //dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "MEDICAMENTOS");
                    }
                    catch (Exception ex)
                    {
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }

            }
            //Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            //Rpt.SetParameterValue("imgDerecha", imgDerecha);
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }

        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentoEdit>

        getDatarptViewMedicamento(
            String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
            , SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog,
            string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewMedicamento - Entrar");


            List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentoEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentoEdit>();

            List<rptViewMedicamento> rptViewMedicamento = new List<rptViewMedicamento>();
            SS_HC_Medicamento objMedicamento = new SS_HC_Medicamento();
            objMedicamento.UnidadReplicacion = unidadReplicacion;
            objMedicamento.IdPaciente = idPaciente;
            objMedicamento.EpisodioClinico = epiClinico;
            objMedicamento.IdEpisodioAtencion = idEpiAtencion;
            objMedicamento.Accion = "REPORTEA";
            rptViewMedicamento = ServiceReportes.ReporteMedicamento(objMedicamento, 0, 0);

            objTabla1 = new System.Data.DataTable();
            SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentoEdit objRPT;
            if (rptViewMedicamento != null)
            {
                foreach (rptViewMedicamento objReport in rptViewMedicamento) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentoEdit();

                    objRPT.GrupoMed = objReport.GrupoMed;
                    objRPT.MED_DCI = objReport.MED_DCI;
                    objRPT.UnidMedDesc = objReport.UnidMedDesc;
                    objRPT.Dosis = Convert.ToDecimal(objReport.Dosis);
                    objRPT.ViaDesc = objReport.ViaDesc;
                    objRPT.Cantidad = Convert.ToInt32(objReport.Cantidad);
                    objRPT.Frecuencia = Convert.ToInt32(objReport.Frecuencia);
                    objRPT.DiasTratamiento = Convert.ToInt32(objReport.DiasTratamiento);
                    objRPT.TipoRegistroMedDesc = objReport.TipoRegistroMedDesc;
                    objRPT.IndicadorRecetaDesc = objReport.IndicadorRecetaDesc;
                    objRPT.IndicacionesDesc = objReport.IndicacionesDesc;

                    objRPT.NombreCompleto = objReport.NombreCompleto;
                    objRPT.Sexo = objReport.Sexo;
                    if (objReport.PersonaEdad != null)
                    {
                        objRPT.PersonaEdad = Convert.ToInt32(objReport.PersonaEdad);
                    }
                    objRPT.TipoTrabajadorDesc = objReport.TipoTrabajadorDesc;
                    objRPT.CodigoOA = objReport.CodigoOA;
                    objRPT.UnidadServicioDesc = objReport.UnidadServicioDesc;
                    objRPT.Expr104 = objReport.Expr104;

                    listaRPT.Add(objRPT);
                }

                ///////////////////////////////                    
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewMedicamento.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                ///////////////////////////////  
            }
            return listaRPT;
        }

        private void GenerarReporterptViewcasoprueba(String tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewcasoprueba - Entrar");

            string tura = Server.MapPath("rptReports/rptViewcasoprueba.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewcasoprueba.rpt"));


            List<SoluccionSalud.RepositoryReport.Entidades.rptViewDiagnosticoEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewDiagnosticoEdit>();
            listaRPT = getDatarptViewcasoprueba("REPORTEA");

            //DataSet obj = new DataSet();
            //dsRptViewer.Tables.Add(objTabla1.Copy());
            //dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "PRUEBA");
                    }
                    catch (Exception ex)
                    {
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }

            }
            //Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            //Rpt.SetParameterValue("imgDerecha", imgDerecha);
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }

        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewDiagnosticoEdit>
        getDatarptViewcasoprueba(String accion)
        {
            Log.Information("VisorReportesHCE - getDatarptViewcasoprueba - Entrar");


            List<SoluccionSalud.RepositoryReport.Entidades.rptViewDiagnosticoEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewDiagnosticoEdit>();

            List<rptViewDiagnostico> rptViewDiagnostico = new List<rptViewDiagnostico>();
            SS_HC_Diagnostico objDiagnostico = new SS_HC_Diagnostico();
            objDiagnostico.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            objDiagnostico.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            objDiagnostico.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            objDiagnostico.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            objDiagnostico.Accion = "REPORTEA";
            rptViewDiagnostico = ServiceReportes.ReporteDiagnostico(objDiagnostico, 0, 0);

            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewDiagnosticoEdit objRPT;
            if (rptViewDiagnostico != null)
            {
                foreach (rptViewDiagnostico objReport in rptViewDiagnostico) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewDiagnosticoEdit();


                    objRPT.DiagnosticoDesc = objReport.DiagnosticoDesc;
                    objRPT.DeterminacionDiagnosticaDesc = objReport.DeterminacionDiagnosticaDesc;
                    objRPT.DiagnosticoPrincipalDesc = objReport.DiagnosticoPrincipalDesc;
                    objRPT.GradoAfeccion = objReport.GradoAfeccion;
                    objRPT.TipoAntecedenteDesc = objReport.TipoAntecedenteDesc;
                    objRPT.IndicadorPreExistenciaDesc = objReport.IndicadorPreExistenciaDesc;
                    objRPT.IndicadorCronicoDesc = objReport.IndicadorCronicoDesc;
                    objRPT.IndicadorNuevoDesc = objReport.IndicadorNuevoDesc;

                    //AUX
                    objRPT.Expr101 = objReport.Expr101;
                    //GENERALES
                    objRPT.NombreCompleto = objReport.NombreCompleto;
                    objRPT.Sexo = objReport.Sexo;
                    if (objReport.PersonaEdad != null)
                    {
                        objRPT.PersonaEdad = Convert.ToInt32(objReport.PersonaEdad);
                    }
                    objRPT.TipoAtencionDesc = objReport.TipoAtencionDesc;
                    objRPT.CodigoOA = objReport.CodigoOA;
                    objRPT.UnidadServicioDesc = objReport.UnidadServicioDesc;
                    //objRPT.PersMedicoNombreCompleto = objReport.PersMedicoNombreCompleto;

                    objRPT.Expr102 = objReport.Expr102;
                    listaRPT.Add(objRPT);
                }
            }
            return listaRPT;
        }

        private SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisEAEdit getObjetoReporteAnamnesisEA(rptViewAnamnesisEA objReport)
        {
            Log.Information("VisorReportesHCE - getObjetoReporteAnamnesisEA - Entrar");

            SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisEAEdit objRPT
                = new SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisEAEdit();


            objRPT.MotivoConsulta = objReport.MotivoConsulta;
            objRPT.Expr5 = objReport.Expr5;
            objRPT.Expr6 = objReport.Expr6;
            objRPT.TiempoEnfermedad = objReport.TiempoEnfermedad;
            objRPT.Descripcion = objReport.Descripcion;
            objRPT.RelatoCronologico = objReport.RelatoCronologico;
            objRPT.Exprapetito = objReport.Exprapetito;
            objRPT.Exprsed = objReport.Exprsed;
            objRPT.Exprorina = objReport.Exprorina;
            objRPT.Deposiciones = objReport.Deposiciones;
            objRPT.IdCIAP2 = Convert.ToInt32(objReport.IdCIAP2);
            objRPT.Sueno = objReport.Sueno;
            objRPT.PesoAnterior = Convert.ToDecimal(objReport.PesoAnterior);
            objRPT.Infancia = objReport.Infancia;
            objRPT.EvaluacionAlimentacionActual = objReport.EvaluacionAlimentacionActual;
            objRPT.NombreCompleto = objReport.NombreCompleto;
            objRPT.Sexo = objReport.Sexo;
            objRPT.edad = objReport.edad != null ? (int)objReport.edad : 0;
            objRPT.TipoAtencionDesc = objReport.TipoAtencionDesc;
            objRPT.CodigoOA = objReport.CodigoOA;
            objRPT.UnidadServicioDesc = objReport.UnidadServicioDesc;
            objRPT.ServicioExtra = objReport.ServicioExtra;








            return objRPT;
        }

        protected void CrystalReportViewer1_Navigate(object source, CrystalDecisions.Web.NavigateEventArgs e)
        {
            GenerarReporteReceta("");
        }

        private DataTable ConvertListToDataTable(List<VW_ATENCIONPACIENTE> list)
        {
            Log.Information("VisorReportesHCE - ConvertListToDataTable - Entrar");

            DataTable table = new DataTable();

            return table;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["ReportID"] != null)
            {
                // Agregados
                string reportID = Request.QueryString["ReportID"].ToString();
                string Visor = "P";

                //CCEP0102    

                switch (reportID)
                {
                    case "CCEP0003": GenerarReporterptViewAnamnesisEA(Visor);
                        break;
                    case "CCEP0005": GenerarReporterptViewAnamnesisAF(Visor);
                        break;
                    case "CCEP0102": GenerarReporterptViewExamenTriajeFisico(Visor);
                        break;
                    case "CCEP0104": GenerarReporterptViewExamenFisicoRegional(Visor);
                        break;
                    case "CCEP0253": GenerarReporterptViewDiagnostico(Visor);
                        break;
                    case "CCEP2010": GenerarReporterptViewEvolucionObjetiva(Visor);
                        break;
                    case "CCEP0306": GenerarReporterptViewExamenSolicitado(Visor);
                        break;

                    case "ReportExamenes": GenerarReporteReceta("");
                        break;

                }


            }
        }
        protected void GenerarRecetaPDF_Click(object sender, EventArgs e)
        {

        }
        private void GenerarReporteMasivo(String tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteMasivo - Entrar");

            /* ReportDocument cryRpt = new ReportDocument();
             cryRpt.Load("C:/MainReport.rpt");
             cryRpt.DataSourceConnections.Clear();
             cryRpt.SetDataSource(ds.Tables[0]);
             cryRpt.Subreports[0].DataSourceConnections.Clear();
             cryRpt.Subreports[0].SetDataSource(ds.Tables[0]);
             crystalReportViewer1.ReportSource = cryRpt;
             crystalReportViewer1.Refresh();
             string tura = Server.MapPath("rptReports/ViewAdjuntos.rpt");
             Rpt.Load(Server.MapPath("rptReports/ViewAdjuntos.rpt"));*/


        }

        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisEAEdit> GrupalReporterptViewAnamnesisEA(
            String tipoVista, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
            , SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog,
            string codFormato, string codUsuario

            )
        {
            Log.Information("VisorReportesHCE - GrupalReporterptViewAnamnesisEA - Entrar");

            List<rptViewAnamnesisEA> rptViewListaDB = new List<rptViewAnamnesisEA>();
            SS_HC_Anamnesis_EA objRptFiltro = new SS_HC_Anamnesis_EA();
            /*
            objRptFiltro.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            objRptFiltro.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            objRptFiltro.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            objRptFiltro.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            */
            objRptFiltro.UnidadReplicacion = unidadReplicacion;
            objRptFiltro.IdPaciente = idPaciente;
            objRptFiltro.EpisodioClinico = epiClinico;
            objRptFiltro.IdEpisodioAtencion = idEpiAtencion;
            objRptFiltro.Accion = "REPORTEA";
            rptViewListaDB = ServiceReportes.ReporteAnamnesisEA(objRptFiltro, 0, 0);

            objTabla1 = new System.Data.DataTable();
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisEAEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisEAEdit>();
            SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisEAEdit objRPT;
            if (rptViewListaDB != null)
            {
                foreach (rptViewAnamnesisEA objReport in rptViewListaDB) // Loop through List with foreach.
                {
                    objRPT = getObjetoReporteAnamnesisEA(objReport);
                    //objRPT.NombreCompleto = objReport.NombreCompleto;
                    //objRPT.Accion = "~/resources/images/logohce.png";
                    listaRPT.Add(objRPT);
                }

                ///////////////////////////////                    
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewListaDB.Count > 0)
                {
                    setDataImpresionAuditoria(tipoVista, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }
            return listaRPT;
        }
        /*****/
        private void GenerarReporterptViewAnamnesisAP(String tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewAnamnesisAP - Entrar");

            String nombreRpt = "Enfermedad_Actual";
            string tura = Server.MapPath("rptReports/rptViewAnamnesisAP.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewAnamnesisAP.rpt"));

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisAPEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisAPEdit>();

            listaRPT = getDatarptViewAnamnesisAP("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, nombreRpt);
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }

            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }

        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisAPEdit>
        getDatarptViewAnamnesisAP(
            String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
            , SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog,
            string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewAnamnesisAP - Entrar");


            List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisAPEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisAPEdit>();

            List<rptViewAnamnesisAP> rptViewAnamnesisAP = new List<rptViewAnamnesisAP>();
            SS_HC_Anamnesis_AP objRptFiltro = new SS_HC_Anamnesis_AP();
            objRptFiltro.UnidadReplicacion = unidadReplicacion;
            objRptFiltro.IdPaciente = idPaciente;
            objRptFiltro.EpisodioClinico = epiClinico;
            objRptFiltro.IdEpisodioAtencion = idEpiAtencion;
            objRptFiltro.Accion = "REPORTEA";
            rptViewAnamnesisAP = ServiceReportes.ReporteAnamnesisAP(objRptFiltro, 0, 0);

            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisAPEdit objRPT;
            if (rptViewAnamnesisAP != null)
            {
                foreach (rptViewAnamnesisAP objReport in rptViewAnamnesisAP) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisAPEdit();
                    //ADD DATOS DEL REPORTE

                    objRPT.GrupoTipoDiagnostico = objReport.GrupoTipoDiagnostico;
                    objRPT.GrupoTipoDiagnosticoDesc = objReport.GrupoTipoDiagnosticoDesc;
                    objRPT.DiagnosticoDesc = objReport.DiagnosticoDesc;
                    objRPT.Alcohol = objReport.Alcohol;
                    objRPT.Tabaco = objReport.Tabaco;
                    objRPT.Drogas = objReport.Drogas;
                    objRPT.ActividadFisica = objReport.ActividadFisica;
                    objRPT.ConsumoVerduras = objReport.ConsumoVerduras;
                    objRPT.ConsumoFrutas = objReport.ConsumoFrutas;
                    objRPT.Medicamentos = objReport.Medicamentos;
                    objRPT.Alimentos = objReport.Alimentos;
                    objRPT.SustanciasEnElAmbiente = objReport.SustanciasEnElAmbiente;
                    objRPT.SustanciasContactoConPiel = objReport.SustanciasContactoConPiel;
                    objRPT.CrianzaAnimalesDomesticos = objReport.CrianzaAnimalesDomesticos;
                    objRPT.AguaPotable = objReport.AguaPotable;
                    objRPT.DisposicionExcretas = objReport.DisposicionExcretas;


                    //GENERALES

                    objRPT.NombreCompleto = objReport.NombreCompleto;
                    objRPT.Sexo = objReport.Sexo;
                    if (objReport.PersonaEdad != null)
                    {
                        objRPT.PersonaEdad = Convert.ToInt32(objReport.PersonaEdad);
                    }
                    objRPT.TipoTrabajadorDesc = objReport.TipoTrabajadorDesc;
                    objRPT.CodigoOA = objReport.CodigoOA;
                    objRPT.UnidadServicioDesc = objReport.UnidadServicioDesc;
                    objRPT.Expr104 = objReport.Expr104;
                    listaRPT.Add(objRPT);
                }
                ///////////////////////////////                    
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewAnamnesisAP.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }
            return listaRPT;
        }


        /**GENERAL::*/
        private void GenerarReporterptViewGeneralHCE(String tipoVista, String unidRep, String epiClinico, String epiAten, String paciente, String formatos, String usuarioActual, String nombreFileExp)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewGeneralHCE - Entrar");

            string ruta = Server.MapPath("rptReports/ViewAdjuntos.rpt");
            Rpt.Load(Server.MapPath("rptReports/ViewAdjuntos.rpt"));
            /***** TRATAMIENTOS DE PARÁMETROS ******/
            String unidadReplicacion = unidRep;
            int idPaciente = (paciente != null ? (paciente != "" ? Convert.ToInt32(paciente) : 0) : 0);
            int episodioClinico = (epiClinico != null ? (epiClinico != "" ? Convert.ToInt32(epiClinico) : 0) : 0); ;
            long idEpisodioAtencion = (epiAten != null ? (epiAten != "" ? Convert.ToInt64(epiAten) : 0) : 0); ; ;

            #region AgrupadorReporte

            /**LISTAR DATOS GENERALES DEL REPORTES EN 'rptViewAgrupador'*/
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit> ListrptViewAgrupador = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit>();
            SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad = new SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit();
            objEntidad.UnidadReplicacion = unidadReplicacion;
            objEntidad.IdPaciente = idPaciente;
            objEntidad.EpisodioClinico = episodioClinico;
            objEntidad.IdEpisodioAtencion = idEpisodioAtencion;
            Boolean existeDataHC = false;
            List<rptViewAgrupador> ListrptViewAgrupadorOrig = new List<rptViewAgrupador>();
            rptViewAgrupador objEntidadOrig = new rptViewAgrupador();
            objEntidadOrig.UnidadReplicacion = unidadReplicacion;
            objEntidadOrig.IdPaciente = idPaciente;
            objEntidadOrig.EpisodioClinico = episodioClinico;
            objEntidadOrig.EpisodioAtencion = idEpisodioAtencion;
            ListrptViewAgrupadorOrig = ServiceReportes.ReporteViewAgrupador(objEntidadOrig);
            if (ListrptViewAgrupadorOrig.Count > 0)
            {
                existeDataHC = true;
                objEntidad.NombreCompleto = ListrptViewAgrupadorOrig[0].NombreCompleto;
                objEntidad.TipoTrabajadorDesc = ListrptViewAgrupadorOrig[0].TipoTrabajadorDesc;
                objEntidad.ServicioExtra = ListrptViewAgrupadorOrig[0].ServicioExtra;
                objEntidad.Sexo = ListrptViewAgrupadorOrig[0].Sexo;
                objEntidad.CodigoOA = ListrptViewAgrupadorOrig[0].CodigoOA;
                objEntidad.edad = (ListrptViewAgrupadorOrig[0].edad != null ? Convert.ToInt32(ListrptViewAgrupadorOrig[0].edad) : 0);
                objEntidad.UnidadServicioDesc = ListrptViewAgrupadorOrig[0].UnidadServicioDesc;
            }

            /************LISTAR DATA DE CADA SUBREPORTE (DESCARTAR LISTADOS DE ACUERDO A PARAM de FORMATOS)***********************/
            string formatosRecibidos = null;
            formatosRecibidos = formatos;
            string FOMR_VACIO = "000";
            formatos = "";
            //PARA EL REGSITRO DE AUDITORÍA
            int idImpresionLog = setDataImpresionAuditoria("HEADER", 0, objEntidad, null, usuarioActual);

            #endregion

            // FORMULARIO INICIALES
            #region FORMULARIOINICIALES_GETDATA

            //LISTADO FORM_0002
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenTriajeFisicoEdit> listaRPTrptViewExamenTriajeEdit = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenTriajeFisicoEdit>();
            if (formatosRecibidos.Contains("" + FORM_0002))
            {
                listaRPTrptViewExamenTriajeEdit = getDatarptViewExamenTriajeFisico("MASIVO",
                     unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                     objEntidad, idImpresionLog, FORM_0002, usuarioActual);
                if (listaRPTrptViewExamenTriajeEdit.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORM_0002, FOMR_VACIO);
                    formatos = formatos + FORM_0002 + "-";
                }
            }

            //LISTADO FORM_0004
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenFisicoRegionalEdit> listaRPTrptViewExamenRegionalEdit = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenFisicoRegionalEdit>();
            if (formatosRecibidos.Contains("" + FORM_0004))
            {
                listaRPTrptViewExamenRegionalEdit = getDatarptViewExamenFisicoRegional("MASIVO",
                         unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                         objEntidad, idImpresionLog, FORM_0004, usuarioActual);
                if (listaRPTrptViewExamenRegionalEdit.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORM_0004, FOMR_VACIO);
                    formatos = formatos + FORM_0004 + "-";
                }
            }
            //LISTADO FORM_0005
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewEvolucionObjetivaEdit> listaRPTrptViewEvolucionObjetivaEdit = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewEvolucionObjetivaEdit>();
            if (formatosRecibidos.Contains("" + FORM_0005))
            {
                listaRPTrptViewEvolucionObjetivaEdit = getDatarptViewEvolucionObjetiva("MASIVO",
                         unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                         objEntidad, idImpresionLog, FORM_0005, usuarioActual);
                if (listaRPTrptViewEvolucionObjetivaEdit.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORM_0005, FOMR_VACIO);
                    formatos = formatos + FORM_0005 + "-";
                }
            }
            //LISTADO FORM_0006
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisAFEdit> listaRPTrptViewAnamnesisAFEdit = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisAFEdit>();
            if (formatosRecibidos.Contains("" + FORM_0006))
            {
                listaRPTrptViewAnamnesisAFEdit = getDatarptViewAnamnesisAF("MASIVO",
                         unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                         objEntidad, idImpresionLog, FORM_0006, usuarioActual);
                if (listaRPTrptViewAnamnesisAFEdit.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORM_0006, FOMR_VACIO);
                    formatos = formatos + FORM_0006 + "-";
                }
            }

            //LISTADO FORM_0012
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewCuidadosPreventivoEdit> listaRPTrptViewCuidadosPreventivo = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewCuidadosPreventivoEdit>();
            if (formatosRecibidos.Contains("" + FORM_0012))
            {
                listaRPTrptViewCuidadosPreventivo = getDatarptViewCuidadosPreventivo("MASIVO",
                         unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                         objEntidad, idImpresionLog, FORM_0012, usuarioActual);
                if (listaRPTrptViewCuidadosPreventivo.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORM_0012, FOMR_VACIO);
                    formatos = formatos + FORM_0012 + "-";
                }
            }

            #endregion

            // FORMULARIO EXTRAS
            #region FORMULARIOEXTRAS_GETDATA

            //LISTADO FORMFE_330

            DataTable listaRPTInformeConsultaExterna = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_330))
            {
                listaRPTInformeConsultaExterna = rptVistas_FE("rptViewInformeConsultaExterna_FE"
                            , ENTITY_GLOBAL.Instance.UnidadReplicacion
                            , (int)ENTITY_GLOBAL.Instance.PacienteID
                            , (int)ENTITY_GLOBAL.Instance.EpisodioClinico
                            , (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                            , null
                            , 0
                            , ENTITY_GLOBAL.Instance.CONCEPTO
                            , ENTITY_GLOBAL.Instance.USUARIO);

                if (listaRPTInformeConsultaExterna.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_330, FOMR_VACIO);
                    formatos = formatos + FORMFE_330 + "-";
                }
            }


            DataTable listaRPTInmunizacionNinio = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_0001))
            {
                listaRPTInmunizacionNinio = rptVistas_FE("rptViewInmunizacionNinio_FE", unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_0001, usuarioActual);

                if (listaRPTInmunizacionNinio.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0001, FOMR_VACIO);
                    formatos = formatos + FORMFE_0001 + "-";
                }
            }


            //LISTADO FORMFE_0002         
            DataTable listaRPTInmunizacionAdulto = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_0002))
            {
                listaRPTInmunizacionAdulto = rptVistas_FE("rptViewInmunizacionAdulto_FE"
                            , unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_0002, usuarioActual);
                if (listaRPTInmunizacionAdulto.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0002, FOMR_VACIO);
                    formatos = formatos + FORMFE_0002 + "-";
                }
            }

            //LISTADO FORMFE_0003        
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesFisiologicos_FEEdit> listaRPTrptViewAntPerFisiologico_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesFisiologicos_FEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0003))
            {
                listaRPTrptViewAntPerFisiologico_FE = getDatarptViewAntecedenteFisiologico_FE("MASIVO", unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_0003, usuarioActual);
                if (listaRPTrptViewAntPerFisiologico_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0003, FOMR_VACIO);
                    formatos = formatos + FORMFE_0003 + "-";
                }
            }

            //LISTADO FORMFE_0004 
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntFisiologicoPediatricoFEEdit> listaRPTrptViewAntFisiologicoPediatrico_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntFisiologicoPediatricoFEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0004))
            {
                listaRPTrptViewAntFisiologicoPediatrico_FE = getDatarptViewAntFisiologicoPediatrico_FE("MASIVO", unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_0004, usuarioActual);
                if (listaRPTrptViewAntFisiologicoPediatrico_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0004, FOMR_VACIO);
                    formatos = formatos + FORMFE_0004 + "-";
                }
            }

            //LISTADO FORM_0005GENERALES
            DataTable listaRPTrptAntGenerales_FE = new DataTable();
            DataTable listaRPTrptAntGeneralesDetalle_FE = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_0005CAB))
            {
                listaRPTrptAntGenerales_FE = rptVistas_FE("rptViewAntecedentesPersonalesPatologicosGenerales_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_0005CAB, usuarioActual);
                if (listaRPTrptAntGenerales_FE.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0005CAB, FOMR_VACIO);
                    formatos = formatos + FORMFE_0005CAB + "-";
                }

                listaRPTrptAntGeneralesDetalle_FE = rptVistas_FE("rptViewAntecedentesPersonalesPatologicosGenerales_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_0005DET, usuarioActual);
                if (listaRPTrptAntGeneralesDetalle_FE.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0005DET, FOMR_VACIO);
                    formatos = formatos + FORMFE_0005DET + "-";
                }
            }


            //LISTADO FORM_0005GINECO
            DataTable listaRPTrptGiencObstetrico = new DataTable();
            DataTable listaRPTrptGiencObstetricoDetalle = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_0005CABGINECO))
            {
                listaRPTrptGiencObstetrico = rptVistas_FE("rptViewAntecedentesPersGinecObstetrico_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_0005CABGINECO, usuarioActual);
                if (listaRPTrptGiencObstetrico.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0005CABGINECO, FOMR_VACIO);
                    formatos = formatos + FORMFE_0005CABGINECO + "-";
                }

                listaRPTrptGiencObstetricoDetalle = rptVistas_FE("rptViewAntecedentesPersGinecObstetrico_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_0005DETGINECO, usuarioActual);
                if (listaRPTrptGiencObstetricoDetalle.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0005DETGINECO, FOMR_VACIO);
                    formatos = formatos + FORMFE_0005DETGINECO + "-";
                }
            }


            //LISTADO FORM_327ORDENINTERVENCIONQUIRURGICA
            DataTable listaRPTCabezeraOrdenInterQuirur1 = new DataTable();
            DataTable listaRPTrptDetOrdenInterQuirurDiag = new DataTable();
            DataTable listaRPTrptDetOrdenInterQuirurCiruProced = new DataTable();
            DataTable listaRPTrptDetOrdenInterQuirurExamen1 = new DataTable();
            DataTable listaRPTrptDetOrdenInterQuirurExamen2 = new DataTable();
            DataTable listaRPTrptDetOrdenInterQuirurExamen3 = new DataTable();


            if (formatosRecibidos.Contains("" + FORMFE_327CAB))
            {
                listaRPTCabezeraOrdenInterQuirur1 = rptVistas_FE("rptViewOrdenInterQuirurgica_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_327CAB, usuarioActual);
                if (listaRPTCabezeraOrdenInterQuirur1.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_327CAB, FOMR_VACIO);
                    formatos = formatos + FORMFE_327CAB + "-";

                    // Verificar si la lista es válida y contiene al menos un elemento
                    if (listaRPTCabezeraOrdenInterQuirur1 != null && listaRPTCabezeraOrdenInterQuirur1.Rows.Count > 0)
                    {
                        // Verificar si la sesión contiene el dato necesario
                        if (Session["EmpresaAseguradoraNombre"] != null)
                        {
                            // Validar si existe la clave "Accion" en las columnas del DataTable
                            if (listaRPTCabezeraOrdenInterQuirur1.Columns.Contains("Accion"))
                            {
                                // Asignar el valor desde la sesión
                                listaRPTCabezeraOrdenInterQuirur1.Rows[0]["Accion"] = Session["EmpresaAseguradoraNombre"];
                            }
                        }
                        // Verificar si la sesión contiene el dato necesario
                        if (Session["CodigoHC_PACIENTE"] != null)
                        {
                            // Validar si existe la clave "Accion" en las columnas del DataTable
                            if (listaRPTCabezeraOrdenInterQuirur1.Columns.Contains("Version"))
                            {
                                // Asignar el valor desde la sesión
                                listaRPTCabezeraOrdenInterQuirur1.Rows[0]["Version"] = Session["CodigoHC_PACIENTE"];
                            }
                        }
                    }

                    foreach (DataRow ht_fila in listaRPTCabezeraOrdenInterQuirur1.Rows)
                    {
                        if (ht_fila["UnidadServicioCodigo"].ToString() != null && ht_fila["UnidadServicioCodigo"].ToString() != "")
                        {
                            System.IO.FileInfo fi = new System.IO.FileInfo(ht_fila["UnidadServicioCodigo"].ToString());
                            if (fi.Exists)
                            {
                                var NombreServidor = fi.Name;
                                var rutaServidor = Server.MapPath("../resources/DocumentosAdjuntos/firmas/");
                                if (!Directory.Exists(rutaServidor))
                                {
                                    DirectoryInfo di = Directory.CreateDirectory(rutaServidor);
                                }
                                var PathServidor = rutaServidor + NombreServidor;
                                System.IO.File.Copy(ht_fila["UnidadServicioCodigo"].ToString(), PathServidor, true);
                                var PathOri = "../resources/DocumentosAdjuntos/firmas/" + NombreServidor;
                                Session["FIRMA_DIGITAL"] = PathOri;
                            }
                        }
                        else
                        {
                            Session["FIRMA_DIGITAL"] = "";
                        }
                    }

                }

                listaRPTrptDetOrdenInterQuirurDiag = rptVistas_FE("rptViewOrdenInterQuiruDiagnosticoDetalle_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_327DIAG, usuarioActual);
                if (listaRPTrptDetOrdenInterQuirurDiag.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_327DIAG, FOMR_VACIO);
                    formatos = formatos + FORMFE_327DIAG + "-";
                }

                listaRPTrptDetOrdenInterQuirurCiruProced = rptVistasExamenesOrdenInter_FE("rptViewOrdenInterQuiruExamenApoyoDetalle_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_327CIRUGIAPRO, usuarioActual, 1);
                if (listaRPTrptDetOrdenInterQuirurCiruProced.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_327CIRUGIAPRO, FOMR_VACIO);
                    formatos = formatos + FORMFE_327CIRUGIAPRO + "-";
                }

                listaRPTrptDetOrdenInterQuirurExamen1 = rptVistasExamenesOrdenInter_FE("rptViewOrdenInterQuiruExamenApoyoDetalle_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_327EXAMEN1, usuarioActual, 2);
                if (listaRPTrptDetOrdenInterQuirurExamen1.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_327EXAMEN1, FOMR_VACIO);
                    formatos = formatos + FORMFE_327EXAMEN1 + "-";
                }


                listaRPTrptDetOrdenInterQuirurExamen2 = rptVistasExamenesOrdenInter_FE("rptViewOrdenInterQuiruExamenApoyoDetalle_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_327EXAMEN2, usuarioActual, 3);
                if (listaRPTrptDetOrdenInterQuirurExamen2.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_327EXAMEN2, FOMR_VACIO);
                    formatos = formatos + FORMFE_327EXAMEN2 + "-";
                }

                listaRPTrptDetOrdenInterQuirurExamen3 = rptVistasExamenesOrdenInter_FE("rptViewOrdenInterQuiruExamenApoyoDetalle_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_327EXAMEN3, usuarioActual, 4);
                if (listaRPTrptDetOrdenInterQuirurExamen3.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_327EXAMEN3, FOMR_VACIO);
                    formatos = formatos + FORMFE_327EXAMEN3 + "-";
                }
            }

            //LISTADO NOTA DE INGRESO listaRPTNotaDeIngresoCAB1
            DataTable listaRPTNotaDeIngresoCAB1 = new DataTable();
            DataTable listaRPTNotaDeIngresoCAB2 = new DataTable();
            DataTable listaRPTNotaDeIngresoCAB3 = new DataTable();
            DataTable listaRPTrptDetNotaDeIngresoDiag = new DataTable();
            DataTable listaRPTrptDetNotaDeIngresoExamen1 = new DataTable();

            if (formatosRecibidos.Contains("" + FORMFE_319CAB1))
            {
                listaRPTNotaDeIngresoCAB1 = rptVistas_FE("rptViewNota_Ingreso_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_319CAB1, usuarioActual);
                if (listaRPTNotaDeIngresoCAB1.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_319CAB1, FOMR_VACIO);
                    formatos = formatos + FORMFE_319CAB1 + "-";
                }

                listaRPTrptDetNotaDeIngresoDiag = rptVistas_FE("rptViewNotaIngreso_Diagnostico_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_319DIAG, usuarioActual);
                if (listaRPTrptDetNotaDeIngresoDiag.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_319DIAG, FOMR_VACIO);
                    formatos = formatos + FORMFE_319DIAG + "-";
                }

                listaRPTNotaDeIngresoCAB2 = rptVistas_FE("rptViewNota_Ingreso_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_319CAB2, usuarioActual);
                if (listaRPTNotaDeIngresoCAB2.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_319CAB2, FOMR_VACIO);
                    formatos = formatos + FORMFE_319CAB2 + "-";
                }

                listaRPTrptDetNotaDeIngresoExamen1 = rptVistasExamenesOrdenInter_FE("rptViewNotaIngreso_ExamenApoyo_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_319EXAMEN1, usuarioActual, 2);
                if (listaRPTrptDetNotaDeIngresoExamen1.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_319EXAMEN1, FOMR_VACIO);
                    formatos = formatos + FORMFE_319EXAMEN1 + "-";
                }


                listaRPTNotaDeIngresoCAB3 = rptVistas_FE("rptViewNota_Ingreso_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_319CAB3, usuarioActual);
                if (listaRPTNotaDeIngresoCAB3.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_319CAB3, FOMR_VACIO);
                    formatos = formatos + FORMFE_319CAB3 + "-";
                }
            }


            //LISTADO TOCOLOSIS listaRPTTocolosisInduccionAcentuacion
            DataTable listaRPTTocolosisInduccionAcentuacion = new DataTable();

            if (formatosRecibidos.Contains("" + FORMFE_502TOCOLOSIS))
            {
                listaRPTTocolosisInduccionAcentuacion = rptVistas_FE("rptViewTocolosisInduccionAcentuacion_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_502TOCOLOSIS, usuarioActual);
                if (listaRPTTocolosisInduccionAcentuacion.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_502TOCOLOSIS, FOMR_VACIO);
                    formatos = formatos + FORMFE_502TOCOLOSIS + "-";
                }

            }

            // LISTADO FORMFE_402CABHELECT1
            DataTable listaRPTrptHelectrolitoNeoCAB1 = new DataTable();
            DataTable listaRPTrptHelectrolitoNeoCAB2 = new DataTable();
            DataTable listaRPTrptHelectrolitoNeoCAB3 = new DataTable();
            DataTable listaRPTrptHelectrolitoNeoDET1 = new DataTable();
            DataTable listaRPTrptHelectrolitoNeoDET2 = new DataTable();

            if (formatosRecibidos.Contains("" + FORMFE_402CABHELECT1))
            {
                listaRPTrptHelectrolitoNeoCAB1 = rptVistasBalanceHidroElectro_FE("rptViewBalanceHidroElectrolitico_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_402CABHELECT1, usuarioActual, 1);
                if (listaRPTrptHelectrolitoNeoCAB1.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_402CABHELECT1, FOMR_VACIO);
                    formatos = formatos + FORMFE_402CABHELECT1 + "-";
                }

                listaRPTrptHelectrolitoNeoDET1 = rptVistasBalanceHidroElectroDetalles_FE("rptViewBalanceHidroElectroliticoDetalle1_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_402DETHELECT1, usuarioActual, 1, 1);
                if (listaRPTrptHelectrolitoNeoDET1.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_402DETHELECT1, FOMR_VACIO);
                    formatos = formatos + FORMFE_402DETHELECT1 + "-";
                }


                listaRPTrptHelectrolitoNeoCAB2 = rptVistasBalanceHidroElectro_FE("rptViewBalanceHidroElectrolitico_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_402CABHELECT2, usuarioActual, 1);
                if (listaRPTrptHelectrolitoNeoCAB2.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_402CABHELECT2, FOMR_VACIO);
                    formatos = formatos + FORMFE_402CABHELECT2 + "-";
                }


                listaRPTrptHelectrolitoNeoDET2 = rptVistasBalanceHidroElectroDetalles_FE("rptViewBalanceHidroElectroliticoDetalle2_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_402DETHELECT2, usuarioActual, 1, 2);

                if (listaRPTrptHelectrolitoNeoDET2.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_402DETHELECT2, FOMR_VACIO);
                    formatos = formatos + FORMFE_402DETHELECT2 + "-";
                }


                listaRPTrptHelectrolitoNeoCAB3 = rptVistasBalanceHidroElectro_FE("rptViewBalanceHidroElectrolitico_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_402CABHELECT3, usuarioActual, 1);
                if (listaRPTrptHelectrolitoNeoCAB3.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_402CABHELECT3, FOMR_VACIO);
                    formatos = formatos + FORMFE_402CABHELECT3 + "-";
                }

            }


            // LISTADO FORMFE_401CABHELECT1
            DataTable listaRPTrptHelectrolitoSOPCAB1 = new DataTable();
            DataTable listaRPTrptHelectrolitoSOPCAB2 = new DataTable();
            DataTable listaRPTrptHelectrolitoSOPCAB3 = new DataTable();
            DataTable listaRPTrptHelectrolitoSOPDET1 = new DataTable();
            DataTable listaRPTrptHelectrolitoSOPDET2 = new DataTable();

            if (formatosRecibidos.Contains("" + FORMFE_401CABHELECT1))
            {
                listaRPTrptHelectrolitoSOPCAB1 = rptVistasBalanceHidroElectro_FE("rptViewBalanceHidroElectrolitico_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_401CABHELECT1, usuarioActual, 2);
                if (listaRPTrptHelectrolitoSOPCAB1.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_401CABHELECT1, FOMR_VACIO);
                    formatos = formatos + FORMFE_401CABHELECT1 + "-";
                }


                listaRPTrptHelectrolitoSOPDET1 = rptVistasBalanceHidroElectroDetalles_FE("rptViewBalanceHidroElectroliticoDetalle1_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_401DETHELECT1, usuarioActual, 2, 1);
                if (listaRPTrptHelectrolitoSOPDET1.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_401DETHELECT1, FOMR_VACIO);
                    formatos = formatos + FORMFE_401DETHELECT1 + "-";
                }


                listaRPTrptHelectrolitoSOPCAB2 = rptVistasBalanceHidroElectro_FE("rptViewBalanceHidroElectrolitico_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_401CABHELECT2, usuarioActual, 2);
                if (listaRPTrptHelectrolitoSOPCAB2.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_401CABHELECT2, FOMR_VACIO);
                    formatos = formatos + FORMFE_401CABHELECT2 + "-";
                }



                listaRPTrptHelectrolitoSOPDET2 = rptVistasBalanceHidroElectroDetalles_FE("rptViewBalanceHidroElectroliticoDetalle2_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_401DETHELECT2, usuarioActual, 2, 2);

                if (listaRPTrptHelectrolitoSOPDET2.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_401DETHELECT2, FOMR_VACIO);
                    formatos = formatos + FORMFE_401DETHELECT2 + "-";
                }


                listaRPTrptHelectrolitoSOPCAB3 = rptVistasBalanceHidroElectro_FE("rptViewBalanceHidroElectrolitico_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_401CABHELECT3, usuarioActual, 2);
                if (listaRPTrptHelectrolitoSOPCAB3.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_401CABHELECT3, FOMR_VACIO);
                    formatos = formatos + FORMFE_401CABHELECT3 + "-";
                }
            }





            //LISTADO FORM_302HOJARECIEN_NACIDO
            DataTable listaRPTrptHojaRecienNacido = new DataTable();
            DataTable listaRPTrptHojaRecienNacidoDetalle = new DataTable();

            if (formatosRecibidos.Contains("" + FORMFE_302CABHOJA))
            {
                listaRPTrptHojaRecienNacido = rptVistas_FE("rptHojaRecienNacido_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_302CABHOJA, usuarioActual);
                if (listaRPTrptHojaRecienNacido.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_302CABHOJA, FOMR_VACIO);
                    formatos = formatos + FORMFE_302CABHOJA + "-";
                }

                listaRPTrptHojaRecienNacidoDetalle = rptVistas_FE("rptViewHojarecienNacidoDetalle_FEsubrep",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_302DETHOJA, usuarioActual);
                if (listaRPTrptHojaRecienNacidoDetalle.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_302DETHOJA, FOMR_VACIO);
                    formatos = formatos + FORMFE_302DETHOJA + "-";
                }
            }

            //LISTADO FORMFE_461CIRUENTRADA
            DataTable listaRPTrptSeguridadCirugiaEntradaCab = new DataTable();

            if (formatosRecibidos.Contains("" + FORMFE_461CIRUENTRADA))
            {

                listaRPTrptSeguridadCirugiaEntradaCab = rptVistasTipoCirugia_FE("rptViewSeguridadCirugia_FE",
                    unidadReplicacion,
                    idPaciente,
                    episodioClinico,
                    idEpisodioAtencion
                   , null, 0, FORMFE_461CIRUENTRADA, usuarioActual, 1);

                if (listaRPTrptSeguridadCirugiaEntradaCab.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_461CIRUENTRADA, FOMR_VACIO);
                    formatos = formatos + FORMFE_461CIRUENTRADA + "-";
                }

            }



            //LISTADO FORMFE_462CIRUPAUSA
            DataTable listaRPTrptSeguridadCirugiaPausaCab = new DataTable();

            if (formatosRecibidos.Contains("" + FORMFE_462CIRUPAUSA))
            {

                listaRPTrptSeguridadCirugiaPausaCab = rptVistasTipoCirugia_FE("rptViewSeguridadCirugia_FE",
                    unidadReplicacion,
                    idPaciente,
                    episodioClinico,
                    idEpisodioAtencion
                   , null, 0, FORMFE_462CIRUPAUSA, usuarioActual, 2);

                if (listaRPTrptSeguridadCirugiaPausaCab.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_462CIRUPAUSA, FOMR_VACIO);
                    formatos = formatos + FORMFE_462CIRUPAUSA + "-";
                }

            }



            //LISTADO FORMFE_463CIRUSALIDA
            DataTable listaRPTrptSeguridadCirugiaSalidaCab = new DataTable();

            if (formatosRecibidos.Contains("" + FORMFE_463CIRUSALIDA))
            {

                listaRPTrptSeguridadCirugiaSalidaCab = rptVistasTipoCirugia_FE("rptViewSeguridadCirugia_FE",
                    unidadReplicacion,
                    idPaciente,
                    episodioClinico,
                    idEpisodioAtencion
                   , null, 0, FORMFE_463CIRUSALIDA, usuarioActual, 3);

                if (listaRPTrptSeguridadCirugiaSalidaCab.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_463CIRUSALIDA, FOMR_VACIO);
                    formatos = formatos + FORMFE_463CIRUSALIDA + "-";
                }

            }


            //LISTADO FORMFE_464
            DataTable listaRPTrptEscalaAltaCirugiaAmbulatoria = new DataTable();

            if (formatosRecibidos.Contains("" + FORMFE_464))
            {

                listaRPTrptEscalaAltaCirugiaAmbulatoria = rptVistas_FE("rptViewEscalaAltaCirugiaAmbulatoria_FE",
                    unidadReplicacion,
                    idPaciente,
                    episodioClinico,
                    idEpisodioAtencion
                   , null, 0, FORMFE_464, usuarioActual);

                if (listaRPTrptEscalaAltaCirugiaAmbulatoria.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_464, FOMR_VACIO);
                    formatos = formatos + FORMFE_464 + "-";
                }
            }

            //LISTADO FORM_0005GINECO
            DataTable listaRPAnestesia3 = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_323_3CAB_ANESTESIA3))
            {
                listaRPAnestesia3 = rptVistas_FE("rptViewFichaAnestesia_3_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_323_3CAB_ANESTESIA3, usuarioActual);
                if (listaRPAnestesia3.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_323_3CAB_ANESTESIA3, FOMR_VACIO);
                    formatos = formatos + FORMFE_323_3CAB_ANESTESIA3 + "-";
                }

            }


            //LISTADO FORM_323_1ANESTESIA
            DataTable listaRPTrptAnestesia1 = new DataTable();
            DataTable listaRPTrptAnestesiaCab2 = new DataTable();
            DataTable listaRPTrptAnestesiaCab3 = new DataTable();
            DataTable listaRPTrptAnestesia1Detalle_1 = new DataTable();

            DataTable listaRPTrptAnestesia1Detalle_2 = new DataTable();
            DataTable listaRPTrptAnestesia1Detalle_3 = new DataTable();
            DataTable listaRPTrptAnestesia1Detalle_4 = new DataTable();
            DataTable listaRPTrptAnestesia1Detalle_5 = new DataTable();


            if (formatosRecibidos.Contains("" + FORMFE_323_1CABANESTESIA))
            {
                listaRPTrptAnestesia1 = rptVistas_FE("rptViewFichaAnestesia_1_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_323_1CABANESTESIA, usuarioActual);
                if (listaRPTrptAnestesia1.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_323_1CABANESTESIA, FOMR_VACIO);
                    formatos = formatos + FORMFE_323_1CABANESTESIA + "-";
                }

                listaRPTrptAnestesia1Detalle_1 = rptVistasExamenesAnestesiaDetalle_1_FE("rptViewFichaAnestesia_1_ExamenesDetalle_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_323_1DET1_ANESTESIA, usuarioActual, 1);

                if (listaRPTrptAnestesia1Detalle_1.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_323_1DET1_ANESTESIA, FOMR_VACIO);
                    formatos = formatos + FORMFE_323_1DET1_ANESTESIA + "-";
                }


                listaRPTrptAnestesiaCab2 = rptVistas_FE("rptViewFichaAnestesia_1_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_323_1CABANESTESIA2, usuarioActual);
                if (listaRPTrptAnestesiaCab2.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_323_1CABANESTESIA2, FOMR_VACIO);
                    formatos = formatos + FORMFE_323_1CABANESTESIA2 + "-";
                }

                listaRPTrptAnestesia1Detalle_2 = rptVistasDiagnosticosAnestesiaDetalle_1_FE("rptViewFichaAnestesia_1_DiagnosticoDetalle_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_323_1DET1_ANESDIAG1, usuarioActual, 1);

                if (listaRPTrptAnestesia1Detalle_2.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_323_1DET1_ANESDIAG1, FOMR_VACIO);
                    formatos = formatos + FORMFE_323_1DET1_ANESDIAG1 + "-";
                }


                listaRPTrptAnestesia1Detalle_3 = rptVistasExamenesAnestesiaDetalle_1_FE("rptViewFichaAnestesia_1_ExamenesDetalle_FE",
                      unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                      null, 0, FORMFE_323_1DET1_ANESEXAM2, usuarioActual, 1);

                if (listaRPTrptAnestesia1Detalle_3.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_323_1DET1_ANESEXAM2, FOMR_VACIO);
                    formatos = formatos + FORMFE_323_1DET1_ANESEXAM2 + "-";
                }


                listaRPTrptAnestesia1Detalle_4 = rptVistasDiagnosticosAnestesiaDetalle_1_FE("rptViewFichaAnestesia_1_DiagnosticoDetalle_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_323_1DET1_ANESDIAG2, usuarioActual, 1);

                if (listaRPTrptAnestesia1Detalle_4.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_323_1DET1_ANESDIAG2, FOMR_VACIO);
                    formatos = formatos + FORMFE_323_1DET1_ANESDIAG2 + "-";
                }

                listaRPTrptAnestesia1Detalle_5 = rptVistasExamenesAnestesiaDetalle_1_FE("rptViewFichaAnestesia_1_ExamenesDetalle_FE",
                        unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_323_1DET1_ANESEXAM3, usuarioActual, 3);

                if (listaRPTrptAnestesia1Detalle_5.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_323_1DET1_ANESEXAM3, FOMR_VACIO);
                    formatos = formatos + FORMFE_323_1DET1_ANESEXAM3 + "-";
                }
                listaRPTrptAnestesiaCab3 = rptVistas_FE("rptViewFichaAnestesia_1_FE",
                     unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                     null, 0, FORMFE_323_1CABANESTESIA3, usuarioActual);
                if (listaRPTrptAnestesiaCab2.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_323_1CABANESTESIA3, FOMR_VACIO);
                    formatos = formatos + FORMFE_323_1CABANESTESIA3 + "-";
                }
            }

            //LISTADO FORM_0006

            DataTable listarptViewAlergias_FE = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_0006))
            {
                listarptViewAlergias_FE = rptVistas_FE("rptViewAlergias_FE",
                       unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_0006, usuarioActual);
                if (listarptViewAlergias_FE.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0006, FOMR_VACIO);
                    formatos = formatos + FORMFE_0006 + "-";
                }
            }

            //LISTADO FORM_0007
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesis_AFAM_FEEdit> listarptAnt_Familiares = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesis_AFAM_FEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0007))
            {
                listarptAnt_Familiares = getDatarptViewAnamnesis_ANTFAM_FE("MASIVO", unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_0007, usuarioActual);
                if (listarptAnt_Familiares.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0007, FOMR_VACIO);
                    formatos = formatos + FORMFE_0007 + "-";
                }
            }
            //LISTADO FORMFE_0008
            List<SoluccionSalud.RepositoryReport.Entidades.rptView_ValoracionFuncionalAM_FEEdit> listarptView_ValoracionFuncionalAM_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptView_ValoracionFuncionalAM_FEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0008))
            {
                listarptView_ValoracionFuncionalAM_FE = getDatarptViewValoracionFuncionalAM_FE("MASIVO", unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_0008, usuarioActual);
                if (listarptView_ValoracionFuncionalAM_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0008, FOMR_VACIO);
                    formatos = formatos + FORMFE_0008 + "-";
                }
            }


            //LISTADO FORMFE_0009
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionMentalAM_FEEdit> listarptViewValoracionMentalAM_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionMentalAM_FEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0009))
            {
                listarptViewValoracionMentalAM_FE = getDatarptViewValoracionMentalAM_FE("MASIVO", unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_0009, usuarioActual);
                if (listarptViewValoracionMentalAM_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0009, FOMR_VACIO);
                    formatos = formatos + FORMFE_0009 + "-";
                }
            }

            //LISTADO FORMFE_0010
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionSocioFamAM_FEEdit> listaRPTrptViewValoracionSocioFamAM_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionSocioFamAM_FEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0010))
            {
                listaRPTrptViewValoracionSocioFamAM_FE = getDatarptViewValoracionSocioFamAM_FE("MASIVO", unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_0010, usuarioActual);
                if (listaRPTrptViewValoracionSocioFamAM_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0010, FOMR_VACIO);
                    formatos = formatos + FORMFE_0010 + "-";
                }
            }

            //LISTADO FORMFE_0011
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionAM_FEEdit> listaRPTrptViewValoracionAM_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionAM_FEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0011))
            {
                listaRPTrptViewValoracionAM_FE = getDatarptViewValoracionAM_FE("MASIVO", unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_0011, usuarioActual);
                if (listaRPTrptViewValoracionAM_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0011, FOMR_VACIO);
                    formatos = formatos + FORMFE_0011 + "-";
                }
            }

            ////LISTADO FORMFE_0012
            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewDiagnostico_FEEdit> listaRPTrptViewDiagnostico_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewDiagnostico_FEEdit>();
            //if (formatosRecibidos.Contains("" + FORMFE_0012))
            //{
            //    listaRPTrptViewDiagnostico_FE = getDatarptViewDiagnostico_FE("MASIVO", unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
            //            null, 0, FORMFE_0012, usuarioActual);
            //    if (listaRPTrptViewDiagnostico_FE.Count > 0)
            //    {
            //        //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
            //        formatosRecibidos = formatosRecibidos.Replace(FORMFE_0012, FOMR_VACIO);
            //        formatos = formatos + FORMFE_0012 + "-";
            //    }
            //}

            //LISTADO FORMFE_0012
            DataTable listaRPTrptViewDiagnostico_FE = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_0012))
            {
                listaRPTrptViewDiagnostico_FE = rptVistas_FE("rptViewDiagnostico_FE",
                            unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_0012, usuarioActual);
                if (listaRPTrptViewDiagnostico_FE.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0012, FOMR_VACIO);
                    formatos = formatos + FORMFE_0012 + "-";
                }
            }


            //LISTADO FORMFE_0013
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenApoyoDiagnostico_FEEdit> listaRPTrptViewExamenApoyo_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenApoyoDiagnostico_FEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0013))
            {
                listaRPTrptViewExamenApoyo_FE = getDatarptViewExamenApoyoDiagnostico_FE("MASIVO", unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_0013, usuarioActual);
                if (listaRPTrptViewExamenApoyo_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0013, FOMR_VACIO);
                    formatos = formatos + FORMFE_0013 + "-";
                }
            }

            //LISTADO FORMFE_0014
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewInterconsulta_FEEdit> listaRPTrptViewInterconsulta_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewInterconsulta_FEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0014))
            {
                listaRPTrptViewInterconsulta_FE = getDatarptViewInterconsulta_FE("MASIVO", unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_0014, usuarioActual);
                if (listaRPTrptViewInterconsulta_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0014, FOMR_VACIO);
                    formatos = formatos + FORMFE_0014 + "-";
                }
            }

            //LISTADO FORMFE_0015
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewProximaAtencion_FEEdit> listaRPTrptViewProximaAtencion_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewProximaAtencion_FEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0015))
            {
                listaRPTrptViewProximaAtencion_FE = getDatarptViewProximaAtencion_FE("MASIVO", unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_0015, usuarioActual);
                if (listaRPTrptViewProximaAtencion_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0015, FOMR_VACIO);
                    formatos = formatos + FORMFE_0015 + "-";
                }
            }


            //LISTADO FORMFE_0016
            DataTable listaRPTApoyoDiagnostico = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_0016))
            {
                listaRPTApoyoDiagnostico = rptVistas_FE("rptViewApoyoDiagnostico_FE",
                            unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                        null, 0, FORMFE_0016, usuarioActual);

                if (listaRPTApoyoDiagnostico.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0016, FOMR_VACIO);
                    formatos = formatos + FORMFE_0016 + "-";
                }
            }

            //LISTADO FORMFE_0017

            //LISTADO FORMFE_0018
            DataTable listaRPTPac_DIE = new DataTable();

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewDieta_FEEdit> listaRPTrptViewDieta1_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewDieta_FEEdit>();
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewDieta_FEEdit> listaRPTrptViewDieta2_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewDieta_FEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0018DET1))
            {
                listaRPTrptViewDieta1_FE = getDatarptViewDieta_FE("MASIVO", unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                            null, 0, FORMFE_0018DET1, usuarioActual, 2);
                if (listaRPTrptViewDieta1_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0018DET1, FOMR_VACIO);
                    formatos = formatos + FORMFE_0018DET1 + "-";
                }

                listaRPTrptViewDieta2_FE = getDatarptViewDieta_FE("MASIVO", unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                            null, 0, FORMFE_0018DET2, usuarioActual, 3);
                if (listaRPTrptViewDieta2_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0018DET2, FOMR_VACIO);
                    formatos = formatos + FORMFE_0018DET2 + "-";
                }

                listaRPTPac_DIE = rptDatosPacienteMedico_FE("rptViewDieta_FE", unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                                                null, 0, FORMFE_0018DET3, usuarioActual);


                if (listaRPTPac_DIE.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0018DET3, FOMR_VACIO);
                    formatos = formatos + FORMFE_0018DET3 + "-";
                }


            }
            //LISTADO FORMFE_0019
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit> listaRPTrptViewMedicamentos1_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit>();
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit> listaRPTrptViewMedicamentos2_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit>();
            //Subreporte 3
            DataTable listaRPTPac_Med = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_0019DET1))
            {
                //Subreporte 1
                listaRPTrptViewMedicamentos1_FE = getDatarptViewMedicamentos_FE("MASIVO", unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                            null, 0, FORMFE_0019DET1, usuarioActual, 1);

                if (listaRPTrptViewMedicamentos1_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0019DET1, FOMR_VACIO);
                    formatos = formatos + FORMFE_0019DET1 + "-";
                }
                //Subreporte 2
                listaRPTrptViewMedicamentos2_FE = getDatarptViewMedicamentos_FE("MASIVO", unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                            null, 0, FORMFE_0019DET2, usuarioActual, 4);

                if (listaRPTrptViewMedicamentos2_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0019DET2, FOMR_VACIO);
                    formatos = formatos + FORMFE_0019DET2 + "-";
                }

                listaRPTPac_Med = rptDatosPacienteMedico_FE("rptViewDatosPaciente_Medico", unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                                         null, 0, FORMFE_0019DET3, usuarioActual);

                if (listaRPTPac_Med.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0019DET3, FOMR_VACIO);
                    formatos = formatos + FORMFE_0019DET3 + "-";
                }
            }

            //LISTADO FORMFE_0020
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewEmitirDescansoMedicoFEEdit> listaRPTrptViewDescansoMedicoFE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewEmitirDescansoMedicoFEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0020))
            {
                listaRPTrptViewDescansoMedicoFE = getDatarptViewEmitirDescansoMedicoFE("MASIVO", unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                            null, 0, FORMFE_0020, usuarioActual);
                if (listaRPTrptViewDescansoMedicoFE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0020, FOMR_VACIO);
                    formatos = formatos + FORMFE_0020 + "-";
                }
            }
            //LISTADO FORMFE_0021
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewEvolucionMedica_FEEdit> listaRPTrptViewEvolucionMedica_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewEvolucionMedica_FEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0021))
            {
                listaRPTrptViewEvolucionMedica_FE = getDatarptViewEvolucionMedica_FE("MASIVO", unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                            null, 0, FORMFE_0021, usuarioActual);
                if (listaRPTrptViewEvolucionMedica_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0021, FOMR_VACIO);
                    formatos = formatos + FORMFE_0021 + "-";
                }
            }
            #endregion

            // FORMULARIO FED
            #region FORMULARIOSFED_GETDATA

            //LISTADO FORMFE_0038

            //LISTADO FORMFE_0039

            //LISTADO FORMFE_0040

            //LISTADO FORMFE_0041
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewEscalaStewart_FEEdit> listarptVistasStewart_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewEscalaStewart_FEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0041))
            {
                listarptVistasStewart_FE = getDatarptViewEscalaStewart_FE("MASIVO", unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                            null, 0, FORMFE_0041, usuarioActual);

                if (listarptVistasStewart_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0041, FOMR_VACIO);
                    formatos = formatos + FORMFE_0041 + "-";
                }
            }

            //LISTADO FORMFE_0042

            DataTable listarptVistasRamsay_FE = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_0042))
            {
                listarptVistasRamsay_FE = rptVistasEscalaRamsay_FE("rptViewEscalaRamsay_FE", unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                            null, 0, FORMFE_0042, usuarioActual);

                if (listarptVistasRamsay_FE.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0042, FOMR_VACIO);
                    formatos = formatos + FORMFE_0042 + "-";
                }
            }


            //LISTADO FORMFE_0043
            DataTable listarptVistasRetiroVoluntario_FE1 = new DataTable();
            DataTable listarptVistasRetiroVoluntario_FE2 = new DataTable();

            string varVistaEntidad = "rptViewRetiroVoluntario_FE"; // Entidad Vista
            if (formatosRecibidos.Contains("" + FORMFE_0043))
            {
                listarptVistasRetiroVoluntario_FE1 = rptVistasRetiroVoluntario_FE(varVistaEntidad, unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                            null, 0, FORMFE_0043, usuarioActual);

                listarptVistasRetiroVoluntario_FE2 = rptVistasRetiroVoluntario_FE(varVistaEntidad
                                    , "", 0, 0, 0, null, 0, FORMFE_0043, usuarioActual);

                // Recorrer y asignar valores

                foreach (DataRow ht_fila in listarptVistasRetiroVoluntario_FE1.AsEnumerable())
                {

                    DataRow rw = listarptVistasRetiroVoluntario_FE2.NewRow();

                    rw["UnidadReplicacion"] = ht_fila["UnidadReplicacion"];
                    rw["IdEpisodioAtencion"] = ht_fila["IdEpisodioAtencion"];
                    rw["IdPaciente"] = ht_fila["IdPaciente"];
                    rw["EpisodioClinico"] = ht_fila["EpisodioClinico"];
                    rw["IdRetiroVoluntario"] = ht_fila["IdRetiroVoluntario"];
                    rw["FechaIngreso"] = ht_fila["FechaIngreso"];
                    rw["HoraIngreso"] = ht_fila["HoraIngreso"];
                    rw["RepresentanteLegal"] = ht_fila["RepresentanteLegal"];
                    rw["IdPersonalSalud"] = ht_fila["IdPersonalSalud"];
                    rw["UsuarioCreacion"] = ht_fila["UsuarioCreacion"];
                    rw["FechaCreacion"] = ht_fila["FechaCreacion"];
                    rw["UsuarioModificacion"] = ht_fila["UsuarioModificacion"];
                    rw["FechaModificacion"] = ht_fila["FechaModificacion"];
                    rw["Accion"] = ht_fila["Accion"];
                    rw["Version"] = ht_fila["Version"];
                    rw["ApellidoPaterno"] = ht_fila["ApellidoPaterno"];
                    rw["ApellidoMaterno"] = ht_fila["ApellidoMaterno"];
                    rw["Nombres"] = ht_fila["Nombres"];
                    rw["NombreCompleto"] = ht_fila["NombreCompleto"];
                    rw["Busqueda"] = ht_fila["Busqueda"];
                    rw["TipoDocumento"] = ht_fila["TipoDocumento"];
                    rw["Documento"] = ht_fila["Documento"];
                    rw["FechaNacimiento"] = ht_fila["FechaNacimiento"];
                    rw["Sexo"] = ht_fila["Sexo"];
                    rw["EstadoCivil"] = ht_fila["EstadoCivil"];
                    rw["PersonaEdad"] = ht_fila["PersonaEdad"];
                    rw["IdOrdenAtencion"] = ht_fila["IdOrdenAtencion"];
                    rw["CodigoOA"] = ht_fila["CodigoOA"];
                    rw["LineaOrdenAtencion"] = ht_fila["LineaOrdenAtencion"];
                    rw["TipoOrdenAtencion"] = ht_fila["TipoOrdenAtencion"];
                    rw["TipoAtencion"] = ht_fila["TipoAtencion"];
                    rw["TipoTrabajador"] = ht_fila["TipoTrabajador"];
                    rw["IdEstablecimientoSalud"] = ht_fila["IdEstablecimientoSalud"];
                    rw["IdUnidadServicio"] = ht_fila["IdUnidadServicio"];
                    rw["FechaRegistro"] = ht_fila["FechaRegistro"];
                    rw["FechaAtencion"] = ht_fila["FechaAtencion"];
                    rw["IdEspecialidad"] = ht_fila["IdEspecialidad"];
                    rw["IdTipoOrden"] = ht_fila["IdTipoOrden"];
                    rw["estadoEpiAtencion"] = ht_fila["estadoEpiAtencion"];
                    rw["ObservacionProximaEpiAtencion"] = ht_fila["ObservacionProximaEpiAtencion"];
                    rw["TipoAtencionDesc"] = ht_fila["TipoAtencionDesc"];
                    rw["TipoTrabajadorDesc"] = ht_fila["TipoTrabajadorDesc"];
                    rw["EstablecimientoCodigo"] = ht_fila["EstablecimientoCodigo"];
                    rw["EstablecimientoDesc"] = ht_fila["EstablecimientoDesc"];
                    rw["UnidadServicioCodigo"] = ht_fila["UnidadServicioCodigo"];
                    rw["UnidadServicioDesc"] = ht_fila["UnidadServicioDesc"];
                    rw["NombreCompletoPerSalud"] = ht_fila["NombreCompletoPerSalud"];
                    rw["CMP"] = ht_fila["CMP"];
                    rw["CodigoHC"] = ht_fila["CodigoHC"];
                    rw["Cama"] = ENTITY_GLOBAL.Instance.CAMA;


                    listarptVistasRetiroVoluntario_FE2.Rows.Add(rw);

                }


                if (listarptVistasRetiroVoluntario_FE2.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0043, FOMR_VACIO);
                    formatos = formatos + FORMFE_0043 + "-";
                }
            }
            //LISTADO FORMFE_0044

            DataTable listarptVistasFuncionesVitales_FE = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_0044))
            {
                listarptVistasFuncionesVitales_FE = rptVistas_FE("rptViewFuncionesVitales_FE", unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                            null, 0, FORMFE_0044, usuarioActual);


                if (listarptVistasFuncionesVitales_FE.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0044, FOMR_VACIO);
                    formatos = formatos + FORMFE_0044 + "-";
                }
            }

            //LISTADO FORMFE_0045

            DataTable listarptVistasEnfermedadActual_FE = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_0045))
            {
                listarptVistasEnfermedadActual_FE = rptVistas_FE("rptViewEnfermedadActual_FE", unidadReplicacion, idPaciente, episodioClinico, idEpisodioAtencion,
                            null, 0, FORMFE_0045, usuarioActual);


                if (listarptVistasEnfermedadActual_FE.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0045, FOMR_VACIO);
                    formatos = formatos + FORMFE_0045 + "-";
                }
            }


            #endregion

            /**ADD DATOS GENERALES DEL REPORTES EN 'ListrptViewAgrupador'*/
            //OBS: AUX TipoEpisodio:  usado para la fórmula de mostrar o no un subreporte de acuerdo al FORMATO que contenga
            objEntidad.TipoEpisodio = formatos;

            ListrptViewAgrupador.Add(objEntidad);
            Rpt.DataSourceConnections.Clear();
            Rpt.SetDataSource(ListrptViewAgrupador);
            /********************************/

            int cantidadSubReport = Rpt.Subreports.Count;

            try
            {
                if (cantidadSubReport > 0)
                {

                    #region FORMULARIOEXTRAS_SETDATASOURCE

                    //ADD FORMFE_330 (ok)
                    if (listaRPTInformeConsultaExterna.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewInformeConsultaExterna_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewInformeConsultaExterna_FEsubrep.rpt"].SetDataSource(listaRPTInformeConsultaExterna);
                    }

                    //ADD FORMFE_0001 (ok)
                    if (listaRPTInmunizacionNinio.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewInmunizacionNinio_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewInmunizacionNinio_FEsubrep.rpt"].SetDataSource(listaRPTInmunizacionNinio);
                    }


                    //ADD FORMFE_0002
                    if (listaRPTInmunizacionAdulto.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewInmunizacionAdultoRep_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewInmunizacionAdultoRep_FEsubrep.rpt"].SetDataSource(listaRPTInmunizacionAdulto);
                    }

                    //ADD FORMFE_0003
                    if (listaRPTrptViewAntPerFisiologico_FE.Count > 0)
                    {
                        Rpt.Subreports["rptViewAntecedentesPersonalesFisiologicos_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewAntecedentesPersonalesFisiologicos_FEsubrep.rpt"].SetDataSource(listaRPTrptViewAntPerFisiologico_FE);
                    }

                    //ADD FORMFE_0004
                    if (listaRPTrptViewAntFisiologicoPediatrico_FE.Count > 0)
                    {
                        Rpt.Subreports["rptViewAntFisiologicoPediatricoFEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewAntFisiologicoPediatricoFEsubrep.rpt"].SetDataSource(listaRPTrptViewAntFisiologicoPediatrico_FE);
                    }

                    //ADD FORMFE_0006GENERALES
                    if (listaRPTrptAntGenerales_FE.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewAntecedentesPersonalesPatologicosGenerales_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewAntecedentesPersonalesPatologicosGenerales_FEsubrep.rpt"].SetDataSource(listaRPTrptAntGenerales_FE);
                    }
                    if (listaRPTrptAntGeneralesDetalle_FE.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewAntecedentesPatologicosGeneralesdetalle.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewAntecedentesPatologicosGeneralesdetalle.rpt"].SetDataSource(listaRPTrptAntGeneralesDetalle_FE);
                    }


                    //ADD FORMFE_0005GINECO
                    if (listaRPTrptGiencObstetrico.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewAntecedentesPersGinecObstetrico_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewAntecedentesPersGinecObstetrico_FEsubrep.rpt"].SetDataSource(listaRPTrptGiencObstetrico);
                    }
                    if (listaRPTrptGiencObstetricoDetalle.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewAntecedentesPersGinecObstetricodetalle.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewAntecedentesPersGinecObstetricodetalle.rpt"].SetDataSource(listaRPTrptGiencObstetricoDetalle);
                    }



                    //ADD FORMFE_0006 (ok)
                    if (listarptViewAlergias_FE.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewAlergia_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewAlergia_FEsubrep.rpt"].SetDataSource(listarptViewAlergias_FE);
                    }



                    //ADD FORMFE_0007
                    if (listarptAnt_Familiares.Count > 0)
                    {
                        Rpt.Subreports["rptViewAnamnesis_ANTFAM_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewAnamnesis_ANTFAM_FEsubrep.rpt"].SetDataSource(listarptAnt_Familiares);
                    }

                    //ADD FORMFE_0008
                    if (listarptView_ValoracionFuncionalAM_FE.Count > 0)
                    {
                        Rpt.Subreports["rptView_ValoracionFuncionalAM_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptView_ValoracionFuncionalAM_FEsubrep.rpt"].SetDataSource(listarptView_ValoracionFuncionalAM_FE);
                    }

                    //ADD FORMFE_0009
                    if (listarptViewValoracionMentalAM_FE.Count > 0)
                    {
                        Rpt.Subreports["rptViewValoracionMentalAM_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewValoracionMentalAM_FEsubrep.rpt"].SetDataSource(listarptViewValoracionMentalAM_FE);
                    }

                    //ADD FORMFE_0010
                    if (listaRPTrptViewValoracionSocioFamAM_FE.Count > 0)
                    {
                        Rpt.Subreports["rptViewValoracionSocioFamAM_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewValoracionSocioFamAM_FEsubrep.rpt"].SetDataSource(listaRPTrptViewValoracionSocioFamAM_FE);
                    }


                    //ADD FORMFE_0011
                    if (listaRPTrptViewValoracionAM_FE.Count > 0)
                    {
                        Rpt.Subreports["rptViewValoracionAM_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewValoracionAM_FEsubrep.rpt"].SetDataSource(listaRPTrptViewValoracionAM_FE);
                    }

                    //ADD FORMFE_0012 (ok)
                    if (listaRPTrptViewDiagnostico_FE.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewDiagnostico_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewDiagnostico_FEsubrep.rpt"].SetDataSource(listaRPTrptViewDiagnostico_FE);
                    }

                    //ADD FORMFE_0013
                    if (listaRPTrptViewExamenApoyo_FE.Count > 0)
                    {
                        Rpt.Subreports["ptViewExamenApoyo_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["ptViewExamenApoyo_FEsubrep.rpt"].SetDataSource(listaRPTrptViewExamenApoyo_FE);
                    }


                    //ADD FORMFE_0014  
                    if (listaRPTrptViewInterconsulta_FE.Count > 0)
                    {
                        Rpt.Subreports["rptViewInterconsulta_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewInterconsulta_FEsubrep.rpt"].SetDataSource(listaRPTrptViewInterconsulta_FE);
                    }

                    //ADD FORMFE_0015       
                    if (listaRPTrptViewProximaAtencion_FE.Count > 0)
                    {
                        Rpt.Subreports["rptViewProximaAtencion_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewProximaAtencion_FEsubrep.rpt"].SetDataSource(listaRPTrptViewProximaAtencion_FE);
                    }

                    //ADD FORMFE_0016             
                    if (listaRPTApoyoDiagnostico.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewApoyoDiagnosticoRep_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewApoyoDiagnosticoRep_FEsubrep.rpt"].SetDataSource(listaRPTApoyoDiagnostico);
                    }
                    //ADD FORMFE_0017

                    //ADD FORMFE_0018    
                    if (listaRPTrptViewDieta1_FE.Count > 0 || listaRPTrptViewDieta2_FE.Count > 0)
                    {

                        if (listaRPTrptViewDieta1_FE.Count == 0) // Argega Cabecera de 
                        {
                            DataTable listaRPT = new DataTable();
                            listaRPT = rptVistas_FE("rptViewDieta_FE",
                            ENTITY_GLOBAL.Instance.UnidadReplicacion,
                            (int)ENTITY_GLOBAL.Instance.PacienteID,
                            (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                            (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                            , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                            ENTITY_GLOBAL.Instance.USUARIO);

                            Rpt.Subreports["rptViewDieta_FEDetalle1.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewDieta_FEDetalle1.rpt"].SetDataSource(listaRPT);

                        }
                        else
                        {

                            Rpt.Subreports["rptViewDieta_FEDetalle1.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewDieta_FEDetalle1.rpt"].SetDataSource(listaRPTrptViewDieta1_FE);

                        }


                        Rpt.Subreports["rptViewDieta_FEDetalle2.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewDieta_FEDetalle2.rpt"].SetDataSource(listaRPTrptViewDieta2_FE);
                    }

                    if (listaRPTPac_DIE.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewDietaSupFirma.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewDietaSupFirma.rpt"].SetDataSource(listaRPTPac_DIE);
                    }


                    //ADD FORMFE_0019  (ok)    
                    //if (listaRPTrptViewMedicamentos1_FE.Count > 0 || listaRPTrptViewMedicamentos2_FE.Count > 0)
                    //{
                    //    Rpt.Subreports["rptViewMedicamentos_FEsubrep.rpt"].DataSourceConnections.Clear();
                    //    Rpt.Subreports["rptViewMedicamentos_FEsubrep.rpt"].SetDataSource(listaRPTrptViewMedicamentos1_FE);
                    ////}
                    ////if (listaRPTrptViewMedicamentos2_FE.Count > 0)
                    ////{
                    //    Rpt.Subreports["rptViewMedicamentos_FEsubrep2.rpt"].DataSourceConnections.Clear();
                    //    Rpt.Subreports["rptViewMedicamentos_FEsubrep2.rpt"].SetDataSource(listaRPTrptViewMedicamentos2_FE);

                    //}
                    if (listaRPTrptViewMedicamentos1_FE.Count > 0 || listaRPTrptViewMedicamentos2_FE.Count > 0)
                    {
                        if (listaRPTrptViewMedicamentos1_FE.Count == 0) // Argega Cabecera de 
                        {
                            DataTable listaRPT = new DataTable();
                            listaRPT = rptVistas_FE("rptViewMedicamentos_FE",
                          ENTITY_GLOBAL.Instance.UnidadReplicacion,
                          (int)ENTITY_GLOBAL.Instance.PacienteID,
                          (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                          (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                          , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                          ENTITY_GLOBAL.Instance.USUARIO);


                            Rpt.Subreports["rptViewMedicamentos_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewMedicamentos_FEsubrep.rpt"].SetDataSource(listaRPT);

                        }
                        else
                        {
                            Rpt.Subreports["rptViewMedicamentos_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewMedicamentos_FEsubrep.rpt"].SetDataSource(listaRPTrptViewMedicamentos1_FE);

                        }

                        Rpt.Subreports["rptViewMedicamentos_FEsubrep2.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewMedicamentos_FEsubrep2.rpt"].SetDataSource(listaRPTrptViewMedicamentos2_FE);



                    }



                    if (listaRPTPac_Med.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewMedicamentos_FEsubrepFirmas.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewMedicamentos_FEsubrepFirmas.rpt"].SetDataSource(listaRPTPac_Med);
                    }
                    //ADD FORMFE_0020     (ok)
                    if (listaRPTrptViewDescansoMedicoFE.Count > 0)
                    {
                        Rpt.Subreports["rptViewEmitirDescansoMedicoFEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewEmitirDescansoMedicoFEsubrep.rpt"].SetDataSource(listaRPTrptViewDescansoMedicoFE);
                    }
                    //ADD FORMFE_0021  
                    if (listaRPTrptViewEvolucionMedica_FE.Count > 0)
                    {
                        try
                        {
                            Rpt.Subreports["rptViewEvolucionMedica_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewEvolucionMedica_FEsubrep.rpt"].SetDataSource(listaRPTrptViewEvolucionMedica_FE);

                        }
                        catch (Exception)
                        {
                            Response.Write("<script language=javascript>alert('No se encuentra el subreporte rptViewEvolucionMedica_FEsubrep');</script>");
                            //throw;
                        }
                    }

                    #endregion

                    #region FORMULARIOFED_SETDATASOURCE_ADJUNTO

                    //ADD FORMFE_0038     



                    //ADD FORMFE_0038     

                    //ADD FORMFE_0040     

                    //ADD FORMFE_0041  
                    if (listarptVistasStewart_FE.Count > 0)
                    {
                        try
                        {
                            Rpt.Subreports["rptViewEscalaStewart_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewEscalaStewart_FEsubrep.rpt"].SetDataSource(listarptVistasStewart_FE);

                        }
                        catch (Exception)
                        {

                            //Response.Write("<script language=javascript>alert('No se encuentra el subreporte rptViewEscalaStewart_FEsubrep');</script>");
                            //throw;
                        }
                    }

                    //ADD FORMFE_0042
                    if (listarptVistasRamsay_FE.Rows.Count > 0)
                    {
                        try
                        {
                            Rpt.Subreports["rptViewEscalaRamsay_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewEscalaRamsay_FEsubrep.rpt"].SetDataSource(listarptVistasRamsay_FE);
                        }
                        catch (Exception)
                        {
                        }

                    }

                    //ADD FORMFE_0043
                    if (listarptVistasRetiroVoluntario_FE2.Rows.Count > 0)
                    {
                        try
                        {
                            Rpt.Subreports["rptViewRetiroVoluntario_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewRetiroVoluntario_FEsubrep.rpt"].SetDataSource(listarptVistasRetiroVoluntario_FE2);

                        }
                        catch (Exception)
                        {
                        }
                    }

                    //ADD FORMFE_0044
                    if (listarptVistasFuncionesVitales_FE.Rows.Count > 0)
                    {
                        try
                        {
                            Rpt.Subreports["rptViewFuncionesVitale_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewFuncionesVitale_FEsubrep.rpt"].SetDataSource(listarptVistasFuncionesVitales_FE);

                        }
                        catch (Exception)
                        {
                        }
                    }

                    //ADD FORMFE_0045
                    if (listarptVistasEnfermedadActual_FE.Rows.Count > 0)
                    {
                        try
                        {
                            Rpt.Subreports["rptViewEnfermedadActual_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewEnfermedadActual_FEsubrep.rpt"].SetDataSource(listarptVistasEnfermedadActual_FE);

                        }
                        catch (Exception)
                        {
                        }
                    }


                    ////ADD FORMFE_0005
                    //if (listarptVistasPerGinecObstetrico_FE.Rows.Count > 0)
                    //{
                    //    try
                    //    {
                    //        Rpt.Subreports["rptViewAntecedentesPersGinecObstetrico_FEsubrep.rpt"].DataSourceConnections.Clear();
                    //        Rpt.Subreports["rptViewAntecedentesPersGinecObstetrico_FEsubrep.rpt"].SetDataSource(listarptVistasPerGinecObstetrico_FE);

                    //    }
                    //    catch (Exception)
                    //    {
                    //    }
                    //}

                    #endregion

                }
            }
            catch (Exception ex)
            {
                Log.Error(ex, ex.Message);
                throw;
            }

            /**ADD PARÁMETROS*/
            #region FORMULARIOINICALES_SETPARAMETER
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            imgFirma = Server.MapPath((string)Session["FIRMA_DIGITAL"]);
            Rpt.SetParameterValue("imgFirma", imgFirma);

            Rpt.SetParameterValue("FORM_0000", FORM_0000);
            Rpt.SetParameterValue("FORM_0001", FORM_0001);
            Rpt.SetParameterValue("FORM_0002", FORM_0002);
            Rpt.SetParameterValue("FORM_0003", FORM_0003);
            Rpt.SetParameterValue("FORM_0004", FORM_0004);
            Rpt.SetParameterValue("FORM_0005", FORM_0005);
            Rpt.SetParameterValue("FORM_0006", FORM_0006);
            Rpt.SetParameterValue("FORM_0007", FORM_0007);
            Rpt.SetParameterValue("FORM_0008", FORM_0008);
            Rpt.SetParameterValue("FORM_0009", FORM_0009);
            Rpt.SetParameterValue("FORM_0010", FORM_0010);
            Rpt.SetParameterValue("FORM_0011", FORM_0011);
            Rpt.SetParameterValue("FORM_0012", FORM_0012);
            #endregion

            #region FORMULARIOEXTRAS_SETPARAMETER

            Rpt.SetParameterValue("FORMFE_0001", FORMFE_0001);
            Rpt.SetParameterValue("FORMFE_0002", FORMFE_0002);
            Rpt.SetParameterValue("FORMFE_0003", FORMFE_0003);
            Rpt.SetParameterValue("FORMFE_0004", FORMFE_0004);
            Rpt.SetParameterValue("FORMFE_0005CABGINECO", FORMFE_0005CABGINECO);
            Rpt.SetParameterValue("FORMFE_0005DETGINECO", FORMFE_0005DETGINECO);
            Rpt.SetParameterValue("FORMFE_330", FORMFE_330);
            Rpt.SetParameterValue("FORMFE_600", FORMFE_600);
            Rpt.SetParameterValue("FORMFE_600_1", FORMFE_600_1);
            Rpt.SetParameterValue("FORMFE_600_2", FORMFE_600_2);
            Rpt.SetParameterValue("FORMFE_600_3", FORMFE_600_3);
            Rpt.SetParameterValue("FORMFE_600_4", FORMFE_600_4);


            Rpt.SetParameterValue("FORMFE_327CAB", FORMFE_327CAB);
            Rpt.SetParameterValue("FORMFE_327CAB2", FORMFE_327CAB2);
            Rpt.SetParameterValue("FORMFE_327CAB3", FORMFE_327CAB3);
            Rpt.SetParameterValue("FORMFE_327DIAG", FORMFE_327DIAG);
            Rpt.SetParameterValue("FORMFE_327CIRUGIAPRO", FORMFE_327CIRUGIAPRO);
            Rpt.SetParameterValue("FORMFE_327EXAMEN1", FORMFE_327EXAMEN1);
            Rpt.SetParameterValue("FORMFE_327EXAMEN2", FORMFE_327EXAMEN2);
            Rpt.SetParameterValue("FORMFE_327EXAMEN3", FORMFE_327EXAMEN3);

            //NOTA DE INGRESO
            Rpt.SetParameterValue("FORMFE_319CAB1", FORMFE_319CAB1);
            Rpt.SetParameterValue("FORMFE_319CAB2", FORMFE_319CAB2);
            Rpt.SetParameterValue("FORMFE_319CAB3", FORMFE_319CAB3);
            Rpt.SetParameterValue("FORMFE_319DIAG", FORMFE_319DIAG);
            Rpt.SetParameterValue("FORMFE_319EXAMEN1", FORMFE_319EXAMEN1);

            //NOTA DE TOCOLOSIS
            Rpt.SetParameterValue("FORMFE_502TOCOLOSIS", FORMFE_502TOCOLOSIS);

            Rpt.SetParameterValue("FORMFE_402CABHELECT1", FORMFE_402CABHELECT1);
            Rpt.SetParameterValue("FORMFE_402CABHELECT2", FORMFE_402CABHELECT2);
            Rpt.SetParameterValue("FORMFE_402CABHELECT3", FORMFE_402CABHELECT3);
            Rpt.SetParameterValue("FORMFE_402DETHELECT1", FORMFE_402DETHELECT1);
            Rpt.SetParameterValue("FORMFE_402DETHELECT2", FORMFE_402DETHELECT2);


            Rpt.SetParameterValue("FORMFE_401CABHELECT1", FORMFE_401CABHELECT1);
            Rpt.SetParameterValue("FORMFE_401CABHELECT2", FORMFE_401CABHELECT2);
            Rpt.SetParameterValue("FORMFE_401CABHELECT3", FORMFE_401CABHELECT3);
            Rpt.SetParameterValue("FORMFE_401DETHELECT1", FORMFE_401DETHELECT1);
            Rpt.SetParameterValue("FORMFE_401DETHELECT2", FORMFE_401DETHELECT2);


            Rpt.SetParameterValue("FORMFE_302CABHOJA", FORMFE_302CABHOJA);
            Rpt.SetParameterValue("FORMFE_302DETHOJA", FORMFE_302DETHOJA);

            Rpt.SetParameterValue("FORMFE_461CIRUENTRADA", FORMFE_461CIRUENTRADA);

            Rpt.SetParameterValue("FORMFE_462CIRUPAUSA", FORMFE_462CIRUPAUSA);
            Rpt.SetParameterValue("FORMFE_463CIRUSALIDA", FORMFE_463CIRUSALIDA);

            Rpt.SetParameterValue("FORMFE_464", FORMFE_464);


            Rpt.SetParameterValue("FORMFE_323_3CAB_ANESTESIA3", FORMFE_323_3CAB_ANESTESIA3);

            Rpt.SetParameterValue("FORMFE_323_1CABANESTESIA", FORMFE_323_1CABANESTESIA);
            Rpt.SetParameterValue("FORMFE_323_1CABANESTESIA2", FORMFE_323_1CABANESTESIA2);
            Rpt.SetParameterValue("FORMFE_323_1DET1_ANESTESIA", FORMFE_323_1DET1_ANESTESIA);



            Rpt.SetParameterValue("FORMFE_323_1DET1_ANESDIAG1", FORMFE_323_1DET1_ANESDIAG1);
            Rpt.SetParameterValue("FORMFE_323_1DET1_ANESEXAM2", FORMFE_323_1DET1_ANESEXAM2);
            Rpt.SetParameterValue("FORMFE_323_1DET1_ANESDIAG2", FORMFE_323_1DET1_ANESDIAG2);
            Rpt.SetParameterValue("FORMFE_323_1DET1_ANESEXAM3", FORMFE_323_1DET1_ANESEXAM3);
            Rpt.SetParameterValue("FORMFE_323_1CABANESTESIA3", FORMFE_323_1CABANESTESIA3);



            Rpt.SetParameterValue("FORMFE_0005CAB", FORMFE_0005CAB);
            Rpt.SetParameterValue("FORMFE_153", FORMFE_153);

            Rpt.SetParameterValue("FORMFE_328", FORMFE_328);

            Rpt.SetParameterValue("FORMFE_103", FORMFE_103);



            Rpt.SetParameterValue("FORMFE_510", FORMFE_510);
            Rpt.SetParameterValue("FORMFE_202", FORMFE_202);


            Rpt.SetParameterValue("FORMFE_0005DET", FORMFE_0005DET);
            Rpt.SetParameterValue("FORMFE_0006", FORMFE_0006);
            Rpt.SetParameterValue("FORMFE_0007", FORMFE_0007);
            Rpt.SetParameterValue("FORMFE_0008", FORMFE_0008);
            Rpt.SetParameterValue("FORMFE_0009", FORMFE_0009);
            Rpt.SetParameterValue("FORMFE_0010", FORMFE_0010);
            Rpt.SetParameterValue("FORMFE_0011", FORMFE_0011);
            Rpt.SetParameterValue("FORMFE_0012", FORMFE_0012);
            Rpt.SetParameterValue("FORMFE_0013", FORMFE_0013);
            Rpt.SetParameterValue("FORMFE_0014", FORMFE_0014);
            Rpt.SetParameterValue("FORMFE_0015", FORMFE_0015);
            Rpt.SetParameterValue("FORMFE_0016", FORMFE_0016);
            Rpt.SetParameterValue("FORMFE_0017", FORMFE_0017);
            Rpt.SetParameterValue("FORMFE_0018DET1", FORMFE_0018DET1);
            Rpt.SetParameterValue("FORMFE_0018DET2", FORMFE_0018DET2);

            Rpt.SetParameterValue("FORMFE_0018DET3", FORMFE_0018DET3);

            Rpt.SetParameterValue("FORMFE_0019", FORMFE_0019);
            Rpt.SetParameterValue("FORMFE_0019GRUPAL", FORMFE_0019GRUPAL);
            Rpt.SetParameterValue("FORMFE_0019DET1", FORMFE_0019DET1);
            Rpt.SetParameterValue("FORMFE_0019DET2", FORMFE_0019DET2);
            Rpt.SetParameterValue("FORMFE_0019DET3", FORMFE_0019DET3);
            Rpt.SetParameterValue("FORMFE_0020", FORMFE_0020);
            Rpt.SetParameterValue("FORMFE_0021", FORMFE_0021);


            Rpt.SetParameterValue("FORMFE_519", FORMFE_519);
            Rpt.SetParameterValue("FORMFE_519_2", FORMFE_519_2);
            Rpt.SetParameterValue("FORMFE_519_3", FORMFE_519_3);
            Rpt.SetParameterValue("FORMFE_519_4", FORMFE_519_4);
            Rpt.SetParameterValue("FORMFE_519_5", FORMFE_519_5);


            #endregion

            #region FORMULARIOFED_SETPARAMETER
            Rpt.SetParameterValue("FORMFE_0038", FORMFE_0038);
            Rpt.SetParameterValue("FORMFE_0039", FORMFE_0039);
            Rpt.SetParameterValue("FORMFE_0040", FORMFE_0040);
            Rpt.SetParameterValue("FORMFE_0041", FORMFE_0041);
            Rpt.SetParameterValue("FORMFE_0042", FORMFE_0042);
            Rpt.SetParameterValue("FORMFE_0043", FORMFE_0043);
            Rpt.SetParameterValue("FORMFE_0044", FORMFE_0044);
            Rpt.SetParameterValue("FORMFE_0045", FORMFE_0045);


            //Rpt.SetParameterValue("FORMFE_0111", FORMFE_0111);
            #endregion

            /******************/

            if (!existeDataHC)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.SetParameterValue("imgFirma", imgFirma);


                        Rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "EXAMEN");
                    }
                    catch (Exception ex)
                    {
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                    Rpt.SetParameterValue("imgFirma", imgFirma);

                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetParameterValue("imgFirma", imgFirma);


        }

        private void DatosGenerales()
        {
            Log.Information("VisorReportesHCE - DatosGenerales - Entrar");

            /**LISTAR DATOS GENERALES DEL REPORTES EN 'rptViewAgrupador'*/
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit> ListrptViewAgrupador = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit>();
            SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad = new SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit();
            objEntidad.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            objEntidad.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            objEntidad.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            objEntidad.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            Boolean existeDataHC = false;
            List<rptViewAgrupador> ListrptViewAgrupadorOrig = new List<rptViewAgrupador>();
            rptViewAgrupador objEntidadOrig = new rptViewAgrupador();
            objEntidadOrig.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            objEntidadOrig.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            objEntidadOrig.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            objEntidadOrig.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            ListrptViewAgrupadorOrig = ServiceReportes.ReporteViewAgrupador(objEntidadOrig);
            if (ListrptViewAgrupadorOrig.Count > 0)
            {
                existeDataHC = true;

                objEntidad.NombreCompleto = ListrptViewAgrupadorOrig[0].NombreCompleto;
                objEntidad.TipoTrabajadorDesc = ListrptViewAgrupadorOrig[0].TipoTrabajadorDesc;
                objEntidad.ServicioExtra = ListrptViewAgrupadorOrig[0].ServicioExtra;
                objEntidad.Sexo = ListrptViewAgrupadorOrig[0].Sexo;
                objEntidad.CodigoOA = ListrptViewAgrupadorOrig[0].CodigoOA;
                objEntidad.edad = (ListrptViewAgrupadorOrig[0].edad != null ? Convert.ToInt32(ListrptViewAgrupadorOrig[0].edad) : 0);
                objEntidad.UnidadServicioDesc = ListrptViewAgrupadorOrig[0].UnidadServicioDesc;
            }
        }

        private void DatosGenerales1()
        {
            Log.Information("VisorReportesHCE - DatosGenerales1 - Entrar");


            /**LISTAR DATOS GENERALES DEL REPORTES EN 'rptViewAgrupador'*/
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit> ListrptViewAgrupador = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit>();
            SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad = new SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit();
            objEntidad.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            objEntidad.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            objEntidad.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            objEntidad.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            Boolean existeDataHC = false;
            List<rptViewAgrupador> ListrptViewAgrupadorOrig = new List<rptViewAgrupador>();
            rptViewAgrupador objEntidadOrig = new rptViewAgrupador();
            objEntidadOrig.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            objEntidadOrig.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            objEntidadOrig.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            objEntidadOrig.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            ListrptViewAgrupadorOrig = ServiceReportes.ReporteViewAgrupador(objEntidadOrig);
            if (ListrptViewAgrupadorOrig.Count > 0)
            {
                existeDataHC = true;
                objEntidad.NombreCompleto = ListrptViewAgrupadorOrig[0].NombreCompleto;
                objEntidad.TipoTrabajadorDesc = ListrptViewAgrupadorOrig[0].TipoTrabajadorDesc;
                objEntidad.ServicioExtra = ListrptViewAgrupadorOrig[0].ServicioExtra;
                objEntidad.Sexo = ListrptViewAgrupadorOrig[0].Sexo;
                objEntidad.CodigoOA = ListrptViewAgrupadorOrig[0].CodigoOA;
                objEntidad.edad = (ListrptViewAgrupadorOrig[0].edad != null ? Convert.ToInt32(ListrptViewAgrupadorOrig[0].edad) : 0);
                objEntidad.UnidadServicioDesc = ListrptViewAgrupadorOrig[0].UnidadServicioDesc;
            }
            if (ListrptViewAgrupadorOrig.Count > 0)
            {
                Rpt.Subreports["DatosGeneralesFE.rpt"].DataSourceConnections.Clear();
                Rpt.Subreports["DatosGeneralesFE.rpt"].SetDataSource(ListrptViewAgrupadorOrig);
            }


        }


        public static void LOGgineco(object obj, Exception ex)
        {
            Log.Information("VisorReportesHCE - LOGgineco - Entrar");

            string fecha = System.DateTime.Now.ToString("yyyyMMdd");
            string hora = System.DateTime.Now.ToString("HH:mm:ss");
            //string path = HttpContext.Current.Request.MapPath("~/log/" + fecha + ".txt");

            string path = System.Web.HttpContext.Current.Request.MapPath("~/log/" + fecha + ".txt");

            StreamWriter sw = new StreamWriter(path, true);

            StackTrace stacktrace = new StackTrace();
            sw.WriteLine(obj.GetType().FullName + " " + hora);
            sw.WriteLine(stacktrace.GetFrame(1).GetMethod().Name + " - " + ex.Message);
            sw.WriteLine("");

            sw.Flush();
            sw.Close();
        }

        /*******************************************************   TOTAL HCE ******************************************************************/
        private void GenerarReporterptViewTotalHCE(String tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewTotalHCE - Entrar");
            string ruta = Server.MapPath("rptReports/ViewAdjuntos.rpt");
            Rpt.Load(Server.MapPath("rptReports/ViewAdjuntos.rpt"));
            #region AgrupadorReporte

            ///**LISTAR DATOS GENERALES DEL REPORTES EN 'rptViewAgrupador'*/
            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit> ListrptViewAgrupador = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit>();
            //SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad = new SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit();
            //objEntidad.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            //objEntidad.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            //objEntidad.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            //objEntidad.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            //Boolean existeDataHC = false;
            //List<rptViewAgrupador> ListrptViewAgrupadorOrig = new List<rptViewAgrupador>();

            //rptViewAgrupador objEntidadOrig = new rptViewAgrupador();
            //objEntidadOrig.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            //objEntidadOrig.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            //objEntidadOrig.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            ////if (ENTITY_GLOBAL.Instance.INDICADOR_EMER == "MED_EMERGENCIA") { objEntidadOrig.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion; ; } else { }
            ///* objEntidadOrig.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;*/
            //objEntidadOrig.EpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            //ListrptViewAgrupadorOrig = ServiceReportes.ReporteViewAgrupador(objEntidadOrig);

            //if (ListrptViewAgrupadorOrig.Count > 0)
            //{
            //    existeDataHC = true;
            //    objEntidad.NombreCompleto = ListrptViewAgrupadorOrig[0].NombreCompleto;
            //    objEntidad.TipoTrabajadorDesc = ListrptViewAgrupadorOrig[0].TipoTrabajadorDesc;
            //    objEntidad.ServicioExtra = ListrptViewAgrupadorOrig[0].ServicioExtra;
            //    objEntidad.Sexo = ListrptViewAgrupadorOrig[0].Sexo;
            //    objEntidad.CodigoOA = ListrptViewAgrupadorOrig[0].CodigoOA;
            //    objEntidad.edad = (ListrptViewAgrupadorOrig[0].edad != null ? Convert.ToInt32(ListrptViewAgrupadorOrig[0].edad) : 0);
            //    objEntidad.UnidadServicioDesc = ListrptViewAgrupadorOrig[0].UnidadServicioDesc;
            //} if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "TRIAJE")
            //{
            //    DataTable listarptAgrupador2_FE = new DataTable();
            //    listarptAgrupador2_FE = rptAgrupador_TRIAJE_FE("rptViewAgrupadorTriaje", ENTITY_GLOBAL.Instance.UnidadReplicacion,
            //     (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioTriaje,
            //         (int)ENTITY_GLOBAL.Instance.EpisodioTriaje,
            //             null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            //    if (listarptAgrupador2_FE.Rows.Count > 0)
            //    {
            //        existeDataHC = true;
            //        objEntidad.NombreCompleto = listarptAgrupador2_FE.Rows[0]["NombreCompleto"].ToString();
            //        objEntidad.TipoTrabajadorDesc = "Triaje";
            //        objEntidad.ServicioExtra = listarptAgrupador2_FE.Rows[0]["ServicioExtra"].ToString();
            //        objEntidad.Sexo = listarptAgrupador2_FE.Rows[0]["Sexo"].ToString();
            //        objEntidad.CodigoOA = listarptAgrupador2_FE.Rows[0]["CodigoOA"].ToString();
            //        objEntidad.edad = (listarptAgrupador2_FE.Rows[0]["Edad"].ToString() != null ? Convert.ToInt32(listarptAgrupador2_FE.Rows[0]["Edad"].ToString()) : 0);
            //        objEntidad.UnidadServicioDesc ="Triaje de Emergencia";
            //        objEntidad.ServicioExtra =Convert.ToString(Session["NOMBRE_MEDICO"]);
            //    }
            //}

            ///**LISTAR DATOS GENERALES DEL REPORTES EN 'rptViewAgrupador'*/

            Boolean existeDataHC = false;
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit> ListrptViewAgrupador = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit>();
            SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad = new SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit();

            DataTable listarptAgrupador_FE = new DataTable();
            if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "TRIAJE")
            {
                listarptAgrupador_FE = rptAgrupador_TRIAJE_FE("rptViewAgrupadorTriaje", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                         (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioTriaje,
                         (int)ENTITY_GLOBAL.Instance.EpisodioTriaje,
                         null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
                objEntidad.TipoTrabajadorDesc = "Triaje";
                objEntidad.UnidadServicioDesc = "Triaje de Emergencia";
                objEntidad.ServicioExtra = Convert.ToString(Session["NOMBRE_MEDICO"]);
                existeDataHC = true;
            }
            else
            {
                listarptAgrupador_FE = rptAgrupador_FE("rptViewAgrupador", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                         (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                         (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                         null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
                objEntidad.ServicioExtra = listarptAgrupador_FE.Rows[0]["ServicioExtra"].ToString();//ListrptViewAgrupadorOrig[0].ServicioExtra;
                objEntidad.UnidadServicioDesc = listarptAgrupador_FE.Rows[0]["UnidadServicioDesc"].ToString();//ListrptViewAgrupadorOrig[0].UnidadServicioDesc;
                objEntidad.TipoTrabajadorDesc = listarptAgrupador_FE.Rows[0]["TipoTrabajadorDesc"].ToString();//listarptAgrupador_FE.Rows[0].TipoTrabajadorDesc;
            }

            objEntidad.NombreCompleto = listarptAgrupador_FE.Rows[0]["NombreCompleto"].ToString();//.NombreCompleto;
            objEntidad.ServicioExtra = listarptAgrupador_FE.Rows[0]["ServicioExtra"].ToString();//listarptAgrupador_FE[0].ServicioExtra;
            objEntidad.Sexo = listarptAgrupador_FE.Rows[0]["Sexo"].ToString();//listarptAgrupador_FE[0].Sexo;
            objEntidad.CodigoOA = listarptAgrupador_FE.Rows[0]["CodigoOA"].ToString();//listarptAgrupador_FE[0].CodigoOA;
            if (!string.IsNullOrEmpty(listarptAgrupador_FE.Rows[0]["NombreCompleto"].ToString()))
            {
                objEntidad.edad = Convert.ToInt32(listarptAgrupador_FE.Rows[0]["edad"].ToString());  //(listarptAgrupador_FE[0].edad != null ? Convert.ToInt32(listarptAgrupador_FE[0].edad) : 0);
            }
            else
            {
                objEntidad.edad = 0;
            }

            /************LISTAR DATA DE CADA SUBREPORTE (DESCARTAR LISTADOS DE ACUERDO A PARAM de FORMATOS)***********************/

            string FOMR_VACIO = "000";
            string formatos = FOMR_VACIO + "-";
            string formatosRecibidos = null;
            formatosRecibidos = formatos;
            //PARA EL REGSITRO DE AUDITORÍA
            int idImpresionLog = setDataImpresionAuditoria("HEADER", 0, objEntidad, null, ENTITY_GLOBAL.Instance.USUARIO);

            DataTable listarV_EpisodioAtencion = new DataTable();
            if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "TRIAJE")
            {
                listarV_EpisodioAtencion = rptV_EpisodioAtencionesTriaje("V_EpisodioAtenciones", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                         (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioTriaje
                         );
            }
            else
            {
                listarV_EpisodioAtencion = rptV_EpisodioAtenciones("V_EpisodioAtenciones", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion);
            }
            foreach (DataRow ht_fila in listarV_EpisodioAtencion.AsEnumerable())
            {
                formatosRecibidos += ht_fila["Accion"].ToString() + "-";

            }

            //LISTADO FORM_0000
            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisEAEdit> listaRPTrptViewAnamnesisEAEdit = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisEAEdit>();
            //listaRPTrptViewAnamnesisEAEdit = GrupalReporterptViewAnamnesisEA("MASIVO", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , objEntidad, idImpresionLog, FORM_0000, ENTITY_GLOBAL.Instance.USUARIO);
            //if (listaRPTrptViewAnamnesisEAEdit.Count > 0)
            //{
            //    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
            //    formatos = formatos + FORM_0000 + "-";
            //}

            #endregion

            // FORMULARIO INICIALES
            #region FORMULARIOINICIALES_GETDATA

            //LISTADO FORM_0002
            if (formatosRecibidos.Contains("" + FORM_0002))
            {
                List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenTriajeFisicoEdit> listaRPTrptViewExamenTriajeEdit = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenTriajeFisicoEdit>();
                listaRPTrptViewExamenTriajeEdit = getDatarptViewExamenTriajeFisico("MASIVO", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , objEntidad, idImpresionLog, FORM_0002, ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptViewExamenTriajeEdit.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORM_0002, FOMR_VACIO);
                    formatos = formatos + FORM_0002 + "-";
                }
            }


            //LISTADO FORM_0004
            if (formatosRecibidos.Contains("" + FORM_0004))
            {
                List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenFisicoRegionalEdit> listaRPTrptViewExamenRegionalEdit = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenFisicoRegionalEdit>();
                listaRPTrptViewExamenRegionalEdit = getDatarptViewExamenFisicoRegional("MASIVO", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , objEntidad, idImpresionLog, FORM_0004, ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptViewExamenRegionalEdit.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORM_0004, FOMR_VACIO);
                    formatos = formatos + FORM_0004 + "-";
                }
            }



            //LISTADO FORM_0005
            if (formatosRecibidos.Contains("" + FORM_0005))
            {
                List<SoluccionSalud.RepositoryReport.Entidades.rptViewEvolucionObjetivaEdit> listaRPTrptViewEvolucionObjetivaEdit = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewEvolucionObjetivaEdit>();
                listaRPTrptViewEvolucionObjetivaEdit = getDatarptViewEvolucionObjetiva("MASIVO", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , objEntidad, idImpresionLog, FORM_0005, ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptViewEvolucionObjetivaEdit.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORM_0005, FOMR_VACIO);
                    formatos = formatos + FORM_0005 + "-";
                }
            }

            //LISTADO FORM_0007
            if (formatosRecibidos.Contains("" + FORM_0007))
            {
                List<SoluccionSalud.RepositoryReport.Entidades.rptViewDiagnosticoEdit> listaRPTrptViewDiagnosticoEdit = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewDiagnosticoEdit>();
                listaRPTrptViewDiagnosticoEdit = getDatarptViewDiagnostico("MASIVO", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , objEntidad, idImpresionLog, FORM_0007, ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptViewDiagnosticoEdit.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORM_0007, FOMR_VACIO);
                    formatos = formatos + FORM_0007 + "-";
                }
            }

            //LISTADO FORM_0008
            if (formatosRecibidos.Contains("" + FORM_0008))
            {
                List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisAPEdit> listaRPTrptViewAnamnesisAPEdit = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesisAPEdit>();
                listaRPTrptViewAnamnesisAPEdit = getDatarptViewAnamnesisAP("MASIVO", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , objEntidad, idImpresionLog, FORM_0008, ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptViewAnamnesisAPEdit.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORM_0008, FOMR_VACIO);
                    formatos = formatos + FORM_0008 + "-";
                }
            }

            //LISTADO FORM_0012
            if (formatosRecibidos.Contains("" + FORM_0012))
            {
                List<SoluccionSalud.RepositoryReport.Entidades.rptViewCuidadosPreventivoEdit> listaRPTrptViewCuidadosPreventivo = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewCuidadosPreventivoEdit>();
                listaRPTrptViewCuidadosPreventivo = getDatarptViewCuidadosPreventivo("MASIVO", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , objEntidad, idImpresionLog, FORM_0012, ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptViewCuidadosPreventivo.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORM_0012, FOMR_VACIO);
                    formatos = formatos + FORM_0012 + "-";
                }
            }

            #endregion

            // FORMULARIO EXTRAS
            #region FORMULARIOEXTRAS_GETDATA

            //LISTADO FORMFE_0001

            DataTable listaRPTInmunizacionNinio = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_0001))
            {
                listaRPTInmunizacionNinio = rptVistas_FE("rptViewInmunizacionNinio_FE"
                            , ENTITY_GLOBAL.Instance.UnidadReplicacion
                            , (int)ENTITY_GLOBAL.Instance.PacienteID
                            , (int)ENTITY_GLOBAL.Instance.EpisodioClinico
                            , (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                            , null
                            , 0
                            , ENTITY_GLOBAL.Instance.CONCEPTO
                            , ENTITY_GLOBAL.Instance.USUARIO);

                if (listaRPTInmunizacionNinio.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0001, FOMR_VACIO);
                    formatos = formatos + FORMFE_0001 + "-";
                }
            }


            //LISTADO FORMFE_0002         
            DataTable listaRPTInmunizacionAdulto = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_0002))
            {
                listaRPTInmunizacionAdulto = rptVistas_FE("rptViewInmunizacionAdulto_FE"
                            , ENTITY_GLOBAL.Instance.UnidadReplicacion
                            , (int)ENTITY_GLOBAL.Instance.PacienteID
                            , (int)ENTITY_GLOBAL.Instance.EpisodioClinico
                            , (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                            , null
                            , 0
                            , ENTITY_GLOBAL.Instance.CONCEPTO
                            , ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTInmunizacionAdulto.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0002, FOMR_VACIO);
                    formatos = formatos + FORMFE_0002 + "-";
                }
            }

            //LISTADO FORMFE_0003        
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesFisiologicos_FEEdit> listaRPTrptViewAntPerFisiologico_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesFisiologicos_FEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0003))
            {
                listaRPTrptViewAntPerFisiologico_FE = getDatarptViewAntecedenteFisiologico_FE("MASIVO", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , objEntidad, idImpresionLog, FORMFE_0003, ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptViewAntPerFisiologico_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0003, FOMR_VACIO);
                    formatos = formatos + FORMFE_0003 + "-";
                }
            }

            //LISTADO FORMFE_0004 
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntFisiologicoPediatricoFEEdit> listaRPTrptViewAntFisiologicoPediatrico_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntFisiologicoPediatricoFEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0004))
            {
                listaRPTrptViewAntFisiologicoPediatrico_FE = getDatarptViewAntFisiologicoPediatrico_FE("MASIVO", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , objEntidad, idImpresionLog, FORMFE_0004, ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptViewAntFisiologicoPediatrico_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0004, FOMR_VACIO);
                    formatos = formatos + FORMFE_0004 + "-";
                }
            }

            //LISTADO FORMFE_153

            DataTable listaRPTrptExamenClinico = new DataTable();

            if (formatosRecibidos.Contains("" + FORMFE_153))
            {
                listaRPTrptExamenClinico = rptVistas_FE("rptViewExamenClinico_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptExamenClinico.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_153, FOMR_VACIO);
                    formatos = formatos + FORMFE_153 + "-";
                }
            }

            //LISTADO FORMFE_328

            DataTable listaRPTrptNOTADEENFERMERA = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_328))
            {
                listaRPTrptNOTADEENFERMERA = rptVistasMasivas_FE("rptViewNotaEnfermeriaMasiva_FE"
                                      , ENTITY_GLOBAL.Instance.UnidadReplicacion
                                      , (int)ENTITY_GLOBAL.Instance.PacienteID
                                      , (int)ENTITY_GLOBAL.Instance.EpisodioClinico
                                      , (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                                      , null
                                      , 0
                                      , ENTITY_GLOBAL.Instance.CONCEPTO
                                      , ENTITY_GLOBAL.Instance.USUARIO);

                foreach (DataRow drPrincipal in listaRPTrptNOTADEENFERMERA.AsEnumerable())
                {
                    if (drPrincipal["FirmaDigital"] != null && drPrincipal["FirmaDigital"] != "")
                    {
                        System.IO.FileInfo fi = new System.IO.FileInfo(drPrincipal["FirmaDigital"].ToString().Trim());
                        if (fi.Exists)
                        {
                            byte[] imageBytes;
                            //var NombreServidor = fi.Name;
                            //var rutaServidor = Server.MapPath("../resources/DocumentosAdjuntos/firmas/");
                            //if (!Directory.Exists(rutaServidor))
                            //{
                            //    DirectoryInfo di = Directory.CreateDirectory(rutaServidor);
                            //}
                            //var PathServidor = rutaServidor + NombreServidor;
                            //System.IO.File.Copy(drPrincipal["UsuarioModificacion"].ToString(), PathServidor, true);
                            //var PathOri = "../resources/DocumentosAdjuntos/firmas/" + NombreServidor;
                            imageBytes = System.IO.File.ReadAllBytes(fi.FullName);
                            drPrincipal["CodigoBinario"] = imageBytes;
                        }
                        else
                        {
                            drPrincipal["CodigoBinario"] = "";
                        }

                    }
                }

                //NotaEnfermeriaListar

                // listaRPTrptNOTADEENFERMERA = ConvertToDataTable(Listar);
                if (listaRPTrptNOTADEENFERMERA.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_328, FOMR_VACIO);
                    formatos = formatos + FORMFE_328 + "-";
                }
            }

            //LISTADO FORMFE_103
            DataTable listaRPTrptNOFARMACOLOGICO = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_103))
            {
                var objListaAnt3 = new List<SS_HC_Medicamento_FE>();
                SS_HC_Medicamento_FE objEnt = new SS_HC_Medicamento_FE();
                objEnt.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                objEnt.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                objEnt.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                objEnt.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                objEnt.Accion = "LISTAR_FARMACO";
                objEnt.TipoMedicamento = 1; //para Medicina
                objListaAnt3 = SvcMedicamentoFE.MedicamentoListar(objEnt);
                listaRPTrptNOFARMACOLOGICO = ConvertToDataTable(objListaAnt3);
                if (listaRPTrptNOFARMACOLOGICO.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_103, FOMR_VACIO);
                    formatos = formatos + FORMFE_103 + "-";
                }
            }


            // LISTADO FORMFE_510
            DataTable listaRPTrptOftalmologico = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_510))
            {
                listaRPTrptOftalmologico = rptVistas_FE("rptViewOftalmologia_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptOftalmologico.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_510, FOMR_VACIO);
                    formatos = formatos + FORMFE_510 + "-";
                }
            }

            //LISTADO FORMFE_202


            DataTable listaRPTrptReferencia = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_202))
            {
                listaRPTrptReferencia = rptVistas_FE("rptViewReferencia_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptReferencia.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_202, FOMR_VACIO);
                    formatos = formatos + FORMFE_202 + "-";
                }
            }


            //LISTADO CATETER
            DataTable listaRPTrptVigilanciaCateterPeriferico = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_511))
            {
                listaRPTrptVigilanciaCateterPeriferico = rptVistas_FE("rptViewVigilanciaCateterPeriferico_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptVigilanciaCateterPeriferico.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_511, FOMR_VACIO);
                    formatos = formatos + FORMFE_511 + "-";
                }
            }

            //LISTADO CATETER urinario

            DataTable listaRPTrptVigilanciaCateterUrinario = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_512))
            {
                listaRPTrptVigilanciaCateterUrinario = rptVistas_FE("rptViewVigilanciaCateterUrinario_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptVigilanciaCateterUrinario.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_512, FOMR_VACIO);
                    formatos = formatos + FORMFE_512 + "-";
                }
            }


            //LISTADO VIGILANCIA VENTILACION MECANICA

            DataTable listaRPTrptVigilanciaVentilacionMecanica = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_521))
            {
                listaRPTrptVigilanciaVentilacionMecanica = rptVistas_FE("rptViewVigilanciaVentilacionMecanica_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptVigilanciaVentilacionMecanica.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_521, FOMR_VACIO);
                    formatos = formatos + FORMFE_521 + "-";
                }
            }

            //LISTADO VIGILANCIA_DISPOSITIVOS

            DataTable listaRPTrptVigilanciaDispositivos = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_513))
            {
                listaRPTrptVigilanciaDispositivos = rptVistas_FE("rptViewVigilanciaDispositivos_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptVigilanciaDispositivos.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_513, FOMR_VACIO);
                    formatos = formatos + FORMFE_513 + "-";
                }
            }

            //LISTADO EVALUACION DE DOLOR NIÑOS

            DataTable listaRPTrptDolorEvaNinio = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_514))
            {
                listaRPTrptDolorEvaNinio = rptVistas_FE("rptViewDolorEvaNinios_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptDolorEvaNinio.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_514, FOMR_VACIO);
                    formatos = formatos + FORMFE_514 + "-";
                }
            }

            //LISTADO ESCALA ALDRETE

            DataTable listaRPTrptEscalaAldrete = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_515))
            {
                listaRPTrptEscalaAldrete = rptVistas_FE("rptViewEscalaAldrete_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptEscalaAldrete.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_515, FOMR_VACIO);
                    formatos = formatos + FORMFE_515 + "-";
                }
            }
            //ESCALA BROMAGE
            DataTable listaRPTrptEscalaBromage = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_561))
            {
                listaRPTrptEscalaBromage = rptVistas_FE("rptViewEscalaBromage_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptEscalaBromage.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_561, FOMR_VACIO);
                    formatos = formatos + FORMFE_561 + "-";
                }
            }

            //LISTADO ESCALA NORTON

            DataTable listaRPTrptEscalaNorton = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_560))
            {
                listaRPTrptEscalaNorton = rptVistas_FE("rptViewEscalaNorton_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptEscalaNorton.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_560, FOMR_VACIO);
                    formatos = formatos + FORMFE_560 + "-";
                }
            }
            //LISTADO ESCALA SEDACION RASS

            DataTable listaRPTrptEscalaSedacionRass = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_562))
            {
                listaRPTrptEscalaSedacionRass = rptVistas_FE("rptViewEscalaSedacionRass_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptEscalaSedacionRass.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_562, FOMR_VACIO);
                    formatos = formatos + FORMFE_562 + "-";
                }
            }

            //LISTADO  GRADO DE DEPENDENCIA

            DataTable listaRPTrptGradoDependencia = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_563))
            {
                listaRPTrptGradoDependencia = rptVistas_FE("rptViewGradoDependencia_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptGradoDependencia.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_563, FOMR_VACIO);
                    formatos = formatos + FORMFE_563 + "-";
                }
            }

            //LISTADO EVA ADULTOS

            DataTable listaRPTrptDolorEvaAdulto = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_564))
            {
                listaRPTrptDolorEvaAdulto = rptVistas_FE("rptViewDolorEvaAdulto_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptDolorEvaAdulto.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_564, FOMR_VACIO);
                    formatos = formatos + FORMFE_564 + "-";
                }
            }

            //LISTADO ESCALA RAMSAY

            DataTable listaRPTrptEscalaRamsay = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_516))
            {
                listaRPTrptEscalaRamsay = rptVistas_FE("rptViewEscalaRamsay_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptEscalaRamsay.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_516, FOMR_VACIO);
                    formatos = formatos + FORMFE_516 + "-";
                }
            }

            //LISTADO PRE OPERATORIO 1

            DataTable listaRPTrptPreOperatorio_1 = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_517))
            {
                listaRPTrptPreOperatorio_1 = rptVistas_FE("rptViewPreOperatorio_1_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptPreOperatorio_1.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_517, FOMR_VACIO);
                    formatos = formatos + FORMFE_517 + "-";
                }
            }

            //LISTADO PRE OPERATORIO 2

            DataTable listaRPTrptPreOperatorio_2 = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_518))
            {
                listaRPTrptPreOperatorio_2 = rptVistas_FE("rptViewPreOperatorio2",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptPreOperatorio_2.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_518, FOMR_VACIO);
                    formatos = formatos + FORMFE_518 + "-";
                }
            }

            //LISTADO BalanceHidroElectro normal
            DataTable listaRPTrptBalanceElectroliticoNormal = new DataTable();
            DataTable listaRPTrptBalanceElectroliticoNormalCab2 = new DataTable();
            DataTable listaRPTrptBalanceElectroliticoNormalCab3 = new DataTable();
            DataTable listaRPTrptBalanceElectroliticoNormalDetalle1 = new DataTable();
            DataTable listaRPTrptBalanceElectroliticoNormalDetalle2 = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_519))
            {
                listaRPTrptBalanceElectroliticoNormal = rptVistasBalanceHidroElectro_FE("rptViewBalanceHidroElectrolitico_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO, 4);
                if (listaRPTrptBalanceElectroliticoNormal.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_519, FOMR_VACIO);
                    formatos = formatos + FORMFE_519 + "-";
                }


                listaRPTrptBalanceElectroliticoNormalDetalle1 = rptVistasBalanceHidroElectroDetalles_FE("rptViewBalanceHidroElectroliticoDetalle2_FE",
                           ENTITY_GLOBAL.Instance.UnidadReplicacion,
                           (int)ENTITY_GLOBAL.Instance.PacienteID,
                           (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                           (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                           , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, 4, 1);
                if (listaRPTrptBalanceElectroliticoNormalDetalle1.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_519_2, FOMR_VACIO);
                    formatos = formatos + FORMFE_519_2 + "-";
                }

                listaRPTrptBalanceElectroliticoNormalCab2 = rptVistasBalanceHidroElectro_FE("rptViewBalanceHidroElectrolitico_FE",
                       ENTITY_GLOBAL.Instance.UnidadReplicacion,
                       (int)ENTITY_GLOBAL.Instance.PacienteID,
                       (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                       (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                       , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                       ENTITY_GLOBAL.Instance.USUARIO, 4);
                if (listaRPTrptBalanceElectroliticoNormalCab2.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_519_3, FOMR_VACIO);
                    formatos = formatos + FORMFE_519_3 + "-";
                }


                listaRPTrptBalanceElectroliticoNormalDetalle2 = rptVistasBalanceHidroElectroDetalles_FE("rptViewBalanceHidroElectroliticoDetalle2_FE",
                           ENTITY_GLOBAL.Instance.UnidadReplicacion,
                           (int)ENTITY_GLOBAL.Instance.PacienteID,
                           (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                           (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                           , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, 4, 2);
                if (listaRPTrptBalanceElectroliticoNormalDetalle2.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_519_4, FOMR_VACIO);
                    formatos = formatos + FORMFE_519_4 + "-";
                }

                listaRPTrptBalanceElectroliticoNormalCab3 = rptVistasBalanceHidroElectro_FE("rptViewBalanceHidroElectrolitico_FE",
                       ENTITY_GLOBAL.Instance.UnidadReplicacion,
                       (int)ENTITY_GLOBAL.Instance.PacienteID,
                       (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                       (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                       , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                       ENTITY_GLOBAL.Instance.USUARIO, 4);
                if (listaRPTrptBalanceElectroliticoNormalCab3.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_519_5, FOMR_VACIO);
                    formatos = formatos + FORMFE_519_5 + "-";
                }
            }

            //KARDEX 1_DETALLE
            DataTable listaRPTrptKardex1_Detalle1 = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_0110))
            {
                listaRPTrptKardex1_Detalle1 = rptVistas_FE("rptviewkarde1_Detalle1", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                        null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptKardex1_Detalle1.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0110, FOMR_VACIO);
                    formatos = formatos + FORMFE_0110 + "-";
                }
            }

            //KARDEX 1 

            //DataTable listaRPTrptKardex1 = new DataTable();
            //if (formatosRecibidos.Contains("" + FORMFE_0111))
            //{
            //    listaRPTrptKardex1 = rptVistas_FENA("rptViewDiagnostico_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion,
            //           (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
            //        //(long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
            //           1,
            //           null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            //    if (listaRPTrptKardex1.Rows.Count > 0)
            //    {
            //        //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
            //        formatosRecibidos = formatosRecibidos.Replace(FORMFE_0111, FOMR_VACIO);
            //        formatos = formatos + FORMFE_0111 + "-";
            //    }
            //}


            //LISTADO CONTRAREFERENCIA

            // DataTable listaRPTrptContrareferencia = new DataTable();
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewContrarReferencia_FEEdit> listaRPTrptContrareferencia = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewContrarReferencia_FEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_520))
            {
                listaRPTrptContrareferencia = getDatarptViewContrarReferencia_FE("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptContrareferencia.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_520, FOMR_VACIO);
                    formatos = formatos + FORMFE_520 + "-";
                }
            }

            DataTable listaRPTrptTriajeEmergencia = new DataTable();
            DataTable listaRPTrptViewTriajeAlergias_FE = new DataTable();
            DataTable listaRPTrptViewTriajeAlergias_FE2 = new DataTable();
            DataTable listaRPTrptViewTriajeAlergias_FE3 = new DataTable();

            DataTable listaRPTrptViewTriajeAlergias_FEDetalle1 = new DataTable();
            DataTable listaRPTrptViewTriajeAlergias_FEDetalle2 = new DataTable();
            //LISTADO TRIAJE EMERGENCIA
            if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "TRIAJE")
            {
                if (formatosRecibidos.Contains("" + FORMFE_522))
                {
                    listaRPTrptTriajeEmergencia = rptVistasTriaje_FE("rptViewTriajeEmergencia_FE",
                             ENTITY_GLOBAL.Instance.UnidadReplicacion,
                            (int)ENTITY_GLOBAL.Instance.PacienteID,
                            (int)ENTITY_GLOBAL.Instance.EpisodioTriaje,

                             null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                            ENTITY_GLOBAL.Instance.USUARIO);
                    if (listaRPTrptTriajeEmergencia.Rows.Count > 0)
                    {
                        //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                        formatosRecibidos = formatosRecibidos.Replace(FORMFE_522, FOMR_VACIO);
                        formatos = formatos + FORMFE_522 + "-";
                    }
                }

                //LISTADO TRIAJE ALERGIA


                if (formatosRecibidos.Contains("" + FORMFE_527))
                {
                    listaRPTrptViewTriajeAlergias_FE = rptVistasTriaje_FE("rptViewCabezeraAntecedenAlergias_FE",
                             ENTITY_GLOBAL.Instance.UnidadReplicacion,
                            (int)ENTITY_GLOBAL.Instance.PacienteID,
                            (int)ENTITY_GLOBAL.Instance.EpisodioTriaje,
                             null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                            ENTITY_GLOBAL.Instance.USUARIO);
                    if (listaRPTrptViewTriajeAlergias_FE.Rows.Count > 0)
                    {
                        //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                        formatosRecibidos = formatosRecibidos.Replace(FORMFE_527, FOMR_VACIO);
                        formatos = formatos + FORMFE_527 + "-";
                    }


                    listaRPTrptViewTriajeAlergias_FEDetalle1 = rptVistasTriaje_Alergias_FE("rptViewTriajeAlergias_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioTriaje
                    , "MA", 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
                    if (listaRPTrptViewTriajeAlergias_FEDetalle1.Rows.Count > 0)
                    {
                        //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                        formatosRecibidos = formatosRecibidos.Replace(FORMFE_528, FOMR_VACIO);
                        formatos = formatos + FORMFE_528 + "-";
                    }


                    listaRPTrptViewTriajeAlergias_FE2 = rptVistasTriaje_FE("rptViewCabezeraAntecedenAlergias_FE",
                             ENTITY_GLOBAL.Instance.UnidadReplicacion,
                            (int)ENTITY_GLOBAL.Instance.PacienteID,
                            (int)ENTITY_GLOBAL.Instance.EpisodioTriaje,
                             null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                            ENTITY_GLOBAL.Instance.USUARIO);
                    if (listaRPTrptViewTriajeAlergias_FE2.Rows.Count > 0)
                    {
                        //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                        formatosRecibidos = formatosRecibidos.Replace(FORMFE_527_2, FOMR_VACIO);
                        formatos = formatos + FORMFE_527_2 + "-";
                    }



                    listaRPTrptViewTriajeAlergias_FEDetalle2 = rptVistasTriaje_Alergias_FE("rptViewTriajeAlergias_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioTriaje
                      , "RE", 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
                    if (listaRPTrptViewTriajeAlergias_FEDetalle2.Rows.Count > 0)
                    {
                        //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                        formatosRecibidos = formatosRecibidos.Replace(FORMFE_529, FOMR_VACIO);
                        formatos = formatos + FORMFE_529 + "-";
                    }


                    listaRPTrptViewTriajeAlergias_FE3 = rptVistasTriaje_FE("rptViewCabezeraAntecedenAlergias_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                       (int)ENTITY_GLOBAL.Instance.PacienteID,
                       (int)ENTITY_GLOBAL.Instance.EpisodioTriaje,
                        null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                       ENTITY_GLOBAL.Instance.USUARIO);
                    if (listaRPTrptViewTriajeAlergias_FE3.Rows.Count > 0)
                    {
                        //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                        formatosRecibidos = formatosRecibidos.Replace(FORMFE_527_3, FOMR_VACIO);
                        formatos = formatos + FORMFE_527_3 + "-";
                    }
                }
            }


            //LISTADO INFORME DE ALTA DATOS GENERALES

            DataTable listarptInformeAlta_DatosGenerales_FE = new DataTable();
            DataTable listarptInformeAlta_Med_FE = new DataTable();
            DataTable listarptInformeAlta_Mat_FE = new DataTable();
            DataTable listarptInformeAlta_ProxCita_FE = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_523) || formatosRecibidos.Contains("" + "CCEPF201"))
            {
                listarptInformeAlta_DatosGenerales_FE = rptVistas_FE("rptViewInformeAlta_DatosGenerales_FE",
                    ENTITY_GLOBAL.Instance.UnidadReplicacion,
                    (int)ENTITY_GLOBAL.Instance.PacienteID,
                    (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                    (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                      ENTITY_GLOBAL.Instance.USUARIO);
                if (listarptInformeAlta_DatosGenerales_FE.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_523, FOMR_VACIO);
                    formatos = formatos + FORMFE_523 + "-";
                }
                //LISTADO INFORME DE ALTA MED


                listarptInformeAlta_Med_FE = rptVistas_FE("rptViewInformeAlta_Med",
                    ENTITY_GLOBAL.Instance.UnidadReplicacion,
                    (int)ENTITY_GLOBAL.Instance.PacienteID,
                    (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                    (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                      ENTITY_GLOBAL.Instance.USUARIO);
                if (listarptInformeAlta_Med_FE.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_524, FOMR_VACIO);
                    formatos = formatos + FORMFE_524 + "-";
                }

                listarptInformeAlta_Mat_FE = rptInformeAlta_MED_FE("rptViewInformeAlta_mat",
                      ENTITY_GLOBAL.Instance.UnidadReplicacion,
                      (int)ENTITY_GLOBAL.Instance.PacienteID,
                      (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                      (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                      , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                      ENTITY_GLOBAL.Instance.USUARIO);
                if (listarptInformeAlta_Mat_FE.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_525, FOMR_VACIO);
                    formatos = formatos + FORMFE_525 + "-";
                }

                listarptInformeAlta_ProxCita_FE = rptInformeAlta_MED_FE("rptViewInformeAlta_proxCita",
                       ENTITY_GLOBAL.Instance.UnidadReplicacion,
                       (int)ENTITY_GLOBAL.Instance.PacienteID,
                       (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                       (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                       , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                       ENTITY_GLOBAL.Instance.USUARIO);
                if (listarptInformeAlta_ProxCita_FE.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_526, FOMR_VACIO);
                    formatos = formatos + FORMFE_526 + "-";
                }
            }



            //LISTADO ESCALA GLASGOW
            DataTable listarptVistasGlasgow_FE = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_0038))
            {
                listarptVistasGlasgow_FE = rptVistasGlasgow_FE("rptViewEscalaGlasgow_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                   , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, "EG");


                if (listarptVistasGlasgow_FE.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0038, FOMR_VACIO);
                    formatos = formatos + FORMFE_0038 + "-";
                }
            }


            // SOLICITUD TRANSFUSIONAL

            DataTable listarptVistasSolucitud_Transfusional_FE = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_530))
            {
                listarptVistasSolucitud_Transfusional_FE = rptVistas_FE("rptViewSolicitudTransfusional_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listarptVistasSolucitud_Transfusional_FE.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_530, FOMR_VACIO);
                    formatos = formatos + FORMFE_530 + "-";
                }
            }


            // ESCALA WOOD DOWNES

            DataTable listarptVistasEscalaWoodDownes_FE = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_531))
            {
                listarptVistasEscalaWoodDownes_FE = rptVistas_FE("rptViewEscalaWoodDownes_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listarptVistasEscalaWoodDownes_FE.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_531, FOMR_VACIO);
                    formatos = formatos + FORMFE_531 + "-";
                }
            }


            // NEONATO PREMATUROS

            DataTable listarptVistaEvaluacionDolorEvaNeonatosPrematuros_FE = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_532))
            {
                listarptVistaEvaluacionDolorEvaNeonatosPrematuros_FE = rptVistas_FE("rptViewEvaluacionDolorEvaNeonatosPrematuros_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listarptVistaEvaluacionDolorEvaNeonatosPrematuros_FE.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_532, FOMR_VACIO);
                    formatos = formatos + FORMFE_532 + "-";
                }
            }


            DataTable listarptVistaEpidemiologia_FE = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_305))
            {
                listarptVistaEpidemiologia_FE = rptVistas_FE("rptViewEpidemiologia_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listarptVistaEpidemiologia_FE.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_305, FOMR_VACIO);
                    formatos = formatos + FORMFE_305 + "-";
                }
            }

            //GLASGOW PRE ESCOLAR
            DataTable listarptVistasGlasgowPreEscolar_FE = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_0039))
            {
                //listarptVistasGlasgowPreEscolar_FE = rptVistas_FE("rptViewEscalaGlasgow_FE",
                //        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                //        (int)ENTITY_GLOBAL.Instance.PacienteID,
                //        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                //        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                //        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                //        ENTITY_GLOBAL.Instance.USUARIO);

                listarptVistasGlasgowPreEscolar_FE = rptVistasGlasgow_FE("rptViewEscalaGlasgow_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
             , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, "GP");


                if (listarptVistasGlasgowPreEscolar_FE.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0039, FOMR_VACIO);
                    formatos = formatos + FORMFE_0039 + "-";
                }
            }

            //GLASGOW LACTANTE
            DataTable listarptVistasGlasgowLactante_FE = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_0040))
            {
                //listarptVistasGlasgowLactante_FE = rptVistas_FE("rptViewEscalaGlasgow_FE",
                //        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                //        (int)ENTITY_GLOBAL.Instance.PacienteID,
                //        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                //        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                //        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                //        ENTITY_GLOBAL.Instance.USUARIO);

                listarptVistasGlasgowLactante_FE = rptVistasGlasgow_FE("rptViewEscalaGlasgow_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
             , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, "GL");


                if (listarptVistasGlasgowLactante_FE.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0040, FOMR_VACIO);
                    formatos = formatos + FORMFE_0040 + "-";
                }
            }

            // LISTADO FORMFE_0043
            DataTable listaRPTrptRetiroVoluntario = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_0043))
            {
                listaRPTrptRetiroVoluntario = rptVistas_FE("rptViewRetiroVoluntario_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptRetiroVoluntario.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0043, FOMR_VACIO);
                    formatos = formatos + FORMFE_0043 + "-";
                }
            }

            //LISTADO FORM_0005
            DataTable listaRPTrptAntGenerales_FE = new DataTable();
            DataTable listaRPTrptAntGeneralesDetalle_FE = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_0005CAB))
            {
                listaRPTrptAntGenerales_FE = rptVistas_FE("rptViewAntecedentesPersonalesPatologicosGenerales_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptAntGenerales_FE.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0005CAB, FOMR_VACIO);
                    formatos = formatos + FORMFE_0005CAB + "-";
                }


                listaRPTrptAntGeneralesDetalle_FE = rptVistas_FE("rptViewAntecedentesPersonalesPatologicosGenerales_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptAntGeneralesDetalle_FE.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0005DET, FOMR_VACIO);
                    formatos = formatos + FORMFE_0005DET + "-";
                }
            }


            //LISTADO FORMFE_0005GINECO

            DataTable listaRPTAntGinecObstetrico = new DataTable();
            DataTable listaRPTAntGinecObstetricoDetalle = new DataTable();

            if (formatosRecibidos.Contains("" + FORMFE_0005CABGINECO))
            {
                listaRPTAntGinecObstetrico = rptVistas_FE("rptViewAntecedentesPersGinecObstetrico_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTAntGinecObstetrico.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0005CABGINECO, FOMR_VACIO);
                    formatos = formatos + FORMFE_0005CABGINECO + "-";
                }


                listaRPTAntGinecObstetricoDetalle = rptVistas_FE("rptViewAntecedentesPersGinecObstetrico_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTAntGinecObstetricoDetalle.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0005DETGINECO, FOMR_VACIO);
                    formatos = formatos + FORMFE_0005DETGINECO + "-";
                }
            }



            //LISTADO FORMFE_600 BALANCE HIDROELECTROLITCO SUBREPORTE

            DataTable listaRPTBalanceHidroelectroliticoCabecera1 = new DataTable();
            DataTable listaRPTBalanceHidroelectroliticoDetalle1 = new DataTable();
            DataTable listaRPTBalanceHidroelectroliticoCabecera2 = new DataTable();
            DataTable listaRPTBalanceHidroelectroliticoDetalle2 = new DataTable();
            DataTable listaRPTBalanceHidroelectroliticoCabecera3 = new DataTable();


            if (formatosRecibidos.Contains("" + FORMFE_600))
            {

                listaRPTBalanceHidroelectroliticoCabecera1 = rptVistasBalanceHidroElectro_FE("rptViewBalanceHidroElectrolitico_FE",
                               ENTITY_GLOBAL.Instance.UnidadReplicacion,
                               (int)ENTITY_GLOBAL.Instance.PacienteID,
                               (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                               (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                               , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, 3);

                if (listaRPTBalanceHidroelectroliticoCabecera1.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_600, FOMR_VACIO);
                    formatos = formatos + FORMFE_600 + "-";
                }



                listaRPTBalanceHidroelectroliticoDetalle1 = rptVistasBalanceHidroElectroDetalles_FE("rptViewBalanceHidroElectroliticoDetalle2_FE",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, 3, 1);
                if (listaRPTBalanceHidroelectroliticoDetalle1.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_600_1, FOMR_VACIO);
                    formatos = formatos + FORMFE_600_1 + "-";
                }

                listaRPTBalanceHidroelectroliticoCabecera2 = rptVistasBalanceHidroElectro_FE("rptViewBalanceHidroElectrolitico_FE",
                              ENTITY_GLOBAL.Instance.UnidadReplicacion,
                              (int)ENTITY_GLOBAL.Instance.PacienteID,
                              (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                              (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                              , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, 3);

                if (listaRPTBalanceHidroelectroliticoCabecera2.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_600_2, FOMR_VACIO);
                    formatos = formatos + FORMFE_600_2 + "-";
                }

                listaRPTBalanceHidroelectroliticoDetalle2 = rptVistasBalanceHidroElectroDetalles_FE("rptViewBalanceHidroElectroliticoDetalle2_FE",
                    ENTITY_GLOBAL.Instance.UnidadReplicacion,
                    (int)ENTITY_GLOBAL.Instance.PacienteID,
                    (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                    (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, 3, 2);


                if (listaRPTBalanceHidroelectroliticoDetalle2.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_600_3, FOMR_VACIO);
                    formatos = formatos + FORMFE_600_3 + "-";
                }
                listaRPTBalanceHidroelectroliticoCabecera3 = rptVistasBalanceHidroElectro_FE("rptViewBalanceHidroElectrolitico_FE",
                             ENTITY_GLOBAL.Instance.UnidadReplicacion,
                             (int)ENTITY_GLOBAL.Instance.PacienteID,
                             (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                             (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                             , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, 3);
                if (listaRPTBalanceHidroelectroliticoCabecera3.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_600_4, FOMR_VACIO);
                    formatos = formatos + FORMFE_600_4 + "-";
                }
            }


            //LISTADO FORM_327ORDENINTERVENCIONQUIRURGICA
            DataTable listaRPTCabezeraOrdenInterQuirur1 = new DataTable();
            DataTable listaRPTrptDetOrdenInterQuirurDiag = new DataTable();
            DataTable listaRPTrptDetOrdenInterQuirurCiruProced = new DataTable();
            DataTable listaRPTrptDetOrdenInterQuirurExamen1 = new DataTable();
            DataTable listaRPTrptDetOrdenInterQuirurExamen2 = new DataTable();
            DataTable listaRPTrptDetOrdenInterQuirurExamen3 = new DataTable();

            if (formatosRecibidos.Contains("" + FORMFE_327CAB))
            {
                listaRPTCabezeraOrdenInterQuirur1 = rptVistas_FE("rptViewOrdenInterQuirurgica_FE",
                         ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO
                        );


                if (listaRPTCabezeraOrdenInterQuirur1.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_327CAB, FOMR_VACIO);
                    formatos = formatos + FORMFE_327CAB + "-";

                    // Verificar si la lista es válida y contiene al menos un elemento
                    if (listaRPTCabezeraOrdenInterQuirur1 != null && listaRPTCabezeraOrdenInterQuirur1.Rows.Count > 0)
                    {
                        // Verificar si la sesión contiene el dato necesario
                        if (Session["EmpresaAseguradoraNombre"] != null)
                        {
                            // Validar si existe la clave "Accion" en las columnas del DataTable
                            if (listaRPTCabezeraOrdenInterQuirur1.Columns.Contains("Accion"))
                            {
                                // Asignar el valor desde la sesión
                                listaRPTCabezeraOrdenInterQuirur1.Rows[0]["Accion"] = Session["EmpresaAseguradoraNombre"];
                            }
                        }
                        // Verificar si la sesión contiene el dato necesario
                        if (Session["CodigoHC_PACIENTE"] != null)
                        {
                            // Validar si existe la clave "Accion" en las columnas del DataTable
                            if (listaRPTCabezeraOrdenInterQuirur1.Columns.Contains("Version"))
                            {
                                // Asignar el valor desde la sesión
                                listaRPTCabezeraOrdenInterQuirur1.Rows[0]["Version"] = Session["CodigoHC_PACIENTE"];
                            }
                        }
                    }

                    foreach (DataRow ht_fila in listaRPTCabezeraOrdenInterQuirur1.Rows)
                    {
                        if (ht_fila["UnidadServicioCodigo"].ToString() != null && ht_fila["UnidadServicioCodigo"].ToString() != "")
                        {
                            System.IO.FileInfo fi = new System.IO.FileInfo(ht_fila["UnidadServicioCodigo"].ToString());
                            if (fi.Exists)
                            {
                                var NombreServidor = fi.Name;
                                var rutaServidor = Server.MapPath("../resources/DocumentosAdjuntos/firmas/");
                                if (!Directory.Exists(rutaServidor))
                                {
                                    DirectoryInfo di = Directory.CreateDirectory(rutaServidor);
                                }
                                var PathServidor = rutaServidor + NombreServidor;
                                System.IO.File.Copy(ht_fila["UnidadServicioCodigo"].ToString(), PathServidor, true);
                                var PathOri = "../resources/DocumentosAdjuntos/firmas/" + NombreServidor;
                                Session["FIRMA_DIGITAL"] = PathOri;
                            }
                        }
                        else
                        {
                            Session["FIRMA_DIGITAL"] = "";
                        }
                    }

                }

                listaRPTrptDetOrdenInterQuirurDiag = rptVistas_FE("rptViewOrdenInterQuiruDiagnosticoDetalle_FE",
                          ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO
                        );

                if (listaRPTrptDetOrdenInterQuirurDiag.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_327DIAG, FOMR_VACIO);
                    formatos = formatos + FORMFE_327DIAG + "-";
                }

                listaRPTrptDetOrdenInterQuirurCiruProced = rptVistasExamenesOrdenInter_FE("rptViewOrdenInterQuiruExamenApoyoDetalle_FE",
                          ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO,
                        1);
                if (listaRPTrptDetOrdenInterQuirurCiruProced.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_327CIRUGIAPRO, FOMR_VACIO);
                    formatos = formatos + FORMFE_327CIRUGIAPRO + "-";
                }


                listaRPTrptDetOrdenInterQuirurExamen1 = rptVistasExamenesOrdenInter_FE("rptViewOrdenInterQuiruExamenApoyoDetalle_FE",
                         ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO,
                        2);
                if (listaRPTrptDetOrdenInterQuirurExamen1.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_327EXAMEN1, FOMR_VACIO);
                    formatos = formatos + FORMFE_327EXAMEN1 + "-";
                }


                listaRPTrptDetOrdenInterQuirurExamen2 = rptVistasExamenesOrdenInter_FE("rptViewOrdenInterQuiruExamenApoyoDetalle_FE",
                         ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO
                        , 3);
                if (listaRPTrptDetOrdenInterQuirurExamen2.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_327EXAMEN2, FOMR_VACIO);
                    formatos = formatos + FORMFE_327EXAMEN2 + "-";
                }

                listaRPTrptDetOrdenInterQuirurExamen3 = rptVistasExamenesOrdenInter_FE("rptViewOrdenInterQuiruExamenApoyoDetalle_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO
                        , 4);
                if (listaRPTrptDetOrdenInterQuirurExamen3.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_327EXAMEN3, FOMR_VACIO);
                    formatos = formatos + FORMFE_327EXAMEN3 + "-";
                }

            }

            //LISTADO NOTA DE INGRESO listaRPTNotaDeIngresoCAB1
            DataTable listaRPTNotaDeIngresoCAB1 = new DataTable();
            DataTable listaRPTNotaDeIngresoCAB2 = new DataTable();
            DataTable listaRPTNotaDeIngresoCAB3 = new DataTable();
            DataTable listaRPTrptDetNotaDeIngresoDiag = new DataTable();
            DataTable listaRPTrptDetNotaDeIngresoExamen1 = new DataTable();

            if (formatosRecibidos.Contains("" + FORMFE_319CAB1))
            {
                listaRPTNotaDeIngresoCAB1 = rptVistas_FE("rptViewNota_Ingreso_FE",
                         ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO
                        );
                if (listaRPTNotaDeIngresoCAB1.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_319CAB1, FOMR_VACIO);
                    formatos = formatos + FORMFE_319CAB1 + "-";
                }

                listaRPTrptDetNotaDeIngresoDiag = rptVistas_FE("rptViewNotaIngreso_Diagnostico_FE",
                         ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO
                        );
                if (listaRPTrptDetNotaDeIngresoDiag.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_319DIAG, FOMR_VACIO);
                    formatos = formatos + FORMFE_319DIAG + "-";
                }

                listaRPTNotaDeIngresoCAB2 = rptVistas_FE("rptViewNota_Ingreso_FE",
                         ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO
                        );
                if (listaRPTNotaDeIngresoCAB2.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_319CAB2, FOMR_VACIO);
                    formatos = formatos + FORMFE_319CAB2 + "-";
                }

                listaRPTrptDetNotaDeIngresoExamen1 = rptVistas_FE("rptViewNotaIngreso_ExamenApoyo_FE",
                         ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO
                        );
                if (listaRPTrptDetNotaDeIngresoExamen1.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_319EXAMEN1, FOMR_VACIO);
                    formatos = formatos + FORMFE_319EXAMEN1 + "-";
                }


                listaRPTNotaDeIngresoCAB3 = rptVistas_FE("rptViewNota_Ingreso_FE",
                         ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO
                        );
                if (listaRPTNotaDeIngresoCAB3.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_319CAB3, FOMR_VACIO);
                    formatos = formatos + FORMFE_319CAB3 + "-";
                }


            }



            //LISTADO TOCOLOSIS listaRPTTocolosisInduccionAcentuacion
            DataTable listaRPTTocolosisInduccionAcentuacion = new DataTable();

            if (formatosRecibidos.Contains("" + FORMFE_502TOCOLOSIS))
            {
                listaRPTTocolosisInduccionAcentuacion = rptVistas_FE("rptViewTocolosisInduccionAcentuacion_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                       (int)ENTITY_GLOBAL.Instance.PacienteID,
                       (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                       (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                       , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                       ENTITY_GLOBAL.Instance.USUARIO
                       );

                if (listaRPTTocolosisInduccionAcentuacion.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_502TOCOLOSIS, FOMR_VACIO);
                    formatos = formatos + FORMFE_502TOCOLOSIS + "-";
                }

            }

            //LISTADO FORMFE_402CABHELECT1
            DataTable listaRPTrptHelectrolitoNeoCAB1 = new DataTable();
            DataTable listaRPTrptHelectrolitoNeoCAB2 = new DataTable();
            DataTable listaRPTrptHelectrolitoNeoCAB3 = new DataTable();
            DataTable listaRPTrptHelectrolitoNeoDET1 = new DataTable();
            DataTable listaRPTrptHelectrolitoNeoDET2 = new DataTable();

            if (formatosRecibidos.Contains("" + FORMFE_402CABHELECT1))
            {
                listaRPTrptHelectrolitoNeoCAB1 = rptVistasBalanceHidroElectro_FE("rptViewBalanceHidroElectrolitico_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                           (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO,
                        1);

                if (listaRPTrptHelectrolitoNeoCAB1.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_402CABHELECT1, FOMR_VACIO);
                    formatos = formatos + FORMFE_402CABHELECT1 + "-";
                }

                listaRPTrptHelectrolitoNeoDET1 = rptVistasBalanceHidroElectroDetalles_FE("rptViewBalanceHidroElectroliticoDetalle1_FE",
                         ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                           (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO,
                        1,
                        1);
                if (listaRPTrptHelectrolitoNeoDET1.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_402DETHELECT1, FOMR_VACIO);
                    formatos = formatos + FORMFE_402DETHELECT1 + "-";
                }


                listaRPTrptHelectrolitoNeoCAB2 = rptVistasBalanceHidroElectro_FE("rptViewBalanceHidroElectrolitico_FE",
                       ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                           (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO,
                        1);
                if (listaRPTrptHelectrolitoNeoCAB2.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_402CABHELECT2, FOMR_VACIO);
                    formatos = formatos + FORMFE_402CABHELECT2 + "-";
                }



                listaRPTrptHelectrolitoNeoDET2 = rptVistasBalanceHidroElectroDetalles_FE("rptViewBalanceHidroElectroliticoDetalle2_FE",
                          ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                           (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO,
                        1,
                        2);

                if (listaRPTrptHelectrolitoNeoDET2.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_402DETHELECT2, FOMR_VACIO);
                    formatos = formatos + FORMFE_402DETHELECT2 + "-";
                }


                listaRPTrptHelectrolitoNeoCAB3 = rptVistasBalanceHidroElectro_FE("rptViewBalanceHidroElectrolitico_FE",
                          ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                           (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO,
                        1);
                if (listaRPTrptHelectrolitoNeoCAB3.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_402CABHELECT3, FOMR_VACIO);
                    formatos = formatos + FORMFE_402CABHELECT3 + "-";
                }


            }


            //LISTADO FORMFE_402CABHELECT1
            DataTable listaRPTrptHelectrolitoSOPCAB1 = new DataTable();
            DataTable listaRPTrptHelectrolitoSOPCAB2 = new DataTable();
            DataTable listaRPTrptHelectrolitoSOPCAB3 = new DataTable();
            DataTable listaRPTrptHelectrolitoSOPDET1 = new DataTable();
            DataTable listaRPTrptHelectrolitoSOPDET2 = new DataTable();

            if (formatosRecibidos.Contains("" + FORMFE_401CABHELECT1))
            {
                listaRPTrptHelectrolitoSOPCAB1 = rptVistasBalanceHidroElectro_FE("rptViewBalanceHidroElectrolitico_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                           (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO,
                        2);

                if (listaRPTrptHelectrolitoSOPCAB1.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_401CABHELECT1, FOMR_VACIO);
                    formatos = formatos + FORMFE_401CABHELECT1 + "-";
                }

                listaRPTrptHelectrolitoSOPDET1 = rptVistasBalanceHidroElectroDetalles_FE("rptViewBalanceHidroElectroliticoDetalle1_FE",
                         ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                           (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO,
                        2,
                        1);
                if (listaRPTrptHelectrolitoSOPDET1.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_401DETHELECT1, FOMR_VACIO);
                    formatos = formatos + FORMFE_401DETHELECT1 + "-";
                }


                listaRPTrptHelectrolitoSOPCAB2 = rptVistasBalanceHidroElectro_FE("rptViewBalanceHidroElectrolitico_FE",
                       ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                           (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO,
                        2);
                if (listaRPTrptHelectrolitoSOPCAB2.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_401CABHELECT2, FOMR_VACIO);
                    formatos = formatos + FORMFE_401CABHELECT2 + "-";
                }

                listaRPTrptHelectrolitoSOPDET2 = rptVistasBalanceHidroElectroDetalles_FE("rptViewBalanceHidroElectroliticoDetalle2_FE",
                          ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                           (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO,
                        2,
                        2);

                if (listaRPTrptHelectrolitoSOPDET2.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_401DETHELECT2, FOMR_VACIO);
                    formatos = formatos + FORMFE_401DETHELECT2 + "-";
                }


                listaRPTrptHelectrolitoSOPCAB3 = rptVistasBalanceHidroElectro_FE("rptViewBalanceHidroElectrolitico_FE",
                          ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                           (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO,
                        2);
                if (listaRPTrptHelectrolitoSOPCAB3.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_401CABHELECT3, FOMR_VACIO);
                    formatos = formatos + FORMFE_401CABHELECT3 + "-";
                }
            }


            //LISTADO FORM_302HOJARECIEN_NACIDO
            DataTable listaRPTrptHojaRecienNacido = new DataTable();
            DataTable listaRPTrptHojaRecienNacidoDetalle = new DataTable();

            if (formatosRecibidos.Contains("" + FORMFE_302CABHOJA))
            {
                listaRPTrptHojaRecienNacido = rptVistas_FE("rptHojaRecienNacido_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptHojaRecienNacido.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_302CABHOJA, FOMR_VACIO);
                    formatos = formatos + FORMFE_302CABHOJA + "-";
                }


                listaRPTrptHojaRecienNacidoDetalle = rptVistas_FE("rptViewHojarecienNacidoDetalle_FEsubrep",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptHojaRecienNacidoDetalle.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_302DETHOJA, FOMR_VACIO);
                    formatos = formatos + FORMFE_302DETHOJA + "-";
                }
            }


            //LISTADO FORMFE_461CIRUENTRADA
            DataTable listaRPTrptSeguridadCirugiaEntradaCab = new DataTable();

            if (formatosRecibidos.Contains("" + FORMFE_461CIRUENTRADA))
            {

                listaRPTrptSeguridadCirugiaEntradaCab = rptVistasTipoCirugia_FE("rptViewSeguridadCirugia_FE",
               ENTITY_GLOBAL.Instance.UnidadReplicacion,
               (int)ENTITY_GLOBAL.Instance.PacienteID,
               (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
               (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
               , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, 1);

                if (listaRPTrptSeguridadCirugiaEntradaCab.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_461CIRUENTRADA, FOMR_VACIO);
                    formatos = formatos + FORMFE_461CIRUENTRADA + "-";
                }
            }


            //LISTADO FORMFE_462CIRUPAUSA
            DataTable listaRPTrptSeguridadCirugiaPausaCab = new DataTable();

            if (formatosRecibidos.Contains("" + FORMFE_462CIRUPAUSA))
            {

                listaRPTrptSeguridadCirugiaPausaCab = rptVistasTipoCirugia_FE("rptViewSeguridadCirugia_FE",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, 2);

                if (listaRPTrptSeguridadCirugiaPausaCab.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_462CIRUPAUSA, FOMR_VACIO);
                    formatos = formatos + FORMFE_462CIRUPAUSA + "-";
                }
            }



            //LISTADO FORMFE_463CIRUSALIDA
            DataTable listaRPTrptSeguridadCirugiaSalidaCab = new DataTable();

            if (formatosRecibidos.Contains("" + FORMFE_463CIRUSALIDA))
            {

                listaRPTrptSeguridadCirugiaSalidaCab = rptVistasTipoCirugia_FE("rptViewSeguridadCirugia_FE",
                    ENTITY_GLOBAL.Instance.UnidadReplicacion,
                    (int)ENTITY_GLOBAL.Instance.PacienteID,
                    (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                    (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, 3);


                if (listaRPTrptSeguridadCirugiaSalidaCab.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_463CIRUSALIDA, FOMR_VACIO);
                    formatos = formatos + FORMFE_463CIRUSALIDA + "-";
                }

            }
            //LISTADO FORMFE_464
            DataTable listaRPTrptEscalaAltaCirugiaAmbulatoria = new DataTable();

            if (formatosRecibidos.Contains("" + FORMFE_464))
            {

                listaRPTrptEscalaAltaCirugiaAmbulatoria = rptVistas_FE("rptViewEscalaAltaCirugiaAmbulatoria_FE",
                  ENTITY_GLOBAL.Instance.UnidadReplicacion,
                  (int)ENTITY_GLOBAL.Instance.PacienteID,
                  (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                  (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                  , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                  ENTITY_GLOBAL.Instance.USUARIO);

                if (listaRPTrptEscalaAltaCirugiaAmbulatoria.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_464, FOMR_VACIO);
                    formatos = formatos + FORMFE_464 + "-";
                }

            }


            //LISTADO FORMFE_323_3ANESTESIA

            DataTable listaRPTAnestesia3 = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_323_3CAB_ANESTESIA3))
            {
                listaRPTAnestesia3 = rptVistas_FE("rptViewFichaAnestesia_3_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTAnestesia3.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_323_3CAB_ANESTESIA3, FOMR_VACIO);
                    formatos = formatos + FORMFE_323_3CAB_ANESTESIA3 + "-";
                }
            }


            //LISTADO FORM_323_1ANESTESIA
            DataTable listaRPTrptAnestesia1 = new DataTable();
            DataTable listaRPTrptAnestesiaCab2 = new DataTable();
            DataTable listaRPTrptAnestesiaCab3 = new DataTable();
            DataTable listaRPTrptAnestesia1Detalle_1 = new DataTable();
            DataTable listaRPTrptAnestesia1Detalle_2 = new DataTable();
            DataTable listaRPTrptAnestesia1Detalle_3 = new DataTable();
            DataTable listaRPTrptAnestesia1Detalle_4 = new DataTable();
            DataTable listaRPTrptAnestesia1Detalle_5 = new DataTable();

            if (formatosRecibidos.Contains("" + FORMFE_323_1CABANESTESIA))
            {
                listaRPTrptAnestesia1 = rptVistas_FE("rptViewFichaAnestesia_1_FE",
                  ENTITY_GLOBAL.Instance.UnidadReplicacion,
                  (int)ENTITY_GLOBAL.Instance.PacienteID,
                  (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                  (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                  , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                  ENTITY_GLOBAL.Instance.USUARIO);

                if (listaRPTrptAnestesia1.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_323_1CABANESTESIA, FOMR_VACIO);
                    formatos = formatos + FORMFE_323_1CABANESTESIA + "-";
                }


                listaRPTrptAnestesia1Detalle_1 = rptVistasExamenesAnestesiaDetalle_1_FE("rptViewFichaAnestesia_1_ExamenesDetalle_FE",
             ENTITY_GLOBAL.Instance.UnidadReplicacion,
             (int)ENTITY_GLOBAL.Instance.PacienteID,
             (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
             (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
             , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
             ENTITY_GLOBAL.Instance.USUARIO, 1);


                if (listaRPTrptAnestesia1Detalle_1.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_323_1DET1_ANESTESIA, FOMR_VACIO);
                    formatos = formatos + FORMFE_323_1DET1_ANESTESIA + "-";
                }


                listaRPTrptAnestesiaCab2 = rptVistas_FE("rptViewFichaAnestesia_1_FE",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                ENTITY_GLOBAL.Instance.USUARIO);

                if (listaRPTrptAnestesiaCab2.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_323_1CABANESTESIA2, FOMR_VACIO);
                    formatos = formatos + FORMFE_323_1CABANESTESIA2 + "-";
                }



                listaRPTrptAnestesia1Detalle_2 = rptVistasDiagnosticosAnestesiaDetalle_1_FE("rptViewFichaAnestesia_1_DiagnosticoDetalle_FE",
            ENTITY_GLOBAL.Instance.UnidadReplicacion,
            (int)ENTITY_GLOBAL.Instance.PacienteID,
            (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
            (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
            ENTITY_GLOBAL.Instance.USUARIO, 1);


                if (listaRPTrptAnestesia1Detalle_2.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_323_1DET1_ANESDIAG1, FOMR_VACIO);
                    formatos = formatos + FORMFE_323_1DET1_ANESDIAG1 + "-";
                }

                listaRPTrptAnestesia1Detalle_3 = rptVistasExamenesAnestesiaDetalle_1_FE("rptViewFichaAnestesia_1_ExamenesDetalle_FE",
                 ENTITY_GLOBAL.Instance.UnidadReplicacion,
                 (int)ENTITY_GLOBAL.Instance.PacienteID,
                 (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                 (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                 , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                 ENTITY_GLOBAL.Instance.USUARIO, 2);


                if (listaRPTrptAnestesia1Detalle_3.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_323_1DET1_ANESEXAM2, FOMR_VACIO);
                    formatos = formatos + FORMFE_323_1DET1_ANESEXAM2 + "-";
                }


                listaRPTrptAnestesia1Detalle_4 = rptVistasDiagnosticosAnestesiaDetalle_1_FE("rptViewFichaAnestesia_1_DiagnosticoDetalle_FE",
             ENTITY_GLOBAL.Instance.UnidadReplicacion,
             (int)ENTITY_GLOBAL.Instance.PacienteID,
             (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
             (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
             , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
             ENTITY_GLOBAL.Instance.USUARIO, 3);


                if (listaRPTrptAnestesia1Detalle_4.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_323_1DET1_ANESDIAG2, FOMR_VACIO);
                    formatos = formatos + FORMFE_323_1DET1_ANESDIAG2 + "-";
                }



                listaRPTrptAnestesia1Detalle_5 = rptVistasExamenesAnestesiaDetalle_1_FE("rptViewFichaAnestesia_1_ExamenesDetalle_FE",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                ENTITY_GLOBAL.Instance.USUARIO, 3);


                if (listaRPTrptAnestesia1Detalle_5.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_323_1DET1_ANESEXAM3, FOMR_VACIO);
                    formatos = formatos + FORMFE_323_1DET1_ANESEXAM3 + "-";
                }



                listaRPTrptAnestesiaCab3 = rptVistas_FE("rptViewFichaAnestesia_1_FE",
                 ENTITY_GLOBAL.Instance.UnidadReplicacion,
                 (int)ENTITY_GLOBAL.Instance.PacienteID,
                 (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                 (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                 , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                 ENTITY_GLOBAL.Instance.USUARIO);

                if (listaRPTrptAnestesiaCab3.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_323_1CABANESTESIA3, FOMR_VACIO);
                    formatos = formatos + FORMFE_323_1CABANESTESIA3 + "-";
                }
            }



            //LISTADO FORM_0006

            DataTable listarptViewAlergias_FE = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_0006))
            {
                listarptViewAlergias_FE = rptVistas_FE("rptViewAlergias_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);
                if (listarptViewAlergias_FE.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0006, FOMR_VACIO);
                    formatos = formatos + FORMFE_0006 + "-";
                }
            }

            //LISTADO FORM_0007
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesis_AFAM_FEEdit> listarptAnt_Familiares = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesis_AFAM_FEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0007))
            {
                listarptAnt_Familiares = getDatarptViewAnamnesis_ANTFAM_FE("MASIVO", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , objEntidad, idImpresionLog, FORMFE_0007, ENTITY_GLOBAL.Instance.USUARIO);
                if (listarptAnt_Familiares.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0007, FOMR_VACIO);
                    formatos = formatos + FORMFE_0007 + "-";
                }
            }

            //LISTADO FORMFE_0008
            List<SoluccionSalud.RepositoryReport.Entidades.rptView_ValoracionFuncionalAM_FEEdit> listarptView_ValoracionFuncionalAM_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptView_ValoracionFuncionalAM_FEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0008))
            {
                listarptView_ValoracionFuncionalAM_FE = getDatarptViewValoracionFuncionalAM_FE("MASIVO", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , objEntidad, idImpresionLog, FORMFE_0008, ENTITY_GLOBAL.Instance.USUARIO);
                if (listarptView_ValoracionFuncionalAM_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0008, FOMR_VACIO);
                    formatos = formatos + FORMFE_0008 + "-";
                }
            }


            //LISTADO FORMFE_0009
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionMentalAM_FEEdit> listarptViewValoracionMentalAM_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionMentalAM_FEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0009))
            {
                listarptViewValoracionMentalAM_FE = getDatarptViewValoracionMentalAM_FE("MASIVO", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , objEntidad, idImpresionLog, FORMFE_0009, ENTITY_GLOBAL.Instance.USUARIO);
                if (listarptViewValoracionMentalAM_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0009, FOMR_VACIO);
                    formatos = formatos + FORMFE_0009 + "-";
                }
            }

            //LISTADO FORMFE_0010
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionSocioFamAM_FEEdit> listaRPTrptViewValoracionSocioFamAM_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionSocioFamAM_FEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0010))
            {
                listaRPTrptViewValoracionSocioFamAM_FE = getDatarptViewValoracionSocioFamAM_FE("MASIVO", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , objEntidad, idImpresionLog, FORMFE_0010, ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptViewValoracionSocioFamAM_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0010, FOMR_VACIO);
                    formatos = formatos + FORMFE_0010 + "-";
                }
            }

            //LISTADO FORMFE_0011
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionAM_FEEdit> listaRPTrptViewValoracionAM_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionAM_FEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0011))
            {
                listaRPTrptViewValoracionAM_FE = getDatarptViewValoracionAM_FE("MASIVO", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , objEntidad, idImpresionLog, FORMFE_0011, ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptViewValoracionAM_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0011, FOMR_VACIO);
                    formatos = formatos + FORMFE_0011 + "-";
                }
            }

            //LISTADO FORMFE_0012
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewDiagnostico_FEEdit> listaRPTrptViewDiagnostico_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewDiagnostico_FEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0012))
            {
                listaRPTrptViewDiagnostico_FE = getDatarptViewDiagnostico_FE("MASIVO", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , objEntidad, idImpresionLog, FORMFE_0012, ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptViewDiagnostico_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0012, FOMR_VACIO);
                    formatos = formatos + FORMFE_0012 + "-";
                }
            }

            //LISTADO FORMFE_0013
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenApoyoDiagnostico_FEEdit> listaRPTrptViewExamenApoyo_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenApoyoDiagnostico_FEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0013))
            {
                listaRPTrptViewExamenApoyo_FE = getDatarptViewExamenApoyoDiagnostico_FE("MASIVO", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , objEntidad, idImpresionLog, FORMFE_0013, ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptViewExamenApoyo_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0013, FOMR_VACIO);
                    formatos = formatos + FORMFE_0013 + "-";
                }
            }

            //LISTADO FORMFE_0014
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewInterconsulta_FEEdit> listaRPTrptViewInterconsulta_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewInterconsulta_FEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0014))
            {
                listaRPTrptViewInterconsulta_FE = getDatarptViewInterconsulta_FE("MASIVO", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , objEntidad, idImpresionLog, FORMFE_0014, ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptViewInterconsulta_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0014, FOMR_VACIO);
                    formatos = formatos + FORMFE_0014 + "-";
                }
            }

            //LISTADO FORMFE_0015
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewProximaAtencion_FEEdit> listaRPTrptViewProximaAtencion_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewProximaAtencion_FEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0015))
            {
                listaRPTrptViewProximaAtencion_FE = getDatarptViewProximaAtencion_FE("MASIVO", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , objEntidad, idImpresionLog, FORMFE_0015, ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptViewProximaAtencion_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0015, FOMR_VACIO);
                    formatos = formatos + FORMFE_0015 + "-";
                }
            }


            //LISTADO FORMFE_0016
            DataTable listaRPTApoyoDiagnostico = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_0016))
            {
                listaRPTApoyoDiagnostico = rptVistas_FE("rptViewApoyoDiagnostico_FE",
                            ENTITY_GLOBAL.Instance.UnidadReplicacion,
                            (int)ENTITY_GLOBAL.Instance.PacienteID,
                            (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                            (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                            null, 0,
                            ENTITY_GLOBAL.Instance.CONCEPTO,
                            ENTITY_GLOBAL.Instance.USUARIO);

                if (listaRPTApoyoDiagnostico.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0016, FOMR_VACIO);
                    formatos = formatos + FORMFE_0016 + "-";
                }
            }

            //LISTADO FORMFE_0017

            //LISTADO FORMFE_0018

            DataTable listaRPTPac_DIE = new DataTable();

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewDieta_FEEdit> listaRPTrptViewDieta1_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewDieta_FEEdit>();
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewDieta_FEEdit> listaRPTrptViewDieta2_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewDieta_FEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0018DET1))
            {
                listaRPTrptViewDieta1_FE = getDatarptViewDieta_FE("MASIVO",
                    ENTITY_GLOBAL.Instance.UnidadReplicacion,
                    (int)ENTITY_GLOBAL.Instance.PacienteID,
                    (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                    (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , null, idImpresionLog, FORMFE_0018DET1,
                    ENTITY_GLOBAL.Instance.USUARIO, 2);
                if (listaRPTrptViewDieta1_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0018DET1, FOMR_VACIO);
                    formatos = formatos + FORMFE_0018DET1 + "-";
                }

                listaRPTrptViewDieta2_FE = getDatarptViewDieta_FE("MASIVO",
                    ENTITY_GLOBAL.Instance.UnidadReplicacion,
                    (int)ENTITY_GLOBAL.Instance.PacienteID,
                    (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                    (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , null, idImpresionLog, FORMFE_0018DET2,
                    ENTITY_GLOBAL.Instance.USUARIO, 3);
                if (listaRPTrptViewDieta2_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0018DET2, FOMR_VACIO);
                    formatos = formatos + FORMFE_0018DET2 + "-";
                }

                listaRPTPac_DIE = rptDatosPacienteMedico_FE("rptViewDieta_FE",
                                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                                (int)ENTITY_GLOBAL.Instance.PacienteID,
                                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                                ENTITY_GLOBAL.Instance.USUARIO);

                if (listaRPTPac_DIE.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0018DET3, FOMR_VACIO);
                    formatos = formatos + FORMFE_0018DET3 + "-";
                }



            }

            //LISTADO FORMFE_0019    
            DataTable listaRPTPac_Med = new DataTable();

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit> listaRPTrptViewMedicamentos1_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit>();
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit> listaRPTrptViewMedicamentos2_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0019DET1))
            {
                //Subreporte 1
                listaRPTrptViewMedicamentos1_FE = getDatarptViewMedicamentos_FE("MASIVO"
                                                    , ENTITY_GLOBAL.Instance.UnidadReplicacion
                                                    , (int)ENTITY_GLOBAL.Instance.PacienteID
                                                    , (int)ENTITY_GLOBAL.Instance.EpisodioClinico
                                                    , (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                                                    , objEntidad
                                                    , idImpresionLog
                    // , FORMFE_0019
                                                   , FORMFE_0019DET1
                                                    , ENTITY_GLOBAL.Instance.USUARIO, 1);

                if (listaRPTrptViewMedicamentos1_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0019DET1, FOMR_VACIO);
                    formatos = formatos + FORMFE_0019DET1 + "-";
                }



                //Subreporte 2
                listaRPTrptViewMedicamentos2_FE = getDatarptViewMedicamentos_FE("MASIVO",
                                                     ENTITY_GLOBAL.Instance.UnidadReplicacion
                                                    , (int)ENTITY_GLOBAL.Instance.PacienteID
                                                    , (int)ENTITY_GLOBAL.Instance.EpisodioClinico
                                                    , (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                                                    , objEntidad
                                                    , idImpresionLog
                    // , FORMFE_0019
                                                   , FORMFE_0019DET2
                                                    , ENTITY_GLOBAL.Instance.USUARIO, 4);

                if (listaRPTrptViewMedicamentos2_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0019DET2, FOMR_VACIO);
                    formatos = formatos + FORMFE_0019DET2 + "-";
                }
                //Subreporte 3 aka angel

                listaRPTPac_Med = rptDatosPacienteMedico_FE("rptViewDatosPaciente_Medico",
                                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                                (int)ENTITY_GLOBAL.Instance.PacienteID,
                                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                                ENTITY_GLOBAL.Instance.USUARIO);

                if (listaRPTPac_Med.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0019DET3, FOMR_VACIO);
                    formatos = formatos + FORMFE_0019DET3 + "-";
                }
            }


            DataTable listaRPTGrupalMedicamentos = new DataTable();
            //LISTADO FORMFE_0019    
            if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" && formatosRecibidos.Contains("" + FORMFE_0019GRUPAL))
            {

                //sub reporte grupal
                listaRPTGrupalMedicamentos = rptVistas_FE("rptViewGrupalMedicamentos_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                        null, 0,
                        ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);

                if (listaRPTGrupalMedicamentos.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0019GRUPAL, FOMR_VACIO);
                    formatos = formatos + FORMFE_0019GRUPAL + "-";
                }
            }


            //LISTADO FORMFE_0020
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewEmitirDescansoMedicoFEEdit> listaRPTrptViewDescansoMedicoFE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewEmitirDescansoMedicoFEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0020))
            {
                listaRPTrptViewDescansoMedicoFE = getDatarptViewEmitirDescansoMedicoFE("MASIVO"
                                                    , ENTITY_GLOBAL.Instance.UnidadReplicacion
                                                    , (int)ENTITY_GLOBAL.Instance.PacienteID
                                                    , (int)ENTITY_GLOBAL.Instance.EpisodioClinico
                                                    , (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                                                    , objEntidad
                                                    , idImpresionLog
                                                    , FORMFE_0020
                                                    , ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptViewDescansoMedicoFE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0020, FOMR_VACIO);
                    formatos = formatos + FORMFE_0020 + "-";
                }
            }

            //LISTADO FORMFE_0021
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewEvolucionMedica_FEEdit> listaRPTrptViewEvolucionMedica_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewEvolucionMedica_FEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0021))
            {
                listaRPTrptViewEvolucionMedica_FE = getDatarptViewEvolucionMedica_FE("MASIVO"
                                                    , ENTITY_GLOBAL.Instance.UnidadReplicacion
                                                    , (int)ENTITY_GLOBAL.Instance.PacienteID
                                                    , (int)ENTITY_GLOBAL.Instance.EpisodioClinico
                                                    , (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                                                   , objEntidad
                                                    , idImpresionLog
                                                    , FORMFE_0021
                                                    , ENTITY_GLOBAL.Instance.USUARIO);
                if (listaRPTrptViewEvolucionMedica_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0021, FOMR_VACIO);
                    formatos = formatos + FORMFE_0021 + "-";
                }
            }

            #endregion

            // FORMULARIO FED
            #region FORMULARIOSFED_GETDATA

            //LISTADO FORMFE_0038




            //LISTADO FORMFE_0039


            //LISTADO FORMFE_0040

            //LISTADO FORMFE_0041
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewEscalaStewart_FEEdit> listarptVistasStewart_FE = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewEscalaStewart_FEEdit>();
            if (formatosRecibidos.Contains("" + FORMFE_0041))
            {
                listarptVistasStewart_FE = getDatarptViewEscalaStewart_FE("MASIVO"
                                                    , ENTITY_GLOBAL.Instance.UnidadReplicacion
                                                    , (int)ENTITY_GLOBAL.Instance.PacienteID
                                                    , (int)ENTITY_GLOBAL.Instance.EpisodioClinico
                                                    , (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                                                    , objEntidad
                                                    , idImpresionLog
                                                    , FORMFE_0041
                                                    , ENTITY_GLOBAL.Instance.USUARIO);

                if (listarptVistasStewart_FE.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0041, FOMR_VACIO);
                    formatos = formatos + FORMFE_0041 + "-";
                }
            }

            //LISTADO FORMFE_0042

            DataTable listarptVistasRamsay_FE = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_0042))
            {
                listarptVistasRamsay_FE = rptVistasEscalaRamsay_FE("rptViewEscalaRamsay_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID
                                       , (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                                       , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);


                if (listarptVistasRamsay_FE.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0042, FOMR_VACIO);
                    formatos = formatos + FORMFE_0042 + "-";
                }
            }

            //LISTADO FORMFE_0043
            DataTable listarptVistasRetiroVoluntario_FE1 = new DataTable();
            DataTable listarptVistasRetiroVoluntario_FE2 = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_0043))
            {
                string varVistaEntidad = "rptViewRetiroVoluntario_FE"; // Entidad Vista
                listarptVistasRetiroVoluntario_FE1 = rptVistasRetiroVoluntario_FE(varVistaEntidad, ENTITY_GLOBAL.Instance.UnidadReplicacion,
                    (int)ENTITY_GLOBAL.Instance.PacienteID
                                       , (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                                       , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

                listarptVistasRetiroVoluntario_FE2 = rptVistasRetiroVoluntario_FE(varVistaEntidad
                                    , ""
                                    , 0
                                    , 0
                                    , 0
                                    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);


                // Recorrer y asignar valores

                foreach (DataRow ht_fila in listarptVistasRetiroVoluntario_FE1.AsEnumerable())
                {

                    DataRow rw = listarptVistasRetiroVoluntario_FE2.NewRow();

                    rw["UnidadReplicacion"] = ht_fila["UnidadReplicacion"];
                    rw["IdEpisodioAtencion"] = ht_fila["IdEpisodioAtencion"];
                    rw["IdPaciente"] = ht_fila["IdPaciente"];
                    rw["EpisodioClinico"] = ht_fila["EpisodioClinico"];
                    rw["IdRetiroVoluntario"] = ht_fila["IdRetiroVoluntario"];
                    rw["FechaIngreso"] = ht_fila["FechaIngreso"];
                    rw["HoraIngreso"] = ht_fila["HoraIngreso"];
                    rw["RepresentanteLegal"] = ht_fila["RepresentanteLegal"];
                    rw["IdPersonalSalud"] = ht_fila["IdPersonalSalud"];
                    rw["UsuarioCreacion"] = ht_fila["UsuarioCreacion"];
                    rw["FechaCreacion"] = ht_fila["FechaCreacion"];
                    rw["UsuarioModificacion"] = ht_fila["UsuarioModificacion"];
                    rw["FechaModificacion"] = ht_fila["FechaModificacion"];
                    rw["Accion"] = ht_fila["Accion"];
                    rw["Version"] = ht_fila["Version"];
                    rw["ApellidoPaterno"] = ht_fila["ApellidoPaterno"];
                    rw["ApellidoMaterno"] = ht_fila["ApellidoMaterno"];
                    rw["Nombres"] = ht_fila["Nombres"];
                    rw["NombreCompleto"] = ht_fila["NombreCompleto"];
                    rw["Busqueda"] = ht_fila["Busqueda"];
                    rw["TipoDocumento"] = ht_fila["TipoDocumento"];
                    rw["Documento"] = ht_fila["Documento"];
                    rw["FechaNacimiento"] = ht_fila["FechaNacimiento"];
                    rw["Sexo"] = ht_fila["Sexo"];
                    rw["EstadoCivil"] = ht_fila["EstadoCivil"];
                    rw["PersonaEdad"] = ht_fila["PersonaEdad"];
                    rw["IdOrdenAtencion"] = ht_fila["IdOrdenAtencion"];
                    rw["CodigoOA"] = ht_fila["CodigoOA"];
                    rw["LineaOrdenAtencion"] = ht_fila["LineaOrdenAtencion"];
                    rw["TipoOrdenAtencion"] = ht_fila["TipoOrdenAtencion"];
                    rw["TipoAtencion"] = ht_fila["TipoAtencion"];
                    rw["TipoTrabajador"] = ht_fila["TipoTrabajador"];
                    rw["IdEstablecimientoSalud"] = ht_fila["IdEstablecimientoSalud"];
                    rw["IdUnidadServicio"] = ht_fila["IdUnidadServicio"];
                    rw["FechaRegistro"] = ht_fila["FechaRegistro"];
                    rw["FechaAtencion"] = ht_fila["FechaAtencion"];
                    rw["IdEspecialidad"] = ht_fila["IdEspecialidad"];
                    rw["IdTipoOrden"] = ht_fila["IdTipoOrden"];
                    rw["estadoEpiAtencion"] = ht_fila["estadoEpiAtencion"];
                    rw["ObservacionProximaEpiAtencion"] = ht_fila["ObservacionProximaEpiAtencion"];
                    rw["TipoAtencionDesc"] = ht_fila["TipoAtencionDesc"];
                    rw["TipoTrabajadorDesc"] = ht_fila["TipoTrabajadorDesc"];
                    rw["EstablecimientoCodigo"] = ht_fila["EstablecimientoCodigo"];
                    rw["EstablecimientoDesc"] = ht_fila["EstablecimientoDesc"];
                    rw["UnidadServicioCodigo"] = ht_fila["UnidadServicioCodigo"];
                    rw["UnidadServicioDesc"] = ht_fila["UnidadServicioDesc"];
                    rw["NombreCompletoPerSalud"] = ht_fila["NombreCompletoPerSalud"];
                    rw["CMP"] = ht_fila["CMP"];
                    rw["CodigoHC"] = ht_fila["CodigoHC"];
                    rw["Cama"] = ENTITY_GLOBAL.Instance.CAMA;

                    listarptVistasRetiroVoluntario_FE2.Rows.Add(rw);

                }


                if (listarptVistasRetiroVoluntario_FE2.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0043, FOMR_VACIO);
                    formatos = formatos + FORMFE_0043 + "-";
                }
            }

            //LISTADO FORMFE_0044

            DataTable listarptVistasFuncionesVitales_FE = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_0044))
            {
                listarptVistasFuncionesVitales_FE = rptVistas_FE("rptViewFuncionesVitales_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID
                                       , (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                                       , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);


                if (listarptVistasFuncionesVitales_FE.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0044, FOMR_VACIO);
                    formatos = formatos + FORMFE_0044 + "-";
                }
            }

            //LISTADO FORMFE_0045

            DataTable listarptVistasEnfermedadActual_FE = new DataTable();
            if (formatosRecibidos.Contains("" + FORMFE_0045))
            {
                listarptVistasEnfermedadActual_FE = rptVistas_FE("rptViewEnfermedadActual_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID
                                       , (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                                       , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);


                if (listarptVistasEnfermedadActual_FE.Rows.Count > 0)
                {
                    //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                    formatosRecibidos = formatosRecibidos.Replace(FORMFE_0045, FOMR_VACIO);
                    formatos = formatos + FORMFE_0045 + "-";
                }
            }


            ////LISTADO FORMFE_0005

            //DataTable listarptVistasPerGinecObstetrico_FE = new DataTable();

            //if (formatosRecibidos.Contains("" + FORMFE_0005))
            //{
            //    listarptVistasPerGinecObstetrico_FE = rptVistas_FE("rptViewAntecedentesPersGinecObstetrico_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID
            //                           , (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //                           , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);


            //    if (listarptVistasPerGinecObstetrico_FE.Rows.Count > 0)
            //    {
            //        //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
            //        formatosRecibidos = formatosRecibidos.Replace(FORMFE_0005, FOMR_VACIO);
            //        formatos = formatos + FORMFE_0005 + "-";
            //    }
            //}

            #endregion

            /**ADD DATOS GENERALES DEL REPORTES EN 'ListrptViewAgrupador'*/
            //OBS: AUX TipoEpisodio:  usado para la fórmula de mostrar o no un subreporte de acuerdo al FORMATO que contenga
            objEntidad.TipoEpisodio = formatos;

            ListrptViewAgrupador.Add(objEntidad);
            Rpt.DataSourceConnections.Clear();
            Rpt.SetDataSource(ListrptViewAgrupador);
            /********************************/

            int cantidadSubReport = Rpt.Subreports.Count;

            try
            {
                if (cantidadSubReport > 0)
                {

                    #region FORMULARIOEXTRAS_SETDATASOURCE

                    //ADD FORMFE_0001 (ok)
                    if (listaRPTInmunizacionNinio.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewInmunizacionNinio_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewInmunizacionNinio_FEsubrep.rpt"].SetDataSource(listaRPTInmunizacionNinio);
                    }


                    //ADD FORMFE_0002
                    if (listaRPTInmunizacionAdulto.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewInmunizacionAdultoRep_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewInmunizacionAdultoRep_FEsubrep.rpt"].SetDataSource(listaRPTInmunizacionAdulto);
                    }

                    //ADD FORMFE_0003
                    if (listaRPTrptViewAntPerFisiologico_FE.Count > 0)
                    {
                        Rpt.Subreports["rptViewAntecedentesPersonalesFisiologicos_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewAntecedentesPersonalesFisiologicos_FEsubrep.rpt"].SetDataSource(listaRPTrptViewAntPerFisiologico_FE);
                    }

                    //ADD FORMFE_0004
                    if (listaRPTrptViewAntFisiologicoPediatrico_FE.Count > 0)
                    {
                        Rpt.Subreports["rptViewAntFisiologicoPediatricoFEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewAntFisiologicoPediatricoFEsubrep.rpt"].SetDataSource(listaRPTrptViewAntFisiologicoPediatrico_FE);
                    }

                    //ADD FORMFE_0005
                    if (listaRPTrptAntGenerales_FE.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewAntecedentesPersonalesPatologicosGenerales_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewAntecedentesPersonalesPatologicosGenerales_FEsubrep.rpt"].SetDataSource(listaRPTrptAntGenerales_FE);
                    }
                    if (listarptVistaEpidemiologia_FE.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewEpidemiologiaCovid_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewEpidemiologiaCovid_FEsubrep.rpt"].SetDataSource(listarptVistaEpidemiologia_FE);
                    }




                    //ADD FORMFE_0006GENERALES
                    if (listaRPTrptAntGenerales_FE.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewAntecedentesPersonalesPatologicosGenerales_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewAntecedentesPersonalesPatologicosGenerales_FEsubrep.rpt"].SetDataSource(listaRPTrptAntGenerales_FE);
                    }
                    if (listaRPTrptAntGeneralesDetalle_FE.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewAntecedentesPatologicosGeneralesdetalle.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewAntecedentesPatologicosGeneralesdetalle.rpt"].SetDataSource(listaRPTrptAntGeneralesDetalle_FE);
                    }

                    //if (listaRPTrptAntGeneralesDetalle_FE.Rows.Count > 0)
                    //{
                    //    Rpt.Subreports["rptViewAntecedentesPatologicosGeneralesdetalle.rpt"].DataSourceConnections.Clear();
                    //    Rpt.Subreports["rptViewAntecedentesPatologicosGeneralesdetalle.rpt"].SetDataSource(listaRPTrptAntGeneralesDetalle_FE);
                    //}

                    //ADD FORMFE_0005Gineco
                    if (listaRPTAntGinecObstetrico.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewAntecedentesPersGinecObstetrico_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewAntecedentesPersGinecObstetrico_FEsubrep.rpt"].SetDataSource(listaRPTAntGinecObstetrico);
                    }
                    if (listaRPTAntGinecObstetricoDetalle.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewAntecedentesPersGinecObstetricodetalle.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewAntecedentesPersGinecObstetricodetalle.rpt"].SetDataSource(listaRPTAntGinecObstetricoDetalle);
                    }

                    //BALANCES DE PEDIATRIA
                    if (listaRPTBalanceHidroelectroliticoCabecera1.Rows.Count > 0)
                    {



                        Rpt.Subreports["rptViewBalanceHidroElectrolitico_PEDIATRICO_FECab1subrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewBalanceHidroElectrolitico_PEDIATRICO_FECab1subrep.rpt"].SetDataSource(listaRPTBalanceHidroelectroliticoCabecera1);



                        Rpt.Subreports["rptViewBalanceHidroElectroliticoDetalle1.rpt - 01"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewBalanceHidroElectroliticoDetalle1.rpt - 01"].SetDataSource(listaRPTBalanceHidroelectroliticoDetalle1);


                        Rpt.Subreports["rptViewBalanceHidroElectrolitico_PEDIATRICO_FECab2subrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewBalanceHidroElectrolitico_PEDIATRICO_FECab2subrep.rpt"].SetDataSource(listaRPTBalanceHidroelectroliticoCabecera2);



                        Rpt.Subreports["rptViewBalanceHidroElectroliticoDetalle2.rpt - 01"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewBalanceHidroElectroliticoDetalle2.rpt - 01"].SetDataSource(listaRPTBalanceHidroelectroliticoDetalle2);


                        Rpt.Subreports["rptViewBalanceHidroElectrolitico_PEDIATRICO_FEsubrepCab3.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewBalanceHidroElectrolitico_PEDIATRICO_FEsubrepCab3.rpt"].SetDataSource(listaRPTBalanceHidroelectroliticoCabecera3);

                    }




                    //ADD FORMFE_327ORDEN_INTERVENCIONQUIRURGICA

                    if (listaRPTCabezeraOrdenInterQuirur1.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewOrdenIntervencionQuirurgica_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewOrdenIntervencionQuirurgica_FEsubrep.rpt"].SetDataSource(listaRPTCabezeraOrdenInterQuirur1);

                        //   if (listaRPTrptDetOrdenInterQuirurDiag.Rows.Count > 0)
                        //  {
                        Rpt.Subreports["rptViewOrdenIntervenQuirurgica_DetalleDiagnostico_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewOrdenIntervenQuirurgica_DetalleDiagnostico_FEsubrep.rpt"].SetDataSource(listaRPTrptDetOrdenInterQuirurDiag);
                        //   }

                        //  if (listaRPTrptDetOrdenInterQuirurCiruProced.Rows.Count > 0)
                        //  {
                        Rpt.Subreports["rptViewOrdenIntervenQuirurgica_DetCirugiaProce_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewOrdenIntervenQuirurgica_DetCirugiaProce_FEsubrep.rpt"].SetDataSource(listaRPTrptDetOrdenInterQuirurCiruProced);
                        // }

                        // if (listaRPTCabezeraOrdenInterQuirur2.Rows.Count > 0)
                        //{
                        Rpt.Subreports["rptViewOrdenIntervencionQuirurgica_FE_Part2subrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewOrdenIntervencionQuirurgica_FE_Part2subrep.rpt"].SetDataSource(listaRPTCabezeraOrdenInterQuirur1);
                        // }

                        // if (listaRPTrptDetOrdenInterQuirurExamen1.Rows.Count > 0)
                        // {
                        Rpt.Subreports["rptViewOrdenIntervenQuirurgica_DetExamenes_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewOrdenIntervenQuirurgica_DetExamenes_FEsubrep.rpt"].SetDataSource(listaRPTrptDetOrdenInterQuirurExamen1);
                        //}

                        // if (listaRPTrptDetOrdenInterQuirurExamen2.Rows.Count > 0)
                        //  {
                        Rpt.Subreports["rptViewOrdenIntervenQuirurgica_DetExamenes_FEsubrep.rpt - 01.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewOrdenIntervenQuirurgica_DetExamenes_FEsubrep.rpt - 01.rpt"].SetDataSource(listaRPTrptDetOrdenInterQuirurExamen2);
                        // }

                        //   if (listaRPTrptDetOrdenInterQuirurExamen3.Rows.Count > 0)
                        //  {
                        Rpt.Subreports["rptViewOrdenIntervenQuirurgica_DetExamenes_FEsubrep.rpt - 02.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewOrdenIntervenQuirurgica_DetExamenes_FEsubrep.rpt - 02.rpt"].SetDataSource(listaRPTrptDetOrdenInterQuirurExamen3);
                        //  }


                        //   if (listaRPTCabezeraOrdenInterQuirur3.Rows.Count > 0)
                        //   {
                        Rpt.Subreports["rptViewOrdenIntervencionQuirurgica_FE_Part3subrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewOrdenIntervencionQuirurgica_FE_Part3subrep.rpt"].SetDataSource(listaRPTCabezeraOrdenInterQuirur1);
                        // }

                    }






                    //ADD  FORMFE_319CAB1
                    try
                    {
                        if (listaRPTNotaDeIngresoCAB1.Rows.Count > 0)
                        {
                            Rpt.Subreports["rptViewNota_De_IngresoCab1_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewNota_De_IngresoCab1_FEsubrep.rpt"].SetDataSource(listaRPTNotaDeIngresoCAB1);


                            Rpt.Subreports["rptViewNota_De_Ingreso_Diagnostico_FE.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewNota_De_Ingreso_Diagnostico_FE.rpt"].SetDataSource(listaRPTrptDetNotaDeIngresoDiag);


                            Rpt.Subreports["rptViewNota_De_IngresoCab2_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewNota_De_IngresoCab2_FEsubrep.rpt"].SetDataSource(listaRPTNotaDeIngresoCAB2);

                            Rpt.Subreports["rptViewNota_De_Ingreso_ExamenApoyo_FE.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewNota_De_Ingreso_ExamenApoyo_FE.rpt"].SetDataSource(listaRPTrptDetNotaDeIngresoExamen1);


                            Rpt.Subreports["rptViewNota_De_IngresoCab3_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewNota_De_IngresoCab3_FEsubrep.rpt"].SetDataSource(listaRPTNotaDeIngresoCAB3);


                        }


                    }
                    catch (Exception EX)
                    {
                    }



                    //ADD TOCOLOSIS FORMFE_502TOCOLOSIS
                    try
                    {
                        if (listaRPTTocolosisInduccionAcentuacion.Rows.Count > 0)
                        {


                            Rpt.Subreports["rptViewTocolosisInduccionAcentuacion_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewTocolosisInduccionAcentuacion_FEsubrep.rpt"].SetDataSource(listaRPTTocolosisInduccionAcentuacion);

                        }
                    }
                    catch (Exception EX)
                    {
                    }








                    //ADD FORMFE_402CABHELECT1 
                    try
                    {
                        if (listaRPTrptHelectrolitoNeoCAB1.Rows.Count > 0)
                        {
                            Rpt.Subreports["rptViewBalanceHidroElectroliticoCab1Neonatologia_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewBalanceHidroElectroliticoCab1Neonatologia_FEsubrep.rpt"].SetDataSource(listaRPTrptHelectrolitoNeoCAB1);

                            //   if (listaRPTrptHelectrolitoNeoDET1.Rows.Count > 0)
                            // {
                            Rpt.Subreports["rptViewBalanceHidroElectroliticoDetalle1Neonatologia_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewBalanceHidroElectroliticoDetalle1Neonatologia_FEsubrep.rpt"].SetDataSource(listaRPTrptHelectrolitoNeoDET1);
                            //     }

                            //   if (listaRPTrptHelectrolitoNeoCAB2.Rows.Count > 0)
                            //   {
                            Rpt.Subreports["rptViewBalanceHidroElectroliticoCab2Neonatologia_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewBalanceHidroElectroliticoCab2Neonatologia_FEsubrep.rpt"].SetDataSource(listaRPTrptHelectrolitoNeoCAB2);
                            //   }

                            //  if (listaRPTrptHelectrolitoNeoDET2.Rows.Count > 0)
                            //  {
                            Rpt.Subreports["rptViewBalanceHidroElectroliticoDetalle2Neonatologia_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewBalanceHidroElectroliticoDetalle2Neonatologia_FEsubrep.rpt"].SetDataSource(listaRPTrptHelectrolitoNeoDET2);
                            //  }


                            //  if (listaRPTrptHelectrolitoNeoCAB3.Rows.Count > 0)
                            //{
                            Rpt.Subreports["rptViewBalanceHidroElectroliticoCab3Neonatologia_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewBalanceHidroElectroliticoCab3Neonatologia_FEsubrep.rpt"].SetDataSource(listaRPTrptHelectrolitoNeoCAB3);

                            //}

                        }


                    }
                    catch (Exception EX)
                    {
                    }





                    //ADD FORMFE_401CABHELECT1 
                    try
                    {
                        if (listaRPTrptHelectrolitoSOPCAB1.Rows.Count > 0)
                        {
                            Rpt.Subreports["rptViewBalanceHidroElectroliticoCab1SOP_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewBalanceHidroElectroliticoCab1SOP_FEsubrep.rpt"].SetDataSource(listaRPTrptHelectrolitoSOPCAB1);


                            Rpt.Subreports["rptViewBalanceHidroElectroliticoDetalle1.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewBalanceHidroElectroliticoDetalle1.rpt"].SetDataSource(listaRPTrptHelectrolitoSOPDET1);


                            Rpt.Subreports["rptViewBalanceHidroElectroliticoCab2SOP_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewBalanceHidroElectroliticoCab2SOP_FEsubrep.rpt"].SetDataSource(listaRPTrptHelectrolitoSOPCAB2);

                            Rpt.Subreports["rptViewBalanceHidroElectroliticoDetalle2.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewBalanceHidroElectroliticoDetalle2.rpt"].SetDataSource(listaRPTrptHelectrolitoSOPDET2);


                            Rpt.Subreports["rptViewBalanceHidroElectroliticoCab3SOP_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewBalanceHidroElectroliticoCab3SOP_FEsubrep.rpt"].SetDataSource(listaRPTrptHelectrolitoSOPCAB3);


                        }


                    }
                    catch (Exception EX)
                    {
                    }



                    //ADD FORMFE_302CABHOJA HOJA RECIEN NACIDO
                    try
                    {
                        if (listaRPTrptHojaRecienNacido.Rows.Count > 0)
                        {
                            Rpt.Subreports["rptViewHojaRecienNacido_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewHojaRecienNacido_FEsubrep.rpt"].SetDataSource(listaRPTrptHojaRecienNacido);
                        }

                        if (listaRPTrptHojaRecienNacidoDetalle.Rows.Count > 0)
                        {
                            Rpt.Subreports["rptViewHojaRecienNacidoDetalle_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewHojaRecienNacidoDetalle_FEsubrep.rpt"].SetDataSource(listaRPTrptHojaRecienNacidoDetalle);
                        }

                    }
                    catch (Exception EX)
                    {
                    }


                    //ADD FORMFE_461CIRUENTRADA SEGURIDAD CIRUGIA ENTRADA
                    try
                    {
                        if (listaRPTrptSeguridadCirugiaEntradaCab.Rows.Count > 0)
                        {
                            Rpt.Subreports["rptViewSeguridadCirugiaEntrada_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewSeguridadCirugiaEntrada_FEsubrep.rpt"].SetDataSource(listaRPTrptSeguridadCirugiaEntradaCab);
                        }

                    }
                    catch (Exception EX)
                    {
                    }


                    //ADD FORMFE_462CIRUPAUSA SEGURIDAD CIRUGIA PAUSA
                    try
                    {
                        if (listaRPTrptSeguridadCirugiaPausaCab.Rows.Count > 0)
                        {
                            Rpt.Subreports["rptViewSeguridadCirugiaPausa_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewSeguridadCirugiaPausa_FEsubrep.rpt"].SetDataSource(listaRPTrptSeguridadCirugiaPausaCab);
                        }

                    }
                    catch (Exception EX)
                    {
                    }

                    //ADD FORMFE_463CIRUSALIDA SEGURIDAD CIRUGIA SALIDA
                    try
                    {
                        if (listaRPTrptSeguridadCirugiaSalidaCab.Rows.Count > 0)
                        {
                            Rpt.Subreports["rptViewSeguridadCirugiaSalida_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewSeguridadCirugiaSalida_FEsubrep.rpt"].SetDataSource(listaRPTrptSeguridadCirugiaSalidaCab);
                        }

                    }
                    catch (Exception EX)
                    {
                    }



                    //ADD FORMFE_464 ESCALA ALTA CIRUGIA AMBULATORIA
                    try
                    {
                        if (listaRPTrptEscalaAltaCirugiaAmbulatoria.Rows.Count > 0)
                        {
                            Rpt.Subreports["rptViewEscalaAltaCirugiaAmbulatoria_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewEscalaAltaCirugiaAmbulatoria_FEsubrep.rpt"].SetDataSource(listaRPTrptEscalaAltaCirugiaAmbulatoria);
                        }

                    }
                    catch (Exception EX)
                    {
                    }


                    //ADD FORMFE_323_3_ANESTESIA

                    try
                    {

                        if (listaRPTAnestesia3.Rows.Count > 0)
                        {

                            Rpt.Subreports["rptViewFichaAnestesia3_subrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewFichaAnestesia3_subrep.rpt"].SetDataSource(listaRPTAnestesia3);


                        }

                    }
                    catch (Exception EX)
                    {
                    }




                    //ADD FORMFE_323_1_ANESTESIA

                    try
                    {

                        if (listaRPTrptAnestesia1.Rows.Count > 0)
                        {
                            Rpt.Subreports["rptViewFichaAnestesia1Cabezera1_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewFichaAnestesia1Cabezera1_FEsubrep.rpt"].SetDataSource(listaRPTrptAnestesia1);


                            //if (listaRPTrptAnestesia1Detalle_1.Rows.Count > 0)
                            //{
                            Rpt.Subreports["rptViewFichaAnestesia_1_ExamenesDetalle1_subrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewFichaAnestesia_1_ExamenesDetalle1_subrep.rpt"].SetDataSource(listaRPTrptAnestesia1Detalle_1);
                            //}

                            Rpt.Subreports["rptViewFichaAnestesia1Cabezera2_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewFichaAnestesia1Cabezera2_FEsubrep.rpt"].SetDataSource(listaRPTrptAnestesiaCab2);



                            Rpt.Subreports["rptViewFichaAnestesia_1_DiagnosticosDetalle1_subrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewFichaAnestesia_1_DiagnosticosDetalle1_subrep.rpt"].SetDataSource(listaRPTrptAnestesia1Detalle_2);

                            Rpt.Subreports["rptViewFichaAnestesia_1_ExamenesDetalle1_subrep.rpt - 01"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewFichaAnestesia_1_ExamenesDetalle1_subrep.rpt - 01"].SetDataSource(listaRPTrptAnestesia1Detalle_3);

                            Rpt.Subreports["rptViewFichaAnestesia_1_DiagnosticosDetalle1_subrep.rpt - 01"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewFichaAnestesia_1_DiagnosticosDetalle1_subrep.rpt - 01"].SetDataSource(listaRPTrptAnestesia1Detalle_4);

                            Rpt.Subreports["rptViewFichaAnestesia_1_ExamenesDetalle1_subrep.rpt - 02"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewFichaAnestesia_1_ExamenesDetalle1_subrep.rpt - 02"].SetDataSource(listaRPTrptAnestesia1Detalle_5);



                            Rpt.Subreports["rptViewFichaAnestesia1Cabezera3_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewFichaAnestesia1Cabezera3_FEsubrep.rpt"].SetDataSource(listaRPTrptAnestesiaCab3);





                        }


                    }
                    catch (Exception EX)
                    {
                    }



                    //ADD FORMFE_153
                    if (listaRPTrptExamenClinico.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewExamenClinico_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewExamenClinico_FEsubrep.rpt"].SetDataSource(listaRPTrptExamenClinico);
                    }



                    //ADD FORMFE_328
                    if (listaRPTrptNOTADEENFERMERA.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptView_NotadeEnfermeriaFEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptView_NotadeEnfermeriaFEsubrep.rpt"].SetDataSource(listaRPTrptNOTADEENFERMERA);
                    }


                    //ADD FORMFE_103
                    if (listaRPTrptNOFARMACOLOGICO.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewMedicamentoNoFarmacologicoFEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewMedicamentoNoFarmacologicoFEsubrep.rpt"].SetDataSource(listaRPTrptNOFARMACOLOGICO);
                    }


                    if (listaRPTrptOftalmologico.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewOftalmologico_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewOftalmologico_FEsubrep.rpt"].SetDataSource(listaRPTrptOftalmologico);
                    }

                    if (listaRPTrptReferencia.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewReferencia_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewReferencia_FEsubrep.rpt"].SetDataSource(listaRPTrptReferencia);
                    }

                    if (listaRPTrptVigilanciaCateterPeriferico.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewVigilanciaCateterPeriferico_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewVigilanciaCateterPeriferico_FEsubrep.rpt"].SetDataSource(listaRPTrptVigilanciaCateterPeriferico);
                    }

                    if (listaRPTrptVigilanciaCateterUrinario.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewVigilanciaCateterUrinario_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewVigilanciaCateterUrinario_FEsubrep.rpt"].SetDataSource(listaRPTrptVigilanciaCateterUrinario);
                    }

                    if (listaRPTrptVigilanciaVentilacionMecanica.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewVigilanciaVentilacionMecanica_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewVigilanciaVentilacionMecanica_FEsubrep.rpt"].SetDataSource(listaRPTrptVigilanciaVentilacionMecanica);
                    }

                    if (listaRPTrptVigilanciaDispositivos.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewVigilanciaDispositivos_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewVigilanciaDispositivos_FEsubrep.rpt"].SetDataSource(listaRPTrptVigilanciaDispositivos);
                    }

                    if (listaRPTrptDolorEvaNinio.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewDolorEvaNinios_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewDolorEvaNinios_FEsubrep.rpt"].SetDataSource(listaRPTrptDolorEvaNinio);
                    }

                    if (listaRPTrptEscalaAldrete.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewEscalaAldrete_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewEscalaAldrete_FEsubrep.rpt"].SetDataSource(listaRPTrptEscalaAldrete);
                    }

                    if (listaRPTrptEscalaBromage.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewEscalaBromage_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewEscalaBromage_FEsubrep.rpt"].SetDataSource(listaRPTrptEscalaBromage);
                    }
                    if (listaRPTrptEscalaSedacionRass.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewEscalaSedacionRass_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewEscalaSedacionRass_FEsubrep.rpt"].SetDataSource(listaRPTrptEscalaSedacionRass);
                    }

                    if (listaRPTrptGradoDependencia.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewGradoDependencia_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewGradoDependencia_FEsubrep.rpt"].SetDataSource(listaRPTrptGradoDependencia);
                    }

                    if (listaRPTrptDolorEvaAdulto.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewDolorEvaAdulto_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewDolorEvaAdulto_FEsubrep.rpt"].SetDataSource(listaRPTrptDolorEvaAdulto);
                    }
                    if (listaRPTrptEscalaNorton.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewEscalaNorton_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewEscalaNorton_FEsubrep.rpt"].SetDataSource(listaRPTrptEscalaNorton);
                    }


                    if (listaRPTrptEscalaRamsay.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewEscalaRamsay_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewEscalaRamsay_FEsubrep.rpt"].SetDataSource(listaRPTrptEscalaRamsay);
                    }
                    if (listaRPTrptPreOperatorio_1.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewPreOperatorio_1_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewPreOperatorio_1_FEsubrep.rpt"].SetDataSource(listaRPTrptPreOperatorio_1);
                    }

                    if (listaRPTrptPreOperatorio_2.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewPreOperatorio2subrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewPreOperatorio2subrep.rpt"].SetDataSource(listaRPTrptPreOperatorio_2);
                    }

                    //BALANCE HIDROELECTROLITCO NORMAL

                    if (listaRPTrptBalanceElectroliticoNormal.Rows.Count > 0)
                    {

                        Rpt.Subreports["rptViewBalanceHidroElectrolitico_NORMAL_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewBalanceHidroElectrolitico_NORMAL_FEsubrep.rpt"].SetDataSource(listaRPTrptBalanceElectroliticoNormal);

                        Rpt.Subreports["rptViewBalanceHidroElectroliticoDetalle1.rpt - 02"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewBalanceHidroElectroliticoDetalle1.rpt - 02"].SetDataSource(listaRPTrptBalanceElectroliticoNormalDetalle1);

                        Rpt.Subreports["rptViewBalanceHidroElectrolitico_NORMAL_CAB2_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewBalanceHidroElectrolitico_NORMAL_CAB2_FEsubrep.rpt"].SetDataSource(listaRPTrptBalanceElectroliticoNormalCab2);

                        Rpt.Subreports["rptViewBalanceHidroElectroliticoDetalle2.rpt - 02"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewBalanceHidroElectroliticoDetalle2.rpt - 02"].SetDataSource(listaRPTrptBalanceElectroliticoNormalDetalle2);

                        Rpt.Subreports["rptViewBalanceHidroElectrolitico_NORMAL_CAB3_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewBalanceHidroElectrolitico_NORMAL_CAB3_FEsubrep.rpt"].SetDataSource(listaRPTrptBalanceElectroliticoNormalCab3);


                    }


                    if (listaRPTrptKardex1_Detalle1.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewKardex1_Detalle1subrep.rpt.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewKardex1_Detalle1subrep.rpt.rpt"].SetDataSource(listaRPTrptKardex1_Detalle1);
                    }


                    //if (listaRPTrptKardex1.Rows.Count > 0)
                    //{
                    //    Rpt.Subreports["rptViewKardex_1Diagnostico_FEsubrep.rpt"].DataSourceConnections.Clear();
                    //    Rpt.Subreports["rptViewKardex_1Diagnostico_FEsubrep.rpt"].SetDataSource(listaRPTrptKardex1);
                    //}



                    if (listaRPTrptContrareferencia.Count > 0)
                    {
                        Rpt.Subreports["rptViewContrarReferencia_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewContrarReferencia_FEsubrep.rpt"].SetDataSource(listaRPTrptContrareferencia);
                    }



                    if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "TRIAJE")
                    {
                        if (listaRPTrptTriajeEmergencia.Rows.Count > 0)
                        {
                            Rpt.Subreports["rptViewTriajeEmergencia_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewTriajeEmergencia_FEsubrep.rpt"].SetDataSource(listaRPTrptTriajeEmergencia);
                        }

                        if (listaRPTrptViewTriajeAlergias_FE.Rows.Count > 0)
                        {
                            Rpt.Subreports["rptViewTriajeAlergias_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewTriajeAlergias_FEsubrep.rpt"].SetDataSource(listaRPTrptViewTriajeAlergias_FE);
                        }

                        if (listaRPTrptViewTriajeAlergias_FEDetalle1.Rows.Count == 0)
                        {
                            Rpt.Subreports["rptViewTriajeAlergias_FEDetalle1subrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewTriajeAlergias_FEDetalle1subrep.rpt"].SetDataSource(listaRPTrptViewTriajeAlergias_FEDetalle1);


                        }
                        else
                        {
                            Rpt.Subreports["rptViewTriajeAlergias_FEDetalle1subrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewTriajeAlergias_FEDetalle1subrep.rpt"].SetDataSource(listaRPTrptViewTriajeAlergias_FEDetalle1);
                        }


                        if (listaRPTrptViewTriajeAlergias_FE2.Rows.Count > 0)
                        {
                            Rpt.Subreports["rptViewTriajeAlergiasParte2_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewTriajeAlergiasParte2_FEsubrep.rpt"].SetDataSource(listaRPTrptViewTriajeAlergias_FE2);
                        }

                        if (listaRPTrptViewTriajeAlergias_FEDetalle2.Rows.Count == 0)
                        {
                            Rpt.Subreports["rptViewTriajeAlergias_FEDetalle2subrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewTriajeAlergias_FEDetalle2subrep.rpt"].SetDataSource(listaRPTrptViewTriajeAlergias_FEDetalle2);

                        }
                        else
                        {
                            Rpt.Subreports["rptViewTriajeAlergias_FEDetalle2subrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewTriajeAlergias_FEDetalle2subrep.rpt"].SetDataSource(listaRPTrptViewTriajeAlergias_FEDetalle2);
                        }

                        if (listaRPTrptViewTriajeAlergias_FE3.Rows.Count > 0)
                        {
                            Rpt.Subreports["rptViewTriajeAlergiasParte3_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewTriajeAlergiasParte3_FEsubrep.rpt"].SetDataSource(listaRPTrptViewTriajeAlergias_FE3);
                        }



                    }

                    if (listarptInformeAlta_DatosGenerales_FE.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewInformeAlta_DatosGenerales_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewInformeAlta_DatosGenerales_FEsubrep.rpt"].SetDataSource(listarptInformeAlta_DatosGenerales_FE);


                        Rpt.Subreports["rptViewInformeAlta_medsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewInformeAlta_medsubrep.rpt"].SetDataSource(listarptInformeAlta_Med_FE);

                        Rpt.Subreports["rptViewInformeAlta_matsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewInformeAlta_matsubrep.rpt"].SetDataSource(listarptInformeAlta_Mat_FE);

                        Rpt.Subreports["rptViewInformeAlta_proxCitassubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewInformeAlta_proxCitassubrep.rpt"].SetDataSource(listarptInformeAlta_ProxCita_FE);


                    }

                    //if (listarptInformeAlta_Med_FE.Rows.Count > 0)
                    //{

                    //}
                    //if (listarptInformeAlta_Mat_FE.Rows.Count > 0)
                    //{
                    //    Rpt.Subreports["rptViewInformeAlta_matsubrep.rpt"].DataSourceConnections.Clear();
                    //    Rpt.Subreports["rptViewInformeAlta_matsubrep.rpt"].SetDataSource(listarptInformeAlta_Mat_FE);
                    //}
                    //if (listarptInformeAlta_ProxCita_FE.Rows.Count > 0)
                    //{
                    //    Rpt.Subreports["rptViewInformeAlta_proxCitassubrep.rpt"].DataSourceConnections.Clear();
                    //    Rpt.Subreports["rptViewInformeAlta_proxCitassubrep.rpt"].SetDataSource(listarptInformeAlta_ProxCita_FE);
                    //}

                    if (listaRPTrptRetiroVoluntario.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewRetiroVoluntario_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewRetiroVoluntario_FEsubrep.rpt"].SetDataSource(listaRPTrptRetiroVoluntario);
                    }

                    //ADD FORMFE_0006 (ok)
                    if (listarptViewAlergias_FE.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewAlergia_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewAlergia_FEsubrep.rpt"].SetDataSource(listarptViewAlergias_FE);
                    }



                    //ADD FORMFE_0007
                    if (listarptAnt_Familiares.Count > 0)
                    {
                        Rpt.Subreports["rptViewAnamnesis_ANTFAM_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewAnamnesis_ANTFAM_FEsubrep.rpt"].SetDataSource(listarptAnt_Familiares);
                    }

                    //ADD FORMFE_0008
                    if (listarptView_ValoracionFuncionalAM_FE.Count > 0)
                    {
                        Rpt.Subreports["rptView_ValoracionFuncionalAM_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptView_ValoracionFuncionalAM_FEsubrep.rpt"].SetDataSource(listarptView_ValoracionFuncionalAM_FE);
                    }

                    //ADD FORMFE_0009
                    if (listarptViewValoracionMentalAM_FE.Count > 0)
                    {
                        Rpt.Subreports["rptViewValoracionMentalAM_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewValoracionMentalAM_FEsubrep.rpt"].SetDataSource(listarptViewValoracionMentalAM_FE);
                    }

                    //ADD FORMFE_0010
                    if (listaRPTrptViewValoracionSocioFamAM_FE.Count > 0)
                    {
                        Rpt.Subreports["rptViewValoracionSocioFamAM_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewValoracionSocioFamAM_FEsubrep.rpt"].SetDataSource(listaRPTrptViewValoracionSocioFamAM_FE);
                    }


                    //ADD FORMFE_0011
                    if (listaRPTrptViewValoracionAM_FE.Count > 0)
                    {
                        Rpt.Subreports["rptViewValoracionAM_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewValoracionAM_FEsubrep.rpt"].SetDataSource(listaRPTrptViewValoracionAM_FE);
                    }

                    //ADD FORMFE_0012 (ok)
                    if (listaRPTrptViewDiagnostico_FE.Count > 0)
                    {
                        Rpt.Subreports["rptViewDiagnostico_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewDiagnostico_FEsubrep.rpt"].SetDataSource(listaRPTrptViewDiagnostico_FE);
                    }

                    //ADD FORMFE_0013
                    if (listaRPTrptViewExamenApoyo_FE.Count > 0)
                    {
                        Rpt.Subreports["rptViewExamenApoyo_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewExamenApoyo_FEsubrep.rpt"].SetDataSource(listaRPTrptViewExamenApoyo_FE);
                    }


                    //ADD FORMFE_0014  
                    if (listaRPTrptViewInterconsulta_FE.Count > 0)
                    {
                        Rpt.Subreports["rptViewInterconsulta_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewInterconsulta_FEsubrep.rpt"].SetDataSource(listaRPTrptViewInterconsulta_FE);
                    }

                    //ADD FORMFE_0015       
                    if (listaRPTrptViewProximaAtencion_FE.Count > 0)
                    {
                        Rpt.Subreports["rptViewProximaAtencion_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewProximaAtencion_FEsubrep.rpt"].SetDataSource(listaRPTrptViewProximaAtencion_FE);
                    }

                    //ADD FORMFE_0016             
                    if (listaRPTApoyoDiagnostico.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewApoyoDiagnosticoRep_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewApoyoDiagnosticoRep_FEsubrep.rpt"].SetDataSource(listaRPTApoyoDiagnostico);
                    }
                    //ADD FORMFE_0017

                    //ADD FORMFE_0018    
                    if (listaRPTrptViewDieta1_FE.Count > 0 || listaRPTrptViewDieta2_FE.Count > 0)
                    {

                        Rpt.Subreports["rptViewDieta_FEDetalle1.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewDieta_FEDetalle1.rpt"].SetDataSource(listaRPTrptViewDieta1_FE);


                        Rpt.Subreports["rptViewDieta_FEDetalle2.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewDieta_FEDetalle2.rpt"].SetDataSource(listaRPTrptViewDieta2_FE);
                    }


                    if (listaRPTPac_DIE.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewDietaSupFirma.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewDietaSupFirma.rpt"].SetDataSource(listaRPTPac_DIE);
                    }




                    //ADD FORMFE_0019  (ok)    
                    if (listaRPTrptViewMedicamentos1_FE.Count > 0 || listaRPTrptViewMedicamentos2_FE.Count > 0)
                    {
                        if (listaRPTrptViewMedicamentos1_FE.Count == 0) // Argega Cabecera de 
                        {
                            DataTable listaRPT = new DataTable();
                            listaRPT = rptVistas_FE("rptViewMedicamentos_FE",
                          ENTITY_GLOBAL.Instance.UnidadReplicacion,
                          (int)ENTITY_GLOBAL.Instance.PacienteID,
                          (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                          (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                          , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                          ENTITY_GLOBAL.Instance.USUARIO);


                            /*if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA")
                            {
                                Rpt.Subreports["rptViewMedicamentos_EMEFEsubrep.rpt"].DataSourceConnections.Clear();
                                Rpt.Subreports["rptViewMedicamentos_EMEFEsubrep.rpt"].SetDataSource(listaRPT);
                            }
                            else
                            {
                                Rpt.Subreports["rptViewMedicamentos_FEsubrep.rpt"].DataSourceConnections.Clear();
                                Rpt.Subreports["rptViewMedicamentos_FEsubrep.rpt"].SetDataSource(listaRPT);
                            }*/
                            Rpt.Subreports["rptViewMedicamentos_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewMedicamentos_FEsubrep.rpt"].SetDataSource(listaRPT);

                        }
                        else
                        {
                            /*if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA")
                            {
                                Rpt.Subreports["rptViewMedicamentos_EMEFEsubrep.rpt"].DataSourceConnections.Clear();
                                Rpt.Subreports["rptViewMedicamentos_EMEFEsubrep.rpt"].SetDataSource(listaRPTrptViewMedicamentos1_FE);
                            }
                            else
                            {
                                Rpt.Subreports["rptViewMedicamentos_FEsubrep.rpt"].DataSourceConnections.Clear();
                                Rpt.Subreports["rptViewMedicamentos_FEsubrep.rpt"].SetDataSource(listaRPTrptViewMedicamentos1_FE);
                            }*/
                            Rpt.Subreports["rptViewMedicamentos_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewMedicamentos_FEsubrep.rpt"].SetDataSource(listaRPTrptViewMedicamentos1_FE);

                        }

                        Rpt.Subreports["rptViewMedicamentos_FEsubrep2.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewMedicamentos_FEsubrep2.rpt"].SetDataSource(listaRPTrptViewMedicamentos2_FE);

                        if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" && listaRPTGrupalMedicamentos.Rows.Count > 0)
                        {
                            Rpt.Subreports["rptViewMedicamentos_FEDetalle2Grupalsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewMedicamentos_FEDetalle2Grupalsubrep.rpt"].SetDataSource(listaRPTGrupalMedicamentos);
                        }

                    }
                    if (listaRPTPac_Med.Rows.Count > 0)
                    {
                        /*if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA")
                        {
                            Rpt.Subreports["rptViewMedicamentos_EMEFEsubrepFirmas.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewMedicamentos_EMEFEsubrepFirmas.rpt"].SetDataSource(listaRPTPac_Med);
                        }
                        else
                        {
                            Rpt.Subreports["rptViewMedicamentos_FEsubrepFirmas.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewMedicamentos_FEsubrepFirmas.rpt"].SetDataSource(listaRPTPac_Med);
                        }*/
                        Rpt.Subreports["rptViewMedicamentos_FEsubrepFirmas.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewMedicamentos_FEsubrepFirmas.rpt"].SetDataSource(listaRPTPac_Med);
                    }





                    //ADD FORMFE_0020     (ok)
                    if (listaRPTrptViewDescansoMedicoFE.Count > 0)
                    {
                        Rpt.Subreports["rptViewEmitirDescansoMedicoFEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewEmitirDescansoMedicoFEsubrep.rpt"].SetDataSource(listaRPTrptViewDescansoMedicoFE);
                    }
                    //ADD FORMFE_0021  
                    if (listaRPTrptViewEvolucionMedica_FE.Count > 0)
                    {
                        try
                        {
                            Rpt.Subreports["rptViewEvolucionMedica_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewEvolucionMedica_FEsubrep.rpt"].SetDataSource(listaRPTrptViewEvolucionMedica_FE);

                        }
                        catch (Exception)
                        {
                            Response.Write("<script language=javascript>alert('No se encuentra el subreporte rptViewEvolucionMedica_FEsubrep');</script>");
                            //throw;
                        }
                    }

                    #endregion

                    #region FORMULARIOFED_SETDATASOURCE_ADJUNTO

                    //ADD FORMFE_0038     
                    if (listarptVistasGlasgow_FE.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewEscalaGlasgow_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewEscalaGlasgow_FEsubrep.rpt"].SetDataSource(listarptVistasGlasgow_FE);
                    }


                    //ADD FORMFE_0038     
                    if (listarptVistasGlasgowPreEscolar_FE.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewEscalaGlasgowPreEscolar_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewEscalaGlasgowPreEscolar_FEsubrep.rpt"].SetDataSource(listarptVistasGlasgowPreEscolar_FE);
                    }




                    // ADD FORMFE _530


                    if (listarptVistasSolucitud_Transfusional_FE.Rows.Count > 0)
                    {
                        try
                        {
                            Rpt.Subreports["rptViewSolucitud_Transfusional_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewSolucitud_Transfusional_FEsubrep.rpt"].SetDataSource(listarptVistasSolucitud_Transfusional_FE);

                        }

                        catch (Exception)
                        {
                        }

                    }


                    // ADD FORMFE _531


                    if (listarptVistasEscalaWoodDownes_FE.Rows.Count > 0)
                    {
                        try
                        {
                            Rpt.Subreports["rptViewEscalaWoodDownes_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewEscalaWoodDownes_FEsubrep.rpt"].SetDataSource(listarptVistasEscalaWoodDownes_FE);

                        }

                        catch (Exception)
                        {
                        }

                    }

                    // ADD FORMFE _532


                    if (listarptVistaEvaluacionDolorEvaNeonatosPrematuros_FE.Rows.Count > 0)
                    {
                        try
                        {
                            Rpt.Subreports["rptViewEvaluacionDolorEvaNeonatosPrematuros_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewEvaluacionDolorEvaNeonatosPrematuros_FEsubrep.rpt"].SetDataSource(listarptVistaEvaluacionDolorEvaNeonatosPrematuros_FE);

                        }

                        catch (Exception)
                        {
                        }

                    }

                    //ADD FORMFE_0040     
                    if (listarptVistasGlasgowLactante_FE.Rows.Count > 0)
                    {
                        Rpt.Subreports["rptViewEscalaGlasgowLactante_FEsubrep.rpt"].DataSourceConnections.Clear();
                        Rpt.Subreports["rptViewEscalaGlasgowLactante_FEsubrep.rpt"].SetDataSource(listarptVistasGlasgowLactante_FE);
                    }

                    //ADD FORMFE_0041  
                    if (listarptVistasStewart_FE.Count > 0)
                    {
                        try
                        {
                            Rpt.Subreports["rptViewEscalaStewart_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewEscalaStewart_FEsubrep.rpt"].SetDataSource(listarptVistasStewart_FE);

                        }
                        catch (Exception)
                        {

                            //Response.Write("<script language=javascript>alert('No se encuentra el subreporte rptViewEscalaStewart_FEsubrep');</script>");
                            //throw;
                        }
                    }

                    //ADD FORMFE_0042
                    if (listarptVistasRamsay_FE.Rows.Count > 0)
                    {
                        try
                        {
                            Rpt.Subreports["rptViewEscalaRamsay_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewEscalaRamsay_FEsubrep.rpt"].SetDataSource(listarptVistasRamsay_FE);
                        }
                        catch (Exception)
                        {
                        }

                    }

                    //ADD FORMFE_0043
                    if (listarptVistasRetiroVoluntario_FE2.Rows.Count > 0)
                    {
                        try
                        {
                            Rpt.Subreports["rptViewRetiroVoluntario_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewRetiroVoluntario_FEsubrep.rpt"].SetDataSource(listarptVistasRetiroVoluntario_FE2);

                        }
                        catch (Exception)
                        {
                        }
                    }

                    //ADD FORMFE_0044
                    if (listarptVistasFuncionesVitales_FE.Rows.Count > 0)
                    {
                        try
                        {
                            Rpt.Subreports["rptViewFuncionesVitale_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewFuncionesVitale_FEsubrep.rpt"].SetDataSource(listarptVistasFuncionesVitales_FE);

                        }
                        catch (Exception)
                        {
                        }
                    }

                    //ADD FORMFE_0045
                    if (listarptVistasEnfermedadActual_FE.Rows.Count > 0)
                    {
                        try
                        {
                            Rpt.Subreports["rptViewEnfermedadActual_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewEnfermedadActual_FEsubrep.rpt"].SetDataSource(listarptVistasEnfermedadActual_FE);

                        }
                        catch (Exception)
                        {
                        }
                    }

                    ////ADD FORMFE_0005GINECO
                    //if (listarptVistasPerGinecObstetrico_FE.Rows.Count > 0)
                    //{
                    //    try
                    //    {
                    //        Rpt.Subreports["rptViewAntecedentesPersGinecObstetrico_FEsubrep.rpt"].DataSourceConnections.Clear();
                    //        Rpt.Subreports["rptViewAntecedentesPersGinecObstetrico_FEsubrep.rpt"].SetDataSource(listarptVistasPerGinecObstetrico_FE);

                    //    }
                    //    catch (Exception)
                    //    {
                    //    }
                    //}







                    #endregion

                }
            }
            catch (Exception ex)
            {
                Log.Error(ex, ex.Message);
                LOGgineco(this, ex);
                throw;
            }


            /**ADD PARÁMETROS*/
            #region FORMULARIOINICALES_SETPARAMETER
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            imgFirma = Server.MapPath((string)Session["FIRMA_DIGITAL"]);
            Rpt.SetParameterValue("imgFirma", imgFirma);

            imgFirma2 = Server.MapPath((string)Session["FIRMA_DIGITAL"]);
            Rpt.SetParameterValue("imgFirma2", imgFirma2);

            imgFirmaContrare = Server.MapPath((string)Session["FIRMA_DIGITALCONTRAREFE"]);
            Rpt.SetParameterValue("imgFirmaContrare", imgFirmaContrare);

            imgFirmaDieta = Server.MapPath((string)Session["FIRMA_DIGITAL"]);
            Rpt.SetParameterValue("imgFirmaDieta", imgFirmaDieta);

            imgFirmaRetiro = Server.MapPath((string)Session["FIRMA_DIGITAL"]);
            Rpt.SetParameterValue("imgFirmaRetiro", imgFirmaRetiro);

            imgFirmaTransfuncional = Server.MapPath((string)Session["FIRMA_DIGITAL"]);
            Rpt.SetParameterValue("imgFirmaTransfuncional", imgFirmaTransfuncional);

            Rpt.SetParameterValue("FORM_0000", FORM_0000);
            Rpt.SetParameterValue("FORM_0001", FORM_0001);
            Rpt.SetParameterValue("FORM_0002", FORM_0002);
            Rpt.SetParameterValue("FORM_0003", FORM_0003);
            Rpt.SetParameterValue("FORM_0004", FORM_0004);
            Rpt.SetParameterValue("FORM_0005", FORM_0005);
            Rpt.SetParameterValue("FORM_0006", FORM_0006);
            Rpt.SetParameterValue("FORM_0007", FORM_0007);
            Rpt.SetParameterValue("FORM_0008", FORM_0008);
            Rpt.SetParameterValue("FORM_0009", FORM_0009);
            Rpt.SetParameterValue("FORM_0010", FORM_0010);
            Rpt.SetParameterValue("FORM_0011", FORM_0011);
            Rpt.SetParameterValue("FORM_0012", FORM_0012);
            #endregion

            #region FORMULARIOEXTRAS_SETPARAMETER

            Rpt.SetParameterValue("FORMFE_0001", FORMFE_0001);
            Rpt.SetParameterValue("FORMFE_0002", FORMFE_0002);
            Rpt.SetParameterValue("FORMFE_0003", FORMFE_0003);
            Rpt.SetParameterValue("FORMFE_0004", FORMFE_0004);
            Rpt.SetParameterValue("FORMFE_0005CABGINECO", FORMFE_0005CABGINECO);
            Rpt.SetParameterValue("FORMFE_0005DETGINECO", FORMFE_0005DETGINECO);


            Rpt.SetParameterValue("FORMFE_600", FORMFE_600);
            Rpt.SetParameterValue("FORMFE_600_1", FORMFE_600_1);
            Rpt.SetParameterValue("FORMFE_600_2", FORMFE_600_2);
            Rpt.SetParameterValue("FORMFE_600_3", FORMFE_600_3);
            Rpt.SetParameterValue("FORMFE_600_4", FORMFE_600_4);
            Rpt.SetParameterValue("FORMFE_327CAB", FORMFE_327CAB);
            Rpt.SetParameterValue("FORMFE_327CAB2", FORMFE_327CAB2);
            Rpt.SetParameterValue("FORMFE_327CAB3", FORMFE_327CAB3);
            Rpt.SetParameterValue("FORMFE_327DIAG", FORMFE_327DIAG);
            Rpt.SetParameterValue("FORMFE_327CIRUGIAPRO", FORMFE_327CIRUGIAPRO);
            Rpt.SetParameterValue("FORMFE_327EXAMEN1", FORMFE_327EXAMEN1);
            Rpt.SetParameterValue("FORMFE_327EXAMEN2", FORMFE_327EXAMEN2);
            Rpt.SetParameterValue("FORMFE_327EXAMEN3", FORMFE_327EXAMEN3);


            Rpt.SetParameterValue("FORMFE_319CAB1", FORMFE_319CAB1);
            Rpt.SetParameterValue("FORMFE_319CAB2", FORMFE_319CAB2);
            Rpt.SetParameterValue("FORMFE_319CAB3", FORMFE_319CAB3);
            Rpt.SetParameterValue("FORMFE_319DIAG", FORMFE_319DIAG);
            Rpt.SetParameterValue("FORMFE_319EXAMEN1", FORMFE_319EXAMEN1);

            Rpt.SetParameterValue("FORMFE_502TOCOLOSIS", FORMFE_502TOCOLOSIS);


            Rpt.SetParameterValue("FORMFE_402CABHELECT1", FORMFE_402CABHELECT1);
            Rpt.SetParameterValue("FORMFE_402CABHELECT2", FORMFE_402CABHELECT2);
            Rpt.SetParameterValue("FORMFE_402CABHELECT3", FORMFE_402CABHELECT3);
            Rpt.SetParameterValue("FORMFE_402DETHELECT1", FORMFE_402DETHELECT1);
            Rpt.SetParameterValue("FORMFE_402DETHELECT2", FORMFE_402DETHELECT2);


            Rpt.SetParameterValue("FORMFE_401CABHELECT1", FORMFE_401CABHELECT1);
            Rpt.SetParameterValue("FORMFE_401CABHELECT2", FORMFE_401CABHELECT2);
            Rpt.SetParameterValue("FORMFE_401CABHELECT3", FORMFE_401CABHELECT3);
            Rpt.SetParameterValue("FORMFE_401DETHELECT1", FORMFE_401DETHELECT1);
            Rpt.SetParameterValue("FORMFE_401DETHELECT2", FORMFE_401DETHELECT2);



            Rpt.SetParameterValue("FORMFE_302CABHOJA", FORMFE_302CABHOJA);
            Rpt.SetParameterValue("FORMFE_302DETHOJA", FORMFE_302DETHOJA);
            Rpt.SetParameterValue("FORMFE_461CIRUENTRADA", FORMFE_461CIRUENTRADA);

            Rpt.SetParameterValue("FORMFE_462CIRUPAUSA", FORMFE_462CIRUPAUSA);
            Rpt.SetParameterValue("FORMFE_463CIRUSALIDA", FORMFE_463CIRUSALIDA);

            Rpt.SetParameterValue("FORMFE_464", FORMFE_464);
            Rpt.SetParameterValue("FORMFE_323_3CAB_ANESTESIA3", FORMFE_323_3CAB_ANESTESIA3);
            Rpt.SetParameterValue("FORMFE_323_1CABANESTESIA", FORMFE_323_1CABANESTESIA);
            Rpt.SetParameterValue("FORMFE_323_1CABANESTESIA2", FORMFE_323_1CABANESTESIA2);
            Rpt.SetParameterValue("FORMFE_323_1DET1_ANESTESIA", FORMFE_323_1DET1_ANESTESIA);

            Rpt.SetParameterValue("FORMFE_323_1DET1_ANESDIAG1", FORMFE_323_1DET1_ANESDIAG1);
            Rpt.SetParameterValue("FORMFE_323_1DET1_ANESEXAM2", FORMFE_323_1DET1_ANESEXAM2);
            Rpt.SetParameterValue("FORMFE_323_1DET1_ANESDIAG2", FORMFE_323_1DET1_ANESDIAG2);
            Rpt.SetParameterValue("FORMFE_323_1DET1_ANESEXAM3", FORMFE_323_1DET1_ANESEXAM3);
            Rpt.SetParameterValue("FORMFE_323_1CABANESTESIA3", FORMFE_323_1CABANESTESIA3);



            Rpt.SetParameterValue("FORMFE_0005CAB", FORMFE_0005CAB);
            Rpt.SetParameterValue("FORMFE_0005DET", FORMFE_0005DET);
            Rpt.SetParameterValue("FORMFE_153", FORMFE_153);

            Rpt.SetParameterValue("FORMFE_328", FORMFE_328);

            Rpt.SetParameterValue("FORMFE_103", FORMFE_103);

            Rpt.SetParameterValue("FORMFE_510", FORMFE_510);
            Rpt.SetParameterValue("FORMFE_202", FORMFE_202);

            Rpt.SetParameterValue("FORMFE_511", FORMFE_511);
            Rpt.SetParameterValue("FORMFE_512", FORMFE_512);
            Rpt.SetParameterValue("FORMFE_521", FORMFE_521);
            Rpt.SetParameterValue("FORMFE_513", FORMFE_513);
            Rpt.SetParameterValue("FORMFE_514", FORMFE_514);

            Rpt.SetParameterValue("FORMFE_515", FORMFE_515);
            Rpt.SetParameterValue("FORMFE_561", FORMFE_561);
            Rpt.SetParameterValue("FORMFE_560", FORMFE_560);


            Rpt.SetParameterValue("FORMFE_562", FORMFE_562);
            Rpt.SetParameterValue("FORMFE_563", FORMFE_563);
            Rpt.SetParameterValue("FORMFE_564", FORMFE_564);



            Rpt.SetParameterValue("FORMFE_516", FORMFE_516);
            Rpt.SetParameterValue("FORMFE_517", FORMFE_517);
            Rpt.SetParameterValue("FORMFE_518", FORMFE_518);

            Rpt.SetParameterValue("FORMFE_519", FORMFE_519);
            Rpt.SetParameterValue("FORMFE_519_2", FORMFE_519_2);
            Rpt.SetParameterValue("FORMFE_519_3", FORMFE_519_3);
            Rpt.SetParameterValue("FORMFE_519_4", FORMFE_519_4);
            Rpt.SetParameterValue("FORMFE_519_5", FORMFE_519_5);

            Rpt.SetParameterValue("FORMFE_520", FORMFE_520);

            Rpt.SetParameterValue("FORMFE_522", FORMFE_522);
            Rpt.SetParameterValue("FORMFE_523", FORMFE_523);
            Rpt.SetParameterValue("FORMFE_524", FORMFE_524);
            Rpt.SetParameterValue("FORMFE_525", FORMFE_525);
            Rpt.SetParameterValue("FORMFE_526", FORMFE_526);


            Rpt.SetParameterValue("FORMFE_527", FORMFE_527);

            Rpt.SetParameterValue("FORMFE_527_2", FORMFE_527_2);
            Rpt.SetParameterValue("FORMFE_527_3", FORMFE_527_3);



            Rpt.SetParameterValue("FORMFE_528", FORMFE_528);
            Rpt.SetParameterValue("FORMFE_529", FORMFE_529);
            Rpt.SetParameterValue("FORMFE_530", FORMFE_530);
            Rpt.SetParameterValue("FORMFE_531", FORMFE_531);
            Rpt.SetParameterValue("FORMFE_532", FORMFE_532);

            Rpt.SetParameterValue("FORMFE_305", FORMFE_305);




            Rpt.SetParameterValue("FORMFE_0006", FORMFE_0006);
            Rpt.SetParameterValue("FORMFE_0007", FORMFE_0007);
            Rpt.SetParameterValue("FORMFE_0008", FORMFE_0008);
            Rpt.SetParameterValue("FORMFE_0009", FORMFE_0009);
            Rpt.SetParameterValue("FORMFE_0010", FORMFE_0010);
            Rpt.SetParameterValue("FORMFE_0011", FORMFE_0011);
            Rpt.SetParameterValue("FORMFE_0012", FORMFE_0012);
            Rpt.SetParameterValue("FORMFE_0013", FORMFE_0013);
            Rpt.SetParameterValue("FORMFE_0014", FORMFE_0014);
            Rpt.SetParameterValue("FORMFE_0015", FORMFE_0015);
            Rpt.SetParameterValue("FORMFE_0016", FORMFE_0016);
            Rpt.SetParameterValue("FORMFE_0017", FORMFE_0017);
            Rpt.SetParameterValue("FORMFE_0018DET1", FORMFE_0018DET1);
            Rpt.SetParameterValue("FORMFE_0018DET2", FORMFE_0018DET2);
            Rpt.SetParameterValue("FORMFE_0018DET3", FORMFE_0018DET3);

            Rpt.SetParameterValue("FORMFE_0019", FORMFE_0019);
            Rpt.SetParameterValue("FORMFE_0019DET1", FORMFE_0019DET1);
            Rpt.SetParameterValue("FORMFE_0019DET2", FORMFE_0019DET2);
            Rpt.SetParameterValue("FORMFE_0019GRUPAL", FORMFE_0019GRUPAL);
            Rpt.SetParameterValue("FORMFE_0019DET3", FORMFE_0019DET3);
            Rpt.SetParameterValue("FORMFE_0020", FORMFE_0020);
            Rpt.SetParameterValue("FORMFE_0021", FORMFE_0021);




            #endregion

            #region FORMULARIOFED_SETPARAMETER
            Rpt.SetParameterValue("FORMFE_0038", FORMFE_0038);
            Rpt.SetParameterValue("FORMFE_0039", FORMFE_0039);
            Rpt.SetParameterValue("FORMFE_0040", FORMFE_0040);
            Rpt.SetParameterValue("FORMFE_0041", FORMFE_0041);
            Rpt.SetParameterValue("FORMFE_0042", FORMFE_0042);
            Rpt.SetParameterValue("FORMFE_0043", FORMFE_0043);
            Rpt.SetParameterValue("FORMFE_0044", FORMFE_0044);
            Rpt.SetParameterValue("FORMFE_0045", FORMFE_0045);


            //Rpt.SetParameterValue("FORMFE_0110", FORMFE_0110);

            //Rpt.SetParameterValue("FORMFE_0111", FORMFE_0111);

            #endregion
            /******************/
            if (!existeDataHC)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.SetParameterValue("imgFirma", imgFirma);
                        Rpt.SetParameterValue("imgFirmaContrare", imgFirmaContrare);

                        Rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "EXAMEN");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                    Rpt.SetParameterValue("imgFirma", imgFirma);
                    Rpt.SetParameterValue("imgFirmaContrare", imgFirmaContrare);

                }

            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetParameterValue("imgFirma", imgFirma);
            Rpt.SetParameterValue("imgFirma2", imgFirma2);
            Rpt.SetParameterValue("imgFirmaContrare", imgFirmaContrare);
            Rpt.SetParameterValue("imgFirmaDieta", imgFirmaDieta);

        }



        private void GenerarReporterptViewTotalTriajeHCE(String tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewTotalTriajeHCE - Entrar");
            string ruta = Server.MapPath("rptReports/ViewAdjuntosTriaje.rpt");
            Rpt.Load(Server.MapPath("rptReports/ViewAdjuntosTriaje.rpt"));

            #region AgrupadorReporte

            ///**LISTAR DATOS GENERALES DEL REPORTES EN 'rptViewAgrupador'*/

            Boolean existeDataHC = false;
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit> ListrptViewAgrupador = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit>();
            SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad = new SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit();

            DataTable listarptAgrupador_FE = new DataTable();
            if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "TRIAJE")
            {
                listarptAgrupador_FE = rptAgrupador_TRIAJE_FE("rptViewAgrupadorTriaje", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                         (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioTriaje,
                         (int)ENTITY_GLOBAL.Instance.EpisodioTriaje,
                         null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
                objEntidad.TipoTrabajadorDesc = "Triaje";
                objEntidad.UnidadServicioDesc = "Triaje de Emergencia";
                objEntidad.ServicioExtra = Convert.ToString(Session["NOMBRE_MEDICO"]);
                existeDataHC = true;
            }
            //else
            //{
            //    listarptAgrupador_FE = rptAgrupador_FE("rptViewAgrupador", ENTITY_GLOBAL.Instance.UnidadReplicacion,
            //             (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
            //             (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
            //             null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //    objEntidad.ServicioExtra = listarptAgrupador_FE.Rows[0]["ServicioExtra"].ToString();//ListrptViewAgrupadorOrig[0].ServicioExtra;
            //    objEntidad.UnidadServicioDesc = listarptAgrupador_FE.Rows[0]["UnidadServicioDesc"].ToString();//ListrptViewAgrupadorOrig[0].UnidadServicioDesc;
            //    objEntidad.TipoTrabajadorDesc = listarptAgrupador_FE.Rows[0]["TipoTrabajadorDesc"].ToString();//listarptAgrupador_FE.Rows[0].TipoTrabajadorDesc;
            //}

            objEntidad.NombreCompleto = listarptAgrupador_FE.Rows[0]["NombreCompleto"].ToString();//.NombreCompleto;
            objEntidad.ServicioExtra = listarptAgrupador_FE.Rows[0]["ServicioExtra"].ToString();//listarptAgrupador_FE[0].ServicioExtra;
            objEntidad.Sexo = listarptAgrupador_FE.Rows[0]["Sexo"].ToString();//listarptAgrupador_FE[0].Sexo;
            objEntidad.CodigoOA = listarptAgrupador_FE.Rows[0]["CodigoOA"].ToString();//listarptAgrupador_FE[0].CodigoOA;
            objEntidad.UnidadReplicacion = listarptAgrupador_FE.Rows[0]["UnidadReplicacion"].ToString();
            if (!string.IsNullOrEmpty(listarptAgrupador_FE.Rows[0]["NombreCompleto"].ToString()))
            {
                objEntidad.edad = Convert.ToInt32(listarptAgrupador_FE.Rows[0]["edad"].ToString());  //(listarptAgrupador_FE[0].edad != null ? Convert.ToInt32(listarptAgrupador_FE[0].edad) : 0);
            }
            else
            {
                objEntidad.edad = 0;
            }

            /************LISTAR DATA DE CADA SUBREPORTE (DESCARTAR LISTADOS DE ACUERDO A PARAM de FORMATOS)***********************/

            string FOMR_VACIO = "000";
            string formatos = FOMR_VACIO + "-";
            string formatosRecibidos = null;
            formatosRecibidos = formatos;
            //PARA EL REGSITRO DE AUDITORÍA
            int idImpresionLog = setDataImpresionAuditoria("HEADER", 0, objEntidad, null, ENTITY_GLOBAL.Instance.USUARIO);

            DataTable listarV_EpisodioAtencion = new DataTable();
            if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "TRIAJE")
            {
                listarV_EpisodioAtencion = rptV_EpisodioAtencionesTriaje("V_EpisodioAtenciones", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                         (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioTriaje
                         );
            }

            foreach (DataRow ht_fila in listarV_EpisodioAtencion.AsEnumerable())
            {
                formatosRecibidos += ht_fila["Accion"].ToString() + "-";

            }



            #endregion

            // FORMULARIO INICIALES
            #region FORMULARIOINICIALES_GETDATA





            #endregion

            // FORMULARIO EXTRAS
            #region FORMULARIOEXTRAS_GETDATA  FORMFE_522






            //LISTADO FORMFE_103



            DataTable listaRPTrptTriajeEmergencia = new DataTable();
            DataTable listaRPTrptViewTriajeAlergias_FE = new DataTable();
            DataTable listaRPTrptViewTriajeAlergias_FE2 = new DataTable();
            DataTable listaRPTrptViewTriajeAlergias_FE3 = new DataTable();

            DataTable listaRPTrptViewTriajeAlergias_FEDetalle1 = new DataTable();
            DataTable listaRPTrptViewTriajeAlergias_FEDetalle2 = new DataTable();
            //LISTADO TRIAJE EMERGENCIA
            if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "TRIAJE")
            {


                if (formatosRecibidos.Contains("" + FORMFE_522))
                {
                    listaRPTrptTriajeEmergencia = rptVistasTriaje_FE("rptViewTriajeEmergencia_FE",
                             ENTITY_GLOBAL.Instance.UnidadReplicacion,
                            (int)ENTITY_GLOBAL.Instance.PacienteID,
                            (int)ENTITY_GLOBAL.Instance.EpisodioTriaje,

                             null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                            ENTITY_GLOBAL.Instance.USUARIO);
                    if (listaRPTrptTriajeEmergencia.Rows.Count > 0)
                    {
                        //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                        formatosRecibidos = formatosRecibidos.Replace(FORMFE_522, FOMR_VACIO);
                        formatos = formatos + FORMFE_522 + "-";
                    }
                }

                //LISTADO TRIAJE ALERGIA


                if (formatosRecibidos.Contains("" + FORMFE_527))
                {
                    listaRPTrptViewTriajeAlergias_FE = rptVistasTriaje_FE("rptViewCabezeraAntecedenAlergias_FE",
                             ENTITY_GLOBAL.Instance.UnidadReplicacion,
                            (int)ENTITY_GLOBAL.Instance.PacienteID,
                            (int)ENTITY_GLOBAL.Instance.EpisodioTriaje,
                             null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                            ENTITY_GLOBAL.Instance.USUARIO);
                    if (listaRPTrptViewTriajeAlergias_FE.Rows.Count > 0)
                    {
                        //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                        formatosRecibidos = formatosRecibidos.Replace(FORMFE_527, FOMR_VACIO);
                        formatos = formatos + FORMFE_527 + "-";
                    }




                    listaRPTrptViewTriajeAlergias_FEDetalle1 = rptVistasTriaje_Alergias_FE("rptViewTriajeAlergias_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioTriaje
             , "MA", 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
                    if (listaRPTrptViewTriajeAlergias_FEDetalle1.Rows.Count > 0)
                    {
                        //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                        formatosRecibidos = formatosRecibidos.Replace(FORMFE_528, FOMR_VACIO);
                        formatos = formatos + FORMFE_528 + "-";
                    }



                    //listaRPTrptViewTriajeAlergias_FE2 = rptVistasTriaje_FE("rptViewCabezeraAntecedenAlergias_FE",
                    //         ENTITY_GLOBAL.Instance.UnidadReplicacion,
                    //        (int)ENTITY_GLOBAL.Instance.PacienteID,
                    //        (int)ENTITY_GLOBAL.Instance.EpisodioTriaje,
                    //         null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                    //        ENTITY_GLOBAL.Instance.USUARIO);
                    listaRPTrptViewTriajeAlergias_FE2 = listaRPTrptViewTriajeAlergias_FE;
                    if (listaRPTrptViewTriajeAlergias_FE2.Rows.Count > 0)
                    {
                        //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                        formatosRecibidos = formatosRecibidos.Replace(FORMFE_527_2, FOMR_VACIO);
                        formatos = formatos + FORMFE_527_2 + "-";
                    }



                    listaRPTrptViewTriajeAlergias_FEDetalle2 = rptVistasTriaje_Alergias_FE("rptViewTriajeAlergias_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioTriaje
            , "RE", 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
                    if (listaRPTrptViewTriajeAlergias_FEDetalle2.Rows.Count > 0)
                    {
                        //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                        formatosRecibidos = formatosRecibidos.Replace(FORMFE_529, FOMR_VACIO);
                        formatos = formatos + FORMFE_529 + "-";
                    }


                    //listaRPTrptViewTriajeAlergias_FE3 = rptVistasTriaje_FE("rptViewCabezeraAntecedenAlergias_FE",
                    //    ENTITY_GLOBAL.Instance.UnidadReplicacion,
                    //   (int)ENTITY_GLOBAL.Instance.PacienteID,
                    //   (int)ENTITY_GLOBAL.Instance.EpisodioTriaje,
                    //    null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                    //   ENTITY_GLOBAL.Instance.USUARIO);
                    listaRPTrptViewTriajeAlergias_FE3 = listaRPTrptViewTriajeAlergias_FE;
                    if (listaRPTrptViewTriajeAlergias_FE3.Rows.Count > 0)
                    {
                        //DE AYUDA A LA FÓRMULA DE SUPRIMIR EN LA PLANTILLA
                        formatosRecibidos = formatosRecibidos.Replace(FORMFE_527_3, FOMR_VACIO);
                        formatos = formatos + FORMFE_527_3 + "-";
                    }


                }
                // aka acaba traije alergias

            }




            //LISTADO FORMFE_0017




            #endregion



            /**ADD DATOS GENERALES DEL REPORTES EN 'ListrptViewAgrupador'*/
            //OBS: AUX TipoEpisodio:  usado para la fórmula de mostrar o no un subreporte de acuerdo al FORMATO que contenga
            objEntidad.TipoEpisodio = formatos;

            ListrptViewAgrupador.Add(objEntidad);
            Rpt.DataSourceConnections.Clear();
            Rpt.SetDataSource(ListrptViewAgrupador);
            /********************************/

            int cantidadSubReport = Rpt.Subreports.Count;

            try
            {
                if (cantidadSubReport > 0)
                {

                    #region FORMULARIOEXTRAS_SETDATASOURCE


                    if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "TRIAJE")
                    {
                        if (listaRPTrptTriajeEmergencia.Rows.Count > 0)
                        {
                            Rpt.Subreports["rptViewTriajeEmergencia_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewTriajeEmergencia_FEsubrep.rpt"].SetDataSource(listaRPTrptTriajeEmergencia);
                        }

                        if (listaRPTrptViewTriajeAlergias_FE.Rows.Count > 0)
                        {
                            Rpt.Subreports["rptViewTriajeAlergias_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewTriajeAlergias_FEsubrep.rpt"].SetDataSource(listaRPTrptViewTriajeAlergias_FE);
                        }

                        if (listaRPTrptViewTriajeAlergias_FEDetalle1.Rows.Count == 0)
                        {
                            Rpt.Subreports["rptViewTriajeAlergias_FEDetalle1subrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewTriajeAlergias_FEDetalle1subrep.rpt"].SetDataSource(listaRPTrptViewTriajeAlergias_FEDetalle1);


                        }
                        else
                        {
                            Rpt.Subreports["rptViewTriajeAlergias_FEDetalle1subrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewTriajeAlergias_FEDetalle1subrep.rpt"].SetDataSource(listaRPTrptViewTriajeAlergias_FEDetalle1);
                        }


                        if (listaRPTrptViewTriajeAlergias_FE2.Rows.Count > 0)
                        {
                            Rpt.Subreports["rptViewTriajeAlergiasParte2_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewTriajeAlergiasParte2_FEsubrep.rpt"].SetDataSource(listaRPTrptViewTriajeAlergias_FE2);
                        }

                        if (listaRPTrptViewTriajeAlergias_FEDetalle2.Rows.Count == 0)
                        {
                            Rpt.Subreports["rptViewTriajeAlergias_FEDetalle2subrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewTriajeAlergias_FEDetalle2subrep.rpt"].SetDataSource(listaRPTrptViewTriajeAlergias_FEDetalle2);

                        }
                        else
                        {
                            Rpt.Subreports["rptViewTriajeAlergias_FEDetalle2subrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewTriajeAlergias_FEDetalle2subrep.rpt"].SetDataSource(listaRPTrptViewTriajeAlergias_FEDetalle2);
                        }

                        if (listaRPTrptViewTriajeAlergias_FE3.Rows.Count > 0)
                        {
                            Rpt.Subreports["rptViewTriajeAlergiasParte3_FEsubrep.rpt"].DataSourceConnections.Clear();
                            Rpt.Subreports["rptViewTriajeAlergiasParte3_FEsubrep.rpt"].SetDataSource(listaRPTrptViewTriajeAlergias_FE3);
                        }



                    }





                    #endregion

                    #region FORMULARIOFED_SETDATASOURCE_ADJUNTO

                    #endregion

                }
            }
            catch (Exception ex)
            {
                Log.Error(ex, ex.Message);
                LOGgineco(this, ex);

                throw;
            }



            /**ADD PARÁMETROS*/
            #region FORMULARIOINICALES_SETPARAMETER
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            Rpt.SetParameterValue("FORMFE_522", FORMFE_522);

            Rpt.SetParameterValue("FORMFE_527", FORMFE_527);
            Rpt.SetParameterValue("FORMFE_528", FORMFE_528);
            Rpt.SetParameterValue("FORMFE_529", FORMFE_529);
            Rpt.SetParameterValue("FORMFE_527_2", FORMFE_527_2);
            Rpt.SetParameterValue("FORMFE_527_3", FORMFE_527_3);



            #endregion
            /******************/
            if (!existeDataHC)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.SetParameterValue("imgFirma", imgFirma);
                        Rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "EXAMEN");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                    Rpt.SetParameterValue("imgFirma", imgFirma);
                }

            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

        }






        /******Registros de AUDITORÍA IMPRESIÓN********/

        public int setDataImpresionAuditoria(String tipo, int idImpresionLog,
            SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objActoInfoEpiAtencion,
            string codigoFormato,
            string codigoUsuario
            )
        {
            Log.Information("VisorReportesHCE - setDataImpresionAuditoria - Entrar");
            int result = 0;
            try
            {
                ///////////////////////////////      
                SS_HC_ImpresionHC_Detalle objDetalle = new SS_HC_ImpresionHC_Detalle();

                SS_HC_ImpresionHC obj = new SS_HC_ImpresionHC();
                switch (tipo)
                {
                    case "REPORTEA":
                        //PARA LA AUDITORIA DE IMPRESION
                        if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
                        {
                            VW_ATENCIONPACIENTE_GENERAL objSelecc = (VW_ATENCIONPACIENTE_GENERAL)Session["VW_ATENCIONPACIENTE_GEN_SELECC"];
                            setDataImpresionAuditoriaIndividual(objSelecc, codigoFormato);
                        }
                        break;
                    case "MASIVO":
                        if (objActoInfoEpiAtencion != null && idImpresionLog > 0)
                        {
                            obj.UnidadReplicacion = objActoInfoEpiAtencion.UnidadReplicacion;
                            obj.IdPaciente = objActoInfoEpiAtencion.IdPaciente;
                            obj.HostImpresion = UtilMVC.ObtenerIP();//MOVIDO 14/04/16
                            obj.UsuarioImpresion = codigoUsuario;
                            obj.FechaImpresion = DateTime.Now;
                            obj.Accion = "INSERT_DETALLE";

                            //
                            objDetalle.IdImpresion = idImpresionLog;
                            objDetalle.IdPaciente = objActoInfoEpiAtencion.IdPaciente;
                            objDetalle.IdEpisodioAtencion = objActoInfoEpiAtencion.IdEpisodioAtencion;
                            objDetalle.EpisodioClinico = objActoInfoEpiAtencion.EpisodioClinico;
                            objDetalle.EpisodioAtencion = objActoInfoEpiAtencion.EpisodioAtencion;
                            objDetalle.IdOpcion = ENTITY_GLOBAL.Instance.IDOPCION_ACTUAL != null ? ((int)ENTITY_GLOBAL.Instance.IDOPCION_ACTUAL) : 0;
                            objDetalle.CodigoOpcion = codigoFormato;
                            objDetalle.IdFormato = ENTITY_GLOBAL.Instance.IDFORMATO != null ? ((int)ENTITY_GLOBAL.Instance.IDFORMATO) : 0;

                            objDetalle.TipoAtencion = (int)Session["TIPOATENCION_ACTUAL"];
                            objDetalle.IdUnidadServicio = objActoInfoEpiAtencion.IdUnidadServicio;
                            objDetalle.IdPersonalSalud = objActoInfoEpiAtencion.IdPersonalSalud;
                            //
                            objDetalle.HostImpresion = UtilMVC.ObtenerIP();//MOVIDO 14/04/16
                            objDetalle.UsuarioImpresion = codigoUsuario;
                            objDetalle.FechaImpresion = DateTime.Now;
                            objDetalle.Accion = "INSERT_DETALLE";
                            result = SvcAuditoriaImpresion.save_ChangesTraking(obj, objDetalle, "SINGLE");
                        }
                        break;
                    case "HEADER":

                        //SS_HC_ImpresionHC_Detalle objDetalle = new SS_HC_ImpresionHC_Detalle();

                        //SS_HC_ImpresionHC obj = new SS_HC_ImpresionHC();
                        obj.UnidadReplicacion = objActoInfoEpiAtencion.UnidadReplicacion;
                        obj.IdPaciente = objActoInfoEpiAtencion.IdPaciente;
                        obj.HostImpresion = UtilMVC.ObtenerIP();//MOVIDO 14/04/16
                        obj.UsuarioImpresion = codigoUsuario;
                        obj.FechaImpresion = DateTime.Now;
                        obj.Accion = "INSERT";
                        result = SvcAuditoriaImpresion.save_ChangesTraking(obj, objDetalle, "SINGLE");
                        break;
                }



                //if (tipo == "REPORTEA") //INDIVIDUAL
                //{
                //    ///////////////////////////////                    
                //    //PARA LA AUDITORIA DE IMPRESION
                //    if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
                //    {
                //        VW_ATENCIONPACIENTE_GENERAL objSelecc = (VW_ATENCIONPACIENTE_GENERAL)Session["VW_ATENCIONPACIENTE_GEN_SELECC"];
                //        setDataImpresionAuditoriaIndividual(objSelecc, codigoFormato);
                //    }
                //}
                //else if (tipo == "MASIVO") //MASIVO
                //{
                //    if (objActoInfoEpiAtencion != null && idImpresionLog > 0)
                //    {
                //        ///////////////////////////////      
                //        SS_HC_ImpresionHC_Detalle objDetalle = new SS_HC_ImpresionHC_Detalle();

                //        SS_HC_ImpresionHC obj = new SS_HC_ImpresionHC();
                //        obj.UnidadReplicacion = objActoInfoEpiAtencion.UnidadReplicacion;
                //        obj.IdPaciente = objActoInfoEpiAtencion.IdPaciente;
                //        obj.HostImpresion = UtilMVC.ObtenerIP();//MOVIDO 14/04/16
                //        obj.UsuarioImpresion = codigoUsuario;
                //        obj.FechaImpresion = DateTime.Now;
                //        obj.Accion = "INSERT_DETALLE";

                //        //
                //        objDetalle.IdImpresion = idImpresionLog;
                //        objDetalle.IdPaciente = objActoInfoEpiAtencion.IdPaciente;
                //        objDetalle.IdEpisodioAtencion = objActoInfoEpiAtencion.IdEpisodioAtencion;
                //        objDetalle.EpisodioClinico = objActoInfoEpiAtencion.EpisodioClinico;
                //        objDetalle.EpisodioAtencion = objActoInfoEpiAtencion.EpisodioAtencion;
                //        objDetalle.IdOpcion = ENTITY_GLOBAL.Instance.IDOPCION_ACTUAL != null ? ((int)ENTITY_GLOBAL.Instance.IDOPCION_ACTUAL) : 0;
                //        objDetalle.CodigoOpcion = codigoFormato;
                //        objDetalle.IdFormato = ENTITY_GLOBAL.Instance.IDFORMATO != null ? ((int)ENTITY_GLOBAL.Instance.IDFORMATO) : 0;

                //        objDetalle.TipoAtencion = (int)Session["TIPOATENCION_ACTUAL"];
                //        objDetalle.IdUnidadServicio = objActoInfoEpiAtencion.IdUnidadServicio;
                //        objDetalle.IdPersonalSalud = objActoInfoEpiAtencion.IdPersonalSalud;
                //        //
                //        objDetalle.HostImpresion = UtilMVC.ObtenerIP();//MOVIDO 14/04/16
                //        objDetalle.UsuarioImpresion = codigoUsuario;
                //        objDetalle.FechaImpresion = DateTime.Now;
                //        objDetalle.Accion = "INSERT_DETALLE";
                //        result = SvcAuditoriaImpresion.save_ChangesTraking(obj, objDetalle, "SINGLE");
                //    }
                //}
                //else if (tipo == "HEADER") //MASIVO
                //{
                //    ///////////////////////////////      
                //    SS_HC_ImpresionHC_Detalle objDetalle = new SS_HC_ImpresionHC_Detalle();

                //    SS_HC_ImpresionHC obj = new SS_HC_ImpresionHC();
                //    obj.UnidadReplicacion = objActoInfoEpiAtencion.UnidadReplicacion;
                //    obj.IdPaciente = objActoInfoEpiAtencion.IdPaciente;
                //    obj.HostImpresion = UtilMVC.ObtenerIP();//MOVIDO 14/04/16
                //    obj.UsuarioImpresion = codigoUsuario;
                //    obj.FechaImpresion = DateTime.Now;
                //    obj.Accion = "INSERT";
                //    result = SvcAuditoriaImpresion.save_ChangesTraking(obj, objDetalle, "SINGLE");
                //}

            }
            catch (Exception ex)
            {
                Log.Error(ex, ex.Message);
            }
            return result;
        }

        public void setDataImpresionAuditoriaIndividual(VW_ATENCIONPACIENTE_GENERAL objActoMedicoSelecc,
            string codigoFormato
            )
        {
            Log.Information("VisorReportesHCE - setDataImpresionAuditoriaIndividual - Entrar");

            try
            {
                SS_HC_ImpresionHC_Detalle objDetalle = new SS_HC_ImpresionHC_Detalle();
                SS_HC_ImpresionHC obj = new SS_HC_ImpresionHC();
                obj.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                obj.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                obj.HostImpresion = ENTITY_GLOBAL.Instance.HostName;
                obj.UsuarioImpresion = ENTITY_GLOBAL.Instance.USUARIO;
                obj.FechaImpresion = DateTime.Now;
                obj.Accion = "INSERT_TOTAL";
                //
                objDetalle.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                objDetalle.IdEpisodioAtencion = (int)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                objDetalle.EpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico;
                objDetalle.EpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencionPrim;
                objDetalle.IdOpcion = ENTITY_GLOBAL.Instance.IDOPCION_ACTUAL != null ? ((int)ENTITY_GLOBAL.Instance.IDOPCION_ACTUAL) : 0;
                objDetalle.CodigoOpcion = codigoFormato;
                objDetalle.IdFormato = ENTITY_GLOBAL.Instance.IDFORMATO != null ? ((int)ENTITY_GLOBAL.Instance.IDFORMATO) : 0;
                objDetalle.TipoAtencion = objActoMedicoSelecc.TipoAtencion;
                objDetalle.IdUnidadServicio = objActoMedicoSelecc.IdUnidadServicio;
                objDetalle.IdPersonalSalud = objActoMedicoSelecc.IdPersonalSalud;
                //
                objDetalle.HostImpresion = ENTITY_GLOBAL.Instance.HostName;
                objDetalle.UsuarioImpresion = ENTITY_GLOBAL.Instance.USUARIO;
                objDetalle.FechaImpresion = DateTime.Now;
                objDetalle.Accion = "INSERT_TOTAL";
                int result = SvcAuditoriaImpresion.save_ChangesTraking(obj, objDetalle, "SINGLE");
            }
            catch (Exception ex)
            {
                Log.Error(ex, ex.Message);
            }
        }


        // *** FORMULARIOS (EXTRAS) ***

        private void GenerarReporterptViewDiagnostico_FE(string tipovista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewDiagnostico_FE - Entrar");
            string tura = Server.MapPath("rptReports/rptViewDiagnostico_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewDiagnostico_FE.rpt"));

            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewDiagnostico_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewDiagnostico_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewDiagnostico_FEEdit>();
            //listaRPT = getDatarptViewDiagnostico_FE("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //  , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //Datos Generales

            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipovista == "I")
                {
                    if (tipovista == "I")
                    {
                        ReportViewer.ReportSource = Rpt;
                        ReportViewer.DataBind();
                    }
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DIAGNOSTICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }

        private void GenerarReporterptViewInformeConsultaExterna_FE(string tipovista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewInformeConsultaExterna_FE - Entrar");
            // Reporte
            string tura = Server.MapPath("rptReports/rptViewInformeConsultaExterna_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewInformeConsultaExterna_FE.rpt"));

            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewInformeConsultaExterna_FE",
                         ENTITY_GLOBAL.Instance.UnidadReplicacion,
                         (int)ENTITY_GLOBAL.Instance.PacienteID,
                         (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                         (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                         null, 0,
                         ENTITY_GLOBAL.Instance.CONCEPTO,
                         ENTITY_GLOBAL.Instance.USUARIO);

            //Datos Generales
            setDatosGenerales();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);

            }
            else
            {
                if (tipovista == "I")
                {
                    if (tipovista == "I")
                    {
                        ReportViewer.ReportSource = Rpt;
                        ReportViewer.DataBind();
                    }
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {

                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "InformeConsultaExterna");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }


        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewDiagnostico_FEEdit>
        getDatarptViewDiagnostico_FE(String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
        , SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog,
        string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewDiagnostico_FE - Entrar");
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewDiagnostico_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewDiagnostico_FEEdit>();
            List<rptViewDiagnostico_FE> rptViewDiagnostico_FE = new List<rptViewDiagnostico_FE>();
            SS_HC_Diagnostico_FE objDiagnostico_FE = new SS_HC_Diagnostico_FE();
            objDiagnostico_FE.UnidadReplicacion = unidadReplicacion;
            objDiagnostico_FE.IdPaciente = idPaciente;
            objDiagnostico_FE.EpisodioClinico = epiClinico;
            objDiagnostico_FE.IdEpisodioAtencion = idEpiAtencion;
            objDiagnostico_FE.Accion = "REPORTEA";
            rptViewDiagnostico_FE = ServiceReportes.ReporteDiagnostico_FE(objDiagnostico_FE, 0, 0);

            objTabla1 = new System.Data.DataTable();
            SoluccionSalud.RepositoryReport.Entidades.rptViewDiagnostico_FEEdit objRPT;

            if (rptViewDiagnostico_FE != null)
            {
                foreach (rptViewDiagnostico_FE objReport in rptViewDiagnostico_FE)
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewDiagnostico_FEEdit();

                    objRPT.DiagnosticoDesc = objReport.DiagnosticoDesc;
                    objRPT.DeterminacionDiagnosticaDesc = objReport.DeterminacionDiagnosticaDesc;
                    objRPT.GradoAfeccionDesc = objReport.GradoAfeccionDesc;
                    objRPT.DiagnosticoPrincipalDesc = objReport.DiagnosticoPrincipalDesc;
                    objRPT.Observacion = objReport.Observacion;
                    objRPT.NombreCompleto = objReport.NombreCompleto;
                    objRPT.TipoAtencionDesc = objReport.TipoAtencionDesc;
                    objRPT.Sexo = objReport.Sexo;
                    objRPT.CodigoOA = objReport.CodigoOA;
                    if (objReport.PersonaEdad != null)
                    {
                        objRPT.PersonaEdad = Convert.ToInt32(objReport.PersonaEdad);
                    }
                    objRPT.UnidadServicioDesc = objReport.UnidadServicioDesc;
                    objRPT.PersMedicoNombreCompleto = objReport.PersMedicoNombreCompleto;
                    objRPT.Expr104 = objReport.Expr104;
                    listaRPT.Add(objRPT);
                }

                ///////////////////////////////                     
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewDiagnostico_FE.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 

            }
            return listaRPT;
        }


        private void GenerarReporterptViewInmunizacionNinio_FE(string tipovista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewInmunizacionNinio_FE - Entrar");
            string tura = Server.MapPath("rptReports/rptViewInmunizacionNinio_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewInmunizacionNinio_FE.rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewInmunizacionNinio_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                        null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //Datos generales
            setDatosGenerales();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipovista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DIAGNOSTICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }

        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewImnunizaionNinio_FEEdit>
        getDatarptViewImnunizaionNinio_FE(String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion,
           SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog, String codFormato, String codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewImnunizaionNinio_FE - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewImnunizaionNinio_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewImnunizaionNinio_FEEdit>();
            List<rptViewInmunizacionNinio_FE> rptViewImnunizaionNinio = new List<rptViewInmunizacionNinio_FE>();
            SS_HC_AntecedentesPersonalesIN_FE objImnunizaionNinio = new SS_HC_AntecedentesPersonalesIN_FE();
            objImnunizaionNinio.UnidadReplicacion = unidadReplicacion;
            objImnunizaionNinio.IdPaciente = idPaciente;
            objImnunizaionNinio.EpisodioClinico = epiClinico;
            objImnunizaionNinio.IdEpisodioAtencion = idEpiAtencion;
            objImnunizaionNinio.Accion = "REPORTEA";

            rptViewImnunizaionNinio = ServiceReportes.ReporteInmunizacionNinio_FE(objImnunizaionNinio, 0, 0);

            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewImnunizaionNinio_FEEdit objRPT;

            if (rptViewImnunizaionNinio != null)
            {
                foreach (rptViewInmunizacionNinio_FE objReport in rptViewImnunizaionNinio)
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewImnunizaionNinio_FEEdit();

                    objRPT.UnidadReplicacion = objReport.UnidadReplicacion;
                    objRPT.IdPaciente = objReport.IdPaciente;
                    objRPT.EpisodioClinico = objReport.EpisodioClinico;
                    objRPT.IdEpisodioAtencion = objReport.IdEpisodioAtencion;

                    objRPT.NO = objReport.NO;
                    objRPT.SI = objReport.SI;

                    objRPT.BCG_RN = objReport.BCG_RN;
                    objRPT.BCG_NoRecuerda = objReport.BCG_NoRecuerda;

                    objRPT.HepatitisBRN_RN = objReport.HepatitisBRN_RN;
                    objRPT.HepatitisBRN_NoRecuerda = objReport.HepatitisBRN_NoRecuerda;

                    objRPT.DPT_1era = objReport.DPT_1era;
                    objRPT.DPT_2da = objReport.DPT_2da;
                    objRPT.DPT_3era = objReport.DPT_3era;
                    objRPT.DPT_1erRef = objReport.DPT_1erRef;
                    objRPT.DPT_2doRef = objReport.DPT_2doRef;
                    objRPT.DPT_NoRecuerda = objReport.DPT_NoRecuerda;

                    objRPT.POLIO_1era = objReport.POLIO_1era;
                    objRPT.POLIO_2da = objReport.POLIO_2da;
                    objRPT.POLIO_3era = objReport.POLIO_3era;
                    objRPT.POLIO_1erRef = objReport.POLIO_1erRef;
                    objRPT.POLIO_2doRef = objReport.POLIO_2doRef;
                    objRPT.POLIO_NoRecuerda = objReport.POLIO_NoRecuerda;

                    objRPT.HiB_1era = objReport.HiB_1era;
                    objRPT.HiB_2da = objReport.HiB_2da;
                    objRPT.HiB_3era = objReport.HiB_3era;
                    objRPT.HiB_1erRef = objReport.HiB_1erRef;
                    objRPT.HiB_2doRef = objReport.HiB_2doRef;
                    objRPT.HiB_NoRecuerda = objReport.HiB_NoRecuerda;

                    objRPT.HEPATITISB_1era = objReport.HEPATITISB_1era;
                    objRPT.HEPATITISB_2da = objReport.HEPATITISB_2da;
                    objRPT.HEPATITISB_3era = objReport.HEPATITISB_3era;
                    objRPT.HEPATITISB_1erRef = objReport.HEPATITISB_1erRef;
                    objRPT.HEPATITISB_NoRecuerda = objReport.HEPATITISB_NoRecuerda;

                    objRPT.ROTAVIRUS_1era = objReport.ROTAVIRUS_1era;
                    objRPT.ROTAVIRUS_2da = objReport.ROTAVIRUS_2da;
                    objRPT.ROTAVIRUS_3era = objReport.ROTAVIRUS_3era;
                    objRPT.ROTAVIRUS_1erRef = objReport.ROTAVIRUS_1erRef;
                    objRPT.ROTAVIRUS_2doRef = objReport.ROTAVIRUS_2doRef;
                    objRPT.ROTAVIRUS_NoRecuerda = objReport.ROTAVIRUS_NoRecuerda;

                    objRPT.SRP_1era = objReport.SRP_1era;
                    objRPT.SRP_2da = objReport.SRP_2da;
                    objRPT.SRP_NoRecuerda = objReport.SRP_NoRecuerda;

                    objRPT.VARICELA_1era = objReport.VARICELA_1era;
                    objRPT.VARICELA_2da = objReport.VARICELA_2da;
                    objRPT.VARICELA_NoRecuerda = objReport.VARICELA_NoRecuerda;

                    objRPT.HEPATITISA_1era = objReport.HEPATITISA_1era;
                    objRPT.HEPATITISA_2da = objReport.HEPATITISA_2da;
                    objRPT.HEPATITISA_NoRecuerda = objReport.HEPATITISA_NoRecuerda;

                    objRPT.NEUMOCOCO_1era = objReport.NEUMOCOCO_1era;
                    objRPT.NEUMOCOCO_2da = objReport.NEUMOCOCO_2da;
                    objRPT.NEUMOCOCO_3era = objReport.NEUMOCOCO_3era;
                    objRPT.NEUMOCOCO_1erRef = objReport.NEUMOCOCO_1erRef;
                    objRPT.NEUMOCOCO_NoRecuerda = objReport.NEUMOCOCO_NoRecuerda;
                    objRPT.INFLUENZA = Convert.ToDateTime(objReport.INFLUENZA);
                    objRPT.Secuencia = Convert.ToInt32(objReport.Secuencia);
                    objRPT.OtrasVacunas = objReport.OtrasVacunas;

                    listaRPT.Add(objRPT);
                }

                ///////////////////////////////                     
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewImnunizaionNinio.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }
            return listaRPT;
        }


        private void GenerarReporterptViewEmitirDescansoMedico_FE(String tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewEmitirDescansoMedico_FE - Entrar");
            string tura = Server.MapPath("rptReports/rptViewEmitirDescansoMedicoFE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewEmitirDescansoMedicoFE.rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewEmitirDescansoMedico_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewEmitirDescansoMedicoFEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewEmitirDescansoMedicoFEEdit>();
            //listaRPT = getDatarptViewEmitirDescansoMedicoFE("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //--------------------------------------------------------------------------------//

            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            imgFirma = Server.MapPath((string)Session["FIRMA_DIGITAL"]);
            //imgFirma = "D:\\FIRMAS\\JALBUJAR.png";
            Rpt.SetParameterValue("imgFirma", imgFirma);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.SetParameterValue("imgFirma", imgFirma);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                    Rpt.SetParameterValue("imgFirma", imgFirma);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetParameterValue("imgFirma", imgFirma);
        }

        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewEmitirDescansoMedicoFEEdit> getDatarptViewEmitirDescansoMedicoFE(
            String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
            , SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog,
            string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewEmitirDescansoMedicoFE - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewEmitirDescansoMedicoFEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewEmitirDescansoMedicoFEEdit>();
            List<rptViewEmitirDescansoMedico_FE> rptViewEmitirDescansoMedico = new List<rptViewEmitirDescansoMedico_FE>();
            SS_HC_DescansoMedico_FE objEmitirDescansoMedico = new SS_HC_DescansoMedico_FE();
            objEmitirDescansoMedico.UnidadReplicacion = unidadReplicacion;
            objEmitirDescansoMedico.IdPaciente = idPaciente;
            objEmitirDescansoMedico.EpisodioClinico = epiClinico;
            objEmitirDescansoMedico.IdEpisodioAtencion = idEpiAtencion;
            objEmitirDescansoMedico.Accion = "REPORTEA";

            rptViewEmitirDescansoMedico = ServiceReportes.ReporteEmitirDescansoMedico_FE(objEmitirDescansoMedico, 0, 0);

            //AAAA
            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewEmitirDescansoMedicoFEEdit objRPT;
            if (rptViewEmitirDescansoMedico != null)
            {
                foreach (rptViewEmitirDescansoMedico_FE objReport in rptViewEmitirDescansoMedico) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewEmitirDescansoMedicoFEEdit();

                    objRPT.Observacion = objReport.Observacion;

                    objRPT.FechaInicioDescanso = Convert.ToDateTime(objReport.FechaInicioDescanso);

                    objRPT.FechaFinDescanso = Convert.ToDateTime(objReport.FechaFinDescanso);

                    objRPT.Dias = Convert.ToInt32(objReport.Dias);
                    objRPT.Expr102 = objReport.Expr102;
                    objRPT.Expr104 = objReport.Expr104;

                    objRPT.NombreCompleto = objReport.NombreCompleto;
                    objRPT.Sexo = objReport.Sexo;
                    if (objReport.PersonaEdad != null)
                    {
                        objRPT.PersonaEdad = Convert.ToInt32(objReport.PersonaEdad);
                    }
                    objRPT.TipoAtencionDesc = objReport.TipoAtencionDesc;
                    objRPT.CodigoOA = objReport.CodigoOA;
                    objRPT.UnidadServicioDesc = objReport.UnidadServicioDesc;
                    objRPT.estadoEpiAtencion = Convert.ToInt32(objReport.estadoEpiAtencion);
                    objRPT.DiagnosticoDesc = objReport.DiagnosticoDesc;
                    objRPT.FechaAtencion = Convert.ToDateTime(objReport.FechaAtencion);
                    objRPT.Expr103 = objReport.Expr103;
                    objRPT.PersMedicoNombreCompleto = objReport.PersMedicoNombreCompleto;
                    objRPT.TipoTrabajadorDesc = objReport.TipoTrabajadorDesc;
                    objRPT.EspecialidadDesc = objReport.EspecialidadDesc;

                    if (objReport.UnidadServicioCodigo != null && objReport.UnidadServicioCodigo != "")
                    {
                        System.IO.FileInfo fi = new System.IO.FileInfo(objReport.UnidadServicioCodigo.Trim()); //Jordan Mateo 03/05/2018
                        if (fi.Exists)
                        {
                            var NombreServidor = fi.Name;
                            var rutaServidor = Server.MapPath("../resources/DocumentosAdjuntos/firmas/");
                            if (!Directory.Exists(rutaServidor))
                            {
                                DirectoryInfo di = Directory.CreateDirectory(rutaServidor);
                            }
                            var PathServidor = rutaServidor + NombreServidor;
                            System.IO.File.Copy(objReport.UnidadServicioCodigo, PathServidor, true);
                            //System.IO.FileInfo fiServidor = new System.IO.FileInfo(PathServidor);
                            var PathOri = "../resources/DocumentosAdjuntos/firmas/" + NombreServidor;
                            //objRPT.Accion = PathOri;
                            Session["FIRMA_DIGITAL"] = PathOri;

                        }
                    }
                    else
                    {
                        Session["FIRMA_DIGITAL"] = "";
                    }

                    listaRPT.Add(objRPT);
                }
                ///////////////////////////////                    
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewEmitirDescansoMedico.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }

            return listaRPT;

        }
        private void GenerarReporterptViewAlergia_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewAlergia_FE - Entrar");

            string tura = Server.MapPath("rptReports/rptViewAlergiaFE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewAlergiaFE.rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewAlergias_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            //DataSet obj = new DataSet();
            //dsRptViewer.Tables.Add(objTabla1.Copy());
            //dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));

            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewAlergias_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAlergias_FEEdit>();
            //listaRPT = getDatarptViewAlergias_FE("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);



            //datos generales
            setDatosGenerales();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {

                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            //Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            //Rpt.SetParameterValue("imgDerecha", imgDerecha);


        }

        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewAlergias_FEEdit>
        getDatarptViewAlergias_FE(
            String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
            , SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog,
            string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewAlergias_FE - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewAlergias_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAlergias_FEEdit>();

            List<rptViewAlergias_FE> rptViewAlergia_FE = new List<rptViewAlergias_FE>();
            SS_HC_Alergia_FE objEmitirDescansoMedico = new SS_HC_Alergia_FE();
            objEmitirDescansoMedico.UnidadReplicacion = unidadReplicacion;
            objEmitirDescansoMedico.IdPaciente = idPaciente;
            objEmitirDescansoMedico.EpisodioClinico = epiClinico;
            objEmitirDescansoMedico.IdEpisodioAtencion = idEpiAtencion;
            objEmitirDescansoMedico.Accion = "REPORTEA";
            rptViewAlergia_FE = ServiceReportes.ReporteAlergia_FE(objEmitirDescansoMedico, 0, 0);
            //AAAA
            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewAlergias_FEEdit objRPT;
            if (rptViewAlergia_FE != null)
            {
                foreach (rptViewAlergias_FE objReport in rptViewAlergia_FE) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewAlergias_FEEdit();

                    objRPT.Observaciones = objReport.Observaciones;

                    objRPT.SI = objReport.SI;

                    objRPT.NO = objReport.NO;

                    objRPT.TipoAlergiaDesc = objReport.TipoAlergiaDesc;

                    objRPT.Nombre = objReport.Nombre;

                    objRPT.DesdeCuando = objReport.DesdeCuando;
                    objRPT.EstudioAlergista = objReport.EstudioAlergista;



                    listaRPT.Add(objRPT);
                }
                ///////////////////////////////                     
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewAlergia_FE.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }

            return listaRPT;

        }



        private void GenerarReporterptViewValoracionFuncionalAM_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewValoracionFuncionalAM_FE - Entrar");
            string tura = Server.MapPath("rptReports/rptView_ValoracionFuncionalAM_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptView_ValoracionFuncionalAM_FE.rpt"));

            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptView_ValoracionFuncionalAM_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //List<SoluccionSalud.RepositoryReport.Entidades.rptView_ValoracionFuncionalAM_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptView_ValoracionFuncionalAM_FEEdit>();
            //listaRPT = getDatarptViewValoracionFuncionalAM_FE("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            imgDF = Server.MapPath("imagenes/leyendaValoracion.JPG");
            Rpt.SetParameterValue("imgDF", imgDF);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.SetParameterValue("imgDF", imgDF);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                    Rpt.SetParameterValue("imgDF", imgDF);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetParameterValue("imgDF", imgDF);
        }

        private List<SoluccionSalud.RepositoryReport.Entidades.rptView_ValoracionFuncionalAM_FEEdit> getDatarptViewValoracionFuncionalAM_FE(
          String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
          , SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog,
          string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewValoracionFuncionalAM_FE - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptView_ValoracionFuncionalAM_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptView_ValoracionFuncionalAM_FEEdit>();

            List<rptView_ValoracionFuncionalAM_FE> rptViewValoracionFuncionalAM = new List<rptView_ValoracionFuncionalAM_FE>();
            SS_HC_ValoracionAM_FE objValoracionAM_FE = new SS_HC_ValoracionAM_FE();
            objValoracionAM_FE.UnidadReplicacion = unidadReplicacion;
            objValoracionAM_FE.IdPaciente = idPaciente;
            objValoracionAM_FE.EpisodioClinico = epiClinico;
            objValoracionAM_FE.IdEpisodioAtencion = idEpiAtencion;
            objValoracionAM_FE.Accion = "REPORTEA";
            rptViewValoracionFuncionalAM = ServiceReportes.ReporteValoracionAM_FE(objValoracionAM_FE, 0, 0);
            //AAAA
            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptView_ValoracionFuncionalAM_FEEdit objRPT;
            if (rptViewValoracionFuncionalAM != null)
            {
                foreach (rptView_ValoracionFuncionalAM_FE objReport in rptViewValoracionFuncionalAM) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptView_ValoracionFuncionalAM_FEEdit();

                    objRPT.LD = objReport.LD;
                    objRPT.LI = objReport.LI;
                    objRPT.VD = objReport.VD;
                    objRPT.VI = objReport.VI;
                    objRPT.SHD = objReport.SHD;
                    objRPT.SHI = objReport.SHI;
                    objRPT.MD = objReport.MD;
                    objRPT.MI = objReport.MI;
                    objRPT.CD = objReport.CD;
                    objRPT.CI = objReport.CI;
                    objRPT.AD = objReport.AD;
                    objRPT.AI = objReport.AI;
                    objRPT.DiagnosticoFuncional = objReport.DiagnosticoFuncional;

                    listaRPT.Add(objRPT);
                }
                ///////////////////////////////                     
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewValoracionFuncionalAM.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }

            return listaRPT;

        }


        private void GenerarReporterptViewProximaAtencion_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewProximaAtencion_FE - Entrar");

            string tura = Server.MapPath("rptReports/rptViewProximaAtencion_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewProximaAtencion_FE.rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewProximaAtencion_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewProximaAtencion_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewProximaAtencion_FEEdit>();
            //listaRPT = getDatarptViewProximaAtencion_FE("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //DataSet obj = new DataSet();
            //dsRptViewer.Tables.Add(objTabla1.Copy());
            //dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));

            //Datos Generales
            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.SetParameterValue("imgDF", imgDF);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                    Rpt.SetParameterValue("imgDF", imgDF);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }


        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewProximaAtencion_FEEdit>
        getDatarptViewProximaAtencion_FE(
        String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
        , SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog,
        string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewProximaAtencion_FE - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewProximaAtencion_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewProximaAtencion_FEEdit>();

            List<rptViewProximaAtencion_FE> rptViewProximaAtencion_FE = new List<rptViewProximaAtencion_FE>();
            SS_HC_ProximaAtencion_FE objValoracionAM_FE = new SS_HC_ProximaAtencion_FE();
            objValoracionAM_FE.UnidadReplicacion = unidadReplicacion;
            objValoracionAM_FE.IdPaciente = idPaciente;
            objValoracionAM_FE.EpisodioClinico = epiClinico;
            objValoracionAM_FE.IdEpisodioAtencion = idEpiAtencion;
            objValoracionAM_FE.Accion = "REPORTEA";
            rptViewProximaAtencion_FE = ServiceReportes.ReporteProximaAtencion_FE(objValoracionAM_FE, 0, 0);
            //AAAA
            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewProximaAtencion_FEEdit objRPT;
            if (rptViewProximaAtencion_FE != null)
            {
                foreach (rptViewProximaAtencion_FE objReport in rptViewProximaAtencion_FE) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewProximaAtencion_FEEdit();

                    objRPT.FechaSolicitada = Convert.ToDateTime(objReport.FechaSolicitada);
                    objRPT.Descripcion = objReport.Descripcion;

                    listaRPT.Add(objRPT);
                }
                ///////////////////////////////                     
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewProximaAtencion_FE.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }

            return listaRPT;

        }



        private void GenerarReporterptViewInmunizacionAdulto_FE(string tipovista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewInmunizacionAdulto_FE - Entrar");

            // Reporte
            string tura = Server.MapPath("rptReports/rptViewInmunizacionAdultoRep_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewInmunizacionAdultoRep_FE.rpt"));

            DataTable listaRPT = new DataTable();

            listaRPT = rptVistas_FE("rptViewInmunizacionAdulto_FE",
                        ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID,
                        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                        null, 0,
                        ENTITY_GLOBAL.Instance.CONCEPTO,
                        ENTITY_GLOBAL.Instance.USUARIO);


            //Datos Generales
            setDatosGenerales();


            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewInmunizacionAdulto_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewInmunizacionAdulto_FEEdit>();
            //listaRPT = getDatarptViewImnunizaionAdulto_FE("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipovista == "I")
                {

                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {

                        Rpt.ExportToHttpResponse
                       (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DIAGNOSTICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }



        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewInmunizacionAdulto_FEEdit>
        getDatarptViewImnunizaionAdulto_FE(String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion,
           SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog, String codFormato, String codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewImnunizaionAdulto_FE - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewInmunizacionAdulto_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewInmunizacionAdulto_FEEdit>();
            List<rptViewInmunizacionAdulto_FE> rptViewImnunizaionAdulto = new List<rptViewInmunizacionAdulto_FE>();
            SS_HC_AntecedentesPersonalesIAdul_FE objImnunizaionAdulto = new SS_HC_AntecedentesPersonalesIAdul_FE();
            objImnunizaionAdulto.UnidadReplicacion = unidadReplicacion;
            objImnunizaionAdulto.IdPaciente = idPaciente;
            objImnunizaionAdulto.EpisodioClinico = epiClinico;
            objImnunizaionAdulto.IdEpisodioAtencion = idEpiAtencion;
            objImnunizaionAdulto.Accion = "REPORTEA";

            //Servicio
            rptViewImnunizaionAdulto = ServiceReportes.ReporteInmunizacionAdulto_FE(objImnunizaionAdulto, 0, 0);

            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewInmunizacionAdulto_FEEdit objRPT;

            if (rptViewImnunizaionAdulto != null)
            {
                foreach (rptViewInmunizacionAdulto_FE objReport in rptViewImnunizaionAdulto)
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewInmunizacionAdulto_FEEdit();

                    objRPT.UnidadReplicacion = objReport.UnidadReplicacion;
                    objRPT.IdPaciente = objReport.IdPaciente;
                    objRPT.EpisodioClinico = objReport.EpisodioClinico;
                    objRPT.IdEpisodioAtencion = objReport.IdEpisodioAtencion;

                    objRPT.NO = objReport.NO;
                    objRPT.SI = objReport.SI;

                    objRPT.DPT_1era = objReport.DPT_1era;
                    objRPT.DPT_2da = objReport.DPT_2da;
                    objRPT.DPT_3era = objReport.DPT_3era;
                    objRPT.DPT_NoRecuerda = objReport.DPT_NoRecuerda;

                    objRPT.SRP_1era = objReport.SRP_1era;
                    objRPT.SRP_NoRecuerda = objReport.SRP_NoRecuerda;

                    objRPT.VARICELA_1era = objReport.VARICELA_1era;
                    objRPT.VARICELA_NoRecuerda = objReport.VARICELA_NoRecuerda;

                    objRPT.HEPATITISB_1era = objReport.HEPATITISB_1era;
                    objRPT.HEPATITISB_2da = objReport.HEPATITISB_2da;
                    objRPT.HEPATITISB_3era = objReport.HEPATITISB_3era;
                    objRPT.HEPATITISB_1erRef = objReport.HEPATITISB_1erRef;
                    objRPT.HEPATITISB_NoRecuerda = objReport.HEPATITISB_NoRecuerda;


                    objRPT.HEPATITISA_1era = objReport.HEPATITISA_1era;
                    objRPT.HEPATITISA_2da = objReport.HEPATITISA_2da;
                    objRPT.HEPATITISA_NoRecuerda = objReport.HEPATITISA_NoRecuerda;

                    objRPT.NEUMOCOCO_1era = objReport.NEUMOCOCO_1era;
                    objRPT.NEUMOCOCO_2da = objReport.NEUMOCOCO_2da;
                    objRPT.NEUMOCOCO_3era = objReport.NEUMOCOCO_3era;
                    objRPT.NEUMOCOCO_NoRecuerda = objReport.NEUMOCOCO_NoRecuerda;

                    objRPT.Antitetanica_1era = objReport.Antitetanica_1era;
                    objRPT.Antitetanica_2da = objReport.Antitetanica_2da;
                    objRPT.Antitetanica_3era = objReport.Antitetanica_3era;
                    objRPT.Antitetanica_NoRecuerda = objReport.Antitetanica_NoRecuerda;

                    objRPT.Papiloma_1era = objReport.Papiloma_1era;
                    objRPT.Papiloma_2da = objReport.Papiloma_2da;
                    objRPT.Papiloma_3era = objReport.Papiloma_3era;
                    objRPT.Papiloma_NoRecuerda = objReport.Papiloma_NoRecuerda;

                    objRPT.INFLUENZA = Convert.ToDateTime(objReport.INFLUENZA);

                    objRPT.Secuencia = Convert.ToInt32(objReport.Secuencia);
                    objRPT.OtrasVacunas = objReport.OtrasVacunas;




                    listaRPT.Add(objRPT);
                }

                ///////////////////////////////                     
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewImnunizaionAdulto.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }
            return listaRPT;
        }


        private void GenerarReporterptViewApoyoDiagnostico_FE(string tipovista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewApoyoDiagnostico_FE - Entrar");

            string report = "rptViewApoyoDiagnosticoRep_FE";
            string tura = Server.MapPath("rptReports/" + report + ".rpt");
            Rpt.Load(Server.MapPath("rptReports/" + report + ".rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewApoyoDiagnostico_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewApoyoDiagnostico_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewApoyoDiagnostico_FEEdit>();
            //listaRPT = getDatarptViewApoyoDiagnostico_FE("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //Datos Generales

            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipovista == "I")
                {
                    if (tipovista == "I")
                    {
                        ReportViewer.ReportSource = Rpt;
                        ReportViewer.DataBind();
                    }
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "ApoyoDiagnostico");
                    }
                    catch (Exception ex)
                    {
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }


        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewApoyoDiagnostico_FEEdit>
        getDatarptViewApoyoDiagnostico_FE(String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion,
           SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog, String codFormato, String codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewApoyoDiagnostico_FE - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewApoyoDiagnostico_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewApoyoDiagnostico_FEEdit>();
            List<rptViewApoyoDiagnostico_FE> rptViewApoyoDiagnostico = new List<rptViewApoyoDiagnostico_FE>();
            SS_HC_ApoyoDiagnostico_FE objApoyoDiagnostico = new SS_HC_ApoyoDiagnostico_FE();
            objApoyoDiagnostico.UnidadReplicacion = unidadReplicacion;
            objApoyoDiagnostico.IdPaciente = idPaciente;
            objApoyoDiagnostico.EpisodioClinico = epiClinico;
            objApoyoDiagnostico.IdEpisodioAtencion = idEpiAtencion;
            objApoyoDiagnostico.Accion = "REPORTEA";

            //Servicio
            rptViewApoyoDiagnostico = ServiceReportes.ReporteApoyoDiagnostico_FE(objApoyoDiagnostico, 0, 0);

            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewApoyoDiagnostico_FEEdit objRPT;

            if (rptViewApoyoDiagnostico != null)
            {
                foreach (rptViewApoyoDiagnostico_FE objReport in rptViewApoyoDiagnostico)
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewApoyoDiagnostico_FEEdit();

                    objRPT.UnidadReplicacion = objReport.UnidadReplicacion;
                    objRPT.IdEpisodioAtencion = objReport.IdEpisodioAtencion;
                    objRPT.IdPaciente = objReport.IdPaciente;
                    objRPT.EpisodioClinico = objReport.EpisodioClinico;

                    //                objRPT.Secuencia = Convert.ToInt32(objReport.Secuencia);
                    objRPT.NroInforme = objReport.NroInforme;
                    objRPT.FechaSolicitada = Convert.ToDateTime(objReport.FechaSolicitada);



                    objRPT.IdEspecialidad = Convert.ToInt32(objReport.IdEspecialidad);
                    objRPT.IdProcedimiento = Convert.ToInt32(objReport.IdProcedimiento);
                    objRPT.TipoOrdenAtencion = Convert.ToInt32(objReport.TipoOrdenAtencion);
                    objRPT.CodigoComponente = objReport.CodigoComponente;
                    //objRPT.IdDiagnostico = Convert.ToInt32(objReport.IdDiagnostico);
                    //objRPT.ProcedimientoText = objReport.ProcedimientoText;
                    //objRPT.DiagnosticoText = objReport.DiagnosticoText;
                    objRPT.Observacion = objReport.Observacion;

                    objRPT.Accion = objReport.Accion;
                    objRPT.Version = objReport.Version;
                    objRPT.Estado = Convert.ToInt32(objReport.Estado);
                    objRPT.UsuarioCreacion = objReport.UsuarioCreacion;
                    //objRPT.FechaCreacion = Convert.ToDateTime(objReport.FechaCreacion);
                    //objRPT.UsuarioModificacion = objReport.UsuarioModificacion;
                    //objRPT.FechaModificacion = Convert.ToDateTime(objReport.FechaModificacion);

                    objRPT.Nombre = objReport.Nombre;
                    objRPT.RutaInforme = objReport.RutaInforme;
                    objRPT.Diagnostico = objReport.Diagnostico;


                    listaRPT.Add(objRPT);
                }

                ///////////////////////////////                     
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewApoyoDiagnostico.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }
            return listaRPT;
        }

        //rptReferencia_FE
        private void GenerarReporterptViewReferencia_FE(string tipovista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewReferencia_FE - Entrar");

            // Reporte
            string tura = Server.MapPath("rptReports/rptViewReferencia_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewReferencia_FE.rpt"));

            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewReferencia_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewReferencia_FEEdit>();

            //listaRPT = getDatarptViewReferencia_FE("REPORTEA",
            //            ENTITY_GLOBAL.Instance.UnidadReplicacion,
            //            (int)ENTITY_GLOBAL.Instance.PacienteID,
            //            (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
            //            (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
            //            null, 0,
            //            ENTITY_GLOBAL.Instance.CONCEPTO,
            //            ENTITY_GLOBAL.Instance.USUARIO);


            DataTable listaRPT = new DataTable();

            listaRPT = rptVistas_FE("rptViewReferencia_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            //Datos Generales
            setDatosGenerales();


            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);

            }
            else
            {
                if (tipovista == "I")
                {
                    if (tipovista == "I")
                    {
                        ReportViewer.ReportSource = Rpt;
                        ReportViewer.DataBind();
                    }
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {

                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DIAGNOSTICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }
        //fin rpt referencia
        //inicio  < private List> referencia
        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewReferencia_FEEdit>
        getDatarptViewReferencia_FE(String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion,
        SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog, String codFormato, String codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewReferencia_FE - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewReferencia_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewReferencia_FEEdit>();
            List<rptViewReferencia_FE> rptViewReferencia = new List<rptViewReferencia_FE>();
            SS_HC_Referencia_FE objReferencia = new SS_HC_Referencia_FE();
            objReferencia.UnidadReplicacion = unidadReplicacion;
            objReferencia.IdPaciente = idPaciente;
            objReferencia.EpisodioClinico = epiClinico;
            objReferencia.IdEpisodioAtencion = idEpiAtencion;
            objReferencia.Accion = "REPORTEA";

            //Servicio
            rptViewReferencia = ServiceReportes.ReporteReferencia_FE(objReferencia, 0, 0);

            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewReferencia_FEEdit objRPT;

            if (rptViewReferencia != null)
            {
                foreach (rptViewReferencia_FE objReport in rptViewReferencia)
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewReferencia_FEEdit();
                    objRPT.UnidadReplicacion = objReport.UnidadReplicacion;
                    objRPT.IdPaciente = objReport.IdPaciente;
                    objRPT.EpisodioClinico = objReport.EpisodioClinico;
                    objRPT.IdEpisodioAtencion = objReport.IdEpisodioAtencion;
                    objRPT.NroReferencia = objReport.NroReferencia;
                    objRPT.P_UNO = objReport.P_UNO;
                    objRPT.P_DOS = objReport.P_DOS;
                    objRPT.P_TRES = objReport.P_TRES;
                    objRPT.P_CUATRO = objReport.P_CUATRO;
                    objRPT.EstablecimientoOri = objReport.EstablecimientoOri;
                    objRPT.ServicioOri = objReport.ServicioOri;
                    objRPT.IdentificacionUsu = objReport.IdentificacionUsu;
                    objRPT.Anamnesis = objReport.Anamnesis;
                    objRPT.EstadoGeneral = objReport.EstadoGeneral;
                    objRPT.Glasgow = objReport.Glasgow;
                    objRPT.FV_T = objReport.FV_T;
                    objRPT.FV_PA = objReport.FV_PA;
                    objRPT.FV_FR = objReport.FV_FR;
                    objRPT.FV_FC = objReport.FV_FC;
                    objRPT.Exam_aux = objReport.Exam_aux;
                    objRPT.Motivo = objReport.Motivo;
                    objRPT.DR_EMERGENCIA = objReport.DR_EMERGENCIA;
                    objRPT.DR_CONSULTA_EXTERNA = objReport.DR_CONSULTA_EXTERNA;
                    objRPT.DR_HOSPITALIZACION = objReport.DR_HOSPITALIZACION;
                    objRPT.FechaReferencia = objReport.FechaReferencia;
                    objRPT.HoraReferencia = objReport.HoraReferencia;
                    objRPT.PersonaAtiende = objReport.PersonaAtiende;
                    objRPT.CS_ESTABLE = objReport.CS_ESTABLE;
                    objRPT.CS_INESTABLE = objReport.CS_INESTABLE;
                    objRPT.MedicoSanna = objReport.MedicoSanna;
                    objRPT.MedicoAtencion = objReport.MedicoAtencion;
                    objRPT.Respon_ref = objReport.Respon_ref;
                    objRPT.Colegiatura_ref = objReport.Colegiatura_ref;
                    objRPT.Respon_serv = objReport.Respon_serv;
                    objRPT.Colegiatura_ser = objReport.Colegiatura_ser;
                    objRPT.Respon_acomp = objReport.Respon_acomp;
                    objRPT.Colegiatura_acomp = objReport.Colegiatura_acomp;
                    objRPT.Respon_recibe = objReport.Respon_recibe;
                    objRPT.Colegiatura_recib = objReport.Colegiatura_recib;
                    objRPT.CLL_ESTABLE = objReport.CLL_ESTABLE;
                    objRPT.CLL_INESTABLE = objReport.CLL_INESTABLE;
                    objRPT.CLL_FALLECIDO = objReport.CLL_FALLECIDO;
                    objRPT.DIAGNOSTICO = objReport.DIAGNOSTICO;
                    listaRPT.Add(objRPT);
                }

                ///////////////////////////////                     
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewReferencia.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }
            return listaRPT;
        }

        //fin private List referencia
        private void GenerarReporterptViewExamenApoyoDiagnostico_FE(string tipovista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewExamenApoyoDiagnostico_FE - Entrar");

            // Reporte
            string tura = Server.MapPath("rptReports/rptViewExamenApoyoDiagnostico_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewExamenApoyoDiagnostico_FE.rpt"));
            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenApoyoDiagnostico_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenApoyoDiagnostico_FEEdit>();
            //listaRPT = getDatarptViewExamenApoyoDiagnostico_FE("REPORTEA",
            //            ENTITY_GLOBAL.Instance.UnidadReplicacion,
            //            (int)ENTITY_GLOBAL.Instance.PacienteID,
            //            (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
            //            (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
            //            null, 0,
            //            ENTITY_GLOBAL.Instance.CONCEPTO,
            //            ENTITY_GLOBAL.Instance.USUARIO);

            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewExamenApoyoDiagnostico_FE",
                         ENTITY_GLOBAL.Instance.UnidadReplicacion,
                         (int)ENTITY_GLOBAL.Instance.PacienteID,
                         (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                         (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                         null, 0,
                         ENTITY_GLOBAL.Instance.CONCEPTO,
                         ENTITY_GLOBAL.Instance.USUARIO);

            //Datos Generales
            setDatosGenerales();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);

            }
            else
            {
                if (tipovista == "I")
                {
                    if (tipovista == "I")
                    {
                        ReportViewer.ReportSource = Rpt;
                        ReportViewer.DataBind();
                    }
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {

                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DIAGNOSTICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }
        //

        private void GenerarReporterptViewExamenClinico_FE(string tipovista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewExamenClinico_FE - Entrar");
            // Reporte
            string tura = Server.MapPath("rptReports/rptViewExamenClinico_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewExamenClinico_FE.rpt"));
            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenApoyoDiagnostico_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenApoyoDiagnostico_FEEdit>();
            //listaRPT = getDatarptViewExamenApoyoDiagnostico_FE("REPORTEA",
            //            ENTITY_GLOBAL.Instance.UnidadReplicacion,
            //            (int)ENTITY_GLOBAL.Instance.PacienteID,
            //            (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
            //            (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
            //            null, 0,
            //            ENTITY_GLOBAL.Instance.CONCEPTO,
            //            ENTITY_GLOBAL.Instance.USUARIO);

            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewExamenClinico_FE",
                         ENTITY_GLOBAL.Instance.UnidadReplicacion,
                         (int)ENTITY_GLOBAL.Instance.PacienteID,
                         (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                         (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                         null, 0,
                         ENTITY_GLOBAL.Instance.CONCEPTO,
                         ENTITY_GLOBAL.Instance.USUARIO);

            //Datos Generales
            setDatosGenerales();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);

            }
            else
            {
                if (tipovista == "I")
                {
                    if (tipovista == "I")
                    {
                        ReportViewer.ReportSource = Rpt;
                        ReportViewer.DataBind();
                    }
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {

                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DIAGNOSTICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }


        private void GenerarReporterptViewOftalmologico_FE(string tipovista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewOftalmologico_FE - Entrar");
            // Reporte
            string tura = Server.MapPath("rptReports/rptViewOftalmologico_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewOftalmologico_FE.rpt"));

            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewOftalmologia_FE",
                         ENTITY_GLOBAL.Instance.UnidadReplicacion,
                         (int)ENTITY_GLOBAL.Instance.PacienteID,
                         (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                         (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                         null, 0,
                         ENTITY_GLOBAL.Instance.CONCEPTO,
                         ENTITY_GLOBAL.Instance.USUARIO);

            //Datos Generales
            setDatosGenerales();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);

            }
            else
            {
                if (tipovista == "I")
                {
                    if (tipovista == "I")
                    {
                        ReportViewer.ReportSource = Rpt;
                        ReportViewer.DataBind();
                    }
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {

                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DIAGNOSTICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }

        private void GenerarReporterptValoracionAM_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptValoracionAM_FE - Entrar");

            string tura = Server.MapPath("rptReports/rptViewValoracionAM_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewValoracionAM_FE.rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewValoracionAM_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionAM_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionAM_FEEdit>();
            //listaRPT = getDatarptViewValoracionAM_FE("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //DataSet obj = new DataSet();
            //dsRptViewer.Tables.Add(objTabla1.Copy());
            //dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));

            //Datos Generales
            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.SetParameterValue("imgDF", imgDF);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                    Rpt.SetParameterValue("imgDF", imgDF);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }

        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenApoyoDiagnostico_FEEdit>
   getDatarptViewExamenApoyoDiagnostico_FE(String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion,
   SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog, String codFormato, String codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewExamenApoyoDiagnostico_FE - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenApoyoDiagnostico_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewExamenApoyoDiagnostico_FEEdit>();
            List<rptViewExamenApoyoDiagnostico_FE> rptViewExamenApoyoDiagnostico = new List<rptViewExamenApoyoDiagnostico_FE>();  //modificar
            SS_HC_ExamenSolicitadoFE objExApoyoDiag = new SS_HC_ExamenSolicitadoFE();   //modificar
            objExApoyoDiag.UnidadReplicacion = unidadReplicacion;
            objExApoyoDiag.IdPaciente = idPaciente;
            objExApoyoDiag.EpisodioClinico = epiClinico;
            objExApoyoDiag.IdEpisodioAtencion = idEpiAtencion;
            objExApoyoDiag.Accion = "REPORTEA";

            //Servicio
            rptViewExamenApoyoDiagnostico = ServiceReportes.ReporteExamenApoyoDiagnostico_FE(objExApoyoDiag, 0, 0);

            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewExamenApoyoDiagnostico_FEEdit objRPT;

            if (rptViewExamenApoyoDiagnostico != null)
            {
                foreach (rptViewExamenApoyoDiagnostico_FE objReport in rptViewExamenApoyoDiagnostico)  //
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewExamenApoyoDiagnostico_FEEdit();
                    objRPT.UnidadReplicacion = objReport.UnidadReplicacion;
                    objRPT.IdPaciente = Convert.ToInt32(objReport.IdPaciente);
                    objRPT.EpisodioClinico = Convert.ToInt32(objReport.EpisodioClinico);
                    objRPT.IdEpisodioAtencion = Convert.ToInt32(objReport.IdEpisodioAtencion);
                    objRPT.Secuencia = Convert.ToInt32(objReport.Secuencia);
                    objRPT.Motivo = objReport.Motivo;
                    objRPT.FechaSolicitada = Convert.ToDateTime(objReport.FechaSolicitada);
                    //   if (rptViewExamenApoyoDiagnostico != null){objRPT.IdTipoExamen = objReport.IdTipoExamen;}else{objRPT.IdTipoExamen = 0;}
                    objRPT.TipoExamen = objReport.TipoExamen;
                    objRPT.Examen = objReport.Examen;
                    objRPT.Examen = objReport.Examen;
                    objRPT.Cantidad = Convert.ToInt32(objReport.Cantidad);
                    objRPT.Especificaciones = objReport.Especificaciones;
                    objRPT.Observacion = objReport.Observacion;
                    objRPT.Diagnostico = objReport.Diagnostico;
                    objRPT.Resumen = objReport.Resumen;
                    objRPT.CodigoSegus = objReport.CodigoSegus;
                    listaRPT.Add(objRPT);
                }

                ///////////////////////////////                     
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewExamenApoyoDiagnostico.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }
            return listaRPT;
        }


        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionAM_FEEdit>
       getDatarptViewValoracionAM_FE(
      String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
      , SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog,
      string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewValoracionAM_FE - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionAM_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionAM_FEEdit>();

            List<rptViewValoracionAM_FE> rptViewValoracionAM_FE = new List<rptViewValoracionAM_FE>();
            SS_HC_ValoracionAM_FE objValoracionAM_FE = new SS_HC_ValoracionAM_FE();
            objValoracionAM_FE.UnidadReplicacion = unidadReplicacion;
            objValoracionAM_FE.IdPaciente = idPaciente;
            objValoracionAM_FE.EpisodioClinico = epiClinico;
            objValoracionAM_FE.IdEpisodioAtencion = idEpiAtencion;
            objValoracionAM_FE.Accion = "REPORTEA";
            rptViewValoracionAM_FE = ServiceReportes.rptViewValoracionAM_FE(objValoracionAM_FE, 0, 0);
            //AAAA
            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionAM_FEEdit objRPT;
            if (rptViewValoracionAM_FE != null)
            {
                foreach (rptViewValoracionAM_FE objReport in rptViewValoracionAM_FE) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionAM_FEEdit();

                    objRPT.S = objReport.S;
                    objRPT.E = objReport.E;
                    objRPT.F = objReport.F;
                    objRPT.G = objReport.G;

                    listaRPT.Add(objRPT);
                }
                ///////////////////////////////                     
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewValoracionAM_FE.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }

            return listaRPT;

        }

        private void GenerarReporteValoracionMentalAM_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteValoracionMentalAM_FE - Entrar");
            string tura = Server.MapPath("rptReports/rptViewValoracionMentalAM_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewValoracionMentalAM_FE.rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewValoracionMentalAM_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionMentalAM_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionMentalAM_FEEdit>();
            //listaRPT = getDatarptViewValoracionMentalAM_FE("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //DataSet obj = new DataSet();
            //dsRptViewer.Tables.Add(objTabla1.Copy());
            //dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));

            //Datos Generales
            setDatosGenerales();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            imgValor = Server.MapPath("imagenes/LeyendaValoracionCongnitivo.JPG");
            Rpt.SetParameterValue("imgValor", imgValor);
            imgEstado = Server.MapPath("imagenes/LeyendaEstadoAfectivo.JPG");
            Rpt.SetParameterValue("imgEstado", imgEstado);

            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.SetParameterValue("imgValor", imgValor);
                        Rpt.SetParameterValue("imgEstado", imgEstado);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                    Rpt.SetParameterValue("imgValor", imgValor);
                    Rpt.SetParameterValue("imgEstado", imgEstado);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetParameterValue("imgValor", imgValor);
            Rpt.SetParameterValue("imgEstado", imgEstado);
        }

        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionMentalAM_FEEdit>
       getDatarptViewValoracionMentalAM_FE(
      String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
      , SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog,
      string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewValoracionMentalAM_FE - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionMentalAM_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionMentalAM_FEEdit>();

            List<rptViewValoracionMentalAM_FE> rptViewValoracionMentalAM_FE = new List<rptViewValoracionMentalAM_FE>();
            SS_HC_ValoracionMentalAM_FE objValoracionMAM_FE = new SS_HC_ValoracionMentalAM_FE();
            objValoracionMAM_FE.UnidadReplicacion = unidadReplicacion;
            objValoracionMAM_FE.IdPaciente = idPaciente;
            objValoracionMAM_FE.EpisodioClinico = epiClinico;
            objValoracionMAM_FE.IdEpisodioAtencion = idEpiAtencion;
            objValoracionMAM_FE.Accion = "REPORTEA";
            rptViewValoracionMentalAM_FE = ServiceReportes.rptViewValoracionMentalAM_FE(objValoracionMAM_FE, 0, 0);
            //AAAA
            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionMentalAM_FEEdit objRPT;
            if (rptViewValoracionMentalAM_FE != null)
            {
                foreach (rptViewValoracionMentalAM_FE objReport in rptViewValoracionMentalAM_FE) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionMentalAM_FEEdit();

                    objRPT.Cualfecha = Convert.ToInt32(objReport.Cualfecha);
                    objRPT.QueDiasemana = Convert.ToInt32(objReport.QueDiasemana);
                    objRPT.EnquelugarEstamos = Convert.ToInt32(objReport.EnquelugarEstamos);
                    objRPT.CualNumerotelefono = Convert.ToInt32(objReport.CualNumerotelefono);
                    objRPT.CuantosAniostiene = Convert.ToInt32(objReport.CuantosAniostiene);
                    objRPT.DondeNacio = Convert.ToInt32(objReport.DondeNacio);
                    objRPT.NombrePresidente = Convert.ToInt32(objReport.NombrePresidente);
                    objRPT.NombrePresidenteAnterior = Convert.ToInt32(objReport.NombrePresidenteAnterior);
                    objRPT.ApellidoMadre = Convert.ToInt32(objReport.ApellidoMadre);
                    objRPT.Restar = Convert.ToInt32(objReport.Restar);
                    objRPT.DesganoDes = objReport.DesganoDes;
                    objRPT.ImpotenteDes = objReport.ImpotenteDes;
                    objRPT.MemoriaDes = objReport.MemoriaDes;
                    objRPT.SatisfechoDes = objReport.SatisfechoDes;
                    objRPT.ValorCognitiva = objReport.ValorCognitiva;
                    objRPT.EstadoAfectivo = objReport.EstadoAfectivo;
                    listaRPT.Add(objRPT);
                }
                ///////////////////////////////                     
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewValoracionMentalAM_FE.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }

            return listaRPT;

        }


        private void GenerarReporteEvolucuionMedica_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteEvolucuionMedica_FE - Entrar");

            string tura = Server.MapPath("rptReports/rptViewEvolucionMedica_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewEvolucionMedica_FE.rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewEvolucionMedica_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewEvolucionMedica_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewEvolucionMedica_FEEdit>();
            //listaRPT = getDatarptViewEvolucionMedica_FE("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //DataSet obj = new DataSet();
            //dsRptViewer.Tables.Add(objTabla1.Copy());
            //dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));
            //Datos Generales

            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }



        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewEvolucionMedica_FEEdit>
   getDatarptViewEvolucionMedica_FE(
  String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
  , SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog,
  string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewEvolucionMedica_FE - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewEvolucionMedica_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewEvolucionMedica_FEEdit>();

            List<rptViewEvolucionMedica_FE> rptViewEvolucionMedica_FE = new List<rptViewEvolucionMedica_FE>();
            SS_HC_EvolucionMedica_FE ObjEvolucionMedica_FE = new SS_HC_EvolucionMedica_FE();
            ObjEvolucionMedica_FE.UnidadReplicacion = unidadReplicacion;
            ObjEvolucionMedica_FE.IdPaciente = idPaciente;
            ObjEvolucionMedica_FE.EpisodioClinico = epiClinico;
            ObjEvolucionMedica_FE.IdEpisodioAtencion = idEpiAtencion;
            ObjEvolucionMedica_FE.Accion = "REPORTEA";
            rptViewEvolucionMedica_FE = ServiceReportes.rptViewEvolucionMedica_FE(ObjEvolucionMedica_FE, 0, 0);
            //AAAA
            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewEvolucionMedica_FEEdit objRPT;
            if (rptViewEvolucionMedica_FE != null)
            {
                foreach (rptViewEvolucionMedica_FE objReport in rptViewEvolucionMedica_FE) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewEvolucionMedica_FEEdit();

                    objRPT.FechaIngreso = Convert.ToDateTime(objReport.FechaIngreso);
                    objRPT.Hora = Convert.ToDateTime(objReport.Hora);
                    objRPT.PersMedicoNombreCompleto = objReport.PersMedicoNombreCompleto;
                    objRPT.EvolucionObjetiva = objReport.EvolucionObjetiva;

                    listaRPT.Add(objRPT);
                }
                ///////////////////////////////                     
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewEvolucionMedica_FE.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }

            return listaRPT;

        }


        private void GenerarReporteMedicamentos_Fe(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteMedicamentos_Fe - Entrar");

            if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA")
            {
                string tura = Server.MapPath("rptReports/rptViewMedicamentos_EMEFE.rpt");
                Rpt.Load(Server.MapPath("rptReports/rptViewMedicamentos_EMEFE.rpt"));
            }
            else
            {
                string tura = Server.MapPath("rptReports/rptViewMedicamentos_FE.rpt");
                Rpt.Load(Server.MapPath("rptReports/rptViewMedicamentos_FE.rpt"));
            }
            DataTable listaRPT = new DataTable();
            DataTable listaRPT_Pac_Med = new DataTable();
            listaRPT = rptVistas_FE("rptViewMedicamentos_FE",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                ENTITY_GLOBAL.Instance.USUARIO);

            /*Datos Paciente -Medico*/
            listaRPT_Pac_Med = rptDatosPacienteMedico_FE("rptViewDatosPaciente_Medico",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                ENTITY_GLOBAL.Instance.USUARIO);

            foreach (DataRow objReport in listaRPT_Pac_Med.AsEnumerable()) // Loop through List with foreach.
            {
                if (objReport["UnidadReplicacion"] != null && objReport["UnidadReplicacion"].ToString() != "")
                {
                    System.IO.FileInfo fi = new System.IO.FileInfo(objReport["UnidadReplicacion"].ToString().Trim());
                    if (fi.Exists)
                    {
                        var NombreServidor = fi.Name;
                        var rutaServidor = Server.MapPath("../resources/DocumentosAdjuntos/firmas/");
                        if (!Directory.Exists(rutaServidor))
                        {
                            DirectoryInfo di = Directory.CreateDirectory(rutaServidor);
                        }
                        var PathServidor = rutaServidor + NombreServidor;
                        System.IO.File.Copy(objReport["UnidadReplicacion"].ToString(), PathServidor, true);
                        //System.IO.FileInfo fiServidor = new System.IO.FileInfo(PathServidor);
                        var PathOri = "../resources/DocumentosAdjuntos/firmas/" + NombreServidor;
                        //objRPT.Accion = PathOri;
                        Session["FIRMA_DIGITAL"] = PathOri;
                    }
                    else
                    {
                        Session["FIRMA_DIGITAL"] = "";
                    }
                }
                else
                {
                    Session["FIRMA_DIGITAL"] = "";
                }
            }

            Rpt.SetDataSource(listaRPT);
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit> listaRPT_1 = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit>();
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit> listaRPT_2 = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit>();
            foreach (DataRow objReport in listaRPT.AsEnumerable())  // Loop through List with foreach.
            {
                SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit();
                if (!string.IsNullOrEmpty(objReport["IdUnidadMedida"].ToString())) objRPT.IdUnidadMedida = Convert.ToInt32(objReport["IdUnidadMedida"].ToString());
                if (!string.IsNullOrEmpty(objReport["Frecuencia"].ToString())) objRPT.Frecuencia = (decimal)objReport["Frecuencia"];
                if (!string.IsNullOrEmpty(objReport["Cantidad"].ToString())) objRPT.Cantidad = Convert.ToInt32(objReport["Cantidad"]);
                if (!string.IsNullOrEmpty(objReport["TipoComida"].ToString())) objRPT.TipoComida = Convert.ToInt32(objReport["TipoComida"]);
                if (!string.IsNullOrEmpty(objReport["PersonaEdad"].ToString())) objRPT.PersonaEdad = Convert.ToInt32(objReport["PersonaEdad"]);
                if (!string.IsNullOrEmpty(objReport["FechaCreacion"].ToString())) objRPT.FechaCreacion = Convert.ToDateTime(objReport["FechaCreacion"]);
                if (!string.IsNullOrEmpty(objReport["TipoMedicamento"].ToString())) objRPT.TipoMedicamento = Convert.ToInt32(objReport["TipoMedicamento"]);
                objRPT.MED_DCI = objReport["MED_DCI"].ToString();
                objRPT.Comentario = objReport["Comentario"].ToString();
                objRPT.Presentacion = objReport["Presentacion"].ToString();
                objRPT.Dosis = objReport["Dosis"].ToString();
                objRPT.UnidMedDesc = objReport["UnidMedDesc"].ToString();
                objRPT.UndTiempoFre = objReport["UndTiempoFre"].ToString();
                objRPT.Periodo = objReport["Periodo"].ToString();
                objRPT.UndTiempoPeri = objReport["UndTiempoPeri"].ToString();
                objRPT.ViaDesc = objReport["ViaDesc"].ToString();
                objRPT.TipRecetaDes = objReport["TipRecetaDes"].ToString();
                objRPT.Indicacion = objReport["Indicacion"].ToString();
                objRPT.NombreCompleto = objReport["NombreCompleto"].ToString();
                objRPT.TipoTrabajadorDesc = objReport["TipoTrabajadorDesc"].ToString();
                objRPT.Sexo = objReport["Sexo"].ToString();
                objRPT.CodigoOA = objReport["CodigoOA"].ToString();
                objRPT.UnidadServicioDesc = objReport["UnidadServicioDesc"].ToString();
                objRPT.PersMedicoNombreCompleto = objReport["PersMedicoNombreCompleto"].ToString();
                objRPT.EstablecimientoDesc = objReport["EstablecimientoDesc"].ToString();
                objRPT.DescripcionLarga = objReport["DescripcionLarga"].ToString();
                objRPT.DescripcionLocal = objReport["DescripcionLocal"].ToString();
                objRPT.DireccionComun = objReport["DireccionComun"].ToString();
                objRPT.DocumentoFiscal = objReport["DocumentoFiscal"].ToString();
                objRPT.TITULAR = objReport["TITULAR"].ToString();
                objRPT.VIGENCIA = objReport["VIGENCIA"].ToString();
                objRPT.POLIZA = objReport["POLIZA"].ToString();
                objRPT.ASEGURADORA = objReport["ASEGURADORA"].ToString();
                objRPT.Busqueda = objReport["Busqueda"].ToString();
                objRPT.DCI = objReport["DCI"].ToString();
                objRPT.Nombre = objReport["Nombre"].ToString();
                objRPT.DiagnosticoDesc = objReport["DiagnosticoDesc"].ToString();
                objRPT.UsuarioAuditoria = objReport["UsuarioAuditoria"].ToString();
                if (objRPT.TipoMedicamento == 1)
                {
                    listaRPT_1.Add(objRPT);
                }
                if (objRPT.TipoMedicamento == 4)
                {
                    listaRPT_2.Add(objRPT);
                }
            }
            //listaRPT_1 = getDatarptViewMedicamentos_FE("REPORTEA",
            //    ENTITY_GLOBAL.Instance.UnidadReplicacion,
            //    (int)ENTITY_GLOBAL.Instance.PacienteID,
            //    (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
            //    (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
            //    ENTITY_GLOBAL.Instance.USUARIO, 1);

            //listaRPT_2 = getDatarptViewMedicamentos_FE("REPORTEA",
            //    ENTITY_GLOBAL.Instance.UnidadReplicacion,
            //    (int)ENTITY_GLOBAL.Instance.PacienteID,
            //    (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
            //    (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
            //    ENTITY_GLOBAL.Instance.USUARIO, 4);



            if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA")
            {
                Rpt.Subreports["rptViewMedicamentos_FEEMEDetalle1.rpt"].SetDataSource(listaRPT_1);
            }
            else
            {
                Rpt.Subreports["rptViewMedicamentos_FEDetalle1.rpt"].SetDataSource(listaRPT_1);
            }
 
            if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA")
            {
                Rpt.Subreports["rptViewMedicamentos_FEEMEDetalle2.rpt"].SetDataSource(listaRPT_2);
            }
            else
            {
                Rpt.Subreports["rptViewMedicamentos_FEDetalle2.rpt"].SetDataSource(listaRPT_2);
            }

            if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA")
            {
                Rpt.Subreports["rptViewMedicamentos_EMEFEsubrepFirmas.rpt"].SetDataSource(listaRPT_Pac_Med);
            }
            else
            {
                Rpt.Subreports["rptViewMedicamentos_FEsubrepFirmas.rpt"].SetDataSource(listaRPT_Pac_Med);
            }

            Rpt.SetDataSource(listaRPT);
            setDatosGenerales();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            imgFirma = Server.MapPath((string)Session["FIRMA_DIGITAL"]);
            Rpt.SetParameterValue("imgFirma", imgFirma);

            if (listaRPT_1.Count == 0 && listaRPT_2.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.SetParameterValue("imgFirma", imgFirma);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                    Rpt.SetParameterValue("imgFirma", imgFirma);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetParameterValue("imgFirma", imgFirma);
        }
             
        private void GenerarReporteMedicamentosGrupal_Fe(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteMedicamentosGrupal_Fe - Entrar");

            string tura = Server.MapPath("rptReports/rptGrupalViewMedicamentos_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewGrupalMedicamentos_FE.rpt"));
            DataTable listaRPT = new DataTable();
            DataTable listaRPT_Pac_Med = new DataTable();
            listaRPT = rptVistas_FE("rptViewMedicamentos_FE",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                ENTITY_GLOBAL.Instance.USUARIO);
            /*Datos Paciente -Medico*/
            listaRPT_Pac_Med = rptDatosPacienteMedico_FE("rptViewDatosPaciente_Medico",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                ENTITY_GLOBAL.Instance.USUARIO);

            Rpt.SetDataSource(listaRPT);
            //DataSet obj = new DataSet();
            //dsRptViewer.Tables.Add(objTabla1.Copy());
            ////dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit> listaRPT_1 = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit>();

            listaRPT_1 = getDatarptViewMedicamentos_FE("REPORTEA",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                ENTITY_GLOBAL.Instance.USUARIO, 1);
            Rpt.Subreports["rptViewMedicamentos_FEDetalle1.rpt"].SetDataSource(listaRPT_1);
            //    Rpt.SetDataSource(listaRPT_1);
            DataTable listaRPT_2 = new DataTable();
            listaRPT_2 = rptVistas_FE("rptViewGrupalMedicamentos_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
              , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            Rpt.Subreports["rptViewMedicamentos_FEDetalle2Grupal.rpt"].SetDataSource(listaRPT_2);
            Rpt.Subreports["rptViewMedicamentos_FEsubrepFirmas.rpt"].SetDataSource(listaRPT_Pac_Med);

            Rpt.SetDataSource(listaRPT);
            setDatosGenerales();



            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            imgFirma = Server.MapPath((string)Session["FIRMA_DIGITAL"]);
            Rpt.SetParameterValue("imgFirma", imgFirma);

            if (listaRPT_1.Count == 0 && listaRPT_2.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.SetParameterValue("imgFirma", imgFirma);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                    Rpt.SetParameterValue("imgFirma", imgFirma);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetParameterValue("imgFirma", imgFirma);

            //Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


        }
        //private void GenerarReporteMedicamentos_Fe_Detalle1(string tipoVista)
        //{
        //    string tura = Server.MapPath("rptReports/rptViewMedicamentos_FEDetalle1.rpt");
        //    Rpt.Load(Server.MapPath("rptReports/rptViewMedicamentos_FEDetalle1.rpt"));

        //    List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit>();
        //    listaRPT = getDatgetDatarptViewMedicamentos_FEarptViewMedicamentos_FE("REPORTEA",
        //        ENTITY_GLOBAL.Instance.UnidadReplicacion,
        //        (int)ENTITY_GLOBAL.Instance.PacienteID,
        //        (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
        //        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
        //        , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
        //        ENTITY_GLOBAL.Instance.USUARIO,1);
        //    Rpt.SetDataSource(listaRPT);
        //    if (listaRPT.Count == 0)
        //    { ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true); }
        //    else
        //    {
        //        if (tipoVista == "I")
        //        {
        //            ReportViewer.ReportSource = Rpt;
        //            ReportViewer.DataBind();
        //        }
        //        else
        //        {
        //            Response.Buffer = false;
        //            Response.ClearContent();
        //            Response.ClearHeaders();
        //            try
        //            {
        //                Rpt.ExportToHttpResponse
        //                (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "AnteFamiliar");
        //            }
        //            catch (Exception ex)
        //            {
        //                throw;
        //            }
        //        }
        //    }
        //    GenerarReporteMedicamentos_Fe_Detalle1(tipoVista);

        //}

        //private void GenerarReporteMedicamentos_Fe_Detalle2(string tipoVista)
        //{
        //    string tura = Server.MapPath("rptReports/rptViewMedicamentos_FEDetalle2.rpt");
        //    Rpt.Load(Server.MapPath("rptReports/rptViewMedicamentos_FEDetalle2.rpt"));

        //    List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit>();
        //    listaRPT = getDatarptViewMedicamentos_FE("REPORTEA",
        //            ENTITY_GLOBAL.Instance.UnidadReplicacion,
        //            (int)ENTITY_GLOBAL.Instance.PacienteID,
        //            (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
        //            (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
        //            , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
        //            ENTITY_GLOBAL.Instance.USUARIO, 4);
        //    Rpt.SetDataSource(listaRPT);
        //    if (listaRPT.Count == 0)
        //    { ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true); }
        //    else
        //    {
        //        if (tipoVista == "I")
        //        {
        //            ReportViewer.ReportSource = Rpt;
        //            ReportViewer.DataBind();
        //        }
        //        else
        //        {
        //            Response.Buffer = false;
        //            Response.ClearContent();
        //            Response.ClearHeaders();
        //            try
        //            {
        //                Rpt.ExportToHttpResponse
        //                (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "AnteFamiliar");
        //            }
        //            catch (Exception ex)
        //            {
        //                throw;
        //            }
        //        }
        //    }
        //    GenerarReporteMedicamentos_Fe_Detalle2(tipoVista);
        //}

        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit> getDatarptViewMedicamentos_FE(
                String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion, SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog, string codFormato, string codUsuario, int tipomedicamento)
        {
            Log.Information("VisorReportesHCE - getDatarptViewMedicamentos_FE - Entrar");
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit>();
            List<rptViewMedicamentos_FE> rptViewMedicamentos_FE = new List<rptViewMedicamentos_FE>();
            SS_HC_Medicamento_FE ObjMedicamento_FE = new SS_HC_Medicamento_FE();
            ObjMedicamento_FE.UnidadReplicacion = unidadReplicacion;
            ObjMedicamento_FE.IdPaciente = idPaciente;
            ObjMedicamento_FE.EpisodioClinico = epiClinico;
            ObjMedicamento_FE.IdEpisodioAtencion = idEpiAtencion;
            ObjMedicamento_FE.Accion = "REPORTEA";
            rptViewMedicamentos_FE = ServiceReportes.rptViewMedicamentos_FE(ObjMedicamento_FE, 0, 0, tipomedicamento);
            //AAAA
            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit objRPT;
            if (rptViewMedicamentos_FE != null)
            {
                foreach (rptViewMedicamentos_FE objReport in rptViewMedicamentos_FE) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit();
                    objRPT.IdUnidadMedida = Convert.ToInt32(objReport.IdUnidadMedida);

                    if (objReport.Frecuencia != null)
                    {
                        objRPT.Frecuencia =/* Convert.ToInt32(*/(decimal)objReport.Frecuencia/*)*/;
                    }
                    else
                    {
                        objRPT.Frecuencia = Convert.ToInt32(objReport.Frecuencia);
                    }
                    objRPT.MED_DCI = objReport.MED_DCI;
                    objRPT.Comentario = objReport.Comentario;
                    objRPT.Presentacion = objReport.Presentacion;
                    objRPT.Dosis = objReport.Dosis;
                    objRPT.UnidMedDesc = objReport.UnidMedDesc;
                    objRPT.TipoComida = Convert.ToInt32(objReport.TipoComida);
                    objRPT.UndTiempoFre = objReport.UndTiempoFre;
                    objRPT.Periodo = objReport.Periodo;
                    objRPT.UndTiempoPeri = objReport.UndTiempoPeri;
                    objRPT.ViaDesc = objReport.ViaDesc;
                    objRPT.Cantidad = Convert.ToInt32(objReport.Cantidad);
                    objRPT.TipRecetaDes = objReport.TipRecetaDes;
                    objRPT.Indicacion = objReport.Indicacion;
                    objRPT.NombreCompleto = objReport.NombreCompleto;
                    objRPT.TipoTrabajadorDesc = objReport.TipoTrabajadorDesc;
                    objRPT.Sexo = objReport.Sexo;
                    objRPT.CodigoOA = objReport.CodigoOA;
                    objRPT.PersonaEdad = Convert.ToInt32(objReport.PersonaEdad);
                    objRPT.UnidadServicioDesc = objReport.UnidadServicioDesc;
                    objRPT.PersMedicoNombreCompleto = objReport.PersMedicoNombreCompleto;
                    objRPT.EstablecimientoDesc = objReport.EstablecimientoDesc;
                    objRPT.DescripcionLarga = objReport.DescripcionLarga;
                    objRPT.DescripcionLocal = objReport.DescripcionLocal;
                    objRPT.DireccionComun = objReport.DireccionComun;
                    objRPT.DocumentoFiscal = objReport.DocumentoFiscal;
                    objRPT.FechaCreacion = Convert.ToDateTime(objReport.FechaCreacion);
                    objRPT.TITULAR = objReport.TITULAR;
                    objRPT.VIGENCIA = objReport.VIGENCIA;
                    objRPT.POLIZA = objReport.POLIZA;
                    objRPT.ASEGURADORA = objReport.ASEGURADORA;
                    objRPT.Busqueda = objReport.Busqueda;
                    objRPT.DCI = objReport.DCI;
                    objRPT.Nombre = objReport.Nombre;
                    objRPT.DiagnosticoDesc = objReport.DiagnosticoDesc;
                    objRPT.UsuarioAuditoria = objReport.UsuarioAuditoria;
                    if (objReport.UnidadServicioCodigo != null && objReport.UnidadServicioCodigo != "")
                    {
                        System.IO.FileInfo fi = new System.IO.FileInfo(objReport.UnidadServicioCodigo.Trim());
                        if (fi.Exists)
                        {
                            var NombreServidor = fi.Name;
                            var rutaServidor = Server.MapPath("../resources/DocumentosAdjuntos/firmas/");
                            if (!Directory.Exists(rutaServidor))
                            {
                                DirectoryInfo di = Directory.CreateDirectory(rutaServidor);
                            }
                            var PathServidor = rutaServidor + NombreServidor;
                            System.IO.File.Copy(objReport.UnidadServicioCodigo, PathServidor, true);
                            //System.IO.FileInfo fiServidor = new System.IO.FileInfo(PathServidor);
                            var PathOri = "../resources/DocumentosAdjuntos/firmas/" + NombreServidor;
                            //objRPT.Accion = PathOri;
                            Session["FIRMA_DIGITAL"] = PathOri;
                        }
                    }
                    else
                    {
                        Session["FIRMA_DIGITAL"] = "";
                    }
                    listaRPT.Add(objRPT);
                }
                ///////////////////////////////                     
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewMedicamentos_FE.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }

            return listaRPT;

        }


        private void GenerarReporteInterconsulta_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteInterconsulta_FE - Entrar");

            string tura = Server.MapPath("rptReports/rptViewInterconsulta_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewInterconsulta_FE.rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewInterconsulta_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewInterconsulta_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewInterconsulta_FEEdit>();
            //listaRPT = getDatarptViewInterconsulta_FE("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //DataSet obj = new DataSet();
            //dsRptViewer.Tables.Add(objTabla1.Copy());
            //dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));
            //Datos GeneralesrptviewMedicamentos_FE 

            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }


        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewInterconsulta_FEEdit>
   getDatarptViewInterconsulta_FE(
 String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
  , SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog,
  string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewInterconsulta_FE - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewInterconsulta_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewInterconsulta_FEEdit>();

            List<rptViewInterconsulta_FE> rptViewInterconsulta_FE = new List<rptViewInterconsulta_FE>();
            SS_HC_InterConsulta_FE ObjMedicamento_FE = new SS_HC_InterConsulta_FE();
            ObjMedicamento_FE.UnidadReplicacion = unidadReplicacion;
            ObjMedicamento_FE.IdPaciente = idPaciente;
            ObjMedicamento_FE.EpisodioClinico = epiClinico;
            ObjMedicamento_FE.IdEpisodioAtencion = idEpiAtencion;
            ObjMedicamento_FE.Accion = "REPORTEA";
            rptViewInterconsulta_FE = ServiceReportes.rptViewInterconsulta_FE(ObjMedicamento_FE, 0, 0);
            //AAAA
            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewInterconsulta_FEEdit objRPT;
            if (rptViewInterconsulta_FE != null)
            {
                foreach (rptViewInterconsulta_FE objReport in rptViewInterconsulta_FE) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewInterconsulta_FEEdit();


                    objRPT.diagnostico = objReport.diagnostico;
                    objRPT.DiagnosticoText = objReport.DiagnosticoText;
                    objRPT.FechaSolicitada = Convert.ToDateTime(objReport.FechaSolicitada);
                    objRPT.EspecialidadDesc = objReport.EspecialidadDesc;
                    objRPT.FechaPlaneada = Convert.ToDateTime(objReport.FechaPlaneada);
                    objRPT.CodigoComponente = objReport.CodigoComponente;
                    objRPT.Observacion = objReport.Observacion;
                    listaRPT.Add(objRPT);
                }
                ///////////////////////////////                     
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewInterconsulta_FE.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }

            return listaRPT;

        }





        private void GenerarReporteValoracionSocioFamAM_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteValoracionSocioFamAM_FE - Entrar");

            string tura = Server.MapPath("rptReports/rptViewValoracionSocioFamAM_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewValoracionSocioFamAM_FE.rpt"));

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionSocioFamAM_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionSocioFamAM_FEEdit>();
            listaRPT = getDatarptViewValoracionSocioFamAM_FE("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //DataSet obj = new DataSet();
            //dsRptViewer.Tables.Add(objTabla1.Copy());
            //dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));

            //Datos Generales
            setDatosGenerales();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            imgValoracionSocio = Server.MapPath("Imagen/LeyendaEstadoSocio.JPG");
            Rpt.SetParameterValue("imgValoracionSocio", imgValoracionSocio);

            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.SetParameterValue("imgValoracionSocio", imgValoracionSocio);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                    Rpt.SetParameterValue("imgValoracionSocio", imgValoracionSocio);

                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetParameterValue("imgValoracionSocio", imgValoracionSocio);
            //Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


        }



        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionSocioFamAM_FEEdit>
        getDatarptViewValoracionSocioFamAM_FE(
        String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
        , SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog,
        string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewValoracionSocioFamAM_FE - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionSocioFamAM_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionSocioFamAM_FEEdit>();

            List<rptViewValoracionSocioFamAM_FE> rptViewValoracionSocioFamAM_FE = new List<rptViewValoracionSocioFamAM_FE>();
            SS_HC_ValoracionSocioFamAM_FE ObjValoracionSocioAM_FE = new SS_HC_ValoracionSocioFamAM_FE();
            ObjValoracionSocioAM_FE.UnidadReplicacion = unidadReplicacion;
            ObjValoracionSocioAM_FE.IdPaciente = idPaciente;
            ObjValoracionSocioAM_FE.EpisodioClinico = epiClinico;
            ObjValoracionSocioAM_FE.IdEpisodioAtencion = idEpiAtencion;
            ObjValoracionSocioAM_FE.Accion = "REPORTEA";
            rptViewValoracionSocioFamAM_FE = ServiceReportes.rptViewValoracionSocioFamAM_FE(ObjValoracionSocioAM_FE, 0, 0);
            //AAAA
            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionSocioFamAM_FEEdit objRPT;
            if (rptViewValoracionSocioFamAM_FE != null)
            {
                foreach (rptViewValoracionSocioFamAM_FE objReport in rptViewValoracionSocioFamAM_FE) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewValoracionSocioFamAM_FEEdit();


                    objRPT.V1 = objReport.V1;
                    objRPT.V2 = objReport.V2;
                    objRPT.V3 = objReport.V3;
                    objRPT.V4 = objReport.V4;
                    objRPT.V5 = objReport.V5;

                    objRPT.ARS1 = objReport.ARS1;
                    objRPT.ARS2 = objReport.ARS2;
                    objRPT.ARS3 = objReport.ARS3;
                    objRPT.ARS4 = objReport.ARS4;
                    objRPT.ARS5 = objReport.ARS5;

                    objRPT.RS1 = objReport.RS1;
                    objRPT.RS2 = objReport.RS2;
                    objRPT.RS3 = objReport.RS3;
                    objRPT.RS4 = objReport.RS4;
                    objRPT.RS5 = objReport.RS5;


                    objRPT.SE1 = objReport.SE1;
                    objRPT.SE2 = objReport.SE2;
                    objRPT.SE3 = objReport.SE3;
                    objRPT.SE4 = objReport.SE4;
                    objRPT.SE5 = objReport.SE5;


                    objRPT.SS1 = objReport.SS1;
                    objRPT.SS2 = objReport.SS2;
                    objRPT.SS3 = objReport.SS3;
                    objRPT.SS4 = objReport.SS4;
                    objRPT.SS5 = objReport.SS5;

                    objRPT.Valoracion = objReport.Valoracion;

                    listaRPT.Add(objRPT);
                }
                ///////////////////////////////                     
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewValoracionSocioFamAM_FE.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }

            return listaRPT;

        }


        private void GenerarReporteAnamnesis_ANTFAM_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteAnamnesis_ANTFAM_FE - Entrar");

            string tura = Server.MapPath("rptReports/rptViewAnamnesis_ANTFAM_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewAnamnesis_ANTFAM_FE.rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewAnamnesis_AFAM_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesis_AFAM_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesis_AFAM_FEEdit>();
            //listaRPT = getDatarptViewAnamnesis_ANTFAM_FE("REPORTEA",
            //        ENTITY_GLOBAL.Instance.UnidadReplicacion,
            //        (int)ENTITY_GLOBAL.Instance.PacienteID,
            //    (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
            //    (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
            //    ENTITY_GLOBAL.Instance.USUARIO);

            //Datos Generales
            setDatosGenerales();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "AnteFamiliar");
                    }
                    catch (Exception ex)
                    {
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }



        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesis_AFAM_FEEdit>
        getDatarptViewAnamnesis_ANTFAM_FE(String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion,
            SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog, string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewAnamnesis_ANTFAM_FE - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesis_AFAM_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesis_AFAM_FEEdit>();
            List<rptViewAnamnesis_AFAM_FE> rptViewAnamnesis_AFAM = new List<rptViewAnamnesis_AFAM_FE>();
            SS_HC_Anamnesis_AFAM_CAB_FE ObjAnamnesis_AFAM_CAB = new SS_HC_Anamnesis_AFAM_CAB_FE();
            ObjAnamnesis_AFAM_CAB.UnidadReplicacion = unidadReplicacion;
            ObjAnamnesis_AFAM_CAB.IdPaciente = idPaciente;
            ObjAnamnesis_AFAM_CAB.EpisodioClinico = epiClinico;
            ObjAnamnesis_AFAM_CAB.IdEpisodioAtencion = idEpiAtencion;
            ObjAnamnesis_AFAM_CAB.Accion = "REPORTEA";

            //Servicio
            rptViewAnamnesis_AFAM = ServiceReportes.rptViewAnamnesis_AFAM_FE(ObjAnamnesis_AFAM_CAB, 0, 0);

            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesis_AFAM_FEEdit objRPT;
            if (rptViewAnamnesis_AFAM != null)
            {
                foreach (rptViewAnamnesis_AFAM_FE objReport in rptViewAnamnesis_AFAM) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewAnamnesis_AFAM_FEEdit();


                    objRPT.AntecedenteFami_flag = objReport.AntecedenteFami_flag;
                    objRPT.UnidadReplicacion = objReport.UnidadReplicacion;
                    objRPT.IdEpisodioAtencion = objReport.IdEpisodioAtencion;
                    objRPT.IdPaciente = objReport.IdPaciente;
                    objRPT.EpisodioClinico = objReport.EpisodioClinico;
                    //    objRPT.IdTipoParentesco = Convert.ToInt32(objReport.IdTipoParentesco);                    
                    if (objReport.Edad != null)
                    {
                        objRPT.Edad = Convert.ToInt32(objReport.Edad);
                    }

                    //    objRPT.IdVivo = objReport.IdVivo;
                    //objRPT.Estado = objReport.Estado;
                    objRPT.UsuarioCreacion = objReport.UsuarioCreacion;
                    //objRPT.FechaCreacion = objReport.FechaCreacion;
                    //objRPT.UsuarioModificacion = objReport.UsuarioModificacion;
                    //objRPT.FechaModificacion = objReport.FechaModificacion;
                    objRPT.Accion = objReport.Accion;
                    objRPT.Version = objReport.Version;
                    objRPT.Expr1 = Convert.ToInt32(objReport.Expr1);
                    objRPT.Expr103 = objReport.Expr103; // Grupo
                    objRPT.Secuencia = objReport.Secuencia;
                    objRPT.IdDiagnostico = objReport.IdDiagnostico;
                    objRPT.Observaciones = objReport.Observaciones;
                    objRPT.IDAntecedentePat = Convert.ToInt32(objReport.IDAntecedentePat);
                    objRPT.CodigoAntecedentePat = objReport.CodigoAntecedentePat;
                    objRPT.Descripcion = objReport.Descripcion;
                    objRPT.Adicional1 = objReport.Adicional1;
                    objRPT.Adicional2 = objReport.Adicional2;
                    //objRPT.Expr2 = objReport.Expr2;
                    //objRPT.Expr4 = objReport.Expr4;
                    //objRPT.Expr5 = objReport.Expr5;
                    //objRPT.Expr6 = objReport.Expr6;
                    //objRPT.IdDiagnosticoPadre = objReport.IdDiagnosticoPadre;
                    //objRPT.Orden = objReport.Orden;
                    objRPT.Expr2 = Convert.ToInt32(objReport.Expr2);
                    //objRPT.Nivel = objReport.Nivel;
                    objRPT.Expr5 = Convert.ToDateTime(objReport.Expr5);
                    //objRPT.IndicadorPermitido = objReport.IndicadorPermitido;
                    //objRPT.tipoFolder = objReport.tipoFolder;
                    objRPT.Expr6 = objReport.Expr6;
                    objRPT.ApellidoPaterno = objReport.ApellidoPaterno;
                    objRPT.ApellidoMaterno = objReport.ApellidoMaterno;
                    objRPT.Nombres = objReport.Nombres;
                    objRPT.NombreCompleto = objReport.NombreCompleto;
                    objRPT.Busqueda = objReport.Busqueda;
                    objRPT.TipoDocumento = objReport.TipoDocumento;
                    objRPT.Documento = objReport.Documento;
                    //objRPT.FechaNacimiento = objReport.FechaNacimiento;
                    objRPT.Sexo = objReport.Sexo;
                    objRPT.EstadoCivil = objReport.EstadoCivil;
                    //objRPT.PersonaEdad = objReport.PersonaEdad;
                    //objRPT.IdOrdenAtencion = objReport.IdOrdenAtencion;
                    objRPT.CodigoOA = objReport.CodigoOA;
                    //objRPT.LineaOrdenAtencion = objReport.LineaOrdenAtencion;
                    //objRPT.TipoOrdenAtencion = objReport.TipoOrdenAtencion;
                    //objRPT.TipoAtencion = objReport.TipoAtencion;
                    objRPT.TipoTrabajador = objReport.TipoTrabajador;
                    //objRPT.IdEstablecimientoSalud = objReport.IdEstablecimientoSalud;
                    //objRPT.IdUnidadServicio = objReport.IdUnidadServicio;
                    //objRPT.IdPersonalSalud = objReport.IdPersonalSalud;
                    //objRPT.FechaRegistro = objReport.FechaRegistro;
                    //objRPT.FechaAtencion = objReport.FechaAtencion;
                    //objRPT.IdEspecialidad = objReport.IdEspecialidad;
                    //objRPT.IdTipoOrden = objReport.IdTipoOrden;
                    //objRPT.estadoEpiAtencion = objReport.estadoEpiAtencion;
                    objRPT.Expr102 = objReport.Expr102;
                    objRPT.TipoAtencionDesc = objReport.TipoAtencionDesc;
                    objRPT.TipoTrabajadorDesc = objReport.TipoTrabajadorDesc;
                    objRPT.EstablecimientoCodigo = objReport.EstablecimientoCodigo;
                    objRPT.EstablecimientoDesc = objReport.EstablecimientoDesc;
                    objRPT.UnidadServicioCodigo = objReport.UnidadServicioCodigo;
                    objRPT.UnidadServicioDesc = objReport.UnidadServicioDesc;
                    objRPT.PersMedicoNombreCompleto = objReport.PersMedicoNombreCompleto;
                    objRPT.PersMedicoNombreDocumento = objReport.PersMedicoNombreDocumento;
                    objRPT.Expr104 = objReport.Expr104; //Especialiadad
                    objRPT.EspecialidadCodigo = objReport.EspecialidadCodigo;
                    objRPT.EspecialidadDesc = objReport.EspecialidadDesc;
                    objRPT.Expr101 = objReport.Expr101; // Parentesco
                    objRPT.Expr3 = objReport.Expr3;
                    objRPT.PersonaEdad = Convert.ToInt32(objReport.PersonaEdad);

                    listaRPT.Add(objRPT);
                }

                ///////////////////////////////                     
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewAnamnesis_AFAM.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 

            }
            return listaRPT;

        }
        private void GenerarReporteContrarReferencia_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteContrarReferencia_FE - Entrar");

            string tura = Server.MapPath("rptReports/rptViewContrarReferencia_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewContrarReferencia_FE.rpt"));

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewContrarReferencia_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewContrarReferencia_FEEdit>();
            listaRPT = getDatarptViewContrarReferencia_FE("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //DataSet obj = new DataSet();
            //dsRptViewer.Tables.Add(objTabla1.Copy());
            //dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));

            //Datos Generales
            setDatosGenerales();


            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            imgFirmaContrare = Server.MapPath((string)Session["FIRMA_DIGITALCONTRAREFE"]);
            Rpt.SetParameterValue("imgFirmaContrare", imgFirmaContrare);
            //imgFirma = Server.MapPath((string)Session["FIRMA_DIGITAL"]);


            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.SetParameterValue("imgFirmaContrare", imgFirmaContrare);

                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                    Rpt.SetParameterValue("imgFirmaContrare", imgFirmaContrare);

                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetParameterValue("imgFirmaContrare", imgFirmaContrare);

            //Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


        }



        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewContrarReferencia_FEEdit>
   getDatarptViewContrarReferencia_FE(
 String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
  , SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog,
  string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewContrarReferencia_FE - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewContrarReferencia_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewContrarReferencia_FEEdit>();

            List<rptViewContrarReferencia_FE> rptViewContrarReferencia_FE = new List<rptViewContrarReferencia_FE>();
            SS_HC_CONTRARREFERENCIA_FE ObjValoracionSocioAM_FE = new SS_HC_CONTRARREFERENCIA_FE();
            ObjValoracionSocioAM_FE.UnidadReplicacion = unidadReplicacion;
            ObjValoracionSocioAM_FE.IdPaciente = idPaciente;
            ObjValoracionSocioAM_FE.EpisodioClinico = epiClinico;
            ObjValoracionSocioAM_FE.IdEpisodioAtencion = idEpiAtencion;
            ObjValoracionSocioAM_FE.Accion = "REPORTEA";
            rptViewContrarReferencia_FE = ServiceReportes.rptViewContrarReferencia_FE(ObjValoracionSocioAM_FE, 0, 0);
            //AAAA
            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewContrarReferencia_FEEdit objRPT;
            if (rptViewContrarReferencia_FE != null)
            {
                foreach (rptViewContrarReferencia_FE objReport in rptViewContrarReferencia_FE) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewContrarReferencia_FEEdit();


                    objRPT.CalificacionJ = objReport.CalificacionJ;
                    objRPT.CalificacionNJ = objReport.CalificacionNJ;
                    objRPT.CMP = objReport.CMP;
                    objRPT.CPA = objReport.CPA;
                    objRPT.CPC = objReport.CPC;
                    objRPT.CPD = objReport.CPD;
                    objRPT.CPF = objReport.CPF;
                    objRPT.CPM = objReport.CPM;
                    objRPT.CPR = objReport.CPR;
                    objRPT.DiagnosticoEG = objReport.DiagnosticoEG;
                    objRPT.DiagnosticoIN = objReport.DiagnosticoIN;
                    objRPT.EpisodioClinico = objReport.EpisodioClinico;
                    objRPT.EspecialidadDesc = objReport.EspecialidadDesc;
                    objRPT.EstablecimientoDestino = objReport.EstablecimientoDestino;
                    objRPT.establecimientoOrigen = objReport.establecimientoOrigen;
                    objRPT.FechaContrarreferencia = Convert.ToDateTime(objReport.FechaContrarreferencia);
                    objRPT.FechaEgreso = Convert.ToDateTime(objReport.FechaEgreso);
                    objRPT.FechaIngreso = Convert.ToDateTime(objReport.FechaIngreso);
                    objRPT.HoraContrarreferencia = Convert.ToDateTime(objReport.HoraContrarreferencia);
                    objRPT.IdentificacionUsuario = objReport.IdentificacionUsuario;
                    objRPT.IdPaciente = objReport.IdPaciente;
                    objRPT.NombreCompleto = objReport.NombreCompleto;
                    objRPT.NroContrarreferencia = Convert.ToInt64(objReport.NroContrarreferencia);
                    objRPT.OrigenA = objReport.OrigenA;
                    objRPT.OrigenD = objReport.OrigenD;
                    objRPT.OrigenE = objReport.OrigenE;
                    objRPT.ProcedimientosRealizados = objReport.ProcedimientosRealizados;
                    objRPT.Recomendaciones = objReport.Recomendaciones;
                    objRPT.ServicioDestino = objReport.ServicioDestino;
                    objRPT.servicioOrigen = objReport.servicioOrigen;
                    objRPT.TratamientoRealizados = objReport.TratamientoRealizados;
                    objRPT.UPSA = objReport.UPSA;
                    objRPT.UPSC = objReport.UPSC;
                    objRPT.UPSE = objReport.UPSE;
                    objRPT.UPSH = objReport.UPSH;

                    if (objReport.UnidadServicioCodigo != null && objReport.UnidadServicioCodigo != "")
                    {
                        System.IO.FileInfo fi = new System.IO.FileInfo(objReport.UnidadServicioCodigo.Trim()); //Jordan Mateo 03/05/2018
                        if (fi.Exists)
                        {
                            var NombreServidor = fi.Name;
                            var rutaServidor = Server.MapPath("../resources/DocumentosAdjuntos/firmas/");
                            if (!Directory.Exists(rutaServidor))
                            {
                                DirectoryInfo di = Directory.CreateDirectory(rutaServidor);
                            }
                            var PathServidor = rutaServidor + NombreServidor;
                            System.IO.File.Copy(objReport.UnidadServicioCodigo, PathServidor, true);
                            //System.IO.FileInfo fiServidor = new System.IO.FileInfo(PathServidor);
                            var PathOri = "../resources/DocumentosAdjuntos/firmas/" + NombreServidor;
                            //objRPT.Accion = PathOri;
                            Session["FIRMA_DIGITALCONTRAREFE"] = PathOri;

                        }
                    }
                    else
                    {
                        Session["FIRMA_DIGITALCONTRAREFE"] = "";
                    }

                    listaRPT.Add(objRPT);
                }
                ///////////////////////////////                     
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewContrarReferencia_FE.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }
            return listaRPT;
        }


        private void GenerarReporteSolicitudTransfusional_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - getDatarptViewContrarReferencia_FE - Entrar");

            string tura = Server.MapPath("rptReports/rptViewSolicitudTransfusional2_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewSolicitudTransfusional2_FE.rpt"));
            //List<SoluccionSalud.Entidades.Entidades.rptViewSolicitudTransfusional2_FE> listaRPT = new List<SoluccionSalud.Entidades.Entidades.rptViewSolicitudTransfusional2_FE>();



            DataTable listaRPT2 = new DataTable();

            listaRPT2 = rptVistas_FE("rptViewSolicitudTransfusional2_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewSolicitudTransfusional_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
              , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            Rpt.Subreports["rptViewSolucitud_Transfusional_FE.rpt"].SetDataSource(listaRPT);
            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            imgFirma = Server.MapPath((string)Session["FIRMA_DIGITAL"]);
            Rpt.SetParameterValue("imgFirma", imgFirma);
            Rpt.SetDataSource(listaRPT2);

            if (listaRPT2.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);

            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

                        Rpt.SetParameterValue("imgFirma", imgFirma);

                        Rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

                    Rpt.SetParameterValue("imgFirma", imgFirma);



                }

            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            Rpt.SetParameterValue("imgFirma", imgFirma);





        }


        private void GenerarReporteSolicitudTransfusional2_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteSolicitudTransfusional2_FE - Entrar");

            string tura = Server.MapPath("rptReports/rptViewSolicitudTransfusional2_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewSolicitudTransfusional2_FE.rpt"));
            //List<SoluccionSalud.Entidades.Entidades.rptViewSolicitudTransfusional2_FE> listaRPT = new List<SoluccionSalud.Entidades.Entidades.rptViewSolicitudTransfusional2_FE>();



            DataTable listaRPT2 = new DataTable();

            listaRPT2 = rptVistas_FE("rptViewSolicitudTransfusional2_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewSolicitudTransfusional_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
              , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            Rpt.Subreports["rptViewSolucitud_Transfusional_FE.rpt"].SetDataSource(listaRPT);
            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            imgFirma = Server.MapPath((string)Session["FIRMA_DIGITAL"]);
            Rpt.SetParameterValue("imgFirma", imgFirma);
            Rpt.SetDataSource(listaRPT2);

            if (listaRPT2.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);

            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

                        Rpt.SetParameterValue("imgFirma", imgFirma);

                        Rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

                    Rpt.SetParameterValue("imgFirma", imgFirma);



                }

            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            Rpt.SetParameterValue("imgFirma", imgFirma);





        }


        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewSolicitudTransfusional_FEEdit>
        getDatarptViewSolicitudTransfusional_FE(String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion,
            SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog, string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewSolicitudTransfusional_FE - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewSolicitudTransfusional_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewSolicitudTransfusional_FEEdit>();
            List<rptViewSolicitudTransfusional_FE> rptViewSolicitudTranfusional = new List<rptViewSolicitudTransfusional_FE>();
            SS_HC_SolucitudTransfusional_FE ObjSolicitudTransfucional = new SS_HC_SolucitudTransfusional_FE();
            ObjSolicitudTransfucional.UnidadReplicacion = unidadReplicacion;
            ObjSolicitudTransfucional.IdPaciente = idPaciente;
            ObjSolicitudTransfucional.EpisodioClinico = epiClinico;
            ObjSolicitudTransfucional.IdEpisodioAtencion = idEpiAtencion;
            ObjSolicitudTransfucional.Accion = "REPORTEA";

            //Servicio
            rptViewSolicitudTranfusional = ServiceReportes.rptViewSolicitudTranfusional_FE(ObjSolicitudTransfucional, 0, 0);

            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewSolicitudTransfusional_FEEdit objRPT;
            if (rptViewSolicitudTranfusional != null)
            {
                foreach (rptViewSolicitudTransfusional_FE objReport in rptViewSolicitudTranfusional) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewSolicitudTransfusional_FEEdit();
                    objRPT.UnidadReplicacion = objReport.UnidadReplicacion;
                    objRPT.IdEpisodioAtencion = objReport.IdEpisodioAtencion;
                    objRPT.IdPaciente = objReport.IdPaciente;
                    objRPT.EpisodioClinico = objReport.EpisodioClinico;
                    objRPT.FechaSolicitud = Convert.ToDateTime(objReport.FechaSolicitud);
                    objRPT.HoraRecepcion = objReport.HoraRecepcion;
                    objRPT.Nombres_Paciente = objReport.Nombres_Paciente;
                    objRPT.Sexo_Paciente = objReport.Sexo_Paciente;
                    objRPT.Edad_paciente = Convert.ToInt32(objReport.Edad_paciente);
                    objRPT.CodigoHC = objReport.CodigoHC;
                    objRPT.Nro_cama = objReport.Nro_cama;
                    objRPT.UnidadServicioCodigo = objReport.UnidadServicioCodigo;
                    objRPT.UnidadServicioDesc = objReport.UnidadServicioDesc;
                    objRPT.TransfusionesPrevias = objReport.TransfusionesPrevias;
                    objRPT.ReaccionesTransfusionalesAnteriores = objReport.ReaccionesTransfusionalesAnteriores;
                    objRPT.EmbarazosPrevios = objReport.EmbarazosPrevios;
                    objRPT.EmbarazosPreviosEspecificar = objReport.EmbarazosPreviosEspecificar;
                    objRPT.Abortos = objReport.Abortos;
                    objRPT.AbortosEspecificar = objReport.AbortosEspecificar;
                    objRPT.IncompatMaternoFetal = objReport.IncompatMaternoFetal;
                    objRPT.IncompatMaternoFetalEspecificar = objReport.IncompatMaternoFetalEspecificar;
                    objRPT.DiagnosticoEnfermedad = objReport.DiagnosticoEnfermedad;
                    objRPT.Hb = Convert.ToDecimal(objReport.Hb);
                    objRPT.Hcto = Convert.ToDecimal(objReport.Hcto);
                    objRPT.Plaquetas = Convert.ToDecimal(objReport.Plaquetas);
                    objRPT.SangreTotalFlag = objReport.SangreTotalFlag;
                    objRPT.SangreTotalCantidad = Convert.ToDecimal(objReport.SangreTotalCantidad);
                    objRPT.FraccionPediatricasCantidad = Convert.ToDecimal(objReport.FraccionPediatricasCantidad);
                    objRPT.FraccionPediatricasFlag = objReport.FraccionPediatricasFlag;
                    objRPT.PaqueteGlobularFlag = objReport.PaqueteGlobularFlag;
                    objRPT.PaqueteGlobularCantidad = Convert.ToDecimal(objReport.PaqueteGlobularCantidad);
                    objRPT.RequerimientoEspecialFlag = objReport.RequerimientoEspecialFlag;
                    objRPT.PlasmaFrescoCongeladoFlag = objReport.PlasmaFrescoCongeladoFlag;
                    objRPT.PlasmaFrescoCongeladoCantidad = Convert.ToDecimal(objReport.PlasmaFrescoCongeladoCantidad);
                    objRPT.DesleucocitadoCantidad = Convert.ToDecimal(objReport.DesleucocitadoCantidad);
                    objRPT.DesleucocitadoFlag = objReport.RequerimientoEspecialFlag;
                    objRPT.CrioprecipitadoFlag = objReport.CrioprecipitadoFlag;
                    objRPT.CrioprecipitadoCantidad = Convert.ToDecimal(objReport.CrioprecipitadoCantidad);
                    objRPT.IrradiadoCantidad = Convert.ToDecimal(objReport.IrradiadoCantidad);
                    objRPT.IrradiadoFlag = objReport.IrradiadoFlag;
                    objRPT.PlaquetasFlag = objReport.PlaquetasFlag;
                    objRPT.PlaquetasCantidad = Convert.ToDecimal(objReport.PlaquetasCantidad);
                    objRPT.OtrosCantidad = Convert.ToDecimal(objReport.OtrosCantidad);
                    objRPT.OtrosEspecificar = objReport.OtrosEspecificar;
                    objRPT.OtrosFlag = objReport.OtrosFlag;
                    objRPT.Requisito = objReport.Requisito;
                    objRPT.PersonaBanco = objReport.PersonaBanco;
                    objRPT.FechaRecepcion = objReport.FechaRecepcion;
                    objRPT.HoraRecepcion = objReport.HoraRecepcion;
                    objRPT.PersMedicoNombreCompleto = objReport.PersMedicoNombreCompleto;
                    objRPT.Expr104 = objReport.Expr104;
                    listaRPT.Add(objRPT);
                }

                ///////////////////////////////                     
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewSolicitudTranfusional.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }
            return listaRPT;
        }

        private void GenerarReporteDieta_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteDieta_FE - Entrar");
            string tura = Server.MapPath("rptReports/rptViewDieta_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewDieta_FE.rpt"));

            DataTable listaRPT = new DataTable();
            DataTable listaRPT_Pac_Med = new DataTable();
            listaRPT = rptVistas_FE("rptViewDieta_FE",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                ENTITY_GLOBAL.Instance.USUARIO);

            Rpt.SetDataSource(listaRPT);


            List<SoluccionSalud.RepositoryReport.Entidades.rptViewDieta_FEEdit> listaRPT1 = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewDieta_FEEdit>();
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewDieta_FEEdit> listaRPT2 = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewDieta_FEEdit>();


            listaRPT1 = getDatarptViewDieta_FE("REPORTEA",
                                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                                (int)ENTITY_GLOBAL.Instance.PacienteID,
                                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                                ENTITY_GLOBAL.Instance.USUARIO, 2);
            Rpt.Subreports["rptViewDieta_FEDetalle1.rpt"].SetDataSource(listaRPT1);
            //  Rpt.SetDataSource(listaRPT1);

            listaRPT2 = getDatarptViewDieta_FE("REPORTEA",
                    ENTITY_GLOBAL.Instance.UnidadReplicacion,
                    (int)ENTITY_GLOBAL.Instance.PacienteID,
                    (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                    (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                    ENTITY_GLOBAL.Instance.USUARIO, 3);
            //  Rpt.SetDataSource(listaRPT2);
            Rpt.Subreports["rptViewDieta_FEDetalle2.rpt"].SetDataSource(listaRPT2);
            Rpt.SetDataSource(listaRPT);
            //Datos Generales
            setDatosGenerales();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            imgFirma = Server.MapPath((string)Session["FIRMA_DIGITAL"]);
            Rpt.SetParameterValue("imgFirma", imgFirma);


            if (listaRPT1.Count == 0 && listaRPT2.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "AnteFamiliar");
                    }
                    catch (Exception ex) { throw; }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }

        private void GenerarReporteDieta_FEDetalle(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteDieta_FEDetalle - Entrar");
            string tura = Server.MapPath("rptReports/rptViewDieta_FEDetalle2.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewDieta_FEDetalle2.rpt"));
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewDieta_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewDieta_FEEdit>();
            listaRPT = getDatarptViewDieta_FE("REPORTEA",
                    ENTITY_GLOBAL.Instance.UnidadReplicacion,
                    (int)ENTITY_GLOBAL.Instance.PacienteID,
                    (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                    (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                    ENTITY_GLOBAL.Instance.USUARIO, 3);

            //DataTable listaRPT = new DataTable();
            //listaRPT = rptVistas_FE("rptViewDieta_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Count == 0)
            { ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true); }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "AnteFamiliar");
                    }
                    catch (Exception ex)
                    {
                        throw;
                    }
                }
            }
            GenerarReporteDieta_FE(tipoVista);
        }

        private void GenerarReporteDieta_FEDetalle2(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteDieta_FEDetalle2 - Entrar");

            string tura = Server.MapPath("rptReports/rptViewDieta_FEDetalle1.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewDieta_FEDetalle1.rpt"));

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewDieta_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewDieta_FEEdit>();
            listaRPT = getDatarptViewDieta_FE("REPORTEA",
                    ENTITY_GLOBAL.Instance.UnidadReplicacion,
                    (int)ENTITY_GLOBAL.Instance.PacienteID,
                    (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                    (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                    ENTITY_GLOBAL.Instance.USUARIO, 2);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Count == 0)
            { ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true); }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "AnteFamiliar");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                }
            }
            GenerarReporteDieta_FE(tipoVista);
        }


        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewDieta_FEEdit>
  getDatarptViewDieta_FE(String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion,
      SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog, string codFormato, string codUsuario, int tipomedicamento)
        {
            Log.Information("VisorReportesHCE - getDatarptViewDieta_FE - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewDieta_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewDieta_FEEdit>();
            List<rptViewDieta_FE> rptViewDieta_FE = new List<rptViewDieta_FE>();
            SS_HC_Medicamento_FE ObjDieta = new SS_HC_Medicamento_FE();
            ObjDieta.IdPaciente = idPaciente;
            ObjDieta.UnidadReplicacion = unidadReplicacion;
            ObjDieta.EpisodioClinico = epiClinico;
            ObjDieta.IdEpisodioAtencion = idEpiAtencion;
            ObjDieta.Accion = "REPORTEA";

            // Servicio
            rptViewDieta_FE = ServiceReportes.rptViewDieta_FE(ObjDieta, 0, 0, tipomedicamento);

            objTabla1 = new System.Data.DataTable();
            SoluccionSalud.RepositoryReport.Entidades.rptViewDieta_FEEdit objRPT;
            if (rptViewDieta_FE != null)
            {
                foreach (rptViewDieta_FE objReport in rptViewDieta_FE) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewDieta_FEEdit();

                    objRPT.UnidadReplicacion = objReport.UnidadReplicacion;
                    objRPT.IdEpisodioAtencion = objReport.IdEpisodioAtencion;
                    objRPT.IdPaciente = objReport.IdPaciente;
                    objRPT.EpisodioClinico = objReport.EpisodioClinico;
                    objRPT.Presentacion = objReport.Presentacion;
                    objRPT.DescripcionLarga = objReport.DescripcionLarga;
                    objRPT.DescripcionLocal = objReport.DescripcionLocal;
                    objRPT.DireccionComun = objReport.DireccionComun;
                    objRPT.DocumentoFiscal = objReport.DocumentoFiscal;
                    objRPT.DietaMedicamento = objReport.DietaMedicamento;
                    objRPT.ViaDescDieta = objReport.ViaDescDieta;
                    objRPT.VolumenDia = objReport.VolumenDia;
                    objRPT.FrecuenciaToma = objReport.FrecuenciaToma;
                    objRPT.Hora = Convert.ToDateTime(objReport.Hora);
                    //    objRPT.HoraInicio = objReport.HoraInicio;
                    objRPT.Comentario = objReport.Comentario;
                    objRPT.PersMedicoNombreCompleto = objReport.PersMedicoNombreCompleto;
                    objRPT.EspecialidadDesc = objReport.EspecialidadDesc;
                    objRPT.CMP = objReport.CMP;
                    objRPT.RNE = objReport.RNE;
                    objRPT.Documento = objReport.Documento;
                    objRPT.ComentarioDieta = objReport.ComentarioDieta;

                    //detalle2

                    objRPT.DosisComplementoDieta = objReport.DosisComplementoDieta;
                    objRPT.MicroNutriente = objReport.MicroNutriente;
                    objRPT.DCI = objReport.DCI;
                    objRPT.ViaDesc = objReport.ViaDesc;
                    objRPT.ComentarioComplementoDieta = objReport.ComentarioComplementoDieta;

                    //detalle1 - Dieta
                    objRPT.PadreDescripcion = objReport.PadreDescripcion;
                    objRPT.HijoDescripcion = objReport.HijoDescripcion;

                    if (objReport.UnidadServicioCodigo != null && objReport.UnidadServicioCodigo != "")
                    {
                        System.IO.FileInfo fi = new System.IO.FileInfo(objReport.UnidadServicioCodigo.Trim());
                        if (fi.Exists)
                        {
                            var NombreServidor = fi.Name;
                            var rutaServidor = Server.MapPath("../resources/DocumentosAdjuntos/firmas/");
                            if (!Directory.Exists(rutaServidor))
                            {
                                DirectoryInfo di = Directory.CreateDirectory(rutaServidor);
                            }
                            var PathServidor = rutaServidor + NombreServidor;
                            System.IO.File.Copy(objReport.UnidadServicioCodigo, PathServidor, true);
                            //System.IO.FileInfo fiServidor = new System.IO.FileInfo(PathServidor);
                            var PathOri = "../resources/DocumentosAdjuntos/firmas/" + NombreServidor;
                            //objRPT.Accion = PathOri;
                            Session["FIRMA_DIGITAL"] = PathOri;
                        }
                    }
                    else
                    {
                        Session["FIRMA_DIGITAL"] = "";
                    }


                    listaRPT.Add(objRPT);
                }


                ///////////////////////////////                     
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewDieta_FE.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }
            return listaRPT;
        }




        /*************************************************************************************************/


        private void GenerarReporterptViewSolicitudProducto(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewSolicitudProducto - Entrar");

            //string tura = Server.MapPath("rptReports/rptViewSolicitudProducto.rpt");
            //Rpt.Load(Server.MapPath("rptReports/rptViewSolicitudProducto.rpt"));

            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewSolicitudProductoEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewSolicitudProductoEdit>();
            //listaRPT = getDatarptViewSolicitudProducto("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            //setDatosGenerales();
            //imgIzquierda = Server.MapPath("Imagen/Logo.png");
            //Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            //Rpt.SetDataSource(listaRPT);

            string tura = Server.MapPath("rptReports/rptViewSolicitudProducto.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewSolicitudProducto.rpt"));
            DataTable listaRPT = new DataTable();

            listaRPT = rptVistaPedidoProducto("rptViewSolicitudProducto", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            // setDatosGenerales();
            setDatosGeneralesDispensacion();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);


            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);

            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }

            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


        }


        /************* SOLICITUD DE DESPACHO  ************/


        private void GenerarReporterptViewSolicitudDespacho(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewSolicitudDespacho - Entrar");


            string tura = Server.MapPath("rptReports/rptViewSolicitudProductoDespacho.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewSolicitudProductoDespacho.rpt"));
            DataTable listaRPT = new DataTable();

            listaRPT = rptVistaPedidoProducto("rptViewSolicitudProductoDespacho", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);



            // setDatosGenerales();
            setDatosGeneralesDispensacion();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);

            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }



        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewSolicitudProductoEdit>
   getDatarptViewSolicitudProducto(String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
  , SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog,
  string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewSolicitudProducto - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewSolicitudProductoEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewSolicitudProductoEdit>();

            List<rptViewSolicitudProducto> rptViewSolicitudProducto = new List<rptViewSolicitudProducto>();
            SS_FA_SolicitudProducto ObjSolicitudProducto = new SS_FA_SolicitudProducto();
            ObjSolicitudProducto.UnidadReplicacion = unidadReplicacion;
            ObjSolicitudProducto.IdPaciente = idPaciente;
            ObjSolicitudProducto.EpisodioClinico = epiClinico;
            ObjSolicitudProducto.IdEpisodioAtencion = idEpiAtencion;
            ObjSolicitudProducto.Accion = "REPORTEA";
            rptViewSolicitudProducto = ServiceReportes.ReporteSolicitudProducto(ObjSolicitudProducto, 0, 0);
            //AAAA
            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewSolicitudProductoEdit objRPT;
            if (rptViewSolicitudProducto != null)
            {
                foreach (rptViewSolicitudProducto objReport in rptViewSolicitudProducto) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewSolicitudProductoEdit();

                    objRPT.UnidadReplicacion = objReport.UnidadReplicacion;
                    objRPT.IdEpisodioAtencion = objReport.IdEpisodioAtencion;
                    objRPT.IdPaciente = objReport.IdPaciente;
                    objRPT.EpisodioClinico = objReport.EpisodioClinico;
                    objRPT.IdSolicitudProducto = objReport.IdSolicitudProducto;
                    objRPT.NumeroDocumento = objReport.NumeroDocumento;
                    objRPT.Observacion = objReport.Observacion;
                    objRPT.Secuencia = objReport.Secuencia;
                    objRPT.Cantidad = Convert.ToDecimal(objReport.Cantidad);
                    objRPT.Linea = objReport.Linea;
                    objRPT.Familia = objReport.Familia;
                    objRPT.SubFamilia = objReport.SubFamilia;
                    objRPT.CodigoComponente = objReport.CodigoComponente;
                    objRPT.NombreCompleto = objReport.NombreCompleto;
                    objRPT.CodigoOA = objReport.CodigoOA;
                    objRPT.FechaCreacion = Convert.ToDateTime(objReport.FechaCreacion);
                    objRPT.PersMedicoNombreCompleto = objReport.PersMedicoNombreCompleto;
                    objRPT.TipoTrabajadorDesc = objReport.TipoTrabajadorDesc;
                    objRPT.Medicamento = objReport.Medicamento;


                    listaRPT.Add(objRPT);
                }
                ///////////////////////////////                     
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewSolicitudProducto.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }

            return listaRPT;

        }



        //***ANT.PER. FISIO
        private void GenerarReporterptViewAntecedentesPersonalesFisiologico(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewAntecedentesPersonalesFisiologico - Entrar");

            string tura = Server.MapPath("rptReports/rptViewAntecedentesPersonalesFisiologicos_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewAntecedentesPersonalesFisiologicos_FE.rpt"));

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesFisiologicos_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesFisiologicos_FEEdit>();
            listaRPT = getDatarptViewAntecedenteFisiologico_FE("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);


            //Datos Generales
            setDatosGenerales();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "SolicitudMedicamento");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            //Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


        }
        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesFisiologicos_FEEdit>
        getDatarptViewAntecedenteFisiologico_FE(String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
       , SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog,
       string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewAntecedenteFisiologico_FE - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesFisiologicos_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesFisiologicos_FEEdit>();

            List<rptViewAntecedentesPersonalesFisiologicos_FE> rptViewAnteFisiologico = new List<rptViewAntecedentesPersonalesFisiologicos_FE>();
            SS_HC_AntecedentesPersonalesFisiologicos_FE ObjAnteFisiologico = new SS_HC_AntecedentesPersonalesFisiologicos_FE();
            ObjAnteFisiologico.UnidadReplicacion = unidadReplicacion;
            ObjAnteFisiologico.IdPaciente = idPaciente;
            ObjAnteFisiologico.EpisodioClinico = epiClinico;
            ObjAnteFisiologico.IdEpisodioAtencion = idEpiAtencion;
            ObjAnteFisiologico.Accion = "REPORTEA";
            rptViewAnteFisiologico = ServiceReportes.rptViewAntecedentesFisiologicos_FE(ObjAnteFisiologico, 0, 0);
            //AAAA
            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesFisiologicos_FEEdit objRPT;
            if (rptViewAnteFisiologico != null)
            {
                foreach (rptViewAntecedentesPersonalesFisiologicos_FE objReport in rptViewAnteFisiologico) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesFisiologicos_FEEdit();

                    objRPT.UnidadReplicacion = objReport.UnidadReplicacion;
                    objRPT.IdEpisodioAtencion = objReport.IdEpisodioAtencion;
                    objRPT.IdPaciente = objReport.IdPaciente;
                    objRPT.EpisodioClinico = objReport.EpisodioClinico;
                    objRPT.IdSecuencia = objReport.IdSecuencia;
                    objRPT.GrupoSanguineo = objReport.GrupoSanguineo;
                    objRPT.FactorRH = objReport.FactorRH;
                    objRPT.AlimentacionA_flag = objReport.AlimentacionA_flag;
                    objRPT.Alcohol = objReport.Alcohol;
                    objRPT.Alcohol_EspecificarCantidad = objReport.Alcohol_EspecificarCantidad;
                    objRPT.Tabaco_flag = objReport.Tabaco_flag;
                    objRPT.Tabaco_NroCigarrillos = objReport.Tabaco_NroCigarrillos;
                    objRPT.TiempoConsumo = objReport.TiempoConsumo;
                    objRPT.Drogas_flag = objReport.Drogas_flag;
                    objRPT.Drogas_Especificar = objReport.Drogas_Especificar;
                    objRPT.Cafe_flag = objReport.Cafe_flag;
                    objRPT.Otros = objReport.Otros;
                    objRPT.ActividadFisica_flag = objReport.ActividadFisica_flag;
                    objRPT.ActividadFisica_subflag = objReport.ActividadFisica_subflag;
                    objRPT.ConsumoVerduras_flag = objReport.ConsumoVerduras_flag;
                    objRPT.ConsumoVerduras_subflag = objReport.ConsumoVerduras_subflag;
                    objRPT.ConsumoFrutas_flag = objReport.ConsumoFrutas_flag;
                    objRPT.ConsumoFrutas_subflag = objReport.ConsumoFrutas_subflag;
                    objRPT.InmunizacionesAdultoObservaciones = objReport.InmunizacionesAdultoObservaciones;
                    objRPT.Accion = objReport.Accion;
                    objRPT.Version = objReport.Version;
                    objRPT.Estado = objReport.Estado;
                    objRPT.UsuarioCreacion = objReport.UsuarioCreacion;
                    objRPT.FechaCreacion = Convert.ToDateTime(objReport.FechaCreacion);
                    objRPT.UsuarioModificacion = objReport.UsuarioModificacion;
                    objRPT.FechaModificacion = Convert.ToDateTime(objReport.FechaModificacion);

                    listaRPT.Add(objRPT);
                }
                ///////////////////////////////                     
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewAnteFisiologico.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }

            return listaRPT;

        }

        //***FIN ANT.PER. FISIO 


        private void GenerarReporteAntFisiologicoPediatrico_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteAntFisiologicoPediatrico_FE - Entrar");

            string tura = Server.MapPath("rptReports/rptViewAntFisiologicoPediatricoFE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewAntFisiologicoPediatricoFE.rpt"));

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntFisiologicoPediatricoFEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntFisiologicoPediatricoFEEdit>();
            listaRPT = getDatarptViewAntFisiologicoPediatrico_FE("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);


            //Datos Generales
            setDatosGenerales();


            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Count == 0)
            {

                DataTable listaRPT1 = new DataTable();

                listaRPT1 = rptVistas_FE("rptViewAntFisiologicoPediatricoFE",
                            ENTITY_GLOBAL.Instance.UnidadReplicacion,
                            (int)ENTITY_GLOBAL.Instance.PacienteID,
                            (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                            (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                            null, 0,
                            ENTITY_GLOBAL.Instance.CONCEPTO,
                            ENTITY_GLOBAL.Instance.USUARIO);
                Rpt.SetDataSource(listaRPT1);

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "FISIOLOGICO PEDIATRICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }

                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
            }

            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


        }



        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntFisiologicoPediatricoFEEdit>
  getDatarptViewAntFisiologicoPediatrico_FE(String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
 , SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog,
 string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewAntFisiologicoPediatrico_FE - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntFisiologicoPediatricoFEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntFisiologicoPediatricoFEEdit>();

            List<rptViewAntFisiologicoPediatricoFE> rptViewAntFisiologicoPediatricoFE = new List<rptViewAntFisiologicoPediatricoFE>();
            SS_HC_Ant_Fisiologico_Pediatrico_FE ObjSolicitudProducto = new SS_HC_Ant_Fisiologico_Pediatrico_FE();
            ObjSolicitudProducto.UnidadReplicacion = unidadReplicacion;
            ObjSolicitudProducto.IdPaciente = idPaciente;
            ObjSolicitudProducto.EpisodioClinico = epiClinico;
            ObjSolicitudProducto.IdEpisodioAtencion = idEpiAtencion;
            ObjSolicitudProducto.Accion = "REPORTEA";

            rptViewAntFisiologicoPediatricoFE = ServiceReportes.rptViewAntFisiologicoPediatricoFE(ObjSolicitudProducto, 0, 0);
            //AAAA
            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewAntFisiologicoPediatricoFEEdit objRPT;
            if (rptViewAntFisiologicoPediatricoFE != null)
            {
                foreach (rptViewAntFisiologicoPediatricoFE objReport in rptViewAntFisiologicoPediatricoFE) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewAntFisiologicoPediatricoFEEdit();

                    objRPT.UnidadReplicacion = objReport.UnidadReplicacion;
                    objRPT.IdEpisodioAtencion = objReport.IdEpisodioAtencion;
                    objRPT.IdPaciente = objReport.IdPaciente;
                    objRPT.EpisodioClinico = objReport.EpisodioClinico;
                    objRPT.IdAntFiPediatrico = objReport.EpisodioClinico;
                    objRPT.EdadMaterna = Convert.ToInt32(objReport.EdadMaterna);
                    objRPT.Paridad_1 = Convert.ToInt32(objReport.Paridad_1);
                    objRPT.Paridad_2 = Convert.ToInt32(objReport.Paridad_2);
                    objRPT.Paridad_3 = Convert.ToInt32(objReport.Paridad_3);
                    objRPT.Paridad_4 = Convert.ToInt32(objReport.Paridad_4);
                    objRPT.Gravidez = Convert.ToInt32(objReport.Gravidez);
                    objRPT.ControlPrenatal = Convert.ToInt32(objReport.ControlPrenatal);
                    objRPT.Complicaciones = objReport.Complicaciones;
                    objRPT.TipoParto = Convert.ToInt32(objReport.TipoParto);
                    objRPT.MotivoCesarea = objReport.MotivoCesarea;
                    objRPT.LugarNacimiento = objReport.LugarNacimiento;
                    objRPT.Peso = Convert.ToDecimal(objReport.Peso);
                    objRPT.PesoNR = Convert.ToInt32(objReport.PesoNR);
                    objRPT.Talla = Convert.ToDecimal(objReport.Talla);
                    objRPT.TallaNR = Convert.ToInt32(objReport.TallaNR);
                    objRPT.PCNacer = Convert.ToDecimal(objReport.PCNacer);
                    objRPT.PCNacerNR = Convert.ToInt32(objReport.PCNacerNR);
                    objRPT.APGAR = Convert.ToInt32(objReport.APGAR);
                    objRPT.Reanimacion = Convert.ToInt32(objReport.Reanimacion);
                    objRPT.Lactancia = Convert.ToInt32(objReport.Lactancia);
                    objRPT.InicioAblactansia = Convert.ToDateTime(objReport.InicioAblactansia);
                    objRPT.AlimentosActuales = objReport.AlimentosActuales;
                    objRPT.Vigilancia = Convert.ToInt32(objReport.Vigilancia);
                    objRPT.Psicomotor = Convert.ToInt32(objReport.Psicomotor);
                    objRPT.DetallarPsicomotor = objReport.DetallarPsicomotor;
                    objRPT.DesApgar1 = objReport.DesApgar1;
                    objRPT.DesApgar2 = objReport.DesApgar2;
                    objRPT.DesApgar3 = objReport.DesApgar3;
                    objRPT.DesApgar4 = objReport.DesApgar4;

                    listaRPT.Add(objRPT);
                }
                ///////////////////////////////                     
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewAntFisiologicoPediatricoFE.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }

            return listaRPT;

        }


        #region CCEPF006_REPORTE

        private void GenerarReporteAntecedentesGeneralesPatologicos_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteAntecedentesGeneralesPatologicos_FE - Entrar");

            string tura = Server.MapPath("rptReports/rptViewAntecedentesPersonalesPatologicosGenerales_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewAntecedentesPersonalesPatologicosGenerales_FE.rpt"));
            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesPatologicosGenerales_FEEdit> listaRPT1 = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesPatologicosGenerales_FEEdit>();
            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesPatologicosGenerales_FEEdit> listaRPT2 = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesPatologicosGenerales_FEEdit>();
            DataTable listaRPT1 = new DataTable();
            DataTable listaRPT2 = new DataTable();

            listaRPT1 = rptVistas_FE("rptViewAntecedentesPersonalesPatologicosGenerales_FE",
                    ENTITY_GLOBAL.Instance.UnidadReplicacion,
                    (int)ENTITY_GLOBAL.Instance.PacienteID,
                    (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                    (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                    ENTITY_GLOBAL.Instance.USUARIO);
            Rpt.Subreports["rptViewAntecedentesPatologicosGeneralesdetalle.rpt"].SetDataSource(listaRPT1);
            Rpt.SetDataSource(listaRPT1);

            //Datos Generales
            setDatosGenerales();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            if (listaRPT1.Rows.Count == 0 && listaRPT2.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "AnteFamiliar");
                    }
                    catch (Exception ex) { throw; }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }


        //


        //detalle
        private void GenerarReportePatologicosGeneralDetalle(string tipoVista)
        {
            string tura = Server.MapPath("rptReports/rptViewAntecedentesPatologicosGeneralesdetalle.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewAntecedentesPatologicosGeneralesdetalle.rpt"));

            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesPatologicosGenerales_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesPatologicosGenerales_FEEdit>();
            DataTable listaRPT = new DataTable();

            listaRPT = rptVistas_FE("rptViewAntecedentesPersonalesPatologicosGenerales_FE",
                    ENTITY_GLOBAL.Instance.UnidadReplicacion,
                    (int)ENTITY_GLOBAL.Instance.PacienteID,
                    (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                    (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                    ENTITY_GLOBAL.Instance.USUARIO);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            { ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true); }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "AnteFamiliar");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                }
            }
            GenerarReporteDieta_FE(tipoVista);

        }

        #endregion


        #region CCEPF005_REPORTE


        private void GenerarReporterptViewAntecedentePersGinecObstetrico(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewAntecedentePersGinecObstetrico - Entrar");

            string tura = Server.MapPath("rptReports/rptViewAntecedentesPersGinecObstetrico_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewAntecedentesPersGinecObstetrico_FE.rpt"));
            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesPatologicosGenerales_FEEdit> listaRPT1 = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesPatologicosGenerales_FEEdit>();
            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesPatologicosGenerales_FEEdit> listaRPT2 = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesPatologicosGenerales_FEEdit>();
            DataTable listaRPT1 = new DataTable();
            DataTable listaRPT2 = new DataTable();

            listaRPT1 = rptVistas_FE("rptViewAntecedentesPersGinecObstetrico_FE",
                    ENTITY_GLOBAL.Instance.UnidadReplicacion,
                    (int)ENTITY_GLOBAL.Instance.PacienteID,
                    (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                    (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                    ENTITY_GLOBAL.Instance.USUARIO);
            Rpt.Subreports["rptViewAntecedentesPersGinecObstetricodetalle.rpt"].SetDataSource(listaRPT1);
            Rpt.SetDataSource(listaRPT1);

            //Datos Generales
            setDatosGenerales();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            if (listaRPT1.Rows.Count == 0 && listaRPT2.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "AnteFamiliar");
                    }
                    catch (Exception ex) { throw; }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }



        private void GenerarReporteptViewAntecedentePersGinecObstetricoDetalle(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteptViewAntecedentePersGinecObstetricoDetalle - Entrar");


            string tura = Server.MapPath("rptReports/rptViewAntecedentesPersGinecObstetricodetalle.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewAntecedentesPersGinecObstetricodetalle.rpt"));

            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesPatologicosGenerales_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesPatologicosGenerales_FEEdit>();
            DataTable listaRPT = new DataTable();

            listaRPT = rptVistas_FE("rptViewAntecedentesPersGinecObstetrico_FE",
                    ENTITY_GLOBAL.Instance.UnidadReplicacion,
                    (int)ENTITY_GLOBAL.Instance.PacienteID,
                    (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                    (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                    ENTITY_GLOBAL.Instance.USUARIO);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            { ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true); }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "AnteFamiliar");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                }
            }
            //  GenerarReporteDieta_FE(tipoVista);

        }


        #endregion



        #region CCEPF305_REPORTE

        private void GenerarReporterptViewEpidemiologiaCovid_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewEpidemiologiaCovid_FE - Entrar");
            Rpt.Load(Server.MapPath("rptReports/EpidemiologiaCovid019.rpt"));
            DataTable listaRPT = new DataTable();
            DataTable listaRPT2 = new DataTable();
            DataTable listaRPT3 = new DataTable();
            listaRPT = rptVistas_FE("rptViewEpidemiologia_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
               , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);



            listaRPT2 = rptVistas_FE("rptViewEpidemiologiaDetalleCasos_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);



            listaRPT3 = rptVistas_FE("rptViewEpidemiologiaDetalleLugar_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            Rpt.Subreports["rptViewEpidemiologiaDetalleCasos_FE.rpt"].SetDataSource(listaRPT2);
            Rpt.Subreports["rptViewEpidemiologiaDetalleLugar.rpt"].SetDataSource(listaRPT3);

            Rpt.SetDataSource(listaRPT);
            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);



            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "SolicitudMedicamento");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }



        }




        #endregion

        public static DataTable rptVistasTriaje_Alergias_FE(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, string var, int va, string CONCEPTO, string Usuario)
        {
            Log.Information("VisorReportesHCE - rptVistasTriaje_Alergias_FE - Entrar");

            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                conx.Open();
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioTriaje= " + EpisodioClinico + " and  Accion= '" + var + "' ORDER BY Accion ASC";
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "Patologicos");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }


        public static DataTable rptVistasMasivas_FE(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion, string var, int va, string CONCEPTO, string Usuario)
        {
            Log.Information("VisorReportesHCE - rptVistas_FE - Entrar");


            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                conx.Open();
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " ORDER BY Accion ASC";
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "Patologicos");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }

        public static DataTable rptVistas_FE(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion, string var, int va, string CONCEPTO, string Usuario)
        {
            Log.Information("VisorReportesHCE - rptVistas_FE - Entrar");


            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                conx.Open();
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and IdEpisodioAtencion=" + EpisodioAtencion + " ORDER BY Accion ASC";
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "Patologicos");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }


        public static DataTable rptVistaPedidoProducto(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion, string var, int va, string CONCEPTO, string Usuario)
        {
            Log.Information("VisorReportesHCE - rptVistaPedidoProducto - Entrar");


            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                conx.Open();
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and IdEpisodioAtencion=" + EpisodioAtencion;
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "Patologicos");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }


        public static DataTable rptVistasTriaje_FE(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, string var, int va, string CONCEPTO, string Usuario)
        {
            Log.Information("VisorReportesHCE - rptVistasTriaje_FE - Entrar");

            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                conx.Open();
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioTriaje= " + EpisodioClinico + " ORDER BY Accion ASC";
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "Patologicos");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }

        public static DataTable rptVistas_FENA(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion, string var, int va, string CONCEPTO, string Usuario)
        {
            Log.Information("VisorReportesHCE - rptVistas_FENA - Entrar");

            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                conx.Open();
                string subsql = @"SELECT max(IdEpisodioAtencion) FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " " + " and  TipoTrabajador='08' ";
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and IdEpisodioAtencion= (" + subsql + ")  ";
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "Patologicos");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }

        public static DataTable rptVigilanciaDrenaje_FE(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion, string var, int va, string CONCEPTO, string Usuario)
        {
            Log.Information("VisorReportesHCE - rptVigilanciaDrenaje_FE - Entrar");


            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                conx.Open();
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and IdEpisodioAtencion=" + EpisodioAtencion + " ORDER BY Accion ASC";
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "Drenajes");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }

        public static DataTable rptInformeAlta_MED_FE(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion, string var, int va, string CONCEPTO, string Usuario)
        {
            Log.Information("VisorReportesHCE - rptInformeAlta_MED_FE - Entrar");

            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                conx.Open();
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and IdEpisodioAtencion=" + EpisodioAtencion + " ORDER BY Accion ASC";
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "Drenajes");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }


        public static DataTable rptAgrupador_TRIAJE_FE(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion, string var, int va, string CONCEPTO, string Usuario)
        {
            Log.Information("VisorReportesHCE - rptAgrupador_TRIAJE_FE - Entrar");


            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                var idvalorepisodio = "";

                if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "TRIAJE")
                {
                    idvalorepisodio = "IdEpisodioTriaje";

                }
                else
                {
                    idvalorepisodio = "EpisodioAtencion";
                }

                conx.Open();
                /* string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and IdEpisodioAtencion=" + EpisodioAtencion;*/
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and " + idvalorepisodio + "= " + EpisodioAtencion; //ADD 05.06.2017 ORLANDO
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "Agrupador");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }






        public static DataTable rptAgrupador_FE(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion, string var, int va, string CONCEPTO, string Usuario)
        {
            Log.Information("VisorReportesHCE - rptAgrupador_FE - Entrar");

            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                var idvalorepisodio = "";
                if (ENTITY_GLOBAL.Instance.INDICADOR_EMER == "MED_EMERGENCIA" || ENTITY_GLOBAL.Instance.INDICADOR_EMER == "MED_HOSPI")
                {
                    idvalorepisodio = "IdEpisodioAtencion";
                }
                else
                {
                    idvalorepisodio = "EpisodioAtencion";
                }
                conx.Open();
                /* string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and IdEpisodioAtencion=" + EpisodioAtencion;*/
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and " + idvalorepisodio + "= " + EpisodioAtencion; //ADD 05.06.2017 ORLANDO
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "Agrupador");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }


        public static DataTable rptAgrupadorDispensacion_FE(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion, string var, int va, string CONCEPTO, string Usuario)
        {
            Log.Information("VisorReportesHCE - rptAgrupadorDispensacion_FE - Entrar");
            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                var idvalorepisodio = "";
                //if (ENTITY_GLOBAL.Instance.INDICADOR_EMER == "MED_EMERGENCIA" || ENTITY_GLOBAL.Instance.INDICADOR_EMER == "MED_HOSPI")
                //{
                //    idvalorepisodio = "IdEpisodioAtencion";
                //}
                //else
                //{
                idvalorepisodio = "IdEpisodioAtencion";
                // }

                conx.Open();
                /* string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and IdEpisodioAtencion=" + EpisodioAtencion;*/
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and " + idvalorepisodio + "= " + EpisodioAtencion; //ADD 05.06.2017 ORLANDO
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "Agrupador");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }


        public static DataTable rptDatosPacienteMedico_FE(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion, string var, int va, string CONCEPTO, string Usuario)
        {
            Log.Information("VisorReportesHCE - rptDatosPacienteMedico_FE - Entrar");
            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                conx.Open();
                /* string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and IdEpisodioAtencion=" + EpisodioAtencion;*/
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and EpisodioAtencion=" + EpisodioAtencion;//ADD 07.06.2017 OES Motivo
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "PacienteMedico");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];
            }
        }

        public static DataTable rptVistasGlasgow_FE(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion, string var, int va, string CONCEPTO, string Usuario, string TipoEscala)
        {
            Log.Information("VisorReportesHCE - rptVistasGlasgow_FE - Entrar");
            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                conx.Open();
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and IdEpisodioAtencion=" + EpisodioAtencion + " and TipoEscala='" + TipoEscala + "' ORDER BY Accion ASC";
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "Glasgow");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }
        public static DataTable rptVistasNorton_FE(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion, string var, int va, string CONCEPTO, string Usuario)
        {
            Log.Information("VisorReportesHCE - rptVistasNorton_FE - Entrar");

            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                conx.Open();
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and IdEpisodioAtencion=" + EpisodioAtencion;
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "Patologico");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }


        public static DataTable rptVistasExamenesOrdenInter_FE(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion, string var, int va, string CONCEPTO, string Usuario, int TipoExamen)
        {
            Log.Information("VisorReportesHCE - rptVistasExamenesOrdenInter_FE - Entrar");


            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                conx.Open();
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and IdEpisodioAtencion=" + EpisodioAtencion + " and TipoExamen='" + TipoExamen + "' ORDER BY Accion ASC";
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "Balance");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }



        public static DataTable rptVistasTipoCirugia_FE(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion, string var, int va, string CONCEPTO, string Usuario, int tipoCirugia)
        {

            Log.Information("VisorReportesHCE - rptVistasTipoCirugia_FE - Entrar");

            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                conx.Open();
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and IdEpisodioAtencion=" + EpisodioAtencion + " and TipoCirugia='" + tipoCirugia + "' ORDER BY Accion ASC";
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "Balance");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }



        public static DataTable rptVistasExamenesAnestesiaDetalle_1_FE(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion, string var, int va, string CONCEPTO, string Usuario, int TipoExamen)
        {
            Log.Information("VisorReportesHCE - rptVistasExamenesAnestesiaDetalle_1_FE - Entrar");

            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                conx.Open();
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and IdEpisodioAtencion=" + EpisodioAtencion + " and TipoExamen='" + TipoExamen + "' ORDER BY Accion ASC";
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "Balance");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }


        public static DataTable rptVistasDiagnosticosAnestesiaDetalle_1_FE(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion, string var, int va, string CONCEPTO, string Usuario, int TipoDiag)
        {
            Log.Information("VisorReportesHCE - rptVistasDiagnosticosAnestesiaDetalle_1_FE - Entrar");


            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                conx.Open();
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and IdEpisodioAtencion=" + EpisodioAtencion + " and TipoDiag='" + TipoDiag + "' ORDER BY Accion ASC";
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "Balance");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }


        public static DataTable rptVistasBalanceHidroElectro_FE(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion, string var, int va, string CONCEPTO, string Usuario, int TipoBalance)
        {
            Log.Information("VisorReportesHCE - rptVistasBalanceHidroElectro_FE - Entrar");

            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                conx.Open();
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and IdEpisodioAtencion=" + EpisodioAtencion + " and TipoBalance='" + TipoBalance + "' ORDER BY Accion ASC";
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "Balance");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }


        public static DataTable rptVistasMedicamento_FE(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion, string var, int va, string CONCEPTO, string Usuario, int TipoMedicamento)
        {
            Log.Information("VisorReportesHCE - rptVistasMedicamento_FE - Entrar");

            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                conx.Open();
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and IdEpisodioAtencion=" + EpisodioAtencion + " and TipoMedicamento='" + TipoMedicamento + "' ORDER BY Accion ASC";
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "Medicamento");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }

        public static DataTable rptVistasDietas_FE(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion, string var, int va, string CONCEPTO, string Usuario, int TipoMedicamento)
        {
            Log.Information("VisorReportesHCE - rptVistasDietas_FE - Entrar");


            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                conx.Open();
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and IdEpisodioAtencion=" + EpisodioAtencion + " and TipoMedicamento='" + TipoMedicamento + "' ORDER BY Accion ASC";
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "Dietas");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }
        public static DataTable rptVistasBalanceHidroElectroDetalles_FE(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion, string var, int va, string CONCEPTO, string Usuario, int TipoBalance, int TipoGrid)
        {
            Log.Information("VisorReportesHCE - rptVistasBalanceHidroElectroDetalles_FE - Entrar");

            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                conx.Open();
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and IdEpisodioAtencion=" + EpisodioAtencion + " and TipoBalance=" + TipoBalance + "and Tipo=" + TipoGrid + " ORDER BY Accion ASC";
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "BalanceDetalles");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }

        //
        //private List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesPatologicosGenerales_FEEdit>
        // getDatarptViewPatologicosGenerales_FE(String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion,
        //    SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog, string codFormato, string codUsuario)
        //{
        //    List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesPatologicosGenerales_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesPatologicosGenerales_FEEdit>();
        //    List<rptViewAntecedentesPersonalesPatologicosGenerales_FE> rptViewDieta_FE = new List<rptViewAntecedentesPersonalesPatologicosGenerales_FE>();
        //    SS_HC_Anam_AP_PatologicosGenerales_FE ObjDieta = new SS_HC_Anam_AP_PatologicosGenerales_FE();
        //    ObjDieta.UnidadReplicacion = unidadReplicacion;
        //    ObjDieta.IdPaciente = idPaciente;
        //    ObjDieta.EpisodioClinico = epiClinico;
        //    ObjDieta.IdEpisodioAtencion = idEpiAtencion;
        //    ObjDieta.Accion = "REPORTEA";

        //    //Servicio
        //    //rptViewDieta_FE = ServiceReportes.rptViewPatologicosGenerales_FE(ObjDieta, 0, 0);

        //    rptViewDieta_FE = rptViewPatologicosBaseDatos_FE(ObjDieta, 0, 0);
        //    objTabla1 = new System.Data.DataTable();
        //    SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesPatologicosGenerales_FEEdit objRPT;
        //    if (rptViewDieta_FE != null)
        //    {
        //        foreach (rptViewAntecedentesPersonalesPatologicosGenerales_FE objReport in rptViewDieta_FE) // Loop through List with foreach.
        //        {
        //            objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesPatologicosGenerales_FEEdit();
        //            objRPT.UnidadReplicacion = objReport.UnidadReplicacion;
        //            objRPT.IdPaciente = objReport.IdPaciente;
        //            objRPT.EpisodioClinico = objReport.EpisodioClinico;
        //            objRPT.IdEpisodioAtencion = objReport.IdEpisodioAtencion;

        //            objRPT.EnfermedadesAnteriores_rb = objReport.EnfermedadesAnteriores_rb;
        //            objRPT.HipertensionSeleccion_ckb = objReport.HipertensionSeleccion_ckb;
        //            objRPT.HipertensionTiempoenfermedad_list = objReport.HipertensionTiempoenfermedad_list;
        //            objRPT.HipertensionMedicacion_rb = objReport.HipertensionMedicacion_rb;
        //            objRPT.HipertensionMedicacion_txt = objReport.HipertensionMedicacion_txt;
        //            objRPT.HipertensionTipoDiagn_list = objReport.HipertensionTipoDiagn_list;
        //            objRPT.DiabetesSeleccion_ckb = objReport.DiabetesSeleccion_ckb;
        //            objRPT.DiabetesTiempoenfermedad_list = objReport.DiabetesTiempoenfermedad_list;
        //            objRPT.DiabetesMedicacion_rb = objReport.DiabetesMedicacion_rb;
        //            objRPT.DiabetesMedicacion_txt = objReport.DiabetesMedicacion_txt;
        //            objRPT.DiabetesTipoDiagn_list = objReport.DiabetesTipoDiagn_list;
        //            objRPT.AsmaSeleccion_ckb = objReport.AsmaSeleccion_ckb;
        //            objRPT.AsmaTiempoenfermedad_list = objReport.AsmaTiempoenfermedad_list;
        //            objRPT.AsmaMedicacion_rb = objReport.AsmaMedicacion_rb;
        //            objRPT.AsmaMedicacion_txt = objReport.AsmaMedicacion_txt;
        //            objRPT.AsmaTipoDiagn_list = objReport.AsmaTipoDiagn_list;
        //            objRPT.SindromeCSeleccion_ckb = objReport.SindromeCSeleccion_ckb;
        //            objRPT.SindromeCTiempoenfermedad_list = objReport.SindromeCTiempoenfermedad_list;
        //            objRPT.SindromeCMedicacion_rb = objReport.SindromeCMedicacion_rb;
        //            objRPT.SindromeCMedicacion_txt = objReport.SindromeCMedicacion_txt;
        //            objRPT.SindromeCTipoDiagn_list = objReport.SindromeCTipoDiagn_list;
        //            objRPT.SindromeRSeleccion_ckb = objReport.SindromeRSeleccion_ckb;
        //            objRPT.SindromeRTiempoenfermedad_list = objReport.SindromeRTiempoenfermedad_list;
        //            objRPT.SindromeRMedicacion_rb = objReport.SindromeRMedicacion_rb;
        //            objRPT.SindromeRMedicacion_txt = objReport.SindromeRMedicacion_txt;
        //            objRPT.SindromeRTipoDiagn_list = objReport.SindromeRTipoDiagn_list;
        //            objRPT.GastritisSeleccion_ckb = objReport.GastritisSeleccion_ckb;
        //            objRPT.GastritisTiempoenfermedad_list = objReport.GastritisTiempoenfermedad_list;
        //            objRPT.GastritisMedicacion_rb = objReport.GastritisMedicacion_rb;
        //            objRPT.GastritisMedicacion_txt = objReport.GastritisMedicacion_txt;
        //            objRPT.GastritisTipoDiagn_list = objReport.GastritisTipoDiagn_list;
        //            objRPT.ArritmiaSeleccion_ckb = objReport.ArritmiaSeleccion_ckb;
        //            objRPT.ArritmiaTiempoenfermedad_list = objReport.ArritmiaTiempoenfermedad_list;
        //            objRPT.ArritmiaMedicacion_rb = objReport.ArritmiaMedicacion_rb;
        //            objRPT.ArritmiaMedicacion_txt = objReport.ArritmiaMedicacion_txt;
        //            objRPT.ArritmiaTipoDiagn_list = objReport.ArritmiaTipoDiagn_list;
        //            objRPT.HepatitisSeleccion_ckb = objReport.HepatitisSeleccion_ckb;
        //            objRPT.HepatitisTiempoenfermedad_list = objReport.HepatitisTiempoenfermedad_list;
        //            objRPT.HepatitisMedicacion_rb = objReport.HepatitisMedicacion_rb;
        //            objRPT.HepatitisMedicacion_txt = objReport.HepatitisMedicacion_txt;
        //            objRPT.HepatitisTipoDiagn_list = objReport.HepatitisTipoDiagn_list;
        //            objRPT.TuberculosisSeleccion_ckb = objReport.TuberculosisSeleccion_ckb;
        //            objRPT.TuberculosisTiempoenfermedad_list = objReport.TuberculosisTiempoenfermedad_list;
        //            objRPT.TuberculosisMedicacion_rb = objReport.TuberculosisMedicacion_rb;
        //            objRPT.TuberculosisMedicacion_txt = objReport.TuberculosisMedicacion_txt;
        //            objRPT.TuberculosisTipoDiagn_list = objReport.TuberculosisTipoDiagn_list;
        //            objRPT.HipertiroidismoSeleccion_ckb = objReport.HipertiroidismoSeleccion_ckb;
        //            objRPT.HipertiroidismoTiempoenfermedad_list = objReport.HipertiroidismoTiempoenfermedad_list;
        //            objRPT.HipertiroidismoMedicacion_rb = objReport.HipertiroidismoMedicacion_rb;
        //            objRPT.HipertiroidismoMedicacion_txt = objReport.HipertiroidismoMedicacion_txt;
        //            objRPT.HipertiroidismoTipoDiagn_list = objReport.HipertiroidismoTipoDiagn_list;
        //            objRPT.HipotiroidismoSeleccion_ckb = objReport.HipotiroidismoSeleccion_ckb;
        //            objRPT.HipotiroidismoTiempoenfermedad_list = objReport.HipotiroidismoTiempoenfermedad_list;
        //            objRPT.HipotiroidismoMedicacion_rb = objReport.HipotiroidismoMedicacion_rb;
        //            objRPT.HipotiroidismoMedicacion_txt = objReport.HipotiroidismoMedicacion_txt;
        //            objRPT.HipotiroidismoTipoDiagn_list = objReport.HipotiroidismoTipoDiagn_list;
        //            objRPT.InfeccionSeleccion_ckb = objReport.InfeccionSeleccion_ckb;
        //            objRPT.InfeccionTiempoenfermedad_list = objReport.InfeccionTiempoenfermedad_list;
        //            objRPT.InfeccionMedicacion_rb = objReport.InfeccionMedicacion_rb;
        //            objRPT.InfeccionMedicacion_txt = objReport.InfeccionMedicacion_txt;
        //            objRPT.InfeccionTipoDiagn_list = objReport.InfeccionTipoDiagn_list;
        //            objRPT.CardiopatiasSeleccion_ckb = objReport.CardiopatiasSeleccion_ckb;
        //            objRPT.CardiopatiasTiempoenfermedad_list = objReport.CardiopatiasTiempoenfermedad_list;
        //            objRPT.CardiopatiasMedicacion_rb = objReport.CardiopatiasMedicacion_rb;
        //            objRPT.CardiopatiasMedicacion_txt = objReport.CardiopatiasMedicacion_txt;
        //            objRPT.CardiopatiasTipoDiagn_list = objReport.CardiopatiasTipoDiagn_list;
        //            objRPT.EtransmisionSSeleccion_ckb = objReport.EtransmisionSSeleccion_ckb;
        //            objRPT.EtransmisionSTiempoenfermedad_list = objReport.EtransmisionSTiempoenfermedad_list;
        //            objRPT.EtransmisionSMedicacion_rb = objReport.EtransmisionSMedicacion_rb;
        //            objRPT.EtransmisionSMedicacion_txt = objReport.EtransmisionSMedicacion_txt;
        //            objRPT.EtransmisionSTipoDiagn_list = objReport.EtransmisionSTipoDiagn_list;
        //            objRPT.DShipoacusiaSeleccion_ckb = objReport.DShipoacusiaSeleccion_ckb;
        //            objRPT.DShipoacusiaTiempoenfermedad_list = objReport.DShipoacusiaTiempoenfermedad_list;
        //            objRPT.DShipoacusiaMedicacion_rb = objReport.DShipoacusiaMedicacion_rb;
        //            objRPT.DShipoacusiaMedicacion_txt = objReport.DShipoacusiaMedicacion_txt;
        //            objRPT.DShipoacusiaTipoDiagn_list = objReport.DShipoacusiaTipoDiagn_list;
        //            objRPT.DScegueraSeleccion_ckb = objReport.DScegueraSeleccion_ckb;
        //            objRPT.DScegueraTiempoenfermedad_list = objReport.DScegueraTiempoenfermedad_list;
        //            objRPT.DScegueraMedicacion_rb = objReport.DScegueraMedicacion_rb;
        //            objRPT.DScegueraMedicacion_txt = objReport.DScegueraMedicacion_txt;
        //            objRPT.DScegueraTipoDiagn_list = objReport.DScegueraTipoDiagn_list;
        //            objRPT.DSSordoMudoSeleccion_ckb = objReport.DSSordoMudoSeleccion_ckb;
        //            objRPT.DSSordoMudoTiempoenfermedad_list = objReport.DSSordoMudoTiempoenfermedad_list;
        //            objRPT.DSSordoMudoMedicacion_rb = objReport.DSSordoMudoMedicacion_rb;
        //            objRPT.DSSordoMudoMedicacion_txt = objReport.DSSordoMudoMedicacion_txt;
        //            objRPT.DSSordoMudoTipoDiagn_list = objReport.DSSordoMudoTipoDiagn_list;
        //            objRPT.DSMiopiaAltaSeleccion_ckb = objReport.DSMiopiaAltaSeleccion_ckb;
        //            objRPT.DSMiopiaAltaTiempoenfermedad_list = objReport.DSMiopiaAltaTiempoenfermedad_list;
        //            objRPT.DSMiopiaAltaMedicacion_rb = objReport.DSMiopiaAltaMedicacion_rb;
        //            objRPT.DSMiopiaAltaMedicacion_txt = objReport.DSMiopiaAltaMedicacion_txt;
        //            objRPT.DSMiopiaAltaTipoDiagn_list = objReport.DSMiopiaAltaTipoDiagn_list;
        //            objRPT.CancerSeleccion_ckb = objReport.CancerSeleccion_ckb;
        //            objRPT.CancerTiempoenfermedad_list = objReport.CancerTiempoenfermedad_list;
        //            objRPT.CancerMedicacion_rb = objReport.CancerMedicacion_rb;
        //            objRPT.CancerMedicacion_txt = objReport.CancerMedicacion_txt;
        //            objRPT.CancerTipoDiagn_list = objReport.CancerTipoDiagn_list;

        //            objRPT.Secuencia = Convert.ToInt32(objReport.Secuencia);
        //            objRPT.OtrasEnfermedades = objReport.OtrasEnfermedades;



        //            //objRPT.IdDiagnostico = Convert.ToInt32(objReport.IdDiagnostico);
        //            objRPT.DiagnosticoText = objReport.DiagnosticoText;
        //            objRPT.TiempoEnfermedad_list = objReport.TiempoEnfermedad_list;
        //            objRPT.DiagnosticoText = objReport.DiagnosticoText;
        //            //objRPT.TipoDiagn_list = objReport.TipoDiagn_list;

        //            objRPT.Descripcion = objReport.Descripcion;




        //            objRPT.Adicional1 = objReport.Adicional1;
        //            objRPT.Adicional2 = objReport.Adicional2;
        //            objRPT.Medicacion_txt = objReport.Medicacion_txt;


        //            listaRPT.Add(objRPT);
        //        }
        //    }
        //    return listaRPT;
        //}
        ////FIN


        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesPatologicosGenerales_FEEdit>
        getDatarptViewAntecedentesPersonalesPatologicosGenerales_FE(String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion,
           SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog, String codFormato, String codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewAntecedentesPersonalesPatologicosGenerales_FE - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesPatologicosGenerales_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesPatologicosGenerales_FEEdit>();
            List<rptViewAntecedentesPersonalesPatologicosGenerales_FE> rptViewAntePatologicoGeneral = new List<rptViewAntecedentesPersonalesPatologicosGenerales_FE>();

            SS_HC_Anam_AP_PatologicosGenerales_FE objPatologicos = new SS_HC_Anam_AP_PatologicosGenerales_FE();
            objPatologicos.UnidadReplicacion = unidadReplicacion;
            objPatologicos.IdPaciente = idPaciente;
            objPatologicos.EpisodioClinico = epiClinico;
            objPatologicos.IdEpisodioAtencion = idEpiAtencion;
            objPatologicos.IdPatologicosGenerales = 1;
            objPatologicos.Accion = "REPORTEA";

            //Servicio
            rptViewAntePatologicoGeneral = ServiceReportes.rptViewPatologicosGenerales_FE(objPatologicos, 0, 0);

            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesPatologicosGenerales_FEEdit objRPT;

            if (rptViewAntePatologicoGeneral != null)
            {
                foreach (rptViewAntecedentesPersonalesPatologicosGenerales_FE objReport in rptViewAntePatologicoGeneral)
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewAntecedentesPersonalesPatologicosGenerales_FEEdit();

                    objRPT.UnidadReplicacion = objReport.UnidadReplicacion;
                    objRPT.IdPaciente = objReport.IdPaciente;
                    objRPT.EpisodioClinico = objReport.EpisodioClinico;
                    objRPT.IdEpisodioAtencion = objReport.IdEpisodioAtencion;

                    objRPT.EnfermedadesAnteriores_rb = objReport.EnfermedadesAnteriores_rb;
                    objRPT.HipertensionSeleccion_ckb = objReport.HipertensionSeleccion_ckb;
                    objRPT.HipertensionTiempoenfermedad_list = objReport.HipertensionTiempoenfermedad_list;
                    objRPT.HipertensionMedicacion_rb = objReport.HipertensionMedicacion_rb;
                    objRPT.HipertensionMedicacion_txt = objReport.HipertensionMedicacion_txt;
                    objRPT.HipertensionTipoDiagn_list = objReport.HipertensionTipoDiagn_list;
                    objRPT.DiabetesSeleccion_ckb = objReport.DiabetesSeleccion_ckb;
                    objRPT.DiabetesTiempoenfermedad_list = objReport.DiabetesTiempoenfermedad_list;
                    objRPT.DiabetesMedicacion_rb = objReport.DiabetesMedicacion_rb;
                    objRPT.DiabetesMedicacion_txt = objReport.DiabetesMedicacion_txt;
                    objRPT.DiabetesTipoDiagn_list = objReport.DiabetesTipoDiagn_list;
                    objRPT.AsmaSeleccion_ckb = objReport.AsmaSeleccion_ckb;
                    objRPT.AsmaTiempoenfermedad_list = objReport.AsmaTiempoenfermedad_list;
                    objRPT.AsmaMedicacion_rb = objReport.AsmaMedicacion_rb;
                    objRPT.AsmaMedicacion_txt = objReport.AsmaMedicacion_txt;
                    objRPT.AsmaTipoDiagn_list = objReport.AsmaTipoDiagn_list;
                    objRPT.SindromeCSeleccion_ckb = objReport.SindromeCSeleccion_ckb;
                    objRPT.SindromeCTiempoenfermedad_list = objReport.SindromeCTiempoenfermedad_list;
                    objRPT.SindromeCMedicacion_rb = objReport.SindromeCMedicacion_rb;
                    objRPT.SindromeCMedicacion_txt = objReport.SindromeCMedicacion_txt;
                    objRPT.SindromeCTipoDiagn_list = objReport.SindromeCTipoDiagn_list;
                    objRPT.SindromeRSeleccion_ckb = objReport.SindromeRSeleccion_ckb;
                    objRPT.SindromeRTiempoenfermedad_list = objReport.SindromeRTiempoenfermedad_list;
                    objRPT.SindromeRMedicacion_rb = objReport.SindromeRMedicacion_rb;
                    objRPT.SindromeRMedicacion_txt = objReport.SindromeRMedicacion_txt;
                    objRPT.SindromeRTipoDiagn_list = objReport.SindromeRTipoDiagn_list;
                    objRPT.GastritisSeleccion_ckb = objReport.GastritisSeleccion_ckb;
                    objRPT.GastritisTiempoenfermedad_list = objReport.GastritisTiempoenfermedad_list;
                    objRPT.GastritisMedicacion_rb = objReport.GastritisMedicacion_rb;
                    objRPT.GastritisMedicacion_txt = objReport.GastritisMedicacion_txt;
                    objRPT.GastritisTipoDiagn_list = objReport.GastritisTipoDiagn_list;
                    objRPT.ArritmiaSeleccion_ckb = objReport.ArritmiaSeleccion_ckb;
                    objRPT.ArritmiaTiempoenfermedad_list = objReport.ArritmiaTiempoenfermedad_list;
                    objRPT.ArritmiaMedicacion_rb = objReport.ArritmiaMedicacion_rb;
                    objRPT.ArritmiaMedicacion_txt = objReport.ArritmiaMedicacion_txt;
                    objRPT.ArritmiaTipoDiagn_list = objReport.ArritmiaTipoDiagn_list;
                    objRPT.HepatitisSeleccion_ckb = objReport.HepatitisSeleccion_ckb;
                    objRPT.HepatitisTiempoenfermedad_list = objReport.HepatitisTiempoenfermedad_list;
                    objRPT.HepatitisMedicacion_rb = objReport.HepatitisMedicacion_rb;
                    objRPT.HepatitisMedicacion_txt = objReport.HepatitisMedicacion_txt;
                    objRPT.HepatitisTipoDiagn_list = objReport.HepatitisTipoDiagn_list;
                    objRPT.TuberculosisSeleccion_ckb = objReport.TuberculosisSeleccion_ckb;
                    objRPT.TuberculosisTiempoenfermedad_list = objReport.TuberculosisTiempoenfermedad_list;
                    objRPT.TuberculosisMedicacion_rb = objReport.TuberculosisMedicacion_rb;
                    objRPT.TuberculosisMedicacion_txt = objReport.TuberculosisMedicacion_txt;
                    objRPT.TuberculosisTipoDiagn_list = objReport.TuberculosisTipoDiagn_list;
                    objRPT.HipertiroidismoSeleccion_ckb = objReport.HipertiroidismoSeleccion_ckb;
                    objRPT.HipertiroidismoTiempoenfermedad_list = objReport.HipertiroidismoTiempoenfermedad_list;
                    objRPT.HipertiroidismoMedicacion_rb = objReport.HipertiroidismoMedicacion_rb;
                    objRPT.HipertiroidismoMedicacion_txt = objReport.HipertiroidismoMedicacion_txt;
                    objRPT.HipertiroidismoTipoDiagn_list = objReport.HipertiroidismoTipoDiagn_list;
                    objRPT.HipotiroidismoSeleccion_ckb = objReport.HipotiroidismoSeleccion_ckb;
                    objRPT.HipotiroidismoTiempoenfermedad_list = objReport.HipotiroidismoTiempoenfermedad_list;
                    objRPT.HipotiroidismoMedicacion_rb = objReport.HipotiroidismoMedicacion_rb;
                    objRPT.HipotiroidismoMedicacion_txt = objReport.HipotiroidismoMedicacion_txt;
                    objRPT.HipotiroidismoTipoDiagn_list = objReport.HipotiroidismoTipoDiagn_list;
                    objRPT.InfeccionSeleccion_ckb = objReport.InfeccionSeleccion_ckb;
                    objRPT.InfeccionTiempoenfermedad_list = objReport.InfeccionTiempoenfermedad_list;
                    objRPT.InfeccionMedicacion_rb = objReport.InfeccionMedicacion_rb;
                    objRPT.InfeccionMedicacion_txt = objReport.InfeccionMedicacion_txt;
                    objRPT.InfeccionTipoDiagn_list = objReport.InfeccionTipoDiagn_list;
                    objRPT.CardiopatiasSeleccion_ckb = objReport.CardiopatiasSeleccion_ckb;
                    objRPT.CardiopatiasTiempoenfermedad_list = objReport.CardiopatiasTiempoenfermedad_list;
                    objRPT.CardiopatiasMedicacion_rb = objReport.CardiopatiasMedicacion_rb;
                    objRPT.CardiopatiasMedicacion_txt = objReport.CardiopatiasMedicacion_txt;
                    objRPT.CardiopatiasTipoDiagn_list = objReport.CardiopatiasTipoDiagn_list;
                    objRPT.EtransmisionSSeleccion_ckb = objReport.EtransmisionSSeleccion_ckb;
                    objRPT.EtransmisionSTiempoenfermedad_list = objReport.EtransmisionSTiempoenfermedad_list;
                    objRPT.EtransmisionSMedicacion_rb = objReport.EtransmisionSMedicacion_rb;
                    objRPT.EtransmisionSMedicacion_txt = objReport.EtransmisionSMedicacion_txt;
                    objRPT.EtransmisionSTipoDiagn_list = objReport.EtransmisionSTipoDiagn_list;
                    objRPT.DShipoacusiaSeleccion_ckb = objReport.DShipoacusiaSeleccion_ckb;
                    objRPT.DShipoacusiaTiempoenfermedad_list = objReport.DShipoacusiaTiempoenfermedad_list;
                    objRPT.DShipoacusiaMedicacion_rb = objReport.DShipoacusiaMedicacion_rb;
                    objRPT.DShipoacusiaMedicacion_txt = objReport.DShipoacusiaMedicacion_txt;
                    objRPT.DShipoacusiaTipoDiagn_list = objReport.DShipoacusiaTipoDiagn_list;
                    objRPT.DScegueraSeleccion_ckb = objReport.DScegueraSeleccion_ckb;
                    objRPT.DScegueraTiempoenfermedad_list = objReport.DScegueraTiempoenfermedad_list;
                    objRPT.DScegueraMedicacion_rb = objReport.DScegueraMedicacion_rb;
                    objRPT.DScegueraMedicacion_txt = objReport.DScegueraMedicacion_txt;
                    objRPT.DScegueraTipoDiagn_list = objReport.DScegueraTipoDiagn_list;
                    objRPT.DSSordoMudoSeleccion_ckb = objReport.DSSordoMudoSeleccion_ckb;
                    objRPT.DSSordoMudoTiempoenfermedad_list = objReport.DSSordoMudoTiempoenfermedad_list;
                    objRPT.DSSordoMudoMedicacion_rb = objReport.DSSordoMudoMedicacion_rb;
                    objRPT.DSSordoMudoMedicacion_txt = objReport.DSSordoMudoMedicacion_txt;
                    objRPT.DSSordoMudoTipoDiagn_list = objReport.DSSordoMudoTipoDiagn_list;
                    objRPT.DSMiopiaAltaSeleccion_ckb = objReport.DSMiopiaAltaSeleccion_ckb;
                    objRPT.DSMiopiaAltaTiempoenfermedad_list = objReport.DSMiopiaAltaTiempoenfermedad_list;
                    objRPT.DSMiopiaAltaMedicacion_rb = objReport.DSMiopiaAltaMedicacion_rb;
                    objRPT.DSMiopiaAltaMedicacion_txt = objReport.DSMiopiaAltaMedicacion_txt;
                    objRPT.DSMiopiaAltaTipoDiagn_list = objReport.DSMiopiaAltaTipoDiagn_list;
                    objRPT.CancerSeleccion_ckb = objReport.CancerSeleccion_ckb;
                    objRPT.CancerTiempoenfermedad_list = objReport.CancerTiempoenfermedad_list;
                    objRPT.CancerMedicacion_rb = objReport.CancerMedicacion_rb;
                    objRPT.CancerMedicacion_txt = objReport.CancerMedicacion_txt;
                    objRPT.CancerTipoDiagn_list = objReport.CancerTipoDiagn_list;

                    objRPT.Secuencia = Convert.ToInt32(objReport.Secuencia);
                    objRPT.OtrasEnfermedades = objReport.OtrasEnfermedades;



                    //objRPT.IdDiagnostico = Convert.ToInt32(objReport.IdDiagnostico);
                    objRPT.DiagnosticoText = objReport.DiagnosticoText;
                    objRPT.TiempoEnfermedad_list = objReport.TiempoEnfermedad_list;
                    objRPT.DiagnosticoText = objReport.DiagnosticoText;
                    //objRPT.TipoDiagn_list = objReport.TipoDiagn_list;

                    objRPT.Descripcion = objReport.Descripcion;




                    objRPT.Adicional1 = objReport.Adicional1;
                    objRPT.Adicional2 = objReport.Adicional2;
                    objRPT.Medicacion_txt = objReport.Medicacion_txt;

                    listaRPT.Add(objRPT);
                }

                ///////////////////////////////                     
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewAntePatologicoGeneral.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }
            return listaRPT;
        }



        //*** Inicio CIRUGIA ENTRADA
        private void GenerarReporterptViewSeguridadCirugiaEntrada_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewSeguridadCirugiaEntrada_FE - Entrar");

            string tura = Server.MapPath("rptReports/rptViewSeguridadCirugiaEntrada_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewSeguridadCirugiaEntrada_FE.rpt"));

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewSeguridadCirugia_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewSeguridadCirugia_FEEdit>();
            listaRPT = getDatarptViewSeguridadCirugia("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, 1);
            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);



            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "SolicitudMedicamento");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            //Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


        }


        //***FIN CIRUGIA ENTRADA


        #region CCEPF463_REPORTE


        private void GenerarReporterptViewSeguridadCirugiaSalida_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewSeguridadCirugiaSalida_FE - Entrar");
            string tura = Server.MapPath("rptReports/rptViewSeguridadCirugiaSalida_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewSeguridadCirugiaSalida_FE.rpt"));

            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewSeguridadCirugia_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewSeguridadCirugia_FEEdit>();
            //listaRPT = getDatarptViewSeguridadCirugia("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, 3);


            DataTable listaRPT = new DataTable();

            listaRPT = rptVistasTipoCirugia_FE("rptViewSeguridadCirugia_FE",
       ENTITY_GLOBAL.Instance.UnidadReplicacion,
       (int)ENTITY_GLOBAL.Instance.PacienteID,
       (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
       (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
       , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, 3);


            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "SolicitudMedicamento");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            //Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


        }
        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewSeguridadCirugia_FEEdit>
        getDatarptViewSeguridadCirugia(String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
       , SoluccionSalud.RepositoryReport.Entidades.rptViewSeguridadCirugia_FEEdit objEntidad, int idImpresionLog,
       string codFormato, string codUsuario, int tipocirugia)
        {
            Log.Information("VisorReportesHCE - getDatarptViewSeguridadCirugia - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewSeguridadCirugia_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewSeguridadCirugia_FEEdit>();

            List<rptViewSeguridadCirugia_FE> rptViewAnteFisiologico = new List<rptViewSeguridadCirugia_FE>();
            SS_HC_SeguridadCirugia_FE ObjAnteFisiologico = new SS_HC_SeguridadCirugia_FE();
            ObjAnteFisiologico.UnidadReplicacion = unidadReplicacion;
            ObjAnteFisiologico.IdPaciente = idPaciente;
            ObjAnteFisiologico.EpisodioClinico = epiClinico;
            ObjAnteFisiologico.IdEpisodioAtencion = idEpiAtencion;
            ObjAnteFisiologico.IdEpisodioAtencion = 1;
            ObjAnteFisiologico.Accion = "REPORTEA";


            //Reporte-Service
            rptViewAnteFisiologico = ServiceReportes.rptViewSeguridadCirugia_FE(ObjAnteFisiologico, 0, 0, tipocirugia);

            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewSeguridadCirugia_FEEdit objRPT;

            if (rptViewAnteFisiologico != null)
            {
                foreach (rptViewSeguridadCirugia_FE objReport in rptViewAnteFisiologico) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewSeguridadCirugia_FEEdit();

                    objRPT.UnidadReplicacion = objReport.UnidadReplicacion;
                    objRPT.IdEpisodioAtencion = objReport.IdEpisodioAtencion;
                    objRPT.IdPaciente = objReport.IdPaciente;
                    objRPT.EpisodioClinico = objReport.EpisodioClinico;
                    objRPT.NombreCompleto = objReport.NombreCompleto;
                    objRPT.IntervencionQ = objReport.IntervencionQ;
                    objRPT.FechaRegistro = Convert.ToDateTime(objReport.FechaRegistro);
                    objRPT.Respuesta1 = Convert.ToInt32(objReport.Respuesta1);
                    objRPT.Respuesta2 = Convert.ToInt32(objReport.Respuesta2);
                    objRPT.Respuesta3 = Convert.ToInt32(objReport.Respuesta3);
                    objRPT.Respuesta4 = Convert.ToInt32(objReport.Respuesta4);
                    objRPT.Respuesta5 = Convert.ToInt32(objReport.Respuesta5);
                    objRPT.Respuesta6 = Convert.ToInt32(objReport.Respuesta6);
                    objRPT.Respuesta7 = Convert.ToInt32(objReport.Respuesta7);
                    objRPT.Respuesta8 = Convert.ToInt32(objReport.Respuesta8);
                    objRPT.Respuesta9 = Convert.ToInt32(objReport.Respuesta9);
                    objRPT.Respuesta10 = Convert.ToInt32(objReport.Respuesta10);
                    objRPT.Respuesta11 = Convert.ToInt32(objReport.Respuesta11);
                    objRPT.Respuesta12 = Convert.ToInt32(objReport.Respuesta12);
                    objRPT.Respuesta13 = Convert.ToInt32(objReport.Respuesta13);
                    objRPT.Respuesta14 = Convert.ToInt32(objReport.Respuesta14);
                    objRPT.Antibiotico = objReport.Antibiotico;
                    objRPT.UsuarioCreacion = objReport.UsuarioCreacion;
                    objRPT.FechaCreacion = Convert.ToDateTime(objReport.FechaCreacion);
                    objRPT.UsuarioModificacion = objReport.UsuarioModificacion;
                    objRPT.FechaModificacion = Convert.ToDateTime(objReport.FechaModificacion);

                    listaRPT.Add(objRPT);
                }
                ///////////////////////////////                     
                //PARA LA AUDITORIA DE IMPRESION
                //if (rptViewAntecedentesPersonalesFisiologicos_FE.Count > 0)
                //{
                //    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                //}
                /////////////////////////////// 
            }

            return listaRPT;

        }
        #endregion








        #region CCEPF462_REPORTE


        private void GenerarReporterptViewSeguridadCirugiaPausa_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewSeguridadCirugiaPausa_FE - Entrar");

            string tura = Server.MapPath("rptReports/rptViewSeguridadCirugiaPausa_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewSeguridadCirugiaPausa_FE.rpt"));

            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewSeguridadCirugia_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewSeguridadCirugia_FEEdit>();
            //listaRPT = getDatarptViewSeguridadCirugia("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, 2);


            DataTable listaRPT = new DataTable();

            listaRPT = rptVistasTipoCirugia_FE("rptViewSeguridadCirugia_FE",
       ENTITY_GLOBAL.Instance.UnidadReplicacion,
       (int)ENTITY_GLOBAL.Instance.PacienteID,
       (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
       (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
       , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, 2);


            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "SolicitudMedicamento");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            //Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


        }


        #endregion




        #region CCEPF444_REPORTE

        private void GenerarReporterptViewEscalaAldrete_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - CCEPF319_View - Entrar");
            Rpt.Load(Server.MapPath("rptReports/rptViewEscalaAldrete_FE.rpt")); // Crystal Report
            string tura = Server.MapPath("rptReports/rptViewEscalaAldrete_FE.rpt");

            DataTable listaRPT = new DataTable();
            string varVistaEntidad = "rptViewEscalaAldrete_FE"; // Entidad Vista
            listaRPT = rptVistasEscalaAldrete_FE(varVistaEntidad, ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID
                                   , (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                                   , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "EscalaAldrete");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }




        }
        public static DataTable rptVistasEscalaAldrete_FE(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion, string var, int va, string CONCEPTO, string Usuario)
        {
            Log.Information("VisorReportesHCE - rptVistasEscalaAldrete_FE - Entrar");

            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                conx.Open();
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and IdEpisodioAtencion=" + EpisodioAtencion + " ORDER BY Accion ASC";
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "EscalaAldrete");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }

        #endregion // fin CCEPF444_REPORTE




        #region CCEPF445_REPORTE
        //***ESCALA STEWART
        private void GenerarReporterptViewEscalaStewart_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewEscalaStewart_FE - Entrar");

            string tura = Server.MapPath("rptReports/rptViewEscalaStewart_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewEscalaStewart_FE.rpt"));

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewEscalaStewart_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewEscalaStewart_FEEdit>();
            listaRPT = getDatarptViewEscalaStewart_FE("REPORTEA", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            setDatosGenerales();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "SolicitudMedicamento");
                    }
                    catch (Exception ex)
                    {
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            //Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


        }
        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewEscalaStewart_FEEdit>
        getDatarptViewEscalaStewart_FE(String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion
       , SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog,
       string codFormato, string codUsuario)
        {
            Log.Information("VisorReportesHCE - getDatarptViewEscalaStewart_FE - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewEscalaStewart_FEEdit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewEscalaStewart_FEEdit>();

            List<rptViewEscalaStewart_FE> rptViewEscalaStewart_FE = new List<rptViewEscalaStewart_FE>();
            SS_HC_EscalaStewart_FE ObjAnteFisiologico = new SS_HC_EscalaStewart_FE();
            ObjAnteFisiologico.UnidadReplicacion = unidadReplicacion;
            ObjAnteFisiologico.IdPaciente = idPaciente;
            ObjAnteFisiologico.EpisodioClinico = epiClinico;
            ObjAnteFisiologico.IdEpisodioAtencion = idEpiAtencion;

            ObjAnteFisiologico.Accion = "REPORTEA";
            rptViewEscalaStewart_FE = ServiceReportes.rptViewEscalaStewart_FE(ObjAnteFisiologico, 0, 0);
            //AAAA
            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewEscalaStewart_FEEdit objRPT;
            if (rptViewEscalaStewart_FE != null)
            {
                foreach (rptViewEscalaStewart_FE objReport in rptViewEscalaStewart_FE) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewEscalaStewart_FEEdit();

                    objRPT.UnidadReplicacion = objReport.UnidadReplicacion;
                    objRPT.IdEpisodioAtencion = objReport.IdEpisodioAtencion;
                    objRPT.IdPaciente = objReport.IdPaciente;
                    objRPT.EpisodioClinico = objReport.EpisodioClinico;
                    objRPT.IdEscalaStewart = objReport.IdEscalaStewart;
                    objRPT.FechaIngreso = Convert.ToDateTime(objReport.FechaIngreso);
                    objRPT.HoraIngreso = Convert.ToDateTime(objReport.HoraIngreso);
                    objRPT.FlagParametro1 = Convert.ToInt32(objReport.FlagParametro1);
                    objRPT.FlagParametro2 = Convert.ToInt32(objReport.FlagParametro2);
                    objRPT.FlagParametro3 = Convert.ToInt32(objReport.FlagParametro3);
                    objRPT.FlagParametro4 = Convert.ToInt32(objReport.FlagParametro4);
                    objRPT.FlagParametro5 = Convert.ToInt32(objReport.FlagParametro5);
                    objRPT.FlagParametro6 = Convert.ToInt32(objReport.FlagParametro6);
                    objRPT.FlagParametro7 = Convert.ToInt32(objReport.FlagParametro7);
                    objRPT.FlagParametro8 = Convert.ToInt32(objReport.FlagParametro8);
                    objRPT.FlagParametro9 = Convert.ToInt32(objReport.FlagParametro9);
                    objRPT.Adicional1 = Convert.ToInt32(objReport.Adicional1);
                    objRPT.Adicional2 = objReport.Adicional2;
                    objRPT.Total = Convert.ToInt32(objReport.Total);
                    objRPT.Estado = Convert.ToInt32(objReport.Estado);
                    objRPT.UsuarioCreacion = objReport.UsuarioCreacion;
                    objRPT.FechaCreacion = Convert.ToDateTime(objReport.FechaCreacion);
                    objRPT.UsuarioModificacion = objReport.UsuarioModificacion;
                    objRPT.FechaModificacion = Convert.ToDateTime(objReport.FechaModificacion);

                    listaRPT.Add(objRPT);
                }
                ///////////////////////////////                     
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewEscalaStewart_FE.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                ///////////////////////////////  
            }

            return listaRPT;

        }

        #endregion

        #region CCEPF631_REPORTE

        private void GenerarReporterptViewTriajeEmergencia_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewTriajeEmergencia_FE - Entrar");

            Rpt.Load(Server.MapPath("rptReports/rptViewTriajeEmergencia_FE.rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistasTriaje_FE("rptViewTriajeEmergencia_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioTriaje
               , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            // setDatosGenerales();
            setDatosGeneralesTriaje();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "SolicitudMedicamento");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }


        }
        #endregion

        #region  CCEPF630_REPORTE

        private void GenerarReporterptViewTriajeAlergias_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewTriajeAlergias_FE - Entrar");
            string tura = Server.MapPath("rptReports/rptViewTriajeEmerAlergias_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewTriajeEmerAlergias_FE.rpt"));
            DataTable listaRPT = new DataTable();
            DataTable listaRPTrptViewTriajeAlergias_FEDetalle1 = new DataTable();
            DataTable listaRPTrptViewTriajeAlergias_FEDetalle2 = new DataTable();

            listaRPT = rptVistasTriaje_FE("rptViewCabezeraAntecedenAlergias_FE",
                            ENTITY_GLOBAL.Instance.UnidadReplicacion,
                           (int)ENTITY_GLOBAL.Instance.PacienteID,
                           (int)ENTITY_GLOBAL.Instance.EpisodioTriaje,
                            null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                           ENTITY_GLOBAL.Instance.USUARIO);


            listaRPTrptViewTriajeAlergias_FEDetalle1 = rptVistasTriaje_Alergias_FE("rptViewTriajeAlergias_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioTriaje
            , "MA", 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);


            listaRPTrptViewTriajeAlergias_FEDetalle2 = rptVistasTriaje_Alergias_FE("rptViewTriajeAlergias_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioTriaje
         , "RE", 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);


            Rpt.Subreports["rptViewTriajeAlergias_FEDetalle1subrep.rpt"].SetDataSource(listaRPTrptViewTriajeAlergias_FEDetalle1);
            Rpt.Subreports["rptViewTriajeAlergias_FEDetalle2subrep.rpt"].SetDataSource(listaRPTrptViewTriajeAlergias_FEDetalle2);

            setDatosGeneralesTriaje();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }



        }











        //***FIN ESCALA STEWART
        #endregion
        #region CCEPF302_REPORTE

        private void GenerarReporterptViewHojaRecienNacido(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewHojaRecienNacido - Entrar");

            DataTable listaRPT = new DataTable();
            DataTable listaRPTDetalle = new DataTable();


            string tura = Server.MapPath("rptReports/rptHojaRecienNacido_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptHojaRecienNacido_FE.rpt"));


            listaRPT = rptVistas_FE("rptHojaRecienNacido_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
           , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);


            listaRPTDetalle = rptVistas_FE("rptViewHojarecienNacidoDetalle_FEsubrep", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
               , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);


            Rpt.Subreports["rptHojaRecienNacido_FEsubrep.rpt"].SetDataSource(listaRPTDetalle);




            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "SolicitudMedicamento");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }



        }

        #endregion

        #region CCEPF420_REPORTE

        private void GenerarReporterptViewVigilanciaCateterUrinario_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewVigilanciaCateterUrinario_FE - Entrar");

            Rpt.Load(Server.MapPath("rptReports/rptViewVigilanciaCateterUrinario_FE.rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewVigilanciaCateterUrinario_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
               , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "SolicitudMedicamento");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }



        }

        #endregion

        private void GenerarReporterptViewVigilanciaVentilacionMecanica_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewVigilanciaVentilacionMecanica_FE - Entrar");

            Rpt.Load(Server.MapPath("rptReports/rptViewVigilanciaVentilacionMecanica_FE.rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewVigilanciaVentilacionMecanica_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
               , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "SolicitudMedicamento");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }



        }

        private void GenerarReporterptViewEvaluacionDolorEvaNeonatosPrematuros_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewEvaluacionDolorEvaNeonatosPrematuros_FE - Entrar");

            Rpt.Load(Server.MapPath("rptReports/rptViewEvaluacionDolorEvaNeonatosPrematuros_FE.rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewEvaluacionDolorEvaNeonatosPrematuros_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
               , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "SolicitudMedicamento");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }



        }

        #region CCEPF422_REPORTE

        private void GenerarReporterptViewVigilanciaCateterPeriferico_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewVigilanciaCateterPeriferico_FE - Entrar");

            Rpt.Load(Server.MapPath("rptReports/rptViewVigilanciaCateterPeriferico_FE.rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewVigilanciaCateterPeriferico_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
               , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "SolicitudMedicamento");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }



        }

        #endregion
        #region CCEPF404_REPORTE

        private void GenerarReporterptViewPartograma(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewPartograma - Entrar");
            Rpt.Load(Server.MapPath("rptReports/rptViewPartograma_FE.rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewPartograma_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
               , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "SolicitudMedicamento");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }




        }

        #endregion

        #region CCEPF505_REPORTE

        private void GenerarReporterptViewResumenParto(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewResumenParto - Entrar");
            Rpt.Load(Server.MapPath("rptReports/rptViewResumenParto_FE.rpt"));
            DataTable listaRPT = new DataTable();
            DataTable listaRPT_1 = new DataTable();

            listaRPT = rptVistas_FE("rptViewResumenParto_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
               , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            listaRPT_1 = rptVistas_FE("rptViewResumenParto_FE_Det", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                        null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            Rpt.Subreports["rptViewResumenParto_FE_Det.rpt"].SetDataSource(listaRPT_1);
            setDatosGenerales();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "SolicitudMedicamento");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }





        }

        #endregion

        #region CCEPF505_2 REPORTE
        private void GenerarReporterptViewResumenParto2_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewResumenParto2_FE - Entrar");

            Rpt.Load(Server.MapPath("rptReports/rptViewResumenParto2_FE.rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewResumenParto2_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                 , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            setDatosGenerales();
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                      (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "SolicitudMedicamento");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }


        }

        #endregion
        #region CCEPF505_3 REPORTE


        private void GenerarReporterptViewResumenParto3_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewResumenParto3_FE - Entrar");
            Rpt.Load(Server.MapPath("rptReports/rptViewResumenParto3_FE.rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewResumenParto3_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
               , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            setDatosGenerales();
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "SolicitudMedicamento");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }


        }


        //#endregion
        //#region CCEPF319 REPORTE


        private void GenerarReporterptViewNota_Ingreso_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewNota_Ingreso_FE - Entrar");


            DataTable listaRPT = new DataTable();
            DataTable listaRPT_detDiagnostico = new DataTable();
            DataTable listaRPT_detExamen_Apoyo = new DataTable();

            string tura = Server.MapPath("rptReports/rptViewNota_De_Ingreso_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewNota_De_Ingreso_FE.rpt"));

            listaRPT = rptVistas_FE("rptViewNota_Ingreso_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
               , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);



            listaRPT_detDiagnostico = rptVistas_FE("rptViewNotaIngreso_Diagnostico_FE",
           ENTITY_GLOBAL.Instance.UnidadReplicacion,
           (int)ENTITY_GLOBAL.Instance.PacienteID,
           (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
           (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
           , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            listaRPT_detExamen_Apoyo = rptVistas_FE("rptViewNotaIngreso_ExamenApoyo_FE",
       ENTITY_GLOBAL.Instance.UnidadReplicacion,
       (int)ENTITY_GLOBAL.Instance.PacienteID,
       (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
       (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
       , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);


            Rpt.Subreports["rptViewNota_De_Ingreso_Diagnostico_FE.rpt"].SetDataSource(listaRPT_detDiagnostico);
            Rpt.Subreports["rptViewNota_De_Ingreso_ExamenApoyo_FE.rpt"].SetDataSource(listaRPT_detExamen_Apoyo);

            //Datos Generales
            setDatosGenerales();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "AnteFamiliar");
                    }
                    catch (Exception ex) { Log.Error(ex, ex.Message); throw; }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


        }


        #endregion

        #region CCEPF502_REPORTE

        private void GenerarReporterptViewTocolosisInduccionAcentuacion_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewTocolosisInduccionAcentuacion_FE - Entrar");


            Rpt.Load(Server.MapPath("rptReports/rptViewTocolosisInduccionAcentuacion_FE.rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewTocolosisInduccionAcentuacion_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
               , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "SolicitudMedicamento");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }





        }

        #endregion

        #region CCEPF464_REPORTE
        private void GenerarReporterptViewEscalaAltaCirugiaAmbulatoria_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewEscalaAltaCirugiaAmbulatoria_FE - Entrar");
            Rpt.Load(Server.MapPath("rptReports/rptViewEscalaAltaCirugiaAmbulatoria_FE.rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewEscalaAltaCirugiaAmbulatoria_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
               , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);


            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);



            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "SolicitudMedicamento");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }


        }





        #endregion


        #region CCEPF435_REPORTE
        private void GenerarReporterptViewGradoDependencia_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewGradoDependencia_FE - Entrar");

            Rpt.Load(Server.MapPath("rptReports/rptViewGradoDependencia_FE.rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewGradoDependencia_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
               , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);



            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "SolicitudMedicamento");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }

        }

        #endregion

        #region CCEPF448_REPORTE
        private void GenerarReporterptViewEscalaSedacionRass_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewEscalaSedacionRass_FE - Entrar");

            Rpt.Load(Server.MapPath("rptReports/rptViewEscalaSedacionRass_FE.rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewEscalaSedacionRass_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
               , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "SolicitudMedicamento");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }


        }

        #endregion


        #region CCEPF449_REPORTE
        private void GenerarReporterptViewEscalaWoodDownes_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewEscalaWoodDownes_FE - Entrar");
            Rpt.Load(Server.MapPath("rptReports/rptViewEscalaWoodDownes_FE.rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewEscalaWoodDownes_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
               , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "SolicitudMedicamento");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }


        }

        #endregion


        #region CCEPF440_REPORTE
        private void GenerarReporterptViewEscalaGlasgow_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewEscalaGlasgow_FE - Entrar");
            Rpt.Load(Server.MapPath("rptReports/rptViewEscalaGlasgow_FE.rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistasGlasgow_FE("rptViewEscalaGlasgow_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
               , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, "EG");

            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "SolicitudMedicamento");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }

        }

        #endregion

        #region CCEPF441_REPORTE
        private void GenerarReporterptViewEscalaGlasgowPreEscolar_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewEscalaGlasgowPreEscolar_FE - Entrar");
            Rpt.Load(Server.MapPath("rptReports/rptViewEscalaGlasgowPreEscolar_FE.rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistasGlasgow_FE("rptViewEscalaGlasgow_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
               , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, "GP");

            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "SolicitudMedicamento");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }


        }

        #endregion

        #region CCEPF442_REPORTE
        private void GenerarReporterptViewEscalaGlasgowLactante_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewEscalaGlasgowLactante_FE - Entrar");

            Rpt.Load(Server.MapPath("rptReports/rptViewEscalaGlasgowLactante_FE.rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistasGlasgow_FE("rptViewEscalaGlasgow_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
               , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, "GL");

            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "SolicitudMedicamento");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }


        }

        #endregion

        #region CCEPF443_REPORTE
        private void GenerarReporterptViewEscalaNorton_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewEscalaNorton_FE - Entrar");
            Rpt.Load(Server.MapPath("rptReports/rptViewEscalaNorton_FE.rpt"));
            DataTable listaRPT = new DataTable();
            listaRPT = rptVistasNorton_FE("rptViewEscalaNorton_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
               , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "SolicitudMedicamento");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }


        }

        #endregion

        #region CCEPF447_REPORTE

        private void GenerarReporterptViewEscalaRamsay_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewEscalaRamsay_FE - Entrar");


            Rpt.Load(Server.MapPath("rptReports/rptViewEscalaRamsay_FE.rpt")); // Crystal Report
            string tura = Server.MapPath("rptReports/rptViewEscalaRamsay_FE.rpt");

            DataTable listaRPT = new DataTable();
            string varVistaEntidad = "rptViewEscalaRamsay_FE"; // Entidad Vista
            listaRPT = rptVistasEscalaRamsay_FE(varVistaEntidad, ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID
                                   , (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                                   , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "EscalaRamsay");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }





        }
        public static DataTable rptVistasEscalaRamsay_FE(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion, string var, int va, string CONCEPTO, string Usuario)
        {
            Log.Information("VisorReportesHCE - rptVistasEscalaRamsay_FE - Entrar");
            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                conx.Open();
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and IdEpisodioAtencion=" + EpisodioAtencion + " ORDER BY Accion ASC";
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "EscalaRamsay");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }

        #endregion // fin CCEPF447_REPORTE

        #region CCEPF204_REPORTE

        private void GenerarReporterptViewRetiroVoluntario2_FE(string tipovista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewRetiroVoluntario2_FE - Entrar");
            // Reporte
            string tura = Server.MapPath("rptReports/rptViewRetiroVoluntario_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewRetiroVoluntario_FE.rpt"));

            DataTable listaRPT = new DataTable();
            listaRPT = rptVistas_FE("rptViewRetiroVoluntario_FE",
                         ENTITY_GLOBAL.Instance.UnidadReplicacion,
                         (int)ENTITY_GLOBAL.Instance.PacienteID,
                         (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                         (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                         null, 0,
                         ENTITY_GLOBAL.Instance.CONCEPTO,
                         ENTITY_GLOBAL.Instance.USUARIO);

            //Datos Generales
            setDatosGenerales();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            imgFirma = Server.MapPath((string)Session["FIRMA_DIGITAL"]);
            Rpt.SetParameterValue("imgFirma", imgFirma);

            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);

            }
            else
            {
                if (tipovista == "I")
                {
                    if (tipovista == "I")
                    {
                        ReportViewer.ReportSource = Rpt;
                        ReportViewer.DataBind();
                    }
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {

                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DIAGNOSTICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                    Rpt.SetParameterValue("imgFirma", imgFirma);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetParameterValue("imgFirma", imgFirma);
        }
        private void GenerarReporterptViewRetiroVoluntario_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewRetiroVoluntario_FE - Entrar");


            Rpt.Load(Server.MapPath("rptReports/rptViewRetiroVoluntario_FE.rpt")); // Crystal Report
            string tura = Server.MapPath("rptReports/rptViewRetiroVoluntario_FE.rpt");

            DataTable DataTableRPT = new DataTable();
            DataTable DataTableRPTNew = new DataTable();

            string varVistaEntidad = "rptViewRetiroVoluntario_FE"; // Entidad Vista
            DataTableRPT = rptVistasRetiroVoluntario_FE(varVistaEntidad, ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID
                                   , (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                                   , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            DataTableRPTNew = rptVistasRetiroVoluntario_FE(varVistaEntidad
                                , ""
                                , 0
                                , 0
                                , 0
                                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            // Recorrer y asignar valores

            foreach (DataRow ht_fila in DataTableRPT.AsEnumerable())
            {

                DataRow rw = DataTableRPTNew.NewRow();

                rw["UnidadReplicacion"] = ht_fila["UnidadReplicacion"];
                rw["IdEpisodioAtencion"] = ht_fila["IdEpisodioAtencion"];
                rw["IdPaciente"] = ht_fila["IdPaciente"];
                rw["EpisodioClinico"] = ht_fila["EpisodioClinico"];
                rw["IdRetiroVoluntario"] = ht_fila["IdRetiroVoluntario"];
                rw["FechaIngreso"] = ht_fila["FechaIngreso"];
                rw["HoraIngreso"] = ht_fila["HoraIngreso"];
                rw["RepresentanteLegal"] = ht_fila["RepresentanteLegal"];
                rw["IdPersonalSalud"] = ht_fila["IdPersonalSalud"];
                rw["UsuarioCreacion"] = ht_fila["UsuarioCreacion"];
                rw["FechaCreacion"] = ht_fila["FechaCreacion"];
                rw["UsuarioModificacion"] = ht_fila["UsuarioModificacion"];
                rw["FechaModificacion"] = ht_fila["FechaModificacion"];
                rw["Accion"] = ht_fila["Accion"];
                rw["Version"] = ht_fila["Version"];
                rw["ApellidoPaterno"] = ht_fila["ApellidoPaterno"];
                rw["ApellidoMaterno"] = ht_fila["ApellidoMaterno"];
                rw["Nombres"] = ht_fila["Nombres"];
                rw["NombreCompleto"] = ht_fila["NombreCompleto"];
                rw["Busqueda"] = ht_fila["Busqueda"];
                rw["TipoDocumento"] = ht_fila["TipoDocumento"];
                rw["Documento"] = ht_fila["Documento"];
                rw["FechaNacimiento"] = ht_fila["FechaNacimiento"];
                rw["Sexo"] = ht_fila["Sexo"];
                rw["EstadoCivil"] = ht_fila["EstadoCivil"];
                rw["PersonaEdad"] = ht_fila["PersonaEdad"];
                rw["IdOrdenAtencion"] = ht_fila["IdOrdenAtencion"];
                rw["CodigoOA"] = ht_fila["CodigoOA"];
                rw["LineaOrdenAtencion"] = ht_fila["LineaOrdenAtencion"];
                rw["TipoOrdenAtencion"] = ht_fila["TipoOrdenAtencion"];
                rw["TipoAtencion"] = ht_fila["TipoAtencion"];
                rw["TipoTrabajador"] = ht_fila["TipoTrabajador"];
                rw["IdEstablecimientoSalud"] = ht_fila["IdEstablecimientoSalud"];
                rw["IdUnidadServicio"] = ht_fila["IdUnidadServicio"];
                rw["FechaRegistro"] = ht_fila["FechaRegistro"];
                rw["FechaAtencion"] = ht_fila["FechaAtencion"];
                rw["IdEspecialidad"] = ht_fila["IdEspecialidad"];
                rw["IdTipoOrden"] = ht_fila["IdTipoOrden"];
                rw["estadoEpiAtencion"] = ht_fila["estadoEpiAtencion"];
                rw["ObservacionProximaEpiAtencion"] = ht_fila["ObservacionProximaEpiAtencion"];
                rw["TipoAtencionDesc"] = ht_fila["TipoAtencionDesc"];
                rw["TipoTrabajadorDesc"] = ht_fila["TipoTrabajadorDesc"];
                rw["EstablecimientoCodigo"] = ht_fila["EstablecimientoCodigo"];
                rw["EstablecimientoDesc"] = ht_fila["EstablecimientoDesc"];
                rw["UnidadServicioCodigo"] = ht_fila["UnidadServicioCodigo"];
                rw["UnidadServicioDesc"] = ht_fila["UnidadServicioDesc"];
                rw["NombreCompletoPerSalud"] = ht_fila["NombreCompletoPerSalud"];
                rw["CMP"] = ht_fila["CMP"];
                rw["CodigoHC"] = ht_fila["CodigoHC"];
                rw["Cama"] = ENTITY_GLOBAL.Instance.CAMA;


                DataTableRPTNew.Rows.Add(rw);

            }
            //



            Rpt.SetDataSource(DataTableRPTNew);

            if (DataTableRPTNew.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "RetiroVoluntario");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }




        }
        public static DataTable rptVistasRetiroVoluntario_FE(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion, string var, int va, string CONCEPTO, string Usuario)
        {
            Log.Information("VisorReportesHCE - rptVistasRetiroVoluntario_FE - Entrar");
            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                conx.Open();
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and IdEpisodioAtencion=" + EpisodioAtencion + " ORDER BY Accion ASC";

                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();

                adapter.Fill(ds_Result, "RetiroVoluntario");

                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }

                return ds_Result.Tables[0];

            }
        }

        #endregion // fin CCEPF447_REPORTE




        #region CCEPF446_REPORTE

        private void GenerarReporterptViewEscalaBromage_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewEscalaBromage_FE - Entrar");
            string tura = Server.MapPath("rptReports/rptViewEscalaBromage_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewEscalaBromage_FE.rpt"));
            DataTable listaRPT = new DataTable();

            listaRPT = rptVistas_FE("rptViewEscalaBromage_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //DataSet obj = new DataSet();
            //dsRptViewer.Tables.Add(objTabla1.Copy());
            //dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));
            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }


        }

        #endregion



        #region CCEPF431_REPORTE

        private void GenerarReporterptViewDolorEvaAdulto_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewDolorEvaAdulto_FE - Entrar");
            string tura = Server.MapPath("rptReports/rptViewDolorEvaAdulto_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewDolorEvaAdulto_FE.rpt"));
            DataTable listaRPT = new DataTable();

            listaRPT = rptVistas_FE("rptViewDolorEvaAdulto_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //DataSet obj = new DataSet();
            //dsRptViewer.Tables.Add(objTabla1.Copy());
            //dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));
            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);


            imgDolor = Server.MapPath("resources/images/CCEPF431.JPG");
            Rpt.SetParameterValue("imgDolor", imgDolor);
            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.SetParameterValue("imgDolor", imgDolor);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                    Rpt.SetParameterValue("imgDolor", imgDolor);
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgDolor", imgDolor);
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }


            //Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            //Rpt.SetParameterValue("imgDerecha", imgDerecha);


        }
        #endregion

        #region CCEPF432_REPORTE

        private void GenerarReporterptViewDolorEvaNinios_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewDolorEvaNinios_FE - Entrar");

            Rpt.Load(Server.MapPath("rptReports/rptViewDolorEvaNinios_FE.rpt")); // Crystal Report
            string tura = Server.MapPath("rptReports/rptViewDolorEvaNinios_FE.rpt");

            DataTable DataTableRPT = new DataTable();
            string varVistaEntidad = "rptViewDolorEvaNinios_FE"; // Entidad Vista

            DataTableRPT = rptVistasDolorEvaNinios_FE(varVistaEntidad, ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID
                                   , (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                                   , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(DataTableRPT);
            setDatosGenerales();

            if (DataTableRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "EscalaRamsay");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }




        }
        public static DataTable rptVistasDolorEvaNinios_FE(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion, string var, int va, string CONCEPTO, string Usuario)
        {
            Log.Information("VisorReportesHCE - rptVistasDolorEvaNinios_FE - Entrar");
            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                conx.Open();
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and IdEpisodioAtencion=" + EpisodioAtencion + " ORDER BY Accion ASC";
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "DolorEvaNinios");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }

        #endregion // fin CCEPF432_REPORTE

        #region CCEPF051_REPORTE

        private void GenerarReporterptViewFuncionesVitales_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewFuncionesVitales_FE - Entrar");

            string tura = Server.MapPath("rptReports/rptViewFuncionesVitale_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewFuncionesVitale_FE.rpt"));
            DataTable listaRPT = new DataTable();

            listaRPT = rptVistas_FE("rptViewFuncionesVitales_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //DataSet obj = new DataSet();
            //dsRptViewer.Tables.Add(objTabla1.Copy());
            //dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));
            //Datos Generales
            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "FUNCIONES VITALES");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }

                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

                }

            }

            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }

        #endregion

        #region CCEPF001_REPORTE

        private void GenerarReporterptViewEnfermedadActual_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewEnfermedadActual_FE - Entrar");

            string tura = Server.MapPath("rptReports/rptViewEnfermedadActual_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewEnfermedadActual_FE.rpt"));
            DataTable listaRPT = new DataTable();

            listaRPT = rptVistas_FE("rptViewEnfermedadActual_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);

            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }

            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

        }

        #endregion


        public DataTable ConvertToDataTable<T>(IList<T> data)
        {
            Log.Information("VisorReportesHCE - ConvertToDataTable - Entrar");

            PropertyDescriptorCollection properties =
               TypeDescriptor.GetProperties(typeof(T));
            DataTable table = new DataTable();
            foreach (PropertyDescriptor prop in properties)
                table.Columns.Add(prop.Name, Nullable.GetUnderlyingType(prop.PropertyType) ?? prop.PropertyType);
            foreach (T item in data)
            {
                DataRow row = table.NewRow();
                foreach (PropertyDescriptor prop in properties)
                    row[prop.Name] = prop.GetValue(item) ?? DBNull.Value;
                table.Rows.Add(row);
            }
            return table;
        }


        #region CCEPF328_REPORTE

        private void GenerarReporterptViewNotaEnfermera_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewNotaEnfermera_FE - Entrar");

            string tura = Server.MapPath("rptReports/rptView_NotadeEnfermeriaFE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptView_NotadeEnfermeriaFE.rpt"));
            //DataTable listaRPT = new DataTable();

            //var LocalEnty = new SS_HC_NotasEnfermeria_FE();
            //List<SS_HC_NotasEnfermeria_FE> Listar = new List<SS_HC_NotasEnfermeria_FE>();


            //List<NotadeEnfermeria> Listar2 = new List<NotadeEnfermeria>();

            //LocalEnty.Accion = "LISTAR";
            //LocalEnty.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            //LocalEnty.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            ////LocalEnty.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            //LocalEnty.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;

            //Listar = SvcNotaEnfermeriaServiceFE.ReporteNotaEnfermeriaListar(LocalEnty).ToList();
            ////NotaEnfermeriaListar

            //listaRPT = ConvertToDataTable(Listar);

            DataTable listaRPTrptNOTADEENFERMERA = new DataTable();
            listaRPTrptNOTADEENFERMERA = rptVistasMasivas_FE("rptViewNotaEnfermeriaMasiva_FE"
                                  , ENTITY_GLOBAL.Instance.UnidadReplicacion
                                  , (int)ENTITY_GLOBAL.Instance.PacienteID
                                  , (int)ENTITY_GLOBAL.Instance.EpisodioClinico
                                  , (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                                  , null
                                  , 0
                                  , ENTITY_GLOBAL.Instance.CONCEPTO
                                  , ENTITY_GLOBAL.Instance.USUARIO);

            foreach (DataRow drPrincipal in listaRPTrptNOTADEENFERMERA.AsEnumerable())
            {
                if (drPrincipal["FirmaDigital"] != null && drPrincipal["FirmaDigital"] != "")
                {
                    System.IO.FileInfo fi = new System.IO.FileInfo(drPrincipal["FirmaDigital"].ToString().Trim());
                    if (fi.Exists)
                    {
                        byte[] imageBytes;
                        //var NombreServidor = fi.Name;
                        //var rutaServidor = Server.MapPath("../resources/DocumentosAdjuntos/firmas/");
                        //if (!Directory.Exists(rutaServidor))
                        //{
                        //    DirectoryInfo di = Directory.CreateDirectory(rutaServidor);
                        //}
                        //var PathServidor = rutaServidor + NombreServidor;
                        //System.IO.File.Copy(drPrincipal["UsuarioModificacion"].ToString(), PathServidor, true);
                        //var PathOri = "../resources/DocumentosAdjuntos/firmas/" + NombreServidor;
                        imageBytes = System.IO.File.ReadAllBytes(fi.FullName);
                        drPrincipal["CodigoBinario"] = imageBytes;
                    }
                    else
                    {
                        drPrincipal["CodigoBinario"] = "";
                    }

                }
            }
            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            Rpt.SetDataSource(listaRPTrptNOTADEENFERMERA);
            if (listaRPTrptNOTADEENFERMERA.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);

            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }

            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

        }

        #endregion


        #region CCEPF103_REPORTE

        private void GenerarReporterptViewIndicaNoFarmacolog_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewIndicaNoFarmacolog_FE - Entrar");
            string tura = Server.MapPath("rptReports/rptViewMedicamentoNoFarmacologicoFE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewMedicamentoNoFarmacologicoFE.rpt"));
            DataTable listaRPT = new DataTable();

            //var LocalEnty = new SS_HC_NotasEnfermeria_FE();
            //List<SS_HC_NotasEnfermeria_FE> Listar = new List<SS_HC_NotasEnfermeria_FE>();

            //LocalEnty.Accion = "LISTAR";
            //LocalEnty.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            //LocalEnty.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            //LocalEnty.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            //LocalEnty.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;

            //Listar = SvcNotaEnfermeriaServiceFE.NotaEnfermeriaListar(LocalEnty).ToList();

            var objListaAnt3 = new List<SS_HC_Medicamento_FE>();
            SS_HC_Medicamento_FE objEnt = new SS_HC_Medicamento_FE();
            objEnt.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            objEnt.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            objEnt.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            objEnt.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            objEnt.Accion = "LISTAR_FARMACO";

            objEnt.TipoMedicamento = 1; //para Medicina
            objListaAnt3 = SvcMedicamentoFE.MedicamentoListar(objEnt);






            listaRPT = ConvertToDataTable(objListaAnt3);

            //listaRPT = rptVistas_FE("rptViewEnfermedadActual_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            //    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);




            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);

            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }

            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

        }

        #endregion


        #region CCEPF501_REPORTE

        private void GenerarReporteEvolucionObstetricaPuerperio_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteEvolucionObstetricaPuerperio_FE - Entrar");

            string tura = Server.MapPath("rptReports/rptViewEvolucionObstetricaPuerperio_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewEvolucionObstetricaPuerperio_FE.rpt"));
            DataTable listaRPT = new DataTable();

            listaRPT = rptVistas_FE("rptViewEvolucionObstetricaPuerperio_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }


        }

        #endregion

        #region CCEPF425_REPORTE

        private void GenerarReporteVigilanciaDispositivos_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteVigilanciaDispositivos_FE - Entrar");

            string tura = Server.MapPath("rptReports/rptViewVigilanciaDispositivos_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewVigilanciaDispositivos_FE.rpt"));
            DataTable listaRPT = new DataTable();
            DataTable listaRPTDrenajes = new DataTable();

            listaRPT = rptVistas_FE("rptViewVigilancia_Dispositivos_FE",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            listaRPTDrenajes = rptVigilanciaDrenaje_FE("rptViewVigilancia_Dispositivos_FE",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            Rpt.Subreports["rptViewVigilanciaDispositivosDrenajes_FE.rpt"].SetDataSource(listaRPTDrenajes);

            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }


        }

        #endregion


        #region CCEPF200_REPORTE

        private void GenerarReporteInformeAlta_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteInformeAlta_FE - Entrar");

            string tura = Server.MapPath("rptReports/rptViewInformeAlta_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewInformeAlta_FE.rpt"));
            DataTable listaRPT = new DataTable();
            DataTable listaRPT_Med = new DataTable();
            DataTable listaRPT_Mat = new DataTable();
            DataTable listaRPT_proxCita = new DataTable();

            listaRPT = rptVistas_FE("rptViewInformeAlta_DatosGenerales_FE",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            listaRPT_Med = rptInformeAlta_MED_FE("rptViewInformeAlta_Med",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            listaRPT_Mat = rptInformeAlta_MED_FE("rptViewInformeAlta_Mat",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            listaRPT_proxCita = rptInformeAlta_MED_FE("rptViewInformeAlta_proxCita",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            Rpt.Subreports["rptViewInformeAlta_med.rpt"].SetDataSource(listaRPT_Med);
            Rpt.Subreports["rptViewInformeAlta_mat.rpt"].SetDataSource(listaRPT_Mat);
            Rpt.Subreports["rptViewInformeAlta_proxCita.rpt"].SetDataSource(listaRPT_proxCita);

            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }


        }

        private void GenerarReporteInformeAlta2_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteInformeAlta2_FE - Entrar");

            string tura = Server.MapPath("rptReports/rptViewInformeAlta_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewInformeAlta_FE.rpt"));
            DataTable listaRPT = new DataTable();
            DataTable listaRPT_Med = new DataTable();
            DataTable listaRPT_Mat = new DataTable();
            DataTable listaRPT_proxCita = new DataTable();

            listaRPT = rptVistas_FE("rptViewInformeAlta_DatosGenerales_FE",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            listaRPT_Med = rptInformeAlta_MED_FE("rptViewInformeAlta_Med",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            listaRPT_Mat = rptInformeAlta_MED_FE("rptViewInformeAlta_Mat",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            listaRPT_proxCita = rptInformeAlta_MED_FE("rptViewInformeAlta_proxCita",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            Rpt.Subreports["rptViewInformeAlta_med.rpt"].SetDataSource(listaRPT_Med);
            Rpt.Subreports["rptViewInformeAlta_mat.rpt"].SetDataSource(listaRPT_Mat);
            Rpt.Subreports["rptViewInformeAlta_proxCita.rpt"].SetDataSource(listaRPT_proxCita);

            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }


        }
        #endregion

        #region CCEPF327_REPORTE



        private void GenerarReporteOrdenIntervencionQuirurgica_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteOrdenIntervencionQuirurgica_FE - Entrar");
            DataTable listaRPT = new DataTable();
            DataTable listaRPT_detDiagnos_1 = new DataTable();
            DataTable listaRPT_detCirigiaProce_2 = new DataTable();
            DataTable listaRPT_detExamen_3 = new DataTable();
            DataTable listaRPT_detExamen_4 = new DataTable();
            DataTable listaRPT_detExamen_5 = new DataTable();
            DataTable listaRPT_Firma = new DataTable();

            string tura = Server.MapPath("rptReports/rptViewOrdenIntervencionQuirurgica_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewOrdenIntervencionQuirurgica_FE.rpt"));

            listaRPT = rptVistas_FE("rptViewOrdenInterQuirurgica_FE",
                    ENTITY_GLOBAL.Instance.UnidadReplicacion,
                    (int)ENTITY_GLOBAL.Instance.PacienteID,
                    (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                    (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                    ENTITY_GLOBAL.Instance.USUARIO);

            // Verificar si la lista es válida y contiene al menos un elemento
            if (listaRPT != null && listaRPT.Rows.Count > 0)
            {
                // Verificar si la sesión contiene el dato necesario
                if (Session["EmpresaAseguradoraNombre"] != null)
                {
                    // Validar si existe la clave "Accion" en las columnas del DataTable
                    if (listaRPT.Columns.Contains("Accion"))
                    {
                        // Asignar el valor desde la sesión
                        listaRPT.Rows[0]["Accion"] = Session["EmpresaAseguradoraNombre"];
                    }
                }
                // Verificar si la sesión contiene el dato necesario
                if (Session["CodigoHC_PACIENTE"] != null)
                {
                    // Validar si existe la clave "Accion" en las columnas del DataTable
                    if (listaRPT.Columns.Contains("Version"))
                    {
                        // Asignar el valor desde la sesión
                        listaRPT.Rows[0]["Version"] = Session["CodigoHC_PACIENTE"];
                    }
                }
            }

            foreach (DataRow ht_fila in listaRPT.Rows)
            {
                if (ht_fila["UnidadServicioCodigo"].ToString() != null && ht_fila["UnidadServicioCodigo"].ToString() != "")
                {
                    System.IO.FileInfo fi = new System.IO.FileInfo(ht_fila["UnidadServicioCodigo"].ToString());
                    if (fi.Exists)
                    {
                        var NombreServidor = fi.Name;
                        var rutaServidor = Server.MapPath("../resources/DocumentosAdjuntos/firmas/");
                        if (!Directory.Exists(rutaServidor))
                        {
                            DirectoryInfo di = Directory.CreateDirectory(rutaServidor);
                        }
                        var PathServidor = rutaServidor + NombreServidor;
                        System.IO.File.Copy(ht_fila["UnidadServicioCodigo"].ToString(), PathServidor, true);
                        var PathOri = "../resources/DocumentosAdjuntos/firmas/" + NombreServidor;
                        Session["FIRMA_DIGITAL"] = PathOri;
                    }
                }
                else
                {
                    Session["FIRMA_DIGITAL"] = "";
                }
            }


            listaRPT_detDiagnos_1 = rptVistas_FE("rptViewOrdenInterQuiruDiagnosticoDetalle_FE",
               ENTITY_GLOBAL.Instance.UnidadReplicacion,
               (int)ENTITY_GLOBAL.Instance.PacienteID,
               (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
               (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
               , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            listaRPT_detCirigiaProce_2 = rptVistasExamenesOrdenInter_FE("rptViewOrdenInterQuiruExamenApoyoDetalle_FE",
              ENTITY_GLOBAL.Instance.UnidadReplicacion,
              (int)ENTITY_GLOBAL.Instance.PacienteID,
              (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
              (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
              , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, 1);

            listaRPT_detExamen_3 = rptVistasExamenesOrdenInter_FE("rptViewOrdenInterQuiruExamenApoyoDetalle_FE",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, 2);

            listaRPT_detExamen_4 = rptVistasExamenesOrdenInter_FE("rptViewOrdenInterQuiruExamenApoyoDetalle_FE",
                     ENTITY_GLOBAL.Instance.UnidadReplicacion,
                     (int)ENTITY_GLOBAL.Instance.PacienteID,
                     (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                     (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                     , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, 3);


            listaRPT_detExamen_5 = rptVistasExamenesOrdenInter_FE("rptViewOrdenInterQuiruExamenApoyoDetalle_FE",
                          ENTITY_GLOBAL.Instance.UnidadReplicacion,
                          (int)ENTITY_GLOBAL.Instance.PacienteID,
                          (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                          (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                          , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, 4);

            //rptVistasExamenesOrdenInter_FE

            Rpt.Subreports["rptViewOrdenIntervenQuirurgica_DetalleDiagnostico_FE.rpt"].SetDataSource(listaRPT_detDiagnos_1);
            Rpt.Subreports["rptViewOrdenIntervenQuirurgica_DetCirugiaProce_FE.rpt"].SetDataSource(listaRPT_detCirigiaProce_2);

            Rpt.Subreports["rptViewOrdenIntervenQuirurgica_DetExamenes_FE.rpt"].SetDataSource(listaRPT_detExamen_3);

            Rpt.Subreports["rptViewOrdenIntervenQuirurgica_DetExamenes_FE.rpt - 01"].SetDataSource(listaRPT_detExamen_4);

            Rpt.Subreports["rptViewOrdenIntervenQuirurgica_DetExamenes_FE.rpt - 02"].SetDataSource(listaRPT_detExamen_5);

            //Rpt.Subreports["rptViewFirmaGeneral.rpt"].SetDataSource(listaRPT_Firma);

            //Datos Generales
            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            imgFirma = "";
            imgFirma = Server.MapPath((string)Session["FIRMA_DIGITAL"]);
            Rpt.SetParameterValue("imgFirma", imgFirma);
            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "AnteFamiliar");
                    }
                    catch (Exception ex) { throw; }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                    Rpt.SetParameterValue("imgFirma", imgFirma);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetParameterValue("imgFirma", imgFirma);
        }


        ////<<<<<<< HEAD
        ////=======
        //                 imgIzquierda = Server.MapPath("Imagen/Logo.png");
        //                 Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        //                    Rpt.SetDataSource(listaRPT);
        //                 if (listaRPT.Rows.Count == 0)
        //                 {
        //                     ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
        //                 }
        //                 else
        //                 {
        //                     if (tipoVista == "I")
        //                     {
        //                         ReportViewer.ReportSource = Rpt;
        //                         ReportViewer.DataBind();
        //                     }
        //                     else
        //                     {
        //                         Response.Buffer = false;
        //                         Response.ClearContent();
        //                         Response.ClearHeaders();
        //                         try
        //                         {
        //                             Rpt.ExportToHttpResponse
        //                             (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "AnteFamiliar");
        //                         }
        //                         catch (Exception ex) { Log.Error(ex, ex.Message); throw; }
        //                         Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        //                     }
        //                 }
        //                 Rpt.SetParameterValue("imgIzquierda", imgIzquierda);



        //             }


        ////>>>>>>> Rafael




        #endregion

        #region CCEPF323_1_REPORTE



        private void GenerarReporteFichaAnestesia_1_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteFichaAnestesia_1_FE - Entrar");


            DataTable listaRPT = new DataTable();
            DataTable listaRPT_detExamen_1 = new DataTable();
            DataTable listaRPT_detExamen_2 = new DataTable();

            DataTable listaRPT_detDiagnstico_1 = new DataTable();
            DataTable listaRPT_detExamenCirugia_ = new DataTable();
            DataTable listaRPT_detExamen_3 = new DataTable();

            DataTable listaRPT_detDiagnsticoPost_2 = new DataTable();

            //DataTable listaRPT_detCirigiaProce_2 = new DataTable();
            //DataTable listaRPT_detExamen_3 = new DataTable();
            //DataTable listaRPT_detExamen_4 = new DataTable();
            //DataTable listaRPT_detExamen_5 = new DataTable();


            string tura = Server.MapPath("rptReports/rptViewFichaAnestesia1_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewFichaAnestesia1_FE.rpt"));


            listaRPT = rptVistas_FE("rptViewFichaAnestesia_1_FE",
                    ENTITY_GLOBAL.Instance.UnidadReplicacion,
                    (int)ENTITY_GLOBAL.Instance.PacienteID,
                    (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                    (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                    ENTITY_GLOBAL.Instance.USUARIO);



            listaRPT_detExamen_1 = rptVistasExamenesAnestesiaDetalle_1_FE("rptViewFichaAnestesia_1_ExamenesDetalle_FE",
              ENTITY_GLOBAL.Instance.UnidadReplicacion,
              (int)ENTITY_GLOBAL.Instance.PacienteID,
              (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
              (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
              , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, 1);




            listaRPT_detDiagnstico_1 = rptVistasDiagnosticosAnestesiaDetalle_1_FE("rptViewFichaAnestesia_1_DiagnosticoDetalle_FE",
           ENTITY_GLOBAL.Instance.UnidadReplicacion,
           (int)ENTITY_GLOBAL.Instance.PacienteID,
           (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
           (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
           , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, 1);


            listaRPT_detExamen_2 = rptVistasExamenesAnestesiaDetalle_1_FE("rptViewFichaAnestesia_1_ExamenesDetalle_FE",
            ENTITY_GLOBAL.Instance.UnidadReplicacion,
            (int)ENTITY_GLOBAL.Instance.PacienteID,
            (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
            (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
            , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, 2);


            listaRPT_detDiagnsticoPost_2 = rptVistasDiagnosticosAnestesiaDetalle_1_FE("rptViewFichaAnestesia_1_DiagnosticoDetalle_FE",
           ENTITY_GLOBAL.Instance.UnidadReplicacion,
           (int)ENTITY_GLOBAL.Instance.PacienteID,
           (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
           (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
           , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, 3);




            listaRPT_detExamen_3 = rptVistasExamenesAnestesiaDetalle_1_FE("rptViewFichaAnestesia_1_ExamenesDetalle_FE",
           ENTITY_GLOBAL.Instance.UnidadReplicacion,
           (int)ENTITY_GLOBAL.Instance.PacienteID,
           (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
           (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
           , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, 3);


            Rpt.Subreports["rptViewFichaAnestesia_1_ExamenesDetalle_FE.rpt"].SetDataSource(listaRPT_detExamen_1);

            Rpt.Subreports["rptViewFichaAnestesia_1_DiagnosticosDetalle_FE.rpt"].SetDataSource(listaRPT_detDiagnstico_1);

            Rpt.Subreports["rptViewFichaAnestesia_1_ExamenesDetalle_FE.rpt - 01"].SetDataSource(listaRPT_detExamen_2);


            Rpt.Subreports["rptViewFichaAnestesia_1_DiagnosticosDetalle_FE.rpt - 01"].SetDataSource(listaRPT_detDiagnsticoPost_2);
            Rpt.Subreports["rptViewFichaAnestesia_1_ExamenesDetalle_FE.rpt - 02"].SetDataSource(listaRPT_detExamen_3);

            //Datos Generales
            setDatosGenerales();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);



            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "AnteFamiliar");
                    }
                    catch (Exception ex) { Log.Error(ex, ex.Message); throw; }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);



        }






        #endregion



        #region CCEP_REPORTE


        private void GenerarReporteFichaAnestesia_3_FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteFichaAnestesia_3_FE - Entrar");


            DataTable listaRPT = new DataTable();

            string tura = Server.MapPath("rptReports/rptViewFichaAnestesia3.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewFichaAnestesia3.rpt"));


            listaRPT = rptVistas_FE("rptViewFichaAnestesia_3_FE",
                    ENTITY_GLOBAL.Instance.UnidadReplicacion,
                    (int)ENTITY_GLOBAL.Instance.PacienteID,
                    (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                    (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                    , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                    ENTITY_GLOBAL.Instance.USUARIO);

            //Datos Generales
            setDatosGenerales();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


            imgAnestesia1 = Server.MapPath("Imagen/bocaanestesia.png");
            Rpt.SetParameterValue("imgAnestesia1", imgAnestesia1);

            imgAnestesia2 = Server.MapPath("Imagen/bocaanestesia.png");
            Rpt.SetParameterValue("imgAnestesia2", imgAnestesia2);

            imgAnestesia3 = Server.MapPath("Imagen/bocaanestesia.png");
            Rpt.SetParameterValue("imgAnestesia3", imgAnestesia3);

            imgAnestesia4 = Server.MapPath("Imagen/bocaanestesia.png");
            Rpt.SetParameterValue("imgAnestesia4", imgAnestesia4);



            Rpt.SetDataSource(listaRPT);
            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "AnteFamiliar");
                    }
                    catch (Exception ex) { Log.Error(ex, ex.Message); throw; }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            Rpt.SetParameterValue("imgAnestesia1", imgAnestesia1);
            Rpt.SetParameterValue("imgAnestesia2", imgAnestesia2);
            Rpt.SetParameterValue("imgAnestesia3", imgAnestesia3);
            Rpt.SetParameterValue("imgAnestesia4", imgAnestesia4);




        }


        #endregion



        #region CCEPF402_REPORTE

        private void GenerarReporteBalanceHidroElectrolitico_FE(string tipoVista, int TipoBalance)
        {
            Log.Information("VisorReportesHCE - GenerarReporteBalanceHidroElectrolitico_FE - Entrar");

            //NEO
            if (TipoBalance == 1)
            {
                string tura = Server.MapPath("rptReports/rptViewBalanceHidroElectrolitico_FE.rpt");
                Rpt.Load(Server.MapPath("rptReports/rptViewBalanceHidroElectrolitico_FE.rpt"));
            }
            //SOP
            else if (TipoBalance == 2)
            {
                string tura = Server.MapPath("rptReports/rptViewBalanceHidroElectrolitico_SOP_FE.rpt");
                Rpt.Load(Server.MapPath("rptReports/rptViewBalanceHidroElectrolitico_SOP_FE.rpt"));
            }
            //PEDIATRICO
            else if (TipoBalance == 3)
            {
                string tura = Server.MapPath("rptReports/rptViewBalanceHidroElectrolitico_PEDIATRICO_FE.rpt");
                Rpt.Load(Server.MapPath("rptReports/rptViewBalanceHidroElectrolitico_PEDIATRICO_FE.rpt"));
            }
            //NORMAL
            else if (TipoBalance == 4)
            {
                string tura = Server.MapPath("rptReports/rptViewBalanceHidroElectrolitico_NORMAL_FE.rpt");
                Rpt.Load(Server.MapPath("rptReports/rptViewBalanceHidroElectrolitico_NORMAL_FE.rpt"));
            }

            DataTable listaRPT = new DataTable();
            DataTable listaRPT_detalle1 = new DataTable();
            DataTable listaRPT_detalle2 = new DataTable();

            listaRPT = rptVistasBalanceHidroElectro_FE("rptViewBalanceHidroElectrolitico_FE",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, TipoBalance);

            listaRPT_detalle1 = rptVistasBalanceHidroElectroDetalles_FE("rptViewBalanceHidroElectroliticoDetalle1_FE",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, TipoBalance, 1);

            listaRPT_detalle2 = rptVistasBalanceHidroElectroDetalles_FE("rptViewBalanceHidroElectroliticoDetalle2_FE",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO, TipoBalance, 2);

            Rpt.Subreports["rptViewBalanceHidroElectroliticoDetalle1.rpt"].SetDataSource(listaRPT_detalle1);
            Rpt.Subreports["rptViewBalanceHidroElectroliticoDetalle2.rpt"].SetDataSource(listaRPT_detalle2);


            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }


        }

        #endregion


        private void GenerarReporterptViewPreOperatorio1(string tipovista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewPreOperatorio1 - Entrar");
            string tura = Server.MapPath("rptReports/rptViewPreOperatorio_1_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewPreOperatorio_1_FE.rpt"));


            DataTable listaRPT = new DataTable();

            listaRPT = rptVistas_FE("rptViewPreOperatorio_1_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                        null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);



            //Datos generales
            setDatosGenerales();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {

                if (tipovista == "I")
                {

                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DIAGNOSTICO");


                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);



                }

            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }


        private void GenerarReporterptViewPreOperatorio2(string tipovista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewPreOperatorio2 - Entrar");

            string tura = Server.MapPath("rptReports/rptViewPreOperatorio2.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewPreOperatorio2.rpt"));


            DataTable listaRPT = new DataTable();

            listaRPT = rptVistas_FE("rptViewPreOperatorio2", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                        null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);



            //Datos generales
            setDatosGenerales();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {

                if (tipovista == "I")
                {

                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DIAGNOSTICO");


                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);



                }

            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }

        private void GenerarReporterptViewKardex3(string tipovista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewKardex3 - Entrar");

            string tura = Server.MapPath("rptReports/rptViewKardex3.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewKardex3.rpt"));


            DataTable listaRPT = new DataTable();

            listaRPT = rptVistas_FE("rptViewKardex3", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                        null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);



            //Datos generales
            setDatosGenerales();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {

                if (tipovista == "I")
                {

                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DIAGNOSTICO");


                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);



                }

            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }

        private void GenerarReporteFichadeAnestesia2(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteFichadeAnestesia2 - Entrar");
            string tura = Server.MapPath("rptReports/rptViewFichaAnestesia2.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewFichaAnestesia2.rpt"));
            DataTable listaRPT = new DataTable();

            listaRPT = rptVistas_FE("rptViewFichaAnestesia2", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //DataSet obj = new DataSet();
            //dsRptViewer.Tables.Add(objTabla1.Copy());
            //dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));
            //Datos Generales
            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }


        }

        private void GenerarReporteFichadeAnestesia5(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteFichadeAnestesia5 - Entrar");
            string tura = Server.MapPath("rptReports/rptViewFichaAnestesia5.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewFichaAnestesia5.rpt"));
            DataTable listaRPT = new DataTable();

            listaRPT = rptVistas_FE("rptViewFichaAnestesia5", ENTITY_GLOBAL.Instance.UnidadReplicacion, (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico, (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //DataSet obj = new DataSet();
            //dsRptViewer.Tables.Add(objTabla1.Copy());
            //dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));
            //Datos Generales
            setDatosGenerales();
            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
                return;
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
                Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            }


        }
        private void GenerarReporteEpicrisis_1FE(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteFichadeAnestesia5 - Entrar");

            string tura = Server.MapPath("rptReports/rptViewEpicrisis_1FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewEpicrisis_1FE.rpt"));

            DataTable listaRPT = new DataTable();
            DataTable listaRPT_Pac_Med = new DataTable();
            DataTable listaRPT_Diagnostico = new DataTable();
            DataTable listaRPT_Principal = new DataTable();
            DataTable listaRPT_Secundario = new DataTable();
            DataTable listaRPT_Interconsulta = new DataTable();

            listaRPT = rptVistas_FE("rptViewEpicrisis_1FE",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                ENTITY_GLOBAL.Instance.USUARIO);


            listaRPT_Diagnostico = rptVistas_FE("rptViewEpicrisis3_Diagnostico_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                        null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            listaRPT_Principal = rptVistas_FE("rptViewEpicrisis3_Principal_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                       (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                       (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                       null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            listaRPT_Secundario = rptVistas_FE("rptViewEpicrisis3_Secundaria_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                   (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                   (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                   null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            listaRPT_Interconsulta = rptVistas_FE("SS_HC_InterConsulta_Epricrisis3_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                                 (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                                 (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                                 null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            //Datos generales
            setDatosGenerales();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            Rpt.Subreports["rptViewEpicrisis3_Diagnostico_FE.rpt"].SetDataSource(listaRPT_Diagnostico);
            Rpt.Subreports["rptViewEpicrisis3_Principal_FE.rpt"].SetDataSource(listaRPT_Principal);
            Rpt.Subreports["rptViewEpicrisis3_Secundaria_FE.rpt"].SetDataSource(listaRPT_Secundario);
            Rpt.Subreports["rptViewInterConsulta_Epicrisis1_FE.rpt"].SetDataSource(listaRPT_Interconsulta);

            if (listaRPT.Rows.Count == 0 /*&& listaRPT_2.Count == 0*/)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            //Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


        }
        private void GenerarReporteEpicrisis2_Fe(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteEpicrisis2_Fe - Entrar");

            string tura = Server.MapPath("rptReports/rptViewEpicrisis2_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewEpicrisis2_FE.rpt"));
            DataTable listaRPT = new DataTable();
            DataTable listaRPT_Pac_Med = new DataTable();
            listaRPT = rptVistas_FE("rptViewMedicamentos_Epi2_FE",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                ENTITY_GLOBAL.Instance.USUARIO);
            /*Datos Paciente -Medico*/
            listaRPT_Pac_Med = rptDatosPacienteMedico_FE("rptViewDatosPaciente_Medico",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                ENTITY_GLOBAL.Instance.USUARIO);

            //Rpt.SetDataSource(listaRPT);
            //DataSet obj = new DataSet();
            //dsRptViewer.Tables.Add(objTabla1.Copy());
            //dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit> listaRPT_1 = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit>();
            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_Epi2_FE_Edit> listaRPT_2 = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_Epi2_FE_Edit>();


            listaRPT_1 = getDatarptViewMedicamentos_FE("REPORTEA",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                ENTITY_GLOBAL.Instance.USUARIO, 1);
            Rpt.Subreports["rptViewMedicamentos_FEDetalle1.rpt"].SetDataSource(listaRPT_1);


            //Rpt.Subreports["rptViewMedicamentos_FEsubrepFirmas.rpt"].SetDataSource(listaRPT_Pac_Med);

            Rpt.Subreports["rptViewMedicamentos_Epi2_Detalle.rpt"].SetDataSource(listaRPT);

            //Rpt.SetDataSource(listaRPT);
            setDatosGenerales();


            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            if (listaRPT_1.Count == 0 /*&& listaRPT_2.Count == 0*/)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            //Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


        }

        private void GenerarReporteAnestesia4_Fe(string tipoVista)
        {
            Log.Information("VisorReportesHCE - GenerarReporteAnestesia4_Fe - Entrar");

            string tura = Server.MapPath("rptReports/rptViewAnestesia4_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewAnestesia4_FE.rpt"));
            DataTable listaRPT = new DataTable();
            DataTable listaRPT_Anestesia4_1 = new DataTable();
            DataTable listaRPT_Anestesia4_2 = new DataTable();
            DataTable listaRPT_Anestesia4_3 = new DataTable();
            listaRPT = rptVistas_FE("rptViewAnestesia4_FE",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                ENTITY_GLOBAL.Instance.USUARIO);
            /*Datos Medicamentos*/
            listaRPT_Anestesia4_1 = rptVistasM_FE("rptViewAnestesia4_Farmacos_Detalle_FE",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                ENTITY_GLOBAL.Instance.USUARIO, 1);
            listaRPT_Anestesia4_2 = rptVistasM_FE("rptViewAnestesia4_Farmacos_Detalle_FE",
               ENTITY_GLOBAL.Instance.UnidadReplicacion,
               (int)ENTITY_GLOBAL.Instance.PacienteID,
               (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
               (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
               , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
               ENTITY_GLOBAL.Instance.USUARIO, 2);
            listaRPT_Anestesia4_3 = rptVistasM_FE("rptViewAnestesia4_Farmacos_Detalle_FE",
               ENTITY_GLOBAL.Instance.UnidadReplicacion,
               (int)ENTITY_GLOBAL.Instance.PacienteID,
               (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
               (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
               , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
               ENTITY_GLOBAL.Instance.USUARIO, 3);

            //Rpt.SetDataSource(listaRPT);
            //DataSet obj = new DataSet();
            //dsRptViewer.Tables.Add(objTabla1.Copy());
            //dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));
            List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit> listaRPT_1 = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_FEEdit>();
            //List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_Epi2_FE_Edit> listaRPT_2 = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_Epi2_FE_Edit>();

            listaRPT_1 = getDatarptViewMedicamentos_FE("REPORTEA",
                ENTITY_GLOBAL.Instance.UnidadReplicacion,
                (int)ENTITY_GLOBAL.Instance.PacienteID,
                (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                (long)ENTITY_GLOBAL.Instance.EpisodioAtencion
                , null, 0, ENTITY_GLOBAL.Instance.CONCEPTO,
                ENTITY_GLOBAL.Instance.USUARIO, 1);
            Rpt.Subreports["rptViewAnestesia4_Detalle1.rpt"].SetDataSource(listaRPT_Anestesia4_1);
            Rpt.Subreports["rptViewAnestesia4_Detalle2.rpt"].SetDataSource(listaRPT_Anestesia4_2);
            Rpt.Subreports["rptViewAnestesia4_Detalle3.rpt"].SetDataSource(listaRPT_Anestesia4_3);


            Rpt.SetDataSource(listaRPT);
            setDatosGenerales();


            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            if (listaRPT_1.Count == 0 /*&& listaRPT_2.Count == 0*/)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipoVista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        ;
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DESCANSOMEDICO");
                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    } Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


                }
            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);

            //Rpt.SetParameterValue("imgIzquierda", imgIzquierda);


        }

        private void GenerarReporterptViewEpicrisis3(string tipovista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewEpicrisis3 - Entrar");

            string tura = Server.MapPath("rptReports/rptViewEpicrisis3_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewEpicrisis3_FE.rpt"));


            DataTable listaRPT = new DataTable();

            DataTable listaRPTMedicamentosEpi3 = new DataTable();

            DataTable listaRPT_Diagnostico = new DataTable();
            DataTable listaRPT_Principal = new DataTable();
            DataTable listaRPT_Secundario = new DataTable();

            listaRPT = rptVistas_FE("rptViewEpicrisis3_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                        null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            listaRPTMedicamentosEpi3 = rptVistas_FE("rptViewMedicamentosEpicrisis3_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                        null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            listaRPT_Diagnostico = rptVistas_FE("rptViewEpicrisis3_Diagnostico_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                        null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            listaRPT_Principal = rptVistas_FE("rptViewEpicrisis3_Principal_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                       (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                       (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                       null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            listaRPT_Secundario = rptVistas_FE("rptViewEpicrisis3_Secundaria_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                   (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                   (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                   null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);





            //Datos generales
            setDatosGenerales();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);
            Rpt.Subreports["rptViewEpicrisis3DetMedicamentos_FE.rpt"].SetDataSource(listaRPTMedicamentosEpi3);
            Rpt.Subreports["rptViewEpicrisis3_Diagnostico_FE.rpt"].SetDataSource(listaRPT_Diagnostico);
            Rpt.Subreports["rptViewEpicrisis3_Principal_FE.rpt"].SetDataSource(listaRPT_Principal);
            Rpt.Subreports["rptViewEpicrisis3_Secundaria_FE.rpt"].SetDataSource(listaRPT_Secundario);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {

                if (tipovista == "I")
                {

                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DIAGNOSTICO");


                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);



                }

            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }
        /***********************************/
        private void GenerarReporterptViewKardex2(string tipovista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewKardex2 - Entrar");
            string tura = Server.MapPath("rptReports/rptViewKardex2_FE.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewKardex2_FE.rpt"));


            DataTable listaRPT = new DataTable();
            DataTable listaRPT_Examen = new DataTable();
            DataTable listaRPT_Interconsulta = new DataTable();


            //listaRPT = rptVistas_FE("rptViewKardex2_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion,
            //            (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
            //            (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
            //            null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            listaRPT_Examen = rptVistas_FE("rptViewExamen_Kardex_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                        null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            listaRPT_Interconsulta = rptVistas_FE("rptViewInterConsulta_Kardex_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                       (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                       (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                       null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);






            //Datos generales
            setDatosGenerales();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            //Rpt.SetDataSource(listaRPT);
            Rpt.Subreports["rptViewExamen_Kardex_FE.rpt"].SetDataSource(listaRPT_Examen);
            Rpt.Subreports["rptViewInterConsulta_Kardex_FE.rpt"].SetDataSource(listaRPT_Interconsulta);


            if (listaRPT_Examen.Rows.Count == 0 && listaRPT_Interconsulta.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {

                if (tipovista == "I")
                {

                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();

                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DIAGNOSTICO");


                    }
                    catch (Exception ex)
                    {
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);



                }

            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }


        private void GenerarReporterptViewKardex1(string tipovista)
        {
            Log.Information("VisorReportesHCE - GenerarReporterptViewKardex1 - Entrar");
            string tura = Server.MapPath("rptReports/rptViewKardex1.rpt");
            Rpt.Load(Server.MapPath("rptReports/rptViewKardex1.rpt"));

            DataTable listaRPT = new DataTable();
            DataTable listaRPT_1 = new DataTable();
            DataTable listaRPT_2 = new DataTable();
            DataTable listaRPT_3 = new DataTable();
            DataTable listaRPT_4 = new DataTable();
            DataTable listaRPT_5 = new DataTable();
            DataTable listaRPT_6 = new DataTable();

            listaRPT = rptVistas_FE("rptviewkardex1", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                        null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            Rpt.SetDataSource(listaRPT);
            //DataSet obj = new DataSet();
            //dsRptViewer.Tables.Add(objTabla1.Copy());
            //dsRptViewer.WriteXmlSchema((Server.MapPath("Xmls/xmlViewAnamnesisEA.xml")));

            listaRPT_1 = rptVistas_FE("rptViewKardex3", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                        (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                        (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                        null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            Rpt.Subreports["rptViewKarderx3subrep.rpt"].SetDataSource(listaRPT_1);

            listaRPT_2 = rptVistas_FE("rptViewKardex1_Detalle1", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                       (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                       (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                       null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            Rpt.Subreports["rptViewKardex1_Detalle1.rpt"].SetDataSource(listaRPT_2);

            listaRPT_3 = rptVistas_FE("rptViewDieta_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                       (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                       (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                       null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            Rpt.Subreports["rptViewDieta_FEDetalle2.rpt"].SetDataSource(listaRPT_3);

            listaRPT_4 = rptVistas_FE("rptViewDieta_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                       (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                       (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                       null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            Rpt.Subreports["rptViewDieta_FEDetalle1.rpt"].SetDataSource(listaRPT_4);

            listaRPT_5 = rptVistas_FENA("rptViewDiagnostico_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                       (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                //(long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                       1,
                       null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            Rpt.Subreports["rptViewDiagnostico_FEsubrep.rpt"].SetDataSource(listaRPT_5);

            listaRPT_6 = rptVistas_FE("rptViewAlergias_FE", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                       (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                       (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                       null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);
            Rpt.Subreports["rptViewAlergia_FEsubrep.rpt"].SetDataSource(listaRPT_6);
            Rpt.SetDataSource(listaRPT);
            //Datos generales
            setDatosGenerales();

            imgIzquierda = Server.MapPath("Imagen/Logo.png");
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
            Rpt.SetDataSource(listaRPT);

            if (listaRPT.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Mensaje", string.Format("Mensaje('{0}');", "NO HAY INFORMACION"), true);
            }
            else
            {
                if (tipovista == "I")
                {
                    ReportViewer.ReportSource = Rpt;
                    ReportViewer.DataBind();
                }
                else
                {
                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    try
                    {
                        Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                        Rpt.ExportToHttpResponse
                        (CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "DIAGNOSTICO");

                    }
                    catch (Exception ex)
                    {
                        Log.Error(ex, ex.Message);
                        throw;
                    }
                    Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
                }

            }
            Rpt.SetParameterValue("imgIzquierda", imgIzquierda);
        }

        public static DataTable rptVistasM_FE(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion, string var, int va, string CONCEPTO, string Usuario, int Tipo)
        {
            Log.Information("VisorReportesHCE - rptVistasM_FE - Entrar");
            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                conx.Open();
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and IdEpisodioAtencion=" + EpisodioAtencion + " and Tipo=" + Tipo + " ORDER BY Accion ASC";
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "MedicamentoAnestesia4");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }


        private List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_Epi2_FE_Edit> getDatarptViewMedicamentos_Epi2_Detalle_FE(String accion, String unidadReplicacion, int idPaciente, int epiClinico, long idEpiAtencion, SoluccionSalud.RepositoryReport.Entidades.rptViewAgrupadorEdit objEntidad, int idImpresionLog, string codFormato, string codUsuario, int tipomedicamento)
        {
            Log.Information("VisorReportesHCE - getDatarptViewMedicamentos_Epi2_Detalle_FE - Entrar");

            List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_Epi2_FE_Edit> listaRPT = new List<SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_Epi2_FE_Edit>();

            List<rptViewMedicamentos_Epi2_FE> rptViewMedicamentos_FE = new List<rptViewMedicamentos_Epi2_FE>();
            SS_HC_Medicamento_FE ObjMedicamento_FE = new SS_HC_Medicamento_FE();
            ObjMedicamento_FE.UnidadReplicacion = unidadReplicacion;
            ObjMedicamento_FE.IdPaciente = idPaciente;
            ObjMedicamento_FE.EpisodioClinico = epiClinico;
            ObjMedicamento_FE.IdEpisodioAtencion = idEpiAtencion;
            ObjMedicamento_FE.Accion = "REPORTEA";
            rptViewMedicamentos_FE = ServiceReportes.rptViewMedicamentos_Epi2_FE(ObjMedicamento_FE, 0, 0, tipomedicamento);
            //AAAA
            objTabla1 = new System.Data.DataTable();

            SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_Epi2_FE_Edit objRPT;
            if (rptViewMedicamentos_FE != null)
            {
                foreach (rptViewMedicamentos_Epi2_FE objReport in rptViewMedicamentos_FE) // Loop through List with foreach.
                {
                    objRPT = new SoluccionSalud.RepositoryReport.Entidades.rptViewMedicamentos_Epi2_FE_Edit();
                    objRPT.IdUnidadMedida = Convert.ToInt32(objReport.IdUnidadMedida);

                    if (objReport.Frecuencia != null)
                    {
                        objRPT.Frecuencia =/* Convert.ToInt32(*/(decimal)objReport.Frecuencia/*)*/;
                    }
                    else
                    {
                        objRPT.Frecuencia = Convert.ToInt32(objReport.Frecuencia);
                    }
                    objRPT.MED_DCI = objReport.MED_DCI;
                    objRPT.Comentario = objReport.Comentario;
                    objRPT.Presentacion = objReport.Presentacion;
                    objRPT.Dosis = objReport.Dosis;
                    objRPT.UnidMedDesc = objReport.UnidMedDesc;
                    objRPT.TipoComida = Convert.ToInt32(objReport.TipoComida);
                    objRPT.UndTiempoFre = objReport.UndTiempoFre;
                    objRPT.Periodo = objReport.Periodo;
                    objRPT.UndTiempoPeri = objReport.UndTiempoPeri;
                    objRPT.ViaDesc = objReport.ViaDesc;
                    objRPT.Cantidad = Convert.ToInt32(objReport.Cantidad);
                    objRPT.TipRecetaDes = objReport.TipRecetaDes;
                    objRPT.Indicacion = objReport.Indicacion;
                    objRPT.NombreCompleto = objReport.NombreCompleto;
                    objRPT.TipoTrabajadorDesc = objReport.TipoTrabajadorDesc;
                    objRPT.Sexo = objReport.Sexo;
                    objRPT.CodigoOA = objReport.CodigoOA;
                    objRPT.PersonaEdad = Convert.ToInt32(objReport.PersonaEdad);
                    objRPT.UnidadServicioDesc = objReport.UnidadServicioDesc;
                    objRPT.PersMedicoNombreCompleto = objReport.PersMedicoNombreCompleto;
                    objRPT.DescripcionLarga = objReport.DescripcionLarga;
                    objRPT.DescripcionLocal = objReport.DescripcionLocal;
                    objRPT.DireccionComun = objReport.DireccionComun;
                    objRPT.DocumentoFiscal = objReport.DocumentoFiscal;
                    objRPT.FechaCreacion = Convert.ToDateTime(objReport.FechaCreacion);
                    objRPT.TITULAR = objReport.TITULAR;
                    objRPT.VIGENCIA = objReport.VIGENCIA;
                    objRPT.POLIZA = objReport.POLIZA;
                    objRPT.ASEGURADORA = objReport.ASEGURADORA;
                    objRPT.EMPLEADORA = objReport.EMPLEADORA;
                    objRPT.DCI = objReport.DCI;
                    objRPT.Nombre = objReport.Nombre;
                    objRPT.DiagnosticoDesc = objReport.DiagnosticoDesc;
                    objRPT.UsuarioAuditoria = objReport.UsuarioAuditoria;
                    listaRPT.Add(objRPT);
                }
                ///////////////////////////////                     
                //PARA LA AUDITORIA DE IMPRESION
                if (rptViewMedicamentos_FE.Count > 0)
                {
                    setDataImpresionAuditoria(accion, idImpresionLog, objEntidad, codFormato, codUsuario);
                }
                /////////////////////////////// 
            }

            return listaRPT;

        }


        public static DataTable rptDatosMedicamentos_Epi2_FE(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion, string var, int va, string CONCEPTO, string Usuario)
        {
            Log.Information("VisorReportesHCE - rptDatosMedicamentos_Epi2_FE - Entrar");


            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                conx.Open();
                /* string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and IdEpisodioAtencion=" + EpisodioAtencion;*/
                string sql = @"SELECT * FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and IdEpisodioAtencion=" + EpisodioAtencion;//ADD 07.06.2017 OES Motivo
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "MedicamentoEpicrisis2");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }

        //Datos Generales del Triaje (Pie de Pagina)
        public void setDatosGeneralesTriaje()
        {
            Log.Information("VisorReportesHCE - setDatosGeneralesTriaje - Entrar");

            DataTable listarptAgrupador_FE = new DataTable();


            listarptAgrupador_FE = rptAgrupador_TRIAJE_FE("rptViewAgrupadorTriaje", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                         (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioTriaje,
                         (int)ENTITY_GLOBAL.Instance.EpisodioTriaje,
                         null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);



            //listarV_EpisodioAtencion = rptV_EpisodioAtencionesTriaje("rptViewAgrupador", ENTITY_GLOBAL.Instance.UnidadReplicacion,
            //         (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioTriaje
            //         );

            listarptAgrupador_FE.Columns.Add("TipoTrabajadorDesc", typeof(String));
            listarptAgrupador_FE.Columns.Add("UnidadServicioDesc", typeof(String));

            listarptAgrupador_FE.Rows[0]["TipoTrabajadorDesc"] = "Triaje";
            listarptAgrupador_FE.Rows[0]["UnidadServicioDesc"] = "Triaje de Emergencia";



            if (listarptAgrupador_FE.Rows.Count > 0)
            {
                Rpt.Subreports["rptDatosGeneralesFE_triaje.rpt"].DataSourceConnections.Clear();
                Rpt.Subreports["rptDatosGeneralesFE_triaje.rpt"].SetDataSource(listarptAgrupador_FE);
            }




        }





        //Datos Generales (Pie de Pagina)


        public void setDatosGenerales()
        {
            Log.Information("VisorReportesHCE - setDatosGenerales - Entrar");


            DataTable listarptAgrupador_FE = new DataTable();


            listarptAgrupador_FE = rptAgrupador_FE("rptViewAgrupador", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                         (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                         (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                         null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);


            if (listarptAgrupador_FE.Rows.Count > 0)
            {
                Rpt.Subreports["rptDatosGeneralesFE.rpt"].DataSourceConnections.Clear();
                Rpt.Subreports["rptDatosGeneralesFE.rpt"].SetDataSource(listarptAgrupador_FE);
            }





        }
        // ***  FIN FORMULARIOS (EXTRAS) ***


        public void setDatosGeneralesDispensacion()
        {
            Log.Information("VisorReportesHCE - setDatosGeneralesDispensacion - Entrar");


            DataTable listarptAgrupadorDispensacion_FE = new DataTable();


            listarptAgrupadorDispensacion_FE = rptAgrupadorDispensacion_FE("rptViewAgrupador", ENTITY_GLOBAL.Instance.UnidadReplicacion,
                         (int)ENTITY_GLOBAL.Instance.PacienteID, (int)ENTITY_GLOBAL.Instance.EpisodioClinico,
                         (long)ENTITY_GLOBAL.Instance.EpisodioAtencion,
                         null, 0, ENTITY_GLOBAL.Instance.CONCEPTO, ENTITY_GLOBAL.Instance.USUARIO);

            if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "")
            {
                nombrmedico = "Medico Tratante";
                // Rpt.Subreports["rptDatosGeneralesFE.rpt"].SetParameterValue("@nombremedico", nombrmedico);
            }
            else
            {
                nombrmedico = "Medico Tratante";
                //Rpt.Subreports["rptDatosGeneralesFE.rpt"].SetParameterValue("@nombremedico", nombrmedico);
            }

            if (listarptAgrupadorDispensacion_FE.Rows.Count > 0)
            {
                Rpt.Subreports["rptDatosGeneralesFE.rpt"].DataSourceConnections.Clear();
                Rpt.Subreports["rptDatosGeneralesFE.rpt"].SetDataSource(listarptAgrupadorDispensacion_FE);
            }
        }








        public static DataTable rptV_EpisodioAtenciones(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion)
        {
            Log.Information("VisorReportesHCE - rptV_EpisodioAtenciones - Entrar");

            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                var idvalorepisodio = "";
                if (ENTITY_GLOBAL.Instance.INDICADOR_EMER == "MED_EMERGENCIA") { idvalorepisodio = "IdEpisodioAtencion"; } else { idvalorepisodio = "Episodio_Atencion"; }
                conx.Open();
                string sql = @"SELECT Accion FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and " + idvalorepisodio + "=" + EpisodioAtencion + " and Accion <> 'CCEPF631' GROUP BY Accion "; //ADD 05.06.2017 ORLANDO
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "Agrupador");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }


        public static DataTable rptV_EpisodioAtencionesTriaje(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico)
        {
            Log.Information("VisorReportesHCE - rptV_EpisodioAtencionesTriaje - Entrar");


            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {

                conx.Open();
                string sql = @"SELECT Accion FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + " and (Accion= 'CCEPF631' or Accion='CCEPF630')" + "  GROUP BY Accion "; //ADD 05.06.2017 ORLANDO
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "Agrupador");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }



    }

}