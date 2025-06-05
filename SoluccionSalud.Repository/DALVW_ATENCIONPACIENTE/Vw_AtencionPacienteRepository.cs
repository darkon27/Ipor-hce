using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Model;
using System.Data.Entity;
using Newtonsoft.Json;
using System.Xml;
using System.Xml.Serialization;
using System.Collections;

using System.IO;
 

namespace SoluccionSalud.Repository.DALVW_ATENCIONPACIENTE
{
    public class Vw_AtencionPacienteRepository : AuditGenerico<VW_ATENCIONPACIENTE_GENERAL, object> 
    {
        public List<VW_ATENCIONPACIENTE> listarVwAtencionPaciente(VW_ATENCIONPACIENTE objSC, int inicio, int final)
        {
            try
            {
                using (var context = new WEB_ERPSALUDEntities())
                {
                    return context.USP_VW_ATENCIONPACIENTE_LISTAR(
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
                        , objSC.UsuarioModificacion
                        , objSC.FechaModificacion
                        , objSC.IdEspecialidad
                        , objSC.CodigoOA
                        , objSC.FechaOrden
                        , objSC.IdProcedimiento
                        , objSC.IdTipoOrden
                        , objSC.FechaRegistroEpiClinico
                        , objSC.FechaCierreEpiClinico
                        , objSC.TipoPaciente
                        , objSC.Edad
                        , objSC.CodigoHC
                        , objSC.CodigoHCAnterior
                        , objSC.CodigoHCSecundario
                        , objSC.TipoHistoria
                        , objSC.EstadoPaciente
                        , objSC.NumeroFile
                        , objSC.IDPACIENTE_OK
                        , objSC.Persona
                        , objSC.NombreCompleto
                        , objSC.TipoDocumento
                        , objSC.Documento
                        , objSC.EsCliente
                        , objSC.EsProveedor
                        , objSC.EsEmpleado
                        , objSC.EsOtro
                        , objSC.TipoPersona
                        , objSC.FechaNacimiento
                        , objSC.Sexo
                        , objSC.Nacionalidad
                        , objSC.EstadoCivil
                        , objSC.NivelInstruccion
                        , objSC.CodigoPostal
                        , objSC.Provincia
                        , objSC.Departamento
                        , objSC.FecIniDiscamec
                        , objSC.FecFinDiscamec
                        , objSC.Pais
                        , objSC.EsPaciente
                        , objSC.EsEmpresa
                        , objSC.personanew
                        , objSC.EstadoPersona
                        , objSC.Servicio
                        , inicio
                        , final
                        , objSC.Version
                        , objSC.Accion
                    ).ToList();
                }
            }         
            catch (Exception ex)
            {                
                throw ex;
            }
        }

