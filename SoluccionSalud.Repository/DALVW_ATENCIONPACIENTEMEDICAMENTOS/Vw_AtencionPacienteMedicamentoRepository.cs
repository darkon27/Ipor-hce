using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.ModelPAE;
using System.Data.Entity;
using Newtonsoft.Json;
using System.Xml;
using System.Xml.Serialization;
using System.Collections;

namespace SoluccionSalud.Repository.DALVW_ATENCIONPACIENTEMEDICAMENTOS
{
    public class Vw_AtencionPacienteMedicamentoRepository : AuditGenerico<VW_ATENCIONPACIENTEMEDICAMENTO, object> 
    {
        public List<VW_ATENCIONPACIENTEMEDICAMENTO> listarVwAtencionPacienteMedicamento(VW_ATENCIONPACIENTEMEDICAMENTO objSC, int inicio, int final)
        {
            try
            {
                DateTime FechaInicio = Convert.ToDateTime(objSC.FechaCreacion);
               DateTime FechaFin = Convert.ToDateTime(objSC.IngresoFechaRegistro);
                String Accion = objSC.Familia;
                String Version = "";
                using (var context = new WEB_ERPSALUDEntities())
                {
                    return context.SP_VW_ATENCIONPACIENTEMEDICAMENTO_Listar(
                        objSC.UnidadReplicacion
                        , objSC.IdEpisodioAtencion                        
                        , objSC.IdPaciente
                        , objSC.EpisodioClinico
                        , objSC.Secuencia
                        , objSC.IdUnidadMedida
                        , objSC.Linea
                        , null//objSC.Familia
                        , objSC.SubFamilia
                        , objSC.TipoComponente
                        , objSC.CodigoComponente
                        , objSC.IdVia
                        , objSC.Dosis
                        , objSC.DiasTratamiento
                        , objSC.Frecuencia
                        , objSC.Cantidad
                        , objSC.IndicadorEPS
                        , objSC.TipoReceta
                        , objSC.Forma
                        , objSC.GrupoMedicamento
                        , objSC.Comentario
                        , objSC.IndicadorAuditoria
                        , objSC.UsuarioAuditoria
                        , objSC.Estado
                        , objSC.Persona
                        , objSC.Origen
                        , objSC.NombreCompleto
                        , objSC.IngresoFechaRegistro
                        , objSC.IngresoAplicacionCodigo
                        , objSC.IngresoUsuario
                        , objSC.Celular
                        , objSC.EstadoPersona
                        , objSC.Medicamento                        
                        , FechaInicio
                        , Accion
                        , Version
                        , FechaFin
                        , objSC.CodigoOA
                        , objSC.Medico
                        , objSC.Cama                        
                    ).ToList();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

      

        private string SerializeArrayList(List<object> objSCList)
        {
            throw new NotImplementedException();
        }
        
    }
}
