/****** Object:  StoredProcedure [dbo].[SP_InsertarBandejaTriaje]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_InsertarBandejaTriaje](
@UnidadReplicacion char(4) , 
@IdPaciente int, 
@IdPersonalSalud int, 
@FechaAtencion datetime, 
@IdEspecialidad int, 
@IdPrioridad int, 
@FlagFirma int , 
@FechaFirma datetime, 
@IdMedicoFirma int, 
@ObservacionFirma varchar(300), 
@Accion varchar(25), 
@Version varchar(25) , 
@Estado int , 
@UsuarioCreacion varchar(25) , 
@UsuarioModificacion varchar(25), 
@FechaModificacion datetime)
as

  if(@Accion = 'INSERT_TRIAJE')
		 BEGIN 

			DECLARE @IdEpisodioTriaje as integer , @CodigoOT AS VARCHAR(15)
			select @IdEpisodioTriaje = ISNULL(max(IdEpisodioTriaje),0)+1 from SS_HC_EpisodioTriaje; 	
  

			EXEC SP_SS_HC_Correlativo '00000000','CEG','OT',@NroPeticion=@CodigoOT output 
 

			INSERT INTO SS_HC_EpisodioTriaje 
			(UnidadReplicacion,IdPaciente,IdEpisodioTriaje,CodigoOT,
			IdPersonalSalud,FechaAtencion,IdEspecialidad,IdPrioridad,FlagFirma,
			IdMedicoFirma,ObservacionFirma,Accion,Version,Estado,UsuarioCreacion,UsuarioModificacion,FechaCreacion,FechaModificacion
			)
			values(  
			@UnidadReplicacion,@IdPaciente,@IdEpisodioTriaje,@CodigoOT
			,@IdPersonalSalud,@FechaAtencion,@IdEspecialidad,@IdPrioridad,@FlagFirma
			,@IdMedicoFirma,@ObservacionFirma,@Accion,@Version,@Estado,@UsuarioCreacion,@UsuarioModificacion,
			SYSDATETIME(),@FechaModificacion)
     
		   select @IdEpisodioTriaje;  
      
		  END 
  
  ELSE IF(@Accion = 'UPDATE_ESPECIALIDAD')
	 BEGIN  
  
	  UPDATE SS_HC_EpisodioTriaje set IdEspecialidad =@IdEspecialidad,
	  Estado = @Estado , UsuarioModificacion = @UsuarioModificacion , 
	  FechaModificacion = @FechaModificacion , IdPrioridad = @IdPrioridad
	  where IdEpisodioTriaje = @IdPaciente;
	  select 1;
      
	  END 

    ELSE IF(@Accion = 'C_LOCALIZATION')
	 BEGIN  
  
	  INSERT INTO SS_HC_VIGILANCIA_DISPOSITIVOS_FE_LOCALIZACION
	  VALUES (@IdPersonalSalud,@ObservacionFirma,@UsuarioCreacion,@UsuarioModificacion,@UnidadReplicacion,
	  @Estado,@IdPaciente,@IdPrioridad)

	  select 1;
      
	  END 
  ELSE IF(@Accion = 'P_LOCALIZATION')
	 BEGIN  
  
	  UPDATE SS_HC_VIGILANCIA_DISPOSITIVOS_FE_LOCALIZACION
	  SET  Descripcion= @ObservacionFirma,
	  --ValorX= @UsuarioCreacion,ValorY = @UsuarioModificacion,
	  UnidadReplicacion = @UnidadReplicacion  
	  where IdEpisodioAtencion=  @Estado and IdPaciente= @IdPaciente and 
	  EpisodioClinico = @IdPrioridad and Secuencia= @IdPersonalSalud


	  select 1;
      
	  END 

    ELSE IF(@Accion = 'D_LOCALIZATION')
	 BEGIN  
  
	  DELETE FROM SS_HC_VIGILANCIA_DISPOSITIVOS_FE_LOCALIZACION
 
	  where IdEpisodioAtencion=  @Estado and IdPaciente= @IdPaciente and 
	  EpisodioClinico = @IdPrioridad and Secuencia= @IdPersonalSalud


	  select 1;
      
  END 

  
  ELSE IF(@Accion = 'UPDATE_RELEVO_MEDICO')
	BEGIN  
 
	update SS_HC_EpisodioAtencion set IdPersonalSalud = @IdPersonalSalud
	 where IdOrdenAtencion = @IdPrioridad
	and CodigoOA = @Version and UnidadReplicacion = @UnidadReplicacion
	and LineaOrdenAtencion = @Estado 

	  select 1;
      
	END   
  
  ELSE IF(@Accion = 'UPDATE_ESTADO')
	 BEGIN  
 
		  UPDATE SS_HC_EpisodioTriaje set Estado = @Estado , 
		  FechaModificacion = @FechaModificacion
		  where IdEpisodioTriaje = @IdPaciente;
		  select 1;     
	  END 

  ELSE IF(@Accion = 'UPDATE_FIRMA_MEDICO')
	 BEGIN   
	  UPDATE SS_HC_EpisodioTriaje set Estado = @Estado , 
	  FechaFirma = @FechaFirma ,
	  IdMedicoFirma = @IdMedicoFirma , 
	  ObservacionFirma = @ObservacionFirma , IdPersonalSalud = @IdPersonalSalud ,
	  FlagFirma = @FlagFirma 
	  where IdEpisodioTriaje = @IdPaciente;
	  select 1;  
      
  END 
    
  ELSE IF(@Accion = 'ANULAR_EPISODIOTRIAJE')
	 BEGIN   
	  UPDATE SS_HC_EpisodioTriaje set Estado = 4 , 
	  FechaModificacion = @FechaModificacion ,UsuarioModificacion = @UsuarioModificacion,
	  ObservacionFirma = @ObservacionFirma 
	  where IdEpisodioTriaje = @IdPaciente

	  DECLARE @IdTriaje as integer 
	  DECLARE @CONTAD as integer  

		SELECT  @CONTAD =COUNT(*), @IdTriaje =max(IdTriaje) FROM BDOncologico.DBO.[SS_CE_TriajeFirma] WHERE IdEpisodioTriajeHCE=@IdPaciente
		IF(@CONTAD>0)
			BEGIN 
			 UPDATE BDOncologico.DBO.SS_CE_Triaje SET EstadoDocumento=3, Observacion = @ObservacionFirma WHERE IdTriaje=@IdTriaje
			 END

	  select 1;  
      
  END 
  GO
/****** Object:  StoredProcedure [dbo].[SP_SS_FA_SolicitudProducto]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE OR ALTER PROCEDURE [SP_SS_FA_SolicitudProducto]
	@UnidadReplicacion  char(4) ,	
	@IdEpisodioAtencion bigint,
	@IdPaciente int,
	@EpisodioClinico int,
	@IdSolicitudProducto  int ,
	@NumeroDocumento  varchar(14),	
	@Observacion  varchar(250),
	@EstadoDocumento int,
	@Estado int,
	@UsuarioCreacion varchar(25),
	@FechaCreacion datetime,
	@UsuarioModificacion varchar(25),
	@FechaModificacion datetime,
	@Accion varchar(50),
	@Version varchar(50),
	@indicaciones varchar(1000)
	
AS
BEGIN
	DECLARE @IdSolicitudProductoID as INTEGER,@NumeroDocumentoID AS VARCHAR(14),@NumeroDocumentoN AS INTEGER	
	declare @Numero varchar(14)	
	IF @Accion = 'NUEVO'
		BEGIN		
			
			SELECT  @IdSolicitudProductoID =isnull(max(IdGuiaFarmacia),0)+1,@NumeroDocumentoID = 'CEG'+RIGHT('00000000' + CAST(CAST(isnull(max(IdGuiaFarmacia),0)+1 AS INT) AS VARCHAR),8) 
			FROM BDOncologico.dbo.SS_AD_GuiaFarmacia			

			INSERT INTO SS_FA_SolicitudProducto(UnidadReplicacion,IdEpisodioAtencion,IdPaciente,EpisodioClinico,IdSolicitudProducto,
			NumeroDocumento,Observacion,EstadoDocumento,Estado,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,Accion,Version,indicaciones)
			VALUES (@UnidadReplicacion,@IdEpisodioAtencion,@IdPaciente,@EpisodioClinico,@IdSolicitudProductoID,
			@NumeroDocumentoID,@Observacion,@EstadoDocumento,2,@UsuarioCreacion,GETDATE(),@UsuarioModificacion,GETDATE(),@Accion,@Version,@indicaciones)

			SELECT @IdSolicitudProductoID;
		END
		IF @Accion = 'UPDATE'
		BEGIN

			UPDATE SS_FA_SolicitudProducto
			SET Observacion=@Observacion,
			EstadoDocumento=@EstadoDocumento,
			Estado=@Estado,
			UsuarioModificacion=@UsuarioModificacion,
			FechaModificacion=@FechaModificacion,
			Accion=@Accion,
			Version=@Version,
			indicaciones=@indicaciones
			WHERE UnidadReplicacion=@UnidadReplicacion AND 
			IdEpisodioAtencion=@IdEpisodioAtencion AND 
			IdPaciente=@IdPaciente AND 
			EpisodioClinico= @EpisodioClinico AND		
			NumeroDocumento=@NumeroDocumento

			SELECT IdSolicitudProducto from SS_FA_SolicitudProducto WHERE UnidadReplicacion=@UnidadReplicacion AND 
			IdEpisodioAtencion=@IdEpisodioAtencion AND 
			IdPaciente=@IdPaciente AND 
			EpisodioClinico= @EpisodioClinico AND			
			NumeroDocumento=@NumeroDocumento
		END
		
		IF @Accion = 'ANULAR'
		begin
			UPDATE SS_FA_SolicitudProducto
			SET Observacion=@Observacion,
			EstadoDocumento=@EstadoDocumento,
			Estado=4,
			UsuarioModificacion=@UsuarioModificacion,
			FechaModificacion=@FechaModificacion,
			Accion=@Accion,
			Version=@Version
			WHERE UnidadReplicacion=@UnidadReplicacion AND 
			IdEpisodioAtencion=@IdEpisodioAtencion AND 
			IdPaciente=@IdPaciente AND 
			EpisodioClinico= @EpisodioClinico AND	
			NumeroDocumento=@NumeroDocumento				
			
			
			SELECT @IdSolicitudProductoID = ISNULL(MAX(IdSolicitudProducto),0)+1 FROM SS_FA_SolicitudProducto;
			SELECT @NumeroDocumentoN = ISNULL(MAX(CONVERT(INT,NumeroDocumento)),0)+1 FROM SS_FA_SolicitudProducto;
			SELECT @NumeroDocumentoID=RIGHT('00000000' + CAST(@NumeroDocumentoN as varchar), 8);
			
			INSERT INTO SS_FA_SolicitudProducto(UnidadReplicacion,IdEpisodioAtencion,IdPaciente,EpisodioClinico,IdSolicitudProducto,
			NumeroDocumento,Observacion,EstadoDocumento,Estado,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,Accion,Version)
			VALUES (@UnidadReplicacion,@IdEpisodioAtencion,@IdPaciente,@EpisodioClinico,@IdSolicitudProductoID,
			@NumeroDocumentoID,'',@EstadoDocumento,1,'',null,'',null,'',@Version)
			
			SELECT @IdSolicitudProductoID 
		end
	
	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_FA_SolicitudProducto_Produccion]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE OR ALTER PROCEDURE [SP_SS_FA_SolicitudProducto_Produccion]
	@UnidadReplicacion  char(4) ,	
	@IdEpisodioAtencion bigint,
	@IdPaciente int,
	@EpisodioClinico int,
	@IdSolicitudProducto  int ,
	@NumeroDocumento  varchar(14),	
	@Observacion  varchar(250),
	@EstadoDocumento int,
	@Estado int,
	@UsuarioCreacion varchar(25),
	@FechaCreacion datetime,
	@UsuarioModificacion varchar(25),
	@FechaModificacion datetime,
	@Accion varchar(50),
	@Version varchar(50),
	@indicaciones varchar(1000)
	
AS
BEGIN
	DECLARE @IdSolicitudProductoID as INTEGER,@NumeroDocumentoID AS VARCHAR(14),@NumeroDocumentoN AS INTEGER, @IdOrdenAtencion as INTEGER, @LineaOA as INTEGER, @IdCExt as INTEGER
	declare @Numero varchar(14)	

	INSERT INTO HCE_LOG_BANDEJA(SPID, FechaPeticion, Medico, Operacion, FechaOperacion,
	CodigoHC, CodigoHCAnterior, TipoOrdenAtencion, PacienteNombre, CodigoOA ,
	FechaInicio ,FechaFin , IdPaciente , Sucursal , IdEspecialidad ,
	IdMedico, OperacionTiempoMS )

	SELECT @@spid, GETDATE(), @IdOrdenAtencion, 'BEGIN', getdate(),
	NULL, NULL, NULL, NULL, @Accion,
	NULL,NULL, @IdPaciente, @UnidadReplicacion, @IdSolicitudProductoID,
	@EpisodioClinico, DATEDIFF(ms, GETDATE(), getdate())

	IF @Accion = 'NUEVO'
		BEGIN		

			INSERT INTO HCE_LOG_BANDEJA(SPID, FechaPeticion, Medico, Operacion, FechaOperacion,
			CodigoHC, CodigoHCAnterior, TipoOrdenAtencion, PacienteNombre, CodigoOA ,
			FechaInicio ,FechaFin , IdPaciente , Sucursal , IdEspecialidad ,
			IdMedico, OperacionTiempoMS )

			SELECT @@spid, GETDATE(), @IdOrdenAtencion, 'PRE-GUIA', getdate(),
			NULL, NULL, NULL, NULL, NULL,
			NULL,NULL, @IdPaciente, @UnidadReplicacion, @IdSolicitudProductoID,
			NULL, DATEDIFF(ms, GETDATE(), getdate())
		
			SELECT TOP 1 @IdOrdenAtencion = SS_HC_EpisodioAtencion.IdOrdenAtencion, @LineaOA = SS_HC_EpisodioAtencion.LineaOrdenAtencion
			FROM SS_HC_EpisodioAtencion WITH(NOLOCK)
			WHERE UnidadReplicacion=@UnidadReplicacion AND IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente AND EpisodioClinico=@EpisodioClinico

			SELECT  TOP 1 @IdCExt = CE.IdConsultaExterna
			FROM [EGVPDB10].SpringSalud_Produccion.dbo.SS_CE_ConsultaExterna CE  WITH(NOLOCK) WHERE CE.IdOrdenAtencion = @IdOrdenAtencion AND CE.LineaOrdenAtencion = @LineaOA
			
			SELECT  @IdSolicitudProductoID =isnull(max(IdGuiaFarmacia),0)+1,@NumeroDocumentoID = 'CEG'+RIGHT('00000000' + CAST(CAST(isnull(max(IdGuiaFarmacia),0)+1 AS INT) AS VARCHAR),8) 
			FROM [EGVPDB10].SpringSalud_Produccion.dbo.SS_AD_GuiaFarmacia	

			INSERT INTO HCE_LOG_BANDEJA(SPID, FechaPeticion, Medico, Operacion, FechaOperacion,
			CodigoHC, CodigoHCAnterior, TipoOrdenAtencion, PacienteNombre, CodigoOA ,
			FechaInicio ,FechaFin , IdPaciente , Sucursal , IdEspecialidad ,
			IdMedico, OperacionTiempoMS )

			SELECT @@spid, GETDATE(), @IdOrdenAtencion, 'GUIA-INICIO', getdate(),
			NULL, NULL, NULL, NULL, NULL,
			NULL,NULL, @IdPaciente, @UnidadReplicacion, @IdSolicitudProductoID,
			NULL, DATEDIFF(ms, GETDATE(), getdate())
			
			 INSERT INTO [EGVPDB10].SpringSalud_Produccion.dbo.SS_AD_GuiaFarmacia ( IdGuiaFarmacia,Compania,TipoDocumento,NumeroDocumento,Sucursal,UnidadReplicacion
				,TransaccionCodigo,FechaDocumento,AlmacenCodigo,ReferenciaTipoDocumento,EstadoDocumento,EstadoDocumentoAnterior
				,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,TipoTransaccion,IndicadorAlta,Observacion,IdGuiaReferencia,UsuarioSolicitante,ReferenciaNumeroDocumento
				) VALUES  (@IdSolicitudProductoID,'00000000', 'GF',@NumeroDocumentoID,@UnidadReplicacion,@UnidadReplicacion,'PED', GETDATE(),'1003','CE',1,1,
				@UsuarioCreacion,GETDATE(), @UsuarioCreacion,GETDATE(),'NS',0,'ENVIO POR HCE',0,@UsuarioCreacion,@IdCExt)

			INSERT INTO HCE_LOG_BANDEJA(SPID, FechaPeticion, Medico, Operacion, FechaOperacion,
			CodigoHC, CodigoHCAnterior, TipoOrdenAtencion, PacienteNombre, CodigoOA ,
			FechaInicio ,FechaFin , IdPaciente , Sucursal , IdEspecialidad ,
			IdMedico, OperacionTiempoMS )

			SELECT @@spid, GETDATE(), @IdOrdenAtencion, 'GUIA-FIN', getdate(),
			NULL, NULL, NULL, NULL, NULL,
			NULL,NULL, @IdPaciente, @UnidadReplicacion, @IdSolicitudProductoID,
			NULL, DATEDIFF(ms, GETDATE(), getdate())

			INSERT INTO SS_FA_SolicitudProducto(UnidadReplicacion,IdEpisodioAtencion,IdPaciente,EpisodioClinico,IdSolicitudProducto,
			NumeroDocumento,Observacion,EstadoDocumento,Estado,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,Accion,Version,indicaciones)
			VALUES (@UnidadReplicacion,@IdEpisodioAtencion,@IdPaciente,@EpisodioClinico,@IdSolicitudProductoID,
			@NumeroDocumentoID,@Observacion,@EstadoDocumento,2,@UsuarioCreacion,GETDATE(),@UsuarioModificacion,GETDATE(),@Accion,@Version,@indicaciones)

			SELECT @IdSolicitudProductoID;
		END
		IF @Accion = 'UPDATE'
		BEGIN

			UPDATE SS_FA_SolicitudProducto
			SET Observacion=@Observacion,
			EstadoDocumento=@EstadoDocumento,
			Estado=@Estado,
			UsuarioModificacion=@UsuarioModificacion,
			FechaModificacion=@FechaModificacion,
			Accion=@Accion,
			Version=@Version,
			indicaciones=@indicaciones
			WHERE UnidadReplicacion=@UnidadReplicacion AND 
			IdEpisodioAtencion=@IdEpisodioAtencion AND 
			IdPaciente=@IdPaciente AND 
			EpisodioClinico= @EpisodioClinico AND		
			NumeroDocumento=@NumeroDocumento

			SELECT IdSolicitudProducto from SS_FA_SolicitudProducto WHERE UnidadReplicacion=@UnidadReplicacion AND 
			IdEpisodioAtencion=@IdEpisodioAtencion AND 
			IdPaciente=@IdPaciente AND 
			EpisodioClinico= @EpisodioClinico AND			
			NumeroDocumento=@NumeroDocumento
		END
		
		IF @Accion = 'ANULAR'
		begin
			UPDATE SS_FA_SolicitudProducto
			SET Observacion=@Observacion,
			EstadoDocumento=@EstadoDocumento,
			Estado=4,
			UsuarioModificacion=@UsuarioModificacion,
			FechaModificacion=@FechaModificacion,
			Accion=@Accion,
			Version=@Version
			WHERE UnidadReplicacion=@UnidadReplicacion AND 
			IdEpisodioAtencion=@IdEpisodioAtencion AND 
			IdPaciente=@IdPaciente AND 
			EpisodioClinico= @EpisodioClinico AND	
			NumeroDocumento=@NumeroDocumento				
			
			
			SELECT @IdSolicitudProductoID = ISNULL(MAX(IdSolicitudProducto),0)+1 FROM SS_FA_SolicitudProducto;
			SELECT @NumeroDocumentoN = ISNULL(MAX(CONVERT(INT,NumeroDocumento)),0)+1 FROM SS_FA_SolicitudProducto;
			SELECT @NumeroDocumentoID=RIGHT('00000000' + CAST(@NumeroDocumentoN as varchar), 8);
			
			INSERT INTO SS_FA_SolicitudProducto(UnidadReplicacion,IdEpisodioAtencion,IdPaciente,EpisodioClinico,IdSolicitudProducto,
			NumeroDocumento,Observacion,EstadoDocumento,Estado,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,Accion,Version)
			VALUES (@UnidadReplicacion,@IdEpisodioAtencion,@IdPaciente,@EpisodioClinico,@IdSolicitudProductoID,
			@NumeroDocumentoID,'',@EstadoDocumento,1,'',null,'',null,'',@Version)
			
			SELECT @IdSolicitudProductoID 
		end
	
	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_FA_SolicitudProductoDetalle]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_FA_SolicitudProductoDetalle]
	@UnidadReplicacion  char(4) ,	
	@IdEpisodioAtencion bigint,
	@IdPaciente int,
	@EpisodioClinico int,
	@IdSolicitudProducto  int ,	
	@Secuencia int,
	@UnidadReplicacionReferencia char(4),
	@IdEpisodioAtencionReferencia bigint,
	@IdPacienteReferencia int,
	@EpisodioClinicoReferencia int,
	@Cantidad decimal(20,6),	
	@Linea char(6),
	@Familia char(6),
	@SubFamilia char(6),
	@TipoComponente char(1),
	@CodigoComponente varchar(25),
	@Medicamento varchar(250),
	@GrupoMedicamento int,
	@IdOrdenAtencion int,
	@Estado int,	
	@UsuarioCreacion varchar(25),
	@FechaCreacion datetime,
	@UsuarioModificacion varchar(25),
	@FechaModificacion datetime,
	@Accion varchar(50),
	@Version varchar(50),
	@indicaciones varchar(1000),
	@LineaOrdenAtencion int,
	@SecuencialHCE varchar(40)


	
AS
BEGIN
	DECLARE @IdSolicitudProductoID as INTEGER,@NumeroDocumentoID AS VARCHAR(8),@NumeroDocumentoN AS INTEGER,@SecuenciaID as integer
	
	IF @Accion = 'NUEVO'
		BEGIN

			IF @TipoComponente='M'
			BEGIN
				EXEC SP_SS_HC_Correlativo '00000000','CEG' ,'HC',@NroPeticion=@SecuencialHCE output
			END

			SELECT @SecuenciaID = ISNULL(max(Secuencia),0)+1  FROM SS_FA_SolicitudProductoDetalle WHERE IdSolicitudProducto=@IdSolicitudProducto
			INSERT INTO SS_FA_SolicitudProductoDetalle(UnidadReplicacion,IdEpisodioAtencion,IdPaciente,EpisodioClinico,IdSolicitudProducto,
			Secuencia,UnidadReplicacionReferencia,IdEpisodioAtencionReferencia,IdPacienteReferencia,EpisodioClinicoReferencia,Cantidad,Linea,Familia,
			SubFamilia,TipoComponente,CodigoComponente,Medicamento,GrupoMedicamento,IdOrdenAtencion,Estado,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,Accion,Version,SecuencialHCE)
			VALUES (@UnidadReplicacion,@IdEpisodioAtencion,@IdPaciente,@EpisodioClinico,@IdSolicitudProducto,
			@SecuenciaID,@UnidadReplicacionReferencia,@IdEpisodioAtencionReferencia,@IdPacienteReferencia,@EpisodioClinicoReferencia,@Cantidad,@Linea,@Familia,
			@SubFamilia,@TipoComponente,@CodigoComponente,@Medicamento,
			@GrupoMedicamento,@IdOrdenAtencion,2,@UsuarioCreacion,@FechaCreacion,@UsuarioCreacion,@FechaModificacion,@Accion,@Version,@SecuencialHCE)
			
			SELECT @IdSolicitudProducto;
		END	
		
	IF @Accion = 'UPDATE'
		BEGIN

			UPDATE SS_FA_SolicitudProductoDetalle			
			SET Cantidad=@Cantidad,
			Estado=@Estado,
			UsuarioModificacion=@UsuarioCreacion,
			FechaModificacion=@FechaModificacion,
			Accion=@Accion,
			Version=@Version
			WHERE UnidadReplicacion=@UnidadReplicacion AND
			IdEpisodioAtencion =@IdEpisodioAtencion AND
			IdPaciente=@IdPaciente AND
			EpisodioClinico = @EpisodioClinico AND
			IdSolicitudProducto=@IdSolicitudProducto AND
			Secuencia=@Secuencia AND
			CodigoComponente=@CodigoComponente
			
			
			SELECT @IdSolicitudProducto;
		END		
		
		IF @Accion = 'DELETE'
		BEGIN
			
			DELETE SS_FA_SolicitudProductoDetalle
			WHERE UnidadReplicacion=@UnidadReplicacion AND
			IdEpisodioAtencion =@IdEpisodioAtencion AND
			IdPaciente=@IdPaciente AND
			EpisodioClinico = @EpisodioClinico AND
			IdSolicitudProducto=@IdSolicitudProducto AND
			Secuencia=@Secuencia AND
			CodigoComponente=@CodigoComponente			
			
			SELECT @IdSolicitudProducto;
		END			
	
END

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_FA_SolicitudProductoDetalle_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE OR ALTER PROCEDURE [SP_SS_FA_SolicitudProductoDetalle_Listar]
	@UnidadReplicacion  char(4) ,	
	@IdEpisodioAtencion bigint,
	@IdPaciente int,
	@EpisodioClinico int,
	@IdSolicitudProducto  int ,	
	@Secuencia int,
	@UnidadReplicacionReferencia char(4),
	@IdEpisodioAtencionReferencia bigint,
	@IdPacienteReferencia int,
	@EpisodioClinicoReferencia int,
	@Cantidad decimal(20,6),	
	@Linea char(6),
	@Familia char(6),
	@SubFamilia char(6),
	@TipoComponente char(1),
	@CodigoComponente varchar(25),
	@Medicamento varchar(250),
	@GrupoMedicamento int,
	@IdOrdenAtencion int,
	@Estado int,	
	
	@UsuarioCreacion varchar(25),
	@FechaCreacion datetime,
	@UsuarioModificacion varchar(25),
	@FechaModificacion datetime,
	@Accion varchar(50),
	@Version varchar(50)
	
AS
BEGIN
	IF @Accion = 'LISTAR'
		BEGIN
										
			SELECT DISTINCT
			D.UnidadReplicacion,
		D.IdEpisodioAtencion,
		D.IdPaciente,
		D.EpisodioClinico,
		D.IdSolicitudProducto,
		D.Secuencia,
		VIS.IngresoUsuario UnidadReplicacionReferencia,
		D.IdEpisodioAtencionReferencia,
		D.IdPacienteReferencia,
		D.EpisodioClinicoReferencia,
		D.Cantidad,
		D.Linea,
		D.Familia,
		D.SubFamilia,
		D.TipoComponente,
		D.CodigoComponente,
		D.Medicamento,
		/*( case when (MED.DescripcionLocal IS NOT null OR MED.DescripcionLocal <> '')
						   then MED.DescripcionLocal else DCI.DescripcionLocal end  ) as Medicamento,*/
		D.GrupoMedicamento,
		D.IdOrdenAtencion,
		D.Estado,
		D.UsuarioCreacion,
		D.FechaCreacion,
		D.SecuencialHCE UsuarioModificacion,
		D.FechaModificacion,
		D.Accion,
		case when isnull((select top 1 G.CantidadDespachada from  BDOncologico.dbo.SS_AD_OrdenAtencionDetalle P WITH(NOLOCK) 
			INNER JOIN BDOncologico.dbo.SS_AD_GuiaFarmaciaDetalle G WITH(NOLOCK)  ON
			G.IdGuiaFarmacia= P.IdGuiaFarmacia AND  P.GuiaSecuencial=G.Secuencial
		where P.SECUENCIALHCE= D.SECUENCIALHCE  and p.IdOrdenAtencion=D.IdOrdenAtencion   ),0)>0 then '3'
		else Convert(varchar(4),D.Estado) end as  Version,
		D.indicaciones,
		D.SecuencialHCE,
		D.LineaOrdenAtencion		
			
			 FROM SS_FA_SolicitudProductoDetalle D 
		LEFT JOIN VW_ATENCIONPACIENTEMEDICAMENTO VIS ON VIS.IdEpisodioAtencion=D.IdEpisodioAtencion AND VIS.IdPaciente=D.IdPaciente 
		AND VIS.EpisodioClinico=D.EpisodioClinico AND VIS.UnidadReplicacion=D.UnidadReplicacion AND VIS.UsuarioAuditoria=D.SecuencialHCE
			Left join WH_ClaseSubFamilia DCI on
            (DCI.Linea = D.Linea
             AND DCI.Familia = D.Familia
             AND DCI.SubFamilia = D.SubFamilia
             AND (D.CodigoComponente  = '' OR D.CodigoComponente is null)
            )
            Left join WH_ItemMast MED on
            (MED.Linea = D.Linea
             AND MED.Familia = D.Familia
             AND MED.SubFamilia = D.SubFamilia
             AND ( rtrim(MED.Item)  =  D.CodigoComponente )
            ) 
			
			WHERE
			D.UnidadReplicacion = @UnidadReplicacion
			AND D.IdEpisodioAtencion=@IdEpisodioAtencion
			AND D.IdPaciente=@IdPaciente
			AND D.EpisodioClinico=@EpisodioClinico
			AND D.IdSolicitudProducto=@IdSolicitudProducto
		END		
	