        public List<VW_ATENCIONPACIENTE> listarVwAtencionPaciente(VW_ATENCIONPACIENTE_GENERAL objSC, List<VW_ATENCIONPACIENTE_GENERAL> objSCList, int inicio, int final)
        {
            try
            {
                SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                dynamic DataKey;
                String xml = "";
                using (var context = new WEB_ERPSALUDEntities())
                {
                    //*  Registra Audit/
                    var objOrigen = new VW_ATENCIONPACIENTE_GENERAL();
                    var objDestino = new VW_ATENCIONPACIENTE_GENERAL();

                    String xlmIn = "";
                    //foreach (VW_ATENCIONPACIENTE_GENERAL result in objSCList)
                    //{
                    //    xlmIn += JsonConvert.SerializeObject(result);
                    //}

                    //xlmIn = XMLString(objSCList);
                    xlmIn = JsonConvert.SerializeObject(objSCList);    // 2018/01/09 ---Jordan Mateo
                    //string output = JsonConvert.SerializeObject(objSCList);
                    //ENTITY_GLOBAL deserializedProduct = JsonConvert.DeserializeObject<ENTITY_GLOBAL>(output);
                    DataKey = new
                    {
                        IdPaciente = objSC.IdPaciente,
                        FechaAtencion = objSC.FechaAtencion,
                        FechaInicio = objSC.FechaInicio,
                        FechaFin = objSC.FechaFin,
                        CodigoHC = objSC.CodigoHC,
                        CodigoHCAnterior = objSC.CodigoHCAnterior,
                        CodigoOA = objSC.CodigoOA,
                        PacienteNombre = objSC.PacienteNombre,
                        EstadoEpiAtencion = objSC.EstadoEpiAtencion,
                        tipoListado = objSC.tipoListado,
                        IdMedico = objSC.IdMedico
                    };
                    objAudit = AddAudita(objOrigen, objDestino, DataKey, "L");
                    objAudit.TableName = "VW_ATENCIONPACIENTE_GENERAL";
                    objAudit.Type = "L";
                    objAudit.VistaData = xlmIn;
                    //context.Entry(objAudit).State = EntityState.Added;
                    //context.SaveChanges();
                    return null;
                    //*/
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

         
        private string SerializeArrayList(List<object> objSCList)
        {
            throw new NotImplementedException();
        }
        public int setMantenimiento(VW_ATENCIONPACIENTE objSC)
        {
            try
            {
                /////
                System.Nullable<int> iReturnValue;
                int valorRetorno = 0;
                using (var context = new WEB_ERPSALUDEntities())
                {
                    iReturnValue = context.USP_VW_ATENCIONPACIENTE(
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
                        , objSC.UsuarioModificacion
                        , objSC.FechaModificacion
                        , objSC.IdEspecialidad
                        , objSC.CodigoOA
                        , objSC.FechaOrden
                        , objSC.IdProcedimiento
                        , objSC.IdTipoOrden
                        , objSC.FechaRegistroEpiClinico
                        , objSC.FechaCierreEpiClinico
                        , objSC.TipoPaciente
                        , objSC.Edad
                        , objSC.CodigoHC
                        , objSC.CodigoHCAnterior
                        , objSC.CodigoHCSecundario
                        , objSC.TipoHistoria
                        , objSC.EstadoPaciente
                        , objSC.NumeroFile
                        , objSC.IDPACIENTE_OK
                        , objSC.Persona
                        , objSC.NombreCompleto
                        , objSC.TipoDocumento
                        , objSC.Documento
                        , objSC.EsCliente
                        , objSC.EsProveedor
                        , objSC.EsEmpleado
                        , objSC.EsOtro
                        , objSC.TipoPersona
                        , objSC.FechaNacimiento
                        , objSC.Sexo
                        , objSC.Nacionalidad
                        , objSC.EstadoCivil
                        , objSC.NivelInstruccion
                        , objSC.CodigoPostal
                        , objSC.Provincia
                        , objSC.Departamento
                        , objSC.FecIniDiscamec
                        , objSC.FecFinDiscamec
                        , objSC.Pais
                        , objSC.EsPaciente
                        , objSC.EsEmpresa
                        , objSC.personanew
                        , objSC.EstadoPersona
                        , objSC.Servicio
                        , null
                        , null
                        , objSC.Version
                        , objSC.Accion
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
        /*****GENERAL AUX*****/

        public List<VW_ATENCIONPACIENTE_GENERAL> listarVwAtencionPacienteGeneral(VW_ATENCIONPACIENTE_GENERAL objSC, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                List<VW_ATENCIONPACIENTE_GENERAL> listaGeneral=
                context.USP_SHC_VW_ATENCIONPACIENTE_GENERAL_LISTAR(
                     objSC.NumeroFila
                    , objSC.tipoListado
                    , objSC.CitaTipo
                    , objSC.CitaFecha
                    , objSC.CitaHora
                    , objSC.Origen
                    , objSC.NombreEspecialidad
                    , objSC.TipoPacienteNombre
                    , objSC.CodigoOA
                    , objSC.FechaInicio
                    , objSC.Cama
                    , objSC.TipoOrdenAtencionNombre
                    , objSC.CodigoHC
                    , objSC.CodigoHCAnterior
                    , objSC.PacienteNombre
                    , objSC.MedicoNombre
                    , objSC.IdOrdenAtencion
                    , objSC.LineaOrdenAtencion
                    , objSC.IdHospitalizacion
                    , objSC.LineaHospitalizacion
                    , objSC.IdConsultaExterna
                    , objSC.IdProcedimiento
                    , objSC.Modalidad
                    , objSC.IndicadorSeguro
                    , objSC.IdCita
                    , objSC.IdPaciente
                    , objSC.TipoPaciente
                    , objSC.TipoAtencion
                    , objSC.IdEspecialidad
                    , objSC.IdEmpresaAseguradora
                    , objSC.TipoOrdenAtencion
                    , objSC.Componente
                    , objSC.ComponenteNombre
                    , objSC.Compania
                    , objSC.Sucursal
                    , objSC.IdMedico
                    , objSC.IndicadorCirugia
                    , objSC.IndicadorExamenPrincipal
                    , objSC.PersonaAnt
                    , objSC.sexo
                    , objSC.FechaNacimiento
                    , objSC.EstadoCivil
                    , objSC.NivelInstruccion
                    , objSC.Direccion
                    , objSC.TipoDocumento
                    , objSC.Documento
                    , objSC.ApellidoPaterno
                    , objSC.ApellidoMaterno
                    , objSC.Nombres
                    , objSC.LugarNacimiento
                    , objSC.CodigoPostal
                    , objSC.Provincia
                    , objSC.Departamento
                    , objSC.Telefono
                    , objSC.CorreoElectronico
                    , objSC.EsPaciente
                    , objSC.EsEmpresa
                    , objSC.Pais
                    , objSC.EstadoPersona
                    , objSC.FechaCierreEpiClinico
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
                    , objSC.UsuarioCreacion
                    , objSC.UsuarioModificacion
                    , objSC.FechaCreacion
                    , objSC.FechaModificacion
                    , objSC.Version
                    , objSC.FechaFin
                    , objSC.FechaOrden
                    , ""+objSC.Comentarios
                    , ""+objSC.Observaciones
                    , ""+objSC.Diagnostico
                    , objSC.UnidadReplicacionHCE
                    , objSC.IdPacienteHCE
                    , objSC.EpisodioClinicoHCE
                    , objSC.IdEpisodioAtencionHCE
                    , objSC.SecuenciaHCE
                    , objSC.CodigoEpisodioClinico
                    , objSC.Contador
                    , inicio
                    , final
                    , objSC.Accion
                  
                ).ToList();

                return listaGeneral;
            }
        }
        public int setMantenimientoGeneral(VW_ATENCIONPACIENTE_GENERAL objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new WEB_ERPSALUDEntities())
            {
                /*iReturnValue = context.USP_SHC_VW_ATENCIONPACIENTE_GENERAL(
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
                    , 0
                    , 0
                    , objSC.Accion     
                ).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                 */ 
            }
            return valorRetorno;
        }
        public static string SerializeArrayList(ArrayList ArrayListIn)
        {
            // get a list of all the types in the ArrayList to serialize
            // avoid duplicates
            ArrayList TypesInList = new ArrayList();

            foreach (Object Item in ArrayListIn)
            {
                if (TypesInList.Contains(Item.GetType()) == false)
                    TypesInList.Add(Item.GetType());
            }

            // we're going to add a string array, so add these two types
            if (TypesInList.Contains(typeof(String)) == false)
                TypesInList.Add(typeof(String));
            if (TypesInList.Contains(typeof(String[])) == false)
                TypesInList.Add(typeof(String[]));

            // Convert the list of types to a string array of type names
            // so we can add it to the ArrayList
            String[] TypeNamesArray = new String[TypesInList.Count];

            for (int i = 0; i < TypesInList.Count; i++)
                TypeNamesArray[i] = ((Type)TypesInList[i]).AssemblyQualifiedName;

            // add the array of type names to the ArrayList
            ArrayListIn.Add(TypeNamesArray);

            // The Serialize function require an array of type objects
            Type[] Types = (Type[])TypesInList.ToArray(typeof(Type));

            // create the serializer, give it the ArrayList type and 
            // the array of types in the ArrayList
            XmlSerializer Serializer = new XmlSerializer(typeof(ArrayList), Types);

            // create a stream for the Serializer output
            StringWriter Writer = new StringWriter();

            // Do the Serialization
            Serializer.Serialize(Writer, ArrayListIn);

            String XMLString = Writer.ToString();

            // remove the string array of types we added.
            // we don't want to affect the original list.
            ArrayListIn.RemoveAt(ArrayListIn.Count - 1);
            return XMLString;
        }
 

    }
    
}
