
﻿using SoluccionSalud.Bussines.BLLSeguridadgrupo;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.SeguridadGrupoService
{
    public class SvcSeguridadGrupo
    {
        public static List<SEGURIDADGRUPO> listarSeguridadGrupo(SEGURIDADGRUPO objSC)
        {
            return new SeguridadGruposBLL().listarSeguridadGrupo(objSC);
        }
        public static int setMantenimiento(SEGURIDADGRUPO ObjTrace)
        {
            return new SeguridadGruposBLL().setMantenimiento(ObjTrace);
        }

        public static List<SEGURIDADGRUPO> listarSeguridadGrupoAccion(SEGURIDADGRUPO objSC, String accion)
        {
            if (objSC == null)
            {
                objSC = new SEGURIDADGRUPO();
            }
            objSC.ACCION = accion;
            return new SeguridadGruposBLL().listarSeguridadGrupo(objSC);
        }
    }
}
