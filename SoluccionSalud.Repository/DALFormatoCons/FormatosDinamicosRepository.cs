using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.ModelPAE;
using System.Data.Entity;
using System.Data.SqlClient;


namespace SoluccionSalud.Repository.DALFormatoCons
{
    public class FormatosDinamicosRepository
    {

        public int Listar(int objSC)
        {

            /////
                       
            int valorRetorno;
            var iReturnValue2 = new List<SS_HC_EpisodioAtencionFormato>();
            using (var context = new WEB_ERPSALUDEntities())
            {


                List<SS_HC_EpisodioAtencionFormato> iReturnValue3 = (from t in context.SS_HC_EpisodioAtencionFormato
                                                                       where
                                                                       t.UnidadReplicacion == ENTITY_GLOBAL.Instance.UnidadReplicacion
                                                                       && t.IdPaciente == ENTITY_GLOBAL.Instance.PacienteID
                                                                       && t.EpisodioClinico == ENTITY_GLOBAL.Instance.EpisodioClinico
                                                                       && t.IdEpisodioAtencion == ENTITY_GLOBAL.Instance.EpisodioAtencion
                                                                      /*  && t.IdEpisodioAtencion == ENTITY_GLOBAL.Instance.EpisodioAtencion*/
                                                                       && t.IdForm == objSC
                                                                       orderby t.IdEpisodioAtencion descending
                                                                       select t).ToList();
                if (iReturnValue3.Count() > 0)
                {
                    valorRetorno = (int)iReturnValue3[0].IdTransacciones;
                }
                else
                { 
                    valorRetorno = 0; 
                }
                  
            }
            return valorRetorno;

        }
        public int ListarAnt(int objSC)
        {

            /////

            int valorRetorno;
            var iReturnValue2 = new List<SS_HC_EpisodioAtencionFormato>();
            using (var context = new WEB_ERPSALUDEntities())
            {


                List<SS_HC_EpisodioAtencionFormato> iReturnValue3 = (from t in context.SS_HC_EpisodioAtencionFormato
                                                                     where
                                                                     t.UnidadReplicacion == ENTITY_GLOBAL.Instance.UnidadReplicacion
                                                                     && t.IdPaciente == ENTITY_GLOBAL.Instance.PacienteID
                                                                     /*&& t.EpisodioClinico == ENTITY_GLOBAL.Instance.EpisodioClinico
                                                                     && t.IdEpisodioAtencion == ENTITY_GLOBAL.Instance.EpisodioAtencion
                                                                           && t.IdEpisodioAtencion == ENTITY_GLOBAL.Instance.EpisodioAtencion*/
                                                                     && t.IdForm == objSC
                                                                     orderby t.IdEpisodioAtencion descending, t.EpisodioClinico descending, t.IdTransacciones descending
                                                                     select t).Take(1).ToList();
                if (iReturnValue3.Count() > 0)
                {
                    valorRetorno = (int)iReturnValue3[0].IdTransacciones;
                }
                else
                {
                    valorRetorno = 0;
                }

            }
            return valorRetorno;

        }
    }
}
