GO

--ALTER TABLE SS_PR_Procedimiento ADD IndicadorAlertaVerInforme INT NULL
 

GO
ALTER PROCEDURE [dbo].[SP_SS_IT_SPRINGDiagnosticosConsultaExterna]

@IDordenatencion Int,
@IdDiagnostico Int,
@UnidadReplicacion Varchar(15),
@IDPaciente int,
@Usuario varchar(25),
@Fechacreacion datetime,
@Determinacion varchar(2),
@LINEA int,
@tipoordenatencion int,
@observaciondiagnostico varchar(200), --modificado para obvservacion 110202020
@tipoIT varchar(5),
@al_retorno int OUTPUT,
@as_mensaje varchar(500) OUTPUT
AS
 --MODIFICADO
BEGIN
 --FIN MODIFICADO
	Declare @IdConsultaExterna int,
	--MODIFICADO
		@IdProcedimiento int,
		@SecuenciaMax int,
		@Determinacon char(1),
		@contador int

	SET @al_retorno = 0

	BEGIN TRAN

	BEGIN TRY
		IF @TipoOrdenAtencion=1 or @TipoOrdenAtencion=11
		BEGIN
			 --FIN MODIFICADO
	--		 LOS IF INTERNOS SON MODIFICACION 11022020
			IF (@tipoIT='N' OR @tipoIT='M')
			BEGIN
				SELECT @IdConsultaExterna = IDConsultaexterna
				FROM SS_CE_ConsultaExterna
				WHERE IdOrdenAtencion = @IDordenatencion and LineaOrdenAtencion=@linea

				DELETE FROM SS_CE_ConsultaExternaDiagnostico WHERE IDConsultaexterna=@IdConsultaExterna
				and IdDiagnostico=@IdDiagnostico

				INSERT INTO SS_CE_ConsultaExternaDiagnostico 
				( IdConsultaExterna, iddiagnostico, tipodiagnostico, estado, UsuarioCreacion, FechaCreacion, 
				UsuarioModificacion, FechaModificacion, TipoAntecedente, IndicadorAntecedente,DetalleDiagnostico,Secuencial ) VALUES  --modificado para obvservacion 110202020
				(@IdConsultaExterna, @IdDiagnostico, @Determinacion, 2, @Usuario, @Fechacreacion,  @Usuario, @Fechacreacion, 'C', 1 ,@observaciondiagnostico,@IDPaciente) --modificado para obvservacion 110202020
			 END
		
			IF @tipoIT='D'
			BEGIN
				SELECT @IdConsultaExterna = IDConsultaexterna
				FROM SS_CE_ConsultaExterna
				WHERE IdOrdenAtencion = @IDordenatencion and LineaOrdenAtencion=@linea

				DELETE FROM SS_CE_ConsultaExternaDiagnostico WHERE IDConsultaexterna=@IdConsultaExterna
					and iddiagnostico=@IdDiagnostico
			END
	--MODIFICADO
		END
		ELSE 
		BEGIN
			IF (@tipoIT='N' OR @tipoIT='M' OR @tipoIT='' OR @tipoIT=NULL)
			BEGIN 
				SELECT @IDPROCEDIMIENTO= SS_PR_Procedimiento.IdProcedimiento
				FROM SS_PR_Procedimiento WITH(NOLOCK) 
				WHERE SS_PR_Procedimiento.IdOrdenAtencion=@IDordenatencion AND SS_PR_Procedimiento.LineaOrdenAtencion=@LINEA


				/* CAMBIO REALIZADO EL 19 Septiembre 2019 */
				DELETE FROM SS_PR_ProcedimientoDiagnostico where IdProcedimiento =@IDPROCEDIMIENTO and IdDiagnostico=@IdDiagnostico

				--SE CAMBIO PARA QUE SIEMPR SEA PRESUNTIVO ESTE TIPO DE DIAGNOSTICO 20022020
				INSERT INTO SS_PR_ProcedimientoDiagnostico ( IdProcedimiento, IdDiagnostico, TipoDiagnostico, Estado,
					UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion, Secuencial,Observacion )  --modificado para obvservacion 110202020
					VALUES ( @IdProcedimiento, @IdDiagnostico, @Determinacion/* @Determinacion*/, 2, @Usuario, @Fechacreacion, @Usuario, 
					@Fechacreacion, @IDPaciente,@observaciondiagnostico ) --modificado para obvservacion 110202020
			END

			IF (@tipoIT ='D')
			BEGIN
				SELECT @IDPROCEDIMIENTO= SS_PR_Procedimiento.IdProcedimiento
				FROM SS_PR_Procedimiento WITH(NOLOCK) 
				WHERE SS_PR_Procedimiento.IdOrdenAtencion=@IDordenatencion AND SS_PR_Procedimiento.LineaOrdenAtencion=@LINEA

				/* CAMBIO REALIZADO EL 19 Septiembre 2019 */
				DELETE FROM SS_PR_ProcedimientoDiagnostico where IdProcedimiento =@IDPROCEDIMIENTO and IdDiagnostico=@IdDiagnostico
			END

		END
		--FIN MODIFICADO
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

