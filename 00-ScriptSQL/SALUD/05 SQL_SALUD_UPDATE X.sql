GO

ALTER VIEW [dbo].[VW_SS_HCE_VisorHistoria] 
AS 

SELECT 
        SS_AD_OrdenAtencion.UnidadReplicacion as UnidadReplicacionEC,        
        TipoAtencion.Nombre as TipoAtencionDescX,
		CitaTipo = (CASE SS_CC_Cita.TipoCita WHEN 1 THEN 'Normal' WHEN 2 THEN 'Adicional' ELSE 'Normal' END),
        CitaFecha = convert(varchar(10) ,SS_CC_Cita.FechaCita,103)  , --SS_CC_Cita.FechaCita,  ARACELY DIJO QUE POR FECHA DE ATENCION 21/08/2019
        CitaHora = convert(varchar(10) ,SS_CC_Cita.FechaCita,108) , --SS_CC_Cita.FechaCita,
        Origen = (CASE WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 11) THEN 'C' ELSE 'P' END),
        NombreEspecialidad = SS_GE_Especialidad.Nombre  ,  --IsNull(SS_GE_Especialidad.Nombre ,   espec.Nombre ) 
        TipoPacienteNombre = TipoPaciente.Nombre,
        SS_AD_OrdenAtencion.CodigoOA,
		IsNull(SS_CC_CITA.Comentario,'') as Cama,
		SS_AD_OrdenAtencion.FechaInicio, 
		TipoOrdenAtencionNombre = TipoOrdenAtencion.Nombre,
        SS_GE_Paciente.CodigoHC,
		Aseg.NombreCompleto  as Aseguradora,
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
				SS_AD_OrdenAtencion.TipoPaciente
			end as Modalidad,
        IndicadorSeguro = ( 				
		SELECT IsNull(CM_CO_TablaMaestroDetalleConcepto.IndicadorConcepto,1)
                FROM CM_CO_TablaMaestroDetalleConcepto WITH(NOLOCK) INNER JOIN CM_CO_TablaMaestroConcepto WITH(NOLOCK) ON CM_CO_TablaMaestroConcepto.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
                        AND CM_CO_TablaMaestroConcepto.IdConcepto = CM_CO_TablaMaestroDetalleConcepto.IdConcepto
                        AND CM_CO_TablaMaestroConcepto.Concepto = 'APLICA_SEGURO'
                WHERE TipoPaciente.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
                        AND TipoPaciente.IdCodigo = CM_CO_TablaMaestroDetalleConcepto.IdCodigo),
            SS_CC_Cita.IdCita,
            SS_AD_OrdenAtencion.FechaFinal as FechaFin,
            SS_GE_Paciente.IdPaciente,
            SS_AD_OrdenAtencion.TipoPaciente,
            SS_AD_OrdenAtencion.TipoAtencion,
            IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_AD_OrdenAtencion.Especialidad),
            SS_AD_OrdenAtencion.IdEmpresaAseguradora,
            SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion,
            SS_AD_OrdenAtencionDetalle.Componente,
            ComponenteNombre = '',--CM_CO_Componente.Nombre,
            SS_AD_OrdenAtencion.Compania,
            SS_AD_OrdenAtencion.Sucursal,	
			--IDMEDICO ASIGNADO
        IdMedico =     IsNull(SS_PR_Procedimiento.Medico,SS_CC_Cita.IdMedico) ,-- Medico.Persona,	
            ------------------------
            0 as IndicadorCirugia,
            0 as IndicadorExamenPrincipal,
            ---------------------------ADD ORIGEN HCE --OBS                  
            SS_AD_OrdenAtencion.UnidadReplicacion AS UnidadReplicacionHCE,
			CASE 
			WHEN  SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 11, 21 ) THEN 
					case 
						WHEN ss_cc_cita.estadodocumento = 2 then 1 --PROGRAMADO
						WHEN ss_cc_cita.estadodocumento = 3 then 0 --PENDIENTE
						WHEN ss_cc_cita.estadodocumento = 8 then 3 -- ATENDIDO		
						WHEN SS_CC_CITA.EstadoDocumento=4 then case when SS_AD_OrdenAtencionDetalle.IndicadorProcedimiento=2 then 3
						else 2
						end	
					Else
					ss_cc_cita.estadodocumento
					end						
			WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (  2, 4, 5, 6, 7, 8, 9, 10, 12, 16, 17, 18, 19, 25, 26, 27, 23, 15, 33, 34, 37, 38, 39, 29, 30, 31, 32, 28 ) THEN 
				case  when IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) = -99 AND SS_CC_Cita.EstadoDocumento IS NULL THEN 0
					when IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) = -99 AND SS_CC_Cita.EstadoDocumento = 3 THEN 0
					when IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) = -99 AND SS_CC_Cita.EstadoDocumento = 2 THEN 1
					when IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) = -99 AND SS_CC_Cita.EstadoDocumento = 8 THEN 0
					when IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) = -99 AND SS_CC_Cita.EstadoDocumento = 4 THEN 0
					when IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) <> -99 AND SS_PR_Procedimiento.EstadoDocumento = 2 THEN 3
					when IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) <> -99 AND SS_PR_Procedimiento.EstadoDocumento = 4 THEN 3							
					when IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) <> -99 AND SS_PR_Procedimiento.EstadoDocumento = 1 THEN 2
					Else 
						-99	
			END   
            Else
                SS_AD_OrdenAtencionDetalle.Estado -- ss_cc_cita.estadodocumento //POR NICK PASCO 02/08/2020
            end  AS EstadoEpiAtencion,  
			
			CASE WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion in (12,11,7)   THEN    
		CASE WHEN isnull(XX1.PR_Secu,0) + isnull(XX2.CE_Secu,0) >0 THEN 3					
				ELSE CASE WHEN SS_CE_ConsultaExternaOrdenMedica.IdConsultaExterna is not null THEN 1 ELSE 2 END 
				END
		ELSE 0
		END AS  EpisodioClinicoHCE,
            CASE WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion in (5,9)   THEN    
		CASE WHEN isnull(XX1.PR_Secu,0) + isnull(XX2.CE_Secu,0) >0 THEN 3					
				ELSE CASE WHEN SS_CE_ConsultaExternaOrdenMedica.IdConsultaExterna is not null THEN 1 ELSE 2 END 
				END
		ELSE 0
		END AS IDEPISODIOAtencionHCE,
            CASE WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion in (17,18,16,8,7,6)   THEN    
			CASE WHEN isnull(XX1.PR_Secu,0) + isnull(XX2.CE_Secu,0) >0 THEN 3					
					ELSE CASE WHEN SS_CE_ConsultaExternaOrdenMedica.IdConsultaExterna is not null THEN 1 ELSE 2 END 
					END
			ELSE 0
			END AS IdPacienteHCE, 
            SS_CC_Cita.EstadoDocumento	 AS SecuenciaHCE,            
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
			'' As Pais,
			(case when SS_CC_Cita.EstadoDocumento = 8 then  CONVERT(varchar(20),3,108) else  PersonaMast.Estado end )
             as EstadoPersona --reemplazar por PersonaMast.Estado
	FROM	SS_AD_OrdenAtencionDetalle				WITH(NOLOCK) 
		INNER JOIN SS_AD_OrdenAtencion				WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdOrdenAtencion = SS_AD_OrdenAtencionDetalle.IdOrdenAtencion 
		INNER JOIN SS_GE_Paciente					WITH(NOLOCK) ON SS_GE_Paciente.IdPaciente = SS_AD_OrdenAtencion.IdPaciente 
		INNER JOIN PersonaMast						WITH(NOLOCK) ON SS_GE_Paciente.IdPaciente = PersonaMast.Persona 
		LEFT JOIN CM_CO_Componente					WITH(NOLOCK) ON ( CM_CO_Componente.CodigoComponente = SS_AD_OrdenAtencionDetalle.Componente ) 
		LEFT JOIN SS_CE_ConsultaExternaOrdenMedica	WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.Idordenatencion = SS_CE_ConsultaExternaOrdenMedica.IdOrdenAtencion
			  AND SS_AD_OrdenAtencionDetalle.Linea = SS_CE_ConsultaExternaOrdenMedica.LineaOrdenAtencion
		LEFT JOIN SS_CE_ConsultaExterna				WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_CE_ConsultaExterna.IdOrdenAtencion   AND SS_AD_OrdenAtencionDetalle.Linea = SS_CE_ConsultaExterna.LineaOrdenAtencion 
		LEFT JOIN (SELECT CE_INFORME.IdConsultaExterna,COUNT(CE_INFORME_DET.Secuencial) CE_Secu  
					FROM 	  SS_CE_Informe AS CE_INFORME  WITH(NOLOCK)		
					LEFT JOIN SS_CE_InformeDetalle AS CE_INFORME_DET WITH(NOLOCK) ON CE_INFORME.IdInforme = CE_INFORME_DET.IdInforme
			 GROUP BY 	CE_INFORME.IdConsultaExterna
				) XX2	ON SS_CE_ConsultaExterna.IdConsultaExterna = XX2.IdConsultaExterna		
		LEFT JOIN SS_GE_ComponentePrestacion		WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.Componente = SS_GE_ComponentePrestacion.Componente 
		LEFT JOIN SS_GE_Turno						WITH(NOLOCK) ON SS_GE_Turno.IdTurno = SS_AD_OrdenAtencionDetalle.IdTurno 
		LEFT JOIN SS_GE_Servicio					WITH(NOLOCK) ON ( SS_GE_Servicio.IdServicio = SS_AD_OrdenAtencionDetalle.IdServicio ) 
		LEFT JOIN SS_GE_GrupoAtencion				WITH(NOLOCK) ON ( SS_GE_GrupoAtencion.IdGrupoAtencion = SS_GE_Servicio.IdGrupoAtencion )
		LEFT JOIN CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK) ON TipoPaciente.IdTablaMaestro = 106  AND TipoPaciente.IdCodigo = SS_AD_OrdenAtencion.TipoPaciente
		LEFT JOIN CM_CO_TablaMaestroDetalle	AS TipoOrdenAtencion WITH (NOLOCK)	ON TipoOrdenAtencion.IdTablaMaestro = 101 AND TipoOrdenAtencion.IdCodigo = SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion
		LEFT JOIN SS_GE_TipoAtencion TipoAtencion	WITH(NOLOCK) ON ( TipoAtencion.IdTipoAtencion = SS_AD_OrdenAtencion.TipoAtencion ) 
		LEFT JOIN GE_Varios as modalid				WITH(NOLOCK) ON ( modalid.CodigoTabla = 'TIPOMODALIDAD' and modalid.Secuencial = SS_AD_OrdenAtencion.Modalidad ) 
		LEFT JOIN GE_Varios as Topico				WITH(NOLOCK) ON ( Topico.CodigoTabla = 'TOPICO' and Topico.Secuencial = SS_AD_OrdenAtencion.IdTopico ) 
		LEFT JOIN SS_PR_Procedimiento				WITH(NOLOCK) ON ( SS_PR_Procedimiento.IdOrdenAtencion = SS_AD_OrdenAtencionDetalle.IdOrdenAtencion AND SS_PR_Procedimiento.LineaOrdenAtencion = SS_AD_OrdenAtencionDetalle.Linea ) 
		LEFT JOIN (	SELECT PR_INFORME.IdProcedimiento,COUNT(PR_INFORME_ASOC.IdProcedimiento) PR_Secu  
					FROM SS_PR_Informe AS PR_INFORME			WITH(NOLOCK)		
					LEFT JOIN SS_PR_ProcedimientoInforme AS PR_INFORME_ASOC WITH(NOLOCK) ON --PR_INFORME.IdInforme = PR_INFORME_ASOC.IdInforme AND
						 PR_INFORME.IdProcedimiento = PR_INFORME_ASOC.IdProcedimiento 
					GROUP BY 	PR_INFORME.IdProcedimiento 
					) XX1	ON SS_PR_Procedimiento.IdProcedimiento = XX1.IdProcedimiento		
		LEFT JOIN PersonaMast as medico				WITH(NOLOCK) ON medico.Persona = SS_PR_Procedimiento.Medico 
		LEFT JOIN SS_CC_Cita						WITH(NOLOCK) ON SS_CC_Cita.IdCita = SS_AD_OrdenAtencionDetalle.IdCita 
		LEFT JOIN SS_CC_Horario						WITH(NOLOCK) ON SS_CC_Horario.IdHorario = SS_CC_Cita.IdHorario 
		LEFT JOIN PersonaMast as medik				WITH(NOLOCK) ON medik.Persona = SS_CC_Horario.Medico 
		LEFT JOIN PersonaMast as Aseg				WITH(NOLOCK) ON Aseg.Persona = SS_AD_OrdenAtencion.IdEmpresaAseguradora 
		LEFT JOIN SS_GE_Consultorio					WITH(NOLOCK) ON ( SS_GE_Consultorio.IdConsultorio = SS_CC_Horario.IdConsultorio ) 
		LEFT JOIN SS_GE_Especialidad				WITH(NOLOCK) ON ( SS_GE_Especialidad.IdEspecialidad = SS_AD_OrdenAtencionDetalle.Especialidad ) 
		LEFT JOIN SS_HO_Hospitalizacion				WITH(NOLOCK) ON SS_HO_Hospitalizacion.IdOrdenAtencion = SS_AD_OrdenAtencion.IdOrdenAtencion AND ss_ad_OrdenAtencion.TipoAtencion = 3
		LEFT JOIN SS_GE_Consultorio CAMA			WITH(NOLOCK) ON CAMA.IdConsultorio = SS_HO_Hospitalizacion.Cama 
	WHERE 
	 SS_AD_OrdenAtencionDetalle.IndicadorDisponible = 2
	 AND SS_CC_Cita.EstadoDocumento IN ( 3, 8, 4 )  