END

GO

/****** Object:  StoredProcedure [dbo].[SP_ListarBandejaDispensacion]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_ListarBandejaDispensacion]
	@UnidadReplicacion  char(4) ,
	@IdEpisodioAtencion  bigint ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,	
	@Secuencia  int ,
	@IdUnidadMedida  int,
	@Linea  char(6),
	@Familia  char(6),
	@SubFamilia  char(6),	
	@TipoComponente  char(1),
	@CodigoComponente  varchar(25),
	@IdVia  int,
	@Dosis  varchar(250),
	@DiasTratamiento  decimal(9, 2),
	@Frecuencia  decimal(9, 2),
	@Cantidad  decimal(20, 6),
	@IndicadorEPS  int,
	@TipoReceta  int,
	@Forma int,
	@GrupoMedicamento int,
	@Comentario  varchar(250),
	@IndicadorAuditoria int,
	@UsuarioAuditoria varchar(25),
	@Estado int,
	@Persona int ,
	@Origen char(4) ,
	@NombreCompleto varchar(100) ,
	@IngresoFechaRegistro datetime,
	@IngresoAplicacionCodigo char(2) ,
	@IngresoUsuario varchar(25)  ,
	@Celular varchar(15) ,
	@EstadoPersona  char(1),
	@Medicamento varchar(max),	
	@FechaInicio datetime,
	@Accion	varchar(50),
	@Version varchar(50),
	@FechaFin datetime,
	@CodigoOA varchar(24),
	@Medico varchar(50),
	@Cama varchar(50)
AS
BEGIN
	DECLARE @CONTADOR INT				
	
	IF(@ACCION = 'LISTARBAND')
	BEGIN
	SELECT @CONTADOR=COUNT(*) FROM 
	 (	SELECT SS_HC_Medicamento.UnidadReplicacion,	SS_HC_Medicamento.IdEpisodioAtencion,	SS_HC_Medicamento.IdPaciente,
		SS_HC_Medicamento.EpisodioClinico,SFP.IdSolicitudProducto,vw.IdOrdenAtencion,vw.LineaOrdenAtencion  ,SFP.Estado,
		SFP.NumeroDocumento,GFD.ESTADODOCUMENTO, MEDICO.NombreCompleto MEDICO,SS_HC_Medicamento.NombreCompleto,
		vw.FechaAtencion , 	SS_HC_Medicamento.IngresoAplicacionCodigo  ,SFP.FechaCreacion,	vw.CodigoOA,
		SS_HC_Medicamento.EstadoPersona  FROM  VW_ATENCIONPACIENTEMEDICAMENTO AS SS_HC_Medicamento  WITH(NOLOCK) 
		INNER JOIN SS_HC_EpisodioAtencion vw WITH(NOLOCK) 
			on  (vw.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion and vw.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
			and vw.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico      and vw.IdPaciente=SS_HC_Medicamento.IdPaciente)
		INNER JOIN PERSONAMAST MEDICO  WITH(NOLOCK)  on MEDICO.Persona = vw.IdPersonalSalud
 		LEFT JOIN SS_FA_SolicitudProducto SFP WITH(NOLOCK) 
			on(SFP.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion and SFP.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
			and	SFP.IdPaciente=SS_HC_Medicamento.IdPaciente and	SFP.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico)
		LEFT JOIN  BDOncologico.[DBO].[SS_AD_GuiaFarmacia] GFD  WITH(NOLOCK)  ON GFD.IdGuiaFarmacia = SFP.IdSolicitudProducto 
		WHERE vw.TipoAtencion=2 	and  SS_HC_Medicamento.Medico in (1,4)	--	tipo  medicamentos		
			AND (@NombreCompleto is null	OR @NombreCompleto =''  OR  upper(SS_HC_Medicamento.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')  
			AND (@CodigoOA is null			OR @CodigoOA=''			OR @CodigoOA=vw.CodigoOA)
			AND (@Cama is null				OR @Cama=''				OR @Cama=SS_HC_Medicamento.Cama)
			AND (@Medico is null			OR @Medico =''			OR  upper(MEDICO.NombreCompleto ) like '%'+upper(@Medico)+'%')
			AND (ISNULL (SFP.FechaCreacion ,vw.FechaAtencion) between @FechaInicio and DATEADD(DAY,1,  @FechaFin)) 
		GROUP BY 	SS_HC_Medicamento.UnidadReplicacion,	SS_HC_Medicamento.IdEpisodioAtencion,	SS_HC_Medicamento.IdPaciente,
		SS_HC_Medicamento.EpisodioClinico,SFP.IdSolicitudProducto,vw.IdOrdenAtencion,vw.LineaOrdenAtencion  ,SFP.Estado,
		SFP.NumeroDocumento,GFD.ESTADODOCUMENTO,SS_HC_Medicamento.NombreCompleto, MEDICO.NombreCompleto,vw.FechaAtencion ,
			SS_HC_Medicamento.IngresoAplicacionCodigo  ,SFP.FechaCreacion,	vw.CodigoOA,SS_HC_Medicamento.EstadoPersona 
		) 	AS XXX


	SELECT SS_HC_Medicamento.UnidadReplicacion,	SS_HC_Medicamento.IdEpisodioAtencion,	SS_HC_Medicamento.IdPaciente   ,
		SS_HC_Medicamento.EpisodioClinico,	isnull(SFP.IdSolicitudProducto,0) as Secuencia,	Null as FechaCreacion,
		vw.LineaOrdenAtencion as IdUnidadMedida, NULL as Linea,	Convert(varchar(1),(ISNULL(SFP.Estado,1))) as Familia,
		null as SubFamilia,	Null as TipoComponente,	Convert(varchar,@CONTADOR)  as CodigoComponente,	vw.IdOrdenAtencion as IdVia,
		Null as Dosis,	Null as DiasTratamiento, NULL as Frecuencia, NULL  as Cantidad,
		Null as IndicadorEPS,	Null as TipoReceta,	NULL as Forma,	NULL as GrupoMedicamento,
		Null as Comentario,	SFP.IdSolicitudProducto as IndicadorAuditoria,
		RTRIM((ISNULL(SFP.NumeroDocumento,''))) as UsuarioAuditoria,  NULL as Accion ,
		ISNULL(case when GFD.ESTADODOCUMENTO is NULL THEN SFP.Estado ELSE GFD.ESTADODOCUMENTO  END ,1)  Estado,
		0 as Persona,	Null as Origen,	SS_HC_Medicamento.NombreCompleto ,	NUll as IngresoFechaRegistro,
		SS_HC_Medicamento.IngresoAplicacionCodigo  ,'' IngresoUsuario   ,
		CONVERT(varchar(10), CASE WHEN  SFP.IdSolicitudProducto IS NULL THEN vw.FechaAtencion ELSE SFP.FechaCreacion END , 103)  as Celular 	,
			SS_HC_Medicamento.EstadoPersona ,	Null as Medicamento,
		vw.CodigoOA,MEDICO.NombreCompleto as Medico,'' as cama
	FROM  VW_ATENCIONPACIENTEMEDICAMENTO AS SS_HC_Medicamento  WITH(NOLOCK) 
	INNER JOIN SS_HC_EpisodioAtencion vw  WITH(NOLOCK) 	ON  (vw.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 
			and vw.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
			and vw.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico      and vw.IdPaciente=SS_HC_Medicamento.IdPaciente)
	INNER JOIN PERSONAMAST MEDICO  WITH(NOLOCK)  ON MEDICO.Persona = vw.IdPersonalSalud
 	LEFT JOIN SS_FA_SolicitudProducto SFP	 WITH(NOLOCK) 	ON (SFP.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 
			and SFP.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
			and	SFP.IdPaciente=SS_HC_Medicamento.IdPaciente and	SFP.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico)
	LEFT JOIN  BDOncologico.[DBO].[SS_AD_GuiaFarmacia] GFD  WITH(NOLOCK)  ON GFD.IdGuiaFarmacia = SFP.IdSolicitudProducto 
	WHERE vw.TipoAtencion=2 	and  SS_HC_Medicamento.Medico in (1,4)--tipo  medicamentos		
		AND (@NombreCompleto is null	OR @NombreCompleto =''  OR  upper(SS_HC_Medicamento.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')  
		AND (@CodigoOA is null			OR @CodigoOA=''			OR @CodigoOA=vw.CodigoOA)
		AND (@Cama is null				OR @Cama=''				OR @Cama=SS_HC_Medicamento.Cama)
		AND (@Medico is null			OR @Medico =''			OR  upper(MEDICO.NombreCompleto ) like '%'+upper(@Medico)+'%')
		AND (ISNULL (SFP.FechaCreacion ,vw.FechaAtencion) between @FechaInicio and DATEADD(DAY,1,  @FechaFin))	
	GROUP BY 	SS_HC_Medicamento.UnidadReplicacion,	SS_HC_Medicamento.IdEpisodioAtencion,	SS_HC_Medicamento.IdPaciente,
	SS_HC_Medicamento.EpisodioClinico,SFP.IdSolicitudProducto,vw.IdOrdenAtencion,vw.LineaOrdenAtencion  ,SFP.Estado,
	SFP.NumeroDocumento,GFD.ESTADODOCUMENTO, MEDICO.NombreCompleto,SS_HC_Medicamento.NombreCompleto,
	vw.FechaAtencion , 	SS_HC_Medicamento.IngresoAplicacionCodigo  ,SFP.FechaCreacion,	vw.CodigoOA,
	SS_HC_Medicamento.EstadoPersona 
	END	

		
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarBandejaTriaje]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE OR ALTER PROCEDURE [SP_ListarBandejaTriaje]
@UnidadReplicacion varchar(10),
@PacienteBusqueda varchar(100),
@BusquedaDNI varchar(8),
@FechaInicio datetime,
@FechaFin datetime,
@Estado int,
@PrioridadTriaje int,
@Especialidad int,
@HistoriaClinica varchar(15),
@PageNumber int ,
@PageZize int
AS

if(@UnidadReplicacion='LISTA_PARA')
		select UnidadReplicacion as UnidadReplicacion, 0.0 as IdOrdenRelacionado, Secuencia as IdPaciente , Descripcion as Accion , 
		IdEpisodioAtencion as IdEpisodioTriaje, Descripcion as CodigoOT  
		, IdPaciente as IdPersonalSalud , null as FechaAtencion , null as IdEspecialidad, null as  Nombre , null as IdPrioridad,
		null as FlagFirma, null as FechaFirma, EpisodioClinico as IdMedicoFirma,null as ObservacionFirma , null as Version,
		null as Estado, ValorX as UsuarioCreacion, ValorY as UsuarioModificacion , null as FechaCreacion , null as FechaModificacion
		, null as Edad , null as Sexo , null as HoraIngreso from SS_HC_VIGILANCIA_DISPOSITIVOS_FE_LOCALIZACION 
		where IdPaciente = @Especialidad and IdEpisodioAtencion = @Estado and EpisodioClinico = @PrioridadTriaje;

ELSE
 
		select  Et.UnidadReplicacion , 
        Et.IdPaciente , 
		p.NombreCompleto Accion ,
		Et.IdEpisodioTriaje ,
		Et.CodigoOT, 
		IdPersonalSalud  , 
		FechaAtencion , 
		Et.IdEspecialidad , 
		Et.UsuarioCreacion AS Nombre , 
		IdPrioridad , 
		FlagFirma , 
		FechaFirma,
		Et.IdMedicoFirma , 
		Et.ObservacionFirma ,		
		pa.CodigoHC as Version,
		Et.Estado  ,
		iSNULL(E.Nombre,'POR ASIGNAR') AS UsuarioCreacion ,
		Et.UsuarioModificacion as UsuarioModificacion, 
		Et.FechaCreacion,
		Et.FechaModificacion  ,
		p.Edad ,
		p.Sexo,
		CONVERT(VARCHAR(5), Et.FechaCreacion, 108) + 
		(CASE WHEN DATEPART(HOUR, Et.FechaCreacion) > 12 THEN ' PM'
			ELSE ' AM'
		END) as HoraIngreso, 
		ISNULL(XXX.IdOrdenAtencion,0) as IdOrdenRelacionado
		from SS_HC_EpisodioTriaje Et 
		left join PERSONAMAST p on Et.IdPaciente = p.Persona 
		left join SS_GE_Paciente pa on Et.IdPaciente = pa.IdPaciente 
        left join SS_GE_Especialidad E on E.IdEspecialidad = Et.IdEspecialidad	
		LEFT JOIN (
		SELECT T.IdOrdenAtencion,f.IdEpisodioTriajeHCE,t.IDPACIENTE  FROM BDOncologico.dbo.[SS_CE_TriajeFirma] F 
				INNER JOIN BDOncologico.dbo.SS_CE_Triaje T ON F.IdTriaje=T.IdTriaje
				INNER JOIN BDOncologico.dbo.SS_AD_OrdenAtencion o ON T.IdOrdenAtencion=o.IdOrdenAtencion	
		) XXX ON XXX.IdEpisodioTriajeHCE =   Et.IdEpisodioTriaje AND XXX.IDPACIENTE=Et.IdPaciente	
	    where  
		(@UnidadReplicacion  is null OR Et.UnidadReplicacion = @UnidadReplicacion)
        AND (@PacienteBusqueda is null or @PacienteBusqueda='' or UPPER(p.NombreCompleto)like '%'+upper(@PacienteBusqueda)+'%')
        AND (@BusquedaDNI is null or @BusquedaDNI='' or UPPER(p.Documento)like '%'+upper(@BusquedaDNI)+'%')
        AND (@FechaInicio IS NULL OR FechaAtencion >=  @FechaInicio)
        AND (@FechaFin IS NULL OR FechaAtencion < DATEADD(DAY,1,@FechaFin))
        AND (@Estado is null or Et.Estado =@Estado)        
        AND (@PrioridadTriaje is null or @PrioridadTriaje='' or UPPER(IdPrioridad)like '%'+upper(@PrioridadTriaje)+'%')
        AND (@Especialidad is null or @Especialidad='' or UPPER(Et.IdEspecialidad)like '%'+upper(@Especialidad)+'%')
		AND (@HistoriaClinica is null or @HistoriaClinica='' or UPPER(pa.CodigoHC)like '%'+upper(@HistoriaClinica)+'%')
GO
/****** Object:  StoredProcedure [dbo].[SP_VW_ATENCIONPACIENTEMEDICAMENTO_Listar]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE OR ALTER PROCEDURE [SP_VW_ATENCIONPACIENTEMEDICAMENTO_Listar]
	@UnidadReplicacion  char(4) ,
	@IdEpisodioAtencion  bigint ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,	
	@Secuencia  int ,
	@IdUnidadMedida  int,
	@Linea  char(6),
	@Familia  char(6),
	@SubFamilia  char(6),	
	@TipoComponente  char(1),
	@CodigoComponente  varchar(25),
	@IdVia  int,
	@Dosis  varchar(250),
	@DiasTratamiento  decimal(9, 2),
	@Frecuencia  decimal(9, 2),
	@Cantidad  decimal(20, 6),
	@IndicadorEPS  int,
	@TipoReceta  int,
	@Forma int,
	@GrupoMedicamento int,
	@Comentario  varchar(250),
	@IndicadorAuditoria int,
	@UsuarioAuditoria varchar(25),
	@Estado int,
	@Persona int ,
	@Origen char(4) ,
	@NombreCompleto varchar(100) ,
	@IngresoFechaRegistro datetime,
	@IngresoAplicacionCodigo char(2) ,
	@IngresoUsuario varchar(25)  ,
	@Celular varchar(15) ,
	@EstadoPersona  char(1),
	@Medicamento varchar(max),	
	@FechaInicio datetime,
	@Accion	varchar(50),
	@Version varchar(50),
	@FechaFin datetime,
	@CodigoOA varchar(24),
	@Medico varchar(50),
	@Cama varchar(50)
AS
BEGIN
	DECLARE @CONTADOR INT				
	if(@ACCION = 'LISTARPAG')
	begin
		SET @CONTADOR=
		(
		SELECT count(*)
    FROM ((SELECT distinct	
		SS_HC_Medicamento.UsuarioAuditoria  as Cama 
	FROM  VW_ATENCIONPACIENTEMEDICAMENTO AS SS_HC_Medicamento 
		where
		(@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(SS_HC_Medicamento.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
		and      
		(@FechaInicio is null or  SS_HC_Medicamento.FechaCreacion >= @FechaInicio) 					   
		and SS_HC_Medicamento.IdEpisodioAtencion =@IdEpisodioAtencion
		and SS_HC_Medicamento.EpisodioClinico=@EpisodioClinico/**/ 					  
		and( @Medicamento is null or @Medicamento = '' or SS_HC_Medicamento.Medicamento like '%'+@Medicamento+'%' )
		and(  SS_HC_Medicamento.IndicadorAuditoria in (1,4) )
					)	) dw )
	
	(SELECT 
	SS_HC_Medicamento.UnidadReplicacion   ,
	SS_HC_Medicamento.IdEpisodioAtencion   ,
	SS_HC_Medicamento.IdPaciente   ,
	SS_HC_Medicamento.EpisodioClinico   ,	
	SS_HC_Medicamento.Secuencia   ,
	SS_HC_Medicamento.FechaCreacion,
	SS_HC_Medicamento.IdUnidadMedida  ,
	SS_HC_Medicamento.Linea  ,
	SS_HC_Medicamento.Familia  ,
	SS_HC_Medicamento.SubFamilia ,	
	(select PD.TipoComponente from SS_FA_SolicitudProductoDetalle PD where
	PD.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 
	and PD.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
	and PD.EpisodioClinico = SS_HC_Medicamento.EpisodioClinico 
	and	PD.IdPaciente=SS_HC_Medicamento.IdPaciente 
	and	PD.Secuencia=SS_HC_Medicamento.Secuencia 
	) as TipoComponente,
	SS_HC_Medicamento.CodigoComponente,
	SS_HC_Medicamento.IdVia  ,
	SS_HC_Medicamento.Dosis  ,
	SS_HC_Medicamento.DiasTratamiento ,
	SS_HC_Medicamento.Frecuencia  ,
	SS_HC_Medicamento.Cantidad  ,
	SS_HC_Medicamento.IndicadorEPS  ,
	SS_HC_Medicamento.TipoReceta  ,
	SS_HC_Medicamento.Forma ,
	SS_HC_Medicamento.GrupoMedicamento ,
	SS_HC_Medicamento.Comentario ,
	SS_HC_Medicamento.IndicadorAuditoria ,
	SS_HC_Medicamento.UsuarioAuditoria ,
   (select PD.Accion from SS_FA_SolicitudProductoDetalle PD where
	PD.IdEpisodioAtencion  = SS_HC_Medicamento.IdEpisodioAtencion 
	and PD.EpisodioClinico = SS_HC_Medicamento.EpisodioClinico 
	and PD.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 	
	and	PD.IdPaciente=SS_HC_Medicamento.IdPaciente 
	and	PD.Secuencia=SS_HC_Medicamento.Secuencia
	) as Accion,
	isnull((select PD.Estado from SS_FA_SolicitudProductoDetalle PD where
	PD.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 
	and PD.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
	and PD.EpisodioClinico = SS_HC_Medicamento.EpisodioClinico 
	and	PD.IdPaciente=SS_HC_Medicamento.IdPaciente 
	and	PD.Secuencia=SS_HC_Medicamento.Secuencia 
	),1) as Estado,
	SS_HC_Medicamento.Persona  ,
	SS_HC_Medicamento.Origen  ,
	SS_HC_Medicamento.NombreCompleto ,
	SS_HC_Medicamento.IngresoFechaRegistro ,
	SS_HC_Medicamento.IngresoAplicacionCodigo  ,
	SS_HC_Medicamento.IngresoUsuario   ,
	SS_HC_Medicamento.Celular  ,
	SS_HC_Medicamento.EstadoPersona ,
	SS_HC_Medicamento.Medicamento ,
	(select Convert(varchar(25),Convert(int,PD.Cantidad)) from SS_FA_SolicitudProductoDetalle PD where
	PD.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 
	and PD.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
	and PD.EpisodioClinico = SS_HC_Medicamento.EpisodioClinico 
	and	PD.IdPaciente=SS_HC_Medicamento.IdPaciente 
	and	PD.Secuencia=SS_HC_Medicamento.Secuencia 
	) as CodigoOA,
	CONVERT(varchar(10),@CONTADOR) as Medico,
	SS_HC_Medicamento.UsuarioAuditoria  as Cama

 FROM  VW_ATENCIONPACIENTEMEDICAMENTO AS SS_HC_Medicamento 
		where
		(@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(SS_HC_Medicamento.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
		and      
		(@FechaInicio is null or  SS_HC_Medicamento.FechaCreacion >= @FechaInicio) 					   
		and SS_HC_Medicamento.IdEpisodioAtencion =@IdEpisodioAtencion
		and SS_HC_Medicamento.EpisodioClinico=@EpisodioClinico/**/ 					  
		and( @Medicamento is null or @Medicamento = '' or SS_HC_Medicamento.Medicamento like '%'+@Medicamento+'%' )
		and(  SS_HC_Medicamento.IndicadorAuditoria in (1,4) )					)	
	order by SS_HC_Medicamento.IdPaciente , SS_HC_Medicamento.IdEpisodioAtencion,SS_HC_Medicamento.FechaCreacion
						
	END
	
		
	if(@ACCION = 'LISTARRES')
	begin
		SET @CONTADOR=(
					   select COUNT(*) from ( 
					   select LX.* from
							(
							select M.* from (
							select distinct 
							SS_HC_Medicamento.UnidadReplicacion   ,
					SS_HC_Medicamento.IdEpisodioAtencion   ,
					SS_HC_Medicamento.IdPaciente   ,
					SS_HC_Medicamento.EpisodioClinico   ,	
	
					0 as Secuencia,	
					(ISNULL((select top 1 SP.Estado from SS_FA_SolicitudProducto SP where SP.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion
					and SP.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and
					SP.IdPaciente=SS_HC_Medicamento.IdPaciente and
					SP.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico  and SP.Estado<4),1)) as Estado,
					0 as Persona,	
					SS_HC_Medicamento.NombreCompleto ,	
					SS_HC_Medicamento.IngresoAplicacionCodigo  ,
					SS_HC_Medicamento.IngresoUsuario   ,
					(SELECT CONVERT(varchar(10),(select TOP 1 PD.FechaCreacion from VW_ATENCIONPACIENTEMEDICAMENTO PD where
					PD.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion and
					PD.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and
					PD.IdPaciente=SS_HC_Medicamento.IdPaciente and
					PD.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico 	
					order by FechaCreacion asc), 103)) as Celular,	
					SS_HC_Medicamento.EstadoPersona ,	
					(select top 1 CodigoOA from VW_ATENCIONPACIENTE 
					where UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 
					and IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
					and EpisodioClinico=SS_HC_Medicamento.EpisodioClinico 
					and IdPaciente=SS_HC_Medicamento.IdPaciente)as CodigoOA, 
					'' as Medico
					,'' as cama
							from
							VW_ATENCIONPACIENTEMEDICAMENTO AS SS_HC_Medicamento inner join  VW_ATENCIONPACIENTE vw
 										on  (vw.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 
								and vw.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
								and vw.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico 
								and vw.TipoAtencion =2
								and vw.IdPaciente=SS_HC_Medicamento.IdPaciente)

							where
								(@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(SS_HC_Medicamento.NombreCompleto) like '%'+upper(@NombreCompleto)+'%') 
								and SS_HC_Medicamento.Medico in (1,4)--tipo  medicamentos 
								and (SS_HC_Medicamento.FechaCreacion between @FechaInicio and DATEADD(DAY,1,  @FechaFin))   
						
								and (@CodigoOA is null or @CodigoOA='' or @CodigoOA=vw.CodigoOA)
								and (@Cama is null or @Cama='' or @Cama=SS_HC_Medicamento.Cama)
								and vw.TipoAtencion=2
				) as M where M.Estado<4
				union all
				
				select distinct 
							SS_HC_Medicamento.UnidadReplicacion   ,
							SS_HC_Medicamento.IdEpisodioAtencion   ,
							SS_HC_Medicamento.IdPaciente   ,
							SS_HC_Medicamento.EpisodioClinico   ,		
							0 as Secuencia,	
							(ISNULL((select top 1 SP.Estado from SS_FA_SolicitudProducto SP where SP.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion
							and SP.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and
							SP.IdPaciente=SS_HC_Medicamento.IdPaciente and
							SP.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico and SP.Estado=4),1)) as Estado,
							0 as Persona,	
							SS_HC_Medicamento.NombreCompleto ,	
							SS_HC_Medicamento.IngresoAplicacionCodigo  ,
							SS_HC_Medicamento.IngresoUsuario   ,
							(SELECT CONVERT(varchar(10),(select TOP 1 PD.FechaCreacion from VW_ATENCIONPACIENTEMEDICAMENTO PD where
							PD.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion and
							PD.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and
							PD.IdPaciente=SS_HC_Medicamento.IdPaciente and
							PD.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico 	
							order by FechaCreacion asc), 103)) as Celular,	
							SS_HC_Medicamento.EstadoPersona ,	
							(select top 1 CodigoOA from VW_ATENCIONPACIENTE 
							where UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 
							and IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
							and EpisodioClinico=SS_HC_Medicamento.EpisodioClinico 
							and IdPaciente=SS_HC_Medicamento.IdPaciente)as CodigoOA, 
							vw.NombreEmergencia as Medico
							,'' as cama
							from
							VW_ATENCIONPACIENTEMEDICAMENTO AS SS_HC_Medicamento 
							inner join  VW_ATENCIONPACIENTE vw	on  (vw.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 
								and vw.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and vw.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico
								 and vw.IdPaciente=SS_HC_Medicamento.IdPaciente		and vw.TipoAtencion=2			)								
							inner join SS_FA_SolicitudProducto SFP	on (SFP.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion
								and SFP.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and SFP.IdPaciente=SS_HC_Medicamento.IdPaciente 
								and	SFP.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico)
							where
								(@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(SS_HC_Medicamento.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')   
								and vw.TipoAtencion=2
								and (SS_HC_Medicamento.FechaCreacion between @FechaInicio and DATEADD(DAY,1,  @FechaFin))   
								and SS_HC_Medicamento.Medico in (1,4)--tipo  medicamentos
								and (@CodigoOA is null or @CodigoOA='' or @CodigoOA=vw.CodigoOA)
								and (@Cama is null or @Cama='' or @Cama=SS_HC_Medicamento.Cama)
								AND (@Medico is null  OR @Medico =''  OR  upper(vw.NombreEmergencia) like '%'+upper(@Medico)+'%')    
								and (SFP.Estado = 4)
							)as LX where (@Estado is null or LX.Estado =@Estado) and (@Medico is null or @Medico = '' or LX.Medico=@Medico)
							) as LL	
					)
			SELECT
			UnidadReplicacion   ,
			IdEpisodioAtencion   ,
			IdPaciente   ,
			EpisodioClinico   ,
			Secuencia,
			FechaCreacion,
			IdUnidadMedida,
			Linea,
			Familia,
			SubFamilia,	
			TipoComponente,
			Convert(varchar(10),isNull(@CONTADOR,'0'))as CodigoComponente,
			IdVia,
			Dosis,
			DiasTratamiento,
			Frecuencia,
			Cantidad,
			IndicadorEPS,
			TipoReceta,
			Forma,
			GrupoMedicamento,
			Comentario,
			IndicadorAuditoria,
			UsuarioAuditoria,
			Accion,
			Estado,
			Persona,
			/*Convert(char(1),Estado) as*/ Origen,
			NombreCompleto ,
			IngresoFechaRegistro,
			IngresoAplicacionCodigo  ,
			IngresoUsuario   ,
			Celular,	
			EstadoPersona ,
			Medicamento,
			CodigoOA, 
			Medico,
			Cama
	
			FROM (
			select Lista.*  ,
		
			ROW_NUMBER() OVER (ORDER BY Lista.NombreCompleto DESC,Lista.IdEpisodioAtencion desc/*, Lista.Estado desc*/ ) AS RowNumber
	
			from (
	
			select /*innerLista.*,*/
	
			innerLista.UnidadReplicacion   ,
			innerLista.IdEpisodioAtencion   ,
			innerLista.IdPaciente   ,
			innerLista.EpisodioClinico   ,
			innerLista.Secuencia,
			innerLista.FechaCreacion,
			innerLista.IdUnidadMedida,
			innerLista.Linea,
			innerLista.Familia,
			innerLista.SubFamilia,	
			innerLista.TipoComponente,	
			innerLista.IdVia,
			innerLista.Dosis,
			innerLista.DiasTratamiento,
			innerLista.Frecuencia,
			innerLista.Cantidad,
			innerLista.IndicadorEPS,
			innerLista.TipoReceta,
			innerLista.Forma,
			innerLista.GrupoMedicamento,
			innerLista.Comentario,
			innerLista.IndicadorAuditoria,
			innerLista.UsuarioAuditoria,
			innerLista.Accion,
			innerLista.Estado,
			innerLista.Persona,
			Convert(char(1),innerLista.Estado) as Origen,
			innerLista.NombreCompleto ,
			innerLista.IngresoFechaRegistro,
			innerLista.IngresoAplicacionCodigo  ,
			innerLista.IngresoUsuario   ,
			innerLista.Celular,	
			innerLista.EstadoPersona ,
			innerLista.Medicamento,
			innerLista.CodigoOA, 
			innerLista.Medico,
			innerLista.Cama
	
	
			from (
	
			select M.* from(				
			SELECT DISTINCT
			SS_HC_Medicamento.UnidadReplicacion   ,
			SS_HC_Medicamento.IdEpisodioAtencion   ,
			SS_HC_Medicamento.IdPaciente   ,
			SS_HC_Medicamento.EpisodioClinico   ,		
			0 as Secuencia, 
			Null as FechaCreacion,
			vw.LineaOrdenAtencion as IdUnidadMedida, 
			null as Linea, 
			Convert(varchar(1),(ISNULL((select top 1 SP.Estado from SS_FA_SolicitudProducto SP where SP.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion
			and SP.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and
			SP.IdPaciente=SS_HC_Medicamento.IdPaciente and
			SP.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico and SP.Estado <4),1))) as Familia, 
			null as SubFamilia, 
			Null as TipoComponente, 
			Null as CodigoComponente, 
			vw.IdOrdenAtencion as IdVia,--SS_HC_Medicamento.IdVia  ,
			Null as Dosis,--SS_HC_Medicamento.Dosis  ,
			Null as DiasTratamiento,--SS_HC_Medicamento.DiasTratamiento ,
			Null as Frecuencia,--SS_HC_Medicamento.Frecuencia  ,
			null  as Cantidad,--SS_HC_Medicamento.Cantidad  ,
			Null as IndicadorEPS,--SS_HC_Medicamento.IndicadorEPS  ,
			Null as TipoReceta,--SS_HC_Medicamento.TipoReceta  ,
			Null as Forma,--SS_HC_Medicamento.Forma ,
			Null as GrupoMedicamento,--SS_HC_Medicamento.GrupoMedicamento ,
			Null as Comentario,--SS_HC_Medicamento.Comentario ,
			Null as IndicadorAuditoria,--SS_HC_Medicamento.IndicadorAuditoria ,
			RTRIM((ISNULL((select top 1 SP.NumeroDocumento from SS_FA_SolicitudProducto SP where SP.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion
			and SP.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and
			SP.IdPaciente=SS_HC_Medicamento.IdPaciente and
			SP.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico ),''))) as UsuarioAuditoria,--SS_HC_Medicamento.UsuarioAuditoria ,
			Null as Accion,--SS_HC_Medicamento.Accion,
			case when (select top 1 P.CantidadDespachada from  BDOncologico.dbo.SS_AD_OrdenAtencionDetalle P
			where P.SECUENCIALHCE= SS_HC_Medicamento.CodigoOA  and p.IdOrdenAtencion=vw.IdOrdenAtencion  and p.Linea=vw.LineaOrdenAtencion ) is not null then 3
			else (ISNULL((select top 1 SP.Estado from SS_FA_SolicitudProducto SP where SP.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion
			and SP.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and
			SP.IdPaciente=SS_HC_Medicamento.IdPaciente and
			SP.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico and SP.Estado <4),1)) end as Estado,--SS_HC_Medicamento.Estado ,
			0 as Persona,
			Null as Origen,--SS_HC_Medicamento.Origen  ,
			SS_HC_Medicamento.NombreCompleto ,
			NUll as IngresoFechaRegistro,/* SS_HC_Medicamento.IngresoFechaRegistro,*/
			SS_HC_Medicamento.IngresoAplicacionCodigo  ,
			SS_HC_Medicamento.IngresoUsuario   ,
			(SELECT CONVERT(varchar(10),(select TOP 1 PD.FechaCreacion from VW_ATENCIONPACIENTEMEDICAMENTO PD where
			PD.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion and
			PD.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and
			PD.IdPaciente=SS_HC_Medicamento.IdPaciente and
			PD.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico 
			order by FechaCreacion asc), 103)) as Celular,

			SS_HC_Medicamento.EstadoPersona ,
			Null as Medicamento,--SS_HC_Medicamento.Medicamento,
			(select top 1 CodigoOA from VW_ATENCIONPACIENTE 
			where UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 
			and IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
			and EpisodioClinico=SS_HC_Medicamento.EpisodioClinico 
			and IdPaciente=SS_HC_Medicamento.IdPaciente)as CodigoOA, 
			vw.NombreEmergencia as Medico
			,'' as cama
 			FROM  VW_ATENCIONPACIENTEMEDICAMENTO AS SS_HC_Medicamento inner join  VW_ATENCIONPACIENTE vw
 			on  (vw.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 
			and vw.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
			and vw.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico 
			and vw.TipoAtencion=2
			and vw.IdPaciente=SS_HC_Medicamento.IdPaciente)  			
				where
			(@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(SS_HC_Medicamento.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
				and (@Cama is null or @Cama='' or @Cama=SS_HC_Medicamento.Cama)
				AND (@Medico is null  OR @Medico =''  OR  upper(vw.NombreEmergencia) like '%'+upper(@Medico)+'%') 
				and SS_HC_Medicamento.Medico in (1,4)--tipo  medicamentos
				and vw.TipoAtencion=2
			and ( SS_HC_Medicamento.FechaCreacion between @FechaInicio and DATEADD(DAY,1,  @FechaFin))   			
			and (@CodigoOA is null or @CodigoOA='' or @CodigoOA=vw.CodigoOA)		
	) as M where M.Estado<4
	
	union ALL
	
	SELECT distinct
	SS_HC_Medicamento.UnidadReplicacion   ,
	SS_HC_Medicamento.IdEpisodioAtencion   ,
	SS_HC_Medicamento.IdPaciente   ,
	SS_HC_Medicamento.EpisodioClinico   ,	
	0 as Secuencia, 
	Null as FechaCreacion,
	vw.IdOrdenAtencion as IdUnidadMedida,--SS_HC_Medicamento.IdUnidadMedida  ,
	vw.LineaOrdenAtencion as Linea,--SS_HC_Medicamento.Linea  ,
	Convert(varchar(1),(ISNULL((select SP.Estado from SS_FA_SolicitudProducto SP where SP.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion
	and SP.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and
	SP.IdPaciente=SS_HC_Medicamento.IdPaciente and
	SP.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico and SP.Estado =4),1))) as Familia,--SS_HC_Medicamento.Familia  ,
	null as SubFamilia,--SS_HC_Medicamento.SubFamilia ,	
	Null as TipoComponente,--SS_HC_Medicamento.TipoComponente  ,
	Null as CodigoComponente,--SS_HC_Medicamento.CodigoComponente,
	vw.IdOrdenAtencion as IdVia,--SS_HC_Medicamento.IdVia  ,
	Null as Dosis,--SS_HC_Medicamento.Dosis  ,
	Null as DiasTratamiento,--SS_HC_Medicamento.DiasTratamiento ,
	Null as Frecuencia,--SS_HC_Medicamento.Frecuencia  ,
	null as Cantidad,--SS_HC_Medicamento.Cantidad  ,
	Null as IndicadorEPS,--SS_HC_Medicamento.IndicadorEPS  ,
	Null as TipoReceta,--SS_HC_Medicamento.TipoReceta  ,
	Null as Forma,--SS_HC_Medicamento.Forma ,
	Null as GrupoMedicamento,--SS_HC_Medicamento.GrupoMedicamento ,
	Null as Comentario,--SS_HC_Medicamento.Comentario ,
	Null as IndicadorAuditoria,--SS_HC_Medicamento.IndicadorAuditoria ,
	RTRIM((ISNULL((select top 1 SP.NumeroDocumento from SS_FA_SolicitudProducto SP where SP.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion
	and SP.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and
	SP.IdPaciente=SS_HC_Medicamento.IdPaciente and
	SP.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico ),''))) as UsuarioAuditoria,--SS_HC_Medicamento.UsuarioAuditoria ,
    Null as Accion,--SS_HC_Medicamento.Accion,
   (ISNULL((select top 1 SP.Estado from SS_FA_SolicitudProducto SP where SP.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion
	and SP.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and
	SP.IdPaciente=SS_HC_Medicamento.IdPaciente and
	SP.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico and SP.Estado <4),1))  as Estado,--SS_HC_Medicamento.Estado ,
	0 as Persona,
	Null as Origen,--SS_HC_Medicamento.Origen  ,
	SS_HC_Medicamento.NombreCompleto ,
	NUll as IngresoFechaRegistro,/* SS_HC_Medicamento.IngresoFechaRegistro,*/
	SS_HC_Medicamento.IngresoAplicacionCodigo  ,
	SS_HC_Medicamento.IngresoUsuario   ,
	(SELECT CONVERT(varchar(10),(select TOP 1 PD.FechaCreacion from VW_ATENCIONPACIENTEMEDICAMENTO PD where
	PD.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion and
	PD.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and
	PD.IdPaciente=SS_HC_Medicamento.IdPaciente and
	PD.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico  
	order by FechaCreacion asc), 103)) as Celular,
 
	SS_HC_Medicamento.EstadoPersona ,
	Null as Medicamento,--SS_HC_Medicamento.Medicamento,
	(select distinct CodigoOA from VW_ATENCIONPACIENTE 
	where UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 
	and IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
	and EpisodioClinico=SS_HC_Medicamento.EpisodioClinico 
	and IdPaciente=SS_HC_Medicamento.IdPaciente)as CodigoOA, 
 
	vw.NombreEmergencia as Medico
 
	,'' as cama

 			FROM  VW_ATENCIONPACIENTEMEDICAMENTO AS SS_HC_Medicamento inner join  VW_ATENCIONPACIENTE vw
 			on  (vw.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 
			and vw.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
			and vw.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico 
			and vw.TipoAtencion=2
			and vw.IdPaciente=SS_HC_Medicamento.IdPaciente) inner join SS_FA_SolicitudProducto SFP
	
			on(SFP.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion
			and SFP.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and
			SFP.IdPaciente=SS_HC_Medicamento.IdPaciente and
			SFP.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico)
 			
		where
			(@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(SS_HC_Medicamento.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
				and (@Cama is null or @Cama='' or @Cama=SS_HC_Medicamento.Cama)
					AND (@Medico is null  OR @Medico =''  OR  upper(vw.NombreEmergencia) like '%'+upper(@Medico)+'%') 
				and SS_HC_Medicamento.Medico in (1,4)
				and vw.TipoAtencion=2				 
			and (SS_HC_Medicamento.FechaCreacion between @FechaInicio and DATEADD(DAY,1,  @FechaFin))   
					
			and (@CodigoOA is null or @CodigoOA='' or @CodigoOA=vw.CodigoOA)
			and (SFP.Estado = 4)					
	
	) as innerLista	
	
	 where (@Estado is null or innerLista.Estado =@Estado)-- and (@Medico is null or @Medico = '' or innerLista.Medico=@Medico)
	AND (@Medico is null  OR @Medico =''  OR  upper(innerLista.Medico) like '%'+upper(@Medico)+'%') 
	
	) as Lista 	
	)
	AS LISTADO
	WHERE (CONVERT(int, @Linea)  Is null AND CONVERT(int, @SubFamilia) Is null) OR      
            RowNumber BETWEEN CONVERT(int, @Linea)  AND CONVERT(int, @SubFamilia) 
	order by RowNumber asc	
	
	END		
	
	if(@ACCION = 'LISTARBAND')
	begin

		SELECT @CONTADOR=COUNT(*) FROM 
		 (	SELECT SS_HC_Medicamento.UnidadReplicacion,	SS_HC_Medicamento.IdEpisodioAtencion,	SS_HC_Medicamento.IdPaciente,
			SS_HC_Medicamento.EpisodioClinico,SFP.IdSolicitudProducto,vw.IdOrdenAtencion,vw.LineaOrdenAtencion  ,SFP.Estado,
			SFP.NumeroDocumento,GFD.ESTADODOCUMENTO, MEDICO.NombreCompleto MEDICO,SS_HC_Medicamento.NombreCompleto,
			vw.FechaAtencion , 	SS_HC_Medicamento.IngresoAplicacionCodigo  ,SFP.FechaCreacion,	vw.CodigoOA,
			SS_HC_Medicamento.EstadoPersona  FROM  VW_ATENCIONPACIENTEMEDICAMENTO AS SS_HC_Medicamento  WITH(NOLOCK) 
			INNER JOIN SS_HC_EpisodioAtencion vw WITH(NOLOCK) 
				on  (vw.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion and vw.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
				and vw.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico      and vw.IdPaciente=SS_HC_Medicamento.IdPaciente)
			INNER JOIN PERSONAMAST MEDICO  WITH(NOLOCK)  on MEDICO.Persona = vw.IdPersonalSalud
 			LEFT JOIN SS_FA_SolicitudProducto SFP WITH(NOLOCK) 
				on(SFP.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion and SFP.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
				and	SFP.IdPaciente=SS_HC_Medicamento.IdPaciente and	SFP.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico)
			LEFT JOIN  BDOncologico.dbo.SS_AD_GuiaFarmacia GFD  WITH(NOLOCK)  ON GFD.IdGuiaFarmacia = SFP.IdSolicitudProducto 
			WHERE vw.TipoAtencion=2 	and  SS_HC_Medicamento.Medico in (1,4)	--	tipo  medicamentos		
				AND (@NombreCompleto is null	OR @NombreCompleto =''  OR  upper(SS_HC_Medicamento.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')  
				AND (@CodigoOA is null			OR @CodigoOA=''			OR @CodigoOA=vw.CodigoOA)
				AND (@Cama is null				OR @Cama=''				OR @Cama=SS_HC_Medicamento.Cama)
				AND (@Medico is null			OR @Medico =''			OR  upper(MEDICO.NombreCompleto ) like '%'+upper(@Medico)+'%')
				AND (ISNULL (SFP.FechaCreacion ,vw.FechaAtencion) between @FechaInicio and DATEADD(DAY,1,  @FechaFin)) 
			GROUP BY 	SS_HC_Medicamento.UnidadReplicacion,	SS_HC_Medicamento.IdEpisodioAtencion,	SS_HC_Medicamento.IdPaciente,
			SS_HC_Medicamento.EpisodioClinico,SFP.IdSolicitudProducto,vw.IdOrdenAtencion,vw.LineaOrdenAtencion  ,SFP.Estado,
			SFP.NumeroDocumento,GFD.ESTADODOCUMENTO,SS_HC_Medicamento.NombreCompleto, MEDICO.NombreCompleto,vw.FechaAtencion ,
				SS_HC_Medicamento.IngresoAplicacionCodigo  ,SFP.FechaCreacion,	vw.CodigoOA,SS_HC_Medicamento.EstadoPersona 
			) 	AS XXX

	

		SELECT SS_HC_Medicamento.UnidadReplicacion,	SS_HC_Medicamento.IdEpisodioAtencion,	SS_HC_Medicamento.IdPaciente   ,
			SS_HC_Medicamento.EpisodioClinico,	isnull(SFP.IdSolicitudProducto,0) as Secuencia,	Null as FechaCreacion,
			vw.LineaOrdenAtencion as IdUnidadMedida, NULL as Linea,	Convert(varchar(1),(ISNULL(SFP.Estado,1))) as Familia,
			null as SubFamilia,	Null as TipoComponente,	Convert(varchar,@CONTADOR)  as CodigoComponente,	vw.IdOrdenAtencion as IdVia,
			Null as Dosis,	Null as DiasTratamiento, NULL as Frecuencia, NULL  as Cantidad,
			Null as IndicadorEPS,	Null as TipoReceta,	NULL as Forma,	NULL as GrupoMedicamento,
			Null as Comentario,	SFP.IdSolicitudProducto as IndicadorAuditoria,
			RTRIM((ISNULL(SFP.NumeroDocumento,''))) as UsuarioAuditoria,  NULL as Accion ,
			ISNULL(case when GFD.ESTADODOCUMENTO is NULL THEN SFP.Estado ELSE (case when GFD.ESTADODOCUMENTO = 1 then 2 when GFD.ESTADODOCUMENTO = 2 then 3 else 1 end) END ,1)  Estado,
			0 as Persona,	Null as Origen,	SS_HC_Medicamento.NombreCompleto ,	NUll as IngresoFechaRegistro,
			SS_HC_Medicamento.IngresoAplicacionCodigo  ,'' IngresoUsuario   ,
			CONVERT(varchar(10), CASE WHEN  SFP.IdSolicitudProducto IS NULL THEN vw.FechaAtencion ELSE SFP.FechaCreacion END , 103) as Celular 	,
				SS_HC_Medicamento.EstadoPersona ,	Null as Medicamento,
			vw.CodigoOA,MEDICO.NombreCompleto as Medico,'' as cama
		FROM  VW_ATENCIONPACIENTEMEDICAMENTO AS SS_HC_Medicamento  WITH(NOLOCK) 
		INNER JOIN SS_HC_EpisodioAtencion vw  WITH(NOLOCK) 	ON  (vw.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 
				and vw.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
				and vw.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico      and vw.IdPaciente=SS_HC_Medicamento.IdPaciente)
		INNER JOIN PERSONAMAST MEDICO  WITH(NOLOCK)  ON MEDICO.Persona = vw.IdPersonalSalud
 		LEFT JOIN SS_FA_SolicitudProducto SFP	 WITH(NOLOCK) 	ON (SFP.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 
				and SFP.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
				and	SFP.IdPaciente=SS_HC_Medicamento.IdPaciente and	SFP.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico)
		LEFT JOIN  BDOncologico.dbo.SS_AD_GuiaFarmacia GFD  WITH(NOLOCK)  ON GFD.IdGuiaFarmacia = SFP.IdSolicitudProducto 
		WHERE vw.TipoAtencion=2 	and  SS_HC_Medicamento.Medico in (1,4)--tipo  medicamentos		
			AND (@NombreCompleto is null	OR @NombreCompleto =''  OR upper(SS_HC_Medicamento.NombreCompleto) like '%'+ upper(@NombreCompleto)+'%')  
			AND (@CodigoOA is null			OR @CodigoOA=''			OR upper(vw.CodigoOA) like '%'+ upper(@CodigoOA)+'%')
			AND (@Cama is null				OR @Cama=''				OR @Cama=SS_HC_Medicamento.Cama)
			AND (@Medico is null			OR @Medico =''			OR upper(MEDICO.NombreCompleto ) like '%'+ upper(@Medico)+'%')
			AND (ISNULL (SFP.FechaCreacion ,vw.FechaAtencion) between @FechaInicio and DATEADD(DAY,1,  @FechaFin))
			and (@Estado is null or @Estado='' or  ISNULL(case when GFD.ESTADODOCUMENTO is NULL THEN SFP.Estado ELSE (case when GFD.ESTADODOCUMENTO = 1 then 2 when GFD.ESTADODOCUMENTO = 2 then 3 else 1 end) END ,1)
			 = @Estado)		 
		GROUP BY 	SS_HC_Medicamento.UnidadReplicacion,	SS_HC_Medicamento.IdEpisodioAtencion,	SS_HC_Medicamento.IdPaciente,
		SS_HC_Medicamento.EpisodioClinico,SFP.IdSolicitudProducto,vw.IdOrdenAtencion,vw.LineaOrdenAtencion  ,SFP.Estado,
		SFP.NumeroDocumento,GFD.ESTADODOCUMENTO, MEDICO.NombreCompleto,SS_HC_Medicamento.NombreCompleto,
		vw.FechaAtencion , 	SS_HC_Medicamento.IngresoAplicacionCodigo  ,SFP.FechaCreacion,	vw.CodigoOA,
		SS_HC_Medicamento.EstadoPersona 
		

	
	END		
	/*** KARDEX ***/
	if(@ACCION = 'LISTARKAR')
	begin
		SET @CONTADOR=(SELECT top 1 SUM(COUNT( DISTINCT NombreCompleto))OVER() 
					from VW_ATENCIONPACIENTEMEDICAMENTO	where 	(
						(VW_ATENCIONPACIENTEMEDICAMENTO.FechaCreacion between @FechaInicio and DATEADD(DAY,1,  DATEADD(DAY,1,  @FechaFin)))
							)
						group by IdEpisodioAtencion 
				
					)		
			SELECT DISTINCT
			SS_HC_Medicamento.UnidadReplicacion   ,
			SS_HC_Medicamento.IdEpisodioAtencion   ,
			SS_HC_Medicamento.IdPaciente   ,
			SS_HC_Medicamento.EpisodioClinico   ,		
			0 as Secuencia,--SS_HC_Medicamento.Secuencia   ,
			Null as FechaCreacion,/*SS_HC_Medicamento.FechaCreacion,*/
			Null as IdUnidadMedida,--SS_HC_Medicamento.IdUnidadMedida  ,
			Null as Linea,--SS_HC_Medicamento.Linea  ,
			Null as Familia,--SS_HC_Medicamento.Familia  ,
			Null as SubFamilia,--SS_HC_Medicamento.SubFamilia ,	
			Null as TipoComponente,--SS_HC_Medicamento.TipoComponente  ,
			Null as CodigoComponente,--SS_HC_Medicamento.CodigoComponente,
			Null as IdVia,--SS_HC_Medicamento.IdVia  ,
			Null as Dosis,--SS_HC_Medicamento.Dosis  ,
			Null as DiasTratamiento,--SS_HC_Medicamento.DiasTratamiento ,
			Null as Frecuencia,--SS_HC_Medicamento.Frecuencia  ,
			Null as Cantidad,--SS_HC_Medicamento.Cantidad  ,
			Null as IndicadorEPS,--SS_HC_Medicamento.IndicadorEPS  ,
			Null as TipoReceta,--SS_HC_Medicamento.TipoReceta  ,
			Null as Forma,--SS_HC_Medicamento.Forma ,
			Null as GrupoMedicamento,--SS_HC_Medicamento.GrupoMedicamento ,
			Null as Comentario,--SS_HC_Medicamento.Comentario ,
			Null as IndicadorAuditoria,--SS_HC_Medicamento.IndicadorAuditoria ,
			Null as UsuarioAuditoria,--SS_HC_Medicamento.UsuarioAuditoria ,
			Null as Accion,--SS_HC_Medicamento.Accion,
			Null as Estado,--SS_HC_Medicamento.Estado ,
			0 as Persona,--SS_HC_Medicamento.Persona  ,
			Null as Origen,--SS_HC_Medicamento.Origen  ,
			SS_HC_Medicamento.NombreCompleto ,
			NUll as IngresoFechaRegistro,/* SS_HC_Medicamento.IngresoFechaRegistro,*/
			SS_HC_Medicamento.IngresoAplicacionCodigo  ,
			SS_HC_Medicamento.IngresoUsuario   ,
			(SELECT CONVERT(varchar(10),(select TOP 1 PD.FechaCreacion from VW_ATENCIONPACIENTEMEDICAMENTO PD where
			PD.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion and
			PD.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and
			PD.IdPaciente=SS_HC_Medicamento.IdPaciente and
			PD.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico  
			order by FechaCreacion asc), 103)) as Celular,
 
			SS_HC_Medicamento.EstadoPersona ,
			Null as Medicamento,--SS_HC_Medicamento.Medicamento,
			(select top 1 CodigoOA from VW_ATENCIONPACIENTE 
			where UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 
			and IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
			and EpisodioClinico=SS_HC_Medicamento.EpisodioClinico 
			and IdPaciente=SS_HC_Medicamento.IdPaciente)as CodigoOA, 
			(select top 1 P.NombreCompleto from BDOncologico.dbo.SS_HO_Hospitalizacion H 
		inner join BDOncologico.dbo.PersonaMast P on H.MedicoResponsable=P.Persona 
		inner join VW_ATENCIONPACIENTE V 
		on H.IdOrdenAtencion=V.IdOrdenAtencion
		where V.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 
			and V.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
			and V.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico 
			and V.IdPaciente=SS_HC_Medicamento.IdPaciente)as Medico
			, (select top 1 C.Nombre from BDOncologico.dbo.SS_HO_Hospitalizacion H 
			inner join BDOncologico.dbo.SS_GE_Consultorio C on H.Cama=C.IdConsultorio inner join VW_ATENCIONPACIENTE V 
		on H.IdOrdenAtencion=V.IdOrdenAtencion
		where V.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 
			and V.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
			and V.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico 
			and V.IdPaciente=SS_HC_Medicamento.IdPaciente)as Cama

 			FROM  VW_ATENCIONPACIENTEMEDICAMENTO AS SS_HC_Medicamento inner join SS_FA_SolicitudProducto on SS_FA_SolicitudProducto.IdPaciente= SS_HC_Medicamento.IdPaciente
			where SS_FA_SolicitudProducto.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion and
		SS_FA_SolicitudProducto.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and
		SS_FA_SolicitudProducto.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico and	
		(@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(SS_HC_Medicamento.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
		and (/*@FechaInicio is null or @FechaFin is null or */SS_HC_Medicamento.FechaCreacion between @FechaInicio and DATEADD(DAY,1,  @FechaFin))   
		order by SS_HC_Medicamento.IdPaciente , SS_HC_Medicamento.IdEpisodioAtencion,Celular	
	END	
	
	
	
	if(@ACCION = 'LISTARKARDEX')
	begin

			(SELECT 
			SS_HC_Medicamento.UnidadReplicacion   ,
			SS_HC_Medicamento.IdEpisodioAtencion   ,
			SS_HC_Medicamento.IdPaciente   ,
			SS_HC_Medicamento.EpisodioClinico   ,	
			SS_HC_Medicamento.Secuencia   ,
			SS_HC_Medicamento.FechaCreacion,
			SS_HC_Medicamento.IdUnidadMedida  ,
			SS_HC_Medicamento.Linea  ,
			SS_HC_Medicamento.Familia  ,
			SS_HC_Medicamento.SubFamilia ,	
			(select top 1 PD.TipoComponente from SS_FA_SolicitudProductoDetalle PD where
				PD.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 
			and PD.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
			and PD.EpisodioClinico = SS_HC_Medicamento.EpisodioClinico 
			and	PD.IdPaciente=SS_HC_Medicamento.IdPaciente 
			and	PD.Secuencia=SS_HC_Medicamento.Secuencia 
			) as TipoComponente,/*SS_HC_Medicamento.TipoComponente  ,*/
			SS_HC_Medicamento.CodigoComponente,
			SS_HC_Medicamento.IdVia  ,
			(select ED.EnfermeraSuministro from SS_HC_KardexEnfermeriaDetalle ED where
				ED.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 
			and ED.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
			and ED.EpisodioClinico = SS_HC_Medicamento.EpisodioClinico 
			and	ED.IdPaciente=SS_HC_Medicamento.IdPaciente 
			and	ED.Secuencia=SS_HC_Medicamento.Secuencia 
			and			ED.Fecha=@FechaInicio
			) as Dosis,/*SS_HC_Medicamento.Dosis  ,*/
			SS_HC_Medicamento.DiasTratamiento ,
			SS_HC_Medicamento.Frecuencia  ,
			SS_HC_Medicamento.Cantidad  ,
			SS_HC_Medicamento.IndicadorEPS  ,
			SS_HC_Medicamento.TipoReceta  ,
			SS_HC_Medicamento.Forma ,
			isnull(SS_HC_Medicamento.GrupoMedicamento,0) as GrupoMedicamento ,
			(select ED.HorasSuministradas from SS_HC_KardexEnfermeriaDetalle ED where
					ED.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 
				and ED.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
				and ED.EpisodioClinico = SS_HC_Medicamento.EpisodioClinico 
				and	ED.IdPaciente=SS_HC_Medicamento.IdPaciente 
				and	ED.Secuencia=SS_HC_Medicamento.Secuencia 
			and	ED.Fecha=@FechaInicio
			/*PD.CodigoComponente=SS_HC_Medicamento.CodigoComponente*/
			) as Comentario,/*SS_HC_Medicamento.Comentario ,*/
			SS_HC_Medicamento.IndicadorAuditoria ,
			(select ( Convert(varchar(2),(DATEPART(hh,(select top 1 (DATEADD(HOUR,5,PD.FechaCorte))  from SS_HC_KardexEnfermeriaDetalle PD where
			PD.UnidadReplicacion=@UnidadReplicacion and
			PD.IdEpisodioAtencion=@IdEpisodioAtencion and
			PD.EpisodioClinico=@EpisodioClinico and
			PD.IdPaciente=@IdPaciente and	
			PD.CodigoComponente=SS_HC_Medicamento.CodigoComponente
			and (DATEADD(day,1,@FechaInicio)> PD.FechaCorte) order by PD.FechaCorte desc
			))))+':'+
			 Convert(varchar(2),(DATEPART(MINUTE,(select top 1 (DATEADD(HOUR,5,PD.FechaCorte))  from SS_HC_KardexEnfermeriaDetalle PD where
			PD.UnidadReplicacion=@UnidadReplicacion and
			PD.IdEpisodioAtencion=@IdEpisodioAtencion and
			PD.EpisodioClinico=@EpisodioClinico and
			PD.IdPaciente=@IdPaciente and	
			PD.CodigoComponente=SS_HC_Medicamento.CodigoComponente
			and (DATEADD(day,1,@FechaInicio)> PD.FechaCorte) order by PD.FechaCorte desc
			))))
			)
			) as UsuarioAuditoria, /*SS_HC_Medicamento.UsuarioAuditoria ,*/
		   (select PD.Accion from SS_HC_KardexEnfermeriaDetalle PD where
			PD.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 
				and PD.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
				and PD.EpisodioClinico = SS_HC_Medicamento.EpisodioClinico 
				and	PD.IdPaciente=SS_HC_Medicamento.IdPaciente 
				and	PD.Secuencia=SS_HC_Medicamento.Secuencia 
			and PD.Fecha=@FechaInicio /*and
			PD.CodigoComponente=SS_HC_Medicamento.CodigoComponente*/
			) as Accion,
			isnull((select top 1 PD.Estado from SS_HC_KardexEnfermeriaDetalle PD where
			PD.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 
				and PD.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
				and PD.EpisodioClinico = SS_HC_Medicamento.EpisodioClinico 
				and	PD.IdPaciente=SS_HC_Medicamento.IdPaciente 
				and	PD.Secuencia=SS_HC_Medicamento.Secuencia 
			and	PD.CodigoComponente=SS_HC_Medicamento.CodigoComponente
			and Convert(int,PD.Version) = isNull(SS_HC_Medicamento.GrupoMedicamento,0)
			and
			DAY(PD.Fecha)=DAY(@FechaInicio)
			and
			MONTH(PD.Fecha)=MONTH(@FechaInicio)
			),1) as Estado,
			/*SS_HC_Medicamento.Estado ,*/
			SS_HC_Medicamento.Persona  ,
			SS_HC_Medicamento.Origen  ,
			(select P.NombreCompleto from PERSONAMAST P inner join SG_Agente A on P.Persona = A.IdEmpleado where A.IdAgente =
	
			(select ED.UsuarioCreacion from SS_HC_KardexEnfermeriaDetalle ED where
					ED.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 
				and ED.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
				and ED.EpisodioClinico = SS_HC_Medicamento.EpisodioClinico 
				and	ED.IdPaciente=SS_HC_Medicamento.IdPaciente 
				and	ED.Secuencia=SS_HC_Medicamento.Secuencia 
			and	ED.Fecha=@FechaInicio	
			)) as NombreCompleto,/*SS_HC_Medicamento.NombreCompleto ,*/
			(select top 1 DATEADD(HOUR,5,PD.HoraInicioProg) from SS_HC_KardexEnfermeriaDetalle PD where
			PD.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 
				and PD.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
				and PD.EpisodioClinico = SS_HC_Medicamento.EpisodioClinico 
				and	PD.IdPaciente=SS_HC_Medicamento.IdPaciente 
				and	PD.Secuencia=SS_HC_Medicamento.Secuencia 
			and PD.CodigoComponente=SS_HC_Medicamento.CodigoComponente
			and
			DAY(PD.Fecha)=DAY(@FechaInicio)
			) as IngresoFechaRegistro ,
			SS_HC_Medicamento.IngresoAplicacionCodigo  ,
			SS_HC_Medicamento.IngresoUsuario   ,
			SS_HC_Medicamento.Celular  ,
			SS_HC_Medicamento.EstadoPersona ,
			SS_HC_Medicamento.Medicamento ,
			(select convert(varchar(10),(select top 1 DATEADD(HOUR,5,PD.FechaCorte)  from SS_HC_KardexEnfermeriaDetalle PD where
			PD.UnidadReplicacion=@UnidadReplicacion and
			PD.IdEpisodioAtencion=@IdEpisodioAtencion and
			PD.EpisodioClinico=@EpisodioClinico and
			PD.IdPaciente=@IdPaciente and
			/*PD.Secuencia=SS_HC_Medicamento.Secuencia and*/
			PD.CodigoComponente=SS_HC_Medicamento.CodigoComponente
			and (DATEADD(day,1,@FechaInicio)> PD.FechaCorte) order by PD.FechaCorte desc
			/*(DAY(PD.Fecha)=DAY(@FechaInicio) or DAY(PD.Fecha)<DAY(@FechaInicio))*/),103)
			) as CodigoOA,
			(select ED.HorasProgramadas from SS_HC_KardexEnfermeriaDetalle ED where
					ED.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 
				and ED.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
				and ED.EpisodioClinico = SS_HC_Medicamento.EpisodioClinico 
				and	ED.IdPaciente=SS_HC_Medicamento.IdPaciente 
				and	ED.Secuencia=SS_HC_Medicamento.Secuencia 
			and	ED.Fecha=@FechaInicio
			/*PD.CodigoComponente=SS_HC_Medicamento.CodigoComponente*/
			) as Medico,
			convert(varchar(2),(select ED.UnidadTiempo from SS_HC_Medicamento_FE ED where
					ED.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion 
				and ED.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
				and ED.EpisodioClinico = SS_HC_Medicamento.EpisodioClinico 
				and	ED.IdPaciente=SS_HC_Medicamento.IdPaciente 
				and	ED.Secuencia=SS_HC_Medicamento.Secuencia 
			and	ED.CodigoComponente=SS_HC_Medicamento.CodigoComponente)) as Cama

		  FROM  VW_ATENCIONPACIENTEMEDICAMENTO AS SS_HC_Medicamento 
				where
			           (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(SS_HC_Medicamento.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
					  and (SS_HC_Medicamento.IdEpisodioAtencion =@IdEpisodioAtencion)
					  and (SS_HC_Medicamento.EpisodioClinico=@EpisodioClinico)/**/
	
    )	
	
	order by SS_HC_Medicamento.IdPaciente , SS_HC_Medicamento.IdEpisodioAtencion,SS_HC_Medicamento.FechaCreacion
						
	END
	if(@ACCION = 'LISTARMEDDEV')
	begin
		SET @CONTADOR=(SELECT COUNT(*) 
					from VW_ATENCIONPACIENTEMEDICAMENTO						
						where 
						
					   (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(VW_ATENCIONPACIENTEMEDICAMENTO.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
					   and (     
					   (@FechaInicio is null or  VW_ATENCIONPACIENTEMEDICAMENTO.FechaCreacion >= @FechaInicio)    
					   and    
					   (@FechaFin is null or  VW_ATENCIONPACIENTEMEDICAMENTO.FechaCreacion <= DATEADD(DAY,1,@FechaFin))    
					   )    
					   /*and (@IdPaciente is null OR VW_ATENCIONPACIENTEMEDICAMENTO.IdPaciente = @IdPaciente)    	*/	
					)		
			(SELECT 
			SS_HC_Medicamento.UnidadReplicacion   ,
			SS_HC_Medicamento.IdEpisodioAtencion   ,
			SS_HC_Medicamento.IdPaciente   ,
			SS_HC_Medicamento.EpisodioClinico   ,	
			SS_HC_Medicamento.Secuencia   ,
			SS_HC_Medicamento.FechaCreacion,
			SS_HC_Medicamento.IdUnidadMedida  ,
			SS_HC_Medicamento.Linea  ,
			SS_HC_Medicamento.Familia  ,
			SS_HC_Medicamento.SubFamilia ,	
			(select top 1 PD.TipoComponente from SS_FA_SolicitudProductoDetalle PD where
			PD.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion and
			PD.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and
			PD.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico and
			PD.IdPaciente=SS_HC_Medicamento.IdPaciente and
			/*PD.Secuencia=SS_HC_Medicamento.Secuencia and*/
			PD.CodigoComponente=SS_HC_Medicamento.CodigoComponente
			) as TipoComponente,/*SS_HC_Medicamento.TipoComponente  ,*/
			SS_HC_Medicamento.CodigoComponente,
			SS_HC_Medicamento.IdVia  ,
			SS_HC_Medicamento.Dosis  ,
			SS_HC_Medicamento.DiasTratamiento ,
			SS_HC_Medicamento.Frecuencia  ,
	
			(select top 1 PD.Cantidad from SS_FA_SolicitudProductoDetalle PD where
			PD.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion and
			PD.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico and
			PD.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and
			PD.IdPaciente=SS_HC_Medicamento.IdPaciente and
			/*PD.Secuencia=SS_HC_Medicamento.Secuencia and*/
			PD.CodigoComponente=SS_HC_Medicamento.CodigoComponente
			) as Cantidad,
	
			/*SS_HC_Medicamento.Cantidad  ,*/
			SS_HC_Medicamento.IndicadorEPS  ,
			SS_HC_Medicamento.TipoReceta  ,
				(select top 1 PD.IdOrdenAtencion from SS_FA_SolicitudProductoDetalle PD where
			PD.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion and
			PD.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico and
			PD.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and
			PD.IdPaciente=SS_HC_Medicamento.IdPaciente and
			/*PD.Secuencia=SS_HC_Medicamento.Secuencia and*/
			PD.CodigoComponente=SS_HC_Medicamento.CodigoComponente
			) as  Forma,
			SS_HC_Medicamento.GrupoMedicamento ,
			SS_HC_Medicamento.Comentario ,
			SS_HC_Medicamento.IndicadorAuditoria ,
			SS_HC_Medicamento.UsuarioAuditoria ,
		   (select top 1 PD.Accion from SS_FA_SolicitudProductoDetalle PD where
			PD.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion and
			PD.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and
			PD.IdPaciente=SS_HC_Medicamento.IdPaciente and
			/*PD.Secuencia=SS_HC_Medicamento.Secuencia and*/
			PD.CodigoComponente=SS_HC_Medicamento.CodigoComponente
			) as Accion,
			isnull((select top 1 PD.Estado from SS_FA_SolicitudProductoDetalle PD where
			PD.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion and
			PD.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and
			PD.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico and
			PD.IdPaciente=SS_HC_Medicamento.IdPaciente and
			PD.Secuencia=SS_HC_Medicamento.Secuencia and
			PD.CodigoComponente=SS_HC_Medicamento.CodigoComponente
			),1) as Estado,
			/*SS_HC_Medicamento.Estado ,*/
			SS_HC_Medicamento.Persona  ,
			SS_HC_Medicamento.Origen  ,
			SS_HC_Medicamento.NombreCompleto ,
			SS_HC_Medicamento.IngresoFechaRegistro ,
			SS_HC_Medicamento.IngresoAplicacionCodigo  ,
			SS_HC_Medicamento.IngresoUsuario   ,
			SS_HC_Medicamento.Celular  ,
			SS_HC_Medicamento.EstadoPersona ,
			SS_HC_Medicamento.Medicamento ,
			(select top 1 Convert(varchar(25),Convert(int,PD.Cantidad)) from SS_FA_SolicitudProductoDetalle PD where
			PD.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion and
			PD.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico and
			PD.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and
			PD.IdPaciente=SS_HC_Medicamento.IdPaciente and
			/*PD.Secuencia=SS_HC_Medicamento.Secuencia and*/
			PD.CodigoComponente=SS_HC_Medicamento.CodigoComponente
			) as CodigoOA,
			'' as Medico,
			(select top 1 Convert(varchar(10),PD.FechaCreacion,103) from SS_FA_SolicitudProductoDetalle PD where
			PD.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion and
			PD.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and
			PD.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico and
			PD.IdPaciente=SS_HC_Medicamento.IdPaciente and
			/*PD.Secuencia=SS_HC_Medicamento.Secuencia and*/
			PD.CodigoComponente=SS_HC_Medicamento.CodigoComponente
			 )as Cama

		 FROM  VW_ATENCIONPACIENTEMEDICAMENTO AS SS_HC_Medicamento 
				where
			           (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(SS_HC_Medicamento.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
					   and      
					   (@FechaInicio is null or  SS_HC_Medicamento.FechaCreacion >= @FechaInicio) 					   
					   and SS_HC_Medicamento.IdEpisodioAtencion =@IdEpisodioAtencion
					  and SS_HC_Medicamento.EpisodioClinico=@EpisodioClinico/**/ 
				and SS_HC_Medicamento.Medicamento is not null
		)
	UNION
	(
	SELECT 
	SS_HC_Medicamento.UnidadReplicacion   ,
	SS_HC_Medicamento.IdEpisodioAtencion   ,
	SS_HC_Medicamento.IdPaciente   ,
	SS_HC_Medicamento.EpisodioClinico   ,	
	SS_HC_Medicamento.Secuencia   ,
	SS_HC_Medicamento.FechaCreacion,
	null as IdUnidadMedida  ,
	SS_HC_Medicamento.Linea  ,
	SS_HC_Medicamento.Familia  ,
	SS_HC_Medicamento.SubFamilia ,	
	SS_HC_Medicamento.TipoComponente  ,
	SS_HC_Medicamento.CodigoComponente,
	null as IdVia  ,
	null as Dosis  ,
	null as DiasTratamiento ,
	null as Frecuencia  ,
	null as Cantidad  ,
	null as IndicadorEPS  ,
	null as TipoReceta  ,
	SS_HC_Medicamento.IdOrdenAtencion as  Forma,
	null as GrupoMedicamento ,
	null as Comentario ,
	null as IndicadorAuditoria ,
	null as UsuarioAuditoria ,
    SS_HC_Medicamento.Accion,
	SS_HC_Medicamento.Estado ,
	null as Persona  ,
	null as Origen  ,
	null as NombreCompleto ,
	null as IngresoFechaRegistro ,
	null as IngresoAplicacionCodigo  ,
	null as IngresoUsuario   ,
	null as Celular  ,
	null as EstadoPersona ,
	(select top 1 MED.DescripcionLocal from WH_ItemMast MED where MED.Linea=SS_HC_Medicamento.Linea
	AND MED.Familia = SS_HC_Medicamento.Familia
						AND MED.SubFamilia = SS_HC_Medicamento.SubFamilia
						AND ( rtrim(MED.Item)  =  SS_HC_Medicamento.CodigoComponente ) ) as Medicamento ,
	(Convert(varchar(25),Convert(int,SS_HC_Medicamento.Cantidad)) )as CodigoOA,
	'' as Medico,
	(select top 1 Convert(varchar(10),PD.FechaCreacion,103) from SS_FA_SolicitudProductoDetalle PD where
	PD.UnidadReplicacion=SS_HC_Medicamento.UnidadReplicacion and
	PD.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and
	PD.EpisodioClinico=SS_HC_Medicamento.EpisodioClinico and
	PD.IdPaciente=SS_HC_Medicamento.IdPaciente and
	/*PD.Secuencia=SS_HC_Medicamento.Secuencia and*/
	PD.CodigoComponente=SS_HC_Medicamento.CodigoComponente
	 ) as Cama

 	FROM  SS_FA_SolicitudProductoDetalle AS SS_HC_Medicamento 
		where			                
					   (@FechaInicio is null or  SS_HC_Medicamento.FechaCreacion >= @FechaInicio)    					 		
			and SS_HC_Medicamento.UnidadReplicacion=@UnidadReplicacion and
				SS_HC_Medicamento.IdEpisodioAtencion=@IdEpisodioAtencion and
				SS_HC_Medicamento.IdPaciente=@IdPaciente and SS_HC_Medicamento.EpisodioClinico=@EpisodioClinico
				and SS_HC_Medicamento.TipoComponente='M'
				and SS_HC_Medicamento.Medicamento is not null	
	)
	order by SS_HC_Medicamento.IdPaciente , SS_HC_Medicamento.IdEpisodioAtencion,SS_HC_Medicamento.FechaCreacion
						
	END
	
		
	END
GO