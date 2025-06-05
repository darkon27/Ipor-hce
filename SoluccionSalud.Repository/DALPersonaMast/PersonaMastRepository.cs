using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALPersonaMast
{
    public class PersonaMastRepository : AuditGenerico<PERSONAMAST, PERSONAMAST>, IPersonaMastRepository
    {

        public List<PERSONAMAST> GetSelectPersonaMast(PERSONAMAST objSC)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_PERSONAMAST(objSC.Persona, objSC.NombreCompleto, objSC.Estado, objSC.ACCION).ToList();
            }
        }
        public List<PERSONAMAST> listarPersonaMast(PERSONAMAST objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<PERSONAMAST> objLista = new List<PERSONAMAST>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_HC_Personamast_Listar(objSC.Persona,objSC.Origen,objSC.ApellidoPaterno,objSC.ApellidoMaterno,
                objSC.Nombres,objSC.NombreCompleto,objSC.Busqueda,objSC.GrupoEmpresarial,objSC.TipoDocumento,objSC.Documento,objSC.CodigoBarras,
                objSC.EsCliente,objSC.EsProveedor,objSC.EsEmpleado,objSC.EsOtro,objSC.TipoPersona,objSC.FechaNacimiento,objSC.CiudadNacimiento,
                objSC.Sexo,objSC.Nacionalidad,objSC.EstadoCivil,objSC.NivelInstruccion,objSC.Direccion,objSC.CodigoPostal,
                objSC.Provincia,objSC.Departamento,objSC.Telefono,objSC.Fax,objSC.DocumentoFiscal,objSC.DocumentoIdentidad,
                objSC.CarnetExtranjeria,objSC.DocumentoMilitarFA,objSC.TipoBrevete,objSC.Brevete,objSC.Pasaporte,
                objSC.NombreEmergencia,objSC.DireccionEmergencia,objSC.TelefonoEmergencia,objSC.BancoMonedaLocal,
                objSC.TipoCuentaLocal,objSC.CuentaMonedaLocal,objSC.BancoMonedaExtranjera,objSC.TipoCuentaExtranjera,
                objSC.CuentaMonedaExtranjera,objSC.PersonaAnt,objSC.CorreoElectronico,objSC.ClasePersonaCodigo,
                objSC.PersonaClasificacion,objSC.EnfermedadGraveFlag,objSC.IngresoFechaRegistro,objSC.IngresoAplicacionCodigo,
                objSC.IngresoUsuario,objSC.PYMEFlag,objSC.Estado,objSC.UltimoUsuario,objSC.UltimaFechaModif,objSC.TipoPersonaUsuario,
                objSC.DireccionReferencia,objSC.Celular,objSC.ParentescoEmergencia,objSC.CelularEmergencia,
                objSC.LugarNacimiento,objSC.SuspensionFonaviFlag,objSC.FlagRepetido,objSC.CodDiscamec,objSC.FecIniDiscamec,
                objSC.FecFinDiscamec,objSC.CodLicArma,objSC.MarcaArma,objSC.SerieArma,objSC.InicioArma,objSC.VencimientoArma,
                objSC.SeguroDiscamec,objSC.CorrelativoSCTR,objSC.CuentaMonedaExtranjera_tmp,objSC.CuentaMonedaLocal_tmp,
                objSC.FlagActualizacion,objSC.TarjetadeCredito,objSC.Pais,objSC.EsPaciente,objSC.EsEmpresa,objSC.Persona_Old,
                objSC.personanew,objSC.cmp,objSC.SUNATNacionalidad,objSC.SUNATVia,objSC.SUNATZona,objSC.SUNATUbigeo,
                objSC.SUNATDomiciliado,objSC.IndicadorAutogenerado,objSC.RutaFirma,objSC.TipoDocumentoIdentidad,
                objSC.IdPersonaUnificado,objSC.idpersona_ok,objSC.edad,objSC.rangoEtario,objSC.TipoMedico,
                objSC.Correcion,objSC.IdEmpresaAnteriorUnificacion,objSC.brevete_fecvcto,objSC.carnetextranjeria_fecvcto,
                objSC.Estado_BK,objSC.Estado_Bks,objSC.IndicadorVinculada,objSC.PaisEmisor,objSC.CodigoLDN,objSC.SunatConvenio,
                objSC.IndicadorRegistroManual,objSC.IndicadorFallecido,objSC.IndicadorSinCorreo,objSC.ACCION, inicio, final
                 ).ToList();
                DataKey = new
                {
                    Persona = objSC.Persona,
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<PERSONAMAST>(), "PERSONAMAST");
                objAudit = AddAudita(new PERSONAMAST(), new PERSONAMAST(), DataKey, "L");
                objAudit.TableName = "PERSONAMAST";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
            }
            return objLista;
        }

        public int setMantenimiento(PERSONAMAST objSC)
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
                        PERSONAMAST objAnterior = new PERSONAMAST();
                        if ((objSC.ACCION.Substring(0, 1) != "I") || (objSC.ACCION.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.PERSONAMASTs
                                           where t.Persona == objSC.Persona
                                           orderby t.Persona descending
                                           select t).SingleOrDefault();
                        }
                        iReturnValue = context.USP_HC_Personamast(
                  objSC.Persona,
                  objSC.Origen,
                  objSC.ApellidoPaterno,
                  objSC.ApellidoMaterno,
                  objSC.Nombres,

                  objSC.NombreCompleto,
                  objSC.Busqueda,
                  objSC.GrupoEmpresarial,
                  objSC.TipoDocumento,
                  objSC.Documento,

                  objSC.CodigoBarras,
                  objSC.EsCliente,
                  objSC.EsProveedor,
                  objSC.EsEmpleado,
                  objSC.EsOtro,

                  objSC.TipoPersona,
                  objSC.FechaNacimiento,
                  objSC.CiudadNacimiento,
                  objSC.Sexo,
                  objSC.Nacionalidad,

                  objSC.EstadoCivil,
                  objSC.NivelInstruccion,
                  objSC.Direccion,
                  objSC.CodigoPostal,
                  objSC.Provincia,

                  objSC.Departamento,
                  objSC.Telefono,
                  objSC.Fax,
                  objSC.DocumentoFiscal,
                  objSC.DocumentoIdentidad,

                  objSC.CarnetExtranjeria,
                  objSC.DocumentoMilitarFA,
                  objSC.TipoBrevete,
                  objSC.Brevete,
                  objSC.Pasaporte,

                  objSC.NombreEmergencia,
                  objSC.DireccionEmergencia,
                  objSC.TelefonoEmergencia,
                  objSC.BancoMonedaLocal,
                  objSC.TipoCuentaLocal,

                  objSC.CuentaMonedaLocal,
                  objSC.BancoMonedaExtranjera,
                  objSC.TipoCuentaExtranjera,
                  objSC.CuentaMonedaExtranjera,
                  objSC.PersonaAnt,

                  objSC.CorreoElectronico,
                  objSC.ClasePersonaCodigo,
                  objSC.PersonaClasificacion,
                  objSC.EnfermedadGraveFlag,
                  objSC.IngresoFechaRegistro,

                  objSC.IngresoAplicacionCodigo,
                  objSC.IngresoUsuario,
                  objSC.PYMEFlag,
                  objSC.Estado,
                  objSC.UltimoUsuario,

                  objSC.UltimaFechaModif,
                  objSC.TipoPersonaUsuario,
                  objSC.DireccionReferencia,
                  objSC.Celular,
                  objSC.ParentescoEmergencia,

                  objSC.CelularEmergencia,
                  objSC.LugarNacimiento,
                  objSC.SuspensionFonaviFlag,
                  objSC.FlagRepetido,
                  objSC.CodDiscamec,

                  objSC.FecIniDiscamec,
                  objSC.FecFinDiscamec,
                  objSC.CodLicArma,
                  objSC.MarcaArma,
                  objSC.SerieArma,

                  objSC.InicioArma,
                  objSC.VencimientoArma,
                  objSC.SeguroDiscamec,
                  objSC.CorrelativoSCTR,
                  objSC.CuentaMonedaExtranjera_tmp,

                  objSC.CuentaMonedaLocal_tmp,
                  objSC.FlagActualizacion,
                  objSC.TarjetadeCredito,
                  objSC.Pais,
                  objSC.EsPaciente,

                  objSC.EsEmpresa,
                  objSC.Persona_Old,
                  objSC.personanew,
                  objSC.cmp,
                  objSC.SUNATNacionalidad,

                  objSC.SUNATVia,
                  objSC.SUNATZona,
                  objSC.SUNATUbigeo,
                  objSC.SUNATDomiciliado,
                  objSC.IndicadorAutogenerado,

                  objSC.RutaFirma,
                  objSC.TipoDocumentoIdentidad,
                  objSC.IdPersonaUnificado,
                  objSC.idpersona_ok,
                  objSC.edad,

                  objSC.rangoEtario,
                  objSC.TipoMedico,
                  objSC.Correcion,
                  objSC.IdEmpresaAnteriorUnificacion,
                  objSC.brevete_fecvcto,

                  objSC.carnetextranjeria_fecvcto,
                  objSC.Estado_BK,
                  objSC.Estado_Bks,
                  objSC.IndicadorVinculada,
                  objSC.PaisEmisor,

                  objSC.CodigoLDN,
                  objSC.SunatConvenio,
                  objSC.IndicadorRegistroManual,
                  objSC.IndicadorFallecido,
                  objSC.IndicadorSinCorreo,

                  objSC.ACCION).SingleOrDefault();
                        DataKey = new
                        {
                            Persona = objSC.Persona,
                        };
                        if (objAnterior == null) objAnterior = new PERSONAMAST();
                        objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.ACCION.Substring(0, 1));
                        objAudit.TableName = "PERSONAMAST";
                        objAudit.Type = objSC.ACCION.Substring(0, 1);
                        if (((objAudit.OldData.Trim().Length != 0) || (objAudit.NewData.Trim().Length != 0)) || (objAudit.Type == "D"))
                        {
                            if (objAudit.Type != "L")
                            {
                                context.Entry(objAudit).State = EntityState.Added;
                                context.SaveChanges();
                            }
                        }

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
        public int setMantenimiento(List<PERSONAMAST> listaObjSC)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;
            System.Nullable<int> iReturnValue = 0;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        if (listaObjSC != null)
                        {
                            foreach (var objSC in listaObjSC)
                            {
                                iReturnValue = context.USP_HC_Personamast(objSC.Persona, objSC.Origen, objSC.ApellidoPaterno, objSC.ApellidoMaterno, objSC.Nombres,
                                    objSC.NombreCompleto, objSC.Busqueda, objSC.GrupoEmpresarial, objSC.TipoDocumento, objSC.Documento, objSC.CodigoBarras, objSC.EsCliente,
                                    objSC.EsProveedor, objSC.EsEmpleado,objSC.EsOtro,objSC.TipoPersona,objSC.FechaNacimiento,objSC.CiudadNacimiento,objSC.Sexo,
                                    objSC.Nacionalidad,objSC.EstadoCivil,objSC.NivelInstruccion,objSC.Direccion,objSC.CodigoPostal,objSC.Provincia,objSC.Departamento,
                                    objSC.Telefono,objSC.Fax,objSC.DocumentoFiscal,objSC.DocumentoIdentidad,objSC.CarnetExtranjeria,objSC.DocumentoMilitarFA,
                                    objSC.TipoBrevete,objSC.Brevete,objSC.Pasaporte,objSC.NombreEmergencia,objSC.DireccionEmergencia,objSC.TelefonoEmergencia,
                                    objSC.BancoMonedaLocal,objSC.TipoCuentaLocal,objSC.CuentaMonedaLocal,objSC.BancoMonedaExtranjera,objSC.TipoCuentaExtranjera,
                                    objSC.CuentaMonedaExtranjera,objSC.PersonaAnt,objSC.CorreoElectronico,objSC.ClasePersonaCodigo,objSC.PersonaClasificacion,
                                    objSC.EnfermedadGraveFlag,objSC.IngresoFechaRegistro,objSC.IngresoAplicacionCodigo,objSC.IngresoUsuario,objSC.PYMEFlag,
                                    objSC.Estado,objSC.UltimoUsuario,objSC.UltimaFechaModif,objSC.TipoPersonaUsuario,objSC.DireccionReferencia,objSC.Celular,
                                    objSC.ParentescoEmergencia,objSC.CelularEmergencia,objSC.LugarNacimiento,objSC.SuspensionFonaviFlag,objSC.FlagRepetido,
                                    objSC.CodDiscamec,objSC.FecIniDiscamec,objSC.FecFinDiscamec,objSC.CodLicArma,objSC.MarcaArma,objSC.SerieArma,objSC.InicioArma,
                                    objSC.VencimientoArma,objSC.SeguroDiscamec,objSC.CorrelativoSCTR,objSC.CuentaMonedaExtranjera_tmp,objSC.CuentaMonedaLocal_tmp,
                                    objSC.FlagActualizacion,objSC.TarjetadeCredito,objSC.Pais,objSC.EsPaciente,objSC.EsEmpresa,objSC.Persona_Old,objSC.personanew,
                                    objSC.cmp,objSC.SUNATNacionalidad,objSC.SUNATVia,objSC.SUNATZona,objSC.SUNATUbigeo,objSC.SUNATDomiciliado,objSC.IndicadorAutogenerado,
                                    objSC.RutaFirma,objSC.TipoDocumentoIdentidad,objSC.IdPersonaUnificado,objSC.idpersona_ok,objSC.edad,objSC.rangoEtario,objSC.TipoMedico,
                                    objSC.Correcion,objSC.IdEmpresaAnteriorUnificacion,objSC.brevete_fecvcto,objSC.carnetextranjeria_fecvcto,objSC.Estado_BK,
                                    objSC.Estado_Bks,objSC.IndicadorVinculada,objSC.PaisEmisor,objSC.CodigoLDN,objSC.SunatConvenio,objSC.IndicadorRegistroManual,
                                    objSC.IndicadorFallecido,objSC.IndicadorSinCorreo,objSC.ACCION).SingleOrDefault();
                            }
                        }
                        valorRetorno = Convert.ToInt32(iReturnValue);
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
