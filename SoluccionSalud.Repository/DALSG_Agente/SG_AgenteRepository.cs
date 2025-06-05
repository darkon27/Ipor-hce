using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALSG_Agente
{
    public class SG_AgenteRepository : AuditGenerico<SG_Agente, SG_Agente>
    {
        public List<SG_Agente> listarSG_Agente(SG_Agente objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SG_Agente> objLista = new List<SG_Agente>();
            if (objSC == null)
            {
                throw new ArgumentNullException("objSC");
            }
            using (var context = new WEB_ERPSALUDEntities())
            {
                //context.Configuration.AutoDetectChangesEnabled = false;
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
                    String xlmIn = XMLString(objLista, new List<SG_Agente>(), "SG_Agente");
                    objAudit = AddAudita(new SG_Agente(), new SG_Agente(), DataKey, "L");
                    objAudit.TableName = "SG_Agente";
                    objAudit.Type = "L";
                    objAudit.Accion = "LISTAR";
                    objAudit.VistaData = xlmIn;
                    context.Entry(objAudit).State = EntityState.Added;
                    context.SaveChanges();
                }
                catch (Exception ex)
                {
                    throw new Exception("Error al listar SG_Agente", ex);
                }
                //context.Configuration.AutoDetectChangesEnabled = true;
            }

            return objLista;
        }

        public int setMantenimiento(SG_Agente objSC)
        {   
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;

            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                context.Configuration.AutoDetectChangesEnabled = false;
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        SG_Agente objAnterior = new SG_Agente();
                        if ((objSC.ACCION.Substring(0, 1) != "I") || (objSC.ACCION.Substring(0, 1) != "N"))
                        {
                            
                            objAnterior = (from t in context.SG_Agente
                                           where t.IdAgente == objSC.IdAgente
                                           orderby t.IdAgente descending
                                           select t).SingleOrDefault();
                        }
                        iReturnValue = context.USP_SS_HC_SG_Agente(
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
                               , objSC.flatUsuGenerico
                               , objSC.TipoTransaccion
                               , objSC.IdOpcionDefecto
                               , objSC.Plataforma
                               , objSC.tipotrabajador
                               , objSC.IdCodigo
                               , objSC.ACCION
                            ).SingleOrDefault();

                        //*  Registra Audit/
                        DataKey = new
                        {
                            IdAgente = objSC.IdAgente,
                            IdGrupo = objSC.IdGrupo
                        };
                        if (objAnterior == null) objAnterior = new SG_Agente();
                        objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.ACCION.Substring(0, 1));
                        objAudit.TableName = "SG_Agente";
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
                context.Configuration.AutoDetectChangesEnabled = true;
            }
            return valorRetorno;
        }

    }
}
