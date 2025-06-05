using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using SoluccionSalud.ModelERP_FORM;
using SoluccionSalud.Model;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository;
using System.Data.Entity;
using System.Xml;
using System.Xml.Serialization;
using SoluccionSalud.Repository.Repository;
using Newtonsoft.Json;

namespace SoluccionSalud.RepositoryFormulario.DAL_Formularios
{
    public class EpisodioNotificacionesRepository
    {
        Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();   //Agregado auditoria --> N° 1


        public List<SS_HC_EpisodioNotificaciones_FE> listarNotificaciones(SS_HC_EpisodioNotificaciones_FE objSC, int inicio, int final)
        {

            List<SS_HC_EpisodioNotificaciones_FE> objLista = new List<SS_HC_EpisodioNotificaciones_FE>();

            using (var context = new ModelFormularios())
            {
                objLista = context.USP_SS_HC_BANDEJA_NOTIFI_EPISODIO_HEADER_LISTAR(

                    objSC.UnidadReplicacion,
                    objSC.IdPaciente,
                    objSC.IdOrdenAtencion,
                    objSC.Tipo,
                    objSC.IdEspecialidad,
                    objSC.CodigoOA,
                    objSC.Secuencia,
                    objSC.TipoMedicamento,
                    objSC.IdUnidadMedida,
                    objSC.Linea,
                    objSC.Familia,
                    objSC.SubFamilia,
                    objSC.CodigoComponente,
                     objSC.IdVia,
                     objSC.Dosis,

                     objSC.DiasTratamiento,
                    objSC.Frecuencia,
                    objSC.Cantidad,
                    objSC.IndicadorEPS,
                    objSC.TipoReceta,
                    objSC.GrupoMedicamento,
                    objSC.Comentario,
                    objSC.TipoComida,
                    objSC.VolumenDia,
                    objSC.FrecuenciaToma,
                    objSC.Presentacion,
                    objSC.Hora,
                    objSC.Periodo,
                     objSC.UnidadTiempo,
                     objSC.UsuarioAuditoria,

                     objSC.Indicacion,
                    objSC.Estado,
                    objSC.UsuarioCreacion,
                    objSC.FechaCreacion,
                    objSC.UsuarioModificacion,
                    objSC.FechaModificacion,
                    objSC.Accion,
                    objSC.Version,

                    objSC.INDICADORTI,
                    objSC.IdPadreNutriente,
                    objSC.IdHijoNutriente,
                    objSC.SecuencialHCE,
                    objSC.CodAlmacen,


                    inicio,
                    final
                ).ToList();



            }
            return objLista;
        }

        //Agregado auditoria --> N° 4
       
        //--
    }
}
