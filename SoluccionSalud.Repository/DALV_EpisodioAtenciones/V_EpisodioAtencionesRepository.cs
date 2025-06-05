using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Model;

namespace SoluccionSalud.Repository.DALV_EpisodioAtenciones
{
    public class V_EpisodioAtencionesRepository
    {
        public List<V_EpisodioAtenciones> ListarV_EpisodioAtenciones(V_EpisodioAtenciones objSC, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                //context.Database.CommandTimeout = 180;
                //NUMEROLOGINSDISPONIBLE y NUMEROLOGINSUSADOS usados auxiliarmente como inicio y fin.
                return context.USP_V_EpisodioAtenciones_LISTAR(
                    objSC.Persona
                    , objSC.NombreCompleto
                    , objSC.UnidadReplicacion
                    , objSC.IdEpisodioAtencion
                    , objSC.UnidadReplicacionEC
                    , objSC.IdPaciente
                    , objSC.EpisodioClinico
                    , objSC.IdEstablecimientoSalud
                    , objSC.IdUnidadServicio
                    , objSC.IdPersonalSalud
                    , objSC.Episodio_Atencion
                    , objSC.TipoAtencion
                    , objSC.IdOrdenAtencion
                    , objSC.TipoOrdenAtencion
                    , objSC.Estado_EpisodioAten
                    , objSC.FechaModificacion
                    , objSC.FechaRegistro
                    , objSC.FechaAtencion
                    , objSC.FechaCierre
                    , objSC.UsuarioModificacion
                    , objSC.CodigoEpisodioClinico
                    , objSC.IdEpisodioAtencionCodigo
                    , objSC.CodigoOA
                    , objSC.TipoTrabajador
                    , objSC.Id001
                    , objSC.Formato_Id
                    , objSC.Id001
                    , objSC.Id002
                    , objSC.Codigo001
                    , objSC.Codigo002
                    , objSC.Descripcion001
                    , inicio
                    , final
                    , objSC.UsuarioCreacion  //AUXILIAR PARA VERSIÓN
                    , objSC.Accion

                    ).ToList();
            }
        }

        public int setMantenimiento(V_EpisodioAtenciones objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_V_EpisodioAtenciones(
                    objSC.Persona
                    , objSC.NombreCompleto
                    , objSC.UnidadReplicacion
                    , objSC.IdEpisodioAtencion
                    , objSC.UnidadReplicacionEC
                    , objSC.IdPaciente
                    , objSC.EpisodioClinico
                    , objSC.IdEstablecimientoSalud
                    , objSC.IdUnidadServicio
                    , objSC.IdPersonalSalud
                    , (int)objSC.Episodio_Atencion
                    , objSC.TipoAtencion
                    , objSC.IdOrdenAtencion
                    , objSC.TipoOrdenAtencion
                    , objSC.Estado_EpisodioAten
                    , objSC.FechaModificacion
                    , objSC.FechaRegistro
                    , objSC.FechaAtencion
                    , objSC.FechaCierre
                    , objSC.UsuarioModificacion
                    , null
                    , null
                    , objSC.UsuarioCreacion  //AUXILIAR PARA VERSIÓN
                    , objSC.Accion

                    ).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
