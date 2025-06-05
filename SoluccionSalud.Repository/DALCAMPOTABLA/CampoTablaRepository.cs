using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Repository.DALCAMPOTABLA
{
    public class CampoTablaRepository : GenericDataRepository<VW_TABLACAMPO>
    {
        public List<VW_TABLACAMPO> listarVwTablaCampo(VW_TABLACAMPO objSC, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_VW_TABLACAMPO_LISTA(
                     objSC.IdFavoritoTabla,
                     objSC.IdCampo,
                     objSC.DescripcionTabla,
                     objSC.DescripTablaCampo,
                     objSC.NumeroClavePrimaria,
                     objSC.Estado,
                     objSC.Accion, objSC.TipoTabla, inicio, final).ToList();
            }
        }
        public int setMantenimiento(VW_TABLACAMPO objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_VW_TABLACAMPO(
                     objSC.IdFavoritoTabla,
                     objSC.IdCampo,
                     objSC.DescripcionTabla,
                     objSC.DescripTablaCampo,
                     objSC.NumeroClavePrimaria,
                     objSC.Estado,
                     objSC.Accion, objSC.TipoTabla).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
