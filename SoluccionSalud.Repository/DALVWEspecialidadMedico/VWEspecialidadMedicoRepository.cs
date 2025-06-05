using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALVWEspecialidadMedico
{
    public class VWEspecialidadMedicoRepository : AuditGenerico<VW_SS_GE_ESPECIALIDADMEDICO, VW_SS_GE_ESPECIALIDADMEDICO>
    {
        public List<VW_SS_GE_ESPECIALIDADMEDICO> listarEspecialidadMedico(VW_SS_GE_ESPECIALIDADMEDICO objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<VW_SS_GE_ESPECIALIDADMEDICO> objLista = new List<VW_SS_GE_ESPECIALIDADMEDICO>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_VW_SS_GE_EspecialidadMedicoListar(objSC.PERSONA, objSC.ORIGEN, objSC.NOMBRES,
                    objSC.NOMBRECOMPLETO, objSC.BUSQUEDA, objSC.TIPODOCUMENTOIDENTIDAD,
                    objSC.DOCUMENTOIDENTIDAD, objSC.ESCLIENTE, objSC.ESPROVEEDOR, objSC.ESEMPLEADO, objSC.ESOTRO,
                    objSC.TIPOPERSONA, objSC.FECHANACIMIENTO, objSC.CIUDADNACIMIENTO, objSC.DOCUMENTOFISCAL,
                    objSC.DOCUMENTO, objSC.PERSONAANT, objSC.CORREOELECTRONICO, objSC.CLASEPERSONACODIGO, objSC.ESTADO,
                    objSC.ULTIMOUSUARIO, objSC.ULTIMAFECHAMODIF, objSC.TIPOPERSONAUSUARIO, objSC.CMP, objSC.FOTO,
                    objSC.NUMEROREGISTROESPECIALIDAD, objSC.TIPOGENERACIONCITA, objSC.TIEMPOPROMEDIOATENCION,
                    objSC.IDESPECIALIDAD, objSC.NOMBRE, objSC.ACCION, objSC.SEXO, objSC.DIRECCION,
                    objSC.TELEFONO, objSC.PROGRAMADO, objSC.SERVICIO, objSC.TIPOHORARIO, objSC.IDHORARIO,
                    objSC.CODIGOUSUARIO, inicio, final
                   ).ToList();
                DataKey = new
                {
                    PERSONA = objSC.PERSONA,
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<VW_SS_GE_ESPECIALIDADMEDICO>(), "VW_SS_GE_ESPECIALIDADMEDICO");
                objAudit = AddAudita(new VW_SS_GE_ESPECIALIDADMEDICO(), new VW_SS_GE_ESPECIALIDADMEDICO(), DataKey, "L");
                objAudit.TableName = "VW_SS_GE_ESPECIALIDADMEDICO";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
            }
            return objLista;
        }
        public int setMantenimiento(VW_SS_GE_ESPECIALIDADMEDICO objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_VW_SS_GE_EspecialidadMedico(
                   objSC.PERSONA, objSC.ORIGEN, objSC.NOMBRES,
                    objSC.NOMBRECOMPLETO, objSC.BUSQUEDA, objSC.TIPODOCUMENTOIDENTIDAD,
                    objSC.DOCUMENTOIDENTIDAD, objSC.ESCLIENTE, objSC.ESPROVEEDOR, objSC.ESEMPLEADO, objSC.ESOTRO,
                    objSC.TIPOPERSONA, objSC.FECHANACIMIENTO, objSC.CIUDADNACIMIENTO, objSC.DOCUMENTOFISCAL,
                    objSC.DOCUMENTO, objSC.PERSONAANT, objSC.CORREOELECTRONICO, objSC.CLASEPERSONACODIGO, objSC.ESTADO,
                    objSC.ULTIMOUSUARIO, objSC.ULTIMAFECHAMODIF, objSC.TIPOPERSONAUSUARIO, objSC.CMP, objSC.FOTO,
                    objSC.NUMEROREGISTROESPECIALIDAD, objSC.TIPOGENERACIONCITA, objSC.TIEMPOPROMEDIOATENCION,
                    objSC.IDESPECIALIDAD, objSC.NOMBRE, objSC.ACCION, objSC.SEXO, objSC.DIRECCION,
                    objSC.TELEFONO, objSC.PROGRAMADO, objSC.SERVICIO, objSC.TIPOHORARIO, objSC.IDHORARIO,
                    objSC.CODIGOUSUARIO
                    ).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
