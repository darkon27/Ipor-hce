using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Model;


namespace SoluccionSalud.Repository.DALSG_Grupo
{
    public class SG_GrupoRepository
    {
        public List<SG_Grupo> listarSG_Grupo(SG_Grupo objSC, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_SS_HC_SG_Grupo_LISTAR(
                         objSC.IdGrupo
                        , objSC.IdGrupoPadre
                        , objSC.CodigoGrupo
                        , objSC.CadenaRecursividad
                        , objSC.NivelGrupo
                        , objSC.Nombre
                        , objSC.Descripcion
                        , objSC.Estado
                        , objSC.UsuarioCreacion
                        , objSC.FechaCreacion
                        , objSC.UsuarioModificacion
                        , objSC.FechaModificacion
                    , inicio, final
                    , objSC.ACCION
                    ).ToList();
            }
        }

        public int setMantenimiento(SG_Grupo objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_SS_HC_SG_Grupo(
                         objSC.IdGrupo
                        ,objSC.IdGrupoPadre
                        ,objSC.CodigoGrupo
                        ,objSC.CadenaRecursividad
                        ,objSC.NivelGrupo
                        ,objSC.Nombre
                        ,objSC.Descripcion
                        ,objSC.Estado
                        ,objSC.UsuarioCreacion
                        ,objSC.FechaCreacion
                        ,objSC.UsuarioModificacion
                        ,objSC.FechaModificacion
                        ,objSC.ACCION

                     ).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
