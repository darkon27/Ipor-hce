using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
 
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.BLLPersonaMast;
using System.Web.Services.Description;

namespace SoluccionSalud.Service.PersonaMastService
{

    public class SvcPersonaMast
    {
        public static List<PERSONAMAST> GetSelectPersonaMast(PERSONAMAST objSC)
        {
            return new PersonaMastBLL().GetSelectPersonaMast(objSC);
        }
        public static List<PERSONAMAST> GetSelectPersonaCitas(PERSONAMAST objSC)
        {
            WebReference.ServiciosSalud miws = new WebReference.ServiciosSalud();
            List<SoluccionSalud.Service.WebReference.AV_SOA_Service> list = new List<SoluccionSalud.Service.WebReference.AV_SOA_Service>();
            SoluccionSalud.Service.WebReference.AV_SOA_Service EntObj = new SoluccionSalud.Service.WebReference.AV_SOA_Service();
            list = miws.GetSelectPersonaMast(EntObj).ToList();
            List<PERSONAMAST> NewList = new List<PERSONAMAST>();
            PERSONAMAST EntNew;
            int reg = 1;
            foreach( SoluccionSalud.Service.WebReference.AV_SOA_Service obj in list){
                EntNew = new PERSONAMAST();
                EntNew.IndicadorRegistroManual = reg;
                EntNew.Persona = (int)obj.IdPaciente;
                EntNew.personanew = (int)obj.Persona;
                EntNew.NombreCompleto = obj.IDPACIENTE_NOMBRE;
                EntNew.IngresoFechaRegistro = obj.FechaCita;
                EntNew.UltimaFechaModif = obj.FechaFin;
                EntNew.FecIniDiscamec = obj.HoraInicio;
                EntNew.FecFinDiscamec = obj.HoraFin;
                EntNew.CodigoLDN = obj.CodigoHC;
                EntNew.Origen = "Consulta Extrena";
                EntNew.ClasePersonaCodigo = obj.CodigoHCAnterior;
                EntNew.CorrelativoSCTR = obj.CodigoOA;
                EntNew.Estado = obj.Estado == 1 ? "Inactivo" : "Activo";
                EntNew.TipoPersona = "Seguro";
                NewList.Add(EntNew);
                reg++;

            }
            return NewList;

        }
    }
}
