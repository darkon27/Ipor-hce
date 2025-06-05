using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryReport;
namespace AppSaludMVC.Controllers
{
    using SvcSS_HC_CuerpoHumano = SoluccionSalud.Service.SS_HC_CuerpoHumanoService.SvcSS_HC_CuerpoHumano;
    using SvcTipoAtencion = SoluccionSalud.Service.AtencionService.SvcTipoAtencion;
    //using SvcSysRecursosValores = SoluccionSalud.Service.SYSRECURSOVALORESService.SvcSysRecursosValores;
    using SvcTABLAFORMATOVALIDACION = SoluccionSalud.Service.TABLAFORMATOVALIDACIONService.SvcTABLAFORMATOVALIDACION;
    using SvcRecursos = SoluccionSalud.Service.RecursosService.SvcRecursos;
    using SvcFavoritoDetalle = SoluccionSalud.Service.FavoritoDetalleService.SvcFavoritoDetalle;
    using SvcFavorito = SoluccionSalud.Service.FavoritoService.Svcfavorito;
    using SvcParametro = SoluccionSalud.Service.ParametroService.SvcParametro;
    using SvcModulos = SoluccionSalud.Service.ModuloService.SvcModulo;
    using SvcPaciente = SoluccionSalud.Service.VW_PERSONAPACIENTEService.SP_SS_GE_PacienteService;
    using SvcFormatoCampo = SoluccionSalud.Service.FormatoCampoService.SvcFormatoCampo;
    using SvcControlValidacion = SoluccionSalud.Service.ControlValidacionService.SvcControlValidacion;
    using SvcUnidadMedidaMinsa = SoluccionSalud.Service.UnidadMedidaMinsaService.SvcUnidadMedidaMinsa;
    using SvcFormato = SoluccionSalud.Service.FormatoService.SvcFormato;
    using SvcHeaderMiscelaneo = SoluccionSalud.Service.DetalleMiscelaneoService.SvcMiscelaneoHeader;
    using SvcNic = SoluccionSalud.Service.NicService.SvcNic;
    using SvcNoc = SoluccionSalud.Service.NocService.SvcNoc;
    using SvcDominio = SoluccionSalud.Service.DominioService.SvcDominio;
    using SvcClase = SoluccionSalud.Service.ClaseService.SvcClase;
    using SvcActividades = SoluccionSalud.Service.ActividadesService.SvcActividades;
    using SvcNanda = SoluccionSalud.Service.NandaService.SvcNanda;
    using SvcFactorRelacionadoNanda = SoluccionSalud.Service.FactorRelacionadoNandaService.SvcFactorRelacionadoNanda;
    using SvcNocNanda = SoluccionSalud.Service.NocNandaService.SvcNocNanda;
    using SvcNocNic = SoluccionSalud.Service.NocNicService.SvcNocNic;
    using SvcNicActividad = SoluccionSalud.Service.NicActividadService.SvcNicActividad;
    using SvcNocIndicador = SoluccionSalud.Service.NocIndicadorService.SvcNocIndicador;
    using SvcIndicador = SoluccionSalud.Service.IndicadorService.SvcIndicador;
    using SvcFactorRelacionado = SoluccionSalud.Service.FactorRelacionadoService.SvcFactorRelacionado;
    using SvcCobertura = SoluccionSalud.Service.CoberturaService.SvcCobertura;
    using SvcFavoritoNumero = SoluccionSalud.Service.FavoritoNumeroService.SvcFavoritoNumero;
    using SvcFavoritoCodigo = SoluccionSalud.Service.FavoritoCodigoService.SvcFavoritoCodigo;
    using SvcProcMedDos = SoluccionSalud.Service.ProcMedDosService.SvcProcMedDos;
    using SvcProcedimiento = SoluccionSalud.Service.ProcedimientoService.SvcProcedimiento;
    using SvcSG_AgenteOpcion = SoluccionSalud.Service.SG_AgenteOpcionService.SvcSG_AgenteOpcion;
    using SvcSG_Agente = SoluccionSalud.Service.SG_AgenteService.SvcSG_Agente;
    using SvcSG_Opcion = SoluccionSalud.Service.SG_OpcionService.SvcSG_Opcion;
    //using SvcSS_HC_NANDA = SoluccionSalud.Service.SS_HC_NANDAService.SvcSS_HC_NANDA;
    using SvcEstablecimiento = SoluccionSalud.Service.EstablecimientoService.SvcEstablecimiento;
    using SvcDiagnostico = SoluccionSalud.Service.DiagnosticoService.SvcDiagnostico;
    using SvcPersonaMast = SoluccionSalud.Service.PersonaMastService.SvcPersonaMast;
    using SvcCategoriaUnidadServicio = SoluccionSalud.Service.CategoriaUnidadServicioService.SvcCategoriaUnidadServicio;
    using SvcServicios = SoluccionSalud.Service.ServiciosService.SvcServicios;
    using SvcUnidadServicio = SoluccionSalud.Service.UnidadServicioService.SvcUnidadServicio;
    using SvcSSHCUbicacion = SoluccionSalud.Service.SSHCUbicacionService.SvcSSHCUbicacion;
    using SvcRegistroAcompanante = SoluccionSalud.Service.RegistrarAcompananteService.SvcRegistroAcompanante;
    using SvcMedicamentos = SoluccionSalud.Service.MedicamentosService.SvcMedicamentos;
    public class UTILES_MENSAJES
    {
        /****PARAMETROS*****/
        public static string PARAM_OPER_esParam = "@@";
        public static Dictionary<String, Object> DICT_PARAMETROS = new Dictionary<String, Object>();
        public static Dictionary<String, Object> DICT_FILESbytes = new Dictionary<String, Object>();
        public static string PARAM_COLOROBLIGA_FORM = null;

        /****CONSTANTES DE LOS FORMULARIOS (CÓDIGOS)*****/
        public static string PATH_MAIN_HCLINICA = "HClinica/";
        public static string PATH_MAIN_BANDEJAMED = "BandejaMedico/";
        public static string PATH_MAIN_GESTION = "Gestion/";
        public static string PATH_MAIN_LOGIN = "Login/";

        public static int ESTADO_EPI_ANULADO = 1;
        public static int ESTADO_EPI_ENATENCION = 2;
        public static int ESTADO_EPI_ATENDIDO = 3;        
        public static int ESTADO_EPI_PENDIENTE = 4;        


        public static string FORM_DIAGNOSTICO_F1 = "CCEP0253";
        public static string FORM_ANAMNESIS_EA_F1 = "CCEP0003";
        public static string FORM_ANAMNESIS_EP_F1 = "CCEP0004";
        public static string FORM_DIETAS_MNUT_F1 = "CCEP0303";
        public static string FORM_MEDICAMENTOS_F1 = "CCEP0304";
        public static string FORM_EVOL_OBJETIVA_F1 = "CCEP2010";
        //ADD NUEVOS
        public static string FORM_DIAGNOSTICO_F2 = "CCEP0F90";

        public static string FORM_NOTAENFERMERIA = "CCEPF328";

        public static string FORM_EVOL_OBJETIVA_F2 = "CCEPF080";
        public static string FORM_MEDICAMENTOS_F2 = "CCEPF101";
         
        public static string FORM_MEDRECTAGRUPAL_F2 = "CCEP9919MEDICA";

        public static string FORM_MEDICAMENTOS_F2ALTAMATMED = "CCEPF201METERIALMED";
        

        public static string FORM_MEDICAMENTOSEPICRISIS_F2 = "CCEPF201_3";

        public static string FORM_MEDICAMENTOS_NO_FARMACOLOGICOS_F2 = "CCEPF103";
        public static string FORM_MED_EPICRISIS201_3_F2 = "CCEPF201_3";
        public static string FORM_MED_INFORMEALTA_F2 = "CCEPF200";

        public static string FORM_MED_INFORMEALTA_F2DIAG = "CCEPF200D";
        public static string FORM_MED_INFORMEALTA_F2EXA = "CCEPF200EXA";

        public static string FORM_DIETAS_MNUT_F2 = "CCEPF100";


          public static string FORM_MED_EPICRISIS201_1_F2 = "CCEPF201_1";
           
        public static string FORM_INFORMEALTA_TRATAMIENTO_F2 = "CCEPF201";
        public static string FORM_RECETAGRUPAL_F2 = "CCEP9919";

        public static string FORM_MED_EPICRISIS201_1_F2EXA = "CCEPF201_1_EXA";


        public static string FORM_EXAMENSOLICITADO_F2 = "CCEPF150";
        public static string FORM_INTERCONSULTAS = "CCEPF151";
        public static string FORM_ALERGIAS = "CCEP00F2";
        public static string FORM_FISIOLOGICOS = "CCEP00F3";
        public static string FORM_PATOLOGICOS_GE = "CCEPF006";
        public static string FORM_FISIOLOGICOS_PE = "CCEPF004";
        public static string FORM_ANTECEDENTES_FA = "CCEPF014";
        


        /****FORMU_VALIDACIONES*****/
        public static string FORM_MSTCUERPOHUMANO = "form_mstcuerpohumano";
        public static string FORM_MSTAGENTE = "form_mstAgente";
        public static string FORM_MSTAGENTEOPCION = "form_mstAgenteOpcion";
        public static string FORM_MSTTIPOATENCION = "form_msttipoatencion";
        public static string FORM_MSTCOBERTURA = "form_mstcobertura";
        public static string FORM_MSTSUCURSAL = "form_mstsucursal";
        public static string FORM_MSTOPCIONES = "form_mstopciones";
        public static string FORM_MSTFORMATO = "form_mstformato";
        public static string FORM_MSTDATO = "form_mstdato";
        public static string FORM_MSTNIC = "form_mstnic";
        public static string FORM_MSTNOC2 = "form_mstnoc2";
        public static string FORM_MSTDOMINIOPAE = "form_mstdominiopae";
        public static string FORM_MSTCLASEPAE = "form_mstclasepae";
        public static string FORM_MSTACTIVIDADES = "form_mstactividades";
        public static string FORM_MSTINDICADORPAE = "form_mstindicadorpae";
        public static string FORM_MSTNANDA = "form_mstnanda";
        public static string FORM_MSTUNIDADMEDIDAMINSA = "form_mstunidadmedidaminsa";  
        public static string FORM_MSTFACTORRELACIONADO = "form_mstfactorrelacionado";
        public static string FORM_MSTFACTORRELACIONADONANDA = "form_mstfactorrelacionadonanda";
        public static string FORM_MSTNOCNANDA = "form_mstnocnanda";
        public static string FORM_MSTNOCNIC = "form_mstnocnic";
        public static string FORM_MSTNOCINDICADOR = "form_mstnocindicador";
        public static string FORM_MSTNICACTIVIDAD = "form_mstnicactividad";
        public static string FORM_MSDIAGNOSTICO = "form_msdiagnostico";
        public static string FORM_MSMEDICAMENTOS = "form_msmedicamentos";
        public static string FORM_MSMEDICAMENTOSMINSA = "form_msmedicamentosminsa";
        public static string FORM_MSCIAP = "form_msciap";
        public static string FORM_MSPROCEDIMIENTO = "form_msprocedimiento";
        public static string FORM_MSCUIDADO = "form_mscuidado";
        public static string FORM_MSRECURSO = "form_msrecurso";
        //public static string FORM_MSTNANDA = "form_mstnanda";
        public static string FORM_MSTVWASIGMED = "form_mstvwasigmed";
        public static string FORM_MSTREGISTRARACOMPANANTE = "form_mstregistraracompanante";
        public static string FORM_MSESTABLECIMIENTO = "form_msestablecimiento";
        public static string FORM_MSMODULO = "form_msmodulo";
        public static string FORM_MSFORMATOCAMPO = "form_msformatocampo";
        public static string FORM_MSTPERSONA = "form_mspersona";
        public static string FORM_MSFAVORITONUMERO = "form_msfavoritonumero";
        public static string FORM_MSCONTROLVALIDACION = "form_mscontrolvalidacion";
        public static string FORM_MSFAVCODIGO = "form_msfavcodigo";
        public static string FORM_MSFAVORITO = "form_msfavorito";
        public static string FORM_MSTPARAMETRO = "form_mstparametro";
        public static string FORM_MSFAVORITODETALLE = "form_msfavoritodetalle";
        public static string FORM_MSCIAPDOS = "form_msciapdos";
        public static string FORM_MSMISCELANEODET = "form_msmiscelaneodet";
        public static string FORM_MSMISCELANEOHED = "form_msmiscelaneohed";
        public static string FORM_MSPACIENTE = "form_mspaciente";
        public static string FORM_MSTMEDICO = "form_mstmedico";
        public static string FORM_MSTCATUNIDADSERVICIO = "form_mstcatunidadservicio";
        public static string FORM_MSTSERVICIO = "form_mstservicio";
        public static string FORM_MSTUNIDADSERVICIO = "form_mstunidadservicio";
        public static string FORM_MSTSSHCUBICACION = "form_mstsshcubicacion";

        //CLAVES PARA FIRMADO FORMULARIOS
        public static string MIRTH_ANAMNESIS = "ANAMNESIS";
        public static string MIRTH_RECETA = "RECETA";
        public static string MIRTH_DIAGNOSTICO = "DIAGNOSTICO";
        public static string MIRTH_PLANTRABAJO = "TRABAJO";
        public static string MIRTH_OFTALMOLOGICO = "EXAMENOFTALMOLOGICO";
        public static string MIRTH_DESCANSOMEDICO = "DESCANSOMEDICO";
        public static string MIRTH_SALUDINFORME = "SALUDINFORME";