ALTER PROCEDURE [dbo].[SP_SS_IT_SPRINGinformeHCE]
@IDordenatencion Int,
@UnidadReplicacion Varchar(15),
@IDPaciente int,
@Usuario varchar(25),
@Fechacreacion datetime,
@LINEA int,
@INFORME varchar(8000),
@al_retorno int OUTPUT,
@as_mensaje varchar(500) OUTPUT
AS

BEGIN TRAN

SET @al_retorno = 0

BEGIN TRY
	Declare @IDPROCEDIMIENTO int,
	@IDInforme int
	SELECT @IDPROCEDIMIENTO = IDPROCEDIMIENTO
	FROM SS_PR_Procedimiento WITH(NOLOCK)
	WHERE IdOrdenAtencion = @IDordenatencion and LineaOrdenAtencion=@linea

	select @IDInforme=IdInforme
	from SS_PR_Informe WITH(NOLOCK) WHERE IdProcedimiento=@IDPROCEDIMIENTO

	delete SS_PR_InformeDetalle where IdInforme=@IDInforme
	delete SS_PR_Informe where  IdInforme=@IDInforme


	SELECT @IDInforme=MAX(IDINFORME)+1
	FROM SS_PR_Informe WITH(NOLOCK)

	INSERT INTO SS_PR_Informe ( IdInforme , IdProcedimiento , IdPlantilla , FechaInforme , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , 
	FechaModificacion ) VALUES 
	( @IDInforme , @IDPROCEDIMIENTO , 40 , @Fechacreacion , 2 , @Usuario ,@Fechacreacion , @Usuario , @Fechacreacion ) 


	INSERT INTO SS_PR_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , 
	Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) VALUES ( @IDInforme , 1 , 10 , 40 , 1 , 0 , @INFORME ,
	getdate(), 2 , @Usuario , @Fechacreacion, @Usuario , @Fechacreacion)
 
	update SS_PR_Procedimiento SET IndicadorInforme =2 WHERE IdProcedimiento =@IDPROCEDIMIENTO 

	-- update SS_PR_Procedimiento SET IndicadorAlertaVerInforme =2 FROM SS_PR_Procedimiento WHERE SS_PR_Procedimiento.IdProcedimiento =@IDPROCEDIMIENTO
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

ALTER PROCEDURE [dbo].[SP_SS_IT_SPRINGRUTAHCE]
@IDordenatencion Int,
@UnidadReplicacion Varchar(15),
@IDPaciente int,
@Usuario varchar(25),
@Fechacreacion datetime,
@LINEA int,
@INFORMERUTA varchar(250),
@OBSERVACION VARCHAR(250),
@al_retorno int OUTPUT,
@as_mensaje varchar(500) OUTPUT
AS
Declare @IDPROCEDIMIENTO int,
@IDInforme int


BEGIN TRAN

SET @al_retorno = 0

