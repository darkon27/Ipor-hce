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
    public class Vw_PersonapacienteRepository : AuditGenerico<VW_PERSONAPACIENTE, VW_PERSONAPACIENTE> 
    {
        public List<VW_PERSONAPACIENTE> listarVwPersonapaciente(VW_PERSONAPACIENTE objSC, int inicio, int final)
        {
            try
            {
               
                dynamic DataKey = null;
                SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                List<VW_PERSONAPACIENTE> objLista = new List<VW_PERSONAPACIENTE>();
              
                /////
                using (var context = new WEB_ERPSALUDEntities())
                {
                          objLista = context.USP_VW_PERSONAPACIENTE_LISTAR(
                                             objSC.Persona
                                             , objSC.NombreCompleto
                                             , objSC.TipoDocumento
                                             , objSC.Documento
                                              , objSC.EsCliente
                                             , objSC.EsEmpleado
                                             , objSC.EsOtro
                                             , objSC.EsProveedor
                                             , objSC.EsPaciente
                                             , objSC.EsEmpresa
                                             , objSC.FechaNacimiento
                                             , objSC.Sexo
                                             , objSC.EstadoCivil
                                             , objSC.NivelInstruccion
                                             , objSC.CodigoPostal
                                             , objSC.Provincia
                                             , objSC.Departamento
                                             , objSC.TipoMedico
                                             , objSC.Estado
                                             , objSC.EstadoEmpleado
                                             , objSC.FechaIngreso
                                             , objSC.CompaniaSocio
                                             , objSC.CentroCostos
                                             , objSC.AFE
                                             , objSC.GradoSalario
                                             , objSC.CodigoCargo
                                             , objSC.DepartamentoOperacional
                                             , null
                                             , null
                                             , objSC.USUARIO
                                             , objSC.USUARIOPERFIL
                                             , objSC.TipoPersona
                                             , objSC.Nombres
                                             , objSC.PersonaAnt
                                             , objSC.Busqueda
                                             , inicio
                                             , final
                                             , objSC.ACCION
                                             ).ToList();
                    
                 

                    DataKey = new
                    {
                        Persona = objSC.Persona,
                        Paciente = objSC.Paciente
                    };
                    // Audit
                    String xlmIn = XMLString(objLista, new List<VW_PERSONAPACIENTE>(), "VW_PERSONAPACIENTE");
                    objAudit = AddAudita(new VW_PERSONAPACIENTE(), objSC, DataKey, "L");
                    objAudit.TableName = "VW_PERSONAPACIENTE";
                    objAudit.Type = "L";
                    objAudit.Accion = "INSERT";
                    objAudit.VistaData = xlmIn;
                    context.Entry(objAudit).State = EntityState.Added;
                    context.SaveChanges();

                }
                return objLista;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public int setMantenimiento(VW_PERSONAPACIENTE objSC)
        {
            try
            {
                /////
                System.Nullable<int> iReturnValue;
                int valorRetorno = 0;
                using (var context = new WEB_ERPSALUDEntities())
                {
                    iReturnValue = context.USP_VW_PERSONAPACIENTE(
                          objSC.Persona
                        , objSC.NombreCompleto
                        , objSC.TipoDocumento
                        , objSC.Documento
                         , objSC.EsCliente
                        , objSC.EsEmpleado
                        , objSC.EsOtro
                        , objSC.EsProveedor
                        , objSC.EsPaciente
                        , objSC.EsEmpresa
                        , objSC.FechaNacimiento
                        , objSC.Sexo
                        , objSC.EstadoCivil
                        , objSC.NivelInstruccion
                        , objSC.CodigoPostal
                        , objSC.Provincia
                        , objSC.Departamento
                        , objSC.TipoMedico
                        , objSC.Estado
                        , objSC.EstadoEmpleado
                        , objSC.FechaIngreso
                        , objSC.CompaniaSocio
                        , objSC.CentroCostos
                        , objSC.AFE
                        , objSC.GradoSalario
                        , objSC.CodigoCargo
                        , objSC.DepartamentoOperacional
                        , null
                        , null
                        , objSC.USUARIO
                        , objSC.USUARIOPERFIL
                        , null
                        , null
                        , objSC.ACCION
                    ).SingleOrDefault();
                    valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                }
                return valorRetorno;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

    }
}
