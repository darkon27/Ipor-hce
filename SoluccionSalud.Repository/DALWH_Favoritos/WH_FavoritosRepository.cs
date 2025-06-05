using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALWH_Favoritos
{
    public class WH_FavoritosRepository : AuditGenerico<vw_favoritos, vw_favoritos> 
    {
        public List<vw_favoritos> listarvw_favoritos(vw_favoritos objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<vw_favoritos> objLista = new List<vw_favoritos>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.usp_vw_favoritos_listar(
                objSC.IdFavorito,
                objSC.NumeroFavorito,
                objSC.Mnemotecnico,
                objSC.Descripcion,
                objSC.DescripcionExtranjera,
                objSC.IdAgente,
                objSC.IdFavoritoTabla,
                objSC.Estado,
                objSC.Accion, objSC.Version, objSC.NombreTabla, objSC.DescripTabla, objSC.CodigoAgente,
                objSC.Nombre, objSC.TipoFavorito, inicio, final
                    ).ToList();

                DataKey = new
                {
                    IdFavorito = objSC.IdFavorito,
                    NumeroFavorito = objSC.NumeroFavorito
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<vw_favoritos>(), "vw_favoritos");
                objAudit = AddAudita(new vw_favoritos(), new vw_favoritos(), DataKey, "L");
                objAudit.TableName = "vw_favoritos";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();

            }

            return objLista;
        }

        public int setMantenimiento(vw_favoritos objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.usp_vw_favoritos(

            objSC.IdFavorito,
                objSC.NumeroFavorito,
                objSC.Mnemotecnico,
                objSC.Descripcion,
                objSC.DescripcionExtranjera,
                objSC.IdAgente,
                objSC.IdFavoritoTabla,
                objSC.Estado,
                objSC.Accion, objSC.Version, objSC.NombreTabla, objSC.DescripTabla, objSC.CodigoAgente,
                objSC.Nombre, objSC.TipoFavorito

                     ).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