BEGIN TRY
	SELECT @IDPROCEDIMIENTO = IDPROCEDIMIENTO	FROM SS_PR_Procedimiento WITH(NOLOCK) WHERE IdOrdenAtencion = @IDordenatencion and LineaOrdenAtencion=@linea

	SELECT @IDInforme=ISNULL(MAX(IDINFORME),0)+1	FROM SS_PR_ProcedimientoInforme WITH(NOLOCK) WHERE IdProcedimiento=@IDPROCEDIMIENTO

	INSERT INTO SS_PR_ProcedimientoInforme ( IdProcedimiento, IdInforme, Nombre, RutaInforme, Estado, UsuarioCreacion, FechaCreacion,
	 UsuarioModificacion, FechaModificacion ) VALUES ( @IDPROCEDIMIENTO, @IDInforme, @OBSERVACION, @INFORMERUTA, 2, @Usuario, @Fechacreacion, 
	 @Usuario, @Fechacreacion ) 

	update SS_PR_Procedimiento SET IndicadorInforme =2 WHERE IdProcedimiento =@IDPROCEDIMIENTO
	

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
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_SS_IT_SALUDOFTALMOLOGICOIngreso]
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

			----MODIFICAR 28 AGOSTO 2019
			--AND SS_CE_ConsultaExterna.LineaOrdenAtencion = @LineaOrdenAtencion
		
		IF ( SELECT  COUNT (*) FROM SS_CE_ConsultaExterna	WHERE SS_CE_ConsultaExterna.IdConsultaExterna=@IdConsultaExterna  )> 0

		BEGIN

		--	CIERRE MODIFICAR 20191709
			DECLARE @TiempoEnfermedad INT
			DECLARE @TiempoEnfermedadUnidad INT
			DECLARE @descripcion VARCHAR(30) 
			DECLARE @resultado VARCHAR(30) 

 			SELECT  @resultado =CAST(SS_HC_EnfermedadActual_FE.TiempoEnfermedad AS VARCHAR(10))  + ' '+ GE_Varios.Descripcion 
			FROM LEPSA_WEB_ERPSALUD_CSB_QA.dbo.SS_HC_EpisodioAtencion AS SS_HC_EpisodioAtencion
			INNER JOIN  LEPSA_WEB_ERPSALUD_CSB_QA.dbo.SS_HC_EnfermedadActual_FE AS SS_HC_EnfermedadActual_FE ON SS_HC_EpisodioAtencion.UnidadReplicacion = SS_HC_EnfermedadActual_FE.UnidadReplicacion
			AND SS_HC_EpisodioAtencion.IdPaciente = SS_HC_EnfermedadActual_FE.IdPaciente
			AND SS_HC_EpisodioAtencion.EpisodioClinico = SS_HC_EnfermedadActual_FE.EpisodioClinico
			AND SS_HC_EpisodioAtencion.IdEpisodioAtencion = SS_HC_EnfermedadActual_FE.IdEpisodioAtencion
			INNER JOIN  LEPSA_WEB_ERPSALUD_CSB_QA.dbo.GE_Varios AS GE_Varios  ON  GE_Varios.CodigoTabla = 'TIEMPOENFERMED' AND GE_Varios.Secuencial =SS_HC_EnfermedadActual_FE.TiempoEnfermedadUnidad 
			WHERE SS_HC_EpisodioAtencion.idOrdenAtencion =  @IDordenatencion


			
			SELECT @IDINFORMEACTUAL = ISNULL(SS_CE_Informe.IdInforme,0)
			FROM SS_CE_Informe WHERE SS_CE_INFORME.IdConsultaExterna=@IdConsultaExterna  AND TipoInforme='CE' AND IdPlantilla=62

			DELETE SS_CE_InformeDetalle WHERE IdInforme = @IDINFORMEACTUAL 	   AND IdPlantilla=62
			DELETE SS_CE_Informe WHERE IdInforme = @IDINFORMEACTUAL AND TipoInforme='CE'  AND IdPlantilla=62
	
			SELECT @IdInformeMax = MAX(SS_CE_Informe.IdInforme) +1
			FROM SS_CE_Informe 

			INSERT INTO SS_CE_Informe ( IdInforme , IdConsultaExterna , IdPlantilla , FechaInforme , TipoInforme , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ) 
			VALUES ( @IdInformeMax , @IdConsultaExterna , 62 , @FechaCreacion , 'CE' , 2 , @UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaCreacion) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ,IndAutoSize,IndAjustarCampo) 
			VALUES ( @IdInformeMax , 1 , 1 , 62 , 1 , 0 , @resultado   , null , 2 , @UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaCreacion,2,2)

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ,IndAutoSize,IndAjustarCampo) 
			VALUES ( @IdInformeMax , 2 , 2 , 62 , 2 , 0 , @ENFACTUAL   , null , 2 , @UsuarioCreacion , @FechaCreacion,@UsuarioCreacion,@FechaCreacion,2,2)

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion ,IndAutoSize,IndAjustarCampo) 
			VALUES ( @IdInformeMax , 3 , 3 , 62 , 3 , 0 , @ANTIMPORTANCIA , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 2 , 2 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 4 , 666 , 62 , 4 , 0 , @AVscOD , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 5 , 667 , 62 , 5 , 0 , @AVSCOI  , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 6 , 668 , 62 , 6 , 0 , @AEAVODPIN , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 7 , 669 , 62 , 7 , 0 , @AEAVOIDPIN  , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 8 , 670 , 62 , 8 , 0 , @AvCCOD , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 9 , 671 , 62 , 9 , 0 , @AVCCOI , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 10 , 672 , 62 , 10 , 0 , @CERCAVAD , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 11 , 673 , 62 , 11 , 0 , @CERCAVAOI , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 12 , 674 , 62 , 12 , 0 , @SPHodREFRA , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 13 , 675 , 62 , 13 , 0 , @CILodREFA , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 14 , 676, 62 , 14 , 0 , @EJEodREFRA , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 15 , 677 , 62 , 15 , 0 , @AVodREFRA , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 16 , 678 , 62 , 16 , 0 , @ADDodREFRA , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 17 , 679 , 62 , 17 , 0 , @DIPodREFRA , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 18 , 680 , 62 , 18 , 0 , @SPHoiSCICLO , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 19 , 681 , 62 , 19 , 0 , @CILoiSCICLO , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 20 , 682 , 62 , 20 , 0 , @EJEoiSCICLO , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 21 , 683 , 62 , 21 , 0 , @AVoiSCICLO , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 22 , 684 , 62 , 22 , 0 , '', null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 23 , 685 , 62 , 23 , 0 , '' , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 
			--- agrego
			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 24 , 686 , 62 , 24 , 0 , @ADDoiSCICLO , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 
			--- agrego
			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 25 , 687 , 62 , 25 , 0 , @DIPoiSCICLO , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 26 , 688 , 62 , 26 , 0 , @PAPARPADOSANEXOS , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 27 , 689 , 62 , 27 , 0 , @CORNEACRISTESCLERA , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 28 , 690 , 62 , 28 , 0 , @IRISPUPILA , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 29 , 691 , 62 , 29 , 0 , null , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 30 , 692 , 62 , 30 , 0 , null , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 31 , 693 , 62 , 31 , 0 , null , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 32 , 694 , 62 , 32 , 0 , null , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 

			INSERT INTO SS_CE_InformeDetalle ( IdInforme , Secuencial , IdConcepto , IdPlantilla , SecuencialPlantilla , ValorNumerico , ValorCadena , ValorFecha , Estado , 
			UsuarioCreacion , FechaCreacion , UsuarioModificacion , FechaModificacion , IndAutoSize , IndAjustarCampo ) 
			VALUES ( @IdInformeMax , 33 , 10 , 62 , 33 , 0 , null , null , 2 , @UsuarioCreacion , @FechaCreacion , @UsuarioCreacion , @FechaCreacion , 1 , 1 ) 


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

ALTER PROCEDURE [dbo].[SP_SS_IT_SPRINGExamenesConsultaExterna]
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
@SECUENCIALHCE VARCHAR(15), --PARA MODIFICAR HCE 15 AGOSTO 2019
@al_retorno int OUTPUT,
@as_mensaje varchar(500) OUTPUT
WITH RECOMPILE
    
AS


-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
--------------------------1.- LLENAR TABLA SS_AD_OrdenAtencionDetalle EXAMENES-------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

declare @var int,@IdLinea int,@ORDEN_ATENCION int ,@idturno int,@IdEstablecimiento int,@nombreComponente varchar(200),@sucursal varchar(15),@compania  varchar(15) -- modificar

BEGIN TRAN

SET @al_retorno = 0

BEGIN TRY
	IF @al_retorno = 0
	BEGIN
		--SET @ORDEN_ATENCION=(SELECT TipoAtencion FROM SS_AD_OrdenAtencion WHERE IdOrdenAtencion=@IDordenatencion) -- COMENTADO JORDAN MATEO
		SELECT @ORDEN_ATENCION=TipoAtencion,@IdEstablecimiento=IdEstablecimiento,@sucursal=Sucursal, @compania=Compania,@idturno = idturno FROM SS_AD_OrdenAtencion WHERE IdOrdenAtencion=@IDordenatencion  -- MODIFICADO JORDAN MATEO 
		SELECT @var = COUNT(*) FROM SS_AD_OrdenAtencionDetalle  WITH (NOLOCK) WHERE IdOrdenAtencion = @IDordenatencion and SECUENCIALHCE=@SECUENCIALHCE
			
		if @var =0
			begin

		
			Declare @IdConsultaExterna int,@SecuencialOrdenMax int, @idservicio int, @INDICADORHHMM int, @CENTROCOSTO varchar(15),@IDMEDICO int --creado para Interconsulta
				
			SELECT @IdLinea = ISNULL(max(Linea)+1,0) FROM SS_AD_OrdenAtencionDetalle  WHERE IdOrdenAtencion = @IDordenatencion
			
			SET @lineamax = @IdLinea

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


			SELECT @INDICADORHHMM = ISNULL(IndRequiereHHMM,1) FROM SG_UnidadReplicacionPrestacion   WHERE UnidadReplicacion=@sucursal AND Prestacion = @Componente  
		
			--SELECT @INDICADORHHMM = IndReqHonorario	FROM SS_GE_ComponentePrestacion  WITH (NOLOCK)	WHERE COMPONENTE = @Componente

			SELECT @SecuencialOrdenMax = ISNULL(MAX(ISNULL(Linea,0)),0) +1
			FROM SS_CE_ConsultaExternaOrdenMedica WITH (NOLOCK)
			WHERE Idconsultaexterna = @IdConsultaExterna 

			--Select @idturno = idturno
			--FROM SS_AD_OrdenAtencion WITH(NOLOCK)
			--WHERE IdOrdenAtencion=@IDordenatencion

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

			----MODIFICAR 15 AGOSTO 2019
			--SELECT @sucursal=Sucursal, @compania=Compania
			--from SS_AD_OrdenAtencion
			--where IdOrdenAtencion=@IDordenatencion

	
			--ALTER TABLE SS_aD_ORDENATENCIONDETALLE ADD SECUENCIALHCE VARCHAR(15) MODIFICAR HCE 15 AGOSTO 2019
			IF @Componente='500101' OR @Componente='500203' OR @Componente='500201' OR @Componente='500204' -- INTEROPERABILIDAD DE INTERCONSULTA luke 12/03/2020 //   LOGICA DE COMPONENTES 02/03/2022
				BEGIN
					
					SELECT @IdConsultaExterna = IDConsultaexterna
					FROM SS_CE_ConsultaExterna  WITH (NOLOCK)
					WHERE IdOrdenAtencion = @IDordenatencion and
					Medico=@IDMedico 

						SELECT @SecuencialOrdenMax = ISNULL(MAX(ISNULL(Linea,0)),0) +1
					FROM SS_CE_ConsultaExternaOrdenMedica WITH (NOLOCK)
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

				if(select count(1) from SS_AD_OrdenAtencion where IdOrdenAtencion=@IDordenatencion and TipoAtencion=2)> 0
					begin

						set @nombreComponente =(select top 1 RefEspecialidad from SS_GE_COMPONENTEPRESTACION where Componente=@Componente)
	
							set @Especialidad = (select top 1 IdEspecialidad from SS_GE_Especialidad where Nombre=@nombreComponente)
							
			
							INSERT INTO SS_AD_OrdenAtencionDetalle ( IdOrdenAtencion, Linea, TipoOrdenAtencion, Especialidad, IndicadorDisponible,
								IdServicio, IdTurno, IdPaciente, TipoComponente, Componente, Cantidad, 
								CentroCosto, Estado, UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion, IndicadorEPS,TipoInterConsulta, 
								IndicadorHonorarios,Observacion,SECUENCIALHCE,SUCURSAL,Compania ) --modificar 15 agosto 2019
								VALUES ( @idordenatencion , @LineaMax, @IdTipoOrdenatencion , @Especialidad ,2,@idservicio,@idturno,@IdPaciente,'C', @Componente , @cantidad,@centrocosto,
							2,@Usuario,GETDATE(),@Usuario,GETDATE(),2,@indicadorEPS,@INDICADORHHMM,UPPER(@Observacion),@SECUENCIALHCE,@sucursal,@compania) --modificar 15 AGOSTO 2019
						
						end
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
			end
			else
			begin
				UPDATE SS_AD_OrdenAtencionDetalle SET Cantidad =@cantidad,Observacion=UPPER(@Observacion) WHERE IdOrdenAtencion = @IDordenatencion and SECUENCIALHCE=@SECUENCIALHCE 
				UPDATE SS_CE_ConsultaExternaOrdenMedica SET MotivoTransferencia=UPPER(@Observacion) WHERE IdOrdenAtencion = @IDordenatencion and LineaOrdenAtencion=@IdLinea  
			end
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

GO

ALTER PROCEDURE [dbo].[SP_SS_IT_SPRINGINDGENRECETA]
@IDordenatencion Int,
@LineaOrdenAtencionConsulta int,
@TipoIndicacion int,
@IDPaciente int,
@descripcion varchar(1500),
@UnidadReplicacion varchar(15),
@FechaCreacion datetime,
@UsuarioCreacion varchar(15),
@IDEPISODIOATENCION int,
@EpisodioClinico int,
@al_retorno int OUTPUT,
@as_mensaje varchar(500) OUTPUT

AS
Declare @IdConsultaExterna int

BEGIN TRAN

SET @al_retorno = 0

BEGIN TRY
	IF @al_retorno = 0
	BEGIN
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

ALTER PROCEDURE [dbo].[SP_SS_IT_SPRINGRECETAConsultaExternaV2]
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
--, ,

AS

Declare @IdConsultaExterna int,@SecuencialRecetaMax int,/*@LineaMax int,*/@nombrecomponente varchar(250), @Especialidad int, @idservicio int, @correlativo int,
@idprocedimiento int,@SECUENCIALRECETA INT=NULL,@CORRELATIVOINDANT INT=NULL,@LINEAOAINSERT INT,@tipoatencion int

BEGIN TRAN

SET @al_retorno = 0

BEGIN TRY
	SELECT @idservicio = IdServicio FROM SS_GE_ServicioPrestacion WITH (NOLOCK) WHERE COMPONENTE = @Componente

	SELECT @Especialidad = ESPECIALIDAD FROM SS_AD_OrdenAtencion WITH (NOLOCK) WHERE IDORDENATENCION = @IDORDENATENCION
	select @tipoatencion = TipoAtencion FROM SS_AD_OrdenAtencion WITH (NOLOCK) WHERE IDORDENATENCION = @IDORDENATENCION

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
		--WHERE IdOrdenAtencion = @IDordenatencion and LineaOrdenAtencion=@LineaOA MODIFICADO 02 OCTUBRE 2019
		WHERE IdConsultaExterna=@IdConsultaExterna and LineaOrdenAtencion= @LINEAOAINSERT

		SELECT @CORRELATIVOINDANT = ISNULL(correlativo,5000)
		FROM SS_CE_CEDetalleIndicaciones WITH (NOLOCK)
		WHERE IdConsultaExterna=@IdConsultaExterna AND Secuencial=@SECUENCIALRECETA

		--PARA MODIFICAR 16092019

		--DELETE FROM SS_CE_CEDetalleIndicaciones WHERE IdConsultaExterna = @IdConsultaExterna AND Correlativo = @CORRELATIVOINDANT

		--DELETE FROM SS_CE_ConsultaExternaReceta WHERE  IdConsultaExterna = @IdConsultaExterna AND  Secuencial=@SECUENCIALRECETA -- IdOrdenAtencion   = @IDordenatencion   AND  LineaOrdenAtencion    = @LINEAOAINSERT
		--   DELETE FROM SS_AD_OrdenAtencionDetalle  WHERE IdOrdenAtencion   = @IDordenatencion   AND  SECUENCIALHCE = @SECUENCIALHCE

		--FIN MODIFICAR FIN 16092019
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
			@unidadMedida,@linea,@familia,@subfamilia,@cantidad,2,@Usuario,@fechacreacion,@indicadorEPS,case when @tipoatencion = 2 then 1 else 2 end ,@NombreComponente,1,'00000000','LIMA',2,@SECUENCIALHCE,'MIRTH')

		
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

		--Modificado por FACN - Inicio
		IF @LINEAOAINSERT > 0
		BEGIN
			UPDATE SS_AD_OrdenAtencionDetalle 
			SET	TipoOrdenAtencion = 13, 
				Especialidad = @Especialidad, 
				IdServicio = @idservicio, 
				IdTurno = 1, 
				IdPaciente = @IdPaciente, 
				TipoComponente = 'A', 
				--Componente = @Componente, 
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
				Sucursal = 'LIMA',
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
	--Modificado por FACN - Fin
	else
	begin

	SELECT @IDPROCEDIMIENTO= SS_PR_Procedimiento.IdProcedimiento
	FROM SS_PR_Procedimiento WITH(NOLOCK)
	WHERE SS_PR_Procedimiento.IdOrdenAtencion=@IDordenatencion AND SS_PR_Procedimiento.LineaOrdenAtencion=@LineaOA

	-- -- CAMBIO
	DELETE FROM SS_AD_OrdenAtencionDetalle  WHERE IdOrdenAtencion   = @IDordenatencion   AND SECUENCIALHCE = @SECUENCIALHCE
	DELETE FROM SS_PR_ProcedimientoDetalle where IdOrdenAtencion=@IDordenatencion and LineaOrdenAtencion=@LINEAOAINSERT

	SELECT @lineamax = ISNULL(MAX(ISNULL(Linea,0)),0) +1
	FROM SS_AD_OrdenAtencionDetalle WITH (NOLOCK) WHERE IdOrdenAtencion = @IDordenatencion


	INSERT INTO SS_AD_OrdenAtencionDetalle ( IdOrdenAtencion , Linea , Especialidad , IdServicio ,
	IdTurno , IdPaciente , TipoComponente , Componente , TipoOrdenAtencion , IdUnidadMedida , Cantidad ,
	CantidadPresupuestada , CantidadSolicitada , Estado , UsuarioCreacion , FechaCreacion , Observacion ,
	CentroCosto , IndicadorEPS , IndicadorSeCobra , IndicadorHonorarios , UsuarioModificacion , FechaModificacion ,
	TipoReceta , IndicadorDisponible , AlmacenDestino , LoteComponente,SECUENCIALHCE ) VALUES
	( @IDordenatencion , @lineamax ,@Especialidad , 0 , 2 , @IDPaciente, 'A' , @Componente , 13 ,
	@unidadmedida ,@Cantidad ,@Cantidad , @Cantidad , 2 ,@Usuario , @Fechacreacion , '' ,  '' , @IndicadorEPS ,
	 null , 1 ,@Usuario ,@Fechacreacion,   2 , null , '1011' ,'',@SECUENCIALHCE)

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


