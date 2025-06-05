using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Model;


namespace SoluccionSalud.Repository.DALSG_AgenteOpcion
{
    public class SG_AgenteOpcionRepository
    {

        public List<SG_AgenteOpcion> listarSG_AgenteOpcion(SG_AgenteOpcion objSC, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return null;
            }
        }
        public int setMantenimiento(SG_AgenteOpcion objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_SS_HC_SG_AgenteOpcion(
                objSC.IdAgente
                , objSC.IdOpcion
                , objSC.ValorFecha
                , objSC.ValorNumerico
                , objSC.ValorTexto
                , objSC.IndicadorAcceso
                , objSC.IndicadorHabilitado
                , objSC.IndicadorObligatorio
                , objSC.IndicadorVisible
                , objSC.IndicadorPrioridad
                , objSC.IndicadorNuevo
                , objSC.IndicadorModificar
                , objSC.IndicadorEliminar
                , objSC.IndicadorImprimir
                , objSC.IndicadorIngreso
                , objSC.Estado
                , objSC.UsuarioCreacion
                , objSC.FechaCreacion
                , objSC.UsuarioModificacion
                , objSC.FechaModificacion
                , objSC.Version
                , objSC.Accion
                ).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
