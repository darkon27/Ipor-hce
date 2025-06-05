using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Model;
using System.Data.Entity;


namespace SoluccionSalud.Repository.DALVW_PERSONAPACIENTE
{
    public class SP_SS_GE_PacienteRepository : AuditGenerico<SS_GE_Paciente, SS_GE_Paciente> 
    {
        public List<SS_GE_Paciente> listarPaciente(SS_GE_Paciente objSC, int inicio, int final)
        {

            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_SS_GE_Paciente_Listar(
                    objSC.IdPaciente,
                    objSC.TipoPaciente,
                    objSC.Edad,
                    objSC.Raza,
                    objSC.Religion,
                    objSC.Cargo,
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
                    objSC.FechaIngreso,
                    objSC.IndicadorNuevo,
                    objSC.Estado,
                    objSC.UsuarioCreacion,
                    objSC.FechaCreacion,
                    objSC.UsuarioModificacion,
                    objSC.FechaModificacion,
                    objSC.NumeroFile,
                    objSC.Servicio,
                    objSC.UsuarioAlmacenamiento,
                    objSC.FechaAlmacenamiento,
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
                    objSC.Accion,
                    objSC.IdPersonal,
                    objSC.AtencionLugar,
                    objSC.Atencion,
                    objSC.IdEstablecimientoIngreso,
                    objSC.IdServicioIngreso,
                    objSC.Prestacion,
                    objSC.Destino,
                    objSC.NroAutorizacion,
                    objSC.Monto,
                    objSC.FechaIngresoHosp,
                    objSC.FechaCorteHosp,
                    objSC.Establecimiento01,
                    objSC.ReferenciaHoja01,
                    objSC.Establecimiento02,
                    objSC.ReferenciaHoja02
                    , inicio
                    , final).ToList();

            }
        }
        public int setMantenimiento(SS_GE_Paciente objSC, PERSONAMAST objSP)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;

            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        SS_GE_Paciente objAnterior = new SS_GE_Paciente();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_GE_Paciente
                                           where t.IdPaciente == objSC.IdPaciente
                                           orderby t.IdPaciente descending
                                           select t).SingleOrDefault();
                        }
                        //PERSONAMAST objAnteriorr = new PERSONAMAST();
                        //if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        //{
                        //    objAnteriorr = (from t in context.PERSONAMASTs
                        //                    where t.Persona == objSP.Persona
                        //                    orderby t.Persona descending
                        //                   select t).SingleOrDefault();
                        //}
                iReturnValue = context.USP_SS_GE_Paciente(
                    objSP.Persona,
                    objSP.ApellidoPaterno,
                    objSP.ApellidoMaterno,
                    objSP.NombreCompleto,
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
                    objSP.Direccion,
                    objSP.CodigoPostal,
                    objSP.Provincia,
                    objSP.Departamento,
                    objSP.Telefono,
                    objSP.DocumentoFiscal,
                    objSP.DocumentoIdentidad,
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
                    objSP.FecIniDiscamec,
                    objSP.FecFinDiscamec,
                    objSP.LugarNacimiento,
                    objSP.Celular,
                    objSP.CelularEmergencia,
                    objSP.ParentescoEmergencia,
                    objSP.DireccionReferencia,
                    objSP.UltimaFechaModif,
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
                    objSP.IngresoFechaRegistro,
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
                    objSP.Nombres,
                    objSP.Busqueda,
                    objSC.IdPersonal,
                    objSC.AtencionLugar,
                    objSC.Atencion,
                    objSC.IdEstablecimientoIngreso,
                    objSC.IdServicioIngreso,
                    objSC.Prestacion,
                    objSC.Destino,
                    objSC.NroAutorizacion,
                    objSC.Monto,
                    objSC.FechaIngresoHosp,
                    objSC.FechaCorteHosp,
                    objSC.Establecimiento01,
                    objSC.ReferenciaHoja01,
                    objSC.Establecimiento02,
                    objSC.ReferenciaHoja02

                    ).SingleOrDefault();

                //*  Registra Audit/
                DataKey = new
                {
                    //Persona = objSP.Persona,
                    IdPaciente = objSC.IdPaciente
                };

                if (objAnterior == null) objAnterior = new SS_GE_Paciente();
                objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                objAudit.TableName = "SS_GE_Paciente";
                objAudit.Type = objSC.Accion.Substring(0, 1);
                if (((objAudit.OldData.Trim().Length != 0) || (objAudit.NewData.Trim().Length != 0)) || (objAudit.Type == "D"))
                {
                    if (objAudit.Type != "L")
                    {
                        context.Entry(objAudit).State = EntityState.Added;
                        context.SaveChanges();
                    }
                }

                //if (objAnteriorr == null) objAnteriorr = new PERSONAMAST();
                //objAudit = AddAudita(objAnteriorr, objSC, DataKey, objSC.Accion.Substring(0, 1));
                //objAudit.TableName = "PERSONAMAST";
                //objAudit.Type = objSC.Accion.Substring(0, 1);
                //if (((objAudit.OldData.Trim().Length != 0) || (objAudit.NewData.Trim().Length != 0)) || (objAudit.Type == "D"))
                //{
                //    if (objAudit.Type != "L")
                //    {
                //        context.Entry(objAudit).State = EntityState.Added;
                //        context.SaveChanges();
                //    }
                //}
                //*/
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

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
