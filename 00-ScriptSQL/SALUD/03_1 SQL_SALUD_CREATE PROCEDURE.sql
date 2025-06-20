GO

CREATE OR ALTER PROCEDURE [dbo].[SS_HC_ATENCIONES_SOA_AMBULATORIO]
(
       @tipoListado			varchar(50) ,
       @CitaTipo			varchar(20) ,
       @CitaFecha			datetime,
       @Origen				varchar(20) ,
       @NombreEspecialidad	varchar(80) ,       
       @TipoPacienteNombre	varchar(80) ,
       @CodigoOA			varchar(25) ,
       @Cama				varchar(150) ,
       @TipoOrdenAtencionNombre          varchar(250) ,
       @CodigoHC			varchar(15) ,       
       @PacienteNombre      varchar(100) ,
       @MedicoNombre		varchar(100) ,
       @IdOrdenAtencion     int ,
       @LineaOrdenAtencion  int ,
       @IdHospitalizacion   int ,       
       @IdCita             int ,
       @IdPaciente         int,
       @TipoPaciente       int,
       @TipoAtencion       int,
       @IdEspecialidad     int,
       
       @IdMedico           int,
       @TipoOrdenAtencion  int,
       @Componente         varchar(25),
       @Compania           varchar(15),
       @Sucursal           varchar(15),
       
       @EstadoPersona             varchar(2),
       @EstadoEpiClinico          int,
       @UnidadReplicacion         varchar(4),
       @UnidadReplicacionEC       varchar(4),
       @IdEpisodioAtencion        bigint,
       
       @EpisodioClinico           int,
       @IdEstablecimientoSalud    int,
       @IdUnidadServicio          int,
       @IdPersonalSalud           int,
       @EpisodioAtencion          bigint,
       @FechaRegistro             datetime,
       @FechaAtencion             datetime,
       @EstadoEpiAtencion         int,
       @FechaInicio				  datetime,
       @FechaFin				  datetime,
       @UsuarioCreacion           varchar(50),
       @FechaCreacion			  datetime ,
       @UsuarioModificacion       varchar(50) , -- Nombre del COMPONENTE TECNOLOGO
       @FechaModificacion		  datetime ,          
       @Version					  varchar(50) ,
       @CodigoHCAnterior		  varchar(15) ,
       @IndicadorCirugia		  int,  
       @IndicadorExamenPrincipal  int,  
       @IndicadorSeguro			  int,  
       @Modalidad				  int,  
       @sexo					  char(1),    
       @EstadoCivil char(1),    
       @NivelInstruccion char(3),    
       @EsPaciente varchar(1),  
       @EsEmpresa varchar(1), 
       @Inicio int ,  
       @NumeroFilas int ,  
       @ACCION varchar(25)
                   
)

--WITH RECOMPILE
AS
BEGIN

       DECLARE @CONTADOR INT                          
       DECLARE @ACCION_END varchar(50)=null    
       /****TABLA TEMPORAL NOMBRE DE LA VISTA  : VW_ATENCIONPACIENTE_GENERAL*******/
       /***************************************************************************/

  DECLARE @TABLA_ATENCIONPACIENTE_GENERAL_TEMP table
      (
            --SECUENCIA             int  NOT NULL   IDENTITY PRIMARY KEY,
            NumeroFila  int   null
      ,     tipoListado varchar(30) null
      ,     CitaTipo    varchar(9)  null
      ,     CitaFecha   datetime    null
      ,     CitaHora    datetime    null
      ,     Origen      varchar(20) null
      ,     NombreEspecialidad      varchar(80) null
      ,     TipoPacienteNombre      varchar(80) null
      ,     CodigoOA    varchar(25) null
      ,     FechaInicio datetime    null
      ,     Cama  varchar(500)      null
      ,     TipoOrdenAtencionNombre varchar(80) null
      ,     CodigoHC    varchar(15) null
      ,     CodigoHCAnterior  varchar(15) null
      ,     PacienteNombre    varchar(100)      null
      ,     MedicoNombre      varchar(100)      null
      ,     IdOrdenAtencion   int   null
      ,     LineaOrdenAtencion      int   null
      ,     IdHospitalizacion int   null
      ,     LineaHospitalizacion    int   null
      ,     IdConsultaExterna int   null
      ,     IdProcedimiento   int   null
      ,     Modalidad   int   null
      ,     IndicadorSeguro   int   null
      ,     IdCita      int   null
      ,     IdPaciente  int   null
      ,     TipoPaciente      int   null
      ,     TipoAtencion      int   null
      ,     IdEspecialidad    int   null
      ,     IdEmpresaAseguradora    int   null
      ,     TipoOrdenAtencion int   null
      ,     Componente  varchar(25) null
      ,     ComponenteNombre  varchar(250)      null
      ,     Compania    varchar(15) null
      ,     Sucursal    varchar(15) null
      ,     IdMedico    int   null
      ,     IndicadorCirugia  int   null
      ,     IndicadorExamenPrincipal     int   null
      ,     PersonaAnt  char(15)    null
      ,     sexo  char(1)     null
      ,     FechaNacimiento   datetime    null
      ,     EstadoCivil char(1)     null
      ,     NivelInstruccion  char(3)     null
      ,     Direccion   varchar(190)      null
      ,     TipoDocumento     char(1)     null
      ,     Documento   char(20)    null
      ,     ApellidoPaterno   varchar(40) null
      ,     ApellidoMaterno   varchar(40) null
      ,     Nombres     varchar(40) null
      ,     LugarNacimiento   varchar(255)      null
      ,     CodigoPostal      char(3)     null
      ,     Provincia   char(3)     null
      ,     Departamento      char(3)     null
      ,     Telefono    varchar(15) null
      ,     CorreoElectronico varchar(50) null
      ,     EsPaciente  varchar(1)  null
      ,     EsEmpresa   varchar(1)  null
      ,     Pais  varchar(100)     null
      ,     EstadoPersona     char(1)     null
      ,     FechaCierreEpiClinico   datetime    null
      ,     EstadoEpiClinico  int   null
      ,     UnidadReplicacion char(4)     null
      ,     UnidadReplicacionEC     char(4)     null
      ,     IdEpisodioAtencion      bigint      null
      ,     EpisodioClinico   int   null
      ,     IdEstablecimientoSalud  int   null
      ,     IdUnidadServicio  int   null
      ,     IdPersonalSalud   int   null
      ,     EpisodioAtencion  int   null
      ,     FechaRegistro     datetime    null
      ,     FechaAtencion     datetime    null
      ,     EstadoEpiAtencion int   null
      ,     UsuarioCreacion   varchar(25) null
      ,     UsuarioModificacion     varchar(25) null
      ,     FechaCreacion     datetime    null
      ,     FechaModificacion datetime    null
      ,     Accion      varchar(25) null
      ,     Version     varchar(25) null
      ,     FechaFin    datetime    null
      ,     FechaOrden  datetime    null
      ,     Comentarios INT null -- varchar(300)      null
      ,     Observaciones INT null -- varchar(300)      null  
      ,     Diagnostico INT null -- varchar(300)      null
      -------------
      ,     UnidadReplicacionHCE    varchar(4)  null
      ,     IdPacienteHCE     int   null
      ,     EpisodioClinicoHCE      int   null
      ,     IdEpisodioAtencionHCE   bigint      null
      ,     SecuenciaHCE      int   null
      ,     CodigoEpisodioClinico   int   null  
      -------------
      ,     Contador    int   null                                          
      )
     
       /*****************************LISTADOS PRINCIPALES***************************************/          

			  DECLARE @fechaPeticion datetime
			  SET @fechaPeticion  = GETDATE()
			  SET @FechaFin = DATEADD(DAY,1,@FechaFin)

            /**AMBULATORIO*/

 
		  insert into @TABLA_ATENCIONPACIENTE_GENERAL_TEMP
		(tipoListado,CitaTipo,CitaFecha,CitaHora,Origen,NombreEspecialidad,TipoPacienteNombre,CodigoOA,
		--------
		  Cama, FechaInicio,TipoOrdenAtencionNombre,CodigoHC,CodigoHCAnterior,
		PacienteNombre,MedicoNombre,IdOrdenAtencion,LineaOrdenAtencion,IdHospitalizacion,
		LineaHospitalizacion,IdConsultaExterna,IdProcedimiento,Modalidad,IndicadorSeguro,
		IdCita,FechaFin,
		--------
		IdPaciente,TipoPaciente,TipoAtencion,IdEspecialidad,IdEmpresaAseguradora,
		TipoOrdenAtencion,Componente,ComponenteNombre,Compania,Sucursal,
		IdMedico,IndicadorCirugia,IndicadorExamenPrincipal,
		-------
		UnidadReplicacionHCE,EstadoEpiAtencion,EpisodioClinicoHCE,IdEpisodioAtencionHCE,IdPacienteHCE,SecuenciaHCE,
		----------
		PersonaAnt,sexo,FechaNacimiento,EstadoCivil,NivelInstruccion,
		Direccion,TipoDocumento,Documento,ApellidoPaterno,ApellidoMaterno,
		Nombres,LugarNacimiento,CodigoPostal,Provincia,Departamento,
		Telefono,CorreoElectronico,EsPaciente,EsEmpresa,Pais,
		EstadoPersona,UnidadReplicacionEC,Version,FechaCierreEpiClinico,Contador
		)


		SELECT --top 50
                  'MED_AMBULATORIO' as tipoListado,
                  ---------7
                  CitaTipo = (CASE SS_CC_Cita.TipoCita WHEN 1 THEN 'Normal' WHEN 4 THEN 'Adicional' ELSE 'Extra' END),
                  CitaFecha = SS_CC_Cita.FechaCita,
                  CitaHora = SS_CC_Cita.FechaCita,
                  Origen = (CASE WHEN SS_AD_OrdenAtencion.IdOrdenAtencion IS NULL THEN 'Cita' ELSE CASE WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 11) THEN 'Consulta' ELSE 'Procedimiento' END END),
                  NombreEspecialidad = SS_GE_Especialidad.Nombre,
                  TipoPacienteNombre = TipoPaciente.Nombre,
                  ISNULL(SS_AD_OrdenAtencion.CodigoOA,'') AS CodigoOA,
                  ----------
                  LEFT(SS_CC_Cita.Comentario, 150) as Cama,
				  ISNULL(SS_AD_OrdenAtencion.FechaInicio,SS_CC_Cita.FechaCita) FechaInicio ,
                  TipoOrdenAtencionNombre = ISNULL(TipoOrdenAtencion.Nombre  , 'Consulta'),
                  SS_GE_Paciente.CodigoHC,
                  SS_GE_Paciente.CodigoHCAnterior,
                  PacienteNombre = paciente.NombreCompleto,
                  --NOMBRE DE MEDICO MEDICO.Busqueda
                  MEDICO.Busqueda as MedicoNombre,
                  IsNull(SS_AD_OrdenAtencion.IdOrdenAtencion,0) AS IdOrdenAtencion,
                  IsNull(SS_AD_OrdenAtencionDetalle.Linea,0) AS LineaOrdenAtencion ,
                  IsNull(SS_AD_OrdenAtencion.IdContrato,0) as IdHospitalizacion,
                  0 AS LineaHospitalizacion ,
                  SS_CE_ConsultaExterna.IdConsultaExterna,
                  SS_PR_Procedimiento.IdProcedimiento,
                  case
					when SS_AD_OrdenAtencion.TipoPaciente='19' then '19'
					when SS_AD_OrdenAtencion.TipoPaciente='4' then '4'
					when SS_AD_OrdenAtencion.modalidad='1' then '1'
					when  SS_AD_OrdenAtencion.modalidad='2' then '2'
					else
					SS_AD_OrdenAtencion.tipopaciente
					end as Modalidad,

                  IndicadorSeguro = (     SELECT IsNull(CM_CO_TablaMaestroDetalleConcepto.IndicadorConcepto,1)
                                               FROM CM_CO_TablaMaestroDetalleConcepto WITH(NOLOCK)
												INNER JOIN CM_CO_TablaMaestroConcepto WITH(NOLOCK) ON CM_CO_TablaMaestroConcepto.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
                                                     AND CM_CO_TablaMaestroConcepto.IdConcepto = CM_CO_TablaMaestroDetalleConcepto.IdConcepto
                                                     AND CM_CO_TablaMaestroConcepto.Concepto = 'APLICA_SEGURO'
                                               WHERE IsNull(TipoPaciente.IdTablaMaestro,-99) = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
                                                     AND IsNull(TipoPaciente.IdCodigo,-99) = CM_CO_TablaMaestroDetalleConcepto.IdCodigo),

                  SS_CC_Cita.IdCita,
                  SS_AD_OrdenAtencion.FechaFinal as FechaFin,
                  ---------------------   11
                  SS_GE_Paciente.IdPaciente,
                  SS_AD_OrdenAtencion.TipoPaciente,
                  SS_AD_OrdenAtencion.TipoAtencion,
                  IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_CC_HORARIO.IdEspecialidad),
                  SS_AD_OrdenAtencion.IdEmpresaAseguradora,
                  SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion,
                  SS_AD_OrdenAtencionDetalle.Componente,
                  ComponenteNombre = CM_CO_Componente.Nombre,
                   IsNull( SS_AD_OrdenAtencion.Compania ,'00000000') AS Compania,
                   case when SS_AD_OrdenAtencion.Sucursal is null then 'LIMA' ELSE  SS_AD_OrdenAtencion.Sucursal END  AS Sucursal,
                  IdMedico = IsNull(IsNull(SS_CE_ConsultaExterna.Medico, SS_PR_Procedimiento.Medico), SS_CC_Horario.Medico),
                  ------------------------
                  0 as IndicadorCirugia,
                  0 as IndicadorExamenPrincipal,
                  ---------------------------ADD ORIGEN HCE --OBS                  
                  case when SS_AD_OrdenAtencion.Sucursal is null then 'LIMA' ELSE  SS_AD_OrdenAtencion.Sucursal END  AS UnidadReplicacionHCE,

				CASE	WHEN  SS_AD_OrdenAtencion.IdOrdenAtencion IS NULL 
					THEN 1 --PROGRAMADO
				ELSE
					CASE	WHEN  SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 11, 21 ) 
						THEN	CASE	WHEN  IsNull(SS_CE_ConsultaExterna.IdConsultaExterna,0) > 0 
											THEN	CASE															
														WHEN SS_CE_ConsultaExterna.EstadoDocumento = 1 
																--then 0 PENDIENTE	
															THEN	CASE	WHEN SS_CC_CITA.EstadoDocumento = 4 
																		THEN 2 --EN ATENCION
																	ELSE 
																		 0 --PENDIENTE	
																	END
														WHEN SS_CE_ConsultaExterna.EstadoDocumento = 2 
																then 3 --ATENDIDO	
														WHEN SS_CE_ConsultaExterna.EstadoDocumento = 3 
																then 4 --ANULADO
														ELSE 0 
													END
										ELSE	CASE	WHEN ss_cc_cita.estadodocumento = 2 
															then 1 --PROGRAMADO
														WHEN ss_cc_cita.estadodocumento = 3 
															then 0 --PENDIENTE
														WHEN SS_CC_CITA.EstadoDocumento = 4 
															then 2 --EN ATENCION
														WHEN SS_CC_CITA.EstadoDocumento = 8 
															then 3 --ATENDIDO
														WHEN SS_CC_CITA.EstadoDocumento = 5 
															then 4 --ANULADO
														ELSE 0 
												END
								END

					WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (  2, 4, 5, 6, 7, 8, 9, 10, 12, 14,16, 17, 18, 19,20,24, 25, 26, 27, 23, 15, 33, 34, 37, 38, 39, 29, 30, 31, 32, 28 ) 
						THEN	CASE	WHEN IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) = -99 AND SS_CC_Cita.EstadoDocumento = 3 
											THEN 0
										WHEN IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) = -99 AND SS_CC_Cita.EstadoDocumento = 2 
											THEN 1
										WHEN IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) = -99 AND SS_CC_Cita.EstadoDocumento = 8 
											THEN 0
										WHEN IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) = -99 AND SS_CC_Cita.EstadoDocumento = 4 
											THEN 0
										WHEN SS_CC_Cita.EstadoDocumento = 4  AND SS_PR_Procedimiento.EstadoDocumento = 3 
											THEN 4 --ANULADO
										WHEN IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) <> -99 AND SS_PR_Procedimiento.EstadoDocumento = 2 
											THEN 3
										WHEN IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) <> -99 AND SS_PR_Procedimiento.EstadoDocumento = 4 
											THEN 5  --TERMINADO
										WHEN IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) <> -99 AND SS_PR_Procedimiento.EstadoDocumento = 1 
											THEN 2
										ELSE -99
								END  
							ELSE ss_cc_cita.estadodocumento
					END  
				END AS EstadoEpiAtencion,                        
                 NULL AS  EpisodioClinicoHCE,
                 NULL AS IDEPISODIOAtencionHCE,
                 NULL AS IdPacienteHCE,
                 NULL AS SecuencialHCE,            
                  ---------------------------  
                  PACIENTE.PersonaAnt,
                  PACIENTE.sexo,
                  PACIENTE.FechaNacimiento,
                 ISNULL(PACIENTE.EstadoCivil,'')EstadoCivil,
                  PACIENTE.NivelInstruccion,
                  replace( LEFT(PACIENTE.Direccion, 190) ,'&#','') as Direccion,
                  PACIENTE.TipoDocumento,
                  PACIENTE.Documento,
                  PACIENTE.ApellidoPaterno,
                  PACIENTE.ApellidoMaterno,
                  PACIENTE.Nombres,
                  PACIENTE.LugarNacimiento,
                  PACIENTE.CodigoPostal,
                  PACIENTE.Provincia,
                  PACIENTE.Departamento,
                  PACIENTE.Telefono,
                  PACIENTE.CorreoElectronico,
                  PACIENTE.EsPaciente,
                  PACIENTE.EsEmpresa,
                  PACIENTE.Pais,
                  PACIENTE.Estado as EstadoPersona,				 
                  case when PACIENTE.Origen  is null then 'LIMA' ELSE  PACIENTE.Origen  END AS  UnidadReplicacionEC,               
				  CASE WHEN SS_AD_OrdenAtencion.IdOrdenAtencion IS NULL THEN 'Ambulatoria' ELSE TipoAtencion.Nombre END  as TipoAtencionDescX,
				   CM_CA_Transaccion.FechaPago FechaCierreEpiClinico,
				0 AS ContadorX
				FROM SS_CC_Cita  WITH(NOLOCK)
				LEFT JOIN SS_CC_Horario  WITH(NOLOCK) ON SS_CC_Horario.IdHorario = SS_CC_Cita.IdHorario  
				LEFT JOIN SS_AD_OrdenAtencionDetalle  WITH(NOLOCK) ON SS_CC_Cita.IdCita = SS_AD_OrdenAtencionDetalle.IdCita  
				LEFT JOIN SS_AD_OrdenAtencion  WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_AD_OrdenAtencion.IdOrdenAtencion  
				LEFT JOIN SS_CE_ConsultaExterna WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_CE_ConsultaExterna.IdOrdenAtencion  
				AND SS_AD_OrdenAtencionDetalle.Linea = SS_CE_ConsultaExterna.LineaOrdenAtencion  
				LEFT JOIN GE_EstadoDocumento WITH(NOLOCK) ON GE_EstadoDocumento.IdEstado = ISNULL(SS_CE_ConsultaExterna.EstadoDocumento, 1)  
				AND GE_EstadoDocumento.IdDocumento = 47
				LEFT JOIN SS_GE_Paciente  WITH(NOLOCK) ON SS_GE_Paciente.IdPaciente = SS_CC_Cita.IdPaciente  
				LEFT JOIN PersonaMast AS Paciente WITH(NOLOCK) ON Paciente.Persona = SS_GE_Paciente.IdPaciente
				LEFT JOIN PERSONAMAST AS MEDICO WITH(NOLOCK) ON SS_CC_CITA.IdMedico=MEDICO.PERSONA  
				LEFT JOIN SS_PR_Procedimiento WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_PR_Procedimiento.IdOrdenAtencion
                        AND SS_AD_OrdenAtencionDetalle.Linea = SS_PR_Procedimiento.LineaOrdenAtencion
                 LEFT JOIN SS_GE_Especialidad WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_CC_HORARIO.IdEspecialidad)
                 LEFT JOIN CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK) ON TipoPaciente.IdTablaMaestro = 106
                        AND TipoPaciente.IdCodigo = IsNull(SS_AD_OrdenAtencion.TipoPaciente,-99)
                 LEFT JOIN CM_CO_TablaMaestroDetalle TipoOrdenAtencion WITH(NOLOCK) ON TipoOrdenAtencion.IdTablaMaestro = 101
                        AND TipoOrdenAtencion.IdCodigo = SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion
                 LEFT JOIN CM_CO_Componente WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.Componente = CM_CO_Componente.CodigoComponente  
                  --------------
                 LEFT JOIN SS_GE_TipoAtencion TipoAtencion WITH(NOLOCK)  ON (TipoAtencion.IdTipoAtencion = SS_AD_OrdenAtencion.TipoAtencion)                      
			   --ECM
			LEFT JOIN CM_CA_TransaccionDetalle WITH(NOLOCK) ON CM_CA_TransaccionDetalle.IdOAOrigen = SS_AD_OrdenAtencionDetalle.IdOrdenAtencion
			AND CM_CA_TransaccionDetalle.IdOALineaOrigen = SS_AD_OrdenAtencionDetalle.Linea
			LEFT JOIN CM_CA_Transaccion WITH(NOLOCK) ON CM_CA_Transaccion.IdTransaccion = (CASE WHEN IsNull(CM_CA_TransaccionDetalle.IdTransaccion,-99999) <> -99999 THEN CM_CA_TransaccionDetalle.IdTransaccion
			ELSE SS_AD_OrdenAtencion.IdTransaccion END)
			--ECM
			  WHERE
		
			--                  --------------FILTROS-------------  
			  IsNull(SS_AD_OrdenAtencion.TipoAtencion,1) IN (1)  /*BY JORDAN 28092021 - INC.*/
			 AND  IsNull(SS_CC_Cita.Estado,-99)  <>1 /*BY JORDAN 16092021 - INC.1571*/
			 AND (@CodigoHC is null OR IsNUll(SS_GE_Paciente.CodigoHC,'-99') = @CodigoHC)    
					AND (@CodigoHCAnterior is null OR IsNull(SS_GE_Paciente.CodigoHCAnterior,'-99') = @CodigoHCAnterior)  
					AND (@TipoOrdenAtencion is null OR IsNull(SS_AD_OrdenAtencion.TipoOrdenAtencion,-99) = @TipoOrdenAtencion)  
					AND (@PacienteNombre is null  OR @PacienteNombre =''  OR  upper(PACIENTE.NombreCompleto) like '%'+upper(@PacienteNombre)+'%')                                
					AND (@CodigoOA is  null OR  upper(SS_AD_OrdenAtencion.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
					AND (IsNull(SS_CC_Cita.FechaCita, '2000-01-01 00:00:000.001') >=  @FechaInicio)    
					AND (IsNull(SS_CC_Cita.FechaCita, '2000-01-01 00:00:000.001') < @FechaFin)  
					AND (@IdPaciente is null OR  @IdPaciente = 0 or  IsNUll(SS_GE_Paciente.IdPaciente,-99) = @IdPaciente)  
			 --AND IsNull( SS_CC_Cita.UnidadReplicacion, '-99') = @Sucursal
				 and (@IdEspecialidad is null OR IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, IsNull(SS_CC_HORARIO.IdEspecialidad,-99)) =@IdEspecialidad)
			 and  isNull(CM_CA_Transaccion.EstadoDocumento,10) <> 9 --ECM
			 and (case when IsNull(SS_CE_ConsultaExterna.Medico,-99) = -99 AND IsNUll(SS_PR_Procedimiento.Medico,-99) = -99 then IsNull(SS_CC_Horario.Medico,-99)
								   else (case when IsNull(SS_CE_ConsultaExterna.Medico,-99) = -99 then SS_PR_Procedimiento.Medico
					else SS_CE_ConsultaExterna.Medico
			end)
			   end) = @IdMedico  

			PRINT 'LLEGO 1'

			SELECT @CONTADOR = COUNT(*) FROM @TABLA_ATENCIONPACIENTE_GENERAL_TEMP

			PRINT @CONTADOR

			IF @CONTADOR > 0
				BEGIN
			SELECT CONVERT(int,ROW_NUMBER() OVER (ORDER BY FechaInicio  ASC ) )AS NumeroFila ,
			tipoListado= CASE	WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion = 0
																then 'Pendiente'
											WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion= 1 
																then 'Programado'
											WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion = 2 
																then 'En Atención'
											WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion = 3 
																then 'Atendido'
											WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion = 4 
																then 'Anulado'
											WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion = 5 
																then 'Terminado'
											WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion = 8 
																then 'Atendido RS'																
											ELSE '' END,CitaTipo,CitaFecha,CitaHora,Origen,NombreEspecialidad,TipoPacienteNombre,VW_ATENCIONPACIENTE_GENERAL.CodigoOA,            
						FechaInicio,Cama,TipoOrdenAtencionNombre,CodigoHC,CodigoHCAnterior,
						PacienteNombre,MedicoNombre,VW_ATENCIONPACIENTE_GENERAL.IdOrdenAtencion,VW_ATENCIONPACIENTE_GENERAL.LineaOrdenAtencion,IdHospitalizacion,
						LineaHospitalizacion,IdConsultaExterna,VW_ATENCIONPACIENTE_GENERAL.IdProcedimiento,Modalidad,IndicadorSeguro,
						IdCita,        
						VW_ATENCIONPACIENTE_GENERAL.IdPaciente,TipoPaciente,VW_ATENCIONPACIENTE_GENERAL.TipoAtencion,VW_ATENCIONPACIENTE_GENERAL.IdEspecialidad,IdEmpresaAseguradora,
						VW_ATENCIONPACIENTE_GENERAL.TipoOrdenAtencion,Componente,ComponenteNombre,Compania,Sucursal,
						IdMedico,IndicadorCirugia,IndicadorExamenPrincipal,        
						PersonaAnt,sexo,FechaNacimiento,EstadoCivil,NivelInstruccion,
						Direccion,TipoDocumento,Documento,ApellidoPaterno,ApellidoMaterno,
						Nombres,LugarNacimiento,CodigoPostal,Provincia,Departamento,
						Telefono,CorreoElectronico,EsPaciente,EsEmpresa,Pais,
						EstadoPersona, FechaCierreEpiClinico ,EstadoEpiClinico,VW_ATENCIONPACIENTE_GENERAL.UnidadReplicacion,VW_ATENCIONPACIENTE_GENERAL.UnidadReplicacionEC,
						IsNUll( CASE WHEN VW_ATENCIONPACIENTE_GENERAL.IdOrdenAtencion=0 THEN VW_ATENCIONPACIENTE_GENERAL.IdEpisodioAtencion ELSE XX.IdEpisodioAtencion END,VW_ATENCIONPACIENTE_GENERAL.IdEpisodioAtencion) IdEpisodioAtencion,
						IsNUll( CASE WHEN VW_ATENCIONPACIENTE_GENERAL.IdOrdenAtencion=0 THEN VW_ATENCIONPACIENTE_GENERAL.EpisodioClinico ELSE XX.EpisodioClinico END,VW_ATENCIONPACIENTE_GENERAL.EpisodioClinico)  EpisodioClinico,
						VW_ATENCIONPACIENTE_GENERAL.IdEstablecimientoSalud,VW_ATENCIONPACIENTE_GENERAL.IdUnidadServicio,VW_ATENCIONPACIENTE_GENERAL.IdPersonalSalud,
						IsNUll( CASE WHEN VW_ATENCIONPACIENTE_GENERAL.IdOrdenAtencion=0 THEN VW_ATENCIONPACIENTE_GENERAL.EpisodioAtencion ELSE XX.EpisodioAtencion END,VW_ATENCIONPACIENTE_GENERAL.EpisodioAtencion)  EpisodioAtencion,
						
						VW_ATENCIONPACIENTE_GENERAL.FechaRegistro,VW_ATENCIONPACIENTE_GENERAL.FechaAtencion,
							IsNUll( CASE WHEN XX.Estado=4 THEN XX.Estado ELSE VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion END,VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion)  EstadoEpiAtencion,
						VW_ATENCIONPACIENTE_GENERAL.UsuarioCreacion,VW_ATENCIONPACIENTE_GENERAL.UsuarioModificacion,VW_ATENCIONPACIENTE_GENERAL.FechaCreacion,
						 VW_ATENCIONPACIENTE_GENERAL.FechaModificacion,VW_ATENCIONPACIENTE_GENERAL.Accion,VW_ATENCIONPACIENTE_GENERAL.Version   ,FechaFin,
						VW_ATENCIONPACIENTE_GENERAL.FechaOrden,Comentarios,Observaciones,Diagnostico, UnidadReplicacionHCE,IdPacienteHCE,
						EpisodioClinicoHCE,IdEpisodioAtencionHCE,SecuenciaHCE,  CodigoEpisodioClinico,
						CONTADOR                                                    
						FROM @TABLA_ATENCIONPACIENTE_GENERAL_TEMP as VW_ATENCIONPACIENTE_GENERAL  
						LEFT JOIN  WEB_ERPSALUD.DBO.SS_HC_EpisodioAtencion XX ON VW_ATENCIONPACIENTE_GENERAL.IdOrdenAtencion = XX.IdOrdenAtencion AND VW_ATENCIONPACIENTE_GENERAL.LineaOrdenAtencion=XX.LineaOrdenAtencion AND XX.IdOrdenAtencion>0
						WHERE 
						   (@EstadoEpiAtencion is null OR  @EstadoEpiAtencion = 0 or  IsNUll(EstadoEpiAtencion,-99) = @EstadoEpiAtencion)  
						   ORDER BY tipoListado,CitaFecha,CitaHora
				END

				ELSE
				BEGIN
					SELECT * FROM @TABLA_ATENCIONPACIENTE_GENERAL_TEMP
				END
			-- PRINT 'LLEGO 2'

 
 
END

GO

CREATE OR ALTER PROCEDURE  [dbo].[SS_HC_ATENCIONES_SOA_AMBULATORIO_HOY]
(
       @tipoListado			varchar(50) ,
       @CitaTipo			varchar(20) ,
       @CitaFecha			datetime,
       @Origen				varchar(20) ,
       @NombreEspecialidad	varchar(80) ,       
       @TipoPacienteNombre	varchar(80) ,
       @CodigoOA			varchar(25) ,
       @Cama				varchar(150) ,
       @TipoOrdenAtencionNombre          varchar(250) ,
       @CodigoHC			varchar(15) ,       
       @PacienteNombre      varchar(100) ,
       @MedicoNombre		varchar(100) ,
       @IdOrdenAtencion     int ,
       @LineaOrdenAtencion  int ,
       @IdHospitalizacion   int ,       
       @IdCita             int ,
       @IdPaciente         int,
       @TipoPaciente       int,
       @TipoAtencion       int,
       @IdEspecialidad     int,
       
       @IdMedico           int,
       @TipoOrdenAtencion  int,
       @Componente         varchar(25),
       @Compania           varchar(15),
       @Sucursal           varchar(15),
       
       @EstadoPersona             varchar(2),
       @EstadoEpiClinico          int,
       @UnidadReplicacion         varchar(4),
       @UnidadReplicacionEC       varchar(4),
       @IdEpisodioAtencion        bigint,
       
       @EpisodioClinico           int,
       @IdEstablecimientoSalud    int,
       @IdUnidadServicio          int,
       @IdPersonalSalud           int,
       @EpisodioAtencion          bigint,
       @FechaRegistro             datetime,
       @FechaAtencion             datetime,
       @EstadoEpiAtencion         int,
       @FechaInicio				  datetime,
       @FechaFin				  datetime,
       @UsuarioCreacion           varchar(50),
       @FechaCreacion			  datetime ,
       @UsuarioModificacion       varchar(50) , -- Nombre del COMPONENTE TECNOLOGO
       @FechaModificacion		  datetime ,          
       @Version					  varchar(50) ,
       @CodigoHCAnterior		  varchar(15) ,
       @IndicadorCirugia		  int,  
       @IndicadorExamenPrincipal  int,  
       @IndicadorSeguro			  int,  
       @Modalidad				  int,  
       @sexo					  char(1),    
       @EstadoCivil char(1),    
       @NivelInstruccion char(3),    
       @EsPaciente varchar(1),  
       @EsEmpresa varchar(1), 
       @Inicio int ,  
       @NumeroFilas int ,  
       @ACCION varchar(25)
                   
)

--WITH RECOMPILE
AS
BEGIN

       DECLARE @CONTADOR INT                          
       DECLARE @ACCION_END varchar(50)=null    
       /****TABLA TEMPORAL NOMBRE DE LA VISTA  : VW_ATENCIONPACIENTE_GENERAL*******/
       /***************************************************************************/

  DECLARE @TABLA_ATENCIONPACIENTE_GENERAL_TEMP table
      (
            --SECUENCIA             int  NOT NULL   IDENTITY PRIMARY KEY,
            NumeroFila  int   null
      ,     tipoListado varchar(30) null
      ,     CitaTipo    varchar(9)  null
      ,     CitaFecha   datetime    null
      ,     CitaHora    datetime    null
      ,     Origen      varchar(20) null
      ,     NombreEspecialidad      varchar(80) null
      ,     TipoPacienteNombre      varchar(80) null
      ,     CodigoOA    varchar(25) null
      ,     FechaInicio datetime    null
      ,     Cama  varchar(150)      null
      ,     TipoOrdenAtencionNombre varchar(80) null
      ,     CodigoHC    varchar(15) null
      ,     CodigoHCAnterior  varchar(15) null
      ,     PacienteNombre    varchar(100)      null
      ,     MedicoNombre      varchar(100)      null
      ,     IdOrdenAtencion   int   null
      ,     LineaOrdenAtencion      int   null
      ,     IdHospitalizacion int   null
      ,     LineaHospitalizacion    int   null
      ,     IdConsultaExterna int   null
      ,     IdProcedimiento   int   null
      ,     Modalidad   int   null
      ,     IndicadorSeguro   int   null
      ,     IdCita      int   null
      ,     IdPaciente  int   null
      ,     TipoPaciente      int   null
      ,     TipoAtencion      int   null
      ,     IdEspecialidad    int   null
      ,     IdEmpresaAseguradora    int   null
      ,     TipoOrdenAtencion int   null
      ,     Componente  varchar(25) null
      ,     ComponenteNombre  varchar(250)      null
      ,     Compania    varchar(15) null
      ,     Sucursal    varchar(15) null
      ,     IdMedico    int   null
      ,     IndicadorCirugia  int   null
      ,     IndicadorExamenPrincipal     int   null
      ,     PersonaAnt  char(15)    null
      ,     sexo  char(1)     null
      ,     FechaNacimiento   datetime    null
      ,     EstadoCivil char(1)     null
      ,     NivelInstruccion  char(3)     null
      ,     Direccion   varchar(190)      null
      ,     TipoDocumento     char(1)     null
      ,     Documento   char(20)    null
      ,     ApellidoPaterno   varchar(40) null
      ,     ApellidoMaterno   varchar(40) null
      ,     Nombres     varchar(40) null
      ,     LugarNacimiento   varchar(255)      null
      ,     CodigoPostal      char(3)     null
      ,     Provincia   char(3)     null
      ,     Departamento      char(3)     null
      ,     Telefono    varchar(15) null
      ,     CorreoElectronico varchar(50) null
      ,     EsPaciente  varchar(1)  null
      ,     EsEmpresa   varchar(1)  null
      ,     Pais  varchar(100)     null
      ,     EstadoPersona     char(1)     null
      ,     FechaCierreEpiClinico   datetime    null
      ,     EstadoEpiClinico  int   null
      ,     UnidadReplicacion char(4)     null
      ,     UnidadReplicacionEC     char(4)     null
      ,     IdEpisodioAtencion      bigint      null
      ,     EpisodioClinico   int   null
      ,     IdEstablecimientoSalud  int   null
      ,     IdUnidadServicio  int   null
      ,     IdPersonalSalud   int   null
      ,     EpisodioAtencion  int   null
      ,     FechaRegistro     datetime    null
      ,     FechaAtencion     datetime    null
      ,     EstadoEpiAtencion int   null
      ,     UsuarioCreacion   varchar(25) null
      ,     UsuarioModificacion     varchar(25) null
      ,     FechaCreacion     datetime    null
      ,     FechaModificacion datetime    null
      ,     Accion      varchar(25) null
      ,     Version     varchar(25) null
      ,     FechaFin    datetime    null
      ,     FechaOrden  datetime    null
      ,     Comentarios INT null -- varchar(300)      null
      ,     Observaciones INT null -- varchar(300)      null  
      ,     Diagnostico INT null -- varchar(300)      null
      -------------
      ,     UnidadReplicacionHCE    varchar(4)  null
      ,     IdPacienteHCE     int   null
      ,     EpisodioClinicoHCE      int   null
      ,     IdEpisodioAtencionHCE   bigint      null
      ,     SecuenciaHCE      int   null
      ,     CodigoEpisodioClinico   int   null  
      -------------
      ,     Contador    int   null                                          
      )
     
       /*****************************LISTADOS PRINCIPALES***************************************/          

			  DECLARE @fechaPeticion datetime
			  SET @fechaPeticion  = GETDATE()
			  SET @FechaFin = DATEADD(DAY,1,@FechaFin)

 
            /**AMBULATORIO*/
            /*********************CONSULTAS*******************************************************
            1. Necesidad de identificar las prestaciones asociadas a un medico
            2. Como va a el manejo de las ordenes de spring salud y los episodios de atención
            3. Identificar los estado de visualización (no visualizamos anulados?)
            *************************************************************************/        /*BY ORLANDO 03032017*/

 
		  insert into @TABLA_ATENCIONPACIENTE_GENERAL_TEMP
		(tipoListado,CitaTipo,CitaFecha,CitaHora,Origen,NombreEspecialidad,TipoPacienteNombre,CodigoOA,
		----------
		  Cama, FechaInicio,TipoOrdenAtencionNombre,CodigoHC,CodigoHCAnterior,
		PacienteNombre,MedicoNombre,IdOrdenAtencion,LineaOrdenAtencion,IdHospitalizacion,
		LineaHospitalizacion,IdConsultaExterna,IdProcedimiento,Modalidad,IndicadorSeguro,
		IdCita,FechaFin,
		----------
		IdPaciente,TipoPaciente,TipoAtencion,IdEspecialidad,IdEmpresaAseguradora,
		TipoOrdenAtencion,Componente,ComponenteNombre,Compania,Sucursal,
		IdMedico,IndicadorCirugia,IndicadorExamenPrincipal,
		---------
		UnidadReplicacionHCE,EstadoEpiAtencion,EpisodioClinicoHCE,IdEpisodioAtencionHCE,IdPacienteHCE,SecuenciaHCE,
		------------
		PersonaAnt,sexo,FechaNacimiento,EstadoCivil,NivelInstruccion,
		Direccion,TipoDocumento,Documento,ApellidoPaterno,ApellidoMaterno,
		Nombres,LugarNacimiento,CodigoPostal,Provincia,Departamento,
		Telefono,CorreoElectronico,EsPaciente,EsEmpresa,Pais,
		EstadoPersona,UnidadReplicacionEC,Version,FechaCierreEpiClinico,Contador
		)

SELECT --top 50
                  'MED_AMBULATORIO' as tipoListado,
                  ---------7
                  CitaTipo = (CASE SS_CC_Cita.TipoCita WHEN 1 THEN 'Normal' WHEN 4 THEN 'Adicional' ELSE 'Extra' END),
                  CitaFecha = SS_CC_Cita.FechaCita,
                  CitaHora = SS_CC_Cita.FechaCita,
                  Origen = (CASE WHEN SS_AD_OrdenAtencion.IdOrdenAtencion IS NULL THEN 'Cita' ELSE CASE WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 11) THEN 'Consulta' ELSE 'Procedimiento' END END),
                  NombreEspecialidad = SS_GE_Especialidad.Nombre,
                  TipoPacienteNombre = TipoPaciente.Nombre,
                  ISNULL(SS_AD_OrdenAtencion.CodigoOA,'') AS CodigoOA,
                  ----------
                  LEFT(SS_CC_Cita.Comentario, 150) as Cama,
				  ISNULL(SS_AD_OrdenAtencion.FechaInicio,SS_CC_Cita.FechaCita) FechaInicio ,
                  TipoOrdenAtencionNombre = ISNULL(TipoOrdenAtencion.Nombre  , 'Consulta'),
                  SS_GE_Paciente.CodigoHC,
                  SS_GE_Paciente.CodigoHCAnterior,
                  PacienteNombre = paciente.NombreCompleto,
                  --NOMBRE DE MEDICO MEDICO.Busqueda
                  MEDICO.Busqueda as MedicoNombre,
                  IsNull(SS_AD_OrdenAtencion.IdOrdenAtencion,0) AS IdOrdenAtencion,
                  IsNull(SS_AD_OrdenAtencionDetalle.Linea,0) AS LineaOrdenAtencion ,
                  IsNull(SS_AD_OrdenAtencion.IdContrato,0) as IdHospitalizacion,
                  0 AS LineaHospitalizacion ,
                  SS_CE_ConsultaExterna.IdConsultaExterna,
                  SS_PR_Procedimiento.IdProcedimiento,
                  case
					when SS_AD_OrdenAtencion.TipoPaciente='19' then '19'
					when SS_AD_OrdenAtencion.TipoPaciente='4' then '4'
					when SS_AD_OrdenAtencion.modalidad='1' then '1'
					when  SS_AD_OrdenAtencion.modalidad='2' then '2'
					else
					SS_AD_OrdenAtencion.tipopaciente
					end as Modalidad,

                  IndicadorSeguro = (     SELECT IsNull(CM_CO_TablaMaestroDetalleConcepto.IndicadorConcepto,1)
                                               FROM CM_CO_TablaMaestroDetalleConcepto WITH(NOLOCK)
												INNER JOIN CM_CO_TablaMaestroConcepto WITH(NOLOCK) ON CM_CO_TablaMaestroConcepto.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
                                                     AND CM_CO_TablaMaestroConcepto.IdConcepto = CM_CO_TablaMaestroDetalleConcepto.IdConcepto
                                                     AND CM_CO_TablaMaestroConcepto.Concepto = 'APLICA_SEGURO'
                                               WHERE IsNull(TipoPaciente.IdTablaMaestro,-99) = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
                                                     AND IsNull(TipoPaciente.IdCodigo,-99) = CM_CO_TablaMaestroDetalleConcepto.IdCodigo),

                  SS_CC_Cita.IdCita,
                  SS_AD_OrdenAtencion.FechaFinal as FechaFin,
                  ---------------------   11
                  SS_GE_Paciente.IdPaciente,
                  SS_AD_OrdenAtencion.TipoPaciente,
                  SS_AD_OrdenAtencion.TipoAtencion,
                  IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_CC_HORARIO.IdEspecialidad),
                  SS_AD_OrdenAtencion.IdEmpresaAseguradora,
                  SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion,
                  SS_AD_OrdenAtencionDetalle.Componente,
                  ComponenteNombre = CM_CO_Componente.Nombre,
                   IsNull( SS_AD_OrdenAtencion.Compania ,'00000000') AS Compania,
                   case when SS_AD_OrdenAtencion.Sucursal is null then 'LIMA' ELSE  SS_AD_OrdenAtencion.Sucursal END  AS Sucursal,
                  IdMedico = IsNull(IsNull(SS_CE_ConsultaExterna.Medico, SS_PR_Procedimiento.Medico), SS_CC_Horario.Medico),
                  ------------------------
                  0 as IndicadorCirugia,
                  0 as IndicadorExamenPrincipal,
                  ---------------------------ADD ORIGEN HCE --OBS                  
                  case when SS_AD_OrdenAtencion.Sucursal is null then 'LIMA' ELSE  SS_AD_OrdenAtencion.Sucursal END  AS UnidadReplicacionHCE,

				CASE	WHEN  SS_AD_OrdenAtencion.IdOrdenAtencion IS NULL 
					THEN 1 --PROGRAMADO
				ELSE
					CASE	WHEN  SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 11, 21 ) 
						THEN	CASE	WHEN  IsNull(SS_CE_ConsultaExterna.IdConsultaExterna,0) > 0 
											THEN	CASE															
														WHEN SS_CE_ConsultaExterna.EstadoDocumento = 1 
																--then 0 PENDIENTE	
															THEN	CASE	WHEN SS_CC_CITA.EstadoDocumento = 4 
																		THEN 2 --EN ATENCION
																	ELSE 
																		 0 --PENDIENTE	
																	END
														WHEN SS_CE_ConsultaExterna.EstadoDocumento = 2 
																then 3 --ATENDIDO	
														WHEN SS_CE_ConsultaExterna.EstadoDocumento = 3 
																then 4 --ANULADO
														ELSE 0 
													END
										ELSE	CASE	WHEN ss_cc_cita.estadodocumento = 2 
															then 1 --PROGRAMADO
														WHEN ss_cc_cita.estadodocumento = 3 
															then 0 --PENDIENTE
														WHEN SS_CC_CITA.EstadoDocumento = 4 
															then 2 --EN ATENCION
														WHEN SS_CC_CITA.EstadoDocumento = 8 
															then 3 --ATENDIDO
														WHEN SS_CC_CITA.EstadoDocumento = 5 
															then 4 --ANULADO
														ELSE 0 
												END
								END

					WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (  2, 4, 5, 6, 7, 8, 9, 10, 12, 14,16, 17, 18, 19,20,24, 25, 26, 27, 23, 15, 33, 34, 37, 38, 39, 29, 30, 31, 32, 28 ) 
						THEN	CASE	WHEN IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) = -99 AND SS_CC_Cita.EstadoDocumento = 3 
											THEN 0
										WHEN IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) = -99 AND SS_CC_Cita.EstadoDocumento = 2 
											THEN 1
										WHEN IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) = -99 AND SS_CC_Cita.EstadoDocumento = 8 
											THEN 0
										WHEN IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) = -99 AND SS_CC_Cita.EstadoDocumento = 4 
											THEN 0
										WHEN SS_CC_Cita.EstadoDocumento = 4  AND SS_PR_Procedimiento.EstadoDocumento = 3 
											THEN 4 --ANULADO
										WHEN IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) <> -99 AND SS_PR_Procedimiento.EstadoDocumento = 2 
											THEN 3
										WHEN IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) <> -99 AND SS_PR_Procedimiento.EstadoDocumento = 4 
											THEN 5  --TERMINADO
										WHEN IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) <> -99 AND SS_PR_Procedimiento.EstadoDocumento = 1 
											THEN 2
										ELSE -99
								END  
							ELSE ss_cc_cita.estadodocumento
					END  
				END AS EstadoEpiAtencion,                        
                 NULL AS  EpisodioClinicoHCE,
                 NULL AS IDEPISODIOAtencionHCE,
                 NULL AS IdPacienteHCE,
                 NULL AS SecuencialHCE,            
                  ---------------------------  
                  PACIENTE.PersonaAnt,
                  PACIENTE.sexo,
                  PACIENTE.FechaNacimiento,
                 ISNULL(PACIENTE.EstadoCivil,'')EstadoCivil,
                  PACIENTE.NivelInstruccion,
                  replace( LEFT(PACIENTE.Direccion, 190) ,'&#','') as Direccion,
                  PACIENTE.TipoDocumento,
                  PACIENTE.Documento,
                  PACIENTE.ApellidoPaterno,
                  PACIENTE.ApellidoMaterno,
                  PACIENTE.Nombres,
                  PACIENTE.LugarNacimiento,
                  PACIENTE.CodigoPostal,
                  PACIENTE.Provincia,
                  PACIENTE.Departamento,
                  PACIENTE.Telefono,
                  PACIENTE.CorreoElectronico,
                  PACIENTE.EsPaciente,
                  PACIENTE.EsEmpresa,
                  PACIENTE.Pais,
                  PACIENTE.Estado as EstadoPersona,				 
                  case when PACIENTE.Origen  is null then 'LIMA' ELSE  PACIENTE.Origen  END AS  UnidadReplicacionEC,               
				  CASE WHEN SS_AD_OrdenAtencion.IdOrdenAtencion IS NULL THEN 'Ambulatoria' ELSE TipoAtencion.Nombre END  as TipoAtencionDescX,
				   CM_CA_Transaccion.FechaPago FechaCierreEpiClinico,
				0 AS ContadorX
				FROM SS_CC_Cita  WITH(NOLOCK)
				LEFT JOIN SS_CC_Horario  WITH(NOLOCK) ON SS_CC_Horario.IdHorario = SS_CC_Cita.IdHorario  
				LEFT JOIN SS_AD_OrdenAtencionDetalle  WITH(NOLOCK) ON SS_CC_Cita.IdCita = SS_AD_OrdenAtencionDetalle.IdCita  
				LEFT JOIN SS_AD_OrdenAtencion  WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_AD_OrdenAtencion.IdOrdenAtencion  
				LEFT JOIN SS_CE_ConsultaExterna WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_CE_ConsultaExterna.IdOrdenAtencion  
				AND SS_AD_OrdenAtencionDetalle.Linea = SS_CE_ConsultaExterna.LineaOrdenAtencion  
				LEFT JOIN GE_EstadoDocumento WITH(NOLOCK) ON GE_EstadoDocumento.IdEstado = ISNULL(SS_CE_ConsultaExterna.EstadoDocumento, 1)  
				AND GE_EstadoDocumento.IdDocumento = 47
				LEFT JOIN SS_GE_Paciente  WITH(NOLOCK) ON SS_GE_Paciente.IdPaciente = SS_CC_Cita.IdPaciente  
				LEFT JOIN PersonaMast AS Paciente WITH(NOLOCK) ON Paciente.Persona = SS_GE_Paciente.IdPaciente
				LEFT JOIN PERSONAMAST AS MEDICO WITH(NOLOCK) ON SS_CC_CITA.IdMedico=MEDICO.PERSONA  
				LEFT JOIN SS_PR_Procedimiento WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_PR_Procedimiento.IdOrdenAtencion
                        AND SS_AD_OrdenAtencionDetalle.Linea = SS_PR_Procedimiento.LineaOrdenAtencion
                 LEFT JOIN SS_GE_Especialidad WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_CC_HORARIO.IdEspecialidad)
                 LEFT JOIN CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK) ON TipoPaciente.IdTablaMaestro = 106
                        AND TipoPaciente.IdCodigo = IsNull(SS_AD_OrdenAtencion.TipoPaciente,-99)
                 LEFT JOIN CM_CO_TablaMaestroDetalle TipoOrdenAtencion WITH(NOLOCK) ON TipoOrdenAtencion.IdTablaMaestro = 101
                        AND TipoOrdenAtencion.IdCodigo = SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion
                 LEFT JOIN CM_CO_Componente WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.Componente = CM_CO_Componente.CodigoComponente  
                  --------------
                 LEFT JOIN SS_GE_TipoAtencion TipoAtencion WITH(NOLOCK)  ON (TipoAtencion.IdTipoAtencion = SS_AD_OrdenAtencion.TipoAtencion)                      
			   --ECM
			LEFT JOIN CM_CA_TransaccionDetalle WITH(NOLOCK) ON CM_CA_TransaccionDetalle.IdOAOrigen = SS_AD_OrdenAtencionDetalle.IdOrdenAtencion
			AND CM_CA_TransaccionDetalle.IdOALineaOrigen = SS_AD_OrdenAtencionDetalle.Linea
			LEFT JOIN CM_CA_Transaccion WITH(NOLOCK) ON CM_CA_Transaccion.IdTransaccion = (CASE WHEN IsNull(CM_CA_TransaccionDetalle.IdTransaccion,-99999) <> -99999 THEN CM_CA_TransaccionDetalle.IdTransaccion
			ELSE SS_AD_OrdenAtencion.IdTransaccion END)
			--ECM
							  WHERE
			--                  --------------FILTROS-------------  
			  IsNull(SS_AD_OrdenAtencion.TipoAtencion,1) IN (1)  /*BY JORDAN 28092021 - INC.*/
			AND  IsNull(SS_CC_Cita.Estado,-99)  <>1 /*BY JORDAN 16092021 - INC.1571*/
			AND (IsNull(SS_CC_Cita.FechaCita, '2000-01-01 00:00:000.001') >=  @FechaInicio)    
			AND (IsNull(SS_CC_Cita.FechaCita, '2000-01-01 00:00:000.001') < @FechaFin)  
			and  isNull(CM_CA_Transaccion.EstadoDocumento,10) <> 9 --ECM
			and (case when IsNull(SS_CE_ConsultaExterna.Medico,-99) = -99 AND IsNUll(SS_PR_Procedimiento.Medico,-99) = -99 then IsNull(SS_CC_Horario.Medico,-99)
								   else (case when IsNull(SS_CE_ConsultaExterna.Medico,-99) = -99 then SS_PR_Procedimiento.Medico
					else SS_CE_ConsultaExterna.Medico
			end)
			   end) = @IdMedico  


                          
			SELECT CONVERT(int,ROW_NUMBER() OVER (ORDER BY FechaInicio  ASC ) )AS NumeroFila ,
			tipoListado= CASE	WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion = 0
																then 'Pendiente'
											WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion= 1 
																then 'Programado'
											WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion = 2 
																then 'En Atención'
											WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion = 3 
																then 'Atendido'
											WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion = 4 
																then 'Anulado'
											WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion = 5 
																then 'Terminado'
											WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion = 8 
																then 'Atendido RS'																
											ELSE '' END,CitaTipo,CitaFecha,CitaHora,Origen,NombreEspecialidad,TipoPacienteNombre,VW_ATENCIONPACIENTE_GENERAL.CodigoOA,            
						FechaInicio,Cama,TipoOrdenAtencionNombre,CodigoHC,CodigoHCAnterior,
						PacienteNombre,MedicoNombre,VW_ATENCIONPACIENTE_GENERAL.IdOrdenAtencion,VW_ATENCIONPACIENTE_GENERAL.LineaOrdenAtencion,IdHospitalizacion,
						LineaHospitalizacion,IdConsultaExterna,VW_ATENCIONPACIENTE_GENERAL.IdProcedimiento,Modalidad,IndicadorSeguro,
						IdCita,        
						VW_ATENCIONPACIENTE_GENERAL.IdPaciente,TipoPaciente,VW_ATENCIONPACIENTE_GENERAL.TipoAtencion,VW_ATENCIONPACIENTE_GENERAL.IdEspecialidad,IdEmpresaAseguradora,
						VW_ATENCIONPACIENTE_GENERAL.TipoOrdenAtencion,Componente,ComponenteNombre,Compania,Sucursal,
						IdMedico,IndicadorCirugia,IndicadorExamenPrincipal,        
						PersonaAnt,sexo,FechaNacimiento,EstadoCivil,NivelInstruccion,
						Direccion,TipoDocumento,Documento,ApellidoPaterno,ApellidoMaterno,
						Nombres,LugarNacimiento,CodigoPostal,Provincia,Departamento,
						Telefono,CorreoElectronico,EsPaciente,EsEmpresa,Pais,
						EstadoPersona, FechaCierreEpiClinico ,EstadoEpiClinico,VW_ATENCIONPACIENTE_GENERAL.UnidadReplicacion,VW_ATENCIONPACIENTE_GENERAL.UnidadReplicacionEC,
						CASE WHEN VW_ATENCIONPACIENTE_GENERAL.IdOrdenAtencion=0 THEN VW_ATENCIONPACIENTE_GENERAL.IdEpisodioAtencion ELSE XX.IdEpisodioAtencion END IdEpisodioAtencion,
						CASE WHEN VW_ATENCIONPACIENTE_GENERAL.IdOrdenAtencion=0 THEN VW_ATENCIONPACIENTE_GENERAL.EpisodioClinico ELSE XX.EpisodioClinico END EpisodioClinico,
						VW_ATENCIONPACIENTE_GENERAL.IdEstablecimientoSalud,VW_ATENCIONPACIENTE_GENERAL.IdUnidadServicio,VW_ATENCIONPACIENTE_GENERAL.IdPersonalSalud,
						CASE WHEN VW_ATENCIONPACIENTE_GENERAL.IdOrdenAtencion=0 THEN VW_ATENCIONPACIENTE_GENERAL.EpisodioAtencion ELSE XX.EpisodioAtencion END  EpisodioAtencion,
						
						VW_ATENCIONPACIENTE_GENERAL.FechaRegistro,VW_ATENCIONPACIENTE_GENERAL.FechaAtencion,
							CASE WHEN XX.Estado=4 THEN XX.Estado ELSE VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion END  EstadoEpiAtencion,
						VW_ATENCIONPACIENTE_GENERAL.UsuarioCreacion,VW_ATENCIONPACIENTE_GENERAL.UsuarioModificacion,VW_ATENCIONPACIENTE_GENERAL.FechaCreacion,
						 VW_ATENCIONPACIENTE_GENERAL.FechaModificacion,VW_ATENCIONPACIENTE_GENERAL.Accion,VW_ATENCIONPACIENTE_GENERAL.Version   ,FechaFin,
						VW_ATENCIONPACIENTE_GENERAL.FechaOrden,Comentarios,Observaciones,Diagnostico, UnidadReplicacionHCE,IdPacienteHCE,
						EpisodioClinicoHCE,IdEpisodioAtencionHCE,SecuenciaHCE,  CodigoEpisodioClinico,
						CONTADOR                                                    
						FROM @TABLA_ATENCIONPACIENTE_GENERAL_TEMP as VW_ATENCIONPACIENTE_GENERAL  
						LEFT JOIN  WEB_ERPSALUD.DBO.SS_HC_EpisodioAtencion XX ON VW_ATENCIONPACIENTE_GENERAL.IdOrdenAtencion = XX.IdOrdenAtencion AND VW_ATENCIONPACIENTE_GENERAL.LineaOrdenAtencion=XX.LineaOrdenAtencion
						WHERE 
						   (@EstadoEpiAtencion is null OR  @EstadoEpiAtencion = 0 or  IsNUll(EstadoEpiAtencion,-99) = @EstadoEpiAtencion)  
						   ORDER BY tipoListado,CitaFecha,CitaHora
 
END

GO

CREATE OR ALTER PROCEDURE  [dbo].[SS_HC_ATENCIONES_SOA_EMERGENCIA2]
(
       @tipoListado			varchar(50) ,
       @CitaTipo			varchar(20) ,
       @CitaFecha			datetime,
       @Origen				varchar(20) ,
       @NombreEspecialidad	varchar(80) ,       
       @TipoPacienteNombre	varchar(80) ,
       @CodigoOA			varchar(25) ,
       @Cama				varchar(150) ,
       @TipoOrdenAtencionNombre          varchar(250) ,
       @CodigoHC			varchar(15) ,       
       @PacienteNombre      varchar(100) ,
       @MedicoNombre		varchar(100) ,
       @IdOrdenAtencion     int ,
       @LineaOrdenAtencion  int ,
       @IdHospitalizacion   int ,       
       @IdCita             int ,
       @IdPaciente         int,
       @TipoPaciente       int,
       @TipoAtencion       int,
       @IdEspecialidad     int,
       
       @IdMedico           int,
       @TipoOrdenAtencion  int,
       @Componente         varchar(25),
       @Compania           varchar(15),
       @Sucursal           varchar(15),
       
       @EstadoPersona             varchar(2),
       @EstadoEpiClinico          int,
       @UnidadReplicacion         varchar(4),
       @UnidadReplicacionEC       varchar(4),
       @IdEpisodioAtencion        bigint,
       
       @EpisodioClinico           int,
       @IdEstablecimientoSalud    int,
       @IdUnidadServicio          int,
       @IdPersonalSalud           int,
       @EpisodioAtencion          bigint,
       @FechaRegistro             datetime,
       @FechaAtencion             datetime,
       @EstadoEpiAtencion         int,
       @FechaInicio				  datetime,
       @FechaFin				  datetime,
       @UsuarioCreacion           varchar(50),
       @FechaCreacion			  datetime ,
       @UsuarioModificacion       varchar(50) , -- Nombre del COMPONENTE TECNOLOGO
       @FechaModificacion		  datetime ,          
       @Version					  varchar(50) ,
       @CodigoHCAnterior		  varchar(15) ,
       @IndicadorCirugia		  int,  
       @IndicadorExamenPrincipal  int,  
       @IndicadorSeguro			  int,  
       @Modalidad				  int,  
       @sexo					  char(1),    
       @EstadoCivil char(1),    
       @NivelInstruccion char(3),    
       @EsPaciente varchar(1),  
       @EsEmpresa varchar(1), 
       @Inicio int ,  
       @NumeroFilas int ,  
       @ACCION varchar(25)
                   
)

--WITH RECOMPILE
AS
BEGIN


       DECLARE @CONTADOR INT                          
       DECLARE @ACCION_END varchar(50)=null    
       /****TABLA TEMPORAL NOMBRE DE LA VISTA  : VW_ATENCIONPACIENTE_GENERAL*******/
       /***************************************************************************/

		create table #TABLA_ATENCIONPACIENTE_GENERAL_TEMP 
      (
            --SECUENCIA             int  NOT NULL   IDENTITY PRIMARY KEY,
            NumeroFila  int   null
      ,     tipoListado varchar(30) null
      ,     CitaTipo    varchar(9)  null
      ,     CitaFecha   datetime    null
      ,     CitaHora    datetime    null
      ,     Origen      varchar(20) null
      ,     NombreEspecialidad      varchar(80) null
      ,     TipoPacienteNombre      varchar(80) null
      ,     CodigoOA    varchar(25) null
      ,     FechaInicio datetime    null
      ,     Cama  varchar(150)      null
      ,     TipoOrdenAtencionNombre varchar(80) null
      ,     CodigoHC    varchar(15) null
      ,     CodigoHCAnterior  varchar(15) null
      ,     PacienteNombre    varchar(100)      null
      ,     MedicoNombre      varchar(100)      null
      ,     IdOrdenAtencion   int   null
      ,     LineaOrdenAtencion      int   null
      ,     IdHospitalizacion int   null
      ,     LineaHospitalizacion    int   null
      ,     IdConsultaExterna int   null
      ,     IdProcedimiento   int   null
      ,     Modalidad   int   null
      ,     IndicadorSeguro   int   null
      ,     IdCita      int   null
      ,     IdPaciente  int   null
      ,     TipoPaciente      int   null
      ,     TipoAtencion      int   null
      ,     IdEspecialidad    int   null
      ,     IdEmpresaAseguradora    int   null
      ,     TipoOrdenAtencion int   null
      ,     Componente  varchar(25) null
      ,     ComponenteNombre  varchar(250)      null
      ,     Compania    varchar(15) null
      ,     Sucursal    varchar(15) null
      ,     IdMedico    int   null
      ,     IndicadorCirugia  int   null
      ,     IndicadorExamenPrincipal     int   null
      ,     PersonaAnt  char(15)    null
      ,     sexo  char(1)     null
      ,     FechaNacimiento   datetime    null
      ,     EstadoCivil char(1)     null
      ,     NivelInstruccion  char(3)     null
      ,     Direccion   varchar(190)      null
      ,     TipoDocumento     char(1)     null
      ,     Documento   char(20)    null
      ,     ApellidoPaterno   varchar(40) null
      ,     ApellidoMaterno   varchar(40) null
      ,     Nombres     varchar(40) null
      ,     LugarNacimiento   varchar(255)      null
      ,     CodigoPostal      char(3)     null
      ,     Provincia   char(3)     null
      ,     Departamento      char(3)     null
      ,     Telefono    varchar(15) null
      ,     CorreoElectronico varchar(50) null
      ,     EsPaciente  varchar(1)  null
      ,     EsEmpresa   varchar(1)  null
      ,     Pais  varchar(100)     null
      ,     EstadoPersona     char(1)     null
      ,     FechaCierreEpiClinico   datetime    null
      ,     EstadoEpiClinico  int   null
      ,     UnidadReplicacion char(4)     null
      ,     UnidadReplicacionEC     char(4)     null
      ,     IdEpisodioAtencion      bigint      null
      ,     EpisodioClinico   int   null
      ,     IdEstablecimientoSalud  int   null
      ,     IdUnidadServicio  int   null
      ,     IdPersonalSalud   int   null
      ,     EpisodioAtencion  int   null
      ,     FechaRegistro     datetime    null
      ,     FechaAtencion     datetime    null
      ,     EstadoEpiAtencion int   null
      ,     UsuarioCreacion   varchar(25) null
      ,     UsuarioModificacion     varchar(25) null
      ,     FechaCreacion     datetime    null
      ,     FechaModificacion datetime    null
      ,     Accion      varchar(25) null
      ,     Version     varchar(25) null
      ,     FechaFin    datetime    null
      ,     FechaOrden  datetime    null
      ,     Comentarios INT null -- varchar(300)      null
      ,     Observaciones INT null -- varchar(300)      null  
      ,     Diagnostico INT null -- varchar(300)      null
      -------------
      ,     UnidadReplicacionHCE    varchar(4)  null
      ,     IdPacienteHCE     int   null
      ,     EpisodioClinicoHCE      int   null
      ,     IdEpisodioAtencionHCE   bigint      null
      ,     SecuenciaHCE      int   null
      ,     CodigoEpisodioClinico   int   null  
      -------------
      ,     Contador    int   null                                          
      )

		DECLARE @fechaPeticion DATETIME
		SET @fechaPeticion = GETDATE()


		create table #tipopaciente(IdTablaMaestro INT , IdCodigo INT , IndicadorConcepto INT, Nombre VARCHAR(80))

		INSERT INTO #tipopaciente(IdTablaMaestro, IdCodigo, IndicadorConcepto, Nombre)
		SELECT CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro, CM_CO_TablaMaestroDetalleConcepto.IdCodigo, 
		IsNull(CM_CO_TablaMaestroDetalleConcepto.IndicadorConcepto,1), CM_CO_TablaMaestroDetalle.Nombre
		FROm CM_CO_TablaMaestroDetalle WITH(NOLOCK)
		INNER JOIN  CM_CO_TablaMaestroDetalleConcepto WITH(NOLOCK) ON 
			CM_CO_TablaMaestroDetalle.IdCodigo = CM_CO_TablaMaestroDetalleConcepto.IdCodigo
			AND CM_CO_TablaMaestroDetalle.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
		INNER JOIN CM_CO_TablaMaestroConcepto WITH(NOLOCK) ON CM_CO_TablaMaestroConcepto.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
			AND CM_CO_TablaMaestroConcepto.IdConcepto = CM_CO_TablaMaestroDetalleConcepto.IdConcepto
			AND CM_CO_TablaMaestroConcepto.Concepto = 'APLICA_SEGURO'

  
             /**CAMBIO 01/10/2015*/
       
            /**MED_EMERGENCIA2*/
            /*********************CONSULTAS*******************************************************
            1. Necesidad de identificar las prestaciones asociadas a un medico
            2. Como va a el manejo de las ordenes de spring salud y los episodios de atención
            3. Identificar los estado de visualización (no visualizamos anulados?)
            *************************************************************************/        /*BY ORLANDO 03032017*/


             insert into #TABLA_ATENCIONPACIENTE_GENERAL_TEMP
 
              (tipoListado,CitaTipo,CitaFecha,CitaHora,Origen,NombreEspecialidad,TipoPacienteNombre,CodigoOA,
             ----------
             FechaInicio,Cama,TipoOrdenAtencionNombre,CodigoHC,CodigoHCAnterior,
             PacienteNombre,MedicoNombre,IdOrdenAtencion,LineaOrdenAtencion,IdHospitalizacion,
             LineaHospitalizacion,IdConsultaExterna,IdProcedimiento,Modalidad,IndicadorSeguro,
             IdCita,FechaFin,
             ----------
             IdPaciente,TipoPaciente,TipoAtencion,IdEspecialidad,IdEmpresaAseguradora,
             TipoOrdenAtencion,Componente,ComponenteNombre,Compania,Sucursal,
             IdMedico,IndicadorCirugia,IndicadorExamenPrincipal,
             ---------
             UnidadReplicacionHCE,EstadoEpiAtencion,EpisodioClinicoHCE,IdEpisodioAtencionHCE,IdPacienteHCE,SecuenciaHCE,
             ------------
             PersonaAnt,sexo,FechaNacimiento,EstadoCivil,NivelInstruccion,
             Direccion,TipoDocumento,Documento,ApellidoPaterno,ApellidoMaterno,
             Nombres,LugarNacimiento,CodigoPostal,Provincia,Departamento,
             Telefono,CorreoElectronico,EsPaciente,EsEmpresa,Pais,
             UnidadReplicacionEC,EstadoPersona      
             )      
                   SELECT TOP 10000
                       CASE
                        WHEN ISNULL(SS_AD_ORDENATENCIONDETALLE.TIPOORDENATENCION, 0) = 1
                             OR ISNULL(SS_AD_ORDENATENCIONDETALLE.TIPOORDENATENCION, 0) = 11
                             OR ISNULL(SS_AD_ORDENATENCIONDETALLE.TIPOORDENATENCION, 0) = 21 THEN
                               (SELECT TOP 1 ISNULL(GE_ESTADODOCUMENTO.CODIGOESTADO, 'NO REGISTRADO')
                                FROM SS_AD_ORDENATENCIONDETALLE OAD WITH(NOLOCK)
								LEFT JOIN SS_CE_CONSULTAEXTERNA WITH(NOLOCK) ON OAD.IdOrdenAtencion = SS_CE_CONSULTAEXTERNA.IdOrdenAtencion  AND OAD.Linea=SS_CE_CONSULTAEXTERNA.LineaOrdenAtencion
                               AND SS_CE_CONSULTAEXTERNA.ESTADO = 2
							   LEFT JOIN GE_ESTADODOCUMENTO WITH(NOLOCK) ON GE_ESTADODOCUMENTO.IDESTADO = SS_CE_CONSULTAEXTERNA.ESTADODOCUMENTO                               
                                  AND GE_ESTADODOCUMENTO.IDDOCUMENTO = 47
							   WHERE SS_CE_CONSULTAEXTERNA.IDORDENATENCION = SS_AD_ORDENATENCIONDETALLE.IDORDENATENCION
                                  AND SS_CE_CONSULTAEXTERNA.LINEAORDENATENCION = SS_AD_ORDENATENCIONDETALLE.LINEA
                                 )
                        ELSE
                               (SELECT TOP 1 ISNULL(GE_ESTADODOCUMENTO.CODIGOESTADO, 'NO REGISTRADO')
                                FROM SS_AD_ORDENATENCIONDETALLE OAD WITH(NOLOCK)
								LEFT JOIN SS_PR_PROCEDIMIENTO  ON OAD.IdOrdenAtencion = SS_PR_PROCEDIMIENTO.IdOrdenAtencion  AND OAD.Linea=SS_PR_PROCEDIMIENTO.LineaOrdenAtencion
								 AND SS_PR_PROCEDIMIENTO.ESTADO = 2
								 LEFT JOIN GE_ESTADODOCUMENTO WITH(NOLOCK) ON GE_ESTADODOCUMENTO.IDESTADO = SS_PR_PROCEDIMIENTO.ESTADODOCUMENTO
								AND GE_ESTADODOCUMENTO.IDDOCUMENTO = 48
                                WHERE OAD.IDORDENATENCION = SS_AD_ORDENATENCIONDETALLE.IDORDENATENCION
                                  AND OAD.LINEA = SS_AD_ORDENATENCIONDETALLE.LINEA
                                 
                                   )
						END
					as tipoListado,
                    ---------7
               ' ' AS CitaTipo,
                    CitaFecha = SS_AD_OrdenAtencion.FechaEmision,
                    CitaHora = (case when SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion=1 and SS_AD_OrdenAtencionDetalle.Linea=1  then SS_AD_OrdenAtencion.FechaPreparacion else SS_AD_OrdenAtencionDetalle.FechaCreacion end ),  --SS_AD_OrdenAtencion.FechaPreparacion,

                    Origen = (case when SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion=11  then 'Interconsulta'
						when SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion=12 then 'Procedimiento'  ELSE
						(CASE SS_AD_OrdenAtencion.TipoAtencion WHEN 3 THEN 'Hospitalización'
						WHEN 2 THEN
						 (CASE
						WHEN
						 ISNULL(SS_CE_CONSULTAEXTERNA.TIPOCONSULTA, 1) = 1 THEN 'Emergencia'
						WHEN ISNULL(SS_CE_CONSULTAEXTERNA.TIPOCONSULTA, 1) = 2 THEN 'Relevo'
						WHEN
						 ISNULL(SS_CE_CONSULTAEXTERNA.TIPOCONSULTA, 1) = 3 THEN 'RE-Ingreso'
						WHEN
						 ISNULL(SS_CE_CONSULTAEXTERNA.TIPOCONSULTA, 1) = 4 THEN 'Interconsulta'
						 END)
						WHEN 1 THEN  'Ambulatorio' ELSE NULL END)END),

					NombreEspecialidad = '',
                    TipoPacienteNombre = '',
                    SS_AD_OrdenAtencion.CodigoOA,
                    SS_AD_OrdenAtencion.FechaInicio,
                    Cama = '',
                    TipoOrdenAtencionNombre = SS_AD_OrdenAtencionDetalle.SECUENCIALHCE,
                    SS_GE_Paciente.CodigoHC,
                    SS_GE_Paciente.CodigoHCAnterior,
                    PacienteNombre = PersonaMast.NombreCompleto,
					MedicoNombre=MEDICO.NombreCompleto,
                    SS_AD_OrdenAtencion.IdOrdenAtencion,
                    SS_AD_OrdenAtencionDetalle.Linea as LineaOrdenAtencion,
					isnull(SS_AD_OrdenAtencion.IndicadorAltaMedica,1) as IndHospitalizado,
                    --IndHospitalizado = IsNull('',1),
                    0 LineaHospitalizacion,
                    0 IdConsultaExterna,
                    IdProcedimiento = CASE WHEN SS_AD_OrdenAtencionDetalle.Componente='500101'
					THEN SS_AD_OrdenAtencionDetalle.IndicadorEPS  ELSE
					SS_AD_OrdenAtencionDetalle.TipoInterConsulta end, -- tipo interconsulta=09-03-2022 angel
                    SS_AD_OrdenAtencion.Modalidad,
					IndicadorSeguro = 0,
                     SS_AD_OrdenAtencionDetalle.IdCita,
                    SS_AD_OrdenAtencion.FechaFinal,
                    SS_GE_Paciente.IdPaciente,
                    SS_AD_OrdenAtencion.TipoPaciente,
                    SS_AD_OrdenAtencion.TipoAtencion,
                    IdEspecialidad = SS_AD_OrdenAtencionDetalle.Especialidad,
                    SS_AD_OrdenAtencion.IdEmpresaAseguradora,
                    SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion,
                    0 Componente,
                    ComponenteNombre =  
					CASE WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion=11 THEN 
								(CASE WHEN SS_AD_OrdenAtencionDetalle.TipoInterConsulta=1 THEN 'I. Opinión'
									  WHEN SS_AD_OrdenAtencionDetalle.TipoInterConsulta=2 THEN 'I. Manejo en Conjunto'
									  ELSE 'I. Derivación' 
								 END)  
						 WHEN SS_AD_OrdenAtencion.TipoAtencion = 2 AND (SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion = 1 OR SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion = 11 OR SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion = 21)   THEN 
								(CASE
									  WHEN SS_AD_OrdenAtencionDetalle.TipoInterConsulta=1 THEN 'I. Opinión'
									  WHEN SS_AD_OrdenAtencionDetalle.TipoInterConsulta=2 THEN 'I. Manejo en Conjunto'
									  WHEN SS_AD_OrdenAtencionDetalle.TipoInterConsulta=3 THEN 'I. Derivación' 
								  END)

						  ELSE
								(CASE WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion= 12 THEN COMPONENTENOMBRE.Descripcion 
								      ELSE '' 
								 END)  
					 END ,
                    SS_AD_OrdenAtencion.Compania,
                   SS_AD_OrdenAtencion.UnidadReplicacion as Sucursal,
                    IdMedico =  CASE WHEN SS_AD_OrdenAtencionDetalle.Componente='500101' THEN ISNULL(0,SS_AD_OrdenAtencionDetalle.IdPersonaAntUnificacion)
					ELSE SS_CE_ConsultaExterna.Medico end,
                    ---------------------------
                    IndicadorCirugia = IsNull('',1),
                    IndicadorExamenPrincipal = 2,
                    ---------------------------ADD ORIGEN HCE --OBS                    
                    null as UnidadReplicacionHCE,	
					ISNULL(	 CASE
                        WHEN ISNULL(SS_AD_ORDENATENCIONDETALLE.TIPOORDENATENCION, 0) = 1
                             OR ISNULL(SS_AD_ORDENATENCIONDETALLE.TIPOORDENATENCION, 0) = 11
                             OR ISNULL(SS_AD_ORDENATENCIONDETALLE.TIPOORDENATENCION, 0) = 21 THEN
                               (SELECT TOP 1 ISNULL(GE_ESTADODOCUMENTO.IdEstado, 1)
                                FROM SS_AD_ORDENATENCIONDETALLE OAD WITH(NOLOCK)
								LEFT JOIN SS_CE_CONSULTAEXTERNA WITH(NOLOCK) ON OAD.IdOrdenAtencion = SS_CE_CONSULTAEXTERNA.IdOrdenAtencion  AND OAD.Linea=SS_CE_CONSULTAEXTERNA.LineaOrdenAtencion
									AND SS_CE_CONSULTAEXTERNA.ESTADO = 2
								LEFT JOIN GE_ESTADODOCUMENTO WITH(NOLOCK) ON GE_ESTADODOCUMENTO.IDESTADO = SS_CE_CONSULTAEXTERNA.ESTADODOCUMENTO
									AND GE_ESTADODOCUMENTO.IDDOCUMENTO = 47 
							   WHERE SS_CE_CONSULTAEXTERNA.IDORDENATENCION = SS_AD_ORDENATENCIONDETALLE.IDORDENATENCION
                                  AND SS_CE_CONSULTAEXTERNA.LINEAORDENATENCION = SS_AD_ORDENATENCIONDETALLE.LINEA                                 
                                 )
                        ELSE
                               (SELECT TOP 1 ISNULL(GE_ESTADODOCUMENTO.IdEstado, 1) -- 0 PENDIENTE 
                                FROM SS_AD_ORDENATENCIONDETALLE OAD WITH(NOLOCK)
								LEFT JOIN SS_PR_PROCEDIMIENTO  ON OAD.IdOrdenAtencion = SS_PR_PROCEDIMIENTO.IdOrdenAtencion  AND OAD.Linea=SS_PR_PROCEDIMIENTO.LineaOrdenAtencion
								 AND SS_PR_PROCEDIMIENTO.ESTADO = 2
								 LEFT JOIN GE_ESTADODOCUMENTO WITH(NOLOCK) ON GE_ESTADODOCUMENTO.IDESTADO = SS_PR_PROCEDIMIENTO.ESTADODOCUMENTO
								AND GE_ESTADODOCUMENTO.IDDOCUMENTO = 48
                                WHERE OAD.IDORDENATENCION = SS_AD_ORDENATENCIONDETALLE.IDORDENATENCION
                                  AND OAD.LINEA = SS_AD_ORDENATENCIONDETALLE.LINEA)
                    END, 0)
				
					AS  EstadoEpiAtencion		  , 
					EpisodioClinicoHCE		=	NULL ,
                    IdEpisodioAtencionHCE	=	NULL ,
                    IdPacienteHCE			=	NULL ,
                    SecuenciaHCE			=	NULL ,                
                    ---------------------------      
                    PersonaMast.PersonaAnt,
                    PersonaMast.sexo,
                    PersonaMast.FechaNacimiento,
                    PersonaMast.EstadoCivil,
                    PersonaMast.NivelInstruccion,
                     replace(PersonaMast.Direccion,'&#','') as Direccion,  
                    PersonaMast.TipoDocumento,
                    PersonaMast.Documento,
                    PersonaMast.ApellidoPaterno,
                    PersonaMast.ApellidoMaterno,
                    PersonaMast.Nombres,
                    PersonaMast.LugarNacimiento,
                    PersonaMast.CodigoPostal,
                    PersonaMast.Provincia,
                    PersonaMast.Departamento,
                    PersonaMast.Telefono,
                    PersonaMast.CorreoElectronico,
                    PersonaMast.EsPaciente,
                    PersonaMast.EsEmpresa,
					PersonaMast.Pais,
                  --  PersonaMast.Pais,
                    PersonaMast.Origen as UnidadReplicacionEC,
                    PersonaMast.Estado as EstadoPersona
                    FROM SS_AD_OrdenAtencionDetalle WITH(NOLOCK)
					left join SS_AD_OrdenAtencion WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdOrdenAtencion= SS_AD_OrdenAtencionDetalle.IdOrdenAtencion
					LEFT JOIN SS_CE_ConsultaExterna WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_CE_ConsultaExterna.IdOrdenAtencion  -- c
								AND SS_AD_OrdenAtencionDetalle.Linea = SS_CE_ConsultaExterna.LineaOrdenAtencion  -- c
					LEFT JOIN SS_PR_Procedimiento PRO  WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = PRO.IdOrdenAtencion  -- c
								AND SS_AD_OrdenAtencionDetalle.Linea = PRO.LineaOrdenAtencion
					LEFT JOIN PersonaMast WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdPaciente = PersonaMast.Persona
                    LEFT JOIN SS_GE_Paciente WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdPaciente = SS_GE_Paciente.IdPaciente
					LEFT JOIN PersonaMast AS MEDICO WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdPersonaAntUnificacion = MEDICO.Persona or SS_CE_ConsultaExterna.Medico =MEDICO.Persona
								OR PRO.Medico =MEDICO.Persona
					LEFT JOIN SS_GE_COMPONENTEPRESTACION as COMPONENTE  WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.Componente = COMPONENTE.Componente
					LEFT JOIN CM_CO_Componente as COMPONENTENOMBRE WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.Componente = COMPONENTENOMBRE.CodigoComponente
		
                    WHERE
					SS_AD_OrdenAtencion.EstadoDocumento NOT IN (8,10,11,12,13,14,15,16)             
					AND	SS_AD_OrdenAtencion.TipoAtencion =2
					AND ( SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion in (1,11) or (SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion =12 and COMPONENTE.IndicadorAfectoEmergencia=2))
					
                    ----EXTRAS---
                    and (@Sucursal is null OR SS_AD_OrdenAtencion.Sucursal= @Sucursal)    
					AND (@CodigoHC is null OR IsNUll(SS_GE_Paciente.CodigoHC,'-99') = @CodigoHC)    
					AND (@CodigoHCAnterior is null OR IsNull(SS_GE_Paciente.CodigoHCAnterior,'-99') = @CodigoHCAnterior)  
					AND (@TipoOrdenAtencion is null OR IsNull(SS_AD_OrdenAtencion.TipoOrdenAtencion,-99) = @TipoOrdenAtencion)
					AND (@PacienteNombre is null  OR  upper(PersonaMast.NombreCompleto) like '%'+upper(@PacienteNombre)+'%')    
					AND (@CodigoOA is  null OR  upper(SS_AD_OrdenAtencion.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
					AND (    
							(@FechaInicio is null or  SS_AD_OrdenAtencion.FechaInicio >= @FechaInicio)    
							and    
							(@FechaFin is null or  SS_AD_OrdenAtencion.FechaInicio <= DATEADD(DAY,1,@FechaFin))    
					 ) 
	

				UPDATE #TABLA_ATENCIONPACIENTE_GENERAL_TEMP SET 
					IndicadorSeguro = IsNull(#tipopaciente.IndicadorConcepto,1),
					TipoPacienteNombre = #tipopaciente.Nombre
				FROM #TABLA_ATENCIONPACIENTE_GENERAL_TEMP
				INNER JOIN #tipopaciente ON #tipopaciente.IdCodigo = #TABLA_ATENCIONPACIENTE_GENERAL_TEMP.TipoPaciente

				UPDATE #TABLA_ATENCIONPACIENTE_GENERAL_TEMP SET 
					NombreEspecialidad = SS_GE_Especialidad.Nombre
				FROM #TABLA_ATENCIONPACIENTE_GENERAL_TEMP
				LEFT JOIN SS_GE_Especialidad WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = #TABLA_ATENCIONPACIENTE_GENERAL_TEMP.IdEspecialidad

				DROP TABLE #tipopaciente
                          
			SELECT CONVERT(int,ROW_NUMBER() OVER (ORDER BY FechaInicio  ASC ) )AS NumeroFila ,
				ISNULL(	tipoListado	,'')tipoListado	, CitaTipo,CitaFecha,CitaHora,Origen,NombreEspecialidad,TipoPacienteNombre,VW_ATENCIONPACIENTE_GENERAL.CodigoOA,            
						FechaInicio,Cama,TipoOrdenAtencionNombre,CodigoHC,CodigoHCAnterior,
						PacienteNombre,MedicoNombre,VW_ATENCIONPACIENTE_GENERAL.IdOrdenAtencion,VW_ATENCIONPACIENTE_GENERAL.LineaOrdenAtencion,IdHospitalizacion,
						LineaHospitalizacion,IdConsultaExterna,IdProcedimiento,Modalidad,IndicadorSeguro,
						IdCita,        
						VW_ATENCIONPACIENTE_GENERAL.IdPaciente,TipoPaciente,VW_ATENCIONPACIENTE_GENERAL.TipoAtencion,IdEspecialidad,IdEmpresaAseguradora,
						TipoOrdenAtencion,Componente,ComponenteNombre,Compania,Sucursal,
						VW_ATENCIONPACIENTE_GENERAL.IdMedico,IndicadorCirugia,IndicadorExamenPrincipal,        
						PersonaAnt,sexo,FechaNacimiento,EstadoCivil,NivelInstruccion,
						Direccion,TipoDocumento,Documento,ApellidoPaterno,ApellidoMaterno,
						Nombres,LugarNacimiento,CodigoPostal,Provincia,Departamento,
						Telefono,CorreoElectronico,EsPaciente,EsEmpresa,Pais,
						EstadoPersona, FechaCierreEpiClinico,VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion EstadoEpiClinico,VW_ATENCIONPACIENTE_GENERAL.UnidadReplicacion,VW_ATENCIONPACIENTE_GENERAL.UnidadReplicacionEC,
						CASE WHEN VW_ATENCIONPACIENTE_GENERAL.IdOrdenAtencion=0 THEN VW_ATENCIONPACIENTE_GENERAL.IdEpisodioAtencion ELSE XXX.IdEpisodioAtencion END IdEpisodioAtencion,
						CASE WHEN VW_ATENCIONPACIENTE_GENERAL.IdOrdenAtencion=0 THEN VW_ATENCIONPACIENTE_GENERAL.EpisodioClinico ELSE XXX.EpisodioClinico END EpisodioClinico,
						VW_ATENCIONPACIENTE_GENERAL.IdEstablecimientoSalud,VW_ATENCIONPACIENTE_GENERAL.IdUnidadServicio,
						CASE WHEN  XXX.ESTADO IS NOT NULL THEN XXX.IdPersonalSalud ELSE VW_ATENCIONPACIENTE_GENERAL.IDMEDICO END   IdPersonalSalud,
						CASE WHEN VW_ATENCIONPACIENTE_GENERAL.IdOrdenAtencion=0 THEN VW_ATENCIONPACIENTE_GENERAL.EpisodioAtencion ELSE XXX.EpisodioAtencion END  EpisodioAtencion,
						
						VW_ATENCIONPACIENTE_GENERAL.FechaRegistro,VW_ATENCIONPACIENTE_GENERAL.FechaAtencion,
						ISNULL(	CASE WHEN XXX.ESTADO IS NOT NULL THEN XXX.ESTADO ELSE		
									CASE  WHEN ISNULL(VW_ATENCIONPACIENTE_GENERAL.TIPOORDENATENCION, 0) = 1
										 OR ISNULL(VW_ATENCIONPACIENTE_GENERAL.TIPOORDENATENCION, 0) = 11
										 OR ISNULL(VW_ATENCIONPACIENTE_GENERAL.TIPOORDENATENCION, 0) = 21 THEN
								
											CASE	WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 3 then 4 --ANULADO
													WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 1 then 0 --PENDIENTE
													WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 2 then 3 -- ATENDIDO
													WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 0 then 0 --PENDIENTE
													WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 7 then 0 -- PENDIENTE 
											END
										ELSE
											CASE	WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 3 then 4 --ANULADO
													WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 1 then 0 --PENDIENTE
													WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 2 then 3 -- ATENDIDO
													WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 0 then 0 --PENDIENTE
													WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 4 then 3 --5 TERMINADO
													WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 7 then 0 -- PENDIENTE   NO REGISTRADO
											END
										
									END	
							END ,0)
							EstadoEpiAtencion,
			VW_ATENCIONPACIENTE_GENERAL.UsuarioCreacion,VW_ATENCIONPACIENTE_GENERAL.UsuarioModificacion,VW_ATENCIONPACIENTE_GENERAL.FechaCreacion,
			VW_ATENCIONPACIENTE_GENERAL.FechaModificacion,VW_ATENCIONPACIENTE_GENERAL.Accion,VW_ATENCIONPACIENTE_GENERAL.Version   ,FechaFin,
			VW_ATENCIONPACIENTE_GENERAL.FechaOrden,Comentarios,Observaciones,Diagnostico, UnidadReplicacionHCE,IdPacienteHCE,
			EpisodioClinicoHCE,IdEpisodioAtencionHCE,SecuenciaHCE,  CodigoEpisodioClinico,	1 CONTADOR    
            FROM #TABLA_ATENCIONPACIENTE_GENERAL_TEMP as VW_ATENCIONPACIENTE_GENERAL  
			LEFT JOIN 	(
			SELECT ISNULL(MAX( A.ESTADO),0)ESTADO ,A.UNIDADREPLICACION,A.IDPACIENTE,IDORDENATENCION,LINEAORDENATENCION,CODIGOOA,TIPOATENCION,
				ISNULL(MAX(B.HCALTAMEDICA),0) HCALTAMEDICA,ISNULL(MAX(B.IDMEDICO),0) IDMEDICO ,MAX(A.EpisodioClinico) EpisodioClinico,
				MAX(A.IdEpisodioAtencion) IdEpisodioAtencion, MAX(A.EpisodioAtencion) EpisodioAtencion,A.IdPersonalSalud
				FROM WEB_ERPSALUD.DBO.SS_HC_EpisodioAtencion  A WITH(NOLOCK)
					LEFT JOIN WEB_ERPSALUD.DBO.SS_HC_InformeAlta_FE B WITH(NOLOCK) ON A.IDPACIENTE=B.IDPACIENTE AND A.UNIDADREPLICACION=B.UNIDADREPLICACION
									AND A.EpisodioClinico=B.EpisodioClinico AND A.IdEpisodioAtencion=B.IdEpisodioAtencion
					WHERE TIPOATENCION=2   	AND 	A.TipoTrabajador= '08'		
					    AND (    
							(@FechaInicio is null or  A.FechaAtencion >= @FechaInicio)    
							AND    
							(@FechaFin is null or  A.FechaAtencion <= DATEADD(DAY,1,@FechaFin))
							) 
					--AND A.IdOrdenAtencion = VW_ATENCIONPACIENTE_GENERAL.IdOrdenAtencion AND A.LineaOrdenAtencion = VW_ATENCIONPACIENTE_GENERAL.LineaOrdenAtencion
					GROUP BY A.UNIDADREPLICACION,A.IDPACIENTE,A.IDORDENATENCION,A.LINEAORDENATENCION,A.CODIGOOA,A.TIPOATENCION,A.IdPersonalSalud
				) XXX  ON   XXX.IDORDENATENCION=VW_ATENCIONPACIENTE_GENERAL.IdOrdenAtencion AND VW_ATENCIONPACIENTE_GENERAL.LineaOrdenAtencion=XXX.LINEAORDENATENCION
			WHERE 
			   (@EstadoEpiAtencion is null  OR  
			  ( CASE WHEN XXX.ESTADO IS NOT NULL THEN XXX.ESTADO ELSE		
								CASE	WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 3 then 4 --ANULADO
										WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 1 then 0 --PENDIENTE
										WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 2 then 3 -- ATENDIDO
										WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 0 then 0 --PENDIENTE
										WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 7 then 0 -- PENDIENTE 
										WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 4 then 3 --5 TERMINADO
								END
						END ) = @EstadoEpiAtencion)    
			 
   	   ORDER BY tipoListado DESC,IdOrdenAtencion


	END
GO

CREATE OR ALTER PROCEDURE  [dbo].[SS_HC_ATENCIONES_SOA_ENFERM_EMERGENCIAS]
(
       @tipoListado			varchar(50) ,
       @CitaTipo			varchar(20) ,
       @CitaFecha			datetime,
       @Origen				varchar(20) ,
       @NombreEspecialidad	varchar(80) ,       
       @TipoPacienteNombre	varchar(80) ,
       @CodigoOA			varchar(25) ,
       @Cama				varchar(150) ,
       @TipoOrdenAtencionNombre          varchar(250) ,
       @CodigoHC			varchar(15) ,       
       @PacienteNombre      varchar(100) ,
       @MedicoNombre		varchar(100) ,
       @IdOrdenAtencion     int ,
       @LineaOrdenAtencion  int ,
       @IdHospitalizacion   int ,       
       @IdCita             int ,
       @IdPaciente         int,
       @TipoPaciente       int,
       @TipoAtencion       int,
       @IdEspecialidad     int,
       
       @IdMedico           int,
       @TipoOrdenAtencion  int,
       @Componente         varchar(25),
       @Compania           varchar(15),
       @Sucursal           varchar(15),
       
       @EstadoPersona             varchar(2),
       @EstadoEpiClinico          int,
       @UnidadReplicacion         varchar(4),
       @UnidadReplicacionEC       varchar(4),
       @IdEpisodioAtencion        bigint,
       
       @EpisodioClinico           int,
       @IdEstablecimientoSalud    int,
       @IdUnidadServicio          int,
       @IdPersonalSalud           int,
       @EpisodioAtencion          bigint,
       @FechaRegistro             datetime,
       @FechaAtencion             datetime,
       @EstadoEpiAtencion         int,
       @FechaInicio				  datetime,
       @FechaFin				  datetime,
       @UsuarioCreacion           varchar(50),
       @FechaCreacion			  datetime ,
       @UsuarioModificacion       varchar(50) , -- Nombre del COMPONENTE TECNOLOGO
       @FechaModificacion		  datetime ,          
       @Version					  varchar(50) ,
       @CodigoHCAnterior		  varchar(15) ,
       @IndicadorCirugia		  int,  
       @IndicadorExamenPrincipal  int,  
       @IndicadorSeguro			  int,  
       @Modalidad				  int,  
       @sexo					  char(1),    
       @EstadoCivil char(1),    
       @NivelInstruccion char(3),    
       @EsPaciente varchar(1),  
       @EsEmpresa varchar(1), 
       @Inicio int ,  
       @NumeroFilas int ,  
       @ACCION varchar(25)
                   
)

--WITH RECOMPILE
AS
BEGIN

		DECLARE @TABLA_ATENCIONPACIENTE_ENFERM table
      (
            --SECUENCIA             int  NOT NULL   IDENTITY PRIMARY KEY,
            NumeroFila  int   null
      ,     tipoListado varchar(30) null
      ,     CitaTipo    varchar(9)  null
      ,     CitaFecha   datetime    null
      ,     CitaHora    datetime    null
      ,     Origen      varchar(20) null
      ,     NombreEspecialidad      varchar(80) null
      ,     TipoPacienteNombre      varchar(80) null
      ,     CodigoOA    varchar(25) null
      ,     FechaInicio datetime    null
      ,     Cama  varchar(150)      null
      ,     TipoOrdenAtencionNombre varchar(80) null
      ,     CodigoHC    varchar(15) null
      ,     CodigoHCAnterior  varchar(15) null
      ,     PacienteNombre    varchar(100)      null
      ,     MedicoNombre      varchar(100)      null
      ,     IdOrdenAtencion   int   null
      ,     LineaOrdenAtencion      int   null
      ,     IdHospitalizacion int   null
      ,     LineaHospitalizacion    int   null
      ,     IdConsultaExterna int   null
      ,     IdProcedimiento   int   null
      ,     Modalidad   int   null
      ,     IndicadorSeguro   int   null
      ,     IdCita      int   null
      ,     IdPaciente  int   null
      ,     TipoPaciente      int   null
      ,     TipoAtencion      int   null
      ,     IdEspecialidad    int   null
      ,     IdEmpresaAseguradora    int   null
      ,     TipoOrdenAtencion int   null
      ,     Componente  varchar(25) null
      ,     ComponenteNombre  varchar(250)      null
      ,     Compania    varchar(15) null
      ,     Sucursal    varchar(15) null
      ,     IdMedico    int   null
      ,     IndicadorCirugia  int   null
      ,     IndicadorExamenPrincipal     int   null
      ,     PersonaAnt  char(15)    null
      ,     sexo  char(1)     null
      ,     FechaNacimiento   datetime    null
      ,     EstadoCivil char(1)     null
      ,     NivelInstruccion  char(3)     null
      ,     Direccion   varchar(190)      null
      ,     TipoDocumento     char(1)     null
      ,     Documento   char(20)    null
      ,     ApellidoPaterno   varchar(40) null
      ,     ApellidoMaterno   varchar(40) null
      ,     Nombres     varchar(40) null
      ,     LugarNacimiento   varchar(255)      null
      ,     CodigoPostal      char(3)     null
      ,     Provincia   char(3)     null
      ,     Departamento      char(3)     null
      ,     Telefono    varchar(15) null
      ,     CorreoElectronico varchar(50) null
      ,     EsPaciente  varchar(1)  null
      ,     EsEmpresa   varchar(1)  null
      ,     Pais  varchar(100)     null
      ,     EstadoPersona     char(1)     null
      ,     FechaCierreEpiClinico   datetime    null
      ,     EstadoEpiClinico  int   null
      ,     UnidadReplicacion char(4)     null
      ,     UnidadReplicacionEC     char(4)     null
      ,     IdEpisodioAtencion      bigint      null
      ,     EpisodioClinico   int   null
      ,     IdEstablecimientoSalud  int   null
      ,     IdUnidadServicio  int   null
      ,     IdPersonalSalud   int   null
      ,     EpisodioAtencion  int   null
      ,     FechaRegistro     datetime    null
      ,     FechaAtencion     datetime    null
      ,     EstadoEpiAtencion int   null
      ,     UsuarioCreacion   varchar(25) null
      ,     UsuarioModificacion     varchar(25) null
      ,     FechaCreacion     datetime    null
      ,     FechaModificacion datetime    null
      ,     Accion      varchar(25) null
      ,     Version     varchar(25) null
      ,     FechaFin    datetime    null
      ,     FechaOrden  datetime    null
      ,     Comentarios INT null -- varchar(300)      null
      ,     Observaciones INT null -- varchar(300)      null  
      ,     Diagnostico INT null -- varchar(300)      null
      -------------
      ,     UnidadReplicacionHCE    varchar(4)  null
      ,     IdPacienteHCE     int   null
      ,     EpisodioClinicoHCE      int   null
      ,     IdEpisodioAtencionHCE   bigint      null
      ,     SecuenciaHCE      int   null
      ,     CodigoEpisodioClinico   int   null  
      -------------
      ,     Contador    int   null                                          
      )


	  DECLARE @PamaetroLog INT

	  SET @PamaetroLog = 1

	  select @PamaetroLog = IsNull(ValorNumerico,1) 
	  from ge_varios WITH(NOLOCK)
	  WHERE CodigoTabla = 'LOG_VISORES_HCE'
	  AND NEMONICO = 'E_V_ENF'


		create table #tipopaciente(IdTablaMaestro INT , IdCodigo INT , IndicadorConcepto INT, Nombre VARCHAR(80))

		INSERT INTO #tipopaciente(IdTablaMaestro, IdCodigo, IndicadorConcepto, Nombre)
		SELECT CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro, CM_CO_TablaMaestroDetalleConcepto.IdCodigo, 
		IsNull(CM_CO_TablaMaestroDetalleConcepto.IndicadorConcepto,1), CM_CO_TablaMaestroDetalle.Nombre
		FROm CM_CO_TablaMaestroDetalle WITH(NOLOCK)
		INNER JOIN  CM_CO_TablaMaestroDetalleConcepto WITH(NOLOCK) ON 
			CM_CO_TablaMaestroDetalle.IdCodigo = CM_CO_TablaMaestroDetalleConcepto.IdCodigo
			AND CM_CO_TablaMaestroDetalle.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
		INNER JOIN CM_CO_TablaMaestroConcepto WITH(NOLOCK) ON CM_CO_TablaMaestroConcepto.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
			AND CM_CO_TablaMaestroConcepto.IdConcepto = CM_CO_TablaMaestroDetalleConcepto.IdConcepto
			AND CM_CO_TablaMaestroConcepto.Concepto = 'APLICA_SEGURO'


	              insert into @TABLA_ATENCIONPACIENTE_ENFERM
 
              (tipoListado,CitaTipo,CitaFecha,CitaHora,Origen,NombreEspecialidad,TipoPacienteNombre,CodigoOA,
             ----------
             FechaInicio,Cama,TipoOrdenAtencionNombre,CodigoHC,CodigoHCAnterior,
             PacienteNombre,MedicoNombre,IdOrdenAtencion,LineaOrdenAtencion,IdHospitalizacion,
             LineaHospitalizacion,IdConsultaExterna,IdProcedimiento,Modalidad,IndicadorSeguro,
             IdCita,FechaFin,
             ----------
             IdPaciente,TipoPaciente,TipoAtencion,IdEspecialidad,IdEmpresaAseguradora,
             TipoOrdenAtencion,Componente,ComponenteNombre,Compania,Sucursal,
             IdMedico,IndicadorCirugia,IndicadorExamenPrincipal,
             ---------
             UnidadReplicacionHCE,EstadoEpiAtencion,EpisodioClinicoHCE,IdEpisodioAtencionHCE,IdPacienteHCE,SecuenciaHCE,
             ------------
             PersonaAnt,sexo,FechaNacimiento,EstadoCivil,NivelInstruccion,
             Direccion,TipoDocumento,Documento,ApellidoPaterno,ApellidoMaterno,
             Nombres,LugarNacimiento,CodigoPostal,Provincia,Departamento,
             Telefono,CorreoElectronico,EsPaciente,EsEmpresa,Pais,
             UnidadReplicacionEC,EstadoPersona      
             )      
   SELECT TOP 10000
					'' as tipoListado,
                    NULL as CitaTipo,
                    CitaFecha = SS_AD_OrdenAtencion.FechaEmision,
                    CitaHora = (case when SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion=1 and SS_AD_OrdenAtencionDetalle.Linea=1  then SS_AD_OrdenAtencion.FechaPreparacion else SS_AD_OrdenAtencionDetalle.FechaCreacion end ),  

                    Origen = (case when SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion=11  then 'Interconsulta'
					when SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion=12 then 'Procedimiento'  ELSE
					(CASE SS_AD_OrdenAtencion.TipoAtencion WHEN 3 THEN 'Hospitalización'
					WHEN 2 THEN
					 (CASE
					WHEN ISNULL(SS_CE_ConsultaExterna.TIPOCONSULTA, 1) = 1 THEN 'Emergencia'
					WHEN ISNULL(SS_CE_ConsultaExterna.TIPOCONSULTA, 1) = 2 THEN 'Relevo'
					WHEN ISNULL(SS_CE_ConsultaExterna.TIPOCONSULTA, 1) = 3 THEN 'RE-Ingreso'
					WHEN ISNULL(SS_CE_CONSULTAEXTERNA.TIPOCONSULTA, 1) = 4 THEN 'Interconsulta'
					 END)
					WHEN 1 THEN  'Ambulatorio' ELSE NULL END)END),
             
					NombreEspecialidad = '',
					TipoPacienteNombre = '',
                   -- TipoPacienteNombre = TipoPaciente.Nombre,
                    SS_AD_OrdenAtencion.CodigoOA,
                    -----------
                    SS_AD_OrdenAtencion.FechaInicio,
                    Cama = ENF.NombreCompleto,
                    TipoOrdenAtencionNombre = SS_AD_OrdenAtencionDetalle.SECUENCIALHCE,
                    SS_GE_Paciente.CodigoHC,
                    SS_GE_Paciente.CodigoHCAnterior,
                    PacienteNombre = PersonaMast.NombreCompleto,
					MedicoNombre=MEDICO.NombreCompleto,
                    SS_AD_OrdenAtencion.IdOrdenAtencion,
                    SS_AD_OrdenAtencionDetalle.Linea as LineaOrdenAtencion,
                    IndHospitalizado = IsNull('',1),
                    LineaHospitalizacion = 0,
                    IdConsultaExterna=0,
                    IdProcedimiento = CASE WHEN SS_AD_OrdenAtencionDetalle.Componente='500101'
					THEN SS_AD_OrdenAtencionDetalle.IndicadorEPS  ELSE
					0 end,
                    SS_AD_OrdenAtencion.Modalidad,
					IndicadorSeguro = 1,
                    IdCita=SS_AD_OrdenAtencionDetalle.IdCita,
                    SS_AD_OrdenAtencion.FechaFinal,
                    ---------------------      11          
                    SS_GE_Paciente.IdPaciente,
                    SS_AD_OrdenAtencion.TipoPaciente,
                    SS_AD_OrdenAtencion.TipoAtencion,
                    IdEspecialidad = SS_AD_OrdenAtencionDetalle.Especialidad,
                    SS_AD_OrdenAtencion.IdEmpresaAseguradora,
                    SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion,
                    SS_AD_OrdenAtencionDetalle.Componente Componente,
                    ComponenteNombre =  CASE WHEN SS_AD_OrdenAtencionDetalle.Componente='500101'
					THEN (CASE WHEN SS_AD_OrdenAtencionDetalle.IndicadorEPS=1 THEN 'I. Opinión'
					when SS_AD_OrdenAtencionDetalle.IndicadorEPS=2 THEN 'I. Manejo en Conjunto'
					else 'I. Derivación' end )  ELSE
					'' end,
                    SS_AD_OrdenAtencion.Compania,
                   SS_AD_OrdenAtencion.UnidadReplicacion as Sucursal,
                    IdMedico =  CASE WHEN SS_AD_OrdenAtencionDetalle.Componente='500101' THEN ISNULL(0,SS_AD_OrdenAtencionDetalle.IdPersonaAntUnificacion)
					ELSE SS_CE_ConsultaExterna.Medico end,
                    ---------------------------
                    IndicadorCirugia = IsNull('',1),
                    IndicadorExamenPrincipal = 2,
                    ---------------------------ADD ORIGEN HCE --OBS                    
                    null as UnidadReplicacionHCE,
					ISNULL(	 CASE
                        WHEN ISNULL(SS_AD_ORDENATENCIONDETALLE.TIPOORDENATENCION, 0) = 1
                             OR ISNULL(SS_AD_ORDENATENCIONDETALLE.TIPOORDENATENCION, 0) = 11
                             OR ISNULL(SS_AD_ORDENATENCIONDETALLE.TIPOORDENATENCION, 0) = 21 THEN
                               (SELECT TOP 1 ISNULL(GE_ESTADODOCUMENTO.IdEstado, 1)
                                FROM SS_AD_ORDENATENCIONDETALLE OAD WITH(NOLOCK)
								LEFT JOIN SS_CE_CONSULTAEXTERNA WITH(NOLOCK) ON OAD.IdOrdenAtencion = SS_CE_CONSULTAEXTERNA.IdOrdenAtencion  AND OAD.Linea=SS_CE_CONSULTAEXTERNA.LineaOrdenAtencion
									AND SS_CE_CONSULTAEXTERNA.ESTADO = 2
								LEFT JOIN GE_ESTADODOCUMENTO WITH(NOLOCK) ON GE_ESTADODOCUMENTO.IDESTADO = SS_CE_CONSULTAEXTERNA.ESTADODOCUMENTO
									AND GE_ESTADODOCUMENTO.IDDOCUMENTO = 47 
							   WHERE SS_CE_CONSULTAEXTERNA.IDORDENATENCION = SS_AD_ORDENATENCIONDETALLE.IDORDENATENCION
                                  AND SS_CE_CONSULTAEXTERNA.LINEAORDENATENCION = SS_AD_ORDENATENCIONDETALLE.LINEA                                 
                                 )
                        ELSE
                               (SELECT TOP 1 ISNULL(GE_ESTADODOCUMENTO.IdEstado, 1) -- 0 PENDIENTE 
                                FROM SS_AD_ORDENATENCIONDETALLE OAD WITH(NOLOCK)
								LEFT JOIN SS_PR_PROCEDIMIENTO  ON OAD.IdOrdenAtencion = SS_PR_PROCEDIMIENTO.IdOrdenAtencion  AND OAD.Linea=SS_PR_PROCEDIMIENTO.LineaOrdenAtencion
								 AND SS_PR_PROCEDIMIENTO.ESTADO = 2
								 LEFT JOIN GE_ESTADODOCUMENTO WITH(NOLOCK) ON GE_ESTADODOCUMENTO.IDESTADO = SS_PR_PROCEDIMIENTO.ESTADODOCUMENTO
								AND GE_ESTADODOCUMENTO.IDDOCUMENTO = 48
                                WHERE OAD.IDORDENATENCION = SS_AD_ORDENATENCIONDETALLE.IDORDENATENCION
                                  AND OAD.LINEA = SS_AD_ORDENATENCIONDETALLE.LINEA)
                    END, 0)
					AS EstadoEpiAtencion,
                     EpisodioClinicoHCE=null,
                    IdEpisodioAtencionHCE= NULL,
                    IdPacienteHCE= PRO.ESTADODOCUMENTO,
                    SecuenciaHCE= SS_CE_CONSULTAEXTERNA.ESTADODOCUMENTO,                
                    ---------------------------      
                    PersonaMast.PersonaAnt,
                    PersonaMast.sexo,
                    PersonaMast.FechaNacimiento,
                    PersonaMast.EstadoCivil,
                    PersonaMast.NivelInstruccion,
                     replace(PersonaMast.Direccion,'&#','') as Direccion,  
                    PersonaMast.TipoDocumento,
                    PersonaMast.Documento,
                    PersonaMast.ApellidoPaterno,
                    PersonaMast.ApellidoMaterno,
                    PersonaMast.Nombres,
                    PersonaMast.LugarNacimiento,
                    PersonaMast.CodigoPostal,
                    PersonaMast.Provincia,
                    PersonaMast.Departamento,
                    PersonaMast.Telefono,
                    PersonaMast.CorreoElectronico,
                    PersonaMast.EsPaciente,
                    PersonaMast.EsEmpresa,
                    PersonaMast.Pais,
                    PersonaMast.Origen as UnidadReplicacionEC,
                    PersonaMast.Estado as EstadoPersona
                    FROM SS_AD_OrdenAtencionDetalle WITH(NOLOCK)
					left join SS_AD_OrdenAtencion  WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdOrdenAtencion = SS_AD_OrdenAtencionDetalle.IdOrdenAtencion
					LEFT JOIN SS_CE_ConsultaExterna  WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_CE_ConsultaExterna.IdOrdenAtencion  -- c
					AND SS_AD_OrdenAtencionDetalle.Linea = SS_CE_ConsultaExterna.LineaOrdenAtencion
					LEFT JOIN SS_PR_Procedimiento PRO  WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = PRO.IdOrdenAtencion  -- c
								AND SS_AD_OrdenAtencionDetalle.Linea = PRO.LineaOrdenAtencion
					LEFT JOIN SS_GE_Paciente WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdPaciente = SS_GE_Paciente.IdPaciente
					LEFT JOIN PersonaMast WITH(NOLOCK) ON SS_GE_Paciente.IdPaciente = PersonaMast.Persona
					LEFT JOIN PersonaMast AS MEDICO WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdPersonaAntUnificacion = MEDICO.Persona or SS_CE_ConsultaExterna.Medico =MEDICO.Persona
																	OR PRO.Medico =MEDICO.Persona
 					LEFT JOIN  SS_CE_Enfermeria WITH(NOLOCK) ON SS_CE_Enfermeria.IdOrdenAtencion=SS_AD_OrdenAtencionDetalle.IdOrdenAtencion
					LEFT JOIN PersonaMast AS ENF WITH(NOLOCK) ON SS_CE_Enfermeria.IdEnfermera = ENF.Persona
								WHERE
					SS_AD_OrdenAtencion.EstadoDocumento NOT IN (8,10,11,12,13,14,15,16)            
					AND SS_AD_OrdenAtencion.TipoAtencion =2
					AND SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion in (1)
					AND (@Sucursal is null OR SS_AD_OrdenAtencion.Sucursal= @Sucursal)   
					AND (@CodigoHC is null OR IsNUll(SS_GE_Paciente.CodigoHC,'-99') = @CodigoHC)   
					AND (@PacienteNombre is null  OR  upper(PersonaMast.NombreCompleto) like '%'+upper(@PacienteNombre)+'%')    
					AND (@CodigoOA IS NULL OR upper(SS_AD_OrdenAtencion.CodigoOA) = Right(('0000000000' + @CodigoOA),10))
   					AND (    
							(@FechaInicio is null or  SS_AD_OrdenAtencion.FechaInicio >= @FechaInicio)    
							and    
							(@FechaFin is null or  SS_AD_OrdenAtencion.FechaInicio <= DATEADD(DAY,1,@FechaFin))    
						) 

			UPDATE @TABLA_ATENCIONPACIENTE_ENFERM SET 
				NombreEspecialidad = SS_GE_Especialidad.Nombre
			FROM @TABLA_ATENCIONPACIENTE_ENFERM CC
			LEFT JOIN SS_GE_Especialidad WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = CC.IdEspecialidad

			UPDATE @TABLA_ATENCIONPACIENTE_ENFERM SET 
				IndicadorSeguro = IsNull(#tipopaciente.IndicadorConcepto,1),
				TipoPacienteNombre = #tipopaciente.Nombre
			FROM @TABLA_ATENCIONPACIENTE_ENFERM CC
			INNER JOIN #tipopaciente ON #tipopaciente.IdCodigo = CC.TipoPaciente


		SELECT CONVERT(int,ROW_NUMBER() OVER (ORDER BY FechaInicio  ASC ) )AS NumeroFila ,
							tipoListado = 	'ENFERM_EMERGENCIAS'			, CitaTipo,CitaFecha,CitaHora,Origen,NombreEspecialidad,TipoPacienteNombre,VW_ATENCIONPACIENTE_GENERAL.CodigoOA,            
						FechaInicio,cama = IsNuLL(VW_ATENCIONPACIENTE_GENERAL.Cama,(select top 1 Per.NombreCompleto from PersonaMast Per where Per.Persona = xxx.IdENFERMERA)),TipoOrdenAtencionNombre,CodigoHC,CodigoHCAnterior,
						PacienteNombre,MedicoNombre,VW_ATENCIONPACIENTE_GENERAL.IdOrdenAtencion,VW_ATENCIONPACIENTE_GENERAL.LineaOrdenAtencion,IdHospitalizacion,
						LineaHospitalizacion,IdConsultaExterna,IdProcedimiento,Modalidad,IndicadorSeguro,
						IdCita,        
						VW_ATENCIONPACIENTE_GENERAL.IdPaciente,TipoPaciente,VW_ATENCIONPACIENTE_GENERAL.TipoAtencion,IdEspecialidad,IdEmpresaAseguradora,
						TipoOrdenAtencion,Componente,ComponenteNombre,Compania,Sucursal,
						VW_ATENCIONPACIENTE_GENERAL.IdMedico,IndicadorCirugia,IndicadorExamenPrincipal,        
						PersonaAnt,sexo,FechaNacimiento,EstadoCivil,NivelInstruccion,
						Direccion,TipoDocumento,Documento,ApellidoPaterno,ApellidoMaterno,
						Nombres,LugarNacimiento,CodigoPostal,Provincia,Departamento,
						Telefono,CorreoElectronico,EsPaciente,EsEmpresa,Pais,
						EstadoPersona, FechaCierreEpiClinico,VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion EstadoEpiClinico,VW_ATENCIONPACIENTE_GENERAL.UnidadReplicacion,VW_ATENCIONPACIENTE_GENERAL.UnidadReplicacionEC,
						CASE WHEN VW_ATENCIONPACIENTE_GENERAL.IdOrdenAtencion=0 THEN VW_ATENCIONPACIENTE_GENERAL.IdEpisodioAtencion ELSE XXX.IdEpisodioAtencion END IdEpisodioAtencion,
						CASE WHEN VW_ATENCIONPACIENTE_GENERAL.IdOrdenAtencion=0 THEN VW_ATENCIONPACIENTE_GENERAL.EpisodioClinico ELSE XXX.EpisodioClinico END EpisodioClinico,
						VW_ATENCIONPACIENTE_GENERAL.IdEstablecimientoSalud,VW_ATENCIONPACIENTE_GENERAL.IdUnidadServicio,VW_ATENCIONPACIENTE_GENERAL.IdPersonalSalud,
						CASE WHEN VW_ATENCIONPACIENTE_GENERAL.IdOrdenAtencion=0 THEN VW_ATENCIONPACIENTE_GENERAL.EpisodioAtencion ELSE XXX.EpisodioAtencion END  EpisodioAtencion,
						VW_ATENCIONPACIENTE_GENERAL.FechaRegistro,VW_ATENCIONPACIENTE_GENERAL.FechaAtencion,
						ISNULL(	CASE WHEN XXX.ESTADO IS NOT NULL THEN XXX.ESTADO ELSE		
									CASE  WHEN ISNULL(VW_ATENCIONPACIENTE_GENERAL.TIPOORDENATENCION, 0) = 1
										 OR ISNULL(VW_ATENCIONPACIENTE_GENERAL.TIPOORDENATENCION, 0) = 11
										 OR ISNULL(VW_ATENCIONPACIENTE_GENERAL.TIPOORDENATENCION, 0) = 21 THEN
								
											CASE	WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 3 then 4 --ANULADO
													WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 1 then 0 --PENDIENTE
													WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 2 then 3 -- ATENDIDO
													WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 0 then 0 --PENDIENTE
													WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 7 then 0 -- PENDIENTE 
											END
										ELSE
											CASE	WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 3 then 4 --ANULADO
													WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 1 then 0 --PENDIENTE
													WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 2 then 3 -- ATENDIDO
													WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 0 then 0 --PENDIENTE
													WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 4 then 3 --5 TERMINADO
													WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 7 then 0 -- PENDIENTE   NO REGISTRADO
											END
										
									END	
							END ,0)
							EstadoEpiAtencion,
						VW_ATENCIONPACIENTE_GENERAL.UsuarioCreacion,VW_ATENCIONPACIENTE_GENERAL.UsuarioModificacion,VW_ATENCIONPACIENTE_GENERAL.FechaCreacion,
						 VW_ATENCIONPACIENTE_GENERAL.FechaModificacion,VW_ATENCIONPACIENTE_GENERAL.Accion,VW_ATENCIONPACIENTE_GENERAL.Version   ,FechaFin,
						VW_ATENCIONPACIENTE_GENERAL.FechaOrden,Comentarios,Observaciones,Diagnostico, UnidadReplicacionHCE,IdPacienteHCE,
						EpisodioClinicoHCE,IdEpisodioAtencionHCE,SecuenciaHCE,  CodigoEpisodioClinico,
						1 CONTADOR                                                    
            FROM @TABLA_ATENCIONPACIENTE_ENFERM as VW_ATENCIONPACIENTE_GENERAL  
			LEFT JOIN 	(
				SELECT ISNULL(MAX( A.ESTADO),0)ESTADO ,A.UNIDADREPLICACION,A.IDPACIENTE,
				IDORDENATENCION,LINEAORDENATENCION,CODIGOOA,TIPOATENCION,
				0 HCALTAMEDICA,IdPersonalSalud IDMEDICO ,MAX(A.EpisodioClinico) EpisodioClinico,
				MAX(A.IdEpisodioAtencion) IdEpisodioAtencion, MAX(A.EpisodioAtencion) EpisodioAtencion,
				(select top 1 b.IdPersonalSalud from WEB_ERPSALUD.DBO.SS_HC_EpisodioAtencion b
				where b.IdOrdenAtencion = a.IdOrdenAtencion and b.EpisodioAtencion = a.EpisodioAtencion
				and b.EpisodioClinico = a.EpisodioClinico and b.TipoTrabajador= '02') as IdENFERMERA
				FROM WEB_ERPSALUD.DBO.SS_HC_EpisodioAtencion  A WITH(NOLOCK)
				WHERE A.TIPOATENCION=2  	AND 	A.TipoTrabajador= '08'	
					and (    
						(@FechaInicio is null or  A.FechaAtencion >= @FechaInicio)    
						and    
						(@FechaFin is null or  A.FechaAtencion <= DATEADD(DAY,1,@FechaFin))    
						) 					
					GROUP BY A.UNIDADREPLICACION,A.IDPACIENTE,A.IDORDENATENCION,A.LINEAORDENATENCION,
					A.CODIGOOA,A.TIPOATENCION,IdPersonalSalud,EpisodioAtencion,EpisodioClinico
				) XXX  ON   XXX.IDORDENATENCION=VW_ATENCIONPACIENTE_GENERAL.IdOrdenAtencion AND VW_ATENCIONPACIENTE_GENERAL.LineaOrdenAtencion=XXX.LINEAORDENATENCION
			WHERE 
			   (@EstadoEpiAtencion is null  OR  
			  ( CASE WHEN XXX.ESTADO IS NOT NULL THEN XXX.ESTADO ELSE		
								CASE	WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 3 then 4 --ANULADO
										WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 1 then 0 --PENDIENTE
										WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 2 then 3 -- ATENDIDO
										WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 0 then 0 --PENDIENTE
										WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 7 then 0 -- PENDIENTE 
								END
						END ) = @EstadoEpiAtencion)    
   	   ORDER BY tipoListado DESC,CitaFecha,CitaHora


END
GO

CREATE OR ALTER PROCEDURE  [dbo].[SS_HC_ATENCIONES_SOA_ENFERM_EMERGENCIAS_HOY]
(
       @tipoListado			varchar(50) ,
       @CitaTipo			varchar(20) ,
       @CitaFecha			datetime,
       @Origen				varchar(20) ,
       @NombreEspecialidad	varchar(80) ,       
       @TipoPacienteNombre	varchar(80) ,
       @CodigoOA			varchar(25) ,
       @Cama				varchar(150) ,
       @TipoOrdenAtencionNombre          varchar(250) ,
       @CodigoHC			varchar(15) ,       
       @PacienteNombre      varchar(100) ,
       @MedicoNombre		varchar(100) ,
       @IdOrdenAtencion     int ,
       @LineaOrdenAtencion  int ,
       @IdHospitalizacion   int ,       
       @IdCita             int ,
       @IdPaciente         int,
       @TipoPaciente       int,
       @TipoAtencion       int,
       @IdEspecialidad     int,
       
       @IdMedico           int,
       @TipoOrdenAtencion  int,
       @Componente         varchar(25),
       @Compania           varchar(15),
       @Sucursal           varchar(15),
       
       @EstadoPersona             varchar(2),
       @EstadoEpiClinico          int,
       @UnidadReplicacion         varchar(4),
       @UnidadReplicacionEC       varchar(4),
       @IdEpisodioAtencion        bigint,
       
       @EpisodioClinico           int,
       @IdEstablecimientoSalud    int,
       @IdUnidadServicio          int,
       @IdPersonalSalud           int,
       @EpisodioAtencion          bigint,
       @FechaRegistro             datetime,
       @FechaAtencion             datetime,
       @EstadoEpiAtencion         int,
       @FechaInicio				  datetime,
       @FechaFin				  datetime,
       @UsuarioCreacion           varchar(50),
       @FechaCreacion			  datetime ,
       @UsuarioModificacion       varchar(50) , -- Nombre del COMPONENTE TECNOLOGO
       @FechaModificacion		  datetime ,          
       @Version					  varchar(50) ,
       @CodigoHCAnterior		  varchar(15) ,
       @IndicadorCirugia		  int,  
       @IndicadorExamenPrincipal  int,  
       @IndicadorSeguro			  int,  
       @Modalidad				  int,  
       @sexo					  char(1),    
       @EstadoCivil char(1),    
       @NivelInstruccion char(3),    
       @EsPaciente varchar(1),  
       @EsEmpresa varchar(1), 
       @Inicio int ,  
       @NumeroFilas int ,  
       @ACCION varchar(25)
                   
)

--WITH RECOMPILE
AS
BEGIN

		DECLARE @TABLA_ATENCIONPACIENTE_ENFERM table
      (
            --SECUENCIA             int  NOT NULL   IDENTITY PRIMARY KEY,
            NumeroFila  int   null
      ,     tipoListado varchar(30) null
      ,     CitaTipo    varchar(9)  null
      ,     CitaFecha   datetime    null
      ,     CitaHora    datetime    null
      ,     Origen      varchar(20) null
      ,     NombreEspecialidad      varchar(80) null
      ,     TipoPacienteNombre      varchar(80) null
      ,     CodigoOA    varchar(25) null
      ,     FechaInicio datetime    null
      ,     Cama  varchar(150)      null
      ,     TipoOrdenAtencionNombre varchar(80) null
      ,     CodigoHC    varchar(15) null
      ,     CodigoHCAnterior  varchar(15) null
      ,     PacienteNombre    varchar(100)      null
      ,     MedicoNombre      varchar(100)      null
      ,     IdOrdenAtencion   int   null
      ,     LineaOrdenAtencion      int   null
      ,     IdHospitalizacion int   null
      ,     LineaHospitalizacion    int   null
      ,     IdConsultaExterna int   null
      ,     IdProcedimiento   int   null
      ,     Modalidad   int   null
      ,     IndicadorSeguro   int   null
      ,     IdCita      int   null
      ,     IdPaciente  int   null
      ,     TipoPaciente      int   null
      ,     TipoAtencion      int   null
      ,     IdEspecialidad    int   null
      ,     IdEmpresaAseguradora    int   null
      ,     TipoOrdenAtencion int   null
      ,     Componente  varchar(25) null
      ,     ComponenteNombre  varchar(250)      null
      ,     Compania    varchar(15) null
      ,     Sucursal    varchar(15) null
      ,     IdMedico    int   null
      ,     IndicadorCirugia  int   null
      ,     IndicadorExamenPrincipal     int   null
      ,     PersonaAnt  char(15)    null
      ,     sexo  char(1)     null
      ,     FechaNacimiento   datetime    null
      ,     EstadoCivil char(1)     null
      ,     NivelInstruccion  char(3)     null
      ,     Direccion   varchar(190)      null
      ,     TipoDocumento     char(1)     null
      ,     Documento   char(20)    null
      ,     ApellidoPaterno   varchar(40) null
      ,     ApellidoMaterno   varchar(40) null
      ,     Nombres     varchar(40) null
      ,     LugarNacimiento   varchar(255)      null
      ,     CodigoPostal      char(3)     null
      ,     Provincia   char(3)     null
      ,     Departamento      char(3)     null
      ,     Telefono    varchar(15) null
      ,     CorreoElectronico varchar(50) null
      ,     EsPaciente  varchar(1)  null
      ,     EsEmpresa   varchar(1)  null
      ,     Pais  varchar(100)     null
      ,     EstadoPersona     char(1)     null
      ,     FechaCierreEpiClinico   datetime    null
      ,     EstadoEpiClinico  int   null
      ,     UnidadReplicacion char(4)     null
      ,     UnidadReplicacionEC     char(4)     null
      ,     IdEpisodioAtencion      bigint      null
      ,     EpisodioClinico   int   null
      ,     IdEstablecimientoSalud  int   null
      ,     IdUnidadServicio  int   null
      ,     IdPersonalSalud   int   null
      ,     EpisodioAtencion  int   null
      ,     FechaRegistro     datetime    null
      ,     FechaAtencion     datetime    null
      ,     EstadoEpiAtencion int   null
      ,     UsuarioCreacion   varchar(25) null
      ,     UsuarioModificacion     varchar(25) null
      ,     FechaCreacion     datetime    null
      ,     FechaModificacion datetime    null
      ,     Accion      varchar(25) null
      ,     Version     varchar(25) null
      ,     FechaFin    datetime    null
      ,     FechaOrden  datetime    null
      ,     Comentarios INT null -- varchar(300)      null
      ,     Observaciones INT null -- varchar(300)      null  
      ,     Diagnostico INT null -- varchar(300)      null
      -------------
      ,     UnidadReplicacionHCE    varchar(4)  null
      ,     IdPacienteHCE     int   null
      ,     EpisodioClinicoHCE      int   null
      ,     IdEpisodioAtencionHCE   bigint      null
      ,     SecuenciaHCE      int   null
      ,     CodigoEpisodioClinico   int   null  
      -------------
      ,     Contador    int   null                                          
      )


	  DECLARE @PamaetroLog INT

	  SET @PamaetroLog = 1

	  select @PamaetroLog = IsNull(ValorNumerico,1) 
	  from ge_varios WITH(NOLOCK)
	  WHERE CodigoTabla = 'LOG_VISORES_HCE'
	  AND NEMONICO = 'E_V_ENF'
	

		CREATE TABLE #tipopaciente(IdTablaMaestro INT , IdCodigo INT , IndicadorConcepto INT, Nombre VARCHAR(80))

		INSERT INTO #tipopaciente(IdTablaMaestro, IdCodigo, IndicadorConcepto, Nombre)
		SELECT CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro, CM_CO_TablaMaestroDetalleConcepto.IdCodigo, 
		IsNull(CM_CO_TablaMaestroDetalleConcepto.IndicadorConcepto,1), CM_CO_TablaMaestroDetalle.Nombre
		FROm CM_CO_TablaMaestroDetalle WITH(NOLOCK)
		INNER JOIN  CM_CO_TablaMaestroDetalleConcepto WITH(NOLOCK) ON 
			CM_CO_TablaMaestroDetalle.IdCodigo = CM_CO_TablaMaestroDetalleConcepto.IdCodigo
			AND CM_CO_TablaMaestroDetalle.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
		INNER JOIN CM_CO_TablaMaestroConcepto WITH(NOLOCK) ON CM_CO_TablaMaestroConcepto.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
			AND CM_CO_TablaMaestroConcepto.IdConcepto = CM_CO_TablaMaestroDetalleConcepto.IdConcepto
			AND CM_CO_TablaMaestroConcepto.Concepto = 'APLICA_SEGURO'

              insert into @TABLA_ATENCIONPACIENTE_ENFERM
 
              (tipoListado,CitaTipo,CitaFecha,CitaHora,Origen,NombreEspecialidad,TipoPacienteNombre,CodigoOA,
             ----------
             FechaInicio,Cama,TipoOrdenAtencionNombre,CodigoHC,CodigoHCAnterior,
             PacienteNombre,MedicoNombre,IdOrdenAtencion,LineaOrdenAtencion,IdHospitalizacion,
             LineaHospitalizacion,IdConsultaExterna,IdProcedimiento,Modalidad,IndicadorSeguro,
             IdCita,FechaFin,
             ----------
             IdPaciente,TipoPaciente,TipoAtencion,IdEspecialidad,IdEmpresaAseguradora,
             TipoOrdenAtencion,Componente,ComponenteNombre,Compania,Sucursal,
             IdMedico,IndicadorCirugia,IndicadorExamenPrincipal,
             ---------
             UnidadReplicacionHCE,EstadoEpiAtencion,EpisodioClinicoHCE,IdEpisodioAtencionHCE,IdPacienteHCE,SecuenciaHCE,
             ------------
             PersonaAnt,sexo,FechaNacimiento,EstadoCivil,NivelInstruccion,
             Direccion,TipoDocumento,Documento,ApellidoPaterno,ApellidoMaterno,
             Nombres,LugarNacimiento,CodigoPostal,Provincia,Departamento,
             Telefono,CorreoElectronico,EsPaciente,EsEmpresa,Pais,
             UnidadReplicacionEC,EstadoPersona      
             )      
   SELECT TOP 10000
					'' as tipoListado,
                    NULL as CitaTipo,
                    CitaFecha = SS_AD_OrdenAtencion.FechaEmision,
                    CitaHora = (case when SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion=1 and SS_AD_OrdenAtencionDetalle.Linea=1  then SS_AD_OrdenAtencion.FechaPreparacion else SS_AD_OrdenAtencionDetalle.FechaCreacion end ),  

                    Origen = (case when SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion=11  then 'Interconsulta'
					when SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion=12 then 'Procedimiento'  ELSE
					(CASE SS_AD_OrdenAtencion.TipoAtencion WHEN 3 THEN 'Hospitalización'
					WHEN 2 THEN
					 (CASE
					WHEN ISNULL(SS_CE_ConsultaExterna.TIPOCONSULTA, 1) = 1 THEN 'Emergencia'
					WHEN ISNULL(SS_CE_ConsultaExterna.TIPOCONSULTA, 1) = 2 THEN 'Relevo'
					WHEN ISNULL(SS_CE_ConsultaExterna.TIPOCONSULTA, 1) = 3 THEN 'RE-Ingreso'
					WHEN ISNULL(SS_CE_CONSULTAEXTERNA.TIPOCONSULTA, 1) = 4 THEN 'Interconsulta'
					 END)
					WHEN 1 THEN  'Ambulatorio' ELSE NULL END)END),
             
					NombreEspecialidad = '',
					TipoPacienteNombre = '',
                   -- TipoPacienteNombre = TipoPaciente.Nombre,
                    SS_AD_OrdenAtencion.CodigoOA,
                    -----------
                    SS_AD_OrdenAtencion.FechaInicio,
                    Cama = ENF.NombreCompleto,
                    TipoOrdenAtencionNombre = SS_AD_OrdenAtencionDetalle.SECUENCIALHCE,
                    SS_GE_Paciente.CodigoHC,
                    SS_GE_Paciente.CodigoHCAnterior,
                    PacienteNombre = PersonaMast.NombreCompleto,
					MedicoNombre=MEDICO.NombreCompleto,
                    SS_AD_OrdenAtencion.IdOrdenAtencion,
                    SS_AD_OrdenAtencionDetalle.Linea as LineaOrdenAtencion,
                    IndHospitalizado = IsNull('',1),
                    LineaHospitalizacion = 0,
                    IdConsultaExterna=0,
                    IdProcedimiento = CASE WHEN SS_AD_OrdenAtencionDetalle.Componente='500101'
					THEN SS_AD_OrdenAtencionDetalle.IndicadorEPS  ELSE
					0 end,
                    SS_AD_OrdenAtencion.Modalidad,
					IndicadorSeguro = 1,
                    IdCita=SS_AD_OrdenAtencionDetalle.IdCita,
                    SS_AD_OrdenAtencion.FechaFinal,
                    ---------------------      11          
                    SS_GE_Paciente.IdPaciente,
                    SS_AD_OrdenAtencion.TipoPaciente,
                    SS_AD_OrdenAtencion.TipoAtencion,
                    IdEspecialidad = SS_AD_OrdenAtencionDetalle.Especialidad,
                    SS_AD_OrdenAtencion.IdEmpresaAseguradora,
                    SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion,
                    SS_AD_OrdenAtencionDetalle.Componente Componente,
                    ComponenteNombre =  CASE WHEN SS_AD_OrdenAtencionDetalle.Componente='500101'
					THEN (CASE WHEN SS_AD_OrdenAtencionDetalle.IndicadorEPS=1 THEN 'I. Opinión'
					when SS_AD_OrdenAtencionDetalle.IndicadorEPS=2 THEN 'I. Manejo en Conjunto'
					else 'I. Derivación' end )  ELSE
					'' end,
                    SS_AD_OrdenAtencion.Compania,
                   SS_AD_OrdenAtencion.UnidadReplicacion as Sucursal,
                    IdMedico =  CASE WHEN SS_AD_OrdenAtencionDetalle.Componente='500101' THEN ISNULL(0,SS_AD_OrdenAtencionDetalle.IdPersonaAntUnificacion)
					ELSE SS_CE_ConsultaExterna.Medico end,
                    ---------------------------
                    IndicadorCirugia = IsNull('',1),
                    IndicadorExamenPrincipal = 2,
                    ---------------------------ADD ORIGEN HCE --OBS                    
                    null as UnidadReplicacionHCE,
					ISNULL(	 CASE
                        WHEN ISNULL(SS_AD_ORDENATENCIONDETALLE.TIPOORDENATENCION, 0) = 1
                             OR ISNULL(SS_AD_ORDENATENCIONDETALLE.TIPOORDENATENCION, 0) = 11
                             OR ISNULL(SS_AD_ORDENATENCIONDETALLE.TIPOORDENATENCION, 0) = 21 THEN
                               (SELECT TOP 1 ISNULL(GE_ESTADODOCUMENTO.IdEstado, 1)
                                FROM SS_AD_ORDENATENCIONDETALLE OAD WITH(NOLOCK)
								LEFT JOIN SS_CE_CONSULTAEXTERNA WITH(NOLOCK) ON OAD.IdOrdenAtencion = SS_CE_CONSULTAEXTERNA.IdOrdenAtencion  AND OAD.Linea=SS_CE_CONSULTAEXTERNA.LineaOrdenAtencion
									AND SS_CE_CONSULTAEXTERNA.ESTADO = 2
								LEFT JOIN GE_ESTADODOCUMENTO WITH(NOLOCK) ON GE_ESTADODOCUMENTO.IDESTADO = SS_CE_CONSULTAEXTERNA.ESTADODOCUMENTO
									AND GE_ESTADODOCUMENTO.IDDOCUMENTO = 47 
							   WHERE SS_CE_CONSULTAEXTERNA.IDORDENATENCION = SS_AD_ORDENATENCIONDETALLE.IDORDENATENCION
                                  AND SS_CE_CONSULTAEXTERNA.LINEAORDENATENCION = SS_AD_ORDENATENCIONDETALLE.LINEA                                 
                                 )
                        ELSE
                               (SELECT TOP 1 ISNULL(GE_ESTADODOCUMENTO.IdEstado, 1) -- 0 PENDIENTE 
                                FROM SS_AD_ORDENATENCIONDETALLE OAD WITH(NOLOCK)
								LEFT JOIN SS_PR_PROCEDIMIENTO  ON OAD.IdOrdenAtencion = SS_PR_PROCEDIMIENTO.IdOrdenAtencion  AND OAD.Linea=SS_PR_PROCEDIMIENTO.LineaOrdenAtencion
								 AND SS_PR_PROCEDIMIENTO.ESTADO = 2
								 LEFT JOIN GE_ESTADODOCUMENTO WITH(NOLOCK) ON GE_ESTADODOCUMENTO.IDESTADO = SS_PR_PROCEDIMIENTO.ESTADODOCUMENTO
								AND GE_ESTADODOCUMENTO.IDDOCUMENTO = 48
                                WHERE OAD.IDORDENATENCION = SS_AD_ORDENATENCIONDETALLE.IDORDENATENCION
                                  AND OAD.LINEA = SS_AD_ORDENATENCIONDETALLE.LINEA)
                    END, 0)
					AS EstadoEpiAtencion,
                     EpisodioClinicoHCE=null,
                    IdEpisodioAtencionHCE= NULL,
                    IdPacienteHCE= PRO.ESTADODOCUMENTO,
                    SecuenciaHCE= SS_CE_CONSULTAEXTERNA.ESTADODOCUMENTO,                
                    ---------------------------      
                    PersonaMast.PersonaAnt,
                    PersonaMast.sexo,
                    PersonaMast.FechaNacimiento,
                    PersonaMast.EstadoCivil,
                    PersonaMast.NivelInstruccion,
                     replace(PersonaMast.Direccion,'&#','') as Direccion,  
                    PersonaMast.TipoDocumento,
                    PersonaMast.Documento,
                    PersonaMast.ApellidoPaterno,
                    PersonaMast.ApellidoMaterno,
                    PersonaMast.Nombres,
                    PersonaMast.LugarNacimiento,
                    PersonaMast.CodigoPostal,
                    PersonaMast.Provincia,
                    PersonaMast.Departamento,
                    PersonaMast.Telefono,
                    PersonaMast.CorreoElectronico,
                    PersonaMast.EsPaciente,
                    PersonaMast.EsEmpresa,
                    PersonaMast.Pais,
                    PersonaMast.Origen as UnidadReplicacionEC,
                    PersonaMast.Estado as EstadoPersona
                    FROM SS_AD_OrdenAtencionDetalle WITH(NOLOCK)
					left join SS_AD_OrdenAtencion  WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdOrdenAtencion = SS_AD_OrdenAtencionDetalle.IdOrdenAtencion
					LEFT JOIN SS_CE_ConsultaExterna  WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_CE_ConsultaExterna.IdOrdenAtencion  -- c
					AND SS_AD_OrdenAtencionDetalle.Linea = SS_CE_ConsultaExterna.LineaOrdenAtencion
					LEFT JOIN SS_PR_Procedimiento PRO  WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = PRO.IdOrdenAtencion  -- c
								AND SS_AD_OrdenAtencionDetalle.Linea = PRO.LineaOrdenAtencion
					LEFT JOIN SS_GE_Paciente WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdPaciente = SS_GE_Paciente.IdPaciente
					LEFT JOIN PersonaMast WITH(NOLOCK) ON SS_GE_Paciente.IdPaciente = PersonaMast.Persona
					LEFT JOIN PersonaMast AS MEDICO WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdPersonaAntUnificacion = MEDICO.Persona or SS_CE_ConsultaExterna.Medico =MEDICO.Persona
																	OR PRO.Medico =MEDICO.Persona
                 --   LEFT JOIN SS_GE_Especialidad WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = SS_AD_OrdenAtencionDetalle.Especialidad
                 --   LEFT JOIN CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK) ON TipoPaciente.IdTablaMaestro = 106           AND TipoPaciente.IdCodigo = SS_AD_OrdenAtencion.TipoPaciente
					LEFT JOIN  SS_CE_Enfermeria WITH(NOLOCK) ON SS_CE_Enfermeria.IdOrdenAtencion=SS_AD_OrdenAtencionDetalle.IdOrdenAtencion
					LEFT JOIN PersonaMast AS ENF WITH(NOLOCK) ON SS_CE_Enfermeria.IdEnfermera = ENF.Persona
								WHERE
					SS_AD_OrdenAtencion.EstadoDocumento NOT IN (8,10,11,12,13,14,15,16)            
					AND SS_AD_OrdenAtencion.TipoAtencion =2
					AND SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion in (1)
					AND (@Sucursal is null OR SS_AD_OrdenAtencion.Sucursal= @Sucursal)   
	--				AND (@CodigoHC is null OR IsNUll(SS_GE_Paciente.CodigoHC,'-99') = @CodigoHC)   
	--				AND (@PacienteNombre is null  OR  upper(PersonaMast.NombreCompleto) like '%'+upper(@PacienteNombre)+'%')    
	--				AND (@CodigoOA IS NULL OR upper(SS_AD_OrdenAtencion.CodigoOA) = Right(('0000000000' + @CodigoOA),10))
   					AND (    
							(@FechaInicio is null or  SS_AD_OrdenAtencion.FechaInicio >= @FechaInicio)    
							and    
							(@FechaFin is null or  SS_AD_OrdenAtencion.FechaInicio <= DATEADD(DAY,1,@FechaFin))    
						) 


			UPDATE @TABLA_ATENCIONPACIENTE_ENFERM SET 
				NombreEspecialidad = SS_GE_Especialidad.Nombre
			FROM @TABLA_ATENCIONPACIENTE_ENFERM CC
			LEFT JOIN SS_GE_Especialidad WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = CC.IdEspecialidad

			UPDATE @TABLA_ATENCIONPACIENTE_ENFERM SET 
				IndicadorSeguro = IsNull(#tipopaciente.IndicadorConcepto,1),
				TipoPacienteNombre = #tipopaciente.Nombre
			FROM @TABLA_ATENCIONPACIENTE_ENFERM CC
			INNER JOIN #tipopaciente ON #tipopaciente.IdCodigo = CC.TipoPaciente


		SELECT CONVERT(int,ROW_NUMBER() OVER (ORDER BY FechaInicio  ASC ) )AS NumeroFila ,
				tipoListado = 	'ENFERM_EMERGENCIAS'			, CitaTipo,CitaFecha,CitaHora,Origen,NombreEspecialidad,TipoPacienteNombre,VW_ATENCIONPACIENTE_GENERAL.CodigoOA,            
				FechaInicio,cama = IsNuLL(VW_ATENCIONPACIENTE_GENERAL.Cama,(select top 1 Per.NombreCompleto from PersonaMast Per where Per.Persona = xxx.IdENFERMERA)),TipoOrdenAtencionNombre,CodigoHC,CodigoHCAnterior,
				PacienteNombre,MedicoNombre,VW_ATENCIONPACIENTE_GENERAL.IdOrdenAtencion,VW_ATENCIONPACIENTE_GENERAL.LineaOrdenAtencion,IdHospitalizacion,
				LineaHospitalizacion,IdConsultaExterna,IdProcedimiento,Modalidad,IndicadorSeguro,
				IdCita,        
				VW_ATENCIONPACIENTE_GENERAL.IdPaciente,TipoPaciente,VW_ATENCIONPACIENTE_GENERAL.TipoAtencion,IdEspecialidad,IdEmpresaAseguradora,
				TipoOrdenAtencion,Componente,ComponenteNombre,Compania,Sucursal,
				VW_ATENCIONPACIENTE_GENERAL.IdMedico,IndicadorCirugia,IndicadorExamenPrincipal,        
				PersonaAnt,sexo,FechaNacimiento,EstadoCivil,NivelInstruccion,
				Direccion,TipoDocumento,Documento,ApellidoPaterno,ApellidoMaterno,
				Nombres,LugarNacimiento,CodigoPostal,Provincia,Departamento,
				Telefono,CorreoElectronico,EsPaciente,EsEmpresa,Pais,
				EstadoPersona, FechaCierreEpiClinico,VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion EstadoEpiClinico,VW_ATENCIONPACIENTE_GENERAL.UnidadReplicacion,VW_ATENCIONPACIENTE_GENERAL.UnidadReplicacionEC,
				CASE WHEN VW_ATENCIONPACIENTE_GENERAL.IdOrdenAtencion=0 THEN VW_ATENCIONPACIENTE_GENERAL.IdEpisodioAtencion ELSE XXX.IdEpisodioAtencion END IdEpisodioAtencion,
				CASE WHEN VW_ATENCIONPACIENTE_GENERAL.IdOrdenAtencion=0 THEN VW_ATENCIONPACIENTE_GENERAL.EpisodioClinico ELSE XXX.EpisodioClinico END EpisodioClinico,
				VW_ATENCIONPACIENTE_GENERAL.IdEstablecimientoSalud,VW_ATENCIONPACIENTE_GENERAL.IdUnidadServicio,VW_ATENCIONPACIENTE_GENERAL.IdPersonalSalud,
				CASE WHEN VW_ATENCIONPACIENTE_GENERAL.IdOrdenAtencion=0 THEN VW_ATENCIONPACIENTE_GENERAL.EpisodioAtencion ELSE XXX.EpisodioAtencion END  EpisodioAtencion,
				VW_ATENCIONPACIENTE_GENERAL.FechaRegistro,VW_ATENCIONPACIENTE_GENERAL.FechaAtencion,
				ISNULL(	CASE WHEN XXX.ESTADO IS NOT NULL THEN XXX.ESTADO ELSE		
						CASE  WHEN ISNULL(VW_ATENCIONPACIENTE_GENERAL.TIPOORDENATENCION, 0) = 1
								OR ISNULL(VW_ATENCIONPACIENTE_GENERAL.TIPOORDENATENCION, 0) = 11
								OR ISNULL(VW_ATENCIONPACIENTE_GENERAL.TIPOORDENATENCION, 0) = 21 THEN
								
								CASE	WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 3 then 4 --ANULADO
										WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 1 then 0 --PENDIENTE
										WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 2 then 3 -- ATENDIDO
										WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 0 then 0 --PENDIENTE
										WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 7 then 0 -- PENDIENTE 
								END
							ELSE
								CASE	WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 3 then 4 --ANULADO
										WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 1 then 0 --PENDIENTE
										WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 2 then 3 -- ATENDIDO
										WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 0 then 0 --PENDIENTE
										WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 4 then 3 --5 TERMINADO
										WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 7 then 0 -- PENDIENTE   NO REGISTRADO
								END
										
						END	
							END ,0)
							EstadoEpiAtencion,
						VW_ATENCIONPACIENTE_GENERAL.UsuarioCreacion,VW_ATENCIONPACIENTE_GENERAL.UsuarioModificacion,VW_ATENCIONPACIENTE_GENERAL.FechaCreacion,
						VW_ATENCIONPACIENTE_GENERAL.FechaModificacion,VW_ATENCIONPACIENTE_GENERAL.Accion,VW_ATENCIONPACIENTE_GENERAL.Version   ,FechaFin,
						VW_ATENCIONPACIENTE_GENERAL.FechaOrden,Comentarios,Observaciones,Diagnostico, UnidadReplicacionHCE,IdPacienteHCE,
						EpisodioClinicoHCE,IdEpisodioAtencionHCE,SecuenciaHCE,  CodigoEpisodioClinico,
						1 CONTADOR                                                    
            FROM @TABLA_ATENCIONPACIENTE_ENFERM as VW_ATENCIONPACIENTE_GENERAL  
			LEFT JOIN 	(
				SELECT ISNULL(MAX( A.ESTADO),0)ESTADO ,A.UNIDADREPLICACION,A.IDPACIENTE,
				IDORDENATENCION,LINEAORDENATENCION,CODIGOOA,TIPOATENCION,
				0 HCALTAMEDICA,IdPersonalSalud IDMEDICO ,MAX(A.EpisodioClinico) EpisodioClinico,
				MAX(A.IdEpisodioAtencion) IdEpisodioAtencion, MAX(A.EpisodioAtencion) EpisodioAtencion,
				(select top 1 b.IdPersonalSalud from WEB_ERPSALUD.DBO.SS_HC_EpisodioAtencion b
				where b.IdOrdenAtencion = a.IdOrdenAtencion and b.EpisodioAtencion = a.EpisodioAtencion
				and b.EpisodioClinico = a.EpisodioClinico and b.TipoTrabajador= '02') as IdENFERMERA
				FROM WEB_ERPSALUD.DBO.SS_HC_EpisodioAtencion  A WITH(NOLOCK)
				WHERE A.TIPOATENCION=2  	AND 	A.TipoTrabajador= '08'	
					and (    
						(@FechaInicio is null or  A.FechaAtencion >= @FechaInicio)    
						and    
						(@FechaFin is null or  A.FechaAtencion <= DATEADD(DAY,1,@FechaFin))    
						) 					
					GROUP BY A.UNIDADREPLICACION,A.IDPACIENTE,A.IDORDENATENCION,A.LINEAORDENATENCION,
					A.CODIGOOA,A.TIPOATENCION,IdPersonalSalud,EpisodioAtencion,EpisodioClinico			
				) XXX  ON   XXX.IDORDENATENCION=VW_ATENCIONPACIENTE_GENERAL.IdOrdenAtencion AND VW_ATENCIONPACIENTE_GENERAL.LineaOrdenAtencion=XXX.LINEAORDENATENCION
			WHERE 
			   (@EstadoEpiAtencion is null  OR  
			  ( CASE WHEN XXX.ESTADO IS NOT NULL THEN XXX.ESTADO ELSE		
								CASE	WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 3 then 4 --ANULADO
										WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 1 then 0 --PENDIENTE
										WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 2 then 3 -- ATENDIDO
										WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 0 then 0 --PENDIENTE
										WHEN VW_ATENCIONPACIENTE_GENERAL.EstadoEpiAtencion  = 7 then 0 -- PENDIENTE 
								END
						END ) = @EstadoEpiAtencion)    
   	   ORDER BY tipoListado DESC,CitaFecha,CitaHora

END

GO

CREATE OR ALTER PROCEDURE  [dbo].[SS_HC_ATENCIONES_SOA]
(
       @tipoListado varchar(50) ,
       @CitaTipo varchar(20) ,
       @CitaFecha datetime,
       @Origen varchar(20) ,
       @NombreEspecialidad varchar(80) ,       
       @TipoPacienteNombre varchar(80) ,
       @CodigoOA varchar(25) ,
       @Cama varchar(150) ,
       @TipoOrdenAtencionNombre          varchar(250) ,
       @CodigoHC varchar(15) ,       
       @PacienteNombre      varchar(100) ,
       @MedicoNombre varchar(100) ,
       @IdOrdenAtencion     int ,
       @LineaOrdenAtencion  int ,
       @IdHospitalizacion   int ,       
       @IdCita             int ,
       @IdPaciente         int,
       @TipoPaciente       int,
       @TipoAtencion       int,
       @IdEspecialidad     int,
       
       @IdMedico           int,
       @TipoOrdenAtencion  int,
       @Componente         varchar(25),
       @Compania           varchar(15),
       @Sucursal           varchar(15),
       
       @EstadoPersona             varchar(2),
       @EstadoEpiClinico          int,
       @UnidadReplicacion         varchar(4),
       @UnidadReplicacionEC       varchar(4),
       @IdEpisodioAtencion        bigint,
       
       @EpisodioClinico           int,
       @IdEstablecimientoSalud    int,
       @IdUnidadServicio          int,
       @IdPersonalSalud           int,
       @EpisodioAtencion          bigint,
       
       @FechaRegistro             datetime,
       @FechaAtencion             datetime,
       @EstadoEpiAtencion         int,
       @FechaInicio datetime,
       @FechaFin datetime,
       
       @UsuarioCreacion         varchar(50),
       @FechaCreacion datetime ,
       @UsuarioModificacion     varchar(50) , -- Nombre del COMPONENTE TECNOLOGO
       @FechaModificacion datetime ,          
       @Version varchar(50) ,
       
       @CodigoHCAnterior varchar(15) ,
       @IndicadorCirugia int,  
       @IndicadorExamenPrincipal int,  
       @IndicadorSeguro int,  
       @Modalidad int,  
       
       @sexo char(1),    
       @EstadoCivil char(1),    
       @NivelInstruccion char(3),    
       @EsPaciente varchar(1),  
       @EsEmpresa varchar(1),        
             
       @Inicio int ,  
       @NumeroFilas int ,  
       @ACCION varchar(25)
                   
)

WITH RECOMPILE
AS
BEGIN
SET @UnidadReplicacion     =NULL
       /****TABLA TEMPORAL NOMBRE DE LA VISTA  : VW_ATENCIONPACIENTE_GENERAL*******/
       /***************************************************************************/
       DECLARE @TABLA_ATENCIONPACIENTE_GENERAL table
       (
             --SECUENCIA                int  NOT NULL   IDENTITY PRIMARY KEY,
              NumeroFila int    null
       ,      tipoListado varchar(30)  null
       ,      CitaTipo varchar(9)   null
       ,      CitaFecha datetime     null
       ,      CitaHora datetime     null
       ,      Origen varchar(20)  null
       ,      NombreEspecialidad  varchar(80)  null
       ,      TipoPacienteNombre  varchar(80)  null
       ,      CodigoOA varchar(25)  null
       ,      FechaInicio datetime     null
       ,      Cama varchar(150) null
       ,      TipoOrdenAtencionNombre    varchar(80)  null
       ,      CodigoHC varchar(15)  null
       ,      CodigoHCAnterior varchar(15)  null
       ,      PacienteNombre varchar(100) null
       ,      MedicoNombre varchar(100) null
       ,      IdOrdenAtencion     int    null
       ,      LineaOrdenAtencion  int    null
       ,      IdHospitalizacion   int    null
       ,      LineaHospitalizacion       int    null
       ,      IdConsultaExterna   int    null
       ,      IdProcedimiento     int    null
       ,      Modalidad int    null
       ,      IndicadorSeguro     int    null
       ,      IdCita int    null
       ,      IdPaciente int    null
       ,      TipoPaciente int    null
       ,      TipoAtencion int    null
       ,      IdEspecialidad    int    null
       ,      IdEmpresaAseguradora       int    null
       ,      TipoOrdenAtencion int    null
       ,      Componente varchar(25)  null
       ,      ComponenteNombre  varchar(250) null
       ,      Compania varchar(15)  null
       ,      Sucursal varchar(15)  null
       ,      IdMedico int    null
       ,      IndicadorCirugia  int    null
       ,      IndicadorExamenPrincipal   int    null
       ,      PersonaAnt char(15)     null
       ,      sexo char(1)      null
       ,      FechaNacimiento   datetime     null
       ,      EstadoCivil char(1)      null
       ,      NivelInstruccion  char(3)      null
       ,      Direccion varchar(190) null
       ,      TipoDocumento char(1)      null
       ,      Documento char(20)     null
       ,      ApellidoPaterno   varchar(40)  null
       ,      ApellidoMaterno   varchar(40)  null
       ,      Nombres varchar(40)  null
       ,      LugarNacimiento   varchar(255) null
       ,      CodigoPostal char(3)      null
       ,      Provincia    char(3)      null
       ,      Departamento char(3)      null
       ,      Telefono     varchar(15)  null
       ,      CorreoElectronico   varchar(50)  null
       ,      EsPaciente   varchar(1)   null
       ,      EsEmpresa    varchar(1)   null
       ,      Pais   varchar(100)      null
       ,      EstadoPersona char(1)      null
       ,      FechaCierreEpiClinico      datetime     null
       ,      EstadoEpiClinico    int    null
       ,      UnidadReplicacion   char(4)      null
       ,      UnidadReplicacionEC char(4)      null
       ,      IdEpisodioAtencion  bigint null
       ,      EpisodioClinico     int    null
       ,      IdEstablecimientoSalud     int    null
       ,      IdUnidadServicio    int    null
       ,      IdPersonalSalud     int    null
       ,      EpisodioAtencion    int    null
       ,      FechaRegistro datetime     null
       ,      FechaAtencion datetime     null
       ,      EstadoEpiAtencion   int    null
       ,      UsuarioCreacion     varchar(25)  null
       ,      UsuarioModificacion varchar(25)  null
       ,      FechaCreacion datetime     null
       ,      FechaModificacion   datetime     null
       ,      Accion varchar(25)  null
       ,      Version varchar(25)  null
       ,      FechaFin datetime     null
       ,      FechaOrden datetime     null
       ,      Comentarios INT null --varchar(300)      null
       ,      Observaciones INT null -- varchar(300)      null  
       ,      Diagnostico INT null -- varchar(300)      null
       -------------
       ,      UnidadReplicacionHCE  varchar(4)   null
       ,      IdPacienteHCE int    null
       ,      EpisodioClinicoHCE int    null
       ,      IdEpisodioAtencionHCE bigint null
       ,      SecuenciaHCE int    null
       ,      CodigoEpisodioClinico int    null  
       -------------
       ,      Contador int    null                                                  
       )
       DECLARE @CONTADOR INT                          
       DECLARE @ACCION_END varchar(50)=null    

  DECLARE @TABLA_ATENCIONPACIENTE_GENERAL_TEMP table
      (
            --SECUENCIA             int  NOT NULL   IDENTITY PRIMARY KEY,
            NumeroFila  int   null
      ,     tipoListado varchar(30) null
      ,     CitaTipo    varchar(9)  null
      ,     CitaFecha   datetime    null
      ,     CitaHora    datetime    null
      ,     Origen      varchar(20) null
      ,     NombreEspecialidad      varchar(80) null
      ,     TipoPacienteNombre      varchar(80) null
      ,     CodigoOA    varchar(25) null
      ,     FechaInicio datetime    null
      ,     Cama  varchar(150)      null
      ,     TipoOrdenAtencionNombre varchar(80) null
      ,     CodigoHC    varchar(15) null
      ,     CodigoHCAnterior  varchar(15) null
      ,     PacienteNombre    varchar(100)      null
      ,     MedicoNombre      varchar(100)      null
      ,     IdOrdenAtencion   int   null
      ,     LineaOrdenAtencion      int   null
      ,     IdHospitalizacion int   null
      ,     LineaHospitalizacion    int   null
      ,     IdConsultaExterna int   null
      ,     IdProcedimiento   int   null
      ,     Modalidad   int   null
      ,     IndicadorSeguro   int   null
      ,     IdCita      int   null
      ,     IdPaciente  int   null
      ,     TipoPaciente      int   null
      ,     TipoAtencion      int   null
      ,     IdEspecialidad    int   null
      ,     IdEmpresaAseguradora    int   null
      ,     TipoOrdenAtencion int   null
      ,     Componente  varchar(25) null
      ,     ComponenteNombre  varchar(250)      null
      ,     Compania    varchar(15) null
      ,     Sucursal    varchar(15) null
      ,     IdMedico    int   null
      ,     IndicadorCirugia  int   null
      ,     IndicadorExamenPrincipal     int   null
      ,     PersonaAnt  char(15)    null
      ,     sexo  char(1)     null
      ,     FechaNacimiento   datetime    null
      ,     EstadoCivil char(1)     null
      ,     NivelInstruccion  char(3)     null
      ,     Direccion   varchar(190)      null
      ,     TipoDocumento     char(1)     null
      ,     Documento   char(20)    null
      ,     ApellidoPaterno   varchar(40) null
      ,     ApellidoMaterno   varchar(40) null
      ,     Nombres     varchar(40) null
      ,     LugarNacimiento   varchar(255)      null
      ,     CodigoPostal      char(3)     null
      ,     Provincia   char(3)     null
      ,     Departamento      char(3)     null
      ,     Telefono    varchar(15) null
      ,     CorreoElectronico varchar(50) null
      ,     EsPaciente  varchar(1)  null
      ,     EsEmpresa   varchar(1)  null
      ,     Pais  varchar(100)     null
      ,     EstadoPersona     char(1)     null
      ,     FechaCierreEpiClinico   datetime    null
      ,     EstadoEpiClinico  int   null
      ,     UnidadReplicacion char(4)     null
      ,     UnidadReplicacionEC     char(4)     null
      ,     IdEpisodioAtencion      bigint      null
      ,     EpisodioClinico   int   null
      ,     IdEstablecimientoSalud  int   null
      ,     IdUnidadServicio  int   null
      ,     IdPersonalSalud   int   null
      ,     EpisodioAtencion  int   null
      ,     FechaRegistro     datetime    null
      ,     FechaAtencion     datetime    null
      ,     EstadoEpiAtencion int   null
      ,     UsuarioCreacion   varchar(25) null
      ,     UsuarioModificacion     varchar(25) null
      ,     FechaCreacion     datetime    null
      ,     FechaModificacion datetime    null
      ,     Accion      varchar(25) null
      ,     Version     varchar(25) null
      ,     FechaFin    datetime    null
      ,     FechaOrden  datetime    null
      ,     Comentarios INT null -- varchar(300)      null
      ,     Observaciones INT null -- varchar(300)      null  
      ,     Diagnostico INT null -- varchar(300)      null
      -------------
      ,     UnidadReplicacionHCE    varchar(4)  null
      ,     IdPacienteHCE     int   null
      ,     EpisodioClinicoHCE      int   null
      ,     IdEpisodioAtencionHCE   bigint      null
      ,     SecuenciaHCE      int   null
      ,     CodigoEpisodioClinico   int   null  
      -------------
      ,     Contador    int   null                                          
      )
     
       /***************************************************************************/    
       /*****************************LISTADOS PRINCIPALES***************************************/          

       
       /********************************************************************/
             --MÉDICOS
       /********************************************************************/
		if(@ACCION = 'MED_AMBULATORIO')
		begin

		  --          /**AMBULATORIO*/
		  --          /*********************CONSULTAS*******************************************************
		  --          1. Necesidad de identificar las prestaciones asociadas a un medico
		  --          2. Como va a el manejo de las ordenes de spring salud y los episodios de atención
		  --          3. Identificar los estado de visualización (no visualizamos anulados?)
		  --          *************************************************************************/        /*BY ORLANDO 03032017*/
			IF CONVERT(DATE, @FechaInicio) = CONVERT(DATE, @FechaFin) 
				AND CONVERT(DATE, @FechaInicio) = CONVERT(DATE, GETDATE())
				AND @IdMedico IS NOT NULL AND @IdMedico > 0 AND @CodigoHC IS NULL 
				AND @CodigoHCAnterior IS NULL AND @TipoOrdenAtencion IS NULL AND @PacienteNombre IS NULL 
				AND @CodigoOA IS NULL AND @IdPaciente IS NULL
				AND @IdEspecialidad IS NULL AND @EstadoEpiAtencion IS NULL
			BEGIN
				EXEC [SS_HC_ATENCIONES_SOA_AMBULATORIO_HOY] @tipoListado,@CitaTipo,@CitaFecha,@Origen,@NombreEspecialidad,@TipoPacienteNombre,@CodigoOA,@Cama,
				@TipoOrdenAtencionNombre,@CodigoHC,@PacienteNombre,@MedicoNombre,@IdOrdenAtencion,@LineaOrdenAtencion,@IdHospitalizacion,@IdCita,@IdPaciente,
				@TipoPaciente,@TipoAtencion,@IdEspecialidad,@IdMedico,@TipoOrdenAtencion,@Componente,@Compania,@Sucursal,@EstadoPersona,@EstadoEpiClinico,
				@UnidadReplicacion,@UnidadReplicacionEC,@IdEpisodioAtencion,@EpisodioClinico,@IdEstablecimientoSalud,@IdUnidadServicio,@IdPersonalSalud,
				@EpisodioAtencion,@FechaRegistro,@FechaAtencion,@EstadoEpiAtencion,@FechaInicio,@FechaFin,@UsuarioCreacion,@FechaCreacion,@UsuarioModificacion,
				@FechaModificacion,@Version,@CodigoHCAnterior,@IndicadorCirugia,@IndicadorExamenPrincipal,@IndicadorSeguro,@Modalidad,@sexo,@EstadoCivil,
				@NivelInstruccion,@EsPaciente,@EsEmpresa,@Inicio,@NumeroFilas,@ACCION
			END 
			ELSE 
			BEGIN
				EXEC [SS_HC_ATENCIONES_SOA_AMBULATORIO] @tipoListado,@CitaTipo,@CitaFecha,@Origen,@NombreEspecialidad,@TipoPacienteNombre,@CodigoOA,@Cama,
				@TipoOrdenAtencionNombre,@CodigoHC,@PacienteNombre,@MedicoNombre,@IdOrdenAtencion,@LineaOrdenAtencion,@IdHospitalizacion,@IdCita,@IdPaciente,
				@TipoPaciente,@TipoAtencion,@IdEspecialidad,@IdMedico,@TipoOrdenAtencion,@Componente,@Compania,@Sucursal,@EstadoPersona,@EstadoEpiClinico,
				@UnidadReplicacion,@UnidadReplicacionEC,@IdEpisodioAtencion,@EpisodioClinico,@IdEstablecimientoSalud,@IdUnidadServicio,@IdPersonalSalud,
				@EpisodioAtencion,@FechaRegistro,@FechaAtencion,@EstadoEpiAtencion,@FechaInicio,@FechaFin,@UsuarioCreacion,@FechaCreacion,@UsuarioModificacion,
				@FechaModificacion,@Version,@CodigoHCAnterior,@IndicadorCirugia,@IndicadorExamenPrincipal,@IndicadorSeguro,@Modalidad,@sexo,@EstadoCivil,
				@NivelInstruccion,@EsPaciente,@EsEmpresa,@Inicio,@NumeroFilas,@ACCION
			END
		end
     
     
       if(@ACCION = 'MED_HOSP_CIRUGIA' or @ACCION='MED_EMERGENCIA') --LUKE 21/02/2020
       begin

      
             /**HOSPITALIZACIOPN - CIRUGIA*/
             /*********************CONSULTAS*******************************************************
             1. Necesidad de identificar las prestaciones asociadas a un medico
             2. Como va a el manejo de las ordenes de spring salud y los episodios de atención
             3. Como va a realizarse el manejo de la interconsulta
             4. Como se va a manejar el proceso de asignación de médicos "Clinica el Golf", "Intervensionista El Golf", "Anestesilogo El Golf"
             5. Como identificar la cirugia principal del médico
             6. En caso de existir mas de dos cirugias, como sera el manejo?
             **************************************************************************************/
             insert into @TABLA_ATENCIONPACIENTE_GENERAL
 
              (tipoListado,CitaTipo,CitaFecha,CitaHora,Origen,NombreEspecialidad,TipoPacienteNombre,CodigoOA,
             ----------
             FechaInicio,Cama,TipoOrdenAtencionNombre,CodigoHC,CodigoHCAnterior,
             PacienteNombre,MedicoNombre,IdOrdenAtencion,LineaOrdenAtencion,IdHospitalizacion,
             LineaHospitalizacion,IdConsultaExterna,IdProcedimiento,Modalidad,IndicadorSeguro,
             IdCita,FechaFin,
             ----------
             IdPaciente,TipoPaciente,TipoAtencion,IdEspecialidad,IdEmpresaAseguradora,
             TipoOrdenAtencion,Componente,ComponenteNombre,Compania,Sucursal,
             IdMedico,IndicadorCirugia,IndicadorExamenPrincipal,
             ---------
             UnidadReplicacionHCE,EstadoEpiAtencion,EpisodioClinicoHCE,IdEpisodioAtencionHCE,IdPacienteHCE,SecuenciaHCE,
             ------------
             PersonaAnt,sexo,FechaNacimiento,EstadoCivil,NivelInstruccion,
             Direccion,TipoDocumento,Documento,ApellidoPaterno,ApellidoMaterno,
             Nombres,LugarNacimiento,CodigoPostal,Provincia,Departamento,
             Telefono,CorreoElectronico,EsPaciente,EsEmpresa,Pais,
             UnidadReplicacionEC,EstadoPersona      
             )      
             select * from
             (
                    SELECT
                    'MED_HOSP_CIRUGIA' as tipoListado,
                    ---------7
                    NULL as CitaTipo,
                    CitaFecha = SS_HO_Hospitalizacion.FechaHospitalizacion,
                    CitaHora = SS_HO_Hospitalizacion.FechaHospitalizacion,
                    Origen = (CASE SS_HO_Hospitalizacion.TipoHospitalizacion WHEN 1 THEN 'Hospitalización' WHEN 2 THEN 'Emergencia' WHEN 3 THEN 'Ambulatorio' ELSE NULL END),

                    NombreEspecialidad = SS_GE_Especialidad.Nombre,
                    TipoPacienteNombre = TipoPaciente.Nombre,
                    SS_AD_OrdenAtencion.CodigoOA,
                    -----------
                    SS_AD_OrdenAtencion.FechaInicio,
                    Cama = SS_GE_Consultorio.Nombre,
                    TipoOrdenAtencionNombre = TipoOrdenAtencion.Nombre,
                    SS_GE_Paciente.CodigoHC,
                    SS_GE_Paciente.CodigoHCAnterior,
                    PacienteNombre = PersonaMast.NombreCompleto,
                    PersonaMast.Busqueda as MedicoNombre,
                    SS_AD_OrdenAtencion.IdOrdenAtencion,
                    LineaOrdenAtencion = 0,
                    SS_HO_Hospitalizacion.IdHospitalizacion,
                    LineaHospitalizacion = 0,
                    0 as IdConsultaExterna,
                    IdProcedimiento = 0,
                    SS_AD_OrdenAtencion.Modalidad,
                    IndicadorSeguro = ( SELECT IsNull(CM_CO_TablaMaestroDetalleConcepto.IndicadorConcepto,1)
                                                      FROM CM_CO_TablaMaestroDetalleConcepto WITH(NOLOCK) INNER JOIN CM_CO_TablaMaestroConcepto WITH(NOLOCK) ON CM_CO_TablaMaestroConcepto.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
                                                            AND CM_CO_TablaMaestroConcepto.IdConcepto = CM_CO_TablaMaestroDetalleConcepto.IdConcepto
                                                            AND CM_CO_TablaMaestroConcepto.Concepto = 'APLICA_SEGURO'
                                                      WHERE TipoPaciente.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
                                                            AND TipoPaciente.IdCodigo = CM_CO_TablaMaestroDetalleConcepto.IdCodigo),
                    0 as IdCita,
                    SS_AD_OrdenAtencion.FechaFinal,
                    ---------------------      11          
                    SS_GE_Paciente.IdPaciente,
                    SS_AD_OrdenAtencion.TipoPaciente,
                    SS_AD_OrdenAtencion.TipoAtencion,
                    IdEspecialidad = SS_AD_OrdenAtencion.Especialidad,
                    SS_AD_OrdenAtencion.IdEmpresaAseguradora,
                    SS_AD_OrdenAtencion.TipoOrdenAtencion,
                    0 AS Componente,
                    ComponenteNombre = '',

                    SS_AD_OrdenAtencion.Compania,
                    SS_AD_OrdenAtencion.Sucursal,
                    IdMedico = '',
                    ---------------------------
                    IndicadorCirugia = IsNull('',1),
                    IndicadorExamenPrincipal = 2,
                    ---------------------------ADD ORIGEN HCE --OBS                    
                    null as UnidadReplicacionHCE,
						Case
											WHEN SS_HO_Hospitalizacion.estadodocumento = 13 then 1 --ANULADO
											WHEN SS_HO_Hospitalizacion.estadodocumento = 3 then 0 --PENDIENTE
											WHEN SS_HO_Hospitalizacion.estadodocumento = 8 then 3 -- ATENDIDO
						WHEN SS_HO_Hospitalizacion.estadodocumento = 10 then 3 -- ATENDIDO
						WHEN SS_HO_Hospitalizacion.estadodocumento = 12 then 3 -- ATENDIDO
						WHEN SS_HO_Hospitalizacion.estadodocumento = 11 then 3 -- ATENDIDO
						WHEN SS_HO_Hospitalizacion.estadodocumento = 15 then 3 -- ATENDIDO
						WHEN SS_HO_Hospitalizacion.estadodocumento = 16 then 3 -- ATENDIDO
                    Else
                    SS_HO_Hospitalizacion.estadodocumento
                    end  AS EstadoEpiAtencion,
                     EpisodioClinicoHCE=null,
                    IdEpisodioAtencionHCE= NULL,
                    IdPacienteHCE= NULL,
                    SecuenciaHCE=null,                
                    ---------------------------      
                    PersonaMast.PersonaAnt,
                    PersonaMast.sexo,
                    PersonaMast.FechaNacimiento,
                    PersonaMast.EstadoCivil,
                    PersonaMast.NivelInstruccion,
                     replace(PersonaMast.Direccion,'&#','') as Direccion,  
                    PersonaMast.TipoDocumento,
                    PersonaMast.Documento,
                    PersonaMast.ApellidoPaterno,
                    PersonaMast.ApellidoMaterno,
                    PersonaMast.Nombres,
                    PersonaMast.LugarNacimiento,
                    PersonaMast.CodigoPostal,
                    PersonaMast.Provincia,
                    PersonaMast.Departamento,
                    PersonaMast.Telefono,
                    PersonaMast.CorreoElectronico,
                    PersonaMast.EsPaciente,
                    PersonaMast.EsEmpresa,
                    PersonaMast.Pais,
                    PersonaMast.Origen as UnidadReplicacionEC,
                    PersonaMast.Estado as EstadoPersona

                    FROM SS_AD_OrdenAtencion WITH(NOLOCK) INNER JOIN SS_HO_Hospitalizacion WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdOrdenAtencion = SS_HO_Hospitalizacion.IdOrdenAtencion
                    LEFT JOIN PersonaMast WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdPaciente = PersonaMast.Persona
                    LEFT JOIN SS_GE_Paciente WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdPaciente = SS_GE_Paciente.IdPaciente
                    LEFT JOIN SS_GE_Especialidad WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = SS_AD_OrdenAtencion.Especialidad
                    LEFT JOIN CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK) ON TipoPaciente.IdTablaMaestro = 106
                           AND TipoPaciente.IdCodigo = SS_AD_OrdenAtencion.TipoPaciente
                    LEFT JOIN CM_CO_TablaMaestroDetalle TipoOrdenAtencion WITH(NOLOCK) ON TipoOrdenAtencion.IdTablaMaestro = 101
                           AND TipoOrdenAtencion.IdCodigo = SS_AD_OrdenAtencion.TipoOrdenAtencion
             /*     LEFT JOIN CM_CO_Componente WITH(NOLOCK) ON SS_HO_Hospitalizacion.Componente = CM_CO_Componente.CodigoComponente*/
                    LEFT JOIN SS_GE_Consultorio WITH(NOLOCK) ON SS_GE_Consultorio.IdConsultorio = SS_HO_Hospitalizacion.Cama
             /*     LEFT JOIN PersonaMast Medico WITH(NOLOCK) ON Medico.Persona = SS_HO_Hospitalizacion.MedicoResponsable*/
                    WHERE
					SS_HO_Hospitalizacion.EstadoDocumento NOT IN (1,2,8,10,11,12,13,14,15,16)             AND
					SS_AD_OrdenAtencion.TipoAtencion in (2,3)

                    ----EXTRAS---
                    and (@UnidadReplicacion is null OR SS_AD_OrdenAtencion.UnidadReplicacion= @UnidadReplicacion)                                          

             ) VW_ATENCIONPACIENTE_GENERAL
             where              
             -----------------------------------------                                        
             (@CodigoHC is null OR VW_ATENCIONPACIENTE_GENERAL.CodigoHC = @CodigoHC)    
             and (@CodigoHCAnterior is null OR VW_ATENCIONPACIENTE_GENERAL.CodigoHCAnterior = @CodigoHCAnterior)    
             and (@TipoOrdenAtencion is null OR VW_ATENCIONPACIENTE_GENERAL.TipoOrdenAtencion = @TipoOrdenAtencion)              

             and (@PacienteNombre is null  OR @PacienteNombre =''  OR  upper(VW_ATENCIONPACIENTE_GENERAL.PacienteNombre) like '%'+upper(@PacienteNombre)+'%')                                      
             and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE_GENERAL.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
             --OBS--and (@IdPersonalSalud is null OR VW_ATENCIONPACIENTE.IdPersonalSalud = @IdPersonalSalud)    
             and (    
                    (@FechaInicio is null or  VW_ATENCIONPACIENTE_GENERAL.FechaInicio >= @FechaInicio)    
                    and    
                    (@FechaFin is null or  VW_ATENCIONPACIENTE_GENERAL.FechaInicio <= DATEADD(DAY,1,@FechaFin))    
             )    
             and (@IdPaciente is null OR  @IdPaciente = 0 or  VW_ATENCIONPACIENTE_GENERAL.IdPaciente = @IdPaciente)
             
             set @ACCION_END = 'TERMINARLISTARPAG'
                   
       end
	  if(@ACCION='MED_EMERGENCIA2') --LUKE 21/02/2020
       begin


			 exec [dbo].[SS_HC_ATENCIONES_SOA_EMERGENCIA2]  @tipoListado,@CitaTipo,@CitaFecha,@Origen,@NombreEspecialidad,@TipoPacienteNombre,@CodigoOA,@Cama,
			@TipoOrdenAtencionNombre,@CodigoHC,@PacienteNombre,@MedicoNombre,@IdOrdenAtencion,@LineaOrdenAtencion,@IdHospitalizacion,@IdCita,@IdPaciente,
			@TipoPaciente,@TipoAtencion,@IdEspecialidad,@IdMedico,@TipoOrdenAtencion,@Componente,@Compania,@Sucursal,@EstadoPersona,@EstadoEpiClinico,
			@UnidadReplicacion,@UnidadReplicacionEC,@IdEpisodioAtencion,@EpisodioClinico,@IdEstablecimientoSalud,@IdUnidadServicio,@IdPersonalSalud,
			@EpisodioAtencion,@FechaRegistro,@FechaAtencion,@EstadoEpiAtencion,@FechaInicio,@FechaFin,@UsuarioCreacion,@FechaCreacion,@UsuarioModificacion,
			@FechaModificacion,@Version,@CodigoHCAnterior,@IndicadorCirugia,@IndicadorExamenPrincipal,@IndicadorSeguro,@Modalidad,@sexo,@EstadoCivil,
			@NivelInstruccion,@EsPaciente,@EsEmpresa,@Inicio,@NumeroFilas,@ACCION

                   
       end
	if(@ACCION = 'ENFERM_EMERGENCIAS')-- luke 21-02-2020
       begin
     
             /**CAMBIO 01/10/2015*/
       
             /**HOSPITALIZACIOPN - CIRUGIA*/
             /*********************CONSULTAS*******************************************************
             1. Necesidad de identificar las prestaciones asociadas a un medico
             2. Como va a el manejo de las ordenes de spring salud y los episodios de atención
             3. Como va a realizarse el manejo de la interconsulta
             4. Como se va a manejar el proceso de asignación de médicos "Clinica el Golf", "Intervensionista El Golf", "Anestesilogo El Golf"
             5. Como identificar la cirugia principal del médico
             6. En caso de existir mas de dos cirugias, como sera el manejo?
             **************************************************************************************/

			IF CONVERT(DATE, @FechaInicio) = CONVERT(DATE, @FechaFin) 
				AND CONVERT(DATE, @FechaInicio) = CONVERT(DATE, GETDATE())
				AND @CodigoHC IS NULL 
				AND @PacienteNombre IS NULL 
				AND @CodigoOA IS NULL
			BEGIN
				EXEC [SS_HC_ATENCIONES_SOA_ENFERM_EMERGENCIAS_HOY] @tipoListado,@CitaTipo,@CitaFecha,@Origen,@NombreEspecialidad,@TipoPacienteNombre,@CodigoOA,@Cama,
				@TipoOrdenAtencionNombre,@CodigoHC,@PacienteNombre,@MedicoNombre,@IdOrdenAtencion,@LineaOrdenAtencion,@IdHospitalizacion,@IdCita,@IdPaciente,
				@TipoPaciente,@TipoAtencion,@IdEspecialidad,@IdMedico,@TipoOrdenAtencion,@Componente,@Compania,@Sucursal,@EstadoPersona,@EstadoEpiClinico,
				@UnidadReplicacion,@UnidadReplicacionEC,@IdEpisodioAtencion,@EpisodioClinico,@IdEstablecimientoSalud,@IdUnidadServicio,@IdPersonalSalud,
				@EpisodioAtencion,@FechaRegistro,@FechaAtencion,@EstadoEpiAtencion,@FechaInicio,@FechaFin,@UsuarioCreacion,@FechaCreacion,@UsuarioModificacion,
				@FechaModificacion,@Version,@CodigoHCAnterior,@IndicadorCirugia,@IndicadorExamenPrincipal,@IndicadorSeguro,@Modalidad,@sexo,@EstadoCivil,
				@NivelInstruccion,@EsPaciente,@EsEmpresa,@Inicio,@NumeroFilas,@ACCION    
			END 
			ELSE
			BEGIN
				EXEC [SS_HC_ATENCIONES_SOA_ENFERM_EMERGENCIAS] @tipoListado,@CitaTipo,@CitaFecha,@Origen,@NombreEspecialidad,@TipoPacienteNombre,@CodigoOA,@Cama,
				@TipoOrdenAtencionNombre,@CodigoHC,@PacienteNombre,@MedicoNombre,@IdOrdenAtencion,@LineaOrdenAtencion,@IdHospitalizacion,@IdCita,@IdPaciente,
				@TipoPaciente,@TipoAtencion,@IdEspecialidad,@IdMedico,@TipoOrdenAtencion,@Componente,@Compania,@Sucursal,@EstadoPersona,@EstadoEpiClinico,
				@UnidadReplicacion,@UnidadReplicacionEC,@IdEpisodioAtencion,@EpisodioClinico,@IdEstablecimientoSalud,@IdUnidadServicio,@IdPersonalSalud,
				@EpisodioAtencion,@FechaRegistro,@FechaAtencion,@EstadoEpiAtencion,@FechaInicio,@FechaFin,@UsuarioCreacion,@FechaCreacion,@UsuarioModificacion,
				@FechaModificacion,@Version,@CodigoHCAnterior,@IndicadorCirugia,@IndicadorExamenPrincipal,@IndicadorSeguro,@Modalidad,@sexo,@EstadoCivil,
				@NivelInstruccion,@EsPaciente,@EsEmpresa,@Inicio,@NumeroFilas,@ACCION   
			END


               
       end

  	 if(@ACCION='MED_AUDITORIA')
	   begin
	   	   PRINT '¨Paso 1 ' + CONVERT(varchar,getdate(),9)
		 
			insert into @TABLA_ATENCIONPACIENTE_GENERAL_TEMP
           (tipoListado,CitaTipo,CitaFecha,CitaHora,Origen,NombreEspecialidad,TipoPacienteNombre,CodigoOA,
					----------
					  Cama, FechaInicio,TipoOrdenAtencionNombre,CodigoHC,CodigoHCAnterior,
					PacienteNombre,MedicoNombre,IdOrdenAtencion,LineaOrdenAtencion,IdHospitalizacion,
					LineaHospitalizacion,IdConsultaExterna,IdProcedimiento,Modalidad,IndicadorSeguro,
					IdCita,FechaFin,
					----------
					IdPaciente,TipoPaciente,TipoAtencion,IdEspecialidad,IdEmpresaAseguradora,
					TipoOrdenAtencion,Componente,ComponenteNombre,Compania,Sucursal,
					IdMedico,IndicadorCirugia,IndicadorExamenPrincipal,
					---------
					UnidadReplicacionHCE,EstadoEpiAtencion,EpisodioClinicoHCE,IdEpisodioAtencionHCE,IdPacienteHCE,SecuenciaHCE,
					------------
					PersonaAnt,sexo,FechaNacimiento,EstadoCivil,NivelInstruccion,
					Direccion,TipoDocumento,Documento,ApellidoPaterno,ApellidoMaterno,
					Nombres,LugarNacimiento,CodigoPostal,Provincia,Departamento,
					Telefono,CorreoElectronico,EsPaciente,EsEmpresa,Pais,
					EstadoPersona,UnidadReplicacionEC,Version,FechaCierreEpiClinico
					)   
		 SELECT --top 50
                  'MED_AUDITORIA' as tipoListado,
                  ---------7
                  CitaTipo = (CASE SS_CC_Cita.TipoCita WHEN 1 THEN 'Normal' WHEN 2 THEN 'Adicional' ELSE 'Normal' END),
                  CitaFecha = SS_CC_Cita.FechaCita,
                  CitaHora = SS_CC_Cita.FechaCita,
                  Origen = (CASE WHEN SS_AD_OrdenAtencion.IdOrdenAtencion IS NULL THEN 'Cita' ELSE CASE WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 11) THEN 'Consulta' ELSE 'Procedimiento' END END),
                  NombreEspecialidad = SS_GE_Especialidad.Nombre,
                  TipoPacienteNombre = TipoPaciente.Nombre,
                  ISNULL(SS_AD_OrdenAtencion.CodigoOA,'') AS CodigoOA,
                  ----------
                   SS_CC_Cita.Comentario as Cama,
				ISNULL(SS_AD_OrdenAtencion.FechaInicio,SS_CC_Cita.FechaCita) FechaInicio ,
                  TipoOrdenAtencionNombre = ISNULL(TipoOrdenAtencion.Nombre  , 'Consulta'),
                  SS_GE_Paciente.CodigoHC,
                  SS_GE_Paciente.CodigoHCAnterior,
                  PacienteNombre = paciente.NombreCompleto,
                  --NOMBRE DE MEDICO MEDICO.Busqueda
                  MEDICO.Busqueda as MedicoNombre,
                  IsNull(SS_AD_OrdenAtencion.IdOrdenAtencion,0) AS IdOrdenAtencion,
                  IsNull(SS_AD_OrdenAtencionDetalle.Linea,0) AS LineaOrdenAtencion ,
                  IsNull(SS_AD_OrdenAtencion.IdContrato,0) as IdHospitalizacion,
                  0 AS LineaHospitalizacion ,
                  SS_CE_ConsultaExterna.IdConsultaExterna,
                  SS_PR_Procedimiento.IdProcedimiento,
                  case
					when SS_AD_OrdenAtencion.TipoPaciente='19' then '19'
					when SS_AD_OrdenAtencion.TipoPaciente='4' then '4'
					when SS_AD_OrdenAtencion.modalidad='1' then '1'
					when  SS_AD_OrdenAtencion.modalidad='2' then '2'
					else
					SS_AD_OrdenAtencion.tipopaciente
					end as Modalidad,

                  IndicadorSeguro = (   
								SELECT IsNull(CM_CO_TablaMaestroDetalleConcepto.IndicadorConcepto,1)
                                FROM CM_CO_TablaMaestroDetalleConcepto WITH(NOLOCK)
								INNER JOIN CM_CO_TablaMaestroConcepto WITH(NOLOCK) ON CM_CO_TablaMaestroConcepto.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
                                        AND CM_CO_TablaMaestroConcepto.IdConcepto = CM_CO_TablaMaestroDetalleConcepto.IdConcepto
                                        AND CM_CO_TablaMaestroConcepto.Concepto = 'APLICA_SEGURO'
                                WHERE IsNull(TipoPaciente.IdTablaMaestro,-99) = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
                                        AND IsNull(TipoPaciente.IdCodigo,-99) = CM_CO_TablaMaestroDetalleConcepto.IdCodigo),

                  SS_CC_Cita.IdCita,
                  SS_AD_OrdenAtencion.FechaFinal as FechaFin,
                  ---------------------   11
                  SS_GE_Paciente.IdPaciente,
                  SS_AD_OrdenAtencion.TipoPaciente,
                  SS_AD_OrdenAtencion.TipoAtencion,
                  IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_CC_HORARIO.IdEspecialidad),
                  SS_AD_OrdenAtencion.IdEmpresaAseguradora,
                  SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion,
                  SS_AD_OrdenAtencionDetalle.Componente,
                  ComponenteNombre = CM_CO_Componente.Nombre,
                   IsNull( SS_AD_OrdenAtencion.Compania ,'00000000') AS Compania,
                   case when SS_AD_OrdenAtencion.Sucursal is null then SS_CC_Cita.UnidadReplicacion ELSE  SS_AD_OrdenAtencion.Sucursal END AS Sucursal,
                  IdMedico = IsNull(IsNull(SS_CE_ConsultaExterna.Medico, SS_PR_Procedimiento.Medico), SS_CC_Horario.Medico),
                  ------------------------
                  0 as IndicadorCirugia,
                  0 as IndicadorExamenPrincipal,
                  ---------------------------ADD ORIGEN HCE --OBS                  
                  case when SS_AD_OrdenAtencion.Sucursal is null then SS_CC_Cita.UnidadReplicacion ELSE  SS_AD_OrdenAtencion.Sucursal END AS UnidadReplicacionHCE,

				CASE	WHEN  SS_AD_OrdenAtencion.IdOrdenAtencion IS NULL 
					THEN 1 --PROGRAMADO
				ELSE
					CASE	WHEN  SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 11, 21 ) 
						THEN	CASE	WHEN  IsNull(SS_CE_ConsultaExterna.IdConsultaExterna,0) > 0 
											THEN	CASE	WHEN SS_CE_ConsultaExterna.EstadoDocumento = 1 
																then 2 --PENDIENTE	
															WHEN SS_CE_ConsultaExterna.EstadoDocumento = 2 
																then 3 --ATENDIDO	
															WHEN SS_CE_ConsultaExterna.EstadoDocumento = 3 
																then 4 --ANULADO
															ELSE 0 
													END
										ELSE	CASE	WHEN ss_cc_cita.estadodocumento = 2 
															then 1 --PROGRAMADO
														WHEN ss_cc_cita.estadodocumento = 3 
															then 0 --PENDIENTE
														WHEN SS_CC_CITA.EstadoDocumento = 4 
															then 2 --EN ATENCION
														WHEN SS_CC_CITA.EstadoDocumento = 8 
															then 3 --ATENDIDO
														WHEN SS_CC_CITA.EstadoDocumento = 5 
															then 4 --ANULADO
														ELSE 0 
												END
								END

					WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (  2, 4, 5, 6, 7, 8, 9, 10, 12, 14,16, 17, 18, 19,20,24, 25, 26, 27, 23, 15, 33, 34, 37, 38, 39, 29, 30, 31, 32, 28 ) 
						THEN	CASE	WHEN IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) = -99 AND SS_CC_Cita.EstadoDocumento = 3 
											THEN 0
										WHEN IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) = -99 AND SS_CC_Cita.EstadoDocumento = 2 
											THEN 1
										WHEN IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) = -99 AND SS_CC_Cita.EstadoDocumento = 8 
											THEN 0
										WHEN IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) = -99 AND SS_CC_Cita.EstadoDocumento = 4 
											THEN 0
										WHEN SS_CC_Cita.EstadoDocumento = 4  AND SS_PR_Procedimiento.EstadoDocumento = 3 
											THEN 4 --ANULADO
										WHEN IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) <> -99 AND SS_PR_Procedimiento.EstadoDocumento = 2 
											THEN 3
										WHEN IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) <> -99 AND SS_PR_Procedimiento.EstadoDocumento = 4 
											THEN 5  --TERMINADO
										WHEN IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) <> -99 AND SS_PR_Procedimiento.EstadoDocumento = 1 
											THEN 2
										ELSE -99
								END  
							ELSE ss_cc_cita.estadodocumento
					END  
				END AS EstadoEpiAtencion,                        
                 NULL AS  EpisodioClinicoHCE,
                 NULL AS IDEPISODIOAtencionHCE,
                 NULL AS IdPacienteHCE,
                 NULL AS SecuencialHCE,            
                  ---------------------------  
                  PACIENTE.PersonaAnt,
                  PACIENTE.sexo,
                  PACIENTE.FechaNacimiento,
                  PACIENTE.EstadoCivil,
                  PACIENTE.NivelInstruccion,
                    replace(PACIENTE.Direccion,'&#','') as Direccion,
                  PACIENTE.TipoDocumento,
                  PACIENTE.Documento,
                  PACIENTE.ApellidoPaterno,
                  PACIENTE.ApellidoMaterno,
                  PACIENTE.Nombres,
                  PACIENTE.LugarNacimiento,
                  PACIENTE.CodigoPostal,
                  PACIENTE.Provincia,
                  PACIENTE.Departamento,
                  PACIENTE.Telefono,
                  PACIENTE.CorreoElectronico,
                  PACIENTE.EsPaciente,
                  PACIENTE.EsEmpresa,
                  PACIENTE.Pais,
                  PACIENTE.Estado as EstadoPersona,
                  case when PACIENTE.Origen  IS NULL then SS_CC_Cita.UnidadReplicacion ELSE  PACIENTE.Origen  END AS  UnidadReplicacionEC,               
				  CASE WHEN SS_AD_OrdenAtencion.IdOrdenAtencion IS NULL THEN 'Ambulatoria' ELSE TipoAtencion.Nombre END  as TipoAtencionDescX,
				  CM_CA_Transaccion.FechaPago FechaCierreEpiClinico
				FROM SS_CC_Cita  WITH(NOLOCK)
				LEFT JOIN SS_CC_Horario  WITH(NOLOCK) ON SS_CC_Horario.IdHorario = SS_CC_Cita.IdHorario  
				LEFT JOIN SS_AD_OrdenAtencionDetalle  WITH(NOLOCK) ON SS_CC_Cita.IdCita = SS_AD_OrdenAtencionDetalle.IdCita  
				LEFT JOIN SS_AD_OrdenAtencion  WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_AD_OrdenAtencion.IdOrdenAtencion  
				LEFT JOIN SS_CE_ConsultaExterna WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_CE_ConsultaExterna.IdOrdenAtencion  
							AND SS_AD_OrdenAtencionDetalle.Linea = SS_CE_ConsultaExterna.LineaOrdenAtencion  
				LEFT JOIN GE_EstadoDocumento WITH(NOLOCK) ON GE_EstadoDocumento.IdEstado = ISNULL(SS_CE_ConsultaExterna.EstadoDocumento, 1)  
							AND GE_EstadoDocumento.IdDocumento = 47
				LEFT JOIN SS_GE_Paciente  WITH(NOLOCK) ON SS_GE_Paciente.IdPaciente = SS_AD_OrdenAtencion.IdPaciente  
				LEFT JOIN PersonaMast AS Paciente WITH(NOLOCK) ON Paciente.Persona = SS_GE_Paciente.IdPaciente
				LEFT JOIN PERSONAMAST AS MEDICO WITH(NOLOCK) ON SS_CC_CITA.IdMedico=MEDICO.PERSONA  
				LEFT JOIN SS_PR_Procedimiento WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_PR_Procedimiento.IdOrdenAtencion
							AND SS_AD_OrdenAtencionDetalle.Linea = SS_PR_Procedimiento.LineaOrdenAtencion
                 LEFT JOIN SS_GE_Especialidad WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_CC_HORARIO.IdEspecialidad)
                 LEFT JOIN CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK) ON TipoPaciente.IdTablaMaestro = 106
							AND TipoPaciente.IdCodigo = IsNull(SS_AD_OrdenAtencion.TipoPaciente,-99)
                 LEFT JOIN CM_CO_TablaMaestroDetalle TipoOrdenAtencion WITH(NOLOCK) ON TipoOrdenAtencion.IdTablaMaestro = 101
							AND TipoOrdenAtencion.IdCodigo = SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion
                 LEFT JOIN CM_CO_Componente WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.Componente = CM_CO_Componente.CodigoComponente  
                  --------------
                 LEFT JOIN SS_GE_TipoAtencion TipoAtencion WITH(NOLOCK)  ON (TipoAtencion.IdTipoAtencion = SS_AD_OrdenAtencion.TipoAtencion)                      
				   --ECM  -- se agrego jordan para la fecha de pago
				LEFT JOIN CM_CA_TransaccionDetalle WITH(NOLOCK) ON CM_CA_TransaccionDetalle.IdOAOrigen = SS_AD_OrdenAtencionDetalle.IdOrdenAtencion
				AND CM_CA_TransaccionDetalle.IdOALineaOrigen = SS_AD_OrdenAtencionDetalle.Linea
				LEFT JOIN CM_CA_Transaccion WITH(NOLOCK) ON CM_CA_Transaccion.IdTransaccion = (CASE WHEN IsNull(CM_CA_TransaccionDetalle.IdTransaccion,-99999) <> -99999 THEN CM_CA_TransaccionDetalle.IdTransaccion
				ELSE SS_AD_OrdenAtencion.IdTransaccion END)		
			
			WHERE
				IsNull(SS_AD_OrdenAtencion.TipoAtencion,1) IN (1,2)  /*BY JORDAN 28092021 - INC.*/
				AND  IsNull(SS_CC_Cita.Estado,-99)  <>1 /*BY JORDAN 16092021 - INC.1571*/
				AND (@CodigoHC is null OR IsNUll(SS_GE_Paciente.CodigoHC,'-99') = @CodigoHC)   
				AND (@Sucursal is null OR SS_AD_OrdenAtencion.UnidadReplicacion = @Sucursal)
				AND (@TipoOrdenAtencion is null OR IsNull(SS_AD_OrdenAtencion.TipoOrdenAtencion,-99) = @TipoOrdenAtencion)  
				AND (@PacienteNombre is null  OR @PacienteNombre =''  OR  upper(PACIENTE.NombreCompleto) like '%'+upper(@PacienteNombre)+'%')                                
				AND (@CodigoOA is  null OR  upper(SS_AD_OrdenAtencion.CodigoOA) like '%'+upper(@CodigoOA)+'%')  
				AND (@MedicoNombre is null  OR @MedicoNombre =''  OR  upper(MEDICO.Busqueda) like '%'+upper(@MedicoNombre)+'%')  
			--	AND (@IdMedico is null OR IsNull(MEDICO.PERSONA ,-99) = @IdMedico)  
				AND (    
                    (@FechaInicio is null or  SS_CC_Cita.FechaCita >= @FechaInicio)    
                    and    
                    (@FechaFin is null or  SS_CC_Cita.FechaCita <= DATEADD(DAY,1,@FechaFin))    
					) 
				AND (@IdPaciente is null OR  @IdPaciente = 0 or  IsNUll(SS_GE_Paciente.IdPaciente,-99) = @IdPaciente)  
				AND IsNull( SS_AD_OrdenAtencion.UnidadReplicacion, '-99') = @Sucursal
				AND (@IdEspecialidad is null OR IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, IsNull(SS_CC_HORARIO.IdEspecialidad,-99)) =@IdEspecialidad)

				PRINT '¨Paso 2 ' + CONVERT(varchar,getdate(),9)
				SELECT @CONTADOR = COUNT(*) from @TABLA_ATENCIONPACIENTE_GENERAL_TEMP 
				WHERE 	(@EstadoEpiAtencion is null OR EstadoEpiAtencion = @EstadoEpiAtencion) 
			
				PRINT '¨Paso 3 ' + CONVERT(varchar,getdate(),9)
				update @TABLA_ATENCIONPACIENTE_GENERAL_TEMP set Contador = @CONTADOR
				WHERE 				(@EstadoEpiAtencion is null OR EstadoEpiAtencion = @EstadoEpiAtencion) 

				PRINT '¨Paso 4 ' + CONVERT(varchar,getdate(),9)
				--SELECT * from @TABLA_ATENCIONPACIENTE_GENERAL_TEMP 
				 SELECT CONVERT(int,ROW_NUMBER() OVER (ORDER BY FechaInicio  ASC ) )AS NumeroFila ,
				tipoListado,CitaTipo,CitaFecha,CitaHora,Origen,NombreEspecialidad,TipoPacienteNombre,CodigoOA,            
				FechaInicio,Cama,TipoOrdenAtencionNombre,CodigoHC,CodigoHCAnterior,
				PacienteNombre,MedicoNombre,IdOrdenAtencion,LineaOrdenAtencion,IdHospitalizacion,
				LineaHospitalizacion,IdConsultaExterna,IdProcedimiento,Modalidad,IndicadorSeguro,
				IdCita,        
				IdPaciente,TipoPaciente,TipoAtencion,IdEspecialidad,IdEmpresaAseguradora,
				TipoOrdenAtencion,Componente,ComponenteNombre,Compania,Sucursal,
				IdMedico,IndicadorCirugia,IndicadorExamenPrincipal,        
				PersonaAnt,sexo,FechaNacimiento,EstadoCivil,NivelInstruccion,
				Direccion,TipoDocumento,Documento,ApellidoPaterno,ApellidoMaterno,
				Nombres,LugarNacimiento,CodigoPostal,Provincia,Departamento,
				Telefono,CorreoElectronico,EsPaciente,EsEmpresa,Pais,
				EstadoPersona, FechaCierreEpiClinico ,EstadoEpiClinico,UnidadReplicacion,UnidadReplicacionEC,IdEpisodioAtencion,
				EpisodioClinico,IdEstablecimientoSalud,IdUnidadServicio,IdPersonalSalud,EpisodioAtencion,FechaRegistro,FechaAtencion,
						 EstadoEpiAtencion,  UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion,Accion,Version   ,FechaFin,
				FechaOrden,Comentarios,Observaciones,Diagnostico, UnidadReplicacionHCE,IdPacienteHCE,
				EpisodioClinicoHCE,IdEpisodioAtencionHCE,SecuenciaHCE,  CodigoEpisodioClinico,
				CONTADOR   from @TABLA_ATENCIONPACIENTE_GENERAL_TEMP
				WHERE 				(@EstadoEpiAtencion is null OR EstadoEpiAtencion = @EstadoEpiAtencion) 



	   end
if(@ACCION = 'TECNOMED_AMBULATORIO' or @ACCION = 'TECNOMED_EMERGENCIA' or @ACCION = 'TECNOMED_HOSP_CIRUGIA')
       begin
            /**TECNOLOGO*/
            /*********************CONSULTAS*******************************************************
            1. Necesidad de identificar las prestaciones asociadas a un medico
            2. Como va a el manejo de las ordenes de spring salud y los episodios de atención
            3. Identificar los estado de visualización (no visualizamos anulados?)
            *************************************************************************/        /*BY JORDAN 19082019*/


			--EXEC [SS_HC_ATENCIONES_SOA_TECNOMED_AMBULATORIO] @tipoListado,@CitaTipo,@CitaFecha,@Origen,@NombreEspecialidad,@TipoPacienteNombre,@CodigoOA,@Cama,
			--@TipoOrdenAtencionNombre,@CodigoHC,@PacienteNombre,@MedicoNombre,@IdOrdenAtencion,@LineaOrdenAtencion,@IdHospitalizacion,@IdCita,@IdPaciente,
			--@TipoPaciente,@TipoAtencion,@IdEspecialidad,@IdMedico,@TipoOrdenAtencion,@Componente,@Compania,@Sucursal,@EstadoPersona,@EstadoEpiClinico,
			--@UnidadReplicacion,@UnidadReplicacionEC,@IdEpisodioAtencion,@EpisodioClinico,@IdEstablecimientoSalud,@IdUnidadServicio,@IdPersonalSalud,
			--@EpisodioAtencion,@FechaRegistro,@FechaAtencion,@EstadoEpiAtencion,@FechaInicio,@FechaFin,@UsuarioCreacion,@FechaCreacion,@UsuarioModificacion,
			--@FechaModificacion,@Version,@CodigoHCAnterior,@IndicadorCirugia,@IndicadorExamenPrincipal,@IndicadorSeguro,@Modalidad,@sexo,@EstadoCivil,
			--@NivelInstruccion,@EsPaciente,@EsEmpresa,@Inicio,@NumeroFilas,@ACCION


       PRINT '¨Paso 1'
	insert into @TABLA_ATENCIONPACIENTE_GENERAL_TEMP
            (tipoListado,CitaTipo,CitaFecha,CitaHora,Origen,NombreEspecialidad,TipoPacienteNombre,CodigoOA,
            ----------
           Cama, FechaInicio,TipoOrdenAtencionNombre,CodigoHC,CodigoHCAnterior,
            PacienteNombre,MedicoNombre,IdOrdenAtencion,LineaOrdenAtencion,IdHospitalizacion,
            LineaHospitalizacion,IdConsultaExterna,IdProcedimiento,Modalidad,IndicadorSeguro,
            IdCita,FechaFin,
            ----------
            IdPaciente,TipoPaciente,TipoAtencion,IdEspecialidad,IdEmpresaAseguradora,
            TipoOrdenAtencion,Componente,ComponenteNombre,Compania,Sucursal,
            IdMedico,IndicadorCirugia,IndicadorExamenPrincipal,
            ---------
            UnidadReplicacionHCE,EstadoEpiAtencion,EpisodioClinicoHCE,IdEpisodioAtencionHCE,IdPacienteHCE,SecuenciaHCE,
            ------------
            PersonaAnt,sexo,FechaNacimiento,EstadoCivil,NivelInstruccion,
            Direccion,TipoDocumento,Documento,ApellidoPaterno,ApellidoMaterno,
            Nombres,LugarNacimiento,CodigoPostal,Provincia,Departamento,
            Telefono,CorreoElectronico,EsPaciente,EsEmpresa,Pais,
            EstadoPersona,UnidadReplicacionEC,Version,Contador
            ) 

				SELECT   'TECNOMED_AMBULATORIO' as tipoListado,
			 CitaTipo = (CASE SS_CC_Cita.TipoCita WHEN 1 THEN 'Normal' WHEN 2 THEN 'Adicional' ELSE 'Normal' END),
                CitaFecha =(case when SS_AD_OrdenAtencion.TipoAtencion=2 then SS_AD_OrdenAtencionDetalle.FechaCreacion else (case when SS_CC_Cita.FechaCita is null then  SS_AD_OrdenAtencion.FechaInicio else SS_CC_Cita.FechaCita end)  end  ) , --SS_CC_Cita.FechaCita,  ARACELY DIJO QUE POR FECHA DE ATENCION 21/08/2019
                CitaHora =(case when SS_AD_OrdenAtencion.TipoAtencion=2 then SS_AD_OrdenAtencionDetalle.FechaCreacion else (case when SS_CC_Cita.FechaCita is null then  SS_AD_OrdenAtencion.FechaInicio else SS_CC_Cita.FechaCita end)  end  ) , --SS_CC_Cita.FechaCita,
                Origen = (CASE WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 11) THEN 'Consulta' ELSE 'Procedimiento' END),
                NombreEspecialidad = SS_GE_Especialidad.Nombre,
                TipoPacienteNombre = TipoPaciente.Nombre,
                SS_AD_OrdenAtencion.CodigoOA,
				IsNull(SS_CC_CITA.Comentario,'') as Cama,
				--SS_AD_OrdenAtencion.FechaInicio, 
				(case when SS_AD_OrdenAtencion.TipoAtencion=2 then SS_AD_OrdenAtencionDetalle.FechaCreacion else SS_AD_OrdenAtencion.FechaInicio  end  ) as FechaInicio,
				TipoOrdenAtencionNombre = TipoOrdenAtencion.Nombre,
                SS_GE_Paciente.CodigoHC,
                SS_GE_Paciente.CodigoHCAnterior,
                PacienteNombre = PersonaMast.NombreCompleto,				
                  --NOMBRE DE MEDICO ASIGNADO		
				IsNull(Medico.NombreCompleto,medik.NombreCompleto)   as MedicoNombre,				
				SS_AD_OrdenAtencionDetalle.IdOrdenAtencion,
                  LineaOrdenAtencion = SS_AD_OrdenAtencionDetalle.Linea,
                  IsNull(SS_AD_OrdenAtencion.IdContrato,0) as IdHospitalizacion,
                  0 AS LineaHospitalizacion ,
                  SS_CE_ConsultaExterna.IdConsultaExterna,
                  SS_PR_Procedimiento.IdProcedimiento,
                  case 
						when SS_AD_OrdenAtencion.TipoPaciente='19' then '19'
						when SS_AD_OrdenAtencion.TipoPaciente='4' then '4'
						when SS_AD_OrdenAtencion.modalidad='1' then '1'
						when  SS_AD_OrdenAtencion.modalidad='2' then '2'
						else
						SS_AD_OrdenAtencion.tipopaciente
				  end as Modalidad,
                IndicadorSeguro = ( 				
				SELECT IsNull(CM_CO_TablaMaestroDetalleConcepto.IndicadorConcepto,1)
                        FROM CM_CO_TablaMaestroDetalleConcepto WITH(NOLOCK) 
						INNER JOIN CM_CO_TablaMaestroConcepto WITH(NOLOCK) ON CM_CO_TablaMaestroConcepto.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
                                AND CM_CO_TablaMaestroConcepto.IdConcepto = CM_CO_TablaMaestroDetalleConcepto.IdConcepto
                                AND CM_CO_TablaMaestroConcepto.Concepto = 'APLICA_SEGURO'
                        WHERE TipoPaciente.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
                                AND TipoPaciente.IdCodigo = CM_CO_TablaMaestroDetalleConcepto.IdCodigo),
                  SS_CC_Cita.IdCita,
 				SS_AD_OrdenAtencion.FechaFinal ,
                  SS_GE_Paciente.IdPaciente,
                  SS_AD_OrdenAtencion.TipoPaciente,
                  SS_AD_OrdenAtencion.TipoAtencion,
                  IdEspecialidad = IsNull( (case  when ss_ad_OrdenAtencion.TipoAtencion in (2,3) then SS_GE_Especialidad.IdEspecialidad else SS_AD_OrdenAtencionDetalle.Especialidad end ), SS_AD_OrdenAtencion.Especialidad),
                  SS_AD_OrdenAtencion.IdEmpresaAseguradora,
                  SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion,
                  SS_AD_OrdenAtencionDetalle.Componente,
                  ComponenteNombre = CM_CO_Componente.Nombre,
                  SS_AD_OrdenAtencion.Compania,
                  SS_AD_OrdenAtencion.Sucursal,	
				   --IDMEDICO ASIGNADO
                IdMedico =     IsNull(SS_PR_Procedimiento.Medico,SS_CC_Cita.IdMedico) ,-- Medico.Persona,	
                  ------------------------
                  0 as IndicadorCirugia,
                  0 as IndicadorExamenPrincipal,
                  ---------------------------ADD ORIGEN HCE --OBS                  
                  @UnidadReplicacionEC AS UnidadReplicacionHCE,
				  CASE 
					WHEN  SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 11, 21 ) THEN 
						   case 
								WHEN ss_cc_cita.estadodocumento = 2 then 1 --PROGRAMADO
								WHEN ss_cc_cita.estadodocumento = 3 then 0 --PENDIENTE
								WHEN ss_cc_cita.estadodocumento = 8 then 3 -- ATENDIDO
		
									WHEN SS_CC_CITA.EstadoDocumento=4 then case when SS_AD_OrdenAtencionDetalle.IndicadorProcedimiento=2 then 3
								else 3
								end
	
								Else
								ss_cc_cita.estadodocumento
								end
						
					WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (  2, 4, 5, 6, 7, 8, 9, 10, 12, 16, 17, 18, 19, 25, 26, 27, 23, 15, 33, 34, 37, 38, 39, 29, 30, 31, 32, 28 ) THEN 
					  case  when IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) = -99 AND SS_CC_Cita.EstadoDocumento IS NULL THEN 0
							when SS_CC_Cita.EstadoDocumento = 4  AND SS_PR_Procedimiento.EstadoDocumento = 3 THEN 4 --ANULADO	
							when SS_CC_Cita.IdCita IS NULL  AND SS_PR_Procedimiento.EstadoDocumento = 3 THEN 4 --ANULADO
							when IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) = -99 AND SS_CC_Cita.EstadoDocumento = 3 THEN 0
							when IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) = -99 AND SS_CC_Cita.EstadoDocumento = 2 THEN 1
							when IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) = -99 AND SS_CC_Cita.EstadoDocumento = 8 THEN 0
							when IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) = -99 AND SS_CC_Cita.EstadoDocumento = 4 THEN 0
							when IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) <> -99 AND SS_PR_Procedimiento.EstadoDocumento = 2 THEN 3
							--when IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) <> -99 AND SS_PR_Procedimiento.EstadoDocumento = 4 THEN 4 --3
							when IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) <> -99 AND SS_PR_Procedimiento.EstadoDocumento = 4 THEN 5 
							when IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) <> -99 AND SS_PR_Procedimiento.EstadoDocumento = 1 THEN 2
							Else 
								-99
					END   
                    Else
                    ss_cc_cita.estadodocumento
                    end  AS EstadoEpiAtencion,  	
					 NULL AS  EpisodioClinicoHCE,
                 NULL AS IDEPISODIOAtencionHCE,
                 NULL AS IdPacienteHCE, 
                 NULL AS SecuenciaHCE,            
                  ---------------------------  
                  PersonaMast.PersonaAnt,
                  PersonaMast.sexo,
                  PersonaMast.FechaNacimiento,
                  PersonaMast.EstadoCivil,
                  PersonaMast.NivelInstruccion,
                  PersonaMast.Direccion,
                  PersonaMast.TipoDocumento,
                  PersonaMast.Documento,
                  PersonaMast.ApellidoPaterno,
                  PersonaMast.ApellidoMaterno,
                  PersonaMast.Nombres,
                  PersonaMast.LugarNacimiento,
                  PersonaMast.CodigoPostal,
                  PersonaMast.Provincia,
                  PersonaMast.Departamento,
                  PersonaMast.Telefono,
                  PersonaMast.CorreoElectronico,
                  PersonaMast.EsPaciente,
                  PersonaMast.EsEmpresa,
				  --NOMBRE DE MEDICO SOLICITANTE
				IsNull( medUsu.NombreCompleto,'') As Pais,
                  PersonaMast.Estado as EstadoPersona,
                  PersonaMast.Origen as UnidadReplicacionEC,        
                  TipoAtencion.Nombre as TipoAtencionDescX
				   ,@CONTADOR AS ContadorX
			FROM	SS_AD_OrdenAtencion WITH(NOLOCK) 
			INNER JOIN SS_AD_OrdenAtencionDetalle WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdOrdenAtencion = SS_AD_OrdenAtencionDetalle.IdOrdenAtencion 
			INNER JOIN SS_GE_Paciente WITH(NOLOCK) ON SS_GE_Paciente.IdPaciente = SS_AD_OrdenAtencion.IdPaciente 
			INNER JOIN PersonaMast WITH(NOLOCK) ON SS_GE_Paciente.IdPaciente = PersonaMast.Persona 
			INNER JOIN CM_CO_Componente WITH(NOLOCK) ON ( CM_CO_Componente.CodigoComponente = SS_AD_OrdenAtencionDetalle.Componente ) 
			LEFT JOIN  SS_CE_ConsultaExterna WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_CE_ConsultaExterna.IdOrdenAtencion   AND SS_AD_OrdenAtencionDetalle.Linea = SS_CE_ConsultaExterna.LineaOrdenAtencion 
			LEFT JOIN SS_PR_Procedimiento WITH(NOLOCK) ON ( SS_PR_Procedimiento.IdOrdenAtencion = SS_AD_OrdenAtencionDetalle.IdOrdenAtencion AND SS_PR_Procedimiento.LineaOrdenAtencion = SS_AD_OrdenAtencionDetalle.Linea ) 
			LEFT JOIN SS_GE_Turno WITH(NOLOCK) ON SS_GE_Turno.IdTurno = SS_AD_OrdenAtencionDetalle.IdTurno 
			LEFT JOIN SS_GE_Servicio WITH(NOLOCK) ON ( SS_GE_Servicio.IdServicio = SS_AD_OrdenAtencionDetalle.IdServicio ) 
			LEFT JOIN SS_GE_GrupoAtencion WITH(NOLOCK) ON ( SS_GE_GrupoAtencion.IdGrupoAtencion = SS_GE_Servicio.IdGrupoAtencion )
			LEFT JOIN CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK) ON TipoPaciente.IdTablaMaestro = 106  AND TipoPaciente.IdCodigo = SS_AD_OrdenAtencion.TipoPaciente
			LEFT JOIN CM_CO_TablaMaestroDetalle	AS TipoOrdenAtencion WITH (NOLOCK)	ON TipoOrdenAtencion.IdTablaMaestro = 101 AND TipoOrdenAtencion.IdCodigo = SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion
			LEFT JOIN SS_GE_TipoAtencion TipoAtencion WITH(NOLOCK) ON ( TipoAtencion.IdTipoAtencion = SS_AD_OrdenAtencion.TipoAtencion ) 
			LEFT JOIN GE_Varios as modalid WITH(NOLOCK) ON ( modalid.CodigoTabla = 'TIPOMODALIDAD' and modalid.Secuencial = SS_AD_OrdenAtencion.Modalidad ) 
			LEFT JOIN GE_Varios as Topico WITH(NOLOCK) ON ( Topico.CodigoTabla = 'TOPICO' and Topico.Secuencial = SS_AD_OrdenAtencion.IdTopico ) 

			LEFT JOIN PersonaMast as medico WITH(NOLOCK) ON medico.Persona = SS_PR_Procedimiento.Medico 
			LEFT JOIN SS_CC_Cita WITH(NOLOCK) ON SS_CC_Cita.IdCita = SS_AD_OrdenAtencionDetalle.IdCita 
			LEFT JOIN SS_CC_Horario WITH(NOLOCK) ON SS_CC_Horario.IdHorario = SS_CC_Cita.IdHorario 
			LEFT JOIN PersonaMast as medik WITH(NOLOCK) ON medik.Persona = SS_CC_Horario.Medico 
			LEFT JOIN SS_GE_Consultorio WITH(NOLOCK) ON ( SS_GE_Consultorio.IdConsultorio = SS_CC_Horario.IdConsultorio ) 
			LEFT JOIN SS_GE_Especialidad WITH(NOLOCK) ON ( SS_GE_Especialidad.IdEspecialidad = SS_PR_Procedimiento.Especialidad ) 
			LEFT JOIN EmpleadoMast as EmpUsu WITH(NOLOCK) ON EmpUsu.Empleado =  IsNull(SS_PR_Procedimiento.Medico,SS_CC_Cita.IdMedico)-- SS_AD_OrdenAtencionDetalle.UsuarioCreacion
			LEFT JOIN PersonaMast as medUsu WITH(NOLOCK) ON medUsu.Persona = EmpUsu.Empleado 

		WHERE 
		SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion NOT IN ( 2,1)
		AND SS_AD_OrdenAtencionDetalle.TipoComponente = 'C'
		AND Isnull(SS_AD_OrdenAtencionDetalle.IndicadorTransferir, 1) = 1
		and SS_AD_OrdenAtencionDetalle.IndicadorDisponible = (case when  ss_ad_OrdenAtencion.TipoAtencion =1 then  2  else 1 end) -- CAMBIO PARA EMERGENCIA-HOSPITALIZACIÓN  LUKE 01-06-2020
			AND	(@CodigoOA is null OR SS_AD_OrdenAtencion.CodigoOA = @CodigoOA) 
			AND	(@CodigoHC is null OR SS_GE_Paciente.CodigoHC = @CodigoHC)
			AND (@Componente is null  OR @Componente =''  OR  upper(SS_AD_OrdenAtencionDetalle.Componente) like '%'+upper(@Componente)+'%')  ---PARA FILTRAR POR COMPONENTE 19/09/2019
			AND (@UsuarioModificacion is null  OR @UsuarioModificacion =''  OR  upper( CM_CO_Componente.Nombre) like '%'+upper(@UsuarioModificacion)+'%')  ---PARA FILTRAR POR NOMBRE COMPONENTE 19/09/2019
			AND (@UsuarioCreacion is null  OR @UsuarioCreacion =''  OR  upper(medik.NombreCompleto) like '%'+upper(@UsuarioCreacion)+'%')  ---PARA FILTRAR POR MEDICO SOLICITANTE 19/09/2019		
			AND (@UnidadReplicacion is null  OR @UnidadReplicacion =''  OR  upper(ss_ad_OrdenAtencion.UnidadReplicacion) like '%'+upper(@UnidadReplicacion)+'%')  ---PARA FILTRAR unidad replicacion 19/09/2019
			AND	(@TipoOrdenAtencion is null OR SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion = @TipoOrdenAtencion) 			
			AND (@PacienteNombre is null  OR @PacienteNombre =''  OR  upper(PersonaMast.Busqueda) like '%'+upper(@PacienteNombre)+'%')     
		   AND (@FechaInicio IS NULL OR convert(date, SS_AD_OrdenAtencion.FechaInicio, 103) between convert(date, @FechaInicio, 103) and convert(date, @FechaFin, 103))
            and   (/*@FechaFin IS NULL OR*/ (CASE WHEN medUsu.Persona is null or medUsu.Persona = '' then SS_AD_OrdenAtencion.FechaInicio else   SS_CC_Cita.FechaCita end) < DATEADD(DAY,1,@FechaFin)) 
			AND (@IdPaciente is null OR  @IdPaciente = 0 or  SS_AD_OrdenAtencion.IdPaciente = @IdPaciente)   
			AND (@IdEspecialidad is null OR SS_PR_Procedimiento.Especialidad=@IdEspecialidad)  -------------------------------ADD 
			AND (@MedicoNombre is null  OR @MedicoNombre =''  OR  upper(IsNull(Medico.NombreCompleto,medik.NombreCompleto) ) like '%'+upper(@MedicoNombre)+'%') ---ADD 27/01/17
			AND (@UnidadReplicacionEC is null OR  @UnidadReplicacionEC ='' or  SS_AD_OrdenAtencion.Sucursal=@UnidadReplicacionEC) 
           
                                                         
             SELECT CONVERT(int,ROW_NUMBER() OVER (ORDER BY FechaInicio  ASC ) )AS NumeroFila ,
				tipoListado,CitaTipo,CitaFecha,CitaHora,Origen,NombreEspecialidad,TipoPacienteNombre,CodigoOA,            
							FechaInicio,Cama,TipoOrdenAtencionNombre,CodigoHC,CodigoHCAnterior,
							PacienteNombre,MedicoNombre,IdOrdenAtencion,LineaOrdenAtencion,IdHospitalizacion,
							LineaHospitalizacion,IdConsultaExterna,IdProcedimiento,Modalidad,IndicadorSeguro,
							IdCita,        
							IdPaciente,TipoPaciente,TipoAtencion,IdEspecialidad,IdEmpresaAseguradora,
							TipoOrdenAtencion,Componente,ComponenteNombre,Compania,Sucursal,
							IdMedico,IndicadorCirugia,IndicadorExamenPrincipal,        
							PersonaAnt,sexo,FechaNacimiento,EstadoCivil,NivelInstruccion,
							Direccion,TipoDocumento,Documento,ApellidoPaterno,ApellidoMaterno,
							Nombres,LugarNacimiento,CodigoPostal,Provincia,Departamento,
							Telefono,CorreoElectronico,EsPaciente,EsEmpresa,Pais,
							EstadoPersona, FechaCierreEpiClinico ,EstadoEpiClinico,UnidadReplicacion,UnidadReplicacionEC,IdEpisodioAtencion,
				EpisodioClinico,IdEstablecimientoSalud,IdUnidadServicio,IdPersonalSalud,EpisodioAtencion,FechaRegistro,FechaAtencion,
						 EstadoEpiAtencion,  UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion,Accion,Version   ,FechaFin,
				FechaOrden,Comentarios,Observaciones,Diagnostico, UnidadReplicacionHCE,IdPacienteHCE,
				EpisodioClinicoHCE,IdEpisodioAtencionHCE,SecuenciaHCE,  CodigoEpisodioClinico,
				CONTADOR                                                    
             from @TABLA_ATENCIONPACIENTE_GENERAL_TEMP as VW_ATENCIONPACIENTE_GENERAL    
      end  


if(@ACCION = 'VALIDAR_HISTORIA_CLINICA')
       begin  
             SELECT IdPaciente,CodigoHC                                                                            
             from SS_GE_Paciente
as VW_ATENCIONPACIENTE_GENERAL                                
where IdPaciente = @CodigoOA and CodigoHC = @CodigoHC

       end          
 if(@ACCION_END = 'TERMINARLISTARPAG')
       begin                          
             SET @CONTADOR=(SELECT COUNT(*)
                                  from @TABLA_ATENCIONPACIENTE_GENERAL as VW_ATENCIONPACIENTE_GENERAL                                                                                                                  
                                  )      
             SELECT
               [tipoListado]
               ,[CitaTipo]
               ,[CitaFecha]
               ,[CitaHora]
               ,[Origen]
               ,[NombreEspecialidad]
               ,[TipoPacienteNombre]
               ,[CodigoOA]
               ,[Cama]
               ,[TipoOrdenAtencionNombre]
               ,[CodigoHC]
               ,[CodigoHCAnterior]
               ,[PacienteNombre]
               ,[MedicoNombre]
               ,[IdOrdenAtencion]
               ,[LineaOrdenAtencion]
               ,[IdHospitalizacion]
               ,[LineaHospitalizacion]
               ,[IdConsultaExterna]
               ,[IdProcedimiento]
               ,[Modalidad]
               ,[IndicadorSeguro]
               ,[IdCita]
               ,[IdPaciente]
               ,[TipoPaciente]
               ,[TipoAtencion]
               ,[IdEspecialidad]
               ,[IdEmpresaAseguradora]
               ,[TipoOrdenAtencion]
               ,[Componente]
               ,[ComponenteNombre]
               ,[Compania]
               ,[Sucursal]
               ,[IdMedico]
               ,[IndicadorCirugia]
               ,[IndicadorExamenPrincipal]
               ,[PersonaAnt]
               ,[sexo]
               ,[FechaNacimiento]
               ,[EstadoCivil]
               ,[NivelInstruccion]
               ,[Direccion]
               ,[TipoDocumento]
               ,[Documento]
               ,[ApellidoPaterno]
               ,[ApellidoMaterno]
               ,[Nombres]
               ,[LugarNacimiento]
               ,[CodigoPostal]
               ,[Provincia]
               ,[Departamento]
               ,[Telefono]
               ,[CorreoElectronico]
               ,[EsPaciente]
               ,[EsEmpresa]
               ,[Pais]
               ,[EstadoPersona]
               ,[FechaCierreEpiClinico]
               ,[EstadoEpiClinico]
               ,[UnidadReplicacion]
               ,[UnidadReplicacionEC]
               ,[IdEpisodioAtencion]
               ,[EpisodioClinico]
               ,[IdEstablecimientoSalud]
               ,[IdUnidadServicio]
               ,[IdPersonalSalud]
               ,[EpisodioAtencion]
               ,[FechaRegistro]
               ,[FechaAtencion]
               ,[EstadoEpiAtencion]
               ,[UsuarioCreacion]
               ,[UsuarioModificacion]
               ,[FechaCreacion]
               ,[FechaModificacion]
               ,[Accion]
               ,TipoAtencionDescX as Version
               ,[FechaInicio]
               ,[FechaFin]
               ,[FechaOrden]
               ,[Comentarios]
               ,[Observaciones]
               ,[Diagnostico]
             -------------
             ,      UnidadReplicacionHCE
             ,      IdPacienteHCE
             ,      EpisodioClinicoHCE
             ,      IdEpisodioAtencionHCE
             ,      SecuenciaHCE
             ,      CodigoEpisodioClinico
             -------------        
               ,ContadorX as Contador
               ,convert(int,RowNumber) as NumeroFila          
             FROM (SELECT VW_ATENCIONPACIENTE_GENERAL.*,                          
                           @CONTADOR AS ContadorX,
                           TipoAtencion.Nombre as TipoAtencionDescX,
                           ROW_NUMBER() OVER (ORDER BY VW_ATENCIONPACIENTE_GENERAL.CodigoOA ASC ) AS RowNumber    
                           from @TABLA_ATENCIONPACIENTE_GENERAL as VW_ATENCIONPACIENTE_GENERAL      
                       left join SS_GE_TipoAtencion TipoAtencion    
                       on (TipoAtencion.IdTipoAtencion = VW_ATENCIONPACIENTE_GENERAL.TipoAtencion)                        
                                       
             ) AS LISTADO
 
       end
       else
      if(@ACCION_END = 'TERMINARLISTAR')
       begin                                                            
             SELECT VW_ATENCIONPACIENTE_GENERAL.*                                                                              
             from @TABLA_ATENCIONPACIENTE_GENERAL as VW_ATENCIONPACIENTE_GENERAL  
       end    

END
GO

--CREATE OR ALTER PROCEDURE [dbo].[SP_HCE_ITIDConsultaExterna]
--    @UnidadReplicacion VARCHAR(15),
--    @IdEpisodioAtencion INT,
--    @IdPaciente INT,
--    @EpisodioClinico INT
--AS
--BEGIN
--    SET NOCOUNT ON;
--    BEGIN TRY
--        BEGIN TRANSACTION;

--        -- Variables locales
--        DECLARE @IdOrdenAtencion INT,
--                @LineaOrdenAtencionConsulta INT,
--                @TipoOrdenAtencion INT,
--                @UsuarioCreacion VARCHAR(50),
--                @FechaCreacion DATETIME,
--                @UsuarioModificacion VARCHAR(50),
--                @FechaModificacion DATETIME;

--        -- Obtener datos
--        SELECT TOP 1
--            @IdOrdenAtencion = IdOrdenAtencion,
--            @LineaOrdenAtencionConsulta = LineaOrdenAtencion,
--            @TipoOrdenAtencion = TipoOrdenAtencion,
--            @UsuarioCreacion = UsuarioCreacion,
--            @FechaCreacion = FechaCreacion,
--            @UsuarioModificacion = UsuarioModificacion,
--            @FechaModificacion = FechaModificacion
--        FROM WEB_ERPSALUD.DBO.SS_HC_EpisodioAtencion
--        WHERE UnidadReplicacion = @UnidadReplicacion 
--          AND EpisodioAtencion = @IdEpisodioAtencion 
--          AND IdPaciente = @IdPaciente 
--          AND EpisodioClinico = @EpisodioClinico
--          AND TipoAtencion = 1;

--        -- Validar si encontró el registro
--        IF @IdOrdenAtencion IS NULL
--        BEGIN
--            RAISERROR('No se encontró información del episodio de atención.', 16, 1);
--            ROLLBACK TRANSACTION;
--            RETURN;
--        END

--        -- Insertar en tabla de ingreso
--        INSERT INTO SS_IT_SaludConsultaExternaIngreso (
--            IdOrdenAtencion,
--            LineaOrdenAtencionConsulta,
--            UnidadReplicacion,
--            IdEpisodioAtencion,
--            IdPaciente,
--            EpisodioClinico,
--            Estado,
--            UsuarioCreacion,
--            FechaCreacion,
--            UsuarioModificacion,
--            FechaModificacion,
--            IndicadorProcesado,
--            FechaProcesado,
--            TipoOrdenAtencion
--        )
--        VALUES (
--            @IdOrdenAtencion,
--            @LineaOrdenAtencionConsulta,
--            @UnidadReplicacion,
--            @IdEpisodioAtencion,
--            @IdPaciente,
--            @EpisodioClinico,
--            2, -- Estado fijo
--            @UsuarioCreacion,
--            @FechaCreacion,
--            @UsuarioModificacion,
--            @FechaModificacion,
--            2, -- IndicadorProcesado fijo
--            GETDATE(),
--            @TipoOrdenAtencion
--        );

--        -- Ejecutar SP dependiente
--        EXEC dbo.SP_SS_IT_SALUDConsultaExterna 
--            @IdOrdenAtencion,
--            @LineaOrdenAtencionConsulta,
--            @UnidadReplicacion,
--            @IdPaciente,
--            NULL, -- @Secuencia (falta en tu parámetro, debes definirlo)
--            @UsuarioCreacion,
--            @FechaCreacion,
--            @TipoOrdenAtencion;

--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        IF @@TRANCOUNT > 0
--            ROLLBACK TRANSACTION;

--        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
--        SELECT @ErrorMessage = ERROR_MESSAGE(), 
--               @ErrorSeverity = ERROR_SEVERITY(), 
--               @ErrorState = ERROR_STATE();
--        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END
--GO
GO
CREATE OR ALTER PROCEDURE [dbo].[SP_HCE_ITIDConsultaExterna]
    @UnidadReplicacion     VARCHAR(15),
    @IdEpisodioAtencion    INT,
    @IdPaciente            INT,
    @EpisodioClinico       INT
AS
BEGIN
    SET XACT_ABORT ON;
    BEGIN TRAN;

    BEGIN TRY
        -- 1) Inserción en SS_IT_SaludConsultaExternaIngreso
        INSERT INTO SS_IT_SaludConsultaExternaIngreso
        (
            IdOrdenAtencion, LineaOrdenAtencionConsulta, UnidadReplicacion,
            IdEpisodioAtencion, IdPaciente, EpisodioClinico,
            Estado, UsuarioCreacion, FechaCreacion, UsuarioModificacion,
            FechaModificacion, IndicadorProcesado, FechaProcesado,
            TipoOrdenAtencion
        )
        SELECT
            e.IdOrdenAtencion,
            e.LineaOrdenAtencion,
            e.UnidadReplicacion,
            e.IdEpisodioAtencion,
            e.IdPaciente,
            e.EpisodioClinico,
            2,
            CASE
                WHEN e.TipoOrdenAtencion IN (1, 2)
                    THEN e.UsuarioCreacion
                ELSE ISNULL(a.CodigoAgente, e.UsuarioCreacion)
            END,
            e.FechaCreacion,
            e.UsuarioModificacion,
            e.FechaModificacion,
            2,
            GETDATE(),
            e.TipoOrdenAtencion
        FROM WEB_ERPSALUD.dbo.SS_HC_EpisodioAtencion e
        LEFT JOIN SG_Agente a
            ON a.IdEmpleado = e.IdPersonalSalud
        WHERE
            e.UnidadReplicacion = @UnidadReplicacion
            AND e.EpisodioAtencion = @IdEpisodioAtencion
            AND e.IdPaciente = @IdPaciente
            AND e.EpisodioClinico = @EpisodioClinico;

        -- 2) Obtener parámetros generados
        DECLARE
            @IdOrdenAtencion INT,
            @LineaOrdenAtencion INT,
            @Usuario       VARCHAR(25),
            @FechaCreacion DATETIME,
            @TipoOrden     INT;

        SELECT TOP 1
            @IdOrdenAtencion       = IdOrdenAtencion,
            @LineaOrdenAtencion    = LineaOrdenAtencionConsulta,
            @TipoOrden             = TipoOrdenAtencion,
            @Usuario               = UsuarioCreacion,
            @FechaCreacion         = FechaCreacion
        FROM SS_IT_SaludConsultaExternaIngreso
        WHERE UnidadReplicacion = @UnidadReplicacion
          AND IdEpisodioAtencion = @IdEpisodioAtencion
          AND IdPaciente = @IdPaciente
          AND EpisodioClinico = @EpisodioClinico;

        IF @IdOrdenAtencion IS NULL
            THROW 51000, 'No se encontró la orden derivada del episodio.', 1;

        -- Variables para procesamiento interno
        DECLARE
            @IdMedico                INT,
            @Especialidad            INT,
            @IdConsultorio           INT,
            @IdCita                  INT,
            @IdCitaEstadoDocumento   INT,
            @EXISTE                  INT,
            @IDMAXConsultaExterna    INT,
            @nroIntentos             INT = 0,
            @Intentar                INT = 1,
            @OBS                     VARCHAR(100),
            @OBSATE                  VARCHAR(100),
            @SecuencialMaxCita       INT,
            @SecuencialMaxOA         INT,
            @ESTADODocumentoOA       INT,
            @p_devhce                INT,
            @oacambio                INT,
			@ll_retorno				 INT,
            @MAXCONEXTCONTROL        INT;

        IF @TipoOrden = 1
        BEGIN
            -- Lógica para Consulta Externa
            SELECT @EXISTE = isnull(IdConsultaExterna,0)
            FROM SS_CE_ConsultaExterna WITH (NOLOCK)
            WHERE IdOrdenAtencion = @IdOrdenAtencion
              AND LineaOrdenAtencion = @LineaOrdenAtencion
              AND Estado = 2;

			SET @ll_retorno = 0 
			SET @OBS ='Estado En Atencion HCE'
			SET @OBSATE ='Nueva Consulta Externa HCE'

			IF @EXISTE > 0
			BEGIN
				SET @ll_retorno = -1
				SET @OBS ='Modificacion En Atencion HCE'
				SET @OBSATE ='Modificacion Consulta Externa HCE'
				PRINT 'EXISTE'
			END;
            SET @Intentar = 1;

            -- Obtener datos de cita/hora
            SELECT
                @IdMedico              = c.IdMedico,
                @Especialidad          = h.IdEspecialidad,
                @IdConsultorio         = h.IdConsultorio,
                @IdCita                = c.IdCita,
                @IdCitaEstadoDocumento = c.EstadoDocumento
            FROM SS_CC_Cita c WITH (NOLOCK)
            JOIN SS_CC_Horario h WITH (NOLOCK) ON c.IdHorario = h.IdHorario
            JOIN SS_AD_OrdenAtencionDetalle od WITH (NOLOCK)
              ON od.IdCita = c.IdCita
             AND od.IdOrdenAtencion = @IdOrdenAtencion
             AND od.Linea = @LineaOrdenAtencion;

            WHILE @nroIntentos < 5 AND @Intentar = 1
            BEGIN
                SET @nroIntentos += 1;
                SET @Intentar = 0;

			IF @ll_retorno = 0 
				BEGIN

				SELECT @IDMAXConsultaExterna = ISNULL(MAX(ISNULL(IdConsultaExterna,0)),0) +1
				FROM SS_CE_ConsultaExterna  
				END
			ELSE
				BEGIN
				SET @IDMAXConsultaExterna =	@EXISTE					
				
				UPDATE SS_CE_ConsultaExterna SET EstadoDocumento=1, EstadoDocumentoAnterior=2 WHERE IdConsultaExterna= @IDMAXConsultaExterna;
				
				END
			IF @ll_retorno = 0 
				BEGIN
					INSERT INTO SS_CE_ConsultaExterna 
					(	IdConsultaExterna , IdCita , IdOrdenAtencion , LineaOrdenAtencion , Consultorio , Medico , Especialidad , 
						FechaConsulta , IndicadorSeguimiento , IdConsultaExternaInicial , EstadoDocumento , Estado , UsuarioCreacion , FechaCreacion , IndicadorFirmaAlta , 
						TipoConsulta ) 
					Values 
					(	@IDMAXConsultaExterna , @IDcita , @IDordenatencion , @LineaOrdenAtencion , @IDconsultorio , @IdMedico , @Especialidad , @FechaCreacion , 1 , @IDMAXConsultaExterna , 
						1 , 2 , @Usuario , @FechaCreacion , 2 , 1 ) 
				
					PRINT 'SS_CE_ConsultaExterna'
				END
            END

            -- Actualizar estados y controles
            UPDATE SS_AD_OrdenAtencion
            SET IdConsultaExternaPrincipal = ISNULL(IdConsultaExternaPrincipal, @IDMAXConsultaExterna),
                EstadoDocumentoAnterior = EstadoDocumento,
                EstadoDocumento = 2            WHERE IdOrdenAtencion = @IdOrdenAtencion;

            UPDATE SS_CC_Cita
            SET EstadoDocumentoAnterior = @IdCitaEstadoDocumento,
                EstadoDocumento = 4           WHERE IdCita = @IdCita;

            SELECT @SecuencialMaxCita = ISNULL(MAX(Secuencial), 0)+1
            FROM SS_CC_CitaControl            WHERE IdDocumento = @IdCita;

            INSERT INTO SS_CC_CitaControl
            (
                IdDocumento, Secuencial, FechaControl, Observacion,
                IdUsuario, EstadoDocumento, EstadoDocumentoAnterior,
                IndicadorRetorno, Estado, UsuarioCreacion, FechaCreacion
            )
            VALUES
            (
                @IdCita, @SecuencialMaxCita, @FechaCreacion, @OBS,
                @Usuario, 4, @IdCitaEstadoDocumento,
                1, 2, @Usuario, @FechaCreacion
            );

            SELECT @EstadodocumentoOA = EstadoDocumento
            FROM SS_AD_OrdenAtencion WITH (NOLOCK)            WHERE IdOrdenAtencion = @IdOrdenAtencion;

            SELECT @SecuencialMaxOA = ISNULL(MAX(Secuencial),0)+1
            FROM SS_AD_OrdenAtencionControl            WHERE IdDocumento = @IdOrdenAtencion;

            INSERT INTO SS_AD_OrdenAtencionControl
            (
                IdDocumento, Secuencial, FechaControl, Observacion,
                IdUsuario, EstadoDocumento, EstadoDocumentoAnterior,
                IndicadorRetorno, Estado, UsuarioCreacion, FechaCreacion
            )
            VALUES
            (
                @IdOrdenAtencion, @SecuencialMaxOA, @FechaCreacion,
                'Estado en Proceso HCE', @Usuario,
                2, @estadoDocumentoOA,
                1, 2, @Usuario, @FechaCreacion
            );

            SELECT @MAXCONEXTCONTROL = ISNULL(MAX(Secuencial),0)+1
            FROM SS_CE_ConsultaExternaControl            WHERE IdDocumento = @IDMAXConsultaExterna;

            INSERT INTO SS_CE_ConsultaExternaControl
            (
                IdDocumento, Secuencial, FechaControl, Observacion,
                IdUsuario, EstadoDocumento, IndicadorRetorno,
                Estado, UsuarioCreacion, FechaCreacion
            )
            VALUES
            (
                @IDMAXConsultaExterna, @MAXCONEXTCONTROL, @FechaCreacion,
                @OBSATE, @Usuario, 1, 1, 2, @Usuario, @FechaCreacion
            );

            UPDATE SS_AD_OrdenAtencionDetalle            SET IndicadorOcultarConsulta = 1
            WHERE IdOrdenAtencion = @IdOrdenAtencion
              AND Linea = @LineaOrdenAtencion;

            UPDATE SS_AD_OrdenAtencion            SET IndicadorOcultarOA = 1
            WHERE IdOrdenAtencion = @IdOrdenAtencion;

            SELECT @p_devhce = ISNULL(ValorNumerico, 1)
            FROM SG_Opcion
            WHERE CodigoOpcion = 'P_HC_DEVHHMM'
              AND TipoOpcion = 'P';

            IF @p_devhce = 2
            BEGIN
                SELECT @oacambio = COUNT(1)
                FROM SS_AD_OrdenAtencionCambio WITH (NOLOCK)
                WHERE TipoTabla = 'O'
                  AND IdTabla = @IdOrdenAtencion
                  AND IndicadorProcesado = 1;

                IF @oacambio IS NULL OR @oacambio = 0
                BEGIN
                    INSERT INTO SS_AD_OrdenAtencionCambio
                    (
                        Periodo, TipoTabla, IdTabla, FechaCambio, IndicadorProcesado
                    )
                    VALUES
                    (
                        YEAR(GETDATE())*100+MONTH(GETDATE()),
                        'O', @IdOrdenAtencion, GETDATE(), 1
                    );
                END
            END
        END
        ELSE
        BEGIN
            -- 3) Lógica para Procedimientos (TipoOrden <> 1)
            SELECT @EXISTE = COUNT(1)
            FROM SS_PR_Procedimiento WITH (NOLOCK)
            WHERE IdOrdenAtencion = @IdOrdenAtencion
              AND LineaOrdenAtencion = @LineaOrdenAtencion
              AND Estado = 2;

            IF @EXISTE = 0
            BEGIN
                SELECT
                    @IdMedico              = c.IdMedico,
                    @Especialidad          = h.IdEspecialidad,
                    @IdConsultorio         = h.IdConsultorio,
                    @IdCita                = c.IdCita,
                    @IdCitaEstadoDocumento = c.EstadoDocumento
                FROM SS_CC_Cita c WITH (NOLOCK)
                JOIN SS_CC_Horario h WITH (NOLOCK) ON c.IdHorario = h.IdHorario
                JOIN SS_AD_OrdenAtencionDetalle od WITH (NOLOCK)
                  ON od.IdCita = c.IdCita
                 AND od.IdOrdenAtencion = @IdOrdenAtencion
                 AND od.Linea = @LineaOrdenAtencion;

                DECLARE @IDPROC INT, @MAXPC INT;
                SELECT @IDPROC = ISNULL(MAX(IdProcedimiento), 0) + 1
                FROM SS_PR_Procedimiento;

                INSERT INTO SS_PR_Procedimiento
                (
                    IdProcedimiento, IdMaestroProcedimiento, FechaProcedimiento,
                    IdOrdenAtencion, LineaOrdenAtencion, IdCita,
                    Especialidad, medico, EstadoDocumento, Estado,
                    UsuarioCreacion, FechaCreacion, IndicadorAutorizacion,
                    RutaFormatoAutorizacion, IndicadorPreparacion,
                    IndicadorRM, IndAdicionarComponente, Consultorio                    
                )
                VALUES
                (
                    @IDPROC, 0, @FechaCreacion,
                    @IdOrdenAtencion, @LineaOrdenAtencion, ISNULL(@IdCita, 0),
                    @Especialidad, @IdMedico, 1, 2,
                    @Usuario, @FechaCreacion, 0,
                    '', 0,
                    1, 0, @IdConsultorio
                );

                SELECT @MAXPC = ISNULL(MAX(Secuencial), 0) + 1
                FROM SS_PR_ProcedimientoControl
                WHERE IdDocumento = @IDPROC;

                INSERT INTO SS_PR_ProcedimientoControl
                (
                    IdDocumento, Secuencial, FechaControl, Observacion,
                    IdUsuario, EstadoDocumento, EstadoDocumentoAnterior,
                    IndicadorRetorno, Periodo, Estado,
                    UsuarioCreacion, FechaCreacion,
                    UsuarioModificacion, FechaModificacion
                )
                VALUES
                (
                    @IDPROC, @MAXPC, @FechaCreacion, 'Nuevo Procedimiento ITHCE',
                    @Usuario, 1, NULL, 1,
                    YEAR(GETDATE())*100+MONTH(GETDATE()), 2,
                    @Usuario, @FechaCreacion,
                    @Usuario, @FechaCreacion
                );

                UPDATE SS_AD_OrdenAtencionDetalle
                SET IndicadorProcedimiento = 2
                WHERE IdOrdenAtencion = @IdOrdenAtencion
                  AND Linea = @LineaOrdenAtencion;

                IF @IdCita IS NOT NULL
                BEGIN
                    UPDATE SS_CC_Cita
                    SET
                        EstadoDocumentoAnterior = @IdCitaEstadoDocumento,
                        EstadoDocumento = 4
                    WHERE IdCita = @IdCita;

                    SELECT @SecuencialMaxCita = ISNULL(MAX(Secuencial),0)+1
                    FROM SS_CC_CitaControl
                    WHERE IdDocumento = @IdCita;

                    INSERT INTO SS_CC_CitaControl
                    (
                        IdDocumento, Secuencial, FechaControl, Observacion,
                        IdUsuario, EstadoDocumento, EstadoDocumentoAnterior,
                        IndicadorRetorno, Estado, UsuarioCreacion, FechaCreacion,
                        UsuarioModificacion, FechaModificacion
                    )
                    VALUES
                    (
                        @IdCita, @SecuencialMaxCita, @FechaCreacion,
                        'Estado En Atencion HCE',
                        @Usuario, 4, @IdCitaEstadoDocumento,
                        1, 2, @Usuario, @FechaCreacion,
                        @Usuario, @FechaCreacion
                    );
                END

                SELECT @p_devhce = ISNULL(ValorNumerico, 1)
                FROM SG_Opcion
                WHERE CodigoOpcion = 'P_HC_DEVHHMM'
                  AND TipoOpcion = 'P';

                IF @p_devhce = 2
                BEGIN
                    SELECT @oacambio = COUNT(1)
                    FROM SS_AD_OrdenAtencionCambio WITH (NOLOCK)
                    WHERE TipoTabla = 'O'
                      AND IdTabla = @IdOrdenAtencion
                      AND IndicadorProcesado = 1;

                    IF @oacambio IS NULL OR @oacambio = 0
                    BEGIN
                        INSERT INTO SS_AD_OrdenAtencionCambio
                        (
                            Periodo, TipoTabla, IdTabla, FechaCambio, IndicadorProcesado
                        )
                        VALUES
                        (
                            YEAR(GETDATE())*100+MONTH(GETDATE()),
                            'O', @IdOrdenAtencion, GETDATE(), 1
                        );
                    END
                END
            END
        END

        COMMIT TRAN;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;

        DECLARE
            @ErrNo INT = ERROR_NUMBER(),
            @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE(),
            @ErrSev INT = ERROR_SEVERITY(),
            @ErrState INT = ERROR_STATE();

        RAISERROR('Error %d: %s', @ErrSev, @ErrState, @ErrNo, @ErrMsg);
        RETURN -1;
    END CATCH;
END;
GO



CREATE OR ALTER PROCEDURE [dbo].[SP_HCE_InteroperabilidadSalidaV0002]

    @UnidadReplicacion VARCHAR(15),
    @IdEpisodioAtencion INT,
    @IdPaciente INT,
    @EpisodioClinico INT

AS

/***OBS::  Código DESDE CREAR CONSULTA */

BEGIN

------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------

--------------------------1.- LLENAR TABLA SS_IT_HCEATENDIDOCONSULTAEXTERNA-----------------------------------

------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------
DECLARE @CANT int 
	select @CANT= COUNT(*) from SS_IT_SaludConsultaExternaIngreso where
			UnidadReplicacion = @UnidadReplicacion AND
			IdEpisodioAtencion = @IdEpisodioAtencion AND
			IdPaciente = @IdPaciente AND
			EpisodioClinico  = @EpisodioClinico

IF @CANT=0
	begin
		exec SP_HCE_ITIDConsultaExterna @UnidadReplicacion,@IdEpisodioAtencion,@IdPaciente,@EpisodioClinico
	end

		INSERT INTO SS_IT_SaludATENDIDOConsultaExternaIngreso(IdOrdenAtencion, LineaOrdenAtencionConsulta, UnidadReplicacion, IdEpisodioAtencion,
			   IdPaciente, EpisodioClinico, Estado, UsuarioCreacion ,FechaCreacion ,UsuarioModificacion, FechaModificacion, IndicadorProcesado,
				   FechaProcesado,TipoOrdenAtencion)
		SELECT IdOrdenAtencion,LineaOrdenAtencion,UnidadReplicacion,EpisodioAtencion,
				IdPaciente,EpisodioClinico,2,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion, 1, GETDATE(),TipoOrdenAtencion
		FROM WEB_ERPSALUD.DBO.SS_HC_EpisodioAtencion 
		WHERE

       UnidadReplicacion = @UnidadReplicacion AND

       EpisodioAtencion = @IdEpisodioAtencion AND

       IdPaciente = @IdPaciente AND

       EpisodioClinico  = @EpisodioClinico

END

GO

CREATE OR ALTER PROCEDURE [dbo].[SP_SS_HC_ProcedimientoInformeSPRING_LISTAR]
    @IdPaciente             INT,
    @Paciente               VARCHAR(300),
    @CodigoOA               VARCHAR(15),
    @CodigoComponente       VARCHAR(25),
    @DescripcionComponente  VARCHAR(300),
    @Inicio                 INT,
    @NumeroFilas            INT,
    @Accion                 VARCHAR(25)
AS
BEGIN
    SET NOCOUNT ON;

    IF (@Accion = 'LISTARPAG')
    BEGIN
        DECLARE @Contador INT;

        SELECT @Contador = COUNT(*)
        FROM SS_PR_ProcedimientoInforme PI WITH (NOLOCK)
        INNER JOIN SS_PR_Procedimiento P WITH (NOLOCK) ON P.IdProcedimiento = PI.IdProcedimiento
        INNER JOIN SS_AD_OrdenAtencionDetalle OAD WITH (NOLOCK) ON OAD.IdOrdenAtencion = P.IdOrdenAtencion AND OAD.Linea = P.LineaOrdenAtencion
        INNER JOIN CM_CO_Componente C WITH (NOLOCK) ON OAD.Componente = C.CodigoComponente
        INNER JOIN SS_AD_OrdenAtencion OA ON OA.IdOrdenAtencion = P.IdOrdenAtencion
        WHERE (@CodigoOA IS NULL OR OA.CodigoOA LIKE '%' + @CodigoOA + '%')
          AND (@DescripcionComponente IS NULL OR C.Descripcion LIKE '%' + @DescripcionComponente + '%')
          AND (@IdPaciente IS NULL OR @IdPaciente = 0 OR OA.IdPaciente = @IdPaciente);

        ;WITH ResultadosPaginados AS (
            SELECT
                PI.IdProcedimiento,
                PI.Nombre AS NombreArchivo,
                REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                    PI.RutaInforme,
                    'X:\', '\\SVSB-SERV-FL02\pdf-imagenes\'),
                    'W:\', '\\SVSB-SERV-FL02\PDF-Precisa\'),
                    'R:\', '\\SVSB-SERV-FL02\PDF_Patologia\'),
                    '\\172.0.3.5\', '\\SVSB-SERV-FL02\'),
                    'B:\', '\\SVSB-SERV-FL02\Informes Radiologia\') AS RutaInforme,
                OA.IdPaciente,
                '' AS Paciente,
                OA.CodigoOA,
                C.CodigoComponente,
                C.Descripcion AS DescripcionComponente,
                OAD.IdOrdenAtencion,
                OAD.Linea AS LineaOA,
                OAD.TipoOrdenAtencion,
                PM.Busqueda AS Medico,
                '' AS Observacion,
                P.FechaProcedimiento,
                PI.FechaCreacion,
                OA.Sucursal AS UsuarioCreacion,
                PI.FechaModificacion,
                PI.UsuarioModificacion,
                PI.RutaInforme AS Accion,
                @Contador AS Contador_filas,
                ROW_NUMBER() OVER (ORDER BY P.FechaProcedimiento DESC) AS RowNum
            FROM SS_PR_ProcedimientoInforme PI WITH (NOLOCK)
            INNER JOIN SS_PR_Procedimiento P WITH (NOLOCK) ON P.IdProcedimiento = PI.IdProcedimiento
            LEFT JOIN PersonaMast PM WITH (NOLOCK) ON P.Medico = PM.Persona
            INNER JOIN SS_AD_OrdenAtencionDetalle OAD WITH (NOLOCK) ON OAD.IdOrdenAtencion = P.IdOrdenAtencion AND OAD.Linea = P.LineaOrdenAtencion
            INNER JOIN CM_CO_Componente C WITH (NOLOCK) ON OAD.Componente = C.CodigoComponente
            INNER JOIN SS_AD_OrdenAtencion OA ON OA.IdOrdenAtencion = P.IdOrdenAtencion
            WHERE (@CodigoOA IS NULL OR OA.CodigoOA LIKE '%' + @CodigoOA + '%')
              AND (@DescripcionComponente IS NULL OR C.Descripcion LIKE '%' + @DescripcionComponente + '%')
              AND (@IdPaciente IS NULL OR @IdPaciente = 0 OR OA.IdPaciente = @IdPaciente)
        )
        SELECT 
            IdProcedimiento,
            NombreArchivo,
            RutaInforme,
            IdPaciente,
            Paciente,
            CodigoOA,
            CodigoComponente,
            DescripcionComponente,
            IdOrdenAtencion,
            LineaOA,
            TipoOrdenAtencion,
            Medico,
            Observacion,
            FechaProcedimiento,
            FechaCreacion,
            UsuarioCreacion,
            FechaModificacion,
            UsuarioModificacion,
            Accion,
            Contador_filas
        FROM ResultadosPaginados
        WHERE (@Inicio IS NULL AND @NumeroFilas IS NULL)
           OR RowNum BETWEEN @Inicio AND @NumeroFilas;
    END
END

/*    
EXEC SP_SS_HC_ProcedimientoInformeSPRING_LISTAR    
1026, NULL, NULL, NULL, NULL, 0 , 30, 'LISTARPAG'

--I:\Laboratorio\0500000710342013102800009603631.pdf
--F:\
*/ 
GO

CREATE OR ALTER PROCEDURE [dbo].[SP_HCE_ITListarValidacion]
   (    
    @UnidadReplicacion		VARCHAR(15)=NULL,
    @IdEpisodioAtencion		INT=NULL,
    @IdPaciente				INT=NULL,
    @EpisodioClinico		INT=NULL,
    @UsuarioCreacion		VARCHAR(150)=NULL,
	@IdOrdenAtencion		INT=NULL,
	@Linea					INT=NULL,
	@SecuenciaHCE			VARCHAR(15)=NULL,
	@FechaCreacion			DATETIME=NULL 
   ) 
WITH RECOMPILE
AS  

BEGIN   
DECLARE @IdConsultaExterna int
DECLARE @XLINEA int,@SECUENCIALRECETA int, @CORRELATIVOINDANT int,@IDPROCEDIMIENTO INT
DECLARE @indvalidarcantidadcmp INT , @cantidadcmp  INT

IF @UsuarioCreacion='DELETERECETA'
begin
	
		IF 	(Select COUNT(TipoOrdenAtencion) from SS_AD_OrdenAtencionDetalle where IdOrdenAtencion=@IdOrdenAtencion and Linea=@Linea AND TipoOrdenAtencion=1)>0
			BEGIN 
				SELECT @XLINEA = Linea FROM SS_AD_OrdenAtencionDetalle  WITH (NOLOCK) WHERE 
				IdOrdenAtencion = @IDordenatencion and SECUENCIALHCE=@SecuenciaHCE and ISNULL(IndicadorCobrado,1)<>2

				SELECT @SECUENCIALRECETA = Secuencial,	 @IdConsultaExterna = IDConsultaexterna	FROM SS_CE_ConsultaExternaReceta
				WHERE IdOrdenAtencion = @IDordenatencion and LineaOrdenAtencion=@XLINEA

				SELECT @CORRELATIVOINDANT = correlativo		FROM SS_CE_CEDetalleIndicaciones WITH (NOLOCK)
				WHERE IdConsultaExterna=@IdConsultaExterna AND Secuencial=@SECUENCIALRECETA						

				DELETE FROM SS_CE_CEDetalleIndicaciones WHERE IdConsultaExterna = @IdConsultaExterna AND  correlativo = @CORRELATIVOINDANT
				DELETE FROM SS_CE_Indicaciones WHERE IdConsultaExterna = @IdConsultaExterna AND  Secuencial = @CORRELATIVOINDANT
				DELETE FROM SS_CE_ConsultaExternaReceta WHERE IdOrdenAtencion   = @IDordenatencion   AND  LineaOrdenAtencion    = @XLINEA 

				DELETE FROM SS_AD_OrdenAtencionDetalle WHERE IdOrdenAtencion=@IdOrdenAtencion and Linea=@XLINEA

			END
		ELSE
			BEGIN
				SELECT @XLINEA = Linea FROM SS_AD_OrdenAtencionDetalle  WITH (NOLOCK) WHERE 
				IdOrdenAtencion = @IDordenatencion and SECUENCIALHCE=@SecuenciaHCE and ISNULL(IndicadorCobrado,1)<>2

				DELETE SS_PR_ProcedimientoDetalle WHERE IdOrdenAtencion=@IdOrdenAtencion AND LineaOrdenAtencion=@XLINEA 
				DELETE SS_AD_OrdenAtencionDetalle WHERE IdOrdenAtencion=@IdOrdenAtencion AND Linea=@XLINEA AND   ISNULL(IndicadorCobrado,1)<>2

				select 1
			END
end
else 
IF @UsuarioCreacion='DELETEINFORME'
	begin



		SELECT @IDPROCEDIMIENTO = IDPROCEDIMIENTO
		FROM SS_PR_Procedimiento
		WHERE IdOrdenAtencion = @IDordenatencion and LineaOrdenAtencion=@linea

		DELETE FROM SS_PR_ProcedimientoInforme WHERE IdProcedimiento=@IDPROCEDIMIENTO
			
		select 1
	end
else
IF @UsuarioCreacion='DELETEAPOYO'
	begin
		IF 	(Select COUNT(TipoOrdenAtencion) from SS_AD_OrdenAtencionDetalle where IdOrdenAtencion=@IdOrdenAtencion and Linea=@Linea AND TipoOrdenAtencion=1)>0
				BEGIN 
					SELECT @XLINEA = Linea FROM SS_AD_OrdenAtencionDetalle  WITH (NOLOCK) WHERE 
					IdOrdenAtencion = @IDordenatencion and SECUENCIALHCE=@SecuenciaHCE and ISNULL(IndicadorCobrado,1)<>2

					SELECT @SECUENCIALRECETA = Secuencial,	 @IdConsultaExterna = IDConsultaexterna	FROM SS_CE_ConsultaExternaReceta
					WHERE IdOrdenAtencion = @IDordenatencion and LineaOrdenAtencion=@XLINEA

					SELECT @CORRELATIVOINDANT = correlativo		FROM SS_CE_CEDetalleIndicaciones WITH (NOLOCK)
					WHERE IdConsultaExterna=@IdConsultaExterna AND Secuencial=@SECUENCIALRECETA

					DELETE FROM SS_CE_CEDetalleIndicaciones WHERE IdConsultaExterna = @IdConsultaExterna AND  correlativo = @CORRELATIVOINDANT
					DELETE FROM SS_CE_ConsultaExternaReceta WHERE IdOrdenAtencion   = @IDordenatencion   AND  LineaOrdenAtencion    = @XLINEA 
					
					DELETE FROM SS_CE_ConsultaExternaOrdenMedica WHERE IdOrdenAtencion=@IdOrdenAtencion	 and LineaOrdenAtencion=@XLINEA
					DELETE FROM SS_AD_OrdenAtencionDetalle WHERE IdOrdenAtencion=@IdOrdenAtencion and Linea=@XLINEA

				
				END
			ELSE
				BEGIN
					SELECT @XLINEA = Linea FROM SS_AD_OrdenAtencionDetalle  WITH (NOLOCK) WHERE 
					IdOrdenAtencion = @IDordenatencion and SECUENCIALHCE=@SecuenciaHCE and ISNULL(IndicadorCobrado,1)<>2
					DELETE FROM SS_CE_ConsultaExternaOrdenMedica WHERE IdOrdenAtencion=@IdOrdenAtencion	 and LineaOrdenAtencion=@XLINEA
					DELETE FROM SS_PR_ProcedimientoDetalle WHERE IdOrdenAtencion=@IdOrdenAtencion AND LineaOrdenAtencion=@XLINEA 
					DELETE FROM SS_AD_OrdenAtencionDetalle WHERE IdOrdenAtencion=@IdOrdenAtencion AND Linea=@XLINEA AND   ISNULL(IndicadorCobrado,1)<>2

					select 1
			END
	end
else
if @UsuarioCreacion='DELETEINTER' -- 25/02/2020 / luke
	begin
		SELECT @XLINEA = Linea FROM SS_AD_OrdenAtencionDetalle  WITH (NOLOCK) WHERE 
				IdOrdenAtencion = @IDordenatencion and SECUENCIALHCE=@SecuenciaHCE and ISNULL(IndicadorCoberturado,0)<>1

		IF 	(Select COUNT(TipoOrdenAtencion) from SS_AD_OrdenAtencionDetalle where IdOrdenAtencion=@IdOrdenAtencion and 
		Linea=@Linea --AND Componente='500101'
		)>0
			BEGIN 
				DELETE FROM SS_AD_OrdenAtencionDetalle WHERE IdOrdenAtencion=@IdOrdenAtencion and Linea=@XLINEA and IndicadorCoberturado is null

				DELETE FROM SS_CE_ConsultaExternaOrdenMedica WHERE IdOrdenAtencion=@IdOrdenAtencion	 and LineaOrdenAtencion=@XLINEA --and Componente='500101'
				select 1
			END
		ELSE
			BEGIN

				DELETE FROM SS_CE_ConsultaExternaOrdenMedica WHERE IdOrdenAtencion=@IdOrdenAtencion	 and LineaOrdenAtencion=@XLINEA
				DELETE FROM SS_AD_OrdenAtencionDetalle WHERE IdOrdenAtencion=@IdOrdenAtencion AND Linea=@XLINEA  and IndicadorCoberturado is null				

		select 1
		END
	END
else 
IF @UsuarioCreacion='ADDOMAINWE'
	begin

		SELECT 'Innpares.local' NombreDominioRed,'Clinica Innpares' DescripcionLocal,'' UnidadReplicacion,d.nombrecompleto,d.documento,d.tipodocumento
			,B.Usuario		,B.UsuarioPerfil		,B.Nombre		,B.Clave		,B.ExpirarPasswordFlag,B.FechaExpiracion		,B.UltimoLogin		
			,B.NumeroLoginsDisponible		,B.NumeroLoginsUsados		,B.UsuarioRed		,B.SQLLogin		,B.SQLPassword		,B.Estado		,B.UltimoUsuario
			,B.UltimaFechaModif	,D.persona ,    'N' AS IndicadorValidarUsuarioRed ,Sucursal UnidadReplicacionDominioRed
		FROM  Usuario B 
			LEFT JOIN EMPLEADOMAST A WITH(ROWLOCK) ON A.CodigoUsuario=B.Usuario 
			LEFT JOIN PERSONAMAST D WITH(ROWLOCK) ON A.Empleado=D.persona 
			LEFT JOIN SG_Agente E  WITH(ROWLOCK) ON B.Usuario=E.CodigoAgente 
		WHERE b.Estado='A'
		AND B.Usuario=@SecuenciaHCE
		
	end
else
IF @UsuarioCreacion='LISTALMACEN'
	begin

		SELECT UnidadReplicacion,DescripcionLocal,'01000000' Compania,Sucursal,
		'000011' AlmacenFarmacia,'000002'   AS  AlmacenEmergencia,'000002' AS AlmacenCentroObstetrico,'000013' AlmacenHospitalaria FROM SY_UnidadReplicacion 
		WHERE Estado='A' AND UnidadReplicacion = @UnidadReplicacion

	end
else
if @UsuarioCreacion='ANULAROA'--  02/03/2020 / luke
	begin
		declare @idhorario int
		declare @tipoatencion int
		set @idhorario =(select IdCita from SS_CC_Cita where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea)
		set @tipoatencion =(Select TipoOrdenAtencion from SS_AD_OrdenAtencionDetalle 
							where IdOrdenAtencion=@IdOrdenAtencion and 	Linea=@Linea)

		if(@tipoatencion)=11
		begin
			update SS_AD_OrdenAtencionDetalle set IndicadorCoberturado=null,IdPersonaAntUnificacion=null where IdOrdenAtencion=@IdOrdenAtencion and Linea=@Linea  
			-- and Componente='500101'
			update SS_CE_ConsultaExternaOrdenMedica set MedicoResponsable=null where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea and Componente='500101'
			delete from SS_CE_ConsultaExterna where IdOrdenAtencion= @IdOrdenAtencion and LineaOrdenAtencion=@Linea 
		end
		if(@tipoatencion=1)
		begin
			update SS_AD_OrdenAtencionDetalle set IndicadorCoberturado=null,IdPersonaAntUnificacion=null where IdOrdenAtencion=@IdOrdenAtencion and Linea=@Linea 
			--and Componente='500101'
			update SS_CE_ConsultaExternaOrdenMedica set MedicoResponsable=null where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea and Componente='500101'
			update SS_CE_ConsultaExterna set Medico=null where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea
		end

		select 1
	end
else
if @UsuarioCreacion='DERIVACION'
	begin
	select 0 as indicadorCobrado1,SECUENCIALHCE AS indicadorCobrado from SS_AD_OrdenAtencionDetalle  OAD
	 where 
		(@IdPaciente IS NULL OR OAD.IdPaciente=@IdPaciente)
	AND (@IdOrdenAtencion IS NULL OR OAD.IdOrdenAtencion=@IdOrdenAtencion)	
	and OAD.Linea=1

	select 1
	end
--else 
--if @UsuarioCreacion='INSERTINTER' --  02/03/2020 / luke
--	begin
--	if @SecuenciaHCE='INSERT'
--		begin
--		update SS_AD_OrdenAtencionDetalle set IndicadorAtencion=1 where 
--				 (@IdPaciente IS NULL OR IdPaciente=@IdPaciente)
--				AND (@IdOrdenAtencion IS NULL OR IdOrdenAtencion=@IdOrdenAtencion)	
--				and Linea=1
--		end
--	 if @SecuenciaHCE='NUEVO'
--		begin
--		update SS_AD_OrdenAtencionDetalle set IndicadorAtencion=NULL where 
--				 (@IdPaciente IS NULL OR IdPaciente=@IdPaciente)
--				AND (@IdOrdenAtencion IS NULL OR IdOrdenAtencion=@IdOrdenAtencion)	
--				and  Linea=1
--		END
--	select 1

--	end
else
if @UsuarioCreacion='UPDATEINTER'--  25/02/2020 / luke APERTURAR INTERCONSULTA
	begin
		if(Select COUNT(TipoOrdenAtencion) from SS_AD_OrdenAtencionDetalle where IdOrdenAtencion=@IdOrdenAtencion and 
		Linea=@Linea AND Componente='500101')>0
			begin
				update SS_AD_OrdenAtencionDetalle set IndicadorCoberturado=1,IdPersonaAntUnificacion=CONVERT(int,@SecuenciaHCE) where IdOrdenAtencion=@IdOrdenAtencion and Linea=@Linea and Componente='500101'
				update SS_CE_ConsultaExternaOrdenMedica set MedicoResponsable=CONVERT(int,@SecuenciaHCE) where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea and Componente='500101'
			end
		if(Select COUNT(IdConsultaExterna) from SS_CE_ConsultaExterna where IdOrdenAtencion=@IdOrdenAtencion and 
		LineaOrdenAtencion=@Linea )>0
			begin
				update SS_CE_ConsultaExterna set Medico=CONVERT(int,@SecuenciaHCE) where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea 
			end
		select 1
	end
else
IF @UsuarioCreacion='DELETEDIAX' --ELIMINA DIAGNÓSTICO
	begin
		SELECT @IdConsultaExterna = IDConsultaexterna
		FROM SS_CE_ConsultaExterna
		WHERE IdOrdenAtencion = @IDordenatencion and LineaOrdenAtencion=@linea
		/* NUEVO */
		SELECT @IDPROCEDIMIENTO =IDPROCEDIMIENTO
		FROM SS_PR_Procedimiento 
		WHERE IdOrdenAtencion=@IdOrdenAtencion AND LineaOrdenAtencion=@Linea

		DELETE SS_PR_ProcedimientoDiagnostico WHERE IdProcedimiento=@IDPROCEDIMIENTO AND IdDiagnostico=@IdEpisodioAtencion
		/*CIERRE*/
		DELETE FROM SS_CE_ConsultaExternaDiagnostico WHERE IDConsultaexterna=@IdConsultaExterna
			and iddiagnostico=@IdEpisodioAtencion
		select 1
	end
else
IF @UsuarioCreacion='UPDATE_HISTORIA'
	begin		
	DECLARE @CONTADORPER INT    
	DECLARE @CONTADORPAC INT       
	DECLARE @CodigoHC VARCHAR(15)
	DECLARE @INDIHC INT  

	set @FechaCreacion= getdate()

	SELECT @CONTADORPAC=COUNT(SS_GE_Paciente.IdPaciente),@CodigoHC=MAX(SS_GE_Paciente.CodigoHC) FROM SS_GE_Paciente WHERE IdPaciente= @IdPaciente

	SET @INDIHC = 0
	IF @CONTADORPAC=0
		BEGIN
			SELECT @CodigoHC = GE_Correlativos.CorrelativoNumero+1
			FROM GE_Correlativos 
			WHERE GE_Correlativos.TipoComprobante = 'HC' 
			AND GE_Correlativos.UnidadReplicacion = @UnidadReplicacion
			AND GE_Correlativos.Compania = '00000000'
			AND GE_Correlativos.Sucursal = @UnidadReplicacion


			UPDATE  GE_Correlativos WITH(ROWLOCK) SET GE_Correlativos.CorrelativoNumero = @CodigoHC, GE_Correlativos.UsuarioModificacion = 'HCE', 
			GE_Correlativos.FechaModificacion = GetDate() 
			FROM GE_Correlativos 
			WHERE GE_Correlativos.TipoComprobante = 'HC' 
			AND GE_Correlativos.UnidadReplicacion = @UnidadReplicacion
			AND GE_Correlativos.Compania ='00000000'
			AND GE_Correlativos.Sucursal = @UnidadReplicacion

			insert into SS_GE_Paciente( IdPaciente,CodigoHC , FechaIngreso, IndicadorNuevo,Estado,FechaCreacion,IDPACIENTE_OK,UsuarioCreacion)            
			values  (  @IdPaciente,@CodigoHC,GETDATE(),1,2,GETDATE(),@IdPaciente,'HCE'	)   


			SET @INDIHC = 1

		END
	ELSE
		BEGIN
			IF	@CodigoHC = '' OR @CodigoHC IS NULL
			BEGIN
				SELECT @CodigoHC = GE_Correlativos.CorrelativoNumero+1
				FROM GE_Correlativos 
				WHERE GE_Correlativos.TipoComprobante = 'HC' 
				AND GE_Correlativos.UnidadReplicacion = @UnidadReplicacion
				AND GE_Correlativos.Compania = '00000000'
				AND GE_Correlativos.Sucursal = @UnidadReplicacion


				UPDATE  GE_Correlativos WITH(ROWLOCK) SET GE_Correlativos.CorrelativoNumero = @CodigoHC, GE_Correlativos.UsuarioModificacion = 'HCE', 
				GE_Correlativos.FechaModificacion = GetDate() 
				FROM GE_Correlativos 
				WHERE GE_Correlativos.TipoComprobante = 'HC' 
				AND GE_Correlativos.UnidadReplicacion = @UnidadReplicacion
				AND GE_Correlativos.Compania ='00000000'
				AND GE_Correlativos.Sucursal = @UnidadReplicacion

				UPDATE SS_GE_Paciente WITH(ROWLOCK) SET SS_GE_Paciente.CodigoHC = @CodigoHC,UsuarioModificacion = 'HCE'
				FROM SS_GE_Paciente 
				WHERE  SS_GE_Paciente.IdPaciente = @IdPaciente

				SET @INDIHC = 1
			END 
		END

		 SELECT 'HISTORIA'= @CodigoHC,'INDICADOR'=@INDIHC;

	end
else
IF @UsuarioCreacion='VER_ATENCIONES'
	begin

	SELECT ss_ad_ordenatencion.idordenatencion,       Isnull(ss_ce_consultaexterna.fechaconsulta, 
       ss_ad_ordenatenciondetalle.fechamodificacion)       AS     FechaConsulta, 
       ss_ad_ordenatenciondetalle.especialidad,  'OA : ' + CONVERT(VARCHAR(15), ss_ad_ordenatencion.idordenatencion )     AS Id, 
       ss_ad_ordenatencion.codigooa,        ss_ad_ordenatencion.tipoordenatencion, 
       ss_ad_ordenatencion.tipoatencion,        ss_ad_ordenatencion.tipopaciente, 
       CASE 
         WHEN ss_ad_ordenatencion.tipoatencion = 1 THEN 
         ss_ad_ordenatencion.modalidad 
         ELSE cm_ca_transaccion.modalidad 
       END                                                              AS        Modalidad, 
       Isnull(ss_ce_consultaexterna.medico, ss_pr_procedimiento.medico) AS        Medico, 
       Medico.nombrecompleto, 
       NULL                                                             AS        IdHospitalizacion, 
       NULL                                                             AS        EstadoHospitalizacion, 
       Isnull(ss_ce_consultaexterna.idconsultaexterna, 0)               AS        IdConsultaExterna, 
       ss_ce_consultaexterna.tipoconsulta,    ss_ad_ordenatenciondetalle.linea,    ss_ad_ordenatencion.unidadreplicacion,
	   ss_ad_ordenatencion.idpaciente 
	FROM   ss_ad_ordenatenciondetalle 
		   INNER JOIN ss_cc_cita              ON ss_cc_cita.idcita = ss_ad_ordenatenciondetalle.idcita 
		   LEFT JOIN ss_ad_ordenatencion      ON ss_ad_ordenatencion.idordenatencion =  ss_ad_ordenatenciondetalle.idordenatencion 
		   LEFT JOIN ss_ce_consultaexterna    ON ( ss_ce_consultaexterna.idordenatencion =  ss_ad_ordenatenciondetalle.idordenatencion 
					 AND ss_ce_consultaexterna.lineaordenatencion =  ss_ad_ordenatenciondetalle.linea )  AND ss_ce_consultaexterna.estado = 2 
		   LEFT JOIN ss_ge_paciente           ON ss_ad_ordenatencion.idpaciente = ss_ge_paciente.idpaciente 
		   LEFT JOIN personamast              ON ss_ge_paciente.idpaciente = personamast.persona 
		   LEFT JOIN ss_cc_horario            ON ss_cc_horario.idhorario = ss_cc_cita.idhorario 
		   LEFT JOIN ss_pr_procedimiento      ON ss_ad_ordenatenciondetalle.idordenatencion =  ss_pr_procedimiento.idordenatencion 
					 AND ss_pr_procedimiento.lineaordenatencion = ss_ad_ordenatenciondetalle.linea 
		   LEFT JOIN personamast AS Medico    ON Medico.persona = Isnull(ss_ce_consultaexterna.medico, ss_pr_procedimiento.medico) 
		   LEFT JOIN ss_ge_servicio			  ON ( ss_ge_servicio.idservicio = ss_ad_ordenatencion.idservicio ) 
		   LEFT JOIN ss_ge_consultorio        ON ( ss_ge_consultorio.idconsultorio = ss_cc_horario.idconsultorio ) 
		   LEFT JOIN ss_ge_grupoatencion      ON ( ss_ge_grupoatencion.idgrupoatencion = ss_cc_cita.idgrupoatencion ) 
		   LEFT JOIN ss_ge_especialidad		  ON ( ss_ge_especialidad.idespecialidad =   ss_ad_ordenatenciondetalle.especialidad ) 
		   LEFT JOIN empleadomast			  ON ( empleadomast.empleado = MEDICO.persona ) 
		   LEFT JOIN cm_ca_transacciondetalle ON ( cm_ca_transacciondetalle.idoaorigen =   ss_ad_ordenatenciondetalle.idordenatencion 
					 AND cm_ca_transacciondetalle.idoalineaorigen =   ss_ad_ordenatenciondetalle.linea ) 
		   LEFT JOIN cm_ca_transaccion		  ON ( cm_ca_transaccion.idtransaccion =   cm_ca_transacciondetalle.idtransaccion ) 
	WHERE  ss_ad_ordenatencion.idpaciente = 9523209 
		   AND ss_ad_ordenatenciondetalle.indicadordisponible = 2 
		   AND ss_ad_ordenatenciondetalle.tipoordenatencion IN ( 1, 11, 12 ) 
		   AND ( ( ss_cc_cita.estadodocumento IN ( 3, 8, 4 )    AND ss_ad_ordenatencion.tipoatencion IN ( 1, 2 ) 
				   AND NOT cm_ca_transaccion.idtransaccion IS NULL ) 
				  OR ( ss_ad_ordenatencion.tipoatencion = 2   AND ss_ce_consultaexterna.estadodocumento <> 3 ) ) 
	UNION ALL 

	SELECT ss_ad_ordenatencion.idordenatencion,       ss_ho_hospitalizacion.fechahospitalizacion, 
		   ss_ad_ordenatencion.especialidad,  'H : '  + CONVERT(VARCHAR(15), ss_ho_hospitalizacion.idhospitalizacion ) AS Id, 
		   ss_ad_ordenatencion.codigooa,       ss_ad_ordenatencion.tipoordenatencion, 
		   ss_ad_ordenatencion.tipoatencion,        ss_ad_ordenatencion.tipopaciente, 
		   ss_ad_ordenatencion.modalidad,        ss_ho_hospitalizacion.medicotratante, 
		   Medico.nombrecompleto,        ss_ho_hospitalizacion.idhospitalizacion, 
		   ss_ho_hospitalizacion.estadodocumento                            AS     EstadoHospitalizacion, 
		   NULL,  NULL,  ss_ho_hospitalizacion.lineaordenatencion,     ss_ad_ordenatencion.unidadreplicacion,
		   ss_ho_hospitalizacion.idpaciente 
	FROM   ss_ho_hospitalizacion 
		   INNER JOIN ss_ad_ordenatencion  ON ss_ho_hospitalizacion.idordenatencion = ss_ad_ordenatencion.idordenatencion 
		   LEFT JOIN ss_ge_paciente        ON ss_ho_hospitalizacion.idpaciente = ss_ge_paciente.idpaciente 
		   LEFT JOIN personamast           ON ss_ho_hospitalizacion.idpaciente = personamast.persona 
		   LEFT JOIN ss_ge_turno           ON ss_ge_turno.idturno = ss_ad_ordenatencion.idturno 
		   LEFT JOIN personamast AS MEDICO ON MEDICO.persona = ss_ho_hospitalizacion.medicotratante 
		   LEFT JOIN ss_ge_servicio        ON ( ss_ge_servicio.idservicio = ss_ad_ordenatencion.idservicio ) 
		   LEFT JOIN ss_ge_grupoatencion   ON ( ss_ge_grupoatencion.idgrupoatencion = 
					   ss_ge_servicio.idgrupoatencion 
					 ) 
		   LEFT JOIN ss_ge_especialidad    ON ( ss_ge_especialidad.idespecialidad = 
					   ss_ad_ordenatencion.especialidad 
					 ) 
		   LEFT JOIN empleadomast          ON ( empleadomast.empleado = MEDICO.persona ) 
		   LEFT JOIN personamast AS EMPASEGURADORA    ON EMPASEGURADORA.persona = 
					 ss_ad_ordenatencion.idempresaaseguradora 
		   LEFT JOIN personamast AS EMPEMPLEADORA     ON EMPEMPLEADORA.persona = ss_ad_ordenatencion.idempresaempleadora 
		   INNER JOIN ss_ad_ordenatenciondetalle      ON ( ss_ad_ordenatenciondetalle.idordenatencion =  ss_ho_hospitalizacion.idordenatencion 
						AND ss_ad_ordenatenciondetalle.linea = ss_ho_hospitalizacion.lineaordenatencion ) 
		   LEFT JOIN ss_ge_componenteprestacion       ON ss_ge_componenteprestacion.componente = ss_ad_ordenatenciondetalle.componente 
		   LEFT JOIN cm_co_componente                 ON cm_co_componente.codigocomponente =     ss_ad_ordenatenciondetalle.componente 
	WHERE  ss_ho_hospitalizacion.idpaciente = 9523209 
	--order by ss_ho_hospitalizacion.idpaciente asc
	UNION ALL 

	SELECT DISTINCT ss_ad_ordenatencion.idordenatencion,					ss_ho_hospitalizacionvisitas.fechavisita, 
					ss_ad_ordenatencion.especialidad, 'V : ' + CONVERT(VARCHAR(15), ss_ho_hospitalizacionvisitas.idvisitas ) AS Id, 
					ss_ad_ordenatencion.codigooa, 				ss_ad_ordenatencion.tipoordenatencion, 
					ss_ad_ordenatencion.tipoatencion, 			ss_ad_ordenatencion.tipopaciente, 
					ss_ad_ordenatencion.modalidad,   			ss_ho_hospitalizacionvisitas.idmedico, 
					personamast.nombrecompleto, 				ss_ho_hospitalizacion.idhospitalizacion, 
					NULL 	AS EstadoHospitalizacion, 	NULL, 	NULL, 		NULL, 
					ss_ad_ordenatencion.unidadreplicacion ,ss_ho_hospitalizacion.idpaciente
	FROM   ss_ho_hospitalizacionvisitas 
		   INNER JOIN ss_ho_hospitalizacion             ON ss_ho_hospitalizacion.idhospitalizacion =  ss_ho_hospitalizacionvisitas.idhospitalizacion 
		   LEFT JOIN ss_ho_hospitalizacionordenmedica   ON ss_ho_hospitalizacionordenmedica.idhospitalizacion =  ss_ho_hospitalizacionvisitas.idhospitalizacion 
							   					 AND ss_ho_hospitalizacionordenmedica.SecuencialVisita =  ss_ho_hospitalizacionvisitas.idvisitas 
		   LEFT JOIN ss_ad_ordenatencion                ON ss_ad_ordenatencion.idordenatencion =  ss_ho_hospitalizacionordenmedica.idordenatencion 
		   LEFT JOIN personamast                        ON ss_ho_hospitalizacionvisitas.idmedico = personamast.persona 
		   LEFT JOIN empleadomast                       ON personamast.persona = empleadomast.empleado 
	WHERE  ss_ad_ordenatencion.idpaciente =	9523209	-- @IdPaciente

end

else
IF @UsuarioCreacion='PERFILEXA'
	begin

	SELECT NULL AS Linea, '' AS SecuenciaHCE, '' AS IndicadorProcedimiento, '' AS IndicadorCobrado1, 
	NULL AS IdOrdenAtencion, '' AS UsuarioCreacion

	--SELECT 1 as Linea,SS_GE_ComponentePerfil.ComponentePerfil as SecuenciaHCE, SS_GE_ComponentePerfil.Secuencial as IndicadorProcedimiento,
	--SS_GE_ComponentePerfil.Estado as IndicadorCobrado1,1 as IdOrdenAtencion, (SELECT CONCAT( CM_CO_Componente.Nombre, '|', '[', SS_GE_ComponentePerfil.ComponentePerfil,']' ) )   as UsuarioCreacion
	--FROM SS_GE_ComponentePerfil 
	--LEFT JOIN CM_CO_Componente ON CM_CO_Componente.CodigoComponente = SS_GE_ComponentePerfil.ComponentePerfil
	--WHERE SS_GE_ComponentePerfil.Componente = @SecuenciaHCE AND SS_GE_ComponentePerfil.Estado = 2 

	end
else  	
if  @UsuarioCreacion='DATA_PACIENTES'
	begin

	SELECT SS_SG_MaestroCobertura.Descripcion as "cobertura",
	 SS_SG_Contrato.CodigoContrato as "contrato",
	 SS_GE_TipoProgramaModalidad.Nombre as "modalidad",
	 SS_AD_OrdenAtencion.IdPoliza as "poliza"
	 FROM SS_AD_OrdenAtencion 
	LEFT JOIN SS_SG_MaestroCobertura ON (SS_SG_MaestroCobertura.IdCobertura =SS_AD_OrdenAtencion.IdCobertura )
	LEFT JOIN SS_SG_Contrato ON (SS_SG_Contrato.IdContrato =SS_AD_OrdenAtencion.IdContrato )
	LEFT JOIN SS_GE_TipoProgramaModalidad ON (SS_GE_TipoProgramaModalidad.Secuencial =SS_AD_OrdenAtencion.Modalidad AND SS_GE_TipoProgramaModalidad.IdTipoPrograma=1)
	where SS_AD_OrdenAtencion.IdOrdenAtencion=@IdOrdenAtencion and SS_AD_OrdenAtencion.UnidadReplicacion=@UnidadReplicacion

end
else  	
if  @UsuarioCreacion='P_ACTVALCPM'
	begin

		--SELECT @indvalidarcantidadcmp=indvalidarcantidadcmp,@cantidadcmp= cantidadcmp 
		--FROM SY_UNIDADREPLICACION
		--WHERE UnidadReplicacion  = @UnidadReplicacion 

		SELECT YEAR(FechaInicio) Anyo, MONTH(FechaInicio) Mes ,IdPaciente,Especialidad,COUNT(IdPaciente)Cantidad FROM SS_AD_OrdenAtencion
		WHERE  TipoAtencion=1 AND TipoPaciente=6  
		AND YEAR(FechaInicio) = YEAR(GETDATE()) AND   MONTH(FechaInicio) = MONTH(GETDATE())
		AND UnidadReplicacion = @UnidadReplicacion
		AND IdPaciente = @IdPaciente --9718709
		AND Especialidad = @IdEpisodioAtencion --9718709
		GROUP BY IdPaciente ,YEAR(FechaInicio) , MONTH(FechaInicio) ,Especialidad
		HAVING COUNT(IdPaciente)>=0 --2
		ORDER BY 2 DESC,3 DESC


end

else  
if @UsuarioCreacion='DISPE'
	begin
	SELECT OAD.IndicadorCobrado,OAD.Linea ,OAD.SECUENCIALHCE as SecuenciaHCE,OAD.Componente,
	OAD.IndicadorCobrado,OAD.CantidadDespachada as IndicadorProcedimiento,--OAD.IndicadorProcedimiento
	OAD.IndicadorCoberturado as IndicadorCobrado1 -- 24-02-2020 luke / indicador para interconsulta
	,OAD.IdPaciente,OAD.IdOrdenAtencion FROM SS_AD_OrdenAtencion OA WITH(NOLOCK)
	INNER JOIN SS_AD_OrdenAtencionDetalle OAD WITH(NOLOCK) ON OA.IdOrdenAtencion =OAD.IdOrdenAtencion
	WHERE
			(@IdPaciente IS NULL OR OAD.IdPaciente=@IdPaciente)
		AND (@IdOrdenAtencion IS NULL OR OAD.IdOrdenAtencion=@IdOrdenAtencion)	
		AND OAD.TipoOrdenAtencion =13
			order by OAD.Linea asc
	end

else  
if @UsuarioCreacion='DISPE2'
	begin
	SELECT OAD.IndicadorCobrado,OAD.Linea ,OAD.SECUENCIALHCE as SecuenciaHCE,OAD.Componente,
	OAD.IndicadorCobrado,OAD.CantidadDespachada as IndicadorProcedimiento,--OAD.IndicadorProcedimiento
	OAD.IndicadorCoberturado as IndicadorCobrado1 -- 24-02-2020 luke / indicador para interconsulta
	,OAD.IdPaciente,OAD.IdOrdenAtencion FROM SS_AD_OrdenAtencion OA WITH(NOLOCK)
	INNER JOIN SS_AD_OrdenAtencionDetalle OAD WITH(NOLOCK) ON OA.IdOrdenAtencion =OAD.IdOrdenAtencion
	WHERE
		 (@IdOrdenAtencion IS NULL OR OAD.IdOrdenAtencion=@IdOrdenAtencion)	
		and OAD.TipoOrdenAtencion =13
			order by OAD.Linea asc
	end

else  
if @UsuarioCreacion='DATA_INTERCONSULTA'
	begin
	SELECT OAD.IndicadorCobrado,OAD.Linea ,OAD.SECUENCIALHCE as SecuenciaHCE,OAD.Componente,
	OAD.IndicadorCobrado,OAD.CantidadDespachada as IndicadorProcedimiento,--OAD.IndicadorProcedimiento
	OAD.IdCita as IndicadorCobrado1 -- 24-02-2020 luke / indicador para interconsulta
	,OAD.IdPaciente,OAD.IdOrdenAtencion FROM SS_AD_OrdenAtencion OA WITH(NOLOCK)
	INNER JOIN SS_AD_OrdenAtencionDetalle OAD WITH(NOLOCK) ON OA.IdOrdenAtencion =OAD.IdOrdenAtencion
	WHERE
		 	(@IdPaciente IS NULL OR OAD.IdPaciente=@IdPaciente)
		AND (@IdOrdenAtencion IS NULL OR OAD.IdOrdenAtencion=@IdOrdenAtencion)	
	--	AND (@UnidadReplicacion IS NULL OR OAD.Sucursal=@UnidadReplicacion)  // MODIFICADO POR GUILLERMO
	end
else 
if @UsuarioCreacion='COD_COMPONENTE'
	begin
	DECLARE @ll_turno INT

		SELECT TOP 1 @ll_turno = IdTurno FROM SS_GE_Turno WHERE Grupo = 'E' AND Convert(Varchar(15), HoraInicio,108) <  Convert(Varchar(15), GETDATE() , 108)  					

		IF @Linea=30 
		BEGIN 
			SELECT CodigoComponente = CM_CO_TablaMaestroDetalleConcepto.ValorTexto,CM_CO_Componente.Descripcion--,CM_CO_TablaMaestroDetalleConcepto.IdConcepto 
						FROM CM_CO_TablaMaestroDetalleConcepto
			INNER JOIN CM_CO_Componente ON CM_CO_Componente.CodigoComponente=CM_CO_TablaMaestroDetalleConcepto.ValorTexto
						WHERE CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro = 107 				
						AND CM_CO_TablaMaestroDetalleConcepto.IdConcepto IN (SELECT CM_CO_TablaMaestroConcepto.IdConcepto  
								FROM CM_CO_TablaMaestroConcepto  
								WHERE (CM_CO_TablaMaestroConcepto.IdTablaMaestro = 107 )
										AND (CM_CO_TablaMaestroConcepto.Concepto = 'COMPONENTE' ))	
						AND CM_CO_TablaMaestroDetalleConcepto.IdCodigo IN (SELECT CM_CO_TablaMaestroDetalleConcepto.IdCodigo
						FROM CM_CO_TablaMaestroConcepto, 
								CM_CO_TablaMaestroDetalleConcepto  
						WHERE (CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro = CM_CO_TablaMaestroConcepto.IdTablaMaestro) 
						AND (CM_CO_TablaMaestroDetalleConcepto.IdConcepto = CM_CO_TablaMaestroConcepto.IdConcepto) 
								AND (CM_CO_TablaMaestroConcepto.IdTablaMaestro = 107 ) 
								AND (CM_CO_TablaMaestroConcepto.Concepto = 'TIPOATENCION' 
								AND CM_CO_TablaMaestroDetalleConcepto.valorinicialn = 2 )) 
						AND CM_CO_TablaMaestroDetalleConcepto.IdCodigo IN (SELECT CM_CO_TablaMaestroDetalleConcepto.IdCodigo
								FROM CM_CO_TablaMaestroConcepto, CM_CO_TablaMaestroDetalleConcepto  
								WHERE (CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro = CM_CO_TablaMaestroConcepto.IdTablaMaestro) 
								AND (CM_CO_TablaMaestroDetalleConcepto.IdConcepto = CM_CO_TablaMaestroConcepto.IdConcepto) 
								AND (CM_CO_TablaMaestroConcepto.IdTablaMaestro = 107 )
								AND (CM_CO_TablaMaestroConcepto.Concepto = 'TURNO')
								AND CM_CO_TablaMaestroDetalleConcepto.valorinicialn=@ll_turno							
										)
				AND CM_CO_Componente.Descripcion LIKE '%'+'EMERGENCISTA'+'%'
			END
		ELSE
			BEGIN
			SELECT CodigoComponente = CM_CO_TablaMaestroDetalleConcepto.ValorTexto ,ls_CentroCosto=CM_CO_Componente.Descripcion --,CM_CO_TablaMaestroDetalleConcepto.IdConcepto 
						FROM CM_CO_TablaMaestroDetalleConcepto
			INNER JOIN CM_CO_Componente ON CM_CO_Componente.CodigoComponente=CM_CO_TablaMaestroDetalleConcepto.ValorTexto
						WHERE CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro = 107 				
						AND CM_CO_TablaMaestroDetalleConcepto.IdConcepto IN (SELECT CM_CO_TablaMaestroConcepto.IdConcepto  
								FROM CM_CO_TablaMaestroConcepto  
								WHERE (CM_CO_TablaMaestroConcepto.IdTablaMaestro = 107 )
										AND (CM_CO_TablaMaestroConcepto.Concepto = 'COMPONENTE' ))	
						AND CM_CO_TablaMaestroDetalleConcepto.IdCodigo IN (SELECT CM_CO_TablaMaestroDetalleConcepto.IdCodigo
						FROM CM_CO_TablaMaestroConcepto, 
								CM_CO_TablaMaestroDetalleConcepto  
						WHERE (CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro = CM_CO_TablaMaestroConcepto.IdTablaMaestro) 
						AND (CM_CO_TablaMaestroDetalleConcepto.IdConcepto = CM_CO_TablaMaestroConcepto.IdConcepto) 
								AND (CM_CO_TablaMaestroConcepto.IdTablaMaestro = 107 ) 
								AND (CM_CO_TablaMaestroConcepto.Concepto = 'TIPOATENCION' 
								AND CM_CO_TablaMaestroDetalleConcepto.valorinicialn = 2 )) 
						AND CM_CO_TablaMaestroDetalleConcepto.IdCodigo IN (SELECT CM_CO_TablaMaestroDetalleConcepto.IdCodigo
								FROM CM_CO_TablaMaestroConcepto, CM_CO_TablaMaestroDetalleConcepto  
								WHERE (CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro = CM_CO_TablaMaestroConcepto.IdTablaMaestro) 
								AND (CM_CO_TablaMaestroDetalleConcepto.IdConcepto = CM_CO_TablaMaestroConcepto.IdConcepto) 
								AND (CM_CO_TablaMaestroConcepto.IdTablaMaestro = 107 )
								AND (CM_CO_TablaMaestroConcepto.Concepto = 'TURNO')
								AND CM_CO_TablaMaestroDetalleConcepto.valorinicialn=@ll_turno							
										)
			AND CM_CO_Componente.Descripcion LIKE '%'+'ESPECIALISTA'+'%'
		END		
	
	end
else
	begin
	SELECT OAD.IndicadorCobrado,OAD.Linea ,OAD.SECUENCIALHCE as SecuenciaHCE,OAD.Componente,
	OAD.IndicadorCobrado,OAD.Cantidad as IndicadorProcedimiento,--OAD.IndicadorProcedimiento
	OAD.IndicadorCoberturado as IndicadorCobrado1 -- 24-02-2020 luke / indicador para interconsulta
	,OAD.IdPaciente,OAD.IdOrdenAtencion,isnull(OA.IndicadorAltaMedica,1) IndicadorAltaMedica FROM SS_AD_OrdenAtencion OA WITH(NOLOCK)
	INNER JOIN SS_AD_OrdenAtencionDetalle OAD WITH(NOLOCK) ON OA.IdOrdenAtencion =OAD.IdOrdenAtencion
	WHERE
			SECUENCIALHCE IS NOT NULL
		AND	(@IdPaciente IS NULL OR OAD.IdPaciente=@IdPaciente)
		AND (@IdOrdenAtencion IS NULL OR OAD.IdOrdenAtencion=@IdOrdenAtencion)	
	end


end
GO

CREATE OR ALTER PROCEDURE [dbo].[SP_HCE_ITListarValidacionEmergencia]
(
    @UnidadReplicacion		VARCHAR(15)=NULL,
    @IdEpisodioAtencion		INT=NULL,
    @IdPaciente				INT=NULL,
    @EpisodioClinico		INT=NULL,
	@IdConsultaExterna		INT= NULL,
	@IdOrdenAtencion		INT=NULL,
	@Linea					INT=NULL,
	@LineaOrdenAtencion		INT=NULL,
	@TipoOrdenMedica		INT=null,
	@Componente				varchar(25)=null,
	@TipoInterConsulta		INT=NULL,
	@Medico					INT=NULL,
	@Especialidad			INT=NULL,
	@EstadoDocumento		INT=NULL,
	@IndicadorEPS			INT=NULL,
	@Estado					INT=NULL,
	@MedicoResponsable		int=null,
    @UsuarioCreacion		VARCHAR(15)=NULL,
	@UsuarioModificacion	VARCHAR(3000)=NULL,
	@SecuenciaHCE			VARCHAR(15)=NULL,
	@FechaCreacion			DATETIME=NULL ,
	@FechaModificacion		DATETIME=NULL,
	@Accion					varchar(25)=null,
	@Version				varchar(25)=null
   ) 
   WITH RECOMPILE
    
as

begin
	DECLARE @idhorario int
	DECLARE @idcita int
	DECLARE @idconsulta int
	DECLARE @secuencia  int
	DECLARE @tipoatencion int
	DECLARE @idprocedimiento int
	DECLARE @lineaNueva int
	DECLARE @tipoOrdenAtencion int
	DECLARE @nombreComponente varchar(200)
	DECLARE @acompaniantefamiliar varchar(200)
	DECLARE @destino varchar(200)
	DECLARE @IdEmpresaAseguradora int

	-- EMERGENCIA ASIGNACION 
	DECLARE @as_componente CHAR(25)
	DECLARE @as_INDEMER INT	
	DECLARE @ll_turno INT
	DECLARE @IndicadorHonorarios INT


if(@Accion='UPDATEINTER')
	BEGIN

	set @idhorario=( SELECT top 1 isnull(SS_CC_Horario.IdHorario,0) as IdHorario FROM SS_CC_Horario WITH(NOLOCK) 
	 WHERE 
	CAST(GETDATE() AS DateTime) <= SS_CC_Horario.FechaFin AND 
	((DATEPART(dw, CAST(GETDATE() AS DateTime))=1 AND IndicadorDomingo=2) OR 
	(DATEPART(dw, CAST(GETDATE()  AS DateTime))=2 AND IndicadorLunes=2) 
	OR  (DATEPART(dw, CAST(GETDATE()  AS DateTime))=3 AND IndicadorMartes=2) OR 
	(DATEPART(dw, CAST(GETDATE()  AS DateTime))=4 AND IndicadorMiercoles=2) OR 
	(DATEPART(dw, CAST(GETDATE()  AS DateTime))=5 AND IndicadorJueves=2) OR 
	(DATEPART(dw, CAST(GETDATE()  AS DateTime))=6 AND IndicadorViernes=2) OR 
	(DATEPART(dw, CAST(GETDATE()  AS DateTime))=7 AND IndicadorSabado=2) ) 
	AND SS_CC_Horario.Estado = 2 AND SS_CC_Horario.IdEspecialidad = @Especialidad AND
	SS_CC_Horario.TipoRegistroHorario = 1 --AND SS_CC_Horario.IdTurno = 11 
	AND SS_CC_Horario.Medico = @Medico ) -- falta definir horario

	set @idcita =(select MAX(SS_CC_Cita.IdCita)+1  from SS_CC_Cita )
	--SELECT @idcita = NEXT VALUE FOR dbo.SecuenciaCita
	set @idconsulta = (SELECT max ( SS_CE_ConsultaExterna.IdConsultaExterna )+1 FROM SS_CE_ConsultaExterna)
	set @secuencia =( SELECT max ( SS_CC_CitaControl.Secuencial )+1  FROM SS_CC_CitaControl WHERE IdDocumento= @idcita) 

	INSERT INTO SS_CC_Cita ( IdCita , IdHorario , FechaCita , FechaLlegada , DuracionPromedio , DuracionReal , TipoCita , 
	IdPaciente , EstadoDocumento , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , 
	IndicadorRegistroCompartido , IdTipoAtencion , IdGrupoAtencion , IdServicio , IdMedico , FechaCitaFecha , UnidadReplicacion ) VALUES
	( @idcita , @idhorario , GETDATE() , GETDATE() , 2 , 2 , 2 , @IdPaciente , 4 , 2 , @UsuarioCreacion ,GETDATE() , @UsuarioModificacion ,
	 GETDATE() , 1 , 2 , 6 , 16 , @Medico , GETDATE() , @UnidadReplicacion )

	INSERT INTO SS_CC_CitaControl ( IdDocumento , Secuencial , FechaControl , Observacion , IdUsuario , EstadoDocumento ,
	 IndicadorRetorno , Estado , UsuarioCreacion , FechaCreacion  ) VALUES 
	 ( @idcita, @secuencia , GETDATE()  , 'Estado Atendido' , @UsuarioCreacion, 4 , 1 , 2 , @UsuarioCreacion , GETDATE()  ) 

	 if(Select COUNT(TipoOrdenAtencion) from SS_AD_OrdenAtencionDetalle where IdOrdenAtencion=@IdOrdenAtencion and 
	Linea=@Linea AND TipoOrdenAtencion=11)>0
	begin

	INSERT INTO SS_CE_ConsultaExterna( IdConsultaExterna , IdCita , IdOrdenAtencion , LineaOrdenAtencion , 
	Consultorio , Medico , Especialidad , FechaConsulta , IndicadorSeguimiento , 
	IdConsultaExternaInicial , EstadoDocumento , Estado , UsuarioCreacion , 
	FechaCreacion , IndicadorFirmaAlta , TipoConsulta,IndicadorFirmaDigital,UsuarioFirmaDigital ) 
	VALUES ( @idconsulta , @idcita , @IdOrdenAtencion , @Linea, 0 , CONVERT(int,@Medico),
	@Especialidad ,GETDATE() , 1 , 1 , 1 , 2 , @UsuarioCreacion , GETDATE(), 1 ,4,1,4) 
	end

	else -- consulta de emergencia
	begin
	update SS_CE_ConsultaExterna set IdCita=@idcita,Medico=@Medico,FechaModificacion=GETDATE() 
	where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea
	end

	update SS_AD_OrdenAtencionDetalle set IndicadorCoberturado=1,IdPersonaAntUnificacion=CONVERT(int,@Medico),IdCita=@idcita
	 where IdOrdenAtencion=@IdOrdenAtencion and Linea=@Linea 

	select @idcita
END

else
if @Accion='ANULAROA'--  02/03/2020 / luke
begin
	Select @tipoOrdenAtencion =TipoOrdenAtencion,@tipoatencion =TipoOrdenAtencion, @idcita =ISNULL(IdCita,0) from SS_AD_OrdenAtencionDetalle where IdOrdenAtencion=@IdOrdenAtencion and Linea=@Linea

	if(@TipoOrdenMedica=1) -- ambulatorio
	begin
		if( @tipoOrdenAtencion=1) --para consulta externa
			begin
				set @idconsulta = (select IdConsultaExterna from SS_CE_ConsultaExterna where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea)
				set @secuencia=(select MAX(Secuencial)+1  from SS_CE_CONSULTAEXTERNACONTROL where IdDocumento=@idconsulta)
				INSERT INTO SS_CE_CONSULTAEXTERNACONTROL (IdDocumento, Secuencial, FechaControl, Observacion, IdUsuario, 
				EstadoDocumento, EstadoDocumentoAnterior, IndicadorRetorno, Periodo, Estado, UsuarioCreacion,  FechaCreacion, UsuarioModificacion, FechaModificacion ) 
				VALUES ( @idconsulta,@secuencia, getdate(), '', @UsuarioCreacion, 3, 1, 1, 0, 2, 
				@UsuarioCreacion, getdate(),@UsuarioCreacion, getdate()) 

				UPDATE SS_CE_ConsultaExterna SET EstadoDocumento = 3, EstadoDocumentoAnterior = 1, UsuarioModificacion = @UsuarioCreacion, 
				FechaModificacion = GETDATE() WHERE IdConsultaExterna = @idconsulta 

				print 'Elimino 1 ' 
			end
			
		else -- para procedimientos
			begin
				set @idprocedimiento =(select IdProcedimiento from SS_PR_Procedimiento where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea)

				UPDATE SS_PR_Procedimiento SET EstadoDocumentoAnterior = 1, EstadoDocumento = 3, UsuarioModificacion = @UsuarioCreacion, 
				FechaModificacion = GETDATE() WHERE IdProcedimiento = @idprocedimiento 
				print 'Elimino 2 ' 
				select @idprocedimiento

			end
            --select @idprocedimiento
		 
		end

	else --emergencia
		begin

		print 'llego tipoatencion ' + convert(varchar,@tipoatencion) + ' TipoOrdenMedica ' +   convert(varchar,@TipoOrdenMedica) + ' idcita ' +   convert(varchar,@idcita)

		if(@tipoatencion=11 and @TipoOrdenMedica=2) -- eliminar interconsultas de emergencias
			begin

				UPDATE SS_AD_OrdenAtencionDetalle set IndicadorCoberturado=null,IdPersonaAntUnificacion=null, IndicadorEliminado=2 WHERE IdOrdenAtencion=@IdOrdenAtencion and Linea=@Linea --and Componente='500101'
				UPDATE SS_CE_ConsultaExterna SET EstadoDocumento = 3, EstadoDocumentoAnterior = 1, UsuarioModificacion = @UsuarioCreacion, 
				FechaModificacion = GETDATE() WHERE IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea		--IdConsultaExterna = @idconsulta 
				UPDATE SS_CC_Cita set EstadoDocumentoAnterior=EstadoDocumento,EstadoDocumento=4,  UsuarioModificacion = @UsuarioCreacion ,
				FechaModificacion = GETDATE() WHERE IdCita= @idcita 
			
				set @idconsulta = (select IdConsultaExterna from SS_CE_ConsultaExterna where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea)
				print 'llego IdConsultaExterna ' + convert(varchar,@idconsulta) + ' IdCita ' +   convert(varchar,@idcita)
				
				print 'Elimino 3 ' 
			end

		else if(@TipoOrdenMedica=2 and @tipoatencion=1) -- eliminar atencion de emergencia
			begin

				set @idconsulta = (select IdConsultaExterna from SS_CE_ConsultaExterna where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea)

				set @secuencia=(select MAX(Secuencial)+1  from SS_CE_CONSULTAEXTERNACONTROL where IdDocumento=@idconsulta)
				INSERT INTO SS_CE_CONSULTAEXTERNACONTROL (IdDocumento, Secuencial, FechaControl, Observacion, IdUsuario, 
				EstadoDocumento, EstadoDocumentoAnterior, IndicadorRetorno, Periodo, Estado, UsuarioCreacion,  FechaCreacion, UsuarioModificacion, FechaModificacion ) 
				VALUES ( @idconsulta,@secuencia, getdate(), 'Anulación de Atención/HCE', @UsuarioCreacion, 3, 1, 1, 0, 2, 
				@UsuarioCreacion, getdate(),@UsuarioCreacion, getdate()) 

				UPDATE SS_CE_ConsultaExterna SET EstadoDocumento = 3, EstadoDocumentoAnterior = 1, UsuarioModificacion = @UsuarioCreacion, 
				FechaModificacion = GETDATE() WHERE IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea-- IdConsultaExterna = @idconsulta 
				print 'Elimino 4' 
			end

		else -- actualizar un procedimiento de ambulatorio
			begin

			set @idprocedimiento = (select IdProcedimiento from SS_PR_Procedimiento WHERE IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea)
				
				UPDATE SS_AD_OrdenAtencionDetalle set IndicadorCoberturado=null,IdPersonaAntUnificacion=null, IndicadorEliminado=2 WHERE IdOrdenAtencion=@IdOrdenAtencion and Linea=@Linea --and Componente='500101'
				UPDATE SS_CC_Cita SET EstadoDocumento=3, EstadoDocumentoAnterior=0 WHERE IdCita= @idcita 
				UPDATE SS_PR_Procedimiento SET EstadoDocumentoAnterior = 1, EstadoDocumento = 3, UsuarioModificacion = @UsuarioCreacion, 
				FechaModificacion = GETDATE() WHERE IdProcedimiento = @idprocedimiento 

					print 'Elimino 5' 
				SET @idconsulta =  @idprocedimiento
			end


	end

	select @idconsulta
	end

else
if @Accion='RELEVOPRINCIPAL' --  25/03/2021 / luke / VERIFICA LINEA PRINCIPAL DE LA ATENCIÓN
begin
		set @idconsulta=0
		set @lineaNueva=(SELECT max(linea) FROM SS_AD_OrdenAtencionDetalle  WITH (NOLOCK) 
		left join SS_CE_ConsultaExterna  WITH (NOLOCK) on  SS_CE_ConsultaExterna.IdOrdenAtencion=SS_AD_OrdenAtencionDetalle.IdOrdenAtencion and
		SS_CE_ConsultaExterna.LineaOrdenAtencion=SS_AD_OrdenAtencionDetalle.Linea
		where SS_AD_OrdenAtencionDetalle.IdOrdenAtencion=@IdOrdenAtencion 
			 and ( ((SS_AD_OrdenAtencionDetalle.TipoInterConsulta = 3 OR SS_AD_OrdenAtencionDetalle.TipoInterConsulta = 2) or SS_AD_OrdenAtencionDetalle.IndicadorEPS =3) 
			 and  SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion=11 and SS_AD_OrdenAtencionDetalle.IdOrdenAtencion=@IdOrdenAtencion 
			 and SS_CE_ConsultaExterna.Medico is not null) or
			( (SS_AD_OrdenAtencionDetalle.TipoInterConsulta is null or SS_AD_OrdenAtencionDetalle.IndicadorEPS 
			is null) and  SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion=1 and SS_AD_OrdenAtencionDetalle.IdOrdenAtencion=@IdOrdenAtencion ))

	if(@lineaNueva = @Linea)
	begin
	set @idconsulta=1
	end

	--aumento angel 28/03/2022
	else if(@Linea = 1)
	begin
		set @idconsulta=1
	end
	select @idconsulta
end
else


if @Accion='RELEVOPRINCIPALENF' --  09/03/2022 / luke / VERIFICA LINEA PRINCIPAL DE LA ATENCIÓN
begin
	set @idconsulta=0
	set @lineaNueva=(SELECT max(linea) FROM SS_AD_OrdenAtencionDetalle  WITH (NOLOCK) 
	left join SS_CE_ConsultaExterna  WITH (NOLOCK) on  SS_CE_ConsultaExterna.IdOrdenAtencion=SS_AD_OrdenAtencionDetalle.IdOrdenAtencion and
	SS_CE_ConsultaExterna.LineaOrdenAtencion=SS_AD_OrdenAtencionDetalle.Linea
				 where SS_AD_OrdenAtencionDetalle.IdOrdenAtencion=@IdOrdenAtencion 
				 and ( ((SS_AD_OrdenAtencionDetalle.TipoInterConsulta = 3 OR SS_AD_OrdenAtencionDetalle.TipoInterConsulta = 2) or SS_AD_OrdenAtencionDetalle.IndicadorEPS =3) 
				 and  SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion=11 and SS_AD_OrdenAtencionDetalle.IdOrdenAtencion=@IdOrdenAtencion 
				 and SS_CE_ConsultaExterna.Medico is not null) or
				( (SS_AD_OrdenAtencionDetalle.TipoInterConsulta is null or SS_AD_OrdenAtencionDetalle.IndicadorEPS 
				is null) and  SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion=1 and SS_AD_OrdenAtencionDetalle.IdOrdenAtencion=@IdOrdenAtencion ))

		if(@lineaNueva = @Linea)
		begin
		set @idconsulta=1
		end

		IF(SELECT COUNT(*) FROM SS_AD_OrdenAtencionDetalle WHERE IdOrdenAtencion=@IdOrdenAtencion AND TipoInterConsulta in(1,2,3) AND Linea= @lineaNueva )>0
		begin
		set @idconsulta=1
		end
	select @idconsulta
	end

else
if @Accion='DERIVACION'--  25/03/2021 / luke - VALIDACIÓN PARA INTERCONSULTA DE DERIVACIÓN
begin

	set @idconsulta = (select count(*) from SS_AD_OrdenAtencionDetalle where IdOrdenAtencion=@IdOrdenAtencion and Linea=@Linea and TipoOrdenAtencion=11 and (TipoInterConsulta=3 or IndicadorEPS=3))
	select @idconsulta
end

else
if @Accion='ANULARALTA'--  02/03/2020 / luke - ACCIÓN DEL BOTÓN ANULAR ALTA
	begin

	update SS_AD_OrdenAtencion set IndicadorAltaMedica=null,IndicadorAltaMedicaOriginal=null,TipoAltaMedica=null where IdOrdenAtencion=@IdOrdenAtencion
	update SS_CE_ConsultaExterna set IndicadorFirmaAlta=null, IndicadorFirmaDigital=null,EstadoDocumento=1 where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea

	select 1
	end

else
if @Accion='ALTA_ADMIN' -- VALIDACIÓN CUANDO UNA ATENCIÓN DE EMERGENCIA YA ESTÁ COBRADA
	begin

	if(select COUNT(*) from SS_CE_ConsultaExterna where IdOrdenAtencion=@IdOrdenAtencion and TipoConsulta=3) > 0
	begin
	set @lineaNueva = (select top 1 LineaOrdenAtencion from SS_CE_ConsultaExterna where IdOrdenAtencion=@IdOrdenAtencion and TipoConsulta=3 order by FechaCreacion desc)
	set @idconsulta = (select IndicadorCobrado from SS_AD_OrdenAtencionDetalle where IdOrdenAtencion=@IdOrdenAtencion and Linea=@lineaNueva )
	SET @IdConsultaExterna = (CASE when @idconsulta IS NULL or @idconsulta=1  THEN 0 else @idconsulta end)
	end

	else
	begin

	set @idconsulta = (select IndicadorCobrado from SS_AD_OrdenAtencionDetalle where IdOrdenAtencion=@IdOrdenAtencion and Linea=@Linea )
	SET @IdConsultaExterna = (CASE when @idconsulta IS NULL or @idconsulta=1  THEN 0 else @idconsulta end)
	end

	select @IdConsultaExterna
	end

else
if @Accion='MED_RELEVO'
	begin

	set @idconsulta = (select Medico from SS_CE_ConsultaExterna where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea)
	SET @IdConsultaExterna = (CASE when @idconsulta IS NULL THEN 0 else @idconsulta end)

	select @IdConsultaExterna
	end
else
if @Accion='MED_PROCED'
begin

	set @idconsulta = (select Medico from SS_PR_Procedimiento where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea)
	SET @IdConsultaExterna = (CASE when @idconsulta IS NULL THEN 0 else @idconsulta end)

	select @IdConsultaExterna
end

else
if(@Accion='HEADER_DESPACHO')
	begin
	DECLARE @FechaHoy DATETIME
	declare @periodo char(6)
	SET @FechaHoy = GETDATE()
	set @periodo =( select  convert(char(6), @FechaHoy,112) )

	  declare @Numero varchar(10)
	  declare @cval  int
	  declare @cidguia  int

	   SELECT @Numero=RTRIM(CONCAT(RTRIM(@UnidadReplicacion),RIGHT('00000000' + CAST(@IndicadorEPS AS VARCHAR),7)))
	  SET @cidguia= @IndicadorEPS

	  set @idconsulta = (select IdConsultaExterna from SS_CE_ConsultaExterna where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea)
  

	 -- INSERT INTO SS_AD_GuiaFarmacia ( IdGuiaFarmacia,Compania,TipoDocumento,NumeroDocumento,Sucursal,UnidadReplicacion
		--,TransaccionCodigo,FechaDocumento,AlmacenCodigo,ReferenciaTipoDocumento,ReferenciaNumeroDocumento,EstadoDocumento,EstadoDocumentoAnterior
		--,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,TipoTransaccion,IndicadorAlta,Observacion,IdGuiaReferencia,UsuarioSolicitante
		--) VALUES  (@cidguia,'00000000', 'GF',@Numero,@UnidadReplicacion,@UnidadReplicacion,	'PED', GETDATE(),'1003','CE',@idconsulta,1,1,
		--@UsuarioCreacion,GETDATE(), @UsuarioCreacion,GETDATE(),'NS',0,'ENVIO POR HCE',0,@UsuarioCreacion)

	 --INSERT INTO SS_AD_GuiaFarmaciaControl ( IdDocumento , Secuencial , FechaControl , Observacion , 
	 --EstadoDocumento , EstadoDocumentoAnterior , Estado , UsuarioCreacion , FechaCreacion ,  UsuarioModificacion , FechaModificacion ) 
	 -- VALUES ( @cidguia , 1 , GETDATE() , NULL , 1 , 0 , 2 ,   @UsuarioCreacion , GETDATE() , @UsuarioCreacion , GETDATE()) 

	  select @cidguia

	end

else
if(@Accion='UPDATE_DESPACHO')
begin

	DECLARE @SecuencialHCEEnf varchar(20)

	set @Componente= ((select left(@Componente,4))  + (convert(varchar,convert(int,(SELECT substring(@Componente, 4, len(@Componente)))))))

	--SET @cidguia = (select top 1 IdGuiaFarmacia from SS_AD_GuiaFarmacia WHERE  Compania='00000000' AND TipoDocumento='GF'
	--and NumeroDocumento=@Componente and Sucursal='CEG')

	select @lineaNueva= (select linea  from SS_CE_ConsultaExternaRecetaEnfermeria WHERE IdOrdenAtencion=@IdOrdenAtencion AND IdConsultaExterna=@cidguia)

  --DELETE FROM SS_AD_GuiaFarmaciaDetalle WHERE IdGuiaFarmacia=@cidguia
  DELETE FROM SS_AD_OrdenAtencionDetalle WHERE IdOrdenAtencion=@IdOrdenAtencion AND Linea=@lineaNueva    
  DELETE FROM SS_CE_ConsultaExternaRecetaEnfermeria WHERE IdOrdenAtencion=@IdOrdenAtencion AND IdConsultaExterna=@cidguia


  select @cidguia

end


else
if(@Accion = 'UPDATE_RETORNO')
	begin
	
	--UPDATE SS_AD_GUIAFARMACIA			
	--			SET 
	--			EstadoDocumento = 1,
	--			UsuarioModificacion= @UsuarioModificacion,
	--			FechaModificacion= @FechaModificacion
	--			WHERE 
	--			IdGuiaFarmacia = Cast( SUBSTRING(@Componente, 6,6) as int);

	--	select IDGUIAFARMACIA from SS_AD_GUIAFARMACIA where IdGuiaFarmacia = Cast( SUBSTRING(@Componente, 6,6) as int);

		  select 1
	end

else
if(@Accion='UPDATE_DESPACHO_HEADER')-- elimina todo el detalle
begin

  select @IdOrdenAtencion  --@cidguia

end

else
if(@Accion='VALIDATE_PEDIDO')
	begin

	--set @Componente= ((select left(@Componente,3))  + (convert(varchar,convert(int,(SELECT substring(@Componente, 4, len(@Componente)))))))

	--SET @cidguia = (select top 1 EstadoDocumento from SS_AD_GuiaFarmacia WHERE  Compania='00000000' AND TipoDocumento='GF'
	--and NumeroDocumento=@Componente and Sucursal='CEG')

	--SET @cidguia = (case when @cidguia <> 1 then -1 else 0 end)

	--  select @cidguia
	select 1
	end

else
if(@Accion='DETALLE_DESPACHO')
	begin

		--declare @id varchar(25)
		--SELECT @Numero=RTRIM(CONCAT(RTRIM(@UnidadReplicacion),RIGHT('00000000' + CAST(@IndicadorEPS AS VARCHAR),7)))
		--SELECT @Componente=case  when Componente IS null     OR Componente=''  then '0000002108' else Componente
		--	end,@LineaOrdenAtencion=Linea FROM SS_AD_OrdenAtencionDetalle  where IdOrdenAtencion=@idordenatencion  AND SECUENCIALHCE=@SecuenciaHCE	


	 --  INSERT INTO SS_AD_GuiaFarmaciaDetalle ( IdGuiaFarmacia , Secuencial , ReferenciaTipoDocumento ,
		--ReferenciaNumeroDocumento , ReferenciaSecuenciaDocumento , Linea , Familia , SubFamilia , Item , 
		--CantidadSolicitada ,   Estado , UsuarioCreacion ,   FechaCreacion , UsuarioModificacion , FechaModificacion )
		--SELECT  @IdConsultaExterna,Linea,'OA' , idordenatencion,Linea,  LineaFamilia , Familia , SubFamilia ,Componente,
		--@TipoOrdenMedica,2,  @UsuarioCreacion,GETDATE(),@UsuarioCreacion,GETDATE()
		--FROM SS_AD_OrdenAtencionDetalle  WHERE idordenatencion=@idordenatencion AND SECUENCIALHCE=@SecuenciaHCE AND Linea= @LineaOrdenAtencion
	 

		-- if(@SecuenciaHCE is not null)
		-- begin
		--   update SS_AD_OrdenAtencionDetalle set CantidadSolicitada=Convert(decimal,@TipoOrdenMedica)  where IdOrdenAtencion=@idordenatencion  AND SECUENCIALHCE=@SecuenciaHCE	AND Linea= @LineaOrdenAtencion
		-- end

	  select 1
	end

if(@Accion='ALTAMEDICA')
begin

		DECLARE @TipoInterConsID INT 
		SELECT @TipoInterConsID = isnull(TipoInterConsulta,0) FROM SS_AD_OrdenAtencionDetalle WHERE IdOrdenAtencion= @IdOrdenAtencion AND Linea=@Linea
		SELECT 	@idconsulta = isnull(IdConsultaExterna,0)     FROM SS_CE_ConsultaExterna WHERE IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea

		IF @TipoInterConsID=2
			BEGIN
				UPDATE SS_AD_OrdenAtencion SET CoberturaMedicoOriginal = @Especialidad , 
				TipoAltaMedicaOriginal =@TipoInterConsulta , ObservacionAltaOriginal ='sas' , 
				IndicadorAltaMedicaOriginal =2 ,CoberturaMedico =@Especialidad , TipoAltaMedica =@TipoInterConsulta ,
				 ObservacionAlta ='sas', IndicadorAltaMedica =2
				WHERE SS_AD_OrdenAtencion.IdOrdenAtencion = @IdOrdenAtencion 
			END
		ELSE
			BEGIN		
				UPDATE SS_AD_OrdenAtencion SET IdConsultaExternaPrincipal = @idconsulta , CoberturaMedicoOriginal = @Especialidad , 
				TipoAltaMedicaOriginal = @TipoInterConsulta , ObservacionAltaOriginal ='sas' , 
				IndicadorAltaMedicaOriginal =2 ,CoberturaMedico =@Especialidad , TipoAltaMedica =@TipoInterConsulta ,
				 ObservacionAlta ='sas', IndicadorAltaMedica =2
				WHERE SS_AD_OrdenAtencion.IdOrdenAtencion = @IdOrdenAtencion
			END

		--Actualiza EstadoDocumento=2 en la tabla SS_CE_ConsultaExterna.
		update SS_CE_ConsultaExterna SET IndicadorFirmaAlta=2, IndicadorFirmaDigital=2 , SS_CE_ConsultaExterna.EstadoDocumento =2 , 
		SS_CE_ConsultaExterna.EstadoDocumentoAnterior =SS_CE_ConsultaExterna.EstadoDocumento 
		FROM SS_CE_ConsultaExterna WHERE IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea	--and TipoConsulta in (1,2,3)
		--AND IdConsultaExterna =@idconsulta  


		INSERT INTO SS_CE_ConsultaExternaControl(IdDocumento,Secuencial,FechaControl,EstadoDocumento,EstadoDocumentoAnterior,
		IndicadorRetorno,Estado,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion, Observacion, Idusuario)  
		SELECT @idconsulta ,  IsNull((SELECT Max(SS_CE_ConsultaExternaControl.Secuencial) + 1 FROM SS_CE_ConsultaExternaControl 
		WHERE SS_CE_ConsultaExternaControl.IdDocumento =  @idconsulta ),1)  ,  		 GETDATE(),  
		 SS_CE_ConsultaExterna.EstadoDocumento,  		  SS_CE_ConsultaExterna.EstadoDocumentoAnterior,  
		 2, 2,  
		@UsuarioCreacion,GETDATE(), 
		@UsuarioCreacion,GETDATE(), 
		 'Por Alta Medica',  
		 @UsuarioCreacion FROM SS_CE_ConsultaExterna 
		 WHERE SS_CE_ConsultaExterna.IdConsultaExterna = @idconsulta

	select @idconsulta

end

if(@Accion='PROC_EMER')
begin
	select 1
END

if(@Accion='FIRMA_CONSULTA')
begin
	if(@EstadoDocumento = 2)
		begin
			set @idconsulta =(select LineaOrdenAtencion from SS_CE_ConsultaExterna where IdOrdenAtencion=@IdOrdenAtencion and TipoConsulta IN (3,2) )
			update SS_CE_ConsultaExterna set EstadoDocumento= (select EstadoDocumento from SS_CE_ConsultaExterna where IdOrdenAtencion=@IdOrdenAtencion )  where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@idconsulta
		end
	else
		begin
			if(select count(*) from SS_CE_ConsultaExterna where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea and EstadoDocumento <>3)> 0
				begin

					if(select count(*) from SS_CE_ConsultaExterna where IdOrdenAtencion=@IdOrdenAtencion and TipoConsulta=3) = 0
						begin
							update SS_CE_ConsultaExterna set EstadoDocumento= 1  where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion IN ( 1,@Linea)				
						end
			else
				begin
					--RETROCEDE EL ESTADO PARA LOS TIPOCONSULTA  2 = RELEVO   //  3=EMERGENCIA
					set @idconsulta =(select LineaOrdenAtencion from SS_CE_ConsultaExterna where IdOrdenAtencion=@IdOrdenAtencion and TipoConsulta IN (3,2) )
						update SS_CE_ConsultaExterna set EstadoDocumento= 1  where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@idconsulta
				end
		end
	
end

select 1
END

if(@Accion='FIRMA_PROC')
begin
	update SS_PR_Procedimiento set EstadoDocumento= 2 where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion =@Linea
	select 1
END

if(@Accion='HORARIO')
begin
	declare @resultado int
	declare @ll_turn int

	SELECT  @resultado = COUNT(H.IdHorario)  FROM SS_CC_Horario h WITH (NOLOCK) 
	inner join SS_GE_Consultorio c  WITH (NOLOCK) on h.IdConsultorio=c.IdConsultorio
	WHERE 		h.Medico = @Medico  
				AND h.Estado=2
				AND c.TipoUso=2
			AND H.IdEspecialidad = @Especialidad
				AND FechaInicioHorario <= CAST(GETDATE() AS DateTime)
				AND FechaFinHorario  >=    CAST(GETDATE() AS DateTime)
	

select @resultado
END

if(@Accion='RELEVO')
begin

		declare @indicador int
		set @indicador= (select count(*) from SS_CC_Horario where Medico= @Medico and IdEspecialidad=@Especialidad and FechaFin >= GETDATE())
			if(@indicador)=0
				begin
					set @lineaNueva =0
				end
			else
				begin

				SELECT TOP 1 @ll_turno =isnull(SS_GE_Turno.IdTurno ,0)
				FROM SS_GE_Turno 
				WHERE SS_GE_Turno.Grupo ='E' 
				AND Convert ( Varchar ( 15 ) , SS_GE_Turno.HoraInicio , 108 ) < Convert ( Varchar ( 15 ) , GETDATE() , 108 )
				AND Convert ( Varchar ( 15 ) , SS_GE_Turno.HoraFinal , 108 ) >= Convert ( Varchar ( 15 ) , GETDATE() , 108 )
				ORDER BY SS_GE_Turno.IdTurno


				SELECT TOP 1 @idhorario =isnull(MAX(H.IdHorario),0)  FROM SS_CC_Horario h WITH (NOLOCK) 
				inner join SS_GE_Consultorio c  WITH (NOLOCK) on h.IdConsultorio=c.IdConsultorio
				WHERE 	h.Medico = @Medico  
							AND h.Estado=2
						--	AND c.IndicadorEmergencia=2
							AND FechaInicio <= CAST(GETDATE() AS DateTime)
							AND FechaFin  >=    CAST(GETDATE() AS DateTime)
  	
				PRINT ' HORARIO ' +  CONVERT(VARCHAR, @idhorario)

				
			IF @idhorario>0
				BEGIN

					IF @Especialidad=30 OR  @Especialidad=103 
						BEGIN 
							SET @as_INDEMER=2
						END
					ELSE
						BEGIN
							SET @as_INDEMER=1
						END 
				
					SELECT @as_componente =	  CM_CO_TablaMaestroDetalleConcepto.ValorTexto
					FROM CM_CO_TablaMaestroDetalleConcepto
					WHERE CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro = 107
					AND CM_CO_TablaMaestroDetalleConcepto.IdCodigo IN (SELECT
						CM_CO_TablaMaestroDetalleConcepto.IdCodigo
					FROM CM_CO_TablaMaestroConcepto,
							CM_CO_TablaMaestroDetalleConcepto
					WHERE (CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro = CM_CO_TablaMaestroConcepto.IdTablaMaestro)
					AND (CM_CO_TablaMaestroDetalleConcepto.IdConcepto = CM_CO_TablaMaestroConcepto.IdConcepto)
					AND (CM_CO_TablaMaestroConcepto.IdTablaMaestro = 107)
					AND (CM_CO_TablaMaestroConcepto.Concepto = 'TIPOATENCION'
					AND CM_CO_TablaMaestroDetalleConcepto.valorinicialn = 2))
					AND CM_CO_TablaMaestroDetalleConcepto.IdCodigo IN (SELECT
						CM_CO_TablaMaestroDetalleConcepto.IdCodigo
					FROM CM_CO_TablaMaestroConcepto,
							CM_CO_TablaMaestroDetalleConcepto
					WHERE (CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro = CM_CO_TablaMaestroConcepto.IdTablaMaestro)
					AND (CM_CO_TablaMaestroDetalleConcepto.IdConcepto = CM_CO_TablaMaestroConcepto.IdConcepto)
					AND (CM_CO_TablaMaestroConcepto.IdTablaMaestro = 107)
					AND (CM_CO_TablaMaestroConcepto.Concepto = 'TURNO'
					AND (CM_CO_TablaMaestroDetalleConcepto.valorinicialn <= @ll_turno
					AND CM_CO_TablaMaestroDetalleConcepto.valorfinaln >= @ll_turno)))
					AND CM_CO_TablaMaestroDetalleConcepto.IdCodigo IN (SELECT
						CM_CO_TablaMaestroDetalleConcepto.IdCodigo
					FROM CM_CO_TablaMaestroConcepto,
							CM_CO_TablaMaestroDetalleConcepto
					WHERE (CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro = CM_CO_TablaMaestroConcepto.IdTablaMaestro)
					AND (CM_CO_TablaMaestroDetalleConcepto.IdConcepto = CM_CO_TablaMaestroConcepto.IdConcepto)
					AND (CM_CO_TablaMaestroConcepto.IdTablaMaestro = 107)
					AND (CM_CO_TablaMaestroConcepto.Concepto = 'INDEMERGENCISTA'
					AND CM_CO_TablaMaestroDetalleConcepto.valorinicialn = @as_INDEMER))
					AND CM_CO_TablaMaestroDetalleConcepto.IdConcepto IN (SELECT
						CM_CO_TablaMaestroConcepto.IdConcepto
					FROM CM_CO_TablaMaestroConcepto
					WHERE (CM_CO_TablaMaestroConcepto.IdTablaMaestro = 107)
					AND (CM_CO_TablaMaestroConcepto.Concepto = 'COMPONENTE'))

						PRINT ' COMPONENTE INI ' +  @as_componente

					set @idcita =(select MAX(SS_CC_Cita.IdCita)+1  from SS_CC_Cita )
					--SELECT @idcita = NEXT VALUE FOR dbo.SecuenciaCita
					set @idconsulta = (SELECT max ( SS_CE_ConsultaExterna.IdConsultaExterna )+1 FROM SS_CE_ConsultaExterna)
					set @secuencia = ( SELECT max ( SS_CC_CitaControl.Secuencial )+1  FROM SS_CC_CitaControl WHERE IdDocumento=@idcita) 
					set @lineaNueva =( SELECT max ( SS_AD_OrdenAtencionDetalle.Linea )+1  FROM SS_AD_OrdenAtencionDetalle  where IdOrdenAtencion=@IdOrdenAtencion) 

					INSERT INTO SS_CC_Cita ( IdCita , IdHorario , FechaCita , FechaLlegada , DuracionPromedio , DuracionReal , TipoCita , 
					IdPaciente , EstadoDocumento , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , 
					IndicadorRegistroCompartido , IdTipoAtencion , IdGrupoAtencion , IdServicio , IdMedico , FechaCitaFecha , UnidadReplicacion ) VALUES
					( @idcita , @idhorario , GETDATE() , GETDATE() , 2 , 2 , 2 , @IdPaciente , 4 , 2 , @UsuarioCreacion ,GETDATE() , @UsuarioModificacion ,
					 GETDATE() , 1 , 2 , 6 , 16 , @Medico , GETDATE() , @UnidadReplicacion )

					INSERT INTO SS_CC_CitaControl ( IdDocumento , Secuencial , FechaControl , Observacion , IdUsuario , EstadoDocumento ,
					 IndicadorRetorno , Estado , UsuarioCreacion , FechaCreacion  ) VALUES 
					 ( @idcita, @secuencia , GETDATE()  , 'Estado Atendido' , @UsuarioCreacion, 4 , 1 , 2 , @UsuarioCreacion , GETDATE()  ) 

					PRINT ' CITA INI ' +  CONVERT(VARCHAR, @idcita)  
					 insert into SS_AD_OrdenAtencionDetalle (IdOrdenAtencion,Linea,TipoOrdenAtencion,Especialidad,IdCita,IndicadorDisponible,IdServicio,IdTurno,IdPaciente,TipoComponente,
					Componente,Cantidad,CantidadPresupuestada,CantidadSolicitada,IdEstablecimiento,Compania,Sucursal,CentroCosto,UnidadOrganizacional,
					Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndicadorHonorarios) values (
					@IdOrdenAtencion,@lineaNueva,1,@Especialidad,@idcita,2,16,8,@IdPaciente,'C',@as_componente,1,1,1,1,'00000000',@UnidadReplicacion,600100,3004,
					2 , @UsuarioCreacion ,GETDATE() , @UsuarioModificacion ,GETDATE(),2)

					INSERT INTO SS_CE_ConsultaExterna( IdConsultaExterna , IdCita , IdOrdenAtencion , LineaOrdenAtencion , 
					Consultorio , Medico , Especialidad , FechaConsulta , IndicadorSeguimiento , 
					IdConsultaExternaInicial , EstadoDocumento , Estado , UsuarioCreacion , 
					FechaCreacion ,UsuarioModificacion,FechaModificacion , TipoConsulta ) VALUES ( @idconsulta , @idcita , @IdOrdenAtencion , @lineaNueva, null , CONVERT(int,@Medico),
					@Especialidad ,GETDATE() , 2 , @idconsulta , 1 , 2 , @UsuarioCreacion , GETDATE(), @UsuarioCreacion , GETDATE() ,2) 
				END
			ELSE
				BEGIN
				   SET  @lineaNueva=0
				   PRINT ' NO CUENTA HORARIO '
				END

		END
		select @lineaNueva

END

 if(@Accion='EMER_CONSULTA')
	begin

	declare @EspecialidadNueva INT
	
	IF @UsuarioModificacion='ALTA'
		BEGIN 
			IF @Linea=1
			BEGIN 
				SELECT @Especialidad = isnull(IdEspecialidad,30) FROM WEB_ERPSALUD.DBO.SS_HC_EpisodioAtencion WHERE 
				IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea and IdEpisodioAtencion=1 and TipoTrabajador='08'
			END
		END


	SELECT TOP 1 @ll_turno =isnull(SS_GE_Turno.IdTurno ,0)
	FROM SS_GE_Turno 
	WHERE SS_GE_Turno.Grupo ='E' 
	AND Convert ( Varchar ( 15 ) , SS_GE_Turno.HoraInicio , 108 ) < Convert ( Varchar ( 15 ) , GETDATE() , 108 )
	AND Convert ( Varchar ( 15 ) , SS_GE_Turno.HoraFinal , 108 ) >= Convert ( Varchar ( 15 ) , GETDATE() , 108 )
	ORDER BY SS_GE_Turno.IdTurno


	SELECT  @idhorario =isnull(MAX(H.IdHorario),0)--,@Especialidad= H.IdEspecialidad  
	FROM SS_CC_Horario h WITH (NOLOCK) 
	inner join SS_GE_Consultorio c  WITH (NOLOCK) on h.IdConsultorio=c.IdConsultorio
	WHERE 	h.Medico = @Medico  
				AND h.Estado=2
				AND c.TipoUso=2
				AND H.IdEspecialidad = @Especialidad
			--	AND c.IndicadorEmergencia=2
				AND FechaInicioHorario <= CAST(GETDATE() AS DateTime)
				AND FechaFinHorario  >=    CAST(GETDATE() AS DateTime)
	GROUP BY H.IdEspecialidad

  		PRINT ' HORARIO ' +  CONVERT(VARCHAR, @idhorario)
		PRINT ' Especialidad ' +  CONVERT(VARCHAR, @Especialidad)

	SELECT @IdEmpresaAseguradora=isnull(IdEmpresaAseguradora,0) FROM SS_AD_OrdenAtencion WHERE  IdOrdenAtencion=@IdOrdenAtencion

	PRINT ' COMPONENTE INI ' + isnull( @as_componente,'')


IF @idhorario>0
	BEGIN

	if(@UsuarioModificacion='RE_INGRESO') -- RE_INGRESO
	begin
		set @idcita= (select idcita from SS_CE_ConsultaExterna where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea)
		update SS_CC_Cita set IdHorario = @idhorario  where IdCita=@idcita

			IF @as_componente IS NULL OR @as_componente=''
			BEGIN
					IF @Especialidad=30 OR  @Especialidad=103 
							BEGIN 
							SET @as_INDEMER=2					
							END
						ELSE
							BEGIN
							SET @as_INDEMER=1					
						 END	
			
					SELECT @as_componente =	  CM_CO_TablaMaestroDetalleConcepto.ValorTexto
					FROM CM_CO_TablaMaestroDetalleConcepto
					WHERE CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro = 107
					AND CM_CO_TablaMaestroDetalleConcepto.IdCodigo IN (SELECT
						CM_CO_TablaMaestroDetalleConcepto.IdCodigo
					FROM CM_CO_TablaMaestroConcepto,
							CM_CO_TablaMaestroDetalleConcepto
					WHERE (CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro = CM_CO_TablaMaestroConcepto.IdTablaMaestro)
					AND (CM_CO_TablaMaestroDetalleConcepto.IdConcepto = CM_CO_TablaMaestroConcepto.IdConcepto)
					AND (CM_CO_TablaMaestroConcepto.IdTablaMaestro = 107)
					AND (CM_CO_TablaMaestroConcepto.Concepto = 'TIPOATENCION'
					AND CM_CO_TablaMaestroDetalleConcepto.valorinicialn = 2))
					AND CM_CO_TablaMaestroDetalleConcepto.IdCodigo IN (SELECT
						CM_CO_TablaMaestroDetalleConcepto.IdCodigo
					FROM CM_CO_TablaMaestroConcepto,
							CM_CO_TablaMaestroDetalleConcepto
					WHERE (CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro = CM_CO_TablaMaestroConcepto.IdTablaMaestro)
					AND (CM_CO_TablaMaestroDetalleConcepto.IdConcepto = CM_CO_TablaMaestroConcepto.IdConcepto)
					AND (CM_CO_TablaMaestroConcepto.IdTablaMaestro = 107)
					AND (CM_CO_TablaMaestroConcepto.Concepto = 'TURNO'
					AND (CM_CO_TablaMaestroDetalleConcepto.valorinicialn <= @ll_turno
					AND CM_CO_TablaMaestroDetalleConcepto.valorfinaln >= @ll_turno)))
					AND CM_CO_TablaMaestroDetalleConcepto.IdCodigo IN (SELECT
						CM_CO_TablaMaestroDetalleConcepto.IdCodigo
					FROM CM_CO_TablaMaestroConcepto,
							CM_CO_TablaMaestroDetalleConcepto
					WHERE (CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro = CM_CO_TablaMaestroConcepto.IdTablaMaestro)
					AND (CM_CO_TablaMaestroDetalleConcepto.IdConcepto = CM_CO_TablaMaestroConcepto.IdConcepto)
					AND (CM_CO_TablaMaestroConcepto.IdTablaMaestro = 107)
					AND (CM_CO_TablaMaestroConcepto.Concepto = 'INDEMERGENCISTA'
					AND CM_CO_TablaMaestroDetalleConcepto.valorinicialn = @as_INDEMER))
					AND CM_CO_TablaMaestroDetalleConcepto.IdConcepto IN (SELECT
						CM_CO_TablaMaestroConcepto.IdConcepto
					FROM CM_CO_TablaMaestroConcepto
					WHERE (CM_CO_TablaMaestroConcepto.IdTablaMaestro = 107)
					AND (CM_CO_TablaMaestroConcepto.Concepto = 'COMPONENTE'))
						

		END

		update SS_AD_OrdenAtencionDetalle set Especialidad=@Especialidad,Componente=@as_componente,IndicadorHonorarios=@IndicadorHonorarios where IdOrdenAtencion=@IdOrdenAtencion and Linea=@Linea
		update SS_CE_ConsultaExterna set Medico =@Medico,Especialidad= @Especialidad, IndicadorFirmaDigital =2, UsuarioFirmaDigital =@UsuarioCreacion where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea
	end
	else 
	begin
		
		set @idcita = (select MAX(SS_CC_Cita.IdCita)+1  from SS_CC_Cita )
		--SELECT @idcita = NEXT VALUE FOR dbo.SecuenciaCita


		BEGIN TRY
			INSERT INTO SS_CC_Cita ( IdCita , IdHorario , FechaCita , FechaLlegada , DuracionPromedio , DuracionReal , TipoCita , 
			IdPaciente , EstadoDocumento , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , 
			IndicadorRegistroCompartido , IdTipoAtencion , IdGrupoAtencion , IdServicio , IdMedico , FechaCitaFecha , UnidadReplicacion ) VALUES
			( @idcita , @idhorario , GETDATE() , GETDATE() , 2 , 2 , 2 , @IdPaciente , 4 , 2 , @UsuarioCreacion ,GETDATE() , @UsuarioModificacion ,
			 GETDATE() , 1 , 2 , 6 , 16 , @Medico , GETDATE() , @UnidadReplicacion )
			 		
			PRINT ' INSERT INTO  Cita ' +  CONVERT(VARCHAR, @idcita)
		
			 SELECT @secuencia = max ( SS_CC_CitaControl.Secuencial )+1  FROM SS_CC_CitaControl  WHERE IdDocumento = @idcita
			INSERT INTO SS_CC_CitaControl ( IdDocumento , Secuencial , FechaControl , Observacion , IdUsuario , EstadoDocumento ,
			 IndicadorRetorno , Estado , UsuarioCreacion , FechaCreacion  ) VALUES 
			 ( @idcita, @secuencia , GETDATE()  , 'Estado Atendido' , @UsuarioCreacion, 4 , 1 , 2 , @UsuarioCreacion , GETDATE() ) 
		END TRY
		BEGIN CATCH
			DECLARE @Mensaje CHAR(20)
			SET @Mensaje = 'Error al Insertar la Cita'

		END CATCH;
				
		PRINT ' INSERT INTO  SS_CC_CitaControl ' +  CONVERT(VARCHAR, @idcita)

		if(@UsuarioModificacion='INTERCONSULTA') --INTERCONSULTA
			 begin	

				set @idconsulta = (SELECT max ( SS_CE_ConsultaExterna.IdConsultaExterna )+1 FROM SS_CE_ConsultaExterna)

				INSERT INTO SS_CE_ConsultaExterna( IdConsultaExterna , IdCita , IdOrdenAtencion , LineaOrdenAtencion , 
				Consultorio , Medico , Especialidad , FechaConsulta , IndicadorSeguimiento , 
				IdConsultaExternaInicial , EstadoDocumento , Estado , UsuarioCreacion , 
				FechaCreacion , IndicadorFirmaAlta , TipoConsulta,IndicadorFirmaDigital,UsuarioFirmaDigital ) 
				VALUES ( @idconsulta , @idcita , @IdOrdenAtencion , @Linea, 0 , CONVERT(int,@Medico),
				@Especialidad ,GETDATE() , 1 , 1 , 1 , 2 , @UsuarioCreacion , GETDATE(), NULL ,4,2,@UsuarioCreacion ) 
		
				update SS_AD_OrdenAtencionDetalle set IdCita= @idcita, Especialidad=@Especialidad,IdServicio=16,IndicadorProcedimiento=null,IdEstablecimiento=1 , IndicadorDisponible=2,IndicadorHonorarios=@IndicadorHonorarios  where IdOrdenAtencion=@IdOrdenAtencion and Linea=@Linea
			end

		 if(@UsuarioModificacion='PROCEDIEMIENTOX') --PROCEDIMIENTO
			begin
				 if(select count(*) from SS_PR_Procedimiento where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea)=0
				 begin
					set @Componente=(select Componente from SS_AD_OrdenAtencionDetalle where IdOrdenAtencion=@IdOrdenAtencion and Linea=@Linea)
					set @idconsulta = (select max(IdProcedimiento)+1 from SS_PR_Procedimiento)			

					insert into SS_PR_Procedimiento (IdProcedimiento,Especialidad,Medico,Consultorio,IndicadorAutorizacion,RutaFormatoAutorizacion,
										IndicadorPreparacion,IdMaestroProcedimiento,Periodo,FechaProcedimiento,Observacion,IdOrdenAtencion,LineaOrdenAtencion,
										IdCita,TipoAlta,FechaAlta,IdMedicoAutoriza,ObservacionAlta,EstadoDocumentoAnterior,EstadoDocumento,
										RutaInforme,Estado,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,FechaInicio,
										FechaTermino,IndicadorRM,IdMovimiento,IndAdicionarComponente,IndicadorInforme,IndicadorFirmaDigital,UsuarioFirmaDigital)
							values (@idconsulta,@Especialidad,@Medico,null,0,'',
									0,0,NULL,GETDATE(),null,@IdOrdenAtencion,@Linea,
									@idcita,null,null,null,null,null,1,
									null,2,@UsuarioCreacion,GETDATE(),@UsuarioCreacion,GETDATE(),NULL,
									NULL,1,NULL,0,NULL,NULL,NULL)


				 end
				   set @idcita =(select IdCita from SS_PR_Procedimiento where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea)
				   set @idconsulta = (select IdCita from SS_AD_OrdenAtencionDetalle WHERE IdOrdenAtencion=@IdOrdenAtencion and Linea=@Linea )

				 if(@idcita is not null and @idconsulta IS NULL) 
				 begin
					 update SS_AD_OrdenAtencionDetalle set IdCita=@idcita, IndicadorDisponible=2,IndicadorHonorarios=@IndicadorHonorarios where IdOrdenAtencion=@IdOrdenAtencion and Linea=@Linea
					 update SS_PR_Procedimiento set Medico=@Medico , Especialidad=@Especialidad where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea
				 end
			end
		else 
			begin	
			
					IF @as_componente IS NULL OR @as_componente=''
					BEGIN
			
							PRINT ' INGRESO EL COMPONENTE'
							IF @Especialidad=30 OR  @Especialidad=103 
								BEGIN 
									SET @as_INDEMER=2	
									

								END
							ELSE
								BEGIN
									SET @as_INDEMER=1								
								END	
				
							PRINT ' INGRESO INDEMER '  + convert (varchar,@as_INDEMER)
							SELECT @as_componente =	  CM_CO_TablaMaestroDetalleConcepto.ValorTexto
							FROM CM_CO_TablaMaestroDetalleConcepto
							WHERE CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro = 107
							AND CM_CO_TablaMaestroDetalleConcepto.IdCodigo IN (SELECT
								CM_CO_TablaMaestroDetalleConcepto.IdCodigo
							FROM CM_CO_TablaMaestroConcepto,
									CM_CO_TablaMaestroDetalleConcepto
							WHERE (CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro = CM_CO_TablaMaestroConcepto.IdTablaMaestro)
							AND (CM_CO_TablaMaestroDetalleConcepto.IdConcepto = CM_CO_TablaMaestroConcepto.IdConcepto)
							AND (CM_CO_TablaMaestroConcepto.IdTablaMaestro = 107)
							AND (CM_CO_TablaMaestroConcepto.Concepto = 'TIPOATENCION'
							AND CM_CO_TablaMaestroDetalleConcepto.valorinicialn = 2))
							AND CM_CO_TablaMaestroDetalleConcepto.IdCodigo IN (SELECT
								CM_CO_TablaMaestroDetalleConcepto.IdCodigo
							FROM CM_CO_TablaMaestroConcepto,
									CM_CO_TablaMaestroDetalleConcepto
							WHERE (CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro = CM_CO_TablaMaestroConcepto.IdTablaMaestro)
							AND (CM_CO_TablaMaestroDetalleConcepto.IdConcepto = CM_CO_TablaMaestroConcepto.IdConcepto)
							AND (CM_CO_TablaMaestroConcepto.IdTablaMaestro = 107)
							AND (CM_CO_TablaMaestroConcepto.Concepto = 'TURNO'
							AND (CM_CO_TablaMaestroDetalleConcepto.valorinicialn <= @ll_turno
							AND CM_CO_TablaMaestroDetalleConcepto.valorfinaln >= @ll_turno)))
							AND CM_CO_TablaMaestroDetalleConcepto.IdCodigo IN (SELECT
								CM_CO_TablaMaestroDetalleConcepto.IdCodigo
							FROM CM_CO_TablaMaestroConcepto,
									CM_CO_TablaMaestroDetalleConcepto
							WHERE (CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro = CM_CO_TablaMaestroConcepto.IdTablaMaestro)
							AND (CM_CO_TablaMaestroDetalleConcepto.IdConcepto = CM_CO_TablaMaestroConcepto.IdConcepto)
							AND (CM_CO_TablaMaestroConcepto.IdTablaMaestro = 107)
							AND (CM_CO_TablaMaestroConcepto.Concepto = 'INDEMERGENCISTA'
							AND CM_CO_TablaMaestroDetalleConcepto.valorinicialn = @as_INDEMER))
							AND CM_CO_TablaMaestroDetalleConcepto.IdConcepto IN (SELECT
								CM_CO_TablaMaestroConcepto.IdConcepto
							FROM CM_CO_TablaMaestroConcepto
							WHERE (CM_CO_TablaMaestroConcepto.IdTablaMaestro = 107)
							AND (CM_CO_TablaMaestroConcepto.Concepto = 'COMPONENTE'))

							PRINT ' COMPONENTE ' +  @as_componente
	
					END

					update SS_AD_OrdenAtencionDetalle set IdCita= @idcita,Componente=@as_componente,Especialidad=@Especialidad,IndicadorHonorarios= @IndicadorHonorarios where IdOrdenAtencion=@IdOrdenAtencion and Linea=@Linea and @UsuarioModificacion <> 'PROCEDIEMIENTOX' --and TipoOrdenAtencion <> 11
				
					update SS_CE_ConsultaExterna set IdCita=@idcita,Medico =@Medico,Especialidad=@Especialidad, IndicadorFirmaDigital =2, UsuarioFirmaDigital =@UsuarioCreacion where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea and @UsuarioModificacion <> 'PROCEDIEMIENTOX'  and TipoConsulta <> 4
							
					PRINT ' update  SS_CE_ConsultaExterna @idcita=' +  CONVERT(VARCHAR, @idcita) +' @Medico =' +  CONVERT(VARCHAR, @Medico)


			END	
	
	end

	END
ELSE
	BEGIN
	   SET  @Linea=0

	   PRINT ' NO INGRESO '
	END


 select @Linea

end

if(@Accion='DELETE_INTER')
 begin
 	select @tipoatencion = TipoAtencion from SS_AD_OrdenAtencion WITH (NOLOCK)
	WHERE IdOrdenAtencion = @IdOrdenAtencion 
	
	if(@tipoatencion=1)
	begin
		DELETE from SS_CE_ConsultaExternaOrdenMedica where IdOrdenAtencion=@IDordenatencion and TipoOrdenMedica=11
		DELETE from SS_AD_OrdenAtencionDetalle where IdOrdenAtencion= @IDordenatencion and TipoOrdenAtencion=11
		set @idprocedimiento =(select IdProcedimiento from SS_PR_Procedimiento where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea)
		if(select count(*) from SS_PR_ProcedimientoInforme where IdProcedimiento=@idprocedimiento)>0
		begin		
			DELETE FROM SS_PR_ProcedimientoInforme where IdProcedimiento=@idprocedimiento
		end
	end
	select 1
	end

if (@Accion='APE_EMER')
begin
		set @idconsulta=((SELECT Count(CM_CA_Transaccion.IdTransaccion)        FROM CM_CA_Transaccion
		WHERE CM_CA_Transaccion.IdOrdenAtencion = @IdOrdenAtencion
          AND CM_CA_Transaccion.IndicadorAperturaEmergencia = 2
          AND CM_CA_Transaccion.EstadoDocumento = 6))

		  select @idconsulta

end

if (@Accion='LINEA_MED')
begin
	set @IdOrdenAtencion=(select IdOrdenAtencion from SS_AD_OrdenAtencion where CodigoOA=@Componente and Especialidad=30)

	set @idconsulta=(select isnull(Linea,0) Linea from SS_AD_OrdenAtencionDetalle where SECUENCIALHCE=@SecuenciaHCE and IdOrdenAtencion=@IdOrdenAtencion)
	--print @idconsulta
	select isnull(@idconsulta,0)  

end

if (@Accion='LINEA_ENF')
begin
	set @IdOrdenAtencion=(select IdOrdenAtencion from SS_AD_OrdenAtencion where CodigoOA=@Componente and Especialidad=30)
	set @idconsulta=(select ISNULL(MAX(Linea),1) from SS_AD_OrdenAtencionDetalle where IdOrdenAtencion=@IdOrdenAtencion)
	select @idconsulta
end

if (@Accion='DEVOL_DETALLE')
begin

	set @IdOrdenAtencion=(select IdOrdenAtencion from SS_AD_OrdenAtencion where CodigoOA=@Componente and Especialidad=30)
	set @idconsulta=(select Linea from SS_AD_OrdenAtencionDetalle where IdOrdenAtencion=@IdOrdenAtencion and Linea=@Linea)
	UPDATE SS_AD_OrdenAtencionDetalle SET CantidadDevuelta =@TipoInterConsulta WHERE IdOrdenAtencion=@IdOrdenAtencion AND Linea = @Linea
	select @idconsulta

end

if (@Accion='ENFERMERIA')
begin

	if  ( (select count(*) from SS_CE_Enfermeria where IdOrdenAtencion=@IdOrdenAtencion ) = 0 )
	begin
		INSERT INTO SS_CE_Enfermeria ( IdOrdenAtencion , IndicadorFirma , Estado , UsuarioCreacion , 
		FechaCreacion , UsuarioModificacion , FechaModificacion ) VALUES ( @IdOrdenAtencion , 1 , 2 , @UsuarioCreacion , 
		GETDATE() , @UsuarioCreacion ,GETDATE() ) 
	end

	select 1
end

if (@Accion='FIRMA_ENFER')
begin
	update SS_CE_Enfermeria SET IndicadorFirma =2 , IdEnfermera =@Medico , UsuarioModificacion =
	@UsuarioCreacion , FechaModificacion =GETDATE() WHERE SS_CE_Enfermeria.IdOrdenAtencion =@IdOrdenAtencion 

	if(@EpisodioClinico = 1)
	begin
	DECLARE @NUM INT 
	--inserta IdOrdenAtencion, IdNotaEnfermeria, FechaEnfermeria, NotaEnfermeria, etc en la tabla SS_CE_NotaEnfermeria.
	DELETE FROM SS_CE_NotaEnfermeria where IdOrdenAtencion=@IdOrdenAtencion and IdNotaEnfermeria=@IdEpisodioAtencion
	DELETE FROM SS_CE_EnfermeraFirmaControl where IdOrdenAtencion=@IdOrdenAtencion and SecuencialFirma=@IdEpisodioAtencion
	DELETE FROM SS_CE_EnfermeriaComponentesFirma where IdOrdenAtencion=@IdOrdenAtencion and SecuencialFirma=@IdEpisodioAtencion
	
	INSERT INTO SS_CE_NotaEnfermeria ( IdOrdenAtencion, IdNotaEnfermeria,
	FechaNotaEnfermeria, NotaEnfermeria, TipoRegistro, Estado, UsuarioCreacion,
	FechaCreacion, UsuarioModificacion, FechaModificacion ) 
	VALUES ( @IdOrdenAtencion, @IdEpisodioAtencion, GETDATE(),
	@UsuarioModificacion, 1, 2, @UsuarioCreacion, GETDATE(),
	@UsuarioCreacion, GETDATE())


	INSERT INTO SS_CE_EnfermeraFirmaControl ( IdOrdenAtencion,SecuencialFirma,FechaFirma,
	Enfermera,Observacion,Estado,UsuarioCreacion,FechaCreacion,UsuarioModificacion,
	FechaModificacion) 
	VALUES ( @IdOrdenAtencion, @IdEpisodioAtencion, GETDATE(),	@UsuarioCreacion,@UsuarioModificacion,  2, @UsuarioCreacion, GETDATE(),
	 @UsuarioCreacion, GETDATE())

	INSERT INTO SS_CE_EnfermeriaComponentesFirma ( IdOrdenAtencion,Tabla,SecuencialTabla,SecuencialFirma) 
	VALUES ( @IdOrdenAtencion, 'NOTA DE ENFERMERIA',@IdEpisodioAtencion,@IdEpisodioAtencion)

	end

	select 1
end

if (@Accion='DELETE_DIAG_INT')
begin
	set @IdConsultaExterna=(select IdConsultaExterna from SS_CE_ConsultaExterna where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea)

	DELETE FROM SS_CE_ConsultaExternaDiagnostico WHERE IDConsultaexterna=@IdConsultaExterna

	select isnull(@IdConsultaExterna,0)  

end


if(@Accion='UPDATE_MED_ALTA')
begin
	set @lineaNueva =(select Linea from SS_AD_OrdenAtencionDetalle where SECUENCIALHCE= @SecuenciaHCE and IdOrdenAtencion=@IdOrdenAtencion)
	set @idconsulta =(select top 1 IdConsultaExterna from SS_CE_ConsultaExterna where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea)

	if(@idconsulta >0)
	begin
		update SS_CE_ConsultaExternaReceta set TipoReceta=2 where IdConsultaExterna =@idconsulta and LineaOrdenAtencion=@lineaNueva
	end 
		select 1
	end

if (@Accion='ESPECI_ALTA')
begin
	DELETE FROM SS_CE_CEDetalleIndicacionesGenerales WHERE IdConsultaExterna = @IdConsultaExterna AND TipoIndicacion = 2
	if(@IndicadorEPS is null)
	begin
		INSERT INTO SS_CE_CEDetalleIndicacionesGenerales( IdConsultaExterna, Secuencial, Correlativo, TipoIndicacion, Descripcion, Estado,
		UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion )
		VALUES ( @IdConsultaExterna, 0, 1, 2, @UsuarioModificacion, 2, @UsuarioCreacion, GETDATE(), @UsuarioCreacion, 
			 GETDATE() )
	end
	select 1
end

if (@Accion='CITA_EMER')
begin
	set @idhorario=( SELECT top 1 isnull(SS_CC_Horario.IdHorario,0) as IdHorario FROM SS_CC_Horario WITH(NOLOCK) 
	 WHERE SS_CC_Horario.FechaInicio <= CAST(GETDATE() AS DateTime) AND  
	CAST(GETDATE() AS DateTime) <= SS_CC_Horario.FechaFin AND 
	((DATEPART(dw, CAST(GETDATE() AS DateTime))=1 AND IndicadorDomingo=2) OR 
	(DATEPART(dw, CAST(GETDATE()  AS DateTime))=2 AND IndicadorLunes=2) 
	OR  (DATEPART(dw, CAST(GETDATE()  AS DateTime))=3 AND IndicadorMartes=2) OR 
	(DATEPART(dw, CAST(GETDATE()  AS DateTime))=4 AND IndicadorMiercoles=2) OR 
	(DATEPART(dw, CAST(GETDATE()  AS DateTime))=5 AND IndicadorJueves=2) OR 
	(DATEPART(dw, CAST(GETDATE()  AS DateTime))=6 AND IndicadorViernes=2) OR 
	(DATEPART(dw, CAST(GETDATE()  AS DateTime))=7 AND IndicadorSabado=2) ) 
	AND SS_CC_Horario.Estado = 2 AND SS_CC_Horario.IdEspecialidad = 30 AND
	SS_CC_Horario.TipoRegistroHorario = 1 --AND SS_CC_Horario.IdTurno = 11 
	AND SS_CC_Horario.Medico = @Medico  AND SS_CC_Horario.UnidadReplicacion = @UnidadReplicacion) -- falta definir horario

	set @idcita =(select MAX(SS_CC_Cita.IdCita)+1  from SS_CC_Cita )
	--SELECT @idcita = NEXT VALUE FOR dbo.SecuenciaCita
	set @idconsulta = (SELECT max ( SS_CE_ConsultaExterna.IdConsultaExterna )+1 FROM SS_CE_ConsultaExterna)
	SELECT  @secuencia =max ( SS_CC_CitaControl.Secuencial )+1  FROM SS_CC_CitaControl  WHERE IdDocumento= @idcita

	INSERT INTO SS_CC_Cita ( IdCita , IdHorario , FechaCita , FechaLlegada , DuracionPromedio , DuracionReal , TipoCita , 
	IdPaciente , EstadoDocumento , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , 
	IndicadorRegistroCompartido , IdTipoAtencion , IdGrupoAtencion , IdServicio , IdMedico , FechaCitaFecha , UnidadReplicacion ) VALUES
	( @idcita , @idhorario , GETDATE() , GETDATE() , 2 , 2 , 2 , @IdPaciente , 4 , 2 , @UsuarioCreacion ,GETDATE() , @UsuarioModificacion ,
	 GETDATE() , 1 , 2 , 6 , 16 , @Medico , GETDATE() , @UnidadReplicacion )

	INSERT INTO SS_CC_CitaControl ( IdDocumento , Secuencial , FechaControl , Observacion , IdUsuario , EstadoDocumento ,
	 IndicadorRetorno , Estado , UsuarioCreacion , FechaCreacion  ) VALUES 
	 ( @idcita, @secuencia , GETDATE()  , 'Estado Atendido' , @UsuarioCreacion, 4 , 1 , 2 , @UsuarioCreacion , GETDATE() ) 

	 UPDATE SS_AD_OrdenAtencionDetalle SET IdCita= @idcita,Componente='500203' WHERE IdOrdenAtencion=@IdOrdenAtencion and Linea=1
	 UPDATE SS_CE_ConsultaExterna SET IdCita=@idcita WHERE IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=1

	select 1
end


if (@Accion='EVO_OBJETIVO')
begin
set @IdConsultaExterna= (select IdConsultaExterna from SS_CE_ConsultaExterna where IdOrdenAtencion=@IdOrdenAtencion and LineaOrdenAtencion=@Linea)
set @idcita =(select IdInforme from SS_CE_Informe where IdConsultaExterna= @IdConsultaExterna )


if(@TipoOrdenMedica = 0)
begin

delete from SS_CE_InformeDetalle where IdInforme= @idcita and Secuencial=12
	
	INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla ,
	SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , 
	Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
		VALUES ( @idcita ,  12 , 333 , 58 , 12 , 0 , @UsuarioModificacion ,  null , 2  , 
		@UsuarioCreacion , GETDATE(),@UsuarioCreacion,GETDATE())

end

	else
		begin

			delete from SS_CE_InformeDetalle where IdInforme= @idcita 

			SET @UsuarioModificacion=(SELECT TOP 1 RelatoCronologico FROM SS_IT_SaludAnamnesisIngreso
			WHERE IdOrdenAtencion=@IdOrdenAtencion AND LineaOrdenAtencion=@Linea order by FechaProcesado desc)

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla ,
			SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , 
			Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
				VALUES ( @idcita ,  1 , 656 , 56 , 1 , 0 , @UsuarioModificacion ,  null , 2  , 
				@UsuarioCreacion , GETDATE(),@UsuarioCreacion,GETDATE())

		end

select 1
end

end
GO
