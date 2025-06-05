using SoluccionSalud.SOA.Entidades;
using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.SOA
{
    public class RepositySOA
    {
        public List<VW_ATENCIONPACIENTE_GENERAL> ListaAtenciones(VW_ATENCIONPACIENTE_GENERAL objSC)
        {
            try
            {
                using (var context = new ClinicaElGolfEntities())
                {

                    return context.USP_SS_HC_ATENCIONES_SOA(
                         objSC.tipoListado
                        , objSC.CitaTipo
                        , objSC.CitaFecha
                        , objSC.Origen
                        , objSC.NombreEspecialidad
                        , objSC.TipoPacienteNombre
                        , objSC.CodigoOA
                        , objSC.Cama
                        , objSC.TipoOrdenAtencionNombre
                        , objSC.CodigoHC
                        , objSC.PacienteNombre
                        , objSC.MedicoNombre
                        , objSC.IdOrdenAtencion
                        , objSC.LineaOrdenAtencion
                        , objSC.IdHospitalizacion
                        , objSC.IdCita
                        , objSC.IdPaciente
                        , objSC.TipoPaciente
                        , objSC.TipoAtencion
                        , objSC.IdEspecialidad
                        , objSC.IdMedico
                        , objSC.TipoOrdenAtencion
                        , objSC.Componente
                        , objSC.Compania
                        , objSC.Sucursal
                        , objSC.EstadoPersona
                        , objSC.EstadoEpiClinico
                        , objSC.UnidadReplicacion
                        , objSC.UnidadReplicacionEC
                        , objSC.IdEpisodioAtencion
                        , objSC.EpisodioClinico
                        , objSC.IdEstablecimientoSalud
                        , objSC.IdUnidadServicio
                        , objSC.IdPersonalSalud
                        , objSC.EpisodioAtencion
                        , objSC.FechaRegistro
                        , objSC.FechaAtencion
                        , objSC.EstadoEpiAtencion
                        , objSC.FechaInicio
                        , objSC.FechaFin
                        , objSC.UsuarioCreacion
                        , objSC.FechaCreacion
                        , objSC.UsuarioModificacion
                        , objSC.FechaModificacion
                        , objSC.Version
                        , objSC.CodigoHCAnterior

                        , objSC.IndicadorCirugia
                        , objSC.IndicadorExamenPrincipal
                        , objSC.IndicadorSeguro
                        , objSC.Modalidad
                        , objSC.sexo
                        , objSC.EstadoCivil
                        , objSC.NivelInstruccion
                        , objSC.EsPaciente
                        , objSC.EsEmpresa

                        , objSC.NumeroFila
                        , objSC.Contador
                        , objSC.Accion
                    ).ToList();
                }
            }
            catch (DbEntityValidationException ex)
            {
                var msj = "";
                foreach (var validationErrors in ex.EntityValidationErrors)
                {
                    foreach (var validationError in validationErrors.ValidationErrors)
                    {
                        // Mostrar el error en la consola o registrarlo en un log
                        msj += "Property: {validationError.PropertyName} Error: {validationError.ErrorMessage}";
                    }
                }
                throw ex;
            }
            //catch (Exception ex)
            //{
            //    //var sqlException = ex.InnerException as SqlException;
            //    throw ex;
            //}
        }

        public int ListaConsultaExterna(SS_HCE_ConsultaExterna objSC)
        {
            int valorRetorno = -1; //ERROR

            using (var context = new ClinicaElGolfEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        Nullable<int> iReturnValue;

                        iReturnValue = context.SP_HCE_ITListarValidacionEmergencia(
                        objSC.UnidadReplicacion
                       , objSC.IdEpisodioAtencion
                       , objSC.IdPaciente
                       , objSC.EpisodioClinico
                       , objSC.IdConsultaExterna
                       , objSC.IdOrdenAtencion
                       , objSC.Linea
                       , objSC.LineaOrdenAtencion
                       , objSC.TipoOrdenMedica
                       , objSC.Componente
                       , objSC.TipoInterConsulta
                       , objSC.Medico
                       , objSC.Especialidad
                       , objSC.EstadoDocumento
                       , objSC.IndicadorEPS
                       , objSC.Estado
                       , objSC.MedicoResponsable
                       , objSC.UsuarioCreacion
                       , objSC.UsuarioModificacion
                       , objSC.SecuenciaHCE
                       , objSC.FechaCreacion
                       , objSC.FechaModificacion
                       , objSC.Accion
                       , objSC.Version).SingleOrDefault();
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

        public int ListaRecetaConsultaExterna(SS_HCE_RecetaConsultaExterna objSC)
        {
            int valorRetorno = -1; //ERROR

            using (var context = new ClinicaElGolfEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        Nullable<int> iReturnValue;

                        iReturnValue = context.SP_HCE_SPRINGRECETAConsultaExternaV2(
                       objSC.IdOrdenAtencion
                      , objSC.LineaOA
                      , objSC.IdPaciente
                      , objSC.Componente
                      , objSC.Unidadmedida
                      , objSC.linea
                      , objSC.Familia
                      , objSC.Subfamilia
                      , objSC.Cantidad
                      , objSC.Via
                      , objSC.Dosis
                      , objSC.Diastratamiento
                      , objSC.Frecuencia
                      , objSC.IndicadorEPS
                      , objSC.Usuario
                      , objSC.FechaCreacion
                      , objSC.IndicacionEspecifica
                      , objSC.lineamax
                      , objSC.TIPOORDENATENCION
                      , objSC.SecuenciaHCE).SingleOrDefault();
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