GO

ALTER PROCEDURE [dbo].[SP_HCE_ITListarValidacion]
   (    
    @UnidadReplicacion		VARCHAR(15)=NULL,
    @IdEpisodioAtencion		INT=NULL,
    @IdPaciente				INT=NULL,
    @EpisodioClinico		INT=NULL,
    @UsuarioCreacion		VARCHAR(150)=NULL,
	@IdOrdenAtencion		INT=NULL,
	@Linea					INT=NULL,
	@SecuenciaHCE			VARCHAR(100)=NULL,
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
	  declare @fechaPeticion datetime
	  SET @fechaPeticion  = GETDATE()

		IF 	(Select COUNT(TipoOrdenAtencion) from SS_AD_OrdenAtencionDetalle where IdOrdenAtencion=@IdOrdenAtencion and Linea=@Linea AND TipoOrdenAtencion=1)>0
			BEGIN 
				SELECT @XLINEA = Linea FROM SS_AD_OrdenAtencionDetalle  WITH (NOLOCK) WHERE 
				IdOrdenAtencion = @IDordenatencion and SECUENCIALHCE=@SecuenciaHCE and ISNULL(IndicadorCobrado,1)<>2

				SELECT @SECUENCIALRECETA = Secuencial,	 @IdConsultaExterna = IDConsultaexterna	FROM SS_CE_ConsultaExternaReceta
				WHERE IdOrdenAtencion = @IDordenatencion and LineaOrdenAtencion=@XLINEA

				SELECT @CORRELATIVOINDANT = correlativo		FROM SS_CE_CEDetalleIndicaciones WITH (NOLOCK)
				WHERE IdConsultaExterna=@IdConsultaExterna AND Secuencial=@SECUENCIALRECETA

				INSERT INTO HCE_LOG_BANDEJA(SPID, FechaPeticion, Medico, Operacion,CodigoHCAnterior, PacienteNombre,FechaOperacion, CodigoHC,FechaInicio ,FechaFin ,
							TipoOrdenAtencion,IdEspecialidad ,IdMedico  )
				SELECT @@spid, GETDATE(), @IdOrdenAtencion , 'DELETERECETA', 'CONSULTA','INICIO',@fechaPeticion, @SecuenciaHCE,	@fechaPeticion,GETDATE(), 
					 @XLINEA,@IdConsultaExterna,@CORRELATIVOINDANT

				DELETE FROM SS_CE_CEDetalleIndicaciones		WHERE IdConsultaExterna = @IdConsultaExterna AND  correlativo = @CORRELATIVOINDANT
				DELETE FROM SS_CE_Indicaciones				WHERE IdConsultaExterna = @IdConsultaExterna AND  Secuencial = @CORRELATIVOINDANT
				DELETE FROM SS_CE_ConsultaExternaReceta		WHERE IdOrdenAtencion   = @IDordenatencion   AND  LineaOrdenAtencion   = @XLINEA 
				DELETE FROM SS_AD_OrdenAtencionDetalle		WHERE IdOrdenAtencion	= @IdOrdenAtencion   AND  Linea=@XLINEA

				INSERT INTO HCE_LOG_BANDEJA(SPID, FechaPeticion, Medico, Operacion,CodigoHCAnterior, PacienteNombre,FechaOperacion, CodigoHC,FechaInicio ,FechaFin ,
							TipoOrdenAtencion,IdEspecialidad ,IdMedico  )
				SELECT @@spid, GETDATE(), @IdOrdenAtencion , 'DELETERECETA', 'CONSULTA','FIN',@fechaPeticion, @SecuenciaHCE,	@fechaPeticion,GETDATE(), 
					 @XLINEA,@IdConsultaExterna,@CORRELATIVOINDANT
			END
		ELSE
			BEGIN
				SELECT @XLINEA = Linea FROM SS_AD_OrdenAtencionDetalle  WITH (NOLOCK) WHERE 
				IdOrdenAtencion = @IDordenatencion and SECUENCIALHCE=@SecuenciaHCE and ISNULL(IndicadorCobrado,1)<>2
				
				INSERT INTO HCE_LOG_BANDEJA(SPID, FechaPeticion, Medico, Operacion,CodigoHCAnterior, PacienteNombre, FechaOperacion, CodigoHC,FechaInicio ,FechaFin ,
							TipoOrdenAtencion )
				SELECT @@spid, GETDATE(), @IdOrdenAtencion , 'DELETERECETA', 'PROCEDIM','INICIO',@fechaPeticion, @SecuenciaHCE,	@fechaPeticion,GETDATE(), 
					 @XLINEA

				DELETE SS_PR_ProcedimientoDetalle WHERE IdOrdenAtencion=@IdOrdenAtencion AND LineaOrdenAtencion=@XLINEA 
				DELETE SS_AD_OrdenAtencionDetalle WHERE IdOrdenAtencion=@IdOrdenAtencion AND Linea=@XLINEA AND   ISNULL(IndicadorCobrado,1)<>2

				INSERT INTO HCE_LOG_BANDEJA(SPID, FechaPeticion, Medico, Operacion,CodigoHCAnterior, PacienteNombre,FechaOperacion, CodigoHC,FechaInicio ,FechaFin ,
							TipoOrdenAtencion  )
				SELECT @@spid, GETDATE(), @IdOrdenAtencion , 'DELETERECETA', 'PROCEDIM','FIN',@fechaPeticion, @SecuenciaHCE,	@fechaPeticion,GETDATE(), 
					 @XLINEA
			
			END

	select 1
end
else 
IF @UsuarioCreacion='DELETEINFORME'
	begin
	   
		SELECT @IDPROCEDIMIENTO = IdProcedimiento
		FROM SS_PR_Procedimiento
		WHERE IdOrdenAtencion = @IdOrdenAtencion and LineaOrdenAtencion=@Linea

		DELETE FROM SS_PR_ProcedimientoInforme WHERE IdProcedimiento=@IDPROCEDIMIENTO --and Nombre=@SecuenciaHCE
			
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
							DELETE FROM SS_CE_ConsultaExternaOrdenMedica WHERE IdOrdenAtencion=@IdOrdenAtencion	 and LineaOrdenAtencion=@XLINEA
					DELETE FROM SS_AD_OrdenAtencionDetalle WHERE IdOrdenAtencion=@IdOrdenAtencion and Linea=@XLINEA

					DELETE FROM SS_CE_CEDetalleIndicaciones WHERE IdConsultaExterna = @IdConsultaExterna AND  correlativo = @CORRELATIVOINDANT
					DELETE FROM SS_CE_ConsultaExternaReceta WHERE IdOrdenAtencion   = @IDordenatencion   AND  LineaOrdenAtencion    = @XLINEA 
				END
			ELSE
				BEGIN
					SELECT @XLINEA = Linea FROM SS_AD_OrdenAtencionDetalle  WITH (NOLOCK) WHERE 
					IdOrdenAtencion = @IDordenatencion and SECUENCIALHCE=@SecuenciaHCE and ISNULL(IndicadorCobrado,1)<>2
					DELETE FROM SS_CE_ConsultaExternaOrdenMedica WHERE IdOrdenAtencion=@IdOrdenAtencion	 and LineaOrdenAtencion=@XLINEA
					DELETE SS_AD_OrdenAtencionDetalle WHERE IdOrdenAtencion=@IdOrdenAtencion AND Linea=@XLINEA AND   ISNULL(IndicadorCobrado,1)<>2
					DELETE SS_PR_ProcedimientoDetalle WHERE IdOrdenAtencion=@IdOrdenAtencion AND LineaOrdenAtencion=@XLINEA 
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

				DELETE FROM SS_CE_ConsultaExternaOrdenMedica WHERE IdOrdenAtencion=@IdOrdenAtencion	 and LineaOrdenAtencion=@XLINEA --and Componente='500101'
				DELETE FROM SS_AD_OrdenAtencionDetalle WHERE IdOrdenAtencion=@IdOrdenAtencion and Linea=@XLINEA and IndicadorCoberturado is null
				select 1
			END
		ELSE
			BEGIN
				--SELECT @XLINEA = Linea FROM SS_AD_OrdenAtencionDetalle  WITH (NOLOCK) WHERE 
				--IdOrdenAtencion = @IDordenatencion and SECUENCIALHCE=@SecuenciaHCE and ISNULL(IndicadorCoberturado,0)<>1
				DELETE FROM SS_CE_ConsultaExternaOrdenMedica WHERE IdOrdenAtencion=@IdOrdenAtencion	 and LineaOrdenAtencion=@XLINEA
				DELETE from SS_AD_OrdenAtencionDetalle WHERE IdOrdenAtencion=@IdOrdenAtencion AND Linea=@XLINEA  and IndicadorCoberturado is null				

		select 1
		END
	END
else 
IF @UsuarioCreacion='ADDOMAINWE'
	begin

		SELECT 'clinicacsb.local' NombreDominioRed,'Clinica San Borja' DescripcionLocal,'' UnidadReplicacion,d.nombrecompleto,d.documento,d.tipodocumento
		,B.Usuario		,B.UsuarioPerfil		,B.Nombre		,B.Clave		,B.ExpirarPasswordFlag,B.FechaExpiracion		,B.UltimoLogin		
		,B.NumeroLoginsDisponible		,B.NumeroLoginsUsados		,B.UsuarioRed		,B.SQLLogin		,B.SQLPassword		,B.Estado		,B.UltimoUsuario
		,B.UltimaFechaModif	,D.persona ,     CONVERT(VARCHAR, B.IndicadorValidarUsuarioRed) AS IndicadorValidarUsuarioRed ,'LIMA' UnidadReplicacionDominioRed
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

		SELECT UnidadReplicacion,DescripcionLocal,'' Compania,'LIMA' Sucursal,
		'' AlmacenFarmacia, '' AlmacenEmergencia,'' AlmacenCentroObstetrico,'' AlmacenHospitalaria FROM SY_UnidadReplicacion 
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
	-- VALIDAR IndicadorAtencion en CSB
	select 1 as indicadorCobrado1,SECUENCIALHCE AS indicadorCobrado from SS_AD_OrdenAtencionDetalle  OAD
	 where 
		(@IdPaciente IS NULL OR OAD.IdPaciente=@IdPaciente)
	AND (@IdOrdenAtencion IS NULL OR OAD.IdOrdenAtencion=@IdOrdenAtencion)	
	and OAD.Linea=1

	select 1
	end
else 
if @UsuarioCreacion='INSERTINTER' --  02/03/2020 / luke
	begin
	--if @SecuenciaHCE='INSERT'
	--	begin
	--	update SS_AD_OrdenAtencionDetalle set IndicadorAtencion=1 where 
	--			 (@IdPaciente IS NULL OR IdPaciente=@IdPaciente)
	--			AND (@IdOrdenAtencion IS NULL OR IdOrdenAtencion=@IdOrdenAtencion)	
	--			and Linea=1
	--	end
	-- if @SecuenciaHCE='NUEVO'
	--	begin
	--	update SS_AD_OrdenAtencionDetalle set IndicadorAtencion=NULL where 
	--			 (@IdPaciente IS NULL OR IdPaciente=@IdPaciente)
	--			AND (@IdOrdenAtencion IS NULL OR IdOrdenAtencion=@IdOrdenAtencion)	
	--			and  Linea=1
	--	END
	select 1

	end
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
			INSERT INTO HCE_LOG_BANDEJA(SPID, FechaPeticion, Medico, Operacion, FechaOperacion, 
							CodigoHC, CodigoHCAnterior, TipoOrdenAtencion, PacienteNombre, CodigoOA , 
							FechaInicio ,FechaFin , IdPaciente , Sucursal , IdEspecialidad , 
							IdMedico )

			SELECT @@spid, @FechaCreacion, 0, '001-TRIAJE PASO1', getdate(), 
			'TRIAJE', '', '', @UsuarioCreacion, '',
			GETDATE(),GETDATE(), @IdPaciente, 'CSB', 0, @IDordenatencion


	SELECT @CONTADORPAC=COUNT(SS_GE_Paciente.IdPaciente),@CodigoHC=MAX(SS_GE_Paciente.CodigoHC) FROM SS_GE_Paciente WHERE IdPaciente= @IdPaciente


				INSERT INTO HCE_LOG_BANDEJA(SPID, FechaPeticion, Medico, Operacion, FechaOperacion, 
							CodigoHC, CodigoHCAnterior, TipoOrdenAtencion, PacienteNombre, CodigoOA , 
							FechaInicio ,FechaFin , IdPaciente , Sucursal , IdEspecialidad , 
							IdMedico,OperacionTiempoMS )

			SELECT @@spid, @FechaCreacion, 0, '002-TRIAJE PASO2', getdate(), 
			'TRIAJE', '', '', @UsuarioCreacion, @CodigoHC,
			GETDATE(),GETDATE(), @IdPaciente, 'CSB', @CONTADORPAC, @IDordenatencion, DATEDIFF(ms, @FechaCreacion, getdate())


	SET @INDIHC = 0
	IF @CONTADORPAC=0
		BEGIN
			SELECT @CodigoHC = GE_Correlativos.CorrelativoNumero+1
			FROM GE_Correlativos 
			WHERE GE_Correlativos.TipoComprobante = 'HC' 
			--AND GE_Correlativos.Sucursal = @UnidadReplicacion
			AND GE_Correlativos.Compania = '00000000'
			AND GE_Correlativos.Sucursal = @UnidadReplicacion

			INSERT INTO HCE_LOG_BANDEJA(SPID, FechaPeticion, Medico, Operacion, FechaOperacion, 
			CodigoHC, CodigoHCAnterior, TipoOrdenAtencion, PacienteNombre, CodigoOA , 
			FechaInicio ,FechaFin , IdPaciente , Sucursal , IdEspecialidad , 
			IdMedico,OperacionTiempoMS )

			SELECT @@spid, @FechaCreacion, 0, '003-TRIAJE PASO3', getdate(), 
			'TRIAJE', '', '', @UsuarioCreacion, @CodigoHC,
			GETDATE(),GETDATE(), @IdPaciente, 'CSB', @CONTADORPAC, @IDordenatencion, DATEDIFF(ms, @FechaCreacion, getdate())


			UPDATE  GE_Correlativos WITH(ROWLOCK) SET GE_Correlativos.CorrelativoNumero = @CodigoHC, GE_Correlativos.UsuarioModificacion = 'HCE', 
			GE_Correlativos.FechaModificacion = GetDate() 
			FROM GE_Correlativos 
			WHERE GE_Correlativos.TipoComprobante = 'HC' 
			--AND GE_Correlativos.UnidadReplicacion = @UnidadReplicacion
			AND GE_Correlativos.Compania ='00000000'
			AND GE_Correlativos.Sucursal = @UnidadReplicacion

			INSERT INTO HCE_LOG_BANDEJA(SPID, FechaPeticion, Medico, Operacion, FechaOperacion, 
			CodigoHC, CodigoHCAnterior, TipoOrdenAtencion, PacienteNombre, CodigoOA , 
			FechaInicio ,FechaFin , IdPaciente , Sucursal , IdEspecialidad , 
			IdMedico,OperacionTiempoMS )

			SELECT @@spid, @FechaCreacion, 0, '004-TRIAJE PASO4', getdate(), 
			'TRIAJE', '', '', @UsuarioCreacion, @CodigoHC,
			GETDATE(),GETDATE(), @IdPaciente, 'CSB', @CONTADORPAC, @IDordenatencion, DATEDIFF(ms, @FechaCreacion, getdate())


			insert into SS_GE_Paciente( IdPaciente,CodigoHC , FechaIngreso, IndicadorNuevo,Estado,FechaCreacion,IDPACIENTE_OK,UsuarioCreacion)            
			values  (  @IdPaciente,@CodigoHC,GETDATE(),1,2,GETDATE(),@IdPaciente,'HCE'	)   

			INSERT INTO HCE_LOG_BANDEJA(SPID, FechaPeticion, Medico, Operacion, FechaOperacion, 
			CodigoHC, CodigoHCAnterior, TipoOrdenAtencion, PacienteNombre, CodigoOA , 
			FechaInicio ,FechaFin , IdPaciente , Sucursal , IdEspecialidad , 
			IdMedico ,OperacionTiempoMS )

			SELECT @@spid, @FechaCreacion, 0, '005-TRIAJE PASO5', getdate(), 
			'TRIAJE', '', '', @UsuarioCreacion, @CodigoHC,
			GETDATE(),GETDATE(), @IdPaciente, 'CSB', @CONTADORPAC, @IDordenatencion, DATEDIFF(ms, @FechaCreacion, getdate())

			SET @INDIHC = 1

		END
	ELSE
		BEGIN
			IF	@CodigoHC = '' OR @CodigoHC IS NULL
			BEGIN
				SELECT @CodigoHC = GE_Correlativos.CorrelativoNumero+1
				FROM GE_Correlativos 
				WHERE GE_Correlativos.TipoComprobante = 'HC' 
				--AND GE_Correlativos.UnidadReplicacion = @UnidadReplicacion
				AND GE_Correlativos.Compania = '00000000'
				AND GE_Correlativos.Sucursal = @UnidadReplicacion

				INSERT INTO HCE_LOG_BANDEJA(SPID, FechaPeticion, Medico, Operacion, FechaOperacion, 
				CodigoHC, CodigoHCAnterior, TipoOrdenAtencion, PacienteNombre, CodigoOA , 
				FechaInicio ,FechaFin , IdPaciente , Sucursal , IdEspecialidad , 
				IdMedico,OperacionTiempoMS )

				SELECT @@spid, @FechaCreacion, 0, '006-TRIAJE PASO6', getdate(), 
				'TRIAJE', '', '', @UsuarioCreacion, @CodigoHC,
				GETDATE(),GETDATE(), @IdPaciente, 'CSB', @CONTADORPAC, @IDordenatencion, DATEDIFF(ms, @FechaCreacion, getdate())


				UPDATE  GE_Correlativos WITH(ROWLOCK) SET GE_Correlativos.CorrelativoNumero = @CodigoHC, GE_Correlativos.UsuarioModificacion = 'HCE', 
				GE_Correlativos.FechaModificacion = GetDate() 
				FROM GE_Correlativos 
				WHERE GE_Correlativos.TipoComprobante = 'HC' 
				--AND GE_Correlativos.UnidadReplicacion = @UnidadReplicacion
				AND GE_Correlativos.Compania ='00000000'
				AND GE_Correlativos.Sucursal = @UnidadReplicacion

				INSERT INTO HCE_LOG_BANDEJA(SPID, FechaPeticion, Medico, Operacion, FechaOperacion, 
				CodigoHC, CodigoHCAnterior, TipoOrdenAtencion, PacienteNombre, CodigoOA , 
				FechaInicio ,FechaFin , IdPaciente , Sucursal , IdEspecialidad , 
				IdMedico,OperacionTiempoMS )

				SELECT @@spid, @FechaCreacion, 0, '007-TRIAJE PASO7', getdate(), 
				'TRIAJE', '', '', @UsuarioCreacion, @CodigoHC,
				GETDATE(),GETDATE(), @IdPaciente, 'CSB', @CONTADORPAC, @IDordenatencion, DATEDIFF(ms, @FechaCreacion, getdate())

				UPDATE SS_GE_Paciente WITH(ROWLOCK) SET SS_GE_Paciente.CodigoHC = @CodigoHC,UsuarioModificacion = 'HCE'
				FROM SS_GE_Paciente 
				WHERE  SS_GE_Paciente.IdPaciente = @IdPaciente

				INSERT INTO HCE_LOG_BANDEJA(SPID, FechaPeticion, Medico, Operacion, FechaOperacion, 
				CodigoHC, CodigoHCAnterior, TipoOrdenAtencion, PacienteNombre, CodigoOA , 
				FechaInicio ,FechaFin , IdPaciente , Sucursal , IdEspecialidad , 
				IdMedico,OperacionTiempoMS )
				
				SELECT @@spid, @FechaCreacion, 0, '008-TRIAJE PASO8', getdate(), 
				'TRIAJE', '', '', @UsuarioCreacion, @CodigoHC,
				GETDATE(),GETDATE(), @IdPaciente, 'CSB', @CONTADORPAC, @IDordenatencion, DATEDIFF(ms, @FechaCreacion, getdate())
				SET @INDIHC = 1
			END 
		END

		INSERT INTO HCE_LOG_BANDEJA(SPID, FechaPeticion, Medico, Operacion, FechaOperacion, 
		CodigoHC, CodigoHCAnterior, TipoOrdenAtencion, PacienteNombre, CodigoOA , 
		FechaInicio ,FechaFin , IdPaciente , Sucursal , IdEspecialidad , 
		IdMedico,OperacionTiempoMS )

		SELECT @@spid, @FechaCreacion, 0, '009-TRIAJE PASO9 FIN', getdate(), 
		'TRIAJE', '', '', @UsuarioCreacion, @CodigoHC,
		GETDATE(),GETDATE(), @IdPaciente, 'CSB', @CONTADORPAC, @IDordenatencion, DATEDIFF(ms, @FechaCreacion, getdate())



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
       ss_ce_consultaexterna.tipoconsulta,    ss_ad_ordenatenciondetalle.linea,    ss_ad_ordenatencion.Sucursal unidadreplicacion,
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
		   NULL,  NULL,  ss_ho_hospitalizacion.lineaordenatencion,     ss_ad_ordenatencion.Sucursal unidadreplicacion,
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
					ss_ad_ordenatencion.Sucursal unidadreplicacion ,ss_ho_hospitalizacion.idpaciente
	FROM   ss_ho_hospitalizacionvisitas 
		   INNER JOIN ss_ho_hospitalizacion             ON ss_ho_hospitalizacion.idhospitalizacion =  ss_ho_hospitalizacionvisitas.idhospitalizacion 
		   LEFT JOIN ss_ho_hospitalizacionordenmedica   ON ss_ho_hospitalizacionordenmedica.idhospitalizacion =  ss_ho_hospitalizacionvisitas.idhospitalizacion 
							   					 AND ss_ho_hospitalizacionordenmedica.idvisitas =  ss_ho_hospitalizacionvisitas.idvisitas 
		   LEFT JOIN ss_ad_ordenatencion                ON ss_ad_ordenatencion.idordenatencion =  ss_ho_hospitalizacionordenmedica.idordenatencion 
		   LEFT JOIN personamast                        ON ss_ho_hospitalizacionvisitas.idmedico = personamast.persona 
		   LEFT JOIN empleadomast                       ON personamast.persona = empleadomast.empleado 
	WHERE  ss_ad_ordenatencion.idpaciente =	9523209	-- @IdPaciente

end

else
IF @UsuarioCreacion='PERFILEXA'
	begin

	SELECT 1 as Linea,SS_GE_ComponentePerfil.ComponentePerfil as SecuenciaHCE, SS_GE_ComponentePerfil.Secuencial as IndicadorProcedimiento,
	SS_GE_ComponentePerfil.Estado as IndicadorCobrado1,1 as IdOrdenAtencion, (SELECT CONCAT( CM_CO_Componente.Nombre, '|', '[', SS_GE_ComponentePerfil.ComponentePerfil,']' ) )   as UsuarioCreacion
	--CM_CO_Componente.Nombre, SS_GE_ComponentePerfil.Estado
	FROM SS_GE_ComponentePerfil 
	LEFT JOIN CM_CO_Componente ON CM_CO_Componente.CodigoComponente = SS_GE_ComponentePerfil.ComponentePerfil
	WHERE SS_GE_ComponentePerfil.Componente =  @SecuenciaHCE AND SS_GE_ComponentePerfil.Estado = 2 


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
	where SS_AD_OrdenAtencion.IdOrdenAtencion=@IdOrdenAtencion --and SS_AD_OrdenAtencion.Sucursal=@UnidadReplicacion

end
else  	
if  @UsuarioCreacion='P_ACTVALCPM'
	begin

	
		SELECT 0 indvalidarcantidadcmp, 0 cantidadcmp 
			FROM SY_UNIDADREPLICACION
		WHERE UnidadReplicacion  = @UnidadReplicacion 


		SELECT YEAR(FechaInicio) Anyo, MONTH(FechaInicio) Mes ,IdPaciente,Especialidad,COUNT(IdPaciente)Cantidad FROM SS_AD_OrdenAtencion
		WHERE  TipoAtencion=1 AND TipoPaciente=6  
		AND YEAR(FechaInicio) = YEAR(GETDATE()) AND   MONTH(FechaInicio) = MONTH(GETDATE())
		AND Sucursal = @UnidadReplicacion
		AND IdPaciente = @IdPaciente --9718709
		AND Especialidad = @IdEpisodioAtencion --9718709
		GROUP BY IdPaciente ,YEAR(FechaInicio) , MONTH(FechaInicio) ,Especialidad
		HAVING COUNT(IdPaciente)>=@cantidadcmp --2
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
	--LEFT JOIN SS_IT_SaludConsultaExternaIngreso CEI WITH(NOLOCK) ON CEI.IdOrdenAtencion=OA.IdOrdenAtencion AND CEI.UnidadReplicacion=OA.UnidadReplicacion
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
	--LEFT JOIN SS_IT_SaludConsultaExternaIngreso CEI WITH(NOLOCK) ON CEI.IdOrdenAtencion=OA.IdOrdenAtencion AND CEI.UnidadReplicacion=OA.UnidadReplicacion
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
	--LEFT JOIN SS_IT_SaludConsultaExternaIngreso CEI WITH(NOLOCK) ON CEI.IdOrdenAtencion=OA.IdOrdenAtencion AND CEI.UnidadReplicacion=OA.UnidadReplicacion
	WHERE
		--     OA.CodigoOA='0002526071'
		--AND CEI.IdEpisodioAtencion=1 
		--AND CEI.EpisodioClinico=1
		--AND (@IdEpisodioAtencion IS NULL OR CEI.IdEpisodioAtencion=@IdEpisodioAtencion)
		--AND (@EpisodioClinico IS NULL OR OAD.EpisodioClinico=@EpisodioClinico)
			
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
		--     OA.CodigoOA='0002526071'
		--AND CEI.IdEpisodioAtencion=1 
		--AND CEI.EpisodioClinico=1
		--AND (@IdEpisodioAtencion IS NULL OR CEI.IdEpisodioAtencion=@IdEpisodioAtencion)
		--AND (@EpisodioClinico IS NULL OR OAD.EpisodioClinico=@EpisodioClinico)
			SECUENCIALHCE IS NOT NULL
		AND	(@IdPaciente IS NULL OR OAD.IdPaciente=@IdPaciente)
		AND (OAD.IdOrdenAtencion=@IdOrdenAtencion)	

	--	AND (@UnidadReplicacion IS NULL OR OAD.Sucursal=@UnidadReplicacion)  // MODIFICADO POR GUILLERMO
	end


end

GO

ALTER PROCEDURE  [dbo].[SS_HC_ATENCIONES_SOA]
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

ALTER PROCEDURE [dbo].[SP_HCE_InteroperabilidadSalidaV0002]

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

FROM LEPSA_WEB_ERPSALUD_CSB.DBO.SS_HC_EpisodioAtencion 

--LEFT JOIN SS_AD_OrdenAtencion ON SS_HC_EpisodioAtencion.IdOrdenAtencion = SS_AD_OrdenAtencion.IdOrdenAtencion

WHERE

       UnidadReplicacion = @UnidadReplicacion AND

       EpisodioAtencion = @IdEpisodioAtencion AND

       IdPaciente = @IdPaciente AND

       EpisodioClinico  = @EpisodioClinico

END

 