        public static Dictionary<string, string> dctNombresFormulario = new Dictionary<string, string>()
        {
                { UTILES_MENSAJES.MIRTH_ANAMNESIS, "Anamnesis" },
                { UTILES_MENSAJES.MIRTH_RECETA, "Receta"},
                { UTILES_MENSAJES.MIRTH_DIAGNOSTICO, "Diagnostico" },
                { UTILES_MENSAJES.MIRTH_PLANTRABAJO, "Plan de Trabajo" },
                { UTILES_MENSAJES.MIRTH_OFTALMOLOGICO, "Olftalmologico"},
                { UTILES_MENSAJES.MIRTH_DESCANSOMEDICO, "Descanso Médico"},
                { UTILES_MENSAJES.MIRTH_SALUDINFORME, "Salud informe"}
        };


        /**METODO PAA OBTNER LOS MENSAJES DE VALIDACIÓN DE FORMULARIO*/
        public static List<ENTITY_MENSAJES> getValidacionFormulario(Object objValidar, String formulario)
        {
            List<ENTITY_MENSAJES> listaMensajes = new List<ENTITY_MENSAJES>();
            if (objValidar is SS_HC_CuerpoHumano && FORM_MSTCUERPOHUMANO == formulario)
            {
                listaMensajes = validoFormularioSS_HC_CuerpoHumano((SS_HC_CuerpoHumano)objValidar);
            }
            else if (objValidar is SG_Agente && FORM_MSTAGENTE == formulario)
            {
                listaMensajes = validoFormularioSG_Agente((SG_Agente)objValidar);
            }

            else if (objValidar is SG_AgenteOpcion && FORM_MSTAGENTEOPCION == formulario)
            {
                listaMensajes = validoFormularioSG_AgenteOpcion((SG_AgenteOpcion)objValidar);
            }
            else if (objValidar is SS_GE_TipoAtencion && FORM_MSTTIPOATENCION == formulario)
            {
                listaMensajes = validoFormularioSS_GE_TipoAtencion((SS_GE_TipoAtencion)objValidar);
            }
            else if (objValidar is SS_SG_MaestroCobertura && FORM_MSTCOBERTURA == formulario)
            {
                listaMensajes = validoFormularioSS_SG_MaestroCobertura((SS_SG_MaestroCobertura)objValidar);
            }

            else if (objValidar is AC_Sucursal && FORM_MSTSUCURSAL == formulario)
            {
                listaMensajes = validoFormularioAC_Sucursal((AC_Sucursal)objValidar);
            }

            else if (objValidar is SG_Opcion && FORM_MSTOPCIONES == formulario)
            {
                listaMensajes = validoFormularioSG_Opcion((SG_Opcion)objValidar);
            }
            else if (objValidar is SS_HC_Formato && FORM_MSTFORMATO == formulario)
            {
                listaMensajes = validoFormularioSS_HC_Formato((SS_HC_Formato)objValidar);
            }
            else if (objValidar is SS_HC_NIC && FORM_MSTNIC == formulario)
            {
                listaMensajes = validoFormularioSS_HC_NIC((SS_HC_NIC)objValidar);
            }

            else if (objValidar is SS_HC_NOC2 && FORM_MSTNOC2 == formulario)
            {
                listaMensajes = validoFormularioSS_HC_NOC2((SS_HC_NOC2)objValidar);
            }


            else if (objValidar is SS_HC_NANDA && FORM_MSTNANDA == formulario)
            {
                listaMensajes = validoFormularioSS_HC_NANDA((SS_HC_NANDA)objValidar);
            }

            else if (objValidar is SS_HC_UnidadMedidaMinsa && FORM_MSTUNIDADMEDIDAMINSA == formulario)
            {
                listaMensajes = validoFormularioSS_HC_UnidadMedidaMinsa((SS_HC_UnidadMedidaMinsa)objValidar);
            } 

            else if (objValidar is SS_HC_FactorRelacionado && FORM_MSTFACTORRELACIONADO == formulario)
            {
                listaMensajes = validoFormularioSS_HC_FactorRelacionado((SS_HC_FactorRelacionado)objValidar);
            }

            else if (objValidar is SS_HC_FactorRelacionadoNanda && FORM_MSTFACTORRELACIONADONANDA == formulario)
            {
                listaMensajes = validoFormularioSS_HC_FactorRelacionadoNanda((SS_HC_FactorRelacionadoNanda)objValidar);
            }


            else if (objValidar is SS_HC_NandaNoc && FORM_MSTNOCNANDA == formulario)
            {
                listaMensajes = validoFormularioSS_HC_NocNanda((SS_HC_NandaNoc)objValidar);
            }

            else if (objValidar is SS_HC_NocNic && FORM_MSTNOCNIC == formulario)
            {
                listaMensajes = validoFormularioSS_HC_NocNic((SS_HC_NocNic)objValidar);
            }


            else if (objValidar is SS_HC_NOCIndicador && FORM_MSTNOCINDICADOR == formulario)
            {
                listaMensajes = validoFormularioSS_HC_NocIndicador((SS_HC_NOCIndicador)objValidar);
            }

            else if (objValidar is SS_HC_NICActividad && FORM_MSTNICACTIVIDAD == formulario)
            {
                listaMensajes = validoFormularioSS_HC_NicActividad((SS_HC_NICActividad)objValidar);
            }

            else if (objValidar is SS_HC_DominioPAE && FORM_MSTDOMINIOPAE == formulario)
            {
                listaMensajes = validoFormularioSS_HC_DominioPAE((SS_HC_DominioPAE)objValidar);
            }


            else if (objValidar is SS_HC_ClasePAE && FORM_MSTCLASEPAE == formulario)
            {
                listaMensajes = validoFormularioSS_HC_ClasePAE((SS_HC_ClasePAE)objValidar);
            }

            else if (objValidar is SS_HC_Actividad && FORM_MSTACTIVIDADES == formulario)
            {
                listaMensajes = validoFormularioSS_HC_Actividades((SS_HC_Actividad)objValidar);
            }

            else if (objValidar is SS_HC_IndicadorPAE && FORM_MSTINDICADORPAE == formulario)
            {
                listaMensajes = validoFormularioSS_HC_IndicadorPAE((SS_HC_IndicadorPAE)objValidar);
            }

                
                

            else if (objValidar is SS_GE_Diagnostico && FORM_MSDIAGNOSTICO == formulario)
            {
                listaMensajes = validoFormularioSS_GE_Diagnostico((SS_GE_Diagnostico)objValidar);

                                
            }

            else if (objValidar is SS_HC_RegistroAcompanante && FORM_MSTREGISTRARACOMPANANTE == formulario)
            {
                listaMensajes = validoFormularioSS_HC_RAcompanante((SS_HC_RegistroAcompanante)objValidar);


            }





            else if (objValidar is WH_ItemMast && FORM_MSMEDICAMENTOS == formulario)
            {
                listaMensajes = validoFormularioWH_ItemMast((WH_ItemMast)objValidar);
            }

            else if (objValidar is WH_ItemMast && FORM_MSMEDICAMENTOSMINSA == formulario)
            {
                listaMensajes = validoFormularioWH_ItemMastMinsa((WH_ItemMast)objValidar);
            }


            else if (objValidar is SS_HC_CIAP2 && FORM_MSCIAP == formulario)
            {
                listaMensajes = validoFormularioSS_HC_CIAP2((SS_HC_CIAP2)objValidar);
            }
            else if (objValidar is SS_HC_Procedimiento && FORM_MSPROCEDIMIENTO == formulario)
            {
                listaMensajes = validoFormularioSS_HC_Procedimiento((SS_HC_Procedimiento)objValidar);
            }
            else if (objValidar is SS_HC_CuidadoPreventivo && FORM_MSCUIDADO == formulario)
            {
                listaMensajes = validoFormularioSS_HC_CuidadoPreventivo((SS_HC_CuidadoPreventivo)objValidar);
            }
            else if (objValidar is SS_HC_FormatoRecursoCampo && FORM_MSRECURSO == formulario)
            {
                listaMensajes = validoFormularioSS_HC_FormatoRecursoCampo((SS_HC_FormatoRecursoCampo)objValidar);
            }
            //else if (objValidar is SS_HC_NANDA && FORM_MSTNANDA == formulario)
            //{
            //    listaMensajes = validoFormularioSS_HC_NANDA((SS_HC_NANDA)objValidar);
            //}
            else if (objValidar is VW_SS_HC_ASIGNACIONMEDICO && FORM_MSTVWASIGMED == formulario)
            {
                listaMensajes = validoFormularioVW_SS_HC_ASIGNACIONMEDICO((VW_SS_HC_ASIGNACIONMEDICO)objValidar);
            }
            //else if (objValidar is SS_HC_NOC && FORM_MSRESULTADOS == formulario)
            //{
            //    listaMensajes = validoFormularioSS_HC_NOC((SS_HC_NOC)objValidar);
            //}
            else if (objValidar is CM_CO_Establecimiento && FORM_MSESTABLECIMIENTO == formulario)
            {
                listaMensajes = validoFormularioCM_CO_Establecimiento((CM_CO_Establecimiento)objValidar);
            }
            else if (objValidar is SG_Modulo && FORM_MSMODULO == formulario)
            {
                listaMensajes = validoFormularioSG_Modulo((SG_Modulo)objValidar);
            }
            else if (objValidar is SS_HC_FormatoCampo && FORM_MSFORMATOCAMPO == formulario)
            {
                listaMensajes = validoFormularioSS_HC_FormatoCampo((SS_HC_FormatoCampo)objValidar);
            }
            else if (objValidar is PERSONAMAST && FORM_MSTPERSONA == formulario)
            {
                listaMensajes = validoFormularioPersona((PERSONAMAST)objValidar);
            }
            else if (objValidar is SS_HC_FavoritoNumero && FORM_MSFAVORITONUMERO == formulario)
            {
                listaMensajes = validoFormularioFavoritoNumero((SS_HC_FavoritoNumero)objValidar);
            }
            else if (objValidar is SS_HC_ControlValidacion && FORM_MSCONTROLVALIDACION == formulario)
            {
                listaMensajes = validoFormularioControlValidacion((SS_HC_ControlValidacion)objValidar);
            }
            else if (objValidar is SS_HC_FavoritoCodigoId && FORM_MSFAVCODIGO == formulario)
            {
                listaMensajes = validoFormularioFavoritoCodigo((SS_HC_FavoritoCodigoId)objValidar);
            }
            else if (objValidar is SS_HC_Favorito && FORM_MSFAVORITO == formulario)
            {
                listaMensajes = validoFormularioFavorito((SS_HC_Favorito)objValidar);
            }
            else if (objValidar is ParametrosMast && FORM_MSTPARAMETRO == formulario)
            {
                listaMensajes = validoFormularioParametro((ParametrosMast)objValidar);
            }
            else if (objValidar is SS_HC_FavoritoDetalle && FORM_MSFAVORITODETALLE == formulario)
            {
                listaMensajes = validoFormularioFavoritoDetalle((SS_HC_FavoritoDetalle)objValidar);
            }
            else if (objValidar is SS_GE_ProcedimientoMedicoDos && FORM_MSCIAPDOS == formulario)
            {
                listaMensajes = validoFormularioSS_HC_CIAPDOS((SS_GE_ProcedimientoMedicoDos)objValidar);
            }
            else if (objValidar is MA_MiscelaneosDetalle && FORM_MSMISCELANEODET == formulario)
            {
                listaMensajes = validoFormularioDetalleMiscelaneoDetalle((MA_MiscelaneosDetalle)objValidar);
            }
            else if (objValidar is MA_MiscelaneosHeader && FORM_MSMISCELANEOHED == formulario)
            {
                listaMensajes = validoFormularioDetalleMiscelaneoHeader((MA_MiscelaneosHeader)objValidar);
            }
            else if (objValidar is SS_GE_Paciente && FORM_MSPACIENTE == formulario)
            {
                listaMensajes = validoFormularioPaciente((SS_GE_Paciente)objValidar);
            }
            else if (objValidar is PERSONAMAST && FORM_MSTMEDICO == formulario)
            {
                listaMensajes = validoFormularioMedico((PERSONAMAST)objValidar);
            }
            else if (objValidar is SS_HC_CatalogoUnidadServicio && FORM_MSTCATUNIDADSERVICIO == formulario)
            {
                listaMensajes = validoFormularioCatUnidadServicio((SS_HC_CatalogoUnidadServicio)objValidar);
            }
            else if (objValidar is SS_GE_Servicio && FORM_MSTSERVICIO == formulario)
            {
                listaMensajes = validoFormularioServicios((SS_GE_Servicio)objValidar);
            }
            else if (objValidar is SS_HC_UnidadServicio && FORM_MSTUNIDADSERVICIO == formulario)
            {
                listaMensajes = validoFormularioUnidadServicios((SS_HC_UnidadServicio)objValidar);
            }
            else if (objValidar is SS_HC_Ubicacion && FORM_MSTSSHCUBICACION == formulario)
            {
                listaMensajes = validoFormularioSSHCUbicacion((SS_HC_Ubicacion)objValidar);
            }
            else
            {

            }//FORM_MSPACIENTE

            return listaMensajes;
        }

