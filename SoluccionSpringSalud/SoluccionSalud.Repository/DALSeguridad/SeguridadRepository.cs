using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Model;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALCategorias;
using SoluccionSalud.Repository.Repository;

namespace SoluccionSalud.Repository.DALSeguridad
{
    public class SeguridadRepository : GenericDataRepository<SEGURIDADCONCEPTO>, ISeguridadRepository, IMantenimiento
    {
      
        public List<SEGURIDADCONCEPTO> GetAll()
        {
            return base.GetSelectAll();
        }

        public int Eliminar(params object[] parameters)
        {
            return base.ExecuteNonQuery("exec SP_ELIMINAR {0}", parameters);
        }

        public List<SEGURIDADCONCEPTO> GetSelectSP(SEGURIDADCONCEPTO objSC)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_SEGURIDADCONCEPTO(objSC.ACCION, objSC.APLICACIONCODIGO, objSC.GRUPO, objSC.CONCEPTO, objSC.CONCEPTOPADRE).ToList();
            }
        }
        public List<SEGURIDADGRUPO> GetSelectSeguridadGrupo(SEGURIDADGRUPO objSC)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_SEGURIDADGRUPO(objSC.ACCION, objSC.APLICACIONCODIGO, objSC.GRUPO).ToList();
            }
        }
        
    }
}
