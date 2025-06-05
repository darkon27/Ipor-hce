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
using System.Data.Entity;
using System.Xml;
using System.Xml.Serialization;
using SoluccionSalud.Repository.Repository;
using Newtonsoft.Json;
using SoluccionSalud.SOA;
using System.Data;
using System.IO;
using System.Diagnostics;

namespace SoluccionSalud.RepositoryFormulario.DAL_Formularios
{
    public class EpisodioTriajeRepository
    {

        ////
        ///

        public int UpdateTriajeAlergias(int Idaction, SS_CE_TriajeViewModel objSC)
        {


            using (ClinicaElGolfEntities context = new ClinicaElGolfEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {

                        if (Idaction == 2)
                        {
                            var IdTriaje = Convert.ToInt32(objSC.IdTriaje);
                            var Otabla = context.SS_CE_Triaje.SingleOrDefault(b => b.IdTriaje == IdTriaje);
                            if (Otabla != null)
                            {
                                Otabla.AntcedentesAlergias = objSC.AntcedentesAlergias;
                                Otabla.indalergiamedicamento = objSC.indalergiamedicamento;
                                Otabla.alergiamedicamento1 = objSC.alergiamedicamento1;
                                Otabla.alergiamedicamento2 = objSC.alergiamedicamento2;
                                Otabla.alergiamedicamento2 = objSC.alergiamedicamento2;
                                Otabla.alergiamedicamento3 = objSC.alergiamedicamento3;
                                Otabla.alergiamedicamento4 = objSC.alergiamedicamento4;
                                Otabla.alergiamedicamento5 = objSC.alergiamedicamento5;

                                Otabla.indmedicamentoregular = objSC.indmedicamentoregular;
                                Otabla.medicamentoregular1 = objSC.medicamentoregular1;
                                Otabla.medicamentoregular1dosis = objSC.medicamentoregular1dosis;
                                Otabla.medicamentoregular1frecuencia = objSC.medicamentoregular1frecuencia;
                                Otabla.medicamentoregular1via = objSC.medicamentoregular1via;
                                Otabla.medicamentoregular2 = objSC.medicamentoregular2;
                                Otabla.medicamentoregular2dosis = objSC.medicamentoregular2dosis;
                                Otabla.medicamentoregular2frecuencia = objSC.medicamentoregular2frecuencia;
                                Otabla.medicamentoregular2via = objSC.medicamentoregular2via;

                                Otabla.medicamentoregular3 = objSC.medicamentoregular3;
                                Otabla.medicamentoregular3dosis = objSC.medicamentoregular3dosis;
                                Otabla.medicamentoregular3frecuencia = objSC.medicamentoregular3frecuencia;
                                Otabla.medicamentoregular3via = objSC.medicamentoregular3via;

                                Otabla.medicamentoregular4 = objSC.medicamentoregular4;
                                Otabla.medicamentoregular4dosis = objSC.medicamentoregular4dosis;
                                Otabla.medicamentoregular4frecuencia = objSC.medicamentoregular4frecuencia;
                                Otabla.medicamentoregular4via = objSC.medicamentoregular4via;

                                Otabla.medicamentoregular5 = objSC.medicamentoregular5;
                                Otabla.medicamentoregular5dosis = objSC.medicamentoregular5dosis;
                                Otabla.medicamentoregular5frecuencia = objSC.medicamentoregular5frecuencia;
                                Otabla.medicamentoregular5via = objSC.medicamentoregular5via;


                                Otabla.indtransfusionessanguineas = objSC.indtransfusionessanguineas;
                                Otabla.indproblematransfusion = objSC.indproblematransfusion;
                                Otabla.indalergiaalimento = objSC.indalergiaalimento;
                                Otabla.indalergiacontacto = objSC.indalergiacontacto;
                                Otabla.IndAprobacionAlergia = objSC.IndAprobacionAlergia;
                                Otabla.IndCopiaCE = objSC.IndCopiaCE;
                                Otabla.alergiacontacto = objSC.medicamentoregular1via;
                                Otabla.EstadoDocumento = 1;

                                context.Entry(Otabla).State = System.Data.Entity.EntityState.Modified;
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
            return 1;
        }


        public List<SP_ListarAlergiaDetalle_FE_Result> GetListTriajeDetalle(SP_ListarAlergiaDetalle_FE_Result p)
        {


            using (var context = new ModelFormularios())
            {
                return context.SP_ListarAlergiaDetalle_FE(p.UnidadReplicacion, p.IdPaciente, p.EpisodioTriaje).ToList();
            }
        }

        public List<AlergiasDetalleViewModel> TriajeAlegriaDetalle(AlergiasDetalleViewModel Obj)
        {

            List<AlergiasDetalleViewModel> lst = new List<AlergiasDetalleViewModel>();
            using (ModelFormularios db = new ModelFormularios())
            {
                lst = (from d in db.SS_HC_Triaje_Ant_AlergiaDetalle_FE

                       select new AlergiasDetalleViewModel
                       {
                           UnidadReplicacion = d.UnidadReplicacion,
                           IdPaciente = d.IdPaciente,
                           EpisodioTriaje = d.EpisodioTriaje,
                           IdTipoAlergia = d.IdTipoAlergia,
                           DesdeCuando = d.DesdeCuando,
                           TipoRegistro = d.TipoRegistro,
                           Observaciones = d.Observaciones,
                           EstudioAlegista = d.EstudioAlegista,
                           Dosis = d.Dosis,
                           Frecuencia = d.Frecuencia,
                           via = d.via,
                           DescripcionManual = d.DescripcionManual,

                       }).Where(x => x.UnidadReplicacion == Obj.UnidadReplicacion &&
                           x.IdPaciente == Obj.IdPaciente && x.EpisodioTriaje == Obj.EpisodioTriaje).ToList();
            }
            return lst;
        }
        public int RegistrarTriajeSpringData(SS_CE_TriajeViewModel objSC)
        {

            System.Nullable<int> iReturnValue;

            int valorRetorno = 0; //ERROR
            int capEspecialidad = Convert.ToInt32(objSC.IdEspecialidad);
            using (var context = new ClinicaElGolfEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        SS_HC_EpisodioTriaje objAnterior = new SS_HC_EpisodioTriaje();

                        iReturnValue = context.Sp_TriajeHceSpring(
                            objSC.Accion, objSC.FechaInicio, objSC.Hora, objSC.NivelTriaje, objSC.EstadoDocumento, objSC.UsuarioCreacion,
                            objSC.UsuarioModificacion, objSC.FechaCreacion, objSC.FechaModificacion,
                            objSC.UnidadReplicacion, objSC.PresionMinima, objSC.PresionMaxima, objSC.Pulso, objSC.Respiracion,
                            objSC.Temperatura, objSC.SaturacionMaxima, objSC.Sintomas, objSC.TiempoEnfermedad, objSC.IdPaciente,
                            objSC.IndAprobacionTriaje, objSC.Sucursal, objSC.IdEspecialidad, objSC.IdEpisodioTriajeHCE).FirstOrDefault();
                        valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                        if (valorRetorno == 1)
                        {

                        }

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




        public List<SP_ListarBandejaTriaje_Result> EpisorioTriaje_Listar(DataBandeja objBandeja, int PageNumber, int PageSize)
        {
            try
            {
                List<SP_ListarBandejaTriaje_Result> objLista = new List<SP_ListarBandejaTriaje_Result>();
                using (var context = new ModelFormularios())
                {
                    objLista = context.SP_ListarBandejaTriaje(
                        objBandeja.UnidadReplicacion,
                        objBandeja.PacienteNombre,
                        objBandeja.DocumentoIdentidad,
                        objBandeja.FechaInicio,
                        objBandeja.FechaFin,
                        objBandeja.Estado,
                        objBandeja.Prioridad,
                        objBandeja.IdEspecialidad,
                        objBandeja.HistoriaClinica, PageNumber, PageSize).ToList();

                    //string unidadReplicacion, string pacienteBusqueda, string busquedaDNI, Nullable<System.DateTime> fechaInicio, Nullable<System.DateTime> fechaFin, Nullable<int> estado, Nullable<int> prioridadTriaje, Nullable<int> especialidad

                    /*
                        dynamic DataKey;
                        DataKey = new
                        {
                            UnidadReplicacion = ObjTrace.UnidadReplicacion,
                            IdPaciente = ObjTrace.IdPaciente
                        };
                     
                     */

                }

                return objLista;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public long getCountEpisodioTriaje()
        {
            long ItemCOunt = 0;
            using (var context = new ModelFormularios())
            {
                ItemCOunt = context.SS_HC_EpisodioTriaje.ToList().Count();


            }

            return ItemCOunt;
        }

        public List<SS_HC_EpisodioTriaje> getSelectEpisodioByCode(long IdEpisodioTriaje)
        {
            var lstEpisodioTriaje = new List<SS_HC_EpisodioTriaje>();
            using (var context = new ModelFormularios())
            {
                var slstEpisodioTriaje = context.SS_HC_EpisodioTriaje.Where(x => x.IdEpisodioTriaje == IdEpisodioTriaje).ToList();

                return lstEpisodioTriaje = slstEpisodioTriaje;
            }

        }

        public int UpdatePacienteHC(int IdPaciente, String HC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        var Otabla = context.SS_GE_Paciente.SingleOrDefault(b => b.IdPaciente == IdPaciente);
                        if (Otabla != null)
                        {
                            Otabla.CodigoHC = HC;

                            valorRetorno = IdPaciente;


                            context.Entry(Otabla).State = System.Data.Entity.EntityState.Modified;


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

        public int setMantenimientoEpisodioTriaje(SS_HC_EpisodioTriaje objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        SS_HC_EpisodioTriaje objAnterior = new SS_HC_EpisodioTriaje();

                        iReturnValue = context.USP_InsertarBandejaTriaje(

                            objSC.UnidadReplicacion,
                            objSC.IdPaciente,
                            objSC.IdPersonalSalud,
                            DateTime.Now,
                            objSC.IdEspecialidad,
                            objSC.IdPrioridad,
                            objSC.FlagFirma,
                            objSC.FechaFirma,
                            objSC.IdMedicoFirma,
                            objSC.ObservacionFirma,
                            objSC.Accion,
                            objSC.Version,
                            objSC.Estado,
                            objSC.UsuarioCreacion,
                            objSC.UsuarioModificacion,
                            DateTime.Now).SingleOrDefault();

                        valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                        if (valorRetorno == 1)
                        {

                        }

                        dbContextTransaction.Commit();
                    }
                    catch (Exception ex)
                    {
                        //GinecoLog(this, ex);
                        dbContextTransaction.Rollback();
                        throw ex;
                    }
                }
            }
            return valorRetorno;
        }

        public int UpdateEspecialidadTriaje(SS_HC_EpisodioTriaje objSC)
        {

            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        SS_HC_EpisodioTriaje objAnterior = new SS_HC_EpisodioTriaje();

                        iReturnValue = context.USP_InsertarBandejaTriaje(

                            objSC.UnidadReplicacion,
                            objSC.IdPaciente,
                            objSC.IdPersonalSalud,
                            objSC.FechaAtencion,
                            objSC.IdEspecialidad,
                            objSC.IdPrioridad,
                            objSC.FlagFirma,
                            objSC.FechaFirma,
                            objSC.IdMedicoFirma,
                            objSC.ObservacionFirma,
                            objSC.Accion,
                            objSC.Version,
                            objSC.Estado,
                            objSC.UsuarioCreacion,
                            objSC.UsuarioModificacion,
                            objSC.FechaModificacion
                            ).SingleOrDefault();



                        valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                        if (valorRetorno == 1)
                        {

                        }

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


        public List<PERSONAMAST> GetSelectPersonaMast(PERSONAMAST objSC)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_PERSONAMAST(objSC.Persona, objSC.NombreCompleto, objSC.Estado, objSC.ACCION).ToList();
            }
        }

        public int RegistrarTriajeSpring(SS_CE_TriajeFirma objSC)
        {

            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new ClinicaElGolfEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        SS_HC_EpisodioTriaje objAnterior = new SS_HC_EpisodioTriaje();



                        iReturnValue = context.USP_FirmarTriajeSpring(
                            objSC.IdTriaje, objSC.Tipo, objSC.RutaFoto, objSC.Estado, objSC.UsuarioCreacion,
                            objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion,
                            objSC.TamañoImagen, objSC.IdEpisodioTriajeHCE).FirstOrDefault();
                        valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                        if (valorRetorno == 1)
                        {

                        }

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


        public List<SG_Agente> listarSG_AgenteLogin(SG_Agente objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SG_Agente> objLista = new List<SG_Agente>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                try
                {
                    //NUMEROLOGINSDISPONIBLE y NUMEROLOGINSUSADOS usados auxiliarmente como inicio y fin.
                    objLista = context.USP_SS_HC_SG_Agente_LISTAR(
                        objSC.IdAgente
                        , objSC.IdGrupo
                        , objSC.IdOrganizacion
                        , objSC.TipoAgente
                        , objSC.CodigoAgente
                        , objSC.IdEmpleado
                        , objSC.IndicadorMultiple
                        , objSC.Clave
                        , objSC.ExpiraClave
                        , objSC.FechaInicio
                        , objSC.FechaFin
                        , objSC.FechaExpiracion
                        , objSC.Nombre
                        , objSC.Descripcion
                        , objSC.Estado
                        , objSC.UsuarioCreacion
                        , objSC.FechaCreacion
                        , objSC.UsuarioModificacion
                        , objSC.FechaModificacion
                        , objSC.IdGrupoTransaccion
                        , objSC.TipoTransaccion
                        , objSC.IdOpcionDefecto
                        , objSC.Plataforma
                        , objSC.tipotrabajador
                        , objSC.IdCodigo
                        , inicio, final
                        , objSC.ACCION
                        ).ToList();

                    DataKey = new
                    {
                        IdAgente = objSC.IdAgente,
                        IdGrupo = objSC.IdGrupo
                    };
                    // Audit
                    //  String xlmIn = XMLString(objLista, new List<SG_Agente>(), "SG_Agente");
                    //  objAudit = AddAudita(new SG_Agente(), new SG_Agente(), DataKey, "L");
                    //  objAudit.TableName = "SG_Agente";
                    // objAudit.Type = "L";
                    //objAudit.Accion = "INSERT";
                    //objAudit.VistaData = xlmIn;
                    //context.Entry(objAudit).State = EntityState.Added;
                    //context.SaveChanges();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }

            return objLista;
        }


        public int InsertarPacienteTriajeWeb(PERSONAMAST objSP)
        {

            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        SS_HC_EpisodioTriaje objAnterior = new SS_HC_EpisodioTriaje();
                        SS_GE_Paciente objSC = new SS_GE_Paciente();

                        var FechaNacimiento = Convert.ToDateTime(objSP.FechaNacimiento);
                        DateTime nacimiento = FechaNacimiento;
                        int edad = DateTime.Today.AddTicks(-nacimiento.Ticks).Year - 1;

                        objSP.edad = edad;

                        objSC.Edad = edad;

                        iReturnValue = context.USP_SS_GE_Paciente(
                    objSP.Persona,
                    objSP.ApellidoPaterno.ToUpper(),
                    objSP.ApellidoMaterno.ToUpper(),
                    objSP.ApellidoPaterno.ToUpper() + " " + objSP.ApellidoMaterno.ToUpper() + " " + objSP.Nombres.ToUpper(),
                    objSP.TipoDocumento,
                    objSP.Documento,
                    objSP.CodigoBarras,
                    objSP.EsCliente,
                    objSP.EsEmpleado,
                    objSP.EsOtro,
                    objSP.TipoPersona,
                    objSP.EsProveedor,
                    objSP.FechaNacimiento,
                    objSP.CiudadNacimiento,
                    objSP.Sexo,
                    objSP.Nacionalidad,
                    objSP.EstadoCivil,
                    objSP.NivelInstruccion,
                    objSP.Direccion.ToUpper(),
                    objSP.CodigoPostal,
                    objSP.Provincia,
                    objSP.Departamento,
                    objSP.Telefono,
                    objSP.DocumentoFiscal,
                    objSP.Documento,
                    objSP.ACCION,
                    objSP.edad,
                    objSP.rangoEtario,
                    objSP.TipoMedico,
                    objSP.Correcion,
                    objSP.EsPaciente,
                    objSP.EsEmpresa,
                    objSP.Pais,
                    objSP.FlagActualizacion,
                    objSP.CuentaMonedaLocal_tmp,
                    objSP.CuentaMonedaExtranjera_tmp,
                    objSP.CorrelativoSCTR,
                    objSP.SeguroDiscamec,
                    objSP.CodDiscamec,
                   DateTime.Now,
                    DateTime.Now,
                    objSP.LugarNacimiento,
                    objSP.Celular,
                    objSP.CelularEmergencia,
                    objSP.ParentescoEmergencia,
                    objSP.DireccionReferencia,
                    DateTime.Now,
                    objSP.TipoPersonaUsuario,
                    objSP.UltimoUsuario,
                    objSP.Estado,
                    objSP.DireccionEmergencia,
                    objSP.TelefonoEmergencia,
                    objSP.BancoMonedaLocal,
                    objSP.TipoCuentaLocal,
                    objSP.CuentaMonedaLocal,
                    objSP.BancoMonedaExtranjera,
                    objSP.TipoCuentaExtranjera,
                    objSP.CuentaMonedaExtranjera,
                    objSP.CorreoElectronico,
                    objSP.EnfermedadGraveFlag,
                    DateTime.Now,
                    objSP.IngresoAplicacionCodigo,
                    objSP.IngresoUsuario,
                    objSP.PYMEFlag,
                    objSC.IdPaciente,
                    objSC.TipoPaciente,
                    objSC.Raza,
                    objSC.AreaLaboral,
                    objSC.Ocupacion,
                    objSC.CodigoHC,
                    objSC.CodigoHCAnterior,
                    objSC.CodigoHCSecundario,
                    objSC.TipoAlmacenamiento,
                    objSC.TipoHistoria,
                    objSC.TipoSituacion,
                    objSC.IdUbicacion,
                    objSC.LugarProcedencia,
                    objSC.RutaFoto,
                    objSC.Estado,
                    objSC.NumeroFile,
                    objSC.Servicio,
                    objSC.Observacion,
                    objSC.IndicadorAsistencia,
                    objSC.CantidadAsistencia,
                    objSC.UbicacionHHCC,
                    objSC.IndicadorMigradoSiteds,
                    objSC.NumeroCaja,
                    objSC.IndicadorCodigoBarras,
                    objSC.IDPACIENTE_OK,
                    objSC.CodigoAsegurado,
                    objSC.NumeroPoliza,
                    objSC.NumeroCertificado,
                    objSC.CodigoProducto,
                    objSC.CodigoPlan,
                    objSC.TipoParentesco,
                    objSC.CodigoBeneficio,
                    objSC.Situacion,
                    objSC.TomoActual,
                    objSC.IndicadorHistoriaFisica,
                    objSC.DescripcionHistoria,
                    objSP.PersonaAnt,
                    objSP.Nombres.ToUpper(),
                    objSP.ApellidoPaterno.ToUpper() + " " + objSP.ApellidoMaterno.ToUpper() + " " + objSP.Nombres.ToUpper(),
                    objSC.IdPersonal,
                    objSC.AtencionLugar,
                    objSC.Atencion,
                    objSC.IdEstablecimientoIngreso,
                    objSC.IdServicioIngreso,
                    objSC.Prestacion,
                    objSC.Destino,
                    objSC.NroAutorizacion,
                    objSC.Monto,
                    DateTime.Now,
                    DateTime.Now,
                    objSC.Establecimiento01,
                    objSC.ReferenciaHoja01,
                    objSC.Establecimiento02,
                    objSC.ReferenciaHoja02
                            ).SingleOrDefault();



                        valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                        if (valorRetorno > 1)
                        {

                        }

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

        public int RegistroPacientesSpringv2(PERSONAMAST objSP)
        {

            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR

            //if (objSP.ACCION == null)
            //{
            ENTITY_GLOBAL.Instance.NombreCompletoPaciente = objSP.ApellidoPaterno.ToUpper() + " " + objSP.ApellidoMaterno.ToUpper() + " " + objSP.Nombres.ToUpper();
            // }


            using (var context = new ClinicaElGolfEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        SS_HC_EpisodioTriaje objAnterior = new SS_HC_EpisodioTriaje();
                        SS_GE_Paciente objSC = new SS_GE_Paciente();

                        var FechaNacimiento = Convert.ToDateTime(objSP.FechaNacimiento);
                        DateTime nacimiento = FechaNacimiento;
                        int edad = DateTime.Today.AddTicks(-nacimiento.Ticks).Year - 1;
                        objSP.edad = edad;
                        objSC.Edad = edad;

                        var objValida = context.PersonaMast.Where(t => t.Documento.Trim() == objSP.Documento.Trim()).ToList();
                        if (objValida.Count == 0)
                        {
                            #region SetPaciente

                            iReturnValue = context.USP_SS_GE_PacienteSpring(
                         objSP.Persona,
                   objSP.ApellidoPaterno.ToUpper(),
                   objSP.ApellidoMaterno.ToUpper(),
                   objSP.ApellidoPaterno.ToUpper() + " " + objSP.ApellidoMaterno.ToUpper() + " " + objSP.Nombres.ToUpper(),
                   objSP.TipoDocumento,
                   objSP.Documento,
                   objSP.CodigoBarras,
                   objSP.EsCliente,
                   objSP.EsEmpleado,
                   objSP.EsOtro,
                   objSP.TipoPersona,
                   objSP.EsProveedor,
                   objSP.FechaNacimiento,
                   objSP.CiudadNacimiento,
                   objSP.Sexo,
                   objSP.Nacionalidad,
                   objSP.EstadoCivil,
                   objSP.NivelInstruccion,
                   objSP.Direccion.ToUpper(),
                   objSP.CodigoPostal,
                   objSP.Provincia,
                   objSP.Departamento,
                   objSP.Telefono,
                   objSP.DocumentoFiscal,
                   objSP.Documento,
                   objSP.ACCION,
                   objSP.edad,
                   objSP.rangoEtario,
                   objSP.TipoMedico,
                   objSP.Correcion,
                   objSP.EsPaciente,
                   objSP.EsEmpresa,
                   objSP.Pais,
                   objSP.FlagActualizacion,
                   objSP.CuentaMonedaLocal_tmp,
                   objSP.CuentaMonedaExtranjera_tmp,
                   objSP.CorrelativoSCTR,
                   objSP.SeguroDiscamec,
                   objSP.CodDiscamec,
                  DateTime.Now,
                   DateTime.Now,
                   objSP.LugarNacimiento,
                   objSP.Celular,
                   objSP.CelularEmergencia,
                   objSP.ParentescoEmergencia,
                   objSP.DireccionReferencia,
                   DateTime.Now,
                   objSP.TipoPersonaUsuario,
                   objSP.UltimoUsuario,
                   objSP.Estado,
                   objSP.DireccionEmergencia,
                   objSP.TelefonoEmergencia,
                   objSP.BancoMonedaLocal,
                   objSP.TipoCuentaLocal,
                   objSP.CuentaMonedaLocal,
                   objSP.BancoMonedaExtranjera,
                   objSP.TipoCuentaExtranjera,
                   objSP.CuentaMonedaExtranjera,
                   objSP.CorreoElectronico,
                   objSP.EnfermedadGraveFlag,
                   DateTime.Now,
                   objSP.IngresoAplicacionCodigo,
                   objSP.IngresoUsuario,
                   objSP.PYMEFlag,
                   objSC.IdPaciente,
                   objSC.TipoPaciente,
                   objSC.Raza,
                   objSC.AreaLaboral,
                   objSC.Ocupacion,
                   objSC.CodigoHC,
                   objSC.CodigoHCAnterior,
                   objSC.CodigoHCSecundario,
                   objSC.TipoAlmacenamiento,
                   objSC.TipoHistoria,
                   objSC.TipoSituacion,
                   objSC.IdUbicacion,
                   objSC.LugarProcedencia,
                   objSC.RutaFoto,
                   objSC.Estado,
                   objSC.NumeroFile,
                   objSC.Servicio,
                   objSC.Observacion,
                   objSC.IndicadorAsistencia,
                   objSC.CantidadAsistencia,
                   objSC.UbicacionHHCC,
                   objSC.IndicadorMigradoSiteds,
                   objSC.NumeroCaja,
                   objSC.IndicadorCodigoBarras,
                   objSC.IDPACIENTE_OK,
                   objSC.CodigoAsegurado,
                   objSC.NumeroPoliza,
                   objSC.NumeroCertificado,
                   objSC.CodigoProducto,
                   objSC.CodigoPlan,
                   objSC.TipoParentesco,
                   objSC.CodigoBeneficio,
                   objSC.Situacion,
                   objSC.TomoActual,
                   objSC.IndicadorHistoriaFisica,
                   objSC.DescripcionHistoria,
                   objSP.PersonaAnt,
                   objSP.Nombres.ToUpper(),
                   objSP.ApellidoPaterno.ToUpper() + " " + objSP.ApellidoMaterno.ToUpper() + " " + objSP.Nombres.ToUpper(),
                   objSC.IdPersonal,
                   objSC.AtencionLugar,
                   objSC.Atencion,
                   objSC.IdEstablecimientoIngreso,
                   objSC.IdServicioIngreso,
                   objSC.Prestacion,
                   objSC.Destino,
                   objSC.NroAutorizacion,
                   objSC.Monto,
                   DateTime.Now,
                   DateTime.Now,
                   objSC.Establecimiento01,
                   objSC.ReferenciaHoja01,
                   objSC.Establecimiento02,
                   objSC.ReferenciaHoja02

                           ).SingleOrDefault();
                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                            if (valorRetorno == 1)
                            {

                            }

                            dbContextTransaction.Commit();

                            #endregion
                        }
                        else
                        {
                            // DNI DUPLICADO

                            return 0000000000;
                        }



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


        public int InsertarPacienteTriaje(PERSONAMAST objSP)
        {

            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new ClinicaElGolfEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        SS_HC_EpisodioTriaje objAnterior = new SS_HC_EpisodioTriaje();
                        SS_GE_Paciente objSC = new SS_GE_Paciente();
                        var FechaNacimiento = Convert.ToDateTime(objSP.FechaNacimiento);
                        DateTime nacimiento = FechaNacimiento;
                        int edad = DateTime.Today.AddTicks(-nacimiento.Ticks).Year - 1;

                        objSP.edad = edad;

                        objSC.Edad = edad;

                        iReturnValue = context.SP_SS_GE_PacienteSpring(
                        objSP.Persona,
                        objSP.ApellidoPaterno.ToUpper(),
                        objSP.ApellidoMaterno.ToUpper(),
                        objSP.NombreCompleto.ToUpper() + " " + objSP.ApellidoPaterno.ToUpper() + ", " + objSP.ApellidoMaterno.ToUpper() + " " + objSP.Nombres,
                        objSP.TipoDocumento,
                        objSP.Documento,
                        objSP.CodigoBarras,
                        objSP.EsCliente,
                        objSP.EsEmpleado,
                        objSP.EsOtro,
                        objSP.TipoPersona,
                        objSP.EsProveedor,
                        objSP.FechaNacimiento,
                        objSP.CiudadNacimiento,
                        objSP.Sexo,
                        objSP.Nacionalidad,
                        objSP.EstadoCivil,
                        objSP.NivelInstruccion,
                        objSP.Direccion.ToUpper(),
                        objSP.CodigoPostal,
                        objSP.Provincia,
                        objSP.Departamento,
                        objSP.Telefono,
                        objSP.DocumentoFiscal,
                        objSP.Documento,
                        objSP.ACCION,
                        objSP.edad,
                        objSP.rangoEtario,
                        objSP.TipoMedico,
                        objSP.Correcion,
                        objSP.EsPaciente,
                        objSP.EsEmpresa,
                        objSP.Pais,
                        objSP.FlagActualizacion,
                        objSP.CuentaMonedaLocal_tmp,
                        objSP.CuentaMonedaExtranjera_tmp,
                        objSP.CorrelativoSCTR,
                        objSP.SeguroDiscamec,
                        objSP.CodDiscamec,
                        DateTime.Now,
                        DateTime.Now,
                        objSP.LugarNacimiento,
                        objSP.Celular,
                        objSP.CelularEmergencia,
                        objSP.ParentescoEmergencia,
                        objSP.DireccionReferencia,
                        DateTime.Now,
                        objSP.TipoPersonaUsuario,
                        objSP.UltimoUsuario,
                        objSP.Estado,
                        objSP.DireccionEmergencia,
                        objSP.TelefonoEmergencia,
                        objSP.BancoMonedaLocal,
                        objSP.TipoCuentaLocal,
                        objSP.CuentaMonedaLocal,
                        objSP.BancoMonedaExtranjera,
                        objSP.TipoCuentaExtranjera,
                        objSP.CuentaMonedaExtranjera,
                        objSP.CorreoElectronico,
                        objSP.EnfermedadGraveFlag,
                        DateTime.Now,
                        objSP.IngresoAplicacionCodigo,
                        objSP.IngresoUsuario,
                        objSP.PYMEFlag,
                        objSC.IdPaciente,
                        objSC.TipoPaciente,
                        objSC.Raza,
                        objSC.AreaLaboral,
                        objSC.Ocupacion,
                        objSC.CodigoHC,
                        objSC.CodigoHCAnterior,
                        objSC.CodigoHCSecundario,
                        objSC.TipoAlmacenamiento,
                        objSC.TipoHistoria,
                        objSC.TipoSituacion,
                        objSC.IdUbicacion,
                        objSC.LugarProcedencia,
                        objSC.RutaFoto,
                        objSC.Estado,
                        objSC.NumeroFile,
                        objSC.Servicio,
                        objSC.Observacion,
                        objSC.IndicadorAsistencia,
                        objSC.CantidadAsistencia,
                        objSC.UbicacionHHCC,
                        objSC.IndicadorMigradoSiteds,
                        objSC.NumeroCaja,
                        objSC.IndicadorCodigoBarras,
                        objSC.IDPACIENTE_OK,
                        objSC.CodigoAsegurado,
                        objSC.NumeroPoliza,
                        objSC.NumeroCertificado,
                        objSC.CodigoProducto,
                        objSC.CodigoPlan,
                        objSC.TipoParentesco,
                        objSC.CodigoBeneficio,
                        objSC.Situacion,
                        objSC.TomoActual,
                        objSC.IndicadorHistoriaFisica,
                        objSC.DescripcionHistoria,
                        objSP.PersonaAnt,
                        objSP.Nombres.ToUpper(),
                      objSP.ApellidoPaterno.ToUpper() + " " + objSP.ApellidoMaterno.ToUpper() + " " + objSP.Nombres.ToUpper(),
                        objSC.IdPersonal,
                        objSC.AtencionLugar,
                        objSC.Atencion,
                        objSC.IdEstablecimientoIngreso,
                        objSC.IdServicioIngreso,
                        objSC.Prestacion,
                        objSC.Destino,
                        objSC.NroAutorizacion,
                        objSC.Monto,
                        DateTime.Now,
                        DateTime.Now,
                        objSC.Establecimiento01,
                        objSC.ReferenciaHoja01,
                        objSC.Establecimiento02,
                        objSC.ReferenciaHoja02).FirstOrDefault();



                        valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                        if (valorRetorno > 1)
                        {

                        }

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

        public List<MA_MiscelaneosDetalle> GetUpListadoServicios(MA_MiscelaneosDetalle ObjTrace)
        {
            try
            {

                List<MA_MiscelaneosDetalle> objLista = new List<MA_MiscelaneosDetalle>();
                using (var context = new WEB_ERPSALUDEntities())
                {
                    objLista = context.USP_LISTARSERVICIOS(ObjTrace.AplicacionCodigo, ObjTrace.CodigoTabla, ObjTrace.Compania,
                        ObjTrace.CodigoElemento, ObjTrace.DescripcionLocal, ObjTrace.DescripcionExtranjera, ObjTrace.ValorNumerico,
                        ObjTrace.ValorCodigo1, ObjTrace.ValorCodigo2, ObjTrace.ValorCodigo3, ObjTrace.ValorCodigo4,
                        ObjTrace.ValorCodigo5, ObjTrace.ValorFecha, ObjTrace.Estado, ObjTrace.ACCION).ToList();

                }


                return objLista;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }



        public long SnedEpisodios(SS_HC_EpisodioAtencion objSC)
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
                            //  objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
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






        public List<MA_MiscelaneosDetalle> ListaComboDepartamentosProvincia(MA_MiscelaneosDetalle ObjTrace)
        {

            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_COMBOSMISCELANEOS(ObjTrace.AplicacionCodigo, ObjTrace.CodigoTabla, ObjTrace.Compania,
                    ObjTrace.CodigoElemento, ObjTrace.DescripcionLocal, ObjTrace.DescripcionExtranjera, ObjTrace.ValorNumerico,
                    ObjTrace.ValorCodigo1, ObjTrace.ValorCodigo2, ObjTrace.ValorCodigo3, ObjTrace.ValorCodigo4,
                    ObjTrace.ValorCodigo5, ObjTrace.ValorFecha, ObjTrace.Estado, ObjTrace.ACCION, ObjTrace.ValorEntero1,
                    ObjTrace.ValorEntero2, ObjTrace.ValorEntero3, ObjTrace.ValorEntero4, ObjTrace.ValorEntero5, ObjTrace.ValorEntero6,
                    ObjTrace.ValorEntero7).ToList();
            }
        }

        public List<MA_MiscelaneosDetalle> ListaComboUbigeo(MA_MiscelaneosDetalle ObjTrace, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_SS_HC_MA_MiscelaneosDetalle_LISTAR(
                    ObjTrace.AplicacionCodigo
                    , ObjTrace.CodigoTabla
                    , ObjTrace.Compania
                    , ObjTrace.CodigoElemento
                    , ObjTrace.DescripcionLocal
                    , ObjTrace.DescripcionExtranjera
                    , ObjTrace.ValorNumerico
                    , ObjTrace.ValorCodigo1
                    , ObjTrace.ValorCodigo2
                    , ObjTrace.ValorCodigo3
                    , ObjTrace.ValorCodigo4
                    , ObjTrace.ValorCodigo5
                    , ObjTrace.ValorFecha
                    , ObjTrace.Estado
                    , ObjTrace.UltimoUsuario
                    , ObjTrace.UltimaFechaModif
                    , ObjTrace.RowID
                    , ObjTrace.ValorEntero1
                    , ObjTrace.ValorEntero2
                    , ObjTrace.ValorEntero3
                    , ObjTrace.ValorEntero4
                    , ObjTrace.ValorEntero5
                    , ObjTrace.ValorCodigo6
                    , ObjTrace.ValorCodigo7
                    , ObjTrace.ValorEntero6
                    , ObjTrace.ValorEntero7

                    , inicio, final
                    , ObjTrace.ACCION
                    ).ToList();
            }
        }



        //public static void GinecoLog(object obj, Exception ex)
        //{

        //    string fecha = System.DateTime.Now.ToString("yyyyMMdd");
        //    string hora = System.DateTime.Now.ToString("HH:mm:ss");
        //    //string path = HttpContext.Current.Request.MapPath("~/log/" + fecha + ".txt");
        //    string path = System.Web.HttpContext.Current.Request.MapPath("~/log/" + fecha + ".txt");
        //    StreamWriter sw = new StreamWriter(path, true);
        //    StackTrace stacktrace = new StackTrace();
        //    sw.WriteLine(obj.GetType().FullName + " " + hora);
        //    sw.WriteLine(stacktrace.GetFrame(1).GetMethod().Name + " - " + ex.Message);
        //    sw.WriteLine("");
        //    sw.Flush();
        //    sw.Close();

        //}



    }
}