        // MAESTRO UBICACIÓN //
        public static List<ENTITY_MENSAJES> validoFormularioSSHCUbicacion(SS_HC_Ubicacion objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool indicaError = false;
            if (objSave != null)
            {
                if (objSave.Accion == "DELETE")
                {
                    if (objSave.IdUbicacion != null)
                    {
                        SS_HC_Ubicacion objBusq = new SS_HC_Ubicacion();
                        objBusq.Accion = "LISTAR";
                        objBusq.IdUbicacionPadre = objSave.IdUbicacion;
                        var Listar = new List<SS_HC_Ubicacion>();

                        Listar = SvcSSHCUbicacion.listarSSHCUbicacion(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            mensaje = "El elemento seleccionado está siendo referenciado como 'Padre', en otro recurso. No puede ser eliminado'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "IdUbicacionPadre",
                                NIVEL = 1
                            });
                        }
                    }
                }
                else
                {
                    if (objSave.Codigo != null)
                    {
                        SS_HC_Ubicacion objBusq = new SS_HC_Ubicacion();
                        objBusq.Accion = "LISTAR";
                        objBusq.Codigo = objSave.Codigo;
                        var Listar = new List<SS_HC_Ubicacion>();
                        Listar = SvcSSHCUbicacion.listarSSHCUbicacion(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            if (objSave.Accion == "NUEVO")
                            {
                                indicaError = true;
                            }
                            else if (objSave.Accion == "UPDATE")
                            {
                                foreach (var result in Listar)
                                {
                                    if (result.Codigo != objSave.Codigo)
                                    {
                                        indicaError = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }
                    if (indicaError)
                    {
                        mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
                        mensajesError.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensaje,
                            IDCOMPONENTE = "Codigo",
                            NIVEL = 1
                        });
                    }
                }
            }
            return mensajesError;
        }
        // PACIENTE //
        public static List<ENTITY_MENSAJES> validoFormularioPaciente(SS_GE_Paciente objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            if (objSave != null)
            {

            }

            return mensajesError;
        }

