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
using System.Data.Entity; //Entity Framework
using System.Xml;
using System.Xml.Serialization;
using SoluccionSalud.Repository.Repository;
using Newtonsoft.Json;
using System.Data.Entity.Validation;

namespace SoluccionSalud.RepositoryFormulario.DAL_Formularios
{
    public class OrdenIntervencionQuirurgica_FERepository
    {

        Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();  //Agregado auditoria --> N° 1


        public List<SS_HC_OrdenIntervencionQuirurgicaCab_FE> listarEntidad(SS_HC_OrdenIntervencionQuirurgicaCab_FE ObjTrace)
        {
            try
            {
                List<SS_HC_OrdenIntervencionQuirurgicaCab_FE> objLista = new List<SS_HC_OrdenIntervencionQuirurgicaCab_FE>();
                using (var context = new ModelFormularios())
                {
                    objLista = context.USP_OrdenInterQuirurgicaListarFE(
                                ObjTrace.UnidadReplicacion,
                                ObjTrace.IdEpisodioAtencion,
                                ObjTrace.IdPaciente,
                                ObjTrace.EpisodioClinico,
                                ObjTrace.IdCirugia,
                                ObjTrace.UsuarioCreacion,
                                ObjTrace.FechaCreacion,
                                ObjTrace.UsuarioModificacion,
                                ObjTrace.FechaModificacion,
                                ObjTrace.Version,
                                ObjTrace.Accion
                            ).ToList();

                    //Agregado auditoria --> N° 2
                    //using (var contextEnty = new WEB_ERPSALUDEntities())
                    //{
                    //    SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                    //    List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                    //    dynamic DataKey;
                    //    DataKey = new
                    //    {
                    //        UnidadReplicacion = ObjTrace.UnidadReplicacion,
                    //        IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                    //        EpisodioClinico = ObjTrace.EpisodioClinico,
                    //        IdPaciente = ObjTrace.IdPaciente
                    //    };

                    //    if (objLista.Count > 1)
                    //    {
                    //        objAudit.Type = "L";
                    //    }
                    //    else
                    //    {
                    //        objAudit.Type = "V";
                    //    }
                    //    string tempType = objAudit.Type;
                    //    objAudit = Control.AddAudita(new SS_HC_OrdenIntervencionQuirurgicaCab_FE(), new SS_HC_OrdenIntervencionQuirurgicaCab_FE(), DataKey, objAudit.Type);
                    //    String xlmIn = XMLString(objLista, "SS_HC_OrdenIntervencionQuirurgicaCab_FE");
                    //    objAudit.TableName = "SS_HC_AntePerGinecoObstetricos_FE";
                    //    objAudit.Type = tempType;
                    //    objAudit.VistaData = xlmIn;
                    //    objAudit.Accion = ObjTrace.Accion;
                    //    contextEnty.Entry(objAudit).State = EntityState.Added;
                    //    contextEnty.SaveChanges();
                    //}
                    //--
                }

                return objLista;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<SS_HC_OrdenIntervencionQuirurgicaCab_FE> listarOrdenIntervencion(SS_HC_OrdenIntervencionQuirurgicaCab_FE entidad)
        {
            try
            {
                List<SS_HC_OrdenIntervencionQuirurgicaCab_FE> objLista = new List<SS_HC_OrdenIntervencionQuirurgicaCab_FE>();
                using (var context = new ModelFormularios())
                {
                    // Ajusta las condiciones según tu necesidad.
                    var sqlSelect = @"
                        SELECT * FROM SS_HC_OrdenIntervencionQuirurgicaCab_FE 
                        WHERE IdPaciente = @IdPaciente AND UnidadReplicacion = @UnidadReplicacion 
                                AND EpisodioClinico = @EpisodioClinico AND IdEpisodioAtencion = @IdEpisodioAtencion";

                    // Parámetros
                    var parameters = new[]
                        {
                            new SqlParameter("@UnidadReplicacion", entidad.UnidadReplicacion ?? (object)DBNull.Value),
                            new SqlParameter("@IdEpisodioAtencion", entidad.IdEpisodioAtencion != 0 ? (object)entidad.IdEpisodioAtencion : DBNull.Value),
                            new SqlParameter("@IdPaciente", entidad.IdPaciente != 0 ? (object)entidad.IdPaciente : DBNull.Value),
                            new SqlParameter("@EpisodioClinico", entidad.EpisodioClinico != 0? (object)entidad.EpisodioClinico : DBNull.Value)
                       };
                    // Ejecutar consulta y mapear resultados
                    var vLista = context.Database.SqlQuery<SS_HC_OrdenIntervencionQuirurgicaCab_FE>(sqlSelect, parameters).ToList();

                    objLista = vLista;
                }
                return objLista;
            }
            catch (Exception ex)
            {
                throw ex; // Considera usar "throw;" para no perder el stack trace original.
            }
        }



        public int SetMantenimientoActualizado(SS_HC_OrdenIntervencionQuirurgicaCab_FE objSC,
                    List<SS_HC_OrdenInterQuiruDiagnosticoDetalle_FE> detalleDiagnostico,
                    List<SS_HC_OrdenInterQuiruExamenApoyoDetalle_FE> detalleCirugiaProcedimiento,
                    List<SS_HC_OrdenInterQuiruExamenApoyoDetalle_FE> detalleExamenes,
                    List<SS_HC_OrdenInterQuiruExamenApoyoDetalle_FE> detalleUsoEquipos,
                    List<SS_HC_OrdenInterQuiruExamenApoyoDetalle_FE> detalleMateriales,
                    string tiempo, string fechaIntervencion)
        {
            int valorRetorno = -1;
            string msj = "";
            using (var context = new ModelFormularios())
            {
                using (var transaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        // Operación de cabecera
                        ProcesarCabecera(context, objSC);

                        // Obtener el valor máximo de la secuencia desde el contexto
                        int secuenciaMax = context.SS_HC_OrdenInterQuiruDiagnosticoDetalle_FE
                       .Where(t =>
                               t.IdPaciente == objSC.IdPaciente
                               && t.UnidadReplicacion == objSC.UnidadReplicacion
                               && t.EpisodioClinico == objSC.EpisodioClinico
                               && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                       ).DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

                        // Inicializar contador para las nuevas secuencias
                        int contadorDet = 0;

                        foreach (SS_HC_OrdenInterQuiruDiagnosticoDetalle_FE objDiag in detalleDiagnostico)
                        {
                            // Manejar el estado según la propiedad "Accion"
                            var accion = objDiag.Accion.ToString();

                            if (accion == "DETALLE")
                            {
                                // Incrementar el contador de secuencia
                                contadorDet++;
                                // Asignar la secuencia si la propiedad existe
                                var secuenciaProperty = objDiag.Secuencia;
                                if (secuenciaProperty != null)
                                {
                                    objDiag.Secuencia = secuenciaMax + contadorDet;
                                }
                            }

                            var entry = context.Entry(objDiag);
                            if (accion == "DETALLE")
                            {
                                entry.State = EntityState.Added;
                            }
                            else if (accion == "UPDATEDETALLE")
                            {
                                entry.State = EntityState.Modified;
                            }
                            else if (accion == "DELETEDETALLE")
                            {
                                entry.State = EntityState.Deleted;
                            }
                        }

                        List<SS_HC_OrdenInterQuiruExamenApoyoDetalle_FE> detalle = new List<SS_HC_OrdenInterQuiruExamenApoyoDetalle_FE>();
                        if (detalleExamenes.Count > 0)
                        {
                            foreach (var Enty in detalleExamenes)
                            {
                                detalle.Add(Enty);
                            }
                        }
                        if (detalleUsoEquipos.Count > 0)
                        {
                            foreach (var Enty in detalleUsoEquipos)
                            {
                                detalle.Add(Enty);
                            }
                        }
                        if (detalleMateriales.Count > 0)
                        {
                            foreach (var Enty in detalleMateriales)
                            {
                                detalle.Add(Enty);
                            }
                        }
                        if (detalleCirugiaProcedimiento.Count > 0)
                        {
                            foreach (var Enty in detalleCirugiaProcedimiento)
                            {
                                detalle.Add(Enty);
                            }
                        }

                        if (detalle.Count > 0)
                        {
                            ProcesarDetalles(context, objSC, detalle, 2);
                        }

                        context.SaveChanges();
                        transaction.Commit();
                        valorRetorno = 1; // Éxito
                    }
                    catch (DbEntityValidationException ex)
                    {
                        foreach (var validationError in ex.EntityValidationErrors)
                        {
                            Console.WriteLine("Entity: " + validationError.Entry.Entity.GetType().Name);
                            foreach (var error in validationError.ValidationErrors)
                            {
                                msj += error.PropertyName + ": " + error.ErrorMessage + " | ";
                                Console.WriteLine(error.PropertyName + " : " + error.ErrorMessage);
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine("Error: " + ex.Message);
                        if (ex.InnerException != null)
                        {
                            msj += "Inner Exception: " + ex.InnerException.Message + "| ";
                            Console.WriteLine("Inner Exception: " + ex.InnerException.Message);
                        }
                        //throw;
                    }
                }
            }
            var leermsj = msj;
            return valorRetorno;
        }

        private void ProcesarCabecera(ModelFormularios context, SS_HC_OrdenIntervencionQuirurgicaCab_FE objSC)
        {
            if (objSC.Accion.Substring(0, 1) == "N") // Insertar
            {
                var sqlInsert = @"INSERT INTO SS_HC_OrdenIntervencionQuirurgicaCab_FE 
                            (UnidadReplicacion, IdEpisodioAtencion, IdPaciente, EpisodioClinico, IdCirugia, 
                            CirugiaCompleja, DuracionAprox, TipoDeHospitalizacion, DiasAproximados, TipoAnastesia, 
                            NumeroAyudantes, NumeroInstrumentos, EquipoHumano, Comentario, Estado, UsuarioCreacion, 
                            FechaCreacion, UsuarioModificacion, FechaModificacion, Accion, Version, OrdIntNinguna, 
                            OrdIntOtro, OrdAnastesiologo, TiempoEnfermedad, FechaIntervencion,flagHospitalaria,
                            diaHospitalaria, flagUCI, diaUCI, flagUCIN, diaUCIN, flagAmbulatorio, diaAmbulatorio)
                          VALUES
                            (@UnidadReplicacion, @IdEpisodioAtencion, @IdPaciente, @EpisodioClinico, @IdCirugia, 
                            @CirugiaCompleja, @DuracionAprox, @TipoDeHospitalizacion, @DiasAproximados, @TipoAnastesia, 
                            @NumeroAyudantes, @NumeroInstrumentos, @EquipoHumano, @Comentario, @Estado, 
                            @UsuarioCreacion, @FechaCreacion, @UsuarioModificacion, @FechaModificacion, 
                            @Accion, @Version, @OrdIntNinguna, @OrdIntOtro, @OrdAnastesiologo, @TiempoEnfermedad, 
                            @FechaIntervencion, @flagHospitalaria, @diaHospitalaria, 
                           @flagUCI, @diaUCI, @flagUCIN, @diaUCIN, @flagAmbulatorio, @diaAmbulatorio)";
                context.Database.ExecuteSqlCommand(sqlInsert, GetParameters(objSC));
            }
            else if (objSC.Accion.Substring(0, 1) == "U") // Actualizar
            {
                var sqlUpdate = @"UPDATE SS_HC_OrdenIntervencionQuirurgicaCab_FE 
                          SET CirugiaCompleja = @CirugiaCompleja, DuracionAprox = @DuracionAprox, 
                              TipoDeHospitalizacion = @TipoDeHospitalizacion, DiasAproximados = @DiasAproximados, 
                              TipoAnastesia = @TipoAnastesia, NumeroAyudantes = @NumeroAyudantes, 
                              NumeroInstrumentos = @NumeroInstrumentos, EquipoHumano = @EquipoHumano, 
                              Comentario = @Comentario, Estado = @Estado, UsuarioModificacion = @UsuarioModificacion, 
                              FechaModificacion = @FechaModificacion, Version = @Version, OrdIntNinguna = @OrdIntNinguna, 
                              OrdIntOtro = @OrdIntOtro, OrdAnastesiologo = @OrdAnastesiologo, 
                              TiempoEnfermedad = @TiempoEnfermedad, FechaIntervencion = @FechaIntervencion, 
                              flagHospitalaria = @flagHospitalaria, diaHospitalaria = @diaHospitalaria,
                              flagUCI = @flagUCI, diaUCI = @diaUCI, flagUCIN = @flagUCIN, diaUCIN= @diaUCIN,
                              flagAmbulatorio =  @flagAmbulatorio, diaAmbulatorio = @diaAmbulatorio
                          WHERE IdPaciente = @IdPaciente AND UnidadReplicacion = @UnidadReplicacion 
                                AND EpisodioClinico = @EpisodioClinico AND IdEpisodioAtencion = @IdEpisodioAtencion";
                context.Database.ExecuteSqlCommand(sqlUpdate, GetParameters(objSC));
            }
            else
            {
                throw new InvalidOperationException("Acción no reconocida: use 'I' para Insertar o 'U' para Actualizar.");
            }
        }

        private void ProcesarDetalles<T>(ModelFormularios context, SS_HC_OrdenIntervencionQuirurgicaCab_FE objSC, List<T> detalles, int valor) where T : class
        {
            if (detalles == null || !detalles.Any())
                return;

            // Obtener el valor máximo de la secuencia desde el contexto
            int secuenciaMax = ObtenerSecuenciaMaxima<T>(context, objSC, valor);

            // Inicializar contador para las nuevas secuencias
            int contadorDet = 0;

            foreach (var detalle in detalles)
            {
                // Manejar el estado según la propiedad "Accion"
                var accion = detalle.GetType().GetProperty("Accion").GetValue(detalle).ToString();

                if (accion == "DETALLE")
                {
                    // Incrementar el contador de secuencia
                    contadorDet++;
                    // Asignar la secuencia si la propiedad existe
                    var secuenciaProperty = detalle.GetType().GetProperty("Secuencia");
                    if (secuenciaProperty != null)
                    {
                        secuenciaProperty.SetValue(detalle, secuenciaMax + contadorDet);
                    }
                }

                var entry = context.Entry(detalle);
                if (accion == "DETALLE")
                {
                    entry.State = EntityState.Added;
                }
                else if (accion == "UPDATEDETALLE")
                {
                    entry.State = EntityState.Modified;
                }
                else if (accion == "DELETEDETALLE")
                {
                    entry.State = EntityState.Deleted;
                }
            }
        }

        // Método para obtener el valor máximo de la secuencia
        private int ObtenerSecuenciaMaxima<T>(ModelFormularios context, SS_HC_OrdenIntervencionQuirurgicaCab_FE objSC, int valor) where T : class
        {
            var maxValue = 0;
            /**obtener la última secuencia*/
            if (valor == 1)
            {
                maxValue = context.SS_HC_OrdenInterQuiruDiagnosticoDetalle_FE
                       .Where(t =>
                               t.IdPaciente == objSC.IdPaciente
                               && t.UnidadReplicacion == objSC.UnidadReplicacion
                               && t.EpisodioClinico == objSC.EpisodioClinico
                               && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                       ).DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);
            }
            if (valor == 2)
            {
                maxValue = context.SS_HC_OrdenInterQuiruExamenApoyoDetalle_FE
                       .Where(t =>
                               t.IdPaciente == objSC.IdPaciente
                               && t.UnidadReplicacion == objSC.UnidadReplicacion
                               && t.EpisodioClinico == objSC.EpisodioClinico
                               && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                       ).DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);
            }

            return maxValue; // Si no hay valores, devolver 0
        }

        private SqlParameter[] GetParameters(SS_HC_OrdenIntervencionQuirurgicaCab_FE entidad)
        {
            return new[]
                {
                    new SqlParameter("@UnidadReplicacion", entidad.UnidadReplicacion ?? (object)DBNull.Value),
                    new SqlParameter("@IdEpisodioAtencion", entidad.IdEpisodioAtencion != 0 ? (object)entidad.IdEpisodioAtencion : DBNull.Value),
                    new SqlParameter("@IdPaciente", entidad.IdPaciente != 0 ? (object)entidad.IdPaciente : DBNull.Value),
                    new SqlParameter("@EpisodioClinico", entidad.EpisodioClinico != 0? (object)entidad.EpisodioClinico : DBNull.Value),
                    new SqlParameter("@IdCirugia", entidad.IdCirugia ?? (object)DBNull.Value),
                    new SqlParameter("@CirugiaCompleja", entidad.CirugiaCompleja ?? (object)DBNull.Value),
                    new SqlParameter("@DuracionAprox", entidad.DuracionAprox ?? (object)DBNull.Value),
                    new SqlParameter("@TipoDeHospitalizacion", entidad.TipoDeHospitalizacion ?? (object)DBNull.Value),
                    new SqlParameter("@DiasAproximados", entidad.DiasAproximados ?? (object)DBNull.Value),
                    new SqlParameter("@TipoAnastesia", entidad.TipoAnastesia ?? (object)DBNull.Value),
                    new SqlParameter("@NumeroAyudantes", entidad.NumeroAyudantes ?? (object)DBNull.Value),
                    new SqlParameter("@NumeroInstrumentos", entidad.NumeroInstrumentos ?? (object)DBNull.Value),
                    new SqlParameter("@EquipoHumano", entidad.EquipoHumano ?? (object)DBNull.Value),
                    new SqlParameter("@Comentario", entidad.Comentario ?? (object)DBNull.Value),  
                    new SqlParameter("@OrdIntNinguna", entidad.OrdIntNinguna ?? (object)DBNull.Value),
                    new SqlParameter("@OrdIntOtro", entidad.OrdIntOtro ?? (object)DBNull.Value),
                    new SqlParameter("@OrdAnastesiologo", entidad.OrdAnastesiologo ?? (object)DBNull.Value),
                    new SqlParameter("@TiempoEnfermedad", entidad.TiempoEnfermedad ?? (object)DBNull.Value),
                    new SqlParameter("@FechaIntervencion", entidad.FechaIntervencion ?? (object)DBNull.Value),                    
                    new SqlParameter("@Estado", entidad.Estado ?? (object)DBNull.Value),
                    new SqlParameter("@UsuarioCreacion", entidad.UsuarioCreacion ?? (object)DBNull.Value),
                    new SqlParameter("@FechaCreacion", entidad.FechaCreacion ?? (object)DBNull.Value),
                    new SqlParameter("@UsuarioModificacion", entidad.UsuarioModificacion ?? (object)DBNull.Value),
                    new SqlParameter("@FechaModificacion", entidad.FechaModificacion ?? (object)DBNull.Value),
                    new SqlParameter("@Accion", entidad.Accion ?? (object)DBNull.Value),
                    new SqlParameter("@Version", entidad.Version ?? (object)DBNull.Value),
                    new SqlParameter("@flagHospitalaria", entidad.flagHospitalaria ?? (object)DBNull.Value),
                    new SqlParameter("@diaHospitalaria", entidad.diaHospitalaria ?? (object)DBNull.Value),
                    new SqlParameter("@flagUCI", entidad.flagUCI ?? (object)DBNull.Value),
                    new SqlParameter("@diaUCI", entidad.diaUCI ?? (object)DBNull.Value),
                    new SqlParameter("@flagUCIN", entidad.flagUCIN ?? (object)DBNull.Value),
                    new SqlParameter("@diaUCIN", entidad.diaUCIN ?? (object)DBNull.Value),
                    new SqlParameter("@flagAmbulatorio", entidad.flagAmbulatorio ?? (object)DBNull.Value),
                    new SqlParameter("@diaAmbulatorio", entidad.diaAmbulatorio ?? (object)DBNull.Value)
                    // Agrega más propiedades si es necesario
                };
        }

        //Agregado auditoria --> N° 4
        public virtual String XMLString(List<SS_HC_OrdenIntervencionQuirurgicaCab_FE> obPadre, String TablaID)
        {
            string jsons = JsonConvert.SerializeObject(new[] { obPadre }, Newtonsoft.Json.Formatting.Indented);
            jsons = jsons.Trim().Substring(1, jsons.Length - 2);
            char coma = '"';
            string json = @"{ " + coma + "TRACKING_CHE" + coma + " : { ";
            string str1 = ": []";
            string str1_1 = ": null";
            jsons = jsons.Replace(str1, str1_1);
            var xmlDocument = new XmlDocument();
            var d = xmlDocument.CreateXmlDeclaration("1.0", "utf-16", "yes");
            xmlDocument.AppendChild(d);
            if (obPadre.Count == 0)
            {
                jsons = json + TablaID + "" + ": {" + coma + "Estado" + coma + ":" + coma + "No hay información" + coma + " }" + "} }";
            }
            else
            {
                jsons = json + TablaID + "" + ":" + jsons + "} }";

            }
            var xml = JsonConvert.DeserializeXmlNode(jsons);
            var root = xmlDocument.ImportNode(xml.DocumentElement, true);
            xmlDocument.AppendChild(root);
            return xmlDocument.OuterXml.ToString();
        }



    }
}
