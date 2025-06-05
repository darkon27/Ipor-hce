
GO
/****** Object:  StoredProcedure [dbo].[SP_HCE_RETORNOATENCIONCONSULTA]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_HCE_RETORNOATENCIONCONSULTA]
@CodigoOA varchar(15),
@IdPaciente int,
@LineaOA int

AS
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
--------------------------1.- LLENAR TABLA INFORME -------------------------------------------
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
BEGIN

	UPDATE SS_HC_EpisodioAtencion SET ESTADO=2,FechaModificacion=getdate(),ObservacionProxima='Retorno BD Helpdesk' WHERE IdPaciente=@IdPaciente and Codigooa=@CodigoOa and LineaOrdenAtencion=@LineaOA

	Select SS_HC_EpisodioAtencion.Estado as EstadoHCE,
	CASE WHEN SS_HC_EpisodioAtencion.Estado=2 THEN 'EN ATENCION'
	WHEN SS_HC_EpisodioAtencion.Estado=3 THEN 'ATENDIDO'
	ELSE
	'ERROR'
	END AS DescripcionEstado,ObservacionProxima AS OBSERVACION,
	PERSONAMAST.Busqueda,SS_HC_EpisodioAtencion.Idpaciente,EpisodioClinico,IdEpisodioAtencion,IdOrdenatencion,LineaOrdenAtencion 
	From SS_HC_EpisodioAtencion INNER JOIN PERSONAMAST 
	ON PERSONAMAST.Persona=SS_HC_EpisodioAtencion.IdPaciente
	WHERE IdPaciente=@IdPaciente and Codigooa=@CodigoOa and LineaOrdenAtencion=@LineaOA
END
GO
/****** Object:  StoredProcedure [dbo].[SP_HeaderMiscelaneos]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_HeaderMiscelaneos]

@AplicacionCodigo char(2),
@CodigoTabla varchar(10),
@Compania char(6),
@DescripcionLocal varchar(100),
@DescripcionExtranjera varchar(80),
@Estado char,
@UltimoUsuario varchar(25),
@UltimaFechaModif datetime,
@Timestamp timestamp,
@ACCION varchar(25)
     
AS    
BEGIN    
SET NOCOUNT ON;  
BEGIN  TRANSACTION  
  
 DECLARE @CONTADOR INT  
 IF(@Accion = 'INSERT')  
 BEGIN   

		
  INSERT INTO MA_MiscelaneosHeader
  (  
		AplicacionCodigo,
		CodigoTabla,
		Compania,
		DescripcionLocal,
		DescripcionExtranjera,
		Estado,
		UltimoUsuario,
		UltimaFechaModif,
		Timestamp,
		ACCION
   )
    VALUES  
  (   
		@AplicacionCodigo,
		@CodigoTabla,
		@Compania,
		@DescripcionLocal,
		@DescripcionExtranjera,
		@Estado,
		@UltimoUsuario,
		GETDATE(),
		default,
		@ACCION
  )  
  
 SELECT 1		 
 END   
 ELSE  
 IF(@Accion = 'UPDATE')  
 BEGIN  
 UPDATE MA_MiscelaneosHeader  
  SET      
		AplicacionCodigo = @AplicacionCodigo,
		CodigoTabla = @CodigoTabla,
		Compania = @Compania,
		DescripcionLocal = @DescripcionLocal,
		DescripcionExtranjera = @DescripcionExtranjera,
		Estado = @Estado,
		UltimoUsuario = @UltimoUsuario,
		UltimaFechaModif = GETDATE(),
		ACCION = @ACCION
		WHERE 
		(CodigoTabla = @CodigoTabla)  
   		select 1
 end   
 else  
 if(@Accion = 'DELETE')  
 begin  
  delete MA_MiscelaneosHeader  
		WHERE 
		(CodigoTabla = @CodigoTabla)  
   		select 1
end
		if(@Accion = 'CONTARLISTAPAG')
	begin		
		
	SET @CONTADOR=(SELECT COUNT(*)       
     FROM MA_MiscelaneosHeader      
     WHERE          
	     (@AplicacionCodigo is null  OR @AplicacionCodigo =''  OR  upper(AplicacionCodigo) like '%'+upper(@AplicacionCodigo)+'%')     
     and (@CodigoTabla is null  OR @CodigoTabla =''  OR  upper(CodigoTabla) like '%'+upper(@CodigoTabla)+'%')   
     and (@Compania is null OR @Compania ='' OR  upper(Compania) like '%'+upper(@Compania)+'%')          
     and (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')             
     and (@DescripcionExtranjera is null OR @DescripcionExtranjera =''  OR  upper(DescripcionExtranjera) like '%'+upper(@DescripcionExtranjera)+'%')   
      and ( @AplicacionCodigo IS NULL OR AplicacionCodigo = @AplicacionCodigo)
      and ( @CodigoTabla IS NULL OR CodigoTabla = @CodigoTabla)
      and ( @Compania IS NULL OR Compania = @Compania)        
     )  
					
		select @CONTADOR
	end
commit	 
END  




GO
/****** Object:  StoredProcedure [dbo].[SP_HeaderMiscelaneos_Lista]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_HeaderMiscelaneos_Lista]    

		@AplicacionCodigo char(2),
		@CodigoTabla varchar(10),
		@Compania char(6),
		@DescripcionLocal varchar(100),
		@DescripcionExtranjera varchar(80),
		@Estado char,
		@UltimoUsuario varchar(25),
		@UltimaFechaModif datetime,
		@Timestamp timestamp,
		@ACCION varchar(25), 		
		@INICIO   int= null,    
		@NUMEROFILAS int = null  
     
AS    
BEGIN   

 IF(@ACCION = 'LISTARPAGMAESTRO')      
 BEGIN      
	DECLARE @CONTADOR INT;
         
	SET @CONTADOR=(SELECT COUNT(*)       
     FROM MA_MiscelaneosHeader      
     WHERE          
	     (@AplicacionCodigo is null  OR @AplicacionCodigo =''  OR  upper(AplicacionCodigo) like '%'+upper(@AplicacionCodigo)+'%')     
     and (@CodigoTabla is null  OR @CodigoTabla =''  OR  upper(CodigoTabla) like '%'+upper(@CodigoTabla)+'%')   
     and (@Compania is null OR @Compania ='' OR  upper(Compania) like '%'+upper(@Compania)+'%')          
     and (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')             
     and (@DescripcionExtranjera is null OR @DescripcionExtranjera =''  OR  upper(DescripcionExtranjera) like '%'+upper(@DescripcionExtranjera)+'%')   
      and ( @AplicacionCodigo IS NULL OR AplicacionCodigo = @AplicacionCodigo)
      and ( @CodigoTabla IS NULL OR CodigoTabla = @CodigoTabla)
      and ( @Compania IS NULL OR Compania = @Compania)        
     )      
        
  SELECT    
		AplicacionCodigo,
		CodigoTabla,
		Compania,
		DescripcionLocal,
		DescripcionExtranjera,
		Estado,
		UltimoUsuario,
		UltimaFechaModif,
		Timestamp,
		ACCION       
  FROM (SELECT      
     MA_MiscelaneosHeader.*                  
      ,@CONTADOR AS Contador,      
            ROW_NUMBER() OVER (ORDER BY AplicacionCodigo ASC ) AS RowNumber          
     FROM MA_MiscelaneosHeader      
     WHERE    
	     (@AplicacionCodigo is null  OR @AplicacionCodigo =''  OR  upper(AplicacionCodigo) like '%'+upper(@AplicacionCodigo)+'%')     
     and (@CodigoTabla is null  OR @CodigoTabla =''  OR  upper(CodigoTabla) like '%'+upper(@CodigoTabla)+'%')   
     and (@Compania is null OR @Compania ='' OR  upper(Compania) like '%'+upper(@Compania)+'%')          
     and (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')             
     and (@DescripcionExtranjera is null OR @DescripcionExtranjera =''  OR  upper(DescripcionExtranjera) like '%'+upper(@DescripcionExtranjera)+'%')   
      and ( @AplicacionCodigo IS NULL OR AplicacionCodigo = @AplicacionCodigo)
      and ( @CodigoTabla IS NULL OR CodigoTabla = @CodigoTabla)
      and ( @Compania IS NULL OR Compania = @Compania)        
      ) AS LISTADO      
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR        
            RowNumber BETWEEN @Inicio  AND @NumeroFilas       
 end   
    
 else   
  if(@ACCION = 'LISTAR')      
 begin      
        
  SELECT        
		AplicacionCodigo,
		CodigoTabla,
		Compania,
		DescripcionLocal,
		DescripcionExtranjera,
		Estado,
		UltimoUsuario,
		UltimaFechaModif,
		Timestamp,
		ACCION           
     FROM MA_MiscelaneosHeader      
     WHERE        
      (@Timestamp is null OR Timestamp = @Timestamp) 
      and ( @AplicacionCodigo IS NULL OR AplicacionCodigo = @AplicacionCodigo)
      and ( @CodigoTabla IS NULL OR CodigoTabla = @CodigoTabla)
      and ( @Compania IS NULL OR Compania = @Compania)      
 end  
 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_HojaRecienNacido_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_HojaRecienNacido_FE]
	
	@IdEpisodioAtencion		bigint ,
	@UnidadReplicacion		char(4) ,
	@IdPaciente				int ,
	@EpisodioClinico		int ,
	@IdRecienNacido int,
	@NombreNacido varchar(100),
	@FechaNacimiento datetime,
	@HoraNacimiento datetime,
	@Sexo varchar (1),
	@Grupo varchar (5),
	@FactorRH varchar(5),
	@Coombs varchar(5),
	@NombrePadre varchar (100),
	@EdadPadre int,
	@NombreMadre varchar(100),
	@EdadMadre int,
	@Domicilio varchar (100),
	@Telefono varchar (100),
	@RPRFlat int,
	@RPRFecha datetime,
	@HIVFlat int,
	@HIVFecha datetime,
	@GrupoSanguineo varchar (5),
	@RH varchar(5),
	@Gravidez varchar (25),
	@Paridad varchar(25),
	@NroCesarea int,
	@FechaUltima datetime,
	@Natimuertos varchar(25),
	@Prematuros varchar (25),
	@Peso decimal,
	@Enfermedades text,
	@FUR datetime,
	@NroControl int,
	@Observaciones text,
	@NroSemana int,
	@NroDuracion int,
	@MembranasFlat int,
	@HoraDuracion datetime,
	@HoraMembranas datetime,
	@Analgesico varchar (25),
	@Anastecia varchar(25),
	@TipoParto int,
	@Posicion text,
	@Medicamentos text,
	@Placenta text,
	@Liquidos text,
	@Otros text,
	@Accion					varchar(25),
	@Version				varchar(25),
	@Estado					int,
	@UsuarioCreacion		varchar(25),
	@FechaCreacion			datetime,
	@UsuarioModificacion	varchar(25),
	@FechaModificacion		datetime

AS
BEGIN
  
 IF @ACCION ='LISTAR'  
  BEGIN  
    Select * From   dbo.SS_HC_HojaRecienNacido_FE   
    Where IdPaciente = @IdPaciente   
    and EpisodioClinico = @EpisodioClinico  
    and IdEpisodioAtencion = @IdEpisodioAtencion  
    and UnidadReplicacion = @UnidadReplicacion  
  END  
  IF @ACCION ='LISTARTOP'  
  BEGIN  	
    Select TOP 1 * From   dbo.SS_HC_HojaRecienNacido_FE   
	  inner join SS_HC_EpisodioAtencion epi on epi.IdPaciente=SS_HC_HojaRecienNacido_FE.IdPaciente 
    Where SS_HC_HojaRecienNacido_FE.IdPaciente = @IdPaciente 
	and epi.CodigoOA=  @Version
    and SS_HC_HojaRecienNacido_FE.UnidadReplicacion = @UnidadReplicacion  
    ORDER BY SS_HC_HojaRecienNacido_FE.EpisodioClinico DESC, SS_HC_HojaRecienNacido_FE.IdEpisodioAtencion DESC
  END  

END
GO
/****** Object:  StoredProcedure [dbo].[SP_Indicaciones]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE OR ALTER PROCEDURE [SP_Indicaciones]
	@UnidadReplicacion  char(4) ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@IdEpisodioAtencion  bigint ,
	@SecuenciaMedicamento  int,
	@Secuencia  int,
	@TipoRegistro  char(1) ,
	@Correlativo  int,
	@IdTipoIndicacion  int,
	@Descripcion  varchar(150) ,
	@Estado  int,
	@UsuarioCreacion  varchar(25) ,
	@FechaCreacion  datetime,
	@UsuarioModificacion  varchar(25) ,
	@FechaModificacion  datetime,
	@Accion  varchar(25) ,
	@Version  varchar(25) 
AS
BEGIN
	 SET NOCOUNT ON;
	 DECLARE @IdEpisodioAtencionId as INTEGER,@SecuenciaID as integer,
	 @EpisodioClinicoID as INTEGER, @ExisteCodigo as VARCHAR(10)
	 set @IdEpisodioAtencionId = @IdEpisodioAtencion;
	 IF @Accion = 'NUEVO'
		BEGIN
			SELECT @SecuenciaID = ISNULL(max(Secuencia),0)+1  FROM SS_HC_Indicaciones
				INSERT INTO dbo.SS_HC_Indicaciones(UnidadReplicacion, IdEpisodioAtencion, IdPaciente, 
				EpisodioClinico, SecuenciaMedicamento, Secuencia, TipoRegistro, Correlativo, 
				IdTipoIndicacion, Descripcion, Estado, UsuarioCreacion, FechaCreacion, UsuarioModificacion, 
				FechaModificacion, 		Version)
				VALUES(@UnidadReplicacion,	@IdEpisodioAtencion,	@IdPaciente,	@EpisodioClinico,	
				@SecuenciaMedicamento,	@SecuenciaID,	@TipoRegistro,	@Correlativo,	@IdTipoIndicacion,	
				@Descripcion,	@Estado,	@UsuarioCreacion,	@FechaCreacion,	@UsuarioModificacion,	
				@FechaModificacion,			@Version) 
				
			select @IdEpisodioAtencionId;
		END
		IF @Accion ='UPDATE'
			BEGIN
				UPDATE SS_HC_Indicaciones SET 	 		 
				 TipoRegistro=@TipoRegistro,	 Correlativo=@Correlativo,	 IdTipoIndicacion=@IdTipoIndicacion,	
				 Descripcion=@Descripcion,	 Estado=@Estado,	 UsuarioCreacion=@UsuarioCreacion,	 
				 FechaCreacion=@FechaCreacion,	 UsuarioModificacion=@UsuarioModificacion,	 
				 FechaModificacion=@FechaModificacion,	 
				 --Accion=@Accion,	 
				 Version=@Version
				 
				Where	IdPaciente = @IdPaciente
			 	and		EpisodioClinico =@EpisodioClinico 
				and		IdEpisodioAtencion = @IdEpisodioAtencion
				and		SecuenciaMedicamento=@SecuenciaMedicamento
				and		Secuencia=@Secuencia

				select @IdEpisodioAtencionId;
			END
		IF @Accion ='DELETE'
			BEGIN
				delete SS_HC_Indicaciones  	 		 				 
				Where	IdPaciente = @IdPaciente
			 	and		EpisodioClinico =@EpisodioClinico 
				and		IdEpisodioAtencion = @IdEpisodioAtencion
				and		SecuenciaMedicamento=@SecuenciaMedicamento
				and		Secuencia=@Secuencia

				select @IdEpisodioAtencionId;
			END
	 
END
	 	 
	 
GO
/****** Object:  StoredProcedure [dbo].[SP_IndicacionesFE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 
CREATE OR ALTER PROCEDURE [SP_IndicacionesFE]
	@UnidadReplicacion  char(4) ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@IdEpisodioAtencion  bigint ,
	@SecuenciaMedicamento  int,
	@Secuencia  int,
	@TipoRegistro  char(1) ,
	@Correlativo  int,
	@IdTipoIndicacion  int,
	@Descripcion  varchar(150) ,
	@GrupoMedicamento int,
	@Estado  int,
	@UsuarioCreacion  varchar(25) ,
	@FechaCreacion  datetime,
	@UsuarioModificacion  varchar(25) ,
	@FechaModificacion  datetime,
	@Accion  varchar(25) ,
	@Version  varchar(25) 
AS
BEGIN
	 SET NOCOUNT ON;
	 DECLARE @IdEpisodioAtencionId as INTEGER,@SecuenciaID as integer,
	 @EpisodioClinicoID as INTEGER, @ExisteCodigo as VARCHAR(10)
	 set @IdEpisodioAtencionId = @IdEpisodioAtencion;
	 IF @Accion = 'NUEVO'
		BEGIN
			SELECT @SecuenciaID = ISNULL(max(Secuencia),0)+1  FROM SS_HC_Indicaciones_FE
				INSERT INTO dbo.SS_HC_Indicaciones_FE(UnidadReplicacion, IdEpisodioAtencion, IdPaciente, 
				EpisodioClinico, SecuenciaMedicamento, Secuencia, TipoRegistro, Correlativo, 
				IdTipoIndicacion, Descripcion,GrupoMedicamento, Estado, UsuarioCreacion, FechaCreacion, UsuarioModificacion, 
				FechaModificacion, 
				--Accion, 
				Version)
				VALUES(@UnidadReplicacion,	@IdEpisodioAtencion,	@IdPaciente,	@EpisodioClinico,	
				@SecuenciaMedicamento,	@SecuenciaID,	@TipoRegistro,	@Correlativo,	@IdTipoIndicacion,	
				@Descripcion, @GrupoMedicamento,	@Estado,	@UsuarioCreacion,	@FechaCreacion,	@UsuarioModificacion,	
				@FechaModificacion,	
				--@Accion,					
				@Version
				) 
			select @IdEpisodioAtencionId;
		END
		IF @Accion ='UPDATE'
			BEGIN
				UPDATE SS_HC_Indicaciones_FE SET 	 		 
				 TipoRegistro=@TipoRegistro,	 Correlativo=@Correlativo,	 IdTipoIndicacion=@IdTipoIndicacion,	
				 Descripcion=@Descripcion,	 Estado=@Estado,	 UsuarioCreacion=@UsuarioCreacion,	 
				 FechaCreacion=@FechaCreacion,	 UsuarioModificacion=@UsuarioModificacion,	 
				 FechaModificacion=@FechaModificacion,	 
				 --Accion=@Accion,	 
				 Version=@Version
				 
				Where	IdPaciente = @IdPaciente
			 	and		EpisodioClinico =@EpisodioClinico 
				and		IdEpisodioAtencion = @IdEpisodioAtencion
				and		SecuenciaMedicamento=@SecuenciaMedicamento
				and		GrupoMedicamento=@GrupoMedicamento
				and		Secuencia=@Secuencia

				select @IdEpisodioAtencionId;
			END
		IF @Accion ='DELETE'
			BEGIN
				delete SS_HC_Indicaciones_FE	 		 				 
				Where	IdPaciente = @IdPaciente
			 	and		EpisodioClinico =@EpisodioClinico 
				and		IdEpisodioAtencion = @IdEpisodioAtencion
				and		GrupoMedicamento=@GrupoMedicamento
				and		SecuenciaMedicamento=@SecuenciaMedicamento
				and		Secuencia=@Secuencia

				select @IdEpisodioAtencionId;
			END
	 
END
	 
GO

/****** Object:  StoredProcedure [dbo].[SP_IndicacionesListarFE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 
CREATE OR ALTER PROCEDURE  [dbo].[SP_IndicacionesListarFE]
	@UnidadReplicacion  char(4) ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@IdEpisodioAtencion  bigint ,
	@SecuenciaMedicamento  int,
	@Secuencia  int,
	@TipoRegistro  char(1) ,
	@Correlativo  int,
	@IdTipoIndicacion  int,
	@Descripcion  varchar(150) ,
	@GrupoMedicamento int,
	@Estado  int,
	@UsuarioCreacion  varchar(25) ,
	@FechaCreacion  datetime,
	@UsuarioModificacion  varchar(25) ,
	@FechaModificacion  datetime,
	@Accion  varchar(25) ,
	@Version  varchar(25) 
AS
BEGIN
	 SET NOCOUNT ON;
	 DECLARE @IdEpisodioAtencionId as INTEGER,@SecuenciaID as integer,
	 @EpisodioClinicoID as INTEGER, @ExisteCodigo as VARCHAR(10)
	 if (@SecuenciaMedicamento =0)
			set @SecuenciaMedicamento = null
	 IF @Accion ='LISTAR'
			BEGIN
				SELECT * FROM SS_HC_Indicaciones_FE 
				Where	IdPaciente = @IdPaciente
			 	and		EpisodioClinico =@EpisodioClinico 
				and		IdEpisodioAtencion = @IdEpisodioAtencion
				and		( @SecuenciaMedicamento is null or SecuenciaMedicamento=@SecuenciaMedicamento)
				--and		Secuencia=@Secuencia
			END
			
			IF @Accion ='LISTARPORGRUPO'
			BEGIN
				SELECT * FROM SS_HC_Indicaciones_FE 
				Where	IdPaciente = @IdPaciente
			 	and		EpisodioClinico =@EpisodioClinico 
				and		IdEpisodioAtencion = @IdEpisodioAtencion
				and		(SecuenciaMedicamento=@SecuenciaMedicamento)
				and		GrupoMedicamento = @GrupoMedicamento
				--and		Secuencia=@Secuencia
			END
	 
END


	 
GO

/****** Object:  StoredProcedure [dbo].[SP_InterConsulta_FE_Insert]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
CREATE OR ALTER PROCEDURE [SP_InterConsulta_FE_Insert]  
 @UnidadReplicacion  char(4) ,  
 @IdEpisodioAtencion  bigint,  
 @IdPaciente  int,  
 @EpisodioClinico  int,  
 @Secuencia  int,  
 @ProximaAtencionFlag  char(1),  
 @FechaSolicitada  datetime,   
 @FechaPlaneada  datetime,  
 @IdEspecialidad  int,  
 @IdEstablecimientoSalud  int,  
 @IdTipoInterConsulta  int,  
 @IdTipoReferencia  int,  
 @Observacion  text,  
 @IdProcedimiento  int,  
 @CodigoComponente  varchar(25),  
 @TipoOrdenAtencion  int,  
 @IndicadorEPS  int,  
 @Estado  int,  
 @UsuarioCreacion  varchar(15),  
 @FechaCreacion  datetime,  
 @UsuarioModificacion  varchar(15),  
 @FechaModificacion  datetime,  
 @Accion  varchar(25),  
 @Version  varchar(25),  
 @IdPersonalSalud int,   
 @IdDiagnostico int,  
 @ProcedimientoText varchar(600),  
 @DiagnosticoText varchar(600) ,
 @IndicadorTI int,
 @CodigoOA varchar(15),
 @IdOrdenAtencion int,
 @Linea int
   
AS  
BEGIN  
 SET NOCOUNT ON;  
 
  IF @Accion = 'NUEVO'  
  BEGIN  
 DECLARE @var varchar(15)

	EXEC SP_SS_HC_Correlativo '00000000','CEG' ,'HC',@NroPeticion=@var output

    INSERT INTO SS_HC_InterConsulta_FE values(@UnidadReplicacion,@IdEpisodioAtencion,@IdPaciente,@EpisodioClinico,@Secuencia,
	@ProximaAtencionFlag,@FechaSolicitada,'1900-01-01 11:25:00.000',@IdEspecialidad,@IdEstablecimientoSalud,@IdTipoInterConsulta,@IdTipoReferencia,
	@Observacion,@IdProcedimiento,@CodigoComponente,@TipoOrdenAtencion,@IndicadorEPS,@IdPersonalSalud,@IdDiagnostico,@ProcedimientoText,
	@DiagnosticoText,@Accion,@Version,@Estado,@UsuarioCreacion,@FechaCreacion,@UsuarioModificacion,@FechaModificacion,1,@var)
  
  select 1
  END  


 IF @Accion = 'UPDATE'    
  BEGIN  
			  UPDATE SS_HC_InterConsulta_FE
			   SET 
			UnidadReplicacion=@UnidadReplicacion
			,
			IdEpisodioAtencion=@IdEpisodioAtencion,
			IdPaciente=@IdPaciente
			,
			EpisodioClinico=@EpisodioClinico,
			Secuencia=@Secuencia,
			ProximaAtencionFlag=@ProximaAtencionFlag,
			FechaSolicitada=@FechaSolicitada,
			FechaPlaneada='1900-01-01 11:25:00.000',
			IdEspecialidad=@IdEspecialidad,
			IdEstablecimientoSalud=@IdEstablecimientoSalud,
			IdTipoInterConsulta=@IdTipoInterConsulta,
			IdTipoReferencia=@IdTipoReferencia,
			Observacion=@Observacion,
			IdProcedimiento=@IdProcedimiento,
			CodigoComponente=@CodigoComponente,
			TipoOrdenAtencion=@TipoOrdenAtencion,
			IndicadorEPS=	@IndicadorEPS,
			IdPersonalSalud=	@IdPersonalSalud,
			IdDiagnostico=	@IdDiagnostico,
			ProcedimientoText=	@ProcedimientoText,
			DiagnosticoText=	@DiagnosticoText,
			Accion=	@Accion,
			Version=	@Version,
			Estado=	@Estado,
			UsuarioCreacion=	@UsuarioCreacion,
			FechaCreacion=	@FechaCreacion,
				UsuarioModificacion=@UsuarioModificacion,
			FechaModificacion=	@FechaModificacion
			,
			IndicadorTI=	1
        Where  IdPaciente = @IdPaciente
                          and          EpisodioClinico =@EpisodioClinico 
                           and          IdEpisodioAtencion = @IdEpisodioAtencion
                           and          UnidadReplicacion  = @UnidadReplicacion
                           and          Secuencia = @Secuencia

			update SS_HC_EpisodioNotificaciones_FE
			set TipoMedicamento=@CodigoComponente,
			IdEspecialidad=@IdEspecialidad,
			CodigoComponente=@CodigoComponente
			Where  IdPaciente = @IdPaciente
                          and          Linea =@Linea 
                           and          IdOrdenAtencion = @TipoOrdenAtencion
                           and          UnidadReplicacion  = @UnidadReplicacion
                           and          Tipo = @EpisodioClinico
						   and          Secuencia = @IdEpisodioAtencion

      select 1 
  END  

    
  IF @Accion ='DELETE' ---delete individual
                    BEGIN
                    
                           delete from  SS_HC_InterConsulta_FE 
                           Where  IdPaciente = @IdPaciente
                          and          EpisodioClinico =@EpisodioClinico 
                           and          IdEpisodioAtencion = @IdEpisodioAtencion
                           and          UnidadReplicacion  = @UnidadReplicacion
                           and          Secuencia = @Secuencia
                           
						   DELETE FROM SS_HC_EpisodioNotificaciones_FE
						   Where  IdPaciente = @IdPaciente
						   and          Linea =@Linea 
                           and          IdOrdenAtencion = @TipoOrdenAtencion
                           and          UnidadReplicacion  = @UnidadReplicacion
                           and          Tipo = @EpisodioClinico
						   and          Secuencia = @IdEpisodioAtencion


                           select @Secuencia;

END


   
END  
    
GO
/****** Object:  StoredProcedure [dbo].[SP_InterConsulta_FEListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE OR ALTER PROCEDURE [SP_InterConsulta_FEListar]  
 @UnidadReplicacion  char(4) ,  
 @IdEpisodioAtencion  bigint,  
 @IdPaciente  int,  
 @EpisodioClinico  int,  
 @Secuencia  int,  
 @ProximaAtencionFlag  char(1),  
 @FechaSolicitada  datetime,   
 @FechaPlaneada  datetime,  
 @IdEspecialidad  int,  
 @IdEstablecimientoSalud  int,  
 @IdTipoInterConsulta  int,  
 @IdTipoReferencia  int,  
 @Observacion  text,  
 @IdProcedimiento  int,  
 @CodigoComponente  varchar(25),  
 @TipoOrdenAtencion  int,  
 @IndicadorEPS  int,  
 @Estado  int,  
 @UsuarioCreacion  varchar(15),  
 @FechaCreacion  datetime,  
 @UsuarioModificacion  varchar(15),  
 @FechaModificacion  datetime,  
 @Accion  varchar(25),  
 @Version  varchar(25),  
 @IdPersonalSalud int,   
 @IdDiagnostico int,  
 @ProcedimientoText varchar(600),  
 @DiagnosticoText varchar(600)  
   
AS  
BEGIN  
 SET NOCOUNT ON;  
  
 DECLARE @IdEpisodioAtencionId as INTEGER,  
  @EpisodioClinicoID as INTEGER, @ExisteCodigo as VARCHAR(10),  
  @SecuenciaID as Integer  
  set @IdEpisodioAtencionId = @IdEpisodioAtencion  
    
  IF @Accion = 'LISTAR'  
  BEGIN  
    Select * From   SS_HC_InterConsulta_FE  
   Where IdPaciente = @IdPaciente   
   AND  IdEpisodioAtencion = @IdEpisodioAtencion  
   AND  EpisodioClinico= @EpisodioClinico  
  END  
    
 IF @Accion = 'LISTARZ'    
  BEGIN  
    Select * From   SS_HC_InterConsulta_FE  
   Where IdPaciente = @IdPaciente   
   AND  IdEpisodioAtencion = @IdEpisodioAtencion  
   AND  EpisodioClinico= @EpisodioClinico  
  END  
    
 IF @Accion = 'LISTARTELESALUD'    
  BEGIN  
   SELECT      SS_HC_ProximaAtencion.UnidadReplicacion,  SS_HC_ProximaAtencion.IdEpisodioAtencion,  SS_HC_ProximaAtencion.IdPaciente,   
         SS_HC_ProximaAtencion.EpisodioClinico,  SS_HC_ProximaAtencion.Secuencia,  SS_HC_ProximaAtencion.ProximaAtencionFlag,   
         SS_HC_ProximaAtencion.FechaSolicitada,  SS_HC_ProximaAtencion.FechaPlaneada,  SS_HC_ProximaAtencion.IdEspecialidad,   
         SS_HC_ProximaAtencion.IdEstablecimientoSalud,  SS_HC_ProximaAtencion.IdTipoInterConsulta,  SS_HC_ProximaAtencion.IdTipoReferencia,   
         SS_HC_ProximaAtencion.Observacion,  SS_HC_ProximaAtencion.IdProcedimiento,  SS_HC_ProximaAtencion.CodigoComponente,   
         SS_HC_ProximaAtencion.TipoOrdenAtencion,  SS_HC_ProximaAtencion.IndicadorEPS,  SS_HC_ProximaAtencion.Estado,   
         SS_HC_ProximaAtencion.UsuarioCreacion,  SS_HC_ProximaAtencion.FechaCreacion,  SS_HC_ProximaAtencion.UsuarioModificacion,   
         SS_HC_ProximaAtencion.FechaModificacion,  SS_HC_ProximaAtencion.Accion,  SS_HC_ProximaAtencion.Version,   
         SS_HC_ProximaAtencion.IdPersonalSalud,  SS_HC_ProximaAtencion.IdDiagnostico,  SS_HC_ProximaAtencion.ProcedimientoText,   
         SS_HC_ProximaAtencion.DiagnosticoText  
   FROM       SS_HC_InterConsulta_FE AS  SS_HC_ProximaAtencion-- INNER JOIN  
   WHERE  SS_HC_ProximaAtencion.IdPaciente = @IdPaciente  
    AND  SS_HC_ProximaAtencion.IdEpisodioAtencion = @IdEpisodioAtencion  
    AND  SS_HC_ProximaAtencion.EpisodioClinico= @EpisodioClinico    
  END  
  
    
END  
    
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADORECURSOS]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_LISTADORECURSOS]
	    @AplicacionCodigo  VARCHAR(2) = null ,
		@CodigoTabla  VARCHAR(10) = null ,
		@CodigoElemento  VARCHAR(10) = null ,
		@DescripcionLocal  VARCHAR(80)= null ,
		@Estado  VARCHAR(1)= null ,
		@ACCION  VARCHAR(25)  = null 
 
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE  @MA_MiscelaneosDetalle TABLE(
		AplicacionCodigo  VARCHAR(2) NULL,
		CodigoTabla  VARCHAR(10) NULL,
		Compania  VARCHAR(6) NULL,
		CodigoElemento  VARCHAR(10) NULL,
		DescripcionLocal  VARCHAR(80) NULL,
		DescripcionExtranjera  VARCHAR(80)NULL,
		ValorNumerico  float NULL,
		ValorCodigo1  VARCHAR(10) NULL,
		ValorCodigo2  VARCHAR(10) NULL,
		ValorCodigo3  VARCHAR(10) NULL,
		ValorCodigo4  VARCHAR(10) NULL,
		ValorCodigo5  VARCHAR(10) NULL,
		ValorFecha  datetime NULL,
		Estado  VARCHAR(1) NULL,
		UltimoUsuario varchar(25) null,
		UltimaFechaModif date null,
		Timestamp datetime null,
		ACCION  VARCHAR(25)  null,
		RowID INT IDENTITY(1,1) PRIMARY KEY
	)
		--SELECT * FROM dbo.MA_MiscelaneosDetalle
	DECLARE @GeneraId as INTEGER, @ExisteCodigo as VARCHAR(10)
	 IF @ACCION ='TITULO_FORM'
		BEGIN
			insert into @MA_MiscelaneosDetalle (AplicacionCodigo, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico)
            SELECT  'CG', @CodigoTabla, [VERSION], Nombre,  Estado  
			FROM          CM_CO_TablaMaestro  
			WHERE 	CM_CO_TablaMaestro.CodigoTabla = @CodigoTabla 
			AND		CM_CO_TablaMaestro.Estado = 2
			select * from @MA_MiscelaneosDetalle
		END
	 IF @ACCION ='NIVEL0'
		BEGIN
			insert into @MA_MiscelaneosDetalle (AplicacionCodigo, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico)
             SELECT  'CG', @CodigoTabla,  CM_CO_TablaMaestroConcepto.Concepto,  CM_CO_TablaMaestroConcepto.Nombre , 
                       CM_CO_TablaMaestroDetalleConcepto.IndicadorConcepto
			FROM          CM_CO_TablaMaestro INNER JOIN
							   CM_CO_TablaMaestroConcepto ON  CM_CO_TablaMaestro.IdTablaMaestro =  CM_CO_TablaMaestroConcepto.IdTablaMaestro INNER JOIN
							   CM_CO_TablaMaestroDetalle ON  CM_CO_TablaMaestro.IdTablaMaestro =  CM_CO_TablaMaestroDetalle.IdTablaMaestro INNER JOIN
							   CM_CO_TablaMaestroDetalleConcepto ON  CM_CO_TablaMaestroConcepto.IdTablaMaestro =  CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro AND 
							   CM_CO_TablaMaestroConcepto.IdConcepto =  CM_CO_TablaMaestroDetalleConcepto.IdConcepto AND 
							   CM_CO_TablaMaestroDetalle.IdCodigo =  CM_CO_TablaMaestroDetalleConcepto.IdCodigo AND 
							   CM_CO_TablaMaestroDetalle.IdTablaMaestro =  CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
			WHERE 	CM_CO_TablaMaestro.CodigoTabla = @CodigoTabla 
			AND	    CM_CO_TablaMaestroDetalle.Codigo = 	@CodigoElemento	
			AND		CM_CO_TablaMaestroDetalleConcepto.IndicadorConcepto = 1
			select * from @MA_MiscelaneosDetalle
		END 
	  
END

GO
/****** Object:  StoredProcedure [dbo].[SP_ListarAlergiaDetalle_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[SP_ListarAlergiaDetalle_FE] --'CEG',19000088,46
  @UnidadReplicacion varchar(10),
  @IdPaciente int,
  @EpisodioTriaje int 
  as
	  select UnidadReplicacion,IdPaciente,EpisodioTriaje,
	  IdTipoAlergia,DesdeCuando,TipoRegistro ,Observaciones,
	  EstudioAlegista,Dosis,Frecuencia,via,DescripcionManual , D.Descripcion as DescripcionVia,
	   case Frecuencia when '64' then 'HORA' when '65' then 'DIA' when '66' then 'SEMANA' when '67' then 'MES'  end DesFrecuencia
	  ,d2.Descripcion as DesAlergia
	  from SS_HC_Triaje_Ant_AlergiaDetalle_FE al 
	  left join  GE_VARIOS D  WITH(NOLOCK) ON D.CodigoTabla='TIPOVIA' and al.via = d.Secuencial
	  left join  GE_VARIOS D2 WITH(NOLOCK) ON D2.CodigoTabla='TIPALERGIA' and al.IdTipoAlergia = d2.Secuencial
	  where 
	  UnidadReplicacion = @UnidadReplicacion and 
	  IdPaciente = @IdPaciente and
	  EpisodioTriaje = @EpisodioTriaje
GO

/****** Object:  StoredProcedure [dbo].[SP_ListarBandejaTriajeMOD]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_ListarBandejaTriajeMOD]
@UnidadReplicacion varchar(10),
@PacienteBusqueda varchar(100),
@BusquedaDNI varchar(8),
@FechaInicio datetime,
@FechaFin datetime,
@Estado int,
@PrioridadTriaje int,
@Especialidad int,
--AUMENTADO
@CodigoHC varchar(15) ,
@UsuarioCreacion  varchar(50),
@FechaCreacion  datetime ,
@horaIngreso    datetime,
@sexo  char(1),
@Edad int 

AS
select  Et.UnidadReplicacion , 
        Et.IdPaciente , 
		p.NombreCompleto Accion ,
		Et.IdEpisodioTriaje ,
		Et.CodigoOT, 
		IdPersonalSalud  , 
		FechaAtencion , 
		Et.IdEspecialidad , 
		iSNULL(E.Nombre,'POR ASIGNAR') AS Nombre , 
		IdPrioridad , 
		FlagFirma , 
		FechaFirma,
		Et.IdMedicoFirma , 
		Et.ObservacionFirma ,		
		Et.Version,Et.Estado ,
		iSNULL(E.Nombre,'POR ASIGNAR') AS UsuarioCreacion ,
		p.Documento as UsuarioModificacion, 
		Et.FechaModificacion  from SS_HC_EpisodioTriaje Et 
		inner join PERSONAMAST p on Et.IdPaciente = p.Persona 
        left join SS_GE_Especialidad E on E.IdEspecialidad = Et.IdEspecialidad
	    where  
		(@UnidadReplicacion  is null OR Et.UnidadReplicacion = @UnidadReplicacion)
        AND (@PacienteBusqueda is null or @PacienteBusqueda='' or UPPER(p.NombreCompleto)like '%'+upper(@PacienteBusqueda)+'%')
        AND (@BusquedaDNI is null or @BusquedaDNI='' or UPPER(p.Documento)like '%'+upper(@BusquedaDNI)+'%')
        AND (@FechaInicio IS NULL OR FechaAtencion >=  @FechaInicio)
        AND (@FechaFin IS NULL OR FechaAtencion < DATEADD(DAY,1,@FechaFin))
        AND (@Estado is null or @Estado='' or UPPER(Et.Estado)like '%'+upper(@Estado)+'%')        
        AND (@PrioridadTriaje is null or @PrioridadTriaje='' or UPPER(IdPrioridad)like '%'+upper(@PrioridadTriaje)+'%')
        AND (@Especialidad is null or @Especialidad='' or UPPER(Et.IdEspecialidad)like '%'+upper(@Especialidad)+'%')
      
GO


/****** Object:  StoredProcedure [dbo].[SP_MA_MiscelaneosDetalleListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================       
-- Author:    Grace Córdova       
-- Create date: 04/08/2015
-- =============================================  
CREATE OR ALTER PROCEDURE [SP_MA_MiscelaneosDetalleListar]
  @AplicacionCodigo  VARCHAR(2) = null ,  
  @CodigoTabla  VARCHAR(20) = null ,  
  @Compania  VARCHAR(6) = null ,  
  @CodigoElemento  VARCHAR(20) = null ,  
  @DescripcionLocal  VARCHAR(80)= null ,  
  @DescripcionExtranjera  VARCHAR(80)= null ,  
  @ValorNumerico  float= null ,  
  @ValorCodigo1  VARCHAR(250)= null ,  
  @ValorCodigo2  VARCHAR(250)= null ,  
  @ValorCodigo3  VARCHAR(250)= null ,  
  @ValorCodigo4  VARCHAR(250)= null ,  
  @ValorCodigo5  VARCHAR(250)= null ,  
  @ValorFecha  datetime= null ,  
  @Estado  VARCHAR(1)= null ,  
  @ACCION  VARCHAR(50)  = null, 
@INICIO   int= null,  
@NUMEROFILAS int = null
AS
BEGIN
DECLARE  @MA_MiscelaneosDetalle TABLE(  
  AplicacionCodigo  VARCHAR(2) NULL,  
  CodigoTabla  VARCHAR(50) NULL,  
  Compania  VARCHAR(6) NULL,  
  CodigoElemento  VARCHAR(10) NULL,  
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

IF (@Accion = 'COMBOSGENERICOS')
BEGIN
IF (@CodigoTabla='TODOLUGAR')  
	BEGIN  

DECLARE @CONTADOR INT
SELECT @CONTADOR = COUNT(*)
		 from pais left join departamento
		on (departamento.Pais = pais.Pais)left join Provincia
		on (Departamento.Departamento = Provincia.Departamento)left join ZonaPostal
		on (ZonaPostal.Provincia = Provincia.Provincia)
		and (ZonaPostal.Departamento = Provincia.Departamento)
		where(@ValorCodigo1 is null or Pais.Pais = @ValorCodigo1 or @ValorCodigo1 = '')
		and  (@ValorCodigo2 is null or Departamento.Departamento = @ValorCodigo2 or @ValorCodigo2 = '')
		and  (@ValorCodigo3 is null or Provincia.Provincia = @ValorCodigo3 or @ValorCodigo3 = '')
		/**/
		insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   
		ValorCodigo1,DescripcionLocal,ValorCodigo2,DescripcionExtranjera, ValorCodigo3,
		ValorCodigo6,ValorCodigo4,ValorCodigo5) 
		select 'WA' ,'999999' ,@CodigoTabla,pais.Pais,pais.DescripcionCorta,
		departamento.Departamento,departamento.DescripcionCorta ,
		provincia.Provincia,provincia.DescripcionCorta,
		zonapostal.CodigoPostal,zonapostal.DescripcionCorta		
		 from pais left join departamento
		on (departamento.Pais = pais.Pais)left join Provincia
		on (Departamento.Departamento = Provincia.Departamento)left join ZonaPostal
		on (ZonaPostal.Provincia = Provincia.Provincia)
		and (ZonaPostal.Departamento = Provincia.Departamento)
		where(@ValorCodigo1 is null or Pais.Pais = @ValorCodigo1 or @ValorCodigo1 = '')
		and  (@ValorCodigo2 is null or Departamento.Departamento = @ValorCodigo2 or @ValorCodigo2 = '')
		and  (@ValorCodigo3 is null or Provincia.Provincia = @ValorCodigo3 or @ValorCodigo3 = '')
	select * from @MA_MiscelaneosDetalle 
		/**/
SELECT
AplicacionCodigo,
CodigoTabla,
Compania,
CodigoElemento,
DescripcionLocal,
DescripcionExtranjera,
ValorNumerico,
ValorCodigo1,
ValorCodigo2,
ValorCodigo3,
ValorCodigo4,
ValorCodigo5,
ValorFecha,
Estado,
UltimoUsuario,
UltimaFechaModif,
Timestamp,
ACCION,
RowID,
ValorEntero1,
ValorEntero2,
ValorEntero3,
ValorEntero4,
ValorEntero5,
ValorCodigo6,
ValorCodigo7,
ValorEntero6,
ValorEntero7
FROM(
 	SELECT
 	@CONTADOR AS CONTADOR,
 	ROW_NUMBER() OVER(ORDER BY CodigoTabla) AS ROWNUMBER,
 	*
 	FROM 
 	@MA_MiscelaneosDetalle
)AS LISTADO
WHERE(@INICIO IS NULL AND @NUMEROFILAS IS NULL)
OR (ROWNUMBER BETWEEN @INICIO AND @NUMEROFILAS)
	END 
	
END
END

/*
EXEC SP_ParametrosMastListar
NULL,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,NULL,NULL,
NULL,NULL,'LISTARPAG',0,15
*/

GO

/****** Object:  StoredProcedure [dbo].[SP_MiscelaneosDetalle]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_MiscelaneosDetalle]    
     @AplicacionCodigo  VARCHAR(10) = null ,-- UnidadReplica    
  @CodigoTabla  VARCHAR(30) = null ,    
  @Compania  VARCHAR(20) = null ,    
  @CodigoElemento  VARCHAR(20) = null ,    
  @DescripcionLocal  VARCHAR(250)= null ,    
      
  @DescripcionExtranjera  VARCHAR(250)= null , -- Usuario    
  @ValorNumerico  float= null ,    
  @ValorCodigo1  VARCHAR(300)= null ,    
  @ValorCodigo2  VARCHAR(300)= null ,    
  @ValorCodigo3  VARCHAR(300)= null ,    
      
  @ValorCodigo4  VARCHAR(300)= null ,    
  @ValorCodigo5  VARCHAR(300)= null ,    
  @ValorCodigo6  VARCHAR(300)= null ,    
  @ValorCodigo7  VARCHAR(300)= null ,    
  @ValorEntero1  int= null , -- IdPaciente    
      
  @ValorEntero2  int= null , -- IdClinico    
  @ValorEntero3  int= null , -- IdAtencion    
  @ValorEntero4  int= null ,    
  @ValorEntero5  int= null ,    
  @ValorEntero6  int= null ,    
      
  @ValorEntero7  int= null ,    
  @ValorFecha  datetime= null ,    
  @Estado  VARCHAR(1)= null ,    
  @ACCION  VARCHAR(50)  = null     
     
AS    
BEGIN    
 SET NOCOUNT ON;    
 DECLARE @CONTADOR INT=0    
 DECLARE @CONTADOR_AUX01 INT=0    
 DECLARE @CONTADOR_AUX02 INT=0    
 DECLARE @CONTADOR_AUX03 INT=0    
 DECLARE @CONTADOR_AUX04 INT=0    
 DECLARE @CONTADOR_AUX05 INT=0    
 DECLARE @CONTADOR_AUX06 INT=0    
 
 DECLARE @EPICLINICO_AUX INT=NULL
 DECLARE @EPIATENCION_AUX BIGINT=NULL    
      
 DECLARE @IdEpisodioAtencionId as INTEGER, @ExisteCodigo as VARCHAR(10), @IDSecuencia AS INT    
 if @CodigoElemento ='DIAGNOSTICO'    
  BEGIN    
    if @ACCION = 'NUEVO'    
    Begin    
     select @IdEpisodioAtencionId = ISNULL(max(IdEpisodioAtencion),0)+1     
      from dbo.SS_HC_EpisodioAtencion     
      where UnidadReplicacion = @AplicacionCodigo and EpisodioClinico =@ValorEntero2    
      and IdPaciente = @ValorEntero1     
          
    insert into dbo.SS_HC_EpisodioAtencion (UnidadReplicacion, IdEpisodioAtencion, UnidadReplicacionEC,     
     IdPaciente, EpisodioClinico, IdEstablecimientoSalud, IdUnidadServicio, IdPersonalSalud,     
      EpisodioAtencion, FechaRegistro, FechaAtencion, TipoAtencion, IdOrdenAtencion,     
     LineaOrdenAtencion, TipoOrdenAtencion, Estado, UsuarioCreacion, FechaCreacion,     
     UsuarioModificacion, FechaModificacion)    
     values (@AplicacionCodigo,@IdEpisodioAtencionId, @AplicacionCodigo,    
     @ValorEntero1,@ValorEntero2,1,null,2,    
      1,GETDATE(),GETDATE(),1,1,    
     1,1,2,'admin',GETDATE(),    
     'admin',GETDATE())    
       
    Select @IDSecuencia = ISNULL(max(Secuencia),0)+1  from SS_HC_Diagnostico    
    insert into dbo.SS_HC_Diagnostico(UnidadReplicacion, IdEpisodioAtencion,     
     IdPaciente, EpisodioClinico,     
     Secuencia, IdDiagnostico,IdDiagnosticoValoracion, Observacion,     
     Estado, UsuarioCreacion,     
     FechaCreacion, UsuarioModificacion, FechaModificacion, Accion, Version)    
    values (@AplicacionCodigo, @IdEpisodioAtencionId,     
     @ValorEntero1, @ValorEntero2,    
     @IDSecuencia, @ValorEntero4, @ValorEntero5,@DescripcionLocal,    
     2,@DescripcionExtranjera,     
     GETDATE(), @DescripcionExtranjera, GETDATE(), @CodigoTabla,@Compania)    
    Select @IdEpisodioAtencionId    
    End    
  END    
 if @CodigoElemento ='ANTEC_FAMILIARES'    
  BEGIN    
    if @ACCION = 'NUEVO' OR  @ACCION = 'UPDATE'     
    Begin    
    Select @IDSecuencia = ISNULL(max(Secuencia),0)+1  from SS_HC_Anamnesis_AF_Enfermedad    
    insert into  SS_HC_Anamnesis_AF_Enfermedad(UnidadReplicacion, IdPaciente, EpisodioClinico,     
      IdEpisodioAtencion, Secuencia, IdDiagnostico, Observaciones, Accion, Version )    
    values (@AplicacionCodigo, @ValorEntero1,@ValorEntero2,     
      @ValorEntero3,@IDSecuencia, @ValorEntero5, @DescripcionLocal,'CCEP0005','')     
    Select @IDSecuencia    
    End    
  END    
  else    
 if(@ACCION = 'BUSCARLINEAFAMILIA')    
 begin        
      
    DECLARE  @MA_MiscelaneosDetalleTFN TABLE(      
     AplicacionCodigo  VARCHAR(2) NULL,      
     CodigoTabla  VARCHAR(50) NULL,      
     Compania  VARCHAR(6) NULL,      
     CodigoElemento  VARCHAR(10) NULL,      
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
    
      
   begin    
   if(@CodigoTabla = 'MM000')
     insert into @MA_MiscelaneosDetalleTFN (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico,ValorCodigo1,ValorCodigo2)        
      Select   'CG','99999', Familia,SubFamilia ,   ltrim(rtrim(DescripcionLocal))+'|['+ ltrim(rtrim(Linea))+'-'+ltrim(rtrim(Familia))+'-'+ltrim(rtrim(SubFamilia))+']'         
		as nombre, '1' as  tipofolder  ,Linea,  'ITEMS'       
      From WH_ClaseSubFamilia        
      where     
			(@ValorCodigo4 is null  OR @ValorCodigo4 =''    OR  upper(Linea) = upper(@ValorCodigo4))    
		and (@ValorCodigo5 is null  OR @ValorCodigo5 =''    OR  upper(Familia) = upper(@ValorCodigo5))      
		and (@ValorCodigo2 is null  OR @ValorCodigo2 =''    OR  upper(DescripcionLocal)  like '%'+upper(@ValorCodigo2)+'%')           
		and exists(select 1 from WH_ItemMast where WH_ItemMast.Linea = WH_ClaseSubFamilia.Linea        
			 and WH_ItemMast.Familia = WH_ClaseSubFamilia.Familia        
			 and WH_ItemMast.SubFamilia = WH_ClaseSubFamilia.SubFamilia         
			 and WH_ItemMast.UnidadCodigo is not null)            
		
  insert into @MA_MiscelaneosDetalleTFN (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico,ValorCodigo1,ValorCodigo2)     

  	SELECT  distinct ''	 ,'' Compania,'' CodigoTabla, '',  
			ltrim(rtrim(DescripcionLocal))+'|['+ ltrim(rtrim(Linea))+'-'+ltrim(rtrim(Familia))+'-'+ltrim(rtrim(SubFamilia))+ '-'+LTRIM(RTRIM(Item))+']'  as DescripcionLocal 
			,'1' as  tipofolder ,''	Linea, '' ValorCodigo2
			--,WH_ItemMast.Familia,WH_ItemMast.SubFamilia		
	FROM WH_ItemMast,SS_HC_FavoritoDetalle s
				    where       
			    (@ValorCodigo4 is null  OR @ValorCodigo4 =''    OR  upper(Linea) = upper(@ValorCodigo4))      
			and (@ValorCodigo5 is null  OR @ValorCodigo5 =''    OR  upper(Familia) = upper(@ValorCodigo5))        
			and (@ValorCodigo2 is null  OR @ValorCodigo2 =''    OR  upper(DescripcionLocal)  like '%'+upper(@ValorCodigo2)+'%') 
			and (Estado ='A') --jordan mateo
   end    
      
   begin       

   insert into @MA_MiscelaneosDetalleTFN (AplicacionCodigo, Compania, ValorEntero2, CodigoTabla,ValorCodigo1,CodigoElemento , DescripcionLocal, ValorNumerico)        
   Select  'CG','99999',IdDiagnostico as ID,isnull(NombreTabla,'UN') ,isnull(CodigoPadre,'UN'), isnull(CodigoDiagnostico,'UN'), case tipofolder         
   when 1 then  ltrim(rtrim(Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),IdDiagnostico)))+']'         
   else ltrim(rtrim(Nombre)) end as nombre, tipofolder         
   From SS_GE_Diagnostico        
   where tipofolder = 1     
  and (@CodigoTabla is null or NombreTabla = @CodigoTabla)    
  and (@ValorCodigo2 is null  OR @ValorCodigo2 =''       
         OR  upper(Descripcion)  like '%'+upper(@ValorCodigo2)+'%')
   --------------------    
    
   -------------------       
        
   insert into @MA_MiscelaneosDetalleTFN (AplicacionCodigo, Compania, ValorEntero2, CodigoTabla,ValorCodigo1,   CodigoElemento , DescripcionLocal, ValorNumerico)        
   Select  'CG','99999', IdProcedimiento,isnull(NombreTabla,'UN'), isnull(CodigoPadre,'UN'),isnull(CodigoProcedimiento,'UN'),  case tipofolder         
   when 1 then  ltrim(rtrim(Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),IdProcedimiento)))+']'        
   else ltrim(rtrim(Nombre)) end as nombre,  tipofolder         
   From SS_GE_ProcedimientoMedico        
   where tipofolder = 1      
  and (@CodigoTabla is null or NombreTabla = @CodigoTabla)   
  and (@ValorCodigo2 is null  OR @ValorCodigo2 =''       
         OR  upper(Nombre)  like '%'+upper(@ValorCodigo2)+'%')    
  --------------------    
    
  -------------------         
           
   insert into @MA_MiscelaneosDetalleTFN (AplicacionCodigo, Compania, ValorEntero2, CodigoTabla,ValorCodigo1,   CodigoElemento , DescripcionLocal, ValorNumerico)        
   Select  'CG','99999', IdProcedimientoDos,isnull(NombreTabla,'UN'), isnull(CodigoPadre,'UN'),isnull(CodigoProcedimientoDos,'UN') ,  case tipofolder         
   when 1 then  ltrim(rtrim(Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),IdProcedimientoDos)))+']'        
   else ltrim(rtrim(Nombre)) end as nombre,  tipofolder         
   From SS_GE_ProcedimientoMedicoDos       
   where tipofolder = 1       
  and (@CodigoTabla is null or NombreTabla = @CodigoTabla)    
  and (@ValorCodigo2 is null  OR @ValorCodigo2 =''       
  OR  upper(Nombre)  like '%'+upper(@ValorCodigo2)+'%')   
   --------------------    
     insert into @MA_MiscelaneosDetalleTFN (AplicacionCodigo, Compania, ValorEntero2, CodigoTabla,ValorCodigo1,   CodigoElemento , DescripcionLocal, ValorNumerico)          
   Select  'CG','99999', '1','1', '1','1' , 
    ltrim(rtrim(CM_CO_Componente.Nombre))+'|['+CodigoComponente+']'         
     as nombre,  '1' AS tipofolder         
   From CM_CO_Componente         
   where /*CodigoComponente = 1         
  and*/ (@CodigoTabla is null or NombreTabla = @CodigoTabla) 
  and (@ValorCodigo2 is null  OR @ValorCodigo2 =''       
  OR  upper(Nombre)  like '%'+upper(@ValorCodigo2)+'%')  
   -------------------         
    
    
 insert into @MA_MiscelaneosDetalleTFN (AplicacionCodigo, Compania,ValorEntero2, CodigoTabla,ValorCodigo1,   CodigoElemento , DescripcionLocal, ValorNumerico)        
  Select  'CG','99999', IdCuerpoHumano,isnull(NombreTabla,'UN'), isnull(CodigoPadre,'UN'),isnull(Codigo,'UN') ,  case tipofolder         
  when 1 then  ltrim(rtrim(Descripcion))+'|['+ ltrim(rtrim(Convert(varchar(10),IdCuerpoHumano)))+']'        
  else ltrim(rtrim(Descripcion)) end as nombre,  tipofolder         
  From  SS_HC_CuerpoHumano       
  where tipofolder = 1     
  and (@CodigoTabla is null or NombreTabla = @CodigoTabla)   
  and (@ValorCodigo2 is null  OR @ValorCodigo2 =''       
  OR  upper(Descripcion)  like '%'+upper(@ValorCodigo2)+'%')  
    --------------------    

   select @CONTADOR = COUNT(*) from @MA_MiscelaneosDetalleTFN    
            
   select @CONTADOR         
   end    
            
 END 
 else    
 if(@ACCION = 'BUSCARSERVICIOSFAVORITOS')    
 begin     
    
      
    DECLARE  @MA_MiscelaneosDetalleTF TABLE(      
     AplicacionCodigo  VARCHAR(2) NULL,      
     CodigoTabla  VARCHAR(50) NULL,      
     Compania  VARCHAR(6) NULL,      
     CodigoElemento  VARCHAR(10) NULL,      
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
    
      
   begin    
     insert into @MA_MiscelaneosDetalleTF (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico,ValorCodigo1,ValorCodigo2)        
      Select   'CG','99999', Familia,SubFamilia ,   ltrim(rtrim(DescripcionLocal))+'|['+ ltrim(rtrim(Linea))+'-'+ltrim(rtrim(Familia))+'-'+ltrim(rtrim(SubFamilia))+']'         
    as nombre, '1' as  tipofolder  ,Linea,  'ITEMS'       
      From WH_ClaseSubFamilia        
      where     
     (@ValorCodigo4 is null  OR @ValorCodigo4 =''     
         OR  upper(Linea) = upper(@ValorCodigo4))    
    and (@ValorCodigo5 is null  OR @ValorCodigo5 =''     
         OR  upper(Familia) = upper(@ValorCodigo5))      
    and (@ValorCodigo2 is null  OR @ValorCodigo2 =''     
         OR  upper(DescripcionLocal) = upper(@ValorCodigo2))           
    
   end    
      
   begin       
         
   insert into @MA_MiscelaneosDetalleTF (AplicacionCodigo, Compania, ValorEntero2, CodigoTabla,ValorCodigo1,CodigoElemento , DescripcionLocal, ValorNumerico)        
   Select  'CG','99999',IdDiagnostico as ID,isnull(NombreTabla,'UN') ,isnull(CodigoPadre,'UN'), isnull(CodigoDiagnostico,'UN'), case tipofolder         
   when 1 then  ltrim(rtrim(Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),IdDiagnostico)))+']'         
   else ltrim(rtrim(Nombre)) end as nombre, tipofolder         
   From SS_GE_Diagnostico        
   where tipofolder = 1     
  and (@CodigoTabla is null or NombreTabla = @CodigoTabla)    
   --------------------    
    
   -------------------       
        
   insert into @MA_MiscelaneosDetalleTF (AplicacionCodigo, Compania, ValorEntero2, CodigoTabla,ValorCodigo1,   CodigoElemento , DescripcionLocal, ValorNumerico)        
   Select  'CG','99999', IdProcedimiento,isnull(NombreTabla,'UN'), isnull(CodigoPadre,'UN'),isnull(CodigoProcedimiento,'UN'),  case tipofolder         
   when 1 then  ltrim(rtrim(Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),IdProcedimiento)))+']'        
   else ltrim(rtrim(Nombre)) end as nombre,  tipofolder         
   From SS_GE_ProcedimientoMedico        
   where tipofolder = 1      
  and (@CodigoTabla is null or NombreTabla = @CodigoTabla)     
  --------------------    
    
  -------------------         
           
   insert into @MA_MiscelaneosDetalleTF (AplicacionCodigo, Compania, ValorEntero2, CodigoTabla,ValorCodigo1,   CodigoElemento , DescripcionLocal, ValorNumerico)        
   Select  'CG','99999', IdProcedimientoDos,isnull(NombreTabla,'UN'), isnull(CodigoPadre,'UN'),isnull(CodigoProcedimientoDos,'UN') ,  case tipofolder         
   when 1 then  ltrim(rtrim(Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),IdProcedimientoDos)))+']'        
   else ltrim(rtrim(Nombre)) end as nombre,  tipofolder         
   From SS_GE_ProcedimientoMedicoDos       
   where tipofolder = 1       
  and (@CodigoTabla is null or NombreTabla = @CodigoTabla)     
   --------------------    
    
   -------------------         
    
    
 insert into @MA_MiscelaneosDetalleTF (AplicacionCodigo, Compania,ValorEntero2, CodigoTabla,ValorCodigo1,   CodigoElemento , DescripcionLocal, ValorNumerico)        
  Select  'CG','99999', IdCuerpoHumano,isnull(NombreTabla,'UN'), isnull(CodigoPadre,'UN'),isnull(Codigo,'UN') ,  case tipofolder         
  when 1 then  ltrim(rtrim(Descripcion))+'|['+ ltrim(rtrim(Convert(varchar(10),IdCuerpoHumano)))+']'        
  else ltrim(rtrim(Descripcion)) end as nombre,  tipofolder         
  From  SS_HC_CuerpoHumano       
  where tipofolder = 1     
  and (@CodigoTabla is null or NombreTabla = @CodigoTabla)     
    --------------------    
    
    -------------------               
       
              
   select @CONTADOR = COUNT(*) from @MA_MiscelaneosDetalleTF    
            
   select @CONTADOR         
   end              
            
 END      
 ELSE IF (@ACCION = 'COMBOSGENERICOS')     
 BEGIN
	DECLARE @CONTAR INT
	SET @CONTAR =(select COUNT(*) from pais left join departamento
		on (departamento.Pais = pais.Pais)left join Provincia
		on (Departamento.Departamento = Provincia.Departamento)left join ZonaPostal
		on (ZonaPostal.Provincia = Provincia.Provincia)
		and (ZonaPostal.Departamento = Provincia.Departamento)
		where(@ValorCodigo1 is null or Pais.Pais = @ValorCodigo1 or @ValorCodigo1 = '')
		and  (@ValorCodigo2 is null or Departamento.Departamento = @ValorCodigo2 or @ValorCodigo2 = '')
		and  (@ValorCodigo3 is null or Provincia.Provincia = @ValorCodigo3 or @ValorCodigo3 = '')
		)
	SELECT @CONTAR
 END
ELSE IF (@ACCION='LISTAGENERAL')        
begin		
		set @CONTADOR = 0
		if(@CodigoTabla= 'TABLA_COMPANIA')
		begin
			Select  
			@CONTADOR = count(*)
			from companyowner 
			inner join CompaniaMast on (substring(CompaniaMast.CompaniaCodigo,1,6)=substring(companyowner.companyowner,1,6) )
			where CompaniaMast.Estado ='A'	
			and (@DescripcionLocal is null or  @DescripcionLocal =''or
					UPPER(companyowner.description ) like '%'+UPPER(@DescripcionLocal)+'%' 
			)					 			
		end  
		else if(@CodigoTabla= 'TABLA_ESTABLEC')
		begin
			Select  
			@CONTADOR = count(*)
			from CM_CO_Establecimiento 			
			where 
			(@DescripcionLocal is null or  @DescripcionLocal ='' or 
					UPPER(Descripcion) like '%'+UPPER(@DescripcionLocal)+'%' 
			)												
		end
		else if(@CodigoTabla= 'TABLA_ESPECIALIDAD')
		begin
			Select  
			@CONTADOR = count(*)
			from SS_GE_Especialidad 			
			where 
			(@DescripcionLocal is null or  @DescripcionLocal ='' or 
					UPPER(Nombre) like '%'+UPPER(@DescripcionLocal)+'%' 
			)
			
		end
		else if(@CodigoTabla= 'TABLA_AGENTE')
		begin
			Select  
			@CONTADOR = count(*)
			from SG_Agente 			
			where 
			(@DescripcionLocal is null or  @DescripcionLocal ='' or 
					UPPER(Nombre) like '%'+UPPER(@DescripcionLocal)+'%' 
			)
		end
		else if(@CodigoTabla= 'TABLA_FORMATO')
		begin
			Select  
			@CONTADOR = count(*)
			from SS_HC_Formato 			
			where 
			(@DescripcionLocal is null or  @DescripcionLocal ='' or 
					UPPER(Descripcion) like '%'+UPPER(@DescripcionLocal)+'%' 
			)
		end
		else if(@CodigoTabla= 'TABLA_SUCURSAL')
		begin
			set @DescripcionLocal=null
			
			select * from SS_HC_FormatoCodigoId
		end				
		  else if(@CodigoTabla= 'TABLA_UNIDSERVICIO')  
		  begin  
			Select  
			@CONTADOR = count(*)
			from SS_HC_UnidadServicio 			
			where 
			(@DescripcionLocal is null or  @DescripcionLocal ='' or 
					UPPER(Descripcion) like '%'+UPPER(@DescripcionLocal)+'%' 
			)	 
		  end  		
	select @CONTADOR    
end 
 if(@Accion = 'INSERTHOMOLOGACION')    
	 begin   
		if(@CodigoTabla= 'TABLA_ESPECIALIDAD')   
		begin
			insert into SS_HA_HomologacionEspecialidad 
			(IdAplicativo,Especialidad, IdEspecialidad )
			values
			(@ValorEntero3,@CodigoElemento,@ValorEntero1)
		end		
		else if(@CodigoTabla= 'TABLA_SUCURSAL')   
		begin
			insert into SS_HA_HomologacionSucursal 
			(IdAplicativo,CodigoSucursal, UnidadReplicacion )
			values
			(@ValorEntero3,@CodigoElemento,@ValorCodigo1)
		end		
		else if(@CodigoTabla= 'TABLA_PACIENTE')   
		begin
			insert into SS_HA_HomologacionPaciente
			(IdAplicativo,NumeroHHCC,DNI,IdPaciente)
			values
			(@ValorEntero3,@CodigoElemento,@ValorCodigo3,@ValorEntero1)
		end		

		else if(@CodigoTabla= 'TABLA_DIAGNOSTICO')   
		begin
			insert into SS_HA_HomologacionDiagnostico
			(IdAplicativo,CodigoDiagnostico,IdDiagnostico)
			values
			(@ValorEntero3,@CodigoElemento,@ValorEntero1)
		end					
		else if(@CodigoTabla= 'TABLA_MEDICO')   
		begin
			insert into SS_HA_HomologacionMedico
			(IdAplicativo,CodigoMedico,IdMedico)
			values
			(@ValorEntero3,@CodigoElemento,@ValorEntero1)
		end											
		else if(@CodigoTabla= 'TABLA_UNID_SERVICIO')   
		begin
			insert into SS_HA_HomologacionServicio
			(IdAplicativo,TipoServicio,IdServicio)
			values
			(@ValorEntero3,@CodigoElemento,@ValorEntero1)
		end	
				
		select 1
	 end   
 else     
 if(@Accion = 'DELETEHOMOLOGACION')    
	 begin    
		if(@CodigoTabla= 'TABLA_ESPECIALIDAD')   
		begin
			delete SS_HA_HomologacionEspecialidad 
			where
			 IdAplicativo = @ValorEntero3
			 and Especialidad = @CodigoElemento	
		end		
		else if(@CodigoTabla= 'TABLA_SUCURSAL')   
		begin
			delete SS_HA_HomologacionSucursal 
			where
			 IdAplicativo = @ValorEntero3
			 and CodigoSucursal = @CodigoElemento			 				
		end		
		else if(@CodigoTabla= 'TABLA_PACIENTE')   
		begin
			delete SS_HA_HomologacionPaciente 
			where
			 IdAplicativo = @ValorEntero3
			 and NumeroHHCC = @CodigoElemento			 				
			 and DNI = @ValorCodigo3
			 		
		end		

		else if(@CodigoTabla= 'TABLA_DIAGNOSTICO')   
		begin
			delete SS_HA_HomologacionDiagnostico 
			where
			 IdAplicativo = @ValorEntero3
			 and CodigoDiagnostico = @CodigoElemento		
			 		
		end					
		else if(@CodigoTabla= 'TABLA_MEDICO')   
		begin
			delete SS_HA_HomologacionMedico 
			where
			 IdAplicativo = @ValorEntero3
			 and CodigoMedico = @CodigoElemento				 		
		end												 	 
		else if(@CodigoTabla= 'TABLA_UNID_SERVICIO')   
		begin
			delete SS_HA_HomologacionServicio 
			where
			 IdAplicativo = @ValorEntero3
			 and TipoServicio = @CodigoElemento			 							 
					
		end		
				
		select 1
  end   	 
ELSE IF(@ACCION = 'VIRTDOCUMENT')     
	begin
		select @CONTADOR =  COUNT(*)
					 FROM  dbo.SS_HC_HistoriaAdjuntaDetalle INNER JOIN
										  dbo.SS_HC_HistoriaAdjunta ON dbo.SS_HC_HistoriaAdjuntaDetalle.UnidadReplicacion = dbo.SS_HC_HistoriaAdjunta.UnidadReplicacion AND 
										  dbo.SS_HC_HistoriaAdjuntaDetalle.IdPaciente = dbo.SS_HC_HistoriaAdjunta.IdPaciente AND 
										  dbo.SS_HC_HistoriaAdjuntaDetalle.SecuenciaInterna = dbo.SS_HC_HistoriaAdjunta.SecuenciaInterna
							
					where 
					(SS_HC_HistoriaAdjunta.UnidadReplicacion = @ValorCodigo1)  --@ValorCodigo1
					and	(SS_HC_HistoriaAdjunta.IdPaciente = @ValorCodigo2)
					and (
						( (@ValorNumerico is null or  @ValorNumerico = 0 )and SS_HC_HistoriaAdjuntaDetalle.NumeroPagina <2)
						OR
						( (@ValorNumerico is not null or  @ValorNumerico <> 0)  and SS_HC_HistoriaAdjuntaDetalle.SecuenciaInterna =@ValorNumerico)
					)				
					---FILTROS ADD
					and	(@ValorEntero1 is null or @ValorEntero1 = 0 or SS_HC_HistoriaAdjunta.TipoAtencion = @ValorEntero1)
					and	(@ValorEntero2 is null or @ValorEntero2 = 0 or SS_HC_HistoriaAdjunta.IdEspecialidad = @ValorEntero2)
					and	(@ValorEntero3 is null or @ValorEntero3 = 0 or SS_HC_HistoriaAdjunta.IdMedico = @ValorEntero3)
					and	(@ValorEntero4 is null or @ValorEntero4 = 0 or SS_HC_HistoriaAdjunta.IdUnidadServicio = @ValorEntero4)
					and	(@ValorEntero5 is null or @ValorEntero5 = 0 or SS_HC_HistoriaAdjunta.IdDiagnostico = @ValorEntero5)

		
		select @CONTADOR 
	end
	
 ELSE IF(@ACCION = 'AGRUPADOR_UBICACIONVIGENTE')     
	begin		
		set @CONTADOR_AUX01 =0
		set @CONTADOR=0
		select @CONTADOR = count(*) from dbo.SS_HC_AgrupadorAtencionVigente
		where rtrim(UnidadReplicacion) = rtrim(@Compania)
		and IdPaciente = @ValorEntero2
		and IdOrdenAtencion = convert(integer,@CodigoElemento)
		
		/**1.- Verificamos si existe algún regisgtro para la OA actual*/
		if(@CONTADOR=0 AND @ValorCodigo6='NUEVO')
		begin

			/**De no ser así, lo creamos*/						
			INSERT INTO SS_HC_AgrupadorAtencionVigente 
			(UnidadReplicacion,IdPaciente,IdOrdenAtencion,EpisodioClinico,IdEpisodioAtencion
			,IdVisitaVigente,TipoUbicacionVigente,IdUbicacionVigente,idHospitalizaciónVigente,Estado
			,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion
			) 
			VALUES 
			(convert(char(4),@Compania) ,@ValorEntero2,convert(integer,@CodigoElemento),@ValorEntero3,convert(bigint , @ValorCodigo2) ,
			convert(bigint , @ValorCodigo2) ,@ValorCodigo1,@ValorEntero1,@ValorEntero1,2,
			@ValorCodigo7,GETDATE(),@ValorCodigo7,GETDATE()						
			) 	
			
			set @CONTADOR_AUX01 =3
		end
		else
		begin
			/**SOLO ACTUALIZAR SI ES LA ÚLTIMA ATENCIÓN REALIZADA*/
			select @ValorFecha= MAX(FechaAtencion) from SS_HC_EpisodioAtencion 
			where IdPaciente =@ValorEntero2
			and UnidadReplicacion=@Compania 
			and IdOrdenAtencion=convert(integer,@CodigoElemento)	
			---
			select top 1 @EPICLINICO_AUX=EpisodioClinico,
				@EPIATENCION_AUX= IdEpisodioAtencion
				 from SS_HC_EpisodioAtencion
			where IdPaciente =@ValorEntero2
			and UnidadReplicacion=@Compania 
			and IdOrdenAtencion=convert(integer,@CodigoElemento)	
			and FechaAtencion  =  @ValorFecha
			
			/**De existir , lo actuyalizamos*/
			update SS_HC_AgrupadorAtencionVigente
			set 
			TipoUbicacionVigente = @ValorCodigo1,
			IdUbicacionVigente = @ValorEntero1,
			idHospitalizaciónVigente= @ValorEntero1,
			UsuarioModificacion = @ValorCodigo7,
			FechaModificacion= GETDATE()
			where
			UnidadReplicacion = @Compania
			and IdPaciente = @ValorEntero2
			and IdOrdenAtencion = convert(integer,@CodigoElemento)
			and EpisodioClinico=@EPICLINICO_AUX
			and IdEpisodioAtencion= @EPIATENCION_AUX
			
			
			set @CONTADOR_AUX01 =2
		end
			
			/****ACTUALIZAMOS LAS ATENCION ACTUAL  (idUbicacón  y tipo) y las VISITAS RELACIONADAS A LA OA******/			
			update SS_HC_EpisodioAtencion
			set 
			TipoUbicacion =@ValorCodigo1,
			IdUbicacion =@ValorEntero1,
			FechaModificacion = GETDATE(),
			UsuarioModificacion = @ValorCodigo7			
			where
			UnidadReplicacion = (convert(char(4),@Compania))
			and IdPaciente = @ValorEntero2
			and EpisodioClinico = @ValorEntero3
			and IdEpisodioAtencion = convert(bigint , @ValorCodigo2) 
			/****ACTUALIZAMOS ADEMÁS  (idUbicacón  y tipo) de las VISITAS RELACIONADAS A LA OA(que no posean ID UBICACION)**/
			update SS_HC_EpisodioAtencion
			set 
			TipoUbicacion =@ValorCodigo1,
			IdUbicacion =@ValorEntero1,
			FechaModificacion = GETDATE(),
			UsuarioModificacion = @ValorCodigo7			
			where
			UnidadReplicacion = (convert(char(4),@Compania))
			and IdPaciente = @ValorEntero2
			and IdOrdenAtencion = convert(integer,@CodigoElemento)
			and (IdUbicacion is null or IdUbicacion = 0 )
			and @ValorCodigo6='NUEVO'
			/*******************/		
		
		select @CONTADOR_AUX01 
	end
 
END    

GO
/****** Object:  StoredProcedure [dbo].[SP_Oftalmologico_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_Oftalmologico_FE]
@UnidadReplicacion char(4) ,
@IdEpisodioAtencion bigint,
@IdPaciente int ,
@EpisodioClinico int ,
@AVscODerecho  varchar(15),
@AVscOIzquierdo varchar(15),
@AVccODerecho varchar(15),
@AVccOIzquierdo varchar(15),
@PinHoldODerecho varchar(15),
@PinHoldOIzquierdo varchar(15),
@CercaODerecho varchar(15),
@CercaOIzquierdo varchar(15),
@RefraODerechoEsfera varchar(15),
@RefraODerechoCilindro varchar(15),
@RefraODerechoEje varchar(15),
@ScicloPejiaOIzqEsfera varchar(15),
@ScicloPejiaOIzqCilindro varchar(15),
@ScicloPejiaOIzqEje varchar(15),
@RefracODerechoAV varchar(15),
@RefracODerechoADD varchar(15),
@RefracODerechoDIP varchar(15),
@CciclopejiaOIzqAV varchar(15),
@CciclopejiaOIzqADD varchar(15),
@CciclopejiaOIzqDIP varchar(15),
@Adicion varchar(15),
@DistanciaPupilar varchar(15),
@TonShiotz varchar(15),
@TonAplanacion varchar(15),
@TonOtra varchar(15),
@TonODerecho varchar(15),
@TonOIzquierdo varchar(15),
@PaquimetriaODerecho varchar(15),
@PaquimetriaOIzquierdo varchar(15),
@CorreccionODerecho varchar(15),
@CorreccionOIzquierdo varchar(15),
@Parpados_anexos varchar(500),
@Cornea_Cristalino_Esclera varchar(500),
@Iris_Pupila varchar(100),
@FondOjo_GoniosCopia varchar(500),
@Estado int ,
@UsuarioCreacion varchar(25) ,
@FechaCreacion datetime ,
@UsuarioModificacion varchar(25),
@FechaModificacion datetime,
@Accion varchar(25),
@Version varchar(25)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @IdEpisodioAtencionId as INTEGER
	DECLARE @EpisodioClinicoID as INTEGER
	DECLARE @ExisteCodigo as VARCHAR(10)
	DECLARE @SecuenciaID as Integer
	
	SET @IdEpisodioAtencionId = @IdEpisodioAtencion

	IF @Accion ='UPDATE'  --Actualiza CABECERA
		BEGIN
				update  SS_HC_Oftalmologico_FE
				Set  
					AVscODerecho=@AVscODerecho,
					AVscOIzquierdo=@AVscOIzquierdo,
					AVccODerecho=@AVccODerecho,
					AVccOIzquierdo=@AVccOIzquierdo,
					PinHoldODerecho=@PinHoldODerecho,
					PinHoldOIzquierdo=@PinHoldOIzquierdo,
					CercaODerecho=@CercaODerecho,
					CercaOIzquierdo=@CercaOIzquierdo,
					RefraODerechoEsfera=@RefraODerechoEsfera,
					RefraODerechoCilindro=@RefraODerechoCilindro,
					RefraODerechoEje=@RefraODerechoEje,
					ScicloPejiaOIzqEsfera=@ScicloPejiaOIzqEsfera,
					ScicloPejiaOIzqCilindro=@ScicloPejiaOIzqCilindro,
					ScicloPejiaOIzqEje=@ScicloPejiaOIzqEje,
					RefracODerechoAV=@RefracODerechoAV,
					RefracODerechoADD=@RefracODerechoADD,
					RefracODerechoDIP=@RefracODerechoDIP,
					CciclopejiaOIzqAV=@CciclopejiaOIzqAV,
					CciclopejiaOIzqADD=@CciclopejiaOIzqADD,
					CciclopejiaOIzqDIP=@CciclopejiaOIzqDIP,
					Adicion=@Adicion,
					DistanciaPupilar=@DistanciaPupilar,
					TonShiotz=@TonShiotz,
					TonAplanacion=@TonAplanacion,
					TonOtra=@TonOtra,
					TonODerecho=@TonODerecho,
					TonOIzquierdo=@TonOIzquierdo,
					PaquimetriaODerecho=@PaquimetriaODerecho,
					PaquimetriaOIzquierdo=@PaquimetriaOIzquierdo,
					CorreccionODerecho=@CorreccionODerecho,
					CorreccionOIzquierdo=@CorreccionOIzquierdo,
					Parpados_anexos=@Parpados_anexos,
					Cornea_Cristalino_Esclera=@Cornea_Cristalino_Esclera,
					Iris_Pupila=@Iris_Pupila,
					FondOjo_GoniosCopia=@FondOjo_GoniosCopia,
					Estado=@Estado,
					UsuarioCreacion=@UsuarioCreacion,
					FechaCreacion=@FechaCreacion ,
					UsuarioModificacion=@UsuarioModificacion,
					FechaModificacion=@FechaModificacion,
					Accion=@Accion
				 Where  
					IdEpisodioAtencion = @IdEpisodioAtencion
					And	EpisodioClinico =@EpisodioClinico
					And	IdPaciente =@IdPaciente
				select @IdEpisodioAtencionId;
		END
				
	IF @Accion = 'NUEVO' -- Insertar Cabecera
		BEGIN
			Insert into dbo.SS_HC_Oftalmologico_FE
				(UnidadReplicacion,IdEpisodioAtencion,IdPaciente,EpisodioClinico,AVscODerecho,
				AVscOIzquierdo,AVccODerecho,AVccOIzquierdo,PinHoldODerecho,PinHoldOIzquierdo,
				CercaODerecho,CercaOIzquierdo,RefraODerechoEsfera,RefraODerechoCilindro,RefraODerechoEje,
				ScicloPejiaOIzqEsfera,ScicloPejiaOIzqCilindro,ScicloPejiaOIzqEje,RefracODerechoAV,RefracODerechoADD,
				RefracODerechoDIP,CciclopejiaOIzqAV,CciclopejiaOIzqADD,CciclopejiaOIzqDIP,Adicion,
				DistanciaPupilar,TonShiotz,TonAplanacion,TonOtra,TonODerecho,
				TonOIzquierdo,PaquimetriaODerecho,PaquimetriaOIzquierdo,CorreccionODerecho,CorreccionOIzquierdo,
				Parpados_anexos,Cornea_Cristalino_Esclera,Iris_Pupila,FondOjo_GoniosCopia,Estado,
				UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,Accion,Version)
			values 
				(@UnidadReplicacion,@IdEpisodioAtencion,@IdPaciente,@EpisodioClinico,@AVscODerecho ,
				@AVscOIzquierdo ,@AVccODerecho ,@AVccOIzquierdo ,@PinHoldODerecho ,@PinHoldOIzquierdo ,
				@CercaODerecho ,@CercaOIzquierdo ,@RefraODerechoEsfera ,@RefraODerechoCilindro ,@RefraODerechoEje ,
				@ScicloPejiaOIzqEsfera ,@ScicloPejiaOIzqCilindro ,@ScicloPejiaOIzqEje ,@RefracODerechoAV ,@RefracODerechoADD,
				@RefracODerechoDIP ,@CciclopejiaOIzqAV ,@CciclopejiaOIzqADD ,@CciclopejiaOIzqDIP ,@Adicion ,
				@DistanciaPupilar ,@TonShiotz ,@TonAplanacion ,@TonOtra ,@TonODerecho ,
				@TonOIzquierdo ,@PaquimetriaODerecho ,@PaquimetriaOIzquierdo ,@CorreccionODerecho ,@CorreccionOIzquierdo ,
				@Parpados_anexos,@Cornea_Cristalino_Esclera,@Iris_Pupila,@FondOjo_GoniosCopia,2,
				@UsuarioCreacion,	GETDATE(),@UsuarioModificacion, GETDATE(),@Accion,'CCEPF510')
 			select @IdEpisodioAtencionId;
		END
	IF @ACCION ='DELETE'  --Borrar DETALLE
		BEGIN  
    
			DELETE SS_HC_Oftalmologico_FE   
		    where 
			   IdPaciente =@IdPaciente  
			   AND  EpisodioClinico = @EpisodioClinico  
			   AND  IdEpisodioAtencion=@IdEpisodioAtencion  
			   AND UnidadReplicacion = @UnidadReplicacion
		   select @IdEpisodioAtencionId;     
		END  	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_OftalmologicoListar_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE  [dbo].[SP_OftalmologicoListar_FE]
	@UnidadReplicacion  char(4) ,
	@IdEpisodioAtencion  bigint ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@AVscODerecho  varchar(15),
	@AVscOIzquierdo varchar(15),
	@AVccODerecho varchar(15),
	@AVccOIzquierdo varchar(15),
	@PinHoldODerecho varchar(15),
	@PinHoldOIzquierdo varchar(15),
	@CercaODerecho varchar(15),
	@CercaOIzquierdo varchar(15),
	@RefraODerechoEsfera varchar(15),
	@RefraODerechoCilindro varchar(15),
	@RefraODerechoEje varchar(15),
	@ScicloPejiaOIzqEsfera varchar(15),
	@ScicloPejiaOIzqCilindro varchar(15),
	@ScicloPejiaOIzqEje varchar(15),
	@RefracODerechoAV varchar(15),
	@RefracODerechoADD varchar(15),
	@RefracODerechoDIP varchar(15),
	@CciclopejiaOIzqAV varchar(15),
	@CciclopejiaOIzqADD varchar(15),
	@CciclopejiaOIzqDIP varchar(15),
	@Adicion varchar(15),
	@DistanciaPupilar varchar(15),
	@TonShiotz varchar(15),
	@TonAplanacion varchar(15),
	@TonOtra varchar(15),
	@TonODerecho varchar(15),
	@TonOIzquierdo varchar(15),
	@PaquimetriaODerecho varchar(15),
	@PaquimetriaOIzquierdo varchar(15),
	@CorreccionODerecho varchar(15),
	@CorreccionOIzquierdo varchar(15),
	@Parpados_anexos varchar(500),
	@Cornea_Cristalino_Esclera varchar(500),
	@Iris_Pupila varchar(100),
	@FondOjo_GoniosCopia varchar(500),
	@Estado int ,
	@UsuarioCreacion  varchar(25),
	@FechaCreacion  datetime,
	@UsuarioModificacion  varchar(25),
	@FechaModificacion  datetime,
	@Accion  varchar(25),
	@Version  varchar(25)
AS
BEGIN
	 IF @Accion = 'LISTAR'
		BEGIN
		Select * From SS_HC_Oftalmologico_FE 
	Where IdPaciente = @IdPaciente   
    and EpisodioClinico = @EpisodioClinico  
    and IdEpisodioAtencion = @IdEpisodioAtencion  
    and UnidadReplicacion = @UnidadReplicacion  
  END  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_OrdenInterQuirurgicaListarFE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[SP_OrdenInterQuirurgicaListarFE]
	@UnidadReplicacion char(4),
	@IdEpisodioAtencion  bigint ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@IdCirugia int ,
	@UsuarioCreacion  varchar(25) ,
	@FechaCreacion  datetime ,
	@UsuarioModificacion  varchar(25) ,
	@FechaModificacion  datetime ,
	@Version  varchar(25),
	@Accion  varchar(25) 	
AS
BEGIN
	SET NOCOUNT ON;
	 IF @Accion ='LISTAR'
			BEGIN
				SELECT * FROM  SS_HC_OrdenIntervencionQuirurgicaCab_FE 				 
				Where	IdPaciente =@IdPaciente 
				and		EpisodioClinico = @EpisodioClinico
				and		IdEpisodioAtencion = @IdEpisodioAtencion
				and		UnidadReplicacion = @UnidadReplicacion 
			END


	IF @Accion ='LISTARDATOSEXTRAS'
			BEGIN
				SELECT UnidadReplicacion,
				IdEpisodioAtencion,
				IdPaciente,
				EpisodioClinico,
				IdCirugia,
				IdCirugia,
				CirugiaCompleja,
				DuracionAprox,
				TipoDeHospitalizacion,DiasAproximados,
				TipoAnastesia,
				NumeroAyudantes,
				NumeroInstrumentos,
				EquipoHumano,
				Comentario,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				Fechaintervencion as FechaModificacion,
				TiempoEnfermedad as Accion,
				Version,
				OrdIntNinguna,
				OrdIntOtro,
				OrdAnastesiologo
				FROM  SS_HC_OrdenIntervencionQuirurgicaCab_FE 				 
				Where	IdPaciente =@IdPaciente 
				and		EpisodioClinico = @EpisodioClinico
				and		IdEpisodioAtencion = @IdEpisodioAtencion
				and		UnidadReplicacion = @UnidadReplicacion 
			END
	 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ParametrosMast]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================         
-- Author:    Grace Córdova         
-- Create date: 04/08/2015  
-- =============================================   
CREATE OR ALTER PROCEDURE [SP_ParametrosMast]  
@CompaniaCodigo CHAR(10),  
@AplicacionCodigo CHAR(2),  
@ParametroClave CHAR(10),  
@DescripcionParametro VARCHAR(300),  
@Explicacion VARCHAR(300),  
  
@TipodeDatoFlag CHAR(1),  
@Texto CHAR(20),  
@Numero MONEY,  
@Fecha DATETIME,  
@FinanceComunFlag CHAR(1),  
  
@Estado CHAR(1),  
@UltimoUsuario VARCHAR(25),  
@UltimaFechaModif DATETIME,  
@ExplicacionAdicional VARCHAR(250),  
@Texto1 CHAR(10),  
  
@Texto2 CHAR(10),  
@UnidadReplicacion VARCHAR(4),  
@Accion VARCHAR(25),
@UsuarioCreacion VARCHAR(25),
@FechaCreacion DATETIME
AS  
BEGIN  
IF (@Accion = 'INSERT')  
BEGIN  
if(@CompaniaCodigo is null)  
set @CompaniaCodigo = '999999'  
INSERT INTO ParametrosMast  
(CompaniaCodigo,  
AplicacionCodigo,  
ParametroClave,  
DescripcionParametro,  
Explicacion,  
TipodeDatoFlag,  
Texto,  
Numero,  
Fecha,  
FinanceComunFlag,  
Estado,  
UltimoUsuario,  
UltimaFechaModif,  
ExplicacionAdicional,  
Texto1,  
Texto2,  
UnidadReplicacion,  
Accion,
UsuarioCreacion,
FechaCreacion
)VALUES(  
@CompaniaCodigo,  
@AplicacionCodigo,  
@ParametroClave,  
@DescripcionParametro,  
@Explicacion,  
@TipodeDatoFlag,  
@Texto,  
@Numero,  
@Fecha,  
@FinanceComunFlag,  
@Estado,  
@UltimoUsuario,  
GETDATE(),  
@ExplicacionAdicional,  
@Texto1,  
@Texto2,  
@UnidadReplicacion,  
@Accion,
@UsuarioCreacion,
GETDATE()
)  
 SELECT 1     
END  
ELSE IF (@Accion = 'UPDATE')  
BEGIN  
UPDATE ParametrosMast  
SET   
CompaniaCodigo=@CompaniaCodigo,  
AplicacionCodigo=@AplicacionCodigo,  
ParametroClave=@ParametroClave,  
DescripcionParametro=@DescripcionParametro,  
Explicacion=@Explicacion,  
TipodeDatoFlag=@TipodeDatoFlag,  
Texto=@Texto,  
Numero=@Numero,  
Fecha=@Fecha,  
FinanceComunFlag=@FinanceComunFlag,  
Estado=@Estado,  
UltimoUsuario=@UltimoUsuario,  
UltimaFechaModif=GETDATE(),  
ExplicacionAdicional=@ExplicacionAdicional,  
Texto1=@Texto1,  
Texto2=@Texto2,  
UnidadReplicacion=@UnidadReplicacion,  
Accion=@Accion,
UsuarioCreacion=@UsuarioCreacion
WHERE  
CompaniaCodigo=@CompaniaCodigo AND  
AplicacionCodigo=@AplicacionCodigo AND  
ParametroClave=@ParametroClave  
select 1  
END  
ELSE IF (@Accion = 'DELETE')  
BEGIN  
DELETE ParametrosMast  
WHERE  
CompaniaCodigo=@CompaniaCodigo AND  
AplicacionCodigo=@AplicacionCodigo AND  
ParametroClave=@ParametroClave  
select 1  
END  
ELSE IF (@Accion = 'LISTARPAG')  
BEGIN  
DECLARE @CONTADOR INT  
SET @CONTADOR = (SELECT COUNT(*) FROM ParametrosMast  
WHERE  
(@AplicacionCodigo is null OR AplicacionCodigo = @AplicacionCodigo)  
AND(@DescripcionParametro is null  OR @DescripcionParametro =''  OR  RTRIM(upper(DescripcionParametro)) like '%'+RTRIM(upper(@DescripcionParametro))+'%')  
AND(@ParametroClave is null  OR @ParametroClave =''  OR  RTRIM(upper(ParametroClave)) like '%'+RTRIM(upper(@ParametroClave))+'%')  
)  
  
SELECT @CONTADOR  
END  
END  
/*  
EXEC SP_ParametrosMast  
NULL,NULL,NULL,NULL,NULL,  
NULL,NULL,NULL,NULL,NULL,  
NULL,NULL,NULL,NULL,NULL,  
NULL,NULL,'LISTARPAG'  
*/

GO
/****** Object:  StoredProcedure [dbo].[SP_ParametrosMastListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================           
-- Author:    Grace Córdova           
-- Create date: 04/08/2015    
-- =============================================      
CREATE OR ALTER PROCEDURE [SP_ParametrosMastListar]    
@CompaniaCodigo CHAR(10),    
@AplicacionCodigo CHAR(2),    
@ParametroClave CHAR(10),    
@DescripcionParametro VARCHAR(300),  
@Explicacion VARCHAR(300),  
    
    
@TipodeDatoFlag CHAR(1),    
@Texto CHAR(20),    
@Numero MONEY,    
@Fecha DATETIME,    
@FinanceComunFlag CHAR(1),    
    
@Estado CHAR(1),    
@UltimoUsuario VARCHAR(25),    
@UltimaFechaModif DATETIME,    
@ExplicacionAdicional VARCHAR(250),    
@Texto1 CHAR(10),    
    
@Texto2 CHAR(10),    
@UnidadReplicacion VARCHAR(4),    
@Accion VARCHAR(25),    
@INICIO   int= null,      
@NUMEROFILAS int = null,    
@UsuarioCreacion VARCHAR(25),  
@FechaCreacion DATETIME  
AS    
BEGIN    
IF (@Accion = 'LISTARPAG')    
BEGIN    
DECLARE @CONTADOR INT    
SELECT @CONTADOR = COUNT(*) FROM ParametrosMast    
WHERE    
(@AplicacionCodigo is null OR AplicacionCodigo = @AplicacionCodigo)    
AND(@DescripcionParametro is null  OR @DescripcionParametro =''  OR  RTRIM(upper(DescripcionParametro)) like '%'+RTRIM(upper(@DescripcionParametro))+'%')         
AND(@ParametroClave is null  OR @ParametroClave =''  OR  RTRIM(upper(ParametroClave)) like '%'+RTRIM(upper(@ParametroClave))+'%')    
    
SELECT    
CompaniaCodigo,    
AplicacionCodigo,    
ParametroClave,    
DescripcionParametro,    
Explicacion,    
TipodeDatoFlag,    
Texto,    
Numero,    
Fecha,    
FinanceComunFlag,    
Estado,    
UltimoUsuario,    
UltimaFechaModif,    
ExplicacionAdicional,    
Texto1,    
Texto2,    
UnidadReplicacion,    
Accion,  
UsuarioCreacion,  
FechaCreacion    
FROM(    
SELECT    
ParametrosMast.CompaniaCodigo,    
ParametrosMast.AplicacionCodigo,    
ParametrosMast.ParametroClave,    
ParametrosMast.DescripcionParametro,    
ParametrosMast.Explicacion,    
ParametrosMast.TipodeDatoFlag,    
ParametrosMast.Texto,    
ParametrosMast.Numero,    
ParametrosMast.Fecha,    
ParametrosMast.FinanceComunFlag,    
ParametrosMast.Estado,    
ParametrosMast.UltimoUsuario,    
ParametrosMast.UltimaFechaModif,    
(select DescripcionCorta from CompaniaMast where CompaniaMast.companiacodigo = ParametrosMast.CompaniaCodigo) AS ExplicacionAdicional,
--ParametrosMast.ExplicacionAdicional,    
convert(varchar,ROW_NUMBER() OVER (ORDER BY CompaniaCodigo ASC )) as Texto1,    
ParametrosMast.Texto2,    
ParametrosMast.UnidadReplicacion,    
ParametrosMast.Accion,    
ParametrosMast.UsuarioCreacion,    
ParametrosMast.FechaCreacion,    
@CONTADOR AS CONTADOR,    
ROW_NUMBER() OVER(ORDER BY CompaniaCodigo) AS ROWNUMBER    
FROM ParametrosMast    
WHERE    
(@AplicacionCodigo is null OR AplicacionCodigo = @AplicacionCodigo)    
AND(@DescripcionParametro is null OR @DescripcionParametro ='' OR RTRIM(upper(DescripcionParametro)) like '%'+RTRIM(upper(@DescripcionParametro))+'%')    
AND(@ParametroClave is null  OR @ParametroClave =''  OR  RTRIM(upper(ParametroClave)) like '%'+RTRIM(upper(@ParametroClave))+'%')    
)AS LISTADO    
WHERE(@INICIO IS NULL AND @NUMEROFILAS IS NULL)    
OR (ROWNUMBER BETWEEN @INICIO AND @NUMEROFILAS)    
END    
ELSE IF (@Accion = 'LISTAR')    
BEGIN    
SELECT    
ParametrosMast.CompaniaCodigo,    
ParametrosMast.AplicacionCodigo,    
ParametrosMast.ParametroClave,    
ParametrosMast.DescripcionParametro,    
ParametrosMast.Explicacion,    
ParametrosMast.TipodeDatoFlag,    
ParametrosMast.Texto,    
ParametrosMast.Numero,    
ParametrosMast.Fecha,    
ParametrosMast.FinanceComunFlag,    
ParametrosMast.Estado,    
ParametrosMast.UltimoUsuario,    
ParametrosMast.UltimaFechaModif,    
ParametrosMast.ExplicacionAdicional,    
ParametrosMast.Texto1,    
ParametrosMast.Texto2,    
ParametrosMast.UnidadReplicacion,    
ParametrosMast.Accion,  
ParametrosMast.UsuarioCreacion,    
ParametrosMast.FechaCreacion    
FROM ParametrosMast    
WHERE    
(@AplicacionCodigo is null OR AplicacionCodigo = @AplicacionCodigo)    
AND (@CompaniaCodigo is null OR CompaniaCodigo = @CompaniaCodigo)    
AND (@ParametroClave is null OR ParametroClave = @ParametroClave)    
AND(@DescripcionParametro is null  OR @DescripcionParametro =''  OR  RTRIM(upper(DescripcionParametro)) like '%'+RTRIM(upper(@DescripcionParametro))+'%')    
END    
END    
    
/*    
EXEC SP_ParametrosMastListar    
NULL,NULL,NULL,NULL,NULL,    
NULL,NULL,NULL,NULL,NULL,    
NULL,NULL,NULL,NULL,NULL,    
NULL,NULL,'LISTARPAG',0,15    
*/    
GO
/****** Object:  StoredProcedure [dbo].[SP_PERSONAMAST]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE OR ALTER PROCEDURE [SP_PERSONAMAST]
	@PERSONA INT=null,
	@NOMBRECOMPLETO VARCHAR(150), 
	@ESTADO CHAR(1)	,
	@ACCION VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @GeneraId as INTEGER, @ExisteCodigo as VARCHAR(10)
	DECLARE @PERSONAMAST  TABLE  (
	[Persona] INT IDENTITY(1,1),
	[Origen] [char](4)  NULL,
	[ApellidoPaterno] [varchar](40) NULL,
	[ApellidoMaterno] [varchar](40) NULL,
	[Nombres] [varchar](40) NULL,
	[NombreCompleto] [varchar](100) NULL,
	[Busqueda] [varchar](100) NULL,
	[GrupoEmpresarial] [char](4) NULL,
	[TipoDocumento] [char](1)  NULL,
	[Documento] [char](20)  NULL,
	[CodigoBarras] [char](18) NULL,
	[EsCliente] [char](1) NULL,
	[EsProveedor] [char](1) NULL,
	[EsEmpleado] [char](1) NULL,
	[EsOtro] [char](1) NULL,
	[TipoPersona] [char](1) NULL,
	[FechaNacimiento] [datetime] NULL,
	[CiudadNacimiento] [char](20) NULL,
	[Sexo] [char](1) NULL,
	[Nacionalidad] [char](20) NULL,
	[EstadoCivil] [char](1) NULL,
	[NivelInstruccion] [char](3) NULL,
	[Direccion] [varchar](190) NULL,
	[CodigoPostal] [char](3) NULL,
	[Provincia] [char](3) NULL,
	[Departamento] [char](3) NULL,
	[Telefono] [varchar](15) NULL,
	[Fax] [varchar](15) NULL,
	[DocumentoFiscal] [char](20) NULL,
	[DocumentoIdentidad] [char](20) NULL,
	[CarnetExtranjeria] [char](10) NULL,
	[DocumentoMilitarFA] [char](10) NULL,
	[TipoBrevete] [char](1) NULL,
	[Brevete] [char](18) NULL,
	[Pasaporte] [char](18) NULL,
	[NombreEmergencia] [varchar](500) NULL,
	[DireccionEmergencia] [varchar](60) NULL,
	[TelefonoEmergencia] [varchar](15) NULL,
	[BancoMonedaLocal] [char](3) NULL,
	[TipoCuentaLocal] [char](3) NULL,
	[CuentaMonedaLocal] [char](20) NULL,
	[BancoMonedaExtranjera] [char](3) NULL,
	[TipoCuentaExtranjera] [char](3) NULL,
	[CuentaMonedaExtranjera] [char](20) NULL,
	[PersonaAnt] [char](15) NULL,
	[CorreoElectronico] [varchar](50) NULL,
	[ClasePersonaCodigo] [char](3) NULL,
	[PersonaClasificacion] [char](8) NULL,
	[EnfermedadGraveFlag] [char](1) NULL,
	[IngresoFechaRegistro] [datetime] NULL,
	[IngresoAplicacionCodigo] [char](2) NULL,
	[IngresoUsuario] [varchar](25) NULL,
	[PYMEFlag] [char](1) NULL,
	[Estado] [char](10) NULL,
	[UltimoUsuario] [varchar](25) NULL,
	[UltimaFechaModif] [datetime] NULL,
	[TipoPersonaUsuario] [char](3) NULL,
	[DireccionReferencia] [varchar](255) NULL,
	[Celular] [varchar](15) NULL,
	[ParentescoEmergencia] [char](15) NULL,
	[CelularEmergencia] [varchar](15) NULL,
	[LugarNacimiento] [varchar](255) NULL,
	[SuspensionFonaviFlag] [varchar](10) NULL,
	[FlagRepetido] [char](1) NULL,
	[CodDiscamec] [varchar](15) NULL,
	[FecIniDiscamec] [datetime] NULL,
	[FecFinDiscamec] [datetime] NULL,
	[CodLicArma] [varchar](15) NULL,
	[MarcaArma] [varchar](10) NULL,
	[SerieArma] [varchar](10) NULL,
	[InicioArma] [datetime] NULL,
	[VencimientoArma] [datetime] NULL,
	[SeguroDiscamec] [char](1) NULL,
	[CorrelativoSCTR] [varchar](3) NULL,
	[CuentaMonedaExtranjera_tmp] [char](15) NULL,
	[CuentaMonedaLocal_tmp] [char](15) NULL,
	[FlagActualizacion] [char](1) NULL,
	[TarjetadeCredito] [char](20) NULL,
	[Pais] [char](4) NULL,
	[EsPaciente] [varchar](1) NULL,
	[EsEmpresa] [varchar](1) NULL,
	[Persona_Old] [int] NULL,
	[personanew] [int] NULL,
	[cmp] [varchar](15) NULL,
	[SUNATNacionalidad] [char](6) NULL,
	[SUNATVia] [char](2) NULL,
	[SUNATZona] [char](2) NULL,
	[SUNATUbigeo] [char](10) NULL,
	[SUNATDomiciliado] [char](1) NULL,
	[IndicadorAutogenerado] [int] NULL,
	[RutaFirma] [varchar](500) NULL,
	[TipoDocumentoIdentidad] [char](1) NULL,
	[IdPersonaUnificado] [int] NULL,
	[idpersona_ok] [int] NULL,
	[edad] [int] NULL,
	[rangoEtario] [varchar](10) NULL,
	[TipoMedico] [int] NULL,
	[Correcion] [int] NULL,
	[IdEmpresaAnteriorUnificacion] [int] NULL,
	[brevete_fecvcto] [datetime] NULL,
	[carnetextranjeria_fecvcto] [datetime] NULL,
	[Estado_BK] [char](1) NULL,
	[Estado_Bks] [char](1) NULL,
	[IndicadorVinculada] [int] NULL,
	[PaisEmisor] [char](3) NULL,
	[CodigoLDN] [char](3) NULL,
	[SunatConvenio] [char](1) NULL,
	[IndicadorRegistroManual] [int] NULL,
	[IndicadorFallecido] [int] NULL,
	[IndicadorSinCorreo] [int] NULL,
	[ACCION] [varchar](25) NULL)

	 IF @ACCION ='LISTARPACIENTE'
		BEGIN			
		
			SELECT 
				PERSONAPACIENTE.Persona
				  ,PERSONAPACIENTE.Origen
				  ,PERSONAPACIENTE.ApellidoPaterno
				  ,PERSONAPACIENTE.ApellidoMaterno
				  ,PERSONAPACIENTE.Nombres
				  ,PERSONAPACIENTE.NombreCompleto
				  ,PERSONAPACIENTE.Busqueda
				  ,PERSONAPACIENTE.GrupoEmpresarial
				  ,PERSONAPACIENTE.TipoDocumento
				  ,PERSONAPACIENTE.Documento
				  ,PERSONAPACIENTE.CodigoBarras
				  ,PERSONAPACIENTE.EsCliente
				  ,PERSONAPACIENTE.EsProveedor
				  ,PERSONAPACIENTE.EsEmpleado
				  ,PERSONAPACIENTE.EsOtro
				  ,PERSONAPACIENTE.TipoPersona
				  ,PERSONAPACIENTE.FechaNacimiento
				  ,PERSONAPACIENTE.CiudadNacimiento
				  ,PERSONAPACIENTE.Sexo
				  ,PERSONAPACIENTE.Nacionalidad
				  ,PERSONAPACIENTE.EstadoCivil
				  ,PERSONAPACIENTE.NivelInstruccion
				  ,PERSONAPACIENTE.Direccion
				  ,PERSONAPACIENTE.CodigoPostal
				  ,PERSONAPACIENTE.Provincia
				  ,PERSONAPACIENTE.Departamento
				  ,PERSONAPACIENTE.Telefono
				  ,PERSONAPACIENTE.Fax
				  ,PERSONAPACIENTE.DocumentoFiscal
				  ,PERSONAPACIENTE.DocumentoIdentidad
				  ,PERSONAPACIENTE.CarnetExtranjeria
				  ,PERSONAPACIENTE.DocumentoMilitarFA
				  ,PERSONAPACIENTE.TipoBrevete
				  ,PERSONAPACIENTE.Brevete
				  ,PERSONAPACIENTE.Pasaporte
				  ,PERSONAPACIENTE.NombreEmergencia
				  ,PERSONAPACIENTE.DireccionEmergencia
				  ,PERSONAPACIENTE.TelefonoEmergencia
				  ,PERSONAPACIENTE.BancoMonedaLocal
				  ,PERSONAPACIENTE.TipoCuentaLocal
				  ,PERSONAPACIENTE.CuentaMonedaLocal
				  ,PERSONAPACIENTE.BancoMonedaExtranjera
				  ,PERSONAPACIENTE.TipoCuentaExtranjera
				  ,PERSONAPACIENTE.CuentaMonedaExtranjera
				  ,PERSONAPACIENTE.PersonaAnt
				  ,PERSONAPACIENTE.CorreoElectronico
				  ,PERSONAPACIENTE.ClasePersonaCodigo
				  ,PERSONAPACIENTE.PersonaClasificacion
				  ,PERSONAPACIENTE.EnfermedadGraveFlag
				  ,PERSONAPACIENTE.IngresoFechaRegistro
				  ,PERSONAPACIENTE.IngresoAplicacionCodigo
				  ,PERSONAPACIENTE.IngresoUsuario
				  ,PERSONAPACIENTE.PYMEFlag
				  ,PERSONAPACIENTE.Estado
				  ,PERSONAPACIENTE.UltimoUsuario
				  ,PERSONAPACIENTE.UltimaFechaModif
				  ,PERSONAPACIENTE.TipoPersonaUsuario
				  ,null as DireccionReferencia ---AUX EMPRESA ASEGURADORA
				  ,PERSONAPACIENTE.Celular
				  ,PERSONAPACIENTE.ParentescoEmergencia
				  ,PERSONAPACIENTE.CelularEmergencia
				  ,PERSONAPACIENTE.LugarNacimiento
				  ,PERSONAPACIENTE.SuspensionFonaviFlag
				  ,PERSONAPACIENTE.FlagRepetido
				  ,PERSONAPACIENTE.CodDiscamec
				  ,PERSONAPACIENTE.FecIniDiscamec
				  ,PERSONAPACIENTE.FecFinDiscamec
				  ,PERSONAPACIENTE.CodLicArma
				  ,PERSONAPACIENTE.MarcaArma
				  ,PERSONAPACIENTE.SerieArma
				  ,PERSONAPACIENTE.InicioArma
				  ,PERSONAPACIENTE.VencimientoArma
				  ,PERSONAPACIENTE.SeguroDiscamec
				  ,PERSONAPACIENTE.CorrelativoSCTR
				  ,PERSONAPACIENTE.CuentaMonedaExtranjera_tmp
				  ,PERSONAPACIENTE.CuentaMonedaLocal_tmp
				  ,PERSONAPACIENTE.FlagActualizacion
				  ,PERSONAPACIENTE.TarjetadeCredito
				  ,PERSONAPACIENTE.Pais
				  ,PERSONAPACIENTE.EsPaciente
				  ,PERSONAPACIENTE.EsEmpresa
				  ,PERSONAPACIENTE.Persona_Old
				  ,PERSONAPACIENTE.personanew
				  ,PERSONAPACIENTE.cmp
				  ,PERSONAPACIENTE.SUNATNacionalidad
				  ,PERSONAPACIENTE.SUNATVia
				  ,PERSONAPACIENTE.SUNATZona
				  ,PERSONAPACIENTE.SUNATUbigeo
				  ,PERSONAPACIENTE.SUNATDomiciliado
				  ,PERSONAPACIENTE.IndicadorAutogenerado
				  ,null as RutaFirma   --AUX TIPO PACIENTE
				  ,PERSONAPACIENTE.TipoDocumentoIdentidad
				  ,PERSONAPACIENTE.IdPersonaUnificado
				  ,PERSONAPACIENTE.idpersona_ok
				  ,PERSONAPACIENTE.edad
				  ,PERSONAPACIENTE.rangoEtario
				  ,PERSONAPACIENTE.TipoMedico
				  ,PERSONAPACIENTE.Correcion
				  ,PERSONAPACIENTE.IdEmpresaAnteriorUnificacion
				  ,PERSONAPACIENTE.brevete_fecvcto
				  ,PERSONAPACIENTE.carnetextranjeria_fecvcto
				  ,PERSONAPACIENTE.Estado_BK
				  ,PERSONAPACIENTE.Estado_Bks
				  ,PERSONAPACIENTE.IndicadorVinculada
				  ,PERSONAPACIENTE.PaisEmisor
				  ,PERSONAPACIENTE.CodigoLDN
				  ,PERSONAPACIENTE.SunatConvenio
				  ,PERSONAPACIENTE.IndicadorRegistroManual
				  ,PERSONAPACIENTE.IndicadorFallecido
				  ,PERSONAPACIENTE.IndicadorSinCorreo
				  ,PERSONAPACIENTE.ACCION			
			from(
				SELECT PERSONAMAST.*  
				FROM dbo.PERSONAMAST 
				INNER JOIN dbo.SS_GE_Paciente 
                      ON dbo.PERSONAMAST.Persona = dbo.SS_GE_Paciente.IdPaciente				
				WHERE PERSONA  = @PERSONA
			)as PERSONAPACIENTE
			
			
			
		END
							
	 IF @ACCION ='LISTAR'
		BEGIN
			insert into @PERSONAMAST(Persona_Old,	personanew,	IndicadorRegistroManual,	
					IngresoFechaRegistro,	FecIniDiscamec,	FecFinDiscamec,	CodigoLDN,	
					NombreCompleto,	Estado, 
					IndicadorFallecido, IndicadorSinCorreo)
		
			SELECT    personanew ,	Persona,	IndicadorRegistroManual,	
					IngresoFechaRegistro,	FecIniDiscamec,	FecFinDiscamec,	CodigoLDN,	
					NombreCompleto,	'Activo' as Estado, 
					SS_HC_EpisodioClinico.EpisodioClinico, SS_HC_EpisodioAtencion.IdEpisodioAtencion
			FROM       dbo.SS_HC_EpisodioClinico INNER JOIN
                      dbo.SS_HC_EpisodioAtencion ON dbo.SS_HC_EpisodioClinico.UnidadReplicacion = dbo.SS_HC_EpisodioAtencion.UnidadReplicacionEC AND 
                      dbo.SS_HC_EpisodioClinico.IdPaciente = dbo.SS_HC_EpisodioAtencion.IdPaciente AND 
                      dbo.SS_HC_EpisodioClinico.EpisodioClinico = dbo.SS_HC_EpisodioAtencion.EpisodioClinico RIGHT OUTER JOIN
                      dbo.PERSONAMAST ON dbo.SS_HC_EpisodioAtencion.IdPaciente = dbo.PERSONAMAST.Persona
		 SELECT * FROM @PERSONAMAST 
			--select * from PERSONAMAST
		END
		
	 IF @ACCION ='LISTARDIAGNOSTICO'
		BEGIN
	 
 			insert into @PERSONAMAST(Persona_Old, personanew,IdPersonaUnificado,  APELLIDOPATERNO, RUTAFIRMA,   Busqueda, FechaNacimiento, NombreEmergencia,ACCION)
 					--select 1 as persona, 'Med. Rojas' as APELLIDOPATERNO, ' Consul. Exter - ' as origen, ' k21.0 Enfermedad del Reflujo Gastro esofagoico con esofagitis' as Busqueda, getdate()-100 as FechaNacimiento
 			select EpisodioClinico,idpaciente,idEpisodioAtencion,   'Med. CALDERON RONDON, Alberto' as NombreCompleto, ' Consul. Exter - ' as RUTAFIRMA,RIGHT('0000'+CAST(Episodio_Atencion AS VARCHAR(4)),4) +'.'+RIGHT('0000'+CAST(IdEpisodioAtencion AS VARCHAR(4)),4) +' - ' + ISNULL(MotivoConsulta,'Episodio')  as MotivoConsultas,FechaCreacion, MotivoConsulta,Accion
 			 from dbo.V_EpisodioAtenciones  Where IdPaciente = @PERSONA
		    SELECT * FROM @PERSONAMAST order by FechaNacimiento
		
		END
	 IF @ACCION ='LISTARCIE10INGRESO'
		BEGIN
	                             
 			insert into @PERSONAMAST(  APELLIDOPATERNO, NOMBRECOMPLETO, TIPODOCUMENTO, DOCUMENTO, ESTADO)
			select  'A01.1' as APELLIDOPATERNO, 'FIEBRE PARATIFOIDEA A' as NOMBRECOMPLETO, 'Presuntivo' as TIPODOCUMENTO, 'Común ' as DOCUMENTO, 'Activo' as ESTADO
	 			SELECT * FROM @PERSONAMAST order by FechaNacimiento
		END 
 	SET NOCOUNT OFF;
END
GO

/****** Object:  StoredProcedure [dbo].[SP_ProximaAtencion_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE OR ALTER PROCEDURE [SP_ProximaAtencion_FE]
	@UnidadReplicacion  char(4) ,
	@IdEpisodioAtencion  bigint,
	@IdPaciente  int,
	@EpisodioClinico  int,
	@Secuencia  int,
	@ProximaAtencionFlag  char(1),
	@FechaSolicitada  datetime,
	@FechaPlaneada  datetime,
	@IdEspecialidad  int,
	@IdEstablecimientoSalud  int,
	@IdTipoInterConsulta  int,
	@IdTipoReferencia  int,
	@Observacion  text,
	@IdProcedimiento  int,
	@CodigoComponente  varchar(25),
	@TipoOrdenAtencion  int,
	@IndicadorEPS  int,
	@Estado  int,
	@UsuarioCreacion  varchar(15),
	@FechaCreacion  datetime,
	@UsuarioModificacion  varchar(15),
	@FechaModificacion  datetime,
	@Accion  varchar(25),
	@Version  varchar(25),
	@IdPersonalSalud int,
	@IdDiagnostico int,
	@ProcedimientoText varchar(600),
	@DiagnosticoText varchar(600)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @IdEpisodioAtencionId as INTEGER,
	 @EpisodioClinicoID as INTEGER, @ExisteCodigo as VARCHAR(10),
	 @SecuenciaID as Integer
	 set @IdEpisodioAtencionId = @IdEpisodioAtencion
		
	 IF @Accion = 'NUEVO'
		BEGIN
			Select @SecuenciaID =  ISNULL(max(Secuencia),0)+1 from SS_HC_ProximaAtencion_FE
			Insert into SS_HC_ProximaAtencion_FE (UnidadReplicacion, IdEpisodioAtencion, IdPaciente, 
				EpisodioClinico, Secuencia, ProximaAtencionFlag, FechaSolicitada, FechaPlaneada, 
				IdEspecialidad, IdEstablecimientoSalud, IdTipoInterConsulta, IdTipoReferencia, 
				Observacion, IdProcedimiento, CodigoComponente, TipoOrdenAtencion, IndicadorEPS, 
				Estado, UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion, 
				Accion, Version, IdPersonalSalud, ProcedimientoText, DiagnosticoText)
			values ( @UnidadReplicacion,	@IdEpisodioAtencion,	@IdPaciente,	
				@EpisodioClinico,	@SecuenciaID,	@ProximaAtencionFlag,	@FechaSolicitada,	
				@FechaPlaneada,	@IdEspecialidad,	@IdEstablecimientoSalud,	@IdTipoInterConsulta,	@IdTipoReferencia,	
				@Observacion,	@IdProcedimiento,	@CodigoComponente,	@TipoOrdenAtencion,	@IndicadorEPS,	
				2,	@UsuarioCreacion,	GETDATE(),	@UsuarioModificacion,	GETDATE(),	
				@Accion,'CCEPF152',@IdPersonalSalud,@ProcedimientoText, @DiagnosticoText)
				
				--	delete from SS_HC_ProximaAtencion
 			select @SecuenciaID;
		END
		ELSE
		IF @Accion ='UPDATE'
			BEGIN
				update  SS_HC_ProximaAtencion_FE 
				Set 	 
					ProximaAtencionFlag=@ProximaAtencionFlag,	 FechaSolicitada=@FechaSolicitada,	 
					FechaPlaneada=@FechaPlaneada,	 IdEspecialidad=@IdEspecialidad,	 
					IdEstablecimientoSalud=@IdEstablecimientoSalud,	 IdTipoInterConsulta=@IdTipoInterConsulta,	
					IdTipoReferencia=@IdTipoReferencia,	 Observacion=@Observacion,	 
					IdProcedimiento=@IdProcedimiento,	 CodigoComponente=@CodigoComponente,	 
					TipoOrdenAtencion=@TipoOrdenAtencion,	 IndicadorEPS=@IndicadorEPS,
					IdPersonalSalud  =@IdPersonalSalud ,
					--UsuarioCreacion=@UsuarioCreacion,	 					
					UsuarioModificacion=@UsuarioModificacion,	
					ProcedimientoText=@ProcedimientoText, DiagnosticoText = @DiagnosticoText ,
					FechaModificacion=GETDATE(),
					Accion=@Accion
					---Version=@Version
				 Where  IdEpisodioAtencion = @IdEpisodioAtencion
				 And	EpisodioClinico =@EpisodioClinico
				 And	IdPaciente =@IdPaciente
				 And	Secuencia =@Secuencia
				 And	UnidadReplicacion =@UnidadReplicacion
				 --And	ProximaAtencionFlag = @ProximaAtencionFlag
				 
					/*
				delete from  SS_HC_ProximaAtencionDiagnostico_FE  
				Where   IdEpisodioAtencion = @IdEpisodioAtencion
				 And	EpisodioClinico =@EpisodioClinico
				 And	IdPaciente =@IdPaciente
				 And	SecuenciaProximaAtencion = @Secuencia
				 */
				select @Secuencia;
			END
			ELSE
		IF @Accion ='DELETE'
			BEGIN
			
				delete from  SS_HC_ProximaAtencionDiagnostico_FE  
				Where   IdEpisodioAtencion = @IdEpisodioAtencion
				 And	EpisodioClinico =@EpisodioClinico
				 And	IdPaciente =@IdPaciente
				 And	SecuenciaProximaAtencion = @Secuencia
				 And	UnidadReplicacion =@UnidadReplicacion
				 
				delete  SS_HC_ProximaAtencion_FE 
				 Where  IdEpisodioAtencion = @IdEpisodioAtencion
				 And	EpisodioClinico =@EpisodioClinico
				 And	IdPaciente =@IdPaciente
				 And	Secuencia =@Secuencia
				 And	UnidadReplicacion =@UnidadReplicacion
				 --And	ProximaAtencionFlag = @ProximaAtencionFlag
			 

				 
				select @Secuencia;
			END
			ELSE			
		IF @ACCION ='DETALLE'
			BEGIN 
                                    
				Select @SecuenciaID =  ISNULL(max(Secuencia),0)+1 from dbo.SS_HC_ProximaAtencionDiagnostico_FE
				Insert Into dbo.SS_HC_ProximaAtencionDiagnostico_FE(UnidadReplicacion, IdEpisodioAtencion, 
				IdPaciente, EpisodioClinico, Secuencia, 
				SecuenciaProximaAtencion, IdDiagnostico)
				  values(@UnidadReplicacion, @IdEpisodioAtencion, 
						 @IdPaciente, @EpisodioClinico, @SecuenciaID,
						 @Secuencia, @IdProcedimiento)
				select   @Secuencia;
				--	select * from SS_HC_ProximaAtencionDiagnostico_FE
		END					
		IF @ACCION ='UPDATEDETALLE'
			BEGIN 
				--USADO AXU: @Version				
				set @SecuenciaID= CONVERT(integer, @Version)								
				update SS_HC_ProximaAtencionDiagnostico_FE
				set 																								
				IdDiagnostico = @IdProcedimiento
				Where   IdEpisodioAtencion = @IdEpisodioAtencion
				 And	EpisodioClinico =@EpisodioClinico
				 And	IdPaciente =@IdPaciente
				 And	UnidadReplicacion = @UnidadReplicacion
				 And	SecuenciaProximaAtencion = @Secuencia
				 And	Secuencia = @SecuenciaID
				 							                                    				
				select   @Secuencia;
				--	select * from SS_HC_ProximaAtencionDiagnostico_FE
			END							
		IF @ACCION ='DELETEDETALLE'
			BEGIN 
				--USADO AXU: @Version				
				set @SecuenciaID= CONVERT(integer, @Version)								
				delete SS_HC_ProximaAtencionDiagnostico_FE		
				Where   IdEpisodioAtencion = @IdEpisodioAtencion
				 And	EpisodioClinico =@EpisodioClinico
				 And	IdPaciente =@IdPaciente
				 And	UnidadReplicacion = @UnidadReplicacion
				 And	SecuenciaProximaAtencion = @Secuencia
				 And	Secuencia = @SecuenciaID
				 							                                    				
				select   @Secuencia;
				--	select * from SS_HC_ProximaAtencionDiagnostico_FE
			END	
			
		ELSE
		IF @Accion ='ASIGNARMEDICO_TS'
			BEGIN
				update  SS_HC_ProximaAtencion_FE 
				Set 	 
					IdPersonalSalud  =@IdPersonalSalud ,
					FechaPlaneada  =@FechaPlaneada,
					IdEspecialidad  =@IdEspecialidad,
					Estado  =@Estado,
					IdEstablecimientoSalud  =@IdEstablecimientoSalud,
				 					
					UsuarioModificacion=@UsuarioModificacion,						
					FechaModificacion=GETDATE()
					
					---Version=@Version
				 Where  IdEpisodioAtencion = @IdEpisodioAtencion
				 And	EpisodioClinico =@EpisodioClinico
				 And	IdPaciente =@IdPaciente
				 And	Secuencia =@Secuencia
				 And	UnidadReplicacion =@UnidadReplicacion
		 				 
				select @Secuencia;
			END
												 
END		 

GO
/****** Object:  StoredProcedure [dbo].[SP_ProximaAtencion_FEListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_ProximaAtencion_FEListar]
	@UnidadReplicacion  char(4) ,
	@IdEpisodioAtencion  bigint,
	@IdPaciente  int,
	@EpisodioClinico  int,
	@Secuencia  int,
	@ProximaAtencionFlag  char(1),
	@FechaSolicitada  datetime,	
	@FechaPlaneada  datetime,
	@IdEspecialidad  int,
	@IdEstablecimientoSalud  int,
	@IdTipoInterConsulta  int,
	@IdTipoReferencia  int,
	@Observacion  text,
	@IdProcedimiento  int,
	@CodigoComponente  varchar(25),
	@TipoOrdenAtencion  int,
	@IndicadorEPS  int,
	@Estado  int,
	@UsuarioCreacion  varchar(15),
	@FechaCreacion  datetime,
	@UsuarioModificacion  varchar(15),
	@FechaModificacion  datetime,
	@Accion  varchar(25),
	@Version  varchar(25),
	@IdPersonalSalud int, 
	@IdDiagnostico int,
	@ProcedimientoText varchar(600),
	@DiagnosticoText varchar(600)
	
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @IdEpisodioAtencionId as INTEGER,
	 @EpisodioClinicoID as INTEGER, @ExisteCodigo as VARCHAR(10),
	 @SecuenciaID as Integer
	 set @IdEpisodioAtencionId = @IdEpisodioAtencion
		
	 IF @Accion = 'LISTAR'
		BEGIN
		 	 SELECT A.*,D.Descripcion Especialidad FROM SS_HC_ProximaAtencion_FE A
			 LEFT JOIN PERSONAMAST B WITH(NOLOCK) ON B.PERSONA = A.IDPERSONALSALUD
			 LEFT JOIN SS_GE_ESPECIALIDADMEDICO C WITH(NOLOCK) ON B.PERSONA = C.IDMEDICO
			 LEFT JOIN SS_GE_ESPECIALIDAD D WITH(NOLOCK) ON C.IDESPECIALIDAD = D.IDESPECIALIDAD 
			Where	A.IdPaciente = @IdPaciente 
			AND		A.IdEpisodioAtencion = @IdEpisodioAtencion
			AND		A.EpisodioClinico= @EpisodioClinico
			--AND		ProximaAtencionFlag = @ProximaAtencionFlag
		END
		
	IF @Accion = 'LISTARZ'  
		BEGIN
		 	SELECT A.*,D.Descripcion Especialidad FROM SS_HC_ProximaAtencion_FE A
			 LEFT JOIN PERSONAMAST B WITH(NOLOCK) ON B.PERSONA = A.IDPERSONALSALUD
			 LEFT JOIN SS_GE_ESPECIALIDADMEDICO C WITH(NOLOCK) ON B.PERSONA = C.IDMEDICO
			 LEFT JOIN SS_GE_ESPECIALIDAD D WITH(NOLOCK) ON C.IDESPECIALIDAD = D.IDESPECIALIDAD 
			Where	A.IdPaciente = @IdPaciente 
			AND		A.IdEpisodioAtencion = @IdEpisodioAtencion
			AND		A.EpisodioClinico= @EpisodioClinico
			--AND		ProximaAtencionFlag IN ('H','C')
		END
		
	IF @Accion = 'LISTARTELESALUD'  
		BEGIN
			SELECT A.*,D.Descripcion Especialidad FROM SS_HC_ProximaAtencion_FE A
			 LEFT JOIN PERSONAMAST B WITH(NOLOCK) ON B.PERSONA = A.IDPERSONALSALUD
			 LEFT JOIN SS_GE_ESPECIALIDADMEDICO C WITH(NOLOCK) ON B.PERSONA = C.IDMEDICO
			 LEFT JOIN SS_GE_ESPECIALIDAD D WITH(NOLOCK) ON C.IDESPECIALIDAD = D.IDESPECIALIDAD 
			WHERE		A.IdPaciente = @IdPaciente
				AND		A.IdEpisodioAtencion = @IdEpisodioAtencion
				AND		A.EpisodioClinico= @EpisodioClinico
			--	AND		SS_HC_ProximaAtencion.ProximaAtencionFlag IN ('T')
		END
				
		--	 SELECT * FROM SS_HC_ProximaAtencionDiagnostico_FE
	 
	 
END
	 
GO

/****** Object:  StoredProcedure [dbo].[SP_Referencia_FEListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_Referencia_FEListar]
	@UnidadReplicacion  char(4) ,
	@IdEpisodioAtencion bigint,
	@IdPaciente			int,
	@EpisodioClinico	int,
	@IdReferencia       integer  ,
	@NroReferencia      varchar(25)  ,
	@Estado  int
	
AS
BEGIN
		
	SELECT * FROM   SS_HC_Referencia_FE
	WHERE	
					(@IdPaciente IS NULL OR IdPaciente = @IdPaciente)  
			  AND   (@IdEpisodioAtencion IS NULL OR IdEpisodioAtencion = @IdEpisodioAtencion) 
			  AND   (@EpisodioClinico IS NULL OR EpisodioClinico = @EpisodioClinico) 
			  AND   (@IdReferencia IS NULL OR IdReferencia = @IdReferencia)
			  AND   (@NroReferencia IS NULL OR NroReferencia = @NroReferencia) 
			  AND   (@Estado IS NULL OR Estado = @Estado) 
	 
END
	 
GO
/****** Object:  StoredProcedure [dbo].[SP_ReferenciaDetalle_FEListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_ReferenciaDetalle_FEListar]
	@UnidadReplicacion  char(4) ,
	@IdEpisodioAtencion bigint,
	@IdPaciente			int,
	@EpisodioClinico	int,
	@IdReferencia       int  ,
	@NroReferencia      varchar(25)  ,
	@IdDiagnostico		int,
	@Estado  int
	
AS
BEGIN
		
	SELECT B.*,C.CodigoDiagnostico,C.Nombre  FROM   SS_HC_Referencia_FE A WITH(NOLOCK)
	INNER JOIN SS_HC_ReferenciaDetalle_FE B WITH(NOLOCK) ON A.IdPaciente = B.IdPaciente AND
	A.IdEpisodioAtencion = B.IdEpisodioAtencion AND A.EpisodioClinico = B.EpisodioClinico
	AND A.IdReferencia = B.IdReferencia
	INNER JOIN SS_GE_Diagnostico C WITH(NOLOCK) ON B.IdDiagnostico=C.IdDiagnostico 
	WHERE	
					(@IdPaciente IS NULL OR A.IdPaciente = @IdPaciente)  
			  AND   (@IdEpisodioAtencion IS NULL OR A.IdEpisodioAtencion = @IdEpisodioAtencion) 
			  AND   (@EpisodioClinico IS NULL OR A.EpisodioClinico = @EpisodioClinico) 
			  AND   (@IdReferencia IS NULL OR A.IdReferencia = @IdReferencia)
			  AND   (@NroReferencia IS NULL OR A.NroReferencia = @NroReferencia)
			  AND   (@IdDiagnostico IS NULL OR C.IdDiagnostico = @IdDiagnostico) 
			  AND   (@Estado IS NULL OR C.Estado = @Estado) 
	 
END

	 
GO
/****** Object:  StoredProcedure [dbo].[SP_SEGURIDADAUTORIZACIONES]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SEGURIDADAUTORIZACIONES]	
	@APLICACIONCODIGO	CHAR(30)=null,
	@GRUPO	CHAR(20)=null,
	@CONCEPTO	CHAR(20)=null,		
	@USUARIO	varchar(30)=null,
	@OPCIONAGREGARFLAG	char(1)=NULL,
	@OPCIONMODIFICARFLAG	char(1)=NULL,
	@OPCIONBORRARFLAG	char(1)=NULL,
	@OPCIONAPROBARFLAG	char(1)=NULL,
	@ESTADO	char(1)	=null,		
	@ULTIMOUSUARIO	varchar(25)	=null,	
	@ULTIMAFECHAMODIF	datetime=null,
			
	@ACCION CHAR(30)=null
 	/*

exec SP_SEGURIDADCONCEPTO 'CONCEPTOPADREHCE',null,NULL,'CCEP0002',null

*/
AS
BEGIN
SET NOCOUNT ON;
BEGIN  TRANSACTION
	declare @contador int =0
	 IF @ACCION ='INSERT' ---OBS SEGURIDADA
		BEGIN

			delete SEGURIDADAUTORIZACIONES
			where 
			APLICACIONCODIGO = @APLICACIONCODIGO
			and GRUPO=@GRUPO 	
			and CONCEPTO = @CONCEPTO
			and USUARIO = @USUARIO
			
			----insertt
			insert into 	
			SEGURIDADAUTORIZACIONES
			(
				APLICACIONCODIGO
				,GRUPO
				,CONCEPTO
				,USUARIO
				,OPCIONAGREGARFLAG
				,OPCIONMODIFICARFLAG
				,OPCIONBORRARFLAG
				,OPCIONAPROBARFLAG
				,ESTADO
				,ULTIMOUSUARIO
				,ULTIMAFECHAMODIF
						
			)
			values
			(
				@APLICACIONCODIGO,
				@GRUPO,
				@CONCEPTO,
				@USUARIO,
				@OPCIONAGREGARFLAG,
				@OPCIONMODIFICARFLAG,
				@OPCIONBORRARFLAG,
				@OPCIONAPROBARFLAG,
				@ESTADO,
				@ULTIMOUSUARIO,
				GETDATE()				
			
			)
			
		select 1	
						
		END	
	ELSE	
	 IF @ACCION ='UPDATE' ---OBS SEGURIDADA
		BEGIN
			select 1			
						
		END		
	ELSE
	 IF @ACCION ='DELETE' ---OBS SEGURIDADA
		BEGIN
			delete SEGURIDADAUTORIZACIONES
			where 
			APLICACIONCODIGO = @APLICACIONCODIGO
			and GRUPO=@GRUPO 	
			and CONCEPTO = @CONCEPTO
			and USUARIO = @USUARIO			
		
			select 1			
						
		END		
	ELSE
	 IF @ACCION ='DELETEUSUARIO' ---OBS SEGURIDADA
		BEGIN
			delete SEGURIDADAUTORIZACIONES
			where 
			APLICACIONCODIGO = @APLICACIONCODIGO
			and USUARIO = @USUARIO
					
			select 1			
						
		END				
commit

END
/*

	*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SEGURIDADAUTORIZACIONES_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*

exec SP_SEGURIDADCONCEPTO 'CONCEPTOPADREHCE',null,NULL,'CCEP0002',null

*/
CREATE OR ALTER PROCEDURE [SP_SEGURIDADAUTORIZACIONES_LISTAR]	
	@APLICACIONCODIGO CHAR(30)=null,
	@GRUPO		CHAR(20)=null,
	@CONCEPTO	CHAR(20)=null,		
	@USUARIO	varchar(30)=null,
	@ESTADO			char(1)	=null,	
	
	@ACCION CHAR(30)=null
 	
AS
BEGIN
	
	 IF @ACCION ='CONCEPTOSSEGURIDADPADRE' ---OBS SEGURIDADA
		BEGIN
		
				select distinct SegAut.* from SEGURIDADAUTORIZACIONES SegAut
				inner join SEGURIDADCONCEPTO	segConcepto  on 
					(SegAut.APLICACIONCODIGO = segConcepto.APLICACIONCODIGO
					and SegAut.GRUPO = segConcepto.GRUPO
					and SegAut.CONCEPTO = segConcepto.CONCEPTO
					)
				where segConcepto.GRUPO=@GRUPO 	
				and CONCEPTOPADRE = @CONCEPTO and SegAut.ESTADO = 'A'
				and SegAut.USUARIO in (
						select PERFIL from SEGURIDADPERFILUSUARIO where USUARIO = @USUARIO  					
						union select @USUARIO)			
						
		END	
	ELSE	
	 IF @ACCION ='CONCEPTOSSEGURIDADAPP' ---OBS SEGURIDADA
		BEGIN
				select distinct SegAut.* from SEGURIDADAUTORIZACIONES SegAut
				inner join SEGURIDADCONCEPTO	segConcepto  on 
					(SegAut.APLICACIONCODIGO = segConcepto.APLICACIONCODIGO
					and SegAut.GRUPO = segConcepto.GRUPO
					and SegAut.CONCEPTO = segConcepto.CONCEPTO
					)
				where 
				 SegAut.ESTADO = 'A'
				 and (@CONCEPTO is null or @CONCEPTO = '' or SegAut.CONCEPTO = @CONCEPTO )
				and SegAut.USUARIO in (
						select PERFIL from SEGURIDADPERFILUSUARIO where USUARIO = @USUARIO					
						union select @USUARIO)	
		END		

END

GO
/****** Object:  StoredProcedure [dbo].[SP_SEGURIDADCONCEPTO]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*

exec SP_SEGURIDADCONCEPTO 'CONCEPTOPADREHCE',null,NULL,'CCEP0002',null

*/
CREATE OR ALTER PROCEDURE [SP_SEGURIDADCONCEPTO]
	@ACCION CHAR(30)=null,
	@APLICACIONCODIGO CHAR(30)=null,
	@GRUPO		CHAR(20)=null,
	@CONCEPTO	CHAR(20)=null,
	@CONCEPTOPADRE	CHAR(20)=null,
	@ULTIMOUSUARIO	varchar(30)=null,
	@ESTADO			char(1)	=null
 	
AS
BEGIN
	IF @ACCION ='LISTARMENU'
		BEGIN
			SELECT * FROM  SEGURIDADCONCEPTO -- WHERE CONCEPTOPADRE = @CONCEPTO
		END
	ELSE	
	IF @ACCION ='LISTARMENU'
		BEGIN
			SELECT * FROM  SEGURIDADCONCEPTO -- WHERE CONCEPTOPADRE = @CONCEPTO
		END
	ELSE	
	 IF @ACCION ='CONCEPTO'
		BEGIN
			SELECT * FROM  SEGURIDADCONCEPTO 
						WHERE   CONCEPTOPADRE is null
						AND		GRUPO =  @GRUPO
						and		TipodeDetalle = '9'
		END
	ELSE
	 IF @ACCION ='CONCEPTOPADRE'
		BEGIN
			SELECT * FROM  SEGURIDADCONCEPTO 
						WHERE   CONCEPTOPADRE = @CONCEPTO
		END
	ELSE
	 IF @ACCION ='CONCEPTOPADREHCE' ---OBS SEGURIDADA
		BEGIN
				  --ANTERIOR
				/*SELECT * FROM  SEGURIDADCONCEPTO 
							WHERE	GRUPO	= 	@GRUPO       
							AND		CONCEPTOPADRE = @CONCEPTOPADRE
							AND		ESTADO = 'A'
							
				
				*/
			
				select distinct segConcepto.* from SEGURIDADCONCEPTO	segConcepto
				left join SEGURIDADAUTORIZACIONES SegAut on 
					(SegAut.APLICACIONCODIGO = segConcepto.APLICACIONCODIGO
					and SegAut.GRUPO = segConcepto.GRUPO
					and SegAut.CONCEPTO = segConcepto.CONCEPTO
					)
				where segConcepto.GRUPO=@GRUPO 	
				and segConcepto.VISIBLEFLAG= 'S'
				and CONCEPTOPADRE = @CONCEPTOPADRE and segConcepto.ESTADO = 'A'
				and SegAut.USUARIO in (
						--OBS:APPCODIGO, usado auxiliarmente
						select PERFIL from SEGURIDADPERFILUSUARIO where USUARIO = @APLICACIONCODIGO  					
						union select @APLICACIONCODIGO)			
						
		END	
	ELSE	
	 IF @ACCION ='CONCEPTOPADREHCERIGTH'
		BEGIN
			SELECT * FROM  SEGURIDADCONCEPTO 
						WHERE	GRUPO	= 	@GRUPO     
						AND		CONCEPTOPADRE = @CONCEPTOPADRE 
						AND		ESTADO = 'A'
			ORDER BY DESCRIPCION
		END	
									
	 IF @ACCION ='REGISROPAGINAS'
		BEGIN
			SELECT * FROM  SEGURIDADCONCEPTO WHERE  GRUPO = @GRUPO
											 AND (NOT CONCEPTOPADRE IS NULL)
											 AND (@CONCEPTO IS NULL OR ltrim(DESCRIPCION) LIKE  '%'+@CONCEPTO+'%')
		END
	ELSE
	 IF @ACCION ='CONCEPTOSSEGURIDADAPP' ---OBS SEGURIDAD, lista todos LOS CONCEPTOS, de acuerdo al usuario
		BEGIN
				select distinct segConcepto.* from SEGURIDADCONCEPTO	segConcepto
				inner join SEGURIDADAUTORIZACIONES SegAut on 
					(SegAut.APLICACIONCODIGO = segConcepto.APLICACIONCODIGO
					and SegAut.GRUPO = segConcepto.GRUPO
					and SegAut.CONCEPTO = segConcepto.CONCEPTO
					)
				where 
				--segConcepto.GRUPO=@GRUPO 	
				--and CONCEPTOPADRE = @CONCEPTOPADRE 
				 segConcepto.ESTADO = 'A'
				 and segConcepto.VISIBLEFLAG= 'S'
				and SegAut.USUARIO in (
						--OBS:APPCODIGO, usado auxiliarmente
						select PERFIL from SEGURIDADPERFILUSUARIO where USUARIO = @ULTIMOUSUARIO					
						union select @ULTIMOUSUARIO)			
						
		END		
	else
	 IF @ACCION ='GRUPOSEGURIDAD'
		BEGIN	
		/*	
			SELECT 
				SEGURIDADGRUPO.APLICACIONCODIGO,			
				SEGURIDADGRUPO.GRUPO,
				SEGURIDADCONCEPTO.DESCRIPCION,
				SEGURIDADGRUPO.ULTIMOUSUARIO,
				SEGURIDADGRUPO.ULTIMAFECHAMODIF,
				SEGURIDADGRUPO.ESTADO,
				SEGURIDADGRUPO.SETCOLUMMENU,
				SEGURIDADGRUPO.SETFILAMENU,
				SEGURIDADCONCEPTO.CONCEPTO as ACCION  --AUXILIAR
			FROM  
			dbo.SEGURIDADGRUPO 
			inner join SEGURIDADCONCEPTO on (SEGURIDADCONCEPTO.GRUPO = SEGURIDADGRUPO.GRUPO
				and SEGURIDADCONCEPTO.APLICACIONCODIGO=SEGURIDADGRUPO.APLICACIONCODIGO 
				and CONCEPTOPADRE is null)
			WHERE	SEGURIDADGRUPO.APLICACIONCODIGO = @APLICACIONCODIGO
			AND		SEGURIDADGRUPO.ESTADO = 'A'
			*/
			SELECT 
				SEGURIDADCONCEPTO.*
			FROM  
			SEGURIDADCONCEPTO 			
			inner join SEGURIDADGRUPO on (SEGURIDADCONCEPTO.GRUPO = SEGURIDADGRUPO.GRUPO
				and SEGURIDADCONCEPTO.APLICACIONCODIGO=SEGURIDADGRUPO.APLICACIONCODIGO 
				and CONCEPTOPADRE is null)
			WHERE	SEGURIDADGRUPO.APLICACIONCODIGO = @APLICACIONCODIGO
			AND		SEGURIDADGRUPO.ESTADO = 'A'	
								
			--order by grupo desc
			--select * from SEGURIDADCONCEPTO
			
		END	
		ELSE
	 IF @ACCION ='CONCEPTOSSEGURIDADPROC' ---OBS SEGURIDAD, lista LOS CONCEPTOS rel. a PROCESOS, de acuerdo al usuario
		BEGIN
			
				select distinct segConcepto.* from SEGURIDADCONCEPTO	segConcepto
				inner join SEGURIDADAUTORIZACIONES SegAut on 
					(SegAut.APLICACIONCODIGO = segConcepto.APLICACIONCODIGO
					and SegAut.GRUPO = segConcepto.GRUPO
					and SegAut.CONCEPTO = segConcepto.CONCEPTO
					)
				where 
				segConcepto.GRUPO='GRUPO018'  --OBS HARD CODE
				--and CONCEPTOPADRE = @CONCEPTOPADRE 
				and  segConcepto.ESTADO = 'A'
				and SegAut.USUARIO in (
						--OBS:APPCODIGO, usado auxiliarmente
						select PERFIL from SEGURIDADPERFILUSUARIO where USUARIO = @ULTIMOUSUARIO					
						union select @ULTIMOUSUARIO)			
						
		END		
		ELSE
		 IF @ACCION ='CONCEPTOFORMPORID'
			BEGIN
				--select * from CM_CO_TablaMaestro
			
			
				SELECT * FROM  SEGURIDADCONCEPTO  
							WHERE   
							APLICACIONCODIGO = @APLICACIONCODIGO
							and GRUPO =@GRUPO
							and CONCEPTO = @CONCEPTO
			END
	
--select * from SEGURIDADCONCEPTO
--select * from SEGURIDADAUTORIZACIONES where USUARIO='SEGURIDAD'
--select * from SEGURIDADPERFILUSUARIO
END
/*
exec SP_SEGURIDADCONCEPTO
	'CONCEPTOSSEGURIDADAPP',
	'MISESF',
	'GRUPO017',
	null,
	'CCEP0001',
	'SEGURIDAD',
	null
	
	*/
	
	
GO
/****** Object:  StoredProcedure [dbo].[SP_SEGURIDADCONCEPTOLISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SEGURIDADCONCEPTOLISTAR]
           @APLICACIONCODIGO char(2),
           @GRUPO char(15),
           @CONCEPTO char(15),
           @CONCEPTOPADRE char(15),
           @IDPAGINA int,
           @DESCRIPCION varchar(3000),
           @DESCRIPCIONINGLES varchar(3000),
           @VISIBLEFLAG char(1),
           @TIPODEDETALLE char(1),
           @TIPODEOBJETO char(1),
           @OBJETO char(50),
           @TIPODEACCESO char(1),
           @OBJETOWINDOW char(80),
           @WORKFLAG char(1),
           @WORKAGREGARFLAG char(1),
           @WORKMODIFICARFLAG char(1),
           @WORKBORRARFLAG char(1),
           @WORKAPROBARFLAG char(1),
           @WEBFLAG char(1),
           @WEBPAGE char(50),
           @WEBACTION char(20),
           @WEBGRUPO char(6),
           @WEBGRUPOSECUENCIA int,
           @ULTIMOUSUARIO varchar(25),
           @ULTIMAFECHAMODIF datetime,
           @ESTADO char(1),
           @ACCION varchar(25),
		   @INICIO   int= null,  
		   @NUMEROFILAS int = null    
AS
BEGIN  
 SET NOCOUNT ON;  
IF(@ACCION = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
		 	
		SET @CONTADOR=(SELECT COUNT(GRUPO) FROM SEGURIDADCONCEPTO
	 					WHERE 
					(@CONCEPTO is null OR CONCEPTO = @CONCEPTO)
					and (@CONCEPTOPADRE is null OR CONCEPTOPADRE = @CONCEPTOPADRE)					
					and (@ESTADO is null OR ESTADO = @ESTADO)
					and (@APLICACIONCODIGO is null OR APLICACIONCODIGO = @APLICACIONCODIGO)
					)
		SELECT
			APLICACIONCODIGO,
			GRUPO,
			CONCEPTO,
			CONCEPTOPADRE,
			IDPAGINA,
			DESCRIPCION,
			DESCRIPCIONINGLES,
			VISIBLEFLAG,
			TIPODEDETALLE,
			TIPODEOBJETO,
			OBJETO,
			TIPODEACCESO,
			OBJETOWINDOW,
			WORKFLAG,
			WORKAGREGARFLAG,
			WORKMODIFICARFLAG,
			WORKBORRARFLAG,
			WORKAPROBARFLAG,
			WEBFLAG,
			WEBPAGE,
			WEBACTION,
			WEBGRUPO,
			WEBGRUPOSECUENCIA,
			ULTIMOUSUARIO,
			ULTIMAFECHAMODIF,
			ESTADO,
			ACCION
		FROM (
			SELECT
			APLICACIONCODIGO,
			GRUPO,
			CONCEPTO,
			CONCEPTOPADRE,
			IDPAGINA,
			DESCRIPCION,
			DESCRIPCIONINGLES,
			VISIBLEFLAG,
			TIPODEDETALLE,
			TIPODEOBJETO,
			OBJETO,
			TIPODEACCESO,
			OBJETOWINDOW,
			WORKFLAG,
			WORKAGREGARFLAG,
			WORKMODIFICARFLAG,
			WORKBORRARFLAG,
			WORKAPROBARFLAG,
			WEBFLAG,
			WEBPAGE,
			WEBACTION,
			WEBGRUPO,
			WEBGRUPOSECUENCIA,
			ULTIMOUSUARIO,
			ULTIMAFECHAMODIF,
			ESTADO,
			ACCION
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY GRUPO ASC ) AS RowNumber   					
				from 
				SEGURIDADCONCEPTO
				where
					(@CONCEPTO is null OR CONCEPTO = @CONCEPTO)
					and (@CONCEPTOPADRE is null OR CONCEPTOPADRE = @CONCEPTOPADRE)					
					and (@DESCRIPCION is null  OR @DESCRIPCION =''  OR  upper(DESCRIPCION) like '%'+upper(@DESCRIPCION)+'%')					
					and (@ESTADO is null OR Estado = @ESTADO)		
					and (@APLICACIONCODIGO is null OR APLICACIONCODIGO = @APLICACIONCODIGO)
		
			) AS LISTADO
			
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
	end
	else
	if(@ACCION = 'LISTAR')
	begin
	 
				SELECT 
					APLICACIONCODIGO,
					GRUPO,
					CONCEPTO,
					CONCEPTOPADRE,
					IDPAGINA,
					DESCRIPCION,
					DESCRIPCIONINGLES,
					VISIBLEFLAG,
					TIPODEDETALLE,
					TIPODEOBJETO,
					OBJETO,
					TIPODEACCESO,
					OBJETOWINDOW,
					WORKFLAG,
					WORKAGREGARFLAG,
					WORKMODIFICARFLAG,
					WORKBORRARFLAG,
					WORKAPROBARFLAG,
					WEBFLAG,
					WEBPAGE,
					WEBACTION,
					WEBGRUPO,
					WEBGRUPOSECUENCIA,
					ULTIMOUSUARIO,
					ULTIMAFECHAMODIF,
					ESTADO,
					ACCION
				from 
				SEGURIDADCONCEPTO
				where
					(@CONCEPTO is null OR CONCEPTO = @CONCEPTO)									
					and (@GRUPO is null OR GRUPO = @GRUPO)		
					and (@APLICACIONCODIGO is null OR APLICACIONCODIGO = @APLICACIONCODIGO) 
	end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 
					*					
				from 
				SEGURIDADCONCEPTO
				where
					(@CONCEPTO is null OR CONCEPTO = @CONCEPTO)									
					and (@GRUPO is null OR GRUPO = @GRUPO)		
					and (@APLICACIONCODIGO is null OR APLICACIONCODIGO = @APLICACIONCODIGO)
					

	end	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SEGURIDADCONCEPTOMANTENIMIENTO]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SEGURIDADCONCEPTOMANTENIMIENTO]  
           @APLICACIONCODIGO char(2),  
           @GRUPO char(15),  
           @CONCEPTO char(15),  
           @CONCEPTOPADRE char(15),  
           @IDPAGINA int,  
           @DESCRIPCION varchar(3000),  
           @DESCRIPCIONINGLES varchar(3000),  
           @VISIBLEFLAG char(1),  
           @TIPODEDETALLE char(1),  
           @TIPODEOBJETO char(1),  
           @OBJETO char(50),  
           @TIPODEACCESO char(1),  
           @OBJETOWINDOW char(80),  
           @WORKFLAG char(1),  
           @WORKAGREGARFLAG char(1),  
           @WORKMODIFICARFLAG char(1),  
           @WORKBORRARFLAG char(1),  
           @WORKAPROBARFLAG char(1),  
           @WEBFLAG char(1),  
           @WEBPAGE char(50),  
           @WEBACTION char(20),  
           @WEBGRUPO char(6),   
           @WEBGRUPOSECUENCIA int,  
           @ULTIMOUSUARIO varchar(25),  
           @ULTIMAFECHAMODIF datetime,  
           @ESTADO char(1),  
           @ACCION varchar(25)  
           AS  
BEGIN   
SET NOCOUNT ON;  
BEGIN  TRANSACTION  
  
 DECLARE @CONTADOR INT  
 IF(@ACCION = 'INSERT')  
 BEGIN   
  INSERT INTO SEGURIDADCONCEPTO  
  (  
   APLICACIONCODIGO,  
   GRUPO,  
   CONCEPTO,  
   CONCEPTOPADRE,  
   IDPAGINA,  
   DESCRIPCION,  
   DESCRIPCIONINGLES,  
   VISIBLEFLAG,  
   TIPODEDETALLE,  
   TIPODEOBJETO,  
   OBJETO,  
   TIPODEACCESO,  
   OBJETOWINDOW,  
   WORKFLAG,  
   WORKAGREGARFLAG,  
   WORKMODIFICARFLAG,  
   WORKBORRARFLAG,  
   WORKAPROBARFLAG,  
   WEBFLAG,  
   WEBPAGE,  
   WEBACTION,  
   WEBGRUPO,  
   WEBGRUPOSECUENCIA,  
   ULTIMOUSUARIO,  
   ULTIMAFECHAMODIF,  
   ESTADO,  
   ACCION  
  )  
    VALUES  
  (  
     @APLICACIONCODIGO,  
           @GRUPO,  
           @CONCEPTO,  
           @CONCEPTOPADRE,  
           @IDPAGINA,  
           @DESCRIPCION,  
           @DESCRIPCIONINGLES,  
           @VISIBLEFLAG,  
           @TIPODEDETALLE,  
           @TIPODEOBJETO,  
           @OBJETO,  
           @TIPODEACCESO,  
           @OBJETOWINDOW,  
           @WORKFLAG,  
           @WORKAGREGARFLAG,  
           @WORKMODIFICARFLAG,  
           @WORKBORRARFLAG,  
           @WORKAPROBARFLAG,  
           @WEBFLAG,  
           @WEBPAGE,  
           @WEBACTION,  
           @WEBGRUPO,  
           @WEBGRUPOSECUENCIA,  
           @ULTIMOUSUARIO,  
           GETDATE(),  
           @ESTADO,  
           @ACCION  
  )  
	DECLARE @TABLAMAESTRO	INT
	DECLARE @IDCODIGO		INT
	
	SELECT @CONTADOR= isnull(MAX(Secuencial),0)+1 from CM_CO_TablaMaestroDetalleConcepto 
	SELECT @TABLAMAESTRO = IdTablaMaestro FROM CM_CO_TablaMaestroDetalleConcepto
	
	SELECT @IDCODIGO =  isnull(MAX(IDCODIGO),0)+1 from CM_CO_TablaMaestroDetalle
	
		  Insert into CM_CO_TablaMaestroDetalle(
		  IdTablaMaestro,
		  IdCodigo,
		  Codigo,
		  Nombre,
		  Estado  
		  )
		  values
		  (1,
		  @IDCODIGO,
		  @CONCEPTO,
		  @DESCRIPCION,
		  2
		  )

		  INSERT INTO CM_CO_TablaMaestroDetalleConcepto
		  (
		  IdTablaMaestro,
		  IdCodigo,
		  Secuencial, 
		  IdConcepto
		  )
		  VALUES
		  (
		  @TABLAMAESTRO,
		  @IDCODIGO,
		  @CONTADOR,
		  @OBJETOWINDOW 
		  )
  
		/****ADD SEGURIDAD AL PERFIL ADMINSYS****/
		  delete SeguridadAutorizaciones where  Usuario = 'ADMINSYS'  and AplicacionCodigo = @APLICACIONCODIGO
		  and GRUPO = @GRUPO    and CONCEPTO = @CONCEPTO
		insert SeguridadAutorizaciones 
		(AplicacionCodigo,Grupo,Concepto,Usuario,OpcionAgregarFlag,OpcionModificarFlag,OpcionBorrarFlag,
		OpcionAprobarFlag, 
		Estado,UltimoUsuario,UltimaFechaModif)
		select AplicacionCodigo,Grupo,Concepto,'ADMINSYS','S','S','S','S',
		'A','ADMINSYS',GETDATE() from SeguridadConcepto  where  AplicacionCodigo = @APLICACIONCODIGO
		and GRUPO = @GRUPO    and CONCEPTO = @CONCEPTO
		/********************************************/
	
	SELECT 1		 
 END   
 ELSE  
 IF(@ACCION = 'UPDATE')  
 BEGIN  
 UPDATE SEGURIDADCONCEPTO  
  SET      
   APLICACIONCODIGO = @APLICACIONCODIGO,  
   GRUPO = @GRUPO,  
   CONCEPTO = @CONCEPTO,  
   CONCEPTOPADRE = @CONCEPTOPADRE,  
   IDPAGINA = @IDPAGINA,  
   DESCRIPCION = @DESCRIPCION,  
   DESCRIPCIONINGLES = @DESCRIPCIONINGLES,  
   --VISIBLEFLAG = @VISIBLEFLAG,  
   TIPODEDETALLE = @TIPODEDETALLE,  
   TIPODEOBJETO = @TIPODEOBJETO,  
   OBJETO = @OBJETO,  
   TIPODEACCESO = @TIPODEACCESO,  
   OBJETOWINDOW = @OBJETOWINDOW,  
   WORKFLAG = @WORKFLAG,  
   WORKAGREGARFLAG = @WORKAGREGARFLAG,  
   WORKMODIFICARFLAG = @WORKMODIFICARFLAG,  
   WORKBORRARFLAG = @WORKBORRARFLAG,  
   WORKAPROBARFLAG = @WORKAPROBARFLAG,  
   WEBFLAG = @WEBFLAG,  
   WEBPAGE = @WEBPAGE,  
   WEBACTION = @WEBACTION,  
   WEBGRUPO = @WEBGRUPO,  
   WEBGRUPOSECUENCIA = @WEBGRUPOSECUENCIA,   
   ULTIMAFECHAMODIF = GETDATE(),  
   ESTADO = @ESTADO,  
   ACCION = @ACCION  
     
   WHERE   
  (APLICACIONCODIGO=@APLICACIONCODIGO)  
   and(GRUPO = @GRUPO)    
   and(CONCEPTO= @CONCEPTO)  
   		select 1
 end   
 else  
 if(@ACCION = 'DELETE')  
 begin  
  delete SEGURIDADCONCEPTO  
  WHERE   
  (APLICACIONCODIGO=@APLICACIONCODIGO)  
   and(GRUPO = @GRUPO)    
   and(CONCEPTO= @CONCEPTO)  
   		select 1
end
		if(@ACCION = 'CONTARLISTAPAG')
	begin		
		
		SET @CONTADOR=(SELECT COUNT(GRUPO) FROM SEGURIDADCONCEPTO
	 					WHERE 
					(@CONCEPTO is null OR CONCEPTO = @CONCEPTO)
					and (@CONCEPTOPADRE is null OR CONCEPTOPADRE = @CONCEPTOPADRE)					
					and (@ESTADO is null OR ESTADO = @ESTADO)
					and (@APLICACIONCODIGO is null OR APLICACIONCODIGO = @APLICACIONCODIGO)
					)
					
		select @CONTADOR
	end
commit	 
END  
/*

exec SP_SEGURIDADCONCEPTOMANTENIMIENTO
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
           'CONTARLISTAPAG'
           
           */
GO
/****** Object:  StoredProcedure [dbo].[SP_SEGURIDADCONCEPTOS]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SEGURIDADCONCEPTOS]
	@ACCION CHAR(20)=null,
	@APLICACIONCODIGO CHAR(2)=null,
	@GRUPO CHAR(15)=null 
	
AS
BEGIN
	IF @ACCION ='LISTARMENU'
		BEGIN
			SELECT * FROM  SEGURIDADCONCEPTO -- WHERE CONCEPTOPADRE = @CONCEPTO
		END
	 IF @ACCION ='GRUPO'
		BEGIN
			SELECT * FROM  SEGURIDADCONCEPTO WHERE  GRUPO= @GRUPO
		END		 
	 IF @ACCION ='TODOS'
		BEGIN
			SELECT * FROM  SEGURIDADCONCEPTO  
		END		
 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SEGURIDADGRUPO]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SEGURIDADGRUPO]
	@ACCION CHAR(20)=null,
	@APLICACIONCODIGO CHAR(2)=null,
	@GRUPO		CHAR(15)=null,
	@ULTIMOUSUARIO	varchar(25)=null,
	@ESTADO			char(1)	=null
	
AS
BEGIN
 
	 IF @ACCION ='GRUPO'
		BEGIN
			SELECT * FROM  dbo.SEGURIDADGRUPO 
			WHERE	APLICACIONCODIGO = @APLICACIONCODIGO
			AND		ESTADO = 'A'
		END
	ELSE
	 IF @ACCION ='GRUPOSEGURIDAD'
		BEGIN		
			SELECT 
				SEGURIDADGRUPO.APLICACIONCODIGO,			
				SEGURIDADGRUPO.GRUPO,
				SEGURIDADCONCEPTO.DESCRIPCION,
				SEGURIDADGRUPO.ULTIMOUSUARIO,
				SEGURIDADGRUPO.ULTIMAFECHAMODIF,
				SEGURIDADGRUPO.ESTADO,
				SEGURIDADGRUPO.SETCOLUMMENU,
				SEGURIDADGRUPO.SETFILAMENU,
				SEGURIDADCONCEPTO.CONCEPTO as ACCION  --AUXILIAR
			FROM  
			dbo.SEGURIDADGRUPO 
			inner join SEGURIDADCONCEPTO on (SEGURIDADCONCEPTO.GRUPO = SEGURIDADGRUPO.GRUPO
				and SEGURIDADCONCEPTO.APLICACIONCODIGO=SEGURIDADGRUPO.APLICACIONCODIGO 
				and CONCEPTOPADRE is null)
			WHERE	SEGURIDADGRUPO.APLICACIONCODIGO = @APLICACIONCODIGO
			AND		SEGURIDADGRUPO.ESTADO = 'A'
			
			--select * from SEGURIDADCONCEPTO
			
		END
			
END

/*
exec SP_SEGURIDADGRUPO
	'GRUPOSEGURIDAD',
	'WA',
	null,
	'ADMINSYS',
	null
	
	*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SEGURIDADGRUPOLISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SEGURIDADGRUPOLISTAR]

@APLICACIONCODIGO		char,
@GRUPO					char(15),
@DESCRIPCION			char(100),
@ULTIMOUSUARIO			varchar(25),
@ULTIMAFECHAMODIF		datetime,
@ESTADO					char,
@SETCOLUMMENU			int,
@SETFILAMENU			int,
@ACCION					varchar(25)
AS    
BEGIN    
IF(@ACCION = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR=(SELECT COUNT(APLICACIONCODIGO) FROM SEGURIDADGRUPO
	 					WHERE 
					(@APLICACIONCODIGO is null OR (APLICACIONCODIGO = @APLICACIONCODIGO) or @APLICACIONCODIGO =0)				
					and (@ESTADO is null OR ESTADO = @ESTADO))
			SELECT
			APLICACIONCODIGO,
			GRUPO,
			DESCRIPCION,
			ULTIMOUSUARIO,
			ULTIMAFECHAMODIF,
			ESTADO,
			SETCOLUMMENU,
			SETFILAMENU,
			ACCION			
			FROM (		
			SELECT
			APLICACIONCODIGO,
			GRUPO,
			DESCRIPCION,
			ULTIMOUSUARIO,
			ULTIMAFECHAMODIF,
			ESTADO,
			SETCOLUMMENU,
			SETFILAMENU,
			ACCION						
			,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY APLICACIONCODIGO ASC ) AS RowNumber   	
					FROM SEGURIDADGRUPO	
					WHERE 
							(@APLICACIONCODIGO is null OR (APLICACIONCODIGO = @APLICACIONCODIGO) or @APLICACIONCODIGO =0)					
					and (@DESCRIPCION is null  OR @DESCRIPCION =''  OR  upper(DESCRIPCION) like '%'+upper(@DESCRIPCION)+'%')					
					and (@Estado is null OR Estado = @Estado)		
 
			) AS LISTADO
		
       END
       ELSE
   IF @Accion ='LISTAR'    
    BEGIN    
		SELECT      
		APLICACIONCODIGO,
			GRUPO,
			DESCRIPCION,
			ULTIMOUSUARIO,
			ULTIMAFECHAMODIF,
			ESTADO,
			SETCOLUMMENU,
			SETFILAMENU,
			ACCION						
			,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY APLICACIONCODIGO ASC ) AS RowNumber   	
					FROM SEGURIDADGRUPO	
					WHERE 
							(@APLICACIONCODIGO is null OR (APLICACIONCODIGO = @APLICACIONCODIGO) or @APLICACIONCODIGO =0)					
					and (@DESCRIPCION is null  OR @DESCRIPCION =''  OR  upper(DESCRIPCION) like '%'+upper(@DESCRIPCION)+'%')					
					and (@Estado is null OR Estado = @Estado)	
					
   END    
END					
GO
/****** Object:  StoredProcedure [dbo].[SP_SEGURIDADGRUPOMANTENIMIENTO]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SEGURIDADGRUPOMANTENIMIENTO]
@APLICACIONCODIGO		char,
@GRUPO					char(15),
@DESCRIPCION			char(100),
@ULTIMOUSUARIO			varchar(25),
@ULTIMAFECHAMODIF		datetime,
@ESTADO					char,
@SETCOLUMMENU			int,
@SETFILAMENU			int,
@ACCION					varchar(25)
AS
BEGIN 
SET NOCOUNT ON;
BEGIN  TRANSACTION

	DECLARE @CONTADOR INT
	IF(@ACCION = 'INSERT')
	begin		 
		
		select @CONTADOR= isnull(MAX(GRUPO),0)+1 from SEGURIDADGRUPO 
		
		SET @GRUPO= @CONTADOR	
		INSERT INTO SEGURIDADGRUPO
		(
			APLICACIONCODIGO,
			GRUPO,
			DESCRIPCION,
			ULTIMOUSUARIO,
			ULTIMAFECHAMODIF,
			ESTADO,
			SETCOLUMMENU,
			SETFILAMENU,
			ACCION	
		)
		VALUES
		(
			@APLICACIONCODIGO,
			@GRUPO,
			@DESCRIPCION,
			@ULTIMOUSUARIO,
			GETDATE(),
			@ESTADO,
			@SETCOLUMMENU,
			@SETFILAMENU,
			@ACCION
		)
	END	
	ELSE
	IF(@ACCION = 'UPDATE')
	BEGIN
	UPDATE SEGURIDADGRUPO
	SET				
			APLICACIONCODIGO = @APLICACIONCODIGO,
			GRUPO = @GRUPO,
			DESCRIPCION = @DESCRIPCION,
			ULTIMOUSUARIO = @ULTIMOUSUARIO,
			ULTIMAFECHAMODIF = GETDATE(),
			ESTADO = @ESTADO,
			SETCOLUMMENU = @SETCOLUMMENU,
			SETFILAMENU = @SETFILAMENU,
			ACCION = @ACCION 	
			
			WHERE 
		(GRUPO = @GRUPO)		
	end	
	else
	if(@ACCION = 'DELETE')
	begin
		delete SEGURIDADGRUPO
		WHERE 
		(GRUPO = @GRUPO)
	end
commit	
	select 1
END	
GO
/****** Object:  StoredProcedure [dbo].[SP_SEGURIDADPERFILUSUARIO]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SEGURIDADPERFILUSUARIO]
(
	@PERFIL CHAR(20)=NULL,
	@Usuario CHAR(20)	,			
	@ESTADO CHAR(2)	,	
	@ULTIMOUSUARIO	char(20),
	@ULTIMAFECHAMODIF	datetime,		
	@ACCION VARCHAR(20)
)

AS
BEGIN
SET NOCOUNT ON;
BEGIN  TRANSACTION
	if(@ACCION = 'INSERT')
	begin
		declare @contar int=0
		--delete de seguridad
		delete SEGURIDADPERFILUSUARIO
		where
		PERFIL=@PERFIL
		and USUARIO = @Usuario
		
		
			insert into
			SEGURIDADPERFILUSUARIO
			(PERFIL,USUARIO,ESTADO,ULTIMOUSUARIO,ULTIMAFECHAMODIF,ACCION)
			values
			(@PERFIL,@USUARIO,@ESTADO,@ULTIMOUSUARIO,GETDATE(),@ACCION)
	
		
	end	
	else
	if(@ACCION = 'DELETE')
	begin
	 
		delete
		SEGURIDADPERFILUSUARIO						
		where perfil=@perfil
		and usuario=@Usuario 
	
	end
	
commit
	select 1	
END
/*

)*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SEGURIDADPERFILUSUARIO_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SEGURIDADPERFILUSUARIO_LISTAR]
(
	@PERFIL CHAR(02)=NULL,
	@Usuario CHAR(20)	,			
	@ESTADO CHAR(1)	,	
	@ULTIMOUSUARIO	char(20),
	
	@INICIO   int= null,  
	@NUMEROFILAS int = null ,
	@ACCION VARCHAR(20)
)

AS
BEGIN
	if(@ACCION = 'LISTAR' or @ACCION is null)
	begin
	 
		SELECT * from
				SEGURIDADPERFILUSUARIO
				WHERE 
				(@USUARIO is null OR Usuario = @USUARIO)
				and (@PERFIL is null OR Perfil = @PERFIL)				
				and (@ESTADO is null OR Estado = @ESTADO)
	end	

END
/*

)*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SG_Modulo]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SG_Modulo]  
   @Sistema varchar(4),  
            @Modulo varchar(2),  
            @Orden int,  
            @Nombre varchar(30),  
            @Descripcion varchar(80),  
            @Plataforma int,  
            @UrlModulo varchar(150),  
            @Estado int,  
            @UsuarioCreacion varchar(25),  
            @FechaCreacion datetime,  
            @UsuarioModificacion varchar(25),  
            @FechaModificacion datetime,   
   @Accion  varchar(25)  
AS    
BEGIN     
SET NOCOUNT ON;    
BEGIN  TRANSACTION    
    
 DECLARE @CONTADOR INT    
 IF(@Accion = 'INSERT')    
 BEGIN     

    
  INSERT INTO SG_Modulo    
  (    
    Sistema,  
    Modulo,  
    Orden,  
    Nombre,  
    Descripcion,  
    Plataforma,  
    UrlModulo,  
    Estado,  
    UsuarioCreacion,  
    FechaCreacion,  
    UsuarioModificacion,  
    FechaModificacion,  
    Accion  
  )    
    VALUES    
  (     
    @Sistema,  
    @Modulo,  
    @Orden,  
    @Nombre,  
    @Descripcion,  
    @Plataforma,  
    @UrlModulo,  
    @Estado,  
    @UsuarioCreacion,  
    GETDATE(),  
    @UsuarioModificacion,  
    GETDATE(),  
    @Accion  
  )    
    
 SELECT 1     
 END     
 ELSE    
 IF(@Accion = 'UPDATE')    
 BEGIN    
 UPDATE SG_Modulo    
  SET        
    Sistema = @Sistema,  
    Modulo = @Modulo,  
    Orden=@Orden,  
    Nombre=@Nombre,  
    Descripcion=@Descripcion,  
    Plataforma=@Plataforma,  
    UrlModulo=@UrlModulo,  
    Estado=@Estado,  
    UsuarioModificacion=@UsuarioModificacion,  
    FechaModificacion=GETDATE(),  
    Accion=@Accion  
  WHERE   
      (Modulo = @Modulo)   
     and (Sistema = @Sistema)  
     select 1  
 end     
 else    
 if(@Accion = 'DELETE')    
 begin    
  delete SG_Modulo    
  WHERE   
      (Modulo = @Modulo)   
     and (Sistema = @Sistema)  
     select 1  
end  
  if(@Accion = 'CONTARLISTAPAG')  
 begin    
    
  
  SET @CONTADOR=(SELECT COUNT(Modulo) FROM SG_Modulo  
       WHERE   
      (@Modulo is null  OR @Modulo =''  OR  upper(Modulo) like '%'+upper(@Modulo)+'%')        
     and (@Sistema is null OR Sistema = @Sistema)       
     and (@Estado is null OR Estado = @Estado)  
     )  
       
  select @CONTADOR  
 end  
commit    
END    
GO
/****** Object:  StoredProcedure [dbo].[SP_SG_Modulo_Lista]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SG_Modulo_Lista]  
   @Sistema varchar(4),  
            @Modulo varchar(2),  
            @Orden int,  
            @Nombre varchar(30),  
            @Descripcion varchar(80),  
            @Plataforma int,  
            @UrlModulo varchar(150),  
            @Estado int,  
            @UsuarioCreacion varchar(25),  
            @FechaCreacion datetime,  
            @UsuarioModificacion varchar(25),  
            @FechaModificacion datetime,   
   @Accion  varchar(25),  
     
   @INICIO   int= null,    
   @NUMEROFILAS int = null     
AS      
BEGIN      
if(@ACCION = 'LISTARPAG')  
 begin  
   DECLARE @CONTADOR INT  
   
  SET @CONTADOR=(SELECT COUNT(Modulo) FROM SG_Modulo  
       WHERE   
      (@Modulo is null  OR @Modulo =''  OR  upper(Modulo) like '%'+upper(@Modulo)+'%')        
     and (@Sistema is null OR Sistema = @Sistema)       
     and (@Estado is null OR Estado = @Estado)  
     )  
  SELECT  
    Sistema,  
    Modulo,  
    Orden,  
    Nombre,  
    Descripcion,  
    Plataforma,  
    UrlModulo,  
    Estado,  
    UsuarioCreacion,  
    FechaCreacion,  
    UsuarioModificacion,  
    FechaModificacion,  
    Accion  
  FROM (    
   SELECT  
    Sistema,  
    Modulo,  
    Orden,  
    Nombre,  
    Descripcion,  
    Plataforma,  
    UrlModulo,  
    Estado,  
    UsuarioCreacion,  
    FechaCreacion,  
    UsuarioModificacion,  
    FechaModificacion,  
    Accion  
     ,@CONTADOR AS Contador  
     ,ROW_NUMBER() OVER (ORDER BY Modulo ASC ) AS RowNumber      
     FROM SG_Modulo   
     WHERE   
      (@Modulo is null  OR @Modulo =''  OR  upper(Modulo) like '%'+upper(@Modulo)+'%')        
     and (@Sistema is null OR Sistema = @Sistema)       
     and (@Estado is null OR Estado = @Estado)  
   
   ) AS LISTADO  
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR    
            RowNumber BETWEEN @Inicio  AND @NumeroFilas   
    
       END  
       ELSE  
  IF @Accion ='LISTAR'      
    BEGIN      
  SELECT  
    Sistema,  
    Modulo,  
    Orden,  
    Nombre,  
    Descripcion,  
    Plataforma,  
    UrlModulo,  
    Estado,  
    UsuarioCreacion,  
    FechaCreacion,  
    UsuarioModificacion,  
    FechaModificacion,  
    Accion  
    FROM SG_Modulo   
         WHERE   
      (@Modulo is null OR Modulo = @Modulo)   
     and (@Sistema is null OR Sistema = @Sistema)       
     and (@Estado is null OR Estado = @Estado)  
   
end   
 else  
 if(@ACCION = 'LISTARPORID')  
 begin    
    SELECT   
     *       
    from   
    SG_Modulo  
  
     WHERE   
      (@Modulo is null OR Modulo = @Modulo)   
     and (@Sistema is null OR Sistema = @Sistema)   
  
 end   
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SHC_VW_ATENCIONPACIENTE_GENERAL]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SHC_VW_ATENCIONPACIENTE_GENERAL]
(
	@tipoListado		varchar(50) ,
	@CitaTipo		varchar(20) ,
	@CitaFecha		datetime,
	@Origen		varchar(20) ,
	@NombreEspecialidad	varchar(80) ,
	
	@TipoPacienteNombre		varchar(80) ,
	@CodigoOA		varchar(15) ,
	@Cama		varchar(150) ,
	@TipoOrdenAtencionNombre		varchar(250) ,
	@CodigoHC		varchar(15) ,
	
	@PacienteNombre		varchar(100) ,
	@MedicoNombre		varchar(100) ,
	@IdOrdenAtencion		int ,
	@LineaOrdenAtencion		int ,
	@IdHospitalizacion		int ,
	
	@IdCita		int ,
	@IdPaciente		int,
	@TipoPaciente		int,
	@TipoAtencion		int,
	@IdEspecialidad		int,
	
	@IdMedico		int,
	@TipoOrdenAtencion		int,
	@Componente		varchar(25),
	@Compania		varchar(15),
	@Sucursal		varchar(15),	
	
	@EstadoPersona		varchar(2),
	@EstadoEpiClinico		int,
	@UnidadReplicacion		varchar(4),
	@UnidadReplicacionEC		varchar(4),
	@IdEpisodioAtencion		bigint,
	
	@EpisodioClinico		int,
	@IdEstablecimientoSalud		int,
	@IdUnidadServicio		int,
	@IdPersonalSalud		int,
	@EpisodioAtencion		int,
	
	@FechaRegistro		datetime,
	@FechaAtencion		datetime,
	@EstadoEpiAtencion		int,
	@FechaInicio		datetime,
	@FechaFin		datetime,
	
	@UsuarioCreacion		varchar(25),
	@FechaCreacion	datetime ,
	@UsuarioModificacion	varchar(25) ,
	@FechaModificacion	datetime ,		
	@Version	varchar(50) ,	
	
	@CodigoHCAnterior		varchar(15) ,	
		
	@Inicio	int ,	
	@NumeroFilas	int ,	
	@ACCION	varchar(25) 
			
)

AS
BEGIN
	DECLARE @CONTADOR INT				
	if(@ACCION = 'LISTARPAG')
	begin
		SET @CONTADOR=(SELECT COUNT(*) 
					from VW_ATENCIONPACIENTE_GENERAL						
						where @tipoListado = VW_ATENCIONPACIENTE_GENERAL.tipoListado
					   and (@CodigoHC is null OR VW_ATENCIONPACIENTE_GENERAL.CodigoHC = @CodigoHC)    
					   and (@CodigoHCAnterior is null OR VW_ATENCIONPACIENTE_GENERAL.CodigoHCAnterior = @CodigoHCAnterior)    
					   and (@PacienteNombre is null  OR @PacienteNombre =''  OR  upper(VW_ATENCIONPACIENTE_GENERAL.PacienteNombre) like '%'+upper(@PacienteNombre)+'%')    
					   --and (@CodigoOA is null OR VW_ATENCIONPACIENTE.CodigoOA = @CodigoOA)    
					   and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE_GENERAL.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
					   --OBS--and (@IdPersonalSalud is null OR VW_ATENCIONPACIENTE.IdPersonalSalud = @IdPersonalSalud)    
					   and (     
						(@FechaInicio is null or  VW_ATENCIONPACIENTE_GENERAL.FechaAtencion >= @FechaInicio)    
						and    
						(@FechaFin is null or  VW_ATENCIONPACIENTE_GENERAL.FechaAtencion <= DATEADD(DAY,1,@FechaFin))    
					   )    
					   and (@IdPaciente is null OR VW_ATENCIONPACIENTE_GENERAL.IdPaciente = @IdPaciente)    		
					)
	 
			select @CONTADOR		

	end	
	

END
/*

exec
	SP_SHC_VW_ATENCIONPACIENTE_GENERAL

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
	'LISTAR'
			
)*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SHC_VW_ATENCIONPACIENTE_GENERAL_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SHC_VW_ATENCIONPACIENTE_GENERAL_LISTAR]
(
				@NumeroFila	int	=null,
		@tipoListado	varchar(30)	=null,
		@CitaTipo	varchar(9)	=null,
		@CitaFecha	datetime	=null,
		@CitaHora	datetime	=null,
		
		@Origen	varchar(20)	=null,		
		@NombreEspecialidad	varchar(80)	=null,
		@TipoPacienteNombre	varchar(80)	=null,
		@CodigoOA	varchar(15)	=null,
		@FechaInicio	datetime	=null,	
		
		@Cama	varchar(150)	=null,
		@TipoOrdenAtencionNombre	varchar(80)	=null,
		@CodigoHC	varchar(15)	=null,
		@CodigoHCAnterior	varchar(15)	=null,
		@PacienteNombre	varchar(100)	=null,
		
		@MedicoNombre	varchar(100)	=null,
		@IdOrdenAtencion	int	=null,
		@LineaOrdenAtencion	int	=null,
		@IdHospitalizacion	int	=null,
		@LineaHospitalizacion	int	=null,	
		
		@IdConsultaExterna	int	=null,
		@IdProcedimiento	int	=null,
		@Modalidad	int	=null,   --AUX USADO PARA TELESALUD --IndicadorTMH
		@IndicadorSeguro	int	=null,
		@IdCita	int	=null,	
		
		@IdPaciente	int	=null,
		@TipoPaciente	int	=null,
		@TipoAtencion	int	=null,
		@IdEspecialidad	int,--	=null,
		@IdEmpresaAseguradora	int	=null,	
		
		@TipoOrdenAtencion	int	=null,
		@Componente	varchar(25)	=null,
		@ComponenteNombre	varchar(250)	=null,
		@Compania	varchar(15)	=null,
		@Sucursal	varchar(15)	=null,
		
		@IdMedico	int	=null,
		@IndicadorCirugia	int	=null,
		@IndicadorExamenPrincipal	int	=null,
		@PersonaAnt	char(15)	=null,
		@sexo	char(1)	=null,	
		
		@FechaNacimiento	datetime	=null,
		@EstadoCivil	char(1)	=null,
		@NivelInstruccion	char(3)	=null,
		@Direccion	varchar(190)	=null,
		@TipoDocumento	char(1)	=null,	
		
		@Documento	char(20)	=null,
		@ApellidoPaterno	varchar(40)	=null,
		@ApellidoMaterno	varchar(40)	=null,
		@Nombres	varchar(40)	=null,
		@LugarNacimiento	varchar(255)	=null,	
		
		@CodigoPostal	char(3)	=null,
		@Provincia	char(3)	=null,
		@Departamento	char(3)	=null,
		@Telefono	varchar(15)	=null,
		@CorreoElectronico	varchar(50)	=null,	
		
		@EsPaciente	varchar(1)	=null,
		@EsEmpresa	varchar(1)	=null,
		@Pais	char(4)	=null,
		@EstadoPersona	char(1)	=null,
		@FechaCierreEpiClinico	datetime	=null,	
		
		@EstadoEpiClinico	int	=null,
		@UnidadReplicacion	char(4)	=null,
		@UnidadReplicacionEC	char(4)	=null,
		@IdEpisodioAtencion	bigint	=null,
		@EpisodioClinico	int	=null,	
		
		@IdEstablecimientoSalud	int	=null,
		@IdUnidadServicio	int	=null,
		@IdPersonalSalud	int	=null,
		@EpisodioAtencion	bigint	=null,
		@FechaRegistro	datetime	=null,	
		
		@FechaAtencion	datetime	=null,
		@EstadoEpiAtencion	int	=null,
		@UsuarioCreacion	varchar(25)	=null,
		@UsuarioModificacion	varchar(25)	=null,
		@FechaCreacion	datetime	=null,	
		
		@FechaModificacion	datetime	=null,	
		@Version	varchar(25)	=null,
		@FechaFin	datetime	=null,
		@FechaOrden	datetime	=null,
		@Comentarios	varchar(300)	=null,  --OBS - TIPO DATO	
		@Observaciones	varchar(300)	=null,	--OBS - TIPO DATO
		@Diagnostico	varchar(300)	=null,	--OBS - TIPO DATO
		@UnidadReplicacionHCE	varchar(4)	=null,
		@IdPacienteHCE	int	=null,
		@EpisodioClinicoHCE	int	=null,	
		@IdEpisodioAtencionHCE	bigint	=null,
		@SecuenciaHCE	int	=null,
		@CodigoEpisodioClinico	int	=null,
		@Contador	int	=null,		
		@Inicio	int =null,	
		@NumeroFilas	int =null,	
		@ACCION	varchar(25) 			
)

AS
BEGIN

	/****TABLA TEMPORAL NOMBRE DE LA VISTA  : VW_ATENCIONPACIENTE_GENERAL*******/
	/***************************************************************************/
	DECLARE @TABLA_ATENCIONPACIENTE_GENERAL table 
	(
		--SECUENCIA			int  NOT NULL   IDENTITY PRIMARY KEY,
		NumeroFila	int	null
	,	tipoListado	varchar(30)	null
	,	CitaTipo	varchar(9)	null
	,	CitaFecha	datetime	null
	,	CitaHora	datetime	null
	,	Origen	varchar(20)	null
	,	NombreEspecialidad	varchar(80)	null
	,	TipoPacienteNombre	varchar(80)	null
	,	CodigoOA	varchar(15)	null
	,	FechaInicio	datetime	null
	,	Cama	varchar(150)	null
	,	TipoOrdenAtencionNombre	varchar(80)	null
	,	CodigoHC	varchar(15)	null
	,	CodigoHCAnterior	varchar(15)	null
	,	PacienteNombre	varchar(100)	null
	,	MedicoNombre	varchar(100)	null
	,	IdOrdenAtencion	int	null
	,	LineaOrdenAtencion	int	null
	,	IdHospitalizacion	int	null
	,	LineaHospitalizacion	int	null
	,	IdConsultaExterna	int	null
	,	IdProcedimiento	int	null
	,	Modalidad	int	null
	,	IndicadorSeguro	int	null
	,	IdCita	int	null
	,	IdPaciente	int	null
	,	TipoPaciente	int	null
	,	TipoAtencion	int	null
	,	IdEspecialidad	int	null
	,	IdEmpresaAseguradora	int	null
	,	TipoOrdenAtencion	int	null
	,	Componente	varchar(25)	null
	,	ComponenteNombre	varchar(250)	null
	,	Compania	varchar(15)	null
	,	Sucursal	varchar(15)	null
	,	IdMedico	int	null
	,	IndicadorCirugia	int	null
	,	IndicadorExamenPrincipal	int	null
	,	PersonaAnt	char(15)	null
	,	sexo	char(1)	null
	,	FechaNacimiento	datetime	null
	,	EstadoCivil	char(1)	null
	,	NivelInstruccion	char(3)	null
	,	Direccion	varchar(190)	null
	,	TipoDocumento	char(1)	null
	,	Documento	char(20)	null
	,	ApellidoPaterno	varchar(40)	null
	,	ApellidoMaterno	varchar(40)	null
	,	Nombres	varchar(40)	null
	,	LugarNacimiento	varchar(255)	null
	,	CodigoPostal	char(3)	null
	,	Provincia	char(3)	null
	,	Departamento	char(3)	null
	,	Telefono	varchar(15)	null
	,	CorreoElectronico	varchar(50)	null
	,	EsPaciente	varchar(1)	null
	,	EsEmpresa	varchar(1)	null
	,	Pais	char(4)	null
	,	EstadoPersona	char(1)	null
	,	FechaCierreEpiClinico	datetime	null
	,	EstadoEpiClinico	int	null
	,	UnidadReplicacion	char(4)	null
	,	UnidadReplicacionEC	char(4)	null
	,	IdEpisodioAtencion	bigint	null
	,	EpisodioClinico	int	null
	,	IdEstablecimientoSalud	int	null
	,	IdUnidadServicio	int	null
	,	IdPersonalSalud	int	null
	,	EpisodioAtencion	bigint	null
	,	FechaRegistro	datetime	null
	,	FechaAtencion	datetime	null
	,	EstadoEpiAtencion	int	null
	,	UsuarioCreacion	varchar(25)	null
	,	UsuarioModificacion	varchar(25)	null
	,	FechaCreacion	datetime	null
	,	FechaModificacion	datetime	null
	,	Accion	varchar(25)	null
	,	Version	varchar(25)	null
	,	FechaFin	datetime	null
	,	FechaOrden	datetime	null
	,	Comentarios	varchar(300)	null
	,	Observaciones	varchar(300)	null	
	,	Diagnostico	varchar(300)	null
	-------------
	,	UnidadReplicacionHCE	varchar(4)	null
	,	IdPacienteHCE	int	null
	,	EpisodioClinicoHCE	int	null
	,	IdEpisodioAtencionHCE	bigint	null
	,	SecuenciaHCE	int	null
	,	CodigoEpisodioClinico	int	null	
	-------------
	,	Contador	int	null								
	)

	DECLARE @ACCION_END varchar(50)=null	
	DECLARE @CONTADORAUX INT				
	if(@ACCION = 'LISTARPAG')
	begin
				select @CONTADORAUX = COUNT(*)
				from VW_ATENCIONPACIENTE
				
				inner join SS_AD_OrdenAtencionDetalle 
				on (SS_AD_OrdenAtencionDetalle.IdPaciente = VW_ATENCIONPACIENTE.Persona 
					and ( (VW_ATENCIONPACIENTE.IdOrdenAtencion is Not null and			
							SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = VW_ATENCIONPACIENTE.IdOrdenAtencion) 
							OR
						  (VW_ATENCIONPACIENTE.IdOrdenAtencion is  null )
						)
				)
				inner join SS_AD_OrdenAtencion
				on (SS_AD_OrdenAtencionDetalle.IdPaciente = SS_AD_OrdenAtencion.IdPaciente
					AND SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_AD_OrdenAtencion.IdOrdenAtencion
				)			   			   			   
			   /*        
			   left join CM_CO_TablaMaestroDetalle TipoPaciente    
			   on (TipoPaciente.IdCodigo = VW_ATENCIONPACIENTE.TipoPaciente    
				and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
			   left join SS_GE_TipoAtencion TipoAtencion    
			   on (TipoAtencion.IdTipoAtencion = VW_ATENCIONPACIENTE.TipoAtencion)    
			   */
			    
			   /*
			   left join SS_HC_Diagnostico HCdiagnostico    
			   on (HCdiagnostico.IdPaciente = VW_ATENCIONPACIENTE.idPaciente
			   and HCdiagnostico.IdEpisodioAtencion = VW_ATENCIONPACIENTE.IdEpisodioAtencion
			   and HCdiagnostico.EpisodioClinico = VW_ATENCIONPACIENTE.EpisodioClinico
			   )    
			   left join SS_GE_Diagnostico GEdiagnostico    
			   on (GEdiagnostico.IdDiagnostico = HCdiagnostico.IdDiagnostico)   
				*/
			 WHERE     			  
			    (@CodigoHC is null OR CodigoHC = @CodigoHC)    
			    --and (SS_AD_OrdenAtencion.IndicadorTMH  = 10)     
			   and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
			   and (@PacienteNombre is null  OR @PacienteNombre =''  OR  upper(VW_ATENCIONPACIENTE.NombreCompleto) like '%'+upper(@PacienteNombre)+'%')    
			   --and (@CodigoOA is null OR VW_ATENCIONPACIENTE.CodigoOA = @CodigoOA)    
			   and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
			   --OBS--and (@IdPersonalSalud is null OR VW_ATENCIONPACIENTE.IdPersonalSalud = @IdPersonalSalud)    
			   /*and (     
				(@FechaInicio is null or  VW_ATENCIONPACIENTE.FechaAtencion >= @FechaInicio)    
				and    
				(@FechaFin is null or  VW_ATENCIONPACIENTE.FechaAtencion <= DATEADD(DAY,1,@FechaFin))    
			   )  */  
			   
						 and (     
				(@FechaInicio is null or  VW_ATENCIONPACIENTE.FechaAtencion >= @FechaInicio)    
				and    
				(@FechaFin is null or  VW_ATENCIONPACIENTE.FechaAtencion <= DATEADD(DAY,1,@FechaFin))    
			   )   
			   --and (@IdPaciente is null OR VW_ATENCIONPACIENTE.Persona = @IdPaciente or  @IdPaciente=0)    
			   and (@EpisodioClinico is null OR VW_ATENCIONPACIENTE.EpisodioClinico = @EpisodioClinico or  @EpisodioClinico=0)    
			   and (@EpisodioAtencion is null OR VW_ATENCIONPACIENTE.EpisodioAtencion = @EpisodioAtencion or  @EpisodioAtencion=0)    
			   ---
			   and (@IdOrdenAtencion is null OR VW_ATENCIONPACIENTE.IdOrdenAtencion = @IdOrdenAtencion or  @IdOrdenAtencion=0)           
			   and (@LineaOrdenAtencion is null OR VW_ATENCIONPACIENTE.LineaOrdenAtencion = @LineaOrdenAtencion or  @LineaOrdenAtencion=0)           
			   ----
			   ----
			   and (@TipoAtencion is null OR ( VW_ATENCIONPACIENTE.TipoAtencion = @TipoAtencion )
						OR ( SS_AD_OrdenAtencion.TipoAtencion = @TipoAtencion )
			   
					) 
				and (@IdEspecialidad is null OR SS_AD_OrdenAtencion.Especialidad=@IdEspecialidad)	-----  ADD 			   
				--and (@Servicio is null OR SS_HC_EpisodioAtencion.TipoEpisodio = @Servicio )                  
			   and (@EstadoEpiAtencion is null or     
				(case     
				 when VW_ATENCIONPACIENTE.Estado IS null     
				 then 0 else VW_ATENCIONPACIENTE.Estado   
				end ) = @EstadoEpiAtencion)     	
			
	    --select * from VW_ATENCIONPACIENTE
		insert into @TABLA_ATENCIONPACIENTE_GENERAL
		(
			UnidadReplicacion    
			 ,IdEpisodioAtencion    
			 ,UnidadReplicacionEC    
			 ,IdPaciente    
			 ,EpisodioClinico    
			 ,IdEstablecimientoSalud    
			 ,IdUnidadServicio    
			 ,IdPersonalSalud         
			 ,EpisodioAtencion    
			 ,FechaRegistro    
			 ,FechaAtencion    
			 ,TipoAtencion    
			 ,IdOrdenAtencion    
			 ,LineaOrdenAtencion    
			 ,TipoOrdenAtencion    
			 ,EstadoEpiAtencion  
			 ,UsuarioCreacion    
			 ,FechaCreacion    
			 ,UsuarioModificacion
			 ,FechaModificacion    
			 ,IdEspecialidad    
			 ,CodigoOA       
			 ,FechaOrden    
			 ,IdProcedimiento    						 
			 ,Accion    
			 ,Version			 
			 ,FechaCierreEpiClinico    
			 ,TipoPaciente      
			 ,CodigoHC    
			 ,CodigoHCAnterior    					
			 ,Origen    
			 ,PacienteNombre
			 ,ApellidoPaterno    
			 ,ApellidoMaterno      
			 ,TipoDocumento    
			 ,Documento      
			 ,FechaNacimiento    
			 ,Sexo      
			 ,EstadoCivil    
			 ,NivelInstruccion    
			 ,Direccion    
			 ,CodigoPostal    
			 ,Provincia    
			 ,Departamento    
			 ,Telefono      
			 ,PersonaAnt
			 ,CorreoElectronico      
			 ,LugarNacimiento    
			 ,Pais    
			 ,EsPaciente
			 ,EsEmpresa    
			 ,EstadoPersona    	        
			 ,EstadoEpiClinico    
			 ,NumeroFila
			 ,Contador
			 ,IdHospitalizacion
			 ,LineaHospitalizacion
			 ,IndicadorExamenPrincipal
			 ,IndicadorCirugia
			 ,tipoListado
			 ,NombreEspecialidad			 
		)							
		  SELECT     
			UnidadReplicacion    
			 ,isnull(IdEpisodioAtencion ,0)    
			 ,UnidadReplicacionEC    
			 ,Persona as IdPaciente    
			 ,isnull(EpisodioClinico ,0)        
			 ,isnull(IdEstablecimientoSalud,0)        
			 ,isnull(IdUnidadServicio ,0)        
			 ,isnull(IdPersonalSalud ,0)
			 ,convert(bigint,EpisodioAtencion) as EpisodioAtencion
			 ,FechaRegistro    
			 ,FechaAtencion    
			 ,TipoAtencionX as TipoAtencion    
			 ,IdOrdenAtencionX as IdOrdenAtencion
			 ,LineaOAX as LineaOrdenAtencion
			 ,TipoOrdenAtencion    
			 ,isnull(Estado ,0) as EstadoEpiAtencion
			 ,UsuarioCreacion    
			 ,FechaCreacion    
			 ,UsuarioModificacion
			 ,FechaModificacion    
			 ,EspecialidadX AS IdEspecialidad			 
			 ,CodigoOAX as CodigoOA       
			 ,FechaOrden    
			 ,IdProcedimiento    
			 ,Accion    
			 ,TipoAtencionX as Version			 
			 ,FechaCierreEpiClinico    
			 ,TipoPaciente      
			 ,CodigoHC    
			 ,CodigoHCAnterior    					
			 ,Origen    
			 ,NombreCompletoX as NombreCompleto
			
			 ,ApellidoPaterno    
			 ,ApellidoMaterno      
			 ,TipoDocumento    
			 ,Documento      
			 ,FechaNacimiento    
			 ,Sexo      
			 ,EstadoCivil    
			 ,NivelInstruccion    
			 ,Direccion    
			 ,CodigoPostal    
			 ,Provincia    
			 ,Departamento    
			 ,Telefono      
			 ,PersonaAnt
			 ,CorreoElectronico      
			 ,LugarNacimiento    
			 ,Pais    
			 ,EsPaciente
			 ,EsEmpresa    
			 ,EstadoPersona    	        
			 ,EstadoEpiClinico   
			 ,RowNumber 
			 ,ContadorX
			 ,0
			 ,0
			 ,0
			 ,0
			 ,'GENERAL'
			 ,(select Nombre from SS_GE_Especialidad where IdEspecialidad=EspecialidadX)--'MEDICINA GENERAL'
		  FROM (      
			SELECT VW_ATENCIONPACIENTE.*,                  			  
			 VW_ATENCIONPACIENTE.Persona as Personax,
			 SS_AD_OrdenAtencion.Especialidad as EspecialidadX,
			 SS_AD_OrdenAtencion.CodigoOA as CodigoOAx,
			 SS_AD_OrdenAtencion.IdOrdenAtencion as IdOrdenAtencionX,
			 SS_AD_OrdenAtencionDetalle.Linea as LineaOAX,
			 VW_ATENCIONPACIENTE.NombreCompleto as NombreCompletoX,
			 (case when VW_ATENCIONPACIENTE.TipoAtencion IS null  
				then SS_AD_OrdenAtencion.TipoAtencion else VW_ATENCIONPACIENTE.TipoAtencion end
			  )
	 		  AS TipoAtencionX,
			 --TipoPaciente.Descripcion as TipoPacienteDesc,        
			   ---TipoAtencion.Nombre as TipoAtencionDesc,         
			   --GEdiagnostico.Nombre as NombreDiagnosticoX,
			   /*
			   (select top 1 Nombre from SG_Agente as agenteTrabajador 
				where agenteTrabajador.CodigoAgente = SS_HC_EpisodioAtencion.UsuarioModificacion 
				) as NombreTrabajadorModificadorX,       */
			  @CONTADORAUX as ContadorX,
			 ROW_NUMBER() OVER (ORDER BY VW_ATENCIONPACIENTE.IdEpisodioAtencion ASC ) AS RowNumber        
				from VW_ATENCIONPACIENTE
				
				inner join SS_AD_OrdenAtencionDetalle 
				on (SS_AD_OrdenAtencionDetalle.IdPaciente = VW_ATENCIONPACIENTE.Persona 
					and ( (VW_ATENCIONPACIENTE.IdOrdenAtencion is Not null and			
							SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = VW_ATENCIONPACIENTE.IdOrdenAtencion) 
							OR
						  (VW_ATENCIONPACIENTE.IdOrdenAtencion is  null )
						)
				)
				inner join SS_AD_OrdenAtencion
				on (SS_AD_OrdenAtencionDetalle.IdPaciente = SS_AD_OrdenAtencion.IdPaciente
					AND SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_AD_OrdenAtencion.IdOrdenAtencion
				)			   			   			   
			   /*        
			   left join CM_CO_TablaMaestroDetalle TipoPaciente    
			   on (TipoPaciente.IdCodigo = VW_ATENCIONPACIENTE.TipoPaciente    
				and TipoPaciente.IdTablaMaestro = 45) --OBS: TIPOPACIEN    
			   left join SS_GE_TipoAtencion TipoAtencion    
			   on (TipoAtencion.IdTipoAtencion = VW_ATENCIONPACIENTE.TipoAtencion)    
			   */
			    
			   /*
			   left join SS_HC_Diagnostico HCdiagnostico    
			   on (HCdiagnostico.IdPaciente = VW_ATENCIONPACIENTE.idPaciente
			   and HCdiagnostico.IdEpisodioAtencion = VW_ATENCIONPACIENTE.IdEpisodioAtencion
			   and HCdiagnostico.EpisodioClinico = VW_ATENCIONPACIENTE.EpisodioClinico
			   )    
			   left join SS_GE_Diagnostico GEdiagnostico    
			   on (GEdiagnostico.IdDiagnostico = HCdiagnostico.IdDiagnostico)   
				*/
			 WHERE     		
				
			 	  
			    (@CodigoHC is null OR CodigoHC = @CodigoHC)    
			    --and (SS_AD_OrdenAtencion.IndicadorTMH  = 10)     
			   and (@CodigoHCAnterior is null OR CodigoHCAnterior = @CodigoHCAnterior)    
			   and (@PacienteNombre is null  OR @PacienteNombre =''  OR  upper(VW_ATENCIONPACIENTE.NombreCompleto) like '%'+upper(@PacienteNombre)+'%')    
			   --and (@CodigoOA is null OR VW_ATENCIONPACIENTE.CodigoOA = @CodigoOA)    
			   and (@CodigoOA is null  OR @CodigoOA =''  OR  upper(VW_ATENCIONPACIENTE.CodigoOA) like '%'+upper(@CodigoOA)+'%')    
			   --OBS--and (@IdPersonalSalud is null OR VW_ATENCIONPACIENTE.IdPersonalSalud = @IdPersonalSalud)    
			  
			   --and (@IdPaciente is null OR VW_ATENCIONPACIENTE.Persona = @IdPaciente or  @IdPaciente=0)
			    
						 and (     
				(@FechaInicio is null or  VW_ATENCIONPACIENTE.FechaAtencion >= @FechaInicio)    
				and    
				(@FechaFin is null or  VW_ATENCIONPACIENTE.FechaAtencion <= DATEADD(DAY,1,@FechaFin))    
			   )   
			   and (@EpisodioClinico is null OR VW_ATENCIONPACIENTE.EpisodioClinico = @EpisodioClinico or  @EpisodioClinico=0)    
			   and (@EpisodioAtencion is null OR VW_ATENCIONPACIENTE.EpisodioAtencion = @EpisodioAtencion or  @EpisodioAtencion=0)    
			   ---
			   and (@IdOrdenAtencion is null OR VW_ATENCIONPACIENTE.IdOrdenAtencion = @IdOrdenAtencion or  @IdOrdenAtencion=0)           
			   and (@LineaOrdenAtencion is null OR VW_ATENCIONPACIENTE.LineaOrdenAtencion = @LineaOrdenAtencion or  @LineaOrdenAtencion=0)           
			   ----
			   and (@IdEspecialidad is null OR SS_AD_OrdenAtencion.Especialidad=@IdEspecialidad)	-----  ADD 	
			   	
			   and (@TipoAtencion is null OR ( VW_ATENCIONPACIENTE.TipoAtencion = @TipoAtencion )
						OR ( SS_AD_OrdenAtencion.TipoAtencion = @TipoAtencion )

			   
					)    
			   
				--and (@Servicio is null OR SS_HC_EpisodioAtencion.TipoEpisodio = @Servicio )                  
			   and (@EstadoEpiAtencion is null or     
				(case     
				 when VW_ATENCIONPACIENTE.Estado IS null     
				 then 0 else VW_ATENCIONPACIENTE.Estado   
				end ) = @EstadoEpiAtencion)        
		        
			 ) AS LISTADO    
			 WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR      
					RowNumber BETWEEN @Inicio  AND @NumeroFilas			
			
			set @ACCION_END = 'TERMINARLISTAR'
								
			/*****
			----ENSAYOS
			select 
			SS_AD_OrdenAtencion.IdOrdenAtencion,
			SS_AD_OrdenAtencion.CodigoOA,  
			SS_AD_OrdenAtencion.IdPaciente,
			SS_AD_OrdenAtencionDetalle.Linea,
			SS_AD_OrdenAtencion.Especialidad,
			VW_ATENCIONPACIENTE.IdEspecialidad,
			VW_ATENCIONPACIENTE.CodigoOA,
			VW_ATENCIONPACIENTE.LineaOrdenAtencion,
			VW_ATENCIONPACIENTE.IdEpisodioAtencion,
			VW_ATENCIONPACIENTE.EstadoEpiClinico,
			VW_ATENCIONPACIENTE.Estado,
			VW_ATENCIONPACIENTE.Persona as PersonaX,
			VW_ATENCIONPACIENTE.*
			from VW_ATENCIONPACIENTE
			
			inner join SS_AD_OrdenAtencionDetalle 
			on (SS_AD_OrdenAtencionDetalle.IdPaciente = VW_ATENCIONPACIENTE.Persona 
				and ( (VW_ATENCIONPACIENTE.IdOrdenAtencion is Not null and			
						SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = VW_ATENCIONPACIENTE.IdOrdenAtencion) 
						OR
					  (VW_ATENCIONPACIENTE.IdOrdenAtencion is  null )
					)
			)
			inner join SS_AD_OrdenAtencion
			on (SS_AD_OrdenAtencionDetalle.IdPaciente = SS_AD_OrdenAtencion.IdPaciente
				AND SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_AD_OrdenAtencion.IdOrdenAtencion
			)
			where VW_ATENCIONPACIENTE.Estado is not null
			*/
			--select IndicadorTMH, * from SS_AD_OrdenAtencion where IndicadorTMH = 10
	end
	else
	if(@ACCION = 'LISTAR')
	begin	 								
			
			set @ACCION_END = 'TERMINARLISTAR'
	end	
	/*********LISTADO FINAL*******/
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
		,	UnidadReplicacionHCE
		,	IdPacienteHCE	
		,	EpisodioClinicoHCE
		,	IdEpisodioAtencionHCE
		,	SecuenciaHCE
		,	CodigoEpisodioClinico
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
		WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
		RowNumber BETWEEN @Inicio  AND @NumeroFilas 		 
		order by 	LISTADO.CodigoOA	
		
		
	end
	else
	if(@ACCION_END = 'TERMINARLISTAR')
	begin
	 								
		SELECT VW_ATENCIONPACIENTE_GENERAL.*						   					       
		from @TABLA_ATENCIONPACIENTE_GENERAL as VW_ATENCIONPACIENTE_GENERAL					

	end	
		
	

END
/*
exec
	SP_SHC_VW_ATENCIONPACIENTE_GENERAL_LISTAR

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
		3,
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
			
		0,
		100,
		'LISTARPAG'
			
*/

--select * from ParametrosMast
GO

/****** Object:  StoredProcedure [dbo].[SP_SS_AD_OrdenAtencionPreexistencia]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_AD_OrdenAtencionPreexistencia]
@Secuencial				INT, 
@IdOrdenAtencion		INT, 
@IdDiagnostico			INT, 
@CodigoDiagnostico		VARCHAR(15), 
@NombreDiagnostico		VARCHAR(250), 

@Observacion			VARCHAR(250), 
@Estado					INT, 
@UsuarioCreacion		VARCHAR(25), 
@FechaCreacion			DATETIME, 
@UsuarioModificacion	VARCHAR(25), 

@FechaModificacion		DATETIME, 
@Accion					VARCHAR(25)
AS 
BEGIN 
SET nocount ON; 

IF @Accion = 'INSERT' 
  BEGIN 
      SELECT @Secuencial = Isnull(Max(secuencial), 0) + 1 FROM   ss_ad_ordenatencionpreexistencia 
      INSERT INTO ss_ad_ordenatencionpreexistencia 
                  (secuencial, 
                   idordenatencion, 
                   iddiagnostico, 
                   codigodiagnostico, 
                   nombrediagnostico, 
                   observacion, 
                   estado, 
                   usuariocreacion, 
                   fechacreacion, 
                   usuariomodificacion, 
                   fechamodificacion, 
                   accion) 
      VALUES      ( @Secuencial, 
                    @IdOrdenAtencion, 
                    @IdDiagnostico, 
                    @CodigoDiagnostico, 
                    @NombreDiagnostico, 
                    @Observacion, 
                    @Estado, 
                    @UsuarioCreacion, 
                    Getdate(), 
                    @UsuarioModificacion, 
                    Getdate(), 
                    @Accion ) 

      SELECT 1 
  END 
ELSE IF @Accion = 'UPDATE' 
  BEGIN 
      UPDATE ss_ad_ordenatencionpreexistencia 
      SET    secuencial = @Secuencial, 
             idordenatencion = @IdOrdenAtencion, 
             iddiagnostico = @IdDiagnostico, 
             codigodiagnostico = @CodigoDiagnostico, 
             nombrediagnostico = @NombreDiagnostico, 
             observacion = @Observacion, 
             estado = @Estado, 
             usuariomodificacion = @UsuarioModificacion, 
             fechamodificacion = GETDATE(), 
             accion = @Accion 
      WHERE  ( ss_ad_ordenatencionpreexistencia.secuencial = @Secuencial ) 
         AND ( ss_ad_ordenatencionpreexistencia.idordenatencion = @IdOrdenAtencion ) 
      SELECT 1 
  END 
ELSE IF @Accion = 'DELETE' 
  BEGIN 
      DELETE FROM ss_ad_ordenatencionpreexistencia 
      WHERE  ( ss_ad_ordenatencionpreexistencia.secuencial = @Secuencial ) 
         AND ( ss_ad_ordenatencionpreexistencia.idordenatencion = @IdOrdenAtencion ) 
      SELECT 1 
  END 
ELSE IF( @ACCION = 'LISTARPAG' ) 
  BEGIN 
      DECLARE @CONTADOR INT 

      SET @CONTADOR = (SELECT Count(*) 
                       FROM   ss_ad_ordenatencionpreexistencia 
                       INNER JOIN SS_AD_OrdenAtencion 
                       ON (SS_AD_OrdenAtencion.IdOrdenAtencion = SS_AD_OrdenAtencionPreexistencia.IdOrdenAtencion)
                       WHERE  ( @Estado IS NULL OR ss_ad_ordenatencionpreexistencia.estado = @Estado OR @Estado = 0 ) 
                          AND ( @IdOrdenAtencion IS NULL OR ss_ad_ordenatencionpreexistencia.idordenatencion = @IdOrdenAtencion OR @IdOrdenAtencion = 0 )
                          AND ( @IdDiagnostico IS NULL OR SS_AD_OrdenAtencion.IdPaciente = @IdDiagnostico OR @IdDiagnostico = 0 )) 
      SELECT @CONTADOR; 
  END 
END 
/*    
EXEC SP_SS_AD_OrdenAtencionPreexistencia  
NULL,NULL, NULL, NULL, NULL,    
NULL, NULL, NULL, NULL, NULL,    
NULL,LISTARPAG    
*/ 
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_AD_OrdenAtencionPreexistenciaListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_AD_OrdenAtencionPreexistenciaListar] 
@Secuencial				INT, 
@IdOrdenAtencion		INT, 
@IdDiagnostico			INT, 
@CodigoDiagnostico		VARCHAR(15), 
@NombreDiagnostico		VARCHAR(250), 

@Observacion			VARCHAR(250), 
@Estado					INT, 
@UsuarioCreacion		VARCHAR(25), 
@FechaCreacion			DATETIME, 
@UsuarioModificacion	VARCHAR(25), 

@FechaModificacion		DATETIME, 
@Accion					VARCHAR(25),
@INICIO					INT, 
@NUMEROFILAS			INT 
AS 
  BEGIN 
      SET nocount ON; 
      DECLARE @CONTADOR INT 
      IF @Accion = 'LISTAR' 
        BEGIN 
            SELECT ss_ad_ordenatencionpreexistencia.secuencial, 
                   ss_ad_ordenatencionpreexistencia.idordenatencion, 
                   ss_ad_ordenatencionpreexistencia.iddiagnostico, 
                   isnull(ss_ad_ordenatencionpreexistencia.codigodiagnostico, '') as codigodiagnostico,
                   isnull(ss_ad_ordenatencionpreexistencia.nombrediagnostico, '') as nombrediagnostico,							
                   ss_ad_ordenatencionpreexistencia.observacion, 
                   ss_ad_ordenatencionpreexistencia.estado, 
                   ss_ad_ordenatencionpreexistencia.usuariocreacion, 
                   ss_ad_ordenatencionpreexistencia.fechacreacion, 
                   ss_ad_ordenatencionpreexistencia.usuariomodificacion, 
                   ss_ad_ordenatencionpreexistencia.fechamodificacion ,
                   ss_ad_ordenatencionpreexistencia.accion 
            FROM   ss_ad_ordenatencionpreexistencia 
            INNER JOIN SS_AD_OrdenAtencion 
            ON (SS_AD_OrdenAtencion.IdOrdenAtencion = SS_AD_OrdenAtencionPreexistencia.IdOrdenAtencion)                      
            WHERE  ( @Estado IS NULL OR SS_AD_OrdenAtencionPreexistencia.estado = @Estado OR @Estado = 0 ) 
               AND ( @IdOrdenAtencion IS NULL OR SS_AD_OrdenAtencionPreexistencia.idordenatencion = @IdOrdenAtencion OR @IdOrdenAtencion = 0 )
               AND ( @IdDiagnostico IS NULL OR SS_AD_OrdenAtencion.IdPaciente = @IdDiagnostico OR @IdDiagnostico = 0 ) 
        END 
      ELSE IF( @Accion = 'LISTARPAG' ) 
        BEGIN 
            SET @CONTADOR = (SELECT Count(*)FROM   ss_ad_ordenatencionpreexistencia 
                             INNER JOIN ss_ad_ordenatencion 
                             ON ( ss_ad_ordenatencion.idordenatencion = ss_ad_ordenatencionpreexistencia.idordenatencion ) 
                             WHERE  ( @Estado IS NULL OR SS_AD_OrdenAtencionPreexistencia.estado = @Estado OR @Estado = 0 ) 
								AND ( @IdOrdenAtencion IS NULL OR SS_AD_OrdenAtencionPreexistencia.idordenatencion = @IdOrdenAtencion OR @IdOrdenAtencion = 0 )
								AND ( @IdDiagnostico IS NULL OR SS_AD_OrdenAtencion.IdPaciente = @IdDiagnostico OR @IdDiagnostico = 0 )) 
								

            SELECT secuencial, 
                   idordenatencion, 
                   iddiagnostico, 
                   codigodiagnostico, 
                   nombrediagnostico, 
                   observacion, 
                   estado, 
                   usuariocreacion, 
                   fechacreacion, 
                   usuariomodificacion, 
                   fechamodificacion,
                   accion 
            FROM   (SELECT  ss_ad_ordenatencionpreexistencia.secuencial, 
                            ss_ad_ordenatencionpreexistencia.idordenatencion, 
                            ss_ad_ordenatencionpreexistencia.iddiagnostico, 							
							isnull(ss_ad_ordenatencionpreexistencia.codigodiagnostico, '') as codigodiagnostico,
							isnull(ss_ad_ordenatencionpreexistencia.nombrediagnostico, '') as nombrediagnostico,							
							ss_ad_ordenatencionpreexistencia.observacion, 
							ss_ad_ordenatencionpreexistencia.estado, 
							ss_ad_ordenatencionpreexistencia.usuariocreacion, 
							ss_ad_ordenatencionpreexistencia.fechacreacion, 
							ss_ad_ordenatencionpreexistencia.usuariomodificacion, 
							ss_ad_ordenatencionpreexistencia.fechamodificacion, 
							ss_ad_ordenatencionpreexistencia.accion, 
							@CONTADOR AS Contador, 
							Row_number() OVER ( ORDER BY ss_ad_ordenatencionpreexistencia.secuencial ASC ) AS RowNumber 
							FROM   ss_ad_ordenatencionpreexistencia 
							INNER JOIN SS_AD_OrdenAtencion 
							ON (SS_AD_OrdenAtencion.IdOrdenAtencion = SS_AD_OrdenAtencionPreexistencia.IdOrdenAtencion)                      
							WHERE  ( @Estado IS NULL OR ss_ad_ordenatencionpreexistencia.Estado = @Estado OR @Estado = 0 ) 
							   AND ( @IdOrdenAtencion IS NULL OR ss_ad_ordenatencionpreexistencia.IdOrdenAtencion = @IdOrdenAtencion OR @IdOrdenAtencion = 0 )
							   AND ( @IdDiagnostico IS NULL OR SS_AD_OrdenAtencion.IdPaciente = @IdDiagnostico OR @IdDiagnostico = 0 )) AS LISTADO 
							   WHERE  ( @Inicio IS NULL AND @NumeroFilas IS NULL ) OR rownumber BETWEEN @Inicio AND @NumeroFilas 
							   END 
				IF @Accion = 'LISTADO' 
        BEGIN 
            SELECT ss_ad_ordenatencionpreexistencia.secuencial, 
                   ss_ad_ordenatencionpreexistencia.idordenatencion, 
                   SS_AD_OrdenAtencion.IdPaciente AS iddiagnostico, 
                   ss_ad_ordenatencionpreexistencia.codigodiagnostico, 
                   ss_ad_ordenatencionpreexistencia.nombrediagnostico, 
                   ss_ad_ordenatencionpreexistencia.observacion, 
                   ss_ad_ordenatencionpreexistencia.estado, 
                   ss_ad_ordenatencionpreexistencia.usuariocreacion, 
                   ss_ad_ordenatencionpreexistencia.fechacreacion, 
                   ss_ad_ordenatencionpreexistencia.usuariomodificacion, 
                   ss_ad_ordenatencionpreexistencia.fechamodificacion ,
                   ss_ad_ordenatencionpreexistencia.accion 
            FROM   ss_ad_ordenatencionpreexistencia  
            INNER JOIN SS_AD_OrdenAtencion 
            ON (SS_AD_OrdenAtencion.IdOrdenAtencion = SS_AD_OrdenAtencionPreexistencia.IdOrdenAtencion)                      
            WHERE  ( @Estado IS NULL OR SS_AD_OrdenAtencionPreexistencia.estado = @Estado OR @Estado = 0 ) 
               AND ( @IdOrdenAtencion IS NULL OR SS_AD_OrdenAtencionPreexistencia.idordenatencion = @IdOrdenAtencion OR @IdOrdenAtencion = 0 )
               AND ( @IdDiagnostico IS NULL OR SS_AD_OrdenAtencion.IdPaciente = @IdDiagnostico OR @IdDiagnostico = 0 ) 
        END 
							   
							   END 
/*     
EXEC SP_SS_AD_OrdenAtencionPreexistenciaListar     
0, 0, 1, NULL, NULL,    
NULL, NULL, NULL, NULL, NULL,    
NULL, 'LISTADO', NULL, NULL
*/ 
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_CC_Horario]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_CC_Horario]
(
	@IdHorario	int ,
	@IdServicio	int ,
	@Medico	int ,
	@IdEspecialidad	int ,
	@IdConsultorio	int ,
	
	@Periodo	int ,
	@IdTurno	int ,
	@FechaInicio	datetime ,
	@FechaFin	datetime ,
	@HoraInicio	datetime ,
	
	@HoraFin	datetime ,
	@FechaInicioHorario	datetime ,
	@FechaFinHorario	datetime ,
	@TipoUso	int ,
	@IndicadorLunes	int ,
	
	@IndicadorMartes	int ,
	@IndicadorMiercoles	int ,
	@IndicadorJueves	int ,
	@IndicadorViernes	int ,
	@IndicadorSabado	int ,
	
	@IndicadorDomingo	int ,
	@TipoGeneracionCita	int ,
	@TiempoPromedioAtencion	numeric(9, 2) ,
	@Estado	int ,
	@UsuarioCreacion	varchar(25) ,
	
	@FechaCreacion	datetime ,
	@UsuarioModificacion	varchar(25) ,
	@FechaModificacion	datetime ,
	@TipoRegistroHorario	int ,
	@IndicadorCompartido	int ,
	
	@IdGrupoAtencionCompartido	int ,
	@IdInasistencia	int ,
	@IndicadorCitaMultiple	int ,
	@IndicadorAplicaAdicional	int ,
	@CantidadCitasAdicional	int ,
	@UnidadReplicacion	char(4) ,
	
		
	@ACCION	varchar(25) 
			
)

AS
BEGIN 
SET NOCOUNT ON;
BEGIN  TRANSACTION

	DECLARE @CONTADOR INT
	
	if(@ACCION = 'INSERT')
	begin		 
		
		select @CONTADOR= isnull(MAX(IdHorario),0)+1 from SS_CC_Horario 
		
		set @IdHorario= @CONTADOR
		insert into SS_CC_Horario
		(
			IdHorario
			,IdServicio
			,Medico
			,IdEspecialidad
			,IdConsultorio
			,Periodo
			,IdTurno
			,FechaInicio
			,FechaFin
			,HoraInicio
			,HoraFin
			,FechaInicioHorario
			,FechaFinHorario
			,TipoUso
			,IndicadorLunes
			,IndicadorMartes
			,IndicadorMiercoles
			,IndicadorJueves
			,IndicadorViernes
			,IndicadorSabado
			,IndicadorDomingo
			,TipoGeneracionCita
			,TiempoPromedioAtencion
			,Estado
			,UsuarioCreacion
			,FechaCreacion
			,UsuarioModificacion
			,FechaModificacion
			,TipoRegistroHorario
			,IndicadorCompartido
			,IdGrupoAtencionCompartido
			,IdInasistencia
			,IndicadorCitaMultiple
			,IndicadorAplicaAdicional
			,CantidadCitasAdicional
			,UnidadReplicacion
			--,ACCION
		)
		values(
				@IdHorario
			,	@IdServicio
			,	@Medico
			,	@IdEspecialidad
			,	@IdConsultorio
			,	@Periodo
			,	@IdTurno
			,	@FechaInicio
			,	@FechaFin
			,	@HoraInicio
			,	@HoraFin
			,	@FechaInicioHorario
			,	@FechaFinHorario
			,	@TipoUso
			,	@IndicadorLunes
			,	@IndicadorMartes
			,	@IndicadorMiercoles
			,	@IndicadorJueves
			,	@IndicadorViernes
			,	@IndicadorSabado
			,	@IndicadorDomingo
			,	@TipoGeneracionCita
			,	@TiempoPromedioAtencion
			,	@Estado
			,	@UsuarioCreacion
			,	@FechaCreacion
			,	@UsuarioModificacion
			,	@FechaModificacion
			,	@TipoRegistroHorario
			,	@IndicadorCompartido
			,	@IdGrupoAtencionCompartido
			,	@IdInasistencia
			,	@IndicadorCitaMultiple
			,	@IndicadorAplicaAdicional
			,	@CantidadCitasAdicional
			,	@UnidadReplicacion
			--,	@ACCION

		)
		select @IdHorario
	end	
	else
	if(@ACCION = 'UPDATE')
	begin			
		update SS_CC_Horario
		set 							
			IdServicio	=	@IdServicio
			,Medico	=	@Medico
			,IdEspecialidad	=	@IdEspecialidad
			,IdConsultorio	=	@IdConsultorio
			,Periodo	=	@Periodo
			,IdTurno	=	@IdTurno
			,FechaInicio	=	@FechaInicio
			,FechaFin	=	@FechaFin
			,HoraInicio	=	@HoraInicio
			,HoraFin	=	@HoraFin
			,FechaInicioHorario	=	@FechaInicioHorario
			,FechaFinHorario	=	@FechaFinHorario
			,TipoUso	=	@TipoUso
			,IndicadorLunes	=	@IndicadorLunes
			,IndicadorMartes	=	@IndicadorMartes
			,IndicadorMiercoles	=	@IndicadorMiercoles
			,IndicadorJueves	=	@IndicadorJueves
			,IndicadorViernes	=	@IndicadorViernes
			,IndicadorSabado	=	@IndicadorSabado
			,IndicadorDomingo	=	@IndicadorDomingo
			,TipoGeneracionCita	=	@TipoGeneracionCita
			,TiempoPromedioAtencion	=	@TiempoPromedioAtencion
			,Estado	=	@Estado
			--,UsuarioCreacion	=	@UsuarioCreacion
			--,FechaCreacion	=	@FechaCreacion
			,UsuarioModificacion	=	@UsuarioModificacion
			,FechaModificacion	=	@FechaModificacion
			,TipoRegistroHorario	=	@TipoRegistroHorario
			,IndicadorCompartido	=	@IndicadorCompartido
			,IdGrupoAtencionCompartido	=	@IdGrupoAtencionCompartido
			,IdInasistencia	=	@IdInasistencia
			,IndicadorCitaMultiple	=	@IndicadorCitaMultiple
			,IndicadorAplicaAdicional	=	@IndicadorAplicaAdicional
			,CantidadCitasAdicional	=	@CantidadCitasAdicional
			,UnidadReplicacion	=	@UnidadReplicacion
			--,ACCION	=	@ACCION		
		WHERE 
		(IdHorario	=	@IdHorario)		
		select @IdHorario
	end	
	else
	if(@ACCION = 'DELETE')
	begin
		delete SS_CC_Horario
		WHERE 
		(IdHorario = @IdHorario)
		select @IdHorario
	end
	else
	if(@ACCION = 'LISTARPAG')
	begin	 	
	
		select  @CONTADOR = COUNT(*) from SS_CC_Horario
	 					WHERE 
					 (@IdHorario is null OR IdHorario = @IdHorario OR @IdHorario=0)
					 AND (@Medico is null OR Medico = @Medico )
					 AND (@IdEspecialidad is null OR IdEspecialidad = @IdEspecialidad )
					 AND (@IdConsultorio is null OR IdConsultorio = @IdConsultorio )
					 AND (@Periodo is null OR Periodo = @Periodo )
					and (@ESTADO is null OR Estado = @ESTADO)
					
		select @CONTADOR
	end
commit	
	
END	
/*
exec SP_SS_CC_Horario

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
	NULL,
	
		
	'LISTARPAG'
	
*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_CC_Horario_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_CC_Horario_LISTAR]
(
	@IdHorario	int ,
	@IdServicio	int ,
	@Medico	int ,
	@IdEspecialidad	int ,
	@IdConsultorio	int ,
	
	@Periodo	int ,
	@IdTurno	int ,
	@FechaInicio	datetime ,
	@FechaFin	datetime ,
	@HoraInicio	datetime ,
	
	@HoraFin	datetime ,
	@FechaInicioHorario	datetime ,
	@FechaFinHorario	datetime ,
	@TipoUso	int ,
	@IndicadorLunes	int ,
	
	@IndicadorMartes	int ,
	@IndicadorMiercoles	int ,
	@IndicadorJueves	int ,
	@IndicadorViernes	int ,
	@IndicadorSabado	int ,
	
	@IndicadorDomingo	int ,
	@TipoGeneracionCita	int ,
	@TiempoPromedioAtencion	numeric(9, 2) ,
	@Estado	int ,
	@UsuarioCreacion	varchar(25) ,
	
	@FechaCreacion	datetime ,
	@UsuarioModificacion	varchar(25) ,
	@FechaModificacion	datetime ,
	@TipoRegistroHorario	int ,
	@IndicadorCompartido	int ,
	
	@IdGrupoAtencionCompartido	int ,
	@IdInasistencia	int ,
	@IndicadorCitaMultiple	int ,
	@IndicadorAplicaAdicional	int ,
	@CantidadCitasAdicional	int ,
	@UnidadReplicacion	char(4) ,
	
	@INICIO   int= null,  
	@NUMEROFILAS int = null ,	
	@ACCION	varchar(25) 
)

AS
BEGIN
	if(@ACCION = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		select  @CONTADOR = COUNT(*) from SS_CC_Horario
	 					WHERE 
					 (@IdHorario is null OR IdHorario = @IdHorario OR @IdHorario=0)
					 AND (@Medico is null OR Medico = @Medico )
					 AND (@IdEspecialidad is null OR IdEspecialidad = @IdEspecialidad )
					 AND (@IdConsultorio is null OR IdConsultorio = @IdConsultorio )
					 AND (@Periodo is null OR Periodo = @Periodo )
					and (@ESTADO is null OR Estado = @ESTADO)
					
	 
		SELECT 
					IdHorario
					,IdServicio
					,Medico
					,IdEspecialidad
					,IdConsultorio
					,Periodo
					,IdTurno
					,FechaInicio
					,FechaFin
					,HoraInicio
					,HoraFin
					,FechaInicioHorario
					,FechaFinHorario
					,TipoUso
					,IndicadorLunes
					,IndicadorMartes
					,IndicadorMiercoles
					,IndicadorJueves
					,IndicadorViernes
					,IndicadorSabado
					,IndicadorDomingo
					,TipoGeneracionCita
					,TiempoPromedioAtencion
					,Estado
					,NombremedicoX as UsuarioCreacion
					,FechaCreacion
					,UsuarioModificacion
					,FechaModificacion
					,TipoRegistroHorario
					,IndicadorCompartido
					,IdGrupoAtencionCompartido
					,IdInasistencia
					,IndicadorCitaMultiple
					,IndicadorAplicaAdicional
					,CantidadCitasAdicional
					,UnidadReplicacion
					,ACCION					
		FROM (
				SELECT 
					SS_CC_Horario.*,
					medico.NombreCompleto as NombremedicoX
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY IdHorario ASC ) AS RowNumber   					
				from 
				SS_CC_Horario
				left Join PERSONAMAST medico on medico.Persona = SS_CC_Horario.Medico
	 					WHERE 
					 (@IdHorario is null OR IdHorario = @IdHorario OR @IdHorario=0)
					 AND (@Medico is null OR Medico = @Medico )
					 AND (@IdEspecialidad is null OR IdEspecialidad = @IdEspecialidad )
					 AND (@IdConsultorio is null OR IdConsultorio = @IdConsultorio )
					 AND (@Periodo is null OR Periodo = @Periodo )
					and (@ESTADO is null OR SS_CC_Horario.Estado = @ESTADO)
					
		
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
	end
	else
	if(@ACCION = 'LISTAR')
	begin
	 
				SELECT 
					IdHorario
					,IdServicio
					,Medico
					,IdEspecialidad
					,IdConsultorio
					,Periodo
					,IdTurno
					,FechaInicio
					,FechaFin
					,HoraInicio
					,HoraFin
					,FechaInicioHorario
					,FechaFinHorario
					,TipoUso
					,IndicadorLunes
					,IndicadorMartes
					,IndicadorMiercoles
					,IndicadorJueves
					,IndicadorViernes
					,IndicadorSabado
					,IndicadorDomingo
					,TipoGeneracionCita
					,TiempoPromedioAtencion
					,Estado
					,UsuarioCreacion
					,FechaCreacion
					,UsuarioModificacion
					,FechaModificacion
					,TipoRegistroHorario
					,IndicadorCompartido
					,IdGrupoAtencionCompartido
					,IdInasistencia
					,IndicadorCitaMultiple
					,IndicadorAplicaAdicional
					,CantidadCitasAdicional
					,UnidadReplicacion
					,ACCION
			
				from 
				SS_CC_Horario
	 					WHERE 
					 (@IdHorario is null OR IdHorario = @IdHorario OR @IdHorario=0)
					 AND (@Medico is null OR Medico = @Medico )
					 AND (@IdEspecialidad is null OR IdEspecialidad = @IdEspecialidad )
					 AND (@IdConsultorio is null OR IdConsultorio = @IdConsultorio )
					 AND (@Periodo is null OR Periodo = @Periodo )
					and (@ESTADO is null OR Estado = @ESTADO)
					

	end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 
					IdHorario
					,IdServicio
					,Medico
					,IdEspecialidad
					,IdConsultorio
					,Periodo
					,IdTurno
					,FechaInicio
					,FechaFin
					,HoraInicio
					,HoraFin
					,FechaInicioHorario
					,FechaFinHorario
					,TipoUso
					,IndicadorLunes
					,IndicadorMartes
					,IndicadorMiercoles
					,IndicadorJueves
					,IndicadorViernes
					,IndicadorSabado
					,IndicadorDomingo
					,TipoGeneracionCita
					,TiempoPromedioAtencion
					,Estado
					,UsuarioCreacion
					,FechaCreacion
					,UsuarioModificacion
					,FechaModificacion
					,TipoRegistroHorario
					,IndicadorCompartido
					,IdGrupoAtencionCompartido
					,IdInasistencia
					,IndicadorCitaMultiple
					,IndicadorAplicaAdicional
					,CantidadCitasAdicional
					,UnidadReplicacion
					,ACCION				
				from 
				SS_CC_Horario
	 					WHERE 
					 (IdHorario = @IdHorario)

					
	end	
	else
	if(@ACCION = 'LISTARDETALLEDIA')
	begin	 
			DECLARE  @SS_CC_HorarioAUX TABLE(           
				IdHorario	int NULL,
				IdServicio	int NULL,
				Medico	int NULL,
				IdEspecialidad	int NULL,
				IdConsultorio	int NULL,
				Periodo	int NULL,
				IdTurno	int NULL,
				FechaInicio	datetime NULL,
				FechaFin	datetime NULL,
				HoraInicio	datetime NULL,
				HoraFin	datetime NULL,
				FechaInicioHorario	datetime NULL,
				FechaFinHorario	datetime NULL,
				TipoUso	int NULL,
				IndicadorLunes	int NULL,
				IndicadorMartes	int NULL,
				IndicadorMiercoles	int NULL,
				IndicadorJueves	int NULL,
				IndicadorViernes	int NULL,
				IndicadorSabado	int NULL,
				IndicadorDomingo	int NULL,
				TipoGeneracionCita	int NULL,
				TiempoPromedioAtencion	numeric(9, 2) NULL,
				Estado	int NULL,
				UsuarioCreacion	varchar(25) NULL,
				FechaCreacion	datetime NULL,
				UsuarioModificacion	varchar(25) NULL,
				FechaModificacion	datetime NULL,
				TipoRegistroHorario	int NULL,
				IndicadorCompartido	int NULL,
				IdGrupoAtencionCompartido	int NULL,
				IdInasistencia	int NULL,
				IndicadorCitaMultiple	int NULL,
				IndicadorAplicaAdicional	int NULL,
				CantidadCitasAdicional	int NULL,
				UnidadReplicacion	char(4) NULL,
				ACCION	varchar(30) NULL
				
			)	 
		
		
			insert into @SS_CC_HorarioAUX 
			(IdHorario,FechaInicio,FechaFin,HoraInicio,HoraFin,Estado)
			values
			(1,@FechaInicio,@FechaInicio,DATEADD(HOUR,8,convert ( datetime,'19000101',102)) 
			,DATEADD(HOUR,12,convert ( datetime,'19000101',101)) ,1),
			(2,@FechaInicio,@FechaInicio,DATEADD(HOUR,12,convert ( datetime,'19000101',102)) 
			,DATEADD(HOUR,16,convert ( datetime,'19000101',101)) ,2)
	 
	 
	 
		--select DATEADD(HOUR,8,convert ( datetime,'19000101',102))
		
				SELECT
					IdHorario
					,IdServicio
					,Medico
					,IdEspecialidad
					,IdConsultorio
					,Periodo
					,IdTurno
					,FechaInicio
					,FechaFin
					,HoraInicio
					,HoraFin
					,FechaInicioHorario
					,FechaFinHorario
					,TipoUso
					,IndicadorLunes
					,IndicadorMartes
					,IndicadorMiercoles
					,IndicadorJueves
					,IndicadorViernes
					,IndicadorSabado
					,IndicadorDomingo
					,TipoGeneracionCita
					,TiempoPromedioAtencion
					,Estado
					,UsuarioCreacion
					,FechaCreacion
					,UsuarioModificacion
					,FechaModificacion
					,TipoRegistroHorario
					,IndicadorCompartido
					,IdGrupoAtencionCompartido
					,IdInasistencia
					,IndicadorCitaMultiple
					,IndicadorAplicaAdicional
					,CantidadCitasAdicional
					,UnidadReplicacion
					,ACCION
			
				from 
				(select 
					HORARIOdet.* from 
						@SS_CC_HorarioAUX													
						 HORARIOdet											
	 							/*WHERE 
							 (@IdHorario is null OR IdHorario = @IdHorario OR @IdHorario=0)
							 AND (@Medico is null OR Medico = @Medico )
							 AND (@FechaInicio is null or FechaInicio = @FechaInicio )
							 AND (@IdEspecialidad is null OR IdEspecialidad = @IdEspecialidad )
							 AND (@IdConsultorio is null OR IdConsultorio = @IdConsultorio )
							 --AND (@Periodo is null OR Periodo = @Periodo )
							and (@ESTADO is null OR Estado = @ESTADO)			*/		
				)Horario
	end	
			

			
	/*
				select * from PERSONAMAST where PERSONA = 28
			
			select * from SS_HC_ProximaAtencion
			select * from SS_HC_EpisodioAtencion
	select IndicadorTMH, * from SS_AD_OrdenAtencion 
	select * from SS_AD_OrdenAtencionDetalle
	
	
	select * from SS_HC_EpisodioAtencion
	
	select * from SS_CC_Horario
	select * from SS_HC_Formato  
	where CodigoFormato = '%'+'CCEP6'+'%'
	
	select * from SG_Opcion 
*/
END
/*
exec SP_SS_CC_Horario_LISTAR
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
	NULL,
	
	0,
	20,
	'LISTARDETALLEDIA'
			
*/

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_GE_Especialidad_listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE OR ALTER PROCEDURE [SP_SS_GE_Especialidad_listar]  
  
           @IdEspecialidad int,  
           @Codigo varchar(15),  
           @Nombre varchar(80),  
           @Descripcion varchar(150),  
           @TiempoPromedioAtencion numeric(9,2),  
           @FormularioInicial int,  
           @FormularioFinal int,  
           @FormularioInforme int,  
           @Estado int,  
           @UsuarioCreacion varchar(25),  
           @FechaCreacion datetime,  
           @UsuarioModificacion varchar(25),  
           @FechaModificacion datetime,  
           @CantidadCitasAdicional int,  
           @AtencionPeriodoCronico int,  
           @IndicadorValidarFlujo int,  
           @ReporteCita int,  
           @foto varchar(150),  
           @descripcion_det varchar(1000),  
           @IndicadorWeb int,  
           @Accion varchar(25),   
             
     @INICIO   int= null,    
     @NUMEROFILAS int = null       
AS      
BEGIN      
if(@ACCION = 'LISTARPAG')  
 begin  
   DECLARE @CONTADOR INT  
   
  SET @CONTADOR=(SELECT COUNT(IdEspecialidad) FROM SS_GE_Especialidad  
       WHERE   
     ( (@IdEspecialidad is null OR (IdEspecialidad = @IdEspecialidad) or @IdEspecialidad =0)       
     and (@Nombre is null  OR @Nombre =''  OR  upper(Nombre) like '%'+upper(@Nombre)+'%')       
     and (@Estado is null OR Estado = @Estado)        
     and (@Codigo is null  OR @Codigo =''  OR  upper(Codigo) like '%'+upper(@Codigo)+'%')  
        
     ))  
  SELECT  
   IdEspecialidad,  
   Codigo,  
   Nombre,  
   Descripcion,  
   TiempoPromedioAtencion,  
   FormularioInicial,  
   FormularioFinal,  
   FormularioInforme,  
   Estado,  
   UsuarioCreacion,  
   FechaCreacion,  
   UsuarioModificacion,  
   FechaModificacion,  
   CantidadCitasAdicional,  
   AtencionPeriodoCronico,  
   IndicadorValidarFlujo,  
   ReporteCita,  
   foto,  
   descripcion_det,  
   IndicadorWeb,  
   Accion  
  FROM (    
   SELECT  
   IdEspecialidad,  
   Codigo,  
   Nombre,  
   Descripcion,  
   TiempoPromedioAtencion,  
   FormularioInicial,  
   FormularioFinal,  
   FormularioInforme,  
   Estado,  
   UsuarioCreacion,  
   FechaCreacion,  
   UsuarioModificacion,  
   FechaModificacion,  
   CantidadCitasAdicional,  
   AtencionPeriodoCronico,  
   IndicadorValidarFlujo,  
   ReporteCita,  
   foto,  
   descripcion_det,  
   IndicadorWeb,  
   Accion  
     ,@CONTADOR AS Contador  
     ,ROW_NUMBER() OVER (ORDER BY IdEspecialidad ASC ) AS RowNumber      
     FROM SS_GE_Especialidad   
     WHERE   
     (@IdEspecialidad is null OR (IdEspecialidad = @IdEspecialidad) or @IdEspecialidad =0)       
     and (@Nombre is null  OR @Nombre =''  OR  upper(Nombre) like '%'+upper(@Nombre)+'%')       
     and (@Estado is null OR Estado = @Estado)        
     and (@Codigo is null  OR @Codigo =''  OR  upper(Codigo) like '%'+upper(@Codigo)+'%')  
       
   
   ) AS LISTADO  
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR    
            RowNumber BETWEEN @Inicio  AND @NumeroFilas   
    
       END  
       ELSE  
	  IF @Accion ='LISTAR'      
		BEGIN      
	  SELECT  
	   IdEspecialidad,  
	   Codigo,  
	   Nombre,  
	   Descripcion,  
	   TiempoPromedioAtencion,  
	   FormularioInicial,  
	   FormularioFinal,  
	   FormularioInforme,  
	   Estado,  
	   UsuarioCreacion,  
	   FechaCreacion,  
	   UsuarioModificacion,  
	   FechaModificacion,  
	   CantidadCitasAdicional,  
	   AtencionPeriodoCronico,  
	   IndicadorValidarFlujo,  
	   ReporteCita,  
	   foto,  
	   descripcion_det,  
	   IndicadorWeb,  
	   Accion  
		 FROM SS_GE_Especialidad   
		 WHERE   
		 (@IdEspecialidad is null OR (IdEspecialidad = @IdEspecialidad) or @IdEspecialidad =0)       
		 and (@Nombre is null  OR @Nombre =''  OR  upper(Nombre) like '%'+upper(@Nombre)+'%')       
		 and (@Estado is null OR Estado = @Estado)   
		 and (@Codigo is null  OR @Codigo =''  OR  upper(Codigo) like '%'+upper(@Codigo)+'%')  
		 
		 
		 
	end   
	 else  
	 if(@ACCION = 'LISTARPORID')  
	 begin    
		SELECT   
		 *       
		from   
		SS_GE_Especialidad  
	  
		 WHERE   
		   (@IdEspecialidad is null OR (IdEspecialidad = @IdEspecialidad) or @IdEspecialidad =0)  
	  
	 end   
       ELSE  
	  IF @Accion ='LISTARPORAGENTE'      
		BEGIN  
			declare @EMPLEADO_AUX int = null    
			
			if(@UsuarioCreacion is not null)
			begin
				select top 1 @EMPLEADO_AUX = IdEmpleado from SG_Agente 
				where rtrim(CodigoAgente) = rtrim(@UsuarioCreacion)
			end
		
			  SELECT  
			   IdEspecialidad,  
			   Codigo,  
			   Nombre,  
			   Descripcion,  
			   TiempoPromedioAtencion,  
			   FormularioInicial,  
			   FormularioFinal,  
			   FormularioInforme,  
			   Estado,  
			   UsuarioCreacion,  
			   FechaCreacion,  
			   UsuarioModificacion,  
			   FechaModificacion,  
			   CantidadCitasAdicional,  
			   AtencionPeriodoCronico,  
			   IndicadorValidarFlujo,  
			   ReporteCita,  
			   foto,  
			   descripcion_det,  
			   IndicadorWeb,  
			   Accion  
				 FROM SS_GE_Especialidad   
				 WHERE   
				 (@IdEspecialidad is null OR (IdEspecialidad = @IdEspecialidad) or @IdEspecialidad =0)       
				 and (@Nombre is null  OR @Nombre =''  OR  upper(Nombre) like '%'+upper(@Nombre)+'%')       
				 and (@Estado is null OR Estado = @Estado)   
				 and (@Codigo is null  OR @Codigo =''  OR  upper(Codigo) like '%'+upper(@Codigo)+'%')  
				 and (@EMPLEADO_AUX is null or @EMPLEADO_AUX = 0 or 
						IdEspecialidad in (select IdEspecialidad from SS_GE_EspecialidadMedico
									where IdMedico = @EMPLEADO_AUX and Estado=2
							)
				 )
	end   	 
	
	 	 
END


GO
/****** Object:  StoredProcedure [dbo].[SP_SS_GE_Especialidad_mantenimiento]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_GE_Especialidad_mantenimiento]  
  
           @IdEspecialidad int,  
           @Codigo varchar(15),  
           @Nombre varchar(80),  
           @Descripcion varchar(150),  
           @TiempoPromedioAtencion numeric(9,2),  
           @FormularioInicial int,  
           @FormularioFinal int,  
           @FormularioInforme int,  
           @Estado int,  
           @UsuarioCreacion varchar(25),  
           @FechaCreacion datetime,  
           @UsuarioModificacion varchar(25),  
           @FechaModificacion datetime,  
           @CantidadCitasAdicional int,  
           @AtencionPeriodoCronico int,  
           @IndicadorValidarFlujo int,  
           @ReporteCita int,  
           @foto varchar(150),  
           @descripcion_det varchar(1000),  
           @IndicadorWeb int,  
           @Accion varchar(25)  
AS    
BEGIN     
SET NOCOUNT ON;    
BEGIN  TRANSACTION    
    
 DECLARE @CONTADOR INT    
 IF(@Accion = 'INSERT')    
 BEGIN     
   select @CONTADOR= isnull(MAX(IdEspecialidad),0)+1 from SS_GE_Especialidad   
    
  set @IdEspecialidad= @CONTADOR  
    
  INSERT INTO SS_GE_Especialidad    
  (   
   IdEspecialidad,  
   Codigo,  
   Nombre,  
   Descripcion,  
   TiempoPromedioAtencion,  
   FormularioInicial,  
   FormularioFinal,  
   FormularioInforme,  
   Estado,  
   UsuarioCreacion,  
   FechaCreacion,  
   UsuarioModificacion,  
   FechaModificacion,  
   CantidadCitasAdicional,  
   AtencionPeriodoCronico,  
   IndicadorValidarFlujo,  
   ReporteCita,  
   foto,  
   descripcion_det,  
   IndicadorWeb,  
   Accion  
   )  
   VALUES  
   (  
   @IdEspecialidad,  
   @Codigo,  
   @Nombre,  
   @Descripcion,  
   @TiempoPromedioAtencion,  
   @FormularioInicial,  
   @FormularioFinal,  
   @FormularioInforme,  
   @Estado,  
   @UsuarioCreacion,  
   @FechaCreacion,  
   @UsuarioModificacion,  
   @FechaModificacion,  
   @CantidadCitasAdicional,  
   @AtencionPeriodoCronico,  
   @IndicadorValidarFlujo,  
   @ReporteCita,  
   @foto,  
   @descripcion_det,  
   @IndicadorWeb,  
   @Accion  
   )  
   SELECT 1     
 END     
 ELSE    
 IF(@Accion = 'UPDATE')    
 BEGIN    
 UPDATE SS_GE_Especialidad    
  SET        
   IdEspecialidad = @IdEspecialidad,  
   Codigo = @Codigo,  
   Nombre = @Nombre,  
   Descripcion = @Descripcion,  
   TiempoPromedioAtencion = @TiempoPromedioAtencion,   
   FormularioInicial = @FormularioInicial,  
   FormularioFinal = @FormularioFinal,  
   FormularioInforme = @FormularioInforme,  
   Estado = @Estado,  
   UsuarioCreacion = @UsuarioCreacion,  
   FechaCreacion = @FechaCreacion,  
   UsuarioModificacion = @UsuarioModificacion,  
   FechaModificacion = @FechaModificacion,  
   CantidadCitasAdicional = @CantidadCitasAdicional,  
   AtencionPeriodoCronico = @AtencionPeriodoCronico,  
   IndicadorValidarFlujo = @IndicadorValidarFlujo,  
   ReporteCita = @ReporteCita,  
   foto = @foto,  
   descripcion_det = @descripcion_det,  
   IndicadorWeb = @IndicadorWeb,  
   Accion = @Accion  
  WHERE   
  (IdEspecialidad = @IdEspecialidad)    
     select 1  
 end     
 else    
 if(@Accion = 'DELETE')    
 begin    
  delete SS_GE_Especialidad    
  WHERE   
  (IdEspecialidad = @IdEspecialidad)   
     select 1  
end  
  if(@Accion = 'CONTARLISTAPAG')  
 begin    
    
  SET @CONTADOR=(SELECT COUNT(IdEspecialidad) FROM SS_GE_Especialidad  
        WHERE   
     ( (@IdEspecialidad is null OR (IdEspecialidad = @IdEspecialidad) or @IdEspecialidad =0)       
     and (@Nombre is null  OR @Nombre =''  OR  upper(Nombre) like '%'+upper(@Nombre)+'%')       
     and (@Estado is null OR Estado = @Estado)        
     and (@Codigo is null  OR @Codigo =''  OR  upper(Codigo) like '%'+upper(@Codigo)+'%')  
        
     ))  
       
  select @CONTADOR  
 end  

 	 
	 
	 	 
 
commit    
END    
  
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_GE_EspecialidadOrdenMedica_Lista]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_GE_EspecialidadOrdenMedica_Lista]
			@IdEspecialidad int,
            @Secuencial int,
            @TipoOrdenMedica int,
            @Estado int,
            @FechaCreacion datetime,
            @UsuarioCreacion varchar(25),
            @FechaModificacion datetime,
            @UsuarioModificacion varchar(25),
            @Accion varchar(25),	
           
		    @INICIO   int= null,  
		    @NUMEROFILAS int = null  
AS    
BEGIN    
if(@Accion = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR=(SELECT COUNT(Secuencial) FROM SS_GE_EspecialidadOrdenMedica
	 					WHERE 
					(@IdEspecialidad is null OR (IdEspecialidad = @IdEspecialidad) or @IdEspecialidad =0)				
					and (@Secuencial is null OR (Secuencial = @Secuencial) or @Secuencial=0)
					and (@Estado is null OR Estado = @Estado)
					)
		SELECT 
		IdEspecialidad,
		Secuencial,
		TipoOrdenMedica,
		Estado,
		FechaCreacion,
		UsuarioCreacion,
		FechaModificacion,
		UsuarioModificacion,
		Accion     
		FROM (		
			SELECT    
		IdEspecialidad,
		Secuencial,
		TipoOrdenMedica,
		Estado,
		FechaCreacion,
		UsuarioCreacion,
		FechaModificacion,
		UsuarioModificacion,
		Accion 
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY Secuencial ASC ) AS RowNumber   	
					FROM SS_GE_EspecialidadOrdenMedica	
					WHERE 
					(@IdEspecialidad is null OR (IdEspecialidad = @IdEspecialidad) or @IdEspecialidad =0)				
					and (@Secuencial is null OR (Secuencial = @Secuencial) or @Secuencial=0)
					and (@Estado is null OR Estado = @Estado)
 
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		
       END
       ELSE
  IF @Accion ='LISTAR'    
    BEGIN    
		SELECT 
		IdEspecialidad,
		Secuencial,
		TipoOrdenMedica,
		Estado,
		FechaCreacion,
		UsuarioCreacion,
		FechaModificacion,
		UsuarioModificacion,
		Accion 
					FROM SS_GE_EspecialidadOrdenMedica	
					WHERE 
					(@IdEspecialidad is null OR (IdEspecialidad = @IdEspecialidad) or @IdEspecialidad =0)				
					and (@Secuencial is null OR (Secuencial = @Secuencial) or @Secuencial=0)
					and (@Estado is null OR Estado = @Estado)
					end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 
					*					
				from 
				SS_GE_EspecialidadOrdenMedica

					WHERE 
							(@IdEspecialidad is null OR (IdEspecialidad = @IdEspecialidad) or @IdEspecialidad =0)				
					and (@Secuencial is null OR (Secuencial = @Secuencial) or @Secuencial=0)

	end	
END  
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_GE_EspecialidadOrdenMedica_mantenimiento]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_GE_EspecialidadOrdenMedica_mantenimiento]
			@IdEspecialidad int,
            @Secuencial int,
            @TipoOrdenMedica int,
            @Estado int,
            @FechaCreacion datetime,
            @UsuarioCreacion varchar(25),
            @FechaModificacion datetime,
            @UsuarioModificacion varchar(25),
            @Accion varchar(25)
AS  
BEGIN   
SET NOCOUNT ON;  
BEGIN  TRANSACTION  
  
 DECLARE @CONTADOR INT  
 IF(@Accion = 'INSERT')  
 BEGIN   
 		select @CONTADOR= isnull(MAX(Secuencial),0)+1 from SS_GE_EspecialidadOrdenMedica 
		
		set @Secuencial= @CONTADOR
		
  INSERT INTO SS_GE_EspecialidadOrdenMedica  
  ( 
			
		IdEspecialidad,
		Secuencial,
		TipoOrdenMedica,
		Estado,
		FechaCreacion,
		UsuarioCreacion,
		FechaModificacion,
		UsuarioModificacion,
		Accion
			)
			VALUES
			(
		@IdEspecialidad,
		@Secuencial,
		@TipoOrdenMedica,
		@Estado,
		@FechaCreacion,
		@UsuarioCreacion,
		@FechaModificacion,
		@UsuarioModificacion,
		@Accion
			)
			SELECT 1		 
 END   
 ELSE  
 IF(@Accion = 'UPDATE')  
 BEGIN  
 UPDATE SS_GE_EspecialidadOrdenMedica  
  SET     	
		IdEspecialidad = @IdEspecialidad,
		Secuencial = @Secuencial,
		TipoOrdenMedica = @TipoOrdenMedica,
		Estado = @Estado,
		FechaCreacion = @FechaCreacion,
		UsuarioCreacion = @UsuarioCreacion,
		FechaModificacion = @FechaModificacion,
		UsuarioModificacion = @UsuarioModificacion,
		Accion = @Accion
		WHERE 
		(IdEspecialidad = @IdEspecialidad)  
		and (Secuencial = @Secuencial)  
   		select 1
 end   
 else  
 if(@Accion = 'DELETE')  
 begin  
  delete SS_GE_EspecialidadOrdenMedica  
		WHERE 
		(IdEspecialidad = @IdEspecialidad) 
		and (Secuencial = @Secuencial)  
   		select 1
end
		if(@Accion = 'CONTARLISTAPAG')
	begin		
		
		SET @CONTADOR=(SELECT COUNT(Secuencial) FROM SS_GE_EspecialidadOrdenMedica
	 					WHERE 
					(@IdEspecialidad is null OR (IdEspecialidad = @IdEspecialidad) or @IdEspecialidad =0)				
					and (@Secuencial is null OR (Secuencial = @Secuencial) or @Secuencial=0)
					and (@Estado is null OR Estado = @Estado) 
				)	
		select @CONTADOR
	end
commit	 
END  

           
           /*
           exec SP_SS_GE_EspecialidadOrdenMedica_mantenimiento
			0,
            0,
            null,
            null,
            null,
            null,
            null,
            null,
            'CONTARLISTAPAG' */
GO

/****** Object:  StoredProcedure [dbo].[SP_SS_GE_Medicamento_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE OR ALTER PROCEDURE [SP_SS_GE_Medicamento_FE]
       @UnidadReplicacion  char(4) ,
       @IdPaciente  int ,
       @EpisodioClinico  int ,
       @IdEpisodioAtencion  bigint ,
       @Secuencia  int ,
       @TipoMedicamento int,
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
       @Comentario  varchar(1500),
       @IndicadorAuditoria int,
       @UsuarioAuditoria varchar(25),
       @TipoComida int,
       @VolumenDia [varchar](250) ,
       @FrecuenciaToma [varchar](250) ,
       @Presentacion [varchar](250) ,
       @Hora [datetime] ,
       @Periodo VARCHAR(10) ,
       @UnidadTiempo INT  ,
       @Indicacion [varchar](250) ,
       @Estado  int,
       @UsuarioCreacion  varchar(25),
       @FechaCreacion  datetime,
       @UsuarioModificacion  varchar(25),
       @FechaModificacion  datetime,
       @Accion      varchar(50),
       @Version varchar(50),
       @IdPadreNutriente  int,
       @IdHijoNutriente  int,
	   @SecuencialHCE VARCHAR(20),  --ANGEL 16/07/2019
	   @CodAlmacen VARCHAR(20)		--ANGEL 16/07/2019
AS
BEGIN
       SET NOCOUNT ON;
       DECLARE @IdEpisodioAtencionId as INTEGER,@SecuenciaID as integer,
       @EpisodioClinicoID as INTEGER, @ExisteCodigo as VARCHAR(10)
       set @IdEpisodioAtencionId = @IdEpisodioAtencion;
       	DECLARE @VNUN  INT
        	DECLARE @IDTIPOATENCION  INT
        
        IF @Accion = 'NUEVO'
             BEGIN
                    if @Version='' or @Version is null
                    begin 
                           set @Version='CCEP0101'
                    end
					if @TipoMedicamento=2
                    begin 
                           set @CodAlmacen=''
                    end
					DECLARE @var varchar(15)

					EXEC SP_SS_HC_Correlativo '00000000','CEG' ,'HC',@NroPeticion = @var output

                    SELECT @SecuenciaID = ISNULL(max(Secuencia),0) + 1  FROM SS_HC_Medicamento_FE
					WHERE  UnidadReplicacion = @UnidadReplicacion AND 
					 IdEpisodioAtencion = @IdEpisodioAtencion AND   IdPaciente = @IdPaciente AND  EpisodioClinico = @EpisodioClinico

                    INSERT INTO SS_HC_Medicamento_FE(UnidadReplicacion, IdEpisodioAtencion, IdPaciente, EpisodioClinico, 
                              Secuencia, IdUnidadMedida, Linea, Familia, SubFamilia, TipoComponente, CodigoComponente, 
                              IdVia, Dosis, DiasTratamiento, Frecuencia, Cantidad, IndicadorEPS, TipoReceta, Estado, 
                              UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion,
                              Accion,  Version, Forma, GrupoMedicamento,Comentario,IndicadorAuditoria, UsuarioAuditoria,
                              TipoMedicamento, TipoComida,  VolumenDia , FrecuenciaToma ,    
                              Presentacion, Hora , Indicacion ,Periodo ,UnidadTiempo,IdPadreNutriente ,IdHijoNutriente,SecuencialHCE,CodAlmacen)--ANGEL 16/07/2019
                           
                           VALUES(@UnidadReplicacion, @IdEpisodioAtencion,       @IdPaciente,       @EpisodioClinico,   
                           @SecuenciaID, @IdUnidadMedida,    @Linea,      @Familia,    @SubFamilia,       @TipoComponente,    @CodigoComponente,  
                           @IdVia,      @Dosis,      @DiasTratamiento,   @Frecuencia, @Cantidad,       @IndicadorEPS,      @TipoReceta, 2,     
                           @UsuarioCreacion,   getdate(),   @UsuarioModificacion,      getdate(), 
						   'NUEVO',     @Version,@Forma, @GrupoMedicamento, 
                          CONVERT(varchar(max),@Comentario) ,@IndicadorAuditoria, @UsuarioAuditoria, @TipoMedicamento, @TipoComida,@VolumenDia ,  @FrecuenciaToma ,
                           @Presentacion,      @Hora ,      @Indicacion,@Periodo ,@UnidadTiempo,@IdPadreNutriente ,@IdHijoNutriente,@var, @CodAlmacen )  --ANGEL 16/07/2019
                           
					     --MODIFICAR 02 FEBRERO 2023
					
						 SELECT @IDTIPOATENCION =TipoAtencion FROM SS_HC_EpisodioAtencion	WHERE  UnidadReplicacion = @UnidadReplicacion AND 
						 IdEpisodioAtencion = @IdEpisodioAtencion AND   IdPaciente = @IdPaciente AND  EpisodioClinico = @EpisodioClinico

						 --IF @IDTIPOATENCION=2
							--BEGIN
							-- EXEC [SP_HCE_MEDICAMENTODIRECTA]  @UnidadReplicacion , 	@IdEpisodioAtencion ,	@IdPaciente ,	@EpisodioClinico  
							--END
                    select @SecuenciaID;
             END

             IF @Accion ='UPDATE'
                    BEGIN		
                           UPDATE SS_HC_Medicamento_FE SET  
                           Comentario=CONVERT(varchar(max),@Comentario)                     
                           Where  IdPaciente = @IdPaciente
                          and          EpisodioClinico =@EpisodioClinico 
                           and          IdEpisodioAtencion = @IdEpisodioAtencion
                           and          UnidadReplicacion  = @UnidadReplicacion
                           select @IdEpisodioAtencionId;

                    END
                    
             IF @Accion ='DELETE' ---delete general
                    BEGIN

                           delete from SS_HC_Indicaciones_FE
                           Where  IdPaciente = @IdPaciente
                          and          EpisodioClinico =@EpisodioClinico 
                           and          IdEpisodioAtencion = @IdEpisodioAtencion
                           and          UnidadReplicacion  = @UnidadReplicacion

                           delete from  SS_HC_Medicamento_FE  
                           Where  IdPaciente = @IdPaciente
                          and          EpisodioClinico =@EpisodioClinico 
                           and          IdEpisodioAtencion = @IdEpisodioAtencion
                           and          TipoMedicamento = @TipoMedicamento
                           and          UnidadReplicacion  = @UnidadReplicacion

                           select @IdEpisodioAtencionId;
                    END          
             IF @Accion ='UPDATEINDIV'
                    BEGIN

					SELECT @VNUN= ISNULL(MAX(D.IndicadorCobrado),1) FROM     SS_HC_Medicamento_FE    MED WITH(NOLOCK)     
					INNER JOIN   SS_HC_EpisodioAtencion EA    WITH(NOLOCK) ON MED.UnidadReplicacion = EA.UnidadReplicacion
                      AND MED.IdEpisodioAtencion =(CASE WHEN EA.TipoAtencion in (2,3) THEN		EA.IdEpisodioAtencion ELSE EA.EpisodioAtencion END )
                      AND MED.IdPaciente = EA.IdPaciente           AND MED.EpisodioClinico = EA.EpisodioClinico AND  MED.GrupoMedicamento =0
					INNER JOIN BDOncologico.DBO.SS_AD_OrdenAtencionDetalle  D WITH (NOLOCK)  ON  D.IdOrdenAtencion = EA.IdOrdenAtencion   AND D.SECUENCIALHCE COLLATE Latin1_General_CI_AS = MED.SECUENCIALHCE COLLATE Latin1_General_CI_AS
					WHERE   MED.IdPaciente = @IdPaciente
							   and          MED.EpisodioClinico =@EpisodioClinico 
							   and          MED.IdEpisodioAtencion = @IdEpisodioAtencion
							   and          MED.UnidadReplicacion  = @UnidadReplicacion
							   and          MED. Secuencia = @Secuencia

						IF @VNUN =1 
							BEGIN

							   UPDATE SS_HC_Medicamento_FE SET  IdUnidadMedida=@IdUnidadMedida,
									  Linea=@Linea, Familia=@Familia,  SubFamilia=@SubFamilia,TipoComponente=@TipoComponente,      
									  CodigoComponente=@CodigoComponente,     IdVia=@IdVia,      Dosis=@Dosis, DiasTratamiento=@DiasTratamiento,      
									  Frecuencia=@Frecuencia,    Cantidad=@Cantidad,       IndicadorEPS=@IndicadorEPS,       TipoReceta=@TipoReceta,   
									  VolumenDia=@VolumenDia ,   FrecuenciaToma=@FrecuenciaToma ,Presentacion=@Presentacion,      Hora=@Hora ,
									 Indicacion=@Indicacion,    Estado=@Estado,     Periodo=@Periodo ,UnidadTiempo=@UnidadTiempo,
									  --UsuarioCreacion=@UsuarioCreacion,                         --FechaCreacion=getdate(),                                    
									  UsuarioModificacion=@UsuarioModificacion,      FechaModificacion=getdate(),      Accion=@Accion,
									  Forma = @Forma,GrupoMedicamento = @GrupoMedicamento ,Comentario=CONVERT(varchar(max),@Comentario),                              
									  IndicadorAuditoria=@IndicadorAuditoria, 
									  UsuarioAuditoria=@UsuarioAuditoria,  IdPadreNutriente=@IdPadreNutriente   ,IdHijoNutriente=@IdHijoNutriente,
									  TipoMedicamento =@TipoMedicamento, TipoComida = @TipoComida,/*AÑADIDO 02102019 PARA INTEROPDIRECTA*/ INDICADORTI=1 --CERRAR MODIF
							   Where  IdPaciente = @IdPaciente
							   and          EpisodioClinico =@EpisodioClinico 
							   and          IdEpisodioAtencion = @IdEpisodioAtencion
							   and          UnidadReplicacion  = @UnidadReplicacion
							   and          Secuencia = @Secuencia

							  --MODIFICAR 02 FEBRERO 2023
					
								 SELECT @IDTIPOATENCION =TipoAtencion FROM SS_HC_EpisodioAtencion	WHERE  UnidadReplicacion = @UnidadReplicacion AND 
								 IdEpisodioAtencion = @IdEpisodioAtencion AND   IdPaciente = @IdPaciente AND  EpisodioClinico = @EpisodioClinico
								 								 
						   END

                           select @Secuencia;

                    END                        
             IF @Accion ='DELETEINDIV' ---delete individual
                    BEGIN
						
					SELECT @VNUN= ISNULL(MAX(D.IndicadorCobrado),1) FROM     SS_HC_Medicamento_FE    MED WITH(NOLOCK)     
					INNER JOIN   SS_HC_EpisodioAtencion EA    WITH(NOLOCK) ON MED.UnidadReplicacion = EA.UnidadReplicacion
                      AND MED.IdEpisodioAtencion =(CASE WHEN EA.TipoAtencion in (2,3) THEN		EA.IdEpisodioAtencion ELSE EA.EpisodioAtencion END )
                      AND MED.IdPaciente = EA.IdPaciente           AND MED.EpisodioClinico = EA.EpisodioClinico AND  MED.GrupoMedicamento =0
					INNER JOIN BDOncologico.DBO.SS_AD_OrdenAtencionDetalle  D WITH (NOLOCK)  ON  D.IdOrdenAtencion = EA.IdOrdenAtencion   AND D.SECUENCIALHCE COLLATE Latin1_General_CI_AS = MED.SECUENCIALHCE COLLATE Latin1_General_CI_AS
					WHERE   MED.IdPaciente = @IdPaciente
							   and          MED.EpisodioClinico =@EpisodioClinico 
							   and           MED.IdEpisodioAtencion = @IdEpisodioAtencion
							   and           MED.UnidadReplicacion  = @UnidadReplicacion
							   and          MED. Secuencia = @Secuencia

						IF @VNUN =1 
							BEGIN
								 if(@TipoMedicamento is null ) set @TipoMedicamento = 1                                               
                           
								   delete from SS_HC_Indicaciones_FE
								   Where  IdPaciente = @IdPaciente
								  and          EpisodioClinico =@EpisodioClinico 
								   and          IdEpisodioAtencion = @IdEpisodioAtencion
								   and          UnidadReplicacion  = @UnidadReplicacion
								   and SecuenciaMedicamento = @Secuencia
								   -----
                           
								   delete from  SS_HC_Medicamento_FE 
								   Where  IdPaciente = @IdPaciente
								  and          EpisodioClinico =@EpisodioClinico 
								   and          IdEpisodioAtencion = @IdEpisodioAtencion
								   and          TipoMedicamento = @TipoMedicamento
								   and          UnidadReplicacion  = @UnidadReplicacion
								   and          Secuencia = @Secuencia
							END
                           select @Secuencia;
                    END                 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_GE_Medicamento_FEListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[SP_SS_GE_Medicamento_FEListar]
       @UnidadReplicacion  char(4) ,
       @IdPaciente  int ,
       @EpisodioClinico  int ,
       @IdEpisodioAtencion  bigint ,
       @Secuencia  int ,
       @TipoMedicamento int,
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
       @TipoComida int,
       @VolumenDia [varchar](250) ,
       @FrecuenciaToma [varchar](250) ,
       @Presentacion [varchar](250) ,
       @Hora [datetime] ,
       @Periodo VARCHAR(10) ,
       @UnidadTiempo INT  ,
       @Indicacion [varchar](250) ,
       @Estado  int,
       @UsuarioCreacion  varchar(25),
       @FechaCreacion  datetime,
       @UsuarioModificacion  varchar(25),
       @FechaModificacion  datetime,
       @Accion      varchar(50),
       @Version varchar(50),
       @IdPadreNutriente  int,
       @IdHijoNutriente  int
AS
BEGIN
       SET NOCOUNT ON;
   

        IF @Accion ='LISTAR_FARMACO'
           BEGIN  
				SELECT top 1 SS_HC_MedicamentoFarmaco.UnidadReplicacion, SS_HC_MedicamentoFarmaco.IdEpisodioAtencion, 
				SS_HC_MedicamentoFarmaco.IdPaciente, SS_HC_MedicamentoFarmaco.EpisodioClinico, SS_HC_Medicamento.Secuencia, 
				SS_HC_Medicamento.TipoMedicamento,	SS_HC_Medicamento.IdUnidadMedida, SS_HC_Medicamento.Linea, 
				SS_HC_Medicamento.Familia, 	SS_HC_Medicamento.SubFamilia, TipoComponente, CodigoComponente, IdVia, 
				Dosis, DiasTratamiento, Frecuencia, Cantidad, IndicadorEPS, TipoReceta, Forma, GrupoMedicamento,
				SS_HC_MedicamentoFarmaco.DescripcionMedicamento as Comentario, 	IndicadorAuditoria, 
			   +(case when Presentacion IS null OR Presentacion=''
					 then ''else +'Presentacion : '+ SS_HC_Medicamento.Presentacion    end)
			   +(case when Dosis IS null OR Dosis=''
							then ''else + ' Dosis : '+ SS_HC_Medicamento.Dosis   end)                 
			   +(case when  UniMed.DescripcionCorta IS null 
							then ''else ' U.Medida : '+UniMed.DescripcionCorta  end) 
			   +(case when Frecuencia is null  
							then '' else ' Frecuencia : '  + CONVERT(VARCHAR,SS_HC_Medicamento.Frecuencia) end)
			   +(case when  DETUNI.Nombre IS null 
							then ''else ' Und.Tiempo : '+ DETUNI.Nombre  end)  
			   +(case when  SS_HC_Medicamento.Periodo IS null 
							then ''else ' Periodo : '+ SS_HC_Medicamento.Periodo   end) 
			   +(case when  DETTIE.Nombre IS null 
							then ''else ' Und.Tiempo : '+ DETTIE.Nombre  end)  
			   +(case when  Via.Descripcion is null 
							then '' else ' Vía : '+ Via.Descripcion end) 
			   +(case when Cantidad is null  
				   then ''else ' Cantidad : '+ CONVERT(VARCHAR,Cantidad) end)
			   +(case when DETTOR.Nombre IS null 
							then ''else ' T.Receta : '+ DETTOR.Nombre   end) 
			   +(case when Indicacion IS null OR Indicacion=''
							then ''else ' Indicacion : '+ Indicacion   end) as    UsuarioAuditoria, 
               TipoComida,VolumenDia ,    FrecuenciaToma ,    
               Presentacion, Hora  ,      Indicacion,Periodo  ,UnidadTiempo ,
               SS_HC_Medicamento.Estado, SS_HC_Medicamento.UsuarioCreacion, SS_HC_Medicamento.FechaCreacion, 
               SS_HC_Medicamento.UsuarioModificacion,  SS_HC_Medicamento.FechaModificacion,  SS_HC_Medicamento.Accion,
               ( case when (MED.DescripcionLocal IS null OR MED.DescripcionLocal = '') 
                           then LIN.DescripcionLocal +' | '+ FAM.DescripcionLocal +' | '+DCI.DescripcionLocal +' | '+  DCI.DescripcionLocal
                           else LIN.DescripcionLocal +' | '+FAM.DescripcionLocal +' | '+DCI.DescripcionLocal +' | '+  MED.DescripcionLocal  end  ) as Version 
				, SS_HC_Medicamento.INDICADORTI,IdPadreNutriente ,IdHijoNutriente, PADRE.Descripcion PadreDescripcion, HIJO.Descripcion HijoDescripcion ,SS_HC_Medicamento.SecuencialHCE,CodAlmacen --ANGEL 16/07/2019
             FROM  SS_HC_Medicamento_NoFarmacologico_FE AS SS_HC_MedicamentoFarmaco 
			 LEFT joiN SS_HC_Medicamento_FE  SS_HC_Medicamento ON SS_HC_Medicamento.IdPaciente =SS_HC_MedicamentoFarmaco.IdPaciente
             LEFT join WH_ClaseSubFamilia DCI				ON    DCI.Linea = SS_HC_Medicamento.Linea    AND DCI.Familia = SS_HC_Medicamento.Familia
                                        AND DCI.SubFamilia = SS_HC_Medicamento.SubFamilia     
             LEFT join  WH_ItemMast MED						ON  ( rtrim(MED.Item)  =  SS_HC_Medicamento.CodigoComponente )                                        
			 LEFT JOIN  UnidadesMast UniMed                 ON (UniMed.IdUnidadMedida = SS_HC_Medicamento.IdUnidadMedida)
             LEFT JOIN  GE_VARIOS Via                       ON     (Via.CodigoTabla = 'TIPOVIA'    AND Via.Secuencial = SS_HC_Medicamento.IdVia)
             LEFT JOIN  CM_CO_TablaMaestroDetalle DETUNI    ON     (DETUNI.IdTablaMaestro = 102    AND DETUNI.IdCodigo = SS_HC_Medicamento.UnidadTiempo)     
             LEFT JOIN  CM_CO_TablaMaestroDetalle DETTIE    ON     (DETTIE.IdTablaMaestro = 102    AND DETTIE.IdCodigo = SS_HC_Medicamento.TipoComida)       
             LEFT JOIN  CM_CO_TablaMaestroDetalle DETTOR    ON     (DETTOR.IdTablaMaestro = 46     AND DETTOR.IdCodigo = SS_HC_Medicamento.TipoReceta)   
             left JOIN  WH_ClaseFamilia FAM					ON FAM.Linea = SS_HC_Medicamento.Linea AND FAM.Familia = SS_HC_Medicamento.Familia 
             left JOIN  WH_ClaseLinea LIN					ON LIN.Linea =   FAM.Linea 
             LEFT JOIN  SS_HC_CATALOGODIETA PADRE			ON PADRE.Nivel =1  AND PADRE.IdDieta =  IdPadreNutriente
             LEFT JOIN  SS_HC_CATALOGODIETA HIJO			ON HIJO.Nivel  =2  AND HIJO.IdDieta  =  IdHijoNutriente
             WHERE  
						(SS_HC_MedicamentoFarmaco.IdPaciente is null or SS_HC_MedicamentoFarmaco.IdPaciente = @IdPaciente) 
                   AND  (@EpisodioClinico is null or SS_HC_MedicamentoFarmaco.EpisodioClinico =@EpisodioClinico )
                   AND  (@UnidadReplicacion is null or SS_HC_MedicamentoFarmaco.UnidadReplicacion =@UnidadReplicacion )
                   AND  (@IdEpisodioAtencion is null or SS_HC_MedicamentoFarmaco.IdEpisodioAtencion = @IdEpisodioAtencion)
     
           END

        IF @Accion ='LISTAR'
              BEGIN    
                SELECT SS_HC_Medicamento.UnidadReplicacion, SS_HC_Medicamento.IdEpisodioAtencion, SS_HC_Medicamento.IdPaciente, SS_HC_Medicamento.EpisodioClinico, Secuencia, 
                SS_HC_Medicamento.TipoMedicamento,
                SS_HC_Medicamento.IdUnidadMedida, SS_HC_Medicamento.Linea, SS_HC_Medicamento.Familia, 
                SS_HC_Medicamento.SubFamilia, TipoComponente, CodigoComponente, IdVia, 
                Dosis, DiasTratamiento, Frecuencia, Cantidad, IndicadorEPS, TipoReceta, Forma, GrupoMedicamento,Comentario, 
                IndicadorAuditoria, 
				+(case when Presentacion IS null OR Presentacion=''
						then ''else +'Presentacion : '+ SS_HC_Medicamento.Presentacion    end)
				+(case when Dosis IS null OR Dosis=''
							then ''else + ' Dosis : '+ SS_HC_Medicamento.Dosis   end)                 
				+(case when  UniMed.DescripcionCorta IS null 
							then ''else ' U.Medida : '+UniMed.DescripcionCorta  end) 
				+(case when Frecuencia is null  
							then '' else ' Frecuencia : '     + CONVERT(VARCHAR,SS_HC_Medicamento.Frecuencia) end)
				+(case when  DETUNI.Nombre IS null 
							then ''else ' Und.Tiempo : '+ DETUNI.Nombre  end)  
				+(case when  SS_HC_Medicamento.Periodo IS null 
							then ''else ' Periodo : '+ SS_HC_Medicamento.Periodo   end) 
				+(case when  DETTIE.Nombre IS null 
							then ''else ' Und.Tiempo : '+ DETTIE.Nombre  end)  
				+(case when  Via.Descripcion is null 
							then '' else ' Vía : '+ Via.Descripcion end) 
				+(case when Cantidad is null  
					then ''else ' Cantidad : '+ CONVERT(VARCHAR,Cantidad) end)
				+(case when DETTOR.Nombre IS null 
							then ''else ' T.Receta : '+ DETTOR.Nombre   end) 
				+(case when Indicacion IS null OR Indicacion=''
							then ''else ' Indicacion : '+ Indicacion   end) as   UsuarioAuditoria, 
							TipoComida,VolumenDia ,    ISNULL(convert(varchar(20),SOLICITUD.IdSolicitudProducto),'N') as "FrecuenciaToma", 
                Presentacion, Hora  ,      Indicacion,Periodo  ,UnidadTiempo ,
                SS_HC_Medicamento.Estado, SS_HC_Medicamento.UsuarioCreacion, SS_HC_Medicamento.FechaCreacion, 
                SS_HC_Medicamento.UsuarioModificacion,  SS_HC_Medicamento.FechaModificacion,        SS_HC_Medicamento.Accion,
                ( case when (MED.DescripcionLocal IS null OR MED.DescripcionLocal = '') 
                            then LIN.DescripcionLocal +' | '+ FAM.DescripcionLocal +' | '+DCI.DescripcionLocal +' | '+  DCI.DescripcionLocal
                                else LIN.DescripcionLocal +' | '+FAM.DescripcionLocal +' | '+DCI.DescripcionLocal +' | '+  MED.DescripcionLocal  end  ) as Version 
				, SS_HC_Medicamento.INDICADORTI,IdPadreNutriente ,IdHijoNutriente, PADRE.Descripcion PadreDescripcion, HIJO.Descripcion HijoDescripcion ,SecuencialHCE,CodAlmacen --ANGEL 16/07/2019
                FROM  SS_HC_Medicamento_FE AS SS_HC_Medicamento 
				Left join WH_ClaseSubFamilia DCI				ON     DCI.Linea = SS_HC_Medicamento.Linea   AND DCI.Familia = SS_HC_Medicamento.Familia
                                    AND DCI.SubFamilia = SS_HC_Medicamento.SubFamilia     
				Left join  WH_ItemMast MED						ON     ( rtrim(MED.Item)  =  SS_HC_Medicamento.CodigoComponente )                                        
				LEFT JOIN  UnidadesMast UniMed					ON (UniMed.IdUnidadMedida = SS_HC_Medicamento.IdUnidadMedida)
				LEFT JOIN  GE_VARIOS Via						ON     (Via.CodigoTabla = 'TIPOVIA'    AND Via.Secuencial = SS_HC_Medicamento.IdVia)
				LEFT JOIN  CM_CO_TablaMaestroDetalle DETUNI		ON     (DETUNI.IdTablaMaestro = 102      AND DETUNI.IdCodigo = SS_HC_Medicamento.UnidadTiempo)     
				LEFT JOIN  CM_CO_TablaMaestroDetalle DETTIE		ON     (DETTIE.IdTablaMaestro = 102      AND DETTIE.IdCodigo = SS_HC_Medicamento.TipoComida)       
				LEFT JOIN  CM_CO_TablaMaestroDetalle DETTOR		ON     (DETTOR.IdTablaMaestro = 46              AND DETTOR.IdCodigo = SS_HC_Medicamento.TipoReceta)   
				left JOIN  WH_ClaseFamilia FAM					ON FAM.Linea = SS_HC_Medicamento.Linea AND FAM.Familia = SS_HC_Medicamento.Familia 
				left JOIN  WH_ClaseLinea LIN					ON LIN.Linea =   FAM.Linea 
				LEFT JOIN  SS_HC_CATALOGODIETA PADRE			ON PADRE.Nivel =1  AND PADRE.IdDieta =  IdPadreNutriente
				LEFT JOIN  SS_HC_CATALOGODIETA HIJO				ON HIJO.Nivel  =2   AND HIJO.IdDieta  =  IdHijoNutriente
				LEFT JOIN SS_FA_SolicitudProducto SOLICITUD  WITH(NOLOCK) ON SOLICITUD.UnidadReplicacion= SS_HC_Medicamento.UnidadReplicacion and 
				SOLICITUD.IdEpisodioAtencion =SS_HC_Medicamento.IdEpisodioAtencion AND SOLICITUD.IdPaciente= SS_HC_Medicamento.IdPaciente AND
				SOLICITUD.EpisodioClinico = SS_HC_Medicamento.EpisodioClinico
				Where  
							(SS_HC_Medicamento.IdPaciente is null or SS_HC_Medicamento.IdPaciente = @IdPaciente) 
                    and   (@EpisodioClinico is null or SS_HC_Medicamento.EpisodioClinico =@EpisodioClinico )
                    and   (@UnidadReplicacion is null or SS_HC_Medicamento.UnidadReplicacion =@UnidadReplicacion )
                    and   (@IdEpisodioAtencion is null or SS_HC_Medicamento.IdEpisodioAtencion = @IdEpisodioAtencion)
                    and   (@TipoMedicamento is null or SS_HC_Medicamento.TipoMedicamento =@TipoMedicamento)
                    and   (@GrupoMedicamento is null or SS_HC_Medicamento.GrupoMedicamento =@GrupoMedicamento)
					--and   (@Secuencia is null or SS_HC_Medicamento.Secuencia =@Secuencia)
					--and SS_HC_Medicamento.Secuencia = ISNULL(@Secuencia, SS_HC_Medicamento.Secuencia)
            END

			IF @Accion ='LISTARCOPIADO'
              BEGIN    
                SELECT SS_HC_Medicamento.UnidadReplicacion, SS_HC_Medicamento.IdEpisodioAtencion, SS_HC_Medicamento.IdPaciente, SS_HC_Medicamento.EpisodioClinico, Secuencia, 
                SS_HC_Medicamento.TipoMedicamento,
                SS_HC_Medicamento.IdUnidadMedida, SS_HC_Medicamento.Linea, SS_HC_Medicamento.Familia, 
                SS_HC_Medicamento.SubFamilia, TipoComponente, CodigoComponente, IdVia, 
                Dosis, DiasTratamiento, Frecuencia, Cantidad, IndicadorEPS, TipoReceta, Forma, GrupoMedicamento,Comentario, 
                IndicadorAuditoria, 
				+(case when Presentacion IS null OR Presentacion=''
						then ''else +'Presentacion : '+ SS_HC_Medicamento.Presentacion    end)
				+(case when Dosis IS null OR Dosis=''
							then ''else + ' Dosis : '+ SS_HC_Medicamento.Dosis   end)                 
				+(case when  UniMed.DescripcionCorta IS null 
							then ''else ' U.Medida : '+UniMed.DescripcionCorta  end) 
				+(case when Frecuencia is null  
							then '' else ' Frecuencia : '     + CONVERT(VARCHAR,SS_HC_Medicamento.Frecuencia) end)
				+(case when  DETUNI.Nombre IS null 
							then ''else ' Und.Tiempo : '+ DETUNI.Nombre  end)  
				+(case when  SS_HC_Medicamento.Periodo IS null 
							then ''else ' Periodo : '+ SS_HC_Medicamento.Periodo   end) 
				+(case when  DETTIE.Nombre IS null 
							then ''else ' Und.Tiempo : '+ DETTIE.Nombre  end)  
				+(case when  Via.Descripcion is null 
							then '' else ' Vía : '+ Via.Descripcion end) 
				+(case when Cantidad is null  
					then ''else ' Cantidad : '+ CONVERT(VARCHAR,Cantidad) end)
				+(case when DETTOR.Nombre IS null 
							then ''else ' T.Receta : '+ DETTOR.Nombre   end) 
				+(case when Indicacion IS null OR Indicacion=''
							then ''else ' Indicacion : '+ Indicacion   end) as   UsuarioAuditoria, 
							TipoComida,VolumenDia ,    ISNULL(convert(varchar(20),SOLICITUD.IdSolicitudProducto),'N') as "FrecuenciaToma", 
                Presentacion, Hora  ,      Indicacion,Periodo  ,UnidadTiempo ,
                SS_HC_Medicamento.Estado, SS_HC_Medicamento.UsuarioCreacion, SS_HC_Medicamento.FechaCreacion, 
                SS_HC_Medicamento.UsuarioModificacion,  SS_HC_Medicamento.FechaModificacion,        SS_HC_Medicamento.Accion,
                ( case when (MED.DescripcionLocal IS null OR MED.DescripcionLocal = '') 
                            then LIN.DescripcionLocal +' | '+ FAM.DescripcionLocal +' | '+DCI.DescripcionLocal +' | '+  DCI.DescripcionLocal
                                else LIN.DescripcionLocal +' | '+FAM.DescripcionLocal +' | '+DCI.DescripcionLocal +' | '+  MED.DescripcionLocal  end  ) as Version 
				, SS_HC_Medicamento.INDICADORTI,IdPadreNutriente ,IdHijoNutriente, PADRE.Descripcion PadreDescripcion, HIJO.Descripcion HijoDescripcion ,SecuencialHCE,CodAlmacen --ANGEL 16/07/2019
                FROM  SS_HC_Medicamento_FE AS SS_HC_Medicamento 
				Left join WH_ClaseSubFamilia DCI				ON     DCI.Linea = SS_HC_Medicamento.Linea   AND DCI.Familia = SS_HC_Medicamento.Familia
                                    AND DCI.SubFamilia = SS_HC_Medicamento.SubFamilia     
				Left join  WH_ItemMast MED						ON     ( rtrim(MED.Item)  =  SS_HC_Medicamento.CodigoComponente )                                        
				LEFT JOIN  UnidadesMast UniMed					ON (UniMed.IdUnidadMedida = SS_HC_Medicamento.IdUnidadMedida)
				LEFT JOIN  GE_VARIOS Via						ON     (Via.CodigoTabla = 'TIPOVIA'    AND Via.Secuencial = SS_HC_Medicamento.IdVia)
				LEFT JOIN  CM_CO_TablaMaestroDetalle DETUNI		ON     (DETUNI.IdTablaMaestro = 102      AND DETUNI.IdCodigo = SS_HC_Medicamento.UnidadTiempo)     
				LEFT JOIN  CM_CO_TablaMaestroDetalle DETTIE		ON     (DETTIE.IdTablaMaestro = 102      AND DETTIE.IdCodigo = SS_HC_Medicamento.TipoComida)       
				LEFT JOIN  CM_CO_TablaMaestroDetalle DETTOR		ON     (DETTOR.IdTablaMaestro = 46              AND DETTOR.IdCodigo = SS_HC_Medicamento.TipoReceta)   
				left JOIN  WH_ClaseFamilia FAM					ON FAM.Linea = SS_HC_Medicamento.Linea AND FAM.Familia = SS_HC_Medicamento.Familia 
				left JOIN  WH_ClaseLinea LIN					ON LIN.Linea =   FAM.Linea 
				LEFT JOIN  SS_HC_CATALOGODIETA PADRE			ON PADRE.Nivel =1  AND PADRE.IdDieta =  IdPadreNutriente
				LEFT JOIN  SS_HC_CATALOGODIETA HIJO				ON HIJO.Nivel  =2   AND HIJO.IdDieta  =  IdHijoNutriente
				LEFT JOIN SS_FA_SolicitudProducto SOLICITUD  WITH(NOLOCK) ON SOLICITUD.UnidadReplicacion= SS_HC_Medicamento.UnidadReplicacion and 
				SOLICITUD.IdEpisodioAtencion =SS_HC_Medicamento.IdEpisodioAtencion AND SOLICITUD.IdPaciente= SS_HC_Medicamento.IdPaciente AND
				SOLICITUD.EpisodioClinico = SS_HC_Medicamento.EpisodioClinico
				Where  
							(SS_HC_Medicamento.IdPaciente is null or SS_HC_Medicamento.IdPaciente = @IdPaciente) 
                    and   (@EpisodioClinico is null or SS_HC_Medicamento.EpisodioClinico =@EpisodioClinico )
                    and   (@UnidadReplicacion is null or SS_HC_Medicamento.UnidadReplicacion =@UnidadReplicacion )
                    and   (@IdEpisodioAtencion is null or SS_HC_Medicamento.IdEpisodioAtencion = @IdEpisodioAtencion)
                    and   (@TipoMedicamento is null or SS_HC_Medicamento.TipoMedicamento =@TipoMedicamento)
                    and   (@GrupoMedicamento is null or SS_HC_Medicamento.GrupoMedicamento =@GrupoMedicamento)
					--and   (@Secuencia is null or SS_HC_Medicamento.Secuencia =@Secuencia)
					and SS_HC_Medicamento.Secuencia = ISNULL(@Secuencia, SS_HC_Medicamento.Secuencia)
            END

		IF @Accion ='LISTAREPI2'
			BEGIN	
				SELECT SS_HC_Medicamento.UnidadReplicacion, IdEpisodioAtencion, IdPaciente, EpisodioClinico, Secuencia, 
				SS_HC_Medicamento.TipoMedicamento,
				SS_HC_Medicamento.IdUnidadMedida, SS_HC_Medicamento.Linea, SS_HC_Medicamento.Familia, 
				SS_HC_Medicamento.SubFamilia, TipoComponente, CodigoComponente, IdVia, 
				Dosis, DiasTratamiento, Frecuencia, Cantidad, IndicadorEPS, TipoReceta, Forma, GrupoMedicamento,Comentario, 
				IndicadorAuditoria, 
				+(case when Presentacion IS null OR Presentacion=''
					then ''else +'Presentacion : '+ SS_HC_Medicamento.Presentacion    end)
				+(case when Dosis IS null OR Dosis=''
						then ''else + ' Dosis : '+ SS_HC_Medicamento.Dosis   end)			
				+(case when  UniMed.DescripcionCorta IS null 
						then ''else ' U.Medida : '+UniMed.DescripcionCorta  end) 
				+(case when Frecuencia is null  
						then '' else ' Frecuencia : '	+ CONVERT(VARCHAR,SS_HC_Medicamento.Frecuencia) end)
				+(case when  DETUNI.Nombre IS null 
						then ''else ' Und.Tiempo : '+ DETUNI.Nombre  end)  
				+(case when  SS_HC_Medicamento.Periodo IS null 
						then ''else ' Periodo : '+ SS_HC_Medicamento.Periodo   end) 
				+(case when  DETTIE.Nombre IS null 
						then ''else ' Und.Tiempo : '+ DETTIE.Nombre  end)  
				+(case when  Via.Descripcion is null 
						then '' else ' Vía : '+ Via.Descripcion end) 
				+(case when Cantidad is null  
					then ''else ' Cantidad : '+ CONVERT(VARCHAR,Cantidad) end)
				+(case when DETTOR.Nombre IS null 
						then ''else ' T.Receta : '+ DETTOR.Nombre   end) 
				+(case when Indicacion IS null OR Indicacion=''
						then ''else ' Indicacion : '+ Indicacion   end) as	UsuarioAuditoria, 
				TipoComida,VolumenDia ,	FrecuenciaToma ,	
				Presentacion,	Hora  ,	Indicacion,Periodo  ,UnidadTiempo ,
				SS_HC_Medicamento.Estado, SS_HC_Medicamento.UsuarioCreacion, SS_HC_Medicamento.FechaCreacion, 
				SS_HC_Medicamento.UsuarioModificacion,	SS_HC_Medicamento.FechaModificacion, 	SS_HC_Medicamento.Accion,
				( case when (MED.DescripcionLocal IS null OR MED.DescripcionLocal = '') 
							then LIN.DescripcionLocal +' | '+ FAM.DescripcionLocal +' | '+DCI.DescripcionLocal +' | '+  DCI.DescripcionLocal
							else LIN.DescripcionLocal +' | '+FAM.DescripcionLocal +' | '+DCI.DescripcionLocal +' | '+  MED.DescripcionLocal  end  ) as Version 
				, SS_HC_Medicamento.INDICADORTI,IdPadreNutriente ,IdHijoNutriente, PADRE.Descripcion PadreDescripcion, HIJO.Descripcion HijoDescripcion,SecuencialHCE,CodAlmacen --ANGEL 16/07/2019
				FROM  SS_HC_Medicamento_FE_Epi2 AS SS_HC_Medicamento
					Left join WH_ClaseSubFamilia DCI			ON 	DCI.Linea = SS_HC_Medicamento.Linea		AND DCI.Familia = SS_HC_Medicamento.Familia
									AND DCI.SubFamilia = SS_HC_Medicamento.SubFamilia	
					Left join  WH_ItemMast MED					ON 	( rtrim(MED.Item)  =  SS_HC_Medicamento.CodigoComponente )						
					LEFT JOIN  UnidadesMast UniMed				ON (UniMed.IdUnidadMedida = SS_HC_Medicamento.IdUnidadMedida)
					LEFT JOIN  GE_VARIOS Via					ON 	(Via.CodigoTabla = 'TIPOVIA'	AND Via.Secuencial = SS_HC_Medicamento.IdVia)
					LEFT JOIN  CM_CO_TablaMaestroDetalle DETUNI	ON 	(DETUNI.IdTablaMaestro = 102	AND DETUNI.IdCodigo = SS_HC_Medicamento.UnidadTiempo)	
					LEFT JOIN  CM_CO_TablaMaestroDetalle DETTIE	ON 	(DETTIE.IdTablaMaestro = 102	AND DETTIE.IdCodigo = SS_HC_Medicamento.TipoComida)	
					LEFT JOIN  CM_CO_TablaMaestroDetalle DETTOR	ON 	(DETTOR.IdTablaMaestro = 46		AND DETTOR.IdCodigo = SS_HC_Medicamento.TipoReceta)	
					left JOIN  WH_ClaseFamilia FAM				ON FAM.Linea = SS_HC_Medicamento.Linea AND FAM.Familia = SS_HC_Medicamento.Familia 
					left JOIN  WH_ClaseLinea LIN				ON LIN.Linea =   FAM.Linea 
					LEFT JOIN  SS_HC_CATALOGODIETA PADRE		ON PADRE.Nivel =1  AND PADRE.IdDieta =  IdPadreNutriente
					LEFT JOIN  SS_HC_CATALOGODIETA HIJO			ON HIJO.Nivel  =2   AND HIJO.IdDieta  =  IdHijoNutriente
					Where	
						(IdPaciente is null or SS_HC_Medicamento.IdPaciente = @IdPaciente) 
						and		(@EpisodioClinico is null or EpisodioClinico =@EpisodioClinico )
			 			and		(@UnidadReplicacion is null or SS_HC_Medicamento.UnidadReplicacion =@UnidadReplicacion )
						and		(@IdEpisodioAtencion is null or IdEpisodioAtencion = @IdEpisodioAtencion)
						and		(@TipoMedicamento is null or SS_HC_Medicamento.TipoMedicamento =@TipoMedicamento)
						and		(@GrupoMedicamento is null or SS_HC_Medicamento.GrupoMedicamento =@GrupoMedicamento)
			END
			
		IF @Accion ='LISTARK'
			 BEGIN
				 SELECT UnidadReplicacion, IdEpisodioAtencion, IdPaciente, EpisodioClinico, Secuencia, 
					null as TipoMedicamento,
					null as IdUnidadMedida, null as Linea, null as Familia, 
					null as SubFamilia, null as TipoComponente, CodigoComponente, IdVia, 
					Dosis, DiasTratamiento, Frecuencia, Cantidad, null as IndicadorEPS, null as TipoReceta, null as Forma, null as GrupoMedicamento,null as Comentario, 
					IndicadorAuditoria, UsuarioAuditoria, 
				TipoComida,VolumenDia ,	FrecuenciaToma ,	
					null as Presentacion,	HoraInicio as Hora  ,	null as Indicacion,Periodo  ,UnidadTiempo ,
					Estado,UsuarioCreacion, FechaCreacion, 
					UsuarioModificacion, HoraAdministracion as FechaModificacion, 
					Accion,Descripcion Version, null as INDICADORTI,null as IdPadreNutriente ,
					null as IdHijoNutriente,Descripcion as PadreDescripcion,null as  HijoDescripcion,SecuencialHCE,CodAlmacen --ANGEL 16/07/2019
				FROM  SS_HC_Medicamento_Kardex_FE 
				
			--	ALTER TABLE SS_HC_Medicamento_Kardex_FE ADD SecuencialHCE VARCHAR(20) NULL, CodAlmacen varchar(20) NULL ;
				Where	
				(SS_HC_Medicamento_Kardex_FE.IdPaciente is null or SS_HC_Medicamento_Kardex_FE.IdPaciente = @IdPaciente) 
				and		(@EpisodioClinico is null or SS_HC_Medicamento_Kardex_FE.EpisodioClinico =@EpisodioClinico )
			 	and		(@UnidadReplicacion is null or SS_HC_Medicamento_Kardex_FE.UnidadReplicacion =@UnidadReplicacion )
				and		(@IdEpisodioAtencion is null or SS_HC_Medicamento_Kardex_FE.IdEpisodioAtencion = @IdEpisodioAtencion)

			 END

		IF @Accion ='LISTARK1'
              BEGIN    

			   declare  @episodio int
			   declare  @clinico int
		      -- declare  @secuencia int

			     set @clinico =(select max(SS_HC_Medicamento.EpisodioClinico)  from SS_HC_Medicamento_FE as SS_HC_Medicamento left JOIN SS_HC_EpisodioAtencion epi
				  on epi.IdPaciente=   SS_HC_Medicamento.IdPaciente and epi.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and epi.EpisodioClinico= SS_HC_Medicamento.EpisodioClinico
				  where epi.CodigoOA=@CodigoComponente)

				 set @episodio =(select max(SS_HC_Medicamento.IdEpisodioAtencion)  from SS_HC_Medicamento_FE as SS_HC_Medicamento left JOIN SS_HC_EpisodioAtencion epi
				  on epi.IdPaciente=   SS_HC_Medicamento.IdPaciente and epi.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and epi.EpisodioClinico= SS_HC_Medicamento.EpisodioClinico
				  where epi.CodigoOA=@CodigoComponente and SS_HC_Medicamento.EpisodioClinico =@clinico)

				  set @secuencia =(select max(SS_HC_Medicamento.Secuencia)  from SS_HC_Medicamento_FE as SS_HC_Medicamento left JOIN SS_HC_EpisodioAtencion epi
				  on epi.IdPaciente=   SS_HC_Medicamento.IdPaciente and epi.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and epi.EpisodioClinico= SS_HC_Medicamento.EpisodioClinico
				  where epi.CodigoOA=@CodigoComponente)


                SELECT SS_HC_Medicamento.UnidadReplicacion, SS_HC_Medicamento.IdEpisodioAtencion, SS_HC_Medicamento.IdPaciente, SS_HC_Medicamento.EpisodioClinico, SS_HC_Medicamento.Secuencia, 
                SS_HC_Medicamento.TipoMedicamento,
                SS_HC_Medicamento.IdUnidadMedida, SS_HC_Medicamento.Linea, SS_HC_Medicamento.Familia, 
                SS_HC_Medicamento.SubFamilia, TipoComponente, CodigoComponente, IdVia, 
                Dosis, DiasTratamiento, Frecuencia, Cantidad, IndicadorEPS, TipoReceta, Forma, GrupoMedicamento,Comentario, 
                IndicadorAuditoria, 
				+(case when Presentacion IS null OR Presentacion=''
						then ''else +'Presentacion : '+ SS_HC_Medicamento.Presentacion    end)
				+(case when Dosis IS null OR Dosis=''
							then ''else + ' Dosis : '+ SS_HC_Medicamento.Dosis   end)                 
				+(case when  UniMed.DescripcionCorta IS null 
							then ''else ' U.Medida : '+UniMed.DescripcionCorta  end) 
				+(case when Frecuencia is null  
							then '' else ' Frecuencia : '     + CONVERT(VARCHAR,SS_HC_Medicamento.Frecuencia) end)
				+(case when  DETUNI.Nombre IS null 
							then ''else ' Und.Tiempo : '+ DETUNI.Nombre  end)  
				+(case when  SS_HC_Medicamento.Periodo IS null 
							then ''else ' Periodo : '+ SS_HC_Medicamento.Periodo   end) 
				+(case when  DETTIE.Nombre IS null 
							then ''else ' Und.Tiempo : '+ DETTIE.Nombre  end)  
				+(case when  Via.Descripcion is null 
							then '' else ' Vía : '+ Via.Descripcion end) 
				+(case when Cantidad is null  
					then ''else ' Cantidad : '+ CONVERT(VARCHAR,Cantidad) end)
				+(case when DETTOR.Nombre IS null 
							then ''else ' T.Receta : '+ DETTOR.Nombre   end) 
				+(case when Indicacion IS null OR Indicacion=''
							then ''else ' Indicacion : '+ Indicacion   end) as   UsuarioAuditoria, 
							TipoComida,VolumenDia ,    FrecuenciaToma ,    
                Presentacion, Hora  ,      Indicacion,Periodo  ,UnidadTiempo ,
                SS_HC_Medicamento.Estado, SS_HC_Medicamento.UsuarioCreacion, SS_HC_Medicamento.FechaCreacion, 
                SS_HC_Medicamento.UsuarioModificacion,  SS_HC_Medicamento.FechaModificacion,        SS_HC_Medicamento.Accion,
                ( case when (MED.DescripcionLocal IS null OR MED.DescripcionLocal = '') 
                            then LIN.DescripcionLocal +' | '+ FAM.DescripcionLocal +' | '+DCI.DescripcionLocal +' | '+  DCI.DescripcionLocal
                                else LIN.DescripcionLocal +' | '+FAM.DescripcionLocal +' | '+DCI.DescripcionLocal +' | '+  MED.DescripcionLocal  end  ) as Version 
				, SS_HC_Medicamento.INDICADORTI,IdPadreNutriente ,IdHijoNutriente, PADRE.Descripcion PadreDescripcion, HIJO.Descripcion HijoDescripcion ,SecuencialHCE,CodAlmacen --ANGEL 16/07/2019
                FROM  SS_HC_Medicamento_FE AS SS_HC_Medicamento 
				Left join WH_ClaseSubFamilia DCI				ON     DCI.Linea = SS_HC_Medicamento.Linea   AND DCI.Familia = SS_HC_Medicamento.Familia
                                    AND DCI.SubFamilia = SS_HC_Medicamento.SubFamilia     
				Left join  WH_ItemMast MED						ON     ( rtrim(MED.Item)  =  SS_HC_Medicamento.CodigoComponente )                                        
				LEFT JOIN  UnidadesMast UniMed					ON (UniMed.IdUnidadMedida = SS_HC_Medicamento.IdUnidadMedida)
				LEFT JOIN  GE_VARIOS Via						ON     (Via.CodigoTabla = 'TIPOVIA'    AND Via.Secuencial = SS_HC_Medicamento.IdVia)
				LEFT JOIN  CM_CO_TablaMaestroDetalle DETUNI		ON     (DETUNI.IdTablaMaestro = 102      AND DETUNI.IdCodigo = SS_HC_Medicamento.UnidadTiempo)     
				LEFT JOIN  CM_CO_TablaMaestroDetalle DETTIE		ON     (DETTIE.IdTablaMaestro = 102      AND DETTIE.IdCodigo = SS_HC_Medicamento.TipoComida)       
				LEFT JOIN  CM_CO_TablaMaestroDetalle DETTOR		ON     (DETTOR.IdTablaMaestro = 46              AND DETTOR.IdCodigo = SS_HC_Medicamento.TipoReceta)   
				left JOIN  WH_ClaseFamilia FAM					ON FAM.Linea = SS_HC_Medicamento.Linea AND FAM.Familia = SS_HC_Medicamento.Familia 
				left JOIN  WH_ClaseLinea LIN					ON LIN.Linea =   FAM.Linea 
				LEFT JOIN  SS_HC_CATALOGODIETA PADRE			ON PADRE.Nivel =1  AND PADRE.IdDieta =  IdPadreNutriente
				LEFT JOIN  SS_HC_CATALOGODIETA HIJO				ON HIJO.Nivel  =2   AND HIJO.IdDieta  =  IdHijoNutriente
			   left JOIN SS_HC_EpisodioAtencion epi
			  on epi.IdPaciente=   SS_HC_Medicamento.IdPaciente and epi.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and epi.EpisodioClinico= SS_HC_Medicamento.EpisodioClinico
  					  WHERE   SS_HC_Medicamento.IdPaciente =@IdPaciente    
				  and epi.CodigoOA=@CodigoComponente
				  AND   SS_HC_Medicamento.EpisodioClinico = @clinico 
				  AND   SS_HC_Medicamento.IdEpisodioAtencion = @episodio      
				  AND   ltrim(rtrim(SS_HC_Medicamento.UnidadReplicacion)) = ltrim(rtrim(@UnidadReplicacion))  
				   and   (@TipoMedicamento is null or SS_HC_Medicamento.TipoMedicamento =@TipoMedicamento)
            END


       IF @Accion ='LISTARK0'
              BEGIN    
                SELECT SS_HC_Medicamento.UnidadReplicacion, IdEpisodioAtencion, IdPaciente, EpisodioClinico, Secuencia, 
                SS_HC_Medicamento.TipoMedicamento,
                SS_HC_Medicamento.IdUnidadMedida, SS_HC_Medicamento.Linea, SS_HC_Medicamento.Familia, 
                SS_HC_Medicamento.SubFamilia, TipoComponente, CodigoComponente, IdVia, 
                Dosis, DiasTratamiento, Frecuencia, Cantidad, IndicadorEPS, TipoReceta, Forma, GrupoMedicamento,Comentario, 
                IndicadorAuditoria, 
				+(case when Presentacion IS null OR Presentacion=''
						then ''else +'Presentacion : '+ SS_HC_Medicamento.Presentacion    end)
				+(case when Dosis IS null OR Dosis=''
							then ''else + ' Dosis : '+ SS_HC_Medicamento.Dosis   end)                 
				+(case when  UniMed.DescripcionCorta IS null 
							then ''else ' U.Medida : '+UniMed.DescripcionCorta  end) 
				+(case when Frecuencia is null  
							then '' else ' Frecuencia : '     + CONVERT(VARCHAR,SS_HC_Medicamento.Frecuencia) end)
				+(case when  DETUNI.Nombre IS null 
							then ''else ' Und.Tiempo : '+ DETUNI.Nombre  end)  
				+(case when  SS_HC_Medicamento.Periodo IS null 
							then ''else ' Periodo : '+ SS_HC_Medicamento.Periodo   end) 
				+(case when  DETTIE.Nombre IS null 
							then ''else ' Und.Tiempo : '+ DETTIE.Nombre  end)  
				+(case when  Via.Descripcion is null 
							then '' else ' Vía : '+ Via.Descripcion end) 
				+(case when Cantidad is null  
					then ''else ' Cantidad : '+ CONVERT(VARCHAR,Cantidad) end)
				+(case when DETTOR.Nombre IS null 
							then ''else ' T.Receta : '+ DETTOR.Nombre   end) 
				+(case when Indicacion IS null OR Indicacion=''
							then ''else ' Indicacion : '+ Indicacion   end) as   UsuarioAuditoria, 
							TipoComida,VolumenDia ,    FrecuenciaToma ,    
                Presentacion, Hora  ,      Indicacion,Periodo  ,UnidadTiempo ,
                SS_HC_Medicamento.Estado, SS_HC_Medicamento.UsuarioCreacion, SS_HC_Medicamento.FechaCreacion, 
                SS_HC_Medicamento.UsuarioModificacion,  SS_HC_Medicamento.FechaModificacion,        SS_HC_Medicamento.Accion,
                ( case when (MED.DescripcionLocal IS null OR MED.DescripcionLocal = '') 
                            then LIN.DescripcionLocal +' | '+ FAM.DescripcionLocal +' | '+DCI.DescripcionLocal +' | '+  DCI.DescripcionLocal
                                else LIN.DescripcionLocal +' | '+FAM.DescripcionLocal +' | '+DCI.DescripcionLocal +' | '+  MED.DescripcionLocal  end  ) as Version 
				, SS_HC_Medicamento.INDICADORTI,IdPadreNutriente ,IdHijoNutriente, PADRE.Descripcion PadreDescripcion, HIJO.Descripcion HijoDescripcion ,SecuencialHCE,CodAlmacen --ANGEL 16/07/2019
                FROM  SS_HC_Medicamento_FE AS SS_HC_Medicamento 
				Left join WH_ClaseSubFamilia DCI				ON     DCI.Linea = SS_HC_Medicamento.Linea   AND DCI.Familia = SS_HC_Medicamento.Familia
                                    AND DCI.SubFamilia = SS_HC_Medicamento.SubFamilia     
				Left join  WH_ItemMast MED						ON     ( rtrim(MED.Item)  =  SS_HC_Medicamento.CodigoComponente )                                        
				LEFT JOIN  UnidadesMast UniMed					ON (UniMed.IdUnidadMedida = SS_HC_Medicamento.IdUnidadMedida)
				LEFT JOIN  GE_VARIOS Via						ON     (Via.CodigoTabla = 'TIPOVIA'    AND Via.Secuencial = SS_HC_Medicamento.IdVia)
				LEFT JOIN  CM_CO_TablaMaestroDetalle DETUNI		ON     (DETUNI.IdTablaMaestro = 102      AND DETUNI.IdCodigo = SS_HC_Medicamento.UnidadTiempo)     
				LEFT JOIN  CM_CO_TablaMaestroDetalle DETTIE		ON     (DETTIE.IdTablaMaestro = 102      AND DETTIE.IdCodigo = SS_HC_Medicamento.TipoComida)       
				LEFT JOIN  CM_CO_TablaMaestroDetalle DETTOR		ON     (DETTOR.IdTablaMaestro = 46              AND DETTOR.IdCodigo = SS_HC_Medicamento.TipoReceta)   
				left JOIN  WH_ClaseFamilia FAM					ON FAM.Linea = SS_HC_Medicamento.Linea AND FAM.Familia = SS_HC_Medicamento.Familia 
				left JOIN  WH_ClaseLinea LIN					ON LIN.Linea =   FAM.Linea 
				LEFT JOIN  SS_HC_CATALOGODIETA PADRE			ON PADRE.Nivel =1  AND PADRE.IdDieta =  IdPadreNutriente
				LEFT JOIN  SS_HC_CATALOGODIETA HIJO				ON HIJO.Nivel  =2   AND HIJO.IdDieta  =  IdHijoNutriente
				Where  
							(IdPaciente is null or SS_HC_Medicamento.IdPaciente = @IdPaciente) 
                    and   (@EpisodioClinico is null or EpisodioClinico =@EpisodioClinico )
                    and   (@UnidadReplicacion is null or SS_HC_Medicamento.UnidadReplicacion =@UnidadReplicacion )
                   -- and   (@IdEpisodioAtencion is null or IdEpisodioAtencion = @IdEpisodioAtencion)
                    and   (@TipoMedicamento is null or SS_HC_Medicamento.TipoMedicamento =@TipoMedicamento)
                    and   (@GrupoMedicamento is null or SS_HC_Medicamento.GrupoMedicamento =@GrupoMedicamento)
					and SS_HC_Medicamento.Estado=1
            END
			 
			   IF @Accion ='LISTARKMED'
              BEGIN 

			   declare  @episodio2 int
			   declare  @clinico2 int
		       declare  @secuencia2 int

			     set @clinico2 =(select max(SS_HC_Medicamento.EpisodioClinico)  from SS_HC_Medicamento_FE as SS_HC_Medicamento left JOIN SS_HC_EpisodioAtencion epi
				  on epi.IdPaciente=   SS_HC_Medicamento.IdPaciente and epi.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and epi.EpisodioClinico= SS_HC_Medicamento.EpisodioClinico
				  where epi.CodigoOA=@CodigoComponente)

				 set @episodio2 =(select max(SS_HC_Medicamento.IdEpisodioAtencion)  from SS_HC_Medicamento_FE as SS_HC_Medicamento left JOIN SS_HC_EpisodioAtencion epi
				  on epi.IdPaciente=   SS_HC_Medicamento.IdPaciente and epi.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion and epi.EpisodioClinico= SS_HC_Medicamento.EpisodioClinico
				  where epi.CodigoOA=@CodigoComponente and SS_HC_Medicamento.EpisodioClinico =@clinico2)

                SELECT SS_HC_Medicamento.UnidadReplicacion, SS_HC_Medicamento.IdEpisodioAtencion, SS_HC_Medicamento.IdPaciente, SS_HC_Medicamento.EpisodioClinico, SS_HC_Medicamento.Secuencia, 
                SS_HC_Medicamento.TipoMedicamento,
                SS_HC_Medicamento.IdUnidadMedida, SS_HC_Medicamento.Linea, SS_HC_Medicamento.Familia, 
                SS_HC_Medicamento.SubFamilia, TipoComponente, CodigoComponente, IdVia, 
                Dosis, DiasTratamiento, Frecuencia, Cantidad, IndicadorEPS, TipoReceta, Forma, GrupoMedicamento,Comentario, 
                IndicadorAuditoria, 
				+(case when Presentacion IS null OR Presentacion=''
						then ''else +'Presentacion : '+ SS_HC_Medicamento.Presentacion    end)
				+(case when Dosis IS null OR Dosis=''
							then ''else + ' Dosis : '+ SS_HC_Medicamento.Dosis   end)                 
				+(case when  UniMed.DescripcionCorta IS null 
							then ''else ' U.Medida : '+UniMed.DescripcionCorta  end) 
				+(case when Frecuencia is null  
							then '' else ' Frecuencia : '     + CONVERT(VARCHAR,SS_HC_Medicamento.Frecuencia) end)
				+(case when  DETUNI.Nombre IS null 
							then ''else ' Und.Tiempo : '+ DETUNI.Nombre  end)  
				+(case when  SS_HC_Medicamento.Periodo IS null 
							then ''else ' Periodo : '+ SS_HC_Medicamento.Periodo   end) 
				+(case when  DETTIE.Nombre IS null 
							then ''else ' Und.Tiempo : '+ DETTIE.Nombre  end)  
				+(case when  Via.Descripcion is null 
							then '' else ' Vía : '+ Via.Descripcion end) 
				+(case when Cantidad is null  
					then ''else ' Cantidad : '+ CONVERT(VARCHAR,Cantidad) end)
				+(case when DETTOR.Nombre IS null 
							then ''else ' T.Receta : '+ DETTOR.Nombre   end) 
				+(case when Indicacion IS null OR Indicacion=''
							then ''else ' Indicacion : '+ Indicacion   end) as   UsuarioAuditoria, 
							TipoComida,VolumenDia ,    FrecuenciaToma ,    
                Presentacion, Hora  ,      Indicacion,Periodo  ,UnidadTiempo ,
                SS_HC_Medicamento.Estado, SS_HC_Medicamento.UsuarioCreacion, SS_HC_Medicamento.FechaCreacion, 
                SS_HC_Medicamento.UsuarioModificacion,  SS_HC_Medicamento.FechaModificacion,        SS_HC_Medicamento.Accion,
                ( case when (MED.DescripcionLocal IS null OR MED.DescripcionLocal = '') 
                            then LIN.DescripcionLocal +' | '+ FAM.DescripcionLocal +' | '+DCI.DescripcionLocal +' | '+  DCI.DescripcionLocal
                                else LIN.DescripcionLocal +' | '+FAM.DescripcionLocal +' | '+DCI.DescripcionLocal +' | '+  MED.DescripcionLocal  end  ) as Version 
				, SS_HC_Medicamento.INDICADORTI,IdPadreNutriente ,IdHijoNutriente, PADRE.Descripcion PadreDescripcion, HIJO.Descripcion HijoDescripcion ,SecuencialHCE,CodAlmacen --ANGEL 16/07/2019
                FROM  SS_HC_Medicamento_FE AS SS_HC_Medicamento 
				Left join WH_ClaseSubFamilia DCI				ON     DCI.Linea = SS_HC_Medicamento.Linea   AND DCI.Familia = SS_HC_Medicamento.Familia
                                    AND DCI.SubFamilia = SS_HC_Medicamento.SubFamilia     
				Left join  WH_ItemMast MED						ON     ( rtrim(MED.Item)  =  SS_HC_Medicamento.CodigoComponente )                                        
				LEFT JOIN  UnidadesMast UniMed					ON (UniMed.IdUnidadMedida = SS_HC_Medicamento.IdUnidadMedida)
				LEFT JOIN  GE_VARIOS Via						ON     (Via.CodigoTabla = 'TIPOVIA'    AND Via.Secuencial = SS_HC_Medicamento.IdVia)
				LEFT JOIN  CM_CO_TablaMaestroDetalle DETUNI		ON     (DETUNI.IdTablaMaestro = 102      AND DETUNI.IdCodigo = SS_HC_Medicamento.UnidadTiempo)     
				LEFT JOIN  CM_CO_TablaMaestroDetalle DETTIE		ON     (DETTIE.IdTablaMaestro = 102      AND DETTIE.IdCodigo = SS_HC_Medicamento.TipoComida)       
				LEFT JOIN  CM_CO_TablaMaestroDetalle DETTOR		ON     (DETTOR.IdTablaMaestro = 46              AND DETTOR.IdCodigo = SS_HC_Medicamento.TipoReceta)   
				left JOIN  WH_ClaseFamilia FAM					ON FAM.Linea = SS_HC_Medicamento.Linea AND FAM.Familia = SS_HC_Medicamento.Familia 
				left JOIN  WH_ClaseLinea LIN					ON LIN.Linea =   FAM.Linea 
				LEFT JOIN  SS_HC_CATALOGODIETA PADRE			ON PADRE.Nivel =1  AND PADRE.IdDieta =  IdPadreNutriente
				LEFT JOIN  SS_HC_CATALOGODIETA HIJO				ON HIJO.Nivel  =2   AND HIJO.IdDieta  =  IdHijoNutriente
				LEFT JOIN SS_HC_EpisodioAtencion epi
				on epi.IdPaciente=   SS_HC_Medicamento.IdPaciente 
				and epi.IdEpisodioAtencion=SS_HC_Medicamento.IdEpisodioAtencion 
				and epi.EpisodioClinico= SS_HC_Medicamento.EpisodioClinico
			  WHERE   SS_HC_Medicamento.IdPaciente =@IdPaciente    
				  AND epi.CodigoOA=@CodigoComponente
				  AND   SS_HC_Medicamento.EpisodioClinico = @clinico2 
				  AND   SS_HC_Medicamento.IdEpisodioAtencion = @episodio2      
				  AND   ltrim(rtrim(SS_HC_Medicamento.UnidadReplicacion)) = ltrim(rtrim(@UnidadReplicacion))  
				  AND   (@TipoMedicamento is null or SS_HC_Medicamento.TipoMedicamento =@TipoMedicamento)
				  AND SS_HC_Medicamento.Estado=2


            END
       
END

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_GE_MedicamentoAlta_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_GE_MedicamentoAlta_FE]
	@UnidadReplicacion  char(4) ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@IdEpisodioAtencion  bigint ,
	@Secuencia  int ,
	@TipoMedicamento int,
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
	@TipoComida int,
	@VolumenDia varchar(250) ,
	@FrecuenciaToma varchar(250) ,
	@Presentacion varchar(250) ,
	@Hora datetime ,
	@Periodo VARCHAR(10) ,
	@UnidadTiempo INT  ,
	@Indicacion varchar(500) ,
	@Estado  int,
	@UsuarioCreacion  varchar(25),
	@FechaCreacion  datetime,
	@UsuarioModificacion  varchar(25),
	@FechaModificacion  datetime,
	@Accion	varchar(50),
	@Version varchar(50),
	 @SecuencialHCE VARCHAR(20)
AS
BEGIN
	 SET NOCOUNT ON;
	 DECLARE @IdEpisodioAtencionId as INTEGER,@SecuenciaID as integer,
	 @EpisodioClinicoID as INTEGER, @ExisteCodigo as VARCHAR(10)
	 set @IdEpisodioAtencionId = @IdEpisodioAtencion;	 
	 
	 
	 IF @Accion = 'NUEVO'
		BEGIN
			if @Version='' or @Version is null
			 begin	 
				set @Version='CCEPF201'
			 end
			 DECLARE @var varchar(15)					
			EXEC SP_SS_HC_Correlativo '00000000','CEG' ,'HC',@NroPeticion=@var output

			   SELECT @SecuenciaID = ISNULL(max(Secuencia),0) + 1  FROM SS_HC_MedicamentoAlta_FE
					WHERE  UnidadReplicacion = @UnidadReplicacion AND 
					 IdEpisodioAtencion = @IdEpisodioAtencion AND   IdPaciente = @IdPaciente AND  EpisodioClinico = @EpisodioClinico

				INSERT INTO SS_HC_MedicamentoAlta_FE(UnidadReplicacion, IdEpisodioAtencion, IdPaciente, EpisodioClinico, 
					Secuencia, IdUnidadMedida, Linea, Familia, SubFamilia, TipoComponente, CodigoComponente, 
					IdVia, Dosis, DiasTratamiento, Frecuencia, Cantidad, IndicadorEPS, TipoReceta, Estado, 
					UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion,
				    Accion,	Version, Forma, GrupoMedicamento,Comentario,IndicadorAuditoria, UsuarioAuditoria,
				    TipoMedicamento, TipoComida,	VolumenDia ,	FrecuenciaToma ,	
					Presentacion,	Hora ,	Indicacion ,Periodo ,UnidadTiempo,SecuencialHCE)
				 
				VALUES(@UnidadReplicacion,	@IdEpisodioAtencion,	@IdPaciente,	@EpisodioClinico,	
				@SecuenciaID,	@IdUnidadMedida,	@Linea,	@Familia,	@SubFamilia,	@TipoComponente,	@CodigoComponente,	
				@IdVia,	@Dosis,	@DiasTratamiento,	@Frecuencia,	@Cantidad,	@IndicadorEPS,	@TipoReceta,	2,	
				@UsuarioCreacion,	getdate(),	@UsuarioModificacion,	getdate(),	'NUEVO',	@Version,@Forma, @GrupoMedicamento, 
				@Comentario,@IndicadorAuditoria, @UsuarioAuditoria, @TipoMedicamento, @TipoComida,@VolumenDia ,	@FrecuenciaToma ,
				@Presentacion,	@Hora ,	@Indicacion,@Periodo ,@UnidadTiempo,@var )
			
			select @SecuenciaID;
		END	
		IF @Accion ='UPDATE'
			BEGIN
				UPDATE SS_HC_MedicamentoAlta_FE SET  IdUnidadMedida=@IdUnidadMedida,
					Linea=@Linea,	 Familia=@Familia,	 SubFamilia=@SubFamilia,TipoComponente=@TipoComponente,	 
					CodigoComponente=@CodigoComponente,	 IdVia=@IdVia,	 Dosis=@Dosis,	 DiasTratamiento=@DiasTratamiento,	 
					Frecuencia=@Frecuencia,	 Cantidad=@Cantidad,	 IndicadorEPS=@IndicadorEPS,	 TipoReceta=@TipoReceta,	 
					VolumenDia=@VolumenDia ,	FrecuenciaToma=@FrecuenciaToma ,Presentacion=@Presentacion,	Hora=@Hora ,
					Indicacion=@Indicacion,	Estado=@Estado,	 Periodo=@Periodo ,UnidadTiempo=@UnidadTiempo,
					--UsuarioCreacion=@UsuarioCreacion,				--FechaCreacion=getdate(),	 					
					UsuarioModificacion=@UsuarioModificacion,	 FechaModificacion=getdate(),	Accion=@Accion,
					Forma = @Forma,GrupoMedicamento = @GrupoMedicamento ,Comentario=@Comentario,					
					IndicadorAuditoria=@IndicadorAuditoria, 
					UsuarioAuditoria=@UsuarioAuditoria,  
					TipoMedicamento =@TipoMedicamento, TipoComida = @TipoComida
				Where	IdPaciente = @IdPaciente
			 	and		EpisodioClinico =@EpisodioClinico 
				and		IdEpisodioAtencion = @IdEpisodioAtencion
				and		UnidadReplicacion  = @UnidadReplicacion
				and		Secuencia = @Secuencia
				 

				select @Secuencia;
			END				
		IF @Accion ='DELETE' ---delete individual
			BEGIN
				if(@TipoMedicamento is null ) set @TipoMedicamento = 1							
				
				delete from SS_HC_MedicamentoAlta_FE
				Where	IdPaciente = @IdPaciente
			 	and		EpisodioClinico =@EpisodioClinico 
				and		IdEpisodioAtencion = @IdEpisodioAtencion
				and		UnidadReplicacion  = @UnidadReplicacion
				and Secuencia = @Secuencia
				-----
				
				delete from  SS_HC_MedicamentoAlta_FE 
				Where	IdPaciente = @IdPaciente
			 	and		EpisodioClinico =@EpisodioClinico 
				and		IdEpisodioAtencion = @IdEpisodioAtencion
				and		TipoMedicamento = @TipoMedicamento
				and		UnidadReplicacion  = @UnidadReplicacion
				and		Secuencia = @Secuencia
				
				select @Secuencia;
			END			 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_GE_MedicamentoAlta_FEListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[SP_SS_GE_MedicamentoAlta_FEListar]
	@UnidadReplicacion  char(4) ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@IdEpisodioAtencion  bigint ,
	@Secuencia  int ,
	@TipoMedicamento int,
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
	@TipoComida int,
	@VolumenDia [varchar](250) ,
	@FrecuenciaToma [varchar](250) ,
	@Presentacion [varchar](250) ,
	@Hora [datetime] ,
	@Periodo VARCHAR(10) ,
	@UnidadTiempo INT  ,
	@Indicacion [varchar](250) ,
	@Estado  int,
	@UsuarioCreacion  varchar(25),
	@FechaCreacion  datetime,
	@UsuarioModificacion  varchar(25),
	@FechaModificacion  datetime,
	@Accion	varchar(50),
	@Version varchar(50)
	,
	@SecuencialHCE varchar(20),
	@INDICADORTI int
AS
BEGIN
	 SET NOCOUNT ON;
 
	 IF @Accion ='LISTAR'
			BEGIN			
				SELECT SS_HC_Medicamento.UnidadReplicacion, IdEpisodioAtencion, IdPaciente, EpisodioClinico, Secuencia, 
				SS_HC_Medicamento.TipoMedicamento,
				SS_HC_Medicamento.IdUnidadMedida, SS_HC_Medicamento.Linea, SS_HC_Medicamento.Familia, 
				SS_HC_Medicamento.SubFamilia, TipoComponente, CodigoComponente, IdVia, 
				Dosis, DiasTratamiento, Frecuencia, Cantidad, IndicadorEPS, TipoReceta, Forma, GrupoMedicamento,Comentario, 
				IndicadorAuditoria, 
	+(case when Presentacion IS null OR Presentacion=''
		then ''else +'Presentacion : '+ SS_HC_Medicamento.Presentacion    end)
	+(case when Dosis IS null OR Dosis=''
			then ''else + ' Dosis : '+ SS_HC_Medicamento.Dosis   end)			
	+(case when  UniMed.DescripcionCorta IS null 
			then ''else ' U.Medida : '+UniMed.DescripcionCorta  end) 
	+(case when Frecuencia is null  
			then '' else ' Frecuencia : '	+ CONVERT(VARCHAR,SS_HC_Medicamento.Frecuencia) end)
	+(case when  DETUNI.Nombre IS null 
			then ''else ' Und.Tiempo : '+ DETUNI.Nombre  end)  
	+(case when  SS_HC_Medicamento.Periodo IS null 
			then ''else ' Periodo : '+ SS_HC_Medicamento.Periodo   end) 
	+(case when  DETTIE.Nombre IS null 
			then ''else ' Und.Tiempo : '+ DETTIE.Nombre  end)  
	+(case when  Via.Descripcion is null 
			then '' else ' Vía : '+ Via.Descripcion end) 
	+(case when Cantidad is null  
	    then ''else ' Cantidad : '+ CONVERT(VARCHAR,Cantidad) end)
	+(case when DETTOR.Nombre IS null 
			then ''else ' T.Receta : '+ DETTOR.Nombre   end) 
	+(case when Indicacion IS null OR Indicacion=''
			then ''else ' Indicacion : '+ Indicacion   end) as				UsuarioAuditoria, 
			TipoComida,VolumenDia ,	FrecuenciaToma ,	
				Presentacion,	Hora  ,	Indicacion,Periodo  ,UnidadTiempo ,
				SS_HC_Medicamento.Estado, SS_HC_Medicamento.UsuarioCreacion, SS_HC_Medicamento.FechaCreacion, 
				SS_HC_Medicamento.UsuarioModificacion,	SS_HC_Medicamento.FechaModificacion, 	SS_HC_Medicamento.Accion,
					( case when (MED.DescripcionLocal IS null OR MED.DescripcionLocal = '') 
								then LIN.DescripcionLocal +' | '+ FAM.DescripcionLocal +' | '+DCI.DescripcionLocal +' | '+  DCI.DescripcionLocal
								else LIN.DescripcionLocal +' | '+FAM.DescripcionLocal +' | '+DCI.DescripcionLocal +' | '+  MED.DescripcionLocal  end  ) as Version
								,SS_HC_Medicamento.SecuencialHCE as SecuencialHCE, 0 as INDICADORTI 
 
			FROM  SS_HC_MedicamentoAlta_FE AS SS_HC_Medicamento 
		Left join WH_ClaseSubFamilia DCI on 	DCI.Linea = SS_HC_Medicamento.Linea		AND DCI.Familia = SS_HC_Medicamento.Familia
						AND DCI.SubFamilia = SS_HC_Medicamento.SubFamilia	
		Left join  WH_ItemMast MED on 	( rtrim(MED.Item)  =  SS_HC_Medicamento.CodigoComponente )						
        LEFT JOIN  UnidadesMast UniMed					ON (UniMed.IdUnidadMedida = SS_HC_Medicamento.IdUnidadMedida)
		LEFT JOIN  GE_VARIOS Via						ON 	(Via.CodigoTabla = 'TIPOVIA'	AND Via.Secuencial = SS_HC_Medicamento.IdVia)
		LEFT JOIN  CM_CO_TablaMaestroDetalle DETUNI	ON 	(DETUNI.IdTablaMaestro = 102	AND DETUNI.IdCodigo = SS_HC_Medicamento.UnidadTiempo)	
		LEFT JOIN  CM_CO_TablaMaestroDetalle DETTIE	ON 	(DETTIE.IdTablaMaestro = 102	AND DETTIE.IdCodigo = SS_HC_Medicamento.TipoComida)	
		LEFT JOIN  CM_CO_TablaMaestroDetalle DETTOR	ON 	(DETTOR.IdTablaMaestro = 46		AND DETTOR.IdCodigo = SS_HC_Medicamento.TipoReceta)	
		left JOIN  WH_ClaseFamilia FAM ON FAM.Linea = SS_HC_Medicamento.Linea AND FAM.Familia = SS_HC_Medicamento.Familia 
		left JOIN  WH_ClaseLinea LIN ON LIN.Linea =   FAM.Linea 		
		Where	
				(IdPaciente is null or SS_HC_Medicamento.IdPaciente = @IdPaciente) 
				and		(@EpisodioClinico is null or SS_HC_Medicamento.EpisodioClinico =@EpisodioClinico )
			 	and		(@UnidadReplicacion is null or SS_HC_Medicamento.UnidadReplicacion =@UnidadReplicacion )
				and		(@IdEpisodioAtencion is null or IdEpisodioAtencion = @IdEpisodioAtencion)
				and		(@TipoMedicamento is null or SS_HC_Medicamento.TipoMedicamento =@TipoMedicamento)
				and		(@GrupoMedicamento is null or SS_HC_Medicamento.GrupoMedicamento =@GrupoMedicamento)
			END
	 
END
 
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_GE_MedicamentoListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE  [dbo].[SP_SS_GE_MedicamentoListar]
	@UnidadReplicacion  char(4) ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@IdEpisodioAtencion  bigint ,
	@Secuencia  int ,
	@TipoMedicamento int,
	@IdUnidadMedida  int,
	@Linea  char(6),
	@Familia  char(6),
	@SubFamilia  char(6),
	@TipoComponente  char(1),
	@CodigoComponente  varchar(25),
	@IdVia  int,
	@Dosis  decimal(9, 2),
	@DiasTratamiento  decimal(9, 2),
	@Frecuencia  decimal(9, 2),
	@Cantidad  decimal(20, 6),
	@IndicadorEPS  int,
	@TipoReceta  int,
	@Forma int,
	@Comentario  varchar(250),
	@IndicadorAuditoria int,
	@UsuarioAuditoria varchar(25),
	@TipoComida int,
	@Estado  int,
	@UsuarioCreacion  varchar(25),
	@FechaCreacion  datetime,
	@UsuarioModificacion  varchar(25),
	@FechaModificacion  datetime,
	@Accion	varchar(50),
	@Version varchar(50)
AS
BEGIN
	 SET NOCOUNT ON;
	 DECLARE @IdEpisodioAtencionId as INTEGER,@SecuenciaID as integer,
	 @EpisodioClinicoID as INTEGER, @ExisteCodigo as VARCHAR(10)
	 set @EpisodioClinicoID = @IdEpisodioAtencion;
 
	 IF @Accion ='LISTAR'
			BEGIN			
				SELECT SS_HC_Medicamento.UnidadReplicacion, IdEpisodioAtencion, IdPaciente, EpisodioClinico, Secuencia, 
				SS_HC_Medicamento.TipoMedicamento,
				IdUnidadMedida, SS_HC_Medicamento.Linea, SS_HC_Medicamento.Familia, 
				SS_HC_Medicamento.SubFamilia, TipoComponente, CodigoComponente, IdVia, 
				Dosis, DiasTratamiento, Frecuencia, Cantidad, IndicadorEPS, TipoReceta, Forma, Comentario, 
				IndicadorAuditoria, UsuarioAuditoria, TipoComida,
				SS_HC_Medicamento.Estado, SS_HC_Medicamento.UsuarioCreacion, SS_HC_Medicamento.FechaCreacion, UsuarioModificacion, 
				FechaModificacion, 
				SS_HC_Medicamento.Accion,
					( case when (MED.DescripcionLocal IS NOT null OR MED.DescripcionLocal <> '') 
								then MED.DescripcionLocal else DCI.DescripcionLocal end  ) as Version 
 
			FROM  
				dbo.SS_HC_Medicamento 
					Left join WH_ClaseSubFamilia DCI on 
						(DCI.Linea = SS_HC_Medicamento.Linea
						AND DCI.Familia = SS_HC_Medicamento.Familia
						AND DCI.SubFamilia = SS_HC_Medicamento.SubFamilia
						AND (SS_HC_Medicamento.CodigoComponente  = '' OR SS_HC_Medicamento.CodigoComponente is null)
						)
					Left join WH_ItemMast MED on 
						(MED.Linea = SS_HC_Medicamento.Linea
						AND MED.Familia = SS_HC_Medicamento.Familia
						AND MED.SubFamilia = SS_HC_Medicamento.SubFamilia
						AND ( rtrim(MED.Item)  =  SS_HC_Medicamento.CodigoComponente )
						)                      
				Where	IdPaciente = @IdPaciente
			 	and		EpisodioClinico =@EpisodioClinico 
				and		IdEpisodioAtencion = @IdEpisodioAtencion
				and (@TipoMedicamento is null or SS_HC_Medicamento.TipoMedicamento =@TipoMedicamento)
			END
	
	IF @Accion ='LISTARCONCPM'
	BEGIN			
				SELECT SS_HC_Medicamento.UnidadReplicacion, IdEpisodioAtencion, SS_HC_Medicamento.IdPaciente, EpisodioClinico, Secuencia, 
				SS_HC_Medicamento.TipoMedicamento,
				IdUnidadMedida, SS_HC_Medicamento.Linea, SS_HC_Medicamento.Familia, 
				SS_HC_Medicamento.SubFamilia, TipoComponente, CodigoComponente, IdVia, 
				Dosis, DiasTratamiento, Frecuencia, Cantidad, IndicadorEPS, Comentario, Forma,  
				IndicadorAuditoria, UsuarioAuditoria, TipoComida,SS_GE_Paciente.TipoPaciente as  TipoReceta,
				SS_HC_Medicamento.Estado, SS_HC_Medicamento.UsuarioCreacion, SS_HC_Medicamento.FechaCreacion, SS_HC_Medicamento.UsuarioModificacion, 
				SS_HC_Medicamento.FechaModificacion, 
				SS_HC_Medicamento.Accion,
					( case when (MED.DescripcionLocal IS NOT null OR MED.DescripcionLocal <> '') 
								then MED.DescripcionLocal else DCI.DescripcionLocal end  ) as Version 
 
			FROM  
				dbo.SS_HC_Medicamento 
					Left join WH_ClaseSubFamilia DCI on 
						(DCI.Linea = SS_HC_Medicamento.Linea
						AND DCI.Familia = SS_HC_Medicamento.Familia
						AND DCI.SubFamilia = SS_HC_Medicamento.SubFamilia
						AND (SS_HC_Medicamento.CodigoComponente  = '' OR SS_HC_Medicamento.CodigoComponente is null)
						)
					Left join WH_ItemMast MED on 
						(MED.Linea = SS_HC_Medicamento.Linea
						AND MED.Familia = SS_HC_Medicamento.Familia
						AND MED.SubFamilia = SS_HC_Medicamento.SubFamilia
						AND ( rtrim(MED.Item)  =  SS_HC_Medicamento.CodigoComponente )
						)  
						
				LEFT JOIN dbo.SS_GE_Paciente  on				
				
				SS_GE_Paciente.IdPaciente =  SS_HC_Medicamento.IdPaciente                  
				Where	SS_HC_Medicamento.IdPaciente = @IdPaciente
			 	and		EpisodioClinico =@EpisodioClinico 
				and		IdEpisodioAtencion = @IdEpisodioAtencion
				and (@TipoMedicamento is null or SS_HC_Medicamento.TipoMedicamento =@TipoMedicamento)
			END
	 
END
	 
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_GE_Paciente]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
CREATE OR ALTER PROCEDURE [SP_SS_GE_Paciente]       
    
 @Persona       int,     
 @ApellidoPaterno     varchar(40),     
 @ApellidoMaterno     varchar(40),     
 @NombreCompleto      varchar(100),     
 @TipoDocumento      char(1),    
 @Documento       char(20),     
 @CodigoBarras      char(18),     
 @EsCliente       char(1),     
 @EsEmpleado       char(1),     
 @EsOtro        char(1),     
 @TipoPersona      char(1),     
 @EsProveedor      char(1),     
 @FechaNacimiento     datetime,     
 @CiudadNacimiento     char(20),     
 @Sexo        char(1),     
 @Nacionalidad      char(20),     
 @EstadoCivil      char(1),     
 @NivelInstruccion     char(3),     
 @Direccion       varchar(190),     
 @CodigoPostal      char(3),     
 @Provincia       char(3),     
 @Departamento      char(3),     
 @Telefono       varchar(15),     
 @DocumentoFiscal     char(20),     
 @DocumentoIdentidad     char(20),     
 @ACCION        varchar(25),     
 @edad        int,     
 @rangoEtario      varchar(10),     
 @TipoMedico       int,     
 @Correcion       int,     
 @EsPaciente       varchar(1),     
 @EsEmpresa       varchar(1),    
 @Pais        char(4),     
 @FlagActualizacion     char(1),     
 @CuentaMonedaLocal_tmp    char(15),     
 @CuentaMonedaExtranjera_tmp   char(15),     
 @CorrelativoSCTR     varchar(3),     
 @SeguroDiscamec      char(1),     
 @CodDiscamec      varchar(15),     
 @FecIniDiscamec      datetime,     
 @FecFinDiscamec      datetime,     
 @LugarNacimiento     varchar(255),     
 @Celular       varchar(15),     
 @CelularEmergencia     varchar(15),     
 @ParentescoEmergencia    char(15),     
 @DireccionReferencia    varchar(255),     
 @UltimaFechaModif     datetime,     
 @TipoPersonaUsuario     char(3),      
 @UltimoUsuario      varchar(25),     
 @Estado        char(1),     
 @DireccionEmergencia    varchar(60),     
 @TelefonoEmergencia     varchar(15),      
 @BancoMonedaLocal     char(3),     
 @TipoCuentaLocal     char(3),     
 @CuentaMonedaLocal     char(20),     
 @BancoMonedaExtranjera    char(3),      
 @TipoCuentaExtranjera    char(3),     
 @CuentaMonedaExtranjera    char(20),     
 @CorreoElectronico     varchar(50),     
 @EnfermedadGraveFlag    char(1),     
 @IngresoFechaRegistro    datetime,     
 @IngresoAplicacionCodigo   char(2),     
 @IngresoUsuario      varchar(25),     
 @PYMEFlag       char(1),     
 @Paciente       int,     
 @TipoPaciente      int,     
 @Raza        varchar(30),     
 @AreaLaboral      varchar(30),     
 @Ocupacion       varchar(80),     
 @CodigoHC       varchar(15),     
 @CodigoHCAnterior     varchar(15),     
 @CodigoHCSecundario     varchar(15),     
 @TipoAlmacenamiento     varchar(2),     
 @TipoHistoria      varchar(1),     
 @TipoSituacion      varchar(1),     
 @IdUbicacion      int,     
 @LugarProcedencia     varchar(30),     
 @RutaFoto       varchar(150),     
 @EstadoPaciente      int,     
 @NumeroFile       int,     
 @Servicio       varchar(25),     
 @Observacion      varchar(250),     
 @IndicadorAsistencia    int,     
 @CantidadAsistencia     int,     
 @UbicacionHHCC      int,     
 @IndicadorMigradoSiteds    int,     
 @NumeroCaja       varchar(25),     
 @IndicadorCodigoBarras    int,     
 @IDPACIENTE_OK      int,     
 @CodigoAsegurado     varchar(30),     
 @NumeroPoliza      int,     
 @NumeroCertificado     int,     
 @CodigoProducto      varchar(25),     
 @CodigoPlan       varchar(25),     
 @TipoParentesco      int,     
 @CodigoBeneficio     varchar(25),     
 @Situacion       int,     
 @TomoActual       int,     
 @IndicadorHistoriaFisica   int,     
 @DescripcionHistoria    varchar(500),     
 @PersonaAnt       char(15),     
 @Nombres       varchar(40),     
 @Busqueda       varchar(100),
 @IdPersonal  int,
 @AtencionLugar varchar(20),
 @Atencion varchar(20),
 @IdEstablecimientoIngreso varchar(20),
 @IdServicioIngreso varchar(20),
 @Prestacion   varchar(20),
 @Destino varchar(20),
 @NroAutorizacion int,
 @Monto money,
 @FechaIngresoHosp datetime,
 @FechaCorteHosp datetime,
 @Establecimiento01 varchar(20),
 @ReferenciaHoja01 varchar(50),
 @Establecimiento02 varchar(20),
 @ReferenciaHoja02 varchar(50)
AS      
BEGIN       
 DECLARE @CONTADORPER INT    
 DECLARE @CONTADORPAC INT      
   
 IF(@Accion = 'INSERTELESALUD')      
  BEGIN       
     
    select @CONTADORPER= (isnull(max(Persona),0)+100000) +1 from personamast     
    select @CONTADORPAC= isnull(MAX(IdPaciente),0)+1 from SS_GE_Paciente     
    set @Persona= @CONTADORPER    
    set @Paciente= @CONTADORPER    
        
    INSERT INTO personamast      
    (     
      Persona,     
      Origen,     
      ApellidoPaterno,     
      ApellidoMaterno,     
      NombreCompleto,     
         TipoDocumento,    
         Documento,     
         CodigoBarras,     
         EsCliente,     
         EsEmpleado,     
         EsOtro,     
         TipoPersona,     
         EsProveedor,     
         FechaNacimiento,     
         CiudadNacimiento,     
         Sexo,     
         Nacionalidad,     
         EstadoCivil,     
         NivelInstruccion,     
         Direccion,     
         CodigoPostal,     
         Provincia,     
         Departamento,     
         Telefono,     
         DocumentoFiscal,     
         DocumentoIdentidad,     
         ACCION,     
         edad,     
         rangoEtario,     
         TipoMedico,     
         Correcion,     
         EsPaciente,     
         EsEmpresa,    
         Pais,     
         FlagActualizacion,     
         CuentaMonedaLocal_tmp,     
         CuentaMonedaExtranjera_tmp,     
         CorrelativoSCTR,     
         SeguroDiscamec,     
         CodDiscamec,     
         FecIniDiscamec,     
         FecFinDiscamec,     
         LugarNacimiento,     
         Celular,     
         CelularEmergencia,     
         ParentescoEmergencia,     
         DireccionReferencia,     
         UltimaFechaModif,     
         TipoPersonaUsuario,     
         UltimoUsuario,     
         Estado,     
         DireccionEmergencia,     
         TelefonoEmergencia,     
         BancoMonedaLocal,     
         TipoCuentaLocal,     
         CuentaMonedaLocal,     
         BancoMonedaExtranjera,     
         TipoCuentaExtranjera,     
         CuentaMonedaExtranjera,     
         CorreoElectronico,     
         EnfermedadGraveFlag,     
         IngresoFechaRegistro,     
         IngresoAplicacionCodigo,     
         IngresoUsuario,     
         PYMEFlag,     
         PersonaAnt,     
         Nombres,     
         Busqueda    
    )    
    VALUES(    
    @Persona,     
    'PE',    
    @ApellidoPaterno,     
    @ApellidoMaterno,     
    @NombreCompleto,     
    @TipoDocumento,    
    @Documento,     
    @CodigoBarras,     
    @EsCliente,     
    @EsEmpleado,     
    @EsOtro,     
    @TipoPersona,     
    @EsProveedor,     
    @FechaNacimiento,     
    @CiudadNacimiento,     
    @Sexo,     
    @Nacionalidad,     
    @EstadoCivil,     
    @NivelInstruccion,     
    @Direccion,     
    @CodigoPostal,     
    @Provincia,     
    @Departamento,     
    @Telefono,     
    @DocumentoFiscal,     
    @DocumentoIdentidad,     
    @ACCION,     
    @edad,     
    @rangoEtario,     
    @TipoMedico,     
    @Correcion,     
    @EsPaciente,     
    @EsEmpresa,    
    @Pais,     
    @FlagActualizacion,     
    @CuentaMonedaLocal_tmp,     
    @CuentaMonedaExtranjera_tmp,     
    @CorrelativoSCTR,     
    @SeguroDiscamec,     
    @CodDiscamec,     
    @FecIniDiscamec,     
    @FecFinDiscamec,     
    @LugarNacimiento,     
    @Celular,     
    @CelularEmergencia,     
    @ParentescoEmergencia,     
    @DireccionReferencia,     
    GETDATE(),     
    @TipoPersonaUsuario,     
    @UltimoUsuario,     
    'A',     
    @DireccionEmergencia,     
    @TelefonoEmergencia,     
    @BancoMonedaLocal,     
    @TipoCuentaLocal,     
    @CuentaMonedaLocal,     
    @BancoMonedaExtranjera,     
    @TipoCuentaExtranjera,     
    @CuentaMonedaExtranjera,     
    @CorreoElectronico,     
    @EnfermedadGraveFlag,     
    GETDATE(),     
    @IngresoAplicacionCodigo,     
    @IngresoUsuario,     
    @PYMEFlag,     
    @PersonaAnt,     
    @Nombres,     
    @Busqueda    
      
    )    
    insert into SS_GE_Paciente    
    (    
        IdPaciente,     
        TipoPaciente,     
        Raza,     
        AreaLaboral,     
        Ocupacion,     
        CodigoHC,     
        CodigoHCAnterior,     
        CodigoHCSecundario,     
        TipoAlmacenamiento,     
        TipoHistoria,     
        TipoSituacion,     
        IdUbicacion,     
        LugarProcedencia,     
        RutaFoto,     
        Estado,     
        NumeroFile,     
        Servicio,     
        Observacion,     
        IndicadorAsistencia,     
        CantidadAsistencia,     
        UbicacionHHCC,     
        IndicadorMigradoSiteds,     
        NumeroCaja,     
        IndicadorCodigoBarras,     
        IDPACIENTE_OK,     
        CodigoAsegurado,     
        NumeroPoliza,     
        NumeroCertificado,     
        CodigoProducto,     
        CodigoPlan,     
        TipoParentesco,     
        CodigoBeneficio,     
        Situacion,     
        TomoActual,     
        IndicadorHistoriaFisica,     
        DescripcionHistoria,    
        Accion,
        IdPersonal,
		AtencionLugar,
		Atencion,
		IdEstablecimientoIngreso,
		IdServicioIngreso,
		Prestacion,
		Destino,
		NroAutorizacion,
		Monto,
		FechaIngresoHosp,
		FechaCorteHosp,
		Establecimiento01,
		ReferenciaHoja01,
		Establecimiento02,
		ReferenciaHoja02  
    )    
        
    values    
    (    
    @Paciente,     
    @TipoPaciente,     
    @Raza,     
    @AreaLaboral,     
    @Ocupacion,    
    @Persona,  
    --@CodigoHC,     
    @CodigoHCAnterior,     
    @CodigoHCSecundario,     
    @TipoAlmacenamiento,     
    @TipoHistoria,     
    @TipoSituacion,     
    @IdUbicacion,     
    @LugarProcedencia,     
    @RutaFoto,     
    2,     
    @NumeroFile,     
    @Servicio,     
    @Observacion,     
    @IndicadorAsistencia,     
    @CantidadAsistencia,     
    @UbicacionHHCC,     
    @IndicadorMigradoSiteds,     
    @NumeroCaja,     
    @IndicadorCodigoBarras,     
    @IDPACIENTE_OK,     
    @CodigoAsegurado,     
    @NumeroPoliza,     
    @NumeroCertificado,     
    @CodigoProducto,     
    'TELESALUD',     
    @TipoParentesco,     
    @CodigoBeneficio,     
    @Situacion,     
    @TomoActual,     
    @IndicadorHistoriaFisica,     
    @DescripcionHistoria,     
    @ACCION,
    @IdPersonal,
    @AtencionLugar,
    @Atencion,
    @IdEstablecimientoIngreso,
    @IdServicioIngreso,
    @Prestacion,
    @Destino,
    @NroAutorizacion,
    @Monto,
    @FechaIngresoHosp,
    @FechaCorteHosp,
    @Establecimiento01,
    @ReferenciaHoja01,
    @Establecimiento02,
    @ReferenciaHoja02
    )    
   DECLARE @UnidadReplicacion VARCHAR(20)  
   DECLARE @CodigoOA int, @IdOrdenAtencion int, @TipoOrdenAtencion int, @IdEspecialidad int,  
    @TipoAtencion int, @IdEstablecimientoSalud int, @Linea int, @IndicadorTMH int  

  set @TipoOrdenAtencion=1  
  set @IdEspecialidad=1  
  set @TipoAtencion=1  
  set @IdEstablecimientoSalud=1  
  set @UnidadReplicacion = 'CEG'  
  set @IndicadorTMH=10  
   select @IdOrdenAtencion = (isnull(max(IdOrdenAtencion),0)+100000) +1 from SS_AD_OrdenAtencion  
 
      SELECT @CodigoOA=isnull(max(CorrelativoNumero),0)+1 FROM  CorrelativosMast WITH(NOLOCK)   
   WHERE CompaniaCodigo='00000000' AND TipoComprobante='OA'  
         UPDATE CorrelativosMast SET CorrelativoNumero=@CodigoOA WHERE CompaniaCodigo='00000000' AND TipoComprobante='OA'  
           
         SELECT @IdOrdenAtencion=isnull(max(IdOrdenAtencion),0)+1 FROM  SS_AD_OrdenAtencion   
           
         insert into SS_AD_OrdenAtencion  
   (  
    IdOrdenAtencion,TipoOrdenAtencion,CodigoOA,Especialidad,TipoAtencion,  
    TipoPaciente,IdServicio,IdPaciente,IdEmpresaAseguradora,Compania,  
    Sucursal,IdEstablecimiento,EstadoDocumento,EstadoDocumentoAnterior,  
    UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,IdEmpleado,  
    UnidadReplicacion, Estado,IndicadorTMH  
   )  
   values  
   (  
    @IdOrdenAtencion,@TipoOrdenAtencion,@CodigoOA,@IdEspecialidad,@TipoAtencion,  
    @TipoPaciente,null,@Paciente,null,null,  
    null,@IdEstablecimientoSalud,null,null,  
    @UltimoUsuario,GETDATE(),@UltimoUsuario,GETDATE(),null,    
    @UnidadReplicacion, 2,@IndicadorTMH  
   )  
   Select @Linea=isnull(max(IdOrdenAtencion),0)+1 from SS_AD_OrdenAtencionDetalle  
   where IdOrdenAtencion = @IdOrdenAtencion  
     
  insert into dbo.SS_AD_OrdenAtencionDetalle  
   ( IdOrdenAtencion,Linea,TipoOrdenAtencion,Especialidad,IdCita,  
     IdPaciente, IdEstablecimiento,Estado  
   )  
   values  
   (  
    @IdOrdenAtencion,@Linea,@TipoOrdenAtencion,@IdEspecialidad,null,  
    @Paciente,@IdEspecialidad,2  
   )  
   select @CONTADORPER    
  END  
  END     
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_GE_Paciente_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_GE_Paciente_Listar]   
@IdPaciente     INT,   
@TipoPaciente    INT,   
@Edad      INT,   
@Raza      VARCHAR,   
@Religion     VARCHAR,   
@Cargo      VARCHAR,   
@AreaLaboral    VARCHAR,   
@Ocupacion     VARCHAR,   
@CodigoHC     VARCHAR,   
@CodigoHCAnterior   VARCHAR,   
@CodigoHCSecundario   VARCHAR,   
@TipoAlmacenamiento   VARCHAR,   
@TipoHistoria    VARCHAR,   
@TipoSituacion    VARCHAR,   
@IdUbicacion    INT,   
@LugarProcedencia   VARCHAR,   
@RutaFoto     VARCHAR,   
@FechaIngreso    DATETIME,   
@IndicadorNuevo    INT,   
@Estado      INT,   
@UsuarioCreacion   VARCHAR,   
@FechaCreacion    DATETIME,   
@UsuarioModificacion  VARCHAR,   
@FechaModificacion   DATETIME,   
@NumeroFile     INT,   
@Servicio     VARCHAR,   
@UsuarioAlmacenamiento  VARCHAR,   
@FechaAlmacenamiento  DATETIME,   
@Observacion    VARCHAR,   
@IndicadorAsistencia  INT,   
@CantidadAsistencia   INT,   
@UbicacionHHCC    INT,   
@IndicadorMigradoSiteds  INT,   
@NumeroCaja     VARCHAR,   
@IndicadorCodigoBarras  INT,   
@IDPACIENTE_OK    INT,   
@CodigoAsegurado   VARCHAR,   
@NumeroPoliza    INT,   
@NumeroCertificado   INT,   
@CodigoProducto    VARCHAR,   
@CodigoPlan     VARCHAR,   
@TipoParentesco    INT,   
@CodigoBeneficio   VARCHAR,   
@Situacion     INT,   
@TomoActual     INT,   
@IndicadorHistoriaFisica INT,   
@DescripcionHistoria  VARCHAR,   
@Accion      VARCHAR,   
 @IdPersonal  int,
 @AtencionLugar varchar(20),
 @Atencion varchar(20),
 @IdEstablecimientoIngreso varchar(20),
 @IdServicioIngreso varchar(20),
 @Prestacion   varchar(20),
 @Destino varchar(20),
 @NroAutorizacion int,
 @Monto money,
 @FechaIngresoHosp datetime,
 @FechaCorteHosp datetime,
 @Establecimiento01 varchar(20),
 @ReferenciaHoja01 varchar(50),
 @Establecimiento02 varchar(20),
 @ReferenciaHoja02 varchar(50),
@INICIO      INT= NULL,   
@NUMEROFILAS    INT = NULL   
AS  
BEGIN   
 IF( @ACCION = 'LISTARPAG' )   
  BEGIN   
   DECLARE @CONTADOR INT   
   SET @CONTADOR=(SELECT Count(idpaciente) FROM   ss_ge_paciente   
                           WHERE  ( @IdPaciente IS NULL OR ( idpaciente = @IdPaciente ) OR @IdPaciente = 0 )   
                                  AND ( @Estado IS NULL OR estado = @Estado )  
                                  )   
            SELECT idpaciente,   
                   tipopaciente,   
                   edad,   
                   raza,   
                   religion,   
                   cargo,   
                   arealaboral,   
                   ocupacion,   
                   codigohc,   
                   codigohcanterior,   
                   codigohcsecundario,   
                   tipoalmacenamiento,   
                   tipohistoria,   
                   tiposituacion,   
                   idubicacion,   
                   lugarprocedencia,   
                   rutafoto,   
                   fechaingreso,   
                   indicadornuevo,   
                   estado,   
                   usuariocreacion,   
                   fechacreacion,   
                   usuariomodificacion,   
                   fechamodificacion,   
                   numerofile,   
                   servicio,   
                   usuarioalmacenamiento,   
                   fechaalmacenamiento,   
                   observacion,   
                   indicadorasistencia,   
                   cantidadasistencia,   
                   ubicacionhhcc,   
                   indicadormigradositeds,   
                   numerocaja,   
                   indicadorcodigobarras,   
                   idpaciente_ok,   
                   codigoasegurado,   
                   numeropoliza,   
                   numerocertificado,   
                   codigoproducto,   
                   codigoplan,   
                   tipoparentesco,   
                   codigobeneficio,   
                   situacion,   
                   tomoactual,   
                   indicadorhistoriafisica,   
                   descripcionhistoria,   
                   accion,
                   IdPersonal,
					AtencionLugar,
					Atencion,
					IdEstablecimientoIngreso,
					IdServicioIngreso,
					Prestacion,
					Destino,
					NroAutorizacion,
					Monto,
					FechaIngresoHosp,
					FechaCorteHosp,
					Establecimiento01,
					ReferenciaHoja01,
					Establecimiento02,
					ReferenciaHoja02    
            FROM   (SELECT idpaciente,   
                           tipopaciente,   
                           edad,   
                           raza,   
                           religion,   
                           cargo,   
                           arealaboral,   
                           ocupacion,   
                           codigohc,   
                           codigohcanterior,   
                           codigohcsecundario,   
    tipoalmacenamiento,   
                           tipohistoria,   
                           tiposituacion,   
                           idubicacion,   
                           lugarprocedencia,   
                           rutafoto,   
                           fechaingreso,   
                           indicadornuevo,   
                           estado,   
                           usuariocreacion,   
                           fechacreacion,   
                           usuariomodificacion,   
                           fechamodificacion,   
                           numerofile,   
                           servicio,   
                           usuarioalmacenamiento,   
                           fechaalmacenamiento,   
                           observacion,   
                           indicadorasistencia,   
                           cantidadasistencia,   
                           ubicacionhhcc,   
                           indicadormigradositeds,   
                           numerocaja,   
                           indicadorcodigobarras,   
                           idpaciente_ok,   
                           codigoasegurado,   
                           numeropoliza,   
                           numerocertificado,   
                           codigoproducto,   
                           codigoplan,   
                           tipoparentesco,   
                           codigobeneficio,   
                           situacion,   
                           tomoactual,   
                           indicadorhistoriafisica,   
                           descripcionhistoria,   
                           accion, 
                           IdPersonal,
							AtencionLugar,
							Atencion,
							IdEstablecimientoIngreso,
							IdServicioIngreso,
							Prestacion,
							Destino,
							NroAutorizacion,
							Monto,
							FechaIngresoHosp,
							FechaCorteHosp,
							Establecimiento01,
							ReferenciaHoja01,
							Establecimiento02,
							ReferenciaHoja02,  
                           @CONTADOR                     AS Contador,   
                           Row_number() OVER ( ORDER BY idpaciente ASC ) AS RowNumber   
                    FROM   ss_ge_paciente   
                    WHERE  ( @IdPaciente IS NULL OR ( idpaciente = @IdPaciente ) OR @IdPaciente = 0 )   
                           AND ( @Estado IS NULL OR estado = @Estado )) AS LISTADO   
            WHERE  ( @Inicio IS NULL AND @NumeroFilas IS NULL ) OR rownumber BETWEEN @Inicio AND @NumeroFilas   
 END   
 ELSE IF @Accion = 'LISTAR'   
  BEGIN   
   SELECT idpaciente,   
                   tipopaciente,   
                   edad,   
                   raza,   
                   religion,   
                   cargo,   
                   arealaboral,   
                   ocupacion,   
                   codigohc,   
                   codigohcanterior,   
                   codigohcsecundario,   
                   tipoalmacenamiento,   
                   tipohistoria,   
                   tiposituacion,   
                   idubicacion,   
                   lugarprocedencia,   
                   rutafoto,   
                   fechaingreso,   
                   indicadornuevo,   
                   estado,   
                   usuariocreacion,   
                   fechacreacion,   
                   usuariomodificacion,   
                   fechamodificacion,   
                   numerofile,   
                   servicio,   
                   usuarioalmacenamiento,   
                   fechaalmacenamiento,   
                   observacion,   
                   indicadorasistencia,   
                   cantidadasistencia,   
                   ubicacionhhcc,   
                   indicadormigradositeds,   
                   numerocaja,   
                   indicadorcodigobarras,   
                   idpaciente_ok,   
                   codigoasegurado,   
                   numeropoliza,   
                   numerocertificado,   
                   codigoproducto,   
                   codigoplan,   
                   tipoparentesco,   
                   codigobeneficio,   
                   situacion,   
                   tomoactual,   
                   indicadorhistoriafisica,   
                   descripcionhistoria,   
                   accion   ,
                   IdPersonal,
					AtencionLugar,
					Atencion,
					IdEstablecimientoIngreso,
					IdServicioIngreso,
					Prestacion,
					Destino,
					NroAutorizacion,
					Monto,
					FechaIngresoHosp,
					FechaCorteHosp,
					Establecimiento01,
					ReferenciaHoja01,
					Establecimiento02,
					ReferenciaHoja02
            FROM   ss_ge_paciente   
            WHERE  ( @IdPaciente IS NULL OR ( idpaciente = @IdPaciente ) OR @IdPaciente = 0 )   
                   AND ( @Estado IS NULL OR estado = @Estado )   
 END   
    ELSE IF( @ACCION = 'LISTARPORID' )   
  BEGIN   
   SELECT * FROM   ss_ge_paciente   
   WHERE  ( @IdPaciente IS NULL OR ( idpaciente = @IdPaciente ) OR @IdPaciente = 0 )   
        END   
  END 
  

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_GE_PacienteTriaje]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[SP_SS_GE_PacienteTriaje]       
 @Persona       int,     
 @ApellidoPaterno     varchar(40),     
 @ApellidoMaterno     varchar(40),     
 @NombreCompleto      varchar(100),     
 @TipoDocumento      char(1),    
 @Documento       char(20),     
 @CodigoBarras      char(18),     
 @EsCliente       char(1),     
 @EsEmpleado       char(1),     
 @EsOtro        char(1),     
 @TipoPersona      char(1),     
 @EsProveedor      char(1),     
 @FechaNacimiento     datetime,     
 @CiudadNacimiento     char(20),     
 @Sexo        char(1),     
 @Nacionalidad      char(20),     
 @EstadoCivil      char(1),     
 @NivelInstruccion     char(3),     
 @Direccion       varchar(190),     
 @CodigoPostal      char(3),     
 @Provincia       char(3),     
 @Departamento      char(3),     
 @Telefono       varchar(15),     
 @DocumentoFiscal     char(20),     
 @DocumentoIdentidad     char(20),     
 @ACCION        varchar(25),     
 @edad        int,     
 @rangoEtario      varchar(10),     
 @TipoMedico       int,     
 @Correcion       int,     
 @EsPaciente       varchar(1),     
 @EsEmpresa       varchar(1),    
 @Pais        char(4),     
 @FlagActualizacion     char(1),     
 @CuentaMonedaLocal_tmp    char(15),     
 @CuentaMonedaExtranjera_tmp   char(15),     
 @CorrelativoSCTR     varchar(3),     
 @SeguroDiscamec      char(1),     
 @CodDiscamec      varchar(15),     
 @FecIniDiscamec      datetime,     
 @FecFinDiscamec      datetime,     
 @LugarNacimiento     varchar(255),     
 @Celular       varchar(15),     
 @CelularEmergencia     varchar(15),     
 @ParentescoEmergencia    char(15),     
 @DireccionReferencia    varchar(255),     
 @UltimaFechaModif     datetime,     
 @TipoPersonaUsuario     char(3),      
 @UltimoUsuario      varchar(25),     
 @Estado        char(1),     
 @DireccionEmergencia    varchar(60),     
 @TelefonoEmergencia     varchar(15),      
 @BancoMonedaLocal     char(3),     
 @TipoCuentaLocal     char(3),     
 @CuentaMonedaLocal     char(20),     
 @BancoMonedaExtranjera    char(3),      
 @TipoCuentaExtranjera    char(3),     
 @CuentaMonedaExtranjera    char(20),     
 @CorreoElectronico     varchar(50),     
 @EnfermedadGraveFlag    char(1),     
 @IngresoFechaRegistro    datetime,     
 @IngresoAplicacionCodigo   char(2),     
 @IngresoUsuario      varchar(25),     
 @PYMEFlag       char(1),     
 @Paciente       int,     
 @TipoPaciente      int,     
 @Raza        varchar(30),     
 @AreaLaboral      varchar(30),     
 @Ocupacion       varchar(80),     
 @CodigoHC       varchar(15),     
 @CodigoHCAnterior     varchar(15),     
 @CodigoHCSecundario     varchar(15),     
 @TipoAlmacenamiento     varchar(2),     
 @TipoHistoria      varchar(1),     
 @TipoSituacion      varchar(1),     
 @IdUbicacion      int,     
 @LugarProcedencia     varchar(30),     
 @RutaFoto       varchar(150),     
 @EstadoPaciente      int,     
 @NumeroFile       int,     
 @Servicio       varchar(25),     
 @Observacion      varchar(250),     
 @IndicadorAsistencia    int,     
 @CantidadAsistencia     int,     
 @UbicacionHHCC      int,     
 @IndicadorMigradoSiteds    int,     
 @NumeroCaja       varchar(25),     
 @IndicadorCodigoBarras    int,     
 @IDPACIENTE_OK      int,     
 @CodigoAsegurado     varchar(30),     
 @NumeroPoliza      int,     
 @NumeroCertificado     int,     
 @CodigoProducto      varchar(25),     
 @CodigoPlan       varchar(25),     
 @TipoParentesco      int,     
 @CodigoBeneficio     varchar(25),     
 @Situacion       int,     
 @TomoActual       int,     
 @IndicadorHistoriaFisica   int,     
 @DescripcionHistoria    varchar(500),     
 @PersonaAnt       char(15),     
 @Nombres       varchar(40),     
 @Busqueda       varchar(100),
 @IdPersonal  int,
 @AtencionLugar varchar(20),
 @Atencion varchar(20),
 @IdEstablecimientoIngreso varchar(20),
 @IdServicioIngreso varchar(20),
 @Prestacion   varchar(20),
 @Destino varchar(20),
 @NroAutorizacion int,
 @Monto money,
 @FechaIngresoHosp datetime,
 @FechaCorteHosp datetime,
 @Establecimiento01 varchar(20),
 @ReferenciaHoja01 varchar(50),
 @Establecimiento02 varchar(20),
 @ReferenciaHoja02 varchar(50)
AS      
BEGIN       
 DECLARE @CONTADORPER INT    
 DECLARE @CONTADORPAC INT      
   
 IF(@Accion = 'INSERTELESALUD')      
  BEGIN       

     
    select @CONTADORPER= (isnull(max(Persona),0)) +1 from personamast     
    --select @CONTADORPAC= isnull(MAX(IdPaciente),0)+1 from SS_GE_Paciente     
    set @Persona= @CONTADORPER    
    set @Paciente= @CONTADORPER    
        
    INSERT INTO personamast      
    (     
      Persona,     
      Origen,     
      ApellidoPaterno,     
      ApellidoMaterno,     
      NombreCompleto,     
         TipoDocumento,    
         Documento,     
         CodigoBarras,     
         EsCliente,     
         EsEmpleado,     
         EsOtro,     
         TipoPersona,     
         EsProveedor,     
         FechaNacimiento,     
         CiudadNacimiento,     
         Sexo,     
         Nacionalidad,     
         EstadoCivil,     
         NivelInstruccion,     
         Direccion,     
         CodigoPostal,     
         Provincia,     
         Departamento,     
         Telefono,     
         DocumentoFiscal,     
         DocumentoIdentidad,     
         ACCION,     
         edad,     
         rangoEtario,     
         TipoMedico,     
         Correcion,     
         EsPaciente,     
         EsEmpresa,    
         Pais,     
         FlagActualizacion,     
         CuentaMonedaLocal_tmp,     
         CuentaMonedaExtranjera_tmp,     
         CorrelativoSCTR,     
         SeguroDiscamec,     
         CodDiscamec,     
         FecIniDiscamec,     
         FecFinDiscamec,     
         LugarNacimiento,     
         Celular,     
         CelularEmergencia,     
         ParentescoEmergencia,     
         DireccionReferencia,     
         UltimaFechaModif,     
         TipoPersonaUsuario,     
         UltimoUsuario,     
         Estado,     
         DireccionEmergencia,     
         TelefonoEmergencia,     
         BancoMonedaLocal,     
         TipoCuentaLocal,     
         CuentaMonedaLocal,     
         BancoMonedaExtranjera,     
         TipoCuentaExtranjera,     
         CuentaMonedaExtranjera,     
         CorreoElectronico,     
         EnfermedadGraveFlag,     
         IngresoFechaRegistro,     
         IngresoAplicacionCodigo,     
         IngresoUsuario,     
         PYMEFlag,     
         PersonaAnt,     
         Nombres,     
         Busqueda    
    )    
    VALUES(    
    @Persona,     
    'PE',    
    @ApellidoPaterno,     
    @ApellidoMaterno,     
    @NombreCompleto,     
    @TipoDocumento,    
    @Documento,     
    @CodigoBarras,     
    @EsCliente,     
    @EsEmpleado,     
    @EsOtro,     
    @TipoPersona,     
    @EsProveedor,     
    @FechaNacimiento,     
    @CiudadNacimiento,     
    @Sexo,     
    @Nacionalidad,     
    @EstadoCivil,     
    @NivelInstruccion,     
    @Direccion,     
    @CodigoPostal,     
    @Provincia,     
    @Departamento,     
    @Telefono,     
    @DocumentoFiscal,     
    @DocumentoIdentidad,     
    @ACCION,     
    @edad,     
    @rangoEtario,     
    @TipoMedico,     
    @Correcion,     
    @EsPaciente,     
    @EsEmpresa,    
    @Pais,     
    @FlagActualizacion,     
    @CuentaMonedaLocal_tmp,     
    @CuentaMonedaExtranjera_tmp,     
    @CorrelativoSCTR,     
    @SeguroDiscamec,     
    @CodDiscamec,     
    @FecIniDiscamec,     
    @FecFinDiscamec,     
    @LugarNacimiento,     
    @Celular,     
    @CelularEmergencia,     
    @ParentescoEmergencia,     
    @DireccionReferencia,     
    GETDATE(),     
    @TipoPersonaUsuario,     
    @UltimoUsuario,     
    'A',     
    @DireccionEmergencia,     
    @TelefonoEmergencia,     
    @BancoMonedaLocal,     
    @TipoCuentaLocal,     
    @CuentaMonedaLocal,     
    @BancoMonedaExtranjera,     
    @TipoCuentaExtranjera,     
    @CuentaMonedaExtranjera,     
    @CorreoElectronico,     
    @EnfermedadGraveFlag,     
    GETDATE(),     
    @IngresoAplicacionCodigo,     
    @IngresoUsuario,     
    @PYMEFlag,     
    @PersonaAnt,     
    @Nombres,     
    @Busqueda    
      
    )    
    insert into SS_GE_Paciente    
    (    
        IdPaciente,     
        TipoPaciente,     
        Raza,     
        AreaLaboral,     
        Ocupacion,     
        CodigoHC,     
        CodigoHCAnterior,     
        CodigoHCSecundario,     
        TipoAlmacenamiento,     
        TipoHistoria,     
        TipoSituacion,     
        IdUbicacion,     
        LugarProcedencia,     
        RutaFoto,     
        Estado,     
        NumeroFile,     
        Servicio,     
        Observacion,     
        IndicadorAsistencia,     
        CantidadAsistencia,     
        UbicacionHHCC,     
        IndicadorMigradoSiteds,     
        NumeroCaja,     
        IndicadorCodigoBarras,     
        IDPACIENTE_OK,     
        CodigoAsegurado,     
        NumeroPoliza,     
        NumeroCertificado,     
        CodigoProducto,     
        CodigoPlan,     
        TipoParentesco,     
        CodigoBeneficio,     
        Situacion,     
        TomoActual,     
        IndicadorHistoriaFisica,     
        DescripcionHistoria,    
        Accion,
        IdPersonal,
		AtencionLugar,
		Atencion,
		IdEstablecimientoIngreso,
		IdServicioIngreso,
		Prestacion,
		Destino,
		NroAutorizacion,
		Monto,
		FechaIngresoHosp,
		FechaCorteHosp,
		Establecimiento01,
		ReferenciaHoja01,
		Establecimiento02,
		ReferenciaHoja02,
		UsuarioCreacion,
		UsuarioModificacion,
		FechaCreacion,
		FechaModificacion  
    )    
        
    values    
    (    
    @Paciente,     
    @TipoPaciente,     
    @Raza,     
    @AreaLaboral,     
    @Ocupacion,    
    @Persona,  
    --@CodigoHC,     
    @CodigoHCAnterior,     
    @CodigoHCSecundario,     
    @TipoAlmacenamiento,     
    @TipoHistoria,     
    @TipoSituacion,     
    @IdUbicacion,     
    @LugarProcedencia,     
    @RutaFoto,     
    2,     
    @NumeroFile,     
    @Servicio,     
    @Observacion,     
    @IndicadorAsistencia,     
    @CantidadAsistencia,     
    @UbicacionHHCC,     
    @IndicadorMigradoSiteds,     
    @NumeroCaja,     
    @IndicadorCodigoBarras,     
    @IDPACIENTE_OK,     
    @CodigoAsegurado,     
    @NumeroPoliza,     
    @NumeroCertificado,     
    @CodigoProducto,     
    'TELESALUD',     
    @TipoParentesco,     
    @CodigoBeneficio,     
    @Situacion,     
    @TomoActual,     
    @IndicadorHistoriaFisica,     
    @DescripcionHistoria,     
    @ACCION,
    @IdPersonal,
    @AtencionLugar,
    @Atencion,
    @IdEstablecimientoIngreso,
    @IdServicioIngreso,
    @Prestacion,
    @Destino,
    @NroAutorizacion,
    @Monto,
    @FechaIngresoHosp,
    @FechaCorteHosp,
    @Establecimiento01,
    @ReferenciaHoja01,
    @Establecimiento02,
    @ReferenciaHoja02,
		'ENFEMER',
	'ENFEMER',
	GETDATE(),
	GETDATE()
    )    
   DECLARE @UnidadReplicacion VARCHAR(20)  
   DECLARE @CodigoOA int, @IdOrdenAtencion int, @TipoOrdenAtencion int, @IdEspecialidad int,  
    @TipoAtencion int, @IdEstablecimientoSalud int, @Linea int, @IndicadorTMH int  

  set @TipoOrdenAtencion=1  
  set @IdEspecialidad=1  
  set @TipoAtencion=1  
  set @IdEstablecimientoSalud=1  
  set @UnidadReplicacion = 'CEG'  
  set @IndicadorTMH=10  

    
   SELECT @CodigoOA=isnull(max(CorrelativoNumero),0)+1 FROM  CorrelativosMast WITH(NOLOCK)   
   WHERE CompaniaCodigo='00000000' AND TipoComprobante='OA'  
   
   UPDATE CorrelativosMast SET CorrelativoNumero=@CodigoOA WHERE CompaniaCodigo='00000000' AND TipoComprobante='OA'  
           
   SELECT @IdOrdenAtencion=isnull(max(IdOrdenAtencion),0)+1 FROM  SS_AD_OrdenAtencion   
           
   insert into SS_AD_OrdenAtencion  
   (  
    IdOrdenAtencion,TipoOrdenAtencion,CodigoOA,Especialidad,TipoAtencion,  
    TipoPaciente,IdServicio,IdPaciente,IdEmpresaAseguradora,Compania,  
    Sucursal,IdEstablecimiento,EstadoDocumento,EstadoDocumentoAnterior,  
    UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,IdEmpleado,  
    UnidadReplicacion, Estado,IndicadorTMH  
   )  
   values  
   (  
    @IdOrdenAtencion,@TipoOrdenAtencion,@CodigoOA,@IdEspecialidad,@TipoAtencion,  
    @TipoPaciente,null,@Paciente,null,null,  
    null,@IdEstablecimientoSalud,null,null,  
    @UltimoUsuario,GETDATE(),@UltimoUsuario,GETDATE(),null,    
    @UnidadReplicacion, 2,@IndicadorTMH  
   )  
   Select @Linea=isnull(max(IdOrdenAtencion),0)+1 from SS_AD_OrdenAtencionDetalle  
   where IdOrdenAtencion = @IdOrdenAtencion  
     
  insert into dbo.SS_AD_OrdenAtencionDetalle  
   ( IdOrdenAtencion,Linea,TipoOrdenAtencion,Especialidad,IdCita,  
     IdPaciente, IdEstablecimiento,Estado  
   )  
   values  
   (  
    @IdOrdenAtencion,@Linea,@TipoOrdenAtencion,@IdEspecialidad,null,  
    @Paciente,@IdEspecialidad,2  
   )  
   select @CONTADORPER    
  END  

 ELSE IF(@Accion = 'INSERTAR_PERSONA_TRIAJE')      
  BEGIN  
   select @CONTADORPER= (isnull(max(Persona),0)) +1 from personamast     
    set @Persona= @CONTADORPER    
    set @Paciente= @CONTADORPER    
        
    INSERT INTO personamast      
    (     
      Persona,     
      Origen,     
      ApellidoPaterno,     
      ApellidoMaterno,     
      NombreCompleto,     
         TipoDocumento,    
         Documento,     
         CodigoBarras,     
         EsCliente,     
         EsEmpleado,     
         EsOtro,     
         TipoPersona,     
         EsProveedor,     
         FechaNacimiento,     
         CiudadNacimiento,     
         Sexo,     
         Nacionalidad,     
         EstadoCivil,     
         NivelInstruccion,     
         Direccion,     
         CodigoPostal,     
         Provincia,     
         Departamento,     
         Telefono,     
         DocumentoFiscal,     
         DocumentoIdentidad,     
         ACCION,     
         edad,     
         rangoEtario,     
         TipoMedico,     
         Correcion,     
         EsPaciente,     
         EsEmpresa,    
         Pais,     
         FlagActualizacion,     
         CuentaMonedaLocal_tmp,     
         CuentaMonedaExtranjera_tmp,     
         CorrelativoSCTR,     
         SeguroDiscamec,     
         CodDiscamec,     
         FecIniDiscamec,     
         FecFinDiscamec,     
         LugarNacimiento,     
         Celular,     
         CelularEmergencia,     
         ParentescoEmergencia,     
         DireccionReferencia,     
         UltimaFechaModif,     
         TipoPersonaUsuario,     
         UltimoUsuario,     
         Estado,     
         DireccionEmergencia,     
         TelefonoEmergencia,     
         BancoMonedaLocal,     
         TipoCuentaLocal,     
         CuentaMonedaLocal,     
         BancoMonedaExtranjera,     
         TipoCuentaExtranjera,     
         CuentaMonedaExtranjera,     
         CorreoElectronico,     
         EnfermedadGraveFlag,     
         IngresoFechaRegistro,     
         IngresoAplicacionCodigo,     
         IngresoUsuario,     
         PYMEFlag,     
         PersonaAnt,     
         Nombres,     
         Busqueda    
    )    
    VALUES(    
    @Persona,     
    'PE',    
    @ApellidoPaterno,     
    @ApellidoMaterno,     
    @NombreCompleto,     
    @TipoDocumento,    
    @Documento,     
    @CodigoBarras,     
    @EsCliente,     
    @EsEmpleado,     
    @EsOtro,     
    @TipoPersona,     
    @EsProveedor,     
    @FechaNacimiento,     
    @CiudadNacimiento,     
    @Sexo,     
    @Nacionalidad,     
    @EstadoCivil,     
    @NivelInstruccion,     
    @Direccion,     
    @CodigoPostal,     
    @Provincia,     
    @Departamento,     
    @Telefono,     
    @DocumentoFiscal,     
    @DocumentoIdentidad,     
    @ACCION,     
    @edad,     
    @rangoEtario,     
    @TipoMedico,     
    @Correcion,     
    @EsPaciente,     
    @EsEmpresa,    
    @Pais,     
    @FlagActualizacion,     
    @CuentaMonedaLocal_tmp,     
    @CuentaMonedaExtranjera_tmp,     
    @CorrelativoSCTR,     
    @SeguroDiscamec,     
    @CodDiscamec,     
    @FecIniDiscamec,     
    @FecFinDiscamec,     
    @LugarNacimiento,     
    @Celular,     
    @CelularEmergencia,     
    @ParentescoEmergencia,     
    @DireccionReferencia,     
    GETDATE(),     
    @TipoPersonaUsuario,     
    @UltimoUsuario,     
    'A',     
    @DireccionEmergencia,     
    @TelefonoEmergencia,     
    @BancoMonedaLocal,     
    @TipoCuentaLocal,     
    @CuentaMonedaLocal,     
    @BancoMonedaExtranjera,     
    @TipoCuentaExtranjera,     
    @CuentaMonedaExtranjera,     
    @CorreoElectronico,     
    @EnfermedadGraveFlag,     
    GETDATE(),     
    @IngresoAplicacionCodigo,     
    @IngresoUsuario,     
    @PYMEFlag,     
    @PersonaAnt,     
    @Nombres,     
    @Busqueda    
      
    )    
    insert into SS_GE_Paciente    
    (    
        IdPaciente,     
        TipoPaciente,     
        Raza,     
        AreaLaboral,     
        Ocupacion,     
        CodigoHC,     
        CodigoHCAnterior,     
        CodigoHCSecundario,     
        TipoAlmacenamiento,     
        TipoHistoria,     
        TipoSituacion,     
        IdUbicacion,     
        LugarProcedencia,     
        RutaFoto,     
        Estado,     
        NumeroFile,     
        Servicio,     
        Observacion,     
        IndicadorAsistencia,     
        CantidadAsistencia,     
        UbicacionHHCC,     
        IndicadorMigradoSiteds,     
        NumeroCaja,     
        IndicadorCodigoBarras,     
        IDPACIENTE_OK,     
        CodigoAsegurado,     
        NumeroPoliza,     
        NumeroCertificado,     
        CodigoProducto,     
        CodigoPlan,     
        TipoParentesco,     
        CodigoBeneficio,     
        Situacion,     
        TomoActual,     
        IndicadorHistoriaFisica,     
        DescripcionHistoria,    
        Accion,
        IdPersonal,
		AtencionLugar,
		Atencion,
		IdEstablecimientoIngreso,
		IdServicioIngreso,
		Prestacion,
		Destino,
		NroAutorizacion,
		Monto,
		FechaIngresoHosp,
		FechaCorteHosp,
		Establecimiento01,
		ReferenciaHoja01,
		Establecimiento02,
		ReferenciaHoja02,
		UsuarioCreacion,
		UsuarioModificacion,
		FechaCreacion,
		FechaModificacion 
    )    
        
    values    
    (    
    @Paciente,     
    @TipoPaciente,     
    @Raza,     
    @AreaLaboral,     
    @Ocupacion,    
    @Persona,  
    --@CodigoHC,     
    @CodigoHCAnterior,     
    @CodigoHCSecundario,     
    @TipoAlmacenamiento,     
    @TipoHistoria,     
    @TipoSituacion,     
    @IdUbicacion,     
    @LugarProcedencia,     
    @RutaFoto,     
    2,     
    @NumeroFile,     
    @Servicio,     
    @Observacion,     
    @IndicadorAsistencia,     
    @CantidadAsistencia,     
    @UbicacionHHCC,     
    @IndicadorMigradoSiteds,     
    @NumeroCaja,     
    @IndicadorCodigoBarras,     
    @IDPACIENTE_OK,     
    @CodigoAsegurado,     
    @NumeroPoliza,     
    @NumeroCertificado,     
    @CodigoProducto,     
    'TELESALUD',     
    @TipoParentesco,     
    @CodigoBeneficio,     
    @Situacion,     
    @TomoActual,     
    @IndicadorHistoriaFisica,     
    @DescripcionHistoria,     
    @ACCION,
    @IdPersonal,
    @AtencionLugar,
    @Atencion,
    @IdEstablecimientoIngreso,
    @IdServicioIngreso,
    @Prestacion,
    @Destino,
    @NroAutorizacion,
    @Monto,
    @FechaIngresoHosp,
    @FechaCorteHosp,
    @Establecimiento01,
    @ReferenciaHoja01,
    @Establecimiento02,
    @ReferenciaHoja02,
		'ENFEMER',
	'ENFEMER',
	GETDATE(),
	GETDATE()
    )   
    select @CONTADORPER  ;
  END     

  END     
  
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_GE_ProcedimientoMedico]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================             
-- Author:    Grace Córdova             
-- Create date: 06/11/2015      
-- =============================================       
CREATE OR ALTER PROCEDURE [SP_SS_GE_ProcedimientoMedico]     
@IdProcedimiento INT,      
@CodigoProcedimiento VARCHAR(15),      
@CodigoPadre VARCHAR(15),      
@Nombre VARCHAR(MAX),      
@Descripcion VARCHAR(MAX),      
      
@Estado INT,      
@UsuarioCreacion VARCHAR(25),      
@FechaCreacion DATETIME,      
@UsuarioModificacion VARCHAR(25),      
@FechaModificacion DATETIME,      
      
@IdProcedimientoPadre INT,      
@Orden INT,      
@CadenaRecursividad VARCHAR(150),      
@Nivel INT,      
@DiagnosticoSiteds VARCHAR(15),      
      
@IndicadorPermitido INT,      
@tipofolder INT,      
@NombreTabla VARCHAR(15),      
@Accion VARCHAR(25),  
@CodigoSegus VARCHAR(25)  
AS      
BEGIN      
IF (@Accion = 'INSERT')      
BEGIN      
  SELECT @IdProcedimiento = Isnull(Max(IdProcedimiento), 0) + 1       
            FROM   dbo.SS_GE_ProcedimientoMedico    
INSERT INTO SS_GE_ProcedimientoMedico   
(IdProcedimiento,      
CodigoProcedimiento,      
CodigoPadre,      
Nombre,      
Descripcion,      
Estado,      
UsuarioCreacion,      
FechaCreacion,      
UsuarioModificacion,      
FechaModificacion,      
IdProcedimientoPadre,      
Orden,      
CadenaRecursividad,      
Nivel,      
DiagnosticoSiteds,      
IndicadorPermitido,      
tipofolder,      
NombreTabla,      
accion,  
CodigoSegus  
)values(@IdProcedimiento,      
@CodigoProcedimiento,      
@CodigoPadre,      
@Nombre,      
@Descripcion,      
@Estado,      
@UsuarioCreacion,      
GETDATE(),      
@UsuarioModificacion,      
GETDATE(),      
@IdProcedimientoPadre,      
@Orden,      
@CadenaRecursividad,      
@Nivel,      
@DiagnosticoSiteds,      
@IndicadorPermitido,      
@tipofolder,      
@NombreTabla,      
@Accion,  
@CodigoSegus)      
SELECT 1      
END      
ELSE IF (@Accion = 'UPDATE')      
BEGIN      
UPDATE SS_GE_ProcedimientoMedico      
SET      
IdProcedimiento=@IdProcedimiento,      
CodigoProcedimiento=@CodigoProcedimiento,      
CodigoPadre=@CodigoPadre,      
Nombre=@Nombre,      
Descripcion=@Descripcion,      
Estado=@Estado,       
UsuarioModificacion=@UsuarioModificacion,      
FechaModificacion=GETDATE(),      
IdProcedimientoPadre=@IdProcedimientoPadre,      
Orden=@Orden,      
CadenaRecursividad=@CadenaRecursividad,      
Nivel=@Nivel,      
DiagnosticoSiteds=@DiagnosticoSiteds,      
IndicadorPermitido=@IndicadorPermitido,      
tipofolder=@tipofolder,      
NombreTabla=@NombreTabla,  
CodigoSegus=@CodigoSegus    
WHERE IdProcedimiento = @IdProcedimiento      
select 1      
END      
ELSE IF (@Accion = 'DELETE')      
BEGIN      
DELETE  SS_GE_ProcedimientoMedico   
WHERE IdProcedimiento = @IdProcedimiento    
select 1      
END      
ELSE IF (@Accion = 'LISTARPAG')      
BEGIN      
DECLARE @CONTADOR INT      
SET @CONTADOR = (SELECT COUNT(*) FROM SS_GE_ProcedimientoMedico     
WHERE (UPPER(CodigoProcedimiento) LIKE '%'+UPPER(@CodigoProcedimiento)+'%' OR @CodigoProcedimiento IS NULL)      
AND (@CodigoSegus IS NULL OR UPPER(CodigoSegus) LIKE '%'+UPPER(@CodigoSegus)+'%')  
AND (@Nombre IS NULL OR UPPER(Nombre) LIKE '%'+UPPER(@Nombre)+'%')      
AND (@Descripcion IS NULL OR UPPER(Descripcion) LIKE '%'+UPPER(@Descripcion)+'%')    
AND (Estado = @Estado OR @Estado IS NULL OR @Estado = 0)      
AND (IdProcedimiento = @IdProcedimiento OR @IdProcedimiento IS NULL OR @IdProcedimiento = 0)      
AND (IdProcedimientoPadre = @IdProcedimientoPadre OR @IdProcedimientoPadre IS NULL OR @IdProcedimientoPadre = 0)
AND (@CodigoSegus IS NULL OR UPPER(CodigoSegus) LIKE '%'+UPPER(@CodigoSegus)+'%') )      
SELECT @CONTADOR      
END      
END      
/*      
EXEC SP_SS_GE_ProcedimientoMedico      
null,null,null,null,null,      
null,null,null,null,null,      
null,null,null,null,null,      
null,null,null,'LISTARPAG',  
NULL   
*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_GE_ProcedimientoMedicoDos]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================         
-- Author:    Grace Córdova         
-- Create date: 07/08/2015  
-- =============================================   
CREATE OR ALTER PROCEDURE [SP_SS_GE_ProcedimientoMedicoDos]  
@IdProcedimientoDos INT,  
@CodigoProcedimientoDos VARCHAR(15),  
@CodigoPadre VARCHAR(15),  
@Nombre VARCHAR(MAX),  
@Descripcion VARCHAR(MAX),  
  
@Estado INT,  
@UsuarioCreacion VARCHAR(25),  
@FechaCreacion DATETIME,  
@UsuarioModificacion VARCHAR(25),  
@FechaModificacion DATETIME,  
  
@IdProcedimientoDosPadre INT,  
@Orden INT,  
@CadenaRecursividad VARCHAR(150),  
@Nivel INT,  
@DiagnosticoSiteds VARCHAR(15),  
  
@IndicadorPermitido INT,  
@tipofolder INT,  
@NombreTabla VARCHAR(15),  
@Accion VARCHAR(25)  
AS  
BEGIN  
IF (@Accion = 'INSERT')  
BEGIN  
  SELECT @IdProcedimientoDos = Isnull(Max(IdProcedimientoDos), 0) + 1   
            FROM   dbo.SS_GE_ProcedimientoMedicoDos   
INSERT INTO SS_GE_ProcedimientoMedicoDos  
(IdProcedimientoDos,  
CodigoProcedimientoDos,  
CodigoPadre,  
Nombre,  
Descripcion,  
Estado,  
UsuarioCreacion,  
FechaCreacion,  
UsuarioModificacion,  
FechaModificacion,  
IdProcedimientoDosPadre,  
Orden,  
CadenaRecursividad,  
Nivel,  
DiagnosticoSiteds,  
IndicadorPermitido,  
tipofolder,  
NombreTabla,  
accion  
)values(@IdProcedimientoDos,  
@CodigoProcedimientoDos,  
@CodigoPadre,  
@Nombre,  
@Descripcion,  
@Estado,  
@UsuarioCreacion,  
GETDATE(),  
@UsuarioModificacion,  
GETDATE(),  
@IdProcedimientoDosPadre,  
@Orden,  
@CadenaRecursividad,  
@Nivel,  
@DiagnosticoSiteds,  
@IndicadorPermitido,  
@tipofolder,  
@NombreTabla,  
@Accion)  
SELECT 1  
END  
ELSE IF (@Accion = 'UPDATE')  
BEGIN  
UPDATE SS_GE_ProcedimientoMedicoDos  
SET  
IdProcedimientoDos=@IdProcedimientoDos,  
CodigoProcedimientoDos=@CodigoProcedimientoDos,  
CodigoPadre=@CodigoPadre,  
Nombre=@Nombre,  
Descripcion=@Descripcion,  
Estado=@Estado,   
UsuarioModificacion=@UsuarioModificacion,  
FechaModificacion=GETDATE(),  
IdProcedimientoDosPadre=@IdProcedimientoDosPadre,  
Orden=@Orden,  
CadenaRecursividad=@CadenaRecursividad,  
Nivel=@Nivel,  
DiagnosticoSiteds=@DiagnosticoSiteds,  
IndicadorPermitido=@IndicadorPermitido,  
tipofolder=@tipofolder,  
NombreTabla=@NombreTabla  
WHERE IdProcedimientoDos = @IdProcedimientoDos  
select 1  
END  
ELSE IF (@Accion = 'DELETE')  
BEGIN  
DELETE  SS_GE_ProcedimientoMedicoDos  
WHERE IdProcedimientoDos = @IdProcedimientoDos  
select 1  
END  
ELSE IF (@Accion = 'LISTARPAG')  
BEGIN  
DECLARE @CONTADOR INT  
SET @CONTADOR = (SELECT COUNT(*) FROM SS_GE_ProcedimientoMedicoDos  
WHERE (UPPER(CodigoProcedimientoDos) LIKE '%'+UPPER(@CodigoProcedimientoDos)+'%' OR @CodigoProcedimientoDos IS NULL)  
AND (@Nombre IS NULL OR UPPER(Nombre) LIKE '%'+UPPER(@Nombre)+'%')  
AND (Estado = @Estado OR @Estado IS NULL OR @Estado = 0)  
AND (IdProcedimientoDos = @IdProcedimientoDos OR @IdProcedimientoDos IS NULL OR @IdProcedimientoDos = 0)  
AND (IdProcedimientoDosPadre = @IdProcedimientoDosPadre OR @IdProcedimientoDosPadre IS NULL OR @IdProcedimientoDosPadre = 0))  
SELECT @CONTADOR  
END  
END  
/*  
EXEC SP_SS_GE_ProcedimientoMedicoDos  
null,null,null,null,null,  
null,null,null,null,null,  
null,null,null,null,null,  
null,null,null,'LISTARPAG'  
*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_GE_ProcedimientoMedicoDosListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================       
-- Author:    Grace Córdova       
-- Create date: 07/08/2015
-- =============================================
CREATE OR ALTER PROCEDURE [SP_SS_GE_ProcedimientoMedicoDosListar]
@IdProcedimientoDos INT,
@CodigoProcedimientoDos VARCHAR(15),
@CodigoPadre VARCHAR(15),
@Nombre VARCHAR(MAX),
@Descripcion VARCHAR(MAX),

@Estado INT,
@UsuarioCreacion VARCHAR(25),
@FechaCreacion DATETIME,
@UsuarioModificacion VARCHAR(25),
@FechaModificacion DATETIME,

@IdProcedimientoDosPadre INT,
@Orden INT,
@CadenaRecursividad VARCHAR(150),
@Nivel INT,
@DiagnosticoSiteds VARCHAR(15),

@IndicadorPermitido INT,
@tipofolder INT,
@NombreTabla VARCHAR(15),
@Accion VARCHAR(25),
@INICIO   INT= null,  

@NUMEROFILAS INT = null
AS
BEGIN
IF (@Accion = 'LISTAR')
BEGIN
SELECT
SS_GE_ProcedimientoMedicoDos.IdProcedimientoDos,
SS_GE_ProcedimientoMedicoDos.CodigoProcedimientoDos,
SS_GE_ProcedimientoMedicoDos.CodigoPadre,
SS_GE_ProcedimientoMedicoDos.Nombre,
SS_GE_ProcedimientoMedicoDos.Descripcion,
SS_GE_ProcedimientoMedicoDos.Estado,
SS_GE_ProcedimientoMedicoDos.UsuarioCreacion,
SS_GE_ProcedimientoMedicoDos.FechaCreacion,
SS_GE_ProcedimientoMedicoDos.UsuarioModificacion,
SS_GE_ProcedimientoMedicoDos.FechaModificacion,
SS_GE_ProcedimientoMedicoDos.IdProcedimientoDosPadre,
SS_GE_ProcedimientoMedicoDos.Orden,
SS_GE_ProcedimientoMedicoDos.CadenaRecursividad,
SS_GE_ProcedimientoMedicoDos.Nivel,
SS_GE_ProcedimientoMedicoDos.DiagnosticoSiteds,
SS_GE_ProcedimientoMedicoDos.IndicadorPermitido,
SS_GE_ProcedimientoMedicoDos.tipofolder,
SS_GE_ProcedimientoMedicoDos.NombreTabla,
SS_GE_ProcedimientoMedicoDos.Accion
FROM
SS_GE_ProcedimientoMedicoDos
WHERE
 (@Nombre IS NULL OR UPPER(Nombre) LIKE '%'+UPPER(@Nombre)+'%')
AND (@CodigoProcedimientoDos IS NULL OR CodigoProcedimientoDos = @CodigoProcedimientoDos)
AND (Estado = @Estado OR @Estado IS NULL OR @Estado = 0)
AND (IdProcedimientoDos = @IdProcedimientoDos OR @IdProcedimientoDos IS NULL OR @IdProcedimientoDos = 0)
AND (IdProcedimientoDosPadre = @IdProcedimientoDosPadre OR @IdProcedimientoDosPadre IS NULL OR @IdProcedimientoDosPadre = 0)
END
ELSE IF (@Accion = 'LISTARPAG')
BEGIN
DECLARE @CONTADOR INT
SELECT @CONTADOR = COUNT(*) FROM SS_GE_ProcedimientoMedicoDos
WHERE (UPPER(CodigoProcedimientoDos) LIKE '%'+UPPER(@CodigoProcedimientoDos)+'%' OR @CodigoProcedimientoDos IS NULL)
AND (@Nombre IS NULL OR UPPER(Nombre) LIKE '%'+UPPER(@Nombre)+'%')
AND (Estado = @Estado OR @Estado IS NULL OR @Estado = 0)
AND (IdProcedimientoDos = @IdProcedimientoDos OR @IdProcedimientoDos IS NULL OR @IdProcedimientoDos = 0)
AND (IdProcedimientoDosPadre = @IdProcedimientoDosPadre OR @IdProcedimientoDosPadre IS NULL OR @IdProcedimientoDosPadre = 0)

SELECT
IdProcedimientoDos,
CodigoProcedimientoDos,
CodigoPadre,
Nombre,
Descripcion,
Estado,
UsuarioCreacion,
FechaCreacion,
UsuarioModificacion,
FechaModificacion,
IdProcedimientoDosPadre,
Orden,
CadenaRecursividad,
Nivel,
DiagnosticoSiteds,
IndicadorPermitido,
tipofolder,
NombreTabla,
Accion
FROM
(SELECT
SS_GE_ProcedimientoMedicoDos.IdProcedimientoDos,
SS_GE_ProcedimientoMedicoDos.CodigoProcedimientoDos,
SS_GE_ProcedimientoMedicoDos.CodigoPadre,
SS_GE_ProcedimientoMedicoDos.Nombre,
SS_GE_ProcedimientoMedicoDos.Descripcion,
SS_GE_ProcedimientoMedicoDos.Estado,
SS_GE_ProcedimientoMedicoDos.UsuarioCreacion,
SS_GE_ProcedimientoMedicoDos.FechaCreacion,
SS_GE_ProcedimientoMedicoDos.UsuarioModificacion,
SS_GE_ProcedimientoMedicoDos.FechaModificacion,
SS_GE_ProcedimientoMedicoDos.IdProcedimientoDosPadre,
SS_GE_ProcedimientoMedicoDos.Orden,
SS_GE_ProcedimientoMedicoDos.CadenaRecursividad,
SS_GE_ProcedimientoMedicoDos.Nivel,
SS_GE_ProcedimientoMedicoDos.DiagnosticoSiteds,
SS_GE_ProcedimientoMedicoDos.IndicadorPermitido,
SS_GE_ProcedimientoMedicoDos.tipofolder,
SS_GE_ProcedimientoMedicoDos.NombreTabla,
SS_GE_ProcedimientoMedicoDos.Accion,
@CONTADOR AS CONTADOR,
ROW_NUMBER() OVER(ORDER BY IdProcedimientoDos) as ROWNUMBER
FROM
SS_GE_ProcedimientoMedicoDos
WHERE (UPPER(CodigoProcedimientoDos) LIKE '%'+UPPER(@CodigoProcedimientoDos)+'%' OR @CodigoProcedimientoDos IS NULL)
AND (@Nombre IS NULL OR UPPER(Nombre) LIKE '%'+UPPER(@Nombre)+'%')
AND (Estado = @Estado OR @Estado IS NULL OR @Estado = 0)
AND (IdProcedimientoDos = @IdProcedimientoDos OR @IdProcedimientoDos IS NULL OR @IdProcedimientoDos = 0)
AND (IdProcedimientoDosPadre = @IdProcedimientoDosPadre OR @IdProcedimientoDosPadre IS NULL OR @IdProcedimientoDosPadre = 0))AS LISTADO
WHERE(@INICIO IS NULL AND @NUMEROFILAS IS NULL)
OR (ROWNUMBER BETWEEN @INICIO AND @NUMEROFILAS)
END
END
/*
EXEC SP_SS_GE_ProcedimientoMedicoDosListar
NULL,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,'LISTARPAG',0,
10
*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_GE_ProcedimientoMedicoListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================         
-- Author:    Grace Córdova         
-- Create date: 06/11/2015  
-- =============================================  
CREATE OR ALTER PROCEDURE [SP_SS_GE_ProcedimientoMedicoListar]  
@IdProcedimiento INT,  
@CodigoProcedimiento VARCHAR(15),  
@CodigoPadre VARCHAR(15),  
@Nombre VARCHAR(MAX),  
@Descripcion VARCHAR(MAX),  
  
@Estado INT,  
@UsuarioCreacion VARCHAR(25),  
@FechaCreacion DATETIME,  
@UsuarioModificacion VARCHAR(25),  
@FechaModificacion DATETIME,  
  
@IdProcedimientoPadre INT,  
@Orden INT,  
@CadenaRecursividad VARCHAR(150),  
@Nivel INT,  
@DiagnosticoSiteds VARCHAR(15),  
  
@IndicadorPermitido INT,  
@tipofolder INT,  
@NombreTabla VARCHAR(15),  
@Accion VARCHAR(25), 
@CodigoSegus VARCHAR(25),

@INICIO   INT= null,      
@NUMEROFILAS INT = null  
AS  
BEGIN  
IF (@Accion = 'LISTAR')  
BEGIN  
SELECT  
SS_GE_ProcedimientoMedico.IdProcedimiento,  
SS_GE_ProcedimientoMedico.CodigoProcedimiento,  
SS_GE_ProcedimientoMedico.CodigoPadre,  
SS_GE_ProcedimientoMedico.Nombre,  
SS_GE_ProcedimientoMedico.Descripcion,  
SS_GE_ProcedimientoMedico.Estado,  
SS_GE_ProcedimientoMedico.UsuarioCreacion,  
SS_GE_ProcedimientoMedico.FechaCreacion,  
SS_GE_ProcedimientoMedico.UsuarioModificacion,  
SS_GE_ProcedimientoMedico.FechaModificacion,  
SS_GE_ProcedimientoMedico.IdProcedimientoPadre,  
SS_GE_ProcedimientoMedico.Orden,  
SS_GE_ProcedimientoMedico.CadenaRecursividad,  
SS_GE_ProcedimientoMedico.Nivel,  
SS_GE_ProcedimientoMedico.DiagnosticoSiteds,  
SS_GE_ProcedimientoMedico.IndicadorPermitido,  
SS_GE_ProcedimientoMedico.tipofolder,  
SS_GE_ProcedimientoMedico.NombreTabla,  
SS_GE_ProcedimientoMedico.Accion,
SS_GE_ProcedimientoMedico.CodigoSegus  
FROM  
SS_GE_ProcedimientoMedico  
WHERE  
 (@Nombre IS NULL OR UPPER(Nombre) LIKE '%'+UPPER(@Nombre)+'%')  
 AND (@Descripcion IS NULL OR UPPER(Descripcion) LIKE '%'+UPPER(@Descripcion)+'%')  
AND (@CodigoProcedimiento IS NULL OR CodigoProcedimiento = @CodigoProcedimiento)  
AND (@CodigoSegus IS NULL OR UPPER(CodigoSegus) LIKE '%'+UPPER(@CodigoSegus)+'%')  

AND (Estado = @Estado OR @Estado IS NULL OR @Estado = 0)  
AND (IdProcedimiento = @IdProcedimiento OR @IdProcedimiento IS NULL OR @IdProcedimiento = 0)  
AND (IdProcedimientoPadre = @IdProcedimientoPadre OR @IdProcedimientoPadre IS NULL OR @IdProcedimientoPadre = 0)  
END  
ELSE IF (@Accion = 'LISTARPAG')  
BEGIN  
DECLARE @CONTADOR INT  
SELECT @CONTADOR = COUNT(*) FROM SS_GE_ProcedimientoMedico 
WHERE (UPPER(CodigoProcedimiento) LIKE '%'+UPPER(@CodigoProcedimiento)+'%' OR @CodigoProcedimiento IS NULL)  
AND (@Nombre IS NULL OR UPPER(Nombre) LIKE '%'+UPPER(@Nombre)+'%')  
AND (@Descripcion IS NULL OR UPPER(Descripcion) LIKE '%'+UPPER(@Descripcion)+'%')  
AND (@CodigoSegus IS NULL OR UPPER(CodigoSegus) LIKE '%'+UPPER(@CodigoSegus)+'%')  
AND (Estado = @Estado OR @Estado IS NULL OR @Estado = 0)  
AND (IdProcedimiento = @IdProcedimiento OR @IdProcedimiento IS NULL OR @IdProcedimiento = 0)  
AND (IdProcedimientoPadre = @IdProcedimientoPadre OR @IdProcedimientoPadre IS NULL OR @IdProcedimientoPadre = 0)  
  
SELECT  
IdProcedimiento,  
CodigoProcedimiento,  
CodigoPadre,  
Nombre,  
Descripcion,  
Estado,  
UsuarioCreacion,  
FechaCreacion,  
UsuarioModificacion,  
FechaModificacion,  
IdProcedimientoPadre,  
Orden,  
CadenaRecursividad,  
Nivel,  
DiagnosticoSiteds,  
IndicadorPermitido,  
tipofolder,  
NombreTabla,  
Accion,
CodigoSegus
FROM  
(SELECT  
SS_GE_ProcedimientoMedico.IdProcedimiento,  
SS_GE_ProcedimientoMedico.CodigoProcedimiento,  
SS_GE_ProcedimientoMedico.CodigoPadre,  
SS_GE_ProcedimientoMedico.Nombre,  
SS_GE_ProcedimientoMedico.Descripcion,  
SS_GE_ProcedimientoMedico.Estado,  
SS_GE_ProcedimientoMedico.UsuarioCreacion,  
SS_GE_ProcedimientoMedico.FechaCreacion,  
SS_GE_ProcedimientoMedico.UsuarioModificacion,  
SS_GE_ProcedimientoMedico.FechaModificacion,  
SS_GE_ProcedimientoMedico.IdProcedimientoPadre,  
SS_GE_ProcedimientoMedico.Orden,  
SS_GE_ProcedimientoMedico.CadenaRecursividad,  
SS_GE_ProcedimientoMedico.Nivel,  
SS_GE_ProcedimientoMedico.DiagnosticoSiteds,  
SS_GE_ProcedimientoMedico.IndicadorPermitido,  
SS_GE_ProcedimientoMedico.tipofolder,  
SS_GE_ProcedimientoMedico.NombreTabla,  
SS_GE_ProcedimientoMedico.Accion,  
SS_GE_ProcedimientoMedico.CodigoSegus,  
@CONTADOR AS CONTADOR,  
ROW_NUMBER() OVER(ORDER BY CodigoPadre) as ROWNUMBER  
FROM  
SS_GE_ProcedimientoMedico 
WHERE (UPPER(CodigoProcedimiento) LIKE '%'+UPPER(@CodigoProcedimiento)+'%' OR @CodigoProcedimiento IS NULL)  
AND (@Nombre IS NULL OR UPPER(Nombre) LIKE '%'+UPPER(@Nombre)+'%')  
AND (@Descripcion IS NULL OR UPPER(Descripcion) LIKE '%'+UPPER(@Descripcion)+'%')  
AND (@CodigoSegus IS NULL OR UPPER(CodigoSegus) LIKE '%'+UPPER(@CodigoSegus)+'%')  
AND (Estado = @Estado OR @Estado IS NULL OR @Estado = 0)  
AND (IdProcedimiento = @IdProcedimiento OR @IdProcedimiento IS NULL OR @IdProcedimiento = 0)  
AND (IdProcedimientoPadre = @IdProcedimientoPadre OR @IdProcedimientoPadre IS NULL OR @IdProcedimientoPadre = 0))AS LISTADO  
WHERE(@INICIO IS NULL AND @NUMEROFILAS IS NULL)  
OR (ROWNUMBER BETWEEN @INICIO AND @NUMEROFILAS)  
END  
END  
/*  
EXEC SP_SS_GE_ProcedimientoMedicoListar  
NULL,NULL,NULL,NULL,NULL,  
NULL,NULL,NULL,NULL,NULL,  
NULL,NULL,NULL,NULL,NULL,  
NULL,NULL,NULL,'LISTARPAG',NULL,
0,10  
*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_GE_SeguridadOpcion]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE  [dbo].[SP_SS_GE_SeguridadOpcion]
    @Sistema      Varchar(4),
	@Nombre      Varchar(30),
	@Modulo      Varchar(2),
	@Orden      int,
	@NombreModulo      Varchar(50),
	@IdOpcion      int,
	@IdOpcionPadre     int,
	@CodigoOpcion      Varchar(15),
	@CadenaRecursividad      Varchar(15),--AUX UNID REPLICACION
	@NivelOpcion     int,
	@NombreOpcion      Varchar(80),
	@Descripcion      Varchar(80),
	@SubModulo      Varchar(2),
	@OrdenOpcion      int,
	@TipoOpcion      Varchar(1),
	@TipoIcono      int,
	@IndicadorPrioridad      int,	--AUX EPI CLINICO
	@IndicadorObjeto     int, 
	@IdObjetoAsociado     int,	--AUX ID UNIDAD DE SERVICIO
	@TipoDato      Varchar(2),
	@Compania      Varchar(15),
	@IndicadorCompania     int,
	@idTipoAtencion     int,
	@TipoTrabajador      Varchar(2),
	@IndicadorFormato     int,
	@IndicadorAsignacion   int,
	@TipoProceso    int,
	@Accion      Varchar(50),
	@Version      Varchar(50),  --AUX EPI ATENCIION
	@Estado      int,
	@IdAgente     int,
	@IdGrupo     int, --AUX ID ESPECIALIDAD
	@IdOrganizacion     int,--AUX ID ESTABLECIMIENTO
	@TipoAgente      int,
	@CodigoAgente    Varchar(20),
	@IdEmpleado     int,	--AUX IDPACIENTE
	@IndicadorMultiple    int,
	@Clave      Varchar(20),
	@NombreAgente      Varchar(60),
	@EstadoAgente       int,
	@Plataforma      Varchar(50),
 	@EstadoAgenteOpcion      int,
	@IdFormato      int,
	@IdFormatoPadre     int,
	@CodigoFormato      Varchar(50),
 
	@Nivel       int,
 	@TipoFormato      int,
	@VersionFormatoFijo      Varchar(50),
	@IdFormatoDinamico     int,
	@EstadoFormato       int
   
AS    
BEGIN    


	 DECLARE @TABLA_OPCIONESAGENTE_VALIDAS table       
	 (      
	  SECUENCIA   int  NOT NULL   IDENTITY PRIMARY KEY,      
	  idAgente int  null ,
	  TipoAgente int null,
	  idOpcion int null,
	  ESTADOAGENTE  int null,
	  INDICADOR varchar(30) null,
	  orden	int ,
	  NivelOpcion	int null,
	  TipoOpcion	varchar(1) null
	 )   
 	declare @cuenta int =1
	declare @ContadorOrden int =0
	declare @IdAgenteMax int =0
	declare @IdOpcionAux int =0
	declare @FechaAgenteMax datetime =null				
	declare @Total int =0
	
	declare @IndicadorVAL_AUX varchar(30)=null
	declare @IndicaTabla_AUX varchar(100)=null
	declare @IndicaTipo_AUX varchar(100)=null
	declare @CampoCodigoID_AUX int=0
	declare @ValorCODIGO_AUX varchar(30)=null
	declare @INDICA_AUX int=0
	
	declare @FormatoID_AUX int =0
	declare @FormatoDinamicoID_AUX int =0
	declare @FormatoCodigo_AUX varchar(30)=null
	
	if(@ACCION = 'LISTAPROCESOS' OR @ACCION = 'LISTAROPCIONESCAGENTE' OR @ACCION ='LISTAROPCIONESCAGENTEOBLIGATORIO' OR @ACCION = 'LISTAPROCESOGENERAL' or @ACCION = 'LISTAPROCESOSBITACORA')
		begin
		
			/*****************************************************************/
			/**CARGAR TABLA TEMPORAL CON LAS OPCIONES Y LOS PERFILES VALIDOS**/
			/*****************************************************************/
			---CARGAR AGENTES USUARIOS
			insert into @TABLA_OPCIONESAGENTE_VALIDAS					
			(idAgente,TipoAgente,idOpcion,ESTADOAGENTE,INDICADOR,orden,NivelOpcion,TipoOpcion)
				select IdAgente,TipoAgente,IdOpcion,EstadoAgente,'VALIDO',0 ,NivelOpcion,TipoOpcion
				from
				(
					select  
					seg.IdAgente,
					seg.TipoAgente,
					seg.NombreAgente,IdOpcion,seg.EstadoAgente,
					seg.NivelOpcion,seg.TipoOpcion
					from SS_CHE_VistaSeguridad as seg						 						 
					where			
						seg.IdAgente in(
							select IdPerfil from SG_PerfilUsuario where IdUsuario =@IdAgente
								and Estado=2
								union select @IdAgente
						)		
						and seg.TipoAgente= 2 --PRIMERO SOLAMENTE USUARIOS						
				)AS SEG_AUX				
				order by SEG_AUX.IdOpcion
			---CARGAR AGENTES PERFILES
			insert into @TABLA_OPCIONESAGENTE_VALIDAS					
			(idAgente,TipoAgente,idOpcion,ESTADOAGENTE,INDICADOR,orden,NivelOpcion,TipoOpcion)
				select IdAgente,TipoAgente,IdOpcion,EstadoAgente,'NO VALIDO',
				ROW_NUMBER() OVER (ORDER BY IdOpcion ASC ) AS RowNumber ,
				NivelOpcion,TipoOpcion
				from
				(
					select  
					seg.IdAgente,
					seg.TipoAgente,
					seg.NombreAgente,IdOpcion,seg.EstadoAgente,
					seg.NivelOpcion,seg.TipoOpcion
					--ROW_NUMBER() OVER (ORDER BY IdOpcion ASC ) AS RowNumber   			
					from SS_CHE_VistaSeguridad as seg						 						 
					where					
						seg.IdAgente in(
							select IdPerfil from SG_PerfilUsuario where IdUsuario =@IdAgente
								and Estado=2
								union select @IdAgente
						)		
						and seg.TipoAgente= 1 --SEGUNDO PERFILES
					
				)AS SEG_AUX
				where 
				SEG_AUX.IdOpcion Not in(select idOpcion from @TABLA_OPCIONESAGENTE_VALIDAS)
				order by SEG_AUX.IdOpcion, SEG_AUX.IdAgente	
												
				---ACTUALIZAMOS IDENTIFICANDO LOS VÁLIDOS Y LOS NO VÁLIDOS (criterio por definir mejor)				
				---CRITERIO: Tienen mayor prioridad los USUARIOS sobre los PERFILES
				---en el caso hubieran más de un PERFIL, se escoge el de mayor IDAgente

				select @Total= COUNT(*) from @TABLA_OPCIONESAGENTE_VALIDAS
					
				set @cuenta  =1			
				while(@cuenta <= @Total)
				begin										 
					select @IdAgenteMax	   = MAX(idagente) 
									from @TABLA_OPCIONESAGENTE_VALIDAS as AUX
									where AUX.idOpcion =
									 (select idOpcion from @TABLA_OPCIONESAGENTE_VALIDAS
										where SECUENCIA = @cuenta
									 )									 															
					
					update @TABLA_OPCIONESAGENTE_VALIDAS 
					set INDICADOR = 'VALIDO'					
					where idAgente = @IdAgenteMax					
					and idOpcion =
						(select idOpcion from @TABLA_OPCIONESAGENTE_VALIDAS
							where SECUENCIA = @cuenta
						)
					
					set @cuenta= @cuenta+1
					-------------
				end					
				
				/***********************************************************************/	
	end
 
	if(@ACCION = 'LISTAPROCESOS')
		BEGIN
			/*************************************************/
			/******CONFIGURACION DE ASIGNACIONES OPCION*****/
			/*************************************************/
			
				select @Total= COUNT(*) from @TABLA_OPCIONESAGENTE_VALIDAS
				set @cuenta  =1						
				
				while(@cuenta <= @Total)
				begin														 
					select @IndicadorVAL_AUX  = INDICADOR,
							@IdOpcionAux= idOpcion
						from @TABLA_OPCIONESAGENTE_VALIDAS as AUX
						where AUX.SECUENCIA = @cuenta
									 									 															
					if(@IndicadorVAL_AUX = 'VALIDO')
					begin
						select @INDICA_AUX =IndicadorAsignacion from SG_Opcion	
						where IdOpcion = @IdOpcionAux
						if(@INDICA_AUX = 2)
						begin						
							/***VALIDACIONES ASIGNADAS:**/
							--------------------------------
							--(1) ESPECIALIDAD
							--------------------------------
							set @CampoCodigoID_AUX = 4 -- 4: INDICA TABLA ESPECIALIDAD
							select @INDICA_AUX = count(*)
							from SS_HC_FormatoCodigoId
							where CampoCodigoId = @CampoCodigoID_AUX  --TABLA ESPECIALIDAD
							and IdOpcion=@IdOpcionAux
							if(@INDICA_AUX > 0) --POSEE ASIGNACIONES
							begin
								select @INDICA_AUX = count(*)
								from SS_HC_FormatoCodigoId
								where CampoCodigoId = @CampoCodigoID_AUX -- TABLA ESPECIALIDAD
								and IdOpcion=@IdOpcionAux	
								and IndicadorCodigoId=1	--1:INDICA TODOS
								
								if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES GENERALES (debe poseer específicas)
								begin
									select @INDICA_AUX = count(*)
									from SS_HC_FormatoCodigoId
									where CampoCodigoId = @CampoCodigoID_AUX -- TABLA ESPECIALIDAD
									and IdOpcion=@IdOpcionAux	
									and IndicadorCodigoId=2	--1:INDICA ESPECIFICOS
									and ValorId= @IdGrupo  --1:ID DE ESPECIALIDAD ESPECÍFICO
									
									if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES PARA TAL VALOR (NO VALIDO)
									begin
										update @TABLA_OPCIONESAGENTE_VALIDAS 
										set INDICADOR = 'NO VALIDO'					
										where SECUENCIA = @cuenta																	
									end
								end							
							end
							
							--------------------------------
							--(2) COMPANIA
							--------------------------------
							set @CampoCodigoID_AUX = 1 -- 1: INDICA TABLA COMPANIA
							select @INDICA_AUX = count(*)
							from SS_HC_FormatoCodigoId
							where CampoCodigoId = @CampoCodigoID_AUX  --TABLA COMPANIA
							and IdOpcion=@IdOpcionAux
							if(@INDICA_AUX > 0) --POSEE ASIGNACIONES
							begin
								select @INDICA_AUX = count(*)
								from SS_HC_FormatoCodigoId
								where CampoCodigoId = @CampoCodigoID_AUX -- TABLA COMPANIA
								and IdOpcion=@IdOpcionAux	
								and IndicadorCodigoId=1	--1:INDICA TODOS
								
								if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES GENERALES (debe poseer específicas)
								begin
									select @INDICA_AUX = count(*)
									from SS_HC_FormatoCodigoId
									where CampoCodigoId = @CampoCodigoID_AUX -- TABLA COMPANIA
									and IdOpcion=@IdOpcionAux	
									and IndicadorCodigoId=2	--1:INDICA ESPECIFICOS
									and ValorTexto= @Compania  --1:COD DE COMPANIA ESPECÍFICO
									
									if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES PARA TAL VALOR (NO VALIDO)
									begin
										update @TABLA_OPCIONESAGENTE_VALIDAS 
										set INDICADOR = 'NO VALIDO'					
										where SECUENCIA = @cuenta																	
									end
								end							
							end						
							--------------------------------
							--(3) ESTABLECIMIENTO
							--------------------------------
							set @CampoCodigoID_AUX = 2 -- 1: INDICA TABLA ESTABLECIMIENTO
							select @INDICA_AUX = count(*)
							from SS_HC_FormatoCodigoId
							where CampoCodigoId = @CampoCodigoID_AUX  --TABLA ESTABLECIMIENTO
							and IdOpcion=@IdOpcionAux
							if(@INDICA_AUX > 0) --POSEE ASIGNACIONES
							begin
								select @INDICA_AUX = count(*)
								from SS_HC_FormatoCodigoId
								where CampoCodigoId = @CampoCodigoID_AUX -- TABLA ESTABLECIMIENTO
								and IdOpcion=@IdOpcionAux	
								and IndicadorCodigoId=1	--1:INDICA TODOS
								
								if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES GENERALES (debe poseer específicas)
								begin
									select @INDICA_AUX = count(*)
									from SS_HC_FormatoCodigoId
									where CampoCodigoId = @CampoCodigoID_AUX -- TABLA ESTABLECIMIENTO
									and IdOpcion=@IdOpcionAux	
									and IndicadorCodigoId=2	--1:INDICA ESPECIFICOS
									and ValorId= @IdOrganizacion  --:ID DE ESTABLECIMIENTO ESPECÍFICO
									
									if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES PARA TAL VALOR (NO VALIDO)
									begin
										update @TABLA_OPCIONESAGENTE_VALIDAS 
										set INDICADOR = 'NO VALIDO'					
										where SECUENCIA = @cuenta																	
									end
								end							
							end									
							--------------------------------
							--(4) AGENTE
							--------------------------------	
							set @CampoCodigoID_AUX = 8 -- 1: INDICA TABLA AGENTE
							select @INDICA_AUX = count(*)
							from SS_HC_FormatoCodigoId
							where CampoCodigoId = @CampoCodigoID_AUX  --TABLA AGENTE
							and IdOpcion=@IdOpcionAux
							if(@INDICA_AUX > 0) --POSEE ASIGNACIONES
							begin
								select @INDICA_AUX = count(*)
								from SS_HC_FormatoCodigoId
								where CampoCodigoId = @CampoCodigoID_AUX -- TABLA AGENTE
								and IdOpcion=@IdOpcionAux	
								and IndicadorCodigoId=1	--1:INDICA TODOS
								
								if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES GENERALES (debe poseer específicas)
								begin
									select @INDICA_AUX = count(*)
									from SS_HC_FormatoCodigoId
									where CampoCodigoId = @CampoCodigoID_AUX -- TABLA 
									and IdOpcion=@IdOpcionAux	
									and IndicadorCodigoId=2	--1:INDICA ESPECIFICOS
									and ValorId= @IdAgente  --:ID DE AGENTE ESPECÍFICO
									
									if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES PARA TAL VALOR (NO VALIDO)
									begin
										update @TABLA_OPCIONESAGENTE_VALIDAS 
										set INDICADOR = 'NO VALIDO'					
										where SECUENCIA = @cuenta																	
									end
								end							
							end																																				
							--------------------------------
							--(5) UNIDAD DE SERVICIO
							--------------------------------	
							set @CampoCodigoID_AUX = 10 -- 1: INDICA TABLA UNID. SERVICIO
							select @INDICA_AUX = count(*)
							from SS_HC_FormatoCodigoId
							where CampoCodigoId = @CampoCodigoID_AUX  --TABLA 
							and IdOpcion=@IdOpcionAux
							if(@INDICA_AUX > 0) --POSEE ASIGNACIONES
							begin
								select @INDICA_AUX = count(*)
								from SS_HC_FormatoCodigoId
								where CampoCodigoId = @CampoCodigoID_AUX -- TABLA 
								and IdOpcion=@IdOpcionAux	
								and IndicadorCodigoId=1	--1:INDICA TODOS
								
								if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES GENERALES (debe poseer específicas)
								begin
								
									select @INDICA_AUX = count(*)
									from SS_HC_FormatoCodigoId
									where CampoCodigoId = @CampoCodigoID_AUX -- TABLA 
									and IdOpcion=@IdOpcionAux	
									and IndicadorCodigoId=2	--1:INDICA ESPECIFICOS
									and rtrim(ValorTexto)= 
										convert(varchar,@IdOrganizacion)   --:IDs  ESPECÍFICOs(Estable)
										+'|'+
										convert(varchar,@IdObjetoAsociado) --:IDs  ESPECÍFICOs (Unid. Serv)
																													
									if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES PARA TAL VALOR (NO VALIDO)
									begin
										update @TABLA_OPCIONESAGENTE_VALIDAS 
										set INDICADOR = 'NO VALIDO'					
										where SECUENCIA = @cuenta																	
									end
								end							
							end	
						end					
					
					end																		
					set @cuenta= @cuenta+1
					-------------
				end
				/*************************************************/
				/*************************************************/
		
			if (@Nivel=1)
				begin
					Select * from dbo.SS_CHE_VistaSeguridad as seguridad
					where 
					seguridad.TipoOpcion <> 'N'
					and		(seguridad.IdAgente in (
								select IdAgente from @TABLA_OPCIONESAGENTE_VALIDAS as AgtVal
								where AgtVal.IdOpcion = seguridad.IdOpcion
								and INDICADOR = 'VALIDO'
								and TipoOpcion <> 'N'
								and NivelOpcion = 1

							)
					)
					and		(seguridad.NivelOpcion = 1)					
					
				end
			else
				begin

				if (@IndicadorMultiple=999)
				begin
				select * from dbo.SS_CHE_VistaSeguridad as seguridad					
					where	
					 seguridad.TipoOpcion <> 'N'
					and		seguridad.IdAgente in (		
					select IdPerfil from SG_PerfilUsuario where IdUsuario =@IdAgente and Estado=2)						
						and		seguridad.IdOpcionPadre = @IdOpcionPadre and seguridad.EstadoAgente=2
					order by seguridad.OrdenOpcion
				end

				else
				begin
				select * from dbo.SS_CHE_VistaSeguridad as seguridad
					where	
					 seguridad.TipoOpcion <> 'N'				
					and		seguridad.IdAgente in (		
								select IdAgente from @TABLA_OPCIONESAGENTE_VALIDAS as AgtVal
								where AgtVal.IdOpcion = seguridad.IdOpcion
								and INDICADOR = 'VALIDO'
								and TipoOpcion <> 'N'																														
					)						
						and		seguridad.IdOpcionPadre = @IdOpcionPadre and seguridad.EstadoAgente=2
					order by seguridad.OrdenOpcion
				end				
				end
			
		 END
	if(@ACCION = 'DATOSRECURSOS')
		BEGIN
			SELECT  'W4G' as Sistema, dbo.SS_HC_Tabla.NombreTabla  as Nombre, 'HC'  as Modulo, 0  as Orden, 
					SS_HC_FormatoRecursoCampo.NombreCampoRecurso  as NombreModulo, 
					dbo.SS_HC_Tabla.IdFavoritoTabla  as IdOpcion, 
					SS_HC_FormatoCampo.SecuenciaCampo  as IdOpcionPadre, 
					''  as   CodigoOpcion,
					''  as  CadenaRecursividad, 
					SS_HC_Tabla.TipoTabla  as NivelOpcion, 
					SS_HC_Tabla.Condicion  as NombreOpcion, 
					SS_HC_TablaCampo.NombreCampo  as Descripcion, 
					''  as  SubModulo, 0  as  
				  OrdenOpcion, ''  as TipoOpcion, 0  as TipoIcono, 0  as IndicadorPrioridad, 0  as IndicadorObjeto, 0  as IdObjetoAsociado, ''  as 
				  TipoDato,
				   SS_HC_TablaCampo.Descripcion  as ValorTexto, 0.0  as ValorNumerico, getdate()  as  ValorFecha, ''  as  UrlOpcion, ''  as  UsuarioCreacion, 
				   getdate()  as  FechaCreacion, ''  as  UsuarioModificacion, 
				  getdate()  as  FechaModificacion, ''  as  Compania, 0  as  IndicadorCompania, 0  as  idTipoAtencion, ''  as  
				  TipoTrabajador, 0  as  IndicadorFormato, 0  as  IndicadorAsignacion, 0  as  TipoProceso, ''  as  Accion, '' as  Version, 0  as  
				  Estado, 0  as  IdAgente, 0  as  IdGrupo, 0  as  IdOrganizacion, 0  as  TipoAgente, ''  as  CodigoAgente, 0  as  IdEmpleado, 0  as  
				  IndicadorMultiple, ''  as  Clave, getdate()  as  FechaInicio, getdate()  as  FechaFin, getdate()  as  FechaExpiracion, ''  as  NombreAgente, 0  as  ExpiraClave, 
				  dbo.SS_HC_Tabla.Descripcion   as DescripcionAgente, 0  as  EstadoAgente, 0  as  IdGrupoTransaccion, 0  as  TipoTransaccion, 0  as  IdOpcionDefecto,''  as  
				  Plataforma, getdate()  as  ValorFechaAgOpcion, 0.0  as  ValorNumericoAgOpcion, ''  as  ValorTextAgOpcion, 0  as  IndicadorAcceso, 0  as  
				  IndicadorHabilitado, 0  as  IndicadorObligatorio, 0  as  IndicadorVisible, 0  as  IndicarPrioridadAgOpcion, 0  as  
				  IndicadorNuevo, 0  as  IndicadorModificar, 0  as  IndicadorEliminar,0 as IndicadorImprimir, 0  as  IndicadorIngreso, 0  as  EstadoAgenteOpcion, 
				  dbo.SS_HC_Formato.IdFormato  as  IdFormato, 0  as IdFormatoPadre, SS_HC_Formato.CodigoFormato  as CodigoFormato, ''  as  CodigoFormatoPadre, '' as  CadenaRecursividadFormato, 
				  0  as  Nivel, ''  as  DescripcionFormato, '' as  DescripcionExtranjera, 0  as TipoFormato, ''  as  VersionFormatoFijo, 0  as 
				  IdFormatoDinamico, 0  as EstadoFormato 
	 		FROM        SS_HC_FormatoRecursoCampo 
			INNER JOIN SS_HC_Formato 		ON  SS_HC_FormatoRecursoCampo.IdFormato=SS_HC_Formato.IdFormato 
			INNER JOIN SS_HC_Tabla 		ON SS_HC_Tabla.IdFavoritoTabla = SS_HC_FormatoRecursoCampo.IdFavoritoTabla 
			INNER JOIN SS_HC_FormatoCampo  ON SS_HC_Formato.IdFormato = SS_HC_FormatoCampo.IdFormato AND    SS_HC_FormatoRecursoCampo.SecuenciaCampo = SS_HC_FormatoCampo.SecuenciaCampo  
			INNER JOIN SS_HC_TablaCampo 	ON    SS_HC_FormatoCampo.IdCampo = SS_HC_TablaCampo.IdCampo
			where	SS_HC_Tabla.TipoTabla = 1
			and		 SS_HC_FormatoRecursoCampo.Estado = 2
			and		 CodigoFormato = @CodigoFormato
			
		END		 
	if(@ACCION = 'DATOSFORMULARIO')
		BEGIN
			/**VERIFICAR ASIGNACION DE FORMATO ALTERNATIVO*/
					--------------------------------
					--(1) FORMATO
					--------------------------------
					set @CampoCodigoID_AUX = 9 -- 4: INDICA TABLA FORMATO
					select @INDICA_AUX = count(*)
					from SS_HC_FormatoCodigoId
					where CampoCodigoId = @CampoCodigoID_AUX  --TABLA FORMATO
					and IdOpcion=@IdOpcion
					
					if(@INDICA_AUX > 0) --POSEE ASIGNACIONES
							begin
								select @INDICA_AUX = count(*)
								from SS_HC_FormatoCodigoId
								where CampoCodigoId = @CampoCodigoID_AUX -- TABLA FORMATO
								and IdOpcion=@IdOpcion	
								and IndicadorCodigoId=1	--1:INDICA TODOS
								
								if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES GENERALES (debe poseer específicas)
								begin
								
									select top 1 @FormatoID_AUX= ValorId  --SOLO UNO
									from SS_HC_FormatoCodigoId
									where CampoCodigoId = @CampoCodigoID_AUX -- TABLA FORMATO
									and IdOpcion=@IdOpcion	
									and IndicadorCodigoId=2	--1:INDICA ESPECIFICOS
																		
									if(@FormatoID_AUX > 0) -- POSEE FORMATO ASIGNADO (OBTENER CODIGO E ID FORM DINAMICO)
									begin
										select @FormatoCodigo_AUX = CodigoFormato,
											@FormatoDinamicoID_AUX = IdFormatoDinamico
										 from SS_HC_Formato
										where IdFormato = @FormatoID_AUX								
									end
								end							
					end
			---------------------			
		
		  Select Sistema, Nombre, Modulo, Orden, NombreModulo, IdOpcion, IdOpcionPadre, 
			  CodigoOpcion, CadenaRecursividad, NivelOpcion, NombreOpcion, Descripcion, SubModulo, 
			  OrdenOpcion, TipoOpcion, TipoIcono, IndicadorPrioridad, IndicadorObjeto, IdObjetoAsociado, 
			  TipoDato, ValorTexto, ValorNumerico, ValorFecha, UrlOpcion, UsuarioCreacion, FechaCreacion, 
			  UsuarioModificacion, FechaModificacion, Compania, IndicadorCompania, idTipoAtencion, 
			  TipoTrabajador, IndicadorFormato, IndicadorAsignacion, TipoProceso, Accion, Version, 
			  Estado, IdAgente, IdGrupo, IdOrganizacion, TipoAgente, CodigoAgente, IdEmpleado, 
			  IndicadorMultiple, Clave, FechaInicio, FechaFin, FechaExpiracion, NombreAgente, ExpiraClave, 
			  DescripcionAgente, EstadoAgente, IdGrupoTransaccion, TipoTransaccion, IdOpcionDefecto, 
			  Plataforma, ValorFechaAgOpcion, ValorNumericoAgOpcion, ValorTextAgOpcion, IndicadorAcceso, 
			  IndicadorHabilitado, IndicadorObligatorio, IndicadorVisible, IndicarPrioridadAgOpcion, 
			  IndicadorNuevo, IndicadorModificar, IndicadorEliminar,IndicadorImprimir ,IndicadorIngreso, EstadoAgenteOpcion, 
			  (case when @FormatoID_AUX>0 then @FormatoID_AUX else IdFormato end) as IdFormato,     
			  IdFormatoPadre, 
			  (case when @FormatoID_AUX>0 then @FormatoCodigo_AUX else CodigoFormato end) as CodigoFormato,   
			  CodigoFormatoPadre, CadenaRecursividadFormato, 
			  Nivel, DescripcionFormato, DescripcionExtranjera, TipoFormato, VersionFormatoFijo, 
			  (case when @FormatoID_AUX>0 then @FormatoDinamicoID_AUX else IdFormatoDinamico end) as IdFormatoDinamico, 
			  EstadoFormato 
			  from dbo.SS_CHE_VistaSeguridad 
			where	
			IdAgente = -2  --OBS:  -2: ADMIN GENERAL
			and		IdOpcion = 	@IdOpcion							
			
		 END		
		 
	if(@ACCION = 'LISTAROPCIONESCAGENTE')
		BEGIN												

			if(@IdOpcionPadre is null and @IdOpcion is not null)
			begin			
				select @IdOpcionPadre = IdOpcionPadre from SG_Opcion where IdOpcion = @IdOpcion
			end			
			
			if (@NivelOpcion=1)
			begin
					select 
						seguridad.Sistema,seguridad.Nombre,seguridad.Modulo,seguridad.Orden,seguridad.NombreModulo,seguridad.IdOpcion,seguridad.IdOpcionPadre,seguridad.CodigoOpcion,seguridad.CadenaRecursividad
						  ,seguridad.NivelOpcion,seguridad.NombreOpcion,seguridad.Descripcion,seguridad.SubModulo,seguridad.OrdenOpcion,seguridad.TipoOpcion
						  ,seguridad.TipoIcono,seguridad.IndicadorPrioridad,seguridad.IndicadorObjeto,seguridad.IdObjetoAsociado,seguridad.TipoDato
						  ,seguridad.ValorTexto,seguridad.ValorNumerico,seguridad.ValorFecha,seguridad.UrlOpcion,seguridad.UsuarioCreacion
						  ,seguridad.FechaCreacion,seguridad.UsuarioModificacion,seguridad.FechaModificacion,seguridad.Compania,seguridad.IndicadorCompania
						  ,seguridad.idTipoAtencion,seguridad.TipoTrabajador,seguridad.IndicadorFormato
						  ,2 as IndicadorAsignacion --OBS: ASIGNADO
						  ,seguridad.TipoProceso,
						  seguridad.Accion,
						  seguridad.Version,seguridad.Estado
							,seguridad.IdAgente,seguridad.IdGrupo,seguridad.IdOrganizacion,seguridad.TipoAgente,seguridad.CodigoAgente
						  ,seguridad.IdEmpleado,seguridad.IndicadorMultiple,seguridad.Clave,seguridad.FechaInicio,seguridad.FechaFin,seguridad.FechaExpiracion,seguridad.NombreAgente,
						  seguridad.ExpiraClave,seguridad.DescripcionAgente,seguridad.EstadoAgente,seguridad.IdGrupoTransaccion,seguridad.TipoTransaccion,seguridad.IdOpcionDefecto,seguridad.Plataforma
						  ,seguridad.ValorFechaAgOpcion,seguridad.ValorNumericoAgOpcion,seguridad.ValorTextAgOpcion
						  ,seguridad.IndicadorAcceso,seguridad.IndicadorHabilitado,seguridad.IndicadorObligatorio,seguridad.IndicadorVisible
						  ,seguridad.IndicarPrioridadAgOpcion,seguridad.IndicadorNuevo,seguridad.IndicadorModificar
						  ,seguridad.IndicadorEliminar,seguridad.IndicadorImprimir,seguridad.IndicadorIngreso,seguridad.EstadoAgenteOpcion,seguridad.IdFormato
						  ,seguridad.IdFormatoPadre,seguridad.CodigoFormato,seguridad.CodigoFormatoPadre,seguridad.CadenaRecursividadFormato
						  ,seguridad.Nivel,seguridad.DescripcionFormato,seguridad.DescripcionExtranjera,seguridad.TipoFormato
						  ,seguridad.VersionFormatoFijo,seguridad.IdFormatoDinamico,seguridad.EstadoFormato															
					from 
					(
						select vistaSeg.* 	from dbo.SS_CHE_VistaSeguridad vistaSeg	 where	
						vistaSeg.IdAgente in (
							select IdAgente from @TABLA_OPCIONESAGENTE_VALIDAS as AgtVal
							where AgtVal.IdOpcion = vistaSeg.IdOpcion
							and INDICADOR = 'VALIDO'
						)						
						and		NivelOpcion = 1					
					) as seguridad																				
					union
					select 
						seguridad.Sistema,seguridad.Nombre,seguridad.Modulo,seguridad.Orden,seguridad.NombreModulo,seguridad.IdOpcion,seguridad.IdOpcionPadre,seguridad.CodigoOpcion,seguridad.CadenaRecursividad
						  ,seguridad.NivelOpcion,seguridad.NombreOpcion,seguridad.Descripcion,seguridad.SubModulo,seguridad.OrdenOpcion,seguridad.TipoOpcion
						  ,seguridad.TipoIcono,seguridad.IndicadorPrioridad,seguridad.IndicadorObjeto,seguridad.IdObjetoAsociado,seguridad.TipoDato
						  ,seguridad.ValorTexto,seguridad.ValorNumerico,seguridad.ValorFecha,seguridad.UrlOpcion,seguridad.UsuarioCreacion
						  ,seguridad.FechaCreacion,seguridad.UsuarioModificacion,seguridad.FechaModificacion,seguridad.Compania,seguridad.IndicadorCompania
						  ,seguridad.idTipoAtencion,seguridad.TipoTrabajador,seguridad.IndicadorFormato
						  ,1 as IndicadorAsignacion --OBS: NO ASIGNADO
						  ,seguridad.TipoProceso,
						  seguridad.Accion,
						  seguridad.Version,seguridad.Estado
							,seguridad.IdAgente,seguridad.IdGrupo,seguridad.IdOrganizacion,
							0 as TipoAgente,
							seguridad.CodigoAgente
						  ,seguridad.IdEmpleado,seguridad.IndicadorMultiple,seguridad.Clave,seguridad.FechaInicio,seguridad.FechaFin,seguridad.FechaExpiracion,
						  seguridad.NombreAgente,
						  seguridad.ExpiraClave,seguridad.DescripcionAgente,seguridad.EstadoAgente,seguridad.IdGrupoTransaccion,seguridad.TipoTransaccion,seguridad.IdOpcionDefecto,seguridad.Plataforma
						  ,seguridad.ValorFechaAgOpcion,seguridad.ValorNumericoAgOpcion,seguridad.ValorTextAgOpcion
						  , 1 as IndicadorAcceso,
						  1 as IndicadorHabilitado,1 as IndicadorObligatorio,1 as IndicadorVisible
						  ,1 as IndicarPrioridadAgOpcion,
						  1 as IndicadorNuevo,1 as IndicadorModificar
						  ,1 as IndicadorEliminar,1 as IndicadorImprimir,1 as IndicadorIngreso,
						  seguridad.EstadoAgenteOpcion,seguridad.IdFormato
						  ,seguridad.IdFormatoPadre,seguridad.CodigoFormato,seguridad.CodigoFormatoPadre,seguridad.CadenaRecursividadFormato
						  ,seguridad.Nivel,seguridad.DescripcionFormato,seguridad.DescripcionExtranjera,seguridad.TipoFormato
						  ,seguridad.VersionFormatoFijo,seguridad.IdFormatoDinamico,seguridad.EstadoFormato					
					from SS_CHE_VistaSeguridad as seguridad		
					where					
					IdAgente = -2  --OBS: hardcode
					and		NivelOpcion = 1	
					and (seguridad.IdOpcion not 
					 in (select idOPcion from SG_AgenteOpcion
						where --IdAgente = @IdAgente
							-----
							seguridad.IdAgente in (		
								select IdAgente from @TABLA_OPCIONESAGENTE_VALIDAS as AgtVal
								where AgtVal.IdOpcion = seguridad.IdOpcion	
								and INDICADOR = 'VALIDO'	
							)						
					 ))					
				end
				
			else
				begin
				Select 
						seguridad.Sistema
						  ,seguridad.Nombre
						  ,seguridad.Modulo
						  ,seguridad.Orden
						  ,seguridad.NombreModulo
						  ,seguridad.IdOpcion
						  ,seguridad.IdOpcionPadre
						  ,seguridad.CodigoOpcion
						  ,seguridad.CadenaRecursividad
						  ,seguridad.NivelOpcion
						  ,seguridad.NombreOpcion
						  ,seguridad.Descripcion
						  ,seguridad.SubModulo
						  ,seguridad.OrdenOpcion
						  ,seguridad.TipoOpcion
						  ,seguridad.TipoIcono
						  ,seguridad.IndicadorPrioridad
						  ,seguridad.IndicadorObjeto
						  ,seguridad.IdObjetoAsociado
						  ,seguridad.TipoDato
						  ,seguridad.ValorTexto
						  ,seguridad.ValorNumerico
						  ,seguridad.ValorFecha
						  ,seguridad.UrlOpcion
						  ,seguridad.UsuarioCreacion
						  ,seguridad.FechaCreacion
						  ,seguridad.UsuarioModificacion
						  ,seguridad.FechaModificacion
						  ,seguridad.Compania
						  ,seguridad.IndicadorCompania
						  ,seguridad.idTipoAtencion
						  ,seguridad.TipoTrabajador
						  ,seguridad.IndicadorFormato
						  ,2 as IndicadorAsignacion --OBS: ASIGNADO
						  ,seguridad.TipoProceso
						  ,seguridad.Accion
						  ,seguridad.Version
						  ,seguridad.Estado
						  ,seguridad.IdAgente
						  ,seguridad.IdGrupo
						  ,seguridad.IdOrganizacion
						  ,seguridad.TipoAgente
						  ,seguridad.CodigoAgente
						  ,seguridad.IdEmpleado
						  ,seguridad.IndicadorMultiple
						  ,seguridad.Clave
						  ,seguridad.FechaInicio
						  ,seguridad.FechaFin
						  ,seguridad.FechaExpiracion
						  ,seguridad.NombreAgente
						  ,seguridad.ExpiraClave
						  ,seguridad.DescripcionAgente
						  ,seguridad.EstadoAgente
						  ,seguridad.IdGrupoTransaccion
						  ,seguridad.TipoTransaccion
						  ,seguridad.IdOpcionDefecto
						  ,seguridad.Plataforma
						  ,seguridad.ValorFechaAgOpcion
						  ,seguridad.ValorNumericoAgOpcion
						  ,seguridad.ValorTextAgOpcion
						  ,seguridad.IndicadorAcceso
						  ,seguridad.IndicadorHabilitado
						  ,seguridad.IndicadorObligatorio
						  ,seguridad.IndicadorVisible
						  ,seguridad.IndicarPrioridadAgOpcion
						  ,seguridad.IndicadorNuevo
						  ,seguridad.IndicadorModificar
						  ,seguridad.IndicadorEliminar
						  ,seguridad.IndicadorImprimir
						  ,seguridad.IndicadorIngreso
						  ,seguridad.EstadoAgenteOpcion
						  ,seguridad.IdFormato
						  ,seguridad.IdFormatoPadre
						  ,seguridad.CodigoFormato
						  ,seguridad.CodigoFormatoPadre
						  ,seguridad.CadenaRecursividadFormato
						  ,seguridad.Nivel
						  ,seguridad.DescripcionFormato
						  ,seguridad.DescripcionExtranjera
						  ,seguridad.TipoFormato
						  ,seguridad.VersionFormatoFijo
						  ,seguridad.IdFormatoDinamico
						  ,seguridad.EstadoFormato
					
					from dbo.SS_CHE_VistaSeguridad as seguridad									
					where				
					IdOpcionPadre = @IdOpcionPadre
					-----
					and		seguridad.IdAgente in (		
								select IdAgente from @TABLA_OPCIONESAGENTE_VALIDAS as AgtVal
								where AgtVal.IdOpcion = seguridad.IdOpcion																	
								and INDICADOR = 'VALIDO'
							)
					and (@IdOpcion is null or (@IdOpcion=IdOpcion) or (@IdOpcion=0))
					union
					select 
						seguridad.Sistema,seguridad.Nombre,seguridad.Modulo,seguridad.Orden,seguridad.NombreModulo,seguridad.IdOpcion,seguridad.IdOpcionPadre,seguridad.CodigoOpcion,seguridad.CadenaRecursividad
						  ,seguridad.NivelOpcion,seguridad.NombreOpcion,seguridad.Descripcion,seguridad.SubModulo,seguridad.OrdenOpcion,seguridad.TipoOpcion
						  ,seguridad.TipoIcono,seguridad.IndicadorPrioridad,seguridad.IndicadorObjeto,seguridad.IdObjetoAsociado,seguridad.TipoDato
						  ,seguridad.ValorTexto,seguridad.ValorNumerico,seguridad.ValorFecha,seguridad.UrlOpcion,seguridad.UsuarioCreacion
						  ,seguridad.FechaCreacion,seguridad.UsuarioModificacion,seguridad.FechaModificacion,seguridad.Compania,seguridad.IndicadorCompania
						  ,seguridad.idTipoAtencion,seguridad.TipoTrabajador,seguridad.IndicadorFormato
						  ,1 as IndicadorAsignacion --OBS: NO ASIGNADO
						  ,seguridad.TipoProceso,seguridad.Accion,seguridad.Version,seguridad.Estado
							,seguridad.IdAgente,seguridad.IdGrupo,seguridad.IdOrganizacion,
							0 as TipoAgente,
							seguridad.CodigoAgente
						  ,seguridad.IdEmpleado,seguridad.IndicadorMultiple,seguridad.Clave,seguridad.FechaInicio,seguridad.FechaFin,seguridad.FechaExpiracion,
						  seguridad.NombreAgente,
						  seguridad.ExpiraClave,seguridad.DescripcionAgente,seguridad.EstadoAgente,seguridad.IdGrupoTransaccion,seguridad.TipoTransaccion,seguridad.IdOpcionDefecto,seguridad.Plataforma
						  ,seguridad.ValorFechaAgOpcion,seguridad.ValorNumericoAgOpcion,seguridad.ValorTextAgOpcion
						  , 1 as IndicadorAcceso,
						  1 as IndicadorHabilitado,1 as IndicadorObligatorio,1 as IndicadorVisible
						  ,1 as IndicarPrioridadAgOpcion,
						  1 as IndicadorNuevo,1 as IndicadorModificar
						  ,1 as IndicadorEliminar,
						  1 as IndicadorImprimir,
						  1 as IndicadorIngreso,
						  seguridad.EstadoAgenteOpcion,seguridad.IdFormato
						  ,seguridad.IdFormatoPadre,seguridad.CodigoFormato,seguridad.CodigoFormatoPadre,seguridad.CadenaRecursividadFormato
						  ,seguridad.Nivel,seguridad.DescripcionFormato,seguridad.DescripcionExtranjera,seguridad.TipoFormato
						  ,seguridad.VersionFormatoFijo,seguridad.IdFormatoDinamico,seguridad.EstadoFormato					
					from SS_CHE_VistaSeguridad as seguridad		
					where					
					IdAgente = -2  --OBS: hardcode: ADMINSYS
					and (	IdOpcionPadre = @IdOpcionPadre)
					and (seguridad.IdOpcion not 
					 in (select idOPcion from SG_AgenteOpcion
						where --IdAgente = @IdAgente
							-----
							seguridad.IdAgente in (		
								select IdAgente from @TABLA_OPCIONESAGENTE_VALIDAS as AgtVal
								where AgtVal.IdOpcion = seguridad.IdOpcion
								and INDICADOR = 'VALIDO'
							)
					 ))
					 ---
					 and (@IdOpcion is null or (@IdOpcion=IdOpcion) or (@IdOpcion=0))
					 and (@NivelOpcion >0 or @NivelOpcion is null)
					-----		
				end

		 END
		 ELSE
		if(@ACCION = 'LISTAROPCIONESCAGENTEOBLIGATORIO')
		BEGIN	
			
			if(@IdOpcionPadre is null and @IdOpcion is not null)
			begin			
				select @IdOpcionPadre = IdOpcionPadre from SG_Opcion where IdOpcion = @IdOpcion
			end			
			
			if (@NivelOpcion=1)
			begin
					select 
						seguridad.Sistema,seguridad.Nombre,seguridad.Modulo,seguridad.Orden,seguridad.NombreModulo,seguridad.IdOpcion,seguridad.IdOpcionPadre,seguridad.CodigoOpcion,seguridad.CadenaRecursividad
						  ,seguridad.NivelOpcion,seguridad.NombreOpcion,seguridad.Descripcion,seguridad.SubModulo,seguridad.OrdenOpcion,seguridad.TipoOpcion
						  ,seguridad.TipoIcono,seguridad.IndicadorPrioridad,seguridad.IndicadorObjeto,seguridad.IdObjetoAsociado,seguridad.TipoDato
						  ,seguridad.ValorTexto,seguridad.ValorNumerico,seguridad.ValorFecha,seguridad.UrlOpcion,seguridad.UsuarioCreacion
						  ,seguridad.FechaCreacion,seguridad.UsuarioModificacion,seguridad.FechaModificacion,seguridad.Compania,seguridad.IndicadorCompania
						  ,seguridad.idTipoAtencion,seguridad.TipoTrabajador,seguridad.IndicadorFormato
						  ,2 as IndicadorAsignacion --OBS: ASIGNADO
						  ,seguridad.TipoProceso,
						  seguridad.Accion,
						  seguridad.Version,seguridad.Estado
							,seguridad.IdAgente,seguridad.IdGrupo,seguridad.IdOrganizacion,seguridad.TipoAgente,seguridad.CodigoAgente
						  ,seguridad.IdEmpleado,seguridad.IndicadorMultiple,seguridad.Clave,seguridad.FechaInicio,seguridad.FechaFin,seguridad.FechaExpiracion,seguridad.NombreAgente,
						  seguridad.ExpiraClave,seguridad.DescripcionAgente,seguridad.EstadoAgente,seguridad.IdGrupoTransaccion,seguridad.TipoTransaccion,seguridad.IdOpcionDefecto,seguridad.Plataforma
						  ,seguridad.ValorFechaAgOpcion,seguridad.ValorNumericoAgOpcion,seguridad.ValorTextAgOpcion
						  ,seguridad.IndicadorAcceso,seguridad.IndicadorHabilitado,seguridad.IndicadorObligatorio,seguridad.IndicadorVisible
						  ,seguridad.IndicarPrioridadAgOpcion,seguridad.IndicadorNuevo,seguridad.IndicadorModificar
						  ,seguridad.IndicadorEliminar,seguridad.IndicadorImprimir,seguridad.IndicadorIngreso,seguridad.EstadoAgenteOpcion,seguridad.IdFormato
						  ,seguridad.IdFormatoPadre,seguridad.CodigoFormato,seguridad.CodigoFormatoPadre,seguridad.CadenaRecursividadFormato
						  ,seguridad.Nivel,seguridad.DescripcionFormato,seguridad.DescripcionExtranjera,seguridad.TipoFormato
						  ,seguridad.VersionFormatoFijo,seguridad.IdFormatoDinamico,seguridad.EstadoFormato															
					from 
					(
						select vistaSeg.* 	from dbo.SS_CHE_VistaSeguridad vistaSeg						
						where	
						IndicadorObligatorio=2 AND
						vistaSeg.IdAgente in (
							select IdAgente from @TABLA_OPCIONESAGENTE_VALIDAS as AgtVal
							where AgtVal.IdOpcion = vistaSeg.IdOpcion
							and INDICADOR = 'VALIDO'
						)						
						and		NivelOpcion = 1					
					) as seguridad																				
					union
					select 
						seguridad.Sistema,seguridad.Nombre,seguridad.Modulo,seguridad.Orden,seguridad.NombreModulo,seguridad.IdOpcion,seguridad.IdOpcionPadre,seguridad.CodigoOpcion,seguridad.CadenaRecursividad
						  ,seguridad.NivelOpcion,seguridad.NombreOpcion,seguridad.Descripcion,seguridad.SubModulo,seguridad.OrdenOpcion,seguridad.TipoOpcion
						  ,seguridad.TipoIcono,seguridad.IndicadorPrioridad,seguridad.IndicadorObjeto,seguridad.IdObjetoAsociado,seguridad.TipoDato
						  ,seguridad.ValorTexto,seguridad.ValorNumerico,seguridad.ValorFecha,seguridad.UrlOpcion,seguridad.UsuarioCreacion
						  ,seguridad.FechaCreacion,seguridad.UsuarioModificacion,seguridad.FechaModificacion,seguridad.Compania,seguridad.IndicadorCompania
						  ,seguridad.idTipoAtencion,seguridad.TipoTrabajador,seguridad.IndicadorFormato
						  ,1 as IndicadorAsignacion --OBS: NO ASIGNADO
						  ,seguridad.TipoProceso,
						  seguridad.Accion,
						  seguridad.Version,seguridad.Estado
							,seguridad.IdAgente,seguridad.IdGrupo,seguridad.IdOrganizacion,
							0 as TipoAgente,
							seguridad.CodigoAgente
						  ,seguridad.IdEmpleado,seguridad.IndicadorMultiple,seguridad.Clave,seguridad.FechaInicio,seguridad.FechaFin,seguridad.FechaExpiracion,
						  seguridad.NombreAgente,
						  seguridad.ExpiraClave,seguridad.DescripcionAgente,seguridad.EstadoAgente,seguridad.IdGrupoTransaccion,seguridad.TipoTransaccion,seguridad.IdOpcionDefecto,seguridad.Plataforma
						  ,seguridad.ValorFechaAgOpcion,seguridad.ValorNumericoAgOpcion,seguridad.ValorTextAgOpcion
						  , 1 as IndicadorAcceso,
						  1 as IndicadorHabilitado,1 as IndicadorObligatorio,1 as IndicadorVisible
						  ,1 as IndicarPrioridadAgOpcion,
						  1 as IndicadorNuevo,1 as IndicadorModificar
						  ,1 as IndicadorEliminar,1 as IndicadorImprimir,1 as IndicadorIngreso,
						  seguridad.EstadoAgenteOpcion,seguridad.IdFormato
						  ,seguridad.IdFormatoPadre,seguridad.CodigoFormato,seguridad.CodigoFormatoPadre,seguridad.CadenaRecursividadFormato
						  ,seguridad.Nivel,seguridad.DescripcionFormato,seguridad.DescripcionExtranjera,seguridad.TipoFormato
						  ,seguridad.VersionFormatoFijo,seguridad.IdFormatoDinamico,seguridad.EstadoFormato					
					from SS_CHE_VistaSeguridad as seguridad		
					where					
					IdAgente = -2  --OBS: hardcode 
					and IndicadorObligatorio=2 
					and		NivelOpcion = 1	
					and (seguridad.IdOpcion not 
					 in (select idOPcion from SG_AgenteOpcion
						where --IdAgente = @IdAgente
							-----
							seguridad.IdAgente in (		
								select IdAgente from @TABLA_OPCIONESAGENTE_VALIDAS as AgtVal
								where AgtVal.IdOpcion = seguridad.IdOpcion	
								and INDICADOR = 'VALIDO'																

							)						
					 ))					
				end
				
			else
				begin
				Select 
						seguridad.Sistema
						  ,seguridad.Nombre
						  ,seguridad.Modulo
						  ,seguridad.Orden
						  ,seguridad.NombreModulo
						  ,seguridad.IdOpcion
						  ,seguridad.IdOpcionPadre
						  ,seguridad.CodigoOpcion
						  ,seguridad.CadenaRecursividad
						  ,seguridad.NivelOpcion
						  ,seguridad.NombreOpcion
						  ,seguridad.Descripcion
						  ,seguridad.SubModulo
						  ,seguridad.OrdenOpcion
						  ,seguridad.TipoOpcion
						  ,seguridad.TipoIcono
						  ,seguridad.IndicadorPrioridad
						  ,seguridad.IndicadorObjeto
						  ,seguridad.IdObjetoAsociado
						  ,seguridad.TipoDato
						  ,seguridad.ValorTexto
						  ,seguridad.ValorNumerico
						  ,seguridad.ValorFecha
						  ,seguridad.UrlOpcion
						  ,seguridad.UsuarioCreacion
						  ,seguridad.FechaCreacion
						  ,seguridad.UsuarioModificacion
						  ,seguridad.FechaModificacion
						  ,seguridad.Compania
						  ,seguridad.IndicadorCompania
						  ,seguridad.idTipoAtencion
						  ,seguridad.TipoTrabajador
						  ,seguridad.IndicadorFormato
						  ,2 as IndicadorAsignacion --OBS: ASIGNADO
						  ,seguridad.TipoProceso
						  ,seguridad.Accion
						  ,seguridad.Version
						  ,seguridad.Estado
						  ,seguridad.IdAgente
						  ,seguridad.IdGrupo
						  ,seguridad.IdOrganizacion
						  ,seguridad.TipoAgente
						  ,seguridad.CodigoAgente
						  ,seguridad.IdEmpleado
						  ,seguridad.IndicadorMultiple
						  ,seguridad.Clave
						  ,seguridad.FechaInicio
						  ,seguridad.FechaFin
						  ,seguridad.FechaExpiracion
						  ,seguridad.NombreAgente
						  ,seguridad.ExpiraClave
						  ,seguridad.DescripcionAgente
						  ,seguridad.EstadoAgente
						  ,seguridad.IdGrupoTransaccion
						  ,seguridad.TipoTransaccion
						  ,seguridad.IdOpcionDefecto
						  ,seguridad.Plataforma
						  ,seguridad.ValorFechaAgOpcion
						  ,seguridad.ValorNumericoAgOpcion
						  ,seguridad.ValorTextAgOpcion
						  ,seguridad.IndicadorAcceso
						  ,seguridad.IndicadorHabilitado
						  ,seguridad.IndicadorObligatorio
						  ,seguridad.IndicadorVisible
						  ,seguridad.IndicarPrioridadAgOpcion
						  ,seguridad.IndicadorNuevo
						  ,seguridad.IndicadorModificar
						  ,seguridad.IndicadorEliminar
						  ,seguridad.IndicadorImprimir
						  ,seguridad.IndicadorIngreso
						  ,seguridad.EstadoAgenteOpcion
						  ,seguridad.IdFormato
						  ,seguridad.IdFormatoPadre
						  ,seguridad.CodigoFormato
						  ,seguridad.CodigoFormatoPadre
						  ,seguridad.CadenaRecursividadFormato
						  ,seguridad.Nivel
						  ,seguridad.DescripcionFormato
						  ,seguridad.DescripcionExtranjera
						  ,seguridad.TipoFormato
						  ,seguridad.VersionFormatoFijo
						  ,seguridad.IdFormatoDinamico
						  ,seguridad.EstadoFormato
					
					from dbo.SS_CHE_VistaSeguridad as seguridad									
					where					
					IndicadorObligatorio=2 AND				
					Modulo = @Modulo
					-----
					and		seguridad.IdAgente in (		
								select IdAgente from @TABLA_OPCIONESAGENTE_VALIDAS as AgtVal
								where AgtVal.IdOpcion = seguridad.IdOpcion																	
								and INDICADOR = 'VALIDO'
	
							)
					and (@IdOpcion is null or (@IdOpcion=IdOpcion) or (@IdOpcion=0))
					union
					select 
						seguridad.Sistema,seguridad.Nombre,seguridad.Modulo,seguridad.Orden,seguridad.NombreModulo,seguridad.IdOpcion,seguridad.IdOpcionPadre,seguridad.CodigoOpcion,seguridad.CadenaRecursividad
						  ,seguridad.NivelOpcion,seguridad.NombreOpcion,seguridad.Descripcion,seguridad.SubModulo,seguridad.OrdenOpcion,seguridad.TipoOpcion
						  ,seguridad.TipoIcono,seguridad.IndicadorPrioridad,seguridad.IndicadorObjeto,seguridad.IdObjetoAsociado,seguridad.TipoDato
						  ,seguridad.ValorTexto,seguridad.ValorNumerico,seguridad.ValorFecha,seguridad.UrlOpcion,seguridad.UsuarioCreacion
						  ,seguridad.FechaCreacion,seguridad.UsuarioModificacion,seguridad.FechaModificacion,seguridad.Compania,seguridad.IndicadorCompania
						  ,seguridad.idTipoAtencion,seguridad.TipoTrabajador,seguridad.IndicadorFormato
						  ,1 as IndicadorAsignacion --OBS: NO ASIGNADO
						  ,seguridad.TipoProceso,seguridad.Accion,seguridad.Version,seguridad.Estado
							,seguridad.IdAgente,seguridad.IdGrupo,seguridad.IdOrganizacion,
							0 as TipoAgente,
							seguridad.CodigoAgente
						  ,seguridad.IdEmpleado,seguridad.IndicadorMultiple,seguridad.Clave,seguridad.FechaInicio,seguridad.FechaFin,seguridad.FechaExpiracion,
						  seguridad.NombreAgente,
						  seguridad.ExpiraClave,seguridad.DescripcionAgente,seguridad.EstadoAgente,seguridad.IdGrupoTransaccion,seguridad.TipoTransaccion,seguridad.IdOpcionDefecto,seguridad.Plataforma
						  ,seguridad.ValorFechaAgOpcion,seguridad.ValorNumericoAgOpcion,seguridad.ValorTextAgOpcion
						  , 1 as IndicadorAcceso,
						  1 as IndicadorHabilitado,1 as IndicadorObligatorio,1 as IndicadorVisible
						  ,1 as IndicarPrioridadAgOpcion,
						  1 as IndicadorNuevo,1 as IndicadorModificar
						  ,1 as IndicadorEliminar,
						  1 as IndicadorImprimir,
						  1 as IndicadorIngreso,
						  seguridad.EstadoAgenteOpcion,seguridad.IdFormato
						  ,seguridad.IdFormatoPadre,seguridad.CodigoFormato,seguridad.CodigoFormatoPadre,seguridad.CadenaRecursividadFormato
						  ,seguridad.Nivel,seguridad.DescripcionFormato,seguridad.DescripcionExtranjera,seguridad.TipoFormato
						  ,seguridad.VersionFormatoFijo,seguridad.IdFormatoDinamico,seguridad.EstadoFormato					
					from SS_CHE_VistaSeguridad as seguridad		
					where					
					IdAgente = -2  --OBS: hardcode: ADMINSYS
					and IndicadorObligatorio=2 
					and (	Modulo = @Modulo)
					and (seguridad.IdOpcion not 
					 in (select idOPcion from SG_AgenteOpcion
						where --IdAgente = @IdAgente
							-----
							seguridad.IdAgente in (		
								select IdAgente from @TABLA_OPCIONESAGENTE_VALIDAS as AgtVal
								where AgtVal.IdOpcion = seguridad.IdOpcion
								and INDICADOR = 'VALIDO'
							)
					 ))
					 ---
					 and (@IdOpcion is null or (@IdOpcion=IdOpcion) or (@IdOpcion=0))
					 and (@NivelOpcion >0 or @NivelOpcion is null)
					-----	
				end

		 END

	ELSE
		 
	 if(@ACCION = 'LISTAROPCIONESCAG')
		BEGIN	
			
	         if (@NivelOpcion=1)
			begin
			    select 					seguridad.Sistema,seguridad.Nombre,seguridad.Modulo,seguridad.Orden,seguridad.NombreModulo,seguridad.IdOpcion,seguridad.IdOpcionPadre,seguridad.CodigoOpcion,seguridad.CadenaRecursividad
						  ,seguridad.NivelOpcion,seguridad.NombreOpcion,seguridad.Descripcion,seguridad.SubModulo,seguridad.OrdenOpcion,seguridad.TipoOpcion
						  ,seguridad.TipoIcono,seguridad.IndicadorPrioridad,seguridad.IndicadorObjeto,seguridad.IdObjetoAsociado,seguridad.TipoDato
						  ,seguridad.ValorTexto,seguridad.ValorNumerico,seguridad.ValorFecha,seguridad.UrlOpcion,seguridad.UsuarioCreacion
						  ,seguridad.FechaCreacion,seguridad.UsuarioModificacion,seguridad.FechaModificacion,seguridad.Compania,seguridad.IndicadorCompania
						  ,seguridad.idTipoAtencion,seguridad.TipoTrabajador,seguridad.IndicadorFormato
						  ,1 as IndicadorAsignacion --OBS: NO ASIGNADO
						  ,seguridad.TipoProceso,seguridad.Accion,seguridad.Version,seguridad.Estado
							,seguridad.IdAgente,seguridad.IdGrupo,seguridad.IdOrganizacion,
							0 as TipoAgente,
							seguridad.CodigoAgente
						  ,seguridad.IdEmpleado,seguridad.IndicadorMultiple,seguridad.Clave,seguridad.FechaInicio,seguridad.FechaFin,seguridad.FechaExpiracion,
						  seguridad.NombreAgente,
						  seguridad.ExpiraClave,seguridad.DescripcionAgente,seguridad.EstadoAgente,seguridad.IdGrupoTransaccion,seguridad.TipoTransaccion,seguridad.IdOpcionDefecto,seguridad.Plataforma
						  ,seguridad.ValorFechaAgOpcion,seguridad.ValorNumericoAgOpcion,seguridad.ValorTextAgOpcion
						  , 1 as IndicadorAcceso,
						  1 as IndicadorHabilitado,1 as IndicadorObligatorio,1 as IndicadorVisible
						  ,1 as IndicarPrioridadAgOpcion,
						  1 as IndicadorNuevo,1 as IndicadorModificar
						  ,1 as IndicadorEliminar,
						  1 as IndicadorImprimir,
						  1 as IndicadorIngreso,
						  seguridad.EstadoAgenteOpcion,seguridad.IdFormato
						  ,seguridad.IdFormatoPadre,seguridad.CodigoFormato,seguridad.CodigoFormatoPadre,seguridad.CadenaRecursividadFormato
						  ,seguridad.Nivel,seguridad.DescripcionFormato,seguridad.DescripcionExtranjera,seguridad.TipoFormato
						  ,seguridad.VersionFormatoFijo,seguridad.IdFormatoDinamico,seguridad.EstadoFormato					
					from SS_CHE_VistaSeguridad as seguridad		
					where					
				IdAgente = @IdAgente
				and IndicadorObligatorio=2
			    and CodigoFormato is not null

			end
	         
	END	
				 
	if(@ACCION = 'LISTAPROCESOGENERAL')
		BEGIN			
					Select * from dbo.SS_CHE_VistaSeguridad  as VistaSeg
					where 
					VistaSeg.TipoOpcion <> 'N' and
					VistaSeg.IdAgente in (
						select DISTINCT IdAgente from @TABLA_OPCIONESAGENTE_VALIDAS as AgtVal
						where AgtVal.IdOpcion = VistaSeg.IdOpcion
						and INDICADOR = 'VALIDO'
						and TipoOpcion <> 'N'
						and IdAgente NOT IN(@IdAgente) 	
				
					)					
					and VistaSeg.EstadoAgenteOpcion = 2
					and VistaSeg.Modulo = 'HC'		
					and VistaSeg.EstadoFormato=@EstadoFormato
					and VistaSeg.NombreOpcion in (Select distinct NombreOpcion from SS_CHE_VistaSeguridad)
					and VistaSeg.UrlOpcion is null		
					
		 END	
		
		 if(@ACCION = 'LISTAPROCESOSBITACORA')
		BEGIN
			/*************************************************/
			/******CONFIGURACION DE ASIGNACIONES OPCION*****/
			/*************************************************/
			
				select @Total= COUNT(*) from @TABLA_OPCIONESAGENTE_VALIDAS
				set @cuenta  =1						
				
				while(@cuenta <= @Total)
				begin														 
					select @IndicadorVAL_AUX  = INDICADOR,
							@IdOpcionAux= idOpcion
						from @TABLA_OPCIONESAGENTE_VALIDAS as AUX
						where AUX.SECUENCIA = @cuenta
									 									 															
					if(@IndicadorVAL_AUX = 'VALIDO')
					begin
						select @INDICA_AUX =IndicadorAsignacion from SG_Opcion	
						where IdOpcion = @IdOpcionAux
						if(@INDICA_AUX = 2)
						begin						
							/***VALIDACIONES ASIGNADAS:**/
							--------------------------------
							--(1) ESPECIALIDAD
							--------------------------------
							set @CampoCodigoID_AUX = 4 -- 4: INDICA TABLA ESPECIALIDAD
							select @INDICA_AUX = count(*)
							from SS_HC_FormatoCodigoId
							where CampoCodigoId = @CampoCodigoID_AUX  --TABLA ESPECIALIDAD
							and IdOpcion=@IdOpcionAux
							if(@INDICA_AUX > 0) --POSEE ASIGNACIONES
							begin
								select @INDICA_AUX = count(*)
								from SS_HC_FormatoCodigoId
								where CampoCodigoId = @CampoCodigoID_AUX -- TABLA ESPECIALIDAD
								and IdOpcion=@IdOpcionAux	
								and IndicadorCodigoId=1	--1:INDICA TODOS
								
								if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES GENERALES (debe poseer específicas)
								begin
									select @INDICA_AUX = count(*)
									from SS_HC_FormatoCodigoId
									where CampoCodigoId = @CampoCodigoID_AUX -- TABLA ESPECIALIDAD
									and IdOpcion=@IdOpcionAux	
									and IndicadorCodigoId=2	--1:INDICA ESPECIFICOS
									and ValorId= @IdGrupo  --1:ID DE ESPECIALIDAD ESPECÍFICO
									
									if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES PARA TAL VALOR (NO VALIDO)
									begin
										update @TABLA_OPCIONESAGENTE_VALIDAS 
										set INDICADOR = 'NO VALIDO'					
										where SECUENCIA = @cuenta																	
									end
								end							
							end
							
							--------------------------------
							--(2) COMPANIA
							--------------------------------
							set @CampoCodigoID_AUX = 1 -- 1: INDICA TABLA COMPANIA
							select @INDICA_AUX = count(*)
							from SS_HC_FormatoCodigoId
							where CampoCodigoId = @CampoCodigoID_AUX  --TABLA COMPANIA
							and IdOpcion=@IdOpcionAux
							if(@INDICA_AUX > 0) --POSEE ASIGNACIONES
							begin
								select @INDICA_AUX = count(*)
								from SS_HC_FormatoCodigoId
								where CampoCodigoId = @CampoCodigoID_AUX -- TABLA COMPANIA
								and IdOpcion=@IdOpcionAux	
								and IndicadorCodigoId=1	--1:INDICA TODOS
								
								if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES GENERALES (debe poseer específicas)
								begin
									select @INDICA_AUX = count(*)
									from SS_HC_FormatoCodigoId
									where CampoCodigoId = @CampoCodigoID_AUX -- TABLA COMPANIA
									and IdOpcion=@IdOpcionAux	
									and IndicadorCodigoId=2	--1:INDICA ESPECIFICOS
									and ValorTexto= @Compania  --1:COD DE COMPANIA ESPECÍFICO
									
									if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES PARA TAL VALOR (NO VALIDO)
									begin
										update @TABLA_OPCIONESAGENTE_VALIDAS 
										set INDICADOR = 'NO VALIDO'					
										where SECUENCIA = @cuenta																	
									end
								end							
							end						
							--------------------------------
							--(3) ESTABLECIMIENTO
							--------------------------------
							set @CampoCodigoID_AUX = 2 -- 1: INDICA TABLA ESTABLECIMIENTO
							select @INDICA_AUX = count(*)
							from SS_HC_FormatoCodigoId
							where CampoCodigoId = @CampoCodigoID_AUX  --TABLA ESTABLECIMIENTO
							and IdOpcion=@IdOpcionAux
							if(@INDICA_AUX > 0) --POSEE ASIGNACIONES
							begin
								select @INDICA_AUX = count(*)
								from SS_HC_FormatoCodigoId
								where CampoCodigoId = @CampoCodigoID_AUX -- TABLA ESTABLECIMIENTO
								and IdOpcion=@IdOpcionAux	
								and IndicadorCodigoId=1	--1:INDICA TODOS
								
								if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES GENERALES (debe poseer específicas)
								begin
									select @INDICA_AUX = count(*)
									from SS_HC_FormatoCodigoId
									where CampoCodigoId = @CampoCodigoID_AUX -- TABLA ESTABLECIMIENTO
									and IdOpcion=@IdOpcionAux	
									and IndicadorCodigoId=2	--1:INDICA ESPECIFICOS
									and ValorId= @IdOrganizacion  --:ID DE ESTABLECIMIENTO ESPECÍFICO
									
									if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES PARA TAL VALOR (NO VALIDO)
									begin
										update @TABLA_OPCIONESAGENTE_VALIDAS 
										set INDICADOR = 'NO VALIDO'					
										where SECUENCIA = @cuenta																	
									end
								end							
							end									
							--------------------------------
							--(4) AGENTE
							--------------------------------	
							set @CampoCodigoID_AUX = 8 -- 1: INDICA TABLA AGENTE
							select @INDICA_AUX = count(*)
							from SS_HC_FormatoCodigoId
							where CampoCodigoId = @CampoCodigoID_AUX  --TABLA AGENTE
							and IdOpcion=@IdOpcionAux
							if(@INDICA_AUX > 0) --POSEE ASIGNACIONES
							begin
								select @INDICA_AUX = count(*)
								from SS_HC_FormatoCodigoId
								where CampoCodigoId = @CampoCodigoID_AUX -- TABLA AGENTE
								and IdOpcion=@IdOpcionAux	
								and IndicadorCodigoId=1	--1:INDICA TODOS
								
								if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES GENERALES (debe poseer específicas)
								begin
									select @INDICA_AUX = count(*)
									from SS_HC_FormatoCodigoId
									where CampoCodigoId = @CampoCodigoID_AUX -- TABLA 
									and IdOpcion=@IdOpcionAux	
									and IndicadorCodigoId=2	--1:INDICA ESPECIFICOS
									and ValorId= @IdAgente  --:ID DE AGENTE ESPECÍFICO
									
									if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES PARA TAL VALOR (NO VALIDO)
									begin
										update @TABLA_OPCIONESAGENTE_VALIDAS 
										set INDICADOR = 'NO VALIDO'					
										where SECUENCIA = @cuenta																	
									end
								end							
							end																																				
							--------------------------------
							--(5) UNIDAD DE SERVICIO
							--------------------------------	
							set @CampoCodigoID_AUX = 10 -- 1: INDICA TABLA UNID. SERVICIO
							select @INDICA_AUX = count(*)
							from SS_HC_FormatoCodigoId
							where CampoCodigoId = @CampoCodigoID_AUX  --TABLA 
							and IdOpcion=@IdOpcionAux
							if(@INDICA_AUX > 0) --POSEE ASIGNACIONES
							begin
								select @INDICA_AUX = count(*)
								from SS_HC_FormatoCodigoId
								where CampoCodigoId = @CampoCodigoID_AUX -- TABLA 
								and IdOpcion=@IdOpcionAux	
								and IndicadorCodigoId=1	--1:INDICA TODOS
								
								if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES GENERALES (debe poseer específicas)
								begin
								
									select @INDICA_AUX = count(*)
									from SS_HC_FormatoCodigoId
									where CampoCodigoId = @CampoCodigoID_AUX -- TABLA 
									and IdOpcion=@IdOpcionAux	
									and IndicadorCodigoId=2	--1:INDICA ESPECIFICOS
									and rtrim(ValorTexto)= 
										convert(varchar,@IdOrganizacion)   --:IDs  ESPECÍFICOs(Estable)
										+'|'+
										convert(varchar,@IdObjetoAsociado) --:IDs  ESPECÍFICOs (Unid. Serv)
																													
									if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES PARA TAL VALOR (NO VALIDO)
									begin
										update @TABLA_OPCIONESAGENTE_VALIDAS 
										set INDICADOR = 'NO VALIDO'					
										where SECUENCIA = @cuenta																	
									end
								end							
							end	

						end					
					
					end																		
					set @cuenta= @cuenta+1
					-------------
				end
				/*************************************************/
				/*************************************************/
		
			if (@Nivel=1)
				begin
					Select * from dbo.SS_CHE_VistaSeguridad as seguridad	where 
					seguridad.TipoOpcion <> 'N'					
					and		(seguridad.IdAgente in (
								select IdAgente from @TABLA_OPCIONESAGENTE_VALIDAS as AgtVal
								where AgtVal.IdOpcion = seguridad.IdOpcion
								and INDICADOR = 'VALIDO'
								and TipoOpcion <> 'N'
								and NivelOpcion = 1
							)
					)
					and		(seguridad.NivelOpcion = 1)					
					
				end
			else
				begin
					select * from (		
						Select vs.* from dbo.SS_CHE_VistaSeguridad vs where 
						vs.CodigoFormato IN(
						SELECT Formato_Codigo FROM v_EPISODIOATENCIONES V 
						WHERE V.IdPaciente=@IdEmpleado AND V.Episodio_Atencion=Convert(bigInt,isnull(@Version,0))/*V.IdEpisodioAtencion=Convert(bigInt,isnull(@Version,0))VERSION*/  
						AND V.UnidadReplicacion=@CadenaRecursividad and v.TipoTrabajador=@TipoTrabajador 
						AND V.CodigoOA IN(select CodigoOA from SS_HC_EpisodioAtencion EpiAtencion	inner join SS_HC_EpisodioClinico EpiClinico
								on (EpiClinico.UnidadReplicacion = EpiAtencion.UnidadReplicacion
							and EpiClinico.IdPaciente = EpiAtencion.IdPaciente
							and EpiClinico.EpisodioClinico = EpiAtencion.EpisodioClinico)
						where	(	(@CadenaRecursividad is null or EpiAtencion.UnidadReplicacion= @CadenaRecursividad)		
						and @Version is null or @Version= 0  or EpiAtencion.EpisodioAtencion= Convert(bigInt,@Version))		
						and (@IdEmpleado is null or  EpiAtencion.IdPaciente= @IdEmpleado)		
						and (@IndicadorPrioridad is null or @IndicadorPrioridad =0 or  EpiAtencion.EpisodioClinico= @IndicadorPrioridad)		
						and (@idTipoAtencion is null or @idTipoAtencion = 0 or  EpiAtencion.TipoAtencion= @idTipoAtencion)	)
						) AND VS.IdOpcionPadre= @IdOpcionPadre			
					)as seguridad
					where	
					 seguridad.TipoOpcion <> 'N'					
					and		seguridad.IdAgente in (																			
								select IdAgente from @TABLA_OPCIONESAGENTE_VALIDAS as AgtVal
								where AgtVal.IdOpcion = seguridad.IdOpcion
								and INDICADOR = 'VALIDO'
								and TipoOpcion <> 'N'
					)						
					and		seguridad.IdOpcionPadre = @IdOpcionPadre	
					order by seguridad.OrdenOpcion
				end

		 END
		 	
END

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_GE_Servicio]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================          
-- Author:    Grace Córdova          
-- Create date: 17/09/2015   
-- =============================================    
CREATE OR ALTER PROCEDURE [SP_SS_GE_Servicio]   
@IdServicio          INT,   
@IdGrupoAtencion     INT,   
@Codigo              VARCHAR(15),   
@Descripcion         VARCHAR(150),   
@IndicadorTriaje     INT,   
  
@TipoOrdenAtencion   INT,   
@Estado              INT,   
@UsuarioCreacion     VARCHAR(25),   
@FechaCreacion       DATETIME,   
@UsuarioModificacion VARCHAR(25),   
  
@FechaModificacion   DATETIME,   
@CentroCosto         VARCHAR(15),   
@CuentaBancaria      CHAR(15),   
@Accion              VARCHAR(25)   
AS   
  BEGIN   
      IF ( @Accion = 'INSERT' )   
        BEGIN           
        select @idservicio = isnull(MAX(idservicio),0)+1 from ss_ge_servicio   
            INSERT INTO ss_ge_servicio   
                        (idservicio,   
                         idgrupoatencion,   
                         codigo,   
                         descripcion,   
                         indicadortriaje,   
                         tipoordenatencion,   
                         estado,   
                         usuariocreacion,   
                         fechacreacion,   
                         usuariomodificacion,   
                         fechamodificacion,   
                         centrocosto,   
                         cuentabancaria,   
                         accion)   
            VALUES     ( @IdServicio,   
                         @IdGrupoAtencion,   
                         @Codigo,   
                         @Descripcion,   
                         @IndicadorTriaje,   
                         @TipoOrdenAtencion,   
                         @Estado,   
                         @UsuarioCreacion,   
                         GETDATE(),   
                         @UsuarioModificacion,   
                         GETDATE(),   
                         @CentroCosto,   
                         @CuentaBancaria,   
                         @Accion )   
            SELECT 1   
        END   
      ELSE IF ( @Accion = 'UPDATE' )   
        BEGIN   
            UPDATE ss_ge_servicio   
            SET    idservicio = @IdServicio,   
                   idgrupoatencion = @IdGrupoAtencion,   
                   codigo = @Codigo,   
                   descripcion = @Descripcion,   
                   indicadortriaje = @IndicadorTriaje,   
                   tipoordenatencion = @TipoOrdenAtencion,   
                   estado = @Estado,                      
                   usuariomodificacion = @UsuarioModificacion,   
                   fechamodificacion = GETDATE(),   
                   centrocosto = @CentroCosto,   
                   cuentabancaria = @CuentaBancaria,   
                   accion = @Accion   
            WHERE  idservicio = @IdServicio   
            SELECT 1   
        END   
      ELSE IF ( @Accion = 'DELETE' )   
        BEGIN   
            DELETE ss_ge_servicio   
            WHERE  idservicio = @IdServicio   
            SELECT 1   
        END   
      ELSE IF ( @Accion = 'LISTARPAG' )   
        BEGIN   
            DECLARE @CONTADOR INT   
            SET @CONTADOR = (SELECT Count(*) FROM   ss_ge_servicio   
                             WHERE  ( @IdServicio IS NULL OR idservicio = @IdServicio OR @IdServicio = 0 )   
                                    AND ( @Descripcion IS NULL OR @Descripcion = '' OR Rtrim(Upper(descripcion)) LIKE '%' + Rtrim(Upper(@Descripcion) ) + '%' ))   
            SELECT @CONTADOR   
        END   
  END   
/*   
EXEC SP_SS_GE_Servicio   
NULL,NULL,NULL,NULL,NULL,   
NULL,NULL,NULL,NULL,NULL,   
NULL,NULL,NULL,'LISTARPAG'   
*/ 
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_GE_ServicioListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================           
-- Author:    Grace Córdova           
-- Create date: 17/09/2015    
-- =============================================     
CREATE OR ALTER PROCEDURE [SP_SS_GE_ServicioListar]   
@IdServicio          INT,   
@IdGrupoAtencion     INT,   
@Codigo              VARCHAR(15),   
@Descripcion         VARCHAR(150),   
@IndicadorTriaje     INT,   
  
@TipoOrdenAtencion   INT,   
@Estado              INT,   
@UsuarioCreacion     VARCHAR(25),   
@FechaCreacion       DATETIME,   
@UsuarioModificacion VARCHAR(25),   
  
@FechaModificacion   DATETIME,   
@CentroCosto         VARCHAR(15),   
@CuentaBancaria      CHAR(15),   
@Accion              VARCHAR(25),   
@INICIO              INT= NULL,   
  
@NUMEROFILAS         INT = NULL   
AS   
  BEGIN   
      IF ( @Accion = 'LISTARPAG' )   
        BEGIN   
            DECLARE @CONTADOR INT   
  
            SELECT @CONTADOR = Count(*)   
            FROM   ss_ge_servicio   
            WHERE  ( @IdServicio IS NULL OR idservicio = @IdServicio OR @IdServicio = 0 )   
                   AND ( @Descripcion IS NULL OR @Descripcion = '' OR Rtrim(Upper(descripcion)) LIKE '%' + Rtrim(Upper(@Descripcion)) + '%' )   
  
            SELECT idservicio,   
                   idgrupoatencion,   
                   codigo,   
                   descripcion,   
                   indicadortriaje,   
                   tipoordenatencion,   
                   estado,   
                   usuariocreacion,   
                   fechacreacion,   
                   usuariomodificacion,   
                   fechamodificacion,   
                   centrocosto,   
                   cuentabancaria,   
                   accion   
            FROM  (SELECT idservicio,   
                          idgrupoatencion,   
                          codigo,   
                          descripcion,   
                          indicadortriaje,   
                          tipoordenatencion,   
                          estado,   
                          usuariocreacion,   
                          fechacreacion,   
                          usuariomodificacion,   
                          fechamodificacion,   
                          centrocosto,   
                          cuentabancaria,   
                          accion,   
                          @CONTADOR                AS CONTADOR,   
                          Row_number() OVER(ORDER BY idservicio) AS ROWNUMBER   
                   FROM   ss_ge_servicio   
                   WHERE  ( @IdServicio IS NULL OR idservicio = @IdServicio OR @IdServicio = 0 )   
                          AND ( @Descripcion IS NULL OR @Descripcion = '' OR Rtrim(Upper(descripcion)) LIKE '%' + Rtrim(Upper(@Descripcion) ) + '%' ))AS LISTADO   
            WHERE ( @INICIO IS NULL   
                    AND @NUMEROFILAS IS NULL )   
                   OR ( rownumber BETWEEN @INICIO AND @NUMEROFILAS )   
        END   
      ELSE IF ( @Accion = 'LISTAR' )   
        BEGIN   
            SELECT idservicio,   
                   idgrupoatencion,   
                   codigo,   
                   descripcion,   
                   indicadortriaje,   
                   tipoordenatencion,   
                   estado,   
                   usuariocreacion,   
                   fechacreacion,   
                   usuariomodificacion,   
                   fechamodificacion,   
                   centrocosto,   
                   cuentabancaria,   
                   accion   
            FROM   ss_ge_servicio   
            WHERE  ( @IdServicio IS NULL OR idservicio = @IdServicio OR @IdServicio = 0 )   
                   AND ( @Descripcion IS NULL OR @Descripcion = '' OR Rtrim(Upper(descripcion)) LIKE '%' + Rtrim(Upper(@Descripcion)) + '%' )   
        END   
  END   
/*   
EXEC SP_SS_GE_ServicioListar   
NULL,NULL,NULL,NULL,NULL,   
NULL,NULL,NULL,NULL,NULL,   
NULL,NULL,NULL,'LISTARPAG',0,15   
*/ 
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Actividad]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER PROCEDURE [SP_SS_HC_Actividad]

	@IdActividad int ,
	@Descripcion varchar(150) ,
	@Estado	int ,
	@UsuarioCreacion varchar(25) ,
	@FechaCreacion datetime ,	
	@UsuarioModificacion varchar(25) ,
	@FechaModificacion datetime ,		
	@ACCION	varchar(25) 
	
AS 
  BEGIN 
      SET nocount ON; 

      IF @Accion = 'INSERT' 
        BEGIN 
            SELECT @IdActividad = Isnull(Max(IdActividad), 0) + 1 FROM   dbo.SS_HC_Actividad  
            INSERT INTO SS_HC_Actividad 
                        (IdActividad,                          
                         descripcion,                         
                         estado, 
                         usuariocreacion, 
                         fechacreacion, 
                         usuariomodificacion, 
                         fechamodificacion, 
                         accion 
                         ) 
            VALUES      ( @IdActividad,                            
                          @Descripcion,                           
                          @Estado, 
                          @UsuarioCreacion, 
                          Getdate(), 
                          @UsuarioModificacion, 
                          Getdate(), 
                          @Accion
                          ) 

            SELECT 1 
        END 
      ELSE IF @Accion = 'UPDATE' 
        BEGIN 
            UPDATE SS_HC_Actividad 
            SET    IdActividad = @IdActividad,                    
                   descripcion = @Descripcion,                   
                   estado = @Estado, 
                 --  usuariocreacion = @UsuarioCreacion, 
                  -- fechacreacion = @FechaCreacion, 
                   usuariomodificacion = @UsuarioModificacion, 
                   fechamodificacion = GETDATE(), 
                   accion = @Accion 
                   
            WHERE  ( SS_HC_Actividad.IdActividad = @IdActividad ) 

            SELECT 1 
        END 
      ELSE IF @Accion = 'DELETE' 
        BEGIN 
            DELETE FROM SS_HC_Actividad 
            WHERE  ( SS_HC_Actividad.IdActividad = @IdActividad ) 

            SELECT 1 
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_Actividad 
                             WHERE  ( @Descripcion IS NULL OR Upper(SS_HC_Actividad.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_Actividad.estado = @Estado OR @Estado = 0 )                                    
                                    AND ( @IdActividad IS NULL OR SS_HC_Actividad.IdActividad = @IdActividad OR @IdActividad = 0 )) 

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
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Actividad_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_Actividad_LISTAR]


	@IdActividad int ,
	@Descripcion varchar(150) ,
	@Estado	int ,
	@UsuarioCreacion varchar(25) ,
	@FechaCreacion datetime ,	
	@UsuarioModificacion varchar(25) ,
	@FechaModificacion datetime ,
	@Inicio	int ,	
	@NumeroFilas int , 		
	@Accion	varchar(25) ,
	@Version varchar(25)		
				

AS 
  BEGIN 
      SET nocount ON; 

      DECLARE @CONTADOR INT 

      IF @Accion = 'LISTAR' 
        BEGIN 
            SELECT SS_HC_Actividad.IdActividad,                    
                   SS_HC_Actividad.descripcion, 
                   SS_HC_Actividad.Estado,                    
                   SS_HC_Actividad.usuariocreacion, 
                   SS_HC_Actividad.fechacreacion, 
                   SS_HC_Actividad.usuariomodificacion, 
                   SS_HC_Actividad.fechamodificacion, 
                   SS_HC_Actividad.accion, 
                   SS_HC_Actividad.version 
            FROM   SS_HC_Actividad 
             WHERE  ( @Descripcion IS NULL OR Upper(SS_HC_Actividad.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_Actividad.estado = @Estado OR @Estado = 0 )                                    
                                    AND ( @IdActividad IS NULL OR SS_HC_Actividad.IdActividad = @IdActividad OR @IdActividad = 0 )
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_Actividad 
                              WHERE  ( @Descripcion IS NULL OR Upper(SS_HC_Actividad.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_Actividad.estado = @Estado OR @Estado = 0 )                                    
                                    AND ( @IdActividad IS NULL OR SS_HC_Actividad.IdActividad = @IdActividad OR @IdActividad = 0 )) 

            SELECT IdActividad,                     
                   descripcion,                    
                   estado, 
                   usuariocreacion, 
                   fechacreacion, 
                   usuariomodificacion, 
                   fechamodificacion, 
                   accion, 
                   version 
            FROM   (SELECT SS_HC_Actividad.IdActividad,                            
                           SS_HC_Actividad.descripcion,                            
                           SS_HC_Actividad.estado, 
                           SS_HC_Actividad.usuariocreacion, 
                           SS_HC_Actividad.fechacreacion, 
                           SS_HC_Actividad.usuariomodificacion, 
                           SS_HC_Actividad.fechamodificacion, 
                           SS_HC_Actividad.accion, 
                           SS_HC_Actividad.version, 
                           @CONTADOR                                  
                           AS 
                           Contador, 
                           Row_number() 
                             OVER ( 
                               ORDER BY SS_HC_Actividad.IdActividad ASC ) 
                               AS 
                           RowNumber 
                    FROM   SS_HC_Actividad 
                     WHERE  ( @Descripcion IS NULL OR Upper(SS_HC_Actividad.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_Actividad.estado = @Estado OR @Estado = 0 )                                     
                                    AND ( @IdActividad IS NULL OR SS_HC_Actividad.IdActividad = @IdActividad OR @IdActividad = 0 )) 
                   AS LISTADO 
            WHERE  ( @Inicio IS NULL 
                     AND @NumeroFilas IS NULL ) 
                    OR rownumber BETWEEN @Inicio AND @NumeroFilas 
        END 
  END 
/*    
EXEC SP_SS_HC_NICListar    
1,NULL, NULL, NULL, NULL,   
NULL, NULL, NULL, NULL, NULL,   
NULL, NULL, NULL, LISTAR, NULL  ,
NULL,NULL 
*/ 




GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Anestesia_Farmaco_Detalle_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_Anestesia_Farmaco_Detalle_FE]
						
						
						@UnidadReplicacion char(4) ,  
						@IdEpisodioAtencion  bigint,
						@IdPaciente        int ,
						@EpisodioClinico   int ,
						@Secuencia         int ,
						@Tipo              int ,
						@TipoVia            int,
						@FarmacoDescripcion varchar(250) ,
						@Dosis             varchar(25) ,
						@Horario          varchar(25)  ,
						@UsuarioCreacion   varchar(25) ,
						@FechaCreacion    datetime  ,
						@UsuarioModificacion varchar(25),
						@FechaModificacion  datetime,
						@Accion           varchar(25)  ,
						@Version          varchar(25)  
AS
BEGIN
DECLARE @SECUENCIAMAX INT 
SET @SECUENCIAMAX = (SELECT (ISNULL(MAX(Secuencia),0)+1) FROM SS_HC_Anestesia_Farmacos_Detalle_FE WHERE
	UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico )
	
IF(@Accion = 'NUEVO')
BEGIN

			INSERT INTO SS_HC_Anestesia_Farmacos_Detalle_FE(						
						UnidadReplicacion  ,  
						IdEpisodioAtencion ,
						IdPaciente         ,
						EpisodioClinico    ,
						Secuencia          ,
						Tipo               ,
						TipoVia            ,
						FarmacoDescripcion ,
						Dosis              ,
						Horario            ,
						UsuarioCreacion    ,
						FechaCreacion      ,
						UsuarioModificacion,
						FechaModificacion  ,
						Accion             ,
						Version) 
				
				values(						
						@UnidadReplicacion  ,  
						@IdEpisodioAtencion ,
						@IdPaciente         ,
						@EpisodioClinico    ,
						@SECUENCIAMAX          ,
						@Tipo               ,
						@TipoVia            ,
						@FarmacoDescripcion ,
						@Dosis              ,
						@Horario            ,
						@UsuarioCreacion    ,
						getdate()      ,
						@UsuarioModificacion,
						getdate()  ,
						@Accion             ,
						@Version)
SELECT @SECUENCIAMAX
END

IF(@Accion = 'UPDATE')
BEGIN

			
				update SS_HC_Anestesia_Farmacos_Detalle_FE
				set
						Secuencia=@Secuencia          ,
						Tipo=@Tipo               ,
						TipoVia=@TipoVia            ,
						FarmacoDescripcion=@FarmacoDescripcion ,
						Dosis=@Dosis              ,
						Horario=@Horario            ,
						UsuarioModificacion=@UsuarioModificacion,
						FechaModificacion=getdate()  ,
						Accion=@Accion             ,
						Version=@Version
			where 
			UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
			AND EpisodioClinico=@EpisodioClinico AND Secuencia=@Secuencia AND Tipo =@Tipo 
	
	
SELECT @Secuencia
END

IF(@Accion = 'DELETE')
BEGIN

	DELETE FROM SS_HC_Anestesia_Farmacos_Detalle_FE
	WHERE UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico AND Secuencia=@Secuencia AND Tipo =@Tipo 
	
SELECT @Secuencia
END


END




GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Anestesia_Farmaco_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_Anestesia_Farmaco_FE]
		@UnidadReplicacion char(4),
		@IdEpisodioAtencion bigint,
		@IdPaciente int,
		@EpisodioClinico int,
		@Ingresos1 int,
		@Ingresos2 int,
		@Ingresos3 int,
		@Ingresos4 int,
		@Ingresos5 int,
		@Ingresos6 int,
		@Ingresos7 int,
		@Ingresos8 int,
		@IngresosCantidad1 int,
		@IngresosCantidad2 int,
		@IngresosCantidad3 int,
		@IngresosCantidad4 int,
		@IngresosCantidad5 int,
		@IngresosCantidad6 int,
		@IngresosCantidad7 int,
		@IngresosCantidad8 int,
		@IngresosHorario1 int,
		@IngresosHorario2 int,
		@IngresosHorario3 int,
		@IngresosHorario4 int,
		@IngresosHorario5 int,
		@IngresosHorario6 int,
		@IngresosHorario7 int,
		@IngresosHorario8 int,
		@TotalIngresos int,
		@Perdidas1 int,
		@Perdidas2 int,
		@Perdidas3 int,
		@Perdidas4 int,
		@Perdidas5 int,
		@Perdidas6 int,
		@PerdidasCantidad1 int,
		@PerdidasCantidad2 int,
		@PerdidasCantidad3 int,
		@PerdidasCantidad4 int,
		@PerdidasCantidad5 int,
		@PerdidasCantidad6 int,
		@PerdidasHorario1 int,
		@PerdidasHorario2 int,
		@PerdidasHorario3 int,
		@PerdidasHorario4 int,
		@PerdidasHorario5 int,
		@PerdidasHorario6 int,
		@TotalPerdidas int,
		@BalanceHidrico int,
		@UsuarioCreacion varchar(25),
		@FechaCreacion datetime,
		@UsuarioModificacion varchar(25),
		@FechaModificacion datetime,
		@Accion varchar(25),
		@Version varchar(25)

AS
BEGIN

IF(@Accion = 'NUEVO')
BEGIN

	insert into SS_HC_Anestesia_farmaco_FE(
				UnidadReplicacion,
				IdEpisodioAtencion,
				IdPaciente,
				EpisodioClinico,
				Ingresos1,
				Ingresos2,
				Ingresos3,
				Ingresos4,
				Ingresos5,
				Ingresos6,
				Ingresos7,
				Ingresos8,
				IngresosCantidad1,
				IngresosCantidad2,
				IngresosCantidad3,
				IngresosCantidad4,
				IngresosCantidad5,
				IngresosCantidad6,
				IngresosCantidad7,
				IngresosCantidad8,
				IngresosHorario1,
				IngresosHorario2,
				IngresosHorario3,
				IngresosHorario4,
				IngresosHorario5,
				IngresosHorario6,
				IngresosHorario7,
				IngresosHorario8,
				TotalIngresos,
				Perdidas1,
				Perdidas2,
				Perdidas3,
				Perdidas4,
				Perdidas5,
				Perdidas6,
				PerdidasCantidad1,
				PerdidasCantidad2,
				PerdidasCantidad3,
				PerdidasCantidad4,
				PerdidasCantidad5,
				PerdidasCantidad6,
				PerdidasHorario1,
				PerdidasHorario2,
				PerdidasHorario3,
				PerdidasHorario4,
				PerdidasHorario5,
				PerdidasHorario6,
				TotalPerdidas,
				BalanceHidrico,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version) 
				values(
					@UnidadReplicacion  ,
					@IdEpisodioAtencion ,
					@IdPaciente         ,
					@EpisodioClinico    ,
					@Ingresos1          ,
					@Ingresos2          ,
					@Ingresos3          ,
					@Ingresos4          ,
					@Ingresos5          ,
					@Ingresos6          ,
					@Ingresos7          ,
					@Ingresos8          ,
					@IngresosCantidad1  ,
					@IngresosCantidad2  ,
					@IngresosCantidad3  ,
					@IngresosCantidad4  ,
					@IngresosCantidad5  ,
					@IngresosCantidad6  ,
					@IngresosCantidad7  ,
					@IngresosCantidad8  ,
					@IngresosHorario1   ,
					@IngresosHorario2   ,
					@IngresosHorario3   ,
					@IngresosHorario4   ,
					@IngresosHorario5   ,
					@IngresosHorario6   ,
					@IngresosHorario7   ,
					@IngresosHorario8   ,
					@TotalIngresos      ,
					@Perdidas1          ,
					@Perdidas2          ,
					@Perdidas3          ,
					@Perdidas4          ,
					@Perdidas5          ,
					@Perdidas6          ,
					@PerdidasCantidad1  ,
					@PerdidasCantidad2  ,
					@PerdidasCantidad3  ,
					@PerdidasCantidad4  ,
					@PerdidasCantidad5  ,
					@PerdidasCantidad6  ,
					@PerdidasHorario1   ,
					@PerdidasHorario2   ,
					@PerdidasHorario3   ,
					@PerdidasHorario4   ,
					@PerdidasHorario5   ,
					@PerdidasHorario6   ,
					@TotalPerdidas      ,
					@BalanceHidrico     ,
					@UsuarioCreacion    ,
					GETDATE()      ,
					@UsuarioModificacion,
					GETDATE()  ,
					@Accion             ,
					@Version            )
			SELECT @EpisodioClinico
	END

IF(@Accion = 'UPDATE')
BEGIN

	UPDATE SS_HC_Anestesia_farmaco_FE
		set
         Ingresos1 =@Ingresos1          ,
          Ingresos2=@Ingresos2          ,
          Ingresos3=@Ingresos3          ,
          Ingresos4=@Ingresos4          ,
          Ingresos5=@Ingresos5          ,
          Ingresos6=@Ingresos6          ,
          Ingresos7=@Ingresos7          ,
         Ingresos8 =@Ingresos8          ,
          IngresosCantidad1=@IngresosCantidad1  ,
          IngresosCantidad2=@IngresosCantidad2  ,
          IngresosCantidad3=@IngresosCantidad3  ,
          IngresosCantidad4=@IngresosCantidad4  ,
          IngresosCantidad5=@IngresosCantidad5  ,
          IngresosCantidad6=@IngresosCantidad6  ,
          IngresosCantidad7=@IngresosCantidad7  ,
          IngresosCantidad8=@IngresosCantidad8  ,
          IngresosHorario1=@IngresosHorario1   ,
          IngresosHorario2=@IngresosHorario2   ,
          IngresosHorario3=@IngresosHorario3   ,
          IngresosHorario4=@IngresosHorario4   ,
          IngresosHorario5=@IngresosHorario5   ,
          IngresosHorario6=@IngresosHorario6   ,
          IngresosHorario7=@IngresosHorario7   ,
          IngresosHorario8=@IngresosHorario8   ,
          TotalIngresos=@TotalIngresos      ,
          Perdidas1=@Perdidas1          ,
          Perdidas2=@Perdidas2          ,
          Perdidas3=@Perdidas3          ,
          Perdidas4=@Perdidas4          ,
          Perdidas5=@Perdidas5          ,
          Perdidas6=@Perdidas6          ,
          PerdidasCantidad1=@PerdidasCantidad1  ,
          PerdidasCantidad2=@PerdidasCantidad2  ,
          PerdidasCantidad3=@PerdidasCantidad3  ,
          PerdidasCantidad4=@PerdidasCantidad4  ,
          PerdidasCantidad5=@PerdidasCantidad5  ,
          PerdidasCantidad6=@PerdidasCantidad6  ,
          PerdidasHorario1=@PerdidasHorario1   ,
          PerdidasHorario2=@PerdidasHorario2   ,
          PerdidasHorario3=@PerdidasHorario3   ,
          PerdidasHorario4=@PerdidasHorario4   ,
          PerdidasHorario5=@PerdidasHorario5   ,
          PerdidasHorario6=@PerdidasHorario6   ,
          TotalPerdidas=@TotalPerdidas      ,
          BalanceHidrico=@BalanceHidrico     ,
          UsuarioModificacion=@UsuarioModificacion,
          FechaModificacion=@FechaModificacion  ,
          Accion=@Accion             ,
          Version=@Version
	WHERE
	UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico 
	
	
	
	
SELECT @EpisodioClinico
END

IF(@Accion = 'DELETE')
BEGIN

	DELETE FROM SS_HC_Anestesia_farmaco_FE
	WHERE UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico 

	
SELECT @EpisodioClinico
END



END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Anestesia_Farmaco_FE_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_Anestesia_Farmaco_FE_Listar]
@UnidadReplicacion char(4)
,@IdEpisodioAtencion bigint 
,@IdPaciente int 
,@EpisodioClinico int 
,@Accion varchar(25)  


AS
BEGIN

IF(@Accion = 'LISTAR')
	BEGIN


		SELECT * FROM SS_HC_Anestesia_Farmaco_FE
			WHERE UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
			AND EpisodioClinico=@EpisodioClinico 
	END
			


END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Anestesia_Farmacos_Detalle_FE_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_Anestesia_Farmacos_Detalle_FE_Listar]
	@UnidadReplicacion char(4) ,
	@IdEpisodioAtencion bigint  ,
	@IdPaciente int  ,
	@EpisodioClinico int  ,
	@Tipo int ,
	@Accion varchar(25) 
	
AS
BEGIN

IF(@Accion = 'LISTAR')
BEGIN
		SELECT * FROM SS_HC_Anestesia_Farmacos_Detalle_FE
		WHERE UnidadReplicacion=@UnidadReplicacion AND
		IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
		AND EpisodioClinico=@EpisodioClinico AND Tipo=@Tipo 
		
END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_AntePerGinecoObstetricosCatalogoCirugia_Listar_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_AntePerGinecoObstetricosCatalogoCirugia_Listar_FE]
@UnidadReplicacion		CHAR(4),
@IdEpisodioAtencion		bigint,
@IdPaciente				int,
@EpisodioClinico		int,
@IdGinecoobstetricos int,

@Accion		varchar(25)

AS 
  BEGIN 
   IF ( @Accion = 'LISTAR' ) 
		set @IdGinecoobstetricos =1
        BEGIN 
            SELECT   *
            FROM   SS_HC_AntePerGinecoObstetricosCatalogoCirugia_FE 
            WHERE  ( UnidadReplicacion = @UnidadReplicacion ) 
					AND ( IdEpisodioAtencion =@IdEpisodioAtencion) 
					AND (IdPaciente	=@IdPaciente )
					and (EpisodioClinico = @EpisodioClinico )
					and ( IdGinecoobstetricos = @IdGinecoobstetricos)
        END 
  END 
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_ApoyoDiagnosticoFile_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_ApoyoDiagnosticoFile_FE]
	@UnidadReplicacion char(4),
	@IdEpisodioAtencion bigint,
	@IdPaciente int,
	@EpisodioClinico int ,
	@NroInforme varchar(25) ,
	@Secuencia int ,	
	@Nombre varchar(150) ,
	@RutaInforme varchar(250),
	@Estado int ,
	@UsuarioCreacion varchar(25) ,
	@FechaCreacion datetime ,
	@UsuarioModificacion varchar(25) ,
	@FechaModificacion datetime ,
	@Accion varchar(25) ,
	@Version varchar(25) 
	
	AS 
	BEGIN
	DECLARE @SECUENCIAMAX INT 
SET @SECUENCIAMAX = (SELECT (ISNULL(MAX(Secuencia),0)+1) FROM SS_HC_ApoyoDiagnosticoFile_FE WHERE
	UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico)
	
	IF(@Accion='NUEVO')
	BEGIN
		INSERT INTO SS_HC_ApoyoDiagnosticoFile_FE(UnidadReplicacion,IdEpisodioAtencion,IdPaciente,EpisodioClinico,NroInforme,
Secuencia,Nombre,RutaInforme,Estado,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,Accion,Version)
VALUES(@UnidadReplicacion,@IdEpisodioAtencion,@IdPaciente,@EpisodioClinico,@NroInforme,
@SECUENCIAMAX,@Nombre,@RutaInforme,@Estado,@UsuarioCreacion,@FechaCreacion,@UsuarioCreacion,@FechaCreacion,@Accion,@Version)

SELECT @SECUENCIAMAX
	END
	
	IF(@Accion='UPDATE')
	BEGIN
		
		UPDATE SS_HC_ApoyoDiagnosticoFile_FE
		SET Nombre=@Nombre,
		RutaInforme=@RutaInforme,
		Estado=@Estado,
		UsuarioModificacion=@UsuarioModificacion,
		FechaModificacion= @FechaModificacion
		
		where UnidadReplicacion=@UnidadReplicacion and IdEpisodioAtencion=@IdEpisodioAtencion and IdPaciente=@IdPaciente and EpisodioClinico=@EpisodioClinico
		and NroInforme=@NroInforme and Secuencia=@Secuencia

SELECT @Secuencia
	END
	
	IF(@Accion='DELETE')
	BEGIN
		
		DELETE SS_HC_ApoyoDiagnosticoFile_FE		
		where UnidadReplicacion=@UnidadReplicacion and IdEpisodioAtencion=@IdEpisodioAtencion and IdPaciente=@IdPaciente and EpisodioClinico=@EpisodioClinico
		and NroInforme=@NroInforme and Secuencia=@Secuencia

SELECT @Secuencia
	END
	
	
	
	
	END
	
GO

/****** Object:  StoredProcedure [dbo].[SP_SS_HC_ApoyoDiagnosticoFileListar_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_ApoyoDiagnosticoFileListar_FE]
	@UnidadReplicacion char(4),
	@IdEpisodioAtencion bigint,
	@IdPaciente int,
	@EpisodioClinico int ,
	@NroInforme varchar(25) ,
	@Secuencia int ,	
	@Nombre varchar(150) ,
	@RutaInforme varchar(250),
	@Estado int ,
	@UsuarioCreacion varchar(25) ,
	@FechaCreacion datetime ,
	@UsuarioModificacion varchar(25) ,
	@FechaModificacion datetime ,
	@Accion varchar(25) ,
	@Version varchar(25) 
	
	AS 
	BEGIN
	
	IF(@Accion='LISTAR')
	BEGIN
		
SELECT * from SS_HC_ApoyoDiagnosticoFile_FE 
where UnidadReplicacion=@UnidadReplicacion and IdEpisodioAtencion=@IdEpisodioAtencion and IdPaciente=@IdPaciente and EpisodioClinico=@EpisodioClinico
		and NroInforme=@NroInforme 
		
	

	END
	
	
	
	
	END


GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_AsignacionMedico]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_AsignacionMedico]
@UnidadReplicacion CHAR(4),
@IdPaciente INT,
@TipoAsignacion INT,
@IdAsignacionMedico INT,
@Secuencia INT,

@SecuenciaReferida INT,
@Observaciones VARCHAR(300),
@UsuarioCreacion VARCHAR(25),
@FechaCreacion DATETIME,
@UsuarioModificacion VARCHAR(25),

@FechaModificacion DATETIME,
@Estado INT,
@Accion              VARCHAR(50) 
AS 
  BEGIN 
      SET nocount ON; 
			SELECT @Secuencia = Isnull(Max(Secuencia), 0) + 1 
            FROM   dbo.SS_HC_AsignacionMedico 
            WHERE ( ss_hc_asignacionmedico.idpaciente = @IdPaciente ) 
      IF @Accion = 'INSERT' 
        BEGIN         
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
							@FechaCreacion,
							@UsuarioModificacion,
							@FechaModificacion,
							@Estado, 
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
            SET @CONTADOR = (SELECT Count(*) FROM  dbo.SS_HC_AsignacionMedico
                             WHERE  ( @Observaciones IS NULL OR Upper(observaciones) LIKE '%' + Upper(@Observaciones ) + '%' ) 
                                    AND ( @UnidadReplicacion IS NULL OR Upper(unidadreplicacion) LIKE '%' + Upper(@UnidadReplicacion) + '%' ) 
                                    AND ( @IdPaciente IS NULL OR idpaciente = @IdPaciente OR @IdPaciente = 0 ) 
                                    AND ( @IdAsignacionMedico IS NULL OR idasignacionmedico = @IdAsignacionMedico OR @IdAsignacionMedico = 0 )                                                                        ) 
            SELECT @CONTADOR; 
        END 
  END 
  /*
EXEC SP_SS_HC_AsignacionMedico   
NULL,0, 1, 0, 0,   
3,2, NULL, 0, 'ROYAL',  
'ROYAL', NULL,'UPDATE'   */
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_AsignacionMedicoListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_AsignacionMedicoListar]
@UnidadReplicacion CHAR(4),
@IdPaciente INT,
@TipoAsignacion INT,
@IdAsignacionMedico INT,
@Secuencia INT,

@SecuenciaReferida INT,
@Observaciones VARCHAR(300),
@UsuarioCreacion VARCHAR(25),
@FechaCreacion DATETIME,
@UsuarioModificacion VARCHAR(25),

@FechaModificacion DATETIME,
@Estado INT,
@Accion              VARCHAR(50), 
@INICIO              INT = NULL , 
@NUMEROFILAS         INT = NULL 
AS 
  BEGIN 
      SET nocount ON; 
IF @Accion = 'LISTAR' 
        BEGIN 
            SELECT  ss_hc_asignacionmedico.UnidadReplicacion,
					ss_hc_asignacionmedico.IdPaciente,
					ss_hc_asignacionmedico.TipoAsignacion,
					ss_hc_asignacionmedico.IdAsignacionMedico,
					ss_hc_asignacionmedico.Secuencia,
					ss_hc_asignacionmedico.SecuenciaReferida,
					ss_hc_asignacionmedico.Observaciones,
					ss_hc_asignacionmedico.UsuarioCreacion,
					ss_hc_asignacionmedico.FechaCreacion,
					ss_hc_asignacionmedico.UsuarioModificacion,
					ss_hc_asignacionmedico.FechaModificacion,
					ss_hc_asignacionmedico.Estado,
					ss_hc_asignacionmedico.accion
            FROM   ss_hc_asignacionmedico 
            WHERE  ( @Observaciones IS NULL OR Upper(observaciones) LIKE '%' + Upper(@Observaciones) + '%' ) 
                    AND ( @UnidadReplicacion IS NULL OR Upper(unidadreplicacion) LIKE '%' + Upper(@UnidadReplicacion) + '%' ) 
                    AND ( @IdPaciente IS NULL OR idpaciente = @IdPaciente OR @IdPaciente = 0 ) 
                    AND ( @IdAsignacionMedico IS NULL OR idasignacionmedico = @IdAsignacionMedico OR @IdAsignacionMedico = 0 )                    
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 
            --,@Personita INT            
		--	select @Personita = Persona from PERSONAMAST where ( @UsuarioCreacion IS NULL OR Upper(NombreCompleto) LIKE '%' + Upper(@UsuarioCreacion ) + '%' )
			

            SET @CONTADOR = (SELECT Count(*) FROM   ss_hc_asignacionmedico 
                             WHERE  ( @Observaciones IS NULL OR Upper(observaciones) LIKE '%' + Upper(@Observaciones ) + '%' ) 
                                    AND ( @UnidadReplicacion IS NULL OR Upper(unidadreplicacion) LIKE '%' + Upper(@UnidadReplicacion) + '%' ) 
                                    AND ( @IdPaciente IS NULL OR idpaciente = @IdPaciente OR @IdPaciente = 0 ) 
                                    AND ( @IdAsignacionMedico IS NULL OR idasignacionmedico = @IdAsignacionMedico OR @IdAsignacionMedico = 0 ) 
                                   ) 

            SELECT unidadreplicacion, 
                   idpaciente, 
                   tipoasignacion, 
                   idasignacionmedico, 
                   Secuencia,
                   SecuenciaReferida,
                   observaciones, 
                   estado, 
                   usuariocreacion, 
                   fechacreacion, 
                   usuariomodificacion, 
                   fechamodificacion, 
                   accion 
            FROM   (SELECT ss_hc_asignacionmedico.UnidadReplicacion,
					ss_hc_asignacionmedico.IdPaciente,
					ss_hc_asignacionmedico.TipoAsignacion,
					ss_hc_asignacionmedico.IdAsignacionMedico,
					ss_hc_asignacionmedico.Secuencia,
					ss_hc_asignacionmedico.SecuenciaReferida,
					ss_hc_asignacionmedico.Observaciones,
					ss_hc_asignacionmedico.UsuarioCreacion,
					ss_hc_asignacionmedico.FechaCreacion,
					ss_hc_asignacionmedico.UsuarioModificacion,
					ss_hc_asignacionmedico.FechaModificacion,
					ss_hc_asignacionmedico.Estado,
					ss_hc_asignacionmedico.accion, 
                           @CONTADOR                           AS contador, 
                           Row_number() OVER(ORDER BY unidadreplicacion ASC) AS rownumber 
                    FROM   ss_hc_asignacionmedico 
                    WHERE  ( @Observaciones IS NULL OR Upper(observaciones) LIKE '%' + Upper(@Observaciones) + '%' ) 
                           AND ( @UnidadReplicacion IS NULL OR Upper(unidadreplicacion) LIKE '%' + Upper(@UnidadReplicacion) + '%' ) 
                           AND ( @IdPaciente IS NULL OR idpaciente = @IdPaciente OR @IdPaciente = 0 )                                                       
                           AND ( @IdAsignacionMedico IS NULL OR idasignacionmedico = @IdAsignacionMedico OR @IdAsignacionMedico = 0 )                            
                          -- AND ( @Personita IS NULL OR persona = @Personita OR @Personita = 0 )
                          ) AS DATOSDETALLE 
            WHERE  ( @INICIO IS NULL AND @NUMEROFILAS IS NULL ) OR ( rownumber BETWEEN @INICIO AND @NUMEROFILAS ) 
        END 
  END 
/*     
EXEC SP_SS_HC_AsignacionMedicoListar     
NULL,NULL, NULL, NULL, NULL,     
NULL, NULL, NULL, NULL, NULL,      
NULL, NULL, NULL,'LISTARPAG', 0, 
10     
*/ 
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_AUDITROYAL]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 
CREATE OR ALTER PROCEDURE [SP_SS_HC_AUDITROYAL]
			@AuditID bigint,
			@HostName varchar(300),
            @Aplicacion varchar(30),
            @Modulo varchar(30),
            @Usuario varchar(128),
            @Type char(1),
            @TableName nvarchar(128),
            @TableIdValue bigint,
            @PrimaryKeyData varchar(1000),
            @OldData text,
            @NewData text,
            @UpdateDate datetime,
            @VistaData xml,
            @Accion varchar(25),  
            @Version datetime
AS  
BEGIN   
SET NOCOUNT ON;  
BEGIN  TRANSACTION  
  
 DECLARE @CONTADOR INT, @IntRetorno int
 
 IF(@Accion = 'INSERT')  
 BEGIN   
 		select @CONTADOR= isnull(MAX(AuditID),0)+1 from SS_HC_AuditRoyal 
		set @IntRetorno= @CONTADOR
						
					  INSERT INTO SS_HC_AuditRoyal  
					  (  		
									--AuditID,
									HostName,
									Aplicacion,
									Modulo,
									Usuario,
									Type,
									TableName,
									TableIdValue,
									PrimaryKeyData,
									OldData,
									NewData,
									UpdateDate,
									VistaData,
									Accion
					  )  
						VALUES  
					  (   
									
									--@AuditID,
									@HostName,
									@Aplicacion,
									@Modulo,
									@Usuario,
									@Type,
									@TableName,
									@TableIdValue,
									@PrimaryKeyData,
									@OldData,
									@NewData,
									@UpdateDate,
									@VistaData,
									@Accion
					  )  
  
			SELECT @IntRetorno		 
 END   
 ELSE  
 IF(@Accion = 'UPDATE')  
 BEGIN  
 UPDATE SS_HC_AuditRoyal  
  SET      
				HostName= @HostName,
				Aplicacion= @Aplicacion,
				Modulo= @Modulo,
				Usuario= @Usuario,
				Type= @Type,
				TableName= @TableName,
				TableIdValue= @TableIdValue,
				PrimaryKeyData= @PrimaryKeyData,
				OldData= @OldData,
				NewData= @NewData,
				UpdateDate=@UpdateDate,
				VistaData=@VistaData,
				Accion=@Accion
		WHERE 
		(AuditID = @AuditID)  
   		select 1
 end   
 else  
 if(@Accion = 'DELETE')  
 begin  
  delete SS_HC_AuditRoyal  
		WHERE 
		(AuditID = @AuditID)   
   		select 1
end
		if(@Accion = 'CONTARLISTAPAG')
	begin		
		
		SET @CONTADOR=(SELECT COUNT(AuditID) FROM SS_HC_AuditRoyal
	 				
     WHERE   
        (@AuditID is null OR (AuditID = @AuditID) or @AuditID =0)  
    and (@HostName is null  OR @HostName =''  OR  upper(HostName) like '%'+upper(@HostName)+'%')   
    and (@Aplicacion is null  OR @Aplicacion =''  OR  upper(Aplicacion) like '%'+upper(@Aplicacion)+'%')  
    and (@Modulo is null  OR @Modulo =''  OR  upper(Modulo) like '%'+upper(@Modulo)+'%')   
    and (@Usuario is null  OR @Usuario =''  OR  upper(Usuario) like '%'+upper(@Usuario)+'%')   
    and (@Type is null OR Type = @Type)   
    and ((@UpdateDate is null or  UpdateDate >= @UpdateDate)    
    and ( @Version is null or  UpdateDate <= DATEADD(DAY,1,@Version)))    
				
	)
				
		select @CONTADOR
	end
commit	 
END  
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_AUDITROYAL_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_AUDITROYAL_LISTAR]    
   @AuditID bigint,  
   @HostName varchar(300),  
            @Aplicacion varchar(30),  
            @Modulo varchar(30),  
            @Usuario varchar(128),  
            @Type char(1),  
            @TableName nvarchar(128),  
            @TableIdValue bigint,  
            @PrimaryKeyData varchar(1000),  
            @OldData text,  
            @NewData text,  
            @UpdateDate datetime,  
            @VistaData xml,
            @Accion varchar(25),  
            @Version datetime, 
              
   @INICIO   int= null,    
   @NUMEROFILAS int = null      
AS      
BEGIN      
if(@Accion = 'LISTARPAG')  
 begin  
   DECLARE @CONTADOR INT  
  SET @CONTADOR=(SELECT COUNT(AuditID) FROM SS_HC_AuditRoyal  
      
     WHERE   
     (@AuditID is null OR (AuditID = @AuditID) or @AuditID =0)  
    and (@HostName is null  OR @HostName =''  OR  upper(HostName) like '%'+upper(@HostName)+'%')   
    and (@Aplicacion is null  OR @Aplicacion =''  OR  upper(Aplicacion) like '%'+upper(@Aplicacion)+'%')  
    and (@Modulo is null  OR @Modulo =''  OR  upper(Modulo) like '%'+upper(@Modulo)+'%')   
    and (@Usuario is null  OR @Usuario =''  OR  upper(Usuario) like '%'+upper(@Usuario)+'%')   
    and (@Type is null OR Type = @Type)
     and ((@UpdateDate is null or  UpdateDate >= @UpdateDate)    
    and ( @Version is null or  UpdateDate <= DATEADD(DAY,1,@Version)))   
      
     )  
  SELECT  
    AuditID,  
    HostName,  
    Aplicacion,  
    Modulo,  
    Usuario,  
    Type,  
    TableName,  
    TableIdValue,  
    PrimaryKeyData,  
    OldData,  
    NewData,  
    UpdateDate,  
    VistaData,
    Accion,
    Version  
  FROM (    
   SELECT  
    AuditID,  
    HostName,  
    Aplicacion,  
    Modulo,  
    Usuario,  
    Type,  
    TableName,  
    TableIdValue,  
    PrimaryKeyData,  
    OldData,  
    NewData,  
    UpdateDate, 
    VistaData, 
    Accion,
    Version  
     ,@CONTADOR AS Contador  
     ,ROW_NUMBER() OVER (ORDER BY AuditID ASC ) AS RowNumber      
     FROM SS_HC_AuditRoyal   
     WHERE   
     (@AuditID is null OR (AuditID = @AuditID) or @AuditID =0)  
    and (@HostName is null  OR @HostName =''  OR  upper(HostName) like '%'+upper(@HostName)+'%')   
    and (@Aplicacion is null  OR @Aplicacion =''  OR  upper(Aplicacion) like '%'+upper(@Aplicacion)+'%')  
    and (@Modulo is null  OR @Modulo =''  OR  upper(Modulo) like '%'+upper(@Modulo)+'%')   
    and (@Usuario is null  OR @Usuario =''  OR  upper(Usuario) like '%'+upper(@Usuario)+'%')   
    and (@Type is null OR Type = @Type)
     and ((@UpdateDate is null or  UpdateDate >= @UpdateDate)    
    and ( @Version is null or  UpdateDate <= DATEADD(DAY,1,@Version)))   
   
   ) AS LISTADO  
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR    
            RowNumber BETWEEN @Inicio  AND @NumeroFilas   
    
       END  
       ELSE  
  IF @Accion ='LISTAR'      
    BEGIN      
  SELECT  
    AuditID,  
    HostName,  
    Aplicacion,  
    Modulo,  
    Usuario,  
    Type,  
    TableName,  
    TableIdValue,  
    PrimaryKeyData,  
    OldData,  
    NewData,  
    UpdateDate,  
    VistaData,
    Accion  
    FROM SS_HC_AuditRoyal   
     WHERE   
     (@AuditID is null OR (AuditID = @AuditID) or @AuditID =0)  
    and (@HostName is null  OR @HostName =''  OR  upper(HostName) like '%'+upper(@HostName)+'%')   
    and (@Aplicacion is null  OR @Aplicacion =''  OR  upper(Aplicacion) like '%'+upper(@Aplicacion)+'%')  
    and (@Modulo is null  OR @Modulo =''  OR  upper(Modulo) like '%'+upper(@Modulo)+'%')   
    and (@Usuario is null  OR @Usuario =''  OR  upper(Usuario) like '%'+upper(@Usuario)+'%')   
    and (@Type is null OR Type = @Type)
       and ((@UpdateDate is null or  UpdateDate >= @UpdateDate)    
    and ( @Version is null or  UpdateDate <= DATEADD(DAY,1,@Version)))   
   
end   
 else  
 if(@ACCION = 'LISTARPORID')  
 begin    
    SELECT   
     *       
    from   
    SS_HC_AuditRoyal  
  
     WHERE   
     (@AuditID = AuditID)   
  
 end   
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_BalanceHidroElect_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_BalanceHidroElect_FE]
@UnidadReplicacion char(4)
,@IdEpisodioAtencion bigint 
,@IdPaciente int 
,@EpisodioClinico int 

,@TipoBalance int

,@FechaControl datetime ,
	@Turno int ,
	@Peso decimal(9,2) ,
	@Hora  int ,
	@AlimentacionOral decimal(9,2) ,
	@SNG decimal(9,2) ,
	@DetalleSNG varchar(500) ,
	@TotalIngresos decimal(9,2) ,
	@PerdidaInsensible int ,
	@PerdidaCantidad decimal(9,2) ,
	@Orina decimal(9,2) ,
	@Heces decimal(9,2) ,
	@Vomitos decimal(9,2) ,
	@Temperatura decimal(9,2) ,
	@TemperaturaDescripcion varchar(250) ,
	@SuperficieCorporal decimal(9,2) ,
	@SuperficieDescripion varchar(250) ,
	@Succion decimal(9,2) ,
	@PerdidaSNG decimal(9,2) ,
	@TotalEgresos decimal(9,2) ,
	@BalanceHidrico decimal(9,2) ,
	@BalanceAcumulado decimal(9,2)  

,@UsuarioCreacion varchar(25)  
,@FechaCreacion datetime 
,@UsuarioModificacion varchar(25)  
,@FechaModificacion datetime 
,@Accion varchar(25)  
,@Version varchar(25)  

AS
BEGIN

IF(@Accion = 'NUEVO')
BEGIN

	INSERT INTO SS_HC_BalanceHidroElect_FE(UnidadReplicacion,IdEpisodioAtencion,IdPaciente,EpisodioClinico,TipoBalance,FechaControl,Turno,Peso,
Hora,AlimentacionOral,SNG,DetalleSNG,TotalIngresos,PerdidaInsensible,PerdidaCantidad,Orina,Heces,Vomitos,Temperatura,TemperaturaDescripcion,SuperficieCorporal,SuperficieDescripion,Succion,
PerdidaSNG,TotalEgresos,BalanceHidrico,BalanceAcumulado,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,Accion,Version) 
VALUES(@UnidadReplicacion,@IdEpisodioAtencion,@IdPaciente,@EpisodioClinico,@TipoBalance,@FechaControl,@Turno,@Peso,
@Hora,@AlimentacionOral,@SNG,@DetalleSNG,@TotalIngresos,@PerdidaInsensible,@PerdidaCantidad,@Orina,@Heces,@Vomitos,@Temperatura,@TemperaturaDescripcion,@SuperficieCorporal,@SuperficieDescripion,@Succion,
@PerdidaSNG,@TotalEgresos,@BalanceHidrico,@BalanceAcumulado,@UsuarioCreacion,@FechaCreacion,@UsuarioModificacion,@FechaModificacion,@Accion,@Version
)
SELECT @EpisodioClinico
END

IF(@Accion = 'UPDATE')
BEGIN

	UPDATE SS_HC_BalanceHidroElect_FE
	SET FechaControl = @FechaControl,
	Turno = @Turno,
	Peso = @Peso,
	Hora = @Hora,
	SNG = @SNG,
	DetalleSNG = @DetalleSNG,
	TotalIngresos = @TotalIngresos,
	AlimentacionOral = @AlimentacionOral,
	PerdidaInsensible= @PerdidaInsensible,
	PerdidaCantidad = @PerdidaCantidad,
	Orina = @Orina,
	Heces = @Heces,
	Vomitos = @Vomitos,
	Temperatura = @Temperatura,
	TemperaturaDescripcion = @TemperaturaDescripcion,
	SuperficieCorporal=@SuperficieCorporal,
	SuperficieDescripion=@SuperficieDescripion,
	Succion = @Succion,
	PerdidaSNG = @PerdidaSNG,
	TotalEgresos = @TotalEgresos,
	BalanceHidrico = @BalanceHidrico,
	BalanceAcumulado = @BalanceAcumulado,
	Accion =@Accion,
	Version=@Version,
	
	UsuarioModificacion=@UsuarioModificacion,
	FechaModificacion=@FechaModificacion
	WHERE
	UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico 
	AND TipoBalance=@TipoBalance
	
	
	
SELECT @EpisodioClinico
END

IF(@Accion = 'DELETE')
BEGIN

	DELETE FROM SS_HC_BalanceHidroElect_FE
	WHERE UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico 
AND TipoBalance=@TipoBalance
	
SELECT @EpisodioClinico
END



END




GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_BalanceHidroElect_FE_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_BalanceHidroElect_FE_Listar]
@UnidadReplicacion char(4)
,@IdEpisodioAtencion bigint 
,@IdPaciente int 
,@EpisodioClinico int 
,@TipoBalance int
,@FechaControl datetime ,
	@Turno int ,
	@Peso decimal(9,2) ,
	@Hora  int ,
	@AlimentacionOral decimal(9,2) ,
	@SNG decimal(9,2) ,
	@DetalleSNG varchar(500) ,
	@TotalIngresos decimal(9,2) ,
	@PerdidaInsensible int ,
	@PerdidaCantidad decimal(9,2) ,
	@Orina decimal(9,2) ,
	@Heces decimal(9,2) ,
	@Vomitos decimal(9,2) ,
	@Temperatura decimal(9,2) ,
	@TemperaturaDescripcion varchar(250) ,
	@SuperficieCorporal decimal(9,2) ,
	@SuperficieDescripion varchar(250) ,
	@Succion decimal(9,2) ,
	@PerdidaSNG decimal(9,2) ,
	@TotalEgresos decimal(9,2) ,
	@BalanceHidrico decimal(9,2) ,
	@BalanceAcumulado decimal(9,2)  

,@UsuarioCreacion varchar(25)  
,@FechaCreacion datetime 
,@UsuarioModificacion varchar(25)  
,@FechaModificacion datetime 
,@Accion varchar(25)  
,@Version varchar(25)  

AS
BEGIN

IF(@Accion = 'LISTAR')
BEGIN


SELECT * FROM SS_HC_BalanceHidroElect_FE
	WHERE UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico AND TipoBalance=@TipoBalance
END
IF(@Accion = 'CALCULAR')
BEGIN
declare @Ingresos decimal(9,2)
declare @Egresos decimal(9,2)
declare @Acumulado decimal(9,2)

	set @Acumulado =( SELECT isNull(SUM(BalanceHidrico),0) FROM 	SS_HC_BalanceHidroElect_FE
		WHERE UnidadReplicacion= @UnidadReplicacion AND   IdPaciente=@IdPaciente AND TipoBalance=@TipoBalance
		AND (EpisodioClinico=@EpisodioClinico and 
	IdEpisodioAtencion<>@IdEpisodioAtencion ) )
	
	select Top 1  UnidadReplicacion,
	IdEpisodioAtencion,
	IdPaciente,
	EpisodioClinico,
	TipoBalance,
	FechaControl,
	Turno,
	Peso,
	Hora,
	AlimentacionOral,
	SNG,
	DetalleSNG,
	/*@Ingresos as*/ TotalIngresos,
	PerdidaInsensible,
	PerdidaCantidad,
	Orina,
	Heces,
	Vomitos,
	Temperatura,
	TemperaturaDescripcion,
	SuperficieCorporal,
	SuperficieDescripion,
	Succion,
	PerdidaSNG,
	/*@Egresos as*/ TotalEgresos,
	/*@Acumulado as*/ BalanceHidrico,
	@Acumulado as BalanceAcumulado,
	UsuarioCreacion,
	FechaCreacion,
	UsuarioModificacion,
	FechaModificacion,
	Accion,
	Version
	from SS_HC_BalanceHidroElect_FE
	where UnidadReplicacion= @UnidadReplicacion AND  IdPaciente=@IdPaciente
	
	
END


END

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_BalanceHidroElectDetalle_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_BalanceHidroElectDetalle_FE]
	@UnidadReplicacion char(4) ,
	@IdEpisodioAtencion bigint  ,
	@IdPaciente int  ,
	@EpisodioClinico int  ,
	@TipoBalance int ,	
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
SET @SECUENCIAMAX = (SELECT (ISNULL(MAX(Secuencia),0)+1) FROM SS_HC_BalanceHidroElectDetalle_FE WHERE
	UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico )
	
IF(@Accion = 'NUEVO')
BEGIN

	INSERT INTO SS_HC_BalanceHidroElectDetalle_FE(UnidadReplicacion,IdEpisodioAtencion,IdPaciente,EpisodioClinico,TipoBalance,Secuencia,Tipo,TipoSolucion,SolucionDescripcion
	,CantidadCC,Especificacion,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,Accion,Version) 
VALUES(@UnidadReplicacion,@IdEpisodioAtencion,@IdPaciente,@EpisodioClinico,@TipoBalance,@SECUENCIAMAX,@Tipo,@TipoSolucion,@SolucionDescripcion,@CantidadCC,@Especificacion,@UsuarioCreacion,
@FechaCreacion,@UsuarioModificacion,@FechaModificacion,@Accion,@Version
)
SELECT @SECUENCIAMAX
END

IF(@Accion = 'UPDATE')
BEGIN

	UPDATE SS_HC_BalanceHidroElectDetalle_FE
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
	AND EpisodioClinico=@EpisodioClinico AND Secuencia=@Secuencia AND Tipo =@Tipo AND TipoBalance=@TipoBalance
	
	
	
SELECT @Secuencia
END

IF(@Accion = 'DELETE')
BEGIN

	DELETE FROM SS_HC_BalanceHidroElectDetalle_FE
	WHERE UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico AND Secuencia=@Secuencia AND Tipo =@Tipo AND TipoBalance=@TipoBalance
	
SELECT @Secuencia
END


END

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_BalanceHidroElectDetalle_FE_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_BalanceHidroElectDetalle_FE_Listar]
	@UnidadReplicacion char(4) ,
	@IdEpisodioAtencion bigint  ,
	@IdPaciente int  ,
	@EpisodioClinico int  ,

	@TipoBalance int,
	
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
SELECT * FROM SS_HC_BalanceHidroElectDetalle_FE
WHERE UnidadReplicacion=@UnidadReplicacion AND 
IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico AND Tipo=@Tipo AND 
TipoBalance=@TipoBalance
END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_BalanceHidroElectNeo_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_BalanceHidroElectNeo_FE]
@UnidadReplicacion char(4)
,@IdEpisodioAtencion bigint 
,@IdPaciente int 
,@EpisodioClinico int 

,@FechaControl datetime ,
	@Turno int ,
	@Peso decimal(9,2) ,
	@Hora  int ,
	@AlimentacionOral decimal(9,2) ,
	@SNG decimal(9,2) ,
	@DetalleSNG varchar(500) ,
	@TotalIngresos decimal(9,2) ,
	@PerdidaInseNeo int ,
	@PerdidaCantidad decimal(9,2) ,
	@Orina decimal(9,2) ,
	@Heces decimal(9,2) ,
	@Vomitos decimal(9,2) ,
	@Temperatura decimal(9,2) ,
	@TemperaturaDescripcion varchar(250) ,
	@Succion decimal(9,2) ,
	@PerdidaSNG decimal(9,2) ,
	@TotalEgresos decimal(9,2) ,
	@BalanceHidrico decimal(9,2) ,
	@BalanceAcumulado decimal(9,2)  

,@UsuarioCreacion varchar(25)  
,@FechaCreacion datetime 
,@UsuarioModificacion varchar(25)  
,@FechaModificacion datetime 
,@Accion varchar(25)  
,@Version varchar(25)  

AS
BEGIN

IF(@Accion = 'NUEVO')
BEGIN

	INSERT INTO SS_HC_BalanceHidroElectNeo_FE(UnidadReplicacion,IdEpisodioAtencion,IdPaciente,EpisodioClinico,FechaControl,Turno,Peso,
Hora,AlimentacionOral,SNG,DetalleSNG,TotalIngresos,PerdidaInseNeo,PerdidaCantidad,Orina,Heces,Vomitos,Temperatura,TemperaturaDescripcion,Succion,
PerdidaSNG,TotalEgresos,BalanceHidrico,BalanceAcumulado,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,Accion,Version) 
VALUES(@UnidadReplicacion,@IdEpisodioAtencion,@IdPaciente,@EpisodioClinico,@FechaControl,@Turno,@Peso,
@Hora,@AlimentacionOral,@SNG,@DetalleSNG,@TotalIngresos,@PerdidaInseNeo,@PerdidaCantidad,@Orina,@Heces,@Vomitos,@Temperatura,@TemperaturaDescripcion,@Succion,
@PerdidaSNG,@TotalEgresos,@BalanceHidrico,@BalanceAcumulado,@UsuarioCreacion,@FechaCreacion,@UsuarioModificacion,@FechaModificacion,@Accion,@Version
)
SELECT @IdEpisodioAtencion
END

IF(@Accion = 'UPDATE')
BEGIN

	UPDATE SS_HC_BalanceHidroElectNeo_FE
	SET FechaControl = @FechaControl,
	Turno = @Turno,
	Peso = @Peso,
	Hora = @Hora,
	SNG = @SNG,
	DetalleSNG = @DetalleSNG,
	TotalIngresos = @TotalIngresos,
	PerdidaInseNeo = @PerdidaInseNeo,
	PerdidaCantidad = @PerdidaCantidad,
	Orina = @Orina,
	Heces = @Heces,
	Vomitos = @Vomitos,
	Temperatura = @Temperatura,
	TemperaturaDescripcion = @TemperaturaDescripcion,
	Succion = @Succion,
	PerdidaSNG = @PerdidaSNG,
	TotalEgresos = @TotalEgresos,
	BalanceHidrico = @BalanceHidrico,
	BalanceAcumulado = @BalanceAcumulado,
	Accion =@Accion,
	Version=@Version,
	
	UsuarioModificacion=@UsuarioModificacion,
	FechaModificacion=@FechaModificacion
	WHERE
	UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico 
	
	
	
SELECT @IdEpisodioAtencion
END

IF(@Accion = 'DELETE')
BEGIN

	DELETE FROM SS_HC_BalanceHidroElectNeo_FE
	WHERE UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico 
	
SELECT @IdEpisodioAtencion
END



END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_BalanceHidroElectNeo_FE_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_BalanceHidroElectNeo_FE_Listar]
@UnidadReplicacion char(4)
,@IdEpisodioAtencion bigint 
,@IdPaciente int 
,@EpisodioClinico int 

,@FechaControl datetime ,
	@Turno int ,
	@Peso decimal(9,2) ,
	@Hora  int ,
	@AlimentacionOral decimal(9,2) ,
	@SNG decimal(9,2) ,
	@DetalleSNG varchar(500) ,
	@TotalIngresos decimal(9,2) ,
	@PerdidaInseNeo int ,
	@PerdidaCantidad decimal(9,2) ,
	@Orina decimal(9,2) ,
	@Heces decimal(9,2) ,
	@Vomitos decimal(9,2) ,
	@Temperatura decimal(9,2) ,
	@TemperaturaDescripcion varchar(250) ,
	@Succion decimal(9,2) ,
	@PerdidaSNG decimal(9,2) ,
	@TotalEgresos decimal(9,2) ,
	@BalanceHidrico decimal(9,2) ,
	@BalanceAcumulado decimal(9,2)  

,@UsuarioCreacion varchar(25)  
,@FechaCreacion datetime 
,@UsuarioModificacion varchar(25)  
,@FechaModificacion datetime 
,@Accion varchar(25)  
,@Version varchar(25)  

AS
BEGIN

IF(@Accion = 'LISTAR')
BEGIN


SELECT * FROM SS_HC_BalanceHidroElectNeo_FE
	WHERE UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico 
END
IF(@Accion = 'CALCULAR')
BEGIN
declare @Ingresos decimal(9,2)
declare @Egresos decimal(9,2)
declare @Acumulado decimal(9,2)

	set @Acumulado =( SELECT isNull(SUM(BalanceHidrico),0) FROM SS_HC_BalanceHidroElectNeo_FE
	WHERE UnidadReplicacion= @UnidadReplicacion AND   IdPaciente=@IdPaciente
	AND (EpisodioClinico=@EpisodioClinico and IdEpisodioAtencion<>@IdEpisodioAtencion) )
	
	select Top 1  UnidadReplicacion,
	IdEpisodioAtencion,
	IdPaciente,
	EpisodioClinico,
	FechaControl,
	Turno,
	Peso,
	Hora,
	AlimentacionOral,
	SNG,
	DetalleSNG,
	/*@Ingresos as*/ TotalIngresos,
	PerdidaInseNeo,
	PerdidaCantidad,
	Orina,
	Heces,
	Vomitos,
	Temperatura,
	TemperaturaDescripcion,
	Succion,
	PerdidaSNG,
	/*@Egresos as*/ TotalEgresos,
	/*@Acumulado as*/ BalanceHidrico,
	@Acumulado as BalanceAcumulado,
	UsuarioCreacion,
	FechaCreacion,
	UsuarioModificacion,
	FechaModificacion,
	Accion,
	Version
	from 	SS_HC_BalanceHidroElectNeo_FE
	where UnidadReplicacion= @UnidadReplicacion AND  IdPaciente=@IdPaciente	

END


END

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_BANDEJA_NOTIFI_DETALLE_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_BANDEJA_NOTIFI_DETALLE_LISTAR]

	    @IdNotificacion bigint ,
	    @IdSecuencia int,
	    @UnidadReplicacion char(4),
	    @IdPaciente int,
	    @EpisodioClinico int,
	    @IdEpisodioAtencion int,
	    @IdComponente int,
		@CodigoComponente varchar(30) ,		
		@Id01 int ,		
		@Id02 int,
		@codigo01 varchar(30),
		@codigo02  varchar(30)  ,
        @codigo03 varchar(30) , 
        @Descripcion01 varchar(300)  ,
        @Descripcion02 varchar(300)  ,
        @Descripcion03 varchar(300)  ,
        @Observacion varchar(300),
        @Estado  char(1)  ,
        @Usuario  varchar(30)  ,
        @UltimaFechaModif  datetime  ,
        @IdOpcion int  ,        
        @Accion varchar(25) , 
        @Version varchar(25)  ,	
	    @INICIO   int= null,  
	    @NUMEROFILAS int = null 	

AS 
  BEGIN 
      SET nocount ON; 

      DECLARE @CONTADOR INT 

      IF @Accion = 'LISTAR' 
        BEGIN 
            SELECT SS_HC_BANDEJA_NOTIFI_DETALLE.IdNotificacion, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.IdSecuencia, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.UnidadReplicacion,
                   SS_HC_BANDEJA_NOTIFI_DETALLE.IdPaciente,
                   SS_HC_BANDEJA_NOTIFI_DETALLE.EpisodioClinico,
                   SS_HC_BANDEJA_NOTIFI_DETALLE.IdEpisodioAtencion,
                   SS_HC_BANDEJA_NOTIFI_DETALLE.IdComponente, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.CodigoComponente, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Id01, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Id02,
                   SS_HC_BANDEJA_NOTIFI_DETALLE.codigo01, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.codigo02, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.codigo03, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Descripcion01, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Descripcion02, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Descripcion03,
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Observacion,
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Estado,
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Usuario,
                   SS_HC_BANDEJA_NOTIFI_DETALLE.UltimaFechaModif, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.IdOpcion,                   
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Accion, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Version 
            FROM   SS_HC_BANDEJA_NOTIFI_DETALLE 
             WHERE                      ( @Observacion IS NULL OR Upper(SS_HC_BANDEJA_NOTIFI_DETALLE.Observacion) LIKE '%' + Upper(@Observacion) + '%' ) 
                                    AND ( @UnidadReplicacion IS NULL OR Upper(SS_HC_BANDEJA_NOTIFI_DETALLE.UnidadReplicacion) LIKE '%' + Upper(@UnidadReplicacion) + '%' ) 
                                    AND ( @IdPaciente IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.IdPaciente = @IdPaciente OR @IdPaciente = 0 )
                                    AND ( @EpisodioClinico IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.EpisodioClinico = @EpisodioClinico OR @EpisodioClinico = 0 )
                                    AND ( @IdEpisodioAtencion IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.IdEpisodioAtencion = @IdEpisodioAtencion OR @IdEpisodioAtencion = 0 )
                                    AND ( @IdOpcion IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.IdOpcion = @IdOpcion OR @IdOpcion = 0 )
                                    AND ( @Estado IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.Estado = @Estado OR @Estado = 0 )                                   
                                    AND ( @IdNotificacion IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.IdNotificacion = @IdNotificacion OR @IdNotificacion = 0 )
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_BANDEJA_NOTIFI_DETALLE 
                              WHERE     ( @Observacion IS NULL OR Upper(SS_HC_BANDEJA_NOTIFI_DETALLE.Observacion) LIKE '%' + Upper(@Observacion) + '%' ) 
                                    AND ( @UnidadReplicacion IS NULL OR Upper(SS_HC_BANDEJA_NOTIFI_DETALLE.UnidadReplicacion) LIKE '%' + Upper(@UnidadReplicacion) + '%' ) 
                                    AND ( @IdPaciente IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.IdPaciente = @IdPaciente OR @IdPaciente = 0 )
                                    AND ( @EpisodioClinico IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.EpisodioClinico = @EpisodioClinico OR @EpisodioClinico = 0 )
                                    AND ( @IdEpisodioAtencion IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.IdEpisodioAtencion = @IdEpisodioAtencion OR @IdEpisodioAtencion = 0 )                                  
                                    AND ( @IdOpcion IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.IdOpcion = @IdOpcion OR @IdOpcion = 0 )
                                    AND ( @Estado IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.Estado = @Estado OR @Estado = 0 )                                   
                                    AND ( @IdNotificacion IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.IdNotificacion = @IdNotificacion OR @IdNotificacion = 0 ))

            SELECT IdNotificacion, 
                   IdSecuencia, 
                   UnidadReplicacion,
                   IdPaciente,
                   EpisodioClinico,
                   IdEpisodioAtencion,
                   IdComponente, 
                   CodigoComponente, 
                   Id01, 
                   Id02,
                   codigo01, 
                   codigo02, 
                   codigo03, 
                   Descripcion01, 
                   Descripcion02, 
                   Descripcion03,
                   Observacion,
                   Estado,
                   Usuario,
                   UltimaFechaModif, 
                   IdOpcion,                   
                   Accion, 
                   Version 
                          
            FROM  (
             SELECT SS_HC_BANDEJA_NOTIFI_DETALLE.IdNotificacion, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.IdSecuencia, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.UnidadReplicacion,
                   SS_HC_BANDEJA_NOTIFI_DETALLE.IdPaciente,
                   SS_HC_BANDEJA_NOTIFI_DETALLE.EpisodioClinico,
                   SS_HC_BANDEJA_NOTIFI_DETALLE.IdEpisodioAtencion,
                   SS_HC_BANDEJA_NOTIFI_DETALLE.IdComponente, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.CodigoComponente, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Id01, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Id02,
                   SS_HC_BANDEJA_NOTIFI_DETALLE.codigo01, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.codigo02, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.codigo03, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Descripcion01, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Descripcion02, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Descripcion03,
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Observacion,
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Estado,
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Usuario,
                   SS_HC_BANDEJA_NOTIFI_DETALLE.UltimaFechaModif, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.IdOpcion,                   
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Accion, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Version ,
                   @CONTADOR     AS 
                           Contador, 
                           Row_number() 
                             OVER ( 
                               ORDER BY SS_HC_BANDEJA_NOTIFI_DETALLE.IdNotificacion ASC ) AS 
                           RowNumber 
                    FROM   SS_HC_BANDEJA_NOTIFI_DETALLE 
                     WHERE              ( @Observacion IS NULL OR Upper(SS_HC_BANDEJA_NOTIFI_DETALLE.Observacion) LIKE '%' + Upper(@Observacion) + '%' ) 
                                    AND ( @UnidadReplicacion IS NULL OR Upper(SS_HC_BANDEJA_NOTIFI_DETALLE.UnidadReplicacion) LIKE '%' + Upper(@UnidadReplicacion) + '%' ) 
                                    AND ( @IdPaciente IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.IdPaciente = @IdPaciente OR @IdPaciente = 0 )
                                    AND ( @EpisodioClinico IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.EpisodioClinico = @EpisodioClinico OR @EpisodioClinico = 0 )
                                    AND ( @IdEpisodioAtencion IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.IdEpisodioAtencion = @IdEpisodioAtencion OR @IdEpisodioAtencion = 0 )                                  
                                    AND ( @IdOpcion IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.IdOpcion = @IdOpcion OR @IdOpcion = 0 )
                                    AND ( @Estado IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.Estado = @Estado OR @Estado = 0 )                                   
                                    AND ( @IdNotificacion IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.IdNotificacion = @IdNotificacion OR @IdNotificacion = 0 ))
                   AS LISTADO 
            WHERE  ( @Inicio IS NULL 
                     AND @NumeroFilas IS NULL ) 
                    OR rownumber BETWEEN @Inicio AND @NumeroFilas 
        END 
               
     
        ELSE IF( @ACCION = 'LISTARDETALLE' ) 
        BEGIN 
            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_BANDEJA_NOTIFI_DETALLE
                 WHERE                  ( @Observacion IS NULL OR Upper(SS_HC_BANDEJA_NOTIFI_DETALLE.Observacion) LIKE '%' + Upper(@Observacion) + '%' )
                                    AND ( @Descripcion01 IS NULL OR Upper(SS_HC_BANDEJA_NOTIFI_DETALLE.Descripcion01) LIKE '%' + Upper(@Descripcion01) + '%' )  
                                    AND ( @UnidadReplicacion IS NULL OR Upper(SS_HC_BANDEJA_NOTIFI_DETALLE.UnidadReplicacion) LIKE '%' + Upper(@UnidadReplicacion) + '%' ) 
                                    AND ( @IdPaciente IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.IdPaciente = @IdPaciente OR @IdPaciente = 0 )
                                    AND ( @EpisodioClinico IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.EpisodioClinico = @EpisodioClinico OR @EpisodioClinico = 0 )
                                    AND ( @IdEpisodioAtencion IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.IdEpisodioAtencion = @IdEpisodioAtencion OR @IdEpisodioAtencion = 0 )                                  
                                    AND ( @IdOpcion IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.IdOpcion = @IdOpcion OR @IdOpcion = 0 )
                                    AND ( @Estado IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.Estado = @Estado OR @Estado = 0 )                                   
                                    AND ( @IdNotificacion IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.IdNotificacion = @IdNotificacion OR @IdNotificacion = 0 ))

            SELECT IdNotificacion, 
                   IdSecuencia, 
                   UnidadReplicacion,
                   IdPaciente,
                   EpisodioClinico,
                   IdEpisodioAtencion,
                   IdComponente, 
                   CodigoComponente, 
                   Id01, 
                   Id02,
                   codigo01, 
                   codigo02, 
                   codigo03, 
                   
                   Descripcion01,    
                   Descripcion02, 
                   Descripcion03,
                   Observacion,
                   Estado,
                   Usuario,
                   UltimaFechaModif, 
                   IdOpcion,                   
                   Accion, 
                   Version 
                          
            FROM  
            (
                 SELECT SS_HC_BANDEJA_NOTIFI_DETALLE.IdNotificacion, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.IdSecuencia, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.UnidadReplicacion,
                   SS_HC_BANDEJA_NOTIFI_DETALLE.IdPaciente,
                   SS_HC_BANDEJA_NOTIFI_DETALLE.EpisodioClinico,
                   SS_HC_BANDEJA_NOTIFI_DETALLE.IdEpisodioAtencion,
                   SS_HC_BANDEJA_NOTIFI_DETALLE.IdComponente, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.CodigoComponente, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Id01, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Id02,
                   SS_HC_BANDEJA_NOTIFI_DETALLE.codigo01, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.codigo02, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.codigo03, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Descripcion01, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Descripcion02, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Descripcion03,
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Observacion,
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Estado,
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Usuario,
                   SS_HC_BANDEJA_NOTIFI_DETALLE.UltimaFechaModif, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.IdOpcion,                   
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Accion, 
                   SS_HC_BANDEJA_NOTIFI_DETALLE.Version ,
                   @CONTADOR     AS 
                           Contador, 
                           Row_number() 
                             OVER ( 
                               ORDER BY SS_HC_BANDEJA_NOTIFI_DETALLE.IdNotificacion ASC ) AS 
                           RowNumber 
                    FROM   SS_HC_BANDEJA_NOTIFI_DETALLE 
						  WHERE         ( @Observacion IS NULL OR Upper(SS_HC_BANDEJA_NOTIFI_DETALLE.Observacion) LIKE '%' + Upper(@Observacion) + '%' ) 
                                    AND ( @Descripcion01 IS NULL OR Upper(SS_HC_BANDEJA_NOTIFI_DETALLE.Descripcion01) LIKE '%' + Upper(@Descripcion01) + '%' )
                                    AND ( @UnidadReplicacion IS NULL OR Upper(SS_HC_BANDEJA_NOTIFI_DETALLE.UnidadReplicacion) LIKE '%' + Upper(@UnidadReplicacion) + '%' ) 
                                    AND ( @IdPaciente IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.IdPaciente = @IdPaciente OR @IdPaciente = 0 )
                                    AND ( @EpisodioClinico IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.EpisodioClinico = @EpisodioClinico OR @EpisodioClinico = 0 )
                                    AND ( @IdEpisodioAtencion IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.IdEpisodioAtencion = @IdEpisodioAtencion OR @IdEpisodioAtencion = 0 )                                  
                                    AND ( @IdOpcion IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.IdOpcion = @IdOpcion OR @IdOpcion = 0 )
                                    AND ( @Estado IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.Estado = @Estado OR @Estado = 0 )                                   
                                    AND ( @IdNotificacion IS NULL OR SS_HC_BANDEJA_NOTIFI_DETALLE.IdNotificacion = @IdNotificacion OR @IdNotificacion = 0 ))
                   AS LISTADO 
                              
        END 
        
  END 






GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_BANDEJA_NOTIFI_EPISODIO_HEADER_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_BANDEJA_NOTIFI_EPISODIO_HEADER_LISTAR]	   
		@UnidadReplicacion char(4) ,		
		@IdPaciente int ,
		 @IdOrdenAtencion int ,			
		@Tipo int,
		 @IdEspecialidad  int ,
		@CodigoOA varchar(25) ,	
		@Secuencia int,		
		@TipoMedicamento int,
		@IdUnidadMedida int,
		@Linea char(6),
		@Familia char(6),
		@SubFamilia char(6),
        @CodigoComponente varchar(25)  ,
		@IdVia int,
		@Dosis Varchar(250),
		@DiasTratamiento decimal (9,2),
		@Frecuencia decimal (9,2),
		@Cantidad decimal (20,6),
		@IndicadorEPS int,
		@TipoReceta int,
		@GrupoMedicamento int,
        @Comentario  varchar(1500)  ,
		@TipoComida int,
		@VolumenDia varchar(250),
		@FrecuenciaToma varchar(250),
		@Presentacion varchar(250),
		@Hora datetime,
		@Periodo varchar(10),
		@UnidadaTiempo int,
		@UsuarioAuditoria varchar(25),
		@Indicacion varchar(500),
        @Estado  int  ,
		@UsuarioCreacion varchar(25),
		@FechaCreacion datetime,
        @UsuarioModificacion  varchar(25)  ,
        @FechaModificacion  datetime  ,             
        @Accion varchar(25) , 
        @Version varchar(25)  ,
		@INDICADORTI int,
		@IdPadreNutriente int,
		@IdHijoNutriente int,
		@SecuencialHCE varchar(20),
		@CodAlmacen varchar(20),
	    @INICIO   int= null,  
	    @NUMEROFILAS int = null 	
AS 
  BEGIN 
      SET nocount ON; 

      DECLARE @CONTADOR INT 

 IF(@ACCION = 'LISTARTOTAL')  
 begin  
   DECLARE @CONTADORES INT  
   
	  SET @CONTADORES=(SELECT COUNT(vw_Imprimir_HC_GRILLANOTIFICACION_EPISODIO.IdPaciente) FROM vw_Imprimir_HC_GRILLANOTIFICACION_EPISODIO           
		   WHERE                     
			 ( @Version IS NULL OR Upper(vw_Imprimir_HC_GRILLANOTIFICACION_EPISODIO.version) LIKE '%' + Upper(@Version) + '%' ) 
 
		 )  
	  SELECT  * FROM
	  ( SELECT     *
		 ,@CONTADOR AS Contador  
		 ,ROW_NUMBER() OVER (ORDER BY IdPaciente ASC ) AS RowNumber     
		  from vw_Imprimir_HC_GRILLANOTIFICACION_EPISODIO 
			WHERE                                  
			( @Version IS NULL OR Upper(vw_Imprimir_HC_GRILLANOTIFICACION_EPISODIO.version) LIKE '%' + Upper(@Version) + '%' )                          
			)  
			AS LISTADO  
			WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR    
				RowNumber BETWEEN @Inicio  AND @NumeroFilas                 
			END  
  END 

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_BANDEJA_NOTIFI_HEADER_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER PROCEDURE [SP_SS_HC_BANDEJA_NOTIFI_HEADER_LISTAR]


	    @IdNotificacion bigint ,
		@UnidadReplicacion char(4) ,		
		@IdPaciente int ,		
		@CodigoOA varchar(25) ,		
		@EpisodioClinico int,
		@IdEpisodioAtencion int,
		@Linea  int  ,
        @IdOrdenAtencion int , 
        @IdPersonalSalud  int  ,
        @TipoNotificacion  varchar(2)  ,
        @Descripcion  varchar(300)  ,
        @Estado  char(1)  ,
        @Usuario  varchar(30)  ,
        @UltimaFechaModif  datetime  ,
        @IdOpcion int  ,        
        @Accion varchar(25) , 
        @Version varchar(25)  ,
	
	    @INICIO   int= null,  
	    @NUMEROFILAS int = null 
			


AS 
  BEGIN 
      SET nocount ON; 

      DECLARE @CONTADOR INT 

      IF @Accion = 'LISTAR' 
        BEGIN 
            SELECT SS_HC_BANDEJA_NOTIFI_HEADER.IdNotificacion, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.UnidadReplicacion, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.IdPaciente, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.CodigoOA, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.EpisodioClinico, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.IdEpisodioAtencion,
                   SS_HC_BANDEJA_NOTIFI_HEADER.Linea, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.IdOrdenAtencion, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.IdPersonalSalud, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.TipoNotificacion, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.Descripcion, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.Estado,
                   SS_HC_BANDEJA_NOTIFI_HEADER.Usuario,
                   SS_HC_BANDEJA_NOTIFI_HEADER.UltimaFechaModif, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.IdOpcion,                   
                   SS_HC_BANDEJA_NOTIFI_HEADER.Accion, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.Version 
            FROM   SS_HC_BANDEJA_NOTIFI_HEADER 
             WHERE                      ( @Descripcion IS NULL OR Upper(SS_HC_BANDEJA_NOTIFI_HEADER.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @IdPersonalSalud IS NULL OR SS_HC_BANDEJA_NOTIFI_HEADER.IdPersonalSalud = @IdPersonalSalud OR @IdPersonalSalud = 0 )
                                    AND ( @Estado IS NULL OR SS_HC_BANDEJA_NOTIFI_HEADER.Estado = @Estado OR @Estado = 0 )                                   
                                    AND ( @IdNotificacion IS NULL OR SS_HC_BANDEJA_NOTIFI_HEADER.IdNotificacion = @IdNotificacion OR @IdNotificacion = 0 )
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_BANDEJA_NOTIFI_HEADER 
                              WHERE     ( @Descripcion IS NULL OR Upper(SS_HC_BANDEJA_NOTIFI_HEADER.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @IdPersonalSalud IS NULL OR SS_HC_BANDEJA_NOTIFI_HEADER.IdPersonalSalud = @IdPersonalSalud OR @IdPersonalSalud = 0 )
                                    AND ( @Estado IS NULL OR SS_HC_BANDEJA_NOTIFI_HEADER.Estado = @Estado OR @Estado = 0 )                                   
                                    AND ( @IdNotificacion IS NULL OR SS_HC_BANDEJA_NOTIFI_HEADER.IdNotificacion = @IdNotificacion OR @IdNotificacion = 0 ))

            SELECT       IdNotificacion,
                         UnidadReplicacion,                          
                         IdPaciente, 
                         CodigoOA,
                         EpisodioClinico,
                         IdEpisodioAtencion,
                         Linea,
                         IdOrdenAtencion,
                         IdPersonalSalud,
                         TipoNotificacion, 
                         Descripcion,   
                         Estado,                  
                         Usuario, 
                         UltimaFechaModif, 
                         IdOpcion,                         
                         Accion, 
                         Version
                          
            FROM  (
            SELECT SS_HC_BANDEJA_NOTIFI_HEADER.IdNotificacion, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.UnidadReplicacion, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.IdPaciente, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.CodigoOA, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.EpisodioClinico, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.IdEpisodioAtencion, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.Linea,
                   SS_HC_BANDEJA_NOTIFI_HEADER.IdOrdenAtencion, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.IdPersonalSalud, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.TipoNotificacion, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.Descripcion,                    
                   SS_HC_BANDEJA_NOTIFI_HEADER.Estado,
                   SS_HC_BANDEJA_NOTIFI_HEADER.Usuario,
                   SS_HC_BANDEJA_NOTIFI_HEADER.UltimaFechaModif, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.IdOpcion,                 
                   SS_HC_BANDEJA_NOTIFI_HEADER.Accion, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.Version ,
                   @CONTADOR     AS 
                           Contador, 
                           Row_number() 
                             OVER ( 
                               ORDER BY SS_HC_BANDEJA_NOTIFI_HEADER.IdNotificacion ASC ) AS 
                           RowNumber 
                    FROM   SS_HC_BANDEJA_NOTIFI_HEADER 
                     WHERE              ( @Descripcion IS NULL OR Upper(SS_HC_BANDEJA_NOTIFI_HEADER.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @IdPersonalSalud IS NULL OR SS_HC_BANDEJA_NOTIFI_HEADER.IdPersonalSalud = @IdPersonalSalud OR @IdPersonalSalud = 0 )                
                                    AND ( @Estado IS NULL OR SS_HC_BANDEJA_NOTIFI_HEADER.Estado = @Estado OR @Estado = 0 )                                   
                                    AND ( @IdNotificacion IS NULL OR SS_HC_BANDEJA_NOTIFI_HEADER.IdNotificacion = @IdNotificacion OR @IdNotificacion = 0 ))
                   AS LISTADO 
            WHERE  ( @Inicio IS NULL 
                     AND @NumeroFilas IS NULL ) 
                    OR rownumber BETWEEN @Inicio AND @NumeroFilas 
        END 
        
        
        IF(@ACCION = 'LISTARTOTAL')  
 begin  
   DECLARE @CONTADORES INT  
   
  SET @CONTADORES=(SELECT COUNT(vw_Imprimir_HC_GRILLANOTIFICACION.IdNotificacion) FROM vw_Imprimir_HC_GRILLANOTIFICACION  
          
       WHERE                       ( @Descripcion IS NULL OR Upper(vw_Imprimir_HC_GRILLANOTIFICACION.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Version IS NULL OR Upper(vw_Imprimir_HC_GRILLANOTIFICACION.version) LIKE '%' + Upper(@Version) + '%' ) 
                                    AND ( @IdPersonalSalud IS NULL OR vw_Imprimir_HC_GRILLANOTIFICACION.IdPersonalSalud = @IdPersonalSalud OR @IdPersonalSalud = 0 )                
                                    AND ( @Estado IS NULL OR vw_Imprimir_HC_GRILLANOTIFICACION.Estado = @Estado OR @Estado = 0 )                                   
                                    AND ( @IdNotificacion IS NULL OR vw_Imprimir_HC_GRILLANOTIFICACION.IdNotificacion = @IdNotificacion OR @IdNotificacion = 0 )
     )  
  SELECT   *
  
  FROM( SELECT  
   *
     ,@CONTADOR AS Contador  
     ,ROW_NUMBER() OVER (ORDER BY IdNotificacion ASC ) AS RowNumber     
      from vw_Imprimir_HC_GRILLANOTIFICACION 
WHERE                                   ( @Descripcion IS NULL OR Upper(vw_Imprimir_HC_GRILLANOTIFICACION.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Version IS NULL OR Upper(vw_Imprimir_HC_GRILLANOTIFICACION.version) LIKE '%' + Upper(@Version) + '%' ) 
                                    AND ( @IdPersonalSalud IS NULL OR vw_Imprimir_HC_GRILLANOTIFICACION.IdPersonalSalud = @IdPersonalSalud OR @IdPersonalSalud = 0 )                
                                    AND ( @Estado IS NULL OR vw_Imprimir_HC_GRILLANOTIFICACION.Estado = @Estado OR @Estado = 0 )                                   
                                    AND ( @IdNotificacion IS NULL OR vw_Imprimir_HC_GRILLANOTIFICACION.IdNotificacion = @IdNotificacion OR @IdNotificacion = 0 )
     )  
     AS LISTADO  
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR    
            RowNumber BETWEEN @Inicio  AND @NumeroFilas   
              
       END        
        
        ELSE IF( @ACCION = 'LISTARPORMEDICO' ) 
        BEGIN 
            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_BANDEJA_NOTIFI_HEADER 
                              WHERE     ( @Descripcion IS NULL OR Upper(SS_HC_BANDEJA_NOTIFI_HEADER.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @IdPersonalSalud IS NULL OR SS_HC_BANDEJA_NOTIFI_HEADER.IdPersonalSalud = @IdPersonalSalud OR @IdPersonalSalud = 0 )                
                                    AND ( @Estado IS NULL OR SS_HC_BANDEJA_NOTIFI_HEADER.Estado = @Estado OR @Estado = 0 )                                   
                                    AND ( @IdNotificacion IS NULL OR SS_HC_BANDEJA_NOTIFI_HEADER.IdNotificacion = @IdNotificacion OR @IdNotificacion = 0 ))

             SELECT      IdNotificacion,
                         UnidadReplicacion,                          
                         IdPaciente, 
                         CodigoOA,
                         EpisodioClinico,
                         IdEpisodioAtencion,
                         Linea,
                         IdOrdenAtencion,
                         IdPersonalSalud,
                         TipoNotificacion, 
                         Descripcion,   
                         Estado,                  
                         Usuario, 
                         UltimaFechaModif, 
                         IdOpcion,                         
                         Accion, 
                         Version
                          
            FROM  (
              SELECT SS_HC_BANDEJA_NOTIFI_HEADER.IdNotificacion, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.UnidadReplicacion, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.IdPaciente, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.CodigoOA, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.EpisodioClinico, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.IdEpisodioAtencion, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.Linea,
                   SS_HC_BANDEJA_NOTIFI_HEADER.IdOrdenAtencion, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.IdPersonalSalud, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.TipoNotificacion, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.Descripcion,                    
                   SS_HC_BANDEJA_NOTIFI_HEADER.Estado,
                   SS_HC_BANDEJA_NOTIFI_HEADER.Usuario,
                   SS_HC_BANDEJA_NOTIFI_HEADER.UltimaFechaModif, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.IdOpcion,                 
                   SS_HC_BANDEJA_NOTIFI_HEADER.Accion, 
                   SS_HC_BANDEJA_NOTIFI_HEADER.Version ,
                   @CONTADOR     AS 
                           Contador, 
                           Row_number() 
                             OVER ( 
                               ORDER BY SS_HC_BANDEJA_NOTIFI_HEADER.IdNotificacion ASC ) AS 
                           RowNumber 
                    FROM   SS_HC_BANDEJA_NOTIFI_HEADER 
						WHERE           ( @Descripcion IS NULL OR Upper(SS_HC_BANDEJA_NOTIFI_HEADER.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @IdPersonalSalud IS NULL OR SS_HC_BANDEJA_NOTIFI_HEADER.IdPersonalSalud = @IdPersonalSalud OR @IdPersonalSalud = 0 )                
                                    AND ( @Estado IS NULL OR SS_HC_BANDEJA_NOTIFI_HEADER.Estado = @Estado OR @Estado = 0 )                                   
                                    AND ( @IdNotificacion IS NULL OR SS_HC_BANDEJA_NOTIFI_HEADER.IdNotificacion = @IdNotificacion OR @IdNotificacion = 0 ))
                   AS LISTADO 
                              
        END 
        
  END 


GO

