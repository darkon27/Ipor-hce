using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Model;

namespace SoluccionSalud.Repository.DALSeguridadGrupo
{
    public class SeguridadGrupoRepository
    {
        public List<SEGURIDADGRUPO> listarSeguridadGrupo(SEGURIDADGRUPO objSC)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                //NUMEROLOGINSDISPONIBLE y NUMEROLOGINSUSADOS usados auxiliarmente como inicio y fin.
                return context.USP_SEGURIDADGRUPOLISTAR(objSC.APLICACIONCODIGO, objSC.GRUPO,
                    objSC.DESCRIPCION, objSC.ULTIMOUSUARIO, objSC.ULTIMAFECHAMODIF, objSC.ESTADO,
                    objSC.SETCOLUMMENU, objSC.SETFILAMENU, objSC.ACCION
                    ).ToList();
            }
        }

        public int setMantenimiento(SEGURIDADGRUPO objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_SEGURIDADGRUPOMANTENIMIENTO(objSC.APLICACIONCODIGO, objSC.GRUPO,
                    objSC.DESCRIPCION, objSC.ULTIMOUSUARIO, objSC.ULTIMAFECHAMODIF, objSC.ESTADO,
                    objSC.SETCOLUMMENU, objSC.SETFILAMENU, objSC.ACCION).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
