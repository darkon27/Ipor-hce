
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_RESPARTO_EMB_ACT_FE_]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_RESPARTO_EMB_ACT_FE_]
 @UnidadReplicacion char(4)
,@IdEpisodioAtencion bigint 
,@IdPaciente int 
,@EpisodioClinico int 
,@Secuencia int
,@FUR datetime
,@FPP datetime
,@EGXFUR varchar(25)
,@PFGECO varchar(25)
,@EG varchar(25)
,@AU varchar(25)
,@UsuarioCreacion varchar(25)  
,@FechaCreacion datetime 
,@UsuarioModificacion varchar(25)  
,@FechaModificacion datetime 
,@Accion varchar(25)  
,@Version varchar(25)  

AS
BEGIN
DECLARE @SECUENCIAMAX INT 
SET @SECUENCIAMAX = (SELECT (ISNULL(MAX(Secuencia),0)+1) FROM SS_HC_RESPARTO_EMB_ACT_FE WHERE
	UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico)

IF(@Accion = 'NUEVO')
BEGIN

	INSERT INTO SS_HC_RESPARTO_EMB_ACT_FE
	(UnidadReplicacion,IdEpisodioAtencion,IdPaciente,EpisodioClinico,Secuencia,
    FUR,FPP,EGXFUR,PFGECO,EG,AU
	,UsuarioCreacion,FechaCreacion,Accion,Version) 
    VALUES(@UnidadReplicacion, @IdEpisodioAtencion, @IdPaciente, @EpisodioClinico, @SECUENCIAMAX, 
    @FUR,@FPP,@EGXFUR,@PFGECO,@EG,@AU,
	@UsuarioCreacion, GETDATE(),@Accion, @Version
    )
SELECT @SECUENCIAMAX
END

IF(@Accion = 'UPDATE')
BEGIN

	UPDATE SS_HC_RESPARTO_EMB_ACT_FE
	SET FUR=@FUR,FPP=@FPP,EGXFUR=@EGXFUR,PFGECO=@PFGECO,EG=@EG,AU=@AU,
	UsuarioModificacion=@UsuarioModificacion,
	FechaModificacion=GETDATE(),Accion=@Accion
	WHERE
	UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico AND Secuencia=@Secuencia
	
	
	
SELECT @Secuencia
END

IF(@Accion = 'DELETE')
BEGIN

	DELETE FROM SS_HC_RESPARTO_EMB_ACT_FE
	WHERE UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico AND Secuencia=@Secuencia
	
SELECT @Secuencia
END



END

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_RESPARTO_EMB_ACT_FE_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_RESPARTO_EMB_ACT_FE_LISTAR]
 @UnidadReplicacion char(4)
,@IdEpisodioAtencion bigint 
,@IdPaciente int 
,@EpisodioClinico int 
,@Secuencia int
,@FUR datetime
,@FPP datetime
,@EGXFUR varchar(25)  
,@PFGECO varchar(25)  
,@EG varchar(25)  
,@AU varchar(25)  
,@UsuarioCreacion varchar(25)  
,@FechaCreacion datetime 
,@UsuarioModificacion varchar(25)  
,@FechaModificacion datetime 
,@Accion varchar(25)  
,@Version varchar(25)   

AS
BEGIN
	IF(@Accion='LISTAR')
	BEGIN
	SELECT * FROM SS_HC_RESPARTO_EMB_ACT_FE
	WHERE UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
		AND EpisodioClinico=@EpisodioClinico
	END

END


GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_RESPARTO_EMB_ANT_FE_]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_RESPARTO_EMB_ANT_FE_]

 @UnidadReplicacion char(4)
,@IdEpisodioAtencion bigint 
,@IdPaciente int 
,@EpisodioClinico int 
,@Secuencia int
,@Pariedad1 int
,@Pariedad2 int
,@Pariedad3 int
,@Pariedad4 int
,@Gravidez int
,@UsuarioCreacion varchar(25)  
,@FechaCreacion datetime 
,@UsuarioModificacion varchar(25)  
,@FechaModificacion datetime 
,@Accion varchar(25)  
,@Version varchar(25)  

AS
BEGIN
DECLARE @SECUENCIAMAX INT 
SET @SECUENCIAMAX = (SELECT (ISNULL(MAX(Secuencia),0)+1) FROM SS_HC_RESPARTO_EMB_ANT_FE WHERE
	UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico)

IF(@Accion = 'NUEVO')
BEGIN

	INSERT INTO SS_HC_RESPARTO_EMB_ANT_FE
	(UnidadReplicacion,IdEpisodioAtencion,IdPaciente,EpisodioClinico,Secuencia,
    Pariedad1,Pariedad2,Pariedad3,Pariedad4,Gravidez
	,UsuarioCreacion,FechaCreacion,Accion,Version) 
    VALUES(@UnidadReplicacion, @IdEpisodioAtencion, @IdPaciente, @EpisodioClinico, @SECUENCIAMAX, 
    @Pariedad1,@Pariedad2,@Pariedad3,@Pariedad4,@Gravidez,
	@UsuarioCreacion, GETDATE(),@Accion, @Version
    )
SELECT @SECUENCIAMAX
END

IF(@Accion = 'UPDATE')
BEGIN

	UPDATE SS_HC_RESPARTO_EMB_ANT_FE
	SET Pariedad1=@Pariedad1,Pariedad2=@Pariedad2,Pariedad3=@Pariedad3,Pariedad4=@Pariedad4,Gravidez=@Gravidez,
	UsuarioModificacion=@UsuarioModificacion,
	FechaModificacion=GETDATE(),Accion=@Accion
	WHERE
	UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico AND Secuencia=@Secuencia
	
	
	
SELECT @Secuencia
END

IF(@Accion = 'DELETE')
BEGIN

	DELETE FROM SS_HC_RESPARTO_EMB_ANT_FE
	WHERE UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico AND Secuencia=@Secuencia
	
SELECT @Secuencia
END



END

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_RESPARTO_EMB_ANT_FE_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_RESPARTO_EMB_ANT_FE_LISTAR]
 @UnidadReplicacion char(4)
,@IdEpisodioAtencion bigint 
,@IdPaciente int 
,@EpisodioClinico int 
,@Secuencia int
,@Pariedad1 int
,@Pariedad2 int
,@Pariedad3 int
,@Pariedad4 int
,@Gravidez int
,@UsuarioCreacion varchar(25)  
,@FechaCreacion datetime 
,@UsuarioModificacion varchar(25)  
,@FechaModificacion datetime 
,@Accion varchar(25)  
,@Version varchar(25)  

AS
BEGIN
IF(@Accion='LISTAR')
BEGIN
SELECT * FROM SS_HC_RESPARTO_EMB_ANT_FE
WHERE UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico
END



END

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_RESUMEN_PARTO_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_RESUMEN_PARTO_FE]
@UnidadReplicacion char(4)
,@IdEpisodioAtencion bigint 
,@IdPaciente int 
,@EpisodioClinico int 
,@IdResParto int
,@Fecha_Ing datetime
,@Hora_Ing datetime
,@Controladora int
,@Membranas int
,@Horas_memb varchar(250)
,@P_Selector1 int
,@P_Selector2 int
,@P_Observacion  varchar(520)  
,@P_Dur_Parto  varchar(250)  
,@S_Selector1 int
,@Observaciones1_S  varchar(520)  
,@S_Fecha_Parto datetime
,@S_Hora_Parto datetime
,@S_Selector2 int
,@S_Episiotomia int
,@S_Desgarro int
,@S_Selector3 int
,@S_Selector4 int
,@Observaciones2_S  varchar(520)  
,@S_Dur_Parto  varchar(520)  
,@UsuarioCreacion varchar(25)  
,@FechaCreacion datetime 
,@UsuarioModificacion varchar(25)  
,@FechaModificacion datetime 
,@Accion varchar(25)  
,@Version varchar(25) 
,@Estado int

AS
BEGIN
DECLARE @SECUENCIA INT 
SET @SECUENCIA = (SELECT (ISNULL(MAX(IdResParto),0)+1) FROM SS_HC_RESUMEN_PARTO_FE WHERE
	UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico)	 

       IF(@Accion='NUEVO')
        BEGIN
             INSERT INTO SS_HC_RESUMEN_PARTO_FE
			 (UnidadReplicacion,
			  IdEpisodioAtencion,
			  IdPaciente,
			  EpisodioClinico,
			  IdResParto,
			  Fecha_Ing,
			  Hora_Ing,
			  Controladora,
              Membranas,
			  Horas_memb,
			  P_Selector1,
			  P_Selector2,
			  P_Observacion,
			  P_Dur_Parto,
			  S_Selector1,
			  Observaciones1_S,
			  S_Fecha_Parto,
			  S_Hora_Parto,
			  S_Selector2,
			  S_Episiotomia,
			  S_Desgarro,
			  S_Selector3,
			  S_Selector4,
			  Observaciones2_S,
			  S_Dur_Parto,
			  UsuarioCreacion,
			  FechaCreacion,
			  Accion,
			  Version,
			  Estado)
             VALUES(@UnidadReplicacion 
					,@IdEpisodioAtencion  
					,@IdPaciente  
					,@EpisodioClinico  
					,@SECUENCIA
					,@Fecha_Ing 
					,@Hora_Ing 
					,@Controladora 
					,@Membranas 
					,@Horas_memb 
					,@P_Selector1 
					,@P_Selector2 
					,@P_Observacion  
					,@P_Dur_Parto    
					,@S_Selector1 
					,@Observaciones1_S  
					,@S_Fecha_Parto 
					,@S_Hora_Parto 
					,@S_Selector2 
					,@S_Episiotomia 
					,@S_Desgarro 
					,@S_Selector3 
					,@S_Selector4 
					,@Observaciones2_S 
					,@S_Dur_Parto   
					,@UsuarioCreacion  
					,@FechaCreacion  					 
					,@Accion   
					,@Version 
					,@Estado )

           SELECT @SECUENCIA
        END

       

    ELSE
	 IF @Accion ='UPDATE'  --Actualiza CABECERA
		BEGIN
				update  SS_HC_RESUMEN_PARTO_FE
				Set  
					 Fecha_Ing=@Fecha_Ing 
					,Hora_Ing=@Hora_Ing 
					,Controladora =@Controladora 
					,Membranas=@Membranas 
					,Horas_memb = @Horas_memb 
					,P_Selector1=@P_Selector1 
					,P_Selector2 =@P_Selector2 
					,P_Observacion=@P_Observacion  
					,P_Dur_Parto =@P_Dur_Parto   
					,S_Selector1=@S_Selector1 
					,Observaciones1_S=@Observaciones1_S  
					,S_Fecha_Parto =@S_Fecha_Parto 
					,S_Hora_Parto=@S_Hora_Parto 
					,S_Selector2=@S_Selector2 
					,S_Episiotomia =@S_Episiotomia 
					,S_Desgarro=@S_Desgarro 
					,S_Selector3=@S_Selector3 
					,S_Selector4 =@S_Selector4 
					,Observaciones2_S  =@Observaciones2_S  
					,S_Dur_Parto  =@S_Dur_Parto  					 
					,UsuarioModificacion=@UsuarioModificacion  
					,FechaModificacion=@FechaModificacion  
					,Accion =@Accion 					
	
				 Where  
					IdEpisodioAtencion = @IdEpisodioAtencion
					And	EpisodioClinico =@EpisodioClinico
					And	IdPaciente =@IdPaciente
 
				SELECT @IdPaciente
		END

	ELSE IF @ACCION ='DELETE'  --Borrar CABECERA
		BEGIN  
    
			DELETE SS_HC_RESUMEN_PARTO_FE   
		    where 
			   IdPaciente =@IdPaciente  
			   AND  EpisodioClinico = @EpisodioClinico  
			   AND  IdEpisodioAtencion=@IdEpisodioAtencion  
			   AND UnidadReplicacion = @UnidadReplicacion
			   AND  IdResParto = @IdResParto 
 
		  SELECT @IdResParto  
		END  	

END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_RESUMEN_PARTO_LISTAR_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[SP_SS_HC_RESUMEN_PARTO_LISTAR_FE]
 @UnidadReplicacion char(4)
,@IdEpisodioAtencion bigint 
,@IdPaciente int 
,@EpisodioClinico int 
,@IdResParto int
,@Fecha_Ing datetime
,@Hora_Ing datetime
,@Controladora int
,@Membranas int
,@Horas_memb varchar(250)
,@P_Selector1 int
,@P_Selector2 int
,@P_Observacion  varchar(520)  
,@P_Dur_Parto  varchar(250)  
,@S_Selector1 int
,@Observaciones1_S  varchar(520)  
,@S_Fecha_Parto datetime
,@S_Hora_Parto datetime
,@S_Selector2 int
,@S_Episiotomia int
,@S_Desgarro int
,@S_Selector3 int
,@S_Selector4 int
,@Observaciones2_S  varchar(520)  
,@S_Dur_Parto  varchar(520)  
,@UsuarioCreacion varchar(25)  
,@FechaCreacion datetime 
,@UsuarioModificacion varchar(25)  
,@FechaModificacion datetime 
,@Accion varchar(25)  
,@Version varchar(25) 
,@Estado int
	
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE 
	 @IdEpisodioAtencionId as INTEGER,
	 @EpisodioClinicoID as INTEGER, 
	 @ExisteCodigo as VARCHAR(10),
	 @SecuenciaID as Integer

	 set @IdEpisodioAtencionId = @IdEpisodioAtencion
		
	 IF @Accion = 'LISTAR'
		BEGIN
		Select * From SS_HC_RESUMEN_PARTO_FE 
		Where	IdPaciente = @IdPaciente 
		AND		IdEpisodioAtencion = @IdEpisodioAtencion
		AND		EpisodioClinico= @EpisodioClinico
		
		END
 
 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_RuleGetCollectionStore]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[SP_SS_HC_RuleGetCollectionStore]
(        
	@AplicacionCodigo varchar(10) ,        
	@CodigoTabla varchar(30) ,        
	@Compania varchar(10) ,        
	@CodigoElemento varchar(10) ,        
	@DescripcionLocal varchar(80) ,        
	@DescripcionExtranjera char(80) ,        
	@ValorNumerico float ,        
	@ValorCodigo1 varchar(300) ,        
	@ValorCodigo2 varchar(300) ,        
	@ValorCodigo3 varchar(300) ,        
	@ValorCodigo4 varchar(300) ,        
	@ValorCodigo5 varchar(300) ,        
	@ValorCodigo6 varchar(300) ,        
	@ValorCodigo7 varchar(300) ,        
	@ValorFecha datetime , 
	@ValorFechaInicio datetime , 
	@ValorFechaFinal datetime ,        
	@Estado char(1) ,        
	@UltimoUsuario varchar(100),         
	@UltimaFechaModif	datetime ,		
	@RowID	int ,
	@ValorEntero1	int ,
	@ValorEntero2	int ,
	@ValorEntero3	int ,
	@ValorEntero4	int ,
	@ValorEntero5	int ,
	@ValorEntero6	int ,
	@ValorEntero7	int  ,      
	@INICIO   int= null,          
	@NUMEROFILAS int = null ,        
	@ACCION VARCHAR(30)        
)        
        
AS        
BEGIN        
	DECLARE  @MA_MiscelaneosDetalle TABLE(          
		   AplicacionCodigo  VARCHAR(100) NULL,          
		   CodigoTabla  VARCHAR(100) NULL,          
		   Compania  VARCHAR(100) NULL,          
		   CodigoElemento  VARCHAR(100) NULL,          
		   DescripcionLocal  VARCHAR(max) NULL,          
		   DescripcionExtranjera  VARCHAR(max)NULL,          
		   ValorNumerico  float NULL,          
		   ValorCodigo1  VARCHAR(250) NULL,          
		   ValorCodigo2  VARCHAR(250) NULL,          
		   ValorCodigo3  VARCHAR(250) NULL,          
		   ValorCodigo4  VARCHAR(250) NULL,          
		   ValorCodigo5  VARCHAR(250) NULL,          
		   ValorCodigo6  VARCHAR(250) NULL,          
		   ValorCodigo7  VARCHAR(250) NULL,          
		   ValorEntero1  int NULL,          
		   ValorEntero2  int NULL,          
		   ValorEntero3  int NULL,          
		   ValorEntero4  int NULL,          
		   ValorEntero5  int NULL,          
		   ValorEntero6  int NULL,         
		   ValorEntero7  int NULL,          
		   ValorFecha  datetime NULL,          
		   Estado  VARCHAR(1) NULL,          
		   UltimoUsuario varchar(25) null,          
		   UltimaFechaModif date null,          
		   Timestamp datetime null,          
		   ACCION  VARCHAR(25)  null,          
		   RowID INT IDENTITY(1,1) PRIMARY KEY          
	)        
	DECLARE @CONTADOR INT        
         
	 if(@ACCION = 'DESCANSOMEDICO')        --SP_RGN_07_AlertaDescansoMedico
		  BEGIN   
			 INSERT INTO @MA_MiscelaneosDetalle 
					 (AplicacionCodigo, Compania, 
					 CodigoTabla,   CodigoElemento,
					 ValorEntero1, 
					 ValorEntero2)          
			 Select  'CG','99999',
				'POSaludDescansoMedico',@CodigoElemento,
				SS_HC_DescansoMedico.IdPaciente,
				CantidadDias = SUM(DATEDIFF(dd,SS_HC_DescansoMedico.FechaInicioDescanso, SS_HC_DescansoMedico.FechaFinDescanso) + 1)
				FROM SS_HC_DescansoMedico
				WHERE SS_HC_DescansoMedico.IdPaciente = @ValorEntero1
				AND YEAR(@ValorFechaFinal) = YEAR(SS_HC_DescansoMedico.FechaInicioDescanso)
				AND SS_HC_DescansoMedico.Estado = 2
				GROUP BY SS_HC_DescansoMedico.IdPaciente
			SELECT * FROM  @MA_MiscelaneosDetalle ;
		  END  
	 if(@ACCION = 'PO_EXAMENPERIODO')         --SP_RGN_01_ExamenLaboratorio
		  BEGIN   
			 INSERT INTO @MA_MiscelaneosDetalle 
					 (AplicacionCodigo, Compania, 
					 CodigoTabla,   CodigoElemento,
					 ValorEntero1, 
					 ValorEntero2,
					 ValorCodigo3,
					  ValorEntero6,
					 ValorFecha)          
			 Select  'CG','99999',
				'POSaludValidExamenPeriodo','ss',
				SS_HC_EpisodioAtencion.IdPaciente,
				SS_HC_EpisodioAtencion.TipoOrdenAtencion,
				isnull(SS_HC_ProcedimientoEjecucion.CodigoComponente,'0'),
				anos = SUM(DATEDIFF(yy,SS_HC_EpisodioAtencion.FechaAtencion, GETDATE())),
				FechaUltimoExmamen = isnull(MAX(SS_HC_EpisodioAtencion.FechaAtencion) ,GETDATE())
				FROM SS_HC_ProcedimientoEjecucion WITH(NOLOCK) LEFT JOIN SS_HC_EpisodioAtencion WITH(NOLOCK) ON SS_HC_EpisodioAtencion.UnidadReplicacion = SS_HC_ProcedimientoEjecucion.UnidadReplicacion
					AND SS_HC_EpisodioAtencion.IdPaciente = SS_HC_ProcedimientoEjecucion.IdPaciente
					AND SS_HC_EpisodioAtencion.EpisodioClinico = SS_HC_ProcedimientoEjecucion.EpisodioClinico
					AND SS_HC_EpisodioAtencion.EpisodioAtencion = SS_HC_ProcedimientoEjecucion.IdEpisodioAtencion
				 WHERE SS_HC_ProcedimientoEjecucion.IdPaciente = @ValorEntero1
				GROUP BY SS_HC_EpisodioAtencion.IdPaciente,
				SS_HC_ProcedimientoEjecucion.CodigoComponente,
				SS_HC_EpisodioAtencion.TipoOrdenAtencion
			SELECT * FROM  @MA_MiscelaneosDetalle ;
		  END 	
	 if(@ACCION = 'CONTROLGINECOLOGIA')      --SP_RGN_02_ExamenGinecologico  
		  BEGIN   
			 INSERT INTO @MA_MiscelaneosDetalle 
					 (AplicacionCodigo, Compania, 
					 CodigoTabla,   CodigoElemento,
					 ValorEntero1,	 
					 ValorCodigo1,	--SEXO
					 ValorEntero2,	-- EDAD
					 ValorEntero3,	-- TIPOCOM
					 ValorCodigo2,	--codigocompon
					 ValorFecha)          
			 Select  'CG','99999',
				'POSaludValidGenicolo',@CodigoElemento,
				SS_HC_EpisodioAtencion.IdPaciente,
				PERSONAMAST.Sexo,
				Edad = DATEDIFF(yy,PERSONAMAST.FechaNacimiento, GETDATE()),
				SS_HC_EpisodioAtencion.TipoOrdenAtencion,
				SS_HC_ProcedimientoEjecucion.CodigoComponente,
				FechaUltimoExmamen = MAX(SS_HC_EpisodioAtencion.FechaAtencion)
				FROM SS_HC_ProcedimientoEjecucion WITH(NOLOCK) LEFT JOIN SS_HC_EpisodioAtencion WITH(NOLOCK) ON SS_HC_EpisodioAtencion.UnidadReplicacion = SS_HC_ProcedimientoEjecucion.UnidadReplicacion
					AND SS_HC_EpisodioAtencion.IdPaciente = SS_HC_ProcedimientoEjecucion.IdPaciente
					AND SS_HC_EpisodioAtencion.EpisodioClinico = SS_HC_ProcedimientoEjecucion.EpisodioClinico
					AND SS_HC_EpisodioAtencion.EpisodioAtencion = SS_HC_ProcedimientoEjecucion.IdEpisodioAtencion
				LEFT JOIN PERSONAMAST WITH(NOLOCK) ON SS_HC_EpisodioAtencion.IdPaciente = PERSONAMAST.Persona
				WHERE SS_HC_ProcedimientoEjecucion.IdPaciente = @ValorEntero1
					AND SS_HC_EpisodioAtencion.IdEspecialidad = 9
				GROUP BY SS_HC_EpisodioAtencion.IdPaciente,
				SS_HC_ProcedimientoEjecucion.CodigoComponente,
				SS_HC_EpisodioAtencion.TipoOrdenAtencion,
				PERSONAMAST.Sexo,
				PERSONAMAST.FechaNacimiento
			SELECT * FROM  @MA_MiscelaneosDetalle ;
		  END 		
	 if(@ACCION = 'FIRMAMEDICO')          --SP_RGN_03_AlertaCierreAtencion
		  BEGIN   
			 INSERT INTO @MA_MiscelaneosDetalle 
					 (AplicacionCodigo, Compania, 
					 CodigoTabla,   CodigoElemento,
					 ValorCodigo1,	 -- UNIDAD REPLICA
					 ValorEntero1,	--IDPACIENTE
					 ValorEntero2,	--EPCLINICO
					 ValorEntero3,	--IDEPATENCION
					 ValorEntero4,	--TIPO ATENCION
					 ValorFecha,	-- FECHAATENC
					 ValorEntero6,
					 ValorEntero5   --ESTADO
					 )          
			 Select  'CG','99999',
				'POSaludFirmaMedico',@CodigoElemento,
				 SS_HC_EpisodioAtencion.UnidadReplicacion,
				SS_HC_EpisodioAtencion.IdPaciente,
				SS_HC_EpisodioAtencion.EpisodioClinico,
				SS_HC_EpisodioAtencion.IdEpisodioAtencion,
				SS_HC_EpisodioAtencion.TipoAtencion,
				SS_HC_EpisodioAtencion.FechaAtencion,
				dias = isnull(DATEDIFF(dd,SS_HC_EpisodioAtencion.FechaAtencion, GETDATE()),0),
				SS_HC_EpisodioAtencion.Estado
				FROM SS_HC_EpisodioAtencion
				WHERE SS_HC_EpisodioAtencion.UnidadReplicacion = @ValorCodigo1
					AND SS_HC_EpisodioAtencion.IdPaciente  = @ValorEntero1
					AND SS_HC_EpisodioAtencion.EpisodioClinico  = @ValorEntero2
					AND SS_HC_EpisodioAtencion.IdEpisodioAtencion  = @ValorEntero3
			SELECT * FROM  @MA_MiscelaneosDetalle ;
		  END 		  
	 if(@ACCION = 'CONSULTAMES')         --SP_RGN_04_AlertaCostoPacienteMes
		  BEGIN   
			 INSERT INTO @MA_MiscelaneosDetalle 
					 (AplicacionCodigo, Compania, 
					 CodigoTabla,   CodigoElemento,
					 ValorCodigo1,	 -- UNIDAD REPLICA
					 ValorEntero1,	--IDPACIENTE
					 ValorEntero2,	--MODALIDAD
					 ValorEntero3	--CANTIDAD
					 ) 		  
				SELECT 
				'CG','99999',
				'POSaludConsultaMes',	@CodigoElemento,			
				SS_HC_EpisodioAtencion.UnidadReplicacion,
				SS_HC_EpisodioAtencion.IdPaciente,
				Modalidad = 2, --??
				Cantidad = (COUNT (DISTINCT SS_HC_EpisodioAtencion.IdOrdenAtencion))
				FROM SS_HC_EpisodioAtencion
				WHERE SS_HC_EpisodioAtencion.UnidadReplicacion =@ValorCodigo1
					AND SS_HC_EpisodioAtencion.IdPaciente  =@ValorEntero1
					AND YEAR(SS_HC_EpisodioAtencion.FechaAtencion)*100 + MONTH(SS_HC_EpisodioAtencion.FechaAtencion) = YEAR(@ValorFecha)*100 + MONTH(@ValorFecha)
				GROUP BY SS_HC_EpisodioAtencion.UnidadReplicacion,
					SS_HC_EpisodioAtencion.IdPaciente		  
		  
		  
			SELECT * FROM  @MA_MiscelaneosDetalle ;
		  END 		  
	 if(@ACCION = 'REPDIAGNOSTICO')         --SP_RGN_06_ReportarDiagnostico
		  BEGIN   
			 INSERT INTO @MA_MiscelaneosDetalle 
					 (AplicacionCodigo, Compania, 
					 CodigoTabla,   CodigoElemento,
					 ValorCodigo1,	 -- UNIDAD REPLICA
					 ValorEntero1,	--IDPACIENTE
					 ValorEntero2,	--EPCLINICO
					 ValorEntero3,	--IDEPATENCION
					 ValorEntero4,	--Secuencia
					 ValorCodigo2,	-- CodigoDiagnostico
					 ValorCodigo3   --DeterminacionDiagnostica
					 ) 		  
				SELECT 
				'CG','99999',
				'POSaludDiagnosticoInformado',	@CodigoElemento,				
				SS_HC_Diagnostico.UnidadReplicacion,
				SS_HC_Diagnostico.IdPaciente,
				SS_HC_Diagnostico.EpisodioClinico,
				SS_HC_Diagnostico.IdEpisodioAtencion,
				SS_HC_Diagnostico.Secuencia,
				SS_GE_Diagnostico.CodigoDiagnostico,
				SS_HC_Diagnostico.DeterminacionDiagnostica
				FROM SS_HC_Diagnostico INNER JOIN SS_GE_Diagnostico ON SS_HC_Diagnostico.IdDiagnostico = SS_GE_Diagnostico.IdDiagnostico
				WHERE SS_HC_Diagnostico.UnidadReplicacion = @ValorCodigo1
					AND SS_HC_Diagnostico.IdPaciente = @ValorEntero1
					AND SS_HC_Diagnostico.EpisodioClinico = @ValorEntero2
					AND SS_HC_Diagnostico.IdEpisodioAtencion = @ValorEntero3	  
		  
		  
			SELECT * FROM  @MA_MiscelaneosDetalle ;
		  END 		 		  
	 if(@ACCION = 'PRIORIDADESPERA')         --SP_RGN_05_AlertaPrioridadEspera
		  BEGIN   
			 INSERT INTO @MA_MiscelaneosDetalle 
					 (AplicacionCodigo, Compania, 
					 CodigoTabla,   CodigoElemento,
					 ValorCodigo1,	 -- UNIDAD REPLICA
					 ValorEntero1,	--IdOrdenAtencion
					 ValorEntero2,	--TipoAtencion					 					 
					 ValorFecha,	-- FechaInicio
					 ValorEntero3   --Prioridad
					 ) 		  
					SELECT
					'CG','99999',
					'POSaludEmergenciaEspera',	@CodigoElemento,						
					SS_AD_OrdenAtencion.UnidadReplicacion,
					SS_AD_OrdenAtencion.IdOrdenAtencion,
					SS_AD_OrdenAtencion.TipoAtencion,
					SS_AD_OrdenAtencion.FechaInicio,
					SS_AD_OrdenAtencion.Prioridad
					FROM SS_AD_OrdenAtencion
					WHERE SS_AD_OrdenAtencion.UnidadReplicacion = @ValorCodigo1
					--AND SS_AD_OrdenAtencion.IndicadorAtendido IS NULL
					AND SS_AD_OrdenAtencion.FechaInicio BETWEEN GETDATE() AND DATEADD(dd, -2, GETDATE())
					AND SS_AD_OrdenAtencion.TipoAtencion = 2
		  
		  
			SELECT * FROM  @MA_MiscelaneosDetalle ;
		  END 		 		  
	 if(@ACCION = 'REPDIAGNOSTICO_UP')        --SP_RGN_07_AlertaDescansoMedico
		  BEGIN  
		  					  		  
			   UPDATE SS_HC_Diagnostico 
			   SET IndicadorAntecedente = 2 --AUX PARA INDIADOR REPORTAR
				FROM SS_HC_Diagnostico
			   WHERE SS_HC_Diagnostico.UnidadReplicacion = @ValorCodigo1
				AND SS_HC_Diagnostico.IdPaciente  = @ValorEntero1
			   AND SS_HC_Diagnostico.EpisodioClinico  = @ValorEntero2
			   AND SS_HC_Diagnostico.IdEpisodioAtencion  = @ValorEntero3  	
			   AND SS_HC_Diagnostico.Secuencia = @ValorEntero4
			
		  
			 INSERT INTO @MA_MiscelaneosDetalle 
					 (AplicacionCodigo, Compania, 
					 CodigoTabla,   CodigoElemento,
					 ValorEntero1
					 )
			 Select  'CG','99999',
				'POSaludDescansoMedico',@CodigoElemento,
				@ValorEntero1			
		
			SELECT * FROM  @MA_MiscelaneosDetalle ;						
		  END  				
	 if(@ACCION = 'FIRMAMEDICO_UP')        --SP_RGN_07_AlertaDescansoMedico
		  BEGIN 
		  --select * from SS_HC_EpisodioAtencion where FlagCierrePorRegla =2
			   UPDATE SS_HC_EpisodioAtencion 
			   SET FlagCierrePorRegla = 2

			   WHERE SS_HC_EpisodioAtencion.UnidadReplicacion = @ValorCodigo1
				AND SS_HC_EpisodioAtencion.IdPaciente  = @ValorEntero1
			   AND SS_HC_EpisodioAtencion.EpisodioClinico  = @ValorEntero2
			   AND SS_HC_EpisodioAtencion.IdEpisodioAtencion  = @ValorEntero3  		  
			   
			 INSERT INTO @MA_MiscelaneosDetalle 
					 (AplicacionCodigo, Compania, 
					 CodigoTabla,   CodigoElemento,
					 ValorEntero1
					 )
			 Select  'CG','99999',
				'POSaludDescansoMedico',@CodigoElemento,
				@ValorEntero1			
		
			SELECT * FROM  @MA_MiscelaneosDetalle ;				   
		  END	  	        
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_SeguimientoRiesgo]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_SeguimientoRiesgo]
           @UnidadReplicacion char(4),
           @IdEpisodioAtencion bigint,
           @IdPaciente int,
           @EpisodioClinico int,
           @IdTipoCuidadoPreventivo int,
           @FechaSeguimiento datetime,
           @Estado int,
           @UsuarioCreacion varchar(25),
           @FechaCreacion datetime,
           @UsuarioModificacion varchar(25),
           @FechaModificacion datetime,
           @Accion varchar(25),
           @Version varchar(25)
           
           AS
BEGIN  
 SET NOCOUNT ON;  
 BEGIN  TRANSACTION
 DECLARE @CONTADOR INT  
 IF @Accion ='NUEVO'  
  BEGIN  

	     IF @FechaSeguimiento IS NULL
			SET @FechaSeguimiento = GETDATE();
		INSERT INTO SS_HC_SeguimientoRiesgo   
		(  
				  UnidadReplicacion,
				  IdEpisodioAtencion,
				  IdPaciente,
				  EpisodioClinico,
				  IdTipoCuidadoPreventivo,
				  FechaSeguimiento,
				  Estado,
				  UsuarioCreacion,
				  FechaCreacion,
				  UsuarioModificacion,
				  FechaModificacion,
				  Accion,
				  Version )  
   values 
	   (
				  @UnidadReplicacion,
				  @IdEpisodioAtencion,
				  @IdPaciente,
				  @EpisodioClinico,
				  @IdTipoCuidadoPreventivo,
				  @FechaSeguimiento,
				  2,
				  @UsuarioCreacion,
				  GETDATE(),
				  @UsuarioModificacion,
				  GETDATE(),
				  'CCEP0302',
				  @Version)   
  END
  ELSE  
  IF @Accion ='UPDATE'  
   BEGIN  
   UPDATE SS_HC_SeguimientoRiesgo SET   
				   
				  FechaSeguimiento = @FechaSeguimiento,
				  Estado = @Estado,
				  UsuarioModificacion = @UsuarioModificacion,
				  FechaModificacion = GETDATE()
			   where 
			   IdEpisodioAtencion = @IdEpisodioAtencion   
			   and UnidadReplicacion= @UnidadReplicacion 
			   and IdPaciente=@IdPaciente 
			   and EpisodioClinico = @EpisodioClinico 
   END   
	else
	if(@ACCION = 'DELETE')
	begin
		delete SS_HC_SeguimientoRiesgo
		WHERE IdEpisodioAtencion = @IdEpisodioAtencion   
			   and UnidadReplicacion= @UnidadReplicacion 
			   and IdPaciente=@IdPaciente 
			   and EpisodioClinico = @EpisodioClinico 
	end
commit	
	select 1 
END   
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_SeguimientoRiesgoDetalle]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_SeguimientoRiesgoDetalle]
           @UnidadReplicacion char(4),
           @IdEpisodioAtencion bigint,
           @IdPaciente int,
           @EpisodioClinico int,
           @Secuencia int,
           @IdCuidadoPreventivo int,
           @Comentario varchar(200),
           @Accion varchar(25),
           @Version varchar(25)
           
             AS
             BEGIN  
 SET NOCOUNT ON;  
 BEGIN  TRANSACTION
 DECLARE @CONTADOR INT , @SecuenciaID as integer 
 IF @Accion ='NUEVO'  
  BEGIN  
  	SELECT @SecuenciaID= isnull(MAX(Secuencia),0)+1 from SS_HC_SeguimientoRiesgoDetalle 
	    DECLARE @Existe as integer
	    Select @Existe = isnull(count(*),0) from SS_HC_SeguimientoRiesgoDetalle
	     where IdEpisodioAtencion = @IdEpisodioAtencion   
			   and UnidadReplicacion= @UnidadReplicacion 
			   and IdPaciente=@IdPaciente 
			   and EpisodioClinico = @EpisodioClinico 
			   and IdCuidadoPreventivo = @IdCuidadoPreventivo 
		if (@Existe > 0)
			begin
				 UPDATE SS_HC_SeguimientoRiesgoDetalle SET  
						Comentario = @Comentario
				   where 
				   IdEpisodioAtencion = @IdEpisodioAtencion   
				   and UnidadReplicacion= @UnidadReplicacion 
				   and IdPaciente=@IdPaciente 
				   and EpisodioClinico = @EpisodioClinico 
				   and IdCuidadoPreventivo = @IdCuidadoPreventivo 
			end
		else	
			begin
				INSERT INTO SS_HC_SeguimientoRiesgoDetalle   
					(  
							  UnidadReplicacion,
							  IdEpisodioAtencion,
							  IdPaciente,
							  EpisodioClinico,
							  Secuencia,
							  IdCuidadoPreventivo,
							  Comentario,
							  Accion,
							  Version)  
			   values 
						 (
							  @UnidadReplicacion,
							  @IdEpisodioAtencion,
							  @IdPaciente,
							  @EpisodioClinico,
							  @SecuenciaID,
							  @IdCuidadoPreventivo,
							  @Comentario,
							  @Accion,
							  @Version)   
			 end
  END
  ELSE  
  IF @Accion ='UPDATE'  
   BEGIN  
   UPDATE SS_HC_SeguimientoRiesgoDetalle SET   
				  IdCuidadoPreventivo = IdCuidadoPreventivo,
				  Comentario = @Comentario, 
				  Accion = @Accion,
				  Version = @Version 
			   where 
			   IdEpisodioAtencion = @IdEpisodioAtencion   
			   and UnidadReplicacion= @UnidadReplicacion 
			   and IdPaciente=@IdPaciente 
			   and EpisodioClinico = @EpisodioClinico 
			   and Secuencia = @Secuencia 
   END   
	else
	if(@ACCION = 'DELETE')
	begin
		delete SS_HC_SeguimientoRiesgoDetalle
		WHERE IdEpisodioAtencion = @IdEpisodioAtencion   
			   and UnidadReplicacion= @UnidadReplicacion 
			   and IdPaciente=@IdPaciente 
			   and EpisodioClinico = @EpisodioClinico 
			   and Secuencia = @Secuencia 
	end
commit	
	select 1 
END   
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_SeguimientoRiesgoDetalle_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_SeguimientoRiesgoDetalle_Listar]
           @UnidadReplicacion char(4),
           @IdEpisodioAtencion bigint,
           @IdPaciente int,
           @EpisodioClinico int,
           @Secuencia int,
           @IdCuidadoPreventivo int,
           @Comentario varchar(200),
           @Accion varchar(25),
           @Version varchar(25)
           
             AS
BEGIN    
if(@ACCION = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR=(SELECT COUNT(IdEpisodioAtencion) FROM SS_HC_SeguimientoRiesgoDetalle
	 					WHERE 
					(@UnidadReplicacion is null OR UnidadReplicacion = @UnidadReplicacion)	
					and (@IdEpisodioAtencion is null OR (IdEpisodioAtencion = @IdEpisodioAtencion) or @IdEpisodioAtencion =0)
					and (@IdPaciente is null OR IdPaciente = @IdPaciente)
					and (@EpisodioClinico is null OR EpisodioClinico = @EpisodioClinico)				
					and (@Secuencia is null OR Secuencia = @Secuencia)
					)
		SELECT
				  UnidadReplicacion,
				  IdEpisodioAtencion,
				  IdPaciente,
				  EpisodioClinico,
				  Secuencia,
				  IdCuidadoPreventivo,
				  Comentario,
				  Accion,
				  Version
		FROM (		
			SELECT
				  UnidadReplicacion,
				  IdEpisodioAtencion,
				  IdPaciente,
				  EpisodioClinico,
				  Secuencia,
				  IdCuidadoPreventivo,
				  Comentario,
				  Accion,
				  Version
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY IdEpisodioAtencion ASC ) AS RowNumber   	
					FROM SS_HC_SeguimientoRiesgoDetalle	
					WHERE  
					(@UnidadReplicacion is null OR UnidadReplicacion = @UnidadReplicacion)	
					and (@IdEpisodioAtencion is null OR (IdEpisodioAtencion = @IdEpisodioAtencion) or @IdEpisodioAtencion =0)
					and (@IdPaciente is null OR IdPaciente = @IdPaciente)
					and (@EpisodioClinico is null OR EpisodioClinico = @EpisodioClinico)				
					and (@Secuencia is null OR Secuencia = @Secuencia)		
 
			) AS LISTADO
		
       END
       ELSE
  IF @Accion ='LISTAR'    
    BEGIN    
		SELECT
				  UnidadReplicacion,
				  IdEpisodioAtencion,
				  IdPaciente,
				  EpisodioClinico,
				  Secuencia,
				  IdCuidadoPreventivo,
				  Comentario,
				  Accion,
				  Version
				FROM SS_HC_SeguimientoRiesgoDetalle	
					WHERE 
					(@UnidadReplicacion is null OR UnidadReplicacion = @UnidadReplicacion)	
					and (@IdEpisodioAtencion is null OR (IdEpisodioAtencion = @IdEpisodioAtencion) or @IdEpisodioAtencion =0)
					and (@IdPaciente is null OR IdPaciente = @IdPaciente)
					and (@EpisodioClinico is null OR EpisodioClinico = @EpisodioClinico)				
					and (@Secuencia is null OR Secuencia = @Secuencia)
 
   END  
   ELSE
  IF @Accion ='LISTARPORIDCUIDADO'    
    BEGIN    
		SELECT
				  UnidadReplicacion,
				  IdEpisodioAtencion,
				  IdPaciente,
				  EpisodioClinico,
				  Secuencia,
				  IdCuidadoPreventivo,
				  Comentario,
				  Accion,
				  Version
				FROM SS_HC_SeguimientoRiesgoDetalle	
					WHERE 
					( UnidadReplicacion = @UnidadReplicacion)	
					and (IdEpisodioAtencion = @IdEpisodioAtencion)
					and (IdPaciente = @IdPaciente)
					and (EpisodioClinico = @EpisodioClinico)				
					and (IdCuidadoPreventivo = @IdCuidadoPreventivo)
 
   END      
END    
    
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_SeguimientoRiesgoListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from SS_HC_SeguimientoRiesgoDetalle
CREATE OR ALTER PROCEDURE [SP_SS_HC_SeguimientoRiesgoListar]
           @UnidadReplicacion char(4),
           @IdEpisodioAtencion bigint,
           @IdPaciente int,
           @EpisodioClinico int,
           @IdTipoCuidadoPreventivo int,
           @FechaSeguimiento datetime,
           @Estado int,
           @UsuarioCreacion varchar(25),
           @FechaCreacion datetime,
           @UsuarioModificacion varchar(25),
           @FechaModificacion datetime,
           @Accion varchar(25),
           @Version varchar(25)
           
           AS
BEGIN    
if(@ACCION = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR=(SELECT COUNT(IdEpisodioAtencion) FROM SS_HC_SeguimientoRiesgo
	 					WHERE 
					(@UnidadReplicacion is null OR UnidadReplicacion = @UnidadReplicacion)	
					and (@IdEpisodioAtencion is null OR (IdEpisodioAtencion = @IdEpisodioAtencion) or @IdEpisodioAtencion =0)
					and (@IdPaciente is null OR IdPaciente = @IdPaciente)
					and (@EpisodioClinico is null OR EpisodioClinico = @EpisodioClinico)				
					and (@Estado is null OR Estado = @Estado)
					)
		SELECT
				  UnidadReplicacion,
				  IdEpisodioAtencion,
				  IdPaciente,
				  EpisodioClinico,
				  IdTipoCuidadoPreventivo,
				  FechaSeguimiento,
				  Estado,
				  UsuarioCreacion,
				  FechaCreacion,
				  UsuarioModificacion,
				  FechaModificacion,
				  Accion,
				  Version
		FROM (		
			SELECT
				  UnidadReplicacion,
				  IdEpisodioAtencion,
				  IdPaciente,
				  EpisodioClinico,
				  IdTipoCuidadoPreventivo,
				  FechaSeguimiento,
				  Estado,
				  UsuarioCreacion,
				  FechaCreacion,
				  UsuarioModificacion,
				  FechaModificacion,
				  Accion,
				  Version
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY IdEpisodioAtencion ASC ) AS RowNumber   	
					FROM SS_HC_SeguimientoRiesgo	
					WHERE  
					(@UnidadReplicacion is null OR UnidadReplicacion = @UnidadReplicacion)	
					and (@IdEpisodioAtencion is null OR (IdEpisodioAtencion = @IdEpisodioAtencion) or @IdEpisodioAtencion =0)
					and (@IdPaciente is null OR IdPaciente = @IdPaciente)
					and (@EpisodioClinico is null OR EpisodioClinico = @EpisodioClinico)				
					and (@Estado is null OR Estado = @Estado)		
 
			) AS LISTADO
		
       END
       ELSE
  IF @Accion ='LISTAR'    
    BEGIN    
		SELECT
				  UnidadReplicacion,
				  IdEpisodioAtencion,
				  IdPaciente,
				  EpisodioClinico,
				  IdTipoCuidadoPreventivo,
				  FechaSeguimiento,
				  Estado,
				  UsuarioCreacion,
				  FechaCreacion,
				  UsuarioModificacion,
				  FechaModificacion,
				  Accion,
				  Version
				FROM SS_HC_SeguimientoRiesgo	
									WHERE 
					(@UnidadReplicacion is null OR UnidadReplicacion = @UnidadReplicacion)	
					and (@IdEpisodioAtencion is null OR (IdEpisodioAtencion = @IdEpisodioAtencion) or @IdEpisodioAtencion =0)
					and (@IdPaciente is null OR IdPaciente = @IdPaciente)
					and (@EpisodioClinico is null OR EpisodioClinico = @EpisodioClinico)				
					and (@Estado is null OR Estado = @Estado)	
 
   END    
	 IF @Accion ='LISTARDETALLE'    
		BEGIN    
			declare @IDCuidadoPreventivoAux int = null
			
			if(@UsuarioCreacion is not null and @UsuarioCreacion <> '')
				set @IDCuidadoPreventivoAux = convert(integer, @UsuarioCreacion)
			
		
			SELECT
					  SS_HC_SeguimientoRiesgo.UnidadReplicacion,
					  SS_HC_SeguimientoRiesgo.IdEpisodioAtencion,
					  SS_HC_SeguimientoRiesgoDetalle.Secuencia as IdPaciente,
					  SS_HC_SeguimientoRiesgo.EpisodioClinico,
					  SS_HC_SeguimientoRiesgo.IdTipoCuidadoPreventivo,
					  SS_HC_SeguimientoRiesgo.FechaSeguimiento,
					  SS_HC_SeguimientoRiesgoDetalle.Secuencia as Estado,					  
					  SS_HC_SeguimientoRiesgo.UsuarioCreacion,
					  SS_HC_EpisodioAtencion.FechaAtencion as FechaCreacion,
					  SS_HC_SeguimientoRiesgo.UsuarioModificacion,
					  SS_HC_SeguimientoRiesgo.FechaModificacion,
					  SS_HC_SeguimientoRiesgoDetalle.Comentario as Accion,
					  SS_HC_CuidadoPreventivo.Descripcion as Version
					FROM   dbo.SS_HC_SeguimientoRiesgo INNER JOIN
                      dbo.SS_HC_SeguimientoRiesgoDetalle ON dbo.SS_HC_SeguimientoRiesgo.UnidadReplicacion = dbo.SS_HC_SeguimientoRiesgoDetalle.UnidadReplicacion AND 
                      dbo.SS_HC_SeguimientoRiesgo.IdEpisodioAtencion = dbo.SS_HC_SeguimientoRiesgoDetalle.IdEpisodioAtencion AND 
                      dbo.SS_HC_SeguimientoRiesgo.IdPaciente = dbo.SS_HC_SeguimientoRiesgoDetalle.IdPaciente AND 
                      dbo.SS_HC_SeguimientoRiesgo.EpisodioClinico = dbo.SS_HC_SeguimientoRiesgoDetalle.EpisodioClinico INNER JOIN
                      dbo.SS_HC_CuidadoPreventivo ON dbo.SS_HC_SeguimientoRiesgoDetalle.IdCuidadoPreventivo = dbo.SS_HC_CuidadoPreventivo.IdCuidadoPreventivo	
                      LEFT JOIN SS_HC_EpisodioAtencion on
						(	SS_HC_EpisodioAtencion.UnidadReplicacion =SS_HC_SeguimientoRiesgo.UnidadReplicacion 
						and SS_HC_EpisodioAtencion.IdPaciente =SS_HC_SeguimientoRiesgo.IdPaciente 
						and SS_HC_EpisodioAtencion.EpisodioClinico =SS_HC_SeguimientoRiesgo.EpisodioClinico 
						and SS_HC_EpisodioAtencion.IdEpisodioAtencion =SS_HC_SeguimientoRiesgo.IdEpisodioAtencion 
						)
					WHERE  SS_HC_SeguimientoRiesgo.UnidadReplicacion = @UnidadReplicacion
						and  (@IdEpisodioAtencion is null or SS_HC_SeguimientoRiesgo.IdEpisodioAtencion = @IdEpisodioAtencion or @IdEpisodioAtencion=0 )
						and  SS_HC_SeguimientoRiesgo.IdPaciente = @IdPaciente
						and  SS_HC_SeguimientoRiesgo.EpisodioClinico = @EpisodioClinico				
						and  (@IdTipoCuidadoPreventivo is null OR SS_HC_SeguimientoRiesgo.IdTipoCuidadoPreventivo = @IdTipoCuidadoPreventivo)	
						and  (@FechaSeguimiento is null OR SS_HC_SeguimientoRiesgo.FechaSeguimiento = @FechaSeguimiento)	
						and  (@IDCuidadoPreventivoAux is null OR SS_HC_SeguimientoRiesgoDetalle.IdCuidadoPreventivo = @IDCuidadoPreventivoAux)	
						--and  (@Estado is null OR SS_HC_SeguimientoRiesgoDetalle.IdCuidadoPreventivo = @Estado)	
	 
	   END       
END    
    
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_SG_Agente]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
CREATE OR ALTER PROCEDURE [SP_SS_HC_SG_Agente]    
(    
 @IdAgente int ,    
 @IdGrupo int ,    
 @IdOrganizacion int ,    
 @TipoAgente int ,    
 @CodigoAgente varchar(15) ,    
 @IdEmpleado int ,    
 @IndicadorMultiple int ,    
 @Clave varchar(15) ,    
 @ExpiraClave int ,    
 @FechaInicio datetime  ,    
   
 @FechaFin datetime ,    
 @FechaExpiracion datetime ,    
 @Nombre varchar(60) ,    
 @Descripcion varchar(80) ,    
 @Estado int ,    
 @UsuarioCreacion varchar(25) ,    
 @FechaCreacion datetime ,    
 @UsuarioModificacion varchar(25) ,    
 @FechaModificacion datetime ,    
 @IdGrupoTransaccion int ,    
   
 @TipoTransaccion int ,    
 @IdOpcionDefecto int ,    
 @Plataforma varchar(25) ,   
 @tipotrabajador char(2),  
 @IdCodigo int,  
 @ACCION varchar(25)     
)    
    
AS    
BEGIN     
SET NOCOUNT ON;    
BEGIN  TRANSACTION    
 declare @IdAgenteAux int =0    
 declare @Contador int =0    
    
 if(@ACCION = 'INSERT')    
 begin    
  select @IdAgenteAux = isnull(MAX(IdAgente),0)+1 from SG_Agente    
  set @IdAgente = @IdAgenteAux    
  declare @CodigoEmpleado int
  set @CodigoEmpleado=(select count(*) from SS_HC_PersonalSalud where IdPersonalSalud=@IdEmpleado)

  insert into SG_Agente    
  (        
  IdAgente    
  ,IdGrupo    
  ,IdOrganizacion    
  ,TipoAgente    
  ,CodigoAgente    
  ,IdEmpleado    
  ,IndicadorMultiple    
  ,Clave    
  ,ExpiraClave    
  ,FechaInicio    
  ,FechaFin    
  ,FechaExpiracion    
  ,Nombre    
  ,Descripcion    
  ,Estado    
  ,UsuarioCreacion    
  ,FechaCreacion    
  ,UsuarioModificacion    
  ,FechaModificacion    
  --IdGrupoTransaccion
  ,flatUsuGenerico
  ,TipoTransaccion    
  ,IdOpcionDefecto    
  ,ACCION      
  ,Plataforma    
  ,tipotrabajador  
  ,IdCodigo  
        )    
  values    
     (    
	   @IdAgente    
	  , @IdGrupo    
	  , @IdOrganizacion    
	  , @TipoAgente    
	  , @CodigoAgente    
	  , @IdEmpleado    
	  , @IndicadorMultiple    
	  , @Clave    
	  , @ExpiraClave    
	  , @FechaInicio    
	  , @FechaFin    
	  , @FechaExpiracion    
	  , @Nombre    
	  , @Descripcion    
	  , @Estado    
	  , @UsuarioCreacion    
	  , GETDATE()    
	  , @UsuarioModificacion    
	  , GETDATE()    
	  , @IdGrupoTransaccion    
	  , @TipoTransaccion    
	  , @IdOpcionDefecto    
	  , @ACCION    
	  ,@Plataforma    
	  ,@tipotrabajador  
	  ,@IdCodigo  
           )    
    
    /************CREAR USUARIO PERSONAL SALUD**************************************************/
  if(@CodigoEmpleado=0)
  begin
  insert into SS_HC_PersonalSalud (IdPersonalSalud, CodigoPersonalSalud, TipoDocumentoIdentidad, NumeroDocumentoIdentidad, IdColegioProfesional, Estado, UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion
)


select PERSONAMAST.Persona,EMPLEADOMAST.TipoTrabajadorSalud,PERSONAMAST.TipoDocumento, PERSONAMAST.Documento,isnull(case when EMPLEADOMAST.CMP ='NULL' THEN NULL ELSE EMPLEADOMAST.CMP END,NULL), 2, @UsuarioCreacion, GETDATE() , @UsuarioModificacion, GETDATE()
from PERSONAMAST 
inner join EMPLEADOMAST on PERSONAMAST.Persona= EMPLEADOMAST.Empleado
where 
PERSONAMAST.Persona= @IdEmpleado
end

  /************CREAR SU FAVORITO POR DEFECTO*************************************************/    
  select @Contador = COUNT(*) from SS_HC_Favorito  where IdAgente = @IdAgente    
  if(@Contador =0 and @TipoAgente = 2)    
  begin    
   select @Contador = isnull(MAX(IdFavorito),0)+1 from SS_HC_Favorito      
       
   insert into SS_HC_Favorito    
   (IdFavorito,Descripcion,TipoFavorito,IdAgente,Estado,    
   UsuarioCreacion,FechaCreacion )    
   values    
   (    
   @Contador,@Nombre,1,@IdAgente,2,    
   @UsuarioCreacion,GETDATE()    
   )       
  end    
 
      
  select @IdAgenteAux    
 end    
 else    
 if(@ACCION = 'UPDATE')    
 begin    
	 UPDATE SG_Agente    
		SET       
	  IdGrupo = @IdGrupo    
	  ,IdOrganizacion = @IdOrganizacion    
	  ,TipoAgente = @TipoAgente    
	  ,CodigoAgente = @CodigoAgente    
	  ,IdEmpleado = @IdEmpleado    
	  ,IndicadorMultiple = @IndicadorMultiple    
	  ,Clave = @Clave    
	  ,ExpiraClave = @ExpiraClave    
	  ,FechaInicio = @FechaInicio    
	  ,FechaFin = @FechaFin    
	  ,FechaExpiracion = @FechaExpiracion    
	  ,Nombre = @Nombre    
	  ,Descripcion = @Descripcion    
	  ,Estado = @Estado    
	  ,UsuarioModificacion = @UsuarioModificacion    
	  ,FechaModificacion = GETDATE()    
	   ,flatUsuGenerico= @IdGrupoTransaccion    
	  ,TipoTransaccion = @TipoTransaccion    
	  ,IdOpcionDefecto = @IdOpcionDefecto    
	  ,ACCION = @ACCION    
	  ,Plataforma = @Plataforma
	  ,tipotrabajador = (CASE @tipotrabajador  WHEN 'nu' then null else @tipotrabajador end)
	  ,IdCodigo =  (CASE @TipoAgente WHEN '1' THEN NULL ELSE @IdCodigo END)
			WHERE     
		 (IdAgente = @IdAgente)     
       
   select 2       
 end     
 else    
 if(@ACCION = 'DELETE')    
 begin  
  declare @codigoEmp int =0;   
		set @codigoEmp = (select COUNT(*) from SS_HC_EpisodioAtencion where IdPersonalSalud=@IdEmpleado)
		
		if(@codigoEmp>0)
		  begin 
		set @IdAgente = 0
		end
		else
		begin
		--FAVORITO
		delete  SS_HC_FavoritoDetalle
		where IdFavorito in(
			select IdFavorito from SS_HC_Favorito
			where IdAgente = @IdAgente	
		)
		delete SS_HC_FavoritoCodigoId
		where IdFavorito in(
			select IdFavorito from SS_HC_Favorito
			where IdAgente = @IdAgente	
		)
		delete SS_HC_FavoritoNumero
		where IdFavorito in(
			select IdFavorito from SS_HC_Favorito
			where IdAgente = @IdAgente	
		)
 		delete from SS_HC_Favorito
		where IdAgente = @IdAgente
	
		--------------------------
	  delete dbo.SG_PerfilUsuario    
	  where     
	  (@IdAgente in( IdPerfil,IdUsuario) )     
	     
	  delete dbo.SG_AgenteOpcion    
	  WHERE     
	  (IdAgente = @IdAgente)     
	       
	  delete SG_Agente    
	  WHERE     
	  (IdAgente = @IdAgente)   
	  ----------------------PERSONA SALUD--------------
	  delete from SS_HC_PersonalSalud  where IdPersonalSalud=@IdEmpleado

	  
      end
  select @IdAgente    
 end     
 if(@ACCION = 'LISTARPAG')    
 begin      
      
  SET @CONTADOR=(SELECT COUNT(*) FROM SG_Agente    
    WHERE     
    (@IdAgente is null or @IdAgente =0 or  cast(IdAgente as VARCHAR) like '%'+upper(@IdAgente)+'%')    
    and (@IdGrupo is null or IdGrupo = @IdGrupo)     
     and (@NOMBRE is null  OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')           
     and (@CodigoAgente is null  OR @CodigoAgente =''  OR  upper(CodigoAgente) like '%'+upper(@CodigoAgente)+'%')           
     and (@IdEmpleado is null OR IdEmpleado = @IdEmpleado)         
          
     and (@ESTADO is null OR Estado = @ESTADO)    
     and (@TipoAgente is null OR TipoAgente = @TipoAgente)    
     and (@Plataforma is null OR Plataforma = @Plataforma)    
     )    
  select @CONTADOR    
 end    
     
commit     
     
END    
    
/*    
exec [SP_SS_HC_SG_Agente]    
 NULL,    
 NULL,    
 NULL,    
 NULL,    
 NULL,    
 NULL,    
 NULL,    
 NULL,    
 NULL,    
 NULL,    
 NULL,    
 NULL,    
 NULL,    
 NULL,    
 NULL,    
 NULL,    
 NULL,    
 NULL,    
 NULL,    
 NULL,    
 NULL,    
 NULL,    
 'LISTARPAG'    
     
 */    
     
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_SG_Agente_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
  
CREATE OR ALTER PROCEDURE [SP_SS_HC_SG_Agente_LISTAR]    
(    
 @IdAgente int ,    
 @IdGrupo int ,    
 @IdOrganizacion int ,    
 @TipoAgente int ,    
 @CodigoAgente varchar(15) ,    
 @IdEmpleado int ,    
 @IndicadorMultiple int ,    
 @Clave varchar(15) ,    
 @ExpiraClave int ,    
 @FechaInicio datetime ,       
 @FechaFin datetime ,    
 @FechaExpiracion datetime ,    
 @Nombre varchar(60) ,    
 @Descripcion varchar(80) ,    
 @Estado int ,    
 @UsuarioCreacion varchar(25) ,    
 @FechaCreacion datetime ,    
 @UsuarioModificacion varchar(25) ,    
 @FechaModificacion datetime ,    
 @IdGrupoTransaccion int ,       
 @TipoTransaccion int ,    
 @IdOpcionDefecto int ,    
 @Plataforma varchar(25) ,    
 @tipotrabajador  char(2),  
 @IdCodigo int,  
 @INICIO   int= null,      
 @NUMEROFILAS int = null ,    
 @ACCION varchar(25)     
)    
    
AS    
BEGIN     
SET NOCOUNT ON;    
    
     
 DECLARE @CONTADOR INT=0    
 if(@ACCION = 'LISTARPAG')    
 begin    
       
  SET @CONTADOR=(SELECT COUNT(*) FROM SG_Agente    
    WHERE     
    (@IdAgente is null or @IdAgente =0 or  cast(IdAgente as VARCHAR) like '%'+upper(@IdAgente)+'%')    
    and (@IdGrupo is null or IdGrupo = @IdGrupo)     
     and (@NOMBRE is null  OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')           
     and (@CodigoAgente is null  OR @CodigoAgente =''  OR  upper(CodigoAgente) like '%'+upper(@CodigoAgente)+'%')           
     and (@IdEmpleado is null OR IdEmpleado = @IdEmpleado)         
         
     and (@ESTADO is null OR Estado = @ESTADO)    
     and (@TipoAgente is null OR TipoAgente = @TipoAgente)        
     and (@Plataforma is null OR Plataforma = @Plataforma)    
     )    
      
  SELECT     
   IdAgente    
   ,IdGrupo    
   ,IdOrganizacion    
   ,TipoAgente    
   ,CodigoAgente    
   ,IdEmpleado    
   ,IndicadorMultiple    
   ,Clave    
   ,(CASE ExpiraClave WHEN 1 THEN 2 WHEN 2 THEN 1 END ) AS ExpiraClave  
   ,FechaInicio    
   ,FechaFin    
   ,FechaExpiracion    
   ,Nombre    
   ,Descripcion    
   ,Estado    
   ,UsuarioCreacion    
   ,FechaCreacion    
   ,UsuarioModificacion    
   ,FechaModificacion    
   ,IdGrupoTransaccion    
   ,TipoTransaccion    
   ,IdOpcionDefecto    
   ,isnull(DescTipoTrabajadorX,    
    case TipoAgente when 2 then 'NO DETERMINADO'else '--' end) as ACCION        
   ,Plataforma    
   ,TipoTrabajadorX AS tipotrabajador  
   ,IdCodigo
   ,Almacen  
    ,flatUsuGenerico
	,FlatAgente  
  FROM (SELECT SG_Agente.*,     
     EMP.TIPOTRABAJADORSALUD as TipoTrabajadorX,    
     tipoTrab.DescripcionLocal as DescTipoTrabajadorX,    
         @CONTADOR AS Contador,    
            ROW_NUMBER() OVER (ORDER BY IdAgente ASC ) AS RowNumber        
     FROM SG_Agente      
     LEFT join EMPLEADOMAST  EMP on (EMP.empleado = SG_Agente.idEmpleado)       
     LEFT join SS_TipoTrabajador tipoTrab on (tipoTrab.TipoTrabajador = EMP.TIPOTRABAJADORSALUD)    
     WHERE     
     (@IdAgente is null or @IdAgente =0 or  cast(IdAgente as VARCHAR) like '%'+upper(@IdAgente)+'%')    
     and (@IdGrupo is null or IdGrupo = @IdGrupo)     
      and (@NOMBRE is null  OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')           
      and (@CodigoAgente is null  OR @CodigoAgente =''  OR  upper(CodigoAgente) like '%'+upper(@CodigoAgente)+'%')           
      and (@IdEmpleado is null OR IdEmpleado = @IdEmpleado)         
            
      and (@ESTADO is null OR SG_Agente.Estado = @ESTADO)    
      and (@TipoAgente is null OR TipoAgente = @TipoAgente)    
      and (@Plataforma is null OR Plataforma = @Plataforma)    
     ) AS LISTADO    
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR      
            RowNumber BETWEEN @Inicio  AND @NumeroFilas        
 end 
 else

  if(@ACCION = 'LISTARPAG_TOTAL_PER')    
 begin    
       
  SET @CONTADOR=(SELECT COUNT(*) FROM SG_Agente    
    WHERE     
    (@IdAgente is null or @IdAgente =0 or  cast(IdAgente as VARCHAR) like '%'+upper(@IdAgente)+'%')    
    and (@IdGrupo is null or IdGrupo = @IdGrupo)     
     and (@NOMBRE is null  OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')           
     and (@CodigoAgente is null  OR @CodigoAgente =''  OR  upper(CodigoAgente) like '%'+upper(@CodigoAgente)+'%')           
     and (@IdEmpleado is null OR IdEmpleado = @IdEmpleado)         
         
     and (@ESTADO is null OR Estado = @ESTADO)    
     and (@TipoAgente is null OR TipoAgente = @TipoAgente)        
     and (@Plataforma is null OR Plataforma = @Plataforma)    
     )    
      
  SELECT     
   IdAgente    
   ,IdGrupo    
   ,IdOrganizacion    
   ,TipoAgente    
   ,CodigoAgente    
   ,IdEmpleado    
   ,IndicadorMultiple    
   ,Clave    
   ,(CASE ExpiraClave WHEN 1 THEN 2 WHEN 2 THEN 1 END ) AS ExpiraClave  
   ,FechaInicio    
   ,FechaFin    
   ,FechaExpiracion    
   ,Nombre    
   ,Descripcion    
   ,Estado    
   ,UsuarioCreacion    
   ,FechaCreacion    
   ,UsuarioModificacion    
   ,FechaModificacion    
   ,IdGrupoTransaccion    
   ,TipoTransaccion    
   ,IdOpcionDefecto    
   ,isnull(DescTipoTrabajadorX,    
    case TipoAgente when 2 then 'NO DETERMINADO'else '--' end) as ACCION        
   ,Plataforma    
   ,TipoTrabajadorX AS tipotrabajador  
   ,IdCodigo
   ,Almacen  
    ,flatUsuGenerico
	,FlatAgente  
  FROM (SELECT SG_Agente.*,     
     EMP.TIPOTRABAJADORSALUD as TipoTrabajadorX,    
     tipoTrab.DescripcionLocal as DescTipoTrabajadorX,    
         @CONTADOR AS Contador,    
            ROW_NUMBER() OVER (ORDER BY IdAgente ASC ) AS RowNumber        
     FROM SG_Agente      
     LEFT join EMPLEADOMAST  EMP on (EMP.empleado = SG_Agente.idEmpleado)       
     LEFT join SS_TipoTrabajador tipoTrab on (tipoTrab.TipoTrabajador = EMP.TIPOTRABAJADORSALUD)    
     WHERE     
     (@IdAgente is null or @IdAgente =0 or  cast(IdAgente as VARCHAR) like '%'+upper(@IdAgente)+'%')    
     and (@IdGrupo is null or IdGrupo = @IdGrupo)     
      and (@NOMBRE is null  OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')           
      and (@CodigoAgente is null  OR @CodigoAgente =''  OR  upper(CodigoAgente) like '%'+upper(@CodigoAgente)+'%')           
      and (@IdEmpleado is null OR IdEmpleado = @IdEmpleado)         
            
      and (@ESTADO is null OR SG_Agente.Estado = @ESTADO)    
      and (@TipoAgente is null OR TipoAgente = @TipoAgente)    
      and (@Plataforma is null OR Plataforma = @Plataforma)    
     ) AS LISTADO    
	 WHERE (@TipoAgente is null OR TipoAgente = @TipoAgente)
     
 end 
 else

 if(@ACCION = 'LISTARPAG_AUDITORIA')    
 begin    
       
  SET @CONTADOR=(SELECT COUNT(*) FROM SG_Agente    
    WHERE     
       ---292076
      (@IdEmpleado is null OR IdEmpleado = @IdEmpleado)         
 
     )    
      
  SELECT     
   IdAgente    
   ,IdGrupo    
   ,IdOrganizacion    
   ,TipoAgente    
   ,CodigoAgente    
   ,IdEmpleado    
   ,IndicadorMultiple    
   ,Clave    
   ,(CASE ExpiraClave WHEN 1 THEN 2 WHEN 2 THEN 1 END ) AS ExpiraClave  
   ,FechaInicio    
   ,FechaFin    
   ,FechaExpiracion    
   ,Nombre    
   ,Descripcion    
   ,Estado    
   ,UsuarioCreacion    
   ,FechaCreacion    
   ,UsuarioModificacion    
   ,FechaModificacion    
   ,IdGrupoTransaccion    
   ,TipoTransaccion    
   ,IdOpcionDefecto    
   ,isnull(DescTipoTrabajadorX,    
    case TipoAgente when 2 then 'NO DETERMINADO'else '--' end) as ACCION        
   ,Plataforma    
   ,TipoTrabajadorX AS tipotrabajador  
   ,IdCodigo 
   ,Almacen 
    ,flatUsuGenerico
	,FlatAgente   
  FROM (SELECT SG_Agente.*,     
     EMP.TIPOTRABAJADORSALUD as TipoTrabajadorX,    
     tipoTrab.DescripcionLocal as DescTipoTrabajadorX,    
         @CONTADOR AS Contador,    
            ROW_NUMBER() OVER (ORDER BY IdAgente ASC ) AS RowNumber        
     FROM SG_Agente      
     LEFT join EMPLEADOMAST  EMP on (EMP.empleado = SG_Agente.idEmpleado)       
     LEFT join SS_TipoTrabajador tipoTrab on (tipoTrab.TipoTrabajador = EMP.TIPOTRABAJADORSALUD)    
     WHERE              
       (@IdEmpleado is null OR IdEmpleado = 292076 OR SG_Agente.IdEmpleado=@IdEmpleado)       
     ) AS LISTADO    
      
 end    
 else 
    
 if(@ACCION = 'LISTAR')    
 begin    
  select     
     IdAgente    
   ,IdGrupo    
   ,IdOrganizacion    
   ,TipoAgente    
   ,CodigoAgente    
   ,IdEmpleado    
   ,IndicadorMultiple    
   ,Clave    
   ,ExpiraClave    
   ,FechaInicio    
   ,FechaFin    
   ,FechaExpiracion    
   ,Nombre    
   ,Descripcion    
   ,Estado    
   ,UsuarioCreacion    
   ,FechaCreacion    
   ,UsuarioModificacion    
   ,FechaModificacion    
   ,IdGrupoTransaccion    
   ,TipoTransaccion    
   ,IdOpcionDefecto    
   ,ACCION        
   ,Plataforma    
   ,(select TipoTrabajadorSalud from empleadomast where Empleado = IdEmpleado) as tipotrabajador  
   ,IdCodigo  
   ,Almacen 
    ,flatUsuGenerico
	,FlatAgente  
   from  SG_Agente    
  WHERE     
  (@IdAgente is null or @IdAgente =0 or  IdAgente = @IdAgente)     
  and (@IdGrupo is null or IdGrupo = @IdGrupo)     
   and (@NOMBRE is null  OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')           
   and (@CodigoAgente is null  OR @CodigoAgente =''  OR  upper(CodigoAgente) like '%'+upper(@CodigoAgente)+'%')           
   and (@IdEmpleado is null OR IdEmpleado = @IdEmpleado)         
        
   and (@ESTADO is null OR Estado = @ESTADO)    
   and (@TipoAgente is null OR TipoAgente = @TipoAgente)    
   and (@Plataforma is null OR Plataforma = @Plataforma)    
         
 end     
 else    
 if(@ACCION = 'VALIDARLOGIN')    
 begin  
 
  select     
   IdAgente    
   ,IdGrupo    
   ,IdOrganizacion    
   ,TipoAgente    
   ,CodigoAgente    
   ,IdEmpleado    
   ,IndicadorMultiple    
   ,Clave    
   ,ExpiraClave    
   ,FechaInicio    
   ,FechaFin    
   ,FechaExpiracion    
   ,NombreEmpleadoX as Nombre  
   ,Descripcion    
   ,Estado    
   ,UsuarioCreacion    
   ,FechaCreacion    
   ,NombreEmpleadoX as UsuarioModificacion    
   ,FechaModificacion    
   ,IdGrupoTransaccion    
   ,TipoTransaccion 
   ,IdOpcionDefecto    
   ,ACCION        
   ,Plataforma   
   ,(case TipoAgente when 2 then TipoTrabajadorX else tipotrabajador end ) as tipotrabajador  
   ,IdCodigo  
   ,Almacen 
    ,flatUsuGenerico
	,FlatAgente 
  from    
  (  
 select SG_Agente.* ,  
	EMPLEADOMAST.TIPOTRABAJADORSALUD as TipoTrabajadorX  ,	
	PERSONAMAST.NombreCompleto as NombreEmpleadoX  
 from SG_Agente    
 left join EMPLEADOMAST on (SG_Agente.IdEmpleado = EMPLEADOMAST.Empleado)  
 left join PERSONAMAST on (EMPLEADOMAST.Empleado = PERSONAMAST.Persona)  

 WHERE     
 (CodigoAgente =@CodigoAgente)     
 and (isnull(Clave,'') = isnull(@Clave,''))  
 and SG_Agente.Estado=2 and
CAST((case when SG_Agente.FechaExpiracion IS NULL
 then 
 SG_Agente.FechaFin 
 else 
	SG_Agente.FechaExpiracion 
	end
	)AS DATE)  > CAST(GETDATE() AS DATE)

	and
	CAST(SG_Agente.FechaInicio AS DATE)  <= CAST(GETDATE() AS DATE)

  )AS AGENTE 
  
 end  

 if(@ACCION = 'VALIDARLOGIN_WEB_APP')    
 begin    
  select     
   IdAgente    
   ,IdGrupo    
   ,IdOrganizacion    
   ,TipoAgente    
   ,CodigoAgente    
   ,IdEmpleado    
   ,IndicadorMultiple    
   ,Clave    
   ,ExpiraClave    
   ,FechaInicio    
   ,FechaFin    
   ,FechaExpiracion    
   ,NombreEmpleadoX as Nombre  
   ,Descripcion    
   ,Estado    
   ,UsuarioCreacion    
   ,FechaCreacion    
   ,NombreEmpleadoX as UsuarioModificacion    
   ,FechaModificacion    
   ,IdGrupoTransaccion    
   ,TipoTransaccion 
   ,IdOpcionDefecto    
   ,ACCION        
   ,Plataforma   
   ,(case TipoAgente when 2 then TipoTrabajadorX else tipotrabajador end ) as tipotrabajador  
   ,IdCodigo  
   ,Almacen 
    ,flatUsuGenerico
	,FlatAgente  
  from    
  (  
 select SG_Agente.* ,  
	'' as TipoTrabajadorX  ,	
	PERSONAMAST.NombreCompleto as NombreEmpleadoX  
 from SG_Agente    
 left join PERSONAMAST on (SG_Agente.IdEmpleado = PERSONAMAST.Persona)  
 WHERE     
 (CodigoAgente = @CodigoAgente)     
 and (isnull(Clave,'') = isnull(@Clave,''))  and SG_Agente.Estado=2
  )AS AGENTE  
  
 end   
  
 if(@ACCION = 'VALIDARLOGIN_RELEVO')    
 begin    
  select     
   IdAgente    
   ,IdGrupo    
   ,IdOrganizacion    
   ,TipoAgente    
   ,CodigoAgente    
   ,IdEmpleado    
   ,IndicadorMultiple    
   ,Clave    
   ,ExpiraClave    
   ,FechaInicio    
   ,FechaFin    
   ,FechaExpiracion    
   ,NombreEmpleadoX as Nombre  
   ,Descripcion    
   ,Estado    
   ,UsuarioCreacion    
   ,FechaCreacion    
   ,NombreEmpleadoX as UsuarioModificacion    
   ,FechaModificacion    
   ,IdGrupoTransaccion    
   ,TipoTransaccion 
   ,IdOpcionDefecto    
   ,ACCION        
   ,Plataforma   
   ,(case TipoAgente when 2 then TipoTrabajadorX else tipotrabajador end ) as tipotrabajador  
   ,IdCodigo  
   ,Almacen 
    ,flatUsuGenerico
	,FlatAgente  
  from    
  (  
 select SG_Agente.* ,  
	convert(varchar,EMPLEADOMAST.idEspecialidad) as TipoTrabajadorX  ,	
	PERSONAMAST.NombreCompleto as NombreEmpleadoX  
 from SG_Agente    
 left join PERSONAMAST on (SG_Agente.IdEmpleado = PERSONAMAST.Persona)  
 left join EMPLEADOMAST on (SG_Agente.IdEmpleado = EMPLEADOMAST.Empleado)  
 WHERE     
 (CodigoAgente = @CodigoAgente)     
 and (isnull(Clave,'') = isnull(@Clave,''))  and SG_Agente.Estado=2
  )AS AGENTE  
  
 end   

  if(@ACCION = 'VALIDAR_MEDICO')    
 begin    
  select     
   IdAgente    
   ,IdGrupo    
   ,IdOrganizacion    
   ,TipoAgente    
   ,CodigoAgente    
   ,IdEmpleado    
   ,IndicadorMultiple    
   ,Clave    
   ,ExpiraClave    
   ,FechaInicio    
   ,FechaFin    
   ,FechaExpiracion    
   ,NombreEmpleadoX as Nombre  
   ,Descripcion    
   ,Estado    
   ,UsuarioCreacion    
   ,FechaCreacion    
   ,NombreEmpleadoX as UsuarioModificacion    
   ,FechaModificacion    
   ,IdGrupoTransaccion    
   ,TipoTransaccion 
   ,IdOpcionDefecto    
   ,ACCION        
   ,Plataforma   
   ,(case TipoAgente when 2 then TipoTrabajadorX else tipotrabajador end ) as tipotrabajador  
   ,IdCodigo  
   ,Almacen 
    ,flatUsuGenerico
	,FlatAgente  
  from    
  (  
 select SG_Agente.* ,  
	'' as TipoTrabajadorX  ,	
	PERSONAMAST.NombreCompleto as NombreEmpleadoX  
 from SG_Agente    
 left join PERSONAMAST on (SG_Agente.IdEmpleado = PERSONAMAST.Persona)  
 WHERE     
 (IdEmpleado = @IdEmpleado)  and SG_Agente.Estado=2
  )AS AGENTE  
  
 end   
 
  
 if(@ACCION = 'VALIDARLOGIN_TRIAJE')    
 begin    
  select     
   IdAgente    
   ,IdGrupo    
   ,IdOrganizacion    
   ,TipoAgente    
   ,CodigoAgente    
   ,IdEmpleado    
   ,IndicadorMultiple    
   ,Clave    
   ,ExpiraClave    
   ,FechaInicio    
   ,FechaFin    
   ,FechaExpiracion    
   ,NombreEmpleadoX as Nombre  
   ,Descripcion    
   ,Estado    
   ,UsuarioCreacion    
   ,FechaCreacion    
   ,NombreEmpleadoX as UsuarioModificacion    
   ,FechaModificacion    
   ,IdGrupoTransaccion    
   ,TipoTransaccion 
   ,IdOpcionDefecto    
   ,ACCION        
   ,Plataforma   
   ,(case TipoAgente when 2 then TipoTrabajadorX else tipotrabajador end ) as tipotrabajador  
   ,IdCodigo  
   ,Almacen 
    ,flatUsuGenerico
	,FlatAgente  
  from    
  (  
 select SG_Agente.* ,  
	'' as TipoTrabajadorX  ,	
	PERSONAMAST.NombreCompleto as NombreEmpleadoX  
 from SG_Agente    
 left join PERSONAMAST on (SG_Agente.IdEmpleado = PERSONAMAST.Persona)  
 WHERE     
 (CodigoAgente = @CodigoAgente) and (isnull(Clave,'') = isnull(@Clave,'')  
  )   and SG_Agente.Estado=2
  )AS AGENTE  
  
 end   
 
  else    
 if(@ACCION = 'VALIDARLOGINEMER')    
 begin    
  select     
   IdAgente    
   ,IdGrupo    
   ,IdOrganizacion    
   ,TipoAgente    
   ,CodigoAgente    
   ,IdEmpleado    
   ,IndicadorMultiple    
   ,Clave    
   ,ExpiraClave    
   ,FechaInicio    
   ,FechaFin    
   ,FechaExpiracion    
   ,NombreEmpleadoX as Nombre  
   ,Descripcion    
   ,Estado    
   ,UsuarioCreacion    
   ,FechaCreacion    
   ,NombreEmpleadoX as UsuarioModificacion    
   ,FechaModificacion    
   ,idespecialidadx AS IdGrupoTransaccion    
   , TipoTransaccion 
   ,IdOpcionDefecto    
   ,ACCION        
   ,Plataforma   
   ,(case TipoAgente when 2 then TipoTrabajadorX else tipotrabajador end ) as tipotrabajador  
   ,IdCodigo  
   ,Almacen 
    ,flatUsuGenerico
	,FlatAgente  
  from    
  (  
 select distinct SG_Agente.* ,  
	EMPLEADOMAST.TIPOTRABAJADORSALUD as TipoTrabajadorX  ,	SS_GE_EspecialidadMedico.idEspecialidad as idespecialidadx,
	PERSONAMAST.NombreCompleto as NombreEmpleadoX  
 from SG_Agente    
 left join EMPLEADOMAST on (SG_Agente.IdEmpleado = EMPLEADOMAST.Empleado)  
 left join PERSONAMAST on (EMPLEADOMAST.Empleado = PERSONAMAST.Persona)  
 left join SS_GE_EspecialidadMedico on (SS_GE_EspecialidadMedico.IdMedico = EMPLEADOMAST.Empleado)

 WHERE     
 (CodigoAgente = @CodigoAgente)     
 and (isnull(Clave,'') = isnull(@Clave,'')) 
 and SG_Agente.Estado=2
  and (@IdGrupoTransaccion is null OR  @IdGrupoTransaccion = 0 or  SS_GE_EspecialidadMedico.IdEspecialidad = @IdGrupoTransaccion)
  )AS AGENTE  
  
 end    
  
 else    
 if(@ACCION = 'LISTARPERFILES')    
 begin    
  select     
   IdAgente    
   ,IdGrupo    
   ,IdOrganizacion    
   ,TipoAgente    
   ,CodigoAgente    
   ,IdEmpleado    
   ,IndicadorMultiple    
   ,Clave    
   ,ExpiraClave    
   ,FechaInicio    
   ,FechaFin    
   ,FechaExpiracion    
   ,Nombre    
   ,Descripcion    
   ,Estado    
   ,UsuarioCreacion    
   ,FechaCreacion    
   ,UsuarioModificacion    
   ,FechaModificacion    
   ,IdGrupoTransaccion    
   ,TipoTransaccion    
   ,IdOpcionDefecto    
   ,ACCION        
   ,Plataforma    
   ,tipotrabajador  
   ,IdCodigo 
   ,Almacen 
    ,flatUsuGenerico 
	,FlatAgente    
  from  SG_Agente    
  WHERE     
  TipoAgente = 1
  AND Estado=2    -- cambio  estados activos 08-05-2020    
  AND (@IdAgente is null or @IdAgente = 0 or idAgente = @IdAgente)   and SG_Agente.Estado=2   
   ORDER BY Nombre
 end     
 else    
 if(@ACCION = 'LISTARUSUARIOS')    
 begin    
  select     
   IdAgente    
   ,IdGrupo    
   ,IdOrganizacion    
   ,TipoAgente    
   ,CodigoAgente    
   ,IdEmpleado    
   ,IndicadorMultiple    
   ,Clave    
   ,ExpiraClave    
   ,FechaInicio    
   ,FechaFin    
   ,FechaExpiracion    
   ,Nombre    
   ,Descripcion    
   ,Estado    
   ,UsuarioCreacion    
   ,FechaCreacion    
   ,UsuarioModificacion    
   ,FechaModificacion    
   ,IdGrupoTransaccion    
   ,TipoTransaccion    
   ,IdOpcionDefecto    
   ,ACCION        
   ,Plataforma      
   ,tipotrabajador  
   ,IdCodigo  
   ,Almacen 
    ,flatUsuGenerico
	,FlatAgente  
  from  SG_Agente    
  WHERE     
  TipoAgente = 2    
  AND (@IdAgente is null or @IdAgente = 0 or idAgente = @IdAgente)     
      
 end 
 
  else    
 if(@ACCION = 'VALIDAESPECIALIDADAD')    
 begin    
  select     
   IdAgente    
   ,IdGrupo    
   ,IdOrganizacion    
   ,TipoAgente    
   ,CodigoAgente    
   ,IdEmpleado    
   ,IndicadorMultiple    
   ,Clave    
   ,ExpiraClave    
   ,FechaInicio    
   ,FechaFin    
   ,FechaExpiracion    
   ,NombreEmpleadoX as Nombre  
   ,Descripcion    
   ,Estado    
   ,UsuarioCreacion    
   ,FechaCreacion    
   ,NombreEmpleadoX as UsuarioModificacion    
   ,FechaModificacion    
   ,idespecialidadx AS IdGrupoTransaccion    
   , TipoTransaccion 
   ,IdOpcionDefecto    
   ,ACCION        
   ,Plataforma   
   ,(case TipoAgente when 2 then TipoTrabajadorX else tipotrabajador end ) as tipotrabajador  
   ,IdCodigo  
   ,Almacen 
    ,flatUsuGenerico
	,FlatAgente  
  from    
  (  
 select distinct SG_Agente.* ,  
	EMPLEADOMAST.TIPOTRABAJADORSALUD as TipoTrabajadorX  ,	SS_GE_EspecialidadMedico.idEspecialidad as idespecialidadx,
	PERSONAMAST.NombreCompleto as NombreEmpleadoX  
 from SG_Agente    
 left join EMPLEADOMAST on (SG_Agente.IdEmpleado = EMPLEADOMAST.Empleado)  
 left join PERSONAMAST on (EMPLEADOMAST.Empleado = PERSONAMAST.Persona)  
 left join SS_GE_EspecialidadMedico on (SS_GE_EspecialidadMedico.IdMedico = EMPLEADOMAST.Empleado)

 WHERE     
 (CodigoAgente = @CodigoAgente)     
 and SG_Agente.Estado=2
  and (@IdGrupoTransaccion is null OR  @IdGrupoTransaccion = 0 or  SS_GE_EspecialidadMedico.IdEspecialidad = @IdGrupoTransaccion)
  )AS AGENTE  
  
 end    
 if(@ACCION = 'VALIDARCODIGO')    
 begin    
   select     
    IdAgente    
    ,IdGrupo    
    ,IdOrganizacion    
    ,TipoAgente    
    ,CodigoAgente    
    ,IdEmpleado    
    ,IndicadorMultiple    
    ,Clave    
    ,ExpiraClave    
    ,FechaInicio    
    ,FechaFin    
    ,FechaExpiracion    
    ,Nombre    
    ,Descripcion    
    ,Estado    
    ,UsuarioCreacion    
    ,FechaCreacion    
    ,UsuarioModificacion    
    ,FechaModificacion    
    ,IdGrupoTransaccion    
    ,TipoTransaccion    
    ,IdOpcionDefecto    
    ,ACCION        
    ,Plataforma    
    ,tipotrabajador  
    ,IdCodigo  
	,Almacen 
	 ,flatUsuGenerico  
 ,FlatAgente    
   from  SG_Agente    
   WHERE     
   (CodigoAgente = @CodigoAgente)      
    end  
      
END    
    
/*    
exec [SP_SS_HC_SG_Agente_LISTAR]    
 0,  NULL,  NULL,  NULL,  NULL,    
 NULL,  NULL,  NULL,  NULL,  NULL,    
 NULL,  NULL,  NULL,  NULL,  2,    
 NULL,  NULL,  NULL,  NULL,  NULL,    
 NULL,NULL,'WEB',0,15,  
 'LISTARPAG'    
 */
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_SG_AgenteOpcion]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_SG_AgenteOpcion]
(
	@IdAgente	int ,
	@IdOpcion	int ,
	@ValorFecha	datetime ,
	@ValorNumerico	decimal(20, 10) ,
	@ValorTexto	varchar(80) ,	
	@IndicadorAcceso	int ,
	@IndicadorHabilitado	int ,
	@IndicadorObligatorio	int ,
	@IndicadorVisible	int ,
	@IndicadorPrioridad	int ,	
	@IndicadorNuevo	int ,
	@IndicadorModificar	int ,
	@IndicadorEliminar	int ,
	@IndicadorImprimir int,
	@IndicadorIngreso	int ,
	@Estado	int ,	
	@UsuarioCreacion	varchar(25) ,
	@FechaCreacion	datetime ,
	@UsuarioModificacion	varchar(25) ,
	@FechaModificacion	datetime ,	
	@Version	varchar(25) ,
	@ACCION	varchar(25) 
)

AS
BEGIN 
SET NOCOUNT ON;
BEGIN  TRANSACTION
	declare @IdAgenteAux int =0

	if(@ACCION = 'INSERT')
	begin
		---delete de seguridad
		delete SG_AgenteOpcion 
		WHERE 
			(IdAgente = @IdAgente)	
			and (IdOpcion = @IdOpcion)		
		
		insert into SG_AgenteOpcion
		(  		
			IdAgente
			,IdOpcion
			,ValorFecha
			,ValorNumerico
			,ValorTexto
			,IndicadorAcceso
			,IndicadorHabilitado
			,IndicadorObligatorio
			,IndicadorVisible
			,IndicadorPrioridad
			,IndicadorNuevo
			,IndicadorModificar
			,IndicadorEliminar
			,IndicadorImprimir
			,IndicadorIngreso
			,Estado
			,UsuarioCreacion
			,FechaCreacion
			,UsuarioModificacion
			,FechaModificacion
			,Accion
			,Version

        )
		values
		   (
			@IdAgente
		,	@IdOpcion
		,	@ValorFecha
		,	@ValorNumerico
		,	@ValorTexto
		,	@IndicadorAcceso
		,	@IndicadorHabilitado
		,	@IndicadorObligatorio
		,	@IndicadorVisible
		,	@IndicadorPrioridad
		,	@IndicadorNuevo
		,	@IndicadorModificar
		,	@IndicadorEliminar
		,   @IndicadorImprimir
		,	@IndicadorIngreso
		,	@Estado
		,	@UsuarioCreacion
		,	getdate()
		,	@UsuarioModificacion
		,	getdate()
		,	@Accion
		,	@Version
           )
		if(@IdAgente = -2) --AGENTE ADMINSYS
			set @IdAgente = 1
			
		select @IdAgente
	end
	else
	if(@ACCION = 'UPDATE')
	begin	
	   
		select @IdAgente			
	end	
	else
	if(@ACCION = 'DELETE')
	begin
		delete SG_AgenteOpcion
		  WHERE 
				(IdAgente = @IdAgente)	
				and (IdOpcion = @IdOpcion)
		
		select @IdAgente
	end	
	if(@ACCION = 'LISTARPAG')
	begin		
		DECLARE @CONTADOR INT =0
		SET @CONTADOR=(SELECT COUNT(*) FROM SG_AgenteOpcion
				WHERE 
				(@IdAgente is null or @IdAgente =0 or  IdAgente = @IdAgente)										
				and (@IdOpcion is null or @IdOpcion =0 or  IdOpcion = @IdOpcion)	
				and (@ESTADO is null OR Estado = @ESTADO)
										
				)

		select @CONTADOR
	end
	
commit	
	
END

/*
exec SP_SS_HC_SG_AgenteOpcion

	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
		
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
		
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
		
	'LISTARPAG'
	
	*/

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_SG_Grupo]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_SG_Grupo]
(
	@IdGrupo	int,
	@IdGrupoPadre	int ,
	@CodigoGrupo	varchar(15) ,
	@CadenaRecursividad	varchar(150) ,
	@NivelGrupo	int ,
	
	@Nombre	varchar(80) ,
	@Descripcion	varchar(150) ,
	@Estado	int ,
	@UsuarioCreacion	varchar(25) ,
	@FechaCreacion	datetime ,
	
	@UsuarioModificacion	varchar(25) ,
	@FechaModificacion	datetime ,
	@ACCION	varchar(25) 
			
)

AS
BEGIN 
SET NOCOUNT ON;
BEGIN  TRANSACTION

	DECLARE @CONTADOR INT
	
	if(@ACCION = 'INSERT')
	begin		 
		
		select @CONTADOR= isnull(MAX(IdGrupo),0)+1 from SG_Grupo 
		
		set @IdGrupo= @CONTADOR
		insert into SG_Grupo
		(
			IdGrupo
			,IdGrupoPadre
			,CodigoGrupo
			,CadenaRecursividad
			,NivelGrupo
			,Nombre
			,Descripcion
			,Estado
			,UsuarioCreacion
			,FechaCreacion
			,UsuarioModificacion
			,FechaModificacion
			,ACCION

		)
		values(
			@IdGrupo
		,	@IdGrupoPadre
		,	@CodigoGrupo
		,	@CadenaRecursividad
		,	@NivelGrupo
		,	@Nombre
		,	@Descripcion
		,	@Estado
		,	@UsuarioCreacion
		,	GETDATE()
		,	@UsuarioModificacion
		,	GETDATE()
		,	@ACCION
	
		)
		select @IdGrupo
	end	
	else
	if(@ACCION = 'UPDATE')
	begin			
		update SG_Grupo
		set 				
		IdGrupoPadre	=	@IdGrupoPadre
		,CodigoGrupo	=	@CodigoGrupo
		,CadenaRecursividad	=	@CadenaRecursividad
		,NivelGrupo	=	@NivelGrupo
		,Nombre	=	@Nombre
		,Descripcion	=	@Descripcion
		,Estado	=	@Estado
		,UsuarioModificacion	=	@UsuarioModificacion
		,FechaModificacion	=	getdate()
		,ACCION	=	@ACCION

		
		WHERE 
		(IdGrupo = @IdGrupo)		
		select @IdGrupo
	end	
	else
	if(@ACCION = 'DELETE')
	begin
		delete SG_Grupo
		WHERE 
		(IdGrupo = @IdGrupo)
		select @IdGrupo
	end
	else
	if(@ACCION = 'LISTARPAG')
	begin	 	
		SET @CONTADOR=(SELECT COUNT(IdGrupo) FROM SG_Grupo
	 					WHERE 
					(@IdGrupo is null OR (IdGrupo = @IdGrupo) or @IdGrupo =0)
					and (@IdGrupoPadre is null OR IdGrupoPadre = @IdGrupoPadre)					
					and (@ESTADO is null OR Estado = @ESTADO)
					and (@CodigoGrupo is null OR CodigoGrupo = @CodigoGrupo)
					and (@NOMBRE is null  OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')
					)
		select @CONTADOR
	end
commit	
	
END	
/*
exec [SP_SS_HC_SG_Grupo]

	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,	
	
	NULL,
	NULL,
	'LISTARPAG'
	
)*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_SG_Grupo_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_SG_Grupo_LISTAR]
(
	@IdGrupo	int,
	@IdGrupoPadre	int ,
	@CodigoGrupo	varchar(15) ,
	@CadenaRecursividad	varchar(150) ,
	@NivelGrupo	int ,
	
	@Nombre	varchar(80) ,
	@Descripcion	varchar(150) ,
	@Estado	int ,
	@UsuarioCreacion	varchar(25) ,
	@FechaCreacion	datetime ,
	
	@UsuarioModificacion	varchar(25) ,
	@FechaModificacion	datetime ,
	
	@INICIO   int= null,  
	@NUMEROFILAS int = null ,	
	@ACCION	varchar(25) 
			
)

AS
BEGIN
	if(@ACCION = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR=(SELECT COUNT(IdGrupo) FROM SG_Grupo
	 					WHERE 
					(@IdGrupo is null OR (IdGrupo = @IdGrupo) or @IdGrupo =0)
					and (@IdGrupoPadre is null OR IdGrupoPadre = @IdGrupoPadre)					
					and (@ESTADO is null OR Estado = @ESTADO)
					and (@CodigoGrupo is null OR CodigoGrupo = @CodigoGrupo)
					and (@NOMBRE is null  OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')
					)
	 
		SELECT 
					IdGrupo
					,IdGrupoPadre
					,CodigoGrupo
					,CadenaRecursividad
					,NivelGrupo
					,Nombre
					,Descripcion
					,Estado
					,UsuarioCreacion
					,FechaCreacion
					,UsuarioModificacion
					,FechaModificacion
					,ACCION						
		FROM (
				SELECT 
					SG_Grupo.*
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY IdGrupo ASC ) AS RowNumber   					
				from 
				SG_Grupo
	 					WHERE 
					(@IdGrupo is null OR (IdGrupo = @IdGrupo) or @IdGrupo =0)
					and (@IdGrupoPadre is null OR IdGrupoPadre = @IdGrupoPadre)					
					and (@ESTADO is null OR Estado = @ESTADO)
					and (@CodigoGrupo is null OR CodigoGrupo = @CodigoGrupo)
					and (@NOMBRE is null  OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')
		
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
	end
	else
	if(@ACCION = 'LISTAR')
	begin
	 
				SELECT 
					IdGrupo
					,IdGrupoPadre
					,CodigoGrupo
					,CadenaRecursividad
					,NivelGrupo
					,Nombre
					,Descripcion
					,Estado
					,UsuarioCreacion
					,FechaCreacion
					,UsuarioModificacion
					,FechaModificacion
					,ACCION				
				from 
				SG_Grupo
	 					WHERE 
					(@IdGrupo is null OR (IdGrupo = @IdGrupo) or @IdGrupo =0)
					and (@IdGrupoPadre is null OR IdGrupoPadre = @IdGrupoPadre)					
					and (@ESTADO is null OR Estado = @ESTADO)
					and (@CodigoGrupo is null OR CodigoGrupo = @CodigoGrupo)
					and (@NOMBRE is null  OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')
					

	end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 
					IdGrupo
					,IdGrupoPadre
					,CodigoGrupo
					,CadenaRecursividad
					,NivelGrupo
					,Nombre
					,Descripcion
					,Estado
					,UsuarioCreacion
					,FechaCreacion
					,UsuarioModificacion
					,FechaModificacion
					,ACCION					
				from 
				SG_Grupo
				where
					(IdGrupo = @IdGrupo)
					
	end	
	

END
/*
exec [SP_SS_HC_SG_Grupo_LISTAR]

	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,	
	
	NULL,
	NULL,
	0,
	20,
	'LISTARPAG'
			
)*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_SG_MaestroCobertura]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_SG_MaestroCobertura] 
  @IdCobertura           INT =null, 
  @CodigoCobertura       VARCHAR(15) = null, 
  @Nombre                VARCHAR(200) = null, 
  @Descripcion           VARCHAR(200) = null, 
  @IndicadorAmbulatorio  INT = null,   
  @IndicadorEmergencia   INT = null, 
  @IndicadorHospitalario INT = null, 
  @Estado                INT = null, 
  @UsuarioCreacion       VARCHAR(25)= null, 
  @FechaCreacion         DATETIME= null,   
  @UsuarioModificacion   VARCHAR(25)= null, 
  @FechaModificacion     DATETIME= null, 
  @Coderam               VARCHAR(1)= null, 
  @TipoTabla             INT= null, 
  @ACCION                VARCHAR( 25) = null,   
  @VERSION               VARCHAR( 25) = null 
AS 
  BEGIN 
    SET nocount ON; 
    IF @Accion = 'INSERT' 
    BEGIN 		
    
      SELECT @IdCobertura = Isnull(Max(idcobertura),0)+1 
      FROM   dbo.ss_sg_maestrocobertura 

      
      if(@IndicadorAmbulatorio is null)
      set @IndicadorAmbulatorio = 1
      if(@IndicadorEmergencia is null)
      set @IndicadorEmergencia = 1
      if(@IndicadorHospitalario is null)
      set @IndicadorHospitalario = 1
      INSERT INTO ss_sg_maestrocobertura 
                  ( 
                              idcobertura, 
                              codigocobertura, 
                              nombre, 
                              descripcion, 
                              indicadorambulatorio, 
                              indicadoremergencia, 
                              indicadorhospitalario, 
                              estado, 
                              usuariocreacion, 
                              fechacreacion, 
                              usuariomodificacion, 
                              fechamodificacion, 
                              coderam, 
                              tipotabla, accion ,version 
                  ) 
                  VALUES 
                  ( 
                              @IdCobertura, 
                              @CodigoCobertura, 
                              @Nombre, 
                              @Descripcion, 
                              @IndicadorAmbulatorio, 
                              @IndicadorEmergencia, 
                              @IndicadorHospitalario, 
                              @Estado, 
                              @UsuarioCreacion, 
                              getdate(), 
                              @UsuarioModificacion, 
                              getdate(), 
                              @Coderam, 
                              @TipoTabla, @ACCION ,@VERSION 
                  ) 
      SELECT  @IdCobertura
    END 
    ELSE 
    IF @Accion = 'UPDATE' 
    BEGIN 
    if(@IndicadorAmbulatorio is null)
      set @IndicadorAmbulatorio = 1
      if(@IndicadorEmergencia is null)
      set @IndicadorEmergencia = 1
      if(@IndicadorHospitalario is null)
      set @IndicadorHospitalario = 1
      UPDATE ss_sg_maestrocobertura 
      SET    idcobertura=@IdCobertura, 
             codigocobertura=@CodigoCobertura, 
             nombre=@Nombre, 
             descripcion=@Descripcion, 
             indicadorambulatorio=@IndicadorAmbulatorio, 
             indicadoremergencia=@IndicadorEmergencia, 
             indicadorhospitalario=@IndicadorHospitalario, 
             estado=@Estado, 
             usuariomodificacion=@UsuarioModificacion, 
             fechamodificacion=Getdate(), 
             coderam=@Coderam, 
             tipotabla=@TipoTabla, 
             accion=@ACCION, 
             version=@VERSION 
      WHERE  ( ss_sg_maestrocobertura.idcobertura = @IdCobertura) 
      SELECT 1 
    END 
    ELSE 
    IF @Accion = 'DELETE' 
    BEGIN 
      DELETE 
      FROM   ss_sg_maestrocobertura 
      WHERE  ( ss_sg_maestrocobertura.idcobertura = @IdCobertura ) 
      SELECT 1 
    END 
    ELSE 
    IF( @ACCION = 'LISTARPAG' ) 
    BEGIN 
      DECLARE @CONTADOR INT 
      if (@IndicadorEmergencia = 0)
      set @IndicadorEmergencia = null
      if (@IndicadorHospitalario = 0)
      set @IndicadorHospitalario = null
      if (@IndicadorAmbulatorio = 0)
      set @IndicadorAmbulatorio = null
      print @IndicadorEmergencia
      print @IndicadorHospitalario
      print @IndicadorAmbulatorio
      SET @CONTADOR = 
      ( 
             SELECT Count(*) 
             FROM   ss_sg_maestrocobertura 
             WHERE 
				 ( @Descripcion IS NULL OR Upper(ss_sg_maestrocobertura.descripcion) LIKE '%' + Upper(@Descripcion) + '%' )
             AND ( ss_sg_maestrocobertura.idcobertura = @IdCobertura OR @IdCobertura IS NULL OR @IdCobertura =0) 
             AND ( @Nombre IS NULL OR Upper(ss_sg_maestrocobertura.Nombre) LIKE '%' + Upper(@Nombre) + '%' ) 							  
			 AND ( @TipoTabla IS NULL OR SS_SG_MaestroCobertura.TipoTabla = @TipoTabla OR @TipoTabla = 0)
			 AND ( @Estado IS NULL OR SS_SG_MaestroCobertura.Estado = @Estado OR @Estado=0)
			 AND ( @IndicadorEmergencia IS NULL OR SS_SG_MaestroCobertura.IndicadorEmergencia = @IndicadorEmergencia )
			 AND ( @IndicadorHospitalario IS NULL OR SS_SG_MaestroCobertura.IndicadorHospitalario = @IndicadorHospitalario )
			 AND ( @IndicadorAmbulatorio IS NULL OR SS_SG_MaestroCobertura.IndicadorAmbulatorio = @IndicadorAmbulatorio )) 
      SELECT @CONTADOR;      
    END 
  END 

  /* 
EXEC SP_SS_HC_SG_MaestroCobertura 
0,NULL, NULL, NULL, 0, 
1, 0, 0, NULL, NULL, 
NULL, NULL, NULL, 0, 
'LISTARPAG', NULL 
*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_SG_MaestroCoberturaListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_SG_MaestroCoberturaListar] 
@IdCobertura           INT, 
@CodigoCobertura       VARCHAR(15 ), 
@Nombre                VARCHAR( 200), 
@Descripcion           VARCHAR( 200), 
@IndicadorAmbulatorio  INT, 

@IndicadorEmergencia   INT, 
@IndicadorHospitalario INT, 
@Estado                INT, 
@UsuarioCreacion       VARCHAR(25 ), 
@FechaCreacion         DATETIME, 

@UsuarioModificacion   VARCHAR(25 ), 
@FechaModificacion     DATETIME, 
@Coderam               VARCHAR(1) , 
@TipoTabla             INT, 
@ACCION                VARCHAR( 25), 

@VERSION               VARCHAR( 25), 
@INICIO                INT, 
@NUMEROFILAS           INT 
AS 
  BEGIN 
      SET nocount ON; 

      DECLARE @CONTADOR INT 

      IF @Accion = 'LISTAR' 
        BEGIN 
            SELECT ss_sg_maestrocobertura.idcobertura, 
                   ss_sg_maestrocobertura.codigocobertura, 
                   ss_sg_maestrocobertura.nombre, 
                   ss_sg_maestrocobertura.descripcion, 
                   ss_sg_maestrocobertura.indicadorambulatorio, 
                   ss_sg_maestrocobertura.indicadoremergencia, 
                   ss_sg_maestrocobertura.indicadorhospitalario, 
                   ss_sg_maestrocobertura.estado, 
                   ss_sg_maestrocobertura.usuariocreacion, 
                   ss_sg_maestrocobertura.fechacreacion, 
                   ss_sg_maestrocobertura.usuariomodificacion, 
                   ss_sg_maestrocobertura.fechamodificacion, 
                   ss_sg_maestrocobertura.coderam, 
                   ss_sg_maestrocobertura.tipotabla, 
                   ss_sg_maestrocobertura.accion, 
                   ss_sg_maestrocobertura.version 
            FROM   ss_sg_maestrocobertura 
            WHERE  
              ( @Descripcion IS NULL OR Upper(ss_sg_maestrocobertura.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
              AND ( ( ss_sg_maestrocobertura.idcobertura = @IdCobertura ) OR @IdCobertura IS NULL OR @IdCobertura = 0 ) 
              AND ( @CodigoCobertura IS NULL OR Upper(ss_sg_maestrocobertura.CodigoCobertura) LIKE '%' + Upper(@CodigoCobertura) + '%' ) 
              AND ( @Nombre IS NULL OR Upper(ss_sg_maestrocobertura.Nombre) LIKE '%' + Upper(@Nombre) + '%' ) 
			  AND ( @TipoTabla IS NULL OR SS_SG_MaestroCobertura.TipoTabla = @TipoTabla OR @TipoTabla = 0)
			  AND ( @Estado IS NULL OR SS_SG_MaestroCobertura.Estado = @Estado OR @Estado=0)
			  AND ( @IndicadorEmergencia IS NULL OR SS_SG_MaestroCobertura.IndicadorEmergencia = @IndicadorEmergencia OR @IndicadorEmergencia = 0)
			  AND ( @IndicadorHospitalario IS NULL OR SS_SG_MaestroCobertura.IndicadorHospitalario = @IndicadorHospitalario OR @IndicadorHospitalario = 0)
			  AND ( @IndicadorAmbulatorio IS NULL OR SS_SG_MaestroCobertura.IndicadorAmbulatorio = @IndicadorAmbulatorio OR @IndicadorAmbulatorio =0)
				  
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            SET @CONTADOR = (SELECT Count(*) 
                             FROM   ss_sg_maestrocobertura 
                             WHERE  
                              ( @Descripcion IS NULL OR Upper(ss_sg_maestrocobertura.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                              AND ( ( ss_sg_maestrocobertura.idcobertura = @IdCobertura ) OR @IdCobertura IS NULL OR @IdCobertura = 0 )
                              AND ( @CodigoCobertura IS NULL OR Upper(ss_sg_maestrocobertura.CodigoCobertura) LIKE '%' + Upper(@CodigoCobertura) + '%' ) 
							  AND ( @Nombre IS NULL OR Upper(ss_sg_maestrocobertura.Nombre) LIKE '%' + Upper(@Nombre) + '%' ) 							  
							  AND ( @TipoTabla IS NULL OR SS_SG_MaestroCobertura.TipoTabla = @TipoTabla OR @TipoTabla = 0)
							  AND ( @Estado IS NULL OR SS_SG_MaestroCobertura.Estado = @Estado OR @Estado=0)
							  AND ( @IndicadorEmergencia IS NULL OR SS_SG_MaestroCobertura.IndicadorEmergencia = @IndicadorEmergencia OR @IndicadorEmergencia = 0)
							  AND ( @IndicadorHospitalario IS NULL OR SS_SG_MaestroCobertura.IndicadorHospitalario = @IndicadorHospitalario OR @IndicadorHospitalario = 0)
							  AND ( @IndicadorAmbulatorio IS NULL OR SS_SG_MaestroCobertura.IndicadorAmbulatorio = @IndicadorAmbulatorio OR @IndicadorAmbulatorio =0)
				  )

            SELECT idcobertura, 
                   codigocobertura, 
                   nombre, 
                   descripcion, 
                   indicadorambulatorio, 
                   indicadoremergencia, 
                   indicadorhospitalario, 
                   estado, 
                   usuariocreacion, 
                   fechacreacion, 
                   usuariomodificacion, 
                   fechamodificacion, 
                   coderam, 
                   tipotabla, 
                   accion, 
                   version 
            FROM   (SELECT ss_sg_maestrocobertura.idcobertura, 
                           ss_sg_maestrocobertura.codigocobertura, 
                           ss_sg_maestrocobertura.nombre, 
                           ss_sg_maestrocobertura.descripcion, 
                           ss_sg_maestrocobertura.indicadorambulatorio, 
                           ss_sg_maestrocobertura.indicadoremergencia, 
                           ss_sg_maestrocobertura.indicadorhospitalario, 
                           ss_sg_maestrocobertura.estado, 
                           ss_sg_maestrocobertura.usuariocreacion, 
                           ss_sg_maestrocobertura.fechacreacion, 
                           ss_sg_maestrocobertura.usuariomodificacion, 
                           ss_sg_maestrocobertura.fechamodificacion, 
                           ss_sg_maestrocobertura.coderam, 
                           ss_sg_maestrocobertura.tipotabla, 
                           ss_sg_maestrocobertura.accion, 
                           ss_sg_maestrocobertura.version, 
                           @CONTADOR AS Contador, 
                           Row_number() OVER ( ORDER BY ss_sg_maestrocobertura.idcobertura ASC ) AS RowNumber 
                    FROM   ss_sg_maestrocobertura 
                    WHERE  
                     ( @Descripcion IS NULL OR Upper(ss_sg_maestrocobertura.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                     AND ( ( ss_sg_maestrocobertura.idcobertura = @IdCobertura ) OR @IdCobertura IS NULL OR @IdCobertura = 0 )
                     AND ( @CodigoCobertura IS NULL OR Upper(ss_sg_maestrocobertura.CodigoCobertura) LIKE '%' + Upper(@CodigoCobertura) + '%' ) 
					 AND ( @Nombre IS NULL OR Upper(ss_sg_maestrocobertura.Nombre) LIKE '%' + Upper(@Nombre) + '%' ) 
					 AND ( @TipoTabla IS NULL OR SS_SG_MaestroCobertura.TipoTabla = @TipoTabla OR @TipoTabla = 0)
					 AND ( @Estado IS NULL OR SS_SG_MaestroCobertura.Estado = @Estado OR @Estado=0)
					 AND ( @IndicadorEmergencia IS NULL OR SS_SG_MaestroCobertura.IndicadorEmergencia = @IndicadorEmergencia OR @IndicadorEmergencia = 0)
					 AND ( @IndicadorHospitalario IS NULL OR SS_SG_MaestroCobertura.IndicadorHospitalario = @IndicadorHospitalario OR @IndicadorHospitalario = 0)
					 AND ( @IndicadorAmbulatorio IS NULL OR SS_SG_MaestroCobertura.IndicadorAmbulatorio = @IndicadorAmbulatorio OR @IndicadorAmbulatorio =0)
				  ) AS LISTADO 
            WHERE  ( @Inicio IS NULL AND @NumeroFilas IS NULL ) OR rownumber BETWEEN @Inicio AND @NumeroFilas 
        END 
      ELSE IF( @ACCION = 'LISTARPORID' ) 
        BEGIN 
            SET @CONTADOR = (SELECT Count(*) 
                             FROM   ss_sg_maestrocobertura 
                             WHERE  
                              ( @Descripcion IS NULL OR Upper(ss_sg_maestrocobertura.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                              AND ( ( ss_sg_maestrocobertura.idcobertura = @IdCobertura ) OR @IdCobertura IS NULL OR @IdCobertura = 0 )
                              AND ( @CodigoCobertura IS NULL OR Upper(ss_sg_maestrocobertura.CodigoCobertura) LIKE '%' + Upper(@CodigoCobertura) + '%' ) 
							  AND ( @Nombre IS NULL OR Upper(ss_sg_maestrocobertura.Nombre) LIKE '%' + Upper(@Nombre) + '%' ) 
				  AND ( @TipoTabla IS NULL OR SS_SG_MaestroCobertura.TipoTabla = @TipoTabla OR @TipoTabla = 0)
				  AND ( @Estado IS NULL OR SS_SG_MaestroCobertura.Estado = @Estado OR @Estado=0)
				  AND ( @IndicadorEmergencia IS NULL OR SS_SG_MaestroCobertura.IndicadorEmergencia = @IndicadorEmergencia OR @IndicadorEmergencia = 0)
				  AND ( @IndicadorHospitalario IS NULL OR SS_SG_MaestroCobertura.IndicadorHospitalario = @IndicadorHospitalario OR @IndicadorHospitalario = 0)
				  AND ( @IndicadorAmbulatorio IS NULL OR SS_SG_MaestroCobertura.IndicadorAmbulatorio = @IndicadorAmbulatorio OR @IndicadorAmbulatorio =0))
				  
            SELECT @CONTADOR; 
        END 
  END 
  
/*  
EXEC SP_SS_HC_SG_MaestroCoberturaListar  
0,NULL,NULL,NULL,NULL, 
NULL,NULL,NULL,NULL,NULL, 
NULL,NULL,NULL,NULL,'LISTARPAG', 
NULL,0,15 
*/ 
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_SG_MaestroCoberturaListarnuevo]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_SG_MaestroCoberturaListarnuevo] 
@IdCobertura           INT, 
@CodigoCobertura       VARCHAR(15 ), 
@Nombre                VARCHAR( 200), 
@Descripcion           VARCHAR( 200), 
@IndicadorAmbulatorio  INT, 

@IndicadorEmergencia   INT, 
@IndicadorHospitalario INT, 
@Estado                INT, 
@UsuarioCreacion       VARCHAR(25 ), 
@FechaCreacion         DATETIME, 

@UsuarioModificacion   VARCHAR(25 ), 
@FechaModificacion     DATETIME, 
@Coderam               VARCHAR(1) , 
@TipoTabla             INT, 
@ACCION                VARCHAR( 25), 

@VERSION               VARCHAR( 25), 
@INICIO                INT, 
@NUMEROFILAS           INT 
AS 
  BEGIN 
		IF( @ACCION = 'LISTARPAG' ) 
		begin
		SELECT ss_sg_maestrocobertura.idcobertura, 
                   ss_sg_maestrocobertura.codigocobertura, 
                   ss_sg_maestrocobertura.nombre, 
                   ss_sg_maestrocobertura.descripcion, 
                   ss_sg_maestrocobertura.indicadorambulatorio, 
                   ss_sg_maestrocobertura.indicadoremergencia, 
                   ss_sg_maestrocobertura.indicadorhospitalario, 
                   ss_sg_maestrocobertura.estado, 
                   ss_sg_maestrocobertura.usuariocreacion, 
                   ss_sg_maestrocobertura.fechacreacion, 
                   ss_sg_maestrocobertura.usuariomodificacion, 
                   ss_sg_maestrocobertura.fechamodificacion, 
                   ss_sg_maestrocobertura.coderam, 
                   ss_sg_maestrocobertura.tipotabla, 
                   ss_sg_maestrocobertura.accion, 
                   ss_sg_maestrocobertura.version 
            FROM   ss_sg_maestrocobertura 
		end
		else
		begin
			SELECT top (1)ss_sg_maestrocobertura.idcobertura, 
                   ss_sg_maestrocobertura.codigocobertura, 
                   ss_sg_maestrocobertura.nombre, 
                   ss_sg_maestrocobertura.descripcion, 
                   ss_sg_maestrocobertura.indicadorambulatorio, 
                   ss_sg_maestrocobertura.indicadoremergencia, 
                   ss_sg_maestrocobertura.indicadorhospitalario, 
                   ss_sg_maestrocobertura.estado, 
                   ss_sg_maestrocobertura.usuariocreacion, 
                   ss_sg_maestrocobertura.fechacreacion, 
                   ss_sg_maestrocobertura.usuariomodificacion, 
                   ss_sg_maestrocobertura.fechamodificacion, 
                   ss_sg_maestrocobertura.coderam, 
                   ss_sg_maestrocobertura.tipotabla, 
                   ss_sg_maestrocobertura.accion, 
                   ss_sg_maestrocobertura.version 
            FROM   ss_sg_maestrocobertura 
		end
            
            
  END 
  
/*  
EXEC SP_SS_HC_SG_MaestroCoberturaListar  
0,NULL,NULL,NULL,NULL, 
NULL,NULL,NULL,NULL,NULL, 
NULL,NULL,NULL,NULL,'LISTARPAG', 
NULL,0,15 
*/ 
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_SG_Opcion]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_SG_Opcion]
(
	@IdOpcion	int ,
	@IdOpcionPadre	int ,
	@CodigoOpcion	varchar(15) ,
	@CadenaRecursividad	varchar(150) ,
	@NivelOpcion	int ,	
	@Nombre	varchar(80) ,
	@Descripcion	varchar(80) ,
	@Sistema	varchar(4) ,
	@Modulo	varchar(2) ,
	@SubModulo	varchar(2) ,	
	@Orden	int ,
	@TipoOpcion	varchar(1) ,
	@TipoIcono	int ,
	@IndicadorPrioridad	int ,
	@IndicadorObjeto	int ,	
	@IdObjetoAsociado	int ,
	@TipoDato	varchar(1) ,
	@ValorTexto	varchar(150) ,
	@ValorNumerico	decimal(20, 10) ,
	@ValorFecha	datetime ,	
	@UrlOpcion	varchar(150) ,
	@UsuarioCreacion	varchar(25) ,
	@FechaCreacion	datetime ,
	@UsuarioModificacion	varchar(25) ,
	@FechaModificacion	datetime ,	
	@Compania	varchar(15) ,
	@IndicadorCompania	int ,
	@idTipoAtencion	int ,
	@TipoTrabajador	char(2) ,
	@IndicadorFormato	int ,	
	@IdFormato	int ,
	@IndicadorAsignacion	int ,
	@TipoProceso	int ,	
	@Version	varchar(50) ,
	@Estado	int ,		
	@ACCION	varchar(25) 
			
)

AS
BEGIN 
SET NOCOUNT ON;
BEGIN  TRANSACTION

	DECLARE @CONTADOR INT
	declare @IdAgenteAux int;
	if(@ACCION = 'INSERT')
	begin		 

		select @CONTADOR= isnull(MAX(IdOpcion),0)+1 from SG_Opcion 
		
		set @IdOpcion= @CONTADOR
		
		if(@CodigoOpcion is null or @CodigoOpcion = '' or  @CodigoOpcion='0')
			set @CodigoOpcion = convert(varchar,@IdOpcion)
					
		insert into SG_Opcion
		(
			IdOpcion
			,IdOpcionPadre
			,CodigoOpcion
			,CadenaRecursividad
			,NivelOpcion
			,Nombre
			,Descripcion
			,Sistema
			,Modulo
			,SubModulo
			,Orden
			,TipoOpcion
			,TipoIcono
			,IndicadorPrioridad
			,IndicadorObjeto
			,IdObjetoAsociado
			,TipoDato
			,ValorTexto
			,ValorNumerico
			,ValorFecha
			,UrlOpcion
			,UsuarioCreacion
			,FechaCreacion
			,UsuarioModificacion
			,FechaModificacion
			,Compania
			,IndicadorCompania
			,idTipoAtencion
			,TipoTrabajador
			,IndicadorFormato
			,IdFormato
			,IndicadorAsignacion
			,TipoProceso
			,Accion
			,Version
			,Estado


		)
		values(
				@IdOpcion
			,	@IdOpcionPadre
			,	@CodigoOpcion
			,	@CadenaRecursividad
			,	@NivelOpcion
			,	@Nombre
			,	@Descripcion
			,	@Sistema
			,	@Modulo
			,	@SubModulo
			,	@Orden
			,	@TipoOpcion
			,	@TipoIcono
			,	@IndicadorPrioridad
			,	@IndicadorObjeto
			,	@IdObjetoAsociado
			,	@TipoDato
			,	@ValorTexto
			,	@ValorNumerico
			,	@ValorFecha
			,	@UrlOpcion
			,	@UsuarioCreacion
			,	GETDATE()
			,	@UsuarioModificacion
			,	GETDATE()
			,	@Compania
			,	@IndicadorCompania
			,	@idTipoAtencion
			,	@TipoTrabajador
			,	@IndicadorFormato
			,	@IdFormato
			,	@IndicadorAsignacion
			,	@TipoProceso
			,	@Accion
			,	@Version
			,	@Estado
	
		)
		/**ADD OPERFIL GENERAL*/
		 --OBS: HARCCODE Codigo AGENTE ROYAL		 
		 set @IdAgenteAux = -2   --OBS -2= ID ADMINSYS
		delete SG_AgenteOpcion where IdAgente =@IdAgenteAux and IdOpcion = @IdOpcion
		insert into SG_AgenteOpcion (idAgente,IdOpcion,Estado )
		values (@IdAgenteAux,@IdOpcion,2) 		
		--select * from SG_AgenteOpcion
		select @IdOpcion
	end	
	else
	if(@ACCION = 'UPDATE')
	begin			
		update SG_Opcion
		set 				
		
		IdOpcionPadre	=	@IdOpcionPadre
		,CodigoOpcion	=	@CodigoOpcion
		,CadenaRecursividad	=	@CadenaRecursividad
		,NivelOpcion	=	@NivelOpcion
		,Nombre	=	@Nombre
		,Descripcion	=	@Descripcion
		,Sistema	=	@Sistema
		,Modulo	=	@Modulo
		,SubModulo	=	@SubModulo
		,Orden	=	@Orden
		,TipoOpcion	=	@TipoOpcion
		,TipoIcono	=	@TipoIcono
		,IndicadorPrioridad	=	@IndicadorPrioridad
		,IndicadorObjeto	=	@IndicadorObjeto
		,IdObjetoAsociado	=	@IdObjetoAsociado
		,TipoDato	=	@TipoDato
		,ValorTexto	=	@ValorTexto
		,ValorNumerico	=	@ValorNumerico
		,ValorFecha	=	@ValorFecha
		,UrlOpcion	=	@UrlOpcion
		,UsuarioModificacion	=	@UsuarioModificacion
		,FechaModificacion	=	GETDATE()
		,Compania	=	@Compania
		,IndicadorCompania	=	@IndicadorCompania
		,idTipoAtencion	=	@idTipoAtencion
		,TipoTrabajador	=	@TipoTrabajador
		,IndicadorFormato	=	@IndicadorFormato
		,IdFormato	=	@IdFormato
		,IndicadorAsignacion	=	@IndicadorAsignacion
		,TipoProceso	=	@TipoProceso
		,Accion	=	@Accion
		,Version	=	@Version
		,Estado	=	@Estado
		
		WHERE 
		(IdOpcion= @IdOpcion)		
		
		
		/**ADD OPERFIL GENERAL*/
		 --OBS: HARCCODE Codigo AGENTE ROYAL		 
		 set @IdAgenteAux = -2   --OBS -2= ID ADMINSYS
		 select @CONTADOR = COUNT(*)
		 from SG_AgenteOpcion where IdAgente =@IdAgenteAux and IdOpcion = @IdOpcion		
		if(@CONTADOR=0)		
			insert into SG_AgenteOpcion (idAgente,IdOpcion,Estado )
			values (@IdAgenteAux,@IdOpcion,2) 		
			--select * from SG_AgenteOpcion
		
		select @IdOpcion
				
	end	
	else
	if(@ACCION = 'DELETE')
	begin
		delete SG_AgenteOpcion
		WHERE 
		(IdOpcion = @IdOpcion)
		
			
		delete SG_Opcion
		WHERE 
		(IdOpcion = @IdOpcion)
		select @IdOpcion
	end
	else
	if(@ACCION = 'LISTARPAG')
	begin	 	
		SET @CONTADOR=(SELECT COUNT(IdOpcion) FROM SG_Opcion
	 					WHERE 
					(@IdOpcion is null OR (IdOpcion = @IdOpcion) or @IdOpcion =0)
					and (@IdOpcionPadre is null OR IdOpcionPadre = @IdOpcionPadre)					
					and (@ESTADO is null OR Estado = @ESTADO)
					and (@CodigoOpcion is null OR CodigoOpcion = @CodigoOpcion)
					and (@NivelOpcion is null OR NivelOpcion = @NivelOpcion)					
					and (@NOMBRE is null  OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')
					)
		select @CONTADOR
	end
commit	
	
END	
/*
exec [SP_SS_HC_SG_Opcion]

	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,

	NULL,
	NULL,
	NULL,
	NULL,
	NULL,

	NULL,
	NULL,
	NULL,
	NULL,
	NULL,

	NULL,
	NULL,
	NULL,
	NULL,
	NULL,

	NULL,
	NULL,
	NULL,
	NULL,
	NULL,

	NULL,
	NULL,
	NULL,
	NULL,
	NULL,

	'LISTARPAG'
	
*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_SG_Opcion_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_SG_Opcion_LISTAR]
(
	@IdOpcion	int ,
	@IdOpcionPadre	int ,
	@CodigoOpcion	varchar(15) ,
	@CadenaRecursividad	varchar(150) ,
	@NivelOpcion	int ,	
	@Nombre	varchar(80) ,
	@Descripcion	varchar(80) ,
	@Sistema	varchar(4) ,
	@Modulo	varchar(2) ,
	@SubModulo	varchar(2) ,	
	@Orden	int ,
	@TipoOpcion	varchar(1) ,
	@TipoIcono	int ,
	@IndicadorPrioridad	int ,
	@IndicadorObjeto	int ,	
	@IdObjetoAsociado	int ,
	@TipoDato	varchar(1) ,
	@ValorTexto	varchar(150) ,
	@ValorNumerico	decimal(20, 10) ,
	@ValorFecha	datetime ,	
	@UrlOpcion	varchar(150) ,
	@UsuarioCreacion	varchar(25) ,
	@FechaCreacion	datetime ,
	@UsuarioModificacion	varchar(25) ,
	@FechaModificacion	datetime ,	
	@Compania	varchar(15) ,
	@IndicadorCompania	int ,
	@idTipoAtencion	int ,
	@TipoTrabajador	char(2) ,
	@IndicadorFormato	int ,	
	@IdFormato	int ,
	@IndicadorAsignacion	int ,
	@TipoProceso	int ,	
	@Version	varchar(50) ,
	@Estado	int ,		
	@Inicio	int ,	
	@NumeroFilas	int ,	
	@ACCION	varchar(25) 
			
)

AS
BEGIN
	if(@ACCION = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR=(SELECT COUNT(IdOpcion) FROM SG_Opcion
	 					WHERE 
					(@IdOpcion is null OR (IdOpcion = @IdOpcion) or @IdOpcion =0)
					and (@IdOpcionPadre is null OR IdOpcionPadre = @IdOpcionPadre)					
					and (@ESTADO is null OR Estado = @ESTADO)
					and (@CodigoOpcion is null OR CodigoOpcion = @CodigoOpcion)
					and (@NivelOpcion is null OR NivelOpcion = @NivelOpcion)					
					and (@NOMBRE is null  OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')
					)
	 
		SELECT 
				IdOpcion
				,IdOpcionPadre
				,CodigoOpcion
				,CadenaRecursividad
				,NivelOpcion
				,Nombre
				,Descripcion
				,Sistema
				,Modulo
				,SubModulo
				,Orden
				,TipoOpcion
				,TipoIcono
				,IndicadorPrioridad
				,IndicadorObjeto
				,IdObjetoAsociado
				,TipoDato
				,ValorTexto
				,ValorNumerico
				,ValorFecha
				,UrlOpcion
				,UsuarioCreacion
				,FechaCreacion
				,UsuarioModificacion
				,FechaModificacion
				,Compania
				,IndicadorCompania
				,idTipoAtencion
				,TipoTrabajador
				,IndicadorFormato
				,IdFormato
				,IndicadorAsignacion
				,TipoProceso
				,Accion
				,Version
				,Estado					
		FROM (
				SELECT 
					SG_Opcion.*
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY IdOpcion ASC ) AS RowNumber   					
				from 
				SG_Opcion
	 					WHERE 
					(@IdOpcion is null OR (IdOpcion = @IdOpcion) or @IdOpcion =0)
					and (@IdOpcionPadre is null OR IdOpcionPadre = @IdOpcionPadre)					
					and (@ESTADO is null OR Estado = @ESTADO)
					and (@CodigoOpcion is null OR CodigoOpcion = @CodigoOpcion)
					and (@NivelOpcion is null OR NivelOpcion = @NivelOpcion)					
					and (@NOMBRE is null  OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')
	
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
	end
	else
	if(@ACCION = 'LISTAR')
	begin
	 
				SELECT 
				IdOpcion
				,IdOpcionPadre
				,CodigoOpcion
				,CadenaRecursividad
				,NivelOpcion
				,Nombre
				,Descripcion
				,Sistema
				,Modulo
				,SubModulo
				,Orden
				,TipoOpcion
				,TipoIcono
				,IndicadorPrioridad
				,IndicadorObjeto
				,IdObjetoAsociado
				,TipoDato
				,ValorTexto
				,ValorNumerico
				,ValorFecha
				,UrlOpcion
				,UsuarioCreacion
				,FechaCreacion
				,UsuarioModificacion
				,FechaModificacion
				,Compania
				,IndicadorCompania
				,idTipoAtencion
				,TipoTrabajador
				,IndicadorFormato
				,IdFormato
				,IndicadorAsignacion
				,TipoProceso
				,Accion
				,Version
				,Estado					
				from 
				SG_Opcion
	 					WHERE 
					(@IdOpcion is null OR (IdOpcion = @IdOpcion) or @IdOpcion =0)
					and (@IdOpcionPadre is null OR IdOpcionPadre = @IdOpcionPadre)					
					and (@ESTADO is null OR Estado = @ESTADO)
					and (@CodigoOpcion is null OR CodigoOpcion = @CodigoOpcion)
					and (@NivelOpcion is null OR NivelOpcion = @NivelOpcion)					
					and (@NOMBRE is null  OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')
						

	end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 
				IdOpcion
				,IdOpcionPadre
				,CodigoOpcion
				,CadenaRecursividad
				,NivelOpcion
				,Nombre
				,Descripcion
				,Sistema
				,Modulo
				,SubModulo
				,Orden
				,TipoOpcion
				,TipoIcono
				,IndicadorPrioridad
				,IndicadorObjeto
				,IdObjetoAsociado
				,TipoDato
				,ValorTexto
				,ValorNumerico
				,ValorFecha
				,UrlOpcion
				,UsuarioCreacion
				,FechaCreacion
				,UsuarioModificacion
				,FechaModificacion
				,Compania
				,IndicadorCompania
				,idTipoAtencion
				,TipoTrabajador
				,IndicadorFormato
				,IdFormato
				,IndicadorAsignacion
				,TipoProceso
				,Accion
				,Version
				,Estado						
				from 
				SG_Opcion
				where
					(IdOpcion = @IdOpcion)
					
	end	
	else
	if(@ACCION = 'LISTARHIJOS')
	begin	 
				SELECT 
				IdOpcion
				,IdOpcionPadre
				,CodigoOpcion
				,CadenaRecursividad
				,NivelOpcion
				,Nombre
				,Descripcion
				,Sistema
				,Modulo
				,SubModulo
				,Orden
				,TipoOpcion
				,TipoIcono
				,IndicadorPrioridad
				,IndicadorObjeto
				,IdObjetoAsociado
				,TipoDato
				,ValorTexto
				,ValorNumerico
				,ValorFecha
				,UrlOpcion
				,UsuarioCreacion
				,FechaCreacion
				,UsuarioModificacion
				,FechaModificacion
				,Compania
				,IndicadorCompania
				,idTipoAtencion
				,TipoTrabajador
				,IndicadorFormato
				,IdFormato
				,IndicadorAsignacion
				,TipoProceso
				,Accion
				,Version
				,Estado						
				from 
				SG_Opcion
				where
					(IdOpcionPadre = @IdOpcion)
					
	end		


END
/*
exec [SP_SS_HC_SG_Opcion_Listar]

	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,

	NULL,
	NULL,
	NULL,
	NULL,
	NULL,

	NULL,
	NULL,
	NULL,
	NULL,
	NULL,

	NULL,
	NULL,
	NULL,
	NULL,
	NULL,

	NULL,
	NULL,
	NULL,
	NULL,
	NULL,

	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	
	0,20,	
	'LISTARPAG'
			
)*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_SG_PerfilUsuario]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_SG_PerfilUsuario]
(
	@IdPerfil	int ,
	@IdUsuario	int ,
	@Estado	int ,
	@UsuarioCreacion	varchar(25) ,
	@FechaCreacion	datetime ,
	@UsuarioModificacion	varchar(25) ,
	@FechaModificacion	datetime ,		
	@ACCION	varchar(25) 
)

AS
BEGIN 
SET NOCOUNT ON;
BEGIN  TRANSACTION

	DECLARE @CONTADOR INT
	
	if(@ACCION = 'INSERT')
	begin		 
			
			delete SG_PerfilUsuario 
		WHERE 
		(IdPerfil= @IdPerfil)		
		and (IdUsuario= @IdUsuario)	
					 		
		insert into SG_PerfilUsuario
		(
			IdPerfil
			,IdUsuario
			,Estado
			,UsuarioCreacion
			,FechaCreacion
			,UsuarioModificacion
			,FechaModificacion
			,ACCION
		)
		values(
				@IdPerfil
			,	@IdUsuario
			,	@Estado
			,	@UsuarioCreacion
			,	GETDATE()
			,	@UsuarioModificacion
			,	GETDATE()
			,	@ACCION

		)

		select 1
	end	
	else
	if(@ACCION = 'UPDATE')
	begin			
		update SG_PerfilUsuario
		set 							
			Estado	=	@Estado
			,UsuarioModificacion	=	@UsuarioModificacion
			,FechaModificacion	=	GETDATE()
			,ACCION	=	@ACCION

		WHERE 
		(IdPerfil= @IdPerfil)		
		and (IdUsuario= @IdUsuario)	
			
		select 1
	end	
	else
	if(@ACCION = 'DELETE')
	begin
		delete SG_PerfilUsuario 
		WHERE 
		(IdPerfil= @IdPerfil)		
		and (IdUsuario= @IdUsuario)	
		
		select 1
	end
	else
	if(@ACCION = 'LISTARPAG')
	begin	 	
		SET @CONTADOR=(SELECT COUNT(IdPerfil) FROM SG_PerfilUsuario
	 					WHERE 
					(@IdPerfil is null OR (IdPerfil = @IdPerfil) or @IdPerfil =0)
					and (@IdUsuario is null OR (IdUsuario = @IdUsuario) or @IdUsuario =0)
					)
		select @CONTADOR
	end
commit	
	
END	
/*
exec SP_SS_HC_SG_PerfilUsuario
(
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
		
	'LISTARPAG'
	
*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_SG_PerfilUsuario_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_SG_PerfilUsuario_LISTAR]
(
	@IdPerfil	int ,
	@IdUsuario	int ,
	@Estado	int ,
	@UsuarioCreacion	varchar(25) ,
	@FechaCreacion	datetime ,
	@UsuarioModificacion	varchar(25) ,
	@FechaModificacion	datetime ,		
	@Inicio	int,
	@NumeroFilas	int,
	@ACCION	varchar(25) 
			
)

AS
BEGIN
	if(@ACCION = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR=(SELECT COUNT(IdPerfil) FROM SG_PerfilUsuario
	 					WHERE 
					(@IdPerfil is null OR (IdPerfil = @IdPerfil) or @IdPerfil =0)
					and (@IdUsuario is null OR (IdUsuario = @IdUsuario) or @IdUsuario =0)			
					)
	 
		SELECT 
			IdPerfil
			,IdUsuario
			,Estado
			,UsuarioCreacion
			,FechaCreacion
			,UsuarioModificacion
			,FechaModificacion
			,ACCION		
			,Version				
		FROM (
				SELECT 
					SG_PerfilUsuario.*
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY IdPerfil ASC ) AS RowNumber   					
				from 
				SG_PerfilUsuario
	 					WHERE 
					(@IdPerfil is null OR (IdPerfil = @IdPerfil) or @IdPerfil =0)
					and (@IdUsuario is null OR (IdUsuario = @IdUsuario) or @IdUsuario =0)
			
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
	end
	else
	if(@ACCION = 'LISTAR')
	begin	 
				SELECT 
					IdPerfil
					,IdUsuario
					,Estado
					,UsuarioCreacion
					,FechaCreacion
					,UsuarioModificacion
					,FechaModificacion
					,ACCION		
					,Version					
				from 
				SG_PerfilUsuario
	 					WHERE 
					(@IdPerfil is null OR (IdPerfil = @IdPerfil) or @IdPerfil =0)
					and (@IdUsuario is null OR (IdUsuario = @IdUsuario) or @IdUsuario =0)					
	end	
	else
	if(@ACCION = 'LISTARPERFILES')
	begin	 
				SELECT 
					perfilAgente.IdPerfil
					,perfilAgente.IdUsuario
					,perfilAgente.Estado
					,agente.Nombre as  UsuarioCreacion --OBS: AUX
					,perfilAgente.FechaCreacion
					,perfilAgente.UsuarioModificacion
					,perfilAgente.FechaModificacion
					,perfilAgente.ACCION	
					,perfilAgente.Version
					--,agente.Estado as EstPri					
				from 
				SG_PerfilUsuario as perfilAgente
				inner join SG_Agente agente
				on(agente.IdAgente = perfilAgente.IdPerfil
					and agente.TipoAgente = 1) ---PERFILES
	 					WHERE 
						agente.Estado=2
					and (@IdPerfil is null OR (IdPerfil = @IdPerfil) or @IdPerfil =0)
					and (@IdUsuario is null OR (IdUsuario = @IdUsuario) or @IdUsuario =0)					
	end		
	else
	if(@ACCION = 'LISTARUSUARIOS')
	begin	 
				SELECT 
					perfilAgente.IdPerfil
					,perfilAgente.IdUsuario
					,perfilAgente.Estado
					,agente.Nombre as  UsuarioCreacion --OBS: AUX
					,perfilAgente.FechaCreacion
					,perfilAgente.UsuarioModificacion
					,perfilAgente.FechaModificacion
					,perfilAgente.ACCION		
					,perfilAgente.Version							
				from 
				SG_PerfilUsuario as perfilAgente
				inner join SG_Agente agente
				on(agente.IdAgente = perfilAgente.IdUsuario
					and agente.TipoAgente = 2) ---USUARIO
	 					WHERE 
					(@IdPerfil is null OR (IdPerfil = @IdPerfil) or @IdPerfil =0)
					and (@IdUsuario is null OR (IdUsuario = @IdUsuario) or @IdUsuario =0)					
	end		
	else
	if(@ACCION = 'LISTARUSUARIOSPERFIL')
	begin	 
				SELECT 
					perfilAgente.IdPerfil
					,perfilAgente.IdUsuario
					,perfilAgente.Estado
					,agente.Nombre as  UsuarioCreacion --OBS: AUX
					,perfilAgente.FechaCreacion
					,perfilAgente.UsuarioModificacion
					,perfilAgente.FechaModificacion
					,perfilAgente.ACCION		
					,DBO.UFN_Agente(perfilAgente.IdPerfil) Version							
				from 
				SG_PerfilUsuario as perfilAgente
				inner join SG_Agente agente
				on(agente.IdAgente = perfilAgente.IdUsuario
					and agente.TipoAgente = 2) ---USUARIO
	 					WHERE 					
					 (@IdUsuario is null OR (IdUsuario = @IdUsuario) or @IdUsuario =0)					
	end		

END
/*
exec [SP_SS_HC_SG_PerfilUsuario_LISTAR]
	0,
	2007,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,		
	
	0,20,	
	'LISTARPERFILES'
			
)*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_SolucionesAdministradas_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_SolucionesAdministradas_FE]
	@UnidadReplicacion char(4) ,
	@IdEpisodioAtencion bigint  ,
	@IdPaciente int  ,
	@EpisodioClinico int  ,	
	@Secuencia int  ,	
	@Tipo int ,
	@TipoSolucion int ,
	@SolucionDescripcion varchar(250) ,
	@CantidadCC decimal(9,2) ,
	@Especificacion varchar(250) ,		
	@UsuarioCreacion varchar(25) ,
	@FechaCreacion datetime ,
	@UsuarioModificacion varchar(25) ,
	@FechaModificacion datetime ,
	@Accion varchar(25) ,
	@Version varchar(25) 
AS
BEGIN
DECLARE @SECUENCIAMAX INT 
SET @SECUENCIAMAX = (SELECT (ISNULL(MAX(Secuencia),0)+1) FROM SS_HC_SolucionesAdministradas_FE WHERE
	UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico)
	
IF(@Accion = 'NUEVO')
BEGIN

	INSERT INTO SS_HC_SolucionesAdministradas_FE(UnidadReplicacion,IdEpisodioAtencion,IdPaciente,EpisodioClinico,Secuencia,Tipo,TipoSolucion,SolucionDescripcion
	,CantidadCC,Especificacion,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,Accion,Version) 
VALUES(@UnidadReplicacion,@IdEpisodioAtencion,@IdPaciente,@EpisodioClinico,@Secuencia,@Tipo,@TipoSolucion,@SolucionDescripcion,@CantidadCC,@Especificacion,@UsuarioCreacion,
@FechaCreacion,@UsuarioModificacion,@FechaModificacion,@Accion,@Version
)
SELECT @SECUENCIAMAX
END

IF(@Accion = 'UPDATE')
BEGIN

	UPDATE SS_HC_SolucionesAdministradas_FE
	SET TipoSolucion = @TipoSolucion,
	SolucionDescripcion= @SolucionDescripcion,
	CantidadCC=@CantidadCC,
	Especificacion=@Especificacion,
	Accion=@Accion,
	Version=@Version,
	
	UsuarioModificacion=@UsuarioModificacion,
	FechaModificacion=@FechaModificacion
	WHERE
	UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico AND Secuencia=@Secuencia AND Tipo =@Tipo	
	
SELECT @Secuencia
END

IF(@Accion = 'DELETE')
BEGIN

	DELETE FROM SS_HC_SolucionesAdministradas_FE
	WHERE UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico AND Secuencia=@Secuencia AND Tipo =@Tipo
	
SELECT @Secuencia
END
END


GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_SolucionesAdministradas_FE_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_SolucionesAdministradas_FE_Listar]
	@UnidadReplicacion char(4) ,
	@IdEpisodioAtencion bigint  ,
	@IdPaciente int  ,
	@EpisodioClinico int  ,	
	@Secuencia int  ,	
	@Tipo int ,
	@TipoSolucion int ,
	@SolucionDescripcion varchar(250) ,
	@CantidadCC decimal(9,2) ,
	@Especificacion varchar(250) ,
		
	@UsuarioCreacion varchar(25) ,
	@FechaCreacion datetime ,
	@UsuarioModificacion varchar(25) ,
	@FechaModificacion datetime ,
	@Accion varchar(25) ,
	@Version varchar(25) 
AS
BEGIN

IF(@Accion = 'LISTAR')
BEGIN
SELECT * FROM SS_HC_SolucionesAdministradas_FE
WHERE UnidadReplicacion=@UnidadReplicacion AND IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico AND Tipo=@Tipo
END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Sucursal]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_Sucursal]   
	@Sucursal  [varchar](4)=NULL ,
	@SucursalGrupo  [varchar](4)=NULL ,
	@DescripcionLocal  [varchar](30)=NULL ,
	@DescripcionIngles  [varchar](30)=NULL ,
	@CuentaContableDefecto  [varchar](20) ,
	@Estado  [varchar](1) =NULL,
	@UltimoUsuario  [varchar](25) =NULL,
	@UltimaFechaModif  [datetime]=NULL ,
	@UsuarioCreacion  [varchar](25) ,
	@FechaCreacion  [datetime]=NULL ,
	@DireccionComun  [varchar](80) ,
	@DireccionAdicional  [varchar](80) ,
	@Telefono1  [varchar](15) ,
	@Telefono2  [varchar](15) ,
	@Telefono3  [varchar](15) ,
	@Fax1  [varchar](15) ,
	@Fax2  [varchar](15) ,
	@Compania  [varchar](8) ,
	@CIIU  [varchar](6) ,
	@LogoSucursal  [varchar](50) ,
	@ACCION  [varchar](25) 
AS  
BEGIN   
SET NOCOUNT ON;  
BEGIN  TRANSACTION  
  
 DECLARE @CONTADOR INT  
 IF(@Accion = 'INSERT')  
 BEGIN   
		
  INSERT INTO AC_Sucursal  
  ( Sucursal
      ,SucursalGrupo
      ,DescripcionLocal
      ,DescripcionIngles
      ,CuentaContableDefecto
      ,Estado
      ,UltimoUsuario
      ,UltimaFechaModif
      ,UsuarioCreacion
      ,FechaCreacion
      ,DireccionComun
      ,DireccionAdicional
      ,Telefono1
      ,Telefono2
      ,Telefono3
      ,Fax1
      ,Fax2
      ,Compania
      ,CIIU
      ,LogoSucursal
      ,ACCION
  )  
    VALUES  
  (   
	   @Sucursal
      ,@SucursalGrupo
      ,@DescripcionLocal
      ,@DescripcionIngles
      ,@CuentaContableDefecto
      ,@Estado
      ,@UltimoUsuario
      ,@UltimaFechaModif
      ,@UsuarioCreacion
      ,@FechaCreacion
      ,@DireccionComun
      ,@DireccionAdicional
      ,@Telefono1
      ,@Telefono2
      ,@Telefono3
      ,@Fax1
      ,@Fax2
      ,@Compania
      ,@CIIU
      ,@LogoSucursal
      ,@ACCION
  )    
 SELECT 1		 
 END   
 ELSE  
 IF(@Accion = 'UPDATE')  
 BEGIN  
 UPDATE AC_Sucursal  
  SET 
       SucursalGrupo =@SucursalGrupo
      ,DescripcionLocal=@DescripcionLocal
      ,DescripcionIngles=@DescripcionIngles
      ,CuentaContableDefecto=@CuentaContableDefecto
      ,Estado=@Estado
      ,UsuarioCreacion=@UsuarioCreacion
      ,FechaCreacion=GETDATE()
      ,DireccionComun=@DireccionComun
      ,DireccionAdicional=@DireccionAdicional
      ,Telefono1=@Telefono1
      ,Telefono2=@Telefono2
      ,Telefono3=@Telefono3
      ,Fax1=@Fax1
      ,Fax2=@Fax2
      ,Compania=@Compania
      ,CIIU=@CIIU
      ,LogoSucursal=@LogoSucursal
      ,ACCION =@ACCION   
	WHERE 
		(Sucursal   =@Sucursal)  
   		select 1
 end   
 else  
 if(@Accion = 'DELETE')  
 begin  
  delete AC_Sucursal  
		WHERE 
		(Sucursal   =@Sucursal) 
   		select 1
end
		if(@Accion = 'CONTARLISTAPAG')
	begin		
		
		SET @CONTADOR=(
			SELECT COUNT(Sucursal) FROM AC_Sucursal WHERE 
				(@Sucursal is null OR @Sucursal='' OR (Sucursal = @Sucursal))										
			and (@Estado is null OR @Estado='' OR Estado = @Estado)
			and (@SucursalGrupo is null OR @SucursalGrupo='' OR SucursalGrupo = @SucursalGrupo)				
			and (@DescripcionLocal is null OR @DescripcionLocal ='' OR ( upper(DescripcionLocal) like upper('%'+@DescripcionLocal+'%')))	
			)	
		select @CONTADOR
	end
	else     
 if(@Accion = 'INSERTHOMOLOGACION')    
	 begin    
		insert into SS_HA_HomologacionSucursal 
		(IdAplicativo,CodigoSucursal, UnidadReplicacion )
		values
		(@Estado,@SucursalGrupo,@DireccionAdicional)
		
		select 1
	 end   
 else     
 if(@Accion = 'DELETEHOMOLOGACION')    
	 begin    
		delete SS_HA_HomologacionSucursal 
		where
		 IdAplicativo = @Estado
		 and CodigoSucursal = @SucursalGrupo
		 and UnidadReplicacion = @DireccionAdicional
		
		select 1
	 end   
commit	 
END  		
				
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_SucursalListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE  [dbo].[SP_SS_HC_SucursalListar]     
	@Sucursal  [varchar](4)=NULL ,
	@SucursalGrupo  [varchar](4) =NULL,
	@DescripcionLocal  [varchar](30)=NULL ,
	@DescripcionIngles  [varchar](30)=NULL ,
	@CuentaContableDefecto  [varchar](20)=NULL ,
	@Estado  [varchar](1)=NULL ,
	@UltimoUsuario  [varchar](25)=NULL ,
	@UltimaFechaModif  [datetime]=NULL ,
	@UsuarioCreacion  [varchar](25) ,
	@FechaCreacion  [datetime]=NULL ,
	@DireccionComun  [varchar](80) ,
	@DireccionAdicional  [varchar](80) ,
	@Telefono1  [varchar](15) ,
	@Telefono2  [varchar](15) ,
	@Telefono3  [varchar](15) ,
	@Fax1  [varchar](15) ,
	@Fax2  [varchar](15) ,
	@Compania  [varchar](8) ,
	@CIIU  [varchar](6) ,
	@LogoSucursal  [varchar](50) ,
	@ACCION  [varchar](25) ,	
	@INICIO   int= null,  
	@NUMEROFILAS int = null     
AS    
BEGIN    
if(@ACCION = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR=(
			SELECT COUNT(Sucursal) FROM AC_Sucursal 	WHERE 
				(@Sucursal is null OR (Sucursal = @Sucursal))										
			and (@Estado is null OR Estado = @Estado)
			and (@SucursalGrupo is null OR SucursalGrupo = @SucursalGrupo)	
				)
		SELECT Sucursal      ,SucursalGrupo      ,DescripcionLocal      ,DescripcionIngles
		  ,CuentaContableDefecto      ,Estado      ,UltimoUsuario      ,UltimaFechaModif
		  ,UsuarioCreacion      ,FechaCreacion      ,DireccionComun      ,DireccionAdicional
		  ,Telefono1      ,Telefono2      ,Telefono3      ,Fax1      ,Fax2
		  ,Compania      ,CIIU      ,LogoSucursal      ,ACCION
		FROM (		
			SELECT
				Sucursal		  ,SucursalGrupo		  ,DescripcionLocal		  ,DescripcionIngles
			  ,CuentaContableDefecto		  ,Estado		  ,UltimoUsuario	  ,UltimaFechaModif
			  ,UsuarioCreacion		  ,FechaCreacion		  ,DireccionComun	  ,DireccionAdicional
			  ,Telefono1		  ,Telefono2		  ,Telefono3		  ,Fax1
			  ,Fax2		  ,Compania		  ,CIIU		  ,LogoSucursal		  ,ACCION	,@CONTADOR AS Contador
		,ROW_NUMBER() OVER (ORDER BY Sucursal ASC ) AS RowNumber   	
		FROM AC_Sucursal	
		WHERE 
			(@Sucursal is null OR (Sucursal = @Sucursal))										
		and (@Estado is null OR Estado = @Estado)
		and (@SucursalGrupo is null OR SucursalGrupo = @SucursalGrupo)				
		and (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')					
		) AS LISTADO
			WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		
       END
       ELSE
  IF @Accion ='LISTAR'    
    BEGIN    
		SELECT
		   Sucursal      ,SucursalGrupo      ,DescripcionLocal      ,DescripcionIngles
		  ,CuentaContableDefecto      ,Estado      ,UltimoUsuario      ,UltimaFechaModif
		  ,UsuarioCreacion      ,FechaCreacion      ,DireccionComun      ,DireccionAdicional
		  ,Telefono1      ,Telefono2      ,Telefono3      ,Fax1      ,Fax2
		  ,Compania      ,CIIU      ,LogoSucursal      ,ACCION
		FROM AC_Sucursal	WHERE 
			(@Sucursal is null OR @Sucursal='' or (Sucursal = @Sucursal))										
		and (@Estado is null OR Estado = @Estado)
		and (@SucursalGrupo is null  OR @SucursalGrupo=''  OR SucursalGrupo = @SucursalGrupo)				
		and (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')	
 
	END	
	ELSE
	IF(@ACCION = 'LISTARPORID')
	BEGIN	 
		SELECT 	*	FROM AC_Sucursal WHERE
		(@Sucursal is null OR (Sucursal = @Sucursal))
	END	
	ELSE
	IF(@ACCION = 'LISTARHOMOLOGACION')    
	BEGIN     
		SELECT    
		CONVERT(integer,RowNumber) as Sucursal,    
		SucursalHCE as SucursalGrupo,    
		NULL AS DescripcionLocal,    
		NULL as DescripcionIngles,    
		NULL as CuentaContableDefecto,    
		AppEXT as Estado,    
		NULL as UltimoUsuario,    
		NULL as UltimaFechaModif,    
		NULL as UsuarioCreacion,    
		NULL as FechaCreacion,    
		NULL as DireccionComun,    
		CodigoEXT as DireccionAdicional,    
		NULL as Telefono1,    
		NULL as Telefono2,    
		NULL as Telefono3,    
		NULL as Fax1,    
		NULL as Fax2,    
		NULL as Compania,    
		NULL as CIIU,    
		NULL as LogoSucursal,   --AUX  
		NULL as  ACCION   
		FROM (      
		SELECT     
			AC_Sucursal.*,  
			HOMOLOGACION.CodigoSucursal AS SucursalHCE,  
			HOMOLOGACION.UnidadReplicacion AS CodigoEXT,  
			HOMOLOGACION.IdAplicativo AS AppEXT,  
			@CONTADOR AS Contador,
			ROW_NUMBER() OVER (ORDER BY HOMOLOGACION.CodigoSucursal ASC ) AS RowNumber        
		FROM SS_HA_HomologacionSucursal HOMOLOGACION     
		LEFT JOIN AC_Sucursal on (AC_Sucursal.Sucursal = HOMOLOGACION.CodigoSucursal)   
		WHERE     
		(@Sucursal is null OR (HOMOLOGACION.CodigoSucursal = @Sucursal) or @Sucursal ='')) AS LISTADO
		END
END


GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_SY_SeguridadAutorizaciones]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_SY_SeguridadAutorizaciones]
(
	@AplicacionCodigo	char(2) ,
	@Grupo	char(20) ,
	@Concepto	char(20) ,
	@Usuario	char(20) ,
	@MasterBrowseFlag	char(1) ,
	@MasterUpdateFlag	char(1) ,
	@MasterApproveFlag	char(1) ,
	@Estado	char(1) ,
	@UltimoUsuario	varchar(25) ,
	@UltimaFechaModif	datetime ,
	@IndAplicaSalud	int ,
	@IdAgente	int ,
	
	@INICIO   int= null,  
	@NUMEROFILAS int = null ,
	@ACCION	varchar(25) 
)

AS
BEGIN 
SET NOCOUNT ON;
BEGIN  TRANSACTION

	
	DECLARE @CONTADOR INT=0
	if(@ACCION = 'INSERT')
	begin
		---DELETE DE SEGURIDAD
		delete SY_SeguridadAutorizaciones
		WHERE 
		( AplicacionCodigo = @AplicacionCodigo)	
		and (Grupo = @Grupo)	
		and (Concepto = @Concepto)	
		and (Usuario = @Usuario)			
	
		insert into SY_SeguridadAutorizaciones
		(
			AplicacionCodigo
			,Grupo
			,Concepto
			,Usuario
			,MasterBrowseFlag
			,MasterUpdateFlag
			,MasterApproveFlag
			,Estado
			,UltimoUsuario
			,UltimaFechaModif
			,IndAplicaSalud
			,Accion

		)
		values(
			@AplicacionCodigo
		,	@Grupo
		,	@Concepto
		,	@Usuario
		,	@MasterBrowseFlag
		,	@MasterUpdateFlag
		,	@MasterApproveFlag
		,	@Estado
		,	@UltimoUsuario
		,	GETDATE()
		,	@IndAplicaSalud
		,	@Accion
		
		)
		
		if(@Grupo='COMPANIASOCIO')
		begin		
			---delete seguridad
			delete SeguridadAutorizacionCompania
			where substring(companyowner,1,8) = substring(@Concepto,1,8)
			and USUARIO =@Usuario
			
			insert into SeguridadAutorizacionCompania
			(Companyowner,Usuario,Estado,UltimaFechaModif,UltimoUsuario,CampoData)
			values
			(@Concepto,@Usuario,@Estado,GETDATE(),@UltimoUsuario,null)
		end			
			
		select 1			
	end
	else
	if(@ACCION = 'UPDATE')
	begin
		update SY_SeguridadAutorizaciones
		set			
			MasterBrowseFlag	=	@MasterBrowseFlag
			,MasterUpdateFlag	=	@MasterUpdateFlag
			,MasterApproveFlag	=	@MasterApproveFlag
			,Estado	=	@Estado
			,UltimoUsuario	=	@UltimoUsuario
			,UltimaFechaModif	=	GETDATE()
			,IndAplicaSalud	=	@IndAplicaSalud
			,Accion	=	@IndAplicaSalud		
		WHERE 
		( AplicacionCodigo = @AplicacionCodigo)	
		and (Grupo = @Grupo)	
		and (Concepto = @Concepto)	
		and (Usuario = @Usuario)			
				
		select 1	
	end	
	else
	if(@ACCION = 'DELETE')
	begin
		
		delete SY_SeguridadAutorizaciones
		WHERE 
		( AplicacionCodigo = @AplicacionCodigo)	
		and (Grupo = @Grupo)	
		and (Concepto = @Concepto)	
		and (Usuario = @Usuario)								
		
		if(@Grupo='COMPANIASOCIO')
		begin		
			delete SeguridadAutorizacionCompania
			where substring(companyowner,1,8) = substring(@Concepto,1,8)
			and USUARIO =@Usuario
		end		
		
		select 1	
		--select * from SY_SeguridadAutorizaciones			
		--select * from SeguridadAutorizacionCompania
	end		
commit
		
END

/*
exec SP_SS_HC_SY_SeguridadAutorizaciones

	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	
	0,
	0,
	'LISTAR'
	
	*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_SY_SeguridadAutorizaciones_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_SY_SeguridadAutorizaciones_LISTAR]
(
	@AplicacionCodigo	char(2) ,
	@Grupo	char(20) ,
	@Concepto	char(20) ,
	@Usuario	char(20) ,
	@MasterBrowseFlag	char(1) ,
	@MasterUpdateFlag	char(1) ,
	@MasterApproveFlag	char(1) ,
	@Estado	char(1) ,
	@UltimoUsuario	varchar(25) ,
	@UltimaFechaModif	datetime ,
	@IndAplicaSalud	int ,
	@IdAgente	int ,
	
	@INICIO   int= null,  
	@NUMEROFILAS int = null ,
	@ACCION	varchar(25) 

	-- MODIFICADO 
	--exec [dbo].[SP_SS_HC_SY_SeguridadAutorizaciones_LISTAR] @AplicacionCodigo='SY',@Grupo=NULL,@Concepto=NULL,@Usuario='JOLIVOS',
	--@MasterBrowseFlag=NULL,@MasterUpdateFlag=NULL,@MasterApproveFlag=NULL,@Estado=NULL,@UltimoUsuario=NULL,@UltimaFechaModif=NULL,
	--@IndAplicaSalud=NULL,@IdAgente=2215,@INICIO=2215,@NUMEROFILAS=0,@ACCION='LISTARSEGURIDADALMACENHCE'
)

AS
BEGIN 
SET NOCOUNT ON;

	
	DECLARE @CONTADOR INT=0
	if(@ACCION = 'LISTARPAG')
	begin
		
		select 1	
	end
	else
	if(@ACCION = 'LISTARSEGURIDAD')
	begin		
		select 
			AplicacionCodigo +'_'
			 + convert(varchar,ROW_NUMBER() OVER (ORDER BY Usuario ASC ))
			 as AplicacionCodigo
			,Grupo
			,Concepto
			,Usuario
			,MasterBrowseFlag
			,MasterUpdateFlag
			,MasterApproveFlag
			,Estado			
			,(case Grupo 
			when 'COMPANIASOCIO' then (select description from Companyowner
				where rtrim(companyowner) = rtrim(Concepto))
			when 'SUCURSAL' then (select DescripcionLocal from AC_Sucursal
				where rtrim(Sucursal) = rtrim(Concepto)	)  
		  
			end
			) as UltimoUsuario 
			
			,UltimaFechaModif
			,IndAplicaSalud
			,Accion			
		 from  SY_SeguridadAutorizaciones
		 
		WHERE 
		(@AplicacionCodigo is null or @AplicacionCodigo ='' or  AplicacionCodigo = @AplicacionCodigo)	
		and (@Grupo is null or @Grupo ='' or  Grupo = @Grupo)	
		and (@Concepto is null or @Concepto ='' or  Concepto = @Concepto)	
		and (@Usuario is null or @Usuario ='' or  rtrim(Usuario) = rtrim(@Usuario))	
		and (@ESTADO is null OR Estado = @ESTADO)
		AND SY_SeguridadAutorizaciones.MasterBrowseFlag IS NULL
		
		--and (Grupo ='Sist. de Administracion Hospitalaria SAC')
				
	end	
	else
	if(@ACCION = 'LISTARSEGURIDADALMACEN')
	begin		
		select 
			AplicacionCodigo +'_'
			 + convert(varchar,ROW_NUMBER() OVER (ORDER BY Usuario ASC ))
			 as AplicacionCodigo,
			SA.Grupo,
			SA.Concepto,
			SA.Usuario,
			SA.MasterBrowseFlag,
			AM.DescripcionLocal as MasterUpdateFlag,
			SU.DescripcionLocal as MasterApproveFlag,
			SA.Estado,
			SA.UltimoUsuario,
			SA.UltimaFechaModif,
			SA.IndAplicaSalud,
			SA.Accion
			 FROM SY_SeguridadAutorizaciones SA 
		INNER JOIN WH_AlmacenMast AM ON AM.AlmacenCodigo=SA.Concepto AND SA.Grupo='ALMACEN' 
		INNER JOIN SY_UnidadReplicacion UR ON UR.UnidadReplicacion =AM.UnidadReplicacion AND AM.CompaniaSocio=UR.Compania AND AM.ESTADO=UR.ESTADO
		INNER JOIN AC_Sucursal  SU ON SU.SUCURSAL=UR.SUCURSAL AND SU.Compania =UR.Compania  AND SU.ESTADO=UR.ESTADO
		--where  usuario='HZAPATA'
		--AND 
		--SU.SUCURSAL='CB01'
				WHERE 
				(@Usuario is null or @Usuario ='' or  rtrim(Usuario) = rtrim(@Usuario))	
				and
		(@UltimoUsuario is null or @UltimoUsuario ='' or  rtrim(SU.SUCURSAL) = rtrim(@UltimoUsuario))
				--and SA.Estado='A'
	end	



		else
	if(@ACCION = 'LISTARSEGURIDADXSUCURSAL')
	begin		
		select 
			AplicacionCodigo +'_'
			 + convert(varchar,ROW_NUMBER() OVER (ORDER BY Usuario ASC ))
			 as AplicacionCodigo,
			SA.Grupo,
			SA.Concepto ,
			--SU.SUCURSAL as Concepto,
			SA.Usuario,
			SA.MasterBrowseFlag,
			AM.DescripcionLocal as MasterUpdateFlag,
			SU.DescripcionLocal as MasterApproveFlag,
			SA.Estado,
			SU.SUCURSAL AS UltimoUsuario ,
			SA.UltimaFechaModif,
			SA.IndAplicaSalud,
			SA.Accion
			 FROM SY_SeguridadAutorizaciones SA 
		INNER JOIN WH_AlmacenMast AM ON AM.AlmacenCodigo=SA.Concepto AND SA.Grupo='ALMACEN' 
		INNER JOIN SY_UnidadReplicacion UR ON UR.UnidadReplicacion =AM.UnidadReplicacion AND AM.CompaniaSocio=UR.Compania AND AM.ESTADO=UR.ESTADO
		INNER JOIN AC_Sucursal  SU ON SU.SUCURSAL=UR.SUCURSAL AND SU.Compania =UR.Compania  AND SU.ESTADO=UR.ESTADO
		--where  usuario='HZAPATA'
				WHERE 
				(@Usuario is null or @Usuario ='' or  rtrim(Usuario) = rtrim(@Usuario))	
				and
				(@UltimoUsuario is null or @UltimoUsuario ='' or  rtrim(SU.SUCURSAL) = rtrim(@UltimoUsuario))	

	end	


		else
	if(@ACCION = 'LISTARSEGURIDADALMACENHCE')
	begin		
		select 
			AplicacionCodigo +'_'
			 + convert(varchar,ROW_NUMBER() OVER (ORDER BY Usuario ASC ))
			 as AplicacionCodigo,
			--SELECT  AplicacionCodigo,
			SA.Grupo,
			SA.Concepto,
			SA.Usuario,
			SA.MasterBrowseFlag,
			AM.DescripcionLocal as MasterUpdateFlag,
			SU.DescripcionLocal as MasterApproveFlag,
			SA.Estado,
			SA.UltimoUsuario,
			SA.UltimaFechaModif,
			SA.IndAplicaSalud,
			SA.Accion
			 FROM SY_SeguridadAutorizaciones SA 

			INNER JOIN WH_AlmacenMast AM ON AM.AlmacenCodigo=SA.Concepto AND SA.Grupo='ALMACEN' 
			INNER JOIN SY_UnidadReplicacion UR ON UR.UnidadReplicacion =AM.UnidadReplicacion AND AM.CompaniaSocio=UR.Compania AND AM.ESTADO=UR.ESTADO
			INNER JOIN AC_Sucursal  SU ON SU.SUCURSAL=UR.SUCURSAL AND SU.Compania =UR.Compania  AND SU.ESTADO=UR.ESTADO
			--where  usuario='lcajas'
		WHERE 
		(@Usuario is null or @Usuario ='' or  rtrim(Usuario) = rtrim(@Usuario))	
			and
		(@UltimoUsuario is null or @UltimoUsuario ='' or  rtrim(SU.SUCURSAL) = rtrim(@UltimoUsuario))	

		and SA.Estado='A'
	end

	else

	if(@ACCION = 'LISTARCOMBOALMACEN')
	begin		
		select 
			AplicacionCodigo +'_'
			 + convert(varchar,ROW_NUMBER() OVER (ORDER BY Usuario ASC ))
			 as AplicacionCodigo,
			--SELECT  AplicacionCodigo,
			SA.Grupo,
			SA.Concepto,
			SA.Usuario,
			SA.MasterBrowseFlag,
			AM.DescripcionLocal as MasterUpdateFlag,
			SU.DescripcionLocal as MasterApproveFlag,
			SA.Estado,
			SA.UltimoUsuario,
			SA.UltimaFechaModif,
			SA.IndAplicaSalud,
			SA.Accion
			 FROM SY_SeguridadAutorizaciones SA 

			INNER JOIN WH_AlmacenMast AM ON AM.AlmacenCodigo=SA.Concepto AND SA.Grupo='ALMACEN' 
			INNER JOIN SY_UnidadReplicacion UR ON UR.UnidadReplicacion =AM.UnidadReplicacion AND AM.CompaniaSocio=UR.Compania AND AM.ESTADO=UR.ESTADO
			INNER JOIN AC_Sucursal  SU ON SU.SUCURSAL=UR.SUCURSAL AND SU.Compania =UR.Compania  AND SU.ESTADO=UR.ESTADO
			--where  usuario='lcajas'
		WHERE 
		(@Usuario is null or @Usuario ='' or  rtrim(Usuario) = rtrim(@Usuario))	
	   AND SA.Estado='A'
	end	

	else

if(@ACCION = 'LISTARPROCEDIMIENTO')
	begin	
	
	select 
			AplicacionCodigo +'_'
			 + convert(varchar,ROW_NUMBER() OVER (ORDER BY Usuario ASC ))
			 as AplicacionCodigo,
			SA.Grupo,
			SA.Concepto,
			SA.Usuario,
			SA.MasterBrowseFlag,
			SS.Descripcion as MasterUpdateFlag,
			SS.Descripcion as MasterApproveFlag,
			--SU.DescripcionLocal as MasterApproveFlag,
			SA.Estado,
			SA.UltimoUsuario,
			SA.UltimaFechaModif,
			SA.IndAplicaSalud,
			SA.Accion
			 FROM SY_SeguridadAutorizaciones SA 
			 inner join SS_GE_Servicio SS on CONVERT(char,ss.IdServicio)= SA.Concepto
			 WHERE 
					(@Usuario is null or @Usuario ='' or  rtrim(Usuario) = rtrim(@Usuario))	

	end	

END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_SysRecursos_Valores_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_SysRecursos_Valores_LISTAR]
(
	@Sistema	varchar(4) ,
	@Modulo	varchar(2) ,
	@Compania	varchar(15) ,
	@CodigoTabla	varchar(15) ,
	@CodigoCampo	varchar(30) ,
	
	@SecuenciaValor	int ,
	@CODTIPOATRIBUTO	varchar(15) ,
	@TIPODATO	char(2) ,
	@VALORTEXTO	varchar(250) ,
	@VALORNUMERICO	numeric(10, 2) ,
	
	@VALORDATE	datetime ,
	@Estado	int ,
	@SecuenciaValorRef	int ,
	@UsuarioCreacion	varchar(25) ,
	@FechaCreacion	datetime ,
	
	@UsuarioModificacion	varchar(25) ,
	@FechaModificacion	datetime ,	
	@VERSION	varchar(25) ,
	
	@Inicio	int ,	
	@NumeroFilas	int ,	
	@ACCION	varchar(25) 
			
)

AS
BEGIN
	if(@ACCION = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR=(SELECT COUNT(SecuenciaValor) 
				FROM SS_HC_SysRecursos_Valores
	 					WHERE 
					(@Sistema is null OR (Sistema = @Sistema) or @Sistema ='')
					and (@Modulo is null OR (Modulo = @Modulo) or @Modulo ='')
					and (@CodigoTabla is null OR (CodigoTabla = @CodigoTabla) or @CodigoTabla ='')
					and (@CodigoCampo is null OR (CodigoCampo = @CodigoCampo) or @CodigoCampo ='')
					and (@SecuenciaValor is null OR (SecuenciaValor = @SecuenciaValor) or @SecuenciaValor =0)
					and (@ESTADO is null OR Estado = @ESTADO)					
					)
	 
		SELECT 
				Sistema
				,Modulo
				,Compania
				,CodigoTabla
				,CodigoCampo
				,SecuenciaValor
				,CODTIPOATRIBUTO
				,TIPODATO
				,VALORTEXTO
				,VALORNUMERICO
				,VALORDATE
				,Estado
				,SecuenciaValorRef
				,UsuarioCreacion
				,FechaCreacion
				,UsuarioModificacion
				,FechaModificacion
				,ACCION
				,VERSION				
		FROM (
				SELECT 
					SS_HC_SysRecursos_Valores.*
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY SecuenciaValor ASC ) AS RowNumber   					
				FROM SS_HC_SysRecursos_Valores
	 					WHERE 
					(@Sistema is null OR (Sistema = @Sistema) or @Sistema ='')
					and (@Modulo is null OR (Modulo = @Modulo) or @Modulo ='')
					and (@CodigoTabla is null OR (CodigoTabla = @CodigoTabla) or @CodigoTabla ='')
					and (@CodigoCampo is null OR (CodigoCampo = @CodigoCampo) or @CodigoCampo ='')
					and (@SecuenciaValor is null OR (SecuenciaValor = @SecuenciaValor) or @SecuenciaValor =0)
					and (@ESTADO is null OR Estado = @ESTADO)	
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
	end
	else
	if(@ACCION = 'LISTAR')
	begin
	 
				SELECT 
					Sistema
					,Modulo
					,Compania
					,CodigoTabla
					,CodigoCampo
					,SecuenciaValor
					,CODTIPOATRIBUTO
					,TIPODATO
					,VALORTEXTO
					,VALORNUMERICO
					,VALORDATE
					,Estado
					,SecuenciaValorRef
					,UsuarioCreacion
					,FechaCreacion
					,UsuarioModificacion
					,FechaModificacion
					,ACCION
					,VERSION						
					
				FROM SS_HC_SysRecursos_Valores
	 					WHERE 
					(@Sistema is null OR (Sistema = @Sistema) or @Sistema ='')
					and (@Modulo is null OR (Modulo = @Modulo) or @Modulo ='')
					and (@CodigoTabla is null OR (CodigoTabla = @CodigoTabla) or @CodigoTabla ='')
					and (@CodigoCampo is null OR (CodigoCampo = @CodigoCampo) or @CodigoCampo ='')
					and (@SecuenciaValor is null OR (SecuenciaValor = @SecuenciaValor) or @SecuenciaValor =0)
					and (@ESTADO is null OR Estado = @ESTADO)					

	end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 
					Sistema
					,Modulo
					,Compania
					,CodigoTabla
					,CodigoCampo
					,SecuenciaValor
					,CODTIPOATRIBUTO
					,TIPODATO
					,VALORTEXTO
					,VALORNUMERICO
					,VALORDATE
					,Estado
					,SecuenciaValorRef
					,UsuarioCreacion
					,FechaCreacion
					,UsuarioModificacion
					,FechaModificacion
					,ACCION
					,VERSION						
					
				FROM SS_HC_SysRecursos_Valores
	 					WHERE 
					 (Sistema = @Sistema)
					and (Modulo = @Modulo)
					and (Compania = @Compania)
					and (CodigoTabla = @CodigoTabla)
					and  (CodigoCampo = @CodigoCampo) 
					and (SecuenciaValor = @SecuenciaValor)					
					
	end	
	else
	if(@ACCION = 'LISTARVALIDAR')
	begin
	 
				SELECT 
					Sistema
					,Modulo
					,Compania
					,CodigoTabla
					,CodigoCampo
					,SecuenciaValor
					,CODTIPOATRIBUTO
					,TIPODATO
					,VALORTEXTO
					,VALORNUMERICO
					,VALORDATE
					,Estado
					,SecuenciaValorRef
					,UsuarioCreacion
					,FechaCreacion
					,UsuarioModificacion
					,FechaModificacion
					,ACCION
					,VERSION						
					
				FROM SS_HC_SysRecursos_Valores
	 					WHERE 
					(@Sistema is null OR (Sistema = @Sistema) or @Sistema ='')
					and (@Modulo is null OR (Modulo = @Modulo) or @Modulo ='')
					and (@CodigoTabla is null OR (CodigoTabla = @CodigoTabla) or @CodigoTabla ='')
					and (@CodigoCampo is null OR (CodigoCampo = @CodigoCampo) or @CodigoCampo ='')
					and (@SecuenciaValor is null OR (SecuenciaValor = @SecuenciaValor) or @SecuenciaValor =0)
					and (@ESTADO is null OR Estado = @ESTADO)					
					and (SUBSTRING( CODTIPOATRIBUTO,1,4) ='VAL_')

	end		

END
/*
exec [SP_SS_HC_SysRecursos_Valores_LISTAR]

	NULL,
	NULL,
	NULL,
	'CPOHUMANOMAST',
	NULL,
	
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
		
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,	
	
	NULL,
	NULL,
	NULL,	
		
	0,20,	
	'LISTARVALIDAR'
			
)*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Tabla_Lista]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_Tabla_Lista]
			@IdFavoritoTabla int,
            @NombreTabla varchar(128),
            @Descripcion varchar(100),
            @DescripcionExtranjera varchar(100),
            @TipoClavePrimaria int,
            @TipoTabla int,
            @Condicion varchar(500),
            @Estado int,
            @UsuarioCreacion varchar(25),
            @FechaCreacion datetime,
            @UsuarioModificacion varchar(25),
            @FechaModificacion datetime,
            @Accion varchar(25),
            @Version varchar(25),

			@INICIO   int= null,  
			@NUMEROFILAS int = null     
AS    
BEGIN    
if(@ACCION = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR=(SELECT COUNT(IdFavoritoTabla) FROM SS_HC_Tabla
	 					WHERE 
					 TipoTabla=1
					AND (@IdFavoritoTabla is null OR (IdFavoritoTabla = @IdFavoritoTabla) or @IdFavoritoTabla =0)	
					and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')				
					)
		SELECT
				IdFavoritoTabla,
				NombreTabla,
				Descripcion,
				DescripcionExtranjera,
				TipoClavePrimaria,
				TipoTabla,
				Condicion,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version
		FROM (		
			SELECT
				IdFavoritoTabla,
				NombreTabla,
				Descripcion,
				DescripcionExtranjera,
				TipoClavePrimaria,
				TipoTabla,
				Condicion,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY IdFavoritoTabla ASC ) AS RowNumber   	
					FROM SS_HC_Tabla	
					WHERE TipoTabla=1
					AND (@IdFavoritoTabla is null OR (IdFavoritoTabla = @IdFavoritoTabla) or @IdFavoritoTabla =0)	
					and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')									
 
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		
       END
       ELSE
  IF @Accion ='LISTAR'    
    BEGIN    
		SELECT
				IdFavoritoTabla,
				NombreTabla,
				Descripcion,
				DescripcionExtranjera,
				TipoClavePrimaria,
				TipoTabla,
				Condicion,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version
				FROM SS_HC_Tabla	
									
				WHERE 
					    (@IdFavoritoTabla is null OR (IdFavoritoTabla = @IdFavoritoTabla) or @IdFavoritoTabla =0)	
					and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')										
		end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 
					*					
				from 
				SS_HC_Tabla

					WHERE 
					(@IdFavoritoTabla is null OR (IdFavoritoTabla = @IdFavoritoTabla) or @IdFavoritoTabla =0)										
		end	
		else
	if(@ACCION = 'LISTARxNOM')
	begin
		 
		SELECT
				IdFavoritoTabla,
				NombreTabla,
				Descripcion,
				DescripcionExtranjera,
				TipoClavePrimaria,
				TipoTabla,
				Condicion,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version
		FROM (		
			SELECT
				IdFavoritoTabla,
				NombreTabla,
				Descripcion,
				DescripcionExtranjera,
				TipoClavePrimaria,
				TipoTabla,
				Condicion,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY IdFavoritoTabla ASC ) AS RowNumber   	
					FROM SS_HC_Tabla	
					WHERE TipoTabla=1
					AND (@NombreTabla is null OR (NombreTabla = @NombreTabla))
										
 
			) AS LISTADO
					
		
       END			
END        
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Tabla_Mantenimiento]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_Tabla_Mantenimiento]
			@IdFavoritoTabla int,
            @NombreTabla varchar(128),
            @Descripcion varchar(100),
            @DescripcionExtranjera varchar(100),
            @TipoClavePrimaria int,
            @TipoTabla int,
            @Condicion varchar(500),
            @Estado int,
            @UsuarioCreacion varchar(25),
            @FechaCreacion datetime,
            @UsuarioModificacion varchar(25),
            @FechaModificacion datetime,
            @Accion varchar(25),
            @Version varchar(25)
AS  
BEGIN   
SET NOCOUNT ON;  
BEGIN  TRANSACTION  
  
 DECLARE @CONTADOR INT  
 IF(@Accion = 'INSERT')  
 BEGIN   
 		select @CONTADOR= isnull(MAX(IdFavoritoTabla),0)+1 from SS_HC_Tabla 
		
		set @IdFavoritoTabla = @CONTADOR
		
  INSERT INTO SS_HC_Tabla  
  (  	
				IdFavoritoTabla,
				NombreTabla,
				Descripcion,
				DescripcionExtranjera,
				TipoClavePrimaria,
				TipoTabla,
				Condicion,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version
  )  
    VALUES  
  (   
				@IdFavoritoTabla,
				@NombreTabla,
				@Descripcion,
				@DescripcionExtranjera,
				@TipoClavePrimaria,
				@TipoTabla,
				@Condicion,
				@Estado,
				@UsuarioCreacion,
				@FechaCreacion,
				@UsuarioModificacion,
				@FechaModificacion,
				@Accion,
				@Version
  )  
  
 SELECT 1		 
 END   
 ELSE  
 IF(@Accion = 'UPDATE')  
 BEGIN  
 UPDATE SS_HC_Tabla  
  SET  
				IdFavoritoTabla = @IdFavoritoTabla,
				NombreTabla = @NombreTabla,
				Descripcion = @Descripcion,
				DescripcionExtranjera = @DescripcionExtranjera,
				TipoClavePrimaria = @TipoClavePrimaria,
				TipoTabla = @TipoTabla,
				Condicion = @Condicion,
				Estado = @Estado,
				UsuarioCreacion = @UsuarioCreacion, 
				FechaCreacion = @FechaCreacion,
				UsuarioModificacion = @UsuarioModificacion,
				FechaModificacion = @FechaModificacion,
				Accion = @Accion,
				Version = @Version
		WHERE 
			(IdFavoritoTabla = @IdFavoritoTabla)  
   		select 1
 end   
 else  
 if(@Accion = 'DELETE')  
 begin  
  delete SS_HC_Tabla  
		WHERE 
			(IdFavoritoTabla = @IdFavoritoTabla) 
   		select 1
end
		if(@Accion = 'CONTARLISTAPAG')
	begin		
		SET @CONTADOR=(SELECT COUNT(IdFavoritoTabla) FROM SS_HC_Tabla
					WHERE TipoTabla=1
					AND (@IdFavoritoTabla is null OR (IdFavoritoTabla = @IdFavoritoTabla) or @IdFavoritoTabla =0)	
					and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')			
					)
					
		select @CONTADOR
	end
commit	 
END  


GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_TablaCampo_Lista]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_TablaCampo_Lista]
			 @IdFavoritoTabla int,
             @IdCampo int,
             @NombreCampo varchar(128),
             @Orden int,
             @Descripcion varchar(100),
             @DescripcionExtranjera varchar(100),
             @TipoCampo int,
             @Longitud int,
             @Decimales int,
             @NumeroClavePrimaria int,
             @TipoCampoDescripcion int,
             @Estado int,
             @UsuarioCreacion varchar(25),
             @FechaCreacion datetime,
             @UsuarioModificacion varchar(25),
             @FechaModificacion datetime,
             @Accion varchar(25),
             @Version varchar(25),	
             
			 @INICIO   int= null,  
			 @NUMEROFILAS int = null    
AS    
BEGIN    
if(@ACCION = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR=(SELECT COUNT(IdCampo) FROM SS_HC_TablaCampo
	 					WHERE 
					(@IdFavoritoTabla is null OR (IdFavoritoTabla = @IdFavoritoTabla) or @IdFavoritoTabla =0)	
					and (@IdCampo is null OR (IdCampo = @IdCampo) or @IdCampo =0)					
					and (@Estado is null OR Estado = @Estado)
					)
		SELECT
				
				convert(int,ROW_NUMBER() OVER (ORDER BY IdFavoritoTabla ASC )) as IdFavoritoTabla,  
				IdCampo,
				NombreCampo,
				Orden,
				Descripcion,
				DescripcionExtranjera,
				TipoCampo,
				Longitud,
				Decimales,
				NumeroClavePrimaria,
				TipoCampoDescripcion,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				convert(varchar,IdFavoritoTabla) as Version   
		FROM (		
			SELECT
				IdFavoritoTabla,
				IdCampo,
				NombreCampo,
				Orden,
				Descripcion,
				DescripcionExtranjera,
				TipoCampo,
				Longitud,
				Decimales,
				NumeroClavePrimaria,
				TipoCampoDescripcion,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY IdCampo ASC ) AS RowNumber   	
					FROM SS_HC_TablaCampo	
					WHERE 
					(@IdFavoritoTabla is null OR (IdFavoritoTabla = @IdFavoritoTabla) or @IdFavoritoTabla =0)	
					and (@NombreCampo is null  OR @NombreCampo =''  OR  upper(NombreCampo) like '%'+upper(@NombreCampo)+'%')
					and (@IdCampo is null OR (IdCampo = @IdCampo) or @IdCampo =0)					
					and (@Estado is null OR Estado = @Estado)
 
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		
       END
       ELSE
       
    IF(@ACCION = 'LISTARPAGDOD')
	BEGIN
		 DECLARE @CONTADORDOD INT
	
		 SET @CONTADORDOD=(SELECT COUNT(IdCampo) FROM SS_HC_TablaCampo
	 					WHERE 
						(IdFavoritoTabla < 7 and NumeroClavePrimaria=1) 
					and (@IdCampo is null OR (IdCampo = @IdCampo) or @IdCampo =0)					
					and (@Estado is null OR Estado = @Estado)
					)
		SELECT
				IdFavoritoTabla,
				IdCampo,
				NombreCampo,
				Orden,
				Descripcion,
				DescripcionExtranjera,
				TipoCampo,
				Longitud,
				Decimales,
				NumeroClavePrimaria,
				TipoCampoDescripcion,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version
		FROM (		
			SELECT
				IdFavoritoTabla,
				IdCampo,
				NombreCampo,
				Orden,
				Descripcion,
				DescripcionExtranjera,
				TipoCampo,
				Longitud,
				Decimales,
				NumeroClavePrimaria,
				TipoCampoDescripcion,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version
					,@CONTADORDOD AS Contador
					,ROW_NUMBER() OVER (ORDER BY IdCampo ASC ) AS RowNumber   	
					FROM SS_HC_TablaCampo	
					WHERE 
						(IdFavoritoTabla < 7 and NumeroClavePrimaria=1) 	
					and (@NombreCampo is null  OR @NombreCampo =''  OR  upper(NombreCampo) like '%'+upper(@NombreCampo)+'%')
					and (@IdCampo is null OR (IdCampo = @IdCampo) or @IdCampo =0)					
					and (@Estado is null OR Estado = @Estado)
 
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		
       END
       ELSE
       
  IF @Accion ='LISTAR'    
    BEGIN    
		SELECT
				IdFavoritoTabla,
				IdCampo,
				NombreCampo,
				Orden,
				Descripcion,
				DescripcionExtranjera,
				TipoCampo,
				Longitud,
				Decimales,
				NumeroClavePrimaria,
				TipoCampoDescripcion,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version
				FROM SS_HC_TablaCampo	
				
				WHERE 
					(@IdFavoritoTabla is null OR (IdFavoritoTabla = @IdFavoritoTabla) or @IdFavoritoTabla =0)	
					and (@IdCampo is null OR (IdCampo = @IdCampo) or @IdCampo =0)					
					and (@Estado is null OR Estado = @Estado)
 
end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 
					*					
				from 
				SS_HC_TablaCampo

					WHERE 
					(@IdFavoritoTabla is null OR (IdFavoritoTabla = @IdFavoritoTabla) or @IdFavoritoTabla =0)	
					and (@IdCampo is null OR (IdCampo = @IdCampo) or @IdCampo =0)					
					and (@Estado is null OR Estado = @Estado)

	end	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_TablaCampo_Mantenimiento]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_TablaCampo_Mantenimiento]
			 @IdFavoritoTabla int,
             @IdCampo int,
             @NombreCampo varchar(128),
             @Orden int,
             @Descripcion varchar(100),
             @DescripcionExtranjera varchar(100),
             @TipoCampo int,
             @Longitud int,
             @Decimales int,
             @NumeroClavePrimaria int,
             @TipoCampoDescripcion int,
             @Estado int,
             @UsuarioCreacion varchar(25),
             @FechaCreacion datetime,
             @UsuarioModificacion varchar(25),
             @FechaModificacion datetime,
             @Accion varchar(25),
             @Version varchar(25)
AS  
BEGIN   
SET NOCOUNT ON;  
BEGIN  TRANSACTION  
  
 DECLARE @CONTADOR INT  
 DECLARE @CONTADORDOD INT  
 IF(@Accion = 'INSERT')  
 BEGIN   
 		select @CONTADOR= isnull(MAX(IdCampo),0)+1 from SS_HC_TablaCampo 
		
		set @IdCampo= @CONTADOR
		
  INSERT INTO SS_HC_TablaCampo  
  (  
			IdFavoritoTabla,
			IdCampo,
			NombreCampo,
			Orden,
			Descripcion,
			DescripcionExtranjera,
			TipoCampo,
			Longitud,
			Decimales,
			NumeroClavePrimaria,
			TipoCampoDescripcion,
			Estado,
			UsuarioCreacion,
			FechaCreacion,
			UsuarioModificacion,
			FechaModificacion,
			Accion,
			Version
  )  
    VALUES  
  (   
	
			@IdFavoritoTabla,
			@IdCampo,
			@NombreCampo,
			@Orden,
			@Descripcion,
			@DescripcionExtranjera,
			@TipoCampo,
			@Longitud,
			@Decimales,
			@NumeroClavePrimaria,
			@TipoCampoDescripcion,
			@Estado,
			@UsuarioCreacion,
			@FechaCreacion,
			@UsuarioModificacion,
			@FechaModificacion,
			@Accion,
			@Version
  )  
  
 SELECT 1		 
 END   
 ELSE  
 IF(@Accion = 'UPDATE')  
 BEGIN  
 UPDATE SS_HC_TablaCampo  
  SET      
			IdFavoritoTabla = @IdFavoritoTabla,
			IdCampo = @IdCampo,
			NombreCampo = @NombreCampo,
			Orden = @Orden,
			Descripcion = @Descripcion,
			DescripcionExtranjera = @DescripcionExtranjera,
			TipoCampo = @TipoCampo,
			Longitud = @Longitud,
			Decimales = @Decimales,
			NumeroClavePrimaria = @NumeroClavePrimaria,
			TipoCampoDescripcion = @TipoCampoDescripcion,
			Estado = @Estado,
			UsuarioCreacion = @UsuarioCreacion,
			FechaCreacion = @FechaCreacion,
			UsuarioModificacion = @UsuarioModificacion, 
			FechaModificacion = @FechaModificacion,
			Accion = @Accion,
			Version = @Version
		WHERE 
		(IdFavoritoTabla = @IdFavoritoTabla)
		and (IdCampo = @IdCampo)  
   		select 1
 END   
 ELSE  
 IF(@Accion = 'DELETE')  
 BEGIN  
 DELETE SS_HC_TablaCampo  
		WHERE 
		    (IdFavoritoTabla = @IdFavoritoTabla)
		AND (IdCampo = @IdCampo)
   		SELECT 1
 END
	IF(@Accion = 'CONTARLISTAPAG')
	BEGIN		
		SET @CONTADOR=(SELECT COUNT(IdCampo) FROM SS_HC_TablaCampo
	 					WHERE 
					(@IdFavoritoTabla is null OR (IdFavoritoTabla = @IdFavoritoTabla) or @IdFavoritoTabla =0)	
					and (@IdCampo is null OR (IdCampo = @IdCampo) or @IdCampo =0)					
					and (@Estado is null OR Estado = @Estado)
					)
					
		select @CONTADOR
	END
	
		IF(@Accion = 'CONTARLISTAPAGDOD')
	BEGIN		
		 SET @CONTADORDOD=(SELECT COUNT(IdCampo) FROM SS_HC_TablaCampo
	 					WHERE 
						(IdFavoritoTabla < 7 and NumeroClavePrimaria=1) 
					and (@IdCampo is null OR (IdCampo = @IdCampo) or @IdCampo =0)					
					and (@Estado is null OR Estado = @Estado)
					)
					
		select @CONTADORDOD
	END
	
COMMIT	 
END  
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Ubicacion]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ============================================= 
-- Author:    Grace Córdova 
-- Create date: 25/11/2015 
-- ============================================= 
CREATE OR ALTER PROCEDURE [SP_SS_HC_Ubicacion] 
  @UnidadReplicacion   CHAR(4), 
  @IdUbicacion         INT, 
  @IdUbicacionPadre    INT, 
  @Codigo              VARCHAR(15), 
  @Nombre              VARCHAR(80), 
  
  @Descripcion         VARCHAR(150), 
  @TipoUbicacion       VARCHAR(1), 
  @Ruta                VARCHAR(250), 
  @OrdenRuta           INT, 
  @Orden               INT, 
  
  @Nivel               INT, 
  @CadenaRecursividad  VARCHAR(150), 
  @Estado              INT, 
  @UsuarioCreacion     VARCHAR(25), 
  @FechaCreacion       DATETIME, 
  
  @UsuarioModificacion VARCHAR(25), 
  @FechaModificacion   DATETIME, 
  @RutaDescripcion     VARCHAR(500), 
  @Accion              VARCHAR(25) 
AS 
  BEGIN 
  DECLARE @CONTADOR INT 
    IF(@Accion = 'INSERT') 
    BEGIN 
    declare @idubicacionnew int
    select @idubicacionnew = isnull(MAX(idubicacion),0)+1 from ss_hc_ubicacion 
      INSERT INTO ss_hc_ubicacion 
                  ( 
                              unidadreplicacion, 
                              idubicacion, 
                              idubicacionpadre, 
                              codigo, 
                              nombre, 
                              descripcion, 
                              tipoubicacion, 
                              ruta, 
                              ordenruta, 
                              orden, 
                              nivel, 
                              cadenarecursividad, 
                              estado, 
                              usuariocreacion, 
                              fechacreacion, 
                              usuariomodificacion, 
                              fechamodificacion, 
                              rutadescripcion, 
                              accion 
                  ) 
                  VALUES 
                  ( 
                              @UnidadReplicacion, 
                              @idubicacionnew, 
                              @IdUbicacionPadre, 
                              @Codigo, 
                              @Nombre, 
                              @Descripcion, 
                              @TipoUbicacion, 
                              @Ruta, 
                              @OrdenRuta, 
                              @Orden, 
                              @Nivel, 
                              @CadenaRecursividad, 
                              @Estado, 
                              @UsuarioCreacion, 
                              Getdate(), 
                              @UsuarioModificacion, 
                              Getdate(), 
                              @RutaDescripcion, 
                              @Accion 
                  ) 
      SELECT 1 
    END 
    ELSE 
    IF(@Accion = 'UPDATE') 
    BEGIN 
      UPDATE ss_hc_ubicacion 
      SET
             idubicacionpadre=@IdUbicacionPadre, 
             codigo=@Codigo, 
             nombre=@Nombre, 
             descripcion=@Descripcion, 
             tipoubicacion=@TipoUbicacion, 
             ruta=@Ruta, 
             ordenruta=@OrdenRuta, 
             orden=@Orden, 
             nivel=@Nivel, 
             cadenarecursividad=@CadenaRecursividad, 
             estado=@Estado, 
             usuariomodificacion=@UsuarioModificacion, 
             fechamodificacion=GETDATE(), 
             rutadescripcion=@RutaDescripcion, 
             accion=@Accion 
      WHERE  unidadreplicacion=@UnidadReplicacion 
      AND    idubicacion=@IdUbicacion 
      SELECT 1 
    END 
    ELSE 
    IF (@Accion = 'DELETE') 
    BEGIN 
      DELETE ss_hc_ubicacion 
      WHERE  unidadreplicacion=@UnidadReplicacion 
      AND    idubicacion=@IdUbicacion 
      SELECT 1 
    END 
    ELSE 
    IF (@Accion = 'LISTARPAG') 
    BEGIN 
      
      SET @CONTADOR = (SELECT  Count(*) 
      FROM   ss_hc_ubicacion 
      WHERE  ( @Codigo IS NULL OR     Upper(codigo) LIKE '%'+Upper(@Codigo)+'%') 
		AND ( @UnidadReplicacion IS NULL OR UnidadReplicacion = @UnidadReplicacion OR @UnidadReplicacion = '' ) 
		AND ( @TipoUbicacion IS NULL OR TipoUbicacion = @TipoUbicacion  )             
      AND    ( @Nombre IS NULL OR     Upper(nombre) LIKE '%'+Upper(@Nombre)+'%') 
      AND    ( @Descripcion IS NULL OR     Upper(descripcion) LIKE '%'+Upper(@Descripcion)+'%') 
      AND    ( @IdUbicacion IS NULL OR @IdUbicacion = 0 OR  IdUbicacion = @IdUbicacion))
      SELECT @CONTADOR 
    end 
    ELSE 
    IF (@Accion = 'LISTARPAGSELEC') 
    BEGIN 
      
      SET @CONTADOR = (SELECT  Count(*) 
      FROM   ss_hc_ubicacion 
      WHERE  ( @Codigo IS NULL OR     Upper(codigo) LIKE '%'+Upper(@Codigo)+'%') 
		AND ( @UnidadReplicacion IS NULL OR UnidadReplicacion = @UnidadReplicacion OR @UnidadReplicacion = '' ) 
		AND ( @TipoUbicacion IS NULL OR TipoUbicacion = @TipoUbicacion  )             
      AND    ( @Nombre IS NULL OR     Upper(nombre) LIKE '%'+Upper(@Nombre)+'%') 
      AND    ( @Descripcion IS NULL OR     Upper(descripcion) LIKE '%'+Upper(@Descripcion)+'%') 
      
      )
      SELECT @CONTADOR 
    end     
  END 
  /* 
EXEC sp_SS_HC_Ubicacion 
NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL 
*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_UbicacionListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:    Grace Córdova  
-- Create date: 25/11/2015  
-- =============================================  
CREATE OR ALTER PROCEDURE [SP_SS_HC_UbicacionListar] 
@UnidadReplicacion   CHAR(4), 
@IdUbicacion         INT, 
@IdUbicacionPadre    INT, 
@Codigo              VARCHAR(15), 
@Nombre              VARCHAR(80), 

@Descripcion         VARCHAR(150), 
@TipoUbicacion       VARCHAR(1), 
@Ruta                VARCHAR(250), 
@OrdenRuta           INT, 
@Orden               INT, 

@Nivel               INT, 
@CadenaRecursividad  VARCHAR(150), 
@Estado              INT, 
@UsuarioCreacion     VARCHAR(25), 
@FechaCreacion       DATETIME, 

@UsuarioModificacion VARCHAR(25), 
@FechaModificacion   DATETIME, 
@RutaDescripcion     VARCHAR(500), 
@Accion              VARCHAR(25), 
@INICIO              INT= NULL, 

@NUMEROFILAS         INT = NULL 
AS 
  BEGIN 
  
  DECLARE @CONTADOR INT 
      IF( @Accion = 'LISTAR' ) 
        BEGIN 
            SELECT ss_hc_ubicacion.unidadreplicacion, 
                   ss_hc_ubicacion.idubicacion, 
                   ss_hc_ubicacion.idubicacionpadre, 
                   ss_hc_ubicacion.codigo, 
                   ss_hc_ubicacion.nombre, 
                   ss_hc_ubicacion.descripcion, 
                   ss_hc_ubicacion.tipoubicacion, 
                   ss_hc_ubicacion.ruta, 
                   ss_hc_ubicacion.ordenruta, 
                   ss_hc_ubicacion.orden, 
                   ss_hc_ubicacion.nivel, 
                   ss_hc_ubicacion.cadenarecursividad, 
                   ss_hc_ubicacion.estado, 
                   ss_hc_ubicacion.usuariocreacion, 
                   ss_hc_ubicacion.fechacreacion, 
                   ss_hc_ubicacion.usuariomodificacion, 
                   ss_hc_ubicacion.fechamodificacion, 
                   ss_hc_ubicacion.rutadescripcion, 
                   ss_hc_ubicacion.accion 
            FROM   ss_hc_ubicacion 
            WHERE  ( @Codigo IS NULL OR Upper(codigo) LIKE '%' + Upper(@Codigo) + '%' ) 
					AND ( @UnidadReplicacion IS NULL OR UnidadReplicacion = @UnidadReplicacion OR @UnidadReplicacion = '' ) 
					AND ( @TipoUbicacion IS NULL OR TipoUbicacion = @TipoUbicacion  )       
            
                   AND ( @Nombre IS NULL OR Upper(nombre) LIKE '%' + Upper(@Nombre) + '%' ) 
                   AND ( @Descripcion IS NULL OR Upper(descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                   AND (@IdUbicacion IS NULL OR @IdUbicacion = 0 OR IdUbicacion = @IdUbicacion )
                   AND (@IdUbicacionPadre IS NULL OR IdUbicacionPadre = @IdUbicacionPadre )
        END 
      ELSE IF( @Accion = 'LISTARPAG' ) 
        BEGIN 
            

            SELECT @CONTADOR = Count(*) 
            FROM   ss_hc_ubicacion 
            WHERE  ( @Codigo IS NULL OR Upper(codigo) LIKE '%' + Upper(@Codigo) + '%' ) 
					AND ( @UnidadReplicacion IS NULL OR UnidadReplicacion = @UnidadReplicacion OR @UnidadReplicacion = '' ) 
					AND ( @TipoUbicacion IS NULL OR TipoUbicacion = @TipoUbicacion  )       
            
                   AND ( @Nombre IS NULL OR Upper(nombre) LIKE '%' + Upper(@Nombre) + '%' ) 
                   AND ( @Descripcion IS NULL OR Upper(descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                   AND (@IdUbicacion IS NULL OR @IdUbicacion = 0 OR IdUbicacion = @IdUbicacion )

            SELECT SS_HC_Ubicacion.unidadreplicacion, 
                   SS_HC_Ubicacion.idubicacion, 
                   SS_HC_Ubicacion.idubicacionpadre, 
                   SS_HC_Ubicacion.codigo, 
                   SS_HC_Ubicacion.nombre, 
                   SS_HC_Ubicacion.descripcion, 
                   SS_HC_Ubicacion.tipoubicacion, 
                   SS_HC_Ubicacion.ruta, 
                   SS_HC_Ubicacion.ordenruta, 
                   SS_HC_Ubicacion.orden, 
                   SS_HC_Ubicacion.nivel, 
                   SS_HC_Ubicacion.cadenarecursividad, 
                   SS_HC_Ubicacion.estado, 
                   SS_HC_Ubicacion.usuariocreacion, 
                   SS_HC_Ubicacion.fechacreacion, 
                   SS_HC_Ubicacion.usuariomodificacion, 
                   SS_HC_Ubicacion.fechamodificacion, 
                   SS_HC_Ubicacion.rutadescripcion, 
                   SS_HC_Ubicacion.accion 
            FROM  (SELECT ss_hc_ubicacion.*,
                          @CONTADOR                AS CONTADOR, 
                          Row_number() 
                            OVER( 
                              ORDER BY codigo ASC) AS ROWNUMBER 
                   FROM   ss_hc_ubicacion 
                   WHERE  ( @Codigo IS NULL OR Upper(codigo) LIKE '%' + Upper(@Codigo) + '%' ) 
					AND ( @UnidadReplicacion IS NULL OR UnidadReplicacion = @UnidadReplicacion OR @UnidadReplicacion = '' ) 
					AND ( @TipoUbicacion IS NULL OR TipoUbicacion = @TipoUbicacion  )       
                   
                          AND ( @Nombre IS NULL OR Upper(nombre) LIKE '%' + Upper(@Nombre) + '%' ) 
                          AND ( @Descripcion IS NULL OR Upper(descripcion) LIKE '%' + Upper(@Descripcion) + '%' )
                          AND (@IdUbicacion IS NULL OR @IdUbicacion = 0 OR IdUbicacion = @IdUbicacion ))AS ss_hc_ubicacion 
            WHERE  ( @INICIO IS NULL OR @NUMEROFILAS IS NULL ) OR ( rownumber BETWEEN @INICIO AND @NUMEROFILAS ) 
        END 
      ELSE IF( @Accion = 'LISTARPAGSELEC' ) 
        BEGIN             

            SELECT @CONTADOR = Count(*) 
            FROM   ss_hc_ubicacion 
            WHERE  ( @Codigo IS NULL OR Upper(codigo) LIKE '%' + Upper(@Codigo) + '%' ) 
					AND ( @UnidadReplicacion IS NULL OR UnidadReplicacion = @UnidadReplicacion OR @UnidadReplicacion = '' ) 
					AND ( @TipoUbicacion IS NULL OR TipoUbicacion = @TipoUbicacion  )       
            
                   AND ( @Nombre IS NULL OR Upper(nombre) LIKE '%' + Upper(@Nombre) + '%' ) 
                   AND ( @Descripcion IS NULL OR Upper(descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                   

            SELECT SS_HC_Ubicacion.unidadreplicacion, 
                   SS_HC_Ubicacion.idubicacion, 
                   SS_HC_Ubicacion.idubicacionpadre, 
                   SS_HC_Ubicacion.codigo, 
                   SS_HC_Ubicacion.nombre, 
                   SS_HC_Ubicacion.descripcion, 
                   SS_HC_Ubicacion.tipoubicacion, 
                   SS_HC_Ubicacion.ruta, 
                   SS_HC_Ubicacion.ordenruta, 
                   SS_HC_Ubicacion.orden, 
                   SS_HC_Ubicacion.nivel, 
                   SS_HC_Ubicacion.cadenarecursividad, 
                   estadoX as estado, 
                   SS_HC_Ubicacion.usuariocreacion, 
                   SS_HC_Ubicacion.fechacreacion, 
                   SS_HC_Ubicacion.usuariomodificacion, 
                   SS_HC_Ubicacion.fechamodificacion, 
                   SS_HC_Ubicacion.rutadescripcion, 
                   SS_HC_Ubicacion.accion 
            FROM  (SELECT 
						ss_hc_ubicacion.*,
						(case when @IdUbicacion = ss_hc_ubicacion.IdUbicacion
							then  -2 else ss_hc_ubicacion.Estado
						end) AS estadoX,            
                          @CONTADOR                AS CONTADOR, 
                          Row_number() 
                            OVER( 
                              ORDER BY codigo ASC) AS ROWNUMBER 
                   FROM   ss_hc_ubicacion 
                   WHERE  ( @Codigo IS NULL OR Upper(codigo) LIKE '%' + Upper(@Codigo) + '%' ) 
					AND ( @UnidadReplicacion IS NULL OR UnidadReplicacion = @UnidadReplicacion OR @UnidadReplicacion = '' ) 
					AND ( @TipoUbicacion IS NULL OR TipoUbicacion = @TipoUbicacion  )       
                   
                          AND ( @Nombre IS NULL OR Upper(nombre) LIKE '%' + Upper(@Nombre) + '%' ) 
                          AND ( @Descripcion IS NULL OR Upper(descripcion) LIKE '%' + Upper(@Descripcion) + '%' )
                 
				)AS ss_hc_ubicacion 
            WHERE  ( @INICIO IS NULL OR @NUMEROFILAS IS NULL ) OR ( rownumber BETWEEN @INICIO AND @NUMEROFILAS ) 
        END         
        
  END 
/*  
EXEC SP_SS_HC_UbicacionListar  
NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,  
NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
NULL  
*/ 
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_UnidadMedidaMinsa]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER PROCEDURE [SP_SS_HC_UnidadMedidaMinsa]

	@IdUnidadMedida int,
	@Codigo varchar(15),	
	@Nombre varchar(150),
	@Simbolo varchar(15),	
	@Estado int,
	@UsuarioCreacion varchar(15),
	@FechaCreacion datetime,
	@UsuarioModificacion varchar(25),
	@FechaModificacion datetime,
	@Accion varchar(25),	
	@Version varchar(25)

AS 
  BEGIN 
      SET nocount ON; 

      IF @Accion = 'INSERT' 
        BEGIN 
            SELECT @IdUnidadMedida = Isnull(Max(IdUnidadMedida), 0) + 1 FROM   dbo.SS_HC_UnidadMedidaMinsa  
            INSERT INTO SS_HC_UnidadMedidaMinsa 
                        (IdUnidadMedida, 
                         Codigo, 
                         Nombre, 
                         Simbolo,                         
                         estado, 
                         usuariocreacion, 
                         fechacreacion, 
                         usuariomodificacion, 
                         fechamodificacion, 
                         accion, 
                         version) 
            VALUES      ( @IdUnidadMedida, 
                          @Codigo, 
                          @Nombre, 
                          @Simbolo,                          
                          @Estado, 
                          @UsuarioCreacion, 
                          Getdate(), 
                          @UsuarioModificacion, 
                          Getdate(), 
                          @Accion, 
                          @Version ) 

            SELECT 1 
        END 
      ELSE IF @Accion = 'UPDATE' 
        BEGIN 
            UPDATE SS_HC_UnidadMedidaMinsa 
            SET    IdUnidadMedida = @IdUnidadMedida, 
                   codigo = @Codigo, 
                   Nombre = @Nombre, 
                   simbolo = @Simbolo,                    
                   estado = @Estado, 
                 --  usuariocreacion = @UsuarioCreacion, 
                  -- fechacreacion = @FechaCreacion, 
                   usuariomodificacion = @UsuarioModificacion, 
                   fechamodificacion = GETDATE(), 
                   accion = @Accion, 
                   version = @Version 
            WHERE  ( SS_HC_UnidadMedidaMinsa.IdUnidadMedida = @IdUnidadMedida ) 

            SELECT 1 
        END 
      ELSE IF @Accion = 'DELETE' 
        BEGIN 
            DELETE FROM SS_HC_UnidadMedidaMinsa 
            WHERE  ( SS_HC_UnidadMedidaMinsa.IdUnidadMedida = @IdUnidadMedida ) 

            SELECT 1 
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_UnidadMedidaMinsa 
                             WHERE  ( @Nombre IS NULL OR Upper(SS_HC_UnidadMedidaMinsa.Nombre) LIKE '%' + Upper(@Nombre) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_UnidadMedidaMinsa.estado = @Estado OR @Estado = 0 ) 
                                    AND ( @Codigo IS NULL OR Upper(SS_HC_UnidadMedidaMinsa.codigo) LIKE '%' + Upper(@Codigo) + '%' )                                    
                                    AND ( @IdUnidadMedida IS NULL OR SS_HC_UnidadMedidaMinsa.IdUnidadMedida = @IdUnidadMedida OR @IdUnidadMedida = 0 )) 

            SELECT @CONTADOR; 
        END 
  END 
/*   
EXEC SP_SS_HC_NIC   
NULL,NULL, NULL, NULL, NULL,   
1, NULL, NULL, NULL, NULL,   
NULL, NULL, NULL, LISTARPAG, NULL   
*/ 


GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_UnidadMedidaMinsa_LISTAR]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_UnidadMedidaMinsa_LISTAR]
(
	@IdUnidadMedida int,
	@Codigo varchar(15),	
	@Nombre varchar(150),
	@Simbolo varchar(15),	
	@Estado int,
	@UsuarioCreacion varchar(15),
	@FechaCreacion datetime,
	@UsuarioModificacion varchar(25),
	@FechaModificacion datetime,
	@Accion varchar(25),	
	@Version varchar(25),		
	@INICIO   int= null,  
	@NUMEROFILAS int = null 
)
AS
BEGIN    
IF(@Accion = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR=(SELECT COUNT(IdUnidadMedida) FROM SS_HC_UnidadMedidaMinsa
	 					WHERE 
					(@IdUnidadMedida is null OR (IdUnidadMedida = @IdUnidadMedida) or @IdUnidadMedida =0)
					AND( @Nombre IS NULL OR Upper(Nombre) LIKE '%' + Upper(@Nombre) + '%' ) 
                    AND ( @Estado IS NULL OR estado = @Estado OR @Estado = 0 ) 
                    AND ( @Codigo IS NULL OR Upper(codigo) LIKE '%' + Upper(@Codigo) + '%' ) 
                    
					)
		SELECT
			IdUnidadMedida
		  ,Codigo
		  ,Nombre
		  ,Simbolo		  
		  ,Estado
		  ,UsuarioCreacion
		  ,FechaCreacion
		  ,UsuarioModificacion
		  ,FechaModificacion
		  ,Accion
		  ,[Version]
		FROM (		
			SELECT
		  IdUnidadMedida
		  ,Codigo
		  ,Nombre
		  ,Simbolo		  
		  ,Estado
		  ,UsuarioCreacion
		  ,FechaCreacion
		  ,UsuarioModificacion
		  ,FechaModificacion
		  ,Accion
		  ,[Version]
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY IdUnidadMedida ASC ) AS RowNumber   	
					FROM SS_HC_UnidadMedidaMinsa	
					WHERE 
						(@IdUnidadMedida is null OR (IdUnidadMedida = @IdUnidadMedida) or @IdUnidadMedida =0)
					AND( @Nombre IS NULL OR Upper(Nombre) LIKE '%' + Upper(@Nombre) + '%' ) 
                    AND ( @Estado IS NULL OR estado = @Estado OR @Estado = 0 ) 
                    AND ( @Codigo IS NULL OR Upper(codigo) LIKE '%' + Upper(@Codigo) + '%' ) 
                   
 
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		
       END
       ELSE
 IF @Accion ='LISTAR'    
    BEGIN    
		SELECT
		  IdUnidadMedida
		  ,Codigo
		  ,Nombre
		  ,Simbolo		  
		  ,Estado
		  ,UsuarioCreacion
		  ,FechaCreacion
		  ,UsuarioModificacion
		  ,FechaModificacion
		  ,Accion
		  ,[Version]
			FROM SS_HC_UnidadMedidaMinsa
				WHERE 
						(@IdUnidadMedida is null OR (IdUnidadMedida = @IdUnidadMedida) or @IdUnidadMedida =0)
					AND( @Nombre IS NULL OR Upper(Nombre) LIKE '%' + Upper(@Nombre) + '%' ) 
                    AND ( @Estado IS NULL OR estado = @Estado OR @Estado = 0 ) 
                    AND ( @Codigo IS NULL OR Upper(codigo) LIKE '%' + Upper(@Codigo) + '%' ) 
	end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 
					*					
				from 
				SS_HC_UnidadMedidaMinsa
								WHERE 
							(IdUnidadMedida = @IdUnidadMedida)			

	end	
END

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_UnidadServicio]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================             
-- Author:    Grace Córdova             
-- Create date: 18/09/2015      
-- =============================================       
CREATE OR ALTER PROCEDURE [SP_SS_HC_UnidadServicio]   
@IdEstablecimientoSalud INT,   
@IdUnidadServicio       INT,   
@IdServicio             INT,   
@Codigo                 VARCHAR(15),   
@Descripcion            VARCHAR(150),   
  
@IndicadorTriaje        INT,  --AUX para TIPOATENCIÓN  
@Estado                 INT,   
@UsuarioCreacion        VARCHAR(25),   
@FechaCreacion          DATETIME,   
@UsuarioModificacion    VARCHAR(25),   
  
@FechaModificacion      DATETIME,   
@Accion                 VARCHAR(25)   
AS   
  BEGIN   
      IF ( @Accion = 'INSERT' )   
        BEGIN   
            --select @idservicio = isnull(MAX(idservicio),0)+1 from ss_ge_servicio      
            INSERT INTO ss_hc_unidadservicio   
                        (idestablecimientosalud,   
                         idunidadservicio,   
                         idservicio,   
                         codigo,   
                         descripcion,   
                         indicadortriaje,   
                         estado,   
                         usuariocreacion,   
                         fechacreacion,   
                         usuariomodificacion,   
                         fechamodificacion,   
                         accion)   
            VALUES      ( @IdEstablecimientoSalud,   
                          @IdUnidadServicio,   
                          @IdServicio,   
                          @Codigo,   
                          @Descripcion,   
                          @IndicadorTriaje,   
                          @Estado,   
                          @UsuarioCreacion,   
                          Getdate(),   
                          @UsuarioModificacion,   
                          Getdate(),   
                          @Accion )   
            SELECT 1   
        END   
      ELSE IF ( @Accion = 'UPDATE' )   
        BEGIN   
        PRINT @IdServicio
            UPDATE ss_hc_unidadservicio   
            SET    idestablecimientosalud = @IdEstablecimientoSalud,   
                   idunidadservicio = @IdUnidadServicio,   
                   idservicio = @IdServicio,   
                   codigo = @Codigo,   
                   descripcion = @Descripcion,   
                   indicadortriaje = @IndicadorTriaje,   
                   estado = @Estado,   
                   usuariomodificacion = @UsuarioModificacion,   
                   fechamodificacion = GETDATE(),   
                   accion = @Accion   
            WHERE  idestablecimientosalud = @IdEstablecimientoSalud   
                   AND idunidadservicio = @IdUnidadServicio   
            SELECT 1   
        END   
      ELSE IF ( @Accion = 'DELETE' )   
        BEGIN   
            DELETE ss_hc_unidadservicio   
            WHERE  idestablecimientosalud = @IdEstablecimientoSalud   
                   AND idunidadservicio = @IdUnidadServicio  
            SELECT 1   
        END   
      ELSE IF ( @Accion = 'LISTARPAG' )   
        BEGIN   
            DECLARE @CONTADOR INT   
  
            SELECT @CONTADOR = Count(*)   
            FROM   ss_hc_unidadservicio  as UnidadServ  
            WHERE  ( @IdEstablecimientoSalud IS NULL OR idestablecimientosalud = @IdEstablecimientoSalud OR @IdEstablecimientoSalud = 0 )   
                   AND ( @IdUnidadServicio IS NULL OR idunidadservicio = @IdUnidadServicio OR @IdUnidadServicio = 0 )   
                   AND ( @Descripcion IS NULL OR @Descripcion = '' OR Rtrim(Upper(UnidadServ.descripcion)) LIKE '%' + Rtrim(Upper(@Descripcion)) + '%' )   
                   AND ( @Codigo IS NULL OR @Codigo = '' OR Rtrim(Upper(UnidadServ.Codigo)) LIKE '%' + Rtrim(Upper(@Codigo)) + '%' )   
                           ------FILTRO TIPO ATENCIÓN AUX  
                           AND (@IndicadorTriaje is null or @IndicadorTriaje =0  
        or @IndicadorTriaje in (  
         select IdTipoAtencion   
         from dbo.SS_HC_CatalogoUnidadServicio_TipoAtencion  
         where SS_HC_CatalogoUnidadServicio_TipoAtencion.IdUnidadServicio =  
          UnidadServ.IdUnidadServicio  
        )          
        )  
       --------------------------                                       
                                       
            SELECT @CONTADOR   
        END   
  END   
/*      
EXEC SP_SS_HC_UnidadServicio      
1,4,4,'prueba','prueba',      
NULL,2,'ROYAL',NULL,'ROYAL',      
NULL,'UPDATE'      
*/ 
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_UnidadServicioListar]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================            
-- Author:    Grace Córdova            
-- Create date: 18/09/2015     
-- =============================================      
CREATE OR ALTER PROCEDURE [SP_SS_HC_UnidadServicioListar] 
@IdEstablecimientoSalud INT, 
@IdUnidadServicio       INT, 
@IdServicio             INT, 
@Codigo                 VARCHAR(15), 
@Descripcion            VARCHAR(150), 

@IndicadorTriaje        INT, 
@Estado                 INT, 
@UsuarioCreacion        VARCHAR(25), 
@FechaCreacion          DATETIME, 
@UsuarioModificacion    VARCHAR(25), 

@FechaModificacion      DATETIME, 
@Accion                 VARCHAR(25), 
@INICIO                 INT= NULL, 
@NUMEROFILAS            INT = NULL 
AS 
  BEGIN 
      IF ( @Accion = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SELECT @CONTADOR = Count(*) 
            FROM   ss_hc_unidadservicio 
            WHERE  ( @IdEstablecimientoSalud IS NULL OR idestablecimientosalud = @IdEstablecimientoSalud OR @IdEstablecimientoSalud = 0 ) 
                   AND ( @IdUnidadServicio IS NULL OR idunidadservicio = @IdUnidadServicio OR @IdUnidadServicio = 0 ) 
                   AND ( @Descripcion IS NULL OR @Descripcion = '' OR Rtrim(Upper(ss_hc_unidadservicio.descripcion)) LIKE '%' + Rtrim(Upper(@Descripcion)) + '%' ) 
                   AND ( @Codigo IS NULL OR @Codigo = '' OR Rtrim(Upper(ss_hc_unidadservicio.Codigo)) LIKE '%' + Rtrim(Upper(@Codigo)) + '%' ) 

            SELECT idestablecimientosalud, 
                   idunidadservicio, 
                   idservicio, 
                   codigo, 
                   descripcion, 
                   indicadortriaje, 
                   estado, 
                   usuariocreacion, 
                   fechacreacion, 
                   usuariomodificacion, 
                   fechamodificacion, 
                   accion 
            FROM   (SELECT idestablecimientosalud, 
                           idunidadservicio, 
                           idservicio, 
                           codigo, 
                           descripcion, 
                           indicadortriaje, 
                           estado, 
                           usuariocreacion, 
                           fechacreacion, 
                           usuariomodificacion, 
                           fechamodificacion, 
                           accion, 
                           @CONTADOR                AS CONTADOR, 
                           Row_number() 
                             OVER( 
                               ORDER BY idservicio) AS ROWNUMBER 
                    FROM   ss_hc_unidadservicio 
                    WHERE  ( @IdEstablecimientoSalud IS NULL OR idestablecimientosalud = @IdEstablecimientoSalud OR @IdEstablecimientoSalud = 0 ) 
                           AND ( @IdUnidadServicio IS NULL OR idunidadservicio = @IdUnidadServicio OR @IdUnidadServicio = 0 ) 
                           AND ( @Descripcion IS NULL OR @Descripcion = '' OR Rtrim(Upper(ss_hc_unidadservicio.descripcion)) LIKE '%' + Rtrim(Upper(@Descripcion)) + '%' )
                           AND ( @Codigo IS NULL OR @Codigo = '' OR Rtrim(Upper(ss_hc_unidadservicio.Codigo)) LIKE '%' + Rtrim(Upper(@Codigo)) + '%' ) )AS LISTADO 
            WHERE  ( @INICIO IS NULL AND @NUMEROFILAS IS NULL ) 
                    OR ( rownumber BETWEEN @INICIO AND @NUMEROFILAS ) 
        END 
      ELSE IF ( @Accion = 'LISTAR' ) 
        BEGIN 
            SELECT idestablecimientosalud, 
                   idunidadservicio, 
                   idservicio, 
                   codigo, 
                   descripcion, 
                   indicadortriaje, 
                   estado, 
                   usuariocreacion, 
                   fechacreacion, 
                   usuariomodificacion, 
                   fechamodificacion, 
                   accion 
            FROM   ss_hc_unidadservicio 
            WHERE  ( @IdEstablecimientoSalud IS NULL OR IdEstablecimientoSalud = @IdEstablecimientoSalud OR @IdEstablecimientoSalud = 0 ) 
                   AND ( @IdUnidadServicio IS NULL OR IdUnidadServicio = @IdUnidadServicio OR @IdUnidadServicio = 0 ) 
                   AND ( @Descripcion IS NULL OR @Descripcion = '' OR Rtrim(Upper(ss_hc_unidadservicio.descripcion)) LIKE '%' + Rtrim(Upper(@Descripcion)) + '%' ) 
                   AND ( @Codigo IS NULL OR @Codigo = '' OR Rtrim(Upper(ss_hc_unidadservicio.Codigo)) LIKE '%' + Rtrim(Upper(@Codigo)) + '%' ) 
        END
        ELSE IF ( @Accion = 'LISTARDOS' ) 
        BEGIN 
            SELECT idestablecimientosalud, 
                   idunidadservicio, 
                   idservicio, 
                   codigo, 
                   descripcion, 
                   indicadortriaje, 
                   estado, 
                   usuariocreacion, 
                   fechacreacion, 
                   usuariomodificacion, 
                   fechamodificacion, 
                   accion 
            FROM   ss_hc_unidadservicio 
            WHERE  ( @IdEstablecimientoSalud IS NULL OR IdEstablecimientoSalud = @IdEstablecimientoSalud OR @IdEstablecimientoSalud = 0 ) 
                   AND ( @IdUnidadServicio IS NULL OR IdUnidadServicio = @IdUnidadServicio OR @IdUnidadServicio = 0 ) 
                   AND ( @Descripcion IS NULL OR @Descripcion = '' OR Rtrim(Upper(ss_hc_unidadservicio.descripcion)) LIKE '%' + Rtrim(Upper(@Descripcion)) + '%' ) 
                   AND ( @Codigo IS NULL OR @Codigo = ss_hc_unidadservicio.Codigo) 
        END 
  END 
/*    
EXEC SP_SS_HC_UnidadServicioListar    
NULL,NULL,NULL,NULL,NULL,    
NULL,NULL,NULL,NULL,NULL,    
NULL,'LISTARPAG',0,15    
*/ 
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_UTILES_TRANSACT]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_UTILES_TRANSACT]
(
	@UnidadReplicacion	char(4) ,
	@IdEpisodioAtencion	bigint ,	
	@IdPaciente	int ,
	@EpisodioClinico	int ,	
	@IdEstablecimientoSalud	int ,
	
	@IdUnidadServicio	int ,
	@IdPersonalSalud	int ,	
	@EpisodioAtencion	bigint ,	
	@FechaRegistro	datetime ,
	@FechaAtencion	datetime ,
	
	@TipoAtencion	int ,
	@IdOrdenAtencion	int ,
	@LineaOrdenAtencion	int ,	
	@TipoOrdenAtencion	int ,
	@Estado	int ,
	
	@IdEspecialidad	int ,
	@CodigoOA	varchar(15) ,
	@TipoTrabajador varchar(10),
    @TipoEpisodio	varchar(20) ,	
	
	@ACCION	varchar(30) 
			
)

AS
BEGIN 
SET NOCOUNT ON;
BEGIN  TRANSACTION
	
	if(@ACCION = 'DELETE_ATENCION_FULL')
	begin				
		/**************************************************************/
		/**SCRIPT PARA LIMIPIRA TRANSACCIONES HCE*/
		/**************************************************************/

		/**EEXAMENS TECNOLOGO*/
		delete SS_HC_ProcedimientoInforme
		where 
		(UnidadReplicacion=@UnidadReplicacion)
		and (IdPaciente = @IdPaciente)
		and (@EpisodioClinico is null OR @EpisodioClinico = 0 OR EpisodioClinico=@EpisodioClinico)
		and (@IdEpisodioAtencion is null OR @IdEpisodioAtencion = 0 OR IdEpisodioAtencion=@IdEpisodioAtencion)		
		
		delete  SS_HC_ProcedimientoEjecucionDetalle
		where 
		(UnidadReplicacion=@UnidadReplicacion)
		and (IdPaciente = @IdPaciente)
		and (@EpisodioClinico is null OR @EpisodioClinico = 0 OR EpisodioClinico=@EpisodioClinico)
		and (@IdEpisodioAtencion is null OR @IdEpisodioAtencion = 0 OR IdEpisodioAtencion=@IdEpisodioAtencion)		
		
		delete SS_HC_ProcedimientoEjecucion
		where 
		(UnidadReplicacion=@UnidadReplicacion)
		and (IdPaciente = @IdPaciente)
		and (@EpisodioClinico is null OR @EpisodioClinico = 0 OR EpisodioClinico=@EpisodioClinico)
		and (@IdEpisodioAtencion is null OR @IdEpisodioAtencion = 0 OR IdEpisodioAtencion=@IdEpisodioAtencion)		
		


		/***Ananmnessis  CCEP0003****/
		delete SS_HC_Anamnesis_EA_Sintoma 
		where 
		(UnidadReplicacion=@UnidadReplicacion)
		and (IdPaciente = @IdPaciente)
		and (@EpisodioClinico is null OR @EpisodioClinico = 0 OR EpisodioClinico=@EpisodioClinico)
		and (@IdEpisodioAtencion is null OR @IdEpisodioAtencion = 0 OR IdEpisodioAtencion=@IdEpisodioAtencion)		
		
		delete SS_HC_Anamnesis_EA  
		where 
		(UnidadReplicacion=@UnidadReplicacion)
		and (IdPaciente = @IdPaciente)
		and (@EpisodioClinico is null OR @EpisodioClinico = 0 OR EpisodioClinico=@EpisodioClinico)
		and (@IdEpisodioAtencion is null OR @IdEpisodioAtencion = 0 OR IdEpisodioAtencion=@IdEpisodioAtencion)		


		/***Ananmnessis CCEP0004****/
		delete SS_HC_Anamnesis_AP_Detalle 
		where 
		(UnidadReplicacion=@UnidadReplicacion)
		and (IdPaciente = @IdPaciente)
		and (@EpisodioClinico is null OR @EpisodioClinico = 0 OR EpisodioClinico=@EpisodioClinico)
		and (@IdEpisodioAtencion is null OR @IdEpisodioAtencion = 0 OR IdEpisodioAtencion=@IdEpisodioAtencion)		
		
		delete SS_HC_Anamnesis_AP  
		where 
		(UnidadReplicacion=@UnidadReplicacion)
		and (IdPaciente = @IdPaciente)
		and (@EpisodioClinico is null OR @EpisodioClinico = 0 OR EpisodioClinico=@EpisodioClinico)
		and (@IdEpisodioAtencion is null OR @IdEpisodioAtencion = 0 OR IdEpisodioAtencion=@IdEpisodioAtencion)		
		

		/***Ananmnessis ante famil  CCEP0005****/
		delete SS_HC_Anamnesis_AF_Enfermedad
		where 
		(UnidadReplicacion=@UnidadReplicacion)
		and (IdPaciente = @IdPaciente)
		and (@EpisodioClinico is null OR @EpisodioClinico = 0 OR EpisodioClinico=@EpisodioClinico)
		and (@IdEpisodioAtencion is null OR @IdEpisodioAtencion = 0 OR IdEpisodioAtencion=@IdEpisodioAtencion)		
		
		delete SS_HC_Anamnesis_AF 
		where 
		(UnidadReplicacion=@UnidadReplicacion)
		and (IdPaciente = @IdPaciente)
		and (@EpisodioClinico is null OR @EpisodioClinico = 0 OR EpisodioClinico=@EpisodioClinico)
		and (@IdEpisodioAtencion is null OR @IdEpisodioAtencion = 0 OR IdEpisodioAtencion=@IdEpisodioAtencion)		
		
		       
		/***Triaje CCEP0102****/       
		delete SS_HC_ExamenFisico_Triaje
		where 
		(UnidadReplicacion=@UnidadReplicacion)
		and (IdPaciente = @IdPaciente)
		and (@EpisodioClinico is null OR @EpisodioClinico = 0 OR EpisodioClinico=@EpisodioClinico)
		and (@IdEpisodioAtencion is null OR @IdEpisodioAtencion = 0 OR IdEpisodioAtencion=@IdEpisodioAtencion)		
		

		/***Exam por regiones  CCEP0104****/   
		delete SS_HC_ExamenFisico_Regional
		where 
		(UnidadReplicacion=@UnidadReplicacion)
		and (IdPaciente = @IdPaciente)
		and (@EpisodioClinico is null OR @EpisodioClinico = 0 OR EpisodioClinico=@EpisodioClinico)
		and (@IdEpisodioAtencion is null OR @IdEpisodioAtencion = 0 OR IdEpisodioAtencion=@IdEpisodioAtencion)				

		/***Est. diagnostico  CCEP0253****/       
		delete SS_HC_Diagnostico
		where 
		(UnidadReplicacion=@UnidadReplicacion)
		and (IdPaciente = @IdPaciente)
		and (@EpisodioClinico is null OR @EpisodioClinico = 0 OR EpisodioClinico=@EpisodioClinico)
		and (@IdEpisodioAtencion is null OR @IdEpisodioAtencion = 0 OR IdEpisodioAtencion=@IdEpisodioAtencion)		
		

		/***Seg riesgos  CCEP0302****/       
		delete SS_HC_SeguimientoRiesgoDetalle
		where 
		(UnidadReplicacion=@UnidadReplicacion)
		and (IdPaciente = @IdPaciente)
		and (@EpisodioClinico is null OR @EpisodioClinico = 0 OR EpisodioClinico=@EpisodioClinico)
		and (@IdEpisodioAtencion is null OR @IdEpisodioAtencion = 0 OR IdEpisodioAtencion=@IdEpisodioAtencion)		
		
		delete SS_HC_SeguimientoRiesgo
		where 
		(UnidadReplicacion=@UnidadReplicacion)
		and (IdPaciente = @IdPaciente)
		and (@EpisodioClinico is null OR @EpisodioClinico = 0 OR EpisodioClinico=@EpisodioClinico)
		and (@IdEpisodioAtencion is null OR @IdEpisodioAtencion = 0 OR IdEpisodioAtencion=@IdEpisodioAtencion)				

		/***Med. Micron y dietas  CCEP0303****/              
		/***Medicamentos  CCEP0304****/              
		delete SS_HC_Indicaciones
		where 
		(UnidadReplicacion=@UnidadReplicacion)
		and (IdPaciente = @IdPaciente)
		and (@EpisodioClinico is null OR @EpisodioClinico = 0 OR EpisodioClinico=@EpisodioClinico)
		and (@IdEpisodioAtencion is null OR @IdEpisodioAtencion = 0 OR IdEpisodioAtencion=@IdEpisodioAtencion)		
		
		delete SS_HC_Medicamento
		where 
		(UnidadReplicacion=@UnidadReplicacion)
		and (IdPaciente = @IdPaciente)
		and (@EpisodioClinico is null OR @EpisodioClinico = 0 OR EpisodioClinico=@EpisodioClinico)
		and (@IdEpisodioAtencion is null OR @IdEpisodioAtencion = 0 OR IdEpisodioAtencion=@IdEpisodioAtencion)		
		
		       
		/***Exam. auxiliares  CCEP0306****/                     
		delete SS_HC_ExamenSolicitado
		where 
		(UnidadReplicacion=@UnidadReplicacion)
		and (IdPaciente = @IdPaciente)
		and (@EpisodioClinico is null OR @EpisodioClinico = 0 OR EpisodioClinico=@EpisodioClinico)
		and (@IdEpisodioAtencion is null OR @IdEpisodioAtencion = 0 OR IdEpisodioAtencion=@IdEpisodioAtencion)		
		
		       
		/***Prox cita CCEP0311****/       
		/***Orden internam/Cirugia  CCEP0312****/       
		/***Realizar interconsulta  CCEP0314****/              
		/***Ref a otros estableci. CCEP0315****/                     
		delete SS_HC_ProximaAtencionDiagnostico
		where 
		(UnidadReplicacion=@UnidadReplicacion)
		and (IdPaciente = @IdPaciente)
		and (@EpisodioClinico is null OR @EpisodioClinico = 0 OR EpisodioClinico=@EpisodioClinico)
		and (@IdEpisodioAtencion is null OR @IdEpisodioAtencion = 0 OR IdEpisodioAtencion=@IdEpisodioAtencion)		
		
		delete SS_HC_ProximaAtencion 
		where 
		(UnidadReplicacion=@UnidadReplicacion)
		and (IdPaciente = @IdPaciente)
		and (@EpisodioClinico is null OR @EpisodioClinico = 0 OR EpisodioClinico=@EpisodioClinico)
		and (@IdEpisodioAtencion is null OR @IdEpisodioAtencion = 0 OR IdEpisodioAtencion=@IdEpisodioAtencion)				


		/***Descanso medico  CCEP0313****/       
		delete SS_HC_DescansoMedico 
		where 
		(UnidadReplicacion=@UnidadReplicacion)
		and (IdPaciente = @IdPaciente)
		and (@EpisodioClinico is null OR @EpisodioClinico = 0 OR EpisodioClinico=@EpisodioClinico)
		and (@IdEpisodioAtencion is null OR @IdEpisodioAtencion = 0 OR IdEpisodioAtencion=@IdEpisodioAtencion)			


		/***EPISODIOS**/
		delete dbo.SS_HC_EpisodioAtencion
		where 
		(UnidadReplicacion=@UnidadReplicacion)
		and (IdPaciente = @IdPaciente)
		and (@EpisodioClinico is null OR @EpisodioClinico = 0 OR EpisodioClinico=@EpisodioClinico)
		and (@IdEpisodioAtencion is null OR @IdEpisodioAtencion = 0 OR IdEpisodioAtencion=@IdEpisodioAtencion)		
		
		delete dbo.SS_HC_EpisodioAtencionMaster
		where 
		(UnidadReplicacion=@UnidadReplicacion)
		and (IdPaciente = @IdPaciente)
		and (@EpisodioClinico is null OR @EpisodioClinico = 0 OR EpisodioClinico=@EpisodioClinico)
		and (@EpisodioAtencion is null OR @EpisodioAtencion = 0 OR EpisodioAtencion=@EpisodioAtencion)		
		
		delete dbo.SS_HC_EpisodioClinico
		where 
		(UnidadReplicacion=@UnidadReplicacion)
		and (IdPaciente = @IdPaciente)
		and (@EpisodioClinico is null OR @EpisodioClinico = 0 OR EpisodioClinico=@EpisodioClinico)			


	end		
	
commit		
END	

/*
exec SP_SS_HC_UTILES_TRANSACT
	'CEG',NULL,1265,NULL,NULL,	 NULL,NULL,NULL,NULL,NULL,   NULL,NULL,NULL,NULL,NULL,    NULL,NULL,NULL,NULL,							
	'DELETE_ATENCION_FULL'
	
*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_VW_TABLAFORMATO_VALIDACION]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_VW_TABLAFORMATO_VALIDACION]
(	
      @IdFormato		int 
      ,@FormatoNivelID		int	
      ,@IdFormatoPadre		int	 
      ,@CodigoFormato		varchar(20)
      ,@CodigoFormatoPadre		varchar(20)    
      
      ,@DescripcionFormato		varchar(100)
      ,@TipoFormato		int	
      ,@EstadoFormato		int	
      ,@IdFavoritoTabla		int
      ,@NombreTabla		varchar(128)
      
      ,@DescripcionTabla		varchar(100)
      ,@TipoTabla		int
      ,@EstadoTabla		int
      ,@IdCampo		int	
      ,@NombreCampo		varchar(128)
      
      ,@DescripcionCampo		varchar(100)
      ,@TipoCampo		int
      ,@Longitud		int
      ,@Decimales		int
      ,@EstadoTablaCampo		int   
      
      ,@SecuenciaCampo		int
      ,@IdSeccionFormato		int
      ,@ValorPorDefecto		varchar(100)
      ,@IndicadorObligatorio		int
      ,@IndicadorCampoCalculado		int
      
      ,@Formula		varchar(500)
      ,@IndicadorValoresVarios		int
      ,@TablaValoresVarios		varchar(15)
      ,@IndicadorRango		int
      ,@RangoDesde		decimal(20,6)
      
      ,@RangoHasta		decimal(20,6)
      ,@IndicadorReglaNegocio		char(10)
      ,@ReglaNegocio		varchar(100)
      ,@Observaciones		varchar(500)
      ,@EstadoFormatoCampo		int
      
      ,@IdConcepto		int
      ,@IdAgrupadorNivel		int   
      ,@IdObjetoAgrupador		int
      ,@IdColumna		int
      ,@IdFila		int
      
      ,@IdEvento		int
      ,@IdParameterEnvio		int   
      ,@Orden		int
      ,@IdAgrupadorNivelPadre		int
      ,@SecuenciaValidacion		int
      
      ,@IdComponente		int
      ,@IdAtributo		int
      ,@TipoValidacion		varchar(10) 
      ,@FlagTipoDato		varchar(1)
      ,@ValorTexto		varchar(200)
      
      ,@ValorNumerico		numeric(10,2)
      ,@ValorDate		datetime
      ,@SecuenciaValidacionRef int
      ,@EstadoValidacion		int
      ,@UsuarioCreacion		varchar(25)
      
      ,@FechaCreacion		datetime      
      ,@UsuarioModificacion		varchar(25)
      ,@FechaModificacion		datetime           
      ,@Version			varchar(25)
      ,@NombreComponente		varchar(200)
      
      ,@TipoComponente		varchar(10)
      ,@EstadoComponente		int
      ,@NombreAtributo		varchar(200)
      ,@EstadoAtributo		int
       ,@IdiomaProperty		varchar(200)
	
		,@Inicio	int,
		@NumeroFilas	int,
		@ACCION	varchar(25) 
			
)

AS
BEGIN
	if(@ACCION = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR=(SELECT COUNT(*) 				
					from 
				VW_SS_HC_TABLAFORMATO_VALIDACION
 					WHERE 
					(@IdFormato is null OR (IdFormato = @IdFormato) or @IdFormato =0)
					and (@SecuenciaCampo is null OR (SecuenciaCampo = @SecuenciaCampo) or @SecuenciaCampo =0)
					and (@SecuenciaValidacion is null OR (@SecuenciaValidacion = SecuenciaValidacion) or @SecuenciaValidacion =0)					
					and (@NombreComponente is null  OR @NombreComponente =''  OR  upper(NombreComponente) like '%'+upper(@NombreComponente)+'%')
	
					)
					
		select @CONTADOR
	end	
	
else 
	if(@ACCION = 'LISTARPAGVALIDACION')
	begin		
	DECLARE @CONTADORVALIDA INT
	
		SET @CONTADORVALIDA=(
				SELECT COUNT(*) FROM
					VW_SS_HC_TABLAFORMATO_VALIDACION
					inner join  SS_HC_ControlValidacion 
					on SS_HC_ControlValidacion.idFormato = VW_SS_HC_TABLAFORMATO_VALIDACION.idFormato
					and SS_HC_ControlValidacion.SecuenciaCampo = VW_SS_HC_TABLAFORMATO_VALIDACION.SecuenciaCampo
					and SS_HC_ControlValidacion.SecuenciaValidacion = VW_SS_HC_TABLAFORMATO_VALIDACION.SecuenciaValidacion			
 					WHERE 
					    (@IdFormato is null OR (SS_HC_ControlValidacion.IdFormato = @IdFormato) or @IdFormato =0)
					and (@DescripcionFormato is null  OR @DescripcionFormato =''  OR  upper(DescripcionFormato) like '%'+upper(@DescripcionFormato)+'%')
					and (@IdComponente is null OR (SS_HC_ControlValidacion.IdComponente = @IdComponente) or @IdComponente =0)
					and (@IdAtributo is null OR (SS_HC_ControlValidacion.IdAtributo = @IdAtributo) or @IdAtributo =0)
					and (@ValorPorDefecto is null  OR @ValorPorDefecto =''  OR  upper(ValorPorDefecto) like '%'+upper(@ValorPorDefecto)+'%')
					and (@EstadoValidacion is null OR EstadoValidacion = @EstadoValidacion)  						
				
		)
								
				SELECT @CONTADORVALIDA
				END
	
END
/*
exec [SP_SS_HC_VW_TABLAFORMATO_VALIDACION]
		NULL,NULL,NULL,NULL,NULL,
		NULL,NULL,NULL,NULL,NULL,      
		NULL,NULL,NULL,NULL,NULL,            
		NULL,NULL,NULL,NULL,NULL,            
		NULL,NULL,NULL,NULL,NULL,            
		NULL,NULL,NULL,NULL,NULL,            
		NULL,NULL,NULL,NULL,NULL,            
		NULL,NULL,NULL,NULL,NULL,            
		NULL,NULL,NULL,NULL,NULL,            
		NULL,NULL,NULL,NULL,NULL,            
		NULL,NULL,NULL,NULL,NULL,            
		NULL,NULL,NULL,NULL,NULL,            
		NULL,NULL,NULL,NULL,NULL,
			
	0,20,	
	'LISTAR'
			
)*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_VW_TABLAFORMATO_VALIDACION_LISTAR]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE OR ALTER PROCEDURE [SP_SS_HC_VW_TABLAFORMATO_VALIDACION_LISTAR]  
(   
      @IdFormato  int   
      ,@FormatoNivelID  int   
      ,@IdFormatoPadre  int    
      ,@CodigoFormato  varchar(20)  
      ,@CodigoFormatoPadre  varchar(20)      
        
      ,@DescripcionFormato  varchar(100)  
      ,@TipoFormato  int   
      ,@EstadoFormato  int   
      ,@IdFavoritoTabla  int  
      ,@NombreTabla  varchar(128)  
        
      ,@DescripcionTabla  varchar(100)  
      ,@TipoTabla  int  
      ,@EstadoTabla  int  
      ,@IdCampo  int   
      ,@NombreCampo  varchar(128)  
        
      ,@DescripcionCampo  varchar(100)  
      ,@TipoCampo  int  
      ,@Longitud  int  
      ,@Decimales  int  
      ,@EstadoTablaCampo  int     
        
      ,@SecuenciaCampo  int  
      ,@IdSeccionFormato  int  
      ,@ValorPorDefecto  varchar(100)  
      ,@IndicadorObligatorio  int  
      ,@IndicadorCampoCalculado  int  
        
      ,@Formula  varchar(500)  
      ,@IndicadorValoresVarios  int  
      ,@TablaValoresVarios  varchar(15)  
      ,@IndicadorRango  int  
      ,@RangoDesde  decimal(20,6)  
        
      ,@RangoHasta  decimal(20,6)  
      ,@IndicadorReglaNegocio  char(10)  
      ,@ReglaNegocio  varchar(100)  
      ,@Observaciones  varchar(500)  
      ,@EstadoFormatoCampo  int  
        
      ,@IdConcepto  int  
      ,@IdAgrupadorNivel  int     
      ,@IdObjetoAgrupador  int  
      ,@IdColumna  int  
      ,@IdFila  int  
        
      ,@IdEvento  int  
      ,@IdParameterEnvio  int     
      ,@Orden  int  
      ,@IdAgrupadorNivelPadre  int  
      ,@SecuenciaValidacion  int  
        
      ,@IdComponente  int  
      ,@IdAtributo  int  
      ,@TipoValidacion  varchar(10)   
      ,@FlagTipoDato  varchar(1)  
      ,@ValorTexto  varchar(200)  
        
      ,@ValorNumerico  numeric(10,2)  
      ,@ValorDate  datetime  
      ,@SecuenciaValidacionRef int  
      ,@EstadoValidacion  int  
      ,@UsuarioCreacion  varchar(25)  
        
      ,@FechaCreacion  datetime        
      ,@UsuarioModificacion  varchar(25)  
      ,@FechaModificacion  datetime             
      ,@Version   varchar(25)  
      ,@NombreComponente  varchar(200)  
        
      ,@TipoComponente  varchar(10)  
      ,@EstadoComponente  int  
      ,@NombreAtributo  varchar(200)  
      ,@EstadoAtributo  int  
      ,@IdiomaProperty  varchar(200)  
   
  ,@Inicio int,  
  @NumeroFilas int,  
  @ACCION varchar(25)   
     
)  
  
AS  
BEGIN  
 if(@ACCION = 'LISTARPAG')  
 begin  
   DECLARE @CONTADOR INT  
   
  SET @CONTADOR=(SELECT COUNT(*)       
     from   
    VW_SS_HC_TABLAFORMATO_VALIDACION  
      WHERE   
     (@IdFormato is null OR (IdFormato = @IdFormato) or @IdFormato =0)  
     and (@SecuenciaCampo is null OR (SecuenciaCampo = @SecuenciaCampo) or @SecuenciaCampo =0)  
     and (@SecuenciaValidacion is null OR (@SecuenciaValidacion = SecuenciaValidacion) or @SecuenciaValidacion =0)       
     and (@NombreComponente is null  OR @NombreComponente =''  OR  upper(NombreComponente) like '%'+upper(@NombreComponente)+'%')  
   
     )  
    
  SELECT   
      IdFormato   
     ,FormatoNivelID  
       ,IdFormatoPadre        
       ,CodigoFormato        
       ,CodigoFormatoPadre        
       ,DescripcionFormato        
       ,TipoFormato        
       ,EstadoFormato        
       ,IdFavoritoTabla        
       ,NombreTabla        
       ,DescripcionTabla        
       ,TipoTabla        
       ,EstadoTabla        
       ,IdCampo        
       ,NombreCampo        
       ,DescripcionCampo        
       ,TipoCampo        
       ,Longitud        
       ,Decimales        
       ,EstadoTablaCampo        
       ,SecuenciaCampo        
       ,IdSeccionFormato        
       ,ValorPorDefecto        
       ,IndicadorObligatorio        
       ,IndicadorCampoCalculado        
       ,Formula        
       ,IndicadorValoresVarios        
       ,TablaValoresVarios        
       ,IndicadorRango        
       ,RangoDesde        
       ,RangoHasta        
       ,IndicadorReglaNegocio        
       ,ReglaNegocio        
       ,Observaciones        
       ,EstadoFormatoCampo        
       ,IdConcepto        
       ,IdAgrupadorNivel        
       ,IdObjetoAgrupador        
       ,IdColumna        
       ,IdFila        
       ,IdEvento        
       ,IdParameterEnvio        
       ,Orden        
       ,IdAgrupadorNivelPadre        
       ,SecuenciaValidacion        
       ,IdComponente        
       ,IdAtributo        
       ,TipoValidacion        
       ,FlagTipoDato        
       ,ValorTexto        
       ,ValorNumerico        
       ,ValorDate        
       ,SecuenciaValidacionRef        
       ,EstadoValidacion        
       ,UsuarioCreacion        
       ,FechaCreacion        
       ,UsuarioModificacion        
       ,FechaModificacion        
       ,Accion        
       ,Version        
       ,NombreComponente        
       ,TipoComponente        
       ,EstadoComponente        
       ,NombreAtributo        
       ,EstadoAtributo        
       ,IdiomaProperty  
  FROM (  
    SELECT   
     VW_SS_HC_TABLAFORMATO_VALIDACION.*  
     ,@CONTADOR AS Contador  
     ,ROW_NUMBER() OVER (ORDER BY IdFormato ASC ) AS RowNumber          
    from   
    VW_SS_HC_TABLAFORMATO_VALIDACION  
      WHERE   
     (@IdFormato is null OR (IdFormato = @IdFormato) or @IdFormato =0)  
     and (@SecuenciaCampo is null OR (SecuenciaCampo = @SecuenciaCampo) or @SecuenciaCampo =0)  
     and (@SecuenciaValidacion is null OR (@SecuenciaValidacion = SecuenciaValidacion) or @SecuenciaValidacion =0)       
     and (@NombreComponente is null  OR @NombreComponente =''  OR  upper(NombreComponente) like '%'+upper(@NombreComponente)+'%')  
     
   ) AS LISTADO  
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR    
            RowNumber BETWEEN @Inicio  AND @NumeroFilas   
 end  
 else   
if(@ACCION = 'LISTARPAGVALIDACION')  
 begin  
   DECLARE @CONTADORVALIDA INT  
   
  SET @CONTADORVALIDA=(  
    SELECT COUNT(*) FROM  
     VW_SS_HC_TABLAFORMATO_VALIDACION  
     inner join  SS_HC_ControlValidacion   
     on SS_HC_ControlValidacion.idFormato = VW_SS_HC_TABLAFORMATO_VALIDACION.idFormato  
     and SS_HC_ControlValidacion.SecuenciaCampo = VW_SS_HC_TABLAFORMATO_VALIDACION.SecuenciaCampo  
     and SS_HC_ControlValidacion.SecuenciaValidacion = VW_SS_HC_TABLAFORMATO_VALIDACION.SecuenciaValidacion     
      WHERE   
         (@IdFormato is null OR (SS_HC_ControlValidacion.IdFormato = @IdFormato) or @IdFormato =0)  
     and (@DescripcionFormato is null  OR @DescripcionFormato =''  OR  upper(DescripcionFormato) like '%'+upper(@DescripcionFormato)+'%')  
     and (@IdComponente is null OR (SS_HC_ControlValidacion.IdComponente = @IdComponente) or @IdComponente =0)  
     and (@IdAtributo is null OR (SS_HC_ControlValidacion.IdAtributo = @IdAtributo) or @IdAtributo =0)  
     and (@ValorPorDefecto is null  OR @ValorPorDefecto =''  OR  upper(ValorPorDefecto) like '%'+upper(@ValorPorDefecto)+'%')  
     and (@EstadoValidacion is null OR EstadoValidacion = @EstadoValidacion)         
      
  )  
  SELECT   
         IdFormato --as FormatoNivelID  
         ,FormatoNivelID  
        ,IdFormatoPadre        
        ,CodigoFormato        
        ,CodigoFormatoPadre        
        ,DescripcionFormato        
        ,TipoFormato        
        ,EstadoFormato        
        ,IdFavoritoTabla        
        ,NombreTabla        
        ,DescripcionTabla        
        ,TipoTabla        
        ,EstadoTabla        
        ,IdCampo        
        ,NombreCampo        
        ,DescripcionCampo        
        ,TipoCampo        
        ,Longitud        
        ,Decimales        
        ,EstadoTablaCampo        
        ,SecuenciaCampo        
        ,IdSeccionFormato        
        ,ValorPorDefecto        
        ,IndicadorObligatorio        
        ,IndicadorCampoCalculado        
        ,Formula        
        ,IndicadorValoresVarios        
        ,TablaValoresVarios        
        ,IndicadorRango        
        ,RangoDesde        
        ,RangoHasta        
        ,IndicadorReglaNegocio        
        ,ReglaNegocio        
        ,Observaciones        
        ,EstadoFormatoCampo        
        ,IdConcepto        
        ,IdAgrupadorNivel        
        ,IdObjetoAgrupador        
        ,IdColumna        
        ,IdFila        
        ,IdEvento        
        ,IdParameterEnvio        
        ,Orden        
        ,IdAgrupadorNivelPadre        
        ,SecuenciaValidacion        
        ,IdComponente        
        ,IdAtributo        
        ,TipoValidacion        
        ,FlagTipoDato        
        ,ValorTexto        
        ,ValorNumerico
        ,ValorDate        
        ,SecuenciaValidacionRef        
        ,EstadoValidacion        
        ,UsuarioCreacion        
        ,FechaCreacion        
        ,UsuarioModificacion        
        ,FechaModificacion        
        ,Accion        
        ,Version        
        ,NombreComponente        
        ,TipoComponente        
        ,EstadoComponente        
        ,NombreAtributo        
        ,EstadoAtributo        
           ,IdiomaProperty  
      
  FROM (    
   SELECT  
       
     convert(int,ROW_NUMBER() OVER   
     (ORDER BY VW_SS_HC_TABLAFORMATO_VALIDACION.IdFormato ASC )       
     ) AS IdFormato  
     --VW_SS_HC_TABLAFORMATO_VALIDACION.IdFormato   
     ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdFormato as FormatoNivelID  
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdFormatoPadre        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.CodigoFormato        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.CodigoFormatoPadre        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.DescripcionFormato        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.TipoFormato        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.EstadoFormato        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdFavoritoTabla        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.NombreTabla        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.DescripcionTabla        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.TipoTabla        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.EstadoTabla        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdCampo        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.NombreCampo        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.DescripcionCampo        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.TipoCampo        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.Longitud        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.Decimales        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.EstadoTablaCampo        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.SecuenciaCampo        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdSeccionFormato        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.ValorPorDefecto        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IndicadorObligatorio        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IndicadorCampoCalculado        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.Formula        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IndicadorValoresVarios        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.TablaValoresVarios        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IndicadorRango        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.RangoDesde        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.RangoHasta        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IndicadorReglaNegocio        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.ReglaNegocio        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.Observaciones        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.EstadoFormatoCampo        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdConcepto        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdAgrupadorNivel        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdObjetoAgrupador        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdColumna        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdFila        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdEvento        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdParameterEnvio        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.Orden        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdAgrupadorNivelPadre        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.SecuenciaValidacion        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdComponente        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdAtributo        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.TipoValidacion        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.FlagTipoDato        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.ValorTexto        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.ValorNumerico        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.ValorDate        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.SecuenciaValidacionRef        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.EstadoValidacion        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.UsuarioCreacion        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.FechaCreacion        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.UsuarioModificacion        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.FechaModificacion        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.Accion        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.Version        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.NombreComponente        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.TipoComponente        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.EstadoComponente        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.NombreAtributo        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.EstadoAtributo        
          ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdiomaProperty     
      ,@CONTADORVALIDA AS Contador  
      ,ROW_NUMBER() OVER (ORDER BY FormatoNivelID ASC ) AS RowNumber      
        from   
     VW_SS_HC_TABLAFORMATO_VALIDACION  
     inner join  SS_HC_ControlValidacion   
     on SS_HC_ControlValidacion.idFormato = VW_SS_HC_TABLAFORMATO_VALIDACION.idFormato  
     and SS_HC_ControlValidacion.SecuenciaCampo = VW_SS_HC_TABLAFORMATO_VALIDACION.SecuenciaCampo  
     and SS_HC_ControlValidacion.SecuenciaValidacion = VW_SS_HC_TABLAFORMATO_VALIDACION.SecuenciaValidacion             
     
      WHERE   
         (@IdFormato is null OR (SS_HC_ControlValidacion.IdFormato = @IdFormato) or @IdFormato =0)  
     and (@DescripcionFormato is null  OR @DescripcionFormato =''  OR  upper(DescripcionFormato) like '%'+upper(@DescripcionFormato)+'%')  
     and (@IdComponente is null OR (SS_HC_ControlValidacion.IdComponente = @IdComponente) or @IdComponente =0)  
     and (@IdAtributo is null OR (SS_HC_ControlValidacion.IdAtributo = @IdAtributo) or @IdAtributo =0)  
     and (@ValorPorDefecto is null  OR @ValorPorDefecto =''  OR  upper(ValorPorDefecto) like '%'+upper(@ValorPorDefecto)+'%')  
     and (@EstadoValidacion is null OR EstadoValidacion = @EstadoValidacion)     
   ) AS LISTADO  
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR    
            RowNumber BETWEEN @Inicio  AND @NumeroFilas   
    
       END  
       ELSE  
 if(@ACCION = 'LISTARVALIDA')  
 begin    
    SELECT   
     convert(int,ROW_NUMBER() OVER   
     (ORDER BY VW_SS_HC_TABLAFORMATO_VALIDACION.IdFormato ASC )       
     ) AS IdFormato  
     --VW_SS_HC_TABLAFORMATO_VALIDACION.IdFormato   
     ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdFormato as FormatoNivelID  
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdFormatoPadre        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.CodigoFormato        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.CodigoFormatoPadre        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.DescripcionFormato        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.TipoFormato        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.EstadoFormato        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdFavoritoTabla        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.NombreTabla        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.DescripcionTabla        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.TipoTabla        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.EstadoTabla        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdCampo        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.NombreCampo        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.DescripcionCampo        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.TipoCampo        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.Longitud        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.Decimales        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.EstadoTablaCampo        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.SecuenciaCampo        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdSeccionFormato        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.ValorPorDefecto        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IndicadorObligatorio        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IndicadorCampoCalculado        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.Formula        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IndicadorValoresVarios        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.TablaValoresVarios        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IndicadorRango        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.RangoDesde        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.RangoHasta        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IndicadorReglaNegocio        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.ReglaNegocio        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.Observaciones        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.EstadoFormatoCampo        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdConcepto        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdAgrupadorNivel        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdObjetoAgrupador        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdColumna        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdFila        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdEvento        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdParameterEnvio        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.Orden        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdAgrupadorNivelPadre        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.SecuenciaValidacion        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdComponente        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdAtributo        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.TipoValidacion        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.FlagTipoDato        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.ValorTexto        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.ValorNumerico        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.ValorDate        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.SecuenciaValidacionRef        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.EstadoValidacion        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.UsuarioCreacion        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.FechaCreacion        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.UsuarioModificacion        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.FechaModificacion        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.Accion        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.Version        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.NombreComponente        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.TipoComponente        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.EstadoComponente        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.NombreAtributo        
        ,VW_SS_HC_TABLAFORMATO_VALIDACION.EstadoAtributo        
          ,VW_SS_HC_TABLAFORMATO_VALIDACION.IdiomaProperty  
       
    from   
    VW_SS_HC_TABLAFORMATO_VALIDACION  
    inner join  SS_HC_ControlValidacion   
    on SS_HC_ControlValidacion.idFormato = VW_SS_HC_TABLAFORMATO_VALIDACION.idFormato  
    and SS_HC_ControlValidacion.SecuenciaCampo = VW_SS_HC_TABLAFORMATO_VALIDACION.SecuenciaCampo  
    and SS_HC_ControlValidacion.SecuenciaValidacion = VW_SS_HC_TABLAFORMATO_VALIDACION.SecuenciaValidacion  
      
       WHERE   
     (@IdFormato is null OR (VW_SS_HC_TABLAFORMATO_VALIDACION.IdFormato = @IdFormato) or @IdFormato =0)  
     and (@SecuenciaCampo is null OR (VW_SS_HC_TABLAFORMATO_VALIDACION.SecuenciaCampo = @SecuenciaCampo) or @SecuenciaCampo =0)  
     and (@CodigoFormato is null OR (VW_SS_HC_TABLAFORMATO_VALIDACION.CodigoFormato = @CodigoFormato))  
     and (@SecuenciaValidacion is null OR (@SecuenciaValidacion = VW_SS_HC_TABLAFORMATO_VALIDACION.SecuenciaValidacion) or @SecuenciaValidacion =0)       
     and (@NombreComponente is null  OR @NombreComponente =''  OR  upper(VW_SS_HC_TABLAFORMATO_VALIDACION.NombreComponente) like '%'+upper(@NombreComponente)+'%')  
     --and (VW_SS_HC_TABLAFORMATO_VALIDACION.EstadoValidacion = 2)       
 end   

   
  
END  
/*  
  
exec [SP_SS_HC_VW_TABLAFORMATO_VALIDACION_LISTAR]  
  0,NULL,NULL,'ccep0102',NULL,  
  NULL,NULL,NULL,NULL,NULL,        
  NULL,NULL,NULL,NULL,NULL,              
  NULL,NULL,NULL,NULL,NULL,              
  NULL,NULL,NULL,NULL,NULL,              
  NULL,NULL,NULL,NULL,NULL,              
  NULL,NULL,NULL,NULL,NULL,              
  NULL,NULL,NULL,NULL,NULL,              
  NULL,NULL,NULL,NULL,NULL,              
  NULL,NULL,NULL,NULL,NULL,              
  NULL,NULL,NULL,2,NULL,              
  NULL,NULL,NULL,NULL,NULL,              
  NULL,NULL,NULL,NULL,NULL,       
 0,50,   
 'LISTARVALIDA'    
)*/     
  
GO

/****** Object:  StoredProcedure [dbo].[SP_SS_Medicamento_Programacion_Kardex_Listar]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[SP_SS_Medicamento_Programacion_Kardex_Listar]
	@UnidadReplicacion  char(4) ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@IdEpisodioAtencion  bigint,
	@Accion varchar(25) 
	
AS
BEGIN
	 SET NOCOUNT ON;
 
	 IF @Accion ='LISTAR'
			BEGIN			
				select 
				UnidadReplicacion,IdEpisodioAtencion,IdPaciente,EpisodioClinico,
				Secuencia,IdMedicacion,Medicacion,Dosis,
				Frecuencia,DiasTratamiento, DiaTratamiento,HoraInicio,
				HoraAdministracion,Hora0,Hora1,Hora2,
				Hora3,Hora4,Hora5,Hora6,
				Hora7,Hora8,Hora9,Hora10,
				Hora11,Hora12,Hora13,Hora14,
				Hora15,Hora16,Hora17,Hora18,
				Hora19,Hora20,Hora21,Hora22,
				Hora23,Estado,UsuarioCreacion,FechaCreacion,
				UsuarioModificacion,FechaModificacion,Accion,Version 
				from SS_HC_Medicamento_Kardex
				where UnidadReplicacion=@UnidadReplicacion and
				IdEpisodioAtencion=@IdEpisodioAtencion and
				IdPaciente=@IdPaciente and
				EpisodioClinico=@EpisodioClinico
			END		 
	 
END

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_VW_ServicioPrestacion]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO	

CREATE OR ALTER PROCEDURE [SP_SS_VW_ServicioPrestacion]
(
	  @Componente					varchar(25) ,
      @ValorMedida					decimal(20,6) ,
      @CantidadAsistentes			decimal(20,6) ,
      @Instrumentistas				int ,
      @DiasHospitalizacion			decimal(9,2) ,
      @CodigoSegus					varchar(15) ,
      @CodigoNuevo					varchar(15) ,
      @Estado						int ,
      @Nombre						varchar(250) ,
      @Descripcion					varchar(300) ,
      @Compania						varchar(15) ,
      @CentroCosto					varchar(15) ,
      @ClasificadorMovimiento		varchar(15) ,
      @ConceptoGasto				varchar(15) ,
      @IndicadorImpuesto			int ,
      @IdClasificacion				int ,
      @CodClasificacion				varchar(15) ,
      @NomClasificacion				varchar(250) ,
      @Orden						int ,
      @TipoPrestacion				int ,
      @IndicadorCita				int ,
      @IndicadorHC					int ,
      @CadenaRecursividad			varchar(150) ,
      @IndicadorPrestacionPrincipal	int ,
      @IndicadorRequierePersonal	int ,
      @IdServicio					int ,
      @IdGrupoAtencion				int ,
      @Codigo						varchar(15) ,
      @TipoOrdenAtencion			int ,
	  @ACCION						varchar(25) 
)

AS
BEGIN 
SET NOCOUNT ON;
BEGIN  TRANSACTION
	
	if(@ACCION = 'LISTARPAG')
	begin		
		DECLARE @CONTADOR INT =0
		SET @CONTADOR=(
			SELECT COUNT(*) FROM VW_ServicioPrestacion	WHERE 
					(@Componente is null or @Componente ='' or   upper(Componente) like '%'+upper(@Componente)+'%')											
				and (@ESTADO is null OR Estado = @ESTADO)
				and (@IdServicio is null or IdServicio = @IdServicio or @IdServicio =0)	
				and (@IdClasificacion is null OR IdClasificacion = @IdClasificacion or @IdClasificacion =0)
				and (@NOMBRE is null  OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')	
				and (@CodigoSegus is null OR @CodigoSegus =''  OR  upper(CodigoSegus) like '%'+upper(@CodigoSegus)+'%')
				and (@CodigoNuevo is null OR @CodigoNuevo =''  OR  upper(CodigoNuevo) like '%'+upper(@CodigoNuevo)+'%')
			)
		select @CONTADOR
	end

commit	
	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_VW_ServicioPrestacionListar]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    
CREATE OR ALTER PROCEDURE  [dbo].[SP_SS_VW_ServicioPrestacionListar]     
	  @Componente					varchar(25) ,
      @ValorMedida					decimal(20,6) ,
      @CantidadAsistentes			decimal(20,6) ,
      @Instrumentistas				int ,
      @DiasHospitalizacion			decimal(9,2) ,
      @CodigoSegus					varchar(15) ,
      @CodigoNuevo					varchar(15) ,
      @Estado						int ,
      @Nombre						varchar(250) ,
      @Descripcion					varchar(300) ,
      @Compania						varchar(15) ,
      @CentroCosto					varchar(15) ,
      @ClasificadorMovimiento		varchar(15) ,
      @ConceptoGasto				varchar(15) ,
      @IndicadorImpuesto			int ,
      @IdClasificacion				int ,
      @CodClasificacion				varchar(15) ,
      @NomClasificacion				varchar(250) ,
      @Orden						int ,
      @TipoPrestacion				int ,
      @IndicadorCita				int ,
      @IndicadorHC					int ,
      @CadenaRecursividad			varchar(150) ,
      @IndicadorPrestacionPrincipal	int ,
      @IndicadorRequierePersonal	int ,
      @IdServicio					int ,
      @IdGrupoAtencion				int ,
      @Codigo						varchar(15) ,
      @TipoOrdenAtencion			int ,
	  @ACCION						varchar(25), 
	  @INICIO						int= null,  
	  @NUMEROFILAS					int = null     
AS    
BEGIN    
if(@ACCION = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR=(
				SELECT COUNT(Componente) FROM VW_ServicioPrestacion	WHERE 
				(@Componente is null or @Componente ='' or  Componente = @Componente)										
				and (@ESTADO is null OR Estado = @ESTADO)
				and (@IdServicio is null or IdServicio = @IdServicio or @IdServicio =0)	
				and (@IdClasificacion is null OR IdClasificacion = @IdClasificacion or @IdClasificacion =0)
				and (@NOMBRE is null  OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')	
				and (@CodigoSegus is null OR @CodigoSegus =''  OR  upper(CodigoSegus) like '%'+upper(@CodigoSegus)+'%')
				and (@CodigoNuevo is null OR @CodigoNuevo =''  OR  upper(CodigoNuevo) like '%'+upper(@CodigoNuevo)+'%')
				)
		SELECT Componente		  ,ValorMedida		  ,CantidadAsistentes		  ,Instrumentistas
		  ,DiasHospitalizacion		  ,CodigoSegus		  ,CodigoNuevo		  ,Estado
		  ,Nombre		  ,Descripcion		  ,Compania		  ,CentroCosto
		  ,ClasificadorMovimiento		  ,ConceptoGasto		  ,IndicadorImpuesto
		  ,IdClasificacion		  ,CodClasificacion		  ,NomClasificacion		  ,Orden
		  ,TipoPrestacion		  ,IndicadorCita		  ,IndicadorHC		  ,CadenaRecursividad
		  ,IndicadorPrestacionPrincipal		  ,IndicadorRequierePersonal		  ,IdServicio
		  ,IdGrupoAtencion		  ,Codigo		  ,TipoOrdenAtencion,Accion
				
		FROM (		
			SELECT
				   Componente		,ValorMedida	         ,CantidadAsistentes
				  ,Instrumentistas	,DiasHospitalizacion	 ,CodigoSegus
				  ,CodigoNuevo		,Estado					 ,Nombre
				  ,Descripcion		,Compania				 ,CentroCosto
				  ,ClasificadorMovimiento	  ,ConceptoGasto	  ,IndicadorImpuesto
				  ,IdClasificacion		  ,CodClasificacion	  ,NomClasificacion
				  ,Orden			 ,TipoPrestacion		 ,IndicadorCita
				  ,IndicadorHC	  ,CadenaRecursividad		  ,IndicadorPrestacionPrincipal
				  ,IndicadorRequierePersonal		  ,IdServicio	  ,IdGrupoAtencion
				  ,Codigo		  ,TipoOrdenAtencion	,Accion						
				  ,@CONTADOR AS Contador
				  ,ROW_NUMBER() OVER (ORDER BY Componente ASC ) AS RowNumber   	
					FROM VW_ServicioPrestacion	
					WHERE 
				(@Componente is null or @Componente ='' or   upper(Componente) like '%'+upper(@Componente)+'%')										
				and (@ESTADO is null OR Estado = @ESTADO)
				and (@IdServicio is null or IdServicio = @IdServicio or @IdServicio =0)	
				and (@IdClasificacion is null OR IdClasificacion = @IdClasificacion or @IdClasificacion =0)
				and (@NOMBRE is null  OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')	
				and (@CodigoSegus is null OR @CodigoSegus =''  OR  upper(CodigoSegus) like '%'+upper(@CodigoSegus)+'%')
				and (@CodigoNuevo is null OR @CodigoNuevo =''  OR  upper(CodigoNuevo) like '%'+upper(@CodigoNuevo)+'%')
 
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		
       END
       ELSE
  IF @Accion ='LISTAR'    
    BEGIN    
		SELECT Componente		  ,ValorMedida		  ,CantidadAsistentes		  ,Instrumentistas
		  ,DiasHospitalizacion		  ,CodigoSegus		  ,CodigoNuevo		  ,Estado
		  ,Nombre		  ,Descripcion		  ,Compania		  ,CentroCosto
		  ,ClasificadorMovimiento		  ,ConceptoGasto		  ,IndicadorImpuesto
		  ,IdClasificacion		  ,CodClasificacion		  ,NomClasificacion		  ,Orden
		  ,TipoPrestacion		  ,IndicadorCita		  ,IndicadorHC		  ,CadenaRecursividad
		  ,IndicadorPrestacionPrincipal		  ,IndicadorRequierePersonal		  ,IdServicio
		  ,IdGrupoAtencion		  ,Codigo		  ,TipoOrdenAtencion,Accion
				FROM VW_ServicioPrestacion	
									WHERE 
				(@Componente is null or @Componente ='' or  Componente = @Componente)										
				and (@ESTADO is null OR Estado = @ESTADO)
				and (@IdServicio is null or IdServicio = @IdServicio or @IdServicio =0)	
				and (@IdClasificacion is null OR IdClasificacion = @IdClasificacion or @IdClasificacion =0)
				and (@NOMBRE is null  OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')	
				and (@CodigoSegus is null OR @CodigoSegus =''  OR  upper(CodigoSegus) like '%'+upper(@CodigoSegus)+'%')
				and (@CodigoNuevo is null OR @CodigoNuevo =''  OR  upper(CodigoNuevo) like '%'+upper(@CodigoNuevo)+'%')
 
end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 	*	FROM 	VW_ServicioPrestacion
					WHERE 	(@Componente is null or @Componente ='' or  Componente = @Componente)

	end	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_VW_VALIDA]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_VW_VALIDA]
		@IdFormato				int,
		@ValorPorDefecto		varchar(100),
		@NombreComponente		varchar(200),
		@TipoComponente			varchar(10),
		@NombreAtributo			varchar(200),
		@SecuenciaCampo			int,
		@SecuenciaValidacion	int,
		@Estado					int,
		@Accion					varchar(25), 
		@Version				varchar(25)
AS
BEGIN 
	
	if(@ACCION = 'CONTARLISTAPAG')
	begin		
		DECLARE @CONTADOR INT
	
	
		SET @CONTADOR=(
				SELECT COUNT(IdFormato) FROM SS_VW_VALIDA	
				WHERE 
					(@IdFormato is null OR (IdFormato = @IdFormato) or @IdFormato =0)
					and (@SecuenciaCampo is null OR (SecuenciaCampo = @SecuenciaCampo) or @SecuenciaCampo =0)
					and (@SecuenciaValidacion is null OR (@SecuenciaValidacion = SecuenciaValidacion) or @SecuenciaValidacion =0)			
					and (@NombreComponente is null  OR @NombreComponente =''  OR  upper(NombreComponente) like '%'+upper(@NombreComponente)+'%')						
					and (@Estado is null OR Estado = @Estado)				)
		select @CONTADOR
	end


	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_VW_VALIDA_LISTA]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	--exec sp_vw_favoritos_listar 0,null,null,null,null,null,null,'LISTARPAG',null,0,10
CREATE OR ALTER PROCEDURE [SP_SS_VW_VALIDA_LISTA] 
		@IdFormato				int,
		@ValorPorDefecto		varchar(100),
		@NombreComponente		varchar(200),
		@TipoComponente			varchar(10),
		@NombreAtributo			varchar(200),
		@SecuenciaCampo			int,
		@SecuenciaValidacion	int,
		@Estado					int,
		@Accion					varchar(25), 
		@Version				varchar(25), 
	    @INICIO					int= null,  
	    @NUMEROFILAS			int = null 
AS    
BEGIN    
if(@ACCION = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR=(
				SELECT COUNT(IdFormato) FROM SS_VW_VALIDA	
				WHERE 
					(@IdFormato is null OR (IdFormato = @IdFormato) or @IdFormato =0)
					and (@SecuenciaCampo is null OR (SecuenciaCampo = @SecuenciaCampo) or @SecuenciaCampo =0)
					and (@SecuenciaValidacion is null OR (@SecuenciaValidacion = SecuenciaValidacion) or @SecuenciaValidacion =0)			
					and (@NombreComponente is null  OR @NombreComponente =''  OR  upper(NombreComponente) like '%'+upper(@NombreComponente)+'%')						
					and (@Estado is null OR Estado = @Estado)				
								)
		SELECT 
				convert(int,ROW_NUMBER() OVER (ORDER BY IdFormato ASC )) as IdFormato,
				ValorPorDefecto,
				NombreComponente,
				TipoComponente,
				NombreAtributo,
				SecuenciaCampo,
				SecuenciaValidacion,
				Estado,
				Accion,
				convert(varchar,IdFormato) as Version
				
		FROM (		
			SELECT
					IdFormato,
					ValorPorDefecto,
					NombreComponente,
					TipoComponente,
					NombreAtributo,
					SecuenciaCampo,
					SecuenciaValidacion,
					Estado,
					Accion,
					Version				
				  ,@CONTADOR AS Contador
				  ,ROW_NUMBER() OVER (ORDER BY IdFormato ASC ) AS RowNumber   	
					FROM SS_VW_VALIDA	
					WHERE 
					(@IdFormato is null OR (IdFormato = @IdFormato) or @IdFormato =0)
					and (@SecuenciaCampo is null OR (SecuenciaCampo = @SecuenciaCampo) or @SecuenciaCampo =0)
					and (@SecuenciaValidacion is null OR (@SecuenciaValidacion = SecuenciaValidacion) or @SecuenciaValidacion =0)			
					and (@NombreComponente is null  OR @NombreComponente =''  OR  upper(NombreComponente) like '%'+upper(@NombreComponente)+'%')						
					and (@Estado is null OR Estado = @Estado)	
 
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		
       END
       ELSE
  IF @Accion ='LISTAR'    
    BEGIN    
		SELECT 
					IdFormato,
					ValorPorDefecto,
					NombreComponente,
					TipoComponente,
					NombreAtributo,
					SecuenciaCampo,
					SecuenciaValidacion,
					Estado,
					Accion,
					Version	
				FROM SS_VW_VALIDA	
									WHERE 
				
					(@IdFormato is null OR (IdFormato = @IdFormato) or @IdFormato =0)
					and (@SecuenciaCampo is null OR (SecuenciaCampo = @SecuenciaCampo) or @SecuenciaCampo =0)
					and (@SecuenciaValidacion is null OR (@SecuenciaValidacion = SecuenciaValidacion) or @SecuenciaValidacion =0)			
					and (@NombreComponente is null  OR @NombreComponente =''  OR  upper(NombreComponente) like '%'+upper(@NombreComponente)+'%')						
					and (@Estado is null OR Estado = @Estado)
end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 	*	FROM 	SS_VW_VALIDA
				where	(@IdFormato is null OR (IdFormato = @IdFormato) or @IdFormato =0)

	end	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_WH_ClaseFamilia]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_WH_ClaseFamilia]
(
@Linea					varchar(6),
	@Familia				varchar(6),
	@DescripcionLocal		varchar(150),
	@DescripcionIngles		varchar(150),
	@DescripcionCompleta	varchar(150),
	@CuentaInventario		varchar(20),
	@CuentaGasto			varchar(20),
	@ElementoGasto			varchar(6),
	@PartidaPresupuestal	varchar(4),
	@FlujodeCaja			varchar(4),
	@LineaFamilia			varchar(12),
	@LoteValidacionFlag	varchar(1),
	@MedicinaGrupoAFlag	varchar(1),
	@MedicinaGrupoHFlag	varchar(1),
	@MedicinaGrupoEFlag	varchar(1),
	@MedicinaGrupoRFlag	varchar(1),
	@CuentaVentas			varchar(20),
	@CuentaTransito			varchar(20),
	@CuentaCostoVentas	varchar(20),
	@Caracteristica01	varchar(3),
	@Caracteristica02	varchar(3),
	@Caracteristica03	varchar(3),
	@Caracteristica04	varchar(3),
	@Caracteristica05	varchar(3),
	@Estado				varchar(1),
	@UltimoUsuario		varchar	(25),
	@UltimaFechaModif		datetime	=NULL,
	@ReferenciaFiscal01		varchar(10),
	@ReferenciaFiscal02		varchar(20),
	@ReferenciaFiscal03		varchar(10),
	@ContactoEMail			varchar(50),
	@ContactoFax			varchar(10),
	@ContactoNombre			varchar(50),
	@ContactoTelefono		varchar(10),
	@CuentaVentaComercial	varchar	(25),
	@CuentaCompras			varchar(20),
	@CentroCosto			varchar(15),
	@CuentaServicioTecnico	varchar(20),
	@ACCION					varchar(25)
)

AS
BEGIN 
SET NOCOUNT ON;
BEGIN  TRANSACTION
	declare @IdAgenteAux int =0
	if(@ACCION = 'LISTARPAG')
	begin		
		DECLARE @CONTADOR INT =0
		 IF @Estado='T' 
			BEGIN
			SET @Estado=NULL
			END
		SET @CONTADOR=(
			SELECT COUNT(*) FROM WH_ClaseFamilia	WHERE 
				(@Familia is null or @Familia ='' or  Familia = @Familia)	
			AND (@Linea is null or @Linea ='' or  Linea = @Linea)										
			AND (@ESTADO is null  OR @ESTADO =''  OR  upper(ESTADO) like '%'+upper(@ESTADO)+'%')	
			AND (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')	

			)
		select @CONTADOR
	end

commit	
	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_WH_ClaseLinea]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_WH_ClaseLinea]  
(  
 @Linea     varchar(6),  
 @DescripcionLocal  varchar(30),  
 @DescripcionIngles  varchar(30),  
 @GrupoLinea    varchar (2),  
 @ManejoColorSerieFlag varchar(18),  
 @Estado     varchar (1),  
 @UltimaFechaModif  datetime= NULL,  
 @UltimoUsuario   varchar (25) ,  
 @ACCION     varchar(25)  
)  
  
AS  
BEGIN   
SET NOCOUNT ON;  
BEGIN  TRANSACTION  
 declare @IdAgenteAux int =0  
 if(@ACCION = 'LISTARPAG')  
 begin    
  DECLARE @CONTADOR INT =0  
      IF @Estado='T'   
   BEGIN  
   SET @Estado=NULL  
   END  
  SET @CONTADOR=(  
   SELECT COUNT(*) FROM WH_ClaseLinea WHERE   
    --(@Linea is null or @Linea ='' or  Linea = @Linea)      
    (@Linea is null  OR @Linea =''  OR  upper(rtrim(Linea)) like '%'+upper(rtrim(@Linea))+'%')   
    and (@ESTADO is null  OR @ESTADO =''  OR  upper(ESTADO) like '%'+upper(@ESTADO)+'%')            
    and (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(rtrim(DescripcionLocal)) like '%'+upper(rtrim(@DescripcionLocal))+'%')   
   )  
  select @CONTADOR  
 end  
  
commit   
   
END  
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_WH_ClaseSubFamilia]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_WH_ClaseSubFamilia]
(
	@Linea					varchar(6),
	@Familia				varchar(6),
	@SubFamilia				varchar(6),
	@DescripcionLocal		varchar	(150),
	@DescripcionIngles		varchar	(150),
	@DescripcionCompleta	varchar	(250),
	@ItemTipo				varchar(1),
	@TransaccionOperacion	varchar(3),
	@Estado					varchar(1),
	@UltimaFechaModif		datetime=	NULL,
	@UltimoUsuario			varchar(25),
	@ACCION					varchar(25)
)

AS
BEGIN 
SET NOCOUNT ON;
BEGIN  TRANSACTION
	declare @IdAgenteAux int =0
	if(@ACCION = 'LISTARPAG')
	begin		
		DECLARE @CONTADOR INT =0
				 IF @Estado='T' 
			BEGIN
			SET @Estado=NULL
			END
		SET @CONTADOR=(
			SELECT COUNT(*) FROM WH_ClaseSubFamilia	WHERE 
					(@SubFamilia is null or @SubFamilia ='' or  SubFamilia = @SubFamilia)	
			AND	(@Familia is null or @Familia ='' or  Familia = @Familia)	
			AND (@Linea is null or @Linea ='' or  Linea = @Linea)										
			AND (@ESTADO is null  OR @ESTADO =''  OR  upper(ESTADO) like '%'+upper(@ESTADO)+'%')	
			AND (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')	

			)
		select @CONTADOR
	end

commit	
	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_WH_ClaseSubFamiliaListar]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
   
CREATE OR ALTER PROCEDURE  [dbo].[SP_SS_WH_ClaseSubFamiliaListar]     
	@Linea					varchar(6),
	@Familia				varchar(6),
	@SubFamilia				varchar(6),
	@DescripcionLocal		varchar	(150),
	@DescripcionIngles		varchar	(150),
	@DescripcionCompleta	varchar	(250),
	@ItemTipo				varchar(1),
	@TransaccionOperacion	varchar(3),
	@Estado					varchar(1),
	@UltimaFechaModif		datetime=	NULL,
	@UltimoUsuario			varchar(25),
	@ACCION					varchar(25), 
	@INICIO					int= null,  
	@NUMEROFILAS			int = null     
AS    
BEGIN    
if(@ACCION = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
			 IF @Estado='T' 
			BEGIN
			SET @Estado=NULL
			END
		SET @CONTADOR=(
				SELECT COUNT(SubFamilia) FROM WH_ClaseSubFamilia	WHERE 
				(@SubFamilia is null or @SubFamilia ='' or  SubFamilia = @SubFamilia)	
			AND	(@Familia is null or @Familia ='' or  Familia = @Familia)	
			AND (@Linea is null or @Linea ='' or  Linea = @Linea)										
			AND (@ESTADO is null  OR @ESTADO =''  OR  upper(ESTADO) like '%'+upper(@ESTADO)+'%')	
			AND (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')	

				)
		SELECT Linea
      ,Familia
      ,SubFamilia
      ,DescripcionLocal
      ,DescripcionIngles
      ,DescripcionCompleta
      ,ItemTipo
      ,TransaccionOperacion
      ,Estado
      ,UltimaFechaModif
      ,UltimoUsuario
      ,rtrim(Linea)+rtrim(Familia)+rtrim(SubFamilia) as Accion				
		FROM (		
			SELECT	Linea
      ,Familia
      ,SubFamilia
      ,DescripcionLocal
      ,DescripcionIngles
      ,DescripcionCompleta
      ,ItemTipo
      ,TransaccionOperacion
      ,Estado
      ,UltimaFechaModif
      ,UltimoUsuario
      ,Accion		
				  ,@CONTADOR AS Contador
				  ,ROW_NUMBER() OVER (ORDER BY SubFamilia ASC ) AS RowNumber   	
					FROM WH_ClaseSubFamilia	
					WHERE 
								(@SubFamilia is null or @SubFamilia ='' or  SubFamilia = @SubFamilia)	
			AND	(@Familia is null or @Familia ='' or  Familia = @Familia)	
			AND (@Linea is null or @Linea ='' or  Linea = @Linea)										
			AND (@ESTADO is null  OR @ESTADO =''  OR  upper(ESTADO) like '%'+upper(@ESTADO)+'%')	
			AND (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')	
 
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		
       END
       ELSE
  IF @Accion ='LISTAR'    
    BEGIN    
		SELECT Linea
      ,Familia
      ,SubFamilia
      ,DescripcionLocal
      ,DescripcionIngles
      ,DescripcionCompleta
      ,ItemTipo
      ,TransaccionOperacion
      ,Estado
      ,UltimaFechaModif
      ,UltimoUsuario
      ,Accion
				FROM WH_ClaseSubFamilia		WHERE 
								(@SubFamilia is null or @SubFamilia ='' or  SubFamilia = @SubFamilia)	
			AND	(@Familia is null or @Familia ='' or  Familia = @Familia)	
			AND (@Linea is null or @Linea ='' or  Linea = @Linea)										
			AND (@ESTADO is null  OR @ESTADO =''  OR  upper(ESTADO) like '%'+upper(@ESTADO)+'%')	
			AND (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')	
 
end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 	*	FROM WH_ClaseSubFamilia  WHERE
					(@SubFamilia is null or @SubFamilia ='' or  SubFamilia = @SubFamilia)	
				AND (@Familia is null or @Familia ='' or  Familia = @Familia)	
				AND (@Linea is null or @Linea ='' or  Linea = @Linea)										


	end	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SY_Global_SeguridadAutorizaciones]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[SP_SY_Global_SeguridadAutorizaciones]
@Concepto varchar(100) ,
@Accion varchar(20)

as

begin

if (@Accion='INSERT')
BEGIN
insert into SY_SeguridadAutorizaciones values ('SY','SUCURSAL',@Concepto,'ROYAL',NULL,NULL,NULL,'A','ROYAL', GETDATE(),2009,@Accion)
PRINT('*-*')
END


ELSE IF(@Accion = 'UPDATE')
begin
PRINT ('HOMBRES TRABAJANDO')
end


ELSE IF(@Accion = 'DELETE')
begin
DELETE FROM SY_SeguridadAutorizaciones WHERE Usuario='ROYAL' AND Grupo='SUCURSAL' AND Concepto=@Concepto
end
end
GO


/****** Object:  StoredProcedure [dbo].[SP_USUARIO]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_USUARIO]
(
	@USUARIO	char(20) ,
	@USUARIOPERFIL	char(2) ,
	@PERSONA	int ,
	@TIPOPERSONA	int ,
	@NOMBRE	varchar(50) ,
	@CLAVE	char(100) ,
	@EXPIRARPASSWORDFLAG	char(1) ,
	@FECHAEXPIRACION	datetime ,
	@ULTIMOLOGIN	datetime ,
	@NUMEROLOGINSDISPONIBLE	int ,
	@NUMEROLOGINSUSADOS	int ,
	@USUARIORED	varchar(25) ,
	@SQLLOGIN	char(20) ,
	@SQLPASSWORD	char(10) ,
	@ESTADO	char(1) ,
	@ULTIMOUSUARIO	varchar(25) ,
	@ULTIMAFECHAMODIF	datetime ,
	@ACCION	varchar(25) 
)

AS
BEGIN 
SET NOCOUNT ON;
BEGIN  TRANSACTION
	if(@ACCION = 'INSERT')
	begin
		insert into USUARIO
		(  USUARIO,
           USUARIOPERFIL,
           PERSONA,
           TIPOPERSONA,
           NOMBRE,
           CLAVE,
           EXPIRARPASSWORDFLAG,
           FECHAEXPIRACION,
           ULTIMOLOGIN,
           NUMEROLOGINSDISPONIBLE,
           NUMEROLOGINSUSADOS,
           USUARIORED,
           SQLLOGIN,
           SQLPASSWORD,
           ESTADO,
           ULTIMOUSUARIO,
           ULTIMAFECHAMODIF,
           ACCION)
		values
		   (@USUARIO,
           @USUARIOPERFIL,
           @PERSONA,
           @TIPOPERSONA,
           @NOMBRE,
           @CLAVE,
           @EXPIRARPASSWORDFLAG,
           @FECHAEXPIRACION,
           @ULTIMOLOGIN,
           @NUMEROLOGINSDISPONIBLE,
           @NUMEROLOGINSUSADOS,
           @USUARIORED,
           @SQLLOGIN,
           @SQLPASSWORD,
           @ESTADO,
           @ULTIMOUSUARIO,
           GETDATE(),
           @ACCION)

		select 1
	end
	else
	if(@ACCION = 'UPDATE')
	begin
	UPDATE USUARIO
	   SET   
			  USUARIOPERFIL = @USUARIOPERFIL,
			  PERSONA = @PERSONA,
			  TIPOPERSONA = @TIPOPERSONA,
			  NOMBRE = @NOMBRE,
			  CLAVE = @CLAVE,
			  EXPIRARPASSWORDFLAG = @EXPIRARPASSWORDFLAG,
			  FECHAEXPIRACION = @FECHAEXPIRACION,
			  ULTIMOLOGIN = @ULTIMOLOGIN,
			  NUMEROLOGINSDISPONIBLE = @NUMEROLOGINSDISPONIBLE,
			  NUMEROLOGINSUSADOS = @NUMEROLOGINSUSADOS,
			  USUARIORED = @USUARIORED,
			  SQLLOGIN = @SQLLOGIN,
			  SQLPASSWORD = @SQLPASSWORD,
			  ESTADO = @ESTADO,
			  ULTIMOUSUARIO = @ULTIMOUSUARIO,
			  ULTIMAFECHAMODIF = GETDATE(),
			  ACCION = @ACCION
		      WHERE 
					(Usuario = @USUARIO)	
			
			select 1			
	end	
	else
	if(@ACCION = 'DELETE')
	begin
		delete SEGURIDADAUTORIZACIONES
		WHERE 
		(Usuario = @USUARIO)
	
		delete SEGURIDADPERFILUSUARIO
		WHERE 
		(Usuario = @USUARIO)				
		delete USUARIO
		WHERE 
		(Usuario = @USUARIO)
		
		select 1
	end	
	if(@ACCION = 'CONTARLISTAPAG')
	begin		
		DECLARE @CONTADOR INT
		SET @CONTADOR=(SELECT COUNT(Usuario) FROM Usuario
	 					WHERE 
					(@USUARIO is null OR Usuario = @USUARIO)
					and (@USUARIOPERFIL is null OR UsuarioPerfil = @USUARIOPERFIL)
					and (@NOMBRE is null   OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')							
					and (@ESTADO is null OR Estado = @ESTADO))
					
		select @CONTADOR
	end
	
commit	
	
END
/*
exec [SP_USUARIO]
	@USUARIO =NULL,
	@USUARIOPERFIL =NULL,
	@PERSONA	int ,
	@TIPOPERSONA	int ,
	@NOMBRE	varchar(50) ,
	@CLAVE	char(100) ,
	@EXPIRARPASSWORDFLAG	char(1) ,
	@FECHAEXPIRACION	datetime ,
	@ULTIMOLOGIN	datetime ,
	@NUMEROLOGINSDISPONIBLE	int ,
	@NUMEROLOGINSUSADOS	int ,
	@USUARIORED	varchar(25) ,
	@SQLLOGIN	char(20) ,
	@SQLPASSWORD	char(10) ,
	@ESTADO	char(1) ,
	@ULTIMOUSUARIO	varchar(25) ,
	@ULTIMAFECHAMODIF	datetime ,
	@ACCION	varchar(
)*/
GO
/****** Object:  StoredProcedure [dbo].[SP_USUARIOS_LISTAR]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_USUARIOS_LISTAR]
(
	@Usuario CHAR(20)	,
	@Clave CHAR(100)	,	
	@USUARIOPERFIL CHAR(2)=NULL,
	@PERSONA INT=null,
	@NOMBRE VARCHAR(50), 
	@ESTADO CHAR(1)	,
	
	@INICIO   int= null,  
	@NUMEROFILAS int = null ,
	@ACCION VARCHAR(20)
)

AS
BEGIN
	DECLARE @CONTADOR INT
	if(@ACCION = 'LISTARPAG')
	begin
		
	
		SET @CONTADOR=(SELECT COUNT(Usuario) FROM Usuario
	 					WHERE 
					(@USUARIO is null OR Usuario = @USUARIO)
					and (@USUARIOPERFIL is null OR UsuarioPerfil = @USUARIOPERFIL)
					and (@NOMBRE is null   OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')							
					and (@ESTADO is null OR Estado = @ESTADO))
	 
		SELECT 
				Usuario as Usuario1		 
			  ,[USUARIOPERFIL]
			  ,[PERSONA]
			  ,[TIPOPERSONA]
			  ,[NOMBRE]
			  ,[CLAVE]
			  ,[EXPIRARPASSWORDFLAG]
			  ,[FECHAEXPIRACION]
			  ,[ULTIMOLOGIN]
			  ,[NUMEROLOGINSDISPONIBLE]
			  ,[NUMEROLOGINSUSADOS]
			  ,[USUARIORED]
			  ,[SQLLOGIN]
			  ,[SQLPASSWORD]
			  ,[ESTADO]
			  ,[ULTIMOUSUARIO]
			  ,[ULTIMAFECHAMODIF]
			  ,[ACCION]		   
		FROM (SELECT Usuario,
						   Clave,
						   PERSONA,
						   TIPOPERSONA,
						   ExpirarPasswordFlag,
						   FechaExpiracion,
						   UltimoLogin,
						   NumeroLoginsDisponible,
						   Estado,
						   UltimaFechaModif,
						   UltimoUsuario,
						   NumeroLoginsUsados,
						   (case UsuarioPerfil 
						   when 'US' then 'Usuario'
						   when 'PE' then 'Perfil'  else '--' end) as UsuarioPerfil,
						   --UsuarioPerfil,
						   Nombre,
						   SQLLOGIN,
						   SQLPASSWORD,
						   UsuarioRed,
						   accion,						   
						   @CONTADOR AS Contador,
					       ROW_NUMBER() OVER (ORDER BY Usuario ASC ) AS RowNumber    
					FROM Usuario  
					WHERE 
					(@USUARIO is null  OR @USUARIO = '' OR Usuario = @USUARIO)
					and (@USUARIOPERFIL is null OR UsuarioPerfil = @USUARIOPERFIL)
					and (@NOMBRE is null  OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')							
					and (@ESTADO is null OR Estado = @ESTADO)
					) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
	end
	else
	if(@ACCION = 'LISTAR')
	begin
	 
		SELECT 
				Usuario as Usuario1		 
			  ,[USUARIOPERFIL]
			  ,[PERSONA]
			  ,[TIPOPERSONA]
			  ,[NOMBRE]
			  ,[CLAVE]
			  ,[EXPIRARPASSWORDFLAG]
			  ,[FECHAEXPIRACION]
			  ,[ULTIMOLOGIN]
			  ,[NUMEROLOGINSDISPONIBLE]
			  ,[NUMEROLOGINSUSADOS]
			  ,[USUARIORED]
			  ,[SQLLOGIN]
			  ,[SQLPASSWORD]
			  ,[ESTADO]
			  ,[ULTIMOUSUARIO]
			  ,[ULTIMAFECHAMODIF]
			  ,[ACCION]		   
					FROM Usuario  
					WHERE 
					(@USUARIO is null OR Usuario = @USUARIO)
					and (@USUARIOPERFIL is null OR UsuarioPerfil = @USUARIOPERFIL)
					and (@NOMBRE is null  OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')							
					and (@ESTADO is null OR Estado = @ESTADO)
	end	
	else
	if(@ACCION = 'VALIDARLOGIN')
	begin
	
	
		select 
				Usuario as Usuario1		 
			    ,(select top 1 us.NOMBRE 
					from SEGURIDADPERFILUSUARIO usperfil inner join USUARIO us
					on(us.USUARIO=usperfil.PERFIL)
					where usperfil.USUARIO = @Usuario
				) as USUARIOPERFIL
			  ,[PERSONA]
			  ,[TIPOPERSONA]
			  ,[NOMBRE]
			  ,[CLAVE]
			  ,[EXPIRARPASSWORDFLAG]
			  ,[FECHAEXPIRACION]
			  ,[ULTIMOLOGIN]
			  ,[NUMEROLOGINSDISPONIBLE]
			  ,[NUMEROLOGINSUSADOS]
			  ,[USUARIORED]
			  ,[SQLLOGIN]
			  ,[SQLPASSWORD]
			  ,[ESTADO]
			  ,[ULTIMOUSUARIO]
			  ,[ULTIMAFECHAMODIF]
			  ,[ACCION]			
			FROM Usuario  
				WHERE 
				( Usuario = @USUARIO)
				and (CLAVE = @Clave)
								
				--and (@USUARIOPERFIL is null OR UsuarioPerfil = @USUARIOPERFIL)				
				--and ( Estado = 'A')		
	end	
	else
	if(@ACCION = 'LISTARPAGAUTORIZA')
	begin
		
	
		SET @CONTADOR=(SELECT COUNT(segAutiriza.Usuario) 
					FROM Usuario  inner join SEGURIDADAUTORIZACIONES segAutiriza
					on (segAutiriza.USUARIO =Usuario.Usuario ) 
					WHERE 
					(@USUARIO is null OR USUARIO.Usuario = @USUARIO)
					and (@USUARIOPERFIL is null OR UsuarioPerfil = @USUARIOPERFIL)
					and (@NOMBRE is null  OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')							
					and (@ESTADO is null OR USUARIO.Estado = @ESTADO)		
					)
					
		SELECT 
				Usuario as Usuario1		 
			  ,[USUARIOPERFIL]
			  ,[PERSONA]
			  ,[TIPOPERSONA]
			  ,[NOMBRE]
			  ,[CLAVE]
			  ,[EXPIRARPASSWORDFLAG]
			  ,[FECHAEXPIRACION]
			  ,[ULTIMOLOGIN]
			  ,[NUMEROLOGINSDISPONIBLE]
			  ,[NUMEROLOGINSUSADOS]
			  ,[USUARIORED]
			  ,[SQLLOGIN]
				,[SQLPASSWORD]
			  ,[ESTADO]
			  ,[ULTIMOUSUARIO]
			  ,[ULTIMAFECHAMODIF]
			  ,[ACCION]		   
		FROM (SELECT DISTINCT Usuario.Usuario,
						   Clave,
						   PERSONA,
						   TIPOPERSONA,
						   ExpirarPasswordFlag,
						   FechaExpiracion,
						   UltimoLogin,
						   NumeroLoginsDisponible,
						   Usuario.Estado,
						   Usuario.UltimaFechaModif,
						   Usuario.UltimoUsuario,
						   NumeroLoginsUsados,
						   (case UsuarioPerfil 
						   when 'US' then 'Usuario'
						   when 'PE' then 'Perfil'  else '--' end) as UsuarioPerfil,
						   --UsuarioPerfil,
						   Nombre,
						   SQLLOGIN,
						   SQLPASSWORD,
						   UsuarioRed,
						   Usuario.accion,						   
						   @CONTADOR AS Contador,
					       ROW_NUMBER() OVER (ORDER BY Usuario.Usuario ASC ) AS RowNumber    
					FROM Usuario  
					WHERE 
					(@USUARIO is null OR USUARIO.Usuario = @USUARIO)
					and (Usuario.USUARIO In (select USUARIO from SEGURIDADAUTORIZACIONES
								where (@USUARIO is null OR SEGURIDADAUTORIZACIONES.Usuario = @USUARIO) )) 
					
					and (@USUARIOPERFIL is null OR UsuarioPerfil = @USUARIOPERFIL)
					and (@NOMBRE is null  OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')							
					and (@ESTADO is null OR USUARIO.Estado = @ESTADO)
					
					
					) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
	end		
	else
	if(@ACCION = 'LISTARPERFILES' OR @ACCION = 'LISTARUSUARIOS')
	begin
		if(@ACCION = 'LISTARPERFILES')
			set @USUARIOPERFIL='PE'
		if(@ACCION = 'LISTARUSUARIOS')
			set @USUARIOPERFIL='US'
		 
		SELECT 
				Usuario as Usuario1		 
			  ,[USUARIOPERFIL]
			  ,[PERSONA]
			  ,[TIPOPERSONA]
			  ,[NOMBRE]
			  ,[CLAVE]
			  ,[EXPIRARPASSWORDFLAG]
			  ,[FECHAEXPIRACION]
			  ,[ULTIMOLOGIN]
			  ,[NUMEROLOGINSDISPONIBLE]
			  ,[NUMEROLOGINSUSADOS]
			  ,[USUARIORED]
			  ,[SQLLOGIN]
			  ,[SQLPASSWORD]
			  ,[ESTADO]
			  ,[ULTIMOUSUARIO]
			  ,[ULTIMAFECHAMODIF]
			  ,[ACCION]		   
					FROM Usuario  
					WHERE 
					(@USUARIO is null OR Usuario = @USUARIO)					
					and (@NOMBRE is null  OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')							
					and (@ESTADO is null OR Estado = @ESTADO)
					and (UsuarioPerfil = @USUARIOPERFIL)
	end		
	--select * from SEGURIDADAUTORIZACIONES
	
END
/*
exec SP_USUARIOS_LISTAR
exec [dbo].[SP_USUARIOS_LISTAR] @Usuario=NULL,@Clave=NULL,@USUARIOPERFIL=NULL,@PERSONA=NULL,@NOMBRE=NULL,@ESTADO=NULL,@INICIO=0,@NUMEROFILAS=20,@ACCION='LISTARPAG'
*/

GO
/****** Object:  StoredProcedure [dbo].[SP_V_EpisodioAtenciones]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_V_EpisodioAtenciones]
(
	@Persona	int
	,@NombreCompleto	varchar(100)	
	,@UnidadReplicacion		char(4)
	,@IdEpisodioAtencion		bigint
	,@UnidadReplicacionEC		char(4)
	
	,@IdPaciente		int
	,@EpisodioClinico		int
	,@IdEstablecimientoSalud		int
	,@IdUnidadServicio		int
	,@IdPersonalSalud		int	
	
	,@EpisodioAtencion		int
	,@TipoAtencion		int
	,@IdOrdenAtencion	int
	,@TipoOrdenAtencion		int	
	,@Estado_EpisodioAten	int
	
	,@FechaRegistroDesde		datetime
	,@FechaRegistroHasta		datetime
	,@FechaAtencion		datetime
	,@FechaCierre		datetime	
	,@UsuarioModificacion		varchar(25), ---AUX  ACCION FORM
			
	@INICIO		int= null,  
	@NUMEROFILAS		int = null ,
	@Version		VARCHAR(25)	,
	@ACCION		VARCHAR(25)
)

AS
BEGIN
	DECLARE @CODIGOOA varchar(20)
	DECLARE @CONTADOR INT =0
	DECLARE @COD_FORMATO_AUX varchar(30)
	
	if(@ACCION = 'LISTARPAG')
	begin		
			set @CODIGOOA = @Version
			if(@UsuarioModificacion is not null)
			begin
				select @COD_FORMATO_AUX = SS_HC_Formato.CodigoFormato from SG_Opcion
				left join SS_HC_Formato on (SS_HC_Formato.IdFormato = SG_Opcion.IdFormato)
				where SG_Opcion.IdOpcion = convert(int ,@UsuarioModificacion)
			end
			
		declare @CONTADOR_DIN int =0			
			select @CONTADOR_DIN= count(*)
				from SS_HC_EpisodioAtencionFormato EpiAtencionFormato											
				where 
				EpiAtencionFormato.UnidadReplicacion= @UnidadReplicacion
						and  EpiAtencionFormato.EpisodioClinico= @EpisodioClinico
							and EpiAtencionFormato.IdEpisodioAtencion= @IdEpisodioAtencion
							and  EpiAtencionFormato.IdPaciente= @IdPaciente					
							
										
			
		SELECT @CONTADOR= COUNT(*) 					
					FROM dbo.V_EpisodioAtenciones
						left join SS_HC_EpisodioAtencion epiAtencion
						on (epiAtencion.EpisodioClinico = V_EpisodioAtenciones.EpisodioClinico
							and epiAtencion.IdEpisodioAtencion = V_EpisodioAtenciones.IdEpisodioAtencion
							and epiAtencion.UnidadReplicacion = V_EpisodioAtenciones.UnidadReplicacion
							and epiAtencion.IdPaciente = V_EpisodioAtenciones.IdPaciente
							and epiAtencion.IdOrdenAtencion = V_EpisodioAtenciones.IdOrdenAtencion
						)											
					WHERE 
					(@Persona is null or (@Persona =0 ) OR Persona = @Persona)
					and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones.IdPaciente = @IdPaciente)
					and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
					and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
					and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones.IdOrdenAtencion = @IdOrdenAtencion)
					and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones.Accion = @COD_FORMATO_AUX)
					and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
	 	 
		select @CONTADOR + @CONTADOR_DIN
	end	
	ELSE
	if(@ACCION = 'LISTARCOPYPAG')
	begin	
			set @CODIGOOA = @Version
			if(@UsuarioModificacion is not null)
			begin
				select @COD_FORMATO_AUX = SS_HC_Formato.CodigoFormato from SG_Opcion
				left join SS_HC_Formato on (SS_HC_Formato.IdFormato = SG_Opcion.IdFormato)
				where SG_Opcion.IdOpcion = convert(int ,@UsuarioModificacion)
			end	
		SELECT @CONTADOR= COUNT(*) 					
					FROM dbo.V_EpisodioAtenciones
						left join SS_HC_EpisodioAtencion epiAtencion
						on (epiAtencion.EpisodioClinico = V_EpisodioAtenciones.EpisodioClinico
							and epiAtencion.IdEpisodioAtencion = V_EpisodioAtenciones.IdEpisodioAtencion
							and epiAtencion.UnidadReplicacion = V_EpisodioAtenciones.UnidadReplicacion
							and epiAtencion.IdPaciente = V_EpisodioAtenciones.IdPaciente
							and epiAtencion.IdOrdenAtencion = V_EpisodioAtenciones.IdOrdenAtencion
						)											
					WHERE 
					(@Persona is null or (@Persona =0 ) OR Persona = @Persona)
					and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones.IdPaciente = @IdPaciente)
					and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
					and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
					and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones.IdOrdenAtencion = @IdOrdenAtencion)
					and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones.Accion = @COD_FORMATO_AUX)
					and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
	 	 
		select @CONTADOR 
	END	


END
/*
exec SP_V_EpisodioAtenciones 
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
		
	NULL,
	NULL,
	NULL,
	NULL,
	'CCEP0202',
			
	0,  
	100,
	null,
	'LISTARPAG'	
*/

GO
/****** Object:  StoredProcedure [dbo].[SP_ValoracionAM_FE]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_ValoracionAM_FE]
	@UnidadReplicacion		char(4) ,
	@IdEpisodioAtencion		bigint ,
	@IdPaciente				int ,
	@EpisodioClinico		int ,
	@Categoria			char(1),
	@Estado					int,
	@UsuarioCreacion		varchar(25),
	@FechaCreacion			datetime,
	@UsuarioModificacion	varchar(25),
	@FechaModificacion		datetime,
	@Accion					varchar(25),
	@Version				varchar(25)
	
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @IdEpisodioAtencionId as INTEGER
	DECLARE @EpisodioClinicoID as INTEGER
	DECLARE @ExisteCodigo as VARCHAR(10)
	DECLARE @SecuenciaID as Integer

	SET @IdEpisodioAtencionId = @IdEpisodioAtencion

	
  
 IF @ACCION ='LISTAR'  
  BEGIN  
    Select * From   dbo.SS_HC_ValoracionAM_FE   
    Where IdPaciente = @IdPaciente   
    and EpisodioClinico = @EpisodioClinico  
    and IdEpisodioAtencion = @IdEpisodioAtencion  
    and UnidadReplicacion = @UnidadReplicacion  
  END  
  IF @ACCION ='LISTARTOP'  
  BEGIN  

	
    Select TOP 1 * From   dbo.SS_HC_ValoracionAM_FE   
	  inner join SS_HC_EpisodioAtencion epi on epi.IdPaciente=SS_HC_ValoracionAM_FE.IdPaciente 
    Where SS_HC_ValoracionAM_FE.IdPaciente = @IdPaciente 
	and epi.CodigoOA=  @Version
    /*and EpisodioClinico = @EpisodioClinico  
    and IdEpisodioAtencion = @IdEpisodioAtencion */ 
    and SS_HC_ValoracionAM_FE.UnidadReplicacion = @UnidadReplicacion  
    ORDER BY SS_HC_ValoracionAM_FE.EpisodioClinico DESC, SS_HC_ValoracionAM_FE.IdEpisodioAtencion DESC
  END  


END
GO
/****** Object:  StoredProcedure [dbo].[SP_ValoracionFuncionalAM_FE]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_ValoracionFuncionalAM_FE]
	@UnidadReplicacion		char(4) ,
	@IdEpisodioAtencion		bigint ,
	@IdPaciente				int ,
	@EpisodioClinico		int ,
	@Lavarse char (1),
	@Vestirse char(1),
	@UsoServHigienico char(1),
	@Movilizarse char(1),
	@Continencia char (1),
	@Alimentarse char(1),
	@DiagnosticoFuncional char(2),
	@Estado					int,
	@UsuarioCreacion		varchar(25),
	@FechaCreacion			datetime,
	@UsuarioModificacion	varchar(25),
	@FechaModificacion		datetime,
	@Accion					varchar(25),
	@Version				varchar(25)

AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @IdEpisodioAtencionId as INTEGER
	DECLARE @EpisodioClinicoID as INTEGER
	DECLARE @ExisteCodigo as VARCHAR(10)
	DECLARE @SecuenciaID as Integer

	SET @IdEpisodioAtencionId = @IdEpisodioAtencion

	
  
 IF @ACCION ='LISTAR'  
  BEGIN  
    Select * From   dbo.SS_HC_ValoracionFuncionalAM_FE   
    Where IdPaciente = @IdPaciente   
    and EpisodioClinico = @EpisodioClinico  
    and IdEpisodioAtencion = @IdEpisodioAtencion  
    and UnidadReplicacion = @UnidadReplicacion  
  END  
  IF @ACCION ='LISTARTOP'  
  BEGIN  

	
    Select TOP 1 * From   dbo.SS_HC_ValoracionFuncionalAM_FE   
	  inner join SS_HC_EpisodioAtencion epi on epi.IdPaciente=SS_HC_ValoracionFuncionalAM_FE.IdPaciente 
    Where SS_HC_ValoracionFuncionalAM_FE.IdPaciente = @IdPaciente 
	and epi.CodigoOA=  @Version
    and SS_HC_ValoracionFuncionalAM_FE.UnidadReplicacion = @UnidadReplicacion  
    ORDER BY SS_HC_ValoracionFuncionalAM_FE.EpisodioClinico DESC, SS_HC_ValoracionFuncionalAM_FE.IdEpisodioAtencion DESC
  END  


END
GO
/****** Object:  StoredProcedure [dbo].[SP_ValoracionMentalAM_FE]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[SP_ValoracionMentalAM_FE]
	@UnidadReplicacion		char(4) ,
	@IdEpisodioAtencion		bigint ,
	@IdPaciente				int ,
	@EpisodioClinico		int ,
	@Cualfecha int,
	@QueDiasemana int,
	@EnquelugarEstamos int,
	@CualNumerotelefono int,
	@CuantosAniostiene int,
	@DondeNacio int,
	@NombrePresidente int,
	@NombrePresidenteAnterior int,
	@ApellidoMadre int,
	@Restar int,
	@ValorCognitiva char (3),
	@Satisfecho int,
	@Impotente int,
	@Memoria int,
	@desgano int,
	@EstadoAfectivo char (1),
	@Estado int,
	@UsuarioCreacion char (25),
	@FechaCreacion datetime,
	@UsuarioModificacion varchar(25),
	@FechaModificacion datetime,
	@Accion varchar (25),
	@Version varchar (25)


AS
BEGIN
	SET NOCOUNT ON;
	   
 IF @ACCION ='LISTAR'  
  BEGIN  
    Select * From   SS_HC_ValoracionMentalAM_FE  
    Where IdPaciente = @IdPaciente   
    and IdEpisodioAtencion = @IdEpisodioAtencion  
    and EpisodioClinico = @EpisodioClinico  
  END  
  IF @ACCION ='LISTARTOP'  
  BEGIN  
  	
    Select TOP 1 * From   dbo.SS_HC_ValoracionMentalAM_FE  
	  inner join SS_HC_EpisodioAtencion epi on epi.IdPaciente=SS_HC_ValoracionMentalAM_FE.IdPaciente 
    Where SS_HC_ValoracionMentalAM_FE.IdPaciente = @IdPaciente 
	and epi.CodigoOA=  @Version
    and SS_HC_ValoracionMentalAM_FE.UnidadReplicacion = @UnidadReplicacion  
    ORDER BY SS_HC_ValoracionMentalAM_FE.EpisodioClinico DESC, SS_HC_ValoracionMentalAM_FE.IdEpisodioAtencion DESC
  END  


END

SELECT*FROM SS_HC_ValoracionMentalAM_FE
GO
/****** Object:  StoredProcedure [dbo].[SP_ValracionSocioFamAM_FE]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[SP_ValracionSocioFamAM_FE]
	@UnidadReplicacion		char(4) ,
	@IdEpisodioAtencion		bigint ,
	@IdPaciente				int ,
	@EpisodioClinico		int ,
	@SituacionSocial char (1),
	@SituacionEconomica char (1),
	@Vivienda char (1),
	@RelacionesSociales char (1),
	@ApoyoRedSocial char (1),
	@Valoracion char (1),
	@Estado int,
	@UsuarioCreacion varchar (25),
	@FechaCreacion datetime,
	@UsuarioModificacion varchar (25),
	@FechaModificacion datetime ,
	@Accion varchar (25),
	@Version varchar (25)

AS
BEGIN
	

 IF @ACCION ='LISTAR'  
  BEGIN  
    Select * From   SS_HC_ValoracionSocioFamAM_FE  
    Where IdPaciente = @IdPaciente   
    and IdEpisodioAtencion = @IdEpisodioAtencion  
    and EpisodioClinico = @EpisodioClinico  
  END  
  IF @ACCION ='LISTARTOP'  
  BEGIN  

	
    Select TOP 1 * From   dbo.SS_HC_ValoracionSocioFamAM_FE  
	  inner join SS_HC_EpisodioAtencion epi on epi.IdPaciente=SS_HC_ValoracionSocioFamAM_FE.IdPaciente 
    Where SS_HC_ValoracionSocioFamAM_FE.IdPaciente = @IdPaciente 
	and epi.CodigoOA=  @Version
    /*and EpisodioClinico = @EpisodioClinico  
    and IdEpisodioAtencion = @IdEpisodioAtencion */ 
    and SS_HC_ValoracionSocioFamAM_FE.UnidadReplicacion = @UnidadReplicacion  
    ORDER BY SS_HC_ValoracionSocioFamAM_FE.EpisodioClinico DESC, SS_HC_ValoracionSocioFamAM_FE.IdEpisodioAtencion DESC
  END  


END

SELECT*FROM SS_HC_ValoracionMentalAM_FE
GO
/****** Object:  StoredProcedure [dbo].[SP_VW_ATENCIONPACIENTE]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_VW_ATENCIONPACIENTE]
(
	@UnidadReplicacion		char(4)
	,@IdEpisodioAtencion		bigint
	,@UnidadReplicacionEC		char(4)
	,@IdPaciente		int
	,@EpisodioClinico		int
	,@IdEstablecimientoSalud		int
	,@IdUnidadServicio		int
	,@IdPersonalSalud		int
	,@aaaaAtencion	int
	,@EpisodioAtencion		bigint
	
	,@FechaRegistro		datetime
	,@FechaAtencion		datetime
	,@TipoAtencion		int
	,@IdOrdenAtencion	int
	,@LineaOrdenAtencion	int	
	,@TipoOrdenAtencion		int
	,@Estado	int
	,@UsuarioModificacion	varchar(25)
	,@FechaModificacion		datetime
	,@IdEspecialidad	int
	
	,@CodigoOA		varchar(25)
	,@FechaOrden	datetime	
	,@IdProcedimiento		int	
	,@IdTipoOrden		int	
	,@FechaRegistroEpiClinico		datetime
	,@FechaCierreEpiClinico		datetime
	,@TipoPaciente		int
	,@Edad		int
	,@CodigoHC	varchar(25)	
	,@CodigoHCAnterior		varchar(25)
	
	,@CodigoHCSecundario		varchar(25)
	,@TipoHistoria		varchar(1)
	,@EstadoPaciente	int	
	,@NumeroFile		int	
	,@IDPACIENTE_OK		int
	,@Persona	int
	,@NombreCompleto		varchar(100)
	,@TipoDocumento		char(1)
	,@Documento		char(20)
	,@EsCliente	char(1)	
	
	,@EsProveedor		char(1)
	,@EsEmpleado		char(1)
	,@EsOtro		char(1)
	,@TipoPersona		char(1)
	,@FechaNacimiento		datetime
	,@Sexo		char(1)	
	,@Nacionalidad		char(20)
	,@EstadoCivil		char(1)
	,@NivelInstruccion		char(3)	
	,@CodigoPostal		char(3)
	
	,@Provincia		char(1)
	,@Departamento		char(1)
	,@FecIniDiscamec		datetime	
	,@FecFinDiscamec		datetime
	,@Pais		char(4)
	,@EsPaciente	char(1)
	,@EsEmpresa		char(1)
	,@personanew		int
	,@EstadoPersona		char(1)
	,@Servicio	varchar(25),
			
	@INICIO		int= null,  
	@NUMEROFILAS		int = null ,
	@Version		VARCHAR(25)	,
	@ACCION		VARCHAR(50)
)

AS
BEGIN
	DECLARE @CONTADOR INT =0
	
	if(@ACCION = 'CONTARLISTAPAGSELEC')
	begin		
		
         if(@Servicio ='CC' or @Servicio is null)  ---AUXILIAR
         begin
				SELECT @CONTADOR= COUNT(*) 					
							FROM dbo.VW_ATENCIONPACIENTE
							where 
							((IdEpisodioAtencion is null and @Servicio ='CC')
							or (@Servicio is null)
							)
							and (@CodigoHC is null OR CodigoHC = @CodigoHC)
							and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)
							and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')
							and (@CodigoOA is null OR VW_ATENCIONPACIENTE.CodigoOA = @CodigoOA)
							--OBS--and (@IdPersonalSalud is null OR VW_ATENCIONPACIENTE.IdPersonalSalud = @IdPersonalSalud)
							and ( 
								(@FecIniDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion >= @FecIniDiscamec)
								and
								(@FecFinDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion <= @FecFinDiscamec)
							)	
							----
							and(VW_ATENCIONPACIENTE.EsEmpleado is null or VW_ATENCIONPACIENTE.EsEmpleado <> 'S') 
							and(VW_ATENCIONPACIENTE.TipoPersona is null or VW_ATENCIONPACIENTE.TipoPersona <> 'J') 
							and (VW_ATENCIONPACIENTE.Persona in (select IDPACIENTE from SS_GE_Paciente))
																			
		end
		else	
	    if(@Servicio ='CA')  ---AUXILIAR
         begin
         				SELECT @CONTADOR= COUNT(*) 					
							FROM dbo.VW_ATENCIONPACIENTE WITH(NOLOCK)
								inner join SS_HC_EpisodioAtencion EpiAten WITH(NOLOCK) on 
							(VW_ATENCIONPACIENTE.UnidadReplicacion=EpiAten.UnidadReplicacion 
							and VW_ATENCIONPACIENTE.IdEpisodioAtencion=EpiAten.IdEpisodioAtencion --OBS: EpisodioAtencion??
							and VW_ATENCIONPACIENTE.UnidadReplicacionEC=EpiAten.UnidadReplicacionEC 
							and VW_ATENCIONPACIENTE.IdPaciente=EpiAten.IdPaciente 
							and VW_ATENCIONPACIENTE.EpisodioClinico=EpiAten.EpisodioClinico 
							)
							where
							1=1
							and (@CodigoHC is null OR CodigoHC = @CodigoHC)
							and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)
							and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')
							and (@CodigoOA is null OR VW_ATENCIONPACIENTE.CodigoOA = @CodigoOA)
							--and (@IdPersonalSalud is null OR VW_ATENCIONPACIENTE.IdPersonalSalud = @IdPersonalSalud)
							and ( 
								(@FecIniDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion >= @FecIniDiscamec)
								and
								(@FecFinDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion <= @FecFinDiscamec)
							)		
							----
							and(VW_ATENCIONPACIENTE.EsEmpleado is null or VW_ATENCIONPACIENTE.EsEmpleado <> 'S') 
							and(VW_ATENCIONPACIENTE.TipoPersona is null or VW_ATENCIONPACIENTE.TipoPersona <> 'J') 
							and (VW_ATENCIONPACIENTE.Persona in (select IDPACIENTE from SS_GE_Paciente))
												
         end         
	 
		select @CONTADOR
	end	
	ELSE
	if(@ACCION = 'LISTARPAG')
	begin		
	
		 SELECT @CONTADOR= COUNT(*)          
     FROM dbo.VW_ATENCIONPACIENTE    WITH(NOLOCK)
       inner join SS_HC_EpisodioAtencion					WITH(NOLOCK)	on (SS_HC_EpisodioAtencion.UnidadReplicacion = VW_ATENCIONPACIENTE.UnidadReplicacion
      -- and    SS_HC_EpisodioAtencion.IdEpisodioAtencion = VW_ATENCIONPACIENTE.IdEpisodioAtencion
       and    SS_HC_EpisodioAtencion.IdOrdenAtencion = VW_ATENCIONPACIENTE.IdOrdenAtencion
	    and    SS_HC_EpisodioAtencion.CodigoOA = VW_ATENCIONPACIENTE.CodigoOA
		and SS_HC_EpisodioAtencion.EpisodioClinico=VW_ATENCIONPACIENTE.EpisodioClinico
		and SS_HC_EpisodioAtencion.EpisodioAtencion=VW_ATENCIONPACIENTE.EpisodioAtencion
		and SS_HC_EpisodioAtencion.IdEpisodioAtencion=VW_ATENCIONPACIENTE.IdEpisodioAtencion
       and    SS_HC_EpisodioAtencion.IdPaciente = VW_ATENCIONPACIENTE.IdPaciente )           
       left join CM_CO_TablaMaestroDetalle TipoPaciente     WITH(NOLOCK)	on (TipoPaciente.IdCodigo = VW_ATENCIONPACIENTE.TipoPaciente            and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
       left join SS_GE_TipoAtencion TipoAtencion			WITH(NOLOCK)	on (TipoAtencion.IdTipoAtencion = VW_ATENCIONPACIENTE.TipoAtencion)    
       left join PERSONAMAST personaPaciente				WITH(NOLOCK)	on (personaPaciente.Persona = VW_ATENCIONPACIENTE.idPaciente)                     
		 WHERE     
      (@NumeroFile is null or isnull(VW_ATENCIONPACIENTE.EstadoAsigMed,0)=@NumeroFile)
       and (@CodigoHC is null OR CodigoHC = @CodigoHC)    
       and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
       and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       --and (@CodigoOA is null OR VW_ATENCIONPACIENTE.CodigoOA = @CodigoOA)    
       and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
       --OBS--and (@IdPersonalSalud is null OR VW_ATENCIONPACIENTE.IdPersonalSalud = @IdPersonalSalud)    
       and (     
        (@FecIniDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion >= @FecIniDiscamec)    
        and    
        (@FecFinDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion <= DATEADD(DAY,1,@FecFinDiscamec))    
       )    
       and (@IdPaciente is null OR personaPaciente.Persona = @IdPaciente or  @IdPaciente=0)            
       ---
       and (@IdOrdenAtencion is null OR VW_ATENCIONPACIENTE.IdOrdenAtencion = @IdOrdenAtencion or  @IdOrdenAtencion=0)           
                     
       -----
       and (@Servicio is null OR SS_HC_EpisodioAtencion.TipoEpisodio = @Servicio )           
       
       and (@Estado is null or     
        (case     
         when VW_ATENCIONPACIENTE.Estado IS null     
         then 0 else VW_ATENCIONPACIENTE.Estado   
        end ) = @Estado)     
	 
			select @CONTADOR
		end	

	if(@ACCION = 'LISTARPAGDIS')
	begin		
	
		 SELECT @CONTADOR= COUNT(*)          
     FROM dbo.VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS    WITH(NOLOCK)
       inner join SS_HC_EpisodioAtencion				WITH(NOLOCK)	on (SS_HC_EpisodioAtencion.UnidadReplicacion = VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.UnidadReplicacion
      -- and    SS_HC_EpisodioAtencion.IdEpisodioAtencion = VW_ATENCIONPACIENTE.IdEpisodioAtencion
       and    SS_HC_EpisodioAtencion.IdOrdenAtencion = VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.IdOrdenAtencion
	    and    SS_HC_EpisodioAtencion.CodigoOA = VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.CodigoOA
		and SS_HC_EpisodioAtencion.EpisodioClinico=VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.EpisodioClinico
		and SS_HC_EpisodioAtencion.EpisodioAtencion=VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.EpisodioAtencion
		and SS_HC_EpisodioAtencion.IdEpisodioAtencion=VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.IdEpisodioAtencion
       and    SS_HC_EpisodioAtencion.IdPaciente = VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.IdPaciente )           
       left join CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK)	on (TipoPaciente.IdCodigo = VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.TipoPaciente and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
       left join SS_GE_TipoAtencion TipoAtencion		WITH(NOLOCK)    on (TipoAtencion.IdTipoAtencion = VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.TipoAtencion)    
       left join PERSONAMAST personaPaciente			WITH(NOLOCK)	on (personaPaciente.Persona = VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.idPaciente)                     
		 WHERE     
      (@NumeroFile is null or isnull(VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.EstadoAsigMed,0)=@NumeroFile)
       and (@CodigoHC is null OR CodigoHC = @CodigoHC)    
       and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
       and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       --and (@CodigoOA is null OR VW_ATENCIONPACIENTE.CodigoOA = @CodigoOA)    
       and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
       --OBS--and (@IdPersonalSalud is null OR VW_ATENCIONPACIENTE.IdPersonalSalud = @IdPersonalSalud)    
       and (     
        (@FecIniDiscamec is null or  VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.FechaAtencion >= @FecIniDiscamec)    
        and    
        (@FecFinDiscamec is null or  VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.FechaAtencion <= DATEADD(DAY,1,@FecFinDiscamec))    
       )    
       and (@IdPaciente is null OR personaPaciente.Persona = @IdPaciente or  @IdPaciente=0)    
      and (@EpisodioClinico is null OR VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.EpisodioClinico = @EpisodioClinico or  @EpisodioClinico=0)    
      and (@EpisodioAtencion is null OR VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.IdEpisodioAtencion = @EpisodioAtencion or  @EpisodioAtencion=0)           
       ---

       and (@IdOrdenAtencion is null OR VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.IdOrdenAtencion = @IdOrdenAtencion or  @IdOrdenAtencion=0)           
       --and (@LineaOrdenAtencion is null OR VW_ATENCIONPACIENTE.LineaOrdenAtencion = @LineaOrdenAtencion or  @LineaOrdenAtencion=0)                         
       -----
       and (@Servicio is null OR SS_HC_EpisodioAtencion.TipoEpisodio = @Servicio )           
       
       and (@Estado is null or     
        (case     
         when VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.Estado IS null     
         then 0 else VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.Estado   
        end ) = @Estado)     
	 
			select @CONTADOR
		end	


	ELSE
	if(@ACCION = 'LISTARESPE') -- luke 09/03/2020
	begin		
	
		 SELECT @CONTADOR= COUNT(*)          
     FROM dbo.VW_ATENCIONPACIENTE			WITH(NOLOCK)
       inner join SS_HC_EpisodioAtencion					WITH(NOLOCK)	on (SS_HC_EpisodioAtencion.UnidadReplicacion = VW_ATENCIONPACIENTE.UnidadReplicacion
      -- and    SS_HC_EpisodioAtencion.IdEpisodioAtencion = VW_ATENCIONPACIENTE.IdEpisodioAtencion
       and    SS_HC_EpisodioAtencion.IdOrdenAtencion = VW_ATENCIONPACIENTE.IdOrdenAtencion
	    and    SS_HC_EpisodioAtencion.CodigoOA = VW_ATENCIONPACIENTE.CodigoOA
		and SS_HC_EpisodioAtencion.EpisodioClinico=VW_ATENCIONPACIENTE.EpisodioClinico
		and SS_HC_EpisodioAtencion.EpisodioAtencion=VW_ATENCIONPACIENTE.EpisodioAtencion
		and SS_HC_EpisodioAtencion.IdEpisodioAtencion=VW_ATENCIONPACIENTE.IdEpisodioAtencion
       and    SS_HC_EpisodioAtencion.IdPaciente = VW_ATENCIONPACIENTE.IdPaciente )           
       left join CM_CO_TablaMaestroDetalle TipoPaciente		WITH(NOLOCK)       on (TipoPaciente.IdCodigo = VW_ATENCIONPACIENTE.TipoPaciente	and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
       left join SS_GE_TipoAtencion TipoAtencion			WITH(NOLOCK)       on (TipoAtencion.IdTipoAtencion = VW_ATENCIONPACIENTE.TipoAtencion)    
       left join PERSONAMAST personaPaciente				WITH(NOLOCK)       on (personaPaciente.Persona = VW_ATENCIONPACIENTE.idPaciente)                     
		 WHERE     
      (@NumeroFile is null or isnull(VW_ATENCIONPACIENTE.EstadoAsigMed,0)=@NumeroFile)
       and (@CodigoHC is null OR CodigoHC = @CodigoHC)    
       and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
       and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       --and (@CodigoOA is null OR VW_ATENCIONPACIENTE.CodigoOA = @CodigoOA)    
       and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
       --OBS--and (@IdPersonalSalud is null OR VW_ATENCIONPACIENTE.IdPersonalSalud = @IdPersonalSalud)    
       and (     
        (@FecIniDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion >= @FecIniDiscamec)    
        and    
        (@FecFinDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion <= DATEADD(DAY,1,@FecFinDiscamec))    
       )    
       and (@IdPaciente is null OR personaPaciente.Persona = @IdPaciente or  @IdPaciente=0)    
       and (@IdOrdenAtencion is null OR VW_ATENCIONPACIENTE.IdOrdenAtencion = @IdOrdenAtencion or  @IdOrdenAtencion=0)           
       --and (@LineaOrdenAtencion is null OR VW_ATENCIONPACIENTE.LineaOrdenAtencion = @LineaOrdenAtencion or  @LineaOrdenAtencion=0)                         
       -----
       and (@Servicio is null OR SS_HC_EpisodioAtencion.TipoEpisodio = @Servicio )           
        and (@IdEspecialidad is null OR VW_ATENCIONPACIENTE.IdEspecialidad = @IdEspecialidad )   
       and (@Estado is null or     
        (case     
         when VW_ATENCIONPACIENTE.Estado IS null     
         then 0 else VW_ATENCIONPACIENTE.Estado   
        end ) = @Estado)     
	 
			select @CONTADOR
		end	
	ELSE	
	if(@ACCION = 'LISTARPAG_FIRMAMEDICO')
	begin		
	
		 SELECT @CONTADOR= COUNT(*)          
     FROM dbo.VW_ATENCIONPACIENTE    WITH(NOLOCK)
       inner join SS_HC_EpisodioAtencion				WITH(NOLOCK)	on (SS_HC_EpisodioAtencion.UnidadReplicacion = VW_ATENCIONPACIENTE.UnidadReplicacion
       and    SS_HC_EpisodioAtencion.IdEpisodioAtencion = VW_ATENCIONPACIENTE.IdEpisodioAtencion
       and    SS_HC_EpisodioAtencion.EpisodioClinico = VW_ATENCIONPACIENTE.EpisodioClinico
       and    SS_HC_EpisodioAtencion.IdPaciente = VW_ATENCIONPACIENTE.IdPaciente       
       )            
       left join CM_CO_TablaMaestroDetalle TipoPaciente	WITH(NOLOCK)	on (TipoPaciente.IdCodigo = VW_ATENCIONPACIENTE.TipoPaciente    
        and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
       left join SS_GE_TipoAtencion TipoAtencion		WITH(NOLOCK)	on (TipoAtencion.IdTipoAtencion = VW_ATENCIONPACIENTE.TipoAtencion)    
       left join PERSONAMAST personaPaciente			WITH(NOLOCK)	on (personaPaciente.Persona = VW_ATENCIONPACIENTE.idPaciente)                     
		 WHERE     
      (@NumeroFile is null or isnull(VW_ATENCIONPACIENTE.EstadoAsigMed,0)=@NumeroFile)
       and (@CodigoHC is null OR CodigoHC = @CodigoHC)    
       and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
       and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       --and (@CodigoOA is null OR VW_ATENCIONPACIENTE.CodigoOA = @CodigoOA)    
       and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
       --OBS--and (@IdPersonalSalud is null OR VW_ATENCIONPACIENTE.IdPersonalSalud = @IdPersonalSalud)    
       and (     
        (@FecIniDiscamec is null or  VW_ATENCIONPACIENTE.FechaOrden/*FechaAtencion*/ >= @FecIniDiscamec)    
        and    
        (@FecFinDiscamec is null or  VW_ATENCIONPACIENTE.FechaOrden/*FechaAtencion-CAMBIADO ISABELA191017 FECHACITA*/ </*=*/ DATEADD(DAY,1,@FecFinDiscamec))    
       )    
       and (@IdPaciente is null OR personaPaciente.Persona = @IdPaciente or  @IdPaciente=0)    
       and (@EpisodioClinico is null OR VW_ATENCIONPACIENTE.EpisodioClinico = @EpisodioClinico or  @EpisodioClinico=0)    
       and (@EpisodioAtencion is null OR VW_ATENCIONPACIENTE.EpisodioAtencion = @EpisodioAtencion or  @EpisodioAtencion=0)           
       ---
       and (@IdOrdenAtencion is null OR VW_ATENCIONPACIENTE.IdOrdenAtencion = @IdOrdenAtencion or  @IdOrdenAtencion=0)           
       and (@LineaOrdenAtencion is null OR VW_ATENCIONPACIENTE.LineaOrdenAtencion = @LineaOrdenAtencion or  @LineaOrdenAtencion=0)                         
       -----
       and (@Servicio is null OR SS_HC_EpisodioAtencion.TipoEpisodio = @Servicio )           
       
       and (@Estado is null or     
        (case     
         when VW_ATENCIONPACIENTE.Estado IS null     
         then 0 else VW_ATENCIONPACIENTE.Estado   
        end ) = @Estado)     
	 
			select @CONTADOR
		end	
	ELSE



	
	if(@ACCION = 'LISTARFARMACO')
	begin		
	
		 SELECT @CONTADOR= COUNT(*)          
     FROM dbo.VW_ATENCIONPACIENTE_NOFARMACOLOGICO    WITH(NOLOCK)
       inner join SS_HC_EpisodioAtencion					WITH(NOLOCK)	on (SS_HC_EpisodioAtencion.UnidadReplicacion = VW_ATENCIONPACIENTE_NOFARMACOLOGICO.UnidadReplicacion
       and    SS_HC_EpisodioAtencion.IdEpisodioAtencion = VW_ATENCIONPACIENTE_NOFARMACOLOGICO.IdEpisodioAtencion
       and    SS_HC_EpisodioAtencion.EpisodioClinico = VW_ATENCIONPACIENTE_NOFARMACOLOGICO.EpisodioClinico
	   and    SS_HC_EpisodioAtencion.CodigoOA=VW_ATENCIONPACIENTE_NOFARMACOLOGICO.CodigoOA
       and    SS_HC_EpisodioAtencion.IdPaciente = VW_ATENCIONPACIENTE_NOFARMACOLOGICO.IdPaciente       
       )            
       left join CM_CO_TablaMaestroDetalle TipoPaciente		WITH(NOLOCK)	on (TipoPaciente.IdCodigo = VW_ATENCIONPACIENTE_NOFARMACOLOGICO.TipoPaciente    
        and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
       left join SS_GE_TipoAtencion TipoAtencion			WITH(NOLOCK)	on (TipoAtencion.IdTipoAtencion = VW_ATENCIONPACIENTE_NOFARMACOLOGICO.TipoAtencion)    
       left join PERSONAMAST personaPaciente				WITH(NOLOCK)	on (personaPaciente.Persona = VW_ATENCIONPACIENTE_NOFARMACOLOGICO.idPaciente)                     
		 WHERE     
      (@NumeroFile is null or isnull(VW_ATENCIONPACIENTE_NOFARMACOLOGICO.EstadoAsigMed,0)=@NumeroFile)
       and (@CodigoHC is null OR CodigoHC = @CodigoHC)    
       and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
       and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       --and (@CodigoOA is null OR VW_ATENCIONPACIENTE.CodigoOA = @CodigoOA)    
       and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE_NOFARMACOLOGICO.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
       --OBS--and (@IdPersonalSalud is null OR VW_ATENCIONPACIENTE.IdPersonalSalud = @IdPersonalSalud)    
       and (     
        (@FecIniDiscamec is null or  VW_ATENCIONPACIENTE_NOFARMACOLOGICO.FechaAtencion >= @FecIniDiscamec)    
        and    
        (@FecFinDiscamec is null or  VW_ATENCIONPACIENTE_NOFARMACOLOGICO.FechaAtencion <= DATEADD(DAY,1,@FecFinDiscamec))    
       )    
       and (@IdPaciente is null OR personaPaciente.Persona = @IdPaciente or  @IdPaciente=0)    
       and (@EpisodioClinico is null OR VW_ATENCIONPACIENTE_NOFARMACOLOGICO.EpisodioClinico = @EpisodioClinico or  @EpisodioClinico=0)    
       and (VW_ATENCIONPACIENTE_NOFARMACOLOGICO.IdEpisodioAtencion = 1)   
	           
       ---
       and (@IdOrdenAtencion is null OR VW_ATENCIONPACIENTE_NOFARMACOLOGICO.IdOrdenAtencion = @IdOrdenAtencion or  @IdOrdenAtencion=0)           
       and (@LineaOrdenAtencion is null OR VW_ATENCIONPACIENTE_NOFARMACOLOGICO.LineaOrdenAtencion = @LineaOrdenAtencion or  @LineaOrdenAtencion=0)                         
       -----
       and (@Servicio is null OR SS_HC_EpisodioAtencion.TipoEpisodio = @Servicio )           
       
       and (@Estado is null or     
        (case     
         when VW_ATENCIONPACIENTE_NOFARMACOLOGICO.Estado IS null     
         then 0 else VW_ATENCIONPACIENTE_NOFARMACOLOGICO.Estado   
        end ) = @Estado)     
	 
			select @CONTADOR
		end	
	else
	if(@ACCION = 'LISTARPAGCONTINUAR')
	begin		
	
		  SELECT @CONTADOR= COUNT(*)          
			 FROM SS_HC_EpisodioClinico		WITH(NOLOCK)
			   inner join dbo.VW_ATENCIONPACIENTE    WITH(NOLOCK)	on (SS_HC_EpisodioClinico.UnidadReplicacion = VW_ATENCIONPACIENTE.UnidadReplicacion
			   --and    SS_HC_EpisodioClinico.IdEpisodioAtencion = VW_ATENCIONPACIENTE.IdEpisodioAtencion
			   and    SS_HC_EpisodioClinico.EpisodioClinico = VW_ATENCIONPACIENTE.EpisodioClinico
			   and    SS_HC_EpisodioClinico.IdPaciente = VW_ATENCIONPACIENTE.IdPaciente       
			   and    VW_ATENCIONPACIENTE.IdEpisodioAtencion =
				(select MAX(IdEpisodioAtencion) from SS_HC_EpisodioAtencion epiAtencion where
					epiAtencion.UnidadReplicacion = VW_ATENCIONPACIENTE.UnidadReplicacion
					and epiAtencion.IdPaciente = VW_ATENCIONPACIENTE.Idpaciente
					and epiAtencion.IdOrdenAtencion = VW_ATENCIONPACIENTE.IdOrdenAtencion			
					)
			   )                   
			   left join CM_CO_TablaMaestroDetalle TipoPaciente		WITH(NOLOCK)	on (TipoPaciente.IdCodigo = VW_ATENCIONPACIENTE.TipoPaciente    
				and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
			   left join SS_GE_TipoAtencion TipoAtencion			WITH(NOLOCK)	on (TipoAtencion.IdTipoAtencion = VW_ATENCIONPACIENTE.TipoAtencion)    
			   left join PERSONAMAST personaPaciente				WITH(NOLOCK)	on (personaPaciente.Persona = VW_ATENCIONPACIENTE.idPaciente)    
				where
				(@IdPaciente is null or VW_ATENCIONPACIENTE.IdPaciente = @IdPaciente or @IdPaciente=0)
				and (@UnidadReplicacion is null or VW_ATENCIONPACIENTE.UnidadReplicacion = @UnidadReplicacion)
			   and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
			   --OBS--and (@IdPersonalSalud is null OR VW_ATENCIONPACIENTE.IdPersonalSalud = @IdPersonalSalud)    
			   and (     
				(@FecIniDiscamec is null or  VW_ATENCIONPACIENTE.FechaRegistro >= @FecIniDiscamec)    
				and    
				(@FecFinDiscamec is null or  VW_ATENCIONPACIENTE.FechaRegistro <= DATEADD(DAY,1,@FecFinDiscamec))    
			   )    
			   ----
			   and (@Estado is null or     
				(case     
				 when VW_ATENCIONPACIENTE.Estado IS null     
				 then 0 else VW_ATENCIONPACIENTE.Estado   
				end )>1/* = @Estado*/)          
				-------
				and (SS_HC_EpisodioClinico.CodigoEpisodioClinico is Not null)
	 
			select @CONTADOR
		end			
	ELSE
	if(@ACCION = 'LISTARPAGSELECPACIENTEOA')
	begin		
				SELECT @CONTADOR= COUNT(*) 					
							FROM 	SS_AD_OrdenAtencion WITH(NOLOCK)
							left join	dbo.VW_ATENCIONPACIENTE		WITH(NOLOCK)	on (	VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA
									and	VW_ATENCIONPACIENTE.Persona = SS_AD_OrdenAtencion.idPaciente	)	
							left join CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK)	on (TipoPaciente.IdCodigo = SS_AD_OrdenAtencion.TipoPaciente
								and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN
							left join SS_GE_TipoAtencion TipoAtencion	WITH(NOLOCK)	on (TipoAtencion.IdTipoAtencion = SS_AD_OrdenAtencion.TipoAtencion)
							left join PERSONAMAST personaPaciente		WITH(NOLOCK)	on (personaPaciente.Persona = SS_AD_OrdenAtencion.idPaciente)
							where 1=1 --and unidadReplicacion is not null
							and (@CodigoHC is null OR CodigoHC = @CodigoHC)
							and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)
							and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')
							--and (@CodigoOA is null OR VW_ATENCIONPACIENTE.CodigoOA = @CodigoOA)
							and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(SS_AD_OrdenAtencion.CodigoOA) like '%'+upper(@CodigoOA)+'%')
							--OBS--and (@IdPersonalSalud is null OR VW_ATENCIONPACIENTE.IdPersonalSalud = @IdPersonalSalud)
							and ( 
								(@FecIniDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion >= @FecIniDiscamec)
								and
								(@FecFinDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion <= DATEADD(DAY,1,@FecFinDiscamec))
							)
							and (@IdPaciente is null OR personaPaciente.Persona = @IdPaciente)
							and (@Estado is null or 
								(case	
									when VW_ATENCIONPACIENTE.Estado IS null 
									then 0 else 
									(case 
										when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA
										then VW_ATENCIONPACIENTE.Estado else 0 end
									)
								end ) = @Estado)						
						 
			select @CONTADOR
		end			
	ELSE
	if(@ACCION = 'LISTARPAGNUEVO')
	begin		
				SELECT @CONTADOR= COUNT(*) 	
				FROM 
				(SELECT DISTINCT 
VW_ATENCIONPACIENTE.UnidadReplicacion,VW_ATENCIONPACIENTE.IdEpisodioAtencion,
VW_ATENCIONPACIENTE.UnidadReplicacionEC,VW_ATENCIONPACIENTE.IdPaciente,
VW_ATENCIONPACIENTE.EpisodioClinico,VW_ATENCIONPACIENTE.IdEstablecimientoSalud,
VW_ATENCIONPACIENTE.IdUnidadServicio,VW_ATENCIONPACIENTE.IdPersonalSalud,
VW_ATENCIONPACIENTE.EpisodioAtencion,
VW_ATENCIONPACIENTE.FechaRegistro,VW_ATENCIONPACIENTE.FechaAtencion,
VW_ATENCIONPACIENTE.TipoAtencion,VW_ATENCIONPACIENTE.IdOrdenAtencion,
VW_ATENCIONPACIENTE.LineaOrdenAtencion,VW_ATENCIONPACIENTE.TipoOrdenAtencion,
VW_ATENCIONPACIENTE.UsuarioCreacion,VW_ATENCIONPACIENTE.FechaCreacion,
VW_ATENCIONPACIENTE.UsuarioModificacion,VW_ATENCIONPACIENTE.FechaModificacion,
VW_ATENCIONPACIENTE.IdEspecialidad,VW_ATENCIONPACIENTE.CodigoOA,
VW_ATENCIONPACIENTE.ProximaAtencionFlag,VW_ATENCIONPACIENTE.IdEspecialidadProxima,
VW_ATENCIONPACIENTE.IdEstablecimientoSaludProxima,VW_ATENCIONPACIENTE.IdTipoInterConsulta,
VW_ATENCIONPACIENTE.IdTipoReferencia,'' ObservacionProxima,
VW_ATENCIONPACIENTE.DescansoMedico,VW_ATENCIONPACIENTE.DiasDescansoMedico,
VW_ATENCIONPACIENTE.FechaInicioDescansoMedico,VW_ATENCIONPACIENTE.FechaFinDescansoMedico,
VW_ATENCIONPACIENTE.FechaOrden,VW_ATENCIONPACIENTE.IdProcedimiento,
NULL AS ObservacionOrden,VW_ATENCIONPACIENTE.IdTipoOrden,
VW_ATENCIONPACIENTE.Accion,VW_ATENCIONPACIENTE.Version,
VW_ATENCIONPACIENTE.FechaRegistroEpiClinico,VW_ATENCIONPACIENTE.FechaCierreEpiClinico,
VW_ATENCIONPACIENTE.TipoPaciente,VW_ATENCIONPACIENTE.Edad,
VW_ATENCIONPACIENTE.Raza,VW_ATENCIONPACIENTE.Religion,
VW_ATENCIONPACIENTE.Cargo,VW_ATENCIONPACIENTE.AreaLaboral,
VW_ATENCIONPACIENTE.Ocupacion,VW_ATENCIONPACIENTE.CodigoHC,
VW_ATENCIONPACIENTE.CodigoHCAnterior,VW_ATENCIONPACIENTE.CodigoHCSecundario,
VW_ATENCIONPACIENTE.TipoAlmacenamiento,VW_ATENCIONPACIENTE.TipoHistoria,
VW_ATENCIONPACIENTE.TipoSituacion,
VW_ATENCIONPACIENTE.IdUbicacion,
VW_ATENCIONPACIENTE.LugarProcedencia,
VW_ATENCIONPACIENTE.RutaFoto,
VW_ATENCIONPACIENTE.FechaIngreso,
VW_ATENCIONPACIENTE.IndicadorNuevo,
VW_ATENCIONPACIENTE.EstadoPaciente,
VW_ATENCIONPACIENTE.NumeroFile,
VW_ATENCIONPACIENTE.Servicio,
VW_ATENCIONPACIENTE.UsuarioAlmacenamiento,
VW_ATENCIONPACIENTE.FechaAlmacenamiento,
VW_ATENCIONPACIENTE.Observacion,
VW_ATENCIONPACIENTE.IndicadorAsistencia,
VW_ATENCIONPACIENTE.CantidadAsistencia,
VW_ATENCIONPACIENTE.UbicacionHHCC,
VW_ATENCIONPACIENTE.IndicadorMigradoSiteds,
VW_ATENCIONPACIENTE.NumeroCaja,
VW_ATENCIONPACIENTE.IndicadorCodigoBarras,
VW_ATENCIONPACIENTE.IDPACIENTE_OK,
VW_ATENCIONPACIENTE.CodigoAsegurado,
VW_ATENCIONPACIENTE.NumeroPoliza,
VW_ATENCIONPACIENTE.CodigoProducto,
VW_ATENCIONPACIENTE.CodigoPlan,
VW_ATENCIONPACIENTE.TipoParentesco,
VW_ATENCIONPACIENTE.CodigoBeneficio,
VW_ATENCIONPACIENTE.Situacion,
VW_ATENCIONPACIENTE.TomoActual,
VW_ATENCIONPACIENTE.IndicadorHistoriaFisica,
VW_ATENCIONPACIENTE.DescripcionHistoria,
VW_ATENCIONPACIENTE.NumeroCertificado,
VW_ATENCIONPACIENTE.Persona,
VW_ATENCIONPACIENTE.Origen,
VW_ATENCIONPACIENTE.ApellidoPaterno,
VW_ATENCIONPACIENTE.ApellidoMaterno,
VW_ATENCIONPACIENTE.NombreCompleto,
VW_ATENCIONPACIENTE.TipoDocumento,
VW_ATENCIONPACIENTE.Documento,
VW_ATENCIONPACIENTE.CodigoBarras,
VW_ATENCIONPACIENTE.EsCliente,
VW_ATENCIONPACIENTE.EsProveedor,
VW_ATENCIONPACIENTE.EsEmpleado,
VW_ATENCIONPACIENTE.EsOtro,
VW_ATENCIONPACIENTE.TipoPersona,
VW_ATENCIONPACIENTE.FechaNacimiento,
VW_ATENCIONPACIENTE.Sexo,
VW_ATENCIONPACIENTE.CiudadNacimiento,
VW_ATENCIONPACIENTE.Nacionalidad,
VW_ATENCIONPACIENTE.EstadoCivil,
VW_ATENCIONPACIENTE.NivelInstruccion,
VW_ATENCIONPACIENTE.Direccion,
VW_ATENCIONPACIENTE.CodigoPostal,
VW_ATENCIONPACIENTE.Provincia,
VW_ATENCIONPACIENTE.Departamento,
VW_ATENCIONPACIENTE.Telefono,
VW_ATENCIONPACIENTE.Fax,
VW_ATENCIONPACIENTE.DocumentoFiscal,
VW_ATENCIONPACIENTE.DocumentoIdentidad,
VW_ATENCIONPACIENTE.CarnetExtranjeria,
VW_ATENCIONPACIENTE.DocumentoMilitarFA,
VW_ATENCIONPACIENTE.TipoBrevete,
VW_ATENCIONPACIENTE.Brevete,
VW_ATENCIONPACIENTE.Pasaporte,
VW_ATENCIONPACIENTE.NombreEmergencia,
VW_ATENCIONPACIENTE.DireccionEmergencia,
VW_ATENCIONPACIENTE.TelefonoEmergencia,
VW_ATENCIONPACIENTE.PersonaAnt,
VW_ATENCIONPACIENTE.CorreoElectronico,
VW_ATENCIONPACIENTE.EnfermedadGraveFlag,
VW_ATENCIONPACIENTE.IngresoFechaRegistro,
VW_ATENCIONPACIENTE.IngresoAplicacionCodigo,
VW_ATENCIONPACIENTE.IngresoUsuario,
VW_ATENCIONPACIENTE.Celular,
VW_ATENCIONPACIENTE.ParentescoEmergencia,
VW_ATENCIONPACIENTE.CelularEmergencia,
VW_ATENCIONPACIENTE.LugarNacimiento,
VW_ATENCIONPACIENTE.SuspensionFonaviFlag,
VW_ATENCIONPACIENTE.FlagRepetido,
VW_ATENCIONPACIENTE.CodDiscamec,
VW_ATENCIONPACIENTE.FecIniDiscamec,
VW_ATENCIONPACIENTE.FecFinDiscamec,
VW_ATENCIONPACIENTE.Pais,
VW_ATENCIONPACIENTE.EsPaciente,
VW_ATENCIONPACIENTE.EsEmpresa,
VW_ATENCIONPACIENTE.Persona_Old,
VW_ATENCIONPACIENTE.personanew,
VW_ATENCIONPACIENTE.EstadoPersona,
VW_ATENCIONPACIENTE.Estado,
VW_ATENCIONPACIENTE.IdAsignacionMedico,
VW_ATENCIONPACIENTE.TipoAsignacion,
VW_ATENCIONPACIENTE.ObservacionesAsigMed,
VW_ATENCIONPACIENTE.EstadoAsigMed,
VW_ATENCIONPACIENTE.EstadoEpiClinico,
VW_ATENCIONPACIENTE.SecAsigMed,
VW_ATENCIONPACIENTE.SecReferidaAsigMed,

      NULL as CodigoOASpring,
      NULL as PersonaAntX,
      NULL as HoraIni,
      NULL  as HoraFin,    
       NULL AS EpiClinico,    
       0 AS EpiAtencion,            
       NULL AS UnidadReplicacionX,           
       NULL AS IdEstablecimientoSaludX,           
       NULL AS IdPersonalSaludX,     
       NULL AS EpisodioAtencionX,     
       NULL AS FechaRegistroX,     
       NULL AS FechaAtencionX,  
         NULL AS TipoAtencionX,   
       NULL AS IdOrdenAtencionX,           
       (case when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA then VW_ATENCIONPACIENTE.LineaOrdenAtencion else 0 end) AS LineaOrdenAtencionX,            
       (case when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA then VW_ATENCIONPACIENTE.TipoOrdenAtencion else 0 end) AS TipoOrdenAtencionX,    
       NULL AS TipoPacienteX,      
       NULL as TipoPacienteDesc,        
       NULL as TipoAtencionDesc,           
       personaPaciente.ApellidoPaterno as ApellidoPaternoX,    
       personaPaciente.ApellidoMaterno as ApellidoMaternoX,           
       personaPaciente.NombreCompleto as NombreCompletoX,    
       personaPaciente.TipoDocumento as TipoDocumentoX,    
       personaPaciente.Documento as DocumentoX,    
       personaPaciente.Sexo as SexoX,    
       personaPaciente.Persona as IdPacienteX,           
       (case when VW_ATENCIONPACIENTE.Estado IS null then 0 else (case when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA then VW_ATENCIONPACIENTE.Estado else 0 end)end ) AS EstadoX,         
      -- @CONTAR AS Contador,    
       medico.nombrecompleto as nombrecompletomedico,
       medico.Persona as idmedico,       
       0 AS RowNumber                     
		FROM    
       SS_AD_OrdenAtencion       WITH(NOLOCK)
       LEFT JOIN dbo.VW_ATENCIONPACIENTE				WITH(NOLOCK) on (VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA and VW_ATENCIONPACIENTE.Persona = SS_AD_OrdenAtencion.idPaciente)     
       left join CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK) on (TipoPaciente.IdCodigo = SS_AD_OrdenAtencion.TipoPaciente and TipoPaciente.IdTablaMaestro = 45)     
       left join SS_GE_TipoAtencion TipoAtencion		WITH(NOLOCK) on (TipoAtencion.IdTipoAtencion = SS_AD_OrdenAtencion.TipoAtencion)    
       left join PERSONAMAST personaPaciente			WITH(NOLOCK) on (personaPaciente.Persona = SS_AD_OrdenAtencion.idPaciente)     
       left join SS_HC_AsignacionMedico am				WITH(NOLOCK) on SS_AD_OrdenAtencion.idPaciente = am.IdPaciente and am.Estado=0
       LEFT JOIN PERSONAMAST medico						WITH(NOLOCK) on am.IdAsignacionMedico  =medico.Persona  
				where 1=1 
				AND (VW_ATENCIONPACIENTE.Estado IS NULL)
				and (@CodigoHC is null OR CodigoHC = @CodigoHC)
				and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)
				and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')
				and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(SS_AD_OrdenAtencion.CodigoOA) like '%'+upper(@CodigoOA)+'%')
				and ((@FecIniDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion >= @FecIniDiscamec)and(@FecFinDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion <= DATEADD(DAY,1,@FecFinDiscamec)))
				and (@Estado is null or (case when VW_ATENCIONPACIENTE.Estado IS null then 0 else (case when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA then VW_ATENCIONPACIENTE.Estado else 0 end)end ) = @Estado)														 
				) as q1
			select @CONTADOR
	end		
			
END
/*
exec SP_VW_ATENCIONPACIENTE 
NULL,NULL,NULL,204,NULL,NULL,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,null,
0,100,NULL,'LISTARPAG'		
*/
GO
/****** Object:  StoredProcedure [dbo].[SP_VW_ATENCIONPACIENTE_LISTAR]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_VW_ATENCIONPACIENTE_LISTAR]    
(    
 @UnidadReplicacion  char(4) = null     
 ,@IdEpisodioAtencion  bigint  = null       
 ,@UnidadReplicacionEC  char(4)    = null     
 ,@IdPaciente  int    = null     
 ,@EpisodioClinico  int    = null     
 ,@IdEstablecimientoSalud  int    = null     
 ,@IdUnidadServicio  int    = null     
 ,@IdPersonalSalud  int    = null     
 ,@aaaaAtencion int    = null     
 ,@EpisodioAtencion  bigint    = null     
     
 ,@FechaRegistro  datetime    = null     
 ,@FechaAtencion  datetime    = null     
 ,@TipoAtencion  int    = null     
 ,@IdOrdenAtencion int    = null     
 ,@LineaOrdenAtencion int     = null     
 ,@TipoOrdenAtencion  int    = null     
 ,@Estado int    = null     
 ,@UsuarioModificacion varchar(25)    = null     
 ,@FechaModificacion  datetime    = null     
 ,@IdEspecialidad int    = null     
     
 ,@CodigoOA  varchar(25)    = null     
 ,@FechaOrden datetime     = null     
 ,@IdProcedimiento  int     = null     
 ,@IdTipoOrden  int     = null     
 ,@FechaRegistroEpiClinico  datetime = null         
 ,@FechaCierreEpiClinico  datetime    = null     
 ,@TipoPaciente  int    = null     
 ,@Edad  int    = null     
 ,@CodigoHC varchar(25)    = null      
 ,@CodigoHCAnterior  varchar(25)    = null     
     
 ,@CodigoHCSecundario  varchar(25)    = null     
 ,@TipoHistoria  varchar(1)    = null     
 ,@EstadoPaciente int     = null     
 ,@NumeroFile  int     = null     
 ,@IDPACIENTE_OK  int    = null     
 ,@Persona int    = null     
 ,@NombreCompleto  varchar(100)    = null     
 ,@TipoDocumento  char(1)    = null     
 ,@Documento  char(20)    = null     
 ,@EsCliente char(1)     = null     
     
 ,@EsProveedor  char(1)    = null     
 ,@EsEmpleado  char(1)    = null     
 ,@EsOtro  char(1)    = null     
 ,@TipoPersona  char(1)    = null     
 ,@FechaNacimiento  datetime    = null     
 ,@Sexo  char(1)     = null     
 ,@Nacionalidad  char(20)    = null     
 ,@EstadoCivil  char(1)    = null     
 ,@NivelInstruccion  char(3)     = null     
 ,@CodigoPostal  char(3)    = null     
     
 ,@Provincia  char(1)    = null     
 ,@Departamento  char(1)    = null     
 ,@FecIniDiscamec  datetime = null---AUX: inicio    
 ,@FecFinDiscamec  datetime = null ---AUX: fin    
 ,@Pais  char(4)    = null
 ,@EsPaciente char(1)    = null
 ,@EsEmpresa  char(1)    = null
 ,@personanew  int    = null
 ,@EstadoPersona  char(1)    = null
 ,@Servicio varchar(25) = null,    
       
 @INICIO  int= null,      
 @NUMEROFILAS  int = null ,    
 @Version  VARCHAR(25) = null,    
 @ACCION  VARCHAR(50)   = null 
)    
--WITH RECOMPILE   
AS    
BEGIN    
 DECLARE @CONTADOR INT    
 DECLARE @CONTAR INT    
    
 if(@ACCION = 'LISTARPAG')    
 begin       
     
  SELECT @CONTADOR= COUNT(*)          
     FROM dbo.VW_ATENCIONPACIENTE WITH(NOLOCK)    
       inner join SS_HC_EpisodioAtencion				WITH(NOLOCK)       on (SS_HC_EpisodioAtencion.UnidadReplicacion = VW_ATENCIONPACIENTE.UnidadReplicacion
		   and    SS_HC_EpisodioAtencion.IdOrdenAtencion = VW_ATENCIONPACIENTE.IdOrdenAtencion
			and    SS_HC_EpisodioAtencion.CodigoOA = VW_ATENCIONPACIENTE.CodigoOA
			and SS_HC_EpisodioAtencion.EpisodioClinico=VW_ATENCIONPACIENTE.EpisodioClinico
			and SS_HC_EpisodioAtencion.EpisodioAtencion=VW_ATENCIONPACIENTE.EpisodioAtencion
			and SS_HC_EpisodioAtencion.IdEpisodioAtencion=VW_ATENCIONPACIENTE.IdEpisodioAtencion
		   and    SS_HC_EpisodioAtencion.IdPaciente = VW_ATENCIONPACIENTE.IdPaciente )       
       left join CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK)	on (TipoPaciente.IdCodigo = VW_ATENCIONPACIENTE.TipoPaciente    
        and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
       left join SS_GE_TipoAtencion TipoAtencion		WITH(NOLOCK)	on (TipoAtencion.IdTipoAtencion =(case when VW_ATENCIONPACIENTE.TipoOrdenAtencion=11 then VW_ATENCIONPACIENTE.TipoOrdenAtencion else
	   VW_ATENCIONPACIENTE.TipoAtencion end))     
       left join PERSONAMAST personaPaciente			WITH(NOLOCK)	on (personaPaciente.Persona = VW_ATENCIONPACIENTE.idPaciente)                     
		 WHERE     
      (@NumeroFile is null or isnull(VW_ATENCIONPACIENTE.EstadoAsigMed,0)=@NumeroFile)and        
	   (@CodigoHC is null OR CodigoHC = @CodigoHC)    
       and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
       and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
       and (     
        (@FecIniDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion >= @FecIniDiscamec)    
        and    
        (@FecFinDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion <= DATEADD(DAY,1,@FecFinDiscamec))    
       )    
       and (@IdPaciente is null OR personaPaciente.Persona = @IdPaciente or  @IdPaciente=0)    
       and (@IdOrdenAtencion is null OR VW_ATENCIONPACIENTE.IdOrdenAtencion = @IdOrdenAtencion or  @IdOrdenAtencion=0)  
	   and VW_ATENCIONPACIENTE.DescansoMedico =@Nacionalidad
       and (@Servicio is null OR SS_HC_EpisodioAtencion.TipoEpisodio = @Servicio )           
       
       and (@Estado is null or     
        (case     
         when VW_ATENCIONPACIENTE.Estado IS null     
         then 0 else VW_ATENCIONPACIENTE.Estado   
        end ) = @Estado)            
    
  SELECT     
    [UnidadReplicacion]    
     ,[IdEpisodioAtencion]    
     ,[UnidadReplicacionEC]    
     ,[IdPaciente]    
     ,[EpisodioClinico]    
     ,[IdEstablecimientoSalud]    
     ,[IdUnidadServicio]    
     ,[IdPersonalSalud]         
     ,[EpisodioAtencion]    
     ,[FechaRegistro]    
     ,[FechaAtencion]    
     ,[TipoAtencion]    
     ,[IdOrdenAtencion]    
     ,[LineaOrdenAtencion]    
     ,[TipoOrdenAtencion]    
     ,[Estado]    
     ,[UsuarioCreacion]    
     ,[FechaCreacion]    
     ,NombreTrabajadorModificadorX as UsuarioModificacion
     ,[FechaModificacion]    
     ,[IdEspecialidad]    
     ,[CodigoOA]    
     ,[ProximaAtencionFlag]    
     ,[IdEspecialidadProxima]    
     ,[IdEstablecimientoSaludProxima]    
     ,[IdTipoInterConsulta]    
     ,[IdTipoReferencia]    
     ,[ObservacionProxima]    
     ,[DescansoMedico]    
     ,[DiasDescansoMedico]    
     ,[FechaInicioDescansoMedico]    
     ,[FechaFinDescansoMedico]    
     ,[FechaOrden]    
     ,[IdProcedimiento]    
     ,TipoAtencionDesc as ObservacionOrden
     ,[IdTipoOrden]    
     ,[Accion]    
     ,[Version]
     ,[FechaRegistroEpiClinico]    
     ,[FechaCierreEpiClinico]    
     ,[TipoPaciente]    
     ,[Edad]    
     ,[Raza]    
     ,[Religion]    
     ,NombreDiagnosticoX as Cargo
     ,[AreaLaboral]    
     ,[Ocupacion]    
     ,[CodigoHC]    
     ,[CodigoHCAnterior]    
     ,[CodigoHCSecundario]    
     ,[TipoAlmacenamiento]    
     ,[TipoHistoria]    
     ,[TipoSituacion]    
     ,[IdUbicacion]    
     ,[LugarProcedencia]    
     ,[RutaFoto]    
     ,[FechaIngreso]    
     ,[IndicadorNuevo]    
     ,[EstadoPaciente]    
     ,[NumeroFile]    
     ,[Servicio]    
     ,[UsuarioAlmacenamiento]    
     ,[FechaAlmacenamiento]    
     ,[Observacion]    
     ,[IndicadorAsistencia]    
     ,[CantidadAsistencia]    
     ,[UbicacionHHCC]    
     ,[IndicadorMigradoSiteds]    
     ,[NumeroCaja]    
     ,[IndicadorCodigoBarras]    
     ,[IDPACIENTE_OK]    
     ,[CodigoAsegurado]    
     ,[NumeroPoliza]    
     ,[CodigoProducto]    
     ,[CodigoPlan]    
     ,[TipoParentesco]    
     ,[CodigoBeneficio]    
     ,[Situacion]    
     ,[TomoActual]    
     ,[IndicadorHistoriaFisica]    
     ,[DescripcionHistoria]    
     ,[NumeroCertificado]    
     ,convert(int,RowNumber) as Persona
     ,[Origen]    
     ,[ApellidoPaterno]    
     ,[ApellidoMaterno]    
     ,[NombreCompleto]    
     ,[TipoDocumento]    
     ,[Documento]    
     ,[CodigoBarras]    
     ,[EsCliente]    
     ,[EsProveedor]    
     ,[EsEmpleado]    
     ,[EsOtro]    
     ,[TipoPersona]    
     ,[FechaNacimiento]    
     ,[Sexo]    
     ,[CiudadNacimiento]    
     ,[Nacionalidad]    
     ,[EstadoCivil]    
     ,[NivelInstruccion]    
     ,[Direccion]    
     ,[CodigoPostal]    
     ,[Provincia]    
     ,[Departamento]    
     ,[Telefono]    
     ,[Fax]    
     ,[DocumentoFiscal]    
     ,[DocumentoIdentidad]    
     ,[CarnetExtranjeria]    
     ,[DocumentoMilitarFA]    
     ,[TipoBrevete]    
     ,[Brevete]    
     ,[Pasaporte]    
     ,[NombreEmergencia]    
     ,[DireccionEmergencia]    
     ,[TelefonoEmergencia]    
     ,CodigoOAx+'_'+CONVERT(varchar,IdEpisodioAtencion)  as  PersonaAnt
     ,[CorreoElectronico]    
     ,[EnfermedadGraveFlag]    
     ,[IngresoFechaRegistro]    
     ,[IngresoAplicacionCodigo]    
     ,[IngresoUsuario]    
     ,[Celular]    
     ,[ParentescoEmergencia]    
     ,[CelularEmergencia]    
     ,[LugarNacimiento]    
     ,[SuspensionFonaviFlag]    
     ,[FlagRepetido]    
     ,[CodDiscamec]    
     ,[FecIniDiscamec]    
     ,[FecFinDiscamec]    
     ,[Pais]    
     ,TipoPacienteDesc as EsPaciente
     ,[EsEmpresa]    
     ,[Persona_Old]    
     ,Personax as personanew
     ,[EstadoPersona]    
       ,IDASIGNACIONMEDICO    
       ,tipoasignacion    
       ,ObservacionesAsigMed    
       ,EstadoAsigMed           
     ,EstadoEpiClinico    
     ,SecAsigMed    
     ,SecReferidaAsigMed   
  FROM (      
    SELECT VW_ATENCIONPACIENTE.*,                  
     @CONTADOR AS Contador,    
     VW_ATENCIONPACIENTE.Persona as Personax,
     VW_ATENCIONPACIENTE.CodigoOA as CodigoOAx,
       TipoPaciente.Descripcion as TipoPacienteDesc,        
       (case when VW_ATENCIONPACIENTE.TipoAtencion=2 then (case when VW_ATENCIONPACIENTE.TipoOrdenAtencion=1 
	  then 'Emergencia' when VW_ATENCIONPACIENTE.TipoOrdenAtencion=11
	   then 'Interconsulta' else 'Procedimiento' end) 
	   else TipoAtencion.Nombre end) as TipoAtencionDesc,-- TipoAtencion.Nombre as TipoAtencionDesc,         
       GEdiagnostico.Nombre as NombreDiagnosticoX,
       (select top 1 Nombre from SG_Agente as agenteTrabajador 
		where agenteTrabajador.IdEmpleado = SS_HC_EpisodioAtencion.IdPersonalSalud 
		) as NombreTrabajadorModificadorX,       
     ROW_NUMBER() OVER (ORDER BY VW_ATENCIONPACIENTE.IdTipoOrden ASC ) AS RowNumber        
     FROM dbo.VW_ATENCIONPACIENTE WITH(NOLOCK)
       inner join SS_HC_EpisodioAtencion				WITH(NOLOCK)       on (SS_HC_EpisodioAtencion.UnidadReplicacion = VW_ATENCIONPACIENTE.UnidadReplicacion
		   and    SS_HC_EpisodioAtencion.IdOrdenAtencion = VW_ATENCIONPACIENTE.IdOrdenAtencion
			and    SS_HC_EpisodioAtencion.CodigoOA = VW_ATENCIONPACIENTE.CodigoOA
			and SS_HC_EpisodioAtencion.EpisodioClinico=VW_ATENCIONPACIENTE.EpisodioClinico
			and SS_HC_EpisodioAtencion.EpisodioAtencion=VW_ATENCIONPACIENTE.EpisodioAtencion
			and SS_HC_EpisodioAtencion.IdEpisodioAtencion=VW_ATENCIONPACIENTE.IdEpisodioAtencion
		   and    SS_HC_EpisodioAtencion.IdPaciente = VW_ATENCIONPACIENTE.IdPaciente )             
       left join CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK)        on (TipoPaciente.IdCodigo = VW_ATENCIONPACIENTE.TipoPaciente    
				and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
       left join SS_GE_TipoAtencion TipoAtencion		WITH(NOLOCK)        on (TipoAtencion.IdTipoAtencion = (case when VW_ATENCIONPACIENTE.TipoOrdenAtencion in (11,12) then VW_ATENCIONPACIENTE.TipoOrdenAtencion else
				VW_ATENCIONPACIENTE.TipoAtencion end))    
       left join PERSONAMAST personaPaciente			WITH(NOLOCK)        on (personaPaciente.Persona = VW_ATENCIONPACIENTE.idPaciente)    
       left join SS_HC_Diagnostico HCdiagnostico		WITH(NOLOCK)        on (HCdiagnostico.IdPaciente = VW_ATENCIONPACIENTE.idPaciente
       and HCdiagnostico.IdEpisodioAtencion = VW_ATENCIONPACIENTE.IdEpisodioAtencion
       and HCdiagnostico.EpisodioClinico = VW_ATENCIONPACIENTE.EpisodioClinico
       )    
       left join SS_GE_Diagnostico GEdiagnostico		WITH(NOLOCK)        on (GEdiagnostico.IdDiagnostico = HCdiagnostico.IdDiagnostico)   
             
              
     WHERE     
      (@NumeroFile is null or isnull(VW_ATENCIONPACIENTE.EstadoAsigMed,0)=@NumeroFile)
       and (@CodigoHC is null OR CodigoHC = @CodigoHC)    
       and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
       and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
       and (     
        (@FecIniDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion >= @FecIniDiscamec)    
        and    
        (@FecFinDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion <= DATEADD(DAY,1,@FecFinDiscamec))    
       )    
       and (@IdPaciente is null OR personaPaciente.Persona = @IdPaciente or  @IdPaciente=0)  
       and (@IdOrdenAtencion is null OR VW_ATENCIONPACIENTE.IdOrdenAtencion = @IdOrdenAtencion or  @IdOrdenAtencion=0)  
		and (@Servicio is null OR SS_HC_EpisodioAtencion.TipoEpisodio = @Servicio )    
		and VW_ATENCIONPACIENTE.DescansoMedico =@Nacionalidad
       and (@Estado is null or     
        (case     
         when VW_ATENCIONPACIENTE.Estado IS null     
         then 0 else VW_ATENCIONPACIENTE.Estado   
        end ) = @Estado)          
        
     ) AS LISTADO    
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR      
            RowNumber BETWEEN @Inicio  AND @NumeroFilas                          
		
 end   



 if(@ACCION = 'LISTDETPACIENTE')    
 begin       
     
  SELECT @CONTADOR= COUNT(*)          
     FROM dbo.VW_ATENCIONPACIENTE WITH(NOLOCK) 
       inner join SS_HC_EpisodioAtencion					WITH(NOLOCK)       on (SS_HC_EpisodioAtencion.UnidadReplicacion = VW_ATENCIONPACIENTE.UnidadReplicacion
			  -- and    SS_HC_EpisodioAtencion.IdEpisodioAtencion = VW_ATENCIONPACIENTE.IdEpisodioAtencion
			   and    SS_HC_EpisodioAtencion.IdOrdenAtencion = VW_ATENCIONPACIENTE.IdOrdenAtencion
				and    SS_HC_EpisodioAtencion.CodigoOA = VW_ATENCIONPACIENTE.CodigoOA
				and SS_HC_EpisodioAtencion.EpisodioClinico=VW_ATENCIONPACIENTE.EpisodioClinico
				and SS_HC_EpisodioAtencion.EpisodioAtencion=VW_ATENCIONPACIENTE.EpisodioAtencion
				and SS_HC_EpisodioAtencion.IdEpisodioAtencion=VW_ATENCIONPACIENTE.IdEpisodioAtencion
			   and    SS_HC_EpisodioAtencion.IdPaciente = VW_ATENCIONPACIENTE.IdPaciente )       
       left join CM_CO_TablaMaestroDetalle TipoPaciente		WITH(NOLOCK)       on (TipoPaciente.IdCodigo = VW_ATENCIONPACIENTE.TipoPaciente    
				and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
       left join SS_GE_TipoAtencion TipoAtencion			WITH(NOLOCK)       on (TipoAtencion.IdTipoAtencion =(case when VW_ATENCIONPACIENTE.TipoOrdenAtencion=11 then VW_ATENCIONPACIENTE.TipoOrdenAtencion else
				VW_ATENCIONPACIENTE.TipoAtencion end))     
       left join PERSONAMAST personaPaciente				WITH(NOLOCK)       on (personaPaciente.Persona = VW_ATENCIONPACIENTE.idPaciente)                     
		   WHERE   
        (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       and (@CodigoOA is null OR VW_ATENCIONPACIENTE.CodigoOA = @CodigoOA)    
       and (@IdPaciente is null OR personaPaciente.Persona = @IdPaciente or  @IdPaciente=0)   
	      and (@IdEpisodioAtencion is null OR VW_ATENCIONPACIENTE.IdEpisodioAtencion = @IdEpisodioAtencion or  @IdEpisodioAtencion=0)  
       and (@Estado is null or     
        (case     
         when VW_ATENCIONPACIENTE.Estado IS null     
         then 0 else VW_ATENCIONPACIENTE.Estado   
        end ) = @Estado)               
    
  SELECT     
    [UnidadReplicacion]    
     ,[IdEpisodioAtencion]    
     ,[UnidadReplicacionEC]    
     ,[IdPaciente]    
     ,[EpisodioClinico]    
     ,[IdEstablecimientoSalud]    
     ,[IdUnidadServicio]    
     ,[IdPersonalSalud]         
     ,[EpisodioAtencion]    
     ,[FechaRegistro]    
     ,[FechaAtencion]    
     ,[TipoAtencion]    
     ,[IdOrdenAtencion]    
     ,[LineaOrdenAtencion]    
     ,[TipoOrdenAtencion]    
     ,[Estado]    
     ,[UsuarioCreacion]    
     ,[FechaCreacion]    
     ,NombreTrabajadorModificadorX as UsuarioModificacion
     ,[FechaModificacion]    
     ,[IdEspecialidad]    
     ,[CodigoOA]    
     ,[ProximaAtencionFlag]    
     ,[IdEspecialidadProxima]    
     ,[IdEstablecimientoSaludProxima]    
     ,[IdTipoInterConsulta]    
     ,[IdTipoReferencia]    
     ,[ObservacionProxima]    
     ,[DescansoMedico]    
     ,[DiasDescansoMedico]    
     ,[FechaInicioDescansoMedico]    
     ,[FechaFinDescansoMedico]    
     ,[FechaOrden]    
     ,[IdProcedimiento]    
     ,TipoAtencionDesc as ObservacionOrden
     ,[IdTipoOrden]    
     ,[Accion]    
     ,[Version]
     ,[FechaRegistroEpiClinico]    
     ,[FechaCierreEpiClinico]    
     ,[TipoPaciente]    
     ,[Edad]    
     ,[Raza]    
     ,[Religion]    
     ,NombreDiagnosticoX as Cargo
     ,[AreaLaboral]    
     ,[Ocupacion]    
     ,[CodigoHC]    
     ,[CodigoHCAnterior]    
     ,[CodigoHCSecundario]    
     ,[TipoAlmacenamiento]    
     ,[TipoHistoria]    
     ,[TipoSituacion]    
     ,[IdUbicacion]    
     ,[LugarProcedencia]    
     ,[RutaFoto]    
     ,[FechaIngreso]    
     ,[IndicadorNuevo]    
     ,[EstadoPaciente]    
     ,[NumeroFile]    
     ,[Servicio]    
     ,[UsuarioAlmacenamiento]    
     ,[FechaAlmacenamiento]    
     ,[Observacion]    
     ,[IndicadorAsistencia]    
     ,[CantidadAsistencia]    
     ,[UbicacionHHCC]    
     ,[IndicadorMigradoSiteds]    
     ,[NumeroCaja]    
     ,[IndicadorCodigoBarras]    
     ,[IDPACIENTE_OK]    
     ,[CodigoAsegurado]    
     ,[NumeroPoliza]    
     ,[CodigoProducto]    
     ,[CodigoPlan]    
     ,[TipoParentesco]    
     ,[CodigoBeneficio]    
     ,[Situacion]    
     ,[TomoActual]    
     ,[IndicadorHistoriaFisica]    
     ,[DescripcionHistoria]    
     ,[NumeroCertificado]    
     ,convert(int,RowNumber) as Persona
     ,[Origen]    
     ,[ApellidoPaterno]    
     ,[ApellidoMaterno]    
     ,[NombreCompleto]    
     ,[TipoDocumento]    
     ,[Documento]    
     ,[CodigoBarras]    
     ,[EsCliente]    
     ,[EsProveedor]    
     ,[EsEmpleado]    
     ,[EsOtro]    
     ,[TipoPersona]    
     ,[FechaNacimiento]    
     ,[Sexo]    
     ,[CiudadNacimiento]    
     ,[Nacionalidad]    
     ,[EstadoCivil]    
     ,[NivelInstruccion]    
     ,[Direccion]    
     ,[CodigoPostal]    
     ,[Provincia]    
     ,[Departamento]    
     ,[Telefono]    
     ,[Fax]    
     ,[DocumentoFiscal]    
     ,[DocumentoIdentidad]    
     ,[CarnetExtranjeria]    
     ,[DocumentoMilitarFA]    
     ,[TipoBrevete]    
     ,[Brevete]    
     ,[Pasaporte]    
     ,[NombreEmergencia]    
     ,[DireccionEmergencia]    
     ,[TelefonoEmergencia]    
     ,CodigoOAx+'_'+CONVERT(varchar,IdEpisodioAtencion)  as  PersonaAnt
     ,[CorreoElectronico]    
     ,[EnfermedadGraveFlag]    
     ,[IngresoFechaRegistro]    
     ,[IngresoAplicacionCodigo]    
     ,[IngresoUsuario]    
     ,[Celular]    
     ,[ParentescoEmergencia]    
     ,[CelularEmergencia]    
     ,[LugarNacimiento]    
     ,[SuspensionFonaviFlag]    
     ,[FlagRepetido]    
     ,[CodDiscamec]    
     ,[FecIniDiscamec]    
     ,[FecFinDiscamec]    
     ,[Pais]    
     ,TipoPacienteDesc as EsPaciente
     ,[EsEmpresa]    
     ,[Persona_Old]    
     ,Personax as personanew
     ,[EstadoPersona]    
       ,IDASIGNACIONMEDICO    
       ,tipoasignacion    
       ,ObservacionesAsigMed    
       ,EstadoAsigMed           
     ,EstadoEpiClinico    
     ,SecAsigMed    
     ,SecReferidaAsigMed   
  FROM (      
    SELECT VW_ATENCIONPACIENTE.*,                  
     @CONTADOR AS Contador,    
     VW_ATENCIONPACIENTE.Persona as Personax,
     VW_ATENCIONPACIENTE.CodigoOA as CodigoOAx,
       TipoPaciente.Descripcion as TipoPacienteDesc,        
       (case when VW_ATENCIONPACIENTE.TipoAtencion=2 then (case when VW_ATENCIONPACIENTE.TipoOrdenAtencion=1 
	  then 'Emergencia' when VW_ATENCIONPACIENTE.TipoOrdenAtencion=11
	   then 'Interconsulta' else 'Procedimiento' end) 
	   else TipoAtencion.Nombre end) as TipoAtencionDesc,-- TipoAtencion.Nombre as TipoAtencionDesc,         
       GEdiagnostico.Nombre as NombreDiagnosticoX,
       (select top 1 Nombre from SG_Agente as agenteTrabajador 
		where agenteTrabajador.IdEmpleado = SS_HC_EpisodioAtencion.IdPersonalSalud 
		) as NombreTrabajadorModificadorX,       
     ROW_NUMBER() OVER (ORDER BY VW_ATENCIONPACIENTE.IdTipoOrden ASC ) AS RowNumber        
     FROM dbo.VW_ATENCIONPACIENTE  WITH(NOLOCK)
       inner join SS_HC_EpisodioAtencion  WITH(NOLOCK)
       on (SS_HC_EpisodioAtencion.UnidadReplicacion = VW_ATENCIONPACIENTE.UnidadReplicacion
       and    SS_HC_EpisodioAtencion.IdOrdenAtencion = VW_ATENCIONPACIENTE.IdOrdenAtencion
	    and    SS_HC_EpisodioAtencion.CodigoOA = VW_ATENCIONPACIENTE.CodigoOA
		and SS_HC_EpisodioAtencion.EpisodioClinico=VW_ATENCIONPACIENTE.EpisodioClinico
		and SS_HC_EpisodioAtencion.EpisodioAtencion=VW_ATENCIONPACIENTE.EpisodioAtencion
		and SS_HC_EpisodioAtencion.IdEpisodioAtencion=VW_ATENCIONPACIENTE.IdEpisodioAtencion
       and    SS_HC_EpisodioAtencion.IdPaciente = VW_ATENCIONPACIENTE.IdPaciente )             
       left join CM_CO_TablaMaestroDetalle TipoPaciente  WITH(NOLOCK)
       on (TipoPaciente.IdCodigo = VW_ATENCIONPACIENTE.TipoPaciente    
        and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
       left join SS_GE_TipoAtencion TipoAtencion  WITH(NOLOCK)
       on (TipoAtencion.IdTipoAtencion = (case when VW_ATENCIONPACIENTE.TipoOrdenAtencion in (11,12) then VW_ATENCIONPACIENTE.TipoOrdenAtencion else
	   VW_ATENCIONPACIENTE.TipoAtencion end))    
       left join PERSONAMAST personaPaciente  WITH(NOLOCK)
       on (personaPaciente.Persona = VW_ATENCIONPACIENTE.idPaciente)    
       left join SS_HC_Diagnostico HCdiagnostico  WITH(NOLOCK)
       on (HCdiagnostico.IdPaciente = VW_ATENCIONPACIENTE.idPaciente
       and HCdiagnostico.IdEpisodioAtencion = VW_ATENCIONPACIENTE.IdEpisodioAtencion
       and HCdiagnostico.EpisodioClinico = VW_ATENCIONPACIENTE.EpisodioClinico
       )    
       left join SS_GE_Diagnostico GEdiagnostico  WITH(NOLOCK)
       on (GEdiagnostico.IdDiagnostico = HCdiagnostico.IdDiagnostico)               
              
       WHERE     
 
        (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       and (@CodigoOA is null OR VW_ATENCIONPACIENTE.CodigoOA = @CodigoOA)    
       and (@IdPaciente is null OR personaPaciente.Persona = @IdPaciente or  @IdPaciente=0)    
	      and (@IdEpisodioAtencion is null OR VW_ATENCIONPACIENTE.IdEpisodioAtencion = @IdEpisodioAtencion or  @IdEpisodioAtencion=0)  
       and (@Estado is null or     
        (case     
         when VW_ATENCIONPACIENTE.Estado IS null     
         then 0 else VW_ATENCIONPACIENTE.Estado   
        end ) = @Estado)          
        
     ) AS LISTADO    
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR      
            RowNumber BETWEEN @Inicio  AND @NumeroFilas                          
		
 end   

 ELSE 
 IF (@ACCION='LISTARFLAT') -- luke 10/03/2020 EMERGENCIA: IDENTIFICAR QUIEN ES MEDICO PRINCIPAL
 BEGIN
	 SELECT *  FROM VW_ATENCIONPACIENTE  WITH(NOLOCK) 
	 INNER JOIN SS_HC_EpisodioAtencion  WITH(NOLOCK)  
		ON SS_HC_EpisodioAtencion.CodigoOA = VW_ATENCIONPACIENTE.CodigoOA 
	 WHERE VW_ATENCIONPACIENTE.IdPersonalSalud=@IdPersonalSalud
	  AND VW_ATENCIONPACIENTE.CodigoOA=@CodigoOA and VW_ATENCIONPACIENTE.IdTipoInterConsulta=1
 END

  ELSE 
 IF (@ACCION='COMP_ENFERMEDAD') 
 BEGIN
	declare @episodioId int

	 set @episodioId =( select max(enf.IdEpisodioAtencion)from SS_HC_EnfermedadActual_FE enf 
	 inner join SS_HC_EpisodioAtencion epi
	on epi.EpisodioClinico=enf.EpisodioClinico and epi.IdEpisodioAtencion= enf.IdEpisodioAtencion and epi.IdPaciente = enf.IdPaciente
	where epi.CodigoOA=@CodigoOA)

	 SELECT * FROM VW_ATENCIONPACIENTE WITH(NOLOCK) 
	 INNER JOIN SS_HC_EpisodioAtencion WITH(NOLOCK) ON SS_HC_EpisodioAtencion.CodigoOA=
	 VW_ATENCIONPACIENTE.CodigoOA WHERE VW_ATENCIONPACIENTE.Persona=@IdPaciente
	  AND VW_ATENCIONPACIENTE.CodigoOA=@CodigoOA and VW_ATENCIONPACIENTE.TipoAtencion=@TipoAtencion and VW_ATENCIONPACIENTE.IdEpisodioAtencion=@episodioId
 END

  ELSE 
 IF (@ACCION='COMP_EXAMEN') 
 BEGIN
	 declare @episodioIdExamen int

	 set @episodioIdExamen =( select max(enf.IdEpisodioAtencion)from SS_HC_ExamenClinico_FE enf 
	 inner join SS_HC_EpisodioAtencion epi 
	on epi.EpisodioClinico=enf.EpisodioClinico and epi.IdEpisodioAtencion= enf.IdEpisodioAtencion and epi.IdPaciente = enf.IdPaciente
	where epi.CodigoOA=@CodigoOA)

	 SELECT * FROM VW_ATENCIONPACIENTE WITH(NOLOCK)
	 INNER JOIN SS_HC_EpisodioAtencion WITH(NOLOCK)ON SS_HC_EpisodioAtencion.CodigoOA=
	 VW_ATENCIONPACIENTE.CodigoOA WHERE VW_ATENCIONPACIENTE.Persona=@IdPaciente
	  AND VW_ATENCIONPACIENTE.CodigoOA=@CodigoOA and VW_ATENCIONPACIENTE.TipoAtencion=@TipoAtencion and VW_ATENCIONPACIENTE.IdEpisodioAtencion=@episodioIdExamen
 END

 else
  if(@ACCION = 'LISTARESPE')   -- luke 09/03/2020
 begin       
       
  SELECT @CONTADOR= COUNT(*)          
     FROM dbo.VW_ATENCIONPACIENTE WITH(NOLOCK)
       inner join SS_HC_EpisodioAtencion WITH(NOLOCK)
       on (SS_HC_EpisodioAtencion.UnidadReplicacion = VW_ATENCIONPACIENTE.UnidadReplicacion
       and    SS_HC_EpisodioAtencion.IdOrdenAtencion = VW_ATENCIONPACIENTE.IdOrdenAtencion
	    and    SS_HC_EpisodioAtencion.CodigoOA = VW_ATENCIONPACIENTE.CodigoOA
		and SS_HC_EpisodioAtencion.EpisodioClinico=VW_ATENCIONPACIENTE.EpisodioClinico
		and SS_HC_EpisodioAtencion.EpisodioAtencion=VW_ATENCIONPACIENTE.EpisodioAtencion
		and SS_HC_EpisodioAtencion.IdEpisodioAtencion=VW_ATENCIONPACIENTE.IdEpisodioAtencion
       and    SS_HC_EpisodioAtencion.IdPaciente = VW_ATENCIONPACIENTE.IdPaciente )       
       left join CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK)
       on (TipoPaciente.IdCodigo = VW_ATENCIONPACIENTE.TipoPaciente    
        and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
       left join SS_GE_TipoAtencion TipoAtencion WITH(NOLOCK)
       on (TipoAtencion.IdTipoAtencion = (case when VW_ATENCIONPACIENTE.TipoOrdenAtencion=11 then VW_ATENCIONPACIENTE.TipoOrdenAtencion else
	   VW_ATENCIONPACIENTE.TipoAtencion end))   
       left join PERSONAMAST personaPaciente WITH(NOLOCK)
       on (personaPaciente.Persona = VW_ATENCIONPACIENTE.idPaciente)                     
		 WHERE     
      (@NumeroFile is null or isnull(VW_ATENCIONPACIENTE.EstadoAsigMed,0)=@NumeroFile)and        
	   (@CodigoHC is null OR CodigoHC = @CodigoHC)    
       and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
       and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
       and (     
        (@FecIniDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion >= @FecIniDiscamec)    
        and    
        (@FecFinDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion <= DATEADD(DAY,1,@FecFinDiscamec))    
       )    
       and (@IdPaciente is null OR personaPaciente.Persona = @IdPaciente or  @IdPaciente=0)    
       and (@IdOrdenAtencion is null OR VW_ATENCIONPACIENTE.IdOrdenAtencion = @IdOrdenAtencion or  @IdOrdenAtencion=0)           
       and (@LineaOrdenAtencion is null OR VW_ATENCIONPACIENTE.LineaOrdenAtencion = @LineaOrdenAtencion)                         
       -----
       and (@Servicio is null OR SS_HC_EpisodioAtencion.TipoEpisodio = @Servicio )           
       and (@Estado is null or     
        (case     
         when VW_ATENCIONPACIENTE.Estado IS null     
         then 0 else VW_ATENCIONPACIENTE.Estado   
        end ) = @Estado)            
    
  SELECT     
    [UnidadReplicacion]    
     ,[IdEpisodioAtencion]    
     ,[UnidadReplicacionEC]    
     ,[IdPaciente]    
     ,[EpisodioClinico]    
     ,[IdEstablecimientoSalud]    
     ,[IdUnidadServicio]    
     ,[IdPersonalSalud]         
     ,[EpisodioAtencion]    
     ,[FechaRegistro]    
     ,[FechaAtencion]    
     ,[TipoAtencion]    
     ,[IdOrdenAtencion]    
     ,[LineaOrdenAtencion]    
     ,[TipoOrdenAtencion]    
     ,[Estado]    
     ,[UsuarioCreacion]    
     ,[FechaCreacion]    
     ,NombreTrabajadorModificadorX as UsuarioModificacion
     ,[FechaModificacion]    
     ,[IdEspecialidad]    
     ,[CodigoOA]    
     ,[ProximaAtencionFlag]    
     ,[IdEspecialidadProxima]    
     ,[IdEstablecimientoSaludProxima]    
     ,[IdTipoInterConsulta]    
     ,[IdTipoReferencia]    
     ,[ObservacionProxima]    
     ,[DescansoMedico]    
     ,[DiasDescansoMedico]    
     ,[FechaInicioDescansoMedico]    
     ,[FechaFinDescansoMedico]    
     ,[FechaOrden]    
     ,[IdProcedimiento]    
     ,TipoAtencionDesc as ObservacionOrden
     ,[IdTipoOrden]    
     ,[Accion]    
     ,[Version]
     ,[FechaRegistroEpiClinico]    
     ,[FechaCierreEpiClinico]    
     ,[TipoPaciente]    
     ,[Edad]    
     ,[Raza]    
     ,[Religion]    
     ,NombreDiagnosticoX as Cargo
     ,[AreaLaboral]    
     ,[Ocupacion]    
     ,[CodigoHC]    
     ,[CodigoHCAnterior]    
     ,[CodigoHCSecundario]    
     ,[TipoAlmacenamiento]    
     ,[TipoHistoria]    
     ,[TipoSituacion]    
     ,[IdUbicacion]    
     ,[LugarProcedencia]    
     ,[RutaFoto]    
     ,[FechaIngreso]    
     ,[IndicadorNuevo]    
     ,[EstadoPaciente]    
     ,[NumeroFile]    
     ,[Servicio]    
     ,[UsuarioAlmacenamiento]    
     ,[FechaAlmacenamiento]    
     ,[Observacion]    
     ,[IndicadorAsistencia]    
     ,[CantidadAsistencia]    
     ,[UbicacionHHCC]    
     ,[IndicadorMigradoSiteds]    
     ,[NumeroCaja]    
     ,[IndicadorCodigoBarras]    
     ,[IDPACIENTE_OK]    
     ,[CodigoAsegurado]    
     ,[NumeroPoliza]    
     ,[CodigoProducto]    
     ,[CodigoPlan]    
     ,[TipoParentesco]    
     ,[CodigoBeneficio]    
     ,[Situacion]    
     ,[TomoActual]    
     ,[IndicadorHistoriaFisica]    
     ,[DescripcionHistoria]    
     ,[NumeroCertificado]    
     ,convert(int,RowNumber) as Persona
     ,[Origen]    
     ,[ApellidoPaterno]    
     ,[ApellidoMaterno]    
     ,[NombreCompleto]    
     ,[TipoDocumento]    
     ,[Documento]    
     ,[CodigoBarras]    
     ,[EsCliente]    
     ,[EsProveedor]    
     ,[EsEmpleado]    
     ,[EsOtro]    
     ,[TipoPersona]    
     ,[FechaNacimiento]    
     ,[Sexo]    
     ,[CiudadNacimiento]    
     ,[Nacionalidad]    
     ,[EstadoCivil]    
     ,[NivelInstruccion]    
     ,[Direccion]    
     ,[CodigoPostal]    
     ,[Provincia]    
     ,[Departamento]    
     ,[Telefono]    
     ,[Fax]    
     ,[DocumentoFiscal]    
     ,[DocumentoIdentidad]    
     ,[CarnetExtranjeria]    
     ,[DocumentoMilitarFA]    
     ,[TipoBrevete]    
     ,[Brevete]    
     ,[Pasaporte]    
     ,[NombreEmergencia]    
     ,[DireccionEmergencia]    
     ,[TelefonoEmergencia]    
     ,CodigoOAx+'_'+CONVERT(varchar,IdEpisodioAtencion)  as  PersonaAnt
     ,[CorreoElectronico]    
     ,[EnfermedadGraveFlag]    
     ,[IngresoFechaRegistro]    
     ,[IngresoAplicacionCodigo]    
     ,[IngresoUsuario]    
     ,[Celular]    
     ,[ParentescoEmergencia]    
     ,[CelularEmergencia]    
     ,[LugarNacimiento]    
     ,[SuspensionFonaviFlag]    
     ,[FlagRepetido]    
     ,[CodDiscamec]    
     ,[FecIniDiscamec]    
     ,[FecFinDiscamec]    
     ,[Pais]    
     ,TipoPacienteDesc as EsPaciente
     ,[EsEmpresa]    
     ,[Persona_Old]    
     ,Personax as personanew
     ,[EstadoPersona]    
       ,IDASIGNACIONMEDICO    
       ,tipoasignacion    
       ,ObservacionesAsigMed    
       ,EstadoAsigMed           
     ,EstadoEpiClinico    
     ,SecAsigMed    
     ,SecReferidaAsigMed   
  FROM (      
    SELECT VW_ATENCIONPACIENTE.*,                  
     @CONTADOR AS Contador,    
     VW_ATENCIONPACIENTE.Persona as Personax,
     VW_ATENCIONPACIENTE.CodigoOA as CodigoOAx,
       TipoPaciente.Descripcion as TipoPacienteDesc,        
      (case when VW_ATENCIONPACIENTE.TipoAtencion=2 then (case when VW_ATENCIONPACIENTE.TipoOrdenAtencion=1 
	  then 'Emergencia' when VW_ATENCIONPACIENTE.TipoOrdenAtencion=11
	   then 'Interconsulta' else 'Procedimiento' end) 
	   else TipoAtencion.Nombre end) as TipoAtencionDesc,-- TipoAtencion.Nombre as TipoAtencionDesc,       
       GEdiagnostico.Nombre as NombreDiagnosticoX,
       (select top 1 Nombre from SG_Agente as agenteTrabajador 
		where agenteTrabajador.IdEmpleado = SS_HC_EpisodioAtencion.IdPersonalSalud 
		) as NombreTrabajadorModificadorX,       
     ROW_NUMBER() OVER (ORDER BY VW_ATENCIONPACIENTE.IdTipoOrden ASC ) AS RowNumber        
     FROM dbo.VW_ATENCIONPACIENTE WITH(NOLOCK)
       inner join SS_HC_EpisodioAtencion WITH(NOLOCK)
       on (SS_HC_EpisodioAtencion.UnidadReplicacion = VW_ATENCIONPACIENTE.UnidadReplicacion
       and    SS_HC_EpisodioAtencion.IdOrdenAtencion = VW_ATENCIONPACIENTE.IdOrdenAtencion
	    and    SS_HC_EpisodioAtencion.CodigoOA = VW_ATENCIONPACIENTE.CodigoOA
		and SS_HC_EpisodioAtencion.EpisodioClinico=VW_ATENCIONPACIENTE.EpisodioClinico
		and SS_HC_EpisodioAtencion.EpisodioAtencion=VW_ATENCIONPACIENTE.EpisodioAtencion
		and SS_HC_EpisodioAtencion.IdEpisodioAtencion=VW_ATENCIONPACIENTE.IdEpisodioAtencion
       and    SS_HC_EpisodioAtencion.IdPaciente = VW_ATENCIONPACIENTE.IdPaciente )             
       left join CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK)
       on (TipoPaciente.IdCodigo = VW_ATENCIONPACIENTE.TipoPaciente    
        and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
       left join SS_GE_TipoAtencion TipoAtencion WITH(NOLOCK)
       on (TipoAtencion.IdTipoAtencion =(case when VW_ATENCIONPACIENTE.TipoOrdenAtencion=11 then VW_ATENCIONPACIENTE.TipoOrdenAtencion else
	   VW_ATENCIONPACIENTE.TipoAtencion end))     
       left join PERSONAMAST personaPaciente WITH(NOLOCK)
       on (personaPaciente.Persona = VW_ATENCIONPACIENTE.idPaciente)    
       left join SS_HC_Diagnostico HCdiagnostico WITH(NOLOCK)
       on (HCdiagnostico.IdPaciente = VW_ATENCIONPACIENTE.idPaciente
       and HCdiagnostico.IdEpisodioAtencion = VW_ATENCIONPACIENTE.IdEpisodioAtencion
       and HCdiagnostico.EpisodioClinico = VW_ATENCIONPACIENTE.EpisodioClinico
       )    
       left join SS_GE_Diagnostico GEdiagnostico WITH(NOLOCK)
       on (GEdiagnostico.IdDiagnostico = HCdiagnostico.IdDiagnostico)   
             
              
     WHERE     
      (@NumeroFile is null or isnull(VW_ATENCIONPACIENTE.EstadoAsigMed,0)=@NumeroFile)
       and (@CodigoHC is null OR CodigoHC = @CodigoHC)    
       and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
       and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
       and (     
        (@FecIniDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion >= @FecIniDiscamec)    
        and    
        (@FecFinDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion <= DATEADD(DAY,1,@FecFinDiscamec))    
       )    
       and (@IdPaciente is null OR personaPaciente.Persona = @IdPaciente or  @IdPaciente=0)    
       and (@IdOrdenAtencion is null OR VW_ATENCIONPACIENTE.IdOrdenAtencion = @IdOrdenAtencion or  @IdOrdenAtencion=0)           
		and (@Servicio is null OR SS_HC_EpisodioAtencion.TipoEpisodio = @Servicio )       
		 and (@LineaOrdenAtencion is null OR VW_ATENCIONPACIENTE.LineaOrdenAtencion = @LineaOrdenAtencion )            
       and (@Estado is null or     
        (case     
         when VW_ATENCIONPACIENTE.Estado IS null     
         then 0 else VW_ATENCIONPACIENTE.Estado   
        end ) = @Estado)          
        
     ) AS LISTADO    
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR      
            RowNumber BETWEEN @Inicio  AND @NumeroFilas                          
		
 end   

 ELSE
  if(@ACCION = 'LISTARVISITA')    
 begin   
 
 SET @NumeroFilas=(SELECT COUNT(*) FROM VW_ATENCIONPACIENTE WHERE CodigoOA=@CodigoOA)    
     
  SELECT @CONTADOR= COUNT(*)          
     FROM dbo.VW_ATENCIONPACIENTE WITH(NOLOCK)
       inner join SS_HC_EpisodioAtencion WITH(NOLOCK)
              on (SS_HC_EpisodioAtencion.UnidadReplicacion = VW_ATENCIONPACIENTE.UnidadReplicacion
       and    SS_HC_EpisodioAtencion.IdOrdenAtencion = VW_ATENCIONPACIENTE.IdOrdenAtencion
	    and    SS_HC_EpisodioAtencion.CodigoOA = VW_ATENCIONPACIENTE.CodigoOA
		and SS_HC_EpisodioAtencion.EpisodioClinico=VW_ATENCIONPACIENTE.EpisodioClinico
		and SS_HC_EpisodioAtencion.EpisodioAtencion=VW_ATENCIONPACIENTE.EpisodioAtencion
		and SS_HC_EpisodioAtencion.IdEpisodioAtencion=VW_ATENCIONPACIENTE.IdEpisodioAtencion
       and    SS_HC_EpisodioAtencion.IdPaciente = VW_ATENCIONPACIENTE.IdPaciente )       
       left join CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK)
       on (TipoPaciente.IdCodigo = VW_ATENCIONPACIENTE.TipoPaciente    
        and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
       left join SS_GE_TipoAtencion TipoAtencion WITH(NOLOCK)
       on (TipoAtencion.IdTipoAtencion = VW_ATENCIONPACIENTE.TipoAtencion)    
       left join PERSONAMAST personaPaciente WITH(NOLOCK)
       on (personaPaciente.Persona = VW_ATENCIONPACIENTE.idPaciente)                     
		 WHERE     
      (@NumeroFile is null or isnull(VW_ATENCIONPACIENTE.EstadoAsigMed,0)=@NumeroFile)and        
	   (@CodigoHC is null OR CodigoHC = @CodigoHC)    
       and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
       and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
       and (     
        (@FecIniDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion >= @FecIniDiscamec)    
        and    
        (@FecFinDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion <= DATEADD(DAY,1,@FecFinDiscamec))    
       )    
       and (@IdPaciente is null OR personaPaciente.Persona = @IdPaciente or  @IdPaciente=0)    
       and (@IdOrdenAtencion is null OR VW_ATENCIONPACIENTE.IdOrdenAtencion = @IdOrdenAtencion or  @IdOrdenAtencion=0)           
       and (@Servicio is null OR SS_HC_EpisodioAtencion.TipoEpisodio = @Servicio )           
       and (@Estado is null or     
        (case     
         when VW_ATENCIONPACIENTE.Estado IS null     
         then 0 else VW_ATENCIONPACIENTE.Estado   
        end ) = @Estado)            
    
  SELECT     
    [UnidadReplicacion]    
     ,[IdEpisodioAtencion]    
     ,[UnidadReplicacionEC]    
     ,[IdPaciente]    
     ,[EpisodioClinico]    
     ,[IdEstablecimientoSalud]    
     ,[IdUnidadServicio]    
     ,[IdPersonalSalud]         
     ,[EpisodioAtencion]    
     ,[FechaRegistro]    
     ,[FechaAtencion]    
     ,[TipoAtencion]    
     ,[IdOrdenAtencion]    
     ,[LineaOrdenAtencion]    
     ,[TipoOrdenAtencion]    
     ,[Estado]    
     ,[UsuarioCreacion]    
     ,[FechaCreacion]    
     ,NombreTrabajadorModificadorX as UsuarioModificacion
     ,[FechaModificacion]    
     ,[IdEspecialidad]    
     ,[CodigoOA]    
     ,[ProximaAtencionFlag]    
     ,[IdEspecialidadProxima]    
     ,[IdEstablecimientoSaludProxima]    
     ,[IdTipoInterConsulta]    
     ,[IdTipoReferencia]    
     ,[ObservacionProxima]    
     ,[DescansoMedico]    
     ,[DiasDescansoMedico]    
     ,[FechaInicioDescansoMedico]    
     ,[FechaFinDescansoMedico]    
     ,[FechaOrden]    
     ,[IdProcedimiento]    
     ,TipoAtencionDesc as ObservacionOrden
     ,[IdTipoOrden]    
     ,[Accion]    
     ,[Version]
     ,[FechaRegistroEpiClinico]    
     ,[FechaCierreEpiClinico]    
     ,[TipoPaciente]    
     ,[Edad]    
     ,[Raza]    
     ,[Religion]    
     ,NombreDiagnosticoX as Cargo
     ,[AreaLaboral]    
     ,[Ocupacion]    
     ,[CodigoHC]    
     ,[CodigoHCAnterior]    
     ,[CodigoHCSecundario]    
     ,[TipoAlmacenamiento]    
     ,[TipoHistoria]    
     ,[TipoSituacion]    
     ,[IdUbicacion]    
     ,[LugarProcedencia]    
     ,[RutaFoto]    
     ,[FechaIngreso]    
     ,[IndicadorNuevo]    
     ,[EstadoPaciente]    
     ,[NumeroFile]    
     ,[Servicio]    
     ,[UsuarioAlmacenamiento]    
     ,[FechaAlmacenamiento]    
     ,[Observacion]    
     ,[IndicadorAsistencia]    
     ,[CantidadAsistencia]    
     ,[UbicacionHHCC]    
     ,[IndicadorMigradoSiteds]    
     ,[NumeroCaja]    
     ,[IndicadorCodigoBarras]    
     ,[IDPACIENTE_OK]    
     ,[CodigoAsegurado]    
     ,[NumeroPoliza]    
     ,[CodigoProducto]    
     ,[CodigoPlan]    
     ,[TipoParentesco]    
     ,[CodigoBeneficio]    
     ,[Situacion]    
     ,[TomoActual]    
     ,[IndicadorHistoriaFisica]    
     ,[DescripcionHistoria]    
     ,[NumeroCertificado]    
     ,convert(int,RowNumber) as Persona
     ,[Origen]    
     ,[ApellidoPaterno]    
     ,[ApellidoMaterno]    
     ,[NombreCompleto]    
     ,[TipoDocumento]    
     ,[Documento]    
     ,[CodigoBarras]    
     ,[EsCliente]    
     ,[EsProveedor]    
     ,[EsEmpleado]    
     ,[EsOtro]    
     ,[TipoPersona]    
     ,[FechaNacimiento]    
     ,[Sexo]    
     ,[CiudadNacimiento]    
     ,[Nacionalidad]    
     ,[EstadoCivil]    
     ,[NivelInstruccion]    
     ,[Direccion]    
     ,[CodigoPostal]    
     ,[Provincia]    
     ,[Departamento]    
     ,[Telefono]    
     ,[Fax]    
     ,[DocumentoFiscal]    
     ,[DocumentoIdentidad]    
     ,[CarnetExtranjeria]    
     ,[DocumentoMilitarFA]    
     ,[TipoBrevete]    
     ,[Brevete]    
     ,[Pasaporte]    
     ,[NombreEmergencia]    
     ,[DireccionEmergencia]    
     ,[TelefonoEmergencia]    
     ,CodigoOAx+'_'+CONVERT(varchar,IdEpisodioAtencion)  as  PersonaAnt
     ,[CorreoElectronico]    
     ,[EnfermedadGraveFlag]    
     ,[IngresoFechaRegistro]    
     ,[IngresoAplicacionCodigo]    
     ,[IngresoUsuario]    
     ,[Celular]    
     ,[ParentescoEmergencia]    
     ,[CelularEmergencia]    
     ,[LugarNacimiento]    
     ,[SuspensionFonaviFlag]    
     ,[FlagRepetido]    
     ,[CodDiscamec]    
     ,[FecIniDiscamec]    
     ,[FecFinDiscamec]    
     ,[Pais]    
     ,TipoPacienteDesc as EsPaciente
     ,[EsEmpresa]    
     ,[Persona_Old]    
     ,Personax as personanew
     ,[EstadoPersona]    
       ,IDASIGNACIONMEDICO    
       ,tipoasignacion    
       ,ObservacionesAsigMed    
       ,EstadoAsigMed           
     ,EstadoEpiClinico    
     ,SecAsigMed    
     ,SecReferidaAsigMed   
  FROM (      
    SELECT VW_ATENCIONPACIENTE.*,                  
     @CONTADOR AS Contador,    
     VW_ATENCIONPACIENTE.Persona as Personax,
     VW_ATENCIONPACIENTE.CodigoOA as CodigoOAx,
       TipoPaciente.Descripcion as TipoPacienteDesc,        
       TipoAtencion.Nombre as TipoAtencionDesc,         
       GEdiagnostico.Nombre as NombreDiagnosticoX,
       (select top 1 Nombre from SG_Agente as agenteTrabajador 
		where agenteTrabajador.IdEmpleado = SS_HC_EpisodioAtencion.IdPersonalSalud 
		) as NombreTrabajadorModificadorX,       
     ROW_NUMBER() OVER (ORDER BY VW_ATENCIONPACIENTE.IdEpisodioAtencion ASC ) AS RowNumber        
     FROM dbo.VW_ATENCIONPACIENTE WITH(NOLOCK)
       inner join SS_HC_EpisodioAtencion WITH(NOLOCK)
             on (SS_HC_EpisodioAtencion.UnidadReplicacion = VW_ATENCIONPACIENTE.UnidadReplicacion
      -- and    SS_HC_EpisodioAtencion.IdEpisodioAtencion = VW_ATENCIONPACIENTE.IdEpisodioAtencion
       and    SS_HC_EpisodioAtencion.IdOrdenAtencion = VW_ATENCIONPACIENTE.IdOrdenAtencion
	    and    SS_HC_EpisodioAtencion.CodigoOA = VW_ATENCIONPACIENTE.CodigoOA
		and SS_HC_EpisodioAtencion.EpisodioClinico=VW_ATENCIONPACIENTE.EpisodioClinico
		and SS_HC_EpisodioAtencion.EpisodioAtencion=VW_ATENCIONPACIENTE.EpisodioAtencion
		and SS_HC_EpisodioAtencion.IdEpisodioAtencion=VW_ATENCIONPACIENTE.IdEpisodioAtencion
       and    SS_HC_EpisodioAtencion.IdPaciente = VW_ATENCIONPACIENTE.IdPaciente )
       left join CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK)
       on (TipoPaciente.IdCodigo = VW_ATENCIONPACIENTE.TipoPaciente    
        and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
       left join SS_GE_TipoAtencion TipoAtencion WITH(NOLOCK)
       on (TipoAtencion.IdTipoAtencion = VW_ATENCIONPACIENTE.TipoAtencion)    
       left join PERSONAMAST personaPaciente WITH(NOLOCK)
       on (personaPaciente.Persona = VW_ATENCIONPACIENTE.idPaciente)    
       left join SS_HC_Diagnostico HCdiagnostico WITH(NOLOCK)
       on (HCdiagnostico.IdPaciente = VW_ATENCIONPACIENTE.idPaciente
       and HCdiagnostico.IdEpisodioAtencion = VW_ATENCIONPACIENTE.IdEpisodioAtencion
       and HCdiagnostico.EpisodioClinico = VW_ATENCIONPACIENTE.EpisodioClinico
       )    
       left join SS_GE_Diagnostico GEdiagnostico WITH(NOLOCK)
       on (GEdiagnostico.IdDiagnostico = HCdiagnostico.IdDiagnostico)   
             
              
     WHERE     
      (@NumeroFile is null or isnull(VW_ATENCIONPACIENTE.EstadoAsigMed,0)=@NumeroFile)
       and (@CodigoHC is null OR CodigoHC = @CodigoHC)    
       and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
       and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       --and (@CodigoOA is null OR VW_ATENCIONPACIENTE.CodigoOA = @CodigoOA)    
       and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
       --OBS--and (@IdPersonalSalud is null OR VW_ATENCIONPACIENTE.IdPersonalSalud = @IdPersonalSalud)    
       and (     
        (@FecIniDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion >= @FecIniDiscamec)    
        and    
        (@FecFinDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion <= DATEADD(DAY,1,@FecFinDiscamec))    
       )    
       and (@IdPaciente is null OR personaPaciente.Persona = @IdPaciente or  @IdPaciente=0)    
       and (@IdOrdenAtencion is null OR VW_ATENCIONPACIENTE.IdOrdenAtencion = @IdOrdenAtencion or  @IdOrdenAtencion=0)           
		and (@Servicio is null OR SS_HC_EpisodioAtencion.TipoEpisodio = @Servicio )                  
       and (@Estado is null or     
        (case     
         when VW_ATENCIONPACIENTE.Estado IS null     
         then 0 else VW_ATENCIONPACIENTE.Estado   
        end ) = @Estado)          
        
     ) AS LISTADO    
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR      
            RowNumber BETWEEN @Inicio  AND @NumeroFilas                          
		
 end  

 else
 if(@ACCION = 'LISTARFARMACO')   -- LUKE 17-02-2020 
 begin       
     
  SELECT @CONTADOR= COUNT(*)          
     FROM dbo.VW_ATENCIONPACIENTE_NOFARMACOLOGICO WITH(NOLOCK)
       inner join SS_HC_EpisodioAtencion WITH(NOLOCK)
       on (SS_HC_EpisodioAtencion.UnidadReplicacion = VW_ATENCIONPACIENTE_NOFARMACOLOGICO.UnidadReplicacion
       and    SS_HC_EpisodioAtencion.IdEpisodioAtencion = VW_ATENCIONPACIENTE_NOFARMACOLOGICO.IdEpisodioAtencion
       and    SS_HC_EpisodioAtencion.EpisodioClinico = VW_ATENCIONPACIENTE_NOFARMACOLOGICO.EpisodioClinico
       and    SS_HC_EpisodioAtencion.IdPaciente = VW_ATENCIONPACIENTE_NOFARMACOLOGICO.IdPaciente       
       )            
       left join CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK)
       on (TipoPaciente.IdCodigo = VW_ATENCIONPACIENTE_NOFARMACOLOGICO.TipoPaciente    
        and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
       left join SS_GE_TipoAtencion TipoAtencion WITH(NOLOCK)
       on (TipoAtencion.IdTipoAtencion = VW_ATENCIONPACIENTE_NOFARMACOLOGICO.TipoAtencion)    
       left join PERSONAMAST personaPaciente WITH(NOLOCK)
       on (personaPaciente.Persona = VW_ATENCIONPACIENTE_NOFARMACOLOGICO.idPaciente)                     
		 WHERE     
      (@NumeroFile is null or isnull(VW_ATENCIONPACIENTE_NOFARMACOLOGICO.EstadoAsigMed,0)=@NumeroFile)
	   and (@CodigoHC is null OR CodigoHC = @CodigoHC)    
       and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
       and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE_NOFARMACOLOGICO.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
       and (     
        (@FecIniDiscamec is null or  VW_ATENCIONPACIENTE_NOFARMACOLOGICO.FechaAtencion >= @FecIniDiscamec)    
        and    
        (@FecFinDiscamec is null or  VW_ATENCIONPACIENTE_NOFARMACOLOGICO.FechaAtencion <= DATEADD(DAY,1,@FecFinDiscamec))    
       )    
       and (@IdPaciente is null OR personaPaciente.Persona = @IdPaciente or  @IdPaciente=0)    
       and (@EpisodioClinico is null OR VW_ATENCIONPACIENTE_NOFARMACOLOGICO.EpisodioClinico = @EpisodioClinico or  @EpisodioClinico=0)    
       and (@IdOrdenAtencion is null OR VW_ATENCIONPACIENTE_NOFARMACOLOGICO.IdOrdenAtencion = @IdOrdenAtencion or  @IdOrdenAtencion=0)           
       and (@LineaOrdenAtencion is null OR VW_ATENCIONPACIENTE_NOFARMACOLOGICO.LineaOrdenAtencion = @LineaOrdenAtencion or  @LineaOrdenAtencion=0)                         
       and (@Servicio is null OR SS_HC_EpisodioAtencion.TipoEpisodio = @Servicio )           
       and (@Estado is null or     
        (case     
         when VW_ATENCIONPACIENTE_NOFARMACOLOGICO.Estado IS null     
         then 0 else VW_ATENCIONPACIENTE_NOFARMACOLOGICO.Estado   
        end ) = @Estado)            
    
  SELECT     
    [UnidadReplicacion]    
     ,[IdEpisodioAtencion]    
     ,[UnidadReplicacionEC]    
     ,[IdPaciente]    
     ,[EpisodioClinico]    
     ,[IdEstablecimientoSalud]    
     ,[IdUnidadServicio]    
     ,[IdPersonalSalud]         
     ,[EpisodioAtencion]    
     ,[FechaRegistro]    
     ,[FechaAtencion]    
     ,[TipoAtencion]    
     ,[IdOrdenAtencion]    
     ,[LineaOrdenAtencion]    
     ,[TipoOrdenAtencion]    
     ,[Estado]    
     ,[UsuarioCreacion]    
     ,[FechaCreacion]    
     ,NombreTrabajadorModificadorX as UsuarioModificacion
     ,[FechaModificacion]    
     ,[IdEspecialidad]    
     ,[CodigoOA]    
     ,[ProximaAtencionFlag]    
     ,[IdEspecialidadProxima]    
     ,[IdEstablecimientoSaludProxima]    
     ,[IdTipoInterConsulta]    
     ,[IdTipoReferencia]    
     ,[ObservacionProxima]    
     ,[DescansoMedico]    
     ,[DiasDescansoMedico]    
     ,[FechaInicioDescansoMedico]    
     ,[FechaFinDescansoMedico]    
     ,[FechaOrden]    
     ,[IdProcedimiento]    
     ,TipoAtencionDesc as ObservacionOrden
     ,[IdTipoOrden]    
     ,[Accion]    
     ,[Version]
     ,[FechaRegistroEpiClinico]    
     ,[FechaCierreEpiClinico]    
     ,[TipoPaciente]    
     ,[Edad]    
     ,[Raza]    
     ,[Religion]    
     ,NombreDiagnosticoX as Cargo
     ,[AreaLaboral]    
     ,[Ocupacion]    
     ,[CodigoHC]    
     ,[CodigoHCAnterior]    
     ,[CodigoHCSecundario]    
     ,[TipoAlmacenamiento]    
     ,[TipoHistoria]    
     ,[TipoSituacion]    
     ,[IdUbicacion]    
     ,[LugarProcedencia]    
     ,[RutaFoto]    
     ,[FechaIngreso]    
     ,[IndicadorNuevo]    
     ,[EstadoPaciente]    
     ,[NumeroFile]    
     ,[Servicio]    
     ,[UsuarioAlmacenamiento]    
     ,[FechaAlmacenamiento]    
     ,[Observacion]    
     ,[IndicadorAsistencia]    
     ,[CantidadAsistencia]    
     ,[UbicacionHHCC]    
     ,[IndicadorMigradoSiteds]    
     ,[NumeroCaja]    
     ,[IndicadorCodigoBarras]    
     ,[IDPACIENTE_OK]    
     ,[CodigoAsegurado]    
     ,[NumeroPoliza]    
     ,[CodigoProducto]    
     ,[CodigoPlan]    
     ,[TipoParentesco]    
     ,[CodigoBeneficio]    
     ,[Situacion]    
     ,[TomoActual]    
     ,[IndicadorHistoriaFisica]    
     ,[DescripcionHistoria]    
     ,[NumeroCertificado]    
     ,convert(int,RowNumber) as Persona
     ,[Origen]    
     ,[ApellidoPaterno]    
     ,[ApellidoMaterno]    
     ,[NombreCompleto]    
     ,[TipoDocumento]    
     ,[Documento]    
     ,[CodigoBarras]    
     ,[EsCliente]    
     ,[EsProveedor]    
     ,[EsEmpleado]    
     ,[EsOtro]    
     ,[TipoPersona]    
     ,[FechaNacimiento]    
     ,[Sexo]    
     ,[CiudadNacimiento]    
     ,[Nacionalidad]    
     ,[EstadoCivil]    
     ,[NivelInstruccion]    
     ,[Direccion]    
     ,[CodigoPostal]    
     ,[Provincia]    
     ,[Departamento]    
     ,[Telefono]    
     ,[Fax]    
     ,[DocumentoFiscal]    
     ,[DocumentoIdentidad]    
     ,[CarnetExtranjeria]    
     ,[DocumentoMilitarFA]    
     ,[TipoBrevete]    
     ,[Brevete]    
     ,[Pasaporte]    
     ,[NombreEmergencia]    
     ,[DireccionEmergencia]    
     ,[TelefonoEmergencia]    
     ,CodigoOAx+'_'+CONVERT(varchar,IdEpisodioAtencion)  as  PersonaAnt
     ,[CorreoElectronico]    
     ,[EnfermedadGraveFlag]    
     ,[IngresoFechaRegistro]    
     ,[IngresoAplicacionCodigo]    
     ,[IngresoUsuario]    
     ,[Celular]    
     ,[ParentescoEmergencia]    
     ,[CelularEmergencia]    
     ,[LugarNacimiento]    
     ,[SuspensionFonaviFlag]    
     ,[FlagRepetido]    
     ,[CodDiscamec]    
     ,[FecIniDiscamec]    
     ,[FecFinDiscamec]    
     ,[Pais]    
     ,TipoPacienteDesc as EsPaciente
     ,[EsEmpresa]    
     ,[Persona_Old]    
     ,Personax as personanew
     ,[EstadoPersona]    
       ,IDASIGNACIONMEDICO    
       ,tipoasignacion    
       ,ObservacionesAsigMed    
       ,EstadoAsigMed           
     ,EstadoEpiClinico    
     ,SecAsigMed    
     ,SecReferidaAsigMed   
  FROM (      
    SELECT VW_ATENCIONPACIENTE_NOFARMACOLOGICO.*,                  
     @CONTADOR AS Contador,    
     VW_ATENCIONPACIENTE_NOFARMACOLOGICO.Persona as Personax,
     VW_ATENCIONPACIENTE_NOFARMACOLOGICO.CodigoOA as CodigoOAx,
       TipoPaciente.Descripcion as TipoPacienteDesc,        
       TipoAtencion.Nombre as TipoAtencionDesc,         
       GEdiagnostico.Nombre as NombreDiagnosticoX,
       (select top 1 Nombre from SG_Agente as agenteTrabajador 
		where agenteTrabajador.IdEmpleado = SS_HC_EpisodioAtencion.IdPersonalSalud 
		) as NombreTrabajadorModificadorX,       
     ROW_NUMBER() OVER (ORDER BY VW_ATENCIONPACIENTE_NOFARMACOLOGICO.IdEpisodioAtencion ASC ) AS RowNumber        
     FROM dbo.VW_ATENCIONPACIENTE_NOFARMACOLOGICO WITH(NOLOCK)
       inner join SS_HC_EpisodioAtencion WITH(NOLOCK)
       on (SS_HC_EpisodioAtencion.UnidadReplicacion = VW_ATENCIONPACIENTE_NOFARMACOLOGICO.UnidadReplicacion
       and    SS_HC_EpisodioAtencion.IdEpisodioAtencion = VW_ATENCIONPACIENTE_NOFARMACOLOGICO.IdEpisodioAtencion
       and    SS_HC_EpisodioAtencion.EpisodioClinico = VW_ATENCIONPACIENTE_NOFARMACOLOGICO.EpisodioClinico
       and    SS_HC_EpisodioAtencion.IdPaciente = VW_ATENCIONPACIENTE_NOFARMACOLOGICO.IdPaciente       
       )            
       left join CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK)
       on (TipoPaciente.IdCodigo = VW_ATENCIONPACIENTE_NOFARMACOLOGICO.TipoPaciente    
        and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
       left join SS_GE_TipoAtencion TipoAtencion WITH(NOLOCK)
       on (TipoAtencion.IdTipoAtencion = VW_ATENCIONPACIENTE_NOFARMACOLOGICO.TipoAtencion)    
       left join PERSONAMAST personaPaciente WITH(NOLOCK)
       on (personaPaciente.Persona = VW_ATENCIONPACIENTE_NOFARMACOLOGICO.idPaciente)    
       left join SS_HC_Diagnostico HCdiagnostico WITH(NOLOCK)
       on (HCdiagnostico.IdPaciente = VW_ATENCIONPACIENTE_NOFARMACOLOGICO.idPaciente
       and HCdiagnostico.IdEpisodioAtencion = VW_ATENCIONPACIENTE_NOFARMACOLOGICO.IdEpisodioAtencion
       and HCdiagnostico.EpisodioClinico = VW_ATENCIONPACIENTE_NOFARMACOLOGICO.EpisodioClinico
       )    

       left join SS_GE_Diagnostico GEdiagnostico WITH(NOLOCK)
       on (GEdiagnostico.IdDiagnostico = HCdiagnostico.IdDiagnostico)   
             
              
     WHERE     
      (@NumeroFile is null or isnull(VW_ATENCIONPACIENTE_NOFARMACOLOGICO.EstadoAsigMed,0)=@NumeroFile)
       and (@CodigoHC is null OR CodigoHC = @CodigoHC)    
       and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
       and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE_NOFARMACOLOGICO.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
       and (     
        (@FecIniDiscamec is null or  VW_ATENCIONPACIENTE_NOFARMACOLOGICO.FechaAtencion >= @FecIniDiscamec)    
        and    
        (@FecFinDiscamec is null or  VW_ATENCIONPACIENTE_NOFARMACOLOGICO.FechaAtencion <= DATEADD(DAY,1,@FecFinDiscamec))    
       )    
       and (@IdPaciente is null OR personaPaciente.Persona = @IdPaciente or  @IdPaciente=0)    
       and (@EpisodioClinico is null OR VW_ATENCIONPACIENTE_NOFARMACOLOGICO.EpisodioClinico = @EpisodioClinico or  @EpisodioClinico=0)    
	   and (VW_ATENCIONPACIENTE_NOFARMACOLOGICO.ObservacionProxima IS NOT NULL) 
       ---
       and (@IdOrdenAtencion is null OR VW_ATENCIONPACIENTE_NOFARMACOLOGICO.IdOrdenAtencion = @IdOrdenAtencion or  @IdOrdenAtencion=0)           
       and (@LineaOrdenAtencion is null OR VW_ATENCIONPACIENTE_NOFARMACOLOGICO.LineaOrdenAtencion = @LineaOrdenAtencion or  @LineaOrdenAtencion=0)           
		and (@Servicio is null OR SS_HC_EpisodioAtencion.TipoEpisodio = @Servicio )                  
       and (@Estado is null or     
        (case     
         when VW_ATENCIONPACIENTE_NOFARMACOLOGICO.Estado IS null     
         then 0 else VW_ATENCIONPACIENTE_NOFARMACOLOGICO.Estado   
        end ) = @Estado)          
        
     ) AS LISTADO    
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR      
            RowNumber BETWEEN @Inicio  AND @NumeroFilas                          
		
 end 
 
 
 else
 if(@ACCION = 'LISTARDISPE')   -- LUKE 17-02-2020 
 begin       
     
  SELECT @CONTADOR= COUNT(*)          
     FROM dbo.VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS WITH(NOLOCK)
       inner join SS_HC_EpisodioAtencion WITH(NOLOCK)
       on (SS_HC_EpisodioAtencion.UnidadReplicacion = VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.UnidadReplicacion
       and    SS_HC_EpisodioAtencion.IdEpisodioAtencion = VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.IdEpisodioAtencion
       and    SS_HC_EpisodioAtencion.EpisodioClinico = VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.EpisodioClinico
       and    SS_HC_EpisodioAtencion.IdPaciente = VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.IdPaciente       
       )            
       left join CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK)
       on (TipoPaciente.IdCodigo = VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.TipoPaciente    
        and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
       left join SS_GE_TipoAtencion TipoAtencion WITH(NOLOCK)
       on (TipoAtencion.IdTipoAtencion = VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.TipoAtencion)    
       left join PERSONAMAST personaPaciente WITH(NOLOCK)
       on (personaPaciente.Persona = VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.idPaciente)                     
		 WHERE     
      (@NumeroFile is null or isnull(VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.EstadoAsigMed,0)=@NumeroFile)and        
	   (@CodigoHC is null OR CodigoHC = @CodigoHC)    
       and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
       and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
       and (     
        (@FecIniDiscamec is null or  VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.FechaAtencion >= @FecIniDiscamec)    
        and    
        (@FecFinDiscamec is null or  VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.FechaAtencion <= DATEADD(DAY,1,@FecFinDiscamec))    
       )    
       and (@IdPaciente is null OR personaPaciente.Persona = @IdPaciente or  @IdPaciente=0)    
       and (@EpisodioClinico is null OR VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.EpisodioClinico = @EpisodioClinico or  @EpisodioClinico=0)    
       and (@EpisodioAtencion is null OR VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.IdEpisodioAtencion = @EpisodioAtencion or  @EpisodioAtencion=0)           
       and (@IdOrdenAtencion is null OR VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.IdOrdenAtencion = @IdOrdenAtencion or  @IdOrdenAtencion=0)           
       and (@LineaOrdenAtencion is null OR VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.LineaOrdenAtencion = @LineaOrdenAtencion or  @LineaOrdenAtencion=0)                         
       and (@Servicio is null OR SS_HC_EpisodioAtencion.TipoEpisodio = @Servicio )           
       and (@Estado is null or     
        (case     
         when VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.Estado IS null     
         then 0 else VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.Estado   
        end ) = @Estado)            
    
  SELECT     
    [UnidadReplicacion]    
     ,[IdEpisodioAtencion]    
     ,[UnidadReplicacionEC]    
     ,[IdPaciente]    
     ,[EpisodioClinico]    
     ,[IdEstablecimientoSalud]    
     ,[IdUnidadServicio]    
     ,[IdPersonalSalud]         
     ,[EpisodioAtencion]    
     ,[FechaRegistro]    
     ,[FechaAtencion]    
     ,[TipoAtencion]    
     ,[IdOrdenAtencion]    
     ,[LineaOrdenAtencion]    
     ,[TipoOrdenAtencion]    
     ,[Estado]    
     ,[UsuarioCreacion]    
     ,[FechaCreacion]    
     ,NombreTrabajadorModificadorX as UsuarioModificacion
     ,[FechaModificacion]    
     ,[IdEspecialidad]    
     ,[CodigoOA]    
     ,[ProximaAtencionFlag]    
     ,[IdEspecialidadProxima]    
     ,[IdEstablecimientoSaludProxima]    
     ,[IdTipoInterConsulta]    
     ,[IdTipoReferencia]    
     ,[ObservacionProxima]    
     ,[DescansoMedico]    
     ,[DiasDescansoMedico]    
     ,[FechaInicioDescansoMedico]    
     ,[FechaFinDescansoMedico]    
     ,[FechaOrden]    
     ,[IdProcedimiento]    
     ,TipoAtencionDesc as ObservacionOrden
     ,[IdTipoOrden]    
     ,[Accion]    
     ,[Version]
     ,[FechaRegistroEpiClinico]    
     ,[FechaCierreEpiClinico]    
     ,[TipoPaciente]    
     ,[Edad]    
     ,[Raza]    
     ,[Religion]    
     ,NombreDiagnosticoX as Cargo
     ,[AreaLaboral]    
     ,[Ocupacion]    
     ,[CodigoHC]    
     ,[CodigoHCAnterior]    
     ,[CodigoHCSecundario]    
     ,[TipoAlmacenamiento]    
     ,[TipoHistoria]    
     ,[TipoSituacion]    
     ,[IdUbicacion]    
     ,[LugarProcedencia]    
     ,[RutaFoto]    
     ,[FechaIngreso]    
     ,[IndicadorNuevo]    
     ,[EstadoPaciente]    
     ,[NumeroFile]    
     ,[Servicio]    
     ,[UsuarioAlmacenamiento]    
     ,[FechaAlmacenamiento]    
     ,[Observacion]    
     ,[IndicadorAsistencia]    
     ,[CantidadAsistencia]    
     ,[UbicacionHHCC]    
     ,[IndicadorMigradoSiteds]    
     ,[NumeroCaja]    
     ,[IndicadorCodigoBarras]    
     ,[IDPACIENTE_OK]    
     ,[CodigoAsegurado]    
     ,[NumeroPoliza]    
     ,[CodigoProducto]    
     ,[CodigoPlan]    
     ,[TipoParentesco]    
     ,[CodigoBeneficio]    
     ,[Situacion]    
     ,[TomoActual]    
     ,[IndicadorHistoriaFisica]    
     ,[DescripcionHistoria]    
     ,[NumeroCertificado]    
     ,convert(int,RowNumber) as Persona
     ,[Origen]    
     ,[ApellidoPaterno]    
     ,[ApellidoMaterno]    
     ,[NombreCompleto]    
     ,[TipoDocumento]    
     ,[Documento]    
     ,[CodigoBarras]    
     ,[EsCliente]    
     ,[EsProveedor]    
     ,[EsEmpleado]    
     ,[EsOtro]    
     ,[TipoPersona]    
     ,[FechaNacimiento]    
     ,[Sexo]    
     ,[CiudadNacimiento]    
     ,[Nacionalidad]    
     ,[EstadoCivil]    
     ,[NivelInstruccion]    
     ,[Direccion]    
     ,[CodigoPostal]    
     ,[Provincia]    
     ,[Departamento]    
     ,[Telefono]    
     ,[Fax]    
     ,[DocumentoFiscal]    
     ,[DocumentoIdentidad]    
     ,[CarnetExtranjeria]    
     ,[DocumentoMilitarFA]    
     ,[TipoBrevete]    
     ,[Brevete]    
     ,[Pasaporte]    
     ,[NombreEmergencia]    
     ,[DireccionEmergencia]    
     ,[TelefonoEmergencia]    
     ,CodigoOAx+'_'+CONVERT(varchar,IdEpisodioAtencion)  as  PersonaAnt
     ,[CorreoElectronico]    
     ,[EnfermedadGraveFlag]    
     ,[IngresoFechaRegistro]    
     ,[IngresoAplicacionCodigo]    
     ,[IngresoUsuario]    
     ,[Celular]    
     ,[ParentescoEmergencia]    
     ,[CelularEmergencia]    
     ,[LugarNacimiento]    
     ,[SuspensionFonaviFlag]    
     ,[FlagRepetido]    
     ,[CodDiscamec]    
     ,[FecIniDiscamec]    
     ,[FecFinDiscamec]    
     ,[Pais]    
     ,TipoPacienteDesc as EsPaciente
     ,[EsEmpresa]    
     ,[Persona_Old]    
     ,Personax as personanew
     ,[EstadoPersona]    
       ,IDASIGNACIONMEDICO    
       ,tipoasignacion    
       ,ObservacionesAsigMed    
       ,EstadoAsigMed           
     ,EstadoEpiClinico    
     ,SecAsigMed    
     ,SecReferidaAsigMed   
  FROM (      
    SELECT VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.*,                  
     @CONTADOR AS Contador,    
     VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.Persona as Personax,
     VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.CodigoOA as CodigoOAx,
       TipoPaciente.Descripcion as TipoPacienteDesc,        
       TipoAtencion.Nombre as TipoAtencionDesc,         
       GEdiagnostico.Nombre as NombreDiagnosticoX,
       (select top 1 Nombre from SG_Agente as agenteTrabajador 
		where agenteTrabajador.IdEmpleado = SS_HC_EpisodioAtencion.IdPersonalSalud 
		) as NombreTrabajadorModificadorX,       
     ROW_NUMBER() OVER (ORDER BY VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.IdEpisodioAtencion ASC ) AS RowNumber        
     FROM dbo.VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS WITH(NOLOCK)
       inner join SS_HC_EpisodioAtencion WITH(NOLOCK)
       on (SS_HC_EpisodioAtencion.UnidadReplicacion = VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.UnidadReplicacion
       and    SS_HC_EpisodioAtencion.IdEpisodioAtencion = VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.IdEpisodioAtencion
       and    SS_HC_EpisodioAtencion.EpisodioClinico = VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.EpisodioClinico
       and    SS_HC_EpisodioAtencion.IdPaciente = VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.IdPaciente       
       )            
       left join CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK)
       on (TipoPaciente.IdCodigo = VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.TipoPaciente    
        and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
       left join SS_GE_TipoAtencion TipoAtencion WITH(NOLOCK)
       on (TipoAtencion.IdTipoAtencion = VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.TipoAtencion)    
       left join PERSONAMAST personaPaciente WITH(NOLOCK)
       on (personaPaciente.Persona = VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.idPaciente)    
       left join SS_HC_Diagnostico HCdiagnostico WITH(NOLOCK)
       on (HCdiagnostico.IdPaciente = VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.idPaciente
       and HCdiagnostico.IdEpisodioAtencion = VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.IdEpisodioAtencion
       and HCdiagnostico.EpisodioClinico = VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.EpisodioClinico
       )    

       left join SS_GE_Diagnostico GEdiagnostico WITH(NOLOCK)
       on (GEdiagnostico.IdDiagnostico = HCdiagnostico.IdDiagnostico)   
             
              
     WHERE     
      (@NumeroFile is null or isnull(VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.EstadoAsigMed,0)=@NumeroFile)
       and (@CodigoHC is null OR CodigoHC = @CodigoHC)    
       and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
       and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       --and (@CodigoOA is null OR VW_ATENCIONPACIENTE.CodigoOA = @CodigoOA)    
       and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
       --OBS--and (@IdPersonalSalud is null OR VW_ATENCIONPACIENTE.IdPersonalSalud = @IdPersonalSalud)    
       and (     
        (@FecIniDiscamec is null or  VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.FechaAtencion >= @FecIniDiscamec)    
        and    
        (@FecFinDiscamec is null or  VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.FechaAtencion <= DATEADD(DAY,1,@FecFinDiscamec))    
       )    
       and (@IdPaciente is null OR personaPaciente.Persona = @IdPaciente or  @IdPaciente=0)    
       and (@EpisodioClinico is null OR VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.EpisodioClinico = @EpisodioClinico or  @EpisodioClinico=0)    
       and (@EpisodioAtencion is null OR VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.IdEpisodioAtencion = @EpisodioAtencion or  @EpisodioAtencion=0)        

       and (@IdOrdenAtencion is null OR VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.IdOrdenAtencion = @IdOrdenAtencion or  @IdOrdenAtencion=0)           
       and (@LineaOrdenAtencion is null OR VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.LineaOrdenAtencion = @LineaOrdenAtencion or  @LineaOrdenAtencion=0)           
       ----
		and (@Servicio is null OR SS_HC_EpisodioAtencion.TipoEpisodio = @Servicio )                  
       and (@Estado is null or     
        (case     
         when VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.Estado IS null     
         then 0 else VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS.Estado   
        end ) = @Estado)          
        
     ) AS LISTADO    
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR      
            RowNumber BETWEEN @Inicio  AND @NumeroFilas    		
 end     
 
     
 ELSE


  if(@ACCION = 'EVOLUCIONOBJETIVA')   -- LUKE - 03-03-2020
 begin       
     
  SELECT @CONTADOR= COUNT(*)          
     FROM dbo.VW_ATENCIONPACIENTE_EVOLUCION_MEDICA WITH(NOLOCK)
       inner join SS_HC_EpisodioAtencion WITH(NOLOCK)
       on (SS_HC_EpisodioAtencion.UnidadReplicacion = VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.UnidadReplicacion
	 and    SS_HC_EpisodioAtencion.IdEpisodioAtencion = VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.IdEpisodioAtencion
      and    SS_HC_EpisodioAtencion.EpisodioClinico = VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.EpisodioClinico
       and    SS_HC_EpisodioAtencion.IdPaciente = VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.IdPaciente       
       )            
       left join CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK)
       on (TipoPaciente.IdCodigo = VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.TipoPaciente    
        and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
       left join SS_GE_TipoAtencion TipoAtencion WITH(NOLOCK)
       on (TipoAtencion.IdTipoAtencion = VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.TipoAtencion)    
       left join PERSONAMAST personaPaciente WITH(NOLOCK)
       on (personaPaciente.Persona = VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.idPaciente)                     
		 WHERE     
      (@NumeroFile is null or isnull(VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.EstadoAsigMed,0)=@NumeroFile)and        
	   (@CodigoHC is null OR CodigoHC = @CodigoHC)    
       and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
       and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       --and (@CodigoOA is null OR VW_ATENCIONPACIENTE.CodigoOA = @CodigoOA)    
       and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
       --OBS--and (@IdPersonalSalud is null OR VW_ATENCIONPACIENTE.IdPersonalSalud = @IdPersonalSalud)    
       and (     
        (@FecIniDiscamec is null or  VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.FechaAtencion >= @FecIniDiscamec)    
        and    
        (@FecFinDiscamec is null or  VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.FechaAtencion <= DATEADD(DAY,1,@FecFinDiscamec))    
       )    
       and (@IdPaciente is null OR personaPaciente.Persona = @IdPaciente or  @IdPaciente=0)    
       and (@EpisodioClinico is null OR VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.EpisodioClinico = @EpisodioClinico or  @EpisodioClinico=0)    
       and (@IdOrdenAtencion is null OR VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.IdOrdenAtencion = @IdOrdenAtencion or  @IdOrdenAtencion=0)           
       and (@LineaOrdenAtencion is null OR VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.LineaOrdenAtencion = @LineaOrdenAtencion or  @LineaOrdenAtencion=0)                         
       -----
       and (@Servicio is null OR SS_HC_EpisodioAtencion.TipoEpisodio = @Servicio )           
       
       and (@Estado is null or     
        (case     
         when VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.Estado IS null     
         then 0 else VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.Estado   
        end ) = @Estado)            
    
  SELECT     
    [UnidadReplicacion]    
     ,[IdEpisodioAtencion]    
     ,[UnidadReplicacionEC]    
     ,[IdPaciente]    
     ,[EpisodioClinico]    
     ,[IdEstablecimientoSalud]    
     ,[IdUnidadServicio]    
     ,[IdPersonalSalud]         
     ,[EpisodioAtencion]    
     ,[FechaRegistro]    
     ,[FechaAtencion]    
     ,[TipoAtencion]    
     ,[IdOrdenAtencion]    
     ,[LineaOrdenAtencion]    
     ,[TipoOrdenAtencion]    
     ,[Estado]    
     ,[UsuarioCreacion]    
     ,[FechaCreacion]    
     ,NombreTrabajadorModificadorX as UsuarioModificacion
     ,[FechaModificacion]    
     ,[IdEspecialidad]    
     ,[CodigoOA]    
     ,[ProximaAtencionFlag]    
     ,[IdEspecialidadProxima]    
     ,[IdEstablecimientoSaludProxima]    
     ,[IdTipoInterConsulta]    
     ,[IdTipoReferencia]    
     ,[ObservacionProxima]    
     ,[DescansoMedico]    
     ,[DiasDescansoMedico]    
     ,[FechaInicioDescansoMedico]    
     ,[FechaFinDescansoMedico]    
     ,[FechaOrden]    
     ,[IdProcedimiento]    
     ,TipoAtencionDesc as ObservacionOrden
     ,[IdTipoOrden]    
     ,[Accion]    
     ,[Version]
     ,[FechaRegistroEpiClinico]    
     ,[FechaCierreEpiClinico]    
     ,[TipoPaciente]    
     ,[Edad]    
     ,[Raza]    
     ,[Religion]    
     ,NombreDiagnosticoX as Cargo
     ,[AreaLaboral]    
     ,[Ocupacion]    
     ,[CodigoHC]    
     ,[CodigoHCAnterior]    
     ,[CodigoHCSecundario]    
     ,[TipoAlmacenamiento]    
     ,[TipoHistoria]    
     ,[TipoSituacion]    
     ,[IdUbicacion]    
     ,[LugarProcedencia]    
     ,[RutaFoto]    
     ,[FechaIngreso]    
     ,[IndicadorNuevo]    
     ,[EstadoPaciente]    
     ,[NumeroFile]    
     ,[Servicio]    
     ,[UsuarioAlmacenamiento]    
     ,[FechaAlmacenamiento]    
     ,[Observacion]    
     ,[IndicadorAsistencia]    
     ,[CantidadAsistencia]    
     ,[UbicacionHHCC]    
     ,[IndicadorMigradoSiteds]    
     ,[NumeroCaja]    
     ,[IndicadorCodigoBarras]    
     ,[IDPACIENTE_OK]    
     ,[CodigoAsegurado]    
     ,[NumeroPoliza]    
     ,[CodigoProducto]    
     ,[CodigoPlan]    
     ,[TipoParentesco]    
     ,[CodigoBeneficio]    
     ,[Situacion]    
     ,[TomoActual]    
     ,[IndicadorHistoriaFisica]    
     ,[DescripcionHistoria]    
     ,[NumeroCertificado]    
     ,convert(int,RowNumber) as Persona
     ,[Origen]    
     ,[ApellidoPaterno]    
     ,[ApellidoMaterno]    
     ,[NombreCompleto]    
     ,[TipoDocumento]    
     ,[Documento]    
     ,[CodigoBarras]    
     ,[EsCliente]    
     ,[EsProveedor]    
     ,[EsEmpleado]    
     ,[EsOtro]    
     ,[TipoPersona]    
     ,[FechaNacimiento]    
     ,[Sexo]    
     ,[CiudadNacimiento]    
     ,[Nacionalidad]    
     ,[EstadoCivil]    
     ,[NivelInstruccion]    
     ,[Direccion]    
     ,[CodigoPostal]    
     ,[Provincia]    
     ,[Departamento]    
     ,[Telefono]    
     ,[Fax]    
     ,[DocumentoFiscal]    
     ,[DocumentoIdentidad]    
     ,[CarnetExtranjeria]    
     ,[DocumentoMilitarFA]    
     ,[TipoBrevete]    
     ,[Brevete]    
     ,[Pasaporte]    
     ,[NombreEmergencia]    
     ,[DireccionEmergencia]    
     ,[TelefonoEmergencia]    
     ,CodigoOAx+'_'+CONVERT(varchar,IdEpisodioAtencion)  as  PersonaAnt
     ,[CorreoElectronico]    
     ,[EnfermedadGraveFlag]    
     ,[IngresoFechaRegistro]    
     ,[IngresoAplicacionCodigo]    
     ,[IngresoUsuario]    
     ,[Celular]    
     ,[ParentescoEmergencia]    
     ,[CelularEmergencia]    
     ,[LugarNacimiento]    
     ,[SuspensionFonaviFlag]    
     ,[FlagRepetido]    
     ,[CodDiscamec]    
     ,[FecIniDiscamec]    
     ,[FecFinDiscamec]    
     ,[Pais]    
     ,TipoPacienteDesc as EsPaciente
     ,[EsEmpresa]    
     ,[Persona_Old]    
     ,Personax as personanew
     ,[EstadoPersona]    
       ,IDASIGNACIONMEDICO    
       ,tipoasignacion    
       ,ObservacionesAsigMed    
       ,EstadoAsigMed           
     ,EstadoEpiClinico    
     ,SecAsigMed    
     ,SecReferidaAsigMed   
  FROM (      
    SELECT VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.*,                  
     @CONTADOR AS Contador,    
     VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.Persona as Personax,
     VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.CodigoOA as CodigoOAx,
       TipoPaciente.Descripcion as TipoPacienteDesc,        
       TipoAtencion.Nombre as TipoAtencionDesc,         
       GEdiagnostico.Nombre as NombreDiagnosticoX,
       (select top 1 Nombre from SG_Agente as agenteTrabajador 
		where agenteTrabajador.IdEmpleado = SS_HC_EpisodioAtencion.IdPersonalSalud 
		) as NombreTrabajadorModificadorX,       
     ROW_NUMBER() OVER (ORDER BY VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.IdEpisodioAtencion ASC ) AS RowNumber        
     FROM dbo.VW_ATENCIONPACIENTE_EVOLUCION_MEDICA WITH(NOLOCK)
       inner join SS_HC_EpisodioAtencion WITH(NOLOCK)
       on (SS_HC_EpisodioAtencion.UnidadReplicacion = VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.UnidadReplicacion
      and    SS_HC_EpisodioAtencion.IdEpisodioAtencion = VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.IdEpisodioAtencion
      and    SS_HC_EpisodioAtencion.EpisodioClinico = VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.EpisodioClinico
       and    SS_HC_EpisodioAtencion.IdPaciente = VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.IdPaciente       
       )            
       left join CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK)
       on (TipoPaciente.IdCodigo = VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.TipoPaciente    
        and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
       left join SS_GE_TipoAtencion TipoAtencion WITH(NOLOCK)
       on (TipoAtencion.IdTipoAtencion = VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.TipoAtencion)    
       left join PERSONAMAST personaPaciente WITH(NOLOCK)
       on (personaPaciente.Persona = VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.idPaciente)    
       left join SS_HC_Diagnostico HCdiagnostico WITH(NOLOCK)
       on (HCdiagnostico.IdPaciente = VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.idPaciente
       and HCdiagnostico.IdEpisodioAtencion = VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.IdEpisodioAtencion
       and HCdiagnostico.EpisodioClinico = VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.EpisodioClinico
       )    
       left join SS_GE_Diagnostico GEdiagnostico WITH(NOLOCK)     on (GEdiagnostico.IdDiagnostico = HCdiagnostico.IdDiagnostico)                 
     WHERE     
      (@NumeroFile is null or isnull(VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.EstadoAsigMed,0)=@NumeroFile)
       and (@CodigoHC is null OR CodigoHC = @CodigoHC)    
       and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
       and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       --and (@CodigoOA is null OR VW_ATENCIONPACIENTE.CodigoOA = @CodigoOA)    
       and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
       --OBS--and (@IdPersonalSalud is null OR VW_ATENCIONPACIENTE.IdPersonalSalud = @IdPersonalSalud)    
       and (     
        (@FecIniDiscamec is null or  VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.FechaAtencion >= @FecIniDiscamec)    
        and    
        (@FecFinDiscamec is null or  VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.FechaAtencion <= DATEADD(DAY,1,@FecFinDiscamec))    
       )    
       and (@IdPaciente is null OR personaPaciente.Persona = @IdPaciente or  @IdPaciente=0)    
       and (@EpisodioClinico is null OR VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.EpisodioClinico = @EpisodioClinico or  @EpisodioClinico=0)    
	   and (VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.ObservacionProxima IS NOT NULL) 
       ---
       and (@IdOrdenAtencion is null OR VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.IdOrdenAtencion = @IdOrdenAtencion or  @IdOrdenAtencion=0)           
       and (@LineaOrdenAtencion is null OR VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.LineaOrdenAtencion = @LineaOrdenAtencion or  @LineaOrdenAtencion=0)           
       ----
		and (@Servicio is null OR SS_HC_EpisodioAtencion.TipoEpisodio = @Servicio )                  
       and (@Estado is null or     
        (case     
         when VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.Estado IS null     
         then 0 else VW_ATENCIONPACIENTE_EVOLUCION_MEDICA.Estado   
        end ) = @Estado)          
        
     ) AS LISTADO    
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR      
            RowNumber BETWEEN @Inicio  AND @NumeroFilas                          
		
 end 
 if(@ACCION = 'LISTARPAG_FIRMAMEDICO')    
 begin       
     
  SELECT @CONTADOR= COUNT(*)          
     FROM dbo.VW_ATENCIONPACIENTE WITH(NOLOCK)
       inner join SS_HC_EpisodioAtencion WITH(NOLOCK)
       on (SS_HC_EpisodioAtencion.UnidadReplicacion = VW_ATENCIONPACIENTE.UnidadReplicacion
       and    SS_HC_EpisodioAtencion.IdEpisodioAtencion = VW_ATENCIONPACIENTE.IdEpisodioAtencion
       and    SS_HC_EpisodioAtencion.EpisodioClinico = VW_ATENCIONPACIENTE.EpisodioClinico
       and    SS_HC_EpisodioAtencion.IdPaciente = VW_ATENCIONPACIENTE.IdPaciente       
       )            
       left join CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK)
       on (TipoPaciente.IdCodigo = VW_ATENCIONPACIENTE.TipoPaciente    
        and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
       left join SS_GE_TipoAtencion TipoAtencion WITH(NOLOCK)
       on (TipoAtencion.IdTipoAtencion = VW_ATENCIONPACIENTE.TipoAtencion)    
       left join PERSONAMAST personaPaciente WITH(NOLOCK)
       on (personaPaciente.Persona = VW_ATENCIONPACIENTE.idPaciente)                     
		 WHERE     
      (@NumeroFile is null or isnull(VW_ATENCIONPACIENTE.EstadoAsigMed,0)=@NumeroFile)and        
	   (@CodigoHC is null OR CodigoHC = @CodigoHC)    
       and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
       and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       --and (@CodigoOA is null OR VW_ATENCIONPACIENTE.CodigoOA = @CodigoOA)    
       and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
       --OBS--and (@IdPersonalSalud is null OR VW_ATENCIONPACIENTE.IdPersonalSalud = @IdPersonalSalud)    
       and (     
        (  VW_ATENCIONPACIENTE.FechaOrden >= @FecIniDiscamec)    
        and    
        ( VW_ATENCIONPACIENTE.FechaOrden < DATEADD(DAY,1,@FecFinDiscamec))    
       )  
       and (@IdPaciente is null OR personaPaciente.Persona = @IdPaciente or  @IdPaciente=0)    
       and (@EpisodioClinico is null OR VW_ATENCIONPACIENTE.EpisodioClinico = @EpisodioClinico or  @EpisodioClinico=0)    
       and (@EpisodioAtencion is null OR VW_ATENCIONPACIENTE.EpisodioAtencion = @EpisodioAtencion or  @EpisodioAtencion=0)           
       ---
       and (@IdOrdenAtencion is null OR VW_ATENCIONPACIENTE.IdOrdenAtencion = @IdOrdenAtencion or  @IdOrdenAtencion=0)           
       and (@LineaOrdenAtencion is null OR VW_ATENCIONPACIENTE.LineaOrdenAtencion = @LineaOrdenAtencion or  @LineaOrdenAtencion=0)                         
       -----
       and (@Servicio is null OR SS_HC_EpisodioAtencion.TipoEpisodio = @Servicio )           
       
       and (@Estado is null or     
        (case     
         when VW_ATENCIONPACIENTE.Estado IS null     
         then 0 else VW_ATENCIONPACIENTE.Estado   
        end ) = @Estado)            
    
  SELECT     
    [UnidadReplicacion]    
     ,[IdEpisodioAtencion]    
     ,[UnidadReplicacionEC]    
     ,[IdPaciente]    
     ,[EpisodioClinico]    
     ,[IdEstablecimientoSalud]    
     ,[IdUnidadServicio]    
     ,[IdPersonalSalud]         
     ,[EpisodioAtencion]    
     ,[FechaRegistro]    
     ,[FechaAtencion]    
     ,[TipoAtencion]    
     ,[IdOrdenAtencion]    
     ,[LineaOrdenAtencion]    
     ,[TipoOrdenAtencion]    
     ,[Estado]    
     ,[UsuarioCreacion]    
     ,[FechaCreacion]    
     ,NombreTrabajadorModificadorX as UsuarioModificacion
     ,[FechaModificacion]    
     ,[IdEspecialidad]    
     ,[CodigoOA]    
     ,[ProximaAtencionFlag]    
     ,[IdEspecialidadProxima]    
     ,[IdEstablecimientoSaludProxima]    
     ,[IdTipoInterConsulta]    
     ,[IdTipoReferencia]    
     ,[ObservacionProxima]    
     ,[DescansoMedico]    
     ,[DiasDescansoMedico]    
     ,[FechaInicioDescansoMedico]    
     ,[FechaFinDescansoMedico]    
     ,[FechaOrden]    
     ,[IdProcedimiento]    
     ,TipoAtencionDesc as ObservacionOrden
     ,[IdTipoOrden]    
     ,[Accion]    
     ,[Version]
     ,[FechaRegistroEpiClinico]    
     ,[FechaCierreEpiClinico]    
     ,[TipoPaciente]    
     ,[Edad]    
     ,[Raza]    
     ,[Religion]    
     ,NombreDiagnosticoX as Cargo
     ,[AreaLaboral]    
     ,[Ocupacion]    
     ,[CodigoHC]    
     ,[CodigoHCAnterior]    
     ,[CodigoHCSecundario]    
     ,[TipoAlmacenamiento]    
     ,[TipoHistoria]    
     ,[TipoSituacion]    
     ,[IdUbicacion]    
     ,[LugarProcedencia]    
     ,[RutaFoto]    
     ,[FechaIngreso]    
     ,[IndicadorNuevo]    
     ,[EstadoPaciente]    
     ,[NumeroFile]    
     ,[Servicio]    
     ,[UsuarioAlmacenamiento]    
     ,[FechaAlmacenamiento]    
     ,[Observacion]    
     ,[IndicadorAsistencia]    
     ,[CantidadAsistencia]    
     ,[UbicacionHHCC]    
     ,[IndicadorMigradoSiteds]    
     ,[NumeroCaja]    
     ,[IndicadorCodigoBarras]    
     ,[IDPACIENTE_OK]    
     ,[CodigoAsegurado]    
     ,[NumeroPoliza]    
     ,[CodigoProducto]    
     ,[CodigoPlan]    
     ,[TipoParentesco]    
     ,[CodigoBeneficio]    
     ,[Situacion]    
     ,[TomoActual]    
     ,[IndicadorHistoriaFisica]    
     ,[DescripcionHistoria]    
     ,[NumeroCertificado]    
     ,convert(int,RowNumber) as Persona
     ,[Origen]    
     ,[ApellidoPaterno]    
     ,[ApellidoMaterno]    
     ,[NombreCompleto]    
     ,[TipoDocumento]    
     ,[Documento]    
     ,[CodigoBarras]    
     ,[EsCliente]    
     ,[EsProveedor]    
     ,[EsEmpleado]    
     ,[EsOtro]    
     ,[TipoPersona]    
     ,[FechaNacimiento]    
     ,[Sexo]    
     ,[CiudadNacimiento]    
     ,[Nacionalidad]    
     ,[EstadoCivil]    
     ,[NivelInstruccion]    
     ,[Direccion]    
     ,[CodigoPostal]    
     ,[Provincia]    
     ,[Departamento]    
     ,[Telefono]    
     ,[Fax]    
     ,[DocumentoFiscal]    
     ,[DocumentoIdentidad]    
     ,[CarnetExtranjeria]    
     ,[DocumentoMilitarFA]    
     ,[TipoBrevete]    
     ,[Brevete]    
     ,[Pasaporte]    
     ,[NombreEmergencia]    
     ,[DireccionEmergencia]    
     ,[TelefonoEmergencia]    
     ,CodigoOAx+'_'+CONVERT(varchar,IdEpisodioAtencion)  as  PersonaAnt
     ,[CorreoElectronico]    
     ,[EnfermedadGraveFlag]    
     ,[IngresoFechaRegistro]    
     ,[IngresoAplicacionCodigo]    
     ,[IngresoUsuario]    
     ,[Celular]    
     ,[ParentescoEmergencia]    
     ,[CelularEmergencia]    
     ,[LugarNacimiento]    
     ,[SuspensionFonaviFlag]    
     ,[FlagRepetido]    
     ,[CodDiscamec]    
     ,[FecIniDiscamec]    
     ,[FecFinDiscamec]    
     ,[Pais]    
     ,TipoPacienteDesc as EsPaciente
     ,[EsEmpresa]    
     ,[Persona_Old]    
     ,Personax as personanew
     ,[EstadoPersona]    
       ,IDASIGNACIONMEDICO    
       ,tipoasignacion    
       ,ObservacionesAsigMed    
       ,EstadoAsigMed           
     ,EstadoEpiClinico    
     ,SecAsigMed    
     ,SecReferidaAsigMed   
  FROM (      
    SELECT VW_ATENCIONPACIENTE.*,                  
     @CONTADOR AS Contador,    
     VW_ATENCIONPACIENTE.Persona as Personax,
     VW_ATENCIONPACIENTE.CodigoOA as CodigoOAx,
       TipoPaciente.Descripcion as TipoPacienteDesc,        
       TipoAtencion.Nombre as TipoAtencionDesc,         
       GEdiagnostico.Nombre as NombreDiagnosticoX,
       (select top 1 Nombre from SG_Agente as agenteTrabajador WITH(NOLOCK) 
		where agenteTrabajador.IdEmpleado = SS_HC_EpisodioAtencion.IdPersonalSalud 
		) as NombreTrabajadorModificadorX,       
     ROW_NUMBER() OVER (ORDER BY VW_ATENCIONPACIENTE.IdEpisodioAtencion ASC ) AS RowNumber        
     FROM dbo.VW_ATENCIONPACIENTE WITH(NOLOCK)
       inner join SS_HC_EpisodioAtencion WITH(NOLOCK)
       on (SS_HC_EpisodioAtencion.UnidadReplicacion = VW_ATENCIONPACIENTE.UnidadReplicacion
       and    SS_HC_EpisodioAtencion.IdEpisodioAtencion = VW_ATENCIONPACIENTE.IdEpisodioAtencion
       and    SS_HC_EpisodioAtencion.EpisodioClinico = VW_ATENCIONPACIENTE.EpisodioClinico
       and    SS_HC_EpisodioAtencion.IdPaciente = VW_ATENCIONPACIENTE.IdPaciente       
       )            
       left join CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK)
       on (TipoPaciente.IdCodigo = VW_ATENCIONPACIENTE.TipoPaciente    
        and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
       left join SS_GE_TipoAtencion TipoAtencion WITH(NOLOCK)
       on (TipoAtencion.IdTipoAtencion = VW_ATENCIONPACIENTE.TipoAtencion)    
       left join PERSONAMAST personaPaciente WITH(NOLOCK)
       on (personaPaciente.Persona = VW_ATENCIONPACIENTE.idPaciente)    
       left join SS_HC_Diagnostico HCdiagnostico WITH(NOLOCK)
       on (HCdiagnostico.IdPaciente = VW_ATENCIONPACIENTE.idPaciente
       and HCdiagnostico.IdEpisodioAtencion = VW_ATENCIONPACIENTE.IdEpisodioAtencion
       and HCdiagnostico.EpisodioClinico = VW_ATENCIONPACIENTE.EpisodioClinico
       )    
       left join SS_GE_Diagnostico GEdiagnostico WITH(NOLOCK)
       on (GEdiagnostico.IdDiagnostico = HCdiagnostico.IdDiagnostico)   
             
              
     WHERE     
      (@NumeroFile is null or isnull(VW_ATENCIONPACIENTE.EstadoAsigMed,0)=@NumeroFile)
       and (@CodigoHC is null OR CodigoHC = @CodigoHC)    
       and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
       and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       --and (@CodigoOA is null OR VW_ATENCIONPACIENTE.CodigoOA = @CodigoOA)    
       and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
       --OBS--and (@IdPersonalSalud is null OR VW_ATENCIONPACIENTE.IdPersonalSalud = @IdPersonalSalud)    
      and (     
        (VW_ATENCIONPACIENTE.FechaOrden >= @FecIniDiscamec)    
        and    
        (VW_ATENCIONPACIENTE.FechaOrden < DATEADD(DAY,1,@FecFinDiscamec))    
       )    
       and (@IdPaciente is null OR personaPaciente.Persona = @IdPaciente or  @IdPaciente=0)    
       and (@EpisodioClinico is null OR VW_ATENCIONPACIENTE.EpisodioClinico = @EpisodioClinico or  @EpisodioClinico=0)    
       and (@EpisodioAtencion is null OR VW_ATENCIONPACIENTE.EpisodioAtencion = @EpisodioAtencion or  @EpisodioAtencion=0)    
       ---
       and (@IdOrdenAtencion is null OR VW_ATENCIONPACIENTE.IdOrdenAtencion = @IdOrdenAtencion or  @IdOrdenAtencion=0)           
       and (@LineaOrdenAtencion is null OR VW_ATENCIONPACIENTE.LineaOrdenAtencion = @LineaOrdenAtencion or  @LineaOrdenAtencion=0)           
       ----
		and (@Servicio is null OR SS_HC_EpisodioAtencion.TipoEpisodio = @Servicio )                  
       and (@Estado is null or     
        (case     
         when VW_ATENCIONPACIENTE.Estado IS null     
         then 0 else VW_ATENCIONPACIENTE.Estado   
        end ) = @Estado)          
        
     ) AS LISTADO    
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR      
            RowNumber BETWEEN @Inicio  AND @NumeroFilas                          
		
 end    
 else    
 if(@ACCION = 'LISTAR')    
 begin    

  SELECT VW_ATENCIONPACIENTE.*     
  FROM dbo.VW_ATENCIONPACIENTE WITH(NOLOCK)
       inner join SS_HC_EpisodioAtencion WITH(NOLOCK)
       on (SS_HC_EpisodioAtencion.UnidadReplicacion = VW_ATENCIONPACIENTE.UnidadReplicacion
       and    SS_HC_EpisodioAtencion.IdEpisodioAtencion = VW_ATENCIONPACIENTE.IdEpisodioAtencion
       and    SS_HC_EpisodioAtencion.EpisodioClinico = VW_ATENCIONPACIENTE.EpisodioClinico
       and    SS_HC_EpisodioAtencion.IdPaciente = VW_ATENCIONPACIENTE.IdPaciente       
       )            
       left join CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK)
       on (TipoPaciente.IdCodigo = VW_ATENCIONPACIENTE.TipoPaciente    
        and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
       left join SS_GE_TipoAtencion TipoAtencion WITH(NOLOCK)
       on (TipoAtencion.IdTipoAtencion = VW_ATENCIONPACIENTE.TipoAtencion)    
       left join PERSONAMAST personaPaciente WITH(NOLOCK)
       on (personaPaciente.Persona = VW_ATENCIONPACIENTE.idPaciente)    
       left join SS_HC_Diagnostico HCdiagnostico WITH(NOLOCK)
       on (HCdiagnostico.IdPaciente = VW_ATENCIONPACIENTE.idPaciente
       and HCdiagnostico.IdEpisodioAtencion = VW_ATENCIONPACIENTE.IdEpisodioAtencion
       and HCdiagnostico.EpisodioClinico = VW_ATENCIONPACIENTE.EpisodioClinico
       )    
       left join SS_GE_Diagnostico GEdiagnostico WITH(NOLOCK)
       on (GEdiagnostico.IdDiagnostico = HCdiagnostico.IdDiagnostico)   
             
              
     WHERE     
      (@NumeroFile is null or isnull(VW_ATENCIONPACIENTE.EstadoAsigMed,0)=@NumeroFile)
       and (@CodigoHC is null OR CodigoHC = @CodigoHC)    
       and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
       and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       --and (@CodigoOA is null OR VW_ATENCIONPACIENTE.CodigoOA = @CodigoOA)    
       and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
       --OBS--and (@IdPersonalSalud is null OR VW_ATENCIONPACIENTE.IdPersonalSalud = @IdPersonalSalud)    
       and (     
        (@FecIniDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion >= @FecIniDiscamec)    
        and    
        (@FecFinDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion <= DATEADD(DAY,1,@FecFinDiscamec))    
       )    
       and (@IdPaciente is null OR personaPaciente.Persona = @IdPaciente)    
       and (@IdOrdenAtencion is null OR VW_ATENCIONPACIENTE.IdOrdenAtencion = @IdOrdenAtencion)
	   --and (@TipoOrdenAtencion is null OR VW_ATENCIONPACIENTE.TipoOrdenAtencion = @TipoOrdenAtencion)
       ---LOGICA DE MATCH SIN LÍNEA DE ATENCIÓN
       and (@LineaOrdenAtencion is null OR 
		(VW_ATENCIONPACIENTE.LineaOrdenAtencion = @LineaOrdenAtencion and VW_ATENCIONPACIENTE.LineaOrdenAtencion is Not null)
		--or VW_ATENCIONPACIENTE.LineaOrdenAtencion is null
		--or VW_ATENCIONPACIENTE.LineaOrdenAtencion = 0
		 )
       and (@Estado is null or     
        (case     
         when VW_ATENCIONPACIENTE.Estado IS null     
         then 0 else VW_ATENCIONPACIENTE.Estado   
        end ) = @Estado)        
        -------
        and (@UnidadReplicacion is null OR VW_ATENCIONPACIENTE.UnidadReplicacion = @UnidadReplicacion)    
        and (@EpisodioClinico is null OR VW_ATENCIONPACIENTE.EpisodioClinico = @EpisodioClinico)    
        and (@IdEpisodioAtencion is null OR VW_ATENCIONPACIENTE.IdEpisodioAtencion = @IdEpisodioAtencion)    

	
 end    
 else
 if(@ACCION = 'LISTARPAGCONTINUAR')    
 begin       
     
  SELECT @CONTADOR= COUNT(*)          
     FROM SS_HC_EpisodioClinico WITH(NOLOCK)
       inner join dbo.VW_ATENCIONPACIENTE WITH(NOLOCK)
       on (SS_HC_EpisodioClinico.UnidadReplicacion = VW_ATENCIONPACIENTE.UnidadReplicacion
         and    SS_HC_EpisodioClinico.EpisodioClinico = VW_ATENCIONPACIENTE.EpisodioClinico
		 and    SS_HC_EpisodioClinico.IdPaciente = VW_ATENCIONPACIENTE.IdPaciente       

		)      
	   INNER JOIN   (
		SELECT IdPaciente,min( EpisodioAtencionCodigo)EpisodioAtencionCodigo,UnidadReplicacion,EpisodioClinico ,min( EpisodioAtencion) EpisodioAtencion  
		FROM SS_HC_EpisodioAtencionMaster WITH(NOLOCK)
		 WHERE IdPaciente = @IdPaciente and EpisodioAtencionCodigo is not null
		 GROUP BY IdPaciente, EpisodioClinico,UnidadReplicacion				
			) XXX  ON XXX.IdPaciente= SS_HC_EpisodioClinico.IdPaciente  and  SS_HC_EpisodioClinico.EpisodioClinico = XXX.EpisodioClinico 
			and  XXX.EpisodioAtencion=   VW_ATENCIONPACIENTE.EpisodioAtencion  
	   left join CM_CO_TablaMaestroDetalle TipoPaciente   WITH(NOLOCK) 
			on (TipoPaciente.IdCodigo = VW_ATENCIONPACIENTE.TipoPaciente    
			and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
       left join SS_GE_TipoAtencion TipoAtencion    WITH(NOLOCK)
			on (TipoAtencion.IdTipoAtencion = VW_ATENCIONPACIENTE.TipoAtencion)    
       left join PERSONAMAST personaPaciente    WITH(NOLOCK)
			on (personaPaciente.Persona = VW_ATENCIONPACIENTE.idPaciente)    
		where
		(@IdPaciente is null or VW_ATENCIONPACIENTE.IdPaciente = @IdPaciente or @IdPaciente=0)
		and (@UnidadReplicacion is null or VW_ATENCIONPACIENTE.UnidadReplicacion = @UnidadReplicacion)
       and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
       --OBS--and (@IdPersonalSalud is null OR VW_ATENCIONPACIENTE.IdPersonalSalud = @IdPersonalSalud)    
       and (     
        (@FecIniDiscamec is null or  VW_ATENCIONPACIENTE.FechaRegistro >= @FecIniDiscamec)    
        and    
        (@FecFinDiscamec is null or  VW_ATENCIONPACIENTE.FechaRegistro <= DATEADD(DAY,1,@FecFinDiscamec))    
       )    
       ----
       and (@Estado is null or     
        (case     
         when VW_ATENCIONPACIENTE.Estado IS null     
         then 0 else VW_ATENCIONPACIENTE.Estado   
        end )>1/* = @Estado*/)          
        -------
		

  SELECT     
    [UnidadReplicacion]    
     ,[IdEpisodioAtencion]    
     ,[UnidadReplicacionEC]    
     ,[IdPaciente]    
     ,[EpisodioClinico]    
     ,[IdEstablecimientoSalud]    
     ,[IdUnidadServicio]    
     ,[IdPersonalSalud]         
     ,[EpisodioAtencion]    
     ,FechaRegistroEpiClinicoX as FechaRegistro
     ,[FechaAtencion]    
     ,[TipoAtencion]    
     ,[IdOrdenAtencion]    
     ,[LineaOrdenAtencion]    
     ,[TipoOrdenAtencion]    
     ,[Estado]    
     ,[UsuarioCreacion]    
     ,[FechaCreacion]    
     ,NombreTrabajadorModificadorX as UsuarioModificacion
     ,[FechaModificacion]    
     ,[IdEspecialidad]    
     ,[CodigoOA]    
     ,[ProximaAtencionFlag]    
     ,[IdEspecialidadProxima]    
     ,[IdEstablecimientoSaludProxima]    
     ,[IdTipoInterConsulta]    
     ,[IdTipoReferencia]    
     ,[ObservacionProxima]    
     ,[DescansoMedico]    
     ,[DiasDescansoMedico]    
     ,[FechaInicioDescansoMedico]    
     ,[FechaFinDescansoMedico]    
     ,[FechaOrden]    
     ,CodigoEpisodioClinicoX as IdProcedimiento --AUX PARA EL Cód DE EPI CLINICO
     ,TipoAtencionDesc as ObservacionOrden
     ,[IdTipoOrden]    
     ,[Accion]    
     ,[Version]
     ,[FechaRegistroEpiClinico]    
     ,[FechaCierreEpiClinico]    
     ,[TipoPaciente]    
     ,[Edad]    
     ,[Raza]    
     ,[Religion]    
     ,Cargo
     ,[AreaLaboral]    
     ,[Ocupacion]    
     ,[CodigoHC]    
     ,[CodigoHCAnterior]    
     ,[CodigoHCSecundario]    
     ,[TipoAlmacenamiento]    
     ,[TipoHistoria]    
     ,[TipoSituacion]    
     ,[IdUbicacion]    
     ,[LugarProcedencia]    
     ,[RutaFoto]    
     ,[FechaIngreso]    
     ,[IndicadorNuevo]    
     ,[EstadoPaciente]    
     ,[NumeroFile]    
     , dbo.FUN_DIAGNOSTICOFE_EPISODIO(UnidadReplicacion,idPaciente ,EpisodioClinico)  [Servicio]    
     ,[UsuarioAlmacenamiento]    
     ,[FechaAlmacenamiento]    
     ,[Observacion]    
     ,[IndicadorAsistencia]    
     ,[CantidadAsistencia]    
     ,[UbicacionHHCC]    
     ,[IndicadorMigradoSiteds]    
     ,[NumeroCaja]    
     ,[IndicadorCodigoBarras]    
     ,[IDPACIENTE_OK]    
     ,[CodigoAsegurado]    
     ,[NumeroPoliza]    
     ,[CodigoProducto]    
     ,[CodigoPlan]    
     ,[TipoParentesco]    
     ,[CodigoBeneficio]    
     ,[Situacion]    
     ,[TomoActual]    
     ,[IndicadorHistoriaFisica]    
     ,[DescripcionHistoria]    
     ,[NumeroCertificado]    
     ,convert(int,RowNumber) as Persona
     ,[Origen]    
     ,[ApellidoPaterno]    
     ,[ApellidoMaterno]    
     ,[NombreCompleto]    
     ,[TipoDocumento]    
     ,[Documento]    
     ,[CodigoBarras]    
     ,[EsCliente]    
     ,[EsProveedor]    
     ,[EsEmpleado]    
     ,[EsOtro]    
     ,[TipoPersona]    
     ,[FechaNacimiento]    
     ,[Sexo]    
     ,[CiudadNacimiento]    
     ,[Nacionalidad]    
     ,[EstadoCivil]    
     ,[NivelInstruccion]    
     ,[Direccion]    
     ,[CodigoPostal]    
     ,[Provincia]    
     ,[Departamento]    
     ,[Telefono]    
     ,[Fax]    
     ,[DocumentoFiscal]    
     ,[DocumentoIdentidad]    
     ,[CarnetExtranjeria]    
     ,[DocumentoMilitarFA]    
     ,[TipoBrevete]    
     ,[Brevete]    
     ,[Pasaporte]    
     ,[NombreEmergencia]    
     ,[DireccionEmergencia]    
     ,[TelefonoEmergencia]    
     ,CodigoOAx+'_'+CONVERT(varchar,IdEpisodioAtencion)  as  PersonaAnt
     ,[CorreoElectronico]    
     ,[EnfermedadGraveFlag]    
     ,[IngresoFechaRegistro]    
     ,[IngresoAplicacionCodigo]    
     ,[IngresoUsuario]    
     ,[Celular]    
     ,[ParentescoEmergencia]    
     ,[CelularEmergencia]    
     ,[LugarNacimiento]    
     ,[SuspensionFonaviFlag]    
     ,[FlagRepetido]    
     ,[CodDiscamec]    
     ,[FecIniDiscamec]    
     ,[FecFinDiscamec]    
     ,[Pais]    
     ,TipoPacienteDesc as EsPaciente
     ,[EsEmpresa]    
     ,[Persona_Old]    
     ,Personax as personanew
     ,[EstadoPersona]    
       ,IDASIGNACIONMEDICO    
       ,tipoasignacion    
       ,ObservacionesAsigMed    
       ,EstadoAsigMed           
     ,EstadoEpiClinico    
     ,SecAsigMed    
     ,SecReferidaAsigMed    
  FROM (      
  SELECT VW_ATENCIONPACIENTE.*,                  
@CONTADOR AS Contador,    --   0 Contador,  
     VW_ATENCIONPACIENTE.Persona as Personax,
     VW_ATENCIONPACIENTE.CodigoOA as CodigoOAx,
       TipoPaciente.Descripcion as TipoPacienteDesc,        
       TipoAtencion.Nombre as TipoAtencionDesc,       
       SS_HC_EpisodioClinico.CodigoEpisodioClinico as CodigoEpisodioClinicoX,
       SS_HC_EpisodioClinico.FechaRegistro as FechaRegistroEpiClinicoX,
       (select top 1 Nombre from SG_Agente as agenteTrabajador WITH(NOLOCK)
		where agenteTrabajador.CodigoAgente = SS_HC_EpisodioClinico.UsuarioModificacion 
		) as NombreTrabajadorModificadorX,
     ROW_NUMBER() OVER (ORDER BY VW_ATENCIONPACIENTE.IdEpisodioAtencion ASC ) AS RowNumber        
     FROM SS_HC_EpisodioClinico WITH(NOLOCK)
       inner join dbo.VW_ATENCIONPACIENTE   WITH(NOLOCK)  
       on (SS_HC_EpisodioClinico.UnidadReplicacion = VW_ATENCIONPACIENTE.UnidadReplicacion
       and    SS_HC_EpisodioClinico.EpisodioClinico = VW_ATENCIONPACIENTE.EpisodioClinico
       and    SS_HC_EpisodioClinico.IdPaciente = VW_ATENCIONPACIENTE.IdPaciente       

       )      
	   INNER JOIN   (
		SELECT IdPaciente,min( EpisodioAtencionCodigo)EpisodioAtencionCodigo,UnidadReplicacion,EpisodioClinico ,min( EpisodioAtencion) EpisodioAtencion  
		FROM SS_HC_EpisodioAtencionMaster WITH(NOLOCK)
		 WHERE IdPaciente = @IdPaciente and EpisodioAtencionCodigo is not null
		 GROUP BY IdPaciente, EpisodioClinico,UnidadReplicacion				
			) XXX  ON XXX.IdPaciente= SS_HC_EpisodioClinico.IdPaciente  and  SS_HC_EpisodioClinico.EpisodioClinico = XXX.EpisodioClinico 
			and  XXX.EpisodioAtencion=   VW_ATENCIONPACIENTE.EpisodioAtencion  
       left join CM_CO_TablaMaestroDetalle TipoPaciente    WITH(NOLOCK)
			on (TipoPaciente.IdCodigo = VW_ATENCIONPACIENTE.TipoPaciente    
			and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
       left join SS_GE_TipoAtencion TipoAtencion    WITH(NOLOCK)
			on (TipoAtencion.IdTipoAtencion = VW_ATENCIONPACIENTE.TipoAtencion)    
       left join PERSONAMAST personaPaciente    WITH(NOLOCK)
			on (personaPaciente.Persona = VW_ATENCIONPACIENTE.idPaciente)    

		where
		( VW_ATENCIONPACIENTE.IdPaciente =   @IdPaciente)
		and ( VW_ATENCIONPACIENTE.UnidadReplicacion = @UnidadReplicacion)
		and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
		--	--OBS--and (@IdPersonalSalud is null OR VW_ATENCIONPACIENTE.IdPersonalSalud = @IdPersonalSalud)  
	    and  SS_HC_EpisodioClinico.CodigoEpisodioClinico is not null  
		and (     
			(@FecIniDiscamec is null or  VW_ATENCIONPACIENTE.FechaRegistro >= @FecIniDiscamec)    
			and    
			(@FecFinDiscamec is null or  VW_ATENCIONPACIENTE.FechaRegistro <= DATEADD(DAY,1,@FecFinDiscamec))					   
            )    
       ) AS LISTADO    
     WHERE 
	 ((@Inicio  Is null AND @NumeroFilas Is null) OR      
            RowNumber BETWEEN @Inicio  AND @NumeroFilas   )                       
		

 end     
 else    
 if(@ACCION = 'LISTARPAGSELECPACIENTE')    
 begin                
             
         if(@Servicio ='CC' or @Servicio is null )  ---AUXILIAR    
         begin    
    SELECT @CONTADOR= COUNT(*)          
       FROM dbo.VW_ATENCIONPACIENTE WITH(NOLOCK)
       where     
       ( (IdEpisodioAtencion is null and @Servicio ='CC')    
       or (@Servicio is null)    
       )    
       and (@CodigoHC is null OR CodigoHC = @CodigoHC)    
       and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
       and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE.CodigoOA) like '%'+upper(@CodigoOA)+'%')           
       --OBS--and (@IdPersonalSalud is null OR VW_ATENCIONPACIENTE.IdPersonalSalud = @IdPersonalSalud)    
       and (     
        (@FecIniDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion >= @FecIniDiscamec)    
        and    
        (@FecFinDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion <= @FecFinDiscamec)    
       )     
       and(VW_ATENCIONPACIENTE.EsEmpleado is null or VW_ATENCIONPACIENTE.EsEmpleado <> 'S')     
       and(VW_ATENCIONPACIENTE.TipoPersona is null or VW_ATENCIONPACIENTE.TipoPersona <> 'J')     
       and (VW_ATENCIONPACIENTE.Persona in (select IDPACIENTE from SS_GE_Paciente WITH(NOLOCK)))    
        
    SELECT     
      isnull(UnidadReplicacion,'UN'+CONVERT(varchar,RowNumber)) as UnidadReplicacion,    
      isnull(IdEpisodioAtencion,0) as IdEpisodioAtencion,    
      isnull(UnidadReplicacionEC,'UN') as UnidadReplicacionEC,    
      isnull(IdPaciente,0) as IdPaciente,    
      isnull(EpisodioClinico,0) as EpisodioClinico,    
          
       [IdEstablecimientoSalud],[IdUnidadServicio],[IdPersonalSalud],[EpisodioAtencion]    
       ,[FechaRegistro],[FechaAtencion],[TipoAtencion],[IdOrdenAtencion],[LineaOrdenAtencion]    
       ,[TipoOrdenAtencion],[Estado],[UsuarioCreacion],[FechaCreacion],[UsuarioModificacion]    
       ,[FechaModificacion],[IdEspecialidad],[CodigoOA],[ProximaAtencionFlag],[IdEspecialidadProxima]    
       ,[IdEstablecimientoSaludProxima],[IdTipoInterConsulta],[IdTipoReferencia],[ObservacionProxima],[DescansoMedico]    
       ,[DiasDescansoMedico],[FechaInicioDescansoMedico],[FechaFinDescansoMedico],[FechaOrden],[IdProcedimiento]    
       ,[ObservacionOrden],[IdTipoOrden],[Accion],[Version],[FechaRegistroEpiClinico]    
       ,[FechaCierreEpiClinico],[TipoPaciente],[Edad],[Raza],[Religion]    
       ,[Cargo],[AreaLaboral],[Ocupacion],[CodigoHC],[CodigoHCAnterior]    
       ,[CodigoHCSecundario],[TipoAlmacenamiento],[TipoHistoria],[TipoSituacion],[IdUbicacion]    
       ,[LugarProcedencia],[RutaFoto],[FechaIngreso],[IndicadorNuevo],[EstadoPaciente]    
       ,[NumeroFile],    
       (case when isnull(IdEpisodioAtencion,0)>0 then 'CA' else 'CC' end) as Servicio    
       ,[UsuarioAlmacenamiento],[FechaAlmacenamiento],[Observacion]    
       ,[IndicadorAsistencia],[CantidadAsistencia],[UbicacionHHCC],[IndicadorMigradoSiteds],[NumeroCaja]    
       ,[IndicadorCodigoBarras]    
       ,[IDPACIENTE_OK]    
       ,[CodigoAsegurado]    
       ,[NumeroPoliza]    
       ,[CodigoProducto]    
       ,[CodigoPlan]    
       ,[TipoParentesco]    
       ,[CodigoBeneficio]    
       ,[Situacion]    
       ,[TomoActual]    
       ,[IndicadorHistoriaFisica]    
       ,[DescripcionHistoria]    
       ,[NumeroCertificado]    
       ,isnull(Persona,0) as Persona    
       ,isnull(Origen,'UN') as Origen    
     ,[ApellidoPaterno]    
       ,[ApellidoMaterno]    
       ,[NombreCompleto]    
       ,[TipoDocumento]    
       ,[Documento]    
       ,[CodigoBarras]    
       ,[EsCliente]    
       ,[EsProveedor]    
       ,[EsEmpleado]    
       ,[EsOtro]    
       ,[TipoPersona]    
       ,[FechaNacimiento]    
       ,[Sexo]    
       ,[CiudadNacimiento]    
       ,[Nacionalidad]    
       ,[EstadoCivil]    
       ,[NivelInstruccion]    
       ,[Direccion]    
       ,[CodigoPostal]    
       ,[Provincia]    
       ,[Departamento]    
       ,[Telefono]    
       ,[Fax]    
       ,[DocumentoFiscal]    
       ,[DocumentoIdentidad]    
       ,[CarnetExtranjeria]    
       ,[DocumentoMilitarFA]    
       ,[TipoBrevete]    
       ,[Brevete]    
       ,[Pasaporte]    
       ,[NombreEmergencia]    
       ,[DireccionEmergencia]    
       ,[TelefonoEmergencia]    
       ,PersonaAntX as PersonaAnt    
       ,[CorreoElectronico]    
       ,[EnfermedadGraveFlag]    
       ,[IngresoFechaRegistro]    
       ,[IngresoAplicacionCodigo]    
       ,[IngresoUsuario]    
       ,[Celular]    
       ,[ParentescoEmergencia]    
       ,[CelularEmergencia]    
       ,[LugarNacimiento]    
       ,[SuspensionFonaviFlag]    
       ,[FlagRepetido]    
       ,[CodDiscamec]    
       ,[FecIniDiscamec]    
       ,[FecFinDiscamec]    
       ,[Pais]    
       ,[EsPaciente]    
       ,[EsEmpresa]    
       ,[Persona_Old]    
       ,[personanew]    
       ,[EstadoPersona]    
       ,IDASIGNACIONMEDICO    
       ,tipoasignacion    
       ,ObservacionesAsigMed    
       ,EstadoAsigMed           
     ,EstadoEpiClinico    
     ,SecAsigMed    
     ,SecReferidaAsigMed          
    FROM (      
          
          
          
      SELECT VW_ATENCIONPACIENTE.*,    
       @CONTADOR AS Contador,    
       LEFT(convert(varchar,persona)+'0000000000',8) +    
       LEFT(convert(varchar,isnull(IdEpisodioAtencion,''))+'00000',4)     
       as PersonaAntX,    
       ROW_NUMBER() OVER (ORDER BY VW_ATENCIONPACIENTE.IdEpisodioAtencion ASC ) AS RowNumber        
       FROM dbo.VW_ATENCIONPACIENTE WITH(NOLOCK)
       where     
       ( (IdEpisodioAtencion is null and @Servicio ='CC')    
       or (@Servicio is null)    
       )    
       and (@CodigoHC is null OR CodigoHC = @CodigoHC)    
       and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
       and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       and (@CodigoOA is null OR VW_ATENCIONPACIENTE.CodigoOA = @CodigoOA)    
       --OBS--and (@IdPersonalSalud is null OR VW_ATENCIONPACIENTE.IdPersonalSalud = @IdPersonalSalud)    
       and (     
        (@FecIniDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion >= @FecIniDiscamec)    
        and    
        (@FecFinDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion <= @FecFinDiscamec)    
       )     
       and(VW_ATENCIONPACIENTE.EsEmpleado is null or VW_ATENCIONPACIENTE.EsEmpleado <> 'S')     
       and(VW_ATENCIONPACIENTE.TipoPersona is null or VW_ATENCIONPACIENTE.TipoPersona <> 'J')     
       and (VW_ATENCIONPACIENTE.Persona in (select IDPACIENTE from SS_GE_Paciente))    
                 
       ) AS LISTADO    
       WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR      
           RowNumber BETWEEN @Inicio  AND @NumeroFilas     
                         
         end    
         else    
         if(@Servicio ='CA')  ---AUXILIAR    
         begin    
    SELECT @CONTADOR= COUNT(*)          
       FROM dbo.VW_ATENCIONPACIENTE WITH(NOLOCK)
       where 1=1    
       and (@CodigoHC is null OR CodigoHC = @CodigoHC)    
       and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
       and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       and (@CodigoOA is null OR VW_ATENCIONPACIENTE.CodigoOA = @CodigoOA)    
       --OBS--and (@IdPersonalSalud is null OR VW_ATENCIONPACIENTE.IdPersonalSalud = @IdPersonalSalud)    
  and (     
        (@FecIniDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion >= @FecIniDiscamec)    
        and    
        (@FecFinDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion <= @FecFinDiscamec)    
       )    
       and(VW_ATENCIONPACIENTE.EsEmpleado is null or VW_ATENCIONPACIENTE.EsEmpleado <> 'S')     
       and(VW_ATENCIONPACIENTE.TipoPersona is null or VW_ATENCIONPACIENTE.TipoPersona <> 'J')     
       and (VW_ATENCIONPACIENTE.Persona in (select IDPACIENTE from SS_GE_Paciente))    
        
    SELECT     
      isnull(UnidadReplicacion,'UN'+CONVERT(varchar,RowNumber)) as UnidadReplicacion,    
      isnull(IdEpisodioAtencion,0) as IdEpisodioAtencion,    
      isnull(UnidadReplicacionEC,'UN') as UnidadReplicacionEC,    
      isnull(IdPaciente,0) as IdPaciente,    
      isnull(EpisodioClinico,0) as EpisodioClinico,    
          
       [IdEstablecimientoSalud],[IdUnidadServicio],[IdPersonalSalud],[EpisodioAtencion]    
       ,[FechaRegistro],[FechaAtencion],[TipoAtencion],[IdOrdenAtencion],[LineaOrdenAtencion]    
       ,[TipoOrdenAtencion],[Estado],[UsuarioCreacion],[FechaCreacion],[UsuarioModificacion]    
       ,[FechaModificacion],[IdEspecialidad],[CodigoOA],[ProximaAtencionFlag],[IdEspecialidadProxima]    
       ,[IdEstablecimientoSaludProxima],[IdTipoInterConsulta],[IdTipoReferencia],[ObservacionProxima],[DescansoMedico]    
       ,[DiasDescansoMedico],[FechaInicioDescansoMedico],[FechaFinDescansoMedico],[FechaOrden],[IdProcedimiento]    
       ,[ObservacionOrden],[IdTipoOrden],[Accion],[Version],[FechaRegistroEpiClinico]    
       ,[FechaCierreEpiClinico],[TipoPaciente],[Edad],[Raza],[Religion]    
       ,[Cargo],[AreaLaboral],[Ocupacion],[CodigoHC],[CodigoHCAnterior]    
       ,[CodigoHCSecundario],[TipoAlmacenamiento],[TipoHistoria],[TipoSituacion],[IdUbicacion]    
       ,[LugarProcedencia],[RutaFoto],[FechaIngreso],[IndicadorNuevo],[EstadoPaciente]    
       ,[NumeroFile],    
       (case when isnull(IdEpisodioAtencion,0)>0 then 'CA' else 'CC' end) as Servicio           
       ,[UsuarioAlmacenamiento],[FechaAlmacenamiento],[Observacion]    
       ,[IndicadorAsistencia],[CantidadAsistencia],[UbicacionHHCC],[IndicadorMigradoSiteds],[NumeroCaja]    
       ,[IndicadorCodigoBarras]    
       ,[IDPACIENTE_OK]    
       ,[CodigoAsegurado]    
       ,[NumeroPoliza]    
       ,[CodigoProducto]    
       ,[CodigoPlan]    
       ,[TipoParentesco]    
       ,[CodigoBeneficio]    
       ,[Situacion]    
       ,[TomoActual]    
       ,[IndicadorHistoriaFisica]    
       ,[DescripcionHistoria]    
       ,[NumeroCertificado]    
       ,isnull(Persona,0) as Persona    
       ,isnull(Origen,'UN') as Origen    
       ,[ApellidoPaterno]    
       ,[ApellidoMaterno]    
       ,[NombreCompleto]    
       ,[TipoDocumento]    
       ,[Documento]    
       ,[CodigoBarras]    
       ,[EsCliente]    
       ,[EsProveedor]    
       ,[EsEmpleado]    
       ,[EsOtro]    
       ,[TipoPersona]    
       ,[FechaNacimiento]    
       ,[Sexo]    
       ,[CiudadNacimiento]    
       ,[Nacionalidad]    
       ,[EstadoCivil]    
       ,[NivelInstruccion]    
       ,[Direccion]    
       ,[CodigoPostal]    
       ,[Provincia]    
       ,[Departamento]    
       ,[Telefono]    
       ,[Fax]    
       ,[DocumentoFiscal]    
       ,[DocumentoIdentidad]    
       ,[CarnetExtranjeria]    
       ,[DocumentoMilitarFA]    
       ,[TipoBrevete]    
       ,[Brevete]    
       ,[Pasaporte]    
       ,[NombreEmergencia]    
       ,[DireccionEmergencia]    
       ,[TelefonoEmergencia]    
       ,PersonaAntX as PersonaAnt    
       ,[CorreoElectronico]    
       ,[EnfermedadGraveFlag]    
       ,[IngresoFechaRegistro]    
       ,[IngresoAplicacionCodigo]    
       ,[IngresoUsuario]    
       ,[Celular]    
       ,[ParentescoEmergencia]    
       ,[CelularEmergencia]    
       ,[LugarNacimiento]    
       ,[SuspensionFonaviFlag]    
       ,[FlagRepetido]    
       ,[CodDiscamec]    
       ,[FecIniDiscamec]    
       ,[FecFinDiscamec]    
      ,[Pais]    
       ,[EsPaciente]    
       ,[EsEmpresa]    
       ,[Persona_Old]    
       ,[personanew]    
       ,[EstadoPersona]    
       ,IDASIGNACIONMEDICO    
       ,tipoasignacion    
       ,ObservacionesAsigMed    
       ,EstadoAsigMed           
     ,EstadoEpiClinico    
     ,SecAsigMed    
     ,SecReferidaAsigMed           
    FROM (      
      SELECT VW_ATENCIONPACIENTE.*,                  
       LEFT(convert(varchar,persona)+'0000000000',8) +    
       LEFT(convert(varchar,isnull(VW_ATENCIONPACIENTE.IdEpisodioAtencion,''))+'00000',4)     
       as PersonaAntX,    
       @CONTADOR AS Contador,    
       ROW_NUMBER() OVER (ORDER BY VW_ATENCIONPACIENTE.IdEpisodioAtencion ASC ) AS RowNumber        
       FROM dbo.VW_ATENCIONPACIENTE WITH(NOLOCK)
       inner join SS_HC_EpisodioAtencion EpiAten WITH(NOLOCK) on     
       (VW_ATENCIONPACIENTE.UnidadReplicacion=EpiAten.UnidadReplicacion     
       and VW_ATENCIONPACIENTE.IdEpisodioAtencion=EpiAten.IdEpisodioAtencion --OBS: EpisodioAtencion??    
       and VW_ATENCIONPACIENTE.UnidadReplicacionEC=EpiAten.UnidadReplicacionEC     
       and VW_ATENCIONPACIENTE.IdPaciente=EpiAten.IdPaciente     
       and VW_ATENCIONPACIENTE.EpisodioClinico=EpiAten.EpisodioClinico     
       )                  
       where 1=1 --and unidadReplicacion is not null    
       and (@CodigoHC is null OR CodigoHC = @CodigoHC)    
       and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
       and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       and (@CodigoOA is null OR VW_ATENCIONPACIENTE.CodigoOA = @CodigoOA)    
       --OBS--and (@IdPersonalSalud is null OR VW_ATENCIONPACIENTE.IdPersonalSalud = @IdPersonalSalud)    
       and (     
        (@FecIniDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion >= @FecIniDiscamec)    
        and    
        (@FecFinDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion <= @FecFinDiscamec)    
       )    
       and(VW_ATENCIONPACIENTE.EsEmpleado is null or VW_ATENCIONPACIENTE.EsEmpleado <> 'S')     
       and(VW_ATENCIONPACIENTE.TipoPersona is null or VW_ATENCIONPACIENTE.TipoPersona <> 'J')     
       and (VW_ATENCIONPACIENTE.Persona in (select IDPACIENTE from SS_GE_Paciente))    
                  
       --and persona > 0    
       ) AS LISTADO    
       WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR      
           RowNumber BETWEEN @Inicio  AND @NumeroFilas              
   --SELECT tipoPaciente, * FROM VW_ATENCIONPACIENTE     
         end             
         
end     
else      
if(@ACCION = 'LISTARPAGSELECPACIENTEOA')    
begin    
         if(@Servicio is null or @Servicio ='CA')  ---AUXILIAR    
         begin    
    SELECT @CONTADOR= COUNT(*)          
       FROM     
       SS_AD_OrdenAtencion WITH(NOLOCK)
	   left join dbo.VW_ATENCIONPACIENTE WITH(NOLOCK)    
       on (    
       VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA    
       and    
       VW_ATENCIONPACIENTE.Persona = SS_AD_OrdenAtencion.idPaciente    
       --and SS_AD_OrdenAtencion.CodigoOA not in (select CodigoOA from VW_ATENCIONPACIENTE)    
       )     
       left join CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK)   
       on (TipoPaciente.IdCodigo = SS_AD_OrdenAtencion.TipoPaciente    
        and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
       left join SS_GE_TipoAtencion TipoAtencion WITH(NOLOCK)
       on (TipoAtencion.IdTipoAtencion = SS_AD_OrdenAtencion.TipoAtencion)    
       left join PERSONAMAST personaPaciente WITH(NOLOCK)
       on (personaPaciente.Persona = SS_AD_OrdenAtencion.idPaciente)    
                             
       where 1=1 --and unidadReplicacion is not null    
       and (@CodigoHC is null OR CodigoHC = @CodigoHC)    
       and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
       and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       --and (@CodigoOA is null OR VW_ATENCIONPACIENTE.CodigoOA = @CodigoOA)    
       and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(SS_AD_OrdenAtencion.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
       --OBS--and (@IdPersonalSalud is null OR VW_ATENCIONPACIENTE.IdPersonalSalud = @IdPersonalSalud)    
       and (@IdPaciente is null OR personaPaciente.Persona = @IdPaciente)    
       and (     
        (@FecIniDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion >= @FecIniDiscamec)    
        and    
        (@FecFinDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion <= DATEADD(DAY,1,@FecFinDiscamec) )    
            
       )    
       and (@Estado is null or     
        (case     
         when VW_ATENCIONPACIENTE.Estado IS null     
         then 0 else     
         (case     
          when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA    
          then VW_ATENCIONPACIENTE.Estado else 0 end    
         )    
        end ) = @Estado)    
          
    SELECT     
      isnull(UnidadReplicacionX,'UN'+CONVERT(varchar,RowNumber)) as UnidadReplicacion,    
      isnull(EpiAtencion,0) as IdEpisodioAtencion,    
      isnull(UnidadReplicacionEC,'UN') as UnidadReplicacionEC,    
      isnull(IdPacienteX,0) as IdPaciente, --OBS    
      isnull(EpiClinico,0) as EpisodioClinico,    
          
       IdEstablecimientoSaludX as IdEstablecimientoSalud,    
       [IdUnidadServicio],    
       IdPersonalSaludX as IdPersonalSalud,               
       EpisodioAtencionX as EpisodioAtencion,    
       FechaRegistroX as FechaRegistro,    
       FechaAtencionX as FechaAtencion,    
       TipoAtencionX as TipoAtencion,    
       IdOrdenAtencionX as IdOrdenAtencion,    
       LineaOrdenAtencionX as LineaOrdenAtencion,    
       TipoOrdenAtencionX as TipoOrdenAtencion,    
        EstadoX as Estado,    
       [UsuarioCreacion],[FechaCreacion],[UsuarioModificacion]    
       ,[FechaModificacion],[IdEspecialidad],    
       CodigoOASpring as CodigoOA,    
       [ProximaAtencionFlag],[IdEspecialidadProxima]    
       ,[IdEstablecimientoSaludProxima],[IdTipoInterConsulta],[IdTipoReferencia]
       ,[ObservacionProxima]
       
       ,[DescansoMedico]    
       ,[DiasDescansoMedico],[FechaInicioDescansoMedico],[FechaFinDescansoMedico],[FechaOrden],[IdProcedimiento]    
       ,[ObservacionOrden],[IdTipoOrden],    
       [Accion],    
       TipoAtencionDesc as  Version,    
       [FechaRegistroEpiClinico]    
       ,[FechaCierreEpiClinico],    
       TipoPacienteX as TipoPaciente,    
       [Edad],[Raza],[Religion]    
       ,NombreDiagnosticoX as Cargo,
       [AreaLaboral],[Ocupacion],[CodigoHC],[CodigoHCAnterior]    
       ,[CodigoHCSecundario],[TipoAlmacenamiento],[TipoHistoria],[TipoSituacion],[IdUbicacion]    
       ,[LugarProcedencia],[RutaFoto],[FechaIngreso],[IndicadorNuevo],[EstadoPaciente]    
       ,[NumeroFile],    
       (case when isnull(IdEpisodioAtencion,0)>0 then 'CA' else 'CC' end) as Servicio           
       ,[UsuarioAlmacenamiento],[FechaAlmacenamiento],[Observacion]    
       ,[IndicadorAsistencia],[CantidadAsistencia],[UbicacionHHCC],[IndicadorMigradoSiteds],[NumeroCaja]    
       ,[IndicadorCodigoBarras]    
       ,[IDPACIENTE_OK]    
       ,[CodigoAsegurado]    
       ,[NumeroPoliza]    
       ,[CodigoProducto]    
       ,[CodigoPlan]    
       ,[TipoParentesco]    
       ,[CodigoBeneficio]    
       ,[Situacion]    
       ,[TomoActual]    
       ,[IndicadorHistoriaFisica]    
       ,[DescripcionHistoria]    
       ,[NumeroCertificado]    
       ,convert(int ,RowNumber) as Persona    
       --,isnull(Persona,0)as Persona    
       ,isnull(Origen,'UN') as Origen    
     ,ApellidoPaternoX as ApellidoPaterno    
     ,ApellidoMaternoX as ApellidoMaterno    
     ,NombreCompletoX as NombreCompleto    
     ,TipoDocumentoX as TipoDocumento    
     ,DocumentoX as Documento    
       ,[CodigoBarras]    
       ,[EsCliente]    
       ,[EsProveedor]    
       ,[EsEmpleado]    
       ,[EsOtro]    
       ,[TipoPersona]    
       ,[FechaNacimiento]    
      ,SexoX as Sexo    
       ,[CiudadNacimiento]    
       ,[Nacionalidad]    
       ,[EstadoCivil]    
       ,[NivelInstruccion]    
       ,[Direccion]    
       ,[CodigoPostal]    
       ,[Provincia]    
       ,[Departamento]    
       ,[Telefono]    
       ,[Fax]    
       ,[DocumentoFiscal]    
       ,[DocumentoIdentidad]    
       ,[CarnetExtranjeria]    
       ,[DocumentoMilitarFA]    
       ,[TipoBrevete]    
       ,[Brevete]    
       ,[Pasaporte]    
       ,[NombreEmergencia]    
       ,[DireccionEmergencia]    
       ,[TelefonoEmergencia]    
       ,PersonaAntX as PersonaAnt    
       ,[CorreoElectronico]    
       ,[EnfermedadGraveFlag]    
       ,[IngresoFechaRegistro]    
       ,[IngresoAplicacionCodigo]    
       ,[IngresoUsuario]    
       ,[Celular]    
       ,[ParentescoEmergencia]    
       ,[CelularEmergencia]    
       ,[LugarNacimiento]    
       ,[SuspensionFonaviFlag]    
       ,[FlagRepetido]    
       ,[CodDiscamec]    
       ,HoraIni  as FecIniDiscamec     
       ,HoraFin  as FecFinDiscamec    
       ,[Pais]    
       ,TipoPacienteDesc as EsPaciente    
       ,[EsEmpresa]    
       ,[Persona_Old]    
       ,[personanew]    
       ,[EstadoPersona]    
       ,IDASIGNACIONMEDICO    
       ,tipoasignacion    
       ,ObservacionesAsigMed    
       ,EstadoAsigMed           
     ,EstadoEpiClinico    
     ,SecAsigMed    
     ,SecReferidaAsigMed    
         
    FROM (      
      SELECT VW_ATENCIONPACIENTE.*,     
       SS_AD_OrdenAtencion.codigoOA as CodigoOASpring,    
       SS_AD_OrdenAtencion.codigoOA as PersonaAntX,    
       ----    
       SS_AD_OrdenAtencion.FechaInicio  as HoraIni ,    
       SS_AD_OrdenAtencion.FechaFinal  as HoraFin,    
       (case     
        when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA    
        then VW_ATENCIONPACIENTE.EpisodioClinico else 0 end    
       ) AS EpiClinico,    
       (case     
        when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA    
        then VW_ATENCIONPACIENTE.IdEpisodioAtencion else 0 end    
       ) AS EpiAtencion,     
       ------------------------------    
       (case     
        when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA    
        then VW_ATENCIONPACIENTE.UnidadReplicacion else null end    
       ) AS UnidadReplicacionX,           
       (case     
        when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA    
        then VW_ATENCIONPACIENTE.IdEstablecimientoSalud else 0 end    
       ) AS IdEstablecimientoSaludX,           
       (case     
        when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA    
        then VW_ATENCIONPACIENTE.IdPersonalSalud else 0 end    
       ) AS IdPersonalSaludX,     
     
       (case     
        when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA    
        then VW_ATENCIONPACIENTE.EpisodioAtencion else 0 end    
       ) AS EpisodioAtencionX,     
       (case     
        when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA    
        then VW_ATENCIONPACIENTE.FechaRegistro else null end    
       ) AS FechaRegistroX,     
       (case     
        when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA    
        then VW_ATENCIONPACIENTE.FechaAtencion else null end    
       ) AS FechaAtencionX,    
       ( --case when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA then     
        SS_AD_OrdenAtencion.TipoAtencion     
        --else 0 end    
       ) AS TipoAtencionX,    
       (case     
        when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA    
        then VW_ATENCIONPACIENTE.IdOrdenAtencion else 0 end    
       ) AS IdOrdenAtencionX,           
       (case     
        when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA    
        then VW_ATENCIONPACIENTE.LineaOrdenAtencion else 0 end    
       ) AS LineaOrdenAtencionX,            
       (case     
        when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA    
        then VW_ATENCIONPACIENTE.TipoOrdenAtencion else 0 end    
       ) AS TipoOrdenAtencionX,    
       (--case when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA then     
        SS_AD_OrdenAtencion.TipoPaciente     
        --else 0 end    
       ) AS TipoPacienteX,      
       TipoPaciente.Descripcion as TipoPacienteDesc,        
       TipoAtencion.Nombre as TipoAtencionDesc,    
       ---------------------------    
       personaPaciente.ApellidoPaterno as ApellidoPaternoX,    
       personaPaciente.ApellidoMaterno as ApellidoMaternoX,           
       personaPaciente.NombreCompleto as NombreCompletoX,    
       personaPaciente.TipoDocumento as TipoDocumentoX,    
       personaPaciente.Documento as DocumentoX,    
       personaPaciente.Sexo as SexoX,    
       personaPaciente.Persona as IdPacienteX,    
       -----------------------------    
       (case     
        when VW_ATENCIONPACIENTE.Estado IS null     
        then 0 else     
        (case     
         when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA    
         then VW_ATENCIONPACIENTE.Estado else 0 end    
        )    
       end ) AS EstadoX,   
       GEdiagnostico.Nombre AS NombreDiagnosticoX,      
       @CONTADOR AS Contador,    
       ROW_NUMBER() OVER (ORDER BY VW_ATENCIONPACIENTE.IdEpisodioAtencion ASC ) AS RowNumber        
       FROM     
       SS_AD_OrdenAtencion WITH(NOLOCK)
	   left join dbo.VW_ATENCIONPACIENTE WITH(NOLOCK)
       on (    
       VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA    
       and    
       VW_ATENCIONPACIENTE.Persona = SS_AD_OrdenAtencion.idPaciente    
       )     
       left join CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK)    
       on (TipoPaciente.IdCodigo = SS_AD_OrdenAtencion.TipoPaciente    
        and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
       left join SS_GE_TipoAtencion TipoAtencion WITH(NOLOCK)
       on (TipoAtencion.IdTipoAtencion = SS_AD_OrdenAtencion.TipoAtencion)    
       left join PERSONAMAST personaPaciente  WITH(NOLOCK)
       on (personaPaciente.Persona = SS_AD_OrdenAtencion.idPaciente)    
       left join SS_HC_Diagnostico HCdiagnostico  WITH(NOLOCK)
       on (HCdiagnostico.IdPaciente = SS_AD_OrdenAtencion.idPaciente
       and HCdiagnostico.IdEpisodioAtencion = VW_ATENCIONPACIENTE.IdEpisodioAtencion
       and HCdiagnostico.EpisodioClinico = VW_ATENCIONPACIENTE.EpisodioClinico
       )    
       left join SS_GE_Diagnostico GEdiagnostico WITH(NOLOCK)
       on (GEdiagnostico.IdDiagnostico = HCdiagnostico.IdDiagnostico)   
             
            
                
       where 1=1 --and unidadReplicacion is not null    
       and (@CodigoHC is null OR CodigoHC = @CodigoHC)    
       and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
       and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')    
       and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(SS_AD_OrdenAtencion.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
       and (     
        (@FecIniDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion >= @FecIniDiscamec)    
        and    
        (@FecFinDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion <= DATEADD(DAY,1,@FecFinDiscamec))    
       )    
       and (@IdPaciente is null OR personaPaciente.Persona = @IdPaciente)    
       and (@Estado is null or     
        (case     
         when VW_ATENCIONPACIENTE.Estado IS null     
         then 0 else     
         (case     
          when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA    
          then VW_ATENCIONPACIENTE.Estado else 0 end    
         )    
        end ) = @Estado)    
       
       ) AS LISTADO    
       WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR      
           RowNumber BETWEEN @Inicio  AND @NumeroFilas              
  
         end      
end    
else      
if(@ACCION = 'LISTARPAGNUEVO')    
begin    
         if(@Servicio is null or @Servicio ='CA')    
         begin    
				SELECT @CONTAR= COUNT(*)          
				FROM (
				SELECT DISTINCT 
			VW_ATENCIONPACIENTE.UnidadReplicacion,VW_ATENCIONPACIENTE.IdEpisodioAtencion,
			VW_ATENCIONPACIENTE.UnidadReplicacionEC,VW_ATENCIONPACIENTE.IdPaciente,
			VW_ATENCIONPACIENTE.EpisodioClinico,VW_ATENCIONPACIENTE.IdEstablecimientoSalud,
			VW_ATENCIONPACIENTE.IdUnidadServicio,VW_ATENCIONPACIENTE.IdPersonalSalud,
			VW_ATENCIONPACIENTE.EpisodioAtencion,
			VW_ATENCIONPACIENTE.FechaRegistro,VW_ATENCIONPACIENTE.FechaAtencion,
			VW_ATENCIONPACIENTE.TipoAtencion,VW_ATENCIONPACIENTE.IdOrdenAtencion,
			VW_ATENCIONPACIENTE.LineaOrdenAtencion,VW_ATENCIONPACIENTE.TipoOrdenAtencion,
			VW_ATENCIONPACIENTE.UsuarioCreacion,VW_ATENCIONPACIENTE.FechaCreacion,
			VW_ATENCIONPACIENTE.UsuarioModificacion,VW_ATENCIONPACIENTE.FechaModificacion,
			VW_ATENCIONPACIENTE.IdEspecialidad,VW_ATENCIONPACIENTE.CodigoOA,
			VW_ATENCIONPACIENTE.ProximaAtencionFlag,VW_ATENCIONPACIENTE.IdEspecialidadProxima,
			VW_ATENCIONPACIENTE.IdEstablecimientoSaludProxima,VW_ATENCIONPACIENTE.IdTipoInterConsulta,
			VW_ATENCIONPACIENTE.IdTipoReferencia,'' ObservacionProxima,
			VW_ATENCIONPACIENTE.DescansoMedico,VW_ATENCIONPACIENTE.DiasDescansoMedico,
			VW_ATENCIONPACIENTE.FechaInicioDescansoMedico,VW_ATENCIONPACIENTE.FechaFinDescansoMedico,
			VW_ATENCIONPACIENTE.FechaOrden,VW_ATENCIONPACIENTE.IdProcedimiento,
			NULL AS ObservacionOrden,VW_ATENCIONPACIENTE.IdTipoOrden,
			VW_ATENCIONPACIENTE.Accion,VW_ATENCIONPACIENTE.Version,
			VW_ATENCIONPACIENTE.FechaRegistroEpiClinico,VW_ATENCIONPACIENTE.FechaCierreEpiClinico,
			VW_ATENCIONPACIENTE.TipoPaciente,VW_ATENCIONPACIENTE.Edad,
			VW_ATENCIONPACIENTE.Raza,VW_ATENCIONPACIENTE.Religion,
			VW_ATENCIONPACIENTE.Cargo,VW_ATENCIONPACIENTE.AreaLaboral,
			VW_ATENCIONPACIENTE.Ocupacion,VW_ATENCIONPACIENTE.CodigoHC,
			VW_ATENCIONPACIENTE.CodigoHCAnterior,VW_ATENCIONPACIENTE.CodigoHCSecundario,
			VW_ATENCIONPACIENTE.TipoAlmacenamiento,VW_ATENCIONPACIENTE.TipoHistoria,
			VW_ATENCIONPACIENTE.TipoSituacion,
			VW_ATENCIONPACIENTE.IdUbicacion,
			VW_ATENCIONPACIENTE.LugarProcedencia,
			VW_ATENCIONPACIENTE.RutaFoto,
			VW_ATENCIONPACIENTE.FechaIngreso,
			VW_ATENCIONPACIENTE.IndicadorNuevo,
			VW_ATENCIONPACIENTE.EstadoPaciente,
			VW_ATENCIONPACIENTE.NumeroFile,
			VW_ATENCIONPACIENTE.Servicio,
			VW_ATENCIONPACIENTE.UsuarioAlmacenamiento,
			VW_ATENCIONPACIENTE.FechaAlmacenamiento,
			VW_ATENCIONPACIENTE.Observacion,
			VW_ATENCIONPACIENTE.IndicadorAsistencia,
			VW_ATENCIONPACIENTE.CantidadAsistencia,
			VW_ATENCIONPACIENTE.UbicacionHHCC,
			VW_ATENCIONPACIENTE.IndicadorMigradoSiteds,
			VW_ATENCIONPACIENTE.NumeroCaja,
			VW_ATENCIONPACIENTE.IndicadorCodigoBarras,
			VW_ATENCIONPACIENTE.IDPACIENTE_OK,
			VW_ATENCIONPACIENTE.CodigoAsegurado,
			VW_ATENCIONPACIENTE.NumeroPoliza,
			VW_ATENCIONPACIENTE.CodigoProducto,
			VW_ATENCIONPACIENTE.CodigoPlan,
			VW_ATENCIONPACIENTE.TipoParentesco,
			VW_ATENCIONPACIENTE.CodigoBeneficio,
			VW_ATENCIONPACIENTE.Situacion,
			VW_ATENCIONPACIENTE.TomoActual,
			VW_ATENCIONPACIENTE.IndicadorHistoriaFisica,
			VW_ATENCIONPACIENTE.DescripcionHistoria,
			VW_ATENCIONPACIENTE.NumeroCertificado,
			VW_ATENCIONPACIENTE.Persona,
			VW_ATENCIONPACIENTE.Origen,
			VW_ATENCIONPACIENTE.ApellidoPaterno,
			VW_ATENCIONPACIENTE.ApellidoMaterno,
			VW_ATENCIONPACIENTE.NombreCompleto,
			VW_ATENCIONPACIENTE.TipoDocumento,
			VW_ATENCIONPACIENTE.Documento,
			VW_ATENCIONPACIENTE.CodigoBarras,
			VW_ATENCIONPACIENTE.EsCliente,
			VW_ATENCIONPACIENTE.EsProveedor,
			VW_ATENCIONPACIENTE.EsEmpleado,
			VW_ATENCIONPACIENTE.EsOtro,
			VW_ATENCIONPACIENTE.TipoPersona,
			VW_ATENCIONPACIENTE.FechaNacimiento,
			VW_ATENCIONPACIENTE.Sexo,
			VW_ATENCIONPACIENTE.CiudadNacimiento,
			VW_ATENCIONPACIENTE.Nacionalidad,
			VW_ATENCIONPACIENTE.EstadoCivil,
			VW_ATENCIONPACIENTE.NivelInstruccion,
			VW_ATENCIONPACIENTE.Direccion,
			VW_ATENCIONPACIENTE.CodigoPostal,
			VW_ATENCIONPACIENTE.Provincia,
			VW_ATENCIONPACIENTE.Departamento,
			VW_ATENCIONPACIENTE.Telefono,
			VW_ATENCIONPACIENTE.Fax,
			VW_ATENCIONPACIENTE.DocumentoFiscal,
			VW_ATENCIONPACIENTE.DocumentoIdentidad,
			VW_ATENCIONPACIENTE.CarnetExtranjeria,
			VW_ATENCIONPACIENTE.DocumentoMilitarFA,
			VW_ATENCIONPACIENTE.TipoBrevete,
			VW_ATENCIONPACIENTE.Brevete,
			VW_ATENCIONPACIENTE.Pasaporte,
			VW_ATENCIONPACIENTE.NombreEmergencia,
			VW_ATENCIONPACIENTE.DireccionEmergencia,
			VW_ATENCIONPACIENTE.TelefonoEmergencia,
			VW_ATENCIONPACIENTE.PersonaAnt,
			VW_ATENCIONPACIENTE.CorreoElectronico,
			VW_ATENCIONPACIENTE.EnfermedadGraveFlag,
			VW_ATENCIONPACIENTE.IngresoFechaRegistro,
			VW_ATENCIONPACIENTE.IngresoAplicacionCodigo,
			VW_ATENCIONPACIENTE.IngresoUsuario,
			VW_ATENCIONPACIENTE.Celular,
			VW_ATENCIONPACIENTE.ParentescoEmergencia,
			VW_ATENCIONPACIENTE.CelularEmergencia,
			VW_ATENCIONPACIENTE.LugarNacimiento,
			VW_ATENCIONPACIENTE.SuspensionFonaviFlag,
			VW_ATENCIONPACIENTE.FlagRepetido,
			VW_ATENCIONPACIENTE.CodDiscamec,
			VW_ATENCIONPACIENTE.FecIniDiscamec,
			VW_ATENCIONPACIENTE.FecFinDiscamec,
			VW_ATENCIONPACIENTE.Pais,
			VW_ATENCIONPACIENTE.EsPaciente,
			VW_ATENCIONPACIENTE.EsEmpresa,
			VW_ATENCIONPACIENTE.Persona_Old,
			VW_ATENCIONPACIENTE.personanew,
			VW_ATENCIONPACIENTE.EstadoPersona,
			VW_ATENCIONPACIENTE.Estado,
			VW_ATENCIONPACIENTE.IdAsignacionMedico,
			VW_ATENCIONPACIENTE.TipoAsignacion,
			VW_ATENCIONPACIENTE.ObservacionesAsigMed,
			VW_ATENCIONPACIENTE.EstadoAsigMed,
			VW_ATENCIONPACIENTE.EstadoEpiClinico,
			VW_ATENCIONPACIENTE.SecAsigMed,
			VW_ATENCIONPACIENTE.SecReferidaAsigMed,
				  NULL as CodigoOASpring,
				  NULL as PersonaAntX,
				  NULL as HoraIni,
				  NULL  as HoraFin,    

				   NULL AS EpiClinico,    
				   0 AS EpiAtencion,            
				   NULL AS UnidadReplicacionX,           
				   NULL AS IdEstablecimientoSaludX,           
				   NULL AS IdPersonalSaludX,     
				   NULL AS EpisodioAtencionX,     
				   NULL AS FechaRegistroX,     
				   NULL AS FechaAtencionX,  
					 NULL AS TipoAtencionX,           
				   NULL AS IdOrdenAtencionX,           
				   (case when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA then VW_ATENCIONPACIENTE.LineaOrdenAtencion else 0 end) AS LineaOrdenAtencionX,            
				   (case when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA then VW_ATENCIONPACIENTE.TipoOrdenAtencion else 0 end) AS TipoOrdenAtencionX,    
				   --(SS_AD_OrdenAtencion.TipoPaciente) AS TipoPacienteX,      
				   NULL AS TipoPacienteX,      
				   --TipoPaciente.Descripcion as TipoPacienteDesc,        
				   NULL as TipoPacienteDesc,        
				   --TipoAtencion.Nombre as TipoAtencionDesc,    
				   NULL as TipoAtencionDesc,           
				   personaPaciente.ApellidoPaterno as ApellidoPaternoX,    
				   personaPaciente.ApellidoMaterno as ApellidoMaternoX,           
				   personaPaciente.NombreCompleto as NombreCompletoX,    
				   personaPaciente.TipoDocumento as TipoDocumentoX,    
				   personaPaciente.Documento as DocumentoX,    
				   personaPaciente.Sexo as SexoX,    
				   personaPaciente.Persona as IdPacienteX,           
				   (case when VW_ATENCIONPACIENTE.Estado IS null then 0 else (case when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA then VW_ATENCIONPACIENTE.Estado else 0 end)end ) AS EstadoX,         
				  -- @CONTAR AS Contador,    
				   medico.nombrecompleto as nombrecompletomedico,
				   medico.Persona as idmedico,
				   @CONTAR AS Contador,    
				   0 AS RowNumber                     
				   FROM      SS_AD_OrdenAtencion WITH(NOLOCK)
				   LEFT JOIN dbo.VW_ATENCIONPACIENTE WITH(NOLOCK) on (VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA and VW_ATENCIONPACIENTE.Persona = SS_AD_OrdenAtencion.idPaciente)     
				   left join CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK) on (TipoPaciente.IdCodigo = SS_AD_OrdenAtencion.TipoPaciente and TipoPaciente.IdTablaMaestro = 45)     
				   left join SS_GE_TipoAtencion TipoAtencion WITH(NOLOCK) on (TipoAtencion.IdTipoAtencion = SS_AD_OrdenAtencion.TipoAtencion)    
				   left join PERSONAMAST personaPaciente WITH(NOLOCK) on (personaPaciente.Persona = SS_AD_OrdenAtencion.idPaciente)     
				   left join SS_HC_AsignacionMedico am WITH(NOLOCK) on SS_AD_OrdenAtencion.idPaciente = am.IdPaciente and am.Estado=0
				   LEFT JOIN PERSONAMAST medico WITH(NOLOCK) on am.IdAsignacionMedico  =medico.Persona     
				   where 1=1     
				   AND (VW_ATENCIONPACIENTE.Estado IS NULL)    
				   and (@CodigoHC is null OR CodigoHC = @CodigoHC)    
				   and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
				   and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')           
				   and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(SS_AD_OrdenAtencion.CodigoOA) like '%'+upper(@CodigoOA)+'%')         
				   and ((@FecIniDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion >= @FecIniDiscamec)and(@FecFinDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion <= DATEADD(DAY,1,@FecFinDiscamec) ))    
				   and (@Estado is null or (case when VW_ATENCIONPACIENTE.Estado IS null then 0 else (case when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA then VW_ATENCIONPACIENTE.Estado else 0 end)end ) = @Estado)           
					) q1
				SELECT     
				  isnull(UnidadReplicacionX,'UN'+CONVERT(varchar,RowNumber)) as UnidadReplicacion,    
				  CONVERT(bigint,isnull(EpiAtencion,0)) as IdEpisodioAtencion,  
										   --'IdEpisodioAtencion'   
				  isnull(UnidadReplicacionEC,'UN') as UnidadReplicacionEC,    
				  isnull(IdPacienteX,0) as IdPaciente,     
				  isnull(EpiClinico,0) as EpisodioClinico,    
				   IdEstablecimientoSaludX as IdEstablecimientoSalud,    
				   [IdUnidadServicio],    
				   IdPersonalSaludX as IdPersonalSalud,    
				   --idmedico as [aaaaAtencion],    
				   EpisodioAtencionX as EpisodioAtencion,    
				   FechaRegistroX as FechaRegistro,    
				   FechaAtencionX as FechaAtencion,    
				   TipoAtencionX as TipoAtencion,    
				   IdOrdenAtencionX as IdOrdenAtencion,    
				   LineaOrdenAtencionX as LineaOrdenAtencion,    
				   TipoOrdenAtencionX as TipoOrdenAtencion,    
					EstadoX as Estado,    
				   [UsuarioCreacion],[FechaCreacion],[UsuarioModificacion]    
				   ,[FechaModificacion],[IdEspecialidad],    
				   CodigoOASpring as CodigoOA,    
				   [ProximaAtencionFlag],[IdEspecialidadProxima]    
				   ,[IdEstablecimientoSaludProxima],[IdTipoInterConsulta],[IdTipoReferencia],[ObservacionProxima],[DescansoMedico]    
				   ,[DiasDescansoMedico],[FechaInicioDescansoMedico],[FechaFinDescansoMedico],[FechaOrden],[IdProcedimiento]    
				   ,[ObservacionOrden],[IdTipoOrden],    
				   [Accion],    
				   TipoAtencionDesc as  Version,    
				   [FechaRegistroEpiClinico]    
				   ,[FechaCierreEpiClinico],    
				   TipoPacienteX as TipoPaciente,    
				   [Edad],[Raza],[Religion]    
				   ,[Cargo],[AreaLaboral],[Ocupacion],[CodigoHC],[CodigoHCAnterior]    
				   ,[CodigoHCSecundario],[TipoAlmacenamiento],[TipoHistoria],[TipoSituacion],[IdUbicacion]    
				   ,[LugarProcedencia],[RutaFoto],[FechaIngreso],[IndicadorNuevo],[EstadoPaciente]    
				   ,[NumeroFile],    
				   (case when isnull(IdEpisodioAtencion,0)>0 then 'CA' else 'CC' end) as Servicio           
				   ,[UsuarioAlmacenamiento],[FechaAlmacenamiento],[Observacion]    
				   ,[IndicadorAsistencia],[CantidadAsistencia],[UbicacionHHCC],[IndicadorMigradoSiteds],[NumeroCaja]    
				   ,[IndicadorCodigoBarras]    
				   ,[IDPACIENTE_OK]    
				   ,[CodigoAsegurado]    
				   ,[NumeroPoliza]    
				   ,[CodigoProducto]    
				   ,[CodigoPlan]    
				   ,[TipoParentesco]    
				   ,[CodigoBeneficio]    
				   ,[Situacion]    
				   ,[TomoActual]    
				   ,[IndicadorHistoriaFisica]    
				   ,[DescripcionHistoria]    
				   ,[NumeroCertificado]    
				   --,convert(int ,RowNumber) as Persona    
				   ,CONVERT(INT ,ROW_NUMBER() over(order by IdPaciente asc)) AS Persona
				   ,isnull(Origen,'UN') as Origen    
				 ,ApellidoPaternoX as ApellidoPaterno    
				 ,ApellidoMaternoX as ApellidoMaterno    
				 ,NombreCompletoX as NombreCompleto    
				 ,TipoDocumentoX as TipoDocumento    
				 ,DocumentoX as Documento    
				   ,[CodigoBarras]    
				   ,[EsCliente]    
				   ,[EsProveedor]    
				   ,[EsEmpleado]    
				   ,[EsOtro]    
				   ,[TipoPersona]    
				   ,[FechaNacimiento]    
				  ,SexoX as Sexo    
				   ,[CiudadNacimiento]    
				   ,[Nacionalidad]    
				   ,[EstadoCivil]    
				   ,[NivelInstruccion]    
				   ,[Direccion]    
				   ,[CodigoPostal]    
				   ,[Provincia]    
				   ,[Departamento]    
				   ,[Telefono]    
				   ,[Fax]    
				   ,[DocumentoFiscal]    
				   ,[DocumentoIdentidad]    
				   ,[CarnetExtranjeria]    
				   ,[DocumentoMilitarFA]    
				   ,[TipoBrevete]    
				   ,[Brevete]    
				   ,[Pasaporte]    
				   ,[NombreEmergencia]    
				   ,[DireccionEmergencia]    
				   ,[TelefonoEmergencia]    
				   ,PersonaAntX as PersonaAnt    
				   ,nombrecompletomedico as [CorreoElectronico]    
				   ,[EnfermedadGraveFlag]    
				   ,[IngresoFechaRegistro]    
				   ,[IngresoAplicacionCodigo]    
				   ,[IngresoUsuario]    
				   ,[Celular]    
				   ,[ParentescoEmergencia]    
				   ,[CelularEmergencia]    
				   ,[LugarNacimiento]    
				   ,[SuspensionFonaviFlag]    
				   ,[FlagRepetido]    
				   ,[CodDiscamec]    
				   ,HoraIni  as FecIniDiscamec     
				   ,HoraFin  as FecFinDiscamec    
				   ,[Pais]    
				   ,TipoPacienteDesc as EsPaciente    
				   ,[EsEmpresa]    
				   ,[Persona_Old]    
				   ,[personanew]    
				   ,[EstadoPersona]    
				   ,IDASIGNACIONMEDICO    
				   ,tipoasignacion    
				   ,ObservacionesAsigMed    
				   ,EstadoAsigMed           
				 ,EstadoEpiClinico    
				 ,SecAsigMed    
				 ,SecReferidaAsigMed               
				FROM (      
				  SELECT DISTINCT 
			VW_ATENCIONPACIENTE.UnidadReplicacion,VW_ATENCIONPACIENTE.IdEpisodioAtencion,
			VW_ATENCIONPACIENTE.UnidadReplicacionEC,VW_ATENCIONPACIENTE.IdPaciente,
			VW_ATENCIONPACIENTE.EpisodioClinico,VW_ATENCIONPACIENTE.IdEstablecimientoSalud,
			VW_ATENCIONPACIENTE.IdUnidadServicio,VW_ATENCIONPACIENTE.IdPersonalSalud,
			VW_ATENCIONPACIENTE.EpisodioAtencion,
			VW_ATENCIONPACIENTE.FechaRegistro,VW_ATENCIONPACIENTE.FechaAtencion,
			VW_ATENCIONPACIENTE.TipoAtencion,VW_ATENCIONPACIENTE.IdOrdenAtencion,
			VW_ATENCIONPACIENTE.LineaOrdenAtencion,VW_ATENCIONPACIENTE.TipoOrdenAtencion,
			VW_ATENCIONPACIENTE.UsuarioCreacion,VW_ATENCIONPACIENTE.FechaCreacion,
			VW_ATENCIONPACIENTE.UsuarioModificacion,VW_ATENCIONPACIENTE.FechaModificacion,
			VW_ATENCIONPACIENTE.IdEspecialidad,VW_ATENCIONPACIENTE.CodigoOA,
			VW_ATENCIONPACIENTE.ProximaAtencionFlag,VW_ATENCIONPACIENTE.IdEspecialidadProxima,
			VW_ATENCIONPACIENTE.IdEstablecimientoSaludProxima,VW_ATENCIONPACIENTE.IdTipoInterConsulta,
			VW_ATENCIONPACIENTE.IdTipoReferencia,'' ObservacionProxima,
			VW_ATENCIONPACIENTE.DescansoMedico,VW_ATENCIONPACIENTE.DiasDescansoMedico,
			VW_ATENCIONPACIENTE.FechaInicioDescansoMedico,VW_ATENCIONPACIENTE.FechaFinDescansoMedico,
			VW_ATENCIONPACIENTE.FechaOrden,VW_ATENCIONPACIENTE.IdProcedimiento,
			NULL AS ObservacionOrden,VW_ATENCIONPACIENTE.IdTipoOrden,
			VW_ATENCIONPACIENTE.Accion,VW_ATENCIONPACIENTE.Version,
			VW_ATENCIONPACIENTE.FechaRegistroEpiClinico,VW_ATENCIONPACIENTE.FechaCierreEpiClinico,
			VW_ATENCIONPACIENTE.TipoPaciente,VW_ATENCIONPACIENTE.Edad,
			VW_ATENCIONPACIENTE.Raza,VW_ATENCIONPACIENTE.Religion,
			VW_ATENCIONPACIENTE.Cargo,VW_ATENCIONPACIENTE.AreaLaboral,
			VW_ATENCIONPACIENTE.Ocupacion,VW_ATENCIONPACIENTE.CodigoHC,
			VW_ATENCIONPACIENTE.CodigoHCAnterior,VW_ATENCIONPACIENTE.CodigoHCSecundario,
			VW_ATENCIONPACIENTE.TipoAlmacenamiento,VW_ATENCIONPACIENTE.TipoHistoria,
			VW_ATENCIONPACIENTE.TipoSituacion,
			VW_ATENCIONPACIENTE.IdUbicacion,
			VW_ATENCIONPACIENTE.LugarProcedencia,
			VW_ATENCIONPACIENTE.RutaFoto,
			VW_ATENCIONPACIENTE.FechaIngreso,
			VW_ATENCIONPACIENTE.IndicadorNuevo,
			VW_ATENCIONPACIENTE.EstadoPaciente,
			VW_ATENCIONPACIENTE.NumeroFile,
			VW_ATENCIONPACIENTE.Servicio,
			VW_ATENCIONPACIENTE.UsuarioAlmacenamiento,
			VW_ATENCIONPACIENTE.FechaAlmacenamiento,
			VW_ATENCIONPACIENTE.Observacion,
			VW_ATENCIONPACIENTE.IndicadorAsistencia,
			VW_ATENCIONPACIENTE.CantidadAsistencia,
			VW_ATENCIONPACIENTE.UbicacionHHCC,
			VW_ATENCIONPACIENTE.IndicadorMigradoSiteds,
			VW_ATENCIONPACIENTE.NumeroCaja,
			VW_ATENCIONPACIENTE.IndicadorCodigoBarras,
			VW_ATENCIONPACIENTE.IDPACIENTE_OK,
			VW_ATENCIONPACIENTE.CodigoAsegurado,
			VW_ATENCIONPACIENTE.NumeroPoliza,
			VW_ATENCIONPACIENTE.CodigoProducto,
			VW_ATENCIONPACIENTE.CodigoPlan,
			VW_ATENCIONPACIENTE.TipoParentesco,
			VW_ATENCIONPACIENTE.CodigoBeneficio,
			VW_ATENCIONPACIENTE.Situacion,
			VW_ATENCIONPACIENTE.TomoActual,
			VW_ATENCIONPACIENTE.IndicadorHistoriaFisica,
			VW_ATENCIONPACIENTE.DescripcionHistoria,
			VW_ATENCIONPACIENTE.NumeroCertificado,
			VW_ATENCIONPACIENTE.Persona,
			VW_ATENCIONPACIENTE.Origen,
			VW_ATENCIONPACIENTE.ApellidoPaterno,
			VW_ATENCIONPACIENTE.ApellidoMaterno,
			VW_ATENCIONPACIENTE.NombreCompleto,
			VW_ATENCIONPACIENTE.TipoDocumento,
			VW_ATENCIONPACIENTE.Documento,
			VW_ATENCIONPACIENTE.CodigoBarras,
			VW_ATENCIONPACIENTE.EsCliente,
			VW_ATENCIONPACIENTE.EsProveedor,
			VW_ATENCIONPACIENTE.EsEmpleado,
			VW_ATENCIONPACIENTE.EsOtro,
			VW_ATENCIONPACIENTE.TipoPersona,
			VW_ATENCIONPACIENTE.FechaNacimiento,
			VW_ATENCIONPACIENTE.Sexo,
			VW_ATENCIONPACIENTE.CiudadNacimiento,
			VW_ATENCIONPACIENTE.Nacionalidad,
			VW_ATENCIONPACIENTE.EstadoCivil,
			VW_ATENCIONPACIENTE.NivelInstruccion,
			VW_ATENCIONPACIENTE.Direccion,
			VW_ATENCIONPACIENTE.CodigoPostal,
			VW_ATENCIONPACIENTE.Provincia,
			VW_ATENCIONPACIENTE.Departamento,
			VW_ATENCIONPACIENTE.Telefono,
			VW_ATENCIONPACIENTE.Fax,
			VW_ATENCIONPACIENTE.DocumentoFiscal,
			VW_ATENCIONPACIENTE.DocumentoIdentidad,
			VW_ATENCIONPACIENTE.CarnetExtranjeria,
			VW_ATENCIONPACIENTE.DocumentoMilitarFA,
			VW_ATENCIONPACIENTE.TipoBrevete,
			VW_ATENCIONPACIENTE.Brevete,
			VW_ATENCIONPACIENTE.Pasaporte,
			VW_ATENCIONPACIENTE.NombreEmergencia,
			VW_ATENCIONPACIENTE.DireccionEmergencia,
			VW_ATENCIONPACIENTE.TelefonoEmergencia,
			VW_ATENCIONPACIENTE.PersonaAnt,
			VW_ATENCIONPACIENTE.CorreoElectronico,
			VW_ATENCIONPACIENTE.EnfermedadGraveFlag,
			VW_ATENCIONPACIENTE.IngresoFechaRegistro,
			VW_ATENCIONPACIENTE.IngresoAplicacionCodigo,
			VW_ATENCIONPACIENTE.IngresoUsuario,
			VW_ATENCIONPACIENTE.Celular,
			VW_ATENCIONPACIENTE.ParentescoEmergencia,
			VW_ATENCIONPACIENTE.CelularEmergencia,
			VW_ATENCIONPACIENTE.LugarNacimiento,
			VW_ATENCIONPACIENTE.SuspensionFonaviFlag,
			VW_ATENCIONPACIENTE.FlagRepetido,
			VW_ATENCIONPACIENTE.CodDiscamec,
			VW_ATENCIONPACIENTE.FecIniDiscamec,
			VW_ATENCIONPACIENTE.FecFinDiscamec,
			VW_ATENCIONPACIENTE.Pais,
			VW_ATENCIONPACIENTE.EsPaciente,
			VW_ATENCIONPACIENTE.EsEmpresa,
			VW_ATENCIONPACIENTE.Persona_Old,
			VW_ATENCIONPACIENTE.personanew,
			VW_ATENCIONPACIENTE.EstadoPersona,
			VW_ATENCIONPACIENTE.Estado,
			VW_ATENCIONPACIENTE.IdAsignacionMedico,
			VW_ATENCIONPACIENTE.TipoAsignacion,
			VW_ATENCIONPACIENTE.ObservacionesAsigMed,
			VW_ATENCIONPACIENTE.EstadoAsigMed,
			VW_ATENCIONPACIENTE.EstadoEpiClinico,
			VW_ATENCIONPACIENTE.SecAsigMed,
			VW_ATENCIONPACIENTE.SecReferidaAsigMed,
				  --SS_AD_OrdenAtencion.codigoOA as CodigoOASpring,
				  NULL as CodigoOASpring,
				 
				  NULL as PersonaAntX,
				  NULL as HoraIni,
				
				  NULL  as HoraFin,    
				   NULL AS EpiClinico,    
				   0 AS EpiAtencion,            
				   NULL AS UnidadReplicacionX,           
				   NULL AS IdEstablecimientoSaludX,           
				   NULL AS IdPersonalSaludX,     
				   NULL AS EpisodioAtencionX,     
				   NULL AS FechaRegistroX,     
				   NULL AS FechaAtencionX,  
			--       (SS_AD_OrdenAtencion.TipoAtencion) AS TipoAtencionX,    
					 NULL AS TipoAtencionX,    
				   --(case when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA then VW_ATENCIONPACIENTE.IdOrdenAtencion else 0 end) AS IdOrdenAtencionX,           
				   NULL AS IdOrdenAtencionX,           
				   (case when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA then VW_ATENCIONPACIENTE.LineaOrdenAtencion else 0 end) AS LineaOrdenAtencionX,            
				   (case when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA then VW_ATENCIONPACIENTE.TipoOrdenAtencion else 0 end) AS TipoOrdenAtencionX,    
			  
				   NULL AS TipoPacienteX,      
			     
				   NULL as TipoPacienteDesc,        
			 
				   NULL as TipoAtencionDesc,           
				   personaPaciente.ApellidoPaterno as ApellidoPaternoX,    
				   personaPaciente.ApellidoMaterno as ApellidoMaternoX,           
				   personaPaciente.NombreCompleto as NombreCompletoX,    
				   personaPaciente.TipoDocumento as TipoDocumentoX,    
				   personaPaciente.Documento as DocumentoX,    
				   personaPaciente.Sexo as SexoX,    
				   personaPaciente.Persona as IdPacienteX,           
				   (case when VW_ATENCIONPACIENTE.Estado IS null then 0 else (case when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA then VW_ATENCIONPACIENTE.Estado else 0 end)end ) AS EstadoX,         
				  -- @CONTAR AS Contador,    
				   medico.nombrecompleto as nombrecompletomedico,
				   medico.Persona as idmedico,
				   @CONTAR AS Contador,    
				   0 AS RowNumber               
				   FROM     
				   SS_AD_OrdenAtencion WITH(NOLOCK)
				   LEFT JOIN dbo.VW_ATENCIONPACIENTE WITH(NOLOCK) on (VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA and VW_ATENCIONPACIENTE.Persona = SS_AD_OrdenAtencion.idPaciente)     
				   left join CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK) on (TipoPaciente.IdCodigo = SS_AD_OrdenAtencion.TipoPaciente and TipoPaciente.IdTablaMaestro = 45)     
				   left join SS_GE_TipoAtencion TipoAtencion WITH(NOLOCK) on (TipoAtencion.IdTipoAtencion = SS_AD_OrdenAtencion.TipoAtencion)    
				   left join PERSONAMAST personaPaciente WITH(NOLOCK) on (personaPaciente.Persona = SS_AD_OrdenAtencion.idPaciente)     
				   left join SS_HC_AsignacionMedico am WITH(NOLOCK) on SS_AD_OrdenAtencion.idPaciente = am.IdPaciente and am.Estado=0
				   LEFT JOIN PERSONAMAST medico WITH(NOLOCK) on am.IdAsignacionMedico  =medico.Persona          
				   where 1=1     
				   AND (VW_ATENCIONPACIENTE.Estado IS NULL)    
				   and (@CodigoHC is null OR CodigoHC = @CodigoHC)    
				   and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
				   and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(personaPaciente.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')           
				   and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(SS_AD_OrdenAtencion.CodigoOA) like '%'+upper(@CodigoOA)+'%')         --  
				   and ((@FecIniDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion >= @FecIniDiscamec)and(@FecFinDiscamec is null or  VW_ATENCIONPACIENTE.FechaAtencion <= DATEADD(DAY,1,@FecFinDiscamec)))    
				   and (@Estado is null or (case when VW_ATENCIONPACIENTE.Estado IS null then 0 else (case when VW_ATENCIONPACIENTE.codigoOA = SS_AD_OrdenAtencion.CodigoOA then VW_ATENCIONPACIENTE.Estado else 0 end)end ) = @Estado)    
				   ) AS LISTADO    
				   WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR RowNumber BETWEEN @Inicio  AND @NumeroFilas                 
       
         end      
end    


end
/*    
exec SP_VW_ATENCIONPACIENTE_LISTAR     
NULL,NULL,NULL,204,NULL,NULL,NULL,null,NULL,NULL,    
NULL,NULL,NULL,NULL,NULL,NULL,NULL,'ROYAL',NULL,NULL,    
NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,    
NULL,NULL,NULL,0,NULL,0,NULL,NULL,NULL,NULL,    
NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,    
NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'CA',    
0,10,NULL,'LISTARPAG'      

*/


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
			where --P.SECUENCIALHCE= SS_HC_Medicamento.CodigoOA  
			 P.SECUENCIALHCE COLLATE Latin1_General_CI_AS = SS_HC_Medicamento.CodigoOA COLLATE Latin1_General_CI_AS			
			and p.IdOrdenAtencion=vw.IdOrdenAtencion  and p.Linea=vw.LineaOrdenAtencion ) is not null then 3
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
/****** Object:  StoredProcedure [dbo].[sp_vw_favoritos]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 --exec sp_vw_favoritos 0,null,null,'LISTARPAG'    
    
CREATE OR ALTER PROCEDURE [sp_vw_favoritos]    
(    
  @Idfavorito    int,    
  @NumeroFavorito   int,    
  @Mnemotecnico   varchar(15),    
  @Descripcion   varchar(50),    
  @DescripcionExtranjera varchar(100),    
  @IdAgente    int,    
  @IdFavoritoTabla  int,    
  @Estado     int,    
  @Accion     varchar(25),    
  @Version    varchar(25),    
  @NombreTabla   varchar(128),    
  @DescripTabla   varchar(100),    
  @CodigoAgente   varchar(15),    
  @Nombre     varchar(60),    
  @TipoFavorito   int    
)    
    
AS    
BEGIN     
SET NOCOUNT ON;    
BEGIN  TRANSACTION    
     
 if(@ACCION = 'LISTARPAG')    
 begin      
  DECLARE @CONTADOR INT =0    
  SET @CONTADOR=(    
    SELECT COUNT(IdFavorito) FROM vw_favoritos WHERE     
    (@Idfavorito is null or @Idfavorito ='' or  Idfavorito = @Idfavorito)              
    --and (@ESTADO is null OR Estado = @ESTADO)    
    and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')     
    and (@CodigoAgente is null  OR @CodigoAgente =''  OR  upper(CodigoAgente) like '%'+upper(@CodigoAgente)+'%')   
    and (@IdFavoritoTabla is null or @IdFavoritoTabla ='' or  IdFavoritoTabla = @IdFavoritoTabla)            
    and (@TipoFavorito is null OR TipoFavorito = @TipoFavorito)      
    )    
  select @CONTADOR;    
 end    
 ELSE IF @Accion ='LISTARGRUPO'        
    BEGIN       
    DECLARE @CONTAR INT    
    SET @CONTAR=(SELECT COUNT(*) FROM  ss_hc_favoritonumero     
    INNER JOIN ss_hc_favorito ON (ss_hc_favorito.IdFavorito = SS_HC_FavoritoNumero.IdFavorito)    
    left JOIN SS_HC_Tabla ON (SS_HC_Tabla.IdFavoritoTabla = ss_hc_favorito.IdFavoritoTabla)     
    WHERE (@Descripcion IS NULL OR Upper(ss_hc_favoritonumero.descripcion) LIKE '%' + Upper(@Descripcion) + '%' )     
      AND (@IdFavorito IS NULL OR SS_HC_Favorito.IdFavorito = @IdFavorito OR @IdFavorito = 0 )   
      AND (@Mnemotecnico IS NULL OR Upper(ss_hc_favoritonumero.Mnemotecnico) LIKE '%' + Upper(@Mnemotecnico) + '%' )     
      AND (@IdAgente IS NULL OR ss_hc_favorito.IdAgente = @IdAgente OR @IdAgente = 0 ) )       
      SELECT @CONTAR;      
 END      
commit     
END 
GO
/****** Object:  StoredProcedure [dbo].[sp_vw_favoritos_listar]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
      
 --exec sp_vw_favoritos_listar 0,null,null,null,null,null,null,'LISTARPAG',null,0,10        
CREATE OR ALTER PROCEDURE [sp_vw_favoritos_listar]        
   @Idfavorito    int,        
   @NumeroFavorito   int,        
   @Mnemotecnico    varchar(15),        
   @Descripcion    varchar(50),        
   @DescripcionExtranjera varchar(100),        
   @IdAgente     int,        
   @IdFavoritoTabla   int,        
   @Estado     int,        
   @Accion     varchar(25),         
   @Version     varchar(25),      
   @NombreTabla    varchar(128),      
   @DescripTabla    varchar(100),      
      @CodigoAgente    varchar(15),      
   @Nombre     varchar(60),      
   @TipoFavorito    int,        
      @INICIO     int= null,          
   @NUMEROFILAS    int = null         
AS            
BEGIN            
if(@ACCION = 'LISTARPAG')        
 begin        
   DECLARE @CONTADOR INT        
         
  SET @CONTADOR=(        
    SELECT COUNT(NumeroFavorito) FROM vw_favoritos WHERE         
    (@Idfavorito is null or @Idfavorito ='' or  Idfavorito = @Idfavorito)                  
    and (@ESTADO is null OR Estado = @ESTADO)        
    and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')      
    and (@CodigoAgente is null  OR @CodigoAgente =''  OR  upper(CodigoAgente) like '%'+upper(@CodigoAgente)+'%')               
    and (@TipoFavorito is null OR TipoFavorito = @TipoFavorito)      
    and (@IdFavoritoTabla is null or @IdFavoritoTabla ='' or  IdFavoritoTabla = @IdFavoritoTabla)     
    )        
  SELECT         
    convert(int,ROW_NUMBER() OVER (ORDER BY IdFavorito ASC )) as IdFavorito,        
    NumeroFavorito,        
    Mnemotecnico,        
    Descripcion,        
    DescripcionExtranjera,        
    IdAgente,        
    IdFavoritoTabla,        
    Estado,        
    Accion,        
    convert(varchar,IdFavorito) as Version  ,      
    NombreTabla,      
    DescripTabla,      
    CodigoAgente,      
    Nombre,      
    TipoFavorito      
            
  FROM (          
   SELECT        
     IdFavorito,        
     NumeroFavorito,        
     Mnemotecnico,        
     Descripcion,        
     DescripcionExtranjera,        
     IdAgente,        
     IdFavoritoTabla,        
     Estado,        
     Accion,        
     Version,          
    NombreTabla,      
    DescripTabla,      
    CodigoAgente,      
    Nombre,      
    TipoFavorito        
      ,@CONTADOR AS Contador        
      ,ROW_NUMBER() OVER (ORDER BY NumeroFavorito ASC ) AS RowNumber            
     FROM vw_favoritos         
     WHERE         
    (@Idfavorito is null or @Idfavorito =0  or  Idfavorito = @Idfavorito)              
             
    and (@Estado is null OR Estado = @Estado)        
    and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')        
    and (@CodigoAgente is null  OR @CodigoAgente =''  OR  upper(CodigoAgente) like '%'+upper(@CodigoAgente)+'%')      
    and (@NombreTabla is null  OR @NombreTabla =''  OR  upper(NombreTabla) like '%'+upper(@NombreTabla)+'%')           
    and (@TipoFavorito is null OR TipoFavorito = @TipoFavorito)        
    and (@IdFavoritoTabla is null or @IdFavoritoTabla =0 or  IdFavoritoTabla = @IdFavoritoTabla)   
 and (@NumeroFavorito is null OR NumeroFavorito = @NumeroFavorito)                  
         
   ) AS LISTADO        
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR          
            RowNumber BETWEEN @Inicio  AND @NumeroFilas         
          
       END        
       ELSE        
  IF @Accion ='LISTAR'            
    BEGIN            
  SELECT         
    IdFavorito,        
    NumeroFavorito,        
    Mnemotecnico,        
    Descripcion,        
    DescripcionExtranjera,        
    IdAgente,        
    IdFavoritoTabla,        
    Estado,        
    Accion,        
    Version ,          
    NombreTabla,      
    DescripTabla,      
    CodigoAgente,      
    Nombre,      
    TipoFavorito         
    FROM vw_favoritos         
   WHERE         
    (@Idfavorito is null or @Idfavorito =0 or  Idfavorito = @Idfavorito)                  
    and (@NumeroFavorito is null or @NumeroFavorito =0 OR NumeroFavorito = @NumeroFavorito)                      
    and (@IdAgente is null OR IdAgente = @IdAgente)           
      
    and (@ESTADO is null OR Estado = @ESTADO)        
    and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')             
    and (@CodigoAgente is null  OR @CodigoAgente =''  OR  upper(CodigoAgente) like '%'+upper(@CodigoAgente)+'%')      
    and (@NombreTabla is null  OR @NombreTabla =''  OR  upper(NombreTabla) like '%'+upper(@NombreTabla)+'%')      
    and (@TipoFavorito is null OR TipoFavorito = @TipoFavorito)      
    and (@IdFavoritoTabla is null or @IdFavoritoTabla =0 or  IdFavoritoTabla = @IdFavoritoTabla)   
            
end         
 else        
 if(@ACCION = 'LISTARPORID')        
 begin          
    SELECT  * FROM  vw_favoritos        
     WHERE  (@Idfavorito is null or @Idfavorito ='' or  Idfavorito = @Idfavorito)        
        
 end         
 ELSE IF @Accion ='LISTARGRUPO'            
    BEGIN           
    DECLARE @CONTAR INT        
  SET @CONTAR=(SELECT COUNT(*) FROM  ss_hc_favoritonumero      
    INNER JOIN ss_hc_favorito ON (ss_hc_favorito.IdFavorito = SS_HC_FavoritoNumero.IdFavorito)        
    left JOIN SS_HC_Tabla ON (SS_HC_Tabla.IdFavoritoTabla = ss_hc_favorito.IdFavoritoTabla)         
    WHERE (@Descripcion IS NULL OR Upper(ss_hc_favoritonumero.descripcion) LIKE '%' + Upper(@Descripcion) + '%' )         
      AND (@IdFavorito IS NULL OR SS_HC_Favorito.IdFavorito = @IdFavorito OR @IdFavorito = 0 )   
      AND (@Mnemotecnico IS NULL OR Upper(ss_hc_favoritonumero.Mnemotecnico) LIKE '%' + Upper(@Mnemotecnico) + '%' )     
      AND (@IdAgente IS NULL OR SS_HC_Favorito.IdAgente = @IdAgente OR @IdAgente = 0 ))        
        
    SELECT         
     IdFavorito,        
     NumeroFavorito,        
     Mnemotecnico,        
  Descripcion,        
  DescripcionExtranjera,        
  IdAgente,        
  idfavoritotabla,        
  Estado,        
  Accion,        
  Version,          
    NombreTabla,      
    DescripTabla,      
    CodigoAgente,      
    Nombre,      
    TipoFavorito          
 FROM(SELECT         
    convert(int,ROW_NUMBER() OVER (ORDER BY ss_hc_favoritonumero.IdFavorito ASC )) IdFavorito,        
    NumeroFavorito,        
    Mnemotecnico,        
    ss_hc_favoritonumero.Descripcion,        
    ss_hc_tabla.nombretabla DescripcionExtranjera, --NOMBRETABLA        
    dbo.SS_HC_Favorito.IdAgente,        
    ss_hc_favorito.idfavoritotabla, --IDFAVORITOTABLA        
    ss_hc_favoritonumero.Estado,            
    ss_hc_favoritonumero.Accion,     
    --ss_hc_tabla.descripcion Version, --DESCRIPCIONTABLA        
    convert(varchar,ss_hc_favoritonumero.IdFavorito) Version,          
    SS_HC_Tabla.NombreTabla,      
    SS_HC_Tabla.Descripcion as DescripTabla,      
    SG_Agente.CodigoAgente,      
    SG_Agente.Nombre,      
    ss_hc_favorito.TipoFavorito ,       
    @CONTAR AS Contador,        
    ROW_NUMBER() OVER (ORDER BY NumeroFavorito ASC ) AS RowNumber          
    FROM ss_hc_favoritonumero         
    INNER JOIN ss_hc_favorito        
    ON (ss_hc_favorito.IdFavorito = SS_HC_FavoritoNumero.IdFavorito)        
    left JOIN SS_HC_Tabla        
    ON (SS_HC_Tabla.IdFavoritoTabla = ss_hc_favorito.IdFavoritoTabla)           
    INNER JOIN SG_Agente        
    ON (SG_Agente.IdAgente = ss_hc_favorito.IdAgente)      
    WHERE (@Descripcion IS NULL OR Upper(ss_hc_favoritonumero.descripcion) LIKE '%' + Upper(@Descripcion) + '%' )         
      AND (@IdFavorito IS NULL OR SS_HC_Favorito.IdFavorito = @IdFavorito OR @IdFavorito = 0 )         
      AND (@Mnemotecnico IS NULL OR Upper(ss_hc_favoritonumero.Mnemotecnico) LIKE '%' + Upper(@Mnemotecnico) + '%' )     
      AND (@IdAgente IS NULL OR SS_HC_Favorito.IdAgente = @IdAgente OR @IdAgente = 0 )  
    )as LISTARGRUPO        
               WHERE ((@Inicio  Is null AND @NumeroFilas Is null) OR RowNumber BETWEEN @Inicio  AND @NumeroFilas )        
         
 end    
 ELSE  
 IF @Accion ='LISTARNUEVO'            
    BEGIN            
  SELECT         
    IdFavorito,        
    NumeroFavorito,        
    Mnemotecnico,        
    Descripcion,        
    DescripcionExtranjera,        
    IdAgente,        
    IdFavoritoTabla,        
    Estado,        
    Accion,        
    (SELECT DESCRIPCION FROM SS_HC_FavoritoNumero WHERE (SS_HC_FavoritoNumero.NUMEROFAVORITO=vw_favoritos.NumeroFavorito and Idfavorito = @Idfavorito )) AS Version ,          
    NombreTabla,      
    DescripTabla,      
    CodigoAgente,      
    Nombre,      
    TipoFavorito         
    FROM vw_favoritos         
         WHERE         
    (@Idfavorito is null or @Idfavorito ='' or  Idfavorito = @Idfavorito)                  
    and (@ESTADO is null OR Estado = @ESTADO)        
    and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')         
    and (@NumeroFavorito is null or @NumeroFavorito ='' or  NumeroFavorito = @NumeroFavorito)       
    and (@CodigoAgente is null  OR @CodigoAgente =''  OR  upper(CodigoAgente) like '%'+upper(@CodigoAgente)+'%')      
    and (@NombreTabla is null  OR @NombreTabla =''  OR  upper(NombreTabla) like '%'+upper(@NombreTabla)+'%')      
    and (@TipoFavorito is null OR TipoFavorito = @TipoFavorito)      
            
end          
END
GO
/****** Object:  StoredProcedure [dbo].[SP_VW_FORMATOCAMPO]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_VW_FORMATOCAMPO]
		@IDFORMATO				INT,  
		@CODIGOFORMATO			VARCHAR(15), 
		@DESCRIPCIONFORMATO		VARCHAR(150),  
		@SECUENCIACAMPO			INT,   
		@DESCRIPFORMATOCAMPO	VARCHAR(100), 
		@FORMULA				VARCHAR(500),
		@Modulo					VARCHAR(10),
		@IndicadorObligatorio   int,
		@ESTADO					INT,  
		@ACCION					VARCHAR(25),
		@VERSION				VARCHAR(25)
AS 
BEGIN 
SET NOCOUNT ON;
BEGIN  TRANSACTION
	
	if(@ACCION = 'LISTARPAG')
	begin		
		DECLARE @CONTADOR INT =0
	
		SET @CONTADOR=(
				SELECT COUNT(IDFORMATO) FROM VW_FORMATOCAMPO	
				WHERE
					(@IDFORMATO is null or @IDFORMATO ='' or  IDFORMATO = @IDFORMATO)		
					and (@DESCRIPFORMATOCAMPO is null  OR @DESCRIPFORMATOCAMPO =''  OR  upper(DESCRIPFORMATOCAMPO) like '%'+upper(@DESCRIPFORMATOCAMPO)+'%')								
					and (@ESTADO is null OR ESTADO = @ESTADO)
				)
		select @CONTADOR
	end
	else
		if(@ACCION = 'LISTARPAGSELEC')
	begin		
		DECLARE @CONTADORS INT =0
	
		SET @CONTADORS=(
				SELECT COUNT(IDFORMATO) FROM VW_FORMATOCAMPO	
				WHERE
					(@IDFORMATO is null or @IDFORMATO ='' or  IDFORMATO = @IDFORMATO)		
					and (@DESCRIPFORMATOCAMPO is null  OR @DESCRIPFORMATOCAMPO =''  OR  upper(DESCRIPFORMATOCAMPO) like '%'+upper(@DESCRIPFORMATOCAMPO)+'%')								
					and (@ESTADO is null OR ESTADO = @ESTADO)	
					AND Modulo = 'HC' 
					AND IndicadorObligatorio=1
				)
		select @CONTADORS
	end
	else
		if(@ACCION = 'LISTARPAGFORMATOCAMPO')
	begin		
		DECLARE @CONTADORFC INT =0
	
		SET @CONTADORFC=(
				SELECT COUNT(IDFORMATO) FROM VW_FORMATOCAMPO	
				WHERE
					(@IDFORMATO is null or @IDFORMATO ='' or  IDFORMATO = @IDFORMATO)		
					and (@DESCRIPFORMATOCAMPO is null  OR @DESCRIPFORMATOCAMPO =''  OR  upper(DESCRIPFORMATOCAMPO) like '%'+upper(@DESCRIPFORMATOCAMPO)+'%')								
					and (@ESTADO is null OR ESTADO = @ESTADO)
				)
		select @CONTADORFC
	end

commit	
	
END  
GO
/****** Object:  StoredProcedure [dbo].[SP_VW_FORMATOCAMPO_LISTA]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_VW_FORMATOCAMPO_LISTA]
		@IDFORMATO				INT,  
		@CODIGOFORMATO			VARCHAR(15), 
		@DESCRIPCIONFORMATO		VARCHAR(150),  
		@SECUENCIACAMPO			INT,   
		@DESCRIPFORMATOCAMPO	VARCHAR(100), 
		@FORMULA				VARCHAR(500),
		@Modulo					VARCHAR(10),
		@IndicadorObligatorio   int,
		@ESTADO					INT,  
		@ACCION					VARCHAR(25), 
		@VERSION				VARCHAR(25), 
	    @INICIO					int= null,  
	    @NUMEROFILAS			int = null 
AS    
BEGIN    
if(@ACCION = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR=(
				SELECT COUNT(IDFORMATO) FROM VW_FORMATOCAMPO	
				WHERE 
					(@IDFORMATO is null or @IDFORMATO ='' or  IDFORMATO = @IDFORMATO)		
					and (@DESCRIPFORMATOCAMPO is null  OR @DESCRIPFORMATOCAMPO =''  OR  upper(DESCRIPFORMATOCAMPO) like '%'+upper(@DESCRIPFORMATOCAMPO)+'%')								
					and (@ESTADO is null OR ESTADO = @ESTADO)	
				)
		SELECT 
				
				IDFORMATO,
				CODIGOFORMATO,
				DESCRIPCIONFORMATO,
				SECUENCIACAMPO, 
				DESCRIPFORMATOCAMPO,  
				FORMULA, 
				ESTADO,  
				ACCION,
				VERSION	
				
		FROM (		
			SELECT
				IDFORMATO,
				CODIGOFORMATO,
				DESCRIPCIONFORMATO,
				SECUENCIACAMPO, 
				DESCRIPFORMATOCAMPO,  
				FORMULA, 
				ESTADO,  
				ACCION,
				VERSION	
				  ,@CONTADOR AS Contador
				  ,ROW_NUMBER() OVER (ORDER BY IDFORMATO ASC ) AS RowNumber   	
					FROM VW_FORMATOCAMPO	
					WHERE 
					(@IDFORMATO is null or @IDFORMATO ='' or  IDFORMATO = @IDFORMATO)		
					and (@DESCRIPFORMATOCAMPO is null  OR @DESCRIPFORMATOCAMPO =''  OR  upper(DESCRIPFORMATOCAMPO) like '%'+upper(@DESCRIPFORMATOCAMPO)+'%')								
					and (@ESTADO is null OR ESTADO = @ESTADO)	
				
 
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		
       END
       ELSE
if(@ACCION = 'LISTARPAGSELEC')
	begin
		DECLARE @CONTADORS INT =0
	
		SET @CONTADORS=(
				SELECT COUNT(IDFORMATO) FROM VW_FORMATOCAMPO	
				WHERE
					(@IDFORMATO is null or @IDFORMATO ='' or  IDFORMATO = @IDFORMATO)		
					and (@DESCRIPFORMATOCAMPO is null  OR @DESCRIPFORMATOCAMPO =''  OR  upper(DESCRIPFORMATOCAMPO) like '%'+upper(@DESCRIPFORMATOCAMPO)+'%')								
					and (@ESTADO is null OR ESTADO = @ESTADO)
					AND Modulo = 'HC' 
					AND IndicadorObligatorio=1
				)
		SELECT 
				
				IDFORMATO,
				CODIGOFORMATO,
				DESCRIPCIONFORMATO,
				SECUENCIACAMPO, 
				DESCRIPFORMATOCAMPO,  
				FORMULA, 
				MODULO,
				INDICADOROBLIGATORIO,
				ESTADO,  
				ACCION,
				VERSION	
				
		FROM (		
			SELECT
				IDFORMATO,
				CODIGOFORMATO,
				DESCRIPCIONFORMATO,
				SECUENCIACAMPO, 
				DESCRIPFORMATOCAMPO,  
				FORMULA, 
				MODULO,
				INDICADOROBLIGATORIO,
				ESTADO,  
				ACCION,
				VERSION	
				  ,@CONTADORS AS Contador
				  ,ROW_NUMBER() OVER (ORDER BY IDFORMATO ASC ) AS RowNumber   	
					FROM VW_FORMATOCAMPO	
					WHERE 
					(@IDFORMATO is null or @IDFORMATO ='' or  IDFORMATO = @IDFORMATO)		
					and (@DESCRIPFORMATOCAMPO is null  OR @DESCRIPFORMATOCAMPO =''  OR  upper(DESCRIPFORMATOCAMPO) like '%'+upper(@DESCRIPFORMATOCAMPO)+'%')								
					and (@ESTADO is null OR ESTADO = @ESTADO)	
					AND Modulo = 'HC' 
					AND IndicadorObligatorio=1
				
 
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		
       END
       ELSE
    IF(@ACCION = 'LISTARPAGFORMATOCAMPO')
	begin
		 DECLARE @CONTADORFC INT
	
		SET @CONTADORFC=(
				SELECT COUNT(IDFORMATO) FROM VW_FORMATOCAMPO	
				WHERE 
					(@IDFORMATO is null or @IDFORMATO ='' or  IDFORMATO = @IDFORMATO)		
					and (@DESCRIPFORMATOCAMPO is null  OR @DESCRIPFORMATOCAMPO =''  OR  upper(DESCRIPFORMATOCAMPO) like '%'+upper(@DESCRIPFORMATOCAMPO)+'%')								
					and (@ESTADO is null OR ESTADO = @ESTADO)	
				)
		SELECT 
				
				IdFormato,
				CODIGOFORMATO,
				DESCRIPCIONFORMATO,
				convert(int,ROW_NUMBER() OVER (ORDER BY SECUENCIACAMPO ASC )) as SECUENCIACAMPO, 
				DESCRIPFORMATOCAMPO,  
				FORMULA, 
				MODULO,
				INDICADOROBLIGATORIO,
				ESTADO,  
				ACCION,
				convert(varchar,SECUENCIACAMPO) as Version  	
				
		FROM (		
			SELECT
				 IdFormato,
				CODIGOFORMATO,
				DESCRIPCIONFORMATO,
				SECUENCIACAMPO, 
				DESCRIPFORMATOCAMPO,  
				FORMULA, 
				MODULO,
				INDICADOROBLIGATORIO,
				ESTADO,  
				ACCION,
				VERSION	
				  ,@CONTADORFC AS Contador
				  ,ROW_NUMBER() OVER (ORDER BY IDFORMATO ASC ) AS RowNumber   	
					FROM VW_FORMATOCAMPO	
					WHERE 
					(@IDFORMATO is null or @IDFORMATO ='' or  IDFORMATO = @IDFORMATO)		
					and (@DESCRIPFORMATOCAMPO is null  OR @DESCRIPFORMATOCAMPO =''  OR  upper(DESCRIPFORMATOCAMPO) like '%'+upper(@DESCRIPFORMATOCAMPO)+'%')								
					and (@ESTADO is null OR ESTADO = @ESTADO)	
				
 
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		
       END
       ELSE
  IF @Accion ='LISTAR'    
    BEGIN    
		SELECT 
				IDFORMATO,
				CODIGOFORMATO,
				DESCRIPCIONFORMATO,
				SECUENCIACAMPO, 
				DESCRIPFORMATOCAMPO,  
				FORMULA, 
				MODULO,
				INDICADOROBLIGATORIO,
				ESTADO,  
				ACCION,
				VERSION	
				FROM VW_FORMATOCAMPO	
									WHERE 
					(@IDFORMATO is null or @IDFORMATO ='' or  IDFORMATO = @IDFORMATO)	
					and (@SECUENCIACAMPO is null or @SECUENCIACAMPO ='' or  SECUENCIACAMPO = @SECUENCIACAMPO)		
					and (@DESCRIPFORMATOCAMPO is null  OR @DESCRIPFORMATOCAMPO =''  OR  upper(DESCRIPFORMATOCAMPO) like '%'+upper(@DESCRIPFORMATOCAMPO)+'%')								
					and (@ESTADO is null OR ESTADO = @ESTADO)	
				
end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 	*	FROM 	VW_FORMATOCAMPO
				where
				(@IDFORMATO = IDFORMATO) 

	end	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_vw_Miscelaneos]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [sp_vw_Miscelaneos] 
@AplicacionHeader   CHAR, 
@CodigoHeader       VARCHAR(10), 
@CompaniaHeader     VARCHAR, 
@DescLocalHeader    VARCHAR(100), 
@DescExtHeader      VARCHAR(80), 

@EstadoHeader       CHAR, 
@UsuarioHeader      VARCHAR(25), 
@FechaHeader        DATETIME, 
@TimeHeader         TIMESTAMP, 
@AccionHeader       VARCHAR(25), 

@AplicacionDetalle  CHAR, 
@CodigoDetalle      CHAR, 
@CompaniaDetalle    CHAR, 
@ElementoDetalle    CHAR, 
@DescDetalle        CHAR, 

@DescextDetalle     CHAR, 
@ValorCodigoDetalle CHAR, 
@EstadoDetalle      CHAR, 
@UsuarioDetalle     VARCHAR(25), 
@FechaDetalle       DATETIME, 

@TimeDetalle        TIMESTAMP, 
@ValorCodigo2       CHAR, 
@ValorCodigo3       CHAR, 
@ValorCodigo4       CHAR, 
@ValorEntero1       INT, 

@ValorEntero2       INT, 
@ValorEntero3       INT, 
@ValorEntero4       INT 
AS 
  BEGIN 
      SET nocount ON; 

      BEGIN TRANSACTION 

      DECLARE @CONTADOR INT 

      IF( @AccionHeader = 'CONTARLISTAPAG' ) 
        BEGIN 
            SET @CONTADOR=(SELECT Count(*) 
                           FROM   vw_miscelaneos 
                           WHERE  ( @CodigoHeader IS NULL 
                                     OR @CodigoHeader = '' 
                                     OR Upper(Ltrim(Rtrim(codigoheader))) LIKE 
                                        '%' + Upper(Ltrim(Rtrim(@CodigoHeader))) 
                                        + '%' ) 
                                  AND ( @DescLocalHeader IS NULL 
                                         OR @DescLocalHeader = '' 
                                         OR Upper(desclocalheader) LIKE 
                                            '%' + Upper(@DescLocalHeader) + 
                                            '%' )) 

            SELECT @CONTADOR 
        END 
      ELSE IF ( @AccionHeader = 'LISTADO' ) 
        BEGIN 
            DECLARE @CONTAR INT 

            SET @CONTAR = (SELECT Count(*) 
                           FROM   ma_miscelaneosheader 
                           WHERE  ( @CodigoHeader IS NULL 
                                     OR @CodigoHeader = '' 
                                     OR Upper(Ltrim(Rtrim(codigotabla))) LIKE 
                                        '%' + Upper(Ltrim(Rtrim(@CodigoHeader))) 
                                        + 
                                        '%' ) 
                                  AND ( @DescLocalHeader IS NULL 
                                         OR @DescLocalHeader = '' 
                                         OR Upper(descripcionlocal) LIKE 
                                            '%' + Upper(@DescLocalHeader) + 
                                            '%' )) 

            SELECT @CONTAR 
        END 

      COMMIT 
  END 
/* 
EXEC [sp_vw_Miscelaneos] 
NULL,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,NULL,'LISTADO',
NULL,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,NULL,NULL,
NULL,NULL,NULL
*/ 
 
GO
/****** Object:  StoredProcedure [dbo].[sp_vw_Miscelaneos_listar]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [sp_vw_Miscelaneos_listar] 
@AplicacionHeader   CHAR, 
@CodigoHeader       VARCHAR(10) , 
@CompaniaHeader     CHAR, 
@DescLocalHeader    VARCHAR(100 ), 
@DescExtHeader      VARCHAR(80) , 

@EstadoHeader       CHAR, 
@UsuarioHeader      VARCHAR(25) , 
@FechaHeader        DATETIME, 
@TimeHeader         TIMESTAMP, 
@AccionHeader       VARCHAR(25) , 

@AplicacionDetalle  CHAR, 
@CodigoDetalle      CHAR, 
@CompaniaDetalle    CHAR, 
@ElementoDetalle    CHAR, 
@DescDetalle        CHAR, 

@DescextDetalle     CHAR, 
@ValorCodigoDetalle CHAR, 
@EstadoDetalle      CHAR, 
@UsuarioDetalle     VARCHAR(25) , 
@FechaDetalle       DATETIME, 

@TimeDetalle        TIMESTAMP, 
@ValorCodigo2       CHAR, 
@ValorCodigo3       CHAR, 
@ValorCodigo4       CHAR, 
@ValorEntero1       INT, 

@ValorEntero2       INT, 
@ValorEntero3       INT, 
@ValorEntero4       INT, 
@INICIO             INT= NULL, 
@NUMEROFILAS        INT = NULL 

AS 
  BEGIN 
      IF( @AccionHeader = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR=(SELECT Count(*) 
                           FROM   vw_miscelaneos 
                           WHERE  ( @CodigoHeader IS NULL 
                                     OR @CodigoHeader = '' 
                                     OR Upper(Ltrim(Rtrim(codigoheader))) LIKE 
                                        '%' + Upper(Ltrim(Rtrim(@CodigoHeader))) 
                                        + '%' ) 
                                  AND ( @DescLocalHeader IS NULL 
                                         OR @DescLocalHeader = '' 
                                         OR Upper(desclocalheader) LIKE 
                                            '%' + Upper(@DescLocalHeader) + 
                                            '%' )) 

            SELECT aplicacionheader, 
                   codigoheader, 
                   companiaheader, 
                   desclocalheader, 
                   descextheader, 
                   estadoheader, 
                   usuarioheader, 
                   fechaheader, 
                   timeheader, 
                   accionheader, 
                   aplicaciondetalle, 
                   codigodetalle, 
                   companiadetalle, 
                   elementodetalle, 
                   descdetalle, 
                   descextdetalle, 
                   valorcodigodetalle, 
                   estadodetalle, 
                   usuariodetalle, 
                   fechadetalle, 
                   timedetalle, 
                   valorcodigo2, 
                   valorcodigo3, 
                   valorcodigo4, 
                   CONVERT(INT, Row_number() 
                                  OVER ( 
                                    ORDER BY valorentero1 ASC )) AS ValorEntero1 
                   , 
                   valorentero2, 
                   valorentero3, 
                   valorentero4 
            FROM   (SELECT aplicacionheader, 
                           codigoheader, 
                           companiaheader, 
                           desclocalheader, 
                           descextheader, 
                           estadoheader, 
                           usuarioheader, 
                           fechaheader, 
                           timeheader, 
                           accionheader, 
                           aplicaciondetalle, 
                           codigodetalle, 
                           companiadetalle, 
                           elementodetalle, 
                           descdetalle, 
                           descextdetalle, 
                           valorcodigodetalle, 
                           estadodetalle, 
                           usuariodetalle, 
                           fechadetalle, 
                           timedetalle, 
                           valorcodigo2, 
                           valorcodigo3, 
                           valorcodigo4, 
                           valorentero1, 
                           valorentero2, 
                           valorentero3, 
                           valorentero4, 
                           @CONTADOR                           AS Contador, 
                           Row_number() 
                             OVER ( 
                               ORDER BY aplicacionheader ASC ) AS RowNumber 
                    FROM   vw_miscelaneos 
                    WHERE  ( @CodigoHeader IS NULL 
                              OR @CodigoHeader = '' 
                              OR Upper(Ltrim(Rtrim(codigoheader))) LIKE 
                                 '%' + Upper(Ltrim(Rtrim(@CodigoHeader))) 
                                 + '%' ) 
                           AND ( @DescLocalHeader IS NULL 
                                  OR @DescLocalHeader = '' 
                                  OR Upper(desclocalheader) LIKE 
                                     '%' + Upper(@DescLocalHeader) + 
                                     '%' )) AS LISTADO 
            WHERE  ( @Inicio IS NULL 
                     AND @NumeroFilas IS NULL ) 
                    OR rownumber BETWEEN @Inicio AND @NumeroFilas 
        END 
      ELSE IF ( @AccionHeader = 'LISTADO' ) 
        BEGIN 
            DECLARE @CONTAR INT 

            SELECT @CONTAR = Count(*) 
            FROM   ma_miscelaneosheader 
            WHERE  ( @CodigoHeader IS NULL OR @CodigoHeader = '' OR Upper(Ltrim(Rtrim(codigotabla))) LIKE '%' + Upper(Ltrim(Rtrim(@CodigoHeader))) + '%' ) 
                   AND ( @DescLocalHeader IS NULL OR @DescLocalHeader = '' OR Upper(descripcionlocal) LIKE '%' + Upper(@DescLocalHeader) + '%' ) 

            SELECT aplicacioncodigo      AS AplicacionHeader, 
                   codigotabla           AS CodigoHeader, 
                   compania              AS CompaniaHeader, 
                   descripcionlocal      AS DescLocalHeader, 
                   descripcionextranjera AS DescExtHeader, 
                   estado                AS EstadoHeader, 
                   ultimousuario         AS UsuarioHeader, 
                   ultimafechamodif      AS FechaHeader, 
                   timestamp             AS TimeHeader, 
                   accion                AS AccionHeader, 
                   aplicaciondetalle, 
                   codigodetalle, 
                   companiadetalle, 
                   elementodetalle, 
                   descdetalle, 
                   descextdetalle, 
                   valorcodigodetalle, 
                   estadodetalle, 
                   usuariodetalle, 
                   fechadetalle, 
                   timestamp AS  timedetalle, 
                   valorcodigo2, 
                   valorcodigo3, 
                   valorcodigo4, 
                   CONVERT(INT, Row_number() OVER (ORDER BY valorentero1 ASC )) AS ValorEntero1 ,
                   valorentero2, 
                   valorentero3, 
                   valorentero4 
            FROM   (SELECT ma_miscelaneosheader.aplicacioncodigo, 
                           ma_miscelaneosheader.codigotabla, 
                           ma_miscelaneosheader.compania, 
                           ma_miscelaneosheader.descripcionlocal, 
                           ma_miscelaneosheader.descripcionextranjera, 
                           ma_miscelaneosheader.estado, 
                           ma_miscelaneosheader.ultimousuario, 
                           ma_miscelaneosheader.ultimafechamodif, 
                           ma_miscelaneosheader.timestamp, 
                           ma_miscelaneosheader.accion, 
                           ''                             AplicacionDetalle, 
                           ''                             CodigoDetalle, 
                           ''                             CompaniaDetalle, 
                           ''                             ElementoDetalle, 
                           ''                             DescDetalle, 
                           ''                             DescextDetalle, 
                           ''                             ValorCodigoDetalle, 
                           ''                             EstadoDetalle, 
                           ''                             UsuarioDetalle, 
                           GETDATE()                      FechaDetalle, 
                           ''                             TimeDetalle, 
                           ''                             ValorCodigo2, 
                           ''                             ValorCodigo3, 
                           ''                             ValorCodigo4, 
                   0 ValorEntero1 ,
                           0                             ValorEntero2, 
                           0                             ValorEntero3, 
                           0                             ValorEntero4, 
                           @CONTAR                        AS CONTADOR, 
                           Row_number() 
                             OVER( 
                               ORDER BY descripcionlocal) AS ROWNUMBER 
                    FROM   ma_miscelaneosheader 
                    WHERE  ( @CodigoHeader IS NULL 
                              OR @CodigoHeader = '' 
                              OR Upper(Ltrim(Rtrim(codigotabla))) LIKE 
                                 '%' + Upper(Ltrim(Rtrim(@CodigoHeader))) + 
                                 '%' ) 
                           AND ( @DescLocalHeader IS NULL 
                                  OR @DescLocalHeader = '' 
                                  OR Upper(descripcionlocal) LIKE 
                                     '%' + Upper(@DescLocalHeader) + 
                                     '%' ))AS LISTADO 
            WHERE ( @INICIO IS NULL 
                    AND @NUMEROFILAS IS NULL ) 
                   OR ( rownumber BETWEEN @INICIO AND @NUMEROFILAS ) 
        END 
  END 
/* 
EXEC [sp_vw_Miscelaneos_listar] 
NULL,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,NULL,'LISTADO',
NULL,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,NULL,NULL
*/ 
 
GO
/****** Object:  StoredProcedure [dbo].[SP_VW_PERSONAPACIENTE]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_VW_PERSONAPACIENTE]                    
(                    
 @Persona int,                    
 @NombreCompleto varchar(100)=NULL,                    
 @TipoDocumento char(1)=NULL,                    
 @Documento VARCHAR(20)=NULL,                    
 @EsCliente varchar(1)=NULL,                    
 @EsEmpleado varchar(1)=NULL,                    
 @EsOtro varchar(1)=NULL,                    
 @EsProveedor varchar(1)=NULL,                    
 @EsPaciente varchar(1)=NULL,                    
 @EsEmpresa varchar(1)=NULL,                    
   
 @FechaNacimiento datetime=NULL,                    
 @Sexo char(1)=NULL,                    
 @EstadoCivil char(1)=NULL,                    
 @NivelInstruccion char(3)=NULL,                    
 @CodigoPostal char(3)=NULL,                    
 @Provincia char(3)=NULL,                    
 @Departamento char(3)=NULL,   
 @TipoMedico int=NULL,                    
 @Estado char(1)=NULL,                    
 @EstadoEmpleado char(1)=NULL,                    
   
 @FechaIngreso DATETIME=NULL,                    
 @CompaniaSocio char(8)=NULL,                    
 @CentroCostos char(10)=NULL,                    
 @AFE VARCHAR(15)=NULL,                    
 @GradoSalario char(3)=NULL,                    
 @CodigoCargo int=NULL,                    
 @DepartamentoOperacional char(10)=NULL,                    
 @Paciente char(10)=NULL,                    
 @HistoriaClinica char(10)=NULL,    
 @Usuario VARCHAR(20) =NULL,        
                
 @USUARIOPERFIL CHAR(2)=NULL,                         
 @INICIO   int= null,                      
 @NUMEROFILAS int = null ,                    
 @ACCION VARCHAR(25)                    
)                    
                    
AS                    
BEGIN                    
 DECLARE @CONTADOR INT                    
                    
 if(@ACCION = 'CONTARLISTARPAG')                    
 begin                    
   SET @CONTADOR=(SELECT COUNT(Persona)                          
     FROM VW_PERSONAPACIENTE                      
     WHERE                     
     (@Persona is null or (@Persona =0 )  OR Persona = @Persona)                    
     and (@Paciente is null OR Paciente = @Paciente)                    
     and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                           
     and (@ESTADO is null OR Estado = @ESTADO)                    
     and (@Usuario is null OR Usuario = @Usuario))                    
                       
   select @CONTADOR                    
 end                    
 else                    
 if(@ACCION = 'CONTARLISTARPAGSELECUSER')                    
 begin                    
   SET @CONTADOR=(SELECT COUNT(Persona)                          
     FROM VW_PERSONAPACIENTE                      
     WHERE                     
     (@Persona is null or (@Persona =0 )  OR Persona = @Persona)                    
     and (@Paciente is null OR Paciente = @Paciente)                    
     and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                           
     and (@ESTADO is null OR Estado = @ESTADO)                    
     and (@Usuario is null OR Usuario = @Usuario))                    
                       
   select @CONTADOR                    
 end                     
   else                    
 if(@ACCION = 'LISTARPAGSELECUSER')                    
 begin                    
   SET @CONTADOR=(SELECT COUNT(Persona)                          
     FROM VW_PERSONAPACIENTE                      
     WHERE                     
     (@Persona is null or (@Persona =0 )  OR Persona = @Persona)                    
     and (@Paciente is null OR Paciente = @Paciente)                    
     and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                           
     and (@ESTADO is null OR Estado = @ESTADO)                    
     and (@Usuario is null OR Usuario = @Usuario))                    
                       
   select @CONTADOR                    
 end                     
 else if(@ACCION = 'CONTARLISTAPAG')                    
 begin                    
   SET @CONTADOR=(SELECT COUNT(Persona)                          
     FROM VW_PERSONAPACIENTE                      
     WHERE                     
     (@Persona is null or (@Persona =0 )  OR Persona = @Persona)                    
     and (@Paciente is null OR Paciente = @Paciente)                    
     and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                           
     and (@ESTADO is null OR Estado = @ESTADO)                    
     and (@Usuario is null OR Usuario = @Usuario))                    
                       
   select @CONTADOR                    
 end                     
 else                    
 if(@ACCION = 'LISTARNUEVOPAG')                    
 begin                    
   SET @CONTADOR=(SELECT COUNT(Persona)                          
     FROM VW_PERSONAPACIENTE                      
     WHERE                     
     (@Persona is null or (@Persona =0 )  OR Persona = @Persona)                    
     --and (@CodigoCargo is null OR Paciente = @CodigoCargo OR @CodigoCargo = 0)                    
     AND (@CodigoCargo is null or @CodigoCargo =0 or  cast(Paciente as VARCHAR) like '%'+upper(@CodigoCargo)+'%')                    
     and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                           
     and (@ESTADO is null OR Estado = @ESTADO)                    
     --and (@Usuario is null OR Usuario = @Usuario)                    
     and (@AFE is null OR CodigoHC like '%'+ @AFE+'%')           
  and (@Usuario is null OR CodigoHCAnterior  like '%'+ @Usuario+'%')           
     AND (@TipoMedico is null or (@TipoMedico =0 ) OR Situacion = @TipoMedico)                    
     and (@Documento is null  OR  Documento like '%'+upper(rtrim(@Documento))+'%')                    
                         
     )                    
                       
   select @CONTADOR                    
 end                     
                     
 else                       
 if(@ACCION = 'LISTARNUEVOPAGDOS')                    
 begin                    
   SET @CONTADOR=(SELECT COUNT(Persona)                          
     FROM VW_PERSONAPACIENTE                      
     WHERE                     
     (@Persona is null or (@Persona =0 )  OR Persona = @Persona)                    
     --and (@CodigoCargo is null OR Paciente = @CodigoCargo OR @CodigoCargo = 0)                    
     AND (@CodigoCargo is null or @CodigoCargo =0 or  cast(Paciente as VARCHAR) like '%'+upper(@CodigoCargo)+'%')                    
     and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                           
     and (@ESTADO is null OR Estado = @ESTADO)                    
     --and (@Usuario is null OR Usuario = @Usuario)                    
     and (@AFE is null OR CodigoHC like '%'+ @AFE+'%')           
  and (@Usuario is null OR CodigoHCAnterior  like '%'+ @Usuario+'%')           
     AND (@TipoMedico is null or (@TipoMedico =0 ) OR Situacion = @TipoMedico)                    
     and (@Documento is null  OR  Documento like '%'+upper(rtrim(@Documento))+'%')               
     AND EsPaciente='S'         
  and TipoPersona='N'         
  and EsEmpleado='N'         
  and EsOtro='N'         
  and EsEmpresa is null                        
                         
     )                    
                       
   select @CONTADOR                    
 end                     
                     
 else                 
 if(@ACCION = 'LISTARPAGPACIENTE')                    
 begin                    
   SET @CONTADOR=(SELECT COUNT(Persona)                          
     FROM VW_PERSONAPACIENTE                      
     WHERE                     
     (@Persona is null or (@Persona =0 )  OR Persona = @Persona)                    
     and (@Paciente is null OR Paciente = @Paciente OR @Paciente = 0)                    
     and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                           
     and (@ESTADO is null OR Estado = @ESTADO)                    
     and (@Usuario is null OR Usuario = @Usuario)                    
     and (@AFE is null OR CodigoHC = @AFE)                    
     and (@Usuario is null OR CodigoHCAnterior = @Usuario)                    
     AND (@TipoMedico is null or (@TipoMedico =0 ) OR Situacion = @TipoMedico)                    
    and (@Documento is null  OR  upper(Documento) like '%'+upper(@Documento)+'%')                    
                         
     )                    
                       
   select @CONTADOR                    
 end                     
 else                    
 if(@ACCION = 'LISTARPAGMEDICO')                    
 begin                    
   SET @CONTADOR=(SELECT COUNT(Persona)                          
     FROM VW_PERSONAPACIENTE                      
     WHERE                     
     (@Persona is null or (@Persona =0 )  OR Persona = @Persona)                    
     and (@Paciente is null OR Paciente = @Paciente OR @Paciente = 0)                    
     and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                           
     and (@ESTADO is null OR Estado = @ESTADO)                    
     and (@Usuario is null OR Usuario = @Usuario)                    
     and (@AFE is null OR CodigoHC = @AFE)                    
     and (@Usuario is null OR CodigoHCAnterior = @Usuario)                    
     AND (@TipoMedico is null or (@TipoMedico =0 ) OR Situacion = @TipoMedico)                    
     and (@Documento is null  OR  upper(Documento) like '%'+upper(@Documento)+'%')                    
     AND (TipoTrabajador = '08')                    
     )                    
                       
   select @CONTADOR                    
 end                     
 ELSE                    
 if(@ACCION = 'LISTARPAGEMPLEADO')                    
 begin                      
   SET @CONTADOR=(SELECT COUNT(*)FROM dbo.VW_PERSONAPACIENTE                    
     WHERE                     
     (@Persona is null or (@Persona =0 )  OR Persona = @Persona)                    
     and (@Paciente is null OR Paciente = @Paciente)                    
     and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                           
     and (@ESTADO is null OR Estado = @ESTADO)                    
     and (@Usuario is null OR Usuario = @Usuario)                    
     AND (EsEmpleado = 'S'))                    
     select @CONTADOR                    
  END         
 ELSE IF(@ACCION = 'LISTARPACPER')                    
 BEGIN                    
 SET @CONTADOR=(      
  SELECT COUNT(*)FROM VW_PERSONAPACIENTE                      
  WHERE(@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')      
  and EsEmpresa = 'N' OR EsEmpresa IS NULL    
  )                    
  SELECT @CONTADOR                    
 END                   
 --select * from SEGURIDADAUTORIZACIONES                    
END                    
/*                    
exec SP_USUARIOS_LISTAR                    
exec [dbo].[SP_USUARIOS_LISTAR] @Usuario=NULL,@Clave=NULL,@USUARIOPERFIL=NULL,@PERSONA=NULL,@NOMBRE=NULL,@ESTADO=NULL,@INICIO=0,@NUMEROFILAS=20,@ACCION='LISTARPAG'                    
*/                    

GO
/****** Object:  StoredProcedure [dbo].[SP_VW_PERSONAPACIENTE_LISTAR]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE OR ALTER PROCEDURE [SP_VW_PERSONAPACIENTE_LISTAR]                        
(                        
 @Persona int,                        
 @NombreCompleto varchar(100),                        
 @TipoDocumento char(1),                        
 @Documento VARCHAR(20),                        
 @EsCliente varchar(1),                        
 @EsEmpleado varchar(1),                        
 @EsOtro varchar(1),                        
 @EsProveedor varchar(1),                        
 @EsPaciente varchar(1),                        
 @EsEmpresa varchar(1),                        
                         
 @FechaNacimiento datetime,                        
 @Sexo char(1),                        
 @EstadoCivil char(1),                        
 @NivelInstruccion char(3),                        
 @CodigoPostal char(3),                        
 @Provincia char(3),                        
 @Departamento char(3),                        
 @TipoMedico int,                        
 @Estado char(1),                        
 @EstadoEmpleado char(1),                        
                         
 @FechaIngreso DATETIME,                        
 @CompaniaSocio char(8),                        
 @CentroCostos varchar(10),--AUX UNIDAD REPLICAC                        
 @AFE VARCHAR(15),                        
 @GradoSalario char(3),                        
 @CodigoCargo int,                        
 @DepartamentoOperacional char(10),                        
 @Paciente char(10),                        
 @HistoriaClinica char(10),                         
 @Usuario VARCHAR(20) ,                         
                         
 @USUARIOPERFIL CHAR(2)=NULL,                          
 /**/                         
 @TipoPersona CHAR(1),                        
 @Nombres VARCHAR(40),                        
 @PersonaAnt CHAR(15),                        
 @Busqueda VARCHAR(100), 
                      
 /**/                        
 @INICIO   int= null,    --AUX: TIPOATENCION                        
 @NUMEROFILAS int = null ,                        
 @ACCION VARCHAR(20)                        
)                              
AS                        
BEGIN                        
 DECLARE @CONTADOR INT                        
                        
 if(@ACCION = 'LISTARPAG')                        
 begin                          
                         
  SELECT *                              
    FROM dbo.VW_PERSONAPACIENTE                        
     WHERE                         
     (@Persona is null or (@Persona =0 )  OR Persona = @Persona)                        
     and (@Paciente is null OR Paciente = @Paciente)                        
     and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                               
     and (@ESTADO is null OR Estado = @ESTADO)                        
     and (@Usuario is null OR Usuario = @Usuario)                        
                          
  SELECT                         
   [Persona]                        
   ,[Nombres]                        
   ,[Busqueda]                        
   ,[PersonaAnt]                           
    ,[ApellidoPaterno]                        
    ,[ApellidoMaterno]                        
    ,[NombreCompleto]                        
    ,[TipoDocumento]                        
    ,[Documento]                        
    ,[CodigoBarras]                        
    ,[EsCliente]                        
    ,[EsEmpleado]                        
    ,[EsOtro]                        
    ,[TipoPersona]                        
    ,[EsProveedor]                        
    ,[FechaNacimiento]                        
    ,[CiudadNacimiento]                        
    ,[Sexo]                        
    ,[Nacionalidad]                        
    ,[EstadoCivil]                        
    ,[NivelInstruccion]                        
    ,[Direccion]                        
    ,[CodigoPostal]                        
    ,[Provincia]           
    ,[Departamento]                        
    ,[Telefono]                        
    ,[DocumentoFiscal]                        
    ,[DocumentoIdentidad]      
    ,[ACCION]                        
    ,[edad]                        
    ,[rangoEtario]                        
    ,[TipoMedico]                        
    ,[Correcion]                        
    ,[EsPaciente]                        
    ,[EsEmpresa]                        
    ,[Pais]                        
    ,[FlagActualizacion]                        
    ,[CuentaMonedaLocal_tmp]                        
    ,[CuentaMonedaExtranjera_tmp]                        
    ,[CorrelativoSCTR]                        
    ,[SeguroDiscamec]                        
    ,[CodDiscamec]                        
    ,[FecIniDiscamec]                        
    ,[FecFinDiscamec]                        
    ,[LugarNacimiento]                        
    ,[Celular]                        
    ,[CelularEmergencia]                        
    ,[ParentescoEmergencia]                        
    ,[DireccionReferencia]                        
    ,[UltimaFechaModif]                        
    ,[TipoPersonaUsuario]                        
    ,[UltimoUsuario]                        
    ,[Estado]                        
    ,[DireccionEmergencia]                        
    ,[TelefonoEmergencia]                        
    ,[BancoMonedaLocal]                
    ,[TipoCuentaLocal]                        
    ,[CuentaMonedaLocal]                        
    ,[BancoMonedaExtranjera]                        
    ,[TipoCuentaExtranjera]                        
    ,[CuentaMonedaExtranjera]                        
    ,[CorreoElectronico]                        
    ,[EnfermedadGraveFlag]                        
    ,[IngresoFechaRegistro]                        
    ,[IngresoAplicacionCodigo]                        
    ,[IngresoUsuario]                        
    ,[PYMEFlag]                        
    ,[TipoPago]                        
    ,[TipoTrabajador]                        
    ,[Religion]                        
    ,[TipoVisa]                        
    ,[VisaFechaInicio]                        
    ,[VisaFechaExpiracion]                        
    ,[CodigoAFP]                        
    ,[NumeroAFP]                        
    ,[BancoCTS]                        
    ,[TipoCuentaCTS]                        
    ,[TipoMonedaCTS]                        
    ,[NumeroCuentaCTS]                        
    ,[EstadoEmpleado]                        
    ,[TipoPlanilla]                        
    ,[FechaIngreso]                        
    ,[FechaUltimaPlanilla]                        
    ,[TipoContrato]                        
    ,[FechaInicioContrato]                        
    ,[FechaFinContrato]                        
    ,[FechaCese]                        
    ,[RazonCese]                        
    ,[Contratista]                        
    ,[CompaniaSocio]                        
    ,[CentroCostos]                        
    ,[AFE]                        
    ,[DeptoOrganizacion]                        
    ,[TipoHorario]                        
    ,[GradoSalario]                        
    ,[Cargo]                        
    ,[Posicion]                        
    ,[NivelAcceso]                        
    ,[FlagIPSSVIDA]                        
    ,[FlagSindicato]                        
    ,[FlagAccTrabajo]                        
    ,[FlagCooperativa]                        
    ,[FlagRetencionJudicial]                        
    ,[FlagReingresos]                        
    ,[FlagComision]                        
    ,[FlagImpuestoRenta]                        
    ,[SueldoActualLocal]                        
    ,[SueldoActualDolar]                        
    ,[SueldoAnteriorLocal]                        
    ,[SueldoAnteriorDolar]                        
    ,[MonedaPago]                        
    ,[TarjetaCredito]                        
    ,[MotivoCese]                        
    ,[DepartamentoOrganizacional]                 
    ,[DepartamentoOperacional]                        
    ,[Perfil]                        
    ,[NivelSalario]                        
    ,[FechaLiquidacion]                        
    ,[FechaReingreso]                        
    ,[UnidadReplicacion]                        
    ,[CodigoCargo]                        
    ,[UltimaFechaPagoVacacion]                        
    ,[Gerencia]                        
    ,[SubGerencia]                        
    ,[RedondeoACuenta]                        
    ,[PlantillaConcepto]                        
    ,[RUCCentroAsistenciaSocial]                        
    ,[Sucursal]                        
    ,[Actividad]                        
    ,[Cliente]                        
    ,[ClienteUnidad]                     
    ,[EmpleadoNivel]                        
    ,[TipoPuesto]                        
    ,[USUARIO]                        
    ,[USUARIOPERFIL]                        
    ,[PERSONAUSUARIO]                        
    ,[CLAVE]                        
    ,[EXPIRARPASSWORDFLAG]                        
    ,[FECHAEXPIRACION]                        
    ,[ULTIMOLOGIN]                        
    ,[Paciente]                        
    ,[TipoPaciente]                        
    ,[Raza]                        
    ,[AreaLaboral]                        
    ,[Ocupacion]                        
    ,[CodigoHC]                        
    ,[CodigoHCAnterior]                        
    ,[CodigoHCSecundario]                        
    ,[TipoAlmacenamiento]                        
    ,[TipoHistoria]                        
    ,[TipoSituacion]                        
    ,[IdUbicacion]                        
    ,[LugarProcedencia]               
    ,[RutaFoto]                        
    ,[EstadoPaciente]                        
    ,[NumeroFile]                        
    ,[Servicio]                        
    ,[Observacion]                        
    ,[IndicadorAsistencia]                        
    ,[CantidadAsistencia]                        
    ,[UbicacionHHCC]                        
    ,[IndicadorMigradoSiteds]                        
    ,[NumeroCaja]                        
    ,[IndicadorCodigoBarras]                        
    ,[IDPACIENTE_OK]                        
    ,[CodigoAsegurado]                        
    ,[NumeroPoliza]                        
    ,[NumeroCertificado]                        
    ,[CodigoProducto]                        
    ,[CodigoPlan]                        
    ,[TipoParentesco]                        
    ,[CodigoBeneficio]                        
    ,[Situacion]                        
    ,[TomoActual]                        
    ,[IndicadorHistoriaFisica]                        
    ,[DescripcionHistoria] 

  FROM (                          
    SELECT VW_PERSONAPACIENTE.*,                                      
 @CONTADOR AS Contador,                        
     ROW_NUMBER() OVER (ORDER BY Persona ASC ) AS RowNumber                            
  FROM dbo.VW_PERSONAPACIENTE                        
     WHERE                         
     (@Persona is null or (@Persona =0 )  OR Persona = @Persona)                        
     and (@Paciente is null OR Paciente = @Paciente)                        
     and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                               
     and (@ESTADO is null OR Estado = @ESTADO)                        
     and (@Usuario is null OR Usuario = @Usuario)                        
     ) AS LISTADO                        
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR                          
            RowNumber BETWEEN @Inicio  AND @NumeroFilas    
			
	
 end  
 ELSE
 if(@ACCION = 'LISTARPAGTRIAJE')                        
 begin                          
                         
  SELECT *                              
    FROM dbo.VW_PERSONAPACIENTETRIAJE                        
     WHERE                         
     (@Persona is null or (@Persona =0 )  OR Persona = @Persona)                        
     and (@Paciente is null OR Paciente = @Paciente)                        
     and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                               
     and (@ESTADO is null OR Estado = @ESTADO)                        
     and (@Usuario is null OR Usuario = @Usuario)    
	 and (@PersonaAnt is null or PersonaAnt=@PersonaAnt ) -- CODIGO OA
	  and TomoActual=1 -- TIPO ATENCION
	  and IndicadorHistoriaFisica=1 -- ESPECIALIDAD
	   order by IngresoFechaRegistro desc
                          
  SELECT                         
   [Persona]                        
   ,[Nombres]                        
   ,[Busqueda]                        
   ,[PersonaAnt]                           
    ,[ApellidoPaterno]                        
    ,[ApellidoMaterno]                        
    ,[NombreCompleto]                        
    ,[TipoDocumento]                        
    ,[Documento]                        
    ,[CodigoBarras]                        
    ,[EsCliente]                        
    ,[EsEmpleado]                        
    ,[EsOtro]                        
    ,[TipoPersona]                        
    ,[EsProveedor]                        
    ,[FechaNacimiento]                        
    ,[CiudadNacimiento]                        
    ,[Sexo]                        
    ,[Nacionalidad]                        
    ,[EstadoCivil]                        
    ,[NivelInstruccion]                        
    ,[Direccion]                        
    ,[CodigoPostal]                        
    ,[Provincia]           
    ,[Departamento]                        
    ,[Telefono]                        
    ,[DocumentoFiscal]                        
    ,[DocumentoIdentidad]      
    ,[ACCION]                        
    ,[edad]                        
    ,[rangoEtario]                        
    ,[TipoMedico]                        
    ,[Correcion]                        
    ,[EsPaciente]                        
    ,[EsEmpresa]                        
    ,[Pais]                        
    ,[FlagActualizacion]                        
    ,[CuentaMonedaLocal_tmp]                        
    ,[CuentaMonedaExtranjera_tmp]                        
    ,[CorrelativoSCTR]                        
    ,[SeguroDiscamec]                        
    ,[CodDiscamec]                        
    ,[FecIniDiscamec]                        
    ,[FecFinDiscamec]                        
    ,[LugarNacimiento]                        
    ,[Celular]                        
    ,[CelularEmergencia]                        
    ,[ParentescoEmergencia]                        
    ,[DireccionReferencia]                        
    ,[UltimaFechaModif]                        
    ,[TipoPersonaUsuario]                        
    ,[UltimoUsuario]                        
    ,[Estado]                        
    ,[DireccionEmergencia]                        
    ,[TelefonoEmergencia]                        
    ,[BancoMonedaLocal]                
    ,[TipoCuentaLocal]                        
    ,[CuentaMonedaLocal]                        
    ,[BancoMonedaExtranjera]                        
    ,[TipoCuentaExtranjera]                        
    ,[CuentaMonedaExtranjera]                        
    ,[CorreoElectronico]                        
    ,[EnfermedadGraveFlag]                        
    ,[IngresoFechaRegistro]                        
    ,[IngresoAplicacionCodigo]                        
    ,[IngresoUsuario]                        
    ,[PYMEFlag]                        
    ,[TipoPago]                        
    ,[TipoTrabajador]                        
    ,[Religion]                        
    ,[TipoVisa]                        
    ,[VisaFechaInicio]                        
    ,[VisaFechaExpiracion]                        
    ,[CodigoAFP]                        
    ,[NumeroAFP]                        
    ,[BancoCTS]                        
    ,[TipoCuentaCTS]                        
    ,[TipoMonedaCTS]                        
    ,[NumeroCuentaCTS]                        
    ,[EstadoEmpleado]                        
    ,[TipoPlanilla]                        
    ,[FechaIngreso]                        
    ,[FechaUltimaPlanilla]                        
    ,[TipoContrato]                        
    ,[FechaInicioContrato]                        
    ,[FechaFinContrato]                        
    ,[FechaCese]                        
    ,[RazonCese]                        
    ,[Contratista]                        
    ,[CompaniaSocio]                        
    ,[CentroCostos]                        
    ,[AFE]                        
    ,[DeptoOrganizacion]                        
    ,[TipoHorario]                        
    ,[GradoSalario]                        
    ,[Cargo]                        
    ,[Posicion]                        
    ,[NivelAcceso]                        
    ,[FlagIPSSVIDA]                        
    ,[FlagSindicato]                        
    ,[FlagAccTrabajo]                        
    ,[FlagCooperativa]                        
    ,[FlagRetencionJudicial]                        
    ,[FlagReingresos]                        
    ,[FlagComision]                        
    ,[FlagImpuestoRenta]                        
    ,[SueldoActualLocal]                        
    ,[SueldoActualDolar]                        
    ,[SueldoAnteriorLocal]                        
    ,[SueldoAnteriorDolar]                        
    ,[MonedaPago]                        
    ,[TarjetaCredito]                        
    ,[MotivoCese]                        
    ,[DepartamentoOrganizacional]                 
    ,[DepartamentoOperacional]                        
    ,[Perfil]                        
    ,[NivelSalario]                        
    ,[FechaLiquidacion]                        
    ,[FechaReingreso]                        
    ,[UnidadReplicacion]                        
    ,[CodigoCargo]                        
    ,[UltimaFechaPagoVacacion]                        
    ,[Gerencia]                        
    ,[SubGerencia]                        
    ,[RedondeoACuenta]                        
    ,[PlantillaConcepto]                        
    ,[RUCCentroAsistenciaSocial]                        
    ,[Sucursal]                        
    ,[Actividad]                        
    ,[Cliente]                        
    ,[ClienteUnidad]                     
    ,[EmpleadoNivel]                        
    ,[TipoPuesto]                        
    ,[USUARIO]                        
    ,[USUARIOPERFIL]                        
    ,[PERSONAUSUARIO]                        
    ,[CLAVE]                        
    ,[EXPIRARPASSWORDFLAG]                        
    ,[FECHAEXPIRACION]                        
    ,[ULTIMOLOGIN]                        
    ,[Paciente]                        
    ,[TipoPaciente]                        
    ,[Raza]                        
    ,[AreaLaboral]                        
    ,[Ocupacion]                        
    ,[CodigoHC]                        
    ,[CodigoHCAnterior]                        
    ,[CodigoHCSecundario]                        
    ,[TipoAlmacenamiento]                        
    ,[TipoHistoria]                        
    ,[TipoSituacion]                        
    ,[IdUbicacion]                        
    ,[LugarProcedencia]               
    ,[RutaFoto]                        
    ,[EstadoPaciente]                        
    ,[NumeroFile]                        
    ,[Servicio]                        
    ,[Observacion]                        
    ,[IndicadorAsistencia]                        
    ,[CantidadAsistencia]                        
    ,[UbicacionHHCC]                        
    ,[IndicadorMigradoSiteds]                        
    ,[NumeroCaja]                        
    ,[IndicadorCodigoBarras]   
	 ,[PersonaAnt]                          
    ,[CodigoAsegurado]                        
    ,[NumeroPoliza]                        
    ,[NumeroCertificado]                        
    ,[CodigoProducto]                        
    ,[CodigoPlan]                        
    ,[TipoParentesco]                        
    ,[CodigoBeneficio]                        
    ,[Situacion]                        
    ,[TomoActual]                        
    ,[IndicadorHistoriaFisica]                        
    ,[DescripcionHistoria] 
	

  FROM (                          
    SELECT VW_PERSONAPACIENTETRIAJE.*,                                      
 @CONTADOR AS Contador,                        
     ROW_NUMBER() OVER (ORDER BY Persona ASC ) AS RowNumber                            
  FROM dbo.VW_PERSONAPACIENTETRIAJE                        
     WHERE                         
     (@Persona is null or (@Persona =0 )  OR Persona = @Persona)                        
     and (@Paciente is null OR Paciente = @Paciente)                        
     and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                               
     and (@ESTADO is null OR Estado = @ESTADO)                        
     and (@Usuario is null OR Usuario = @Usuario) 
	 and (@PersonaAnt is null or PersonaAnt=@PersonaAnt )
	  and TomoActual=1
	  and IndicadorHistoriaFisica=1
     ) AS LISTADO                        
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR                          
            RowNumber BETWEEN @Inicio  AND @NumeroFilas    
			 order by IngresoFechaRegistro desc
		
 end

 else                        
 if(@ACCION = 'LISTAR')                        
 begin                        
                          
  SELECT *                            
  FROM dbo.VW_PERSONAPACIENTE                        
     WHERE                         
     (@Persona is null or (@Persona =0 )  OR Persona = @Persona)                        
     and (@Paciente is null OR Paciente = @Paciente)                        
     and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                               
     and (@ESTADO is null OR Estado = @ESTADO)                        
     and (@Usuario is null OR Usuario = @Usuario)                        
                             
                       
 end                         
 ELSE                        
 if(@ACCION = 'LISTARPORID')                        
 begin           
	/**************************************/
	/****PARA OBTENER LA OPCION PADRE****/
	declare @TIPOTRABAJADOR_AUX varchar(4) =null
	declare @OPCIONID_ARBOL varchar(100)=null
	declare @OPCIONID_ARBOL_INIT varchar(100)=null
	declare @OPCIONDESC_ARBOL varchar(200) =null
			
	---OBTENER TIPO TRABAJADOR ACTUAL
	select @TIPOTRABAJADOR_AUX = (case when Empleado = -1 then '08' else TipoTrabajadorSalud  end) 	 
	from EMPLEADOMAST where Empleado = @Persona
	
	
	---OBTENER OCIÓN DE ARBOL DE PROCESOS (solo se permite una a la vez)
	select TOP 1 @OPCIONID_ARBOL = convert(varchar,IdOpcion),
    @OPCIONDESC_ARBOL = Descripcion 
    from SG_Opcion                         
     where (IdOpcionPadre = 3000 )  --OBS: ID  MACROPROCESO                        
     and ( ( (idTipoAtencion is null  or idTipoAtencion = 0 ) /* AND (@INICIO is null or @INICIO =0)*/ ) 
			or ( idTipoAtencion = @INICIO  and @INICIO is Not null and @INICIO <> 0) 
		  )  --OBS AUX TIPO ATENCION 
     and (TipoTrabajador = @TIPOTRABAJADOR_AUX)
     and (Estado = 2)
	 order by Orden  asc   
	    
	/********SECCIÓN PARA OBTENER OPCIÓN ID POR DEFECTO (PRIMERA EN CARGARSE - )*****************/
	/********se deberá obtener de un parámetro o cargar con una consulta más extensa**************/
	if(@OPCIONID_ARBOL = '3001') --CONSULTA EXTERNA
	begin
		set @OPCIONID_ARBOL_INIT = '3003';
	end 
	else if(@OPCIONID_ARBOL = '3090')--HOSPITALIZACIÓN
	begin
		set @OPCIONID_ARBOL_INIT = '3092';
	end 	
	else if(@OPCIONID_ARBOL = '3130')--EMERGENCIA
	begin
		set @OPCIONID_ARBOL_INIT = '3135';
	end 	
	else if(@OPCIONID_ARBOL = '3168')--CIRUGIA
	begin
		set @OPCIONID_ARBOL_INIT = '3170';
	end 		
	else if(@OPCIONID_ARBOL = '3206')--PAE (PROCESO ASISTENCIAL DE ENFERMERIA)
	begin
		set @OPCIONID_ARBOL_INIT = 1;
	end 	
	else if(@OPCIONID_ARBOL = '3247')-- PAO  (PROCESO ASISTENCIAL DE OBSTETRICIA)
	begin
		set @OPCIONID_ARBOL_INIT = 1;
	end 
	else if(@OPCIONID_ARBOL = '3288')-- APOYO AL DIAGNOSTICO
	begin
		set @OPCIONID_ARBOL_INIT = 1;
	end 
	else if(@OPCIONID_ARBOL = '3352')-- CONSULTA CLÍNICA
	begin
		set @OPCIONID_ARBOL_INIT = 1;
	end 
	else if(@OPCIONID_ARBOL = '3437')-- GENERAR PEDIDO
	begin
		set @OPCIONID_ARBOL_INIT = '3438';
	end		
	else if(@OPCIONID_ARBOL = '3440')-- PROGRAMAR KARDEX
	begin
		set @OPCIONID_ARBOL_INIT = '3441';
	end	
		
     
	/**************************************/                 			
	/**************************************/                 			
	          
  ---DIRECCIONREFERENCIA Y CCOSTO USADO AXULIARMENTE; para Establecimiento y Periodo                        
  SELECT                         
   [Persona]                           
   ,[Nombres]                        
   ,[Busqueda]                        
   ,[PersonaAnt]                         
     ,[ApellidoPaterno]                        
     ,[ApellidoMaterno]                        
     ,[NombreCompleto]               
     ,[TipoDocumento]                        
     ,[Documento]                        
     ,[CodigoBarras]                        
     ,[EsCliente]                        
     ,[EsEmpleado]                        
     ,[EsOtro]                        
     ,[TipoPersona]                        
     ,[EsProveedor]                        
     ,[FechaNacimiento]                        
     ,[CiudadNacimiento]                        
     ,[Sexo]                        
     ,[Nacionalidad]                        
     ,[EstadoCivil]                        
     ,[NivelInstruccion]                        
     ,[Direccion]                       ,[CodigoPostal]                        
     ,[Provincia]                        
     ,[Departamento]                        
     ,[Telefono]                        
     ,[DocumentoFiscal]                        
     ,[DocumentoIdentidad]                        
     ,[ACCION]                        
     ,[edad]                        
     ,[rangoEtario]                        
     ,[TipoMedico]                        
     ,[Correcion]                        
     ,[EsPaciente]                        
     ,[EsEmpresa]                        
     ,[Pais]                        
     ,[FlagActualizacion]                        
     ,[CuentaMonedaLocal_tmp]                        
     ,[CuentaMonedaExtranjera_tmp]                        
     ,[CorrelativoSCTR]                        
     ,[SeguroDiscamec]                        
     ,[CodDiscamec]                        
     ,[FecIniDiscamec]                        
     ,[FecFinDiscamec]                        
     ,[LugarNacimiento]                        
     ,[Celular]                        
     ,[CelularEmergencia]                        
     ,[ParentescoEmergencia]                        
     ,isnull((select top 1 Nombre from dbo.CM_CO_Establecimiento where IdEstablecimiento =convert(int,@AFE))            
  ,'No Definido') as  DireccionReferencia --AUX                      
     ,[UltimaFechaModif]                        
     ,[TipoPersonaUsuario]                        
     ,[UltimoUsuario]                        
     ,[Estado]                   
     ,[DireccionEmergencia]                        
     ,[TelefonoEmergencia]                        
     ,[BancoMonedaLocal]                        
     ,[TipoCuentaLocal]                        
     ,[CuentaMonedaLocal]                        
     ,[BancoMonedaExtranjera]                        
     ,[TipoCuentaExtranjera]                        
     ,[CuentaMonedaExtranjera]                        
     ,[CorreoElectronico]                        
     ,[EnfermedadGraveFlag]                        
     ,[IngresoFechaRegistro]                        
     ,[IngresoAplicacionCodigo]                        
     ,[IngresoUsuario]                        
     ,[PYMEFlag]                        
     ,[TipoPago]   
     ,vwPersona.[TipoTrabajador]                        
     ,[Religion]                        
     ,[TipoVisa]                        
     ,[VisaFechaInicio]                        
     ,[VisaFechaExpiracion]                        
     ,[CodigoAFP]                        
     ,[NumeroAFP]                        
     ,[BancoCTS]                        
     ,[TipoCuentaCTS]                        
     ,[TipoMonedaCTS]                        
     ,[NumeroCuentaCTS]                        
     ,[EstadoEmpleado]                        
     ,[TipoPlanilla]                        
     ,[FechaIngreso]                        
     ,[FechaUltimaPlanilla]                        
     ,[TipoContrato]                        
     ,[FechaInicioContrato]                        
     ,[FechaFinContrato]                        
     ,[FechaCese]                        
     ,[RazonCese]                        
     ,[Contratista]                        
     ,CompaniaSocio                        
    -- ,isnull(CentroCostos,substring(CONVERT(varchar,GETDATE(),112),1,6)) as  CentroCostos --AUX                        
    ,CONVERT(varchar,GETDATE(),112)as  CentroCostos        
                    ,[AFE]                        
     ,[DeptoOrganizacion]                        
     ,[TipoHorario]                        
     ,[GradoSalario]                        
     ,[Cargo]                        
     ,[Posicion]                        
     ,[NivelAcceso]                      
     ,[FlagIPSSVIDA]                        
     ,[FlagSindicato]                        
     ,[FlagAccTrabajo]                        
     ,[FlagCooperativa]                        
     ,[FlagRetencionJudicial]                        
     ,[FlagReingresos]                        
     ,[FlagComision]                        
     ,[FlagImpuestoRenta]                        
     ,[SueldoActualLocal]                        
     ,[SueldoActualDolar]                        
     ,[SueldoAnteriorLocal]                        
     ,[SueldoAnteriorDolar]                        
     ,[MonedaPago]                        
     ,[TarjetaCredito]                        
     ,[MotivoCese]                        
     ,[DepartamentoOrganizacional]                        
     ,[DepartamentoOperacional]                        
     ,[Perfil]                        
     ,[NivelSalario]                        
     ,[FechaLiquidacion]                        
     ,[FechaReingreso]                        
     ,[UnidadReplicacion]                        
     ,[CodigoCargo]                        
     ,[UltimaFechaPagoVacacion]                        
     ,[Gerencia]                        
     ,[SubGerencia]                        
     ,[RedondeoACuenta]                        
     ,[PlantillaConcepto]                        
     ,[RUCCentroAsistenciaSocial]                        
     ,[Sucursal]                        
     ,[Actividad]                        
     ,[Cliente]                        
     ,[ClienteUnidad]                        
     ,[EmpleadoNivel]                        
     ,[TipoPuesto]                        
                            
     ,(select top 1 CodigoAgente from SG_Agente as ag                        
      where ag.IdEmpleado = Persona) as USUARIO                        
     ,[USUARIOPERFIL]                      
     ,[PERSONAUSUARIO]                        
     ,[CLAVE]                        
     ,[EXPIRARPASSWORDFLAG]                        
     ,[FECHAEXPIRACION]                        
    ,[ULTIMOLOGIN]                        
    ,[Paciente]                        
   ,[TipoPaciente]                        
    ,[Raza]                        
    ,[AreaLaboral]                        
    ,[Ocupacion]                        
    ,[CodigoHC]                        
    ,[CodigoHCAnterior]                        
    ,[CodigoHCSecundario]                        
    ,[TipoAlmacenamiento]                        
    ,[TipoHistoria]                        
    ,[TipoSituacion]               
    ,[IdUbicacion]                        
    ,[LugarProcedencia]                        
    ,[RutaFoto]                        
    ,[EstadoPaciente]                        
    ,[NumeroFile]                        
    /******************************************/                        
   ,@OPCIONID_ARBOL as Servicio                        
   ,@OPCIONDESC_ARBOL as Observacion                        
    --,[Servicio]                        
    --,[Observacion]                        
    ,[IndicadorAsistencia]                        
    ,[CantidadAsistencia]                        
    ,[UbicacionHHCC]                        
    ,[IndicadorMigradoSiteds]                        
    ,[NumeroCaja]                        
    ,[IndicadorCodigoBarras]                        
    ,[IDPACIENTE_OK]                        
    ,[CodigoAsegurado]               
    ,[NumeroPoliza]                        
    ,[NumeroCertificado]                        
    ,[CodigoProducto]                        
    ,@OPCIONID_ARBOL_INIT as CodigoPlan --AUX PARA CARGAR ID OPCIÓN DE INICIO POR DEFECTO
 ,[TipoParentesco]                        
    --,[CodigoBeneficio]            
    ,( select SS_TipoTrabajador.DescripcionLocal           
    from EMPLEADOMAST           
    left join SS_TipoTrabajador on (SS_TipoTrabajador.TipoTrabajador = EMPLEADOMAST.TipoTrabajadorSalud)          
    where Empleado = @Persona )AS CodigoBeneficio        
    ,[Situacion]                        
    ,[TomoActual]                        
    ,vwPersona.[IndicadorHistoriaFisica]                        
    ,DB_NAME() as DescripcionHistoria
                         
  FROM dbo.VW_PERSONAPACIENTE as vwPersona                                                                       
     WHERE                         
  (Persona = @Persona)                                                       
                             
 end  
 ELSE
 if(@ACCION = 'LISTARPORIDMED')                        
 begin           
	/**************************************/
	/****PARA OBTENER LA OPCION PADRE****/
	declare @TIPOTRABAJADOR_AUXX varchar(4) =null
	declare @OPCIONID_ARBOLL varchar(100)=null
	declare @OPCIONID_ARBOLL_INIT varchar(100)=null
	declare @OPCIONDESC_ARBOLL varchar(200) =null
			
	---OBTENER TIPO TRABAJADOR ACTUAL
	select @TIPOTRABAJADOR_AUXX = (case when Empleado = -1 then '08' else TipoTrabajadorSalud  end) 	 
	from EMPLEADOMAST where Empleado = @Persona			
		
	---OBTENER OCIÓN DE ARBOL DE PROCESOS (solo se permite una a la vez)
	select TOP 1 @OPCIONID_ARBOLL = convert(varchar,IdOpcion),
    @OPCIONDESC_ARBOLL = Descripcion 
    from SG_Opcion                         
     where (IdOpcionPadre = 3000 )  --OBS: ID  MACROPROCESO                        
    
     and (TipoTrabajador = @TIPOTRABAJADOR_AUXX)
     and (Estado = 2)
	 order by Orden  asc   
	    
	/********SECCIÓN PARA OBTENER OPCIÓN ID POR DEFECTO (PRIMERA EN CARGARSE - )*****************/
	/********se deberá obtener de un parámetro o cargar con una consulta más extensa**************/
	if(@OPCIONID_ARBOLL = '3446')
	begin
		set @OPCIONID_ARBOLL_INIT = '3448';
	end 
	     
	/**************************************/                 			
	/**************************************/                 			
	          
  ---DIRECCIONREFERENCIA Y CCOSTO USADO AXULIARMENTE; para Establecimiento y Periodo                        
  SELECT                         
   [Persona]                           
   ,[Nombres]                        
   ,[Busqueda]                        
   ,[PersonaAnt]                         
     ,[ApellidoPaterno]                        
     ,[ApellidoMaterno]                        
     ,[NombreCompleto]               
     ,[TipoDocumento]                        
     ,[Documento]                        
     ,[CodigoBarras]                        
     ,[EsCliente]                        
     ,[EsEmpleado]                        
     ,[EsOtro]                        
     ,[TipoPersona]                        
     ,[EsProveedor]                        
     ,[FechaNacimiento]                        
     ,[CiudadNacimiento]                        
     ,[Sexo]                        
     ,[Nacionalidad]                        
     ,[EstadoCivil]                        
     ,[NivelInstruccion]                        
     ,[Direccion]                       ,[CodigoPostal]                        
     ,[Provincia]                        
     ,[Departamento]                        
     ,[Telefono]                        
     ,[DocumentoFiscal]                        
     ,[DocumentoIdentidad]                        
     ,[ACCION]                        
     ,[edad]                        
     ,[rangoEtario]                        
     ,[TipoMedico]                        
     ,[Correcion]                        
     ,[EsPaciente]                        
     ,[EsEmpresa]                        
     ,[Pais]                        
     ,[FlagActualizacion]                        
     ,[CuentaMonedaLocal_tmp]                        
     ,[CuentaMonedaExtranjera_tmp]                        
     ,[CorrelativoSCTR]                        
     ,[SeguroDiscamec]                        
     ,[CodDiscamec]                        
     ,[FecIniDiscamec]                        
     ,[FecFinDiscamec]                        
     ,[LugarNacimiento]                        
     ,[Celular]                        
     ,[CelularEmergencia]                        
     ,[ParentescoEmergencia]                        
     ,isnull((select top 1 Nombre from dbo.CM_CO_Establecimiento where IdEstablecimiento =convert(int,@AFE))            
  ,'No Definido') as  DireccionReferencia --AUX                      
     ,[UltimaFechaModif]                        
     ,[TipoPersonaUsuario]                        
     ,[UltimoUsuario]                        
     ,[Estado]                   
     ,[DireccionEmergencia]                        
     ,[TelefonoEmergencia]                        
     ,[BancoMonedaLocal]                        
     ,[TipoCuentaLocal]                        
     ,[CuentaMonedaLocal]                        
     ,[BancoMonedaExtranjera]                        
     ,[TipoCuentaExtranjera]                        
     ,[CuentaMonedaExtranjera]                        
     ,[CorreoElectronico]                        
     ,[EnfermedadGraveFlag]                        
     ,[IngresoFechaRegistro]                        
     ,[IngresoAplicacionCodigo]                        
     ,[IngresoUsuario]                        
     ,[PYMEFlag]                        
     ,[TipoPago]   
     ,vwPersona.[TipoTrabajador]                        
     ,[Religion]                        
     ,[TipoVisa]                        
     ,[VisaFechaInicio]                        
     ,[VisaFechaExpiracion]                        
     ,[CodigoAFP]                        
     ,[NumeroAFP]                        
     ,[BancoCTS]                        
     ,[TipoCuentaCTS]                        
     ,[TipoMonedaCTS]                        
     ,[NumeroCuentaCTS]                        
     ,[EstadoEmpleado]                        
     ,[TipoPlanilla]                        
     ,[FechaIngreso]                        
     ,[FechaUltimaPlanilla]                        
     ,[TipoContrato]                        
     ,[FechaInicioContrato]                        
     ,[FechaFinContrato]                        
     ,[FechaCese]                        
     ,[RazonCese]                        
     ,[Contratista]                        
     ,CompaniaSocio                        
    -- ,isnull(CentroCostos,substring(CONVERT(varchar,GETDATE(),112),1,6)) as  CentroCostos --AUX                        
    ,CONVERT(varchar,GETDATE(),112)as  CentroCostos        
     ,[AFE]                        
     ,[DeptoOrganizacion]                        
     ,[TipoHorario]                        
     ,[GradoSalario]                        
     ,[Cargo]                        
     ,[Posicion]                        
     ,[NivelAcceso]                      
     ,[FlagIPSSVIDA]                        
     ,[FlagSindicato]                        
     ,[FlagAccTrabajo]                        
     ,[FlagCooperativa]                        
     ,[FlagRetencionJudicial]                        
     ,[FlagReingresos]                        
     ,[FlagComision]                        
     ,[FlagImpuestoRenta]                        
     ,[SueldoActualLocal]                        
     ,[SueldoActualDolar]                        
     ,[SueldoAnteriorLocal]                        
     ,[SueldoAnteriorDolar]                        
     ,[MonedaPago]                        
     ,[TarjetaCredito]                        
     ,[MotivoCese]                        
     ,[DepartamentoOrganizacional]                        
     ,[DepartamentoOperacional]                        
     ,[Perfil]                        
     ,[NivelSalario]                        
     ,[FechaLiquidacion]                        
     ,[FechaReingreso]                        
     ,[UnidadReplicacion]                        
     ,[CodigoCargo]                        
     ,[UltimaFechaPagoVacacion]                        
     ,[Gerencia]                        
     ,[SubGerencia]                        
     ,[RedondeoACuenta]                        
     ,[PlantillaConcepto]                        
     ,[RUCCentroAsistenciaSocial]                        
     ,[Sucursal]                        
     ,[Actividad]                        
     ,[Cliente]                        
     ,[ClienteUnidad]                        
     ,[EmpleadoNivel]                        
     ,[TipoPuesto]                        
                            
     ,(select top 1 CodigoAgente from SG_Agente as ag                        
      where ag.IdEmpleado = Persona) as USUARIO                        
     ,[USUARIOPERFIL]                      
     ,[PERSONAUSUARIO]                        
     ,[CLAVE]                        
     ,[EXPIRARPASSWORDFLAG]                        
     ,[FECHAEXPIRACION]                        
    ,[ULTIMOLOGIN]                        
    ,[Paciente]                        
   ,[TipoPaciente]                        
    ,[Raza]                        
    ,[AreaLaboral]                        
    ,[Ocupacion]                        
    ,[CodigoHC]                        
    ,[CodigoHCAnterior]                        
    ,[CodigoHCSecundario]                        
    ,[TipoAlmacenamiento]                        
    ,[TipoHistoria]                        
    ,[TipoSituacion]               
    ,[IdUbicacion]                        
    ,[LugarProcedencia]                        
    ,[RutaFoto]                        
    ,[EstadoPaciente]                        
    ,[NumeroFile]                        
    /******************************************/                        
   ,'3446' as Servicio                        
   ,'GENERAR PEDIDO' as Observacion                        
    --,[Servicio]                        
    --,[Observacion]                        
    ,[IndicadorAsistencia]                        
    ,[CantidadAsistencia]                        
    ,[UbicacionHHCC]                        
    ,[IndicadorMigradoSiteds]                        
    ,[NumeroCaja]                        
    ,[IndicadorCodigoBarras]                        
    ,[IDPACIENTE_OK]                        
    ,[CodigoAsegurado]               
    ,[NumeroPoliza]                        
    ,[NumeroCertificado]                        
    ,[CodigoProducto]                        
    ,'3448' as CodigoPlan --AUX PARA CARGAR ID OPCIÓN DE INICIO POR DEFECTO
 ,[TipoParentesco]                        
    --,[CodigoBeneficio]            
    ,( select SS_TipoTrabajador.DescripcionLocal           
    from EMPLEADOMAST           
    left join SS_TipoTrabajador on (SS_TipoTrabajador.TipoTrabajador = EMPLEADOMAST.TipoTrabajadorSalud)          
    where Empleado = @Persona )AS CodigoBeneficio        
    ,[Situacion]                        
    ,[TomoActual]                        
    ,vwPersona.[IndicadorHistoriaFisica]                        
    ,DB_NAME() as DescripcionHistoria
                         
  FROM dbo.VW_PERSONAPACIENTE as vwPersona                                               
                          
     WHERE                         
  (Persona = @Persona)                        
                       
 end 
 
 ELSE
 if(@ACCION = 'LISTARIDDEVOLUCION')                        
 begin           
	/**************************************/
	/****PARA OBTENER LA OPCION PADRE****/
	declare @TIPO_TRABAJADOR_AUX varchar(4) =null
	declare @OPCIID_ARBOL varchar(100)=null
	declare @OPCIID_ARBOL_INITT varchar(100)=null
	declare @OPCIDESC_ARBOL varchar(200) =null
			
	---OBTENER TIPO TRABAJADOR ACTUAL
    select @TIPO_TRABAJADOR_AUX = (case when Empleado = -1 then '08' else TipoTrabajadorSalud  end) 	 
	from EMPLEADOMAST where Empleado = @Persona
		
	---OBTENER OPCIÓN DE ARBOL DE PROCESOS (solo se permite una a la vez)
	select TOP 1 @OPCIONID_ARBOLL = convert(varchar,IdOpcion),
    @OPCIONDESC_ARBOLL = Descripcion 
    from SG_Opcion                         
     where (IdOpcionPadre = 3000 )  --OBS: ID  MACROPROCESO                        
    
     and (TipoTrabajador = @TIPO_TRABAJADOR_AUX)
     and (Estado = 2)
	 order by Orden  asc   
	    
	/********SECCIÓN PARA OBTENER OPCIÓN ID POR DEFECTO (PRIMERA EN CARGARSE - )*****************/
	/********se deberá obtener de un parámetro o cargar con una consulta más extensa**************/
	if(@OPCIID_ARBOL = '3465')
	begin
		set @OPCIID_ARBOL_INITT = '3466';
	end 
	     
	/**************************************/                 			
	/**************************************/                 			
	          
  ---DIRECCIONREFERENCIA Y CCOSTO USADO AXULIARMENTE; para Establecimiento y Periodo                        
  SELECT                         
   [Persona]                           
   ,[Nombres]                        
   ,[Busqueda]                        
   ,[PersonaAnt]                         
     ,[ApellidoPaterno]                        
     ,[ApellidoMaterno]                        
     ,[NombreCompleto]               
     ,[TipoDocumento]                        
     ,[Documento]                        
     ,[CodigoBarras]                        
     ,[EsCliente]                        
     ,[EsEmpleado]                        
     ,[EsOtro]                        
     ,[TipoPersona]                        
     ,[EsProveedor]                        
     ,[FechaNacimiento]                        
     ,[CiudadNacimiento]                        
     ,[Sexo]                        
     ,[Nacionalidad]                        
     ,[EstadoCivil]                        
     ,[NivelInstruccion]                        
     ,[Direccion]                       ,[CodigoPostal]                        
     ,[Provincia]                        
     ,[Departamento]                        
     ,[Telefono]                        
     ,[DocumentoFiscal]                        
     ,[DocumentoIdentidad]                        
     ,[ACCION]                        
     ,[edad]                        
     ,[rangoEtario]                        
     ,[TipoMedico]                        
     ,[Correcion]                        
     ,[EsPaciente]                        
     ,[EsEmpresa]                        
     ,[Pais]                        
     ,[FlagActualizacion]                        
     ,[CuentaMonedaLocal_tmp]                        
     ,[CuentaMonedaExtranjera_tmp]                        
     ,[CorrelativoSCTR]                        
     ,[SeguroDiscamec]                        
     ,[CodDiscamec]                        
     ,[FecIniDiscamec]                        
     ,[FecFinDiscamec]                        
     ,[LugarNacimiento]                        
     ,[Celular]                        
     ,[CelularEmergencia]                        
     ,[ParentescoEmergencia]                        
     ,isnull((select top 1 Nombre from dbo.CM_CO_Establecimiento where IdEstablecimiento =convert(int,@AFE))            
  ,'No Definido') as  DireccionReferencia --AUX                      
     ,[UltimaFechaModif]                        
     ,[TipoPersonaUsuario]                        
     ,[UltimoUsuario]                        
     ,[Estado]                   
     ,[DireccionEmergencia]                        
     ,[TelefonoEmergencia]                        
     ,[BancoMonedaLocal]                        
     ,[TipoCuentaLocal]                        
     ,[CuentaMonedaLocal]                        
     ,[BancoMonedaExtranjera]                        
     ,[TipoCuentaExtranjera]                        
     ,[CuentaMonedaExtranjera]                        
     ,[CorreoElectronico]                        
     ,[EnfermedadGraveFlag]                        
     ,[IngresoFechaRegistro]                        
     ,[IngresoAplicacionCodigo]                        
     ,[IngresoUsuario]                        
     ,[PYMEFlag]                        
     ,[TipoPago]   
     ,vwPersona.[TipoTrabajador]                        
     ,[Religion]                        
     ,[TipoVisa]                        
     ,[VisaFechaInicio]                        
     ,[VisaFechaExpiracion]                        
     ,[CodigoAFP]                        
     ,[NumeroAFP]                        
     ,[BancoCTS]                        
     ,[TipoCuentaCTS]                        
     ,[TipoMonedaCTS]                        
     ,[NumeroCuentaCTS]                        
     ,[EstadoEmpleado]                        
     ,[TipoPlanilla]                        
     ,[FechaIngreso]                        
     ,[FechaUltimaPlanilla]                        
     ,[TipoContrato]                        
     ,[FechaInicioContrato]                        
     ,[FechaFinContrato]                        
     ,[FechaCese]                        
     ,[RazonCese]                        
     ,[Contratista]                        
     ,CompaniaSocio                        
    -- ,isnull(CentroCostos,substring(CONVERT(varchar,GETDATE(),112),1,6)) as  CentroCostos --AUX                        
    ,CONVERT(varchar,GETDATE(),112)as  CentroCostos        
    ,[AFE]                        
     ,[DeptoOrganizacion]                        
     ,[TipoHorario]                        
     ,[GradoSalario]                        
     ,[Cargo]                        
     ,[Posicion]                        
     ,[NivelAcceso]                      
     ,[FlagIPSSVIDA]                        
     ,[FlagSindicato]                        
     ,[FlagAccTrabajo]                        
     ,[FlagCooperativa]                        
     ,[FlagRetencionJudicial]                        
     ,[FlagReingresos]                        
     ,[FlagComision]                        
     ,[FlagImpuestoRenta]                        
     ,[SueldoActualLocal]                        
     ,[SueldoActualDolar]                        
     ,[SueldoAnteriorLocal]                        
     ,[SueldoAnteriorDolar]                        
     ,[MonedaPago]                        
     ,[TarjetaCredito]                        
     ,[MotivoCese]                        
     ,[DepartamentoOrganizacional]                        
     ,[DepartamentoOperacional]                        
     ,[Perfil]                        
     ,[NivelSalario]                        
     ,[FechaLiquidacion]                        
     ,[FechaReingreso]                        
     ,[UnidadReplicacion]                        
     ,[CodigoCargo]                        
     ,[UltimaFechaPagoVacacion]                        
     ,[Gerencia]                        
     ,[SubGerencia]                        
     ,[RedondeoACuenta]                        
     ,[PlantillaConcepto]                        
     ,[RUCCentroAsistenciaSocial]                        
     ,[Sucursal]                        
     ,[Actividad]                        
     ,[Cliente]                        
     ,[ClienteUnidad]                        
     ,[EmpleadoNivel]                        
     ,[TipoPuesto]                        
                            
     ,(select top 1 CodigoAgente from SG_Agente as ag                        
      where ag.IdEmpleado = Persona) as USUARIO                        
     ,[USUARIOPERFIL]                      
     ,[PERSONAUSUARIO]                        
     ,[CLAVE]                        
     ,[EXPIRARPASSWORDFLAG]                        
     ,[FECHAEXPIRACION]                        
    ,[ULTIMOLOGIN]                        
    ,[Paciente]                        
   ,[TipoPaciente]                        
    ,[Raza]                        
    ,[AreaLaboral]                        
    ,[Ocupacion]                        
    ,[CodigoHC]                        
    ,[CodigoHCAnterior]                        
    ,[CodigoHCSecundario]                        
    ,[TipoAlmacenamiento]                        
    ,[TipoHistoria]                        
    ,[TipoSituacion]               
    ,[IdUbicacion]                        
    ,[LugarProcedencia]                        
    ,[RutaFoto]                        
    ,[EstadoPaciente]                        
    ,[NumeroFile]                        
    /******************************************/                        
   ,'3465' as Servicio                        
   ,'DEVOLUCION' as Observacion                        
    --,[Servicio]                        
    --,[Observacion]                        
    ,[IndicadorAsistencia]                        
    ,[CantidadAsistencia]                        
    ,[UbicacionHHCC]                        
    ,[IndicadorMigradoSiteds]                        
    ,[NumeroCaja]                        
    ,[IndicadorCodigoBarras]                        
    ,[IDPACIENTE_OK]                        
    ,[CodigoAsegurado]               
    ,[NumeroPoliza]                        
    ,[NumeroCertificado]                        
    ,[CodigoProducto]                        
    ,'3466' as CodigoPlan --AUX PARA CARGAR ID OPCIÓN DE INICIO POR DEFECTO
 ,[TipoParentesco]                        
    --,[CodigoBeneficio]            
    ,( select SS_TipoTrabajador.DescripcionLocal           
    from EMPLEADOMAST           
    left join SS_TipoTrabajador on (SS_TipoTrabajador.TipoTrabajador = EMPLEADOMAST.TipoTrabajadorSalud)          
    where Empleado = @Persona )AS CodigoBeneficio        
    ,[Situacion]                        
    ,[TomoActual]                        
    ,vwPersona.[IndicadorHistoriaFisica]                        
    ,DB_NAME() as DescripcionHistoria
                         
  FROM dbo.VW_PERSONAPACIENTE as vwPersona                                               
                          
     WHERE                         
  (Persona = @Persona)                        
         
                             
 END  
 ELSE
 
 if(@ACCION = 'LISTARPORIDKARDEX')                        
 begin           
	/**************************************/
	/****PARA OBTENER LA OPCION PADRE****/
	declare @TIPTRABAJADOR_AUX varchar(4) =null
	declare @OPCID_ARBOL varchar(100)=null
	declare @OPCID_ARBOL_INIT varchar(100)=null
	declare @OPCDESC_ARBOL varchar(200) =null
			
	---OBTENER TIPO TRABAJADOR ACTUAL
select @TIPOTRABAJADOR_AUXX = (case when Empleado = -1 then '08' else TipoTrabajadorSalud  end) 	 
	from EMPLEADOMAST where Empleado = @Persona	
		
	---OBTENER OPCIÓN DE ARBOL DE PROCESOS (solo se permite una a la vez)
	select TOP 1 @OPCIONID_ARBOLL = convert(varchar,IdOpcion),
    @OPCIONDESC_ARBOLL = Descripcion 
    from SG_Opcion                         
     where (IdOpcionPadre = 3000 )  --OBS: ID  MACROPROCESO                        
    
     and (TipoTrabajador = @TIPOTRABAJADOR_AUXX)
     and (Estado = 2)
	 order by Orden  asc    
	    
	/********SECCIÓN PARA OBTENER OPCIÓN ID POR DEFECTO (PRIMERA EN CARGARSE - )*****************/
	/********se deberá obtener de un parámetro o cargar con una consulta más extensa**************/
	if(@OPCID_ARBOL = '3447')
	begin
		set @OPCID_ARBOL_INIT = '3449';
	end 
	     
	/**************************************/                 			
	/**************************************/                 			
	          
  ---DIRECCIONREFERENCIA Y CCOSTO USADO AXULIARMENTE; para Establecimiento y Periodo                        
  SELECT                         
   [Persona]                           
   ,[Nombres]                        
   ,[Busqueda]                        
   ,[PersonaAnt]                         
     ,[ApellidoPaterno]                        
     ,[ApellidoMaterno]                        
     ,[NombreCompleto]               
     ,[TipoDocumento]                        
     ,[Documento]                        
     ,[CodigoBarras]                        
     ,[EsCliente]                        
     ,[EsEmpleado]                        
     ,[EsOtro]                        
     ,[TipoPersona]                        
     ,[EsProveedor]                        
     ,[FechaNacimiento]                        
     ,[CiudadNacimiento]                        
     ,[Sexo]                        
     ,[Nacionalidad]                        
     ,[EstadoCivil]                        
     ,[NivelInstruccion]                        
     ,[Direccion]                       ,[CodigoPostal]                        
     ,[Provincia]                        
     ,[Departamento]                        
     ,[Telefono]                        
     ,[DocumentoFiscal]                        
     ,[DocumentoIdentidad]                        
     ,[ACCION]                        
     ,[edad]                        
     ,[rangoEtario]                        
     ,[TipoMedico]                        
     ,[Correcion]                        
     ,[EsPaciente]                        
     ,[EsEmpresa]                        
     ,[Pais]                        
     ,[FlagActualizacion]                        
     ,[CuentaMonedaLocal_tmp]                        
     ,[CuentaMonedaExtranjera_tmp]                        
     ,[CorrelativoSCTR]                        
     ,[SeguroDiscamec]                        
     ,[CodDiscamec]                        
     ,[FecIniDiscamec]                        
     ,[FecFinDiscamec]                        
     ,[LugarNacimiento]                        
     ,[Celular]                        
     ,[CelularEmergencia]                        
     ,[ParentescoEmergencia]                        
     ,isnull((select top 1 Nombre from dbo.CM_CO_Establecimiento where IdEstablecimiento =convert(int,@AFE))            
  ,'No Definido') as  DireccionReferencia --AUX                      
     ,[UltimaFechaModif]                        
     ,[TipoPersonaUsuario]                        
     ,[UltimoUsuario]                        
     ,[Estado]                   
     ,[DireccionEmergencia]                        
     ,[TelefonoEmergencia]                        
     ,[BancoMonedaLocal]                        
     ,[TipoCuentaLocal]                        
     ,[CuentaMonedaLocal]                        
     ,[BancoMonedaExtranjera]                        
     ,[TipoCuentaExtranjera]                        
     ,[CuentaMonedaExtranjera]                        
     ,[CorreoElectronico]                        
     ,[EnfermedadGraveFlag]                        
     ,[IngresoFechaRegistro]                        
     ,[IngresoAplicacionCodigo]                        
     ,[IngresoUsuario]                        
     ,[PYMEFlag]                        
     ,[TipoPago]   
     ,vwPersona.[TipoTrabajador]                        
     ,[Religion]                        
     ,[TipoVisa]                        
     ,[VisaFechaInicio]                        
     ,[VisaFechaExpiracion]                        
     ,[CodigoAFP]                        
     ,[NumeroAFP]                        
     ,[BancoCTS]                        
     ,[TipoCuentaCTS]                        
     ,[TipoMonedaCTS]                        
     ,[NumeroCuentaCTS]                        
     ,[EstadoEmpleado]                        
     ,[TipoPlanilla]                        
     ,[FechaIngreso]                        
     ,[FechaUltimaPlanilla]                        
     ,[TipoContrato]                        
     ,[FechaInicioContrato]                        
     ,[FechaFinContrato]                        
     ,[FechaCese]                        
     ,[RazonCese]                        
     ,[Contratista]                        
     ,CompaniaSocio                        
    -- ,isnull(CentroCostos,substring(CONVERT(varchar,GETDATE(),112),1,6)) as  CentroCostos --AUX                        
    ,CONVERT(varchar,GETDATE(),112)as  CentroCostos        
                    ,[AFE]                        
     ,[DeptoOrganizacion]                        
     ,[TipoHorario]                        
     ,[GradoSalario]                        
     ,[Cargo]                        
     ,[Posicion]                        
     ,[NivelAcceso]                      
     ,[FlagIPSSVIDA]                        
     ,[FlagSindicato]                        
     ,[FlagAccTrabajo]                        
     ,[FlagCooperativa]                        
     ,[FlagRetencionJudicial]                        
     ,[FlagReingresos]                        
     ,[FlagComision]                        
     ,[FlagImpuestoRenta]                        
     ,[SueldoActualLocal]                        
     ,[SueldoActualDolar]                        
     ,[SueldoAnteriorLocal]                        
     ,[SueldoAnteriorDolar]                        
     ,[MonedaPago]                        
     ,[TarjetaCredito]                        
     ,[MotivoCese]                        
     ,[DepartamentoOrganizacional]                        
     ,[DepartamentoOperacional]                        
     ,[Perfil]                        
     ,[NivelSalario]                        
     ,[FechaLiquidacion]                        
     ,[FechaReingreso]                        
     ,[UnidadReplicacion]                        
     ,[CodigoCargo]                        
     ,[UltimaFechaPagoVacacion]                        
     ,[Gerencia]                        
     ,[SubGerencia]                        
     ,[RedondeoACuenta]                        
     ,[PlantillaConcepto]                        
     ,[RUCCentroAsistenciaSocial]                        
     ,[Sucursal]                        
     ,[Actividad]                        
     ,[Cliente]                        
     ,[ClienteUnidad]                        
     ,[EmpleadoNivel]                        
     ,[TipoPuesto]                        
                            
     ,(select top 1 CodigoAgente from SG_Agente as ag                        
      where ag.IdEmpleado = Persona) as USUARIO                        
     ,[USUARIOPERFIL]                      
     ,[PERSONAUSUARIO]                        
     ,[CLAVE]                        
     ,[EXPIRARPASSWORDFLAG]                        
     ,[FECHAEXPIRACION]                        
    ,[ULTIMOLOGIN]                        
    ,[Paciente]                        
   ,[TipoPaciente]                        
    ,[Raza]                        
    ,[AreaLaboral]                        
    ,[Ocupacion]                        
    ,[CodigoHC]                        
    ,[CodigoHCAnterior]                        
    ,[CodigoHCSecundario]                        
    ,[TipoAlmacenamiento]                        
    ,[TipoHistoria]                        
    ,[TipoSituacion]               
    ,[IdUbicacion]                        
    ,[LugarProcedencia]                        
    ,[RutaFoto]                        
    ,[EstadoPaciente]                        
    ,[NumeroFile]                        
    /******************************************/                        
   ,'3447' as Servicio                        
   ,'PROGRAMAR KARDEX' as Observacion                        
    --,[Servicio]                        
    --,[Observacion]                        
    ,[IndicadorAsistencia]                        
    ,[CantidadAsistencia]                        
    ,[UbicacionHHCC]                        
    ,[IndicadorMigradoSiteds]                        
    ,[NumeroCaja]                        
    ,[IndicadorCodigoBarras]                        
    ,[IDPACIENTE_OK]                        
    ,[CodigoAsegurado]               
    ,[NumeroPoliza]                        
    ,[NumeroCertificado]                        
    ,[CodigoProducto]                        
    ,'3449' as CodigoPlan --AUX PARA CARGAR ID OPCIÓN DE INICIO POR DEFECTO
 ,[TipoParentesco]                        
    --,[CodigoBeneficio]            
    ,( select SS_TipoTrabajador.DescripcionLocal           
    from EMPLEADOMAST           
    left join SS_TipoTrabajador on (SS_TipoTrabajador.TipoTrabajador = EMPLEADOMAST.TipoTrabajadorSalud)          
    where Empleado = @Persona )AS CodigoBeneficio        
    ,[Situacion]                        
    ,[TomoActual]                        
    ,vwPersona.[IndicadorHistoriaFisica]                        
    ,DB_NAME() as DescripcionHistoria
                         
  FROM dbo.VW_PERSONAPACIENTE as vwPersona                                               
                          
     WHERE                         
  (Persona = -1)                        
                         
 END  
                         
 ELSE                        
 if(@ACCION = 'LISTARPAGSELECUSER')                        
 begin                          
                         
  SELECT @CONTADOR= COUNT(*)                              
    FROM dbo.VW_PERSONAPACIENTE                        
     WHERE                         
     (@Persona is null or (@Persona =0 )  OR Persona = @Persona)                        
     and (@Paciente is null OR Paciente = @Paciente)                        
     and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                               
     and (@ESTADO is null OR Estado = @ESTADO)                        
     and (@Usuario is null OR Usuario = @Usuario)                        
        
   select [Persona]                        
   ,[Nombres]                        
   ,[Busqueda]                        
   ,[PersonaAnt]                         
    ,[ApellidoPaterno]                        
    ,[ApellidoMaterno]                        
    ,[NombreCompleto]                        
    ,[TipoDocumento]                        
    ,[Documento]                      
    ,[CodigoBarras]                        
    ,[EsCliente]                        
    ,[EsEmpleado]                        
    ,[EsOtro]                        
    ,[TipoPersona]                        
    ,[EsProveedor]                        
    ,[FechaNacimiento]                        
    ,[CiudadNacimiento]                        
    ,[Sexo]                        
    ,[Nacionalidad]                        
    ,[EstadoCivil]                        
    ,[NivelInstruccion]                        
    ,[Direccion]                        
    ,[CodigoPostal]                        
    ,[Provincia]                        
 ,[Departamento]                        
    ,[Telefono]                        
    ,[DocumentoFiscal]                        
    ,[DocumentoIdentidad]                        
    ,[ACCION]                        
    ,[edad]                        
    ,[rangoEtario]                        
    ,[TipoMedico]                        
    ,[Correcion]                        
    ,[EsPaciente]                        
    ,[EsEmpresa]                        
    ,[Pais]                        
    ,[FlagActualizacion]                        
    ,[CuentaMonedaLocal_tmp]                        
    ,[CuentaMonedaExtranjera_tmp]                        
    ,[CorrelativoSCTR]                        
    ,[SeguroDiscamec]                        
    ,[CodDiscamec]                        
    ,[FecIniDiscamec]                        
    ,[FecFinDiscamec]                        
    ,[LugarNacimiento]                        
    ,[Celular]                        
    ,[CelularEmergencia]                        
    ,[ParentescoEmergencia]                        
    ,[DireccionReferencia]                        
    ,[UltimaFechaModif]          
    ,[TipoPersonaUsuario]                        
    ,[UltimoUsuario]                        
    ,[Estado]                        
    ,[DireccionEmergencia]                        
    ,[TelefonoEmergencia]                        
    ,[BancoMonedaLocal]                        
    ,[TipoCuentaLocal]                        
    ,[CuentaMonedaLocal]                        
    ,[BancoMonedaExtranjera]                        
    ,[TipoCuentaExtranjera]                        
    ,[CuentaMonedaExtranjera]                        
    ,[CorreoElectronico]                        
    ,[EnfermedadGraveFlag]                        
    ,[IngresoFechaRegistro]                        
    ,[IngresoAplicacionCodigo]                        
    ,[IngresoUsuario]                        
    ,[PYMEFlag]                        
    ,[TipoPago]                        
    ,[TipoTrabajador]                        
    ,[Religion]                        
    ,[TipoVisa]                        
    ,[VisaFechaInicio]                        
    ,[VisaFechaExpiracion]                        
    ,[CodigoAFP]                        
    ,[NumeroAFP]                        
    ,[BancoCTS]                        
    ,[TipoCuentaCTS]                        
    ,[TipoMonedaCTS]                     
    ,[NumeroCuentaCTS]                        
    ,[EstadoEmpleado]                        
    ,[TipoPlanilla]                        
    ,[FechaIngreso]                        
    ,[FechaUltimaPlanilla]                        
    ,[TipoContrato]                        
    ,[FechaInicioContrato]                        
    ,[FechaFinContrato]                        
    ,[FechaCese]                        
    ,[RazonCese]                        
    ,[Contratista]                        
    ,[CompaniaSocio]                        
    ,[CentroCostos]                        
,[AFE]                        
 ,[DeptoOrganizacion]                        
    ,[TipoHorario]                        
    ,[GradoSalario]                        
    ,[Cargo]                        
    ,[Posicion]                        
    ,[NivelAcceso]                        
    ,[FlagIPSSVIDA]                        
    ,[FlagSindicato]                        
    ,[FlagAccTrabajo]                        
    ,[FlagCooperativa]                        
    ,[FlagRetencionJudicial]                        
    ,[FlagReingresos]                        
    ,[FlagComision]                        
    ,[FlagImpuestoRenta]                        
    ,[SueldoActualLocal]                        
    ,[SueldoActualDolar]                        
  ,[SueldoAnteriorLocal]                        
    ,[SueldoAnteriorDolar]                        
    ,[MonedaPago]                        
    ,[TarjetaCredito]                        
    ,[MotivoCese]                        
    ,[DepartamentoOrganizacional]                        
    ,[DepartamentoOperacional]                        
    ,[Perfil]                        
    ,[NivelSalario]                        
    ,[FechaLiquidacion]                        
    ,[FechaReingreso]                        
    ,[UnidadReplicacion]                        
    ,[CodigoCargo]                        
    ,[UltimaFechaPagoVacacion]                        
    ,[Gerencia]                        
    ,[SubGerencia]                        
    ,[RedondeoACuenta]                        
    ,[PlantillaConcepto]                        
    ,[RUCCentroAsistenciaSocial]                        
    ,[Sucursal]                        
    ,[Actividad]                        
    ,[Cliente]                        
    ,[ClienteUnidad]                        
    ,[EmpleadoNivel]                        
    ,[TipoPuesto]                        
    ,[USUARIO]                        
    ,[USUARIOPERFIL]                        
    ,[PERSONAUSUARIO]                        
    ,[CLAVE]                        
    ,[EXPIRARPASSWORDFLAG]                        
    ,[FECHAEXPIRACION]                        
    ,[ULTIMOLOGIN]                        
    ,[Paciente]                        
    ,[TipoPaciente]                        
    ,[Raza]                        
    ,[AreaLaboral]                        
    ,[Ocupacion]                        
    ,[CodigoHC]                        
    ,[CodigoHCAnterior]                        
    ,[CodigoHCSecundario]                        
    ,[TipoAlmacenamiento]                     
    ,[TipoHistoria]                        
    ,[TipoSituacion]                        
    ,[IdUbicacion]                        
    ,[LugarProcedencia]                        
    ,[RutaFoto]                        
    ,[EstadoPaciente]                        
    ,[NumeroFile]                        
    ,TIPTRAB AS [Servicio]                        
    ,OBS AS [Observacion]                        
    ,[IndicadorAsistencia]                        
    ,[CantidadAsistencia]                        
    ,[UbicacionHHCC]                        
    ,[IndicadorMigradoSiteds]                        
    ,[NumeroCaja]                        
    ,[IndicadorCodigoBarras]                        
    ,[IDPACIENTE_OK]                        
    ,[CodigoAsegurado]                        
    ,[NumeroPoliza]                        
    ,[NumeroCertificado]                        
    ,[CodigoProducto]                        
    ,[CodigoPlan]                        
    ,[TipoParentesco]                        
    ,[CodigoBeneficio]                        
    ,[Situacion]                        
    ,[TomoActual]                        
    ,[IndicadorHistoriaFisica]                        
    ,[DescripcionHistoria]
                           
  FROM (                          
    SELECT VW_PERSONAPACIENTE.*,               
    SS_TipoTrabajador.DescripcionLocal AS OBS,                                   
    SS_TipoTrabajador.TipoTrabajador AS TIPTRAB,               @CONTADOR AS Contador,                        
     ROW_NUMBER() OVER (ORDER BY Persona ASC ) AS RowNumber                            
  FROM dbo.VW_PERSONAPACIENTE  LEFT JOIN            
  SS_TipoTrabajador ON (SS_TipoTrabajador.TipoTrabajador = VW_PERSONAPACIENTE.TipoTrabajador)                      
     WHERE                         
     (@Persona is null or (@Persona =0 )  OR Persona = @Persona)                        
     and (@Paciente is null OR Paciente = @Paciente)                        
     and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                               
     and (@ESTADO is null OR VW_PERSONAPACIENTE.Estado = @ESTADO)                   
     and (@Usuario is null OR Usuario = @Usuario)                        
     ) AS LISTADO                        
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR                          
            RowNumber BETWEEN @Inicio  AND @NumeroFilas                         
 end                        
                            
 ELSE                        
 if(@ACCION = 'LISTARNUEVOPAG')                        
 begin                          
                         
  SELECT @CONTADOR= COUNT(*)                              
    FROM dbo.VW_PERSONAPACIENTE                        
     WHERE                         
     (@Persona is null or (@Persona =0 )  OR Persona = @Persona)                        
     --and (@CodigoCargo is null OR Paciente = @CodigoCargo OR @CodigoCargo = 0)                        
     AND (@CodigoCargo is null or @CodigoCargo =0 or  cast(Paciente as VARCHAR) like '%'+upper(@CodigoCargo)+'%')                        
     and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                               
     and (@ESTADO is null OR Estado = @ESTADO)                        
     --and (@Usuario is null OR Usuario = @Usuario)                        
     and (@AFE is null OR CodigoHC like '%'+ @AFE+'%')                        
     and (@Usuario is null OR CodigoHCAnterior like '%'+ @Usuario+'%')                        
     AND (@TipoMedico is null or (@TipoMedico =0 ) OR Situacion = @TipoMedico)                        
     and (@Documento is null  OR  Documento like '%'+upper(rtrim(@Documento))+'%')                        
                             
                          
   select [Persona]                        
   ,[Nombres]                        
   ,[Busqueda]                        
   ,[PersonaAnt]                         
    ,[ApellidoPaterno]                        
    ,[ApellidoMaterno]                        
    ,[NombreCompleto]                        
    ,[TipoDocumento]                        
    ,[Documento]                        
    ,[CodigoBarras]                   
    ,[EsCliente]                        
    ,[EsEmpleado]                        
    ,[EsOtro]                        
    ,[TipoPersona]                        
    ,[EsProveedor]                        
    ,[FechaNacimiento]                        
    ,[CiudadNacimiento]                        
    ,[Sexo]                        
    ,[Nacionalidad]                        
    ,[EstadoCivil]                        
    ,[NivelInstruccion]                        
    ,[Direccion]                        
    ,[CodigoPostal]                        
    ,[Provincia]                        
    ,[Departamento]                        
    ,[Telefono]                        
    ,[DocumentoFiscal]                        
    ,[DocumentoIdentidad]                        
    ,[ACCION]                        
    ,[edad]                        
    ,[rangoEtario]                
    ,[TipoMedico]                        
    ,[Correcion]                        
    ,[EsPaciente]                        
    ,[EsEmpresa]                        
    ,[Pais]                        
    ,[FlagActualizacion]                        
    ,[CuentaMonedaLocal_tmp]        
    ,[CuentaMonedaExtranjera_tmp]                        
    ,[CorrelativoSCTR]                        
    ,[SeguroDiscamec]                        
    ,[CodDiscamec]                        
    ,[FecIniDiscamec]                        
    ,[FecFinDiscamec]                        
    ,[LugarNacimiento]                        
    ,[Celular]                        
    ,[CelularEmergencia]                        
    ,[ParentescoEmergencia]                        
    ,[DireccionReferencia]                   
    ,[UltimaFechaModif]                        
    ,[TipoPersonaUsuario]                        
    ,[UltimoUsuario]                        
    ,[Estado]                        
    ,[DireccionEmergencia]                        
    ,[TelefonoEmergencia]                        
    ,[BancoMonedaLocal]                        
    ,[TipoCuentaLocal]                        
    ,[CuentaMonedaLocal]                        
    ,[BancoMonedaExtranjera]                        
    ,[TipoCuentaExtranjera]                        
    ,[CuentaMonedaExtranjera]                        
    ,[CorreoElectronico]                        
    ,[EnfermedadGraveFlag]                        
    ,[IngresoFechaRegistro]                        
    ,[IngresoAplicacionCodigo]                        
    ,[IngresoUsuario]                        
    ,[PYMEFlag]                        
    ,[TipoPago]                        
    ,[TipoTrabajador]                        
    ,[Religion]                        
    ,[TipoVisa]                          ,[VisaFechaInicio]                        
    ,[VisaFechaExpiracion]                        
    ,[CodigoAFP]                        
    ,[NumeroAFP]                        
    ,[BancoCTS]                        
    ,[TipoCuentaCTS]                        
    ,[TipoMonedaCTS]                        
    ,[NumeroCuentaCTS]                        
    ,[EstadoEmpleado]                        
    ,[TipoPlanilla]                        
    ,[FechaIngreso]                        
    ,[FechaUltimaPlanilla]                        
    ,[TipoContrato]                        
    ,[FechaInicioContrato]                        
    ,[FechaFinContrato]                        
    ,[FechaCese]                        
    ,[RazonCese]                        
    ,[Contratista]                        
    ,[CompaniaSocio]                        
    ,[CentroCostos]                        
    ,[AFE]                        
    ,[DeptoOrganizacion]                        
    ,[TipoHorario]                        
    ,[GradoSalario]                        
    ,[Cargo]                        
    ,[Posicion]                        
    ,[NivelAcceso]                        
    ,[FlagIPSSVIDA]                        
    ,[FlagSindicato]                        
    ,[FlagAccTrabajo]                        
    ,[FlagCooperativa]                        
    ,[FlagRetencionJudicial]                        
    ,[FlagReingresos]                        
    ,[FlagComision]                        
    ,[FlagImpuestoRenta]                        
    ,[SueldoActualLocal]                        
    ,[SueldoActualDolar]                        
    ,[SueldoAnteriorLocal]                        
    ,[SueldoAnteriorDolar]                        
    ,[MonedaPago]                        
    ,[TarjetaCredito]                        
    ,[MotivoCese]                        
    ,[DepartamentoOrganizacional]                        
    ,[DepartamentoOperacional]                        
    ,[Perfil]                        
    ,[NivelSalario]                        
    ,[FechaLiquidacion]                        
    ,[FechaReingreso]                        
    ,[UnidadReplicacion]                        
    ,[CodigoCargo]                        
    ,[UltimaFechaPagoVacacion]                        
    ,[Gerencia]                        
    ,[SubGerencia]                        
    ,[RedondeoACuenta]                        
    ,[PlantillaConcepto]                        
    ,[RUCCentroAsistenciaSocial]                        
    ,[Sucursal]                        
    ,[Actividad]                        
    ,[Cliente]                        
    ,[ClienteUnidad]                        
    ,[EmpleadoNivel]                        
    ,[TipoPuesto]                        
    ,[USUARIO]                        
    ,[USUARIOPERFIL]                        
    ,[PERSONAUSUARIO]                        
    ,[CLAVE]                        
    ,[EXPIRARPASSWORDFLAG]                        
    ,[FECHAEXPIRACION]                        
    ,[ULTIMOLOGIN]                        
    ,[Paciente]                        
    ,[TipoPaciente]                        
    ,[Raza]                        
    ,[AreaLaboral]                        
    ,[Ocupacion]                        
    ,[CodigoHC]                        
    ,[CodigoHCAnterior]                        
    ,[CodigoHCSecundario]                        
    ,[TipoAlmacenamiento]                        
    ,[TipoHistoria]                        
    ,[TipoSituacion]                        
    ,[IdUbicacion]                        
    ,[LugarProcedencia]                        
    ,[RutaFoto]                        
    ,[EstadoPaciente]                        
    ,[NumeroFile]                        
    ,[Servicio]                        
    ,[Observacion]                        
    ,[IndicadorAsistencia]                        
    ,[CantidadAsistencia]                        
    ,[UbicacionHHCC]                        
    ,[IndicadorMigradoSiteds]                        
    ,[NumeroCaja]                        
    ,[IndicadorCodigoBarras]                        
    ,[IDPACIENTE_OK]                        
    ,[CodigoAsegurado]               
    ,[NumeroPoliza]                        
    ,[NumeroCertificado]                        
    ,[CodigoProducto]                        
    ,[CodigoPlan]                        
    ,[TipoParentesco]                        
    ,[CodigoBeneficio]                        
    ,[Situacion]                        
    ,[TomoActual]                        
    ,[IndicadorHistoriaFisica]                        
    ,[DescripcionHistoria] 
        
  FROM (                          
    SELECT VW_PERSONAPACIENTE.*,                                      
     @CONTADOR AS Contador,                        
     ROW_NUMBER() OVER (ORDER BY Persona ASC ) AS RowNumber                            
  FROM dbo.VW_PERSONAPACIENTE                        
     WHERE                         
     (@Persona is null or (@Persona =0 )  OR Persona = @Persona)                        
     --and (@CodigoCargo is null OR Paciente = @CodigoCargo OR @CodigoCargo = 0)                        
     AND (@CodigoCargo is null or @CodigoCargo =0 or  cast(Paciente as VARCHAR) like '%'+upper(@CodigoCargo)+'%')                        
     and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                               
     and (@ESTADO is null OR Estado = @ESTADO)                        
     --and (@Usuario is null OR Usuario = @Usuario)                        
     and (@AFE is null OR CodigoHC like '%' +@AFE+'%')              
     and (@Usuario is null OR CodigoHCAnterior like '%' +@Usuario+'%')             
     AND (@TipoMedico is null or (@TipoMedico =0 ) OR Situacion = @TipoMedico)                        
     and (@Documento is null  OR  Documento like '%'+upper(RTRIM(@Documento))+'%')                        
                             
     ) AS LISTADO                 
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR                          
            RowNumber BETWEEN @Inicio  AND @NumeroFilas                         
 end                        
 ELSE                             
 if(@ACCION = 'LISTARNUEVOPAGDOS')                        
 begin                          
                         
  SELECT @CONTADOR= COUNT(*)                              
    FROM dbo.VW_PERSONAPACIENTE            
     WHERE                         
     (@Persona is null or (@Persona =0 )  OR Persona = @Persona)                        
     --and (@CodigoCargo is null OR Paciente = @CodigoCargo OR @CodigoCargo = 0)                        
     AND (@CodigoCargo is null or @CodigoCargo =0 or  cast(Paciente as VARCHAR) like '%'+upper(@CodigoCargo)+'%')                        
     and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                               
     and (@ESTADO is null OR Estado = @ESTADO)                        
     --and (@Usuario is null OR Usuario = @Usuario)                        
     and (@AFE is null OR CodigoHC like '%'+ @AFE+'%')                        
     and (@Usuario is null OR CodigoHCAnterior like '%'+ @Usuario+'%')                        
     AND (@TipoMedico is null or (@TipoMedico =0 ) OR Situacion = @TipoMedico)                        
     and (@Documento is null  OR  Documento like '%'+upper(rtrim(@Documento))+'%')                  
     AND EsPaciente='S'             
  and TipoPersona='N'             
  and EsEmpleado='N'             
  and EsOtro='N'             
  and EsEmpresa is null                  
                             
                          
   select [Persona]                        
   ,[Nombres]                        
   ,[Busqueda]                        
   ,[PersonaAnt]                         
    ,[ApellidoPaterno]                        
    ,[ApellidoMaterno]                        
    ,[NombreCompleto]                  
    ,[TipoDocumento]                        
    ,[Documento]                        
    ,[CodigoBarras]                        
    ,[EsCliente]                        
    ,[EsEmpleado]                        
    ,[EsOtro]                        
    ,[TipoPersona]                        
  ,[EsProveedor]                        
    ,[FechaNacimiento]                        
    ,[CiudadNacimiento]                        
    ,[Sexo]                        
    ,[Nacionalidad]                        
    ,[EstadoCivil]                        
    ,[NivelInstruccion]                        
    ,[Direccion]                        
    ,[CodigoPostal]                        
    ,[Provincia]                        
    ,[Departamento]                        
    ,[Telefono]                        
    ,[DocumentoFiscal]                        
    ,[DocumentoIdentidad]                        
    ,[ACCION]                        
    ,[edad]                        
    ,[rangoEtario]                        
    ,[TipoMedico]                        
    ,[Correcion]                        
    ,[EsPaciente]                        
    ,[EsEmpresa]                        
    ,[Pais]                        
    ,[FlagActualizacion]                        
    ,[CuentaMonedaLocal_tmp]                        
    ,[CuentaMonedaExtranjera_tmp]                        
    ,[CorrelativoSCTR]                        
    ,[SeguroDiscamec]                        
    ,[CodDiscamec]                        
    ,[FecIniDiscamec]                        
    ,[FecFinDiscamec]                        
    ,[LugarNacimiento]                        
    ,[Celular]                        
    ,[CelularEmergencia]                        
    ,[ParentescoEmergencia]                        
    ,[DireccionReferencia]                        
    ,[UltimaFechaModif]                        
    ,[TipoPersonaUsuario]                        
    ,[UltimoUsuario]                        
    ,[Estado]                        
    ,[DireccionEmergencia]                        
    ,[TelefonoEmergencia]                        
    ,[BancoMonedaLocal]                        
    ,[TipoCuentaLocal]                        
    ,[CuentaMonedaLocal]                        
    ,[BancoMonedaExtranjera]                        
    ,[TipoCuentaExtranjera]        
    ,[CuentaMonedaExtranjera]                        
    ,[CorreoElectronico]                        
    ,[EnfermedadGraveFlag]                        
    ,[IngresoFechaRegistro]                        
    ,[IngresoAplicacionCodigo]                        
    ,[IngresoUsuario]                        
    ,[PYMEFlag]                        
    ,[TipoPago]                        
    ,[TipoTrabajador]                        
    ,[Religion]                        
    ,[TipoVisa]                        
    ,[VisaFechaInicio]                        
    ,[VisaFechaExpiracion]                        
    ,[CodigoAFP]                        
    ,[NumeroAFP]                        
    ,[BancoCTS]                        
    ,[TipoCuentaCTS]                        
    ,[TipoMonedaCTS]                        
    ,[NumeroCuentaCTS]                        
    ,[EstadoEmpleado]                        
    ,[TipoPlanilla]                        
    ,[FechaIngreso]                        
    ,[FechaUltimaPlanilla]                        
    ,[TipoContrato]                        
    ,[FechaInicioContrato]                        
    ,[FechaFinContrato]                        
    ,[FechaCese]                        
    ,[RazonCese]                        
    ,[Contratista]                        
    ,[CompaniaSocio]                        
    ,[CentroCostos]                        
    ,[AFE]                        
    ,[DeptoOrganizacion]                        
    ,[TipoHorario]                        
    ,[GradoSalario]                        
    ,[Cargo]                        
    ,[Posicion]                        
    ,[NivelAcceso]                        
    ,[FlagIPSSVIDA]                        
    ,[FlagSindicato]                        
    ,[FlagAccTrabajo]                        
    ,[FlagCooperativa]                        
    ,[FlagRetencionJudicial]                        
    ,[FlagReingresos]                        
    ,[FlagComision]                        
    ,[FlagImpuestoRenta]                        
    ,[SueldoActualLocal]                        
    ,[SueldoActualDolar]                        
    ,[SueldoAnteriorLocal]                  
    ,[SueldoAnteriorDolar]                        
    ,[MonedaPago]                        
    ,[TarjetaCredito]                        
    ,[MotivoCese]                        
    ,[DepartamentoOrganizacional]                        
    ,[DepartamentoOperacional]                        
    ,[Perfil]                        
    ,[NivelSalario]                        
    ,[FechaLiquidacion]                        
    ,[FechaReingreso]                        
    ,[UnidadReplicacion]                        
    ,[CodigoCargo]                        
    ,[UltimaFechaPagoVacacion]                        
    ,[Gerencia]                        
    ,[SubGerencia]                        
    ,[RedondeoACuenta]                        
    ,[PlantillaConcepto]                        
    ,[RUCCentroAsistenciaSocial]                        
    ,[Sucursal]                        
    ,[Actividad]                        
    ,[Cliente]                        
    ,[ClienteUnidad]                        
    ,[EmpleadoNivel]                        
    ,[TipoPuesto]                        
    ,[USUARIO]                        
    ,[USUARIOPERFIL]                        
    ,[PERSONAUSUARIO]                        
    ,[CLAVE]                        
    ,[EXPIRARPASSWORDFLAG]                        
    ,[FECHAEXPIRACION]                        
    ,[ULTIMOLOGIN]                        
    ,[Paciente]                        
    ,[TipoPaciente]                        
    ,[Raza]                        
    ,[AreaLaboral]                        
    ,[Ocupacion]                        
    ,[CodigoHC]                        
    ,[CodigoHCAnterior]                        
    ,[CodigoHCSecundario]                        
    ,[TipoAlmacenamiento]                        
    ,[TipoHistoria]                        
    ,[TipoSituacion]                        
    ,[IdUbicacion]                        
    ,[LugarProcedencia]                        
    ,[RutaFoto]                        
    ,[EstadoPaciente]                        
    ,[NumeroFile]                        
    ,[Servicio]                        
    ,[Observacion]                        
    ,[IndicadorAsistencia]                        
    ,[CantidadAsistencia]                        
    ,[UbicacionHHCC]                        
    ,[IndicadorMigradoSiteds]                        
    ,[NumeroCaja]                        
    ,[IndicadorCodigoBarras]                        
    ,[IDPACIENTE_OK]                        
    ,[CodigoAsegurado]                        
    ,[NumeroPoliza]                        
    ,[NumeroCertificado]                        
    ,[CodigoProducto]                        
    ,[CodigoPlan]                        
    ,[TipoParentesco]                        
    ,[CodigoBeneficio]                        
    ,[Situacion]                        
    ,[TomoActual]                        
    ,[IndicadorHistoriaFisica]                        
    ,[DescripcionHistoria] 
  
  FROM (                          
    SELECT VW_PERSONAPACIENTE.*,                                      
     @CONTADOR AS Contador,                        
     ROW_NUMBER() OVER (ORDER BY Persona ASC ) AS RowNumber                            
  FROM dbo.VW_PERSONAPACIENTE                        
     WHERE                         
     (@Persona is null or (@Persona =0 )  OR Persona = @Persona)                        
     AND (@CodigoCargo is null or @CodigoCargo =0 or  cast(Paciente as VARCHAR) like '%'+upper(@CodigoCargo)+'%')                        
     and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                               
     and (@ESTADO is null OR Estado = @ESTADO)                        
     --and (@Usuario is null OR Usuario = @Usuario)                        
     and (@AFE is null OR CodigoHC like '%' +@AFE+'%')              
     and (@Usuario is null OR CodigoHCAnterior like '%' +@Usuario+'%')             
     AND (@TipoMedico is null or (@TipoMedico =0 ) OR Situacion = @TipoMedico)                        
     and (@Documento is null  OR  Documento like '%'+upper(RTRIM(@Documento))+'%')              
     AND EsPaciente='S'             
  and TipoPersona='N'             
  and EsEmpleado='N'             
  and EsOtro='N'             
  and EsEmpresa is null                          
                             
     ) AS LISTADO                        
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR                          
            RowNumber BETWEEN @Inicio  AND @NumeroFilas                         
 end                        
 ELSE                   
 if(@ACCION = 'LISTARPAGPACIENTE')                        
 begin                          
                         
  SELECT @CONTADOR= COUNT(*)                              
    FROM dbo.VW_PERSONAPACIENTE                        
     WHERE                         
     (@Persona is null or (@Persona =0 )  OR Persona = @Persona)                        
     and (@CodigoCargo is null OR Paciente = @CodigoCargo OR @CodigoCargo = 0)                        
     and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                               
     and (@ESTADO is null OR Estado = @ESTADO)                        
     and (@Usuario is null OR Usuario = @Usuario)                        
     and (@AFE is null OR CodigoHC = @AFE)                        
     and (@Usuario is null OR CodigoHCAnterior = @Usuario)                        
     AND (@TipoMedico is null or (@TipoMedico =0 ) OR Situacion = @TipoMedico)                        
     and (@Documento is null  OR  upper(Documento) like '%'+upper(@Documento)+'%')                        
                             
                          
   select [Persona]                        
   ,[Nombres]                        
   ,[Busqueda]                        
   ,[PersonaAnt]                         
    ,[ApellidoPaterno]                     
    ,[ApellidoMaterno]                        
    ,[NombreCompleto]                        
    ,[TipoDocumento]                        
    ,[Documento]                        
    ,[CodigoBarras]                        
    ,[EsCliente]                        
    ,[EsEmpleado]                        
    ,[EsOtro]                        
    ,[TipoPersona]                        
    ,[EsProveedor]                        
   ,[FechaNacimiento]                        
    ,[CiudadNacimiento]                        
    ,[Sexo]                        
    ,[Nacionalidad]                        
    ,[EstadoCivil]                        
    ,[NivelInstruccion]                        
    ,[Direccion]                        
    ,[CodigoPostal]                        
    ,[Provincia]                        
    ,[Departamento]                        
    ,[Telefono]                        
    ,[DocumentoFiscal]                        
    ,[DocumentoIdentidad]                        
    ,[ACCION]                        
    ,[edad]                        
    ,[rangoEtario]                        
    ,[TipoMedico]                        
    ,[Correcion]                        
    ,[EsPaciente]                        
    ,[EsEmpresa]                        
    ,[Pais]                        
    ,[FlagActualizacion]                        
    ,[CuentaMonedaLocal_tmp]                        
    ,[CuentaMonedaExtranjera_tmp]                        
    ,[CorrelativoSCTR]                        
    ,[SeguroDiscamec]                        
    ,[CodDiscamec]                        
    ,[FecIniDiscamec]                        
    ,[FecFinDiscamec]                        
    ,[LugarNacimiento]                        
    ,[Celular]                        
    ,[CelularEmergencia]                        
    ,[ParentescoEmergencia]                        
    ,[DireccionReferencia]                        
    ,[UltimaFechaModif]                        
    ,[TipoPersonaUsuario]                        
    ,[UltimoUsuario]                        
    ,[Estado]                        
    ,[DireccionEmergencia]                        
    ,[TelefonoEmergencia]                        
    ,[BancoMonedaLocal]         
    ,[TipoCuentaLocal]                        
    ,[CuentaMonedaLocal]                        
    ,[BancoMonedaExtranjera]                        
    ,[TipoCuentaExtranjera]                        
    ,[CuentaMonedaExtranjera]                        
    ,[CorreoElectronico]                        
    ,[EnfermedadGraveFlag]                        
    ,[IngresoFechaRegistro]                        
    ,[IngresoAplicacionCodigo]                        
    ,[IngresoUsuario]                        
    ,[PYMEFlag]                        
    ,[TipoPago]                        
    ,[TipoTrabajador]                        
    ,[Religion]                        
    ,[TipoVisa]                        
    ,[VisaFechaInicio]                        
    ,[VisaFechaExpiracion]                        
    ,[CodigoAFP]                        
    ,[NumeroAFP]                        
    ,[BancoCTS]                        
    ,[TipoCuentaCTS]                        
    ,[TipoMonedaCTS]                        
    ,[NumeroCuentaCTS]                        
    ,[EstadoEmpleado]                        
    ,[TipoPlanilla]                        
    ,[FechaIngreso]                        
    ,[FechaUltimaPlanilla]                        
    ,[TipoContrato]                        
    ,[FechaInicioContrato]                        
    ,[FechaFinContrato]                        
    ,[FechaCese]                        
    ,[RazonCese]                        
    ,[Contratista]                        
    ,[CompaniaSocio]                        
    ,[CentroCostos]                        
    ,[AFE]                        
    ,[DeptoOrganizacion]                     
    ,[TipoHorario]                        
    ,[GradoSalario]                        
    ,[Cargo]                        
    ,[Posicion]                        
    ,[NivelAcceso]                        
    ,[FlagIPSSVIDA]                        
    ,[FlagSindicato]                        
    ,[FlagAccTrabajo]                        
    ,[FlagCooperativa]                        
    ,[FlagRetencionJudicial]                        
    ,[FlagReingresos]                        
    ,[FlagComision]                        
    ,[FlagImpuestoRenta]                        
    ,[SueldoActualLocal]                        
    ,[SueldoActualDolar]                        
    ,[SueldoAnteriorLocal]                        
    ,[SueldoAnteriorDolar]                        
    ,[MonedaPago]                        
    ,[TarjetaCredito]                        
    ,[MotivoCese]                        
    ,[DepartamentoOrganizacional]                       
    ,[DepartamentoOperacional]                        
    ,[Perfil]                        
    ,[NivelSalario]                        
    ,[FechaLiquidacion]                        
    ,[FechaReingreso]                        
    ,[UnidadReplicacion]                        
    ,[CodigoCargo]                        
    ,[UltimaFechaPagoVacacion]                        
    ,[Gerencia]                        
    ,[SubGerencia]                        
    ,[RedondeoACuenta]                        
    ,[PlantillaConcepto]                        
    ,[RUCCentroAsistenciaSocial]                        
    ,[Sucursal]                        
    ,[Actividad]                        
    ,[Cliente]                        
    ,[ClienteUnidad]                        
    ,[EmpleadoNivel]                        
    ,[TipoPuesto]                        
    ,[USUARIO]                        
    ,[USUARIOPERFIL]                        
    ,[PERSONAUSUARIO]                        
    ,[CLAVE]                        
    ,[EXPIRARPASSWORDFLAG]                        
    ,[FECHAEXPIRACION]                        
    ,[ULTIMOLOGIN]                        
    ,[Paciente]                        
    ,[TipoPaciente]                        
    ,[Raza]                        
    ,[AreaLaboral]                        
    ,[Ocupacion]                        
    ,[CodigoHC]                        
    ,[CodigoHCAnterior]                        
    ,[CodigoHCSecundario]                        
    ,[TipoAlmacenamiento]                        
    ,[TipoHistoria]                    
    ,[TipoSituacion]                        
    ,[IdUbicacion]                        
    ,[LugarProcedencia]                        
    ,[RutaFoto]                        
    ,[EstadoPaciente]                        
    ,[NumeroFile]                        
    ,[Servicio]                        
    ,[Observacion]                        
,[IndicadorAsistencia]                        
    ,[CantidadAsistencia]                        
    ,[UbicacionHHCC]                        
    ,[IndicadorMigradoSiteds]                        
    ,[NumeroCaja]                        
    ,[IndicadorCodigoBarras]                        
    ,[IDPACIENTE_OK]                        
    ,[CodigoAsegurado]                        
    ,[NumeroPoliza]                        
    ,[NumeroCertificado]                        
    ,[CodigoProducto]                        
    ,[CodigoPlan]                        
    ,[TipoParentesco]                        
    ,[CodigoBeneficio]                        
    ,[Situacion]                        
    ,[TomoActual]                        
    ,[IndicadorHistoriaFisica]                        
    ,[DescripcionHistoria]   
  
  FROM (                          
    SELECT VW_PERSONAPACIENTE.*,                                      
     @CONTADOR AS Contador,                        
ROW_NUMBER() OVER (ORDER BY Persona ASC ) AS RowNumber                            
  FROM dbo.VW_PERSONAPACIENTE                        
     WHERE                         
     (@Persona is null or (@Persona =0 )  OR Persona = @Persona)                        
     and (@CodigoCargo is null OR Paciente = @CodigoCargo OR @CodigoCargo = 0)                        
     and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                               
     and (@ESTADO is null OR Estado = @ESTADO)                        
     and (@Usuario is null OR Usuario = @Usuario)                        
     and (@AFE is null OR CodigoHC = @AFE)                        
     and (@Usuario is null OR CodigoHCAnterior = @Usuario)                        
     AND (@TipoMedico is null or (@TipoMedico =0 ) OR Situacion = @TipoMedico)                        
     and (@Documento is null  OR  upper(Documento) like '%'+upper(@Documento)+'%')                        
                      ) AS LISTADO                        
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR                          
            RowNumber BETWEEN @Inicio  AND @NumeroFilas                         
 end                        
 ELSE                        
 if(@ACCION = 'LISTARPAGMEDICO')                        
 begin                          
                         
  SELECT @CONTADOR= COUNT(*)                              
    FROM dbo.VW_PERSONAPACIENTE                        
     WHERE                         
     (@Persona is null or (@Persona =0 )  OR Persona = @Persona)                        
     and (@CodigoCargo is null OR Paciente = @CodigoCargo OR @CodigoCargo = 0)                        
     and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                               
     and (@ESTADO is null OR Estado = @ESTADO)                        
     and (@Usuario is null OR Usuario = @Usuario)                        
     and (@AFE is null OR CodigoHC = @AFE)                        
     and (@Usuario is null OR CodigoHCAnterior = @Usuario)                        
     AND (@TipoMedico is null or (@TipoMedico =0 ) OR Situacion = @TipoMedico)                        
     and (@Documento is null  OR  upper(Documento) like '%'+upper(@Documento)+'%')                        
     AND (TipoTrabajador = '08')                        
                          
   select [Persona]                        
   ,[Nombres]                        
   ,[Busqueda]                        
   ,[PersonaAnt]                         
    ,[ApellidoPaterno]                        
    ,[ApellidoMaterno]                        
    ,[NombreCompleto]                        
    ,[TipoDocumento]                        
    ,[Documento]                        
    ,[CodigoBarras]                        
    ,[EsCliente]                        
    ,[EsEmpleado]                        
    ,[EsOtro]                        
    ,[TipoPersona]                        
    ,[EsProveedor]                        
    ,[FechaNacimiento]                        
    ,[CiudadNacimiento]                        
    ,[Sexo]                        
    ,[Nacionalidad]                        
    ,[EstadoCivil]                        
    ,[NivelInstruccion]                    ,[Direccion]                        
    ,[CodigoPostal]                        
    ,[Provincia]                        
    ,[Departamento]                        
    ,[Telefono]                        
    ,[DocumentoFiscal]                        
    ,[DocumentoIdentidad]                        
    ,[ACCION]                        
    ,[edad]                        
    ,[rangoEtario]                        
    ,[TipoMedico]                        
    ,[Correcion]                        
    ,[EsPaciente]                        
    ,[EsEmpresa]                        
    ,[Pais]                        
    ,[FlagActualizacion]                        
    ,[CuentaMonedaLocal_tmp]                        
    ,[CuentaMonedaExtranjera_tmp]                        
    ,[CorrelativoSCTR]                        
    ,[SeguroDiscamec]                        
    ,[CodDiscamec]                        
    ,[FecIniDiscamec]                        
    ,[FecFinDiscamec]                        
    ,[LugarNacimiento]                        
    ,[Celular]                        
    ,[CelularEmergencia]                        
    ,[ParentescoEmergencia]                        
    ,[DireccionReferencia]                        
    ,[UltimaFechaModif]                        
    ,[TipoPersonaUsuario]                        
    ,[UltimoUsuario]                        
    ,[Estado]                        
    ,[DireccionEmergencia]                        
    ,[TelefonoEmergencia]                        
    ,[BancoMonedaLocal]                        
    ,[TipoCuentaLocal]                        
    ,[CuentaMonedaLocal]                        
    ,[BancoMonedaExtranjera]                        
    ,[TipoCuentaExtranjera]                        
    ,[CuentaMonedaExtranjera]                        
    ,[CorreoElectronico]                        
    ,[EnfermedadGraveFlag]                        
    ,[IngresoFechaRegistro]                        
    ,[IngresoAplicacionCodigo]                        
    ,[IngresoUsuario]                        
    ,[PYMEFlag]                        
    ,[TipoPago]                        
    ,[TipoTrabajador]                        
    ,[Religion]                        
    ,[TipoVisa]                        
    ,[VisaFechaInicio]                        
    ,[VisaFechaExpiracion]                        
    ,[CodigoAFP]                        
    ,[NumeroAFP]                        
    ,[BancoCTS]                        
    ,[TipoCuentaCTS]                        
    ,[TipoMonedaCTS]                        
    ,[NumeroCuentaCTS]                        
    ,[EstadoEmpleado]                        
    ,[TipoPlanilla]                        
    ,[FechaIngreso]                        
    ,[FechaUltimaPlanilla]                        
    ,[TipoContrato]                        
    ,[FechaInicioContrato]                        
    ,[FechaFinContrato]                        
    ,[FechaCese]                        
    ,[RazonCese]                    
    ,[Contratista]                        
    ,[CompaniaSocio]                        
    ,[CentroCostos]                        
    ,[AFE]                        
    ,[DeptoOrganizacion]                        
    ,[TipoHorario]                        
    ,[GradoSalario]                        
    ,[Cargo]                        
    ,[Posicion]                        
    ,[NivelAcceso]                        
    ,[FlagIPSSVIDA]                        
    ,[FlagSindicato]                        
    ,[FlagAccTrabajo]                        
    ,[FlagCooperativa]                        
    ,[FlagRetencionJudicial]                        
    ,[FlagReingresos]              
    ,[FlagComision]                        
    ,[FlagImpuestoRenta]                        
    ,[SueldoActualLocal]                        
    ,[SueldoActualDolar]                        
   ,[SueldoAnteriorLocal]                        
    ,[SueldoAnteriorDolar]                        
    ,[MonedaPago]                        
    ,[TarjetaCredito]                        
    ,[MotivoCese]                        
    ,[DepartamentoOrganizacional]                        
    ,[DepartamentoOperacional]                        
    ,[Perfil]                        
    ,[NivelSalario]                        
    ,[FechaLiquidacion]                        
    ,[FechaReingreso]                        
    ,[UnidadReplicacion]                        
    ,[CodigoCargo]                        
    ,[UltimaFechaPagoVacacion]                        
    ,[Gerencia]                        
    ,[SubGerencia]                        
    ,[RedondeoACuenta]                        
    ,[PlantillaConcepto]                        
    ,[RUCCentroAsistenciaSocial]                        
    ,[Sucursal]                        
    ,[Actividad]                        
    ,[Cliente]                        
    ,[ClienteUnidad]                        
    ,[EmpleadoNivel]                        
    ,[TipoPuesto]                        
    ,[USUARIO]                        
    ,[USUARIOPERFIL]                        
    ,[PERSONAUSUARIO]                        
    ,[CLAVE]                        
    ,[EXPIRARPASSWORDFLAG]                        
    ,[FECHAEXPIRACION]                        
    ,[ULTIMOLOGIN]                        
    ,[Paciente]                        
    ,[TipoPaciente]                        
    ,[Raza]                        
    ,[AreaLaboral]                        
    ,[Ocupacion]                        
    ,[CodigoHC]                        
    ,[CodigoHCAnterior]                        
    ,[CodigoHCSecundario]                        
    ,[TipoAlmacenamiento]                        
    ,[TipoHistoria]                        
    ,[TipoSituacion]                 
    ,[IdUbicacion]                        
    ,[LugarProcedencia]                        
    ,[RutaFoto]                        
    ,[EstadoPaciente]                        
    ,[NumeroFile]                        
    ,[Servicio]                        
    ,[Observacion]                        
    ,[IndicadorAsistencia]                        
    ,[CantidadAsistencia]                        
    ,[UbicacionHHCC]                        
    ,[IndicadorMigradoSiteds]                        
    ,[NumeroCaja]                        
    ,[IndicadorCodigoBarras]                        
    ,[IDPACIENTE_OK]                        
    ,[CodigoAsegurado]                        
    ,[NumeroPoliza]                        
    ,[NumeroCertificado]                        
    ,[CodigoProducto]                        
    ,[CodigoPlan]                        
    ,[TipoParentesco]                        
    ,[CodigoBeneficio]                        
    ,[Situacion]                        
    ,[TomoActual]                        
    ,[IndicadorHistoriaFisica]       
    ,[DescripcionHistoria] 
   
  FROM (                          
    SELECT VW_PERSONAPACIENTE.*,                                      
     @CONTADOR AS Contador,                        
     ROW_NUMBER() OVER (ORDER BY Persona ASC ) AS RowNumber                            
  FROM dbo.VW_PERSONAPACIENTE                        
     WHERE                         
     (@Persona is null or (@Persona =0 )  OR Persona = @Persona)                        
     and (@CodigoCargo is null OR Paciente = @CodigoCargo OR @CodigoCargo = 0)                        
     and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                               
     and (@ESTADO is null OR Estado = @ESTADO)                        
     and (@Usuario is null OR Usuario = @Usuario)                        
     and (@AFE is null OR CodigoHC = @AFE)                        
     and (@Usuario is null OR CodigoHCAnterior = @Usuario)                        
AND (@TipoMedico is null or (@TipoMedico =0 ) OR Situacion = @TipoMedico)                        
     and (@Documento is null  OR  upper(Documento) like '%'+upper(@Documento)+'%')                        
     AND (TipoTrabajador = '08')                        
     ) AS LISTADO                        
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR                          
 RowNumber BETWEEN @Inicio  AND @NumeroFilas                         
 end                        
 ELSE                        
 if(@ACCION = 'LISTARPAGEMPLEADO')                        
 begin                          
                         
  SELECT @CONTADOR= COUNT(*)                              
    FROM dbo.VW_PERSONAPACIENTE                        
     WHERE                         
     (@Persona is null or (@Persona =0 )  OR Persona = @Persona)                        
     and (@Paciente is null OR Paciente = @Paciente)                        
     and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                               
     and (@ESTADO is null OR Estado = @ESTADO)                        
     and (@Usuario is null OR Usuario = @Usuario)                        
     AND (EsEmpleado = 'S')                        
                          
   select [Persona]                        
   ,[Nombres]                        
   ,[Busqueda]                        
   ,[PersonaAnt]                         
    ,[ApellidoPaterno]                        
    ,[ApellidoMaterno]                        
    ,[NombreCompleto]                        
    ,[TipoDocumento]                        
    ,[Documento]                        
    ,[CodigoBarras]                        
   ,[EsCliente]                        
    ,[EsEmpleado]                        
    ,[EsOtro]                        
    ,[TipoPersona]                        
    ,[EsProveedor]                        
    ,[FechaNacimiento]                        
    ,[CiudadNacimiento]                        
    ,[Sexo]                        
    ,[Nacionalidad]                        
    ,[EstadoCivil]                        
    ,[NivelInstruccion]                        
    ,[Direccion]                        
    ,[CodigoPostal]                        
    ,[Provincia]                        
    ,[Departamento]                        
    ,[Telefono]                        
    ,[DocumentoFiscal]                        
    ,[DocumentoIdentidad]                        
    ,[ACCION]                        
    ,[edad]                        
    ,[rangoEtario]                        
    ,[TipoMedico]                        
    ,[Correcion]                        
    ,[EsPaciente]                        
    ,[EsEmpresa]                        
    ,[Pais]                        
    ,[FlagActualizacion]                        
    ,[CuentaMonedaLocal_tmp]                        
    ,[CuentaMonedaExtranjera_tmp]                        
    ,[CorrelativoSCTR]                        
    ,[SeguroDiscamec]                        
    ,[CodDiscamec]                        
    ,[FecIniDiscamec]                        
    ,[FecFinDiscamec]                        
    ,[LugarNacimiento]                        
    ,[Celular]                        
    ,[CelularEmergencia]            
    ,[ParentescoEmergencia]                        
    ,[DireccionReferencia]                        
    ,[UltimaFechaModif]                        
    ,[TipoPersonaUsuario]                        
    ,[UltimoUsuario]                        
    ,[Estado]                        
    ,[DireccionEmergencia]                        
    ,[TelefonoEmergencia]                        
    ,[BancoMonedaLocal]                        
    ,[TipoCuentaLocal]                        
    ,[CuentaMonedaLocal]                        
    ,[BancoMonedaExtranjera]                        
    ,[TipoCuentaExtranjera]                        
    ,[CuentaMonedaExtranjera]                        
    ,[CorreoElectronico]                        
    ,[EnfermedadGraveFlag]                        
    ,[IngresoFechaRegistro]                        
    ,[IngresoAplicacionCodigo]           
    ,[IngresoUsuario]                        
    ,[PYMEFlag]                        
    ,[TipoPago]                        
    ,[TipoTrabajador]                        
    ,[Religion]                        
    ,[TipoVisa]                        
    ,[VisaFechaInicio]                        
    ,[VisaFechaExpiracion]                        
    ,[CodigoAFP]                        
    ,[NumeroAFP]                        
    ,[BancoCTS]                        
    ,[TipoCuentaCTS]                        
    ,[TipoMonedaCTS]                        
    ,[NumeroCuentaCTS]                        
    ,[EstadoEmpleado]                        
    ,[TipoPlanilla]                        
    ,[FechaIngreso]                        
    ,[FechaUltimaPlanilla]                        
    ,[TipoContrato]                    
    ,[FechaInicioContrato]                        
    ,[FechaFinContrato]                        
    ,[FechaCese]                        
    ,[RazonCese]                        
    ,[Contratista]                        
    ,[CompaniaSocio]                        
    ,[CentroCostos]                        
    ,[AFE]                        
    ,[DeptoOrganizacion]                        
    ,[TipoHorario]                        
    ,[GradoSalario]                        
    ,[Cargo]                        
    ,[Posicion]                        
    ,[NivelAcceso]                        
    ,[FlagIPSSVIDA]                        
    ,[FlagSindicato]                        
    ,[FlagAccTrabajo]                        
    ,[FlagCooperativa]                        
    ,[FlagRetencionJudicial]                        
    ,[FlagReingresos]                        
    ,[FlagComision]             
    ,[FlagImpuestoRenta]                        
    ,[SueldoActualLocal]                        
    ,[SueldoActualDolar]                        
    ,[SueldoAnteriorLocal]                        
    ,[SueldoAnteriorDolar]                        
    ,[MonedaPago]                        
    ,[TarjetaCredito]                        
    ,[MotivoCese]                        
    ,[DepartamentoOrganizacional]                        
    ,[DepartamentoOperacional]                        
    ,[Perfil]                        
    ,[NivelSalario]                        
    ,[FechaLiquidacion]                        
    ,[FechaReingreso]                        
    ,[UnidadReplicacion]                        
   ,[CodigoCargo]                        
    ,[UltimaFechaPagoVacacion]                        
    ,[Gerencia]                        
    ,[SubGerencia]                        
    ,[RedondeoACuenta]                        
    ,[PlantillaConcepto]                        
    ,[RUCCentroAsistenciaSocial]                        
    ,[Sucursal]                        
    ,[Actividad]                        
    ,[Cliente]                        
    ,[ClienteUnidad]                        
    ,[EmpleadoNivel]                        
    ,[TipoPuesto]                        
    ,[USUARIO]                        
    ,[USUARIOPERFIL]                        
    ,[PERSONAUSUARIO]                        
    ,[CLAVE]                        
    ,[EXPIRARPASSWORDFLAG]                        
    ,[FECHAEXPIRACION]                        
    ,[ULTIMOLOGIN]                        
    ,[Paciente]                        
    ,[TipoPaciente]                        
    ,[Raza]                        
    ,[AreaLaboral]                        
    ,[Ocupacion]                        
    ,[CodigoHC]                      
    ,[CodigoHCAnterior]                        
    ,[CodigoHCSecundario]                        
    ,[TipoAlmacenamiento]                        
    ,[TipoHistoria]                        
    ,[TipoSituacion]                        
    ,[IdUbicacion]                        
    ,[LugarProcedencia]                        
    ,[RutaFoto]                        
    ,[EstadoPaciente]                        
    ,[NumeroFile]                        
    ,[Servicio]                        
    ,[Observacion]                        
    ,[IndicadorAsistencia]                        
    ,[CantidadAsistencia]                        
    ,[UbicacionHHCC]                
    ,[IndicadorMigradoSiteds]                        
    ,[NumeroCaja]                        
    ,[IndicadorCodigoBarras]                        
    ,[IDPACIENTE_OK]                        
    ,[CodigoAsegurado]                        
    ,[NumeroPoliza]                        
    ,[NumeroCertificado]                        
    ,[CodigoProducto]                        
    ,[CodigoPlan]                        
    ,[TipoParentesco]                        
    ,[CodigoBeneficio]                        
    ,[Situacion]                        
    ,[TomoActual]                        
    ,[IndicadorHistoriaFisica]                        
    ,[DescripcionHistoria]    
   
  FROM (                          
    SELECT VW_PERSONAPACIENTE.*,                                      
     @CONTADOR AS Contador,                        
     ROW_NUMBER() OVER (ORDER BY Persona ASC ) AS RowNumber                            
  FROM dbo.VW_PERSONAPACIENTE                        
     WHERE                         
     (@Persona is null or (@Persona =0 )  OR Persona = @Persona)                        
     and (@Paciente is null OR Paciente = @Paciente)                        
     and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                               
     and (@ESTADO is null OR Estado = @ESTADO)                        
     and (@Usuario is null OR Usuario = @Usuario)                       
     AND (EsEmpleado = 'S')                        
     ) AS LISTADO                        
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR                          
            RowNumber BETWEEN @Inicio  AND @NumeroFilas                         
 end       

  ELSE IF(@ACCION = 'LISTARPACPER_TRIAJE')                    
 BEGIN                    
 SELECT @CONTADOR= COUNT(*)FROM dbo.VW_PERSONAPACIENTE      
 WHERE (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                               
                 AND (EsEmpresa = 'N' OR EsEmpresa IS NULL      )  
   select       
   [Persona]                        
   ,[Nombres]                        
   ,[Busqueda]                        
   ,[PersonaAnt]                         
   ,[ApellidoPaterno]                        
   ,[ApellidoMaterno]                        
   ,[NombreCompleto]                        
   ,[TipoDocumento]                        
   ,[Documento]                        
   ,[CodigoBarras]                        
   ,[EsCliente]                        
   ,[EsEmpleado]                        
   ,[EsOtro]                        
   ,[TipoPersona]                        
   ,[EsProveedor]                        
   ,[FechaNacimiento]                        
   ,[CiudadNacimiento]                        
   ,[Sexo]                        
   ,[Nacionalidad]                        
   ,[EstadoCivil]                        
   ,[NivelInstruccion]                        
   ,[Direccion]                        
   ,[CodigoPostal]                        
   ,[Provincia]                        
   ,[Departamento]                        
   ,[Telefono]                        
   ,[DocumentoFiscal]                        
   ,[DocumentoIdentidad]                        
   ,[ACCION]                        
   ,[edad]                        
   ,[rangoEtario]                        
   ,[TipoMedico]                        
   ,[Correcion]                        
   ,[EsPaciente]                        
   ,[EsEmpresa]                        
   ,[Pais]                        
   ,[FlagActualizacion]                        
   ,[CuentaMonedaLocal_tmp]                        
   ,[CuentaMonedaExtranjera_tmp]               
   ,[CorrelativoSCTR]                        
   ,[SeguroDiscamec]                        
   ,[CodDiscamec]                        
   ,[FecIniDiscamec]                        
   ,[FecFinDiscamec]                        
   ,[LugarNacimiento]                        
   ,[Celular]                        
   ,[CelularEmergencia]                        
   ,[ParentescoEmergencia]                        
   ,[DireccionReferencia]       
   ,[UltimaFechaModif]                        
   ,[TipoPersonaUsuario]                        
   ,[UltimoUsuario]                        
   ,[Estado]                        
   ,[DireccionEmergencia]                        
   ,[TelefonoEmergencia]                        
   ,[BancoMonedaLocal]                        
   ,[TipoCuentaLocal]                        
   ,[CuentaMonedaLocal]                        
   ,[BancoMonedaExtranjera]                        
   ,[TipoCuentaExtranjera]                        
   ,[CuentaMonedaExtranjera]                        
   ,[CorreoElectronico]                        
   ,[EnfermedadGraveFlag]                        
   ,[IngresoFechaRegistro]                        
   ,[IngresoAplicacionCodigo]                        
   ,[IngresoUsuario]                        
   ,[PYMEFlag]                        
   ,[TipoPago]                        
   ,[TipoTrabajador]                        
   ,[Religion]                        
   ,[TipoVisa]                        
   ,[VisaFechaInicio]                        
   ,[VisaFechaExpiracion]                        
   ,[CodigoAFP]                        
   ,[NumeroAFP]                        
   ,[BancoCTS]                        
   ,[TipoCuentaCTS]                        
   ,[TipoMonedaCTS]                        
   ,[NumeroCuentaCTS]                        
   ,[EstadoEmpleado]                        
   ,[TipoPlanilla]                        
   ,[FechaIngreso]                        
   ,[FechaUltimaPlanilla]                        
   ,[TipoContrato]                        
   ,[FechaInicioContrato]                        
   ,[FechaFinContrato]                        
   ,[FechaCese]                        
   ,[RazonCese]                        
   ,[Contratista]                        
   ,[CompaniaSocio]                        
   ,[CentroCostos]                        
   ,[AFE]                        
   ,[DeptoOrganizacion]                        
   ,[TipoHorario]                        
   ,[GradoSalario]                        
   ,[Cargo]                        
   ,[Posicion]                        
   ,[NivelAcceso]                        
   ,[FlagIPSSVIDA]                        
   ,[FlagSindicato]                        
   ,[FlagAccTrabajo]                        
   ,[FlagCooperativa]                        
   ,[FlagRetencionJudicial]                        
   ,[FlagReingresos]                        
   ,[FlagComision]             
   ,[FlagImpuestoRenta]                        
   ,[SueldoActualLocal]                        
   ,[SueldoActualDolar]                        
   ,[SueldoAnteriorLocal]                        
   ,[SueldoAnteriorDolar]                        
   ,[MonedaPago]                        
   ,[TarjetaCredito]                        
   ,[MotivoCese]                        
   ,[DepartamentoOrganizacional]                        
   ,[DepartamentoOperacional]                        
   ,[Perfil]                        
   ,[NivelSalario]                        
   ,[FechaLiquidacion]                        
   ,[FechaReingreso]                        
   ,[UnidadReplicacion]                        
   ,[CodigoCargo]                        
   ,[UltimaFechaPagoVacacion]                        
   ,[Gerencia]                        
   ,[SubGerencia]                        
   ,[RedondeoACuenta]                        
   ,[PlantillaConcepto]                        
   ,[RUCCentroAsistenciaSocial]                        
   ,[Sucursal]                        
   ,[Actividad]                        
   ,[Cliente]                        
   ,[ClienteUnidad]                        
   ,[EmpleadoNivel]                        
   ,[TipoPuesto]                        
   ,[USUARIO]                        
   ,[USUARIOPERFIL]                        
   ,[PERSONAUSUARIO]                        
   ,[CLAVE]                        
   ,[EXPIRARPASSWORDFLAG]                        
   ,[FECHAEXPIRACION]                        
   ,[ULTIMOLOGIN]                        
   ,[Paciente]                        
   ,[TipoPaciente]                        
   ,[Raza]                        
   ,[AreaLaboral]                        
   ,[Ocupacion]                        
   ,[CodigoHC]                      
   ,[CodigoHCAnterior]                        
   ,[CodigoHCSecundario]                        
   ,[TipoAlmacenamiento]                        
   ,[TipoHistoria]                        
   ,[TipoSituacion]                        
   ,[IdUbicacion]             
   ,[LugarProcedencia]                        
   ,[RutaFoto]                        
   ,[EstadoPaciente]                        
   ,[NumeroFile]                        
   ,[Servicio]                        
   ,[Observacion]                        
   ,[IndicadorAsistencia]                        
   ,[CantidadAsistencia]                        
   ,[UbicacionHHCC]                        
   ,[IndicadorMigradoSiteds]                        
   ,[NumeroCaja]                        
   ,[IndicadorCodigoBarras]                        
   ,[IDPACIENTE_OK]                        
   ,[CodigoAsegurado]                        
   ,[NumeroPoliza]                        
   ,[NumeroCertificado]                        
   ,[CodigoProducto]                        
   ,[CodigoPlan]                        
   ,[TipoParentesco]                        
   ,[CodigoBeneficio]                        
   ,[Situacion]                        
   ,[TomoActual]                        
   ,[IndicadorHistoriaFisica]                        
   ,[UnidadReplicacion] as DescripcionHistoria      
   
   FROM (      
   SELECT VW_PERSONAPACIENTE.*,      
   @CONTADOR AS Contador,      
   ROW_NUMBER() OVER (ORDER BY Persona ASC ) AS RowNumber      
   FROM dbo.VW_PERSONAPACIENTE      
   WHERE       
   (@Usuario  is null OR UnidadReplicacion = @Usuario)
        AND (@NombreCompleto is null or @NombreCompleto='' or UPPER(NombreCompleto)like '%'+upper(@NombreCompleto)+'%')
        AND (@Nombres is null or @Nombres='' or UPPER(CodigoHC)like '%'+upper(@Nombres)+'%')        
		AND (@Documento is null or @Documento='' or UPPER(Documento)like '%'+upper(@Documento)+'%')
   
    
   AND (EsEmpresa = 'N' OR EsEmpresa IS NULL  )  
   ) AS LISTADO      
   WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR RowNumber BETWEEN @Inicio  AND @NumeroFilas      
   END      

  ELSE IF(@ACCION = 'LISTARPACPER')                    
 BEGIN                    
 SELECT @CONTADOR= COUNT(*)FROM dbo.VW_PERSONAPACIENTE      
 WHERE (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')                               
                 AND (EsEmpresa = 'N' OR EsEmpresa IS NULL      )  
   select       
   [Persona]                        
   ,[Nombres]                        
   ,[Busqueda]                        
   ,[PersonaAnt]                         
   ,[ApellidoPaterno]                        
   ,[ApellidoMaterno]                        
   ,[NombreCompleto]                        
   ,[TipoDocumento]                        
   ,[Documento]                        
   ,[CodigoBarras]                        
   ,[EsCliente]                        
   ,[EsEmpleado]                        
   ,[EsOtro]                        
   ,[TipoPersona]                        
   ,[EsProveedor]                        
   ,[FechaNacimiento]                        
   ,[CiudadNacimiento]                        
   ,[Sexo]                        
   ,[Nacionalidad]                        
   ,[EstadoCivil]                        
   ,[NivelInstruccion]                        
   ,[Direccion]                        
   ,[CodigoPostal]                        
   ,[Provincia]                        
   ,[Departamento]                        
   ,[Telefono]                        
   ,[DocumentoFiscal]                        
   ,[DocumentoIdentidad]                        
   ,[ACCION]                        
   ,[edad]                        
   ,[rangoEtario]                        
   ,[TipoMedico]                        
   ,[Correcion]                        
   ,[EsPaciente]                        
   ,[EsEmpresa]                        
   ,[Pais]                        
   ,[FlagActualizacion]                        
   ,[CuentaMonedaLocal_tmp]                        
   ,[CuentaMonedaExtranjera_tmp]               
   ,[CorrelativoSCTR]                        
   ,[SeguroDiscamec]                        
   ,[CodDiscamec]                        
   ,[FecIniDiscamec]                        
   ,[FecFinDiscamec]                        
   ,[LugarNacimiento]                        
   ,[Celular]                        
   ,[CelularEmergencia]                        
   ,[ParentescoEmergencia]                        
   ,[DireccionReferencia]       
   ,[UltimaFechaModif]                        
   ,[TipoPersonaUsuario]                        
   ,[UltimoUsuario]                        
   ,[Estado]                        
   ,[DireccionEmergencia]                        
   ,[TelefonoEmergencia]                        
   ,[BancoMonedaLocal]                        
   ,[TipoCuentaLocal]                        
   ,[CuentaMonedaLocal]                        
   ,[BancoMonedaExtranjera]                        
   ,[TipoCuentaExtranjera]                        
   ,[CuentaMonedaExtranjera]                        
   ,[CorreoElectronico]                        
   ,[EnfermedadGraveFlag]                        
   ,[IngresoFechaRegistro]                        
   ,[IngresoAplicacionCodigo]                        
   ,[IngresoUsuario]                        
   ,[PYMEFlag]                        
   ,[TipoPago]                        
   ,[TipoTrabajador]                        
   ,[Religion]                        
   ,[TipoVisa]                        
   ,[VisaFechaInicio]                        
   ,[VisaFechaExpiracion]                        
   ,[CodigoAFP]                        
   ,[NumeroAFP]                        
   ,[BancoCTS]                        
   ,[TipoCuentaCTS]                        
   ,[TipoMonedaCTS]                        
   ,[NumeroCuentaCTS]                        
   ,[EstadoEmpleado]                        
   ,[TipoPlanilla]                        
   ,[FechaIngreso]                        
   ,[FechaUltimaPlanilla]                        
   ,[TipoContrato]                        
   ,[FechaInicioContrato]                        
   ,[FechaFinContrato]                        
   ,[FechaCese]                        
   ,[RazonCese]                        
   ,[Contratista]                        
   ,[CompaniaSocio]                        
   ,[CentroCostos]                        
   ,[AFE]                        
   ,[DeptoOrganizacion]                        
   ,[TipoHorario]                        
   ,[GradoSalario]                        
   ,[Cargo]                        
   ,[Posicion]                        
   ,[NivelAcceso]                        
   ,[FlagIPSSVIDA]                        
   ,[FlagSindicato]                        
   ,[FlagAccTrabajo]                        
   ,[FlagCooperativa]                        
   ,[FlagRetencionJudicial]                        
   ,[FlagReingresos]                        
   ,[FlagComision]             
   ,[FlagImpuestoRenta]                        
   ,[SueldoActualLocal]                        
   ,[SueldoActualDolar]                        
   ,[SueldoAnteriorLocal]                        
   ,[SueldoAnteriorDolar]                        
   ,[MonedaPago]                        
   ,[TarjetaCredito]                        
   ,[MotivoCese]                        
   ,[DepartamentoOrganizacional]                        
   ,[DepartamentoOperacional]                        
   ,[Perfil]                        
   ,[NivelSalario]                        
   ,[FechaLiquidacion]                        
   ,[FechaReingreso]                        
   ,[UnidadReplicacion]                        
   ,[CodigoCargo]                        
   ,[UltimaFechaPagoVacacion]                        
   ,[Gerencia]                        
   ,[SubGerencia]                        
   ,[RedondeoACuenta]                        
   ,[PlantillaConcepto]                        
   ,[RUCCentroAsistenciaSocial]                        
   ,[Sucursal]                        
   ,[Actividad]                        
   ,[Cliente]                        
   ,[ClienteUnidad]                        
   ,[EmpleadoNivel]                        
   ,[TipoPuesto]                        
   ,[USUARIO]                        
   ,[USUARIOPERFIL]                        
   ,[PERSONAUSUARIO]                        
   ,[CLAVE]                        
   ,[EXPIRARPASSWORDFLAG]                        
   ,[FECHAEXPIRACION]                        
   ,[ULTIMOLOGIN]                        
   ,[Paciente]                        
   ,[TipoPaciente]                        
   ,[Raza]                        
   ,[AreaLaboral]                        
   ,[Ocupacion]                        
   ,[CodigoHC]                      
   ,[CodigoHCAnterior]                        
   ,[CodigoHCSecundario]                        
   ,[TipoAlmacenamiento]                        
   ,[TipoHistoria]                        
   ,[TipoSituacion]                        
   ,[IdUbicacion]             
   ,[LugarProcedencia]                        
   ,[RutaFoto]                        
   ,[EstadoPaciente]                        
   ,[NumeroFile]                        
   ,[Servicio]                        
   ,[Observacion]                        
   ,[IndicadorAsistencia]                        
   ,[CantidadAsistencia]                        
   ,[UbicacionHHCC]                        
   ,[IndicadorMigradoSiteds]                        
   ,[NumeroCaja]                        
   ,[IndicadorCodigoBarras]                        
   ,[IDPACIENTE_OK]                        
   ,[CodigoAsegurado]                        
   ,[NumeroPoliza]                        
   ,[NumeroCertificado]                        
   ,[CodigoProducto]                        
   ,[CodigoPlan]                        
   ,[TipoParentesco]                        
   ,[CodigoBeneficio]                        
   ,[Situacion]                        
   ,[TomoActual]                        
   ,[IndicadorHistoriaFisica]                        
   ,[DescripcionHistoria]      
   
   FROM (      
   SELECT VW_PERSONAPACIENTE.*,      
   @CONTADOR AS Contador,      
   ROW_NUMBER() OVER (ORDER BY Persona ASC ) AS RowNumber      
   FROM dbo.VW_PERSONAPACIENTE      
   WHERE       
   (
   @NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%' --and

   )      
    
   AND (EsEmpresa = 'N' OR EsEmpresa IS NULL  )  
   ) AS LISTADO      
   WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR RowNumber BETWEEN @Inicio  AND @NumeroFilas      
   END                         
                   
END

/****** Object:  StoredProcedure [dbo].[SP_VW_ATENCIONPACIENTE_LISTAR]    Script Date: 19/04/2022 22:31:17 ******/
SET ANSI_NULLS ON
GO
/****** Object:  StoredProcedure [dbo].[SP_VW_SS_GE_EmpresaSeguro]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_VW_SS_GE_EmpresaSeguro]  
@IDEMPRESA INT,  
@CODIGO VARCHAR(15),  
@DESCRIPCION VARCHAR(150),  
@TIPOEMPRESA VARCHAR(1),  
@TIPOSEGURO INT,  
  
@ESTADO INT,  
@USUARIOCREACION VARCHAR(25),  
@FECHACREACION DATETIME,  
@USUARIOMODIFICACION VARCHAR(25),  
@FECHAMODIFICACION DATETIME,  
  
@ACCION VARCHAR(25),  
@PERSONA INT,  
@NOMBRECOMPLETO VARCHAR(100),  
@DOCUMENTOFISCAL VARCHAR(20),  
@DIRECCION VARCHAR(190),  
  
@TELEFONO VARCHAR(15),  
@TIPOEMPRESANOMBRE VARCHAR(80),  
@TIPOSEGURONOMBRE VARCHAR(80)  
AS   
  BEGIN   
      SET nocount ON;   
  
       IF( @ACCION = 'LISTARPAG' )   
        BEGIN   
            DECLARE @CONTADOR INT   
  
            SET @CONTADOR = (SELECT Count(*) FROM   VW_SS_GE_EMPRESASEGURO   
                             WHERE  ( @CODIGO IS NULL OR Upper(CODIGO) LIKE '%' + Upper(@CODIGO) + '%' )   
                             AND ( @TIPOEMPRESA IS NULL OR Upper(TIPOEMPRESA) LIKE '%' + Upper(@TIPOEMPRESA) + '%' )   
                                AND ( @TIPOSEGURO IS NULL OR TIPOSEGURO = @TIPOSEGURO OR @TIPOSEGURO=0 )   
                                AND ( @DESCRIPCION IS NULL OR Upper(DESCRIPCION) LIKE '%' + Upper(@DESCRIPCION) + '%' )   
                                AND ( @DOCUMENTOFISCAL IS NULL OR Upper(RTRIM(DOCUMENTOFISCAL)) LIKE '%' + Upper(RTRIM(@DOCUMENTOFISCAL)) + '%' ))   
           SELECT @CONTADOR;   
        END   
  END   
/*    
EXEC SP_VW_SS_GE_EMPRESASEGURO    
NULL,NULL, NULL, NULL, 0,    
NULL, NULL, NULL, NULL, NULL,    
LISTARPAG, NULL, NULL, NULL, NULL,  
NULL, NULL ,NULL   
*/   
GO
/****** Object:  StoredProcedure [dbo].[SP_VW_SS_GE_EmpresaSeguroListar]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_VW_SS_GE_EmpresaSeguroListar]   
  @IDEMPRESA           INT,   
  @CODIGO              VARCHAR(15),   
  @DESCRIPCION         VARCHAR(150),   
  @TIPOEMPRESA         VARCHAR(1),   
  @TIPOSEGURO          INT,   
    
  @ESTADO              INT,   
  @USUARIOCREACION     VARCHAR(25),   
  @FECHACREACION       DATETIME,   
  @USUARIOMODIFICACION VARCHAR(25),   
  @FECHAMODIFICACION   DATETIME,   
    
  @ACCION              VARCHAR(25),   
  @PERSONA             INT,   
  @NOMBRECOMPLETO      VARCHAR(100),   
  @DOCUMENTOFISCAL     VARCHAR(20),   
  @DIRECCION           VARCHAR(190),   
    
  @TELEFONO            VARCHAR(15),   
  @TIPOEMPRESANOMBRE   VARCHAR(80),   
  @TIPOSEGURONOMBRE    VARCHAR(80),   
  @INICIO              INT = NULL,   
  @NUMEROFILAS         INT = NULL   
AS   
  BEGIN   
    SET nocount ON;   
    IF( @ACCION = 'LISTARPAG' )   
    BEGIN   
      DECLARE @CONTADOR INT   
      SET @CONTADOR = ( SELECT Count(*) FROM   vw_ss_ge_empresaseguro   
             WHERE  ( @CODIGO IS NULL OR Upper(codigo) LIKE '%' + Upper(@CODIGO) + '%' )   
             AND    ( @TIPOEMPRESA IS NULL OR Upper(tipoempresa) LIKE '%' + Upper(@TIPOEMPRESA) + '%' )   
             AND    ( @TIPOSEGURO IS NULL OR tiposeguro = @TIPOSEGURO OR @TIPOSEGURO=0 )   
             AND    ( @DESCRIPCION IS NULL OR Upper(descripcion) LIKE '%' + Upper(@DESCRIPCION) + '%' )   
             AND    ( @DOCUMENTOFISCAL IS NULL OR Upper(RTRIM(documentofiscal)) LIKE '%' + Upper(RTRIM(@DOCUMENTOFISCAL)) + '%' ))  
               
      SELECT idempresa,   
             codigo,   
             descripcion,   
             tipoempresa,   
             tiposeguro,   
             estado,   
             usuariocreacion,   
             fechacreacion,   
             usuariomodificacion,   
             fechamodificacion,   
             accion,   
             persona,   
             nombrecompleto,   
             documentofiscal,   
             direccion,   
             telefono,   
             tipoempresanombre,   
             tiposeguronombre   
      FROM   (   
                    SELECT idempresa,   
                           codigo,   
                           descripcion,   
                           tipoempresa,   
                           tiposeguro,   
                           estado,   
                           usuariocreacion,   
                           fechacreacion,   
                           usuariomodificacion,   
                           fechamodificacion,   
                           accion,   
                           persona,   
                           nombrecompleto,   
                           documentofiscal,   
                           direccion,   
                           telefono,   
                           tipoempresanombre,   
                           tiposeguronombre,   
                           @CONTADOR                        AS contador,   
                           row_number() OVER(ORDER BY idempresa ASC) AS rownumber   
                    FROM   vw_ss_ge_empresaseguro   
                   WHERE  ( @CODIGO IS NULL OR Upper(codigo) LIKE '%' + Upper(@CODIGO) + '%' )   
       AND    ( @TIPOEMPRESA IS NULL OR Upper(tipoempresa) LIKE '%' + Upper(@TIPOEMPRESA) + '%' )   
       AND    ( @TIPOSEGURO IS NULL OR tiposeguro = @TIPOSEGURO OR @TIPOSEGURO=0 )   
          AND    ( @DESCRIPCION IS NULL OR Upper(descripcion) LIKE '%' + Upper(@DESCRIPCION) + '%' )   
       AND    ( @DOCUMENTOFISCAL IS NULL OR Upper(RTRIM(documentofiscal)) LIKE '%' + Upper(RTRIM(@DOCUMENTOFISCAL)) + '%' ) )AS empresaseguro  
  WHERE  ( @INICIO IS NULL AND  @NUMEROFILAS IS NULL) OR     ( rownumber BETWEEN @INICIO AND    @NUMEROFILAS)   
    END   
  END   
  /*   
EXEC SP_VW_SS_GE_EMPRESASEGUROLISTAR   
NULL,NULL, NULL, NULL, 0,   
NULL, NULL, NULL, NULL, NULL,   
LISTARPAG, NULL, NULL, NULL, NULL,   
NULL, NULL ,NULL, 0, 10   
*/
GO
/****** Object:  StoredProcedure [dbo].[SP_VW_SS_GE_EspecialidadMedico]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_VW_SS_GE_EspecialidadMedico]     
@PERSONA                    INT,     
@ORIGEN                     CHAR (4),     
@NOMBRES     VARCHAR(40),     
@NOMBRECOMPLETO    VARCHAR(100),     
@BUSQUEDA     VARCHAR(100),     
    
@TIPODOCUMENTOIDENTIDAD     CHAR (1),     
@DOCUMENTOIDENTIDAD         CHAR (20),     
@ESCLIENTE                  CHAR (1),     
@ESPROVEEDOR                CHAR (1),     
@ESEMPLEADO                 CHAR (1),     
    
@ESOTRO                     CHAR (1),     
@TIPOPERSONA                CHAR (1),     
@FECHANACIMIENTO   DATETIME,     
@CIUDADNACIMIENTO           CHAR (20),     
@DOCUMENTOFISCAL            CHAR (20),     
    
@DOCUMENTO                  CHAR (20),     
@PERSONAANT                 CHAR (15),     
@CORREOELECTRONICO   VARCHAR(50),     
@CLASEPERSONACODIGO         CHAR (3),     
@ESTADO                     CHAR (1),     
    
@ULTIMOUSUARIO    VARCHAR(25),     
@ULTIMAFECHAMODIF   DATETIME,     
@TIPOPERSONAUSUARIO         CHAR (3),     
@CMP      VARCHAR(25),     
@FOTO      VARCHAR(150),     
    
@NUMEROREGISTROESPECIALIDAD VARCHAR(25),     
@TIPOGENERACIONCITA         INT,     
@TIEMPOPROMEDIOATENCION  NUMERIC(9, 2),     
@IDESPECIALIDAD             INT,     
@NOMBRE      VARCHAR(80),     
    
@ACCION      VARCHAR(25),     
@SEXO                       CHAR (1),     
@DIRECCION     VARCHAR(190),     
@TELEFONO     VARCHAR(15),     
@PROGRAMADO                 INT,     
    
@SERVICIO                   INT,     
@TIPOHORARIO    VARCHAR(3),     
@IDHORARIO                  INT,     
@CODIGOUSUARIO    VARCHAR(25)    
--,@Codigo      VARCHAR(15)     
AS     
  BEGIN     
      SET nocount ON;     
    
    DECLARE @SUCURSAL VARCHAR(15) =null
    DECLARE @COMPANIA VARCHAR(15)=null
    select @SUCURSAL = Sucursal from CM_CO_Establecimiento
    WHERE (IdEstablecimiento = @PROGRAMADO)


    select @COMPANIA = Compania from CM_CO_Establecimiento
    WHERE (IdEstablecimiento = @PROGRAMADO)

    
      IF( @ACCION = 'LISTARPAG' )     
        BEGIN     
            DECLARE @CONTADOR INT     
    
            SET @CONTADOR = (SELECT Count(*)     
                             FROM   vw_ss_ge_especialidadmedico  
                             JOIN EMPLEADOMAST ON (EMPLEADOMAST.Empleado = PERSONA)    
						 WHERE  ( @CMP IS NULL OR Upper(rtrim(vw_ss_ge_especialidadmedico.CMP)) LIKE '%' + Upper(rtrim(@CMP)) + '%' )     
								AND ( @NOMBRECOMPLETO IS NULL OR Upper(nombrecompleto) LIKE '%' + Upper(@NOMBRECOMPLETO) + '%' )   
								AND ( @NUMEROREGISTROESPECIALIDAD IS NULL OR Upper(numeroregistroespecialidad) LIKE '%' + Upper( @NUMEROREGISTROESPECIALIDAD) + '%' )   
								AND ( @NOMBRE IS NULL OR Upper(nombre) LIKE '%' + Upper(@NOMBRE) + '%' )   
								AND ( @ESTADO IS NULL OR vw_ss_ge_especialidadmedico.estado = @ESTADO )  
								AND ( @IDESPECIALIDAD IS NULL OR vw_ss_ge_especialidadmedico.IDESPECIALIDAD = @IDESPECIALIDAD or @IDESPECIALIDAD = 0)  
								AND ( @PERSONA IS NULL OR PERSONA = @PERSONA OR @PERSONA = 0)
								AND ( @COMPANIA IS NULL OR EMPLEADOMAST.CompaniaSocio = @COMPANIA)
								AND ( @SUCURSAL IS NULL OR convert(varchar,EMPLEADOMAST.Sucursal) = @SUCURSAL))   
                    
    
            SELECT @CONTADOR;     
        END     
  END     
/*       
EXEC SP_VW_SS_GE_ESPECIALIDADMEDICO       
NULL,NULL, NULL, NULL, NULL,       
NULL, NULL, NULL, NULL, NULL,       
NULL, NULL, NULL, NULL, NULL,     
NULL, NULL, NULL, NULL, NULL,     
NULL, NULL, NULL, NULL, NULL,     
NULL, NULL, NULL, NULL, NULL,     
'LISTARPAG', NULL, NULL, NULL, NULL,     
NULL, NULL, NULL, NULL, NULL    
*/ 
GO
/****** Object:  StoredProcedure [dbo].[SP_VW_SS_GE_EspecialidadMedicoListar]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_VW_SS_GE_EspecialidadMedicoListar]     
@PERSONA                    INT,     
@ORIGEN                     CHAR (4),     
@NOMBRES                    VARCHAR(40),     
@NOMBRECOMPLETO             VARCHAR(100),     
@BUSQUEDA                   VARCHAR(100),     
    
@TIPODOCUMENTOIDENTIDAD     CHAR (1),     
@DOCUMENTOIDENTIDAD         CHAR (20),     
@ESCLIENTE                  CHAR (1),     
@ESPROVEEDOR                CHAR (1),     
@ESEMPLEADO                 CHAR (1),     
    
@ESOTRO                     CHAR (1),     
@TIPOPERSONA                CHAR (1),     
@FECHANACIMIENTO            DATETIME,     
@CIUDADNACIMIENTO           CHAR (20),     
@DOCUMENTOFISCAL            CHAR (20),     
    
@DOCUMENTO                  CHAR (20),     
@PERSONAANT                 CHAR (15),     
@CORREOELECTRONICO          VARCHAR(50),     
@CLASEPERSONACODIGO         CHAR (3),     
@ESTADO                     CHAR (1),     
    
@ULTIMOUSUARIO              VARCHAR(25),     
@ULTIMAFECHAMODIF           DATETIME,     
@TIPOPERSONAUSUARIO         CHAR (3),     
@CMP                        VARCHAR(25),     
@FOTO                       VARCHAR(150),     
    
@NUMEROREGISTROESPECIALIDAD VARCHAR(25),     
@TIPOGENERACIONCITA         INT,     
@TIEMPOPROMEDIOATENCION     NUMERIC(9, 2),     
@IDESPECIALIDAD             INT,     
@NOMBRE                     VARCHAR(80),     
    
@ACCION                     VARCHAR(25),     
@SEXO                       CHAR (1),     
@DIRECCION                  VARCHAR(190),     
@TELEFONO                   VARCHAR(15),     
@PROGRAMADO                 INT,     
    
@SERVICIO                   INT,     
@TIPOHORARIO                VARCHAR(3),     
@IDHORARIO                  INT,     
@CODIGOUSUARIO              VARCHAR(25),     
--@Codigo                     VARCHAR(15),     
    
@INICIO                     INT = NULL,     
@NUMEROFILAS                INT = NULL     
AS     
  BEGIN     
    SET nocount ON;     
    IF( @ACCION = 'LISTARPAG' )     
    BEGIN     
    DECLARE @SUCURSAL VARCHAR(15) =null  
    DECLARE @COMPANIA VARCHAR(15)=null  
    select @SUCURSAL = Sucursal from CM_CO_Establecimiento  
    WHERE (IdEstablecimiento = @PROGRAMADO)  
  
  
    select @COMPANIA = Compania from CM_CO_Establecimiento  
    WHERE (IdEstablecimiento = @PROGRAMADO)  
      
      DECLARE @CONTADOR INT     
      SET @CONTADOR =     
      (     
             SELECT Count(*)     
             FROM   vw_ss_ge_especialidadmedico     
             JOIN EMPLEADOMAST ON (EMPLEADOMAST.Empleado = PERSONA)  
             WHERE  ( @CMP IS NULL OR Upper(rtrim(vw_ss_ge_especialidadmedico.CMP)) LIKE '%' + Upper(rtrim(@CMP)) + '%' )       
                    AND ( @NOMBRECOMPLETO IS NULL OR Upper(nombrecompleto) LIKE '%' + Upper(@NOMBRECOMPLETO) + '%' )     
                    AND ( @NUMEROREGISTROESPECIALIDAD IS NULL OR Upper(numeroregistroespecialidad) LIKE '%' + Upper( @NUMEROREGISTROESPECIALIDAD) + '%' )     
                    AND ( @NOMBRE IS NULL OR Upper(nombre) LIKE '%' + Upper(@NOMBRE) + '%' )     
                    AND ( @ESTADO IS NULL OR vw_ss_ge_especialidadmedico.estado = @ESTADO )    
                    AND ( @IDESPECIALIDAD IS NULL OR vw_ss_ge_especialidadmedico.IDESPECIALIDAD = @IDESPECIALIDAD or @IDESPECIALIDAD = 0)    
                    AND ( @PERSONA IS NULL OR PERSONA = @PERSONA OR @PERSONA = 0)  
                    AND ( @COMPANIA IS NULL OR EMPLEADOMAST.CompaniaSocio = @COMPANIA)  
                    AND ( @SUCURSAL IS NULL OR convert(varchar,EMPLEADOMAST.Sucursal) = @SUCURSAL))     
                              
      SELECT convert(integer ,rownumber )AS persona,     
             origen,     
             nombres,     
             nombrecompleto,     
             busqueda,     
             tipodocumentoidentidad,     
             documentoidentidad,     
             escliente,     
             esproveedor,     
             esempleado,     
             esotro,     
        tipopersona,     
             fechanacimiento,     
             ciudadnacimiento,     
             documentofiscal,     
             documento,     
             personaant,     
             correoelectronico,     
             companiadescr as clasepersonacodigo,     
             estado,     
             ultimousuario,     
             ultimafechamodif,     
             sucursaldesc as tipopersonausuario,     
             cmp,     
             foto,     
             numeroregistroespecialidad,     
             tipogeneracioncita,     
             tiempopromedioatencion,     
             idespecialidad,     
             nombre,     
             accion,     
             sexo,     
             direccion,     
             telefono,     
             programado,     
             idEst as servicio,     
             tipohorario,     
             PERSONAX as idhorario,     
             codigousuario                  
      FROM   (     
                      SELECT  vw_ss_ge_especialidadmedico.*,                     
                      EMPLEADOMAST.Sucursal as SUC,  
          vw_ss_ge_especialidadmedico.PERSONA As PERSONAX,    
          (select top 1 description from VW_SS_GE_ESPECIALIDADMEDICO join EMPLEADOMAST on (Empleado = persona)join companyowner on (companyowner = CompaniaSocio)) as companiadescr,    
          (select top 1 DescripcionLocal from EMPLEADOMAST join VW_SS_GE_ESPECIALIDADMEDICO on (Empleado = persona) join AC_Sucursal on (AC_Sucursal.Sucursal = empleadomast.Sucursal)) as sucursaldesc,     
          (select TOP 1 IdEstablecimiento from EMPLEADOMAST join CM_CO_Establecimiento on (CompaniaSocio = Compania and CM_CO_Establecimiento.Sucursal = EMPLEADOMAST.Sucursal)) AS idEst,  
                               @CONTADOR                               AS contador,     
                               Row_number() OVER(ORDER BY persona ASC) AS rownumber     
                      FROM     vw_ss_ge_especialidadmedico    
                      inner JOIN EMPLEADOMAST ON (EMPLEADOMAST.Empleado = PERSONA)   
                      WHERE    ( @CMP IS NULL OR Upper(rtrim(vw_ss_ge_especialidadmedico.CMP)) LIKE '%' + Upper(rtrim(@CMP)) + '%' )       
                               AND ( @NOMBRECOMPLETO IS NULL OR Upper(nombrecompleto) LIKE '%' + Upper(@NOMBRECOMPLETO) + '%' )     
                               AND ( @NUMEROREGISTROESPECIALIDAD IS NULL OR Upper(numeroregistroespecialidad) LIKE '%' + Upper( @NUMEROREGISTROESPECIALIDAD) + '%' )     
                               AND ( @NOMBRE IS NULL OR Upper(nombre) LIKE '%' + Upper(@NOMBRE) + '%' )     
                               AND ( @ESTADO IS NULL OR vw_ss_ge_especialidadmedico.estado = @ESTADO )     
                               AND ( @IDESPECIALIDAD IS NULL OR vw_ss_ge_especialidadmedico.IDESPECIALIDAD = @IDESPECIALIDAD or @IDESPECIALIDAD = 0)    
                               AND ( @PERSONA IS NULL OR PERSONA = @PERSONA OR @PERSONA = 0)  
                               AND ( @COMPANIA IS NULL OR EMPLEADOMAST.CompaniaSocio = @COMPANIA)  
                               AND ( @SUCURSAL IS NULL OR convert(varchar,EMPLEADOMAST.Sucursal) = @SUCURSAL)  
                               )AS especialidadmedico     
         WHERE ( @INICIO IS NULL AND @NUMEROFILAS IS NULL ) OR ( rownumber BETWEEN @INICIO AND @NUMEROFILAS )     
                    
         --select Sucursal,UnidadReplicacion,* from EMPLEADOMAST  
 END   
 IF( @ACCION = 'LISTARPAG2' )     
    BEGIN     
    
      DECLARE @CONTADORES INT     
      SET @CONTADORES =     
      (     
             SELECT Count(*)     
             FROM   vw_ss_ge_especialidadmedico     
             JOIN EMPLEADOMAST ON (EMPLEADOMAST.Empleado = PERSONA)  
             WHERE  ( @CMP IS NULL OR Upper(rtrim(vw_ss_ge_especialidadmedico.CMP)) LIKE '%' + Upper(rtrim(@CMP)) + '%' )       
                    AND ( @NOMBRECOMPLETO IS NULL OR Upper(nombrecompleto) LIKE '%' + Upper(@NOMBRECOMPLETO) + '%' )     
                    AND ( @NUMEROREGISTROESPECIALIDAD IS NULL OR Upper(numeroregistroespecialidad) LIKE '%' + Upper( @NUMEROREGISTROESPECIALIDAD) + '%' )     
                    AND ( @NOMBRE IS NULL OR Upper(nombre) LIKE '%' + Upper(@NOMBRE) + '%' )     
                    AND ( @ESTADO IS NULL OR vw_ss_ge_especialidadmedico.estado = @ESTADO )    
                    AND ( @IDESPECIALIDAD IS NULL OR vw_ss_ge_especialidadmedico.IDESPECIALIDAD = @IDESPECIALIDAD or @IDESPECIALIDAD = 0)    
                    AND ( @PERSONA IS NULL OR PERSONA = @PERSONA OR @PERSONA = 0)  )     
                              
      SELECT convert(integer ,rownumber )AS persona,     
             origen,     
             nombres,     
             nombrecompleto,     
             busqueda,     
             tipodocumentoidentidad,     
             documentoidentidad,     
             escliente,     
             esproveedor,     
             esempleado,     
             esotro,     
        tipopersona,     
             fechanacimiento,     
             ciudadnacimiento,     
             documentofiscal,     
             documento,     
             personaant,     
             correoelectronico,     
             companiadescr as clasepersonacodigo,     
             estado,     
             ultimousuario,     
             ultimafechamodif,     
             sucursaldesc as tipopersonausuario,     
             cmp,     
             foto,     
             numeroregistroespecialidad,     
             tipogeneracioncita,     
             tiempopromedioatencion,     
             idespecialidad,     
             nombre,     
             accion,     
             sexo,     
             direccion,     
             telefono,     
             programado,     
             idEst as servicio,     
             tipohorario,     
             PERSONAX as idhorario,     
             codigousuario                  
      FROM   (     
                      SELECT  vw_ss_ge_especialidadmedico.*,                     
                      EMPLEADOMAST.Sucursal as SUC,  
          vw_ss_ge_especialidadmedico.PERSONA As PERSONAX,    
          (select top 1 description from VW_SS_GE_ESPECIALIDADMEDICO join EMPLEADOMAST on (Empleado = persona)join companyowner on (companyowner = CompaniaSocio)) as companiadescr,    
          (select top 1 DescripcionLocal from EMPLEADOMAST join VW_SS_GE_ESPECIALIDADMEDICO on (Empleado = persona) join AC_Sucursal on (AC_Sucursal.Sucursal = empleadomast.Sucursal)) as sucursaldesc,     
          (select TOP 1 IdEstablecimiento from EMPLEADOMAST join CM_CO_Establecimiento on (CompaniaSocio = Compania and CM_CO_Establecimiento.Sucursal = EMPLEADOMAST.Sucursal)) AS idEst,  
                               @CONTADORES                               AS contador,     
                               Row_number() OVER(ORDER BY persona ASC) AS rownumber     
                      FROM     vw_ss_ge_especialidadmedico    
                      inner JOIN EMPLEADOMAST ON (EMPLEADOMAST.Empleado = PERSONA)   
                      WHERE    ( @CMP IS NULL OR Upper(rtrim(vw_ss_ge_especialidadmedico.CMP)) LIKE '%' + Upper(rtrim(@CMP)) + '%' )       
                               AND ( @NOMBRECOMPLETO IS NULL OR Upper(nombrecompleto) LIKE '%' + Upper(@NOMBRECOMPLETO) + '%' )     
                               AND ( @NUMEROREGISTROESPECIALIDAD IS NULL OR Upper(numeroregistroespecialidad) LIKE '%' + Upper( @NUMEROREGISTROESPECIALIDAD) + '%' )     
                               AND ( @NOMBRE IS NULL OR Upper(nombre) LIKE '%' + Upper(@NOMBRE) + '%' )     
                               AND ( @ESTADO IS NULL OR vw_ss_ge_especialidadmedico.estado = @ESTADO )     
                               AND ( @IDESPECIALIDAD IS NULL OR vw_ss_ge_especialidadmedico.IDESPECIALIDAD = @IDESPECIALIDAD or @IDESPECIALIDAD = 0)    
                               AND ( @PERSONA IS NULL OR PERSONA = @PERSONA OR @PERSONA = 0)  
                               )AS especialidadmedico     
         WHERE ( @INICIO IS NULL AND @NUMEROFILAS IS NULL ) OR ( rownumber BETWEEN @INICIO AND @NUMEROFILAS )    
 END    
END     
/*     
EXEC SP_VW_SS_GE_EspecialidadMedicoListar     
NULL,NULL, NULL, NULL, NULL,     
NULL, NULL, NULL, NULL, NULL,     
NULL, NULL, NULL, NULL, NULL,     
NULL, NULL, NULL, NULL, NULL,     
NULL, NULL, NULL, NULL, NULL,     
NULL, NULL, NULL, NULL, NULL,     
'LISTARPAG', NULL, NULL, NULL, NULL,     
NULL, NULL, NULL, NULL,     
0,10     
*/
GO
/****** Object:  StoredProcedure [dbo].[SP_VW_SS_HC_AsignacionMedico]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_VW_SS_HC_AsignacionMedico] 
@UnidadReplicacion   CHAR(4), 
@IdPaciente          INT, 
@IdAsignacionMedico  INT, 
@TipoAsignacion      INT, 
@Observaciones       VARCHAR(120), 

@Estado              INT, 
@UsuarioCreacion     VARCHAR(25), 
@FechaCreacion       DATETIME, 
@UsuarioModificacion VARCHAR(25), 
@FechaModificacion   DATETIME, 

@medico1             VARCHAR(100), 
@nombrecompleto      VARCHAR(100), 
@Servicio			 VARCHAR(25),
@CodigoHC			 VARCHAR(25),
@CodigoHCAnterior	 VARCHAR(25),
	
@CodigoOA			 VARCHAR(25),
@FecIniDiscamec		 DATETIME,
@FecFinDiscamec		 DATETIME,
@Secuencia INT,
@SecuenciaReferida INT,

@Accion              VARCHAR(50) 
AS 
  BEGIN 
      SET nocount ON; 
      if(@Accion = 'UPDATE')
      SET @Accion = 'INSERT'
       SELECT @Secuencia = Isnull(Max(Secuencia), 0) + 1 
            FROM   dbo.SS_HC_AsignacionMedico 
            WHERE ( ss_hc_asignacionmedico.idpaciente = @IdPaciente ) 
       IF(@Secuencia >1)  
       SELECT @SecuenciaReferida =  Max(Secuencia) FROM   dbo.SS_HC_AsignacionMedico 
            WHERE ( ss_hc_asignacionmedico.idpaciente = @IdPaciente )  
            
 IF @Accion = 'INSERT' 
        BEGIN         
			UPDATE dbo.SS_HC_AsignacionMedico
			SET Estado=2
			where IdPaciente = @IdPaciente
			
            INSERT INTO dbo.SS_HC_AsignacionMedico
                        (	UnidadReplicacion,
							IdPaciente,
							TipoAsignacion,
							IdAsignacionMedico,
							Secuencia,
							SecuenciaReferida,
							Observaciones,
							UsuarioCreacion,
							FechaCreacion,
							UsuarioModificacion,
							FechaModificacion,
							Estado, 
							accion) 
            VALUES      (   @UnidadReplicacion,
							@IdPaciente,
							@TipoAsignacion,
							@IdAsignacionMedico,
							@Secuencia,
							@SecuenciaReferida,
							@Observaciones,
							@UsuarioCreacion,
							GETDATE(),
							@UsuarioModificacion,
							GETDATE(),
							ISNULL(@Estado,0), 
                            @Accion ) 

            SELECT 1 
        END 
      ELSE IF @Accion = 'UPDATE' 
        BEGIN 
            UPDATE dbo.SS_HC_AsignacionMedico
            SET		UnidadReplicacion=@UnidadReplicacion,
					IdPaciente=@IdPaciente,
					TipoAsignacion=@TipoAsignacion,
					IdAsignacionMedico=@IdAsignacionMedico,
					Secuencia=@Secuencia,
					SecuenciaReferida=@SecuenciaReferida,
					Observaciones=@Observaciones,
					UsuarioCreacion=@UsuarioCreacion,
					FechaCreacion=@FechaCreacion,
					UsuarioModificacion=@UsuarioModificacion,
					FechaModificacion=@FechaModificacion,
					Estado=@Estado, 
                    accion = @Accion 
            WHERE  ( ss_hc_asignacionmedico.unidadreplicacion = @UnidadReplicacion ) 
                   AND ( ss_hc_asignacionmedico.idpaciente = @IdPaciente ) 
                   AND ( ss_hc_asignacionmedico.TipoAsignacion = @TipoAsignacion ) 
                   AND ( ss_hc_asignacionmedico.idasignacionmedico = @IdAsignacionMedico ) 
				   AND ( ss_hc_asignacionmedico.secuencia = @Secuencia ) 
            SELECT 1 
        END 
      ELSE IF @Accion = 'DELETE' 
        BEGIN 
            DELETE FROM dbo.SS_HC_AsignacionMedico
            WHERE  ( ss_hc_asignacionmedico.unidadreplicacion = @UnidadReplicacion ) 
                   AND ( ss_hc_asignacionmedico.idpaciente = @IdPaciente ) 
                   AND ( ss_hc_asignacionmedico.TipoAsignacion = @TipoAsignacion ) 
                   AND ( ss_hc_asignacionmedico.idasignacionmedico = @IdAsignacionMedico ) 
				   AND ( ss_hc_asignacionmedico.secuencia = @Secuencia )
            SELECT 1 
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   ss_ad_ordenatencion 
                         LEFT JOIN dbo.vw_ss_hc_asignacionmedico ON ( vw_ss_hc_asignacionmedico.codigooa = ss_ad_ordenatencion.codigooa AND vw_ss_hc_asignacionmedico.empleado = ss_ad_ordenatencion.idpaciente ) 
                         LEFT JOIN cm_co_tablamaestrodetalle TipoPaciente ON ( TipoPaciente.idcodigo = ss_ad_ordenatencion.tipopaciente AND TipoPaciente.idtablamaestro = 45 ) 
                         LEFT JOIN ss_ge_tipoatencion TipoAtencion ON ( TipoAtencion.idtipoatencion = ss_ad_ordenatencion.tipoatencion ) 
                         LEFT JOIN personamast personaPaciente ON ( personaPaciente.persona = ss_ad_ordenatencion.idpaciente )                               
                             WHERE  ( @Observaciones IS NULL OR Upper(vw_ss_hc_asignacionmedico.observaciones) LIKE '%' + Upper(@Observaciones ) + '%' ) 
                                    AND ( @UnidadReplicacion IS NULL OR Upper(vw_ss_hc_asignacionmedico.unidadreplicacion) LIKE '%' + Upper(@UnidadReplicacion) + '%' ) 
                                    AND ( @IdPaciente IS NULL OR vw_ss_hc_asignacionmedico.idpaciente = @IdPaciente OR @IdPaciente = 0 ) 
                                    
                                    
                                    AND ( @IdAsignacionMedico IS NULL OR vw_ss_hc_asignacionmedico.idasignacionmedico = @IdAsignacionMedico OR @IdAsignacionMedico = 0 ) 
                                    
                                    AND ( @medico1 IS NULL OR Upper(medico1) LIKE '%' + Upper(@medico1) + '%' ) 
                                                                    
									AND (@CodigoHC is null OR vw_ss_hc_asignacionmedico.CodigoHC = @CodigoHC)
									AND (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)
									--AND (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')
									AND (@CodigoOA is null OR vw_ss_hc_asignacionmedico.CodigoOA = @CodigoOA)
									AND ((@FecIniDiscamec is null or  vw_ss_hc_asignacionmedico.FechaAtencion >= @FecIniDiscamec)and(@FecFinDiscamec is null or  vw_ss_hc_asignacionmedico.FechaAtencion <= @FecFinDiscamec))				 
                                    AND (@nombrecompleto IS NULL OR Upper(vw_ss_hc_asignacionmedico.nombrecompleto) LIKE '%' + Upper(@nombrecompleto) + '%' )) 
            SELECT @CONTADOR; 
        END 
  END 
/* 
EXEC SP_VW_SS_HC_ASIGNACIONMEDICO    
'01', 1, 4, 1, 'prueba',    
0, 'ROYAL', NULL, 'ROYAL', NULL,   
NULL, NULL, NULL, NULL, NULL, 
NULL, NULL, NULL, NULL, NULL, 
'UPDATE'   
*/ 


GO
/****** Object:  StoredProcedure [dbo].[SP_VW_SS_HC_AsignacionMedicoListar]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_VW_SS_HC_AsignacionMedicoListar] 
@UnidadReplicacion   CHAR(4), 
@IdPaciente          INT, 
@IdAsignacionMedico  INT, 
@TipoAsignacion      INT, 
@Observaciones       VARCHAR(120), 

@Estado              INT, 
@UsuarioCreacion     VARCHAR(25), 
@FechaCreacion       DATETIME , 
@UsuarioModificacion VARCHAR (25), 
@FechaModificacion   DATETIME , 

@medico1             VARCHAR (100), 
@nombrecompleto      VARCHAR(100), 
@Servicio			 VARCHAR(25),
@CodigoHC			 VARCHAR(25),
@CodigoHCAnterior	 VARCHAR(25),	

@CodigoOA			 VARCHAR(25),
@FecIniDiscamec		 DATETIME,
@FecFinDiscamec		 DATETIME,
@Secuencia			 INT,
@SecuenciaReferida   INT,

@Accion              VARCHAR(50), 
@INICIO              INT = NULL, 
@NUMEROFILAS         INT = NULL 
AS 
  BEGIN 
      SET nocount ON; 
     IF( @ACCION = 'LISTARPAGNEW' ) 
        BEGIN 
            DECLARE @CONTAR INT 

            SET @CONTAR = (SELECT Count(*) FROM   ss_ad_ordenatencion 
                         LEFT JOIN dbo.vw_ss_hc_asignacionmedico ON ( vw_ss_hc_asignacionmedico.codigooa = ss_ad_ordenatencion.codigooa AND vw_ss_hc_asignacionmedico.empleado = ss_ad_ordenatencion.idpaciente ) 
                         LEFT JOIN cm_co_tablamaestrodetalle TipoPaciente ON ( TipoPaciente.idcodigo = ss_ad_ordenatencion.tipopaciente AND TipoPaciente.idtablamaestro = 45 ) 
                         LEFT JOIN ss_ge_tipoatencion TipoAtencion ON ( TipoAtencion.idtipoatencion = ss_ad_ordenatencion.tipoatencion ) 
                         LEFT JOIN personamast personaPaciente ON ( personaPaciente.persona = ss_ad_ordenatencion.idpaciente )  
                             WHERE  ( @Observaciones IS NULL OR Upper(observaciones) LIKE '%' + Upper(@Observaciones ) + '%' ) 
                                    AND ( @UnidadReplicacion IS NULL OR Upper(vw_ss_hc_asignacionmedico.unidadreplicacion) LIKE '%' + Upper(@UnidadReplicacion) + '%' ) 
                                    AND ( @IdPaciente IS NULL OR vw_ss_hc_asignacionmedico.idpaciente = @IdPaciente OR @IdPaciente = 0 ) 


                                    AND ( @IdAsignacionMedico IS NULL OR idasignacionmedico = @IdAsignacionMedico OR @IdAsignacionMedico = 0 ) 

                                    AND ( @medico1 IS NULL OR Upper(medico1) LIKE '%' + Upper(@medico1 ) + '%' ) 

                                    AND ( @nombrecompleto IS NULL OR Upper(vw_ss_hc_asignacionmedico.nombrecompleto) LIKE '%' + Upper(@nombrecompleto) + '%' )

									AND (@CodigoHC is null OR vw_ss_hc_asignacionmedico.CodigoHC = @CodigoHC)
									AND (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)
									AND (@CodigoOA is null OR vw_ss_hc_asignacionmedico.CodigoOA = @CodigoOA)
									AND ((@FecIniDiscamec is null or  vw_ss_hc_asignacionmedico.FechaAtencion >= @FecIniDiscamec)and(@FecFinDiscamec is null or  vw_ss_hc_asignacionmedico.FechaAtencion <= @FecFinDiscamec))				 ) 

            SELECT  empleado,
					origen,
					busqueda,
					tipodocumentoidentidad,
					documentoidentidad,
					escliente,
					esproveedor,
					esempleado,
					esotro,
					tipopersona,
					fechanacimiento,
					ciudadnacimiento,
					documentofiscal,
					documento,
					personaant,
					correoelectronico,
					clasepersonacodigo,
					estadopersona,
					ultimousuario,
					ultimafechamodif,
					tipopersonausuario,
					fecfindiscamec,
					fecinidiscamec,
					cmp,
					foto,
					sexo,
					direccion,
					telefono,
					codigousuario,
					unidadreplicacion,
					idpaciente,
					nombres,
					nombrecompleto,
					idasignacionmedico,
					medico1,
					tipoasignacion,
					observaciones,
					estado,
					usuariocreacion,
					fechacreacion,
					usuariomodificacion,
					fechamodificacion,
					accion,
					codigohc,
					codigohcanterior,
					servicio,

					TipoPaciente,
					IdPersonalSalud,
					CodigoOASpring as CodigoOA,
					FechaAtencion,
					Secuencia,
					SecuenciaReferida
            FROM   (SELECT vw_ss_hc_asignacionmedico.empleado,
							vw_ss_hc_asignacionmedico.origen,
							vw_ss_hc_asignacionmedico.busqueda,
							vw_ss_hc_asignacionmedico.tipodocumentoidentidad,
							vw_ss_hc_asignacionmedico.documentoidentidad,
							vw_ss_hc_asignacionmedico.escliente,
							vw_ss_hc_asignacionmedico.esproveedor,
							vw_ss_hc_asignacionmedico.esempleado,
							vw_ss_hc_asignacionmedico.esotro,
							vw_ss_hc_asignacionmedico.tipopersona,
							vw_ss_hc_asignacionmedico.fechanacimiento,
							vw_ss_hc_asignacionmedico.ciudadnacimiento,
							vw_ss_hc_asignacionmedico.documentofiscal,
							vw_ss_hc_asignacionmedico.documento,
							vw_ss_hc_asignacionmedico.personaant,
							vw_ss_hc_asignacionmedico.correoelectronico,
							vw_ss_hc_asignacionmedico.clasepersonacodigo,
							vw_ss_hc_asignacionmedico.estadopersona,
							vw_ss_hc_asignacionmedico.ultimousuario,
							vw_ss_hc_asignacionmedico.ultimafechamodif,
							vw_ss_hc_asignacionmedico.tipopersonausuario,
							vw_ss_hc_asignacionmedico.fecfindiscamec,
							vw_ss_hc_asignacionmedico.fecinidiscamec,
							vw_ss_hc_asignacionmedico.cmp,
							vw_ss_hc_asignacionmedico.foto,
							vw_ss_hc_asignacionmedico.sexo,
							vw_ss_hc_asignacionmedico.direccion,
							vw_ss_hc_asignacionmedico.telefono,
							vw_ss_hc_asignacionmedico.codigousuario,
							vw_ss_hc_asignacionmedico.unidadreplicacion,

							vw_ss_hc_asignacionmedico.idpaciente,
							vw_ss_hc_asignacionmedico.nombres,
							vw_ss_hc_asignacionmedico.nombrecompleto,

							vw_ss_hc_asignacionmedico.idasignacionmedico,
							vw_ss_hc_asignacionmedico.medico1,
							vw_ss_hc_asignacionmedico.Secuencia,
							vw_ss_hc_asignacionmedico.SecuenciaReferida,
							vw_ss_hc_asignacionmedico.tipoasignacion,
							vw_ss_hc_asignacionmedico.observaciones,
							vw_ss_hc_asignacionmedico.estado,
							vw_ss_hc_asignacionmedico.usuariocreacion,
							vw_ss_hc_asignacionmedico.fechacreacion,
							vw_ss_hc_asignacionmedico.usuariomodificacion,
							vw_ss_hc_asignacionmedico.fechamodificacion,
							vw_ss_hc_asignacionmedico.accion,
							vw_ss_hc_asignacionmedico.codigohc,
							vw_ss_hc_asignacionmedico.codigohcanterior,
							vw_ss_hc_asignacionmedico.servicio,
							vw_ss_hc_asignacionmedico.TipoPaciente,
							vw_ss_hc_asignacionmedico.IdPersonalSalud,
							SS_AD_OrdenAtencion.codigoOA as CodigoOASpring,
							vw_ss_hc_asignacionmedico.FechaAtencion, 
                           @CONTAR                           AS contador, 
                           Row_number() OVER(ORDER BY vw_ss_hc_asignacionmedico.unidadreplicacion ASC) AS rownumber 
                    FROM   ss_ad_ordenatencion 
                         LEFT JOIN dbo.vw_ss_hc_asignacionmedico ON ( vw_ss_hc_asignacionmedico.codigooa = ss_ad_ordenatencion.codigooa AND vw_ss_hc_asignacionmedico.empleado = ss_ad_ordenatencion.idpaciente ) 
                         LEFT JOIN cm_co_tablamaestrodetalle TipoPaciente ON ( TipoPaciente.idcodigo = ss_ad_ordenatencion.tipopaciente AND TipoPaciente.idtablamaestro = 45 ) 
                         LEFT JOIN ss_ge_tipoatencion TipoAtencion ON ( TipoAtencion.idtipoatencion = ss_ad_ordenatencion.tipoatencion ) 
                         LEFT JOIN personamast personaPaciente ON ( personaPaciente.persona = ss_ad_ordenatencion.idpaciente )  
                    WHERE  ( @Observaciones IS NULL OR Upper(observaciones) LIKE '%' + Upper(@Observaciones) + '%' ) 
                           AND ( @UnidadReplicacion IS NULL OR Upper(vw_ss_hc_asignacionmedico.unidadreplicacion) LIKE '%' + Upper(@UnidadReplicacion) + '%' ) 
                           AND ( @IdPaciente IS NULL OR vw_ss_hc_asignacionmedico.idpaciente = @IdPaciente OR @IdPaciente = 0 ) 


                           AND ( @IdAsignacionMedico IS NULL OR idasignacionmedico = @IdAsignacionMedico OR @IdAsignacionMedico = 0 ) 

                           AND ( @medico1 IS NULL OR Upper(medico1) LIKE '%' + Upper(@medico1) + '%' ) 

                           AND ( @nombrecompleto IS NULL OR Upper(vw_ss_hc_asignacionmedico.nombrecompleto) LIKE '%' + Upper(@nombrecompleto) + '%' )
                           
                           ) AS DATOSDETALLE 
            WHERE  ( @INICIO IS NULL AND @NUMEROFILAS IS NULL ) OR ( rownumber BETWEEN @INICIO AND @NUMEROFILAS ) 
        END
      ELSE IF @Accion = 'LISTAR' 
        BEGIN 
            SELECT vw_ss_hc_asignacionmedico.empleado,
							vw_ss_hc_asignacionmedico.origen,
							vw_ss_hc_asignacionmedico.busqueda,
							vw_ss_hc_asignacionmedico.tipodocumentoidentidad,
							vw_ss_hc_asignacionmedico.documentoidentidad,
							vw_ss_hc_asignacionmedico.escliente,
							vw_ss_hc_asignacionmedico.esproveedor,
							vw_ss_hc_asignacionmedico.esempleado,
							vw_ss_hc_asignacionmedico.esotro,
							vw_ss_hc_asignacionmedico.tipopersona,
							vw_ss_hc_asignacionmedico.fechanacimiento,
							vw_ss_hc_asignacionmedico.ciudadnacimiento,
							vw_ss_hc_asignacionmedico.documentofiscal,
							vw_ss_hc_asignacionmedico.documento,
							vw_ss_hc_asignacionmedico.personaant,
							vw_ss_hc_asignacionmedico.correoelectronico,
							vw_ss_hc_asignacionmedico.clasepersonacodigo,
							vw_ss_hc_asignacionmedico.estadopersona,
							vw_ss_hc_asignacionmedico.ultimousuario,
							vw_ss_hc_asignacionmedico.ultimafechamodif,
							vw_ss_hc_asignacionmedico.tipopersonausuario,
							vw_ss_hc_asignacionmedico.fecfindiscamec,
							vw_ss_hc_asignacionmedico.fecinidiscamec,
							vw_ss_hc_asignacionmedico.cmp,
							vw_ss_hc_asignacionmedico.foto,
							vw_ss_hc_asignacionmedico.sexo,
							vw_ss_hc_asignacionmedico.direccion,
							vw_ss_hc_asignacionmedico.telefono,
							vw_ss_hc_asignacionmedico.codigousuario,
							vw_ss_hc_asignacionmedico.unidadreplicacion,

							vw_ss_hc_asignacionmedico.idpaciente,
							vw_ss_hc_asignacionmedico.nombres,
							vw_ss_hc_asignacionmedico.nombrecompleto,

							vw_ss_hc_asignacionmedico.idasignacionmedico,
							vw_ss_hc_asignacionmedico.medico1,
							VW_SS_HC_ASIGNACIONMEDICO.Secuencia,
							VW_SS_HC_ASIGNACIONMEDICO.SecuenciaReferida,
							vw_ss_hc_asignacionmedico.tipoasignacion,
							vw_ss_hc_asignacionmedico.observaciones,
							vw_ss_hc_asignacionmedico.estado,
							vw_ss_hc_asignacionmedico.usuariocreacion,
							vw_ss_hc_asignacionmedico.fechacreacion,
							vw_ss_hc_asignacionmedico.usuariomodificacion,
							vw_ss_hc_asignacionmedico.fechamodificacion,
							vw_ss_hc_asignacionmedico.accion,
							vw_ss_hc_asignacionmedico.codigohc,
							vw_ss_hc_asignacionmedico.codigohcanterior,
							vw_ss_hc_asignacionmedico.servicio,
							vw_ss_hc_asignacionmedico.TipoPaciente,
							vw_ss_hc_asignacionmedico.IdPersonalSalud,
							vw_ss_hc_asignacionmedico.CodigoOA,
							vw_ss_hc_asignacionmedico.FechaAtencion
            FROM   vw_ss_hc_asignacionmedico 
            WHERE  ( @Observaciones IS NULL OR Upper(observaciones) LIKE '%' + Upper(@Observaciones) + '%' ) 
                   AND ( @UnidadReplicacion IS NULL OR Upper(unidadreplicacion) LIKE '%' + Upper(@UnidadReplicacion) + '%' ) 
                   AND ( @IdPaciente IS NULL OR idpaciente = @IdPaciente OR @IdPaciente = 0 ) 


                   AND ( @IdAsignacionMedico IS NULL OR idasignacionmedico = @IdAsignacionMedico OR @IdAsignacionMedico = 0 ) 

                   AND ( @medico1 IS NULL OR Upper(medico1) LIKE '%' + Upper(@medico1) + '%' ) 

                   AND ( @nombrecompleto IS NULL OR Upper(nombrecompleto) LIKE '%' + Upper(@nombrecompleto) + '%' ) 

				   AND (@CodigoHC is null OR vw_ss_hc_asignacionmedico.CodigoHC = @CodigoHC)
				   AND (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)
				   AND (@CodigoOA is null OR vw_ss_hc_asignacionmedico.CodigoOA = @CodigoOA)
				   AND ((@FecIniDiscamec is null or  vw_ss_hc_asignacionmedico.FechaAtencion >= @FecIniDiscamec)and(@FecFinDiscamec is null or  vw_ss_hc_asignacionmedico.FechaAtencion <= @FecFinDiscamec))				 
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) FROM   vw_ss_hc_asignacionmedico 
                             WHERE  ( @Observaciones IS NULL OR Upper(observaciones) LIKE '%' + Upper(@Observaciones ) + '%' ) 
                                    AND ( @UnidadReplicacion IS NULL OR Upper(unidadreplicacion) LIKE '%' + Upper(@UnidadReplicacion) + '%' ) 
                                    AND ( @IdPaciente IS NULL OR idpaciente = @IdPaciente OR @IdPaciente = 0 ) 


                                    AND ( @IdAsignacionMedico IS NULL OR idasignacionmedico = @IdAsignacionMedico OR @IdAsignacionMedico = 0 ) 

                                    AND ( @medico1 IS NULL OR Upper(medico1) LIKE '%' + Upper(@medico1 ) + '%' ) 

                                    AND ( @nombrecompleto IS NULL OR Upper(nombrecompleto) LIKE '%' + Upper(@nombrecompleto) + '%' )

									AND (@CodigoHC is null OR vw_ss_hc_asignacionmedico.CodigoHC = @CodigoHC)
									AND (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)
									AND (@CodigoOA is null OR vw_ss_hc_asignacionmedico.CodigoOA = @CodigoOA)
									AND ((@FecIniDiscamec is null or  vw_ss_hc_asignacionmedico.FechaAtencion >= @FecIniDiscamec)and(@FecFinDiscamec is null or  vw_ss_hc_asignacionmedico.FechaAtencion <= @FecFinDiscamec))				 ) 

            SELECT  empleado,
					origen,
					busqueda,
					tipodocumentoidentidad,
					documentoidentidad,
					escliente,
					esproveedor,
					esempleado,
					esotro,
					tipopersona,
					fechanacimiento,
					ciudadnacimiento,
					documentofiscal,
					documento,
					personaant,
					correoelectronico,
					clasepersonacodigo,
					estadopersona,
					ultimousuario,
					ultimafechamodif,
					tipopersonausuario,
					fecfindiscamec,
					fecinidiscamec,
					cmp,
					foto,
					sexo,
					direccion,
					telefono,
					codigousuario,
					unidadreplicacion,
					idpaciente,
					nombres,
					nombrecompleto,
					idasignacionmedico,
					medico1,
					tipoasignacion,
					observaciones,
					estado,
					usuariocreacion,
					fechacreacion,
					usuariomodificacion,
					fechamodificacion,
					accion,
					codigohc,
					codigohcanterior,
					TipoPaciente,
					IdPersonalSalud,
					CodigoOA,
					FechaAtencion,
					servicio,
					Secuencia,
					SecuenciaReferida
            FROM   (SELECT	
							VW_SS_HC_ASIGNACIONMEDICO.Secuencia,
							VW_SS_HC_ASIGNACIONMEDICO.SecuenciaReferida,
							vw_ss_hc_asignacionmedico.empleado,
							vw_ss_hc_asignacionmedico.origen,
							vw_ss_hc_asignacionmedico.busqueda,
							vw_ss_hc_asignacionmedico.tipodocumentoidentidad,
							vw_ss_hc_asignacionmedico.documentoidentidad,
							vw_ss_hc_asignacionmedico.escliente,
							vw_ss_hc_asignacionmedico.esproveedor,
							vw_ss_hc_asignacionmedico.esempleado,
							vw_ss_hc_asignacionmedico.esotro,
							vw_ss_hc_asignacionmedico.tipopersona,
							vw_ss_hc_asignacionmedico.fechanacimiento,
							vw_ss_hc_asignacionmedico.ciudadnacimiento,
							vw_ss_hc_asignacionmedico.documentofiscal,
							vw_ss_hc_asignacionmedico.documento,
							vw_ss_hc_asignacionmedico.personaant,
							vw_ss_hc_asignacionmedico.correoelectronico,
							vw_ss_hc_asignacionmedico.clasepersonacodigo,
							vw_ss_hc_asignacionmedico.estadopersona,
							vw_ss_hc_asignacionmedico.ultimousuario,
							vw_ss_hc_asignacionmedico.ultimafechamodif,
							vw_ss_hc_asignacionmedico.tipopersonausuario,
							vw_ss_hc_asignacionmedico.fecfindiscamec,
							vw_ss_hc_asignacionmedico.fecinidiscamec,
							vw_ss_hc_asignacionmedico.cmp,
							vw_ss_hc_asignacionmedico.foto,
							vw_ss_hc_asignacionmedico.sexo,
							vw_ss_hc_asignacionmedico.direccion,
							vw_ss_hc_asignacionmedico.telefono,
							vw_ss_hc_asignacionmedico.codigousuario,
							vw_ss_hc_asignacionmedico.unidadreplicacion,
							vw_ss_hc_asignacionmedico.idpaciente,
							vw_ss_hc_asignacionmedico.nombres,
							vw_ss_hc_asignacionmedico.nombrecompleto,
							vw_ss_hc_asignacionmedico.idasignacionmedico,
							vw_ss_hc_asignacionmedico.medico1,
							vw_ss_hc_asignacionmedico.tipoasignacion,
							vw_ss_hc_asignacionmedico.observaciones,
							vw_ss_hc_asignacionmedico.estado,
							vw_ss_hc_asignacionmedico.usuariocreacion,
							vw_ss_hc_asignacionmedico.fechacreacion,
							vw_ss_hc_asignacionmedico.usuariomodificacion,
							vw_ss_hc_asignacionmedico.fechamodificacion,
							vw_ss_hc_asignacionmedico.accion,
							vw_ss_hc_asignacionmedico.codigohc,
							vw_ss_hc_asignacionmedico.codigohcanterior,
							vw_ss_hc_asignacionmedico.servicio,
							vw_ss_hc_asignacionmedico.TipoPaciente,
							vw_ss_hc_asignacionmedico.IdPersonalSalud,
							vw_ss_hc_asignacionmedico.CodigoOA,
							vw_ss_hc_asignacionmedico.FechaAtencion, 
                           @CONTADOR                           AS contador, 
                           Row_number() OVER(ORDER BY unidadreplicacion ASC) AS rownumber 
                    FROM   vw_ss_hc_asignacionmedico 
                    WHERE  ( @Observaciones IS NULL OR Upper(observaciones) LIKE '%' + Upper(@Observaciones) + '%' ) 
                           AND ( @UnidadReplicacion IS NULL OR Upper(unidadreplicacion) LIKE '%' + Upper(@UnidadReplicacion) + '%' ) 
                           AND ( @IdPaciente IS NULL OR idpaciente = @IdPaciente OR @IdPaciente = 0 ) 
                           
                           
                           AND ( @IdAsignacionMedico IS NULL OR idasignacionmedico = @IdAsignacionMedico OR @IdAsignacionMedico = 0 ) 
                 
                           AND ( @medico1 IS NULL OR Upper(medico1) LIKE '%' + Upper(@medico1) + '%' ) 
                           AND ( @nombrecompleto IS NULL OR Upper(nombrecompleto) LIKE '%' + Upper(@nombrecompleto) + '%' )) AS DATOSDETALLE 
            WHERE  ( @INICIO IS NULL AND @NUMEROFILAS IS NULL ) OR ( rownumber BETWEEN @INICIO AND @NUMEROFILAS ) 
        END
        ELSE IF @Accion = 'LISTANDO' 
        BEGIN 
            SELECT vw_ss_hc_asignacionmedico.empleado,
							vw_ss_hc_asignacionmedico.origen,
							vw_ss_hc_asignacionmedico.busqueda,
							vw_ss_hc_asignacionmedico.tipodocumentoidentidad,
							vw_ss_hc_asignacionmedico.documentoidentidad,
							vw_ss_hc_asignacionmedico.escliente,
							vw_ss_hc_asignacionmedico.esproveedor,
							vw_ss_hc_asignacionmedico.esempleado,
							vw_ss_hc_asignacionmedico.esotro,
							vw_ss_hc_asignacionmedico.tipopersona,
							vw_ss_hc_asignacionmedico.fechanacimiento,
							vw_ss_hc_asignacionmedico.ciudadnacimiento,
							vw_ss_hc_asignacionmedico.documentofiscal,
							vw_ss_hc_asignacionmedico.documento,
							vw_ss_hc_asignacionmedico.personaant,
							vw_ss_hc_asignacionmedico.correoelectronico,
							vw_ss_hc_asignacionmedico.clasepersonacodigo,
							vw_ss_hc_asignacionmedico.estadopersona,
							vw_ss_hc_asignacionmedico.ultimousuario,
							vw_ss_hc_asignacionmedico.ultimafechamodif,
							vw_ss_hc_asignacionmedico.tipopersonausuario,
							vw_ss_hc_asignacionmedico.fecfindiscamec,
							vw_ss_hc_asignacionmedico.fecinidiscamec,
							vw_ss_hc_asignacionmedico.cmp,
							vw_ss_hc_asignacionmedico.foto,
							vw_ss_hc_asignacionmedico.sexo,
							vw_ss_hc_asignacionmedico.direccion,
							vw_ss_hc_asignacionmedico.telefono,
							vw_ss_hc_asignacionmedico.codigousuario,
							vw_ss_hc_asignacionmedico.unidadreplicacion,
							
							vw_ss_hc_asignacionmedico.idpaciente,
							vw_ss_hc_asignacionmedico.nombres,
							vw_ss_hc_asignacionmedico.nombrecompleto,
							vw_ss_hc_asignacionmedico.servicio,
							vw_ss_hc_asignacionmedico.idasignacionmedico,
							vw_ss_hc_asignacionmedico.medico1,
							VW_SS_HC_ASIGNACIONMEDICO.Secuencia,
							VW_SS_HC_ASIGNACIONMEDICO.SecuenciaReferida,							
							vw_ss_hc_asignacionmedico.tipoasignacion,
							vw_ss_hc_asignacionmedico.observaciones,
							vw_ss_hc_asignacionmedico.estado,
							vw_ss_hc_asignacionmedico.usuariocreacion,
							vw_ss_hc_asignacionmedico.fechacreacion,
							vw_ss_hc_asignacionmedico.usuariomodificacion,
							vw_ss_hc_asignacionmedico.fechamodificacion,
							vw_ss_hc_asignacionmedico.accion,
							vw_ss_hc_asignacionmedico.codigohc,
							vw_ss_hc_asignacionmedico.codigohcanterior,
							--vw_ss_hc_asignacionmedico.servicio,
							
							vw_ss_hc_asignacionmedico.TipoPaciente,
							vw_ss_hc_asignacionmedico.IdPersonalSalud,
							vw_ss_hc_asignacionmedico.CodigoOA,
							vw_ss_hc_asignacionmedico.FechaAtencion
            FROM   vw_ss_hc_asignacionmedico 
            WHERE  ( @Observaciones IS NULL OR Upper(observaciones) LIKE '%' + Upper(@Observaciones) + '%' ) 
                   AND ( @UnidadReplicacion IS NULL OR Upper(unidadreplicacion) LIKE '%' + Upper(@UnidadReplicacion) + '%' ) 
                   AND ( @IdPaciente IS NULL OR empleado = @IdPaciente OR @IdPaciente = 0 ) 
                   
                   
                   AND ( @IdAsignacionMedico IS NULL OR idasignacionmedico = @IdAsignacionMedico OR @IdAsignacionMedico = 0 ) 
                   
                   AND ( @medico1 IS NULL OR Upper(medico1) LIKE '%' + Upper(@medico1) + '%' ) 
                   
                   AND ( @nombrecompleto IS NULL OR Upper(nombrecompleto) LIKE '%' + Upper(@nombrecompleto) + '%' ) 
                   
				   AND (@CodigoHC is null OR vw_ss_hc_asignacionmedico.CodigoHC = @CodigoHC)
				   AND (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)
				   AND (@CodigoOA is null OR vw_ss_hc_asignacionmedico.CodigoOA = @CodigoOA)
				   AND ((@FecIniDiscamec is null or  vw_ss_hc_asignacionmedico.FechaAtencion >= @FecIniDiscamec)and(@FecFinDiscamec is null or  vw_ss_hc_asignacionmedico.FechaAtencion <= @FecFinDiscamec))				 
        END  
                                 
  END 
/*      
EXEC SP_VW_SS_HC_ASIGNACIONMEDICOListar      
NULL, NULL, NULL, NULL, NULL,      
null, NULL, NULL, NULL, NULL,       
NULL, NULL, NULL, NULL, NULL, 
NULL, NULL, NULL, NULL, NULL, 
NULL, NULL,'LISTARPAGNEW', NULL, NULL      
*/ 
GO

/****** Object:  StoredProcedure [dbo].[SP_VW_SS_HC_FORMATORECURSOCAMPO]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_VW_SS_HC_FORMATORECURSOCAMPO]
@IDFORMATO INT,
@SECUENCIACAMPO INT,
@CODIGOFORMATO VARCHAR(15),
@DESCRIPCION VARCHAR(150),
@IDFAVORITOTABLA INT,
@NOMBRECAMPO VARCHAR(150),
@NOMBRETABLA VARCHAR(150),
@ESTADO INT,

@ACCION VARCHAR(25)
AS 
  BEGIN 
      SET nocount ON; 

       IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
         --   DECLARE @CONTADOR INT 

         --   SET @CONTADOR = (SELECT Count(*) FROM VW_FORMATORECURSOCAMPO
							SELECT * FROM VW_FORMATORECURSOCAMPO   
                             WHERE  ( @IDFORMATO		IS NULL OR IdFormato		=	@IDFORMATO			OR @IDFORMATO=0 )
                                AND ( @SECUENCIACAMPO	IS NULL OR SecuenciaCampo	=	@SECUENCIACAMPO		OR @SECUENCIACAMPO=0 )  
                                AND ( @CODIGOFORMATO	IS NULL OR Upper(CodigoFormato)	LIKE '%' + Upper(@CODIGOFORMATO)	+ '%' ) 
								AND ( @DESCRIPCION		IS NULL OR Upper(DescripcionFormato)	LIKE '%' + Upper(@DESCRIPCION)		+ '%' ) 
                                AND ( @IDFAVORITOTABLA	IS NULL OR IdFavoritoTabla	=	@IDFAVORITOTABLA	OR @IDFAVORITOTABLA=0 )
                                AND ( @NOMBRECAMPO		IS NULL OR Upper(DescripFormatoCampo)	LIKE '%' + Upper(@NOMBRECAMPO)		+ '%' ) 
                                AND ( @NOMBRETABLA		IS NULL OR Upper(DescripcionTabla)	LIKE '%' + Upper(@NOMBRETABLA)		+ '%' ) 
                                AND ( @ESTADO			IS NULL OR Estado			=	@ESTADO				OR @ESTADO=0 )--)
       -- SELECT @CONTADOR; 
        END 
  END 
/*  
EXEC SP_VW_SS_HC_FORMATORECURSOCAMPO  
0,0,
NULL, NULL, 0, NULL, 0,'LISTARPAG'  
*/ 
GO
/****** Object:  StoredProcedure [dbo].[SP_VW_SS_HC_FORMATORECURSOCAMPO_LISTAR]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_VW_SS_HC_FORMATORECURSOCAMPO_LISTAR]
		@IDFORMATO INT,  
		@CODIGOFORMATO VARCHAR(15), 
		@DESCRIPCIONFORMATO VARCHAR(150),  
		@SECUENCIACAMPO INT,   
		@DESCRIPFORMATOCAMPO VARCHAR(100), 
		@FORMULA VARCHAR(500),
		@IDFAVORITOTABLA INT,  
		@DESCRIPCIONTABLA VARCHAR(100), 
		@DESCRIPTABLACAMPO VARCHAR(150),   
		@ESTADO INT,  
		  
		@ACCION VARCHAR(25), 
	    @INICIO					int= null,  
	    @NUMEROFILAS			int = null 
AS    
BEGIN    
if(@ACCION = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR=(
				SELECT COUNT(SECUENCIACAMPO) FROM VW_FORMATORECURSOCAMPO	
				WHERE 
					(@IDFORMATO is null or @IDFORMATO ='' or  IDFORMATO = @IDFORMATO)		
					and (@CODIGOFORMATO is null  OR @CODIGOFORMATO =''  OR  upper(CODIGOFORMATO) like '%'+upper(@CODIGOFORMATO)+'%')								
					and (@ESTADO is null OR Estado = @ESTADO)
					and (@DESCRIPCIONFORMATO is null  OR @DESCRIPCIONFORMATO =''  OR  upper(DESCRIPCIONFORMATO) like '%'+upper(@DESCRIPCIONFORMATO)+'%')	
				)
		SELECT 
				IDFORMATO,
				CODIGOFORMATO,
				DESCRIPCIONFORMATO,
				SECUENCIACAMPO, 
				DESCRIPFORMATOCAMPO,  
				FORMULA,
				IDFAVORITOTABLA,  
				DESCRIPCIONTABLA,  
				DESCRIPTABLACAMPO,  
				ESTADO,  
				ACCION
				
		FROM (		
			SELECT
				IDFORMATO,
				CODIGOFORMATO,
				DESCRIPCIONFORMATO,
				SECUENCIACAMPO, 
				DESCRIPFORMATOCAMPO,  
				FORMULA,
				IDFAVORITOTABLA,  
				DESCRIPCIONTABLA,  
				DESCRIPTABLACAMPO,  
				ESTADO,  
				ACCION		
				  ,@CONTADOR AS Contador
				  ,ROW_NUMBER() OVER (ORDER BY IDFORMATO ASC ) AS RowNumber   	
					FROM VW_FORMATORECURSOCAMPO	
					WHERE 
				(@IDFORMATO is null or @IDFORMATO ='' or  IdFormato = @IDFORMATO)		
				and (@CODIGOFORMATO is null  OR @CODIGOFORMATO =''  OR  upper(CODIGOFORMATO) like '%'+upper(@CODIGOFORMATO)+'%')
				and (@ESTADO is null OR Estado = @ESTADO)
				and (@DESCRIPCIONFORMATO is null  OR @DESCRIPCIONFORMATO =''  OR  upper(DESCRIPCIONFORMATO) like '%'+upper(@DESCRIPCIONFORMATO)+'%')	
				
 
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		
       END
       ELSE
  IF @Accion ='LISTAR'    
    BEGIN    
		SELECT 
				
				IDFORMATO,
				CODIGOFORMATO,
				DESCRIPCIONFORMATO,
				SECUENCIACAMPO, 
				DESCRIPFORMATOCAMPO,  
				FORMULA,
				IDFAVORITOTABLA,  
				DESCRIPCIONTABLA,  
				DESCRIPTABLACAMPO,  
				ESTADO,  
				ACCION	
				FROM VW_FORMATORECURSOCAMPO	
									WHERE 
				(@IDFORMATO is null or @IDFORMATO ='' or  IdFormato = @IDFORMATO)		
				and (@CODIGOFORMATO is null  OR @CODIGOFORMATO =''  OR  upper(CODIGOFORMATO) like '%'+upper(@CODIGOFORMATO)+'%')									
				and (@ESTADO is null OR Estado = @ESTADO)
				and (@DESCRIPCIONFORMATO is null  OR @DESCRIPCIONFORMATO =''  OR  upper(DESCRIPCIONFORMATO) like '%'+upper(@DESCRIPCIONFORMATO)+'%')	
				
end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 	*	FROM 	VW_FORMATORECURSOCAMPO
				where
				(@IDFORMATO = IdFormato) 
				and(@CODIGOFORMATO = codigoformato)	

	end	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_VW_SS_HC_FORMATORECURSOCAMPO_Mantenimiento]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_VW_SS_HC_FORMATORECURSOCAMPO_Mantenimiento]
		@IDFORMATO INT,  
		@CODIGOFORMATO VARCHAR(15), 
		@DESCRIPCIONFORMATO VARCHAR(150),  
		@SECUENCIACAMPO INT,   
		@DESCRIPFORMATOCAMPO VARCHAR(100), 
		@FORMULA VARCHAR(500),
		@IDFAVORITOTABLA INT,  
		@DESCRIPCIONTABLA VARCHAR(100), 
		@DESCRIPTABLACAMPO VARCHAR(150),   
		@ESTADO INT,  
		  
		@ACCION VARCHAR(25)


AS
BEGIN 
SET NOCOUNT ON;
BEGIN  TRANSACTION
	
	if(@ACCION = 'LISTARPAG')
	begin		
		DECLARE @CONTADOR INT =0
	
		SET @CONTADOR=(
				SELECT COUNT(SECUENCIACAMPO) FROM VW_FORMATORECURSOCAMPO	
				WHERE 
					(@IDFORMATO is null or @IDFORMATO ='' or  IDFORMATO = @IDFORMATO)		
					and (@CODIGOFORMATO is null  OR @CODIGOFORMATO =''  OR  upper(CODIGOFORMATO) like '%'+upper(@CODIGOFORMATO)+'%')								
					and (@ESTADO is null OR Estado = @ESTADO)
					and (@DESCRIPCIONFORMATO is null  OR @DESCRIPCIONFORMATO =''  OR  upper(DESCRIPCIONFORMATO) like '%'+upper(@DESCRIPCIONFORMATO)+'%')	
				)
		select @CONTADOR
	end

commit	
	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_VW_SS_IT_ProcesoHistoriaAdjunta]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================           
-- Author:    Grace Córdova           
-- Create date: 10/11/2015    
-- =============================================     
CREATE OR ALTER PROCEDURE [SP_VW_SS_IT_ProcesoHistoriaAdjunta]
@idsecuencia		INT,
@CodigoSucursal		VARCHAR(20),
@UnidadReplicacion	CHAR(4),
@IdAplicativo		INT,
@CodigoReferencia	VARCHAR(20),
@CodigoHHCC			VARCHAR(20),
@DNI				VARCHAR(50),
@IdPaciente			INT,
@TipoAtencion		INT,
@Fecha				DATETIME,

@Especialidad		VARCHAR(50),
@IdEspecialidad		INT,
@Servicio			VARCHAR(50),
@IdServicio			INT,
@CodigoMedico		VARCHAR(50),
@IdMedico			INT,
@CodigoAdmision		VARCHAR(10),
@CodigoOA			VARCHAR(10),
@CodigoDiagnostico	VARCHAR(10),
@IdDiagnostico		INT,

@NumeroPagina		INT,
@RutaImagen			VARCHAR(150),
@FechaRecepcion		DATETIME,
@IndicadorProcesado CHAR(1),
@IndicadorError		CHAR(1),
@DescripcionError	VARCHAR(100),
@Accion				VARCHAR(20),
@Rownumber			BIGINT
AS    
BEGIN      
IF (@Accion = 'LISTARPAG')    
BEGIN    
DECLARE @CONTADOR INT    
SET @CONTADOR = (SELECT COUNT(*) FROM SS_IT_ProcesoHistoriaAdjunta    
WHERE ( IdAplicativo = @IdAplicativo OR @IdAplicativo IS NULL OR @IdAplicativo = 0 ) 
      AND ( IdPaciente = @IdPaciente OR @IdPaciente IS NULL OR @IdPaciente = 0 ) 
      AND ( Upper(DNI) LIKE '%' + Upper(@DNI) + '%' OR @DNI IS NULL )
      AND ( Upper(CodigoReferencia) LIKE '%' + Upper(@CodigoReferencia) + '%' OR @CodigoReferencia IS NULL )
      AND ( Upper(CodigoSucursal) LIKE '%' + Upper(@CodigoSucursal) + '%' OR @CodigoSucursal IS NULL ) )    
      
SELECT @CONTADOR    
END    
END    
/*    
EXEC SP_VW_SS_IT_ProcesoHistoriaAdjunta    
null,null,null,null,null,null,null,null,null,null,
null,null,null,null,null,null,null,null,null,null,
null,null,null,null,null,null,'LISTARPAG',null
*/
GO
/****** Object:  StoredProcedure [dbo].[SP_VW_SS_IT_ProcesoHistoriaAdjuntaListar]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ============================================= 
-- Author:    Grace Córdova 
-- Create date: 10/11/2015 
-- ============================================= 
CREATE OR ALTER PROCEDURE [SP_VW_SS_IT_ProcesoHistoriaAdjuntaListar]
  @idsecuencia        INT, 
  @CodigoSucursal     VARCHAR(20), 
  @UnidadReplicacion  CHAR(4), 
  @IdAplicativo       INT, 
  @CodigoReferencia   VARCHAR(20), 
  @CodigoHHCC         VARCHAR(20), 
  @DNI                VARCHAR(50), 
  @IdPaciente         INT, 
  @TipoAtencion       INT, 
  @Fecha              DATETIME, 
  @Especialidad       VARCHAR(50), 
  @IdEspecialidad     INT, 
  @Servicio           VARCHAR(50), 
  @IdServicio         INT, 
  @CodigoMedico       VARCHAR(50), 
  @IdMedico           INT, 
  @CodigoAdmision     VARCHAR(10), 
  @CodigoOA           VARCHAR(10), 
  @CodigoDiagnostico  VARCHAR(10), 
  @IdDiagnostico      INT, 
  @NumeroPagina       INT, 
  @RutaImagen         VARCHAR(150), 
  @FechaRecepcion     DATETIME, 
  @IndicadorProcesado CHAR(1), 
  @IndicadorError     CHAR(1), 
  @DescripcionError   VARCHAR(100), 
  @Accion             VARCHAR(20), 
  @Rownumber          BIGINT, 
  @INICIO             INT= NULL, 
  @NUMEROFILAS        INT = NULL 
AS 
  BEGIN 
    IF ( @Accion = 'LISTAR' ) 
    BEGIN 
      SELECT 
             0 as idsecuencia, 
             codigosucursal, 
             unidadreplicacion, 
             idaplicativo, 
             codigoreferencia, 
             codigohhcc, 
             dni, 
             idpaciente, 
             tipoatencion, 
             fecha, 
             especialidad, 
             idespecialidad, 
             servicio, 
             idservicio, 
             codigomedico, 
             idmedico, 
             codigoadmision, 
             codigooa, 
             codigodiagnostico, 
             iddiagnostico, 
             numeropagina, 
             rutaimagen, 
             fecharecepcion, 
             indicadorprocesado, 
             indicadorerror, 
             descripcionerror, 
             accion, 
             0 as rownumber 
      FROM   dbo.SS_IT_ProcesoHistoriaAdjunta
      WHERE  ( idaplicativo = @IdAplicativo OR     @IdAplicativo IS NULL OR     @IdAplicativo = 0 ) 
      AND    ( idpaciente = @IdPaciente OR     @IdPaciente IS NULL OR     @IdPaciente = 0 ) 
      AND ( Upper(DNI) LIKE '%' + Upper(@DNI) + '%' OR @DNI IS NULL )
      AND ( Upper(CodigoReferencia) LIKE '%' + Upper(@CodigoReferencia) + '%' OR @CodigoReferencia IS NULL )
      AND ( Upper(CodigoSucursal) LIKE '%' + Upper(@CodigoSucursal) + '%' OR @CodigoSucursal IS NULL )
    END 
    ELSE 
    IF ( @Accion = 'LISTARPAG' ) 
    BEGIN 
      DECLARE @CONTADOR INT 
      SELECT @CONTADOR = Count(*) FROM   ss_it_procesohistoriaadjunta 
      WHERE  ( idaplicativo = @IdAplicativo OR     @IdAplicativo IS NULL OR     @IdAplicativo = 0 ) 
      AND    ( idpaciente = @IdPaciente OR     @IdPaciente IS NULL OR     @IdPaciente = 0 ) 
      AND ( Upper(DNI) LIKE '%' + Upper(@DNI) + '%' OR @DNI IS NULL )
      AND ( Upper(CodigoReferencia) LIKE '%' + Upper(@CodigoReferencia) + '%' OR @CodigoReferencia IS NULL )
      AND ( Upper(CodigoSucursal) LIKE '%' + Upper(@CodigoSucursal) + '%' OR @CodigoSucursal IS NULL )
      SELECT 
             idsecuencia, 
             codigosucursal, 
             unidadreplicacion, 
             idaplicativo, 
             codigoreferencia, 
             codigohhcc, 
             dni, 
             idpaciente, 
             tipoatencion, 
             fecha, 
             especialidad, 
             idespecialidad, 
             servicio, 
             idservicio, 
             codigomedico, 
             idmedico, 
             codigoadmision, 
             codigooa, 
             codigodiagnostico, 
             iddiagnostico, 
             numeropagina, 
             rutaimagen, 
             fecharecepcion, 
             indicadorprocesado, 
             indicadorerror, 
             descripcionerror, 
             accion, 
             rownumber 
      FROM   ( 
                      SELECT   
                               convert(int,Row_number() OVER( ORDER BY idpaciente DESC)) as idsecuencia, 
                               codigosucursal, 
                               unidadreplicacion, 
                               idaplicativo, 
                               codigoreferencia, 
                               codigohhcc, 
                               dni, 
                               idpaciente, 
                               tipoatencion, 
                               fecha, 
                               especialidad, 
                               idespecialidad, 
                               servicio, 
                               idservicio, 
                               codigomedico, 
                               idmedico, 
                               codigoadmision, 
                               codigooa, 
                               codigodiagnostico, 
                               iddiagnostico, 
                               numeropagina, 
                               rutaimagen, 
                               fecharecepcion, 
                               indicadorprocesado, 
                               indicadorerror, 
                               descripcionerror, 
                               accion, 
                               Row_number() OVER( ORDER BY idpaciente DESC) AS rownumber,
                               @CONTADOR AS contador
                      FROM     ss_it_procesohistoriaadjunta 
                      WHERE    ( idaplicativo = @IdAplicativo OR       @IdAplicativo IS NULL OR       @IdAplicativo = 0 ) 
                      and      ( idpaciente = @IdPaciente OR       @IdPaciente IS NULL OR       @IdPaciente = 0 ) 
                      AND ( Upper(DNI) LIKE '%' + Upper(@DNI) + '%' OR @DNI IS NULL )
					  AND ( Upper(CodigoReferencia) LIKE '%' + Upper(@CodigoReferencia) + '%' OR @CodigoReferencia IS NULL )
					  AND ( Upper(CodigoSucursal) LIKE '%' + Upper(@CodigoSucursal) + '%' OR @CodigoSucursal IS NULL ))AS listado 
      WHERE  ( @INICIO IS NULL AND    @NUMEROFILAS IS NULL ) OR     ( rownumber BETWEEN @INICIO AND    @NUMEROFILAS ) 
    END 
  END 
  /* 
EXEC SP_VW_SS_IT_ProcesoHistoriaAdjunta 
NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
NULL,NULL,NULL,NULL,NULL,NULL,'LISTARPAG',NULL,0,10 
*/
GO
/****** Object:  StoredProcedure [dbo].[SP_VW_TABLACAMPO]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_VW_TABLACAMPO]  
  @IDFAVORITOTABLA			INT,    
  @IDCAMPO					INT,
  @DESCRIPCIONTABLA			VARCHAR(100),   
  @DESCRIPTABLACAMPO		VARCHAR(150),   
  @NumeroClavePrimaria		INT, 
  @ESTADO					INT,    
  @ACCION					VARCHAR(25),  
  @TIPOTABLA				INT
  
AS  
BEGIN   
SET NOCOUNT ON;  
BEGIN  TRANSACTION  
   
 if(@ACCION = 'LISTARPAG')  
 begin    
  DECLARE @CONTADOR INT =0  
   
		SET @CONTADOR	=	(
				SELECT COUNT(IdFavoritoTabla) FROM VW_TABLACAMPO	
				WHERE 
					(@IDFAVORITOTABLA is null OR (IdFavoritoTabla = @IDFAVORITOTABLA) or @IDFAVORITOTABLA =0)	
					and (@DESCRIPTABLACAMPO is null  OR @DESCRIPTABLACAMPO =''  OR  upper(DescripTablaCampo) like '%'+upper(@DESCRIPTABLACAMPO)+'%')   						
							)
  select @CONTADOR  
 end  
 else
  if(@ACCION = 'LISTARPAGSELEC')  
 begin    
  DECLARE @CONTADORS INT =0     
	SET @CONTADORS	=	(
				SELECT COUNT(IdFavoritoTabla) FROM VW_TABLACAMPO	
				WHERE 
							(@IDFAVORITOTABLA is null OR (IdFavoritoTabla = @IDFAVORITOTABLA) or @IDFAVORITOTABLA =0)	
					and (@DESCRIPTABLACAMPO is null  OR @DESCRIPTABLACAMPO =''  OR  upper(DescripTablaCampo) like '%'+upper(@DESCRIPTABLACAMPO)+'%')   						
					--and IdFavoritoTabla < 7 
					and TipoTabla = 1
					and NumeroClavePrimaria =1	
							)
  select @CONTADORS  
 end    
commit      
END



GO
/****** Object:  StoredProcedure [dbo].[SP_VW_TABLACAMPO_LISTA]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_VW_TABLACAMPO_LISTA]

		@IDFAVORITOTABLA		INT,  
		@IDCAMPO				INT,
		@DESCRIPCIONTABLA		VARCHAR(100), 
		@DESCRIPTABLACAMPO		VARCHAR(150), 
		@NumeroClavePrimaria	INT,
		@ESTADO					INT,  
		@ACCION					VARCHAR(25),
		@TIPOTABLA				INT,
	    @INICIO					int= null,  
	    @NUMEROFILAS			int = null 
AS    
BEGIN    
if(@ACCION = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR	=	(
				SELECT COUNT(IdFavoritoTabla) FROM VW_TABLACAMPO	
				WHERE 
							(@IDFAVORITOTABLA is null OR (IdFavoritoTabla = @IDFAVORITOTABLA) or @IDFAVORITOTABLA =0)	
					and (@DESCRIPTABLACAMPO is null  OR @DESCRIPTABLACAMPO =''  OR  upper(DescripTablaCampo) like '%'+upper(@DESCRIPTABLACAMPO)+'%')   						
				
							)
		SELECT 
				
				IdFavoritoTabla ,  
				IdCampo,
				DescripcionTabla,  
				DescripTablaCampo,  
				Estado,  
				Accion,
				TipoTabla
				
		FROM (		
			SELECT
				IdFavoritoTabla ,  
				IdCampo,
				DescripcionTabla,  
				DescripTablaCampo,  
				Estado,  
				Accion,
				TipoTabla	
				  ,@CONTADOR AS Contador
				  ,ROW_NUMBER() OVER (ORDER BY IdFavoritoTabla ASC ) AS RowNumber   	
					FROM VW_TABLACAMPO	
					WHERE 
								(@IDFAVORITOTABLA is null OR (IdFavoritoTabla = @IDFAVORITOTABLA) or @IDFAVORITOTABLA =0)	
					and (@DESCRIPTABLACAMPO is null  OR @DESCRIPTABLACAMPO =''  OR  upper(DescripTablaCampo) like '%'+upper(@DESCRIPTABLACAMPO)+'%')   						
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		
       END
       ELSE
       if(@ACCION = 'LISTARPAGSELEC')
	begin
		 DECLARE @CONTADORS INT
	
		SET @CONTADORS	=	(
				SELECT COUNT(IdFavoritoTabla) FROM VW_TABLACAMPO	
				WHERE 
							(@IDFAVORITOTABLA is null OR (IdFavoritoTabla = @IDFAVORITOTABLA) or @IDFAVORITOTABLA =0)	
					and (@DESCRIPTABLACAMPO is null  OR @DESCRIPTABLACAMPO =''  OR  upper(DescripTablaCampo) like '%'+upper(@DESCRIPTABLACAMPO)+'%')   						
					--and IdFavoritoTabla < 7 
					and TipoTabla = 1
					and NumeroClavePrimaria =1	
							)
		SELECT 
				
				IdFavoritoTabla ,  
				IdCampo,
				DescripcionTabla,  
				DescripTablaCampo,  
				NumeroClavePrimaria,
				Estado,  
				Accion,
				TipoTabla
				
		FROM (		
			SELECT
				IdFavoritoTabla ,  
				IdCampo,
				DescripcionTabla,  
				DescripTablaCampo,  
				NumeroClavePrimaria,
				Estado,  
				Accion,
				TipoTabla	
				  ,@CONTADORS AS Contador
				  ,ROW_NUMBER() OVER (ORDER BY IdFavoritoTabla ASC ) AS RowNumber   	
					FROM VW_TABLACAMPO	
				WHERE 
						(@IDFAVORITOTABLA is null OR (IdFavoritoTabla = @IDFAVORITOTABLA) or @IDFAVORITOTABLA =0)	
					and (@DESCRIPTABLACAMPO is null  OR @DESCRIPTABLACAMPO =''  OR  upper(DescripTablaCampo) like '%'+upper(@DESCRIPTABLACAMPO)+'%')   						
					and TipoTabla = 1
					and NumeroClavePrimaria =1						
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		
       END
       ELSE
  IF @Accion ='LISTAR'    
    BEGIN    
		SELECT 
				
				IdFavoritoTabla ,  
				IdCampo,
				DescripcionTabla,  
				DescripTablaCampo,   
				NumeroClavePrimaria,
				Estado,  
				Accion,
				TipoTabla
				FROM VW_TABLACAMPO	
					WHERE 
							(@IDFAVORITOTABLA is null OR (IdFavoritoTabla = @IDFAVORITOTABLA) or @IDFAVORITOTABLA =0)	
						AND (@DESCRIPTABLACAMPO IS NULL OR (DescripTablaCampo = @DESCRIPTABLACAMPO))  									
end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 	*	FROM 	VW_TABLACAMPO
				where
				(@IDFAVORITOTABLA = IdFavoritoTabla) 
	end	
END

--exec SP_VW_TABLACAMPO_LISTA 1,0,null,'CodigoDiagnostico',null,'LISTAR',NULL,0,10
GO
/****** Object:  StoredProcedure [dbo].[SP_WH_ClaseFamilia_Listado]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_WH_ClaseFamilia_Listado]
			@Linea char(6),
            @Familia char(6), 
            @DescripcionLocal varchar(150), 
            @DescripcionIngles varchar(150), 
            @DescripcionCompleta varchar(150),
            @CuentaInventario char(20),
            @CuentaGasto char(20),
            @ElementoGasto char(6),
            @PartidaPresupuestal char(4),
            @FlujodeCaja char(4),
            @LineaFamilia char(12),
            @LoteValidacionFlag char(1),
            @MedicinaGrupoAFlag char(1),
            @MedicinaGrupoHFlag char(1),
            @MedicinaGrupoEFlag char(1),
            @MedicinaGrupoRFlag char(1),
            @CuentaVentas char(20),
            @CuentaTransito char(20),
            @CuentaCostoVentas char(20),
            @Caracteristica01 char(3),
            @Caracteristica02 char(3),
            @Caracteristica03 char(3),
            @Caracteristica04 char(3),
            @Caracteristica05 char(3),
            @Estado char(1),
            @UltimoUsuario varchar(25),
            @UltimaFechaModif datetime,
            @ReferenciaFiscal01 char(10),
            @ReferenciaFiscal02 char(20),
            @ReferenciaFiscal03 char(10),
            @ContactoEMail char(50),
            @ContactoFax char(10),
            @ContactoNombre char(50),
            @ContactoTelefono char(10),
            @CuentaVentaComercial varchar(25),
            @CuentaCompras char(20),
            @CentroCosto varchar(15),
            @CuentaServicioTecnico char(20),
            @Accion varchar(25),
           
		   @INICIO   int= null,  
		   @NUMEROFILAS int = null    
AS    
BEGIN    
if(@ACCION = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
			  IF @Estado='T' 
			BEGIN
			SET @Estado=NULL
			END
		SET @CONTADOR=(SELECT COUNT(Linea) FROM WH_ClaseFamilia 
	 					WHERE 
				(@Familia is null or @Familia ='' or  Familia = @Familia)	
			AND (@Linea is null or @Linea ='' or  Linea = @Linea)										
			AND (@ESTADO is null  OR @ESTADO =''  OR  upper(ESTADO) like '%'+upper(@ESTADO)+'%')	
			AND (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')	
					)  
					SELECT
					Linea,
					Familia,
					DescripcionLocal,
					DescripcionIngles,
					DescripcionCompleta,
					CuentaInventario,
					CuentaGasto,
					ElementoGasto,
					PartidaPresupuestal,
					FlujodeCaja,
					LineaFamilia,
					LoteValidacionFlag,
					MedicinaGrupoAFlag,
					MedicinaGrupoHFlag,
					MedicinaGrupoEFlag,
					MedicinaGrupoRFlag,
					CuentaVentas,
					CuentaTransito,
					CuentaCostoVentas,
					Caracteristica01,
					Caracteristica02,
					Caracteristica03,
					Caracteristica04,
					Caracteristica05,
					Estado,
					UltimoUsuario,
					UltimaFechaModif,
					ReferenciaFiscal01,
					ReferenciaFiscal02,
					ReferenciaFiscal03,
					ContactoEMail,
					ContactoFax,
					ContactoNombre,
					ContactoTelefono,
					CuentaVentaComercial,
					CuentaCompras,
					CentroCosto,
					CuentaServicioTecnico,
					Accion
					FROM (		
			SELECT
					Linea,
					Familia,
					DescripcionLocal,
					DescripcionIngles,
					DescripcionCompleta,
					CuentaInventario,
					CuentaGasto,
					ElementoGasto,
					PartidaPresupuestal,
					FlujodeCaja,
					LineaFamilia,
					LoteValidacionFlag,
					MedicinaGrupoAFlag,
					MedicinaGrupoHFlag,
					MedicinaGrupoEFlag,
					MedicinaGrupoRFlag,
					CuentaVentas,
					CuentaTransito,
					CuentaCostoVentas,
					Caracteristica01,
					Caracteristica02,
					Caracteristica03,
					Caracteristica04,
					Caracteristica05,
					Estado,
					UltimoUsuario,
					UltimaFechaModif,
					ReferenciaFiscal01,
					ReferenciaFiscal02,
					ReferenciaFiscal03,
					ContactoEMail,
					ContactoFax,
					ContactoNombre,
					ContactoTelefono,
					CuentaVentaComercial,
					CuentaCompras,
					CentroCosto,
					CuentaServicioTecnico,
					Accion
					
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY Linea ASC ) AS RowNumber   	
					FROM WH_ClaseFamilia
					WHERE 
				(@Familia is null or @Familia ='' or  Familia = @Familia)	
			AND (@Linea is null or @Linea ='' or  Linea = @Linea)										
			AND (@ESTADO is null  OR @ESTADO =''  OR  upper(ESTADO) like '%'+upper(@ESTADO)+'%')	
			AND (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')	
					)  
			 AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		END
       ELSE
  IF @Accion ='LISTAR'    
    BEGIN    
		SELECT
					Linea,
					Familia,
					DescripcionLocal,
					DescripcionIngles,
					DescripcionCompleta,
					CuentaInventario,
					CuentaGasto,
					ElementoGasto,
					PartidaPresupuestal,
					FlujodeCaja,
					LineaFamilia,
					LoteValidacionFlag,
					MedicinaGrupoAFlag,
					MedicinaGrupoHFlag,
					MedicinaGrupoEFlag,
					MedicinaGrupoRFlag,
					CuentaVentas,
					CuentaTransito,
					CuentaCostoVentas,
					Caracteristica01,
					Caracteristica02,
					Caracteristica03,
					Caracteristica04,
					Caracteristica05,
					Estado,
					UltimoUsuario,
					UltimaFechaModif,
					ReferenciaFiscal01,
					ReferenciaFiscal02,
					ReferenciaFiscal03,
					ContactoEMail,
					ContactoFax,
					ContactoNombre,
					ContactoTelefono,
					CuentaVentaComercial,
					CuentaCompras,
					CentroCosto,
					CuentaServicioTecnico,
					Accion
					FROM WH_ClaseFamilia
					WHERE 
					(@Linea is null OR (Linea = @Linea) or @Linea =0)
					and (@Familia is null OR Familia = @Familia)					
					and (@Estado is null OR Estado = @Estado)
					  end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 
					*					
				FROM WH_ClaseFamilia
					WHERE 
					(@Linea is null OR (Linea = @Linea) or @Linea =0)
					and (@Familia is null OR Familia = @Familia or @Familia =0)					
			

	end	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_WH_ClaseLinea_Listado]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_WH_ClaseLinea_Listado]    
    
           @Linea char(6),    
           @DescripcionLocal char(30),    
           @DescripcionIngles char(30),    
           @GrupoLinea char(2),    
           @ManejoColorSerieFlag char(18),    
           @Estado char(1),    
           @UltimaFechaModif datetime,    
           @UltimoUsuario varchar(25),    
           @Accion varchar(25),    
               
     @INICIO   int= null,      
     @NUMEROFILAS int = null        
AS        
BEGIN        
if(@ACCION = 'LISTARPAG')    
 begin    
   DECLARE @CONTADOR INT    
    IF @Estado='T'     
   BEGIN    
   SET @Estado=NULL    
   END    
       
  SET @CONTADOR=(SELECT COUNT(Linea) FROM WH_ClaseLinea    
       WHERE     
     --(@Linea is null OR (Linea = @Linea) or @Linea =0)    
     (@Linea is null or @Linea =0 or  cast(Linea as VARCHAR) like '%'+upper(@Linea)+'%')    
     and (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')         
     and (@ESTADO is null  OR @ESTADO =''  OR  upper(ESTADO) like '%'+upper(@ESTADO)+'%')     
     )      
     SELECT    
     Linea,    
     DescripcionLocal,    
     DescripcionIngles,    
     GrupoLinea,    
     ManejoColorSerieFlag,    
     Estado,    
     UltimaFechaModif,    
     UltimoUsuario,    
     Accion    
  FROM (      
   SELECT    
     Linea,    
     DescripcionLocal,    
     DescripcionIngles,    
     GrupoLinea,    
     ManejoColorSerieFlag,    
     Estado,    
     UltimaFechaModif,    
     UltimoUsuario,    
     Accion    
         
     ,@CONTADOR AS Contador    
     ,ROW_NUMBER() OVER (ORDER BY Linea ASC ) AS RowNumber        
     FROM WH_ClaseLinea     
     WHERE     
     --(@Linea is null OR (Linea = @Linea) or @Linea =0)    
     (@Linea is null  OR @Linea =''  OR  upper(rtrim(Linea)) like '%'+upper(rtrim(@Linea))+'%')         
     and (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(rtrim(DescripcionLocal)) like '%'+upper(rtrim(@DescripcionLocal))+'%')         
     and (@ESTADO is null  OR @ESTADO =''  OR  upper(ESTADO) like '%'+upper(@ESTADO)+'%')     
     )      
    AS LISTADO    
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR      
            RowNumber BETWEEN @Inicio  AND @NumeroFilas     
  END    
       ELSE    
  IF @Accion ='LISTAR'        
    BEGIN        
  SELECT    
     Linea,    
     DescripcionLocal,    
     DescripcionIngles,    
     GrupoLinea,    
     ManejoColorSerieFlag,    
     Estado,    
     UltimaFechaModif,    
     UltimoUsuario,    
     Accion    
     FROM WH_ClaseLinea     
     WHERE     
     (@Linea is null  OR @Linea =''  OR  upper(rtrim(Linea)) like '%'+upper(rtrim(@Linea))+'%')         
     and (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(rtrim(DescripcionLocal)) like '%'+upper(rtrim(@DescripcionLocal))+'%')          
     and (@ESTADO is null  OR @ESTADO =''  OR  upper(ESTADO) like '%'+upper(@ESTADO)+'%')     
    
       end     
 else    
 if(@ACCION = 'LISTARPORID')    
 begin      
    SELECT     
     *         
    from     
    WH_ClaseLinea    
    
     WHERE     
       (@Linea is null OR (Linea = @Linea) or @Linea =0)    
    
 end     
END
GO
/****** Object:  StoredProcedure [dbo].[SP_WH_ItemMast_mantenimiento]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER PROCEDURE [SP_WH_ItemMast_mantenimiento]  
           @Item VARchar(50),  
           @ItemTipo char(2),  
           @Linea char(6),  
           @Familia char(6),  
           @SubFamilia char(6),  
           @SubFamiliaInferior char(6),  
           @DescripcionLocal varchar,  
           @DescripcionIngles varchar,  
           @DescripcionCompleta varchar,  
           @NumeroDeParte char(20),  
           @CodigoInterno char(20),  
           @UnidadCodigo char(6),  
           @UnidadCompra char(6),  
           @UnidadEmbalaje char(6),  
           @Color char(3),  
           @Modelo char(20),  
           @MarcaCodigo char(4),  
           @ItemProcedencia varchar(10),  
           @ClasificacionComercial char(6),  
           @PartidaArancelaria char(10),  
           @CodigoBarras varchar(25),  
           @CodigoBarrasFabricante char(13),  
           @CodigoBarras2 char(30),  
           @MonedaCodigo char(2),  
           @PrecioCosto decimal(16,6),  
           @PrecioUnitarioLocal decimal(16,6),  
           @PrecioUnitarioDolares decimal(16,6),  
           @ItemPrecioFlag char(1),  
           @ItemPrecioCodigo char(20),  
           @DisponibleVentaFlag char(1),  
           @ManejoxLoteFlag char(1),  
           @ManejoxSerieFlag char(1),  
           @ManejoxKitFlag char(1),  
           @ManejoxKitSplitFlag char(1),  
           @ManejoxUnidadFlag char(1),  
           @AfectoImpuestoVentasFlag char(1),  
           @AfectoImpuesto2Flag char(1),  
           @RequisicionamientoAutomaticoFl char(1),  
           @ControlCalidadFlag char(1),  
           @DisponibleTransferenciaFlag char(1),  
           @DisponibleConsumoFlag char(1),  
           @FormularioFlag char(1),  
           @FormularioNroJuegos int,  
           @ISOAplicableFlag char(1),  
           @ISONormaInterna char(15),  
           @CantidadDobleFlag char(1),  
           @CantidadDobleFactor decimal(16,10),  
           @UnidadCodigoDoble char(6),  
           @UnidadReplicacion char(4),  
           @ImageFile char(80),  
           @MapaFile char(80),  
           @CuentaInventario char(20),  
           @CuentaGasto char(20),  
           @CuentaInversion char(20),  
           @CuentaServicioTecnico char(20),  
           @CuentaSalidaTerceros char(20),  
           @CuentaVentas char(20),  
           @CuentaTransito char(20),  
           @ElementoGasto char(10),  
           @ElementoInversion char(10),  
           @PartidaPresupuestal char(4),  
           @FlujodeCaja char(4),  
           @LotedeCompra int,  
           @LotedeDespacho decimal(16,6),  
           @LotedeCompraM3 decimal(16,6),  
           @LotedeCompraKG decimal(16,6),  
           @PeriodicidadCompraMeses money,  
           @EspecificacionTecnica varchar(255),  
           @Dimensiones char(30),  
           @FactorEquivalenciaComercial decimal(10,4),  
           @ABCCodigo char(2),  
           @InventarioTolerancia decimal(10,7),  
           @StockMinimo money,  
           @StockMaximo money,  
           @LotedeVenta int,  
           @DescripcionAdicional text,  
           @CodigoPrecio char(3),  
           @CaracteristicaValor01 char(10),  
           @CaracteristicaValor02 char(10),  
           @CaracteristicaValor03 char(10),  
           @CaracteristicaValor04 char(10),  
           @CaracteristicaValor05 char(10),  
           @ReferenciaFiscal02 char(20),  
           @ReferenciaFiscalIngreso02 char(20),  
           @DetraccionCodigo char(4),  
           @Estado char(1),  
           @PeriodicidadCompra char(1),  
           @UltimaFechaModif datetime,  
           @UltimoUsuario varchar(25),  
           @Centrocosto varchar(15),  
           @ConceptoGasto varchar(15),  
           @ClasificadorMovimiento varchar(15),  
           @FlujodeCajaIngreso char(4),  
           @MapaCodigo char(10),  
           @paisfabricacion char(4),  
           @ABCCodigoIN char(3),  
           @Lectura varchar(1),  
           @IdGrupoComponente int,  
           @IdRegimenVenta int,  
           @IndicadorReemplazo int,  
           @UsuarioCreacion varchar(25),  
           @FechaCreacion datetime,  
           @CuentaVentaComercial varchar(25),  
           @CuentaDescuentoVentaComercial varchar(25),  
           @IndicadorCuentaVenta int,  
           @TipoRepuesto varchar(2),  
           @Cantidadkit int,  
           @PeriodoInicioReposicion int,  
           @PeriodosReposicion int,  
           @IndicadorClasificacion int,  
           @PeridoInicioReposicion int,  
           @IdClasificacion int,  
           @cantidadReposicion decimal(16,6),  
           @grupoReposicion char(6),  
           @IndicadorReposicion int,  
           @IndicadorPrecioManual int,  
           @IndicadorConsumoFraccionado int,  
           @nombreLaboratorio varchar(255),  
           @estadoAnterior varchar(1),  
           @CuentaCompras char(20),  
           @PrecioCostoAnt decimal(16,6),  
           @UltimaOC varchar(10),  
           @PreviaOC varchar(10),  
           @tipomedicamento varchar(1),  
           @CodigoDigemid varchar(50),  
           @EAN13 varchar(20),  
           @MedicamentoCodigo varchar(50),  
           @MedicamentoCodigoPadre varchar(50),  
           @NombreTabla varchar(100),  
           @tipofolder int,  
   
     @ACCION varchar(25)  
     AS  
BEGIN  
SET NOCOUNT ON;    
BEGIN  TRANSACTION  
 DECLARE @CONTADOR INT  
 IF(@ACCION='INSERT')  
 BEGIN  
   SELECT @CONTADOR= isnull(MAX(Item),0)+1 from WH_ItemMast   
  SET @Item = @CONTADOR  
  INSERT INTO WH_ItemMast   
  (  
  Item,  
  ItemTipo,  
  Linea,  
  Familia,  
  SubFamilia,  
  SubFamiliaInferior,  
  DescripcionLocal,  
  DescripcionIngles,  
  DescripcionCompleta,  
  NumeroDeParte,  
  CodigoInterno,  
  UnidadCodigo,  
  UnidadCompra,  
  UnidadEmbalaje,  
  Color,  
  Modelo,  
  MarcaCodigo,  
  ItemProcedencia,  
  ClasificacionComercial,  
  PartidaArancelaria,  
  CodigoBarras,  
  CodigoBarrasFabricante,  
  CodigoBarras2,  
  MonedaCodigo,  
  PrecioCosto,  
  PrecioUnitarioLocal,  
  PrecioUnitarioDolares,  
  ItemPrecioFlag,  
  ItemPrecioCodigo,  
  DisponibleVentaFlag,  
  ManejoxLoteFlag,  
  ManejoxSerieFlag,  
  ManejoxKitFlag,  
  ManejoxKitSplitFlag,  
  ManejoxUnidadFlag,  
  AfectoImpuestoVentasFlag,  
  AfectoImpuesto2Flag,  
  RequisicionamientoAutomaticoFl,  
  ControlCalidadFlag,  
  DisponibleTransferenciaFlag,  
  DisponibleConsumoFlag,  
  FormularioFlag,  
  FormularioNroJuegos,  
  ISOAplicableFlag,  
  ISONormaInterna,  
  CantidadDobleFlag,  
  CantidadDobleFactor,  
  UnidadCodigoDoble,  
  UnidadReplicacion,  
  ImageFile,  
  MapaFile,  
  CuentaInventario,  
  CuentaGasto,  
  CuentaInversion,  
  CuentaServicioTecnico,  
  CuentaSalidaTerceros,  
  CuentaVentas,  
  CuentaTransito,  
  ElementoGasto,  
  ElementoInversion,  
  PartidaPresupuestal,  
  FlujodeCaja,  
  LotedeCompra,  
  LotedeDespacho,  
  LotedeCompraM3,  
  LotedeCompraKG,  
  PeriodicidadCompraMeses,  
  EspecificacionTecnica,  
  Dimensiones,  
  FactorEquivalenciaComercial,  
  ABCCodigo,  
  InventarioTolerancia,  
  StockMinimo,  
  StockMaximo,  
  LotedeVenta,  
  DescripcionAdicional,  
  CodigoPrecio,  
  CaracteristicaValor01,  
  CaracteristicaValor02,  
  CaracteristicaValor03,  
  CaracteristicaValor04,  
  CaracteristicaValor05,  
  ReferenciaFiscal02,  
  ReferenciaFiscalIngreso02,  
  DetraccionCodigo,  
  Estado,  
  PeriodicidadCompra,  
  UltimaFechaModif,  
  UltimoUsuario,  
  Centrocosto,  
  ConceptoGasto,  
  ClasificadorMovimiento,  
  FlujodeCajaIngreso,  
  MapaCodigo,  
  paisfabricacion,  
  ABCCodigoIN,  
  Lectura,  
  IdGrupoComponente,  
  IdRegimenVenta,  
  IndicadorReemplazo,  
  UsuarioCreacion,  
  FechaCreacion,  
  CuentaVentaComercial,  
  CuentaDescuentoVentaComercial,  
  IndicadorCuentaVenta,  
  TipoRepuesto,  
  Cantidadkit,  
  PeriodoInicioReposicion,  
  PeriodosReposicion,  
  IndicadorClasificacion,  
  PeridoInicioReposicion,  
  IdClasificacion,  
  cantidadReposicion,  
  grupoReposicion,  
  IndicadorReposicion,  
  IndicadorPrecioManual,  
  IndicadorConsumoFraccionado,  
  nombreLaboratorio,  
  estadoAnterior,  
  CuentaCompras,  
  PrecioCostoAnt,  
  UltimaOC,  
  PreviaOC,  
  tipomedicamento,  
  CodigoDigemid,  
  EAN13,  
  MedicamentoCodigo,  
  MedicamentoCodigoPadre,  
  NombreTabla,  
  tipofolder,  
  Accion   
  )  
  VALUES  
  (  
  @Item,  
  @ItemTipo,  
  @Linea,  
  @Familia,  
  @SubFamilia,  
  @SubFamiliaInferior,  
  @DescripcionLocal,  
  @DescripcionIngles,  
  @DescripcionCompleta,  
  @NumeroDeParte,  
  @CodigoInterno,  
  @UnidadCodigo,  
  @UnidadCompra,  
  @UnidadEmbalaje,  
  @Color,  
  @Modelo,  
  @MarcaCodigo,  
  @ItemProcedencia,  
  @ClasificacionComercial,  
  @PartidaArancelaria,  
  @CodigoBarras,  
  @CodigoBarrasFabricante,  
  @CodigoBarras2,  
  @MonedaCodigo,  
  @PrecioCosto,  
  @PrecioUnitarioLocal,  
  @PrecioUnitarioDolares,  
  @ItemPrecioFlag,  
  @ItemPrecioCodigo,  
  @DisponibleVentaFlag,  
  @ManejoxLoteFlag,  
  @ManejoxSerieFlag,  
  @ManejoxKitFlag,  
  @ManejoxKitSplitFlag,  
  @ManejoxUnidadFlag,  
  @AfectoImpuestoVentasFlag,  
  @AfectoImpuesto2Flag,  
  @RequisicionamientoAutomaticoFl,  
  @ControlCalidadFlag,  
  @DisponibleTransferenciaFlag,  
  @DisponibleConsumoFlag,  
  @FormularioFlag,  
  @FormularioNroJuegos,  
  @ISOAplicableFlag,  
  @ISONormaInterna,  
  @CantidadDobleFlag,  
  @CantidadDobleFactor,  
  @UnidadCodigoDoble,  
  @UnidadReplicacion,  
  @ImageFile,  
  @MapaFile,  
  @CuentaInventario,  
  @CuentaGasto,  
  @CuentaInversion,  
  @CuentaServicioTecnico,  
  @CuentaSalidaTerceros,  
  @CuentaVentas,  
  @CuentaTransito,  
  @ElementoGasto,  
  @ElementoInversion,  
  @PartidaPresupuestal,  
  @FlujodeCaja,  
  @LotedeCompra,  
  @LotedeDespacho,  
  @LotedeCompraM3,  
  @LotedeCompraKG,  
  @PeriodicidadCompraMeses,  
  @EspecificacionTecnica,  
  @Dimensiones,  
  @FactorEquivalenciaComercial,  
  @ABCCodigo,  
  @InventarioTolerancia,  
  @StockMinimo,  
  @StockMaximo,  
  @LotedeVenta,  
  @DescripcionAdicional,  
  @CodigoPrecio,  
  @CaracteristicaValor01,  
  @CaracteristicaValor02,  
  @CaracteristicaValor03,  
  @CaracteristicaValor04,  
  @CaracteristicaValor05,  
  @ReferenciaFiscal02,  
  @ReferenciaFiscalIngreso02,  
  @DetraccionCodigo,  
  @Estado,  
  @PeriodicidadCompra,  
  @UltimaFechaModif,  
  @UltimoUsuario,  
  @Centrocosto,  
  @ConceptoGasto,  
  @ClasificadorMovimiento,  
  @FlujodeCajaIngreso,  
  @MapaCodigo,  
  @paisfabricacion,  
  @ABCCodigoIN,  
  @Lectura,  
  @IdGrupoComponente,  
  @IdRegimenVenta,  
  @IndicadorReemplazo,  
  @UsuarioCreacion,  
  GETDATE(),  
  @CuentaVentaComercial,  
  @CuentaDescuentoVentaComercial,  
  @IndicadorCuentaVenta,  
  @TipoRepuesto,  
  @Cantidadkit,  
  @PeriodoInicioReposicion,  
  @PeriodosReposicion,  
  @IndicadorClasificacion,  
  @PeridoInicioReposicion,  
  @IdClasificacion,  
  @cantidadReposicion,  
  @grupoReposicion,  
  @IndicadorReposicion,  
  @IndicadorPrecioManual,  
  @IndicadorConsumoFraccionado,  
  @nombreLaboratorio,  
  @estadoAnterior,  
  @CuentaCompras,  
  @PrecioCostoAnt,  
  @UltimaOC,  
  @PreviaOC,  
  @tipomedicamento,  
  @CodigoDigemid,  
  @EAN13,  
  @MedicamentoCodigo,  
  @MedicamentoCodigoPadre,  
  @NombreTabla,  
  @tipofolder,  
  @ACCION    
  )  
  select 1  
  END  
  ELSE  
  IF @ACCION='UPDATE'  
  BEGIN  
  UPDATE  
  WH_ItemMast  
  SET  
  Item = @Item,  
  ItemTipo = @ItemTipo,  
  Linea = @Linea,  
  Familia = @Familia,  
  SubFamilia = @SubFamilia,  
  SubFamiliaInferior = @SubFamilia,  
  DescripcionLocal = @DescripcionLocal,  
  DescripcionIngles = @DescripcionIngles,  
  DescripcionCompleta = @DescripcionCompleta,  
  NumeroDeParte = @NumeroDeParte,  
  CodigoInterno = @CodigoInterno,  
  UnidadCodigo = @UnidadCodigo,  
  UnidadCompra = @UnidadCompra,  
  UnidadEmbalaje = @UnidadEmbalaje,  
  Color = @Color,  
  Modelo = @Modelo,  
  MarcaCodigo = @MarcaCodigo,  
  ItemProcedencia = @ItemProcedencia,  
  ClasificacionComercial = @ClasificacionComercial,  
  PartidaArancelaria = @PartidaArancelaria,  
  CodigoBarras = @CodigoBarras,  
  CodigoBarrasFabricante = @CodigoBarrasFabricante,  
  CodigoBarras2 = @CodigoBarras2,  
  MonedaCodigo = @MonedaCodigo,  
  PrecioCosto = @PrecioCosto,  
  PrecioUnitarioLocal = @PrecioUnitarioLocal,  
  PrecioUnitarioDolares = @PrecioUnitarioDolares,  
  ItemPrecioFlag = @ItemPrecioFlag,  
  ItemPrecioCodigo = @ItemPrecioCodigo,  
  DisponibleVentaFlag = @DisponibleVentaFlag,  
  ManejoxLoteFlag = @ManejoxLoteFlag,  
  ManejoxSerieFlag = @ManejoxSerieFlag,  
  ManejoxKitFlag = @ManejoxKitFlag,  
  ManejoxKitSplitFlag = @ManejoxKitSplitFlag,  
  ManejoxUnidadFlag = @ManejoxUnidadFlag,  
  AfectoImpuestoVentasFlag = @AfectoImpuestoVentasFlag,  
  AfectoImpuesto2Flag = @AfectoImpuesto2Flag,  
  RequisicionamientoAutomaticoFl = @RequisicionamientoAutomaticoFl,  
  ControlCalidadFlag = @ControlCalidadFlag,  
  DisponibleTransferenciaFlag = @DisponibleTransferenciaFlag,  
  DisponibleConsumoFlag = @DisponibleConsumoFlag,  
  FormularioFlag = @FormularioFlag,  
  FormularioNroJuegos = @FormularioNroJuegos,  
  ISOAplicableFlag = @ISOAplicableFlag,  
  ISONormaInterna = @ISONormaInterna,  
  CantidadDobleFlag = @CantidadDobleFlag,  
  CantidadDobleFactor = @CantidadDobleFactor,  
  UnidadCodigoDoble = @UnidadCodigoDoble,  
  UnidadReplicacion = @UnidadReplicacion,  
  ImageFile = @ImageFile,  
  MapaFile = @MapaFile,  
  CuentaInventario = @CuentaInventario,  
  CuentaGasto = @CuentaGasto,  
  CuentaInversion = @CuentaGasto,  
  CuentaServicioTecnico = @CuentaServicioTecnico,  
  CuentaSalidaTerceros = @CuentaSalidaTerceros,  
  CuentaVentas = @CuentaVentas,  
  CuentaTransito = @CuentaTransito,  
  ElementoGasto = @ElementoGasto,  
  ElementoInversion = @ElementoInversion,  
  PartidaPresupuestal = @PartidaPresupuestal,  
  FlujodeCaja = @FlujodeCaja,  
  LotedeCompra = @LotedeCompra,  
  LotedeDespacho = @LotedeDespacho,  
  LotedeCompraM3 = @LotedeCompraM3,  
  LotedeCompraKG = @LotedeCompraKG,  
  PeriodicidadCompraMeses = @PeriodicidadCompraMeses,  
  EspecificacionTecnica = @EspecificacionTecnica,  
  Dimensiones = @Dimensiones,  
  FactorEquivalenciaComercial = @FactorEquivalenciaComercial,  
  ABCCodigo = @ABCCodigo,  
  InventarioTolerancia = @InventarioTolerancia,  
  StockMinimo = @StockMinimo,  
  StockMaximo = @StockMaximo,  
  LotedeVenta = @LotedeVenta,  
  DescripcionAdicional = @DescripcionAdicional,  
  CodigoPrecio = @CodigoPrecio,  
  CaracteristicaValor01 = @CaracteristicaValor01,  
  CaracteristicaValor02 = @CaracteristicaValor02,  
  CaracteristicaValor03 = @CaracteristicaValor03,  
  CaracteristicaValor04 = @CaracteristicaValor04,  
  CaracteristicaValor05 = @CaracteristicaValor05,  
  ReferenciaFiscal02 = @ReferenciaFiscal02,  
  ReferenciaFiscalIngreso02 = @ReferenciaFiscalIngreso02,  
  DetraccionCodigo = @DetraccionCodigo,  
  Estado = @Estado,  
  PeriodicidadCompra = @PeriodicidadCompra,  
  UltimaFechaModif = @UltimaFechaModif,  
  UltimoUsuario = @UltimoUsuario,  
  Centrocosto = @Centrocosto,  
  ConceptoGasto = @ConceptoGasto,  
  ClasificadorMovimiento = @ClasificadorMovimiento,  
  FlujodeCajaIngreso = @FlujodeCajaIngreso,  
  MapaCodigo = @MapaCodigo,  
  paisfabricacion = @paisfabricacion,  
  ABCCodigoIN = @ABCCodigoIN,  
  Lectura = @Lectura,  
  IdGrupoComponente = @IdGrupoComponente,  
  IdRegimenVenta = @IdRegimenVenta,  
  IndicadorReemplazo = @IndicadorReemplazo,  
  CuentaVentaComercial = @CuentaVentaComercial,  
  CuentaDescuentoVentaComercial = @CuentaDescuentoVentaComercial,  
  IndicadorCuentaVenta = @IndicadorCuentaVenta,  
  TipoRepuesto = @TipoRepuesto,  
  Cantidadkit = @Cantidadkit,  
  PeriodoInicioReposicion = @PeriodoInicioReposicion,  
  PeriodosReposicion = @PeriodosReposicion,  
  IndicadorClasificacion = @IndicadorClasificacion,  
  PeridoInicioReposicion = @PeridoInicioReposicion,  
  IdClasificacion = @IdClasificacion,  
  cantidadReposicion = @cantidadReposicion,  
  grupoReposicion = @grupoReposicion,  
  IndicadorReposicion = @IndicadorReposicion,  
  IndicadorPrecioManual = @IndicadorPrecioManual,  
  IndicadorConsumoFraccionado = @IndicadorConsumoFraccionado,  
  nombreLaboratorio = @nombreLaboratorio,  
  estadoAnterior = @estadoAnterior,  
  CuentaCompras = @CuentaCompras,  
  PrecioCostoAnt = @PrecioCostoAnt,  
  UltimaOC = @UltimaOC,  
  PreviaOC = @PreviaOC,  
  tipomedicamento = @tipomedicamento,  
  CodigoDigemid = @CodigoDigemid,  
  EAN13 = @EAN13,  
  MedicamentoCodigo = @MedicamentoCodigo,  
  MedicamentoCodigoPadre = @MedicamentoCodigoPadre,  
  NombreTabla = @NombreTabla,  
  tipofolder = @tipofolder,  
  Accion = @ACCION   
  WHERE   
  (Item=@Item)   
  select 1     
     END     
  ELSE
  
   IF @ACCION='UPDATE_MINSA'  
  BEGIN  
  UPDATE  
  WH_ItemMast  
  SET     
  IdClasificacion = @IdClasificacion,   
  Accion = @ACCION   
  WHERE   
  (Item=@Item)   
  select 1     
     END     
  ELSE 
  
    
  IF(@ACCION = 'DELETE')  
  BEGIN  
  DELETE WH_ItemMast  
  WHERE   
  (Item = @Item)  
  select 1  
 end  
 else  
 if(@ACCION = 'CONTARLISTARPAG')  
 begin   
  SET @CONTADOR=(SELECT COUNT(Item) FROM WH_ItemMast  
       WHERE   
       (@Item is null  OR @Item =''  OR  upper(Item) like '%'+upper(@Item)+'%')  
	 and (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')
     and (@Linea is null OR Linea = @Linea)  
     and (@Familia is null OR Familia = @Familia)       
     and (@Estado is null OR Estado = @Estado)  
     )  
  select @CONTADOR  
 end  
commit   
   
END 

GO
/****** Object:  StoredProcedure [dbo].[SP_WH_ItemMastListar]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER PROCEDURE [SP_WH_ItemMastListar]  
           @Item varchar(50),  
           @ItemTipo char(2),  
           @Linea char(6),  
           @Familia char(6),  
           @SubFamilia char(6),  
           @SubFamiliaInferior char(6),  
           @DescripcionLocal varchar(max),  
           @DescripcionIngles varchar,  
           @DescripcionCompleta varchar,  
           @NumeroDeParte char(20),             
           @CodigoInterno char(20),  
           @UnidadCodigo char(6),  
           @UnidadCompra char(6),  
           @UnidadEmbalaje char(6),  
           @Color char(3),  
           @Modelo char(20),  
           @MarcaCodigo char(4),  
           @ItemProcedencia varchar(10),  
           @ClasificacionComercial char(6),  
           @PartidaArancelaria char(10),             
           @CodigoBarras varchar(25),  
           @CodigoBarrasFabricante char(13),  
           @CodigoBarras2 char(30),  
           @MonedaCodigo char(2),  
           @PrecioCosto decimal(16,6),  
           @PrecioUnitarioLocal decimal(16,6),  
           @PrecioUnitarioDolares decimal(16,6),  
           @ItemPrecioFlag char(1),  
           @ItemPrecioCodigo char(20),  
           @DisponibleVentaFlag char(1),  
           
           @ManejoxLoteFlag char(1),  
           @ManejoxSerieFlag char(1),  
           @ManejoxKitFlag char(1),  
           @ManejoxKitSplitFlag char(1),  
           @ManejoxUnidadFlag char(1),  
           @AfectoImpuestoVentasFlag char(1),  
           @AfectoImpuesto2Flag char(1),  
           @RequisicionamientoAutomaticoFl char(1),  
           @ControlCalidadFlag char(1),  
           @DisponibleTransferenciaFlag char(1),  
           
           @DisponibleConsumoFlag char(1),  
           @FormularioFlag char(1),  
           @FormularioNroJuegos int,  
           @ISOAplicableFlag char(1),  
           @ISONormaInterna char(15),  
           @CantidadDobleFlag char(1),  
           @CantidadDobleFactor decimal(16,10),  
           @UnidadCodigoDoble char(6),  
           @UnidadReplicacion char(4),  
           @ImageFile char(80),  
           
           @MapaFile char(80),  
           @CuentaInventario char(20),  
           @CuentaGasto char(20),  
           @CuentaInversion char(20),  
           @CuentaServicioTecnico char(20),  
           @CuentaSalidaTerceros char(20),  
           @CuentaVentas char(20),  
           @CuentaTransito char(20),  
           @ElementoGasto char(10),  
           @ElementoInversion char(10),  
           
           @PartidaPresupuestal char(4),  
           @FlujodeCaja char(4),  
           @LotedeCompra int,  
           @LotedeDespacho decimal(16,6),  
           @LotedeCompraM3 decimal(16,6),  
           @LotedeCompraKG decimal(16,6),  
           @PeriodicidadCompraMeses money,  
           @EspecificacionTecnica varchar(255),  
           @Dimensiones char(30),  
           @FactorEquivalenciaComercial decimal(10,4),  
           
           @ABCCodigo char(2),  
           @InventarioTolerancia decimal(10,7),  
           @StockMinimo money,  
           @StockMaximo money,  
           @LotedeVenta int,  
           @DescripcionAdicional text,  
           @CodigoPrecio char(3),  
           @CaracteristicaValor01 char(10),  
           @CaracteristicaValor02 char(10),  
           @CaracteristicaValor03 char(10),  
           
           @CaracteristicaValor04 char(10),  
           @CaracteristicaValor05 char(10),  
           @ReferenciaFiscal02 char(20),  
           @ReferenciaFiscalIngreso02 char(20),  
           @DetraccionCodigo char(4),  
           @Estado char(1),  
           @PeriodicidadCompra char(1),  
           @UltimaFechaModif datetime,  
           @UltimoUsuario varchar(25),  
           @Centrocosto varchar(15),  
           
           @ConceptoGasto varchar(15),  
           @ClasificadorMovimiento varchar(15),  
           @FlujodeCajaIngreso char(4),  
           @MapaCodigo char(10),  
           @paisfabricacion char(4),  
           @ABCCodigoIN char(3),  
           @Lectura varchar(1),  
           @IdGrupoComponente int,  
           @IdRegimenVenta int,  
           @IndicadorReemplazo int,  
           
           @UsuarioCreacion varchar(25),  
           @FechaCreacion datetime,  
           @CuentaVentaComercial varchar(25),  
           @CuentaDescuentoVentaComercial varchar(25),  
           @IndicadorCuentaVenta int,  
           @TipoRepuesto varchar(2),  
           @Cantidadkit int,  
           @PeriodoInicioReposicion int,  
           @PeriodosReposicion int,  
           @IndicadorClasificacion int,  
           
           @PeridoInicioReposicion int,  
           @IdClasificacion int,  
           @cantidadReposicion decimal(16,6),  
           @grupoReposicion char(6),  
           @IndicadorReposicion int,  
           @IndicadorPrecioManual int,  
           @IndicadorConsumoFraccionado int,  
           @nombreLaboratorio varchar(255),  
           @estadoAnterior varchar(1),  
           @CuentaCompras char(20),  
           
           @PrecioCostoAnt decimal(16,6),  
           @UltimaOC varchar(10),  
           @PreviaOC varchar(10),  
           @tipomedicamento varchar(1),  
           @CodigoDigemid varchar(50),  
           @EAN13 varchar(20),  
           @MedicamentoCodigo varchar(50),  
           @MedicamentoCodigoPadre varchar(50),  
           @NombreTabla varchar(100),  
           @tipofolder int,  
   
     @ACCION varchar(25),  
     @INICIO   int= null,    
     @NUMEROFILAS int = null   
  
AS  
BEGIN      
IF(@ACCION = 'LISTARPAG')  
 begin  
   DECLARE @CONTADOR INT  
   
  SET @CONTADOR=(SELECT COUNT(Item) FROM WH_ItemMast  
       WHERE   
       (@Item is null  OR @Item =''  OR  upper(Item) like '%'+upper(@Item)+'%')  
	 and (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')
     and (@Linea is null OR Linea = @Linea)  
     and (@Familia is null OR Familia = @Familia)       
     and (@Estado is null OR Estado = @Estado)  
     )  
  SELECT   
  Item,  
  ItemTipo,  
  Linea,  
  Familia,  
  SubFamilia,  
  SubFamiliaInferior,  
  DescripcionLocal,  
  DescripcionIngles,  
  DescripcionCompleta,  
  NumeroDeParte,  
  CodigoInterno,  
  UnidadCodigo,  
  UnidadCompra,  
  UnidadEmbalaje,  
  Color,  
  Modelo,  
  MarcaCodigo,  
  ItemProcedencia,  
  ClasificacionComercial,  
  PartidaArancelaria,  
  CodigoBarras,  
  CodigoBarrasFabricante,  
  CodigoBarras2,  
  MonedaCodigo,  
  PrecioCosto,  
  PrecioUnitarioLocal,  
  PrecioUnitarioDolares,  
  ItemPrecioFlag,  
  ItemPrecioCodigo,  
  DisponibleVentaFlag,  
  ManejoxLoteFlag,  
  ManejoxSerieFlag,  
  ManejoxKitFlag,  
  ManejoxKitSplitFlag,  
  ManejoxUnidadFlag,  
  AfectoImpuestoVentasFlag,  
  AfectoImpuesto2Flag,  
  RequisicionamientoAutomaticoFl,  
  ControlCalidadFlag,  
  DisponibleTransferenciaFlag,  
  DisponibleConsumoFlag,  
  FormularioFlag,  
  FormularioNroJuegos,  
  ISOAplicableFlag,  
  ISONormaInterna,  
  CantidadDobleFlag,  
  CantidadDobleFactor,  
  UnidadCodigoDoble,  
  UnidadReplicacion,  
  ImageFile,  
  MapaFile,  
  CuentaInventario,  
  CuentaGasto,  
  CuentaInversion,  
  CuentaServicioTecnico,  
  CuentaSalidaTerceros,  
  CuentaVentas,  
  CuentaTransito,  
  ElementoGasto,  
  ElementoInversion,  
  PartidaPresupuestal,  
  FlujodeCaja,  
  LotedeCompra,  
  LotedeDespacho,  
  LotedeCompraM3,  
  LotedeCompraKG,  
  PeriodicidadCompraMeses,  
  EspecificacionTecnica,  
  Dimensiones,  
  FactorEquivalenciaComercial,  
  ABCCodigo,  
  InventarioTolerancia,  
  StockMinimo,  
  StockMaximo,  
  LotedeVenta,  
  DescripcionAdicional,  
  CodigoPrecio,  
  CaracteristicaValor01,  
  CaracteristicaValor02,  
  CaracteristicaValor03,  
  CaracteristicaValor04,  
  CaracteristicaValor05,  
  ReferenciaFiscal02,  
  ReferenciaFiscalIngreso02,  
  DetraccionCodigo,  
  Estado,  
  PeriodicidadCompra,  
  UltimaFechaModif,  
  UltimoUsuario,  
  Centrocosto,  
  ConceptoGasto,  
  ClasificadorMovimiento,  
  FlujodeCajaIngreso,  
  MapaCodigo,  
  paisfabricacion,  
  ABCCodigoIN,  
  Lectura,  
  IdGrupoComponente,  
  IdRegimenVenta,  
  IndicadorReemplazo,  
  UsuarioCreacion,  
  FechaCreacion,  
  CuentaVentaComercial,  
  CuentaDescuentoVentaComercial,  
  IndicadorCuentaVenta,  
  TipoRepuesto,  
  Cantidadkit,  
  PeriodoInicioReposicion,  
  PeriodosReposicion,  
  IndicadorClasificacion,  
  PeridoInicioReposicion,  
  IdClasificacion,  
  cantidadReposicion,  
  grupoReposicion,  
  IndicadorReposicion,  
  IndicadorPrecioManual,  
  IndicadorConsumoFraccionado,  
  nombreLaboratorio,  
  estadoAnterior,  
  CuentaCompras,  
  PrecioCostoAnt,  
  UltimaOC,  
  PreviaOC,  
  tipomedicamento,  
  CodigoDigemid,  
  EAN13,  
  MedicamentoCodigo,  
  MedicamentoCodigoPadre,  
  NombreTabla,  
  tipofolder,  
  Accion   
  FROM( SELECT  
    Item,  
    ItemTipo,  
    Linea,  
    Familia,  
    SubFamilia,  
    SubFamiliaInferior,  
    DescripcionLocal,  
    DescripcionIngles,  
    DescripcionCompleta,  
    NumeroDeParte,  
    CodigoInterno,  
    UnidadCodigo,  
    UnidadCompra,  
    UnidadEmbalaje,  
    Color,  
    Modelo,  
    MarcaCodigo,  
    ItemProcedencia,  
    ClasificacionComercial,  
    PartidaArancelaria,  
    CodigoBarras,  
    CodigoBarrasFabricante,  
    CodigoBarras2,  
    MonedaCodigo,  
    PrecioCosto,  
    PrecioUnitarioLocal,  
    PrecioUnitarioDolares,  
    ItemPrecioFlag,  
    ItemPrecioCodigo,  
    DisponibleVentaFlag,  
    ManejoxLoteFlag,  
    ManejoxSerieFlag,  
    ManejoxKitFlag,  
    ManejoxKitSplitFlag,  
    ManejoxUnidadFlag,  
    AfectoImpuestoVentasFlag,  
    AfectoImpuesto2Flag,  
    RequisicionamientoAutomaticoFl,  
    ControlCalidadFlag,  
    DisponibleTransferenciaFlag,  
    DisponibleConsumoFlag,  
    FormularioFlag,  
    FormularioNroJuegos,  
    ISOAplicableFlag,  
    ISONormaInterna,  
    CantidadDobleFlag,  
    CantidadDobleFactor,  
    UnidadCodigoDoble,  
    UnidadReplicacion,  
    ImageFile,  
    MapaFile,  
    CuentaInventario,  
    CuentaGasto,  
    CuentaInversion,  
    CuentaServicioTecnico,  
    CuentaSalidaTerceros,  
    CuentaVentas,  
    CuentaTransito,  
    ElementoGasto,  
    ElementoInversion,  
    PartidaPresupuestal,  
    FlujodeCaja,  
    LotedeCompra,  
    LotedeDespacho,  
    LotedeCompraM3,  
    LotedeCompraKG,  
    PeriodicidadCompraMeses,  
    EspecificacionTecnica,  
    Dimensiones,  
    FactorEquivalenciaComercial,  
    ABCCodigo,  
    InventarioTolerancia,  
    StockMinimo,  
    StockMaximo,  
    LotedeVenta,  
    DescripcionAdicional,  
    CodigoPrecio,  
    CaracteristicaValor01,  
    CaracteristicaValor02,  
    CaracteristicaValor03,  
    CaracteristicaValor04,  
    CaracteristicaValor05,  
    ReferenciaFiscal02,  
    ReferenciaFiscalIngreso02,  
    DetraccionCodigo,  
    Estado,  
    PeriodicidadCompra,  
    UltimaFechaModif,  
    UltimoUsuario,  
    Centrocosto,  
    ConceptoGasto,  
    ClasificadorMovimiento,  
    FlujodeCajaIngreso,  
    MapaCodigo,  
    paisfabricacion,  
    ABCCodigoIN,  
    Lectura,  
    IdGrupoComponente,  
    IdRegimenVenta,  
    IndicadorReemplazo,  
    UsuarioCreacion,  
    FechaCreacion,  
    CuentaVentaComercial,  
    CuentaDescuentoVentaComercial,  
    IndicadorCuentaVenta,  
    TipoRepuesto,  
    Cantidadkit,  
    PeriodoInicioReposicion,  
    PeriodosReposicion,  
    IndicadorClasificacion,  
    PeridoInicioReposicion,  
    IdClasificacion,  
    cantidadReposicion,  
    grupoReposicion,  
    IndicadorReposicion,  
    IndicadorPrecioManual,  
    IndicadorConsumoFraccionado,  
    nombreLaboratorio,  
    estadoAnterior,  
    CuentaCompras,  
    PrecioCostoAnt,  
    UltimaOC,  
    PreviaOC,  
    tipomedicamento,  
    CodigoDigemid,  
    EAN13,  
    MedicamentoCodigo,  
    MedicamentoCodigoPadre,  
    NombreTabla,  
    tipofolder,  
    Accion   
     ,@CONTADOR AS Contador  
     ,ROW_NUMBER() OVER (ORDER BY Item ASC ) AS RowNumber     
     FROM WH_ItemMast  
 WHERE   
       (@Item is null  OR @Item =''  OR  upper(Item) like '%'+upper(@Item)+'%')  
	 and (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')
     and (@Linea is null OR Linea = @Linea)  
     and (@Familia is null OR Familia = @Familia)       
     and (@Estado is null OR Estado = @Estado)  
     )  
     AS LISTADO  
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR    
            RowNumber BETWEEN @Inicio  AND @NumeroFilas   
              
       END  
ELSE  
 IF(@ACCION = 'LISTARTOTAL')  
 begin  
   DECLARE @CONTADORES INT  
   
  SET @CONTADORES=(SELECT COUNT(vw_Imprimir_HC_GRILLAMEDICAMENTO.Item) FROM vw_Imprimir_HC_GRILLAMEDICAMENTO  
       WHERE   
       (@Item is null  OR @Item =''  OR  upper(vw_Imprimir_HC_GRILLAMEDICAMENTO.Item) like '%'+upper(@Item)+'%')  
	 and (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(vw_Imprimir_HC_GRILLAMEDICAMENTO.DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')
     and (@Linea is null OR vw_Imprimir_HC_GRILLAMEDICAMENTO.Linea = @Linea)  
     and (@Familia is null OR vw_Imprimir_HC_GRILLAMEDICAMENTO.Familia = @Familia)       
     and (@Estado is null OR vw_Imprimir_HC_GRILLAMEDICAMENTO.Estado = @Estado)  
     )  
  SELECT   *
  
  FROM( SELECT  
   *
     ,@CONTADOR AS Contador  
     ,ROW_NUMBER() OVER (ORDER BY Item ASC ) AS RowNumber     
      from vw_Imprimir_HC_GRILLAMEDICAMENTO 
 WHERE   
       (@Item is null  OR @Item =''  OR  upper(vw_Imprimir_HC_GRILLAMEDICAMENTO.Item) like '%'+upper(@Item)+'%')  
	 and (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(vw_Imprimir_HC_GRILLAMEDICAMENTO.DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')
     and (@Linea is null OR vw_Imprimir_HC_GRILLAMEDICAMENTO.Linea = @Linea)  
     and (@Familia is null OR vw_Imprimir_HC_GRILLAMEDICAMENTO.Familia = @Familia)       
     and (@Estado is null OR vw_Imprimir_HC_GRILLAMEDICAMENTO.Estado = @Estado)  
     )  
     AS LISTADO  
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR    
            RowNumber BETWEEN @Inicio  AND @NumeroFilas   
              
       END  
ELSE  
 
 
 IF @ACCION ='LISTAR'      
    BEGIN      
  SELECT  
    Item,  
    ItemTipo,  
    Linea,  
    Familia,  
    SubFamilia,  
    SubFamiliaInferior,  
    DescripcionLocal,  
    DescripcionIngles,  
    DescripcionCompleta,  
    NumeroDeParte,  
    CodigoInterno,  
    UnidadCodigo,  
    UnidadCompra,  
    UnidadEmbalaje,  
    Color,  
    Modelo,  
    MarcaCodigo,  
    ItemProcedencia,  
    ClasificacionComercial,  
    PartidaArancelaria,  
    CodigoBarras,  
    CodigoBarrasFabricante,  
    CodigoBarras2,  
    MonedaCodigo,  
    PrecioCosto,  
    PrecioUnitarioLocal,  
    PrecioUnitarioDolares,  
    ItemPrecioFlag,  
    ItemPrecioCodigo,  
    DisponibleVentaFlag,  
    ManejoxLoteFlag,  
    ManejoxSerieFlag,  
    ManejoxKitFlag,  
    ManejoxKitSplitFlag,  
    ManejoxUnidadFlag,  
    AfectoImpuestoVentasFlag,  
    AfectoImpuesto2Flag,  
    RequisicionamientoAutomaticoFl,  
    ControlCalidadFlag,  
    DisponibleTransferenciaFlag,  
    DisponibleConsumoFlag,  
    FormularioFlag,  
    FormularioNroJuegos,  
    ISOAplicableFlag,  
    ISONormaInterna,  
    CantidadDobleFlag,  
    CantidadDobleFactor,  
    UnidadCodigoDoble,  
    UnidadReplicacion,  
    ImageFile,  
    MapaFile,  
    CuentaInventario,  
    CuentaGasto,  
    CuentaInversion,  
    CuentaServicioTecnico,  
    CuentaSalidaTerceros,  
    CuentaVentas,  
    CuentaTransito,  
    ElementoGasto,  
    ElementoInversion,  
    PartidaPresupuestal,  
    FlujodeCaja,  
    LotedeCompra,  
    LotedeDespacho,  
    LotedeCompraM3,  
    LotedeCompraKG,  
    PeriodicidadCompraMeses,  
    EspecificacionTecnica,  
    Dimensiones,  
    FactorEquivalenciaComercial,  
    ABCCodigo,  
    InventarioTolerancia,  
    StockMinimo,  
    StockMaximo,  
    LotedeVenta,  
    DescripcionAdicional,  
    CodigoPrecio,  
    CaracteristicaValor01,  
    CaracteristicaValor02,  
    CaracteristicaValor03,  
    CaracteristicaValor04,  
    CaracteristicaValor05,  
    ReferenciaFiscal02,  
    ReferenciaFiscalIngreso02,  
    DetraccionCodigo,  
    Estado,  
    PeriodicidadCompra,  
    UltimaFechaModif,  
    UltimoUsuario,  
    Centrocosto,  
    ConceptoGasto,  
    ClasificadorMovimiento,  
    FlujodeCajaIngreso,  
    MapaCodigo,  
    paisfabricacion,  
    ABCCodigoIN,  
    Lectura,  
    IdGrupoComponente,  
    IdRegimenVenta,  
    IndicadorReemplazo,  
    UsuarioCreacion,  
    FechaCreacion,  
    CuentaVentaComercial,  
    CuentaDescuentoVentaComercial,  
    IndicadorCuentaVenta,  
    TipoRepuesto,  
    Cantidadkit,  
    PeriodoInicioReposicion,  
    PeriodosReposicion,  
    IndicadorClasificacion,  
    PeridoInicioReposicion,  
    IdClasificacion,  
    cantidadReposicion,  
    grupoReposicion,  
    IndicadorReposicion,  
    IndicadorPrecioManual,  
    IndicadorConsumoFraccionado,  
    nombreLaboratorio,  
    estadoAnterior,  
    CuentaCompras,  
    PrecioCostoAnt,  
    UltimaOC,  
    PreviaOC,  
    tipomedicamento,  
    CodigoDigemid,  
    EAN13,  
    MedicamentoCodigo,  
    MedicamentoCodigoPadre,  
    NombreTabla,  
    tipofolder,  
    Accion   
    FROM WH_ItemMast  
 WHERE   
       (@Item is null  OR @Item =''  OR  upper(Item) like '%'+upper(@Item)+'%')  
	 and (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')
     and (@Linea is null OR Linea = @Linea)  
     and (@Familia is null OR Familia = @Familia)       
     and (@Estado is null OR Estado = @Estado)  
 END   
 ELSE  
 IF(@ACCION = 'LISTARPORID')  
 BEGIN  
 SELECT * FROM WH_ItemMast WHERE (Item = @Item)  
 END  
 

 END
 
 /*133
 exec SP_WH_ItemMastListar
 null,null,null,null,null,'vasos',null,null,null,null,
 null,null,null,null,null,null,null,null,null,null,
 null,null,null,null,null,null,null,null,null,null,
 null,null,null,null,null,null,null,null,null,null,	
 null,null,null,null,null,null,null,null,null,null,	
 null,null,null,null,null,null,null,null,null,null,	
 null,null,null,null,null,null,null,null,null,null,	
 null,null,null,null,null,null,null,null,null,null,	
 null,null,null,null,null,null,null,null,null,null,
 null,null,null,null,null,null,null,null,null,null,
 null,null,null,null,null,null,null,null,null,null,
 null,null,null,null,null,null,null,null,null,null,
 null,null,null,null,null,null,null,null,null,null,
 'LISTARPAG',0,200
 */

GO
/****** Object:  StoredProcedure [dbo].[SPAnamnesisEAReportes]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[SPAnamnesisEAReportes]  
 @Accion varchar(30)=null  
AS  
BEGIN  
	IF @Accion ='REPORTEA'  
	  BEGIN  
		Select * From   rptViewAnamnesisEA   
	 
	  END  
END
GO

/****** Object:  StoredProcedure [dbo].[SS_HC_NOMBRE_PERDIDO]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SS_HC_NOMBRE_PERDIDO]
@IdTablaMaestro			int,
@IdConcepto				int,
@Concepto				varchar(15),
@Nombre					varchar(80),
@Descripcion			varchar(150),
@TipoConcepto			int,
@TipoDato				varchar,
@Campo					varchar(80),
@Estado					int,
@UsuarioCreacion		varchar(25),
@FechaCreacion			datetime,
@UsuarioModificacion	varchar(25),
@FechaModificacion		datetime,
@Accion					varchar
AS    
BEGIN    
IF(@ACCION = 'LISTARPERFILES')
	SELECT
		IdTablaMaestro,
		IdConcepto,
		Concepto,
		Nombre,
		Descripcion,
		TipoConcepto,
		TipoDato,
		Campo,
		Estado,
		UsuarioCreacion,
		FechaCreacion,
		UsuarioModificacion,
		FechaModificacion,
		Accion
	FROM
		CM_CO_TablaMaestroConcepto
		WHERE 
			(@IdTablaMaestro is null OR IdTablaMaestro = @IdTablaMaestro)	
		AND	(@IdConcepto is null OR IdConcepto = @IdConcepto)	
END
		
GO


/****** Object:  StoredProcedure [dbo].[SP_V_EpisodioAtenciones_LISTAR]    Script Date: 17/04/2025 18:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_V_EpisodioAtenciones_LISTAR]
(
	@Persona	int
	,@NombreCompleto	varchar(100)	
	,@UnidadReplicacion		char(4)
	,@IdEpisodioAtencion		bigint
	,@UnidadReplicacionEC		char(4)	
	,@IdPaciente		int
	,@EpisodioClinico		int
	,@IdEstablecimientoSalud		int
	,@IdUnidadServicio		int
	,@IdPersonalSalud		int		
	,@EpisodioAtencion		bigint
	,@TipoAtencion		int
	,@IdOrdenAtencion	int
	,@TipoOrdenAtencion		int	
	,@Estado_EpisodioAten	int	
	,@FechaRegistroDesde		datetime
	,@FechaRegistroHasta		datetime
	,@FechaAtencion		datetime
	,@FechaCierre		datetime	
	,@UsuarioModificacion		varchar(25)--AUX  ACCION FORM
	--AGREGADOS
	,@CodigoEpisodioClinico		integer
	,@IdEpisodioAtencionCodigo		varchar(100)
	,@CODIGOOA		varchar(25)
	,@TipoTrabajador		varchar(25)	
	,@IdOpcion		integer	
	,@IdFormato		integer
	,@Id001		integer
	,@Id002		integer
	,@Codigo001		varchar(100)
	,@Codigo002		varchar(100)	
	,@Descripcion001	varchar(200)                                      			
	,@INICIO		int= null,  
	@NUMEROFILAS		int = null ,
	@Version		VARCHAR(25)	,--AUX CODIGO OA
	@ACCION		VARCHAR(25)
)

AS
BEGIN
	
	DECLARE @CONTADOR INT
	DECLARE @COD_FORMATO_AUX varchar(30)

	if(@ACCION = 'LISTARPAG')
	begin		
		set @CODIGOOA = @Version
		if(@UsuarioModificacion is not null)
		begin
			select @COD_FORMATO_AUX = SS_HC_Formato.CodigoFormato from SG_Opcion
			left join SS_HC_Formato on (SS_HC_Formato.IdFormato = SG_Opcion.IdFormato)
			where SG_Opcion.IdOpcion = convert(int ,@UsuarioModificacion)
		end
		declare @CONTADOR_DIN int =0			
			select @CONTADOR_DIN= count(*)
				from SS_HC_EpisodioAtencionFormato EpiAtencionFormato											
				where 
				EpiAtencionFormato.UnidadReplicacion= @UnidadReplicacion
						and  EpiAtencionFormato.EpisodioClinico= @EpisodioClinico
							and EpiAtencionFormato.IdEpisodioAtencion= @IdEpisodioAtencion
							and  EpiAtencionFormato.IdPaciente= @IdPaciente	
		SELECT @CONTADOR= COUNT(*) 					
					FROM dbo.V_EpisodioAtenciones
						left join SS_HC_EpisodioAtencion epiAtencion
						on (epiAtencion.EpisodioClinico = V_EpisodioAtenciones.EpisodioClinico
							and epiAtencion.IdEpisodioAtencion = V_EpisodioAtenciones.IdEpisodioAtencion
							and epiAtencion.UnidadReplicacion = V_EpisodioAtenciones.UnidadReplicacion
							and epiAtencion.IdPaciente = V_EpisodioAtenciones.IdPaciente
							and epiAtencion.IdOrdenAtencion = V_EpisodioAtenciones.IdOrdenAtencion
						)											
					WHERE 
					(@Persona is null or (@Persona =0 ) OR Persona = @Persona)
					and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones.IdPaciente = @IdPaciente)
					and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
					and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
					and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones.IdOrdenAtencion = @IdOrdenAtencion)
					and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones.Accion = @COD_FORMATO_AUX)
					and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
					AND ((@FechaRegistroDesde is null or  V_EpisodioAtenciones.FechaCreacion >= @FechaRegistroDesde)    
	                and (@FechaRegistroHasta is null or  V_EpisodioAtenciones.FechaCreacion < DATEADD(DAY,1,@FechaRegistroHasta)))
	 	 
 
		SELECT 
				convert(int,RowNumber) as [Persona]  --OBS: persona == idPaciente
			  ,[ApellidoPaterno]
			  ,[ApellidoMaterno]
			  ,[Nombres]
			  ,[NombreCompleto]
			  ,[UnidadReplicacion]
			  ,[IdPaciente]
			  ,[FechaCierre]
			  ,[Episodio_Atencion]
			  ,[FechaReg_EpisoAtencon]
			  ,[FechaAtencion]
			  ,[TipoAtencion]
			  ,[IdOrdenAtencion]
			  ,[LineaOrdenAtencion]
			  ,[TipoOrdenAtencion]
			  ,[Estado_EpisodioAten]
			  ,[UsuarioCreacion]
			  ,[FechaCreacion]
			  ,CodigoOAX as UsuarioModificacion ---AUX cod OA
			  ,[FechaModificacion]
			  ,RIGHT('0000'+CAST(Episodio_Atencion AS VARCHAR(4)),4) +
				'.'+RIGHT('0000'+CAST(IdEpisodioAtencion AS VARCHAR(4)),4) +
				' - ' + ISNULL(MotivoConsulta,'Episodio')  as MotivoConsulta
			  ,[FechaRegistro]
			  ,[Accion]
			  ,[EpisodioClinico]
			  ,[IdEpisodioAtencion]
			  ,[UnidadReplicacionEC]
			  ,[IdEstablecimientoSalud]
			  ,[IdUnidadServicio]
			  ,[IdPersonalSalud]
			  ,NombreMedicoUserX as PersonalSaludNombre
			  ,[IdEspecialidad]
			  ,[especialidadNombre]			  
                      ---AGREGADOS ---                      
				  ,[CodigoEpisodioClinico]
				  ,[IdEpisodioAtencionCodigo]
				  ,[CodigoOA]
				  ,[TipoTrabajador]
				  ,[TipoTrabajador_Desc]
				  ,[Id001]
				  ,[Id002]
				  ,[Codigo001]
				  ,[Codigo002]
				  ,[Codigo003]
				  ,[Codigo004]
				  ,[Descripcion001]
				  ,[Descripcion002]
				  ,[Descripcion003]
				  ,[Descripcion004]
				  ,[Documento_Paciente]
				  ,[Documento_Medico]
				  ,[Formato_Codigo]
				  ,[Formato_Id]
				  ,[Formato_Tipo]
				  ,[Formato_Uso]
				  ,[Formato_Descripcion]
				  ,(@CONTADOR + @CONTADOR_DIN) as contador_filas
		FROM (	 
				SELECT V_EpisodioAtenciones_MAIN.*,	
					--V_EpisodioAtenciones_MAIN.CodigoOAX ,
					medicoUser.NombreCompleto AS NombreMedicoUserX ,
					@CONTADOR AS Contador,
					ROW_NUMBER() OVER (ORDER BY /*V_EpisodioAtenciones_MAIN.CodigoOA DESC,*/V_EpisodioAtenciones_MAIN.IdEpisodioAtencion asc ) AS RowNumber    						
					FROM 
					(
						select V_EpisodioAtenciones.*, 
						epiAtencion.CodigoOA AS CodigoOAX 
						 from 
						dbo.V_EpisodioAtenciones
						left join SS_HC_EpisodioAtencion epiAtencion
						on (epiAtencion.EpisodioClinico = V_EpisodioAtenciones.EpisodioClinico
							and epiAtencion.IdEpisodioAtencion = V_EpisodioAtenciones.IdEpisodioAtencion
							and epiAtencion.UnidadReplicacion = V_EpisodioAtenciones.UnidadReplicacion
							and epiAtencion.IdPaciente = V_EpisodioAtenciones.IdPaciente
							and epiAtencion.IdOrdenAtencion = V_EpisodioAtenciones.IdOrdenAtencion
						)				
						WHERE 
						(@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones.Persona = @Persona)
						and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones.IdPaciente = @IdPaciente)
						and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(V_EpisodioAtenciones.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
						and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
						and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones.IdOrdenAtencion = @IdOrdenAtencion)
						and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones.Accion = @COD_FORMATO_AUX)					
						and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
						AND ((@FechaRegistroDesde is null or  V_EpisodioAtenciones.FechaCreacion >= @FechaRegistroDesde)    
	                    and (@FechaRegistroHasta is null or  V_EpisodioAtenciones.FechaCreacion < DATEADD(DAY,1,@FechaRegistroHasta))
	                    
	                    )

						UNION
						select 
							EpiAtencionFormato.IdPaciente as Persona,paciente.ApellidoPaterno as ApellidoPaterno,paciente.ApellidoMaterno as ApellidoMaterno,null as Nombres,paciente.NombreCompleto as NombreCompleto,
							EpiAtencionFormato.UnidadReplicacion,IdPaciente,null as FechaCierre,0 as Episodio_Atencion,null as FechaReg_EpisoAtencon,
							null as FechaAtencion,0 as TipoAtencion,0 as IdOrdenAtencion,0 as LineaOrdenAtencion, 0 as TipoOrdenAtencion,
							EpiAtencionFormato.Estado as Estado_EpisodioAten,EpiAtencionFormato.UsuarioCreacion,EpiAtencionFormato.FechaCreacion,EpiAtencionFormato.UsuarioModificacion,EpiAtencionFormato.FechaModificacion,
							ConceptoFormulario as MotivoConsulta,null as FechaRegistro,convert(varchar,IdTransacciones) as Accion,EpisodioClinico as EpisodioClinico,IdEpisodioAtencion as IdEpisodioAtencion,
							'CEG' as UnidadReplicacionEC,IdOpcion as IdEstablecimientoSalud,IdForm as IdUnidadServicio,0 as IdPersonalSalud,null as PersonalSaludNombre,  --AUX OPCION Y FORM
							0 as IdEspecialidad,null as especialidadNombre,	
                      ---AGREGADOS ---                      
                      '000' as CodigoEpisodioClinico
                      ,'000' as  IdEpisodioAtencionCodigo
                      ,null as  CodigoOA
                      ,'000' as  TipoTrabajador
                      ,'000' as TipoTrabajador_Desc
                      ,0 as Id001
                      ,0 as Id002
                      ,'000' as Codigo001
                      ,'000' as Codigo002
                      ,'000' as Codigo003
                      ,'000' as Codigo004
                      ,'000' as Descripcion001
                      ,'000' as Descripcion002
                      ,'000' as Descripcion003
                      ,'000' as Descripcion004
                      ,'000' as  Documento_Paciente
                      ,'000' as  Documento_Medico
                      --INFO FORMATO
                      ,'000' as Formato_Codigo
                      ,0 as Formato_Id
                      ,0 as Formato_Tipo
                      ,0 as Formato_Uso
                      ,'000' as Formato_Descripcion       
                      ,0 as contador_filas  ,
                      												
							null as  CodigoOAX
						 from SS_HC_EpisodioAtencionFormato EpiAtencionFormato				
							left join PERSONAMAST paciente on (paciente.Persona = EpiAtencionFormato.IdPaciente)
						 where 
							EpiAtencionFormato.UnidadReplicacion= @UnidadReplicacion
							and  EpiAtencionFormato.EpisodioClinico= @EpisodioClinico
							and EpiAtencionFormato.IdEpisodioAtencion= @IdEpisodioAtencion
							and  EpiAtencionFormato.IdPaciente= @IdPaciente	

														
					)as V_EpisodioAtenciones_MAIN
						left join SG_Agente agente 
						on (agente.CodigoAgente = V_EpisodioAtenciones_MAIN.UsuarioCreacion)
						left join PERSONAMAST medicoUser 
						on (medicoUser.persona = agente.IdEmpleado)						
					--					
					) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
					order by /*CodigoOA DESC,*/ FechaCreacion /*DESC */    

							   				       
	end
	else 
	if(@ACCION='LISTARPAGTRIAJE')
		begin		
		DECLARE @TRIAJEEMER VARCHAR(12)
			DECLARE @TRIAJEALER VARCHAR(12)
			SET @TRIAJEEMER='CCEPF630'
			SET @TRIAJEALER='CCEPF631'
		set @CODIGOOA = @Version
		if(@UsuarioModificacion is not null)
		begin
			select @COD_FORMATO_AUX = SS_HC_Formato.CodigoFormato from SG_Opcion
			left join SS_HC_Formato on (SS_HC_Formato.IdFormato = SG_Opcion.IdFormato)
			where SG_Opcion.IdOpcion = convert(int ,@UsuarioModificacion)
		end
declare @CONTADOR_DINT int =0			
			select @CONTADOR_DINT= count(*)
				from SS_HC_EpisodioAtencionFormato EpiAtencionFormato											
				where 
				EpiAtencionFormato.UnidadReplicacion= @UnidadReplicacion
						and  EpiAtencionFormato.EpisodioClinico= @EpisodioClinico
							--and EpiAtencionFormato.IdEpisodioAtencion= @IdEpisodioAtencion
							and  EpiAtencionFormato.IdPaciente= @IdPaciente	
		SELECT @CONTADOR= COUNT(*) 					
					FROM dbo.V_EpisodioAtenciones
						left join SS_HC_EpisodioTriaje epiAtencion
						on (epiAtencion.IdEpisodioTriaje = V_EpisodioAtenciones.EpisodioClinico			
							and epiAtencion.UnidadReplicacion = V_EpisodioAtenciones.UnidadReplicacion
							and epiAtencion.IdPaciente = V_EpisodioAtenciones.IdPaciente
					
						)											
					WHERE 
					(@Persona is null or (@Persona =0 ) OR Persona = @Persona)
					and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones.IdPaciente = @IdPaciente)
					and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
					and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
					--and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones.IdOrdenAtencion = @IdOrdenAtencion)
					and (V_EpisodioAtenciones.Accion IN (case when @UsuarioModificacion='0' then @TRIAJEEMER else @COD_FORMATO_AUX end ,case when @UsuarioModificacion='0' then @TRIAJEALER else '' end))
					--and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones.Accion = @COD_FORMATO_AUX)
					and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOT) like '%'+upper(@CODIGOOA)+'%')
					AND ((@FechaRegistroDesde is null or  V_EpisodioAtenciones.FechaCreacion >= @FechaRegistroDesde)    
	                and (@FechaRegistroHasta is null or  V_EpisodioAtenciones.FechaCreacion < DATEADD(DAY,1,@FechaRegistroHasta)))
	 
 
		SELECT 
				convert(int,RowNumber) as [Persona]  --OBS: persona == idPaciente
			  ,[ApellidoPaterno]
			  ,[ApellidoMaterno]
			  ,[Nombres]
			  ,[NombreCompleto]
			  ,[UnidadReplicacion]
			  ,[IdPaciente]
			  ,[FechaCierre]
			  ,[Episodio_Atencion]
			  ,[FechaReg_EpisoAtencon]
			  ,[FechaAtencion]
			  ,(case when IdEstablecimientoSalud=null then 0 else IdEstablecimientoSalud end)as TipoAtencion--[TipoAtencion]
			  ,[IdOrdenAtencion]
			  ,(case when IdEstablecimientoSalud=null then 0 else IdEstablecimientoSalud end)as LineaOrdenAtencion --[LineaOrdenAtencion]
			  ,(case when IdEstablecimientoSalud=null then 0 else IdEstablecimientoSalud end) as TipoOrdenAtencion --[TipoOrdenAtencion]
			  ,[Estado_EpisodioAten]
			  ,[UsuarioCreacion]
			  ,[FechaCreacion]
			  ,CodigoOAX as UsuarioModificacion ---AUX cod OA
			  ,[FechaModificacion]
			  ,RIGHT('0000'+CAST(Episodio_Atencion AS VARCHAR(4)),4) +
				'.'+RIGHT('0000'+CAST(IdEpisodioAtencion AS VARCHAR(4)),4) +
				' - ' + ISNULL(MotivoConsulta,'Episodio')  as MotivoConsulta
			  --,[MotivoConsulta]
			  ,[FechaRegistro]
			  ,[Accion]
			  ,[EpisodioClinico]
			  ,IdEpisodioAtencion
			  ,[UnidadReplicacionEC]
			  ,[IdEstablecimientoSalud]
			  ,[IdUnidadServicio]
			  ,[IdPersonalSalud]
			  ,PersonalSaludNombre
			  ,(case when IdEstablecimientoSalud=null then 0 else IdEstablecimientoSalud end)as IdEspecialidad --IdEspecialidad
			  ,[especialidadNombre]			  
                      ---AGREGADOS ---                      
				  ,[CodigoEpisodioClinico]
				  ,CodigoOA as IdEpisodioAtencionCodigo
				  ,[CodigoOA]
				  ,[TipoTrabajador]
				  ,[TipoTrabajador_Desc]
				  ,[Id001]
				  ,[Id002]
				  ,[Codigo001]
				  ,[Codigo002]
				  ,[Codigo003]
				  ,[Codigo004]
				  ,[Descripcion001]
				  ,[Descripcion002]
				  ,[Descripcion003]
				  ,[Descripcion004]
				  ,[Documento_Paciente]
				  ,[Documento_Medico]
				  ,[Formato_Codigo]
				  ,[Formato_Id]
				  ,[Formato_Tipo]
				  ,[Formato_Uso]
				  ,[Formato_Descripcion]
				  ,(@CONTADOR + @CONTADOR_DINT) as contador_filas
		FROM (	 
				SELECT V_EpisodioAtenciones_MAIN.*,	
					--V_EpisodioAtenciones_MAIN.CodigoOAX ,
					medicoUser.NombreCompleto AS NombreMedicoUserX ,
					@CONTADOR AS Contador,
					ROW_NUMBER() OVER (ORDER BY /*V_EpisodioAtenciones_MAIN.CodigoOA DESC,*/V_EpisodioAtenciones_MAIN.IdEpisodioAtencion asc ) AS RowNumber    						
					FROM 
					(
						select V_EpisodioAtenciones.*, 
						epiAtencion.CodigoOT AS CodigoOAX 
						 from 
						dbo.V_EpisodioAtenciones
						left join SS_HC_EpisodioTriaje epiAtencion
						on (
						epiAtencion.CodigoOT = V_EpisodioAtenciones.CodigoOA and
							
							 epiAtencion.UnidadReplicacion = V_EpisodioAtenciones.UnidadReplicacion
							and epiAtencion.IdPaciente = V_EpisodioAtenciones.IdPaciente
							
						)				
						WHERE 
						(@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones.Persona = @Persona)
						and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones.IdPaciente = @IdPaciente)
						and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(V_EpisodioAtenciones.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
						and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
						and (V_EpisodioAtenciones.Accion IN (case when @UsuarioModificacion='0' then @TRIAJEEMER else @COD_FORMATO_AUX end ,case when @UsuarioModificacion='0' then @TRIAJEALER else '' end))				
						and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOT) like '%'+upper(@CODIGOOA)+'%')
						AND ((@FechaRegistroDesde is null or  V_EpisodioAtenciones.FechaCreacion >= @FechaRegistroDesde)    
	                    and (@FechaRegistroHasta is null or  V_EpisodioAtenciones.FechaCreacion < DATEADD(DAY,1,@FechaRegistroHasta))									
	                    )																		
					)as V_EpisodioAtenciones_MAIN
						left join SG_Agente agente 
						on (agente.CodigoAgente = V_EpisodioAtenciones_MAIN.UsuarioCreacion)
						left join PERSONAMAST medicoUser 
						on (medicoUser.persona = agente.IdEmpleado)						
					--					
					) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
					order by /*CodigoOA DESC,*/ FechaCreacion /*DESC */    
							   				       
	end
	else
		if(@ACCION = 'LISTARPAGOBLIGATORIO')
	begin		
		set @CODIGOOA = @Version
		if(@UsuarioModificacion is not null)
		begin
			select @COD_FORMATO_AUX = SS_HC_Formato.CodigoFormato from SG_Opcion
			left join SS_HC_Formato on (SS_HC_Formato.IdFormato = SG_Opcion.IdFormato)
			where SG_Opcion.IdOpcion = convert(int ,@UsuarioModificacion)
		end
	
	--	declare @CONTADOR_DIN int =0			
			select @CONTADOR_DIN= count(*)
				from SS_HC_EpisodioAtencionFormato EpiAtencionFormato											
				where 
				EpiAtencionFormato.UnidadReplicacion= @UnidadReplicacion
						and  EpiAtencionFormato.EpisodioClinico= @EpisodioClinico
							and EpiAtencionFormato.IdEpisodioAtencion= @IdEpisodioAtencion
							and  EpiAtencionFormato.IdPaciente= @IdPaciente					
							AND EpiAtencionFormato.IdOpcion =@UsuarioModificacion
										
			
		SELECT @CONTADOR= COUNT(*) 					
					FROM dbo.V_EpisodioAtenciones
						left join SS_HC_EpisodioAtencion epiAtencion
						on (epiAtencion.EpisodioClinico = V_EpisodioAtenciones.EpisodioClinico
							and epiAtencion.IdEpisodioAtencion = V_EpisodioAtenciones.Episodio_Atencion
							and epiAtencion.UnidadReplicacion = V_EpisodioAtenciones.UnidadReplicacion
							and epiAtencion.IdPaciente = V_EpisodioAtenciones.IdPaciente
							and epiAtencion.IdOrdenAtencion = V_EpisodioAtenciones.IdOrdenAtencion
						)											
					WHERE 
					  (@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones.Persona = @Persona)
						and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones.IdPaciente = @IdPaciente)
						and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones.Accion = @COD_FORMATO_AUX)					
					    and (@UnidadReplicacion is null  OR  upper(V_EpisodioAtenciones.UnidadReplicacion) like '%'+upper(@UnidadReplicacion)+'%')							
					    and (@IdEpisodioAtencion is null OR  V_EpisodioAtenciones.Episodio_Atencion = @IdEpisodioAtencion)
					    and (@EpisodioClinico  is null OR V_EpisodioAtenciones.EpisodioClinico = @EpisodioClinico)
	 	 
 
		SELECT 
				convert(int,RowNumber) as [Persona]  --OBS: persona == idPaciente
			  ,[ApellidoPaterno]
			  ,[ApellidoMaterno]
			  ,[Nombres]
			  ,[NombreCompleto]
			  ,[UnidadReplicacion]
			  ,[IdPaciente]
			  ,[FechaCierre]
			  ,[Episodio_Atencion]
			  ,[FechaReg_EpisoAtencon]
			  ,[FechaAtencion]
			  ,[TipoAtencion]
			  ,[IdOrdenAtencion]
			  ,[LineaOrdenAtencion]
			  ,[TipoOrdenAtencion]
			  ,[Estado_EpisodioAten]
			  ,[UsuarioCreacion]
			  ,[FechaCreacion]
			  ,CodigoOAX as UsuarioModificacion ---AUX cod OA
			  ,[FechaModificacion]
			  ,RIGHT('0000'+CAST(Episodio_Atencion AS VARCHAR(4)),4) +
				'.'+RIGHT('0000'+CAST(IdEpisodioAtencion AS VARCHAR(4)),4) +
				' - ' + ISNULL(MotivoConsulta,'Episodio')  as MotivoConsulta
			  --,[MotivoConsulta]
			  ,[FechaRegistro]
			  ,[Accion]
			  ,[EpisodioClinico]
			  ,[IdEpisodioAtencion]
			  ,[UnidadReplicacionEC]
			  ,[IdEstablecimientoSalud]
			  ,[IdUnidadServicio]
			  ,[IdPersonalSalud]
			  ,NombreMedicoUserX as PersonalSaludNombre
			  ,[IdEspecialidad]
			  ,[especialidadNombre]			  
                      ---AGREGADOS ---                      
				  ,[CodigoEpisodioClinico]
				  ,[IdEpisodioAtencionCodigo]
				  ,[CodigoOA]
				  ,[TipoTrabajador]
				  ,[TipoTrabajador_Desc]
				  ,[Id001]
				  ,[Id002]
				  ,[Codigo001]
				  ,[Codigo002]
				  ,[Codigo003]
				  ,[Codigo004]
				  ,[Descripcion001]
				  ,[Descripcion002]
				  ,[Descripcion003]
				  ,[Descripcion004]
				  ,[Documento_Paciente]
				  ,[Documento_Medico]
				  ,[Formato_Codigo]
				  ,[Formato_Id]
				  ,[Formato_Tipo]
				  ,[Formato_Uso]
				  ,[Formato_Descripcion]
				  ,(@CONTADOR + @CONTADOR_DIN) as contador_filas
		FROM (	 
				SELECT V_EpisodioAtenciones_MAIN.*,	
					--V_EpisodioAtenciones_MAIN.CodigoOAX ,
					medicoUser.NombreCompleto AS NombreMedicoUserX ,
					
					@CONTADOR AS Contador,
					ROW_NUMBER() OVER (ORDER BY /*V_EpisodioAtenciones_MAIN.CodigoOA DESC,*/V_EpisodioAtenciones_MAIN.IdEpisodioAtencion asc ) AS RowNumber    						
					FROM 
					(
						select V_EpisodioAtenciones.*, 
						epiAtencion.CodigoOA AS CodigoOAX 
						 from 
						dbo.V_EpisodioAtenciones
						left join SS_HC_EpisodioAtencion epiAtencion
						on (epiAtencion.EpisodioClinico = V_EpisodioAtenciones.EpisodioClinico
							and epiAtencion.IdEpisodioAtencion = V_EpisodioAtenciones.Episodio_Atencion
							and epiAtencion.UnidadReplicacion = V_EpisodioAtenciones.UnidadReplicacion
							and epiAtencion.IdPaciente = V_EpisodioAtenciones.IdPaciente
							and epiAtencion.IdOrdenAtencion = V_EpisodioAtenciones.IdOrdenAtencion
						)
											
						WHERE 
						    (@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones.Persona = @Persona)
						and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones.IdPaciente = @IdPaciente)
						and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones.Accion = @COD_FORMATO_AUX)					
                 
					    and (@UnidadReplicacion is null  OR  upper(V_EpisodioAtenciones.UnidadReplicacion) like '%'+upper(@UnidadReplicacion)+'%')							
					    and (@IdEpisodioAtencion is null OR  V_EpisodioAtenciones.Episodio_Atencion = @IdEpisodioAtencion)
					    and (@EpisodioClinico  is null OR V_EpisodioAtenciones.EpisodioClinico = @EpisodioClinico)								
	                    
						UNION
						select 
							EpiAtencionFormato.IdPaciente as Persona,paciente.ApellidoPaterno as ApellidoPaterno,paciente.ApellidoMaterno as ApellidoMaterno,null as Nombres,paciente.NombreCompleto as NombreCompleto,
							EpiAtencionFormato.UnidadReplicacion,IdPaciente,null as FechaCierre,0 as Episodio_Atencion,null as FechaReg_EpisoAtencon,
							null as FechaAtencion,0 as TipoAtencion,0 as IdOrdenAtencion,0 as LineaOrdenAtencion, 0 as TipoOrdenAtencion,
							EpiAtencionFormato.Estado as Estado_EpisodioAten,EpiAtencionFormato.UsuarioCreacion,EpiAtencionFormato.FechaCreacion,EpiAtencionFormato.UsuarioModificacion,EpiAtencionFormato.FechaModificacion,
							ConceptoFormulario as MotivoConsulta,null as FechaRegistro,convert(varchar,IdTransacciones) as Accion,EpisodioClinico as EpisodioClinico,IdEpisodioAtencion as IdEpisodioAtencion,
							'CEG' as UnidadReplicacionEC,IdOpcion as IdEstablecimientoSalud,IdForm as IdUnidadServicio,0 as IdPersonalSalud,null as PersonalSaludNombre,  --AUX OPCION Y FORM
							0 as IdEspecialidad,null as especialidadNombre,	
                      ---AGREGADOS ---                      
                      '000' as CodigoEpisodioClinico
                      ,'000' as  IdEpisodioAtencionCodigo
                      ,null as  CodigoOA
                      ,'000' as  TipoTrabajador
                      ,'000' as TipoTrabajador_Desc
                      ,0 as Id001
                      ,0 as Id002
                      ,'000' as Codigo001
                      ,'000' as Codigo002
                      ,'000' as Codigo003
                      ,'000' as Codigo004
                      ,'000' as Descripcion001
                      ,'000' as Descripcion002
                      ,'000' as Descripcion003
                      ,'000' as Descripcion004
                      ,'000' as  Documento_Paciente
                      ,'000' as  Documento_Medico
                      --INFO FORMATO
                      ,'000' as Formato_Codigo
                      ,0 as Formato_Id
                      ,0 as Formato_Tipo
                      ,0 as Formato_Uso
                      ,'000' as Formato_Descripcion       
                      ,0 as contador_filas  ,
                      												
							null as  CodigoOAX
						 from SS_HC_EpisodioAtencionFormato EpiAtencionFormato				
							left join PERSONAMAST paciente on (paciente.Persona = EpiAtencionFormato.IdPaciente)
						 where 
							EpiAtencionFormato.UnidadReplicacion= @UnidadReplicacion
							and  EpiAtencionFormato.EpisodioClinico= @EpisodioClinico
							and EpiAtencionFormato.IdEpisodioAtencion= @IdEpisodioAtencion
							and  EpiAtencionFormato.IdPaciente= @IdPaciente	
							--ADD 13.06.2017 OES
							and EpiAtencionFormato.IdOpcion=@UsuarioModificacion				
														
					)as V_EpisodioAtenciones_MAIN
						left join SG_Agente agente 
						on (agente.CodigoAgente = V_EpisodioAtenciones_MAIN.UsuarioCreacion)
						left join PERSONAMAST medicoUser 
						on (medicoUser.persona = agente.IdEmpleado)						
					--					
					) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
					order by /*CodigoOA DESC,*/ FechaCreacion /*DESC */  
		 
							   				       
	end
	ELSE
	if(@ACCION = 'LISTAR')
	begin
		SELECT *				
		FROM dbo.V_EpisodioAtenciones
					WHERE 
					(@Persona is null or (@Persona =0 ) OR Persona = @Persona)
					and (@IdPaciente is null  or (@IdPaciente =0 ) OR IdPaciente = @IdPaciente)
					and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
					and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
					and (@IdOrdenAtencion  is null OR IdOrdenAtencion = @IdOrdenAtencion)
					and (@UsuarioModificacion  is null OR V_EpisodioAtenciones.Accion = @UsuarioModificacion)
					
	end	
	ELSE
if(@ACCION = 'LISTARCOPYPAG')
	begin		
		 set @COD_FORMATO_AUX = @Codigo002		 
		 if(@Codigo002 is not null)
			begin
				select @COD_FORMATO_AUX = SS_HC_Formato.CodigoFormato from SG_Opcion
				left join SS_HC_Formato on (SS_HC_Formato.IdFormato = SG_Opcion.IdFormato)
				where SG_Opcion.IdOpcion = convert(int ,@Codigo002)
			end			 
		--@CONTADOR = 
		SELECT @CONTADOR = COUNT(*)
		FROM		
			V_EpisodioAtenciones AS V_EpisodioAtenciones_MAIN
			--where V_EpisodioAtenciones_MAIN.IdPaciente=1076942		
			WHERE 
				(@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones_MAIN.Persona = @Persona)
				and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones_MAIN.IdPaciente = @IdPaciente)
				and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(V_EpisodioAtenciones_MAIN.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
				and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
				and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones_MAIN.IdOrdenAtencion = @IdOrdenAtencion)
				and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Formato_Codigo = @COD_FORMATO_AUX)					
				and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
							

	
		SELECT LISTADO.* FROM
		(
			select 
		      convert(integer,ROW_NUMBER() OVER (ORDER BY V_EpisodioAtenciones_MAIN.FechaCreacion DESC ) )			  
			  AS Persona ,   
			  ApellidoPaterno,
			  ApellidoMaterno,
			  Nombres,
			  NombreCompleto,
			  UnidadReplicacion,
			  IdPaciente,
			  FechaCierre,
			  Episodio_Atencion,
			  FechaReg_EpisoAtencon,
			  FechaAtencion,
			  TipoAtencion,
			  IdOrdenAtencion,
			  LineaOrdenAtencion,
			  TipoOrdenAtencion,
			  Estado_EpisodioAten,
			  UsuarioCreacion,
			  FechaCreacion,
			  UsuarioModificacion,
			  FechaModificacion,
			  MotivoConsulta,
			  FechaRegistro,
			  Accion,
			  EpisodioClinico,
			  IdEpisodioAtencion,
			  UnidadReplicacionEC,
			  IdEstablecimientoSalud,
			  IdUnidadServicio,
			  IdPersonalSalud,
			  PersonalSaludNombre,
			  IdEspecialidad,
			  especialidadNombre,
			  CodigoEpisodioClinico,	
			  '['+right('0000000'+isnull(convert(varchar,CodigoEpisodioClinico),'No Def'),6)+']'+ + '.'+
			  right('0000000'+isnull(convert(varchar,IdEpisodioAtencion),'No Def'),6) as IdEpisodioAtencionCodigo,
			  CodigoOA,
			  TipoTrabajador,
			  TipoTrabajador_Desc,
			  Id001,
			  Id002,
			  Codigo001,
			  Codigo002,
			  Codigo003,
			  Codigo004,
			  Descripcion001,
			  Descripcion002,
			  Descripcion003,
			  right('0000000'+isnull(convert(varchar,CodigoEpisodioClinico),'No Def'),6) as Descripcion004,
			  Documento_Paciente,
			  Documento_Medico,
			  Formato_Codigo,
			  Formato_Id,
			  Formato_Tipo,
			  Formato_Uso,
			  Formato_Descripcion
			  ,	
			  @CONTADOR as contador_filas	
			from V_EpisodioAtenciones as V_EpisodioAtenciones_MAIN
		--	where 
		--	V_EpisodioAtenciones_MAIN.Persona=14
		--	AND V_EpisodioAtenciones_MAIN.IdPaciente=14
		----	AND V_EpisodioAtenciones_MAIN.EpisodioClinico=168
		--	AND V_EpisodioAtenciones_MAIN.Formato_Codigo='CCEPF200D'
			
		WHERE 
				(@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones_MAIN.Persona = @Persona)
				and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones_MAIN.IdPaciente = @IdPaciente)
				and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(V_EpisodioAtenciones_MAIN.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
				and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
				and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones_MAIN.IdOrdenAtencion = @IdOrdenAtencion)
				and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Formato_Codigo = @COD_FORMATO_AUX)					
				and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')


				  			
		)AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       LISTADO.Persona BETWEEN @Inicio  AND @NumeroFilas 	
		
	END
	


	
if(@ACCION = 'LISTARCOPYREC')
	begin		
		 set @COD_FORMATO_AUX = @Codigo002		 
		 if(@Codigo002 is not null)
			begin
				select @COD_FORMATO_AUX = SS_HC_Formato.CodigoFormato from SG_Opcion
				left join SS_HC_Formato on (SS_HC_Formato.IdFormato = SG_Opcion.IdFormato)
				where SG_Opcion.IdOpcion = convert(int ,@Codigo002)
			end			 
		--@CONTADOR = 
		SELECT @CONTADOR = COUNT(*)
		FROM		
			V_EpisodioAtenciones AS V_EpisodioAtenciones_MAIN
			--where V_EpisodioAtenciones_MAIN.IdPaciente=1076942		
			WHERE 
				(@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones_MAIN.Persona = @Persona)
				and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones_MAIN.IdPaciente = @IdPaciente)
				and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(V_EpisodioAtenciones_MAIN.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
				and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
				and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones_MAIN.IdOrdenAtencion = @IdOrdenAtencion)
				and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Formato_Codigo = @COD_FORMATO_AUX)
				and (@UsuarioModificacion  is null OR V_EpisodioAtenciones_MAIN.Formato_Codigo = @UsuarioModificacion)
				and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
							

	
		SELECT LISTADO.* FROM
		(
			select 
		      convert(integer,ROW_NUMBER() OVER (ORDER BY V_EpisodioAtenciones_MAIN.FechaCreacion DESC ) )			  
			  AS Persona ,   
			  ApellidoPaterno,
			  ApellidoMaterno,
			  Nombres,
			  NombreCompleto,
			  UnidadReplicacion,
			  IdPaciente,
			  FechaCierre,
			  Episodio_Atencion,
			  FechaReg_EpisoAtencon,
			  FechaAtencion,
			  TipoAtencion,
			  IdOrdenAtencion,
			  LineaOrdenAtencion,
			  TipoOrdenAtencion,
			  Estado_EpisodioAten,
			  UsuarioCreacion,
			  FechaCreacion,
			  UsuarioModificacion,
			  FechaModificacion,
			  MotivoConsulta,
			  FechaRegistro,
			  Accion,
			  EpisodioClinico,
			  IdEpisodioAtencion,
			  UnidadReplicacionEC,
			  IdEstablecimientoSalud,
			  IdUnidadServicio,
			  IdPersonalSalud,
			  PersonalSaludNombre,
			  IdEspecialidad,
			  especialidadNombre,
			  CodigoEpisodioClinico,	
			  '['+right('0000000'+isnull(convert(varchar,CodigoEpisodioClinico),'No Def'),6)+']'+ + '.'+
			  right('0000000'+isnull(convert(varchar,IdEpisodioAtencion),'No Def'),6) as IdEpisodioAtencionCodigo,
			  CodigoOA,
			  TipoTrabajador,
			  TipoTrabajador_Desc,
			  Id001,
			  Id002,
			  Codigo001,
			  Codigo002,
			  Codigo003,
			  Codigo004,
			  Descripcion001,
			  Descripcion002,
			  Descripcion003,
			  right('0000000'+isnull(convert(varchar,CodigoEpisodioClinico),'No Def'),6) as Descripcion004,
			  Documento_Paciente,
			  Documento_Medico,
			  Formato_Codigo,
			  Formato_Id,
			  Formato_Tipo,
			  Formato_Uso,
			  Formato_Descripcion
			  ,	
			  @CONTADOR as contador_filas	
			from V_EpisodioAtenciones as V_EpisodioAtenciones_MAIN
			
		WHERE 
				(@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones_MAIN.Persona = @Persona)
				and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones_MAIN.IdPaciente = @IdPaciente)
				and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(V_EpisodioAtenciones_MAIN.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
				and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
				and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones_MAIN.IdOrdenAtencion = @IdOrdenAtencion)
				and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Formato_Codigo = @COD_FORMATO_AUX)					
				and (@UsuarioModificacion  is null OR V_EpisodioAtenciones_MAIN.Formato_Codigo = @UsuarioModificacion)
				and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
				  			
		)AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       LISTADO.Persona BETWEEN @Inicio  AND @NumeroFilas 	
		
	END
   
	if(@ACCION = 'LISTARGLASGOWPAG')
	begin		
		 set @COD_FORMATO_AUX = @Codigo002		 
		 if(@Codigo002 is not null)
			begin
				select @COD_FORMATO_AUX = SS_HC_Formato.CodigoFormato from SG_Opcion
				left join SS_HC_Formato on (SS_HC_Formato.IdFormato = SG_Opcion.IdFormato)
				where SG_Opcion.IdOpcion = convert(int ,@Codigo002)
			end			 
		--@CONTADOR = 
		SELECT @CONTADOR = COUNT(*)		FROM		V_EpisodioAtenciones AS V_EpisodioAtenciones_MAIN	
			WHERE 
				 (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Formato_Codigo = @COD_FORMATO_AUX)					
				and 
				(@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')

		SELECT LISTADO.* FROM
		(
			select 
		      convert(integer,ROW_NUMBER() OVER (ORDER BY V_EpisodioAtenciones_MAIN.FechaCreacion DESC ) )			  
			  AS Persona ,   
			  ApellidoPaterno,
			  ApellidoMaterno,
			  Nombres,
			  NombreCompleto,
			  UnidadReplicacion,
			  IdPaciente,
			  FechaCierre,
			  Episodio_Atencion,
			  FechaReg_EpisoAtencon,
			  FechaAtencion,
			  TipoAtencion,
			  IdOrdenAtencion,
			  LineaOrdenAtencion,
			  TipoOrdenAtencion,
			  Estado_EpisodioAten,
			  UsuarioCreacion,
			  FechaCreacion,
			  UsuarioModificacion,
			  FechaModificacion,
			  MotivoConsulta,
			  FechaRegistro,
			  Accion,
			  EpisodioClinico,
			  IdEpisodioAtencion,
			  UnidadReplicacionEC,
			  IdEstablecimientoSalud,
			  IdUnidadServicio,
			  IdPersonalSalud,
			  PersonalSaludNombre,
			  IdEspecialidad,
			  especialidadNombre,
			  CodigoEpisodioClinico,	
			  '['+right('0000000'+isnull(convert(varchar,CodigoEpisodioClinico),'No Def'),6)+']'+ + '.'+
			  right('0000000'+isnull(convert(varchar,IdEpisodioAtencion),'No Def'),6) as IdEpisodioAtencionCodigo,
			  CodigoOA,
			  TipoTrabajador,
			  TipoTrabajador_Desc,
			  Id001,
			  Id002,
			  Codigo001,
			  Codigo002,
			  Codigo003,
			  Codigo004,
			  Descripcion001,
			  Descripcion002,
			  Descripcion003,
			  right('0000000'+isnull(convert(varchar,CodigoEpisodioClinico),'No Def'),6) as Descripcion004,
			  Documento_Paciente,
			  Documento_Medico,
			  Formato_Codigo,
			  Formato_Id,
			  Formato_Tipo,
			  Formato_Uso,
			  Formato_Descripcion
			  ,	
			 @CONTADOR as contador_filas	
			from V_EpisodioAtenciones as V_EpisodioAtenciones_MAIN			
		WHERE 
				(@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Formato_Codigo = @COD_FORMATO_AUX)					
				and 
				(@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
				  			
		)AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       LISTADO.Persona BETWEEN @Inicio  AND @NumeroFilas 			
	END

	if(@ACCION = 'LISTARFARMACO')
	begin		
		 set @COD_FORMATO_AUX = @Codigo002		 
		 if(@Codigo002 is not null)
			begin
				select @COD_FORMATO_AUX = SS_HC_Formato.CodigoFormato from SG_Opcion
				left join SS_HC_Formato on (SS_HC_Formato.IdFormato = SG_Opcion.IdFormato)
				where SG_Opcion.IdOpcion = convert(int ,@Codigo002)
			end			 
		--@CONTADOR = 
		SELECT @CONTADOR = COUNT(*)		FROM	V_EpisodioAtenciones AS V_EpisodioAtenciones_MAIN
			WHERE 
				(@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones_MAIN.Persona = @Persona)
				and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones_MAIN.IdPaciente = @IdPaciente)
				and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(V_EpisodioAtenciones_MAIN.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
				and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
				and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones_MAIN.IdOrdenAtencion = @IdOrdenAtencion)
				and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Formato_Codigo = @COD_FORMATO_AUX)					
				and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
							

	
		SELECT LISTADO.* FROM
		(
			select 
		      convert(integer,ROW_NUMBER() OVER (ORDER BY V_EpisodioAtenciones_MAIN.Persona ASC ) )			  
			  AS Persona ,   
			  ApellidoPaterno,
			  ApellidoMaterno,
			  Nombres,
			  NombreCompleto,
			  UnidadReplicacion,
			  IdPaciente,
			  FechaCierre,
			  Episodio_Atencion,
			  FechaReg_EpisoAtencon,
			  FechaAtencion,
			  TipoAtencion,
			  IdOrdenAtencion,
			  LineaOrdenAtencion,
			  TipoOrdenAtencion,
			  Estado_EpisodioAten,
			  UsuarioCreacion,
			  FechaCreacion,
			  UsuarioModificacion,
			  FechaModificacion,
			  MotivoConsulta,
			  FechaRegistro,
			  Accion,
			  EpisodioClinico,
			  IdEpisodioAtencion,
			  UnidadReplicacionEC,
			  IdEstablecimientoSalud,
			  IdUnidadServicio,
			  IdPersonalSalud,
			  PersonalSaludNombre,
			  IdEspecialidad,
			  especialidadNombre,
			  CodigoEpisodioClinico,	
			  '['+right('0000000'+isnull(convert(varchar,CodigoEpisodioClinico),'No Def'),6)+']'+ + '.'+
			  right('0000000'+isnull(convert(varchar,IdEpisodioAtencion),'No Def'),6) as IdEpisodioAtencionCodigo,
			  CodigoOA,
			  TipoTrabajador,
			  TipoTrabajador_Desc,
			  Id001,
			  Id002,
			  Codigo001,
			  Codigo002,
			  Codigo003,
			  Codigo004,
			  Descripcion001,
			  Descripcion002,
			  Descripcion003,
			  right('0000000'+isnull(convert(varchar,CodigoEpisodioClinico),'No Def'),6) as Descripcion004,
			  Documento_Paciente,
			  Documento_Medico,
			  Formato_Codigo,
			  Formato_Id,
			  Formato_Tipo,
			  Formato_Uso,
			  Formato_Descripcion
			  ,
			 @CONTADOR as contador_filas	
			from V_EpisodioAtenciones as V_EpisodioAtenciones_MAIN
			
			WHERE 
				(@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones_MAIN.Persona = @Persona)
				and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones_MAIN.IdPaciente = @IdPaciente)
				and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(V_EpisodioAtenciones_MAIN.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
				and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
				and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones_MAIN.IdOrdenAtencion = @IdOrdenAtencion)
				and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Formato_Codigo = @COD_FORMATO_AUX)					
				and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
				  			
		)AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       LISTADO.Persona BETWEEN @Inicio  AND @NumeroFilas 
						  
					order by IdEpisodioAtencion desc, FechaCreacion desc 		
		
	END

	ELSE
	if(@ACCION = 'LISTAR_GRUPO')
	begin	
	
		 set @COD_FORMATO_AUX = @Codigo002
		 
		 if(@Codigo002 is not null)
			begin
				select @COD_FORMATO_AUX = SS_HC_Formato.CodigoFormato from SG_Opcion
				left join SS_HC_Formato on (SS_HC_Formato.IdFormato = SG_Opcion.IdFormato)
				where SG_Opcion.IdOpcion = convert(int ,@Codigo002)
			end			 
		--@CONTADOR = 
		SELECT @CONTADOR = COUNT(Accion) FROM
		(
			SELECT V_EpisodioAtenciones_MAIN.Accion FROM		V_EpisodioAtenciones AS V_EpisodioAtenciones_MAIN	
			WHERE 
				(@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones_MAIN.Persona = @Persona)
				and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones_MAIN.IdPaciente = @IdPaciente)
				and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(V_EpisodioAtenciones_MAIN.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
				and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
				and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones_MAIN.IdOrdenAtencion = @IdOrdenAtencion)
				and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Accion = @COD_FORMATO_AUX)					
				and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')				
						
			group by		
			  UnidadReplicacion,
			  IdPaciente,			
			  Accion,
			  EpisodioClinico,
			  IdEpisodioAtencion
		)	LISTA 

	
		SELECT LISTADO.* FROM
		(
			select 
		      convert(integer,ROW_NUMBER() OVER (ORDER BY V_EpisodioAtenciones_MAIN.Persona ASC ) )
			  
			  AS Persona ,   
			  ApellidoPaterno,
			  ApellidoMaterno,
			  Nombres,
			  NombreCompleto,
			  UnidadReplicacion,
			  IdPaciente,
			  FechaCierre,
			  Episodio_Atencion,
			  FechaReg_EpisoAtencon,
			  FechaAtencion,
			  TipoAtencion,
			  IdOrdenAtencion,
			  LineaOrdenAtencion,
			  TipoOrdenAtencion,
			  Estado_EpisodioAten,
			  UsuarioCreacion,
			  MAX(FechaCreacion) as FechaCreacion,
			  UsuarioModificacion,
			  FechaModificacion,
			  '' as MotivoConsulta,
			  FechaRegistro,
			  Accion,
			  EpisodioClinico,
			  IdEpisodioAtencion,
			  UnidadReplicacionEC,
			  IdEstablecimientoSalud,
			  IdUnidadServicio,
			  IdPersonalSalud,
			  PersonalSaludNombre,
			  IdEspecialidad,
			  especialidadNombre,
			  CodigoEpisodioClinico,
			  IdEpisodioAtencionCodigo,
			  CodigoOA,
			  TipoTrabajador,
			  TipoTrabajador_Desc,
			  0 as Id001,
			  0 as Id002,
			  '00' Codigo001,
			  '00' as Codigo002,
			  '00' as Codigo003,
			  '00' as Codigo004,
			  '00' as Descripcion001,
			  '00' as Descripcion002,
			  '00' as Descripcion003,
			  '00' as Descripcion004,
			  Documento_Paciente,
			  Documento_Medico,
			  Formato_Codigo,
			  Formato_Id,
			  Formato_Tipo,
			  Formato_Uso,
			  Formato_Descripcion,
			  @CONTADOR as contador_filas	
			from V_EpisodioAtenciones as V_EpisodioAtenciones_MAIN
			--where V_EpisodioAtenciones_MAIN.IdPaciente=1076942
			
			WHERE 
				(@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones_MAIN.Persona = @Persona)
				and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones_MAIN.IdPaciente = @IdPaciente)
				and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(V_EpisodioAtenciones_MAIN.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
				and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
				and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones_MAIN.IdOrdenAtencion = @IdOrdenAtencion)
				and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Accion = @COD_FORMATO_AUX)					
				and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
		
			
			group by
				Persona,
			  ApellidoPaterno,
			  ApellidoMaterno,
			  Nombres,
			  NombreCompleto,
			  UnidadReplicacion,
			  IdPaciente,
			  FechaCierre,
			  Episodio_Atencion,
			  FechaReg_EpisoAtencon,
			  FechaAtencion,
			  TipoAtencion,
			  IdOrdenAtencion,
			  LineaOrdenAtencion,
			  TipoOrdenAtencion,
			  Estado_EpisodioAten,
			  UsuarioCreacion,
			  --FechaCreacion,
			  UsuarioModificacion,
			  FechaModificacion,
			  --MotivoConsulta,
			  FechaRegistro,
			  Accion,
			  EpisodioClinico,
			  IdEpisodioAtencion,
			  UnidadReplicacionEC,
			  IdEstablecimientoSalud,
			  IdUnidadServicio,
			  IdPersonalSalud,
			  PersonalSaludNombre,
			  IdEspecialidad,
			  especialidadNombre,
			  CodigoEpisodioClinico,
			  IdEpisodioAtencionCodigo,
			  CodigoOA,
			  TipoTrabajador,
			  TipoTrabajador_Desc,			
				-----
			  Documento_Paciente,
			  Documento_Medico,
			  Formato_Codigo,
			  Formato_Id,
			  Formato_Tipo,
			  Formato_Uso,
			  Formato_Descripcion,			 
			  contador_filas	
			  
			  
		)AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       LISTADO.Persona BETWEEN @Inicio  AND @NumeroFilas 
					order by  LISTADO.FechaRegistro desc 		
				
	end

	ELSE
	if(@ACCION = 'LISTAR_COMP')
	begin	
	
		 set @COD_FORMATO_AUX = @Codigo002
		 
		 if(@Codigo002 is not null)
			begin
				select @COD_FORMATO_AUX = SS_HC_Formato.CodigoFormato from SG_Opcion
				left join SS_HC_Formato on (SS_HC_Formato.IdFormato = SG_Opcion.IdFormato)
				where SG_Opcion.IdOpcion = convert(int ,@Codigo002)
			end			 
		--@CONTADOR = 
		SELECT @CONTADOR = COUNT(Accion) FROM
		(
			SELECT V_EpisodioAtenciones_MAIN.Accion FROM			V_EpisodioAtenciones AS V_EpisodioAtenciones_MAIN
			WHERE 				
				 (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones_MAIN.IdPaciente = @IdPaciente)			
				and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Codigo003 = @COD_FORMATO_AUX)					
				and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
						
			group by		
			  UnidadReplicacion,
			  IdPaciente,			
			  Accion,
			  EpisodioClinico,
			  IdEpisodioAtencion
		)	LISTA 

	
		SELECT LISTADO.* FROM
		(
			select 
		      convert(integer,ROW_NUMBER() OVER (ORDER BY V_EpisodioAtenciones_MAIN.Persona ASC ) )
			  
			  AS Persona ,   
			  ApellidoPaterno,
			  ApellidoMaterno,
			  Nombres,
			  NombreCompleto,
			  UnidadReplicacion,
			  IdPaciente,
			  FechaCierre,
			  Episodio_Atencion,
			  FechaReg_EpisoAtencon,
			  FechaAtencion,
			  TipoAtencion,
			  IdOrdenAtencion,
			  LineaOrdenAtencion,
			  TipoOrdenAtencion,
			  Estado_EpisodioAten,
			  UsuarioCreacion,
			  MAX(FechaCreacion) as FechaCreacion,
			  UsuarioModificacion,
			  FechaModificacion,
			  '' as MotivoConsulta,
			  FechaRegistro,
			  Accion,
			  EpisodioClinico,
			  IdEpisodioAtencion,
			  UnidadReplicacionEC,
			  IdEstablecimientoSalud,
			  IdUnidadServicio,
			  IdPersonalSalud,
			  PersonalSaludNombre,
			  IdEspecialidad,
			  especialidadNombre,
			  CodigoEpisodioClinico,
			  IdEpisodioAtencionCodigo,
			  CodigoOA,
			  TipoTrabajador,
			  TipoTrabajador_Desc,
			  0 as Id001,
			  0 as Id002,
			  '00' Codigo001,
			  '00' as Codigo002,
			  '00' as Codigo003,
			   Codigo004,
			   Descripcion001,
			  Descripcion002,
			  Descripcion003,
			  Descripcion004,
			  Documento_Paciente,
			  Documento_Medico,
			  Formato_Codigo,
			  Formato_Id,
			  Formato_Tipo,
			  Formato_Uso,
			  Formato_Descripcion			 
			from V_EpisodioAtenciones as V_EpisodioAtenciones_MAIN
			WHERE 			
				(@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones_MAIN.IdPaciente = @IdPaciente)			
				and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Formato_Codigo = @COD_FORMATO_AUX)					
				and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')				
			
		
			
			group by
				Persona,
			  ApellidoPaterno,
			  ApellidoMaterno,
			  Nombres,
			  NombreCompleto,
			  UnidadReplicacion,
			  IdPaciente,
			  FechaCierre,
			  Episodio_Atencion,
			  FechaReg_EpisoAtencon,
			  FechaAtencion,
			  TipoAtencion,
			  IdOrdenAtencion,
			  LineaOrdenAtencion,
			  TipoOrdenAtencion,
			  Estado_EpisodioAten,
			  UsuarioCreacion,
			  --FechaCreacion,
			  UsuarioModificacion,
			  FechaModificacion,
			  --MotivoConsulta,
			  FechaRegistro,
			  Accion,
			  EpisodioClinico,
			  IdEpisodioAtencion,
			  UnidadReplicacionEC,
			  IdEstablecimientoSalud,
			  IdUnidadServicio,
			  IdPersonalSalud,
			  PersonalSaludNombre,
			  IdEspecialidad,
			  especialidadNombre,
			  CodigoEpisodioClinico,
			  IdEpisodioAtencionCodigo,
			  CodigoOA,
			  TipoTrabajador,
			  TipoTrabajador_Desc,			
				-----
			  Documento_Paciente,
			  Documento_Medico,
			  Formato_Codigo,
			  Formato_Id,
			  Formato_Tipo,
			  Formato_Uso,
			  Formato_Descripcion,
			  Descripcion003,
			  Descripcion004,
			  Codigo004,
			  Descripcion001,
			  Descripcion002,
			  contador_filas				  			
		)AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       LISTADO.Persona BETWEEN @Inicio  AND @NumeroFilas 
					order by IdPersonalSalud, FechaCreacion desc   		
				
	end	
	else
	if(@ACCION = 'LISTAR_DIN')
	begin	
	
		 set @COD_FORMATO_AUX = @Codigo002
		 
		 if(@Codigo002 is not null)
			begin
				select @COD_FORMATO_AUX = SS_HC_Formato.CodigoFormato from SG_Opcion
				left join SS_HC_Formato on (SS_HC_Formato.IdFormato = SG_Opcion.IdFormato)
				where SG_Opcion.IdOpcion = convert(int ,@Codigo002)
			end			 
		--@CONTADOR = 
		SELECT @CONTADOR = COUNT(Accion) FROM
		(
			SELECT V_EpisodioAtenciones_MAIN.Accion FROM	V_EpisodioAtenciones AS V_EpisodioAtenciones_MAIN
	
			WHERE 
				(@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones_MAIN.Persona = @Persona)
				and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones_MAIN.IdPaciente = @IdPaciente)
				and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(V_EpisodioAtenciones_MAIN.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
				and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
				and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones_MAIN.IdOrdenAtencion = @IdOrdenAtencion)
				and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Accion = @COD_FORMATO_AUX)					
				and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
				and (@IdOpcion is null or V_EpisodioAtenciones_MAIN.Id002 = @Id001)
						
			group by		
			  UnidadReplicacion,
			  IdPaciente,			
			  Accion,
			  EpisodioClinico,
			  IdEpisodioAtencion/*,Id001*/
		)	LISTA 

	
		SELECT LISTADO.* FROM
		(
			select 
		      convert(integer,ROW_NUMBER() OVER (ORDER BY V_EpisodioAtenciones_MAIN.Persona ASC ) )
			  
			  AS Persona ,   
			  ApellidoPaterno,
			  ApellidoMaterno,
			  Nombres,
			  NombreCompleto,
			  UnidadReplicacion,
			  IdPaciente,
			  FechaCierre,
			  Episodio_Atencion,
			  FechaReg_EpisoAtencon,
			  FechaAtencion,
			  TipoAtencion,
			  IdOrdenAtencion,
			  LineaOrdenAtencion,
			  TipoOrdenAtencion,
			  Estado_EpisodioAten,
			  UsuarioCreacion,
			  MAX(FechaCreacion) as FechaCreacion,
			  UsuarioModificacion,
			  FechaModificacion,
			  '' as MotivoConsulta,
			  FechaRegistro,
			  Accion,
			  EpisodioClinico,
			  IdEpisodioAtencion,
			  UnidadReplicacionEC,
			  IdEstablecimientoSalud,
			  IdUnidadServicio,
			  IdPersonalSalud,
			  PersonalSaludNombre,
			  IdEspecialidad,
			  especialidadNombre,
			  CodigoEpisodioClinico,
			  IdEpisodioAtencionCodigo,
			  CodigoOA,
			  TipoTrabajador,
			  TipoTrabajador_Desc,
			  Id001,
			  Id002,
			  Codigo001,
			  '00' as Codigo002,
			  '00' as Codigo003,
			  '00' as Codigo004,
			  '00' as Descripcion001,
			  '00' as Descripcion002,
			  '00' as Descripcion003,
			  '00' as Descripcion004,
			  Documento_Paciente,
			  Documento_Medico,
			  Formato_Codigo,
			  Formato_Id,
			  Formato_Tipo,
			  Formato_Uso,
			  Formato_Descripcion,
			  @CONTADOR as contador_filas	
			from V_EpisodioAtenciones as V_EpisodioAtenciones_MAIN
			--where V_EpisodioAtenciones_MAIN.IdPaciente=1076942
			
			WHERE 
				(@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones_MAIN.Persona = @Persona)
				and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones_MAIN.IdPaciente = @IdPaciente)
				and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(V_EpisodioAtenciones_MAIN.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
				and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
				and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones_MAIN.IdOrdenAtencion = @IdOrdenAtencion)
				and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Accion = @COD_FORMATO_AUX)					
				and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
		and (@IdOpcion is null or V_EpisodioAtenciones_MAIN.Id002 = @Id001)
			
			group by
				Persona,
			  ApellidoPaterno,
			  ApellidoMaterno,
			  Nombres,
			  NombreCompleto,
			  UnidadReplicacion,
			  IdPaciente,
			  FechaCierre,
			  Episodio_Atencion,
			  FechaReg_EpisoAtencon,
			  FechaAtencion,
			  TipoAtencion,
			  IdOrdenAtencion,
			  LineaOrdenAtencion,
			  TipoOrdenAtencion,
			  Estado_EpisodioAten,
			  UsuarioCreacion,
			  --FechaCreacion,
			  UsuarioModificacion,
			  FechaModificacion,
			  --MotivoConsulta,
			  FechaRegistro,
			  Accion,
			  EpisodioClinico,
			  IdEpisodioAtencion,
			  UnidadReplicacionEC,
			  IdEstablecimientoSalud,
			  IdUnidadServicio,
			  IdPersonalSalud,
			  PersonalSaludNombre,
			  IdEspecialidad,
			  especialidadNombre,
			  CodigoEpisodioClinico,
			  IdEpisodioAtencionCodigo,
			  CodigoOA,
			  Id001,
			  Id002,
			  Codigo001,
			  TipoTrabajador,
			  TipoTrabajador_Desc,			
				-----
			  Documento_Paciente,
			  Documento_Medico,
			  Formato_Codigo,
			  Formato_Id,
			  Formato_Tipo,
			  Formato_Uso,
			  Formato_Descripcion,			 
			  contador_filas				  			
		)AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       LISTADO.Persona BETWEEN @Inicio  AND @NumeroFilas 
					order by IdPersonalSalud, FechaCreacion desc   		
				
	end
	--------------------------------------------------------------------------------------------------
  
END



GO
