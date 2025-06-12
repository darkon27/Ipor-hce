
GO


--CREATE OR ALTER PROCEDURE [dbo].[SP_SS_IT_SALUDConsultaExterna]
--/*  
--'**********************************************************************************      
--'* Permite visualizar los errores de ejecucion del SP de Consulta Externa  
--'* Input :  @    
--'* Output : <vacio>      
--'* Creado por : Mitsuo
--'* Fec Creación : 20/11/2017      
--'* Fec Actualización : 27/02/2018 Responsable : Mitsuo     
--'* Motivo : Visualizar el Log de Error.      
--'**********************************************************************************   
--*/  
--(
--   @IDordenatencion int,
--   @LineaOrdenAtencionConsulta int,
--   @UnidadReplicacion varchar(15), 
--   @IDPaciente int,
--   @Secuencia int,
--   @Usuario varchar(25),
--   @Fechacreacion datetime,
--   @TipoOrdenAtencion int
--)
--AS
--BEGIN
--SET XACT_ABORT ON
----BEGIN DISTRIBUTED TRANSACTION
----Begin Transaction;
--	DECLARE @IdMedico INT, @Especialidad INT, @IdConsultorio INT, @IdCita INT, @IdCitaEstadoDocumento INT, 
--			@IdMaxConsultaExterna INT, @SecuencialMaxCita INT, @ESTADODocumentoOA INT, @SecuencialMaxOA INT, @ll_retorno INT, @intentar INT,
--			@nrointentos INT, @EXISTE INT, @IDPROCEDIMIENTO INT,@MAXPROCCONTROL INT, @oacambio INT, @p_devhce  INT,@MAXCONEXTCONTROL INT
--	DECLARE @OBS VARCHAR(30),@OBSATE VARCHAR(30)
		 
----iNICIAN CAMBIOS DE SP
--   IF @TipoOrdenAtencion=1
--   BEGIN

--	SELECT @EXISTE = IdConsultaExterna FROM SS_CE_ConsultaExterna WITH(NOLOCK)
--	WHERE IdOrdenAtencion = @IDordenatencion AND LineaOrdenAtencion = @LineaOrdenAtencionConsulta 
--	AND Estado = 2 and @TipoOrdenAtencion = 1
	
--	PRINT 'VALIDA  '


--	SET @ll_retorno = 0 
--	SET @OBS ='Estado En Atencion HCE'
--	SET @OBSATE ='Nueva Consulta Externa HCE'


--	IF @EXISTE > 0
--	BEGIN
--		SET @ll_retorno = -1
--		SET @OBS ='Modificacion En Atencion HCE'
--		SET @OBSATE ='Modificacion Consulta Externa HCE'
--		PRINT 'EXISTE'
--	END

--	--IF @ll_retorno = 0 
--	--BEGIN
--		SELECT  @IdMedico = SS_CC_Cita.IdMedico, 
--				@Especialidad = SS_CC_Horario.IdEspecialidad , 
--				@IdConsultorio = SS_CC_Horario.IdConsultorio , 
--				@IdCita = SS_CC_Cita.IdCita , 
--				@IdCitaEstadoDocumento = SS_CC_Cita.EstadoDocumento 
--		FROM SS_CC_Horario WITH(NOLOCK)
--		INNER JOIN SS_CC_Cita ON SS_CC_Cita.IdHorario = SS_CC_Horario.IdHorario
--		INNER JOIN SS_AD_OrdenAtencionDetalle ON SS_AD_OrdenAtencionDetalle.IdCita =SS_CC_Cita.IdCita
--		WHERE SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = @IDordenatencion 
--			AND SS_AD_OrdenAtencionDetalle.Linea = @LineaOrdenAtencionConsulta 

--		PRINT 'IdMedico'
--	--END

--	--IF @ll_retorno = 0 
--	--BEGIN
--		SET @nrointentos = 0
--		SET @intentar = 1

--		WHILE @nrointentos < 5 and @intentar = 1
--		BEGIN

--			SET @nrointentos = @nrointentos + 1
--			SET @intentar = 0

--			IF @ll_retorno = 0 
--				BEGIN

--				SELECT @IDMAXConsultaExterna = ISNULL(MAX(ISNULL(IdConsultaExterna,0)),0) +1
--				FROM SS_CE_ConsultaExterna

  
--				END
--			ELSE
--				BEGIN
--				SET @IDMAXConsultaExterna =	@EXISTE					
				
--				UPDATE SS_CE_ConsultaExterna SET EstadoDocumento=1, EstadoDocumentoAnterior=2 WHERE IdConsultaExterna= @IDMAXConsultaExterna;
				
--				END

--			IF @ll_retorno = 0 
--				BEGIN
--					INSERT INTO SS_CE_ConsultaExterna 
--					(	IdConsultaExterna , IdCita , IdOrdenAtencion , LineaOrdenAtencion , Consultorio , Medico , Especialidad , 
--						FechaConsulta , IndicadorSeguimiento , IdConsultaExternaInicial , EstadoDocumento , Estado , UsuarioCreacion , FechaCreacion , IndicadorFirmaAlta , 
--						TipoConsulta ) 
--					Values 
--					(	@IDMAXConsultaExterna , @IDcita , @IDordenatencion , @LineaOrdenAtencionConsulta , @IDconsultorio , @IdMedico , @Especialidad , @FechaCreacion , 1 , @IDMAXConsultaExterna , 
--						1 , 2 , @Usuario , @FechaCreacion , 2 , 1 ) 
				
--					PRINT 'SS_CE_ConsultaExterna'
--				END

--		END
--	--END 

--	--IF @ll_retorno = 0 
--	--BEGIN
--		IF @intentar = 0	
--		BEGIN
--			UPDATE SS_AD_OrdenAtencion SET 
--				IdConsultaExternaPrincipal = @IDMAXConsultaExterna 
--			Where IdOrdenAtencion = @IDOrdenATENCION AND 
--			IdConsultaExternaPrincipal IS NULL 

--			UPDATE SS_CC_Cita SET
--				EstadoDocumentoAnterior =3 , EstadoDocumento =4 
--			WHERE SS_CC_Cita.IdCita = @IDcita

--			SELECT @SecuencialMaxCita = ISNULL(MAX(ISNULL(Secuencial,0)),0) +1
--			FROM SS_CC_CitaControl 
--			WHERE IdDocumento = @IdCita 
		
--			INSERT INTO SS_CC_CitaControl 
--			(	IdDocumento , Secuencial , FechaControl , Observacion , IdUsuario , EstadoDocumento , EstadoDocumentoAnterior , 
--			IndicadorRetorno , Estado , UsuarioCreacion , FechaCreacion ) 
--			VALUES 
--			(	@IdCita, @SecuencialMaxCita, @FechaCreacion, @OBS, @Usuario, 4, 3, 1, 2, @Usuario, @FechaCreacion )

--			SELECT @ESTADODocumentoOA = EstadoDocumento
--			FROM SS_AD_OrdenAtencion WITH(NOLOCK)
--			WHERE IdOrdenAtencion = @IDORDENATENCION

--			UPDATE SS_AD_OrdenAtencion SET
--				EstadoDocumentoAnterior = @EstadoDocumentoOA, 
--				EstadoDocumento = 2 
--			WHERE IdOrdenAtencion = @IdOrdenAtencion 

--			SELECT @SecuencialMaxOA = ISNULL(MAX(ISNULL(Secuencial,0)),0) +1
--			FROM SS_AD_OrdenAtencionControl 
--			WHERE IdDocumento = @IdOrdenAtencion 

--			INSERT INTO SS_AD_OrdenAtencionControl 
--			(	IdDocumento , Secuencial , FechaControl , Observacion , IdUsuario , EstadoDocumento , EstadoDocumentoAnterior , 
--			IndicadorRetorno , Estado , UsuarioCreacion , FechaCreacion ) 
--			VALUES 
--			(	@IDORDENATENCION , @SecuencialMaxOA , @FECHACREACION , 'Estado en Proceso HCE' , @Usuario , 2 , @EstadoDocumentoOA , 1 , 2 , @Usuario , @FechaCreacion ) 


			
--			SELECT @MAXCONEXTCONTROL = ISNULL(MAX(ISNULL(Secuencial,0)),0) +1
--			FROM SS_CE_ConsultaExternaControl 
--			WHERE IdDocumento = @IDMAXConsultaExterna 

--			INSERT INTO SS_CE_ConsultaExternaControl 
--			(	IdDocumento , Secuencial , FechaControl , Observacion , IdUsuario , EstadoDocumento , IndicadorRetorno , Estado , UsuarioCreacion , FechaCreacion ) 
--			VALUES
--			(	@IDMAXConsultaExterna , @MAXCONEXTCONTROL , @FechaCreacion , @OBSATE , @Usuario , 1 , 1 , 2 , @Usuario , @FechaCreacion ) 

--			UPDATE SS_AD_OrdenAtencionDetalle SET
--				IndicadorOcultarConsulta = 1 
--			WHERE IdOrdenAtencion = @IdOrdenAtencion AND Linea =@LineaOrdenAtencionConsulta 

--			UPDATE SS_AD_OrdenAtencion SET 
--				IndicadorOcultarOA =1 
--			WHERE IdOrdenAtencion = @IDORDENATENCION


--			SELECT @p_devhce = IsNull( ValorNumerico, 1)
--			FROM SG_Opcion
--			WHERE CodigoOpcion = 'P_HC_DEVHHMM'
--			AND TipoOpcion = 'P'

--			IF @p_devhce = 2 
--			BEGIN 
--				SELECT @oacambio = COUNT ( 1 ) 
--				FROM SS_AD_OrdenAtencionCambio 
--				WITH ( NOLOCK ) 
--				WHERE --SS_AD_OrdenAtencionCambio.Periodo <= 201905 AND 
--				SS_AD_OrdenAtencionCambio.TipoTabla ='O' AND SS_AD_OrdenAtencionCambio.IdTabla =@IDORDENATENCION 
--					AND SS_AD_OrdenAtencionCambio.IndicadorProcesado =1 
		
--				IF @oacambio = 0 OR @oacambio IS NULL
--				begin
--					INSERT INTO SS_AD_OrdenAtencionCambio ( Periodo , TipoTabla , IdTabla , FechaCambio , IndicadorProcesado ) 
--					VALUES ( year(getdate()) * 100 + MONTH(getdate()) , 'O' , @IDORDENATENCION , getdate() , 1 ) 
--				end 
--			END    

--		END--FIN DE INTENTAR = 0

--	--END 
--   END --AÑADIDO PARA EL IF SUPERIOR DE CONSULTA
--  ELSE --@TipoOrdenAtencion<>1 AND @TipoOrdenAtencion IS NOT NULL
--  BEGIN 
  
--	SELECT @EXISTE = COUNT( IdProcedimiento )FROM SS_PR_Procedimiento WITH(NOLOCK) WHERE SS_PR_Procedimiento.IdOrdenAtencion = @IDordenatencion
--		AND SS_PR_Procedimiento.LineaOrdenAtencion = @LineaOrdenAtencionConsulta AND Estado = 2 
--		--SELECT count ( SS_PR_Procedimiento.IdProcedimiento ) FROM SS_PR_Procedimiento WHERE SS_PR_Procedimiento.IdOrdenAtencion =4168942  AND SS_PR_Procedimiento.LineaOrdenAtencion =1 
--	IF @EXISTE =0
--	BEGIN 
 
--		SELECT @IdMedico = SS_CC_Cita.IdMedico, 
--				@Especialidad = SS_CC_Horario.IdEspecialidad , 
--				@IdConsultorio = SS_CC_Horario.IdConsultorio , 
--				@IdCita = SS_CC_Cita.IdCita , 
--				@IdCitaEstadoDocumento = SS_CC_Cita.EstadoDocumento 
--		FROM SS_CC_Horario WITH(NOLOCK)
--		INNER JOIN SS_CC_Cita WITH(NOLOCK) ON SS_CC_Cita.IdHorario = SS_CC_Horario.IdHorario
--		INNER JOIN SS_AD_OrdenAtencionDetalle WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdCita =SS_CC_Cita.IdCita
--		WHERE SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = @IDordenatencion AND SS_AD_OrdenAtencionDetalle.Linea = @LineaOrdenAtencionConsulta 
	   
--		SELECT @IDPROCEDIMIENTO = ISNULL(MAX(ISNULL(IdProcedimiento,0)),0) +1
--		FROM SS_PR_Procedimiento 
	
