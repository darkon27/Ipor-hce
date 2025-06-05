GO

ALTER PROCEDURE [dbo].[SP_SS_IT_SALUDAnamnesisInFormeMedico]
@IDordenatencion Int=null,
@IdPaciente int=null,
@IdLineaOa int=null,
@Secuencia int=null,
@InformeMedico varchar(8000),
@Estado int=null,
@UsuarioCreacion varchar(25),
@FechaCreacion datetime=null,
@ExamenClinico varchar(8000),
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

				Declare @IdConsultaExterna INT,@IdInformeMax INT,
				@IDINFORMEACTUAL INT, 
				@tipoatencion INT,
				@plantilla INT,
				@tipoconsulta INT

				if (len(@InformeMedico)>0)
				BEGIN

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

							
						END	
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

ALTER PROCEDURE [dbo].[SP_SS_IT_SALUDAnamnesisIngreso]
	@IDordenatencion Int,
	@IdPaciente int,
	--PARA MODIFICAR 28 AGOSTO 2019
	@IdLineaOa int,
	--CIERRE MODIFICAR
	@Secuencia int,
	@TiempoEnfermedad varchar(50),
	@RelatoCronologico varchar(8000),
	@PresionArterialMS1 varchar(50),
	@PresionArterialMS2 varchar(50),
	@FrecuenciaCardiaca varchar(50),
	@FrecuenciaRespiratoria varchar(50),
	@Temperatura numeric(20,6),
	@SaturacionOxigeno VARCHAR(50),
	@Peso varchar(50),
	@Talla varchar(50),
	@Estado int,
	@UsuarioCreacion varchar(25),
	@FechaCreacion datetime,
	@ExamenClinico varchar(8000),
	@UsuarioModificacion varchar(25),
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
	@IDESPECIALIDADOF INT,

	--MODIFICAR PARA RELEVO 20210111
	@tipoatencion INT,
	@plantilla int,
	@tipoconsulta int


	BEGIN TRAN

	SET @al_retorno = 0

	BEGIN TRY
		IF @al_retorno = 0
		BEGIN
			SELECT @IdConsultaExterna = SS_CE_ConsultaExterna.IDConsultaexterna
			FROM SS_CE_ConsultaExterna
			WHERE SS_CE_ConsultaExterna.IdOrdenAtencion = @IDordenatencion
			AND SS_CE_ConsultaExterna.LineaOrdenAtencion = @IdLineaOa
			--MODIFICAR 28 AGOSTO 2019
		END

	--IdPlantilla = 29

		IF @al_retorno = 0
		BEGIN
			IF ( SELECT  COUNT (1) FROM SS_CE_ConsultaExterna
			WHERE SS_CE_ConsultaExterna.IdConsultaExterna=@IdConsultaExterna AND SS_CE_ConsultaExterna.Especialidad<>22/*OFTALMOLOGIA*/)> 0
			BEGIN
				SELECT @tipoconsulta  = SS_CE_ConsultaExterna.TipoConsulta
				FROM SS_CE_ConsultaExterna
				WHERE SS_CE_ConsultaExterna.IdOrdenAtencion = @IDordenatencion
				AND SS_CE_ConsultaExterna.LineaOrdenAtencion = @IdLineaOa

				select @tipoatencion   = SS_AD_OrdenAtencion.TipoAtencion
				from SS_AD_OrdenAtencion where IdOrdenAtencion=@IDordenatencion

				SELECT @IDINFORMEACTUAL = ISNULL(SS_CE_Informe.IdInforme,0)
				FROM SS_CE_Informe WHERE SS_CE_INFORME.IdConsultaExterna=@IdConsultaExterna AND TipoInforme='CE'

				DELETE SS_CE_InformeDetalle WHERE IdInforme = @IDINFORMEACTUAL 	 
				DELETE SS_CE_Informe WHERE IdInforme = @IDINFORMEACTUAL AND TipoInforme='CE'
		
				SELECT @IdInformeMax = MAX(SS_CE_Informe.IdInforme) +1
				FROM SS_CE_Informe 

					if( @IdLineaOa > 1 and @tipoconsulta=4) --INTERCONSULTA
					begin
						set @plantilla=55
						--55 / IDCONCEPTO = 655
						INSERT INTO SS_CE_Informe ( IdInforme , IdConsultaExterna , IdPlantilla , FechaInforme , TipoInforme , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) -- SE REALIZO EL CAMBIO DEL 29 AL 58 POR EL INCIDENTE DE LA TABLA INFORME 16-11-2020
						VALUES ( @IdInformeMax , @IdConsultaExterna , @plantilla , @FechaCreacion , 'CE' , 2 , @UsuarioCreacion , @FechaCreacion,@UsuarioModificacion,@FechaModificacion) 

						INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
								VALUES ( @IdInformeMax , 1 , 655 , @plantilla , 1 , 0 , @RelatoCronologico , null , 2 ,@UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaModificacion)
						end
					else if(@tipoatencion=2 and @IdLineaOa > 1 and @tipoconsulta=2) --RELEVO
						begin
						--IF @tipoatencion=1
						--	begin
								set @plantilla=56
						--	end
						--ELSE
						--	begin
						--		set @plantilla=58
						--	end	


						INSERT INTO SS_CE_Informe ( IdInforme , IdConsultaExterna , IdPlantilla , FechaInforme , TipoInforme , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) -- SE REALIZO EL CAMBIO DEL 29 AL 58 POR EL INCIDENTE DE LA TABLA INFORME 16-11-2020
						VALUES ( @IdInformeMax , @IdConsultaExterna , @plantilla , @FechaCreacion , 'CE' , 2 , @UsuarioCreacion , @FechaCreacion,@UsuarioModificacion,@FechaModificacion) 

						INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
								VALUES ( @IdInformeMax , 1 , 656 , @plantilla , 1 , 0 , @RelatoCronologico , null , 2 ,@UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaModificacion)
						end

					else if(@tipoconsulta =3 and @IdLineaOa > 1 and @tipoatencion=2) --REINGRESO
					begin

						set @plantilla=58

						INSERT INTO SS_CE_Informe ( IdInforme , IdConsultaExterna , IdPlantilla , FechaInforme , TipoInforme , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) -- SE REALIZO EL CAMBIO DEL 29 AL 58 POR EL INCIDENTE DE LA TABLA INFORME 16-11-2020
							VALUES ( @IdInformeMax , @IdConsultaExterna , @plantilla , @FechaCreacion , 'CE' , 2 , @UsuarioCreacion , @FechaCreacion,@UsuarioModificacion,@FechaModificacion) 

							INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
							VALUES ( @IdInformeMax , 1 , 1 , @plantilla , 1 , 0 , @TiempoEnfermedad , null , 2 , @UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaModificacion)

							INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
							VALUES ( @IdInformeMax , 2 , 2 , @plantilla , 2 , 0 , @RelatoCronologico , null , 2 ,@UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaModificacion)

							INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
							VALUES ( @IdInformeMax , 3 , 332 , @plantilla , 3 , 0 , @SaturacionOxigeno , null , 2 ,@UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaModificacion) 

							INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
							VALUES ( @IdInformeMax , 4 , 4 , @plantilla , 4 , 0 , @PresionArterialMS1 , null , 2 , @UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaModificacion)

							INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
							VALUES ( @IdInformeMax , 5 , 142 , @plantilla , 5 , 0 , @PresionArterialMS2, null , 2 , @UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaModificacion)

							INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
							VALUES ( @IdInformeMax , 6 , 5 , @plantilla , 6 , 0 , @FrecuenciaCardiaca , null , 2 , @UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaModificacion)

							INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
							VALUES ( @IdInformeMax , 7 , 6 , @plantilla , 7 , 0 ,  @FrecuenciaRespiratoria, null , 2 , @UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaModificacion)

							INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion )
							VALUES ( @IdInformeMax , 8 , 7 , @plantilla , 8 , 0 , @Peso , null , 2 , @UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaModificacion)

							INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion )
							VALUES ( @IdInformeMax , 9 , 8 , @plantilla , 9 , 0 , @Talla , null , 2 , @UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaModificacion)

							INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
							VALUES ( @IdInformeMax , 10 , 9 , @plantilla , 10 , @temperatura , '' , null , 2 , @UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaModificacion)

							INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
							VALUES ( @IdInformeMax ,  11 , 10 , @plantilla , 11 , 0 , @ExamenClinico ,  null , 2  , @UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaModificacion)

					end

					else --CONSULTA EMERGENCIA / AMBULATORIO / HOSPITALIZACIÓN
					begin

						if @tipoatencion=1
							begin
								set @plantilla=29
							end
						ELSE
							begin
								set @plantilla=58
							end	

						INSERT INTO SS_CE_Informe ( IdInforme , IdConsultaExterna , IdPlantilla , FechaInforme , TipoInforme , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) -- SE REALIZO EL CAMBIO DEL 29 AL 58 POR EL INCIDENTE DE LA TABLA INFORME 16-11-2020
							VALUES ( @IdInformeMax , @IdConsultaExterna , @plantilla , @FechaCreacion , 'CE' , 2 , @UsuarioCreacion , @FechaCreacion,@UsuarioModificacion,@FechaModificacion) 

							INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
							VALUES ( @IdInformeMax , 1 , 1 , @plantilla , 1 , 0 , @TiempoEnfermedad , null , 2 , @UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaModificacion)

							INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
							VALUES ( @IdInformeMax , 2 , 2 , @plantilla , 2 , 0 , @RelatoCronologico , null , 2 ,@UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaModificacion)

									INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
							VALUES ( @IdInformeMax , 3 , 5 , @plantilla , 3 , 0 , @FrecuenciaCardiaca , null , 2 , @UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaModificacion)



							INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
							VALUES ( @IdInformeMax , 4 , 4 , @plantilla , 4 , 0 , @PresionArterialMS1 , null , 2 , @UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaModificacion)

							INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
							VALUES ( @IdInformeMax , 5 , 142 , @plantilla , 5 , 0 , @PresionArterialMS2, null , 2 , @UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaModificacion)

									INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
							VALUES ( @IdInformeMax , 6 , 332 , @plantilla , 6 , 0 , @SaturacionOxigeno , null , 2 ,@UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaModificacion) 

							INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
							VALUES ( @IdInformeMax , 7 , 6 , @plantilla , 7 , 0 ,  @FrecuenciaRespiratoria, null , 2 , @UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaModificacion)

							INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion )
							VALUES ( @IdInformeMax , 8 , 7 , @plantilla , 8 , 0 , @Peso , null , 2 , @UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaModificacion)

							INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion )
							VALUES ( @IdInformeMax , 9 , 8 , @plantilla , 9 , 0 , @Talla , null , 2 , @UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaModificacion)

							INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
							VALUES ( @IdInformeMax , 10 , 9 , @plantilla , 10 , @temperatura , '' , null , 2 , @UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaModificacion)

							INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
							VALUES ( @IdInformeMax ,  11 , 10 , @plantilla , 11 , 0 , @ExamenClinico ,  null , 2  , @UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaModificacion)

					END	
			END
			ELSE
			BEGIN
				SELECT COUNT (1) FROM SS_CE_Informe WHERE IdInforme=@IDINFORMEACTUAL
			END

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
END
GO
