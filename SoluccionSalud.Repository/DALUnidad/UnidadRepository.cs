using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALUnidad
{
    public class UnidadRepository : AuditGenerico<UnidadesMast, UnidadesMast> 
    {
        public List<UnidadesMast> listarUnidad(UnidadesMast objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<UnidadesMast> objLista = new List<UnidadesMast>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista =  context.USP_HC_UnidadesMastListar(objSC.UnidadCodigo, objSC.DescripcionCorta, objSC.DescripcionExtranjera,
                    objSC.UnidadTipo, objSC.NumeroDecimales, objSC.Estado, objSC.UltimaFechaModif,
                    objSC.UltimoUsuario, objSC.IdUnidadMedida, objSC.IndicadorMedidaBase, objSC.FactorConversion, 
                    objSC.UsuarioCreacion,objSC.FechaCreacion, objSC.indAfectocalculocantidad, objSC.CodigoFiscal, objSC.ACCION, inicio, final
                   ).ToList();

                DataKey = new
                {
                    UnidadCodigo = objSC.UnidadCodigo                    
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<UnidadesMast>(), "UnidadesMast");
                objAudit = AddAudita(new UnidadesMast(), new UnidadesMast(), DataKey, "L");
                objAudit.TableName = "UnidadesMast";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
            }
   
            return objLista;
        }
        public int setMantenimiento(UnidadesMast objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_HC_UnidadesMast(objSC.UnidadCodigo, objSC.DescripcionCorta, objSC.DescripcionExtranjera,
                    objSC.UnidadTipo, objSC.NumeroDecimales, objSC.Estado, objSC.UltimaFechaModif,
                    objSC.UltimoUsuario, objSC.IdUnidadMedida, objSC.IndicadorMedidaBase, objSC.FactorConversion,
                    objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.indAfectocalculocantidad, objSC.CodigoFiscal, objSC.ACCION).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