--		INSERT INTO SS_PR_Procedimiento ( IdProcedimiento , IdMaestroProcedimiento , FechaProcedimiento , IdOrdenAtencion , LineaOrdenAtencion , IdCita ,
--		Especialidad , medico , EstadoDocumento , Estado , UsuarioCreacion , FechaCreacion , IndicadorAutorizacion , RutaFormatoAutorizacion , 
--		IndicadorPreparacion , IndicadorRM , IndAdicionarComponente , Consultorio , IndicadorAtencion )
--		VALUES ( @IDPROCEDIMIENTO , 0 , @Fechacreacion , @IDordenatencion , @LineaOrdenAtencionConsulta ,(case when @IdCita is null then (select max(IdCita)+1 from SS_CC_Cita) else @IdCita end )  , @Especialidad , @IdMedico , 1 , 2 ,
--		@Usuario , @Fechacreacion, 0 , '' , 0 , 1 , 0 , @IdConsultorio, 1 ) 


--		SELECT @MAXPROCCONTROL = ISNULL(MAX(ISNULL(Secuencial,0)),0) +1
--		FROM SS_PR_ProcedimientoControl WITH(NOLOCK) 
--		WHERE IdDocumento = @IDPROCEDIMIENTO 

--		INSERT INTO SS_PR_ProcedimientoControl
--		( IdDocumento , Secuencial , FechaControl , Observacion , IdUsuario , EstadoDocumento , 
--		EstadoDocumentoAnterior , IndicadorRetorno , Periodo , Estado , UsuarioCreacion , FechaCreacion , 
--		UsuarioModificacion , FechaModificacion ) VALUES ( @IDPROCEDIMIENTO , @MAXPROCCONTROL , @Fechacreacion, 
--		'Nuevo Procedimiento ITHCE' , @Usuario , 1 , NULL , 1 , 1 , 2 , @Usuario , @Fechacreacion , 
--		@Usuario , @Fechacreacion ) 
				
--		update SS_AD_OrdenAtencionDetalle SET IndicadorProcedimiento =2 
--		WHERE ( SS_AD_OrdenAtencionDetalle.IdOrdenAtencion =@IDordenatencion )
--		AND ( SS_AD_OrdenAtencionDetalle.Linea =@LineaOrdenAtencionConsulta ) 

--	/*AÑADIDO PARA MODIFICAR CUANDO NO TIENE CITA 16OCTUBRE2019*/
--	BEGIN
--		if  isnull(@IdCita,0)=0
--				begin
--				select @IdCita=0
--				end 
--				else 	
--				begin
--			/*AÑADIDO PARA MODIFICAR CUANDO NO TIENE CITA16OCTUBRE2019*/
--				UPDATE SS_CC_Cita SET EstadoDocumentoAnterior =@IdCitaEstadoDocumento , EstadoDocumento =4 
--				WHERE SS_CC_Cita.IdCita =@IdCita
			
			
--				SELECT @SecuencialMaxCita = ISNULL(MAX(ISNULL(Secuencial,0)),0) +1
--				FROM SS_CC_CitaControl 
--				WHERE IdDocumento = @IdCita 
		

--				INSERT INTO SS_CC_CitaControl 
--				(	IdDocumento , Secuencial , FechaControl , Observacion , IdUsuario , EstadoDocumento , 
--				EstadoDocumentoAnterior , IndicadorRetorno , Estado , UsuarioCreacion , FechaCreacion ,UsuarioModificacion,FechaModificacion) 
--				VALUES 
--				(	@IdCita, @SecuencialMaxCita, @FechaCreacion, 'Estado En Atencion HCE', @Usuario, 4, 3, 1, 2, @Usuario, @FechaCreacion, @Usuario, @FechaCreacion )
--				end --16OCTUBRE2019
--				END --16OCTUBRE2019
			

--		SELECT @p_devhce = IsNull( ValorNumerico, 1)
--		FROM SG_Opcion
--		WHERE CodigoOpcion = 'P_HC_DEVHHMM'
--		AND TipoOpcion = 'P'

--		IF @p_devhce = 2 
--		BEGIN 
--			SELECT @oacambio = COUNT ( 1 ) 
--			FROM SS_AD_OrdenAtencionCambio 
--			WITH ( NOLOCK ) 
--			WHERE --SS_AD_OrdenAtencionCambio.Periodo <= 201905 AND 
--			SS_AD_OrdenAtencionCambio.TipoTabla ='O' AND SS_AD_OrdenAtencionCambio.IdTabla =@IDORDENATENCION 
--			AND SS_AD_OrdenAtencionCambio.IndicadorProcesado =1 
		
--			IF @oacambio = 0 OR @oacambio IS NULL
--			begin

--				INSERT INTO SS_AD_OrdenAtencionCambio ( Periodo , TipoTabla , IdTabla , FechaCambio , IndicadorProcesado ) 
--				VALUES (year(getdate()) * 100 + MONTH(getdate()) , 'O' , @IDORDENATENCION , getdate() , 1 ) 
--			end 
--		END 
--	END
--   END

	 
--   If @@TRANCOUNT > 0    

--   SET XACT_ABORT OFF
-- END 
 
--GO

