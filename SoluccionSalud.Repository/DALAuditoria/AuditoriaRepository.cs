using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;
using Newtonsoft.Json;

namespace SoluccionSalud.Repository.DALAuditoria
{
    public class AuditoriaRepository : AuditGenerico<SS_HC_AuditRoyal, SS_HC_AuditRoyal>
    {
        public List<SS_HC_AuditRoyal> listarAuditoRoyal(SS_HC_AuditRoyal objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_AuditRoyal> objLista = new List<SS_HC_AuditRoyal>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_SS_HC_AUDITROYAL_LISTAR(objSC.AuditID,
                    objSC.HostName, objSC.Aplicacion, objSC.Modulo,
                    objSC.Usuario, objSC.Type, objSC.TableName,
                    objSC.TableIdValue, objSC.PrimaryKeyData,
                    objSC.OldData, objSC.NewData,
                    objSC.UpdateDate, objSC.VistaData, objSC.Accion, objSC.Version
                    , inicio
                    , final).ToList();


                DataKey = new
                {
                    AuditID = objSC.AuditID
                };
                // Audit

                //String xlmIn = XMLString(objLista, new List<SS_HC_AuditRoyal>(), "SS_HC_AuditRoyal");
                String xlmIn = JsonConvert.SerializeObject(objLista);  // 2018/01/09 ---Jordan Mateo
                objAudit = AddAudita(new SS_HC_AuditRoyal(), objSC, DataKey, "L");
                objAudit.TableName = "SS_HC_AuditRoyal";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();

            }

            return objLista;
        }
        public int setMantenimiento(SS_HC_AuditRoyal objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_SS_HC_AUDITROYAL(
                    objSC.AuditID,
                    objSC.HostName, objSC.Aplicacion, objSC.Modulo,
                    objSC.Usuario, objSC.Type, objSC.TableName,
                    objSC.TableIdValue, objSC.PrimaryKeyData,
                    objSC.OldData, objSC.NewData,
                    objSC.UpdateDate, objSC.VistaData, objSC.Accion, objSC.Version).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
        public void Save_ChangesTraking(SS_HC_AuditRoyal objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_SS_HC_AUDITROYAL(
                    objSC.AuditID,
                    objSC.HostName, objSC.Aplicacion, objSC.Modulo,
                    objSC.Usuario, objSC.Type, objSC.TableName,
                    objSC.TableIdValue, objSC.PrimaryKeyData,
                    objSC.OldData, objSC.NewData,
                    objSC.UpdateDate, objSC.VistaData, objSC.Accion, objSC.Version).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            // return valorRetorno;
        }
    }
}