        // MAESTRO MÉDICO  //
        public static List<ENTITY_MENSAJES> validoFormularioMedico(PERSONAMAST objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            if (objSave != null)
            {                
                if (objSave.ACCION == "NUEVO")
                {
                    if (objSave.Persona != 0)
                    {
                        PERSONAMAST objFiltro = new PERSONAMAST();
                        objFiltro.ACCION = "CONTARLISTAR";
                        objFiltro.Persona = objSave.Persona;

                       int Listar = SvcPersonaMast.setMantenimiento(objFiltro);
                        if (Listar > 0)
                        {
                            mensaje = "La persona seleccionada ya se encuentra registrada como médico.";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "Persona",
                                NIVEL = 1
                            });
                        }
                    }
                    else
                    {
                        mensaje = "Debe ingresar el campo cód. médico";
                        mensajesError.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensaje,
                            IDCOMPONENTE = "Persona",
                            NIVEL = 1
                        });
                    }
                }
            }
            return mensajesError;
        }
        /*MAESTRO SERVICIOS*/
        public static List<ENTITY_MENSAJES> validoFormularioServicios(SS_GE_Servicio objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            if (objSave != null)
            {
                //VALID_ELIMINARPADRE:
                //if (objSave.accion == "NUEVO")
                //{
                //    if (objSave.IdServicio != null)
                //    {
                //        SS_GE_Servicio objBusq = new SS_GE_Servicio();
                //        objBusq.accion = "LISTAR";
                //        objBusq.IdServicio = objSave.IdServicio;
                //        var Listar = new List<SS_GE_Servicio>();

                //        Listar = SvcServicios.listarServicio(objBusq, 0, 0);

                //        if (Listar.Count > 0)
                //        {
                //            mensaje = "El Id ya se encuentra guardado dentro de la tabla. No puede ser guardado'";
                //            mensajesError.Add(new ENTITY_MENSAJES
                //            {
                //                DESCRIPCION = mensaje,
                //                IDCOMPONENTE = "txtDesc",
                //                NIVEL = 1
                //            });
                //        }

                //    }

                //}

            }

            return mensajesError;
        }
        /*MAESTRO UNIDAD DE SERVICIOS*/
        public static List<ENTITY_MENSAJES> validoFormularioUnidadServicios(SS_HC_UnidadServicio objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool indicaError = false;
            if (objSave != null)
            {
                if (objSave.Accion == "DELETE")
                {
                    
                }
                else
                {
                    if (objSave.Accion == "NUEVO")
                    {
                        if (objSave.IdEstablecimientoSalud == 0 || objSave.IdEstablecimientoSalud == null)
                        {
                            mensaje = "Debe ingresar el campo establecimiento";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "IdEstablecimientoSalud",
                                NIVEL = 1
                            });
                        }
                        if (objSave.IdUnidadServicio == 0 || objSave.IdUnidadServicio == null)
                        {
                            mensaje = "Debe ingresar el campo unidad servicio";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "IdUnidadServicio",
                                NIVEL = 1
                            });
                        }
                        if ((objSave.IdUnidadServicio != 0 || objSave.IdUnidadServicio != null) && (objSave.IdEstablecimientoSalud != 0 || objSave.IdEstablecimientoSalud != null))
                        {
                            SS_HC_UnidadServicio objBusq = new SS_HC_UnidadServicio();
                            objBusq.Accion = "LISTAR";
                            objBusq.IdUnidadServicio = objSave.IdUnidadServicio;
                            objBusq.IdEstablecimientoSalud = objSave.IdEstablecimientoSalud;
                            var Listar = new List<SS_HC_UnidadServicio>();

                            Listar = SvcUnidadServicio.listarUnidadServicio(objBusq, 0, 0);
                            if (Listar.Count > 0)
                            {
                                mensaje = "El establecimiento y la unidad de servicio del registro ya han sido utilizados. Modificar el establecimiento y la unidad de servicio ingresada.";
                                mensajesError.Add(new ENTITY_MENSAJES
                                {
                                    DESCRIPCION = mensaje,
                                    IDCOMPONENTE = "IdUnidadServicio",
                                    NIVEL = 1
                                });
                            }
                        }
                    }
                    if (objSave.Codigo != null)
                    {
                        SS_HC_UnidadServicio objBusq = new SS_HC_UnidadServicio();
                        objBusq.Accion = "LISTARDOS";
                        objBusq.Codigo = objSave.Codigo;
                        var Listar = new List<SS_HC_UnidadServicio>();

                        Listar = SvcUnidadServicio.listarUnidadServicio(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            if (objSave.Accion == "NUEVO")
                            {
                                indicaError = true;
                            }
                            else if (objSave.Accion == "UPDATE")
                            {
                                foreach (var result in Listar)
                                {
                                    if ((result.IdUnidadServicio != objSave.IdUnidadServicio) && (result.IdEstablecimientoSalud != objSave.IdEstablecimientoSalud))
                                    {
                                        indicaError = true;
                                        break;
                                    }
                                }
                            }

                        }
                    }
                    if (indicaError)
                    {
                        mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
                        mensajesError.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensaje,
                            IDCOMPONENTE = "Codigo",
                            NIVEL = 1
                        });
                    }
                }      
            }

            return mensajesError;
        }
        // MISCELANEO HEADER //
        public static List<ENTITY_MENSAJES> validoFormularioDetalleMiscelaneoHeader(MA_MiscelaneosHeader objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            if (objSave != null)
            {
                //VALID_ELIMINARPADRE:
                if (objSave.ACCION == "NUEVO")
                {
                    if (objSave.CodigoTabla != null)
                    {
                        MA_MiscelaneosHeader objBusq = new MA_MiscelaneosHeader();
                        objBusq.ACCION = "LISTAR";
                        objBusq.CodigoTabla = objSave.CodigoTabla;
                        var Listar = new List<MA_MiscelaneosHeader>();

                        Listar = SvcHeaderMiscelaneo.listarHeaderMiscelaneo(objBusq, 0, 0);

                        if (Listar.Count > 0)
                        {
                            mensaje = "El Codigo Tabla ya se encuentra guardado dentro de la tabla. No puede ser guardado'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }

                    }

                }

            }

            return mensajesError;
        }

        // MISCELANEO DETALLE  //
        public static List<ENTITY_MENSAJES> validoFormularioDetalleMiscelaneoDetalle(MA_MiscelaneosDetalle objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            if (objSave != null)
            {

            }

            return mensajesError;
        }

        // FAVORITO DETALLE  //
        public static List<ENTITY_MENSAJES> validoFormularioFavoritoDetalle(SS_HC_FavoritoDetalle objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            if (objSave != null)
            {
                //VALID_ELIMINARPADRE:
                if (objSave.Accion == "INSERT")
                {
                    if (objSave.ValorId != null)
                    {
                        SS_HC_FavoritoDetalle objBusq = new SS_HC_FavoritoDetalle();
                        objBusq.Accion = "LISTAR";
                        objBusq.ValorId = objSave.ValorId;
                        var Listar = new List<SS_HC_FavoritoDetalle>();

                        Listar = SvcFavoritoDetalle.listarFavoritoDetalle(objBusq, 0, 0, 0, 0);

                        if (Listar.Count > 0)
                        {
                            mensaje = "El elemento seleccionado ya se encuentra guardado dentro de la tabla. No puede ser guardado'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }

                    }

                }
            }

            return mensajesError;
        }
        // PARÁMETROS  //
        public static List<ENTITY_MENSAJES> validoFormularioParametro(ParametrosMast objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            if (objSave != null)
            {
                if (objSave.Accion == "NUEVO")
                {
                    if (objSave.AplicacionCodigo != null && objSave.ParametroClave != null)
                    {
                        ParametrosMast objFiltro = new ParametrosMast();
                        objFiltro.Accion = "LISTAR";
                        if (objSave.CompaniaCodigo == null)
                        {
                            objFiltro.CompaniaCodigo = "999999";
                        }
                        else { objFiltro.CompaniaCodigo = objSave.CompaniaCodigo; }
                        objFiltro.AplicacionCodigo = objSave.AplicacionCodigo;
                        objFiltro.ParametroClave = objSave.ParametroClave;
                        var Listar = new List<ParametrosMast>();

                        Listar = SvcParametro.listarParametro(objFiltro, 0, 0);
                        if (Listar.Count > 0)
                        {
                            mensaje = "El código del registro ya ha sido utilizado para la misma Aplicación y Compañía. Modificar el código ingresado.'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }
                }
            }

            return mensajesError;
        }
        // FAVORITO  //
        public static List<ENTITY_MENSAJES> validoFormularioFavorito(SS_HC_Favorito objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            if (objSave != null)
            {
                if (objSave.Accion == "NUEVO")
                {
                    if (objSave.Descripcion != null)
                    {
                        SS_HC_Favorito objBusq = new SS_HC_Favorito();
                        objBusq.Accion = "LISTAR";
                        objBusq.Descripcion = objSave.Descripcion;
                        var Listar = new List<SS_HC_Favorito>();

                        Listar = SvcFavorito.listarFavorito(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            mensaje = "El elemento ya se encuentra registrado.";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }
                }
            }

            return mensajesError;
        }

        // FAVORITO CODIGO //

        public static List<ENTITY_MENSAJES> validoFormularioFavoritoCodigo(SS_HC_FavoritoCodigoId objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            if (objSave != null)
            {

                if (objSave.Accion == "NUEVO")
                {
                    if (objSave.ValorTexto != null)
                    {
                        SS_HC_FavoritoCodigoId objBusq = new SS_HC_FavoritoCodigoId();
                        objBusq.Accion = "LISTAR";
                        objBusq.ValorTexto = objSave.ValorTexto;
                        var Listar = new List<SS_HC_FavoritoCodigoId>();

                        Listar = SvcFavoritoCodigo.listarFavoritoCodigo(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            mensaje = "El elemento seleccionado está siendo referenciado como 'Descripción', en otro recurso. No puede ser guardado'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }
                }
            }
            

            return mensajesError;
        }

        //* CONTROL VALIDACION */ 
        public static List<ENTITY_MENSAJES> validoFormularioControlValidacion(SS_HC_ControlValidacion objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            if (objSave != null)
            {
                if (objSave.Accion == "NUEVO")
                {
                    if (objSave.IdFormato == 0)
                    {
                        SS_HC_ControlValidacion objBusq = new SS_HC_ControlValidacion();
                        objBusq.Accion = "LISTAR";
                        objBusq.IdFormato = objSave.IdFormato;
                        var Listar = new List<SS_HC_ControlValidacion>();

                        Listar = SvcControlValidacion.listarControlValidacion(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            mensaje = "Debe agregar un Formato para registrar la validación";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }
                    if (objSave.IdAtributo == 0)
                    {
                        SS_HC_ControlValidacion objBusq = new SS_HC_ControlValidacion();
                        objBusq.Accion = "LISTAR";
                        objBusq.IdAtributo = objSave.IdAtributo;
                        var Listar = new List<SS_HC_ControlValidacion>();

                        Listar = SvcControlValidacion.listarControlValidacion(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            mensaje = "Debe agregar un Atributo para registrar la validación";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }
                    if (objSave.IdComponente == 0)
                    {
                        SS_HC_ControlValidacion objBusq = new SS_HC_ControlValidacion();
                        objBusq.Accion = "LISTAR";
                        objBusq.IdComponente = objSave.IdComponente;
                        var Listar = new List<SS_HC_ControlValidacion>();

                        Listar = SvcControlValidacion.listarControlValidacion(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            mensaje = "Debe agregar un Componente para registrar la validación";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }
                }
            }

            return mensajesError;

        }
        //* FAVORITO NUMERO */ 
        public static List<ENTITY_MENSAJES> validoFormularioFavoritoNumero(SS_HC_FavoritoNumero objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            if (objSave != null)
            {

                if (objSave.Accion == "NUEVO")
                {
                    if (objSave.Mnemotecnico != null)
                    {
                        SS_HC_FavoritoNumero objBusq = new SS_HC_FavoritoNumero();
                        objBusq.Accion = "LISTAR";
                        objBusq.Mnemotecnico = objSave.Mnemotecnico;
                        var Listar = new List<SS_HC_FavoritoNumero>();

                        Listar = SvcFavoritoNumero.listarFavoritoNumero(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            mensaje = "El elemento seleccionado está siendo referenciado como 'Mnemotecnico', en otro recurso. No puede ser guardado'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }
                }
            }

            return mensajesError;
        }

        //*   FORMATO CAMPO    */
        public static List<ENTITY_MENSAJES> validoFormularioSS_HC_FormatoCampo(SS_HC_FormatoCampo objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            if (objSave != null)
            {
                if (objSave.Accion == "NUEVO")
                {
                    if (objSave.IdFormato == 0)
                    {
                        SS_HC_FormatoCampo objBusq = new SS_HC_FormatoCampo();
                        objBusq.Accion = "LISTAR";
                        objBusq.IdFormato = objSave.IdFormato;
                        var Listar = new List<SS_HC_FormatoCampo>();

                        Listar = SvcFormatoCampo.listarFormatoCampo(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            mensaje = "Debe agregar un Formato para registrar el recurso";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }
                }
            }

            return mensajesError;
        }
        //********* MODULOS *************/

        public static List<ENTITY_MENSAJES> validoFormularioSG_Modulo(SG_Modulo objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            if (objSave != null)
            {
                if (objSave.Accion == "NUEVO")
                {
                    if (objSave.Sistema != null && objSave.Modulo != null)
                    {
                        SG_Modulo objFiltro = new SG_Modulo();
                        objFiltro.Accion = "LISTAR";
                        objFiltro.Sistema = objSave.Sistema;
                        objFiltro.Modulo = objSave.Modulo;
                        var Listar = new List<SG_Modulo>();

                        Listar = SvcModulos.listarModulos(objFiltro, 0, 0);
                        if (Listar.Count > 0)
                        {
                            mensaje = "El elemento ya se encuentra registrado.";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }
                }
            }

            return mensajesError;
        }

        //*** ESTABLECIMIENTO***/ 
        public static List<ENTITY_MENSAJES> validoFormularioCM_CO_Establecimiento(CM_CO_Establecimiento objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool indicaError = false;
            if (objSave != null)
            {
                if(objSave.Accion == "NUEVO" || objSave.Accion == "UPDATE"){
                    if (objSave.Codigo != null)
                    {
                        CM_CO_Establecimiento objBusq = new CM_CO_Establecimiento();
                        objBusq.Accion = "LISTAR";
                        objBusq.Codigo = objSave.Codigo;
                        var Listar = new List<CM_CO_Establecimiento>();

                        Listar = SvcEstablecimiento.listarEstablecimiento(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            if (objSave.Accion == "NUEVO")
                            {
                                indicaError = true;
                            }
                            else if (objSave.Accion == "UPDATE")
                            {
                                foreach (var result in Listar)
                                {
                                    if (result.IdEstablecimiento != objSave.IdEstablecimiento)
                                    {
                                        indicaError = true;
                                        break;
                                    }
                                }
                            }

                        }
                    }
                    if (indicaError)
                    {
                        mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
                        mensajesError.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensaje,
                            IDCOMPONENTE = "Codigo",
                            NIVEL = 1
                        });
                    }
                }
            }

            return mensajesError;
        }
        //********     RESULTADOS ESPERADOS   *************/}

        //public static List<ENTITY_MENSAJES> validoFormularioSS_HC_NOC(SS_HC_NOC objSave)
        //{
        //    List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
        //    String mensaje = null;
        //    bool indicaError=false;
        //    if (objSave != null)
        //    {
        //        if (objSave.Accion == "DELETE")
        //        {
        //            if (objSave.IdNOC != null)
        //            {
        //                SS_HC_NOC objBusq = new SS_HC_NOC();
        //                objBusq.Accion = "LISTAR";
        //                objBusq.IdNOCPadre = objSave.IdNOC;
        //                var Listar = new List<SS_HC_NOC>();

        //                Listar = SvcResultados.listarResultadosEsperados(objBusq, 0, 0);
        //                if (Listar.Count > 0)
        //                {
        //                    mensaje = "El elemento seleccionado está siendo referenciado como 'Padre', en otro recurso. No puede ser eliminado'";
        //                    mensajesError.Add(new ENTITY_MENSAJES
        //                    {
        //                        DESCRIPCION = mensaje,
        //                        IDCOMPONENTE = "IdNOCPadre",
        //                        NIVEL = 1
        //                    });
        //                }
        //            }
        //        }
        //        else
        //        {
        //            if (objSave.Codigo != null)
        //            {
        //                SS_HC_NOC objBusq = new SS_HC_NOC();
        //                objBusq.Accion = "LISTAR";
        //                objBusq.Codigo = objSave.Codigo;
        //                var Listar = new List<SS_HC_NOC>();

        //                Listar = SvcResultados.listarResultadosEsperados(objBusq, 0, 0);
        //                if (Listar.Count > 0)
        //                {
        //                    if (objSave.Accion == "NUEVO")
        //                    {
        //                        indicaError = true;
        //                    }
        //                    else if (objSave.Accion == "UPDATE")
        //                    {
        //                        foreach (var result in Listar)
        //                        {
        //                            if (result.IdNOC != objSave.IdNOC)
        //                            {
        //                                indicaError = true;
        //                                break;
        //                            }
        //                        }
        //                    }

        //                }
        //            }
        //            if (indicaError)
        //            {
        //                mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
        //                mensajesError.Add(new ENTITY_MENSAJES
        //                {
        //                    DESCRIPCION = mensaje,
        //                    IDCOMPONENTE = "Codigo",
        //                    NIVEL = 1
        //                });
        //            }
        //        }
                
              
        //    }

        //    return mensajesError;
        //}

        //***********  RECURSOS ******************/
        public static List<ENTITY_MENSAJES> validoFormularioSS_HC_FormatoRecursoCampo(SS_HC_FormatoRecursoCampo objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            if (objSave != null)
            {
                //VALID_ELIMINARPADRE:
                if (objSave.Accion == "NUEVO")
                {
                    if (objSave.IdFormato == 0)
                    {
                        SS_HC_FormatoRecursoCampo objBusq = new SS_HC_FormatoRecursoCampo();
                        objBusq.Accion = "LISTAR";
                        objBusq.IdFormato = objSave.IdFormato;
                        var Listar = new List<SS_HC_FormatoRecursoCampo>();

                        Listar = SvcRecursos.listarRecursos(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            mensaje = "Debe agregar un Formato Campo para registrar el recurso";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }
                    else if (objSave.IdFormato > 0)
                    {
                        SS_HC_FormatoRecursoCampo objBusq = new SS_HC_FormatoRecursoCampo();
                        objBusq.Accion = "LISTAR";
                        objBusq.IdFormato = objSave.IdFormato;
                        var Listar = new List<SS_HC_FormatoRecursoCampo>();

                        Listar = SvcRecursos.listarRecursos(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            mensaje = "El elemento seleccionado está siendo referenciado como 'Formato', en otro recurso. No puede ser guardado'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }

                }
            }

            return mensajesError;
        }
        /********* MAESTRO PERSONA*************/
        public static List<ENTITY_MENSAJES> validoFormularioPersona(PERSONAMAST objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            if (objSave != null)
            {
                if (objSave.ACCION != "DELETE")
                {
                    if (objSave.TipoPersona == null)
                    {

                        mensaje = "Debe ingresar un valor para el combo 'TipoPersona'";
                        mensajesError.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensaje,
                            IDCOMPONENTE = "txtPersona",
                            NIVEL = 1
                        });

                    }
                }
            }

            return mensajesError;
        }
        /********* CUIDADO PREVENTIVO *************/
        public static List<ENTITY_MENSAJES> validoFormularioSS_HC_CuidadoPreventivo(SS_HC_CuidadoPreventivo objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool indicaError = false;
            if (objSave != null)
            {
                if (objSave.Accion == "DELETE")
                {
                    if (objSave.IdCuidadoPreventivo != null)
                    {
                        SS_HC_CuidadoPreventivo objBusq = new SS_HC_CuidadoPreventivo();
                        objBusq.Accion = "LISTARVALIDACION";
                        objBusq.IdCuidadoPreventivoPadre = objSave.IdCuidadoPreventivo;
                        var Listar = new List<SS_HC_CuidadoPreventivo>();

                        Listar = null;// SvcCuidadoPreventido.listarCuidadoPreventivo(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            mensaje = "El elemento seleccionado está siendo referenciado como 'Padre', en otro recurso. No puede ser eliminado'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "IdNOCPadre",
                                NIVEL = 1
                            });
                        }
                    }
                }
                else
                {
                    if (objSave.CodigoCuidadoPreventivo != null)
                    {
                        SS_HC_CuidadoPreventivo objBusq = new SS_HC_CuidadoPreventivo();
                        objBusq.Accion = "LISTARVALIDACION";
                        objBusq.CodigoCuidadoPreventivo = objSave.CodigoCuidadoPreventivo;
                        var Listar = new List<SS_HC_CuidadoPreventivo>();

                        Listar = null;// SvcCuidadoPreventido.listarCuidadoPreventivo(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            if (objSave.Accion == "NUEVO")
                            {
                                indicaError = true;
                            }
                            else if (objSave.Accion == "UPDATE")
                            {
                                foreach (var result in Listar)
                                {
                                    if (result.IdTipoCuidadoPreventivo != objSave.IdTipoCuidadoPreventivo)
                                    {
                                        indicaError = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }
                    if (indicaError)
                    {
                        mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
                        mensajesError.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensaje,
                            IDCOMPONENTE = "Codigo",
                            NIVEL = 1
                        });
                    }
                }
                

                if (objSave.Accion == "NUEVO")
                {
                    if (objSave.CodigoCuidadoPreventivo != null)
                    {
                        SS_HC_CuidadoPreventivo objBusq = new SS_HC_CuidadoPreventivo();
                        objBusq.Accion = "LISTAR";
                        objBusq.CodigoCuidadoPreventivo = objSave.CodigoCuidadoPreventivo;
                        var Listar = new List<SS_HC_CuidadoPreventivo>();

                        Listar = null;// SvcCuidadoPreventido.listarCuidadoPreventivo(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            mensaje = "El elemento seleccionado está siendo referenciado como 'Codigo', en otro recurso. No puede ser guardado'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }
                }

            }

            return mensajesError;
        }

        //****** PROCEDIMIENTO ************/
        public static List<ENTITY_MENSAJES> validoFormularioSS_HC_Procedimiento(SS_HC_Procedimiento objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool indicaError = false;
            if (objSave != null)
            {
                if (objSave.Accion == "DELETE")
                {
                    if (objSave.IdProcedimiento != null)
                    {
                        SS_HC_Procedimiento objBusq = new SS_HC_Procedimiento();
                        objBusq.Accion = "LISTAR";
                        objBusq.IdProcedimientoPadre = objSave.IdProcedimiento;
                        var Listar = new List<SS_HC_Procedimiento>();

                        Listar = SvcProcedimiento.listarProcedimiento(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            mensaje = "El elemento seleccionado está siendo referenciado como 'Padre', en otro recurso. No puede ser eliminado'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "IdProcedimiento",
                                NIVEL = 1
                            });
                        }
                    }
                }
                else
                {
                    if (objSave.CodigoProcedimiento != null)
                    {
                        SS_HC_Procedimiento objBusq = new SS_HC_Procedimiento();
                        objBusq.Accion = "LISTAR";
                        objBusq.CodigoProcedimiento = objSave.CodigoProcedimiento;
                        var Listar = new List<SS_HC_Procedimiento>();

                        Listar = SvcProcedimiento.listarProcedimiento(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            if (objSave.Accion == "NUEVO")
                            {
                                indicaError = true;
                            }
                            else if (objSave.Accion == "UPDATE")
                            {
                                foreach (var result in Listar)
                                {
                                    if (result.IdProcedimiento != objSave.IdProcedimiento)
                                    {
                                        indicaError = true;
                                        break;
                                    }
                                }
                            }

                        }
                    }
                    if (indicaError)
                    {
                        mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
                        mensajesError.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensaje,
                            IDCOMPONENTE = "CodigoProcedimiento",
                            NIVEL = 1
                        });
                    }
                }                                
            }
            

            return mensajesError;
        }

        //********* CIAP ****************/
        public static List<ENTITY_MENSAJES> validoFormularioSS_HC_CIAP2(SS_HC_CIAP2 objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            if (objSave != null)
            {

            }

            return mensajesError;
        }
        //********* CIAP 2 ****************/
        public static List<ENTITY_MENSAJES> validoFormularioSS_HC_CIAPDOS(SS_GE_ProcedimientoMedicoDos objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool indicaError = false;
            if (objSave != null)                
            {
                if (objSave.Accion == "DELETE")
                {
                    if (objSave.IdProcedimientoDos != null)
                    {
                        SS_GE_ProcedimientoMedicoDos objBusq = new SS_GE_ProcedimientoMedicoDos();
                        objBusq.Accion = "LISTAR";
                        objBusq.IdProcedimientoDosPadre = objSave.IdProcedimientoDos;
                        var Listar = new List<SS_GE_ProcedimientoMedicoDos>();

                        Listar = SvcProcMedDos.listarProcMedicoDos(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            mensaje = "El elemento seleccionado está siendo referenciado como 'Padre', en otro recurso. No puede ser eliminado'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "IdProcedimientoDos",
                                NIVEL = 1
                            });
                        }
                    }
                }
                else
                {
                    if (objSave.CodigoProcedimientoDos != null)
                    {
                        SS_GE_ProcedimientoMedicoDos objBusq = new SS_GE_ProcedimientoMedicoDos();
                        objBusq.Accion = "LISTAR";
                        objBusq.CodigoProcedimientoDos = objSave.CodigoProcedimientoDos;
                        var Listar = new List<SS_GE_ProcedimientoMedicoDos>();

                        Listar = SvcProcMedDos.listarProcMedicoDos(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            if (objSave.Accion == "NUEVO")
                            {
                                indicaError = true;
                            }
                            else if (objSave.Accion == "UPDATE")
                            {
                                foreach (var result in Listar)
                                {
                                    if (result.IdProcedimientoDos != objSave.IdProcedimientoDos)
                                    {
                                        indicaError = true;
                                        break;
                                    }
                                }
                            }

                        }
                    }
                    if (indicaError)
                    {
                        mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
                        mensajesError.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensaje,
                            IDCOMPONENTE = "Codigo",
                            NIVEL = 1
                        });
                    }
                }                              
            }

            return mensajesError;
        }


        /*** MEDICAMENTOS **/

        public static List<ENTITY_MENSAJES> validoFormularioWH_ItemMast(WH_ItemMast objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            if (objSave != null)
            {
                if (objSave.Accion != "DELETE")
                {
                    if (objSave.DescripcionLocal != null)
                    {
                        if (objSave.DescripcionLocal.Trim().Length == 0)
                        {
                            mensaje = "Debe ingresar un valor para el campo 'Descripción de el Articulo'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDes",
                                NIVEL = 1
                            });
                        }
                    }
                    else
                    {
                        mensaje = "Debe ingresar un valor para el campo 'Descripción de el Articulo'";
                        mensajesError.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensaje,
                            IDCOMPONENTE = "txtDes",
                            NIVEL = 1
                        });
                    }
                }
                if (objSave.Accion != "UPDATE")
                {
                    if (objSave.IdClasificacion != null)
                    {
                        if (objSave.IdClasificacion == 0)
                        {
                            mensaje = "Debe ingresar un valor para el campo 'Unidad Minsa de el Articulo'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "cmbuni",
                                NIVEL = 1
                            });
                        }
                    }
                    else
                    {
                        mensaje = "Debe ingresar un valor para el campo 'Unidad Minsa de el Articulo'";
                        mensajesError.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensaje,
                            IDCOMPONENTE = "cmbuni",
                            NIVEL = 1
                        });
                    }
                }
            }

            return mensajesError;
        }



        
             public static List<ENTITY_MENSAJES> validoFormularioWH_ItemMastMinsa(WH_ItemMast objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            if (objSave != null)
            {

                if (objSave.Accion != "UPDATE_MINSA")
                {
                    if (objSave.IdClasificacion != null)
                    {
                        if (objSave.IdClasificacion == 0)
                        {
                            mensaje = "Debe ingresar un valor para el campo 'Unidad Minsa de el Articulo'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "cmbuni",
                                NIVEL = 1
                            });
                        }
                    }
                    else
                    {
                        mensaje = "Debe ingresar un valor para el campo 'Unidad Minsa de el Articulo'";
                        mensajesError.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensaje,
                            IDCOMPONENTE = "cmbuni",
                            NIVEL = 1
                        });
                    }
                }
            }

            return mensajesError;
        }

        /*** DIAGNOSTICO **/
        public static List<ENTITY_MENSAJES> validoFormularioSS_GE_Diagnostico(SS_GE_Diagnostico objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool indicaError = false;
            if (objSave != null)
            {
                if (objSave.Accion == "DELETE")
                {
                    if (objSave.IdDiagnostico != null)
                    {
                        SS_GE_Diagnostico objBusq = new SS_GE_Diagnostico();
                        objBusq.Accion = "LISTAR";
                        objBusq.IdDiagnosticoPadre = objSave.IdDiagnostico;
                        var Listar = new List<SS_GE_Diagnostico>();

                        Listar = SvcDiagnostico.listarDiagnostico(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            mensaje = "El elemento seleccionado está siendo referenciado como 'Padre', en otro recurso. No puede ser eliminado'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "IdNOCPadre",
                                NIVEL = 1
                            });
                        }
                    }
                }
                else
                {
                    if (objSave.CodigoDiagnostico != null)
                    {
                        SS_GE_Diagnostico objBusq = new SS_GE_Diagnostico();
                        objBusq.Accion = "LISTAR";
                        objBusq.CodigoDiagnostico = objSave.CodigoDiagnostico;
                        var Listar = new List<SS_GE_Diagnostico>();

                        Listar = SvcDiagnostico.listarDiagnostico(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            if (objSave.Accion == "NUEVO")
                            {
                                indicaError = true;
                            }
                            else if (objSave.Accion == "UPDATE")
                            {
                                foreach (var result in Listar)
                                {
                                    if (result.IdDiagnostico != objSave.IdDiagnostico)
                                    {
                                        indicaError = true;
                                        break;
                                    }
                                }
                            }

                        }
                    }
                    if (indicaError)
                    {
                        mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
                        mensajesError.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensaje,
                            IDCOMPONENTE = "Codigo",
                            NIVEL = 1
                        });
                    }
                }
                
            }

            return mensajesError;
        }

        

        /**OBS:  OBTENER INNFO  DE ARCHIVOS DE RECURSOS,  (XML, etc)*/
        /*** Cuerpo Humano **/
        public static List<ENTITY_MENSAJES> validoFormularioSS_HC_CuerpoHumano(SS_HC_CuerpoHumano objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool indicaError = false;
            if (objSave != null)
            {
                //VALID_ELIMINARPADRE:
                if (objSave.ACCION == "DELETE")
                {
                    if (objSave.IdCuerpoHumano != null)
                    {
                        SS_HC_CuerpoHumano objBusq = new SS_HC_CuerpoHumano();
                        objBusq.ACCION = "LISTAR";
                        objBusq.IdCuerpoHumanoPadre = objSave.IdCuerpoHumano;
                        var Listar = new List<SS_HC_CuerpoHumano>();

                        Listar = SvcSS_HC_CuerpoHumano.listarSSHCCuerpoHumano(objBusq);
                        if (Listar.Count > 0)
                        {
                            mensaje = "El elemento seleccionado está siendo referenciado como 'Padre', en otro recurso. No puede ser eliminado'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }
                }
                else
                {
                    if (objSave.IdCuerpoHumano != null)
                    {
                        SS_HC_CuerpoHumano objBusq = new SS_HC_CuerpoHumano();
                        objBusq.ACCION = "LISTAR";
                        objBusq.Codigo = objSave.Codigo;
                        var Listar = new List<SS_HC_CuerpoHumano>();

                        Listar = SvcSS_HC_CuerpoHumano.listarSSHCCuerpoHumano(objBusq);
                        if (Listar.Count > 0)
                        {
                            if (objSave.ACCION == "NUEVO")
                            {
                                indicaError = true;
                            }
                            else if (objSave.ACCION == "UPDATE")
                            {
                                foreach (var result in Listar)
                                {
                                    if (result.IdCuerpoHumano != objSave.IdCuerpoHumano)
                                    {
                                        indicaError = true;
                                        break;
                                    }
                                }
                            }
                        }
                        if (indicaError)
                        {
                            mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }
                }
            }
            return mensajesError;
        }
        /**Validación Asignacion Médico*/
        public static List<ENTITY_MENSAJES> validoFormularioVW_SS_HC_ASIGNACIONMEDICO(VW_SS_HC_ASIGNACIONMEDICO objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            if (objSave != null)
            {
                if (objSave.accion != "DELETE")
                {
                    if (objSave.idpaciente != null)
                    {
                        if (objSave.idpaciente == 0)
                        {
                            mensaje = "Debe ingresar un valor para el campo 'Paciente'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "nfIdEmp",
                                NIVEL = 1
                            });
                        }
                    }
                    else
                    {
                        mensaje = "Debe ingresar un valor para el campo 'Paciente'";
                        mensajesError.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensaje,
                            IDCOMPONENTE = "nfIdEmp",
                            NIVEL = 1
                        });
                    }

                    if (objSave.idasignacionmedico != null)
                    {
                        if (objSave.idasignacionmedico == 0)
                        {
                            mensaje = "Debe ingresar un valor para el campo 'Médico'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "nfIdMed",
                                NIVEL = 1
                            });
                        }
                    }
                    else
                    {
                        mensaje = "Debe ingresar un valor para el campo 'Médico'";
                        mensajesError.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensaje,
                            IDCOMPONENTE = "nfIdMed",
                            NIVEL = 1
                        });
                    }
                }
            }

            return mensajesError;
        }
        /***************FIN***************/
        /**Validación Maestro Dato*/
        public static List<ENTITY_MENSAJES> validoFormularioCM_CO_TablaMaestro(SS_HC_Formato objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            if (objSave != null)
            {
                if (objSave.Accion != "DELETE")
                {
                    if (objSave.Descripcion != null)
                    {
                        if (objSave.Descripcion.Trim().Length == 0)
                        {
                            mensaje = "Debe ingresar un valor para el campo 'Código'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDes",
                                NIVEL = 1
                            });
                        }
                    }
                    else
                    {
                        mensaje = "Debe ingresar un valor para el campo 'Código'";
                        mensajesError.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensaje,
                            IDCOMPONENTE = "txtDes",
                            NIVEL = 1
                        });
                    }
                }
            }

            return mensajesError;
        }
        /***************FIN***************/
        /**Validación Maestro NIC*/
        public static List<ENTITY_MENSAJES> validoFormularioSS_HC_NIC(SS_HC_NIC objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool indicaError = false;
            bool indicaError2 = false;
            if (objSave != null)
            {            

                if (objSave.Accion == "NUEVO" || objSave.Accion == "UPDATE")
                {
                    if (objSave.Codigo != null)
                    {
                        SS_HC_NIC objBusq = new SS_HC_NIC();
                        objBusq.Accion = "LISTAR";
                        objBusq.Codigo = objSave.Codigo;
                        var Listar = new List<SS_HC_NIC>();
                        Listar = SvcNic.listarNic(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            if (objSave.Accion == "NUEVO")
                            {
                                if (Int32.Parse(objSave.CodigoPadre) == Int32.Parse(objSave.Codigo))
                                {
                                    indicaError2 = true;
                                }
                                else { indicaError = true; } 
                            }
                            else if (objSave.Accion == "UPDATE")
                            {
                                foreach (var result in Listar)
                                {
                                    if (result.IdNIC != objSave.IdNIC)
                                    {
                                        indicaError = true;
                                        break;
                                    }
                                }
                                if (Int32.Parse(objSave.CodigoPadre) == Int32.Parse(objSave.Codigo))
                                {
                                   // ENTITY_GLOBAL.Instance.MENSAJE_ERROR = "No puede asignar un padre a si mismo"; 
                                    indicaError2 = true;
                                }

                            }                       
                        }
                        if (indicaError)
                        {
                            mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
                            ENTITY_GLOBAL.Instance.MENSAJE_ERROR = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'"; 
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                        if (indicaError2)
                        {
                            mensaje = "No puede asignar un padre a si mismo.";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }
                }
            }

            return mensajesError;
        }
        /***************FIN***************/
        /**Validación Maestro Formato*/

        /*****vALIDACION NOC2**/
           public static List<ENTITY_MENSAJES> validoFormularioSS_HC_NOC2(SS_HC_NOC2 objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool indicaError = false;
            bool indicaError2 = false;
            if (objSave != null)
            {

                if (objSave.Accion == "NUEVO" || objSave.Accion == "UPDATE")
                {
                    if (objSave.Codigo != null)
                    {
                        SS_HC_NOC2 objBusq = new SS_HC_NOC2();
                        objBusq.Accion = "LISTAR";
                        objBusq.Codigo = objSave.Codigo;
                        var Listar = new List<SS_HC_NOC2>();
                        Listar = SvcNoc.listarNoc(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            if (objSave.Accion == "NUEVO")
                            {
                                if (Int32.Parse(objSave.CodigoPadre) == Int32.Parse(objSave.Codigo))
                                {                                     
                                    indicaError2 = true;
                                }
                                else {indicaError = true; } 
                            }
                            else if (objSave.Accion == "UPDATE")
                            {
                                foreach (var result in Listar)
                                {
                                    if (result.IdNoc != objSave.IdNoc)
                                    {
                                        indicaError = true;
                                        break;
                                    }
                                }
                                if (Int32.Parse(objSave.CodigoPadre) == Int32.Parse(objSave.Codigo))
                                {
                                    // ENTITY_GLOBAL.Instance.MENSAJE_ERROR = "No puede asignar un padre a si mismo"; 
                                    indicaError2 = true;
                                }
                            }
                        }
                        if (indicaError)
                        {
                            mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                        if (indicaError2)
                        {
                            mensaje = "No puede asignar un padre a si mismo.";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }
                }
            }

            return mensajesError;
        }
        
        /*****FIN******/


        /***** VALIDACION DE FACTOR RELACIONADO******/

        public static List<ENTITY_MENSAJES> validoFormularioSS_HC_FactorRelacionado(SS_HC_FactorRelacionado objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool indicaError = false;
            if (objSave != null)
            {

                if (objSave.Accion == "NUEVO" || objSave.Accion == "UPDATE")
                {
                    if (objSave.Codigo != null)
                    {
                        SS_HC_FactorRelacionado objBusq = new SS_HC_FactorRelacionado();
                        objBusq.Accion = "LISTAR";
                        objBusq.Codigo = objSave.Codigo;
                        var Listar = new List<SS_HC_FactorRelacionado>();
                        Listar = SvcFactorRelacionado.listarFactorRelacionado(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            if (objSave.Accion == "NUEVO")
                            {
                                indicaError = true;
                            }
                            else if (objSave.Accion == "UPDATE")
                            {
                                foreach (var result in Listar)
                                {
                                    if (result.IdFactorRelacionado != objSave.IdFactorRelacionado)
                                    {
                                        indicaError = true;
                                        break;
                                    }
                                }
                            }
                        }
                        if (indicaError)
                        {
                            mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }
                }
            }

            return mensajesError;
        }


        /*****FIN***/


        /*****************VALIDACION DE FACTOR RELACIONADO NANDA*********************/


        public static List<ENTITY_MENSAJES> validoFormularioSS_HC_FactorRelacionadoNanda(SS_HC_FactorRelacionadoNanda objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool indicaError = false;
            if (objSave != null)
            {

                if (objSave.Accion == "NUEVO" || objSave.Accion == "UPDATE")
                {
                    if (objSave.Descripcion != null)
                    {
                        SS_HC_FactorRelacionadoNanda objBusq = new SS_HC_FactorRelacionadoNanda();
                        objBusq.Accion = "LISTAR";
                        objBusq.Descripcion = objSave.Descripcion;
                        var Listar = new List<SS_HC_FactorRelacionadoNanda>();
                        Listar = SvcFactorRelacionadoNanda.listarFactorRelacionadoNanda(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            if (objSave.Accion == "NUEVO")
                            {
                                indicaError = true;
                            }
                            else if (objSave.Accion == "UPDATE")
                            {
                                foreach (var result in Listar)
                                {
                                    if (result.IdFRN != objSave.IdFRN)
                                    {
                                        indicaError = true;
                                        break;
                                    }
                                }
                            }
                        }
                        if (indicaError)
                        {
                            mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }
                }
            }

            return mensajesError;
        }

        /****************fin**********************/


        /*****************VALIDACION DE NOC NANDA*********************/


        public static List<ENTITY_MENSAJES> validoFormularioSS_HC_NocNanda(SS_HC_NandaNoc objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool indicaError = false;
            if (objSave != null)
            {

                if (objSave.Accion == "NUEVO" || objSave.Accion == "UPDATE")
                {
                    if (objSave.Descripcion != null)
                    {
                        SS_HC_NandaNoc objBusq = new SS_HC_NandaNoc();
                        objBusq.Accion = "LISTAR";
                        objBusq.Descripcion = objSave.Descripcion;
                        var Listar = new List<SS_HC_NandaNoc>();
                        Listar = SvcNocNanda.listarNocNanda(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            if (objSave.Accion == "NUEVO")
                            {
                                indicaError = true;
                            }
                            else if (objSave.Accion == "UPDATE")
                            {
                                foreach (var result in Listar)
                                {
                                    if (result.IdNanNoc != objSave.IdNanNoc)
                                    {
                                        indicaError = true;
                                        break;
                                    }
                                }
                            }
                        }
                        if (indicaError)
                        {
                            mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }
                }
            }

            return mensajesError;
        }
 
        /****************fin**********************/

        /********************VALIDACION DE NOC NIC***********************************/

        public static List<ENTITY_MENSAJES> validoFormularioSS_HC_NocNic(SS_HC_NocNic objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool indicaError = false;
            if (objSave != null)
            {

                if (objSave.Accion == "NUEVO" || objSave.Accion == "UPDATE")
                {
                    if (objSave.Descripcion != null)
                    {
                        SS_HC_NocNic objBusq = new SS_HC_NocNic();
                        objBusq.Accion = "LISTAR";
                        objBusq.Descripcion = objSave.Descripcion;
                        var Listar = new List<SS_HC_NocNic>();
                        Listar = SvcNocNic.listarNocNic(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            if (objSave.Accion == "NUEVO")
                            {
                                indicaError = true;
                            }
                            else if (objSave.Accion == "UPDATE")
                            {
                                foreach (var result in Listar)
                                {
                                    if (result.IdNC != objSave.IdNC)
                                    {
                                        indicaError = true;
                                        break;
                                    }
                                }
                            }
                        }
                        if (indicaError)
                        {
                            mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }
                }
            }

            return mensajesError;
        }

        /**********************FIN***********************************/

        /*********************VALIDACION DE NOC INDICADORPAE***********************************/
        
        public static List<ENTITY_MENSAJES> validoFormularioSS_HC_NocIndicador(SS_HC_NOCIndicador objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool indicaError = false;
            if (objSave != null)
            {

                if (objSave.Accion == "NUEVO" || objSave.Accion == "UPDATE")
                {
                    if (objSave.Descripcion != null)
                    {
                        SS_HC_NOCIndicador objBusq = new SS_HC_NOCIndicador();
                        objBusq.Accion = "LISTAR";
                        objBusq.Descripcion = objSave.Descripcion;
                        var Listar = new List<SS_HC_NOCIndicador>();
                        Listar = SvcNocIndicador.listarNocIndicador(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            if (objSave.Accion == "NUEVO")
                            {
                                indicaError = true;
                            }
                            else if (objSave.Accion == "UPDATE")
                            {
                                foreach (var result in Listar)
                                {
                                    if (result.IdNIN != objSave.IdNIN)
                                    {
                                        indicaError = true;
                                        break;
                                    }
                                }
                            }
                        }
                        if (indicaError)
                        {
                            mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }
                }
            }

            return mensajesError;
        }
        /*************************FIN*******************************/


        /****************VALIDACION DE NIC ACTIVIDADPAE*******************************************/

        public static List<ENTITY_MENSAJES> validoFormularioSS_HC_NicActividad(SS_HC_NICActividad objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool indicaError = false;
            if (objSave != null)
            {

                if (objSave.Accion == "NUEVO" || objSave.Accion == "UPDATE")
                {
                    if (objSave.Descripcion != null)
                    {
                        SS_HC_NICActividad objBusq = new SS_HC_NICActividad();
                        objBusq.Accion = "LISTAR";
                        objBusq.Descripcion = objSave.Descripcion;
                        var Listar = new List<SS_HC_NICActividad>();
                        Listar = SvcNicActividad.listarNicActividad(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            if (objSave.Accion == "NUEVO")
                            {
                                indicaError = true;
                            }
                            else if (objSave.Accion == "UPDATE")
                            {
                                foreach (var result in Listar)
                                {
                                    if (result.IdNA != objSave.IdNA)
                                    {
                                        indicaError = true;
                                        break;
                                    }
                                }
                            }
                        }
                        if (indicaError)
                        {
                            mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }
                }
            }

            return mensajesError;
        }

       /**********************FIN***************************************/

        /*****VALIDACION DE DOMINIOPAE**/

        public static List<ENTITY_MENSAJES> validoFormularioSS_HC_DominioPAE(SS_HC_DominioPAE objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool indicaError = false;
            if (objSave != null)
            {

                if (objSave.Accion == "NUEVO" || objSave.Accion == "UPDATE")
                {
                    if (objSave.Descripcion != null)
                    {
                        SS_HC_DominioPAE objBusq = new SS_HC_DominioPAE();
                        objBusq.Accion = "LISTAR";
                        objBusq.Descripcion = objSave.Descripcion;
                        var Listar = new List<SS_HC_DominioPAE>();
                        Listar = SvcDominio.listardominio(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            if (objSave.Accion == "NUEVO")
                            {
                                indicaError = true;
                            }
                            else if (objSave.Accion == "UPDATE")
                            {
                                foreach (var result in Listar)
                                {
                                    if (result.IdDominioPAE != objSave.IdDominioPAE)
                                    {
                                        indicaError = true;
                                        break;
                                    }
                                }
                            }
                        }
                        if (indicaError)
                        {
                            mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }
                }
            }

            return mensajesError;
        }





        /***FIN***/

        /*******VALIDACION DE CLASEPAE*****/

        public static List<ENTITY_MENSAJES> validoFormularioSS_HC_ClasePAE(SS_HC_ClasePAE objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool indicaError = false;
            if (objSave != null)
            {

                if (objSave.Accion == "NUEVO" || objSave.Accion == "UPDATE")
                {
                    if (objSave.Descripcion != null)
                    {
                        SS_HC_ClasePAE objBusq = new SS_HC_ClasePAE();
                        objBusq.Accion = "LISTAR";
                        objBusq.Descripcion = objSave.Descripcion;
                        var Listar = new List<SS_HC_ClasePAE>();
                        Listar = SvcClase.listarclase(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            if (objSave.Accion == "NUEVO")
                            {
                                indicaError = true;
                            }
                            else if (objSave.Accion == "UPDATE")
                            {
                                foreach (var result in Listar)
                                {
                                    if (result.IdClasePAE != objSave.IdClasePAE)
                                    {
                                        indicaError = true;
                                        break;
                                    }
                                }
                            }
                        }
                        if (indicaError)
                        {
                            mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }
                }
            }

            return mensajesError;
        }

        /******FIN******/

        /******VALIDACION DE ACTIVIDADES*************/

        public static List<ENTITY_MENSAJES> validoFormularioSS_HC_Actividades(SS_HC_Actividad objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool indicaError = false;
            if (objSave != null)
            {

                if (objSave.Accion == "NUEVO" || objSave.Accion == "UPDATE")
                {
                    if (objSave.Descripcion != null)
                    {
                        SS_HC_Actividad objBusq = new SS_HC_Actividad();
                        objBusq.Accion = "LISTAR";
                        objBusq.Descripcion = objSave.Descripcion;
                        var Listar = new List<SS_HC_Actividad>();
                        Listar = SvcActividades.listarActividades(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            if (objSave.Accion == "NUEVO")
                            {
                                indicaError = true;
                            }
                            else if (objSave.Accion == "UPDATE")
                            {
                                foreach (var result in Listar)
                                {
                                    if (result.IdActividad != objSave.IdActividad)
                                    {
                                        indicaError = true;
                                        break;
                                    }
                                }
                            }
                        }
                        if (indicaError)
                        {
                            mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }
                }
            }

            return mensajesError;
        }


          /*************fin*************/

        /***********************************************/

        public static List<ENTITY_MENSAJES> validoFormularioSS_HC_Favorito(SS_HC_Favorito objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool indicaError = false;
            if (objSave != null)
            {

                if (objSave.Accion == "NUEVO" || objSave.Accion == "UPDATE")
                {
                    if (objSave.Descripcion != null)
                    {
                        SS_HC_Favorito objBusq = new SS_HC_Favorito();
                        objBusq.Accion = "LISTAR";
                        objBusq.Descripcion = objSave.Descripcion;
                        var Listar = new List<SS_HC_Favorito>();
                        Listar = SvcFavorito.listarFavorito(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            if (objSave.Accion == "NUEVO")
                            {
                                indicaError = true;
                            }
                            else if (objSave.Accion == "UPDATE")
                            {
                                foreach (var result in Listar)
                                {
                                    if (result.Descripcion != objSave.Descripcion)
                                    {
                                        indicaError = true;
                                        break;
                                    }
                                }
                            }
                        }
                        if (indicaError)
                        {
                            mensaje = "La Descripcion del registro ya ha sido utilizado. Modificar la descripcion ingresado...'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }
                }
            }

            return mensajesError;
        }

        /*************FIN ***********/


        /***********VALIDACION DE INDICADORES******************************************/

                public static List<ENTITY_MENSAJES> validoFormularioSS_HC_IndicadorPAE(SS_HC_IndicadorPAE objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool indicaError = false;
            if (objSave != null)
            {

                if (objSave.Accion == "NUEVO" || objSave.Accion == "UPDATE")
                {
                    if (objSave.Descripcion != null)
                    {
                        SS_HC_IndicadorPAE objBusq = new SS_HC_IndicadorPAE();
                        objBusq.Accion = "LISTAR";
                        objBusq.Descripcion = objSave.Descripcion;
                        var Listar = new List<SS_HC_IndicadorPAE>();
                        Listar = SvcIndicador.listarindicador(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            if (objSave.Accion == "NUEVO")
                            {
                                indicaError = true;
                            }
                            else if (objSave.Accion == "UPDATE")
                            {
                                foreach (var result in Listar)
                                {
                                    if (result.IdIndicadorPAE != objSave.IdIndicadorPAE)
                                    {
                                        indicaError = true;
                                        break;
                                    }
                                }
                            }
                        }
                        if (indicaError)
                        {
                            mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }
                }
            }

            return mensajesError;
        }

        /**********FIN*******************************************/


                /*************REGISTRAR ACOMPAÑANTE****************************/

                public static List<ENTITY_MENSAJES> validoFormularioSS_HC_RAcompanante(SS_HC_RegistroAcompanante objSave)
                {
                    List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
                    String mensaje = null;
                    bool indicaError = false;
                    if (objSave != null)
                    {

                        if (objSave.Accion == "NUEVO" || objSave.Accion == "UPDATE")
                        {
                            if (objSave.Observaciones != null)
                            {
                                SS_HC_RegistroAcompanante objBusq = new SS_HC_RegistroAcompanante();
                                objBusq.Accion = "LISTAR";
                                objBusq.Observaciones = objSave.Observaciones;
                                var Listar = new List<SS_HC_RegistroAcompanante>();
                                Listar = SvcRegistroAcompanante.listarRegistroAcompanante(objBusq, 0, 0);
                                if (Listar.Count > 0)
                                {
                                    if (objSave.Accion == "NUEVO")
                                    {
                                        indicaError = true;
                                    }
                                    else if (objSave.Accion == "UPDATE")
                                    {
                                        foreach (var result in Listar)
                                        {
                                            if (result.IdAcompanante != objSave.IdAcompanante)
                                            {
                                                indicaError = true;
                                                break;
                                            }
                                        }
                                    }
                                }
                                if (indicaError)
                                {
                                    mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
                                    mensajesError.Add(new ENTITY_MENSAJES
                                    {
                                        DESCRIPCION = mensaje,
                                        IDCOMPONENTE = "txtDesc",
                                        NIVEL = 1
                                    });
                                }
                            }
                        }
                    }

                    return mensajesError;

                }

                /***************FIN****************************/

        public static List<ENTITY_MENSAJES> validoFormularioSS_HC_Formato(SS_HC_Formato objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool indicaError = false;
            if (objSave != null)
            {
                if (objSave.Accion == "DELETE")
                {
                    if (objSave.CodigoFormatoPadre != null)
                    {
                        SS_HC_Formato objBusq = new SS_HC_Formato();
                        objBusq.Accion = "LISTAR";
                        objBusq.CodigoFormatoPadre = objSave.CodigoFormato;
                        var Listar = new List<SS_HC_Formato>();

                        Listar = SvcFormato.listarFormato(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            mensaje = "El elemento seleccionado está siendo referenciado como 'Padre', en otro formato. No puede ser eliminado'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "CodigoFormatoPadre",
                                NIVEL = 1
                            });
                        }
                    }
                }
                else
                {
                    if (objSave.CodigoFormatoPadre != null && objSave.CodigoFormato != null)
                    {
                        SS_HC_Formato objBusq = new SS_HC_Formato();
                        objBusq.Accion = "LISTAR";
                        objBusq.CodigoFormato = objSave.CodigoFormato;
                        var Listar = new List<SS_HC_Formato>();



                        Listar = SvcFormato.listarFormato(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            if (objSave.Accion == "NUEVO")
                            {
                                indicaError = true;
                            }
                            else if (objSave.Accion == "UPDATE")
                            {
                                foreach (var result in Listar)
                                {
                                    if (result.CodigoFormatoPadre != objSave.CodigoFormatoPadre && result.CodigoFormato != objSave.CodigoFormato)
                                    {
                                        indicaError = true;
                                        break;
                                    }
                                }
                            }

                        }
                    }
                    if (indicaError)
                    {
                        mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
                        mensajesError.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensaje,
                            IDCOMPONENTE = "Codigo",
                            NIVEL = 1
                        });
                    }
                }               
            }
            return mensajesError;
        }
        /***************FIN***************/
        /**Validación Catálogo Unidad Servicio*/
        public static List<ENTITY_MENSAJES> validoFormularioCatUnidadServicio(SS_HC_CatalogoUnidadServicio objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool indicaError = false;
            if (objSave != null)
            {
                if (objSave.Accion == "DELETE")
                {
                    if (objSave.IdUnidadServicio != null)
                    {
                        SS_HC_CatalogoUnidadServicio objBusq = new SS_HC_CatalogoUnidadServicio();
                        objBusq.Accion = "LISTAR";
                        objBusq.IdUnidadServicioPadre = objSave.IdUnidadServicio;
                        var Listar = new List<SS_HC_CatalogoUnidadServicio>();

                        Listar = SvcCategoriaUnidadServicio.listarCatUnidadServicio(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            mensaje = "El elemento seleccionado está siendo referenciado como 'Padre', en otro catálogo. No puede ser eliminado'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "IdUnidadServicioPadre",
                                NIVEL = 1
                            });
                        }
                    }
                }
                else
                {
                    
                    if (objSave.CodigoUnidadServicio != null )
                    {
                        SS_HC_CatalogoUnidadServicio objBusq = new SS_HC_CatalogoUnidadServicio();
                        objBusq.Accion = "LISTAR";
                        objBusq.CodigoUnidadServicio = objSave.CodigoUnidadServicio;
                        var Listar = new List<SS_HC_CatalogoUnidadServicio>();

                        Listar = SvcCategoriaUnidadServicio.listarCatUnidadServicio(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            if (objSave.Accion == "NUEVO")
                            {
                                indicaError = true;
                            }
                            else if (objSave.Accion == "UPDATE")
                            {
                                foreach (var result in Listar)
                                {
                                    if (result.CodigoUnidadServicio != objSave.CodigoUnidadServicio)
                                    {
                                        indicaError = true;
                                        break;
                                    }
                                }
                            }

                        }
                    }
                    if (indicaError)
                    {
                        mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
                        mensajesError.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensaje,
                            IDCOMPONENTE = "Codigo",
                            NIVEL = 1
                        });
                    }
                }     
            }
            return mensajesError;
        }
        /***************FIN***************/

        /**Validación Maestro Cobertura*/
        public static List<ENTITY_MENSAJES> validoFormularioSS_SG_MaestroCobertura(SS_SG_MaestroCobertura objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            if (objSave != null)
            {
                if (objSave.ACCION == "NUEVO")
                {
                    if (objSave.CodigoCobertura != null)
                    {
                        SS_SG_MaestroCobertura objBusq = new SS_SG_MaestroCobertura();
                        objBusq.ACCION = "LISTAR";
                        objBusq.CodigoCobertura = objSave.CodigoCobertura;
                        var Listar = new List<SS_SG_MaestroCobertura>();
                        Listar = SvcCobertura.listarCobertura(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "txtDesc",
                                NIVEL = 1
                            });
                        }
                    }
                }
            }

            return mensajesError;
        }
        /***************FIN***************/

        /**Validación Maestro Tipo Atención*/
        public static List<ENTITY_MENSAJES> validoFormularioSS_GE_TipoAtencion(SS_GE_TipoAtencion objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool indicaError = false;
            if (objSave != null)
            {
                if (objSave.Accion == "NUEVO" || objSave.Accion == "UPDATE")
                {
                    if (objSave.Codigo != null)
                    {
                        SS_GE_TipoAtencion objBusq = new SS_GE_TipoAtencion();
                        objBusq.Accion = "LISTAR";
                        objBusq.Codigo = objSave.Codigo;
                        var Listar = new List<SS_GE_TipoAtencion>();

                        Listar = SvcTipoAtencion.listarTipoAtencion(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            if (objSave.Accion == "NUEVO")
                            {
                                indicaError = true;
                            }
                            else if (objSave.Accion == "UPDATE")
                            {
                                foreach (var result in Listar)
                                {
                                    if (result.IdTipoAtencion != objSave.IdTipoAtencion)
                                    {
                                        indicaError = true;
                                        break;
                                    }
                                }
                            }

                        }
                    }
                    if (indicaError)
                    {
                        mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
                        mensajesError.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensaje,
                            IDCOMPONENTE = "Codigo",
                            NIVEL = 1
                        });
                    }
                }
            }

            return mensajesError;
        }

        /**Validación Maestro Sucursal*/
        public static List<ENTITY_MENSAJES> validoFormularioAC_Sucursal(AC_Sucursal objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            if (objSave != null)
            {
                if (objSave.ACCION != "DELETE")
                {
                    if (objSave.Sucursal != null)
                    {
                        if (objSave.Sucursal.Trim().Length == 0)
                        {
                            mensaje = "Debe ingresar un valor para el campo 'Sucursal'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "tfCodigo",
                                NIVEL = 1
                            });
                            //mensajesError.Add(mensaje);
                        }
                    }
                    else
                    {
                        mensaje = "Debe ingresar un valor para el campo 'Sucursal'";
                        mensajesError.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensaje,
                            IDCOMPONENTE = "tfCodigo",
                            NIVEL = 1
                        });
                    }
                    if (objSave.DescripcionLocal != null)
                    {
                        if (objSave.DescripcionLocal.Trim().Length == 0)
                        {
                            mensaje = "Debe ingresar un valor para el campo 'Nombre'";
                            mensajesError.Add(new ENTITY_MENSAJES
                            {
                                DESCRIPCION = mensaje,
                                IDCOMPONENTE = "tfNombre",
                                NIVEL = 1
                            });
                        }
                    }
                    else
                    {
                        mensaje = "Debe ingresar un valor para el campo 'Nombre'";
                        mensajesError.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensaje,
                            IDCOMPONENTE = "tfNombre",
                            NIVEL = 1
                        });
                    }
                }
            }
            return mensajesError;
        }

        /**Validación Maestro Agente*/
        public static List<ENTITY_MENSAJES> validoFormularioSG_Agente(SG_Agente objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool  indicaError = false;
            if (objSave != null)
            {
                if (objSave.TipoAgente == null && objSave.IdEmpleado == null && objSave.ACCION != "DELETE")
                {
                    mensaje = "No se realizó ningún cambio";
                    mensajesError.Add(new ENTITY_MENSAJES
                    {
                        DESCRIPCION = mensaje,
                        IDCOMPONENTE = "IdEmpleado",
                        NIVEL = 1
                    });
                    //mensajesError.Add(mensaje);
                }
                else if ( objSave.ACCION != "DELETE")
                {
                    if (objSave.CodigoAgente != null)
                    {
                        SG_Agente objBusq = new SG_Agente();
                        objBusq.ACCION = "VALIDARCODIGO";
                        objBusq.IdAgente = objSave.IdAgente;
                        objBusq.IdEmpleado = objSave.IdEmpleado;
                        objBusq.CodigoAgente = objSave.CodigoAgente;
                        var Listar = new List<SG_Agente>();
                        Listar = SvcSG_Agente.listarSG_Agente(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            if (objSave.ACCION == "NUEVO")
                            {
                                indicaError = true;
                            }
                            else if (objSave.ACCION == "UPDATE")
                            {
                                foreach (var result in Listar)
                                {
                                    if (result.IdAgente != objSave.IdAgente)
                                    {
                                        indicaError = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }
                    if (indicaError)
                    {
                        mensaje = "El Código de Agente ingresado (" + objSave.CodigoAgente + ") ya ha sido empleado. Ingresar otro 'código'.";
                        mensajesError.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensaje,
                            IDCOMPONENTE = "CodigoAgente",
                            NIVEL = 1
                        });
                    }                            
                }
            }
            return mensajesError;
        }

        /******Validacion Agente Opcion*****/

        public static List<ENTITY_MENSAJES> validoFormularioSG_AgenteOpcion(SG_AgenteOpcion objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;          
            if (objSave != null)
            {
                if (objSave.IdOpcion == null && objSave.IndicadorAcceso == null && objSave.IndicadorEliminar == null && objSave.IndicadorHabilitado == null && objSave.IndicadorImprimir == null && objSave.IndicadorModificar == null && objSave.IndicadorNuevo == null  && objSave.Accion != "DELETE")
                {
                    mensaje = "No se realizó ningún cambio";
                    mensajesError.Add(new ENTITY_MENSAJES
                    {
                        DESCRIPCION = mensaje,
                        IDCOMPONENTE = "IdAgente",
                        NIVEL = 1
                    });
                    //mensajesError.Add(mensaje);
                }
               
            }
            return mensajesError;
        }

        /**Validación Maestro Opciones*/
        public static List<ENTITY_MENSAJES> validoFormularioSG_Opcion(SG_Opcion objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool indicaError = false;
            if (objSave != null)
            {
                if (objSave.Accion == "DELETE")
                {
                    SG_Opcion objBusq = new SG_Opcion();
                    objBusq.Accion = "LISTAR";
                    objBusq.IdOpcionPadre = objSave.IdOpcion;
                    var Listar = new List<SG_Opcion>();
                    Listar = SvcSG_Opcion.listarSG_Opcion(objBusq, 0, 0);
                    if (Listar.Count > 0)
                    {
                        mensaje = "El elemento seleccionado (" + objSave .IdOpcionPadre+ ") está siendo referenciado como 'Padre', en otro registro. No puede ser eliminado'";
                        
                        mensajesError.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensaje,
                            IDCOMPONENTE = "IdOpcionPadre",
                            NIVEL = 1
                        });

                    }
                }
                else
                {                    
                    SG_Opcion objBusq = new SG_Opcion();
                    objBusq.Accion = "LISTAR";
                    objBusq.CodigoOpcion = objSave.CodigoOpcion;
                    var Listar = new List<SG_Opcion>();
                    Listar = SvcSG_Opcion.listarSG_Opcion(objBusq, 0, 0);
                    if (Listar.Count > 0)
                    {
                        if (objSave.Accion == "NUEVO" )
                        {
                            indicaError = true;
                        }
                        else
                        {
                            foreach (var result in Listar){
                                if (result.IdOpcion != objSave.IdOpcion) 
                                {
                                    indicaError = true;
                                    break;
                                }
                            }
                        }
                    }
                    if (indicaError)
                    {
                        mensaje = "El Código de Opción ingresado (" + objSave.CodigoOpcion + ") ya ha sido empleado. Ingresar otro 'código'.";

                        mensajesError.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensaje,
                            IDCOMPONENTE = "IdOpcion",
                            NIVEL = 1
                        });
                    }
                }
            }
            return mensajesError;
        }

        /**Validación Maestro SS_HC_UnidadMedidaMinsa*/
        public static List<ENTITY_MENSAJES> validoFormularioSS_HC_UnidadMedidaMinsa(SS_HC_UnidadMedidaMinsa objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool indicaError = false;
            if (objSave != null)
            {
                if (objSave.Accion == "NUEVO" || objSave.Accion == "UPDATE")
                {
                    if (objSave.Codigo != null)
                    {
                        SS_HC_UnidadMedidaMinsa objBusq = new SS_HC_UnidadMedidaMinsa();
                        objBusq.Accion = "LISTAR";
                        objBusq.Codigo = objSave.Codigo;
                        var Listar = new List<SS_HC_UnidadMedidaMinsa>();

                        Listar = SvcUnidadMedidaMinsa.listarUnidadMedidaMinsa(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            if (objSave.Accion == "NUEVO")
                            {
                                indicaError = true;
                            }
                            else if (objSave.Accion == "UPDATE")
                            {
                                foreach (var result in Listar)
                                {
                                    if (result.IdUnidadMedida != objSave.IdUnidadMedida)
                                    {
                                        indicaError = true;
                                        break;
                                    }
                                }
                            }

                        }
                    }
                    if (indicaError)
                    {
                        mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
                        mensajesError.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensaje,
                            IDCOMPONENTE = "Codigo",
                            NIVEL = 1
                        });
                    }
                }
            }
            return mensajesError;
        }

        /**UTILES*/

        /***************/
        public static List<ENTITY_MENSAJES> validoFormularioSS_HC_NANDA(SS_HC_NANDA objSave)
        {
            List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            bool indicaError = false;
            bool indicaError2 = false;
            if (objSave != null)
            {
                if (objSave.Accion == "NUEVO" || objSave.Accion == "UPDATE")
                {
                    if (objSave.Codigo != null)
                    {
                        SS_HC_NANDA objBusq = new SS_HC_NANDA();
                        objBusq.Accion = "LISTARN";
                        objBusq.Codigo = objSave.Codigo;
                        var Listar = new List<SS_HC_NANDA>();

                        Listar = SvcNanda.listarNanda(objBusq, 0, 0);
                        if (Listar.Count > 0)
                        {
                            if (objSave.Accion == "NUEVO")
                            {
                                if (Int32.Parse(objSave.CodigoPadre) == Int32.Parse(objSave.Codigo))
                                {
                                    indicaError2 = true;
                                }
                                else { indicaError = true; } 
                            }
                            else if (objSave.Accion == "UPDATE")
                            {
                                foreach (var result in Listar)
                                {
                                    if (result.IdNanda != objSave.IdNanda)
                                    {
                                        indicaError = true;
                                        break;
                                    }
                                }
                                if (Int32.Parse(objSave.CodigoPadre) == Int32.Parse(objSave.Codigo))
                                {
                                    // ENTITY_GLOBAL.Instance.MENSAJE_ERROR = "No puede asignar un padre a si mismo"; 
                                    indicaError2 = true;
                                }
                            }

                        }
                    }
                    if (indicaError)
                    {
                        mensaje = "El código del registro ya ha sido utilizado. Modificar el código ingresado.'";
                        mensajesError.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensaje,
                            IDCOMPONENTE = "Codigo",
                            NIVEL = 1
                        });
                    }
                    if (indicaError2)
                    {
                        mensaje = "No puede asignar un padre a si mismo.";
                        mensajesError.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensaje,
                            IDCOMPONENTE = "txtDesc",
                            NIVEL = 1
                        });
                    }
                }
            }
            return mensajesError;
        }

        /**PARA CADA COMPOENTE ENVIADO SE SETEA UNA PROPIEDAD O ATRIBUTO RECIBIDO (Los valores se transformana dinámicamente)*/
        public static Object setPropiedadesComponenteForm(Object componente, String atributo,
            Object valor, String tipoDato)
        {
            try
            {
                dynamic valorX = valor;
                /*if (tipoDato=="B")
                {
                    if (valorX == 1)
                    {
                        valorX = true;
                    }
                    else
                    {
                        valorX = false;
                    }
                } */
                Type magicType = componente.GetType();
                System.Reflection.PropertyInfo magicPro = magicType.GetProperty("" + atributo);
                Type magicPropertyType = magicPro.PropertyType;
                valorX = Convert.ChangeType(valorX, magicPropertyType);
                magicPro.SetValue(componente, valorX);

                //MethodInfo magicMethod = magicType.GetMethod("GetHashCode");
                //object magicValue = magicMethod.Invoke(magicClassObject, new object[] {});
                //magicPro.SetValue(componente, 1);
                object magicValuePro = magicPro.GetValue(componente);
                //object magicValueMet = magicMethod.Invoke(field01, new object[] { });
                var magicValueX = magicValuePro;
                return componente;
            }
            catch (Exception ex)
            {               
                return null;
            }
            return componente;
        }


        public static bool validoItem(string tipoAtributoValor, object valor, string tipoDato,
            String valTexto, Nullable<Decimal> valNumero, Nullable<DateTime> valDate)
        {
            string VAL_NULLABLE = "VAL_NULLABLE";
            string VAL_MAX = "VAL_MAX";
            string VAL_MIN = "VAL_MIN";
            if (VAL_NULLABLE == tipoAtributoValor)
            {
                if ((valTexto + "").Trim() == "S")
                {
                    if (valor == null)
                    {
                        return false;
                    }
                    else
                    {
                        if (valor is string)
                        {
                            if (valor == "")
                            {
                                return false;
                            }
                        }
                    }
                }
            }
            else if (VAL_MAX == tipoAtributoValor)
            {
                try
                {
                    if (valNumero != null && valor != null)
                    {
                        if ((tipoDato + "").Trim() == "N")
                        {
                            Nullable<Decimal> valorX = null;
                            var type = valor.GetType().Name;
                            if (type.ToLower() == "int32")
                            {
                                valorX = new Decimal((int)valor);
                            }
                            else if (type.ToLower() == "double")
                            {
                                valorX = new Decimal((double)valor);
                            }
                            else if (type.ToLower() == "float")
                            {
                                valorX = new Decimal((float)valor);
                            }
                            else if (type.ToLower() == "int64")
                            {
                                valorX = new Decimal((int)valor);
                            }
                            //valor.getClass().cast(valor)                                                    
                            if (valorX != null)
                            {
                                if (valorX > valNumero)
                                {
                                    return false;
                                }
                            }
                        }
                        else
                        {

                        }
                    }
                }
                catch (Exception ee)
                {

                }
            }
            return true;
        }

        /*****TRATAMIENTO DE PARÁMTETROS*************/
        public static void loadAllParametro_Formulario(List<String> paramClaves, String indica)
        {
            /**por impl*/
        }
        public static Object loadParametro_Formulario(String paramClave, String indica, bool forzar)
        {
            Object param = getParametro_Form(paramClave);
            if (param == null || forzar)
            {
                List<ParametrosMast> listaParam = new List<ParametrosMast>();
                ParametrosMast objParam = new ParametrosMast();
                objParam.Accion = "LISTAR";
                objParam.CompaniaCodigo = "999999";
                objParam.AplicacionCodigo = "WA";//obs
                objParam.ParametroClave = paramClave;
                listaParam = SvcParametro.listarParametro(objParam, 0, 0);
                if (listaParam.Count > 0)
                {
                    if ((listaParam[0].TipodeDatoFlag + "").Trim() == "T")
                    {
                        param = (listaParam[0].Texto+"").Trim();
                    }
                    else if ((listaParam[0].TipodeDatoFlag + "").Trim() == "F")
                    {
                        param = listaParam[0].Fecha;
                    }
                    else if ((listaParam[0].TipodeDatoFlag + "").Trim() == "N")
                    {
                        param = listaParam[0].Numero;
                    }
                    else
                    {
                        param = null;
                    }
                }
                setParametro_Form(paramClave, param);
            }
            return param;
        }

      
        public static Object loadParametro_Session(String paramClave, String indica, bool forzar, List<ParametrosMast>listxx )
        {
            List<ParametrosMast> listaParam = listxx.Where(x => x.ParametroClave == paramClave).ToList();
            Object param = getParametro_Form(paramClave);
            if (param == null || forzar)
            {   
                if (listaParam.Count > 0)
                {
                    if ((listaParam[0].TipodeDatoFlag + "").Trim() == "T")
                    {
                        param = (listaParam[0].Texto + "").Trim();
                    }
                    else if ((listaParam[0].TipodeDatoFlag + "").Trim() == "F")
                    {
                        param = listaParam[0].Fecha;
                    }
                    else if ((listaParam[0].TipodeDatoFlag + "").Trim() == "N")
                    {
                        param = listaParam[0].Numero;
                    }
                    else
                    {
                        param = null;
                    }
                }
                setParametro_Form(paramClave, param);
            }
            return param;
        }


        public static Object getParametro_Form(String paramClave)
        {
            if (paramClave != null)
            {
                if (DICT_PARAMETROS.ContainsKey("" + paramClave))
                {
                    return DICT_PARAMETROS[paramClave];
                }
                else
                {
                    return null;
                }
            }
            else
            {
                return null;
            }
        }
        public static void setParametro_Form(String paramClave, Object paramValor)
        {
            if (paramClave != null)
            {
                DICT_PARAMETROS[paramClave] = paramValor;
            }
        }
        public static void inicializarParametros_Form(bool reiniciar)
        {
            if (reiniciar)
            {
                DICT_PARAMETROS = new Dictionary<String, Object>();
           }
        }
        public static void inicializarFilesBytesUploaded_HCE(bool reiniciar)
        {
            if (reiniciar)
            {
                DICT_FILESbytes = new Dictionary<String, Object>();
            }
        }
        public static Object getFilesBytesUploaded_HCE(String fileClave)
        {
            if (fileClave != null)
            {
                if (DICT_PARAMETROS.ContainsKey("" + fileClave))
                {
                    return DICT_PARAMETROS[fileClave];
                }
                else
                {
                    return null;
                }
            }
            else
            {
                return null;
            }
        }
        public static void setFilesBytesUploaded_HCE(String fileClave, Object fileByteValor)
        {
            if (fileClave != null)
            {
                DICT_PARAMETROS[fileClave] = fileByteValor;
            }
        }
        /***CÓDIGO HCE****/
        public static String getCodigoTransaccionHCE(Nullable<long> id01, Nullable<long> id02,
            Nullable<long> id03, Nullable<int> idAux, string codigo)
        {            
            String codigoHCE = "";
            if (codigo != null && codigo != "")
            {
                codigoHCE = codigo + "-";
            }
            String codigoId01 = "";
            if (id01 != null && id01!=0)
            {
                codigoId01 = String.Format("{0:000000}", id01);
            }
            else if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA")
            {
                codigoId01 = String.Format("{0:000000}", ENTITY_GLOBAL.Instance.EpisodioClinico); 
            }
            else
            {
                codigoId01 = "[Sin Ep. Clínico]";
            }
            codigoHCE = codigoHCE + codigoId01 + "." +
                //String.Format("{0:000000}", id02) +"."+
                String.Format("{0:000000}", ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" ? id02:id03)
                
                ;
            return codigoHCE;
        }
        public static String getCodigoTransaccionTriajeHCE(Nullable<long> id01, Nullable<long> id02,
           Nullable<long> id03, Nullable<int> idAux, string codigo)
        {
            String codigoHCE = "";
            if (codigo != null && codigo != "")
            {
                codigoHCE = codigo + "-";
            }
            String codigoId01 = "";
            if (id01 != null && id01 != 0)
            {
                codigoId01 = String.Format("{0:000000}", id01);
            }
            else
            {
                codigoId01 = "[Sin Ep. Triaje]";
            }
            codigoHCE = codigoHCE  +
                //String.Format("{0:000000}", id02) +"."+
                String.Format("{0:000000}",  id02)

                ;
            return codigoHCE;
        }

        public static Object getMsgLabelAuxiliar_Form(String indicador, Object valorKey)
        {
            Object result=null;
            if (valorKey != null && indicador!=null)
            {
                if (indicador == "TRIAJE_IMC")
                {
                    var mensajeSalud="";
                    decimal imc = (decimal)valorKey;
                    
                    if (imc < 16)
                    {
                        mensajeSalud = "Delgadez Severa";
                    }
                    else if (imc < 17)
                    {
                        mensajeSalud = "Delgadez Moderada";
                    }
                    else if (Decimal.Compare(imc, Convert.ToDecimal(18.5))<0)
                    {
                        mensajeSalud = "Delgadez Aceptable";
                    }
                    else if (imc < 25)
                    {
                        mensajeSalud = "Peso Normal";
                    }
                    else if (imc < 30)
                    {
                        mensajeSalud = "Sobrepeso";
                    }
                    else if (imc < 35)
                    {
                        mensajeSalud = "Obeso: Tipo I";
                    }
                    else if (imc < 40)
                    {
                        mensajeSalud = "Obeso: Tipo II";
                    }
                    else if (imc >= 40)
                    {
                        mensajeSalud = "Obeso: Tipo III";
                    }
                    result = mensajeSalud;
                }
                else
                {

                }

            }
            return result;
        }


        public static ParametrosMast getParametro_Formulario(String paramClave, String indica)
        {
            ParametrosMast param = null;
            if (paramClave!=null)
            {          
                ParametrosMast objParam = new ParametrosMast();                
                objParam.CompaniaCodigo = "999999";
                objParam.AplicacionCodigo = "WA";//obs
                objParam.ParametroClave = paramClave;
                param = SvcParametro.getMantenimientoPoId(objParam);                    
            }
            return param;
        }

    }
}