CREATE OR ALTER PROCEDURE [dbo].[SP_SS_IT_SALUDAtendidoConsultaExterna]
(
    @IDordenatencion             INT,
    @IDPaciente                  INT,
    @Usuario                     VARCHAR(25),
    @FechaCreacion               DATETIME,
    @UnidadReplicacion           VARCHAR(15),
    @LineaOrdenAtencionConsulta  INT,
    @TipoOrdenAtencion           INT,
    @al_retorno					INT OUTPUT,
    @as_mensaje					VARCHAR(500) OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE 
        @IdConsultaExterna      INT,
        @ConsultaExternaMax     INT,
        @EstadoConsultaExterna  INT,
        @IdCita                 INT,
        @EstadoCita             INT,
        @SecuencialMaxCita      INT,
        @SecuenciaMaxProc       INT,
        @IDPROCEDIMIENTO        INT;

    BEGIN TRY
        -- Asignar valores iniciales
        SET @al_retorno = 0;  -- Valor de éxito por defecto
        SET @as_mensaje = 'Operación realizada con éxito';

        IF @TipoOrdenAtencion = 1
        BEGIN
            -- Lógica de consulta externa
            PRINT 'llegó punto x1'; 

            -- Obtener IdConsultaExterna
            SELECT TOP 1 @IdConsultaExterna = IDConsultaExterna
            FROM SS_CE_ConsultaExterna WITH (NOLOCK)
            WHERE IdOrdenAtencion = @IDordenatencion
              AND LineaOrdenAtencion = @LineaOrdenAtencionConsulta;

            IF @IdConsultaExterna IS NULL
            BEGIN
             --  RAISERROR('No se encontró Consulta Externa para la orden.', 16, 1);
               SET @al_retorno = 1;  -- Error
               SET @as_mensaje = 'No se encontró Consulta Externa para la orden.';
               RETURN;
            END

            -- (Más lógica de la consulta externa...)

            -- Actualizar Estado de Cita
            IF @IdCita IS NOT NULL
            BEGIN
                UPDATE SS_CC_Cita
                SET EstadoDocumentoAnterior = @EstadoCita,
                    EstadoDocumento = 8
                WHERE IdCita = @IdCita;

                -- (Más lógica de actualización de cita...)
            END

            -- (Más lógica de actualización de consulta externa...)
        END
        ELSE
        BEGIN
            -- Lógica para otro tipo de orden de atención
            PRINT 'llegó punto @IDordenatencion = ' + CAST(ISNULL(@IDordenatencion,0) AS VARCHAR);

            IF @IDordenatencion > 0
            BEGIN
                -- Obtener procedimiento
                SELECT TOP 1 @IDPROCEDIMIENTO = IdProcedimiento
                FROM SS_PR_Procedimiento WITH (NOLOCK)
                WHERE IdOrdenAtencion = @IDordenatencion
                  AND LineaOrdenAtencion = @LineaOrdenAtencionConsulta;

                IF @IDPROCEDIMIENTO IS NULL
                BEGIN
             --       RAISERROR('No se encontró Procedimiento para la orden.', 16, 1);
                    SET @al_retorno = 1;  -- Error
                    SET @as_mensaje = 'No se encontró Procedimiento para la orden.';
                    RETURN;
                END

                -- (Más lógica de procedimiento...)

                -- Actualizar Orden Atención Detalle
                UPDATE SS_AD_ORDENATENCIONDETALLE
                SET Situacion = 2
                WHERE IdOrdenAtencion = @IDordenatencion
                  AND Linea = @LineaOrdenAtencionConsulta;
            END
        END
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT;
        SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY();
        
        RAISERROR (@ErrMsg, @ErrSeverity, 1);
        
        -- Asignar valores de error
        SET @al_retorno = 1;  -- Error
        SET @as_mensaje = @ErrMsg;  -- Mensaje de error
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE [dbo].[SP_SS_IT_SALUDDescansoMedico]
@IdOrdenAtencion Int=null,
@IdPaciente int=null,
@IdLineaOa int=null,
@FechaInicio DATETIME,
@FechaFinal DATETIME,
@Observaciones varchar(250),
@Estado int=null,
@UsuarioCreacion varchar(25),
@FechaCreacion datetime=null,
@UsuarioModificacion varchar(25),
@FechaModificacion datetime=null

AS
BEGIN
	Declare @ldt_FechaHoy datetime
	Declare @ll_retorno int
	Declare @ls_mensaje varchar(500)

	BEGIN TRAN

	SET @ll_retorno = 0

    BEGIN TRY
		
		IF @ll_retorno = 0
		BEGIN
			SET @ldt_FechaHoy = GETDATE()


				DECLARE @IdConsultaExterna INT 
				DECLARE @IdDescanso INT 

				SELECT @IdConsultaExterna = IdConsultaExterna FROM SS_CE_ConsultaExterna 
				WHERE IdOrdenAtencion = @IdOrdenAtencion AND LineaOrdenAtencion=@IdLineaOa
	
					IF ( SELECT  COUNT (*) FROM SS_CE_ConsultaExterna	WHERE SS_CE_ConsultaExterna.IdConsultaExterna=@IdConsultaExterna )> 0
						BEGIN

							DELETE FROM SS_CE_DescansoMedico  WHERE IdConsultaExterna = @IdConsultaExterna
							SELECT @IdDescanso = ISNULL(Max(IdDescanso),1)+ 1 FROM SS_CE_DescansoMedico WHERE IdConsultaExterna =@IdConsultaExterna			
							INSERT INTO SS_CE_DescansoMedico  (IdDescanso,IdConsultaExterna,FechaInicio,
								FechaFinal,Observaciones,Estado,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,TxtObservaciones)
							VALUES (@IdDescanso, @IdConsultaExterna,@FechaInicio,@FechaFinal,@Observaciones,2,@UsuarioCreacion,@FechaCreacion ,@UsuarioCreacion,@ldt_FechaHoy,DATEDIFF(day, @FechaInicio,  DATEADD(DAY, 1,@FechaFinal)))
		

						END
					ELSE
						BEGIN
								SET @ll_retorno = -1
								SET @ls_mensaje = 'No Existe Consulta Externa'
						END

		END

	END TRY
    BEGIN CATCH
		
		SET @ll_retorno = -1
		SET @ls_mensaje = ERROR_MESSAGE()

    END CATCH


	IF @ll_retorno = 0
	BEGIN
		SET @ll_retorno = 1
		SET @ls_mensaje = 'Correcto'
		COMMIT
	END
	ELSE
	BEGIN
		ROLLBACK
	END

		
	SELECT  Retorno = @ll_retorno, Mensaje = @ls_mensaje
END
GO

CREATE OR ALTER PROCEDURE [dbo].[SP_SS_IT_SALUDAnamnesisInFormeMedico]
@IDordenatencion		Int=null,
@IdPaciente				int=null,
@IdLineaOa				int=null,
@Secuencia				int=null,
@InformeMedico			varchar(8000),
@Estado					int=null,
@UsuarioCreacion		varchar(25),
@FechaCreacion			datetime=null,
@ExamenClinico			varchar(8000),
@UsuarioModificacion	varchar(25),
@FechaModificacion		datetime=null

AS
BEGIN
	
	Declare @IdConsultaExterna INT,@IdInformeMax INT,
	@IDINFORMEACTUAL INT, 
	@tipoatencion INT,
	@plantilla INT,
	@tipoconsulta INT
	SELECT @IdConsultaExterna = SS_CE_ConsultaExterna.IDConsultaexterna
	FROM SS_CE_ConsultaExterna
	WHERE SS_CE_ConsultaExterna.IdOrdenAtencion = @IDordenatencion
	AND SS_CE_ConsultaExterna.LineaOrdenAtencion = @IdLineaOa

	--IdPlantilla = 33   -- informe medico 

	IF ( SELECT  COUNT (*) FROM SS_CE_ConsultaExterna	WHERE SS_CE_ConsultaExterna.IdConsultaExterna=@IdConsultaExterna )> 0

	BEGIN

			SELECT @tipoconsulta  = SS_CE_ConsultaExterna.TipoConsulta
			FROM SS_CE_ConsultaExterna
			WHERE SS_CE_ConsultaExterna.IdOrdenAtencion = @IDordenatencion
			AND SS_CE_ConsultaExterna.LineaOrdenAtencion = @IdLineaOa

			SELECT @tipoatencion   = SS_AD_OrdenAtencion.TipoAtencion
			from SS_AD_OrdenAtencion where IdOrdenAtencion=@IDordenatencion

			SELECT @IDINFORMEACTUAL = ISNULL(SS_CE_Informe.IdInforme,0)
			FROM SS_CE_Informe WHERE SS_CE_INFORME.IdConsultaExterna=@IdConsultaExterna AND TipoInforme='RM'

			DELETE SS_CE_InformeDetalle WHERE IdInforme = @IDINFORMEACTUAL 	 
			DELETE SS_CE_Informe WHERE IdInforme = @IDINFORMEACTUAL AND TipoInforme='RM'
		
			SELECT @IdInformeMax = MAX(SS_CE_Informe.IdInforme) +1
			FROM SS_CE_Informe 				

			if @tipoatencion=1
				begin
					set @plantilla=33
				end
			ELSE
				begin
					set @plantilla=33
				end	

			INSERT INTO SS_CE_Informe ( IdInforme , IdConsultaExterna , IdPlantilla , FechaInforme , TipoInforme , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) -- SE REALIZO EL CAMBIO DEL 29 AL 58 POR EL INCIDENTE DE LA TABLA INFORME 16-11-2020
				VALUES ( @IdInformeMax , @IdConsultaExterna , @plantilla , @FechaCreacion , 'RM' , 2 , @UsuarioCreacion , @FechaCreacion,@UsuarioModificacion,@FechaModificacion) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
										VALUES ( @IdInformeMax , 1 , 25 , @plantilla , 1 , 0 , @InformeMedico , null , 2 , @UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaCreacion)

			SELECT @IDINFORMEACTUAL   Informe 
		END	

	ELSE
		BEGIN
				SELECT 0  as Informe 
		END

END

GO

CREATE OR ALTER PROCEDURE [dbo].[SP_SS_IT_SALUDAnamnesisIngresoMirth]
(
    -- Parámetros de Ingreso
    @UnidadReplicacion          VARCHAR(15),
    @IdEpisodioAtencion         INT = NULL,
    @IdPaciente                 INT,
    @EpisodioClinico            INT = NULL,
    @IdOrdenAtencion            INT,
    @LineaOrdenAtencion         INT,
    @Secuencia                  VARCHAR(20),
    @TiempoEnfermedad           VARCHAR(50),
    @TiempoEnfermedadUnidad     VARCHAR(15),
    @RelatoCronologico          VARCHAR(8000),
    @PresionArterialMSD1        VARCHAR(50),
    @PresionArterialMSD2        VARCHAR(50),
    @PresionArterialMSI1        VARCHAR(50),
    @PresionArterialMSI2        VARCHAR(50),
    @FrecuenciaCardiaca         VARCHAR(50),
    @FrecuenciaRespiratoria     VARCHAR(50),
    @Temperatura                NUMERIC(20,6) = 0,
    @SaturacionOxigeno          VARCHAR(50),
    @Peso                       VARCHAR(50),
    @Talla                      VARCHAR(50),
    @ExamenClinico              VARCHAR(8000),
    @Estado                     INT,
    @UsuarioCreacion            VARCHAR(25),
    @FechaCreacion              DATETIME
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE 
        @ldt_FechaHoy DATETIME = GETDATE(),
        @ll_retorno INT = 0,
        @ls_mensaje VARCHAR(500) = '',
        @IdConsultaExterna INT,
        @tipoconsulta INT,
        @tipoatencion INT,
        @plantilla INT,
        @IdInformeActual INT,
        @IdInformeNuevo INT;

    BEGIN TRY
        BEGIN TRAN;

        -- Insertar en SS_IT_SALUDAnamnesisIngreso
        INSERT INTO SS_IT_SALUDAnamnesisIngreso 
        (
            IdOrdenAtencion, LineaOrdenAtencion, UnidadReplicacion, IdEpisodioAtencion, IdPaciente,
            EpisodioClinico, Secuencia, TiempoEnfermedad, TiempoEnfermedadUnidad, RelatoCronologico,
            PresionArterialMSD1, PresionArterialMSD2, PresionArterialMSI1, PresionArterialMSI2,
            FrecuenciaCardiaca, FrecuenciaRespiratoria, Temperatura, SaturacionOxigeno,
            Peso, Talla, EXAMENCLINICOOBS, Estado,
            UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion,
            IndicadorProcesado, FechaProcesado
        )
        VALUES
        (
            @IdOrdenAtencion, @LineaOrdenAtencion, @UnidadReplicacion, @IdEpisodioAtencion, @IdPaciente,
            @EpisodioClinico, @Secuencia, @TiempoEnfermedad, @TiempoEnfermedadUnidad, @RelatoCronologico,
            @PresionArterialMSD1, @PresionArterialMSD2, @PresionArterialMSI1, @PresionArterialMSI2,
            @FrecuenciaCardiaca, @FrecuenciaRespiratoria, @Temperatura, @SaturacionOxigeno,
            @Peso, @Talla, @ExamenClinico, @Estado,
            @UsuarioCreacion, @FechaCreacion, @UsuarioCreacion, @FechaCreacion,
            1, @ldt_FechaHoy
        );

        -- Obtener información de consulta externa
        SELECT 
            @IdConsultaExterna = CE.IdConsultaExterna,
            @tipoconsulta = CE.TipoConsulta,
            @tipoatencion = OA.TipoAtencion
        FROM 
            SS_CE_ConsultaExterna CE
            INNER JOIN SS_AD_OrdenAtencion OA ON OA.IdOrdenAtencion = CE.IdOrdenAtencion
        WHERE 
            CE.IdOrdenAtencion = @IdOrdenAtencion AND CE.LineaOrdenAtencion = @LineaOrdenAtencion;

        IF @IdConsultaExterna IS NULL
        BEGIN
            SET @ll_retorno = -1;
            SET @ls_mensaje = 'Consulta externa no encontrada.';
            ROLLBACK;
            SELECT Retorno = @ll_retorno, Mensaje = @ls_mensaje;
            RETURN;
        END

        -- Buscar informe actual
        SELECT @IdInformeActual = IdInforme
        FROM SS_CE_Informe
        WHERE IdConsultaExterna = @IdConsultaExterna AND TipoInforme = 'CE';

        -- Borrar informe anterior si existe
        IF @IdInformeActual IS NOT NULL
        BEGIN
            DELETE FROM SS_CE_InformeDetalle WHERE IdInforme = @IdInformeActual;
            DELETE FROM SS_CE_Informe WHERE IdInforme = @IdInformeActual;
        END

        -- Generar nuevo IdInforme
        SELECT @IdInformeNuevo = ISNULL(MAX(IdInforme), 0) + 1 FROM SS_CE_Informe WITH (TABLOCKX);

        -- Determinar plantilla
        IF @LineaOrdenAtencion > 1 AND @tipoconsulta = 4
            SET @plantilla = 55;
        ELSE IF @tipoatencion = 2 AND @LineaOrdenAtencion > 1 AND @tipoconsulta = 2
            SET @plantilla = 56;
        ELSE IF @tipoatencion = 2 AND @LineaOrdenAtencion > 1 AND @tipoconsulta = 3
            SET @plantilla = 58;
        ELSE
        BEGIN
            SET @ll_retorno = -1;
            SET @ls_mensaje = 'Condición de plantilla no encontrada.';
            ROLLBACK;
            SELECT Retorno = @ll_retorno, Mensaje = @ls_mensaje;
            RETURN;
        END

        -- Insertar informe principal
        INSERT INTO SS_CE_Informe
        (IdInforme, IdConsultaExterna, IdPlantilla, FechaInforme, TipoInforme, Estado, UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion)
        VALUES
        (@IdInformeNuevo, @IdConsultaExterna, @plantilla, @FechaCreacion, 'CE', 2, @UsuarioCreacion, @FechaCreacion, @UsuarioCreacion, @FechaCreacion);

        -- Insertar detalles según plantilla
        IF @plantilla = 55
        BEGIN
            INSERT INTO SS_CE_InformeDetalle (IdInforme, Secuencial, IdConcepto, IdPlantilla, SecuencialPlantilla, ValorNumerico, ValorCadena, ValorFecha, Estado, UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion)
            VALUES (@IdInformeNuevo, 1, 655, @plantilla, 1, 0, @RelatoCronologico, NULL, 2, @UsuarioCreacion, @FechaCreacion, @UsuarioCreacion, @FechaCreacion);
        END
        ELSE IF @plantilla = 56
        BEGIN
            INSERT INTO SS_CE_InformeDetalle (IdInforme, Secuencial, IdConcepto, IdPlantilla, SecuencialPlantilla, ValorNumerico, ValorCadena, ValorFecha, Estado, UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion)
            VALUES (@IdInformeNuevo, 1, 656, @plantilla, 1, 0, @RelatoCronologico, NULL, 2, @UsuarioCreacion, @FechaCreacion, @UsuarioCreacion, @FechaCreacion);
        END
        ELSE IF @plantilla = 58
        BEGIN
            INSERT INTO SS_CE_InformeDetalle (IdInforme, Secuencial, IdConcepto, IdPlantilla, SecuencialPlantilla, ValorNumerico, ValorCadena, ValorFecha, Estado, UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion)
            SELECT @IdInformeNuevo, Secuencial, IdConcepto, @plantilla, Secuencial, 0, Valor, NULL, 2, @UsuarioCreacion, @FechaCreacion, @UsuarioCreacion, @FechaCreacion
            FROM (VALUES
                (1, 1, @TiempoEnfermedad),
                (2, 2, @RelatoCronologico),
                (3, 332, @SaturacionOxigeno),
                (4, 4, @PresionArterialMSD1),
                (5, 142, @PresionArterialMSD2),
                (6, 5, @FrecuenciaCardiaca),
                (7, 6, @FrecuenciaRespiratoria)
            ) AS Detalle(Secuencial, IdConcepto, Valor);
        END

        COMMIT;

        SET @ll_retorno = 1;
        SET @ls_mensaje = 'OK';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;

        SET @ll_retorno = -1;
        SET @ls_mensaje = ERROR_MESSAGE();
    END CATCH;

    SELECT Retorno = @ll_retorno, Mensaje = @ls_mensaje;
END
GO

CREATE OR ALTER PROCEDURE [dbo].[SP_SS_IT_SaludDiagnosticoIngreso]
	@UnidadReplicacion         varchar(15),
	@IdEpisodioAtencion        int = NULL,
	@IdPaciente                int = NULL,
	@EpisodioClinico           int = NULL,
	@IdOrdenAtencion           int,
	@LINEA                     int,
	@IdDiagnostico             int,
	@Secuencia                 int = NULL,
	@Determinacion             varchar(2),
	@TipoOrdenAtencion         int,
	@ObservacionDiagnostico    varchar(200),
	@TipoIT                    varchar(5),
	@Estado                    int = 2,  -- Valor por defecto
	@UsuarioCreacion           varchar(25),
	@FechaCreacion             datetime
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE 
		@IdConsultaExterna     int,
		@IdProcedimiento       int,
		@al_retorno            int ,
		@as_mensaje            varchar(500);
	BEGIN TRY
		BEGIN TRAN;

		-- Insertar en la tabla de ingreso
		INSERT INTO SS_IT_SaludDiagnosticoIngreso (
			IdOrdenAtencion, LineaOrdenAtencionConsulta, IdDiagnostico, UnidadReplicacion,
			IdEpisodioAtencion, IdPaciente, EpisodioClinico, Secuencia, Estado, Determinacion,
			TIPOORDENATENCION, ObservacionDIAGNOSTICO, TIPOIT, UsuarioCreacion, FechaCreacion,
			UsuarioModificacion, FechaModificacion, IndicadorRecepcion, FechaRecepcion,
			IndicadorProcesado, FechaProcesado
		)
		VALUES (
			@IdOrdenAtencion, @LINEA, @IdDiagnostico, @UnidadReplicacion,
			@IdEpisodioAtencion, @IdPaciente, @EpisodioClinico, @Secuencia, @Estado, @Determinacion,
			@TipoOrdenAtencion, @ObservacionDiagnostico, @TipoIT, @UsuarioCreacion, @FechaCreacion,
			@UsuarioCreacion, GETDATE(), 1, GETDATE(), 1, GETDATE()
		);

		-- Procesar según tipo de atención
		IF @TipoOrdenAtencion IN (1, 11)
		BEGIN
			SELECT @IdConsultaExterna = IDConsultaexterna
			FROM SS_CE_ConsultaExterna
			WHERE IdOrdenAtencion = @IdOrdenAtencion AND LineaOrdenAtencion = @LINEA;

			-- Eliminar diagnóstico previo si existe
			DELETE FROM SS_CE_ConsultaExternaDiagnostico
			WHERE IDConsultaexterna = @IdConsultaExterna AND IdDiagnostico = @IdDiagnostico;

			-- Insertar si no es tipo D (eliminación)
			IF @TipoIT IN ('N', 'M')
			BEGIN
				INSERT INTO SS_CE_ConsultaExternaDiagnostico (
					IdConsultaExterna, IdDiagnostico, TipoDiagnostico, Estado,
					UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion,
					TipoAntecedente, IndicadorAntecedente, DetalleDiagnostico, Secuencial
				)
				VALUES (
					@IdConsultaExterna, @IdDiagnostico, @Determinacion, 2,
					@UsuarioCreacion, @FechaCreacion, @UsuarioCreacion, @FechaCreacion,
					'C', 1, @ObservacionDiagnostico, @IdPaciente
				);
			END
		END
		ELSE
		BEGIN
			SELECT @IdProcedimiento = IdProcedimiento
			FROM SS_PR_Procedimiento WITH(NOLOCK)
			WHERE IdOrdenAtencion = @IdOrdenAtencion AND LineaOrdenAtencion = @LINEA;

			-- Eliminar diagnóstico previo
			DELETE FROM SS_PR_ProcedimientoDiagnostico
			WHERE IdProcedimiento = @IdProcedimiento AND IdDiagnostico = @IdDiagnostico;

			-- Insertar si no es tipo D (eliminación)
			IF @TipoIT IN ('N', 'M', '')
			BEGIN
				INSERT INTO SS_PR_ProcedimientoDiagnostico (
					IdProcedimiento, IdDiagnostico, TipoDiagnostico, Estado,
					UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion, Observacion
				)
				VALUES (
					@IdProcedimiento, @IdDiagnostico, @Determinacion, 2,
					@UsuarioCreacion, @FechaCreacion, @UsuarioCreacion, @FechaCreacion, @ObservacionDiagnostico
				);
			END
		END

		COMMIT;
		SET @al_retorno = 1;
		SET @as_mensaje = 'Correcto';
	END TRY
	BEGIN CATCH
		ROLLBACK;
		SET @al_retorno = -1;
		SET @as_mensaje = ERROR_MESSAGE();
	END CATCH

	-- Devolver resultado
	SELECT Retorno = @al_retorno, Mensaje = @as_mensaje;
END
GO

CREATE OR ALTER PROCEDURE [dbo].[SP_SS_IT_SaludInformePROCIngreso]
	@UnidadReplicacion		varchar(15),
	@IdEpisodioAtencion		Int = NULL,
	@IdPaciente				int = NULL,
	@EpisodioClinico		int = NULL,
	@IdOrdenAtencion		Int = NULL,
	@LineaOrdenAtencion		int = NULL,
	@Informe				varchar(8000),
	@Estado					int = NULL,
	@UsuarioCreacion		varchar(25),
	@Fechacreacion			datetime
AS
BEGIN
	DECLARE @ldt_FechaHoy datetime = GETDATE()
	DECLARE @ll_retorno int = 0
	DECLARE @ls_mensaje varchar(500) = ''

	-- Variables para lógica de SP_SS_IT_SALUDInformeHCE
	DECLARE @IDPROCEDIMIENTO int
	DECLARE @IDInforme int

	BEGIN TRAN

	BEGIN TRY
		-- Insertar en SS_IT_SaludInformePROCIngreso
		INSERT INTO SS_IT_SaludInformePROCIngreso 
		( 
			IdOrdenAtencion, LineaOrdenAtencion, UnidadReplicacion, IdEpisodioAtencion,
			IdPaciente, EpisodioClinico, Estado, Informe,
			UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion,
			IndicadorRecepcion, FechaRecepcion, IndicadorProcesado, FechaProcesado		
		) 
		VALUES  
		( 
			@IdOrdenAtencion, @LineaOrdenAtencion, @UnidadReplicacion, @IdEpisodioAtencion, 
			@IdPaciente, @EpisodioClinico, @Estado ,@Informe, 
			@UsuarioCreacion, @Fechacreacion, @UsuarioCreacion, @ldt_FechaHoy,
			1, @ldt_FechaHoy, 1, @ldt_FechaHoy 
		)

		-- Obtener el ID del procedimiento relacionado
		SELECT @IDPROCEDIMIENTO = IDPROCEDIMIENTO
		FROM SS_PR_Procedimiento WITH(NOLOCK)
		WHERE IdOrdenAtencion = @IdOrdenAtencion AND LineaOrdenAtencion = @LineaOrdenAtencion

		-- Obtener IdInforme si existe y eliminar registros anteriores
		SELECT @IDInforme = IdInforme
		FROM SS_PR_Informe WITH(NOLOCK) 
		WHERE IdProcedimiento = @IDPROCEDIMIENTO

		DELETE FROM SS_PR_InformeDetalle WHERE IdInforme = @IDInforme
		DELETE FROM SS_PR_Informe WHERE IdInforme = @IDInforme

		-- Generar nuevo IDInforme
		SELECT @IDInforme = ISNULL(MAX(IDINFORME), 0) + 1
		FROM SS_PR_Informe WITH(NOLOCK)

		-- Insertar nuevo informe
		INSERT INTO SS_PR_Informe 
		( 
			IdInforme, IdProcedimiento, IdPlantilla, FechaInforme, Estado, 
			UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion 
		) 
		VALUES 
		( 
			@IDInforme, @IDPROCEDIMIENTO, 40, @Fechacreacion, 2, 
			@UsuarioCreacion, @Fechacreacion, @UsuarioCreacion, @Fechacreacion 
		)

		-- Insertar detalle del informe
		INSERT INTO SS_PR_InformeDetalle 
		( 
			IdInforme, Secuencial, IdConcepto, IdPlantilla, SecuencialPlantilla, 
			ValorNumerico, ValorCadena, ValorFecha, Estado, 
			UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion 
		) 
		VALUES 
		( 
			@IDInforme, 1, 10, 40, 1, 
			0, @Informe, GETDATE(), 2, 
			@UsuarioCreacion, @Fechacreacion, @UsuarioCreacion, @Fechacreacion 
		)

		-- Actualizar el procedimiento para indicar que ya tiene informe
		UPDATE SS_PR_Procedimiento 
		SET 
			IndicadorInforme = 2,
			UsuarioModificacion = @UsuarioCreacion, 
			FechaModificacion = @Fechacreacion 
		WHERE IdProcedimiento = @IDPROCEDIMIENTO

		-- Éxito
		SET @ll_retorno = 1
		SET @ls_mensaje = 'Correcto'

		COMMIT
	END TRY
	BEGIN CATCH
		-- Manejo de errores
		SET @ll_retorno = -1
		SET @ls_mensaje = ERROR_MESSAGE()
		ROLLBACK
	END CATCH

	-- Retornar estado
	SELECT Retorno = @ll_retorno, Mensaje = @ls_mensaje
END
GO

CREATE OR ALTER PROCEDURE [dbo].[SP_SS_IT_SaludInformeRutaIngreso]
@UnidadReplicacion    varchar(15),
@IdEpisodioAtencion   int = NULL,
@IdPaciente           int = NULL,
@EpisodioClinico      int = NULL,
@IdOrdenAtencion      int = NULL,
@LineaOrdenAtencion   int = NULL,
@RutaInforme          varchar(250),
@Observacion          varchar(250),
@Estado               int = NULL,
@UsuarioCreacion      varchar(25),
@Fechacreacion        datetime
AS
BEGIN
    DECLARE 
        @ldt_FechaHoy        datetime = GETDATE(),
        @IDPROCEDIMIENTO     int,
        @IDInforme           int,
        @ll_retorno          int = 0,
        @ls_mensaje          varchar(500)

    BEGIN TRAN

    BEGIN TRY
        -- Paso 1: Insertar en SS_IT_SaludInformeRutaIngreso
        INSERT INTO SS_IT_SaludInformeRutaIngreso 
        (
            IdOrdenAtencion, LineaOrdenAtencion, UnidadReplicacion, IdEpisodioAtencion,
            IdPaciente, EpisodioClinico, Estado, RutaInforme, Observacion,
            UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion,
            IndicadorRecepcion, FechaRecepcion, IndicadorProcesado, FechaProcesado
        ) VALUES 
        (
            @IdOrdenAtencion, @LineaOrdenAtencion, @UnidadReplicacion, @IdEpisodioAtencion,
            @IdPaciente, @EpisodioClinico, @Estado, @RutaInforme, @Observacion,
            @UsuarioCreacion, @Fechacreacion, @UsuarioCreacion, @ldt_FechaHoy,
            1, @ldt_FechaHoy, 1, @ldt_FechaHoy
        )

        -- Paso 2: Obtener ID del procedimiento
        SELECT @IDPROCEDIMIENTO = IDPROCEDIMIENTO 
        FROM SS_PR_Procedimiento WITH(NOLOCK) 
        WHERE IdOrdenAtencion = @IdOrdenAtencion AND LineaOrdenAtencion = @LineaOrdenAtencion

        -- Paso 3: Generar nuevo IDInforme
        SELECT @IDInforme = ISNULL(MAX(IDINFORME), 0) + 1 
        FROM SS_PR_ProcedimientoInforme WITH(NOLOCK) 
        WHERE IdProcedimiento = @IDPROCEDIMIENTO

        -- Paso 4: Insertar en SS_PR_ProcedimientoInforme
        INSERT INTO SS_PR_ProcedimientoInforme 
        (
            IdProcedimiento, IdInforme, Nombre, RutaInforme, Estado, 
            UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion
        ) VALUES 
        (
            @IDPROCEDIMIENTO, @IDInforme, @Observacion, @RutaInforme, 2, 
            @UsuarioCreacion, @Fechacreacion, @UsuarioCreacion, @Fechacreacion
        )

        -- Paso 5: Actualizar indicador de procedimiento
        UPDATE SS_PR_Procedimiento 
        SET IndicadorInforme = 2, 
            UsuarioModificacion = @UsuarioCreacion, 
            FechaModificacion = @Fechacreacion
        WHERE IdProcedimiento = @IDPROCEDIMIENTO

    END TRY
    BEGIN CATCH
        SET @ll_retorno = -1
        SET @ls_mensaje = ERROR_MESSAGE()
    END CATCH

    IF @ll_retorno = 0
    BEGIN
        COMMIT
        SET @ll_retorno = 1
        SET @ls_mensaje = 'Correcto'
    END
    ELSE
    BEGIN
        ROLLBACK
    END

    SELECT Retorno = @ll_retorno, Mensaje = @ls_mensaje
END
GO

CREATE OR ALTER PROCEDURE [dbo].[SP_SS_IT_SALUDOftalmologicoHCE]
@IdOrdenAtencion int,
@LineaOrdenAtencion int,
@UnidadReplicacion varchar(15),
@IdEpisodioAtencion int,
@IdPaciente int,
@EpisodioClinico int,
@Secuencia varchar(25),
@ENFACTUAL varchar (4000),
@ANTIMPORTANCIA varchar (25),
@AVscOD varchar (25),
@AvCCOD varchar (25),
@AEAVODPIN varchar (25),
@CERCAVAD varchar (25),
@AVSCOI varchar (25),
@AVCCOI varchar (25),
@AEAVOIDPIN varchar (25),
@CERCAVAOI varchar (25),
@SPHodREFRA varchar (25),
@CILodREFA varchar (25),
@EJEodREFRA varchar (25),
@AVodREFRA varchar (25),
@ADDodREFRA varchar (25),
@DIPodREFRA varchar (25),
@SPHoiSCICLO varchar (25),
@CILoiSCICLO varchar (25),
@EJEoiSCICLO varchar (25),
@AVoiSCICLO varchar (25),
@ADDoiSCICLO varchar (25),
@DIPoiSCICLO varchar (25),
@PAPARPADOSANEXOS varchar (500),
@CORNEACRISTESCLERA VARchar (500),
@IRISPUPILA varchar (500),
@TonoOD varchar (25),
@TonoOI varchar (25),
@MMHHTonShiotz varchar (25),
@MMHHTonAplanacion varchar (25),
@MMHHTonOtra varchar (25),
@FONDOJOyG varchar (500),
@Estado int,
@UsuarioCreacion varchar (25),
@FechaCreacion datetime,
@UsuarioModificacion varchar (25),
@FechaModificacion datetime,
@al_retorno int OUTPUT,
@as_mensaje varchar(500) OUTPUT
AS
BEGIN
Declare @IdConsultaExterna int,@IdInformeMax int, --28 AGOSTO 2019,@SecuencialInformeDetallei int,@IdCita int,@EstadoCita int, @SecuencialMaxCita INT
--MODIFICAR
@IDINFORMEACTUAL INT,
--CIERRE
--MODIFICAR PARA OFTALMOLOGIA 20191709
@IDESPECIALIDADOF INT

	BEGIN TRAN

	SET @al_retorno = 0

	BEGIN TRY
		IF @al_retorno = 0
		BEGIN

			SELECT @IdConsultaExterna = SS_CE_ConsultaExterna.IDConsultaexterna
			FROM SS_CE_ConsultaExterna
			WHERE SS_CE_ConsultaExterna.IdOrdenAtencion = @IDordenatencion AND SS_CE_ConsultaExterna.LineaOrdenAtencion = @LineaOrdenAtencion

			IF ( SELECT  COUNT (*) FROM SS_CE_ConsultaExterna
			WHERE SS_CE_ConsultaExterna.IdConsultaExterna=@IdConsultaExterna AND SS_CE_ConsultaExterna.Especialidad=22/*OFTALMOLOGIA*/)> 0

			BEGIN

				SELECT @IDINFORMEACTUAL = ISNULL(SS_CE_Informe.IdInforme,0)
				FROM SS_CE_Informe WHERE SS_CE_INFORME.IdConsultaExterna=@IdConsultaExterna  AND TipoInforme='CE'

				DELETE SS_CE_InformeDetalle WHERE IdInforme = @IDINFORMEACTUAL 	 
				DELETE SS_CE_Informe WHERE IdInforme = @IDINFORMEACTUAL AND TipoInforme='CE'
	
				SELECT @IdInformeMax = MAX(SS_CE_Informe.IdInforme) +1
				FROM SS_CE_Informe 

				INSERT INTO SS_CE_Informe ( IdInforme , IdConsultaExterna , IdPlantilla , FechaInforme , TipoInforme , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
				VALUES ( @IdInformeMax , @IdConsultaExterna , 31 , @FechaCreacion , 'CE' , 2 , @UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaCreacion) 

	
				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
				VALUES ( @IdInformeMax , 1 , 2 , 31 , 1 , 0 , @ENFACTUAL   , null , 2 , @UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaCreacion)

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
				VALUES ( @IdInformeMax , 2 , 3 , 31 , 2 , 0 , @ANTIMPORTANCIA , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion  ) 
				VALUES ( @IdInformeMax , 3 , 260 , 31 , 3 , 0 , @AVscOD , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion  ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion  ) 
				VALUES ( @IdInformeMax , 4 , 261 , 31 , 4 , 0 , @AvCCOD , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion  ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion  ) 
				VALUES ( @IdInformeMax , 5 , 262 , 31 , 5 , 0 , @AEAVODPIN , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion  ) 
				VALUES ( @IdInformeMax , 6 , 263 , 31 , 6 , 0 , @CERCAVAD , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion  ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion  ) 
				VALUES ( @IdInformeMax , 7 , 264 , 31 , 7 , 0 , @AVSCOI , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion  ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
				VALUES ( @IdInformeMax , 8 , 265 , 31 , 8 , 0 , @AVCCOI , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion  ) 
				VALUES ( @IdInformeMax , 9 , 266 , 31 , 9 , 0 , @AEAVOIDPIN , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion  ) 
				VALUES ( @IdInformeMax , 10 , 267 , 31 , 10 , 0 , @CERCAVAOI , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
				VALUES ( @IdInformeMax , 11 , 268 , 31 , 11 , 0 , @SPHodREFRA , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion  ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion  ) 
				VALUES ( @IdInformeMax , 12 , 269 , 31 , 12 , 0 , @CILodREFA , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion  ) 
				VALUES ( @IdInformeMax , 13 , 270 , 31 , 13 , 0 , @EJEodREFRA , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion  ) 
				VALUES ( @IdInformeMax , 14 , 271 , 31 , 14 , 0 , @AVodREFRA , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion  ) 
				VALUES ( @IdInformeMax , 15 , 272 , 31 , 15 , 0 , @ADDodREFRA , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion  ) 
				VALUES ( @IdInformeMax , 16 , 273 , 31 , 16 , 0 , @DIPodREFRA , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion  ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
				VALUES ( @IdInformeMax , 17 , 274 , 31 , 17 , 0 , @SPHoiSCICLO , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion  ) 
				VALUES ( @IdInformeMax , 18 , 275 , 31 , 18 , 0 , @CILoiSCICLO , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion  ) 
				VALUES ( @IdInformeMax , 19 , 276 , 31 , 19 , 0 , @EJEoiSCICLO , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion  ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
				VALUES ( @IdInformeMax , 20 , 277 , 31 , 20 , 0 , @AVoiSCICLO , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
				VALUES ( @IdInformeMax , 21 , 278 , 31 , 21 , 0 , @ADDoiSCICLO , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion  ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion  ) 
				VALUES ( @IdInformeMax , 22 , 279 , 31 , 22 , 0 , @DIPoiSCICLO , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion  ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion  ) 
				VALUES ( @IdInformeMax , 23 , 280 , 31 , 23 , 0 , @PAPARPADOSANEXOS , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
				VALUES ( @IdInformeMax , 24 , 281 , 31 , 24 , 0 , @CORNEACRISTESCLERA , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion  ) 
				VALUES ( @IdInformeMax , 25 , 282 , 31 , 25 , 0 , @IRISPUPILA , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion  ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion  ) 
				VALUES ( @IdInformeMax , 26 , 283 , 31 , 26 , 0 , @TonoOD , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion  ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion  ) 
				VALUES ( @IdInformeMax , 27 , 284 , 31 , 27 , 0 , @TonoOI , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion  ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
				VALUES ( @IdInformeMax , 28 , 285 , 31 , 28 , 0 , @MMHHTonShiotz , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion  ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion  ) 
				VALUES ( @IdInformeMax , 29 , 286 , 31 , 29 , 0 , @FONDOJOyG , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion  ) 

				INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
				UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion  ) 
				VALUES ( @IdInformeMax , 30 , 287 , 31 , 30 , 0 , @FONDOJOyG , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion  ) 
			END
			ELSE
			BEGIN
				SELECT COUNT (1) FROM SS_CE_Informe WHERE IdInforme=@IDINFORMEACTUAL
			END
		END
		--CERRAR MODIFICAR OTALMOLOGIC 17092019

	END TRY
	BEGIN CATCH

		SET @al_retorno = -1
		SET @as_mensaje = ERROR_MESSAGE()

	END CATCH

	IF @al_retorno = 0
	BEGIN
		COMMIT
	END
	ELSE
	BEGIN
		ROLLBACK
	END
END



GO

CREATE OR ALTER PROCEDURE [dbo].[SP_SS_IT_SaludOFTALMOLOGICOIngresoIntermedia]
@IdOrdenAtencion		int,
@LineaOrdenAtencion		int,
@UnidadReplicacion		varchar(15),
@IdEpisodioAtencion		int,
@IdPaciente				int,
@EpisodioClinico		int,
@Secuencia				varchar(25),
@ENFACTUAL				varchar (4000),
@ANTIMPORTANCIA			varchar (25),
@AVscOD					varchar (25),
@AvCCOD					varchar (25),
@AEAVODPIN				varchar (25),
@CERCAVAD				varchar (25),
@AVSCOI					varchar (25),
@AVCCOI					varchar (25),
@AEAVOIDPIN				varchar (25),
@CERCAVAOI				varchar (25),
@SPHodREFRA				varchar (25),
@CILodREFA				varchar (25),
@EJEodREFRA				varchar (25),
@AVodREFRA				varchar (25),
@ADDodREFRA				varchar (25),
@DIPodREFRA				varchar (25),
@SPHoiSCICLO			varchar (25),
@CILoiSCICLO			varchar (25),
@EJEoiSCICLO			varchar (25),
@AVoiSCICLO				varchar (25),
@ADDoiSCICLO			varchar (25),
@DIPoiSCICLO			varchar (25),
@PAPARPADOSANEXOS		varchar (500),
@CORNEACRISTESCLERA		varchar (500),
@IRISPUPILA				varchar (500),
@TonoOD					varchar (25),
@TonoOI					varchar (25),
@MMHHTonShiotz			varchar (25),
@MMHHTonAplanacion		varchar (25),
@MMHHTonOtra			varchar (25),
@FONDOJOyG				varchar (500),
@Estado					int=NULL,
@UsuarioCreacion		varchar(25),
@Fechacreacion			datetime

AS
BEGIN

	Declare @ldt_FechaHoy datetime
	Declare @ll_retorno int
	Declare @ls_mensaje varchar(500)

	BEGIN TRAN

	SET @ll_retorno = 0

    BEGIN TRY
		IF @ll_retorno = 0
		BEGIN
			SET @ldt_FechaHoy = GETDATE()

			INSERT INTO SS_IT_SALUDOFTALMOLOGICOIngreso 
				( IdOrdenAtencion,LineaOrdenAtencion,UnidadReplicacion,IdEpisodioAtencion,IdPaciente,EpisodioClinico,Secuencia,
				ENFACTUAL,ANTIMPORTANCIA,AVscOD,AvCCOD,AEAVODPIN,CERCAVAD,AVSCOI,
				AVCCOI,AEAVOIDPIN,CERCAVAOI,SPHodREFRA,CILodREFA,EJEodREFRA,AVodREFRA,
				ADDodREFRA,DIPodREFRA,SPHoiSCICLO,CILoiSCICLO,EJEoiSCICLO,AVoiSCICLO,
				ADDoiSCICLO,DIPoiSCICLO,PAPARPADOSANEXOS,CORNEACRISTESCLERA,IRISPUPILA,
				TonoOD,TonoOI,MMHHTonShiotz,MMHHTonAplanacion,MMHHTonOtra,FONDOJOyG,
				Estado,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,
				IndicadorProcesado,FechaProcesado		)
			 VALUES  
					( 	@IdOrdenAtencion,@LineaOrdenAtencion,@UnidadReplicacion,@IdEpisodioAtencion,@IdPaciente,@EpisodioClinico,@Secuencia,
						@ENFACTUAL,@ANTIMPORTANCIA,@AVscOD,@AvCCOD,@AEAVODPIN,@CERCAVAD,@AVSCOI,
						@AVCCOI,@AEAVOIDPIN,@CERCAVAOI,@SPHodREFRA,@CILodREFA,@EJEodREFRA,@AVodREFRA,
						@ADDodREFRA,@DIPodREFRA,@SPHoiSCICLO,@CILoiSCICLO,@EJEoiSCICLO,@AVoiSCICLO,
						@ADDoiSCICLO,@DIPoiSCICLO,@PAPARPADOSANEXOS,@CORNEACRISTESCLERA,@IRISPUPILA,
						@TonoOD,@TonoOI,@MMHHTonShiotz,@MMHHTonAplanacion,@MMHHTonOtra,@FONDOJOyG, 
						@Estado , @UsuarioCreacion, @Fechacreacion, @UsuarioCreacion,@ldt_FechaHoy,1,@ldt_FechaHoy ) 


			EXEC SP_SS_IT_SALUDOftalmologicoHCE @IdOrdenAtencion, @LineaOrdenAtencion, @UnidadReplicacion, @IdEpisodioAtencion, @IdPaciente, @EpisodioClinico, @Secuencia, @ENFACTUAL,
				@ANTIMPORTANCIA, @AVscOD, @AvCCOD, @AEAVODPIN, @CERCAVAD, @AVSCOI, @AVCCOI, @AEAVOIDPIN, @CERCAVAOI, @SPHodREFRA, @CILodREFA, @EJEodREFRA, @AVodREFRA, @ADDodREFRA, @DIPodREFRA,
				@SPHoiSCICLO, @CILoiSCICLO, @EJEoiSCICLO, @AVoiSCICLO, @ADDoiSCICLO, @DIPoiSCICLO, @PAPARPADOSANEXOS, @CORNEACRISTESCLERA, @IRISPUPILA, @TonoOD, @TonoOI, @MMHHTonShiotz,
				@MMHHTonAplanacion, @MMHHTonOtra, @FONDOJOyG, @Estado, @UsuarioCreacion, @ldt_FechaHoy, @UsuarioCreacion, @ldt_FechaHoy, @ll_retorno OUT, @ls_mensaje OUT
		END
	END TRY
    BEGIN CATCH
		
		SET @ll_retorno = -1
		SET @ls_mensaje = ERROR_MESSAGE()

    END CATCH


	IF @ll_retorno = 0
	BEGIN
			SET @ll_retorno = 1
		SET @ls_mensaje = 'Correcto'
		COMMIT
	END
	ELSE
	BEGIN
		ROLLBACK
	END

	SELECT  Retorno = @ll_retorno, Mensaje = @ls_mensaje

END
GO

CREATE OR ALTER PROCEDURE [dbo].[SP_SS_IT_SaludExamenesHCE]
@IDordenatencion Int,
@IDPaciente int,
@IdTipoOrdenatencion int,
@Componente varchar(25),
@Cantidad DECIMAL (20,6),
@IndicadorEPS int,
@Especialidad int,
@Usuario varchar(25),
@Fechacreacion datetime,
@lineamax int,
@Observacion varchar(200),
@LineaOrdenAtencionConsulta int,
@SECUENCIALHCE VARCHAR(15) --PARA MODIFICAR HCE 15 AGOSTO 2019
WITH RECOMPILE
    
AS


-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
--------------------------1.- LLENAR TABLA SS_AD_OrdenAtencionDetalle EXAMENES-------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

declare @var int,@IdLinea int,@ORDEN_ATENCION int ,@idturno int,@IdEstablecimiento int,@nombreComponente varchar(200),@sucursal varchar(15),@compania  varchar(15) -- modificar

--SET @ORDEN_ATENCION=(SELECT TipoAtencion FROM SS_AD_OrdenAtencion WHERE IdOrdenAtencion=@IDordenatencion) -- COMENTADO JORDAN MATEO
SELECT @ORDEN_ATENCION=TipoAtencion,@IdEstablecimiento=IdEstablecimiento,@sucursal=Sucursal, @compania=Compania,@idturno = idturno FROM SS_AD_OrdenAtencion WHERE IdOrdenAtencion=@IDordenatencion  -- MODIFICADO JORDAN MATEO 
SELECT @var = COUNT(*),@IdLinea = max(Linea) FROM SS_AD_OrdenAtencionDetalle  WITH (NOLOCK) WHERE IdOrdenAtencion = @IDordenatencion and SECUENCIALHCE=@SECUENCIALHCE

if @var =0
	begin

	Declare @IdConsultaExterna int,@SecuencialOrdenMax int, @idservicio int, @INDICADORHHMM int, @CENTROCOSTO varchar(15),@IDMEDICO int --creado para Interconsulta

	SELECT @IdConsultaExterna = IDConsultaexterna
	FROM SS_CE_ConsultaExterna  WITH (NOLOCK) 
	WHERE IdOrdenAtencion = @IDordenatencion AND  LineaOrdenAtencion= @LineaOrdenAtencionConsulta

	SELECT @idservicio = IdServicio
	FROM SS_GE_ServicioPrestacion  WITH (NOLOCK)
	WHERE COMPONENTE = @Componente

	SELECT @CentroCosto = CM_CO_TablaMaestroDetalleConcepto.ValorTexto FROM CM_CO_TablaMaestroDetalleConcepto WITH (NOLOCK)
	INNER JOIN CM_CO_TablaMaestroConcepto WITH (NOLOCK)ON CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro = CM_CO_TablaMaestroConcepto.IdTablaMaestro AND CM_CO_TablaMaestroDetalleConcepto.IdConcepto = CM_CO_TablaMaestroConcepto.IdConcepto 
	WHERE CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro = 101 AND CM_CO_TablaMaestroDetalleConcepto.IdCodigo = @IdTipoOrdenatencion --6
	 AND CM_CO_TablaMaestroConcepto.Concepto = 'TOA_COSTCENTER' 

	SELECT @SecuencialOrdenMax = ISNULL(MAX(ISNULL(Linea,0)),0) +1
	FROM SS_CE_ConsultaExternaOrdenMedica WITH (NOLOCK)
	WHERE Idconsultaexterna = @IdConsultaExterna 

	/*CAMBIO REALIZADO EL 28NOVIEMBRE2017*/
	--   LOGICA DE COMPONENTES 02/03/2022
	Select @IdTipoOrdenatencion = (CASE
	WHEN @Componente='500101' OR @Componente='500203' OR @Componente='500201' OR @Componente='500204' THEN '11'
		ELSE @IdTipoOrdenatencion
	END)
	--   LOGICA DE COMPONENTES 02/03/2022
	SELECT @IDMedico = (CASE 
		WHEN @Componente='500101' OR @Componente='500203' OR @Componente='500201' OR @Componente='500204'   THEN (SELECT IdEmpleado FROM SG_Agente WHERE CodigoAgente=@Usuario)
	ELSE NULL
	END)

	IF @Componente='500101' OR @Componente='500203' OR @Componente='500201' OR @Componente='500204' -- INTEROPERABILIDAD DE INTERCONSULTA luke 12/03/2020 //   LOGICA DE COMPONENTES 02/03/2022
		BEGIN

			SELECT @IdConsultaExterna = IDConsultaexterna			FROM SS_CE_ConsultaExterna  WITH (NOLOCK)
			WHERE IdOrdenAtencion = @IDordenatencion and Medico=@IDMedico 

			SELECT @SecuencialOrdenMax = ISNULL(MAX(ISNULL(Linea,0)),0) +1 FROM SS_CE_ConsultaExternaOrdenMedica WITH (NOLOCK)
			WHERE Idconsultaexterna = @IdConsultaExterna

			INSERT INTO SS_AD_OrdenAtencionDetalle ( IdOrdenAtencion, Linea, TipoOrdenAtencion, Especialidad, IndicadorDisponible,
			 IdServicio, IdTurno, IdPaciente, TipoComponente, Componente, Cantidad, 
			 CentroCosto, Estado, UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion, IndicadorEPS, 
			 IndicadorHonorarios,Observacion,SECUENCIALHCE,SUCURSAL,Compania,IdPersonaAntUnificacion,TipoInterConsulta,IdEstablecimiento ) --modificar 15 agosto 2019
			 VALUES ( @idordenatencion , @LineaMax, @IdTipoOrdenatencion , @Especialidad ,2,@idservicio,@idturno,@IdPaciente,'C', @Componente , @cantidad,@centrocosto,
			2,@Usuario,GETDATE(),@Usuario,GETDATE(),2,@INDICADORHHMM,UPPER(@Observacion),@SECUENCIALHCE,@sucursal,@compania,null,@IndicadorEPS,@IdEstablecimiento) --modificar 15 AGOSTO 2019

			INSERT INTO SS_CE_ConsultaExternaOrdenMedica ( IdConsultaExterna, Linea, IdOrdenAtencion, LineaOrdenAtencion, TipoOrdenMedica, Componente, IndicadorOrden, 
			Estado, UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion, IndicadorEPS, IdEspecialidad,FechaMotivo,MotivoTransferencia,MedicoResponsable,TipoInterConsulta ) 
			VALUES ( @IdConsultaExterna, @SecuencialOrdenMax, @IDordenatencion,@LineaMax,@IdTipoOrdenatencion,@Componente,2,2,@Usuario,@Fechacreacion,@Usuario,
			GETDATE(),2,@Especialidad,GETDATE(),UPPER(@Observacion),@IDMedico,@IndicadorEPS)
		END

	ELSE
	BEGIN

		if(select count(*) from SS_AD_OrdenAtencion where IdOrdenAtencion=@IDordenatencion and TipoAtencion=2)> 0
			BEGIN

					INSERT INTO SS_AD_OrdenAtencionDetalle ( IdOrdenAtencion, Linea, TipoOrdenAtencion, Especialidad, IndicadorDisponible,
					 IdServicio, IdTurno, IdPaciente, TipoComponente, Componente, Cantidad, 
					 CentroCosto, Estado, UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion, IndicadorEPS,TipoInterConsulta, 
					 IndicadorHonorarios,Observacion,SECUENCIALHCE,SUCURSAL,Compania ) --modificar 15 agosto 2019
					 VALUES ( @idordenatencion , @LineaMax, @IdTipoOrdenatencion , @Especialidad ,2,@idservicio,@idturno,@IdPaciente,'C', @Componente , @cantidad,@centrocosto,
					2,@Usuario,GETDATE(),@Usuario,GETDATE(),2,@indicadorEPS,@INDICADORHHMM,UPPER(@Observacion),@SECUENCIALHCE,@sucursal,@compania) --modificar 15 AGOSTO 2019

				END
		else
			begin
				INSERT INTO SS_AD_OrdenAtencionDetalle ( IdOrdenAtencion, Linea, TipoOrdenAtencion, Especialidad, IndicadorDisponible,
				 IdServicio, IdTurno, IdPaciente, TipoComponente, Componente, Cantidad, 
				 CentroCosto, Estado, UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion, IndicadorEPS, 
				 IndicadorHonorarios,Observacion,SECUENCIALHCE,SUCURSAL,Compania ) --modificar 15 agosto 2019
				 VALUES ( @idordenatencion , @LineaMax, @IdTipoOrdenatencion , @Especialidad ,1,@idservicio,@idturno,@IdPaciente,'C', @Componente , @cantidad,@centrocosto,
				2,@Usuario,GETDATE(),@Usuario,GETDATE(),@indicadorEPS,@INDICADORHHMM,UPPER(@Observacion),@SECUENCIALHCE,@sucursal,@compania) --modificar 15 AGOSTO 2019

			end

		INSERT INTO SS_CE_ConsultaExternaOrdenMedica ( IdConsultaExterna, Linea, IdOrdenAtencion, LineaOrdenAtencion, TipoOrdenMedica, Componente, IndicadorOrden, 
		Estado, UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion, IndicadorEPS, IdEspecialidad,FechaMotivo,MotivoTransferencia,MedicoResponsable,TipoInterConsulta ) 
		VALUES ( @IdConsultaExterna, @SecuencialOrdenMax, @IDordenatencion,@LineaMax,@IdTipoOrdenatencion,@Componente,2,2,@Usuario,@Fechacreacion,@Usuario,
		@Fechacreacion,@IndicadorEPS,@Especialidad,@Fechacreacion,UPPER(@Observacion),@IDMEDICO,1)
		END

   END
  
else
	begin
	
	if  @Componente='500101' OR @Componente='500203' OR @Componente='500201' OR @Componente='500204'-- CAMBIO REALIZADO EL 25 DE Enero 2020  //   LOGICA DE COMPONENTES 02/03/2022
		begin
			UPDATE SS_AD_OrdenAtencionDetalle SET TipoInterConsulta=@IndicadorEPS,Cantidad =@cantidad,Observacion=UPPER(@Observacion),Especialidad=@Especialidad WHERE IdOrdenAtencion = @IDordenatencion and SECUENCIALHCE=@SECUENCIALHCE 
			UPDATE SS_CE_ConsultaExternaOrdenMedica SET MotivoTransferencia=UPPER(@Observacion), TipoInterConsulta=@IndicadorEPS,IdEspecialidad=@Especialidad WHERE IdOrdenAtencion = @IDordenatencion and LineaOrdenAtencion=@IdLinea  
		END
	else
		begin
			UPDATE SS_AD_OrdenAtencionDetalle SET Cantidad =@cantidad,Observacion=UPPER(@Observacion) WHERE IdOrdenAtencion = @IDordenatencion and SECUENCIALHCE=@SECUENCIALHCE 
			UPDATE SS_CE_ConsultaExternaOrdenMedica SET MotivoTransferencia=UPPER(@Observacion) WHERE IdOrdenAtencion = @IDordenatencion and LineaOrdenAtencion=@IdLinea  
		END
END 

GO

CREATE OR ALTER PROCEDURE [dbo].[SP_SS_IT_SaludProcedimientoIngreso]
@UnidadReplicacion		varchar(15),
@IdEpisodioAtencion		int,
@IdPaciente				int,
@EpisodioClinico		int,
@IdOrdenAtencion		Int,
@Linea					int,
@Componente				varchar(25),
@Secuencia				int,
@TipoOrdenatencion		int,
@Cantidad				DECIMAL (20,6),
@IndicadorEPS			int,
@IdMedico				int,
@Especialidad			int,
@IdCita					int,
@Observacion			varchar(200),
@SECUENCIALHCE			VARCHAR(15),
@EstadoDocumento		int=NULL,
@Estado					int=NULL,
@UsuarioCreacion		varchar(25),
@Fechacreacion			datetime

AS
BEGIN
	Declare @ldt_FechaHoy datetime
	Declare @ll_retorno int
	Declare @ls_mensaje varchar(500)

	BEGIN TRAN

	SET @ll_retorno = 0

    BEGIN TRY

			SET @ldt_FechaHoy = GETDATE()

			INSERT INTO SS_IT_SaludProcedimientoIngreso 
				( IdOrdenAtencion,		LineaOrdenAtencionConsulta,		LineaOrdenAtencion,		UnidadReplicacion,		IdEpisodioAtencion,
				IdPaciente,		EpisodioClinico,		Secuencia,			Componente,		Cantidad,
				IndicadorEPS,		Especialidad,	IdMedico,FechaProcedimiento,	IdCita	,EstadoDocumento,
				idtipoordenatencion, Observacion, SecuencialHCE,
				Estado,	UsuarioCreacion,		FechaCreacion,		UsuarioModificacion,	FechaModificacion,
				IndicadorRecepcion,		FechaRecepcion,		IndicadorProcesado,		FechaProcesado		
				) VALUES  
				( @IdOrdenAtencion,	@Linea,	0,	@UnidadReplicacion, @IdEpisodioAtencion, 
				@IdPaciente, @EpisodioClinico, @Secuencia, @Componente,@Cantidad,
				@IndicadorEPS,@Especialidad ,  @IdMedico,  @ldt_FechaHoy ,@IdCita ,@EstadoDocumento,
				@TipoOrdenatencion ,@Observacion,@SECUENCIALHCE ,
				@Estado , @UsuarioCreacion, @Fechacreacion, @UsuarioCreacion, @ldt_FechaHoy,1,@ldt_FechaHoy,1,@ldt_FechaHoy ) 

			EXEC SP_SS_IT_SaludExamenesHCE @IDordenatencion, @IDPaciente, @TipoOrdenatencion, @Componente, @Cantidad, @IndicadorEPS, @Especialidad, @UsuarioCreacion, 
				@ldt_FechaHoy, @Linea, @Observacion, @Linea, @SECUENCIALHCE, @ll_retorno OUT, @ls_mensaje OUT

	END TRY
    BEGIN CATCH
		
		SET @ll_retorno = -1
		SET @ls_mensaje = ERROR_MESSAGE()

    END CATCH


	IF @ll_retorno = 0
	BEGIN
			SET @ll_retorno = 1
		SET @ls_mensaje = 'Correcto'
		COMMIT
	END
	ELSE
	BEGIN
		ROLLBACK
	END

	SELECT  Retorno = @ll_retorno, Mensaje = @ls_mensaje

END 
GO

CREATE OR ALTER PROCEDURE [dbo].[SP_SS_IT_SALUDINDGENRecetaHCE]
@IDordenatencion Int,
@LineaOrdenAtencionConsulta int,
@TipoIndicacion int,
@IDPaciente int,
@descripcion varchar(1500),
@UnidadReplicacion varchar(15),
@FechaCreacion datetime,
@UsuarioCreacion varchar(15),
@IDEPISODIOATENCION int,
@EpisodioClinico int

AS
	BEGIN
		Declare @IdConsultaExterna int

		SELECT @IdConsultaExterna = IDConsultaexterna
		FROM SS_CE_ConsultaExterna WITH(NOLOCK)
		WHERE IdOrdenAtencion = @IDordenatencion

		DELETE FROM SS_CE_CEDetalleIndicacionesGenerales WHERE IdConsultaExterna=@IdConsultaExterna--AÑADIDO 03OCTUBRE2019

		INSERT INTO SS_CE_CEDetalleIndicacionesGenerales 
		( IdConsultaExterna,correlativo,secuencial,TipoIndicacion,Descripcion,Estado,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion
		) 
		VALUES ( @IdConsultaExterna , '1','0','1',RTRIM(LTRIM(@descripcion)),2,@UsuarioCreacion,@FechaCreacion,@UsuarioCreacion,@FechaCreacion
		) 
	END
GO

CREATE OR ALTER PROCEDURE [dbo].[SP_SS_IT_SaludRecetaIndicacionesGENIngreso]
	-- Add the parameters for the stored procedure here
@UnidadReplicacion	varchar(15),
@IdEpisodioAtencion Int=NULL,
@IdPaciente			int=NULL,
@EpisodioClinico	int=NULL,
@IdOrdenAtencion	Int=NULL,
@LINEA				int=NULL,
@TipoIndicacion		Int=NULL,
@Descripcion		varchar(1500),
@Secuencia			Int=NULL,
@Estado				int=NULL,
@UsuarioCreacion	varchar(25),
@Fechacreacion		datetime
AS
BEGIN

	Declare @ldt_FechaHoy datetime
	Declare @ll_retorno int
	Declare @ls_mensaje varchar(500)

	BEGIN TRAN

	SET @ll_retorno = 0

    BEGIN TRY
		IF @ll_retorno = 0
		BEGIN
			SET @ldt_FechaHoy = GETDATE()

			INSERT INTO SS_IT_SaludRecetaIndicacionesGENIngreso 
				( IdOrdenAtencion,		LineaOrdenAtencionConsulta,		TipoIndicacion,		UnidadReplicacion,		IdEpisodioAtencion,
				IdPaciente,		EpisodioClinico,		Secuencia,		Estado,		Descripcion,
						UsuarioCreacion,		FechaCreacion,		UsuarioModificacion,	FechaModificacion,
				IndicadorRecepcion,		FechaRecepcion,		IndicadorProcesado,		FechaProcesado		
				) VALUES  
				( @IdOrdenAtencion,	@LINEA,	@TipoIndicacion,	@UnidadReplicacion, @IdEpisodioAtencion, 
				@IdPaciente, @EpisodioClinico, @Secuencia, @Estado ,@Descripcion, 
				@UsuarioCreacion, @Fechacreacion, @UsuarioCreacion, @ldt_FechaHoy,
				1, @ldt_FechaHoy,1, @ldt_FechaHoy )

			EXEC SP_SS_IT_SALUDINDGENRecetaHCE @IDordenatencion, @LINEA, @TipoIndicacion, @IDPaciente, @descripcion, @UnidadReplicacion, @ldt_FechaHoy, @UsuarioCreacion,
				@IDEPISODIOATENCION, @EpisodioClinico, @ll_retorno OUT, @ls_mensaje OUT
		END
	END TRY
    BEGIN CATCH
		
		SET @ll_retorno = -1
		SET @ls_mensaje = ERROR_MESSAGE()

    END CATCH


	IF @ll_retorno = 0
	BEGIN
			SET @ll_retorno = 1
		SET @ls_mensaje = 'Correcto'
		COMMIT
	END
	ELSE
	BEGIN
		ROLLBACK
	END

	SELECT  Retorno = @ll_retorno, Mensaje = @ls_mensaje
END
GO

CREATE OR ALTER PROCEDURE [dbo].[SP_SS_IT_SALUDRecetaHCE]
@IDordenatencion Int,
@LineaOA int,
@IDPaciente int,
@Componente varchar(25),
@unidadmedida int,
@linea varchar(6),
@Familia varchar(6),
@Subfamilia varchar(6),
@Cantidad decimal(20,6),--varchar(15), --cambio jordan 07/07/2020
@Via int,
@Dosis varchar(15),
@Diastratamiento varchar(15),
@Frecuencia varchar(15),
@IndicadorEPS int,
@Usuario varchar(25),
@Fechacreacion datetime,
@IndicacionEspecifica varchar(500),
@lineamax INT,
@TIPOORDENATENCION INT, --JORDAN HABIA PUESTO ESTO EN NULL PQ?
--MODIFICAR PARA SECUENCIAL
@SECUENCIALHCE VARCHAR(20),
@al_retorno int OUTPUT,
@as_mensaje varchar(500) OUTPUT
AS

Declare @IdConsultaExterna int,@SecuencialRecetaMax int,/*@LineaMax int,*/@nombrecomponente varchar(250),@Sucursal varchar(15),  @Especialidad int, @idservicio int, @correlativo int,
@idprocedimiento int,@SECUENCIALRECETA INT=NULL,@CORRELATIVOINDANT INT=NULL,@LINEAOAINSERT INT,@tipoatencion int

BEGIN TRAN

SET @al_retorno = 0

BEGIN TRY
	SELECT @idservicio = IdServicio FROM SS_GE_ServicioPrestacion WITH (NOLOCK) WHERE COMPONENTE = @Componente
	
	SELECT @Especialidad = ESPECIALIDAD, @tipoatencion = TipoAtencion,@Sucursal = Sucursal  FROM SS_AD_OrdenAtencion WITH (NOLOCK) WHERE IDORDENATENCION = @IDORDENATENCION

	SELECT @nombrecomponente = DescripcionLocal FROM WH_ItemMast WITH (NOLOCK) WHERE ITEM = @COMPONENTE

	DECLARE @VNUN  INT
	SELECT @LINEAOAINSERT=Linea,@VNUN= ISNULL(IndicadorCobrado,1) FROM SS_AD_OrdenAtencionDetalle  WITH (NOLOCK) WHERE IdOrdenAtencion = @IDordenatencion   AND SECUENCIALHCE = @SECUENCIALHCE


	if @TIPOORDENATENCION=1 or @TIPOORDENATENCION=11
	begin

		--PARA MODIFICAR 16092019
		SELECT @IdConsultaExterna = IDConsultaexterna
		FROM SS_CE_ConsultaExterna WITH(NOLOCK)
		WHERE IdOrdenAtencion = @IDordenatencion and LineaOrdenAtencion=@LineaOA

		SELECT @SECUENCIALRECETA = ISNULL(Secuencial,0)
		FROM SS_CE_ConsultaExternaReceta WITH(NOLOCK)
		WHERE IdConsultaExterna=@IdConsultaExterna and LineaOrdenAtencion= @LINEAOAINSERT

		SELECT @CORRELATIVOINDANT = ISNULL(correlativo,5000)
		FROM SS_CE_CEDetalleIndicaciones WITH (NOLOCK)
		WHERE IdConsultaExterna=@IdConsultaExterna AND Secuencial=@SECUENCIALRECETA

		SELECT @correlativo = ISNULL (max(ISNULL(correlativo,0)),0) +1
		FROM SS_CE_CEDetalleIndicaciones WITH (NOLOCK) WHERE IdConsultaExterna=@IdConsultaExterna

		SELECT @SecuencialRecetaMax = ISNULL(MAX(ISNULL(Secuencial,0)),0) +1
		FROM SS_CE_ConsultaExternaReceta WITH (NOLOCK) WHERE Idconsultaexterna = @IdConsultaExterna

		SELECT @lineamax = ISNULL(MAX(ISNULL(Linea,0)),0) +1
		FROM SS_AD_OrdenAtencionDetalle WITH (NOLOCK) WHERE IdOrdenAtencion = @IDordenatencion

		PRINT 'LLEGO 1'
		IF @LINEAOAINSERT IS NULL OR @LINEAOAINSERT = 0
		BEGIN
			INSERT INTO SS_AD_OrdenAtencionDetalle
			( IdOrdenAtencion , Linea , TipoOrdenAtencion, Especialidad , IdServicio , IdTurno , IdPaciente , TipoComponente ,
			Componente , IdUnidadMedida , LineaFamilia , Familia , SubFamilia , Cantidad , Estado , UsuarioCreacion , FechaCreacion , IndicadorEPS , TipoReceta ,
			Observacion ,  IdEstablecimiento,Compania,Sucursal,IndicadorCoberturado,SECUENCIALHCE,flg_SEGUIMIENTO )
			VALUES ( @idordenatencion , @LineaMax, '13' , @Especialidad ,@idservicio,'1',@IdPaciente,'A' , @Componente ,
			@unidadMedida,@linea,@familia,@subfamilia,@cantidad,2,@Usuario,@fechacreacion,@indicadorEPS,case when @tipoatencion = 2 then 1 else 2 end ,@NombreComponente,1,'00000000',@Sucursal,2,@SECUENCIALHCE,'HCE')

		
		PRINT 'LLEGO 2'

			INSERT INTO SS_CE_ConsultaExternaReceta ( IdConsultaExterna , Secuencial , TipoComponente , Componente , Linea ,
			Familia , SubFamilia , UnidadMedida , IdOrdenAtencion , LineaOrdenAtencion , Cantidad , Forma , Via , Dosis ,
			DiasTratamiento , Frecuencia , Comentario , IndicadorAuditoria , UsuarioAuditoria , FechaAutorizacion , Estado ,
			UsuarioCreacion , FechaCreacion ,FechaModificacion,UsuarioModificacion, IndicadorEPS , TipoReceta )
			VALUES ( @IdConsultaExterna, @SecuencialRecetaMax , 'A' , @Componente , @linea , @Familia ,
			@Subfamilia , @unidadmedida , @IDordenatencion , @LineaMax , @Cantidad , null , @Via , @Dosis ,
			 @Diastratamiento , @Frecuencia , @nombrecomponente, null , null , null , 2 , @Usuario , @Fechacreacion , @Fechacreacion,@Usuario, @IndicadorEPS , case when @tipoatencion = 2 then 1 else 2 end  )

		 		PRINT 'LLEGO 3'
			INSERT INTO SS_CE_CEDetalleIndicaciones ( IdConsultaExterna, Secuencial, Correlativo, TipoIndicacion, Descripcion, Estado,
			UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion )
			VALUES ( @IdConsultaExterna, @SecuencialRecetaMax, @correlativo, 1, @indicacionEspecifica, 2, @Usuario, @Fechacreacion, @Usuario,
			@Fechacreacion )
		END

		IF @LINEAOAINSERT > 0
		BEGIN
			UPDATE SS_AD_OrdenAtencionDetalle 
			SET	TipoOrdenAtencion = 13, 
				Especialidad = @Especialidad, 
				IdServicio = @idservicio, 
				IdTurno = 1, 
				IdPaciente = @IdPaciente, 
				TipoComponente = 'A', 
				IdUnidadMedida = @unidadMedida, 
				LineaFamilia = @linea, 
				Familia = @familia, 
				SubFamilia = @subfamilia, 
				Cantidad = @cantidad, 
				Estado = 2, 
				UsuarioCreacion = @Usuario, 
				FechaCreacion = @fechacreacion, 
				IndicadorEPS = @indicadorEPS, 
				TipoReceta = case when @tipoatencion = 2 then 1 else 2 end, 
				Observacion = @NombreComponente,  
				IdEstablecimiento = 1,
				Compania = '00000000',
				Sucursal = @Sucursal,
				IndicadorCoberturado = 2,
				SECUENCIALHCE = @SECUENCIALHCE
			FROM SS_AD_OrdenAtencionDetalle
			WHERE IdOrdenAtencion = @idordenatencion
			AND SECUENCIALHCE = @SECUENCIALHCE
			AND ISNULL(IndicadorCobrado,0) <> 2

			UPDATE SS_CE_ConsultaExternaReceta
			SET	TipoComponente = 'A', 
				Componente = @Componente, 
				Linea = @linea, 
				Familia = @Familia, 
				SubFamilia = @Subfamilia, 
				UnidadMedida = @unidadmedida, 
				Cantidad = @Cantidad, 
				Forma = NULL, 
				Via = @Via, 
				Dosis = @Dosis, 
				DiasTratamiento = @Diastratamiento,
				Frecuencia = @Frecuencia, 
				Comentario = @nombrecomponente, 
				IndicadorAuditoria = NULL, 
				UsuarioAuditoria = NULL, 
				FechaAutorizacion = NULL, 
				Estado = 2, 
				UsuarioCreacion = @Usuario, 
				FechaCreacion = @Fechacreacion,
				FechaModificacion = @Fechacreacion,
				UsuarioModificacion = @Usuario, 
				IndicadorEPS = @IndicadorEPS, 
				TipoReceta = case when @tipoatencion = 2 then 1 else 2 end
			FROM SS_CE_ConsultaExternaReceta
			WHERE IdConsultaExterna = @IdConsultaExterna
			AND  Secuencial=@SECUENCIALRECETA

			UPDATE SS_CE_CEDetalleIndicaciones
			SET	Secuencial = @SECUENCIALRECETA, 
				TipoIndicacion = 1,
				Descripcion = @indicacionEspecifica, 
				Estado = 2,
				UsuarioCreacion = @Usuario, 
				FechaCreacion = @Fechacreacion, 
				UsuarioModificacion = @Usuario, 
				FechaModificacion = @Fechacreacion
			FROM SS_CE_CEDetalleIndicaciones
			WHERE IdConsultaExterna = @IdConsultaExterna 
			AND Correlativo = @CORRELATIVOINDANT		
		END
	end 

	else
	begin

	SELECT @IDPROCEDIMIENTO= SS_PR_Procedimiento.IdProcedimiento
	FROM SS_PR_Procedimiento WITH(NOLOCK)
	WHERE SS_PR_Procedimiento.IdOrdenAtencion=@IDordenatencion AND SS_PR_Procedimiento.LineaOrdenAtencion=@LineaOA


	DELETE FROM SS_AD_OrdenAtencionDetalle  WHERE IdOrdenAtencion   = @IDordenatencion   AND SECUENCIALHCE = @SECUENCIALHCE
	DELETE FROM SS_PR_ProcedimientoDetalle where IdOrdenAtencion=@IDordenatencion and LineaOrdenAtencion=@LINEAOAINSERT

	SELECT @lineamax = ISNULL(MAX(ISNULL(Linea,0)),0) +1
	FROM SS_AD_OrdenAtencionDetalle WITH (NOLOCK) WHERE IdOrdenAtencion = @IDordenatencion


	INSERT INTO SS_AD_OrdenAtencionDetalle ( IdOrdenAtencion , Linea , Especialidad , IdServicio ,
	IdTurno , IdPaciente , TipoComponente , Componente , TipoOrdenAtencion , IdUnidadMedida , Cantidad ,
	CantidadPresupuestada , CantidadSolicitada , Estado , UsuarioCreacion , FechaCreacion , Observacion ,
	CentroCosto , IndicadorEPS , IndicadorSeCobra , IndicadorHonorarios , UsuarioModificacion , FechaModificacion ,
	TipoReceta , IndicadorDisponible , AlmacenDestino , LoteComponente,SECUENCIALHCE,Sucursal ) VALUES
	( @IDordenatencion , @lineamax ,@Especialidad , 0 , 2 , @IDPaciente, 'A' , @Componente , 13 ,
	@unidadmedida ,@Cantidad ,@Cantidad , @Cantidad , 2 ,@Usuario , @Fechacreacion , '' ,  '' , @IndicadorEPS ,
	 null , 1 ,@Usuario ,@Fechacreacion,   2 , null , '1011' ,'',@SECUENCIALHCE,@Sucursal)

	SELECT @correlativo = ISNULL (max(ISNULL(Secuencial,0)),0) +1
	FROM SS_PR_ProcedimientoDetalle WITH (NOLOCK)
	WHERE IdProcedimiento=@IDPROCEDIMIENTO

	INSERT INTO SS_PR_ProcedimientoDetalle ( IdProcedimiento , Secuencial , IdMaestroProcedimiento , SecuencialProcedimiento , IdOrdenAtencion ,
	LineaOrdenAtencion , IndicadorRecursoFijo , TipoRecurso , TipoRegistro , Situacion , TipoComponente , Componente , LineaFamilia , Familia , SubFamilia ,
	UnidadMedida , Cantidad , CantidadEjecutada , Dosis , Profesion , Especialidad , Medico , TipoColegiatura , NumeroColegiatura , Equipo , IndicadorCobrar ,
	TipoCobro , IndicadorIncluido , UnidadMedidaTiempo , Tiempo , Descripcion , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ,
	IndicadorGenerico , MontoGenerico , TipoReceta ) VALUES ( @IDPROCEDIMIENTO , @correlativo , 0 , null ,  @IDordenatencion , @lineamax,null , '1' , 'M' , null , 'A' ,
	@Componente   , @linea , @Familia , @Subfamilia , @unidadmedida , @Cantidad , @Cantidad , null , null , null , null , null , null , null , null , null , null , null , null , null ,
	2 ,@Usuario , @Fechacreacion , @Usuario , @Fechacreacion , null , null , 2 )

	END
END TRY
BEGIN CATCH

	SET @al_retorno = -1
	SET @as_mensaje = ERROR_MESSAGE()

END CATCH


IF @al_retorno = 0
BEGIN
	COMMIT
END
ELSE
BEGIN
	ROLLBACK
END
GO

CREATE OR ALTER PROCEDURE [dbo].[SP_SS_IT_SaludRecetaIngreso]
@UnidadReplicacion		VARCHAR(15)=null,
@IdEpisodioAtencion		int=null,
@IdPaciente				int=null,
@EpisodioClinico		int=null,
@IdOrdenAtencion		Int=null,
@LineaOrdenAtencion		int=null,
@Secuencia				int=null,
@Componente				VARCHAR(25)=null,
@SubFamilia				VARCHAR(6)=null,
@Familia				VARCHAR(6)=null,
@Linea					VARCHAR(6)=null,
@UnidadMedida			int=null,
@Cantidad				decimal(20,6)=null,		
@Via					VARCHAR(15)=null,
@Dosis					VARCHAR(150)=null,
@Diastratamiento		VARCHAR(15)=null,
@Frecuencia				VARCHAR(15)=null,
@IndicadorEPS			int=null,
@TipoReceta				int=null,
@IndicacionEspecifica	VARCHAR(500)=null,
@TipoOrdenAtencion		INT=null, 
@SECUENCIALHCE			VARCHAR(20)=null,
@Estado					int=NULL,
@UsuarioCreacion		varchar(25)=null,
@Fechacreacion			datetime=null

AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @Error INT
	Declare @ll_retorno int
	Declare @ls_mensaje varchar(500)


	BEGIN TRAN

	SET @ll_retorno = 0

    BEGIN TRY
		INSERT INTO SS_IT_SaludRecetaIngreso 
		( UnidadReplicacion, IdEpisodioAtencion, IdPaciente,EpisodioClinico, 
			Secuencia,IdOrdenAtencion,LineaOrdenAtencionConsulta,Componente,
			SubFamilia,Familia,Linea,UnidadMedida,Cantidad,Via,Dosis,DiasTratamiento,
			Frecuencia, IndicadorEPS,TipoReceta,indicacionespecifica,TipoOrdenAtencion,SecuencialHCE,
			Estado,	UsuarioCreacion,		FechaCreacion,		UsuarioModificacion,	FechaModificacion,
			IndicadorRecepcion,		FechaRecepcion,		IndicadorProcesado,		FechaProcesado	
		) VALUES  
		( 	@UnidadReplicacion, @IdEpisodioAtencion, 	@IdPaciente, @EpisodioClinico,
			@Secuencia, @IdOrdenAtencion,	@LineaOrdenAtencion,@Componente,
			@SubFamilia,@Familia,@Linea,@UnidadMedida,@Cantidad,@Via,@Dosis,@DiasTratamiento,
			@Frecuencia, @IndicadorEPS,@TipoReceta,@indicacionespecifica,@TipoOrdenAtencion,@SecuencialHCE,
			@Estado , @UsuarioCreacion, @Fechacreacion, @UsuarioCreacion, GETDATE(),1,GETDATE(),1,GETDATE() ) 
	
		EXEC SP_SS_IT_SALUDRecetaHCE @IDordenatencion,@LineaOrdenAtencion ,@IDPaciente ,@Componente ,@unidadmedida ,@linea ,@Familia ,@Subfamilia ,@Cantidad, @Via, @Dosis, @Diastratamiento,@Frecuencia ,@IndicadorEPS ,@UsuarioCreacion ,@Fechacreacion ,@IndicacionEspecifica,0,@TipoOrdenAtencion,@SECUENCIALHCE, @ll_retorno OUT, @ls_mensaje OUT
    END TRY
    BEGIN CATCH
		
		SET @ll_retorno = -1
		SET @ls_mensaje = ERROR_MESSAGE()

    END CATCH


	IF @ll_retorno = 0
	BEGIN
		COMMIT
		SET @ll_retorno = 1
		SET @ls_mensaje = 'Correcto'
	END
	ELSE
	BEGIN
		ROLLBACK
		BEGIN TRANSACTION
		SET @ll_retorno = 0
		SET @ls_mensaje = 'Error :: ' + @ls_mensaje

		COMMIT TRANSACTION
	END

	SELECT Retorno = @ll_retorno, Mensaje = @ls_mensaje
END


GO





