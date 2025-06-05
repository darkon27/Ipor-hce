using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALVW_ServicioPrestacion
{
    public class VW_ServicioPrestacionRepository : AuditGenerico<VW_ServicioPrestacion, VW_ServicioPrestacion> 
    {
        public List<VW_ServicioPrestacion> listarVW_ServicioPrestacion(VW_ServicioPrestacion objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<VW_ServicioPrestacion> objLista = new List<VW_ServicioPrestacion>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista= context.USP_SS_VW_ServicioPrestacionListar(
                         objSC.Componente
                        , objSC.ValorMedida
                        , objSC.CantidadAsistentes
                        , objSC.Instrumentistas
                        , objSC.DiasHospitalizacion
                        , objSC.CodigoSegus
                        , objSC.CodigoNuevo
                        , objSC.Estado
                        , objSC.Nombre
                        , objSC.Descripcion
                        , objSC.Compania
                        , objSC.CentroCosto
                        , objSC.ClasificadorMovimiento
                        , objSC.ConceptoGasto
                        , objSC.IndicadorImpuesto
                        , objSC.IdClasificacion
                        , objSC.CodClasificacion
                        , objSC.NomClasificacion
                        , objSC.Orden
                        , objSC.TipoPrestacion
                        , objSC.IndicadorCita
                        , objSC.IndicadorHC
                        , objSC.CadenaRecursividad
                        , objSC.IndicadorPrestacionPrincipal
                        , objSC.IndicadorRequierePersonal
                        , objSC.IdServicio
                        , objSC.IdGrupoAtencion
                        , objSC.Codigo
                        , objSC.TipoOrdenAtencion
                        , objSC.ACCION
                    , inicio, final
                    ).ToList();

                DataKey = new
                {
                    Componente = objSC.Componente
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<VW_ServicioPrestacion>(), "VW_ServicioPrestacion");
                objAudit = AddAudita(new VW_ServicioPrestacion(), new VW_ServicioPrestacion(), DataKey, "L");
                objAudit.TableName = "VW_ServicioPrestacion";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
            }
            return objLista;
        }

        public int setMantenimiento(VW_ServicioPrestacion objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_SS_VW_ServicioPrestacion(
                        objSC.Componente
                        , objSC.ValorMedida
                        , objSC.CantidadAsistentes
                        , objSC.Instrumentistas
                        , objSC.DiasHospitalizacion
                        , objSC.CodigoSegus
                        , objSC.CodigoNuevo
                        , objSC.Estado
                        , objSC.Nombre
                        , objSC.Descripcion
                        , objSC.Compania
                        , objSC.CentroCosto
                        , objSC.ClasificadorMovimiento
                        , objSC.ConceptoGasto
                        , objSC.IndicadorImpuesto
                        , objSC.IdClasificacion
                        , objSC.CodClasificacion
                        , objSC.NomClasificacion
                        , objSC.Orden
                        , objSC.TipoPrestacion
                        , objSC.IndicadorCita
                        , objSC.IndicadorHC
                        , objSC.CadenaRecursividad
                        , objSC.IndicadorPrestacionPrincipal
                        , objSC.IndicadorRequierePersonal
                        , objSC.IdServicio
                        , objSC.IdGrupoAtencion
                        , objSC.Codigo
                        , objSC.TipoOrdenAtencion
                        , objSC.ACCION

                     ).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
