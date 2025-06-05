using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvcEpisodioTriaje
    {

        public static int UpdateTriajeAlergias(int Idaction, SS_CE_TriajeViewModel objSC)
        {

            return new EpisodioTriajeRepository().UpdateTriajeAlergias(Idaction, objSC);
        }

        public static long GetItemCount()
        {

            return new EpisodioTriajeRepository().getCountEpisodioTriaje();
        }

        public static List<SP_ListarAlergiaDetalle_FE_Result> TriajeAlegriaDetalle(SP_ListarAlergiaDetalle_FE_Result Obj)
        {

            return new EpisodioTriajeRepository().GetListTriajeDetalle(Obj);
        }

        public static List<SS_HC_EpisodioTriaje> getSelectEpisodioByCode(long IdEpisodioTriaje)
        {

            return new EpisodioTriajeRepository().getSelectEpisodioByCode(IdEpisodioTriaje);
        }

        public static long RegistrarTriajeSpringData(SS_CE_TriajeViewModel objSP)
        {
            return new EpisodioTriajeRepository().RegistrarTriajeSpringData(objSP);
        }
        public static List<SP_ListarBandejaTriaje_Result> EpisorioTriaje_Listar(DataBandeja objBandeja, int PageNumber, int PageSiz)
        {
            return new EpisodioTriajeRepository().EpisorioTriaje_Listar(objBandeja, PageNumber, PageSiz);
        }

        public long getCountEpisodioTriaje()
        {
            return new EpisodioTriajeRepository().getCountEpisodioTriaje();
        }

        
        public static int setMantenimientoEpisodioTriaje(SS_HC_EpisodioTriaje ObjTrace)
        {
           

            return new EpisodioTriajeRepository().setMantenimientoEpisodioTriaje(ObjTrace);
        }

        public static int UpdatePacienteHC(int IdPaciente, String HC)
        {


            return new EpisodioTriajeRepository().UpdatePacienteHC(IdPaciente, HC);
        }
         

        public static int UpdateEspecialidadTriaje(SS_HC_EpisodioTriaje ObjTrace)
        {
            return new EpisodioTriajeRepository().UpdateEspecialidadTriaje(ObjTrace);
        }


        public static List<SG_Agente> listarSG_AgenteLogin(SG_Agente objSC, int inicio, int final)
        {
            return new EpisodioTriajeRepository().listarSG_AgenteLogin(objSC, inicio, final);
        }

        public static List<PERSONAMAST> GetSelectPersonaMast(PERSONAMAST objSC)
        {
            return new EpisodioTriajeRepository().GetSelectPersonaMast(objSC);
        }

        public static List<MA_MiscelaneosDetalle> ListaComboUbigeo(MA_MiscelaneosDetalle ObjTrace1, int inicio, int final)
        {
            return new EpisodioTriajeRepository().ListaComboUbigeo(ObjTrace1, inicio, final);

        }
        public static List<MA_MiscelaneosDetalle> ListaComboDepartamentosProvincia(MA_MiscelaneosDetalle ObjTrace1)
        {
            return new EpisodioTriajeRepository().ListaComboDepartamentosProvincia(ObjTrace1);

        }


        public static List<MA_MiscelaneosDetalle> GetUpListadoServicios(MA_MiscelaneosDetalle objSC)
        {
            return new EpisodioTriajeRepository().GetUpListadoServicios(objSC);
        }





        public static int InsertarPacienteTriajeWeb(PERSONAMAST objSP)
        {
            return new EpisodioTriajeRepository().InsertarPacienteTriajeWeb(objSP);
        }
        public static int InsertarPacienteTriaje(PERSONAMAST objSP)
        {
            return new EpisodioTriajeRepository().RegistroPacientesSpringv2(objSP);
        }

        public static int RegistrarTriajeSpring(SS_CE_TriajeFirma objSP)
        {
            return new EpisodioTriajeRepository().RegistrarTriajeSpring(objSP);
        }


        public static long SendEpisodios(SS_HC_EpisodioAtencion objSP)
        {
            return new EpisodioTriajeRepository().SnedEpisodios(objSP);
        }





    }
}
