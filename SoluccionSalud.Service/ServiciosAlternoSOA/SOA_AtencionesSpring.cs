using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.SOA.Bussines.SOA_Atenciones;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.ServiciosAlternoSOA
{
    public class SOA_AtencionesSpring
    {
        public static List<SoluccionSalud.SOA.Entidades.VW_ATENCIONPACIENTE_GENERAL> ListaAtenciones(SoluccionSalud.SOA.Entidades.VW_ATENCIONPACIENTE_GENERAL ObjTrace)
        {
            return new AtencionesOrigenBLL().ListaAtenciones(ObjTrace);
        }
        public static int ListaConsultaExterna(SoluccionSalud.SOA.Entidades.SS_HCE_ConsultaExterna ObjTrace)
        {
            return new AtencionesOrigenBLL().ListaConsultaExterna(ObjTrace);
        }
        public static int ListaConsultaExternaEmergencia(SS_HCE_ConsultaExterna ObjTrace)
        {
            int registro = 0;
            SoluccionSalud.SOA.Entidades.SS_HCE_ConsultaExterna objEntidad = getVW_CONSULTA_EXTERNA(ObjTrace);
            registro = ListaConsultaExterna(objEntidad);
            return registro;
        }

        public static int ListaRecetaConsultaExterna(SoluccionSalud.SOA.Entidades.SS_HCE_RecetaConsultaExterna ObjTrace)
        {
            return new AtencionesOrigenBLL().ListaRecetaConsultaExterna(ObjTrace);
        }
        public static int ListaRecetaConsultaExternaEmergencia(SS_HCE_RecetaConsultaExterna ObjTrace)
        {
            int registro = 0;
            SoluccionSalud.SOA.Entidades.SS_HCE_RecetaConsultaExterna objEntidad = getVW_RECETA_CONSULTA_EXTERNA(ObjTrace);
            registro = ListaRecetaConsultaExterna(objEntidad);
            return registro;
        }

        public static List<VW_ATENCIONPACIENTE_GENERAL> ListaPacienteTeleSalud(VW_ATENCIONPACIENTE_GENERAL ObjTrace, String PARAM_ACTIVOSOA)
        {
            List<VW_ATENCIONPACIENTE_GENERAL> ListaAtencionHCE = new List<VW_ATENCIONPACIENTE_GENERAL>();
            VW_ATENCIONPACIENTE_GENERAL objAuxHCE;
            List<SoluccionSalud.SOA.Entidades.VW_ATENCIONPACIENTE_GENERAL> ListarGeneral = new List<SoluccionSalud.SOA.Entidades.VW_ATENCIONPACIENTE_GENERAL>();

            bool indicaACTIVOSOA = true;
            if (PARAM_ACTIVOSOA != null && PARAM_ACTIVOSOA != "")
            {
                indicaACTIVOSOA = (PARAM_ACTIVOSOA == "N" ? false : true);
            }

            var Listar = new List<VW_ATENCIONPACIENTE>();
            var LocalEnty = new VW_ATENCIONPACIENTE();

            ObjTrace.Accion = "LISTARTELE";
            ListaAtencionHCE = SoluccionSalud.Service.VW_ATENCIONPACIENTEService.SvcVw_AtencionPaciente.listarVwAtencionPacienteGeneral(ObjTrace, ObjTrace.NumeroFila, ObjTrace.Contador);
            SoluccionSalud.Service.VW_ATENCIONPACIENTEService.SvcVw_AtencionPaciente.listarVwAtencionPaciente(ObjTrace, ListaAtencionHCE, 0, 0);
            return ListaAtencionHCE;
        }

        public static List<VW_ATENCIONPACIENTE_GENERAL> ListaAtencionesHCE(VW_ATENCIONPACIENTE_GENERAL ObjTrace, String PARAM_ACTIVOSOA)
        {
            List<VW_ATENCIONPACIENTE_GENERAL> ListaAtencionHCE = new List<VW_ATENCIONPACIENTE_GENERAL>();
            VW_ATENCIONPACIENTE_GENERAL objAuxHCE;
            List<SoluccionSalud.SOA.Entidades.VW_ATENCIONPACIENTE_GENERAL> ListarGeneral = new List<SoluccionSalud.SOA.Entidades.VW_ATENCIONPACIENTE_GENERAL>();

            /**por cambiar GET SOA ... add campos*/
            SoluccionSalud.SOA.Entidades.VW_ATENCIONPACIENTE_GENERAL objEntidad =
                getVW_ATENCIONPACIENTE_GENERAL_SOA(ObjTrace);

            if (ObjTrace.EstadoEpiAtencion == null || ObjTrace.EstadoEpiAtencion == 0)
            {

            }
            bool indicaACTIVOSOA = true;
            if (PARAM_ACTIVOSOA != null && PARAM_ACTIVOSOA != "")
            {
                indicaACTIVOSOA = (PARAM_ACTIVOSOA == "N" ? false : true);
            }

            var Listar = new List<VW_ATENCIONPACIENTE>();
            var LocalEnty = new VW_ATENCIONPACIENTE();
            if (indicaACTIVOSOA)
            {
                ListarGeneral = ListaAtenciones(objEntidad);
            }
            int cantidadTotal = 0;
            int cantidadHCE = 0;
            int cantidadHCEfiltro = 0;
            if (ListarGeneral == null)
            {
                //  ListarGeneral = new List<SoluccionSalud.SOA.Entidades.VW_ATENCIONPACIENTE_GENERAL>();
            }
            if (ListarGeneral.Count > 0)
            {
                if (ObjTrace.tipoListado == "MED_AUDITORIA" || ObjTrace.tipoListado == "MED_AMBULATORIO" || ObjTrace.tipoListado == "TECNOMED_AMBULATORIO" || ObjTrace.tipoListado == "MED_EMERGENCIA2" || ObjTrace.tipoListado == "ENFERM_EMERGENCIAS")
                {                 
                    cantidadTotal = ListarGeneral[0].Contador;
                    foreach (SoluccionSalud.SOA.Entidades.VW_ATENCIONPACIENTE_GENERAL result in ListarGeneral)
                    {
                        objAuxHCE = getVW_ATENCIONPACIENTE_GENERAL_HCE(result);
                        ListaAtencionHCE.Add(objAuxHCE);
                    }
                }
                //if (ObjTrace.tipoListado == "MED_AMBULATORIO")
                //{
                   
                //    cantidadTotal = ListarGeneral[0].Contador;
                //    foreach (SoluccionSalud.SOA.Entidades.VW_ATENCIONPACIENTE_GENERAL result in ListarGeneral)
                //    {
                //        objAuxHCE = getVW_ATENCIONPACIENTE_GENERAL_HCE(result);
                //        ListaAtencionHCE.Add(objAuxHCE);
                //    }
                //}
                else
                {
                    /*****CASO  HAYA RESULTADOS EN EL LISTADO EXTERNO SOA***/
                    cantidadTotal = ListarGeneral[0].Contador;

                    // List<SoluccionSalud.SOA.Entidades.VW_ATENCIONPACIENTE_GENERAL> ListarGeneral2 = new List<SoluccionSalud.SOA.Entidades.VW_ATENCIONPACIENTE_GENERAL>();
                    // ListarGeneral = ListarGeneral.OrderBy(o => o.IdOrdenAtencion).ThenBy(o => o.LineaOrdenAtencion).ToList();
                    // .ThenBy(o => o.CitaFecha)

                    ListarGeneral = ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" ? ListarGeneral.OrderBy(o => o.CitaHora).OrderBy(Y => Y.IdOrdenAtencion).ToList() : ListarGeneral.OrderBy(o => o.CitaFecha).ToList();
                    /**MATCH CON EPISODIOS DE ATENCIÓN*/
                    foreach (SoluccionSalud.SOA.Entidades.VW_ATENCIONPACIENTE_GENERAL result in ListarGeneral)
                    {
                        Listar = new List<VW_ATENCIONPACIENTE>();
                        LocalEnty = new VW_ATENCIONPACIENTE();

                        LocalEnty.Accion = "LISTAR";
                        LocalEnty.NumeroFile = 0;
                        LocalEnty.IdPaciente = result.IdPaciente;
                        LocalEnty.CodigoOA = result.CodigoOA;
                        LocalEnty.IdOrdenAtencion = result.IdOrdenAtencion;
                        LocalEnty.TipoOrdenAtencion = result.TipoOrdenAtencion;
                        LocalEnty.LineaOrdenAtencion = ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" ? result.LineaOrdenAtencion : 0;
                        LocalEnty.FechaInicioDescansoMedico = result.FechaInicio;
                        LocalEnty.FechaFinDescansoMedico = result.FechaFin;


                        /***CASO ESPECIAL: LISTADOS DE TECNÓLOGOS MÉDICOS****/
                        // ObjTrace.tipoListado == "TECNOMED_AMBULATORIO" ||
                        //ObjTrace.tipoListado == "TECNOMED_EMERGENCIA" ||
                        if (ObjTrace.tipoListado == "TECNOMED_HOSP_CIRUGIA")
                        {
                            SS_HC_ProcedimientoEjecucion objProcEjexAux = new SS_HC_ProcedimientoEjecucion();
                            List<SS_HC_ProcedimientoEjecucion> listaProcEjexAux = new List<SS_HC_ProcedimientoEjecucion>();

                            objProcEjexAux.UnidadReplicacion = ObjTrace.UnidadReplicacion;
                            objProcEjexAux.IdPaciente = Convert.ToInt32(result.IdPaciente);
                            if (result.EpisodioClinicoHCE != null)
                            {
                                objProcEjexAux.EpisodioClinico = Convert.ToInt32(result.EpisodioClinicoHCE);
                            }
                            ////////
                            objProcEjexAux.UnidadReplicacionSolicitado = result.UnidadReplicacionHCE;
                            objProcEjexAux.EpisodioClinicoSolicitado = result.EpisodioClinicoHCE;
                            objProcEjexAux.IdEpisodioAtencionSolicitado = result.IdEpisodioAtencionHCE;
                            objProcEjexAux.SecuenciaSolicitado = result.SecuenciaHCE;
                            objProcEjexAux.ACCION = "LISTARPORORIGEN";

                            listaProcEjexAux = SoluccionSalud.Service.ProcedimientoEjecucionService.SvcProcedimientoEjecucion.listarSS_HC_ProcedimientoEjecucion(objProcEjexAux, 0, 0);
                            if (listaProcEjexAux.Count > 0)
                            {
                                /**Cruzar por PROCEDIMIENTO EJECUCIÓN*/
                                LocalEnty.UnidadReplicacion = listaProcEjexAux[0].UnidadReplicacion;
                                LocalEnty.EpisodioClinico = listaProcEjexAux[0].EpisodioClinico;
                                LocalEnty.IdEpisodioAtencion = listaProcEjexAux[0].IdEpisodioAtencion;
                                Listar = SoluccionSalud.Service.VW_ATENCIONPACIENTEService.SvcVw_AtencionPaciente.listarVwAtencionPaciente(LocalEnty, 0, 0);
                            }
                        }
                        else
                        {
                            /**CASO GENERAL: LISTADOS DE MÉDICOS, ENFERMERAS Y OBSTETRIZ  (Cruzar por LÍNEA DE OA) **/
                            LocalEnty.LineaOrdenAtencion = result.LineaOrdenAtencion;
                            // LocalEnty.Estado = result.IdHospitalizacion;
                            //if (ObjTrace.EstadoEpiAtencion != 0){}
                            //   foreach (cantidadTotal in ListarGeneral)
                            //   {
                            Listar = SoluccionSalud.Service.VW_ATENCIONPACIENTEService.SvcVw_AtencionPaciente.listarVwAtencionPaciente(LocalEnty, 0, 0);
                            // }
                        }
                        if (Listar.Count > 0)
                        {
                            var count = 0;
                            var resultado = 0;
                            if (ObjTrace.tipoListado == "MED_AUDITORIA")
                            {

                            }
                            else
                            {
                                result.FechaFin = Listar[0].FechaFinDescansoMedico;
                            }
                            if (result.EstadoEpiAtencion == 4)
                            {
                                result.EstadoEpiAtencion = 4;
                                result.CodigoEpisodioClinico = 4;
                            }
                            else if (result.EstadoEpiAtencion == 5)
                            {
                                result.EstadoEpiAtencion = 5;
                                result.CodigoEpisodioClinico = 5;
                            }
                            else
                            {
                                result.EstadoEpiAtencion = Listar[0].Estado;
                                result.EstadoEpiClinico = Listar[0].EstadoEpiClinico;
                                result.CodigoEpisodioClinico = Listar[0].EstadoEpiClinico;
                            }
                            if (ObjTrace.tipoListado == "MED_EMERGENCIA2" || ObjTrace.tipoListado == "ENFERM_EMERGENCIAS")
                            {
                                if (ObjTrace.tipoListado == "ENFERM_EMERGENCIAS")
                                {
                                    foreach (VW_ATENCIONPACIENTE Objresult in Listar)
                                    {
                                        if (Objresult.DescansoMedico == "08")
                                        {
                                            result.MedicoNombre = Objresult.NombreEmergencia;
                                        }
                                    }
                                }

                                if (Listar[0].SecAsigMed == 3 && result.IdHospitalizacion == 2)// indicadoraltamedida=2 / if (Listar[0].Estado == 3 && Listar[0].IdUbicacion == 3)
                                {
                                    result.EstadoEpiAtencion = 3;
                                    result.CodigoEpisodioClinico = 3;
                                }
                                else if (result.IdHospitalizacion == 2 && ObjTrace.tipoListado == "ENFERM_EMERGENCIAS")
                                {
                                    result.EstadoEpiAtencion = 3;
                                    result.CodigoEpisodioClinico = 3;
                                }
                                else if (Listar[0].Estado == 3 && Listar[0].IdUbicacion == 4)
                                {
                                    result.EstadoEpiAtencion = 2;
                                    result.CodigoEpisodioClinico = 2;
                                }
                                else if (Listar[0].Estado == 3 && Listar[0].IdUbicacion == null)
                                {
                                    result.EstadoEpiAtencion = 2;
                                    result.CodigoEpisodioClinico = 2;
                                }

                                if (result.TipoOrdenAtencion == 11 || result.TipoOrdenAtencion == 5 || (result.TipoOrdenAtencion == 1 && result.LineaOrdenAtencion != 1))
                                {
                                    count = Listar.Count;
                                    foreach (var listaInterconsultas in Listar)
                                    {
                                        if (listaInterconsultas.Estado == 3)
                                        {
                                            resultado++;
                                        }
                                    }
                                    if (resultado == count && (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER != "RE-Ingreso"
                                   && ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER != "Relevo"
                                   && (result.TipoOrdenAtencion == 11 && result.IdProcedimiento == 3)))
                                    {
                                        result.EstadoEpiAtencion = 3;
                                        result.CodigoEpisodioClinico = 3;
                                        if (result.TipoOrdenAtencion == 11 && result.IdProcedimiento == 3 && (Listar[0].IdUbicacion == null || Listar[0].IdUbicacion == 4))
                                        {
                                            result.EstadoEpiAtencion = 2;
                                            result.CodigoEpisodioClinico = 2;
                                        }
                                    }
                                }
                                if (Listar[0].Estado == 1)
                                {
                                    result.EstadoEpiAtencion = 1;
                                    result.CodigoEpisodioClinico = 1;
                                }
                                if (Listar[0].Estado == 3 && (result.TipoOrdenAtencion == 12 || (result.TipoOrdenAtencion == 11 && result.IdProcedimiento == 1)))
                                {
                                    result.EstadoEpiAtencion = 3;
                                    result.CodigoEpisodioClinico = 3;
                                }
                            }
                            //}
                            result.UnidadReplicacion = Listar[0].UnidadReplicacion;
                            result.UnidadReplicacionEC = Listar[0].UnidadReplicacionEC;
                            result.IdEpisodioAtencion = Listar[0].IdEpisodioAtencion;
                            result.EpisodioClinico = Listar[0].EpisodioClinico;
                            result.IdEstablecimientoSalud = Listar[0].IdEstablecimientoSalud;
                            result.IdUnidadServicio = Listar[0].IdUnidadServicio;
                            result.IdPersonalSalud = Listar[0].IdPersonalSalud;
                            /////////
                            result.EpisodioAtencion = Listar[0].EpisodioAtencion;
                            result.FechaAtencion = Listar[0].FechaAtencion;
                            result.FechaRegistro = Listar[0].FechaRegistro;
                            //AUX para fecha Firma add 2017-08
                            if (ObjTrace.tipoListado == "MED_AUDITORIA")
                            {

                            }
                            else
                            {
                                result.FechaFin = Listar[0].FechaFinDescansoMedico;
                            }
                            result.Accion = Listar[0].NombreEmergencia;
                            objAuxHCE = getVW_ATENCIONPACIENTE_GENERAL_HCE(result);
                            //  llamar a store de atenciones episodio de hce
                            cantidadHCE++;
                            if (ObjTrace.EstadoEpiAtencion == null)
                            {
                                cantidadHCEfiltro++;
                                ListaAtencionHCE.Add(objAuxHCE);
                            }
                            else
                            {
                                if ((ObjTrace.tipoListado == "MED_EMERGENCIA2" || ObjTrace.tipoListado == "ENFERM_EMERGENCIAS") && ObjTrace.EstadoEpiAtencion == 3)
                                {
                                    if (Listar[0].IdUbicacion == 3 || (resultado == count && (result.TipoOrdenAtencion == 11 || result.TipoOrdenAtencion == 12 || result.TipoOrdenAtencion == 5)))
                                    {
                                        cantidadHCEfiltro++;
                                        ListaAtencionHCE.Add(objAuxHCE);
                                    }
                                }
                                else if ((ObjTrace.tipoListado == "MED_EMERGENCIA2" || ObjTrace.tipoListado == "ENFERM_EMERGENCIAS") && ObjTrace.EstadoEpiAtencion == 2)
                                {
                                    if (result.TipoOrdenAtencion == 11 || result.TipoOrdenAtencion == 12 || result.TipoOrdenAtencion == 5)
                                    {
                                        if (resultado != count)
                                        {
                                            cantidadHCEfiltro++;
                                            ListaAtencionHCE.Add(objAuxHCE);
                                        }
                                    }
                                    else if (Listar[0].IdUbicacion == null)
                                    {
                                        cantidadHCEfiltro++;
                                        ListaAtencionHCE.Add(objAuxHCE);
                                    }
                                }
                                else
                                {
                                    if (ObjTrace.EstadoEpiAtencion == Listar[0].Estado)
                                    {
                                        cantidadHCEfiltro++;
                                        ListaAtencionHCE.Add(objAuxHCE);
                                    }
                                    else
                                    {
                                        if (ObjTrace.EstadoEpiAtencion == result.EstadoEpiAtencion)
                                        {
                                            cantidadHCEfiltro++;
                                            ListaAtencionHCE.Add(objAuxHCE);
                                        }
                                    }
                                }
                            }
                        }
                        else   //no existe en HCE
                        {
                            if (Listar.Count == 0 && (ObjTrace.tipoListado == "MED_EMERGENCIA2" || ObjTrace.tipoListado == "ENFERM_EMERGENCIAS"))
                            {
                                if (result.EstadoEpiAtencion == 4)
                                {
                                    result.EstadoEpiAtencion = 4;
                                }
                                else if (ObjTrace.tipoListado == "MED_EMERGENCIA2" && result.IdPacienteHCE == 1)
                                {
                                    result.EstadoEpiAtencion = 3;
                                }
                                //else if (result.Origen == "Procedimiento" && result.EstadoEpiAtencion == 2)
                                //{
                                //    result.EstadoEpiAtencion = 8;
                                //} 
                                //else if (result.EstadoEpiAtencion == 2)
                                //{
                                //    result.EstadoEpiAtencion = 3;
                                //} 
                                else if (result.Origen != "Relevo" && (result.MedicoNombre != null))
                                {
                                    result.EstadoEpiAtencion = 3;
                                }
                                else if (ObjTrace.tipoListado == "MED_EMERGENCIA2" || result.Origen == "Interconsulta")
                                {
                                    
                                }   
                                else
                                {
                                    result.EstadoEpiAtencion = 0;
                                }
                            }
                            if (ObjTrace.EstadoEpiAtencion == null)
                            {
                                if (result.EstadoEpiAtencion == 2)
                                {
                                    result.EstadoEpiAtencion = 3;
                                }

                                if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA")
                                {
                                    if (ListaAtencionHCE != null)
                                    {
                                        result.IdPersonalSalud = ListaAtencionHCE.Count > 0 && result.IdPersonalSalud == null ? ListaAtencionHCE[0].IdPersonalSalud : null;
                                    }
                                }
                                objAuxHCE = getVW_ATENCIONPACIENTE_GENERAL_HCE(result);
                                ListaAtencionHCE.Add(objAuxHCE);
                            }
                            else if (ObjTrace.EstadoEpiAtencion == result.EstadoEpiAtencion)
                            {
                                if (result.EstadoEpiAtencion == 2)
                                {
                                    result.EstadoEpiAtencion = 3;
                                }
                                objAuxHCE = getVW_ATENCIONPACIENTE_GENERAL_HCE(result);
                                ListaAtencionHCE.Add(objAuxHCE);
                            }
                            else if (ObjTrace.EstadoEpiAtencion != result.EstadoEpiAtencion)
                            {
                                if (ObjTrace.EstadoEpiAtencion == 3 && result.EstadoEpiAtencion == 2)
                                {
                                    result.EstadoEpiAtencion = 3;
                                    objAuxHCE = getVW_ATENCIONPACIENTE_GENERAL_HCE(result);
                                    ListaAtencionHCE.Add(objAuxHCE);
                                }
                            }
                        }
                    }

                }               
                if (ListaAtencionHCE.Count > 0)
                {
                    if (ObjTrace.tipoListado == "MED_AUDITORIA")
                    {
                        //ListaAtencionHCE[0].Contador = cantidadTotal;
                    }
                    else if (ObjTrace.EstadoEpiAtencion == null)
                    {
                        ListaAtencionHCE[0].Contador = cantidadTotal;
                    }
                    else if (ObjTrace.EstadoEpiAtencion == 0)
                    {
                        ListaAtencionHCE[0].Contador = cantidadTotal - cantidadHCE;
                    }
                    else
                    {
                        ListaAtencionHCE[0].Contador = cantidadHCEfiltro;
                    }
                }
            }
            else
            {
                if (!indicaACTIVOSOA)
                {
                    /*****CASO NO HAYA RESPUESTA DEL LISTADO EXTERNO SOA***/
                    /*
                    objAuxHCE = new VW_ATENCIONPACIENTE_GENERAL();
                    objAuxHCE.Accion = "LISTAR";
                    objAuxHCE.NumeroFila = 0;
                    objAuxHCE.IdPaciente = ObjTrace.IdPaciente;
                    objAuxHCE.CodigoOA = ObjTrace.CodigoOA;
                    objAuxHCE.PacienteNombre = ObjTrace.PacienteNombre;
                    objAuxHCE.EstadoEpiAtencion = ObjTrace.EstadoEpiAtencion;
                    objAuxHCE.FechaInicio = ObjTrace.FechaInicio;
                    objAuxHCE.FechaFin = ObjTrace.FechaFin;
                    objAuxHCE.CodigoHC = ObjTrace.CodigoHC;
                    objAuxHCE.CodigoHCAnterior = ObjTrace.CodigoHCAnterior;
                    objAuxHCE.IdPersonalSalud = ObjTrace.IdMedico;
                    objAuxHCE.TipoOrdenAtencion = ObjTrace.TipoOrdenAtencion;
                    //LocalEnty.Compania = ObjTrace.Compania;
                    objAuxHCE.UnidadReplicacion = ObjTrace.UnidadReplicacion;
                    //LocalEnty.Sucursal = ObjTrace.Sucursal;
                    objAuxHCE.IdEstablecimientoSalud = ObjTrace.IdEstablecimientoSalud;
                    objAuxHCE.Accion = "LISTARPAG";
                    */
                    ObjTrace.Accion = "LISTARPAG";
                    //LocalEnty.IdOrdenAtencion = ObjTrace.IdOrdenAtencion;
                    ListaAtencionHCE = SoluccionSalud.Service.VW_ATENCIONPACIENTEService.SvcVw_AtencionPaciente.listarVwAtencionPacienteGeneral(ObjTrace, ObjTrace.NumeroFila, ObjTrace.Contador);
                    /*
                    cantidadTotal = SoluccionSalud.Service.VW_ATENCIONPACIENTEService.SvcVw_AtencionPaciente.setMantenimiento(LocalEnty);
                    if (cantidadTotal > 0)
                    {
                        Listar = SoluccionSalud.Service.VW_ATENCIONPACIENTEService.SvcVw_AtencionPaciente.listarVwAtencionPaciente(LocalEnty, ObjTrace.NumeroFila, ObjTrace.Contador);
                        foreach (var resultHCE in Listar)
                        {                        
                            ListaAtencionHCE.Add(getVW_ATENCIONPACIENTE_GENERAL_HCE(resultHCE, cantidadTotal));
                        }
                    }*/
                }
            }

            //SoluccionSalud.Service.VW_ATENCIONPACIENTEService.SvcVw_AtencionPaciente.listarVwAtencionPaciente(ObjTrace, ListaAtencionHCE, 0, 0);
            return ListaAtencionHCE;
        }

        /**por cambiar terminar MATCH de los campos agregados y modificados*/
        public static VW_ATENCIONPACIENTE_GENERAL getVW_ATENCIONPACIENTE_GENERAL_HCE(SoluccionSalud.SOA.Entidades.VW_ATENCIONPACIENTE_GENERAL obj)
        {
            VW_ATENCIONPACIENTE_GENERAL objHCE = new VW_ATENCIONPACIENTE_GENERAL();
            objHCE.NumeroFila = obj.NumeroFila;
            objHCE.tipoListado = obj.tipoListado;
            objHCE.CitaTipo = obj.CitaTipo;
            objHCE.CitaFecha = obj.CitaFecha;
            objHCE.CitaHora = obj.CitaHora;
            objHCE.Origen = obj.Origen;
            objHCE.NombreEspecialidad = obj.NombreEspecialidad;
            objHCE.TipoPacienteNombre = obj.TipoPacienteNombre;
            objHCE.CodigoOA = obj.CodigoOA;
            objHCE.FechaInicio = obj.FechaInicio;
            objHCE.Cama = obj.Cama;
            objHCE.TipoOrdenAtencionNombre = obj.TipoOrdenAtencionNombre;
            objHCE.CodigoHC = obj.CodigoHC;
            objHCE.CodigoHCAnterior = obj.CodigoHCAnterior;
            objHCE.PacienteNombre = obj.PacienteNombre;
            objHCE.MedicoNombre = obj.MedicoNombre;
            objHCE.IdOrdenAtencion = obj.IdOrdenAtencion;
            objHCE.LineaOrdenAtencion = obj.LineaOrdenAtencion;
            objHCE.IdHospitalizacion = obj.IdHospitalizacion;
            objHCE.LineaHospitalizacion = obj.LineaHospitalizacion;
            objHCE.IdConsultaExterna = obj.IdConsultaExterna;
            objHCE.IdProcedimiento = obj.IdProcedimiento;
            objHCE.Modalidad = obj.Modalidad;
            objHCE.IndicadorSeguro = obj.IndicadorSeguro;
            objHCE.IdCita = obj.IdCita;
            objHCE.IdPaciente = obj.IdPaciente;
            objHCE.TipoPaciente = obj.TipoPaciente;
            objHCE.TipoAtencion = obj.TipoAtencion;
            objHCE.IdEspecialidad = obj.IdEspecialidad;
            objHCE.IdEmpresaAseguradora = obj.IdEmpresaAseguradora;
            objHCE.TipoOrdenAtencion = obj.TipoOrdenAtencion;
            objHCE.Componente = obj.Componente;
            objHCE.ComponenteNombre = obj.ComponenteNombre;
            objHCE.Compania = obj.Compania;
            objHCE.Sucursal = obj.Sucursal;
            objHCE.IdMedico = obj.IdMedico;
            objHCE.IndicadorCirugia = obj.IndicadorCirugia;
            objHCE.IndicadorExamenPrincipal = obj.IndicadorExamenPrincipal;
            objHCE.PersonaAnt = obj.PersonaAnt;
            objHCE.sexo = obj.sexo;
            objHCE.FechaNacimiento = obj.FechaNacimiento;
            objHCE.EstadoCivil = obj.EstadoCivil;
            objHCE.NivelInstruccion = obj.NivelInstruccion;
            objHCE.Direccion = obj.Direccion;
            objHCE.TipoDocumento = obj.TipoDocumento;
            objHCE.Documento = obj.Documento;
            objHCE.ApellidoPaterno = obj.ApellidoPaterno;
            objHCE.ApellidoMaterno = obj.ApellidoMaterno;
            objHCE.Nombres = obj.Nombres;
            objHCE.LugarNacimiento = obj.LugarNacimiento;
            objHCE.CodigoPostal = obj.CodigoPostal;
            objHCE.Provincia = obj.Provincia;
            objHCE.Departamento = obj.Departamento;
            objHCE.Telefono = obj.Telefono;
            objHCE.CorreoElectronico = obj.CorreoElectronico;
            objHCE.EsPaciente = obj.EsPaciente;
            objHCE.EsEmpresa = obj.EsEmpresa;
            objHCE.Pais = obj.Pais;
            objHCE.EstadoPersona = obj.EstadoPersona;
            objHCE.FechaCierreEpiClinico = obj.FechaCierreEpiClinico;
            objHCE.EstadoEpiClinico = obj.EstadoEpiClinico;
            objHCE.UnidadReplicacion = obj.UnidadReplicacion;
            objHCE.UnidadReplicacionEC = obj.UnidadReplicacionEC;
            objHCE.IdEpisodioAtencion = obj.IdEpisodioAtencion;
            objHCE.EpisodioClinico = obj.EpisodioClinico;
            objHCE.IdEstablecimientoSalud = obj.IdEstablecimientoSalud;
            objHCE.IdUnidadServicio = obj.IdUnidadServicio;
            objHCE.IdPersonalSalud = obj.IdPersonalSalud;
            objHCE.EpisodioAtencion = obj.EpisodioAtencion;
            objHCE.FechaRegistro = obj.FechaRegistro;
            objHCE.FechaAtencion = obj.FechaAtencion;
            objHCE.EstadoEpiAtencion = obj.EstadoEpiAtencion;
            objHCE.UsuarioCreacion = obj.UsuarioCreacion;
            objHCE.UsuarioModificacion = obj.UsuarioModificacion;
            objHCE.FechaCreacion = obj.FechaCreacion;
            objHCE.FechaModificacion = obj.FechaModificacion;
            objHCE.Accion = obj.Accion;
            objHCE.Version = obj.Version;
            objHCE.FechaFin = obj.FechaFin;
            objHCE.FechaOrden = obj.FechaOrden;
            objHCE.Comentarios = obj.Comentarios;
            objHCE.Observaciones = obj.Observaciones;

            ////changed 15/09/15      //////////////
            if (obj.UnidadReplicacionHCE != null)
            {
                objHCE.UnidadReplicacionHCE = obj.UnidadReplicacionHCE; //OBS
            }
            else
            {
                objHCE.UnidadReplicacionHCE = obj.UnidadReplicacionEC; //OBS
            }

            if (obj.IdPacienteHCE != null)
            {
                objHCE.IdPacienteHCE = obj.IdPacienteHCE;
            }
            else
            {
                objHCE.IdPacienteHCE = obj.IdPaciente; //OBS
            }
            objHCE.EpisodioClinicoHCE = obj.EpisodioClinicoHCE;
            objHCE.IdEpisodioAtencionHCE = obj.IdEpisodioAtencionHCE;
            objHCE.SecuenciaHCE = obj.SecuenciaHCE;
            objHCE.CodigoEpisodioClinico = obj.CodigoEpisodioClinico;


            /*try
            {
                if (obj.UsuarioCreacion != null)
                {
                    objHCE.EpisodioClinicoHCE = Convert.ToInt32(obj.UsuarioCreacion); //OBS
                }
                if (obj.UsuarioModificacion != null)
                {
                    objHCE.IdEpisodioAtencionHCE = Convert.ToInt64(obj.UsuarioModificacion); //OBS                
                }
                objHCE.SecuenciaHCE = 0; //OBS
            }catch(Exception ex){

            }*/

            ///////////////////////////////
            objHCE.Diagnostico = obj.Diagnostico;
            objHCE.Contador = obj.Contador;

            return objHCE;
        }
        public static SoluccionSalud.SOA.Entidades.VW_ATENCIONPACIENTE_GENERAL getVW_ATENCIONPACIENTE_GENERAL_SOA(VW_ATENCIONPACIENTE_GENERAL obj)
        {
            SoluccionSalud.SOA.Entidades.VW_ATENCIONPACIENTE_GENERAL objSOA = new SoluccionSalud.SOA.Entidades.VW_ATENCIONPACIENTE_GENERAL();
            objSOA.NumeroFila = obj.NumeroFila;
            objSOA.tipoListado = obj.tipoListado;
            objSOA.CitaTipo = obj.CitaTipo;
            objSOA.CitaFecha = obj.CitaFecha;
            objSOA.CitaHora = obj.CitaHora;
            objSOA.Origen = obj.Origen;
            objSOA.NombreEspecialidad = obj.NombreEspecialidad;
            objSOA.TipoPacienteNombre = obj.TipoPacienteNombre;
            objSOA.CodigoOA = obj.CodigoOA;
            objSOA.FechaInicio = obj.FechaInicio;
            objSOA.Cama = obj.Cama;
            objSOA.TipoOrdenAtencionNombre = obj.TipoOrdenAtencionNombre;
            objSOA.CodigoHC = obj.CodigoHC;
            objSOA.CodigoHCAnterior = obj.CodigoHCAnterior;
            objSOA.PacienteNombre = obj.PacienteNombre;
            objSOA.MedicoNombre = obj.MedicoNombre;
            objSOA.IdOrdenAtencion = obj.IdOrdenAtencion;
            objSOA.LineaOrdenAtencion = obj.LineaOrdenAtencion;
            objSOA.IdHospitalizacion = obj.IdHospitalizacion;
            objSOA.LineaHospitalizacion = obj.LineaHospitalizacion;
            objSOA.IdConsultaExterna = obj.IdConsultaExterna;
            objSOA.IdProcedimiento = obj.IdProcedimiento;
            objSOA.Modalidad = obj.Modalidad;
            objSOA.IndicadorSeguro = obj.IndicadorSeguro;
            objSOA.IdCita = obj.IdCita;
            objSOA.IdPaciente = obj.IdPaciente;
            objSOA.TipoPaciente = obj.TipoPaciente;
            objSOA.TipoAtencion = obj.TipoAtencion;
            objSOA.IdEspecialidad = obj.IdEspecialidad;
            objSOA.IdEmpresaAseguradora = obj.IdEmpresaAseguradora;
            objSOA.TipoOrdenAtencion = obj.TipoOrdenAtencion;
            objSOA.Componente = obj.Componente;
            objSOA.ComponenteNombre = obj.ComponenteNombre;
            objSOA.Compania = obj.Compania;
            objSOA.Sucursal = obj.Sucursal;
            objSOA.IdMedico = obj.IdMedico;
            objSOA.IndicadorCirugia = obj.IndicadorCirugia;
            objSOA.IndicadorExamenPrincipal = obj.IndicadorExamenPrincipal;
            objSOA.PersonaAnt = obj.PersonaAnt;
            objSOA.sexo = obj.sexo;
            objSOA.FechaNacimiento = obj.FechaNacimiento;
            objSOA.EstadoCivil = obj.EstadoCivil;
            objSOA.NivelInstruccion = obj.NivelInstruccion;
            objSOA.Direccion = obj.Direccion;
            objSOA.TipoDocumento = obj.TipoDocumento;
            objSOA.Documento = obj.Documento;
            objSOA.ApellidoPaterno = obj.ApellidoPaterno;
            objSOA.ApellidoMaterno = obj.ApellidoMaterno;
            objSOA.Nombres = obj.Nombres;
            objSOA.LugarNacimiento = obj.LugarNacimiento;
            objSOA.CodigoPostal = obj.CodigoPostal;
            objSOA.Provincia = obj.Provincia;
            objSOA.Departamento = obj.Departamento;
            objSOA.Telefono = obj.Telefono;
            objSOA.CorreoElectronico = obj.CorreoElectronico;
            objSOA.EsPaciente = obj.EsPaciente;
            objSOA.EsEmpresa = obj.EsEmpresa;
            objSOA.Pais = obj.Pais;
            objSOA.EstadoPersona = obj.EstadoPersona;
            objSOA.FechaCierreEpiClinico = obj.FechaCierreEpiClinico;
            objSOA.EstadoEpiClinico = obj.EstadoEpiClinico;
            objSOA.UnidadReplicacion = obj.UnidadReplicacion;
            objSOA.UnidadReplicacionEC = obj.UnidadReplicacionEC;
            objSOA.IdEpisodioAtencion = obj.IdEpisodioAtencion;
            objSOA.EpisodioClinico = obj.EpisodioClinico;
            objSOA.IdEstablecimientoSalud = obj.IdEstablecimientoSalud;
            objSOA.IdUnidadServicio = obj.IdUnidadServicio;
            objSOA.IdPersonalSalud = obj.IdPersonalSalud;
            objSOA.EpisodioAtencion = obj.EpisodioAtencion;//changed 15/09/15        
            objSOA.FechaRegistro = obj.FechaRegistro;
            objSOA.FechaAtencion = obj.FechaAtencion;
            objSOA.EstadoEpiAtencion = obj.EstadoEpiAtencion;
            objSOA.UsuarioCreacion = obj.UsuarioCreacion;
            objSOA.UsuarioModificacion = obj.UsuarioModificacion;
            objSOA.FechaCreacion = obj.FechaCreacion;
            objSOA.FechaModificacion = obj.FechaModificacion;
            objSOA.Accion = obj.Accion;
            objSOA.Version = obj.Version;
            objSOA.FechaFin = obj.FechaFin;
            objSOA.FechaOrden = obj.FechaOrden;
            objSOA.Comentarios = obj.Comentarios;
            objSOA.Observaciones = obj.Observaciones;
            objSOA.Diagnostico = obj.Diagnostico;
            objSOA.Contador = obj.Contador;
            ////changed 15/09/15      
            objSOA.UnidadReplicacionHCE = obj.UnidadReplicacionHCE;
            objSOA.IdPacienteHCE = obj.IdPacienteHCE;
            objSOA.EpisodioClinicoHCE = obj.EpisodioClinicoHCE;
            objSOA.IdEpisodioAtencionHCE = obj.IdEpisodioAtencionHCE;
            objSOA.SecuenciaHCE = obj.SecuenciaHCE;
            objSOA.CodigoEpisodioClinico = obj.CodigoEpisodioClinico;
            ////
            return objSOA;
        }
        public static SoluccionSalud.SOA.Entidades.SS_HCE_RecetaConsultaExterna getVW_RECETA_CONSULTA_EXTERNA(SS_HCE_RecetaConsultaExterna obj)
        {
            SoluccionSalud.SOA.Entidades.SS_HCE_RecetaConsultaExterna objSOA = new SoluccionSalud.SOA.Entidades.SS_HCE_RecetaConsultaExterna();
            objSOA.IdOrdenAtencion = obj.IdOrdenAtencion;
            objSOA.LineaOA = obj.LineaOA;
            objSOA.IdPaciente = obj.IdPaciente;
            objSOA.Componente = obj.Componente;
            objSOA.Unidadmedida = obj.Unidadmedida;
            objSOA.linea = obj.linea;
            objSOA.Familia = obj.Familia;
            objSOA.Subfamilia = obj.Subfamilia;
            objSOA.Cantidad = obj.Cantidad;
            objSOA.Via = obj.Via;
            objSOA.Dosis = obj.Dosis;
            objSOA.Diastratamiento = obj.Diastratamiento;
            objSOA.Frecuencia = obj.Frecuencia;
            objSOA.IndicadorEPS = obj.IndicadorEPS;
            objSOA.Usuario = obj.Usuario;
            objSOA.FechaCreacion = obj.FechaCreacion;
            objSOA.IndicacionEspecifica = obj.IndicacionEspecifica;
            objSOA.lineamax = obj.lineamax;
            objSOA.TIPOORDENATENCION = obj.TIPOORDENATENCION;
            objSOA.SecuenciaHCE = obj.SecuenciaHCE;

            return objSOA;
        }
        public static SoluccionSalud.SOA.Entidades.SS_HCE_ConsultaExterna getVW_CONSULTA_EXTERNA(SS_HCE_ConsultaExterna obj)
        {
            SoluccionSalud.SOA.Entidades.SS_HCE_ConsultaExterna objSOA = new SoluccionSalud.SOA.Entidades.SS_HCE_ConsultaExterna();
            objSOA.UnidadReplicacion = obj.UnidadReplicacion;
            objSOA.IdEpisodioAtencion = obj.IdEpisodioAtencion;
            objSOA.IdPaciente = obj.IdPaciente;
            objSOA.EpisodioClinico = obj.EpisodioClinico;
            objSOA.IdConsultaExterna = obj.IdConsultaExterna;
            objSOA.IdOrdenAtencion = obj.IdOrdenAtencion;
            objSOA.Linea = obj.Linea;
            objSOA.LineaOrdenAtencion = obj.LineaOrdenAtencion;
            objSOA.TipoOrdenMedica = obj.TipoOrdenMedica;
            objSOA.Componente = obj.Componente;
            objSOA.TipoInterConsulta = obj.TipoInterConsulta;
            objSOA.Medico = obj.Medico;
            objSOA.Especialidad = obj.Especialidad;
            objSOA.EstadoDocumento = obj.EstadoDocumento;
            objSOA.IndicadorEPS = obj.IndicadorEPS;
            objSOA.Estado = obj.Estado;
            objSOA.MedicoResponsable = obj.MedicoResponsable;
            objSOA.UsuarioCreacion = obj.UsuarioCreacion;
            objSOA.UsuarioModificacion = obj.UsuarioModificacion;
            objSOA.SecuenciaHCE = obj.SecuenciaHCE;
            objSOA.FechaCreacion = obj.FechaCreacion;
            objSOA.FechaModificacion = obj.FechaModificacion;
            objSOA.Accion = obj.Accion;
            objSOA.Version = obj.Version;

            return objSOA;
        }
        public static VW_ATENCIONPACIENTE_GENERAL getVW_ATENCIONPACIENTE_GENERAL_HCE(VW_ATENCIONPACIENTE obj, int total)
        {
            VW_ATENCIONPACIENTE_GENERAL objHCE = new VW_ATENCIONPACIENTE_GENERAL();
            /*objHCE.NumeroFila = obj.NumeroFila;
            objHCE.tipoListado = obj.tipoListado;
            objHCE.CitaTipo = obj.CitaTipo;
            objHCE.CitaFecha = obj.CitaFecha;
            objHCE.CitaHora = obj.CitaHora;*/
            objHCE.Origen = obj.Origen;
            //objHCE.NombreEspecialidad = obj.NombreEspecialidad;
            objHCE.TipoPacienteNombre = obj.EsPaciente;
            objHCE.CodigoOA = obj.CodigoOA;
            objHCE.FechaInicio = obj.FechaRegistro;
            //objHCE.Cama = obj.Cama;
            //objHCE.TipoOrdenAtencionNombre = obj.TipoOrdenAtencionNombre;
            objHCE.CodigoHC = obj.CodigoHC;
            objHCE.CodigoHCAnterior = obj.CodigoHCAnterior;
            objHCE.PacienteNombre = obj.NombreCompleto;
            //objHCE.MedicoNombre = obj.MedicoNombre;
            objHCE.IdOrdenAtencion = Convert.ToInt32(obj.IdOrdenAtencion);
            objHCE.LineaOrdenAtencion = Convert.ToInt32(obj.LineaOrdenAtencion);
            //objHCE.IdHospitalizacion = obj.IdHospitalizacion;
            //objHCE.LineaHospitalizacion = obj.LineaHospitalizacion;
            //objHCE.IdConsultaExterna = obj.IdConsultaExterna;
            objHCE.IdProcedimiento = obj.IdProcedimiento;
            //objHCE.Modalidad = obj.Modalidad;
            //objHCE.IndicadorSeguro = obj.IndicadorSeguro;
            ///objHCE.IdCita = obj.IdCita;
            objHCE.IdPaciente = obj.IdPaciente;
            objHCE.TipoPaciente = obj.TipoPaciente;
            objHCE.TipoAtencion = obj.TipoAtencion;
            objHCE.IdEspecialidad = obj.IdEspecialidad;
            //objHCE.IdEmpresaAseguradora = obj.IdEmpresaAseguradora;
            objHCE.TipoOrdenAtencion = obj.TipoOrdenAtencion;
            //objHCE.Componente = obj.Componente;
            //objHCE.ComponenteNombre = obj.ComponenteNombre;
            //objHCE.Compania = obj.Compania;
            //objHCE.Sucursal = obj.Sucursal;
            objHCE.IdMedico = obj.IdPersonalSalud;
            //objHCE.IndicadorCirugia = obj.IndicadorCirugia;
            //objHCE.IndicadorExamenPrincipal = obj.IndicadorExamenPrincipal;
            objHCE.PersonaAnt = obj.PersonaAnt;
            //objHCE.sexo = obj.sexo;
            objHCE.FechaNacimiento = obj.FechaNacimiento;
            objHCE.EstadoCivil = obj.EstadoCivil;
            objHCE.NivelInstruccion = obj.NivelInstruccion;
            objHCE.Direccion = obj.Direccion;
            objHCE.TipoDocumento = obj.TipoDocumento;
            objHCE.Documento = obj.Documento;
            objHCE.ApellidoPaterno = obj.ApellidoPaterno;
            objHCE.ApellidoMaterno = obj.ApellidoMaterno;
            //objHCE.Nombres = obj.Nomnbres;
            objHCE.LugarNacimiento = obj.LugarNacimiento;
            objHCE.CodigoPostal = obj.CodigoPostal;
            objHCE.Provincia = obj.Provincia;
            objHCE.Departamento = obj.Departamento;
            objHCE.Telefono = obj.Telefono;
            objHCE.CorreoElectronico = obj.CorreoElectronico;
            objHCE.EsPaciente = obj.EsPaciente;
            objHCE.EsEmpresa = obj.EsEmpresa;
            objHCE.Pais = obj.Pais;
            objHCE.EstadoPersona = obj.EstadoPersona;
            objHCE.FechaCierreEpiClinico = obj.FechaCierreEpiClinico;
            objHCE.EstadoEpiClinico = obj.EstadoEpiClinico;
            objHCE.UnidadReplicacion = obj.UnidadReplicacion;
            objHCE.UnidadReplicacionEC = obj.UnidadReplicacionEC;
            objHCE.IdEpisodioAtencion = obj.IdEpisodioAtencion;
            objHCE.EpisodioClinico = obj.EpisodioClinico;
            objHCE.IdEstablecimientoSalud = obj.IdEstablecimientoSalud;
            objHCE.IdUnidadServicio = obj.IdUnidadServicio;
            objHCE.IdPersonalSalud = obj.IdPersonalSalud;
            objHCE.EpisodioAtencion = obj.EpisodioAtencion;
            objHCE.FechaRegistro = obj.FechaRegistro;
            objHCE.FechaAtencion = obj.FechaAtencion;
            objHCE.EstadoEpiAtencion = obj.Estado;
            objHCE.UsuarioCreacion = obj.UsuarioCreacion;
            objHCE.UsuarioModificacion = obj.UsuarioModificacion;
            objHCE.FechaCreacion = obj.FechaCreacion;
            objHCE.FechaModificacion = obj.FechaModificacion;
            objHCE.Accion = obj.Accion;
            objHCE.Version = obj.Version;
            //objHCE.FechaFin = obj.FechaFin;
            objHCE.FechaOrden = obj.FechaOrden;
            // objHCE.Comentarios = obj.Comentarios;
            //objHCE.Observaciones = obj.Observacion;
            /*
            ////changed 15/09/15      //////////////
            if (obj.UnidadReplicacionHCE != null)
            {
                objHCE.UnidadReplicacionHCE = obj.UnidadReplicacionHCE; //OBS
            }
            else
            {
                objHCE.UnidadReplicacionHCE = obj.UnidadReplicacionEC; //OBS
            }

            if (obj.IdPacienteHCE != null)
            {
                objHCE.IdPacienteHCE = obj.IdPacienteHCE;
            }
            else
            {
                objHCE.IdPacienteHCE = obj.IdPaciente; //OBS
            }
            objHCE.EpisodioClinicoHCE = obj.EpisodioClinicoHCE;
            objHCE.IdEpisodioAtencionHCE = obj.IdEpisodioAtencionHCE;
            objHCE.SecuenciaHCE = obj.SecuenciaHCE;
            objHCE.CodigoEpisodioClinico = obj.CodigoEpisodioClinico;
            */

            /*try
            {
                if (obj.UsuarioCreacion != null)
                {
                    objHCE.EpisodioClinicoHCE = Convert.ToInt32(obj.UsuarioCreacion); //OBS
                }
                if (obj.UsuarioModificacion != null)
                {
                    objHCE.IdEpisodioAtencionHCE = Convert.ToInt64(obj.UsuarioModificacion); //OBS                
                }
                objHCE.SecuenciaHCE = 0; //OBS
            }catch(Exception ex){

            }*/

            ///////////////////////////////
            //objHCE.Diagnostico = obj.Diagnostico;
            objHCE.Contador = total;

            return objHCE;
        }
    }
}
