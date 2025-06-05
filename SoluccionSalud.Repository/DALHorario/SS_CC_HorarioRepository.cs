using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Model;
using System.Data.Entity;


namespace SoluccionSalud.Repository.DALHorario
{
    public class SS_CC_HorarioRepository : AuditGenerico<SS_CC_Horario, SS_CC_Horario> 
    {
        public List<SS_CC_Horario> listarSS_CC_Horario(SS_CC_Horario objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_CC_Horario> objLista = new List<SS_CC_Horario>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_SS_CC_Horario_LISTAR(
                    objSC.IdHorario
                    ,objSC.IdServicio
                    ,objSC.Medico
                    ,objSC.IdEspecialidad
                    ,objSC.IdConsultorio
                    ,objSC.Periodo
                    ,objSC.IdTurno
                    ,objSC.FechaInicio
                    ,objSC.FechaFin
                    ,objSC.HoraInicio
                    ,objSC.HoraFin
                    ,objSC.FechaInicioHorario
                    ,objSC.FechaFinHorario
                    ,objSC.TipoUso
                    ,objSC.IndicadorLunes
                    ,objSC.IndicadorMartes
                    ,objSC.IndicadorMiercoles
                    ,objSC.IndicadorJueves
                    ,objSC.IndicadorViernes
                    ,objSC.IndicadorSabado
                    ,objSC.IndicadorDomingo
                    ,objSC.TipoGeneracionCita
                    ,objSC.TiempoPromedioAtencion
                    ,objSC.Estado
                    ,objSC.UsuarioCreacion
                    ,objSC.FechaCreacion
                    ,objSC.UsuarioModificacion
                    ,objSC.FechaModificacion
                    ,objSC.TipoRegistroHorario
                    ,objSC.IndicadorCompartido
                    ,objSC.IdGrupoAtencionCompartido
                    ,objSC.IdInasistencia
                    ,objSC.IndicadorCitaMultiple
                    ,objSC.IndicadorAplicaAdicional
                    ,objSC.CantidadCitasAdicional
                    ,objSC.UnidadReplicacion                   
                    , inicio
                    , final
                     ,objSC.ACCION
                    ).ToList();

                DataKey = new
                {
                    IdHorario = objSC.IdHorario
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<SS_CC_Horario>(), "SS_CC_Horario");
                objAudit = AddAudita(new SS_CC_Horario(), objSC, DataKey, "L");
                objAudit.TableName = "SS_CC_Horario";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();

            }

            return objLista;
        }

        public int setMantenimiento(SS_CC_Horario objSC)
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
                        SS_CC_Horario objAnterior = new SS_CC_Horario();
                        if ((objSC.ACCION.Substring(0, 1) != "I") || (objSC.ACCION.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_CC_Horario
                                           where t.IdHorario == objSC.IdHorario
                                           orderby t.IdHorario descending
                                           select t).SingleOrDefault();
                        }
                        iReturnValue = context.USP_SS_CC_Horario(
                                objSC.IdHorario
                                , objSC.IdServicio
                                , objSC.Medico
                                , objSC.IdEspecialidad
                                , objSC.IdConsultorio
                                , objSC.Periodo
                                , objSC.IdTurno
                                , objSC.FechaInicio
                                , objSC.FechaFin
                                , objSC.HoraInicio
                                , objSC.HoraFin
                                , objSC.FechaInicioHorario
                                , objSC.FechaFinHorario
                                , objSC.TipoUso
                                , objSC.IndicadorLunes
                                , objSC.IndicadorMartes
                                , objSC.IndicadorMiercoles
                                , objSC.IndicadorJueves
                                , objSC.IndicadorViernes
                                , objSC.IndicadorSabado
                                , objSC.IndicadorDomingo
                                , objSC.TipoGeneracionCita
                                , objSC.TiempoPromedioAtencion
                                , objSC.Estado
                                , objSC.UsuarioCreacion
                                , objSC.FechaCreacion
                                , objSC.UsuarioModificacion
                                , objSC.FechaModificacion
                                , objSC.TipoRegistroHorario
                                , objSC.IndicadorCompartido
                                , objSC.IdGrupoAtencionCompartido
                                , objSC.IdInasistencia
                                , objSC.IndicadorCitaMultiple
                                , objSC.IndicadorAplicaAdicional
                                , objSC.CantidadCitasAdicional
                                , objSC.UnidadReplicacion                                                                
                                 , objSC.ACCION                        
                            ).SingleOrDefault();

                        //*  Registra Audit/
                        DataKey = new
                        {
                            IdHorario = objSC.IdHorario
                        };
                        if (objAnterior == null) objAnterior = new SS_CC_Horario();
                        objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.ACCION.Substring(0, 1));
                        objAudit.TableName = "SS_CC_Horario";
                        objAudit.Type = objSC.ACCION.Substring(0, 1);
                        if (((objAudit.OldData.Trim().Length != 0) || (objAudit.NewData.Trim().Length != 0)) || (objAudit.Type == "D"))
                        {
                            if (objAudit.Type != "L")
                            {
                                context.Entry(objAudit).State = EntityState.Added;
                                context.SaveChanges();
                            }
                        }

                        //*/
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
    }
}
