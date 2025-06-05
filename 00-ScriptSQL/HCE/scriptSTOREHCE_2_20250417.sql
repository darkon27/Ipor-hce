GO

/****** Object:  StoredProcedure [dbo].[SP_SS_HC_CatalogoUnidadServicio]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_CatalogoUnidadServicio]
@IdUnidadServicio      INT, 
@CodigoUnidadServicio  VARCHAR(20), 
@IdUnidadServicioPadre INT, 
@Descripcion           VARCHAR(200), 
@DescripcionExtranjera VARCHAR(200), 
@Nivel                 INT, 
@UltimoNivelFlag       CHAR(1), 
@CadenaRecursividad    VARCHAR(150), 
@Orden                 INT, 
@Icono                 VARCHAR(100), 
@Estado                INT, 
@UsuarioCreacion       VARCHAR(25), 
@FechaCreacion         DATETIME, 
@UsuarioModificacion   VARCHAR(25), 
@FechaModificacion     DATETIME, 
@Accion                VARCHAR( 25) 
AS 
  BEGIN 
      SET nocount ON; 

      IF @Accion = 'INSERT' 
        BEGIN 
			SELECT @IdUnidadServicio = Isnull(Max(ss_hc_catalogounidadservicio.IdUnidadServicio), 0) + 1 
            FROM   dbo.ss_hc_catalogounidadservicio 
			PRINT @idunidadservicio
            INSERT INTO ss_hc_catalogounidadservicio 
                        (idunidadservicio, 
                         codigounidadservicio, 
                         idunidadserviciopadre, 
                         descripcion, 
                         descripcionextranjera, 
                         nivel, 
                         ultimonivelflag, 
                         cadenarecursividad, 
                         orden, 
                         icono, 
                         estado, 
                         usuariocreacion, 
                         fechacreacion, 
                         usuariomodificacion, 
                         fechamodificacion, 
                         accion) 
            VALUES      ( @IdUnidadServicio, 
                          @CodigoUnidadServicio, 
                          @IdUnidadServicioPadre, 
                          @Descripcion, 
                          @DescripcionExtranjera, 
                          @Nivel, 
                          @UltimoNivelFlag, 
                          @CadenaRecursividad, 
                          @Orden, 
                          @Icono, 
                          @Estado, 
                          @UsuarioCreacion, 
                          Getdate(), 
                          @UsuarioModificacion, 
                          Getdate(), 
                          @Accion) 
            SELECT 1 
        END 
      ELSE IF @Accion = 'UPDATE' 
        BEGIN 
            UPDATE ss_hc_catalogounidadservicio 
            SET    idunidadservicio = @IdUnidadServicio, 
                   codigounidadservicio = @CodigoUnidadServicio, 
                   idunidadserviciopadre = @IdUnidadServicioPadre, 
                   descripcion = @Descripcion, 
                   descripcionextranjera = @DescripcionExtranjera, 
                   nivel = @Nivel, 
                   ultimonivelflag = @UltimoNivelFlag, 
                   cadenarecursividad = @CadenaRecursividad, 
                   orden = @Orden, 
                   icono = @Icono, 
                   estado = @Estado, 
                   usuariomodificacion = @UsuarioModificacion, 
                   fechamodificacion = Getdate(), 
                   accion = @Accion 
            WHERE  ( ss_hc_catalogounidadservicio.idunidadservicio = 
                     @IdUnidadServicio 
                   ) 

            SELECT 1 
        END 
      ELSE IF @Accion = 'DELETE' 
        BEGIN 
            DELETE FROM ss_hc_catalogounidadservicio 
            WHERE  ( ss_hc_catalogounidadservicio.idunidadservicio = 
                     @IdUnidadServicio 
                   ) 
            SELECT 1 
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   ss_hc_catalogounidadservicio 
                             WHERE  ( @Descripcion IS NULL OR Upper(ss_hc_catalogounidadservicio.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                            AND ( @Estado IS NULL OR ss_hc_catalogounidadservicio.estado = @Estado OR @Estado = 0 ) 
                            AND ( @CodigoUnidadServicio IS NULL OR Upper( ss_hc_catalogounidadservicio.codigounidadservicio) LIKE '%' + Upper(@CodigoUnidadServicio) + '%' )
                            AND ( @IdUnidadServicio IS NULL OR ss_hc_catalogounidadservicio.IdUnidadServicio = @IdUnidadServicio OR @IdUnidadServicio = 0 )) 
            SELECT @CONTADOR; 
        END 
  END 
/*    
EXEC SP_SS_HC_CatalogoUnidadServicio    
0,NULL, NULL, NULL, NULL,    
NULL,NULL, NULL, NULL, NULL, 
NULL,NULL, NULL, NULL, NULL,   
LISTARPAG    
*/ 


GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_CatalogoUnidadServicio_TipoAtencion]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================           
-- Author:    Grace Córdova           
-- Create date: 22/09/2015    
-- =============================================     
CREATE OR ALTER PROCEDURE [SP_SS_HC_CatalogoUnidadServicio_TipoAtencion]
@IdUnidadServicio		INT,
@IdTipoAtencion			INT,
@Descripcion			VARCHAR(200),
@DescripcionExtranjera	VARCHAR(200),
@Estado					INT,

@UsuarioCreacion		VARCHAR(25),
@FechaCreacion			DATETIME,
@UsuarioModificacion	VARCHAR(25),
@FechaModificacion		DATETIME,
@Accion                 VARCHAR(25) 
AS 
  BEGIN 
      IF not EXISTS(select 1 from SS_HC_CatalogoUnidadServicio_TipoAtencion where IdUnidadServicio=@IdUnidadServicio and  IdTipoAtencion=@IdTipoAtencion ) 
        BEGIN   
            INSERT INTO SS_HC_CatalogoUnidadServicio_TipoAtencion 
                        (	IdUnidadServicio,
							IdTipoAtencion,
							Descripcion,
							DescripcionExtranjera,
							Estado,
							UsuarioCreacion,
							FechaCreacion,
							UsuarioModificacion,
							FechaModificacion,
							Accion
							) 
            VALUES      (	@IdUnidadServicio,
							@IdTipoAtencion,
							@Descripcion,
							@DescripcionExtranjera,
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
        BEGIN
        SELECT 1
        END
       IF ( @Accion = 'UPDATE' ) 
        BEGIN 
            UPDATE	SS_HC_CatalogoUnidadServicio_TipoAtencion 
            SET		IdUnidadServicio=@IdUnidadServicio,
					IdTipoAtencion=@IdTipoAtencion,
					Descripcion=@Descripcion,
					DescripcionExtranjera=@DescripcionExtranjera,
					Estado=@Estado,
					UsuarioModificacion=@UsuarioModificacion,
					FechaModificacion=GETDATE(),
					Accion=@Accion
            WHERE  IdUnidadServicio = @IdUnidadServicio 
                   AND IdTipoAtencion = @IdTipoAtencion
            SELECT 1 
        END 
       IF ( @Accion = 'DELETE' ) 
        BEGIN 
            DELETE SS_HC_CatalogoUnidadServicio_TipoAtencion 
            WHERE  IdUnidadServicio = @IdUnidadServicio 
                   AND IdTipoAtencion = @IdTipoAtencion
            SELECT 1 
        END 
       IF ( @Accion = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_CatalogoUnidadServicio_TipoAtencion 
                             WHERE  ( @IdUnidadServicio IS NULL OR IdUnidadServicio = @IdUnidadServicio OR @IdUnidadServicio = 0 ) 
                                    AND ( @IdTipoAtencion IS NULL OR IdTipoAtencion = @IdTipoAtencion OR @IdTipoAtencion = 0 ) 
                                    AND ( @Descripcion IS NULL OR @Descripcion = '' OR Rtrim(Upper(SS_HC_CatalogoUnidadServicio_TipoAtencion.descripcion)) LIKE '%' + Rtrim(Upper(@Descripcion)) + '%' )
                                    )                                     
            SELECT @CONTADOR 
        END 
  END 
/*    
EXEC SP_SS_HC_CatalogoUnidadServicio_TipoAtencion   
NULL,NULL,NULL,NULL,NULL,    
NULL,NULL,NULL,NULL,'LISTARPAG'    
*/ 
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_CatalogoUnidadServicio_TipoAtencionListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================            
-- Author:    Grace Córdova            
-- Create date: 22/09/2015     
-- =============================================      
CREATE OR ALTER PROCEDURE [SP_SS_HC_CatalogoUnidadServicio_TipoAtencionListar] 
@IdUnidadServicio		INT,
@IdTipoAtencion			INT,
@Descripcion			VARCHAR(200),
@DescripcionExtranjera	VARCHAR(200),
@Estado					INT,

@UsuarioCreacion		VARCHAR(25),
@FechaCreacion			DATETIME,
@UsuarioModificacion	VARCHAR(25),
@FechaModificacion		DATETIME,
@Accion                 VARCHAR(25), 

@INICIO                 INT= NULL, 
@NUMEROFILAS            INT = NULL 
AS 
  BEGIN 
      IF ( @Accion = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SELECT @CONTADOR = Count(*) 
            FROM   SS_HC_CatalogoUnidadServicio_TipoAtencion 
            WHERE  ( @IdUnidadServicio IS NULL OR IdUnidadServicio = @IdUnidadServicio OR @IdUnidadServicio = 0 ) 
					AND ( @IdTipoAtencion IS NULL OR IdTipoAtencion = @IdTipoAtencion OR @IdTipoAtencion = 0 ) 
                    AND ( @Descripcion IS NULL OR @Descripcion = '' OR Rtrim(Upper(SS_HC_CatalogoUnidadServicio_TipoAtencion.descripcion)) LIKE '%' + Rtrim(Upper(@Descripcion)) + '%' ) 

            SELECT	IdUnidadServicio,
					IdTipoAtencion,
					Descripcion,
					DescripcionExtranjera,
					Estado,
					UsuarioCreacion,
					FechaCreacion,
					UsuarioModificacion,
					FechaModificacion,
					Accion					 
            FROM   (SELECT IdUnidadServicio,
							IdTipoAtencion,
							Descripcion,
							DescripcionExtranjera,
							Estado,
							UsuarioCreacion,
							FechaCreacion,
							UsuarioModificacion,
							FechaModificacion,
							Accion, 
							@CONTADOR                AS CONTADOR, 
							Row_number() 
                             OVER(ORDER BY IdUnidadServicio) AS ROWNUMBER 
                    FROM   SS_HC_CatalogoUnidadServicio_TipoAtencion 
                    WHERE  ( @IdUnidadServicio IS NULL OR IdUnidadServicio = @IdUnidadServicio OR @IdUnidadServicio = 0 ) 
							AND ( @IdTipoAtencion IS NULL OR IdTipoAtencion = @IdTipoAtencion OR @IdTipoAtencion = 0 ) 
							AND ( @Descripcion IS NULL OR @Descripcion = '' OR Rtrim(Upper(SS_HC_CatalogoUnidadServicio_TipoAtencion.descripcion)) LIKE '%' + Rtrim(Upper(@Descripcion)) + '%' )  )AS LISTADO 
            WHERE  ( @INICIO IS NULL AND @NUMEROFILAS IS NULL ) OR ( rownumber BETWEEN @INICIO AND @NUMEROFILAS ) 
        END 
      ELSE IF ( @Accion = 'LISTAR' ) 
        BEGIN 
            SELECT IdUnidadServicio,
					IdTipoAtencion,
					Descripcion,
					DescripcionExtranjera,
					Estado,
					UsuarioCreacion,
					FechaCreacion,
					UsuarioModificacion,
					FechaModificacion,
					Accion
            FROM   SS_HC_CatalogoUnidadServicio_TipoAtencion 
            WHERE  ( @IdUnidadServicio IS NULL OR IdUnidadServicio = @IdUnidadServicio OR @IdUnidadServicio = 0 ) 
					AND ( @IdTipoAtencion IS NULL OR IdTipoAtencion = @IdTipoAtencion OR @IdTipoAtencion = 0 ) 
					AND ( @Descripcion IS NULL OR @Descripcion = '' OR Rtrim(Upper(SS_HC_CatalogoUnidadServicio_TipoAtencion.descripcion)) LIKE '%' + Rtrim(Upper(@Descripcion)) + '%' )
        END 
  END 
/*    
EXEC SP_SS_HC_CatalogoUnidadServicio_TipoAtencionListar    
NULL,NULL,NULL,NULL,NULL,    
NULL,NULL,NULL,NULL,'LISTARPAG',
0,15    
*/ 
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_CatalogoUnidadServicioListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_CatalogoUnidadServicioListar]   
@IdUnidadServicio  INT ,   
@CodigoUnidadServicio VARCHAR(20),   
@IdUnidadServicioPadre INT ,   
@Descripcion   VARCHAR(200),   
@DescripcionExtranjera VARCHAR(200),    
@Nivel     INT ,   
@UltimoNivelFlag  CHAR(1),   
@CadenaRecursividad  VARCHAR(150),   
@Orden     INT ,   
@Icono     VARCHAR(100),     
@Estado     INT ,   
@UsuarioCreacion  VARCHAR(25),   
@FechaCreacion   DATETIME,   
@UsuarioModificacion VARCHAR(25),   
@FechaModificacion  DATETIME,     
@Accion     VARCHAR( 25),   
@INICIO     INT ,   
@NUMEROFILAS   INT   
AS   
  BEGIN   
      SET nocount ON;   
  
      DECLARE @CONTADOR INT   
  
      IF @Accion = 'LISTAR'   
        BEGIN   
            SELECT ss_hc_catalogounidadservicio.idunidadservicio,   
                   ss_hc_catalogounidadservicio.codigounidadservicio,   
                   ss_hc_catalogounidadservicio.idunidadserviciopadre,   
                   ss_hc_catalogounidadservicio.descripcion,   
                   ss_hc_catalogounidadservicio.descripcionextranjera,   
                   ss_hc_catalogounidadservicio.nivel,   
                   ss_hc_catalogounidadservicio.ultimonivelflag,   
                   ss_hc_catalogounidadservicio.cadenarecursividad,   
                   ss_hc_catalogounidadservicio.orden,   
                   ss_hc_catalogounidadservicio.icono,   
                   ss_hc_catalogounidadservicio.estado,   
                   ss_hc_catalogounidadservicio.usuariocreacion,   
                   ss_hc_catalogounidadservicio.fechacreacion,   
                   ss_hc_catalogounidadservicio.usuariomodificacion,   
                   ss_hc_catalogounidadservicio.fechamodificacion,   
                   ss_hc_catalogounidadservicio.Accion  
            FROM   ss_hc_catalogounidadservicio   
           WHERE  ( @Descripcion IS NULL OR Upper(ss_hc_catalogounidadservicio.descripcion) LIKE '%' + Upper(@Descripcion) + '%' )   
                            AND ( @Estado IS NULL OR ss_hc_catalogounidadservicio.estado = @Estado OR @Estado = 0 )   
                            AND ( @CodigoUnidadServicio IS NULL OR Upper( ss_hc_catalogounidadservicio.codigounidadservicio) LIKE '%' + Upper(@CodigoUnidadServicio) + '%' )  
                            AND ( @IdUnidadServicio IS NULL OR ss_hc_catalogounidadservicio.IdUnidadServicio = @IdUnidadServicio OR @IdUnidadServicio = 0 )  
                            AND ( @IdUnidadServicioPadre IS NULL OR ss_hc_catalogounidadservicio.IdUnidadServicioPadre = @IdUnidadServicioPadre OR @IdUnidadServicioPadre = 0 )  
        END   
      ELSE IF( @ACCION = 'LISTARPAG' )   
        BEGIN   
  
            SET @CONTADOR = (SELECT Count(*)   
                             FROM   ss_hc_catalogounidadservicio   
                             WHERE  ( @Descripcion IS NULL OR Upper(ss_hc_catalogounidadservicio.descripcion) LIKE '%' + Upper(@Descripcion) + '%' )   
                            AND ( @Estado IS NULL OR ss_hc_catalogounidadservicio.estado = @Estado OR @Estado = 0 )   
                            AND ( @CodigoUnidadServicio IS NULL OR Upper( ss_hc_catalogounidadservicio.codigounidadservicio) LIKE '%' + Upper(@CodigoUnidadServicio) + '%' )  
                            AND ( @IdUnidadServicio IS NULL OR ss_hc_catalogounidadservicio.IdUnidadServicio = @IdUnidadServicio OR @IdUnidadServicio = 0 ))   
              
     
            SELECT idunidadservicio,   
                   codigounidadservicio,   
                   idunidadserviciopadre,   
                   descripcion,   
                   descripcionextranjera,   
                   nivel,   
                   ultimonivelflag,   
                   cadenarecursividad,   
                   orden,   
                   icono,   
                   estado,   
                   usuariocreacion,   
                   fechacreacion,   
                   usuariomodificacion,   
                   fechamodificacion,   
                   accion   
            FROM   (SELECT idunidadservicio,   
                     codigounidadservicio,   
                           idunidadserviciopadre,   
                           descripcion,   
                           descripcionextranjera,   
                           nivel,   
                           ultimonivelflag,   
                           cadenarecursividad,   
                           orden,   
                           icono,   
                           estado,   
                           usuariocreacion,   
                           fechacreacion,   
                           usuariomodificacion,   
                           fechamodificacion,   
                           accion,   
                           @CONTADOR AS Contador,   
                           Row_number() OVER (ORDER BY idunidadservicio ASC ) AS RowNumber   
                    FROM   ss_hc_catalogounidadservicio   
                   WHERE  ( @Descripcion IS NULL OR Upper(descripcion) LIKE '%' + Upper(@Descripcion) + '%' )   
                            AND ( @Estado IS NULL OR estado = @Estado OR @Estado = 0 )   
                            AND ( @CodigoUnidadServicio IS NULL OR Upper( codigounidadservicio) LIKE '%' + Upper(@CodigoUnidadServicio) + '%' )  
                            AND ( @IdUnidadServicio IS NULL OR IdUnidadServicio = @IdUnidadServicio OR @IdUnidadServicio = 0 )  
                            )   
                   AS   
                   LISTADO   
            WHERE  ( @Inicio IS NULL AND @NumeroFilas IS NULL )   
                    OR rownumber BETWEEN @Inicio AND @NumeroFilas   
        END  
          
  END   
/*       
EXEC SP_SS_HC_CatalogoUnidadServicioListar       
0, NULL, NULL, NULL, NULL,      
NULL, NULL, NULL, NULL, NULL,      
NULL, NULL, NULL, NULL, NULL,    
'listarpag',0 ,15  
*/ 
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_CIAP2]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_CIAP2]
	@IdCIAP2 int,
	@IdCIAP2Padre int,
	@Codigo varchar (20),
	@RubricaCompleta varchar(500),
	@RubricaAbreviada varchar(100),
	@Nivel int,
	@Incluido varchar(500),
	@Excluido varchar(500),
	@Criterios varchar(500),
	@Consideraciones varchar(500),
	@Notas varchar(500),
	@CIE10 varchar(500),
	@IdComponente int,
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
 IF @Accion ='INSERT'  
  BEGIN  
  	SELECT @CONTADOR= isnull(MAX(IdCIAP2),0)+1 from SS_HC_CIAP2 
		SET @IdCIAP2 = @CONTADOR
		INSERT INTO SS_HC_CIAP2   
		(
		IdCIAP2,
		IdCIAP2Padre,
		Codigo,
		RubricaCompleta,
		RubricaAbreviada,
		Nivel,
		Incluido,
		Excluido,
		Criterios,
		Consideraciones,
		Notas,
		CIE10,
		IdComponente,
		Estado,
		UsuarioCreacion,
		FechaCreacion,
		UsuarioModificacion,
		FechaModificacion,
		Accion,
		Version)
		VALUES
		(
		@IdCIAP2,
		@IdCIAP2Padre,
		@Codigo,
		@RubricaCompleta,
		@RubricaAbreviada,
		@NiveL,
		@Incluido,
		@Excluido,
		@Criterios,
		@Consideraciones,
		@Notas,
		@CIE10,
		@IdComponente,
		@Estado,
		@UsuarioCreacion,
		GETDATE(),
		@UsuarioModificacion,
		GETDATE(),
		@Accion,
		@Version
		)
		select 1
		END
		ELSE
		IF @Accion='UPDATE'
		BEGIN
		UPDATE SS_HC_CIAP2
		SET 
		IdCIAP2Padre=@IdCIAP2Padre, Codigo=@Codigo,RubricaCompleta=@RubricaCompleta,
		RubricaAbreviada=@RubricaAbreviada,Nivel=@Nivel,Incluido=@Incluido,
		Excluido=@Excluido,Criterios=@Criterios,Consideraciones=@Consideraciones,
		Notas=@Notas,CIE10=@CIE10,IdComponente=@IdComponente,Estado=@Estado,
		UsuarioCreacion=@UsuarioCreacion,FechaCreacion=@FechaCreacion,
		FechaModificacion=GETDATE()/*,Accion = @Accion*/ , Version=@Version
		WHERE 
		(IdCIAP2 = @IdCIAP2) 
		select 1
		END
		ELSE
		IF(@ACCION = 'DELETE')
		BEGIN
		DELETE SS_HC_CIAP2
		WHERE 
		(IdCIAP2 = @IdCIAP2)
		select 1
	end
	else
	if(@ACCION = 'CONTARLISTARPAG')
	begin	 	
		SET @CONTADOR=(SELECT COUNT(IdCIAP2) FROM SS_HC_CIAP2
	 					WHERE 
					(@IdCIAP2 is null OR (IdCIAP2 = @IdCIAP2) or @IdCIAP2 =0)
					and (@IdCIAP2Padre is null OR IdCIAP2Padre = @IdCIAP2Padre)					
					and (@Estado is null OR Estado = @Estado)
					and (@Codigo is null  OR @Codigo =''  OR  upper(Codigo) like '%'+upper(@Codigo)+'%')
					)
		select @CONTADOR
	end
commit	
	
END	
			
		
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_CIAP2Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_CIAP2Listar]
	@IdCIAP2 int,
	@IdCIAP2Padre int,
	@Codigo varchar (20),
	@RubricaCompleta varchar(500),
	@RubricaAbreviada varchar(100),
	@Nivel int,
	@Incluido varchar(500),
	@Excluido varchar(500),
	@Criterios varchar(500),
	@Consideraciones varchar(500),
	@Notas varchar(500),
	@CIE10 varchar(500),
	@IdComponente int,
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
IF(@Accion = 'LISTARPAG')
	BEGIN
		DECLARE @CONTADOR INT
	
		SET @CONTADOR=(SELECT COUNT(IdCIAP2) FROM SS_HC_CIAP2
	 					WHERE 
					(@IdCIAP2 is null OR (IdCIAP2 = @IdCIAP2) or @IdCIAP2 =0)
					and (@IdCIAP2Padre is null OR IdCIAP2Padre = @IdCIAP2Padre)					
					and (@Estado is null OR Estado = @Estado)
					and (@Codigo is null  OR @Codigo =''  OR  upper(Codigo) like '%'+upper(@Codigo)+'%')
					)
		SELECT
			IdCIAP2,
			IdCIAP2Padre,
			Codigo,
			RubricaCompleta,
			RubricaAbreviada,
			Nivel,
			Incluido,
			Excluido,
			Criterios,
			Consideraciones,
			Notas,
			CIE10,
			IdComponente,
			Estado,
			UsuarioCreacion,
			FechaCreacion,
			UsuarioModificacion,
			FechaModificacion,
			Accion,
			Version
		FROM (		
			SELECT		
			IdCIAP2,
			IdCIAP2Padre,
			Codigo,
			RubricaCompleta,
			RubricaAbreviada,
			Nivel,
			Incluido,
			Excluido,
			Criterios,
			Consideraciones,
			Notas,
			CIE10,
			IdComponente,
			Estado,
			UsuarioCreacion,
			FechaCreacion,
			UsuarioModificacion,
			FechaModificacion,
			Accion,
			Version			
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY IdCIAP2 ASC ) AS RowNumber   	
					FROM SS_HC_CIAP2	
					WHERE 
						(@IdCIAP2 is null OR (IdCIAP2 = @IdCIAP2) or @IdCIAP2 =0)
					and (@IdCIAP2Padre is null OR IdCIAP2Padre = @IdCIAP2Padre)					
					and (@RubricaCompleta is null  OR @RubricaCompleta =''  OR  upper(RubricaCompleta) like '%'+upper(@RubricaCompleta)+'%')					
					and (@Estado is null OR Estado = @Estado)
					and (@Codigo is null  OR @Codigo =''  OR  upper(Codigo) like '%'+upper(@Codigo)+'%')	
 
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		
       END
       ELSE
	If @Accion = 'LISTAR'
	BEGIN
		SELECT
			IdCIAP2,
			IdCIAP2Padre,
			Codigo,
			RubricaCompleta,
			RubricaAbreviada,
			Nivel,
			Incluido,
			Excluido,
			Criterios,
			Consideraciones,
			Notas,
			CIE10,
			IdComponente,
			Estado,
			UsuarioCreacion,
			FechaCreacion,
			UsuarioModificacion,
			FechaModificacion,
			Accion,
			Version
				FROM SS_HC_CIAP2
					WHERE 
						(@IdCIAP2 is null OR (IdCIAP2 = @IdCIAP2) or @IdCIAP2 =0)
					and (@IdCIAP2Padre is null OR IdCIAP2Padre = @IdCIAP2Padre)					
					and (@RubricaCompleta is null  OR @RubricaCompleta =''  OR  upper(RubricaCompleta) like '%'+upper(@RubricaCompleta)+'%')					
					and (@Estado is null OR Estado = @Estado)	
					and (@Codigo is null  OR @Codigo =''  OR  upper(Codigo) like '%'+upper(@Codigo)+'%')
end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 
					*					
				from 
				SS_HC_CIAP2

					WHERE 
						(@IdCIAP2 is null OR (IdCIAP2 = @IdCIAP2) or @IdCIAP2 =0)

	end	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_ClasePAE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_ClasePAE]

	@IdClasePAE int ,
	@Descripcion varchar(150) ,
	@Estado	int ,
	@UsuarioCreacion varchar(25) ,
	@FechaCreacion datetime ,	
	@UsuarioModificacion varchar(25) ,
	@FechaModificacion datetime ,		
	@ACCION	varchar(30) 
			
AS 
  BEGIN 
      SET nocount ON; 

      IF @Accion = 'INSERT' 
        BEGIN 
            SELECT @IdClasePAE = Isnull(Max(IdClasePAE), 0) + 1 FROM   dbo.SS_HC_ClasePAE  
            INSERT INTO SS_HC_ClasePAE 
                        (IdClasePAE,                          
                         descripcion,                         
                         estado, 
                         usuariocreacion, 
                         fechacreacion, 
                         usuariomodificacion, 
                         fechamodificacion, 
                         accion 
                         ) 
            VALUES      ( @IdClasePAE,                            
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
            UPDATE SS_HC_ClasePAE 
            SET    IdClasePAE = @IdClasePAE,                    
                   descripcion = @Descripcion,                   
                   estado = @Estado, 
                   usuariomodificacion = @UsuarioModificacion, 
                   fechamodificacion = GETDATE(), 
                   accion = @Accion 
                   
            WHERE  ( SS_HC_ClasePAE.IdClasePAE = @IdClasePAE ) 

            SELECT 1 
        END 
      ELSE IF @Accion = 'DELETE' 
        BEGIN 
            DELETE FROM SS_HC_ClasePAE 
            WHERE  ( SS_HC_ClasePAE.IdClasePAE = @IdClasePAE ) 

            SELECT 1 
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_ClasePAE 
                             WHERE  ( @Descripcion IS NULL OR Upper(SS_HC_ClasePAE.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_ClasePAE.estado = @Estado OR @Estado = 0 )                                    
                                    AND ( @IdClasePAE IS NULL OR SS_HC_ClasePAE.IdClasePAE = @IdClasePAE OR @IdClasePAE = 0 )) 

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
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_ClasePAE_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_ClasePAE_LISTAR]
	@IdClasePAE int ,
	@Descripcion varchar(150) ,
	@Estado	int ,
	@UsuarioCreacion varchar(25) ,
	@FechaCreacion datetime ,	
	@UsuarioModificacion varchar(25) ,
	@FechaModificacion datetime ,
	@Inicio	int ,	
	@NumeroFilas	int ,	
	@Accion	varchar(25),
	@Version varchar(25)
			
AS 
  BEGIN 
      SET nocount ON; 

      DECLARE @CONTADOR INT 

      IF @Accion = 'LISTAR' 
        BEGIN 
            SELECT SS_HC_ClasePAE.IdClasePAE,                    
                   SS_HC_ClasePAE.descripcion, 
                   SS_HC_ClasePAE.Estado,                    
                   SS_HC_ClasePAE.usuariocreacion, 
                   SS_HC_ClasePAE.fechacreacion, 
                   SS_HC_ClasePAE.usuariomodificacion, 
                   SS_HC_ClasePAE.fechamodificacion, 
                   SS_HC_ClasePAE.accion, 
                   SS_HC_ClasePAE.version 
            FROM   SS_HC_ClasePAE 
             WHERE  ( @Descripcion IS NULL OR Upper(SS_HC_ClasePAE.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_ClasePAE.estado = @Estado OR @Estado = 0 )                                    
                                    AND ( @IdClasePAE IS NULL OR SS_HC_ClasePAE.IdClasePAE = @IdClasePAE OR @IdClasePAE = 0 )
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_ClasePAE 
                              WHERE  ( @Descripcion IS NULL OR Upper(SS_HC_ClasePAE.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_ClasePAE.estado = @Estado OR @Estado = 0 )                                    
                                    AND ( @IdClasePAE IS NULL OR SS_HC_ClasePAE.IdClasePAE = @IdClasePAE OR @IdClasePAE = 0 )) 

            SELECT IdClasePAE,                     
                   descripcion,                    
                   estado, 
                   usuariocreacion, 
                   fechacreacion, 
                   usuariomodificacion, 
                   fechamodificacion, 
                   accion, 
                   version 
            FROM   (SELECT SS_HC_ClasePAE.IdClasePAE,                            
                           SS_HC_ClasePAE.descripcion,                            
                           SS_HC_ClasePAE.estado, 
                           SS_HC_ClasePAE.usuariocreacion, 
                           SS_HC_ClasePAE.fechacreacion, 
                           SS_HC_ClasePAE.usuariomodificacion, 
                           SS_HC_ClasePAE.fechamodificacion, 
                           SS_HC_ClasePAE.accion, 
                           SS_HC_ClasePAE.version, 
                           @CONTADOR                                  
                           AS 
                           Contador, 
                           Row_number() 
                             OVER ( 
                               ORDER BY SS_HC_ClasePAE.IdClasePAE ASC ) 
                               AS 
                           RowNumber 
                    FROM   SS_HC_ClasePAE 
                     WHERE  ( @Descripcion IS NULL OR Upper(SS_HC_ClasePAE.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_ClasePAE.estado = @Estado OR @Estado = 0 )                                     
                                    AND ( @IdClasePAE IS NULL OR SS_HC_ClasePAE.IdClasePAE = @IdClasePAE OR @IdClasePAE = 0 )) 
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
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_companyowner]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_companyowner]
(
	@companyowner	varchar(8) ,
	@description	varchar(40) ,
	@englishdescription	char(40) ,
	@percentage	real ,
	@company	varchar(15) ,
	@owner	char(2) ,
	@ChangeRate	real ,
	@lastuser	char(10) ,
	@lastdate	datetime ,		
	@ACCION	varchar(30) 			
)


AS
BEGIN 
SET NOCOUNT ON;
BEGIN  TRANSACTION

	DECLARE @CONTADOR INT
	
	if(@ACCION = 'INSERT')
	begin		 		 
			
		insert into companyowner
		(
			companyowner
			,description
			,englishdescription
			,percentage
			,company
			,owner
			,ChangeRate
			,lastuser
			,lastdate

		)
		values(
			@companyowner
		,	@description
		,	@englishdescription
		,	@percentage
		,	@company
		,	@owner
		,	@ChangeRate
		,	@lastuser
		,	@lastdate

	
		)
		
		select 1
	end	
	else
	if(@ACCION = 'UPDATE')
	begin			
		select 1
	end	
	else
	if(@ACCION = 'DELETE')
	begin
		select 1
	end
	else
	if(@ACCION = 'LISTARPAG')
	begin	 	
		SET @CONTADOR=(SELECT COUNT(companyowner) FROM companyowner
	 					WHERE 
					(@companyowner is null OR (rtrim(upper(companyowner)) like '%'+rtrim(upper(@companyowner))+'%') or @companyowner = '')

					and (@description is null  OR @description =''  OR  rtrim(upper(description)) like '%'+rtrim(upper(@description))+'%')
					)
		select @CONTADOR
	end
commit	
	
END	
/*
exec [SP_SS_HC_companyowner]

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
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_companyowner_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_companyowner_LISTAR]
(
	@companyowner	char(8) ,
	@description	char(40) ,
	@englishdescription	char(40) ,
	@percentage	real ,
	@company	varchar(15) ,
	
	@owner	char(2) ,
	@ChangeRate	real ,
	@lastuser	char(10) ,
	@lastdate	datetime ,
	
	@Inicio	int ,	
	@NumeroFilas	int ,	
	@ACCION	varchar(25) 
			
)

AS
BEGIN
	if(@ACCION = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR=(SELECT COUNT(companyowner) FROM companyowner
	 					WHERE 
					(@companyowner is null OR (rtrim(upper(companyowner)) like '%'+rtrim(upper(@companyowner))+'%') or @companyowner = '')

					and (@description is null  OR @description =''  OR  rtrim(upper(description)) like '%'+rtrim(upper(@description))+'%')
					)
	 
		SELECT 
			companyowner as companyowner1
			,description
			,englishdescription
			,percentage
			,company
			,owner
			,ChangeRate
			,lastuser
			,lastdate
			,ACCION	
		FROM (
				SELECT 
					companyowner.*
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY companyowner ASC ) AS RowNumber   					
				from 
				companyowner	 				
	 					WHERE 
					(@companyowner is null OR (rtrim(upper(companyowner)) like '%'+rtrim(upper(@companyowner))+'%') or @companyowner = '')

					and (@description is null  OR @description =''  OR  rtrim(upper(description)) like '%'+rtrim(upper(@description))+'%')
	
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
	end
	else
	if(@ACCION = 'LISTAR')
	begin
	 
				SELECT 
				companyowner as companyowner1
				,description
				,englishdescription
				,percentage
				,company
				,owner
				,ChangeRate
				,lastuser
				,lastdate
				,ACCION					
				from 
				companyowner	 				
	 					WHERE 
					(@companyowner is null OR (companyowner = @companyowner) or @companyowner = '')

					and (@description is null  OR @description =''  OR  upper(description) like '%'+upper(@description)+'%')
					
						

	end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
			SELECT 
				companyowner as companyowner1
				,description
				,englishdescription
				,percentage
				,company
				,owner
				,ChangeRate
				,lastuser
				,lastdate
				,ACCION					
				from 
				companyowner	 				
	 					WHERE 
					companyowner = @companyowner
					
	end	
	

END
/*
exec [SP_SS_HC_companyowner_LISTAR]

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
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_ControlAtributo]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_ControlAtributo]
@IdAtributo INT,
@Nombre VARCHAR(200),
@Estado INT,
@UsuarioCreacion VARCHAR(25),
@FechaCreacion DATETIME,
@UsuarioModificacion VARCHAR(25),
@FechaModificacion DATETIME,
@Accion VARCHAR(25),
@Version VARCHAR(25)

AS  
BEGIN   
SET NOCOUNT ON;  
BEGIN  TRANSACTION  
  
 DECLARE @CONTADOR INT  
 	IF(@Accion = 'CONTARLISTAPAG')
	BEGIN		
		
		 SET @CONTADOR=(SELECT COUNT(IdAtributo) FROM SS_HC_ControlAtributo
	 					WHERE 
						(@IdAtributo is null OR (IdAtributo = @IdAtributo) or @IdAtributo =0)
					and (@Nombre is null  OR @Nombre =''  OR  upper(Nombre) like '%'+upper(@Nombre)+'%')
					and (@Estado is null OR (Estado = @Estado) or @Estado =0)
					)
					
		select @CONTADOR
	end
commit	 
END  
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_ControlAtributo_Lista]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_ControlAtributo_Lista]
@IdAtributo INT,
@Nombre VARCHAR(200),
@Estado INT,
@UsuarioCreacion VARCHAR(25),
@FechaCreacion DATETIME,
@UsuarioModificacion VARCHAR(25),
@FechaModificacion DATETIME,
@Accion VARCHAR(25),
@Version VARCHAR(25),
            
@INICIO   int= null,  
@NUMEROFILAS int = null 
AS
BEGIN    
IF(@Accion = 'LISTARPAG')
	BEGIN
		 DECLARE @CONTADOR INT
		 SET @CONTADOR=(SELECT COUNT(IdAtributo) FROM SS_HC_ControlAtributo
	 					WHERE 
						(@IdAtributo is null OR (IdAtributo = @IdAtributo) or @IdAtributo =0)
					and (@Nombre is null  OR @Nombre =''  OR  upper(Nombre) like '%'+upper(@Nombre)+'%')
					and (@Estado is null OR (Estado = @Estado) or @Estado =0)
					)
					
		SELECT
				IdAtributo,
				Nombre,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version
		FROM (		
			SELECT
				IdAtributo,
				Nombre,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY IdAtributo ASC ) AS RowNumber   	
					FROM SS_HC_ControlAtributo	
					WHERE 
						(@IdAtributo is null OR (IdAtributo = @IdAtributo) or @IdAtributo =0)
					and (@Nombre is null  OR @Nombre =''  OR  upper(Nombre) like '%'+upper(@Nombre)+'%')
					and (@Estado is null OR (Estado = @Estado) or @Estado =0)
   	
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		
       END
       ELSE
  IF @Accion ='LISTAR'    
    BEGIN    
		SELECT
				IdAtributo,
				Nombre,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version
				FROM SS_HC_ControlAtributo	
				WHERE 
						(@IdAtributo is null OR (IdAtributo = @IdAtributo) or @IdAtributo =0)
					and (@Nombre is null  OR @Nombre =''  OR  upper(Nombre) like '%'+upper(@Nombre)+'%')
					and (@Estado is null OR (Estado = @Estado) or @Estado =0)	
	end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 
					*					
				from 
				SS_HC_ControlAtributo

					WHERE 
						(@IdAtributo = IdAtributo)
		
END	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_ControlComponente]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_ControlComponente]
@IdComponente INT,
@Nombre VARCHAR(200),
@Tipo VARCHAR(200),
@Estado INT,
@UsuarioCreacion VARCHAR(25),
@FechaCreacion DATETIME,
@UsuarioModificacion VARCHAR(25),
@FechaModificacion DATETIME,
@Accion VARCHAR(25),
@Version VARCHAR(25)

AS  
BEGIN   
SET NOCOUNT ON;  
BEGIN  TRANSACTION  
  
 DECLARE @CONTADOR INT  
 	IF(@Accion = 'CONTARLISTAPAG')
	BEGIN		
		 SET @CONTADOR=(SELECT COUNT(IdComponente) FROM SS_HC_ControlComponente
	 					WHERE 
						(@IdComponente is null OR (IdComponente = @IdComponente) or @IdComponente =0)
					and (@Nombre is null  OR @Nombre =''  OR  upper(Nombre) like '%'+upper(@Nombre)+'%')
					and (@Estado is null OR (Estado = @Estado) or @Estado =0)
					)
					
		select @CONTADOR
	end
commit	 
END  
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_ControlComponente_Lista]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_ControlComponente_Lista]
@IdComponente INT,
@Nombre VARCHAR(200),
@Tipo VARCHAR(200),
@Estado INT,
@UsuarioCreacion VARCHAR(25),
@FechaCreacion DATETIME,
@UsuarioModificacion VARCHAR(25),
@FechaModificacion DATETIME,
@Accion VARCHAR(25),
@Version VARCHAR(25),
            
@INICIO   int= null,  
@NUMEROFILAS int = null 
AS
BEGIN    
IF(@Accion = 'LISTARPAG')
	BEGIN
		 DECLARE @CONTADOR INT
		 SET @CONTADOR=(SELECT COUNT(IdComponente) FROM SS_HC_ControlComponente
	 					WHERE 
						(@IdComponente is null OR (IdComponente = @IdComponente) or @IdComponente =0)
					and (@Nombre is null  OR @Nombre =''  OR  upper(Nombre) like '%'+upper(@Nombre)+'%')
					and (@Estado is null OR (Estado = @Estado) or @Estado =0)
					)
					
		SELECT
				IdComponente,
				Nombre,
				Tipo,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version
		FROM (		
			SELECT
				IdComponente,
				Nombre,
				Tipo,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY IdComponente ASC ) AS RowNumber   	
					FROM SS_HC_ControlComponente
					WHERE 
						(@IdComponente is null OR (IdComponente = @IdComponente) or @IdComponente =0)
					and (@Nombre is null  OR @Nombre =''  OR  upper(Nombre) like '%'+upper(@Nombre)+'%')
					and (@Estado is null OR (Estado = @Estado) or @Estado =0)
   	
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		
       END
       ELSE
  IF @Accion ='LISTAR'    
    BEGIN    
		SELECT
				IdComponente,
				Nombre,
				Tipo,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version
				FROM SS_HC_ControlComponente	
				WHERE 
						(@IdComponente is null OR (IdComponente = @IdComponente) or @IdComponente =0)
					and (@Nombre is null  OR @Nombre =''  OR  upper(Nombre) like '%'+upper(@Nombre)+'%')
					and (@Estado is null OR (Estado = @Estado) or @Estado =0)	
	end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 
					*					
				from 
				SS_HC_ControlComponente

					WHERE 
						(@IdComponente = IdComponente)
		
END	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_ControlValidacion]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_ControlValidacion]
			@IdFormato int,
            @SecuenciaCampo int,
            @SecuenciaValidacion int,
            @IdComponente int,
            @IdAtributo int,
            @Idioma varchar(20),
            @TipoValidacion varchar(10),
            @FlagTipoDato varchar(1),
            @ValorTexto varchar(200),
            @ValorNumerico numeric(10,2),
            @ValorDate datetime,
            @SecuenciaValidacionRef int,
            @Estado int,
            @UsuarioCreacion varchar(25),
            @FechaCreacion datetime,
            @UsuarioModificacion varchar(25),
            @FechaModificacion datetime,
            @Accion varchar(25),
            @Version varchar(25),
            @IdSeccionFormato int		
            
AS  
BEGIN   
SET NOCOUNT ON;  
BEGIN  TRANSACTION  
  
 DECLARE @CONTADOR INT  
 IF(@Accion = 'INSERT')  
 BEGIN   
 		select @CONTADOR= isnull(MAX(SecuenciaValidacion),0)+1 from SS_HC_ControlValidacion where IdFormato=@IdFormato
		set @SecuenciaValidacion= @CONTADOR
		
  INSERT INTO SS_HC_ControlValidacion  
  (  
				IdFormato,
				SecuenciaCampo,
				SecuenciaValidacion,
				IdComponente,
				IdAtributo,
				Idioma,
				TipoValidacion,
				FlagTipoDato,
				ValorTexto,
				ValorNumerico,
				ValorDate,
				SecuenciaValidacionRef,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version,
				IdSeccionFormato
  )  
    VALUES  
  (   
				@IdFormato,
				@SecuenciaCampo,
				@SecuenciaValidacion,
				@IdComponente,
				@IdAtributo,
				@Idioma,
				@TipoValidacion,
				@FlagTipoDato,
				@ValorTexto,
				@ValorNumerico,
				@ValorDate,
				@SecuenciaValidacionRef,
				@Estado,
				@UsuarioCreacion,
				GETDATE(),
				@UsuarioModificacion,
				GETDATE(),
				@Accion,
				@Version,
				@IdSeccionFormato
  )  
  
 SELECT 1		 
 END   
 ELSE  
 IF(@Accion = 'UPDATE')  
 BEGIN  
 UPDATE SS_HC_ControlValidacion  
  SET     
				IdFormato=@IdFormato,
				SecuenciaCampo=@SecuenciaCampo,
				SecuenciaValidacion=@SecuenciaValidacion,
				IdComponente=@IdComponente,
				IdAtributo=@IdAtributo,
				Idioma=@Idioma,
				TipoValidacion=@TipoValidacion,
				FlagTipoDato=@FlagTipoDato,
				ValorTexto=@ValorTexto,
				ValorNumerico=@ValorNumerico,
				ValorDate=@ValorDate,
				SecuenciaValidacionRef=@SecuenciaValidacionRef,
				Estado=@Estado,
				UsuarioModificacion=@UsuarioModificacion,
				FechaModificacion=GETDATE(),
				Accion=@Accion,
				Version=@Version,
				IdSeccionFormato=@IdSeccionFormato
		WHERE 
						(@IdFormato is null OR (IdFormato = @IdFormato) or @IdFormato =0)
					and	(@SecuenciaCampo is null OR (SecuenciaCampo = @SecuenciaCampo) or @SecuenciaCampo =0)
					and	(@SecuenciaValidacion is null OR (SecuenciaValidacion = @SecuenciaValidacion) or @SecuenciaValidacion =0)
   		select 1
 end   
 else  
 if(@Accion = 'DELETE')  
 begin  
  delete SS_HC_ControlValidacion  
		WHERE 
						(@IdFormato is null OR (IdFormato = @IdFormato) or @IdFormato =0)
					and	(@SecuenciaCampo is null OR (SecuenciaCampo = @SecuenciaCampo) or @SecuenciaCampo =0)
					and	(@SecuenciaValidacion is null OR (SecuenciaValidacion = @SecuenciaValidacion) or @SecuenciaValidacion =0)
   		select 1
end
		if(@Accion = 'CONTARLISTAPAG')
	begin		
		
		SET @CONTADOR=(SELECT COUNT(SecuenciaValidacion) FROM SS_HC_ControlValidacion
	 					WHERE 
						(@IdFormato is null OR (IdFormato = @IdFormato) or @IdFormato =0)
					and	(@SecuenciaCampo is null OR (SecuenciaCampo = @SecuenciaCampo) or @SecuenciaCampo =0)
					and	(@SecuenciaValidacion is null OR (SecuenciaValidacion = @SecuenciaValidacion) or @SecuenciaValidacion =0)
					)
					
		select @CONTADOR
	end
commit	 
END  
 
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_ControlValidacion_Lista]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_ControlValidacion_Lista]
			@IdFormato int,
            @SecuenciaCampo int,
            @SecuenciaValidacion int,
            @IdComponente int,
            @IdAtributo int,
            @Idioma varchar(20),
            @TipoValidacion varchar(10),
            @FlagTipoDato varchar(1),
            @ValorTexto varchar(200),
            @ValorNumerico numeric(10,2),
            @ValorDate datetime,
            @SecuenciaValidacionRef int,
            @Estado int,
            @UsuarioCreacion varchar(25),
            @FechaCreacion datetime,
            @UsuarioModificacion varchar(25),
            @FechaModificacion datetime,
            @Accion varchar(25),
            @Version varchar(25),
            @IdSeccionFormato int,
            
			@INICIO   int= null,  
			@NUMEROFILAS int = null   
AS
BEGIN    
IF(@Accion = 'LISTARPAG')
	BEGIN
		 DECLARE @CONTADOR INT
		 SET @CONTADOR=(SELECT COUNT(SecuenciaValidacion) FROM SS_HC_ControlValidacion
	 					WHERE 
						(@IdFormato is null OR (IdFormato = @IdFormato) or @IdFormato =0)
					and	(@SecuenciaCampo is null OR (SecuenciaCampo = @SecuenciaCampo) or @SecuenciaCampo =0)
					and	(@SecuenciaValidacion is null OR (SecuenciaValidacion = @SecuenciaValidacion) or @SecuenciaValidacion =0)
					)
					
		SELECT
				convert(int,ROW_NUMBER() OVER (ORDER BY IdFormato ASC )) as IdFormato,
				SecuenciaCampo,
				SecuenciaValidacion,
				IdComponente,
				IdAtributo,
				Idioma,
				TipoValidacion,
				FlagTipoDato,
				ValorTexto,
				ValorNumerico,
				ValorDate,
				SecuenciaValidacionRef,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				convert(varchar,IdFormato) as Version,
				IdSeccionFormato
		FROM (		
			SELECT
				IdFormato,
				SecuenciaCampo,
				SecuenciaValidacion,
				IdComponente,
				IdAtributo,
				Idioma,
				TipoValidacion,
				FlagTipoDato,
				ValorTexto,
				ValorNumerico,
				ValorDate,
				SecuenciaValidacionRef,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version,
				IdSeccionFormato
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY SecuenciaValidacion ASC ) AS RowNumber   	
					FROM SS_HC_ControlValidacion	
					WHERE 
						(@IdFormato is null OR (IdFormato = @IdFormato) or @IdFormato =0)
					and	(@SecuenciaCampo is null OR (SecuenciaCampo = @SecuenciaCampo) or @SecuenciaCampo =0)
					and	(@SecuenciaValidacion is null OR (SecuenciaValidacion = @SecuenciaValidacion) or @SecuenciaValidacion =0)
   	
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		
       END
       ELSE
  IF @Accion ='LISTAR'    
    BEGIN    
		SELECT
				IdFormato,
				SecuenciaCampo,
				SecuenciaValidacion,
				IdComponente,
				IdAtributo,
				Idioma,
				TipoValidacion,
				FlagTipoDato,
				ValorTexto,
				ValorNumerico,
				ValorDate,
				SecuenciaValidacionRef,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version,
				IdSeccionFormato
				FROM SS_HC_ControlValidacion	
				WHERE 
						(@IdFormato is null OR (IdFormato = @IdFormato) or @IdFormato =0)
					and	(@SecuenciaCampo is null OR (SecuenciaCampo = @SecuenciaCampo) or @SecuenciaCampo =0)
					and	(@SecuenciaValidacion is null OR (SecuenciaValidacion = @SecuenciaValidacion) or @SecuenciaValidacion =0)
   	
	end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 
					*					
				from 
				SS_HC_ControlValidacion

					WHERE 
						(@IdFormato is null OR (IdFormato = @IdFormato) or @IdFormato =0)
					and	(@SecuenciaCampo is null OR (SecuenciaCampo = @SecuenciaCampo) or @SecuenciaCampo =0)
					and	(@SecuenciaValidacion is null OR (SecuenciaValidacion = @SecuenciaValidacion) or @SecuenciaValidacion =0)
   	
		
END	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Copiar_EpisodioAtencion]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_Copiar_EpisodioAtencion]
(
	@UnidadReplicacion	char(4) ,
	@IdPaciente	int ,
	@EpisodioClinico	int ,
	@IdEpisodioAtencion	bigint ,
	@UnidadReplicacionEC	char(4) ,			
	@IdOpcion	int ,
	@IdFormato	int ,
	@CodigoFormato	varchar(25) ,	
	@FechaRegistro	datetime ,
	@UsuarioCreacion	varchar(30) ,	
	@ACCION	varchar(30) 			
)

AS
BEGIN 
SET NOCOUNT ON;

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
	  TipoOpcion	varchar(1) null,		
		IdFormato		int null,
		CodigoFormato		varchar(25) null
	 )  
	 
	 DECLARE @TABLA_OPCIONESAGENTE_PROCESO table       
	 (      
	  SECUENCIA   int  NOT NULL   IDENTITY PRIMARY KEY,      
	  IdFormato		int null,
	  CodigoFormato		varchar(25) null
	 )
	 
	declare @UnidadReplicacionCopy	char(4) 
	declare @IdEpisodioAtencionCopy	bigint
	declare @EpisodioClinicoCopy	int
	declare @IdPacienteCopy	int 	
	declare @CodigoFormatoAux varchar(25)=0
	----------	 	  
 	declare @cuenta int =1
 	declare @Total int =0
    declare @IdAgenteMax int =0
 	---------------
	DECLARE @IDSECUENCIA_AUX INT
	declare @IdAgente int;

	if(@ACCION = 'FORM_COMPARTIDOS')
	begin
			/*****************************************************************/
			/**  AGREGACIONES PARA AGREGAR LOS DATOS DE LOS FORMULARIOS COMPARTIDOS A LA NUEVA ATENCIÓN  **/
			/*****************************************************************/
			select @IdAgente = IdAgente from  dbo.SG_Agente where CodigoAgente = @UsuarioCreacion
						

			/** 1 .- CARGAR TABLA TEMPORAL CON LAS OPCIONES Y LOS PERFILES VALIDOS**/
			
			---CARGAR AGENTES USUARIOS
			insert into @TABLA_OPCIONESAGENTE_VALIDAS					
			(idAgente,TipoAgente,idOpcion,ESTADOAGENTE,INDICADOR,orden,NivelOpcion,TipoOpcion
				,IdFormato,CodigoFormato				
				)
				select IdAgente,TipoAgente,IdOpcion,EstadoAgente,'VALIDO',0 ,NivelOpcion,TipoOpcion
				,IdFormato,CodigoFormato
				from
				(
					select  
					seg.IdAgente,
					seg.TipoAgente,
					seg.NombreAgente,IdOpcion,seg.EstadoAgente,
					seg.NivelOpcion,seg.TipoOpcion, 
					--
					seg.IdFormato,seg.CodigoFormato
					from SS_CHE_VistaSeguridad as seg						 						 
					where
						--IdOpcionPadre = @IdOpcionPadre  and
						--seg.IdOpcion in (3207,3208,3209,3210,3211) and						
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
			(idAgente,TipoAgente,idOpcion,ESTADOAGENTE,INDICADOR,orden,NivelOpcion,TipoOpcion
				,IdFormato,CodigoFormato
				)
				select IdAgente,TipoAgente,IdOpcion,EstadoAgente,'NO VALIDO',
				ROW_NUMBER() OVER (ORDER BY IdOpcion ASC ) AS RowNumber ,
				NivelOpcion,TipoOpcion
				,IdFormato,CodigoFormato
				from
				(
					select  
					seg.IdAgente,
					seg.TipoAgente,
					seg.NombreAgente,IdOpcion,seg.EstadoAgente,
					seg.NivelOpcion,seg.TipoOpcion
					--
					,seg.IdFormato,seg.CodigoFormato					
					--ROW_NUMBER() OVER (ORDER BY IdOpcion ASC ) AS RowNumber   			
					from SS_CHE_VistaSeguridad as seg						 						 
					where
						--IdOpcionPadre = @IdOpcionPadre  and
						--seg.IdOpcion in (3207,3208,3209,3210,3211) and						
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
			
		/** 2 .- OBTENER SOLO LOS FORMATOS COMPARTIDOS**/
			insert into @TABLA_OPCIONESAGENTE_PROCESO					
			(IdFormato,CodigoFormato)						
			select distinct OPCIONES_AGENTE.IdFormato,
					OPCIONES_AGENTE.CodigoFormato from @TABLA_OPCIONESAGENTE_VALIDAS  OPCIONES_AGENTE
			inner join SS_HC_Formato on
				 (OPCIONES_AGENTE.IdFormato =SS_HC_Formato.IdFormato 
					and SS_HC_Formato.IndCompartido = 2 --OBS: SE DEFINIO EL VALOR 2 PARA EL TIPO DE FORM. COMPARTIDO
					)				
			where SS_HC_Formato.CodigoFormato is not null

		
			select @Total= COUNT(*) from @TABLA_OPCIONESAGENTE_PROCESO
					
			set @cuenta  =1		
									
			while(@cuenta <= @Total)
			begin					
				select @CodigoFormatoAux = CodigoFormato from @TABLA_OPCIONESAGENTE_PROCESO
				where SECUENCIA = @cuenta
				--COMENZAR
				set @CodigoFormato = 	@CodigoFormatoAux								
				/******************** COPIAR LOS FORMATOS COMPARTIDOS *********************/
				/************************************************************
					se debe desarrollar el caso para cada formulario (POR CÓDIGO DE FORMATO)
				************************************************************/
				
				--NOTA: SE DECICIÓ OBTENER EL ÚLTIMO REGISTRO CREADO, NO MODIFICADO.					  		
				IF(@CodigoFormato = 'CCEP0003')
				BEGIN			  		
					--1.- OBTENER EL ID PARA EL REGSITRO DEL FORMULARIO
					set @IdEpisodioAtencionCopy = null;
						select top 1 
							@UnidadReplicacionCopy = UnidadReplicacion ,
							@EpisodioClinicoCopy = EpisodioClinico ,
							@IdEpisodioAtencionCopy = IdEpisodioAtencion ,
							@IdPacienteCopy = IdPaciente 
						
						from SS_HC_EpisodioAtencion
						where
							UnidadReplicacion = @UnidadReplicacion
							AND IdPaciente = @IdPaciente
							AND FechaCreacion is not null
							AND IdEpisodioAtencion not IN 
							(select NUEVA.IdEpisodioAtencion
								from SS_HC_EpisodioAtencion as NUEVA where
									NUEVA.UnidadReplicacion = @UnidadReplicacion
									AND NUEVA.IdPaciente = @IdPaciente
									AND NUEVA.EpisodioClinico = @EpisodioClinico
									AND NUEVA.IdEpisodioAtencion = @IdEpisodioAtencion							
							)

						order by FechaCreacion desc					
										
						  		
					if(@IdEpisodioAtencionCopy is not null)	
					begin
						
						--2.- REGISTRAR LOS DATOS	
						insert into	SS_HC_Anamnesis_EA
						select 
							@UnidadReplicacion
							  ,@IdEpisodioAtencion
							  ,@IdPaciente
							  ,@EpisodioClinico
							  ,IdFormaInicio				  
							  ,IdCursoEnfermedad
							  ,TiempoEnfermedad
							  ,RelatoCronologico
							  ,Apetito
							  ,Sed
							  ,Orina
							  ,Deposiciones
							  ,Sueno
							  ,PesoAnterior
							  ,Infancia
							  ,EvaluacionAlimentacionActual
							  ,Estado
							  ,@UsuarioCreacion
							  ,getDate()
							  ,@UsuarioCreacion
							  ,getDate()
							  ,Accion
							  ,Version
							  ,MotivoConsulta
							  ,ComentarioAdicional
							  ,Prioridad
						from SS_HC_Anamnesis_EA 
						where
							UnidadReplicacion = @UnidadReplicacionCopy
							AND EpisodioClinico  = @EpisodioClinicoCopy
							AND IdEpisodioAtencion = @IdEpisodioAtencionCopy
							AND IdPaciente = @IdPacienteCopy
							
						----------------------------
						select @IDSECUENCIA_AUX = ISNULL(max(Secuencia),0)+1 
						  from dbo.SS_HC_Anamnesis_EA_Sintoma 			  
						  where UnidadReplicacion = @UnidadReplicacion 
						  and EpisodioClinico =@EpisodioClinico
						  and IdPaciente = @IdPaciente 
						----------------------------
						insert into	SS_HC_Anamnesis_EA_Sintoma						
						select 
							@UnidadReplicacion
							  ,@IdEpisodioAtencion
							  ,@IdPaciente
							  ,@EpisodioClinico
						,Secuencia
						,IdCIAP2
						,Accion
						,Version						
						from SS_HC_Anamnesis_EA_Sintoma 
						where
							UnidadReplicacion = @UnidadReplicacionCopy
							AND EpisodioClinico  = @EpisodioClinicoCopy
							AND IdEpisodioAtencion = @IdEpisodioAtencionCopy
							AND IdPaciente = @IdPacienteCopy
	
					end													
				END
				ELSE IF(@CodigoFormato = 'CCEP0005')
				BEGIN			  		
					--1.- OBTENER EL ID PARA EL REGSITRO DEL FORMULARIO
					set @IdEpisodioAtencionCopy = null;
						select top 1 
							@UnidadReplicacionCopy = UnidadReplicacion ,
							@EpisodioClinicoCopy = EpisodioClinico ,
							@IdEpisodioAtencionCopy = IdEpisodioAtencion ,
							@IdPacienteCopy = IdPaciente 
						
						from SS_HC_EpisodioAtencion
						where
							UnidadReplicacion = @UnidadReplicacion
							AND IdPaciente = @IdPaciente
							AND FechaCreacion is not null
							AND IdEpisodioAtencion not IN 
							(select NUEVA.IdEpisodioAtencion
								from SS_HC_EpisodioAtencion as NUEVA where
									NUEVA.UnidadReplicacion = @UnidadReplicacion
									AND NUEVA.IdPaciente = @IdPaciente
									AND NUEVA.EpisodioClinico = @EpisodioClinico
									AND NUEVA.IdEpisodioAtencion = @IdEpisodioAtencion							
							)

						order by FechaCreacion desc					
										
						  		
					if(@IdEpisodioAtencionCopy is not null)	
					begin
						
						--2.- REGISTRAR LOS DATOS	
						insert into	SS_HC_Anamnesis_AF
						select 
							@UnidadReplicacion
							  ,@IdEpisodioAtencion
							  ,@IdPaciente
							  ,@EpisodioClinico
							  ,IdTipoParentesco				  
							  ,Edad
							  ,IdVivo
							  ,Estado
							  ,@UsuarioCreacion
							  ,getDate()
							  ,@UsuarioCreacion
							  ,getDate()
							  ,Accion
							  ,Version								  
						from SS_HC_Anamnesis_AF 
						where
							UnidadReplicacion = @UnidadReplicacionCopy
							AND EpisodioClinico  = @EpisodioClinicoCopy
							AND IdEpisodioAtencion = @IdEpisodioAtencionCopy
							AND IdPaciente = @IdPacienteCopy
							
						----------------------------
						select @IDSECUENCIA_AUX = ISNULL(max(Secuencia),0)+1 
						  from dbo.SS_HC_Anamnesis_EA_Sintoma 			  
						  where UnidadReplicacion = @UnidadReplicacion 
						  and EpisodioClinico =@EpisodioClinico
						  and IdPaciente = @IdPaciente 
						----------------------------
						insert into	SS_HC_Anamnesis_AF_Enfermedad						
						select 
							@UnidadReplicacion
							  ,@IdEpisodioAtencion
							  ,@IdPaciente
							  ,@EpisodioClinico
						,Secuencia
						--,ROW_NUMBER() OVER (ORDER BY IdOpcion ASC ) AS RowNumber 
						,IdDiagnostico
						,Accion
						,Version						
						from SS_HC_Anamnesis_AF_Enfermedad 
						where
							UnidadReplicacion = @UnidadReplicacionCopy
							AND EpisodioClinico  = @EpisodioClinicoCopy
							AND IdEpisodioAtencion = @IdEpisodioAtencionCopy
							AND IdPaciente = @IdPacienteCopy

					end													
				END
				ELSE
				IF(@CodigoFormato = 'CCEP0004')
				BEGIN
					set @Total =1
				END
				ELSE
				IF(@CodigoFormato = 'CCEP0055')
				BEGIN
				--1.- OBTENER EL ID PARA EL REGISTRO DEL FORMULARIO
					set @IdEpisodioAtencionCopy = null;
						select top 1 
							@UnidadReplicacionCopy = UnidadReplicacion ,
							@EpisodioClinicoCopy = EpisodioClinico ,
							@IdEpisodioAtencionCopy = IdEpisodioAtencion ,
							@IdPacienteCopy = IdPaciente 
						
						from SS_HC_EpisodioAtencion
						where
							UnidadReplicacion = @UnidadReplicacion
							AND IdPaciente = @IdPaciente
							AND FechaCreacion is not null
							AND IdEpisodioAtencion not IN 
							(select NUEVA.IdEpisodioAtencion
								from SS_HC_EpisodioAtencion as NUEVA where
									NUEVA.UnidadReplicacion = @UnidadReplicacion
									AND NUEVA.IdPaciente = @IdPaciente
									AND NUEVA.EpisodioClinico = @EpisodioClinico
									AND NUEVA.IdEpisodioAtencion = @IdEpisodioAtencion							
							)

						order by FechaCreacion desc					
										
						  		
					if(@IdEpisodioAtencionCopy is not null)	
					begin
						
						--2.- REGISTRAR LOS DATOS	
														
						insert into	SS_HC_Anamnesis_AFAM
						select 
							@UnidadReplicacion
							  ,@IdEpisodioAtencion
							  ,@IdPaciente
							  ,@EpisodioClinico
							  ,SecuenciaFamilia				  
							  ,IdTipoParentesco
							  ,Edad
							  ,IdVivo
							  ,Estado
							  ,@UsuarioCreacion
							  ,getDate()
							  ,@UsuarioCreacion
							  ,getDate()
							  ,Accion
							  ,Version							  
						from SS_HC_Anamnesis_AFAM 
						where
							UnidadReplicacion = @UnidadReplicacionCopy
							AND EpisodioClinico  = @EpisodioClinicoCopy
							AND IdEpisodioAtencion = @IdEpisodioAtencionCopy
							AND IdPaciente = @IdPacienteCopy
							
						----------------------------
						----------------------------
						select @IDSECUENCIA_AUX = ISNULL(max(Secuencia),0)+1 
						  from dbo.SS_HC_Anamnesis_AFAM_Enfermedad 			  
						  where UnidadReplicacion = @UnidadReplicacion 
						  and EpisodioClinico =@EpisodioClinico
						  and IdPaciente = @IdPaciente 
						----------------------------
						insert into SS_HC_Anamnesis_AFAM_Enfermedad
						
						select 
							@UnidadReplicacion							  
							  ,@IdPaciente
							  ,@EpisodioClinico
							  ,@IdEpisodioAtencion
							  ,SecuenciaFamilia							
							  ,IdDiagnostico
							  ,Observaciones				 					
							  ,Accion
							  ,Version							  
						from SS_HC_Anamnesis_AFAM_Enfermedad 
						where
							UnidadReplicacion = @UnidadReplicacionCopy
							AND EpisodioClinico  = @EpisodioClinicoCopy
							AND IdEpisodioAtencion = @IdEpisodioAtencionCopy
							AND IdPaciente = @IdPacienteCopy
						
						----------------------------
					end		
				
					set @Total =1
				END
				ELSE
				IF(@CodigoFormato = 'CCEP0102')
				BEGIN
				--1.- OBTENER EL ID PARA EL REGISTRO DEL FORMULARIO
					set @IdEpisodioAtencionCopy = null;
						select top 1 
							@UnidadReplicacionCopy = UnidadReplicacion ,
							@EpisodioClinicoCopy = EpisodioClinico ,
							@IdEpisodioAtencionCopy = IdEpisodioAtencion ,
							@IdPacienteCopy = IdPaciente 
						
						from SS_HC_EpisodioAtencion
						where
							UnidadReplicacion = @UnidadReplicacion
							AND IdPaciente = @IdPaciente
							AND FechaCreacion is not null
							AND IdEpisodioAtencion not IN 
							(select NUEVA.IdEpisodioAtencion
								from SS_HC_EpisodioAtencion as NUEVA where
									NUEVA.UnidadReplicacion = @UnidadReplicacion
									AND NUEVA.IdPaciente = @IdPaciente
									AND NUEVA.EpisodioClinico = @EpisodioClinico
									AND NUEVA.IdEpisodioAtencion = @IdEpisodioAtencion							
							)

						order by FechaCreacion desc					
										
						  		
					if(@IdEpisodioAtencionCopy is not null)	
					begin
						
						--2.- REGISTRAR LOS DATOS	
						
						insert into	SS_HC_ExamenFisico_Triaje
						select 
							@UnidadReplicacion
							  ,@IdEpisodioAtencion
							  ,@IdPaciente
							  ,@EpisodioClinico
							  ,PresionMinima				  
							  ,PresionMaxima
							  ,FrecuenciaRespiratoria
							  ,FrecuenciaCardiaca
							  ,Temperatura
							  ,Peso
							  ,Talla
							  ,IndiceMasaCorporal
							  ,IdEstadoGeneral
							  ,IdNutricion
							  ,IdNutricion
							  ,IdColaboracion							  
							  ,ObservacionesAdicionales							  
							  ,Estado
							  ,@UsuarioCreacion
							  ,getDate()
							  ,@UsuarioCreacion
							  ,getDate()
							  ,Accion
							  ,Version							  
						from SS_HC_ExamenFisico_Triaje 
						where
							UnidadReplicacion = @UnidadReplicacionCopy
							AND EpisodioClinico  = @EpisodioClinicoCopy
							AND IdEpisodioAtencion = @IdEpisodioAtencionCopy
							AND IdPaciente = @IdPacienteCopy
							
						----------------------------						
					end			
				
					set @Total =1
				END
				ELSE
				IF(@CodigoFormato = 'CCEP0104')
				BEGIN
				--1.- OBTENER EL ID PARA EL REGISTRO DEL FORMULARIO
					set @IdEpisodioAtencionCopy = null;
						select top 1 
							@UnidadReplicacionCopy = UnidadReplicacion ,
							@EpisodioClinicoCopy = EpisodioClinico ,
							@IdEpisodioAtencionCopy = IdEpisodioAtencion ,
							@IdPacienteCopy = IdPaciente 
						
						from SS_HC_EpisodioAtencion
						where
							UnidadReplicacion = @UnidadReplicacion
							AND IdPaciente = @IdPaciente
							AND FechaCreacion is not null
							AND IdEpisodioAtencion not IN 
							(select NUEVA.IdEpisodioAtencion
								from SS_HC_EpisodioAtencion as NUEVA where
									NUEVA.UnidadReplicacion = @UnidadReplicacion
									AND NUEVA.IdPaciente = @IdPaciente
									AND NUEVA.EpisodioClinico = @EpisodioClinico
									AND NUEVA.IdEpisodioAtencion = @IdEpisodioAtencion							
							)
	
						order by FechaCreacion desc					
										
						  		
					if(@IdEpisodioAtencionCopy is not null)	
					begin
						
						--2.- REGISTRAR LOS DATOS	
						
						----------------------------
						select @IDSECUENCIA_AUX = ISNULL(max(Secuencia),0)+1 
						  from dbo.SS_HC_ExamenFisico_Regional 			  
						  where UnidadReplicacion = @UnidadReplicacion 
						  and EpisodioClinico =@EpisodioClinico
						  and IdPaciente = @IdPaciente 
						----------------------------											
						
						insert into	SS_HC_ExamenFisico_Regional
						select 
							@UnidadReplicacion
							  ,@IdEpisodioAtencion
							  ,@IdPaciente
							  ,@EpisodioClinico
							  ,@IDSECUENCIA_AUX /*Secuencia	*/			  
							  ,IdCuerpoHumano
							  ,Comentarios
							  ,Estado
							  ,@UsuarioCreacion
							  ,getDate()
							  ,@UsuarioCreacion
							  ,getDate()
							  ,Accion
							  ,Version							  
						from SS_HC_ExamenFisico_Regional 
						where
							UnidadReplicacion = @UnidadReplicacionCopy
							AND EpisodioClinico  = @EpisodioClinicoCopy
							AND IdEpisodioAtencion = @IdEpisodioAtencionCopy
							AND IdPaciente = @IdPacienteCopy							
						----------------------------						
					end										
				
					set @Total =1
				END
				ELSE
				IF(@CodigoFormato = 'CCEPF300')
				BEGIN
				--1.- OBTENER EL ID PARA EL REGISTRO DEL FORMULARIO
					set @IdEpisodioAtencionCopy = null;
						select top 1 
							@UnidadReplicacionCopy = UnidadReplicacion ,
							@EpisodioClinicoCopy = EpisodioClinico ,
							@IdEpisodioAtencionCopy = IdEpisodioAtencion ,
							@IdPacienteCopy = IdPaciente 
						
						from SS_HC_EpisodioAtencion
						where
							UnidadReplicacion = @UnidadReplicacion
							AND IdPaciente = @IdPaciente
							AND FechaCreacion is not null
							AND IdEpisodioAtencion not IN 
							(select NUEVA.IdEpisodioAtencion
								from SS_HC_EpisodioAtencion as NUEVA where
									NUEVA.UnidadReplicacion = @UnidadReplicacion
									AND NUEVA.IdPaciente = @IdPaciente
									AND NUEVA.EpisodioClinico = @EpisodioClinico
									AND NUEVA.IdEpisodioAtencion = @IdEpisodioAtencion							
							)

						order by FechaCreacion desc					
										
						  		
					if(@IdEpisodioAtencionCopy is not null)	
					begin
						
						--2.- REGISTRAR LOS DATOS						
						
						insert into	SS_HC_DescansoMedico_FE
						select 
							@UnidadReplicacion
							  ,@IdEpisodioAtencion
							  ,@IdPaciente
							  ,@EpisodioClinico
							  ,FechaFinDescanso			  
							  ,FechaFinDescanso
							  ,Observacion
							  ,Estado
							  ,@UsuarioCreacion
							  ,getDate()
							  ,@UsuarioCreacion
							  ,getDate()
							  ,Accion
							  ,Version
							  ,Dias
							  ,fecha
							  ,IdDiagnostico
							  ,IdFormaInicio							  
						from SS_HC_DescansoMedico_FE 
						where
							UnidadReplicacion = @UnidadReplicacionCopy
							AND EpisodioClinico  = @EpisodioClinicoCopy
							AND IdEpisodioAtencion = @IdEpisodioAtencionCopy
							AND IdPaciente = @IdPacienteCopy
							
						----------------------------
						
						----------------------------
						select @IDSECUENCIA_AUX = ISNULL(max(Secuencia),0)+1 
						  from dbo.SS_HC_DescansoMedico_Diagnostico_FE 			  
						  where UnidadReplicacion = @UnidadReplicacion 
						  and EpisodioClinico =@EpisodioClinico
						  and IdPaciente = @IdPaciente 
						----------------------------
						
						insert into	SS_HC_DescansoMedico_Diagnostico_FE
						select 
							@UnidadReplicacion
							  ,@IdEpisodioAtencion
							  ,@IdPaciente
							  ,@EpisodioClinico
							  ,@IDSECUENCIA_AUX/*Secuencia*/
							  ,IdDiagnostico
							  ,Accion
							  ,Version							  							  
						from SS_HC_DescansoMedico_Diagnostico_FE 
						where
							UnidadReplicacion = @UnidadReplicacionCopy
							AND EpisodioClinico  = @EpisodioClinicoCopy
							AND IdEpisodioAtencion = @IdEpisodioAtencionCopy
							AND IdPaciente = @IdPacienteCopy						
						
					end							
				
					set @Total =1
				END
				ELSE
				IF(@CodigoFormato = 'CCEP0F90')
				BEGIN
				--1.- OBTENER EL ID PARA EL REGISTRO DEL FORMULARIO
					set @IdEpisodioAtencionCopy = null;
						select top 1 
							@UnidadReplicacionCopy = UnidadReplicacion ,
							@EpisodioClinicoCopy = EpisodioClinico ,
							@IdEpisodioAtencionCopy = IdEpisodioAtencion ,
							@IdPacienteCopy = IdPaciente 
						
						from SS_HC_EpisodioAtencion
						where
							UnidadReplicacion = @UnidadReplicacion
							AND IdPaciente = @IdPaciente
							AND FechaCreacion is not null
							AND IdEpisodioAtencion not IN 
							(select NUEVA.IdEpisodioAtencion
								from SS_HC_EpisodioAtencion as NUEVA where
									NUEVA.UnidadReplicacion = @UnidadReplicacion
									AND NUEVA.IdPaciente = @IdPaciente
									AND NUEVA.EpisodioClinico = @EpisodioClinico
									AND NUEVA.IdEpisodioAtencion = @IdEpisodioAtencion							
							)

						order by FechaCreacion desc					
										
						  		
					if(@IdEpisodioAtencionCopy is not null)	
					begin
						
						--2.- REGISTRAR LOS DATOS	
						
						----------------------------
						select @IDSECUENCIA_AUX = ISNULL(max(Secuencia),0)+1 
						  from dbo.SS_HC_Diagnostico_FE 			  
						  where UnidadReplicacion = @UnidadReplicacion 
						  and EpisodioClinico =@EpisodioClinico
						  and IdPaciente = @IdPaciente 
						----------------------------		
						insert into	SS_HC_Diagnostico_FE (
						UnidadReplicacion, IdEpisodioAtencion, IdPaciente,
						EpisodioClinico, Secuencia, FechaRegistro,
						IdDiagnostico, IdDiagnosticoValoracion, DeterminacionDiagnostica,
						IdDiagnosticoPrincipal, GradoAfeccion,Observacion,
						IndicadorAntecedente, TipoAntecedente, IndicadorPreExistencia,
						IndicadorCronico, IndicadorNuevo, DetalleDiagnostico,
						Estado, UsuarioCreacion, FechaCreacion,
						UsuarioModificacion, FechaModificacion, Accion, Version)
						select 
							   @UnidadReplicacion
							  ,@IdEpisodioAtencion
							  ,@IdPaciente
							  ,@EpisodioClinico							  
							  ,@IDSECUENCIA_AUX/*Secuencia*/
							  ,FechaRegistro
							  ,IdDiagnostico
							  ,IdDiagnosticoValoracion
							  ,DeterminacionDiagnostica
							  ,IdDiagnosticoPrincipal
							  ,GradoAfeccion
							  ,Observacion
							  ,IndicadorAntecedente
							  ,TipoAntecedente
							  ,IndicadorPreExistencia
							  ,IndicadorCronico
							  ,IndicadorNuevo
							  ,DetalleDiagnostico
							  ,Estado
							  ,@UsuarioCreacion
							  ,getDate()
							  ,@UsuarioCreacion
							  ,getDate()
							  ,Accion
							  ,Version							  
						from SS_HC_Diagnostico_FE 
						where
							UnidadReplicacion = @UnidadReplicacionCopy
							AND EpisodioClinico  = @EpisodioClinicoCopy
							AND IdEpisodioAtencion = @IdEpisodioAtencionCopy
							AND IdPaciente = @IdPacienteCopy	
						----------------------------
						
					end		
				
				
				
				
					set @Total =1
				END
				ELSE

				IF(@CodigoFormato = 'CCEPF154')
				BEGIN
				--1.- OBTENER EL ID PARA EL REGISTRO DEL FORMULARIO
					set @IdEpisodioAtencionCopy = null;
						select top 1 
							@UnidadReplicacionCopy = UnidadReplicacion ,
							@EpisodioClinicoCopy = EpisodioClinico ,
							@IdEpisodioAtencionCopy = IdEpisodioAtencion ,
							@IdPacienteCopy = IdPaciente 
						
						from SS_HC_EpisodioAtencion
						where
							UnidadReplicacion = @UnidadReplicacion
							AND IdPaciente = @IdPaciente
							AND FechaCreacion is not null
							AND IdEpisodioAtencion not IN 
							(select NUEVA.IdEpisodioAtencion
								from SS_HC_EpisodioAtencion as NUEVA where
									NUEVA.UnidadReplicacion = @UnidadReplicacion
									AND NUEVA.IdPaciente = @IdPaciente
									AND NUEVA.EpisodioClinico = @EpisodioClinico
									AND NUEVA.IdEpisodioAtencion = @IdEpisodioAtencion							
							)

						order by FechaCreacion desc					
										
						  		
					if(@IdEpisodioAtencionCopy is not null)	
					begin
						
						--2.- REGISTRAR LOS DATOS	
						
						----------------------------
						--select @IDSECUENCIA_AUX = ISNULL(max(Secuencia),0)+1 
						--  from dbo.SS_HC_ApoyoDiagnostico_FE 			  
						--  where UnidadReplicacion = @UnidadReplicacion 
						--  and EpisodioClinico =@EpisodioClinico
						--  and IdPaciente = @IdPaciente 
						----------------------------		
						insert into	SS_HC_ApoyoDiagnostico_FE
						select 
							   @UnidadReplicacion
							  ,@IdEpisodioAtencion
							  ,@IdPaciente
							  ,@EpisodioClinico							  
							  --,@IDSECUENCIA_AUX/*Secuencia*/
							  ,NroInforme
							  ,Observacion
							,FechaSolicitada
							,Accion
							  ,Version	
							  ,Estado						  
							  ,@UsuarioCreacion
							  ,getDate()
							  ,@UsuarioCreacion
							  ,getDate()
							  ,Nombre
							  ,RutaInforme							  							  
						from SS_HC_ApoyoDiagnostico_FE 
						where
							UnidadReplicacion = @UnidadReplicacionCopy
							AND EpisodioClinico  = @EpisodioClinicoCopy
							AND IdEpisodioAtencion = @IdEpisodioAtencionCopy
							AND IdPaciente = @IdPacienteCopy	
						----------------------------						
					end				
				
					set @Total =1
				END

				ELSE
				IF(@CodigoFormato = 'CCEPF080')
				BEGIN
				--1.- OBTENER EL ID PARA EL REGISTRO DEL FORMULARIO
					set @IdEpisodioAtencionCopy = null;
						select top 1 
							@UnidadReplicacionCopy = UnidadReplicacion ,
							@EpisodioClinicoCopy = EpisodioClinico ,
							@IdEpisodioAtencionCopy = IdEpisodioAtencion ,
							@IdPacienteCopy = IdPaciente 
						
						from SS_HC_EpisodioAtencion
						where
							UnidadReplicacion = @UnidadReplicacion
							AND IdPaciente = @IdPaciente
							AND FechaCreacion is not null
							AND IdEpisodioAtencion not IN 
							(select NUEVA.IdEpisodioAtencion
								from SS_HC_EpisodioAtencion as NUEVA where
									NUEVA.UnidadReplicacion = @UnidadReplicacion
									AND NUEVA.IdPaciente = @IdPaciente
									AND NUEVA.EpisodioClinico = @EpisodioClinico
									AND NUEVA.IdEpisodioAtencion = @IdEpisodioAtencion							
							)
						order by FechaCreacion desc				
						  		
					if(@IdEpisodioAtencionCopy is not null)	
					begin
						
						--2.- REGISTRAR LOS DATOS	
						
						insert into	SS_HC_EvolucionMedica_FE
						select 
							@UnidadReplicacion
							  ,@IdEpisodioAtencion
							  ,@IdPaciente
							  ,@EpisodioClinico
							 /* ,@IDSECUENCIA_AUX Secuencia	*/			  
							  ,CodigoSecuencia
								,IdOrdenAtencion
								,FechaIngreso
								,DictamenRiesgo
								,EvolucionObjetiva
								,ObservacionesAdicionales
								,Medico
								,Especialidad
							  ,Estado
							  ,@UsuarioCreacion
							  ,getDate()
							  ,@UsuarioCreacion
							  ,getDate()
							  ,Accion
							  ,Version							  							  
						from SS_HC_EvolucionMedica_FE 
						where
							UnidadReplicacion = @UnidadReplicacionCopy
							AND EpisodioClinico  = @EpisodioClinicoCopy
							AND IdEpisodioAtencion = @IdEpisodioAtencionCopy
							AND IdPaciente = @IdPacienteCopy
							
						----------------------------
						
					end		
				
				
				
				
					set @Total =1
				END
				ELSE
				IF(@CodigoFormato = 'CCEP0253')
				BEGIN
					--1.- OBTENER EL ID PARA EL REGSITRO DEL FORMULARIO
					set @IdEpisodioAtencionCopy = null;
					select top 1 
						@UnidadReplicacionCopy = UnidadReplicacion ,
						@EpisodioClinicoCopy = EpisodioClinico ,
						@IdEpisodioAtencionCopy = IdEpisodioAtencion ,
						@IdPacienteCopy = IdPaciente 
					
					from SS_HC_EpisodioAtencion 
					where
						UnidadReplicacion = @UnidadReplicacion
						AND IdPaciente = @IdPaciente
						AND FechaCreacion is not null
						AND IdEpisodioAtencion not IN 
						(select NUEVA.IdEpisodioAtencion
							from SS_HC_EpisodioAtencion as NUEVA where
								NUEVA.UnidadReplicacion = @UnidadReplicacion
								AND NUEVA.IdPaciente = @IdPaciente
								AND NUEVA.EpisodioClinico = @EpisodioClinico
								AND NUEVA.IdEpisodioAtencion = @IdEpisodioAtencion							
						)												
					order by FechaCreacion desc		
																						  		
					if(@IdEpisodioAtencionCopy is not null)	
					begin		
					
						--2.- REGISTRAR LOS DATOS	
						insert into	SS_HC_Diagnostico					
						select 
								@UnidadReplicacion
							  ,@IdEpisodioAtencion
							  ,@IdPaciente
							  ,@EpisodioClinico
							  ,[Secuencia]
							  ,[FechaRegistro]
							  ,[IdDiagnostico]
							  ,[IdDiagnosticoValoracion]
							  ,[DeterminacionDiagnostica]
							  ,[IdDiagnosticoPrincipal]
							  ,[GradoAfeccion]
							  ,[Observacion]
							  ,[IndicadorAntecedente]
							  ,[TipoAntecedente]
							  ,[IndicadorPreExistencia]
							  ,[IndicadorCronico]
							  ,[IndicadorNuevo]
							  ,[DetalleDiagnostico]
							  ,[Estado]
							  ,@UsuarioCreacion
							  ,GETDATE()
							  ,@UsuarioCreacion
							  ,GETDATE()
							  ,[Accion]
							  ,[Version]				
						from SS_HC_Diagnostico		
						where
							UnidadReplicacion = @UnidadReplicacionCopy
							AND EpisodioClinico  = @EpisodioClinicoCopy
							AND IdEpisodioAtencion = @IdEpisodioAtencionCopy
							AND IdPaciente = @IdPacienteCopy	
			
					end
					
				
					set @Total =1
				END		
				else
				BEGIN
					set @Total =-1
				END				
			
				---CUENTA
				set @cuenta= @cuenta+1										
			END
						
			
		select @IdEpisodioAtencion
				
	end			
END	
/*
exec SP_SS_HC_EpisodioAtencion
	NULL,NULL,NULL,NULL,NULL,	
	NULL,NULL,NULL,NULL,NULL,		
	NULL,NULL,NULL,NULL,NULL,	
	NULL,NULL,'ROYAL', --
	NULL,NULL,		
	NULL,NULL,NULL,NULL,NULL,
		
	NULL,NULL,NULL,NULL,NULL,
	NULL,NULL,NULL,NULL,NULL,		
	NULL,NULL,NULL,NULL,NULL,		
	NULL,NULL,NULL,NULL,					
	NULL,NULL,NULL,NULL,		
	'PRUEBA'
	
*/

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Correlativo]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_Correlativo]
   (  
    @Compania		VARCHAR(15),
	@Sucursal		VARCHAR(4),
	@TipoComprobante VARCHAR(2),
	@NroPeticion	VARCHAR(15) OUTPUT
   )  
AS  
BEGIN   
DECLARE @var INT
DECLARE @ano VARCHAR(4)  
DECLARE @mes VARCHAR(2) 
DECLARE @dia VARCHAR(2) 
   DECLARE @NUM INT


     SELECT @NUM=count(*) FROM  CorrelativosMast WITH(NOLOCK) 
   WHERE CompaniaCodigo=@Compania AND TipoComprobante=@TipoComprobante AND Sucursal=@Sucursal  and  convert(nvarchar(20),UltimaFechaModif,103)=convert(nvarchar(20),SYSDATETIME(),103) 

   IF @NUM=0
   BEGIN
	   SELECT @var=CorrelativoDesde FROM  CorrelativosMast WITH(NOLOCK) 
	   WHERE CompaniaCodigo=@Compania AND TipoComprobante=@TipoComprobante AND Sucursal=@Sucursal  --and  convert(nvarchar(20),UltimaFechaModif,103)=convert(nvarchar(20),SYSDATETIME(),103) 
       UPDATE CorrelativosMast SET CorrelativoNumero=@var+1,UltimaFechaModif=SYSDATETIME() WHERE CompaniaCodigo=@Compania AND TipoComprobante=@TipoComprobante AND Sucursal=@Sucursal

   END
   ELSE
   BEGIN
	   SELECT @var=CorrelativoNumero FROM  CorrelativosMast WITH(NOLOCK) 
	   WHERE CompaniaCodigo=@Compania AND TipoComprobante=@TipoComprobante AND Sucursal=@Sucursal  --and  convert(nvarchar(20),UltimaFechaModif,103)=convert(nvarchar(20),SYSDATETIME(),103) 
	   UPDATE CorrelativosMast SET CorrelativoNumero=@var+1 WHERE CompaniaCodigo=@Compania AND TipoComprobante=@TipoComprobante AND Sucursal=@Sucursal
   END
   
   SELECT @ano=YEAR(SYSDATETIME()),@mes=RIGHT('00' + CAST(MONTH(SYSDATETIME()) as VARCHAR),2),@dia=RIGHT('00' + CAST(DAY(SYSDATETIME()) as VARCHAR),2)
   SET @NroPeticion = @ano+@mes+@dia + RIGHT('00000' + CAST(CAST(@var AS INT) AS VARCHAR), 5)


  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_CuerpoHumano]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_CuerpoHumano]
(
	@IdCuerpoHumano	int ,
	@IdCuerpoHumanoPadre	int ,
	@Codigo	varchar(20) ,
	@Descripcion	varchar(100) ,
	@DescripcionIngles	varchar(100) ,
	@Nivel	int ,
	@UltimoNivelFlag	char(1) ,
	@CadenaRecursiva	varchar(100) ,
	@Orden	int ,
	@Icono	varchar(100) ,
	@Estado	int ,
	@UsuarioCreacion	varchar(25) ,
	@FechaCreacion	datetime ,
	@UsuarioModificacion	varchar(25) ,
	@FechaModificacion	datetime ,
	@NombreTabla	varchar(100) ,
	@CodigoPadre	varchar(30) ,
	@tipofolder	int ,
	
	
	@ACCION VARCHAR(20)
)

AS
BEGIN 
SET NOCOUNT ON;
BEGIN  TRANSACTION

	DECLARE @CONTADOR INT
	
	if(@ACCION = 'INSERT')
	begin		 
		
		select @CONTADOR= isnull(MAX(IdCuerpoHumano),0)+1 from SS_HC_CuerpoHumano 
		
		set @IdCuerpoHumano= @CONTADOR
		insert into SS_HC_CuerpoHumano
		(
			IdCuerpoHumano
			,IdCuerpoHumanoPadre
			,Codigo
			,Descripcion
			,DescripcionIngles
			,Nivel
			,UltimoNivelFlag
			,CadenaRecursiva
			,Orden
			,Icono
			,Estado
			,UsuarioCreacion
			,FechaCreacion
			,UsuarioModificacion
			,FechaModificacion
			,NombreTabla
			,CodigoPadre
			,tipofolder
		)
		values(
			@IdCuerpoHumano
		,	@IdCuerpoHumanoPadre
		,	@Codigo
		,	@Descripcion
		,	@DescripcionIngles
		,	@Nivel
		,	@UltimoNivelFlag
		,	@CadenaRecursiva
		,	@Orden
		,	@Icono
		,	@Estado
		,	isnull(@UsuarioCreacion,@UsuarioModificacion)
		,	GETDATE()
		,	@UsuarioModificacion
		,	GETDATE()		
		,@NombreTabla
		,@CodigoPadre
		,@tipofolder		
		)
		select 1
	end	
	else
	if(@ACCION = 'UPDATE')
	begin			
		update SS_HC_CuerpoHumano
		set 		
		IdCuerpoHumanoPadre	=	@IdCuerpoHumanoPadre
		,Codigo	=	@Codigo
		,Descripcion	=	@Descripcion
		,DescripcionIngles	=	@DescripcionIngles
		,Nivel	=	@Nivel
		,UltimoNivelFlag	=	@UltimoNivelFlag
		,CadenaRecursiva	=	@CadenaRecursiva
		,Orden	=	@Orden
		,Icono	=	@Icono
		,Estado	=	@Estado
		,UsuarioModificacion	=	@UsuarioModificacion
		,FechaModificacion	=	GETDATE	()
		,NombreTabla	=	@NombreTabla
		,CodigoPadre	=	@CodigoPadre
		,tipofolder	=	@tipofolder
		
		WHERE 
		(IdCuerpoHumano = @IdCuerpoHumano)		
		select 1
	end	
	else
	if(@ACCION = 'DELETE')
	begin
		delete SS_HC_CuerpoHumano
		WHERE 
		(IdCuerpoHumano = @IdCuerpoHumano)
		select 1
	end
	else
	if(@ACCION = 'CONTARLISTARPAG')
	begin	 	
		SET @CONTADOR=(SELECT COUNT(IdCuerpoHumano) FROM SS_HC_CuerpoHumano
				where
					(@IdCuerpoHumano is null OR (IdCuerpoHumano = @IdCuerpoHumano) or @IdCuerpoHumano =0)
					and (@IdCuerpoHumanoPadre is null OR IdCuerpoHumanoPadre = @IdCuerpoHumanoPadre)					
					and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')					
					and (@ESTADO is null OR Estado = @ESTADO)		
					and (@Codigo is null  OR @Codigo =''  OR  upper(Codigo) like '%'+upper(@Codigo)+'%')					
					)
		select @CONTADOR
	end
commit	
	
END	
/*

)*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_CuerpoHumano_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_CuerpoHumano_LISTAR]
(
	@IdCuerpoHumano	int ,
	@IdCuerpoHumanoPadre	int ,
	@Codigo	varchar(20) ,
	@Descripcion	varchar(100) ,
	@DescripcionIngles	varchar(100) ,	
	@UltimoNivelFlag	char(1) ,
	@CadenaRecursiva	varchar(100) ,		
	@Estado	int ,
	@UsuarioCreacion	varchar(25) ,
	@FechaCreacion	datetime ,				
	@INICIO   int= null,  
	@NUMEROFILAS int = null ,
	@ACCION VARCHAR(20)
)

AS
BEGIN
	if(@ACCION = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR=(SELECT COUNT(IdCuerpoHumano) FROM SS_HC_CuerpoHumano
				where
					(@IdCuerpoHumano is null OR (IdCuerpoHumano = @IdCuerpoHumano) or @IdCuerpoHumano =0)
					and (@IdCuerpoHumanoPadre is null OR IdCuerpoHumanoPadre = @IdCuerpoHumanoPadre)					
					and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')					
					and (@ESTADO is null OR Estado = @ESTADO)		
					and (@Codigo is null  OR @Codigo =''  OR  upper(Codigo) like '%'+upper(@Codigo)+'%')					
					)
	 
		SELECT 
					IdCuerpoHumano
					,IdCuerpoHumanoPadre
					,Codigo
					,Descripcion
					,DescripcionIngles
					,Nivel
					,UltimoNivelFlag
					,CadenaRecursiva
					,Orden
					,Icono
					,Estado
					,UsuarioCreacion
					,FechaCreacion
					,UsuarioModificacion
					,FechaModificacion		
					,ACCION		
					,NombreTabla
					,CodigoPadre
					,tipofolder						
		FROM (
				SELECT 
					IdCuerpoHumano
					,IdCuerpoHumanoPadre
					,Codigo
					,Descripcion
					,DescripcionIngles
					,Nivel
					,UltimoNivelFlag
					,CadenaRecursiva
					,Orden
					,Icono
					,Estado
					,UsuarioCreacion
					,FechaCreacion
					,UsuarioModificacion
					,FechaModificacion		
					,ACCION		
					,NombreTabla
					,CodigoPadre
					,tipofolder
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY IdCuerpoHumano ASC ) AS RowNumber   					
				from 
				SS_HC_CuerpoHumano
				where
					(@IdCuerpoHumano is null OR (IdCuerpoHumano = @IdCuerpoHumano) or @IdCuerpoHumano =0)
					and (@IdCuerpoHumanoPadre is null OR IdCuerpoHumanoPadre = @IdCuerpoHumanoPadre)					
					and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')					
					and (@ESTADO is null OR Estado = @ESTADO)		
					and (@Codigo is null  OR @Codigo =''  OR  upper(Codigo) like '%'+upper(@Codigo)+'%')					
					
		
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
	end
	else
	if(@ACCION = 'LISTAR')
	begin
	 
				SELECT 
					IdCuerpoHumano
					,IdCuerpoHumanoPadre
					,Codigo
					,Descripcion
					,DescripcionIngles
					,Nivel
					,UltimoNivelFlag
					,CadenaRecursiva
					,Orden
					,Icono
					,Estado
					,UsuarioCreacion
					,FechaCreacion
					,UsuarioModificacion
					,FechaModificacion		
					,ACCION		
					,NombreTabla
					,CodigoPadre
					,tipofolder					
				from 
				SS_HC_CuerpoHumano
				where
					(@IdCuerpoHumano is null OR (IdCuerpoHumano = @IdCuerpoHumano) or @IdCuerpoHumano =0)
					and (@IdCuerpoHumanoPadre is null OR IdCuerpoHumanoPadre = @IdCuerpoHumanoPadre)					
					and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')					
					and (@ESTADO is null OR Estado = @ESTADO)
					and (@Codigo is null  OR @Codigo =''  OR  upper(Codigo) like '%'+upper(@Codigo)+'%')

	end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 
					*					
				from 
				SS_HC_CuerpoHumano
				where
					(IdCuerpoHumano = @IdCuerpoHumano)
					

	end	
	

END
/*
exec SP_SS_HC_CuerpoHumano_LISTAR

	0,
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
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_CuidadoPreventivo]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_CuidadoPreventivo]
           @IdCuidadoPreventivo int,
           @IdCuidadoPreventivoPadre int,
           @CodigoCuidadoPreventivo varchar(20),
           @CodigoCuidadoPreventivoPadre varchar(20),
           @IdTipoCuidadoPreventivo int,
           @IdTipoPeriodicidad int,
           @Descripcion varchar(200),
           @DescripcionExtranjera varchar(200),
           @Nivel int,
           @UltimoNivelFlag char(1),
           @CadenaRecursiva varchar(150),
           @Orden int,
           @Estado int,
           @UsuarioCreacion varchar(25),
           @FechaCreacion datetime,
           @UsuarioModificacion varchar(25),
           @FechaModificacion datetime,
           @NombreTabla varchar(25),
           @Accion varchar(25),
           @Version varchar(25)
           
           AS    
BEGIN   
 SET NOCOUNT ON;  
 --BEGIN  TRANSACTION
 DECLARE @CONTADOR INT  
 IF @Accion ='INSERT'  
  BEGIN  
  	SELECT @CONTADOR= isnull(MAX(IdCuidadoPreventivo),0)+1 from SS_HC_CuidadoPreventivo 
		SET @IdCuidadoPreventivo = @CONTADOR
		INSERT INTO SS_HC_CuidadoPreventivo   
		(  
				IdCuidadoPreventivo,
				IdCuidadoPreventivoPadre,
				CodigoCuidadoPreventivo,
				CodigoCuidadoPreventivoPadre,
				IdTipoCuidadoPreventivo,
				IdTipoPeriodicidad,
				Descripcion,
				DescripcionExtranjera,
				Nivel,
				UltimoNivelFlag,
				CadenaRecursiva,
				Orden,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				NombreTabla,
				Accion,
				Version )  
   values 
	   (
				@IdCuidadoPreventivo,
				@IdCuidadoPreventivoPadre,
				@CodigoCuidadoPreventivo,
				@CodigoCuidadoPreventivoPadre,
				@IdTipoCuidadoPreventivo,
				@IdTipoPeriodicidad,
				@Descripcion,
				@DescripcionExtranjera,
				@Nivel,
				@UltimoNivelFlag,
				@CadenaRecursiva,
				@Orden,
				@Estado,
				@UsuarioCreacion,
				GETDATE(),
				@UsuarioCreacion,
				GETDATE(),
				@NombreTabla,
				@Accion,
				@Version)   
		select 1
  END
  ELSE  
  IF @Accion ='UPDATE'  
   BEGIN  
   UPDATE SS_HC_CuidadoPreventivo SET   
				IdCuidadoPreventivoPadre = @IdCuidadoPreventivoPadre ,
				CodigoCuidadoPreventivo = @CodigoCuidadoPreventivo ,
				CodigoCuidadoPreventivoPadre = @CodigoCuidadoPreventivoPadre ,
				IdTipoCuidadoPreventivo = @IdTipoCuidadoPreventivo ,
				IdTipoPeriodicidad = @IdTipoPeriodicidad ,
				Descripcion = @Descripcion ,
				DescripcionExtranjera = @DescripcionExtranjera ,
				Nivel = @Nivel ,
				UltimoNivelFlag = @UltimoNivelFlag ,
				CadenaRecursiva = @CadenaRecursiva ,
				Orden = @Orden ,
				Estado = @Estado ,
				FechaModificacion = GETDATE() ,
				NombreTabla = @NombreTabla ,
				Accion = @Accion ,
				Version = @Version 
   where IdCuidadoPreventivo = @IdCuidadoPreventivo   
		select 1
   END   
	else
	if(@ACCION = 'DELETE')
	begin
		delete SS_HC_CuidadoPreventivo
		WHERE 
		(IdCuidadoPreventivo = @IdCuidadoPreventivo )
	select 1 
	end
else
	if(@ACCION = 'LISTARPAG')
	begin	 	
		SET @CONTADOR=(SELECT COUNT(IdCuidadoPreventivo) FROM SS_HC_CuidadoPreventivo
	 					WHERE 
					(@IdCuidadoPreventivo is null OR (IdCuidadoPreventivo = @IdCuidadoPreventivo) or @IdCuidadoPreventivo =0)
					and (@IdCuidadoPreventivoPadre is null OR IdCuidadoPreventivoPadre = @IdCuidadoPreventivoPadre)					
					and (@Estado is null OR Estado = @Estado)
					and (@CodigoCuidadoPreventivo is null  OR @CodigoCuidadoPreventivo =''  OR  upper(CodigoCuidadoPreventivo) like '%'+upper(@CodigoCuidadoPreventivo)+'%')	
)
		select @CONTADOR
	end
	
END	 

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_CuidadoPreventivoListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_CuidadoPreventivoListar]
           @IdCuidadoPreventivo int,
           @IdCuidadoPreventivoPadre int,
           @CodigoCuidadoPreventivo varchar(20),
           @CodigoCuidadoPreventivoPadre varchar(20),
           @IdTipoCuidadoPreventivo int,
           @IdTipoPeriodicidad int,
           @Descripcion varchar(200),
           @DescripcionExtranjera varchar(200),
           @Nivel int,
           @UltimoNivelFlag char(1),
           @CadenaRecursiva varchar(150),
           @Orden int,
           @Estado int,
           @UsuarioCreacion varchar(25),
           @FechaCreacion datetime,
           @UsuarioModificacion varchar(25),
           @FechaModificacion datetime,
           @NombreTabla varchar(25),
           @Accion varchar(25),
           @Version varchar(25),				
			@INICIO   int= null,  
			@NUMEROFILAS int = null 
           
           AS    
BEGIN    
if(@ACCION = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR=(SELECT COUNT(IdCuidadoPreventivo) FROM SS_HC_CuidadoPreventivo
	 					WHERE 
					(@IdCuidadoPreventivo is null OR (IdCuidadoPreventivo = @IdCuidadoPreventivo) or @IdCuidadoPreventivo =0)
					and (@IdCuidadoPreventivoPadre is null OR IdCuidadoPreventivoPadre = @IdCuidadoPreventivoPadre)					
					and (@Estado is null OR Estado = @Estado)
					and (@CodigoCuidadoPreventivo is null  OR @CodigoCuidadoPreventivo =''  OR  upper(CodigoCuidadoPreventivo) like '%'+upper(@CodigoCuidadoPreventivo)+'%')	
				)
		SELECT
				IdCuidadoPreventivo,
				IdCuidadoPreventivoPadre,
				CodigoCuidadoPreventivo,
				CodigoCuidadoPreventivoPadre,
				IdTipoCuidadoPreventivo,
				IdTipoPeriodicidad,
				Descripcion,
				DescripcionExtranjera,
				Nivel,
				UltimoNivelFlag,
				CadenaRecursiva,
				Orden,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				NombreTabla,
				Accion,
				Version
		FROM (		
			SELECT
				IdCuidadoPreventivo,
				IdCuidadoPreventivoPadre,
				CodigoCuidadoPreventivo,
				CodigoCuidadoPreventivoPadre,
				IdTipoCuidadoPreventivo,
				IdTipoPeriodicidad,
				Descripcion,
				DescripcionExtranjera,
				Nivel,
				UltimoNivelFlag,
				CadenaRecursiva,
				Orden,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				NombreTabla,
				Accion,
				Version
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY IdCuidadoPreventivo ASC ) AS RowNumber   	
					FROM SS_HC_CuidadoPreventivo	
					WHERE  
					(@IdCuidadoPreventivo is null OR (IdCuidadoPreventivo = @IdCuidadoPreventivo) or @IdCuidadoPreventivo =0)
					and (@IdCuidadoPreventivoPadre is null OR IdCuidadoPreventivoPadre = @IdCuidadoPreventivoPadre)						
					and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')					
					and (@Estado is null OR Estado = @Estado)					
					and (@CodigoCuidadoPreventivo is null  OR @CodigoCuidadoPreventivo =''  OR  upper(CodigoCuidadoPreventivo) like '%'+upper(@CodigoCuidadoPreventivo)+'%')	

 
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		
       END
       ELSE
  IF @Accion ='LISTAR'    
    BEGIN    
		SELECT
				IdCuidadoPreventivo,
				IdCuidadoPreventivoPadre,
				CodigoCuidadoPreventivo,
				CodigoCuidadoPreventivoPadre,
				IdTipoCuidadoPreventivo,
				IdTipoPeriodicidad,
				Descripcion,
				DescripcionExtranjera,
				Nivel,
				UltimoNivelFlag,
				CadenaRecursiva,
				Orden,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				NombreTabla,
				Accion,
				Version
				FROM SS_HC_CuidadoPreventivo	
				WHERE	IdCuidadoPreventivoPadre IS NULL
				and		IdTipoCuidadoPreventivo = @IdTipoCuidadoPreventivo
	
	end	
	else
	  IF @Accion ='LISTAMANTENIMIENTO'    
    BEGIN    
		SELECT
				IdCuidadoPreventivo,
				IdCuidadoPreventivoPadre,
				CodigoCuidadoPreventivo,
				CodigoCuidadoPreventivoPadre,
				IdTipoCuidadoPreventivo,
				IdTipoPeriodicidad,
				Descripcion,
				DescripcionExtranjera,
				Nivel,
				UltimoNivelFlag,
				CadenaRecursiva,
				Orden,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				NombreTabla,
				Accion,
				Version
				FROM SS_HC_CuidadoPreventivo
					WHERE  
					(@IdCuidadoPreventivo is null OR (IdCuidadoPreventivo = @IdCuidadoPreventivo) or @IdCuidadoPreventivo =0)
					and (@IdCuidadoPreventivoPadre is null OR IdCuidadoPreventivoPadre = @IdCuidadoPreventivoPadre)						
					and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')					
					and (@Estado is null OR Estado = @Estado)		
					and (@CodigoCuidadoPreventivo is null  OR @CodigoCuidadoPreventivo =''  OR  upper(CodigoCuidadoPreventivo) like '%'+upper(@CodigoCuidadoPreventivo)+'%')	
	end	
	else
IF @Accion ='LISTARHIJO'    
    BEGIN    
		SELECT
				IdCuidadoPreventivo,
				IdCuidadoPreventivoPadre,
				CodigoCuidadoPreventivo,
				CodigoCuidadoPreventivoPadre,
				IdTipoCuidadoPreventivo,
				IdTipoPeriodicidad,
				Descripcion,
				DescripcionExtranjera,
				Nivel,
				UltimoNivelFlag,
				CadenaRecursiva,
				Orden,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				NombreTabla,
				Accion,
				Version
				FROM SS_HC_CuidadoPreventivo	
				WHERE	IdCuidadoPreventivoPadre = @IdCuidadoPreventivoPadre
				and		IdTipoCuidadoPreventivo = @IdTipoCuidadoPreventivo
		
	end	
	else	
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 
					*					
				from 
				SS_HC_CuidadoPreventivo
				where
					(@IdCuidadoPreventivo is null OR (IdCuidadoPreventivo = @IdCuidadoPreventivo) or @IdCuidadoPreventivo =0)
					and (@IdCuidadoPreventivoPadre is null OR IdCuidadoPreventivoPadre = @IdCuidadoPreventivoPadre)						
					and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')					
					and (@Estado is null OR Estado = @Estado)		
					and (@CodigoCuidadoPreventivo is null  OR @CodigoCuidadoPreventivo =''  OR  upper(CodigoCuidadoPreventivo) like '%'+upper(@CodigoCuidadoPreventivo)+'%')	

	end	
      ELSE
  IF @Accion ='LISTARPORPADRE'    
    BEGIN    
		SELECT
				IdCuidadoPreventivo,
				IdCuidadoPreventivoPadre,
				CodigoCuidadoPreventivo,
				CodigoCuidadoPreventivoPadre,
				IdTipoCuidadoPreventivo,
				IdTipoPeriodicidad,
				Descripcion,
				DescripcionExtranjera,
				Nivel,
				UltimoNivelFlag,
				CadenaRecursiva,
				Orden,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				NombreTabla,
				Accion,
				Version
				FROM SS_HC_CuidadoPreventivo	
									WHERE 
					(@IdCuidadoPreventivo is null OR (IdCuidadoPreventivo = @IdCuidadoPreventivo) or @IdCuidadoPreventivo =0)
					and (@IdCuidadoPreventivoPadre is null OR IdCuidadoPreventivoPadre = @IdCuidadoPreventivoPadre)						
					and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')					
					and (@Estado is null OR Estado = @Estado)		
					and (@CodigoCuidadoPreventivo is null  OR @CodigoCuidadoPreventivo =''  OR  upper(CodigoCuidadoPreventivo) like '%'+upper(@CodigoCuidadoPreventivo)+'%')	
					and (@CodigoCuidadoPreventivoPadre is null OR CodigoCuidadoPreventivoPadre = @CodigoCuidadoPreventivoPadre)
					and (@Nivel is null OR Nivel = @Nivel)		
 
	end	
	else	
	if(@ACCION = 'LISTARVALIDACION')
	begin	 
				SELECT 
					*					
				from 
				SS_HC_CuidadoPreventivo
				where
					(@IdCuidadoPreventivo is null OR (IdCuidadoPreventivo = @IdCuidadoPreventivo) or @IdCuidadoPreventivo =0)
					and (@IdCuidadoPreventivoPadre is null OR IdCuidadoPreventivoPadre = @IdCuidadoPreventivoPadre)																
					and (@CodigoCuidadoPreventivo is null  OR @CodigoCuidadoPreventivo ='' OR  CodigoCuidadoPreventivo =  @CodigoCuidadoPreventivo)	

	end			
END

/*
exec SP_SS_HC_CuidadoPreventivoListar
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           'LISTAR',
           NULL
           
           */
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Dominio_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_Dominio_LISTAR]


	@IdDominioPAE int ,
	@Descripcion varchar(150) ,
	@Estado	int ,
	@UsuarioCreacion varchar(25) ,
	@FechaCreacion datetime ,	
	@UsuarioModificacion varchar(25) ,
	@FechaModificacion datetime ,
	@Inicio	int ,	
	@NumeroFilas	int ,	
	@Accion	varchar(25),
	@Version varchar(25)

AS 
  BEGIN 
      SET nocount ON; 

      DECLARE @CONTADOR INT 

      IF @Accion = 'LISTAR' 
        BEGIN 
            SELECT SS_HC_DominioPAE.IdDominioPAE,                    
                   SS_HC_DominioPAE.descripcion, 
                   SS_HC_DominioPAE.Estado,                    
                   SS_HC_DominioPAE.usuariocreacion, 
                   SS_HC_DominioPAE.fechacreacion, 
                   SS_HC_DominioPAE.usuariomodificacion, 
                   SS_HC_DominioPAE.fechamodificacion, 
                   SS_HC_DominioPAE.accion, 
                   SS_HC_DominioPAE.version 
            FROM   SS_HC_DominioPAE 
             WHERE  ( @Descripcion IS NULL OR Upper(SS_HC_DominioPAE.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_DominioPAE.estado = @Estado OR @Estado = 0 )                                    
                                    AND ( @IdDominioPAE IS NULL OR SS_HC_DominioPAE.IdDominioPAE = @IdDominioPAE OR @IdDominioPAE = 0 )
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_DominioPAE 
                              WHERE  ( @Descripcion IS NULL OR Upper(SS_HC_DominioPAE.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_DominioPAE.estado = @Estado OR @Estado = 0 )                                    
                                    AND ( @IdDominioPAE IS NULL OR SS_HC_DominioPAE.IdDominioPAE = @IdDominioPAE OR @IdDominioPAE = 0 )) 

            SELECT IdDominioPAE,                     
                   descripcion,                    
                   estado, 
                   usuariocreacion, 
                   fechacreacion, 
                   usuariomodificacion, 
                   fechamodificacion, 
                   accion, 
                   version 
            FROM   (SELECT SS_HC_DominioPAE.IdDominioPAE,                            
                           SS_HC_DominioPAE.descripcion,                            
                           SS_HC_DominioPAE.estado, 
                           SS_HC_DominioPAE.usuariocreacion, 
                           SS_HC_DominioPAE.fechacreacion, 
                           SS_HC_DominioPAE.usuariomodificacion, 
                           SS_HC_DominioPAE.fechamodificacion, 
                           SS_HC_DominioPAE.accion, 
                           SS_HC_DominioPAE.version, 
                           @CONTADOR                                  
                           AS 
                           Contador, 
                           Row_number() 
                             OVER ( 
                               ORDER BY SS_HC_DominioPAE.IdDominioPAE ASC ) 
                               AS 
                           RowNumber 
                    FROM   SS_HC_DominioPAE 
                     WHERE  ( @Descripcion IS NULL OR Upper(SS_HC_DominioPAE.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_DominioPAE.estado = @Estado OR @Estado = 0 )                                     
                                    AND ( @IdDominioPAE IS NULL OR SS_HC_DominioPAE.IdDominioPAE = @IdDominioPAE OR @IdDominioPAE = 0 )) 
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
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_DominioPAE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER PROCEDURE [SP_SS_HC_DominioPAE]

	@IdDominioPAE int ,
	@Descripcion varchar(150) ,
	@Estado	int ,
	@UsuarioCreacion varchar(25) ,
	@FechaCreacion datetime ,	
	@UsuarioModificacion varchar(25) ,
	@FechaModificacion datetime ,		
	@ACCION	varchar(30) 
			

AS 
  BEGIN 
      SET nocount ON; 

      IF @Accion = 'INSERT' 
        BEGIN 
            SELECT @IdDominioPAE = Isnull(Max(IdDominioPAE), 0) + 1 FROM   dbo.SS_HC_DominioPAE  
            INSERT INTO SS_HC_DominioPAE 
                        (IdDominioPAE,                          
                         descripcion,                         
                         estado, 
                         usuariocreacion, 
                         fechacreacion, 
                         usuariomodificacion, 
                         fechamodificacion, 
                         accion 
                         ) 
            VALUES      ( @IdDominioPAE,                            
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
            UPDATE SS_HC_DominioPAE 
            SET    IdDominioPAE = @IdDominioPAE,                    
                   descripcion = @Descripcion,                   
                   estado = @Estado, 
                   usuariomodificacion = @UsuarioModificacion, 
                   fechamodificacion = GETDATE(), 
                   accion = @Accion                    
            WHERE  ( SS_HC_DominioPAE.IdDominioPAE = @IdDominioPAE ) 

            SELECT 1 
        END 
      ELSE IF @Accion = 'DELETE' 
        BEGIN 
            DELETE FROM SS_HC_DominioPAE 
            WHERE  ( SS_HC_DominioPAE.IdDominioPAE = @IdDominioPAE ) 

            SELECT 1 
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_DominioPAE 
                             WHERE  ( @Descripcion IS NULL OR Upper(SS_HC_DominioPAE.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_DominioPAE.estado = @Estado OR @Estado = 0 )                                    
                                    AND ( @IdDominioPAE IS NULL OR SS_HC_DominioPAE.IdDominioPAE = @IdDominioPAE OR @IdDominioPAE = 0 )) 

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
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Epicrisis_1_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_Epicrisis_1_FE]
(
@UnidadReplicacion char(4),
@IdEpisodioAtencion bigint,
@IdPaciente int,
@EpisodioClinico int,
@IdMedico int,
@ManejoConjunto char(1),
@Especificar int,
@Redacta int,
@FechaIngreso datetime,
@HoraIngreso datetime,
@FechaEgreso datetime,
@HoraEgreso datetime,
@DiasHospitalizacion text,
@EnfermedadActual text,
@Antecedentes text,
@ExamenFisico text,
@Evolucion text,
@Estado int,
@UsuarioCreacion varchar(25),
@FechaCreacion DATETIME,
@UsuarioModificacion varchar(25),
@FechaModificacion DATETIME,
@Accion varchar(25),
@Version varchar (25)
)
AS
BEGIN


if(@Accion='NUEVO')
BEGIN
SET NOCOUNT ON;

	insert into SS_HC_Epicrisis_1_FE
	(	
	UnidadReplicacion ,
	IdEpisodioAtencion,
	IdPaciente,
	EpisodioClinico,
	IdMedico,
	ManejoConjunto,
	Especificar,
	Redacta,
	FechaIngreso,
	HoraIngreso,
	FechaEgreso,
	HoraEgreso,
	DiasHospitalizacion,
	EnfermedadActual,
	Antecedentes,
	ExamenFisico,
	Evolucion,
	Estado,
	UsuarioCreacion,
	FechaCreacion,
	UsuarioModificacion,
	FechaModificacion,
	Accion,
	Version 

	)
	values
	(
	@UnidadReplicacion ,
	@IdEpisodioAtencion,
	@IdPaciente,
	@EpisodioClinico,
	@IdMedico,
	@ManejoConjunto,
	@Especificar,
	@Redacta,
	@FechaIngreso ,
	@HoraIngreso ,
	@FechaEgreso ,
	@HoraEgreso ,
	@DiasHospitalizacion,
	@EnfermedadActual,
	@Antecedentes,
	@ExamenFisico,
	@Evolucion,
	@Estado,
	@UsuarioCreacion,
	GETDATE(),
	@UsuarioModificacion,
	GETDATE(),
	@Accion,
	@Version 

	)
	select @IdPaciente


END

else
if(@Accion='UPDATE')
begin


	update SS_HC_Epicrisis_1_FE
	set
	UnidadReplicacion=@UnidadReplicacion,
	IdEpisodioAtencion=@IdEpisodioAtencion,
	IdPaciente=@IdPaciente,
	EpisodioClinico=@EpisodioClinico,
	IdMedico=@IdMedico,
	ManejoConjunto=@ManejoConjunto,
	Especificar=@Especificar,
	Redacta=@Redacta,
	FechaIngreso=@FechaIngreso,
	HoraIngreso=@HoraIngreso,
	FechaEgreso=@FechaEgreso,
	HoraEgreso=@HoraEgreso,
	DiasHospitalizacion=@DiasHospitalizacion,
	EnfermedadActual=@EnfermedadActual,
	Antecedentes=@Antecedentes,
	ExamenFisico=@ExamenFisico,
	Evolucion=@Evolucion,
	Estado=@Estado,
	UsuarioCreacion=@UsuarioCreacion,
	FechaCreacion=@FechaCreacion,
	UsuarioModificacion=@UsuarioModificacion,
	FechaModificacion=@FechaModificacion,
	Accion=@Accion,
	Version=@Version 

	WHERE
	(UnidadReplicacion= @UnidadReplicacion)
	and ( IdPaciente= @IdPaciente)
	and ( EpisodioClinico= @EpisodioClinico)
	and ( IdEpisodioAtencion= @IdEpisodioAtencion)

	select @EpisodioClinico
end


else
if(@ACCION = 'DELETE')
	begin
		delete SS_HC_Epicrisis_1_FE
		WHERE
		(UnidadReplicacion= @UnidadReplicacion)
		and ( IdPaciente= @IdPaciente)
		and ( EpisodioClinico= @EpisodioClinico)
		and ( IdEpisodioAtencion= @IdEpisodioAtencion)

		select 1
	end

end


GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Epicrisis_1_FE_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_Epicrisis_1_FE_Listar]
(
@UnidadReplicacion char(4),
@IdEpisodioAtencion bigint,
@IdPaciente int,
@EpisodioClinico int,
@IdMedico int,
@ManejoConjunto char(1),
@Especificar int,
@Redacta int,
@FechaIngreso datetime,
@HoraIngreso datetime,
@FechaEgreso datetime,
@HoraEgreso datetime,
@DiasHospitalizacion text,
@EnfermedadActual text,
@Antecedentes text,
@ExamenFisico text,
@Evolucion text,
@Estado int,
@UsuarioCreacion varchar(25),
@FechaCreacion datetime,
@UsuarioModificacion varchar(25),
@FechaModificacion datetime,
@Accion varchar(25),
@Version varchar (25)
)

as
begin 

IF @Accion = 'LISTAR'

	select * from SS_HC_Epicrisis_1_FE where
	@UnidadReplicacion=UnidadReplicacion AND
	@IdEpisodioAtencion=IdEpisodioAtencion AND
	@IdPaciente=IdPaciente  AND 
	@EpisodioClinico=EpisodioClinico

END


GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Epicrisis_2_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_Epicrisis_2_FE]
(

	@UnidadReplicacion char(4),
	@IdEpisodioAtencion bigint,
	@IdPaciente int,
	@EpisodioClinico int,
	@Complicaciones text,
	@Pronostico  varchar (50),
	@TipoAlta varchar(50),
	@CondicionEgreso varchar(50),
	@CausaMuerte text,
	@Necropsia char(1),
	@PlanAlta text,
	@Estado int,
	@UsuarioCreacion varchar(25),
	@FechaCreacion datetime,
	@UsuarioModificacion varchar(25),
	@FechaModificacion datetime,
	@Accion varchar (25),
	@Version varchar(25)
	
)
AS
BEGIN 


if(@Accion='INSERT')
BEGIN
insert into SS_HC_Epicrisis_2_FE
		(
			
			UnidadReplicacion,
	IdEpisodioAtencion,
	IdPaciente,
	EpisodioClinico,
	Complicaciones,
	Pronostico,
	TipoAlta,
	CondicionEgreso,
	CausaMuerte,
	Necropsia,
	PlanAlta,
	Estado,
	UsuarioCreacion,
	FechaCreacion,
	UsuarioModificacion,
	FechaModificacion,
	Accion,
	Version		
	)
		values
		(
			@UnidadReplicacion,
	@IdEpisodioAtencion,
	@IdPaciente,
	@EpisodioClinico,
	@Complicaciones,
	@Pronostico,
	@TipoAlta,
	@CondicionEgreso,
	@CausaMuerte,
	@Necropsia,
	@PlanAlta,
	@Estado,
	@UsuarioCreacion,
	@FechaCreacion,
	@UsuarioModificacion,
	@FechaModificacion,
	@Accion,
	@Version
		)
		
		select @IdPaciente


END

else
if(@Accion='UPDATE')
begin
update SS_HC_Epicrisis_2_FE

		set 									

		Complicaciones=@Complicaciones,
	Pronostico = @Pronostico,
	TipoAlta= @TipoAlta,
	CondicionEgreso=@CondicionEgreso,
	CausaMuerte=@CausaMuerte,
	Necropsia=@Necropsia,
	PlanAlta=@PlanAlta,
	Estado=@Estado,
	UsuarioCreacion=@UsuarioCreacion,
	FechaCreacion=@FechaCreacion,
	UsuarioModificacion=@UsuarioModificacion,
	FechaModificacion=@FechaModificacion,
	Accion=@Accion
		WHERE 
		(UnidadReplicacion= @UnidadReplicacion)				
		and ( IdPaciente= @IdPaciente)		
		and ( EpisodioClinico= @EpisodioClinico)
		and ( IdEpisodioAtencion= @IdEpisodioAtencion)		
						
		select @EpisodioClinico
end


else
	if(@ACCION = 'DELETE')
	begin			
		delete SS_HC_Epicrisis_2_FE
		WHERE 
		(UnidadReplicacion= @UnidadReplicacion)				
		and ( IdPaciente= @IdPaciente)		
		and ( EpisodioClinico= @EpisodioClinico)	
		and ( IdEpisodioAtencion= @IdEpisodioAtencion)

		select 1
	end


end


GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Epicrisis_2_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[SP_SS_HC_Epicrisis_2_Listar]
@UnidadReplicacion char(4) ,
@IdEpisodioAtencion bigint,
@IdPaciente int,
@EpisodioClinico int,
@IdMedicoTratante int,
@Especificar varchar(50),
@Redacta char(1),
@ManejoConjunto int,
@ManejoConjuntoDescri varchar (60),
@FechaIngreso datetime,
@HoraIngreso datetime,
@FechaEgreso datetime,
@HoraEgreso datetime,
@DiasHospitalizacion int,
@EnfermedadActual varchar(50),
@Antecedentes text,
@ExamenFisico text,
@Evolucion text,
@Estado int,
@UsuarioCreacion varchar(25),
@FechaCreacion datetime,
@UsuarioModificacion varchar(25),
@FechaModificacion datetime,
@Accion varchar(25),
@Version varchar(25)

as
begin 

	IF @Accion = 'LISTAR'

		select * from SS_HC_Epicrisis_2_FE where
		@UnidadReplicacion=UnidadReplicacion AND
		@IdEpisodioAtencion=IdEpisodioAtencion AND
		@IdPaciente=IdPaciente  AND 
		@EpisodioClinico=EpisodioClinico

	END

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Epicrisis_3_Principal_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_Epicrisis_3_Principal_Listar]

@UnidadReplicacion char(4)
,@IdEpisodioAtencion bigint 
,@IdPaciente int 
,@EpisodioClinico int 
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
		SELECT * FROM SS_HC_Epicrisis_3_Diag_Principal
		WHERE UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
			AND EpisodioClinico=@EpisodioClinico 
	END

END

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Epicrisis_3_Secundario_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_Epicrisis_3_Secundario_Listar]

@UnidadReplicacion char(4)
,@IdEpisodioAtencion bigint 
,@IdPaciente int 
,@EpisodioClinico int 
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
		SELECT * FROM SS_HC_Epicrisis_3_Diag_Secundaria
		WHERE UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
			AND EpisodioClinico=@EpisodioClinico 
	END



END

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Epicrisis_Diagnostico_Insert]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_Epicrisis_Diagnostico_Insert]
(
	@UnidadReplicacion	char(4) ,
	@IdEpisodioAtencion	int ,
	@IdPaciente	int ,
	@EpisodioClinico	int ,
	@Secuencia int, 
	@IdEpicrisis3	int,
	@DiagnosticoDescripcion varchar(250),
	@Codigo varchar(25),
	@Estado int,
	@UsuarioCreacion	varchar(25) ,
	@FechaCreacion	datetime ,
	@UsuarioModificacion	varchar(25) ,
	@FechaModificacion	datetime, 
	@Accion	varchar(25),
	@Version varchar(25)
			
)

AS
BEGIN 
SET NOCOUNT ON;
 	--DECLARE @IDSecuencia AS INT
 if(@ACCION = 'NUEVO')
	BEGIN

		INSERT INTO SS_HC_Epicrisis_3_Diagnostico
		(UnidadReplicacion,
		IdEpisodioAtencion,
		IdPaciente,
		EpisodioClinico,
		Secuencia,
		IdEpicrisis3,
		DiagnosticoDescripcion,
		Codigo,
		UsuarioCreacion,
		FechaCreacion,
		UsuarioModificacion,
		FechaModificacion,
		Accion,
		Version)
		 VALUES
		(@UnidadReplicacion,
		@IdEpisodioAtencion,
		@IdPaciente,
		@EpisodioClinico,
		@Secuencia,
		@IdEpicrisis3,
		@DiagnosticoDescripcion,
		@Codigo,
		@UsuarioCreacion,
		@FechaCreacion,
		@UsuarioModificacion,
		@FechaModificacion,
		@Accion,
		@Version)

		END

		if(@ACCION = 'UPDATE')
		BEGIN
			UPDATE SS_HC_Epicrisis_3_Diagnostico SET 
			IdEpicrisis3=@IdEpicrisis3,
			DiagnosticoDescripcion=@DiagnosticoDescripcion,
			UsuarioModificacion=@UsuarioModificacion,
			FechaModificacion=@FechaModificacion,
			Accion=@Accion,
			Version=@Version
			WHERE 
			--Codigo=@Codigo 
			--AND
			UnidadReplicacion=@UnidadReplicacion AND
			IdEpisodioAtencion=@IdEpisodioAtencion AND
			IdPaciente=@IdPaciente AND
			EpisodioClinico=@EpisodioClinico 
			--AND 
			--Secuencia=@Secuencia

		END

		if(@ACCION = 'DELETE')
		BEGIN
			DELETE FROM SS_HC_Epicrisis_3_Diagnostico 
			WHERE Codigo=@Codigo AND UnidadReplicacion=@UnidadReplicacion AND
			IdEpisodioAtencion=@IdEpisodioAtencion AND
			IdPaciente=@IdPaciente AND
			EpisodioClinico=@EpisodioClinico 
			--AND Secuencia=@Secuencia

		END

END	


GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Epicrisis_Insert]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_Epicrisis_Insert]
(
	@UnidadReplicacion	char(4) ,
	@EpisodioAtencion	int ,
	@IdPaciente	int ,
	@EpisodioClinico	int ,
	@IdEpicrisis3	int,
	@Complicaciones varchar(250),
	@Pronostico int,
	@TipoAlta int,
	@CondicionEgreso int,
	@CausaMuerte varchar(50),
	@PlanAlta varchar(120),
	@Necropsia int,
	@Estado int,
	@UsuarioCreacion	varchar(25) ,
	@FechaCreacion	datetime ,
	@UsuarioModificacion	varchar(25) ,
	@FechaModificacion	datetime, 
	@Accion	varchar(25),
	@Version varchar(25)
			
)

AS
BEGIN 
SET NOCOUNT ON;

		INSERT INTO SS_HC_Epicrisis_3 
		(UnidadReplicacion,
		IdEpisodioAtencion,
		IdPaciente,
		EpisodioClinico,
		IdEpicrisis3,
		Complicaciones,
		Pronostico,
		TipoAlta,
		CondicionEgreso,
		CausaMuerte,
		PlanAlta,
		Necropsia,
		Estado,
		UsuarioCreacion,
		FechaCreacion,
		UsuarioModificacion,
		Accion,
		Version) VALUES
		(@UnidadReplicacion,
		@EpisodioAtencion,
		@IdPaciente,
		@EpisodioClinico,
		@IdEpicrisis3,
		@Complicaciones,
		@Pronostico,
		@TipoAlta,
		@CondicionEgreso,
		@CausaMuerte,
		@PlanAlta,
		@Necropsia,
		@Estado,
		@UsuarioCreacion,
		@FechaCreacion,
		@UsuarioModificacion,
		@Accion,
		@Version)


END	


GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Epicrisis_Principal_Insert]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_Epicrisis_Principal_Insert]
(
	@UnidadReplicacion	char(4) ,
	@IdEpisodioAtencion	int ,
	@IdPaciente	int ,
	@EpisodioClinico	int ,
	@Secuencia int, 
	@IdEpicrisis3	int,
	@DiagnosticoDescripcion varchar(250),
	@Codigo varchar(25),
	@Estado int,
	@UsuarioCreacion	varchar(25) ,
	@FechaCreacion	datetime ,
	@UsuarioModificacion	varchar(25) ,
	@FechaModificacion	datetime, 
	@Accion	varchar(25),
	@Version varchar(25)
			
)

AS
BEGIN 
SET NOCOUNT ON;
 if(@ACCION = 'NUEVO')
	BEGIN

		DELETE FROM SS_HC_Epicrisis_3_Diag_Principal 
		WHERE Codigo=@Codigo AND UnidadReplicacion=@UnidadReplicacion AND
		IdEpisodioAtencion=@IdEpisodioAtencion AND
		IdPaciente=@IdPaciente AND
		EpisodioClinico=@EpisodioClinico AND Secuencia=@Secuencia

		INSERT INTO SS_HC_Epicrisis_3_Diag_Principal
		(UnidadReplicacion,
		IdEpisodioAtencion,
		IdPaciente,
		EpisodioClinico,
		Secuencia,
		IdEpicrisis3,
		DiagnosticoDescripcion,
		Codigo,
		UsuarioCreacion,
		FechaCreacion,
		UsuarioModificacion,
		FechaModificacion,
		Accion,
		Version) VALUES
		(@UnidadReplicacion,
		@IdEpisodioAtencion,
		@IdPaciente,
		@EpisodioClinico,
		@Secuencia,
		@IdEpicrisis3,
		@DiagnosticoDescripcion,
		@Codigo,
		@UsuarioCreacion,
		@FechaCreacion,
		@UsuarioModificacion,
		@FechaModificacion,
		@Accion,
		@Version)
		END
		if(@ACCION = 'UPDATE')
		BEGIN
		UPDATE SS_HC_Epicrisis_3_Diag_Principal SET 
		IdEpicrisis3=@IdEpicrisis3,
		DiagnosticoDescripcion=@DiagnosticoDescripcion,
		UsuarioModificacion=@UsuarioModificacion,
		FechaModificacion=@FechaModificacion,
		Accion=@Accion,
		Version=@Version
		WHERE Codigo=@Codigo AND UnidadReplicacion=@UnidadReplicacion AND
		IdEpisodioAtencion=@IdEpisodioAtencion AND
		IdPaciente=@IdPaciente AND
		EpisodioClinico=@EpisodioClinico AND Secuencia=@Secuencia

		END

		if(@ACCION = 'DELETE')
		BEGIN
		DELETE FROM SS_HC_Epicrisis_3_Diag_Principal 
		WHERE Codigo=@Codigo AND UnidadReplicacion=@UnidadReplicacion AND
		IdEpisodioAtencion=@IdEpisodioAtencion AND
		IdPaciente=@IdPaciente AND
		EpisodioClinico=@EpisodioClinico
		-- AND Secuencia=@Secuencia

		END

END	


GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Epicrisis_Secundario_Insert]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_Epicrisis_Secundario_Insert]
(
	@UnidadReplicacion	char(4) ,
	@IdEpisodioAtencion	int ,
	@IdPaciente	int ,
	@EpisodioClinico	int ,
	@Secuencia int, 
	@IdEpicrisis3	int,
	@DiagnosticoDescripcion varchar(250),
	@Codigo varchar(25),
	@Estado int,
	@UsuarioCreacion	varchar(25) ,
	@FechaCreacion	datetime ,
	@UsuarioModificacion	varchar(25) ,
	@FechaModificacion	datetime, 
	@Accion	varchar(25),
	@Version varchar(25)
			
)

AS
BEGIN 
SET NOCOUNT ON;
 if(@ACCION = 'NUEVO')
	BEGIN

		DELETE FROM SS_HC_Epicrisis_3_Diag_Secundaria 
		WHERE Codigo=@Codigo AND UnidadReplicacion=@UnidadReplicacion AND
		IdEpisodioAtencion=@IdEpisodioAtencion AND
		IdPaciente=@IdPaciente AND
		EpisodioClinico=@EpisodioClinico AND Secuencia=@Secuencia

		INSERT INTO SS_HC_Epicrisis_3_Diag_Secundaria
		(UnidadReplicacion,
		IdEpisodioAtencion,
		IdPaciente,
		EpisodioClinico,
		Secuencia,
		IdEpicrisis3,
		DiagnosticoDescripcion,
		Codigo,
		UsuarioCreacion,
		FechaCreacion,
		UsuarioModificacion,
		FechaModificacion,
		Accion,
		Version) VALUES
		(@UnidadReplicacion,
		@IdEpisodioAtencion,
		@IdPaciente,
		@EpisodioClinico,
		@Secuencia,
		@IdEpicrisis3,
		@DiagnosticoDescripcion,
		@Codigo,
		@UsuarioCreacion,
		@FechaCreacion,
		@UsuarioModificacion,
		@FechaModificacion,
		@Accion,
		@Version)
		END
		if(@ACCION = 'UPDATE')
		BEGIN
		UPDATE SS_HC_Epicrisis_3_Diag_Secundaria SET 
		IdEpicrisis3=@IdEpicrisis3,
		DiagnosticoDescripcion=@DiagnosticoDescripcion,
		UsuarioModificacion=@UsuarioModificacion,
		FechaModificacion=@FechaModificacion,
		Accion=@Accion,
		Version=@Version
		WHERE Codigo=@Codigo AND UnidadReplicacion=@UnidadReplicacion AND
		IdEpisodioAtencion=@IdEpisodioAtencion AND
		IdPaciente=@IdPaciente AND
		EpisodioClinico=@EpisodioClinico AND Secuencia=@Secuencia

		END

		if(@ACCION = 'DELETE')
		BEGIN
		DELETE FROM SS_HC_Epicrisis_3_Diag_Secundaria 
		WHERE Codigo=@Codigo AND UnidadReplicacion=@UnidadReplicacion AND
		IdEpisodioAtencion=@IdEpisodioAtencion AND
		IdPaciente=@IdPaciente AND
		EpisodioClinico=@EpisodioClinico 
		--AND Secuencia=@Secuencia

		END



END	
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Epicrisis2_Detalle_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_Epicrisis2_Detalle_FE]
(
			@UnidadReplicacion char(4) 
		   ,@IdEpisodioAtencion bigint 
           ,@IdPaciente int 
           ,@EpisodioClinico int 
           ,@Secuencia int 

           ,@IdEpicrisis2 int 
           ,@DiagnosticoDescripcion varchar(250) 
           
           ,@Codigo varchar(25) 
           ,@Estado int 
           ,@UsuarioCreacion varchar (25)
           ,@FechaCreacion datetime 
           ,@UsuarioModificacion  varchar (25)
           ,@FechaModificacion datetime 
           ,@Accion  varchar (25)
           ,@Version  varchar (25)

)
AS
BEGIN 


if(@Accion='INSERT')
BEGIN
insert into SS_HC_Epicrisis_2_Detalle_FE
		(
		UnidadReplicacion
           ,IdEpisodioAtencion
           ,IdPaciente
           ,EpisodioClinico
           ,Secuencia
           ,IdEpicrisis2
           ,DiagnosticoDescripcion
           
           ,Codigo
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
			@UnidadReplicacion
			,@IdEpisodioAtencion
           ,@IdPaciente
           ,@EpisodioClinico
           ,@Secuencia
           ,@IdEpicrisis2
           ,@DiagnosticoDescripcion
           
           ,@Codigo
           ,@Estado
           ,@UsuarioCreacion
           ,@FechaCreacion
           ,@UsuarioModificacion
           ,@FechaModificacion
           ,@Accion
           ,@Version
          
			
		)
		
		select @IdPaciente


END

else
if(@Accion='UPDATE')
begin
update SS_HC_Epicrisis_2_Detalle_FE
		set 									
			DiagnosticoDescripcion	=	@DiagnosticoDescripcion
			,Codigo=@Codigo
			,Estado	=	@Estado
			,UsuarioModificacion	=	@UsuarioModificacion
			,FechaModificacion	=	@FechaModificacion
			,Accion	=	@Accion	
		WHERE 
		(UnidadReplicacion= @UnidadReplicacion)				
		and ( IdPaciente= @IdPaciente)		
		and ( EpisodioClinico= @EpisodioClinico)
		and ( IdEpisodioAtencion= @IdEpisodioAtencion)		
						
		select 1
end


else
	if(@ACCION = 'DELETE')
	begin			
		delete SS_HC_Epicrisis_2_Detalle_FE
		WHERE 
		(UnidadReplicacion= @UnidadReplicacion)				
		and ( IdPaciente= @IdPaciente)		
		and ( EpisodioClinico= @EpisodioClinico)	
		and ( IdEpisodioAtencion= @IdEpisodioAtencion)

		select 1
	end


end
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_EpicrisisFE_2_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [dbo].[SP_SS_HC_EpicrisisFE_2_Listar]
@UnidadReplicacion char(4) ,
@IdEpisodioAtencion bigint,
@IdPaciente int,
@EpisodioClinico int,
@Complicaciones text,
@Pronostico varchar (50),
@TipoAlta varchar (50),
@CondicionEgreso varchar (50),
@CausaMuerte text,
@Necropsia char (1),
@PlanAlta text,
@Estado int,
@UsuarioCreacion varchar(25),
@FechaCreacion datetime,
@UsuarioModificacion varchar(25),
@FechaModificacion datetime,
@Accion varchar(25),
@Version varchar(25)

as
begin 

IF @Accion = 'LISTAR'

select * from SS_HC_Epicrisis_2_FE where
@UnidadReplicacion=UnidadReplicacion AND
@IdEpisodioAtencion=IdEpisodioAtencion AND
@IdPaciente=IdPaciente  AND 
@EpisodioClinico=EpisodioClinico

END


GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_EpisodioAtencion]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_EpisodioAtencion]
(
	@UnidadReplicacion	char(4) ,
	@IdEpisodioAtencion	bigint ,
	@UnidadReplicacionEC	char(4) ,
	@IdPaciente	int ,
	@EpisodioClinico	int ,	
	@IdEstablecimientoSalud	int ,
	@IdUnidadServicio	int ,
	@IdPersonalSalud	int ,
	@aaaaAtencion	int ,
	@EpisodioAtencion	bigint ,	
	@FechaRegistro	datetime ,
	@FechaAtencion	datetime ,
	@TipoAtencion	int ,
	@IdOrdenAtencion	int ,
	@LineaOrdenAtencion	int ,	
	@TipoOrdenAtencion	int ,
	@Estado	int ,
	@UsuarioCreacion	varchar(25) ,
	@FechaCreacion	datetime ,
	@UsuarioModificacion	varchar(25) ,	
	@FechaModificacion	datetime ,
	@IdEspecialidad	int ,
	@CodigoOA	varchar(15) ,
	@ProximaAtencionFlag	char(1) ,
	@IdEspecialidadProxima	int ,	
	@IdEstablecimientoSaludProxima	int ,
	@IdTipoInterConsulta	int ,
	@IdTipoReferencia	int ,
	@ObservacionProxima	text ,
	@DescansoMedico	varchar(200) ,	
	@DiasDescansoMedico	int ,
	@FechaInicioDescansoMedico	datetime ,
	@FechaFinDescansoMedico	datetime ,
	@FechaOrden	datetime ,
	@IdProcedimiento	int ,	
	@ObservacionOrden	text ,
	@IdTipoOrden	int ,	
	@Version	varchar(25) ,
	@FlagFirma	int ,
	@FechaFirma	datetime ,	
	@idMedicoFirma	int ,
	@ObservacionFirma	varchar(300) ,
	@KeyPrivada	nvarchar(300) ,
	@KeyPublica	nvarchar(300) ,	
	@TipoTrabajador varchar(10),
    @TipoEpisodio	varchar(20) ,	
	@TipoUbicacion	char(1),
	@IdUbicacion	int,		
	@ACCION	varchar(30) 
			
)

AS
BEGIN 
--SET XACT_ABORT ON
SET NOCOUNT ON;
BEGIN  TRANSACTION

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
	  TipoOpcion	varchar(1) null,
		IdFormato		int null,
		CodigoFormato		varchar(25) null
	 )  
	 
	 DECLARE @TABLA_OPCIONESAGENTE_PROCESO table       
	 (      
	  SECUENCIA   int  NOT NULL   IDENTITY PRIMARY KEY,      
	  IdFormato		int null,
	  CodigoFormato		varchar(25) null
	 )
	 	  
 	declare @cuenta int =1
 	declare @Total int =0
    declare @IdAgenteMax int =0
    declare @CodigoFormatoAux varchar(25)=0
 	---------------
	DECLARE @CONTADOR INT
	declare @IdAgente int;
	declare @IdEpisodioAtencionId BIGINT;
	declare @EpisodioClinicoID as INTEGER, 
		@ExisteCodigo as VARCHAR(10),
		@SecuenciaID as Integer,
		@TipoUbicacionVigenteAUX char(1) = null,
		@IdUbicacionVigenteAUX int = null


	if(@ACCION = 'COMPARTIDO')
	begin
			/*****************************************************************/
			/**  AGREGACIONES PARA AGREGAR LOS DATOS DE LOS FORMULARIOS COMPARTIDOS A LA NUEVA ATENCIÓN  **/
			/*****************************************************************/
											
			exec  SP_SS_HC_Copiar_EpisodioAtencion
							@UnidadReplicacion ,
							@IdPaciente,
							@EpisodioClinico,
							@IdEpisodioAtencion,
							@UnidadReplicacionEC,									
							null,
							null,
							@CodigoFormatoAux,
							null,								
							@UsuarioCreacion,	
							'FORM_COMPARTIDOS'	
																		
		--select @IdEpisodioAtencion
	END		
	--else	
	if(@ACCION = 'INSERT')
	begin				
		/**SECCIÓN PARA COPIAR LOS FORMULARIOS COMPARTIDOS*/

		/****************************************************/

		select @IdEpisodioAtencionId = ISNULL(max(IdEpisodioAtencion),0)+1 
			  from dbo.SS_HC_EpisodioAtencion 
			  
			  where UnidadReplicacion = @UnidadReplicacion 
			  and EpisodioClinico =@EpisodioClinico
			  and IdPaciente = @IdPaciente 
			
				
		-------------------------------------------------------------
		---REGISTRO EPI ATENCIÓN MASTER	
		if(@EpisodioAtencion is null)---EPISODIO DE ATENCÍÓN NUEVO (SI NO , NUEVA VISITA)
		begin
			select @EpisodioAtencion = ISNULL(max(EpisodioAtencion),0)+1  from SS_HC_EpisodioAtencionMaster			
			  where UnidadReplicacion = @UnidadReplicacion 
			  and EpisodioClinico =@EpisodioClinico
			  and IdPaciente = @IdPaciente 

			if(@CodigoOA is null)
				BEGIN
					EXEC SP_SS_HC_Correlativo '00000000','CEG' ,'OA',@NroPeticion=@CodigoOA output
					SET @Estado=0
					SET @TipoAtencion=1
				END 
		
			insert into SS_HC_EpisodioAtencionMaster
			(
				UnidadReplicacion,IdPaciente,EpisodioClinico,EpisodioAtencion,EpisodioAtencionCodigo
				,FechaRegistro,FechaAtencion,TipoAtencion,IdOrdenAtencion,CodigoOA
				,TipoOrdenAtencion,Estado,UsuarioCreacion,FechaCreacion,UsuarioModificacion
				,FechaModificacion,ProximaAtencionFlag,IdTipoInterConsulta,IdTipoReferencia,ObservacionProxima
				,FlagFirma,FechaFirma,idMedicoFirma,ObservacionFirma,KeyPrivada
				,KeyPublica,Accion,Version,UnidadReplicacionEC
			
			)values
			(
				@UnidadReplicacion,@IdPaciente,@EpisodioClinico,@EpisodioAtencion,null
				,@FechaRegistro,@FechaAtencion,@TipoAtencion,@IdOrdenAtencion,@CodigoOA
				,@TipoOrdenAtencion,@Estado,@UsuarioCreacion,GETDATE(),@UsuarioModificacion
				,@FechaModificacion,@ProximaAtencionFlag,@IdTipoInterConsulta,@IdTipoReferencia,@ObservacionProxima
				,@FlagFirma,@FechaFirma,@idMedicoFirma,@ObservacionProxima,@KeyPrivada
				,@KeyPublica,@Accion,@Version,@UnidadReplicacionEC
			)

			IF(@TipoAtencion = 2 OR @TipoAtencion = 3)  ---EPISODIO DE ATENCIÓN HOSPI Y EMERGEN  ACTUALIZACIÓN 31/01/2018
				BEGIN
			  	set @IdEpisodioAtencion = @EpisodioAtencion				
				set @IdEpisodioAtencionId = @EpisodioAtencion

				UPDATE SS_HC_EpisodioClinico	SET 	CodigoEpisodioClinico	=	@EpisodioAtencion	WHERE 
					UnidadReplicacion= @UnidadReplicacion	and IdPaciente= @IdPaciente   and EpisodioClinico =@EpisodioClinico
				END

			set  @IdTipoOrden = 1  --AUX PARA índice de VISITA
			if (@TipoAtencion=2 )
			begin
			select @IdTipoOrden = ISNULL(max(IdTipoOrden),0)+1 
			  from dbo.SS_HC_EpisodioAtencion 			  
			  where UnidadReplicacion = @UnidadReplicacion 
			  and IdOrdenAtencion =@IdOrdenAtencion
			  and TipoTrabajador <>'02'

			  set  @Version = @IdTipoOrden
			  set @TipoEpisodio='VISITA'
			end
			else
			begin
				set  @Version = @IdTipoOrden			
			end
			
		end
		else
		begin

			if (@TipoAtencion=2 )
			begin
			--AUX PARA índice de VISITA		
			select @IdTipoOrden = ISNULL(max(IdTipoOrden),0)+1 
			  from dbo.SS_HC_EpisodioAtencion 			  
			  where UnidadReplicacion = @UnidadReplicacion 
			  and IdOrdenAtencion =@IdOrdenAtencion
			   and TipoTrabajador <>'02'
			--------------
			set  @Version = @IdTipoOrden

			end

			else
			begin
			--AUX PARA índice de VISITA		
			select @IdTipoOrden = ISNULL(max(IdTipoOrden),0)+1 
			  from dbo.SS_HC_EpisodioAtencion 			  
			  where UnidadReplicacion = @UnidadReplicacion 
			  and EpisodioClinico =@EpisodioClinico
			  and IdPaciente = @IdPaciente 			  					
			  and EpisodioAtencion = @EpisodioAtencion 

			set  @Version = @IdTipoOrden


			end


			
		if(@TipoAtencion=2 and @FlagFirma <> 99) -- cambio para emergencia LUKE 09/03/2020
		begin
		select @IdEpisodioAtencionId = ISNULL(max(IdEpisodioAtencion),0)+1 
			  from dbo.SS_HC_EpisodioAtencion 			  
			  where UnidadReplicacion = @UnidadReplicacion 
			  and EpisodioClinico=@EpisodioClinico
			  and IdOrdenAtencion =@IdOrdenAtencion

		 	select @IdTipoOrden = ISNULL(max(IdTipoOrden),0)+1 
			  from dbo.SS_HC_EpisodioAtencion 			  
			  where UnidadReplicacion = @UnidadReplicacion 
			  and IdOrdenAtencion =@IdOrdenAtencion
		      and TipoTrabajador <>'02'
			--------------
			set  @Version = @IdTipoOrden
			set @EpisodioClinico=(select top 1 EpisodioClinico from SS_HC_EpisodioAtencion
			where UnidadReplicacion = @UnidadReplicacion 
			  and IdOrdenAtencion =@IdOrdenAtencion
			  and  IdPersonalSalud= (case when @TipoTrabajador='02' then (select top 1 IdPersonalSalud from SS_HC_EpisodioAtencion where IdOrdenAtencion=@IdOrdenAtencion and 
			  TipoOrdenAtencion=1 and LineaOrdenAtencion=1) else @IdPersonalSalud end) 
			 and  LineaOrdenAtencion=@LineaOrdenAtencion
			)

			set @TipoOrdenAtencion =(select top 1 TipoOrdenAtencion from SS_HC_EpisodioAtencion
			where UnidadReplicacion = @UnidadReplicacion 
			  and IdOrdenAtencion =@IdOrdenAtencion
			 and  IdPersonalSalud= (case when @TipoTrabajador='02' then (select top 1 IdPersonalSalud from SS_HC_EpisodioAtencion where IdOrdenAtencion=@IdOrdenAtencion and 
			  TipoOrdenAtencion=1 and LineaOrdenAtencion=1) else @IdPersonalSalud end) 
			  and  LineaOrdenAtencion=@LineaOrdenAtencion
			)
			set @IdEspecialidad =(select top 1 IdEspecialidad from SS_HC_EpisodioAtencion
			where UnidadReplicacion = @UnidadReplicacion 
			  and IdOrdenAtencion =@IdOrdenAtencion
			  and  IdPersonalSalud= (case when @TipoTrabajador='02' then (select top 1 IdPersonalSalud from SS_HC_EpisodioAtencion where IdOrdenAtencion=@IdOrdenAtencion and 
			  TipoOrdenAtencion=1 and LineaOrdenAtencion=1) else @IdPersonalSalud end) 
			 and  LineaOrdenAtencion=@LineaOrdenAtencion
			)	
			
				
		end

		else if(@TipoAtencion=2 and @FlagFirma = 99) --RELEVO
		begin
			select @IdEpisodioAtencionId = ISNULL(max(IdEpisodioAtencion),0)+1 
			  from dbo.SS_HC_EpisodioAtencion 			  
			  where UnidadReplicacion = @UnidadReplicacion 
			  and EpisodioClinico=@EpisodioClinico
			  and IdOrdenAtencion =@IdOrdenAtencion

		 	select @IdTipoOrden = ISNULL(max(IdTipoOrden),0)+1 
			  from dbo.SS_HC_EpisodioAtencion 			  
			  where UnidadReplicacion = @UnidadReplicacion 
			  and IdOrdenAtencion =@IdOrdenAtencion
			  and TipoTrabajador <>'02'
			--------------
			set  @Version = @IdTipoOrden
		end
		end
		
		if (@IdEpisodioAtencionId=1 AND @TipoAtencion=2)
		begin

		select @IdEpisodioAtencionId = ISNULL(max(IdEpisodioAtencion),0)+1 
		from dbo.SS_HC_EpisodioAtencion 			  
		where UnidadReplicacion = @UnidadReplicacion 
	     and EpisodioClinico=@EpisodioClinico
		and IdOrdenAtencion =@IdOrdenAtencion

		if(@TipoOrdenAtencion=1) 
		begin
		set @TipoEpisodio='EPISODIO'
		end
		else
		begin
		set @TipoEpisodio='VISITA'
		end				
		end
		set @IdEpisodioAtencion = @IdEpisodioAtencionId
		set @FlagFirma=null
	
	IF @TipoAtencion=1

		BEGIN
		/***************  LOG PARA GUARDAR EL IDESPECIALIDAD INICIO ******************/

		SELECT @IdEspecialidad=Especialidad FROM BDOncologico.DBO.SS_AD_OrdenAtencionDetalle WHERE IdOrdenAtencion=@IdOrdenAtencion and linea = @LineaOrdenAtencion

		END

		insert into SS_HC_EpisodioAtencion
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
			,Estado
			,UsuarioCreacion
			,FechaCreacion
			,UsuarioModificacion
			,FechaModificacion
			,IdEspecialidad
			,CodigoOA
			,ProximaAtencionFlag
			,IdEspecialidadProxima
			,IdEstablecimientoSaludProxima
			,IdTipoInterConsulta
			,IdTipoReferencia
			,ObservacionProxima
			,DescansoMedico
			,DiasDescansoMedico
			,FechaInicioDescansoMedico
			,FechaFinDescansoMedico
			,FechaOrden
			,IdProcedimiento
			,ObservacionOrden
			,IdTipoOrden
			,Accion
			,Version
			,FlagFirma
			,FechaFirma
			,idMedicoFirma
			,ObservacionFirma
			,KeyPrivada
			,KeyPublica
			,TipoTrabajador	
			,TipoEpisodio	

		)
		values(
			@UnidadReplicacion
		,	@IdEpisodioAtencion
		,	isnull(@UnidadReplicacionEC,@UnidadReplicacion)
		,	@IdPaciente
		,	@EpisodioClinico
		,	@IdEstablecimientoSalud
		,	@IdUnidadServicio
		,	(case when @IdPersonalSalud=0 then null else @IdPersonalSalud end )		
		,	@EpisodioAtencion
		,	isnull(@FechaRegistro, GETDATE())
		,	isnull(@FechaAtencion, GETDATE())
		,	@TipoAtencion
		,	@IdOrdenAtencion
		,	@LineaOrdenAtencion
		,	@TipoOrdenAtencion
		,	isnull(@Estado,2) --2: EN ATENCION
		,	@UsuarioCreacion
		,	GETDATE()
		,	@UsuarioModificacion
		,	GETDATE()
		,	@IdEspecialidad
		,	@CodigoOA
		,	@ProximaAtencionFlag
		,	@IdEspecialidadProxima
		,	@IdEstablecimientoSaludProxima
		,	@IdTipoInterConsulta
		,	@IdTipoReferencia
		,	@ObservacionProxima
		,	@DescansoMedico
		,	@DiasDescansoMedico
		,	@FechaInicioDescansoMedico
		,	@FechaFinDescansoMedico
		,	@FechaOrden
		,	@IdProcedimiento
		,	@ObservacionOrden
		,	@IdTipoOrden
		,	@Accion
		,	@Version
		,	@FlagFirma
		,	@FechaFirma
		,	@idMedicoFirma
		,	@ObservacionFirma
		,	@KeyPrivada
		,	@KeyPublica
		,	@TipoTrabajador	
		,	@TipoEpisodio				
		)


		/*********TOPICO / CAMA:  SE ASIGNA EL ÚLTIMO SI EXISTIESE******************/
			/****OBTENERMOS ÚLTIMOS IDubic y Tipo */
			select @IdUbicacionVigenteAUX=IdUbicacionVigente,
			@TipoUbicacionVigenteAUX=TipoUbicacionVigente from SS_HC_AgrupadorAtencionVigente
			where UnidadReplicacion = @UnidadReplicacion
			and IdPaciente = @IdPaciente
			and IdOrdenAtencion = @IdOrdenAtencion
			
			
			/****ACTUALIZAMOS LAS ATENCION ACTUAL  (idUbicacón  y tipo) ******/			
			update SS_HC_EpisodioAtencion
			set 
			TipoUbicacion =@TipoUbicacionVigenteAUX,
			IdUbicacion =@IdUbicacionVigenteAUX,
			FechaModificacion = GETDATE(),
			UsuarioModificacion = @UsuarioModificacion			
			where
			UnidadReplicacion = @UnidadReplicacion
			and IdPaciente = @IdPaciente
			and EpisodioClinico = @EpisodioClinico
			and IdEpisodioAtencion = @IdEpisodioAtencionId
	

			update SS_HC_AgrupadorAtencionVigente
			set 						
			EpisodioClinico= @EpisodioClinico,
			IdEpisodioAtencion= @IdEpisodioAtencionId,
			UsuarioModificacion = @UsuarioModificacion,
			FechaModificacion= GETDATE()
			where
			UnidadReplicacion = @UnidadReplicacion
			and IdPaciente = @IdPaciente
			and IdOrdenAtencion = convert(integer, @IdOrdenAtencion)	
		/*se coloca aca para prueba de IDCONSULTAEXTERNA SPRING INVOCAR SP*/
        declare @UnidadReplicacionAUX2 varchar(15)
		set @UnidadReplicacionAUX2 = @UnidadReplicacion

		if(@TipoAtencion=2 ) -- cambio para emergencia JORDAN 23/06/2020
		BEGIN
			IF @IdEpisodioAtencion=1
			BEGIN

				declare @idvar int
				declare @idTriajeHCE int

				--SELECT TOP 1 @idTriajeHCE=IdEpisodioTriajeHCE  FROM BDOncologico.dbo.[SS_CE_TriajeFirma] F 
				--INNER JOIN BDOncologico.dbo.SS_CE_Triaje T ON F.IdTriaje=T.IdTriaje
				--INNER JOIN BDOncologico.dbo.SS_AD_OrdenAtencion o ON T.IdOrdenAtencion=o.IdOrdenAtencion	
				--WHERE T.IdOrdenAtencion = @IdOrdenAtencion
				
				SELECT @idvar=ISNULL(max(IdFuncionVital),0)+1  FROM SS_HC_FuncionesVitales_FE 

				INSERT INTO SS_HC_FuncionesVitales_FE (UnidadReplicacion,IdEpisodioAtencion,IdPaciente,EpisodioClinico,IdFuncionVital,Fecha,Hora,
					PresionArterialMSD1,PresionArterialMSD2,PresionArterialMSI,PresionArterialMS2,Temperatura,FrecuenciaCardiaca,FrecuenciaRespiratoria,
					SaturacionOxigeno,FrecuenciaCardFetal_Flag,FrecuenciaCard_FetalAdd,Peso,estado,Accion,Version)
				SELECT @UnidadReplicacion,@IdEpisodioAtencionId,@IdPaciente,@EpisodioClinico,@idvar,GETDATE(),GETDATE(),
					PresionArterialMSD1,PresionArterialMSD2,PresionArterialMSI,PresionArterialMS2,Temperatura,FrecuenciaCardiaca,FrecuenciaRespiratoria,
					SaturacionOxigeno,FrecuenciaCardFetal_Flag,FrecuenciaCard_FetalAdd, Peso,2,'NUEVO','CCEPF051' FROM SS_HC_TriajeEmergencia_FE 
				WHERE EpisodioTriaje=@idTriajeHCE

			END
		END
			
		/*******************************************************************************/	

		select @IdEpisodioAtencionId
	end	

	--	else	
	if(@ACCION = 'INSERTENF')
	begin				

		select @IdEpisodioAtencionId = ISNULL(max(IdEpisodioAtencion),0)+1 
			  from dbo.SS_HC_EpisodioAtencion 			  
			  where UnidadReplicacion = @UnidadReplicacion 
			  and EpisodioClinico=@EpisodioClinico
			  and IdOrdenAtencion =@IdOrdenAtencion
			
		select @IdTipoOrden = ISNULL(max(IdTipoOrden),0)+1 
			  from dbo.SS_HC_EpisodioAtencion 			  
			  where UnidadReplicacion = @UnidadReplicacion 
			  and IdOrdenAtencion =@IdOrdenAtencion
			  and TipoTrabajador='02'
			--------------
		 	 set  @Version = @IdTipoOrden
			 set @TipoEpisodio='VISITA'
		-------------------------------------------------------------

		set @IdEpisodioAtencion = @IdEpisodioAtencionId
		set @FlagFirma=null
		
		insert into SS_HC_EpisodioAtencion
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
			,Estado
			,UsuarioCreacion
			,FechaCreacion
			,UsuarioModificacion
			,FechaModificacion
			,IdEspecialidad
			,CodigoOA
			,ProximaAtencionFlag
			,IdEspecialidadProxima
			,IdEstablecimientoSaludProxima
			,IdTipoInterConsulta
			,IdTipoReferencia
			,ObservacionProxima
			,DescansoMedico
			,DiasDescansoMedico
			,FechaInicioDescansoMedico
			,FechaFinDescansoMedico
			,FechaOrden
			,IdProcedimiento
			,ObservacionOrden
			,IdTipoOrden
			,Accion
			,Version
			,FlagFirma
			,FechaFirma
			,idMedicoFirma
			,ObservacionFirma
			,KeyPrivada
			,KeyPublica
			,TipoTrabajador	
			,TipoEpisodio	

		)
		values(
			@UnidadReplicacion
		,	@IdEpisodioAtencion
		,	isnull(@UnidadReplicacionEC,@UnidadReplicacion)
		,	@IdPaciente
		,	@EpisodioClinico
		,	@IdEstablecimientoSalud
		,	@IdUnidadServicio
		,	(case when @IdPersonalSalud=0 then null else @IdPersonalSalud end )		
		,	@EpisodioAtencion
		,	isnull(@FechaRegistro, GETDATE())
		,	isnull(@FechaAtencion, GETDATE())
		,	@TipoAtencion
		,	@IdOrdenAtencion
		,	@LineaOrdenAtencion
		,	@TipoOrdenAtencion
		,	isnull(@Estado,2) --2: EN ATENCION
		,	@UsuarioCreacion
		,	GETDATE()
		,	@UsuarioModificacion
		,	GETDATE()
		,	@IdEspecialidad
		,	@CodigoOA
		,	@ProximaAtencionFlag
		,	@IdEspecialidadProxima
		,	@IdEstablecimientoSaludProxima
		,	@IdTipoInterConsulta
		,	@IdTipoReferencia
		,	@ObservacionProxima
		,	@DescansoMedico
		,	@DiasDescansoMedico
		,	@FechaInicioDescansoMedico
		,	@FechaFinDescansoMedico
		,	@FechaOrden
		,	@IdProcedimiento
		,	@ObservacionOrden
		,	@IdTipoOrden
		,	@Accion
		,	@Version
		,	@FlagFirma
		,	@FechaFirma
		,	@idMedicoFirma
		,	@ObservacionFirma
		,	@KeyPrivada
		,	@KeyPublica
		,	@TipoTrabajador	
		,	@TipoEpisodio				
		)
		/*********TOPICO / CAMA:  SE ASIGNA EL ÚLTIMO SI EXISTIESE******************/
			/****OBTENERMOS ÚLTIMOS IDubic y Tipo */
			select @IdUbicacionVigenteAUX=IdUbicacionVigente,
			@TipoUbicacionVigenteAUX=TipoUbicacionVigente from SS_HC_AgrupadorAtencionVigente
			where UnidadReplicacion = @UnidadReplicacion
			and IdPaciente = @IdPaciente
			and IdOrdenAtencion = @IdOrdenAtencion
			
			
			/****ACTUALIZAMOS LAS ATENCION ACTUAL  (idUbicacón  y tipo) ******/			
			update SS_HC_EpisodioAtencion
			set 
			TipoUbicacion =@TipoUbicacionVigenteAUX,
			IdUbicacion =@IdUbicacionVigenteAUX,
			FechaModificacion = GETDATE(),
			UsuarioModificacion = @UsuarioModificacion			
			where
			UnidadReplicacion = @UnidadReplicacion
			and IdPaciente = @IdPaciente
			and EpisodioClinico = @EpisodioClinico
			and IdEpisodioAtencion = @IdEpisodioAtencionId
	
			/**De existir SS_HC_AgrupadorAtencionVigente, lo actuzalizamos*/
			update SS_HC_AgrupadorAtencionVigente
			set 						
			EpisodioClinico= @EpisodioClinico,
			IdEpisodioAtencion= @IdEpisodioAtencionId,
			UsuarioModificacion = @UsuarioModificacion,
			FechaModificacion= GETDATE()
			where
			UnidadReplicacion = @UnidadReplicacion
			and IdPaciente = @IdPaciente
			and IdOrdenAtencion = convert(integer, @IdOrdenAtencion)	
		
		/*******************************************************************************/	

		select @IdEpisodioAtencionId
	end	

	--else
	if(@ACCION = 'UPDATE')
	begin			
			set @IdEpisodioAtencionId = @IdEpisodioAtencion
			
		update SS_HC_EpisodioAtencion
		set 						
			UnidadReplicacionEC	=	@UnidadReplicacionEC
			,IdEstablecimientoSalud	=	@IdEstablecimientoSalud
			,IdUnidadServicio	=	@IdUnidadServicio
			,IdPersonalSalud	=	@IdPersonalSalud			
			,EpisodioAtencion	=	@EpisodioAtencion
			,FechaRegistro	=	@FechaRegistro
			,FechaAtencion	=	@FechaAtencion
			,TipoAtencion	=	@TipoAtencion
			,IdOrdenAtencion	=	@IdOrdenAtencion
			,LineaOrdenAtencion	=	@LineaOrdenAtencion
			,TipoOrdenAtencion	=	@TipoOrdenAtencion
			,Estado	=	@Estado
			,UsuarioModificacion	=	@UsuarioModificacion
			,FechaModificacion	=	GETDATE()
			,CodigoOA	=	@CodigoOA
			,ProximaAtencionFlag	=	@ProximaAtencionFlag
			,IdEstablecimientoSaludProxima	=	@IdEstablecimientoSaludProxima
			,IdTipoInterConsulta	=	@IdTipoInterConsulta
			,IdTipoReferencia	=	@IdTipoReferencia
			,ObservacionProxima	=	@ObservacionProxima
			,DescansoMedico	=	@DescansoMedico
			,DiasDescansoMedico	=	@DiasDescansoMedico
			,FechaInicioDescansoMedico	=	@FechaInicioDescansoMedico
			,FechaFinDescansoMedico	=	@FechaFinDescansoMedico
			,FechaOrden	=	@FechaOrden
			,IdProcedimiento	=	@IdProcedimiento
			,ObservacionOrden	=	@ObservacionOrden
			,IdTipoOrden	=	@IdTipoOrden
			,Accion	=	@Accion
			,Version	=	@Version
			,FlagFirma	=	@FlagFirma
			,FechaFirma	=	@FechaFirma
			,idMedicoFirma	=	@idMedicoFirma
			,ObservacionFirma	=	@ObservacionFirma
			,KeyPrivada	=	@KeyPrivada
			,KeyPublica	=	@KeyPublica
			,TipoTrabajador	= @TipoTrabajador	
			,TipoEpisodio = @TipoEpisodio
			,IdUbicacion=null
		
		WHERE 
		(UnidadReplicacion= @UnidadReplicacion)		
		and (IdEpisodioAtencion= @IdEpisodioAtencion)		
		and ( IdPaciente= @IdPaciente)		
		and ( EpisodioClinico= @EpisodioClinico)	
		
		if(@TipoAtencion=2)
		begin
		update SS_HC_EpisodioAtencion
		set IdUbicacion=null
		where 
		(UnidadReplicacion= @UnidadReplicacion)		
		--and (IdEpisodioAtencion= @IdEpisodioAtencion)		
		and ( IdPaciente= @IdPaciente)		
		and ( EpisodioClinico= @EpisodioClinico)
		and TipoAtencion=2
		end	
						
		select @IdEpisodioAtencionId
				
	end	
	--else
	if(@ACCION = 'DELETE')
	begin			
		delete SS_HC_EpisodioAtencion
		WHERE 
		(UnidadReplicacion= @UnidadReplicacion)		
		and (IdEpisodioAtencion= @IdEpisodioAtencion)		
		and ( IdPaciente= @IdPaciente)		
		and ( EpisodioClinico= @EpisodioClinico)	
		
		set  @IdEpisodioAtencionId= 1
		select @IdEpisodioAtencionId
	end
	--else
	if(@ACCION = 'PROC_INTEROPERABILIDAD')
	begin	 	
		
		declare @UnidadReplicacionAUX varchar(15)
		set @UnidadReplicacionAUX = @UnidadReplicacion
		
		--exec SP_HCE_InteroperabilidadSalidaV0001 		@UnidadReplicacionAUX,		@EpisodioAtencion,		
		--@IdPaciente,		@EpisodioClinico

		----	MODIFICADO JORDAN MATEO 07/07/2020
		--EXEC SP_HCE_InteroperabilidadSalidaV0004 @UnidadReplicacionAUX,		@EpisodioAtencion,	
		----@idEpisodioAtencion,Cambio por Logica
		--@IdPaciente,		@EpisodioClinico
			
		set  @IdEpisodioAtencionId= 1
		select @IdEpisodioAtencionId
		
	end
	--else 
	if (@ACCION='ANULAROA')
	begin
	declare  @secmax int
	declare @secuencias int
	set @secmax= (select MAX(secuencia) from SS_HC_EpisodioAtencion_Anulado)
	set @secuencias = (case when @secmax IS null or @secmax=0  then 1 else @secmax+1 end)

	insert into SS_HC_EpisodioAtencion_Anulado (UnidadReplicacion,EpisodioClinico,IdEpisodioAtencion,
	IdPaciente,Secuencia,CodigoOA,MotivoAnulacion,IdMedico,Estado,
	UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,Accion,Version)	
	VALUES(@UnidadReplicacion,@EpisodioClinico,@IdEpisodioAtencion,@IdPaciente, 
	@secuencias,@CodigoOA,@ObservacionProxima,@idMedicoFirma,1,@UsuarioCreacion,GETDATE(),
	@UsuarioCreacion,GETDATE(),@ACCION,'AMBULATORIO')

	
	set  @IdEpisodioAtencionId= 1
		select @IdEpisodioAtencionId	
	
	end

	--	else 
	if (@ACCION='RELEVAME')
	begin
	declare  @medicotitular int
	set @medicotitular= (select IdPersonalSalud from SS_HC_EpisodioAtencion where CodigoOA=@CodigoOA and IdEpisodioAtencion=1)

		set  @IdEpisodioAtencionId= 1
		select @IdEpisodioAtencionId	
	
	end

		if(@ACCION = 'PROC_FIRMARACTO')
	begin	 	
		declare @UnidadReplicacionAUXint varchar(15)
		set @UnidadReplicacionAUXint = @UnidadReplicacion

			--	MODIFICADO JORDAN MATEO 07/07/2020
		EXEC SP_HCE_InteroperabilidadSalidaV0004 @UnidadReplicacion,		@EpisodioAtencion,	
		--@idEpisodioAtencion,Cambio por Logica
		@IdPaciente,		@EpisodioClinico

		if(@IdUbicacion=1 and @TipoAtencion in (2,3))-- accion para cerrar emergencia con alta médica
		begin
		
			update SS_HC_EpisodioAtencion
			set 									
				IdUbicacion	=	3,
				FechaFirma = GETDATE()	
			WHERE 
			(UnidadReplicacion= @UnidadReplicacion)		
			and (IdOrdenAtencion= @IdOrdenAtencion)	
			and (LineaOrdenAtencion= @LineaOrdenAtencion)	
		
		end		

		if(@TipoAtencion=3) -- firma de emergencia
		begin
		exec SP_HCE_InteroperabilidadSalidaV0002 
		@UnidadReplicacionAUXint,
		@EpisodioAtencion,		
		@IdPaciente,
		@EpisodioClinico
			

		update SS_HC_EpisodioAtencion
		set 									
			UsuarioModificacion	=	@UsuarioModificacion
			,FechaModificacion	=	GETDATE()
			,FlagFirma	=	@FlagFirma
			,FechaFirma	=	@FechaFirma
			,idMedicoFirma	=	@idMedicoFirma
			,ObservacionFirma	=	@ObservacionFirma
			,KeyPrivada	=	@KeyPrivada
			,KeyPublica	=	@KeyPublica
			,Estado = 3 
		
		WHERE 
		(UnidadReplicacion= @UnidadReplicacion)		
		and (IdEpisodioAtencion= @IdEpisodioAtencion)	
		and ( IdPaciente= @IdPaciente)		
		and ( EpisodioClinico= @EpisodioClinico)
		end

		else
		begin

		exec SP_HCE_InteroperabilidadSalidaV0002 
		@UnidadReplicacionAUXint,
		@EpisodioAtencion,		
		@IdPaciente,
		@EpisodioClinico
			

		update SS_HC_EpisodioAtencion
		set 									
			UsuarioModificacion	=	@UsuarioModificacion
			,FechaModificacion	=	GETDATE()
			,FlagFirma	=	@FlagFirma
			,FechaFirma	=	@FechaFirma
			,idMedicoFirma	=	@idMedicoFirma
			,ObservacionFirma	=	@ObservacionFirma
			,KeyPrivada	=	@KeyPrivada
			,KeyPublica	=	@KeyPublica
			,Estado = 3 
		
		WHERE 
		(UnidadReplicacion= @UnidadReplicacion)		
		and (EpisodioAtencion= @EpisodioAtencion)	
		and ( IdPaciente= @IdPaciente)		
		and ( EpisodioClinico= @EpisodioClinico)
		end
		set  @IdEpisodioAtencionId= 1
		select @IdEpisodioAtencionId	
	end	

	--else
	if(@ACCION = 'ALTAMEDICA')
	begin
		
		update SS_HC_EpisodioAtencion set IdUbicacion=3 where IdOrdenAtencion=@IdOrdenAtencion AND (TipoOrdenAtencion=1 or TipoOrdenAtencion=11)
			and	(UnidadReplicacion= @UnidadReplicacion)		
			and (IdEpisodioAtencion= @IdEpisodioAtencion)
			and ( IdPaciente= @IdPaciente)		
			and ( EpisodioClinico= @EpisodioClinico)	

		set  @IdEpisodioAtencionId= 1				 	
		select @IdEpisodioAtencionId		
	end	
--	else

	if(@ACCION = 'ALTA_UPDATE')
	begin
		
		update SS_HC_EpisodioAtencion set Estado=3 
		where 
		CodigoOA=@CodigoOA
		and
		UnidadReplicacion=@UnidadReplicacion
			and	(UnidadReplicacion= @UnidadReplicacion)		
			and (IdEpisodioAtencion= @IdEpisodioAtencion)
			and ( IdPaciente= @IdPaciente)		
			and ( EpisodioClinico= @EpisodioClinico)	

		set  @IdEpisodioAtencionId= 1
		select @IdEpisodioAtencionId

	end	
	--else

	if(@ACCION = 'VALIDA_ALTA')
	begin
		DECLARE @validaalta int =0;

		set @validaalta= (
			select max(hc_episodioaten.IdEpisodioAtencion) from SS_HC_InformeAlta_FE infoalta
			inner join SS_HC_EpisodioAtencion hc_episodioaten
			on hc_episodioaten.EpisodioClinico=infoalta.EpisodioClinico
			and hc_episodioaten.IdPaciente=infoalta.IdPaciente
			and hc_episodioaten.idepisodioatencion =infoalta.idepisodioatencion
			and hc_episodioaten.tipotrabajador='08'
			where hc_episodioaten.CodigoOA=@CodigoOA 
			and infoalta.hcaltamedica=1
			and hc_episodioaten.UnidadReplicacion=@UnidadReplicacion
		)

		set  @IdEpisodioAtencionId= @validaalta
		select @IdEpisodioAtencionId
	end	

	if(@ACCION = 'VALIDA_ALTA_FORM')
	begin
		DECLARE @validaalta2 int =0;

		set @validaalta2= (
			select max(hc_episodioaten.IdEpisodioAtencion) from SS_HC_InformeAlta_FE infoalta
			inner join SS_HC_EpisodioAtencion hc_episodioaten
			on hc_episodioaten.EpisodioClinico=infoalta.EpisodioClinico
			and hc_episodioaten.IdPaciente=infoalta.IdPaciente
			and hc_episodioaten.idepisodioatencion =infoalta.idepisodioatencion
			and hc_episodioaten.tipotrabajador='08'
			where hc_episodioaten.CodigoOA=@CodigoOA 
			--and hc_episodioaten.FlagFirma=1 -- esta columna no se esta guardando
			and infoalta.hcaltamedica=1
			and hc_episodioaten.UnidadReplicacion=@UnidadReplicacion
			AND  hc_episodioaten.idepisodioatencion <> @IdEpisodioAtencion
		)

		set  @IdEpisodioAtencionId= @validaalta2
		select @IdEpisodioAtencionId
	end	

--	else

	if(@ACCION = 'ALTAMEDICARE')
	begin	 	
		
		update SS_HC_EpisodioAtencion set IdUbicacion=3 where IdOrdenAtencion=@IdOrdenAtencion AND (TipoOrdenAtencion=1 or TipoOrdenAtencion=11)
			and	(UnidadReplicacion= @UnidadReplicacion)		
			and (IdEpisodioAtencion= @IdEpisodioAtencion)
			and ( IdPaciente= @IdPaciente)		
			and ( EpisodioClinico= @EpisodioClinico)	
		set  @IdEpisodioAtencionId= 1				 	
		select @IdEpisodioAtencionId		
	end	

	--		else
	if(@ACCION = 'ALTAMEDICAEME')
	begin	 	
		
		update SS_HC_EpisodioAtencion set IdUbicacion=3 where IdOrdenAtencion=@IdOrdenAtencion AND (TipoOrdenAtencion=1 or TipoOrdenAtencion=11)
			and	(UnidadReplicacion= @UnidadReplicacion)		
			and (IdEpisodioAtencion= @IdEpisodioAtencion)
			and ( IdPaciente= @IdPaciente)		
			and ( EpisodioClinico= @EpisodioClinico)	
		set  @IdEpisodioAtencionId= 1				 	
		select @IdEpisodioAtencionId		
	end	
--	else
	if(@ACCION = 'EPISODIOCLINICO')
	begin	 	
		 -- select * from dbo.SS_HC_EpisodioAtencion
		--	select * from dbo.SS_HC_EpisodioClinico
			select @EpisodioClinicoID = ISNULL(max(EpisodioClinico),0)+1 
				 from dbo.SS_HC_EpisodioClinico 
				WHERE 
				(UnidadReplicacion= @UnidadReplicacion)						
				and ( IdPaciente= @IdPaciente)						
				 
			 Insert into dbo.SS_HC_EpisodioClinico
				(UnidadReplicacion, IdPaciente, EpisodioClinico, 
				 FechaRegistro,   Estado, UsuarioCreacion,IdOrdenAtencion, 
				 FechaCreacion, UsuarioModificacion, FechaModificacion)
				 values 
				 (@UnidadReplicacion, @IdPaciente, @EpisodioClinicoID, 
				 GETDATE(), 2, @UsuarioCreacion, @IdOrdenAtencion,
				 GETDATE(), @UsuarioModificacion,GETDATE())

		set  @IdEpisodioAtencionId= @EpisodioClinicoID				 	
		select @IdEpisodioAtencionId		
	end		
--	else	 
	 IF @Accion = 'FINALIZAATENCION'
		BEGIN
		set @IdEpisodioAtencionId = @IdEpisodioAtencion

			Update SS_HC_EpisodioAtencion 
			set Estado = 3 ,
			UsuarioModificacion =@UsuarioModificacion,
			FechaModificacion = GETDATE()
			 Where 
			(UnidadReplicacion= @UnidadReplicacion)		
			and (IdEpisodioAtencion= @IdEpisodioAtencion) 
			--and (EpisodioAtencion= @IdEpisodioAtencion) CAMBIO POR LOGICA
			and ( IdPaciente= @IdPaciente)		
			and ( EpisodioClinico= @EpisodioClinico)				 
			And	CodigoOA =@CodigoOA
						
			select @IdEpisodioAtencionId;				 
		END	
	if(@ACCION = 'CONTINUAR')
	begin							
		-------------------------------------------------------------
		--DECLARE @CODMEDICO int
		DECLARE @XEpiAten int
		DECLARE @XEpiClin int
		DECLARE @YEpiAten int

		DECLARE @CoEpiCli int
		select @CoEpiCli=CodigoEpisodioClinico from dbo.SS_HC_EpisodioClinico 
				WHERE 
					(UnidadReplicacion= @UnidadReplicacion)						
					and ( IdPaciente= @IdPaciente)	
					and (EpisodioClinico=@EpisodioClinico)
					
		select @EpisodioClinico = ISNULL(max(EpisodioClinico),0)+1  from dbo.SS_HC_EpisodioClinico 
				WHERE 
					(UnidadReplicacion= @UnidadReplicacion)						
					and ( IdPaciente= @IdPaciente)
										
		Insert into dbo.SS_HC_EpisodioClinico
					(UnidadReplicacion, IdPaciente, EpisodioClinico,CodigoEpisodioClinico, 
					 FechaRegistro,   Estado, UsuarioCreacion,IdOrdenAtencion, 
					 FechaCreacion, UsuarioModificacion, FechaModificacion)
				values 
					 (@UnidadReplicacion, @IdPaciente, @EpisodioClinico, @CoEpiCli,
					 GETDATE(), 2, @UsuarioCreacion, @IdOrdenAtencion,
					 GETDATE(), @UsuarioModificacion,GETDATE())
	
		select @YEpiAten= COUNT(CodigoEpisodioClinico), @IdEpisodioAtencion = COUNT(CodigoEpisodioClinico)  from SS_HC_EpisodioClinico	
		where CodigoEpisodioClinico=@CoEpiCli
		and UnidadReplicacion = @UnidadReplicacion 
		and IdPaciente = @IdPaciente 	
	 
		select @EpisodioAtencion= ISNULL(max(EpisodioAtencion),0)+1  from SS_HC_EpisodioAtencionMaster			
			  WHERE UnidadReplicacion = @UnidadReplicacion 
			  and EpisodioClinico =@EpisodioClinico
			  and IdPaciente = @IdPaciente 	
  							
			insert into SS_HC_EpisodioAtencionMaster
			(
				UnidadReplicacion,IdPaciente,EpisodioClinico,EpisodioAtencion,EpisodioAtencionCodigo
				,FechaRegistro,FechaAtencion,TipoAtencion,IdOrdenAtencion,CodigoOA
				,TipoOrdenAtencion,Estado,UsuarioCreacion,FechaCreacion,UsuarioModificacion
				,FechaModificacion,ProximaAtencionFlag,IdTipoInterConsulta,IdTipoReferencia,ObservacionProxima
				,FlagFirma,FechaFirma,idMedicoFirma,ObservacionFirma,KeyPrivada
				,KeyPublica,Accion,Version ,UnidadReplicacionEC
			
			)values
			(
				@UnidadReplicacion,@IdPaciente,@EpisodioClinico,@EpisodioAtencion,@YEpiAten
				,@FechaRegistro,@FechaAtencion,@TipoAtencion,@IdOrdenAtencion,@CodigoOA
				,@TipoOrdenAtencion,@Estado,@UsuarioCreacion,isnull(@FechaCreacion, GETDATE()) ,@UsuarioModificacion
				,@FechaModificacion,@ProximaAtencionFlag,@IdTipoInterConsulta,@IdTipoReferencia,@ObservacionProxima
				,@FlagFirma,@FechaFirma,@idMedicoFirma,@ObservacionFirma,@KeyPrivada
				,@KeyPublica,@Accion,@Version	,@UnidadReplicacionEC		
			)					  					
		
		set  @Version =@YEpiAten
				
		insert into SS_HC_EpisodioAtencion
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
			,Estado
			,UsuarioCreacion
			,FechaCreacion
			,UsuarioModificacion
			,FechaModificacion
			,IdEspecialidad
			,CodigoOA
			,ProximaAtencionFlag
			,IdEspecialidadProxima
			,IdEstablecimientoSaludProxima
			,IdTipoInterConsulta
			,IdTipoReferencia
			,ObservacionProxima
			,DescansoMedico
			,DiasDescansoMedico
			,FechaInicioDescansoMedico
			,FechaFinDescansoMedico
			,FechaOrden
			,IdProcedimiento
			,ObservacionOrden
			,IdTipoOrden
			,Accion
			,Version
			,FlagFirma
			,FechaFirma
			,idMedicoFirma
			,ObservacionFirma
			,KeyPrivada
			,KeyPublica
			,TipoTrabajador	
			,TipoEpisodio	

		)
		values(
			@UnidadReplicacion
		,	@IdEpisodioAtencion
		,	isnull(@UnidadReplicacionEC,@UnidadReplicacion)
		,	@IdPaciente
		,	@EpisodioClinico
		,	@IdEstablecimientoSalud
		,	@IdUnidadServicio
		,	(case when @IdPersonalSalud=0 then null else @IdPersonalSalud end )
		,	@EpisodioAtencion
		,	isnull(@FechaRegistro, GETDATE())
		,	isnull(@FechaAtencion, GETDATE())
		,	@TipoAtencion
		,	@IdOrdenAtencion
		,	@LineaOrdenAtencion
		,	@TipoOrdenAtencion
		,	isnull(@Estado,2) --2: EN ATENCION
		,	@UsuarioCreacion
		,	GETDATE()
		,	@UsuarioModificacion
		,	GETDATE()
		,	@IdEspecialidad
		,	@CodigoOA
		,	@ProximaAtencionFlag
		,	@IdEspecialidadProxima
		,	@IdEstablecimientoSaludProxima
		,	@IdTipoInterConsulta
		,	@IdTipoReferencia
		,	@ObservacionProxima
		,	@DescansoMedico
		,	@DiasDescansoMedico
		,	@FechaInicioDescansoMedico
		,	@FechaFinDescansoMedico
		,	@FechaOrden
		,	@IdProcedimiento
		,	@ObservacionOrden
		,	@IdTipoOrden
		,	@Accion
		,	@Version
		,	@FlagFirma
		,	@FechaFirma
		,	@idMedicoFirma
		,	@ObservacionFirma
		,	@KeyPrivada
		,	@KeyPublica
		,	@TipoTrabajador	
		,	@TipoEpisodio				
		)
			
			 
		set @IdEpisodioAtencionId=@EpisodioAtencion
		select @IdEpisodioAtencionId
	end		
--	else
	if(@ACCION = 'ABRIREPICLINICO')
	begin

		select @CONTADOR = COUNT(*) from SS_HC_EpisodioAtencionMaster 
		where 	IdPaciente = @IdPaciente
		and IdOrdenatencion =@IdOrdenAtencion
		
		if(@CONTADOR>0)
			begin
				select top 1 @EpisodioClinicoID = EpisodioClinico from SS_HC_EpisodioAtencionMaster 
				where IdPaciente = @IdPaciente
				and IdOrdenatencion =@IdOrdenAtencion
				
				select convert(bigint,@EpisodioClinicoID)		
			end
		else
		begin
     	
		/*****/	
		set @IdEpisodioAtencionId = 0
			select @IdEpisodioAtencionId
		end
	end		
--	else
	if(@ACCION = 'CARGAADICIONAL')
	begin			
		--select * from SS_GE_Paciente
	
		select @CONTADOR = COUNT(*) from SS_AD_OrdenAtencion
		where IdOrdenAtencion = @IdOrdenAtencion		
		if(@CONTADOR = 0)
		begin
			insert into SS_AD_OrdenAtencion
			(
				IdOrdenAtencion,TipoOrdenAtencion,CodigoOA,Especialidad,TipoAtencion,
				TipoPaciente,IdServicio,IdPaciente,IdEmpresaAseguradora,Compania,
				Sucursal,IdEstablecimiento,EstadoDocumento,EstadoDocumentoAnterior,Estado,
				UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,IdEmpleado,
				UnidadReplicacion,Modalidad,FechaInicio,FechaFinal,IdContrato
			)
			values
			(
				@IdOrdenAtencion,@TipoOrdenAtencion,@CodigoOA,@IdEspecialidad,@TipoAtencion,
				@IdEstablecimientoSaludProxima,null,@IdPaciente,@IdUbicacion,null,
				null,@IdEstablecimientoSalud,null,null,null,
				@UsuarioCreacion,GETDATE(),@UsuarioModificacion,GETDATE(),@IdPersonalSalud,
				@UnidadReplicacion,@IdProcedimiento,@FechaInicioDescansoMedico,@FechaFinDescansoMedico,@FlagFirma
			)
		end
		
		select @CONTADOR= COUNT(*)  from SS_AD_OrdenAtencionDetalle
		where IdOrdenAtencion = @IdOrdenAtencion
		and Linea = @LineaOrdenAtencion
		if(@CONTADOR = 0)
		begin
			insert into SS_AD_OrdenAtencionDetalle
			(
				IdOrdenAtencion,Linea,TipoOrdenAtencion,Especialidad,IdServicio,
				IdPaciente,Compania,Sucursal,IdEstablecimiento,
				Estado,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion				
			)
			values
			(
				@IdOrdenAtencion,@LineaOrdenAtencion,@TipoOrdenAtencion,@IdEspecialidad,null,
				@IdPaciente,null,null,@IdEstablecimientoSalud,
				null,@UsuarioCreacion,GETDATE(),@UsuarioModificacion,GETDATE()				
			)
		end		
		
			set @IdEpisodioAtencionId = 0
			select @IdEpisodioAtencionId
	end		
	
commit	
--SET XACT_ABORT OFF	
END	


/*
exec SP_SS_HC_EpisodioAtencion
	'CEG',2,NULL,1072676,2,	
	NULL,NULL,NULL,NULL,NULL,		
	NULL,NULL,NULL,NULL,NULL,	
	NULL,NULL,'ROYAL', --
	NULL,NULL,		
	NULL,NULL,NULL,NULL,NULL,
		
	NULL,NULL,NULL,NULL,NULL,
	NULL,NULL,NULL,NULL,NULL,		
	NULL,NULL,NULL,NULL,NULL,		
	NULL,NULL,NULL,NULL,					
	NULL,NULL,NULL,NULL,		
	'COMPARTIDO'
	
*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_EpisodioAtencionListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_EpisodioAtencionListar]
(
	@UnidadReplicacion	char(4) ,
	@IdEpisodioAtencion	bigint ,
	@UnidadReplicacionEC	char(4) ,
	@IdPaciente	int ,
	@EpisodioClinico	int ,	
	@IdEstablecimientoSalud	int ,
	@IdUnidadServicio	int ,
	@IdPersonalSalud	int ,
	@aaaaAtencion	int ,
	@EpisodioAtencion	bigint ,	
	@FechaRegistro	datetime ,
	@FechaAtencion	datetime ,
	@TipoAtencion	int ,
	@IdOrdenAtencion	int ,
	@LineaOrdenAtencion	int ,	
	@TipoOrdenAtencion	int ,
	@Estado	int ,
	@UsuarioCreacion	varchar(25) ,
	@FechaCreacion	datetime ,
	@UsuarioModificacion	varchar(25) ,
	
	@FechaModificacion	datetime ,
	@IdEspecialidad	int ,
	@CodigoOA	varchar(15) ,
	@ProximaAtencionFlag	char(1) ,
	@IdEspecialidadProxima	int ,
	
	@IdEstablecimientoSaludProxima	int ,
	@IdTipoInterConsulta	int ,
	@IdTipoReferencia	int ,
	@ObservacionProxima	text ,
	@DescansoMedico	varchar(200) ,
	
	@DiasDescansoMedico	int ,
	@FechaInicioDescansoMedico	datetime ,
	@FechaFinDescansoMedico	datetime ,
	@FechaOrden	datetime ,
	@IdProcedimiento	int ,
	
	@ObservacionOrden	text ,
	@IdTipoOrden	int ,	
	@Version	varchar(25) ,
	@FlagFirma	int ,
	@FechaFirma	datetime ,
	
	@idMedicoFirma	int ,
	@ObservacionFirma	varchar(300) ,
	@KeyPrivada	nvarchar(300) ,
	@KeyPublica	nvarchar(300) ,
	
	@TipoTrabajador varchar(10),
    @TipoEpisodio	varchar(20) ,
    
	@TipoUbicacion	char(1),
	@IdUbicacion	int,
	
	@ACCION	varchar(30) 
			
)

AS
BEGIN 
SET NOCOUNT ON;

	DECLARE @CONTADOR INT
	declare @IdAgenteAux int;
	declare @EpisodioClinicoAux int =0;
	if(@ACCION = 'LISTAR')
	begin		 		

		select 
			  EpiAtencion.UnidadReplicacion
			  ,EpiAtencion.IdPaciente
			  ,EpiAtencion.EpisodioClinico
			  ,EpiAtencion.EpisodioAtencion
			  ,EpiAtencion.IdEpisodioAtencion
			  ,EpiAtencion.IdOrdenAtencion
			  ,EpiAtencion.LineaOrdenAtencion
			  ,EpiAtencion.CodigoOA
			  ,EpiAtencion.TipoAtencion
			  ,EpiAtencion.UnidadReplicacionEC
			  ,EpiAtencion.TipoOrdenAtencion
			  ,EpiAtencion.TipoTrabajador
			  ,EpiAtencion.TipoEpisodio
			  ,EpiAtencion.IdEpisodioAtencionCodigo
			  ,EpiAtencion.IdEstablecimientoSalud
			  ,EpiAtencion.IdUnidadServicio
			  ,EpiAtencion.IdPersonalSalud
			  ,EpiAtencion.FechaRegistro
			  ,EpiAtencion.FechaAtencion
			  ,EpiAtencion.Estado
			  ,EpiAtencion.UsuarioCreacion
			  ,EpiAtencion.FechaCreacion
			  ,EpiAtencion.UsuarioModificacion
			  ,EpiAtencion.FechaModificacion
			  ,EpiAtencion.IdEspecialidad
			  ,EpiAtencion.ProximaAtencionFlag
			  ,EpiAtencion.IdEspecialidadProxima
			  ,EpiAtencion.IdEstablecimientoSaludProxima
			  ,EpiAtencion.IdTipoInterConsulta
			  ,EpiAtencion.IdTipoReferencia
			  ,EpiAtencion.ObservacionProxima
			  ,EpiAtencion.DescansoMedico
			  ,EpiAtencion.DiasDescansoMedico
			  ,EpiAtencion.FechaInicioDescansoMedico
			  ,EpiAtencion.FechaFinDescansoMedico
			  ,EpiAtencion.FechaOrden
			  ,EpiAtencion.IdProcedimiento
			  ,PERSONAMAST.NombreCompleto AS ObservacionOrden
			  ,EpiAtencion.IdTipoOrden
			  ,EpiClinico.CodigoEpisodioClinico as FlagFirma
			  ,EpiAtencion.FechaFirma
			  ,EpiAtencion.idMedicoFirma
			  ,SS_GE_Especialidad.Descripcion  as ObservacionFirma
			  ,EpiAtencion.KeyPrivada
			  ,EpiAtencion.KeyPublica
			  ,EpiAtencion.Accion
			  ,EpiAtencion.Version		
			  ,EpiAtencion.TipoUbicacion
			  ,EpiAtencion.IdUbicacion
			  ,EpiAtencion.FlagCierrePorRegla --ADD		
		from SS_HC_EpisodioAtencion EpiAtencion
		inner join SS_HC_EpisodioClinico EpiClinico		on (EpiClinico.UnidadReplicacion = EpiAtencion.UnidadReplicacion
					and EpiClinico.IdPaciente = EpiAtencion.IdPaciente	and EpiClinico.EpisodioClinico = EpiAtencion.EpisodioClinico		)
		LEFT join SS_GE_Especialidad 	on (	SS_GE_Especialidad.IdEspecialidad = EpiAtencion.IdEspecialidad	)
		LEFT join PERSONAMAST 		on (	PERSONAMAST.Persona = EpiAtencion.IdPersonalSalud			)
		where
			(@UnidadReplicacion  is null or EpiAtencion.UnidadReplicacion= @UnidadReplicacion)	
		---agregado jordan mateo 07/06/2019
		and (@EpisodioAtencion is null or @EpisodioAtencion = 0  or EpiAtencion.EpisodioAtencion= @EpisodioAtencion)
		and (@IdEpisodioAtencion is null or @IdEpisodioAtencion = 0  or EpiAtencion.IdEpisodioAtencion= @IdEpisodioAtencion)
		--and (@IdEpisodioAtencion is null or @IdEpisodioAtencion = 0  or EpiAtencion.EpisodioAtencion= @IdEpisodioAtencion)	
		---			
		and (@IdPaciente		 is null or  EpiAtencion.IdPaciente= @IdPaciente)		
		and (@EpisodioClinico	 is null or @EpisodioClinico =0 or  EpiAtencion.EpisodioClinico= @EpisodioClinico)
		---agregado jordan mateo 02/04/2019
		and (@IdOrdenAtencion	 is null or @IdOrdenAtencion =0 or  EpiAtencion.IdOrdenAtencion= @IdOrdenAtencion)	
		and (@LineaOrdenAtencion is null or @LineaOrdenAtencion =0 or  EpiAtencion.LineaOrdenAtencion= @LineaOrdenAtencion)
		-----
		and (@TipoAtencion		 is null or @TipoAtencion = 0 or  EpiAtencion.TipoAtencion= @TipoAtencion)	
		and (@IdPersonalSalud	 is null or @IdPersonalSalud = 0 or  EpiAtencion.IdPersonalSalud= @IdPersonalSalud)

		---agregado Nick Pasco 11/02/2021
		and (@CodigoOA  is null or EpiAtencion.CodigoOA= @CodigoOA)	
		and (@IdEspecialidad  is null or EpiAtencion.IdEspecialidad= @IdEspecialidad)	
		AND (@FechaAtencion IS NULL OR EpiAtencion.FechaAtencion < DATEADD(DAY,1,@FechaAtencion))
		
		order by  EpiAtencion.FechaRegistro desc --luke 19/07/2019
	end	

	if(@ACCION = 'LISTARTRIAJE')
	begin		 		
	
		select 
			  EpiAtencion.UnidadReplicacion
			  ,EpiAtencion.IdPaciente
			  ,EpiAtencion.IdEpisodioTriaje as EpisodioClinico
			  ,CONVERT(bigint, EpiAtencion.IdEpisodioTriaje) as EpisodioAtencion
			  ,CONVERT(bigint, EpiAtencion.IdEpisodioTriaje) as IdEpisodioAtencion
			  ,EpiAtencion.IdEpisodioTriaje as IdOrdenAtencion
			  ,EpiAtencion.IdEpisodioTriaje as LineaOrdenAtencion
			  ,EpiAtencion.CodigoOT as CodigoOA
			  ,EpiAtencion.IdEpisodioTriaje as TipoAtencion
			  ,EpiAtencion.UnidadReplicacion as UnidadReplicacionEC
			  ,EpiAtencion.IdEpisodioTriaje as TipoOrdenAtencion
			  ,EpiAtencion.Version as TipoTrabajador
			  ,EpiAtencion.Version as TipoEpisodio
			  ,EpiAtencion.Version as IdEpisodioAtencionCodigo
			  ,EpiAtencion.IdEpisodioTriaje as IdEstablecimientoSalud
			  ,EpiAtencion.IdEpisodioTriaje as IdUnidadServicio
			  ,EpiAtencion.IdPersonalSalud
			  ,EpiAtencion.FechaAtencion as FechaRegistro
			  ,EpiAtencion.FechaAtencion 
			  ,EpiAtencion.Estado
			  ,EpiAtencion.UsuarioCreacion
			  ,EpiAtencion.FechaAtencion as FechaCreacion
			  ,EpiAtencion.UsuarioModificacion
			  ,EpiAtencion.FechaModificacion
			  ,EpiAtencion.IdEspecialidad
			  ,EpiAtencion.Version as ProximaAtencionFlag
			  ,EpiAtencion.IdEspecialidad as IdEspecialidadProxima
			  ,EpiAtencion.IdEpisodioTriaje as IdEstablecimientoSaludProxima
			  ,EpiAtencion.IdEpisodioTriaje as IdTipoInterConsulta
			  ,EpiAtencion.IdEpisodioTriaje as IdTipoReferencia
			  ,EpiAtencion.Version as ObservacionProxima
			  ,EpiAtencion.Version as DescansoMedico
			  ,EpiAtencion.IdEpisodioTriaje as DiasDescansoMedico
			  ,EpiAtencion.FechaAtencion as FechaInicioDescansoMedico
			  ,EpiAtencion.FechaAtencion as FechaFinDescansoMedico
			  ,EpiAtencion.FechaAtencion as FechaOrden
			  ,EpiAtencion.IdEpisodioTriaje as IdProcedimiento
			  ,PERSONAMAST.NombreCompleto AS ObservacionOrden
			  ,EpiAtencion.IdEpisodioTriaje as IdTipoOrden
			  ,EpiAtencion.IdEpisodioTriaje as FlagFirma
			  ,EpiAtencion.FechaFirma
			  ,EpiAtencion.idMedicoFirma
			  ,SS_GE_Especialidad.Descripcion  as ObservacionFirma
			  ,EpiAtencion.Version  as KeyPrivada
			  ,EpiAtencion.Version as KeyPublica
			  ,EpiAtencion.Accion
			  ,EpiAtencion.Version		
			  ,EpiAtencion.Version as TipoUbicacion
			  ,EpiAtencion.IdEpisodioTriaje as IdUbicacion
			  ,EpiAtencion.IdEpisodioTriaje as FlagCierrePorRegla --ADD			
		from SS_HC_EpisodioTriaje EpiAtencion

		LEFT join SS_GE_Especialidad 	on (	SS_GE_Especialidad.IdEspecialidad = EpiAtencion.IdEspecialidad	)
		LEFT join PERSONAMAST 		on (	PERSONAMAST.Persona = EpiAtencion.IdPersonalSalud			)
		where
			(@UnidadReplicacion  is null or EpiAtencion.UnidadReplicacion= @UnidadReplicacion)	
		and (@IdPaciente		 is null or  EpiAtencion.IdPaciente= @IdPaciente)			
		and (@IdPersonalSalud	 is null or @IdPersonalSalud = 0 or  EpiAtencion.IdPersonalSalud= @IdPersonalSalud)		
		order by  EpiAtencion.FechaAtencion desc 
	end	
	--else
	if(@ACCION = 'LISTARPORID')
	begin		 

		select 
			  UnidadReplicacion
			  ,IdPaciente
			  ,EpisodioClinico
			  ,EpisodioAtencion
			  ,IdEpisodioAtencion
			  ,IdOrdenAtencion
			  ,LineaOrdenAtencion
			  ,CodigoOA
			  ,TipoAtencion
			  ,UnidadReplicacionEC
			  ,TipoOrdenAtencion
			  ,TipoTrabajador
			  ,TipoEpisodio
			  ,IdEpisodioAtencionCodigo
			  ,IdEstablecimientoSalud
			  ,IdUnidadServicio
			  ,IdPersonalSalud
			  ,FechaRegistro
			  ,FechaAtencion
			  ,Estado
			  ,UsuarioCreacion
			  ,FechaCreacion
			  ,UsuarioModificacion
			  ,FechaModificacion
			  ,IdEspecialidad
			  ,ProximaAtencionFlag
			  ,IdEspecialidadProxima
			  ,IdEstablecimientoSaludProxima
			  ,IdTipoInterConsulta
			  ,IdTipoReferencia
			  ,ObservacionProxima
			  ,DescansoMedico
			  ,DiasDescansoMedico
			  ,FechaInicioDescansoMedico
			  ,FechaFinDescansoMedico
			  ,FechaOrden
			  ,IdProcedimiento
			  ,ObservacionOrden
			  ,IdTipoOrden
			  ,(select CodigoEpisodioClinico from SS_HC_EpisodioClinico EpiClinico
					where
					(EpiClinico.UnidadReplicacion= @UnidadReplicacion)		
					and (EpiClinico.EpisodioClinico= @EpisodioClinico)		
					and ( EpiClinico.IdPaciente= @IdPaciente)					
				 ) as FlagFirma  --AUX
			  ,FechaFirma
			  ,idMedicoFirma
			  ,ObservacionFirma
			  ,KeyPrivada
			  ,KeyPublica
			  ,Accion
			  ,Version		
			  ,TipoUbicacion
			  ,IdUbicacion
			  ,FlagCierrePorRegla --ADD
		from SS_HC_EpisodioAtencion
		where
		(UnidadReplicacion= @UnidadReplicacion)		
		and (EpisodioAtencion= @IdEpisodioAtencion)	
		and ( IdPaciente= @IdPaciente)		
		and ( EpisodioClinico= @EpisodioClinico)	
		
	end	


	if(@ACCION = 'LISTARPORFIRM')
	begin		 

		select 
			  UnidadReplicacion
			  ,IdPaciente
			  ,EpisodioClinico
			  ,EpisodioAtencion
			  ,IdEpisodioAtencion
			  ,IdOrdenAtencion
			  ,LineaOrdenAtencion
			  ,CodigoOA
			  ,TipoAtencion
			  ,UnidadReplicacionEC
			  ,TipoOrdenAtencion
			  ,TipoTrabajador
			  ,TipoEpisodio
			  ,IdEpisodioAtencionCodigo
			  ,IdEstablecimientoSalud
			  ,IdUnidadServicio
			  ,IdPersonalSalud
			  ,FechaRegistro
			  ,FechaAtencion
			  ,Estado
			  ,UsuarioCreacion
			  ,FechaCreacion
			  ,UsuarioModificacion
			  ,FechaModificacion
			  ,IdEspecialidad
			  ,ProximaAtencionFlag
			  ,IdEspecialidadProxima
			  ,IdEstablecimientoSaludProxima
			  ,IdTipoInterConsulta
			  ,IdTipoReferencia
			  ,ObservacionProxima
			  ,DescansoMedico
			  ,DiasDescansoMedico
			  ,FechaInicioDescansoMedico
			  ,FechaFinDescansoMedico
			  ,FechaOrden
			  ,IdProcedimiento
			  ,ObservacionOrden
			  ,IdTipoOrden
			  ,(select CodigoEpisodioClinico from SS_HC_EpisodioClinico EpiClinico
					where
					(EpiClinico.UnidadReplicacion= @UnidadReplicacion)		
					and (EpiClinico.EpisodioClinico= @EpisodioClinico)		
					and ( EpiClinico.IdPaciente= @IdPaciente)					
				 ) as FlagFirma  --AUX
			  ,FechaFirma
			  ,idMedicoFirma
			  ,ObservacionFirma
			  ,KeyPrivada
			  ,KeyPublica
			  ,Accion
			  ,Version		
			  ,TipoUbicacion
			  ,IdUbicacion
			  ,FlagCierrePorRegla --ADD
		from SS_HC_EpisodioAtencion
		where
		(UnidadReplicacion= @UnidadReplicacion)		
		and (IdOrdenAtencion= @IdOrdenAtencion)		
		
	end	


		if(@ACCION = 'LISTARENFER')
	begin		 

		select 
			  UnidadReplicacion
			  ,IdPaciente
			  ,EpisodioClinico
			  ,EpisodioAtencion
			  ,IdEpisodioAtencion
			  ,IdOrdenAtencion
			  ,LineaOrdenAtencion
			  ,CodigoOA
			  ,TipoAtencion
			  ,UnidadReplicacionEC
			  ,TipoOrdenAtencion
			  ,TipoTrabajador
			  ,TipoEpisodio
			  ,IdEpisodioAtencionCodigo
			  ,IdEstablecimientoSalud
			  ,IdUnidadServicio
			  ,IdPersonalSalud
			  ,FechaRegistro
			  ,FechaAtencion
			  ,Estado
			  ,UsuarioCreacion
			  ,FechaCreacion
			  ,UsuarioModificacion
			  ,FechaModificacion
			  ,IdEspecialidad
			  ,ProximaAtencionFlag
			  ,IdEspecialidadProxima
			  ,IdEstablecimientoSaludProxima
			  ,IdTipoInterConsulta
			  ,IdTipoReferencia
			  ,ObservacionProxima
			  ,DescansoMedico
			  ,DiasDescansoMedico
			  ,FechaInicioDescansoMedico
			  ,FechaFinDescansoMedico
			  ,FechaOrden
			  ,IdProcedimiento
			  ,ObservacionOrden
			  ,IdTipoOrden
			  ,(select CodigoEpisodioClinico from SS_HC_EpisodioClinico EpiClinico
					where
					(EpiClinico.UnidadReplicacion= @UnidadReplicacion)		
					and (EpiClinico.EpisodioClinico= @EpisodioClinico)		
					and ( EpiClinico.IdPaciente= @IdPaciente)					
				 ) as FlagFirma  --AUX
			  ,FechaFirma
			  ,idMedicoFirma
			  ,ObservacionFirma
			  ,KeyPrivada
			  ,KeyPublica
			  ,Accion
			  ,Version		
			  ,TipoUbicacion
			  ,IdUbicacion
			  ,FlagCierrePorRegla --ADD
		from SS_HC_EpisodioAtencion
		where
		(UnidadReplicacion= @UnidadReplicacion)		
		and ( IdPaciente= @IdPaciente)		
		and (TipoTrabajador = '02' )
		and  (Estado =3)
		and (IdOrdenAtencion=@IdOrdenAtencion)
		
	end	

		if(@ACCION = 'LISTARPORIDEMER')
	begin		 

		select 
			  UnidadReplicacion
			  ,IdPaciente
			  ,EpisodioClinico
			  ,EpisodioAtencion
			  ,IdEpisodioAtencion
			  ,IdOrdenAtencion
			  ,LineaOrdenAtencion
			  ,CodigoOA
			  ,TipoAtencion
			  ,UnidadReplicacionEC
			  ,TipoOrdenAtencion
			  ,TipoTrabajador
			  ,TipoEpisodio
			  ,IdEpisodioAtencionCodigo
			  ,IdEstablecimientoSalud
			  ,IdUnidadServicio
			  ,IdPersonalSalud
			  ,FechaRegistro
			  ,FechaAtencion
			  ,Estado
			  ,UsuarioCreacion
			  ,FechaCreacion
			  ,UsuarioModificacion
			  ,FechaModificacion
			  ,IdEspecialidad
			  ,ProximaAtencionFlag
			  ,IdEspecialidadProxima
			  ,IdEstablecimientoSaludProxima
			  ,IdTipoInterConsulta
			  ,IdTipoReferencia
			  ,ObservacionProxima
			  ,DescansoMedico
			  ,DiasDescansoMedico
			  ,FechaInicioDescansoMedico
			  ,FechaFinDescansoMedico
			  ,FechaOrden
			  ,IdProcedimiento
			  ,ObservacionOrden
			  ,IdTipoOrden
			  ,(select CodigoEpisodioClinico from SS_HC_EpisodioClinico EpiClinico
					where
					(EpiClinico.UnidadReplicacion= @UnidadReplicacion)		
					and (EpiClinico.EpisodioClinico= @EpisodioClinico)		
					and ( EpiClinico.IdPaciente= @IdPaciente)					
				 ) as FlagFirma  --AUX
			  ,FechaFirma
			  ,idMedicoFirma
			  ,ObservacionFirma
			  ,KeyPrivada
			  ,KeyPublica
			  ,Accion
			  ,Version		
			  ,TipoUbicacion
			  ,IdUbicacion
			  ,FlagCierrePorRegla --ADD
		from SS_HC_EpisodioAtencion
		where
		(UnidadReplicacion= @UnidadReplicacion)		
		and (IdOrdenAtencion= @IdOrdenAtencion)		
		and ( IdPaciente= @IdPaciente)		
		
		
	end	



	if(@ACCION = 'LISTARPORIDHOSP')
	begin		 

		select 
			  UnidadReplicacion
			  ,IdPaciente
			  ,EpisodioClinico
			  ,EpisodioAtencion
			  ,IdEpisodioAtencion
			  ,IdOrdenAtencion
			  ,LineaOrdenAtencion
			  ,CodigoOA
			  ,TipoAtencion
			  ,UnidadReplicacionEC
			  ,TipoOrdenAtencion
			  ,TipoTrabajador
			  ,TipoEpisodio
			  ,IdEpisodioAtencionCodigo
			  ,IdEstablecimientoSalud
			  ,IdUnidadServicio
			  ,IdPersonalSalud
			  ,FechaRegistro
			  ,FechaAtencion
			  ,Estado
			  ,UsuarioCreacion
			  ,FechaCreacion
			  ,UsuarioModificacion
			  ,FechaModificacion
			  ,IdEspecialidad
			  ,ProximaAtencionFlag
			  ,IdEspecialidadProxima
			  ,IdEstablecimientoSaludProxima
			  ,IdTipoInterConsulta
			  ,IdTipoReferencia
			  ,ObservacionProxima
			  ,DescansoMedico
			  ,DiasDescansoMedico
			  ,FechaInicioDescansoMedico
			  ,FechaFinDescansoMedico
			  ,FechaOrden
			  ,IdProcedimiento
			  ,ObservacionOrden
			  ,IdTipoOrden
			  ,(select CodigoEpisodioClinico from SS_HC_EpisodioClinico EpiClinico
					where
					(EpiClinico.UnidadReplicacion= @UnidadReplicacion)		
					and (EpiClinico.EpisodioClinico= @EpisodioClinico)		
					and ( EpiClinico.IdPaciente= @IdPaciente)					
				 ) as FlagFirma  --AUX
			  ,FechaFirma
			  ,idMedicoFirma
			  ,ObservacionFirma
			  ,KeyPrivada
			  ,KeyPublica
			  ,Accion
			  ,Version		
			  ,TipoUbicacion
			  ,IdUbicacion
			  ,FlagCierrePorRegla --ADD
		from SS_HC_EpisodioAtencion
		where
		(UnidadReplicacion= @UnidadReplicacion)		
		and (IdEpisodioAtencion= @IdEpisodioAtencion)
		and ( IdPaciente= @IdPaciente)		
		and ( EpisodioClinico= @EpisodioClinico)	
		
	end	
	--else
	if(@ACCION = 'ATENCIONFORMATO')
	begin		 
		select 
	  UnidadReplicacion
      ,IdPaciente
      ,EpisodioClinico
      ,EpisodioAtencion
      ,IdEpisodioAtencion
      ,IdOrdenAtencion
      ,LineaOrdenAtencion
      ,CodigoOA
      ,TipoAtencion
      ,UnidadReplicacionEC
      ,TipoOrdenAtencion
      ,TipoTrabajador
      ,TipoEpisodio
      ,IdEpisodioAtencionCodigo
      ,IdEstablecimientoSalud
      ,IdUnidadServicio
      ,IdPersonalSalud
      ,FechaRegistro
      ,FechaAtencion
      ,Estado
      ,UsuarioCreacion
      ,FechaCreacion
      ,UsuarioModificacion
      ,FechaModificacion
      ,IdEspecialidad
      ,ProximaAtencionFlag
      ,IdEspecialidadProxima
      ,IdEstablecimientoSaludProxima
      ,IdTipoInterConsulta
      ,IdTipoReferencia
      ,ObservacionProxima
      ,DescansoMedico
      ,DiasDescansoMedico
      ,FechaInicioDescansoMedico
      ,FechaFinDescansoMedico
      ,FechaOrden
      ,IdTransaccionesX  as IdProcedimiento
      ,ObservacionOrden
      ,IdTipoOrden
      ,FlagFirma
      ,FechaFirma
      ,idMedicoFirma
      ,ObservacionFirma
      ,KeyPrivada
      ,KeyPublica
      ,Accion
      ,Version
		,TipoUbicacion
		,IdUbicacion  
		,FlagCierrePorRegla --ADD    
		from (
			select 
				EpiAtencion.*,
				EpiAtencionFormato.IdTransacciones as IdTransaccionesX
				from
				SS_HC_EpisodioAtencion as EpiAtencion
				inner join 
				SS_HC_EpisodioAtencionFormato  as EpiAtencionFormato
				on(				
					EpiAtencion.UnidadReplicacion= EpiAtencionFormato.UnidadReplicacion
					and EpiAtencion.IdEpisodioAtencion= EpiAtencionFormato.IdEpisodioAtencion
					and  EpiAtencion.IdPaciente= EpiAtencionFormato.IdPaciente
					and  EpiAtencion.EpisodioClinico= EpiAtencionFormato.EpisodioClinico
				)
				where
				(EpiAtencionFormato.UnidadReplicacion= @UnidadReplicacion)		
				and (EpiAtencionFormato.IdEpisodioAtencion= @IdEpisodioAtencion)		
				and ( EpiAtencionFormato.IdPaciente= @IdPaciente)		
				and ( EpiAtencionFormato.EpisodioClinico= @EpisodioClinico)	
				and (EpiAtencionFormato.IdOpcion= @IdTipoReferencia)	
				and (EpiAtencionFormato.IdForm = @IdTipoInterConsulta)				
		)as EPI_FORMATO
						
	end	
	--else
	if(@ACCION = 'ATENCIONTECMEDICO')
	begin		 
		select 
	  UnidadReplicacion
      ,IdPaciente
      ,EpisodioClinico
      ,EpisodioAtencion
      ,convert(bigint,RowNumber) as  IdEpisodioAtencion
      ,IdOrdenAtencion
      ,LineaOrdenAtencion
      ,CodigoOA
      ,TipoAtencion
      ,UnidadReplicacionEC
      ,TipoOrdenAtencion
      ,TipoTrabajador
      ,TipoEpisodio
      ,IdEpisodioAtencionCodigo
      ,IdEstablecimientoSalud
      ,IdUnidadServicio
      ,IdPersonalSalud
      ,FechaSolitadaX as FechaRegistro
      ,FechaAtencion
      ,Estado
      ,UsuarioCreacion
      ,FechaCreacion
      ,NombreEmpleadoCreador as UsuarioModificacion
      ,FechaModificacion
      ,IdEspecialidad
      ,ProximaAtencionFlag
      ,IdEspecialidadProxima
      ,IdEstablecimientoSaludProxima
      ,IdTipoInterConsulta
      ,IdTipoReferencia
      ,ObservacionProxima
      ,CodigoProcedimientoX  as DescansoMedico
      ,DiasDescansoMedico
      ,FechaInicioDescansoMedico
      ,FechaFinDescansoMedico
      ,FechaOrden
      ,IdProcedimientoX  as IdProcedimiento
      ,NombreProcX as ObservacionOrden
      ,IdTipoOrden
      ,0 as FlagFirma
      ,FechaFirma
      ,idMedicoFirma
      ,ObservacionFirma
      ,convert(nvarchar,IdEpisodioAtencion) as KeyPrivada
      ,KeyPublica
      ,Accion
      ,Version
	,TipoUbicacion
	,IdUbicacion      
	,FlagCierrePorRegla --ADD
		from (
			select 
				EpiAtencion.*,
				empleadoTrab.NombreCompleto as NombreEmpleadoCreador,
				SS_GE_ProcedimientoMedico.Nombre as NombreProcX,
				SS_GE_ProcedimientoMedico.CodigoProcedimiento as CodigoProcedimientoX,
				SS_HC_ExamenSolicitado.IdProcedimiento as IdProcedimientoX,
				SS_HC_ExamenSolicitado.FechaSolitada as FechaSolitadaX,
				ROW_NUMBER() OVER (ORDER BY EpiAtencion.IdEpisodioAtencion ASC ) AS RowNumber        
			from SS_HC_ExamenSolicitado  
			inner join SS_HC_EpisodioAtencion as EpiAtencion
			on (SS_HC_ExamenSolicitado.UnidadReplicacion= EpiAtencion.UnidadReplicacion
			and SS_HC_ExamenSolicitado.IdPaciente= EpiAtencion.IdPaciente
			and SS_HC_ExamenSolicitado.EpisodioClinico= EpiAtencion.EpisodioClinico
			and SS_HC_ExamenSolicitado.IdEpisodioAtencion= EpiAtencion.IdEpisodioAtencion
			)
			left join SS_GE_ProcedimientoMedico 
			on(SS_GE_ProcedimientoMedico.IdProcedimiento = SS_HC_ExamenSolicitado.IdProcedimiento)			
			left join PERSONAMAST empleadoTrab
			on(empleadoTrab.Persona = EpiAtencion.IdPersonalSalud)						
			where 
			EpiAtencion.IdPaciente = @IdPaciente				
			and (@IdOrdenAtencion is null or IdOrdenAtencion = @IdOrdenAtencion)
			and (@EpisodioClinico is null or EpiAtencion.EpisodioClinico = @EpisodioClinico or @EpisodioClinico =0)
			and ( (select COUNT(*) from SS_HC_ProcedimientoEjecucion procEjec
					where procEjec.UnidadReplicacionSolicitado = SS_HC_ExamenSolicitado.UnidadReplicacion
					and procEjec.EpisodioClinicoSolicitado = SS_HC_ExamenSolicitado.EpisodioClinico
					and procEjec.IdPacienteSolicitado = SS_HC_ExamenSolicitado.IdPaciente
					and procEjec.IdEpisodioAtencionSolicitado = SS_HC_ExamenSolicitado.IdEpisodioAtencion
					and procEjec.IdProcedimiento = SS_HC_ExamenSolicitado.IdProcedimiento
				  ) 
					= 0
				)
		   and (     
			(@FechaInicioDescansoMedico is null or  EpiAtencion.FechaAtencion >= @FechaInicioDescansoMedico)    
			and    
			(@FechaFinDescansoMedico is null or  EpiAtencion.FechaAtencion <= DATEADD(DAY,1,@FechaFinDescansoMedico))    
		   )    		
		
		)as EPI_FORMATO
			
	end	
	--else
	if(@ACCION = 'LISTAR_ABRIREPICLINICO')
	begin			
		select /*@CONTADOR =*/COUNT(*) from SS_HC_EpisodioAtencionMaster 
		where 
		UnidadReplicacion = @UnidadReplicacion
		and IdPaciente = @IdPaciente 
		and IdOrdenatencion =@IdOrdenAtencion
		if(@CONTADOR>0)
		begin
			select top 1 @EpisodioClinicoAux = EpisodioClinico from SS_HC_EpisodioAtencionMaster 
			where 
			UnidadReplicacion = @UnidadReplicacion
			and IdPaciente = @IdPaciente 
			and IdOrdenatencion =@IdOrdenAtencion
		
		
		end
			select 
			  UnidadReplicacion
			  ,IdPaciente
			  ,EpisodioClinico
			  ,EpisodioAtencion
			  ,IdEpisodioAtencion
			  ,IdOrdenAtencion
			  ,LineaOrdenAtencion
			  ,CodigoOA
			  ,TipoAtencion
			  ,UnidadReplicacionEC
			  ,TipoOrdenAtencion
			  ,TipoTrabajador
			  ,TipoEpisodio
			  ,IdEpisodioAtencionCodigo
			  ,IdEstablecimientoSalud
			  ,IdUnidadServicio
			  ,IdPersonalSalud
			  ,FechaRegistro
			  ,FechaAtencion
			  ,Estado
			  ,UsuarioCreacion
			  ,FechaCreacion
			  ,UsuarioModificacion
			  ,FechaModificacion
			  ,IdEspecialidad
			  ,ProximaAtencionFlag
			  ,IdEspecialidadProxima
			  ,IdEstablecimientoSaludProxima
			  ,IdTipoInterConsulta
			  ,IdTipoReferencia
			  ,ObservacionProxima
			  ,DescansoMedico
			  ,DiasDescansoMedico
			  ,FechaInicioDescansoMedico
			  ,FechaFinDescansoMedico
			  ,FechaOrden
			  ,IdProcedimiento
			  ,ObservacionOrden
			  ,IdTipoOrden
			  ,EpisodioCodigoX as FlagFirma
			  ,FechaFirma
			  ,idMedicoFirma
			  ,ObservacionFirma
			  ,KeyPrivada
			  ,KeyPublica
			  ,Accion
			  ,Version
			  ,TipoUbicacion
			  ,IdUbicacion	
			  ,FlagCierrePorRegla --ADD		  
				from (
					select  top 1 
					SS_HC_EpisodioAtencion.* ,
					SS_HC_EpisodioClinico.CodigoEpisodioClinico as EpisodioCodigoX
						from SS_HC_EpisodioAtencion		
					inner join SS_HC_EpisodioClinico 
					on (SS_HC_EpisodioAtencion.UnidadReplicacion =SS_HC_EpisodioClinico.UnidadReplicacion 
						and SS_HC_EpisodioAtencion.IdPaciente =SS_HC_EpisodioClinico.IdPaciente 
						and SS_HC_EpisodioAtencion.EpisodioClinico =SS_HC_EpisodioClinico.EpisodioClinico 
						)
					 where 
					SS_HC_EpisodioClinico.UnidadReplicacion = @UnidadReplicacion
					and SS_HC_EpisodioClinico.IdPaciente = @IdPaciente 				
					and SS_HC_EpisodioClinico.EpisodioClinico = 1
					and SS_HC_EpisodioAtencion.IdOrdenAtencion = @IdOrdenAtencion
				
				)as EPI_CLINICO				
			
	end			

END	
/*
exec [SP_SS_HC_EpisodioAtencionListar]
	NULL,
	NULL,
	NULL,
	1265,
	NULL,
	
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
		
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
		
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
		
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,

	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
		
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
		
	NULL,
	NULL,
	NULL,
	NULL,				
	NULL,
	NULL,
	NULl,
	NULL,
	
	'LISTARPORID'
	
*/


GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_EpisodioClinico]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_EpisodioClinico]
(
	@UnidadReplicacion	char(4) ,
	@IdPaciente	int ,
	@EpisodioClinico	int ,
	@FechaRegistro	datetime ,
	@FechaCierre	datetime ,	
	@Estado	int ,
	@UsuarioCreacion	varchar(25) ,
	@FechaCreacion	datetime ,
	@UsuarioModificacion	varchar(25) ,
	@FechaModificacion	datetime ,	
	@CodigoEpisodioClinico	int ,
	@FlagMedico	int ,
	@FlagEnfermera	int ,
	@IdOrdenAtencion	int ,		
	@ACCION	varchar(30) 
			
)

AS
BEGIN 
SET NOCOUNT ON;
BEGIN  TRANSACTION

	DECLARE @CONTADOR INT
	declare @IdAgenteAux int;
	declare @IdEpisodioAtencionId INTEGER;
	declare @EpisodioClinicoID as INTEGER, 
		@ExisteCodigo as VARCHAR(10),
		@SecuenciaID as Integer,--,
		@LineaOrdenatencion as int--modificado MM13octubre2019
		if(@ACCION = 'UPDATE_MEDICO')
	begin

		update SS_HC_EpisodioAtencion
		set 									
			IdPersonalSalud	=	@FlagMedico,
			FechaModificacion= GETDATE(),
			UsuarioModificacion= @UsuarioModificacion
			
		WHERE 
		UnidadReplicacion=@UnidadReplicacion AND
			IdPaciente= @IdPaciente
		and IdOrdenAtencion= @IdOrdenAtencion		
		and  EpisodioClinico= @EpisodioClinico

		select @FlagMedico		
		
		select @lineaordenatencion=LineaOrdenatencion 
		FROM SS_HC_EpisodioAtencion WHERE
			UnidadReplicacion=@UnidadReplicacion AND
			IdPaciente= @IdPaciente
		and IdOrdenAtencion= @IdOrdenAtencion		
		and  EpisodioClinico= @EpisodioClinico 

	EXEC SS_SP_ASIGNAMEDICO @UnidadReplicacion,@IdOrdenAtencion,@lineaordenatencion,@IdPaciente,@EpisodioClinico,@FlagMedico,@USUARIOMODIFICACION,@USUARIOCREACION --mm13octubre2019
				
	end
	
	else	
	if (@ACCION='APROBAR')
	begin
	update SS_HC_EpisodioAtencion
		set 									
			IdEspecialidad	=	@FlagMedico,
			FechaModificacion= GETDATE(),
			UsuarioModificacion= @UsuarioModificacion,
			FechaRegistro=GETDATE(),
			Estado=4
			
		WHERE 
		UnidadReplicacion=@UnidadReplicacion AND
			IdPaciente= @IdPaciente
		and CodigoOA= @UsuarioCreacion		
		and  EpisodioClinico= @EpisodioClinico

		select 1

	end

			else	
	if (@ACCION='RELEVAME')
	begin
	update SS_HC_EpisodioAtencion
		set 									
			IdTipoInterConsulta=0
		WHERE 
		 IdOrdenAtencion= @IdOrdenAtencion		
		and  IdTipoInterConsulta= 1
		and TipoOrdenAtencion = 1
		select 1

	end

		else	
	if (@ACCION='ANULAROA')
	begin
	update SS_HC_EpisodioAtencion
		set 									
			FechaModificacion= GETDATE(),
			UsuarioModificacion= @UsuarioModificacion,
			FechaRegistro=GETDATE(),
			Estado=4
			
		WHERE 
		UnidadReplicacion=@UnidadReplicacion AND
			IdPaciente= @IdPaciente
		and CodigoOA= @UsuarioCreacion		
		and  EpisodioClinico= @EpisodioClinico

		select 1

	end

			else	
	if (@ACCION='ANULARALTA')
	begin
		--agregado angel
		update SS_HC_InformeAlta_FE set hcaltamedica=null WHERE IdPaciente=@IdPaciente and UnidadReplicacion=@UnidadReplicacion and EpisodioClinico=@EpisodioClinico


		set @LineaOrdenatencion=(select top 1 LineaOrdenAtencion from SS_HC_EpisodioAtencion where  EpisodioClinico=@EpisodioClinico and CodigoOA= @UsuarioCreacion)
			update SS_HC_EpisodioAtencion
		set 									
			FechaModificacion= GETDATE(),
			UsuarioModificacion= @UsuarioModificacion,
			IdTipoReferencia=null,
			IdUbicacion=4
			
		WHERE	
		 CodigoOA= @UsuarioCreacion
		and LineaOrdenAtencion=@LineaOrdenatencion

		select 1

	end

				else	
	if (@ACCION='ANULARREINGRESO')
	begin

	set @LineaOrdenatencion=(select top 1 LineaOrdenAtencion from SS_HC_EpisodioAtencion where  EpisodioClinico=@EpisodioClinico and CodigoOA= @UsuarioCreacion)
	update SS_HC_EpisodioAtencion
		set 									
			FechaModificacion= GETDATE(),
			UsuarioModificacion= @UsuarioModificacion,
			IdTipoReferencia=null,
			IdUbicacion=4
			
		WHERE	
		 CodigoOA= @UsuarioCreacion
		and LineaOrdenAtencion=@LineaOrdenatencion

		select 1

	end

			else	
	if (@ACCION='ANULAR_OA_EMER')
	begin
	update SS_HC_EpisodioAtencion
		set 									
			FechaModificacion= GETDATE(),
			UsuarioModificacion= @UsuarioModificacion,
			FechaRegistro=GETDATE(),
			Estado=4
			
		WHERE 
		UnidadReplicacion=@UnidadReplicacion AND
			IdPaciente= @IdPaciente
		and CodigoOA= @UsuarioCreacion		
		

		select 1

	end

		else	
	if (@ACCION='DESAPROBAR')
	begin
	update SS_HC_EpisodioAtencion
		set 									
			FechaModificacion= GETDATE(),
			UsuarioModificacion= @UsuarioModificacion,
			FechaRegistro=GETDATE(),
			Estado=1
			
		WHERE 
		UnidadReplicacion=@UnidadReplicacion AND
			IdPaciente= @IdPaciente
		and CodigoOA= @UsuarioCreacion			
		and  EpisodioClinico= @EpisodioClinico

		select 1

	end

			else	
	if (@ACCION='MEDICO')

	begin
		declare @RESULTADO INT
		SET @RESULTADO =(SELECT COUNT(*) FROM SS_HC_EpisodioAtencion WHERE
		UnidadReplicacion=@UnidadReplicacion AND
			IdPersonalSalud	=	@FlagMedico
		AND FechaRegistro =@FechaRegistro)
		if(@RESULTADO=0)
		BEGIN
			update SS_HC_EpisodioAtencion
		set 	
			IdPersonalSalud	=	@FlagMedico,								
			FechaModificacion= GETDATE(),
			UsuarioModificacion= @UsuarioModificacion,
			FechaRegistro=@FechaRegistro,
			Estado=2
			
		WHERE 
		UnidadReplicacion=@UnidadReplicacion AND
			IdPaciente= @IdPaciente
		and CodigoOA= @UsuarioCreacion			
		and  EpisodioClinico= @EpisodioClinico

		set @RESULTADO=0

		END

		select @RESULTADO

	end

	else 
	if (@ACCION='MED_PRINCIPAL') -- luke 03/02/2020
	begin
	declare  @IDMEDICO int
	SET @IDMEDICO =(select e.IdPersonalSalud from SS_HC_EpisodioAtencion e 
	left join SS_HC_InterConsulta_FE i on i.IdEpisodioAtencion = e.IdEpisodioAtencion  
	and i.EpisodioClinico=e.EpisodioClinico
	where i.SecuencialHCE=@UsuarioCreacion and e.CodigoOA=@UsuarioModificacion)	

		update SS_HC_EpisodioAtencion
		set 									
			IdTipoInterConsulta	=	null					
		WHERE 
		UnidadReplicacion=@UnidadReplicacion AND
			IdPersonalSalud= @IDMEDICO
		and IdOrdenAtencion= @IdOrdenAtencion		
		-- jordan 26/08/2020
		UPDATE SS_HC_InformeAlta_FE  set hcaltamedica=null FROM  SS_HC_InformeAlta_FE  B
		INNER JOIN SS_HC_EpisodioAtencion A ON A.IdEpisodioAtencion=B.IdEpisodioAtencion AND A.EpisodioClinico=B.EpisodioClinico
		AND A.IdPaciente=B.IdPaciente AND A.UnidadReplicacion=B.UnidadReplicacion
		WHERE A.IdOrdenAtencion=@IdOrdenAtencion


		select 1		
	end

	if(@ACCION = 'EPISODIOCLINICO')
		begin	 	
				select @EpisodioClinicoID = ISNULL(max(EpisodioClinico),0)+1 
					 from dbo.SS_HC_EpisodioClinico 
					WHERE 
					(UnidadReplicacion= @UnidadReplicacion)						
					and ( IdPaciente= @IdPaciente)						
				 Insert into dbo.SS_HC_EpisodioClinico
					(UnidadReplicacion, IdPaciente, EpisodioClinico, 
					 FechaRegistro,   Estado, UsuarioCreacion,IdOrdenAtencion, 
					 FechaCreacion, UsuarioModificacion, FechaModificacion)
					 values 
					 (@UnidadReplicacion, @IdPaciente, @EpisodioClinicoID, 
					 GETDATE(), 2, @UsuarioCreacion, @IdOrdenAtencion,
					 GETDATE(), @UsuarioModificacion,GETDATE())
					 
			set  @IdEpisodioAtencionId= @EpisodioClinicoID				 	
			select @IdEpisodioAtencionId		
		end		
	if(@ACCION = 'INSERT')
	begin				
		insert into SS_HC_EpisodioClinico
		(
			UnidadReplicacion
			,IdPaciente
			,EpisodioClinico
			,FechaRegistro
			,FechaCierre
			,Estado
			,UsuarioCreacion
			,FechaCreacion
			,UsuarioModificacion
			,FechaModificacion
			,CodigoEpisodioClinico
			,FlagMedico
			,FlagEnfermera
			,IdOrdenAtencion
		--	,ACCION		
		)
		values
		(
			@UnidadReplicacion
		,	@IdPaciente
		,	@EpisodioClinico
		,	@FechaRegistro
		,	@FechaCierre
		,	@Estado
		,	@UsuarioCreacion
		,	GETDATE()
		,	@UsuarioModificacion
		,	GETDATE()
		,	@CodigoEpisodioClinico
		,	@FlagMedico
		,	@FlagEnfermera
		,	@IdOrdenAtencion
		--,	@ACCION		
		)
		
		select @EpisodioClinico
	end	
	else
	if(@ACCION = 'UPDATE')
	begin											
			
		update SS_HC_EpisodioClinico
		set 									
			FechaRegistro	=	@FechaRegistro
			,FechaCierre	=	@FechaCierre
			,Estado	=	@Estado
			,UsuarioModificacion	=	@UsuarioModificacion
			,FechaModificacion	=	GETDATE()
			,CodigoEpisodioClinico	=	@CodigoEpisodioClinico
			,FlagMedico	=	@FlagMedico
			,FlagEnfermera	=	@FlagEnfermera
			,IdOrdenAtencion	=	@IdOrdenAtencion
		WHERE 
		(UnidadReplicacion= @UnidadReplicacion)				
		and ( IdPaciente= @IdPaciente)		
		and ( EpisodioClinico= @EpisodioClinico)		
						
		select @EpisodioClinico
				
	end	
	else
	if(@ACCION = 'DELETE')
	begin			
		delete SS_HC_EpisodioClinico
		WHERE 
		(UnidadReplicacion= @UnidadReplicacion)				
		and ( IdPaciente= @IdPaciente)		
		and ( EpisodioClinico= @EpisodioClinico)	
		
		select 1
	end
	else
	if(@ACCION = 'UPDATE_EPINUEVO')
	begin	
							
		SELECT @CodigoEpisodioClinico = isnull(MAX(CodigoEpisodioClinico),0)+1 FROM dbo.SS_HC_EpisodioClinico 		
			   WHERE UnidadReplicacion = @UnidadReplicacion	and IdPaciente = @IdPaciente

		update SS_HC_EpisodioClinico
		set 									
			UsuarioModificacion		=	@UsuarioModificacion
			,FechaModificacion		=	GETDATE()
			,CodigoEpisodioClinico	=	@CodigoEpisodioClinico
		WHERE 
		(UnidadReplicacion= @UnidadReplicacion)
		and EpisodioClinico=@EpisodioClinico
		and ( IdPaciente= @IdPaciente)	
		
		UPDATE SS_HC_EpisodioAtencionMaster
		set
		 	UsuarioModificacion	=	@UsuarioModificacion
			,FechaModificacion	=	GETDATE()
			,EpisodioAtencionCodigo	=	@CodigoEpisodioClinico --'1'/*Convert(varchar(4),@temp)*/
		WHERE 
		(UnidadReplicacion= @UnidadReplicacion)
		and EpisodioClinico=@EpisodioClinico
		and ( IdPaciente= @IdPaciente)

		DECLARE @NUM INT
		SELECT @NUM=COUNT(*) FROM SS_HC_EpisodioAtencion WHERE 	UnidadReplicacion = @UnidadReplicacion	
					AND IdPaciente = @IdPaciente AND IdOrdenAtencion = @IdOrdenAtencion
		IF @NUM >1
			BEGIN
				UPDATE SS_HC_EpisodioAtencion SET IdEpisodioAtencion=1 WHERE UnidadReplicacion = @UnidadReplicacion	
					AND IdPaciente = @IdPaciente AND IdOrdenAtencion = @IdOrdenAtencion
					AND EpisodioClinico=@EpisodioClinico
			END
			
		-----				
		select @CodigoEpisodioClinico
				
	end	
	else
	if(@ACCION = 'UPDATE_EPICONTINUAR')
	begin


		update SS_HC_EpisodioClinico
		set 									
			UsuarioModificacion	=	@UsuarioModificacion
			,FechaModificacion	=	GETDATE()
			,CodigoEpisodioClinico	=	@CodigoEpisodioClinico
		WHERE 
		(UnidadReplicacion= @UnidadReplicacion)
		and ( IdPaciente= @IdPaciente)
		and ( EpisodioClinico= @EpisodioClinico)
								
		select @CodigoEpisodioClinico
				
	end	
	else
	if(@ACCION = 'UPDATE_ATECONTINUAR')
	begin
		DECLARE @TEMPx INT
		DECLARE @Codigox INT
			
		SELECT @TEMPx= COUNT(*) FROM SS_HC_EpisodioClinico 
				WHERE UnidadReplicacion = @UnidadReplicacion and IdPaciente = @IdPaciente
				and CodigoEpisodioClinico =@CodigoEpisodioClinico; 

		update SS_HC_EpisodioAtencionMaster
		set 									
			UsuarioModificacion	=	@UsuarioModificacion
			,FechaModificacion	=	GETDATE()
			,EpisodioAtencionCodigo	= Convert(varchar(4),@TEMPx)

		WHERE 
		(UnidadReplicacion= @UnidadReplicacion)				
		and ( IdPaciente= @IdPaciente)		
		and ( EpisodioClinico= @EpisodioClinico)
		
		update SS_HC_EpisodioAtencion
		set 									
			UsuarioModificacion	=	@UsuarioModificacion
			,FechaModificacion	=	GETDATE()
			,IdEpisodioAtencion	=	@TEMPx ---cambio
	
		WHERE 
		(UnidadReplicacion= @UnidadReplicacion)				
		and ( IdPaciente= @IdPaciente)		
		and ( EpisodioClinico= @EpisodioClinico)		
						
		select @TEMPx
				
	end	

		else	
	if (@ACCION='KARDEX')
	begin
	update SS_HC_Medicamento_FE set Estado=3 where SecuencialHCE=@UsuarioModificacion
		select 1

	end

	else
	if(@ACCION = 'VALIDAR_EPICONTINUAR')
	begin
		select @CONTADOR= COUNT(*) from SS_HC_EpisodioClinico where
		UnidadReplicacion = @UnidadReplicacion
		and IdPaciente = @IdPaciente
		and CodigoEpisodioClinico is not null
	
		if(@CONTADOR > 0)	
			set @CONTADOR	=1
		else
			set @CONTADOR	=0
		select @CONTADOR
				
	end	
			
commit		
END	
/*
exec SP_SS_HC_EpisodioClinico

	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	
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
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_EpisodioClinicoListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_EpisodioClinicoListar]
(
	@UnidadReplicacion	char(4) ,
	@IdPaciente	int ,
	@EpisodioClinico	int ,
	@FechaRegistro	datetime ,
	@FechaCierre	datetime ,
	
	@Estado	int ,
	@UsuarioCreacion	varchar(25) ,
	@FechaCreacion	datetime ,
	@UsuarioModificacion	varchar(25) ,
	@FechaModificacion	datetime ,
	
	@CodigoEpisodioClinico	int ,
	@FlagMedico	int ,
	@FlagEnfermera	int ,
	@IdOrdenAtencion	int ,
	
	@Inicio	int ,
	@Final	int ,
	@ACCION	varchar(30) 
			
)

AS
BEGIN 
SET NOCOUNT ON;

	DECLARE @CONTADOR INT
	declare @IdAgenteAux int;
	declare @EpisodioClinicoAux int =0;
	if(@ACCION = 'LISTAR')
	begin		 

		select * from SS_HC_EpisodioClinico
		where
		(@UnidadReplicacion is null or UnidadReplicacion= @UnidadReplicacion)				
		and (@IdPaciente is null or  IdPaciente= @IdPaciente)		
		and (@EpisodioClinico is null or  EpisodioClinico= @EpisodioClinico)	
		and (@CodigoEpisodioClinico is null or  CodigoEpisodioClinico= @CodigoEpisodioClinico)	
		
	end		
	if(@ACCION = 'LISTARPORID')
	begin		 

		
		select * from SS_HC_EpisodioClinico
		where
		(UnidadReplicacion= @UnidadReplicacion)				
		and (IdPaciente= @IdPaciente)		
		and ( EpisodioClinico= @EpisodioClinico)			
		
	end	
	-- AGREGADO A PEDIDO DE MITSUO 27/02/2019
	if(@ACCION = 'LISTARCONTINUAR')
	begin	 
		select * from SS_HC_EpisodioClinico
		where
		(UnidadReplicacion= @UnidadReplicacion)	and (IdPaciente= @IdPaciente)		
		and EpisodioClinico IN (
			SELECT MAX(EpisodioClinico) FROM SS_HC_EpisodioClinico 
			WHERE  (UnidadReplicacion= @UnidadReplicacion)	and (IdPaciente= @IdPaciente)	
			AND CodigoEpisodioClinico IN ( 
				SELECT CodigoEpisodioClinico FROM SS_HC_EpisodioClinico
				WHERE  (UnidadReplicacion= @UnidadReplicacion)	and (IdPaciente= @IdPaciente) 
				AND EpisodioClinico=@EpisodioClinico	
			)	
		 )			
			
	end	

END	
/*
exec SP_SS_HC_EpisodioClinicoListar

	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	
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
	10,
	'LISTAR'

	
*/


GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_FACTOR_NANDA]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_FACTOR_NANDA]
@IdFRN                 INT,
@IdNanda               INT, 
@IdFactorRelacionado   INT, 
@Descripcion         VARCHAR(300), 
@Estado              INT, 
@UsuarioCreacion     VARCHAR(25), 
@FechaCreacion       DATETIME, 
@UsuarioModificacion VARCHAR(25), 
@FechaModificacion   DATETIME, 
@Accion              VARCHAR( 25), 
@Version             VARCHAR( 25) 
AS 
  BEGIN 
      SET nocount ON; 

      IF @Accion = 'INSERT' 
        BEGIN 
            SELECT @IdFRN = Isnull(Max(IdFRN), 0) + 1 FROM   dbo.SS_HC_FactorRelacionadoNanda  
            INSERT INTO SS_HC_FactorRelacionadoNanda 
                        (IdFRN,
                         IdNanda,
                         IdFactorRelacionado,                         
                         Descripcion,                          
                         Estado, 
                         usuariocreacion, 
                         fechacreacion, 
                         usuariomodificacion, 
                         fechamodificacion, 
                         accion, 
                         version) 
            VALUES      ( 
                          @IdFRN,
                          @IdNanda , 
                          @IdFactorRelacionado , 
                          @Descripcion  , 
                          @Estado      , 
                          @UsuarioCreacion   , 
                          Getdate(), 
                          @UsuarioModificacion, 
                          Getdate(), 
                          @Accion, 
                          @Version ) 

            
             SELECT 1 
        END 
      ELSE IF @Accion = 'UPDATE' 
        BEGIN 
            UPDATE SS_HC_FactorRelacionadoNanda 
            SET    IdFRN = @IdFRN, 
                   IdNanda = @IdNanda, 
                   IdFactorRelacionado = @IdFactorRelacionado, 
                   Descripcion = @Descripcion,                 
                   Estado = @Estado, 
                   usuariomodificacion = @UsuarioModificacion, 
                   fechamodificacion = GETDATE(), 
                   accion = @Accion, 
                   version = @Version 
            WHERE  ( SS_HC_FactorRelacionadoNanda.IdFRN = @IdFRN ) 
                   

            SELECT 1 
        END 
      ELSE IF @Accion = 'DELETE' 
        BEGIN 
            DELETE FROM SS_HC_FactorRelacionadoNanda 
            WHERE  ( SS_HC_FactorRelacionadoNanda.IdFRN = @IdFRN ) 

            SELECT 1 
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_FactorRelacionadoNanda
                             WHERE  (     @Descripcion IS NULL OR Upper(SS_HC_FactorRelacionadoNanda.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_FactorRelacionadoNanda.Estado = @Estado OR @Estado = 0 )              
                                    AND ( @IdNanda IS NULL OR SS_HC_FactorRelacionadoNanda.IdNanda =@IdNanda OR @IdNanda = 0 ) 
                                    AND ( @IdFactorRelacionado IS NULL OR SS_HC_FactorRelacionadoNanda.IdFactorRelacionado = @IdFactorRelacionado OR @IdFactorRelacionado = 0 ) 
                                    AND ( @IdFRN IS NULL OR SS_HC_FactorRelacionadoNanda.IdFRN = @IdFRN OR @IdFRN = 0  )) 
            SELECT @CONTADOR; 
        END 
  END 




GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_FactorRelacionado]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER PROCEDURE [SP_SS_HC_FactorRelacionado]

	@IdFactorRelacionado int ,
	@Codigo varchar(10),
	@CodigoPadre VARCHAR(10), 
	@Descripcion varchar(300) ,
	@DescripcionCorta varchar(100) ,
	@Nivel INT, 
    @CadenaRecursiva VARCHAR(150), 
    @Orden INT, 
	@Estado	int ,
	@UsuarioCreacion varchar(25) ,
	@FechaCreacion datetime ,	
	@UsuarioModificacion varchar(25) ,
	@FechaModificacion datetime ,		
	@ACCION	varchar(25) ,
	@Version varchar(25)
	
	
AS 
  BEGIN 
      SET nocount ON; 

      IF @Accion = 'INSERT' 
        BEGIN 
            SELECT @IdFactorRelacionado = Isnull(Max(IdFactorRelacionado), 0) + 1 FROM   dbo.SS_HC_FactorRelacionado  
            INSERT INTO SS_HC_FactorRelacionado 
                        (IdFactorRelacionado, 
                         codigo, 
                         codigopadre, 
                         descripcion, 
                         descripcioncorta, 
                         nivel, 
                         cadenarecursiva, 
                         orden, 
                         estado, 
                         usuariocreacion, 
                         fechacreacion, 
                         usuariomodificacion, 
                         fechamodificacion, 
                         accion, 
                         version) 
            VALUES      ( @IdFactorRelacionado, 
                          @Codigo, 
                          @CodigoPadre, 
                          @Descripcion, 
                          @DescripcionCorta, 
                          @Nivel, 
                          @CadenaRecursiva, 
                          @Orden, 
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
            UPDATE SS_HC_FactorRelacionado 
            SET    IdFactorRelacionado = @IdFactorRelacionado, 
                   codigo = @Codigo, 
                   codigopadre = @CodigoPadre, 
                   descripcion = @Descripcion, 
                   descripcioncorta = @DescripcionCorta, 
                   nivel = @Nivel, 
                   cadenarecursiva = @CadenaRecursiva, 
                   orden = @Orden, 
                   estado = @Estado, 
                   usuariomodificacion = @UsuarioModificacion, 
                   fechamodificacion = GETDATE(), 
                   accion = @Accion, 
                   version = @Version 
            WHERE  ( SS_HC_FactorRelacionado.IdFactorRelacionado = @IdFactorRelacionado ) 

            SELECT 1 
        END 
      ELSE IF @Accion = 'DELETE' 
        BEGIN 
            DELETE FROM SS_HC_FactorRelacionado 
            WHERE  ( SS_HC_FactorRelacionado.IdFactorRelacionado = @IdFactorRelacionado ) 

            SELECT 1 
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_FactorRelacionado 
                             WHERE  ( @Descripcion IS NULL OR Upper(SS_HC_FactorRelacionado.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_FactorRelacionado.estado = @Estado OR @Estado = 0 ) 
                                    AND ( @Codigo IS NULL OR Upper(SS_HC_FactorRelacionado.codigo) LIKE '%' + Upper(@Codigo) + '%' )
                                     AND ( @CodigoPadre IS NULL OR Upper(SS_HC_FactorRelacionado.CodigoPadre) LIKE '%' + Upper(@CodigoPadre) + '%' ) 
                                    AND ( @Nivel IS NULL OR SS_HC_FactorRelacionado.Nivel = @Nivel OR @Nivel = 0 ) 
                                    AND ( @IdFactorRelacionado IS NULL OR SS_HC_FactorRelacionado.IdFactorRelacionado = @IdFactorRelacionado OR @IdFactorRelacionado = 0 )) 

            SELECT @CONTADOR; 
        END 
  END 


GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_FactorRelacionado_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_FactorRelacionado_LISTAR]
	@IdFactorRelacionado int ,
	@Codigo varchar(10),
	@CodigoPadre VARCHAR(10), 
	@Descripcion varchar(300) ,		
	@DescripcionCorta varchar(100) ,	
	@Nivel  INT, 
    @CadenaRecursiva VARCHAR(150), 
    @Orden INT, 
	@Estado	int ,
	@UsuarioCreacion varchar(25) ,	
	@FechaCreacion datetime ,	
	@UsuarioModificacion varchar(25) ,
	@FechaModificacion datetime ,		
	@ACCION	varchar(25) ,
	@Version varchar(25),		
	@INICIO   int= null,  
	@NUMEROFILAS int = null 	

AS 
  BEGIN 
      SET nocount ON; 

      DECLARE @CONTADOR INT 

      IF @Accion = 'LISTAR' 
        BEGIN 
            SELECT SS_HC_FactorRelacionado.IdFactorRelacionado, 
                   SS_HC_FactorRelacionado.codigo, 
                   SS_HC_FactorRelacionado.codigopadre, 
                   SS_HC_FactorRelacionado.descripcion, 
                   SS_HC_FactorRelacionado.descripcioncorta, 
                   SS_HC_FactorRelacionado.nivel, 
                   SS_HC_FactorRelacionado.cadenarecursiva, 
                   SS_HC_FactorRelacionado.orden, 
                   SS_HC_FactorRelacionado.estado, 
                   SS_HC_FactorRelacionado.usuariocreacion, 
                   SS_HC_FactorRelacionado.fechacreacion, 
                   SS_HC_FactorRelacionado.usuariomodificacion, 
                   SS_HC_FactorRelacionado.fechamodificacion, 
                   SS_HC_FactorRelacionado.accion, 
                   SS_HC_FactorRelacionado.version 
            FROM   SS_HC_FactorRelacionado 
             WHERE  ( @Descripcion IS NULL OR Upper(SS_HC_FactorRelacionado.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_FactorRelacionado.estado = @Estado OR @Estado = 0 ) 
                                    AND ( @Codigo IS NULL OR Upper(SS_HC_FactorRelacionado.codigo) LIKE '%' + Upper(@Codigo) + '%' ) 
                                    AND ( @CodigoPadre IS NULL OR Upper(SS_HC_FactorRelacionado.CodigoPadre) LIKE '%' + Upper(@CodigoPadre) + '%' ) 
                                    AND ( @Nivel IS NULL OR SS_HC_FactorRelacionado.Nivel = @Nivel OR @Nivel = 0 ) 
                                    AND ( @IdFactorRelacionado IS NULL OR SS_HC_FactorRelacionado.IdFactorRelacionado = @IdFactorRelacionado OR @IdFactorRelacionado = 0 )
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_FactorRelacionado 
                              WHERE  ( @Descripcion IS NULL OR Upper(SS_HC_FactorRelacionado.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_FactorRelacionado.estado = @Estado OR @Estado = 0 ) 
                                    AND ( @Codigo IS NULL OR Upper(SS_HC_FactorRelacionado.codigo) LIKE '%' + Upper(@Codigo) + '%' )
                                    AND ( @CodigoPadre IS NULL OR Upper(SS_HC_FactorRelacionado.CodigoPadre) LIKE '%' + Upper(@CodigoPadre) + '%' ) 
                                    AND ( @Nivel IS NULL OR SS_HC_FactorRelacionado.Nivel = @Nivel OR @Nivel = 0 ) 
                                    AND ( @IdFactorRelacionado IS NULL OR SS_HC_FactorRelacionado.IdFactorRelacionado = @IdFactorRelacionado OR @IdFactorRelacionado = 0 )) 

            SELECT IdFactorRelacionado, 
                   codigo, 
                   codigopadre, 
                   descripcion, 
                   descripcioncorta, 
                   nivel, 
                   cadenarecursiva, 
                   orden, 
                   estado, 
                   usuariocreacion, 
                   fechacreacion, 
                   usuariomodificacion, 
                   fechamodificacion, 
                   accion, 
                   version 
            FROM   (SELECT SS_HC_FactorRelacionado.IdFactorRelacionado, 
                           SS_HC_FactorRelacionado.codigo, 
                           SS_HC_FactorRelacionado.codigopadre, 
                           SS_HC_FactorRelacionado.descripcion, 
                           SS_HC_FactorRelacionado.descripcioncorta, 
                           SS_HC_FactorRelacionado.nivel, 
                           SS_HC_FactorRelacionado.cadenarecursiva, 
                           SS_HC_FactorRelacionado.orden, 
                           SS_HC_FactorRelacionado.estado, 
                           SS_HC_FactorRelacionado.usuariocreacion, 
                           SS_HC_FactorRelacionado.fechacreacion, 
                           SS_HC_FactorRelacionado.usuariomodificacion, 
                           SS_HC_FactorRelacionado.fechamodificacion, 
                           SS_HC_FactorRelacionado.accion, 
                           SS_HC_FactorRelacionado.version, 
                           @CONTADOR                                  AS 
                           Contador, 
                           Row_number() 
                             OVER ( 
                               ORDER BY SS_HC_FactorRelacionado.IdFactorRelacionado ASC ) AS 
                           RowNumber 
                    FROM   SS_HC_FactorRelacionado 
                     WHERE  ( @Descripcion IS NULL OR Upper(SS_HC_FactorRelacionado.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_FactorRelacionado.estado = @Estado OR @Estado = 0 ) 
                                    AND ( @Codigo IS NULL OR Upper(SS_HC_FactorRelacionado.codigo) LIKE '%' + Upper(@Codigo) + '%' )
                                    AND ( @CodigoPadre IS NULL OR Upper(SS_HC_FactorRelacionado.CodigoPadre) LIKE '%' + Upper(@CodigoPadre) + '%' ) 
                                    AND ( @Nivel IS NULL OR SS_HC_FactorRelacionado.Nivel = @Nivel OR @Nivel = 0 ) 
                                    AND ( @IdFactorRelacionado IS NULL OR SS_HC_FactorRelacionado.IdFactorRelacionado = @IdFactorRelacionado OR @IdFactorRelacionado = 0 )) 
                   AS LISTADO 
            WHERE  ( @Inicio IS NULL 
                     AND @NumeroFilas IS NULL ) 
                    OR rownumber BETWEEN @Inicio AND @NumeroFilas 
        END 
        ELSE IF( @ACCION = 'LISTARFACTORNANDA' ) 
        BEGIN           
 SET @CONTADOR = (SELECT Count(*) 
                             FROM      dbo.SS_HC_FactorRelacionado INNER JOIN
                      dbo.SS_HC_FactorRelacionadoNanda 
                      ON dbo.SS_HC_FactorRelacionado.IdFactorRelacionado = dbo.SS_HC_FactorRelacionadoNanda.IdFactorRelacionado 
                       INNER JOIN SS_HC_NANDA 
                       
                      ON 
                      SS_HC_NANDA.IdNanda = SS_HC_FactorRelacionadoNanda.IdNanda  
                              WHERE  
                                     ( @Orden IS NULL OR SS_HC_FactorRelacionadoNanda.IdNanda = @Orden OR @Orden = 0 ) )
                                     

            SELECT IdFactorRelacionado, 
                   codigo, 
                   codigopadre, 
                   descripcion, 
                   descripcioncorta, 
                   nivel, 
                   cadenarecursiva, 
                   orden, 
                   estado, 
                   usuariocreacion, 
                   fechacreacion, 
                   usuariomodificacion, 
                   fechamodificacion, 
                   accion, 
                   version 
            FROM   (SELECT SS_HC_FactorRelacionado.IdFactorRelacionado, 
                           SS_HC_FactorRelacionado.codigo, 
                           SS_HC_FactorRelacionado.codigopadre, 
                           SS_HC_FactorRelacionado.descripcion, 
                           SS_HC_FactorRelacionado.descripcioncorta, 
                           SS_HC_FactorRelacionado.nivel, 
                           SS_HC_FactorRelacionado.cadenarecursiva, 
                           SS_HC_FactorRelacionadoNanda.IdNanda as orden, 
                           SS_HC_FactorRelacionado.estado, 
                           SS_HC_FactorRelacionado.usuariocreacion, 
                           SS_HC_FactorRelacionado.fechacreacion, 
                           SS_HC_FactorRelacionado.usuariomodificacion, 
                           SS_HC_FactorRelacionado.fechamodificacion, 
                           SS_HC_FactorRelacionado.accion, 
                           SS_HC_FactorRelacionado.version, 
                           @CONTADOR                                  AS 
                           Contador, 
                           Row_number() 
                             OVER ( 
                               ORDER BY SS_HC_FactorRelacionado.IdFactorRelacionado ASC ) AS 
                           RowNumber 
                       FROM      dbo.SS_HC_FactorRelacionado INNER JOIN
                      dbo.SS_HC_FactorRelacionadoNanda 
                      ON dbo.SS_HC_FactorRelacionado.IdFactorRelacionado = dbo.SS_HC_FactorRelacionadoNanda.IdFactorRelacionado 
                       INNER JOIN SS_HC_NANDA 
                       
                      ON 
                      SS_HC_NANDA.IdNanda = SS_HC_FactorRelacionadoNanda.IdNanda   
                     WHERE  
                                     ( @Orden IS NULL OR SS_HC_FactorRelacionadoNanda.IdNanda = @Orden OR @Orden = 0 ) )
                             
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
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_FactorRelacionado_listarcombo]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_FactorRelacionado_listarcombo]
	@IdFactorRelacionado int ,
	@Descripcion varchar(300) ,			
	@ACCION	varchar(25) 
AS 
  BEGIN 
      SET nocount ON; 

      DECLARE @CONTADOR INT 

      IF @Accion = 'LISTAR' 
        BEGIN 
            SELECT SS_HC_FactorRelacionado.IdFactorRelacionado,                   
                   SS_HC_FactorRelacionado.descripcion,                    
                   SS_HC_FactorRelacionado.accion
            FROM   SS_HC_FactorRelacionado 
            
        END 
      
  END 


GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_FactorRelacionadoNanda_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER PROCEDURE [SP_SS_HC_FactorRelacionadoNanda_LISTAR]

    @IdFRN        INT,
    @IdNanda      INT, 
	@IdFactorRelacionado   INT, 
	@Descripcion         VARCHAR(300), 
    @Estado              INT, 
    @UsuarioCreacion     VARCHAR(25), 
    @FechaCreacion       DATETIME, 
    @UsuarioModificacion VARCHAR(25), 
    @FechaModificacion   DATETIME, 
    @Accion              VARCHAR( 25), 
    @Version             VARCHAR( 25) ,	
	@INICIO   int= null,  
	@NUMEROFILAS int = null 

AS 
  BEGIN 
      SET nocount ON; 

      DECLARE @CONTADOR INT 

      IF @Accion = 'LISTAR' 
        BEGIN 
            SELECT SS_HC_FactorRelacionadoNanda.IdFRN, 
                   SS_HC_FactorRelacionadoNanda.IdNanda, 
                   SS_HC_FactorRelacionadoNanda.IdFactorRelacionado, 
                   SS_HC_FactorRelacionadoNanda.Descripcion,                   
                   SS_HC_FactorRelacionadoNanda.Estado, 
                   SS_HC_FactorRelacionadoNanda.UsuarioCreacion, 
                   SS_HC_FactorRelacionadoNanda.FechaCreacion, 
                   SS_HC_FactorRelacionadoNanda.UsuarioModificacion, 
                   SS_HC_FactorRelacionadoNanda.Fechamodificacion, 
                   SS_HC_FactorRelacionadoNanda.Accion, 
                   SS_HC_FactorRelacionadoNanda.version 
            FROM   SS_HC_FactorRelacionadoNanda 
             WHERE                      ( @Descripcion IS NULL OR Upper(SS_HC_FactorRelacionadoNanda.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_FactorRelacionadoNanda.Estado = @Estado OR @Estado = 0 ) 
                                    AND ( @IdNanda IS NULL OR SS_HC_FactorRelacionadoNanda.IdNanda =@IdNanda OR @IdNanda = 0 ) 
                                    AND ( @IdFactorRelacionado IS NULL OR SS_HC_FactorRelacionadoNanda.IdFactorRelacionado = @IdFactorRelacionado OR @IdFactorRelacionado = 0 ) 
                                    AND ( @IdFRN IS NULL OR SS_HC_FactorRelacionadoNanda.IdFRN = @IdFRN OR @IdFRN = 0 )
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_FactorRelacionadoNanda 
                              WHERE     ( @Descripcion IS NULL OR Upper(SS_HC_FactorRelacionadoNanda.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_FactorRelacionadoNanda.Estado = @Estado OR @Estado = 0 ) 
                                    AND ( @IdNanda IS NULL OR SS_HC_FactorRelacionadoNanda.IdNanda =@IdNanda OR @IdNanda = 0 ) 
                                    AND ( @IdFactorRelacionado IS NULL OR SS_HC_FactorRelacionadoNanda.IdFactorRelacionado = @IdFactorRelacionado OR @IdFactorRelacionado = 0 ) 
                                    AND ( @IdFRN IS NULL OR SS_HC_FactorRelacionadoNanda.IdFRN = @IdFRN OR @IdFRN = 0 )) 

            SELECT 
            
                   IdFRN, 
                   IdNanda, 
                   IdFactorRelacionado, 
                   descripcion,                    
                   estado, 
                   usuariocreacion, 
                   fechacreacion, 
                   usuariomodificacion, 
                   fechamodificacion, 
                   accion, 
                   version 
            FROM   (SELECT SS_HC_FactorRelacionadoNanda.IdFRN,
                           SS_HC_FactorRelacionadoNanda.IdNanda,
                           SS_HC_FactorRelacionadoNanda.IdFactorRelacionado,                           
                           SS_HC_FactorRelacionadoNanda.Descripcion,                           
                           SS_HC_FactorRelacionadoNanda.Estado, 
                           SS_HC_FactorRelacionadoNanda.usuariocreacion, 
                           SS_HC_FactorRelacionadoNanda.fechacreacion, 
                           SS_HC_FactorRelacionadoNanda.usuariomodificacion, 
                           SS_HC_FactorRelacionadoNanda.fechamodificacion, 
                           SS_HC_FactorRelacionadoNanda.accion, 
                           SS_HC_FactorRelacionadoNanda.version, 
                           @CONTADOR  
                           AS 
                           Contador, 
                           Row_number() 
                             OVER ( 
                               ORDER BY SS_HC_FactorRelacionadoNanda.IdFRN ASC ) 
                               AS 
                           RowNumber 
                    FROM   SS_HC_FactorRelacionadoNanda 
                     WHERE              ( @Descripcion IS NULL OR Upper(SS_HC_FactorRelacionadoNanda.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_FactorRelacionadoNanda.Estado = @Estado OR @Estado = 0 ) 
                                    AND ( @IdNanda IS NULL OR SS_HC_FactorRelacionadoNanda.IdNanda =@IdNanda OR @IdNanda = 0 ) 
                                    AND ( @IdFactorRelacionado IS NULL OR SS_HC_FactorRelacionadoNanda.IdFactorRelacionado = @IdFactorRelacionado OR @IdFactorRelacionado = 0 ) 
                                    AND ( @IdFRN IS NULL OR SS_HC_FactorRelacionadoNanda.IdFRN = @IdFRN OR @IdFRN = 0 )) 
                   AS LISTADO 
            WHERE  ( @Inicio IS NULL 
                     AND @NumeroFilas IS NULL ) 
                    OR rownumber BETWEEN @Inicio AND @NumeroFilas 
        END 
        
      ELSE IF( @ACCION = 'LISTARFACTORNANDA' ) 
        BEGIN           

           SELECT SS_HC_FactorRelacionado.Codigo as version, SS_HC_FactorRelacionado.Descripcion,SS_HC_FactorRelacionado.Estado
           , SS_HC_NANDA.IdNanda as IdNanda, SS_HC_FactorRelacionado.IdFactorRelacionado,SS_HC_FactorRelacionadoNanda.IdFRN as IdFRN
 
			FROM      dbo.SS_HC_FactorRelacionado INNER JOIN
                      dbo.SS_HC_FactorRelacionadoNanda 
                      ON dbo.SS_HC_FactorRelacionado.IdFactorRelacionado = dbo.SS_HC_FactorRelacionadoNanda.IdFactorRelacionado 
                       INNER JOIN SS_HC_NANDA 
                       
                      ON 
                      SS_HC_NANDA.IdNanda = SS_HC_FactorRelacionadoNanda.IdNanda                    
                                          
                      
                      
				Where	SS_HC_FactorRelacionadoNanda.IdNanda = @IdNanda
			 
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
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_FAVORITO]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_FAVORITO]  
   @IdFavorito int,  
            @Descripcion varchar(100),  
            @DescripcionExtranjera varchar(100),  
            @TipoFavorito int,  
            @IdFavoritoTabla int,  
            @IdAgente int,  
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
   select @CONTADOR= isnull(MAX(IdFavorito),0)+1 from ss_hc_favorito   
  set @IdFavorito= @CONTADOR  
   
  INSERT INTO ss_hc_favorito    
  (    
    IdFavorito,  
    Descripcion,  
    DescripcionExtranjera,  
    TipoFavorito,  
    IdFavoritoTabla,  
    IdAgente,  
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
    @IdFavorito,  
    @Descripcion,  
    @DescripcionExtranjera,  
    @TipoFavorito,  
    @IdFavoritoTabla,  
    @IdAgente,  
    @Estado,  
    @UsuarioCreacion,  
    GETDATE(),  
    @UsuarioModificacion,  
    GETDATE(),  
    @Accion,  
    @Version  
  )    
    
 SELECT 1     
 END     
 ELSE    
 IF(@Accion = 'UPDATE')    
 BEGIN    
 UPDATE ss_hc_favorito    
  SET        
    IdFavorito=@IdFavorito,  
    Descripcion=@Descripcion,  
    DescripcionExtranjera=@DescripcionExtranjera,  
    TipoFavorito=@TipoFavorito,  
    IdFavoritoTabla=@IdFavoritoTabla,  
    IdAgente=@IdAgente,  
    Estado=@Estado,  
    FechaCreacion=@FechaCreacion,  
    FechaModificacion=GETDATE(),  
    Accion=@Accion,  
    Version=@Version  
  WHERE   
  (IdFavorito = @IdFavorito)    
     select 1  
 end     
 else    
 if(@Accion = 'DELETE')    
 begin    
   delete  from SS_HC_FavoritoCodigoId  
  WHERE   
  (IdFavorito = @IdFavorito)  
   
  delete ss_hc_favorito    
  WHERE   
  (IdFavorito = @IdFavorito)    
     select 1  
end  
  else if(@Accion = 'CONTARLISTAPAG')  
 begin    
    
  SET @CONTADOR=(SELECT COUNT(IdFavorito) FROM ss_hc_favorito  
       WHERE   
     (@IdFavorito is null OR (IdFavorito = @IdFavorito) or @IdFavorito =0)  
    and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')       
      and (@Estado is null OR Estado = @Estado)  
     )  
       
  select @CONTADOR  
 end  
 else if(@Accion = 'NUEVOLISTAPAG')  
 begin    
    
  SET @CONTADOR=(
  SELECT SUM(CONTAR)FROM
  (SELECT COUNT(*) AS CONTAR FROM ss_hc_favorito  
       WHERE   
     (@IdFavorito is null OR (IdFavorito = @IdFavorito) or @IdFavorito =0)  
    and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')       
      and (Estado = 2)  
      AND (IdAgente IS NULL) 
      UNION 
      SELECT COUNT(*)AS CONTAR FROM ss_hc_favorito  
       WHERE   
     (@IdFavorito is null OR (IdFavorito = @IdFavorito) or @IdFavorito =0)  
    and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')       
      and (Estado = 2)  
      AND (IdAgente = @IdAgente)) AS LISTA
     )  
       
  select @CONTADOR  
 end  
commit    
END    
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_FAVORITO_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_FAVORITO_LISTAR]    
   @IdFavorito int,    
            @Descripcion varchar(100),    
            @DescripcionExtranjera varchar(100),    
            @TipoFavorito int,    
            @IdFavoritoTabla int,    
            @IdAgente int,    
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
if(@Accion = 'LISTARPAG')    
 begin    
   DECLARE @CONTADOR INT    
  SET @CONTADOR=(SELECT COUNT(IdFavorito) FROM ss_hc_favorito    
       WHERE     
     (@IdFavorito is null OR (IdFavorito = @IdFavorito) or @IdFavorito =0)    
    and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')         
      and (@Estado is null OR Estado = @Estado)    
     )    
  SELECT    
    IdFavorito,    
    Descripcion,    
    DescripcionExtranjera,    
    TipoFavorito,    
    IdFavoritoTabla,    
    IdAgente,    
    Estado,    
    UsuarioCreacion,    
    FechaCreacion,    
    UsuarioModificacion,    
    FechaModificacion,    
    Accion,    
    Version    
  FROM (      
   SELECT    
    IdFavorito,    
    Descripcion,    
    DescripcionExtranjera,    
    TipoFavorito,    
    IdFavoritoTabla,    
    IdAgente,    
    Estado,    
    UsuarioCreacion,    
    FechaCreacion,    
    UsuarioModificacion,    
    FechaModificacion,    
    Accion,    
    Version    
     ,@CONTADOR AS Contador    
     ,ROW_NUMBER() OVER (ORDER BY IdFavorito ASC ) AS RowNumber        
     FROM ss_hc_favorito     
     WHERE     
       (@IdFavorito is null OR (IdFavorito = @IdFavorito) or @IdFavorito =0)        
      and (@TipoFavorito is null OR (TipoFavorito = @TipoFavorito) or @TipoFavorito =0)        
     and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')         
     and (@Estado is null OR Estado = @Estado)      
     
   ) AS LISTADO    
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR      
            RowNumber BETWEEN @Inicio  AND @NumeroFilas     
      
       END    
       ELSE    
  IF @Accion ='LISTAR'        
    BEGIN        
  SELECT    
    IdFavorito,    
    Descripcion,    
    DescripcionExtranjera,    
    TipoFavorito,    
    IdFavoritoTabla,    
    IdAgente,    
    Estado,    
    UsuarioCreacion,    
    FechaCreacion,    
    UsuarioModificacion,    
    FechaModificacion,    
    Accion,    
    Version    
    FROM ss_hc_favorito     
    WHERE     
      (@IdFavorito is null OR (IdFavorito = @IdFavorito) or @IdFavorito =0)        
     and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')         
     and (@Estado is null OR Estado = @Estado)    
     and (@IdAgente is null OR IdAgente = @IdAgente)    
     
end     
 else    
 if(@ACCION = 'LISTARPORID')    
 begin      
    SELECT     
     *         
    from     
    ss_hc_favorito    
    
     WHERE     
     (@IdFavorito is null OR (IdFavorito = @IdFavorito) or @IdFavorito =0)     
    
 end 
 ELSE  
 if(@ACCION = 'LISTARxTABLA')    
 begin      
    SELECT top(1)     
     *         
    from     
    ss_hc_favorito    
    
     WHERE     
     (IdFavoritoTabla = @IdFavoritoTabla and IdAgente =@IdAgente and Estado =@Estado and TipoFavorito =1)     
    
 end     
 ELSE  
 if(@Accion = 'NUEVOLISTAPAG')    
 begin    
   DECLARE @CONTADORES INT    
  SET @CONTADOR=(
  SELECT COUNT(CONTAR)FROM(
  SELECT COUNT(IdFavorito)AS CONTAR FROM ss_hc_favorito    
       WHERE     
     (@IdFavorito is null OR (IdFavorito = @IdFavorito) or @IdFavorito =0)    
    and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')         
      and (Estado = 2)  
       AND (IdAgente IS NULL) 
       UNION
       SELECT COUNT(IdFavorito)AS CONTAR FROM ss_hc_favorito    
       WHERE     
     (@IdFavorito is null OR (IdFavorito = @IdFavorito) or @IdFavorito =0)    
    and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')         
      and (Estado = 2)  
       AND (IdAgente = @IdAgente)) AS LISTAR   
     )    
  SELECT    
    IdFavorito,    
    Descripcion,    
    DescripcionExtranjera,    
    TipoFavorito,    
    IdFavoritoTabla,    
    IdAgente,    
    Estado,    
    UsuarioCreacion,    
    FechaCreacion,    
    UsuarioModificacion,    
    FechaModificacion,    
    Accion,    
    Version    
  FROM (      
   SELECT    
    IdFavorito,    
    Descripcion,    
    DescripcionExtranjera,    
    TipoFavorito,    
    IdFavoritoTabla,    
    IdAgente,    
    Estado,    
    UsuarioCreacion,    
    FechaCreacion,    
    UsuarioModificacion,    
    FechaModificacion,    
    Accion,    
    Version    
     ,@CONTADORES AS Contador    
     ,ROW_NUMBER() OVER (ORDER BY IdFavorito ASC ) AS RowNumber        
     FROM ss_hc_favorito     
     WHERE     
       (@IdFavorito is null OR (IdFavorito = @IdFavorito) or @IdFavorito =0)        
      and (@TipoFavorito is null OR (TipoFavorito = @TipoFavorito) or @TipoFavorito =0)        
     and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')         
     and (Estado = 2)      
   AND (IdAgente IS NULL)  
   UNION
   SELECT    
    IdFavorito,    
    Descripcion,    
    DescripcionExtranjera,    
    TipoFavorito,    
    IdFavoritoTabla,    
    IdAgente,    
    Estado,    
    UsuarioCreacion,    
    FechaCreacion,    
    UsuarioModificacion,    
    FechaModificacion,    
    Accion,    
    Version    
     ,@CONTADORES AS Contador    
     ,ROW_NUMBER() OVER (ORDER BY IdFavorito ASC ) AS RowNumber        
     FROM ss_hc_favorito     
     WHERE     
       (@IdFavorito is null OR (IdFavorito = @IdFavorito) or @IdFavorito =0)        
      and (@TipoFavorito is null OR (TipoFavorito = @TipoFavorito) or @TipoFavorito =0)        
     and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')         
     and (Estado = 2)      
   AND (IdAgente = @IdAgente)  
   ) AS LISTADO    
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR      
            RowNumber BETWEEN @Inicio  AND @NumeroFilas     
      
       END     
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_FAVORITOCODIGOID]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_FAVORITOCODIGOID]
			@IdFavorito int,
            @CampoCodigoId int,
            @IndicadorCodigoId int,
            @ValorTexto varchar(100),
            @ValorId int,
            @ValorFecha datetime,
            @ValorDecimal decimal(10,0),
            @Estado int,
            @Accion varchar(25),
            @Version varchar(25)
AS  
BEGIN   
SET NOCOUNT ON;  
BEGIN  TRANSACTION  
  
 DECLARE @CONTADOR INT  
 IF(@Accion = 'INSERT')  
 BEGIN   
 		select @CONTADOR= isnull(MAX(CampoCodigoId),0)+1 from SS_HC_FAVORITOCODIGOID 
		
		set @CampoCodigoId= @CONTADOR
		
  INSERT INTO SS_HC_FAVORITOCODIGOID  
  (  
				IdFavorito,
				CampoCodigoId,
				IndicadorCodigoId,
				ValorTexto,
				ValorId,
				ValorFecha,
				ValorDecimal,
				Estado,
				Accion,
				Version
  )  
    VALUES  
  (   
			@IdFavorito,
            @CampoCodigoId,
            @IndicadorCodigoId,
            @ValorTexto,
            @ValorId,
            @ValorFecha,
            @ValorDecimal,
            @Estado,
            @Accion,
            @Version 
  )  
  
 SELECT 1		 
 END   
 ELSE  
 IF(@Accion = 'UPDATE')  
 BEGIN  
 UPDATE SS_HC_FAVORITOCODIGOID  
  SET     
				IdFavorito=@IdFavorito,
				CampoCodigoId=@CampoCodigoId,
				IndicadorCodigoId=@IndicadorCodigoId,
				ValorTexto=@ValorTexto,
				ValorId=@ValorId,
				ValorFecha=@ValorFecha,
				ValorDecimal=@ValorDecimal,
				Estado=@Estado,
				Accion=@Accion,
				Version=@Version
		WHERE 
		(CampoCodigoId = @CampoCodigoId)  
   		select 1
 end   
 else  
 if(@Accion = 'DELETE')  
 begin  
  delete SS_HC_FAVORITOCODIGOID  
		WHERE 
		(CampoCodigoId = @CampoCodigoId)  
   		select 1
end
		if(@Accion = 'CONTARLISTAPAG')
	begin		
		
		SET @CONTADOR=(SELECT COUNT(CampoCodigoId) FROM SS_HC_FAVORITOCODIGOID
	 					WHERE 
					(@IdFavorito is null OR (IdFavorito = @IdFavorito) or @IdFavorito =0)
					and (@CampoCodigoId is null OR (CampoCodigoId = @CampoCodigoId) or @CampoCodigoId =0)					
					and (@Estado is null OR Estado = @Estado)
					)
					
		select @CONTADOR
	end
commit	 
END  
 
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_FAVORITOCODIGOID_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_FAVORITOCODIGOID_LISTAR]
			@IdFavorito int,
            @CampoCodigoId int,
            @IndicadorCodigoId int,
            @ValorTexto varchar(100),
            @ValorId int,
            @ValorFecha datetime,
            @ValorDecimal decimal(10,0),
            @Estado int,
            @Accion varchar(25),
            @Version varchar(25),
            
			@INICIO   int= null,  
			@NUMEROFILAS int = null  
AS    
BEGIN    
if(@ACCION = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR=(SELECT COUNT(CampoCodigoId) FROM SS_HC_FAVORITOCODIGOID
	 					WHERE 
					(@IdFavorito is null OR (IdFavorito = @IdFavorito) or @IdFavorito =0)
					and (@CampoCodigoId is null OR (CampoCodigoId = @CampoCodigoId) or @CampoCodigoId =0)					
					and (@Estado is null OR Estado = @Estado)
					)
		SELECT
				IdFavorito,
				CampoCodigoId,
				IndicadorCodigoId,
				ValorTexto,
				ValorId,
				ValorFecha,
				ValorDecimal,
				Estado,
				Accion,
				Version
		FROM (		
			SELECT
				IdFavorito,
				CampoCodigoId,
				IndicadorCodigoId,
				ValorTexto,
				ValorId,
				ValorFecha,
				ValorDecimal,
				Estado,
				Accion,
				Version
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY CampoCodigoId ASC ) AS RowNumber   	
					FROM SS_HC_FAVORITOCODIGOID	
					WHERE 
						(@IdFavorito is null OR (IdFavorito = @IdFavorito) or @IdFavorito =0)
					and (@CampoCodigoId is null OR (CampoCodigoId = @CampoCodigoId) or @CampoCodigoId =0)				
					and (@ValorTexto is null  OR @ValorTexto =''  OR  upper(ValorTexto) like '%'+upper(@ValorTexto)+'%')					
					and (@Estado is null OR Estado = @Estado)		
 
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		
       END
       ELSE
  IF @Accion ='LISTAR'    
    BEGIN    
		SELECT
				IdFavorito,
				CampoCodigoId,
				IndicadorCodigoId,
				ValorTexto,
				ValorId,
				ValorFecha,
				ValorDecimal,
				Estado,
				Accion,
				Version
				FROM SS_HC_FAVORITOCODIGOID	
									WHERE 
						(@IdFavorito is null OR (IdFavorito = @IdFavorito) or @IdFavorito =0)
					and (@CampoCodigoId is null OR (CampoCodigoId = @CampoCodigoId) or @CampoCodigoId =0)				
					and (@ValorTexto is null  OR @ValorTexto =''  OR  upper(ValorTexto) like '%'+upper(@ValorTexto)+'%')					
					and (@Estado is null OR Estado = @Estado)	
 
end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 
					*					
				from 
				SS_HC_FAVORITOCODIGOID

					WHERE 
						(@IdFavorito is null OR (IdFavorito = @IdFavorito) or @IdFavorito =0)
					and (@CampoCodigoId is null OR (CampoCodigoId = @CampoCodigoId) or @CampoCodigoId =0)	

	end	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_FAVORITODETALLEDETALLE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_FAVORITODETALLEDETALLE]  
   @IdFavorito int,  
            @NumeroFavorito int,  
            @Secuencia int,  
            @ValorId int,  
            @ValorTexto1 varchar(300),  
            @ValorTexto2 varchar(30),  
            @ValorTexto3 varchar(30),  
            @ValorTexto4 varchar(30),  
            @ValorTexto5 varchar(30),  
            @UsuarioCreacion varchar(25),  
            @FechaCreacion datetime,  
            @Accion varchar(25),  
            @Version varchar(25),  
              
            @IdAgente int,  
            @TipoFavorito int  
              
AS    
BEGIN     
SET NOCOUNT ON;    
BEGIN  TRANSACTION    
    
 DECLARE @CONTADOR INT    
 DECLARE @CONTANDO INT 
 DECLARE @IDVALOR INT  
 DECLARE @CONTAR INT 
 IF(@Accion = 'INSERT')    
 BEGIN     
	   select @CONTADOR= isnull(MAX(Secuencia),0)+1 from SS_HC_FAVORITODETALLE   
	  set @Secuencia= @CONTADOR  
	  if (@ValorTexto4 ='ITEMS')
	  select @CONTANDO= count(IdFavorito) from SS_HC_FAVORITODETALLE
	   where ((ValorTexto2 = @ValorTexto2)
	   and (ValorTexto3 = @ValorTexto3)
	   and (ValorTexto4 = @ValorTexto4) 
	   and (ValorTexto5 = @ValorTexto5) 
	   and (IdFavorito = @IdFavorito)
	   and (NumeroFavorito=@NumeroFavorito)  ) 
	  ELSE
	  select @CONTANDO = count(IdFavorito) from SS_HC_FAVORITODETALLE
	   where (IdFavorito = @IdFavorito)
	   and (NumeroFavorito = @NumeroFavorito)
	   and (Secuencia=@Secuencia) --Angel
	   --and (ValorId = @ValorId)
	   IF(@CONTANDO =0)
	   BEGIN
	  INSERT INTO SS_HC_FAVORITODETALLE    
	  (    
		IdFavorito,  
		NumeroFavorito,  
		Secuencia,  
		ValorId,  
		ValorTexto1,  
		ValorTexto2,  
		ValorTexto3,  
		ValorTexto4,  
		ValorTexto5,  
		UsuarioCreacion,  
		FechaCreacion,  
		Accion,  
		Version  
	  )    
		VALUES    
	  (     
		@IdFavorito,  
		@NumeroFavorito,  
		@Secuencia,  
		@ValorId,  
		@ValorTexto1,  
		@ValorTexto2,  
		@ValorTexto3,  
		@ValorTexto4,  
		@ValorTexto5,  
		@UsuarioCreacion,  
		GETDATE(),  
		@Accion,  
		@Version  
	  )    
	  
	  
	 END    
	    
	 SELECT 1 
 END     
 ELSE    
 IF(@Accion = 'UPDATE')    
 BEGIN    
	 UPDATE SS_HC_FAVORITODETALLE    
	  SET       
		IdFavorito=@IdFavorito,  
		NumeroFavorito=@NumeroFavorito,  
		Secuencia=@Secuencia,  
		ValorId=@ValorId,  
		ValorTexto1=@ValorTexto1,  
		ValorTexto2=@ValorTexto2,  
		ValorTexto3=@ValorTexto3,  
		ValorTexto4=@ValorTexto4,  
		ValorTexto5=@ValorTexto5,  
		UsuarioCreacion=@UsuarioCreacion,  
		FechaCreacion=@FechaCreacion,  
		Accion=@Accion,  
		Version=@Version  
	  WHERE   
      (IdFavorito = @IdFavorito)  
     and (NumeroFavorito = @NumeroFavorito)  
     and (Secuencia = @Secuencia)  
     select 1  
 end     
 else    
 if(@Accion = 'DELETE')    
 begin    
  delete SS_HC_FAVORITODETALLE    
  WHERE   
      (IdFavorito = @IdFavorito)  
     and (NumeroFavorito = @NumeroFavorito)  
     and (Secuencia = @Secuencia)  
     select 1  
end  
  if(@Accion = 'CONTARLISTAPAG')  
 begin    
    
  SET @CONTADOR=(SELECT COUNT(Secuencia) FROM SS_HC_FAVORITODETALLE  
       WHERE   
      (@IdFavorito is null OR (IdFavorito = @IdFavorito) or @IdFavorito =0)  
     and (@NumeroFavorito is null OR (NumeroFavorito = @NumeroFavorito) or @NumeroFavorito =0)  
     and (@Secuencia is null OR (Secuencia = @Secuencia) or @Secuencia =0)  
    and (@ValorTexto1 is null  OR @ValorTexto1 =''  OR  upper(ValorTexto1) like '%'+upper(@ValorTexto1)+'%')  
     )         
  select @CONTADOR  
 end  
 else    
 if(@Accion = 'DELETEUSER')    
 begin    
	if(@ValorTexto4= 'ITEMS')
	begin
	  delete SS_HC_FAVORITODETALLE    
	  WHERE   
		  (IdFavorito = @IdFavorito)  
		 and (NumeroFavorito = @NumeroFavorito)  
		 and (ValorTexto5 = @ValorTexto5)  	
		 and (ValorTexto2 = @ValorTexto2)  	
		 and (ValorTexto3 = @ValorTexto3)  	
	end

	if(@ValorTexto4= 'DELETEDIAGFAVORITOS')
	begin
	  delete SS_HC_FAVORITODETALLE    
	  WHERE   
		   (IdFavorito = @IdFavorito)  
		 and (NumeroFavorito = @NumeroFavorito) 
	   AND (ValorId = @ValorTexto3) 
	end

	else
	begin
	  delete SS_HC_FAVORITODETALLE    
		    WHERE   
		  (IdFavorito = @IdFavorito)  
		 and (NumeroFavorito = @NumeroFavorito)  
		 and (ValorTexto3 = @ValorTexto3)  	
	end
     select 1  
end  
 
commit    
END    
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_FAVORITODETALLEDETALLE_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_FAVORITODETALLEDETALLE_LISTAR]
			@IdFavorito int,
            @NumeroFavorito int,
            @Secuencia int,
            @ValorId int,
            @ValorTexto1 varchar(30),
            @ValorTexto2 varchar(30),
            @ValorTexto3 varchar(30),
            @ValorTexto4 varchar(30),
            @ValorTexto5 varchar(30),
            @UsuarioCreacion varchar(25),
            @FechaCreacion datetime,
            @Accion varchar(25),
            @Version varchar(25),            
            @IdAgente int,
            @TipoFavorito int,            
			@INICIO   int= null,  
			@NUMEROFILAS int = null   
AS
BEGIN    
if(@Accion = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
		SET @CONTADOR=(SELECT COUNT(Secuencia) FROM SS_HC_FAVORITODETALLE
	 					WHERE 
						(@IdFavorito is null OR (IdFavorito = @IdFavorito) or @IdFavorito =0)
					and	(@NumeroFavorito is null OR (NumeroFavorito = @NumeroFavorito) or @NumeroFavorito =0)
					and	(@Secuencia is null OR (Secuencia = @Secuencia) or @Secuencia =0)
				and (@ValorTexto1 is null  OR @ValorTexto1 =''  OR  upper(ValorTexto1) like '%'+upper(@ValorTexto1)+'%')

					)
		SELECT
				IdFavorito,
				NumeroFavorito,
				Secuencia,
				ValorId,
				ValorTexto1,
				ValorTexto2,
				ValorTexto3,
				ValorTexto4,
				ValorTexto5,
				UsuarioCreacion,
				FechaCreacion,
				Accion,
				Version
		FROM (		
			SELECT
				IdFavorito,
				NumeroFavorito,
				Secuencia,
				ValorId,
				ValorTexto1,
				ValorTexto2,
				ValorTexto3,
				ValorTexto4,
				ValorTexto5,
				UsuarioCreacion,
				FechaCreacion,
				Accion,
				Version
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY Secuencia ASC ) AS RowNumber   	
					FROM SS_HC_FAVORITODETALLE	
					WHERE 
						(@IdFavorito is null OR (IdFavorito = @IdFavorito) or @IdFavorito =0)
					and	(@NumeroFavorito is null OR (NumeroFavorito = @NumeroFavorito) or @NumeroFavorito =0)
					and	(@Secuencia is null OR (Secuencia = @Secuencia) or @Secuencia =0)	
				and (@ValorTexto1 is null  OR @ValorTexto1 =''  OR  upper(ValorTexto1) like '%'+upper(@ValorTexto1)+'%')	
 
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
				Secuencia,
				ValorId,
				ValorTexto1,
				ValorTexto2,
				ValorTexto3,
				ValorTexto4,
				ValorTexto5,
				UsuarioCreacion,
				FechaCreacion,
				Accion,
				Version
				FROM SS_HC_FAVORITODETALLE	
				WHERE 
						(@IdFavorito is null OR (IdFavorito = @IdFavorito) or @IdFavorito =0)
					and	(@NumeroFavorito is null OR (NumeroFavorito = @NumeroFavorito) or @NumeroFavorito =0)
					and	(@Secuencia is null OR (Secuencia = @Secuencia) or @Secuencia =0)	
				and (@ValorTexto1 is null  OR @ValorTexto1 =''  OR  upper(ValorTexto1) like '%'+upper(@ValorTexto1)+'%')
				and (@ValorId is null OR (ValorId = @ValorId) or @ValorId =0)
 
	end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 
					*					
				from 
				SS_HC_FAVORITODETALLE

					WHERE 
						(@IdFavorito is null OR (IdFavorito = @IdFavorito) or @IdFavorito =0)
					and	(@NumeroFavorito is null OR (NumeroFavorito = @NumeroFavorito) or @NumeroFavorito =0)
					and	(@Secuencia is null OR (Secuencia = @Secuencia) or @Secuencia =0)	
				and (@ValorTexto1 is null  OR @ValorTexto1 =''  OR  upper(ValorTexto1) like '%'+upper(@ValorTexto1)+'%')	

	end	
	else
	if(@ACCION = 'LISTARPORAGENTE')
	begin	 
					select * 
					from dbo.SS_HC_FavoritoDetalle favDetalle
					inner join SS_HC_Favorito fav
					on (fav.IdFavorito = favDetalle.IdFavorito
					and fav.IdAgente = @IdAgente)

	end		
END
 /*          
exec SP_SS_HC_FAVORITODETALLEDETALLE_LISTAR
			NULL,
            NULL,
            NULL,
            NULL,
            NULL,
            
			NULL,
            NULL,
            NULL,
            NULL,
            NULL,
            
			NULL,
            'LISTARPORAGENTE',
            NULL,
            2009,  --AGENTE
            NULL, --TIPO
            
			0,  
			0
			*/
					   			           
           
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_FavoritoNumero]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_FavoritoNumero]

           @IdFavorito int,
           @NumeroFavorito int,
           @Mnemotecnico varchar(15),
           @Descripcion varchar(100),
           @DescripcionExtranjera varchar(100),
           @IndicadorPorDefecto int,
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
 		Select @CONTADOR= isnull(MAX(NumeroFavorito),0)+1 from ss_hc_favoritonumero where IdFavorito=@IdFavorito 		
		set @NumeroFavorito= @CONTADOR		
		IF (@Version IS NOT NULL)
  BEGIN
	UPDATE ss_hc_favorito
	SET IdAgente = @Version
	WHERE (ss_hc_favorito.IdFavorito = @IdFavorito) 
	END
  INSERT INTO ss_hc_favoritonumero  
  (  
				IdFavorito,
				NumeroFavorito,
				Mnemotecnico,
				Descripcion,
				DescripcionExtranjera,
				IndicadorPorDefecto,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion
  )  
    VALUES  
  (   
			
				@IdFavorito,
				@NumeroFavorito,
				@Mnemotecnico,
				@Descripcion,
				@DescripcionExtranjera,
				@IndicadorPorDefecto,
				@Estado,
				@UsuarioCreacion,
				GETDATE(),
				@UsuarioModificacion,
				GETDATE(),
				@Accion
  )  
  
 SELECT 1		 
 END  
 ELSE IF @Accion ='LISTARGRUPO'    
    BEGIN   
    DECLARE @CONTAR INT
    SET @CONTAR=(SELECT COUNT(*) FROM  ss_hc_favoritonumero	
				INNER JOIN ss_hc_favorito ON (ss_hc_favorito.IdFavorito = SS_HC_FavoritoNumero.IdFavorito)
				INNER JOIN SS_HC_Tabla ON (SS_HC_Tabla.IdFavoritoTabla = ss_hc_favorito.IdFavoritoTabla) 
				WHERE (@Descripcion IS NULL OR Upper(ss_hc_favoritonumero.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
				  AND (@IdFavorito IS NULL OR SS_HC_Tabla.IdFavoritoTabla = @IdFavorito OR @IdFavorito = 0 ) )   
				  SELECT @CONTAR;  
	END	 
 ELSE  
 IF(@Accion = 'UPDATE')  
 BEGIN  
 UPDATE ss_hc_favoritonumero  
  SET      
			
				IdFavorito=@IdFavorito,
				NumeroFavorito=@NumeroFavorito,
				Mnemotecnico=@Mnemotecnico,
				Descripcion=@Descripcion,
				DescripcionExtranjera=@DescripcionExtranjera,
				IndicadorPorDefecto=@IndicadorPorDefecto,
				Estado=@Estado,
				UsuarioModificacion=@UsuarioModificacion,
				FechaModificacion=GETDATE(),
				Accion=@Accion
				--,
				--Version=@Version
		WHERE 
		(IdFavorito = @IdFavorito)  
		and (NumeroFavorito = @NumeroFavorito)
   		select 1
 end   
 else  
 if(@Accion = 'DELETE')  
 begin 
 delete SS_HC_FavoritoDetalle 
 where (IdFavorito = @IdFavorito)  
		and (NumeroFavorito = @NumeroFavorito)
  delete ss_hc_favoritonumero  
		WHERE 
		(IdFavorito = @IdFavorito)  
		and (NumeroFavorito = @NumeroFavorito)
   		select 1
end
		if(@Accion = 'CONTARLISTAPAG')
	begin		
		
		SET @CONTADOR=(SELECT COUNT(NumeroFavorito) FROM ss_hc_favoritoNumero
	 					WHERE 
					(@IdFavorito is null OR (IdFavorito = @IdFavorito) or @IdFavorito =0)
				and	(@NumeroFavorito is null OR (NumeroFavorito = @NumeroFavorito) or @NumeroFavorito =0)
				and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')					
				and (@Estado is null OR Estado = @Estado)
					)
					
		select @CONTADOR
	end
commit	 
END  
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_FavoritoNumeroListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_FavoritoNumeroListar]

           @IdFavorito int,
           @NumeroFavorito int,
           @Mnemotecnico varchar(15),
           @Descripcion varchar(100),
           @DescripcionExtranjera varchar(100),
           @IndicadorPorDefecto int,
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
if(@Accion = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
		SET @CONTADOR=(SELECT COUNT(NumeroFavorito) FROM  ss_hc_favoritoNumero
	 					WHERE 
					(@IdFavorito is null OR (IdFavorito = @IdFavorito) or @IdFavorito =0)
				and	(@NumeroFavorito is null OR (NumeroFavorito = @NumeroFavorito) or @NumeroFavorito =0)
				and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')					
				and (@Estado is null OR Estado = @Estado)
					)
		SELECT
				IdFavorito,
				NumeroFavorito,
				Mnemotecnico,
				Descripcion,
				DescripcionExtranjera,
				IndicadorPorDefecto,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version
		FROM (		
			SELECT
				IdFavorito,
				NumeroFavorito,
				Mnemotecnico,
				Descripcion,
				DescripcionExtranjera,
				IndicadorPorDefecto,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY NumeroFavorito ASC ) AS RowNumber   	
					FROM ss_hc_favoritonumero	
					WHERE 
					(@IdFavorito is null OR (IdFavorito = @IdFavorito) or @IdFavorito =0)
				and	(@NumeroFavorito is null OR (NumeroFavorito = @NumeroFavorito) or @NumeroFavorito =0)
				and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')					
				and (@Estado is null OR Estado = @Estado)		
 
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
				IndicadorPorDefecto,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version
				
				FROM ss_hc_favoritonumero	
				WHERE 
					(@IdFavorito is null OR (IdFavorito = @IdFavorito) or @IdFavorito =0)
				and	(@NumeroFavorito is null OR (NumeroFavorito = @NumeroFavorito) or @NumeroFavorito =0)
				and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')	
				and (@Mnemotecnico is null  OR @Mnemotecnico =''  OR  upper(Mnemotecnico) like '%'+upper(@Mnemotecnico)+'%')				
				and (@Estado is null OR Estado = @Estado)
 
	end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 
					*					
				from 
				ss_hc_favoritonumero

					WHERE 
					(@IdFavorito is null OR (IdFavorito = @IdFavorito) or @IdFavorito =0)	
					and (@NumeroFavorito is null OR (NumeroFavorito = @NumeroFavorito) or @NumeroFavorito =0)	

	end	
	else
	if(@ACCION = 'LISTARMENUFAV')
	begin	 
				select * 
				from dbo.SS_HC_FavoritoNumero favNumero
				inner join SS_HC_Favorito fav
				on (fav.IdFavorito = favNumero.IdFavorito
				and fav.IdAgente = @INICIO)  --INICIO AUX AGENTE				
				WHERE 
				favNumero.IdFavorito in (select c.IdFavorito from SS_HC_Favorito c where c.IdFavoritoTabla=CAST(@Version as int) and c.IdAgente=@INICIO and c.Estado = 2)
	end		
	ELSE IF @Accion ='LISTARGRUPO'    
    BEGIN   
    DECLARE @CONTAR INT
		SET @CONTAR=(SELECT COUNT(*) FROM  ss_hc_favoritonumero	
				INNER JOIN ss_hc_favorito ON (ss_hc_favorito.IdFavorito = SS_HC_FavoritoNumero.IdFavorito)
				INNER JOIN SS_HC_Tabla ON (SS_HC_Tabla.IdFavoritoTabla = ss_hc_favorito.IdFavoritoTabla) 
				WHERE (@Descripcion IS NULL OR Upper(ss_hc_favoritonumero.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
				  AND (@IdFavorito IS NULL OR SS_HC_Tabla.IdFavoritoTabla = @IdFavorito OR @IdFavorito = 0 ) )
     
    SELECT 
    IdFavorito,
    NumeroFavorito,
    Mnemotecnico,
	Descripcion,
	DescripcionExtranjera,
	IndicadorPorDefecto,
	Estado,
	UsuarioCreacion,
	FechaCreacion,
	UsuarioModificacion,
	FechaModificacion,
	Accion,
	Version 
	FROM(SELECT				
				ss_hc_favoritonumero.IdFavorito,
				NumeroFavorito,
				Mnemotecnico,
				ss_hc_favoritonumero.Descripcion,
				ss_hc_tabla.nombretabla DescripcionExtranjera, --NOMBRETABLA
				ss_hc_favorito.idfavoritotabla IndicadorPorDefecto, --IDFAVORITOTABLA
				ss_hc_favoritonumero.Estado,
				ss_hc_favoritonumero.UsuarioCreacion,
				ss_hc_favoritonumero.FechaCreacion,
				ss_hc_favoritonumero.UsuarioModificacion,
				ss_hc_favoritonumero.FechaModificacion,
				ss_hc_favoritonumero.Accion,
				ss_hc_tabla.descripcion Version, --DESCRIPCIONTABLA
				@CONTAR AS Contador,
				ROW_NUMBER() OVER (ORDER BY NumeroFavorito ASC ) AS RowNumber  
				FROM ss_hc_favoritonumero	
				INNER JOIN ss_hc_favorito
				ON (ss_hc_favorito.IdFavorito = SS_HC_FavoritoNumero.IdFavorito)
				INNER JOIN SS_HC_Tabla
				ON (SS_HC_Tabla.IdFavoritoTabla = ss_hc_favorito.IdFavoritoTabla)  
				WHERE (@Descripcion IS NULL OR Upper(ss_hc_favoritonumero.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
				  AND (@IdFavorito IS NULL OR SS_HC_Tabla.IdFavoritoTabla = @IdFavorito OR @IdFavorito = 0 ) 
				)as LISTARGRUPO
               WHERE ((@Inicio  Is null AND @NumeroFilas Is null) OR RowNumber BETWEEN @Inicio  AND @NumeroFilas )
 
	end	
	
END

/*
exec SP_SS_HC_FavoritoNumeroListar

           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           'LISTARGRUPO',
           NULL,
           NULL,
           NULL
*/

			           
           
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Formato]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_Formato] 
@IdFormato             INT, 
@IdFormatoPadre        INT, 
@CodigoFormato         VARCHAR(20), 
@CodigoFormatoPadre    VARCHAR(20), 
@CadenaRecursividad    VARCHAR(150), 

@Nivel                 INT, 
@Descripcion           VARCHAR(100), 
@DescripcionExtranjera VARCHAR(100), 
@TipoFormato           INT, 
@VersionFormatoFijo    VARCHAR(50), 

@IdFormatoDinamico     INT, 
@Estado                INT, 
@UsuarioCreacion       VARCHAR(25), 
@FechaCreacion         DATETIME, 
@UsuarioModificacion   VARCHAR(25), 

@IndCompartido	INT,

@FechaModificacion     DATETIME, 
@Accion                VARCHAR( 25), 
@Version               VARCHAR( 25),
@Modulo               VARCHAR( 25)  
AS 
  BEGIN 
      SET nocount ON; 
		--select * from ss_hc_formato
      IF @Accion = 'INSERT' 
        BEGIN 
            SELECT @IdFormato = Isnull(Max(ss_hc_formato.IdFormato), 0) + 1 
            FROM   dbo.ss_hc_formato 

            INSERT INTO ss_hc_formato 
                        (idformato, 
                         idformatopadre, 
                         codigoformato, 
                         codigoformatopadre, 
                         cadenarecursividad, 
                         nivel, 
                         descripcion, 
                         descripcionextranjera, 
                         tipoformato, 
                         versionformatofijo, 
                         idformatodinamico, 
                         estado, 
                         usuariocreacion, 
                         fechacreacion, 
                         usuariomodificacion, 
                         fechamodificacion, 
                         accion, 
                         version,
                         Modulo
                         ,IndCompartido
                         ) 
            VALUES      ( @IdFormato, 
                          @IdFormatoPadre, 
                          @CodigoFormato, 
                          @CodigoFormatoPadre, 
                          @CadenaRecursividad, 
                          @Nivel, 
                          @Descripcion, 
                          @DescripcionExtranjera, 
                          @TipoFormato, 
                          @VersionFormatoFijo, 
                          @IdFormatoDinamico, 
                          @Estado, 
                          @UsuarioCreacion, 
                          Getdate(), 
                          @UsuarioModificacion, 
                          Getdate(), 
                          @Accion, 
                          @Version ,
                          @Modulo
                          ,@IndCompartido
                          ) 

            SELECT 1 
        END 
		ELSE IF @Accion = 'NUEVO' 
        BEGIN 
            SELECT @IdFormato = Isnull(Max(ss_hc_formato.IdFormato), 0) + 1 
            FROM   dbo.ss_hc_formato 

            INSERT INTO ss_hc_formato 
                        (idformato, 
                         idformatopadre, 
                         codigoformato, 
                         codigoformatopadre, 
                         cadenarecursividad, 
                         nivel, 
                         descripcion, 
                         descripcionextranjera, 
                         tipoformato, 
                         versionformatofijo, 
                         idformatodinamico, 
                         estado, 
                         usuariocreacion, 
                         fechacreacion, 
                         usuariomodificacion, 
                         fechamodificacion, 
                         accion, 
                         version,
                         Modulo
                         ,IndCompartido
                         ) 
            VALUES      ( @IdFormato, 
                          @IdFormatoPadre, 
                          @CodigoFormato, 
                          @CodigoFormatoPadre, 
                          @CadenaRecursividad, 
                          @Nivel, 
                          @Descripcion, 
                          @DescripcionExtranjera, 
                          @TipoFormato, 
                          @VersionFormatoFijo, 
                          @IdFormatoDinamico, 
                          @Estado, 
                          @UsuarioCreacion, 
                          Getdate(), 
                          @UsuarioModificacion, 
                          Getdate(), 
                          @Accion, 
                          @Version ,
                          @Modulo
                          ,@IndCompartido
                          ) 

            SELECT 1 
        END 
      ELSE IF @Accion = 'UPDATE' 
        BEGIN 
            UPDATE ss_hc_formato 
            SET    idformato = @IdFormato, 
                   idformatopadre = @IdFormatoPadre, 
                   codigoformato = @CodigoFormato, 
                   codigoformatopadre = @CodigoFormatoPadre, 
                   cadenarecursividad = @CadenaRecursividad, 
                   nivel = @Nivel, 
                   descripcion = @Descripcion, 
                   descripcionextranjera = @DescripcionExtranjera, 
                   tipoformato = @TipoFormato, 
                   versionformatofijo = @VersionFormatoFijo, 
                   idformatodinamico = @IdFormatoDinamico, 
                   estado = @Estado, 
                   usuariomodificacion = @UsuarioModificacion, 
                   fechamodificacion = GETDATE(), 
                   accion = @Accion, 
                   version = @Version ,
                   Modulo = @Modulo
                   ,IndCompartido = @IndCompartido
            WHERE  ( ss_hc_formato.idformato = @IdFormato ) 

            SELECT 1 
        END 
      ELSE IF @Accion = 'DELETE' 
        BEGIN 
            DELETE FROM ss_hc_formato 
            WHERE  ( ss_hc_formato.idformato = @IdFormato ) 

            SELECT 1 
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) FROM   ss_hc_formato 
                             WHERE  ( @Descripcion IS NULL OR Upper(ss_hc_formato.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                              --  AND ( ss_hc_formato.idformato = @IdFormato OR @IdFormato IS NULL OR @IdFormato = 0 ) 
                                AND ( @Estado IS NULL OR ss_hc_formato.estado = @Estado OR @Estado=0 ) 
                                AND ( @CodigoFormatoPadre IS NULL OR Upper(ss_hc_formato.CodigoFormatoPadre) LIKE '%' + Upper(@CodigoFormatoPadre) + '%' ) 
                                AND ( @TipoFormato IS NULL OR ss_hc_formato.TipoFormato = @TipoFormato OR @TipoFormato = 0 ) )

            SELECT @CONTADOR; 
        END 
  END 
/*  
EXEC SP_SS_HC_Formato  
0,0, NULL, NULL, NULL,  
0, NULL, NULL, 0, NULL,  
0, 0, NULL, NULL,  
NULL,NULL, LISTARPAG ,NULL 
*/ 
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Formato_Lista]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_Formato_Lista]
@IdFormato             INT, 
@IdFormatoPadre        INT, 
@CodigoFormato         VARCHAR(20), 
@CodigoFormatoPadre    VARCHAR(20), 
@CadenaRecursividad    VARCHAR(150), 

@Nivel                 INT, 
@Descripcion           VARCHAR(100), 
@DescripcionExtranjera VARCHAR(100), 
@TipoFormato           INT, 
@VersionFormatoFijo    VARCHAR(50), 

@IdFormatoDinamico     INT, 
@Estado                INT, 
@UsuarioCreacion       VARCHAR(25), 
@FechaCreacion         DATETIME, 
@UsuarioModificacion   VARCHAR(25), 
@FechaModificacion     DATETIME, 
@Modulo				   varchar(2),
@Accion                VARCHAR( 25), 
@Version               VARCHAR( 25), 
			@INICIO   int= null,  
			@NUMEROFILAS int = null
			
			  
           AS    
BEGIN    
if(@Accion = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR=(SELECT COUNT(*) FROM ss_hc_formato
                             WHERE  (@IdFormato is null OR (IdFormato = @IdFormato) or @IdFormato =0)
                                AND ( @Descripcion IS NULL OR Upper(ss_hc_formato.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                AND ( @Estado IS NULL OR ss_hc_formato.estado = @Estado OR @Estado=0 ) 
                                AND ( @CodigoFormatoPadre IS NULL OR Upper(ss_hc_formato.CodigoFormatoPadre) LIKE '%' + Upper(@CodigoFormatoPadre) + '%' ) 
                                AND ( @TipoFormato IS NULL OR ss_hc_formato.TipoFormato = @TipoFormato OR @TipoFormato = 0 )
                                AND ( @Modulo IS NULL OR Upper(ss_hc_formato.Modulo) LIKE '%' + Upper(@Modulo) + '%' ) 
                                AND ( @CodigoFormato is null OR (CodigoFormato = @CodigoFormato))
					)
		SELECT
				IdFormato,
				IdFormatoPadre,
				CodigoFormato,
				CodigoFormatoPadre,
				CadenaRecursividad,
				Nivel,
				Descripcion,
				DescripcionExtranjera,
				TipoFormato,
				VersionFormatoFijo,
				IdFormatoDinamico,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version
				,IndCompartido       
		FROM (		
			SELECT
				IdFormato,
				IdFormatoPadre,
				CodigoFormato,
				CodigoFormatoPadre,
				CadenaRecursividad,
				Nivel,
				Descripcion,
				DescripcionExtranjera,
				TipoFormato,
				VersionFormatoFijo,
				IdFormatoDinamico,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version
				,IndCompartido       
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY IdFormato ASC ) AS RowNumber   	
					FROM SS_HC_Formato	
                             WHERE  (@IdFormato is null OR (IdFormato = @IdFormato) or @IdFormato =0)
                                AND ( @CodigoFormato is null OR (CodigoFormato = @CodigoFormato))
                                AND ( @Descripcion IS NULL OR Upper(ss_hc_formato.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                AND ( @Estado IS NULL OR ss_hc_formato.estado = @Estado OR @Estado=0 ) 
                                AND ( @CodigoFormatoPadre IS NULL OR Upper(ss_hc_formato.CodigoFormatoPadre) LIKE '%' + Upper(@CodigoFormatoPadre) + '%' ) 
                                AND ( @TipoFormato IS NULL OR ss_hc_formato.TipoFormato = @TipoFormato OR @TipoFormato = 0 )
                                AND ( @Modulo IS NULL OR Upper(ss_hc_formato.Modulo) LIKE '%' + Upper(@Modulo) + '%' )  
 
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		
       END
       ELSE
   IF @Accion ='LISTAR'    
    BEGIN    
		SELECT
				IdFormato,
				IdFormatoPadre,
				CodigoFormato,
				CodigoFormatoPadre,
				CadenaRecursividad,
				Nivel,
				Descripcion,
				DescripcionExtranjera,
				TipoFormato,
				VersionFormatoFijo,
				IdFormatoDinamico,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version
				,IndCompartido       
				FROM SS_HC_Formato	
					
                             WHERE  ( @Descripcion IS NULL OR Upper(ss_hc_formato.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
								AND ( @IdFormato IS NULL OR ss_hc_formato.IdFormato = @IdFormato OR @IdFormato = 0 )
                                AND ( @Estado IS NULL OR ss_hc_formato.estado = @Estado OR @Estado=0 ) 
                                AND ( @CodigoFormatoPadre IS NULL OR Upper(ss_hc_formato.CodigoFormatoPadre) LIKE '%' + Upper(@CodigoFormatoPadre) + '%' ) 
                                AND ( @TipoFormato IS NULL OR ss_hc_formato.TipoFormato = @TipoFormato OR @TipoFormato = 0 )
                                AND ( @Modulo IS NULL OR Upper(ss_hc_formato.Modulo) LIKE '%' + Upper(@Modulo) + '%' )  
                                AND ( @CodigoFormato is null OR (CodigoFormato = @CodigoFormato))
 
end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 
					*					
				from 
				SS_HC_Formato

					WHERE 
							(@IdFormato = IdFormato)

	end	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Formato_Mantenimiento]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_Formato_Mantenimiento]
			@IdFormato int,
            @IdFormatoPadre int,
            @CodigoFormato varchar(20),
            @CodigoFormatoPadre varchar(20),
            @CadenaRecursividad varchar(150),
            @Nivel int,
            @Descripcion varchar(100),
            @DescripcionExtranjera varchar(100),
            @TipoFormato int,
            @VersionFormatoFijo varchar(50),
            @IdFormatoDinamico int,
            @Estado int,
            @UsuarioCreacion varchar(25),
            @FechaCreacion datetime,
            @UsuarioModificacion varchar(25),
            @FechaModificacion datetime,
            @Accion varchar(50),
            @Version varchar(50)
            AS  
BEGIN   
SET NOCOUNT ON;  
BEGIN  TRANSACTION  
  
 DECLARE @CONTADOR INT  
 IF(@Accion = 'INSERT')  
 BEGIN   
 		select @CONTADOR= isnull(MAX(IdFormato),0)+1 from SS_HC_Formato 
		
		set @IdFormato= @CONTADOR
		
  INSERT INTO SS_HC_Formato  
  (  
				IdFormato,
				IdFormatoPadre,
				CodigoFormato,
				CodigoFormatoPadre,
				CadenaRecursividad,
				Nivel,
				Descripcion,
				DescripcionExtranjera,
				TipoFormato,
				VersionFormatoFijo,
				IdFormatoDinamico,
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
				@IdFormato,
				@IdFormatoPadre,
				@CodigoFormato,
				@CodigoFormatoPadre,
				@CadenaRecursividad,
				@Nivel,
				@Descripcion,
				@DescripcionExtranjera,
				@TipoFormato,
				@VersionFormatoFijo,
				@IdFormatoDinamico,
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
 UPDATE SS_HC_Formato  
  SET      
				IdFormato=@IdFormato,
				IdFormatoPadre=IdFormatoPadre,
				CodigoFormato=@CodigoFormato,
				CodigoFormatoPadre=@CodigoFormatoPadre,
				CadenaRecursividad=@CadenaRecursividad,
				Nivel=@Nivel,
				Descripcion=@Descripcion,
				DescripcionExtranjera=@DescripcionExtranjera,
				TipoFormato=@TipoFormato,
				VersionFormatoFijo=@VersionFormatoFijo,
				IdFormatoDinamico=@IdFormatoDinamico,
				Estado=@Estado,
				UsuarioCreacion=@UsuarioCreacion,
				FechaCreacion=@FechaCreacion,
				UsuarioModificacion=@UsuarioModificacion,
				FechaModificacion=@FechaModificacion,
				Accion=@Accion,
				Version=@Version
		WHERE 
		(IdFormato = @IdFormato)  
   		select 1
 end   
 else  
 if(@Accion = 'DELETE')  
 begin  
  delete SS_HC_Formato  
		WHERE 
		(IdFormato = @IdFormato) 
   		select 1
end
		if(@Accion = 'CONTARLISTAPAG')
	begin		
		
	SET @CONTADOR=(SELECT COUNT(IdFormato) FROM SS_HC_Formato
	 					WHERE 
					(@IdFormato is null OR (IdFormato = @IdFormato) or @IdFormato =0)
					and (@IdFormatoPadre is null OR IdFormatoPadre = @IdFormatoPadre)					
					and (@Estado is null OR Estado = @Estado)
					)
					
		select @CONTADOR
	end
commit	 
END  
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_FormatoAsignacion]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_FormatoAsignacion]
(
	@IdFormatoAsignacion	int ,
	@IdOpcion	int ,
	@Nombre	varchar(80) ,
	@Descripcion	varchar(80) ,
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

	DECLARE @contador int =0
	if(@ACCION = 'INSERT')
	begin
		SELECT @contador= isnull(MAX(IdFormatoAsignacion),0)+1 
		from SS_HC_FormatoAsignacion		
		set @IdFormatoAsignacion = @contador
		
		INSERT INTO SS_HC_FormatoAsignacion
		(
			IdFormatoAsignacion
			,IdOpcion
			,Nombre
			,Descripcion
			,Estado
			,UsuarioCreacion
			,FechaCreacion
			,UsuarioModificacion
			,FechaModificacion
			,Accion
			,Version
		)
		VALUES
		(
			@IdFormatoAsignacion
		,	@IdOpcion
		,	@Nombre
		,	@Descripcion
		,	@Estado
		,	@UsuarioCreacion
		,	GETDATE()
		,	@UsuarioModificacion
		,	GETDATE()
		,	@Accion
		,	@Version
		
		)
		
		return @IdFormatoAsignacion
	end
	else
	if(@ACCION = 'UPDATE')
	begin	
			update SS_HC_FormatoAsignacion
			set			
			IdOpcion	=	@IdOpcion
			,Nombre	=	@Nombre
			,Descripcion	=	@Descripcion
			,Estado	=	@Estado
			,UsuarioCreacion	=	@UsuarioCreacion
			--,FechaCreacion	=	@FechaCreacion
			,UsuarioModificacion	=	@UsuarioModificacion
			,FechaModificacion	=	GETDATE()
			--,Accion	=	@Accion
			,Version	=	@Version												
	 		WHERE 					
			(IdFormatoAsignacion = @IdFormatoAsignacion )																	

		return @IdFormatoAsignacion
	end
	else
	if(@ACCION = 'DELETE')
	begin	
			--delete SS_HC_FormatoCodigoId
	 	--	WHERE 					
			--(IdFormatoAsignacion = @IdFormatoAsignacion )			
				
			delete SS_HC_FormatoAsignacion
	 		WHERE 					
			(IdFormatoAsignacion = @IdFormatoAsignacion )																	

		return @IdFormatoAsignacion

	end	
commit	 
END  
/*
exec SP_SS_HC_FormatoAsignacion

	NULL,
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
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_FormatoAsignacion_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_FormatoAsignacion_LISTAR]
(
	@IdFormatoAsignacion	int ,
	@IdOpcion	int ,
	@Nombre	varchar(80) ,
	@Descripcion	varchar(80) ,
	@Estado	int ,
	
	@UsuarioCreacion	varchar(25) ,
	@FechaCreacion	datetime ,
	@UsuarioModificacion	varchar(25) ,
	@FechaModificacion	datetime ,	
	@Version	varchar(25) ,
	
	@Inicio	int ,	
	@NumeroFilas	int ,	
	@ACCION	varchar(25) 
			
)

AS
BEGIN
	if(@ACCION = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR=(
		SELECT COUNT(IdOpcion) 
				from 
				SS_HC_FormatoAsignacion
	 					WHERE 
					(@IdOpcion is null OR (IdOpcion = @IdOpcion) or @IdOpcion =0)
					and (@IdFormatoAsignacion is null OR IdFormatoAsignacion = @IdFormatoAsignacion or @IdFormatoAsignacion =0)					
					and (@ESTADO is null OR Estado = @ESTADO)					
					and (@NOMBRE is null  OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')
					)
	 
		SELECT 
			IdFormatoAsignacion
			,IdOpcion
			,Nombre
			,Descripcion
			,Estado
			,UsuarioCreacion
			,FechaCreacion
			,UsuarioModificacion
			,FechaModificacion
			,Accion
			,Version
				
		FROM (
				SELECT 
					SS_HC_FormatoAsignacion.*
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY IdFormatoAsignacion ASC ) AS RowNumber   					
				from 
				SS_HC_FormatoAsignacion
	 					WHERE 
					(@IdOpcion is null OR (IdOpcion = @IdOpcion) or @IdOpcion =0)
					and (@IdFormatoAsignacion is null OR IdFormatoAsignacion = @IdFormatoAsignacion or @IdFormatoAsignacion =0)					
					and (@ESTADO is null OR Estado = @ESTADO)					
					and (@NOMBRE is null  OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')
	
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
	end
	else
	if(@ACCION = 'LISTAR')
	begin
			SELECT 
			IdFormatoAsignacion
			,IdOpcion
			,Nombre
			,Descripcion
			,Estado
			,UsuarioCreacion
			,FechaCreacion
			,UsuarioModificacion
			,FechaModificacion
			,Accion
			,Version			
				from 
				SS_HC_FormatoAsignacion
	 					WHERE 
					(@IdOpcion is null OR (IdOpcion = @IdOpcion) or @IdOpcion =0)
					and (@IdFormatoAsignacion is null OR IdFormatoAsignacion = @IdFormatoAsignacion or @IdFormatoAsignacion =0)					
					and (@ESTADO is null OR Estado = @ESTADO)					
					and (@NOMBRE is null  OR @NOMBRE =''  OR  upper(Nombre) like '%'+upper(@NOMBRE)+'%')
						

	end	
	

END
/*
exec SP_SS_HC_FormatoAsignacion_LISTAR

	NULL,
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
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_FormatoCampo_Lista]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_FormatoCampo_Lista]  
   @IdFormato int,  
            @SecuenciaCampo int,  
            @IdFavoritoTabla int,  
            @IdCampo int,  
            @IdSeccionFormato int,  
            @TipoCampo int,  
            @ValorPorDefecto varchar(100),  
            @IndicadorObligatorio int,  
            @IndicadorCampoCalculado int,  
            @Formula varchar(500),  
            @IndicadorValoresVarios int,  
            @TablaValoresVarios varchar(15),  
            @IndicadorRango int,  
            @RangoDesde decimal(20,6),  
            @RangoHasta decimal(20,6),  
            @IndicadorReglaNegocio char(10),  
            @ReglaNegocio varchar(100),  
            @Observaciones varchar(500),  
            @Estado int,  
            @UsuarioCreacion varchar(25),  
            @FechaCreacion datetime,  
            @UsuarioModificacion varchar(25),  
            @FechaModificacion datetime,  
            @Accion varchar(25),  
            @Version varchar(25),   
            @DescripcionLocal varchar(500),
            @DescripcionExtranjera varchar(500),
            @IdConcepto int,
            @IdAgrupadorNivel int,
            @IdObjetoAgrupador int,
            @IdColumna int,
            @IdFila int,
            @IdEvento int,
            @IdParameterEnvio int,
            @Orden int,
            @IdAgrupadorNivelPadre int,    
		    @INICIO   int= null,    
		    @NUMEROFILAS int = null         
       
           AS      
BEGIN      
if(@Accion = 'LISTARPAG')  
 begin  
   DECLARE @CONTADOR INT  
   
  SET @CONTADOR=(SELECT COUNT(SecuenciaCampo) FROM SS_HC_FormatoCampo  
       WHERE   
			(@IdFormato is null OR (IdFormato = @IdFormato) or @IdFormato =0)  
	 and (@ValorPorDefecto is null  OR @ValorPorDefecto =''  OR  upper(ValorPorDefecto) like '%'+upper(@ValorPorDefecto)+'%')
     and (@SecuenciaCampo is null OR (SecuenciaCampo = @SecuenciaCampo) or @SecuenciaCampo =0)       
     and (@Estado is null OR Estado = @Estado) 
     )  
  SELECT  
    convert(int,ROW_NUMBER() OVER (ORDER BY IdFormato ASC )) as IdFormato,    
    SecuenciaCampo ,  
    IdFavoritoTabla,  
    IdCampo,  
    IdSeccionFormato,  
    TipoCampo,  
    ValorPorDefecto,  
    IndicadorObligatorio,  
    IndicadorCampoCalculado,  
    Formula,  
    IndicadorValoresVarios,  
    TablaValoresVarios,  
    IndicadorRango,  
    RangoDesde,  
    RangoHasta,  
    IndicadorReglaNegocio,  
    ReglaNegocio,  
    Observaciones,  
    Estado,  
    UsuarioCreacion,  
    FechaCreacion,  
    UsuarioModificacion,  
    FechaModificacion,  
    Accion,  
    convert(varchar,IdFormato) as Version  ,   
    DescripcionLocal,
	DescripcionExtranjera,
	IdConcepto,
	IdAgrupadorNivel,
	IdObjetoAgrupador,
	IdColumna,
	IdFila,
	IdEvento,
	IdParameterEnvio,
	Orden,
	IdAgrupadorNivelPadre  
  FROM (    
   SELECT  
    IdFormato,  
    SecuenciaCampo ,  
    IdFavoritoTabla,  
    IdCampo,  
    IdSeccionFormato,  
    TipoCampo,  
    ValorPorDefecto,  
    IndicadorObligatorio,  
    IndicadorCampoCalculado,  
    Formula,  
    IndicadorValoresVarios,  
    TablaValoresVarios,  
    IndicadorRango,  
    RangoDesde,  
    RangoHasta,  
    IndicadorReglaNegocio,  
    ReglaNegocio,  
    Observaciones,  
    Estado,  
    UsuarioCreacion,  
    FechaCreacion,  
    UsuarioModificacion,  
    FechaModificacion,  
    Accion,  
    Version,
    DescripcionLocal,
	DescripcionExtranjera,
	IdConcepto,
	IdAgrupadorNivel,
	IdObjetoAgrupador,
	IdColumna,
	IdFila,
	IdEvento,
	IdParameterEnvio,
	Orden,
	IdAgrupadorNivelPadre  
     ,@CONTADOR AS Contador  
     ,ROW_NUMBER() OVER (ORDER BY SecuenciaCampo ASC ) AS RowNumber      
     FROM SS_HC_FormatoCampo 
       WHERE   
			(@IdFormato is null OR (IdFormato = @IdFormato) or @IdFormato =0)  
	 and (@ValorPorDefecto is null  OR @ValorPorDefecto =''  OR  upper(ValorPorDefecto) like '%'+upper(@ValorPorDefecto)+'%')
     and (@SecuenciaCampo is null OR (SecuenciaCampo = @SecuenciaCampo) or @SecuenciaCampo =0)       
     and (@Estado is null OR Estado = @Estado)  
   
   ) AS LISTADO  
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR    
            RowNumber BETWEEN @Inicio  AND @NumeroFilas   
    
       END  
       ELSE  
        IF @Accion ='LISTARVISTA'    
Select SS_HC_Formato.CodigoFormato  as CodigoFormato, SS_HC_Formato.Descripcion as Descripcion,   
SS_HC_FormatoCampo.SecuenciaCampo as SecuenciaCampo, SS_HC_TablaCampo.NombreCampo AS NombreCampo,  
SS_HC_TablaCampo.Estado AS Estado  
     FROM      dbo.SS_HC_TablaCampo INNER JOIN    
                      dbo.SS_HC_Tabla INNER JOIN    
                      dbo.SS_HC_FormatoRecursoCampo ON dbo.SS_HC_Tabla.IdFavoritoTabla = dbo.SS_HC_FormatoRecursoCampo.IdFavoritoTabla INNER JOIN    
                      dbo.SS_HC_Formato INNER JOIN    
                      dbo.SS_HC_FormatoCampo ON dbo.SS_HC_Formato.IdFormato = dbo.SS_HC_FormatoCampo.IdFormato ON     
                      dbo.SS_HC_FormatoRecursoCampo.SecuenciaCampo = dbo.SS_HC_FormatoCampo.SecuenciaCampo ON     
                      dbo.SS_HC_TablaCampo.IdCampo = dbo.SS_HC_FormatoCampo.SecuenciaCampo            
          
        ELSE  
  IF @Accion ='LISTAR'      
    BEGIN      
  SELECT  
    IdFormato,  
    SecuenciaCampo,  
    IdFavoritoTabla,  
    IdCampo,  
    IdSeccionFormato,  
    TipoCampo,  
    ValorPorDefecto,  
    IndicadorObligatorio,  
    IndicadorCampoCalculado,  
    Formula,  
    IndicadorValoresVarios,  
    TablaValoresVarios,  
    IndicadorRango,  
    RangoDesde,  
    RangoHasta,  
    IndicadorReglaNegocio,  
    ReglaNegocio,  
    Observaciones,  
    Estado,  
    UsuarioCreacion,  
    FechaCreacion,  
    UsuarioModificacion,  
    FechaModificacion,  
    Accion,  
    Version,
    DescripcionLocal,
	DescripcionExtranjera,
	IdConcepto,
	IdAgrupadorNivel,
	IdObjetoAgrupador,
	IdColumna,
	IdFila,
	IdEvento,
	IdParameterEnvio,
	Orden,
	IdAgrupadorNivelPadre    
    FROM SS_HC_FormatoCampo   
       WHERE   
			(@IdFormato is null OR (IdFormato = @IdFormato) or @IdFormato =0)  
	 and (@ValorPorDefecto is null  OR @ValorPorDefecto =''  OR  upper(ValorPorDefecto) like '%'+upper(@ValorPorDefecto)+'%')
     and (@SecuenciaCampo is null OR (SecuenciaCampo = @SecuenciaCampo) or @SecuenciaCampo =0)       
     and (@Estado is null OR Estado = @Estado)  
   
end   
 else  
 if(@ACCION = 'LISTARPORID')  
 begin    
    SELECT   
     *       
    from   
    SS_HC_FormatoCampo  
  
     WHERE   
       (@IdFormato is null OR (IdFormato = @IdFormato) or @IdFormato =0)  
     and (@SecuenciaCampo is null OR (SecuenciaCampo = @SecuenciaCampo) or @SecuenciaCampo =0)   
  
 end   
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_FormatoCampo_Mantenimiento]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_FormatoCampo_Mantenimiento]
			@IdFormato int,
            @SecuenciaCampo int,
            @IdFavoritoTabla int,
            @IdCampo int,
            @IdSeccionFormato int,
            @TipoCampo int,
            @ValorPorDefecto varchar(100),
            @IndicadorObligatorio int,
            @IndicadorCampoCalculado int,
            @Formula varchar(500),
            @IndicadorValoresVarios int,
            @TablaValoresVarios varchar(15),
            @IndicadorRango int,
            @RangoDesde decimal(20,6),
            @RangoHasta decimal(20,6),
            @IndicadorReglaNegocio char(10),
            @ReglaNegocio varchar(100),
            @Observaciones varchar(500),
            @Estado int,
            @UsuarioCreacion varchar(25),
            @FechaCreacion datetime,
            @UsuarioModificacion varchar(25),
            @FechaModificacion datetime,
            @Accion varchar(25),
            @Version varchar(25), 
            @DescripcionLocal varchar(500),
            @DescripcionExtranjera varchar(500),
            @IdConcepto int,
            @IdAgrupadorNivel int,
            @IdObjetoAgrupador int,
            @IdColumna int,
            @IdFila int,
            @IdEvento int,
            @IdParameterEnvio int,
            @Orden int,
            @IdAgrupadorNivelPadre int
            
            AS  
BEGIN   
SET NOCOUNT ON;  
BEGIN  TRANSACTION  
  
 DECLARE @CONTADOR INT  
 IF(@Accion = 'INSERT')  
 BEGIN   
 		select @CONTADOR= isnull(MAX(SecuenciaCampo),0)+1 from SS_HC_FormatoCampo 
		
		set @SecuenciaCampo= @CONTADOR
		
  INSERT INTO SS_HC_FormatoCampo  
  (  
				IdFormato,
				SecuenciaCampo,
				IdFavoritoTabla,
				IdCampo,
				IdSeccionFormato,
				TipoCampo,
				ValorPorDefecto,
				IndicadorObligatorio,
				IndicadorCampoCalculado,
				Formula,
				IndicadorValoresVarios,
				TablaValoresVarios,
				IndicadorRango,
				RangoDesde,
				RangoHasta,
				IndicadorReglaNegocio,
				ReglaNegocio,
				Observaciones,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version,
				DescripcionLocal,
				DescripcionExtranjera,
				IdConcepto,
				IdAgrupadorNivel,
				IdObjetoAgrupador,
				IdColumna,
				IdFila,
				IdEvento,
				IdParameterEnvio,
				Orden,
				IdAgrupadorNivelPadre  
  )  
    VALUES  
  (  
				@IdFormato,
				@SecuenciaCampo,
				@IdFavoritoTabla,
				@IdCampo,
				@IdSeccionFormato,
				@TipoCampo,
				@ValorPorDefecto,
				@IndicadorObligatorio,
				@IndicadorCampoCalculado,
				@Formula,
				@IndicadorValoresVarios,
				@TablaValoresVarios,
				@IndicadorRango,
				@RangoDesde,
				@RangoHasta,
				@IndicadorReglaNegocio,
				@ReglaNegocio,
				@Observaciones,
				@Estado,
				@UsuarioCreacion,
				GETDATE(),
				@UsuarioModificacion,
				GETDATE(),
				@Accion,
				@Version,
				@DescripcionLocal,
				@DescripcionExtranjera,
				@IdConcepto,
				@IdAgrupadorNivel,
				@IdObjetoAgrupador,
				@IdColumna,
				@IdFila,
				@IdEvento,
				@IdParameterEnvio,
				@Orden,
				@IdAgrupadorNivelPadre  
  )  
  
		SELECT 1		 
	 END   
	 ELSE  
	 IF(@Accion = 'UPDATE')  
	 BEGIN  
		 UPDATE SS_HC_FormatoCampo  
		  SET      
				IdCampo=@IdCampo,
				IdSeccionFormato=@IdSeccionFormato,
				TipoCampo=@TipoCampo,
				ValorPorDefecto=@ValorPorDefecto,
				IndicadorObligatorio=@IndicadorObligatorio,
				IndicadorCampoCalculado=@IndicadorCampoCalculado,
				Formula=@Formula,
				IndicadorValoresVarios=@IndicadorValoresVarios,
				TablaValoresVarios=@TablaValoresVarios,
				IndicadorRango=@IndicadorRango,
				RangoDesde=@RangoDesde,
				RangoHasta=@RangoHasta,
				IndicadorReglaNegocio=@IndicadorReglaNegocio,
				ReglaNegocio=@ReglaNegocio,
				Observaciones=@Observaciones,
				Estado=@Estado,
				UsuarioModificacion=@UsuarioModificacion,
				FechaModificacion=GETDATE(),
				Accion=@Accion,
				Version=@Version,
				DescripcionLocal=@DescripcionLocal,
				DescripcionExtranjera=@DescripcionExtranjera,
				IdConcepto=@IdConcepto,
				IdAgrupadorNivel=@IdAgrupadorNivel,
				IdObjetoAgrupador=@IdObjetoAgrupador,
				IdColumna=@IdColumna,
				IdFila=@IdFila,
				IdEvento=@IdEvento,
				IdParameterEnvio=@IdParameterEnvio,
				Orden=@Orden,
				IdAgrupadorNivelPadre=@IdAgrupadorNivelPadre  
		WHERE 
		(IdFormato = @IdFormato) 
		and (SecuenciaCampo = @SecuenciaCampo) 
   		select 1
 end   
 else  
 if(@Accion = 'DELETE')  
 begin  
  delete SS_HC_FormatoCampo  
		WHERE 
		(IdFormato = @IdFormato) 
		and (SecuenciaCampo = @SecuenciaCampo) 
   		select 1
end
		if(@Accion = 'CONTARLISTAPAG')
	begin		
		
   
  SET @CONTADOR=(SELECT COUNT(SecuenciaCampo) FROM SS_HC_FormatoCampo  
       WHERE   
			(@IdFormato is null OR (IdFormato = @IdFormato) or @IdFormato =0)  
	 and (@ValorPorDefecto is null  OR @ValorPorDefecto =''  OR  upper(ValorPorDefecto) like '%'+upper(@ValorPorDefecto)+'%')
     and (@SecuenciaCampo is null OR (SecuenciaCampo = @SecuenciaCampo) or @SecuenciaCampo =0)       
     and (@Estado is null OR Estado = @Estado) 
     )  
					
		select @CONTADOR
	end
commit	 
END  
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_FormatoCodigoId]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_FormatoCodigoId]
(
	@IdOpcion	int ,	
	@CampoCodigoId	int ,
	@SecuenciaAsignacion	int ,	
	@IndicadorCodigoId	int ,
	@ValorTexto	varchar(25) ,	
	@ValorId	int ,				
	@Version	varchar(25) ,		
	@UsuarioCreacion	varchar(25) ,		
	@FechaCreacion	datetime,		
	@UsuarioModificacion	varchar(25) ,		
	@FechaModificacion	datetime,		
	@ACCION	varchar(25) 				
)

AS
BEGIN 
begin transaction  
SET NOCOUNT ON;  

	DECLARE @contador int =0
	if(@ACCION = 'INSERT')
	begin		
		
		select @contador = isnull(MAX(SecuenciaAsignacion),0)+1 from SS_HC_FormatoCodigoId
		where IdOpcion = @IdOpcion
		
		set @SecuenciaAsignacion = @contador
		
		INSERT INTO SS_HC_FormatoCodigoId
		(
			IdOpcion
			,CampoCodigoId
			,SecuenciaAsignacion
			,IndicadorCodigoId
			,ValorTexto
			,ValorId
			,Accion			
			,Version
			,UsuarioCreacion
			,FechaCreacion
			
		)
		VALUES
		(
				@IdOpcion
			,	@CampoCodigoId
			,	@SecuenciaAsignacion
			,	@IndicadorCodigoId
			,	@ValorTexto
			,	@ValorId
			,	@Accion
			,	@Version				
			,	@UsuarioCreacion
			,	GETDATE()			
		)
		
		select @IdOpcion
	end
	else
	if(@ACCION = 'UPDATE')
	begin	
			update SS_HC_FormatoCodigoId
			set											
				IndicadorCodigoId	=	@IndicadorCodigoId
				,ValorTexto	=	@ValorTexto
				,ValorId	=	@ValorId
				,Accion	=	@Accion
				,Version	=	@Version
				,UsuarioModificacion	=	@UsuarioModificacion
				,FechaModificacion	=	GETDATE()
	 		WHERE 					
			(IdOpcion = @IdOpcion )
			and (CampoCodigoId = @CampoCodigoId )
			and (SecuenciaAsignacion = @SecuenciaAsignacion )

		select @IdOpcion
	end
	else
	if(@ACCION = 'DELETE')
	begin	
			delete SS_HC_FormatoCodigoId
	 		WHERE 					
			(IdOpcion = @IdOpcion )
			and (CampoCodigoId = @CampoCodigoId )
			and (SecuenciaAsignacion = @SecuenciaAsignacion )


		select @IdOpcion
	end	
commit
END  
/*
exec  [dbo].[SP_SS_HC_FormatoCodigoId]
	3004,
	4,
	null,
	2,	
	'00000001',
	1,
	NULL,
	'INSERT'	
			
)*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_FormatoCodigoId_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_FormatoCodigoId_LISTAR]
(
	@IdOpcion	int ,	
	@CampoCodigoId	int ,
	@SecuenciaAsignacion	int,
	@IndicadorCodigoId	int ,
	@ValorTexto	varchar(25) ,	
	@ValorId	int ,		
	@Version	varchar(25) ,		
	@Inicio	int ,	
	@NumeroFilas	int ,	
	@ACCION	varchar(25) 			
)

AS
BEGIN
	if(@ACCION = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR=(
		SELECT COUNT(CampoCodigoId) 
				from 
				SS_HC_FormatoCodigoId
	 					WHERE 
					(@CampoCodigoId is null OR (CampoCodigoId = @CampoCodigoId) or @CampoCodigoId =0)
					and (@SecuenciaAsignacion is null OR SecuenciaAsignacion = @SecuenciaAsignacion or @SecuenciaAsignacion =0)
					)
	 
		SELECT 
			IdOpcion
			,CampoCodigoId
			,IndicadorCodigoId
			,SecuenciaAsignacion
			,ValorTexto
			,ValorId
			,Accion
			,Version				
			,UsuarioCreacion
			,FechaCreacion
			,UsuarioModificacion
			,FechaModificacion			
		FROM (
				SELECT 
					SS_HC_FormatoCodigoId.*
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY IdOpcion ASC ) AS RowNumber   					
				from 
				SS_HC_FormatoCodigoId
	 					WHERE 
					(@CampoCodigoId is null OR (CampoCodigoId = @CampoCodigoId) or @CampoCodigoId =0)
					and (@IdOpcion is null OR IdOpcion = @IdOpcion or @IdOpcion =0)
					and (@SecuenciaAsignacion is null OR SecuenciaAsignacion = @SecuenciaAsignacion or @SecuenciaAsignacion =0)					
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
	end
	else
	if(@ACCION = 'LISTAR')
	begin

			SELECT 
			ASIG_FORMATO.IdOpcion
			,ASIG_FORMATO.CampoCodigoId
			,ASIG_FORMATO.SecuenciaAsignacion
			,ASIG_FORMATO.IndicadorCodigoId
			,ASIG_FORMATO.ValorTexto
			,ASIG_FORMATO.ValorId
			,ASIG_FORMATO.Accion
			,campoAsig.DescripcionLocal as  Version			
			,DESC_SELECCION.Nombre as UsuarioCreacion
			,ASIG_FORMATO.FechaCreacion
			,ASIG_FORMATO.UsuarioModificacion
			,ASIG_FORMATO.FechaModificacion					
				from 
				SS_HC_FormatoCodigoId as ASIG_FORMATO				
				left join MA_MiscelaneosDetalle campoAsig on
					( 
						campoAsig.AplicacionCodigo= 'WA' 
						and campoAsig.CodigoTabla= 'FORMCAMPOA' 
						and campoAsig.Compania= '999999' 
						and ltrim(campoAsig.CodigoElemento)= CONVERT(varchar,ASIG_FORMATO.CampoCodigoId)
					)
				left join 	
				(
					select SSS.* from 
					(
						select 1 as INDICATABLA, companyowner as Codigo,description as Nombre, 0 as ID ,'TABLA_COMPANIA' as TIPO from						
						companyowner
						where rtrim(companyowner) in (select rtrim(AUX.valortexto) from SS_HC_FormatoCodigoId as AUX 
							where (@IdOpcion is null OR AUX.IdOpcion = @IdOpcion or @IdOpcion =0)
							)
						union
						select 2 as INDICATABLA ,Codigo,Nombre, IdEstablecimiento as ID ,'TABLA_ESTABLEC' as TIPO from						
						CM_CO_Establecimiento
						where IdEstablecimiento in (select ValorId from SS_HC_FormatoCodigoId as AUX 
							where (@IdOpcion is null OR AUX.IdOpcion = @IdOpcion or @IdOpcion =0)
							)
						
						union
						select  4 as INDICATABLA ,Codigo,Nombre, IdEspecialidad  as ID  ,'TABLA_ESPECIALIDAD' as TIPO from						
						SS_GE_Especialidad
						where IdEspecialidad in (select ValorId from SS_HC_FormatoCodigoId as AUX 
							where (@IdOpcion is null OR AUX.IdOpcion = @IdOpcion or @IdOpcion =0)
							)
						
						union
						select  8 as INDICATABLA ,CodigoAgente,Nombre, IdAgente as ID ,'TABLA_AGENTE' as TIPO from						
						SG_Agente
						where IdAgente in (select ValorId from SS_HC_FormatoCodigoId as AUX 
							where (@IdOpcion is null OR AUX.IdOpcion = @IdOpcion or @IdOpcion =0)
							)
						
						union
						select  9 as INDICATABLA ,CodigoFormato,Descripcion as Nombre, IdFormato as ID ,'TABLA_FORMATO' as TIPO from						
						SS_HC_Formato							
						where IdFormato in (select ValorId from SS_HC_FormatoCodigoId as AUX 
							where (@IdOpcion is null OR AUX.IdOpcion = @IdOpcion or @IdOpcion =0)
							)
						
					)AS SSS						
				)DESC_SELECCION on (DESC_SELECCION.INDICATABLA =ASIG_FORMATO.CampoCodigoId
						and (DESC_SELECCION.Codigo = ASIG_FORMATO.ValorTexto
							OR DESC_SELECCION.ID = ASIG_FORMATO.ValorId
							)
						)
					
	 				WHERE 
					(@CampoCodigoId is null OR (CampoCodigoId = @CampoCodigoId) or @CampoCodigoId =0)
					and (@IdOpcion is null OR IdOpcion = @IdOpcion or @IdOpcion =0)
					and (@SecuenciaAsignacion is null OR SecuenciaAsignacion = @SecuenciaAsignacion or @SecuenciaAsignacion =0)
	end	

END
/*
exec SP_SS_HC_FormatoCodigoId_LISTAR

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
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_FormatoListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_FormatoListar]         
@IdFormato             INT,         
@IdFormatoPadre        INT,         
@CodigoFormato         VARCHAR(20),         
@CodigoFormatoPadre    VARCHAR(20),         
@CadenaRecursividad    VARCHAR(150),                
@Nivel                 INT,         
@Descripcion           VARCHAR(100),         
@DescripcionExtranjera VARCHAR(100),         
@TipoFormato           INT,         
@VersionFormatoFijo    VARCHAR(50),                 
@IdFormatoDinamico     INT,         
@Estado                INT,         
@UsuarioCreacion       VARCHAR(25),         
@FechaCreacion         DATETIME,         
@UsuarioModificacion   VARCHAR(25),                 
@FechaModificacion     DATETIME,         
@Modulo varchar(2),        
@Accion                VARCHAR( 25),         
@Version               VARCHAR( 25),         
@INICIO                INT,         
@NUMEROFILAS           INT         
AS         
  BEGIN         
      SET nocount ON;         
        
      DECLARE @CONTADOR INT         
        
      IF @Accion = 'LISTAR'         
        BEGIN         
            SELECT ss_hc_formato.idformato,         
                   ss_hc_formato.idformatopadre,         
                   ss_hc_formato.codigoformato,         
                   ss_hc_formato.codigoformatopadre,         
                   ss_hc_formato.cadenarecursividad,         
                   ss_hc_formato.nivel,         
                   ss_hc_formato.descripcion,         
                   ss_hc_formato.descripcionextranjera,         
                   ss_hc_formato.tipoformato,         
                   ss_hc_formato.versionformatofijo,         
                   ss_hc_formato.idformatodinamico,         
                   ss_hc_formato.estado,         
                   ss_hc_formato.usuariocreacion,         
                   ss_hc_formato.fechacreacion,         
                   ss_hc_formato.usuariomodificacion,         
                   ss_hc_formato.fechamodificacion,         
                   ss_hc_formato.Modulo,         
                   ss_hc_formato.accion,         
                   ss_hc_formato.version  
                   ,ss_hc_formato.IndCompartido       
                           
            FROM   ss_hc_formato         
                             WHERE  ( @Descripcion IS NULL OR Upper(ss_hc_formato.descripcion) LIKE '%' + Upper(@Descripcion) + '%' )     
        AND ( @IdFormato IS NULL OR ss_hc_formato.IdFormato = @IdFormato OR @IdFormato = 0 )    
                                AND ( @Estado IS NULL OR ss_hc_formato.estado = @Estado OR @Estado=0 )     
                                AND ( @CodigoFormatoPadre IS NULL OR Upper(ss_hc_formato.CodigoFormatoPadre) LIKE '%' + Upper(@CodigoFormatoPadre) + '%' )     
                                AND ( @TipoFormato IS NULL OR ss_hc_formato.TipoFormato = @TipoFormato OR @TipoFormato = 0 )    
                                AND ( @Modulo IS NULL OR Upper(ss_hc_formato.Modulo) LIKE '%' + Upper(@Modulo) + '%' )      
                                AND ( @CodigoFormato is null OR (CodigoFormato = @CodigoFormato))        
        END         
      ELSE IF( @ACCION = 'LISTARPAG' )         
        BEGIN         
            SET @CONTADOR = (SELECT Count(*)         
                             FROM   ss_hc_formato         
                             WHERE  ( @Descripcion IS NULL OR Upper(ss_hc_formato.descripcion) LIKE '%' + Upper(@Descripcion) + '%' )         
                                AND ( ss_hc_formato.idformato = @IdFormato OR @IdFormato IS NULL OR @IdFormato = 0 )         
                                AND ( @Estado IS NULL OR ss_hc_formato.estado = @Estado OR @Estado=0 )         
                                AND ( @CodigoFormatoPadre IS NULL OR Upper(ss_hc_formato.CodigoFormatoPadre) LIKE '%' + Upper(@CodigoFormatoPadre) + '%' )       
                                AND ( @Modulo IS NULL OR Upper(ss_hc_formato.Modulo) LIKE '%' + Upper(@Modulo) + '%' )      
                                AND ( @CodigoFormato is null OR (UPPER(CodigoFormato) LIKE '%'+@CodigoFormato+'%'))      
                                AND ( @TipoFormato IS NULL OR ss_hc_formato.TipoFormato = @TipoFormato OR @TipoFormato = 0 ) )        
                                             
        
            SELECT idformato,         
                   idformatopadre,         
                   codigoformato,         
                   codigoformatopadre,         
                   cadenarecursividad,         
                   nivel,         
                   descripcion,         
                   descripcionextranjera,         
                   tipoformato,         
                   versionformatofijo,         
                   idformatodinamico,         
                   estado,         
                   usuariocreacion,         
                   fechacreacion,         
                   usuariomodificacion,         
                   fechamodificacion,         
                   Modulo,         
                   accion,         
                   version      
                   ,IndCompartido          
            FROM   (SELECT ss_hc_formato.idformato,         
                           ss_hc_formato.idformatopadre,         
                           ss_hc_formato.codigoformato,         
                           ss_hc_formato.codigoformatopadre,         
                           ss_hc_formato.cadenarecursividad,         
                           ss_hc_formato.nivel,         
                           ss_hc_formato.descripcion,         
                           ss_hc_formato.descripcionextranjera,         
                           ss_hc_formato.tipoformato,         
                           ss_hc_formato.versionformatofijo,         
                           ss_hc_formato.idformatodinamico,         
                           ss_hc_formato.estado,         
                           ss_hc_formato.usuariocreacion,         
                           ss_hc_formato.fechacreacion,         
                           ss_hc_formato.usuariomodificacion,         
                           ss_hc_formato.fechamodificacion,         
                           (select nombre from SG_Modulo where SG_Modulo.Modulo = ss_hc_formato.Modulo) as Modulo,--ss_hc_formato.Modulo,         
                           ss_hc_formato.accion,         
                           ss_hc_formato.version,    
                           ss_hc_formato.IndCompartido            ,
                           @CONTADOR AS Contador,         
                           Row_number() OVER (ORDER BY ss_hc_formato.idformato ASC ) AS RowNumber         
                    FROM   ss_hc_formato         
                             WHERE  ( @Descripcion IS NULL OR Upper(ss_hc_formato.descripcion) LIKE '%' + Upper(@Descripcion) + '%' )         
                                AND ( ss_hc_formato.idformato = @IdFormato OR @IdFormato IS NULL OR @IdFormato = 0 )         
                                AND ( @Estado IS NULL OR ss_hc_formato.estado = @Estado OR @Estado=0 )         
                                AND ( @CodigoFormatoPadre IS NULL OR Upper(ss_hc_formato.CodigoFormatoPadre) LIKE '%' + Upper(@CodigoFormatoPadre) + '%' )         
                                AND ( @TipoFormato IS NULL OR ss_hc_formato.TipoFormato = @TipoFormato OR @TipoFormato = 0 )     
                                AND ( @CodigoFormato is null OR (UPPER(CodigoFormato) LIKE '%'+@CodigoFormato+'%'))   
                                AND ( @Modulo IS NULL OR Upper(ss_hc_formato.Modulo) LIKE '%' + Upper(@Modulo) + '%' )  )    
                   AS LISTADO         
            WHERE  ( @Inicio IS NULL AND @NumeroFilas IS NULL ) OR rownumber BETWEEN @Inicio AND @NumeroFilas         
        END         
      ELSE IF( @ACCION = 'LISTARPORID' )         
        BEGIN         
            SET @CONTADOR = (SELECT Count(*)         
                             FROM   ss_hc_formato         
                             WHERE  ( @Descripcion IS NULL OR Upper(ss_hc_formato.descripcion) LIKE '%' + Upper(@Descripcion) + '%' )         
                                    AND ( ss_hc_formato.idformato = @IdFormato OR @IdFormato IS NULL OR @IdFormato = 0 )         
                                    AND ( @Estado IS NULL OR ss_hc_formato.estado = @Estado OR @Estado = 0 )         
                                    AND ( @CodigoFormatoPadre IS NULL OR Upper(ss_hc_formato.codigoformatopadre) LIKE '%' + Upper(@CodigoFormatoPadre) + '%' ) )         
        
            SELECT @CONTADOR;         
        END         
  END         
/*           
EXEC SP_SS_HC_FormatoListar           
0,NULL,NULL,NULL,NULL,          
NULL,NULL,NULL,NULL,NULL,          
NULL,NULL,NULL,NULL,NULL,          
NULL,'LISTARPAG',NULL,0,15          
*/ 
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_FormatoRecursoCampo_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_FormatoRecursoCampo_Listar]
			@IdFormato int,
            @SecuenciaCampo int,
            @IdFavoritoTabla int,
            @NombreCampoRecurso varchar(128),
            @Accion varchar(25),
            @Version varchar(25),
            @Estado int,	
            @UsuarioCreacion varchar(25),
            @FechaCreacion datetime,
            @UsuarioModificacion varchar(25),
            @FechaModificacion datetime,
			@INICIO   int= null,  
			@NUMEROFILAS int = null     
AS    
BEGIN    
if(@ACCION = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR=(SELECT COUNT(*) FROM SS_HC_FormatoRecursoCampo
	 					WHERE 
						(@IdFormato is null OR (IdFormato = @IdFormato) or @IdFormato =0)
					and (@SecuenciaCampo is null OR (SecuenciaCampo = @SecuenciaCampo) or @SecuenciaCampo=0)					
					and (@NombreCampoRecurso is null  OR @NombreCampoRecurso =''  OR  upper(NombreCampoRecurso) like '%'+upper(@NombreCampoRecurso)+'%')							
					and (@Estado is null OR Estado = @Estado) 						
					)
		SELECT
				IdFormato,
				SecuenciaCampo,
				IdFavoritoTabla,
				NombreCampoRecurso,
				Accion,
				Version,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion
		FROM (		
			SELECT
				IdFormato,
				SecuenciaCampo,
				IdFavoritoTabla,
				NombreCampoRecurso,
				Accion,
				Version,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY SecuenciaCampo ASC ) AS RowNumber   	
					FROM SS_HC_FormatoRecursoCampo	
					WHERE 
						(@IdFormato is null OR (IdFormato = @IdFormato) or @IdFormato =0)
					and (@SecuenciaCampo is null OR (SecuenciaCampo = @SecuenciaCampo) or @SecuenciaCampo=0)					
					and (@NombreCampoRecurso is null  OR @NombreCampoRecurso =''  OR  upper(NombreCampoRecurso) like '%'+upper(@NombreCampoRecurso)+'%')							
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
				SecuenciaCampo,
				IdFavoritoTabla,
				NombreCampoRecurso,
				Accion,
				Version,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion
				FROM SS_HC_FormatoRecursoCampo	
									
				WHERE 
						(@IdFormato is null OR (IdFormato = @IdFormato) or @IdFormato =0)
					and (@SecuenciaCampo is null OR (SecuenciaCampo = @SecuenciaCampo) or @SecuenciaCampo=0)					
					and (@NombreCampoRecurso is null  OR @NombreCampoRecurso =''  OR  upper(NombreCampoRecurso) like '%'+upper(@NombreCampoRecurso)+'%')							
					and (@Estado is null OR Estado = @Estado) 	
end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 
					*					
				from 
				SS_HC_FormatoRecursoCampo

					WHERE 
						(IdFormato = @IdFormato)  and  (SecuenciaCampo = @SecuenciaCampo)
	END	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_FormatoRecursoCampo_Mantenimiento]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_FormatoRecursoCampo_Mantenimiento]
			@IdFormato int,
            @SecuenciaCampo int,
            @IdFavoritoTabla int,
            @NombreCampoRecurso varchar(128),
            @Accion varchar(25),
            @Version varchar(25),
            @Estado int,
            @UsuarioCreacion varchar(25),
            @FechaCreacion datetime,
            @UsuarioModificacion varchar(25),
            @FechaModificacion datetime
AS  
BEGIN   
SET NOCOUNT ON;  
BEGIN  TRANSACTION  
  
 DECLARE @CONTADOR INT  
 IF(@Accion = 'INSERT')  
 BEGIN 
 declare @ver int  
 set  @ver= (select MAX(Version) from SS_HC_FormatoRecursoCampo) 
 print @ver
 		select @CONTADOR= isnull(MAX(Version),0)+1 from SS_HC_FormatoRecursoCampo 
		
		set @Version = @CONTADOR
		
  INSERT INTO SS_HC_FormatoRecursoCampo  
  (  
				IdFormato,
				SecuenciaCampo,
				IdFavoritoTabla,
				NombreCampoRecurso,
				Accion,
				Version,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion
  )  
    VALUES  
  (   
				@IdFormato,
				@SecuenciaCampo,
				@IdFavoritoTabla,
				@NombreCampoRecurso,
				@Accion,
				@Version,
				@Estado,
				@UsuarioCreacion,
				GETDATE(),
				@UsuarioModificacion,
				GETDATE()
  )  
  
 SELECT 1		 
 END   
 ELSE  
 IF(@Accion = 'UPDATE')  
 BEGIN  
 UPDATE SS_HC_FormatoRecursoCampo  
  SET  
				IdFormato = @IdFormato,
				SecuenciaCampo = @SecuenciaCampo,
				IdFavoritoTabla = @IdFavoritoTabla,
				NombreCampoRecurso = @NombreCampoRecurso,
				Accion = @Accion,
				Version = @Version,
				Estado = @Estado,
				UsuarioModificacion = @UsuarioModificacion,
				FechaModificacion = GETDATE()
		WHERE 
			(IdFormato = @IdFormato)  
		and (SecuenciaCampo = @SecuenciaCampo)
   		select 1
 end   
 else  
 if(@Accion = 'DELETE')  
 begin  
  delete SS_HC_FormatoRecursoCampo  
		WHERE 
			(IdFormato = @IdFormato)  
		and (SecuenciaCampo = @SecuenciaCampo)
   		select 1
end
		if(@Accion = 'CONTARLISTAPAG')
	begin		
		
		SET @CONTADOR=(SELECT COUNT(*) FROM SS_HC_FormatoRecursoCampo
	 					WHERE 
						(@IdFormato is null OR (IdFormato = @IdFormato) or @IdFormato =0)
					and (@SecuenciaCampo is null OR (SecuenciaCampo = @SecuenciaCampo) or @SecuenciaCampo=0)					
					and (@NombreCampoRecurso is null  OR @NombreCampoRecurso =''  OR  upper(NombreCampoRecurso) like '%'+upper(@NombreCampoRecurso)+'%')							
					and (@Estado is null OR Estado = @Estado) 			
					)
					
		select @CONTADOR
	end
commit	 
END  

--exec SP_SS_HC_FormatoRecursoCampo_Mantenimiento 0,0,null,'p','CONTARLISTAPAG',null,null
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_GE_ClasificadorMovimiento]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_GE_ClasificadorMovimiento] 
@ClasificadorMovimiento VARCHAR(15), 
@ClasificadorMovimientoGrupo VARCHAR(15), 
@Nombre VARCHAR(80), 
@Descripcion VARCHAR(150), 
@Estado INT, 
@UsuarioCreacion VARCHAR(25), 
@FechaCreacion DATETIME, 
@UsuarioModificacion VARCHAR(25), 
@FechaModificacion DATETIME, 
@FlujodeCaja VARCHAR(15), 
@CentroCosto VARCHAR(15), 
@Accion VARCHAR( 25), 
@Version VARCHAR( 25) 
AS 
  BEGIN 
      SET nocount ON; 

      DECLARE @ClasificadorMovimientoId AS INTEGER 

      SET @ClasificadorMovimientoId = @ClasificadorMovimiento; 

      IF @Accion = 'NUEVO' 
        BEGIN 
            INSERT INTO ge_clasificadormovimiento 
                        (clasificadormovimiento, 
                         clasificadormovimientogrupo, 
                         nombre, 
                         descripcion, 
                         estado, 
                         usuariocreacion, 
                         fechacreacion, 
                         usuariomodificacion, 
                         fechamodificacion, 
                         flujodecaja, 
                         centrocosto, 
                         accion, 
                         version) 
            VALUES      (@ClasificadorMovimiento, 
                         @ClasificadorMovimientoGrupo, 
                         @Nombre, 
                         @Descripcion, 
                         @Estado, 
                         @UsuarioCreacion, 
                         @FechaCreacion, 
                         @UsuarioModificacion, 
                         @FechaModificacion, 
                         @FlujodeCaja, 
                         @CentroCosto, 
                         @Accion, 
                         @Version ) 

            SELECT @ClasificadorMovimientoId; 
        END 

      ELSE IF @Accion = 'UPDATE' 
        BEGIN 
            UPDATE ge_clasificadormovimiento 
            SET    clasificadormovimiento = @ClasificadorMovimiento, 
                   clasificadormovimientogrupo = @ClasificadorMovimientoGrupo, 
                   nombre = @Nombre, 
                   descripcion = @Descripcion, 
                   estado = @Estado, 
                   usuariocreacion = @UsuarioCreacion, 
                   fechacreacion = @FechaCreacion, 
                   usuariomodificacion = @UsuarioModificacion, 
                   fechamodificacion = @FechaModificacion, 
                   flujodecaja = @FlujodeCaja, 
                   centrocosto = @CentroCosto, 
                   accion = @Accion, 
                   version = @Version 
            WHERE  ( ge_clasificadormovimiento.clasificadormovimiento = 
                     @ClasificadorMovimiento ) 

            SELECT @ClasificadorMovimientoId; 
        END 

      ELSE IF @Accion = 'DELETE' 
        BEGIN 
            DELETE FROM ge_clasificadormovimiento 
            WHERE  ( ge_clasificadormovimiento.clasificadormovimiento = 
                     @ClasificadorMovimiento ) 

            SELECT @ClasificadorMovimientoId; 
        END 
        
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
        DECLARE @CONTADOR INT 
        SET @CONTADOR = (SELECT Count(*) 
			FROM   ge_clasificadormovimiento 
			WHERE  ( @Nombre IS NULL OR Upper(ge_clasificadormovimiento.nombre) LIKE '%' + Upper(@Nombre) + '%' ))
			SELECT @CONTADOR;              
	END	     
  END 
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_GE_ClasificadorMovimientoListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_GE_ClasificadorMovimientoListar] 
@ClasificadorMovimiento		 VARCHAR(15), 
@ClasificadorMovimientoGrupo VARCHAR(15), 
@Nombre                      VARCHAR(80), 
@Descripcion                 VARCHAR(150), 
@Estado                      INT, 
@UsuarioCreacion             VARCHAR(25), 
@FechaCreacion               DATETIME, 
@UsuarioModificacion         VARCHAR(25), 
@FechaModificacion           DATETIME, 
@FlujodeCaja                 VARCHAR(15), 
@CentroCosto                 VARCHAR(15), 
@INICIO                      INT= NULL, 
@NUMEROFILAS                 INT = NULL, 
@Accion                      VARCHAR( 25), 
@Version                     VARCHAR( 25) 
AS 
BEGIN 
SET nocount ON; 

	IF @Accion = 'LISTAR' 
		BEGIN 
			SELECT ge_clasificadormovimiento.clasificadormovimiento, 
			ge_clasificadormovimiento.clasificadormovimientogrupo, 
			ge_clasificadormovimiento.nombre, 
			ge_clasificadormovimiento.descripcion, 
			ge_clasificadormovimiento.estado, 
			ge_clasificadormovimiento.usuariocreacion, 
			ge_clasificadormovimiento.fechacreacion, 
			ge_clasificadormovimiento.usuariomodificacion, 
			ge_clasificadormovimiento.fechamodificacion, 
			ge_clasificadormovimiento.flujodecaja, 
			ge_clasificadormovimiento.centrocosto, 
			ge_clasificadormovimiento.accion, 
			ge_clasificadormovimiento.version 
			FROM   ge_clasificadormovimiento 
			WHERE  ( @Nombre IS NULL OR Upper(ge_clasificadormovimiento.nombre) LIKE '%' + Upper(@Nombre) + '%' ) 
		END 
	ELSE IF( @ACCION = 'LISTARPAG' ) 
		BEGIN 
			DECLARE @CONTADOR INT 

			SET @CONTADOR = (SELECT Count(*) 
			FROM   ge_clasificadormovimiento 
			WHERE  ( @Nombre IS NULL 
			OR 
			Upper(ge_clasificadormovimiento.nombre) 
			LIKE 
			'%' + Upper(@Nombre) + '%' )) 

			SELECT 
			clasificadormovimiento, 
			clasificadormovimientogrupo, 
			nombre, 
			descripcion, 
			estado, 
			usuariocreacion, 
			fechacreacion, 
			usuariomodificacion, 
			fechamodificacion, 
			flujodecaja, 
			centrocosto, 
			accion, 
			version 
			FROM   (SELECT ge_clasificadormovimiento.clasificadormovimiento, 
			ge_clasificadormovimiento.clasificadormovimientogrupo, 
			ge_clasificadormovimiento.nombre, 
			ge_clasificadormovimiento.descripcion, 
			ge_clasificadormovimiento.estado, 
			ge_clasificadormovimiento.usuariocreacion, 
			ge_clasificadormovimiento.fechacreacion, 
			ge_clasificadormovimiento.usuariomodificacion, 
			ge_clasificadormovimiento.fechamodificacion, 
			ge_clasificadormovimiento.flujodecaja, 
			ge_clasificadormovimiento.centrocosto, 
			ge_clasificadormovimiento.accion, 
			ge_clasificadormovimiento.version, 
			@CONTADOR AS Contador, 
			Row_number() OVER ( ORDER BY ge_clasificadormovimiento.clasificadormovimiento ASC ) AS RowNumber 
			FROM   ge_clasificadormovimiento 
			WHERE  ( @Nombre IS NULL OR Upper(ge_clasificadormovimiento.nombre) LIKE '%' + Upper(@Nombre) + '%' )) AS LISTADO 
			WHERE  ( @Inicio IS NULL AND @NumeroFilas IS NULL ) OR rownumber BETWEEN @Inicio AND @NumeroFilas 
		END 
		

	END 
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_GE_TipoAtencion]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_GE_TipoAtencion] 
@IdTipoAtencion         INT , 
@Codigo                 VARCHAR( 15) , 
@Nombre                 VARCHAR( 80), 
@Descripcion            VARCHAR( 150), 
@Estado                 INT , 

@UsuarioCreacion        VARCHAR( 25) , 
@FechaCreacion          DATETIME , 
@UsuarioModificacion    VARCHAR( 25) , 
@FechaModificacion      DATETIME , 
@ClasificadorMovimiento VARCHAR( 15) , 

@Accion                 VARCHAR( 25) , 
@Version                VARCHAR( 25) 
AS 
  BEGIN 
      SET nocount ON; 

      IF @Accion = 'INSERT' 
        BEGIN 
        select @IdTipoAtencion = ISNULL(max(IdTipoAtencion),0)+1 
				 from dbo.ss_ge_tipoatencion 
				 where  ( ss_ge_tipoatencion.IdTipoAtencion = IdTipoAtencion ) 
				 PRINT @IdTipoAtencion
            INSERT INTO ss_ge_tipoatencion 
                        (idtipoatencion, 
                         codigo, 
                         nombre, 
                         descripcion, 
                         estado, 
                         usuariocreacion, 
                         fechacreacion, 
                         usuariomodificacion, 
                         fechamodificacion, 
                         clasificadormovimiento, 
                         accion, 
                         version) 
            VALUES     (@IdTipoAtencion, 
                        @Codigo, 
                        @Nombre, 
                        @Descripcion, 
                        @Estado, 
                        @UsuarioCreacion, 
                        Getdate(), 
                        @UsuarioModificacion, 
                        Getdate(), 
                        @ClasificadorMovimiento, 
                        @Accion, 
                        @Version ) 
					SELECT 1	
            
        END 
      ELSE IF @Accion = 'UPDATE' 
        BEGIN 
            UPDATE ss_ge_tipoatencion 
            SET    idtipoatencion = @IdTipoAtencion, 
                   codigo = @Codigo, 
                   nombre = @Nombre, 
                   descripcion = @Descripcion, 
                   estado = @Estado, 
                   usuariomodificacion = @UsuarioModificacion, 
                   fechamodificacion = GETDATE(), 
                   clasificadormovimiento = @ClasificadorMovimiento, 
                   accion = @Accion, 
                   version = @Version 
            WHERE  ( ss_ge_tipoatencion.IdTipoAtencion = @IdTipoAtencion ) 
				SELECT 1	
        END 

      ELSE IF @Accion = 'DELETE' 
        BEGIN 
        
			delete dbo.SS_GE_GrupoAtencion
			WHERE  ( SS_GE_GrupoAtencion.IdTipoAtencion = @IdTipoAtencion ) 
			
            DELETE FROM ss_ge_tipoatencion 
            WHERE  ( ss_ge_tipoatencion.IdTipoAtencion = @IdTipoAtencion ) 

            SELECT 1
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   ss_ge_tipoatencion 
                           WHERE 
										( @Descripcion IS NULL OR Upper(ss_ge_tipoatencion.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( ss_ge_tipoatencion.IdTipoAtencion = @IdTipoAtencion OR @IdTipoAtencion IS NULL OR @IdTipoAtencion =0) ) 
			SELECT @CONTADOR;                                     
	END	
	                                    
  END 
  
  /*
  EXEC SP_SS_HC_GE_TipoAtencion
 0,'FF', 'FF', NULL, 0, 
 'MISESF', GETDATE(), NULL, NULL, NULL, 
 'LISTARPAG', NULL
  */
  
/*
  EXEC SP_SS_HC_GE_TipoAtencion
1,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,0,15,
'LISTARPAG',NULL
*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_GE_TipoAtencionListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_GE_TipoAtencionListar] 
@IdTipoAtencion         INT, 
@Codigo                 VARCHAR( 15), 
@Nombre                 VARCHAR( 80), 
@Descripcion            VARCHAR( 150), 
@Estado                 INT, 
@UsuarioCreacion        VARCHAR( 25), 
@FechaCreacion          DATETIME, 
@UsuarioModificacion    VARCHAR( 25), 
@FechaModificacion      DATETIME, 
@ClasificadorMovimiento VARCHAR( 15), 
@INICIO                 INT= NULL , 
@NUMEROFILAS            INT = NULL, 
@Accion                 VARCHAR( 25), 
@Version                VARCHAR( 25) 
AS 
  BEGIN 
      SET nocount ON; 

            DECLARE @CONTADOR INT 
      IF @Accion = 'LISTAR' 
        BEGIN 
            SELECT ss_ge_tipoatencion.idtipoatencion, 
                   ss_ge_tipoatencion.codigo, 
                   ss_ge_tipoatencion.nombre, 
                   ss_ge_tipoatencion.descripcion, 
                   ss_ge_tipoatencion.estado, 
                   ss_ge_tipoatencion.usuariocreacion, 
                   ss_ge_tipoatencion.fechacreacion, 
                   ss_ge_tipoatencion.usuariomodificacion, 
                   ss_ge_tipoatencion.fechamodificacion, 
                   ss_ge_tipoatencion.clasificadormovimiento, 
                   ss_ge_tipoatencion.accion, 
                   ss_ge_tipoatencion.version 
            FROM   ss_ge_tipoatencion 
            WHERE ( @Descripcion IS NULL OR Upper(ss_ge_tipoatencion.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                   AND ( ss_ge_tipoatencion.IdTipoAtencion = @IdTipoAtencion OR @IdTipoAtencion IS NULL OR @IdTipoAtencion =0) 
                   AND ( ss_ge_tipoatencion.Codigo = @Codigo OR @Codigo IS NULL) 
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   ss_ge_tipoatencion 
                           WHERE ( @Descripcion IS NULL OR Upper(ss_ge_tipoatencion.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( ss_ge_tipoatencion.IdTipoAtencion = @IdTipoAtencion OR @IdTipoAtencion IS NULL OR @IdTipoAtencion =0) )     

            SELECT 
            idtipoatencion, 
                           codigo, 
                           nombre, 
                           descripcion, 
                           estado, 
                           usuariocreacion, 
                           fechacreacion, 
                           usuariomodificacion, 
                           fechamodificacion, 
                           clasificadormovimiento, 
                           accion, 
                           version
            FROM   (SELECT ss_ge_tipoatencion.idtipoatencion, 
                           ss_ge_tipoatencion.codigo, 
                           ss_ge_tipoatencion.nombre, 
                           ss_ge_tipoatencion.descripcion, 
                           ss_ge_tipoatencion.estado, 
                           ss_ge_tipoatencion.usuariocreacion, 
                           ss_ge_tipoatencion.fechacreacion, 
                           ss_ge_tipoatencion.usuariomodificacion, 
                           ss_ge_tipoatencion.fechamodificacion, 
                           ss_ge_tipoatencion.clasificadormovimiento, 
                           ss_ge_tipoatencion.accion, 
                           ss_ge_tipoatencion.version, 
                           @CONTADOR AS Contador, 
                           Row_number() OVER (ORDER BY ss_ge_tipoatencion.idtipoatencion ASC ) AS RowNumber 
                    FROM   ss_ge_tipoatencion 
                    WHERE ( @Descripcion IS NULL OR Upper(ss_ge_tipoatencion.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' )
                            AND ( (ss_ge_tipoatencion.IdTipoAtencion = @IdTipoAtencion) OR @IdTipoAtencion IS NULL OR @IdTipoAtencion =0) ) AS LISTADO 
            WHERE  ( @Inicio IS NULL 
                     AND @NumeroFilas IS NULL ) 
                    OR rownumber BETWEEN @Inicio AND @NumeroFilas 
        END 
        ELSE IF( @ACCION = 'LISTARPORID' ) 
        BEGIN 
            SET @CONTADOR = (SELECT Count(*) 
                             FROM   ss_ge_tipoatencion 
                           WHERE ( @Descripcion IS NULL OR Upper(ss_ge_tipoatencion.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( ss_ge_tipoatencion.IdTipoAtencion = @IdTipoAtencion OR @IdTipoAtencion IS NULL OR @IdTipoAtencion =0) ) 
			SELECT @CONTADOR;                                     
	END	
  END 
 
 /* 
  exec SP_SS_HC_GE_TipoAtencionListar 
0,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,NULL,NULL,
0,15,'LISTARPAG',NULL
*/
/*
	EXEC SP_SS_HC_GE_TipoAtencionListar
	2,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,NULL,NULL,
0,15,'LISTAR',NULL

*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_GrupoFamiliar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:    Grace Córdova  
-- Create date: 12/11/2015  
-- =============================================  
CREATE OR ALTER PROCEDURE [SP_SS_HC_GrupoFamiliar] 
@IdPaciente          INT, 
@IdPacienteFamiliar  INT, 
@TipoFamiliar        INT, 
@Estado              INT, 
@UsuarioCreacion     VARCHAR(25), 

@FechaCreacion       DATETIME, 
@UsuarioModificacion VARCHAR(25), 
@FechaModificacion   DATETIME, 
@Accion              VARCHAR(25)
AS 
  BEGIN 
      SET nocount ON; 

      BEGIN TRANSACTION 

      DECLARE @CONTADOR INT=0 

      IF( @ACCION = 'INSERT' ) 
        BEGIN 
            DELETE ss_hc_grupofamiliar 
            WHERE  ( idpaciente = @IdPaciente ) 
                   AND ( idpacientefamiliar = @IdPacienteFamiliar ) 
                   AND ( tipofamiliar = @TipoFamiliar ) 

            INSERT INTO ss_hc_grupofamiliar 
                        (idpaciente, 
                         idpacientefamiliar, 
                         tipofamiliar, 
                         estado, 
                         usuariocreacion, 
                         fechacreacion, 
                         usuariomodificacion, 
                         fechamodificacion, 
                         accion) 
            VALUES     ( @IdPaciente, 
                         @IdPacienteFamiliar, 
                         @TipoFamiliar, 
                         @Estado, 
                         @UsuarioCreacion, 
                         Getdate(), 
                         @UsuarioModificacion, 
                         Getdate(), 
                         @Accion ) 

            SELECT 1 
        END 
      ELSE IF( @ACCION = 'UPDATE' ) 
        BEGIN 
            UPDATE ss_hc_grupofamiliar 
            SET    idpaciente = @IdPaciente, 
                   idpacientefamiliar = @IdPacienteFamiliar, 
                   tipofamiliar = @TipoFamiliar, 
                   estado = @Estado, 
                   usuariomodificacion = @UsuarioModificacion, 
                   fechamodificacion = Getdate(), 
                   accion = @Accion 
            WHERE  ( idpaciente = @IdPaciente ) 
                   AND ( idpacientefamiliar = @IdPacienteFamiliar ) 
                   AND ( tipofamiliar = @TipoFamiliar ) 
            SELECT 1 
        END 
      ELSE IF( @ACCION = 'DELETE' ) 
        BEGIN 
            DELETE ss_hc_grupofamiliar 
            WHERE  ( idpaciente = @IdPaciente ) 
                   AND ( idpacientefamiliar = @IdPacienteFamiliar ) 
                   AND ( tipofamiliar = @TipoFamiliar ) 
            SELECT 1 
        END 
      COMMIT 
  END 
/*   
exec SP_SS_HC_GrupoFamiliar      
 NULL,  NULL,  NULL,  NULL,  NULL,   
 NULL,  NULL,  NULL, 'LISTAR' 
 */ 
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_GrupoFamiliarListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================   
-- Author:    Grace Córdova   
-- Create date: 12/11/2015   
-- =============================================   
CREATE OR ALTER PROCEDURE [SP_SS_HC_GrupoFamiliarListar] 
@IdPaciente          INT, 
@IdPacienteFamiliar  INT, 
@TipoFamiliar        INT, 
@Estado              INT, 
@UsuarioCreacion     VARCHAR(25), 

@FechaCreacion       DATETIME, 
@UsuarioModificacion VARCHAR(25), 
@FechaModificacion   DATETIME, 
@Accion              VARCHAR(25), 
@INICIO              INT= NULL, 

@NUMEROFILAS         INT = NULL 
AS 
  BEGIN 
      SET nocount ON; 
      DECLARE @CONTADOR INT=0 
      IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            SELECT * FROM   ss_hc_grupofamiliar 
        END 
      ELSE IF( @ACCION = 'LISTAR' ) 
        BEGIN 
            SELECT 
            CONVERT(INT, Row_number() OVER ( ORDER BY idpacientefamiliar ASC ))   AS IdPaciente , 
            idpacientefamiliar, 
            tipofamiliar, 
            idpaciente AS Estado , 
            (SELECT descripcion FROM   ge_varios WHERE  Rtrim(tipofamiliar) = Rtrim(secuencial) AND ge_varios.codigotabla = 'TIPOPARENTESCO') AS UsuarioCreacion, 
            fechacreacion, 
            (SELECT nombrecompleto FROM   personamast WHERE  persona = idpacientefamiliar) AS UsuarioModificacion, 
            fechamodificacion, 
            accion 
            FROM   ss_hc_grupofamiliar 
            WHERE  ( @IdPaciente IS NULL OR @IdPaciente = 0 OR idpaciente = @IdPaciente ) 
        END 
  END 
/*    
exec SP_SS_HC_GrupoFamiliarListar      
 NULL,  NULL,  NULL,  NULL,  NULL,    
 NULL,  NULL,  NULL,  'LISTARPAG',  0,     
 0  
 */ 
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_ImpresionHC]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_ImpresionHC]
		@IdImpresion int ,
		@UnidadReplicacion char(4),
		@IdPaciente int,		
		@HostImpresion varchar(25),		
		@UsuarioImpresion varchar(25),
		@FechaImpresion datetime,
		@CodigoHC varchar(250),
		@Accion varchar(25),
		@Secuencial int,
		@IdEpisodioAtencion bigint,
		@IdOpcion int,
		@EpisodioClinico int,
		@EpisodioAtencion bigint,
		@CodigoOpcion varchar(25),
		@IdFormato int,
		@TipoAtencion int,
		@IdUnidadServicio int,
		@IdPersonalSalud int
		
AS  
BEGIN   
SET NOCOUNT ON;  
BEGIN  TRANSACTION  
  
 DECLARE @CONTADOR INT, @IntRetorno int
 --select @IdImpresion= isnull(MAX(IdImpresion),0)+1 from SS_HC_ImpresionHC 

IF(@Accion = 'INSERT')  
 BEGIN  		
 		select @IdImpresion= isnull(MAX(IdImpresion),0)+1 from SS_HC_ImpresionHC 
		
						
					  INSERT INTO SS_HC_ImpresionHC  
					  (  		
									IdImpresion,
									UnidadReplicacion,
									IdPaciente,
									HostImpresion,						
									UsuarioImpresion,
									FechaImpresion,	
									CodigoHC,								
									Accion
					  )  
						VALUES  
					  (   
									
									@IdImpresion,
									@UnidadReplicacion ,
	                            	@IdPaciente ,		
	                            	@HostImpresion ,		
	                              	@UsuarioImpresion ,
	                             	@FechaImpresion ,
									@CodigoHC,
	                             	@Accion
					  )  
					  
			SELECT @IdImpresion
					   
END
 ELSE  
IF(@Accion = 'INSERT_DETALLE')  
 BEGIN  

 select @IdImpresion= isnull(MAX(IdImpresion),0) from SS_HC_ImpresionHC  WHERE IdPaciente=@IdPaciente
					  INSERT INTO SS_HC_ImpresionHC_Detalle  
                     (                       
	                  	IdImpresion,
	                 	--secuencial --es IDENTITY
		                IdPaciente,
	                   	IdEpisodioAtencion,
	                 	IdOpcion,
                   		EpisodioClinico,
                 		EpisodioAtencion,
                		CodigoOpcion,
                		IdFormato,
	                	TipoAtencion,
		                IdUnidadServicio,
		                IdPersonalSalud,
		                HostImpresion,
		                UsuarioImpresion,
		                FechaImpresion,
		                Accion		
                        )  
                        VALUES  
                   (                      
		                @IdImpresion,						
						@IdPaciente,
						@IdEpisodioAtencion,
						@IdOpcion,
						@EpisodioClinico,
						@EpisodioAtencion,
						@CodigoOpcion,
						@IdFormato,
						@TipoAtencion,
						@IdUnidadServicio,
						@IdPersonalSalud,
						@HostImpresion,		
						@UsuarioImpresion,
						@FechaImpresion,
						@Accion 
					)  			  		 		  
  
			SELECT @IdImpresion	
					   
END
 ELSE  
 IF(@Accion = 'INSERT_TOTAL')  
 BEGIN   
		--PRIMERO: INSERTAR EN HEADER:
						
					  INSERT INTO SS_HC_ImpresionHC  
					  (  		
									IdImpresion,
									UnidadReplicacion,
									IdPaciente,
									HostImpresion,						
									UsuarioImpresion,
									FechaImpresion,	
									CodigoHC,								
									Accion
					  )  
						VALUES  
					  (   									
									@IdImpresion,
									@UnidadReplicacion ,
	                            	@IdPaciente ,		
	                            	@HostImpresion ,		
	                              	@UsuarioImpresion ,
	                             	@FechaImpresion ,
									@CodigoHC,
	                             	@Accion
					  )  
					  
			--PRIMERO: LUEGO  INSERTAR EN DETALLE CON EL ID DE HEADER : @IdImpresion:		 
					  INSERT INTO SS_HC_ImpresionHC_Detalle  
                     (  
                     
	                  	IdImpresion,	                 	
		                IdPaciente,
	                   	IdEpisodioAtencion,
	                 	IdOpcion,
                   		EpisodioClinico,
                 		EpisodioAtencion,
                		CodigoOpcion,
                		IdFormato,
	                	TipoAtencion,
		                IdUnidadServicio,
		                IdPersonalSalud,
		                HostImpresion,
		                UsuarioImpresion,
		                FechaImpresion,
		                Accion
		
                        )  
                        VALUES  
                   (   
                   
		                @IdImpresion,
						
						@IdPaciente,
						@IdEpisodioAtencion,
						@IdOpcion,
						@EpisodioClinico,
						@EpisodioAtencion,
						@CodigoOpcion,
						@IdFormato,
						@TipoAtencion,
						@IdUnidadServicio,
						@IdPersonalSalud,
						@HostImpresion,		
						@UsuarioImpresion,
						@FechaImpresion,
						@Accion 
  )  		  		 		  
  
			SELECT @IdImpresion		 
 END   
 ELSE  
 IF(@Accion = 'UPDATE')  
 BEGIN  
 UPDATE SS_HC_ImpresionHC  
  SET      
				                     UnidadReplicacion = @UnidadReplicacion,
									IdPaciente = @IdPaciente,
									HostImpresion = @HostImpresion,						
									UsuarioImpresion = @UsuarioImpresion,
									FechaImpresion = @FechaImpresion,	
									CodigoHC = @CodigoHC,								
									Accion=@Accion
		WHERE 
		(IdImpresion = @IdImpresion)  
   		select 1
 end   
ELSE
 if(@Accion = 'DELETE')  
 begin  
  delete SS_HC_ImpresionHC  
		WHERE 
		(IdImpresion = @IdImpresion)   
   		select 1
end
ELSE
if(@Accion = 'CONTARLISTAPAG')
begin		
		
		SET @CONTADOR=(SELECT COUNT(IdImpresion) FROM SS_HC_ImpresionHC	 				
     WHERE   
        (@IdImpresion is null OR (IdImpresion = @IdImpresion) or @IdImpresion =0)  
    and (@HostImpresion is null  OR @HostImpresion =''  OR  upper(HostImpresion) like '%'+upper(@HostImpresion)+'%')   
    and (@IdPaciente is null  OR @IdPaciente =''  OR  upper(IdPaciente) like '%'+upper(@IdPaciente)+'%')     
    and (@UsuarioImpresion is null  OR @UsuarioImpresion =''  OR  upper(UsuarioImpresion) like '%'+upper(@UsuarioImpresion)+'%')    
    and (@FechaImpresion is null or FechaImpresion >= @FechaImpresion )
	and (@CodigoHC is null OR @CodigoHC='' or  upper(CodigoHC) like '%'+upper(@CodigoHC)+'%')
				
					)
					
	select @CONTADOR
end
commit	 
END  
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_ImpresionHC_Detalle]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_ImpresionHC_Detalle]    

		@IdImpresion int ,
		@Secuencial int,
		@IdPaciente int,
		@IdEpisodioAtencion bigint,
		@IdOpcion int,
		@EpisodioClinico int,
		@EpisodioAtencion bigint,
		@CodigoOpcion varchar(25),
		@IdFormato int,
		@TipoAtencion int,
		@IdUnidadServicio int,
		@IdPersonalSalud int,
		@HostImpresion varchar(25),		
		@UsuarioImpresion varchar(25),
		@FechaImpresion datetime,
		@Accion varchar(25)		
     
AS    
BEGIN    
SET NOCOUNT ON;  
BEGIN  TRANSACTION  
  
 DECLARE @CONTADOR INT  
 IF(@Accion = 'INSERT')  
 BEGIN   
		
  INSERT INTO SS_HC_ImpresionHC_Detalle  
  (  
		IdImpresion,
		Secuencial,
		IdPaciente,
		IdEpisodioAtencion,
		IdOpcion,
		EpisodioClinico,
		EpisodioAtencion,
		CodigoOpcion,
		IdFormato,
		TipoAtencion,
		IdUnidadServicio,
		IdPersonalSalud,
		HostImpresion,
		UsuarioImpresion,
		FechaImpresion,
		Accion
		
  )  
    VALUES  
  (   
		@IdImpresion,
		@Secuencial,
		@IdPaciente,
		@IdEpisodioAtencion,
		@IdOpcion,
		@EpisodioClinico,
		@EpisodioAtencion,
		@CodigoOpcion,
		@IdFormato,
		@TipoAtencion,
		@IdUnidadServicio,
		@IdPersonalSalud,
		@HostImpresion,		
		@UsuarioImpresion,
		@FechaImpresion,
		@Accion 
  )  
  
 SELECT 1		 
 END   
 ELSE  
 IF(@Accion = 'UPDATE')  
 BEGIN  
 UPDATE SS_HC_ImpresionHC_Detalle  
  SET      
		IdImpresion = @IdImpresion,
		--Secuencial = @Secuencial,
		IdPaciente = @IdPaciente,
		IdEpisodioAtencion = @IdEpisodioAtencion,
		IdOpcion = @IdOpcion,
		EpisodioClinico = @EpisodioClinico,
		EpisodioAtencion = @EpisodioAtencion,
		CodigoOpcion = @CodigoOpcion,
		IdFormato = @IdFormato,
		TipoAtencion = @TipoAtencion,
		IdUnidadServicio = @IdUnidadServicio,
		IdPersonalSalud = @IdPersonalSalud,
		HostImpresion = @HostImpresion,
		UsuarioImpresion = @UsuarioImpresion,
		FechaImpresion = @FechaImpresion,
		Accion = @Accion
		WHERE 
		(IdImpresion = @IdImpresion)  
		and (IdPaciente = @IdPaciente) and Secuencial = @Secuencial
   		select 1
 end   
 else  
 if(@Accion = 'DELETE')  
 begin  
  delete SS_HC_ImpresionHC_Detalle  
		WHERE 
		(IdImpresion = @IdImpresion)  
		and (IdPaciente = @IdPaciente) 
   		select 1
end
		if(@Accion = 'CONTARLISTAPAG')
	begin		
		
	SET @CONTADOR=(SELECT COUNT(*)       
     FROM SS_HC_ImpresionHC_Detalle      
     WHERE           
	(IdImpresion = @IdImpresion)  
		and (IdPaciente = @IdPaciente)      
     )  
					
		select @CONTADOR
	end
commit	 
END  

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_ImpresionHC_Detalle_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER PROCEDURE [SP_SS_HC_ImpresionHC_Detalle_LISTAR]    
        @IdImpresion int ,
		@Secuencial int,
		@IdPaciente int,
		@IdEpisodioAtencion bigint,
		@IdOpcion int,
		@EpisodioClinico int,
		@EpisodioAtencion bigint,
		@CodigoOpcion varchar(25),
		@IdFormato int,
		@TipoAtencion int,
		@IdUnidadServicio int,
		@IdPersonalSalud int,
		@HostImpresion varchar(25),		
		@UsuarioImpresion varchar(25),
		@FechaImpresion datetime,
		@Accion varchar(25),
              
   @INICIO   int= null,    
   @NUMEROFILAS int = null      
AS      
BEGIN      
if(@Accion = 'LISTARPAG')  
 begin  
   DECLARE @CONTADOR INT  
  SET @CONTADOR=(SELECT COUNT(IdImpresion) FROM vw_Imprimir_HC_DETALLE_GRILLA  
      
     WHERE   
     (@IdImpresion is null OR (IdImpresion = @IdImpresion) or @IdImpresion =0)  
    and (@HostImpresion is null  OR @HostImpresion =''  OR  upper(HostImpresion) like '%'+upper(@HostImpresion)+'%')   
    and (@IdOpcion is null  OR @IdOpcion =''  OR  upper(IdOpcion) like '%'+upper(@IdOpcion)+'%')  
    and (@CodigoOpcion is null  OR @CodigoOpcion =''  OR  upper(CodigoOpcion) like '%'+upper(@CodigoOpcion)+'%')   
    and (@UsuarioImpresion is null  OR @UsuarioImpresion =''  OR  upper(UsuarioImpresion) like '%'+upper(@UsuarioImpresion)+'%')   
    and (@FechaImpresion is null or FechaImpresion >= @FechaImpresion )
      
     )  
  SELECT  
    IdImpresion  ,
		Secuencial ,
		IdPaciente ,
		IdEpisodioAtencion ,
		IdOpcion ,
		EpisodioClinico ,
		EpisodioAtencion ,
		CodigoOpcion ,
		IdFormato ,
		TipoAtencion ,
		IdUnidadServicio ,
		IdPersonalSalud ,
		HostImpresion ,		
		UsuarioImpresion ,
		FechaImpresion ,
		 Accion  
  FROM (    
   SELECT  
    IdImpresion  ,
		Secuencial ,
		IdPaciente ,
		IdEpisodioAtencion ,
		IdOpcion ,
		EpisodioClinico ,
		EpisodioAtencion ,
		CodigoOpcion ,
		IdFormato ,
		TipoAtencion ,
		@CONTADOR AS IdUnidadServicio ,
		IdPersonalSalud ,
		HostImpresion ,		
		UsuarioImpresion ,
		FechaImpresion ,
		 Accion 
      
     ,@CONTADOR AS Contador_filas  
     ,ROW_NUMBER() OVER (ORDER BY IdImpresion ASC ) AS RowNumber      
     FROM vw_Imprimir_HC_DETALLE_GRILLA   
     WHERE   
     (@IdImpresion is null OR (IdImpresion = @IdImpresion) or @IdImpresion =0)  
    and (@HostImpresion is null  OR @HostImpresion =''  OR  upper(HostImpresion) like '%'+upper(@HostImpresion)+'%')   
    and (@IdOpcion is null  OR @IdOpcion =''  OR  upper(IdOpcion) like '%'+upper(@IdOpcion)+'%')  
    and (@CodigoOpcion is null  OR @CodigoOpcion =''  OR  upper(CodigoOpcion) like '%'+upper(@CodigoOpcion)+'%')   
    and (@UsuarioImpresion is null  OR @UsuarioImpresion =''  OR  upper(UsuarioImpresion) like '%'+upper(@UsuarioImpresion)+'%')   
    and (@FechaImpresion is null or FechaImpresion >= @FechaImpresion )
   
   ) AS LISTADO  
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR    
            RowNumber BETWEEN @Inicio  AND @NumeroFilas   
    
       END  
       ELSE  
  IF @Accion ='LISTAR'      
    BEGIN      
  SELECT  
      IdImpresion  ,
		Secuencial ,
		IdPaciente ,
		IdEpisodioAtencion ,
		IdOpcion ,
		EpisodioClinico ,
		EpisodioAtencion ,
		CodigoOpcion ,
		IdFormato ,
		TipoAtencion ,
		IdUnidadServicio ,
		IdPersonalSalud ,
		HostImpresion ,		
		UsuarioImpresion ,
		FechaImpresion ,
		Accion 
    FROM SS_HC_ImpresionHC_Detalle   
     WHERE   
     (@IdImpresion is null OR (IdImpresion = @IdImpresion) or @IdImpresion =0)  
    and (@HostImpresion is null  OR @HostImpresion =''  OR  upper(HostImpresion) like '%'+upper(@HostImpresion)+'%')   
    and (@IdOpcion is null  OR @IdOpcion =''  OR  upper(IdOpcion) like '%'+upper(@IdOpcion)+'%')  
    and (@CodigoOpcion is null  OR @CodigoOpcion =''  OR  upper(CodigoOpcion) like '%'+upper(@CodigoOpcion)+'%')   
    and (@UsuarioImpresion is null  OR @UsuarioImpresion =''  OR  upper(UsuarioImpresion) like '%'+upper(@UsuarioImpresion)+'%')   
    and (@FechaImpresion is null or FechaImpresion >= @FechaImpresion )
   
end   
 else  
 if(@ACCION = 'LISTARPORID')  
 begin    
    SELECT        *           from       SS_HC_ImpresionHC_Detalle    
     WHERE   
     (@IdImpresion = IdImpresion)   
  
 end   
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_ImpresionHC_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_ImpresionHC_LISTAR]    
(       
		@IdImpresion int,
		@UnidadReplicacion char(4),
		@IdPaciente int,		
		@HostImpresion varchar(25),		
		@UsuarioImpresion varchar(25),		
		@FechaImpresion datetime,
		@CodigoHC varchar(250),
		@Accion varchar(25),
		@Version  varchar(25) ,
        @Descripcion datetime,      
        @INICIO   int= null,    
        @NUMEROFILAS int = null,
		@Contador_filas int               
)    
    
AS    
BEGIN    
 DECLARE @CONTADOR INT    
 DECLARE @CONTAR INT   

  IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            SET @CONTADOR = (SELECT Count(*) 
                             FROM   vw_Imprimir_HC_GRILLA AS SS_HC_Imprimir 
                             
                  WHERE (@IdImpresion is null OR (IdImpresion = @IdImpresion) or @IdImpresion =0)  
                            and (@HostImpresion is null  OR @HostImpresion =''  OR  upper(HostImpresion) like '%'+upper(@HostImpresion)+'%')                              
                            and (@UsuarioImpresion is null  OR @UsuarioImpresion =''  OR  upper(UsuarioImpresion) like '%'+upper(@UsuarioImpresion)+'%')    
                           and  (@Version is null  OR @Version =''  OR  upper(SS_HC_Imprimir.NombreCompleto) like '%'+upper(@Version)+'%')  
						    AND ((@FechaImpresion is null or  FechaImpresion >= @FechaImpresion)    
                        	and (@Descripcion is null or  FechaImpresion < DATEADD(DAY,1,@Descripcion)))
						   and  (@CodigoHC is null OR @CodigoHC='' OR upper(CodigoHC) like '%'+upper(@CodigoHC)+'%') 
						   and  (@UnidadReplicacion is null OR @UnidadReplicacion='' OR upper(UnidadReplicacion) like '%'+upper(@UnidadReplicacion)+'%')
							  )
							                
            SELECT IdImpresion,
			       UnidadReplicacion,        
                   IdPaciente,  
				   HostImpresion,   
				   UsuarioImpresion,   
				   FechaImpresion ,
				   NombreCompleto as Version,              
                   Accion,
				   CodigoHC,
				   descripcion ,
				   Contador_filas                                                            
                  
            FROM  
			
			(  SELECT  SS_HC_Imprimir.*,			 
                           @CONTADOR   AS  Contador, 
                           ROW_NUMBER() 
                             OVER ( 
                               ORDER BY SS_HC_Imprimir.FechaImpresion DESC ) 
                               AS 
                           RowNumber 
						     FROM dbo.vw_Imprimir_HC_GRILLA   AS SS_HC_Imprimir   
                          WHERE (@IdImpresion is null OR (IdImpresion = @IdImpresion) or @IdImpresion =0)  
                            and (@HostImpresion is null  OR @HostImpresion =''  OR  upper(HostImpresion) like '%'+upper(@HostImpresion)+'%')                              
                            and (@UsuarioImpresion is null  OR @UsuarioImpresion =''  OR  upper(UsuarioImpresion) like '%'+upper(@UsuarioImpresion)+'%')    
                           and  (@Version is null  OR @Version =''  OR  upper(SS_HC_Imprimir.NombreCompleto) like '%'+upper(@Version)+'%')  
						    AND ((@FechaImpresion is null or  FechaImpresion >= @FechaImpresion)    
                        	and (@Descripcion is null or  FechaImpresion < DATEADD(DAY,1,@Descripcion)))
						    and (@CodigoHC is null OR @CodigoHC='' OR upper(CodigoHC) like '%'+upper(@CodigoHC)+'%') 
							and (@UnidadReplicacion is null OR @UnidadReplicacion='' OR upper(UnidadReplicacion) like '%'+upper(@UnidadReplicacion)+'%') 
							  )
                   AS LISTADO 
            WHERE  ( @Inicio IS NULL 
                     AND @NumeroFilas IS NULL ) 
                    OR rownumber BETWEEN @Inicio AND @NumeroFilas 
        END 
 else
 IF( @ACCION = 'CUENTA' ) 
        BEGIN 
            SET @CONTADOR = (SELECT Count(*) 
                             FROM   vw_Imprimir_HC_GRILLA AS SS_HC_Imprimir 
                             
                  WHERE (@IdImpresion is null OR (IdImpresion = @IdImpresion) or @IdImpresion =0)  
                            and (@HostImpresion is null  OR @HostImpresion =''  OR  upper(HostImpresion) like '%'+upper(@HostImpresion)+'%')                              
                            and (@UsuarioImpresion is null  OR @UsuarioImpresion =''  OR  upper(UsuarioImpresion) like '%'+upper(@UsuarioImpresion)+'%')    
                            and (@Version is null  OR @Version =''  OR  upper(SS_HC_Imprimir.NombreCompleto) like '%'+upper(@Version)+'%')  
						    and ((@FechaImpresion is null or  FechaImpresion >= @FechaImpresion)    
                        	and (@Descripcion is null or  FechaImpresion < DATEADD(DAY,1,@Descripcion)))
						    and (@CodigoHC is null OR @CodigoHC='' OR upper(CodigoHC) like '%'+upper(@CodigoHC)+'%') 
							and (@UnidadReplicacion is null OR @UnidadReplicacion='' OR upper(UnidadReplicacion) like '%'+upper(@UnidadReplicacion)+'%') 
							   )
              
            SELECT IdImpresion,
			       UnidadReplicacion,        
                   IdPaciente,  
				   HostImpresion,   
				   UsuarioImpresion,   
				   FechaImpresion ,				          
                   Accion,
				   '' as Version,
				   descripcion ,
				   CodigoHC ,
				   @CONTADOR as Contador_filas                                                          
                  
            FROM  
			
			(  SELECT top 1 SS_HC_Imprimir.*,			 
                           @CONTADOR   AS  Contador, 
                           ROW_NUMBER() 
                             OVER ( 
                               ORDER BY SS_HC_Imprimir.FechaImpresion DESC ) 
                               AS 
                           RowNumber 
						     FROM dbo.vw_Imprimir_HC_GRILLA   AS SS_HC_Imprimir   
                             WHERE (@IdImpresion is null OR (IdImpresion = @IdImpresion) or @IdImpresion =0)  
                             and (@HostImpresion is null  OR @HostImpresion =''  OR  upper(HostImpresion) like '%'+upper(@HostImpresion)+'%')                              
                             and (@UsuarioImpresion is null  OR @UsuarioImpresion =''  OR  upper(UsuarioImpresion) like '%'+upper(@UsuarioImpresion)+'%')    
                             and (@Version is null  OR @Version =''  OR  upper(SS_HC_Imprimir.NombreCompleto) like '%'+upper(@Version)+'%')  
						     and ((@FechaImpresion is null or  FechaImpresion >= @FechaImpresion)    
                        	 and (@Descripcion is null or  FechaImpresion < DATEADD(DAY,1,@Descripcion)))
						     and (@CodigoHC is null OR @CodigoHC='' OR upper(CodigoHC) like '%'+upper(@CodigoHC)+'%') 
							 and (@UnidadReplicacion is null OR @UnidadReplicacion='' OR upper(UnidadReplicacion) like '%'+upper(@UnidadReplicacion)+'%') 
							  )
                   AS LISTADO             
        END 
 else
  IF @Accion = 'LISTAR' 
        BEGIN 
            SELECT SS_HC_Imprimir.IdImpresion,    
			       SS_HC_Imprimir.UnidadReplicacion,                 
                   SS_HC_Imprimir.IdPaciente,
				   SS_HC_Imprimir.HostImpresion,
				   SS_HC_Imprimir.UsuarioImpresion, 
				   SS_HC_Imprimir.FechaImpresion,
                   SS_HC_Imprimir.NombreCompleto as version,       
                   SS_HC_Imprimir.CodigoHC ,
				   '' as descripcion                                     
            FROM   vw_Imprimir_HC_GRILLA AS SS_HC_Imprimir 
             WHERE           ( @Version IS NULL OR Upper(SS_HC_Imprimir.NombreCompleto) LIKE '%' + Upper(@Version) + '%' ) 
                         AND ( @Accion IS NULL OR Upper(SS_HC_Imprimir.CodigoHC) LIKE '%' + Upper(@Accion) + '%' )      
						 AND ( @UnidadReplicacion IS NULL OR Upper(SS_HC_Imprimir.UnidadReplicacion) LIKE '%' + Upper(@UnidadReplicacion) + '%' )      
						 AND ( @HostImpresion IS NULL OR Upper(SS_HC_Imprimir.HostImpresion) LIKE '%' + Upper(@HostImpresion) + '%' )  
						 AND ( @UsuarioImpresion IS NULL OR Upper(SS_HC_Imprimir.UsuarioImpresion) LIKE '%' + Upper(@UsuarioImpresion) + '%' )  
						 AND ((@FechaImpresion is null or  SS_HC_Imprimir.FechaImpresion >= @FechaImpresion)    
				         and (@Descripcion is null or  SS_HC_Imprimir.FechaImpresion <= DATEADD(DAY,1,@Descripcion)))                         
        END       
  END 
 

GO
/****** Object:  StoredProcedure [dbo].[sp_SS_HC_ImpresionHC_listarotro]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [sp_SS_HC_ImpresionHC_listarotro] 
        @IdImpresionHeader int ,
		@UnidadReplicacionHeader int,
		@IdPacienteHeader int,		
		@HostImpresionHeader varchar(25),		
		@UsuarioImpresionHeader varchar(25),
		@FechaImpresionHeader datetime,
		@AccionHeader varchar(25),		
	   @IdImpresionDetalle int  ,
	   @SecuencialDetalle int ,
	   @IdPacienteDetalle int,
	   @IdEpisodioAtencionDetalle bigint,
	   @IdOpcionDetalle int,
	   @EpisodioClinicoDetalle int,
	   @EpisodioAtencionDetalle bigint,
	   @CodigoOpcionDetalle varchar(25),
	   @IdFormatoDetalle int,
	   @TipoAtencionDetalle int,
	   @IdUnidadServicioDetalle int,
	   @IdPersonalSaludDetalle int,
	   @HostImpresionDetalle varchar(25),
	   @UsuarioImpresionDetalle varchar(25),
	   @FechaImpresionDetalle datetime,	  
       @INICIO             INT= NULL, 
       @NUMEROFILAS        INT = NULL 

AS 
  BEGIN 
      IF( @AccionHeader = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR=(SELECT Count(*) 
                           FROM   vw_Imprimir_HC 
                           WHERE  ( @IdPacienteHeader IS NULL 
                                     OR @IdPacienteHeader = '' 
                                     OR Upper(Ltrim(Rtrim(IdPacienteHeader))) LIKE 
                                        '%' + Upper(Ltrim(Rtrim(@IdPacienteHeader))) 
                                        + '%' ) 
                                  AND ( @HostImpresionHeader IS NULL 
                                         OR @HostImpresionHeader = '' 
                                         OR Upper(HostImpresionHeader) LIKE 
                                            '%' + Upper(@HostImpresionHeader) + 
                                            '%' )) 

       SELECT   IdImpresionHeader  ,
		UnidadReplicacionHeader,
		IdPacienteHeader ,		
		HostImpresionHeader ,		
		UsuarioImpresionHeader ,
		FechaImpresionHeader ,
		AccionHeader ,		
	   IdImpresionDetalle   ,
	   SecuencialDetalle  ,
	   IdPacienteDetalle ,
	   IdEpisodioAtencionDetalle ,
	   IdOpcionDetalle ,
	   EpisodioClinicoDetalle ,
	   EpisodioAtencionDetalle ,
	   CodigoOpcionDetalle ,
	   IdFormatoDetalle ,
	   TipoAtencionDetalle ,
	   IdUnidadServicioDetalle ,
	   IdPersonalSaludDetalle ,
	   HostImpresionDetalle ,
	   UsuarioImpresionDetalle ,
	   FechaImpresionDetalle 
            FROM   (SELECT IdImpresionHeader  ,
		UnidadReplicacionHeader,
		IdPacienteHeader ,		
		HostImpresionHeader ,		
		UsuarioImpresionHeader ,
		FechaImpresionHeader ,
		AccionHeader ,		
	   IdImpresionDetalle   ,
	   SecuencialDetalle  ,
	   IdPacienteDetalle ,
	   IdEpisodioAtencionDetalle ,
	   IdOpcionDetalle ,
	   EpisodioClinicoDetalle ,
	   EpisodioAtencionDetalle ,
	   CodigoOpcionDetalle ,
	   IdFormatoDetalle ,
	   TipoAtencionDetalle ,
	   IdUnidadServicioDetalle ,
	   IdPersonalSaludDetalle ,
	   HostImpresionDetalle ,
	   UsuarioImpresionDetalle ,
	   FechaImpresionDetalle , 
            @CONTADOR AS Contador, 
            Row_number() 
                OVER ( 
                ORDER BY FechaImpresionHeader ASC ) AS RowNumber 
				FROM   vw_Imprimir_HC 
				WHERE  ( @IdPacienteHeader IS NULL OR @IdPacienteHeader = '' OR Upper(Ltrim(Rtrim(IdPacienteHeader))) LIKE 
							'%' + Upper(Ltrim(Rtrim(@IdPacienteHeader))) + '%' ) 
                    AND ( @HostImpresionHeader IS NULL OR @HostImpresionHeader = '' OR Upper(HostImpresionHeader) LIKE 
                            '%' + Upper(@HostImpresionHeader) + '%' ))  AS LISTADO 
            WHERE  ( @Inicio IS NULL 
                     AND @NumeroFilas IS NULL ) 
                    OR rownumber BETWEEN @Inicio AND @NumeroFilas 
        END 
      ELSE IF ( @AccionHeader = 'LISTADO' ) 
        BEGIN 
            DECLARE @CONTAR INT 

            SELECT @CONTAR = Count(*) 
            FROM   SS_HC_ImpresionHC 
            WHERE  ( @IdPacienteHeader IS NULL OR @IdPacienteHeader = '' OR Upper(Ltrim(Rtrim(IdPaciente))) LIKE 
                                        '%' + Upper(Ltrim(Rtrim(@IdPacienteHeader))) 
                                        + '%' ) 
                                  AND ( @HostImpresionHeader IS NULL OR @HostImpresionHeader = '' 
                                         OR Upper(HostImpresion) LIKE  '%' + Upper(@HostImpresionHeader) + 
                                            '%' )

            SELECT IdImpresion as  IdImpresionHeader ,
		UnidadReplicacion  as UnidadReplicacionHeader,
		IdPaciente as IdPacienteHeader,		
		HostImpresion as HostImpresionHeader,		
		UsuarioImpresion as UsuarioImpresionHeader,
		FechaImpresion as FechaImpresionHeader,
		Accion as AccionHeader,		
	   IdImpresionDetalle   ,
	   SecuencialDetalle  ,
	   IdPacienteDetalle ,
	   IdEpisodioAtencionDetalle ,
	   IdOpcionDetalle ,
	   EpisodioClinicoDetalle ,
	   EpisodioAtencionDetalle ,
	   CodigoOpcionDetalle ,
	   IdFormatoDetalle ,
	   TipoAtencionDetalle ,
	   IdUnidadServicioDetalle ,
	   IdPersonalSaludDetalle ,
	   HostImpresionDetalle ,
	   UsuarioImpresionDetalle ,
	   FechaImpresionDetalle  
            FROM   (SELECT SS_HC_ImpresionHC.IdImpresion, 
                           SS_HC_ImpresionHC.UnidadReplicacion, 
                           SS_HC_ImpresionHC.IdPaciente, 
                           SS_HC_ImpresionHC.HostImpresion, 
                           SS_HC_ImpresionHC.UsuarioImpresion, 
                           SS_HC_ImpresionHC.FechaImpresion,                            
                           SS_HC_ImpresionHC.accion, 
                           ''                             IdImpresionDetalle, 
                           ''                             SecuencialDetalle, 
                           ''                             IdPacienteDetalle, 
                           ''                             IdEpisodioAtencionDetalle, 
                           ''                             IdOpcionDetalle, 
                           ''                             EpisodioClinicoDetalle, 
                           ''                             EpisodioAtencionDetalle, 
                           ''                             CodigoOpcionDetalle, 
                           ''                             IdFormatoDetalle, 
                           ''                             TipoAtencionDetalle, 
                           ''                             IdUnidadServicioDetalle, 
                           ''                             IdPersonalSaludDetalle, 
                           ''                             HostImpresionDetalle, 
                           ''                             UsuarioImpresionDetalle, 
                   GETDATE()                              FechaImpresionDetalle , 
                           @CONTAR                        AS CONTADOR, 
                           Row_number() 
                             OVER( 
                               ORDER BY HostImpresion) AS ROWNUMBER 
                    FROM   SS_HC_ImpresionHC 
                    WHERE  ( @IdImpresionHeader IS NULL 
                              OR @IdImpresionHeader = '' 
                              OR Upper(Ltrim(Rtrim(IdImpresion))) LIKE 
                                 '%' + Upper(Ltrim(Rtrim(@IdImpresionHeader))) + 
                                 '%' ) 
                           AND ( @HostImpresionHeader IS NULL 
                                  OR @HostImpresionHeader = '' 
                                  OR Upper(HostImpresion) LIKE 
                                     '%' + Upper(@HostImpresionHeader) + 
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
/****** Object:  StoredProcedure [dbo].[sp_SS_HC_ImpresionHCotro]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER PROCEDURE [sp_SS_HC_ImpresionHCotro] 
        @IdImpresionHeader int ,
		@SecuencialHeader int,
		@IdPacienteHeader int,
		@IdEpisodioAtencionHeader bigint,
		@IdOpcionHeader int,
		@EpisodioClinicoHeader int,
		@EpisodioAtencionHeader bigint,
		@CodigoOpcionHeader varchar(25),
		@IdFormatoHeader int,
		@TipoAtencionHeader int,
		@IdUnidadServicioHeader int,
		@IdPersonalSaludHeader int,
		@HostImpresionHeader varchar(25),		
		@UsuarioImpresionHeader varchar(25),
		@FechaImpresionHeader datetime,
		@AccionHeader varchar(25),		
	   @IdImpresionDetalle int  ,
	   @SecuencialDetalle int ,
	   @IdPacienteDetalle int,
	   @IdEpisodioAtencionDetalle bigint,
	   @IdOpcionDetalle int,
	   @EpisodioClinicoDetalle int,
	   @EpisodioAtencionDetalle bigint,
	   @CodigoOpcionDetalle varchar(25),
	   @IdFormatoDetalle int,
	   @TipoAtencionDetalle int,
	   @IdUnidadServicioDetalle int,
	   @IdPersonalSaludDetalle int,
	   @HostImpresionDetalle varchar(25),
	   @UsuarioImpresionDetalle varchar(25),
	   @FechaImpresionDetalle datetime 		
AS 
  BEGIN 
      SET nocount ON; 

      BEGIN TRANSACTION 

      DECLARE @CONTADOR INT 

      IF( @AccionHeader = 'CONTARLISTAPAG' ) 
        BEGIN 
            SET @CONTADOR=(SELECT Count(*) 
                           FROM   vw_Imprimir_HC 
                           WHERE  ( @IdPacienteHeader IS NULL 
                                    OR @IdPacienteHeader = '' 
                                    OR Upper(Ltrim(Rtrim(IdPacienteHeader))) LIKE 
                                    '%' + Upper(Ltrim(Rtrim(@IdPacienteHeader))) 
                                    + '%' ) 
                                  AND ( @HostImpresionHeader IS NULL 
                                    OR @HostImpresionHeader = '' 
                                    OR Upper(HostImpresionHeader) LIKE 
                                    '%' + Upper(@HostImpresionHeader) + 
                                    '%' )) 

            SELECT @CONTADOR 
        END 
      ELSE IF ( @AccionHeader = 'LISTADO' ) 
        BEGIN 
            DECLARE @CONTAR INT 

            SET @CONTAR = (SELECT Count(*) 
                           FROM   SS_HC_ImpresionHC 
                           WHERE  ( @IdPacienteHeader IS NULL 
                                OR @IdPacienteHeader = '' 
                                OR Upper(Ltrim(Rtrim(IdPaciente))) LIKE 
                                '%' + Upper(Ltrim(Rtrim(@IdPacienteHeader))) 
                                + '%' ) 
                                  AND ( @HostImpresionHeader IS NULL 
                                OR @HostImpresionHeader = '' 
                                OR Upper(HostImpresion) LIKE 
                                '%' + Upper(@HostImpresionHeader) + 
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
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_IndicadorPAE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_IndicadorPAE]

	@IdIndicadorPAE int ,
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
            SELECT @IdIndicadorPAE = Isnull(Max(IdIndicadorPAE), 0) + 1 FROM   dbo.SS_HC_IndicadorPAE  
            INSERT INTO SS_HC_IndicadorPAE 
                        (IdIndicadorPAE,                          
                         descripcion,                         
                         estado, 
                         usuariocreacion, 
                         fechacreacion, 
                         usuariomodificacion, 
                         fechamodificacion, 
                         accion 
                         ) 
            VALUES      ( @IdIndicadorPAE,                            
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
            UPDATE SS_HC_IndicadorPAE 
            SET    IdIndicadorPAE = @IdIndicadorPAE,                    
                   descripcion = @Descripcion,                   
                   estado = @Estado, 
                   usuariomodificacion = @UsuarioModificacion, 
                   fechamodificacion = GETDATE(), 
                   accion = @Accion 
                   
            WHERE  ( SS_HC_IndicadorPAE.IdIndicadorPAE = @IdIndicadorPAE ) 

            SELECT 1 
        END 
      ELSE IF @Accion = 'DELETE' 
        BEGIN 
            DELETE FROM SS_HC_IndicadorPAE 
            WHERE  ( SS_HC_IndicadorPAE.IdIndicadorPAE = @IdIndicadorPAE ) 

            SELECT 1 
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_IndicadorPAE 
                             WHERE  ( @Descripcion IS NULL OR Upper(SS_HC_IndicadorPAE.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_IndicadorPAE.estado = @Estado OR @Estado = 0 )                                    
                                    AND ( @IdIndicadorPAE IS NULL OR SS_HC_IndicadorPAE.IdIndicadorPAE = @IdIndicadorPAE OR @IdIndicadorPAE = 0 )) 

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
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_IndicadorPAE_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_IndicadorPAE_LISTAR]
	@IdIndicadorPAE int ,
	@Descripcion varchar(150) ,
	@Estado	int ,
	@UsuarioCreacion varchar(25) ,
	@FechaCreacion datetime ,	
	@UsuarioModificacion varchar(25) ,
	@FechaModificacion datetime ,		
	@Inicio	int ,	
	@NumeroFilas	int ,	
	@Accion	varchar(25),
	@Version varchar(25)

AS 
 BEGIN 
      SET nocount ON; 

      DECLARE @CONTADOR INT 

      IF @Accion = 'LISTAR' 
        BEGIN 
            SELECT SS_HC_IndicadorPAE.IdIndicadorPAE,                    
                   SS_HC_IndicadorPAE.descripcion, 
                   SS_HC_IndicadorPAE.Estado,                    
                   SS_HC_IndicadorPAE.usuariocreacion, 
                   SS_HC_IndicadorPAE.fechacreacion, 
                   SS_HC_IndicadorPAE.usuariomodificacion, 
                   SS_HC_IndicadorPAE.fechamodificacion, 
                   SS_HC_IndicadorPAE.accion, 
                   SS_HC_IndicadorPAE.version 
            FROM   SS_HC_IndicadorPAE 
             WHERE  ( @Descripcion IS NULL OR Upper(SS_HC_IndicadorPAE.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                   AND ( @Estado IS NULL OR SS_HC_IndicadorPAE.estado = @Estado OR @Estado = 0 )                                    
                   AND ( @IdIndicadorPAE IS NULL OR SS_HC_IndicadorPAE.IdIndicadorPAE = @IdIndicadorPAE OR @IdIndicadorPAE = 0 )
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_IndicadorPAE 
                              WHERE  ( @Descripcion IS NULL OR Upper(SS_HC_IndicadorPAE.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_IndicadorPAE.estado = @Estado OR @Estado = 0 )                                    
                                    AND ( @IdIndicadorPAE IS NULL OR SS_HC_IndicadorPAE.IdIndicadorPAE = @IdIndicadorPAE OR @IdIndicadorPAE = 0 )) 

            SELECT IdIndicadorPAE,                     
                   descripcion,                    
                   estado, 
                   usuariocreacion, 
                   fechacreacion, 
                   usuariomodificacion, 
                   fechamodificacion, 
                   accion, 
                   version 
            FROM   (SELECT SS_HC_IndicadorPAE.IdIndicadorPAE,                            
                           SS_HC_IndicadorPAE.descripcion,                            
                           SS_HC_IndicadorPAE.estado, 
                           SS_HC_IndicadorPAE.usuariocreacion, 
                           SS_HC_IndicadorPAE.fechacreacion, 
                           SS_HC_IndicadorPAE.usuariomodificacion, 
                           SS_HC_IndicadorPAE.fechamodificacion, 
                           SS_HC_IndicadorPAE.accion, 
                           SS_HC_IndicadorPAE.version, 
                           @CONTADOR                                  
                           AS 
                           Contador, 
                           Row_number() 
                             OVER ( 
                               ORDER BY SS_HC_IndicadorPAE.IdIndicadorPAE ASC ) 
                               AS 
                           RowNumber 
                    FROM   SS_HC_IndicadorPAE 
                     WHERE  ( @Descripcion IS NULL OR Upper(SS_HC_IndicadorPAE.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_IndicadorPAE.estado = @Estado OR @Estado = 0 )                                     
                                    AND ( @IdIndicadorPAE IS NULL OR SS_HC_IndicadorPAE.IdIndicadorPAE = @IdIndicadorPAE OR @IdIndicadorPAE = 0 )) 
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
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_InformeAlta_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_InformeAlta_FE]
@UnidadReplicacion char(4)
,@IdEpisodioAtencion bigint 
,@IdPaciente int 
,@EpisodioClinico int 
,@IdMedico int
,@IdEspecialidad int
,@IdTipoAlta int
,@IdPronostico int
,@Procedimientos varchar(250)
,@indigenerales varchar(250)
,@actividafisica varchar(250)
,@indidieta varchar(250)
,@restricciones varchar(250)
,@proximacitas datetime
,@UsuarioCreacion varchar(25)  
,@FechaCreacion datetime 
,@UsuarioModificacion varchar(25)  
,@FechaModificacion datetime 
,@Accion varchar(25)  
,@Version varchar(25) 

AS
BEGIN
IF(@Accion='NUEVO')
BEGIN
	 INSERT INTO SS_HC_InformeAlta_FE(UnidadReplicacion,
	IdEpisodioAtencion,IdPaciente,EpisodioClinico,IdMedico,IdEspecialidad,IdTipoAlta,IdPronostico,
	Procedimientos,indigenerales,actividafisica,indidieta,restricciones,proximacitas,UsuarioCreacion,
	FechaCreacion,UsuarioModificacion,FechaModificacion,Accion,Version,hcaltamedica)
	VALUES(@UnidadReplicacion,
	@IdEpisodioAtencion,@IdPaciente,@EpisodioClinico,@IdMedico,@IdEspecialidad,@IdTipoAlta,@IdPronostico,
	@Procedimientos,@indigenerales,@actividafisica,@indidieta,@restricciones,@proximacitas,@UsuarioCreacion,
	@FechaCreacion,@UsuarioCreacion,@FechaCreacion,@Accion,@Version,1)

	update SS_HC_EpisodioAtencion set IdTipoReferencia=2 where IdPaciente=@IdPaciente and EpisodioClinico= @EpisodioClinico and IdEpisodioAtencion=@IdEpisodioAtencion
	 and TipoAtencion=2 and IdOrdenAtencion=convert (int,@UsuarioModificacion)

SELECT @EpisodioClinico
END

IF(@Accion='UPDATE')
BEGIN
	IF(@Version='CCEPF200')
	BEGIN
			UPDATE SS_HC_InformeAlta_FE
			SET IdMedico=@IdMedico,
			IdEspecialidad=@IdEspecialidad,
			IdTipoAlta=@IdTipoAlta,
			IdPronostico=@IdPronostico,
			Procedimientos=@Procedimientos,
			UsuarioModificacion=@UsuarioModificacion,
			FechaModificacion=@FechaModificacion,
			Accion=@Accion,
			Version=@Version,
			hcaltamedica=1
			WHERE UnidadReplicacion=@UnidadReplicacion AND IdEpisodioAtencion=@IdEpisodioAtencion AND
			IdPaciente=@IdPaciente AND EpisodioClinico=@EpisodioClinico

			SELECT @EpisodioClinico
	END
		IF(@Version='CCEPF201')
	BEGIN
			UPDATE SS_HC_InformeAlta_FE
			SET
			indigenerales=@indigenerales,
			actividafisica=@actividafisica,
			indidieta=@indidieta,
			restricciones=@restricciones,
			UsuarioModificacion=@UsuarioModificacion,
			FechaModificacion=@FechaModificacion,
			Accion=@Accion,
			Version=@Version,
			hcaltamedica=1
			WHERE UnidadReplicacion=@UnidadReplicacion AND IdEpisodioAtencion=@IdEpisodioAtencion AND
			IdPaciente=@IdPaciente AND EpisodioClinico=@EpisodioClinico

			SELECT @EpisodioClinico
	END
END

END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_InformeAltaAPD_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_InformeAltaAPD_FE]
@UnidadReplicacion char(4)
,@IdEpisodioAtencion bigint 
,@IdPaciente int 
,@EpisodioClinico int 
,@Secuencia int 
,@ExamenDescripcion varchar(250)  
,@CodigoSegus varchar(25)  
,@UsuarioCreacion varchar(25)  
,@FechaCreacion datetime 
,@UsuarioModificacion varchar(25)  
,@FechaModificacion datetime 
,@Accion varchar(25)  
,@Version varchar(25)  

AS
BEGIN
	DECLARE @SECUENCIAMAX INT 
	SET @SECUENCIAMAX = (SELECT (ISNULL(MAX(Secuencia),0)+1) FROM SS_HC_InformeAltaAPD_FE )

	IF(@Accion = 'NUEVO')
	BEGIN

		DELETE FROM SS_HC_InformeAltaAPD_FE WHERE UnidadReplicacion= @UnidadReplicacion
			AND  IdEpisodioAtencion=@IdEpisodioAtencion 
			AND IdPaciente=@IdPaciente
			AND EpisodioClinico=@EpisodioClinico
			AND Secuencia=@Secuencia

		INSERT INTO SS_HC_InformeAltaAPD_FE(UnidadReplicacion,IdEpisodioAtencion,IdPaciente,EpisodioClinico,Secuencia,
		ExamenDescripcion,CodigoSegus,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,Accion,Version) 
		VALUES(@UnidadReplicacion, @IdEpisodioAtencion, @IdPaciente, @EpisodioClinico, @SECUENCIAMAX, 
		@ExamenDescripcion, @CodigoSegus,@UsuarioCreacion, @FechaCreacion, @UsuarioModificacion, @FechaModificacion, @Accion, @Version
		)
		SELECT @SECUENCIAMAX
	END

	IF(@Accion = 'UPDATE')
	BEGIN

		UPDATE SS_HC_InformeAltaAPD_FE
		SET ExamenDescripcion = @ExamenDescripcion,
		CodigoSegus= @CodigoSegus,
		UsuarioModificacion=@UsuarioModificacion,
		FechaModificacion=@FechaModificacion
		WHERE
		UnidadReplicacion= @UnidadReplicacion 
		AND  IdEpisodioAtencion=@IdEpisodioAtencion
		AND IdPaciente=@IdPaciente
		AND EpisodioClinico=@EpisodioClinico 
		AND Secuencia=@Secuencia	
	
		SELECT @Secuencia
	END

	IF(@Accion = 'DELETE')
	BEGIN

		DELETE FROM SS_HC_InformeAltaAPD_FE
		WHERE UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
		AND EpisodioClinico=@EpisodioClinico AND Secuencia=@Secuencia
	
		SELECT @Secuencia
	END

END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_InformeAltaAPD_FE_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_InformeAltaAPD_FE_Listar]
 @UnidadReplicacion char(4)
,@IdEpisodioAtencion bigint 
,@IdPaciente int 
,@EpisodioClinico int 
,@Secuencia int 
,@ExamenDescripcion varchar(250)  
,@CodigoSegus varchar(25)  
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
		SELECT * FROM SS_HC_InformeAltaAPD_FE
		WHERE UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
			AND EpisodioClinico=@EpisodioClinico
	END

END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_InformeAltaDiagAlt_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_InformeAltaDiagAlt_FE]
 @UnidadReplicacion char(4)
,@IdEpisodioAtencion bigint 
,@IdPaciente int 
,@EpisodioClinico int 
,@Secuencia int 
,@DiagnosticoDescripcion varchar(250)  
,@Codigo varchar(25)  
,@UsuarioCreacion varchar(25)  
,@FechaCreacion datetime 
,@UsuarioModificacion varchar(25)  
,@FechaModificacion datetime 
,@Accion varchar(25)  
,@Version varchar(25)  

AS
BEGIN
	DECLARE @SECUENCIAMAX INT 
	SET @SECUENCIAMAX = (SELECT (ISNULL(MAX(Secuencia),0)+1) FROM SS_HC_InformeAltaDiagAlt_FE WHERE
		UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
		AND EpisodioClinico=@EpisodioClinico)
	IF(@Accion = 'NUEVO')
	BEGIN

		INSERT INTO SS_HC_InformeAltaDiagAlt_FE(UnidadReplicacion,IdEpisodioAtencion,IdPaciente,EpisodioClinico,Secuencia,
		DiagnosticoDescripcion,Codigo,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,Accion,Version) 
		VALUES(@UnidadReplicacion, @IdEpisodioAtencion, @IdPaciente, @EpisodioClinico, @SECUENCIAMAX, 
		@DiagnosticoDescripcion, @Codigo,@UsuarioCreacion, @FechaCreacion, @UsuarioModificacion, @FechaModificacion, @Accion, @Version
		)
		SELECT @SECUENCIAMAX
	END

	IF(@Accion = 'UPDATE')
	BEGIN

		UPDATE SS_HC_InformeAltaDiagAlt_FE
		SET DiagnosticoDescripcion = @DiagnosticoDescripcion,
		Codigo= @Codigo,
		UsuarioModificacion=@UsuarioModificacion,
		FechaModificacion=@FechaModificacion
		WHERE
		UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
		AND EpisodioClinico=@EpisodioClinico AND Secuencia=@Secuencia	
	
	SELECT @Secuencia
	END

	IF(@Accion = 'DELETE')
	BEGIN

		DELETE FROM SS_HC_InformeAltaDiagAlt_FE
		WHERE UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
		AND EpisodioClinico=@EpisodioClinico AND Secuencia=@Secuencia
	
	SELECT @Secuencia
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_InformeAltaDiagAlt_FE_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_InformeAltaDiagAlt_FE_Listar]
 @UnidadReplicacion char(4)
,@IdEpisodioAtencion bigint 
,@IdPaciente int 
,@EpisodioClinico int 
,@Secuencia int 
,@DiagnosticoDescripcion varchar(250)  
,@Codigo varchar(25)  
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
		SELECT * FROM SS_HC_InformeAltaDiagAlt_FE
		WHERE UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
			AND EpisodioClinico=@EpisodioClinico
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_InformeAltaDiagIng_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_InformeAltaDiagIng_FE]
 @UnidadReplicacion char(4)
,@IdEpisodioAtencion bigint 
,@IdPaciente int 
,@EpisodioClinico int 
,@Secuencia int 
,@DiagnosticoDescripcion varchar(250)  
,@Codigo varchar(25)  
,@UsuarioCreacion varchar(25)  
,@FechaCreacion datetime 
,@UsuarioModificacion varchar(25)  
,@FechaModificacion datetime 
,@Accion varchar(25)  
,@Version varchar(25)  

AS
BEGIN
DECLARE @SECUENCIAMAX INT 
	SET @SECUENCIAMAX = (SELECT (ISNULL(MAX(Secuencia),0)+1) FROM SS_HC_InformeAltaDiagIng_FE WHERE
		UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
		AND EpisodioClinico=@EpisodioClinico)
	IF(@Accion = 'NUEVO')
	BEGIN
	
		DELETE FROM SS_HC_InformeAltaDiagIng_FE WHERE UnidadReplicacion= @UnidadReplicacion
			AND  IdEpisodioAtencion=@IdEpisodioAtencion 
			AND IdPaciente=@IdPaciente
			AND EpisodioClinico=@EpisodioClinico
			AND Secuencia=@Secuencia

			INSERT INTO SS_HC_InformeAltaDiagIng_FE(UnidadReplicacion,IdEpisodioAtencion,IdPaciente,EpisodioClinico,Secuencia,
		DiagnosticoDescripcion,Codigo,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,Accion,Version) 
		VALUES(@UnidadReplicacion, @IdEpisodioAtencion, @IdPaciente, @EpisodioClinico, @Secuencia, 
		@DiagnosticoDescripcion, @Codigo,@UsuarioCreacion, @FechaCreacion, @UsuarioModificacion, @FechaModificacion, @Accion, @Version
		)
		SELECT @SECUENCIAMAX
	END

	IF(@Accion = 'UPDATE')
	BEGIN

		UPDATE SS_HC_InformeAltaDiagIng_FE
		SET DiagnosticoDescripcion = @DiagnosticoDescripcion,
		Codigo= @Codigo,
		UsuarioModificacion=@UsuarioModificacion,
		FechaModificacion=@FechaModificacion
		WHERE
		UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
		AND EpisodioClinico=@EpisodioClinico AND Secuencia=@Secuencia
		
	SELECT @Secuencia
	END
	IF(@Accion = 'DELETE')
	BEGIN

		DELETE FROM SS_HC_InformeAltaDiagIng_FE
		WHERE UnidadReplicacion= @UnidadReplicacion
		AND  IdEpisodioAtencion=@IdEpisodioAtencion 
		AND IdPaciente=@IdPaciente
		AND EpisodioClinico=@EpisodioClinico
		AND Secuencia=@Secuencia	
	
	SELECT @Secuencia
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_InformeAltaDiagIng_FE_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_InformeAltaDiagIng_FE_Listar]
 @UnidadReplicacion char(4)
,@IdEpisodioAtencion bigint 
,@IdPaciente int 
,@EpisodioClinico int 
,@Secuencia int 
,@DiagnosticoDescripcion varchar(250)  
,@Codigo varchar(25)  
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
		SELECT * FROM SS_HC_InformeAltaDiagIng_FE
		WHERE UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
			AND EpisodioClinico=@EpisodioClinico
	END

END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_InformeAltaProxCita_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_InformeAltaProxCita_FE]
@UnidadReplicacion char(4)
,@IdEpisodioAtencion bigint 
,@IdPaciente int 
,@EpisodioClinico int 
,@Secuencia int 
,@FechaCita datetime
,@IdEspecialidad int  
,@Observacion varchar(250)  
,@UsuarioCreacion varchar(25)  
,@FechaCreacion datetime 
,@UsuarioModificacion varchar(25)  
,@FechaModificacion datetime 
,@Accion varchar(25)  
,@Version varchar(25)  

AS
BEGIN
	DECLARE @SECUENCIAMAX INT 
	SET @SECUENCIAMAX = (SELECT (ISNULL(MAX(Secuencia),0)+1) FROM SS_HC_InformeAltaProxCita_FE WHERE
		UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
		AND EpisodioClinico=@EpisodioClinico)
	IF(@Accion = 'NUEVO')
	BEGIN

		INSERT INTO SS_HC_InformeAltaProxCita_FE(UnidadReplicacion,IdEpisodioAtencion,IdPaciente,EpisodioClinico,Secuencia,
	FechaCita,IdEspecialidad, Observacion,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,Accion,Version) 
	VALUES(@UnidadReplicacion, @IdEpisodioAtencion, @IdPaciente, @EpisodioClinico, @SECUENCIAMAX, 
	@FechaCita, @IdEspecialidad,@Observacion,@UsuarioCreacion, @FechaCreacion, @UsuarioModificacion, @FechaModificacion, @Accion, @Version
	)
	SELECT @SECUENCIAMAX
	END

	IF(@Accion = 'UPDATE')
	BEGIN

		UPDATE SS_HC_InformeAltaProxCita_FE
		SET FechaCita = @FechaCita,
		IdEspecialidad= @IdEspecialidad,
		UsuarioModificacion=@UsuarioModificacion,
		FechaModificacion=@FechaModificacion
		WHERE
		UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
		AND EpisodioClinico=@EpisodioClinico AND Secuencia=@Secuencia
	
	
	
	SELECT @Secuencia
	END

	IF(@Accion = 'DELETE')
	BEGIN

		DELETE FROM SS_HC_InformeAltaProxCita_FE
		WHERE UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
		AND EpisodioClinico=@EpisodioClinico AND Secuencia=@Secuencia
	
	SELECT @Secuencia
	END

END

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_InformeAltaProxCita_FE_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_InformeAltaProxCita_FE_Listar]
@UnidadReplicacion char(4)
,@IdEpisodioAtencion bigint 
,@IdPaciente int 
,@EpisodioClinico int 
,@Secuencia int 
,@FechaCita datetime
,@IdEspecialidad int  
,@Observacion varchar(250)  
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
		SELECT * FROM SS_HC_InformeAltaProxCita_FE 
		WHERE UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
			AND EpisodioClinico=@EpisodioClinico
	END
END

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_InterConsultaSalida_Lista]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_InterConsultaSalida_Lista]
(
	 @UnidadReplicacion		varchar(4)=NULL
	,@EpisodioAtencion		bigint=NULL
	,@IdPaciente			int=NULL
	,@EpisodioClinico		int=NULL
	,@IdOrdenAtencion		int=NULL
)

AS
BEGIN
	
	SELECT SS_HC_EpisodioAtencion.IdOrdenAtencion,
			SS_HC_EpisodioAtencion.LineaOrdenAtencion,
			LineaOrdenAtencion = NULL,  --500201 500204
			CodigoSegus= CASE WHEN TipoAtencion=1  THEN '500101' ELSE CASE WHEN '20:00:00'>Convert(Varchar(15), GETDATE() , 108) THEN '500201' ELSE '500204' END  END,
			Cantidad=1,
			SS_HC_InterConsulta_FE.IdTipoInterConsulta as IndicadorEPS,-- luke 25-02-2020 / tipo interconsulta
			SS_HC_InterConsulta_FE.IdEspecialidad,
			Medico=0,
			FechaProcedimiento =GETDATE(),
			IdCita = NULL,
			EstadoDcumento = NULL,
			SS_HC_EpisodioAtencion.UnidadReplicacion,
			SS_HC_EpisodioAtencion.IdEpisodioAtencion,
			SS_HC_EpisodioAtencion.IdPaciente,
			SS_HC_EpisodioAtencion.EpisodioClinico,
			SS_HC_InterConsulta_FE.Secuencia,
			Estado = 2,
			SS_HC_InterConsulta_FE.UsuarioCreacion,
			FechaCreacion=GETDATE(),
			SS_HC_InterConsulta_FE.UsuarioModificacion,
			FechaModificacion=GETDATE(),
			IdTipoOrdenAtencion=11,
			SS_HC_InterConsulta_FE.Observacion
			,SS_HC_InterConsulta_FE.SecuencialHCE
			FROM SS_HC_InterConsulta_FE 
			INNER JOIN SS_HC_EpisodioAtencion ON SS_HC_EpisodioAtencion.UnidadReplicacion = SS_HC_InterConsulta_FE.UnidadReplicacion
					AND SS_HC_EpisodioAtencion.IdPaciente = SS_HC_InterConsulta_FE.IdPaciente
				AND SS_HC_EpisodioAtencion.EpisodioClinico = SS_HC_InterConsulta_FE.EpisodioClinico
				AND (case when SS_HC_EpisodioAtencion.TipoAtencion=1 then SS_HC_EpisodioAtencion.EpisodioAtencion else 
			 SS_HC_EpisodioAtencion.IdEpisodioAtencion end)= SS_HC_InterConsulta_FE.IdEpisodioAtencion		
			WHERE
				SS_HC_EpisodioAtencion.IdOrdenAtencion = @IdOrdenAtencion	   --8009772
			AND	SS_HC_EpisodioAtencion.UnidadReplicacion = @UnidadReplicacion 	
			AND	SS_HC_EpisodioAtencion.IdPaciente = @IdPaciente 
			AND	SS_HC_EpisodioAtencion.EpisodioClinico  = @EpisodioClinico 
			AND (case when SS_HC_EpisodioAtencion.TipoAtencion=1 then SS_HC_EpisodioAtencion.EpisodioAtencion else 
			 SS_HC_EpisodioAtencion.IdEpisodioAtencion end) = @EpisodioAtencion 
		

END

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Kardex1_FE_Insert]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_Kardex1_FE_Insert]
(
	@UnidadReplicacion	char(4),
	@IdEpisodioAtencion	bigint,
	@IdPaciente	int,
	@EpisodioClinico	int,
	@IdMedico int,
	@CMP int,
	@Estado int,
	@NombreMedico varchar(100),
	@Religion varchar(25),
	@Ayuno int,
	@UsuarioCreacion	varchar(25),
	@FechaCreacion	datetime,
	@UsuarioModificacion	varchar(25),
	@FechaModificacion	datetime,
	@Accion	varchar(25),
	@Version	varchar(150)			
)

AS
BEGIN 
SET NOCOUNT ON;
 if(@ACCION = 'NUEVO')
	BEGIN
		INSERT INTO SS_HC_Kardex1_FE(
		UnidadReplicacion,
		IdEpisodioAtencion,
		IdPaciente,
		EpisodioClinico,
		IdMedico,
		CMP,
		Estado,
		NombreMedico,
		Religion,
		Ayuno,
		UsuarioCreacion,
		FechaCreacion,
		UsuarioModificacion,
		FechaModificacion,
		Accion,
		Version) VALUES
			(
		@UnidadReplicacion,
		@IdEpisodioAtencion,
		@IdPaciente,
		@EpisodioClinico,
		@IdMedico,
		@CMP,
		@Estado,
		@NombreMedico,
		@Religion,
		@Ayuno,
		@UsuarioCreacion,
		GETDATE(),
		@UsuarioModificacion,
		GETDATE(),
		@Accion,
		@Version)
	END

		if(@ACCION = 'UPDATE')
		BEGIN
		UPDATE SS_HC_Kardex1_FE SET 
		IdMedico=@IdMedico,
		CMP=@CMP,
		Estado=@Estado,
		NombreMedico=@NombreMedico,
		Religion=@Religion,
		Ayuno=@Ayuno,
		UsuarioModificacion=@UsuarioModificacion,
		FechaModificacion=GETDATE(),
		Accion=@Accion,
		Version=@Version
			WHERE UnidadReplicacion=@UnidadReplicacion AND
			IdEpisodioAtencion=@IdEpisodioAtencion AND
			IdPaciente=@IdPaciente AND
			EpisodioClinico=@EpisodioClinico 
		END
END	
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Kardex1_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[SP_SS_HC_Kardex1_Listar]
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
				UnidadReplicacion,
				IdEpisodioAtencion,
				IdPaciente,
				EpisodioClinico,
				IdMedico,
				CMP,
				Estado,
				NombreMedico,
				Religion,
				Ayuno,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version
				from SS_HC_KARDEX1_FE
				where UnidadReplicacion=@UnidadReplicacion and
				IdEpisodioAtencion=@IdEpisodioAtencion and
				IdPaciente=@IdPaciente and
				EpisodioClinico=@EpisodioClinico
			END
	ELSE IF @Accion ='LISTARKARDEX3'
			BEGIN			
				select 
				SS_HC_KARDEX1_FE.UnidadReplicacion,
				SS_HC_KARDEX1_FE.IdEpisodioAtencion,
				SS_HC_KARDEX1_FE.IdPaciente,
				SS_HC_KARDEX1_FE.EpisodioClinico,
				IdMedico,
				CMP,
				SS_HC_KARDEX1_FE.Estado,
				NombreMedico,
				Religion,
				Ayuno,
				SS_HC_KARDEX1_FE.UsuarioCreacion,
				SS_HC_KARDEX1_FE.FechaCreacion,
				SS_HC_KARDEX1_FE.UsuarioModificacion,
				SS_HC_KARDEX1_FE.FechaModificacion,
				SS_HC_KARDEX1_FE.Accion,
				SS_HC_KARDEX1_FE.Version
				from SS_HC_KARDEX1_FE
				left join SS_HC_Medicamento_Kardex on (SS_HC_KARDEX1_FE.UnidadReplicacion = SS_HC_Medicamento_Kardex.UnidadReplicacion
				and SS_HC_KARDEX1_FE.IdEpisodioAtencion=SS_HC_Medicamento_Kardex.IdEpisodioAtencion
				and SS_HC_KARDEX1_FE.IdPaciente = SS_HC_Medicamento_Kardex.IdPaciente
				and SS_HC_KARDEX1_FE.EpisodioClinico = SS_HC_Medicamento_Kardex.EpisodioClinico )
			where SS_HC_Medicamento_Kardex.UnidadReplicacion=@UnidadReplicacion and
				SS_HC_Medicamento_Kardex.IdEpisodioAtencion=@IdEpisodioAtencion and
				SS_HC_Medicamento_Kardex.IdPaciente=@IdPaciente and
				SS_HC_Medicamento_Kardex.EpisodioClinico=@EpisodioClinico and
				(Hora0=1 or Hora1=1 or Hora2=1 or Hora3=1 or Hora4=1 or Hora5=1 or Hora6=1 or Hora7=1 
				or Hora8=1 or Hora9=1 or Hora10=1 or Hora11=1 or Hora12=1 or Hora13=1 or Hora14=1 or Hora15=1
				or Hora16=1 or Hora17=1 or Hora18=1 or Hora19=1 or Hora20=1 or Hora21=1 or Hora22=1 or Hora23=1)
			END		 	 
END


GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_KardexEnfermeria]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_KardexEnfermeria]
	@UnidadReplicacion  char(4) ,	
	@IdEpisodioAtencion bigint,
	@IdPaciente int,
	@EpisodioClinico int,
	@IdOrdenAtencion  int ,	
	@Observacion  varchar(250),	
	@Estado int,
	@UsuarioCreacion varchar(25),
	@FechaCreacion datetime,
	@UsuarioModificacion varchar(25),
	@FechaModificacion datetime,
	@Accion varchar(50),
	@Version varchar(50)
	
AS
BEGIN
	DECLARE @IdOrdenAtencionID as INTEGER/*,@NumeroDocumentoID AS VARCHAR(8),@NumeroDocumentoN AS INTEGER*/
	IF @Accion = 'NUEVO'
		BEGIN
			SELECT @IdOrdenAtencionID = ISNULL(MAX(IdOrdenAtencion),0)+1 FROM SS_HC_KardexEnfermeria;

			INSERT INTO SS_HC_KardexEnfermeria(UnidadReplicacion,IdEpisodioAtencion,IdPaciente,EpisodioClinico,IdOrdenAtencion,Observacion,Estado,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,Accion,Version)
			VALUES (@UnidadReplicacion,@IdEpisodioAtencion,@IdPaciente,@EpisodioClinico,@IdOrdenAtencionID,
			@Observacion,@Estado,@UsuarioCreacion,@FechaCreacion,@UsuarioModificacion,@FechaModificacion,@Accion,@Version)
			
			SELECT @IdOrdenAtencionID;
		END
		IF @Accion = 'UPDATE'
		BEGIN
			
			UPDATE SS_HC_KardexEnfermeria
			SET Observacion=@Observacion,			
			Estado=@Estado,
			UsuarioModificacion=@UsuarioModificacion,
			FechaModificacion=@FechaModificacion,
			Accion=@Accion,
			Version=@Version
			WHERE UnidadReplicacion=@UnidadReplicacion AND 
			IdEpisodioAtencion=@IdEpisodioAtencion AND 
			IdPaciente=@IdPaciente AND 
			EpisodioClinico= @EpisodioClinico 
			
			SELECT IdOrdenAtencion from SS_HC_KardexEnfermeria WHERE UnidadReplicacion=@UnidadReplicacion AND 
			IdEpisodioAtencion=@IdEpisodioAtencion AND 
			IdPaciente=@IdPaciente AND 
			EpisodioClinico= @EpisodioClinico
		END
		IF @Accion = 'UPDATEX'
		BEGIN
			
			UPDATE SS_HC_KardexEnfermeria
			SET 
			UsuarioModificacion=@UsuarioModificacion,
			FechaModificacion=@FechaModificacion,	
			Version=@Version
			WHERE UnidadReplicacion=@UnidadReplicacion AND 
			IdEpisodioAtencion=@IdEpisodioAtencion AND 
			IdPaciente=@IdPaciente AND 
			EpisodioClinico= @EpisodioClinico
			
			SELECT IdOrdenAtencion from SS_HC_KardexEnfermeria WHERE UnidadReplicacion=@UnidadReplicacion AND 
			IdEpisodioAtencion=@IdEpisodioAtencion AND 
			IdPaciente=@IdPaciente AND 
			EpisodioClinico= @EpisodioClinico
		END
	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_KardexEnfermeriaDetalle]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_KardexEnfermeriaDetalle]
	@UnidadReplicacion  char(4) ,	
	@IdEpisodioAtencion bigint,
	@IdPaciente int,
	@EpisodioClinico int,	
	@IdOrdenAtencion int,
	@Secuencia int,
	@UnidadReplicacionReferencia char(4),
	@IdEpisodioAtencionReferencia bigint,
	@IdPacienteReferencia int,
	@EpisodioClinicoReferencia int,
	@Fecha datetime,	
	@FechaCorte	datetime,
	@HoraInicioProg	datetime,
	@HorasProgramadas varchar(250),
	@HorasSuministradas varchar(250),
	@EnfermeraSuministro varchar(250),
	@Linea char(6),
	@Familia char(6),
	@SubFamilia char(6),
	@TipoComponente char(1),
	@CodigoComponente varchar(25),
	@SituacionRegistro int,
	@GrupoMedicamento int,
	@Observacion varchar(250),
	@Estado int,
	@UsuarioCreacion varchar(25),
	@FechaCreacion datetime,
	@UsuarioModificacion varchar(25),
	@FechaModificacion datetime,
	@Accion varchar(50),
	@Version varchar(50)
	
AS
BEGIN
	DECLARE @IdSolicitudProductoID as INTEGER,@NumeroDocumentoID AS VARCHAR(8),@NumeroDocumentoN AS INTEGER, @FechaCorteNew as datetime
		
	IF @Accion = 'NUEVO'
		BEGIN				
						
			INSERT INTO SS_HC_KardexEnfermeriaDetalle(UnidadReplicacion,IdEpisodioAtencion,IdPaciente,EpisodioClinico,IdOrdenAtencion,
			Secuencia,UnidadReplicacionReferencia,IdEpisodioAtencionReferencia,IdPacienteReferencia,EpisodioClinicoReferencia,Fecha,FechaCorte,HoraInicioProg,HorasProgramadas,HorasSuministradas,EnfermeraSuministro, Linea,Familia,SubFamilia,TipoComponente,CodigoComponente,SituacionRegistro,GrupoMedicamento,Observacion,Estado,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,Accion,Version)
			VALUES (@UnidadReplicacion,@IdEpisodioAtencion,@IdPaciente,@EpisodioClinico,@IdOrdenAtencion,
			@Secuencia,@UnidadReplicacionReferencia,@IdEpisodioAtencionReferencia,@IdPacienteReferencia,@EpisodioClinicoReferencia,@Fecha,@FechaCorte,@HoraInicioProg,@HorasProgramadas,@HorasSuministradas,@EnfermeraSuministro,@Linea,@Familia,@SubFamilia,@TipoComponente,@CodigoComponente,@SituacionRegistro,@GrupoMedicamento,@Observacion,@Estado,@UsuarioCreacion,@FechaCreacion,@UsuarioModificacion,@FechaModificacion,@Accion,@Version)
			
			SELECT @IdOrdenAtencion;
		END	
		
	IF @Accion = 'UPDATE'
		BEGIN
		
	set @FechaCorteNew =(	select top 1 PD.FechaCorte  from SS_HC_KardexEnfermeriaDetalle PD where
	PD.UnidadReplicacion=@UnidadReplicacion and
	PD.IdEpisodioAtencion=@IdEpisodioAtencion and
	PD.EpisodioClinico=@EpisodioClinico and
	PD.IdPaciente=@IdPaciente and
	PD.Secuencia=@Secuencia and
	PD.CodigoComponente=@CodigoComponente
	and
	DAY(PD.Fecha)=DAY(@Fecha))
	
		if(@FechaCorteNew is null)
		begin
		set @FechaCorteNew=@FechaCorte
		end		
			
		UPDATE SS_HC_KardexEnfermeriaDetalle			
			SET HorasProgramadas=@HorasProgramadas,
			HoraInicioProg=@HoraInicioProg,
			Estado=@Estado,
			UsuarioModificacion=@UsuarioModificacion,
			FechaModificacion=@FechaModificacion,
			FechaCorte=@FechaCorteNew,
			GrupoMedicamento=@GrupoMedicamento,
			Accion=@Accion,			
			Version=@Version
			WHERE UnidadReplicacion=@UnidadReplicacion AND
			IdEpisodioAtencion =@IdEpisodioAtencion AND
			IdPaciente=@IdPaciente AND
			EpisodioClinico = @EpisodioClinico AND
			IdOrdenAtencion=@IdOrdenAtencion AND
			Secuencia=@Secuencia AND
			CodigoComponente=@CodigoComponente and
			DAY(Fecha)=DAY(@Fecha)			
			
			SELECT @IdOrdenAtencion;
		END				

	IF @Accion = 'UPDATEX'
		BEGIN
		
	set @FechaCorteNew =(	select top 1 PD.FechaCorte  from SS_HC_KardexEnfermeriaDetalle PD where
	PD.UnidadReplicacion=@UnidadReplicacion and
	PD.IdEpisodioAtencion=@IdEpisodioAtencion and
	PD.EpisodioClinico=@EpisodioClinico and
	PD.IdPaciente=@IdPaciente and
	PD.Secuencia=@Secuencia and
	PD.CodigoComponente=@CodigoComponente
	and
	DAY(PD.Fecha)=DAY(@Fecha))
	
		if(@FechaCorteNew is null)
		begin
		set @FechaCorteNew=@FechaCorte
		end		
			
		UPDATE SS_HC_KardexEnfermeriaDetalle			
			SET EnfermeraSuministro=@EnfermeraSuministro,
			HorasSuministradas=@HorasSuministradas,
			UsuarioModificacion=@UsuarioModificacion,
			FechaModificacion=@FechaModificacion,
			FechaCorte=@FechaCorteNew,
			Version=@Version
			WHERE UnidadReplicacion=@UnidadReplicacion AND
			IdEpisodioAtencion =@IdEpisodioAtencion AND
			IdPaciente=@IdPaciente AND
			EpisodioClinico = @EpisodioClinico AND
			IdOrdenAtencion=@IdOrdenAtencion AND
			Secuencia=@Secuencia AND
			CodigoComponente=@CodigoComponente and
			DAY(Fecha)=DAY(@Fecha)			
			
			SELECT @IdOrdenAtencion;
		END		
	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_MA_MiscelaneosDetalle]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_MA_MiscelaneosDetalle]
(
	@AplicacionCodigo	char(2) ,
	@CodigoTabla	char(10) ,
	@Compania	char(6) ,
	@CodigoElemento	char(10) ,
	@DescripcionLocal	char(80) ,	
	@DescripcionExtranjera	char(80) ,
	@ValorNumerico	float ,
	@ValorCodigo1	char(300) ,
	@ValorCodigo2	char(300) ,
	@ValorCodigo3	char(300) ,	
	@ValorCodigo4	char(300) ,
	@ValorCodigo5	char(300) ,
	@ValorFecha	datetime ,
	@Estado	char(1) ,
	@UltimoUsuario	varchar(25) ,
	@UltimaFechaModif	datetime ,
	@Timestamp	timestamp ,	
	@RowID	int ,
	@ValorEntero1	int ,
	@ValorEntero2	int ,
	@ValorEntero3	int ,
	@ValorEntero4	int ,
	@ValorEntero5	int ,
	@ValorCodigo6	varchar(25) ,
	@ValorCodigo7	varchar(25) ,
	@ValorEntero6	int ,
	@ValorEntero7	int,	
	@ACCION	varchar(25) 
)

AS
BEGIN
	DECLARE @CONTADOR INT=0
	DECLARE @CONTADOR_AUX01 INT=0
	DECLARE @CONTADOR_AUX02 INT=0
	DECLARE @CONTADOR_AUX03 INT=0
	DECLARE @CONTADOR_AUX04 INT=0
	DECLARE @CONTADOR_AUX05 INT=0
	DECLARE @CONTADOR_AUX06 INT=0
	if(@ACCION = 'BUSCARSERVICIOS')
	begin	
	   Select @CONTADOR_AUX01=  COUNT(*) 
	   From SS_GE_Diagnostico  where  1=1  
	   and (@ValorNumerico is null OR tipofolder = convert(integer,@ValorNumerico))
	   and nombretabla in (SELECT   CM_CO_TablaMaestroConcepto.Concepto  
		FROM          CM_CO_TablaMaestro INNER JOIN  
				CM_CO_TablaMaestroConcepto ON  CM_CO_TablaMaestro.IdTablaMaestro =  CM_CO_TablaMaestroConcepto.IdTablaMaestro INNER JOIN  
				CM_CO_TablaMaestroDetalle ON  CM_CO_TablaMaestro.IdTablaMaestro =  CM_CO_TablaMaestroDetalle.IdTablaMaestro INNER JOIN  
				CM_CO_TablaMaestroDetalleConcepto ON  CM_CO_TablaMaestroConcepto.IdTablaMaestro =  CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro AND   
				CM_CO_TablaMaestroConcepto.IdConcepto =  CM_CO_TablaMaestroDetalleConcepto.IdConcepto AND   
				CM_CO_TablaMaestroDetalle.IdCodigo =  CM_CO_TablaMaestroDetalleConcepto.IdCodigo AND   
				CM_CO_TablaMaestroDetalle.IdTablaMaestro =  CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro  
		WHERE      CM_CO_TablaMaestroDetalle.Codigo =   @ValorCodigo1)  
	  
		Select @CONTADOR_AUX02=  COUNT(*) 
	   From SS_GE_ProcedimientoMedico  where  1=1 --CodigoPadre = @CodigoElemento --and nombretabla='PP000'  
	   and (@ValorNumerico is null OR tipofolder = convert(integer,@ValorNumerico))
	   and nombretabla in (SELECT   CM_CO_TablaMaestroConcepto.Concepto  
		FROM          CM_CO_TablaMaestro INNER JOIN  
				CM_CO_TablaMaestroConcepto ON  CM_CO_TablaMaestro.IdTablaMaestro =  CM_CO_TablaMaestroConcepto.IdTablaMaestro INNER JOIN  
				CM_CO_TablaMaestroDetalle ON  CM_CO_TablaMaestro.IdTablaMaestro =  CM_CO_TablaMaestroDetalle.IdTablaMaestro INNER JOIN  
				CM_CO_TablaMaestroDetalleConcepto ON  CM_CO_TablaMaestroConcepto.IdTablaMaestro =  CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro AND   
				CM_CO_TablaMaestroConcepto.IdConcepto =  CM_CO_TablaMaestroDetalleConcepto.IdConcepto AND   
				CM_CO_TablaMaestroDetalle.IdCodigo =  CM_CO_TablaMaestroDetalleConcepto.IdCodigo AND   
				CM_CO_TablaMaestroDetalle.IdTablaMaestro =  CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro  
		WHERE      CM_CO_TablaMaestroDetalle.Codigo =   @ValorCodigo1)  
	     
		Select @CONTADOR_AUX03=  COUNT(*) 
	   From SS_GE_ProcedimientoMedicoDos  where  1=1 --CodigoPadre = @CodigoElemento --and nombretabla='PD000'  
	   and (@ValorNumerico is null OR tipofolder = convert(integer,@ValorNumerico))
	   and nombretabla in (SELECT   CM_CO_TablaMaestroConcepto.Concepto  
		FROM          CM_CO_TablaMaestro INNER JOIN  
				CM_CO_TablaMaestroConcepto ON  CM_CO_TablaMaestro.IdTablaMaestro =  CM_CO_TablaMaestroConcepto.IdTablaMaestro INNER JOIN  
				CM_CO_TablaMaestroDetalle ON  CM_CO_TablaMaestro.IdTablaMaestro =  CM_CO_TablaMaestroDetalle.IdTablaMaestro INNER JOIN  
				CM_CO_TablaMaestroDetalleConcepto ON  CM_CO_TablaMaestroConcepto.IdTablaMaestro =  CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro AND   
				CM_CO_TablaMaestroConcepto.IdConcepto =  CM_CO_TablaMaestroDetalleConcepto.IdConcepto AND   
				CM_CO_TablaMaestroDetalle.IdCodigo =  CM_CO_TablaMaestroDetalleConcepto.IdCodigo AND   
				CM_CO_TablaMaestroDetalle.IdTablaMaestro =  CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro  
		WHERE      CM_CO_TablaMaestroDetalle.Codigo =   @ValorCodigo1)  

	Select @CONTADOR_AUX04=  COUNT(*) 
	   From WH_ItemMast  where 1=1 -- MedicamentoCodigoPadre = @CodigoElemento --and nombretabla='PD000'  
	   and (@ValorNumerico is null OR tipofolder = convert(integer,@ValorNumerico))
	   and nombretabla in (SELECT   CM_CO_TablaMaestroConcepto.Concepto  
		FROM          CM_CO_TablaMaestro INNER JOIN  
				CM_CO_TablaMaestroConcepto ON  CM_CO_TablaMaestro.IdTablaMaestro =  CM_CO_TablaMaestroConcepto.IdTablaMaestro INNER JOIN  
				CM_CO_TablaMaestroDetalle ON  CM_CO_TablaMaestro.IdTablaMaestro =  CM_CO_TablaMaestroDetalle.IdTablaMaestro INNER JOIN  
				CM_CO_TablaMaestroDetalleConcepto ON  CM_CO_TablaMaestroConcepto.IdTablaMaestro =  CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro AND   
				CM_CO_TablaMaestroConcepto.IdConcepto =  CM_CO_TablaMaestroDetalleConcepto.IdConcepto AND   
				CM_CO_TablaMaestroDetalle.IdCodigo =  CM_CO_TablaMaestroDetalleConcepto.IdCodigo AND   
				CM_CO_TablaMaestroDetalle.IdTablaMaestro =  CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro  
		WHERE      CM_CO_TablaMaestroDetalle.Codigo =   @ValorCodigo1) 
		
	Select @CONTADOR_AUX05=  COUNT(*)	
				   From  SS_HC_CuerpoHumano where 1=1 --CodigoPadre = @CodigoElemento --and nombretabla='PD000'  
				   and (@ValorNumerico is null OR tipofolder = convert(integer,@ValorNumerico))
				   and nombretabla in (SELECT   CM_CO_TablaMaestroConcepto.Concepto  
					FROM          CM_CO_TablaMaestro INNER JOIN  
							CM_CO_TablaMaestroConcepto ON  CM_CO_TablaMaestro.IdTablaMaestro =  CM_CO_TablaMaestroConcepto.IdTablaMaestro INNER JOIN  
							CM_CO_TablaMaestroDetalle ON  CM_CO_TablaMaestro.IdTablaMaestro =  CM_CO_TablaMaestroDetalle.IdTablaMaestro INNER JOIN  
							CM_CO_TablaMaestroDetalleConcepto ON  CM_CO_TablaMaestroConcepto.IdTablaMaestro =  CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro AND   
							CM_CO_TablaMaestroConcepto.IdConcepto =  CM_CO_TablaMaestroDetalleConcepto.IdConcepto AND   
							CM_CO_TablaMaestroDetalle.IdCodigo =  CM_CO_TablaMaestroDetalleConcepto.IdCodigo AND   
							CM_CO_TablaMaestroDetalle.IdTablaMaestro =  CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro  
					WHERE      CM_CO_TablaMaestroDetalle.Codigo =   @ValorCodigo1)  					       				     
		set @CONTADOR= 
			 @CONTADOR_AUX01+
			@CONTADOR_AUX02 +
			@CONTADOR_AUX03	+
			@CONTADOR_AUX04	+
			@CONTADOR_AUX05
			
		select @CONTADOR
	END  	
	--select * from SEGURIDADAUTORIZACIONES
	
END

/*
exec SP_SS_HC_MA_MiscelaneosDetalle
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	
	NULL,
	NULL,
	'CCEP0104',
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,	
	'BUSCARSERVICIOS'	
	
	*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_MA_MiscelaneosDetalle_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE OR ALTER PROCEDURE  [dbo].[SP_SS_HC_MA_MiscelaneosDetalle_LISTAR]
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
 @ValorFecha datetime ,        
 @Estado char(1) ,        
 @UltimoUsuario varchar(100),                 
	@UltimaFechaModif	datetime ,		
	@RowID	int ,
	@ValorEntero1	int ,
	@ValorEntero2	int ,
	@ValorEntero3	int ,
	@ValorEntero4	int ,
	@ValorEntero5	int ,
	@ValorCodigo6	varchar(25) ,
	@ValorCodigo7	varchar(25) ,
	@ValorEntero6	int ,
	@ValorEntero7	int  ,              
 @INICIO   int= null,          
 @NUMEROFILAS int = null ,        
 @ACCION VARCHAR(30)        
)        
        
AS        
BEGIN        

 declare @filtrosFavNum varchar(300) =null        
 DECLARE @TABLA_FILTROSFAVORITOS table         
 (        
  --SECUENCIA   int  NOT NULL   IDENTITY PRIMARY KEY,        
  descripcion varchar(100),        
  idFavorito   int,        
  numeroFavorito   int,          
  ESTADO  char(1)           
 )        
         
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
         
 if(@ACCION = 'ERRORES')        
  BEGIN        
    INSERT INTO @MA_MiscelaneosDetalle(AplicacionCodigo, CodigoTabla,Compania,CodigoElemento, DescripcionLocal, DescripcionExtranjera)        
            
	SELECT 
		'AP' AS Tipo,
		'TABLA' AS Origen,
		'001' AS Codigo,
		sm.CodigoError,
		sm.DescripcionLocal,
		sysmsg.description AS MensajeSistema
	FROM dbo.SS_HC_TableSysMessages sm
	LEFT JOIN master.dbo.sysmessages sysmsg 
		ON sysmsg.error = sm.IDEstandar  
	WHERE sysmsg.msglangid = 3082 AND sm.IDEstandar = @INICIO    
   select * from @MA_MiscelaneosDetalle          
  END        
  
  
   if(@ACCION = 'LISTAR_DEPARTAMENTOS')        
  BEGIN        
 
   select 'WA' as AplicacionCodigo , 'TODOLUGAR' AS CodigoTabla , '999999' as Compania,'1' as CodigoElemento,
   'Peru' as DescripcionLocal , DescripcionLarga AS DescripcionExtranjera , null as ValorNumerico ,
   'PER' AS ValorCodigo1 , '12' AS ValorCodigo2 , '1' AS ValorCodigo3 ,  '1' AS ValorCodigo4,
    Departamento AS ValorCodigo5 , null as ValorFecha,  null as Estado ,  null as UltimoUsuario,
     null as UltimaFechaModif , null as Timestamp , null as ACCION , 1 as RowID , 
     null as ValorEntero1 , null as ValorEntero2 , null as ValorEntero3 ,  null as ValorEntero4
   , null as ValorEntero5 ,  DescripcionLarga  as ValorCodigo6  ,  null as ValorCodigo7 , null as ValorEntero6 ,
   null as ValorEntero7 , null as MA_MiscelaneosHeader   from Departamento ;        
  END  
  
  if(@ACCION = 'LISTAR_PROVINCIA_DEPARTAMENTO')        
  BEGIN        
    
   select  Provincia as CodigoElemento,DescripcionCorta as ValorCodigo5 from Provincia where Departamento = @RowID; 
           
  END  
      
 if(@ACCION = 'LISTARPAG')        
 begin        
           
  SET @CONTADOR=(SELECT COUNT(*)         
     FROM MA_MiscelaneosDetalle        
     WHERE         
     (@AplicacionCodigo is null OR AplicacionCodigo = @AplicacionCodigo)        
     and (@CodigoTabla is null OR CodigoTabla = @CodigoTabla)        
     and (@Compania is null OR Compania = @Compania)        
     and (@CodigoElemento is null OR CodigoElemento = @CodigoElemento)        
     and (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')               
     and (@ESTADO is null OR Estado = @ESTADO)          
     )        
          
  SELECT         
     [AplicacionCodigo]        
      ,[CodigoTabla]        
      ,[Compania]        
      ,[CodigoElemento]        
      ,[DescripcionLocal]        
      ,[DescripcionExtranjera]        
      ,[ValorNumerico]        
      ,[ValorCodigo1]        
      ,[ValorCodigo2]        
      ,[ValorCodigo3]        
      ,[ValorCodigo4]        
      ,[ValorCodigo5]        
      ,[ValorFecha]        
      ,[Estado]        
      ,[UltimoUsuario]        
      ,[UltimaFechaModif]        
      ,[Timestamp]        
      ,[ACCION]        
      ,[RowID]        
      ,[ValorEntero1]        
      ,[ValorEntero2]        
      ,[ValorEntero3]        
      ,[ValorEntero4]        
      ,[ValorEntero5]        
      ,[ValorCodigo6]        
  ,[ValorCodigo7]        
      ,[ValorEntero6]        
      ,[ValorEntero7]             
  FROM (SELECT        
     MA_MiscelaneosDetalle.*                    
      ,@CONTADOR AS Contador,        
            ROW_NUMBER() OVER (ORDER BY CodigoTabla ASC ) AS RowNumber            
     FROM MA_MiscelaneosDetalle        
     WHERE         
     (@AplicacionCodigo is null OR AplicacionCodigo = @AplicacionCodigo)        
     and (@CodigoTabla is null OR CodigoTabla = @CodigoTabla)        
     and (@Compania is null OR Compania = @Compania)        
     and (@CodigoElemento is null OR CodigoElemento = @CodigoElemento)        
     and (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')               
     and (@ESTADO is null OR Estado = @ESTADO)        
     ) AS LISTADO        
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR          
            RowNumber BETWEEN @Inicio  AND @NumeroFilas         
 end        
 else        
 if(@ACCION = 'LISTAR')        
 begin        
          
  SELECT         
   [AplicacionCodigo]        
    ,[CodigoTabla]        
    ,[Compania]        
    ,[CodigoElemento]        
    ,[DescripcionLocal]        
    ,[DescripcionExtranjera]        
    ,[ValorNumerico]        
    ,[ValorCodigo1]        
    ,[ValorCodigo2]        
    ,[ValorCodigo3]        
    ,[ValorCodigo4]        
    ,[ValorCodigo5]        
    ,[ValorFecha]        
    ,[Estado]        
    ,[UltimoUsuario]        
    ,[UltimaFechaModif]        
    ,[Timestamp]        
    ,[ACCION]        
    ,[RowID]        
    ,[ValorEntero1]        
    ,[ValorEntero2]        
    ,[ValorEntero3]        
    ,[ValorEntero4]        
    ,[ValorEntero5]        
    ,[ValorCodigo6]        
    ,[ValorCodigo7]        
    ,[ValorEntero6]        
    ,[ValorEntero7]            
     FROM MA_MiscelaneosDetalle        
     WHERE         
     (@AplicacionCodigo is null OR AplicacionCodigo = @AplicacionCodigo)        
     and (@CodigoTabla is null OR CodigoTabla = @CodigoTabla)        
     and (@Compania is null OR Compania = @Compania)        
     and (@CodigoElemento is null OR CodigoElemento = @CodigoElemento)        
     and (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')               
     and (@ESTADO is null OR Estado = @ESTADO)
      
 end    
     else        
         
  IF @ACCION ='BUSCARLINEAFAMILIA'          
  BEGIN      
   if(@CodigoTabla = 'MM000')      
     insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico,ValorCodigo1,ValorCodigo2,ValorEntero2)          
      Select   'CG','99999', Familia,SubFamilia ,   ltrim(rtrim(DescripcionLocal))+'|['+ ltrim(rtrim(Linea))+'-'+ltrim(rtrim(Familia))+'-'+ltrim(rtrim(SubFamilia))+']'           
		as nombre, '1' as  tipofolder  ,Linea,  'ITEMS'  ,Linea       
		From WH_ClaseSubFamilia          
      where       
     (@ValorCodigo4 is null  OR @ValorCodigo4 =''       
         OR  upper(Linea) = upper(@ValorCodigo4))      
    and (@ValorCodigo5 is null  OR @ValorCodigo5 =''       
         OR  upper(Familia) = upper(@ValorCodigo5))        
    and (@ValorCodigo2 is null  OR @ValorCodigo2 =''       
         OR  upper(DescripcionLocal)  like '%'+upper(@ValorCodigo2)+'%')         
			and exists(select 1 from WH_ItemMast where WH_ItemMast.Linea = WH_ClaseSubFamilia.Linea        
			 and WH_ItemMast.Familia = WH_ClaseSubFamilia.Familia        
			 and WH_ItemMast.SubFamilia = WH_ClaseSubFamilia.SubFamilia         
			 and WH_ItemMast.UnidadCodigo is not null)        
			           
	insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico,ValorCodigo1,ValorCodigo2,ValorEntero2)       			                    
		-- melisa - se agrego el DISTINCT 10/10/2020
		SELECT DISTINCT 	 'CG' AplicacionCodigo ,
		(select DescripcionCorta from 
		UnidadesMast where UnidadCodigo = WH_ItemMast.UnidadCodigo)
		
		Compania,Familia CodigoTabla, rtrim(WH_ItemMast.SubFamilia) +'|'+ rtrim(WH_ItemMast.Item) Item, --CodigoElemento = Item --jordan mateo,  
			 ltrim(rtrim(DescripcionLocal))+'|['+ ltrim(rtrim(Linea))+'-'+ltrim(rtrim(Familia))+'-'+ltrim(rtrim(SubFamilia))+ '-'+LTRIM(RTRIM(Item))+']'  as DescripcionLocal ,
			'1' as  tipofolder ,
			Linea, 'ITEMS' ValorCodigo2,Item
			--,WH_ItemMast.Familia,WH_ItemMast.SubFamilia		
	FROM WH_ItemMast,SS_HC_FavoritoDetalle s
				    where       
			    (@ValorCodigo4 is null  OR @ValorCodigo4 =''    OR  upper(Linea) = upper(@ValorCodigo4))      
			and (@ValorCodigo5 is null  OR @ValorCodigo5 =''    OR  upper(Familia) = upper(@ValorCodigo5))        
			and (@ValorCodigo2 is null  OR @ValorCodigo2 =''    OR  upper(DescripcionLocal)  like '%'+upper(@ValorCodigo2)+'%') 
			and (Estado ='A') --jordan mateo
		
			 --------------  
        
   insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, ValorEntero2, CodigoTabla,ValorCodigo1,CodigoElemento , DescripcionLocal, ValorNumerico)        
   Select  'CG','99999',IdDiagnostico as ID,isnull(NombreTabla,'UN') ,isnull(CodigoPadre,'UN'), isnull(CodigoDiagnostico,'UN'), case tipofolder           
   when 1 then  ltrim(rtrim(Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),IdDiagnostico)))+']'           
   else ltrim(rtrim(Nombre)) end as nombre, tipofolder           
   From SS_GE_Diagnostico         
   where tipofolder = 1       
  and (@CodigoTabla is null or NombreTabla = @CodigoTabla)  
  and (@ValorCodigo2 is null  OR @ValorCodigo2 =''       
         OR  upper(Descripcion)  like '%'+upper(@ValorCodigo2)+'%')
          
   --select * from SS_GE_Diagnostico where tipoFolder = 1        
   insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, ValorEntero2, CodigoTabla,ValorCodigo1,   CodigoElemento , DescripcionLocal, ValorNumerico)          
   Select  'CG','99999', IdProcedimiento,isnull(NombreTabla,'UN'), isnull(CodigoPadre,'UN'),isnull(CodigoProcedimiento,'UN'),  case tipofolder           
   when 1 then  ltrim(rtrim(Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),IdProcedimiento)))+']'          
   else ltrim(rtrim(Nombre)) end as nombre,  tipofolder           
   From SS_GE_ProcedimientoMedico          
   where tipofolder = 1        
  and (@CodigoTabla is null or NombreTabla = @CodigoTabla)   
   and (@ValorCodigo2 is null  OR @ValorCodigo2 =''       
         OR  upper(Nombre)  like '%'+upper(@ValorCodigo2)+'%')    
 --------------------        
            
   insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, ValorEntero2, CodigoTabla,ValorCodigo1,   CodigoElemento , DescripcionLocal, ValorNumerico)          
   Select  'CG','99999', IdProcedimientoDos,isnull(NombreTabla,'UN'), isnull(CodigoPadre,'UN'),isnull(CodigoProcedimientoDos,'UN') ,  case tipofolder           
   when 1 then  ltrim(rtrim(Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),IdProcedimientoDos)))+']'          
   else ltrim(rtrim(Nombre)) end as nombre,  tipofolder           
   From SS_GE_ProcedimientoMedicoDos         
   where tipofolder = 1         
  and (@CodigoTabla is null or NombreTabla = @CodigoTabla) 
  and (@ValorCodigo2 is null  OR @ValorCodigo2 =''       
  OR  upper(Nombre)  like '%'+upper(@ValorCodigo2)+'%')  
 -----------CM_CO_Componente---------         
    insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, ValorEntero2, CodigoTabla,ValorCodigo1,   CodigoElemento , DescripcionLocal, ValorNumerico)          
   Select  'CG','99999', IdClasificacion,isnull(NombreTabla,'UN'), isnull(CodigoComponente,'UN'),isnull(CodigoComponente,'UN') , 
    ltrim(rtrim(CM_CO_Componente.Nombre))+'|['+CodigoComponente+']'         
     as nombre,  '1'           
   From CM_CO_Componente         
   where /*CodigoComponente = 1         
  and*/ (@CodigoTabla is null or NombreTabla = @CodigoTabla) 
  and (@ValorCodigo2 is null  OR @ValorCodigo2 =''       
  OR  upper(Nombre)  like '%'+upper(@ValorCodigo2)+'%')  


 ------------------------------------------
        
 insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania,ValorEntero2, CodigoTabla,ValorCodigo1,   CodigoElemento , DescripcionLocal, ValorNumerico)          
  Select  'CG','99999', IdCuerpoHumano,isnull(NombreTabla,'UN'), isnull(CodigoPadre,'UN'),isnull(Codigo,'UN') ,  case tipofolder           
  when 1 then  ltrim(rtrim(Descripcion))+'|['+ ltrim(rtrim(Convert(varchar(10),IdCuerpoHumano)))+']'          
  else ltrim(rtrim(Descripcion)) end as nombre,  tipofolder           
  From  SS_HC_CuerpoHumano  
  where tipofolder = 1       
  and (@CodigoTabla is null or NombreTabla = @CodigoTabla) 
   and (@ValorCodigo2 is null  OR @ValorCodigo2 =''       
  OR  upper(Descripcion)  like '%'+upper(@ValorCodigo2)+'%')      
  --and (@ValorCodigo2 IS NULL OR Upper(rtrim(Descripcion)) LIKE '%' + Upper(rtrim(@ValorCodigo2)) + '%' )         
  select @CONTADOR = COUNT(*) from @MA_MiscelaneosDetalle        
          
  SELECT         
     [AplicacionCodigo]        
      ,[CodigoTabla]        
      ,[Compania]        
      ,[CodigoElemento]        
      ,[DescripcionLocal]        
      ,[DescripcionExtranjera]        
      ,[ValorNumerico]        
      ,[ValorCodigo1]        
      ,[ValorCodigo2]        
      ,[ValorCodigo3]        
      ,[ValorCodigo4]        
      ,[ValorCodigo5]        
      ,[ValorFecha]        
      ,[Estado]        
      ,[UltimoUsuario]        
      ,[UltimaFechaModif]        
      ,[Timestamp]        
      ,[ACCION]        
      ,[RowID]        
      ,[ValorEntero1]        
      ,[ValorEntero2]        
      ,[ValorEntero3]        
      ,[ValorEntero4]        
      ,[ValorEntero5]        
      ,[ValorCodigo6]        
      ,[ValorCodigo7]        
      ,[ValorEntero6]        
      ,[ValorEntero7]                       
  FROM (SELECT        
     detalles.*                    
     ,--@CONTADOR AS Contador,        
            ROW_NUMBER() OVER (ORDER BY CodigoTabla ASC ) AS RowNumber            
     from @MA_MiscelaneosDetalle  as detalles           
     --where @CodigoTabla = CodigoTabla      
        
     ) AS LISTADO        
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR          
            RowNumber BETWEEN @Inicio  AND @NumeroFilas        
   
             
  END     
 else        
  IF @ACCION ='BUSCARSERVICIOSFAVORITOS'          
  BEGIN      
       
     insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico,ValorCodigo1,ValorCodigo2)          
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
          
            
   insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, ValorEntero2, CodigoTabla,ValorCodigo1,CodigoElemento , DescripcionLocal, ValorNumerico)          
   Select  'CG','99999',IdDiagnostico as ID,isnull(NombreTabla,'UN') ,isnull(CodigoPadre,'UN'), isnull(CodigoDiagnostico,'UN'), case tipofolder           
   when 1 then  ltrim(rtrim(Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),IdDiagnostico)))+']'           
   else ltrim(rtrim(Nombre)) end as nombre, tipofolder           
   From SS_GE_Diagnostico          
   where tipofolder = 1       
  and (@CodigoTabla is null or NombreTabla = @CodigoTabla)      
          
   --select * from SS_GE_Diagnostico where tipoFolder = 1        
   insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, ValorEntero2, CodigoTabla,ValorCodigo1,   CodigoElemento , DescripcionLocal, ValorNumerico)          
   Select  'CG','99999', IdProcedimiento,isnull(NombreTabla,'UN'), isnull(CodigoPadre,'UN'),isnull(CodigoProcedimiento,'UN'),  case tipofolder           
   when 1 then  ltrim(rtrim(Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),IdProcedimiento)))+']'          
   else ltrim(rtrim(Nombre)) end as nombre,  tipofolder           
   From SS_GE_ProcedimientoMedico          
   where tipofolder = 1        
  and (@CodigoTabla is null or NombreTabla = @CodigoTabla)       
 --------------------        
            
   insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, ValorEntero2, CodigoTabla,ValorCodigo1,   CodigoElemento , DescripcionLocal, ValorNumerico)          
   Select  'CG','99999', IdProcedimientoDos,isnull(NombreTabla,'UN'), isnull(CodigoPadre,'UN'),isnull(CodigoProcedimientoDos,'UN') ,  case tipofolder           
   when 1 then  ltrim(rtrim(Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),IdProcedimientoDos)))+']'          
   else ltrim(rtrim(Nombre)) end as nombre,  tipofolder           
   From SS_GE_ProcedimientoMedicoDos         
   where tipofolder = 1         
  and (@CodigoTabla is null or NombreTabla = @CodigoTabla)      
 --------------------         
        
 insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania,ValorEntero2, CodigoTabla,ValorCodigo1,   CodigoElemento , DescripcionLocal, ValorNumerico)          
  Select  'CG','99999', IdCuerpoHumano,isnull(NombreTabla,'UN'), isnull(CodigoPadre,'UN'),isnull(Codigo,'UN') ,  case tipofolder           
  when 1 then  ltrim(rtrim(Descripcion))+'|['+ ltrim(rtrim(Convert(varchar(10),IdCuerpoHumano)))+']'          
  else ltrim(rtrim(Descripcion)) end as nombre,  tipofolder           
  From  SS_HC_CuerpoHumano         
  where tipofolder = 1       
  and (@CodigoTabla is null or NombreTabla = @CodigoTabla)      
  --and (@ValorCodigo2 IS NULL OR Upper(rtrim(Descripcion)) LIKE '%' + Upper(rtrim(@ValorCodigo2)) + '%' )         
  select @CONTADOR = COUNT(*) from @MA_MiscelaneosDetalle        
          
  SELECT         
     [AplicacionCodigo]        
      ,[CodigoTabla]        
      ,[Compania]        
      ,[CodigoElemento]        
      ,[DescripcionLocal]        
      ,[DescripcionExtranjera]        
      ,[ValorNumerico]        
      ,[ValorCodigo1]        
      ,[ValorCodigo2]        
      ,[ValorCodigo3]        
      ,[ValorCodigo4]        
      ,[ValorCodigo5]        
      ,[ValorFecha]        
      ,[Estado]        
      ,[UltimoUsuario]        
      ,[UltimaFechaModif]        
      ,[Timestamp]        
      ,[ACCION]        
      ,[RowID]        
      ,[ValorEntero1]        
      ,[ValorEntero2]        
      ,[ValorEntero3]        
      ,[ValorEntero4]        
      ,[ValorEntero5]        
      ,[ValorCodigo6]        
      ,[ValorCodigo7]        
      ,[ValorEntero6]        
      ,[ValorEntero7]                       
  FROM (SELECT        
     detalles.*                    
     ,--@CONTADOR AS Contador,        
            ROW_NUMBER() OVER (ORDER BY CodigoTabla ASC ) AS RowNumber            
     from @MA_MiscelaneosDetalle  as detalles           
     --where @CodigoTabla = CodigoTabla      
        
     ) AS LISTADO        
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR          
            RowNumber BETWEEN @Inicio  AND @NumeroFilas        
                             
             
  END           
  else        
 if(@ACCION = 'BUSCARSERVICIOS' AND (@CodigoTabla= 'MM000' OR @CodigoTabla= '0000'))        
   begin   
		 if(@ValorCodigo1 ='ACTIVO' and isnull(len(@ValorCodigo3),0) > 3)        
		 begin        
		   set @filtrosFavNum=@ValorCodigo3        
		   --set @grupos = 'R1_1y R1_2y R1_3y R1_4y R1_2'                 
		   set @filtrosFavNum = REPLACE(@filtrosFavNum,'R','Select ')        
		   set @filtrosFavNum = REPLACE(@filtrosFavNum,'y',' union ')        
		   set @filtrosFavNum = REPLACE(@filtrosFavNum,'_',' , ')        
		   set @filtrosFavNum = REPLACE(@filtrosFavNum,'yx',' ')        
		   set @filtrosFavNum = REPLACE(@filtrosFavNum,'union x',' ')        
		   --set @grupos = 'select 13,21 union select 22,25 union select 26,30 union select 31,40'        
		   insert into @TABLA_FILTROSFAVORITOS (idFavorito,numeroFavorito)        
		   EXEC(  @filtrosFavNum )                  
		 end    
		-- Medicamentos             
		if(@ValorCodigo1='ACTIVO' ) --FAVORITOS ACTIVOS  
		begin  
			insert into @MA_MiscelaneosDetalle 
			(AplicacionCodigo,
			 Compania,
			  CodigoTabla, 
			  CodigoElemento , 
			  DescripcionLocal, 
			  ValorNumerico,
			  ValorEntero1,
			 ValorEntero2,
			 ValorEntero3,
			 ValorCodigo1,
			 ValorCodigo2,
			 ValorCodigo3,
			 ValorCodigo4,
			 ValorCodigo7
			 ,ValorEntero4
			 )   
			      			
			  Select   
			  'CG',
			  '',
			   Familia,
			   SubFamilia ,
			ltrim(rtrim(DescripcionLocal))+'|['+ ltrim(rtrim(Linea))+'-'+ltrim(rtrim(Familia))+'-'+ltrim(rtrim(SubFamilia))+']'  as nombre,
			'1' as  tipofolder ,
			detalleFav.IdFavorito,
			detalleFav.NumeroFavorito,
			detalleFav.ValorId,
			WH_ClaseSubFamilia.Linea,
			WH_ClaseSubFamilia.Familia,
			WH_ClaseSubFamilia.SubFamilia,
			detalleFav.ValorTexto4, 
			Tipo = 'DCI'
			,isnull(SS_SG_RestriccionContrato.IndicadorEps,2)
			From WH_ClaseSubFamilia  
			 ----------------  
			 --select * frlaseSubFamilia
			 --select * from SS_SG_RestriccionContrato
			 --select * from SS_HC_FavoritoDetalle
			 
			INNER JOIN  SS_HC_FavoritoDetalle detalleFav  
			 on(( @ValorCodigo1='ACTIVO')  
			and ( 
				rtrim(WH_ClaseSubFamilia.Linea) = detalleFav.ValorTexto5  
				and rtrim(WH_ClaseSubFamilia.Familia) = detalleFav.ValorTexto2  
				and rtrim(WH_ClaseSubFamilia.SubFamilia) = detalleFav.ValorTexto3  
				and 'ITEMS' = detalleFav.ValorTexto4  
				and detalleFav.numeroFavorito in (select NumeroFavorito   
					from @TABLA_FILTROSFAVORITOS AUX where detalleFav.IdFavorito = AUX.idFavorito
					)   
				and detalleFav.IdFavorito in (select idFavorito   
					from @TABLA_FILTROSFAVORITOS AUX where detalleFav.NumeroFavorito = AUX.numeroFavorito)   
				)   
			 )             
		   ---------------  OBTENER INDICADOR EPS-----------
			LEFT JOIN SS_SG_RestriccionContrato ON(			
			SS_SG_RestriccionContrato.UnidadReplicacion=@ValorCodigo6
			and SS_SG_RestriccionContrato.IdContrato=@ValorEntero1
			and SS_SG_RestriccionContrato.TipoComponente='A'  --Artículo
			and rtrim(SS_SG_RestriccionContrato.Componente)=rtrim(WH_ClaseSubFamilia.SubFamilia)	   		
		   	)
		   	----------------------------------------------------
			where (@DescripcionLocal is null  OR @DescripcionLocal ='' 	 OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')         
			and (@CodigoElemento is null  OR @CodigoElemento =''		 OR  upper(SubFamilia) like '%'+upper(@CodigoElemento)+'%')        
			and (@ValorCodigo4 is null  OR @ValorCodigo4 =''  			 OR  upper(Linea) = upper(@ValorCodigo4))        
			and (@ValorCodigo5 is null  OR @ValorCodigo5 =''   			 OR  upper(Familia) = upper(@ValorCodigo5))        
			and exists(select 1 from WH_ItemMast where WH_ItemMast.Linea = WH_ClaseSubFamilia.Linea        
			 and WH_ItemMast.Familia = WH_ClaseSubFamilia.Familia        
			 and WH_ItemMast.SubFamilia = WH_ClaseSubFamilia.SubFamilia         
			 and WH_ItemMast.UnidadCodigo is not null)  
			 
			   
			 
			 -----------TIPO MEDICINAS------------
			insert into @MA_MiscelaneosDetalle 
			(AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico
			,ValorEntero1,ValorEntero2,ValorEntero3
			,ValorCodigo1,ValorCodigo2,ValorCodigo3
			,ValorCodigo4,ValorCodigo7
			,ValorEntero4
			)          			                    
			SELECT 
			 'CG',(select DescripcionCorta from UnidadesMast where UnidadCodigo = WH_ItemMast.UnidadCodigo),Familia, Item = WH_ItemMast.Item,  ltrim(rtrim(DescripcionLocal))+'|['+ ltrim(rtrim(Linea))+'-'+ltrim(rtrim(Familia))+'-'+ltrim(rtrim(SubFamilia))+ '-'+LTRIM(RTRIM(WH_ItemMast.Item))+']'  as nombre,'1' as  tipofolder ,
			 detalleFav.IdFavorito,detalleFav.NumeroFavorito,detalleFav.ValorId            
			 ,WH_ItemMast.Linea,WH_ItemMast.Familia,WH_ItemMast.SubFamilia
			,'ITEMS'  ,   Tipo = 'MED'
			,isnull(SS_SG_RestriccionContrato.IndicadorEps,2)
			FROM WH_ItemMast
			 --------------  
			 inner JOIN  SS_HC_FavoritoDetalle detalleFav  
			 on(( @ValorCodigo1='ACTIVO')  
			and ( 
				ltrim(WH_ItemMast.Linea) = detalleFav.ValorTexto5  
				and rtrim(WH_ItemMast.Familia) = detalleFav.ValorTexto2  
				and (rtrim(WH_ItemMast.SubFamilia) +'|'	+ rtrim(WH_ItemMast.Item)) = rtrim(detalleFav.ValorTexto3)
				and 'ITEMS' = detalleFav.ValorTexto4  
				and detalleFav.numeroFavorito in (select NumeroFavorito   
					from @TABLA_FILTROSFAVORITOS AUX where detalleFav.IdFavorito = AUX.idFavorito
					)   
				and detalleFav.IdFavorito in (select idFavorito   
					from @TABLA_FILTROSFAVORITOS AUX where detalleFav.NumeroFavorito = AUX.numeroFavorito)   
				)   
			 )             
		   ---------------  OBTENER INDICADOR EPS-----------
			LEFT JOIN SS_SG_RestriccionContrato ON(			
			SS_SG_RestriccionContrato.UnidadReplicacion=@ValorCodigo6
			and SS_SG_RestriccionContrato.IdContrato=@ValorEntero1
			and SS_SG_RestriccionContrato.TipoComponente='A'  --Artículo
			and rtrim(SS_SG_RestriccionContrato.Componente)=rtrim(WH_ItemMast.Item)	   		
		   	)
		   	----------------------------------------------------
			WHERE 
			    (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')         
			and (@CodigoElemento is null  OR @CodigoElemento =''      OR  upper(WH_ItemMast.Item) like '%'+upper(@CodigoElemento)+'%')        
			and (@ValorCodigo4 is null  OR @ValorCodigo4 =''          OR  upper(Linea) = upper(@ValorCodigo4))        
			and (@ValorCodigo5 is null  OR @ValorCodigo5 =''          OR  upper(Familia) = upper(@ValorCodigo5))        
			AND WH_ItemMast.Estado = 'A'								
			--WH_ItemMast.Linea IN ('04', '13')
				
								
		end
		else		
		begin
		   --TIPO DCI
		  declare @Stock int
		   set @Stock=0		   
		   if (@ValorEntero7!=null or @ValorEntero7!='')
				begin
				set @Stock= @ValorEntero7
				end
			insert into @MA_MiscelaneosDetalle 
			(AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico
			,ValorCodigo1,ValorCodigo2,ValorCodigo3			
			,ValorCodigo4,ValorCodigo7
			,ValorEntero4
			,UltimoUsuario	--- almacen		--ANGEL15
	
			)  
		   
			  Select   'CG','', Familia,SubFamilia ,   ltrim(rtrim(DescripcionLocal))+'|['+ ltrim(rtrim(Linea))+'-'+ltrim(rtrim(Familia))+'-'+ltrim(rtrim(SubFamilia))+']' as nombre, '1' as  tipofolder ,
				Linea,Familia,SubFamilia
			,'ITEMS' ,   Tipo = 'DCI'
			,isnull(SS_SG_RestriccionContrato.IndicadorEps,2) ,@UltimoUsuario --ANGEL15
			--	,5  --angel 12
			
			  From WH_ClaseSubFamilia          
		   ---------------  OBTENER INDICADOR EPS-----------
			LEFT JOIN SS_SG_RestriccionContrato ON(			
			SS_SG_RestriccionContrato.UnidadReplicacion=@ValorCodigo6
			and SS_SG_RestriccionContrato.IdContrato=@ValorEntero1
			and SS_SG_RestriccionContrato.TipoComponente='A'  --Artículo
			and rtrim(SS_SG_RestriccionContrato.Componente)=rtrim(WH_ClaseSubFamilia.SubFamilia)	   		
		   	)
		 --  	LEFT JOIN SY_SeguridadAutorizaciones ON(			
			--SS_SG_RestriccionContrato.TipoComponente='A'  --Artículo  angel 12 		
		 --  	)
		 --SELECT * FROM SY_SeguridadAutorizaciones WHERE Concepto='1002'   
		 --SELECT * FROM Wh_ItemAlmacen WHERE AlmacenCodigo='1002' AND StockPedido >0           
		   
		   	----------------------------------------------------			  
			  where 
					(@DescripcionLocal is null  OR @DescripcionLocal ='' OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')         
				and (@CodigoElemento is null  OR @CodigoElemento =''     OR  upper(SubFamilia) like '%'+upper(@CodigoElemento)+'%')        
				and (@ValorCodigo4 is null  OR @ValorCodigo4 =''	     OR  upper(Linea) = upper(@ValorCodigo4))        
				and (@ValorCodigo5 is null  OR @ValorCodigo5 =''       	 OR  upper(Familia) = upper(@ValorCodigo5))        
				AND WH_ClaseSubFamilia.Estado = 'A'			  
			and exists(select 1 from WH_ItemMast 
					/*
					inner join SpringSalud_ProduccionHCE.dbo.Wh_ItemAlmacenLote
					on WH_ItemMast.Item collate Modern_Spanish_CI_AS= ClinicaElGolf.dbo.Wh_ItemAlmacenLote.Item collate Modern_Spanish_CI_AS
						*/
					where WH_ItemMast.Linea = WH_ClaseSubFamilia.Linea        
					 and WH_ItemMast.Familia = WH_ClaseSubFamilia.Familia        
					 and WH_ItemMast.SubFamilia = WH_ClaseSubFamilia.SubFamilia         
					 AND WH_ItemMast.Estado = 'A'      
					 and WH_ItemMast.UnidadCodigo is not null
					 /*and SpringSalud_ProduccionHCE.dbo.Wh_ItemAlmacenLote.Item >= @ValorEntero7 */
					 
					--and SY_SeguridadAutorizaciones.Concepto = @ValorEntero6 --angel 12/07/2019
					
				--inicio prueba sin stock
					and WH_ItemMast.Item collate Modern_Spanish_CI_AS in (
						select Item from BDOncologico.dbo.Wh_ItemAlmacenLote XLOTE
						where Item collate Modern_Spanish_CI_AS = WH_ItemMast.Item collate Modern_Spanish_CI_AS
						and (@ValorEntero7 is null or XLOTE.StockActual >= @Stock)
						and (@UltimoUsuario is null or XLOTE.almacencodigo = @UltimoUsuario) --ANGEL15
						--AND XLOTE.AlmacenCodigo='1002' -- angel 12/07/2019
						--AND XLOTE.AlmacenCodigo=@ValorEntero6
						
						)
				--end
			 )    
			 
			 --TIPO MEDICINA
			insert into @MA_MiscelaneosDetalle 
			(AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico
			,ValorCodigo1,ValorCodigo2,ValorCodigo3
			,ValorCodigo4,ValorCodigo7
			,ValorEntero4,UltimoUsuario  --angel15
			,ValorEntero5
			)          			                    
			SELECT 
			 'CG',und.DescripcionCorta,Familia, Item = WH_ItemMast.Item,  ltrim(rtrim(DescripcionLocal))+'|['+ ltrim(rtrim(Linea))+'-'+ltrim(rtrim(Familia))+'-'+ltrim(rtrim(SubFamilia))+ '-'+LTRIM(RTRIM(WH_ItemMast.Item))+ ']'  as nombre,'1' as  tipofolder ,
			WH_ItemMast.Linea,WH_ItemMast.Familia,WH_ItemMast.SubFamilia
			,'ITEMS'  ,   Tipo = 'MED'
			,isnull(SS_SG_RestriccionContrato.IndicadorEps,2),@UltimoUsuario --ANGEL15
			,und.IdUnidadMedida
			FROM WH_ItemMast /*inner join ClinicaElGolf.dbo.Wh_ItemAlmacenLote
				on WH_ItemMast.Item collate Modern_Spanish_CI_AS= ClinicaElGolf.dbo.Wh_ItemAlmacenLote.Item collate Modern_Spanish_CI_AS*/
		   ---------------  OBTENER INDICADOR EPS-----------
		   left join UnidadesMast und  on und.UnidadCodigo = WH_ItemMast.UnidadCodigo
			LEFT JOIN SS_SG_RestriccionContrato ON(			
			SS_SG_RestriccionContrato.UnidadReplicacion=@ValorCodigo6
			and SS_SG_RestriccionContrato.IdContrato=@ValorEntero1
			and SS_SG_RestriccionContrato.TipoComponente='A'  --Artículo
			and rtrim(SS_SG_RestriccionContrato.Componente)=rtrim(WH_ItemMast.Item)	   		
		   	)
		   	----------------------------------------------------			
			WHERE 
			  (@DescripcionLocal is null  OR @DescripcionLocal =''         
			 OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')         
			and (@CodigoElemento is null  OR @CodigoElemento =''         
			 OR  upper(WH_ItemMast.Item) like '%'+upper(@CodigoElemento)+'%')        
			and (@ValorCodigo4 is null  OR @ValorCodigo4 =''         
				 OR  upper(Linea) = upper(@ValorCodigo4))        
			and (@ValorCodigo5 is null  OR @ValorCodigo5 =''         
				 OR  upper(Familia) = upper(@ValorCodigo5))        
			AND WH_ItemMast.Estado = 'A'	
			
			/*and ClinicaElGolf.dbo.Wh_ItemAlmacenLote.Item >= @ValorEntero7*/
    -- inicio prueba sin stock
		and WH_ItemMast.Item collate Modern_Spanish_CI_AS in (
		 select Item from BDOncologico.dbo.Wh_ItemAlmacenLote XLOTE
		 where Item collate Modern_Spanish_CI_AS = WH_ItemMast.Item collate Modern_Spanish_CI_AS
		 and (@ValorEntero7 is null or XLOTE.StockActual >= @Stock)
		and (@UltimoUsuario is null or  XLOTE.almacencodigo  = @UltimoUsuario) --ANGEL15
		 --and XLOTE.StockActual >= @Stock
		 --AND XLOTE.AlmacenCodigo='1002'
		 ) 		
	--end						
			--WH_ItemMast.Linea IN ('04', '13')
			
			--AND WH_ItemMast.DescripcionLocal LIKE @ls_Descripcion

			  -- select * from SS_HC_Medicamento                              		
		end
    -- select * from WH_ClaseSubFamilia        
    select @CONTADOR = COUNT(*) from @MA_MiscelaneosDetalle        
     /*where         
     (        
      (@DescripcionLocal is null  OR @DescripcionLocal =''         
      OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')         
      and ValorNumerico = 1        
      )*/        
      --OR (ValorNumerico <> 1)        
          
  SELECT         
     [AplicacionCodigo]        
      ,[CodigoTabla]        
      ,[Compania]        
      ,[CodigoElemento]        
      ,[DescripcionLocal]        
      ,[DescripcionExtranjera]        
      ,[ValorNumerico]        
      ,[ValorCodigo1]        
      ,[ValorCodigo2]        
      ,[ValorCodigo3]        
      ,[ValorCodigo4]        
      ,[ValorCodigo5]        
      ,[ValorFecha]        
      ,[Estado]        
      ,[UltimoUsuario]        
      ,[UltimaFechaModif]        
      ,[Timestamp]        
      ,[ACCION]        
      ,[RowID]        
      ,[ValorEntero1]        
      ,[ValorEntero2]        
      ,[ValorEntero3]        
      ,ValorEPSX as ValorEntero4
      ,[ValorEntero5]        
      ,[ValorCodigo6]        
      ,[ValorCodigo7]        
      ,[ValorEntero6]        
      ,convert(integer,Contador) as ValorEntero7 --AUX PARA CONTADOR
  FROM (SELECT        
     detalles.*
     ,isnull(detalles.ValorEntero4,0) as ValorEPSX
     ,@CONTADOR AS Contador,        
            ROW_NUMBER() OVER (ORDER BY CodigoTabla ASC ) AS RowNumber            
     from @MA_MiscelaneosDetalle  as detalles           
     /*where         
     (        
      (@DescripcionLocal is null  OR @DescripcionLocal =''         
      OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')         
      and ValorNumerico = 1        
      )*/        
      --OR (ValorNumerico <> 1)        
     ) AS LISTADO        
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR          
            RowNumber BETWEEN @Inicio  AND @NumeroFilas      -- PAGINADO  
                    
   end 

     
 else     
  if(@ACCION = 'BUSCARSERVICIOS' AND (@CodigoTabla= 'NAN0001' OR @CodigoTabla= '0000'))        
   begin  		    
		 
		-- Medicamentos             
		 
		begin  
			insert into @MA_MiscelaneosDetalle 
			(AplicacionCodigo, Compania, CodigoTabla,CodigoElemento , DescripcionLocal, ValorNumerico			 
			 ,ValorCodigo1,ValorCodigo2,ValorCodigo3
			 ,ValorCodigo4,ValorCodigo7
			 
			 )          			
			 Select   'CG','99999', N.IdNanda,N.Codigo , N.Descripcion , '1'  
			 ,D.Descripcion AS DescripcionCorta,N.IdDominioPAE,N.IdNanda           
			 ,N.Orden,N.Estado       					
			 FROM SS_HC_NANDA N inner join  SS_HC_DominioPAE D
			 on N.IdDominioPAE = D.IdDominioPAE	 
								
		end         
        select  * from @MA_MiscelaneosDetalle                         
                    
   end   
   ELSE   
   /*modificado 020217*/
     if(@ACCION = 'BUSCARSERVICIOS' AND (@CodigoTabla= 'DC000' OR @CodigoTabla= '0000'))        
   begin  		    
		 
		-- catalogo de dietas             
		 
		begin  
			insert into @MA_MiscelaneosDetalle 
			(AplicacionCodigo, Compania, CodigoTabla,CodigoElemento , DescripcionLocal, ValorNumerico			 
			 ,ValorCodigo1,ValorCodigo2,ValorCodigo3
			 ,ValorCodigo4,ValorCodigo7
			 
			 )          			
			 Select   'CG','99999', '',N.CodigoDieta , N.Descripcion , '1'  
			 ,'' AS DescripcionCorta,'',''          
			 ,'',''       					
			 FROM SS_HC_CATALOGODIETA N 
			 
			 			
				   				  
			           	 	 					
								
		end  
		
		       
        select @CONTADOR = COUNT(*) from @MA_MiscelaneosDetalle      
		
		SELECT         
     [AplicacionCodigo]        
      ,[CodigoTabla]        
      ,[Compania]        
      ,[CodigoElemento]        
      ,[DescripcionLocal]        
      ,[DescripcionExtranjera]        
      ,[ValorNumerico]        
      ,[ValorCodigo1]        
      ,[ValorCodigo2]        
      ,[ValorCodigo3]        
      ,[ValorCodigo4]        
      ,[ValorCodigo5]        
      ,[ValorFecha]        
      ,[Estado]        
      ,[UltimoUsuario]        
      ,[UltimaFechaModif]        
      ,[Timestamp]        
      ,[ACCION]        
      ,[RowID]        
      ,[ValorEntero1]        
      ,[ValorEntero2]        
      ,[ValorEntero3]        
      ,ValorEPSX as ValorEntero4
      ,[ValorEntero5]        
      ,[ValorCodigo6]        
      ,[ValorCodigo7]        
      ,[ValorEntero6]        
      ,convert(integer,Contador) as ValorEntero7 --AUX PARA CONTADOR
  FROM (SELECT        
     detalles.*
     ,isnull(detalles.ValorEntero4,0) as ValorEPSX
     ,@CONTADOR AS Contador,        
            ROW_NUMBER() OVER (ORDER BY CodigoTabla ASC ) AS RowNumber            
     from @MA_MiscelaneosDetalle  as detalles           
    where         
     (        
      (@DescripcionLocal is null  OR @DescripcionLocal =''         
      OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')         
      and ValorNumerico = 1        
      )     
      --OR (ValorNumerico <> 1)        
     ) AS LISTADO        
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR          
            RowNumber BETWEEN @Inicio  AND @NumeroFilas                           
                    
   end   
   ELSE 
    if(@ACCION = 'BUSCARSERVICIOS' AND (@CodigoTabla= 'PC000' OR @CodigoTabla= '0000'))        
   begin  		    
		 
		-- catalogo de dietas             
		 
		begin  
			insert into @MA_MiscelaneosDetalle 
			(AplicacionCodigo, Compania, CodigoTabla,CodigoElemento , DescripcionLocal, ValorNumerico			 
			 ,ValorCodigo1,ValorCodigo2,ValorCodigo3
			 ,ValorCodigo4,ValorCodigo7
			 
			 )          			
			 Select   'CG','99999', CodigoAntecedentePat,CodigoAntecedentePat ,Descripcion , '1'  
			 ,Descripcion AS DescripcionCorta,'',''          
			 ,'',''       					
			 FROM SS_HC_CATALOGOPAT 
			 
			 			---@ValorCodigo6='CEG'
				   				  
			           	 	 					
								
		end  
		
		       
        select @CONTADOR = COUNT(*) from @MA_MiscelaneosDetalle      
		
		SELECT         
     [AplicacionCodigo]        
      ,[CodigoTabla]        
      ,[Compania]        
      ,[CodigoElemento]        
      ,[DescripcionLocal]        
      ,[DescripcionExtranjera]        
      ,[ValorNumerico]        
      ,[ValorCodigo1]        
      ,[ValorCodigo2]        
      ,[ValorCodigo3]        
      ,[ValorCodigo4]        
      ,[ValorCodigo5]        
      ,[ValorFecha]        
      ,[Estado]        
      ,[UltimoUsuario]        
      ,[UltimaFechaModif]        
      ,[Timestamp]        
      ,[ACCION]        
      ,[RowID]        
      ,[ValorEntero1]        
      ,[ValorEntero2]        
      ,[ValorEntero3]        
      ,ValorEPSX as ValorEntero4
      ,[ValorEntero5]        
      ,[ValorCodigo6]        
      ,[ValorCodigo7]        
      ,[ValorEntero6]        
      ,convert(integer,Contador) as ValorEntero7 --AUX PARA CONTADOR
  FROM (SELECT        
     detalles.*
     ,isnull(detalles.ValorEntero4,0) as ValorEPSX
     ,@CONTADOR AS Contador,        
            ROW_NUMBER() OVER (ORDER BY CodigoTabla ASC ) AS RowNumber            
     from @MA_MiscelaneosDetalle  as detalles           
    where         
     (        
      (@DescripcionLocal is null  OR @DescripcionLocal =''         
      OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')         
      and ValorNumerico = 1        
      )     
      --OR (ValorNumerico <> 1)        
     ) AS LISTADO        
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR          
            RowNumber BETWEEN @Inicio  AND @NumeroFilas                           
                    
   end   

      ELSE -- PARA EMERGENCIA
    if(@ACCION = 'BUSCARSERVICIOS' AND (@CodigoTabla= 'PC000_EMERGENCIA' OR @CodigoTabla= '0000'))        
   begin  		    
		 
		-- catalogo de dietas             
		 
		begin  
			insert into @MA_MiscelaneosDetalle 
			(AplicacionCodigo, Compania, CodigoTabla,CodigoElemento , DescripcionLocal, ValorNumerico			 
			 ,ValorCodigo1,ValorCodigo2,ValorCodigo3
			 ,ValorCodigo4,ValorCodigo7
			 
			 )          			
			 Select   'CG','99999', CodigoAntecedentePat,CodigoAntecedentePat ,Descripcion , '1'  
			 ,Descripcion AS DescripcionCorta,'',''          
			 ,'',''       					
			 FROM SS_HC_CATALOGOPAT where CodigoAntecedentePat in (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,22,25)
			 
			 				  
			           	 	 					
								
		end  
		
		       
        select @CONTADOR = COUNT(*) from @MA_MiscelaneosDetalle      
		
		SELECT         
     [AplicacionCodigo]        
      ,[CodigoTabla]        
      ,[Compania]        
      ,[CodigoElemento]        
      ,[DescripcionLocal]        
      ,[DescripcionExtranjera]        
      ,[ValorNumerico]        
      ,[ValorCodigo1]        
      ,[ValorCodigo2]        
      ,[ValorCodigo3]        
      ,[ValorCodigo4]        
      ,[ValorCodigo5]        
      ,[ValorFecha]        
      ,[Estado]        
      ,[UltimoUsuario]        
      ,[UltimaFechaModif]        
      ,[Timestamp]        
      ,[ACCION]        
      ,[RowID]        
      ,[ValorEntero1]        
      ,[ValorEntero2]        
      ,[ValorEntero3]        
      ,ValorEPSX as ValorEntero4
      ,[ValorEntero5]        
      ,[ValorCodigo6]        
      ,[ValorCodigo7]        
      ,[ValorEntero6]        
      ,convert(integer,Contador) as ValorEntero7 --AUX PARA CONTADOR
  FROM (SELECT        
     detalles.*
     ,isnull(detalles.ValorEntero4,0) as ValorEPSX
     ,@CONTADOR AS Contador,        
            ROW_NUMBER() OVER (ORDER BY CodigoTabla ASC ) AS RowNumber            
     from @MA_MiscelaneosDetalle  as detalles           
    where         
     (        
      (@DescripcionLocal is null  OR @DescripcionLocal =''         
      OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')         
      and ValorNumerico = 1        
      )     
      --OR (ValorNumerico <> 1)        
     ) AS LISTADO        
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR          
            RowNumber BETWEEN @Inicio  AND @NumeroFilas                           
                    
   end  

   ELSE    
  IF @ACCION ='BUSCARSERVICIOS'          
  BEGIN           
 -----------PREPARACIÓN DE FILTROS DE FAVORITOS        
 
 if(@ValorCodigo1 ='ACTIVO' and isnull(len(@ValorCodigo3),0) > 3)        
 begin        
   set @filtrosFavNum=@ValorCodigo3        
   --set @grupos = 'R1_1y R1_2y R1_3y R1_4y R1_2'                 
   set @filtrosFavNum = REPLACE(@filtrosFavNum,'R','Select ')        
   set @filtrosFavNum = REPLACE(@filtrosFavNum,'y',' union ')        
   set @filtrosFavNum = REPLACE(@filtrosFavNum,'_',' , ')        
   set @filtrosFavNum = REPLACE(@filtrosFavNum,'yx',' ')        
   set @filtrosFavNum = REPLACE(@filtrosFavNum,'union x',' ')        
   --set @grupos = 'select 13,21 union select 22,25 union select 26,30 union select 31,40'        
   insert into @TABLA_FILTROSFAVORITOS (idFavorito,numeroFavorito)        
   EXEC(  @filtrosFavNum )                  
 end           
  /* select * from SS_HC_FavoritoDetalle detalleFav        
  inner join @TABLA_FILTROSFAVORITOS filtroFav         
  on (filtroFav.idFavorito = detalleFav.IdFavorito          
  and filtroFav.numeroFavorito = detalleFav.NumeroFavorito)        
  */        
 ---------------------------------------------            
 
 /****PARA DIAGNÓSTICOS  *****/          
 if(@ValorCodigo1='ACTIVO' ) --FAVORITOS ACTIVOS  
 begin  
    insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal,   
    ValorNumerico,   
    ValorEntero1,ValorEntero2,ValorEntero3)          
    Select  'CG','99999', CodigoPadre,CodigoDiagnostico, case tipofolder           
    when 1 then  ltrim(rtrim(Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),IdDiagnostico)))+']'           
    else ltrim(rtrim(Nombre)) end as nombre, tipofolder ,  
    detalleFav.IdFavorito,detalleFav.NumeroFavorito,detalleFav.ValorId  
    From     
     SS_GE_Diagnostico     
     --------------  
     inner JOIN  SS_HC_FavoritoDetalle detalleFav  
     on(( @ValorCodigo1='ACTIVO')  
    and ( SS_GE_Diagnostico.idDiagnostico = detalleFav.ValorId  
    and detalleFav.numeroFavorito in (select NumeroFavorito   
     from @TABLA_FILTROSFAVORITOS AUX where detalleFav.IdFavorito = AUX.idFavorito)   
    and detalleFav.IdFavorito in (select idFavorito   
     from @TABLA_FILTROSFAVORITOS AUX where detalleFav.NumeroFavorito = AUX.numeroFavorito)   
    )   
     )             
   ---------------  
    where NombreTabla = @CodigoTabla        
  and (@DescripcionLocal is null  OR @DescripcionLocal =''         
   OR  upper(Nombre) like '%'+upper(@DescripcionLocal)+'%')         
  and (@CodigoElemento is null  OR @CodigoElemento =''         
   OR  upper(CodigoDiagnostico) like '%'+upper(@CodigoElemento)+'%')           
  and tipofolder = 1            
 end  
 else  
 begin  
    insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal,   
    ValorNumerico)          
    Select  'CG','99999', CodigoPadre,CodigoDiagnostico, case tipofolder           
    when 1 then  ltrim(rtrim(Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),IdDiagnostico)))+']'           
    else ltrim(rtrim(Nombre)) end as nombre, tipofolder           
    From     
     SS_GE_Diagnostico        
    where NombreTabla = @CodigoTabla        
  and (@DescripcionLocal is null  OR @DescripcionLocal =''         
   OR  upper(Nombre) like '%'+upper(@DescripcionLocal)+'%')         
  and (@CodigoElemento is null  OR @CodigoElemento =''         
   OR  upper(CodigoDiagnostico) like '%'+upper(@CodigoElemento)+'%')           
  and tipofolder = 1      
 end  
   
/****PARA PROC. MEDICO   (CPT)  *****/          
 if(@ValorCodigo1='ACTIVO' ) --FAVORITOS ACTIVOS  
 begin  
     insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico  
     ,ValorEntero1,ValorEntero2,ValorEntero3
     ,ValorEntero4,ValorCodigo1
     )    
     Select  'CG','99999', CodigoPadre,CodigoProcedimiento,  case tipofolder           
     when 1 then  ltrim(rtrim(Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),IdProcedimiento)))+']'           
     else ltrim(rtrim(Nombre)) end as nombre,  tipofolder         ,         
     detalleFav.IdFavorito,detalleFav.NumeroFavorito,detalleFav.ValorId
     ,0,IdProcedimiento
     From SS_GE_ProcedimientoMedico      
      --------------  
      inner JOIN  SS_HC_FavoritoDetalle detalleFav  
      on(( @ValorCodigo1='ACTIVO')  
     and ( SS_GE_ProcedimientoMedico.IdProcedimiento = detalleFav.ValorId  
     and detalleFav.numeroFavorito in (select NumeroFavorito   
      from @TABLA_FILTROSFAVORITOS AUX where detalleFav.IdFavorito = AUX.idFavorito)   
     and detalleFav.IdFavorito in (select idFavorito   
      from @TABLA_FILTROSFAVORITOS AUX where detalleFav.NumeroFavorito = AUX.numeroFavorito)   
     )   
      )             
    ---------------  
     where NombreTabla = @CodigoTabla        
   and (@DescripcionLocal is null  OR @DescripcionLocal =''         
    OR  upper(Nombre) like '%'+upper(@DescripcionLocal)+'%')         
   and (@CodigoElemento is null  OR @CodigoElemento =''         
    OR  upper(CodigoProcedimiento) like '%'+upper(@CodigoElemento)+'%')           
   and tipofolder = 1       
 end  
 else  
 begin  
 
   -------------------         
     --where CodigoPadre = @CodigoElemento --and nombretabla='DD000'          
    --and nombretabla in ( @ValorCodigo1)            
     insert into @MA_MiscelaneosDetalle 
     (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, 
     ValorNumerico,ValorEntero4,ValorCodigo1)          
     Select  'CG','99999', CodigoPadre,CodigoProcedimiento,  case tipofolder           
     when 1 then  ltrim(rtrim(Nombre))         
     else ltrim(rtrim(Nombre)) end as nombre,  
     tipofolder,0,IdProcedimiento     /**aqui se agrego este campo*/     
     From SS_GE_ProcedimientoMedico               
     where NombreTabla = @CodigoTabla        
   and (@DescripcionLocal is null  OR @DescripcionLocal =''         
    OR  upper(Nombre) like '%'+upper(@DescripcionLocal)+'%')         
   and (@CodigoElemento is null  OR @CodigoElemento =''         
    OR  upper(CodigoProcedimiento) like '%'+upper(@CodigoElemento)+'%')           
   and tipofolder = 1          
        
   
 end  
      
/****PARA PROC. MEDICO DOS  (CIAP)  *****/       
 if(@ValorCodigo1='ACTIVO' ) --FAVORITOS ACTIVOS  
 begin  
     insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico  
     ,ValorEntero1,ValorEntero2,ValorEntero3)     
     Select  'CG','99999', CodigoPadre,CodigoProcedimientoDos ,  case tipofolder           
     when 1 then  ltrim(rtrim(Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),IdProcedimientoDos)))+']'           
     else ltrim(rtrim(Nombre)) end as nombre,  tipofolder           
     ,detalleFav.IdFavorito,detalleFav.NumeroFavorito,detalleFav.ValorId  
     From SS_GE_ProcedimientoMedicoDos       
      --------------  
      inner JOIN  SS_HC_FavoritoDetalle detalleFav  
      on(( @ValorCodigo1='ACTIVO')  
     and ( SS_GE_ProcedimientoMedicoDos.IdProcedimientoDos = detalleFav.ValorId  
     and detalleFav.numeroFavorito in (select NumeroFavorito   
      from @TABLA_FILTROSFAVORITOS AUX where detalleFav.IdFavorito = AUX.idFavorito)   
     and detalleFav.IdFavorito in (select idFavorito   
      from @TABLA_FILTROSFAVORITOS AUX where detalleFav.NumeroFavorito = AUX.numeroFavorito)   
     )   
      )             
    ---------------  
     where NombreTabla = @CodigoTabla --and nombretabla='PD000'          
   and (@DescripcionLocal is null  OR @DescripcionLocal =''         
    OR  upper(Nombre) like '%'+upper(@DescripcionLocal)+'%')         
   and (@CodigoElemento is null  OR @CodigoElemento =''         
    OR  upper(CodigoProcedimientoDos) like '%'+upper(@CodigoElemento)+'%')           
   and tipofolder = 1     
 end  
 else    
 begin  
    --where CodigoPadre = @CodigoElemento --and nombretabla='PP000'          
    --and nombretabla in ( @ValorCodigo1)                     
    insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico)          
    Select  'CG','99999', CodigoPadre,CodigoProcedimientoDos ,  case tipofolder           
    when 1 then  ltrim(rtrim(Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),IdProcedimientoDos)))+']'           
    else ltrim(rtrim(Nombre)) end as nombre,  tipofolder           
    From SS_GE_ProcedimientoMedicoDos              
     where NombreTabla = @CodigoTabla --and nombretabla='PD000'          
   and (@DescripcionLocal is null  OR @DescripcionLocal =''         
    OR  upper(Nombre) like '%'+upper(@DescripcionLocal)+'%')         
   and (@CodigoElemento is null  OR @CodigoElemento =''         
    OR  upper(CodigoProcedimientoDos) like '%'+upper(@CodigoElemento)+'%')           
   and tipofolder = 1            
   
 end            
         
         
/****PARA CUERPO HUMANO  *****/        
 if(@ValorCodigo1='ACTIVO' ) --FAVORITOS ACTIVOS  
 begin  
   insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico  
   ,ValorEntero1,ValorEntero2,ValorEntero3)     
    Select  'CG','99999', CodigoPadre,Codigo ,  case tipofolder           
    when 1 then  ltrim(rtrim(Descripcion))+'|['+ ltrim(rtrim(Convert(varchar(10),IdCuerpoHumano)))+']'           
    else ltrim(rtrim(Descripcion)) end as nombre,  tipofolder           
    ,detalleFav.IdFavorito,detalleFav.NumeroFavorito,detalleFav.ValorId  
    From  SS_HC_CuerpoHumano      
      --------------  
      inner JOIN  SS_HC_FavoritoDetalle detalleFav  
      on(( @ValorCodigo1='ACTIVO')  
     and ( SS_HC_CuerpoHumano.IdCuerpoHumano = detalleFav.ValorId  
     and detalleFav.numeroFavorito in (select NumeroFavorito   
      from @TABLA_FILTROSFAVORITOS AUX where detalleFav.IdFavorito = AUX.idFavorito)   
     and detalleFav.IdFavorito in (select idFavorito   
      from @TABLA_FILTROSFAVORITOS AUX where detalleFav.NumeroFavorito = AUX.numeroFavorito)   
     )   
      )             
    ---------------  
    where NombreTabla = @CodigoTabla        
   and (@DescripcionLocal is null  OR @DescripcionLocal =''         
    OR  upper(Descripcion) like '%'+upper(@DescripcionLocal)+'%')         
   and (@CodigoElemento is null  OR @CodigoElemento =''         
    OR  upper(Codigo) like '%'+upper(@CodigoElemento)+'%')           
   and tipofolder = 1   
   
   
 end  
 else  
 begin  
   insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico)          
    Select  'CG','99999', CodigoPadre,Codigo ,  case tipofolder      
    when 1 then  ltrim(rtrim(Descripcion))+'|['+ ltrim(rtrim(Convert(varchar(10),IdCuerpoHumano)))+']'           
    else ltrim(rtrim(Descripcion)) end as nombre,  tipofolder           
    From  SS_HC_CuerpoHumano            
    where NombreTabla = @CodigoTabla        
   and (@DescripcionLocal is null  OR @DescripcionLocal =''         
    OR  upper(Descripcion) like '%'+upper(@DescripcionLocal)+'%')         
   and (@CodigoElemento is null  OR @CodigoElemento =''         
    OR  upper(Codigo) like '%'+upper(@CodigoElemento)+'%')           
   and tipofolder = 1           
     --where CodigoPadre = @CodigoElemento --and nombretabla='PD000'     
 end  
              
  /****PARA COMPONENTES (SEGUS) *****/
 if(@ValorCodigo1='ACTIVO' ) --FAVORITOS ACTIVOS  
 begin  
   insert into @MA_MiscelaneosDetalle 
   (AplicacionCodigo, Compania, CodigoTabla, CodigoElemento   , DescripcionLocal, ValorNumerico,
   ValorEntero1,ValorEntero2,ValorEntero3
   ,ValorEntero4,ValorCodigo1
   )     
    Select  'CG',ISNULL(CM_CO_TablaMaestroDetalle.Nombre,'9999'),@CodigoTabla,CodigoComponente ,ltrim(rtrim(CM_CO_Componente.Nombre))+'|['+CodigoComponente+']'  as nombre, '1'           
    ,detalleFav.IdFavorito,detalleFav.NumeroFavorito,detalleFav.ValorId  
    ,isnull(SS_SG_RestriccionContrato.IndicadorEps,2),CodigoComponente
    From     SS_GE_ComponentePrestacion 
	INNER JOIN CM_CO_Componente ON CM_CO_Componente.CodigoComponente =  SS_GE_ComponentePrestacion.Componente 
	LEFT JOIN CM_CO_ClasificacionComponente ON CM_CO_Componente.IdClasificacion = CM_CO_ClasificacionComponente.IdClasificacion 
	LEFT JOIN SS_GE_ServicioPrestacion ON SS_GE_ComponentePrestacion.Componente = SS_GE_ServicioPrestacion.Componente 
	LEFT JOIN SS_GE_Servicio ON SS_GE_ServicioPrestacion.IdServicio = SS_GE_Servicio.IdServicio 
	INNER JOIN SG_UnidadReplicacionPrestacion ON SG_UnidadReplicacionPrestacion.Prestacion = CM_CO_Componente.CodigoComponente 
	AND  SG_UnidadReplicacionPrestacion.Estado = 2 AND SG_UnidadReplicacionPrestacion.UnidadReplicacion =     @ValorCodigo6 --'CEG' MULTISUCURSAL       
      --------------  
      inner JOIN  SS_HC_FavoritoDetalle detalleFav  
      on(( @ValorCodigo1='ACTIVO')  
     and ( CM_CO_Componente.CodigoComponente = detalleFav.ValorTexto3  
     and detalleFav.numeroFavorito in (select NumeroFavorito   
      from @TABLA_FILTROSFAVORITOS AUX where detalleFav.IdFavorito = AUX.idFavorito)   
     and detalleFav.IdFavorito in (select idFavorito   
      from @TABLA_FILTROSFAVORITOS AUX where detalleFav.NumeroFavorito = AUX.numeroFavorito)   
     )   
      )             
		   ---------------  OBTENER INDICADOR EPS-----------
			LEFT JOIN SS_SG_RestriccionContrato ON(			
			SS_SG_RestriccionContrato.UnidadReplicacion=@ValorCodigo6 --'CEG'
			and SS_SG_RestriccionContrato.IdContrato=@ValorEntero1
			and SS_SG_RestriccionContrato.TipoComponente='C'  --Artículo
			and rtrim(SS_SG_RestriccionContrato.Componente)=rtrim(CM_CO_Componente.CodigoComponente)	   		
		   	)
		   	----------------------------------------------------
			   LEFT JOIN CM_CO_TablaMaestroDetalle
	ON (CM_CO_TablaMaestroDetalle.IdTablaMaestro='101')
	AND (CM_CO_TablaMaestroDetalle.IdCodigo=CM_CO_Componente.IDTipoOrdenAtencion)
		--and (CM_CO_TablaMaestroDetalle.Estado='2') --AÑADIDO PARA PEDIDO DE ARACELI OCTUBRE FILTRO SERVICIO

    where
    NombreTabla = @CodigoTabla        
   and (@DescripcionLocal is null  OR @DescripcionLocal =''         
    OR  upper(CM_CO_Componente.Nombre) like '%'+upper(@DescripcionLocal)+'%')         
   and (@CodigoElemento is null  OR @CodigoElemento =''         
    OR  upper(CodigoComponente) like '%'+upper(@CodigoElemento)+'%')                   
   and (@ValorCodigo2 is null  OR @ValorCodigo2 =''         
    OR  upper(CM_CO_TablaMaestroDetalle.Nombre) like '%'+upper(@ValorCodigo2)+'%') 
		 AND CM_CO_Componente.ESTADO=2   --AÑADIDO PARA PRUEBA ESTADO EN SEGUS
 end  
 else  
 begin  
   insert into @MA_MiscelaneosDetalle 
   (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico
   ,ValorEntero4,ValorCodigo1
   )     
    Select      
	'CG',ISNULL(CM_CO_TablaMaestroDetalle.Nombre,'9999'), @CodigoTabla,CodigoComponente ,ltrim(rtrim(CM_CO_Componente.Nombre))+'|['+CodigoComponente+']'  as nombre, '1' 
	,isnull(SS_SG_RestriccionContrato.IndicadorEps,2),CodigoComponente
    From  SS_GE_ComponentePrestacion 
	INNER JOIN CM_CO_Componente ON CM_CO_Componente.CodigoComponente =  SS_GE_ComponentePrestacion.Componente 
	LEFT JOIN CM_CO_ClasificacionComponente ON CM_CO_Componente.IdClasificacion = CM_CO_ClasificacionComponente.IdClasificacion 
	LEFT JOIN SS_GE_ServicioPrestacion ON SS_GE_ComponentePrestacion.Componente = SS_GE_ServicioPrestacion.Componente 
	LEFT JOIN SS_GE_Servicio ON SS_GE_ServicioPrestacion.IdServicio = SS_GE_Servicio.IdServicio 
	INNER JOIN SG_UnidadReplicacionPrestacion ON SG_UnidadReplicacionPrestacion.Prestacion = CM_CO_Componente.CodigoComponente 
	AND  SG_UnidadReplicacionPrestacion.Estado = 2 
	AND SG_UnidadReplicacionPrestacion.UnidadReplicacion =     @ValorCodigo6 --'CEG' MULTISUCURSAL 
	----CM_CO_Componente ---- JORDAN MATEO    
		   ---------------  OBTENER INDICADOR EPS-----------
			LEFT JOIN SS_SG_RestriccionContrato ON(			
			SS_SG_RestriccionContrato.UnidadReplicacion=@ValorCodigo6
			and SS_SG_RestriccionContrato.IdContrato=@ValorEntero1
			and SS_SG_RestriccionContrato.TipoComponente='C'  --Artículo
			and rtrim(SS_SG_RestriccionContrato.Componente)=rtrim(CM_CO_Componente.CodigoComponente)	   		
		   	)
		   	----------------------------------------------------
		   LEFT JOIN CM_CO_TablaMaestroDetalle
	ON (CM_CO_TablaMaestroDetalle.IdTablaMaestro='101')
	AND (CM_CO_TablaMaestroDetalle.IdCodigo=CM_CO_Componente.IDTipoOrdenAtencion)
	
	 	    
    where
    NombreTabla = @CodigoTabla        
   and (@DescripcionLocal is null  OR @DescripcionLocal =''         
    OR  upper(CM_CO_Componente.Nombre) like '%'+upper(@DescripcionLocal)+'%')         
   and (@CodigoElemento is null  OR @CodigoElemento =''         
    OR  upper(CodigoComponente) like '%'+upper(@CodigoElemento)+'%') 
	and (@ValorCodigo2 is null  OR @ValorCodigo2 =''         
    OR  upper(CM_CO_TablaMaestroDetalle.Nombre) like '%'+upper(@ValorCodigo2)+'%')             
     --where CodigoPadre = @CodigoElemento --and nombretabla='PD000'     
 	 AND CM_CO_Componente.ESTADO=2   --AÑADIDO PARA PRUEBAESTADO
 end       
      
  select @CONTADOR = COUNT(*) from @MA_MiscelaneosDetalle        
     /*where        (        
      (@DescripcionLocal is null  OR @DescripcionLocal =''         
      OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')         
      and ValorNumerico = 1        
      )*/        
      --OR (ValorNumerico <> 1)        
          
  SELECT         
     [AplicacionCodigo]        
      ,[CodigoTabla]        
      ,[Compania]        
      ,[CodigoElemento]        
      ,[DescripcionLocal]        
      ,[DescripcionExtranjera]        
      ,[ValorNumerico]        
      ,[ValorCodigo1]        
      ,[ValorCodigo2]        
      ,[ValorCodigo3]        
      ,[ValorCodigo4]        
      ,[ValorCodigo5]        
      ,[ValorFecha]        
      ,[Estado]        
      ,[UltimoUsuario]        
      ,[UltimaFechaModif]        
      ,[Timestamp]        
      ,[ACCION]        
      ,[RowID]        
      ,[ValorEntero1]        
      ,[ValorEntero2]        
      ,[ValorEntero3]        
      ,ValorEPSX as ValorEntero4
      ,[ValorEntero5]        
      ,[ValorCodigo6]        
      ,[ValorCodigo7]        
      ,[ValorEntero6]        
      ,convert(integer,Contador) as ValorEntero7 --AUX PARA CONTADOR
  FROM (SELECT        
     detalles.*              
     ,isnull(detalles.ValorEntero4,0) as ValorEPSX      
     ,@CONTADOR AS Contador,        
            ROW_NUMBER() OVER (ORDER BY CodigoTabla ASC ) AS RowNumber            
     from @MA_MiscelaneosDetalle  as detalles           
     /*where         
     (        
      (@DescripcionLocal is null  OR @DescripcionLocal =''         
      OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')         
      and ValorNumerico = 1        
      )*/        
      --OR (ValorNumerico <> 1)        
     ) AS LISTADO        
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR          
            RowNumber BETWEEN @Inicio  AND @NumeroFilas        
                             
             
  END     
  ELSE 
    IF(@ACCION='DIAGNOSTICOS2')
      BEGIN
      if(@ValorCodigo1='ACTIVO' ) --FAVORITOS ACTIVOS  
      begin  
      insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal,   
      ValorNumerico,   
      ValorEntero1,ValorEntero2,ValorEntero3)          
    Select  'CG','99999', CodigoPadre,CodigoDiagnostico, case tipofolder           
    when 1 then  CodigoDiagnostico +'/'+ ltrim(rtrim(Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),IdDiagnostico)))+']'           
    else ltrim(rtrim(Nombre)) end as nombre, tipofolder ,  
    detalleFav.IdFavorito,detalleFav.NumeroFavorito,detalleFav.ValorId  
    From     
     SS_GE_Diagnostico     
     --------------  
     inner JOIN  SS_HC_FavoritoDetalle detalleFav  
     on(( @ValorCodigo1='ACTIVO')  
    and ( SS_GE_Diagnostico.idDiagnostico = detalleFav.ValorId  
    and detalleFav.numeroFavorito in (select NumeroFavorito   
     from @TABLA_FILTROSFAVORITOS AUX where detalleFav.IdFavorito = AUX.idFavorito)   
    and detalleFav.IdFavorito in (select idFavorito   
     from @TABLA_FILTROSFAVORITOS AUX where detalleFav.NumeroFavorito = AUX.numeroFavorito)   
    )   
     )             
   ---------------  
    where NombreTabla = @CodigoTabla        
  and (@DescripcionLocal is null  OR @DescripcionLocal =''         
   OR  upper(Nombre) like '%'+upper(@DescripcionLocal)+'%')         
  and (@CodigoElemento is null  OR @CodigoElemento =''         
   OR  upper(CodigoDiagnostico) like '%'+upper(@CodigoElemento)+'%')           
  and tipofolder = 1            
 end  
 else  
 begin  
    insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal,   
    ValorNumerico)          
    Select  'CG','99999', CodigoPadre,CodigoDiagnostico, case tipofolder           
    when 1 then CodigoDiagnostico +'/'+ ltrim(rtrim(Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),IdDiagnostico)))+']'           
    else ltrim(rtrim(Nombre)) end as nombre, tipofolder           
    From     
     SS_GE_Diagnostico        
    where NombreTabla = @CodigoTabla        
  and (@DescripcionLocal is null  OR @DescripcionLocal =''         
   OR  upper(Nombre) like '%'+upper(@DescripcionLocal)+'%')         
  and (@CodigoElemento is null  OR @CodigoElemento =''         
   OR  upper(CodigoDiagnostico) like '%'+upper(@CodigoElemento)+'%')           
  and tipofolder = 1      
  end  
        
  select @CONTADOR = COUNT(*) from @MA_MiscelaneosDetalle        
    
          
  SELECT         
     [AplicacionCodigo]        
      ,[CodigoTabla]        
      ,[Compania]        
      ,[CodigoElemento]        
      ,[DescripcionLocal]        
      ,[DescripcionExtranjera]        
      ,[ValorNumerico]        
      ,[ValorCodigo1]        
      ,[ValorCodigo2]        
      ,[ValorCodigo3]        
      ,[ValorCodigo4]        
      ,[ValorCodigo5]        
      ,[ValorFecha]        
      ,[Estado]        
      ,[UltimoUsuario]        
      ,[UltimaFechaModif]        
      ,[Timestamp]        
      ,[ACCION]        
      ,[RowID]        
      ,[ValorEntero1]        
      ,[ValorEntero2]        
      ,[ValorEntero3]        
      ,ValorEPSX as ValorEntero4
      ,[ValorEntero5]        
      ,[ValorCodigo6]        
      ,[ValorCodigo7]        
      ,[ValorEntero6]        
      ,convert(integer,Contador) as ValorEntero7 --AUX PARA CONTADOR
  FROM (SELECT        
     detalles.*              
     ,isnull(detalles.ValorEntero4,0) as ValorEPSX      
     ,@CONTADOR AS Contador,        
            ROW_NUMBER() OVER (ORDER BY CodigoTabla ASC ) AS RowNumber            
     from @MA_MiscelaneosDetalle  as detalles           
      
     ) AS LISTADO        
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR          
            RowNumber BETWEEN @Inicio  AND @NumeroFilas  

  END       
  ELSE IF (@ACCION='LISTARLINEA')          
    BEGIN          
     insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,           
      DescripcionLocal,ValorCodigo1)          
     Select  'CG','99999',  Linea, Linea ,            
      DescripcionLocal  , Linea from WH_ClaseLinea         
      where         
      (@ValorCodigo1 is null OR linea =@ValorCodigo1)        
     --select * from WH_ClaseLinea        
      select * from @MA_MiscelaneosDetalle          
    END           
     ELSE IF (@ACCION='LISTARFAMILIA')          
    BEGIN          
     insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,           
      DescripcionLocal,ValorCodigo1)          
     Select  'CG','99999',  Linea, Familia ,            
      DescripcionLocal  , Familia from WH_ClaseFamilia          
     --select * from WH_ClaseFamilia          
     Where Linea = @ValorCodigo1          
     and (@ValorCodigo2 is null OR @ValorCodigo2 = Familia)        
             
      select * from @MA_MiscelaneosDetalle          
                    
    END  
     ELSE IF (@ACCION='LISTARSUBFAMILIA')          
    BEGIN          
     if len(@ValorCodigo3)=0 SET @ValorCodigo3 = NULL          
    insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,           
     DescripcionLocal, ValorCodigo1, ValorCodigo2, ValorCodigo3, ValorCodigo4, ValorCodigo5,         
     ValorCodigo6, ValorCodigo7)          
    Select  'CG','99999',  WH_ClaseSubFamilia.Linea, WH_ClaseSubFamilia.SubFamilia ,            
     WH_ClaseSubFamilia.DescripcionLocal, WH_ClaseSubFamilia.Linea, WH_ClaseSubFamilia.Familia,         
     WH_ClaseSubFamilia.SubFamilia, WH_ClaseSubFamilia.ItemTipo, WH_ClaseSubFamilia.Estado,        
     WH_ClaseLinea.DescripcionLocal, WH_ClaseFamilia.DescripcionLocal         
    FROM         dbo.WH_ClaseFamilia INNER JOIN        
         dbo.WH_ClaseLinea ON dbo.WH_ClaseFamilia.Linea = dbo.WH_ClaseLinea.Linea         
    INNER JOIN        
         dbo.WH_ClaseSubFamilia ON dbo.WH_ClaseFamilia.Linea = dbo.WH_ClaseSubFamilia.Linea         
    AND dbo.WH_ClaseFamilia.Familia = dbo.WH_ClaseSubFamilia.Familia        
    --select * from WH_ClaseSubFamilia          
    Where WH_ClaseSubFamilia.Linea = @ValorCodigo1          
    and  WH_ClaseSubFamilia.Familia = @ValorCodigo2          
    and exists(select 1 from wh_itemmast where wh_itemmast.Linea = WH_ClaseSubFamilia.Linea        
     and wh_itemmast.Familia = WH_ClaseSubFamilia.Familia        
     and wh_itemmast.SubFamilia = WH_ClaseSubFamilia.SubFamilia)        
     and  (@ValorCodigo3 IS NULL OR WH_ClaseSubFamilia.SubFamilia = @ValorCodigo3)             
    and  (@ValorCodigo4 IS NULL OR WH_ClaseSubFamilia.DescripcionLocal LIKE '%'+@ValorCodigo4 + '%')             
            
     select * from @MA_MiscelaneosDetalle          
   END         
     ELSE IF (@ACCION='TRATACTIVO')          
  BEGIN          
          
   insert into @MA_MiscelaneosDetalle         
   (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,           
   ValorNumerico,        
   ValorCodigo1,ValorCodigo2,        
   DescripcionLocal)               
   SELECT 'CG','99999',         
   SS_AD_OrdenAtencion.idPaciente,        
   ROW_NUMBER() OVER (ORDER BY SS_AD_OrdenAtencion.idPaciente ASC ) AS CodigoElemento,            
   SS_CE_ConsultaExterna.IdConsultaExterna,         
   CONVERT(varchar,SS_CE_ConsultaExterna.FechaConsulta,103)  AS FechaIni,        
   --IsNull(SS_CE_ConsultaExternaReceta.DiasTratamiento,0) AS DiasTratamiento,         
   CONVERT(varchar,DATEADD(dw,IsNull(SS_CE_ConsultaExternaReceta.DiasTratamiento,0),        
   SS_CE_ConsultaExterna.FechaConsulta),103) AS FechaFinal,         
   --(CASE WHEN LTRIM(RTRIM(ISNULL(SS_CE_ConsultaExternaReceta.Componente,''))) = '' THEN 'DCI' ELSE 'MEDICAMENTO' END        
   --) AS Tipo,         
   (CASE WHEN LTRIM(RTRIM(ISNULL(SS_CE_ConsultaExternaReceta.Componente,''))) = '' THEN WH_ClaseSubFamilia.DescripcionLocal ELSE WH_ItemMast.DescripcionLocal END        
   ) AS Descripcion         
   FROM SS_CE_ConsultaExternaReceta INNER JOIN SS_CE_ConsultaExterna         
   ON SS_CE_ConsultaExternaReceta.IdConsultaExterna = SS_CE_ConsultaExterna.IdConsultaExterna         
   INNER JOIN SS_AD_OrdenAtencion     
   ON SS_CE_ConsultaExterna.IdOrdenAtencion = SS_AD_OrdenAtencion.IdOrdenAtencion         
   LEFT JOIN WH_ClaseSubFamilia         
   ON SS_CE_ConsultaExternaReceta.Linea = WH_ClaseSubFamilia.Linea         
    AND SS_CE_ConsultaExternaReceta.Familia = WH_ClaseSubFamilia.Familia         
    AND SS_CE_ConsultaExternaReceta.SubFamilia = WH_ClaseSubFamilia.SubFamilia         
   LEFT JOIN WH_ItemMast         
   ON SS_CE_ConsultaExternaReceta.Componente = WH_ItemMast.Item         
   WHERE SS_AD_OrdenAtencion.IdPaciente =@INICIO        
      
    AND SS_CE_ConsultaExternaReceta.Estado = 2         
   ORDER BY SS_CE_ConsultaExterna.FechaConsulta          
           
      select * from @MA_MiscelaneosDetalle          
                    
  END             
      
 ELSE IF(@ACCION = 'COMBOSEGURIDAD')        
  BEGIN        
  PRINT ''+@ACCION + '---'  + @CodigoTabla        
     IF(@CodigoTabla = 'COMPANIA')        
    BEGIN        
      insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania,         
      CodigoTabla,   CodigoElemento ,           
      ValorCodigo1, DescripcionLocal,ValorEntero1)         
     SELECT   distinct  dbo.SY_SeguridadAutorizaciones.AplicacionCodigo, dbo.SeguridadAutorizacionCompania.Companyowner,         
     dbo.SY_SeguridadAutorizaciones.Grupo,  dbo.companyowner.companyowner,         
                     dbo.companyowner.companyowner, dbo.companyowner.description   ,0     
     FROM         dbo.SY_SeguridadAutorizaciones INNER JOIN        
            dbo.SeguridadAutorizacionCompania ON dbo.SY_SeguridadAutorizaciones.Usuario = dbo.SeguridadAutorizacionCompania.Usuario INNER JOIN        
            dbo.companyowner ON dbo.SeguridadAutorizacionCompania.Companyowner = dbo.companyowner.companyowner        
     where   ltrim(SY_SeguridadAutorizaciones.Usuario)  = @UltimoUsuario        
     and (Grupo = 'COMPANIASOCIO' AND SY_SeguridadAutorizaciones.Estado='A')      
     PRINT ''+@ACCION + '---'  + @CodigoTabla        
    END 
	
	IF(@CodigoTabla = 'PROCEDIMIENTO')        
    BEGIN   

      insert into @MA_MiscelaneosDetalle (
	  AplicacionCodigo, 
	  Compania,         
      CodigoTabla,
	 CodigoElemento ,           
      ValorCodigo1,
	  DescripcionLocal,
	  ValorEntero1) 
     SELECT distinct  
	 
	 'SY' as AplicacionCodigo,
	 Convert (varchar,IdServicio) Concepto	
				 ,'PROCEDIMIENTO' Grupo
				, Convert (varchar,IdServicio) Concepto
				,Convert (varchar,IdServicio) Concepto	
				,Descripcion Descripcion,0

	 FROM
	 SS_GE_Servicio where TipoOrdenAtencion is not null
     PRINT ''+@ACCION + '---'  + @CodigoTabla  
	 

    END
	
	
	   IF(@CodigoTabla = 'SUCURSAL')        
    BEGIN       
	
	if(select count(*) from SY_SeguridadAutorizaciones WHERE Usuario=@UltimoUsuario)=0
	begin
	set @UltimoUsuario='ROYAL'
	end

      insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania,         
      CodigoTabla,   CodigoElemento ,           
      ValorCodigo1, DescripcionLocal,ValorEntero1)         
     Select  dbo.SY_SeguridadAutorizaciones.AplicacionCodigo,SeguridadAutorizacionCompania.Companyowner,        
       dbo.SY_SeguridadAutorizaciones.Grupo,dbo.AC_Sucursal.Sucursal,        
       dbo.AC_Sucursal.Sucursal,AC_Sucursal.DescripcionLocal  ,0       
      FROM       dbo.SY_SeguridadAutorizaciones INNER JOIN        
            dbo.AC_Sucursal ON dbo.SY_SeguridadAutorizaciones.Concepto = dbo.AC_Sucursal.Sucursal INNER JOIN        
            dbo.SeguridadAutorizacionCompania ON dbo.SY_SeguridadAutorizaciones.Usuario = dbo.SeguridadAutorizacionCompania.Usuario AND         
            dbo.AC_Sucursal.Compania = dbo.SeguridadAutorizacionCompania.Companyowner        
     where ltrim(SY_SeguridadAutorizaciones.Usuario)  = @UltimoUsuario         
     and AC_Sucursal.Compania =@ValorCodigo1       
     and  (Grupo = 'SUCURSAL' and SY_SeguridadAutorizaciones.Estado='A')
    END  
	
	
	 --angelN
    IF(@CodigoTabla = 'UNIDADREPLI')        
    BEGIN        
      insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania,         
      CodigoTabla,   CodigoElemento ,           
      ValorCodigo1, DescripcionLocal,ValorEntero1)         
    SELECT   distinct  F.AplicacionCodigo, C.Companyowner,   F.Grupo,       
  --    CO.companyowner,  CO.companyowner,  R.DescripcionLocal  ,0  --// angel Observado
     R.UnidadReplicacion,  R.UnidadReplicacion,  R.DescripcionLocal  ,0 
   FROM SY_SeguridadAutorizaciones  F
   INNER JOIN SY_UnidadReplicacion R  ON F.Concepto = R.UnidadReplicacion 
   INNER JOIN SeguridadAutorizacionCompania  C ON F.Usuario = C.Usuario 
   INNER JOIN companyowner CO ON R.Compania = C.companyowner        
     where  
    Grupo = 'SUCURSAL'   
        and  ltrim(F.Usuario)  = @UltimoUsuario
		and (@ValorCodigo1 is null  OR @ValorCodigo1 ='' OR R.UnidadReplicacion = @ValorCodigo1)   
        AND R.Compania = CO.companyowner 
     PRINT ''+@ACCION + '---'  + @CodigoTabla     
    END
    

      IF(@CodigoTabla = 'DESALMACEN')        
    BEGIN        
      insert into @MA_MiscelaneosDetalle 
      (AplicacionCodigo, Compania,CodigoTabla,   CodigoElemento , ValorCodigo1, DescripcionLocal,ValorEntero1, ValorCodigo3, ValorCodigo4, ValorCodigo5,ValorCodigo6)         
    SELECT   distinct 
     F.AplicacionCodigo, C.Companyowner,F.Grupo, R.AlmacenCodigo,  R.AlmacenCodigo,  R.DescripcionLocal  ,0 ,UR.AlmacenFarmacia,UR.AlmacenEmergencia,UR.AlmacenCentroObstetrico,UR.AlmacenHospitalaria
     
   FROM SY_SeguridadAutorizaciones  F
   INNER JOIN WH_AlmacenMast R  ON F.Concepto = R.UnidadReplicacion 
   INNER JOIN SeguridadAutorizacionCompania  C ON F.Usuario = C.Usuario 
   INNER JOIN SY_UnidadReplicacion UR ON UR.UnidadReplicacion =R.UnidadReplicacion AND R.CompaniaSocio=UR.Compania AND R.ESTADO=UR.ESTADO
   INNER JOIN companyowner CO ON R.CompaniaSocio = c.companyowner        
     where  
    Grupo = 'SUCURSAL'   
       and  ltrim(F.Usuario)  = @UltimoUsuario
         AND R.CompaniaSocio = CO.companyowner  
		 AND F.Concepto= @ValorCodigo1
    END
    
  IF(@CodigoTabla = 'ESTABLEC')        
    BEGIN        
      insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania,         
      CodigoTabla,   CodigoElemento ,           
      ValorCodigo1, DescripcionLocal,        
      ValorCodigo2, Estado,        
      ValorCodigo3,ValorEntero1)         
      SELECT     dbo.SY_SeguridadAutorizaciones.AplicacionCodigo, dbo.SY_SeguridadAutorizaciones.Grupo,         
       dbo.AC_Sucursal.Sucursal, dbo.CM_CO_Establecimiento.IdEstablecimiento,         
       dbo.CM_CO_Establecimiento.Codigo, dbo.CM_CO_Establecimiento.Nombre,         
       dbo.CM_CO_Establecimiento.Descripcion, dbo.CM_CO_Establecimiento.Estado,         
       dbo.SY_SeguridadAutorizaciones.Usuario ,CM_CO_Establecimiento.IdEstablecimiento       
     FROM dbo.AC_Sucursal INNER JOIN        
       dbo.CM_CO_Establecimiento ON dbo.AC_Sucursal.Sucursal = dbo.CM_CO_Establecimiento.Sucursal INNER JOIN        
       dbo.SY_SeguridadAutorizaciones ON dbo.AC_Sucursal.Sucursal = dbo.SY_SeguridadAutorizaciones.Concepto        
     where ltrim(SY_SeguridadAutorizaciones.Usuario) = @UltimoUsuario         
     and CM_CO_Establecimiento.Compania =@ValorCodigo1  
     and CM_CO_Establecimiento.Sucursal =@ValorCodigo2  
                              
    END         
   select * from @MA_MiscelaneosDetalle           
  END    
  
    ELSE IF(@ACCION = 'DIETAHIJOS')        
    BEGIN                 
        
      insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania,         
      CodigoTabla,   CodigoElemento ,           
      ValorCodigo1, DescripcionLocal,ValorEntero1)         
         Select  'CG','99999',IdDieta, IdPadre,IdDieta,Descripcion, IdDieta from [dbo].[SS_HC_CATALOGODIETA] WHERE IdPadre=@ValorEntero1 AND Nivel=2
		
   select * from @MA_MiscelaneosDetalle           
  END  
 
 ELSE IF (@ACCION='INFOPACIENTE')          
 begin  
  --EMPRESA ASEGURADORA  
  declare @EMPRESAASEG_DESC varchar(300)=null  
    
  select @EMPRESAASEG_DESC = NombreCompleto from PersonaMast  
  where Persona = CONVERT(varchar, @ValorCodigo2)  
       
  insert into @MA_MiscelaneosDetalle   
  (AplicacionCodigo, Compania, CodigoTabla,CodigoElemento, DescripcionLocal)  
  values(  
  'AW', '00000000','INFOPAC','ASEG',isnull(@EMPRESAASEG_DESC,'--')  
  )  
    
  select * from @MA_MiscelaneosDetalle  
 end   
 ELSE IF (@ACCION='LISTACOMBO')          
 begin   
     
  insert into @MA_MiscelaneosDetalle     
  (AplicacionCodigo, Compania, CodigoTabla,CodigoElemento, DescripcionLocal  
  ,ValorNumerico,ValorCodigo1,ValorCodigo2,ValorCodigo3  
  )  
  select AplicacionCodigo, Compania, CodigoTabla,CodigoElemento, DescripcionLocal  
  ,ValorNumerico,ValorCodigo1,ValorCodigo2,ValorCodigo3  
   from dbo.MA_MiscelaneosDetalle  
  where  
    ( AplicacionCodigo = @AplicacionCodigo)        
    and ( CodigoTabla = @CodigoTabla)        
    and (Compania = @Compania)        
    and (@CodigoElemento is null OR CodigoElemento = @CodigoElemento)            
        
  select * from @MA_MiscelaneosDetalle      
    
 end   
  ELSE IF (@ACCION='LISTAGENERAL')          
 begin      
  if(@CodigoTabla= 'TABLA_COMPANIA')  
  begin  
   insert into @MA_MiscelaneosDetalle   
   (AplicacionCodigo, Compania, CodigoTabla,     
   CodigoElemento ,   DescripcionLocal,ValorCodigo1,ValorEntero1,
   ValorEntero2,ValorEntero3,ValorEntero4,ValorEntero5,ValorNumerico
   )    
   Select    
   'CG','99999',company,  
   companyowner,description,  companyowner,0,
   0,0,0,0,0  
   from companyowner   
   inner join CompaniaMast on (substring(CompaniaMast.CompaniaCodigo,1,6)=substring(companyowner.companyowner,1,6) )  
   where CompaniaMast.Estado ='A'   
   and (@DescripcionLocal is null or  @DescripcionLocal ='' or   
     UPPER(companyowner.description ) like '%'+UPPER(@DescripcionLocal)+'%'   
   )           
  end    
  else if(@CodigoTabla= 'TABLA_ESTABLEC')  
  begin  
   insert into @MA_MiscelaneosDetalle   
   (AplicacionCodigo, Compania, CodigoTabla,     
   CodigoElemento ,   DescripcionLocal,ValorCodigo1,ValorEntero1,
   ValorEntero2,ValorEntero3,ValorEntero4,ValorEntero5,ValorNumerico)    
   Select    
   'CG','99999',Codigo,  
   IdEstablecimiento,Nombre,  Codigo,IdEstablecimiento,
   0,0,0,0,IdEstablecimiento  
   from CM_CO_Establecimiento      
   where   
   (@DescripcionLocal is null or  @DescripcionLocal ='' or   
     UPPER(Nombre) like '%'+UPPER(@DescripcionLocal)+'%'   
   )                
  end  
  else if(@CodigoTabla= 'TABLA_ESPECIALIDAD')  
  begin  
   insert into @MA_MiscelaneosDetalle   
   (AplicacionCodigo, Compania, CodigoTabla,     
   CodigoElemento ,   DescripcionLocal,ValorCodigo1,ValorEntero1,
   ValorEntero2,ValorEntero3,ValorEntero4,ValorEntero5,ValorNumerico)    
   Select    
   'CG','99999',Codigo,  
   IdEspecialidad,Nombre,  Codigo,IdEspecialidad,
   0,0,0,0,IdEspecialidad  
   from SS_GE_Especialidad      
   where   
   (@DescripcionLocal is null or  @DescripcionLocal ='' or   
     UPPER(Nombre) like '%'+UPPER(@DescripcionLocal)+'%'   
   )  
               
  end  
  else if(@CodigoTabla= 'TABLA_AGENTE')  
  begin  
   insert into @MA_MiscelaneosDetalle   
   (AplicacionCodigo, Compania, CodigoTabla,     
   CodigoElemento ,   DescripcionLocal,ValorCodigo1,ValorEntero1,
   ValorEntero2,ValorEntero3,ValorEntero4,ValorEntero5,ValorNumerico)    
   Select    
   'CG','99999',CodigoAgente,  
   IdAgente,Nombre,  CodigoAgente,IdAgente,
   0,0,0,0,IdAgente  
   from SG_Agente      
   where   
   (@DescripcionLocal is null or  @DescripcionLocal ='' or   
     UPPER(Nombre) like '%'+UPPER(@DescripcionLocal)+'%'   
   )          
  end  
  else if(@CodigoTabla= 'TABLA_FORMATO')  
  begin  
   insert into @MA_MiscelaneosDetalle   
   (AplicacionCodigo, Compania, CodigoTabla,     
   CodigoElemento ,   DescripcionLocal,ValorCodigo1,ValorEntero1,
   ValorEntero2,ValorEntero3,ValorEntero4,ValorEntero5,ValorNumerico)    
   Select    
   'CG','99999',CodigoFormato,  
   IdFormato,Descripcion,  CodigoFormato,IdFormato,
   0,0,0,0,IdFormato  
   from SS_HC_Formato      
   where   
   (@DescripcionLocal is null or  @DescripcionLocal ='' or   
     UPPER(Descripcion) like '%'+UPPER(@DescripcionLocal)+'%'   
   )            
  end  
  else if(@CodigoTabla= 'TABLA_UNIDSERVICIO')  
  begin  
   insert into @MA_MiscelaneosDetalle   
   (AplicacionCodigo, Compania, CodigoTabla,     
   CodigoElemento ,   DescripcionLocal,ValorCodigo1,ValorEntero1,
   ValorEntero2,ValorEntero3,ValorEntero4,ValorEntero5,ValorNumerico)    
   Select    
   'CG','99999',Codigo,  
   Codigo,Descripcion,  Codigo,IdEstablecimientoSalud,
   IdUnidadServicio,0,0,0,IdServicio  
   from SS_HC_UnidadServicio      
   where   
   (@DescripcionLocal is null or  @DescripcionLocal ='' or   
     UPPER(Descripcion) like '%'+UPPER(@DescripcionLocal)+'%'   
   ) 
  end              
  else if(@CodigoTabla= 'TABLA_SUCURSAL')  
  begin  
   set @DescripcionLocal=null       

  end          
   ----------------------------------------------------------------------------  
     SELECT         
     [AplicacionCodigo]        
      ,[CodigoTabla]        
      ,[Compania]        
      ,[CodigoElemento]        
      ,[DescripcionLocal]        
      ,[DescripcionExtranjera]        
      ,[ValorNumerico]        
      ,[ValorCodigo1]        
      ,[ValorCodigo2]        
      ,[ValorCodigo3]        
      ,[ValorCodigo4]        
      ,[ValorCodigo5]        
      ,[ValorFecha]        
      ,[Estado]        
      ,[UltimoUsuario]        
      ,[UltimaFechaModif]        
      ,[Timestamp]        
      ,[ACCION]        
      ,[RowID]        
      ,[ValorEntero1]        
      ,[ValorEntero2]        
      ,[ValorEntero3]        
      ,[ValorEntero4]        
      ,[ValorEntero5]        
      ,[ValorCodigo6]        
      ,[ValorCodigo7]        
      ,[ValorEntero6]        
      ,[ValorEntero7]                 
     FROM (SELECT        
     detalles.*                    
     ,@CONTADOR AS Contador,        
      ROW_NUMBER() OVER (ORDER BY CodigoTabla ASC ) AS RowNumber            
     from @MA_MiscelaneosDetalle  as detalles                   
     ) AS LISTADO        
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR          
      RowNumber BETWEEN @Inicio  AND @NumeroFilas      
              
 END     
    
 ELSE  
 IF @ACCION ='COMBOSGENERICO'    
    BEGIN   
    --SET @INICIO = NULL  
    --SET @NUMEROFILAS = NULL  
     IF (@CodigoTabla='TODOLUGAR')    
   BEGIN    
   DECLARE @CONTAR INT  
  SELECT @CONTAR = COUNT(*)  
     from pais left join departamento  
    on (departamento.Pais = pais.Pais)left join Provincia  
    on (Departamento.Departamento = Provincia.Departamento)left join ZonaPostal  
    on (ZonaPostal.Provincia = Provincia.Provincia)  
    and (ZonaPostal.Departamento = Provincia.Departamento)  
    where(@ValorCodigo1 is null or Pais.Pais = @ValorCodigo1 or @ValorCodigo1 = '')  
    and  (@ValorCodigo2 is null or Departamento.Departamento = @ValorCodigo2 or @ValorCodigo2 = '')  
    and  (@ValorCodigo3 is null or Provincia.Provincia = @ValorCodigo3 or @ValorCodigo3 = '')  
    and  (@ValorCodigo4 is null or ZonaPostal.CodigoPostal = @ValorCodigo4 or @ValorCodigo4 = '')  
    /**/  
    insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,     
    ValorCodigo1,DescripcionLocal,ValorCodigo2,DescripcionExtranjera, ValorCodigo3,  
    ValorCodigo6,ValorCodigo4,ValorCodigo5,CodigoElemento)   
    select 'WA' ,'999999' ,@CodigoTabla,pais.Pais,pais.DescripcionCorta,  
    ISNULL(departamento.Departamento,' '),ISNULL(departamento.DescripcionCorta,pais.DescripcionCorta) ,  
    ISNULL(provincia.Provincia,' '),ISNULL(provincia.DescripcionCorta,pais.DescripcionCorta),  
    ISNULL(zonapostal.CodigoPostal,' '),ISNULL(zonapostal.DescripcionCorta,pais.DescripcionCorta) ,  
      convert(varchar ,ROW_NUMBER() OVER (ORDER BY Pais.pais ASC ))  
     from pais left join departamento  
    on (departamento.Pais = pais.Pais)left join Provincia  
    on (Departamento.Departamento = Provincia.Departamento)left join ZonaPostal  
    on (ZonaPostal.Provincia = Provincia.Provincia)  
    and (ZonaPostal.Departamento = Provincia.Departamento)  
    where(@ValorCodigo1 is null or Pais.Pais = @ValorCodigo1 or @ValorCodigo1 = '')  
    and  (@ValorCodigo2 is null or Departamento.Departamento = @ValorCodigo2 or @ValorCodigo2 = '')  
    and  (@ValorCodigo3 is null or Provincia.Provincia = @ValorCodigo3 or @ValorCodigo3 = '')  
    and  (@ValorCodigo4 is null or ZonaPostal.CodigoPostal = @ValorCodigo4 or @ValorCodigo4 = '')  

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
    @CONTAR AS CONTADOR,  
    ROW_NUMBER() OVER(ORDER BY CodigoElemento) AS ROWNUMBER,  
    *  
    FROM   
    @MA_MiscelaneosDetalle  
    where(@ValorCodigo1 is null or ValorCodigo1 = @ValorCodigo1 or @ValorCodigo1 = '')  
    and  (@ValorCodigo2 is null or ValorCodigo2 = @ValorCodigo2 or @ValorCodigo2 = '')  
    and  (@ValorCodigo3 is null or ValorCodigo3 = @ValorCodigo3 or @ValorCodigo3 = '')  
    and  (@ValorCodigo4 is null or @ValorCodigo4 = @ValorCodigo4 or @ValorCodigo4 = '')  
  )AS LISTADO  
  WHERE(@INICIO IS NULL AND @NUMEROFILAS IS NULL)  
  OR (ROWNUMBER BETWEEN @INICIO AND @NUMEROFILAS)  
   END   
  END  
 ELSE IF (@ACCION='INFOABOUT')          
 begin  
  --EMPRESA ASEGURADORA  
 /**/  
 declare @IdEmpleadoAux02 int =0  
 declare @IndicaAux02 int =0    
 declare @TipoTrabajadorAux02 varchar(200) =null  
 declare @NombreEmpleadoAux02 varchar(200) =null   
 insert into @MA_MiscelaneosDetalle  
    (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento,  
    ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,  
    DescripcionLocal,ValorEntero1,UltimoUsuario,ValorCodigo5,ValorCodigo6,
    ValorCodigo7
    )      
    select   
    isnull((select DESCRIPCIONCORTA from APLICACIONESMAST where AplicacionCodigo = @AplicacionCodigo),'WA'),  
    isnull((select description from companyowner where companyowner= @Compania),'999999'),  
    isnull((select DescripcionLocal from AC_Sucursal where Sucursal = @CodigoTabla),'AUX'),  
    idAgente,  
    (select Nombre from CM_CO_Establecimiento where IdEstablecimiento = convert(int,@ValorCodigo1) ) ,  
    substring(CONVERT(varchar,GETDATE(),112),1,6),  
    DB_NAME(),  
    (@TipoTrabajadorAux02),  
    (@NombreEmpleadoAux02),  
    isnull(@IdEmpleadoAux02,0),  
    CodigoAgente  ,
    'SPRING SALUD',
    'Historia Clínica Electrónica HCE' ,
    'ROYAL SYSTEMS S.A.C'       
    from SG_Agente  
    where  IdAgente =  convert(int,@CodigoElemento)  
 /**/   
  select * from @MA_MiscelaneosDetalle  
 end     
 ELSE IF (@ACCION='INFOSESSION')          
 begin  
  declare @IdEmpleadoAux01 int =0  
  declare @IndicaAux01 int =0    
  declare @TipoTrabajadorAux varchar(200) =null  
  declare @NombreEmpleadoAux varchar(200) =null      
      
  if(@CodigoElemento is not null)  
  begin  
   select @IdEmpleadoAux01= IdEmpleado from SG_Agente where IdAgente = convert(int,@CodigoElemento)  
   select @IndicaAux01= TipoAgente from SG_Agente where IdAgente =  convert(int,@CodigoElemento)  
     
   if(@IndicaAux01 >1) ---QUE NO SEA PERFIL  
   begin  
    select @TipoTrabajadorAux = SS_TipoTrabajador.DescripcionLocal   
    from EMPLEADOMAST   
    left join SS_TipoTrabajador on (SS_TipoTrabajador.TipoTrabajador = EMPLEADOMAST.TipoTrabajadorSalud)  
    where Empleado = @IdEmpleadoAux01  
      
    select @NombreEmpleadoAux = NombreCompleto from PERSONAMAST where Persona = @IdEmpleadoAux01  
      
   end  
   else  
   begin      
    set @TipoTrabajadorAux = 'USUARIO GENÉRICO'  
    select @NombreEmpleadoAux= Nombre from SG_Agente where IdAgente = convert(int,@CodigoElemento)    
   end     
   -------------------  
    insert into @MA_MiscelaneosDetalle  
    (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento,  
    ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,  
    DescripcionLocal,ValorEntero1,UltimoUsuario)      
    select   
    isnull((select DESCRIPCIONCORTA from APLICACIONESMAST where AplicacionCodigo = @AplicacionCodigo),'WA'),  
    isnull((select description from companyowner where companyowner= @Compania),'999999'),  
    isnull((select DescripcionLocal from AC_Sucursal where Sucursal = @CodigoTabla),'AUX'),  
    idAgente,  
    (select Nombre from CM_CO_Establecimiento where IdEstablecimiento = convert(int,@ValorCodigo1) ) ,  
    CONVERT(varchar,GETDATE(),112),  
    DB_NAME(),  
    (@TipoTrabajadorAux),  
    (@NombreEmpleadoAux),  
    isnull(@IdEmpleadoAux01,0),  
    CodigoAgente     
    from SG_Agente  
    where  IdAgente =  convert(int,@CodigoElemento)  
     
	end  
		select * from @MA_MiscelaneosDetalle  
	end    
	ELSE IF(@ACCION = 'VIRTDOCUMENT')     
		begin
		
	
			insert into @MA_MiscelaneosDetalle   
			(AplicacionCodigo, 
			Compania, 
			CodigoTabla,  
			CodigoElemento,    
			ValorCodigo1,     
			ValorEntero1 ,           
			ValorEntero2,   
			DescripcionLocal,        
			ValorCodigo2,   
			Estado,  
			ValorNumerico,
			DescripcionExtranjera,
			ValorEntero3,
			ValorEntero4
			)    
		
			Select				
					DOCS.UnidadReplicacion, 
					DOCS.CodigoReferencia, 
					DOCS.IdPaciente,
					convert(varchar,DOCS.SecuenciaInterna)+'_'+convert(varchar,DOCS.NumeroPagina), 
					DOCS.NOMBREFILE,			 
					DOCS.Linea,
					DOCS.NumeroPagina,
					(case when @ValorNumerico > 0 then DOCS.descripcion+ ' Pág.' +RIGHT('00000000'+convert(varchar,DOCS.NumeroPagina),6)
						else DOCS.descripcion end
					) as descripcion,					
					DOCS.Extension,
					DOCS.Estado2,
					DOCS.Estado,
					DOCS.PATHFILE,
					(case when @ValorNumerico > 0 then 2 else DOCS. TipoItem end) as TipoItem,
					DOCS.SecuenciaInterna
			from 
			(
			
				Select 
					SS_HC_HistoriaAdjunta.UnidadReplicacion, 
					SS_HC_HistoriaAdjunta.CodigoReferencia, 
					SS_HC_HistoriaAdjunta.IdPaciente,
					SS_HC_HistoriaAdjuntaDetalle.SecuenciaInterna, 
					substring(SS_HC_HistoriaAdjuntaDetalle.RutaImagen,4,len(SS_HC_HistoriaAdjuntaDetalle.RutaImagen)) as NOMBREFILE,			 
					SS_HC_HistoriaAdjuntaDetalle.Linea,
					SS_HC_HistoriaAdjuntaDetalle.NumeroPagina,
					'Doc-'+CONVERT(varchar,SS_HC_HistoriaAdjunta.FechaAtencion,102)+ '[Cód:'+
					 SS_HC_HistoriaAdjunta.CodigoReferencia+']' as descripcion,
					SS_HC_HistoriaAdjuntaDetalle.Extension,
					'A' as Estado2,
					SS_HC_HistoriaAdjuntaDetalle.Estado,
					'http://10.10.2.62/Carpeta/' as PATHFILE,
					(case when
					(select COUNT(*) from SS_HC_HistoriaAdjuntaDetalle AUX 
						where SS_HC_HistoriaAdjuntaDetalle.IdPaciente  = AUX.IdPaciente
						and SS_HC_HistoriaAdjuntaDetalle.UnidadReplicacion  = AUX.UnidadReplicacion
						and SS_HC_HistoriaAdjuntaDetalle.SecuenciaInterna  = AUX.SecuenciaInterna
					) > 1 then 1 else 2 end) as TipoItem
					--SS_HC_HistoriaAdjuntaDetalle.RutaImagen 
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
					
			)AS DOCS
			order by DOCS.descripcion desc
			
			select * from @MA_MiscelaneosDetalle  
			
		end
	  ELSE IF (@ACCION='LISTARHOMOLOGACION')          
		 begin      
			if(@CodigoTabla= 'TABLA_ESPECIALIDAD')  
			  begin  
			   insert into @MA_MiscelaneosDetalle   
			   (AplicacionCodigo, Compania, CodigoTabla,CodigoElemento ,   
			   DescripcionLocal,ValorCodigo1,ValorCodigo2,ValorEntero1,ValorEntero2,
			   ValorCodigo3, ValorEntero3,ValorEntero4,ValorEntero5
			   )    
			   Select    
			   HOMOLOGACION.IdAplicativo,'99999',HOMOLOGACION.Especialidad, HOMOLOGACION.Especialidad,
			   SS_GE_Especialidad.Nombre,HOMOLOGACION.IdEspecialidad,'',HOMOLOGACION.IdEspecialidad,0,
			   '',HOMOLOGACION.IdAplicativo,SS_GE_Especialidad.Estado,0
				FROM SS_HA_HomologacionEspecialidad HOMOLOGACION   
				left JOIN SS_GE_Especialidad on (SS_GE_Especialidad.IdEspecialidad = HOMOLOGACION.IdEspecialidad) 
				WHERE   
				(@ValorEntero1 is null OR (HOMOLOGACION.IdEspecialidad = @ValorEntero1) or @ValorEntero1 =0)		   
		  end    
		  else 	if(@CodigoTabla= 'TABLA_SUCURSAL')  
			  begin  
			   insert into @MA_MiscelaneosDetalle   
			   (AplicacionCodigo, Compania, CodigoTabla,CodigoElemento ,   
			   DescripcionLocal,ValorCodigo1,ValorCodigo2,ValorEntero1,ValorEntero2,
			   ValorCodigo3, ValorEntero3,ValorEntero4,ValorEntero5
			   )    
			   Select    
			   HOMOLOGACION.IdAplicativo,'99999',HOMOLOGACION.CodigoSucursal, HOMOLOGACION.CodigoSucursal,
			   AC_Sucursal.DescripcionLocal,HOMOLOGACION.UnidadReplicacion,'',0,0,
			   '',HOMOLOGACION.IdAplicativo,0,0
				FROM SS_HA_HomologacionSucursal HOMOLOGACION   
				left JOIN AC_Sucursal on ( rtrim(AC_Sucursal.Sucursal) = HOMOLOGACION.UnidadReplicacion) 
				WHERE   
				(@ValorCodigo1 is null OR (HOMOLOGACION.UnidadReplicacion = @ValorCodigo1) or @ValorCodigo1 ='')		   								
		  end    
		  else 	if(@CodigoTabla= 'TABLA_PACIENTE')  
			  begin  
			   insert into @MA_MiscelaneosDetalle   
			   (AplicacionCodigo, Compania, CodigoTabla,CodigoElemento ,   
			   DescripcionLocal,ValorCodigo1,ValorCodigo2,ValorEntero1,ValorEntero2,
			   ValorCodigo3, ValorEntero3,ValorEntero4,ValorEntero5
			   )    
			   Select    
			   HOMOLOGACION.IdAplicativo,'99999',HOMOLOGACION.DNI, HOMOLOGACION.NumeroHHCC,
			   PERSONAMAST.NombreCompleto,HOMOLOGACION.IdPaciente,'',HOMOLOGACION.IdPaciente,0,
			   HOMOLOGACION.DNI,HOMOLOGACION.IdAplicativo,0,0
				FROM SS_HA_HomologacionPaciente HOMOLOGACION   
				left JOIN PERSONAMAST on (PERSONAMAST.Persona = HOMOLOGACION.IdPaciente) 
				WHERE   
				(@ValorEntero1 is null OR (HOMOLOGACION.IdPaciente = @ValorEntero1) or @ValorEntero1 =0)		   
								
		  end	
		  else if(@CodigoTabla= 'TABLA_SERVICIO')  
			  begin  
			   insert into @MA_MiscelaneosDetalle   
			   (AplicacionCodigo, Compania, CodigoTabla,CodigoElemento ,   
			   DescripcionLocal,ValorCodigo1,ValorCodigo2,ValorEntero1,ValorEntero2,
			   ValorCodigo3, ValorEntero3,ValorEntero4,ValorEntero5
			   )    
			   Select    
			   HOMOLOGACION.IdAplicativo,'99999',HOMOLOGACION.TipoServicio, HOMOLOGACION.TipoServicio,
			   SS_GE_Servicio.Descripcion,HOMOLOGACION.IdServicio,'',HOMOLOGACION.IdServicio,0,
			   '',HOMOLOGACION.IdAplicativo,SS_GE_Servicio.Estado,0
				FROM SS_HA_HomologacionServicio HOMOLOGACION   
				left JOIN SS_GE_Servicio on (SS_GE_Servicio.IdServicio = HOMOLOGACION.IdServicio) 
				WHERE   
				(@ValorEntero1 is null OR (HOMOLOGACION.IdServicio = @ValorEntero1) or @ValorEntero1 =0)		   
		  end 
		  else if(@CodigoTabla= 'TABLA_DIAGNOSTICO')  
			  begin  
			   insert into @MA_MiscelaneosDetalle   
			   (AplicacionCodigo, Compania, CodigoTabla,CodigoElemento ,   
			   DescripcionLocal,ValorCodigo1,ValorCodigo2,ValorEntero1,ValorEntero2,
			   ValorCodigo3, ValorEntero3,ValorEntero4,ValorEntero5
			   )    
			   Select    
			   HOMOLOGACION.IdAplicativo,'99999',HOMOLOGACION.CodigoDiagnostico, HOMOLOGACION.CodigoDiagnostico,
			   SS_GE_Diagnostico.Nombre,HOMOLOGACION.IdDiagnostico,'',HOMOLOGACION.IdDiagnostico,0,
			   '',HOMOLOGACION.IdAplicativo,SS_GE_Diagnostico.Estado,0
				FROM SS_HA_HomologacionDiagnostico HOMOLOGACION   
				left JOIN SS_GE_Diagnostico on (SS_GE_Diagnostico.IdDiagnostico = HOMOLOGACION.IdDiagnostico) 
				WHERE   
				(@ValorEntero1 is null OR (HOMOLOGACION.IdDiagnostico = @ValorEntero1) or @ValorEntero1 =0)		   
		  end 		  	  
		  else if(@CodigoTabla= 'TABLA_MEDICO')  
			  begin  
			   insert into @MA_MiscelaneosDetalle   
			   (AplicacionCodigo, Compania, CodigoTabla,CodigoElemento ,   
			   DescripcionLocal,ValorCodigo1,ValorCodigo2,ValorEntero1,ValorEntero2,
			   ValorCodigo3, ValorEntero3,ValorEntero4,ValorEntero5
			   )    
			   Select    
			   HOMOLOGACION.IdAplicativo,'99999',HOMOLOGACION.CodigoMedico, HOMOLOGACION.CodigoMedico,
			   PERSONAMAST.NombreCompleto,HOMOLOGACION.IdMedico,'',HOMOLOGACION.IdMedico,0,
			   '',HOMOLOGACION.IdAplicativo,0,0
				FROM SS_HA_HomologacionMedico HOMOLOGACION   
				left JOIN PERSONAMAST on (PERSONAMAST.Persona = HOMOLOGACION.IdMedico) 
				WHERE   
				(@ValorEntero1 is null OR (HOMOLOGACION.IdMedico = @ValorEntero1) or @ValorEntero1 =0)		   
		  end
		  else if(@CodigoTabla= 'TABLA_UNID_SERVICIO')  
			  begin  
			   insert into @MA_MiscelaneosDetalle   
			   (AplicacionCodigo, Compania, CodigoTabla,CodigoElemento ,   
			   DescripcionLocal,ValorCodigo1,ValorCodigo2,ValorEntero1,ValorEntero2,
			   ValorCodigo3, ValorEntero3,ValorEntero4,ValorEntero5
			   )    
			   Select    
			   HOMOLOGACION.IdAplicativo,'99999',HOMOLOGACION.TipoServicio, HOMOLOGACION.TipoServicio,
			   SS_HC_CatalogoUnidadServicio.Descripcion,HOMOLOGACION.IdServicio,'',HOMOLOGACION.IdServicio,0,
			   '',HOMOLOGACION.IdAplicativo,SS_HC_CatalogoUnidadServicio.Estado,0
				FROM SS_HA_HomologacionServicio HOMOLOGACION   
				left JOIN SS_HC_CatalogoUnidadServicio on (SS_HC_CatalogoUnidadServicio.IdUnidadServicio = HOMOLOGACION.IdServicio) 
				WHERE   
				(@ValorEntero1 is null OR (HOMOLOGACION.IdServicio = @ValorEntero1) or @ValorEntero1 =0)		   
		  end 		    	  
		  --LISTADO
		  select * from @MA_MiscelaneosDetalle  
	END		
          
END        
        
  
		  
        
/*  
  
    'CEG','9999','DOCEXT',  
    '001',
    'Pacientes/001.jpg',	-- RUTA
    1,
    1,
    'HC : 999',
    'VALO2',
    'A',
    2 ,
    'http://10.10.2.62/Carpeta/',
    'Pacientes/001.jpg'
    
select * from dbo.CM_CO_Establecimiento        
select * from MA_MiscelaneosDetalle      

exec SP_SS_HC_MA_MiscelaneosDetalle_LISTAR                
 null,        
 null,--'PP000',        
 null,  
 null,        
 NULL,        
         
 NULL,        
 8,        
 'CEG',        
 1076841,        
 NULL,         
         
 null,--04',        
 null,--'00',        
 NULL,        
 NULL,        
 NULL,        
         
	NUll,
	NUll,
	NUll,
	NUll,
	NUll,
	NUll,
	NUll,
	NUll,
	NUll,
	NUll,
	NUll,         
 0,        
 10,        
 'VIRTDOCUMENT'        
         
 */ 





GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_MA_MiscelaneosDetalleMEDICAMENTO_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE  [dbo].[SP_SS_HC_MA_MiscelaneosDetalleMEDICAMENTO_LISTAR]
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
 @ValorFecha datetime ,        
 @Estado char(1) ,        
 @UltimoUsuario varchar(100),         
        
	@UltimaFechaModif	datetime ,		
	@RowID	int ,
	@ValorEntero1	int ,
	@ValorEntero2	int ,
	@ValorEntero3	int ,
	@ValorEntero4	int ,
	@ValorEntero5	int ,
	@ValorCodigo6	varchar(25) ,
	@ValorCodigo7	varchar(25) ,
	@ValorEntero6	int ,
	@ValorEntero7	int  ,      
        
 @INICIO   int= null,          
 @NUMEROFILAS int = null ,        
 @ACCION VARCHAR(30)        
)        
        
AS        
BEGIN        

 declare @filtrosFavNum varchar(300) =null        
 DECLARE @TABLA_FILTROSFAVORITOS table         
 (        
  --SECUENCIA   int  NOT NULL   IDENTITY PRIMARY KEY,        
  descripcion varchar(100),        
  idFavorito   int,        
  numeroFavorito   int,          
  ESTADO  char(1)           
 )        
         
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
         
		 if(@ValorCodigo1 ='ACTIVO' and isnull(len(@ValorCodigo3),0) > 3)        
		 begin        
		   set @filtrosFavNum=@ValorCodigo3        
		   --set @grupos = 'R1_1y R1_2y R1_3y R1_4y R1_2'                 
		   set @filtrosFavNum = REPLACE(@filtrosFavNum,'R','Select ')        
		   set @filtrosFavNum = REPLACE(@filtrosFavNum,'y',' union ')        
		   set @filtrosFavNum = REPLACE(@filtrosFavNum,'_',' , ')        
		   set @filtrosFavNum = REPLACE(@filtrosFavNum,'yx',' ')        
		   set @filtrosFavNum = REPLACE(@filtrosFavNum,'union x',' ')        
		   --set @grupos = 'select 13,21 union select 22,25 union select 26,30 union select 31,40'        
		   insert into @TABLA_FILTROSFAVORITOS (idFavorito,numeroFavorito)        
		   EXEC(  @filtrosFavNum )                  
		 end    
		-- Medicamentos             
		if(@ValorCodigo1='ACTIVO' ) --FAVORITOS ACTIVOS  
		begin  
			insert into @MA_MiscelaneosDetalle 
			(AplicacionCodigo,
			 Compania,
			  CodigoTabla, 
			  CodigoElemento , 
			  DescripcionLocal, 
			  ValorNumerico,
			  ValorEntero1,
			 ValorEntero2,
			 ValorEntero3,
			 ValorCodigo1,
			 ValorCodigo2,
			 ValorCodigo3,
			 ValorCodigo4,
			 ValorCodigo7
			 ,ValorEntero4
			 )   
			      			
			  Select   
			  'CG',
			  '',
			   Familia,
			   SubFamilia ,
			ltrim(rtrim(DescripcionLocal))+'|['+ ltrim(rtrim(Linea))+'-'+ltrim(rtrim(Familia))+'-'+ltrim(rtrim(SubFamilia))+']'  as nombre,
			'1' as  tipofolder ,
			detalleFav.IdFavorito,
			detalleFav.NumeroFavorito,
			detalleFav.ValorId,
			WH_ClaseSubFamilia.Linea,
			WH_ClaseSubFamilia.Familia,
			WH_ClaseSubFamilia.SubFamilia,
			detalleFav.ValorTexto4, 
			Tipo = 'DCI'
			,isnull(SS_SG_RestriccionContrato.IndicadorEps,2)
			From WH_ClaseSubFamilia WITH(NOLOCK)
			 ----------------  
			 
			INNER JOIN  SS_HC_FavoritoDetalle detalleFav WITH(NOLOCK)
			 on(( @ValorCodigo1='ACTIVO')  
			and ( 
				rtrim(WH_ClaseSubFamilia.Linea) = detalleFav.ValorTexto5  
				and rtrim(WH_ClaseSubFamilia.Familia) = detalleFav.ValorTexto2  
				and rtrim(WH_ClaseSubFamilia.SubFamilia) = detalleFav.ValorTexto3  
				and 'ITEMS' = detalleFav.ValorTexto4  
				and detalleFav.numeroFavorito in (select NumeroFavorito   
					from @TABLA_FILTROSFAVORITOS AUX where detalleFav.IdFavorito = AUX.idFavorito
					)   
				and detalleFav.IdFavorito in (select idFavorito   
					from @TABLA_FILTROSFAVORITOS AUX where detalleFav.NumeroFavorito = AUX.numeroFavorito)   
				)   
			 )             
		   ---------------  OBTENER INDICADOR EPS-----------
			LEFT JOIN SS_SG_RestriccionContrato WITH(NOLOCK) ON(			
			SS_SG_RestriccionContrato.UnidadReplicacion=@ValorCodigo6
			and SS_SG_RestriccionContrato.IdContrato=@ValorEntero1
			and SS_SG_RestriccionContrato.TipoComponente='A'  --Artículo
			and rtrim(SS_SG_RestriccionContrato.Componente)=rtrim(WH_ClaseSubFamilia.SubFamilia)	   		
		   	)
		   	----------------------------------------------------
			where (@DescripcionLocal is null  OR @DescripcionLocal ='' 	 OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')         
			and (@CodigoElemento is null  OR @CodigoElemento =''		 OR  upper(SubFamilia) like '%'+upper(@CodigoElemento)+'%')        
			and (@ValorCodigo4 is null  OR @ValorCodigo4 =''  			 OR  upper(Linea) = upper(@ValorCodigo4))        
			and (@ValorCodigo5 is null  OR @ValorCodigo5 =''   			 OR  upper(Familia) = upper(@ValorCodigo5))        
			and exists(select 1 from WH_ItemMast WITH(NOLOCK) where WH_ItemMast.Linea = WH_ClaseSubFamilia.Linea        
			 and WH_ItemMast.Familia = WH_ClaseSubFamilia.Familia        
			 and WH_ItemMast.SubFamilia = WH_ClaseSubFamilia.SubFamilia         
			 and WH_ItemMast.UnidadCodigo is not null)  
			 
			   
			 
			 -----------TIPO MEDICINAS------------
			insert into @MA_MiscelaneosDetalle 
			(AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico
			,ValorEntero1,ValorEntero2,ValorEntero3
			,ValorCodigo1,ValorCodigo2,ValorCodigo3
			,ValorCodigo4,ValorCodigo7
			,ValorEntero4
			)          			                    
			SELECT 
			 'CG',(select DescripcionCorta from UnidadesMast WITH(NOLOCK) where UnidadCodigo = WH_ItemMast.UnidadCodigo),Familia, Item = WH_ItemMast.Item,  ltrim(rtrim(DescripcionLocal))+'|['+ ltrim(rtrim(Linea))+'-'+ltrim(rtrim(Familia))+'-'+ltrim(rtrim(SubFamilia))+ '-'+LTRIM(RTRIM(WH_ItemMast.Item))+']'  as nombre,'1' as  tipofolder ,
			 detalleFav.IdFavorito,detalleFav.NumeroFavorito,detalleFav.ValorId            
			 ,WH_ItemMast.Linea,WH_ItemMast.Familia,WH_ItemMast.SubFamilia
			,'ITEMS'  ,   Tipo = 'MED'
			,isnull(SS_SG_RestriccionContrato.IndicadorEps,2)
			FROM WH_ItemMast WITH(NOLOCK)
			 --------------  
			 inner JOIN  SS_HC_FavoritoDetalle detalleFav WITH(NOLOCK)
			 on(( @ValorCodigo1='ACTIVO')  
			and ( 
				ltrim(WH_ItemMast.Linea) = detalleFav.ValorTexto5  
				and rtrim(WH_ItemMast.Familia) = detalleFav.ValorTexto2  
				and (rtrim(WH_ItemMast.SubFamilia) +'|'	+ rtrim(WH_ItemMast.Item)) = rtrim(detalleFav.ValorTexto3)
				and 'ITEMS' = detalleFav.ValorTexto4  
				and detalleFav.numeroFavorito in (select NumeroFavorito   
					from @TABLA_FILTROSFAVORITOS AUX where detalleFav.IdFavorito = AUX.idFavorito
					)   
				and detalleFav.IdFavorito in (select idFavorito   
					from @TABLA_FILTROSFAVORITOS AUX where detalleFav.NumeroFavorito = AUX.numeroFavorito)   
				)   
			 )             
		   ---------------  OBTENER INDICADOR EPS-----------
			LEFT JOIN SS_SG_RestriccionContrato WITH(NOLOCK) ON(			
			SS_SG_RestriccionContrato.UnidadReplicacion=@ValorCodigo6
			and SS_SG_RestriccionContrato.IdContrato=@ValorEntero1
			and SS_SG_RestriccionContrato.TipoComponente='A'  --Artículo
			and rtrim(SS_SG_RestriccionContrato.Componente)=rtrim(WH_ItemMast.Item)	   		
		   	)
		   	----------------------------------------------------
			WHERE 
			    (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')         
			and (@CodigoElemento is null  OR @CodigoElemento =''      OR  upper(WH_ItemMast.Item) like '%'+upper(@CodigoElemento)+'%')        
			and (@ValorCodigo4 is null  OR @ValorCodigo4 =''          OR  upper(Linea) = upper(@ValorCodigo4))        
			and (@ValorCodigo5 is null  OR @ValorCodigo5 =''          OR  upper(Familia) = upper(@ValorCodigo5))        
			AND WH_ItemMast.Estado = 'A'								
			--WH_ItemMast.Linea IN ('04', '13')
				
								
		end
		else		
		begin
		   --TIPO DCI
		  declare @Stock int
		   set @Stock=0		   
		   if (@ValorEntero7!=null or @ValorEntero7!='')
				begin
				set @Stock= @ValorEntero7
				end
			insert into @MA_MiscelaneosDetalle 
			(AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico
			,ValorCodigo1,ValorCodigo2,ValorCodigo3			
			,ValorCodigo4,ValorCodigo7
			,ValorEntero4
			,UltimoUsuario	--- almacen		--ANGEL15
	
			)  
		   
			  Select   'CG','', Familia,SubFamilia ,   ltrim(rtrim(DescripcionLocal))+'|['+ ltrim(rtrim(Linea))+'-'+ltrim(rtrim(Familia))+'-'+ltrim(rtrim(SubFamilia))+']' as nombre, '1' as  tipofolder ,
				Linea,Familia,SubFamilia
			,'ITEMS' ,   Tipo = 'DCI'
			,isnull(SS_SG_RestriccionContrato.IndicadorEps,2) ,@UltimoUsuario --ANGEL15
			--	,5  --angel 12
			
			  From WH_ClaseSubFamilia WITH(NOLOCK)
		   ---------------  OBTENER INDICADOR EPS-----------
			LEFT JOIN SS_SG_RestriccionContrato WITH(NOLOCK) ON(			
			SS_SG_RestriccionContrato.UnidadReplicacion=@ValorCodigo6
			and SS_SG_RestriccionContrato.IdContrato=@ValorEntero1
			and SS_SG_RestriccionContrato.TipoComponente='A'  --Artículo
			and rtrim(SS_SG_RestriccionContrato.Componente)=rtrim(WH_ClaseSubFamilia.SubFamilia)	   		
		   	)
         
		   
		   	----------------------------------------------------			  
			  where 
					(@DescripcionLocal is null  OR @DescripcionLocal ='' OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')         
				and (@CodigoElemento is null  OR @CodigoElemento =''     OR  upper(SubFamilia) like '%'+upper(@CodigoElemento)+'%')        
				and (@ValorCodigo4 is null  OR @ValorCodigo4 =''	     OR  upper(Linea) = upper(@ValorCodigo4))        
				and (@ValorCodigo5 is null  OR @ValorCodigo5 =''       	 OR  upper(Familia) = upper(@ValorCodigo5))        
				AND WH_ClaseSubFamilia.Estado = 'A'			  
			and exists(select 1 from WH_ItemMast WITH(NOLOCK)
					where WH_ItemMast.Linea = WH_ClaseSubFamilia.Linea        
					 and WH_ItemMast.Familia = WH_ClaseSubFamilia.Familia        
					 and WH_ItemMast.SubFamilia = WH_ClaseSubFamilia.SubFamilia         
					 AND WH_ItemMast.Estado = 'A'      
					 and WH_ItemMast.UnidadCodigo is not null					
				--inicio prueba sin stock
					and WH_ItemMast.Item collate Modern_Spanish_CI_AS in (
						select Item from BDOncologico.dbo.Wh_ItemAlmacenLote XLOTE WITH(NOLOCK)
						where Item collate Modern_Spanish_CI_AS = WH_ItemMast.Item collate Modern_Spanish_CI_AS
						and (@ValorEntero7 is null or XLOTE.StockActual >= @Stock)
						and (@UltimoUsuario is null or XLOTE.almacencodigo = @UltimoUsuario) --ANGEL15
						
						)
			 )    
			 
			 --TIPO MEDICINA
			insert into @MA_MiscelaneosDetalle 
			(AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico
			,ValorCodigo1,ValorCodigo2,ValorCodigo3
			,ValorCodigo4,ValorCodigo7
			,ValorEntero4,UltimoUsuario  --angel15
			,ValorEntero5
			)          			                    
			SELECT 
			 'CG',und.DescripcionCorta,Familia, Item = WH_ItemMast.Item,  ltrim(rtrim(DescripcionLocal))+'|['+ ltrim(rtrim(Linea))+'-'+ltrim(rtrim(Familia))+'-'+ltrim(rtrim(SubFamilia))+ '-'+LTRIM(RTRIM(WH_ItemMast.Item))+ ']'  as nombre,'1' as  tipofolder ,
			WH_ItemMast.Linea,WH_ItemMast.Familia,WH_ItemMast.SubFamilia
			,'ITEMS'  ,   Tipo = 'MED'
			,isnull(SS_SG_RestriccionContrato.IndicadorEps,2),@UltimoUsuario --ANGEL15
			,und.IdUnidadMedida
			FROM WH_ItemMast WITH(NOLOCK)


		   ---------------  OBTENER INDICADOR EPS-----------
		   left join UnidadesMast und WITH(NOLOCK) on und.UnidadCodigo = WH_ItemMast.UnidadCodigo
			LEFT JOIN SS_SG_RestriccionContrato WITH(NOLOCK) ON(			
			SS_SG_RestriccionContrato.UnidadReplicacion=@ValorCodigo6
			and SS_SG_RestriccionContrato.IdContrato=@ValorEntero1
			and SS_SG_RestriccionContrato.TipoComponente='A'  --Artículo
			and rtrim(SS_SG_RestriccionContrato.Componente)=rtrim(WH_ItemMast.Item)	   		
		   	)
		   	----------------------------------------------------			
			WHERE 
			  (@DescripcionLocal is null  OR @DescripcionLocal =''         
			 OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')         
			and (@CodigoElemento is null  OR @CodigoElemento =''         
			 OR  upper(WH_ItemMast.Item) like '%'+upper(@CodigoElemento)+'%')        
			and (@ValorCodigo4 is null  OR @ValorCodigo4 =''         
				 OR  upper(Linea) = upper(@ValorCodigo4))        
			and (@ValorCodigo5 is null  OR @ValorCodigo5 =''         
				 OR  upper(Familia) = upper(@ValorCodigo5))        
			AND WH_ItemMast.Estado = 'A'	
			

    -- inicio prueba sin stock
		and WH_ItemMast.Item collate Modern_Spanish_CI_AS in (
		 select Item from BDOncologico.dbo.Wh_ItemAlmacenLote XLOTE WITH(NOLOCK)
		 where Item collate Modern_Spanish_CI_AS = WH_ItemMast.Item collate Modern_Spanish_CI_AS
		 and (@ValorEntero7 is null or XLOTE.StockActual >= @Stock)
		and (@UltimoUsuario is null or  XLOTE.almacencodigo  = @UltimoUsuario) --ANGEL15
		 ) 		
                            		
		end
     
    select @CONTADOR = COUNT(*) from @MA_MiscelaneosDetalle        
       
          
  SELECT         
     [AplicacionCodigo]        
      ,[CodigoTabla]        
      ,[Compania]        
      ,[CodigoElemento]        
      ,[DescripcionLocal]        
      ,[DescripcionExtranjera]        
      ,[ValorNumerico]        
      ,[ValorCodigo1]        
      ,[ValorCodigo2]        
      ,[ValorCodigo3]        
      ,[ValorCodigo4]        
      ,[ValorCodigo5]        
      ,[ValorFecha]        
      ,[Estado]        
      ,[UltimoUsuario]        
      ,[UltimaFechaModif]        
      ,[Timestamp]        
      ,[ACCION]        
      ,[RowID]        
      ,[ValorEntero1]        
      ,[ValorEntero2]        
      ,[ValorEntero3]        
      ,ValorEPSX as ValorEntero4
      ,[ValorEntero5]        
      ,[ValorCodigo6]        
      ,[ValorCodigo7]        
      ,[ValorEntero6]        
      ,convert(integer,Contador) as ValorEntero7 --AUX PARA CONTADOR
  FROM (SELECT        
     detalles.*
     ,isnull(detalles.ValorEntero4,0) as ValorEPSX
     ,@CONTADOR AS Contador,        
            ROW_NUMBER() OVER (ORDER BY CodigoTabla ASC ) AS RowNumber            
     from @MA_MiscelaneosDetalle  as detalles           
    
     ) AS LISTADO        
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR          
            RowNumber BETWEEN @Inicio  AND @NumeroFilas      -- PAGINADO  
                    
          
END        
        
  
		  
        
/*  
  
    'CEG','9999','DOCEXT',  
    '001',
    'Pacientes/001.jpg',	-- RUTA
    1,
    1,
    'HC : 999',
    'VALO2',
    'A',
    2 ,
    'http://10.10.2.62/Carpeta/',
    'Pacientes/001.jpg'
    
select * from dbo.CM_CO_Establecimiento        
select * from MA_MiscelaneosDetalle      

exec SP_SS_HC_MA_MiscelaneosDetalle_LISTAR                
 null,        
 null,--'PP000',        
 null,  
 null,        
 NULL,        
         
 NULL,        
 8,        
 'CEG',        
 1076841,        
 NULL,         
         
 null,--04',        
 null,--'00',        
 NULL,        
 NULL,        
 NULL,        
         
	NUll,
	NUll,
	NUll,
	NUll,
	NUll,
	NUll,
	NUll,
	NUll,
	NUll,
	NUll,
	NUll,         
 0,        
 10,        
 'VIRTDOCUMENT'        
         
 */ 





GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_MA_MiscelaneosDetallePROCEDIMIENTO_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE  [dbo].[SP_SS_HC_MA_MiscelaneosDetallePROCEDIMIENTO_LISTAR]
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
 @ValorFecha datetime ,        
 @Estado char(1) ,        
 @UltimoUsuario varchar(100),         
        
	@UltimaFechaModif	datetime ,		
	@RowID	int ,
	@ValorEntero1	int ,
	@ValorEntero2	int ,
	@ValorEntero3	int ,
	@ValorEntero4	int ,
	@ValorEntero5	int ,
	@ValorCodigo6	varchar(25) ,
	@ValorCodigo7	varchar(25) ,
	@ValorEntero6	int ,
	@ValorEntero7	int  ,      
        
 @INICIO   int= null,          
 @NUMEROFILAS int = null ,        
 @ACCION VARCHAR(30)        
)        
        
AS        
BEGIN        

 declare @filtrosFavNum varchar(300) =null        
 DECLARE @TABLA_FILTROSFAVORITOS table         
 (        
  --SECUENCIA   int  NOT NULL   IDENTITY PRIMARY KEY,        
  descripcion varchar(100),        
  idFavorito   int,        
  numeroFavorito   int,          
  ESTADO  char(1)           
 )        
         
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

 if(@ValorCodigo1 ='ACTIVO' and isnull(len(@ValorCodigo3),0) > 3)        
 begin        
   set @filtrosFavNum=@ValorCodigo3        
   --set @grupos = 'R1_1y R1_2y R1_3y R1_4y R1_2'                 
   set @filtrosFavNum = REPLACE(@filtrosFavNum,'R','Select ')        
   set @filtrosFavNum = REPLACE(@filtrosFavNum,'y',' union ')        
   set @filtrosFavNum = REPLACE(@filtrosFavNum,'_',' , ')        
   set @filtrosFavNum = REPLACE(@filtrosFavNum,'yx',' ')        
   set @filtrosFavNum = REPLACE(@filtrosFavNum,'union x',' ')        
   --set @grupos = 'select 13,21 union select 22,25 union select 26,30 union select 31,40'        
   insert into @TABLA_FILTROSFAVORITOS (idFavorito,numeroFavorito)        
   EXEC(  @filtrosFavNum )                  
 end           
  /* select * from SS_HC_FavoritoDetalle detalleFav        
  inner join @TABLA_FILTROSFAVORITOS filtroFav         
  on (filtroFav.idFavorito = detalleFav.IdFavorito          
  and filtroFav.numeroFavorito = detalleFav.NumeroFavorito)        
  */        
 ---------------------------------------------            
 
 /****PARA DIAGNÓSTICOS  *****/          
 if(@ValorCodigo1='ACTIVO' ) --FAVORITOS ACTIVOS  
 begin  
    insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal,   
    ValorNumerico,   
    ValorEntero1,ValorEntero2,ValorEntero3)          
    Select  'CG','99999', CodigoPadre,CodigoDiagnostico, case tipofolder           
    when 1 then  ltrim(rtrim(Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),IdDiagnostico)))+']'           
    else ltrim(rtrim(Nombre)) end as nombre, tipofolder ,  
    detalleFav.IdFavorito,detalleFav.NumeroFavorito,detalleFav.ValorId  
    From     
     SS_GE_Diagnostico WITH(NOLOCK)
     --------------  
     inner JOIN  SS_HC_FavoritoDetalle detalleFav WITH(NOLOCK)
     on(( @ValorCodigo1='ACTIVO')  
    and ( SS_GE_Diagnostico.idDiagnostico = detalleFav.ValorId  
    and detalleFav.numeroFavorito in (select NumeroFavorito   
     from @TABLA_FILTROSFAVORITOS AUX where detalleFav.IdFavorito = AUX.idFavorito)   
    and detalleFav.IdFavorito in (select idFavorito   
     from @TABLA_FILTROSFAVORITOS AUX where detalleFav.NumeroFavorito = AUX.numeroFavorito)   
    )   
     )             
   ---------------  
    where NombreTabla = @CodigoTabla        
  and (@DescripcionLocal is null  OR @DescripcionLocal =''         
   OR  upper(Nombre) like '%'+upper(@DescripcionLocal)+'%')         
  and (@CodigoElemento is null  OR @CodigoElemento =''         
   OR  upper(CodigoDiagnostico) like '%'+upper(@CodigoElemento)+'%')           
  and tipofolder = 1            
 end  
 else  
 begin  
    insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal,   
    ValorNumerico)          
    Select  'CG','99999', CodigoPadre,CodigoDiagnostico, case tipofolder           
    when 1 then  ltrim(rtrim(Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),IdDiagnostico)))+']'           
    else ltrim(rtrim(Nombre)) end as nombre, tipofolder           
    From     
     SS_GE_Diagnostico WITH(NOLOCK)       
    where NombreTabla = @CodigoTabla        
  and (@DescripcionLocal is null  OR @DescripcionLocal =''         
   OR  upper(Nombre) like '%'+upper(@DescripcionLocal)+'%')         
  and (@CodigoElemento is null  OR @CodigoElemento =''         
   OR  upper(CodigoDiagnostico) like '%'+upper(@CodigoElemento)+'%')           
  and tipofolder = 1      
 end  
   
/****PARA PROC. MEDICO   (CPT)  *****/          
 if(@ValorCodigo1='ACTIVO' ) --FAVORITOS ACTIVOS  
 begin  
     insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico  
     ,ValorEntero1,ValorEntero2,ValorEntero3
     ,ValorEntero4,ValorCodigo1
     )    
     Select  'CG','99999', CodigoPadre,CodigoProcedimiento,  case tipofolder           
     when 1 then  ltrim(rtrim(Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),IdProcedimiento)))+']'           
     else ltrim(rtrim(Nombre)) end as nombre,  tipofolder         ,         
     detalleFav.IdFavorito,detalleFav.NumeroFavorito,detalleFav.ValorId
     ,0,IdProcedimiento
     From SS_GE_ProcedimientoMedico WITH(NOLOCK)
      --------------  
      inner JOIN  SS_HC_FavoritoDetalle detalleFav WITH(NOLOCK)
      on(( @ValorCodigo1='ACTIVO')  
     and ( SS_GE_ProcedimientoMedico.IdProcedimiento = detalleFav.ValorId  
     and detalleFav.numeroFavorito in (select NumeroFavorito   
      from @TABLA_FILTROSFAVORITOS AUX where detalleFav.IdFavorito = AUX.idFavorito)   
     and detalleFav.IdFavorito in (select idFavorito   
      from @TABLA_FILTROSFAVORITOS AUX where detalleFav.NumeroFavorito = AUX.numeroFavorito)   
     )   
      )             
    ---------------  
     where NombreTabla = @CodigoTabla        
   and (@DescripcionLocal is null  OR @DescripcionLocal =''         
    OR  upper(Nombre) like '%'+upper(@DescripcionLocal)+'%')         
   and (@CodigoElemento is null  OR @CodigoElemento =''         
    OR  upper(CodigoProcedimiento) like '%'+upper(@CodigoElemento)+'%')           
   and tipofolder = 1       
 end  
 else  
 begin  
 
   -------------------         
     --where CodigoPadre = @CodigoElemento --and nombretabla='DD000'          
    --and nombretabla in ( @ValorCodigo1)            
     insert into @MA_MiscelaneosDetalle 
     (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, 
     ValorNumerico,ValorEntero4,ValorCodigo1)          
     Select  'CG','99999', CodigoPadre,CodigoProcedimiento,  case tipofolder           
     when 1 then  ltrim(rtrim(Nombre))         
     else ltrim(rtrim(Nombre)) end as nombre,  
     tipofolder,0,IdProcedimiento     /**aqui se agrego este campo*/     
     From SS_GE_ProcedimientoMedico WITH(NOLOCK)
     where NombreTabla = @CodigoTabla        
   and (@DescripcionLocal is null  OR @DescripcionLocal =''         
    OR  upper(Nombre) like '%'+upper(@DescripcionLocal)+'%')         
   and (@CodigoElemento is null  OR @CodigoElemento =''         
    OR  upper(CodigoProcedimiento) like '%'+upper(@CodigoElemento)+'%')           
   and tipofolder = 1          
        
   
 end  
      
/****PARA PROC. MEDICO DOS  (CIAP)  *****/       
 if(@ValorCodigo1='ACTIVO' ) --FAVORITOS ACTIVOS  
 begin  
     insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico  
     ,ValorEntero1,ValorEntero2,ValorEntero3)     
     Select  'CG','99999', CodigoPadre,CodigoProcedimientoDos ,  case tipofolder           
     when 1 then  ltrim(rtrim(Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),IdProcedimientoDos)))+']'           
     else ltrim(rtrim(Nombre)) end as nombre,  tipofolder           
     ,detalleFav.IdFavorito,detalleFav.NumeroFavorito,detalleFav.ValorId  
     From SS_GE_ProcedimientoMedicoDos WITH(NOLOCK)
      --------------  
      inner JOIN  SS_HC_FavoritoDetalle detalleFav WITH(NOLOCK)
      on(( @ValorCodigo1='ACTIVO')  
     and ( SS_GE_ProcedimientoMedicoDos.IdProcedimientoDos = detalleFav.ValorId  
     and detalleFav.numeroFavorito in (select NumeroFavorito   
      from @TABLA_FILTROSFAVORITOS AUX where detalleFav.IdFavorito = AUX.idFavorito)   
     and detalleFav.IdFavorito in (select idFavorito   
      from @TABLA_FILTROSFAVORITOS AUX where detalleFav.NumeroFavorito = AUX.numeroFavorito)   
     )   
      )             
    ---------------  
     where NombreTabla = @CodigoTabla --and nombretabla='PD000'          
   and (@DescripcionLocal is null  OR @DescripcionLocal =''         
    OR  upper(Nombre) like '%'+upper(@DescripcionLocal)+'%')         
   and (@CodigoElemento is null  OR @CodigoElemento =''         
    OR  upper(CodigoProcedimientoDos) like '%'+upper(@CodigoElemento)+'%')           
   and tipofolder = 1     
 end  
 else    
 begin  
    --where CodigoPadre = @CodigoElemento --and nombretabla='PP000'          
    --and nombretabla in ( @ValorCodigo1)                     
    insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico)          
    Select  'CG','99999', CodigoPadre,CodigoProcedimientoDos ,  case tipofolder           
    when 1 then  ltrim(rtrim(Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),IdProcedimientoDos)))+']'           
    else ltrim(rtrim(Nombre)) end as nombre,  tipofolder           
    From SS_GE_ProcedimientoMedicoDos WITH(NOLOCK)
     where NombreTabla = @CodigoTabla --and nombretabla='PD000'          
   and (@DescripcionLocal is null  OR @DescripcionLocal =''         
    OR  upper(Nombre) like '%'+upper(@DescripcionLocal)+'%')         
   and (@CodigoElemento is null  OR @CodigoElemento =''         
    OR  upper(CodigoProcedimientoDos) like '%'+upper(@CodigoElemento)+'%')           
   and tipofolder = 1            
   
 end            
         
         
/****PARA CUERPO HUMANO  *****/        
 if(@ValorCodigo1='ACTIVO' ) --FAVORITOS ACTIVOS  
 begin  
   insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico  
   ,ValorEntero1,ValorEntero2,ValorEntero3)     
    Select  'CG','99999', CodigoPadre,Codigo ,  case tipofolder           
    when 1 then  ltrim(rtrim(Descripcion))+'|['+ ltrim(rtrim(Convert(varchar(10),IdCuerpoHumano)))+']'           
    else ltrim(rtrim(Descripcion)) end as nombre,  tipofolder           
    ,detalleFav.IdFavorito,detalleFav.NumeroFavorito,detalleFav.ValorId  
    From  SS_HC_CuerpoHumano WITH(NOLOCK)
      --------------  
      inner JOIN  SS_HC_FavoritoDetalle detalleFav WITH(NOLOCK)
      on(( @ValorCodigo1='ACTIVO')  
     and ( SS_HC_CuerpoHumano.IdCuerpoHumano = detalleFav.ValorId  
     and detalleFav.numeroFavorito in (select NumeroFavorito   
      from @TABLA_FILTROSFAVORITOS AUX where detalleFav.IdFavorito = AUX.idFavorito)   
     and detalleFav.IdFavorito in (select idFavorito   
      from @TABLA_FILTROSFAVORITOS AUX where detalleFav.NumeroFavorito = AUX.numeroFavorito)   
     )   
      )             
    ---------------  
    where NombreTabla = @CodigoTabla        
   and (@DescripcionLocal is null  OR @DescripcionLocal =''         
    OR  upper(Descripcion) like '%'+upper(@DescripcionLocal)+'%')         
   and (@CodigoElemento is null  OR @CodigoElemento =''         
    OR  upper(Codigo) like '%'+upper(@CodigoElemento)+'%')           
   and tipofolder = 1   
   
   
 end  
 else  
 begin  
   insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico)          
    Select  'CG','99999', CodigoPadre,Codigo ,  case tipofolder      
    when 1 then  ltrim(rtrim(Descripcion))+'|['+ ltrim(rtrim(Convert(varchar(10),IdCuerpoHumano)))+']'           
    else ltrim(rtrim(Descripcion)) end as nombre,  tipofolder           
    From  SS_HC_CuerpoHumano            
    where NombreTabla = @CodigoTabla        
   and (@DescripcionLocal is null  OR @DescripcionLocal =''         
    OR  upper(Descripcion) like '%'+upper(@DescripcionLocal)+'%')         
   and (@CodigoElemento is null  OR @CodigoElemento =''         
    OR  upper(Codigo) like '%'+upper(@CodigoElemento)+'%')           
   and tipofolder = 1           
     --where CodigoPadre = @CodigoElemento --and nombretabla='PD000'     
 end  
              
  /****PARA COMPONENTES (SEGUS) *****/
 if(@ValorCodigo1='ACTIVO' ) --FAVORITOS ACTIVOS  
 begin  

  PRINT 'LLEGOOOOO  ACTIVO SEGUS'
   insert into @MA_MiscelaneosDetalle 
   (AplicacionCodigo, Compania, CodigoTabla, CodigoElemento   , DescripcionLocal, ValorNumerico,
   ValorEntero1,ValorEntero2,ValorEntero3
   ,ValorEntero4,ValorCodigo1
   )     
    Select  'CG',ISNULL(CM_CO_TablaMaestroDetalle.Nombre,'9999'),@CodigoTabla,CodigoComponente ,ltrim(rtrim(CM_CO_Componente.Nombre))+'|['+CodigoComponente+']'  as nombre, '1'           
    ,detalleFav.IdFavorito,detalleFav.NumeroFavorito,detalleFav.ValorId  
    ,isnull(SS_SG_RestriccionContrato.IndicadorEps,2),CodigoComponente
    From     SS_GE_ComponentePrestacion WITH(NOLOCK)
	INNER JOIN CM_CO_Componente WITH(NOLOCK) ON CM_CO_Componente.CodigoComponente =  SS_GE_ComponentePrestacion.Componente 
	LEFT JOIN CM_CO_ClasificacionComponente WITH(NOLOCK) ON CM_CO_Componente.IdClasificacion = CM_CO_ClasificacionComponente.IdClasificacion 
	LEFT JOIN SS_GE_ServicioPrestacion WITH(NOLOCK) ON SS_GE_ComponentePrestacion.Componente = SS_GE_ServicioPrestacion.Componente 
	LEFT JOIN SS_GE_Servicio WITH(NOLOCK) ON SS_GE_ServicioPrestacion.IdServicio = SS_GE_Servicio.IdServicio 
	INNER JOIN SG_UnidadReplicacionPrestacion WITH(NOLOCK) ON SG_UnidadReplicacionPrestacion.Prestacion = CM_CO_Componente.CodigoComponente 
	AND  SG_UnidadReplicacionPrestacion.Estado = 2 AND SG_UnidadReplicacionPrestacion.UnidadReplicacion =     @ValorCodigo6 --'CEG' MULTISUCURSAL       
      --------------  
      inner JOIN  SS_HC_FavoritoDetalle detalleFav WITH(NOLOCK)
      on(( @ValorCodigo1='ACTIVO')  
     and ( CM_CO_Componente.CodigoComponente = detalleFav.ValorTexto3  
     and detalleFav.numeroFavorito in (select NumeroFavorito   
      from @TABLA_FILTROSFAVORITOS AUX where detalleFav.IdFavorito = AUX.idFavorito)   
     and detalleFav.IdFavorito in (select idFavorito   
      from @TABLA_FILTROSFAVORITOS AUX where detalleFav.NumeroFavorito = AUX.numeroFavorito)   
     )   
      )             
		   ---------------  OBTENER INDICADOR EPS-----------
			LEFT JOIN SS_SG_RestriccionContrato WITH(NOLOCK) ON(			
			SS_SG_RestriccionContrato.UnidadReplicacion=@ValorCodigo6 --'CEG'
			and SS_SG_RestriccionContrato.IdContrato=@ValorEntero1
			and SS_SG_RestriccionContrato.TipoComponente='C'  --Artículo
			and rtrim(SS_SG_RestriccionContrato.Componente)=rtrim(CM_CO_Componente.CodigoComponente)	   		
		   	)
		   	----------------------------------------------------
			   LEFT JOIN CM_CO_TablaMaestroDetalle WITH(NOLOCK)
	ON (CM_CO_TablaMaestroDetalle.IdTablaMaestro='101')
	AND (CM_CO_TablaMaestroDetalle.IdCodigo=CM_CO_Componente.IDTipoOrdenAtencion)
		--and (CM_CO_TablaMaestroDetalle.Estado='2') --AÑADIDO PARA PEDIDO DE ARACELI OCTUBRE FILTRO SERVICIO

    where
    NombreTabla = @CodigoTabla        
   and (@DescripcionLocal is null  OR @DescripcionLocal =''         
    OR  upper(CM_CO_Componente.Nombre) like '%'+upper(@DescripcionLocal)+'%')         
   and (@CodigoElemento is null  OR @CodigoElemento =''         
    OR  upper(CodigoComponente) like '%'+upper(@CodigoElemento)+'%')                   
   and (@ValorCodigo2 is null  OR @ValorCodigo2 =''         
    OR  upper(CM_CO_TablaMaestroDetalle.Nombre) like '%'+upper(@ValorCodigo2)+'%') 
		 AND CM_CO_Componente.ESTADO=2   --AÑADIDO PARA PRUEBA ESTADO EN SEGUS
 end  
 else  
 begin  

  PRINT 'LLEGOOOOO  INACTIVO SEGUS'
   insert into @MA_MiscelaneosDetalle 
   (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico
   ,ValorEntero4,ValorCodigo1
   )     
    Select      
	'CG',ISNULL(CM_CO_TablaMaestroDetalle.Nombre,'9999'), @CodigoTabla,CodigoComponente ,ltrim(rtrim(CM_CO_Componente.Nombre))+'|['+CodigoComponente+']'  as nombre, '1' 
	,isnull(SS_SG_RestriccionContrato.IndicadorEps,2),CodigoComponente
    From  SS_GE_ComponentePrestacion WITH(NOLOCK)
	INNER JOIN CM_CO_Componente WITH(NOLOCK) ON CM_CO_Componente.CodigoComponente =  SS_GE_ComponentePrestacion.Componente 
	LEFT JOIN CM_CO_ClasificacionComponente WITH(NOLOCK) ON CM_CO_Componente.IdClasificacion = CM_CO_ClasificacionComponente.IdClasificacion 
	LEFT JOIN SS_GE_ServicioPrestacion WITH(NOLOCK) ON SS_GE_ComponentePrestacion.Componente = SS_GE_ServicioPrestacion.Componente 
	LEFT JOIN SS_GE_Servicio WITH(NOLOCK) ON SS_GE_ServicioPrestacion.IdServicio = SS_GE_Servicio.IdServicio 
	INNER JOIN SG_UnidadReplicacionPrestacion WITH(NOLOCK) ON SG_UnidadReplicacionPrestacion.Prestacion = CM_CO_Componente.CodigoComponente 
	AND  SG_UnidadReplicacionPrestacion.Estado = 2 
	AND SG_UnidadReplicacionPrestacion.UnidadReplicacion =     @ValorCodigo6 --'CEG' MULTISUCURSAL 
	----CM_CO_Componente ---- JORDAN MATEO    
		   ---------------  OBTENER INDICADOR EPS-----------
			LEFT JOIN SS_SG_RestriccionContrato WITH(NOLOCK) ON(			
			SS_SG_RestriccionContrato.UnidadReplicacion=@ValorCodigo6
			and SS_SG_RestriccionContrato.IdContrato=@ValorEntero1
			and SS_SG_RestriccionContrato.TipoComponente='C'  --Artículo
			and rtrim(SS_SG_RestriccionContrato.Componente)=rtrim(CM_CO_Componente.CodigoComponente)	   		
		   	)
		   	----------------------------------------------------
		   LEFT JOIN CM_CO_TablaMaestroDetalle WITH(NOLOCK)
	ON (CM_CO_TablaMaestroDetalle.IdTablaMaestro='101')
	AND (CM_CO_TablaMaestroDetalle.IdCodigo=CM_CO_Componente.IDTipoOrdenAtencion)
	
	 	    
    where
    NombreTabla = @CodigoTabla        
   and (@DescripcionLocal is null  OR @DescripcionLocal =''         
    OR  upper(CM_CO_Componente.Nombre) like '%'+upper(@DescripcionLocal)+'%')         
   and (@CodigoElemento is null  OR @CodigoElemento =''         
    OR  upper(CodigoComponente) like '%'+upper(@CodigoElemento)+'%') 
	and (@ValorCodigo2 is null  OR @ValorCodigo2 =''         
    OR  upper(CM_CO_TablaMaestroDetalle.Nombre) like '%'+upper(@ValorCodigo2)+'%')             
     --where CodigoPadre = @CodigoElemento --and nombretabla='PD000'     
 	 AND CM_CO_Componente.ESTADO=2   --AÑADIDO PARA PRUEBAESTADO
 end       
      
  select @CONTADOR = COUNT(*) from @MA_MiscelaneosDetalle        
     /*where        (        
      (@DescripcionLocal is null  OR @DescripcionLocal =''         
      OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')         
      and ValorNumerico = 1        
      )*/        
      --OR (ValorNumerico <> 1)        
          
  SELECT         
     [AplicacionCodigo]        
      ,[CodigoTabla]        
      ,[Compania]        
      ,[CodigoElemento]        
      ,[DescripcionLocal]        
      ,[DescripcionExtranjera]        
      ,[ValorNumerico]        
      ,[ValorCodigo1]        
      ,[ValorCodigo2]        
      ,[ValorCodigo3]        
      ,[ValorCodigo4]        
      ,[ValorCodigo5]        
      ,[ValorFecha]        
      ,[Estado]        
      ,[UltimoUsuario]        
      ,[UltimaFechaModif]        
      ,[Timestamp]        
      ,[ACCION]        
      ,[RowID]        
      ,[ValorEntero1]        
      ,[ValorEntero2]        
      ,[ValorEntero3]        
      ,ValorEPSX as ValorEntero4
      ,[ValorEntero5]        
      ,[ValorCodigo6]        
      ,[ValorCodigo7]        
      ,[ValorEntero6]        
      ,convert(integer,Contador) as ValorEntero7 --AUX PARA CONTADOR
  FROM (SELECT        
     detalles.*              
     ,isnull(detalles.ValorEntero4,0) as ValorEPSX      
     ,@CONTADOR AS Contador,        
            ROW_NUMBER() OVER (ORDER BY CodigoTabla ASC ) AS RowNumber            
     from @MA_MiscelaneosDetalle  as detalles           
    
     ) AS LISTADO        
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR          
            RowNumber BETWEEN @Inicio  AND @NumeroFilas       
          
END        
        
  
		  
        
/*  
  
    'CEG','9999','DOCEXT',  
    '001',
    'Pacientes/001.jpg',	-- RUTA
    1,
    1,
    'HC : 999',
    'VALO2',
    'A',
    2 ,
    'http://10.10.2.62/Carpeta/',
    'Pacientes/001.jpg'
    
select * from dbo.CM_CO_Establecimiento        
select * from MA_MiscelaneosDetalle      

exec SP_SS_HC_MA_MiscelaneosDetalle_LISTAR                
 null,        
 null,--'PP000',        
 null,  
 null,        
 NULL,        
         
 NULL,        
 8,        
 'CEG',        
 1076841,        
 NULL,         
         
 null,--04',        
 null,--'00',        
 NULL,        
 NULL,        
 NULL,        
         
	NUll,
	NUll,
	NUll,
	NUll,
	NUll,
	NUll,
	NUll,
	NUll,
	NUll,
	NUll,
	NUll,         
 0,        
 10,        
 'VIRTDOCUMENT'        
         
 */ 





GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Medicamento_Kardex_FE_Insert]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_Medicamento_Kardex_FE_Insert]
(
	@UnidadReplicacion	char(4),
	@IdEpisodioAtencion	bigint,
	@IdPaciente	int,
	@EpisodioClinico	int,
	@Secuencia	int,
	@CodigoComponente	varchar(25),
	@IdVia	int,
	@Dosis	varchar (250),
	@DiasTratamiento	decimal,
	@Frecuencia	decimal,
	@Cantidad	decimal,
	@Descripcion	varchar(250),
	@TipoComida	int,
	@VolumenDia	varchar(250),
	@FrecuenciaToma	varchar(250),
	@Periodo	varchar(10),
	@UnidadTiempo	int,
	@IndicadorAuditoria	int,
	@UsuarioAuditoria	varchar(250),
	@HoraInicio	datetime,
	@HoraAdministracion	datetime,
	@Estado	int,
	@UsuarioCreacion	varchar(25),
	@FechaCreacion	datetime,
	@UsuarioModificacion	varchar(25),
	@FechaModificacion	datetime,
	@Accion	varchar(25),
	@Version	varchar(150)
			
)

AS
BEGIN 
SET NOCOUNT ON;
 if(@ACCION = 'NUEVO')
	BEGIN
		INSERT INTO SS_HC_Medicamento_Kardex_FE(
	UnidadReplicacion,
	IdEpisodioAtencion,
	IdPaciente,
	EpisodioClinico,
	Secuencia,
	CodigoComponente,
	IdVia,
	Dosis,
	DiasTratamiento,
	Frecuencia,
	Cantidad,
	Descripcion,
	TipoComida,
	VolumenDia,
	FrecuenciaToma,
	Periodo,
	UnidadTiempo,
	IndicadorAuditoria,
	UsuarioAuditoria,
	HoraInicio,
	HoraAdministracion,
	Estado,
	UsuarioCreacion,
	FechaCreacion,
	UsuarioModificacion,
	FechaModificacion,
	Accion,
	Version) VALUES
		(
	@UnidadReplicacion,
	@IdEpisodioAtencion,
	@IdPaciente,
	@EpisodioClinico,
	@Secuencia,
	@CodigoComponente,
	@IdVia,
	@Dosis,
	@DiasTratamiento,
	@Frecuencia,
	@Cantidad,
	@Descripcion,
	@TipoComida,
	@VolumenDia,
	@FrecuenciaToma,
	@Periodo,
	@UnidadTiempo,
	@IndicadorAuditoria,
	@UsuarioAuditoria,
	@HoraInicio,
	@HoraAdministracion,
	@Estado,
	@UsuarioCreacion,
	getdate(),
	@UsuarioModificacion,
	getdate(),
	@Accion,
	@Version)
		END

		if(@ACCION = 'UPDATE')
		BEGIN
		UPDATE SS_HC_Medicamento_Kardex_FE SET 
		CodigoComponente=@CodigoComponente,
		IdVia=@IdVia,
		Dosis=@Dosis,
		DiasTratamiento=@DiasTratamiento,
		Frecuencia=@Frecuencia,
		Cantidad=@Cantidad,
		Descripcion=@Descripcion,
		TipoComida=@TipoComida,
		VolumenDia=@VolumenDia,
		FrecuenciaToma=@FrecuenciaToma,
		Periodo=@Periodo,
		UnidadTiempo=@UnidadTiempo,
		IndicadorAuditoria=@IndicadorAuditoria,
		UsuarioAuditoria=@UsuarioAuditoria,
		HoraInicio=@HoraInicio,
		HoraAdministracion=@HoraAdministracion,
		Estado=@Estado,
		UsuarioCreacion=@UsuarioCreacion,		
		UsuarioModificacion=@UsuarioModificacion,
		FechaModificacion=getdate(),
		Accion=@Accion,
		Version=@Version
			WHERE UnidadReplicacion=@UnidadReplicacion AND
			IdEpisodioAtencion=@IdEpisodioAtencion AND
			IdPaciente=@IdPaciente AND
			EpisodioClinico=@EpisodioClinico AND Secuencia=@Secuencia
		END

END	

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Medicamento_Kardex_Insert]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_Medicamento_Kardex_Insert]
(
	@UnidadReplicacion char(4),
	@IdEpisodioAtencion bigint,
	@IdPaciente int,
	@EpisodioClinico int,
	@Secuencia int,
	@IdMedicacion int,
	@Medicacion varchar(250),
	@Dosis varchar(80),
	@Frecuencia varchar(80),
	@DiasTratamiento decimal(9,2),
	@DiaTratamiento decimal(9,2),
	@HoraInicio datetime,
	@HoraAdministracion datetime,
	@Hora0 int,
	@Hora1 int,
	@Hora2 int,
	@Hora3 int,
	@Hora4 int,
	@Hora5 int,
	@Hora6 int,
	@Hora7 int,
	@Hora8 int,
	@Hora9 int,
	@Hora10 int,
	@Hora11 int,
	@Hora12 int,
	@Hora13 int,
	@Hora14 int,
	@Hora15 int,
	@Hora16 int,
	@Hora17 int,
	@Hora18 int,
	@Hora19 int,
	@Hora20 int,
	@Hora21 int,
	@Hora22 int,
	@Hora23 int,
	@Estado int,
	@UsuarioCreacion varchar(25),
	@FechaCreacion datetime,
	@UsuarioModificacion varchar(25),
	@FechaModificacion datetime,
	@Accion varchar(25),
	@Version varchar(25)
			
)

AS
BEGIN 
SET NOCOUNT ON;
	 if(@ACCION = 'NUEVO')
		BEGIN
			INSERT INTO SS_HC_Medicamento_Kardex(
		UnidadReplicacion,
		IdEpisodioAtencion,
		IdPaciente,
		EpisodioClinico,
		Secuencia,
		IdMedicacion,
		Medicacion,
		Dosis,
		Frecuencia,
		DiasTratamiento,
		DiaTratamiento,
		HoraInicio,
		HoraAdministracion,
		Hora0,
		Hora1,
		Hora2,
		Hora3,
		Hora4,
		Hora5,
		Hora6,
		Hora7,
		Hora8,
		Hora9,
		Hora10,
		Hora11,
		Hora12,
		Hora13,
		Hora14,
		Hora15,
		Hora16,
		Hora17,
		Hora18,
		Hora19,
		Hora20,
		Hora21,
		Hora22,
		Hora23,
		Estado,
		UsuarioCreacion,
		FechaCreacion,
		UsuarioModificacion,
		FechaModificacion,
		Accion,
		Version) VALUES
			(
		@UnidadReplicacion,
		@IdEpisodioAtencion,
		@IdPaciente,
		@EpisodioClinico,
		@Secuencia,
		@IdMedicacion,
		@Medicacion,
		@Dosis,
		@Frecuencia,
		@DiasTratamiento,
		@DiaTratamiento,
		@HoraInicio,
		@HoraAdministracion,
		@Hora0,
		@Hora1,
		@Hora2,
		@Hora3,
		@Hora4,
		@Hora5,
		@Hora6,
		@Hora7,
		@Hora8,
		@Hora9,
		@Hora10,
		@Hora11,
		@Hora12,
		@Hora13,
		@Hora14,
		@Hora15,
		@Hora16,
		@Hora17,
		@Hora18,
		@Hora19,
		@Hora20,
		@Hora21,
		@Hora22,
		@Hora23,
		@Estado,
		@UsuarioCreacion,
		@FechaCreacion,
		@UsuarioModificacion,
		@FechaModificacion,
		@Accion,
		@Version)
			END

		if(@ACCION = 'UPDATE')
		BEGIN
		UPDATE SS_HC_Medicamento_Kardex SET 
		Medicacion=@Medicacion,
		Dosis=@Dosis,
		Frecuencia=@Frecuencia,
		DiasTratamiento=@DiasTratamiento,
		DiaTratamiento=@DiaTratamiento,
		HoraInicio=@HoraInicio,
		HoraAdministracion=@HoraAdministracion,
		Hora0=@Hora0,
		Hora1=@Hora1,
		Hora2=@Hora2,
		Hora3=@Hora3,
		Hora4=@Hora4,
		Hora5=@Hora5,
		Hora6=@Hora6,
		Hora7=@Hora7,
		Hora8=@Hora8,
		Hora9=@Hora9,
		Hora10=@Hora10,
		Hora11=@Hora11,
		Hora12=@Hora12,
		Hora13=@Hora13,
		Hora14=@Hora14,
		Hora15=@Hora15,
		Hora16=@Hora16,
		Hora17=@Hora17,
		Hora18=@Hora18,
		Hora19=@Hora19,
		Hora20=@Hora20,
		Hora21=@Hora21,
		Hora22=@Hora22,
		Hora23=@Hora23,
		Estado=@Estado,
		UsuarioModificacion=@UsuarioModificacion,
		FechaModificacion=@FechaModificacion,
		Accion=@Accion,
		Version=@Version
			WHERE IdMedicacion=@IdMedicacion AND UnidadReplicacion=@UnidadReplicacion AND
			IdEpisodioAtencion=@IdEpisodioAtencion AND
			IdPaciente=@IdPaciente AND
			EpisodioClinico=@EpisodioClinico AND Secuencia=@Secuencia


		END

		if(@ACCION = 'MEDICACION')
		BEGIN
		UPDATE SS_HC_Medicamento_Kardex SET 
		Hora0=@Hora0,
		Hora1=@Hora1,
		Hora2=@Hora2,
		Hora3=@Hora3,
		Hora4=@Hora4,
		Hora5=@Hora5,
		Hora6=@Hora6,
		Hora7=@Hora7,
		Hora8=@Hora8,
		Hora9=@Hora9,
		Hora10=@Hora10,
		Hora11=@Hora11,
		Hora12=@Hora12,
		Hora13=@Hora13,
		Hora14=@Hora14,
		Hora15=@Hora15,
		Hora16=@Hora16,
		Hora17=@Hora17,
		Hora18=@Hora18,
		Hora19=@Hora19,
		Hora20=@Hora20,
		Hora21=@Hora21,
		Hora22=@Hora22,
		Hora23=@Hora23,
		Estado=@Estado,
		UsuarioModificacion=@UsuarioModificacion,
		FechaModificacion=GETDATE(),
		Accion=@Accion
			WHERE IdMedicacion=@IdMedicacion AND UnidadReplicacion=@UnidadReplicacion AND
			IdEpisodioAtencion=@IdEpisodioAtencion AND
			IdPaciente=@IdPaciente AND
			EpisodioClinico=@EpisodioClinico AND Secuencia=@Secuencia


		END

		if(@ACCION = 'DELETEKARDEX')
		BEGIN
		DELETE FROM SS_HC_Medicamento_Kardex 
		WHERE 
		UnidadReplicacion=@UnidadReplicacion AND
		IdEpisodioAtencion=@IdEpisodioAtencion AND
		IdPaciente=@IdPaciente AND
		EpisodioClinico=@EpisodioClinico

		END
END	

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Miscelaneos_Formularios_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[SP_SS_HC_Miscelaneos_Formularios_LISTAR]
(        
 @AplicacionCodigo varchar(10) ,        
 @CodigoTabla varchar(30) ,        
 @Compania varchar(10) ,        
 @CodigoElemento varchar(10) ,   
 @Usuario varchar(30) ,              
 @UnidadReplicacion varchar(4) ,   
 @IdPaciente int ,   
 @EpisodioClinico	int,   
 @IdEpisodioAtencion	bigint,   
 @IdOrdenAtencion	int,  
 @CodigoOA	varchar(30),  
 @IdMedico	int, 
 @IdOpcion	int, 
 @CodigoFormato	varchar(30), 
 @ACCION VARCHAR(50)        
  
)        
        
AS        
BEGIN         
	/*******************************************************************************************************************
	
		EL OBJETOVO DE ESTE STORED, ES PERMITIR GENERALIZAR ALGUNAS FUNCIONALIDADES CAMBIANTES POR FORMULARIOS
		, DE DEBERÁ CONTEMPLAR ALGUNA LÓGICA PARTICULAR PARA CADA FORMULARIO NUEVO
			
	*******************************************************************************************************************/         
         
         
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
 DECLARE @COD_FORMATO_AUX varchar(30)
 
	/**SECCIÓN PARA TRATAR LA VALIDACIóN DE OBLIGATORIEDAD DE FORMULARIOS**/ 
	if(@ACCION = 'VALID_FORM_OBLIGA')        
	BEGIN        
		select * from MA_MiscelaneosDetalle        
	END        
	ELSE   
	/**SECCIÓN PARA TRATAR EL LISATDO DE LAS COLUMNAS DEL LISTADO DE CORNOLOGÍAS, DE ACUERDO AL FORMATO FILTRADO*
		SE DEBERÁ AGREGAR EL CÓDIGO DEL FORMULARIO Y ESPECIFICAR EL NOMBRE DE LAS COLUMNAS PARA ESTE
	
	*/
	if(@ACCION = 'COLUMNAS_CRONOL')        
	begin 
	
		/** 1.-  OBTENER EL CÓDIGO DEL FORMATO DE ACEURDO AL ID DE OPCIÓN ENVIADO  *****/
	    if(@IdOpcion is not null)
		begin
		  select @COD_FORMATO_AUX = SS_HC_Formato.CodigoFormato from SG_Opcion
			left join SS_HC_Formato on (SS_HC_Formato.IdFormato = SG_Opcion.IdFormato)
			where SG_Opcion.IdOpcion = convert(int ,@IdOpcion)
		end
		
		/** 2.- ARMAR LOS NOMBRES DE LAS COLUMNAS PARA CADA FORMULARIO (VER DOCUMENTACIÓN DE MEJORAS DE CORNOLOGÍAS)****/
		
		--DIAGNÓSTICO VERSIÓN 01
		 if(@COD_FORMATO_AUX = 'CCEPF631')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Motivo de Ingreso','Sintomas','0','Prioridad de Triaje','0',
                 'VER'
               )          
          end 
		   if(@COD_FORMATO_AUX = 'CCEPF630')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Motivo de Ingreso','Peso','0','Prioridad de Triaje','0',
                 'VER'
               )          
          end 
		 if(@COD_FORMATO_AUX = 'CCEP0253')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Diagnóstico','Determinación','0','Grado de afección','0',
                 'VER'
               )          
          end    
          --ENFERMEDAD ACTUAL VERSIÓN 01 
          ELSE if(@COD_FORMATO_AUX = 'CCEP0003')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Evaluacion de la Alimentacion Actual','0','0','Apetito','Motivo de consulta',
                 'VER'
               )          
          end  
		   ELSE if(@COD_FORMATO_AUX = 'CCEP0004')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Alergia Medicamentos','Alergia Alimentos','0','Consumo de Verduras','Consumo de Frutas',
                 'VER'
               )          
          end 

		  ELSE if(@COD_FORMATO_AUX = 'CCEP0014')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Profesional','Parentesco','Estado Actual','Enfermedad','Fecha de registro',
                 'VER'
               )          
          end 



		   ELSE if(@COD_FORMATO_AUX = 'CCEPF012')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Vacunas','Influenza','0','0','0',
                 'VER'
               )          
          end  

		  	   ELSE if(@COD_FORMATO_AUX = 'CCEPF004')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'EdadMaterna','ControlPrenatal','Complicaciones','0','0',
                 'VER'
               )          
          end  
		
          --ANAMNESIS ALERGIAS 
          ELSE if(@COD_FORMATO_AUX = 'CCEP00F2')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Historia de Alergia','Nombre','¿Desde cuándo?','0','0',
                 'VER'
               )          
          end  
		  ---PATOLOGICOS GENERALES
		    ELSE if(@COD_FORMATO_AUX = 'CCEPF006')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Enfermedades Anteriores','Observaciones','0','0','0',
                 'VER'
               )          
          end  
        
            /*	
			ANAMNESIS FISIOLOGICOS GENERALES--
			ANAMNESIS PEDIATRICOS--			
			ANAMNESIS FISIOLOGICOS GINECO OBSTETRICOS--
			ANAMNESIS PATOLOGICOS  GENERALES
			PATOLÓGICOS GINECO OBSTÉTRICOS--
			PATOLÓGICOS ANESTESIOLÓGICO
			PATOLÓGICOS CARDIOLÓGICO
			PROBLEMAS SALUD
			TRANSFUSIONES, QUIRÚRGICOS Y HOSPITALIZACIONES--
			EPIDEMIOLÓGICOS Y SOCIOECONÓMICOS
			LACTANCIA MATERNA
			
			TRIAJE Y FUNCIONES VITALES
			FUNCIONES VITALES

				*/
          ELSE if(@COD_FORMATO_AUX IN ('CCEPX002','CCEP00F4','CCEP0F10','CCEP0102')) -- POR DEFINIR
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Tipo','Opción','0','Valor','0',
                 'VER'
               )          
          end   

		  ELSE if(@COD_FORMATO_AUX IN ('CCEPF005'))
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'CaracteristicasMenstruaciones','Resul','0','0','0',
                 'VER'
               )          
          end  
          /**
			INMUNIZACIÓN ADULTO
			INMUNIZACIÓN NIÑOS

          **/
          ELSE if(@COD_FORMATO_AUX IN ('CCEPF013','CCEPF012'))-- 'CCEPX003') -- POR DEFINIR
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Inmunización','Influenza','0','0','0',
                 'VER'
               )          
          end  

		     ELSE if(@COD_FORMATO_AUX IN ('CCEPF013'))
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Inmunización','Influenza','0','0','0',
                 'VER'
               )          
          end  

             
          /**
			ANTECEDENTES FAMILIARES

          **/
          ELSE if(@COD_FORMATO_AUX = 'CCEPF014') 
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Antecedentes','Parentesco','Observaciones','0','0',
                 'VER'
               )          
          end  
		   /**
			EVOLUCION MEDICA

          **/
          ELSE if(@COD_FORMATO_AUX = 'CCEPF080') --'CCEPX004') -- POR DEFINIR
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Fecha de Ingreso','Hora de Ingreso','Enfermedad','0','0',
                 'VER'
               )          
          end  
          /*
			VALORACIÓN DEL ADULTO MAYOR
          **/
          ELSE if(@COD_FORMATO_AUX = 'CCEPF018')--'CCEPX005') -- POR DEFINIR
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Saludable','Fragil','Enfermo','Geriatrico Complejo','0',
                 'VER'
               )          
          end  



          /*
			EXAMEN POR REGIONES APARATOS Y SISTEMA--
			EXAMEN GINECO OBSTÉTRICO

          **/

          ELSE if(@COD_FORMATO_AUX = 'CCEP0104')--'CCEPX006') -- POR DEFINIR
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Tipo','Qué','Opción','Valor','0',
                 'VER'
               )          
          end 
		          ELSE if(@COD_FORMATO_AUX = 'CCEPF153')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Observaciones','0','0','0','0',
                 'VER'
               )          
          end 
          /*
				EVOLUCIÓN --Falta
          **/
          ELSE if(@COD_FORMATO_AUX = 'CCEPX007') -- POR DEFINIR
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Evolución','0','0','0','0',
                 'VER'
               )          
          end 
			--DIAGNÓSTICO VERSIÓN 02
		 ELSE if(@COD_FORMATO_AUX IN('CCEP0F90','CCEP0251'))-- 'CCEP025XXX')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Diagnóstico','Determinación','0','Grado de afección','0',
                 'VER'
               )          
          end 
		/**
		INDICACIÓN DE DIETA Y COMPLEMENTOS 
		**/
		 ELSE if(@COD_FORMATO_AUX IN('CCEPF100','CCEPF101')) --'CCEP025XXX')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Tipo','Nombre','Indicaciones','0','0',
                 'VER'
               )          
          end 
		/**
		INDICACIÓN DE MEDICACIÓN, SOLUCIONES, OTROS --No encontrado
 
		**/
		 ELSE if(@COD_FORMATO_AUX = 'CCEP0000001')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Medicamento','Dosis','Indicaciones','Estado','0',
                 'VER'
               )          
          end 
		/**
		EXAMENES DE APOYO AL DIAGNÓSTICO - SEGUS y CPT 
		**/
		 ELSE if(@COD_FORMATO_AUX = 'CCEPF300')--'CCEP000000WWW')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Fecha de inicio','Fecha fin','Número de días','0','0',
                 'VER'
               )          
          end 
		/**
		INTERCONSULTA--
		PROXIMA CITA--
		NOTA DE INGRESO (amb y eme)

		**/
		 ELSE if(@COD_FORMATO_AUX ='CCEPF151')-- 'CCEP0000000003')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Tipo','Motivo','Resumen','0','0',
                 'VER'
               )          
          end 
		  	/**
		OFTAMOLOGIA

		**/
		   ELSE if(@COD_FORMATO_AUX ='CCEPF510')-- 'CCEP0000000003')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Parpados y Anexos','Cornea,Cristalino,Esclera','Iris,Pupila','0','0',
                 'VER'
               )          
          end 
		    	/**
		ANTECEDENTES PERSONALES FISIOLOGICOS
		
		**/
		   ELSE if(@COD_FORMATO_AUX ='CCEP00F3')-- 'CCEP0000000003')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,ValorCodigo6,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'GrupoSanguineo','FactorRH','Alimentacion Actual','0','0','Otros',
                 'VER'
               )          
          end 
		 
		 ELSE if(@COD_FORMATO_AUX IN ('CCEP0311','CCEPF152'))-- 'CCEP0000000003')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Tipo','Fecha Solicitada','0','0','0',
                 'VER'
               )          
          end 
          ELSE if(@COD_FORMATO_AUX ='CCEPF154')-- 'CCEP0000000003')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Fecha del Informe','Resumen','0','0','0',
                 'VER'
               )          
          end 
          /**
		PROCEDIMIENTO - ORDEN DE INTERVENCION QUIRURGICA
		**/
		 ELSE if(@COD_FORMATO_AUX = 'CCEP0310')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Procedimiento','Diagnostico','tipo','Fecha y Hora','0',
                 'VER'
               )          
          end 

          
/**
		ALTA - REFERENCIA
		**/
		 ELSE if(@COD_FORMATO_AUX = 'CCEPF202')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Número','Prioridad','Establecimiento de destino','Servicio de destino','Fecha de Transferencia',
                 'VER'
               )          
          end 
          
          
          /**
		ESPECIALES - DESCANSO MEDICO
		**/
		 ELSE if(@COD_FORMATO_AUX IN ('CCEP0313','CCEPF300'))
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Fecha de inicio','Fecha fin','Número de días','0','0',
                 'VER'
               )          
          end 
          
          
          ELSE if(@COD_FORMATO_AUX = 'CCEP0055')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Parentesco','Estado Actual','Enfermedad','0','0',
                 'VER'
               )          
          end  
          
           ELSE if(@COD_FORMATO_AUX = 'CCEP2010')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'EVOLUCION','0','0','0','0',
                 'VER'
               )          
          end  
             ELSE if(@COD_FORMATO_AUX = 'CCEPF150')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Examen','Especificaciones','Fecha de Solicitud','0','0',
                 'VER'
               )          
          end 

		  ELSE if(@COD_FORMATO_AUX = 'CCEPF015')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Resultado','0','Fecha de Solicitud','0','0',
                 'VER'
               )          
          end 
		
  		  ELSE if(@COD_FORMATO_AUX = 'CCEPF360')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Requisitos','Personal del Banco','0','0','0',
                 'VER'
               )          
          end 
		   	  ELSE if(@COD_FORMATO_AUX = 'CCEPF301b')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Transfusiones Previas','Embarazos','Abortos','0','0',
                 'VER'
               )          
          end 
	    ELSE if(@COD_FORMATO_AUX = 'CCEPF017')
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999','CRONO'  ,@COD_FORMATO_AUX,
                 'Examen','0','Fecha de Solicitud','0','0',
                 'VER'
               )          
          end 

		   ELSE if(@COD_FORMATO_AUX IN ('CCEPF001')) --'CCEPX005') -- FUNCIONES VITALES EnfermedadActual
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'TipoAmnamnesis','Motivo Ingreso','Tiempo de Enfermedad','0','0',
                 'VER'
               )          
          end   
		     ELSE if(@COD_FORMATO_AUX IN ('CCEPF051')) --'CCEPX005') -- FUNCIONES VITALES EnfermedadActual
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'TipoAmnamnesis','FormaInicio','0','0','0',
                 'VER'
               )          
          end   
		  
		     ELSE if(@COD_FORMATO_AUX IN ('CCEPF016'))
           begin  
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )             
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'Satisfecho','Impotente','Memoria','0','0',
                 'VER'
               )          
          end                                                                                                                				
			else
			begin
              insert into @MA_MiscelaneosDetalle 
               (AplicacionCodigo,Compania,CodigoTabla,CodigoElemento ,
                ValorCodigo1,ValorCodigo2,ValorCodigo3,ValorCodigo4,ValorCodigo5,
                ACCION
               )      
       
                 values('WA','999999'   , 'CRONO'  ,@COD_FORMATO_AUX,
                 'SIN NOMBRE 01','SIN NOMBRE 02','SIN NOMBRE 03','SIN NOMBRE 04','SIN NOMBRE 05',
                  'VER'
               )
			end
			
			
			
			
	 select * from @MA_MiscelaneosDetalle 
        
   END     
END      




GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Monitoreo_Obs_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_Monitoreo_Obs_FE]
@UnidadReplicacion char(4)
,@IdEpisodioAtencion bigint 
,@IdPaciente int 
,@EpisodioClinico int 
,@IdMedico int
,@IdEspecialidad int
,@IdMonitoreo int
,@Hora_Inicio datetime
,@UsuarioCreacion varchar(25)  
,@FechaCreacion datetime 
,@UsuarioModificacion varchar(25)  
,@FechaModificacion datetime 
,@Accion varchar(25)  
,@Version varchar(25) 
,@IdDiagnostico int
,@IdFormaInicio int
,@Estado int

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
				update  SS_HC_Monitoreo_Obs_FE
				Set  IdMedico=@IdMedico,	 
					 IdEspecialidad=@IdEspecialidad,
					 IdMonitoreo=@IdMonitoreo,	 
					 Hora_Inicio=@Hora_Inicio,	 					
					 UsuarioModificacion=@UsuarioModificacion,	 
					 FechaModificacion=@FechaModificacion,	  	 
					 Accion = @Accion,					
					 IdFormaInicio=@IdFormaInicio

				 Where  
					IdEpisodioAtencion = @IdEpisodioAtencion
					And	EpisodioClinico =@EpisodioClinico
					And	IdPaciente =@IdPaciente
 
				select @IdEpisodioAtencionId;
		END

       IF(@Accion='NUEVO')
        BEGIN
             INSERT INTO SS_HC_Monitoreo_Obs_FE
			 (UnidadReplicacion,IdEpisodioAtencion,IdPaciente,
			 EpisodioClinico,
			 IdMedico,IdEspecialidad,IdMonitoreo,Hora_Inicio,
             UsuarioCreacion,FechaCreacion,
			 Accion,Version,IdFormaInicio,Estado)
             VALUES(@UnidadReplicacion,@IdEpisodioAtencion,@IdPaciente,
			 @EpisodioClinico,
			 @IdMedico,@IdEspecialidad,@IdMonitoreo,@Hora_Inicio,
             @UsuarioCreacion,@FechaCreacion,
			 @Accion,'CCEPF502',@IdFormaInicio,@Estado)

            select @IdEpisodioAtencionId;
        END

       

     IF @ACCION ='UPDATEDETALLE'  --Actualizar DETALLE
		BEGIN          

   			UPDATE SS_HC_Monitoreo_Obs_Diagnostico_FE 
			SET 
				IdDiagnostico=	@IdDiagnostico,
				Accion = @Accion
				
			Where	
			UnidadReplicacion = @UnidadReplicacion
			and		IdEpisodioAtencion = @IdEpisodioAtencion
			and IdPaciente =@IdPaciente 
			and		EpisodioClinico = @EpisodioClinico
			and Secuencia = @IdFormaInicio
				
				
			-- select @Secuencia;
			select @IdEpisodioAtencionId;

		END  
	
	IF @ACCION ='INSERTDETALLE'  --Insertar DETALLE
		BEGIN  
		   select @SecuenciaID = ISNULL(max(Secuencia),0) + 1   from SS_HC_Monitoreo_Obs_Diagnostico_FE  
           
  
		   insert into SS_HC_Monitoreo_Obs_Diagnostico_FE
		   ( UnidadReplicacion, IdEpisodioAtencion, IdPaciente,   
			EpisodioClinico, Secuencia, IdDiagnostico,Accion,Version)  
		   values 
		   (@UnidadReplicacion, @IdEpisodioAtencion, @IdPaciente,   
			@EpisodioClinico, @SecuenciaID, @IdDiagnostico,@Accion,'CCEPF502' )  
      
		   select @IdEpisodioAtencionId;  
      
		END 	

	IF @ACCION ='DELETE'  --Borrar DETALLE
		BEGIN  
    
			DELETE SS_HC_Monitoreo_Obs_Diagnostico_FE   
		    where 
			   IdPaciente =@IdPaciente  
			   AND  EpisodioClinico = @EpisodioClinico  
			   AND  IdEpisodioAtencion=@IdEpisodioAtencion  
			   AND UnidadReplicacion = @UnidadReplicacion
			   AND  Secuencia = @IdFormaInicio  
 
		   select @IdFormaInicio;     
		END  	

END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Monitoreo_Obs_Ing_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_Monitoreo_Obs_Ing_FE]

@UnidadReplicacion char(4)
,@IdEpisodioAtencion bigint 
,@IdPaciente int 
,@EpisodioClinico int 

,@Secuencia int
,@Fecha datetime
,@Hora datetime
,@Goteoxmin int
,@MU int
,@Fun_Vital_PA1 int
,@Fun_Vital_PA2 int
,@Fun_Vital_P int
,@Fun_Vital_R int
,@Fun_Vital_T decimal (9,2)
,@FCF int
,@Din_Ut_Frec int
,@Din_Ut_Dur int
,@Din_Ut_Int int
,@Ex_Val_Dilat int
,@Ex_Val_Incorp int
,@Ex_Val_AP	int
,@Ex_Val_IdM int
,@Observaciones varchar(250)  
,@Firma varchar(25)  

,@UsuarioCreacion varchar(25)  
,@FechaCreacion datetime 
,@UsuarioModificacion varchar(25)  
,@FechaModificacion datetime 
,@Accion varchar(25)  
,@Version varchar(25)  

AS
BEGIN
DECLARE @SECUENCIAMAX INT 
SET @SECUENCIAMAX = (SELECT (ISNULL(MAX(Secuencia),0)+1) FROM SS_HC_Monitoreo_Obs_Ing_FE WHERE
	UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico)

IF(@Accion = 'NUEVO')
BEGIN

	INSERT INTO SS_HC_Monitoreo_Obs_Ing_FE
	(UnidadReplicacion,IdEpisodioAtencion,IdPaciente,EpisodioClinico,Secuencia,
    Fecha,Hora,Goteoxmin,MU,Fun_Vital_PA1,Fun_Vital_PA2,Fun_Vital_P,Fun_Vital_R,
	Fun_Vital_T,FCF,Din_Ut_Frec,Din_Ut_Dur,Din_Ut_Int,Ex_Val_Dilat,Ex_Val_Incorp,
	Ex_Val_AP,Ex_Val_IdM,Observaciones,Firma,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,Accion,Version) 
    VALUES(@UnidadReplicacion, @IdEpisodioAtencion, @IdPaciente, @EpisodioClinico, @SECUENCIAMAX, 
    @Fecha,@Hora,@Goteoxmin,@MU,@Fun_Vital_PA1,@Fun_Vital_PA2,@Fun_Vital_P,@Fun_Vital_R,
	@Fun_Vital_T,@FCF,@Din_Ut_Frec,@Din_Ut_Dur,@Din_Ut_Int,@Ex_Val_Dilat,@Ex_Val_Incorp,
	@Ex_Val_AP,@Ex_Val_IdM,@Observaciones,@Firma,@UsuarioCreacion, GETDATE(), @UsuarioModificacion, @FechaModificacion, @Accion, 'CCEPF502'
    )
SELECT @SECUENCIAMAX
END

IF(@Accion = 'UPDATE')
BEGIN

	UPDATE SS_HC_Monitoreo_Obs_Ing_FE
	SET Fecha=@Fecha,Hora=@Hora,Goteoxmin=@Goteoxmin,MU=@MU,Fun_Vital_PA1=@Fun_Vital_PA1,
	Fun_Vital_PA2=@Fun_Vital_PA2,Fun_Vital_P=@Fun_Vital_P,Fun_Vital_R=@Fun_Vital_R,
	Fun_Vital_T=@Fun_Vital_T,FCF=@FCF,Din_Ut_Frec=@Din_Ut_Frec,Din_Ut_Dur=@Din_Ut_Dur,
	Din_Ut_Int=@Din_Ut_Int,Ex_Val_Dilat=@Ex_Val_Dilat,Ex_Val_Incorp=@Ex_Val_Incorp,
	Ex_Val_AP=@Ex_Val_AP,Ex_Val_IdM=@Ex_Val_IdM,Observaciones=@Observaciones,Firma=@Firma
	,UsuarioModificacion=@UsuarioModificacion,
	FechaModificacion=GETDATE(),Accion=@Accion,Version='CCEPF502'
	WHERE
	UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico AND Secuencia=@Secuencia
	
	
	
SELECT @Secuencia
END

IF(@Accion = 'DELETE')
BEGIN

	DELETE FROM SS_HC_Monitoreo_Obs_Ing_FE
	WHERE UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico AND Secuencia=@Secuencia
	
SELECT @Secuencia
END



END

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Monitoreo_Obs_Ing_FE_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_Monitoreo_Obs_Ing_FE_Listar]

@UnidadReplicacion char(4)
,@IdEpisodioAtencion bigint 
,@IdPaciente int 
,@EpisodioClinico int 

,@Secuencia int
,@Fecha datetime
,@Hora datetime
,@Goteoxmin int
,@MU int
,@Fun_Vital_PA1 int
,@Fun_Vital_PA2 int
,@Fun_Vital_P int
,@Fun_Vital_R int
,@Fun_Vital_T decimal (9,2)
,@FCF int
,@Din_Ut_Frec int
,@Din_Ut_Dur int
,@Din_Ut_Int int
,@Ex_Val_Dilat int
,@Ex_Val_Incorp int
,@Ex_Val_AP	int
,@Ex_Val_IdM int
,@Observaciones varchar(250)  
,@Firma varchar(25)  

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
SELECT * FROM SS_HC_Monitoreo_Obs_Ing_FE
WHERE UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
	AND EpisodioClinico=@EpisodioClinico
END



END

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Monitoreo_Obs_Listar_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE  [dbo].[SP_SS_HC_Monitoreo_Obs_Listar_FE]
@UnidadReplicacion char(4)
,@IdEpisodioAtencion bigint 
,@IdPaciente int 
,@EpisodioClinico int 
,@IdMedico int
,@IdEspecialidad int
,@IdMonitoreo int
,@Hora_Inicio datetime
,@UsuarioCreacion varchar(25)  
,@FechaCreacion datetime 
,@UsuarioModificacion varchar(25)  
,@FechaModificacion datetime 
,@Accion varchar(25)  
,@Version varchar(25) 
,@IdDiagnostico int
,@IdFormaInicio int
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
		Select * From SS_HC_Monitoreo_Obs_FE 
		Where	IdPaciente = @IdPaciente 
		AND		IdEpisodioAtencion = @IdEpisodioAtencion
		AND		EpisodioClinico= @EpisodioClinico
		
		END
 
 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_NANDA]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_NANDA]

	@IdNanda int,
	@Codigo varchar(10),
	@CodigoPadre varchar(10),
	@Descripcion varchar(300),
	@DescripcionCorta varchar(100),
	@TipoFactor int,
	@Nivel int,
	@CadenaRecursiva varchar(50),
	@IdDominioPAE int ,
	@IdClasePAE int,
	@Orden int,
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
            SELECT @IdNanda = Isnull(Max(IdNanda), 0) + 1 FROM   dbo.SS_HC_NANDA  
            INSERT INTO SS_HC_NANDA 
                        (IdNanda, 
                         codigo, 
                         codigopadre, 
                         descripcion, 
                         descripcioncorta, 
                         TipoFactor,
                         nivel, 
                         cadenarecursiva, 
                         IdDominioPAE,
                         IdClasePAE,
                         orden, 
                         estado, 
                         usuariocreacion, 
                         fechacreacion, 
                         usuariomodificacion, 
                         fechamodificacion, 
                         accion, 
                         version) 
            VALUES      ( @IdNanda, 
                          @Codigo, 
                          @CodigoPadre, 
                          @Descripcion, 
                          @DescripcionCorta,
                          @TipoFactor, 
                          @Nivel, 
                          @CadenaRecursiva, 
                          @IdDominioPAE,
                          @IdClasePAE,
                          @Orden, 
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
            UPDATE SS_HC_NANDA 
            SET    IdNanda = @IdNanda, 
                   codigo = @Codigo, 
                   codigopadre = @CodigoPadre, 
                   descripcion = @Descripcion, 
                   descripcioncorta = @DescripcionCorta,
                   TipoFactor=@TipoFactor, 
                   nivel = @Nivel, 
                   cadenarecursiva = @CadenaRecursiva,
                   IdDominioPAE  = @IdDominioPAE,
                   IdClasePAE = @IdClasePAE,
                   orden = @Orden, 
                   estado = @Estado, 
                 --  usuariocreacion = @UsuarioCreacion, 
                  -- fechacreacion = @FechaCreacion, 
                   usuariomodificacion = @UsuarioModificacion, 
                   fechamodificacion = GETDATE(), 
                   accion = @Accion, 
                   version = @Version 
            WHERE  ( SS_HC_NANDA.IdNanda = @IdNanda ) 

            SELECT 1 
        END 
      ELSE IF @Accion = 'DELETE' 
        BEGIN 
            DELETE FROM SS_HC_NANDA 
            WHERE  ( SS_HC_NANDA.IdNanda = @IdNanda ) 

            SELECT 1 
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_NANDA 
                             WHERE  ( @Descripcion IS NULL OR Upper(SS_HC_NANDA.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_NANDA.estado = @Estado OR @Estado = 0 ) 
                                    AND ( @Codigo IS NULL OR Upper(SS_HC_NANDA.codigo) LIKE '%' + Upper(@Codigo) + '%' )
                                    AND ( @CodigoPadre IS NULL OR Upper(SS_HC_NANDA.CodigoPadre) LIKE '%' + Upper(@CodigoPadre) + '%' ) 
                                    AND ( @Nivel IS NULL OR SS_HC_NANDA.Nivel = @Nivel OR @Nivel = 0 ) 
                                    AND ( @TipoFactor IS NULL OR SS_HC_NANDA.TipoFactor = @TipoFactor OR @TipoFactor = 0 ) 
                                    AND ( @IdNanda IS NULL OR SS_HC_NANDA.IdNanda = @IdNanda OR @IdNanda = 0 )) 

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
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_NANDA_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_NANDA_LISTAR]
(
	@IdNanda int,
	@Codigo varchar(10),
	@CodigoPadre varchar(10),
	@Descripcion varchar(300),
	@DescripcionCorta varchar(100),
	@TipoFactor int,
	@Nivel int,
	@CadenaRecursiva varchar(50),
	@Orden int,
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
	
		SET @CONTADOR=(SELECT COUNT(IdNanda) FROM SS_HC_NANDA
	 					WHERE 
					(@IdNanda is null OR (IdNanda = @IdNanda) or @IdNanda =0)
					AND( @Descripcion IS NULL OR Upper(descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                    AND ( @Estado IS NULL OR estado = @Estado OR @Estado = 0 ) 
                    AND ( @Codigo IS NULL OR Upper(codigo) LIKE '%' + Upper(@Codigo) + '%' ) 
                    AND ( @CodigoPadre IS NULL OR Upper(CodigoPadre) LIKE '%' + Upper(@CodigoPadre) + '%' ) 
                    AND ( @Nivel IS NULL OR Nivel = @Nivel OR @Nivel = 0 ) 
					)
		SELECT
			IdNanda
		  ,Codigo
		  ,CodigoPadre
		  ,Descripcion
		  ,DescripcionCorta
		  ,TipoFactor
		  ,Nivel
		  ,CadenaRecursiva
		  ,Orden
		  ,Estado
		  ,UsuarioCreacion
		  ,FechaCreacion
		  ,UsuarioModificacion
		  ,FechaModificacion
		  ,Accion
		  ,[Version]
		FROM (		
			SELECT
			IdNanda
		  ,Codigo
		  ,CodigoPadre
		  ,Descripcion
		  ,DescripcionCorta
		  ,TipoFactor
		  ,Nivel
		  ,CadenaRecursiva
		  ,Orden
		  ,Estado
		  ,UsuarioCreacion
		  ,FechaCreacion
		  ,UsuarioModificacion
		  ,FechaModificacion
		  ,Accion
		  ,[Version]
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY IdNanda ASC ) AS RowNumber   	
					FROM SS_HC_NANDA	
					WHERE 
						(@IdNanda is null OR (IdNanda = @IdNanda) or @IdNanda =0)
					AND( @Descripcion IS NULL OR Upper(descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                    AND ( @Estado IS NULL OR estado = @Estado OR @Estado = 0 ) 
                    AND ( @Codigo IS NULL OR Upper(codigo) LIKE '%' + Upper(@Codigo) + '%' ) 
                    AND ( @CodigoPadre IS NULL OR Upper(CodigoPadre) LIKE '%' + Upper(@CodigoPadre) + '%' ) 
                    AND ( @Nivel IS NULL OR Nivel = @Nivel OR @Nivel = 0 ) 
 
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		
       END
       ELSE
 IF @Accion ='LISTAR'    
    BEGIN    
		SELECT
		   N.IdNanda
		  ,N.Codigo
		  ,N.CodigoPadre
		  ,N.Descripcion
		  ,C.Descripcion AS  DescripcionCorta
		  ,N.TipoFactor
		  ,N.Nivel
		  ,N.CadenaRecursiva
		  ,N.IdDominioPAE
		  ,N.IdClasePAE
		  ,N.Orden
		  ,N.Estado
		  ,N.UsuarioCreacion
		  ,N.FechaCreacion
		  ,N.UsuarioModificacion
		  ,N.FechaModificacion
		  ,N.Accion
		  ,D.Descripcion AS Version
			FROM SS_HC_NANDA N inner join  SS_HC_DominioPAE D
			on N.IdDominioPAE = D.IdDominioPAE
			INNER JOIN SS_HC_ClasePAE C ON  N.IdClasePAE= C.IdClasePAE
			
			
				WHERE 
						N.IdNanda = @IdNanda
						/*((@IdNanda is null OR (IdNanda = @IdNanda) or @IdNanda =0)
					AND( @Descripcion IS NULL OR Upper(descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                   /* AND ( @Estado IS NULL OR estado = @Estado OR @Estado = 0 ) */
                    AND ( @Codigo IS NULL OR Upper(codigo) LIKE '%' + Upper(@Codigo) + '%' ) 
                    AND ( @CodigoPadre IS NULL OR Upper(CodigoPadre) LIKE '%' + Upper(@CodigoPadre) + '%' ) 
                   /* AND ( @Nivel IS NULL OR Nivel = @Nivel OR @Nivel = 0 ) */
					)*/
						
						
					
	end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 
					*					
				from 
				SS_HC_NANDA
								WHERE 
							(IdNanda = @IdNanda)			

	end	
END

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_NANDAListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_NANDAListar]

	@IdNanda int,
	@Codigo varchar(10),
	@CodigoPadre varchar(10),
	@Descripcion varchar(300),
	@DescripcionCorta varchar(100),
	@TipoFactor int,
	@Nivel int,
	@CadenaRecursiva varchar(50),
	@IdDominioPAE int ,
	@IdClasePAE int,
	@Orden int,
	@Estado int,
	@UsuarioCreacion varchar(15),
	@FechaCreacion datetime,
	@UsuarioModificacion varchar(25),
	@FechaModificacion datetime,
	@Accion varchar(25),	
	@Version varchar(25),		
	@INICIO   int= null,  
	@NUMEROFILAS int = null 

AS 
  BEGIN 
      SET nocount ON; 

      DECLARE @CONTADOR INT 

      IF @Accion = 'LISTAR' 
        BEGIN 
           SELECT
		   N.IdNanda
		  ,N.Codigo
		  ,N.CodigoPadre
		  ,N.Descripcion
		  ,C.Descripcion AS  DescripcionCorta
		  ,N.TipoFactor
		  ,N.Nivel
		  ,N.CadenaRecursiva
		  ,N.IdDominioPAE
		  ,N.IdClasePAE
		  ,N.Orden
		  ,N.Estado
		  ,N.UsuarioCreacion
		  ,N.FechaCreacion
		  ,N.UsuarioModificacion
		  ,N.FechaModificacion
		  ,(select Descripcion from SS_HC_NANDA where Codigo = N.CodigoPadre ) as Accion
		  ,D.Descripcion AS Version 
			FROM SS_HC_NANDA N inner join  SS_HC_DominioPAE D
			on N.IdDominioPAE = D.IdDominioPAE
			INNER JOIN SS_HC_ClasePAE C ON  N.IdClasePAE= C.IdClasePAE
			WHERE 
						N.IdNanda = @IdNanda 
        END 
        else IF @Accion = 'LISTARN' 
        BEGIN 
           SELECT
		   N.IdNanda
		  ,N.Codigo
		  ,N.CodigoPadre
		  ,N.Descripcion
		  ,C.Descripcion AS  DescripcionCorta
		  ,N.TipoFactor
		  ,N.Nivel
		  ,N.CadenaRecursiva
		  ,N.IdDominioPAE
		  ,N.IdClasePAE
		  ,N.Orden
		  ,N.Estado
		  ,N.UsuarioCreacion
		  ,N.FechaCreacion
		  ,N.UsuarioModificacion
		  ,N.FechaModificacion
		  ,N.Accion
		  ,D.Descripcion AS Version 
			FROM SS_HC_NANDA N inner join  SS_HC_DominioPAE D
			on N.IdDominioPAE = D.IdDominioPAE
			INNER JOIN SS_HC_ClasePAE C ON  N.IdClasePAE= C.IdClasePAE
			WHERE ((@IdNanda is null OR (IdNanda = @IdNanda) or @IdNanda =0)
					AND( @Descripcion IS NULL OR Upper(N.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                   /* AND ( @Estado IS NULL OR estado = @Estado OR @Estado = 0 ) */
                    AND ( @Codigo IS NULL OR Upper(codigo) LIKE '%' + Upper(@Codigo) + '%' ) 
                    AND ( @CodigoPadre IS NULL OR Upper(CodigoPadre) LIKE '%' + Upper(@CodigoPadre) + '%' ) 
                   /* AND ( @Nivel IS NULL OR Nivel = @Nivel OR @Nivel = 0 ) */
					)
			
			
				/*WHERE 
						N.IdNanda = @IdNanda */
        END 
        
        
        
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_NANDA 
                              WHERE  ( @Descripcion IS NULL OR Upper(SS_HC_NANDA.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_NANDA.estado = @Estado OR @Estado = 0 ) 
                                    AND ( @Codigo IS NULL OR Upper(SS_HC_NANDA.codigo) LIKE '%' + Upper(@Codigo) + '%' )
                                    AND ( @CodigoPadre IS NULL OR Upper(SS_HC_NANDA.CodigoPadre) LIKE '%' + Upper(@CodigoPadre) + '%' ) 
                                    AND ( @TipoFactor IS NULL OR SS_HC_NANDA.TipoFactor = @TipoFactor OR @TipoFactor = 0 ) 
                                    AND ( @IdDominioPAE IS NULL OR SS_HC_NANDA.IdDominioPAE = @IdDominioPAE OR @IdDominioPAE = 0 ) 
                                    AND ( @IdClasePAE IS NULL OR SS_HC_NANDA.IdClasePAE = @IdClasePAE OR @IdClasePAE = 0 ) 
                                    AND ( @Nivel IS NULL OR SS_HC_NANDA.Nivel = @Nivel OR @Nivel = 0 ) 
                                    AND ( @IdNanda IS NULL OR SS_HC_NANDA.IdNanda = @IdNanda OR @IdNanda = 0 )) 

            SELECT IdNanda, 
                   codigo, 
                   codigopadre, 
                   descripcion, 
                   descripcioncorta,
                   TipoFactor, 
                   nivel, 
                   cadenarecursiva, 
                   IdDominioPAE,
                   IdClasePAE,
                   orden, 
                   estado, 
                   usuariocreacion, 
                   fechacreacion, 
                   usuariomodificacion, 
                   fechamodificacion, 
                   accion, 
                   version 
            FROM   (SELECT SS_HC_NANDA.IdNanda, 
                           SS_HC_NANDA.codigo, 
                           SS_HC_NANDA.codigopadre, 
                           SS_HC_NANDA.descripcion, 
                           SS_HC_NANDA.descripcioncorta, 
                           SS_HC_NANDA.TipoFactor,
                           SS_HC_NANDA.nivel, 
                           SS_HC_NANDA.cadenarecursiva,
                           SS_HC_NANDA.IdDominioPAE,
                           SS_HC_NANDA.IdClasePAE, 
                           SS_HC_NANDA.orden, 
                           SS_HC_NANDA.estado, 
                           SS_HC_NANDA.usuariocreacion, 
                           SS_HC_NANDA.fechacreacion, 
                           SS_HC_NANDA.usuariomodificacion, 
                           SS_HC_NANDA.fechamodificacion, 
                           SS_HC_NANDA.accion, 
                           SS_HC_NANDA.version, 
                           @CONTADOR                                  AS 
                           Contador, 
                           Row_number() 
                             OVER ( 
                               ORDER BY SS_HC_NANDA.IdNanda ASC ) AS 
                           RowNumber 
                    FROM   SS_HC_NANDA 
                     WHERE  ( @Descripcion IS NULL OR Upper(SS_HC_NANDA.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_NANDA.estado = @Estado OR @Estado = 0 ) 
                                    AND ( @Codigo IS NULL OR Upper(SS_HC_NANDA.codigo) LIKE '%' + Upper(@Codigo) + '%' )
                                    AND ( @CodigoPadre IS NULL OR Upper(SS_HC_NANDA.CodigoPadre) LIKE '%' + Upper(@CodigoPadre) + '%' ) 
                                    AND ( @IdDominioPAE IS NULL OR SS_HC_NANDA.IdDominioPAE = @IdDominioPAE OR @IdDominioPAE = 0 ) 
                                    AND ( @IdClasePAE IS NULL OR SS_HC_NANDA.IdClasePAE = @IdClasePAE OR @IdClasePAE = 0 ) 
                                    AND ( @Nivel IS NULL OR SS_HC_NANDA.Nivel = @Nivel OR @Nivel = 0 ) 
                                    AND ( @TipoFactor IS NULL OR SS_HC_NANDA.TipoFactor = @TipoFactor OR @TipoFactor = 0 ) 
                                    AND ( @IdNanda IS NULL OR SS_HC_NANDA.IdNanda = @IdNanda OR @IdNanda = 0 )) 
                   AS LISTADO 
            WHERE  ( @Inicio IS NULL 
                     AND @NumeroFilas IS NULL ) 
                    OR rownumber BETWEEN @Inicio AND @NumeroFilas 
        END 
  END 


GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_NIC]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_NIC] 
@IdNIC               INT, 
@Codigo              VARCHAR(10), 
@CodigoPadre         VARCHAR(10), 
@Descripcion         VARCHAR(300), 
@DescripcionCorta    VARCHAR(100), 

@Nivel               INT, 
@CadenaRecursiva     VARCHAR(150), 
@Orden               INT, 
@Estado              INT, 
@UsuarioCreacion     VARCHAR(25), 

@FechaCreacion       DATETIME, 
@UsuarioModificacion VARCHAR(25), 
@FechaModificacion   DATETIME, 
@Accion              VARCHAR( 25), 
@Version             VARCHAR( 25) 
AS 
  BEGIN 
      SET nocount ON; 

      IF @Accion = 'INSERT' 
        BEGIN 
            SELECT @IdNIC = Isnull(Max(IdNIC), 0) + 1 FROM   dbo.ss_hc_nic  
            INSERT INTO ss_hc_nic 
                        (idnic, 
                         codigo, 
                         codigopadre, 
                         descripcion, 
                         descripcioncorta, 
                         nivel, 
                         cadenarecursiva, 
                         orden, 
                         estado, 
                         usuariocreacion, 
                         fechacreacion, 
                         usuariomodificacion, 
                         fechamodificacion, 
                         accion, 
                         version) 
            VALUES      ( @IdNIC, 
                          @Codigo, 
                          @CodigoPadre, 
                          @Descripcion, 
                          @DescripcionCorta, 
                          @Nivel, 
                          @CadenaRecursiva, 
                          @Orden, 
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
            UPDATE ss_hc_nic 
            SET    idnic = @IdNIC, 
                   codigo = @Codigo, 
                   codigopadre = @CodigoPadre, 
                   descripcion = @Descripcion, 
                   descripcioncorta = @DescripcionCorta, 
                   nivel = @Nivel, 
                   cadenarecursiva = @CadenaRecursiva, 
                   orden = @Orden, 
                   estado = @Estado, 
                 --  usuariocreacion = @UsuarioCreacion, 
                  -- fechacreacion = @FechaCreacion, 
                   usuariomodificacion = @UsuarioModificacion, 
                   fechamodificacion = GETDATE(), 
                   accion = @Accion, 
                   version = @Version 
            WHERE  ( ss_hc_nic.idnic = @IdNIC ) 

            SELECT 1 
        END 
      ELSE IF @Accion = 'DELETE' 
        BEGIN 
            DELETE FROM ss_hc_nic 
            WHERE  ( ss_hc_nic.idnic = @IdNIC ) 

            SELECT 1 
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   ss_hc_nic 
                             WHERE  ( @Descripcion IS NULL OR Upper(ss_hc_nic.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR ss_hc_nic.estado = @Estado OR @Estado = 0 ) 
                                    AND ( @Codigo IS NULL OR Upper(ss_hc_nic.codigo) LIKE '%' + Upper(@Codigo) + '%' )
                                     AND ( @CodigoPadre IS NULL OR Upper(ss_hc_nic.CodigoPadre) LIKE '%' + Upper(@CodigoPadre) + '%' ) 
                                    AND ( @Nivel IS NULL OR ss_hc_nic.Nivel = @Nivel OR @Nivel = 0 ) 
                                    AND ( @IdNIC IS NULL OR ss_hc_nic.IdNIC = @IdNIC OR @IdNIC = 0 )) 

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
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_NIC_ACTIVIDAD]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_NIC_ACTIVIDAD]
@IdNA                  INT,
@IdNic                 INT, 
@IdActividad           INT, 
@Descripcion           VARCHAR(300), 
@Estado                INT, 
@UsuarioCreacion       VARCHAR(25), 
@FechaCreacion         DATETIME, 
@UsuarioModificacion   VARCHAR(25), 
@FechaModificacion     DATETIME, 
@Accion                VARCHAR( 25), 
@Version               VARCHAR( 25) 
AS 
  BEGIN 
      SET nocount ON; 

      IF @Accion = 'INSERT' 
        BEGIN 
            SELECT @IdNA = Isnull(Max(IdNA), 0) + 1 FROM   dbo.SS_HC_NICActividad  
            INSERT INTO SS_HC_NICActividad 
                        (IdNA,
                         IdNic,
                         IdActividad,                         
                         Descripcion,                          
                         Estado, 
                         usuariocreacion, 
                         fechacreacion, 
                         usuariomodificacion, 
                         fechamodificacion, 
                         accion, 
                         version) 
            VALUES      ( 
                          @IdNA,
                          @IdNic , 
                          @IdActividad , 
                          @Descripcion  , 
                          @Estado      , 
                          @UsuarioCreacion   , 
                          Getdate(), 
                          @UsuarioModificacion, 
                          Getdate(), 
                          @Accion, 
                          @Version ) 

            
             SELECT 1 
        END 
      ELSE IF @Accion = 'UPDATE' 
        BEGIN 
            UPDATE SS_HC_NICActividad 
            SET    IdNA = @IdNA, 
                   IdNic = @IdNic, 
                   IdActividad = @IdActividad, 
                   Descripcion = @Descripcion,                 
                   Estado = @Estado, 
                   usuariomodificacion = @UsuarioModificacion, 
                   fechamodificacion = GETDATE(), 
                   accion = @Accion, 
                   version = @Version 
            WHERE  ( SS_HC_NICActividad.IdNA = @IdNA ) 
                   

            SELECT 1 
        END 
      ELSE IF @Accion = 'DELETE' 
        BEGIN 
            DELETE FROM SS_HC_NICActividad 
            WHERE  ( SS_HC_NICActividad.IdNA = @IdNA ) 

            SELECT 1 
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_NICActividad
                             WHERE  (     @Descripcion IS NULL OR Upper(SS_HC_NICActividad.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_NICActividad.Estado = @Estado OR @Estado = 0 )              
                                    AND ( @IdActividad IS NULL OR SS_HC_NICActividad.IdActividad =@IdActividad OR @IdActividad = 0 ) 
                                    AND ( @IdNic IS NULL OR SS_HC_NICActividad.IdNic = @IdNic OR @IdNic = 0 ) 
                                    AND ( @IdNA IS NULL OR SS_HC_NICActividad.IdNA = @IdNA OR @IdNA = 0  )) 
            SELECT @CONTADOR; 
        END 
  END 







GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_NIC_LISTAR2]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_NIC_LISTAR2]
(

	@IdNic int ,
	@Descripcion varchar(300) ,
	@CodigoPadre varchar(10),
	@Codigo varchar(10),	
	@DescripcionCorta varchar(100) ,
	@Nivel int,
	@CadenaRecursiva varchar(150),
	@Orden int,
	@Estado	int ,
	@UsuarioCreacion varchar(25) ,
	@FechaCreacion datetime ,
	
	@UsuarioModificacion varchar(25) ,
	@FechaModificacion datetime ,
		
	@ACCION	varchar(25) ,
	@Version varchar(25),
	
	@INICIO   int= null,  
	@NUMEROFILAS int = null 
			
)

AS
BEGIN
	if(@Accion = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR=(SELECT COUNT(IdNic) FROM SS_HC_NIC
	 					WHERE 
					(@IdNic is null OR (rtrim(upper(IdNic)) like '%'+rtrim(upper(@IdNic))+'%') or @IdNic = '')

					and (@Descripcion is null  OR @Descripcion =''  OR  rtrim(upper(Descripcion)) like '%'+rtrim(upper(@Descripcion))+'%')
					)
	 
		SELECT 
			IdNic as IdNic1
           ,Descripcion
           ,CodigoPadre
           ,Codigo
           ,DescripcionCorta
           ,Nivel
           ,CadenaRecursiva
           ,Orden
           ,Estado
           ,UsuarioCreacion
           ,FechaCreacion
           ,UsuarioModificacion
           ,FechaModificacion
           ,Accion
           ,Version
				
		FROM (
				SELECT 
					SS_HC_NIC.*
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY IdNic ASC ) AS RowNumber   					
				from 
				SS_HC_NIC	 				
	 					WHERE 
					(@IdNic is null OR (rtrim(upper(IdNic)) like '%'+rtrim(upper(@IdNic))+'%') or @IdNic = '')

					and (@Descripcion is null  OR @Descripcion =''  OR  rtrim(upper(Descripcion)) like '%'+rtrim(upper(@Descripcion))+'%')
	
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
	end
	else
	if(@ACCION = 'LISTAR')
	begin
	 
				SELECT 
			IdNic as IdNic1
           ,Descripcion
           ,CodigoPadre
           ,Codigo
           ,DescripcionCorta
           ,Nivel
           ,CadenaRecursiva
           ,Orden
           ,Estado
           ,UsuarioCreacion
           ,FechaCreacion
           ,UsuarioModificacion
           ,FechaModificacion
           ,Accion
           ,Version			
				from 
				SS_HC_NIC	 				
	 					WHERE 
					(@IdNic is null OR (IdNic = @IdNic) or @IdNic = '')

					and (@descripcion is null  OR @descripcion =''  OR  upper(descripcion) like '%'+upper(@descripcion)+'%')
					
						

	end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
			SELECT 
			IdNic as IdNic1
           ,Descripcion
           ,CodigoPadre
           ,Codigo
           ,DescripcionCorta
           ,Nivel
           ,CadenaRecursiva
           ,Orden
           ,Estado
           ,UsuarioCreacion
           ,FechaCreacion
           ,UsuarioModificacion
           ,FechaModificacion
           ,Accion
           ,Version						
				from 
				SS_HC_NIC	 				
	 					WHERE 
					IdNic = @IdNic			
											
					
	end	
	

END

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_NIC2]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_NIC2]
(
	@IdNic int ,
	@Descripcion varchar(300) ,
	@CodigoPadre varchar(10),
	@Codigo varchar(10),	
	@DescripcionCorta varchar(100) ,
	@Nivel int,
	@CadenaRecursiva varchar(150),
	@Orden int,
	@Estado	int ,
	@UsuarioCreacion varchar(25) ,
	@FechaCreacion datetime ,	
	@UsuarioModificacion varchar(25) ,
	@FechaModificacion datetime ,
		
	@ACCION	varchar(25) ,
	@Version varchar(25)
	
	
			
)


AS
BEGIN 
SET NOCOUNT ON;
BEGIN  TRANSACTION

	DECLARE @CONTADOR INT
	
	if(@ACCION = 'INSERT')
	begin		 		 
			
		insert into SS_HC_NIC
		(
			IdNic
           ,Descripcion
           ,CodigoPadre
           ,Codigo
           ,DescripcionCorta
           ,Nivel
           ,CadenaRecursiva
           ,Orden
           ,Estado
           ,UsuarioCreacion
           ,FechaCreacion
           ,UsuarioModificacion
           ,FechaModificacion
           ,Accion
           ,Version
			

		)
		values(
		
	          @IdNic ,
	          @Descripcion  ,
	          @CodigoPadre,
	          @Codigo ,	
	          @DescripcionCorta ,
	          @Nivel ,
	          @CadenaRecursiva ,
	          @Orden ,
	          @Estado ,
	          @UsuarioCreacion ,
	          @FechaCreacion ,	
	          @UsuarioModificacion ,
	          @FechaModificacion ,		
	          @ACCION ,
	          @Version 

	
		)
		
		select 1
	end	
	else
	if(@ACCION = 'UPDATE')
	begin			
		select 1
	end	
	else
	if(@ACCION = 'DELETE')
	begin
		select 1
	end
	else
	if(@ACCION = 'LISTARPAG')
	begin	 	
		SET @CONTADOR=(SELECT COUNT(IdNic) FROM SS_HC_NIC
	 					WHERE 
					(@IdNic is null OR (rtrim(upper(IdNic)) like '%'+rtrim(upper(@IdNic))+'%') or @IdNic = '')

					and (@descripcion is null  OR @descripcion =''  OR  rtrim(upper(Descripcion)) like '%'+rtrim(upper(@Descripcion))+'%')
					)
		select @CONTADOR
	end
commit	
	
END	
/*
exec [SP_SS_HC_companyowner]

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
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_NicActividades_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_NicActividades_LISTAR]

   @IdNA                  INT,
   @IdNic                 INT, 
   @IdActividad           INT, 
   @Descripcion           VARCHAR(300), 
   @Estado                INT, 
   @UsuarioCreacion       VARCHAR(25), 
   @FechaCreacion         DATETIME, 
   @UsuarioModificacion   VARCHAR(25), 
   @FechaModificacion     DATETIME, 
   @Accion                VARCHAR( 25), 
   @Version               VARCHAR( 25) ,
   @INICIO                int= null,  
   @NUMEROFILAS           int = null 
			


AS 
  BEGIN 
      SET nocount ON; 

      DECLARE @CONTADOR INT 

      IF @Accion = 'LISTAR' 
        BEGIN 
            SELECT SS_HC_NICActividad.IdNA, 
                   SS_HC_NICActividad.IdNic, 
                   SS_HC_NICActividad.IdActividad, 
                   SS_HC_NICActividad.Descripcion,                   
                   SS_HC_NICActividad.Estado, 
                   SS_HC_NICActividad.UsuarioCreacion, 
                   SS_HC_NICActividad.FechaCreacion, 
                   SS_HC_NICActividad.UsuarioModificacion, 
                   SS_HC_NICActividad.Fechamodificacion, 
                   SS_HC_NICActividad.Accion, 
                   SS_HC_NICActividad.version 
            FROM   SS_HC_NICActividad 
             WHERE                      ( @Descripcion IS NULL OR Upper(SS_HC_NICActividad.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_NICActividad.Estado = @Estado OR @Estado = 0 ) 
                                    AND ( @IdActividad IS NULL OR SS_HC_NICActividad.IdActividad =@IdActividad OR @IdActividad = 0 ) 
                                    AND ( @IdNic IS NULL OR SS_HC_NICActividad.IdNic = @IdNic OR @IdNic = 0 ) 
                                    AND ( @IdNA IS NULL OR SS_HC_NICActividad.IdNA = @IdNA OR @IdNA = 0 )
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_NICActividad 
                              WHERE     ( @Descripcion IS NULL OR Upper(SS_HC_NICActividad.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_NICActividad.Estado = @Estado OR @Estado = 0 ) 
                                    AND ( @IdActividad IS NULL OR SS_HC_NICActividad.IdActividad =@IdActividad OR @IdActividad = 0 ) 
                                    AND ( @IdNic IS NULL OR SS_HC_NICActividad.IdNic = @IdNic OR @IdNic = 0 ) 
                                    AND ( @IdNA IS NULL OR SS_HC_NICActividad.IdNA = @IdNA OR @IdNA = 0 )) 

            SELECT 
                   IdNA, 
                   IdNic, 
                   IdActividad, 
                   descripcion,                    
                   estado, 
                   usuariocreacion, 
                   fechacreacion, 
                   usuariomodificacion, 
                   fechamodificacion, 
                   accion, 
                   version 
                   
            FROM   (SELECT SS_HC_NICActividad.IdNA,
                           SS_HC_NICActividad.IdNic,
                           SS_HC_NICActividad.IdActividad,                           
                           SS_HC_NICActividad.Descripcion,                           
                           SS_HC_NICActividad.Estado, 
                           SS_HC_NICActividad.usuariocreacion, 
                           SS_HC_NICActividad.fechacreacion, 
                           SS_HC_NICActividad.usuariomodificacion, 
                           SS_HC_NICActividad.fechamodificacion, 
                           SS_HC_NICActividad.accion, 
                           SS_HC_NICActividad.version, 
                           @CONTADOR  
                           AS 
                           Contador, 
                           Row_number() 
                             OVER ( 
                               ORDER BY SS_HC_NICActividad.IdNA ASC ) 
                               AS 
                           RowNumber 
                    FROM   SS_HC_NICActividad 
                     WHERE              ( @Descripcion IS NULL OR Upper(SS_HC_NICActividad.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_NICActividad.Estado = @Estado OR @Estado = 0 ) 
                                    AND ( @IdActividad IS NULL OR SS_HC_NICActividad.IdActividad =@IdActividad OR @IdActividad = 0 ) 
                                    AND ( @IdNic IS NULL OR SS_HC_NICActividad.IdNic = @IdNic OR @IdNic = 0 ) 
                                    AND ( @IdNA IS NULL OR SS_HC_NICActividad.IdNA = @IdNA OR @IdNA = 0 )) 
                   AS LISTADO 
            WHERE  ( @Inicio IS NULL 
                     AND @NumeroFilas IS NULL ) 
                    OR rownumber BETWEEN @Inicio AND @NumeroFilas 
        END 
  END 



GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_NICListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_NICListar] 
@IdNIC               INT, 
@Codigo              VARCHAR(10), 
@CodigoPadre         VARCHAR(10), 
@Descripcion         VARCHAR(300), 
@DescripcionCorta    VARCHAR(100), 
@Nivel               INT, 
@CadenaRecursiva     VARCHAR(150), 
@Orden               INT, 
@Estado              INT, 
@UsuarioCreacion     VARCHAR(25), 
@FechaCreacion       DATETIME, 
@UsuarioModificacion VARCHAR(25), 
@FechaModificacion   DATETIME, 
@Accion              VARCHAR( 25), 
@Version             VARCHAR( 25), 
@INICIO              INT, 
@NUMEROFILAS         INT 
AS 
  BEGIN 
      SET nocount ON; 

      DECLARE @CONTADOR INT 

      IF @Accion = 'LISTAR' 
        BEGIN 
            SELECT ss_hc_nic.idnic, 
                   ss_hc_nic.codigo, 
                   ss_hc_nic.codigopadre, 
                   ss_hc_nic.descripcion, 
                   ss_hc_nic.descripcioncorta, 
                   ss_hc_nic.nivel, 
                   ss_hc_nic.cadenarecursiva, 
                   ss_hc_nic.orden, 
                   ss_hc_nic.estado, 
                   ss_hc_nic.usuariocreacion, 
                   ss_hc_nic.fechacreacion, 
                   ss_hc_nic.usuariomodificacion, 
                   ss_hc_nic.fechamodificacion, 
                   (select Descripcion from SS_HC_NIC where Codigo = (select CodigoPadre from SS_HC_NIC where IdNic=@IdNIC) ) as accion, 
                   ss_hc_nic.version 
            FROM   ss_hc_nic 
             WHERE  ( @Descripcion IS NULL OR Upper(ss_hc_nic.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR ss_hc_nic.estado = @Estado OR @Estado = 0 ) 
                                    AND ( @Codigo IS NULL OR Upper(ss_hc_nic.codigo) LIKE '%' + Upper(@Codigo) + '%' ) 
                                    AND ( @CodigoPadre IS NULL OR Upper(ss_hc_nic.CodigoPadre) LIKE '%' + Upper(@CodigoPadre) + '%' ) 
                                    AND ( @Nivel IS NULL OR ss_hc_nic.Nivel = @Nivel OR @Nivel = 0 ) 
                                    AND ( @IdNIC IS NULL OR ss_hc_nic.IdNIC = @IdNIC OR @IdNIC = 0 )
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            SET @CONTADOR = (SELECT Count(*) 
                             FROM   ss_hc_nic 
                              WHERE  ( @Descripcion IS NULL OR Upper(ss_hc_nic.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR ss_hc_nic.estado = @Estado OR @Estado = 0 ) 
                                    AND ( @Codigo IS NULL OR Upper(ss_hc_nic.codigo) LIKE '%' + Upper(@Codigo) + '%' )
                                    AND ( @CodigoPadre IS NULL OR Upper(ss_hc_nic.CodigoPadre) LIKE '%' + Upper(@CodigoPadre) + '%' ) 
                                    AND ( @Nivel IS NULL OR ss_hc_nic.Nivel = @Nivel OR @Nivel = 0 ) 
                                    AND ( @IdNIC IS NULL OR ss_hc_nic.IdNIC = @IdNIC OR @IdNIC = 0 )) 

            SELECT idnic, 
                   codigo, 
                   codigopadre, 
                   descripcion, 
                   descripcioncorta, 
                   nivel, 
                   cadenarecursiva, 
                   orden, 
                   estado, 
                   usuariocreacion, 
                   fechacreacion, 
                   usuariomodificacion, 
                   fechamodificacion, 
                   accion, 
                   version 
            FROM   (SELECT ss_hc_nic.idnic, 
                           ss_hc_nic.codigo, 
                           ss_hc_nic.codigopadre, 
                           ss_hc_nic.descripcion, 
                           ss_hc_nic.descripcioncorta, 
                           ss_hc_nic.nivel, 
                           ss_hc_nic.cadenarecursiva, 
                           ss_hc_nic.orden, 
                           ss_hc_nic.estado, 
                           ss_hc_nic.usuariocreacion, 
                           ss_hc_nic.fechacreacion, 
                           ss_hc_nic.usuariomodificacion, 
                           ss_hc_nic.fechamodificacion, 
                           ss_hc_nic.accion, 
                           ss_hc_nic.version, 
                           @CONTADOR                                  AS 
                           Contador, 
                           Row_number() 
                             OVER ( 
                               ORDER BY ss_hc_nic.idnic ASC ) AS 
                           RowNumber 
                    FROM   ss_hc_nic 
                     WHERE  ( @Descripcion IS NULL OR Upper(ss_hc_nic.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR ss_hc_nic.estado = @Estado OR @Estado = 0 ) 
                                    AND ( @Codigo IS NULL OR Upper(ss_hc_nic.codigo) LIKE '%' + Upper(@Codigo) + '%' )
                                    AND ( @CodigoPadre IS NULL OR Upper(ss_hc_nic.CodigoPadre) LIKE '%' + Upper(@CodigoPadre) + '%' ) 
                                    AND ( @Nivel IS NULL OR ss_hc_nic.Nivel = @Nivel OR @Nivel = 0 ) 
                                    AND ( @IdNIC IS NULL OR ss_hc_nic.IdNIC = @IdNIC OR @IdNIC = 0 )) 
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
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_NOC]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_NOC]
			@IdNOC int,
            @IdNOCPadre int,
            @Codigo varchar(10),
            @CodigoPadre varchar(10),
            @Descripcion varchar(300),
            @DescripcionCorta varchar(100),
            @TipoNive4 int,
            @Nivel int,
            @CadenaRecursiva varchar(150),
            @Orden int,
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
 		select @CONTADOR= isnull(MAX(IdNOC),0)+1 from ss_hc_noc 
		
		set @IdNOC= @CONTADOR
		
  INSERT INTO ss_hc_noc  
  (  
				
				IdNOC,
				IdNOCPadre,
				Codigo,
				CodigoPadre,
				Descripcion,
				DescripcionCorta,
				TipoNive4,
				Nivel,
				CadenaRecursiva,
				Orden,
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
				
				@IdNOC,
				@IdNOCPadre,
				@Codigo,
				@CodigoPadre,
				@Descripcion,
				@DescripcionCorta,
				@TipoNive4,
				@Nivel,
				@CadenaRecursiva,
				@Orden,
				@Estado,
				@UsuarioCreacion,
				GETDATE(),
				@UsuarioModificacion,
				GETDATE(),
				@Accion,
				@Version
  )  
  
 SELECT 1		 
 END   
 ELSE  
 IF(@Accion = 'UPDATE')  
 BEGIN  
 UPDATE ss_hc_noc  
  SET      
				IdNOC = @IdNOC,
				IdNOCPadre = @IdNOCPadre,
				Codigo = @Codigo,
				CodigoPadre = @CodigoPadre,
				Descripcion = @Descripcion,
				DescripcionCorta = @DescripcionCorta,
				TipoNive4 = @TipoNive4,
				Nivel = @Nivel,
				CadenaRecursiva = @CadenaRecursiva,
				Orden = @Orden,
				Estado = @Estado,
				UsuarioModificacion = @UsuarioModificacion,
				FechaModificacion = GETDATE(),
				Accion = @Accion,
				Version= @Version
		WHERE 
		(IdNOC = @IdNOC)  
   		select 1
 end   
 else  
 if(@Accion = 'DELETE')  
 begin  
  delete ss_hc_noc  
		WHERE 
		(IdNOC = @IdNOC)  
   		select 1
end
		if(@Accion = 'CONTARLISTAPAG')
	begin		
		
		SET @CONTADOR=(SELECT COUNT(IdNOC) FROM ss_hc_noc
	 					WHERE 
					(@IdNOC is null OR (IdNOC = @IdNOC) or @IdNOC =0)
					and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')					
					and (@Estado is null OR Estado = @Estado)
					)
					
		select @CONTADOR
	end
commit	 
END  
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_NOC_INDICADOR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_NOC_INDICADOR]
    @IdNIN               INT,
    @IdNoc               INT, 
	@IdIndicadorPAE      INT, 
	@Descripcion         VARCHAR(300), 
    @Estado              INT, 
    @UsuarioCreacion     VARCHAR(25), 
    @FechaCreacion       DATETIME, 
    @UsuarioModificacion VARCHAR(25), 
    @FechaModificacion   DATETIME, 
    @Accion              VARCHAR( 25), 
    @Version             VARCHAR( 25)
AS 
  BEGIN 
      SET nocount ON; 

      IF @Accion = 'INSERT' 
        BEGIN 
            SELECT @IdNIN = Isnull(Max(IdNIN), 0) + 1 FROM   dbo.SS_HC_NOCIndicador  
            INSERT INTO SS_HC_NOCIndicador 
                        (IdNIN,
                         IdNoc,
                         IdIndicadorPAE,                         
                         Descripcion,                          
                         Estado, 
                         usuariocreacion, 
                         fechacreacion, 
                         usuariomodificacion, 
                         fechamodificacion, 
                         accion, 
                         version) 
            VALUES      ( 
                          @IdNIN,
                          @IdNoc , 
                          @IdIndicadorPAE , 
                          @Descripcion  , 
                          @Estado      , 
                          @UsuarioCreacion   , 
                          Getdate(), 
                          @UsuarioModificacion, 
                          Getdate(), 
                          @Accion, 
                          @Version ) 

            
             SELECT 1 
        END 
      ELSE IF @Accion = 'UPDATE' 
        BEGIN 
            UPDATE SS_HC_NOCIndicador 
            SET    IdNIN = @IdNIN, 
                   IdNoc = @IdNoc, 
                   IdIndicadorPAE = @IdIndicadorPAE, 
                   Descripcion = @Descripcion,                 
                   Estado = @Estado, 
                   usuariomodificacion = @UsuarioModificacion, 
                   fechamodificacion = GETDATE(), 
                   accion = @Accion, 
                   version = @Version 
            WHERE  ( SS_HC_NOCIndicador.IdNIN = @IdNIN ) 
                   

            SELECT 1 
        END 
      ELSE IF @Accion = 'DELETE' 
        BEGIN 
            DELETE FROM SS_HC_NOCIndicador 
            WHERE  ( SS_HC_NOCIndicador.IdNIN = @IdNIN ) 

            SELECT 1 
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_NOCIndicador
                             WHERE  (     @Descripcion IS NULL OR Upper(SS_HC_NOCIndicador.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_NOCIndicador.Estado = @Estado OR @Estado = 0 )              
                                    AND ( @IdIndicadorPAE IS NULL OR SS_HC_NOCIndicador.IdIndicadorPAE =@IdIndicadorPAE OR @IdIndicadorPAE = 0 ) 
                                    AND ( @IdNoc IS NULL OR SS_HC_NOCIndicador.IdNoc = @IdNoc OR @IdNoc = 0 ) 
                                    AND ( @IdNIN IS NULL OR SS_HC_NOCIndicador.IdNIN = @IdNIN OR @IdNIN = 0  )) 
            SELECT @CONTADOR; 
        END 
  END 






GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_NOC_Lista]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_NOC_Lista]
			@IdNOC int,
            @IdNOCPadre int,
            @Codigo varchar(10),
            @CodigoPadre varchar(10),
            @Descripcion varchar(300),
            @DescripcionCorta varchar(100),
            @TipoNive4 int,
            @Nivel int,
            @CadenaRecursiva varchar(150),
            @Orden int,
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
if(@Accion = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
		SET @CONTADOR=(SELECT COUNT(IdNOC) FROM ss_hc_noc
	 					WHERE 
					(@IdNOC is null OR (IdNOC = @IdNOC) or @IdNOC =0)
					and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')					
					and (@Estado is null OR Estado = @Estado)
					)
		SELECT
				IdNOC,
				IdNOCPadre,
				Codigo,
				CodigoPadre,
				Descripcion,
				DescripcionCorta,
				TipoNive4,
				Nivel,
				CadenaRecursiva,
				Orden,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version
		FROM (		
			SELECT
				IdNOC,
				IdNOCPadre,
				Codigo,
				CodigoPadre,
				Descripcion,
				DescripcionCorta,
				TipoNive4,
				Nivel,
				CadenaRecursiva,
				Orden,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY IdNOC ASC ) AS RowNumber   	
					FROM ss_hc_noc	
					WHERE 
						(@IdNOC is null OR (IdNOC = @IdNOC) or @IdNOC =0)				
					and (@Codigo is null  OR @Codigo =''  OR  upper(Codigo) like '%'+upper(@Codigo)+'%')					
					and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')					
					and (@Estado is null OR Estado = @Estado)		
 
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		
       END
       ELSE
  IF @Accion ='LISTAR'    
    BEGIN    
		SELECT
				IdNOC,
				IdNOCPadre,
				Codigo,
				CodigoPadre,
				Descripcion,
				DescripcionCorta,
				TipoNive4,
				Nivel,
				CadenaRecursiva,
				Orden,
				Estado,
				UsuarioCreacion,
				FechaCreacion,
				UsuarioModificacion,
				FechaModificacion,
				Accion,
				Version
				FROM ss_hc_noc	
				WHERE 
						(@IdNOC is null OR (IdNOC = @IdNOC) or @IdNOC =0)				
					and(@IdNOCPadre is null OR (IdNOCPadre = @IdNOCPadre) or @IdNOCPadre =0)				
					and(@Codigo is null OR (Codigo = @Codigo))				
					and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')					
					and (@Estado is null OR Estado = @Estado)	
 
end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 
					*					
				from 
				ss_hc_noc

					WHERE 
					(@IdNOC is null OR (IdNOC = @IdNOC) or @IdNOC =0)	

	end	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_NOC_LISTAR2]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_NOC_LISTAR2]

@IdNoc             INT, 
@Codigo              VARCHAR(10), 
@CodigoPadre         VARCHAR(10), 
@Descripcion         VARCHAR(300), 
@DescripcionCorta    VARCHAR(100), 

@Nivel               INT, 
@CadenaRecursiva     VARCHAR(150), 
@Orden               INT, 
@Estado              INT, 
@UsuarioCreacion     VARCHAR(25), 

@FechaCreacion       DATETIME, 
@UsuarioModificacion VARCHAR(25), 
@FechaModificacion   DATETIME, 
@Accion              VARCHAR( 25), 
@Version             VARCHAR( 25), 

@INICIO              INT, 
@NUMEROFILAS         INT 
AS 
  BEGIN 
      SET nocount ON; 

      DECLARE @CONTADOR INT 

      IF @Accion = 'LISTAR' 
        BEGIN 
            SELECT ss_hc_noc2.idnoc, 
                   ss_hc_noc2.codigo, 
                   ss_hc_noc2.codigopadre, 
                   ss_hc_noc2.descripcion, 
                   ss_hc_noc2.descripcioncorta, 
                   ss_hc_noc2.nivel, 
                   ss_hc_noc2.cadenarecursiva, 
                   ss_hc_noc2.orden, 
                   ss_hc_noc2.estado, 
                   ss_hc_noc2.usuariocreacion, 
                   ss_hc_noc2.fechacreacion, 
                   ss_hc_noc2.usuariomodificacion, 
                   ss_hc_noc2.fechamodificacion, 
                   (select Descripcion from ss_hc_noc2 where Codigo = (select CodigoPadre from ss_hc_noc2 where IdNoc=@IdNoc) ) as accion, 
                   ss_hc_noc2.version 
            FROM   ss_hc_noc2 
             WHERE  ( @Descripcion IS NULL OR Upper(ss_hc_noc2.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR ss_hc_noc2.estado = @Estado OR @Estado = 0 ) 
                                    AND ( @Codigo IS NULL OR Upper(ss_hc_noc2.codigo) LIKE '%' + Upper(@Codigo) + '%' ) 
                                    AND ( @CodigoPadre IS NULL OR Upper(ss_hc_noc2.CodigoPadre) LIKE '%' + Upper(@CodigoPadre) + '%' ) 
                                    AND ( @Nivel IS NULL OR ss_hc_noc2.Nivel = @Nivel OR @Nivel = 0 ) 
                                    AND ( @IdNoc IS NULL OR ss_hc_noc2.IdNoc = @IdNoc OR @IdNoc = 0 )
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            SET @CONTADOR = (SELECT Count(*) 
                             FROM   ss_hc_noc2 
                              WHERE  ( @Descripcion IS NULL OR Upper(ss_hc_noc2.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR ss_hc_noc2.estado = @Estado OR @Estado = 0 ) 
                                    AND ( @Codigo IS NULL OR Upper(ss_hc_noc2.codigo) LIKE '%' + Upper(@Codigo) + '%' )
                                    AND ( @CodigoPadre IS NULL OR Upper(ss_hc_noc2.CodigoPadre) LIKE '%' + Upper(@CodigoPadre) + '%' ) 
                                    AND ( @Nivel IS NULL OR ss_hc_noc2.Nivel = @Nivel OR @Nivel = 0 ) 
                                    AND ( @IdNoc IS NULL OR ss_hc_noc2.IdNoc = @IdNoc OR @IdNoc = 0 )) 

            SELECT idnoc, 
                   codigo, 
                   codigopadre, 
                   descripcion, 
                   descripcioncorta, 
                   nivel, 
                   cadenarecursiva, 
                   orden, 
                   estado, 
                   usuariocreacion, 
                   fechacreacion, 
                   usuariomodificacion, 
                   fechamodificacion, 
                   accion, 
                   version 
            FROM   (SELECT ss_hc_noc2.idnoc, 
                           ss_hc_noc2.codigo, 
                           ss_hc_noc2.codigopadre, 
                           ss_hc_noc2.descripcion, 
                           ss_hc_noc2.descripcioncorta, 
                           ss_hc_noc2.nivel, 
                           ss_hc_noc2.cadenarecursiva, 
                           ss_hc_noc2.orden, 
                           ss_hc_noc2.estado, 
                           ss_hc_noc2.usuariocreacion, 
                           ss_hc_noc2.fechacreacion, 
                           ss_hc_noc2.usuariomodificacion, 
                           ss_hc_noc2.fechamodificacion, 
                           ss_hc_noc2.accion, 
                           ss_hc_noc2.version, 
                           @CONTADOR                                 
                            AS 
                           Contador, 
                           Row_number() 
                             OVER ( 
                               ORDER BY ss_hc_noc2.idnoc ASC ) AS 
                           RowNumber 
                    FROM   ss_hc_noc2 
                     WHERE  ( @Descripcion IS NULL OR Upper(ss_hc_noc2.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR ss_hc_noc2.estado = @Estado OR @Estado = 0 ) 
                                    AND ( @Codigo IS NULL OR Upper(ss_hc_noc2.codigo) LIKE '%' + Upper(@Codigo) + '%' )
                                    AND ( @CodigoPadre IS NULL OR Upper(ss_hc_noc2.CodigoPadre) LIKE '%' + Upper(@CodigoPadre) + '%' ) 
                                    AND ( @Nivel IS NULL OR ss_hc_noc2.Nivel = @Nivel OR @Nivel = 0 ) 
                                    AND ( @IdNoc IS NULL OR ss_hc_noc2.IdNoc = @IdNoc OR @IdNoc = 0 )) 
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
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_NOC_NANDA]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_NOC_NANDA]
@IdNanNoc              INT,
@IdNanda               INT, 
@IdNoc                 INT, 
@Descripcion         VARCHAR(300), 
@Estado              INT, 
@UsuarioCreacion     VARCHAR(25), 
@FechaCreacion       DATETIME, 
@UsuarioModificacion VARCHAR(25), 
@FechaModificacion   DATETIME, 
@Accion              VARCHAR( 25), 
@Version             VARCHAR( 25) 
AS 
  BEGIN 
      SET nocount ON; 

      IF @Accion = 'INSERT' 
        BEGIN 
            SELECT @IdNanNoc = Isnull(Max(IdNanNoc), 0) + 1 FROM   dbo.SS_HC_NandaNoc  
            INSERT INTO SS_HC_NandaNoc 
                        (IdNanNoc,
                         IdNanda,
                         IdNoc,                         
                         Descripcion,                          
                         Estado, 
                         usuariocreacion, 
                         fechacreacion, 
                         usuariomodificacion, 
                         fechamodificacion, 
                         accion, 
                         version) 
            VALUES      ( 
                          @IdNanNoc,
                          @IdNanda , 
                          @IdNoc , 
                          @Descripcion  , 
                          @Estado      , 
                          @UsuarioCreacion   , 
                          Getdate(), 
                          @UsuarioModificacion, 
                          Getdate(), 
                          @Accion, 
                          @Version ) 

            
             SELECT 1 
        END 
      ELSE IF @Accion = 'UPDATE' 
        BEGIN 
            UPDATE SS_HC_NandaNoc 
            SET    IdNanNoc = @IdNanNoc, 
                   IdNanda = @IdNanda, 
                   IdNoc = @IdNoc, 
                   Descripcion = @Descripcion,                 
                   Estado = @Estado, 
                   usuariomodificacion = @UsuarioModificacion, 
                   fechamodificacion = GETDATE(), 
                   accion = @Accion, 
                   version = @Version 
            WHERE  ( SS_HC_NandaNoc.IdNanNoc = @IdNanNoc ) 
                   

            SELECT 1 
        END 
      ELSE IF @Accion = 'DELETE' 
        BEGIN 
            DELETE FROM SS_HC_NandaNoc 
            WHERE  ( SS_HC_NandaNoc.IdNanNoc = @IdNanNoc ) 

            SELECT 1 
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_NandaNoc
                             WHERE  (     @Descripcion IS NULL OR Upper(SS_HC_NandaNoc.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_NandaNoc.Estado = @Estado OR @Estado = 0 )              
                                    AND ( @IdNanda IS NULL OR SS_HC_NandaNoc.IdNanda =@IdNanda OR @IdNanda = 0 ) 
                                    AND ( @IdNoc IS NULL OR SS_HC_NandaNoc.IdNoc = @IdNoc OR @IdNoc = 0 ) 
                                    AND ( @IdNanNoc IS NULL OR SS_HC_NandaNoc.IdNanNoc = @IdNanNoc OR @IdNanNoc = 0  )) 
            SELECT @CONTADOR; 
        END 
  END 





GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_NOC_NIC]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_NOC_NIC]
@IdNC              INT,
@IdNoc               INT, 
@IdNic                 INT, 
@Descripcion         VARCHAR(300), 
@Estado              INT, 
@UsuarioCreacion     VARCHAR(25), 
@FechaCreacion       DATETIME, 
@UsuarioModificacion VARCHAR(25), 
@FechaModificacion   DATETIME, 
@Accion              VARCHAR( 25), 
@Version             VARCHAR( 25) 
AS 
  BEGIN 
      SET nocount ON; 

      IF @Accion = 'INSERT' 
        BEGIN 
            SELECT @IdNC = Isnull(Max(IdNC), 0) + 1 FROM   dbo.SS_HC_NocNic  
            INSERT INTO SS_HC_NocNic 
                        (IdNC,
                         IdNoc,
                         IdNic,                         
                         Descripcion,                          
                         Estado, 
                         usuariocreacion, 
                         fechacreacion, 
                         usuariomodificacion, 
                         fechamodificacion, 
                         accion, 
                         version) 
            VALUES      ( 
                          @IdNC,
                          @IdNoc , 
                          @IdNic , 
                          @Descripcion  , 
                          @Estado      , 
                          @UsuarioCreacion   , 
                          Getdate(), 
                          @UsuarioModificacion, 
                          Getdate(), 
                          @Accion, 
                          @Version ) 

            
             SELECT 1 
        END 
      ELSE IF @Accion = 'UPDATE' 
        BEGIN 
            UPDATE SS_HC_NocNic 
            SET    IdNC = @IdNC, 
                   IdNoc = @IdNoc, 
                   IdNic = @IdNic, 
                   Descripcion = @Descripcion,                 
                   Estado = @Estado, 
                   usuariomodificacion = @UsuarioModificacion, 
                   fechamodificacion = GETDATE(), 
                   accion = @Accion, 
                   version = @Version 
            WHERE  ( SS_HC_NocNic.IdNC = @IdNC ) 
                   

            SELECT 1 
        END 
      ELSE IF @Accion = 'DELETE' 
        BEGIN 
            DELETE FROM SS_HC_NocNic 
            WHERE  ( SS_HC_NocNic.IdNC = @IdNC ) 

            SELECT 1 
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_NocNic
                             WHERE  (     @Descripcion IS NULL OR Upper(SS_HC_NocNic.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_NocNic.Estado = @Estado OR @Estado = 0 )              
                                    AND ( @IdNoc IS NULL OR SS_HC_NocNic.IdNoc =@IdNoc OR @IdNoc = 0 ) 
                                    AND ( @IdNic IS NULL OR SS_HC_NocNic.IdNic = @IdNic OR @IdNic = 0 ) 
                                    AND ( @IdNC IS NULL OR SS_HC_NocNic.IdNC = @IdNC OR @IdNC = 0  )) 
            SELECT @CONTADOR; 
        END 
  END 






GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_NOC2]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_NOC2]
@IdNoc               INT, 
@Codigo              VARCHAR(10), 
@CodigoPadre         VARCHAR(10), 
@Descripcion         VARCHAR(300), 
@DescripcionCorta    VARCHAR(100), 

@Nivel               INT, 
@CadenaRecursiva     VARCHAR(150), 
@Orden               INT, 
@Estado              INT, 
@UsuarioCreacion     VARCHAR(25), 

@FechaCreacion       DATETIME, 
@UsuarioModificacion VARCHAR(25), 
@FechaModificacion   DATETIME, 
@Accion              VARCHAR( 25), 
@Version             VARCHAR( 25) 
AS 
  BEGIN 
      SET nocount ON; 

      IF @Accion = 'INSERT' 
        BEGIN 
            SELECT @IdNoc = Isnull(Max(IdNoc), 0) + 1 FROM   dbo.ss_hc_noc2  
            INSERT INTO ss_hc_noc2 
                        (idnoc, 
                         codigo, 
                         codigopadre, 
                         descripcion, 
                         descripcioncorta, 
                         nivel, 
                         cadenarecursiva, 
                         orden, 
                         estado, 
                         usuariocreacion, 
                         fechacreacion, 
                         usuariomodificacion, 
                         fechamodificacion, 
                         accion, 
                         version) 
            VALUES      ( @IdNoc, 
                          @Codigo, 
                          @CodigoPadre, 
                          @Descripcion, 
                          @DescripcionCorta, 
                          @Nivel, 
                          @CadenaRecursiva, 
                          @Orden, 
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
            UPDATE ss_hc_noc2 
            SET    idnoc = @IdNoc, 
                   codigo = @Codigo, 
                   codigopadre = @CodigoPadre, 
                   descripcion = @Descripcion, 
                   descripcioncorta = @DescripcionCorta, 
                   nivel = @Nivel, 
                   cadenarecursiva = @CadenaRecursiva, 
                   orden = @Orden, 
                   estado = @Estado, 
                 --  usuariocreacion = @UsuarioCreacion, 
                  -- fechacreacion = @FechaCreacion, 
                   usuariomodificacion = @UsuarioModificacion, 
                   fechamodificacion = GETDATE(), 
                   accion = @Accion, 
                   version = @Version 
            WHERE  ( ss_hc_noc2.idnoc = @IdNoc ) 

            SELECT 1 
        END 
      ELSE IF @Accion = 'DELETE' 
        BEGIN 
            DELETE FROM ss_hc_noc2 
            WHERE  ( ss_hc_noc2.idnoc = @IdNoc ) 

            SELECT 1 
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   ss_hc_noc2
                             WHERE  ( @Descripcion IS NULL OR Upper(ss_hc_noc2.descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR ss_hc_noc2.estado = @Estado OR @Estado = 0 ) 
                                    AND ( @Codigo IS NULL OR Upper(ss_hc_noc2.codigo) LIKE '%' + Upper(@Codigo) + '%' )
                                     AND ( @CodigoPadre IS NULL OR Upper(ss_hc_noc2.CodigoPadre) LIKE '%' + Upper(@CodigoPadre) + '%' ) 
                                    AND ( @Nivel IS NULL OR ss_hc_noc2.Nivel = @Nivel OR @Nivel = 0 ) 
                                    AND ( @IdNoc IS NULL OR ss_hc_noc2.IdNoc = @IdNoc OR @IdNoc = 0 )) 

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
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_NocIndicador_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_NocIndicador_LISTAR]

    @IdNIN               INT,
    @IdNoc               INT, 
	@IdIndicadorPAE      INT, 
	@Descripcion         VARCHAR(300), 
    @Estado              INT, 
    @UsuarioCreacion     VARCHAR(25), 
    @FechaCreacion       DATETIME, 
    @UsuarioModificacion VARCHAR(25), 
    @FechaModificacion   DATETIME, 
    @Accion              VARCHAR( 25), 
    @Version             VARCHAR( 25) ,	
	@INICIO   int= null,  
	@NUMEROFILAS int = null 
			


AS 
  BEGIN 
      SET nocount ON; 

      DECLARE @CONTADOR INT 

      IF @Accion = 'LISTAR' 
        BEGIN 
            SELECT SS_HC_NOCIndicador.IdNIN, 
                   SS_HC_NOCIndicador.IdNoc, 
                   SS_HC_NOCIndicador.IdIndicadorPAE, 
                   SS_HC_NOCIndicador.Descripcion,                   
                   SS_HC_NOCIndicador.Estado, 
                   SS_HC_NOCIndicador.UsuarioCreacion, 
                   SS_HC_NOCIndicador.FechaCreacion, 
                   SS_HC_NOCIndicador.UsuarioModificacion, 
                   SS_HC_NOCIndicador.Fechamodificacion, 
                   SS_HC_NOCIndicador.Accion, 
                   SS_HC_NOCIndicador.version 
            FROM   SS_HC_NOCIndicador 
             WHERE                      ( @Descripcion IS NULL OR Upper(SS_HC_NOCIndicador.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_NOCIndicador.Estado = @Estado OR @Estado = 0 ) 
                                    AND ( @IdIndicadorPAE IS NULL OR SS_HC_NOCIndicador.IdIndicadorPAE =@IdIndicadorPAE OR @IdIndicadorPAE = 0 ) 
                                    AND ( @IdNoc IS NULL OR SS_HC_NOCIndicador.IdNoc = @IdNoc OR @IdNoc = 0 ) 
                                    AND ( @IdNIN IS NULL OR SS_HC_NOCIndicador.IdNIN = @IdNIN OR @IdNIN = 0 )
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_NOCIndicador 
                              WHERE     ( @Descripcion IS NULL OR Upper(SS_HC_NOCIndicador.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_NOCIndicador.Estado = @Estado OR @Estado = 0 ) 
                                    AND ( @IdIndicadorPAE IS NULL OR SS_HC_NOCIndicador.IdIndicadorPAE =@IdIndicadorPAE OR @IdIndicadorPAE = 0 ) 
                                    AND ( @IdNoc IS NULL OR SS_HC_NOCIndicador.IdNoc = @IdNoc OR @IdNoc = 0 ) 
                                    AND ( @IdNIN IS NULL OR SS_HC_NOCIndicador.IdNIN = @IdNIN OR @IdNIN = 0 )) 

            SELECT 
            
                   IdNIN, 
                   IdNoc, 
                   IdIndicadorPAE, 
                   Descripcion,                    
                   Estado, 
                   Usuariocreacion, 
                   Fechacreacion, 
                   Usuariomodificacion, 
                   Fechamodificacion, 
                   Accion, 
                   version 
            FROM   (SELECT SS_HC_NOCIndicador.IdNIN,
                           SS_HC_NOCIndicador.IdNoc,
                           SS_HC_NOCIndicador.IdIndicadorPAE,                           
                           SS_HC_NOCIndicador.Descripcion,                           
                           SS_HC_NOCIndicador.Estado, 
                           SS_HC_NOCIndicador.Usuariocreacion, 
                           SS_HC_NOCIndicador.Fechacreacion, 
                           SS_HC_NOCIndicador.Usuariomodificacion, 
                           SS_HC_NOCIndicador.Fechamodificacion, 
                           SS_HC_NOCIndicador.Accion, 
                           SS_HC_NOCIndicador.version, 
                           @CONTADOR  
                           AS 
                           Contador, 
                           Row_number() 
                             OVER ( 
                               ORDER BY SS_HC_NOCIndicador.IdNIN ASC ) 
                               AS 
                           RowNumber 
                    FROM   SS_HC_NOCIndicador 
                     WHERE              ( @Descripcion IS NULL OR Upper(SS_HC_NOCIndicador.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_NOCIndicador.Estado = @Estado OR @Estado = 0 ) 
                                    AND ( @IdIndicadorPAE IS NULL OR SS_HC_NOCIndicador.IdIndicadorPAE =@IdIndicadorPAE OR @IdIndicadorPAE = 0 ) 
                                    AND ( @IdNoc IS NULL OR SS_HC_NOCIndicador.IdNoc = @IdNoc OR @IdNoc = 0 ) 
                                    AND ( @IdNIN IS NULL OR SS_HC_NOCIndicador.IdNIN = @IdNIN OR @IdNIN = 0 )) 
                   AS LISTADO 
            WHERE  ( @Inicio IS NULL 
                     AND @NumeroFilas IS NULL ) 
                    OR rownumber BETWEEN @Inicio AND @NumeroFilas 
        END 
  END 

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_NocNanda_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_NocNanda_LISTAR]

    @IdNanNoc            INT,
    @IdNanda             INT, 
	@IdNoc               INT, 
	@Descripcion         VARCHAR(300), 
    @Estado              INT, 
    @UsuarioCreacion     VARCHAR(25), 
    @FechaCreacion       DATETIME, 
    @UsuarioModificacion VARCHAR(25), 
    @FechaModificacion   DATETIME, 
    @Accion              VARCHAR( 25), 
    @Version             VARCHAR( 25) ,	
	@INICIO   int= null,  
	@NUMEROFILAS int = null 
			


AS 
  BEGIN 
      SET nocount ON; 

      DECLARE @CONTADOR INT 

      IF @Accion = 'LISTAR' 
        BEGIN 
            SELECT SS_HC_NandaNoc.IdNanNoc, 
                   SS_HC_NandaNoc.IdNanda, 
                   SS_HC_NandaNoc.IdNoc, 
                   SS_HC_NandaNoc.Descripcion,                   
                   SS_HC_NandaNoc.Estado, 
                   SS_HC_NandaNoc.UsuarioCreacion, 
                   SS_HC_NandaNoc.FechaCreacion, 
                   SS_HC_NandaNoc.UsuarioModificacion, 
                   SS_HC_NandaNoc.Fechamodificacion, 
                   SS_HC_NandaNoc.Accion, 
                   SS_HC_NandaNoc.version 
            FROM   SS_HC_NandaNoc 
             WHERE                      ( @Descripcion IS NULL OR Upper(SS_HC_NandaNoc.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_NandaNoc.Estado = @Estado OR @Estado = 0 ) 
                                    AND ( @IdNanda IS NULL OR SS_HC_NandaNoc.IdNanda =@IdNanda OR @IdNanda = 0 ) 
                                    AND ( @IdNoc IS NULL OR SS_HC_NandaNoc.IdNoc = @IdNoc OR @IdNoc = 0 ) 
                                    AND ( @IdNanNoc IS NULL OR SS_HC_NandaNoc.IdNanNoc = @IdNanNoc OR @IdNanNoc = 0 )
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_NandaNoc 
                              WHERE     ( @Descripcion IS NULL OR Upper(SS_HC_NandaNoc.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_NandaNoc.Estado = @Estado OR @Estado = 0 ) 
                                    AND ( @IdNanda IS NULL OR SS_HC_NandaNoc.IdNanda =@IdNanda OR @IdNanda = 0 ) 
                                    AND ( @IdNoc IS NULL OR SS_HC_NandaNoc.IdNoc = @IdNoc OR @IdNoc = 0 ) 
                                    AND ( @IdNanNoc IS NULL OR SS_HC_NandaNoc.IdNanNoc = @IdNanNoc OR @IdNanNoc = 0 )) 

            SELECT 
            
                   IdNanNoc, 
                   IdNanda, 
                   IdNoc, 
                   descripcion,                    
                   estado, 
                   usuariocreacion, 
                   fechacreacion, 
                   usuariomodificacion, 
                   fechamodificacion, 
                   accion, 
                   version 
            FROM   (SELECT SS_HC_NandaNoc.IdNanNoc,
                           SS_HC_NandaNoc.IdNanda,
                           SS_HC_NandaNoc.IdNoc,                           
                           SS_HC_NandaNoc.Descripcion,                           
                           SS_HC_NandaNoc.Estado, 
                           SS_HC_NandaNoc.usuariocreacion, 
                           SS_HC_NandaNoc.fechacreacion, 
                           SS_HC_NandaNoc.usuariomodificacion, 
                           SS_HC_NandaNoc.fechamodificacion, 
                           SS_HC_NandaNoc.accion, 
                           SS_HC_NandaNoc.version, 
                           @CONTADOR  
                           AS 
                           Contador, 
                           Row_number() 
                             OVER ( 
                               ORDER BY SS_HC_NandaNoc.IdNanNoc ASC ) 
                               AS 
                           RowNumber 
                    FROM   SS_HC_NandaNoc 
                     WHERE              ( @Descripcion IS NULL OR Upper(SS_HC_NandaNoc.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_NandaNoc.Estado = @Estado OR @Estado = 0 ) 
                                    AND ( @IdNanda IS NULL OR SS_HC_NandaNoc.IdNanda =@IdNanda OR @IdNanda = 0 ) 
                                    AND ( @IdNoc IS NULL OR SS_HC_NandaNoc.IdNoc = @IdNoc OR @IdNoc = 0 ) 
                                    AND ( @IdNanNoc IS NULL OR SS_HC_NandaNoc.IdNanNoc = @IdNanNoc OR @IdNanNoc = 0 )) 
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
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_NocNic_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_NocNic_LISTAR]

    @IdNC              INT,
    @IdNoc               INT, 
    @IdNic                 INT, 
    @Descripcion         VARCHAR(300), 
    @Estado              INT, 
    @UsuarioCreacion     VARCHAR(25), 
    @FechaCreacion       DATETIME, 
    @UsuarioModificacion VARCHAR(25), 
    @FechaModificacion   DATETIME, 
    @Accion              VARCHAR( 25), 
    @Version             VARCHAR( 25) ,
	@INICIO   int= null,  
	@NUMEROFILAS int = null 
			


AS 
  BEGIN 
      SET nocount ON; 

      DECLARE @CONTADOR INT 

      IF @Accion = 'LISTAR' 
        BEGIN 
            SELECT SS_HC_NocNic.IdNC, 
                   SS_HC_NocNic.IdNoc, 
                   SS_HC_NocNic.IdNic, 
                   SS_HC_NocNic.Descripcion,                   
                   SS_HC_NocNic.Estado, 
                   SS_HC_NocNic.UsuarioCreacion, 
                   SS_HC_NocNic.FechaCreacion, 
                   SS_HC_NocNic.UsuarioModificacion, 
                   SS_HC_NocNic.Fechamodificacion, 
                   SS_HC_NocNic.Accion, 
                   SS_HC_NocNic.version 
            FROM   SS_HC_NocNic 
             WHERE                      ( @Descripcion IS NULL OR Upper(SS_HC_NocNic.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_NocNic.Estado = @Estado OR @Estado = 0 ) 
                                    AND ( @IdNoc IS NULL OR SS_HC_NocNic.IdNoc =@IdNoc OR @IdNoc = 0 ) 
                                    AND ( @IdNic IS NULL OR SS_HC_NocNic.IdNic = @IdNic OR @IdNic = 0 ) 
                                    AND ( @IdNC IS NULL OR SS_HC_NocNic.IdNC = @IdNC OR @IdNC = 0 )
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_NocNic 
                              WHERE     ( @Descripcion IS NULL OR Upper(SS_HC_NocNic.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_NocNic.Estado = @Estado OR @Estado = 0 ) 
                                    AND ( @IdNoc IS NULL OR SS_HC_NocNic.IdNoc =@IdNoc OR @IdNoc = 0 ) 
                                    AND ( @IdNic IS NULL OR SS_HC_NocNic.IdNic = @IdNic OR @IdNic = 0 ) 
                                    AND ( @IdNC IS NULL OR SS_HC_NocNic.IdNC = @IdNC OR @IdNC = 0 )) 

            SELECT 
            
                   IdNC, 
                   IdNoc, 
                   IdNic, 
                   descripcion,                    
                   estado, 
                   usuariocreacion, 
                   fechacreacion, 
                   usuariomodificacion, 
                   fechamodificacion, 
                   accion, 
                   version 
            FROM   (SELECT SS_HC_NocNic.IdNC,
                           SS_HC_NocNic.IdNoc,
                           SS_HC_NocNic.IdNic,                           
                           SS_HC_NocNic.Descripcion,                           
                           SS_HC_NocNic.Estado, 
                           SS_HC_NocNic.usuariocreacion, 
                           SS_HC_NocNic.fechacreacion, 
                           SS_HC_NocNic.usuariomodificacion, 
                           SS_HC_NocNic.fechamodificacion, 
                           SS_HC_NocNic.accion, 
                           SS_HC_NocNic.version, 
                           @CONTADOR  
                           AS 
                           Contador, 
                           Row_number() 
                             OVER ( 
                               ORDER BY SS_HC_NocNic.IdNC ASC ) 
                               AS 
                           RowNumber 
                    FROM   SS_HC_NocNic 
                     WHERE              ( @Descripcion IS NULL OR Upper(SS_HC_NocNic.Descripcion) LIKE '%' + Upper(@Descripcion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_NocNic.Estado = @Estado OR @Estado = 0 ) 
                                    AND ( @IdNoc IS NULL OR SS_HC_NocNic.IdNoc =@IdNoc OR @IdNoc = 0 ) 
                                    AND ( @IdNic IS NULL OR SS_HC_NocNic.IdNic = @IdNic OR @IdNic = 0 ) 
                                    AND ( @IdNC IS NULL OR SS_HC_NocNic.IdNC = @IdNC OR @IdNC = 0 )) 
                   AS LISTADO 
            WHERE  ( @Inicio IS NULL 
                     AND @NumeroFilas IS NULL ) 
                    OR rownumber BETWEEN @Inicio AND @NumeroFilas 
        END 
  END 


GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_PacienteDocumentos]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================           
-- Author:    Grace Córdova           
-- Create date: 09/11/2015    
-- =============================================     
CREATE OR ALTER PROCEDURE [SP_SS_HC_PacienteDocumentos]   
@UnidadReplicacion		CHAR(4), 
@IdPaciente				INT, 
@Secuencial				INT, 
@TipoDocumento			CHAR(1), 
@NumeroDocumento		CHAR(25), 
@FechaVigencia			DATETIME, 
@Estado					INT, 
@UsuarioCreacion		CHAR(25), 
@FechaCreacion			DATETIME, 
@UsuarioModificacion	CHAR(25), 
@FechaModificacion		DATETIME, 
@Accion					VARCHAR(200)
AS    
BEGIN      
IF not exists (select * from ss_hc_pacientedocumentos where (IdPaciente = @IdPaciente) AND (TipoDocumento = @TipoDocumento) AND (NumeroDocumento = @NumeroDocumento))
BEGIN
DECLARE @CONTADORES INT
select @CONTADORES= isnull(MAX(Secuencial),0)+1 from ss_hc_pacientedocumentos  WHERE IdPaciente=@IdPaciente
set @Secuencial= @CONTADORES
update ss_hc_pacientedocumentos
set Estado = 1
where IdPaciente = @IdPaciente
INSERT INTO ss_hc_pacientedocumentos
(
UnidadReplicacion,
IdPaciente,
Secuencial,
TipoDocumento,
NumeroDocumento,
FechaVigencia,
Estado,
UsuarioCreacion,
FechaCreacion,
UsuarioModificacion,
FechaModificacion,
Accion
)VALUES(
@UnidadReplicacion,
@IdPaciente,
@Secuencial,
@TipoDocumento,
@NumeroDocumento,
@FechaVigencia,
2,
@UsuarioCreacion,
GETDATE(),
@UsuarioModificacion,
GETDATE(),
'LISTARPAG'
)
SELECT 1
END
ELSE IF (@Accion = 'LISTARPAG')    
BEGIN    
DECLARE @CONTADOR INT    
SET @CONTADOR = (SELECT COUNT(*) FROM ss_hc_pacientedocumentos JOIN personamast ON ( ss_hc_pacientedocumentos.idpaciente = personamast.persona )    
WHERE  ( Upper(ss_hc_pacientedocumentos.accion) LIKE '%' + Upper(@Accion) + '%' OR @Accion IS NULL ) 
      AND ( ss_hc_pacientedocumentos.estado = @Estado OR @Estado IS NULL OR @Estado = 0 ) 
      AND ( IdPaciente = @IdPaciente OR @IdPaciente IS NULL OR @IdPaciente = 0 ) )    
SELECT @CONTADOR    
END    
END    
/*    
EXEC SP_SS_HC_PacienteDocumentos    
null,null,null,null,null,    
null,null,null,null,null,
NULL,'LISTARPAG'
*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_PacienteDocumentosListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================           
-- Author:    Grace Córdova           
-- Create date: 09/11/2015    
-- =============================================    
CREATE OR ALTER PROCEDURE [SP_SS_HC_PacienteDocumentosListar] 
@UnidadReplicacion		CHAR(4), 
@IdPaciente				INT, 
@Secuencial				INT, 
@TipoDocumento			CHAR(1), 
@NumeroDocumento		CHAR(25), 
@FechaVigencia			DATETIME, 
@Estado					INT, 
@UsuarioCreacion		CHAR(25), 
@FechaCreacion			DATETIME, 
@UsuarioModificacion	CHAR(25), 
@FechaModificacion		DATETIME, 
@Accion					VARCHAR(200), 
@INICIO					INT= NULL, 
@NUMEROFILAS			INT = NULL 
AS 
  BEGIN 
      IF ( @Accion = 'LISTAR' ) 
        BEGIN 
            SELECT ss_hc_pacientedocumentos.unidadreplicacion, 
                   idpaciente, 
                   secuencial, 
                   ss_hc_pacientedocumentos.tipodocumento, 
                   ss_hc_pacientedocumentos.numerodocumento, 
                   fechavigencia, 
                   ss_hc_pacientedocumentos.estado, 
                   usuariocreacion, 
                   fechacreacion, 
                   usuariomodificacion, 
                   fechamodificacion, 
                   nombrecompleto AS Accion
            FROM   ss_hc_pacientedocumentos 
                   JOIN personamast ON ( ss_hc_pacientedocumentos.idpaciente = personamast.persona ) 
            WHERE  ( Upper(ss_hc_pacientedocumentos.accion) LIKE '%' + Upper(@Accion) + '%' OR @Accion IS NULL ) 
                   AND ( ss_hc_pacientedocumentos.estado = @Estado OR @Estado IS NULL OR @Estado = 0 ) 
                   AND ( IdPaciente = @IdPaciente OR @IdPaciente IS NULL OR @IdPaciente = 0 )
            ORDER BY secuencial DESC       
        END 
      ELSE IF ( @Accion = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SELECT @CONTADOR = Count(*) 
            FROM   ss_hc_pacientedocumentos 
                   JOIN personamast ON ( ss_hc_pacientedocumentos.idpaciente = personamast.persona ) 
            WHERE  ( Upper(ss_hc_pacientedocumentos.accion) LIKE '%' + Upper(@Accion) + '%' OR @Accion IS NULL ) 
                   AND ( ss_hc_pacientedocumentos.estado = @Estado OR @Estado IS NULL OR @Estado = 0 ) 
                   AND ( IdPaciente = @IdPaciente OR @IdPaciente IS NULL OR @IdPaciente = 0 )

            SELECT unidadreplicacion, 
                   idpaciente, 
                   secuencial, 
                   tipodocumento, 
                   numerodocumento, 
                   fechavigencia, 
                   estado, 
                   usuariocreacion, 
                   fechacreacion, 
                   usuariomodificacion, 
                   fechamodificacion, 
                   nombrecompleto AS Accion 
            FROM   (SELECT ss_hc_pacientedocumentos.unidadreplicacion, 
                           ss_hc_pacientedocumentos.idpaciente, 
                           ss_hc_pacientedocumentos.secuencial, 
                           ss_hc_pacientedocumentos.tipodocumento, 
                           ss_hc_pacientedocumentos.numerodocumento, 
                           ss_hc_pacientedocumentos.fechavigencia, 
                           ss_hc_pacientedocumentos.estado, 
                           ss_hc_pacientedocumentos.usuariocreacion, 
                           ss_hc_pacientedocumentos.fechacreacion, 
                           ss_hc_pacientedocumentos.usuariomodificacion, 
                           ss_hc_pacientedocumentos.fechamodificacion, 
                           nombrecompleto, 
                           @CONTADOR                 AS CONTADOR, 
                           Row_number() OVER( ORDER BY secuencial desc) AS ROWNUMBER 
                    FROM   ss_hc_pacientedocumentos 
                           JOIN personamast ON ( ss_hc_pacientedocumentos.idpaciente = personamast.persona ) 
                    WHERE  ( Upper(ss_hc_pacientedocumentos.accion) LIKE '%' + Upper(@Accion) + '%' OR @Accion IS NULL ) 
                           AND ( ss_hc_pacientedocumentos.estado = @Estado OR @Estado IS NULL OR @Estado = 0 )
                           AND ( IdPaciente = @IdPaciente OR @IdPaciente IS NULL OR @IdPaciente = 0 ))AS LISTADO 
            WHERE  ( @INICIO IS NULL AND @NUMEROFILAS IS NULL ) 
                    OR ( rownumber BETWEEN @INICIO AND @NUMEROFILAS ) 
        END 
  END 
/*    
EXEC SP_SS_HC_PacienteDocumentosListar    
NULL,NULL,NULL,NULL,NULL,    
NULL,NULL,NULL,NULL,NULL,    
NULL,'LISTARPAG',0,10    
*/ 
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_PAE_Diagnostico]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_PAE_Diagnostico]

	@UnidadReplicacion varchar(4) ,   
    @IdEpisodioAtencion	bigint,  
    @IdPaciente int ,   
    @EpisodioClinico	int,
    @IdOrdenAtencion	int,  
    @SecuenciaPAE int,
	@IdNanda int,	
	@IdDominioPAE int ,
	@IdClasePAE int,
	@Observacion varchar(250),
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
            SELECT @SecuenciaPAE = Isnull(Max(SecuenciaPAE), 0) + 1 FROM   dbo.SS_HC_PAE_Diagnostico  
            INSERT INTO SS_HC_PAE_Diagnostico 
                        (
                        
                   UnidadReplicacion,
                   IdEpisodioAtencion,
                   IdPaciente,
                   EpisodioClinico,
                   IdOrdenAtencion,
                   SecuenciaPAE, 
                   IdNanda,                    
                   IdDominioPAE,
                   IdClasePAE,
                   observacion, 
                   estado, 
                   usuariocreacion, 
                   fechacreacion, 
                   usuariomodificacion, 
                   fechamodificacion, 
                   accion, 
                   version
                    ) 
            VALUES      ( 
                        
            @UnidadReplicacion  ,   
            @IdEpisodioAtencion	,  
            @IdPaciente  ,   
            @EpisodioClinico	,
            @IdOrdenAtencion	,  
            @SecuenciaPAE ,
	        @IdNanda ,	
	        @IdDominioPAE  ,
	        @IdClasePAE ,
			@Observacion,
			@Estado ,
			@UsuarioCreacion ,
			@FechaCreacion ,
			@UsuarioModificacion ,
			@FechaModificacion ,
			@Accion ,	
			@Version) 

            SELECT 1 
        END 
      ELSE IF @Accion = 'UPDATE' 
        BEGIN 
            UPDATE SS_HC_PAE_Diagnostico 
            SET    
            
                    UnidadReplicacion=  @UnidadReplicacion,   
                    IdEpisodioAtencion = @IdEpisodioAtencion,  
                    IdPaciente = @IdPaciente,   
                    EpisodioClinico =   @EpisodioClinico,
                    IdOrdenAtencion=  @IdOrdenAtencion,  
                    SecuenciaPAE   = @SecuenciaPAE ,                      
                    IdNanda = @IdNanda,                    
                    IdDominioPAE  = @IdDominioPAE,
                    IdClasePAE = @IdClasePAE,
                    Observacion = @Observacion, 
                    estado = @Estado, 
                    --  usuariocreacion = @UsuarioCreacion, 
                    -- fechacreacion = @FechaCreacion, 
                    usuariomodificacion = @UsuarioModificacion, 
                    fechamodificacion = GETDATE(), 
                    accion = @Accion, 
                    version = @Version 
            WHERE  ( SS_HC_PAE_Diagnostico.SecuenciaPAE = @SecuenciaPAE ) 

            SELECT 1 
        END 
      ELSE IF @Accion = 'DELETE' 
        BEGIN 
            DELETE FROM SS_HC_PAE_Diagnostico 
            WHERE  ( SS_HC_PAE_Diagnostico.SecuenciaPAE = @SecuenciaPAE ) 

            SELECT 1 
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_PAE_Diagnostico 
                             WHERE  
                                        ( @Estado IS NULL OR SS_HC_PAE_Diagnostico.estado = @Estado OR @Estado = 0 ) 
                                    AND ( @IdDominioPAE IS NULL OR SS_HC_PAE_Diagnostico.IdDominioPAE = @IdDominioPAE OR @IdDominioPAE = 0 ) 
                                    AND ( @IdClasePAE IS NULL OR SS_HC_PAE_Diagnostico.IdClasePAE = @IdClasePAE OR @IdClasePAE = 0 )                                       
                                    AND ( @IdNanda IS NULL OR SS_HC_PAE_Diagnostico.IdNanda = @IdNanda OR @IdNanda = 0 )) 

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
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_PAE_DiagnosticoListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_PAE_DiagnosticoListar]
    @UnidadReplicacion varchar(4) ,   
    @IdEpisodioAtencion	bigint,  
    @IdPaciente int ,   
    @EpisodioClinico	int,
    @IdOrdenAtencion	int,  
    @SecuenciaPAE int,
	@IdNanda int,	
	@IdDominioPAE int ,
	@IdClasePAE int,
	@Observacion varchar(250),
	@Estado int,
	@UsuarioCreacion varchar(15),
	@FechaCreacion datetime,
	@UsuarioModificacion varchar(25),
	@FechaModificacion datetime,
	@Accion varchar(25),	
	@Version varchar(25),		
	@INICIO   int= null,  
	@NUMEROFILAS int = null 

AS 
  BEGIN 
      SET nocount ON; 

      DECLARE @CONTADOR INT 

      IF @Accion = 'LISTAR' 
        BEGIN 
           SELECT
              
                      
           N.UnidadReplicacion 
          ,N.IdEpisodioAtencion
          ,N.IdPaciente
          ,N.EpisodioClinico
          ,N.IdOrdenAtencion
          ,N.SecuenciaPAE
          ,N.IdNanda		  
		  ,N.IdDominioPAE
		  ,N.IdClasePAE
		  ,N.Observacion
		  ,N.Estado
		  ,N.UsuarioCreacion
		  ,N.FechaCreacion
		  ,N.UsuarioModificacion
		  ,N.FechaModificacion
		  ,N.Accion
		  ,D.Descripcion AS Version
			FROM SS_HC_PAE_Diagnostico N inner join  SS_HC_DominioPAE D
			on N.IdDominioPAE = D.IdDominioPAE
			INNER JOIN SS_HC_ClasePAE C ON  N.IdClasePAE= C.IdClasePAE
			
			
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_PAE_Diagnostico 
                              WHERE  ( @Observacion IS NULL OR Upper(SS_HC_PAE_Diagnostico.Observacion) LIKE '%' + Upper(@Observacion) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_PAE_Diagnostico.estado = @Estado OR @Estado = 0 )                                     
                                    AND ( @IdDominioPAE IS NULL OR SS_HC_PAE_Diagnostico.IdDominioPAE = @IdDominioPAE OR @IdDominioPAE = 0 ) 
                                    AND ( @IdClasePAE IS NULL OR SS_HC_PAE_Diagnostico.IdClasePAE = @IdClasePAE OR @IdClasePAE = 0 )                                  
                                    AND ( @IdNanda IS NULL OR SS_HC_PAE_Diagnostico.IdNanda = @IdNanda OR @IdNanda = 0 )) 

            SELECT 
            
                   UnidadReplicacion,
                   IdEpisodioAtencion,
                   IdPaciente,
                   EpisodioClinico,
                   IdOrdenAtencion,
                   SecuenciaPAE, 
                   IdNanda,                    
                   IdDominioPAE,
                   IdClasePAE,
                   observacion, 
                   estado, 
                   usuariocreacion, 
                   fechacreacion, 
                   usuariomodificacion, 
                   fechamodificacion, 
                   accion, 
                   version 
            FROM   (SELECT 
                           
                           SS_HC_PAE_Diagnostico.UnidadReplicacion,                          
                           SS_HC_PAE_Diagnostico.IdEpisodioAtencion,
                           SS_HC_PAE_Diagnostico.IdPaciente,
                           SS_HC_PAE_Diagnostico.EpisodioClinico,
                           SS_HC_PAE_Diagnostico.IdOrdenAtencion,
                           SS_HC_PAE_Diagnostico.SecuenciaPAE,
                           SS_HC_PAE_Diagnostico.IdNanda,                           
                           SS_HC_PAE_Diagnostico.IdDominioPAE,
                           SS_HC_PAE_Diagnostico.IdClasePAE, 
                           SS_HC_PAE_Diagnostico.Observacion, 
                           SS_HC_PAE_Diagnostico.estado, 
                           SS_HC_PAE_Diagnostico.usuariocreacion, 
                           SS_HC_PAE_Diagnostico.fechacreacion, 
                           SS_HC_PAE_Diagnostico.usuariomodificacion, 
                           SS_HC_PAE_Diagnostico.fechamodificacion, 
                           SS_HC_PAE_Diagnostico.accion, 
                           SS_HC_PAE_Diagnostico.version, 
                           @CONTADOR       AS 
                           Contador, 
                           Row_number() 
                             OVER ( 
                             ORDER BY SS_HC_PAE_Diagnostico.IdNanda ASC ) AS 
                           RowNumber 
                    FROM   SS_HC_PAE_Diagnostico 
                     WHERE 
                                     ( @Estado IS NULL OR SS_HC_PAE_Diagnostico.estado = @Estado OR @Estado = 0 )                                    
                                    AND ( @IdDominioPAE IS NULL OR SS_HC_PAE_Diagnostico.IdDominioPAE = @IdDominioPAE OR @IdDominioPAE = 0 ) 
                                    AND ( @IdClasePAE IS NULL OR SS_HC_PAE_Diagnostico.IdClasePAE = @IdClasePAE OR @IdClasePAE = 0 )                                   
                                    AND ( @IdNanda IS NULL OR SS_HC_PAE_Diagnostico.IdNanda = @IdNanda OR @IdNanda = 0 )) 
                   AS LISTADO 
            WHERE  ( @Inicio IS NULL 
                     AND @NumeroFilas IS NULL ) 
                    OR rownumber BETWEEN @Inicio AND @NumeroFilas 
        END 
        
        
     ELSE IF @Accion = 'LISTARPLAN' 
        BEGIN 
           SELECT
              
                      
           N.UnidadReplicacion 
          ,N.IdEpisodioAtencion
          ,N.IdPaciente
          ,N.EpisodioClinico
          ,N.IdOrdenAtencion
          ,N.SecuenciaPAE
          ,N.IdNanda		  
		  ,N.IdDominioPAE
		  ,N.IdClasePAE
		  ,(select Descripcion from SS_HC_ClasePAE where IdClasePAE=N.IdClasePAE ) as Observacion
		  ,N.Estado
		  ,(select codigo from SS_HC_NANDA where IdNanda= N.IdNanda) as UsuarioCreacion
		  ,N.FechaCreacion
		  ,N.UsuarioModificacion
		  ,N.FechaModificacion
		  ,ND.Descripcion AS Accion
		  ,D.Descripcion AS Version
			FROM SS_HC_PAE_Diagnostico N inner join  SS_HC_DominioPAE D
			on N.IdDominioPAE = D.IdDominioPAE
			INNER JOIN SS_HC_ClasePAE C ON  N.IdClasePAE= C.IdClasePAE
			INNER JOIN SS_HC_NANDA ND ON N.IdNanda=ND.IdNanda
			WHERE                     ( @IdPaciente IS NULL OR N.IdPaciente = @IdPaciente OR @IdPaciente = 0 )   
                                    AND ( @UnidadReplicacion IS NULL OR Upper(N.UnidadReplicacion) LIKE '%' + Upper(@UnidadReplicacion) + '%' )    
                                    AND ( @EpisodioClinico IS NULL OR N.EpisodioClinico = @EpisodioClinico OR @EpisodioClinico = 0 )  
                                    AND ( @IdEpisodioAtencion IS NULL OR N.IdEpisodioAtencion = @IdEpisodioAtencion OR @IdEpisodioAtencion = 0 )
       
			
        END    
  END 



GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_PAE_FactorRelacionado]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_PAE_FactorRelacionado]
	@UnidadReplicacion varchar(4) ,   
    @IdEpisodioAtencion	bigint,  
    @IdPaciente int ,   
    @EpisodioClinico	int,
    @IdOrdenAtencion	int,  
    @SecuenciaPAE int,
    @IdFactorRelacionado int,	
	@IdNanda int,	
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
            SELECT @IdNanda = Isnull(Max(SecuenciaPAE), 0) + 1 FROM   dbo.SS_HC_PAE_FactorRelacionado  
            INSERT INTO SS_HC_PAE_FactorRelacionado 
                        (
                        
                   UnidadReplicacion,
                   IdEpisodioAtencion,
                   IdPaciente,
                   EpisodioClinico,
                   IdOrdenAtencion,
                   SecuenciaPAE, 
                   IdFactorRelacionado,
                   IdNanda,                
                   estado, 
                   usuariocreacion, 
                   fechacreacion, 
                   usuariomodificacion, 
                   fechamodificacion, 
                   accion, 
                   version
                    ) 
            VALUES      ( 
                        
            @UnidadReplicacion  ,   
            @IdEpisodioAtencion	,  
            @IdPaciente  ,   
            @EpisodioClinico	,
            @IdOrdenAtencion	,  
            @SecuenciaPAE ,
            @IdFactorRelacionado,
	        @IdNanda ,		        
			@Estado ,
			@UsuarioCreacion ,
			@FechaCreacion ,
			@UsuarioModificacion ,
			@FechaModificacion ,
			@Accion ,	
			@Version) 

            SELECT 1 
        END 
      ELSE IF @Accion = 'UPDATE' 
        BEGIN 
            UPDATE SS_HC_PAE_FactorRelacionado 
            SET    
            
                    UnidadReplicacion=  @UnidadReplicacion,   
                    IdEpisodioAtencion = @IdEpisodioAtencion,  
                    IdPaciente = @IdPaciente,   
                    EpisodioClinico =   @EpisodioClinico,
                    IdOrdenAtencion=  @IdOrdenAtencion,  
                    SecuenciaPAE   = @SecuenciaPAE , 
                    IdFactorRelacionado = @IdFactorRelacionado,                         
                    IdNanda = @IdNanda,            
                    estado = @Estado, 
                    --  usuariocreacion = @UsuarioCreacion, 
                    -- fechacreacion = @FechaCreacion, 
                    usuariomodificacion = @UsuarioModificacion, 
                    fechamodificacion = GETDATE(), 
                    accion = @Accion, 
                    version = @Version 
            WHERE  ( SS_HC_PAE_FactorRelacionado.SecuenciaPAE = @SecuenciaPAE ) 

            SELECT 1 
        END 
      ELSE IF @Accion = 'DELETE' 
        BEGIN 
            DELETE FROM SS_HC_PAE_FactorRelacionado 
            WHERE  ( SS_HC_PAE_FactorRelacionado.SecuenciaPAE = @SecuenciaPAE ) 

            SELECT 1 
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_PAE_FactorRelacionado 
                             WHERE  
                                        ( @Estado IS NULL OR SS_HC_PAE_FactorRelacionado.estado = @Estado OR @Estado = 0 )   
                                    AND ( @SecuenciaPAE IS NULL OR SS_HC_PAE_FactorRelacionado.SecuenciaPAE = @SecuenciaPAE OR @SecuenciaPAE = 0 )                                    
                                    AND ( @IdFactorRelacionado IS NULL OR SS_HC_PAE_FactorRelacionado.IdFactorRelacionado = @IdFactorRelacionado OR @IdFactorRelacionado = 0 )                                       
                                    AND ( @IdNanda IS NULL OR SS_HC_PAE_FactorRelacionado.IdNanda = @IdNanda OR @IdNanda = 0 )) 

            SELECT @CONTADOR; 
        END 
  END 

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Partograma_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_Partograma_FE]
	@UnidadReplicacion char(4),
	@IdEpisodioAtencion bigint,
	@IdPaciente int,
	@EpisodioClinico int,	
	@Fecha datetime  ,
	@FrecCardiacaFetal int  ,
	@Membranas char(1) ,
	@Liquido char(1) ,
	@DilatacionCuelloUt int ,
	@DescensoCefalico int ,
	@TactosVaginales int ,	
	@DuracionContracciones int ,
	@ContracTEENmin int ,
	@Oxitocina int ,	
	@FVPulso int ,
	@FVPresionArterial int ,
	@FVPresionArterialD int ,
	@FVTemperatura decimal(9,2) ,	
	@Proteina decimal(9,2) ,
	@Acetona decimal(9,2) ,
	@Volumen int ,	
	@UsuarioCreacion varchar(25) ,
	@FechaCreacion datetime ,
	@UsuarioModificacion varchar(25) ,
	@FechaModificacion datetime ,
	@Accion varchar(25) ,
	@Version varchar(25) 	
	AS
	BEGIN
	
	if(@Accion='NUEVO')
	BEGIN
	INSERT INTO SS_HC_Partograma_FE (UnidadReplicacion,IdEpisodioAtencion,IdPaciente,EpisodioClinico,Fecha,FrecCardiacaFetal,Membranas,
		Liquido,DilatacionCuelloUt,DescensoCefalico,TactosVaginales,DuracionContracciones,ContracTEENmin,Oxitocina,FVPulso,FVPresionArterial,
		FVPresionArterialD,FVTemperatura,Proteina,Acetona,Volumen,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,Accion,Version)
		VALUES(@UnidadReplicacion,@IdEpisodioAtencion,@IdPaciente,@EpisodioClinico,@Fecha,@FrecCardiacaFetal,@Membranas,
		@Liquido,@DilatacionCuelloUt,@DescensoCefalico,@TactosVaginales,@DuracionContracciones,@ContracTEENmin,@Oxitocina,@FVPulso,@FVPresionArterial,
		@FVPresionArterialD,@FVTemperatura,@Proteina,@Acetona,@Volumen,@UsuarioCreacion,@FechaCreacion,@UsuarioModificacion,@FechaModificacion,@Accion,@Version)
	select @EpisodioClinico
	END
	
	if(@Accion='UPDATE')
	BEGIN
		UPDATE SS_HC_Partograma_FE
		SET Fecha=@Fecha,
			FrecCardiacaFetal=@FrecCardiacaFetal,
			Membranas=@Membranas,
			Liquido=@Liquido,
			DilatacionCuelloUt=@DilatacionCuelloUt,
			DescensoCefalico=@DescensoCefalico,
			TactosVaginales=@TactosVaginales,
			DuracionContracciones=@DuracionContracciones,
			ContracTEENmin=@ContracTEENmin,
			Oxitocina=@Oxitocina,
			FVPulso=@FVPulso,
			FVPresionArterial=@FVPresionArterial,
			FVPresionArterialD=@FVPresionArterialD,
			FVTemperatura=@FVTemperatura,
			Proteina=@Proteina,
			Acetona=@Acetona,
			Volumen=@Volumen,
			UsuarioModificacion=@UsuarioModificacion,
			FechaModificacion=@FechaModificacion,
			Accion=@Accion,
			Version=@Version
			
			WHERE UnidadReplicacion=@UnidadReplicacion AND IdEpisodioAtencion=@IdEpisodioAtencion AND
			IdPaciente=@IdPaciente AND EpisodioClinico=@EpisodioClinico
		select @EpisodioClinico
	END 
	
	
	END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Partograma_FE_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_Partograma_FE_Listar]
	@UnidadReplicacion char(4),
	@IdEpisodioAtencion bigint,
	@IdPaciente int,
	@EpisodioClinico int,	
	@Fecha datetime  ,
	@FrecCardiacaFetal int  ,
	@Membranas char(1) ,
	@Liquido char(1) ,
	@DilatacionCuelloUt int ,
	@DescensoCefalico int ,
	@TactosVaginales int ,	
	@DuracionContracciones int ,
	@ContracTEENmin int ,
	@Oxitocina int ,	
	@FVPulso int ,
	@FVPresionArterial int ,
	@FVPresionArterialD int ,
	@FVTemperatura decimal(9,2) ,	
	@Proteina decimal(9,2) ,
	@Acetona decimal(9,2) ,
	@Volumen int ,	
	@UsuarioCreacion varchar(25) ,
	@FechaCreacion datetime ,
	@UsuarioModificacion varchar(25) ,
	@FechaModificacion datetime ,
	@Accion varchar(25) ,
	@Version varchar(25) 	
	AS
	BEGIN
	
	if(@Accion='LISTAR')
	BEGIN
	SELECT * FROM SS_HC_Partograma_FE WHERE UnidadReplicacion=@UnidadReplicacion AND IdEpisodioAtencion=@IdEpisodioAtencion AND
			IdPaciente=@IdPaciente AND EpisodioClinico=@EpisodioClinico
	END
	
	if(@Accion='LISTARGRAF')
	BEGIN
	SELECT * FROM SS_HC_Partograma_FE WHERE UnidadReplicacion=@UnidadReplicacion AND /*IdEpisodioAtencion=@IdEpisodioAtencion AND*/
			IdPaciente=@IdPaciente AND EpisodioClinico=@EpisodioClinico
	END
	if(@Accion='LISTARCONT')
	BEGIN
	SELECT * FROM SS_HC_Partograma_FE WHERE UnidadReplicacion=@UnidadReplicacion AND /*IdEpisodioAtencion=@IdEpisodioAtencion AND*/
			IdPaciente=@IdPaciente AND EpisodioClinico=@EpisodioClinico AND DuracionContracciones=@DuracionContracciones
	END
	
	
	
	
	END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_PartogramaDetalle_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_PartogramaDetalle_FE]
	@UnidadReplicacion char(4),
	@IdEpisodioAtencion bigint,
	@IdPaciente int,
	@EpisodioClinico int,
	
	@Secuencia int,
	@Medicamento varchar(300) ,
	@Hora datetime ,	
		
	@UsuarioCreacion varchar(25) ,
	@FechaCreacion datetime ,
	@UsuarioModificacion varchar(25) ,
	@FechaModificacion datetime,
	@Accion varchar(25) ,
	@Version varchar(25) 
	
	AS
	BEGIN
	
	IF(@Accion='NUEVO')
	BEGIN
		DECLARE @Secuenciamax int
	
		set @Secuenciamax = (SELECT (ISNULL(MAX(Secuencia),0)+1) FROM SS_HC_PartogramaDetalle_FE WHERE
		UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
		AND EpisodioClinico=@EpisodioClinico)
		
		INSERT INTO SS_HC_PartogramaDetalle_FE(UnidadReplicacion,IdEpisodioAtencion,IdPaciente,EpisodioClinico,Secuencia,Medicamento,Hora,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,Accion,Version)
		VALUES (@UnidadReplicacion,@IdEpisodioAtencion,@IdPaciente,@EpisodioClinico,@Secuenciamax,@Medicamento,@Hora,@UsuarioCreacion,@FechaCreacion,@UsuarioModificacion,@FechaModificacion,@Accion,@Version)
		
		select @Secuenciamax
	END
	IF(@Accion='UPDATE')
	BEGIN
		UPDATE SS_HC_PartogramaDetalle_FE
		
		SET Medicamento = @Medicamento,
			Hora = @Hora,
			UsuarioModificacion = @UsuarioModificacion,
			FechaModificacion = @FechaModificacion
		WHERE UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
			  AND EpisodioClinico=@EpisodioClinico AND Secuencia=@Secuencia
			  
		SELECT @Secuencia
	END
	
	IF(@Accion = 'DELETE')
	BEGIN

		DELETE FROM SS_HC_PartogramaDetalle_FE
		WHERE UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
			  AND EpisodioClinico=@EpisodioClinico AND Secuencia=@Secuencia
		
		SELECT @Secuencia
	END
	
	END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_PartogramaDetalleListar_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[SP_SS_HC_PartogramaDetalleListar_FE]
	@UnidadReplicacion char(4),
	@IdEpisodioAtencion bigint,
	@IdPaciente int,
	@EpisodioClinico int,
	
	@Secuencia int,
	@Medicamento varchar(300) ,
	@Hora datetime ,	
		
	@UsuarioCreacion varchar(25) ,
	@FechaCreacion datetime ,
	@UsuarioModificacion varchar(25) ,
	@FechaModificacion datetime,
	@Accion varchar(25) ,
	@Version varchar(25) 
	
	AS
	BEGIN
	
	IF(@Accion='LISTAR')
	BEGIN
		
		select * from SS_HC_PartogramaDetalle_FE WHERE UnidadReplicacion= @UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion AND IdPaciente=@IdPaciente
			  AND EpisodioClinico=@EpisodioClinico
	END
	
	
	END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_Procedimiento]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_Procedimiento]
(
	@IdProcedimiento int,
	@IdProcedimientoPadre int,
	@Descripcion varchar(200),
	@DescripcionExtranjera varchar(200),
	@Nivel int,
	@UltimoNivelFlag char,
	@CadenaRecursiva varchar(150),
	@Orden int,
	@Icono varchar(100),
	@NombreInterfaz varchar(100),
	@CodigoProcedimiento varchar(15),
	@UsuarioModficacion varchar(25),
	@FechaModificacion datetime,
	@Accion varchar(25),
	@UsuarioCreacion varchar(25),
	@FechaCreacion datetime,
	@Version varchar(25),
	@Estado int
)
AS
BEGIN
SET NOCOUNT ON;  
BEGIN  TRANSACTION
 DECLARE @CONTADOR INT 
	IF(@Accion='INSERT')
	BEGIN
  	SELECT @CONTADOR= isnull(MAX(IdProcedimiento),0)+1 from SS_HC_Procedimiento 
		SET @IdProcedimiento = @CONTADOR
		INSERT INTO SS_HC_Procedimiento
		( 
			IdProcedimiento,
			IdProcedimientoPadre,
			Descripcion,
			DescripcionExtranjera,
			Nivel,
			UltimoNivelFlag,
			CadenaRecursiva,
			Orden,
			Icono,
			NombreInterfaz,
			CodigoProcedimiento, 
			UsuarioModificacion,
			FechaModificacion,
			Accion,
			UsuarioCreacion,
			FechaCreacion,
			Version,
			Estado
		)
		VALUES
		(
			@IdProcedimiento,
			@IdProcedimientoPadre,
			@Descripcion,
			@DescripcionExtranjera,
			@Nivel,
			@UltimoNivelFlag,
			@CadenaRecursiva,
			@Orden,
			@Icono,
			@NombreInterfaz,
			@CodigoProcedimiento, 
			@UsuarioModficacion,
			GETDATE(),
			@Accion,
			@UsuarioCreacion,
			GETDATE(),
			@Version,
			@Estado
			)
		select 1
		END
		ELSE
		IF @ACCION='UPDATE'
		BEGIN
		UPDATE SS_HC_Procedimiento SET IdProcedimientoPadre=@IdProcedimientoPadre,Descripcion=@Descripcion, DescripcionExtranjera=@DescripcionExtranjera,
		Nivel=@Nivel,UltimoNivelFlag=@UltimoNivelFlag,CadenaRecursiva=@CadenaRecursiva,Orden=@Orden,
		Icono=@Icono,NombreInterfaz=@NombreInterfaz,CodigoProcedimiento=@CodigoProcedimiento,
		FechaModificacion=GETDATE(),Accion = @Accion,Version=@Version,Estado=@Estado  
		WHERE IdProcedimiento = @IdProcedimiento 
		select 1   
   		END   
		ELSE
		IF(@ACCION = 'DELETE')
		BEGIN
		DELETE SS_HC_Procedimiento
		WHERE 
		(IdProcedimiento = @IdProcedimiento)
		select 1
	end
	else
	if(@ACCION = 'CONTARLISTARPAG')
	begin	 	
		SET @CONTADOR=(SELECT COUNT(IdProcedimiento) FROM SS_HC_Procedimiento
	 					WHERE 
					(@IdProcedimiento is null OR (IdProcedimiento = @IdProcedimiento) or @IdProcedimiento =0)
					and (@IdProcedimientoPadre is null OR IdProcedimientoPadre = @IdProcedimientoPadre)					
					and (@Estado is null OR Estado = @Estado)
					and (@CodigoProcedimiento is null  OR @CodigoProcedimiento =''  OR  upper(CodigoProcedimiento) like '%'+upper(@CodigoProcedimiento)+'%')
					)
		select @CONTADOR
	end
commit	
	
END	
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_ProcedimientoEjecucion]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_ProcedimientoEjecucion]
(
	@UnidadReplicacion	char(4) ,
	@IdEpisodioAtencion	bigint ,
	@IdPaciente	int ,
	@EpisodioClinico	int ,
	@Secuencia	int ,
	
	@UnidadReplicacionSolicitado	char(4) ,
	@IdEpisodioAtencionSolicitado	bigint ,
	@IdPacienteSolicitado	int ,
	@EpisodioClinicoSolicitado	int ,
	@SecuenciaSolicitado	int ,
	
	@IdProcedimiento	int ,
	@CodigoComponente	varchar(25) ,
	@FechaSolicitud	datetime ,
	@FechaProcedimiento	datetime ,
	@FechaInicio	datetime ,
	
	@FechaFin	datetime ,
	@FechaInforme	datetime ,
	@IndicadorPreparacion	int ,
	@IndicadorAutorizacion	int ,
	@Medico	int ,
	
	@Observacion	varchar(250) ,
	@TipoAlta	int ,
	@FechaAlta	datetime ,
	@IdMedicoAutoriza	int ,
	@ObservacionAlta	varchar(250) ,
	
	@UsuarioCreacion	varchar(25) ,
	@FechaCreacion	datetime ,
	@UsuarioModificacion	varchar(25) ,
	@FechaModificacion	datetime ,	
	@TipoCodigo	char(1),
	
	@ACCION	varchar(30) 
			
)

AS
BEGIN 
SET NOCOUNT ON;
BEGIN  TRANSACTION

	DECLARE @CONTADOR INT
	declare @IdAgenteAux int;
	declare @IdEpisodioAtencionId INT;
	declare @EpisodioClinicoID as INTEGER, 
		@ExisteCodigo as VARCHAR(10),
		@SecuenciaID as Integer
		
	
	if(@ACCION = 'INSERT')
	begin				
		/***OBTENER EL TIPO DE CÓDIGO QUE CORRESPONDA ***/
		select @TipoCodigo= TipoCodigo from SS_HC_ExamenSolicitado
		where UnidadReplicacion = @UnidadReplicacionSolicitado
		and IdPaciente = @IdPacienteSolicitado
		and EpisodioClinico=@EpisodioClinicoSolicitado
		and IdEpisodioAtencion=@IdEpisodioAtencionSolicitado
		and Secuencia=@SecuenciaSolicitado
		/*****************************************/
		
		select @IdEpisodioAtencionId = ISNULL(max(Secuencia),0)+1 
			  from dbo.SS_HC_ProcedimientoEjecucion 
			  
			  where UnidadReplicacion = @UnidadReplicacion 
			  and EpisodioClinico =@EpisodioClinico
			  and IdPaciente = @IdPaciente 
			  and IdEpisodioAtencion = @IdEpisodioAtencion 
			  
				
		set @Secuencia = @IdEpisodioAtencionId
		
		insert into SS_HC_ProcedimientoEjecucion
		(
			UnidadReplicacion
			,IdEpisodioAtencion
			,IdPaciente
			,EpisodioClinico
			,Secuencia
			,UnidadReplicacionSolicitado
			,IdEpisodioAtencionSolicitado
			,IdPacienteSolicitado
			,EpisodioClinicoSolicitado
			,SecuenciaSolicitado
			,IdProcedimiento
			,CodigoComponente
			,FechaSolicitud
			,FechaProcedimiento
			,FechaInicio
			,FechaFin
			,FechaInforme
			,IndicadorPreparacion
			,IndicadorAutorizacion
			,Medico
			,Observacion
			,TipoAlta
			,FechaAlta
			,IdMedicoAutoriza
			,ObservacionAlta
			,UsuarioCreacion
			,FechaCreacion
			,UsuarioModificacion
			,FechaModificacion
			,TipoCodigo

		)
		values(
			@UnidadReplicacion
		,	@IdEpisodioAtencion
		,	@IdPaciente
		,	@EpisodioClinico
		,	@Secuencia
		,	@UnidadReplicacionSolicitado
		,	@IdEpisodioAtencionSolicitado
		,	@IdPacienteSolicitado
		,	@EpisodioClinicoSolicitado
		,	@SecuenciaSolicitado
		,	@IdProcedimiento
		,	@CodigoComponente
		,	@FechaSolicitud
		,	@FechaProcedimiento
		,	@FechaInicio
		,	@FechaFin
		,	@FechaInforme
		,	@IndicadorPreparacion
		,	@IndicadorAutorizacion
		,	@Medico
		,	@Observacion
		,	@TipoAlta
		,	@FechaAlta
		,	@IdMedicoAutoriza
		,	@ObservacionAlta
		,	@UsuarioCreacion
		,	GETDATE()
		,	@UsuarioModificacion
		,	GETDATE()
		,	@TipoCodigo
		)

		select @IdEpisodioAtencionId
	end	
	else
	if(@ACCION = 'UPDATE')
	begin			
			set @IdEpisodioAtencionId = convert(INTEGER,@IdEpisodioAtencion)
			
		update SS_HC_ProcedimientoEjecucion
		set 						
			UnidadReplicacionSolicitado	=	@UnidadReplicacionSolicitado
			,IdEpisodioAtencionSolicitado	=	@IdEpisodioAtencionSolicitado
			,IdPacienteSolicitado	=	@IdPacienteSolicitado
			,EpisodioClinicoSolicitado	=	@EpisodioClinicoSolicitado
			,SecuenciaSolicitado	=	@SecuenciaSolicitado
			,IdProcedimiento	=	@IdProcedimiento
			,CodigoComponente	=	@CodigoComponente
			,FechaSolicitud	=	@FechaSolicitud
			,FechaProcedimiento	=	@FechaProcedimiento
			,FechaInicio	=	@FechaInicio
			,FechaFin	=	@FechaFin
			,FechaInforme	=	@FechaInforme
			,IndicadorPreparacion	=	@IndicadorPreparacion
			,IndicadorAutorizacion	=	@IndicadorAutorizacion
			,Medico	=	@Medico
			,Observacion	=	@Observacion
			,TipoAlta	=	@TipoAlta
			,FechaAlta	=	@FechaAlta
			,IdMedicoAutoriza	=	@IdMedicoAutoriza
			,ObservacionAlta	=	@ObservacionAlta
			--,UsuarioCreacion	=	@UsuarioCreacion
			,FechaCreacion	=	GETDATE()
			,UsuarioModificacion	=	@UsuarioModificacion
			,FechaModificacion	=	@FechaModificacion
	
		
		WHERE 
		(UnidadReplicacion= @UnidadReplicacion)		
		and (IdEpisodioAtencion= @IdEpisodioAtencion)		
		and ( IdPaciente= @IdPaciente)		
		and ( EpisodioClinico= @EpisodioClinico)		
		and ( Secuencia= @Secuencia)		
						
		select @Secuencia
				
	end	
	else
	if(@ACCION = 'DELETE')
	begin			
		delete SS_HC_ProcedimientoEjecucion
		WHERE 
		(UnidadReplicacion= @UnidadReplicacion)		
		and (IdEpisodioAtencion= @IdEpisodioAtencion)		
		and ( IdPaciente= @IdPaciente)		
		and ( EpisodioClinico= @EpisodioClinico)		
		and ( Secuencia= @Secuencia)
		
		select 1
	end	
	
	
commit		
END	
/*
exec SP_SS_HC_ProcedimientoEjecucion
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	
	NULL,
	NULL,
	NULL,
	NULL,	
	
	'UPDATE'
	
*/






GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_ProcedimientoEjecucionListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_SS_HC_ProcedimientoEjecucionListar]
(
	@UnidadReplicacion	char(4) ,
	@IdEpisodioAtencion	bigint ,
	@IdPaciente	int ,
	@EpisodioClinico	int ,
	@Secuencia	int ,	
	@UnidadReplicacionSolicitado	char(4) ,
	@IdEpisodioAtencionSolicitado	bigint ,
	@IdPacienteSolicitado	int ,
	@EpisodioClinicoSolicitado	int ,
	@SecuenciaSolicitado	int ,	
	@IdProcedimiento	int ,
	@CodigoComponente	varchar(25) ,
	@FechaSolicitud	datetime ,
	@FechaProcedimiento	datetime ,
	@FechaInicio	datetime ,	
	@FechaFin	datetime ,
	@FechaInforme	datetime ,
	@IndicadorPreparacion	int ,
	@IndicadorAutorizacion	int ,
	@Medico	int ,	
	@Observacion	varchar(250) ,
	@TipoAlta	int ,
	@FechaAlta	datetime ,
	@IdMedicoAutoriza	int ,
	@ObservacionAlta	varchar(250) ,	
	@UsuarioCreacion	varchar(25) ,
	@FechaCreacion	datetime ,
	@UsuarioModificacion	varchar(25) ,
	@FechaModificacion	datetime ,
	@TipoCodigo	char(1),	
	@inicio	int,
	@final	int,
	@ACCION	varchar(30) 			
)

AS
BEGIN 
SET NOCOUNT ON;

	DECLARE @CONTADOR INT
	declare @IdAgenteAux int;
	 if(@ACCION = 'LISTAR')
			begin		 
					select
					UnidadReplicacion
				  ,IdEpisodioAtencion
				  ,IdPaciente
				  ,EpisodioClinico
				  ,Secuencia
				  ,UnidadReplicacionSolicitado
				  ,IdEpisodioAtencionSolicitado
				  ,IdPacienteSolicitado
				  ,EpisodioClinicoSolicitado
				  ,SecuenciaSolicitado
				  ,IdProcedimiento
				  ,CodigoComponente
				  ,FechaSolicitud
				  ,FechaProcedimiento
				  ,FechaInicio
				  ,FechaFin
				  ,FechaInforme
				  ,IndicadorPreparacion
				  ,IndicadorAutorizacion
				  ,Medico
				  ,Observacion
				  ,TipoAlta
				  ,FechaAlta
				  ,IdMedicoAutoriza
				  ,(case TipoCodigo when 'S' then NombreExamenX_SEGUS   --PARA LA DESCRIPCIÓN DEL EXAMEN(CPT o SEGUS)
				  else NombreExamenX_CPT end  ) as ObservacionAlta
				  ,UsuarioCreacion
				  ,FechaCreacion
				  ,UsuarioModificacion
				  ,FechaModificacion
				  ,ACCION		
				  ,TipoCodigo
					from		
					(				
						select ProceEjecucion.* ,
						SS_GE_ProcedimientoMedico.Nombre as NombreExamenX_CPT,
						CM_CO_Componente.Nombre as NombreExamenX_SEGUS
						from SS_HC_ProcedimientoEjecucion as ProceEjecucion
						left join SS_HC_ExamenSolicitado ExamenSol
						on (ExamenSol.UnidadReplicacion = ProceEjecucion.UnidadReplicacionSolicitado
							and ExamenSol.IdPaciente = ProceEjecucion.IdPacienteSolicitado
							and ExamenSol.EpisodioClinico = ProceEjecucion.EpisodioClinicoSolicitado
							and ExamenSol.IdEpisodioAtencion = ProceEjecucion.IdEpisodioAtencionSolicitado
							and ExamenSol.Secuencia = ProceEjecucion.SecuenciaSolicitado
						)						
						left join SS_GE_ProcedimientoMedico 
						on(SS_GE_ProcedimientoMedico.IdProcedimiento = ExamenSol.IdProcedimiento
						and ExamenSol.TipoCodigo = 'C')
						left join CM_CO_Componente 
						on(CM_CO_Componente.CodigoComponente = ExamenSol.CodigoComponente
						and ExamenSol.TipoCodigo = 'S')
						
						where
						(@UnidadReplicacion is null or ProceEjecucion.UnidadReplicacion= @UnidadReplicacion)		
						and (@IdEpisodioAtencion is null  or ProceEjecucion.IdEpisodioAtencion= @IdEpisodioAtencion)		
						and (@IdPaciente is null or  ProceEjecucion.IdPaciente= @IdPaciente)		
						and (@EpisodioClinico is null or  ProceEjecucion.EpisodioClinico= @EpisodioClinico)	
						and (@Secuencia is null or  ProceEjecucion.Secuencia= @Secuencia or  @Secuencia = 0)	
						and (@IdProcedimiento is null or  ProceEjecucion.IdProcedimiento= @IdProcedimiento or  @IdProcedimiento= 0)	
					)AS ProcedimientoEjecucion
						
			
			end	
	ELSE
	if(@ACCION = 'LISTARINFORMES')
		begin		 
					select
					UnidadReplicacion
				  ,IdEpisodioAtencion
				  ,IdPaciente
				  ,EpisodioClinico
				  ,Secuencia
				  ,UnidadReplicacionSolicitado
				  ,IdEpisodioAtencionSolicitado
				  ,IdPacienteSolicitado
				  ,EpisodioClinicoSolicitado
				  ,SecuenciaSolicitado
				  ,IdProcedimiento
				  ,CodigoComponente
				  ,FechaSolicitud
				  ,FechaProcedimiento
				  ,FechaInicio
				  ,FechaFin
				  ,FechaInforme
				  ,IndicadorPreparacion
				  ,IndicadorAutorizacion
				  ,Medico
				  ,Observacion
				  ,TipoAlta
				  ,FechaAlta
				  ,IdMedicoAutoriza
				   , ObservacionAlta
				  ,UsuarioCreacion
				  ,FechaCreacion
				  ,UsuarioModificacion
				  ,FechaModificacion
				  ,ACCION		 		
				  ,TipoCodigo
					from	SS_HC_ProcedimientoEjecucion
					Where  (@UnidadReplicacion is null or UnidadReplicacion= @UnidadReplicacion)		
						and (@IdEpisodioAtencion is null  or IdEpisodioAtencion= @IdEpisodioAtencion)		
						and (@IdPaciente is null or  IdPaciente= @IdPaciente)		
						and (@EpisodioClinico is null or  EpisodioClinico= @EpisodioClinico)	
						--and (@Secuencia is null or  Secuencia= @Secuencia or  @Secuencia = 0)	
						--and (@IdProcedimiento is null or  ProceEjecucion.IdProcedimiento= @IdProcedimiento or  @IdProcedimiento= 0)	
				
		end	
	else
	if(@ACCION = 'LISTARPORID')
	begin		 

		select * from SS_HC_ProcedimientoEjecucion
		where
		(UnidadReplicacion= @UnidadReplicacion)		
		and (IdEpisodioAtencion= @IdEpisodioAtencion)		
		and ( IdPaciente= @IdPaciente)		
		and ( EpisodioClinico= @EpisodioClinico)	
		and ( Secuencia= @Secuencia)			
	end	
	else
	if(@ACCION = 'LISTARPORORIGEN')
	begin		 

		select * from SS_HC_ProcedimientoEjecucion
		where		
		( @UnidadReplicacion is null or UnidadReplicacion= @UnidadReplicacion)			
		--and ( @EpisodioClinico is null or EpisodioClinico= @EpisodioClinico)	
		and ( IdPaciente= @IdPaciente)					
		----------------------------
		and ( UnidadReplicacionSolicitado = @UnidadReplicacionSolicitado)
		and ( EpisodioClinicoSolicitado = @EpisodioClinicoSolicitado)
		and ( IdEpisodioAtencionSolicitado = @IdEpisodioAtencionSolicitado)
		and ( SecuenciaSolicitado = @SecuenciaSolicitado)
	end			
	
END	
/*
exec [SP_SS_HC_ProcedimientoEjecucionListar]

	'CEG',
	2,
	1265,
	4,
	NULL,
	
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	
	NULL,
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
	10,
	'LISTAR'
	
*/
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_ProcedimientoInforme]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_ProcedimientoInforme]
(
	@UnidadReplicacion	char(4) ,
	@IdEpisodioAtencion	bigint ,
	@IdPaciente	int ,
	@EpisodioClinico	int ,
	@Secuencia	int ,
	
	@SecuenciaInforme	int ,
	@Nombre	varchar(150) ,
	@RutaInforme	varchar(250) ,
	@Estado	int ,
	@UsuarioCreacion	varchar(25) ,
	
	@FechaCreacion	datetime ,
	@UsuarioModificacion	varchar(25) ,
	@FechaModificacion	datetime ,	
		
	@ACCION	varchar(30) 
			
			
)

AS
BEGIN 
SET NOCOUNT ON;
BEGIN  TRANSACTION

	DECLARE @CONTADOR INT
	declare @IdAgenteAux int;
	declare @IdSecuenciaAux INT;
	declare @EpisodioClinicoID as INTEGER, 
		@ExisteCodigo as VARCHAR(10),
		@SecuenciaID as Integer
	
	if(@ACCION = 'INSERT')
	begin				
		select @IdSecuenciaAux = ISNULL(max(SecuenciaInforme),0)+1 
			  from dbo.SS_HC_ProcedimientoInforme 
			  
			  where UnidadReplicacion = @UnidadReplicacion 
			  and EpisodioClinico =@EpisodioClinico
			  and IdPaciente = @IdPaciente 
			  and IdEpisodioAtencion = @IdEpisodioAtencion 
			  and Secuencia = @Secuencia
			  
				
		set @SecuenciaInforme = @IdSecuenciaAux
		
		insert into SS_HC_ProcedimientoInforme
		(
			UnidadReplicacion
			,IdEpisodioAtencion
			,IdPaciente
			,EpisodioClinico
			,Secuencia
			,SecuenciaInforme
			,Nombre
			,RutaInforme
			,Estado
			,UsuarioCreacion
			,FechaCreacion
			,UsuarioModificacion
			,FechaModificacion			

		)
		values(
				@UnidadReplicacion
			,	@IdEpisodioAtencion
			,	@IdPaciente
			,	@EpisodioClinico
			,	@Secuencia
			,	@SecuenciaInforme
			,	@Nombre
			,	@RutaInforme
			,	@Estado
			,	@UsuarioCreacion
			,	GETDATE()
			,	@UsuarioModificacion
			,	GETDATE()
		)

		select @SecuenciaInforme
	end	
	else
	if(@ACCION = 'UPDATE')
	begin						
			
		update SS_HC_ProcedimientoInforme
		set 																								
			Nombre	=	@Nombre
			,RutaInforme	=	@RutaInforme
			,Estado	=	@Estado
			--,UsuarioCreacion	=	@UsuarioCreacion
			--,FechaCreacion	=	@FechaCreacion
			,UsuarioModificacion	=	@UsuarioModificacion
			,FechaModificacion	=	getdate()			
		WHERE 
		(UnidadReplicacion= @UnidadReplicacion)		
		and (IdEpisodioAtencion= @IdEpisodioAtencion)		
		and ( IdPaciente= @IdPaciente)		
		and ( EpisodioClinico= @EpisodioClinico)		
		and ( Secuencia= @Secuencia)		
		and ( SecuenciaInforme= @SecuenciaInforme)		
						
		select @Secuencia
				
	end	
	else
	if(@ACCION = 'DELETE')
	begin			
		delete SS_HC_ProcedimientoInforme
		WHERE 
		(UnidadReplicacion= @UnidadReplicacion)		
		and (IdEpisodioAtencion= @IdEpisodioAtencion)		
		and ( IdPaciente= @IdPaciente)		
		and ( EpisodioClinico= @EpisodioClinico)		
		and ( Secuencia= @Secuencia)		
		and ( SecuenciaInforme= @SecuenciaInforme)	
		
		select 1
	end	
	
	
commit		
END	
/*
exec SP_SS_HC_ProcedimientoEjecucion
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	
	NULL,
	NULL,
	NULL,
	NULL,	
	
	'UPDATE'
	
*/

GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_ProcedimientoInformeListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_SS_HC_ProcedimientoInformeListar]
(
	@UnidadReplicacion	char(4) ,
	@IdEpisodioAtencion	bigint ,
	@IdPaciente	int ,
	@EpisodioClinico	int ,
	@Secuencia	int ,
	
	@SecuenciaInforme	int ,
	@Nombre	varchar(150) ,
	@RutaInforme	varchar(250) ,
	@Estado	int ,
	@UsuarioCreacion	varchar(25) ,
	
	@FechaCreacion	datetime ,
	@UsuarioModificacion	varchar(25) ,
	@FechaModificacion	datetime ,	
	
	@inicio	int,
	@final	int,
	@ACCION	varchar(30) 
			
)

AS
BEGIN 
SET NOCOUNT ON;

	DECLARE @CONTADOR INT
	declare @IdAgenteAux int;
	if(@ACCION = 'LISTAR')
	begin		 

		select * from SS_HC_ProcedimientoInforme
		where
		(@UnidadReplicacion is null or UnidadReplicacion= @UnidadReplicacion)		
		and (@IdEpisodioAtencion is null  or IdEpisodioAtencion= @IdEpisodioAtencion)		
		and (@IdPaciente is null or  IdPaciente= @IdPaciente)		
		and (@EpisodioClinico is null or  EpisodioClinico= @EpisodioClinico)	
		and (@Secuencia is null or  Secuencia= @Secuencia)	
		and (@SecuenciaInforme is null or  SecuenciaInforme= @SecuenciaInforme or  @SecuenciaInforme = 0)	
		and (@Nombre is null  OR @Nombre =''  OR  upper(Nombre) like '%'+upper(@Nombre)+'%')							
		
	end	
	else
	if(@ACCION = 'LISTARPORID')
	begin		 

		select * from SS_HC_ProcedimientoInforme
		where
		(UnidadReplicacion= @UnidadReplicacion)		
		and (IdEpisodioAtencion= @IdEpisodioAtencion)		
		and ( IdPaciente= @IdPaciente)		
		and ( EpisodioClinico= @EpisodioClinico)	
		and ( Secuencia= @Secuencia)	
		and (SecuenciaInforme= @SecuenciaInforme)	
		
	end	
		
	
END	
/*
exec [SP_SS_HC_ProcedimientoInformeListar]

	NULL,
	NULL,
	NULL,
	NULL,
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
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_ProcedimientoInformeSPRING_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC SP_SS_HC_ProcedimientoInformeSPRING_LISTAR    
--1,NULL, NULL, NULL, NULL,   
--NULL, NULL, NULL, NULL, NULL,   
--NULL, NULL, NULL, NULL, NULL,  
--NULL, NULL, NULL, NULL, NULL  ,
--NULL, 'LISTAR'
--I:\Laboratorio\0500000710342013102800009603631.pdf
--F:\
CREATE OR ALTER PROCEDURE [SP_SS_HC_ProcedimientoInformeSPRING_LISTAR]


	@IdProcedimiento int ,
	@NombreArchivo varchar(250) ,
	@RutaInforme varchar(300),
	@IdPaciente	int ,
	@Paciente varchar(300),
	@CodigoOA varchar(15),
	@CodigoComponente varchar(25),
	@DescripcionComponente varchar(300),
	@IdOrdenAtencion int,
	@LineaOA int,
	@TipoOrdenAtencion int ,
	@Medico varchar(300) ,
	@Observacion varchar(300) ,
	@FechaProcedimiento datetime=null,
	@FechaCreacion datetime=null,	
	@UsuarioCreacion varchar(15),
	@FechaModificacion datetime=null ,
	@UsuarioModificacion varchar(25) ,
	@Contador_filas int,
	@Inicio	int ,	
	@NumeroFilas int , 		
	@Accion	varchar(25) 
		
				

AS 
  BEGIN 
      SET nocount ON; 

      DECLARE @CONTADOR INT 
	
      IF @Accion = 'LISTAR' 
        BEGIN 
            SELECT SS_HC_ProcedimientoInformeSPRING.IdProcedimiento,
                   SS_HC_ProcedimientoInformeSPRING.NombreArchivo, 
				   Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace
				   (SS_HC_ProcedimientoInformeSPRING.RutaInforme,
					'X:\','\\SVSB-SERV-FL02\pdf-imagenes\'),
					'W:\','\\SVSB-SERV-FL02\PDF-Precisa\'),
					'R:\','\\SVSB-SERV-FL02\PDF_Patologia\'),	--
				    'I:\','\\EGVPFS1\informes\'),---\\controlador\informes\
					'G:\','\\EGVPFS1\Informes\GastroEnterologia\'),
					'P:\','\\EGVPFS1\informes\Patologia\Destino\'),
					'\\172.0.3.5\','\\SVSB-SERV-FL02\'),				
					'B:\','\\SVSB-SERV-FL02\Informes Radiologia\') RutaInforme,    
				   --SS_HC_ProcedimientoInformeSPRING.RutaInforme,             
                   SS_HC_ProcedimientoInformeSPRING.IdPaciente, 
                   SS_HC_ProcedimientoInformeSPRING.Paciente, 
                   SS_HC_ProcedimientoInformeSPRING.CodigoOA, 
                   SS_HC_ProcedimientoInformeSPRING.CodigoComponente,
				   SS_HC_ProcedimientoInformeSPRING.DescripcionComponente, 
				   SS_HC_ProcedimientoInformeSPRING.IdOrdenAtencion, 
				   SS_HC_ProcedimientoInformeSPRING.LineaOA,  
				   SS_HC_ProcedimientoInformeSPRING.TipoOrdenAtencion,
				   SS_HC_ProcedimientoInformeSPRING.Medico,
				   SS_HC_ProcedimientoInformeSPRING.Observacion,
				   SS_HC_ProcedimientoInformeSPRING.FechaProcedimiento,
				   SS_HC_ProcedimientoInformeSPRING.FechaCreacion,
				   SS_HC_ProcedimientoInformeSPRING.UsuarioCreacion,
				   SS_HC_ProcedimientoInformeSPRING.FechaModificacion,
				   SS_HC_ProcedimientoInformeSPRING.UsuarioModificacion,
                   SS_HC_ProcedimientoInformeSPRING.accion
                 
            FROM   SS_HC_ProcedimientoInformeSPRING  --where CodigoOA='0002462408'
             WHERE  ( @CodigoOA IS NULL OR Upper(SS_HC_ProcedimientoInformeSPRING.CodigoOA) LIKE '%' + Upper(@CodigoOA) + '%' ) 
			        AND ( @DescripcionComponente IS NULL OR Upper(SS_HC_ProcedimientoInformeSPRING.DescripcionComponente) LIKE '%' + Upper(@DescripcionComponente) + '%' ) 
                                    AND ( @IdPaciente IS NULL OR SS_HC_ProcedimientoInformeSPRING.IdPaciente = @IdPaciente OR @IdPaciente = 0 )      
				ORDER BY SS_HC_ProcedimientoInformeSPRING.FechaCreacion desc --luke 19/07/2019                              
                              --      AND( @Paciente IS NULL OR Upper(SS_HC_ProcedimientoInformeSPRING.Paciente) LIKE '%' + Upper(@Paciente) + '%' ) 
	                    
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_ProcedimientoInformeSPRING 
                              WHERE  ( @CodigoOA IS NULL OR Upper(SS_HC_ProcedimientoInformeSPRING.CodigoOA) LIKE '%' + Upper(@CodigoOA) + '%' ) 
							        AND ( @DescripcionComponente IS NULL OR Upper(SS_HC_ProcedimientoInformeSPRING.DescripcionComponente) LIKE '%' + Upper(@DescripcionComponente) + '%' ) 
                                    AND ( @IdPaciente IS NULL OR SS_HC_ProcedimientoInformeSPRING.IdPaciente = @IdPaciente OR @IdPaciente = 0 )                                    
                                --    AND( @Paciente IS NULL OR Upper(SS_HC_ProcedimientoInformeSPRING.Paciente) LIKE '%' + Upper(@Paciente) + '%' )
								 )


             SELECT IdProcedimiento,                    
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
                    accion,
					Contador_filas
            FROM   ( SELECT SS_HC_ProcedimientoInformeSPRING.IdProcedimiento,                    
                   SS_HC_ProcedimientoInformeSPRING.NombreArchivo, 
				   Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace
				   (SS_HC_ProcedimientoInformeSPRING.RutaInforme,
					'X:\','\\SVSB-SERV-FL02\pdf-imagenes\'),
					'W:\','\\SVSB-SERV-FL02\PDF-Precisa\'),
					'R:\','\\SVSB-SERV-FL02\PDF_Patologia\'),	--
				    'I:\','\\EGVPFS1\informes\'),---\\controlador\informes\
					'G:\','\\EGVPFS1\Informes\GastroEnterologia\'),
					'P:\','\\EGVPFS1\informes\Patologia\Destino\'),
					'\\172.0.3.5\','\\SVSB-SERV-FL02\'),				
					'B:\','\\SVSB-SERV-FL02\Informes Radiologia\') RutaInforme, 
				 --  SS_HC_ProcedimientoInformeSPRING.RutaInforme,                   
                   SS_HC_ProcedimientoInformeSPRING.IdPaciente, 
                   SS_HC_ProcedimientoInformeSPRING.Paciente, 
                   SS_HC_ProcedimientoInformeSPRING.CodigoOA, 
                   SS_HC_ProcedimientoInformeSPRING.CodigoComponente,
				   SS_HC_ProcedimientoInformeSPRING.DescripcionComponente, 
				   SS_HC_ProcedimientoInformeSPRING.IdOrdenAtencion, 
				   SS_HC_ProcedimientoInformeSPRING.LineaOA,  
				   SS_HC_ProcedimientoInformeSPRING.TipoOrdenAtencion,
				   SS_HC_ProcedimientoInformeSPRING.Medico,
				   SS_HC_ProcedimientoInformeSPRING.Observacion,
				   SS_HC_ProcedimientoInformeSPRING.FechaProcedimiento,
				   SS_HC_ProcedimientoInformeSPRING.FechaCreacion,
				   SS_HC_ProcedimientoInformeSPRING.UsuarioCreacion,
				   SS_HC_ProcedimientoInformeSPRING.FechaModificacion,
				   SS_HC_ProcedimientoInformeSPRING.UsuarioModificacion,
                   SS_HC_ProcedimientoInformeSPRING.accion, 
                           @CONTADOR                                  
                           AS 
                           Contador_filas, 
                           Row_number() 
                             OVER ( 
                             ORDER BY SS_HC_ProcedimientoInformeSPRING.FechaProcedimiento desc) 
                               AS 
                           RowNumber 
                    FROM   SS_HC_ProcedimientoInformeSPRING 
                     WHERE  ( @CodigoOA IS NULL OR Upper(SS_HC_ProcedimientoInformeSPRING.CodigoOA) LIKE '%' + Upper(@CodigoOA) + '%' ) 
					                AND ( @DescripcionComponente IS NULL OR Upper(SS_HC_ProcedimientoInformeSPRING.DescripcionComponente) LIKE '%' + Upper(@DescripcionComponente) + '%' ) 
                                    AND ( @IdPaciente IS NULL OR SS_HC_ProcedimientoInformeSPRING.IdPaciente = @IdPaciente OR @IdPaciente = 0 )   
									                               
                                   -- AND( @Paciente IS NULL OR Upper(SS_HC_ProcedimientoInformeSPRING.Paciente) LIKE '%' + Upper(@Paciente) + '%' ) 
									)
                AS LISTADO 
					--ORDER BY CodigoOA desc 
            WHERE  ( @Inicio IS NULL 
                     AND @NumeroFilas IS NULL ) 
                   OR rownumber BETWEEN @Inicio AND @NumeroFilas -- where del paginado 
			
        END 
  END 
/*    
--EXEC SP_SS_HC_ProcedimientoInformeSPRING_LISTAR    
--1,NULL, NULL, NULL, NULL,   
--NULL, NULL, NULL, NULL, NULL,   
--NULL, NULL, NULL, NULL, NULL,  
--NULL, NULL, NULL, NULL, NULL  ,
--NULL, 'LISTAR'
--I:\Laboratorio\0500000710342013102800009603631.pdf
--F:\
*/ 



GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_ProcedimientoListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_SS_HC_ProcedimientoListar]
(
	@IdProcedimiento int,
	@IdProcedimientoPadre int,
	@Descripcion varchar(200),
	@DescripcionExtranjera varchar(200),
	@Nivel int,
	@UltimoNivelFlag char,
	@CadenaRecursiva varchar(150),
	@Orden int,
	@Icono varchar(100),
	@NombreInterfaz varchar(100),
	@CodigoProcedimiento varchar(15),
	@UsuarioModficacion varchar(25),
	@FechaModificacion datetime,
	@Accion varchar(25),
	@UsuarioCreacion varchar(25),
	@FechaCreacion datetime,
	@Version varchar(25),
	@Estado int,	
		
	@INICIO   int= null,  
	@NUMEROFILAS int = null 
)
AS
BEGIN    
IF(@Accion = 'LISTARPAG')
	begin
		 DECLARE @CONTADOR INT
	
		SET @CONTADOR=(SELECT COUNT(IdProcedimiento) FROM SS_HC_Procedimiento
	 					WHERE 
					(@IdProcedimiento is null OR (IdProcedimiento = @IdProcedimiento) or @IdProcedimiento =0)
					and (@IdProcedimientoPadre is null OR IdProcedimientoPadre = @IdProcedimientoPadre)					
					and (@Estado is null OR Estado = @Estado)
					and (@CodigoProcedimiento is null  OR @CodigoProcedimiento =''  OR  upper(CodigoProcedimiento) like '%'+upper(@CodigoProcedimiento)+'%')
					)
		SELECT
			IdProcedimiento,
			IdProcedimientoPadre,
			Descripcion,
			DescripcionExtranjera,
			Nivel,
			UltimoNivelFlag,
			CadenaRecursiva,
			Orden,
			Icono,
			NombreInterfaz,
			CodigoProcedimiento,
			UsuarioModificacion,
			FechaModificacion,
			Accion,
			UsuarioCreacion,
			FechaCreacion,
			Version,
			Estado
		FROM (		
			SELECT
			IdProcedimiento,
			IdProcedimientoPadre,
			Descripcion,
			DescripcionExtranjera,
			Nivel,
			UltimoNivelFlag,
			CadenaRecursiva,
			Orden,
			Icono,
			NombreInterfaz,
			CodigoProcedimiento,
			UsuarioModificacion,
			FechaModificacion,
			Accion,
			UsuarioCreacion,
			FechaCreacion,
			Version,
			Estado
					,@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY IdProcedimiento ASC ) AS RowNumber   	
					FROM SS_HC_Procedimiento	
					WHERE 
							(@IdProcedimiento is null OR (IdProcedimiento = @IdProcedimiento) or @IdProcedimiento =0)
					and (@IdProcedimientoPadre is null OR IdProcedimientoPadre = @IdProcedimientoPadre)					
					and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')					
					and (@Estado is null OR Estado = @Estado)		
					and (@CodigoProcedimiento is null  OR @CodigoProcedimiento =''  OR  upper(CodigoProcedimiento) like '%'+upper(@CodigoProcedimiento)+'%')
 
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		
       END
       ELSE
 IF @Accion ='LISTAR'    
    BEGIN    
		SELECT
			IdProcedimiento,
			IdProcedimientoPadre,
			Descripcion,
			DescripcionExtranjera,
			Nivel,
			UltimoNivelFlag,
			CadenaRecursiva,
			Orden,
			Icono,
			NombreInterfaz,
			CodigoProcedimiento,
			UsuarioModificacion,
			FechaModificacion,
			Accion,
			UsuarioCreacion,
			FechaCreacion,
			Version,
			Estado
			FROM SS_HC_Procedimiento
								WHERE 
							(@IdProcedimiento is null OR (IdProcedimiento = @IdProcedimiento) or @IdProcedimiento =0)
					and (@IdProcedimientoPadre is null OR IdProcedimientoPadre = @IdProcedimientoPadre)					
					and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')					
					and (@Estado is null OR Estado = @Estado)		
					and (@CodigoProcedimiento is null OR CodigoProcedimiento = @CodigoProcedimiento)
	end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 
					*					
				from 
				SS_HC_Procedimiento
								WHERE 
							(IdProcedimiento = @IdProcedimiento)			

	end	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_RegistroAcompanante]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER PROCEDURE [SP_SS_HC_RegistroAcompanante]

	@IdAcompanante int ,
	@UnidadReplicacion  char(4),
	@IdPaciente  int ,
	@EpisodioClinico  int ,		
    @IdEpisodioAtencion  int ,
	@CodigoOA	nvarchar(15) ,
	@Tipo char(1) ,
	@numero nvarchar(15) ,	
	@TipoParentesco int ,
	@ApePat varchar(250) ,		
	@ApeMat	varchar(250) ,
	@Nombres varchar(250) ,
	@Telefono varchar(12),
	@Observaciones varchar(350),
	@Estado int ,
	@UsuarioCreacion varchar(25),
	@FechaCreacion datetime,
	@UsuarioModificacion varchar(25),
	@FechaModificacion datetime,
	@Accion varchar(25),
	@Version varchar(25)
			
AS 
  BEGIN 
      SET nocount ON; 

      IF @Accion = 'NUEVO' 
        BEGIN 
            SELECT @IdAcompanante = Isnull(Max(IdAcompanante), 0) + 1 FROM   dbo.SS_HC_RegistroAcompanante  
            INSERT INTO SS_HC_RegistroAcompanante 
                        (IdAcompanante,                          
                         UnidadReplicacion  ,
                         IdPaciente ,
                         EpisodioClinico ,	
                         IdEpisodioAtencion  ,
                         CodigoOA,
                         Tipo,
                         numero,
                         TipoParentesco,
                         ApePat,
                         ApeMat,
                         Nombres, 
                         Telefono,   
                         Observaciones,                  
                         Estado, 
                         UsuarioCreacion, 
                         FechaCreacion, 
                         UsuarioModificacion, 
                         FechaModificacion, 
                         Accion, 
                         Version) 
                         
            VALUES      ( @IdAcompanante ,
	                      @UnidadReplicacion  ,
                          @IdPaciente ,
                          @EpisodioClinico ,		
                          @IdEpisodioAtencion   ,
	                      @CodigoOA	 ,
	                      @Tipo ,
	                      @numero ,	
	                      @TipoParentesco ,
	                      @ApePat ,		
                          @ApeMat ,
	                      @Nombres  ,
	                      @Telefono ,
	                      @Observaciones ,
	                      @Estado ,
	                      @UsuarioCreacion ,
	                       Getdate(), 
	                      @UsuarioModificacion ,
	                      Getdate(), 
	                      'VISTA' ,
	                      @Version
                          ) 

            SELECT 1 
        END 
      ELSE IF @Accion = 'UPDATE' 
        BEGIN 
            UPDATE SS_HC_RegistroAcompanante 
            SET    
            
                         IdAcompanante =  @IdAcompanante,  
                         UnidadReplicacion = @UnidadReplicacion,                  
                         IdPaciente = @IdPaciente,
                         EpisodioClinico = @EpisodioClinico,
                         IdEpisodioAtencion = @IdEpisodioAtencion,
                         CodigoOA = @CodigoOA,
                         Tipo = @Tipo,
                         numero = @numero,
                         TipoParentesco = @TipoParentesco,
                         ApePat = @ApePat,
                         ApeMat = @ApeMat,
                         Nombres = @Nombres,
                         Telefono = @Telefono,
                         Observaciones = @Observaciones ,               
                         Estado = @Estado,
                      -- UsuarioCreacion 
                      -- FechaCreacion 
                         UsuarioModificacion = @UsuarioModificacion, 
                         FechaModificacion = GETDATE(),
                       --  Accion = @Accion,
                         Version = @Version
            
            
            
                   
            WHERE  ( SS_HC_RegistroAcompanante.IdAcompanante = @IdAcompanante ) 

            SELECT 1 
        END 
      ELSE IF @Accion = 'DELETE' 
        BEGIN 
            DELETE FROM SS_HC_RegistroAcompanante 
            WHERE  ( SS_HC_RegistroAcompanante.IdAcompanante = @IdAcompanante ) 

            SELECT 1 
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_RegistroAcompanante 
                             WHERE   ( @Observaciones IS NULL OR Upper(SS_HC_RegistroAcompanante.Observaciones) LIKE '%' + Upper(@Observaciones) + '%' ) 
                                    AND ( @Estado IS NULL OR SS_HC_RegistroAcompanante.Estado = @Estado OR @Estado = 0 )   
                                    AND ( @IdPaciente IS NULL OR SS_HC_RegistroAcompanante.IdPaciente = @IdPaciente OR @IdPaciente = 0 )   
                                    AND ( @UnidadReplicacion IS NULL OR Upper(SS_HC_RegistroAcompanante.UnidadReplicacion) LIKE '%' + Upper(@UnidadReplicacion) + '%' )    
                                    AND ( @EpisodioClinico IS NULL OR SS_HC_RegistroAcompanante.EpisodioClinico = @EpisodioClinico OR @EpisodioClinico = 0 )  
                                    AND ( @IdEpisodioAtencion IS NULL OR SS_HC_RegistroAcompanante.IdEpisodioAtencion = @IdEpisodioAtencion OR @IdEpisodioAtencion = 0 )                                  
                                    AND ( @IdAcompanante IS NULL OR SS_HC_RegistroAcompanante.IdAcompanante = @IdAcompanante OR @IdAcompanante = 0 ))

            SELECT @CONTADOR; 
        END 
  END 




GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_RegistroAcompanante_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER PROCEDURE [SP_SS_HC_RegistroAcompanante_LISTAR]


	@IdAcompanante int ,
	@UnidadReplicacion  char(4),
	@IdPaciente  int ,
	@EpisodioClinico  int ,		
    @IdEpisodioAtencion  int ,
	@CodigoOA	nvarchar(15) ,
	@Tipo char(1) ,
	@numero nvarchar(15) ,	
	@TipoParentesco int ,
	@ApePat varchar(250) ,		
	@ApeMat	varchar(250) ,
	@Nombres varchar(250) ,
	@Telefono varchar(12),
	@Observaciones varchar(350),
	@Estado int ,
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
      SET nocount ON; 

      DECLARE @CONTADOR INT 

      IF @Accion = 'LISTAR' 
        BEGIN 
            SELECT SS_HC_RegistroAcompanante.IdAcompanante , 
                   SS_HC_RegistroAcompanante.UnidadReplicacion  ,
                   SS_HC_RegistroAcompanante.IdPaciente ,
                   SS_HC_RegistroAcompanante.EpisodioClinico ,	
                   SS_HC_RegistroAcompanante.IdEpisodioAtencion  ,                   
                   SS_HC_RegistroAcompanante.CodigoOA, 
                   SS_HC_RegistroAcompanante.Tipo, 
                   SS_HC_RegistroAcompanante.numero, 
                   SS_HC_RegistroAcompanante.TipoParentesco,
                   SS_HC_RegistroAcompanante.ApePat, 
                   SS_HC_RegistroAcompanante.ApeMat, 
                   SS_HC_RegistroAcompanante.Nombres, 
                   SS_HC_RegistroAcompanante.Telefono, 
                   SS_HC_RegistroAcompanante.Observaciones, 
                   SS_HC_RegistroAcompanante.Estado,
                   SS_HC_RegistroAcompanante.UsuarioCreacion,
                   SS_HC_RegistroAcompanante.Fechacreacion, 
                   SS_HC_RegistroAcompanante.UsuarioModificacion, 
                   SS_HC_RegistroAcompanante.Fechamodificacion, 
                   SS_HC_RegistroAcompanante.Accion, 
                   SS_HC_RegistroAcompanante.Version 
            FROM   SS_HC_RegistroAcompanante 
             WHERE                     ( @IdPaciente IS NULL OR SS_HC_RegistroAcompanante.IdPaciente = @IdPaciente OR @IdPaciente = 0 )   
                                    AND ( @UnidadReplicacion IS NULL OR Upper(SS_HC_RegistroAcompanante.UnidadReplicacion) LIKE '%' + Upper(@UnidadReplicacion) + '%' )    
                                    AND ( @EpisodioClinico IS NULL OR SS_HC_RegistroAcompanante.EpisodioClinico = @EpisodioClinico OR @EpisodioClinico = 0 )  
                                    AND ( @IdEpisodioAtencion IS NULL OR SS_HC_RegistroAcompanante.IdEpisodioAtencion = @IdEpisodioAtencion OR @IdEpisodioAtencion = 0 )
        END 
      ELSE IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            SET @CONTADOR = (SELECT Count(IdEpisodioAtencion) 
                             FROM   SS_HC_RegistroAcompanante 
                              WHERE     
                                     IdPaciente = @IdPaciente   
                                 and EpisodioClinico = @EpisodioClinico  
                                 and IdEpisodioAtencion = @IdEpisodioAtencion  
                                 and UnidadReplicacion = @UnidadReplicacion
                                     
                                     )
            SELECT       IdAcompanante,    
                         UnidadReplicacion  ,
                         IdPaciente, 
                         EpisodioClinico,
                         IdEpisodioAtencion,                         
                         CodigoOA,
                         Tipo,
                         numero,
                         TipoParentesco,
                         ApePat,
                         ApeMat,
                         Nombres, 
                         Telefono,   
                         Observaciones,                  
                         Estado, 
                         UsuarioCreacion, 
                         FechaCreacion, 
                         UsuarioModificacion, 
                         FechaModificacion, 
                         Accion, 
                         Version
                          
            FROM  (SELECT SS_HC_RegistroAcompanante.IdAcompanante, 
                  SS_HC_RegistroAcompanante.UnidadReplicacion,
                   SS_HC_RegistroAcompanante.IdPaciente, 
                   SS_HC_RegistroAcompanante.EpisodioClinico,
                   SS_HC_RegistroAcompanante.IdEpisodioAtencion,                     
                   SS_HC_RegistroAcompanante.CodigoOA, 
                   SS_HC_RegistroAcompanante.Tipo, 
                   SS_HC_RegistroAcompanante.numero, 
                   SS_HC_RegistroAcompanante.TipoParentesco,
                   SS_HC_RegistroAcompanante.ApePat, 
                   SS_HC_RegistroAcompanante.ApeMat, 
                   SS_HC_RegistroAcompanante.Nombres, 
                   SS_HC_RegistroAcompanante.Telefono, 
                   SS_HC_RegistroAcompanante.Observaciones, 
                   SS_HC_RegistroAcompanante.Estado,
                   SS_HC_RegistroAcompanante.UsuarioCreacion,
                   SS_HC_RegistroAcompanante.Fechacreacion, 
                   SS_HC_RegistroAcompanante.UsuarioModificacion, 
                   SS_HC_RegistroAcompanante.Fechamodificacion, 
                   SS_HC_RegistroAcompanante.Accion, 
                   SS_HC_RegistroAcompanante.Version ,
                   @CONTADOR     AS 
                           Contador, 
                           Row_number() 
                             OVER ( 
                               ORDER BY SS_HC_RegistroAcompanante.IdEpisodioAtencion ASC ) AS 
                           RowNumber 
                    FROM   SS_HC_RegistroAcompanante 
                     WHERE          
                     
                                     IdPaciente = @IdPaciente   
                                 and EpisodioClinico = @EpisodioClinico  
                                 and IdEpisodioAtencion = @IdEpisodioAtencion  
                                 and UnidadReplicacion = @UnidadReplicacion
                     
                     )
                   AS LISTADO 
          
        END 
        
        ELSE IF( @ACCION = 'LISTARPORPACIENTE' ) 
        BEGIN 
            SET @CONTADOR = (SELECT Count(*) 
                             FROM   SS_HC_RegistroAcompanante 
                              WHERE      ( @IdPaciente IS NULL OR SS_HC_RegistroAcompanante.IdPaciente = @IdPaciente OR @IdPaciente = 0 )   
                                    AND ( @UnidadReplicacion IS NULL OR Upper(SS_HC_RegistroAcompanante.UnidadReplicacion) LIKE '%' + Upper(@UnidadReplicacion) + '%' )    
                                    AND ( @EpisodioClinico IS NULL OR SS_HC_RegistroAcompanante.EpisodioClinico = @EpisodioClinico OR @EpisodioClinico = 0 )  
                                    AND ( @IdEpisodioAtencion IS NULL OR SS_HC_RegistroAcompanante.IdEpisodioAtencion = @IdEpisodioAtencion OR @IdEpisodioAtencion = 0 ))

            SELECT IdAcompanante,    
                         UnidadReplicacion,                      
                         IdPaciente, 
                         IdEpisodioAtencion,
                         EpisodioClinico,
                         CodigoOA,
                         Tipo,
                         numero,
                         TipoParentesco,
                         ApePat,
                         ApeMat,
                         Nombres, 
                         Telefono,   
                         Observaciones,                  
                         Estado, 
                         UsuarioCreacion, 
                         FechaCreacion, 
                         UsuarioModificacion, 
                         FechaModificacion, 
                         Accion, 
                         Version
                          
            FROM  (SELECT SS_HC_RegistroAcompanante.IdAcompanante, 
                   SS_HC_RegistroAcompanante.UnidadReplicacion, 
                   SS_HC_RegistroAcompanante.IdPaciente,
                   SS_HC_RegistroAcompanante.IdEpisodioAtencion,
                   SS_HC_RegistroAcompanante.EpisodioClinico,
                   SS_HC_RegistroAcompanante.CodigoOA, 
                   SS_HC_RegistroAcompanante.Tipo, 
                   SS_HC_RegistroAcompanante.numero, 
                   SS_HC_RegistroAcompanante.TipoParentesco,
                   SS_HC_RegistroAcompanante.ApePat, 
                   SS_HC_RegistroAcompanante.ApeMat, 
                   SS_HC_RegistroAcompanante.Nombres, 
                   SS_HC_RegistroAcompanante.Telefono, 
                   SS_HC_RegistroAcompanante.Observaciones, 
                   SS_HC_RegistroAcompanante.Estado,
                   SS_HC_RegistroAcompanante.UsuarioCreacion,
                   SS_HC_RegistroAcompanante.Fechacreacion, 
                   SS_HC_RegistroAcompanante.UsuarioModificacion, 
                   SS_HC_RegistroAcompanante.Fechamodificacion, 
                   SS_HC_RegistroAcompanante.Accion, 
                   SS_HC_RegistroAcompanante.Version ,
                   @CONTADOR     AS 
                           Contador, 
                           Row_number() 
                             OVER ( 
                               ORDER BY SS_HC_RegistroAcompanante.IdAcompanante ASC ) AS 
                           RowNumber 
                    FROM   SS_HC_RegistroAcompanante 
                     WHERE             ( @IdPaciente IS NULL OR SS_HC_RegistroAcompanante.IdPaciente = @IdPaciente OR @IdPaciente = 0 )   
                                    AND ( @UnidadReplicacion IS NULL OR Upper(SS_HC_RegistroAcompanante.UnidadReplicacion) LIKE '%' + Upper(@UnidadReplicacion) + '%' )    
                                    AND ( @EpisodioClinico IS NULL OR SS_HC_RegistroAcompanante.EpisodioClinico = @EpisodioClinico OR @EpisodioClinico = 0 )  
                                    AND ( @IdEpisodioAtencion IS NULL OR SS_HC_RegistroAcompanante.IdEpisodioAtencion = @IdEpisodioAtencion OR @IdEpisodioAtencion = 0 ))
                   AS LISTADO 
           
        END 
        
  END 








GO
/****** Object:  StoredProcedure [dbo].[SP_SS_HC_ReporteEpisodioClinico]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

   
CREATE OR ALTER PROCEDURE [SP_SS_HC_ReporteEpisodioClinico] 
/******   
  Autor:		Jordan Mateo
  Creación:    28/09/2016
  **********************************************************/
      @UnidadReplicacion		VARCHAR(100),                
      @IdPaciente				INT=NULL,
      @CodigoOA					VARCHAR(100)
AS
      BEGIN


  SELECT ECLI.UnidadReplicacion, ECLI.FechaAtencion, ECLI.TipoAtencion, ECLI.IdOrdenAtencion,
             ECLI.LineaOrdenAtencion, ECLI.TipoOrdenAtencion,ECLI.Persona, ECLI.ApellidoPaterno,  
			ECLI.ApellidoMaterno, ECLI.Nombres,  ECLI.CodigoOA   ,'' Documento,ECLI.Accion,ECLI.Accion Version ,
			'http://localhost:11505/Reportes/VisorReportesHCE.aspx?' as Tabla,ECLI.EpisodioClinico,ECLI.Episodio_Atencion EpisodioAtencion,
			'GENERICO_HCE' as TipoFormulario,'' Ruta,FO.Descripcion Formulario FROM V_EpisodioAtenciones  ECLI
			 INNER JOIN SS_HC_Formato FO		 ON FO.CodigoFormato = ECLI.Accion
		 WHERE 	  (@UnidadReplicacion IS NULL OR ECLI.UnidadReplicacion = @UnidadReplicacion)  
	 AND	  (@IdPaciente IS NULL OR ECLI.IdPaciente = @IdPaciente)  
	 AND	  (@CodigoOA IS NULL OR ECLI.CodigoOA = @CodigoOA) 	
	 ORDER BY ECLI.EpisodioClinico,ECLI.IdEpisodioAtencion	


END


GO
