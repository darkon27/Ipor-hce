using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALMiscelaneoFormulario
{
    public class MiscelaneoFormularioCrono : AuditGenerico<MA_MiscelaneosDetalle, MA_MiscelaneosDetalle> 
    {
        public List<MA_MiscelaneosDetalle> listarMA_MiscelaneosFormularioCrono(MA_MiscelaneosDetalle ObjTrace, string usu, string unidadreplicacion, int idpaciente, int episodioclinico, int idepisodioatencion, int idordenatencion, string CodigoOA, int IdMedico, int IdOpcion, string codigoformato)
        {
            List<MA_MiscelaneosDetalle> objLista = new List<MA_MiscelaneosDetalle>();
            using (var context = new WEB_ERPSALUDEntities())
            {
               objLista=  context.SP_SS_HC_Miscelaneos_Formularios_LISTAR(
                      ObjTrace.AplicacionCodigo
                    , ObjTrace.CodigoTabla
                    , ObjTrace.Compania
                    , ObjTrace.CodigoElemento                    
                    ,usu
                    ,unidadreplicacion
                    ,idpaciente
                    ,episodioclinico
                    ,idepisodioatencion
                    ,idordenatencion
                    ,CodigoOA
                    ,IdMedico
                    ,IdOpcion
                    ,codigoformato
                    , ObjTrace.ACCION

                    ).ToList();

            }

            return objLista;
        }
    }
}
