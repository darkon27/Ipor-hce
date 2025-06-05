using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Repository.DALFormularios
{
    public class ProblemasRepository : AuditGenerico<SS_HC_Problema, SS_HC_Problema> 
    {
        public int setMantenimiento(SS_HC_Problema ObjTrace)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();

            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new WEB_ERPSALUDEntities())
            {
                try
                {
                    var InformacionObj = (from t in context.SS_HC_Problema
                                          where t.IdPaciente == ObjTrace.IdPaciente
                                          && t.EpisodioClinico == ObjTrace.EpisodioClinico
                                          && t.IdEpisodioAtencion == ObjTrace.IdEpisodioAtencion
                                          && t.TipoProblema == ObjTrace.TipoProblema
                                          && t.Secuencia == ObjTrace.Secuencia
                                          orderby t.IdEpisodioAtencion descending
                                          select t).SingleOrDefault();
                    if (InformacionObj == null) InformacionObj = new SS_HC_Problema();

                    iReturnValue = context.USP_Problema(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente,
                    ObjTrace.EpisodioClinico, ObjTrace.TipoProblema, ObjTrace.IdTipoProblemaDiag, ObjTrace.Secuencia, ObjTrace.Fecha, ObjTrace.IdDiagnostico,
                    ObjTrace.Observacion, ObjTrace.IdControlado, ObjTrace.Estado, ObjTrace.UsuarioCreacion,
                    ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion, ObjTrace.Accion,
                    ObjTrace.Version).SingleOrDefault();
                    valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                    
                    DataKey = new
                    {
                        UnidadReplicacion = ObjTrace.UnidadReplicacion,
                        IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                        EpisodioClinico = ObjTrace.EpisodioClinico,
                        IdPaciente = ObjTrace.IdPaciente,
                        TipoProblema = ObjTrace.TipoProblema,
                        Secuencia = ObjTrace.Secuencia
                    };
                    // Audit

                    objAudit = AddAudita(InformacionObj, ObjTrace, DataKey, ObjTrace.Accion.Substring(0, 1));
                    objAudit.TableName = "SS_HC_Problema";
                    objAudit.Type = ObjTrace.Accion.Substring(0, 1);
                    context.Entry(objAudit).State = EntityState.Added;
                    context.SaveChanges();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return valorRetorno;
        }
        public List<SS_HC_Problema> ProblemasListar(SS_HC_Problema ObjTrace)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;
            List<SS_HC_Problema> objLista = new List<SS_HC_Problema>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_ProblemaListar(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente,
                    ObjTrace.EpisodioClinico, ObjTrace.TipoProblema, ObjTrace.IdTipoProblemaDiag, ObjTrace.Secuencia, ObjTrace.Fecha, ObjTrace.IdDiagnostico,
                    ObjTrace.Observacion, ObjTrace.IdControlado, ObjTrace.Estado, ObjTrace.UsuarioCreacion,
                    ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion, ObjTrace.Accion,
                    ObjTrace.Version).ToList();

                DataKey = new
                {
                    UnidadReplicacion = ObjTrace.UnidadReplicacion,
                    IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                    EpisodioClinico = ObjTrace.EpisodioClinico,
                    IdPaciente = ObjTrace.IdPaciente,
                    TipoProblema = ObjTrace.TipoProblema,
                    Secuencia = ObjTrace.Secuencia
                };

                objAudit.Type = "V";
                if (objLista.Count > 1) objAudit.Type = "L";
                string tempType = objAudit.Type;
                objAudit = AddAudita(new SS_HC_Problema(), new SS_HC_Problema(), DataKey, objAudit.Type);
                String xlmIn = XMLString(objLista, new List<SS_HC_Problema>(), "SS_HC_Problema");
                objAudit.TableName = "SS_HC_Problema";
                objAudit.Type = tempType;
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
            }
            return objLista;

        }
    }
}
