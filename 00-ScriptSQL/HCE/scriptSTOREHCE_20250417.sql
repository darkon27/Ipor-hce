
/****** Object:  StoredProcedure [dbo].[buscatexto]    Script Date: 17/04/2025 18:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [buscatexto]   
   (  
    @texto CHAR(255)  
   )  
AS  
BEGIN   
DECLARE @sql CHAR(255)  
  
SELECT @sql = 'SELECT DISTINCT(name) FROM syscomments a, sysobjects b WHERE a.id = b.id AND text LIKE ''%'  
SELECT @sql = RTRIM(@sql) + @texto  
SELECT @sql = RTRIM(@sql) + '%'''  
  
EXEC(@sql)  
  
END  
GO
/****** Object:  StoredProcedure [dbo].[BuscaValorEnBBDD]    Script Date: 17/04/2025 18:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[BuscaValorEnBBDD]
(
@StrValorBusqueda nvarchar(100)
)
AS
BEGIN

CREATE TABLE #Resultado (NombreColumna nvarchar(370), ValorColumna nvarchar(3630))
SET NOCOUNT ON

DECLARE @NombreTabla nvarchar(256),
@NombreColumna nvarchar(128),
@StrValorBusqueda2 nvarchar(110)

SET  @NombreTabla = ''
SET @StrValorBusqueda2 = QUOTENAME('%' + @StrValorBusqueda + '%','''')

WHILE @NombreTabla IS NOT NULL
     BEGIN
     SET @NombreColumna = ''
     SET @NombreTabla =
     (SELECT MIN(QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME))
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_TYPE = 'BASE TABLE'
     AND QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) > @NombreTabla
     AND OBJECTPROPERTY(
     OBJECT_ID(QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME)), 'IsMSShipped') = 0)

     WHILE (@NombreTabla IS NOT NULL) AND (@NombreColumna IS NOT NULL)
         BEGIN
         SET @NombreColumna =
         (SELECT MIN(QUOTENAME(COLUMN_NAME))
         FROM INFORMATION_SCHEMA.COLUMNS
         WHERE TABLE_SCHEMA = PARSENAME(@NombreTabla, 2)
         AND TABLE_NAME = PARSENAME(@NombreTabla, 1)
         AND DATA_TYPE IN ('char', 'varchar', 'nchar', 'nvarchar')
         AND QUOTENAME(COLUMN_NAME) > @NombreColumna)

         IF @NombreColumna IS NOT NULL
              BEGIN
              INSERT INTO #Resultado
              EXEC
              ('SELECT ''' + @NombreTabla + '.' + @NombreColumna + ''', LEFT(' + @NombreColumna + ', 3630)
              FROM ' + @NombreTabla + ' (NOLOCK) ' + ' WHERE ' + @NombreColumna + ' LIKE ' + @StrValorBusqueda2)
              END 
         END
     END
     SELECT NombreColumna, ValorColumna FROM #Resultado
END
GO
/****** Object:  StoredProcedure [dbo].[guardartriaje]    Script Date: 17/04/2025 18:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [guardartriaje]
@idordenatencion int,
@diagnostico varchar(90),
@fechaatencion varchar(70),
@motivo varchar(50),
@antecedentes varchar(500),
@alergias varchar(500),
@peso varchar(10),
@pa varchar(10),
@pa2 varchar(10),
@temperatura varchar(10),
@sato2 varchar(10),
@fc varchar(10),
@fr varchar(10),
@fur varchar(10),
@discriminador1 varchar(30),
@discriminador2 varchar(30),
@discriminador3 varchar(30),
@discriminador4 varchar(30),
@discriminador5 varchar(30),
@discriminador6 varchar(30),
@discriminador7 varchar(30),
@discriminador8 varchar(30),
@discriminador9 varchar(30),
@discriminador10 varchar(30),
@discriminador11 varchar(30),
@discriminador12 varchar(30),
@discriminador13 varchar(30),
@discriminador14 varchar(30),
@discriminador15 varchar(30),
@discriminador16 varchar(30),
@discriminador17 varchar(30),
@discriminador18 varchar(30),
@observacion varchar(300),
@prioridad char(1)
as
begin
	declare @coddiagnostico int
	set @coddiagnostico=(select iddiagnostico from diagnostico where descripcion=@diagnostico)

	IF EXISTS(SELECT idordenatencion FROM detalle_triaje where idordenatencion=@idordenatencion)

	update detalle_triaje
	set fechaatencion=@fechaatencion,motivo=@motivo,antecedentes=@antecedentes,alergias=@alergias,peso=@peso,
	pa=@pa,pa2=@pa2,temperatura=@temperatura,sato2=@sato2,fc=@fc,fur=@fur,discriminador1=@discriminador1,
	discriminador2=@discriminador2,discriminador3=@discriminador3,discriminador4=@discriminador4,discriminador5=@discriminador5,
	discriminador6=@discriminador6,discriminador7=@discriminador7,discriminador8=@discriminador8,discriminador9=@discriminador9,discriminador10=@discriminador10,
	discriminador11=@discriminador11,discriminador12=@discriminador12,discriminador13=@discriminador13,discriminador14=@discriminador14,discriminador15=@discriminador15,
	discriminador16=@discriminador16,discriminador17=@discriminador17,discriminador18=@discriminador18,observacion=@observacion,
	prioridad=@prioridad,fechahoraregistro=getdate()
	where idordenatencion=@idordenatencion

	ELSE

	insert into detalle_triaje values(@idordenatencion,@coddiagnostico,@fechaatencion,@motivo,@antecedentes,@alergias,
	@peso,@pa,@pa2,@temperatura,@sato2,@fc,@fr,@fur,@discriminador1,@discriminador2,@discriminador3,@discriminador4,
	@discriminador5,@discriminador6,@discriminador7,@discriminador8,@discriminador9,@discriminador10,@discriminador11,
	@discriminador12,@discriminador13,@discriminador14,@discriminador15,@discriminador16,@discriminador17,@discriminador18,
	@observacion,@prioridad, getdate())

	update ordenatencion set estadoatencion='ATENDIDO' where idordenatencion=@idordenatencion
end
GO
/****** Object:  StoredProcedure [dbo].[HCE_ELIMINAR_ATENCIONES]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [HCE_ELIMINAR_ATENCIONES]
@IDORDENATENCION INT,
@IDEPISODIOATENCION INT,
@IDEPISODIOCLINICO INT,
@TICKET_ATENCION INT

AS
BEGIN
	DECLARE @ll_Spid AS INT    
	DECLARE @ls_HostName AS VARCHAR(100)    
	DECLARE @ls_UserSystem AS VARCHAR(100)    
	DECLARE @ls_AppName AS VARCHAR(150)    
	DECLARE @fecha DATETIME
	DECLARE @ls_Texto AS VARCHAR(100)
	SELECT @ls_HostName = HOST_NAME(), @ls_AppName = APP_NAME(), @ll_Spid = @@spid, @ls_UserSystem = SUSER_SNAME() , @fecha = GETDATE(), 
	       @ls_Texto = 'ELIMINAR_ATENCION_HCE '+CAST(@IDORDENATENCION AS VARCHAR(20))+','+CAST(@IDEPISODIOATENCION AS VARCHAR(15))+','+CAST(@IDEPISODIOCLINICO AS VARCHAR(15))+','+CAST(@TICKET_ATENCION AS VARCHAR(15))

			DELETE FROM SS_HC_EpisodioAtencion
			WHERE IdOrdenAtencion= @IDORDENATENCION and IdEpisodioAtencion = @IDEPISODIOATENCION and EpisodioClinico= @IDEPISODIOCLINICO
	
			DELETE FROM SS_HC_EpisodioClinico
			WHERE IdOrdenAtencion= @IDORDENATENCION and EpisodioClinico= @IDEPISODIOCLINICO

			DELETE FROM SS_HC_EpisodioAtencionMaster
			WHERE IdOrdenAtencion= @IDORDENATENCION and EpisodioAtencion = @IDEPISODIOATENCION and EpisodioClinico= @IDEPISODIOCLINICO
		
END
GO
/****** Object:  StoredProcedure [dbo].[leer]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [leer] (    
    @obj varchar(50)    
 )    
as    
begin    
    declare @sql varchar(250),    
         @type char(5)    
    
    select @type = ''    
    select @type = xtype from sysobjects where name = @obj    
    if @@rowcount > 0    
    begin    
        if @type = 'U'    
           begin  select @sql = 'sp_help ' + @obj end    
        if @type = 'P'    
           begin  select @sql = 'sp_helptext ' + @obj end    
        if @type = 'V'    
           begin  select @sql = 'sp_helptext ' + @obj end    
        execute(@sql)    
    end    
    else    
    begin    
        print 'OBJETO NO ENCONTRADO :P'    
    end    
    
    return    
end    
GO
/****** Object:  StoredProcedure [dbo].[leerDatos]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [leerDatos] (    
    @obj varchar(50)    
 )    
as    
begin    
		SELECT

		so.name AS Tabla,

		sc.name AS Columna,

		st.name AS Tipo,

		sc.max_length AS Tamaño,
		sc.column_id

		FROM

		sys.objects so INNER JOIN

		sys.columns sc ON

		so.object_id = sc.object_id INNER JOIN

		sys.types st ON

		st.system_type_id = sc.system_type_id AND

		st.name != 'sysname'

		WHERE

		so.type = 'U'

		ORDER BY
		so.name ,

		sc.column_id
--so.name,
--sc.name 

end    
GO

/****** Object:  StoredProcedure [dbo].[RPT_AnamnesisAF_Reportes]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE OR ALTER PROCEDURE  [dbo].[RPT_AnamnesisAF_Reportes] 
	@UnidadReplicacion char(4) ,
	@IdEpisodioAtencion bigint  ,
	@IdPaciente int  ,
	@EpisodioClinico int  ,
	@Secuencia int  ,
	@IdTipoParentesco int  ,
	@Accion varchar(25) 
	
AS
BEGIN
	 
	 select * from dbo.rptViewAnamnesisAF  
	 Where  
				UnidadReplicacion	= @UnidadReplicacion
		and		IdPaciente			= @IdPaciente
		and		EpisodioClinico		= @EpisodioClinico
		and		IdEpisodioAtencion	= @IdEpisodioAtencion	 
 
END
 
		 
GO
/****** Object:  StoredProcedure [dbo].[RPT_AnamnesisAP_Reportes]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[RPT_AnamnesisAP_Reportes] 
 @UnidadReplicacion char(4),  
 @IdEpisodioAtencion bigint ,  
 @IdPaciente int,  
 @EpisodioClinico int,    
 @nombrePaciente varchar(100),  
 @Accion varchar(30)  
   
AS  
BEGIN  				
	
	IF @Accion ='REPORTEA'  
	  BEGIN  
		Select * From   dbo.rptViewAnamnesisAP
		Where 
		IdPaciente = @IdPaciente
		and EpisodioClinico = @EpisodioClinico 
		and IdEpisodioAtencion = @IdEpisodioAtencion  
		and UnidadReplicacion = @UnidadReplicacion  
	  END  
END
GO
/****** Object:  StoredProcedure [dbo].[RPT_AnamnesisEA_Reportes]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[RPT_AnamnesisEA_Reportes] 
 @UnidadReplicacion char(4),  
 @IdEpisodioAtencion bigint ,  
 @IdPaciente int,  
 @EpisodioClinico int,  
 @MotivoConsulta varchar(200),  
 @IdFormaInicio int,  
 @IdCursoEnfermedad int,  
 @Accion varchar(30)  
   
AS  
BEGIN  				
	
	IF @Accion ='REPORTEA'  
	  BEGIN  
		Select * From   rptViewAnamnesisEA   
		Where 
		IdPaciente = @IdPaciente
		and EpisodioClinico = @EpisodioClinico 
		and IdEpisodioAtencion = @IdEpisodioAtencion  
		and UnidadReplicacion = @UnidadReplicacion  
	  END  
END
GO
/****** Object:  StoredProcedure [dbo].[RPT_CuidadosPreventivos_Reportes]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE  [dbo].[RPT_CuidadosPreventivos_Reportes] 
 @UnidadReplicacion char(4),  
 @IdEpisodioAtencion bigint ,  
 @IdPaciente int,  
 @EpisodioClinico int,   
 @nombrePaciente varchar(100),  
 @Accion varchar(30)  
   
AS  
BEGIN  				
	
	IF @Accion ='REPORTEA'  
	  BEGIN  
		Select * From   rptViewCuidadosPreventivos
		Where 		
		IdPaciente = @IdPaciente
		and EpisodioClinico = @EpisodioClinico 
		and IdEpisodioAtencion = @IdEpisodioAtencion  
		and UnidadReplicacion = @UnidadReplicacion  
		
	  END  
END

GO
/****** Object:  StoredProcedure [dbo].[RPT_Diagnostico_Reportes]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[RPT_Diagnostico_Reportes] 
 @UnidadReplicacion char(4),  
 @IdEpisodioAtencion bigint ,  
 @IdPaciente int,  
 @EpisodioClinico int,    
 @nombrePaciente varchar(100),  
 @Accion varchar(30)  
   
AS  
BEGIN  				
	
	IF @Accion ='REPORTEA'  
	  BEGIN  
		Select * From   rptViewDiagnostico
		Where 
		IdPaciente = @IdPaciente
		and EpisodioClinico = @EpisodioClinico 
		and IdEpisodioAtencion = @IdEpisodioAtencion  
		and UnidadReplicacion = @UnidadReplicacion  
		
	  END  
END
GO
/****** Object:  StoredProcedure [dbo].[RPT_Diagnostico_Reportes_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE  [dbo].[RPT_Diagnostico_Reportes_FE] 
 @UnidadReplicacion char(4),  
 @IdEpisodioAtencion bigint ,  
 @IdPaciente int,  
 @EpisodioClinico int,
 @nombrePaciente varchar(100),  
 @Accion varchar(30)  
   
AS  
BEGIN  				
	
	IF @Accion ='REPORTEA'  
	  BEGIN  
		Select * From   rptViewDiagnostico_FE
		Where 
		IdPaciente = @IdPaciente
		and EpisodioClinico = @EpisodioClinico 
		and IdEpisodioAtencion = @IdEpisodioAtencion  
		and UnidadReplicacion = @UnidadReplicacion  
		
	  END  
END
GO
/****** Object:  StoredProcedure [dbo].[RPT_EmitirDescansoMedico_Reportes]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE  [dbo].[RPT_EmitirDescansoMedico_Reportes] 
 @UnidadReplicacion char(4),  
 @IdEpisodioAtencion bigint ,  
 @IdPaciente int,  
 @EpisodioClinico int,    
 @nombrePaciente varchar(100),  
 @Accion varchar(30)  
   
AS  
BEGIN  				
	
	IF @Accion ='REPORTEA'  
	  BEGIN  
		Select * From   rptViewEmitirDescansoMedico
		Where 
		IdPaciente = @IdPaciente
		and EpisodioClinico = @EpisodioClinico 
		and IdEpisodioAtencion = @IdEpisodioAtencion  
		and UnidadReplicacion = @UnidadReplicacion  
	  END  
END


GO
/****** Object:  StoredProcedure [dbo].[RPT_EmitirDescansoMedico_Reportes_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE  [dbo].[RPT_EmitirDescansoMedico_Reportes_FE] 
 @UnidadReplicacion char(4),  
 @IdEpisodioAtencion bigint ,  
 @IdPaciente int,  
 @EpisodioClinico int,  
 @nombrePaciente varchar(100),  
 @Accion varchar(30)     
AS  
BEGIN  				
	
	IF @Accion ='REPORTEA'  
	  BEGIN  
	  	SELECT  *  FROM   rptViewEmitirDescansoMedico_FE  a  Where 
		a.IdPaciente = @IdPaciente
		and a.EpisodioClinico = @EpisodioClinico 
		and a.IdEpisodioAtencion = @IdEpisodioAtencion  
		and a.UnidadReplicacion = @UnidadReplicacion  			
	  END  
END
GO
/****** Object:  StoredProcedure [dbo].[RPT_EvolucionObjetiva_Reportes]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[RPT_EvolucionObjetiva_Reportes] 
 @UnidadReplicacion char(4),  
 @IdEpisodioAtencion bigint ,  
 @IdPaciente int,  
 @EpisodioClinico int,   
 @nombrePaciente varchar(100),  
 @Accion varchar(30)  
   
AS  
BEGIN  				
	
	IF @Accion ='REPORTEA'  
	  BEGIN  
		Select * From   rptViewEvolucionObjetiva
		Where 
		IdPaciente = @IdPaciente
		and EpisodioClinico = @EpisodioClinico 
		and IdEpisodioAtencion = @IdEpisodioAtencion  
		and UnidadReplicacion = @UnidadReplicacion  
	  END  

	  IF @Accion ='EVOLUCION'  
	  BEGIN  
		Select * From   SS_HC_EvolucionMedica_FE
		Where 
		IdPaciente = @IdPaciente
		and EpisodioClinico = @EpisodioClinico 
		and UnidadReplicacion = @UnidadReplicacion  
	  END  
END
GO
/****** Object:  StoredProcedure [dbo].[RPT_ExamenFisico_Regional_Reportes]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[RPT_ExamenFisico_Regional_Reportes] 
 @UnidadReplicacion char(4),  
 @IdEpisodioAtencion bigint ,  
 @IdPaciente int,  
 @EpisodioClinico int,   
 @nombrePaciente varchar(100),  
 @Accion varchar(30)  
   
AS  
BEGIN  				
	
	IF @Accion ='REPORTEA'  
	  BEGIN  
		Select * From   rptViewExamenFisicoRegional
		Where 
		IdPaciente = @IdPaciente
		and EpisodioClinico = @EpisodioClinico 
		and IdEpisodioAtencion = @IdEpisodioAtencion  
		and UnidadReplicacion = @UnidadReplicacion  
	  END  
END
GO
/****** Object:  StoredProcedure [dbo].[RPT_ExamenFisico_Triaje_Reportes]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[RPT_ExamenFisico_Triaje_Reportes] 
 @UnidadReplicacion char(4),  
 @IdEpisodioAtencion bigint ,  
 @IdPaciente int,  
 @EpisodioClinico int,    
 @nombrePaciente varchar(100),  
 @Accion varchar(30)  
   
AS  
BEGIN  				
	
	IF @Accion ='REPORTEA'  
	  BEGIN  
		Select * From   rptViewExamenTriajeFisico
		Where 
		IdPaciente = @IdPaciente
		and EpisodioClinico = @EpisodioClinico 
		and IdEpisodioAtencion = @IdEpisodioAtencion  
		and UnidadReplicacion = @UnidadReplicacion  
	  END  
END
GO
/****** Object:  StoredProcedure [dbo].[RPT_ExamenSolicitado_Reportes]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[RPT_ExamenSolicitado_Reportes] 
 @UnidadReplicacion char(4),  
 @IdEpisodioAtencion bigint ,  
 @IdPaciente int,  
 @EpisodioClinico int,    
 @nombrePaciente varchar(100),  
 @Accion varchar(30)  
   
AS  
BEGIN  				
	
	IF @Accion ='REPORTEA'  
	  BEGIN  
		Select * From   rptViewExamenSolicitado
		Where 
		IdPaciente = @IdPaciente
		and EpisodioClinico = @EpisodioClinico 
		and IdEpisodioAtencion = @IdEpisodioAtencion  
		and UnidadReplicacion = @UnidadReplicacion  
	  END  
END
GO

/****** Object:  StoredProcedure [dbo].[RPT_ImunizacionNinio_Reportes_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[RPT_ImunizacionNinio_Reportes_FE] 
 @UnidadReplicacion char(4),  
 @IdEpisodioAtencion bigint ,  
 @IdPaciente int,  
 @EpisodioClinico int,    
 @Accion varchar(25), 
 @Version varchar(25)  
   
AS  
BEGIN  				
	
	IF @Accion ='REPORTEA'  
	  BEGIN  
		Select * From   rptViewInmunizacionNinio_FE
		Where 		
		IdPaciente = @IdPaciente
		and EpisodioClinico = @EpisodioClinico 
		and IdEpisodioAtencion = @IdEpisodioAtencion  
		and SubString(UnidadReplicacion, 1,4) = @UnidadReplicacion  
		
	  END  
END


GO
/****** Object:  StoredProcedure [dbo].[RPT_Medicamentos_Reportes]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[RPT_Medicamentos_Reportes] 
 @UnidadReplicacion char(4),  
 @IdEpisodioAtencion bigint ,  
 @IdPaciente int,  
 @EpisodioClinico int,    
 @nombrePaciente varchar(100),  
 @Accion varchar(30)  
   
AS  
BEGIN  				
	
	IF @Accion ='REPORTEA'  
	  BEGIN  
		Select * From   rptViewMedicamentos
		Where 
		IdPaciente = @IdPaciente
		and EpisodioClinico = @EpisodioClinico 
		and IdEpisodioAtencion = @IdEpisodioAtencion  
		and UnidadReplicacion = @UnidadReplicacion  
	  END  
END
GO
/****** Object:  StoredProcedure [dbo].[RPT_ProximaAtencion_Reportes]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE  [dbo].[RPT_ProximaAtencion_Reportes] 
 @UnidadReplicacion char(4),  
 @IdEpisodioAtencion bigint ,  
 @IdPaciente int,  
 @EpisodioClinico int,    
 @nombrePaciente varchar(100),  
 @Accion varchar(30)  
   
AS  
BEGIN  				
	
	IF @Accion ='REPORTEA'  
	  BEGIN  
		Select * From   rptViewProximaAtencion
		Where 
		IdPaciente = @IdPaciente
		and EpisodioClinico = @EpisodioClinico 
		and IdEpisodioAtencion = @IdEpisodioAtencion  
		and UnidadReplicacion = @UnidadReplicacion  
	  END  
END
GO
/****** Object:  StoredProcedure [dbo].[RPT_SolicitarReferencias_Reportes]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE  [dbo].[RPT_SolicitarReferencias_Reportes] 
 @UnidadReplicacion char(4),  
 @IdEpisodioAtencion bigint ,  
 @IdPaciente int,  
 @EpisodioClinico int,    
 @nombrePaciente varchar(100),  
 @Accion varchar(30)  
   
AS  
BEGIN  				
	
	IF @Accion ='REPORTEA'  
	  BEGIN  
		Select * From   rptViewSolicitarReferencias
		Where 
		IdPaciente = @IdPaciente
		and EpisodioClinico = @EpisodioClinico 
		and IdEpisodioAtencion = @IdEpisodioAtencion  
		and UnidadReplicacion = @UnidadReplicacion  
	  END  
END
GO

/****** Object:  StoredProcedure [dbo].[SNp_SS_HC_EpisodioAtencionFormatoInsertar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SNp_SS_HC_EpisodioAtencionFormatoInsertar]
(
   @pReplicacion char(4),
   @pAtencion bigint,
   @pPaciente int,
   @pClinico int,
   @pTransID int,  
   @pIdSecuencia smallint,
   @pIdOpcion int,
   @pIdForm int,
   @pUsuario varchar(25)
)
As
Begin
   Set NoCount On

   If (Select Count(*) 
       From SS_HC_EpisodioAtencionFormato 
       Where IdEpisodioAtencion = @pAtencion And 
             IdPaciente = @pPaciente And 
             EpisodioClinico = @pClinico And 
             IdForm = @pIdForm And
             IdTransacciones = @pTransID) > 0
   Begin
      Update SS_HC_EpisodioAtencionFormato
      Set IdSecuencia = @pIdSecuencia,
          UsuarioModificacion = @pUsuario,
          FechaModificacion = GetDate()
      Where IdEpisodioAtencion = @pAtencion And 
            IdPaciente = @pPaciente And 
            EpisodioClinico = @pClinico And 
            IdForm = @pIdForm And
            IdTransacciones = @pTransID
   End
   Else
   Begin
      Insert Into SS_HC_EpisodioAtencionFormato
      (
         UnidadReplicacion, IdEpisodioAtencion, IdPaciente, EpisodioClinico, IdTransacciones, 
         IdOpcion, IdForm, ConceptoFormulario, Estado, UsuarioCreacion, FechaCreacion, 
         UsuarioModificacion, FechaModificacion, IdSecuencia
      )
      Select @pReplicacion, @pAtencion, @pPaciente, @pClinico, @pTransID, 
             @pIdOpcion, @pIdForm, Null, 2, @pUsuario, GetDate(), @pUsuario, GetDate(), @pIdSecuencia
   End

   Set NoCount Off
End
GO
/****** Object:  StoredProcedure [dbo].[SP_Alergia_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_Alergia_FE]  
 @UnidadReplicacion char(4),  
 @IdEpisodioAtencion bigint ,  
 @IdPaciente int,  
 @EpisodioClinico int,   
 @TieneHistoria char(1),  
 @IdFormaInicio int,  
 @IdCursoEnfermedad int,  
 @Estado int,  
 @UsuarioCreacion varchar(25),  
 @FechaCreacion datetime,  
 @UsuarioModificacion varchar(25),  
 @FechaModificacion datetime,   
 @IdMedicamento VARCHAR(25), 
 @Linea char(6), 
 @Familia char(6), 
 @SubFamilia char(6),
 @IdTipoAlergia int,
 @ACCION varchar(50),  
 @DesdeCuandoDet varchar(75),
 @EstudioAlegistaDet int,
 @ObservacionesDet VARCHAR(50),
 @TipoRegistroDet char(2),
 @DescripcionManualDet varchar(50)
   
AS  
BEGIN  
 SET NOCOUNT ON;  
  
 DECLARE @IdEpisodioAtencionId as INTEGER, 
 @ExisteCodigo as VARCHAR(10),
 @SecuenciaID as integer  
 set @IdEpisodioAtencionId = @IdEpisodioAtencion  


  IF @ACCION ='UPDATE'  -- Actualizar CABECERA
  BEGIN  
   update SS_HC_Alergia_FE set   
   	 IdMedicamento=@IdMedicamento,
	 TieneHistoria=@TieneHistoria, 	       
     IdFormaInicio=@IdFormaInicio, 
	 IdCursoEnfermedad=@IdCursoEnfermedad,        
	 UsuarioCreacion =@UsuarioCreacion,
	 UsuarioModificacion=@UsuarioModificacion,   
     FechaModificacion=@FechaModificacion,
	 FechaCreacion=@FechaCreacion,
	 Accion = 'UPDATE',
	 Version ='CCEP00F2'
   where   
   IdEpisodioAtencion=@IdEpisodioAtencion  
   and  EpisodioClinico =@EpisodioClinico    
   and  IdPaciente =@IdPaciente  
   
   select @IdEpisodioAtencionId;  
  END  

  IF @ACCION ='NUEVO'  -- Insertar Cabecera
  BEGIN  
    insert into SS_HC_Alergia_FE(UnidadReplicacion, IdEpisodioAtencion,   
    IdPaciente, EpisodioClinico,   	TieneHistoria,UsuarioCreacion,
    FechaCreacion, UsuarioModificacion,  FechaModificacion,   Accion, Version)  
   values (@UnidadReplicacion, @IdEpisodioAtencion,   
    @IdPaciente, @EpisodioClinico,   	@TieneHistoria,	
	@UsuarioCreacion,      GETDATE(), @UsuarioModificacion, GETDATE(), 
	'NUEVO','CCEP00F2')  
     
   select @IdEpisodioAtencionId;  
     
  END  

 IF @ACCION ='UPDATEDETALLE'  --Actualizar DETALLE
  BEGIN          

   	UPDATE SS_HC_AlergiaDetalle_FE
	SET 
		IdTipoAlergia=@IdTipoAlergia,
		CodigoComponente =@IdMedicamento,
		Linea=@Linea, Familia=@Familia, SubFamilia=@SubFamilia,												
		DesdeCuando=@DesdeCuandoDet , EstudioAlegista=@EstudioAlegistaDet , 
		Observaciones=RTRIM(@ObservacionesDet),						
		UsuarioModificacion = @UsuarioModificacion,						
		FechaModificacion = getdate(),
		DescripcionManual = @DescripcionManualDet,
		Accion = 'UPDATE',
	    Version ='CCEP00F2'
	Where	
	UnidadReplicacion = @UnidadReplicacion
	and		IdEpisodioAtencion = @IdEpisodioAtencion
	and IdPaciente =@IdPaciente 
	and		EpisodioClinico = @EpisodioClinico
	and Secuencia = @IdFormaInicio				

	select @IdEpisodioAtencionId;

  END  
  
  IF @ACCION ='DETALLE'  --Insertar DETALLE
  BEGIN  

   select @SecuenciaID = ISNULL(max(Secuencia),0)+1   
     from SS_HC_AlergiaDetalle_FE             
  
   insert into SS_HC_AlergiaDetalle_FE( UnidadReplicacion, IdEpisodioAtencion, IdPaciente,   
    EpisodioClinico, Secuencia, IdCIAP2, CodigoComponente, Linea, Familia, SubFamilia,
	UsuarioCreacion, FechaCreacion, UsuarioModificacion,  FechaModificacion, IdTipoAlergia,
	DesdeCuando , EstudioAlegista , Observaciones, TipoRegistro, DescripcionManual, Accion, Version
	)  
   values (@UnidadReplicacion, @IdEpisodioAtencion, @IdPaciente,   
    @EpisodioClinico, @SecuenciaID, @IdCursoEnfermedad,  @IdMedicamento, @Linea, @Familia, @SubFamilia,
	@UsuarioCreacion, GETDATE(), @UsuarioModificacion, GETDATE(), @IdTipoAlergia,
	@DesdeCuandoDet , @EstudioAlegistaDet , RTRIM(@ObservacionesDet), @TipoRegistroDet, @DescripcionManualDet, 'NUEVO', 'CCEP00F2'
	)  
      
   select @IdEpisodioAtencionId;  
      
  END   
  
  IF @ACCION ='DELETEDETALLE'  --Borrar DETALLE
  BEGIN  
    
	DELETE SS_HC_AlergiaDetalle_FE   
   where 
	   IdPaciente =@IdPaciente  
	   AND  EpisodioClinico = @EpisodioClinico  
	   AND  IdEpisodioAtencion=@IdEpisodioAtencion  
	   AND  Secuencia = @IdFormaInicio  
 
   select @IdEpisodioAtencionId;     
  END      
   
END     
   
GO
/****** Object:  StoredProcedure [dbo].[SP_Alergia_FE_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[SP_Alergia_FE_Listar]  
 @UnidadReplicacion char(4),  
 @IdEpisodioAtencion bigint ,  
 @IdPaciente int,  
 @EpisodioClinico int, 
 @TieneHistoria	char(1),   
 @IdFormaInicio int,  
 @IdCursoEnfermedad int,  
 @Estado int,  
 @UsuarioCreacion varchar(25),  
 @FechaCreacion datetime,  
 @UsuarioModificacion varchar(25),  
 @FechaModificacion datetime,  
 @ComentarioAdicional varchar(500),
 @Prioridad VARCHAR(20),
 @IdMedicamento	varchar(25),
 @ACCION varchar(50)  
   
AS  
BEGIN  
 SET NOCOUNT ON;  
  
 DECLARE @IdEpisodioAtencionId as INTEGER, @ExisteCodigo as VARCHAR(10) 
  
 IF @ACCION ='LISTAR'  
  BEGIN  
    Select * From   dbo.SS_HC_Alergia_FE   
    Where IdPaciente = @IdPaciente   
    and EpisodioClinico = @EpisodioClinico  
    and IdEpisodioAtencion = @IdEpisodioAtencion  
    and UnidadReplicacion = @UnidadReplicacion  
  END  
  IF @ACCION ='LISTARTOP'  
  BEGIN  
    Select TOP 1 * From   dbo.SS_HC_Alergia_FE   
    Where IdPaciente = @IdPaciente   
    and UnidadReplicacion = @UnidadReplicacion  
    ORDER BY EpisodioClinico DESC, IdEpisodioAtencion DESC
  END  
  IF @ACCION ='ALERGIATOP'  
  BEGIN  
    Select TOP 1 * From   dbo.SS_HC_Alergia_FE   
    Where IdPaciente = @IdPaciente   
    and UnidadReplicacion = @UnidadReplicacion  
    ORDER BY EpisodioClinico DESC, IdEpisodioAtencion DESC
  END 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Anam_AP_PatologicosGeneralesDetalleListar_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_Anam_AP_PatologicosGeneralesDetalleListar_FE]
@UnidadReplicacion		CHAR(4),
@IdEpisodioAtencion		bigint,
@IdPaciente				int,
@EpisodioClinico		int,
@Accion		varchar(25)

AS 
  BEGIN 
   IF ( @Accion = 'LISTAR' ) 
        BEGIN 
            SELECT   *
            FROM   SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE 
            WHERE  ( UnidadReplicacion = @UnidadReplicacion ) 
					AND ( IdEpisodioAtencion =@IdEpisodioAtencion) 
					AND (IdPaciente	=@IdPaciente )
					and (EpisodioClinico = @EpisodioClinico )
        END 
  END 
GO
/****** Object:  StoredProcedure [dbo].[SP_Anam_AP_PatologicosGeneralesListar_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[SP_Anam_AP_PatologicosGeneralesListar_FE]
	@UnidadReplicacion char(4),
	@IdEpisodioAtencion  bigint ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@CodigoSecuencia int ,
	
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
				SELECT * FROM  SS_HC_Anam_AP_PatologicosGenerales_FE  
				Where	IdPaciente =@IdPaciente 
				and		EpisodioClinico = @EpisodioClinico
				and		IdEpisodioAtencion = @IdEpisodioAtencion
				and		UnidadReplicacion = @UnidadReplicacion 
 
			END
			IF @Accion ='LISTARTOP'
			BEGIN
				SELECT TOP 1 * FROM  SS_HC_Anam_AP_PatologicosGenerales_FE  
				Where	IdPaciente =@IdPaciente 
				and		UnidadReplicacion = @UnidadReplicacion 
				ORDER BY EpisodioClinico DESC, IdEpisodioAtencion DESC
			END
	 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Anamnesis_AP]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
EXEC SP_LISTARSERVICIOS,'CCEP0003',	,,	,	,	,	,	,	,	,	,	,	,	'TITULO_FORM'
EXEC SP_LISTARSERVICIOS,	'REG0000',	,	'CCEP0003',	,	,	,	,	,	,	,	,	,	,	'NIVEL0'
*/
CREATE OR ALTER PROCEDURE  [dbo].[SP_Anamnesis_AP]
	@UnidadReplicacion char(4),
	@IdEpisodioAtencion bigint ,
	@IdPaciente int,
	@EpisodioClinico int,
	@IdTipoEmbarazo smallint ,
	@PatologiaGestacion varchar(200) ,
	@IdControlPrenatal smallint , 
	@CPnumeroControles smallint , 
	@CPnumeroEmbarazos smallint , 
	@LugarControl varchar(200) ,
	@IdTipoParto smallint , 
	@ComplicacionesParto text , 
	@IdLugarParto smallint , 
	@IdPartoAtendidoPor smallint , 
	@AntecentesPatologicos text , 
	@SemanasGestacionNacer smallint , 
	@PesoAlNacerGR int , 
	@TallaAlNacerCM money , 
	@PerimetroCefalicoCM money , 
	@PatologiasPernatales text , 
	@DiasHospitalizacion smallint , 
	@IdTipoLecheHasta6meses smallint , 
	@AntecLactancia varchar(200) ,
	@EdadInicioAblactanciaMeses smallint , 
	@DesarrolloSicomotriz varchar(200) ,
	@FechaUltimaRegla datetime , 
	@FechaUltimoPeriodo datetime , 
	@MetodosAnticonceptivos varchar(200) ,
	@Menarquia varchar(200) ,
	@Menopausia varchar(200) ,
	@CaracteristicasMenstruaciones varchar(200) ,
	@InformacionEmbarazos varchar(200) ,
	@Transfusiones varchar(200) ,
	@DeinmunizFechaAproximada datetime , 
	@DeinmunizEdadAproximada int , 
	@Alcohol varchar(200) ,
	@Tabaco varchar(200) ,
	@Drogas varchar(200) ,
	@ActividadFisica varchar(200) ,
	@ConsumoVerduras varchar(200) ,
	@ConsumoFrutas varchar(200) ,
	@Medicamentos varchar(200) ,
	@Alimentos varchar(200) ,
	@SustanciasEnElAmbiente varchar(200) ,
	@SustanciasContactoConPiel varchar(200) ,
	@ContactoPersonaEnferma varchar(200) ,
	@CrianzaAnimalesDomesticos varchar(200) ,
	@AguaPotable varchar(200) ,
	@DisposicionExcretas varchar(200) ,
	@ReaccionAdversaMedicamentos varchar(200) ,
	@SaludBucal varchar(200) ,
	@VigilanciaDeCrecimiento varchar(200) ,
	@VigilanciaDelDesarrollo varchar(200) ,
	@IdValoracionFuncional1 smallint , 
	@IdValoracionFuncional2 smallint , 
	@IdValoracionFuncional3 smallint , 
	@IdValoracionFuncional4 smallint , 
	@IdValoracionFuncional5 smallint , 
	@IdValoracionFuncional6 smallint , 
	@DiagnosticoFuncional smallint , 
	@IdEstadoCognitivo1 smallint , 
	@IdEstadoCognitivo2 smallint , 
	@IdEstadoCognitivo3 smallint , 
	@IdEstadoCognitivo4 smallint , 
	@IdEstadoCognitivo5 smallint , 
	@IdEstadoCognitivo6 smallint , 
	@IdEstadoCognitivo7 smallint , 
	@IdEstadoCognitivo8 smallint , 
	@IdEstadoCognitivo9 smallint , 
	@IdEstadoCognitivo10 smallint , 
	@ValoracionCognitiva smallint , 
	@IdEstadoAfectivo1 smallint , 
	@IdEstadoAfectivo2 smallint , 
	@IdEstadoAfectivo3 smallint , 
	@IdEstadoAfectivo4 smallint , 
	@ConManifestacionesDepresivas smallint , 
	@ValoracionSocioFamiliar1 smallint , 
	@ValoracionSocioFamiliar2 smallint , 
	@ValoracionSocioFamiliar3 smallint , 
	@ValoracionSocioFamiliar4 smallint , 
	@ValoracionSocioFamiliar5 smallint , 
	@ValoracionSocioFamiliar smallint , 
	@IdCategoriaAdutoMayor smallint , 
	@Estado smallint , 
	@UsuarioCreacion varchar(25) ,
	@FechaCreacion datetime , 
	@UsuarioModificacion varchar(25) ,
    @FechaModificacion datetime ,
    @Accion varchar(50)
	
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @IdEpisodioAtencionId as INTEGER,
	 @EpisodioClinicoID as INTEGER, @ExisteCodigo as VARCHAR(10),
	 @SecuenciaID as Integer
	 
	 set @IdEpisodioAtencionId = @IdEpisodioAtencion
	 
	 IF @Accion = 'FINALIZAATENCION'
		BEGIN
			Update SS_HC_EpisodioAtencion set Estado = 3 
			 Where IdEpisodioAtencion = @IdEpisodioAtencion
				 And	EpisodioClinico =@EpisodioClinico
				 And	IdPaciente =@IdPaciente
				 And	CodigoOA =@PatologiaGestacion
			select @IdEpisodioAtencionId;				 
		END
	ELSE
	 IF @Accion = 'EPISODIOCLINICO'
		BEGIN
			select @EpisodioClinicoID = ISNULL(max(EpisodioClinico),0)+1 
				 from dbo.SS_HC_EpisodioClinico 
				 where  IdPaciente = @IdPaciente 
			 Insert into dbo.SS_HC_EpisodioClinico(UnidadReplicacion, IdPaciente, EpisodioClinico, 
				 FechaRegistro,   Estado, UsuarioCreacion, FechaCreacion, UsuarioModificacion, 
				 FechaModificacion)
				 values (@UnidadReplicacion, @IdPaciente, @EpisodioClinicoID, 
				 GETDATE(), 2, @UsuarioCreacion, GETDATE(), @UsuarioModificacion,
				 GETDATE())
			select @EpisodioClinicoID;				 
		END
		ELSE		
	 IF @Accion = 'EPISODIOATENCION'
		BEGIN
		
		  select @IdEpisodioAtencionId = ISNULL(max(IdEpisodioAtencion),0)+1 
			  from dbo.SS_HC_EpisodioAtencion 
			  where UnidadReplicacion = @UnidadReplicacion and EpisodioClinico =@EpisodioClinico
			  and IdPaciente = @IdPaciente 

			insert into dbo.SS_HC_EpisodioAtencion 
				(UnidadReplicacion, IdEpisodioAtencion, UnidadReplicacionEC, 
				IdPaciente, EpisodioClinico, IdEstablecimientoSalud, IdUnidadServicio, IdPersonalSalud, 
				 EpisodioAtencion, FechaRegistro, FechaAtencion, TipoAtencion, IdOrdenAtencion, 
				LineaOrdenAtencion, TipoOrdenAtencion, Estado, UsuarioCreacion, FechaCreacion, 
				UsuarioModificacion, FechaModificacion, CodigoOA
				
				)
				values 
				(@UnidadReplicacion,@IdEpisodioAtencionId, @UnidadReplicacion,
				@IdPaciente,@EpisodioClinico,1,null,2,
				 1,GETDATE(),GETDATE(),1,convert(int,@IdEstadoAfectivo1),
				1,1,2,@UsuarioCreacion,GETDATE(),
				@UsuarioCreacion ,GETDATE(),@PatologiaGestacion 
				
				)
			select @IdEpisodioAtencionId;				 
		END		
		ELSE		
	 IF @Accion = 'NUEVO'
		BEGIN		
		
			Insert into SS_HC_Anamnesis_AP (UnidadReplicacion, IdEpisodioAtencion, 
				IdPaciente, EpisodioClinico,
				IdTipoEmbarazo, PatologiaGestacion, 
				IdControlPrenatal, CPnumeroControles, CPnumeroEmbarazos, LugarControl, IdTipoParto, ComplicacionesParto, 
				IdLugarParto, IdPartoAtendidoPor, AntecentesPatologicos, SemanasGestacionNacer, PesoAlNacerGR, TallaAlNacerCM, 
				PerimetroCefalicoCM, PatologiasPernatales, DiasHospitalizacion, IdTipoLecheHasta6meses, AntecLactancia, 
				EdadInicioAblactanciaMeses, DesarrolloSicomotriz, FechaUltimaRegla, FechaUltimoPeriodo, MetodosAnticonceptivos, 
				Menarquia, Menopausia, CaracteristicasMenstruaciones, InformacionEmbarazos, Transfusiones, 
				DeinmunizFechaAproximada, DeinmunizEdadAproximada, Alcohol, Tabaco, Drogas, ActividadFisica, 
				ConsumoVerduras, ConsumoFrutas, Medicamentos, Alimentos, SustanciasEnElAmbiente, SustanciasContactoConPiel, 
				ContactoPersonaEnferma, CrianzaAnimalesDomesticos, AguaPotable,	DisposicionExcretas, ReaccionAdversaMedicamentos, 
				SaludBucal, VigilanciaDeCrecimiento, VigilanciaDelDesarrollo, IdValoracionFuncional1, IdValoracionFuncional2, 
				IdValoracionFuncional3, IdValoracionFuncional4, IdValoracionFuncional5, IdValoracionFuncional6, DiagnosticoFuncional, 
				IdEstadoCognitivo1, IdEstadoCognitivo2, IdEstadoCognitivo3, IdEstadoCognitivo4, IdEstadoCognitivo5, IdEstadoCognitivo6, 
				IdEstadoCognitivo7, IdEstadoCognitivo8, IdEstadoCognitivo9, IdEstadoCognitivo10, ValoracionCognitiva, IdEstadoAfectivo1, 
				IdEstadoAfectivo2, IdEstadoAfectivo3, IdEstadoAfectivo4, ConManifestacionesDepresivas, ValoracionSocioFamiliar1, 
				ValoracionSocioFamiliar2, ValoracionSocioFamiliar3, ValoracionSocioFamiliar4, ValoracionSocioFamiliar5, 
				ValoracionSocioFamiliar, IdCategoriaAdutoMayor, Estado, UsuarioCreacion, FechaCreacion, UsuarioModificacion, 
				FechaModificacion, Accion)
			values (@UnidadReplicacion, @IdEpisodioAtencion, 
				@IdPaciente, @EpisodioClinico,
				@IdTipoEmbarazo, @PatologiaGestacion, 
				@IdControlPrenatal, @CPnumeroControles, @CPnumeroEmbarazos, @LugarControl, @IdTipoParto, @ComplicacionesParto, 
				@IdLugarParto, @IdPartoAtendidoPor, @AntecentesPatologicos, @SemanasGestacionNacer, @PesoAlNacerGR, @TallaAlNacerCM, 
				@PerimetroCefalicoCM, @PatologiasPernatales, @DiasHospitalizacion, @IdTipoLecheHasta6meses, @AntecLactancia, 
				@EdadInicioAblactanciaMeses, @DesarrolloSicomotriz, @FechaUltimaRegla, @FechaUltimoPeriodo, @MetodosAnticonceptivos, 
				@Menarquia, @Menopausia, @CaracteristicasMenstruaciones, @InformacionEmbarazos, @Transfusiones,
				@DeinmunizFechaAproximada, @DeinmunizEdadAproximada, @Alcohol, @Tabaco, @Drogas, @ActividadFisica, 
				@ConsumoVerduras, @ConsumoFrutas, @Medicamentos, @Alimentos, @SustanciasEnElAmbiente, @SustanciasContactoConPiel, 
				@ContactoPersonaEnferma, @CrianzaAnimalesDomesticos, @AguaPotable, @DisposicionExcretas, @ReaccionAdversaMedicamentos, 
				@SaludBucal, @VigilanciaDeCrecimiento, @VigilanciaDelDesarrollo, @IdValoracionFuncional1, @IdValoracionFuncional2, 
				@IdValoracionFuncional3, @IdValoracionFuncional4, @IdValoracionFuncional5, @IdValoracionFuncional6, @DiagnosticoFuncional, 
				@IdEstadoCognitivo1, @IdEstadoCognitivo2, @IdEstadoCognitivo3, @IdEstadoCognitivo4, @IdEstadoCognitivo5, @IdEstadoCognitivo6,
				 @IdEstadoCognitivo7, @IdEstadoCognitivo8, @IdEstadoCognitivo9, @IdEstadoCognitivo10, @ValoracionCognitiva, @IdEstadoAfectivo1, 
				 @IdEstadoAfectivo2, @IdEstadoAfectivo3, @IdEstadoAfectivo4, @ConManifestacionesDepresivas, @ValoracionSocioFamiliar1, 
				 @ValoracionSocioFamiliar2, @ValoracionSocioFamiliar3, @ValoracionSocioFamiliar4, @ValoracionSocioFamiliar5, 
				 @ValoracionSocioFamiliar, @IdCategoriaAdutoMayor, @Estado, @UsuarioCreacion, GETDATE(), @UsuarioModificacion, 
				 GETDATE(),'CCEP0004'--ADD
				 )
			select @IdEpisodioAtencionId;		
		END
		ELSE
		IF @Accion ='UPDATE'
			BEGIN
				update  SS_HC_Anamnesis_AP set	UnidadReplicacion=@UnidadReplicacion,  
						IdTipoEmbarazo=@IdTipoEmbarazo, PatologiaGestacion=@PatologiaGestacion, IdControlPrenatal=@IdControlPrenatal, 
						CPnumeroControles=@CPnumeroControles, CPnumeroEmbarazos=@CPnumeroEmbarazos, LugarControl=@LugarControl, 
						IdTipoParto=@IdTipoParto, ComplicacionesParto=@ComplicacionesParto, IdLugarParto=@IdLugarParto, 
						IdPartoAtendidoPor=@IdPartoAtendidoPor, AntecentesPatologicos=@AntecentesPatologicos, 
						SemanasGestacionNacer=@SemanasGestacionNacer, PesoAlNacerGR=@PesoAlNacerGR, TallaAlNacerCM=@TallaAlNacerCM, 
						PerimetroCefalicoCM=@PerimetroCefalicoCM, PatologiasPernatales=@PatologiasPernatales, DiasHospitalizacion=@DiasHospitalizacion, 
						IdTipoLecheHasta6meses=@IdTipoLecheHasta6meses, AntecLactancia=@AntecLactancia, 
						EdadInicioAblactanciaMeses=@EdadInicioAblactanciaMeses, DesarrolloSicomotriz=@DesarrolloSicomotriz, 
						FechaUltimaRegla=@FechaUltimaRegla, FechaUltimoPeriodo=@FechaUltimoPeriodo, MetodosAnticonceptivos=@MetodosAnticonceptivos, 
						Menarquia=@Menarquia, Menopausia=@Menopausia, CaracteristicasMenstruaciones=@CaracteristicasMenstruaciones, 
						InformacionEmbarazos=@InformacionEmbarazos, Transfusiones=@Transfusiones, DeinmunizFechaAproximada=@DeinmunizFechaAproximada, 
						DeinmunizEdadAproximada=@DeinmunizEdadAproximada, Alcohol=@Alcohol, Tabaco=@Tabaco, Drogas=@Drogas, 
						ActividadFisica=@ActividadFisica, ConsumoVerduras=@ConsumoVerduras, ConsumoFrutas=@ConsumoFrutas, Medicamentos=@Medicamentos, 
						Alimentos=@Alimentos, SustanciasEnElAmbiente=@SustanciasEnElAmbiente, SustanciasContactoConPiel=@SustanciasContactoConPiel, 
						ContactoPersonaEnferma=@ContactoPersonaEnferma, CrianzaAnimalesDomesticos=@CrianzaAnimalesDomesticos, 
						AguaPotable=@AguaPotable,	DisposicionExcretas=@DisposicionExcretas, ReaccionAdversaMedicamentos=@ReaccionAdversaMedicamentos, 
						SaludBucal=@SaludBucal, VigilanciaDeCrecimiento=@VigilanciaDeCrecimiento, VigilanciaDelDesarrollo=@VigilanciaDelDesarrollo, 
						IdValoracionFuncional1=@IdValoracionFuncional1, IdValoracionFuncional2=@IdValoracionFuncional2, 
						IdValoracionFuncional3=@IdValoracionFuncional3, IdValoracionFuncional4=@IdValoracionFuncional4, 
						IdValoracionFuncional5=@IdValoracionFuncional5, IdValoracionFuncional6=@IdValoracionFuncional6, 
						DiagnosticoFuncional=@DiagnosticoFuncional, IdEstadoCognitivo1=@IdEstadoCognitivo1, IdEstadoCognitivo2=@IdEstadoCognitivo2, 
						IdEstadoCognitivo3=@IdEstadoCognitivo3, IdEstadoCognitivo4=@IdEstadoCognitivo4, IdEstadoCognitivo5=@IdEstadoCognitivo5, 
						IdEstadoCognitivo6=@IdEstadoCognitivo6, IdEstadoCognitivo7=@IdEstadoCognitivo7, IdEstadoCognitivo8=@IdEstadoCognitivo8, 
						IdEstadoCognitivo9=@IdEstadoCognitivo9, IdEstadoCognitivo10=@IdEstadoCognitivo10, ValoracionCognitiva=@ValoracionCognitiva, 
						IdEstadoAfectivo1=@IdEstadoAfectivo1, IdEstadoAfectivo2=@IdEstadoAfectivo2, IdEstadoAfectivo3=@IdEstadoAfectivo3, 
						IdEstadoAfectivo4=@IdEstadoAfectivo4, ConManifestacionesDepresivas=@ConManifestacionesDepresivas, 
						ValoracionSocioFamiliar1=@ValoracionSocioFamiliar1, ValoracionSocioFamiliar2=@ValoracionSocioFamiliar2, 
						ValoracionSocioFamiliar3=@ValoracionSocioFamiliar3, ValoracionSocioFamiliar4=@ValoracionSocioFamiliar4, 
						ValoracionSocioFamiliar5=@ValoracionSocioFamiliar5, ValoracionSocioFamiliar=@ValoracionSocioFamiliar, 
						IdCategoriaAdutoMayor=@IdCategoriaAdutoMayor, Estado=@Estado, UsuarioCreacion=@UsuarioCreacion,
						 FechaCreacion=@FechaCreacion, UsuarioModificacion=@UsuarioModificacion, FechaModificacion=@FechaModificacion, Accion='CCEP0004'--ADD
				 Where  IdEpisodioAtencion = @IdEpisodioAtencion
				 And	EpisodioClinico =@EpisodioClinico
				 And	IdPaciente =@IdPaciente

				set @IdEpisodioAtencionId = @IdEpisodioAtencion
				select @IdEpisodioAtencionId;	
			END
		ELSE	
		IF @ACCION ='DETALLE'
			BEGIN 
                                    
				Select @SecuenciaID =  ISNULL(max(Secuencia),0)+1 from dbo.SS_HC_Anamnesis_AP_Detalle
				Insert Into SS_HC_Anamnesis_AP_Detalle(UnidadReplicacion, IdEpisodioAtencion, 
					IdPaciente, EpisodioClinico, TipoRegistro, 
					Secuencia, 
					Fecha, IdTabla, IdTipoAlergia, 
					Nombre, Lugar, Dosis, Observaciones, Estado, UsuarioCreacion, 
					FechaCreacion, UsuarioModificacion, FechaModificacion)
				  values(@UnidadReplicacion, @IdEpisodioAtencion, 
						 @IdPaciente, @EpisodioClinico, @LugarControl,--TIPOTREGISTRO
						 @SecuenciaID, 
						 @FechaUltimoPeriodo, @IdEstadoCognitivo1, @IdEstadoCognitivo2, 
						 @Alcohol, @Tabaco, @Drogas,@Alimentos, 2, @UsuarioCreacion, 
						 GETDATE(), @UsuarioModificacion, GETDATE())
				select   @SecuenciaID;
		
			END	
			ELSE				
		IF @ACCION ='UPDATEDETALLE'
			BEGIN 		
				update SS_HC_Anamnesis_AP_Detalle
				set 
				Fecha = @FechaUltimoPeriodo, 
				IdTabla = @IdEstadoCognitivo1, 
				IdTipoAlergia = @IdEstadoCognitivo2, 				
				Nombre = @Alcohol, 
				Lugar = @Tabaco, 
				Dosis = @Drogas, 
				Observaciones = @Alimentos, 
				Estado = 2, 
				UsuarioCreacion = @UsuarioCreacion, 				
				UsuarioModificacion = @UsuarioModificacion, 
				FechaModificacion = GETDATE()	
				 Where  
				 UnidadReplicacion = @UnidadReplicacion
				 AND IdEpisodioAtencion = @IdEpisodioAtencion
				 And	EpisodioClinico =@EpisodioClinico
				 And	IdPaciente =@IdPaciente
				 And Secuencia = @DeinmunizEdadAproximada

				
				
				select @DeinmunizEdadAproximada --AUX SECUENCIA
			end
		IF @ACCION ='DELETEDETALLE'
			BEGIN 		
				delete SS_HC_Anamnesis_AP_Detalle
				 Where  
				 UnidadReplicacion = @UnidadReplicacion
				 AND IdEpisodioAtencion = @IdEpisodioAtencion
				 And	EpisodioClinico =@EpisodioClinico
				 And	IdPaciente =@IdPaciente
				 And Secuencia = @DeinmunizEdadAproximada
				
				select @DeinmunizEdadAproximada--AUX SECUENCIA 
			end			

END
			 
GO
/****** Object:  StoredProcedure [dbo].[SP_Anamnesis_AP_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
EXEC SP_LISTARSERVICIOS,'CCEP0003',	,,	,	,	,	,	,	,	,	,	,	,	'TITULO_FORM'
EXEC SP_LISTARSERVICIOS,	'REG0000',	,	'CCEP0003',	,	,	,	,	,	,	,	,	,	,	'NIVEL0'
*/
CREATE OR ALTER PROCEDURE  [dbo].[SP_Anamnesis_AP_Listar]
	@UnidadReplicacion char(4),
	@IdEpisodioAtencion bigint ,
	@IdPaciente int,
	@EpisodioClinico int,
	@IdTipoEmbarazo smallint ,
	@PatologiaGestacion varchar(200) ,
	@IdControlPrenatal smallint , 
	@CPnumeroControles smallint , 
	@CPnumeroEmbarazos smallint , 
	@LugarControl varchar(200) ,
	@IdTipoParto smallint , 
	@ComplicacionesParto text , 
	@IdLugarParto smallint , 
	@IdPartoAtendidoPor smallint , 
	@AntecentesPatologicos text , 
	@SemanasGestacionNacer smallint , 
	@PesoAlNacerGR int , 
	@TallaAlNacerCM money , 
	@PerimetroCefalicoCM money , 
	@PatologiasPernatales text , 
	@DiasHospitalizacion smallint , 
	@IdTipoLecheHasta6meses smallint , 
	@AntecLactancia varchar(200) ,
	@EdadInicioAblactanciaMeses smallint , 
	@DesarrolloSicomotriz varchar(200) ,
	@FechaUltimaRegla datetime , 
	@FechaUltimoPeriodo datetime , 
	@MetodosAnticonceptivos varchar(200) ,
	@Menarquia varchar(200) ,
	@Menopausia varchar(200) ,
	@CaracteristicasMenstruaciones varchar(200) ,
	@InformacionEmbarazos varchar(200) ,
	@Transfusiones varchar(200) ,
	@DeinmunizFechaAproximada datetime , 
	@DeinmunizEdadAproximada int , 
	@Alcohol varchar(200) ,
	@Tabaco varchar(200) ,
	@Drogas varchar(200) ,
	@ActividadFisica varchar(200) ,
	@ConsumoVerduras varchar(200) ,
	@ConsumoFrutas varchar(200) ,
	@Medicamentos varchar(200) ,
	@Alimentos varchar(200) ,
	@SustanciasEnElAmbiente varchar(200) ,
	@SustanciasContactoConPiel varchar(200) ,
	@ContactoPersonaEnferma varchar(200) ,
	@CrianzaAnimalesDomesticos varchar(200) ,
	@AguaPotable varchar(200) ,
	@DisposicionExcretas varchar(200) ,
	@ReaccionAdversaMedicamentos varchar(200) ,
	@SaludBucal varchar(200) ,
	@VigilanciaDeCrecimiento varchar(200) ,
	@VigilanciaDelDesarrollo varchar(200) ,
	@IdValoracionFuncional1 smallint , 
	@IdValoracionFuncional2 smallint , 
	@IdValoracionFuncional3 smallint , 
	@IdValoracionFuncional4 smallint , 
	@IdValoracionFuncional5 smallint , 
	@IdValoracionFuncional6 smallint , 
	@DiagnosticoFuncional smallint , 
	@IdEstadoCognitivo1 smallint , 
	@IdEstadoCognitivo2 smallint , 
	@IdEstadoCognitivo3 smallint , 
	@IdEstadoCognitivo4 smallint , 
	@IdEstadoCognitivo5 smallint , 
	@IdEstadoCognitivo6 smallint , 
	@IdEstadoCognitivo7 smallint , 
	@IdEstadoCognitivo8 smallint , 
	@IdEstadoCognitivo9 smallint , 
	@IdEstadoCognitivo10 smallint , 
	@ValoracionCognitiva smallint , 
	@IdEstadoAfectivo1 smallint , 
	@IdEstadoAfectivo2 smallint , 
	@IdEstadoAfectivo3 smallint , 
	@IdEstadoAfectivo4 smallint , 
	@ConManifestacionesDepresivas smallint , 
	@ValoracionSocioFamiliar1 smallint , 
	@ValoracionSocioFamiliar2 smallint , 
	@ValoracionSocioFamiliar3 smallint , 
	@ValoracionSocioFamiliar4 smallint , 
	@ValoracionSocioFamiliar5 smallint , 
	@ValoracionSocioFamiliar smallint , 
	@IdCategoriaAdutoMayor smallint , 
	@Estado smallint , 
	@UsuarioCreacion varchar(25) ,
	@FechaCreacion datetime , 
	@UsuarioModificacion varchar(25) ,
    @FechaModificacion datetime ,
    @Accion varchar(50)
	
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @IdEpisodioAtencionId as INTEGER, @ExisteCodigo as VARCHAR(10)
	 IF @Accion ='LISTAR'
		BEGIN
			Select * From   dbo.SS_HC_Anamnesis_AP Where IdPaciente = @IdPaciente and IdEpisodioAtencion = @IdEpisodioAtencion
		END

	 IF @Accion ='LISTARPORPACIENTE'
		BEGIN
			Select * From   dbo.SS_HC_Anamnesis_AP 
			Where IdPaciente = @IdPaciente 
		END
	 
END
	 
GO
/****** Object:  StoredProcedure [dbo].[SP_Anamnesis_EA]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
EXEC SP_LISTARSERVICIOS,'CCEP0003', NULL,, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'TITULO_FORM'  
EXEC SP_LISTARSERVICIOS, 'REG0000', NULL, 'CCEP0003', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NIVEL0'  
*/  
CREATE OR ALTER PROCEDURE [SP_Anamnesis_EA]  
 @UnidadReplicacion char(4),  
 @IdEpisodioAtencion bigint ,  
 @IdPaciente int,  
 @EpisodioClinico int,  
 @MotivoConsulta varchar(200),  
 @IdFormaInicio int,  
 @IdCursoEnfermedad int,  
 @TiempoEnfermedad varchar(100),  
 @RelatoCronologico text,  
 @Apetito varchar(100),  
 @Sed varchar(100),  
 @Orina varchar(100),  
 @Deposiciones varchar(100),  
 @Sueno varchar(100),  
 @PesoAnterior money,  
 @Infancia varchar(100),  
 @EvaluacionAlimentacionActual varchar(200),  
 @Estado int,  
 @UsuarioCreacion varchar(25),  
 @FechaCreacion datetime,  
 @UsuarioModificacion varchar(25),  
 @FechaModificacion datetime,  
 @ComentarioAdicional varchar(500),
 @Prioridad VARCHAR(20),
 @ACCION varchar(50)  
   
AS  
BEGIN  
 SET NOCOUNT ON;  
  
 DECLARE @IdEpisodioAtencionId as INTEGER, @ExisteCodigo as VARCHAR(10), @SecuenciaID as integer  
 set @IdEpisodioAtencionId = @IdEpisodioAtencion  
  IF @ACCION ='NUEVO'  
  BEGIN  
    insert into SS_HC_Anamnesis_EA(UnidadReplicacion, IdEpisodioAtencion,   
    IdPaciente, EpisodioClinico,   
   IdFormaInicio, IdCursoEnfermedad, TiempoEnfermedad, RelatoCronologico, Apetito,   
   Sed, Orina, Deposiciones, Sueno, PesoAnterior, Infancia, EvaluacionAlimentacionActual,   
   Estado, UsuarioCreacion, FechaCreacion, UsuarioModificacion,   
   FechaModificacion, MotivoConsulta,ComentarioAdicional, Prioridad, Accion)  
   values (@UnidadReplicacion, @IdEpisodioAtencion,   
    @IdPaciente, @EpisodioClinico,    @IdFormaInicio, @IdCursoEnfermedad,  
    @TiempoEnfermedad, @RelatoCronologico, @Apetito, @Sed, @Orina, @Deposiciones, @Sueno,   
    @PesoAnterior, @Infancia, @EvaluacionAlimentacionActual, @Estado, @UsuarioCreacion,  
     GETDATE(), @UsuarioModificacion, GETDATE(), @MotivoConsulta, @ComentarioAdicional, @Prioridad,'CCEP0003')  
     
   select @IdEpisodioAtencionId;  
     
  END  
  IF @ACCION ='DETALLE'  
  BEGIN  
   select @SecuenciaID = ISNULL(max(Secuencia),0)+1   
     from SS_HC_Anamnesis_EA_Sintoma  
           
  
   insert into SS_HC_Anamnesis_EA_Sintoma( UnidadReplicacion, IdEpisodioAtencion, IdPaciente,   
    EpisodioClinico, Secuencia, IdCIAP2)  
   values (@UnidadReplicacion, @IdEpisodioAtencion, @IdPaciente,   
    @EpisodioClinico, @SecuenciaID, @IdCursoEnfermedad)  
      
   select @IdEpisodioAtencionId;  
      
  END   
 IF @ACCION ='UPDATEDETALLE'  
  BEGIN  
     
   select @IdEpisodioAtencionId;     
  END    
  IF @ACCION ='DELETE'  
  BEGIN  
    
   DELETE SS_HC_Anamnesis_EA_Sintoma   
   where IdPaciente =@IdPaciente  
   AND  EpisodioClinico = @EpisodioClinico  
   AND  IdEpisodioAtencion=@IdEpisodioAtencion  
   AND  Secuencia = @IdFormaInicio  

   select @IdEpisodioAtencionId;     
  END   
       
  IF @ACCION ='UPDATE'  
  BEGIN  
   update SS_HC_Anamnesis_EA set   
     MotivoConsulta = @MotivoConsulta,  
     IdFormaInicio=@IdFormaInicio, IdCursoEnfermedad=@IdCursoEnfermedad,   
     TiempoEnfermedad=@TiempoEnfermedad, RelatoCronologico=@RelatoCronologico,   
     Apetito=@Apetito, Sed=@Sed, Orina=@Orina, Deposiciones=@Deposiciones,   
     Sueno=@Sueno, PesoAnterior=@PesoAnterior, Infancia=@Infancia,   
     EvaluacionAlimentacionActual=@EvaluacionAlimentacionActual, 
     UsuarioModificacion=@UsuarioModificacion,   
     FechaModificacion=@FechaModificacion,
     ComentarioAdicional = @ComentarioAdicional,
     Prioridad = @Prioridad
   where   
   IdEpisodioAtencion=@IdEpisodioAtencion  
   and  EpisodioClinico =@EpisodioClinico    
   and  IdPaciente =@IdPaciente  
     
   select @IdEpisodioAtencionId;  
  END      
   
END  
   
GO
/****** Object:  StoredProcedure [dbo].[SP_Anamnesis_EA_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[SP_Anamnesis_EA_Listar]  
 @UnidadReplicacion char(4),  
 @IdEpisodioAtencion bigint ,  
 @IdPaciente int,  
 @EpisodioClinico int,  
 @MotivoConsulta varchar(200),  
 @IdFormaInicio int,  
 @IdCursoEnfermedad int,  
 @TiempoEnfermedad varchar(100),  
 @RelatoCronologico text,  
 @Apetito varchar(100),  
 @Sed varchar(100),  
 @Orina varchar(100),  
 @Deposiciones varchar(100),  
 @Sueno varchar(100),  
 @PesoAnterior money,  
 @Infancia varchar(100),  
 @EvaluacionAlimentacionActual varchar(200),  
 @Estado int,  
 @UsuarioCreacion varchar(25),  
 @FechaCreacion datetime,  
 @UsuarioModificacion varchar(25),  
 @FechaModificacion datetime,  
 @ComentarioAdicional varchar(500),
 @Prioridad VARCHAR(20),
 @ACCION varchar(50)  
   
AS  
BEGIN  
 SET NOCOUNT ON;  
  
 DECLARE @IdEpisodioAtencionId as INTEGER, @ExisteCodigo as VARCHAR(10)  
  IF @ACCION ='LISTAR'  
  BEGIN  
    Select * From   dbo.SS_HC_Anamnesis_EA   
    Where IdPaciente = @IdPaciente   
    and EpisodioClinico = @EpisodioClinico  
    and IdEpisodioAtencion = @IdEpisodioAtencion  
    and UnidadReplicacion = @UnidadReplicacion  
  END  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Anamnesis_EA_Reportes]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[SP_Anamnesis_EA_Reportes]  
 @UnidadReplicacion char(4),  
 @IdEpisodioAtencion bigint ,  
 @IdPaciente int,  
 @EpisodioClinico int,  
 @MotivoConsulta varchar(200),  
 @IdFormaInicio int,  
 @IdCursoEnfermedad int,  
 @Accion varchar(30)  
   
AS  
BEGIN  
	IF @Accion ='REPORTEA'  
	  BEGIN  
		Select * From   rptViewAnamnesisEA   
		Where IdPaciente = @IdPaciente   
		and EpisodioClinico = @EpisodioClinico  
		and IdEpisodioAtencion = @IdEpisodioAtencion  
		and UnidadReplicacion = @UnidadReplicacion  
	  END  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AnamnesisAF]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE OR ALTER PROCEDURE  [dbo].[SP_AnamnesisAF]
	@UnidadReplicacion char(4) ,
	@IdEpisodioAtencion bigint  ,
	@IdPaciente int  ,
	@EpisodioClinico int  ,
	@Secuencia int  ,
	@IdTipoParentesco int  ,
	@Edad int  ,
	@IdVivo int  ,
	@Estado int  ,
	@UsuarioCreacion varchar(25) ,
	@FechaCreacion datetime  ,
	@UsuarioModificacion varchar(200) ,
	@FechaModificacion datetime  ,
	@Accion varchar(25) ,
	@Version varchar(25)
	
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @IdEpisodioAtencionId as INTEGER,@SecuenciaID as INTEGER,
	 @EpisodioClinicoID as INTEGER, @ExisteCodigo as VARCHAR(10)
	 
	 SET @IdEpisodioAtencionId = @IdEpisodioAtencion;
	 
	 IF @Accion = 'NUEVO'
		BEGIN

			INSERT INTO  SS_HC_Anamnesis_AF(UnidadReplicacion, IdEpisodioAtencion, IdPaciente, EpisodioClinico, 
								  IdTipoParentesco, Edad, IdVivo, Estado, UsuarioCreacion, 
								FechaCreacion, UsuarioModificacion, 
								FechaModificacion, Accion, Version)
			VALUES(@UnidadReplicacion,	@IdEpisodioAtencionId,	@IdPaciente, 	@EpisodioClinico,	
								 	@IdTipoParentesco,	@Edad,	@IdVivo,	@Estado,	@UsuarioCreacion,	
								@FechaCreacion,	@UsuarioModificacion,	
								@FechaModificacion,	'CCEP0005',	@Version)

			select @IdEpisodioAtencionId;
		END

	 IF @Accion = 'UPDATE'
		BEGIN		 
					update SS_HC_Anamnesis_AF
					set 
					IdTipoParentesco = @IdTipoParentesco,
					Edad = @Edad,
					IdVivo = @IdVivo,
					UsuarioModificacion = @UsuarioModificacion,
					FechaModificacion = @FechaModificacion
					Where	IdPaciente =@IdPaciente
					and		EpisodioClinico =@EpisodioClinico
					and		IdEpisodioAtencion = @IdEpisodioAtencion
				 
			select @IdEpisodioAtencionId;
		END
 	
		IF @Accion ='UPDATEDETALLE'
			BEGIN
				update SS_HC_Anamnesis_AF_Enfermedad
				set IdDiagnostico = @IdTipoParentesco, Observaciones = @UsuarioModificacion
				where	IdPaciente =@IdPaciente
				AND		EpisodioClinico = @EpisodioClinico
				AND		IdEpisodioAtencion=@IdEpisodioAtencion
				and		Secuencia = @Secuencia

				select @IdEpisodioAtencionId

			END

		IF @Accion ='DETALLE'
			BEGIN
			select @SecuenciaID = ISNULL(max(Secuencia),0)+1  from SS_HC_Anamnesis_AF_Enfermedad
			 Insert into dbo.SS_HC_Anamnesis_AF_Enfermedad(UnidadReplicacion, IdPaciente, 
					 EpisodioClinico, IdEpisodioAtencion, 
					 Secuencia, IdDiagnostico, Observaciones )
			values(@UnidadReplicacion,	@IdPaciente, 
					@EpisodioClinico, @IdEpisodioAtencionId, 
					 @SecuenciaID,	@IdTipoParentesco,	@UsuarioModificacion)	 

			select @IdEpisodioAtencionId;

			END
 
		 IF @ACCION ='DELETE'
			BEGIN
		 
			 DELETE SS_HC_Anamnesis_AF_Enfermedad 
			where		
				UnidadReplicacion= @UnidadReplicacion
				AND  IdPaciente =@IdPaciente
				AND		EpisodioClinico = @EpisodioClinico
				AND		IdEpisodioAtencion=@IdEpisodioAtencion
				and		Secuencia = @Secuencia
				and		IdDiagnostico = @IdTipoParentesco
				
				select @IdEpisodioAtencionId;
			END				
END


GO
/****** Object:  StoredProcedure [dbo].[SP_AnamnesisAF_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE  [dbo].[SP_AnamnesisAF_FE]
	@UnidadReplicacion char(4) ,
	@IdEpisodioAtencion bigint  ,
	@IdPaciente int  ,
	@EpisodioClinico int  ,
	@Secuencia int  ,
	@IdTipoParentesco int  ,
	@Edad int  ,
	@IdVivo int  ,
	@Estado int  ,
	@UsuarioCreacion varchar(25) ,
	@FechaCreacion datetime  ,
	@UsuarioModificacion varchar(200) ,
	@FechaModificacion datetime  ,
	@Accion varchar(25) ,
	@Version varchar(25)
	
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @IdEpisodioAtencionId as INTEGER,@SecuenciaID as INTEGER,
	 @EpisodioClinicoID as INTEGER, @ExisteCodigo as VARCHAR(10)
	 
	 SET @IdEpisodioAtencionId = @IdEpisodioAtencion;
	 
	 IF @Accion = 'NUEVO'
		BEGIN

				INSERT INTO  SS_HC_Anamnesis_AF_FE(UnidadReplicacion, IdEpisodioAtencion, IdPaciente, EpisodioClinico, 
								  IdTipoParentesco, Edad, IdVivo, Estado, UsuarioCreacion, 
								FechaCreacion, UsuarioModificacion, 
								FechaModificacion, Accion, Version)
				VALUES(@UnidadReplicacion,	@IdEpisodioAtencionId,	@IdPaciente, 	@EpisodioClinico,	
								 	@IdTipoParentesco,	@Edad,	@IdVivo,	@Estado,	@UsuarioCreacion,	
								@FechaCreacion,	@UsuarioModificacion,	
								@FechaModificacion,	@Accion,	@Version)

			select @IdEpisodioAtencionId;
		END

	 IF @Accion = 'UPDATE'
		BEGIN
		 
					update SS_HC_Anamnesis_AF_FE
					set 
					IdTipoParentesco = @IdTipoParentesco,
					Edad = @Edad,
					IdVivo = @IdVivo,
					 Accion=@Accion , Version=@Version ,
					UsuarioModificacion = @UsuarioModificacion,
					FechaModificacion = @FechaModificacion
					Where	IdPaciente =@IdPaciente
					and		EpisodioClinico =@EpisodioClinico
					and		IdEpisodioAtencion = @IdEpisodioAtencion
				 
			select @IdEpisodioAtencionId;
		END
 	
		IF @Accion ='UPDATEDETALLE'
			BEGIN
				update SS_HC_Anamnesis_AF_Enfermedad_FE
				set IdDiagnostico = @IdTipoParentesco, Observaciones = @UsuarioModificacion,  Accion=@Accion , Version=@Version 
				where	IdPaciente =@IdPaciente
				AND		EpisodioClinico = @EpisodioClinico
				AND		IdEpisodioAtencion=@IdEpisodioAtencion
				and		Secuencia = @Secuencia

				select @IdEpisodioAtencionId
			END

		IF @Accion ='DETALLE'
			BEGIN
			select @SecuenciaID = ISNULL(max(Secuencia),0)+1  from SS_HC_Anamnesis_AF_Enfermedad_FE
			 Insert into dbo.SS_HC_Anamnesis_AF_Enfermedad_FE(UnidadReplicacion, IdPaciente, 
					 EpisodioClinico, IdEpisodioAtencion, 
					 Secuencia, IdDiagnostico, Observaciones , Accion, Version)
			values(@UnidadReplicacion,	@IdPaciente, 
					@EpisodioClinico, @IdEpisodioAtencionId, 
					 @SecuenciaID,	@IdTipoParentesco,	@UsuarioModificacion,	@Accion,	@Version)	
					 
			select @IdEpisodioAtencionId;

			END
 
		 IF @ACCION ='DELETE'
			BEGIN
		 
			 DELETE SS_HC_Anamnesis_AF_Enfermedad_FE 
			where		
				UnidadReplicacion= @UnidadReplicacion
				AND  IdPaciente =@IdPaciente
				AND		EpisodioClinico = @EpisodioClinico
				AND		IdEpisodioAtencion=@IdEpisodioAtencion
				and		Secuencia = @Secuencia
				and		IdDiagnostico = @IdTipoParentesco
				
				select @IdEpisodioAtencionId;
			END				
END


GO
/****** Object:  StoredProcedure [dbo].[SP_AnamnesisAFListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE OR ALTER PROCEDURE  [dbo].[SP_AnamnesisAFListar]
	@UnidadReplicacion char(4) ,
	@IdEpisodioAtencion bigint  ,
	@IdPaciente int  ,
	@EpisodioClinico int  ,
	@Secuencia int  ,
	@IdTipoParentesco int  ,
	@Edad int  ,
	@IdVivo int  ,
	@Estado int  ,
	@UsuarioCreacion varchar(25) ,
	@FechaCreacion datetime  ,
	@UsuarioModificacion varchar(25) ,
	@FechaModificacion datetime  ,
	@Accion varchar(25) ,
	@Version varchar(25)
	
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @IdEpisodioAtencionId as INTEGER,
	 @EpisodioClinicoID as INTEGER, @ExisteCodigo as VARCHAR(10)
	 IF @Accion = 'LISTAR'
		BEGIN		 
		 
			SELECT * FROM  SS_HC_Anamnesis_AF  
			Where  IdEpisodioAtencion = @IdEpisodioAtencion
			 	and		IdPaciente =@IdPaciente			 	
			 	and		EpisodioClinico =@EpisodioClinico				 

			END 
END
 
		 
GO
/****** Object:  StoredProcedure [dbo].[SP_AnamnesisAFListar_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE OR ALTER PROCEDURE  [dbo].[SP_AnamnesisAFListar_FE]
	@UnidadReplicacion char(4) ,
	@IdEpisodioAtencion bigint  ,
	@IdPaciente int  ,
	@EpisodioClinico int  ,
	@Secuencia int  ,
	@IdTipoParentesco int  ,
	@Edad int  ,
	@IdVivo int  ,
	@Estado int  ,
	@UsuarioCreacion varchar(25) ,
	@FechaCreacion datetime  ,
	@UsuarioModificacion varchar(25) ,
	@FechaModificacion datetime  ,
	@Accion varchar(25) ,
	@Version varchar(25)
	
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @IdEpisodioAtencionId as INTEGER,
	 @EpisodioClinicoID as INTEGER, @ExisteCodigo as VARCHAR(10)
	 IF @Accion = 'LISTAR'
		BEGIN		 
		 
			SELECT * FROM  SS_HC_Anamnesis_AF_FE  
			Where  IdEpisodioAtencion = @IdEpisodioAtencion
			 	and		IdPaciente =@IdPaciente			 	
			 	and		EpisodioClinico =@EpisodioClinico				 

			END
 
END
 
		 
GO
/****** Object:  StoredProcedure [dbo].[SP_AntecedentesPersonalesIAdulDetalleListar_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_AntecedentesPersonalesIAdulDetalleListar_FE]
@UnidadReplicacion		CHAR(4),
@IdEpisodioAtencion		bigint,
@IdPaciente				int,
@EpisodioClinico		int,
@Accion		varchar(25)

AS 
  BEGIN 
   IF ( @Accion = 'LISTAR' ) 
        BEGIN 
            SELECT  * FROM   SS_HC_AntecedentesPersonalesIAdulDetalle_FE 
            WHERE  ( UnidadReplicacion = @UnidadReplicacion ) 
					AND ( IdEpisodioAtencion =@IdEpisodioAtencion) 
					AND (IdPaciente	=@IdPaciente )
					and (EpisodioClinico = @EpisodioClinico )
        END 
        IF ( @Accion = 'LISTARTOP' ) 
        BEGIN 
            SELECT  TOP 1 *
            FROM   SS_HC_AntecedentesPersonalesIAdulDetalle_FE 
            WHERE  ( UnidadReplicacion = @UnidadReplicacion ) 			
					AND (IdPaciente	=@IdPaciente )			
					ORDER BY EpisodioClinico desc,IdEpisodioAtencion desc
        END 
  END 
GO
/****** Object:  StoredProcedure [dbo].[SP_AntecedentesPersonalesIAdulListarFE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE  [dbo].[SP_AntecedentesPersonalesIAdulListarFE]
	@UnidadReplicacion char(4),
	@IdEpisodioAtencion  bigint ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@CodigoSecuencia int ,
	
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
				SELECT * FROM  SS_HC_AntecedentesPersonalesIAdul_FE  
				Where	IdPaciente =@IdPaciente 
				and		EpisodioClinico = @EpisodioClinico
				and		IdEpisodioAtencion = @IdEpisodioAtencion
				and		UnidadReplicacion = @UnidadReplicacion 
 
			END
			
			IF @Accion ='LISTARTOP'
			BEGIN
				SELECT TOP 1 * FROM  SS_HC_AntecedentesPersonalesIAdul_FE  
				Where	IdPaciente =@IdPaciente 
				and		UnidadReplicacion = @UnidadReplicacion 
				ORDER BY EpisodioClinico desc, IdEpisodioAtencion desc
 
			END
	 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AntecedentesPersonalesINDetalleListar_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_AntecedentesPersonalesINDetalleListar_FE]
@UnidadReplicacion		CHAR(4),
@IdEpisodioAtencion		bigint,
@IdPaciente				int,
@EpisodioClinico		int,
@Accion		varchar(25)

AS 
  BEGIN 
   IF ( @Accion = 'LISTAR' ) 
        BEGIN 
            SELECT * FROM   SS_HC_AntecedentesPersonalesINDetalle_FE 
            WHERE  ( UnidadReplicacion = @UnidadReplicacion ) 
					AND ( IdEpisodioAtencion =@IdEpisodioAtencion) 
					AND (IdPaciente	=@IdPaciente )
					and (EpisodioClinico = @EpisodioClinico )
        END 
        IF ( @Accion = 'LISTARTOP' ) 
        BEGIN 
            SELECT  top 1 *
            FROM   SS_HC_AntecedentesPersonalesINDetalle_FE 
            WHERE  ( UnidadReplicacion = @UnidadReplicacion ) 
					AND (IdPaciente	=@IdPaciente )
					ORDER BY EpisodioClinico desc, IdEpisodioAtencion desc
        END 
  END 
GO
/****** Object:  StoredProcedure [dbo].[SP_AntecedentesPersonalesINListarFE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[SP_AntecedentesPersonalesINListarFE]
	@UnidadReplicacion char(4),
	@IdEpisodioAtencion  bigint ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@CodigoSecuencia int ,	
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
				SELECT * FROM  SS_HC_AntecedentesPersonalesIN_FE  
				Where	IdPaciente =@IdPaciente 
				and		EpisodioClinico = @EpisodioClinico
				and		IdEpisodioAtencion = @IdEpisodioAtencion
				and		UnidadReplicacion = @UnidadReplicacion 
 
			END
	IF @Accion ='LISTARTOP'
			BEGIN
				SELECT TOP 1 * FROM  SS_HC_AntecedentesPersonalesIN_FE  
				Where	IdPaciente =@IdPaciente 
				and		UnidadReplicacion = @UnidadReplicacion 
				ORDER BY EpisodioClinico desc, IdEpisodioAtencion desc
 
			END		
	 
END
	 
GO
/****** Object:  StoredProcedure [dbo].[SP_AntePerGinecoObstetricosListarFE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE  [dbo].[SP_AntePerGinecoObstetricosListarFE]
	@UnidadReplicacion char(4),
	@IdEpisodioAtencion  bigint ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@IdGinecoobstetricos int ,	
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
				SELECT * FROM  SS_HC_AntePerGinecoObstetricos_FE  
				Where	IdPaciente =@IdPaciente 
				and		EpisodioClinico = @EpisodioClinico
				and		IdEpisodioAtencion = @IdEpisodioAtencion
				and		UnidadReplicacion = @UnidadReplicacion 
				and     IdGinecoobstetricos = @IdGinecoobstetricos
 
			END
	 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Apoyo_Diagnostico_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_Apoyo_Diagnostico_FE]
	@UnidadReplicacion  char(4) ,
	@IdEpisodioAtencion  bigint ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@Accion  varchar(25),
	@IdDiagnostico int, 
	@IdFormaInicio int --SECUENCIA
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @IdEpisodioAtencionId as INTEGER
	DECLARE @SecuenciaID as Integer

	SET @IdEpisodioAtencionId = @IdEpisodioAtencion

	
	IF @ACCION ='UPDATEDETALLE'  --Actualizar DETALLE
		BEGIN          

   			UPDATE SS_HC_Apoyo_Diagnostico_FE 
			SET 
				IdDiagnostico=	@IdDiagnostico,
				Accion = @Accion				
			Where	
			UnidadReplicacion = @UnidadReplicacion
			and		IdEpisodioAtencion = @IdEpisodioAtencion
			and IdPaciente =@IdPaciente 
			and		EpisodioClinico = @EpisodioClinico
			and Secuencia = @IdFormaInicio				
				
			select @IdEpisodioAtencionId;

		END  
	
	IF @ACCION ='INSERTDETALLE'  --Insertar DETALLE
		BEGIN  

		select @SecuenciaID = count(*) from   SS_HC_Apoyo_Diagnostico_FE where UnidadReplicacion = @UnidadReplicacion
			and	IdEpisodioAtencion = @IdEpisodioAtencion	and IdPaciente =@IdPaciente 
			and	EpisodioClinico = @EpisodioClinico			and IdDiagnostico=@IdDiagnostico

		if @SecuenciaID=0
			BEGIN
			   select @SecuenciaID = ISNULL(max(Secuencia),0) + 1   from SS_HC_Apoyo_Diagnostico_FE          
  
			   insert into SS_HC_Apoyo_Diagnostico_FE
			   ( UnidadReplicacion, IdEpisodioAtencion, IdPaciente,   
				EpisodioClinico, Secuencia, IdDiagnostico,Accion)  
			   values 
			   (@UnidadReplicacion, @IdEpisodioAtencion, @IdPaciente,   
				@EpisodioClinico, @SecuenciaID, @IdDiagnostico,@Accion )  
			END
		   select @IdEpisodioAtencionId;  
      
		END 	

	IF @ACCION ='DELETE'  --Borrar DETALLE
		BEGIN  
    
			DELETE SS_HC_Apoyo_Diagnostico_FE   
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

/****** Object:  StoredProcedure [dbo].[sp_bloqueos]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [sp_bloqueos]
AS
	SELECT DISTINCT
	A.spid,
	left(convert(sysname, rtrim(A.loginame)),20) as 'loginname',
	hostname=left(A.hostname,20),
	program=left(A.program_name,20),
	BloqueadoPor=A.blocked,
	Bloqueador = '['+RTRIM(convert(sysname, rtrim(B.loginame)))+'] desde ['+RTRIM(B.program_name)+'] en ['+RTRIM(B.hostname)+']'
	FROM master.dbo.sysprocesses A
	LEFT JOIN master.dbo.sysprocesses B
	ON A.Blocked = B.Spid
	WHERE A.Blocked > 0
	AND A.Spid <> A.Blocked
GO

/****** Object:  StoredProcedure [dbo].[SP_CM_CH_CO_TablaMaestroDetalle]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_CM_CH_CO_TablaMaestroDetalle] 
@IdTablaMaestro      INT, 
@IdCodigo            INT, 
@Codigo              VARCHAR(25), 
@Nombre              VARCHAR(250), 
@Descripcion         VARCHAR(250), 

@Estado              INT, 
@UsuarioCreacion     VARCHAR(25), 
@FechaCreacion       DATETIME, 
@UsuarioModificacion VARCHAR(25), 
@FechaModificacion   DATETIME, 

@Accion              VARCHAR(25) 
AS 
  BEGIN 
      SET nocount ON; 

      IF( @Accion = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   cm_co_tablamaestrodetalle 
                             WHERE  ( @Codigo IS NULL OR Upper(codigo) LIKE '%' + Upper(@Codigo ) + '%' ) 
                                    AND ( @Nombre IS NULL OR Upper(nombre) LIKE '%' + Upper(@Nombre) + '%' )
                                    AND ( @IdTablaMaestro IS NULL OR IdTablaMaestro = @IdTablaMaestro or @IdTablaMaestro = 0)
                                    AND ( @IdCodigo IS NULL OR IdCodigo = @IdCodigo or @IdCodigo = 0 )) 
            SELECT @CONTADOR; 
        END 
  END 
/*      
EXEC SP_CM_CH_CO_TablaMaestroDetalle      
NULL,NULL, NULL, NULL, NULL,      
NULL, NULL, NULL, NULL, NULL,      
'LISTARPAG'  
*/ 
GO
/****** Object:  StoredProcedure [dbo].[SP_CM_CH_CO_TablaMaestroDetalleListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_CM_CH_CO_TablaMaestroDetalleListar] 
@IdTablaMaestro      INT, 
@IdCodigo            INT, 
@Codigo				 VARCHAR(25), 
@Nombre				 VARCHAR(250), 
@Descripcion		 VARCHAR(250), 

@Estado              INT, 
@UsuarioCreacion	 VARCHAR(25), 
@FechaCreacion		 DATETIME, 
@UsuarioModificacion VARCHAR(25), 
@FechaModificacion	 DATETIME, 

@Accion				 VARCHAR(25), 
@INICIO              INT = NULL, 
@NUMEROFILAS         INT = NULL 
AS 
  BEGIN 
      SET nocount ON; 

      IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   cm_co_tablamaestrodetalle 
                             WHERE  ( @Codigo IS NULL OR Upper(codigo) LIKE '%' + Upper(@Codigo ) + '%' ) 
                                    AND ( @Nombre IS NULL OR Upper(nombre) LIKE '%' + Upper(@Nombre) + '%' )
                                    AND ( @IdTablaMaestro IS NULL OR IdTablaMaestro = @IdTablaMaestro or @IdTablaMaestro = 0)
                                    AND ( @IdCodigo IS NULL OR IdCodigo = @IdCodigo or @IdCodigo = 0 )) 
            SELECT idtablamaestro, 
                   idcodigo, 
                   codigo, 
                   nombre, 
                   descripcion, 
                   estado, 
                   usuariocreacion, 
                   fechacreacion, 
                   usuariomodificacion, 
                   fechamodificacion, 
                   accion 
            FROM   (SELECT idtablamaestro, 
                           idcodigo, 
                           codigo, 
                           nombre, 
                           descripcion, 
                           estado, 
                           usuariocreacion, 
                           fechacreacion, 
                           usuariomodificacion, 
                           fechamodificacion, 
                           accion, 
                           @CONTADOR                        AS contador, 
                           Row_number() OVER(ORDER BY idtablamaestro ASC) AS rownumber 
                    FROM   cm_co_tablamaestrodetalle 
                   WHERE  ( @Codigo IS NULL OR Upper(codigo) LIKE '%' + Upper(@Codigo ) + '%' ) 
                          AND ( @Nombre IS NULL OR Upper(nombre) LIKE '%' + Upper(@Nombre) + '%' )
                          AND ( @IdTablaMaestro IS NULL OR IdTablaMaestro = @IdTablaMaestro or @IdTablaMaestro = 0)
                          AND ( @IdCodigo IS NULL OR IdCodigo = @IdCodigo or @IdCodigo = 0 )) AS DATOSDETALLE 
            WHERE  ( @INICIO IS NULL AND @NUMEROFILAS IS NULL ) OR ( rownumber BETWEEN @INICIO AND @NUMEROFILAS ) 
        END 
  END 
/*    
EXEC SP_CM_CH_CO_TablaMaestroDetalleListar    
NULL,NULL, NULL, NULL, NULL,    
NULL, 0, NULL, NULL, NULL,     
'LISTARPAG', 0,10    
*/ 
GO
/****** Object:  StoredProcedure [dbo].[SP_CM_CO_ESTABLECIMIENTO]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_CM_CO_ESTABLECIMIENTO]  
   @IdEstablecimiento int,  
            @Codigo varchar(15),  
            @Nombre varchar(80),  
            @Descripcion varchar(150),  
            @Observacion varchar(150),  
            @Estado int,  
            @UsuarioCreacion varchar(25),  
            @FechaCreacion datetime,  
            @UsuarioModificacion varchar(25),  
            @FechaModificacion datetime,  
            @Sucursal varchar(15),  
            @Compania varchar(15),  
            @Direccion varchar(250),  
            @Accion varchar(25)  
AS    
BEGIN     
SET NOCOUNT ON;    
BEGIN  TRANSACTION    
    
 DECLARE @CONTADOR INT    
 IF(@Accion = 'INSERT')    
 BEGIN     
   select @CONTADOR= isnull(MAX(IdEstablecimiento),0)+1 from CM_CO_ESTABLECIMIENTO   
    
  set @IdEstablecimiento= @CONTADOR  
    
  INSERT INTO CM_CO_ESTABLECIMIENTO    
  (    
    IdEstablecimiento,  
    Codigo,  
    Nombre,  
    Descripcion,  
    Observacion,  
    Estado,  
    UsuarioCreacion,  
    FechaCreacion,  
    UsuarioModificacion,  
    FechaModificacion,  
    Sucursal,  
    Compania,  
    Direccion,  
    Accion  
  )    
    VALUES    
  (     
     
    @IdEstablecimiento,  
    @Codigo,  
    @Nombre,  
    @Descripcion,  
    @Observacion,  
    @Estado,  
    @UsuarioCreacion,  
    GETDATE(),  
    @UsuarioModificacion,  
    GETDATE(),  
    @Sucursal,  
    @Compania,  
    @Direccion,  
    @Accion  
  )    
    
 SELECT 1     
 END     
 ELSE    
 IF(@Accion = 'UPDATE')    
 BEGIN    
 UPDATE CM_CO_ESTABLECIMIENTO    
  SET        
    IdEstablecimiento=@IdEstablecimiento,  
    Codigo=@Codigo,  
    Nombre=@Nombre,  
    Descripcion=@Descripcion,  
    Observacion=@Observacion,  
    Estado=@Estado,  
    UsuarioCreacion=@UsuarioCreacion,  
    FechaCreacion=@FechaCreacion,  
    UsuarioModificacion=@UsuarioModificacion,  
    FechaModificacion=GETDATE(),  
    Sucursal=@Sucursal,  
    Compania=@Compania,  
    Direccion=@Direccion,  
    Accion=@Accion  
  WHERE   
  (IdEstablecimiento = @IdEstablecimiento)    
     select 1  
 end     
 else    
 if(@Accion = 'DELETE')    
 begin    
  delete CM_CO_ESTABLECIMIENTO    
  WHERE   
  (IdEstablecimiento = @IdEstablecimiento)    
     select 1  
end  
  if(@Accion = 'CONTARLISTAPAG')  
 begin    
  SET @CONTADOR=(SELECT COUNT(IdEstablecimiento) FROM CM_CO_ESTABLECIMIENTO  
       WHERE   
     (@IdEstablecimiento is null OR (IdEstablecimiento = @IdEstablecimiento) or @IdEstablecimiento =0)  
     and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')       
     and (@Estado is null OR Estado = @Estado)
     and (@Compania is null OR substring(Compania,1,6) = @Compania)    
     )  
       
  select @CONTADOR  
 end  
commit    
END    
GO
/****** Object:  StoredProcedure [dbo].[SP_CM_CO_ESTABLECIMIENTO_Lista]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_CM_CO_ESTABLECIMIENTO_Lista]    
   @IdEstablecimiento int,    
            @Codigo varchar(15),    
            @Nombre varchar(80),    
            @Descripcion varchar(150),    
            @Observacion varchar(150),    
            @Estado int,    
            @UsuarioCreacion varchar(25),    
            @FechaCreacion datetime,    
            @UsuarioModificacion varchar(25),    
            @FechaModificacion datetime,    
            @Sucursal varchar(15),    
            @Compania varchar(15),    
            @Direccion varchar(250),    
            @Accion varchar(25),    
                
   @INICIO   int= null,      
   @NUMEROFILAS int = null     
AS        
BEGIN        
if(@Accion = 'LISTARPAG')    
 begin    
   DECLARE @CONTADOR INT    
  SET @CONTADOR=(SELECT COUNT(IdEstablecimiento) FROM CM_CO_ESTABLECIMIENTO    
       WHERE     
     (@IdEstablecimiento is null OR (IdEstablecimiento = @IdEstablecimiento) or @IdEstablecimiento =0)    
     and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')         
     and (@Estado is null OR Estado = @Estado)   
     and (@Compania is null OR substring(Compania,1,6) = @Compania)   
     )    
  SELECT    
    IdEstablecimiento,    
    Codigo,    
    Nombre,    
    Descripcion,    
    Observacion,    
    Estado,    
    UsuarioCreacion,    
    FechaCreacion,    
    UsuarioModificacion,    
    FechaModificacion,        
    --(SELECT DescripcionLocal FROM AC_Sucursal WHERE AC_Sucursal.Sucursal = SUCURSAL) AS Sucursal,    
    Sucursal,    
    Compania,    
    Direccion,    
    Accion    
  FROM (      
   SELECT    
    IdEstablecimiento,    
    Codigo,    
    Nombre,    
    Descripcion,    
    Observacion,    
    Estado,    
    UsuarioCreacion,    
    FechaCreacion,    
    UsuarioModificacion,    
    FechaModificacion,    
    (SELECT DescripcionLocal FROM AC_Sucursal WHERE AC_Sucursal.Sucursal = CM_CO_ESTABLECIMIENTO.Sucursal) AS Sucursal,    
    --Sucursal,  
    Compania,    
    Direccion,    
    Accion    
     ,@CONTADOR AS Contador    
     ,ROW_NUMBER() OVER (ORDER BY IdEstablecimiento ASC ) AS RowNumber        
     FROM CM_CO_ESTABLECIMIENTO     
     WHERE     
      (@IdEstablecimiento is null OR (IdEstablecimiento = @IdEstablecimiento) or @IdEstablecimiento =0)        
     and (@Codigo is null  OR @Codigo =''  OR  upper(Codigo) like '%'+upper(@Codigo)+'%')         
     and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')         
     and (@Estado is null OR Estado = @Estado)      
 and (@Sucursal is null OR Sucursal = @Sucursal)      
 and (@Compania is null OR substring(Compania,1,6) = @Compania)      
   ) AS LISTADO    
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR      
            RowNumber BETWEEN @Inicio  AND @NumeroFilas     
      
       END    
       ELSE    
  IF @Accion ='LISTAR'        
    BEGIN        
  SELECT    
    IdEstablecimiento,    
    Codigo,    
    Nombre,    
    Descripcion,    
    Observacion,    
    Estado,    
    UsuarioCreacion,    
    FechaCreacion,    
    UsuarioModificacion,    
    FechaModificacion,    
    Sucursal,    
    Compania,    
    Direccion,    
    Accion    
    FROM CM_CO_ESTABLECIMIENTO     
    WHERE     
      (@IdEstablecimiento is null OR (IdEstablecimiento = @IdEstablecimiento) or @IdEstablecimiento =0)        
     and (@Codigo is null OR Codigo = @Codigo)           
     and (@Descripcion is null  OR @Descripcion =''  OR  upper(Descripcion) like '%'+upper(@Descripcion)+'%')         
     and (@Estado is null OR Estado = @Estado)     
     
end     
 else    
 if(@ACCION = 'LISTARPORID')    
 begin      
    SELECT     
     *         
    from     
    CM_CO_ESTABLECIMIENTO    
    
     WHERE     
     (@IdEstablecimiento is null OR (IdEstablecimiento = @IdEstablecimiento) or @IdEstablecimiento =0)     
    
 end     
END    
  
/*  
EXEC  [SP_CM_CO_ESTABLECIMIENTO_Lista]  
0,NULL,NULL,NULL,  
NULL,NULL,NULL,NULL,NULL,  
NULL,NULL,NULL,NULL,'LISTARPAG',  
0,10  
*/
GO
/****** Object:  StoredProcedure [dbo].[SP_CM_CO_ListaBaseComponente_lista]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_CM_CO_ListaBaseComponente_lista]

			@IdListaBase int,
            @TipoComponente varchar(1),
            @CodigoComponente varchar(25),
            @Periodo int,
            @Moneda varchar(2),
            @PrecioUnitarioLista decimal(20,6),
            @PrecioUnitarioListaLocal decimal(20,6),
            @PrecioUnitarioBase decimal(20,6),
            @PrecioUnitarioBaseLocal decimal(20,6),
            @FechaValidezInicio datetime,
            @FechaValidezFin datetime,
            @Estado int,
            @UsuarioCreacion varchar(25),
            @FechaCreacion datetime,
            @UsuarioModificacion varchar(25),
            @FechaModificacion datetime,
            @IndicadorPrecioCero int,
            @Factor decimal(20,6),
            @TipoFactor varchar(1),
            @IndicadorFactor int,
            @PrecioCosto decimal(20,6),
            @FactorCosto decimal(20,6),
            @PrecioKairos decimal(20,6),
            @FactorKairos decimal(20,6),
			@Accion varchar(25),
			
			@INICIO   int= null,  
			@NUMEROFILAS int = null
			
			AS
BEGIN    
IF(@Accion = 'LISTARPAG')
	BEGIN
		DECLARE @CONTADOR INT
	
		SET @CONTADOR=(SELECT COUNT(IdListaBase) FROM CM_CO_ListaBaseComponente
	 					WHERE 
					(@IdListaBase is null OR (IdListaBase = @IdListaBase) or @IdListaBase =0)
					and (@TipoComponente is null OR TipoComponente = @TipoComponente)
					and (@CodigoComponente is null OR CodigoComponente = @CodigoComponente)					
					and (@Estado is null OR Estado = @Estado)
					) 
					SELECT
					IdListaBase,
					TipoComponente,
					CodigoComponente,
					Periodo,
					Moneda,
					PrecioUnitarioLista,
					PrecioUnitarioListaLocal,
					PrecioUnitarioBase,
					PrecioUnitarioBaseLocal,
					FechaValidezInicio,
					FechaValidezFin,
					Estado,
					UsuarioCreacion,
					FechaCreacion,
					UsuarioModificacion,
					FechaModificacion,
					IndicadorPrecioCero,
					Factor,
					TipoFactor,
					IndicadorFactor,
					PrecioCosto,
					FactorCosto,
					PrecioKairos,
					FactorKairos,
					Accion
					FROM(
					SELECT 
					IdListaBase,
					TipoComponente,
					CodigoComponente,
					Periodo,
					Moneda,
					PrecioUnitarioLista,
					PrecioUnitarioListaLocal,
					PrecioUnitarioBase,
					PrecioUnitarioBaseLocal,
					FechaValidezInicio,
					FechaValidezFin,
					Estado,
					UsuarioCreacion,
					FechaCreacion,
					UsuarioModificacion,
					FechaModificacion,
					IndicadorPrecioCero,
					Factor,
					TipoFactor,
					IndicadorFactor,
					PrecioCosto,
					FactorCosto,
					PrecioKairos,
					FactorKairos,
					Accion,
					
					@CONTADOR AS Contador
					,ROW_NUMBER() OVER (ORDER BY IdListaBase ASC ) AS RowNumber   	
					FROM CM_CO_ListaBaseComponente	
					WHERE 
					(@IdListaBase is null OR (IdListaBase = @IdListaBase) or @IdListaBase =0)
					and (@TipoComponente is null OR TipoComponente = @TipoComponente)
					and (@CodigoComponente is null OR CodigoComponente = @CodigoComponente)					
					and (@Estado is null OR Estado = @Estado)
 
			) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		
       END
       ELSE
       If @Accion = 'detalle'
       SELECT CM_CO_ListaBaseComponente.IdListaBase, 
				CM_CO_ListaBaseComponente.TipoComponente, 
				CM_CO_ListaBaseComponente.CodigoComponente, 
				CM_CO_ListaBaseComponente.Periodo, 
				CM_CO_ListaBaseComponente.Moneda, 
				CM_CO_ListaBaseComponente.PrecioUnitarioLista, 
				CM_CO_ListaBaseComponente.PrecioUnitarioListaLocal, 
				CM_CO_ListaBaseComponente.PrecioUnitarioBase, 
				CM_CO_ListaBaseComponente.PrecioUnitarioBaseLocal, 
				CM_CO_ListaBaseComponente.TipoFactor, 
				CM_CO_ListaBaseComponente.Factor, 
				CM_CO_ListaBaseComponente.FechaValidezInicio, 
				CM_CO_ListaBaseComponente.FechaValidezFin, 
				CM_CO_ListaBaseComponente.IndicadorPrecioCero, 
				CM_CO_ListaBaseComponente.Estado, 
				CM_CO_ListaBaseComponente.UsuarioCreacion, 
				CM_CO_ListaBaseComponente.FechaCreacion, 
				CM_CO_ListaBaseComponente.UsuarioModificacion, 
				CM_CO_ListaBaseComponente.FechaModificacion, WH_ItemMast.DescripcionLocal AS Componente_Articulo, 
				CM_CO_Componente.Nombre AS Componente_Nombre, CM_CO_ListaBase.Nombre, 
				CM_CO_ListaBase.TipoLista, CM_CO_ListaBase.IdCliente, 
				PersonaMast.Busqueda AS IdClienteNombre, 1 AS Control 
				FROM CM_CO_ListaBaseComponente 
				INNER JOIN CM_CO_ListaBase ON CM_CO_ListaBase.IdListaBase = CM_CO_ListaBaseComponente.IdListaBase 
				LEFT JOIN WH_ItemMast ON CM_CO_ListaBaseComponente.CodigoComponente = WH_ItemMast.Item 
				LEFT JOIN CM_CO_Componente 
				ON CM_CO_ListaBaseComponente.CodigoComponente = CM_CO_Componente.CodigoComponente 
				LEFT JOIN PersonaMast ON PersonaMast.Persona = CM_CO_ListaBase.IdCliente 
       else
	If @Accion = 'LISTAR'
	BEGIN
		SELECT
					IdListaBase,
					TipoComponente,
					CodigoComponente,
					Periodo,
					Moneda,
					PrecioUnitarioLista,
					PrecioUnitarioListaLocal,
					PrecioUnitarioBase,
					PrecioUnitarioBaseLocal,
					FechaValidezInicio,
					FechaValidezFin,
					Estado,
					UsuarioCreacion,
					FechaCreacion,
					UsuarioModificacion,
					FechaModificacion,
					IndicadorPrecioCero,
					Factor,
					TipoFactor,
					IndicadorFactor,
					PrecioCosto,
					FactorCosto,
					PrecioKairos,
					FactorKairos,
					Accion
					FROM CM_CO_ListaBaseComponente	
					WHERE 
					(@IdListaBase is null OR (IdListaBase = @IdListaBase) or @IdListaBase =0)
					and (@TipoComponente is null OR TipoComponente = @TipoComponente)
					and (@CodigoComponente is null OR CodigoComponente = @CodigoComponente)					
					and (@Estado is null OR Estado = @Estado)
					end	
	else
	if(@ACCION = 'LISTARPORID')
	begin	 
				SELECT 
					*		
					FROM			
				CM_CO_ListaBaseComponente 

					WHERE 
						(@IdListaBase is null OR (IdListaBase = @IdListaBase) or @IdListaBase =0)
					and (@TipoComponente is null OR TipoComponente = @TipoComponente)
					and (@CodigoComponente is null OR CodigoComponente = @CodigoComponente)	

	end	
END
					
GO
/****** Object:  StoredProcedure [dbo].[SP_CM_CO_ListaBaseComponente_mantenimiento]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_CM_CO_ListaBaseComponente_mantenimiento]

			@IdListaBase int,
            @TipoComponente varchar(1),
            @CodigoComponente varchar(25),
            @Periodo int,
            @Moneda varchar(2),
            @PrecioUnitarioLista decimal(20,6),
            @PrecioUnitarioListaLocal decimal(20,6),
            @PrecioUnitarioBase decimal(20,6),
            @PrecioUnitarioBaseLocal decimal(20,6),
            @FechaValidezInicio datetime,
            @FechaValidezFin datetime,
            @Estado int,
            @UsuarioCreacion varchar(25),
            @FechaCreacion datetime,
            @UsuarioModificacion varchar(25),
            @FechaModificacion datetime,
            @IndicadorPrecioCero int,
            @Factor decimal(20,6),
            @TipoFactor varchar(1),
            @IndicadorFactor int,
            @PrecioCosto decimal(20,6),
            @FactorCosto decimal(20,6),
            @PrecioKairos decimal(20,6),
            @FactorKairos decimal(20,6),
			@Accion varchar(25)
			
AS
BEGIN 
SET NOCOUNT ON;
BEGIN  TRANSACTION

	DECLARE @CONTADOR INT
	
	if(@ACCION = 'INSERT')
	begin		 
		
		select @CONTADOR= isnull(MAX(IdListaBase),0)+1 from CM_CO_ListaBaseComponente 
		
		set @IdListaBase= @CONTADOR
		insert into CM_CO_ListaBaseComponente
		(
					IdListaBase,
					TipoComponente,
					CodigoComponente,
					Periodo,
					Moneda,
					PrecioUnitarioLista,
					PrecioUnitarioListaLocal,
					PrecioUnitarioBase,
					PrecioUnitarioBaseLocal,
					FechaValidezInicio,
					FechaValidezFin,
					Estado,
					UsuarioCreacion,
					FechaCreacion,
					UsuarioModificacion,
					FechaModificacion,
					IndicadorPrecioCero,
					Factor,
					TipoFactor,
					IndicadorFactor,
					PrecioCosto,
					FactorCosto,
					PrecioKairos,
					FactorKairos,
					Accion
		)
		values
		(
					@IdListaBase,
					@TipoComponente,
					@CodigoComponente,
					@Periodo,
					@Moneda,
					@PrecioUnitarioLista,
					@PrecioUnitarioListaLocal,
					@PrecioUnitarioBase,
					@PrecioUnitarioBaseLocal,
					@FechaValidezInicio,
					@FechaValidezFin,
					@Estado,
					@UsuarioCreacion,
					@FechaCreacion,
					@UsuarioModificacion,
					@FechaModificacion,
					@IndicadorPrecioCero,
					@Factor,
					@TipoFactor,
					@IndicadorFactor,
					@PrecioCosto,
					@FactorCosto,
					@PrecioKairos,
					@FactorKairos,
					@Accion
		)		
		select 1
	end	
	else
	if(@ACCION = 'UPDATE')
	begin			
		update CM_CO_ListaBaseComponente
		set 
					IdListaBase = @IdListaBase,
					TipoComponente = @TipoComponente,
					CodigoComponente = @CodigoComponente,
					Periodo = @Periodo ,
					Moneda = @Moneda ,
					PrecioUnitarioLista = @PrecioUnitarioLista ,
					PrecioUnitarioListaLocal = @PrecioUnitarioListaLocal ,
					PrecioUnitarioBase = @PrecioUnitarioBase ,
					PrecioUnitarioBaseLocal = @PrecioUnitarioBaseLocal ,
					FechaValidezInicio = @FechaValidezInicio,
					FechaValidezFin = @FechaValidezFin ,
					Estado = @Estado , 
					UsuarioCreacion = @UsuarioCreacion ,
					FechaCreacion = @FechaCreacion ,
					UsuarioModificacion = @UsuarioModificacion ,
					FechaModificacion = @FechaModificacion,
					IndicadorPrecioCero = @IndicadorFactor ,
					Factor = @Factor ,
					TipoFactor = @TipoFactor ,
					IndicadorFactor = @IndicadorFactor ,
					PrecioCosto = @PrecioCosto ,
					FactorCosto = @FactorCosto ,
					PrecioKairos = @PrecioKairos  ,
					FactorKairos = @FactorKairos ,
					Accion = @Accion 
		WHERE 
		(IdListaBase = @IdListaBase)		
		select 1
	end		
	else
	if(@ACCION = 'DELETE')
	begin
		delete CM_CO_ListaBaseComponente
		WHERE 
		(IdListaBase = @IdListaBase)
		select 1
	end
	else
	if(@ACCION = 'CONTARLISTARPAG')
	begin	
	
		SET @CONTADOR=(SELECT COUNT(IdListaBase) FROM CM_CO_ListaBaseComponente
	 					WHERE 
					(@IdListaBase is null OR (IdListaBase = @IdListaBase) or @IdListaBase =0)
					and (@TipoComponente is null OR TipoComponente = @TipoComponente)
					and (@CodigoComponente is null OR CodigoComponente = @CodigoComponente)					
					and (@Estado is null OR Estado = @Estado))
		select @CONTADOR
	end
commit	
	
END			
GO
/****** Object:  StoredProcedure [dbo].[SP_CM_HC_CO_TablaMaestro]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_CM_HC_CO_TablaMaestro] 
@IdTablaMaestro      INT, 
@CodigoTabla         VARCHAR(25), 
@Nombre              VARCHAR(255), 
@Descripcion         VARCHAR(255), 
@Version             VARCHAR(15), 

@Estado              INT, 
@UsuarioCreacion     VARCHAR(25), 
@FechaCreacion       DATETIME, 
@UsuarioModificacion VARCHAR(25), 
@FechaModificacion   DATETIME, 

@Accion              VARCHAR(25) 
AS 
  BEGIN 
      SET nocount ON; 

      IF( @Accion = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   cm_co_tablamaestro 
                             WHERE  ( @CodigoTabla IS NULL OR Upper(codigotabla) LIKE '%' + Upper(@CodigoTabla ) + '%' ) 
                                    AND ( @Nombre IS NULL OR Upper(nombre) LIKE '%' + Upper(@Nombre) + '%' )) 
            SELECT @CONTADOR; 
        END 
  END 
/*     
EXEC SP_CM_HC_CO_TablaMaestro     
NULL,NULL, NULL, NULL, NULL,     
NULL, NULL, NULL, NULL, NULL,     
'LISTARPAG' 
*/ 
GO
/****** Object:  StoredProcedure [dbo].[SP_CM_HC_CO_TablaMaestroListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_CM_HC_CO_TablaMaestroListar] 
@IdTablaMaestro      INT, 
@CodigoTabla         VARCHAR(25), 
@Nombre              VARCHAR(255), 
@Descripcion         VARCHAR(255 ), 
@Version             VARCHAR(15), 
@Estado              INT, 
@UsuarioCreacion     VARCHAR(25), 
@FechaCreacion       DATETIME, 
@UsuarioModificacion VARCHAR(25), 
@FechaModificacion   DATETIME, 
@Accion              VARCHAR(25), 
@INICIO              INT = NULL, 
@NUMEROFILAS         INT = NULL 
AS 
  BEGIN 
      SET nocount ON; 
	  IF (@Accion = 'LISTAR')
	  BEGIN
	  SELECT idtablamaestro, 
             codigotabla, 
             nombre, 
             descripcion, 
             version, 
             estado, 
             usuariocreacion, 
             fechacreacion, 
             usuariomodificacion, 
             fechamodificacion, 
             accion
             FROM   cm_co_tablamaestro 
             WHERE  ( @CodigoTabla IS NULL OR Upper(codigotabla) LIKE '%' + Upper(@CodigoTabla ) + '%' ) 
             AND ( @Nombre IS NULL OR Upper(nombre) LIKE '%' + Upper(@Nombre) + '%' )
             AND ( @IdTablaMaestro IS NULL OR IdTablaMaestro=@IdTablaMaestro OR @IdTablaMaestro = 0)
	  END
      ELSE IF( @Accion = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   cm_co_tablamaestro 
                             WHERE  ( @CodigoTabla IS NULL OR Upper(codigotabla) LIKE '%' + Upper(@CodigoTabla ) + '%' ) 
                                    AND ( @Nombre IS NULL OR Upper(nombre) LIKE '%' + Upper(@Nombre) + '%' )
                                    AND ( @IdTablaMaestro IS NULL OR IdTablaMaestro=@IdTablaMaestro OR @IdTablaMaestro = 0) )

            SELECT idtablamaestro, 
                   codigotabla, 
                   nombre, 
                   descripcion, 
                   version, 
                   estado, 
                   usuariocreacion, 
                   fechacreacion, 
                   usuariomodificacion, 
                   fechamodificacion, 
                   accion 
            FROM   (SELECT idtablamaestro, 
                           codigotabla, 
                           nombre, 
                           descripcion, 
                           version, 
                           estado, 
                           usuariocreacion, 
                           fechacreacion, 
                           usuariomodificacion, 
                           fechamodificacion, 
                           accion, 
                           @CONTADOR                        AS contador, 
                           Row_number() 
                             OVER( 
                               ORDER BY idtablamaestro ASC) AS rownumber 
                    FROM   cm_co_tablamaestro 
                     WHERE  ( @CodigoTabla IS NULL OR Upper(codigotabla) LIKE '%' + Upper(@CodigoTabla ) + '%' ) 
                            AND ( @Nombre IS NULL OR Upper(nombre) LIKE '%' + Upper(@Nombre) + '%' )
                            AND ( @IdTablaMaestro IS NULL OR IdTablaMaestro=@IdTablaMaestro OR @IdTablaMaestro = 0) ) 
                   AS 
                   DATOS 
            WHERE  ( @INICIO IS NULL AND @NUMEROFILAS IS NULL ) OR ( rownumber BETWEEN @INICIO AND @NUMEROFILAS ) 
        END 
  END 
/*   
EXEC SP_CM_HC_CO_TablaMaestroListar   
6,NULL, NULL, NULL, NULL,   
NULL, NULL, NULL, NULL, NULL,    
'LISTAR', 0,0   
*/ 
GO
/****** Object:  StoredProcedure [dbo].[SP_COMBOSMISCELANEOS]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


 -- =============================================                
-- Author:    Grace Córdova                
-- Create date: 05/08/2015          
-- =============================================          
CREATE OR ALTER PROCEDURE [SP_COMBOSMISCELANEOS]            
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
  @ValorEntero1   INT = NULL,          
  @ValorEntero2   INT = NULL,          
  @ValorEntero3   INT = NULL,          
  @ValorEntero4   INT = NULL,          
  @ValorEntero5   INT = NULL,          
  @ValorEntero6   INT = NULL,          
  @ValorEntero7   INT = NULL          
AS            
BEGIN            
 SET NOCOUNT ON;            
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
         
 IF @ACCION ='COMBOSGENERICOS'            
  BEGIN            
   IF (@CodigoTabla='APLICACIONESMAST')            
    BEGIN            
     insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,            
      DescripcionLocal,ValorCodigo1)            
      Select 'WA','999999', '', APLICACIONCODIGO,              
      DESCRIPCIONCORTA, APLICACIONCODIGO from APLICACIONESMAST          
      select * from @MA_MiscelaneosDetalle            
    END
   ELSE IF (@CodigoTabla='UNITIEMPO')            
BEGIN            
insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,            
 DescripcionLocal,ValorCodigo1)            
Select 'WA','999999', @CodigoTabla, IdCodigo,Nombre,IdCodigo from CM_CO_TablaMaestroDetalle          
where (IdTablaMaestro = '102')          
 select * from @MA_MiscelaneosDetalle            
END  
ELSE IF (@CodigoTabla='TIPRECETA')            
BEGIN            
insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,            
 DescripcionLocal,ValorCodigo1)            
Select 'WA','999999', @CodigoTabla, IdCodigo,Nombre,IdCodigo from CM_CO_TablaMaestroDetalle          
where (IdTablaMaestro = '103')          
 select * from @MA_MiscelaneosDetalle            
END
--Formu Extra
ELSE IF (@CodigoTabla='TIPALERGIA')            
BEGIN            
insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,            
 DescripcionLocal,ValorCodigo1)            
Select 'WA','999999', @CodigoTabla, IdCodigo,Nombre,IdCodigo from CM_CO_TablaMaestroDetalle          
where (IdTablaMaestro = '104')          
 select * from @MA_MiscelaneosDetalle            
END

ELSE IF (@CodigoTabla='SUCURSAL')      
  BEGIN      
insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
Select  'WA','999999',  Sucursal, Sucursal ,    DescripcionLocal, Sucursal from ac_sucursal      
select * from @MA_MiscelaneosDetalle      
  END                
    ELSE IF (@CodigoTabla='COMPANIAMAST')            
    BEGIN            
     insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,            
      DescripcionLocal,ValorCodigo1)            
     Select 'WA','999999', @CodigoTabla, CompaniaCodigo,              
      DescripcionCorta, CompaniaCodigo from CompaniaMast          
      select * from @MA_MiscelaneosDetalle            
    END      
    ELSE IF (@CodigoTabla='TIPOATENCIO')            
    BEGIN            
     insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,            
      DescripcionLocal,ValorCodigo1)            
     Select 'WA','999999', @CodigoTabla, IdTipoAtencion,              
      Descripcion, IdTipoAtencion from SS_GE_TipoAtencion          
      select * from @MA_MiscelaneosDetalle            
    END          
    ELSE IF (@CodigoTabla='TIPOSEXO')            
    BEGIN            
  SELECT * FROM MA_MiscelaneosDetalle          
        WHERE Compania='999999'                  
        AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
        AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla            
    END  

ELSE IF (@CodigoTabla='TIPOSOLUC2')-- Luke 17/06/2019      
    BEGIN            
  SELECT * FROM MA_MiscelaneosDetalle      
        WHERE Compania='999999'                  
        AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
        AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla            
    END    

ELSE IF (@CodigoTabla='TIPOSOLUCI')-- Luke 17/06/2019      
    BEGIN            
  SELECT * FROM MA_MiscelaneosDetalle      
        WHERE Compania='999999'                  
        AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
        AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla            
    END    

ELSE IF (@CodigoTabla='TIPOSOLUC3')-- Luke 17/06/2019      
    BEGIN            
  SELECT * FROM MA_MiscelaneosDetalle      
        WHERE Compania='999999'                  
        AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
        AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla            
    END    
ELSE IF (@CodigoTabla='TURNO')    --luke 19-06-2019        
 BEGIN            
  SELECT * FROM MA_MiscelaneosDetalle        
  WHERE Compania='999999'                  
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla          
 END
  ELSE IF (@CodigoTabla='INDCOMPART')      
 BEGIN      
  select * from MA_MiscelaneosDetalle    
  WHERE Compania='999999'        
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
  AND MA_MiscelaneosDetalle.CodigoTabla =  @CodigoTabla        
 END
    ELSE IF (@CodigoTabla='EXAKAR2')    --luke 20-06-2019        
 BEGIN            
  SELECT * FROM MA_MiscelaneosDetalle
  WHERE Compania='999999'                  
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla          
 END
 
 ELSE IF (@CodigoTabla='TPOPCIONIC')          
 BEGIN          
  SELECT * FROM MA_MiscelaneosDetalle        
  WHERE Compania='999999'    
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')        
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla        
 END    
  ELSE IF (@CodigoTabla='TPOUBICACI')          
 BEGIN          
  SELECT * FROM MA_MiscelaneosDetalle        
  WHERE Compania='999999'    
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')        
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla        
 END  
 ELSE IF (@CodigoTabla='PRIORIDAD')          
 BEGIN          
  SELECT * FROM MA_MiscelaneosDetalle        
  WHERE Compania='999999'    
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')        
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla        
 END
 
 
   ELSE IF (@CodigoTabla='TIPPRONOS')   --luke 10-10-2019          
 BEGIN            
  SELECT * FROM MA_MiscelaneosDetalle
  WHERE Compania='999999'                  
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla          
 END
 
  ELSE IF (@CodigoTabla='TIPOALTA')   --luke 10-10-2019          
 BEGIN            
  SELECT * FROM MA_MiscelaneosDetalle
  WHERE Compania='999999'                  
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla          
 END
 
  ELSE IF (@CodigoTabla='CONEGRESO')   --luke 17-06-2019          
 BEGIN            
  SELECT * FROM MA_MiscelaneosDetalle
  WHERE Compania='999999'                  
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla          
 END    
 ELSE IF (@CodigoTabla='ATENCIONLU')            
    BEGIN            
 SELECT * FROM MA_MiscelaneosDetalle          
        WHERE Compania='999999'                  
        AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
        AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla            
    END    
    ELSE IF (@CodigoTabla='PAISSELECC')            
    BEGIN            
     insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,            
      DescripcionLocal,ValorCodigo1)            
     Select 'WA','999999', @CodigoTabla, RTRIM(Pais)+LTRIM(Estado),              
      Pais + ' : ' + DescripcionCorta, RTRIM(Pais)+LTRIM(Estado) from Pais                
      select * from @MA_MiscelaneosDetalle            
    END          
    ELSE IF (@CodigoTabla='DEPARTAMEN')            
    BEGIN            
     insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,            
      DescripcionLocal,ValorCodigo1)            
     Select  'AW','999999',@CodigoTabla, departamento,          
     DescripcionCorta,  departamento from departamento          
      select * from @MA_MiscelaneosDetalle            
    END            
    ELSE IF (@CodigoTabla='PROVINCIAS')            
 BEGIN            
     insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,            
      DescripcionLocal,ValorCodigo1)            
     Select 'WA','999999', @CodigoTabla, rtrim(Departamento)+ltrim(Provincia),              
     DescripcionCorta, rtrim(Departamento)+ltrim(Provincia) from Provincia                
      select * from @MA_MiscelaneosDetalle            
    END          
    ELSE IF (@CodigoTabla='ZONAPOSTAL')            
    BEGIN            
     insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,            
      DescripcionLocal,ValorCodigo1)            
     Select 'WA','999999', @CodigoTabla, LTRIM(RTRIM(Provincia))+RTRIM(CodigoPostal),              
      DescripcionCorta, LTRIM(RTRIM(Provincia))+RTRIM(CodigoPostal) from ZonaPostal                
      select * from @MA_MiscelaneosDetalle            
    END            
  ELSE IF (@CodigoTabla='TIPOPERSON')            
  BEGIN            
   SELECT * FROM MA_MiscelaneosDetalle          
   WHERE Compania='999999'                  
   AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
   AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla          
  END            
  ELSE IF (@CodigoTabla='TIPODOCUME')            
  BEGIN            
   SELECT * FROM MA_MiscelaneosDetalle          
   WHERE Compania='999999'                  
   AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
   AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla          
  END
  ELSE IF (@CodigoTabla='TIPOPARENT')            
  BEGIN            
   SELECT * FROM MA_MiscelaneosDetalle          
   WHERE Compania='999999'                  
   AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
   AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla
   END                  
  ELSE IF (@CodigoTabla='TIPOREL')            
  BEGIN            
   SELECT * FROM MA_MiscelaneosDetalle          
   WHERE Compania='999999'                  
   AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
   AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla          
  END  
   ELSE IF (@CodigoTabla='RANGETARIO')            
 BEGIN            
  SELECT * FROM MA_MiscelaneosDetalle          
  WHERE Compania='999999'                  
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla          
 END  
   ELSE IF (@CodigoTabla='TIPDOCTRIA')            
  BEGIN            
   SELECT * FROM MA_MiscelaneosDetalle          
   WHERE Compania='999999'                  
   AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
   AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla          
  END

  ELSE IF (@CodigoTabla='TIPOBOOL')            
  BEGIN            
   SELECT * FROM MA_MiscelaneosDetalle          
   WHERE Compania='999999'                  
   AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
   AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla          
  END            
  ELSE IF (@CodigoTabla='ESTADOCIVI')            
  BEGIN            
   SELECT * FROM MA_MiscelaneosDetalle          
   WHERE Compania='999999'                  
   AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
   AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla          
  END            
  ELSE IF (@CodigoTabla='TIPORAZA')            
  BEGIN            
   SELECT * FROM MA_MiscelaneosDetalle          
   WHERE Compania='999999'                  
   AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
   AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla          
  END            
  ELSE IF (@CodigoTabla='TIPOREL')    
  BEGIN            
   SELECT * FROM MA_MiscelaneosDetalle          
   WHERE Compania='999999'                  
   AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
   AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla          
  END          
 ELSE IF (@CodigoTabla='RANGETARIO')            
 BEGIN            
  SELECT * FROM MA_MiscelaneosDetalle          
  WHERE Compania='999999'                  
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla          
 END          
         
    ELSE IF (@CodigoTabla='TIPOTECNOL')            
    BEGIN            
     insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,            
      DescripcionLocal,ValorCodigo1)            
     Select 'WA','999999', @CodigoTabla, IdCodigo,Nombre,IdCodigo from CM_CO_TablaMaestroDetalle          
     where (IdTablaMaestro = '101')          
      select * from @MA_MiscelaneosDetalle            
    END          
         
 ELSE IF (@CodigoTabla='TIPOTRABAJ')            
BEGIN            
insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,            
 DescripcionLocal,ValorCodigo1)            
Select 'WA','999999', @CodigoTabla, TipoTrabajador,DescripcionLocal,TipoTrabajador from ss_tipotrabajador                          
 select * from @MA_MiscelaneosDetalle        
END        
 ELSE IF (@CodigoTabla='INTERCONSU')            
BEGIN            
 SELECT * FROM MA_MiscelaneosDetalle          
 WHERE Compania='999999'                  
 AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
 AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla          
END  

-- FORM EXTRAS
 ELSE IF (@CodigoTabla='INTERCONFE')            
BEGIN            
 SELECT * FROM MA_MiscelaneosDetalle          
 WHERE Compania='999999'                  
 AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
 AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla          
END

  ELSE IF (@CodigoTabla='EXAKAR2')    --melisa 09-10-2019        
 BEGIN            
  SELECT * FROM MA_MiscelaneosDetalle
  WHERE Compania='999999'                  
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla          
 END
 
 ELSE IF (@CodigoTabla='INTKAR2')            
 BEGIN            
  SELECT * FROM MA_MiscelaneosDetalle
  WHERE Compania='999999'                  
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla          
 END

 ELSE IF (@CodigoTabla='DESGARRO')    --luke 19-06-2019        
 BEGIN            
  SELECT * FROM MA_MiscelaneosDetalle        
  WHERE Compania='999999'                  
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla          
 END

 ELSE IF (@CodigoTabla='TIPEXAMEN')            
BEGIN            
 SELECT * FROM MA_MiscelaneosDetalle          
 WHERE Compania='999999'                  
 AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
 AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla          
END

 ELSE IF (@CodigoTabla='ESTACTUAL')            
BEGIN            
 SELECT * FROM MA_MiscelaneosDetalle          
 WHERE Compania='999999'                  
 AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
 AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla          
END
 
     
 ELSE IF (@CodigoTabla='SELECCPAIS')            
    BEGIN            
     insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,            
      DescripcionLocal,ValorCodigo1)            
     Select 'WA','999999', @CodigoTabla, RTRIM(Pais)+LTRIM(Estado),              
      DescripcionCorta, RTRIM(Pais) from Pais                
      select * from @MA_MiscelaneosDetalle            
    END          
    ELSE IF (@CodigoTabla='SELECCDEPA')            
    BEGIN            
     insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,            
      DescripcionLocal,ValorCodigo1)            
     Select  'AW','999999',@CodigoTabla, departamento,          
DescripcionCorta,  departamento from departamento          
     where (@ValorCodigo1 is null or Pais like '%'+UPPER(@ValorCodigo1)+'%')          
      select * from @MA_MiscelaneosDetalle            
    END            
    ELSE IF (@CodigoTabla='SELECCPROV')            
    BEGIN            
     insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,            
      DescripcionLocal,ValorCodigo1)                
      Select 'WA','999999', @CodigoTabla, (Provincia),              
      DescripcionCorta,(Provincia) from Provincia                
      where (@ValorCodigo1 is null or Departamento like '%'+UPPER(@ValorCodigo1)+'%')          
      select * from @MA_MiscelaneosDetalle            
    END          
    ELSE IF (@CodigoTabla='SELECCPOST')            
    BEGIN            
     insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,            
      DescripcionLocal,ValorCodigo1)            
     Select 'WA','999999', @CodigoTabla, LTRIM(RTRIM(Provincia))+RTRIM(CodigoPostal),              
      DescripcionCorta, LTRIM(RTRIM(Provincia))+RTRIM(CodigoPostal) from ZonaPostal          
      where (@ValorCodigo1 is null or Departamento like '%'+UPPER(substring(@ValorCodigo1,0,4))+'%')          
      and (@ValorCodigo2 is null or Provincia like '%'+UPPER(substring(@ValorCodigo2,3,2))+'%')          
      select * from @MA_MiscelaneosDetalle            
    END          
        ELSE IF (@CodigoTabla='TIPOMODULO')            
 BEGIN            
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)            
  Select  'CG','99999',Sistema,Modulo,Nombre,  Modulo from dbo.SG_Modulo          
  where Estado =2          
  and (@ValorCodigo1 is null or Sistema = @ValorCodigo1 or @ValorCodigo1 = '')          
  select * from @MA_MiscelaneosDetalle            
 END          
  ELSE IF (@CodigoTabla='TIPATEN')            
 BEGIN            
 insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal,ValorCodigo1)            
    SELECT 'WA','999999',@CodigoTabla,CM_CO_TablaMaestroDetalle.IdCodigo, CM_CO_TablaMaestroDetalle.Nombre,CM_CO_TablaMaestroDetalle.IdCodigo FROM CM_CO_TablaMaestroDetalle WHERE CM_CO_TablaMaestroDetalle.IdTablaMaestro= 101      
    select * from @MA_MiscelaneosDetalle          
 END            
 ELSE IF (@CodigoTabla='VOF')            
 BEGIN            
  SELECT * FROM MA_MiscelaneosDetalle          
  WHERE Compania='999999'                  
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla          
 END    
 ELSE IF(@CodigoTabla = 'ESTABLEC')    
    BEGIN        
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento, DescripcionLocal ,ValorCodigo1)--, ValorCodigo2, Estado, ValorCodigo3)        
  SELECT 'WA','999999',  @CodigoTabla,dbo.CM_CO_Establecimiento.Codigo,   dbo.CM_CO_Establecimiento.Nombre,dbo.CM_CO_Establecimiento.IdEstablecimiento        
 FROM dbo.AC_Sucursal INNER JOIN        
   dbo.CM_CO_Establecimiento ON dbo.AC_Sucursal.Sucursal = dbo.CM_CO_Establecimiento.Sucursal INNER JOIN        
   dbo.SY_SeguridadAutorizaciones ON dbo.AC_Sucursal.Sucursal = dbo.SY_SeguridadAutorizaciones.Concepto        
 where ltrim(SY_SeguridadAutorizaciones.Usuario) = @ValorCodigo5        
   and (@ValorCodigo1 is null or CM_CO_Establecimiento.Compania = @ValorCodigo1)  
   and (@ValorCodigo2 is null or CM_CO_Establecimiento.Sucursal = @ValorCodigo2)  
       select * from @MA_MiscelaneosDetalle                      
    END                
 ELSE IF (@CodigoTabla='TIPOAUD')            
 BEGIN            
  SELECT * FROM MA_MiscelaneosDetalle          
  WHERE Compania='999999'                  
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla          
 END  
 ELSE IF (@CodigoTabla='LISTSERV')--LUKE 19/06/2019          
    BEGIN            
     SELECT * FROM MA_MiscelaneosDetalle        
  WHERE Compania='999999'                  
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')          
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla          
             
    END  
     
 ELSE IF (@CodigoTabla='TODOLUGAR')            
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
 --select * from @MA_MiscelaneosDetalle          
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
--WHERE(@ValorEntero1 IS NULL AND @ValorEntero2 IS NULL)          
--OR (ROWNUMBER BETWEEN @ValorEntero1 AND @ValorEntero2)          
 END          
  END            
END            
/*          
EXEC SP_CombosMiscelaneos          
'WA','TODOLUGAR','999999',NULL,NULL,          
NULL,NULL,'','','',          
NULL,NULL,NULL,NULL,'COMBOSGENERICOS',NULL,          
NULL,NULL,NULL,          
NULL,NULL,NULL          
*/  
GO
/****** Object:  StoredProcedure [dbo].[SP_DescansoMedico]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE OR ALTER PROCEDURE [SP_DescansoMedico]
	@UnidadReplicacion  char(4) ,
	@IdEpisodioAtencion  bigint ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@FechaInicioDescanso  datetime,
	@FechaFinDescanso  datetime,
	@Observacion  varchar(500),
	@Estado  int,
	@UsuarioCreacion  varchar(25),
	@FechaCreacion  datetime,
	@UsuarioModificacion  varchar(25),
	@FechaModificacion  datetime,
	@Accion  varchar(25),
	@Version  varchar(25),
	@Dias int
	
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @IdEpisodioAtencionId as INTEGER,
	 @EpisodioClinicoID as INTEGER, @ExisteCodigo as VARCHAR(10),
	 @SecuenciaID as Integer
	 set @IdEpisodioAtencionId = @IdEpisodioAtencion
		
	 IF @Accion = 'NUEVO'
		BEGIN
			Insert into dbo.SS_HC_DescansoMedico(UnidadReplicacion, IdEpisodioAtencion, IdPaciente, 
				EpisodioClinico, 
				FechaInicioDescanso, FechaFinDescanso, Observacion, Estado, 
				UsuarioCreacion, FechaCreacion, 
				UsuarioModificacion, FechaModificacion, Accion, Version , Dias)
			values (@UnidadReplicacion,	@IdEpisodioAtencion,	@IdPaciente,	
				@EpisodioClinico,	
				@FechaInicioDescanso,	@FechaFinDescanso,	@Observacion,	2,	
				@UsuarioCreacion,	GETDATE(),	
				@UsuarioModificacion, GETDATE(),	'CCEP0312',	@Version, 	@Dias )
 			select @IdEpisodioAtencionId;
		END
		IF @Accion ='UPDATE'
			BEGIN
				update  SS_HC_DescansoMedico
				Set  FechaInicioDescanso=@FechaInicioDescanso,	 FechaFinDescanso=@FechaFinDescanso,
					 Observacion=@Observacion,	 Estado=@Estado,	 
					 UsuarioCreacion=@UsuarioCreacion,	FechaCreacion= getdate() ,
					 UsuarioModificacion=@UsuarioModificacion,	 
					 FechaModificacion=GETDATE(),	  	 
					 Version=@Version, Dias = @Dias
				 Where  IdEpisodioAtencion = @IdEpisodioAtencion
				 And	EpisodioClinico =@EpisodioClinico
				 And	IdPaciente =@IdPaciente
 
				select @IdEpisodioAtencionId;
			END
			
				
 
END
	 
		 
GO
/****** Object:  StoredProcedure [dbo].[SP_DescansoMedico_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_DescansoMedico_FE]
	@UnidadReplicacion  char(4) ,
	@IdEpisodioAtencion  bigint ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@FechaInicioDescanso  datetime,
	@FechaFinDescanso  datetime,
	@Observacion  varchar(500),
	@Estado  int,
	@UsuarioCreacion  varchar(25),
	@FechaCreacion  datetime,
	@UsuarioModificacion  varchar(25),
	@FechaModificacion  datetime,
	@Accion  varchar(25),
	@Version  varchar(25),
	@Dias int,
	@Fecha  datetime,
	@IdDiagnostico int, 
	@IdFormaInicio int --SECUENCIA
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
				update  SS_HC_DescansoMedico_FE
				Set  FechaInicioDescanso=@FechaInicioDescanso,	 
					 FechaFinDescanso=@FechaFinDescanso,
					 Observacion=@Observacion,	 
					 Estado=@Estado,	 
					 UsuarioCreacion=@UsuarioCreacion,	
					 FechaCreacion= @FechaCreacion,
					 UsuarioModificacion=@UsuarioModificacion,	 
					 FechaModificacion=@FechaModificacion,	  	 
					 Accion = @Accion,
					 Dias = @Dias,
					 fecha=@Fecha,
					 IdFormaInicio=@IdFormaInicio

				 Where  
					IdEpisodioAtencion = @IdEpisodioAtencion
					And	EpisodioClinico =@EpisodioClinico
					And	IdPaciente =@IdPaciente
 
				select @IdEpisodioAtencionId;
		END
				
	IF @Accion = 'NUEVO' -- Insertar Cabecera
		BEGIN
			Insert into dbo.SS_HC_DescansoMedico_FE
				(UnidadReplicacion, IdEpisodioAtencion, IdPaciente, 
				EpisodioClinico, 
				FechaInicioDescanso, FechaFinDescanso, Observacion, Estado, 
				UsuarioCreacion, FechaCreacion, 
				UsuarioModificacion, FechaModificacion, Accion, Version , Dias, IdFormaInicio)
			values 
				(@UnidadReplicacion,	@IdEpisodioAtencion,	@IdPaciente,	
				@EpisodioClinico,	
				@FechaInicioDescanso,	@FechaFinDescanso,	@Observacion,	2,	
				@UsuarioCreacion,	GETDATE(),	
				@UsuarioModificacion, GETDATE(),@Accion,'CCEPF300',@Dias, @IdFormaInicio )
 			select @IdEpisodioAtencionId;
 			
		END

	IF @ACCION ='UPDATEDETALLE'  --Actualizar DETALLE
		BEGIN          

   			UPDATE SS_HC_DescansoMedico_Diagnostico_FE 
			SET 
				IdDiagnostico=	@IdDiagnostico,
				Accion = @Accion
				
			Where	
			UnidadReplicacion = @UnidadReplicacion
			and		IdEpisodioAtencion = @IdEpisodioAtencion
			and IdPaciente =@IdPaciente 
			and		EpisodioClinico = @EpisodioClinico
			and Secuencia = @IdFormaInicio

			select @IdEpisodioAtencionId;

		END  
	
	IF @ACCION ='INSERTDETALLE'  --Insertar DETALLE
		BEGIN  
		   select @SecuenciaID = ISNULL(max(Secuencia),0) + 1   from SS_HC_DescansoMedico_Diagnostico_FE  
           
  
		   insert into SS_HC_DescansoMedico_Diagnostico_FE
		   ( UnidadReplicacion, IdEpisodioAtencion, IdPaciente,   
			EpisodioClinico, Secuencia, IdDiagnostico,Accion)  
		   values 
		   (@UnidadReplicacion, @IdEpisodioAtencion, @IdPaciente,   
			@EpisodioClinico, @SecuenciaID, @IdDiagnostico,@Accion )  
      
		   select @IdEpisodioAtencionId;  
      
		END 	

	IF @ACCION ='DELETE'  --Borrar DETALLE
		BEGIN  
    
			DELETE SS_HC_DescansoMedico_Diagnostico_FE   
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
/****** Object:  StoredProcedure [dbo].[SP_DescansoMedicoListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE OR ALTER PROCEDURE  [dbo].[SP_DescansoMedicoListar]
	@UnidadReplicacion  char(4) ,
	@IdEpisodioAtencion  bigint ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@FechaInicioDescanso  datetime,
	@FechaFinDescanso  datetime,
	@Observacion  varchar(500),
	@Estado  int,
	@UsuarioCreacion  varchar(25),
	@FechaCreacion  datetime,
	@UsuarioModificacion  varchar(25),
	@FechaModificacion  datetime,
	@Accion  varchar(25),
	@Version  varchar(25),
	@Dias int
	
	
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @IdEpisodioAtencionId as INTEGER,
	 @EpisodioClinicoID as INTEGER, @ExisteCodigo as VARCHAR(10),
	 @SecuenciaID as Integer
	 set @IdEpisodioAtencionId = @IdEpisodioAtencion
		
	 IF @Accion = 'LISTAR'
		BEGIN
		Select * From SS_HC_DescansoMedico 
		Where	IdPaciente = @IdPaciente 
		AND		IdEpisodioAtencion = @IdEpisodioAtencion
		AND		EpisodioClinico= @EpisodioClinico
		
		END
 
 
END
	 
		 
GO
/****** Object:  StoredProcedure [dbo].[SP_DescansoMedicoListar_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE  [dbo].[SP_DescansoMedicoListar_FE]
	@UnidadReplicacion  char(4) ,
	@IdEpisodioAtencion  bigint ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@FechaInicioDescanso  datetime,
	@FechaFinDescanso  datetime,
	@Observacion  varchar(500),
	@Estado  int,
	@UsuarioCreacion  varchar(25),
	@FechaCreacion  datetime,
	@UsuarioModificacion  varchar(25),
	@FechaModificacion  datetime,
	@Accion  varchar(25),
	@Version  varchar(25),
	@Dias int,
	@IdFormaInicio int
	
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
		Select * From SS_HC_DescansoMedico_FE 
		Where	IdPaciente = @IdPaciente 
		AND		IdEpisodioAtencion = @IdEpisodioAtencion
		AND		EpisodioClinico= @EpisodioClinico
		AND		UnidadReplicacion= @UnidadReplicacion
		END
 
 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DetalleMiscelaneos]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_DetalleMiscelaneos]    

		@AplicacionCodigo varchar(2),
		@CodigoTabla varchar(20),
		@Compania varchar(6),
		@CodigoElemento varchar(20),
		@DescripcionLocal varchar(100),
		@DescripcionExtranjera Varchar(100),
		@ValorNumerico float,
		@ValorCodigo1 varchar(300),
		@ValorCodigo2 varchar(300),
		@ValorCodigo3 varchar(300),
		@ValorCodigo4 varchar(300),
		@ValorCodigo5 varchar(300),
		@ValorFecha datetime,
		@Estado char,
		@UltimoUsuario varchar(25),
		@UltimaFechaModif datetime,
		@Timestamp timestamp,
		@ACCION varchar(25),
		@RowID int,
		@ValorEntero1 int,
		@ValorEntero2 int,
		@ValorEntero3 int,
		@ValorEntero4 int,
		@ValorEntero5 int,
		@ValorCodigo6 varchar(25),
		@ValorCodigo7 varchar(25),
		@ValorEntero6 int,
		@ValorEntero7 int
     
AS    
BEGIN    
SET NOCOUNT ON;  
BEGIN  TRANSACTION  
  
 DECLARE @CONTADOR INT  
 IF(@Accion = 'INSERT')  
 BEGIN   
		
  INSERT INTO MA_MiscelaneosDetalle  
  (  
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
  )  
    VALUES  
  (   
		@AplicacionCodigo,
		@CodigoTabla,
		@Compania,
		@CodigoElemento,
		@DescripcionLocal,
		@DescripcionExtranjera,
		@ValorNumerico,
		@ValorCodigo1,
		@ValorCodigo2,
		@ValorCodigo3,
		@ValorCodigo4,
		@ValorCodigo5,
		@ValorFecha,
		@Estado,
		@UltimoUsuario,
		GETDATE(),
		default,
		@ACCION,
		@RowID,
		@ValorEntero1,
		@ValorEntero2,
		@ValorEntero3,
		@ValorEntero4,
		@ValorEntero5,
		@ValorCodigo6,
		@ValorCodigo7,
		@ValorEntero6,
		@ValorEntero7
  )  
  
 SELECT 1		 
 END   
 ELSE  
 IF(@Accion = 'UPDATE')  
 BEGIN  
 UPDATE MA_MiscelaneosDetalle  
  SET      
		AplicacionCodigo = @AplicacionCodigo,
		CodigoTabla = @CodigoTabla,
		Compania = @Compania,
		CodigoElemento = @CodigoElemento,
		DescripcionLocal = @DescripcionLocal,
		DescripcionExtranjera = @DescripcionExtranjera,
		ValorNumerico = @ValorNumerico,
		ValorCodigo1 = @ValorCodigo1,
		ValorCodigo2 = @ValorCodigo2,
		ValorCodigo3 = @ValorCodigo3,
		ValorCodigo4 = @ValorCodigo4,
		ValorCodigo5 = @ValorCodigo5,
		ValorFecha = @ValorFecha, 
		Estado = @Estado,
		UltimoUsuario = @UltimoUsuario,
		UltimaFechaModif = GETDATE(),
		--Timestamp = @Timestamp,
		ACCION = @ACCION,
		RowID = @RowID,
		ValorEntero1 = @ValorEntero1,
		ValorEntero2 = @ValorEntero2,
		ValorEntero3 = @ValorEntero3,
		ValorEntero4 = @ValorEntero4,
		ValorEntero5 = @ValorEntero5,
		ValorCodigo6 = @ValorCodigo6,
		ValorCodigo7 = @ValorCodigo7,
		ValorEntero6 = @ValorEntero6,
		ValorEntero7 = @ValorEntero7
		WHERE 
		(CodigoTabla = @CodigoTabla)  
		and (CodigoElemento = @CodigoElemento)
   		select 1
 end   
 else  
 if(@Accion = 'DELETE')  
 begin  
  delete MA_MiscelaneosDetalle  
		WHERE 
		(CodigoTabla = @CodigoTabla)  
		and (CodigoElemento = @CodigoElemento) 
   		select 1
end
		if(@Accion = 'CONTARLISTAPAG')
	begin		
		
	SET @CONTADOR=(SELECT COUNT(*)       
     FROM MA_MiscelaneosDetalle      
     WHERE           
		 (@AplicacionCodigo is null OR AplicacionCodigo = @AplicacionCodigo)  
     and (@CodigoTabla is null OR CodigoTabla = @CodigoTabla)   
     and (@Compania is null OR Compania = @Compania)       
     )  
					
		select @CONTADOR
	end
commit	 
END  
GO
/****** Object:  StoredProcedure [dbo].[SP_DetalleMiscelaneos_Lista]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_DetalleMiscelaneos_Lista]    

		@AplicacionCodigo varchar(2),
		@CodigoTabla varchar(20),
		@Compania varchar(6),
		@CodigoElemento varchar(20),
		@DescripcionLocal varchar(100),
		@DescripcionExtranjera Varchar(100),
		@ValorNumerico float,
		@ValorCodigo1 varchar(5),
		@ValorCodigo2 char,
		@ValorCodigo3 char,
		@ValorCodigo4 char,
		@ValorCodigo5 char,
		@ValorFecha datetime,
		@Estado char,
		@UltimoUsuario varchar(25),
		@UltimaFechaModif datetime,
		@Timestamp timestamp,
		@ACCION varchar(25),
		@RowID int,
		@ValorEntero1 int,
		@ValorEntero2 int,
		@ValorEntero3 int,
		@ValorEntero4 int,
		@ValorEntero5 int,
		@ValorCodigo6 varchar(25),
		@ValorCodigo7 varchar(25),
		@ValorEntero6 int,
		@ValorEntero7 int,    
		
		@INICIO   int= null,    
		@NUMEROFILAS int = null  
     
AS    
BEGIN   

 IF(@ACCION = 'LISTARPAGMAESTRO')      
 BEGIN      
	DECLARE @CONTADOR INT;
         
	SET @CONTADOR=(SELECT COUNT(*)       
     FROM MA_MiscelaneosDetalle      
     WHERE           
		 (@AplicacionCodigo is null OR AplicacionCodigo = @AplicacionCodigo)  
     and (@CodigoTabla is null OR CodigoTabla = @CodigoTabla)   
     and (@Compania is null OR Compania = @Compania)       
     )     
        
  SELECT     
		AplicacionCodigo       
      ,CodigoTabla 
      ,Compania   
      ,CodigoElemento    
      ,DescripcionLocal     
      ,DescripcionExtranjera      
	  ,ValorNumerico            
      ,ValorCodigo1      
      ,ValorCodigo2      
      ,ValorCodigo3      
      ,ValorCodigo4      
      ,ValorCodigo5      
      ,ValorFecha      
      ,Estado      
      ,UltimoUsuario      
      ,UltimaFechaModif      
      ,Timestamp      
      ,ACCION      
      ,RowID      
      ,convert(int,ROW_NUMBER() OVER (ORDER BY ValorEntero1 ASC )) as   ValorEntero1     
      ,ValorEntero2      
      ,ValorEntero3      
      ,ValorEntero4      
      ,ValorEntero5      
      ,ValorCodigo6      
	  ,ValorCodigo7      
      ,ValorEntero6      
      ,ValorEntero7           
  FROM (SELECT      
     MA_MiscelaneosDetalle.*                  
      ,@CONTADOR AS Contador,      
            ROW_NUMBER() OVER (ORDER BY AplicacionCodigo ASC ) AS RowNumber          
     FROM MA_MiscelaneosDetalle      
     WHERE    
	     (@AplicacionCodigo is null  OR @AplicacionCodigo =''  OR  upper(AplicacionCodigo) like '%'+upper(@AplicacionCodigo)+'%')     
     and (@CodigoTabla is null  OR @CodigoTabla =''  OR  upper(CodigoTabla) like '%'+upper(@CodigoTabla)+'%')   
     and (@Compania is null OR @Compania ='' OR  upper(Compania) like '%'+upper(@Compania)+'%')       
     and (@CodigoElemento is null OR @CodigoElemento='' OR  upper(CodigoElemento) like '%'+upper(@CodigoElemento)+'%')     
     and (@DescripcionLocal is null  OR @DescripcionLocal =''  OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')             
     and (@DescripcionExtranjera is null OR @DescripcionExtranjera =''  OR  upper(DescripcionExtranjera) like '%'+upper(@DescripcionExtranjera)+'%')      
     ) AS LISTADO      
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR        
            RowNumber BETWEEN @Inicio  AND @NumeroFilas       
 end   
    
 else   
  if(@ACCION = 'LISTAR')      
 begin      
        
  SELECT       
		AplicacionCodigo       
      ,CodigoTabla 
      ,Compania   
      ,CodigoElemento    
      ,DescripcionLocal     
      ,DescripcionExtranjera      
	  ,ValorNumerico            
      ,ValorCodigo1      
      ,ValorCodigo2      
      ,ValorCodigo3      
      ,ValorCodigo4      
      ,ValorCodigo5      
      ,ValorFecha      
      ,Estado      
      ,UltimoUsuario      
      ,UltimaFechaModif      
      ,Timestamp      
      ,ACCION      
      ,RowID      
      ,convert(int,ROW_NUMBER() OVER (ORDER BY ValorEntero1 ASC )) as   ValorEntero1     
      ,ValorEntero2      
      ,ValorEntero3      
      ,ValorEntero4      
      ,ValorEntero5      
      ,ValorCodigo6      
	  ,ValorCodigo7      
      ,ValorEntero6      
      ,ValorEntero7          
     FROM MA_MiscelaneosDetalle      
     WHERE        
      (@Timestamp is null OR Timestamp = @Timestamp)    
 
   
 end  
 
END
GO

/****** Object:  StoredProcedure [dbo].[SP_Diagnostico_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE OR ALTER PROCEDURE  [dbo].[SP_Diagnostico_FE]
	@UnidadReplicacion  varchar(4) ,
	@IdEpisodioAtencion  bigint ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@Secuencia  int ,
	@FechaRegistro datetime,
	@IdDiagnostico  int,
	@IdDiagnosticoValoracion  int,
	@DeterminacionDiagnostica  char(2),
	@IdDiagnosticoPrincipal  int,
	@GradoAfeccion  varchar(2),
	@Observacion  varchar(250),
	@IndicadorAntecedente  int,
	@TipoAntecedente  varchar(2),
	@IndicadorPreExistencia int,
	@IndicadorCronico int,
	@IndicadorNuevo int,
	@DetalleDiagnostico varchar(200),
	@Estado  int,
	@UsuarioCreacion  varchar(25),
	@FechaCreacion  datetime,
	@UsuarioModificacion  varchar(25),
	@FechaModificacion  datetime,
	@Accion  varchar(25),
	@Version  varchar(25)
	
AS
BEGIN
	SET NOCOUNT ON;
 	DECLARE @IdEpisodioAtencionId as INTEGER, @ExisteCodigo as VARCHAR(10), @IDSecuencia AS INT
 	set @IdEpisodioAtencionId = @IdEpisodioAtencion
	 IF @Accion = 'NUEVO'
		BEGIN

			Select @IDSecuencia = ISNULL(max(Secuencia),0)+1  from SS_HC_Diagnostico_FE	WHERE  UnidadReplicacion = @UnidadReplicacion AND 
					 IdEpisodioAtencion = @IdEpisodioAtencion AND   IdPaciente = @IdPaciente AND  EpisodioClinico = @EpisodioClinico
			
			DECLARE @var varchar(15)

			EXEC SP_SS_HC_Correlativo '00000000','CEG' ,'HC',@NroPeticion=@var output
			--select @var 
			SET ANSI_WARNINGS  ON;
			Insert into SS_HC_Diagnostico_FE  (UnidadReplicacion, IdEpisodioAtencion, IdPaciente, EpisodioClinico, 
				Secuencia, FechaRegistro, IdDiagnostico, IdDiagnosticoValoracion, DeterminacionDiagnostica, 
				IdDiagnosticoPrincipal, GradoAfeccion, Observacion, IndicadorAntecedente,
				TipoAntecedente, IndicadorPreExistencia, IndicadorCronico, IndicadorNuevo,
				DetalleDiagnostico, Estado, UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion,	 Accion, Version,SecuencialHCE)
			
			values (@UnidadReplicacion, 	@IdEpisodioAtencion, 	@IdPaciente, 	@EpisodioClinico, 	
				@IDSecuencia, 	@FechaRegistro, @IdDiagnostico, 	@IdDiagnosticoValoracion, 	@DeterminacionDiagnostica, 	
				@IdDiagnosticoPrincipal, 	@GradoAfeccion, 	@Observacion, 	@IndicadorAntecedente,
				@TipoAntecedente,  @IndicadorPreExistencia, @IndicadorCronico, @IndicadorNuevo,
				@DetalleDiagnostico, 2, 	@UsuarioCreacion, GETDATE(), 	@UsuarioCreacion, GETDATE(), @Accion, 	@Version,@var)
			SET ANSI_WARNINGS  off;

			select @IDSecuencia;
		END
		IF @Accion ='UPDATE'
			BEGIN
			
			update  SS_HC_Diagnostico_FE set	 IdDiagnostico=@IdDiagnostico, 	 
				IdDiagnosticoValoracion=@IdDiagnosticoValoracion, 	 DeterminacionDiagnostica=@DeterminacionDiagnostica, 	 
				IdDiagnosticoPrincipal=@IdDiagnosticoPrincipal, 	 
				IndicadorAntecedente= @IndicadorAntecedente, GradoAfeccion=@GradoAfeccion, 	 
				Observacion=@Observacion, 	 TipoAntecedente=@TipoAntecedente, IndicadorPreExistencia=@IndicadorPreExistencia, 	 
				IndicadorCronico=@IndicadorCronico, IndicadorNuevo=@IndicadorNuevo, 	 Estado=@Estado, 	
				UsuarioModificacion=@UsuarioModificacion, 	 Accion=@Accion,Version=@Version,
				FechaModificacion=GETDATE()
			 Where  IdPaciente =@IdPaciente
			 and	EpisodioClinico = @EpisodioClinico
			 and	IdEpisodioAtencion = @IdEpisodioAtencion
			 and	Secuencia  = @Secuencia
            select @Secuencia;
			 
			END
		IF @Accion ='DELETE'
			BEGIN
					 
			 DELETE FROM SS_HC_Diagnostico_FE
			 Where  IdPaciente =@IdPaciente
			 and	EpisodioClinico = @EpisodioClinico
			 and	IdEpisodioAtencion = @IdEpisodioAtencionId
			 and	Secuencia  = @Secuencia
			select @Secuencia;	 
			 
			END			

END
GO
/****** Object:  StoredProcedure [dbo].[SP_DiagnosticoListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE OR ALTER PROCEDURE  [dbo].[SP_DiagnosticoListar]  
	@UnidadReplicacion  char(4) ,
	@IdEpisodioAtencion  bigint ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@Secuencia  int ,
	@FechaRegistro datetime,
	@IdDiagnostico  int,
	@IdDiagnosticoValoracion  int,
	@DeterminacionDiagnostica  char(2),
	@IdDiagnosticoPrincipal  int,
	@GradoAfeccion  char(2),
	@Observacion  varchar(250),
	@IndicadorAntecedente  int,
	@TipoAntecedente  char(2),
	@IndicadorPreExistencia int,
	@IndicadorCronico int,
	@IndicadorNuevo int,
	@DetalleDiagnostico varchar(200),
	@Estado  int,
	@UsuarioCreacion  varchar(25),
	@FechaCreacion  datetime,
	@UsuarioModificacion  varchar(25),
	@FechaModificacion  datetime,
	@Accion  varchar(25),
	@Version  varchar(25)
   
AS  
BEGIN  
 SET NOCOUNT ON;  
  DECLARE @IdEpisodioAtencionId as INTEGER, @ExisteCodigo as VARCHAR(10), @IDSecuencia AS INT  
  IF @Accion ='LISTAR'  
   BEGIN  
    Select  
		diag_HC. UnidadReplicacion
      ,diag_HC. IdEpisodioAtencion
      ,diag_HC. IdPaciente
      ,diag_HC. EpisodioClinico
      ,diag_HC. Secuencia
      ,diag_HC. FechaRegistro
      ,diag_HC. IdDiagnostico
      ,diag_HC. IdDiagnosticoValoracion
      ,diag_HC. DeterminacionDiagnostica
      ,diag_HC. IdDiagnosticoPrincipal
      ,diag_HC. GradoAfeccion
      ,diag_HC. Observacion
      ,diag_HC. IndicadorAntecedente
      ,diag_HC. TipoAntecedente
      ,diag_HC. IndicadorPreExistencia
      ,diag_HC. IndicadorCronico
      ,diag_HC. IndicadorNuevo
      ,isnull(diag_HC. DetalleDiagnostico,diag_MAST.Nombre) as DetalleDiagnostico
      ,diag_HC. Estado
      ,diag_HC. UsuarioCreacion
      ,diag_HC. FechaCreacion
      ,diag_HC. UsuarioModificacion
      ,diag_HC. FechaModificacion
      ,diag_HC. Accion
      ,diag_HC. Version        
    from SS_HC_Diagnostico  diag_HC
    left join SS_GE_Diagnostico diag_MAST on (diag_MAST.IdDiagnostico = diag_HC.IdDiagnostico )
    Where	IdPaciente =@IdPaciente  
    AND		EpisodioClinico = @EpisodioClinico  
	AND		IdEpisodioAtencion = @IdEpisodioAtencion  
   END  
   
END  
   
   
GO
/****** Object:  StoredProcedure [dbo].[SP_DiagnosticoListar_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[SP_DiagnosticoListar_FE]  
	@UnidadReplicacion  char(4) ,
	@IdEpisodioAtencion  bigint ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@Secuencia  int ,
	@FechaRegistro datetime,
	@IdDiagnostico  int,
	@IdDiagnosticoValoracion  int,
	@DeterminacionDiagnostica  char(2),
	@IdDiagnosticoPrincipal  int,
	@GradoAfeccion  char(2),
	@Observacion  varchar(250),
	@IndicadorAntecedente  int,
	@TipoAntecedente  char(2),
	@IndicadorPreExistencia int,
	@IndicadorCronico int,
	@IndicadorNuevo int,
	@DetalleDiagnostico varchar(200),
	@Estado  int,
	@UsuarioCreacion  varchar(25),
	@FechaCreacion  datetime,
	@UsuarioModificacion  varchar(25),
	@FechaModificacion  datetime,
	@Accion  varchar(25),
	@Version  varchar(25)
   
AS  
BEGIN  
 SET NOCOUNT ON;  
  DECLARE @IdEpisodioAtencionId as INTEGER, @ExisteCodigo as VARCHAR(10), @IDSecuencia AS INT  
  IF @Accion ='LISTAR'  
   BEGIN  
    Select  
		diag_HC. UnidadReplicacion
      ,diag_HC. IdEpisodioAtencion
      ,diag_HC. IdPaciente
      ,diag_HC. EpisodioClinico
      ,diag_HC. Secuencia
      ,diag_HC. FechaRegistro
      ,diag_HC. IdDiagnostico
      ,diag_HC. IdDiagnosticoValoracion
      ,diag_HC. DeterminacionDiagnostica
      ,diag_HC. IdDiagnosticoPrincipal
      ,diag_HC. GradoAfeccion
      ,diag_HC. Observacion
      ,diag_HC. IndicadorAntecedente
      ,diag_HC. TipoAntecedente
      ,diag_HC. IndicadorPreExistencia
      ,diag_HC. IndicadorCronico
      ,diag_HC. IndicadorNuevo
      ,isnull(diag_HC. DetalleDiagnostico,diag_MAST.Nombre) as DetalleDiagnostico
      ,diag_HC. Estado
      ,diag_HC. UsuarioCreacion
      ,diag_HC. FechaCreacion
      ,diag_HC. UsuarioModificacion
      ,diag_HC. FechaModificacion
      ,diag_HC. Accion
      ,diag_HC. Version        
    from SS_HC_Diagnostico_FE  diag_HC
    left join SS_GE_Diagnostico diag_MAST on (diag_MAST.IdDiagnostico = diag_HC.IdDiagnostico )	
    Where	IdPaciente =  @IdPaciente  	
    AND		EpisodioClinico = @EpisodioClinico  
	AND		IdEpisodioAtencion = @IdEpisodioAtencion  
	AND     UnidadReplicacion = @UnidadReplicacion

   END  
   
  IF @Accion ='LISTAROA'  
   BEGIN  
   Select  TOP 1
		diag_HC.UnidadReplicacion
      ,diag_HC.IdEpisodioAtencion
      ,diag_HC.IdPaciente
      ,diag_HC.EpisodioClinico
      ,diag_HC.Secuencia
      ,diag_HC.FechaRegistro
      ,diag_HC.IdDiagnostico
      ,diag_HC.IdDiagnosticoValoracion
      ,diag_HC.DeterminacionDiagnostica
      ,diag_HC.IdDiagnosticoPrincipal
      ,diag_HC.GradoAfeccion
      ,diag_HC.Observacion
      ,diag_HC.IndicadorAntecedente
      ,diag_HC.TipoAntecedente
      ,diag_HC.IndicadorPreExistencia
      ,diag_HC.IndicadorCronico
      ,diag_HC.IndicadorNuevo
      ,isnull(diag_HC. DetalleDiagnostico,diag_MAST.Nombre) as DetalleDiagnostico
      ,diag_HC.Estado
      ,diag_HC.UsuarioCreacion
      ,diag_HC.FechaCreacion
      ,diag_HC.UsuarioModificacion
      ,diag_HC.FechaModificacion
      ,diag_HC.Accion
      ,diag_HC.Version        
    from SS_HC_Diagnostico_FE  diag_HC inner join SS_HC_EpisodioAtencion  
				on SS_HC_EpisodioAtencion.IdPaciente=diag_HC.IdPaciente 
    left join SS_GE_Diagnostico diag_MAST on (diag_MAST.IdDiagnostico = diag_HC.IdDiagnostico )	
    Where	diag_HC.IdPaciente =  @IdPaciente  	and  SS_HC_EpisodioAtencion.CodigoOA=@UsuarioModificacion 
    
	ORDER BY diag_HC.EpisodioClinico desc, diag_HC.IdEpisodioAtencion desc

   end

END     

GO
/****** Object:  StoredProcedure [dbo].[SP_EnfermedadActual_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_EnfermedadActual_FE]
	@UnidadReplicacion		char(4) ,
	@IdEpisodioAtencion		bigint ,
	@IdPaciente				int ,
	@EpisodioClinico		int ,
	@TipoAnamnesis			char(1),
	@TipoAnamnesisDescrip	varchar(100),
	@MotivoIngreso			varchar(150),
	@FormaInicio			char(1),
	@CursoEnfermedad		char(1),
	@TiempoEnfermedad		int,
	@TiempoEnfermedadUnidad	char(1),
	@RelatoCronologico		text,
	@Apetito				char(1),
	@Sed					char(1),
	@Sudor					char(1),
	@Animo					varchar(100),
	@Orina					char(1),
	@Orina_Roja				char(1),
	@Orina_Espumosa			char(1),
	@Orina_Otros			varchar(150),
	@Deposiciones			varchar(250),
	@Deposiciones_Moco		char(1),
	@Deposiciones_Sangre	char(1),
	@Deposiciones_Otros		varchar(150),
	@Sueño					char(1),
	@PesoHabitual			char(1),
	@PesoHabitualSub		int,
	@FechaSolicitada		datetime,
	@Estado					int,
	@UsuarioCreacion		varchar(25),
	@FechaCreacion			datetime,
	@UsuarioModificacion	varchar(25),
	@FechaModificacion		datetime,
	@Accion					varchar(25),
	@Version				varchar(25),
	@Sintomas				varchar(300),
	@Secuencia				int
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
    Select * From   dbo.SS_HC_EnfermedadActual_FE   
    Where IdPaciente = @IdPaciente   
    and EpisodioClinico = @EpisodioClinico  
    and IdEpisodioAtencion = @IdEpisodioAtencion  
    and UnidadReplicacion = @UnidadReplicacion  
  END  
  IF @ACCION ='LISTARTOP'  
  BEGIN  	
    Select TOP 1 * From   dbo.SS_HC_EnfermedadActual_FE   
	  inner join SS_HC_EpisodioAtencion epi on epi.IdPaciente=SS_HC_EnfermedadActual_FE.IdPaciente 
    Where SS_HC_EnfermedadActual_FE.IdPaciente = @IdPaciente 
	and epi.CodigoOA=  @Version
    and SS_HC_EnfermedadActual_FE.UnidadReplicacion = @UnidadReplicacion  
    ORDER BY SS_HC_EnfermedadActual_FE.EpisodioClinico DESC, SS_HC_EnfermedadActual_FE.IdEpisodioAtencion DESC
  END  


	IF @Accion ='UPDATE'  --Actualiza CABECERA
		BEGIN
				update  SS_HC_EnfermedadActual_FE
				Set  
					TipoAnamnesis=@TipoAnamnesis,
					TipoAnamnesisDescrip=@TipoAnamnesisDescrip,
					MotivoIngreso=@MotivoIngreso,
					FormaInicio=@FormaInicio,
					CursoEnfermedad=@CursoEnfermedad,
					TiempoEnfermedad=@TiempoEnfermedad,
					TiempoEnfermedadUnidad=@TiempoEnfermedadUnidad,
					RelatoCronologico=@RelatoCronologico,
					Apetito=@Apetito,
					Sed=@Sed,
					Sudor=@Sudor,
					Animo=@Animo,
					Orina=@Orina,
					Orina_Roja=@Orina_Roja,
					Orina_Espumosa=@Orina_Espumosa,
					Orina_Otros=@Orina_Otros,
					Deposiciones=@Deposiciones,
					Deposiciones_Moco=@Deposiciones_Moco,
					Deposiciones_Sangre=@Deposiciones_Sangre,
					Deposiciones_Otros=@Deposiciones_Otros,
					[Sueño]=@Sueño,
					PesoHabitual=@PesoHabitual,
					PesoHabitualSub=@PesoHabitualSub,
					FechaSolicitada=@FechaSolicitada,			 
					 Estado=@Estado,	 
					 UsuarioCreacion=@UsuarioCreacion,	
					 FechaCreacion= @FechaCreacion,
					 UsuarioModificacion=@UsuarioModificacion,	 
					 FechaModificacion=@FechaModificacion,	  	 
					 Accion = @Accion
				 Where  
					IdEpisodioAtencion = @IdEpisodioAtencion
					And	EpisodioClinico =@EpisodioClinico
					And	IdPaciente =@IdPaciente
					And	UnidadReplicacion =@UnidadReplicacion
				select @IdEpisodioAtencionId;
		END
				
	IF @Accion = 'NUEVO' -- Insertar Cabecera
		BEGIN
			Insert into dbo.SS_HC_EnfermedadActual_FE
				(UnidadReplicacion, IdEpisodioAtencion, IdPaciente,EpisodioClinico, 
				TipoAnamnesis,TipoAnamnesisDescrip,MotivoIngreso,
				FormaInicio,CursoEnfermedad,TiempoEnfermedad,TiempoEnfermedadUnidad,
				RelatoCronologico,Apetito,Sed,Sudor,Animo,Orina,Orina_Roja,Orina_Espumosa,
				Orina_Otros,Deposiciones,Deposiciones_Moco,Deposiciones_Sangre,Deposiciones_Otros,
				[Sueño],PesoHabitual,PesoHabitualSub,FechaSolicitada, Estado, 
				UsuarioCreacion, FechaCreacion,UsuarioModificacion, FechaModificacion, Accion, Version)
			values 
				(@UnidadReplicacion,	@IdEpisodioAtencion,	@IdPaciente,@EpisodioClinico,
				@TipoAnamnesis,@TipoAnamnesisDescrip,@MotivoIngreso,
				@FormaInicio,@CursoEnfermedad,@TiempoEnfermedad,@TiempoEnfermedadUnidad,
				@RelatoCronologico,@Apetito,@Sed,@Sudor,@Animo,@Orina,@Orina_Roja,@Orina_Espumosa,
				@Orina_Otros,@Deposiciones,@Deposiciones_Moco,@Deposiciones_Sangre,@Deposiciones_Otros,
				@Sueño,@PesoHabitual,@PesoHabitualSub,@FechaSolicitada,	2,
				@UsuarioCreacion,	GETDATE(),	@UsuarioModificacion, GETDATE(),@Accion,'CCEPF300' )
 			select @IdEpisodioAtencionId;
 			
		END

	IF @ACCION ='UPDATEDETALLE'  --Actualizar DETALLE
		BEGIN          

   			UPDATE SS_HC_EnfermedadActualDetalle_FE 
			SET 
				Sintomas=	@Sintomas,
				Accion = @Accion				
			Where	
					UnidadReplicacion = @UnidadReplicacion
			and		IdEpisodioAtencion = @IdEpisodioAtencion
			and		IdPaciente =@IdPaciente
			and		EpisodioClinico = @EpisodioClinico
			and		Secuencia = @Secuencia
				
			-- select @Secuencia;
			select @IdEpisodioAtencionId;

		END  
	
	IF @ACCION ='INSERTDETALLE'  --Insertar DETALLE
		BEGIN  
		   select @SecuenciaID = ISNULL(max(Secuencia),0) + 1   from SS_HC_EnfermedadActualDetalle_FE     
  
		   insert into SS_HC_EnfermedadActualDetalle_FE
		   ( UnidadReplicacion, IdEpisodioAtencion, IdPaciente,
			EpisodioClinico, Secuencia, Sintomas,Accion)
		   values 
		   (@UnidadReplicacion, @IdEpisodioAtencion, @IdPaciente,
			@EpisodioClinico, @SecuenciaID, @Sintomas,@Accion )
      
		   select @IdEpisodioAtencionId;
      
		END

	IF @ACCION ='DELETE'  --Borrar DETALLE
		BEGIN
    
			DELETE SS_HC_EnfermedadActualDetalle_FE
		    where
			   IdPaciente =@IdPaciente
			   AND  EpisodioClinico = @EpisodioClinico
			   AND  IdEpisodioAtencion=@IdEpisodioAtencion
			   AND UnidadReplicacion = @UnidadReplicacion
			   AND  Secuencia = @Secuencia
 
		   select @Secuencia;
		END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_EPISODIOATENCION_LISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_EPISODIOATENCION_LISTAR]
	@UnidadReplicacion char(4),
	@IdEpisodioAtencion int,
	@EpisodioAtencion int,
	@IdPaciente int,
	@TipoAtencion int,
	@MotivoConsulta varchar(20)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @IdEpisodioAtencionId as INTEGER, @ExisteCodigo as VARCHAR(10)
	 IF @MotivoConsulta ='LISTAEPISODIO'
		BEGIN
			SELECT     dbo.PERSONAMAST.Persona, dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.Nombres, 
                      dbo.PERSONAMAST.NombreCompleto, dbo.SS_HC_EpisodioClinico.UnidadReplicacion, dbo.SS_HC_EpisodioClinico.IdPaciente, 
                      dbo.SS_HC_EpisodioClinico.FechaCierre, dbo.SS_HC_EpisodioAtencion.EpisodioClinico AS Episodio_Atencion, 
                      dbo.SS_HC_EpisodioAtencion.FechaRegistro AS FechaReg_EpisoAtencon, dbo.SS_HC_EpisodioAtencion.FechaAtencion, dbo.SS_HC_EpisodioAtencion.TipoAtencion, 
                      dbo.SS_HC_EpisodioAtencion.IdOrdenAtencion, dbo.SS_HC_EpisodioAtencion.LineaOrdenAtencion, dbo.SS_HC_EpisodioAtencion.TipoOrdenAtencion, 
                      dbo.SS_HC_EpisodioAtencion.Estado AS Estado_EpisodioAten, dbo.SS_HC_EpisodioAtencion.UsuarioCreacion, dbo.SS_HC_EpisodioAtencion.FechaCreacion, 
                      dbo.SS_HC_EpisodioAtencion.UsuarioModificacion, dbo.SS_HC_EpisodioAtencion.FechaModificacion, dbo.SS_HC_Anamnesis_EA.MotivoConsulta, 
                      dbo.SS_HC_EpisodioAtencion.EpisodioAtencion, dbo.SS_HC_EpisodioClinico.FechaRegistro, dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion
			FROM         dbo.SS_HC_Anamnesis_EA INNER JOIN
                      dbo.SS_HC_EpisodioAtencion ON dbo.SS_HC_Anamnesis_EA.UnidadReplicacion = dbo.SS_HC_EpisodioAtencion.UnidadReplicacion AND 
                      dbo.SS_HC_Anamnesis_EA.IdEpisodioAtencion = dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion INNER JOIN
                      dbo.SS_HC_EpisodioClinico ON dbo.SS_HC_EpisodioAtencion.UnidadReplicacionEC = dbo.SS_HC_EpisodioClinico.UnidadReplicacion AND 
                      dbo.SS_HC_EpisodioAtencion.IdPaciente = dbo.SS_HC_EpisodioClinico.IdPaciente AND 
                      dbo.SS_HC_EpisodioAtencion.EpisodioClinico = dbo.SS_HC_EpisodioClinico.EpisodioClinico INNER JOIN
                      dbo.SS_GE_Paciente ON dbo.SS_HC_EpisodioClinico.IdPaciente = dbo.SS_GE_Paciente.IdPaciente INNER JOIN
                      dbo.SS_HC_PersonalSalud ON dbo.SS_HC_EpisodioAtencion.IdPersonalSalud = dbo.SS_HC_PersonalSalud.IdPersonalSalud INNER JOIN
                      dbo.PERSONAMAST ON dbo.SS_HC_PersonalSalud.IdPersonalSalud = dbo.PERSONAMAST.Persona
              union all
              SELECT     dbo.PERSONAMAST.Persona, dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.Nombres, 
                      dbo.PERSONAMAST.NombreCompleto, dbo.SS_HC_EpisodioClinico.UnidadReplicacion, dbo.SS_HC_EpisodioClinico.IdPaciente, 
                      dbo.SS_HC_EpisodioClinico.FechaCierre, dbo.SS_HC_EpisodioAtencion.EpisodioClinico AS Episodio_Atencion, 
                      dbo.SS_HC_EpisodioAtencion.FechaRegistro AS FechaReg_EpisoAtencon, dbo.SS_HC_EpisodioAtencion.FechaAtencion, dbo.SS_HC_EpisodioAtencion.TipoAtencion, 
                      dbo.SS_HC_EpisodioAtencion.IdOrdenAtencion, dbo.SS_HC_EpisodioAtencion.LineaOrdenAtencion, dbo.SS_HC_EpisodioAtencion.TipoOrdenAtencion, 
                      dbo.SS_HC_EpisodioAtencion.Estado AS Estado_EpisodioAten, dbo.SS_HC_EpisodioAtencion.UsuarioCreacion, dbo.SS_HC_EpisodioAtencion.FechaCreacion, 
                      dbo.SS_HC_EpisodioAtencion.UsuarioModificacion, dbo.SS_HC_EpisodioAtencion.FechaModificacion, 
                      dbo.SS_HC_Anamnesis_AP.PatologiaGestacion as MotivoConsulta,
                      dbo.SS_HC_EpisodioAtencion.EpisodioAtencion, 
                      dbo.SS_HC_EpisodioClinico.FechaRegistro, dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion
				FROM         dbo.SS_HC_EpisodioAtencion INNER JOIN
                      dbo.SS_HC_EpisodioClinico ON dbo.SS_HC_EpisodioAtencion.UnidadReplicacionEC = dbo.SS_HC_EpisodioClinico.UnidadReplicacion AND 
                      dbo.SS_HC_EpisodioAtencion.IdPaciente = dbo.SS_HC_EpisodioClinico.IdPaciente AND 
                      dbo.SS_HC_EpisodioAtencion.EpisodioClinico = dbo.SS_HC_EpisodioClinico.EpisodioClinico INNER JOIN
                      dbo.SS_GE_Paciente ON dbo.SS_HC_EpisodioClinico.IdPaciente = dbo.SS_GE_Paciente.IdPaciente INNER JOIN
                      dbo.SS_HC_PersonalSalud ON dbo.SS_HC_EpisodioAtencion.IdPersonalSalud = dbo.SS_HC_PersonalSalud.IdPersonalSalud INNER JOIN
                      dbo.PERSONAMAST ON dbo.SS_HC_PersonalSalud.IdPersonalSalud = dbo.PERSONAMAST.Persona INNER JOIN
                      dbo.SS_HC_Anamnesis_AP ON dbo.SS_HC_EpisodioAtencion.UnidadReplicacion = dbo.SS_HC_Anamnesis_AP.UnidadReplicacion AND 
                      dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion = dbo.SS_HC_Anamnesis_AP.IdEpisodioAtencion
   
		END

END
	
GO
/****** Object:  StoredProcedure [dbo].[SP_EvolucionMedica_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[SP_EvolucionMedica_FE] 
 @UnidadReplicacion char(4),  
 @IdEpisodioAtencion int ,  
 @IdPaciente int,  
 @EpisodioClinico int,  
 @CodigoSecuencia int,
 @IdOrdenAtencion int,
 @FechaIngreso datetime,
 @DictamenRiesgo varchar (500),
 @EvolucionObjetiva varchar (2000),
 @ObservacionesAdicionales varchar(500),
 @Medico varchar (80),
 @Especialidad varchar(80),
 @Estado int,
 @UsuarioCreacion varchar (25),
 @FechaCreacion datetime,
 @UsuarioModificacion varchar (25),
 @FechaModificacion datetime,
 @Accion varchar(25),
 @Version varchar(25)

AS  
BEGIN  				

	  IF @Accion ='EVOLUCION'  
	  BEGIN  
		Select EV.UnidadReplicacion,EV.IdEpisodioAtencion,
		EV.IdPaciente,EV.EpisodioClinico,EV.CodigoSecuencia,
		EV.IdOrdenAtencion,EV.FechaIngreso,EV.DictamenRiesgo ,
		EV.EvolucionObjetiva,EV.ObservacionesAdicionales,
		EV.Medico, SS_GE_Especialidad.Nombre Especialidad,
		EV.Estado, EV.UsuarioCreacion , EV.FechaCreacion,
	    convert(nvarchar(MAX), EV.FechaIngreso, 3)+' '+ FORMAT(EV.FechaIngreso,'hh:mm') UsuarioModificacion,EV.FechaModificacion,EV.Accion,EV.Version From   SS_HC_EvolucionMedica_FE EV
		 LEFT JOIN  SS_GE_Especialidad ON  SS_GE_Especialidad.IdEspecialidad = CONVERT(INT, EV.Especialidad)
		Where 
		EV.IdPaciente = @IdPaciente
		and EV.EpisodioClinico = @EpisodioClinico 
		and EV.UnidadReplicacion = @UnidadReplicacion  
	  END  
END


 
GO
/****** Object:  StoredProcedure [dbo].[SP_ExamenFisico_Triaje]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[SP_ExamenFisico_Triaje]
		@UnidadReplicacion  char(4),
		@IdEpisodioAtencion  bigint ,
		@IdPaciente  int ,
		@EpisodioClinico  int ,
		@PresionMinima int ,
		@PresionMaxima int ,
		@FrecuenciaRespiratoria decimal(20,6) ,
		@FrecuenciaCardiaca decimal(20,6) ,
		@Temperatura decimal(20,6) ,
		@Peso decimal(20,6) ,
		@Talla decimal(20,6) ,
		@IndiceMasaCorporal decimal(20,6) ,
		@IdEstadoGeneral  int ,
		@IdNutricion  int ,
		@IdHidratacion  int ,
		@IdColaboracion  int ,
		@ObservacionesAdicionales  varchar(250),
		@Estado  int ,
		@UsuarioCreacion  varchar(25),
		@FechaCreacion  datetime,
		@UsuarioModificacion  varchar(25),
		@FechaModificacion  datetime,
		@Accion  varchar(25),
		@Version  varchar(25)
	
AS
BEGIN
	SET NOCOUNT ON;
 	DECLARE @IdEpisodioAtencionId as INTEGER, @ExisteCodigo as VARCHAR(10), @IDSecuencia AS INT
 	set @IdEpisodioAtencionId = @IdEpisodioAtencion
	 IF @Accion = 'NUEVO'
		BEGIN 
 			Insert into SS_HC_ExamenFisico_Triaje(UnidadReplicacion, IdEpisodioAtencion, IdPaciente, EpisodioClinico, 
				PresionMinima, PresionMaxima, FrecuenciaRespiratoria, FrecuenciaCardiaca, Temperatura, Peso, Talla, 
				IndiceMasaCorporal, IdEstadoGeneral, IdNutricion, IdHidratacion, IdColaboracion, ObservacionesAdicionales, 
				Estado, UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion, Accion, Version)
			values (@UnidadReplicacion,	@IdEpisodioAtencionId,	@IdPaciente,	@EpisodioClinico,	
				@PresionMinima, @PresionMaxima,	@FrecuenciaRespiratoria,	@FrecuenciaCardiaca,	@Temperatura,	@Peso,	
				@Talla,	@IndiceMasaCorporal,	@IdEstadoGeneral,	@IdNutricion,	@IdHidratacion,	@IdColaboracion,	
				@ObservacionesAdicionales,	2,	@UsuarioCreacion,	GETDATE(),	@UsuarioModificacion,	
				GETDATE(),	@Version,	@Version) 
				
			select @IdEpisodioAtencionId;
			
		END
		IF @Accion ='UPDATE'
			BEGIN
			  set @IdEpisodioAtencionId = @IdEpisodioAtencion;
			update  SS_HC_ExamenFisico_Triaje set	 
				PresionMinima=@PresionMinima,	 
				PresionMaxima=@PresionMaxima,	 
				FrecuenciaRespiratoria=@FrecuenciaRespiratoria,	 FrecuenciaCardiaca=@FrecuenciaCardiaca,	 
				Temperatura=@Temperatura,	 Peso=@Peso,	 Talla=@Talla,	 IndiceMasaCorporal=@IndiceMasaCorporal,	 
				IdEstadoGeneral=@IdEstadoGeneral,	 IdNutricion=@IdNutricion,	 IdHidratacion=@IdHidratacion,	 
				IdColaboracion=@IdColaboracion,	 ObservacionesAdicionales=@ObservacionesAdicionales,		 
				UsuarioCreacion=@UsuarioCreacion,	  UsuarioModificacion=@UsuarioModificacion,	 
				FechaModificacion=getdate()
			 Where  IdEpisodioAtencion = @IdEpisodioAtencion
			 and	IdPaciente =@IdPaciente
			 and	EpisodioClinico =@EpisodioClinico
			select @IdEpisodioAtencionId;
			END
 
END
 
		 
GO
/****** Object:  StoredProcedure [dbo].[SP_ExamenFisicoRegional]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE OR ALTER PROCEDURE  [dbo].[SP_ExamenFisicoRegional]
		@UnidadReplicacion  char(4),
		@IdEpisodioAtencion  bigint ,
		@IdPaciente  int ,
		@EpisodioClinico  int ,
		@Secuencia  int ,
		@IdCuerpoHumano  int ,
		@Comentarios varchar(200),
		@Estado  int ,
		@UsuarioCreacion  varchar(25),
		@FechaCreacion  datetime,
		@UsuarioModificacion  varchar(25),
		@FechaModificacion  datetime,
		@Accion  varchar(25),
		@Version  varchar(25)
	
AS
BEGIN
	SET NOCOUNT ON;
 	DECLARE @IdEpisodioAtencionId as INTEGER, @ExisteCodigo as VARCHAR(10), @IDSecuencia AS INT
 	set @IdEpisodioAtencionId = @IdEpisodioAtencion
	 IF @Accion = 'NUEVO'
		BEGIN
			Select @IDSecuencia = ISNULL(max(Secuencia),0)+1  from SS_HC_ExamenFisico_Regional
			Insert into SS_HC_ExamenFisico_Regional(UnidadReplicacion, IdEpisodioAtencion, IdPaciente, EpisodioClinico, 
				Secuencia, IdCuerpoHumano, Comentarios,
				Estado, UsuarioCreacion, FechaCreacion, UsuarioModificacion, FechaModificacion, Accion, Version)
			values (@UnidadReplicacion,	@IdEpisodioAtencionId,	@IdPaciente,	@EpisodioClinico,	
					@IDSecuencia,@IdCuerpoHumano, @Comentarios,
					2,	@UsuarioCreacion,	GETDATE(),	@UsuarioModificacion,	
				GETDATE(),	@Version,	@Version) 
			select @IdEpisodioAtencionId;
			
		END
		IF @Accion ='UPDATE'
			BEGIN
				 UPDATE SS_HC_ExamenFisico_Regional
				 SET  IdCuerpoHumano= @IdCuerpoHumano, Comentarios = @Comentarios
				 Where  IdEpisodioAtencion = @IdEpisodioAtencion
				 and	IdPaciente =@IdPaciente
				 and	EpisodioClinico =@EpisodioClinico
				 and	Secuencia =@Secuencia
				 --and	IdCuerpoHumano =@IdCuerpoHumano
				select @IdEpisodioAtencionId;
			END
		IF @Accion ='DELETE'
			BEGIN
				 DELETE FROM SS_HC_ExamenFisico_Regional
				 Where  IdEpisodioAtencion = @IdEpisodioAtencion
				 and	IdPaciente =@IdPaciente
				 and	EpisodioClinico =@EpisodioClinico
				 and	Secuencia =@Secuencia
				 --and	IdCuerpoHumano =@IdCuerpoHumano
				select @IdEpisodioAtencionId;
			END
 
END
 
		 
GO
/****** Object:  StoredProcedure [dbo].[SP_ExamenFisicoTriajeListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[SP_ExamenFisicoTriajeListar]
		@UnidadReplicacion  char(4),
		@IdEpisodioAtencion  bigint ,
		@IdPaciente  int ,
		@EpisodioClinico  int ,
		@PresionMinima int ,
		@PresionMaxima int ,
		@FrecuenciaRespiratoria decimal(20,6) ,
		@FrecuenciaCardiaca decimal(20,6) ,
		@Temperatura decimal(20,6) ,
		@Peso decimal(20,6) ,
		@Talla decimal(20,6) ,
		@IndiceMasaCorporal decimal(20,6) ,
		@IdEstadoGeneral   int ,
		@IdNutricion   int ,
		@IdHidratacion   int ,
		@IdColaboracion   int ,
		@ObservacionesAdicionales  varchar(250),
		@Estado  int ,
		@UsuarioCreacion  varchar(25),
		@FechaCreacion  datetime,
		@UsuarioModificacion  varchar(25),
		@FechaModificacion  datetime,
		@Accion  varchar(25),
		@Version  varchar(25)
	
AS
BEGIN
	 SET NOCOUNT ON;

	DECLARE @IdEpisodioAtencionId as INTEGER, @ExisteCodigo as VARCHAR(10)
	 IF @Accion ='LISTAR'
		BEGIN
			Select * From   SS_HC_ExamenFisico_Triaje 
			Where IdPaciente = @IdPaciente 
			and EpisodioClinico = @EpisodioClinico
			and IdEpisodioAtencion = @IdEpisodioAtencion

		END
 
END
 
		 
GO
/****** Object:  StoredProcedure [dbo].[SP_ExamenSolicitado]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
CREATE OR ALTER PROCEDURE [SP_ExamenSolicitado]
	@UnidadReplicacion char(4),
	@IdEpisodioAtencion  bigint ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@Secuencia  int ,
	@IdProcedimiento  int ,
	@IdEspecialidad  int ,
	@IdTipoExamen int,
	@FechaSolitada datetime ,
	@Conceptos varchar(200) ,
	@CodigoComponente  varchar(25) ,
	@Observacion  varchar(200) ,
	@TipoOrdenAtencion  int ,
	@IndicadorEPS  int ,
	@UsuarioCreacion  varchar(25) ,
	@FechaCreacion  datetime ,
	@UsuarioModificacion  varchar(25) ,
	@FechaModificacion  datetime ,	
	@TipoCodigo	char(1) ,
	@CodigoSegus	varchar(25) ,
	@Version  varchar(25),
	@Cantidad  int,	
	@Accion  varchar(25) 
	
	
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @IdEpisodioAtencionId as INTEGER,	@SecuenciaID as integer,
	 @EpisodioClinicoID as INTEGER, @ExisteCodigo as VARCHAR(10)
	 set @IdEpisodioAtencionId = @IdEpisodioAtencion
	 IF @Accion = 'NUEVO'
		BEGIN
		 Select @SecuenciaID = ISNULL(max(Secuencia),0)+1  From SS_HC_ExamenSolicitado
				Where	
				UnidadReplicacion = @UnidadReplicacion
				and		IdEpisodioAtencion = @IdEpisodioAtencion
				and IdPaciente =@IdPaciente 
				and		EpisodioClinico = @EpisodioClinico
				
						 
		 INSERT INTO  SS_HC_ExamenSolicitado (UnidadReplicacion, IdEpisodioAtencion, IdPaciente, 
				 EpisodioClinico, Secuencia, IdProcedimiento, IdEspecialidad, CodigoComponente, Observacion, 
				 TipoOrdenAtencion, IndicadorEPS, UsuarioCreacion, FechaCreacion, UsuarioModificacion, 
				 FechaModificacion, Accion, Version ,FechaSolitada, Cantidad
				 ,TipoCodigo,CodigoSegus
				 )
		 VALUES(@UnidadReplicacion, @IdEpisodioAtencion, @IdPaciente, 
					@EpisodioClinico, @SecuenciaID, 
					@IdProcedimiento, @IdEspecialidad, @CodigoComponente, @Observacion, 
					@TipoOrdenAtencion, @IndicadorEPS, @UsuarioCreacion, getdate(), 
					@UsuarioModificacion, getdate(), 'CCEP0306', @Version, @FechaSolitada, @Cantidad
					,@TipoCodigo,@CodigoSegus
					)
					
 
			select @SecuenciaID;
		END
		IF @Accion ='UPDATE'
			BEGIN
				UPDATE SS_HC_ExamenSolicitado SET   
								IdProcedimiento= @IdProcedimiento, 
								Observacion=@Observacion,
								FechaSolitada = @FechaSolitada,
						 UsuarioModificacion = @UsuarioModificacion,
						 Cantidad = @Cantidad, 
						 FechaModificacion = getdate()
				Where	
				UnidadReplicacion = @UnidadReplicacion
				and		IdEpisodioAtencion = @IdEpisodioAtencion
				and IdPaciente =@IdPaciente 
				and		EpisodioClinico = @EpisodioClinico
				and Secuencia = @Secuencia				
				
			 select @Secuencia;

			END
		else
		IF @Accion ='DELETE'
			BEGIN
				delete SS_HC_ExamenSolicitado
				Where	
				UnidadReplicacion = @UnidadReplicacion
				and		IdEpisodioAtencion = @IdEpisodioAtencion
				and IdPaciente =@IdPaciente 
				and		EpisodioClinico = @EpisodioClinico
				and Secuencia = @Secuencia				
				
			 select @Secuencia;
			END	 
END
	 
GO
/****** Object:  StoredProcedure [dbo].[SP_ExamenSolicitadoFE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_ExamenSolicitadoFE]
	@UnidadReplicacion varchar(4),
	@IdEpisodioAtencion  bigint ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@Secuencia  int ,
	@IdProcedimiento  int ,
	@IdEspecialidad  int ,
	@IdTipoExamen int,
	@FechaSolitada datetime ,
	@Conceptos varchar(200) ,
	@CodigoComponente  varchar(25) ,
	@Observacion  varchar(200) ,
	@TipoOrdenAtencion  int ,
	@IndicadorEPS  int ,
	@UsuarioCreacion  varchar(25) ,
	@FechaCreacion  datetime ,
	@UsuarioModificacion  varchar(25) ,
	@FechaModificacion  datetime ,	
	@TipoCodigo	varchar(1) ,
	@CodigoSegus	varchar(25) ,
	@Version  varchar(25),
	@Cantidad  int,
	@Resumen	varchar(500),
	@Motivo	varchar(250),
	@TipoExamen	varchar(10),	
	@Accion  varchar(25) ,
    @IdDiagnostico int
	
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @IdEpisodioAtencionId as INTEGER,	@SecuenciaID as integer,
	 @EpisodioClinicoID as INTEGER, @ExisteCodigo as VARCHAR(10)
	 set @IdEpisodioAtencionId = @IdEpisodioAtencion

 IF @ACCION ='NUEVO'  -- NUEVO CABECERA
	  BEGIN  
	  	  
		  SELECT @SecuenciaID =COUNT(*) FROM SS_HC_ExamenSolicitadoFE WHERE  UnidadReplicacion=@UnidadReplicacion AND  IdEpisodioAtencion=@IdEpisodioAtencion
		  AND IdPaciente=@IdPaciente AND  EpisodioClinico=@EpisodioClinico

		  IF @SecuenciaID=0
			BEGIN
			INSERT INTO  SS_HC_ExamenSolicitadoFE 
				  (UnidadReplicacion, IdEpisodioAtencion, IdPaciente, EpisodioClinico,
					  Resumen,Motivo,TipoExamen,  UsuarioCreacion, FechaCreacion, 
					  UsuarioModificacion, 	 FechaModificacion, Accion, Version,Estado
					 )
			VALUES(@UnidadReplicacion, @IdEpisodioAtencion, @IdPaciente, @EpisodioClinico,
					 @Resumen, @Motivo, @TipoExamen, @UsuarioCreacion, getdate(), 
					 @UsuarioModificacion, getdate(), 'NUEVO', 'CCEPF150',2
				  )	
			END
	   select @IdEpisodioAtencionId; 
	    
	  END   

 IF @ACCION ='UPDATE'  -- Actualiza CABECERA
	  BEGIN  
	   update SS_HC_ExamenSolicitadoFE set   

	   	Resumen = @Resumen,
		Motivo	=@Motivo,
		TipoExamen=@TipoExamen,
		Accion='UPDATE',
		 UsuarioModificacion=@UsuarioModificacion,   
		 FechaModificacion=@FechaModificacion
	   where
	   UnidadReplicacion = @UnidadReplicacion   
	   and IdEpisodioAtencion=@IdEpisodioAtencion  
	   and  EpisodioClinico =@EpisodioClinico    
	   and  IdPaciente =@IdPaciente         
	   select @IdEpisodioAtencionId;  
	  END   

IF @Accion = 'DETALLE'  -- Insertar DETALLE
	BEGIN

	SELECT @SecuenciaID = ISNULL(max(Secuencia),0)+1  From SS_HC_ExamenSolicitadoDet_FE
			Where	
			UnidadReplicacion = @UnidadReplicacion
			and		IdEpisodioAtencion = @IdEpisodioAtencion
			and IdPaciente =@IdPaciente 
			and		EpisodioClinico = @EpisodioClinico
  	DECLARE @var varchar(15)

	EXEC SP_SS_HC_Correlativo '00000000','CEG' ,'HC',@NroPeticion=@var output

	INSERT INTO  SS_HC_ExamenSolicitadoDet_FE (UnidadReplicacion, IdEpisodioAtencion, IdPaciente, 
				EpisodioClinico, Secuencia, IdProcedimiento, IdEspecialidad, CodigoComponente, Observacion, 
				TipoOrdenAtencion, IndicadorEPS, UsuarioCreacion, FechaCreacion, UsuarioModificacion, 
				FechaModificacion, Accion, Version ,FechaSolicitada, Cantidad
				,TipoCodigo,CodigoSegus, Especificaciones,secuencialHCE
				)
	VALUES(@UnidadReplicacion, @IdEpisodioAtencion, @IdPaciente, 
				@EpisodioClinico, @SecuenciaID, @IdProcedimiento, @IdEspecialidad, @CodigoComponente, @Observacion, 
				@TipoOrdenAtencion, @IndicadorEPS, @UsuarioCreacion, getdate(), 
				@UsuarioModificacion, getdate(), 'NUEVO', 'CCEPF150', @FechaSolitada, @Cantidad
				,@TipoCodigo,@CodigoSegus, @Conceptos,@var
				)					
 
		select @IdEpisodioAtencionId;  

	END

IF @Accion ='UPDATEDETALLE'  -- Actualizar Detalle
	BEGIN
		UPDATE SS_HC_ExamenSolicitadoDet_FE SET   
					IdProcedimiento= @IdProcedimiento, 
					Observacion=@Observacion,
					FechaSolicitada = @FechaSolitada,
					UsuarioModificacion = @UsuarioModificacion,
					Cantidad = @Cantidad, 
					Accion='UPDATE',
					FechaModificacion = getdate(),
					Especificaciones= @Conceptos
		Where	
		UnidadReplicacion = SubString(@UnidadReplicacion,1,3)
		and		IdEpisodioAtencion = @IdEpisodioAtencion
		and		IdPaciente =@IdPaciente 
		and		EpisodioClinico = @EpisodioClinico
		and		Secuencia = @Secuencia				

		select @IdEpisodioAtencionId;
				
	END

IF @Accion ='DELETE' --Borrar DETALLE
	BEGIN
		delete SS_HC_ExamenSolicitadoDet_FE
		Where	
		UnidadReplicacion = @UnidadReplicacion
		and		IdEpisodioAtencion = @IdEpisodioAtencion
		and IdPaciente =@IdPaciente 
		and		EpisodioClinico = @EpisodioClinico
		and Secuencia = @Secuencia				
				
		select @Secuencia;
	END	 

IF @ACCION ='UPDATEDETALLEDIAG'  --Actualizar DETALLE
BEGIN          

   	UPDATE SS_HC_ExamenSolicitado_Diagnostico_FE 
	SET 
		IdDiagnostico=	@IdDiagnostico,
		Accion = @Accion
				
	Where	
	UnidadReplicacion = @UnidadReplicacion
	and		IdEpisodioAtencion = @IdEpisodioAtencion
	and IdPaciente =@IdPaciente 
	and		EpisodioClinico = @EpisodioClinico
	and Secuencia = @Secuencia				
				
	select @IdEpisodioAtencionId;

END  
	
IF @ACCION ='INSERTDETALLEDIAG'  --Insertar DETALLE
	BEGIN  
		select @SecuenciaID = ISNULL(max(Secuencia),0) + 1   from SS_HC_ExamenSolicitado_Diagnostico_FE             
  
		insert into SS_HC_ExamenSolicitado_Diagnostico_FE
		( UnidadReplicacion, IdEpisodioAtencion, IdPaciente,   
		EpisodioClinico, Secuencia, IdDiagnostico,Accion)  
		values 
		(@UnidadReplicacion, @IdEpisodioAtencion, @IdPaciente,   
		@EpisodioClinico, @SecuenciaID, @IdDiagnostico,@Accion )  
      
		select @IdEpisodioAtencionId;  
      
	END 	

IF @ACCION ='DELETEDETADIAG'  --Borrar DETALLE
	BEGIN  
    
		DELETE SS_HC_ExamenSolicitado_Diagnostico_FE   
		where 
			IdPaciente =@IdPaciente  
			AND  EpisodioClinico = @EpisodioClinico  
			AND  IdEpisodioAtencion=@IdEpisodioAtencion  
			AND UnidadReplicacion = @UnidadReplicacion
			AND  Secuencia = @Secuencia 
 
		select @Secuencia;     
	END  			

END
	 
GO
/****** Object:  StoredProcedure [dbo].[SP_ExamenSolicitadoFE_BCK2022116]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_ExamenSolicitadoFE_BCK2022116]
	@UnidadReplicacion varchar(4),
	@IdEpisodioAtencion  bigint ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@Secuencia  int ,
	@IdProcedimiento  int ,
	@IdEspecialidad  int ,
	@IdTipoExamen int,
	@FechaSolitada datetime ,
	@Conceptos varchar(200) ,
	@CodigoComponente  varchar(25) ,
	@Observacion  varchar(200) ,
	@TipoOrdenAtencion  int ,
	@IndicadorEPS  int ,
	@UsuarioCreacion  varchar(25) ,
	@FechaCreacion  datetime ,
	@UsuarioModificacion  varchar(25) ,
	@FechaModificacion  datetime ,	
	@TipoCodigo	varchar(1) ,
	@CodigoSegus	varchar(25) ,
	@Version  varchar(25),
	@Cantidad  int,
	@Resumen	varchar(500),
	@Motivo	varchar(250),
	@TipoExamen	varchar(10),	
	@Accion  varchar(25) ,
    @IdDiagnostico int
	--@IdFormaInicio int --SECUENCIA
	
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @IdEpisodioAtencionId as INTEGER,	@SecuenciaID as integer,
	 @EpisodioClinicoID as INTEGER, @ExisteCodigo as VARCHAR(10)
	 set @IdEpisodioAtencionId = @IdEpisodioAtencion

 IF @ACCION ='NUEVO'  -- NUEVO CABECERA
	  BEGIN  
	  	  
		INSERT INTO  SS_HC_ExamenSolicitadoFE 
			  (UnidadReplicacion, IdEpisodioAtencion, IdPaciente, EpisodioClinico,
				  Resumen,Motivo,TipoExamen,  UsuarioCreacion, FechaCreacion, 
				  UsuarioModificacion, 	 FechaModificacion, Accion, Version,Estado
				 )
		VALUES(@UnidadReplicacion, @IdEpisodioAtencion, @IdPaciente, @EpisodioClinico,
				 @Resumen, @Motivo, @TipoExamen, @UsuarioCreacion, getdate(), 
				 @UsuarioModificacion, getdate(), 'NUEVO', 'CCEPF150',2
			  )	

	   select @IdEpisodioAtencionId; 
	    
	  END   

 IF @ACCION ='UPDATE'  -- Actualiza CABECERA
	  BEGIN  
	   update SS_HC_ExamenSolicitadoFE set   

	   	Resumen = @Resumen,
		Motivo	=@Motivo,
		TipoExamen=@TipoExamen,
		Accion='UPDATE',
		 UsuarioModificacion=@UsuarioModificacion,   
		 FechaModificacion=@FechaModificacion
	   where
	   UnidadReplicacion = @UnidadReplicacion   
	   and IdEpisodioAtencion=@IdEpisodioAtencion  
	   and  EpisodioClinico =@EpisodioClinico    
	   and  IdPaciente =@IdPaciente  
       
	   select @IdEpisodioAtencionId;  
	  END   

IF @Accion = 'DETALLE'  -- Insertar DETALLE
	BEGIN

	SELECT @SecuenciaID = ISNULL(max(Secuencia),0)+1  From SS_HC_ExamenSolicitadoDet_FE
			Where	
			UnidadReplicacion = @UnidadReplicacion
			and		IdEpisodioAtencion = @IdEpisodioAtencion
			and IdPaciente =@IdPaciente 
			and		EpisodioClinico = @EpisodioClinico

  	DECLARE @var varchar(15)
	EXEC SP_SS_HC_Correlativo '00000000','CEG' ,'HC',@NroPeticion=@var output
	   
	INSERT INTO  SS_HC_ExamenSolicitadoDet_FE (UnidadReplicacion, IdEpisodioAtencion, IdPaciente, 
				EpisodioClinico, Secuencia, IdProcedimiento, IdEspecialidad, CodigoComponente, Observacion, 
				TipoOrdenAtencion, IndicadorEPS, UsuarioCreacion, FechaCreacion, UsuarioModificacion, 
				FechaModificacion, Accion, Version ,FechaSolicitada, Cantidad
				,TipoCodigo,CodigoSegus, Especificaciones,secuencialHCE
				)
	VALUES(@UnidadReplicacion, @IdEpisodioAtencion, @IdPaciente, 
				@EpisodioClinico, @SecuenciaID, @IdProcedimiento, @IdEspecialidad, @CodigoComponente, @Observacion, 
				@TipoOrdenAtencion, @IndicadorEPS, @UsuarioCreacion, getdate(), 
				@UsuarioModificacion, getdate(), 'NUEVO', 'CCEPF150', @FechaSolitada, @Cantidad
				,@TipoCodigo,@CodigoSegus, @Conceptos,@var
				)					

		select @IdEpisodioAtencionId;  

	END

IF @Accion ='UPDATEDETALLE'  -- Actualizar Detalle
	BEGIN
		UPDATE SS_HC_ExamenSolicitadoDet_FE SET   
					IdProcedimiento= @IdProcedimiento, 
					Observacion=@Observacion,
					FechaSolicitada = @FechaSolitada,
					UsuarioModificacion = @UsuarioModificacion,
					Cantidad = @Cantidad, 
					Accion='UPDATE',
					FechaModificacion = getdate(),
					Especificaciones= @Conceptos
		Where	
		UnidadReplicacion = SubString(@UnidadReplicacion,1,3)
		and		IdEpisodioAtencion = @IdEpisodioAtencion
		and		IdPaciente =@IdPaciente 
		and		EpisodioClinico = @EpisodioClinico
		and		Secuencia = @Secuencia

		select @IdEpisodioAtencionId;
				
	END

IF @Accion ='DELETE' --Borrar DETALLE
	BEGIN
		delete SS_HC_ExamenSolicitadoDet_FE
		Where	
		UnidadReplicacion = @UnidadReplicacion
		and		IdEpisodioAtencion = @IdEpisodioAtencion
		and IdPaciente =@IdPaciente 
		and		EpisodioClinico = @EpisodioClinico
		and Secuencia = @Secuencia				
				
		select @Secuencia;
	END	 

IF @ACCION ='UPDATEDETALLEDIAG'  --Actualizar DETALLE
BEGIN          

   	UPDATE SS_HC_ExamenSolicitado_Diagnostico_FE 
	SET 
		IdDiagnostico=	@IdDiagnostico,
		Accion = @Accion				
	Where	
	UnidadReplicacion = @UnidadReplicacion
	and		IdEpisodioAtencion = @IdEpisodioAtencion
	and IdPaciente =@IdPaciente 
	and		EpisodioClinico = @EpisodioClinico
	and Secuencia = @Secuencia

	select @IdEpisodioAtencionId;

END  
	
IF @ACCION ='INSERTDETALLEDIAG'  --Insertar DETALLE
	BEGIN  
		select @SecuenciaID = ISNULL(max(Secuencia),0) + 1   from SS_HC_ExamenSolicitado_Diagnostico_FE             
  
		insert into SS_HC_ExamenSolicitado_Diagnostico_FE
		( UnidadReplicacion, IdEpisodioAtencion, IdPaciente,   
		EpisodioClinico, Secuencia, IdDiagnostico,Accion)  
		values 
		(@UnidadReplicacion, @IdEpisodioAtencion, @IdPaciente,   
		@EpisodioClinico, @SecuenciaID, @IdDiagnostico,@Accion )  
      
		select @IdEpisodioAtencionId;  
      
	END 	

IF @ACCION ='DELETEDETADIAG'  --Borrar DETALLE
	BEGIN  
    
		DELETE SS_HC_ExamenSolicitado_Diagnostico_FE   
		where 
			IdPaciente =@IdPaciente  
			AND  EpisodioClinico = @EpisodioClinico  
			AND  IdEpisodioAtencion=@IdEpisodioAtencion  
			AND UnidadReplicacion = @UnidadReplicacion
			AND  Secuencia = @Secuencia 
 
		select @Secuencia;     
	END  			

END
	 
GO
/****** Object:  StoredProcedure [dbo].[SP_ExamenSolicitadoListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE OR ALTER PROCEDURE  [dbo].[SP_ExamenSolicitadoListar]
	@UnidadReplicacion char(4),
	@IdEpisodioAtencion  bigint ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@Secuencia  int ,
	@IdProcedimiento  int ,
	@IdEspecialidad  int ,
	@IdTipoExamen int,
	@FechaSolitada datetime ,
	@Conceptos varchar(200) ,
	@CodigoComponente  varchar(25) ,
	@Observacion  varchar(200) ,
	@TipoOrdenAtencion  int ,
	@IndicadorEPS  int ,
	@UsuarioCreacion  varchar(25) ,
	@FechaCreacion  datetime ,
	@UsuarioModificacion  varchar(25) ,
	@FechaModificacion  datetime ,
	@TipoCodigo	char(1) ,
	@CodigoSegus	varchar(25) ,
	@Version  varchar(25),
	@Cantidad  int,	
	@Accion  varchar(25) ,
	@inicio  int,
	@numerofilas  int
	
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @IdEpisodioAtencionId as INTEGER,
	 @EpisodioClinicoID as INTEGER, @ExisteCodigo as VARCHAR(10)
	 IF @Accion ='LISTAR'
			BEGIN
				SELECT * FROM  SS_HC_ExamenSolicitado  
				Where	IdPaciente =@IdPaciente 
				and		EpisodioClinico = @EpisodioClinico
				and		IdEpisodioAtencion = @IdEpisodioAtencion
 
			END
	 
END
	 
GO
/****** Object:  StoredProcedure [dbo].[SP_ExamenSolicitadoListarFE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE  [dbo].[SP_ExamenSolicitadoListarFE]
	@UnidadReplicacion char(4),
	@IdEpisodioAtencion  bigint ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@Secuencia  int ,
	@IdProcedimiento  int ,
	@IdEspecialidad  int ,
	@FechaSolitada datetime ,	
	@CodigoComponente  varchar(25) ,
	@Observacion  varchar(200) ,	
	@IndicadorEPS  int ,
	@UsuarioCreacion  varchar(25) ,
	@FechaCreacion  datetime ,
	@UsuarioModificacion  varchar(25) ,
	@FechaModificacion  datetime ,
	@TipoCodigo	char(1) ,
	@CodigoSegus	varchar(25) ,
	@Version  varchar(25),
	@Cantidad  int,	
	@Accion  varchar(25) ,
	@inicio  int,
	@numerofilas  int
	
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @IdEpisodioAtencionId as INTEGER,
	 @EpisodioClinicoID as INTEGER, @ExisteCodigo as VARCHAR(10)
	 IF @Accion ='LISTAR'
			BEGIN
				SELECT * FROM  SS_HC_ExamenSolicitadoFE  
				Where	IdPaciente =@IdPaciente 
				and		EpisodioClinico = @EpisodioClinico
				and		IdEpisodioAtencion = @IdEpisodioAtencion
				and		UnidadReplicacion = @UnidadReplicacion 
 
			END
	 
END
	 
GO
/****** Object:  StoredProcedure [dbo].[SP_FormCSB_MigrarDatosHC]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_FormCSB_MigrarDatosHC]
@CodAnulado VARCHAR(20),
@CodNuevo VARCHAR(20),
@IdOrdenAtencionAnulada VARCHAR(20),
@IdOrdenAtencionNueva VARCHAR(20),
@IdPaciente VARCHAR(20)
AS
BEGIN
SET NOCOUNT ON
		declare @count1 varchar(3)
		declare @count2 varchar(3)
		declare @count3 varchar(3)
		declare @count4 varchar(3)
		declare @count5 varchar(3)
		declare @count6 varchar(3)
		declare @count7 varchar(3)
		declare @count8 varchar(3)
		declare @count9 varchar(3)
		declare @count10 varchar(3)

		----------------------------- SS_HC_EpisodioClinico ------------------------------
		select @count3 = count(*) from SS_HC_EpisodioClinico where IdOrdenAtencion =  @IdOrdenAtencionAnulada
		IF @count3 > 0 
			BEGIN
				update SS_HC_EpisodioClinico 
				set SS_HC_EpisodioClinico.idordenatencion = @IdOrdenAtencionNueva
				where IdOrdenAtencion =  @IdOrdenAtencionAnulada 
			END
		------------------------- SS_HC_EpisodioAtencionMaster ---------------------------
		select @count2 = count(*) from SS_HC_EpisodioAtencionMaster where IdOrdenAtencion = @IdOrdenAtencionAnulada
		IF @count2 > 0 
			BEGIN
				update SS_HC_EpisodioAtencionMaster 
				set SS_HC_EpisodioAtencionMaster.codigooa = @CodNuevo, SS_HC_EpisodioAtencionMaster.idordenatencion = @IdOrdenAtencionNueva
				where IdOrdenAtencion =  @IdOrdenAtencionAnulada 
			END
		------------------------------ SS_HC_EpisodioAtencion ------------------------------
		select @count1 = count(*) from SS_HC_EpisodioAtencion where codigooa = @CodAnulado and idordenatencion = @IdOrdenAtencionAnulada
		IF @count1 > 0 
			BEGIN
				update SS_HC_EpisodioAtencion 
				set SS_HC_EpisodioAtencion.codigooa = @CodNuevo, SS_HC_EpisodioAtencion.idordenatencion = @IdOrdenAtencionNueva
				where codigooa = @CodAnulado and idordenatencion = @IdOrdenAtencionAnulada
			END
		------------------------- SS_HC_AgrupadorAtencionVigente -------------------------
		select @count4 = count(*) from SS_HC_AgrupadorAtencionVigente where IdOrdenAtencion =  @IdOrdenAtencionAnulada
		IF @count4 > 0 
			BEGIN
				update SS_HC_AgrupadorAtencionVigente 
				set SS_HC_AgrupadorAtencionVigente.idordenatencion = @IdOrdenAtencionNueva
				where idordenatencion = @IdOrdenAtencionAnulada
			END
		---------------------------- SS_HC_EvolucionMedica_FE ----------------------------
		select @count5 = count(*) from SS_HC_EvolucionMedica_FE where IdOrdenAtencion =  @IdOrdenAtencionAnulada
		IF @count5 > 0 
			BEGIN
				update SS_HC_EvolucionMedica_FE
				set SS_HC_EvolucionMedica_FE.idordenatencion = @IdOrdenAtencionNueva
				where idordenatencion = @IdOrdenAtencionAnulada
			END
		---------------------------- SS_HC_EvolucionObjetiva -----------------------------
		select @count6 = count(*) from SS_HC_EvolucionObjetiva where IdOrdenAtencion =  @IdOrdenAtencionAnulada
		IF @count6 > 0 
			BEGIN
				update SS_HC_EvolucionObjetiva 
				set SS_HC_EvolucionObjetiva.idordenatencion = @IdOrdenAtencionNueva
				where idordenatencion = @IdOrdenAtencionAnulada
			END
		----------------------------- SS_HC_KardexEnfermeria -----------------------------
		select @count7 = count(*) from SS_HC_KardexEnfermeria where IdOrdenAtencion =  @IdOrdenAtencionAnulada
		IF @count7 > 0 
			BEGIN
				update SS_HC_KardexEnfermeria set 
				SS_HC_KardexEnfermeria.idordenatencion = @IdOrdenAtencionNueva
				where idordenatencion = @IdOrdenAtencionAnulada
			END
		-------------------------- SS_HC_KardexEnfermeriaDetalle -------------------------
		select @count8 = count(*) from SS_HC_KardexEnfermeriaDetalle where IdOrdenAtencion =  @IdOrdenAtencionAnulada
		IF @count8 > 0 
			BEGIN
				update SS_HC_KardexEnfermeriaDetalle 
				set SS_HC_KardexEnfermeriaDetalle.idordenatencion = @IdOrdenAtencionNueva
				where idordenatencion = @IdOrdenAtencionAnulada
			END
		------------------------------ SS_HC_PAE_Diagnostico -----------------------------
		select @count9 = count(*) from SS_HC_PAE_Diagnostico where IdOrdenAtencion =  @IdOrdenAtencionAnulada
		IF @count9 > 0 
			BEGIN
				update SS_HC_PAE_Diagnostico 
				set SS_HC_PAE_Diagnostico.idordenatencion = @IdOrdenAtencionNueva
				where idordenatencion = @IdOrdenAtencionAnulada
			END
		--------------------------- SS_HC_PAE_FactorRelacionado --------------------------
		select @count10 = count(*) from SS_HC_PAE_FactorRelacionado where IdOrdenAtencion =  @IdOrdenAtencionAnulada
		IF @count10 > 0 
			BEGIN
				update SS_HC_PAE_FactorRelacionado 
				set SS_HC_PAE_FactorRelacionado.idordenatencion = @IdOrdenAtencionNueva
				where idordenatencion = @IdOrdenAtencionAnulada
			END

			SELECT @IdPaciente
		RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GE_Diagnostico]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_GE_Diagnostico]   
		@IdDiagnostico int,
		@CodigoDiagnostico varchar(15),
		@CodigoPadre varchar(15),
		@Nombre varchar(350),
		@Descripcion varchar(350),
		@Estado int,
		@UsuarioCreacion varchar(25),
		@FechaCreacion datetime,
		@UsuarioModificacion varchar(25),
		@FechaModificacion datetime,
		@IdDiagnosticoPadre int,
		@Orden int,
		@CadenaRecursividad varchar(150),
		@Nivel int,
		@DiagnosticoSiteds varchar(15),
		@IndicadorPermitido int,
		@tipoFolder int,
		@NombreTabla varchar(15),
		@Accion varchar(25),
		@Version varchar(25)
AS  
BEGIN   
SET NOCOUNT ON;  
BEGIN  TRANSACTION  
  
 DECLARE @CONTADOR INT  
 IF(@Accion = 'INSERT')  
 BEGIN   
 		select @CONTADOR= isnull(MAX(IdDiagnostico),0)+1 from SS_GE_Diagnostico 
		
		set @IdDiagnostico= @CONTADOR
		
  INSERT INTO SS_GE_Diagnostico  
  (  
	IdDiagnostico,
	CodigoDiagnostico,
	CodigoPadre,
	Nombre,
	Descripcion,
	Estado,
	UsuarioCreacion,
	FechaCreacion,
	UsuarioModificacion,
	FechaModificacion,
	IdDiagnosticoPadre,
	Orden,
	CadenaRecursividad,
	Nivel,
	DiagnosticoSiteds,
	IndicadorPermitido,
	tipoFolder,
	NombreTabla,
	Accion,
	Version
  )  
    VALUES  
  (   
	@IdDiagnostico,
	@CodigoDiagnostico,
	@CodigoPadre,
	@Nombre,
	@Descripcion,
	@Estado,
	@UsuarioCreacion,
	GETDATE(),
	@UsuarioModificacion,
	GETDATE(),
	@IdDiagnosticoPadre,
	@Orden,
	@CadenaRecursividad,
	@Nivel,
	@DiagnosticoSiteds,
	@IndicadorPermitido,
	@tipoFolder,
	@NombreTabla,
	@Accion,
	@Version
  )  
  
 SELECT 1		 
 END   
 ELSE  
 IF(@Accion = 'UPDATE')  
 BEGIN  
 UPDATE SS_GE_Diagnostico  
  SET      
	IdDiagnosticoPadre = @IdDiagnosticoPadre,
    CodigoDiagnostico=@CodigoDiagnostico,
    Nombre=@Nombre,
    Descripcion=@Descripcion,  
    Estado=@Estado,
    --UsuarioModificacion=@UsuarioModificacion,
    FechaModificacion=GETDATE(),  
    IdDiagnostico=@IdDiagnostico,
    Orden=@Orden,
    CadenaRecursividad=@CadenaRecursividad,
    Nivel=@Nivel,
    DiagnosticoSiteds=@DiagnosticoSiteds,  
    IndicadorPermitido=@IndicadorPermitido,
    tipoFolder=@tipoFolder,
    NombreTabla=@NombreTabla
		WHERE 
		(IdDiagnostico = @IdDiagnostico)  
   		select 1
 end   
 else  
 if(@Accion = 'DELETE')  
 begin  
  delete SS_GE_Diagnostico  
		WHERE 
		(IdDiagnostico = @IdDiagnostico)
   		select 1
end
		if(@Accion = 'CONTARLISTAPAG')
	begin		
		
		SET @CONTADOR=(SELECT COUNT(IdDiagnostico) FROM SS_GE_Diagnostico
	 				 
     WHERE   
       (@IdDiagnostico is null OR (IdDiagnostico = @IdDiagnostico) or @IdDiagnostico =0)  
     and (@IdDiagnosticoPadre is null OR IdDiagnosticoPadre = @IdDiagnosticoPadre)       
     and (@Nombre is null  OR @Nombre =''  OR  upper(Nombre) like '%'+upper(@Nombre)+'%')       
     and (@Estado is null OR Estado = @Estado)        
     and (@CodigoDiagnostico is null  OR @CodigoDiagnostico =''  OR  upper(CodigoDiagnostico) like '%'+upper(@CodigoDiagnostico)+'%')  
   )
					
		select @CONTADOR
	end
commit	 
END  
GO
/****** Object:  StoredProcedure [dbo].[SP_GE_DiagnosticoListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
      
CREATE OR ALTER PROCEDURE  [dbo].[SP_GE_DiagnosticoListar]       
@IdDiagnostico int,      
@CodigoDiagnostico varchar(15),      
@CodigoPadre varchar(15),      
@Nombre varchar(350),      
--@Descripcion varchar(350),      
@Estado int,      
@UsuarioCreacion varchar(25),      
@FechaCreacion datetime,      
@UsuarioModificacion varchar(25),      
@FechaModificacion datetime,      
@IdDiagnosticoPadre int,      
@Orden int,      
@CadenaRecursividad varchar(150),      
@Nivel int,      
@DiagnosticoSiteds varchar(15),      
@IndicadorPermitido int,      
@tipoFolder int,      
@NombreTabla varchar(15),      
@Accion  varchar(25),      
@Version varchar(25),   
@INICIO   int= null,    
@NUMEROFILAS int = null       
AS      
BEGIN      
if(@ACCION = 'LISTARPAG')  
 begin  
   DECLARE @CONTADOR INT  
   
  SET @CONTADOR=(SELECT COUNT(IdDiagnostico) FROM SS_GE_Diagnostico  
      
     WHERE   
       (@IdDiagnostico is null OR (IdDiagnostico = @IdDiagnostico) or @IdDiagnostico =0)  
     and (@IdDiagnosticoPadre is null OR IdDiagnosticoPadre = @IdDiagnosticoPadre)       
     and (@Nombre is null  OR @Nombre =''  OR  upper(Nombre) like '%'+upper(@Nombre)+'%')       
     and (@Estado is null OR Estado = @Estado)        
     and (@CodigoDiagnostico is null  OR @CodigoDiagnostico =''  OR  upper(CodigoDiagnostico) like '%'+upper(@CodigoDiagnostico)+'%')  
   
     )  
  SELECT  
    IdDiagnostico,  
    CodigoDiagnostico,  
    CodigoPadre,  
    Nombre,  
    Descripcion,  
    Estado,  
    UsuarioCreacion,  
    FechaCreacion,  
    UsuarioModificacion,  
    FechaModificacion,  
    IdDiagnosticoPadre,  
    Orden,  
    CadenaRecursividad,  
    Nivel,  
    DiagnosticoSiteds,  
    IndicadorPermitido,  
    tipoFolder,  
    NombreTabla,  
    Accion,  
    Version  
  FROM (    
   SELECT  
    IdDiagnostico,  
    CodigoDiagnostico,  
    CodigoPadre,  
    Nombre,  
    Descripcion,  
    Estado,  
    UsuarioCreacion,  
    FechaCreacion,  
    UsuarioModificacion,  
    FechaModificacion,  
    IdDiagnosticoPadre,  
    Orden,  
    CadenaRecursividad,  
    Nivel,  
    DiagnosticoSiteds,  
    IndicadorPermitido,  
    tipoFolder,  
    NombreTabla,  
    Accion,  
    Version  
     ,@CONTADOR AS Contador  
     ,ROW_NUMBER() OVER (ORDER BY IdDiagnostico ASC ) AS RowNumber      
     FROM SS_GE_Diagnostico   
     WHERE   
       (@IdDiagnostico is null OR (IdDiagnostico = @IdDiagnostico) or @IdDiagnostico =0)  
     and (@IdDiagnosticoPadre is null OR IdDiagnosticoPadre = @IdDiagnosticoPadre)       
     and (@Nombre is null  OR @Nombre =''  OR  upper(Nombre) like '%'+upper(@Nombre)+'%')       
     and (@Estado is null OR Estado = @Estado)        
     and (@CodigoDiagnostico is null  OR @CodigoDiagnostico =''  OR  upper(CodigoDiagnostico) like '%'+upper(@CodigoDiagnostico)+'%')  
   
   ) AS LISTADO  
     WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR    
            RowNumber BETWEEN @Inicio  AND @NumeroFilas   
    
       END  
       ELSE  
  IF @Accion ='LISTAR'      
    BEGIN      
  SELECT  
    IdDiagnostico,  
    CodigoDiagnostico,  
    CodigoPadre,  
    Nombre,  
    Descripcion,  
    Estado,  
    UsuarioCreacion,  
    FechaCreacion,  
    UsuarioModificacion,  
    FechaModificacion,  
    IdDiagnosticoPadre,  
    Orden,  
    CadenaRecursividad,  
    Nivel,  
    DiagnosticoSiteds,  
    IndicadorPermitido,  
    tipoFolder,  
    NombreTabla,  
    Accion,  
    Version  
    FROM SS_GE_Diagnostico    
     WHERE   
       (@IdDiagnostico is null OR (IdDiagnostico = @IdDiagnostico) or @IdDiagnostico =0)  
     and (@IdDiagnosticoPadre is null OR IdDiagnosticoPadre = @IdDiagnosticoPadre)       
     and (@Nombre is null  OR @Nombre =''  OR  upper(Nombre) like '%'+upper(@Nombre)+'%')       
     and (@Estado is null OR Estado = @Estado)        
     and (@CodigoDiagnostico is null  OR @CodigoDiagnostico =CodigoDiagnostico)  
   
end   
 else  
 if(@ACCION = 'LISTARPORID')  
 begin    
    SELECT   
     *       
    from   
    SS_GE_Diagnostico  
  
     WHERE   
       (CodigoPadre = @CodigoPadre) 
  
 end   
 else  
 if(@ACCION = 'LISTANDOPORID')  
 begin    
    SELECT   
     *       
    from   
    SS_GE_Diagnostico  
  
     WHERE   
		(@IdDiagnostico is null OR (IdDiagnostico = @IdDiagnostico) or @IdDiagnostico =0)  
        
  
 end   
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GE_VARIOSLISTAR]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_GE_VARIOSLISTAR]
@CodigoTabla varchar(15),
@Secuencial int,
@CodigoTablaPadre varchar(15),
@SecuencialPadre int,
@Nemonico varchar(7),
@Descripcion varchar(80),
@ValorFecha datetime,
@ValorNumerico decimal(20,6),
@ValorTexto varchar(30),
@IndicadorUso int,
@IndicadorAgregarHijo int,
@Estado int,
@UsuarioCreacion varchar(25),
@FechaCreacion datetime,
@UsuarioModificacion varchar(25),
@FechaModificacion datetime,
@OrdenEstablecido int,
@Accion  varchar(25) 
AS
BEGIN
	SET NOCOUNT ON;
	 
	IF @Accion ='LISTAR'
		BEGIN
				select * from GE_VARIOS where CodigoTabla='HCTIPOCUIDPREV' and Secuencial > 0		 
		END
	 
 END
	
GO
/****** Object:  StoredProcedure [dbo].[SP_HC_Personamast]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_HC_Personamast]         
  @Persona                      INT,         
  @Origen                       CHAR(4),         
  @ApellidoPaterno              VARCHAR(40),         
  @ApellidoMaterno              VARCHAR(40),         
  @Nombres                      VARCHAR(40),         
          
  @NombreCompleto               VARCHAR(100),         
  @Busqueda                     VARCHAR(100),         
  @GrupoEmpresarial             CHAR(4),         
  @TipoDocumento                CHAR(1),         
  @Documento                    CHAR(20),         
          
  @CodigoBarras                 CHAR(18),         
  @EsCliente                    CHAR(1),         
  @EsProveedor                  CHAR(1),         
  @EsEmpleado                   CHAR(1),         
  @EsOtro                       CHAR(1),         
          
  @TipoPersona                  CHAR(1),         
  @FechaNacimiento              DATETIME,         
  @CiudadNacimiento             CHAR(20),         
  @Sexo                         CHAR(1),         
  @Nacionalidad                 CHAR(20),         
          
  @EstadoCivil                  CHAR(1),         
  @NivelInstruccion             CHAR(3),         
  @Direccion                    VARCHAR(190),         
  @CodigoPostal                 CHAR(3),         
  @Provincia                    CHAR(3),         
          
  @Departamento                 CHAR(3),         
  @Telefono                     VARCHAR(15),         
  @Fax                          VARCHAR(15),         
  @DocumentoFiscal              CHAR(20),         
  @DocumentoIdentidad           CHAR(20),         
          
  @CarnetExtranjeria            CHAR(10),         
  @DocumentoMilitarFA           CHAR(10),         
  @TipoBrevete                  CHAR(1),         
  @Brevete                      CHAR(18),         
  @Pasaporte                    CHAR(18),         
          
  @NombreEmergencia             VARCHAR(50),         
  @DireccionEmergencia          VARCHAR(60),         
  @TelefonoEmergencia           VARCHAR(15),         
  @BancoMonedaLocal             CHAR(3),         
  @TipoCuentaLocal              CHAR(3),         
          
  @CuentaMonedaLocal            CHAR(20),         
  @BancoMonedaExtranjera        CHAR(3),         
  @TipoCuentaExtranjera         CHAR(3),         
  @CuentaMonedaExtranjera       CHAR(20),         
  @PersonaAnt                   CHAR(15),         
          
  @CorreoElectronico            VARCHAR(50),         
  @ClasePersonaCodigo           CHAR(3),         
  @PersonaClasificacion         CHAR(8),         
  @EnfermedadGraveFlag          CHAR(1),         
  @IngresoFechaRegistro         DATETIME,         
          
  @IngresoAplicacionCodigo      CHAR(2),         
  @IngresoUsuario               VARCHAR(25),         
  @PYMEFlag                     CHAR(1),         
  @Estado                       CHAR(1),         
  @UltimoUsuario                VARCHAR(25),         
          
  @UltimaFechaModif             DATETIME,         
  @TipoPersonaUsuario           CHAR(3),         
  @DireccionReferencia          VARCHAR(255),         
  @Celular                      VARCHAR(15),         
  @ParentescoEmergencia         CHAR(15),         
          
  @CelularEmergencia            VARCHAR(15),         
  @LugarNacimiento              VARCHAR(255),         
  @SuspensionFonaviFlag         VARCHAR(10),         
  @FlagRepetido                 CHAR(1),         
  @CodDiscamec                  VARCHAR(15),         
          
  @FecIniDiscamec               DATETIME,         
  @FecFinDiscamec               DATETIME,         
  @CodLicArma                   VARCHAR(15),         
  @MarcaArma                    VARCHAR(10),         
  @SerieArma                    VARCHAR(10),         
          
  @InicioArma                   DATETIME,         
  @VencimientoArma              DATETIME,         
  @SeguroDiscamec               CHAR(1),         
  @CorrelativoSCTR              VARCHAR(3),         
  @CuentaMonedaExtranjera_tmp   CHAR(15),         
          
  @CuentaMonedaLocal_tmp        CHAR(15),         
  @FlagActualizacion            CHAR(1),         
  @TarjetadeCredito             CHAR(20),         
  @Pais                         CHAR(4),     
  @EsPaciente                   VARCHAR(1),         
          
  @EsEmpresa                    VARCHAR(1),         
  @Persona_Old                  INT,         
  @personanew                   INT,         
  @cmp                          VARCHAR(15),         
  @SUNATNacionalidad            CHAR(6),         
          
  @SUNATVia                     CHAR(2),         
  @SUNATZona                    CHAR(2),         
  @SUNATUbigeo         CHAR(10),         
  @SUNATDomiciliado             CHAR(1),         
  @IndicadorAutogenerado        INT,         
          
  @RutaFirma                    VARCHAR(250),         
  @TipoDocumentoIdentidad       CHAR(1),         
  @IdPersonaUnificado           INT,         
  @idpersona_ok                 INT,         
  @edad                         INT,         
          
  @rangoEtario                  VARCHAR(10),         
  @TipoMedico                   INT,         
  @Correcion                    INT,         
  @IdEmpresaAnteriorUnificacion INT,         
  @brevete_fecvcto              DATETIME,         
          
  @carnetextranjeria_fecvcto    DATETIME,         
  @Estado_BK                    CHAR(1),         
  @Estado_Bks                   CHAR(1),         
  @IndicadorVinculada           INT,         
  @PaisEmisor                   CHAR(3),         
          
  @CodigoLDN                    CHAR(3),         
  @SunatConvenio                CHAR(1),         
  @IndicadorRegistroManual      INT,         
  @IndicadorFallecido           INT,         
  @IndicadorSinCorreo           INT,        
           
  @ACCION                       VARCHAR(25)         
AS         
  BEGIN         
          
 DECLARE @CONTADORS INT          
    SET nocount ON;         
    IF @Accion = 'INSERT'         
 BEGIN           
   select @CONTADORS= isnull(MAX(Persona),0)+1 from personamast         
          
  set @Persona= @CONTADORS        
         
      INSERT INTO personamast         
                  (         
                              persona,         
                              origen,         
                              apellidopaterno,         
                              apellidomaterno,         
                              nombres,         
                              nombrecompleto,         
                              busqueda,         
                              grupoempresarial,         
                              tipodocumento,         
                              documento,         
                              codigobarras,         
                              escliente,         
                              esproveedor,         
                              esempleado,         
                              esotro,         
                              tipopersona,         
                              fechanacimiento,         
                              ciudadnacimiento,         
                              sexo,         
                              nacionalidad,         
                              estadocivil,         
                              nivelinstruccion,         
                              direccion,         
                              codigopostal,         
                              provincia,         
                              departamento,         
                              telefono,         
                              fax,         
                              documentofiscal,         
                              documentoidentidad,         
                              carnetextranjeria,         
                              documentomilitarfa,         
                              tipobrevete,         
                              brevete,         
                              pasaporte,         
                              nombreemergencia,         
       direccionemergencia,         
                              telefonoemergencia,         
                              bancomonedalocal,         
                              tipocuentalocal,         
                              cuentamonedalocal,         
                              bancomonedaextranjera,         
                              tipocuentaextranjera,         
                              cuentamonedaextranjera,         
                              personaant,         
                              correoelectronico,         
                              clasepersonacodigo,         
                              personaclasificacion,         
                              enfermedadgraveflag,         
                              ingresofecharegistro,         
                              ingresoaplicacioncodigo,         
                              ingresousuario,         
                              pymeflag,         
                              estado,         
                              ultimousuario,         
                              ultimafechamodif,         
                              tipopersonausuario,         
                              direccionreferencia,         
                              celular,         
                              parentescoemergencia,         
                              celularemergencia,         
                              lugarnacimiento,         
                              suspensionfonaviflag,         
                              flagrepetido,         
                              coddiscamec,         
                              fecinidiscamec,         
                              fecfindiscamec,         
                              codlicarma,         
                              marcaarma,         
                              seriearma,         
                              inicioarma,         
                              vencimientoarma,         
                              segurodiscamec,         
                              correlativosctr,         
                              cuentamonedaextranjera_tmp,         
                              cuentamonedalocal_tmp,         
                              flagactualizacion,         
                              tarjetadecredito,         
                              pais,         
                              espaciente,         
                              esempresa,         
                              persona_old,         
                              personanew,         
                              cmp,         
                              sunatnacionalidad,         
                              sunatvia,         
                              sunatzona,         
                              sunatubigeo,         
                              sunatdomiciliado,         
                              indicadorautogenerado,         
                              rutafirma,         
                              tipodocumentoidentidad,         
                              idpersonaunificado,         
                              idpersona_ok,         
                              edad,         
                              rangoetario,         
                              tipomedico,         
                              correcion,         
                              idempresaanteriorunificacion,         
                              brevete_fecvcto,         
                              carnetextranjeria_fecvcto,         
                              estado_bk,         
                              estado_bks,         
                              indicadorvinculada,         
                              paisemisor,         
                              codigoldn,         
                              sunatconvenio,         
                              indicadorregistromanual,         
                              indicadorfallecido,         
                              indicadorsincorreo,         
                              accion         
                  )         
                  VALUES         
                  (         
                              @Persona,         
                              @Origen,         
                              @ApellidoPaterno,         
                              @ApellidoMaterno,         
                              @Nombres,         
                              @NombreCompleto,         
                              @Busqueda,         
         @GrupoEmpresarial,         
                              @TipoDocumento,         
                              @Documento,         
                              @CodigoBarras,         
                              @EsCliente,         
                              @EsProveedor,         
                              @EsEmpleado,         
                              @EsOtro,         
                              @TipoPersona,         
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
                              @Fax,         
                              @DocumentoFiscal,         
                              @DocumentoIdentidad,         
        @CarnetExtranjeria,         
                              @DocumentoMilitarFA,         
                              @TipoBrevete,         
                              @Brevete,         
                              @Pasaporte,         
                              @NombreEmergencia,         
                              @DireccionEmergencia,         
                              @TelefonoEmergencia,         
                              @BancoMonedaLocal,         
                              @TipoCuentaLocal,         
                              @CuentaMonedaLocal,         
                              @BancoMonedaExtranjera,         
                              @TipoCuentaExtranjera,         
                              @CuentaMonedaExtranjera,         
                              @PersonaAnt,         
                              @CorreoElectronico,         
                              @ClasePersonaCodigo,         
                              @PersonaClasificacion,         
                              @EnfermedadGraveFlag,         
                              @IngresoFechaRegistro,         
                              @IngresoAplicacionCodigo,         
                              @IngresoUsuario,         
                              @PYMEFlag,         
                              @Estado,         
                              @UltimoUsuario,         
                              @UltimaFechaModif,         
                              @TipoPersonaUsuario,         
                              @DireccionReferencia,         
                              @Celular,         
                              @ParentescoEmergencia,         
                              @CelularEmergencia,         
                              @LugarNacimiento,         
                              @SuspensionFonaviFlag,         
                              @FlagRepetido,         
                              @CodDiscamec,         
                              @FecIniDiscamec,         
                              @FecFinDiscamec,         
                              @CodLicArma,         
                              @MarcaArma,         
                              @SerieArma,         
                              @InicioArma,         
                              @VencimientoArma,         
                            @SeguroDiscamec,         
                              @CorrelativoSCTR,         
                              @CuentaMonedaExtranjera_tmp,         
                              @CuentaMonedaLocal_tmp,         
                              @FlagActualizacion,         
                              @TarjetadeCredito,         
                              @Pais,         
                              @EsPaciente,         
                              @EsEmpresa,         
                              @Persona_Old,         
                              @personanew,         
                              @cmp,         
           @SUNATNacionalidad,         
                              @SUNATVia,         
                              @SUNATZona,         
                              @SUNATUbigeo,         
                              @SUNATDomiciliado,         
                              @IndicadorAutogenerado,         
                              @RutaFirma,         
                              @TipoDocumentoIdentidad,         
                              @IdPersonaUnificado,         
                              @idpersona_ok,         
                              @edad,         
                              @rangoEtario,         
                              @TipoMedico,         
                              @Correcion,         
                              @IdEmpresaAnteriorUnificacion,         
                              @brevete_fecvcto,         
                              @carnetextranjeria_fecvcto,         
                              @Estado_BK,         
                              @Estado_Bks,         
                              @IndicadorVinculada,         
                              @PaisEmisor,         
                              @CodigoLDN,         
                              @SunatConvenio,         
                              @IndicadorRegistroManual,         
                              @IndicadorFallecido,         
                              @IndicadorSinCorreo,         
                              @ACCION         
                  )         
          IF NOT EXISTS (SELECT *FROM SS_HC_PersonalSalud   WHERE IdPersonalSalud = @Persona)      
	BEGIN      
	 insert into SS_HC_PersonalSalud  
 ( IdPersonalSalud,CodigoPersonalSalud,TipoDocumentoIdentidad,NumeroDocumentoIdentidad,Estado,UsuarioCreacion,FechaCreacion)  
	values(@Persona,'08',@TipoDocumento,@DocumentoIdentidad ,'A',@UltimoUsuario,GETDATE())        
	END 
     SELECT 1         
    END         
    ELSE         
    IF @Accion = 'UPDATE'         
    BEGIN         
    IF(@idpersona_ok = 0)      
    BEGIN      
    UPDATE personamast         
  SET            
  persona=@Persona,         
  origen=@Origen,         
  apellidopaterno=@ApellidoPaterno,         
  apellidomaterno=@ApellidoMaterno,         
  nombres=@Nombres,        
  TipoDocumentoIdentidad=@TipoDocumentoIdentidad,         
  DocumentoIdentidad=@DocumentoIdentidad,        
  fechanacimiento=@FechaNacimiento,         
  ciudadnacimiento=@CiudadNacimiento,         
        sexo=@Sexo,         
        estadocivil=@EstadoCivil,         
        direccion=@Direccion,         
        codigopostal=@CodigoPostal,         
        provincia=@Provincia,         
        departamento=@Departamento,         
        telefono=@Telefono,                     
        documentofiscal=@DocumentoFiscal,                       
        celular=@Celular,                      
        pais=@Pais,                      
        tipomedico=@TipoMedico,        
        UltimaFechaModif = GETDATE(),        
        UltimoUsuario = @UltimoUsuario,        
        accion=@ACCION         
 WHERE  ( personamast.persona = @Persona )         
     if not exists (select * from EMPLEADOMAST where (empleadomast.Empleado = @Persona))        
  begin        
  insert into EMPLEADOMAST        
  (Empleado,TipoTrabajadorSalud,TipoTrabajador,ACCION,CompaniaSocio)        
  values(@Persona,'08','08',@ACCION,'999999')          
  end        
  else        
  begin        
  update EMPLEADOMAST        
  set TipoTrabajadorSalud = '08'    ,  
  TipoTrabajador = '08'    
  , ACCION = @ACCION        
  where empleado=@persona        
  end        
  IF NOT EXISTS (SELECT *FROM SS_GE_ESPECIALIDADMEDICO WHERE IdMedico = @Persona)      
  BEGIN      
  insert into SS_GE_ESPECIALIDADMEDICO        
  (IdEspecialidad,IdMedico,Estado,UsuarioCreacion,FechaCreacion,UsuarioModificacion,FechaModificacion,ACCION)        
  values(@TipoMedico,@Persona,2,@UltimoUsuario,GETDATE(),@UltimoUsuario,GETDATE(),@ACCION)        
  END
	IF NOT EXISTS (SELECT *FROM SS_HC_PersonalSalud   WHERE IdPersonalSalud = @Persona)      
	BEGIN      
	insert into SS_HC_PersonalSalud  
	( IdPersonalSalud,CodigoPersonalSalud,TipoDocumentoIdentidad,NumeroDocumentoIdentidad,Estado,UsuarioCreacion,FechaCreacion)  
	values(@Persona,'08',@TipoDocumento,@DocumentoIdentidad ,'A',@UltimoUsuario,GETDATE())        
	END   
    END      
    ELSE       
    BEGIN      
      UPDATE personamast         
      SET    persona=@Persona,         
             origen=@Origen,         
             apellidopaterno=@ApellidoPaterno,         
             apellidomaterno=@ApellidoMaterno,         
             nombres=@Nombres,         
             nombrecompleto=@NombreCompleto,         
             busqueda=@Busqueda,         
             grupoempresarial=@GrupoEmpresarial,         
             tipodocumento=@TipoDocumento,         
             documento=@Documento,         
             codigobarras=@CodigoBarras,         
             escliente=@EsCliente,         
             esproveedor=@EsProveedor,         
             esempleado=@EsEmpleado,         
             esotro=@EsOtro,         
             tipopersona=@TipoPersona,         
             fechanacimiento=@FechaNacimiento,         
             ciudadnacimiento=@CiudadNacimiento,         
             sexo=@Sexo,         
             nacionalidad=@Nacionalidad,         
             estadocivil=@EstadoCivil,         
             nivelinstruccion=@NivelInstruccion,         
             direccion=@Direccion,         
             codigopostal=@CodigoPostal,         
             provincia=@Provincia,         
             departamento=@Departamento,         
             telefono=@Telefono,         
             fax=@Fax,         
             documentofiscal=@DocumentoFiscal,         
             documentoidentidad=@DocumentoIdentidad,         
             carnetextranjeria=@CarnetExtranjeria,         
             documentomilitarfa=@DocumentoMilitarFA,         
            tipobrevete=@TipoBrevete,         
             brevete=@Brevete,         
             pasaporte=@Pasaporte,         
             nombreemergencia=@NombreEmergencia,         
             direccionemergencia=@DireccionEmergencia,         
             telefonoemergencia=@TelefonoEmergencia,         
             bancomonedalocal=@BancoMonedaLocal,         
             tipocuentalocal=@TipoCuentaLocal,         
             cuentamonedalocal=@CuentaMonedaLocal,         
             bancomonedaextranjera=@BancoMonedaExtranjera,         
             tipocuentaextranjera=@TipoCuentaExtranjera,         
             cuentamonedaextranjera=@CuentaMonedaExtranjera,         
             personaant=@PersonaAnt,         
             correoelectronico=@CorreoElectronico,         
             clasepersonacodigo=@ClasePersonaCodigo,         
             personaclasificacion=@PersonaClasificacion,         
             enfermedadgraveflag=@EnfermedadGraveFlag,         
             ingresofecharegistro=@IngresoFechaRegistro,         
             ingresoaplicacioncodigo=@IngresoAplicacionCodigo,         
             ingresousuario=@IngresoUsuario,         
             pymeflag=@PYMEFlag,         
             estado=@Estado,         
             ultimousuario=@UltimoUsuario,         
             ultimafechamodif=@UltimaFechaModif,         
             tipopersonausuario=@TipoPersonaUsuario,         
             direccionreferencia=@DireccionReferencia,         
             celular=@Celular,         
             parentescoemergencia=@ParentescoEmergencia,         
             celularemergencia=@CelularEmergencia,         
             lugarnacimiento=@LugarNacimiento,         
             suspensionfonaviflag=@SuspensionFonaviFlag,         
             flagrepetido=@FlagRepetido,         
             coddiscamec=@CodDiscamec,         
             fecinidiscamec=@FecIniDiscamec,         
             fecfindiscamec=@FecFinDiscamec,         
             codlicarma=@CodLicArma,         
             marcaarma=@MarcaArma,         
             seriearma=@SerieArma,         
             inicioarma=@InicioArma,         
             vencimientoarma=@VencimientoArma,         
             segurodiscamec=@SeguroDiscamec,         
             correlativosctr=@CorrelativoSCTR,         
             cuentamonedaextranjera_tmp=@CuentaMonedaExtranjera_tmp,         
             cuentamonedalocal_tmp=@CuentaMonedaLocal_tmp,         
             flagactualizacion=@FlagActualizacion,         
             tarjetadecredito=@TarjetadeCredito,         
             pais=@Pais,         
             espaciente=@EsPaciente,         
             esempresa=@EsEmpresa,         
             persona_old=@Persona_Old,         
             personanew=@personanew,         
             cmp=@cmp,         
             sunatnacionalidad=@SUNATNacionalidad,         
             sunatvia=@SUNATVia,         
             sunatzona=@SUNATZona,         
             sunatubigeo=@SUNATUbigeo,         
             sunatdomiciliado=@SUNATDomiciliado,         
             indicadorautogenerado=@IndicadorAutogenerado,         
             rutafirma=@RutaFirma,         
             tipodocumentoidentidad=@TipoDocumentoIdentidad,         
             idpersonaunificado=@IdPersonaUnificado,         
             idpersona_ok=@idpersona_ok,         
             edad=@edad,         
             rangoetario=@rangoEtario,         
             tipomedico=@TipoMedico,         
             correcion=@Correcion,         
             idempresaanteriorunificacion=@IdEmpresaAnteriorUnificacion,         
             brevete_fecvcto=@brevete_fecvcto,         
             carnetextranjeria_fecvcto=@carnetextranjeria_fecvcto,         
             estado_bk=@Estado_BK,         
             estado_bks=@Estado_Bks,         
             indicadorvinculada=@IndicadorVinculada,         
             paisemisor=@PaisEmisor,         
             codigoldn=@CodigoLDN,         
             sunatconvenio=@SunatConvenio,         
             indicadorregistromanual=@IndicadorRegistroManual,         
             indicadorfallecido=@IndicadorFallecido,         
             indicadorsincorreo=@IndicadorSinCorreo,         
             accion=@ACCION         
      WHERE  ( personamast.persona = @Persona )         
      END      
      SELECT 1         
   END         
    ELSE         
    IF @Accion = 'DELETE'         
    BEGIN         
      DELETE         
      FROM   personamast         
      WHERE  ( personamast.persona = @Persona )         
      SELECT 1         
    END        
    ELSE         
    IF( @ACCION = 'LISTARPAG' )         
    BEGIN         
      DECLARE @CONTADOR INT         
      SET @CONTADOR =         
      (         
             SELECT Count(*)         
             FROM   personamast         
             where (@Persona IS NULL OR     ( @Persona =0 ) OR  cast(Persona as VARCHAR) like '%'+upper(@Persona)+'%')         
             and    ( @NombreCompleto is NULL OR     @NombreCompleto ='' OR     upper(nombrecompleto) LIKE '%'+upper(@NombreCompleto)+'%')         
             AND    ( @ESTADO IS NULL OR     estado = @ESTADO)         
             AND    ( @Documento IS NULL OR     rtrim(upper(documento)) LIKE '%'+rtrim(upper(@Documento))+'%') )         
      SELECT @CONTADOR;         
             
    END         
    ELSE IF @Accion = 'NUEVO'         
    BEGIN          
  select @CONTADORS= isnull(MAX(Persona),0)+1 from personamast         
  set @Persona= @CONTADORS        
  set @ACCION ='INSERT'         
            
  INSERT INTO personamast(         
  persona,         
  origen,         
  apellidopaterno,         
  apellidomaterno,         
  nombres,         
  tipodocumento,         
  documento,         
  fechanacimiento,         
  sexo,         
  estadocivil,         
  direccion,         
  codigopostal,         
  provincia,         
  departamento,         
  telefono,        
  documentofiscal,        
  celular,        
  pais,        
  tipomedico,        
  UltimoUsuario,        
  UltimaFechaModif,        
  accion) VALUES (         
  @Persona,         
  @Origen,         
  @ApellidoPaterno,         
  @ApellidoMaterno,         
  @Nombres,         
  @TipoDocumento,         
  @Documento,         
  @FechaNacimiento,        
  @Sexo,         
  @EstadoCivil,         
  @Direccion,         
  @CodigoPostal,         
  @Provincia,         
  @Departamento,         
  @Telefono,         
  @DocumentoFiscal,         
  @Celular,         
  @Pais,        
  @TipoMedico,         
  @UltimoUsuario,        
  GETDATE(),        
  @ACCION )         
       
      SELECT 1         
 END         
    ELSE IF @Accion = 'MODIFICAR'         
    BEGIN         
    SET @ACCION ='UPDATE'        
  UPDATE personamast         
  SET            
  persona=@Persona,         
  origen=@Origen,         
  apellidopaterno=@ApellidoPaterno,         
  apellidomaterno=@ApellidoMaterno,         
  nombres=@Nombres,        
  TipoDocumentoIdentidad=@TipoDocumentoIdentidad,         
  DocumentoIdentidad=@DocumentoIdentidad,        
  fechanacimiento=@FechaNacimiento,         
  ciudadnacimiento=@CiudadNacimiento,         
        sexo=@Sexo,         
        estadocivil=@EstadoCivil,         
        direccion=@Direccion,         
        codigopostal=@CodigoPostal,         
        provincia=@Provincia,         
        departamento=@Departamento,         
        telefono=@Telefono,                     
        documentofiscal=@DocumentoFiscal,                       
        celular=@Celular,                      
        pais=@Pais,                      
        tipomedico=@TipoMedico,        
        UltimaFechaModif = GETDATE(),        
        UltimoUsuario = @UltimoUsuario,        
        accion=@ACCION         
 WHERE  ( personamast.persona = @Persona )         
    SELECT 1         
    END       
     IF (@ACCION IS NOT NULL)      
     BEGIN      
     EXEC SP_SS_HC_PacienteDocumentos @SUNATUbigeo,@Persona,NULL,@TipoDocumento,@Documento,NULL,@Estado,@UltimoUsuario,NULL,@UltimoUsuario,NULL,@ACCION             
     END       
  END      
   if(@Accion = 'INSERTGRUPOFAM')        
  begin        
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
            VALUES     ( @personanew,     
                         @IndicadorAutogenerado,     
                         @IdPersonaUnificado,     
                         @Estado,     
                         @UltimoUsuario,     
                         Getdate(),     
                         @UltimoUsuario,     
                         Getdate(),     
                         @Accion )     
  select 1    
  end       
 else         
 if(@Accion = 'DELETEGRUPOFAM')        
  begin        
   DELETE ss_hc_grupofamiliar     
            WHERE  ( idpaciente = @personanew )     
                   AND ( idpacientefamiliar = @IndicadorAutogenerado )     
                   AND ( tipofamiliar = @IdPersonaUnificado )     
  select 1    
  end         
  /*         
EXEC SP_HC_Personamast         
5,'CEG', 'AGUILAR', 'SEGURA', 'JORGE ARTURO',NULL,NULL, NULL, 'R', '10092979691',          
NULL,NULL, NULL, NULL, NULL,NULL,NULL, NULL, 'M', NULL,         
'S',NULL, 'AV.  28 DE JULIO 250  DPTO. 1002 LIMA LIMA MIRAFLORES', '25', '04',12,'33333', NULL, '4444', '69854214',         
NULL,NULL, NULL, NULL, NULL,NULL,NULL, NULL, NULL, NULL,         
NULL,NULL, NULL, NULL, NULL,NULL,NULL, NULL, NULL, NULL,         
NULL,NULL, NULL, NULL, NULL,NULL,NULL, NULL, '44444', NULL,         
NULL,NULL, NULL, NULL, NULL,NULL,NULL, NULL, NULL, NULL,         
NULL,NULL, NULL, NULL, NULL,NULL,NULL, NULL, 'PER', NULL,         
NULL,NULL, NULL, NULL, NULL,NULL,NULL, NULL, NULL, NULL,         
NULL,'D', NULL, NULL, NULL,NULL,2, NULL, NULL, NULL,         
NULL,NULL, NULL, NULL, NULL,NULL,NULL, NULL, NULL, NULL,         
LISTARPAG          
*/
GO
/****** Object:  StoredProcedure [dbo].[SP_HC_Personamast_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_HC_Personamast_Listar]       
@Persona                      INT,       
  @Origen                       CHAR(4),       
  @ApellidoPaterno              VARCHAR(40),       
  @ApellidoMaterno              VARCHAR(40),       
  @Nombres                      VARCHAR(40),       
        
  @NombreCompleto               VARCHAR(100),       
  @Busqueda                     VARCHAR(100),       
  @GrupoEmpresarial             CHAR(4),       
  @TipoDocumento                CHAR(1),       
  @Documento                    CHAR(20),       
        
  @CodigoBarras                 CHAR(18),       
  @EsCliente                    CHAR(1),       
  @EsProveedor                  CHAR(1),       
  @EsEmpleado                   CHAR(1),       
  @EsOtro                       CHAR(1),       
        
  @TipoPersona                  CHAR(1),       
  @FechaNacimiento              DATETIME,       
  @CiudadNacimiento             CHAR(20),       
  @Sexo                         CHAR(1),       
  @Nacionalidad                 CHAR(20),       
        
  @EstadoCivil                  CHAR(1),       
  @NivelInstruccion             CHAR(3),       
  @Direccion                    VARCHAR(190),       
  @CodigoPostal                 CHAR(3),       
  @Provincia                    CHAR(3),       
        
  @Departamento                 CHAR(3),       
  @Telefono                     VARCHAR(15),       
  @Fax                          VARCHAR(15),       
  @DocumentoFiscal              CHAR(20),       
  @DocumentoIdentidad           CHAR(20),       
        
  @CarnetExtranjeria            CHAR(10),       
  @DocumentoMilitarFA           CHAR(10),       
  @TipoBrevete                  CHAR(1),       
  @Brevete                      CHAR(18),       
  @Pasaporte                    CHAR(18),       
        
  @NombreEmergencia             VARCHAR(50),       
  @DireccionEmergencia          VARCHAR(60),       
  @TelefonoEmergencia           VARCHAR(15),       
  @BancoMonedaLocal             CHAR(3),       
  @TipoCuentaLocal              CHAR(3),       
        
  @CuentaMonedaLocal            CHAR(20),       
  @BancoMonedaExtranjera        CHAR(3),       
  @TipoCuentaExtranjera         CHAR(3),       
  @CuentaMonedaExtranjera       CHAR(20),       
  @PersonaAnt                   CHAR(15),       
        
  @CorreoElectronico            VARCHAR(50),       
  @ClasePersonaCodigo           CHAR(3),       
  @PersonaClasificacion         CHAR(8),       
  @EnfermedadGraveFlag          CHAR(1),       
  @IngresoFechaRegistro         DATETIME,       
        
  @IngresoAplicacionCodigo      CHAR(2),       
  @IngresoUsuario               VARCHAR(25),       
  @PYMEFlag                     CHAR(1),       
  @Estado                       CHAR(1),       
  @UltimoUsuario                VARCHAR(25),       
        
  @UltimaFechaModif             DATETIME,       
  @TipoPersonaUsuario           CHAR(3),       
  @DireccionReferencia          VARCHAR(255),       
  @Celular                      VARCHAR(15),       
  @ParentescoEmergencia         CHAR(15),       
        
  @CelularEmergencia            VARCHAR(15),       
  @LugarNacimiento              VARCHAR(255),       
  @SuspensionFonaviFlag         VARCHAR(10),       
  @FlagRepetido                 CHAR(1),       
  @CodDiscamec                  VARCHAR(15),       
        
  @FecIniDiscamec               DATETIME,       
  @FecFinDiscamec               DATETIME,       
  @CodLicArma                   VARCHAR(15),       
  @MarcaArma                    VARCHAR(10),       
  @SerieArma                    VARCHAR(10),       
        
  @InicioArma                   DATETIME,       
  @VencimientoArma              DATETIME,       
  @SeguroDiscamec               CHAR(1),       
  @CorrelativoSCTR              VARCHAR(3),       
  @CuentaMonedaExtranjera_tmp   CHAR(15),       
        
  @CuentaMonedaLocal_tmp        CHAR(15),       
  @FlagActualizacion            CHAR(1),       
  @TarjetadeCredito             CHAR(20),       
  @Pais                         CHAR(4),       
  @EsPaciente                   VARCHAR(1),       
        
  @EsEmpresa                    VARCHAR(1),       
  @Persona_Old                  INT,       
  @personanew                   INT,       @cmp                          VARCHAR(15),       
  @SUNATNacionalidad            CHAR(6),       
        
  @SUNATVia                     CHAR(2),       
  @SUNATZona                    CHAR(2),       
  @SUNATUbigeo              CHAR(10),       
  @SUNATDomiciliado             CHAR(1),       
  @IndicadorAutogenerado        INT,       
        
  @RutaFirma                    VARCHAR(250),       
  @TipoDocumentoIdentidad       CHAR(1),       
  @IdPersonaUnificado           INT,       
  @idpersona_ok                 INT,       
  @edad                         INT,       
        
  @rangoEtario                  VARCHAR(10),       
  @TipoMedico                   INT,       
  @Correcion                    INT,       
  @IdEmpresaAnteriorUnificacion INT,       
  @brevete_fecvcto              DATETIME,       
        
  @carnetextranjeria_fecvcto    DATETIME,       
  @Estado_BK                    CHAR(1),       
  @Estado_Bks                   CHAR(1),       
  @IndicadorVinculada           INT,       
  @PaisEmisor                   CHAR(3),       
        
  @CodigoLDN                    CHAR(3),       
  @SunatConvenio                CHAR(1),       
  @IndicadorRegistroManual      INT,       
  @IndicadorFallecido           INT,       
  @IndicadorSinCorreo           INT,      
         
  @ACCION                       VARCHAR(25),      
  @INICIO                       INT = NULL,       
  @NUMEROFILAS                  INT = NULL       
AS       
  BEGIN       
      DECLARE @CONTADOR INT       
      
      IF( @ACCION = 'LISTARPAG' )       
        BEGIN       
            SELECT @CONTADOR = Count(*)       
            FROM   dbo.personamast       
            where (@Persona IS NULL OR     ( @Persona =0 ) OR  cast(Persona as VARCHAR) like '%'+upper(@Persona)+'%')       
             and    ( @NombreCompleto is NULL OR     @NombreCompleto ='' OR     upper(nombrecompleto) LIKE '%'+upper(@NombreCompleto)+'%')       
             AND    ( @ESTADO IS NULL OR     estado = @ESTADO)       
             AND    ( @Documento IS NULL OR     rtrim(upper(documento)) LIKE '%'+rtrim(upper(@Documento))+'%')       
      
            SELECT persona,       
                   origen,       
                   apellidopaterno,       
                   apellidomaterno,       
                   nombres,       
                   nombrecompleto,       
                   busqueda,       
                   grupoempresarial,       
                   tipodocumento,       
                   documento,       
                   codigobarras,       
                   (case(EsCliente) when 'S' then '1' when 'N' then '0' end)as EsCliente,  
                   (case EsProveedor when 'S' then '1' when 'N' then '0' end) as EsProveedor,  
                   (case EsEmpleado when 'S' then '1' when 'N' then '0' end) as EsEmpleado,  
                   (case EsOtro when 'S' then '1' when 'N' then '0' end) as EsOtro,  
                   tipopersona,       
                   fechanacimiento,       
                   ciudadnacimiento,       
                   sexo,       
                   nacionalidad,       
                   estadocivil,       
                   nivelinstruccion,       
                   direccion,       
                   codigopostal,       
                   provincia,       
                   departamento,       
                   telefono,       
                   fax,       
                   documentofiscal,       
                   documentoidentidad,       
                   carnetextranjeria,       
                   documentomilitarfa,       
                   tipobrevete,       
                   brevete,       
                   pasaporte,       
                   nombreemergencia,       
                   direccionemergencia,       
                   telefonoemergencia,       
             bancomonedalocal,       
                   tipocuentalocal,       
                   cuentamonedalocal,       
                   bancomonedaextranjera,       
                   tipocuentaextranjera,       
                   cuentamonedaextranjera,       
                   personaant,       
                   correoelectronico,       
                   clasepersonacodigo,       
                   personaclasificacion,       
                   enfermedadgraveflag,       
                   ingresofecharegistro,       
                   ingresoaplicacioncodigo,       
                   ingresousuario,       
                   pymeflag,       
                   estado,       
                   ultimousuario,       
                   ultimafechamodif,       
                   tipopersonausuario,       
                   direccionreferencia,       
                   celular,       
                   parentescoemergencia,       
                   celularemergencia,       
                   lugarnacimiento,       
                   suspensionfonaviflag,       
                   flagrepetido,       
                   coddiscamec,       
                   fecinidiscamec,       
                   fecfindiscamec,       
                   codlicarma,       
                   marcaarma,       
                   seriearma,       
                   inicioarma,       
                   vencimientoarma,       
                   segurodiscamec,       
                   correlativosctr,       
                   cuentamonedaextranjera_tmp,       
                   cuentamonedalocal_tmp,       
                   flagactualizacion,       
                   tarjetadecredito,       
                   pais,       
                   espaciente,       
                   esempresa,       
                   persona_old,       
                   personanew,       
                   cmp,       
                   sunatnacionalidad,       
                   sunatvia,       
                   sunatzona,       
                   sunatubigeo,       
                   sunatdomiciliado,       
                   indicadorautogenerado,       
                   rutafirma,       
                   tipodocumentoidentidad,       
                   idpersonaunificado,       
                   idpersona_ok,       
                   edad,       
                   rangoetario,       
                   tipomedico,       
                   correcion,       
                   idempresaanteriorunificacion,       
                   brevete_fecvcto,       
                   carnetextranjeria_fecvcto,       
                   estado_bk,       
                   estado_bks,       
                   indicadorvinculada,       
                   paisemisor,       
                   codigoldn,       
                   sunatconvenio,       
                   indicadorregistromanual,       
                   indicadorfallecido,       
                   indicadorsincorreo,       
                   accion       
            FROM   (SELECT personamast.persona,       
                           personamast.origen,       
                           personamast.apellidopaterno,       
                           personamast.apellidomaterno,       
                           personamast.nombres,       
                           personamast.nombrecompleto,       
                           personamast.busqueda,       
                           personamast.grupoempresarial,       
                           personamast.tipodocumento,       
                           personamast.documento,       
                           personamast.codigobarras,       
                           personamast.EsCliente,       
                           personamast.EsProveedor,       
                           personamast.EsEmpleado,       
                           personamast.EsOtro,       
                           personamast.tipopersona,       
                           personamast.fechanacimiento,       
                        personamast.ciudadnacimiento,       
                           personamast.sexo,       
                           personamast.nacionalidad,       
                           personamast.estadocivil,       
                           personamast.nivelinstruccion,       
                           personamast.direccion,       
                           personamast.codigopostal,       
                           personamast.provincia,       
                           personamast.departamento,       
                           personamast.telefono,       
                           personamast.fax,       
                           personamast.documentofiscal,       
                           personamast.documentoidentidad,       
                           personamast.carnetextranjeria,       
                           personamast.documentomilitarfa,       
                           personamast.tipobrevete,       
                           personamast.brevete,       
                           personamast.pasaporte,       
                           personamast.nombreemergencia,       
                           personamast.direccionemergencia,       
                           personamast.telefonoemergencia,       
                           personamast.bancomonedalocal,       
                           personamast.tipocuentalocal,       
                           personamast.cuentamonedalocal,       
                           personamast.bancomonedaextranjera,       
                           personamast.tipocuentaextranjera,       
                           personamast.cuentamonedaextranjera,       
                           personamast.personaant,       
                           personamast.correoelectronico,       
                           personamast.clasepersonacodigo,       
                           personamast.personaclasificacion,       
                           personamast.enfermedadgraveflag,       
                           personamast.ingresofecharegistro,       
                           personamast.ingresoaplicacioncodigo,       
                           personamast.ingresousuario,       
                           personamast.pymeflag,       
                           personamast.estado,       
                           personamast.ultimousuario,       
                           personamast.ultimafechamodif,       
                           personamast.tipopersonausuario,       
                           personamast.direccionreferencia,       
                           personamast.celular,       
                           personamast.parentescoemergencia,       
                           personamast.celularemergencia,       
                           personamast.lugarnacimiento,       
                           personamast.suspensionfonaviflag,       
                           personamast.flagrepetido,       
                           personamast.coddiscamec,       
                           personamast.fecinidiscamec,       
                           personamast.fecfindiscamec,       
                           personamast.codlicarma,       
                           personamast.marcaarma,       
                           personamast.seriearma,       
                           personamast.inicioarma,       
                           personamast.vencimientoarma,       
                           personamast.segurodiscamec,       
                           personamast.correlativosctr,       
                           personamast.cuentamonedaextranjera_tmp,       
                           personamast.cuentamonedalocal_tmp,       
                           personamast.flagactualizacion,       
                           personamast.tarjetadecredito,       
                           personamast.pais,       
                           personamast.espaciente,       
                           personamast.esempresa,       
                           personamast.persona_old,       
                           personamast.personanew,       
                           personamast.cmp,       
                           personamast.sunatnacionalidad,       
                           personamast.sunatvia,       
                           personamast.sunatzona,       
                           personamast.sunatubigeo,       
                           personamast.sunatdomiciliado,       
                           personamast.indicadorautogenerado,       
                           personamast.rutafirma,       
                           personamast.tipodocumentoidentidad,       
                           personamast.idpersonaunificado,       
                           personamast.idpersona_ok,       
                           personamast.edad,       
                           personamast.rangoetario,       
                           personamast.tipomedico,       
                           personamast.correcion,       
     personamast.idempresaanteriorunificacion,       
                           personamast.brevete_fecvcto,       
                           personamast.carnetextranjeria_fecvcto,       
                           personamast.estado_bk,       
                           personamast.estado_bks,       
                           personamast.indicadorvinculada,       
                           personamast.paisemisor,       
                           personamast.codigoldn,       
                           personamast.sunatconvenio,       
                           personamast.indicadorregistromanual,       
                           personamast.indicadorfallecido,       
                           personamast.indicadorsincorreo,       
     personamast.accion,       
                           @CONTADOR                  AS Contador,       
                           Row_number()       
                             OVER (       
                               ORDER BY persona ASC ) AS RowNumber       
                    FROM   dbo.personamast       
                     where (@Persona IS NULL OR     ( @Persona =0 ) OR  cast(Persona as VARCHAR) like '%'+upper(@Persona)+'%')       
             and    ( @NombreCompleto is NULL OR     @NombreCompleto ='' OR     upper(nombrecompleto) LIKE '%'+upper(@NombreCompleto)+'%')       
             AND    ( @ESTADO IS NULL OR     estado = @ESTADO)       
             AND    ( @Documento IS NULL OR     rtrim(upper(documento)) LIKE '%'+rtrim(upper(@Documento))+'%') )       
                   AS       
                   LISTADO       
            WHERE  ( @INICIO IS NULL       
                     AND @NUMEROFILAS IS NULL )       
                    OR rownumber BETWEEN @INICIO AND @NUMEROFILAS       
        END       
      ELSE IF( @ACCION = 'LISTAR' )       
        BEGIN       
            SELECT personamast.persona,       
                   personamast.origen,       
                   personamast.apellidopaterno,       
                   personamast.apellidomaterno,       
                   personamast.nombres,       
                   personamast.nombrecompleto,       
                   personamast.busqueda,       
                   personamast.grupoempresarial,       
                   personamast.tipodocumento,       
                   personamast.documento,       
                   personamast.codigobarras,       
                   personamast.escliente,       
                   personamast.esproveedor,       
                   personamast.esempleado,       
                   personamast.esotro,       
                   personamast.tipopersona,       
                   personamast.fechanacimiento,       
                   personamast.ciudadnacimiento,       
                   personamast.sexo,       
                   personamast.nacionalidad,       
                   personamast.estadocivil,       
                   personamast.nivelinstruccion,       
                   personamast.direccion,       
                   personamast.codigopostal,       
                   personamast.provincia,       
       personamast.departamento,       
                   personamast.telefono,       
                   personamast.fax,       
                   personamast.documentofiscal,       
                   personamast.documentoidentidad,       
                   personamast.carnetextranjeria,       
                   personamast.documentomilitarfa,       
                   personamast.tipobrevete,       
                   personamast.brevete,       
                   personamast.pasaporte,       
                   personamast.nombreemergencia,       
                   personamast.direccionemergencia,       
                   personamast.telefonoemergencia,       
                   personamast.bancomonedalocal,       
                   personamast.tipocuentalocal,       
                   personamast.cuentamonedalocal,       
                   personamast.bancomonedaextranjera,       
                   personamast.tipocuentaextranjera,       
                   personamast.cuentamonedaextranjera,       
                   personamast.personaant,       
                 personamast.correoelectronico,       
                   personamast.clasepersonacodigo,       
                   personamast.personaclasificacion,       
                   personamast.enfermedadgraveflag,       
                   personamast.ingresofecharegistro,       
                   personamast.ingresoaplicacioncodigo,       
                   personamast.ingresousuario,       
                   personamast.pymeflag,       
                   personamast.estado,       
                   personamast.ultimousuario,       
                   personamast.ultimafechamodif,       
                   personamast.tipopersonausuario,       
                   personamast.direccionreferencia,       
                   personamast.celular,       
                   personamast.parentescoemergencia,       
                   personamast.celularemergencia,       
                   personamast.lugarnacimiento,       
                   personamast.suspensionfonaviflag,       
                   personamast.flagrepetido,       
                   personamast.coddiscamec,       
                   personamast.fecinidiscamec,       
                   personamast.fecfindiscamec,       
                   personamast.codlicarma,       
                   personamast.marcaarma,       
                   personamast.seriearma,       
                   personamast.inicioarma,       
                   personamast.vencimientoarma,       
                   personamast.segurodiscamec,       
                   personamast.correlativosctr,       
                   personamast.cuentamonedaextranjera_tmp,       
                   personamast.cuentamonedalocal_tmp,       
                   personamast.flagactualizacion,       
                   personamast.tarjetadecredito,       
                   personamast.pais,       
                   personamast.espaciente,       
                   personamast.esempresa,       
                   personamast.persona_old,       
                   personamast.personanew,       
                   personamast.cmp,       
                   personamast.sunatnacionalidad,       
                   personamast.sunatvia,       
                   personamast.sunatzona,       
                   personamast.sunatubigeo,       
                   personamast.sunatdomiciliado,       
                   personamast.indicadorautogenerado,       
                   personamast.rutafirma,       
                   personamast.tipodocumentoidentidad,       
                   personamast.idpersonaunificado,       
                   personamast.idpersona_ok,       
                   personamast.edad,       
                   personamast.rangoetario,       
                   personamast.tipomedico,       
                   personamast.correcion,       
                   personamast.idempresaanteriorunificacion,       
                   personamast.brevete_fecvcto,       
                   personamast.carnetextranjeria_fecvcto,       
                   personamast.estado_bk,       
                   personamast.estado_bks,       
                   personamast.indicadorvinculada,       
                   personamast.paisemisor,       
                   personamast.codigoldn,       
                   personamast.sunatconvenio,       
                   personamast.indicadorregistromanual,       
                   personamast.indicadorfallecido,       
                   personamast.indicadorsincorreo,       
                   personamast.accion       
            FROM   dbo.personamast       
             where (@Persona IS NULL OR     ( @Persona =0 ) OR     persona = @Persona)       
             and    ( @NombreCompleto is NULL OR     @NombreCompleto ='' OR     upper(nombrecompleto) LIKE '%'+upper(@NombreCompleto)+'%')       
             AND    ( @ESTADO IS NULL OR     estado = @ESTADO)       
             AND    ( @Documento IS NULL OR     upper(documento) LIKE '%'+upper(@Documento)+'%')       
        END    
         ELSE IF( @ACCION = 'LISTARGRUPOFAM' )       
        BEGIN       
            SELECT personamast.persona,       
                   personamast.origen,       
                   personamast.apellidopaterno,       
                   personamast.apellidomaterno,       
                   personamast.nombres,       
                   personamast.nombrecompleto,       
                   personamast.busqueda,       
                   personamast.grupoempresarial,       
                   personamast.tipodocumento,       
                   personamast.documento,       
                   personamast.codigobarras,       
                   personamast.escliente,       
                   personamast.esproveedor,       
                   personamast.esempleado,       
                   personamast.esotro,       
                   personamast.tipopersona,       
                   personamast.fechanacimiento,       
                   personamast.ciudadnacimiento,       
                   personamast.sexo,       
                   personamast.nacionalidad,       
                   personamast.estadocivil,       
                   personamast.nivelinstruccion,       
                   personamast.direccion,       
                   personamast.codigopostal,       
                   personamast.provincia,       
       personamast.departamento,       
                   personamast.telefono,       
                   personamast.fax,       
                   personamast.documentofiscal,       
                   personamast.documentoidentidad,       
                   personamast.carnetextranjeria,       
                   personamast.documentomilitarfa,       
                   personamast.tipobrevete,       
                   personamast.brevete,       
                   personamast.pasaporte,       
                   personamast.nombreemergencia,       
                   personamast.direccionemergencia,       
                   personamast.telefonoemergencia,       
                   personamast.bancomonedalocal,       
                   personamast.tipocuentalocal,       
                   personamast.cuentamonedalocal,       
                   personamast.bancomonedaextranjera,       
                   personamast.tipocuentaextranjera,       
                   personamast.cuentamonedaextranjera,       
                   personamast.personaant,       
                 personamast.correoelectronico,       
                   personamast.clasepersonacodigo,       
                   personamast.personaclasificacion,       
                   personamast.enfermedadgraveflag,       
                   personamast.ingresofecharegistro,       
                   personamast.ingresoaplicacioncodigo,       
                   personamast.ingresousuario,       
                   personamast.pymeflag,       
                   personamast.estado,       
                   @UltimoUsuario as ultimousuario,       
                   personamast.ultimafechamodif,       
                   personamast.tipopersonausuario,       
                   personamast.direccionreferencia,       
                   personamast.celular,       
                   personamast.parentescoemergencia,       
                   personamast.celularemergencia,       
                   personamast.lugarnacimiento,       
                   personamast.suspensionfonaviflag,       
                   personamast.flagrepetido,       
                   personamast.coddiscamec,       
                   personamast.fecinidiscamec,       
                   personamast.fecfindiscamec,       
                   personamast.codlicarma,       
                   personamast.marcaarma,       
                   personamast.seriearma,       
                   personamast.inicioarma,       
                   personamast.vencimientoarma,       
                   personamast.segurodiscamec,       
                   personamast.correlativosctr,       
                   personamast.cuentamonedaextranjera_tmp,       
                   personamast.cuentamonedalocal_tmp,       
                   personamast.flagactualizacion,       
                   personamast.tarjetadecredito,       
                   personamast.pais,       
                   personamast.espaciente,       
                   personamast.esempresa,       
                   personamast.persona_old,       
                   personamast.personanew,       
                   personamast.cmp,       
                   personamast.sunatnacionalidad,       
                   personamast.sunatvia,       
                   personamast.sunatzona,       
                   personamast.sunatubigeo,       
                   personamast.sunatdomiciliado,       
                   personamast.indicadorautogenerado,       
                   personamast.rutafirma,       
                   personamast.tipodocumentoidentidad,       
                   personamast.idpersonaunificado,       
                   personamast.idpersona_ok,       
                   personamast.edad,       
                   personamast.rangoetario,       
                   personamast.tipomedico,       
                   personamast.correcion,       
                   personamast.idempresaanteriorunificacion,       
                   personamast.brevete_fecvcto,       
                   personamast.carnetextranjeria_fecvcto,       
                   personamast.estado_bk,       
                   personamast.estado_bks,       
                   personamast.indicadorvinculada,       
                   personamast.paisemisor,       
                   personamast.codigoldn,       
                   personamast.sunatconvenio,       
                   personamast.indicadorregistromanual,       
                   personamast.indicadorfallecido,       
                   personamast.indicadorsincorreo,       
                   personamast.accion       
            FROM   dbo.personamast       
             where (@Persona IS NULL OR     ( @Persona =0 ) OR     persona = @Persona)       
             and    ( @NombreCompleto is NULL OR     @NombreCompleto ='' OR     upper(nombrecompleto) LIKE '%'+upper(@NombreCompleto)+'%')       
             AND    ( @ESTADO IS NULL OR     estado = @ESTADO)       
             AND    ( @Documento IS NULL OR     upper(documento) LIKE '%'+upper(@Documento)+'%')       
        END       
        ELSE IF(@ACCION = 'CONTARLISTAR')    
        BEGIN    
   DECLARE @CONTAR INT         
   SET @CONTAR =  (         
   SELECT Count(*)         
   FROM   vw_ss_ge_especialidadmedico         
   WHERE  ( @Persona IS NULL OR PERSONA = @Persona )    
   )    
  END     
  ELSE IF( @ACCION = 'LISTARPORID' )       
        BEGIN      
            SELECT personamast.persona,personamast.origen,personamast.apellidopaterno,personamast.apellidomaterno,       
                   personamast.nombres,personamast.nombrecompleto,personamast.busqueda,personamast.grupoempresarial,personamast.tipodocumento,       
                   personamast.documento,personamast.codigobarras,personamast.escliente,personamast.esproveedor,personamast.esempleado,       
                   personamast.esotro,personamast.tipopersona,personamast.fechanacimiento,personamast.ciudadnacimiento,personamast.sexo,       
                   personamast.nacionalidad,personamast.estadocivil,personamast.nivelinstruccion, personamast.direccion,personamast.codigopostal,       
                   personamast.provincia, personamast.departamento, personamast.telefono, personamast.fax, personamast.documentofiscal,       
                   personamast.documentoidentidad, personamast.carnetextranjeria,personamast.documentomilitarfa, personamast.tipobrevete, personamast.brevete,       
                   personamast.pasaporte,personamast.nombreemergencia,personamast.direccionemergencia,personamast.telefonoemergencia, personamast.bancomonedalocal,       
                   personamast.tipocuentalocal, personamast.cuentamonedalocal,  personamast.bancomonedaextranjera, personamast.tipocuentaextranjera, personamast.cuentamonedaextranjera,       
                   personamast.personaant,       
                 personamast.correoelectronico,       
                   personamast.clasepersonacodigo,       
                   personamast.personaclasificacion,       
                   personamast.enfermedadgraveflag,       
                   personamast.ingresofecharegistro,       
                   personamast.ingresoaplicacioncodigo,       
                   personamast.ingresousuario,       
                   personamast.pymeflag,       
                   personamast.estado,       
                   personamast.ultimousuario,       
                   personamast.ultimafechamodif,       
                   personamast.tipopersonausuario,       
                   personamast.direccionreferencia,       
                   personamast.celular,       
                   personamast.parentescoemergencia,       
                   personamast.celularemergencia,       
                   personamast.lugarnacimiento,       
                   personamast.suspensionfonaviflag,       
                   personamast.flagrepetido,       
                   personamast.coddiscamec,       
                   personamast.fecinidiscamec,       
                   personamast.fecfindiscamec,       
                   personamast.codlicarma,       
                   personamast.marcaarma,       
                   personamast.seriearma,       
                   personamast.inicioarma,       
                   personamast.vencimientoarma,       
                   personamast.segurodiscamec,       
                   personamast.correlativosctr,       
                   personamast.cuentamonedaextranjera_tmp,       
                   personamast.cuentamonedalocal_tmp,       
                   personamast.flagactualizacion,       
                   personamast.tarjetadecredito,       
                   personamast.pais,       
                   personamast.espaciente,       
                   personamast.esempresa,       
                   personamast.persona_old,       
                   personamast.personanew,       
                   personamast.cmp,       
                   personamast.sunatnacionalidad,       
                   personamast.sunatvia,       
                   personamast.sunatzona,       
                   personamast.sunatubigeo,       
                   personamast.sunatdomiciliado,       
                   personamast.indicadorautogenerado,       
                   personamast.rutafirma,       
                   personamast.tipodocumentoidentidad,       
                   personamast.idpersonaunificado,       
                   personamast.idpersona_ok,       
                   personamast.edad,       
                   personamast.rangoetario,       
                   personamast.tipomedico,       
                   personamast.correcion,       
                   personamast.idempresaanteriorunificacion,       
                   personamast.brevete_fecvcto,       
                   personamast.carnetextranjeria_fecvcto,       
                   personamast.estado_bk,       
                   personamast.estado_bks,       
                   personamast.indicadorvinculada,       
                   personamast.paisemisor,       
                   personamast.codigoldn,       
                   personamast.sunatconvenio,       
                   personamast.indicadorregistromanual,       
                   personamast.indicadorfallecido,       
                   personamast.indicadorsincorreo,       
                   personamast.accion       
            FROM   dbo.personamast       
             where ( persona = @Persona)                                              
        END    
ELSE
IF(@ACCION = 'LISTARGRUPOFAMILIAR') 
BEGIN 
  SELECT CONVERT(integer,RowNumber) AS persona, 
         NULL AS origen, 
         NULL AS apellidopaterno, 
         NULL AS apellidomaterno, 
         NULL AS nombres, 
         nombre AS nombrecompleto, 
         NULL AS busqueda, 
         NULL AS grupoempresarial, 
         NULL AS tipodocumento, 
         NULL AS documento, 
         NULL AS codigobarras, 
         NULL AS EsCliente, 
         NULL AS EsProveedor, 
         NULL AS EsEmpleado, 
         NULL AS EsOtro, 
         NULL AS tipopersona, 
         NULL AS fechanacimiento, 
         NULL AS ciudadnacimiento, 
         NULL AS sexo, 
         NULL AS nacionalidad, 
         NULL AS estadocivil, 
         NULL AS nivelinstruccion, 
         NULL AS direccion, 
         NULL AS codigopostal, 
         NULL AS provincia, 
         NULL AS departamento, 
         NULL AS telefono, 
         NULL AS fax, 
         NULL AS documentofiscal, 
         NULL AS documentoidentidad, 
         NULL AS carnetextranjeria, 
         NULL AS documentomilitarfa, 
         NULL AS tipobrevete, 
         NULL AS brevete, 
         NULL AS pasaporte, 
         DescTip AS nombreemergencia, 
         NULL AS direccionemergencia, 
         NULL AS telefonoemergencia, 
         NULL AS bancomonedalocal, 
         NULL AS tipocuentalocal, 
         NULL AS cuentamonedalocal, 
         NULL AS bancomonedaextranjera, 
         NULL AS tipocuentaextranjera, 
         NULL AS cuentamonedaextranjera, 
         NULL AS personaant, 
         NULL AS correoelectronico, 
         NULL AS clasepersonacodigo, 
         NULL AS personaclasificacion, 
         NULL AS enfermedadgraveflag, 
         NULL AS ingresofecharegistro, 
         NULL AS ingresoaplicacioncodigo, 
         NULL AS ingresousuario, 
         NULL AS pymeflag, 
         convert(varchar,EstHCE) AS estado, 
         UsuMHCE AS ultimousuario, 
         FecMHCE AS ultimafechamodif, 
         NULL AS tipopersonausuario, 
         NULL AS direccionreferencia, 
         NULL AS celular, 
         NULL AS parentescoemergencia, 
         NULL AS celularemergencia, 
         NULL AS lugarnacimiento, 
         NULL AS suspensionfonaviflag, 
         NULL AS flagrepetido, 
         NULL AS coddiscamec, 
         NULL AS fecinidiscamec, 
         NULL AS fecfindiscamec, 
         NULL AS codlicarma, 
         NULL AS marcaarma, 
         NULL AS seriearma, 
         NULL AS inicioarma, 
         NULL AS vencimientoarma, 
         NULL AS segurodiscamec, 
         NULL AS correlativosctr, 
         NULL AS cuentamonedaextranjera_tmp, 
         NULL AS cuentamonedalocal_tmp, 
         NULL AS flagactualizacion, 
         NULL AS tarjetadecredito, 
         NULL AS pais, 
         NULL AS espaciente, 
         NULL AS esempresa, 
         NULL AS persona_old, 
         IdHCE AS personanew, 
         NULL AS cmp, 
         NULL AS sunatnacionalidad, 
         NULL AS sunatvia, 
         NULL AS sunatzona, 
         NULL AS sunatubigeo, 
         NULL AS sunatdomiciliado, 
         IdPacHCE AS indicadorautogenerado, 
         NULL AS rutafirma, 
         NULL AS tipodocumentoidentidad, 
         AppEXT AS idpersonaunificado, 
         NULL AS idpersona_ok, 
         NULL AS edad, 
         NULL AS rangoetario, 
         NULL AS tipomedico, 
         NULL AS correcion, 
         NULL AS idempresaanteriorunificacion, 
         NULL AS brevete_fecvcto, 
         NULL AS carnetextranjeria_fecvcto, 
         NULL AS estado_bk, 
         NULL AS estado_bks, 
         NULL AS indicadorvinculada, 
         NULL AS paisemisor, 
         NULL AS codigoldn, 
         NULL AS sunatconvenio, 
         NULL AS indicadorregistromanual, 
         NULL AS indicadorfallecido, 
         NULL AS indicadorsincorreo, 
         AccHCE AS accion 
  FROM   ( 
                   SELECT    personamast.*, 
                             HOMOLOGACION.idpaciente                                           AS IdHCE,
                             HOMOLOGACION.idpacientefamiliar                                   AS IdPacHCE,
                             HOMOLOGACION.tipofamiliar                                         AS AppEXT,
                             HOMOLOGACION.estado                                               AS EstHCE,
                             HOMOLOGACION.usuariocreacion                                      AS UsuCHCE,
                             HOMOLOGACION.fechacreacion                                        AS FecCHCE,
                             HOMOLOGACION.usuariomodificacion                                  AS UsuMHCE,
                             HOMOLOGACION.fechamodificacion                                    AS FecMHCE,
                             HOMOLOGACION.accion                                               AS AccHCE,
                             @CONTADOR                                                         AS Contador,
                             (SELECT GE_Varios.Descripcion FROM GE_Varios WHERE GE_Varios.CodigoTabla='TIPOPARENTESCO' AND GE_Varios.Secuencial= tipofamiliar AND GE_Varios.Estado= 2) AS DescTip,
                             (select nombrecompleto from PERSONAMAST where PERSONAMAST.Persona = idpacientefamiliar) as nombre,
                             Row_number() OVER (ORDER BY HOMOLOGACION.idpacientefamiliar ASC ) AS RowNumber
                   FROM      ss_hc_grupofamiliar HOMOLOGACION 
                   LEFT JOIN personamast 
                   ON        ( personamast.persona = HOMOLOGACION.idpaciente) 
                   WHERE     ( @Persona IS NULL OR ( HOMOLOGACION.idpaciente = @Persona) OR  @Persona =0)) AS LISTADO 
END	  
	ELSE IF(@ACCION = 'LISTARVALIDAR')  
	BEGIN        
	SELECT * FROM   personamast  
	WHERE  (  @Persona is null OR @Persona =0 OR PERSONA = @Persona )      
	and (  @DocumentoIdentidad is null OR @DocumentoIdentidad ='' OR DocumentoIdentidad = @DocumentoIdentidad )         
	END          
  END 
GO
/****** Object:  StoredProcedure [dbo].[SP_HC_Triaje_Ant_Alergia_FE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [SP_HC_Triaje_Ant_Alergia_FE]  
 @UnidadReplicacion char(4),  
 @IdPaciente int,  
 @EpisodioTriaje int,  
 @TieneHistoria char(1),
 @TieneAlimento	char(1),
 @TieneAmbiental char(1),
 @TieneContacto	char(1),
 @MedicamentoRegular char(1),
 @TransfusionSanguinea char(1),
 @ProblemaTransfusion char(1),
 @Comentarios text,
 @IdFormaInicio int,  
 @IdCursoEnfermedad int,   
 @Estado int,  
 @UsuarioCreacion varchar(25),  
 @FechaCreacion datetime,  
 @UsuarioModificacion varchar(25),  
 @FechaModificacion datetime,   
 @IdMedicamento VARCHAR(25), 
 @Linea char(6), 
 @Familia char(6), 
 @SubFamilia char(6),
 @IdTipoAlergia int,
 @ACCION varchar(50),  
 @DesdeCuandoDet varchar(75),
 @EstudioAlegistaDet int,
 @ObservacionesDet VARCHAR(50),
 @Dosis int,
 @Frecuencia varchar(75),
 @Via char(1),
 @TipoRegistroDet char(2),
 @DescripcionManualDet varchar(50)
   
AS  
BEGIN  
 SET NOCOUNT ON;  
  
  declare 
 @SecuenciaID as integer  
 
  IF @ACCION ='UPDATE'  -- Actualizar CABECERA
  BEGIN  
	   update SS_HC_Triaje_Ant_Alergia_FE set   
   		 IdMedicamento=@IdMedicamento,
		 TieneHistoria=@TieneHistoria, 
		 TieneAlimento =@TieneAlimento,
		 TieneAmbiental=@TieneAmbiental,
		 TieneContacto=@TieneContacto,
		 MedicamentoRegular=@MedicamentoRegular,
		 TransfusionSanguinea=@TransfusionSanguinea,
		 ProblemaTransfusion=@ProblemaTransfusion,
		 Comentarios=@Comentarios,
		 IdFormaInicio=@IdFormaInicio, 
		 IdCursoEnfermedad=@IdCursoEnfermedad,        
		 UsuarioCreacion =@UsuarioCreacion,
		 UsuarioModificacion=@UsuarioModificacion,   
		 FechaModificacion=@FechaModificacion,
		 FechaCreacion=@FechaCreacion,
		 Accion = 'UPDATE',
		 Version ='CCEPF630'
	   where      
		 EpisodioTriaje =@EpisodioTriaje    
	   and  IdPaciente =@IdPaciente         

		   select 1;
 
  END  

  IF @ACCION ='NUEVO'  -- Insertar Cabecera
  BEGIN  
		insert into SS_HC_Triaje_Ant_Alergia_FE(UnidadReplicacion,   
		IdPaciente, EpisodioTriaje,   
		TieneHistoria,TieneAlimento,TieneAmbiental,TieneContacto,MedicamentoRegular,
		TransfusionSanguinea,ProblemaTransfusion,Comentarios,
	   UsuarioCreacion, FechaCreacion, UsuarioModificacion,  FechaModificacion, 
		Accion, Version)  
	   values (@UnidadReplicacion,   
		@IdPaciente, @EpisodioTriaje,   
		@TieneHistoria,@TieneAlimento,@TieneAmbiental,@TieneContacto,@MedicamentoRegular,
		@TransfusionSanguinea,@ProblemaTransfusion,@Comentarios,
		@UsuarioCreacion,      GETDATE(), @UsuarioModificacion, GETDATE(), 
		'NUEVO','CCEPF630')  
     
	   select @EpisodioTriaje;  
     
  END  

 IF @ACCION ='UPDATEDETALLE'  --Actualizar DETALLE
  BEGIN          

   	UPDATE SS_HC_Triaje_Ant_AlergiaDetalle_FE
	SET 
		IdTipoAlergia=@IdTipoAlergia,
		CodigoComponente =@IdMedicamento,
		Linea=@Linea, Familia=@Familia, SubFamilia=@SubFamilia,												
		DesdeCuando=@DesdeCuandoDet , EstudioAlegista=@EstudioAlegistaDet , 
		Observaciones=RTRIM(@ObservacionesDet),		
		Dosis=@Dosis,
		Frecuencia=@Frecuencia,
		Via=@Via,
		UsuarioModificacion = @UsuarioModificacion,						
		FechaModificacion = getdate(),
		DescripcionManual = @DescripcionManualDet,
		Accion = 'UPDATE',
	    Version ='CCEPF630'
	Where	
	UnidadReplicacion = @UnidadReplicacion
	
	and IdPaciente =@IdPaciente 
	and		EpisodioTriaje = @EpisodioTriaje
	and Secuencia = @IdFormaInicio
				
		select 1;		

  END  
  
  IF @ACCION ='DETALLE'  --Insertar DETALLE
  BEGIN  

	   select @SecuenciaID = ISNULL(max(Secuencia),0)+1   
		 from SS_HC_Triaje_Ant_AlergiaDetalle_FE             
  
	   insert into SS_HC_Triaje_Ant_AlergiaDetalle_FE( UnidadReplicacion, IdPaciente,   
		EpisodioTriaje, Secuencia, IdCIAP2, CodigoComponente, Linea, Familia, SubFamilia,
		UsuarioCreacion, FechaCreacion, UsuarioModificacion,  FechaModificacion, IdTipoAlergia,
		DesdeCuando , EstudioAlegista , Observaciones,Dosis,Frecuencia,Via, TipoRegistro, DescripcionManual, Accion, Version
		)  
	   values (@UnidadReplicacion, @IdPaciente,   
		@EpisodioTriaje, @SecuenciaID, @IdCursoEnfermedad,  @IdMedicamento, @Linea, @Familia, @SubFamilia,
		@UsuarioCreacion, GETDATE(), @UsuarioModificacion, GETDATE(), @IdTipoAlergia,
		@DesdeCuandoDet , @EstudioAlegistaDet , RTRIM(@ObservacionesDet),
		@Dosis,@Frecuencia,@Via, @TipoRegistroDet, @DescripcionManualDet, 'NUEVO', 'CCEPF630'
		)  
      
	  select 1;  
      
  END   
  
  IF @ACCION ='DELETEDETALLE'  --Borrar DETALLE
  BEGIN  
    
	DELETE SS_HC_Triaje_Ant_AlergiaDetalle_FE   
   where 
	   IdPaciente =@IdPaciente  
	   AND  EpisodioTriaje = @EpisodioTriaje  	
	   AND  Secuencia = @IdFormaInicio   
    select 1;
  END  
   
END    
   
GO
/****** Object:  StoredProcedure [dbo].[SP_HC_Triaje_Ant_Alergia_FE_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE  [dbo].[SP_HC_Triaje_Ant_Alergia_FE_Listar]  
 @UnidadReplicacion char(4),  
 @IdPaciente int,  
 @EpisodioTriaje int, 
  @IdFormaInicio int,  
 @IdCursoEnfermedad int, 
 @Estado int,  
 @UsuarioCreacion varchar(25),  
 @FechaCreacion datetime,  
 @UsuarioModificacion varchar(25),  
 @FechaModificacion datetime, 
 @ACCION varchar(25),
 @version varchar(25),
 @TieneHistoria	char(1),
 @TieneAlimento	char(1),
 @TieneAmbiental char(1),
 @TieneContacto	char(1),
 @MedicamentoRegular char(1),
 @TransfusionSanguinea char(1),
 @ProblemaTransfusion char(1),
 @Comentarios text,
 @IdMedicamento	varchar(25),
 @IdTipoAlergiaDet int,
 @LineaDet char(6),
 @FamiliaDet char(6),
 @SubFamiliaDet char(6),
 @DesdeCuandoDet varchar(75),
 @ObservacionesDet char(50),
 @EstudioAlegistaDet int,
 @TipoRegistroDet char(2),
 @DescripcionManualDet VARCHAR(50)

AS  
BEGIN  
 SET NOCOUNT ON;  

 IF @ACCION ='LISTAR'  
  BEGIN  
    Select * From   dbo.SS_HC_Triaje_Ant_Alergia_FE   
    Where IdPaciente = @IdPaciente   
    and EpisodioTriaje = @EpisodioTriaje     
    and UnidadReplicacion = @UnidadReplicacion  
  END  
 
END

GO
/****** Object:  StoredProcedure [dbo].[SP_HC_TriajeEmergencia_FE_Insert]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_HC_TriajeEmergencia_FE_Insert]
   @UnidadReplicacion		char(4) ,	
	@IdPaciente				int ,
	@EpisodioTriaje		int ,
	@IdFuncionVital int,
    @Fecha datetime,
	@Hora datetime,
	@PresionArterialMSD1 int,
	@PresionArterialMSD2 int,
	@PresionArterialMSI int,
	@PresionArterialMS2 int,
	@FrecuenciaCardiaca decimal (5,2),
	@FrecuenciaRespiratoria int,
	@Temperatura decimal (4,1),
	@SaturacionOxigeno int,
	@FrecuenciaCardFetal_Flag int,
	@FrecuenciaCard_FetalAdd int,
	@Peso decimal (9,2),
	@TiempoEnfermedad int,
	@TiempoEnfermedadUnidad char (1),
	@Motivodeingreso varchar (100),
	@Sintomas varchar (305),
	@Prioridad int,
	@Especialidad char (2),
	@Estado int,
	@UsuarioCreacion varchar (25),
	@FechaCreacion datetime ,
	@UsuarioModificacion varchar (25),
	@FechaModificacion datetime,
	@Accion varchar (25),
	@Version varchar (25)
as
	begin

	IF @ACCION ='NUEVO'  
	BEGIN  

			INSERT INTO SS_HC_TriajeEmergencia_FE values(@UnidadReplicacion,
			@IdPaciente,@EpisodioTriaje,@IdFuncionVital, @Fecha,@Hora,@PresionArterialMSD1,@PresionArterialMSD2,
			@PresionArterialMSI,@PresionArterialMS2,@FrecuenciaCardiaca,@FrecuenciaRespiratoria,
			@Temperatura,@SaturacionOxigeno,@FrecuenciaCardFetal_Flag,@FrecuenciaCard_FetalAdd,@Peso,
			@TiempoEnfermedad,@TiempoEnfermedadUnidad,@Motivodeingreso,@Sintomas,@Prioridad,@Especialidad
			,@Estado,@UsuarioCreacion,@FechaCreacion,@UsuarioModificacion,@FechaModificacion,@Accion,@Version)	
	
			update SS_HC_EpisodioTriaje set IdEspecialidad=CAST(@Especialidad AS INT)
			where IdEpisodioTriaje = @EpisodioTriaje and IdPaciente = @IdPaciente; 	


	end

	select @IdPaciente;

	IF @ACCION ='UPDATE'  
	BEGIN  

			UPDATE  SS_HC_TriajeEmergencia_FE set Fecha=@Fecha,Hora=@Hora,PresionArterialMSD1=@PresionArterialMSD1,PresionArterialMSD2=@PresionArterialMSD2,
			PresionArterialMSI=@PresionArterialMSI,PresionArterialMS2=@PresionArterialMS2,FrecuenciaCardiaca=@FrecuenciaCardiaca,
			FrecuenciaRespiratoria=@FrecuenciaRespiratoria,
			Temperatura=@Temperatura,SaturacionOxigeno=@SaturacionOxigeno,FrecuenciaCardFetal_Flag=@FrecuenciaCardFetal_Flag,FrecuenciaCard_FetalAdd=@FrecuenciaCard_FetalAdd,
			Peso=@Peso,TiempoEnfermedad=@TiempoEnfermedad,TiempoEnfermedadUnidad=@TiempoEnfermedadUnidad,Motivodeingreso=@Motivodeingreso,Sintomas=@Sintomas,Prioridad=@Prioridad,Especialidad=@Especialidad
			,Estado=@Estado,UsuarioCreacion=@UsuarioCreacion,FechaCreacion=@FechaCreacion,UsuarioModificacion=@UsuarioModificacion,FechaModificacion=@FechaModificacion,Accion=@Accion,Version=@Version
			Where IdPaciente = @IdPaciente   
			and EpisodioTriaje = @EpisodioTriaje 
			and UnidadReplicacion = @UnidadReplicacion  

			select @IdPaciente;

	end

	IF @ACCION ='DELETE'  
	BEGIN 
	
		DELETE  FROM SS_HC_TriajeEmergencia_FE Where IdPaciente = @IdPaciente   
		and EpisodioTriaje =@EpisodioTriaje  
		and UnidadReplicacion =@UnidadReplicacion  

		select @IdPaciente;
	end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_HC_TriajeEmergencia_FE_Listar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_HC_TriajeEmergencia_FE_Listar]
	@UnidadReplicacion		char(4) ,	
	@IdPaciente				int ,
	@EpisodioTriaje		int ,
	@IdFuncionVital int,
	@Fecha datetime,
	@Hora datetime,
	@PresionArterialMSD1 int ,
	@PresionArterialMSD2 int,
	@PresionArterialMSI int,
	@PresionArterialMS2 int,
	@FrecuenciaCardiaca decimal (5,2),
	@FrecuenciaRespiratoria int,
	@Temperatura decimal (4,1),
	@SaturacionOxigeno int,
	@FrecuenciaCard_FetalFlag int,
	@FrecuenciaCard_FetalAdd int,
	@Peso decimal (9,2) ,
	@TiempoEnfermedad int,
	@TiempoEnfermedadUnidad char(1),
	@Motivodeingreso varchar (100),
	@Sintomas varchar (100),
	@Prioridad int ,
	@Especialidad char (2),
	@Estado int,
	@UsuarioCreacion varchar (25),
	@FechaCreacion datetime,
	@UsuarioModificacion varchar (25),
	@FechaModificacion datetime,
	@Accion varchar (25),
	@Version varchar (25)
	
AS
BEGIN
  
 IF @ACCION ='LISTARTRIAJE'  
  BEGIN  
    Select * From   dbo.SS_HC_TriajeEmergencia_FE   
    Where IdPaciente = @IdPaciente   
    and EpisodioTriaje = @EpisodioTriaje  
   
    and UnidadReplicacion = @UnidadReplicacion  
  END 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_HC_UnidadesMast]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_HC_UnidadesMast] 
@UnidadCodigo             VARCHAR(3), 
@DescripcionCorta         VARCHAR(20), 
@DescripcionExtranjera    VARCHAR(40), 
@UnidadTipo               CHAR(1), 
@NumeroDecimales          INT, 

@Estado                   CHAR(1), 
@UltimaFechaModif         DATETIME, 
@UltimoUsuario            CHAR(25), 
@IdUnidadMedida           INT, 
@IndicadorMedidaBase      INT, 

@FactorConversion         DECIMAL(16, 6), 
@UsuarioCreacion          VARCHAR(25), 
@FechaCreacion            DATETIME, 
@indAfectocalculocantidad INT, 
@CodigoFiscal             CHAR(2), 

@ACCION                   VARCHAR(25) 
AS 
  BEGIN 
      SET nocount ON; 

      IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   unidadesmast 
                             WHERE  ( @UnidadCodigo IS NULL OR Upper(rtrim(unidadcodigo)) LIKE '%' + Upper(rtrim(@UnidadCodigo)) + '%' ) 
                                    AND ( @DescripcionCorta IS NULL OR Upper(rtrim(descripcioncorta)) LIKE '%' + Upper(rtrim(@DescripcionCorta)) + '%' ) 
                                    AND ( @UnidadTipo IS NULL OR unidadtipo = @UnidadTipo )) 

            SELECT @CONTADOR; 
        END 
  END 
/*    
EXEC SP_HC_UnidadesMast    
'bl',NULL, NULL, NULL, NULL,    
NULL, NULL, NULL, 0, NULL,    
NULL, NULL, NULL, NULL, NULL,  
'LISTARPAG'
*/ 
GO
/****** Object:  StoredProcedure [dbo].[SP_HC_UnidadesMastListar]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_HC_UnidadesMastListar] 
@UnidadCodigo             VARCHAR(3), 
@DescripcionCorta         VARCHAR(20), 
@DescripcionExtranjera    VARCHAR(40), 
@UnidadTipo               CHAR(1), 
@NumeroDecimales          INT, 

@Estado                   CHAR(1), 
@UltimaFechaModif         DATETIME, 
@UltimoUsuario            CHAR(25), 
@IdUnidadMedida           INT, 
@IndicadorMedidaBase      INT, 

@FactorConversion         DECIMAL(16, 6), 
@UsuarioCreacion          VARCHAR(25), 
@FechaCreacion            DATETIME, 
@indAfectocalculocantidad INT, 
@CodigoFiscal             CHAR(2), 

@ACCION                   VARCHAR(25), 
@INICIO                   INT = NULL, 
@NUMEROFILAS              INT = NULL 
AS 
  BEGIN 
      SET nocount ON; 

      IF( @ACCION = 'LISTARPAG' ) 
        BEGIN 
            DECLARE @CONTADOR INT 

            SET @CONTADOR = (SELECT Count(*) 
                             FROM   unidadesmast 
                             WHERE  ( @UnidadCodigo IS NULL OR Upper(rtrim(unidadcodigo)) LIKE '%' + Upper(rtrim(@UnidadCodigo)) + '%' ) 
                                    AND ( @DescripcionCorta IS NULL OR Upper(rtrim(descripcioncorta)) LIKE '%' + Upper(rtrim(@DescripcionCorta)) + '%' ) 
                                    AND ( @UnidadTipo IS NULL OR unidadtipo = @UnidadTipo )) 

            SELECT unidadcodigo, 
                   descripcioncorta, 
                   descripcionextranjera, 
                   unidadtipo, 
                   numerodecimales, 
                   estado, 
                   ultimafechamodif, 
                   ultimousuario, 
                   idunidadmedida, 
                   indicadormedidabase, 
                   factorconversion, 
                   usuariocreacion, 
                   fechacreacion, 
                   indafectocalculocantidad, 
                   codigofiscal,
                   ACCION 
            FROM   (SELECT unidadcodigo, 
                           descripcioncorta, 
                           descripcionextranjera, 
                           unidadtipo, 
                           numerodecimales, 
                           estado, 
                           ultimafechamodif, 
                           ultimousuario, 
                           idunidadmedida, 
                           indicadormedidabase, 
                           factorconversion, 
                           usuariocreacion, 
                           fechacreacion, 
                           indafectocalculocantidad, 
                           codigofiscal, 
                           ACCION,
                           @CONTADOR                      AS contador, 
                           Row_number() OVER(ORDER BY unidadcodigo ASC) AS rownumber 
                    FROM   unidadesmast 
                    WHERE  ( @UnidadCodigo IS NULL OR Upper(rtrim(unidadcodigo)) LIKE '%' + Upper(rtrim(@UnidadCodigo)) + '%' ) 
                            AND ( @DescripcionCorta IS NULL OR Upper(descripcioncorta) LIKE '%' + Upper(@DescripcionCorta) + '%' ) 
                            AND ( @UnidadTipo IS NULL OR unidadtipo = @UnidadTipo ))AS UNIDADES 
            WHERE  ( @INICIO IS NULL AND @NUMEROFILAS IS NULL ) OR ( rownumber BETWEEN @INICIO AND @NUMEROFILAS ) 
        END 
  END 
/*  
EXEC SP_HC_UnidadesMastListar  
'BD',NULL, NULL, NULL, NULL,  
NULL, NULL, NULL, 0, NULL,  
NULL, NULL, NULL, NULL, NULL,   
'LISTARPAG', 0,10  
*/ 
GO
/****** Object:  StoredProcedure [dbo].[SP_HC_UnificacionPacientes_FechaRegistroMaster_HCE1]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_HC_UnificacionPacientes_FechaRegistroMaster_HCE1]
	@IdPacienteNew INT
AS
BEGIN
	SET NOCOUNT ON

	SELECT Indice = 0,IdPaciente,EpisodioClinico,FechaRegistro 
	INTO #SS_HC_EpisodioClinico
	FROM SS_HC_EpisodioClinico WHERE IdPaciente = @IdPacienteNew ORDER BY FechaRegistro

	UPDATE #SS_HC_EpisodioClinico
	SET #SS_HC_EpisodioClinico.Indice = OA.sequence
	FROM #SS_HC_EpisodioClinico
	INNER JOIN
	(
	   SELECT ROW_NUMBER() OVER ( ORDER BY #SS_HC_EpisodioClinico.FechaRegistro ) AS sequence, #SS_HC_EpisodioClinico.EpisodioClinico
	   FROM #SS_HC_EpisodioClinico
	) OA ON OA.EpisodioClinico = #SS_HC_EpisodioClinico.EpisodioClinico

	DECLARE @LoopCounter INT, @LoopCounterMax INT, @MaxEmployeeId INT, @EpisodioClinico INT, @IdPaciente INT, @as_mensaje VARCHAR(255)

	SELECT	@MaxEmployeeId = Max(#SS_HC_EpisodioClinico.Indice),
			@LoopCounter = 0
	FROM	#SS_HC_EpisodioClinico

	SET @LoopCounterMax = @MaxEmployeeId

	WHILE(@LoopCounter IS NOT NULL
		  AND @LoopCounter < @MaxEmployeeId)
	BEGIN
		SET @LoopCounter = @LoopCounter  + 1
		SET @LoopCounterMax = @LoopCounterMax + 1

		SELECT	@EpisodioClinico = #SS_HC_EpisodioClinico.EpisodioClinico,
				@IdPaciente = #SS_HC_EpisodioClinico.IdPaciente
		FROM	#SS_HC_EpisodioClinico 
		WHERE #SS_HC_EpisodioClinico.Indice = @LoopCounter
		
		UPDATE SS_HC_EpisodioClinico SET EpisodioClinico = @LoopCounterMax
		from SS_HC_EpisodioClinico where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_EpisodioAtencion SET EpisodioClinico = @LoopCounterMax
		from SS_HC_EpisodioAtencion where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_EpisodioAtencionMaster SET EpisodioClinico = @LoopCounterMax
		from SS_HC_EpisodioAtencionMaster where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_EnfermedadActual_FE SET EpisodioClinico = @LoopCounterMax
		from SS_HC_EnfermedadActual_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_ExamenClinico_FE SET EpisodioClinico = @LoopCounterMax
		from SS_HC_ExamenClinico_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_Diagnostico_FE SET EpisodioClinico = @LoopCounterMax
		from SS_HC_Diagnostico_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_Medicamento_FE SET EpisodioClinico = @LoopCounterMax
		from SS_HC_Medicamento_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_FuncionesVitales_FE SET EpisodioClinico = @LoopCounterMax
		from SS_HC_FuncionesVitales_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_InformeAlta_FE SET EpisodioClinico = @LoopCounterMax
		FROM SS_HC_InformeAlta_FE WHERE IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_Oftalmologico_FE SET EpisodioClinico = @LoopCounterMax
		from SS_HC_Oftalmologico_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_AntecedentesPersonalesFisiologicos_FE SET EpisodioClinico = @LoopCounterMax
		from SS_HC_AntecedentesPersonalesFisiologicos_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_AntecedentesPersonalesIAdul_FE SET EpisodioClinico = @LoopCounterMax
		from SS_HC_AntecedentesPersonalesIAdul_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_AntecedentesPersonalesIAdulDetalle_FE SET EpisodioClinico = @LoopCounterMax
		from SS_HC_AntecedentesPersonalesIAdulDetalle_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico
 
		UPDATE SS_HC_Anam_AP_PatologicosGenerales_FE SET EpisodioClinico = @LoopCounterMax
		from SS_HC_Anam_AP_PatologicosGenerales_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE SET EpisodioClinico = @LoopCounterMax
		from SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico
      
		UPDATE SS_HC_AlergiaDetalle_FE SET EpisodioClinico = @LoopCounterMax
		from SS_HC_AlergiaDetalle_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_Anamnesis_AFAM_FE SET EpisodioClinico = @LoopCounterMax
		from SS_HC_Anamnesis_AFAM_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_AntecedentesPersonalesIN_FE SET EpisodioClinico = @LoopCounterMax
		from SS_HC_AntecedentesPersonalesIN_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_AntecedentesPersonalesINDetalle_FE SET EpisodioClinico = @LoopCounterMax
		from SS_HC_AntecedentesPersonalesINDetalle_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_ANT_FISIOLOGICO_PEDIATRICO_FE SET EpisodioClinico = @LoopCounterMax
		from SS_HC_ANT_FISIOLOGICO_PEDIATRICO_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_ValoracionAM_FE SET EpisodioClinico = @LoopCounterMax
		from SS_HC_ValoracionAM_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_ValoracionFuncionalAM_FE SET EpisodioClinico = @LoopCounterMax
		from SS_HC_ValoracionFuncionalAM_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_ValoracionMentalAM_FE SET EpisodioClinico = @LoopCounterMax
		from SS_HC_ValoracionMentalAM_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_ValoracionSocioFamAM_FE SET EpisodioClinico = @LoopCounterMax
		from SS_HC_ValoracionSocioFamAM_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_ProximaAtencion_FE SET EpisodioClinico = @LoopCounterMax
		from SS_HC_ProximaAtencion_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_ApoyoDiagnosticoFile_FE SET EpisodioClinico = @LoopCounterMax
		from SS_HC_ApoyoDiagnosticoFile_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico
     
		UPDATE SS_HC_DescansoMedico_FE SET EpisodioClinico = @LoopCounterMax
		from SS_HC_DescansoMedico_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		SELECT *
		INTO #SS_HC_ApoyoDiagnosticoDet_FE
		FROM SS_HC_ApoyoDiagnosticoDet_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		SELECT *
		INTO #SS_HC_ApoyoDiagnostico_FE
		FROM SS_HC_ApoyoDiagnostico_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE #SS_HC_ApoyoDiagnosticoDet_FE SET EpisodioClinico = @LoopCounterMax

		UPDATE #SS_HC_ApoyoDiagnostico_FE SET EpisodioClinico = @LoopCounterMax

		DELETE FROM SS_HC_ApoyoDiagnosticoDet_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		DELETE FROM SS_HC_ApoyoDiagnostico_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		INSERT INTO SS_HC_ApoyoDiagnostico_FE
		SELECT * FROM #SS_HC_ApoyoDiagnostico_FE

		INSERT INTO SS_HC_ApoyoDiagnosticoDet_FE
		SELECT * FROM #SS_HC_ApoyoDiagnosticoDet_FE

		DROP TABLE #SS_HC_ApoyoDiagnosticoDet_FE

		DROP TABLE #SS_HC_ApoyoDiagnostico_FE

		SELECT *
		INTO #SS_HC_ExamenSolicitadoDet_FE
		FROM SS_HC_ExamenSolicitadoDet_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		SELECT *
		INTO #SS_HC_ExamenSolicitadoFE
		FROM SS_HC_ExamenSolicitadoFE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE #SS_HC_ExamenSolicitadoDet_FE SET EpisodioClinico = @LoopCounterMax

		UPDATE #SS_HC_ExamenSolicitadoFE SET EpisodioClinico = @LoopCounterMax

		DELETE FROM SS_HC_ExamenSolicitadoDet_FE WHERE IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		DELETE FROM SS_HC_ExamenSolicitadoFE WHERE IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico
		
		INSERT INTO SS_HC_ExamenSolicitadoFE
		SELECT * FROM #SS_HC_ExamenSolicitadoFE

		INSERT INTO SS_HC_ExamenSolicitadoDet_FE
		SELECT * FROM #SS_HC_ExamenSolicitadoDet_FE

		DROP TABLE #SS_HC_ExamenSolicitadoDet_FE

		DROP TABLE #SS_HC_ExamenSolicitadoFE

	END
END

DROP TABLE #SS_HC_EpisodioClinico 
GO
/****** Object:  StoredProcedure [dbo].[SP_HC_UnificacionPacientes_FechaRegistroMaster_HCE2]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_HC_UnificacionPacientes_FechaRegistroMaster_HCE2]
	@IdPacienteNew INT
AS
BEGIN
	SET NOCOUNT ON

	SELECT SS_HC_EpisodioClinico.*
	INTO #SS_HC_EpisodioClinicos
	FROM SS_HC_EpisodioClinico WHERE IdPaciente = 0

	SELECT Indice = 0,IdPaciente,EpisodioClinico,FechaRegistro 
	INTO #SS_HC_EpisodioClinico
	FROM SS_HC_EpisodioClinico WHERE IdPaciente = @IdPacienteNew ORDER BY FechaRegistro

	UPDATE #SS_HC_EpisodioClinico
	SET #SS_HC_EpisodioClinico.Indice = OA.sequence
	FROM #SS_HC_EpisodioClinico
	INNER JOIN
	(
	   SELECT ROW_NUMBER() OVER ( ORDER BY #SS_HC_EpisodioClinico.FechaRegistro ) AS sequence, #SS_HC_EpisodioClinico.EpisodioClinico
	   FROM #SS_HC_EpisodioClinico
	) OA ON OA.EpisodioClinico = #SS_HC_EpisodioClinico.EpisodioClinico

	SELECT * FROM #SS_HC_EpisodioClinico ORDER BY Indice

	DECLARE @LoopCounter INT, @LoopCounterMax INT, @MaxEmployeeId INT, @EpisodioClinico INT, @IdPaciente INT, @as_mensaje VARCHAR(255)

	SELECT	@MaxEmployeeId = Max(#SS_HC_EpisodioClinico.Indice),
			@LoopCounter = 0
	FROM	#SS_HC_EpisodioClinico

	WHILE(@LoopCounter IS NOT NULL
		  AND @LoopCounter < @MaxEmployeeId)
	BEGIN
		SET @LoopCounter = @LoopCounter  + 1
		SET @LoopCounterMax = @LoopCounterMax + 1

		SELECT	@EpisodioClinico = #SS_HC_EpisodioClinico.EpisodioClinico,
				@IdPaciente = #SS_HC_EpisodioClinico.IdPaciente
		FROM	#SS_HC_EpisodioClinico 
		WHERE #SS_HC_EpisodioClinico.Indice = @LoopCounter
		
		UPDATE SS_HC_EpisodioClinico SET EpisodioClinico = @LoopCounter
		from SS_HC_EpisodioClinico where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_EpisodioAtencion SET EpisodioClinico = @LoopCounter
		from SS_HC_EpisodioAtencion where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_EpisodioAtencionMaster SET EpisodioClinico = @LoopCounter
		from SS_HC_EpisodioAtencionMaster where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_EnfermedadActual_FE SET EpisodioClinico = @LoopCounter
		from SS_HC_EnfermedadActual_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_ExamenClinico_FE SET EpisodioClinico = @LoopCounter
		from SS_HC_ExamenClinico_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_Diagnostico_FE SET EpisodioClinico = @LoopCounter
		from SS_HC_Diagnostico_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_Medicamento_FE SET EpisodioClinico = @LoopCounter
		from SS_HC_Medicamento_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_FuncionesVitales_FE SET EpisodioClinico = @LoopCounter
		from SS_HC_FuncionesVitales_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_InformeAlta_FE SET EpisodioClinico = @LoopCounter
		FROM SS_HC_InformeAlta_FE WHERE IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_Oftalmologico_FE SET EpisodioClinico = @LoopCounter
		from SS_HC_Oftalmologico_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_AntecedentesPersonalesFisiologicos_FE SET EpisodioClinico = @LoopCounter
		from SS_HC_AntecedentesPersonalesFisiologicos_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_AntecedentesPersonalesIAdul_FE SET EpisodioClinico = @LoopCounter
		from SS_HC_AntecedentesPersonalesIAdul_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_AntecedentesPersonalesIAdulDetalle_FE SET EpisodioClinico = @LoopCounter
		from SS_HC_AntecedentesPersonalesIAdulDetalle_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico
 
		UPDATE SS_HC_Anam_AP_PatologicosGenerales_FE SET EpisodioClinico = @LoopCounter
		from SS_HC_Anam_AP_PatologicosGenerales_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE SET EpisodioClinico = @LoopCounter
		from SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico
      
		UPDATE SS_HC_AlergiaDetalle_FE SET EpisodioClinico = @LoopCounter
		from SS_HC_AlergiaDetalle_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_Anamnesis_AFAM_FE SET EpisodioClinico = @LoopCounter
		from SS_HC_Anamnesis_AFAM_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_AntecedentesPersonalesIN_FE SET EpisodioClinico = @LoopCounter
		from SS_HC_AntecedentesPersonalesIN_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_AntecedentesPersonalesINDetalle_FE SET EpisodioClinico = @LoopCounter
		from SS_HC_AntecedentesPersonalesINDetalle_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_ANT_FISIOLOGICO_PEDIATRICO_FE SET EpisodioClinico = @LoopCounter
		from SS_HC_ANT_FISIOLOGICO_PEDIATRICO_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_ValoracionAM_FE SET EpisodioClinico = @LoopCounter
		from SS_HC_ValoracionAM_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_ValoracionFuncionalAM_FE SET EpisodioClinico = @LoopCounter
		from SS_HC_ValoracionFuncionalAM_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_ValoracionMentalAM_FE SET EpisodioClinico = @LoopCounter
		from SS_HC_ValoracionMentalAM_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_ValoracionSocioFamAM_FE SET EpisodioClinico = @LoopCounter
		from SS_HC_ValoracionSocioFamAM_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE SS_HC_ProximaAtencion_FE SET EpisodioClinico = @LoopCounter
		from SS_HC_ProximaAtencion_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		--UPDATE SS_HC_ApoyoDiagnostico_FE SET EpisodioClinico = @LoopCounter
		--from SS_HC_ApoyoDiagnostico_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		--UPDATE SS_HC_ApoyoDiagnosticoDet_FE SET EpisodioClinico = @LoopCounter
		--from SS_HC_ApoyoDiagnosticoDet_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		SELECT *
		INTO #SS_HC_ApoyoDiagnosticoDet_FE
		FROM SS_HC_ApoyoDiagnosticoDet_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		SELECT *
		INTO #SS_HC_ApoyoDiagnostico_FE
		FROM SS_HC_ApoyoDiagnostico_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE #SS_HC_ApoyoDiagnosticoDet_FE SET EpisodioClinico = @LoopCounter

		UPDATE #SS_HC_ApoyoDiagnostico_FE SET EpisodioClinico = @LoopCounter

		DELETE FROM SS_HC_ApoyoDiagnosticoDet_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		DELETE FROM SS_HC_ApoyoDiagnostico_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		INSERT INTO SS_HC_ApoyoDiagnostico_FE
		SELECT * FROM #SS_HC_ApoyoDiagnostico_FE

		INSERT INTO SS_HC_ApoyoDiagnosticoDet_FE
		SELECT * FROM #SS_HC_ApoyoDiagnosticoDet_FE

		DROP TABLE #SS_HC_ApoyoDiagnosticoDet_FE

		DROP TABLE #SS_HC_ApoyoDiagnostico_FE

		UPDATE SS_HC_ApoyoDiagnosticoFile_FE SET EpisodioClinico = @LoopCounter
		from SS_HC_ApoyoDiagnosticoFile_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico
     
		UPDATE SS_HC_DescansoMedico_FE SET EpisodioClinico = @LoopCounter
		from SS_HC_DescansoMedico_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		SELECT *
		INTO #SS_HC_ExamenSolicitadoDet_FE
		FROM SS_HC_ExamenSolicitadoDet_FE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		SELECT *
		INTO #SS_HC_ExamenSolicitadoFE
		FROM SS_HC_ExamenSolicitadoFE where IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		UPDATE #SS_HC_ExamenSolicitadoDet_FE SET EpisodioClinico = @LoopCounter

		UPDATE #SS_HC_ExamenSolicitadoFE SET EpisodioClinico = @LoopCounter

		DELETE FROM SS_HC_ExamenSolicitadoDet_FE WHERE IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico

		DELETE FROM SS_HC_ExamenSolicitadoFE WHERE IdPaciente = @IdPaciente and EpisodioClinico = @EpisodioClinico
		
		INSERT INTO SS_HC_ExamenSolicitadoFE
		SELECT * FROM #SS_HC_ExamenSolicitadoFE

		INSERT INTO SS_HC_ExamenSolicitadoDet_FE
		SELECT * FROM #SS_HC_ExamenSolicitadoDet_FE

		DROP TABLE #SS_HC_ExamenSolicitadoDet_FE

		DROP TABLE #SS_HC_ExamenSolicitadoFE

	END
END

DROP TABLE #SS_HC_EpisodioClinicos
DROP TABLE #SS_HC_EpisodioClinico 
GO
/****** Object:  StoredProcedure [dbo].[SP_HC_UnificacionPacientes_HCE]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [SP_HC_UnificacionPacientes_HCE]
	@IdPacienteNew INT, 
	@IdPacienteAnt INT,
	@UnidadReplicacion CHAR(4)
AS
BEGIN
	SET NOCOUNT ON

	PRINT '@@IdPacienteNew : ' +  CONVERT(NVARCHAR,@IdPacienteNew)
	PRINT '@@IdPacienteAnt : ' +  CONVERT(NVARCHAR,@IdPacienteAnt)

	SELECT SS_HC_EpisodioClinico.EpisodioClinico, SS_HC_EpisodioClinico.IdPaciente, SS_HC_EpisodioClinico.IdOrdenAtencion, SS_HC_EpisodioClinico.UnidadReplicacion
	INTO #SS_HC_EpisodioClinicoNew
	FROM SS_HC_EpisodioClinico WHERE IdPaciente = @IdPacienteNew AND UnidadReplicacion = @UnidadReplicacion

	PRINT '@IdPacienteNew : ' + CONVERT(NVARCHAR,@IdPacienteNew)
	PRINT '@UnidadReplicacion : ' + @UnidadReplicacion

	SELECT SS_HC_EpisodioClinico.EpisodioClinico, SS_HC_EpisodioClinico.IdPaciente, SS_HC_EpisodioClinico.IdOrdenAtencion, SS_HC_EpisodioClinico.UnidadReplicacion
	INTO #SS_HC_EpisodioClinicoAnt
	FROM SS_HC_EpisodioClinico WHERE IdPaciente = @IdPacienteAnt AND UnidadReplicacion = @UnidadReplicacion ORDER BY EpisodioClinico

	PRINT '@@IdPacienteAnt 2 : ' + CONVERT(NVARCHAR,@IdPacienteAnt)
	PRINT '@UnidadReplicacion 2 : ' + @UnidadReplicacion

	DECLARE @LoopCounter INT, @LoopCounterCero INT, @MaxEmployeeId INT, @MaxEmployeeIdAnt INT, @EpisodioClinico INT, @IdOrdenAtencion INT, @as_mensaje VARCHAR(255)

	SELECT	@LoopCounterCero = COUNT(*)
	FROM	#SS_HC_EpisodioClinicoNew

	SELECT	@MaxEmployeeIdAnt = MAX(EpisodioClinico),
			@LoopCounter = 0
	FROM	#SS_HC_EpisodioClinicoAnt

	IF @LoopCounterCero > 0
		BEGIN
			SELECT	@MaxEmployeeId = MAX(EpisodioClinico),
					@LoopCounter = 0
			FROM	#SS_HC_EpisodioClinicoNew
		END
	ELSE
		BEGIN
			SET @MaxEmployeeId = 0
			SET @LoopCounter = -1
		END		

	PRINT '@MaxEmployeeId 1 : ' + CONVERT(NVARCHAR,@MaxEmployeeId)
	PRINT '@MaxEmployeeIdAnt 1 : ' + CONVERT(NVARCHAR,@MaxEmployeeIdAnt)
	PRINT '@LoopCounter 1 : ' + CONVERT(NVARCHAR,@LoopCounter)

	WHILE(@LoopCounter IS NOT NULL
		  AND (CASE WHEN @MaxEmployeeId > @MaxEmployeeIdAnt THEN @MaxEmployeeId ELSE  @MaxEmployeeIdAnt END) > @LoopCounter)
	BEGIN
		PRINT '@LoopCounter 3 : ' +  CONVERT(NVARCHAR,@LoopCounter)
		PRINT '@MaxEmployeeId 3 : ' +  CONVERT(NVARCHAR,@MaxEmployeeId)
		PRINT '@MaxEmployeeIdAnt 3 : ' +  CONVERT(NVARCHAR,@MaxEmployeeIdAnt)

		SET @LoopCounter = @LoopCounter  + 1

		IF	@LoopCounter = 0
			BEGIN 
				SET @LoopCounter = 1
			END

		PRINT '@LoopCounter 4 : ' +  CONVERT(NVARCHAR,@LoopCounter)

		SELECT	@EpisodioClinico = #SS_HC_EpisodioClinicoAnt.EpisodioClinico,
				@IdOrdenAtencion = #SS_HC_EpisodioClinicoAnt.IdOrdenAtencion
		FROM	#SS_HC_EpisodioClinicoAnt 
		WHERE #SS_HC_EpisodioClinicoAnt.EpisodioClinico = @LoopCounter
		AND #SS_HC_EpisodioClinicoAnt.IdPaciente = @IdPacienteAnt

		UPDATE SS_HC_EpisodioAtencion SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_EpisodioAtencion where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		UPDATE SS_HC_EpisodioClinico SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_EpisodioClinico where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		UPDATE SS_HC_EpisodioAtencionMaster SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_EpisodioAtencionMaster where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		UPDATE SS_HC_EnfermedadActual_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_EnfermedadActual_FE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		UPDATE SS_HC_ExamenClinico_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_ExamenClinico_FE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		UPDATE SS_HC_Diagnostico_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_Diagnostico_FE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		UPDATE SS_HC_Medicamento_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_Medicamento_FE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		SELECT *
		INTO #SS_HC_ExamenSolicitadoDet_FE
		FROM SS_HC_ExamenSolicitadoDet_FE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		SELECT *
		INTO #SS_HC_ExamenSolicitadoFE
		FROM SS_HC_ExamenSolicitadoFE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		UPDATE #SS_HC_ExamenSolicitadoDet_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew

		UPDATE #SS_HC_ExamenSolicitadoFE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew

		DELETE FROM SS_HC_ExamenSolicitadoDet_FE WHERE IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		DELETE FROM SS_HC_ExamenSolicitadoFE WHERE IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion
		
		INSERT INTO SS_HC_ExamenSolicitadoFE
		SELECT * FROM #SS_HC_ExamenSolicitadoFE

		INSERT INTO SS_HC_ExamenSolicitadoDet_FE
		SELECT * FROM #SS_HC_ExamenSolicitadoDet_FE

		DROP TABLE #SS_HC_ExamenSolicitadoDet_FE

		DROP TABLE #SS_HC_ExamenSolicitadoFE

		UPDATE SS_HC_FuncionesVitales_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_FuncionesVitales_FE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		UPDATE SS_HC_InformeAlta_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		FROM SS_HC_InformeAlta_FE WHERE IdPaciente = @IdPacienteAnt  and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		UPDATE SS_HC_Oftalmologico_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_Oftalmologico_FE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		UPDATE SS_HC_AntecedentesPersonalesFisiologicos_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_AntecedentesPersonalesFisiologicos_FE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		UPDATE SS_HC_AntecedentesPersonalesIAdul_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_AntecedentesPersonalesIAdul_FE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		 UPDATE SS_HC_AntecedentesPersonalesIAdulDetalle_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_AntecedentesPersonalesIAdulDetalle_FE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion 
 
		UPDATE SS_HC_Anam_AP_PatologicosGenerales_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_Anam_AP_PatologicosGenerales_FE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		UPDATE SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion
      
		UPDATE SS_HC_AlergiaDetalle_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_AlergiaDetalle_FE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		UPDATE SS_HC_Anamnesis_AFAM_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_Anamnesis_AFAM_FE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion   

		UPDATE SS_HC_AntecedentesPersonalesIN_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_AntecedentesPersonalesIN_FE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		UPDATE SS_HC_AntecedentesPersonalesINDetalle_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_AntecedentesPersonalesINDetalle_FE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		UPDATE SS_HC_ANT_FISIOLOGICO_PEDIATRICO_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_ANT_FISIOLOGICO_PEDIATRICO_FE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		UPDATE SS_HC_ValoracionAM_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_ValoracionAM_FE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		UPDATE SS_HC_ValoracionFuncionalAM_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_ValoracionFuncionalAM_FE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		UPDATE SS_HC_ValoracionMentalAM_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_ValoracionMentalAM_FE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		UPDATE SS_HC_ValoracionSocioFamAM_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_ValoracionSocioFamAM_FE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		UPDATE SS_HC_ValoracionSocioFamAM_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_ValoracionSocioFamAM_FE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		UPDATE SS_HC_ProximaAtencion_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_ProximaAtencion_FE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		UPDATE SS_HC_ApoyoDiagnostico_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_ApoyoDiagnostico_FE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		UPDATE SS_HC_ApoyoDiagnosticoDet_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_ApoyoDiagnosticoDet_FE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion

		UPDATE SS_HC_ApoyoDiagnosticoFile_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_ApoyoDiagnosticoFile_FE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion
     
		UPDATE SS_HC_DescansoMedico_FE SET EpisodioClinico = @MaxEmployeeId + @LoopCounter, IdPaciente = @IdPacienteNew
		from SS_HC_DescansoMedico_FE where IdPaciente = @IdPacienteAnt and EpisodioClinico = @LoopCounter AND UnidadReplicacion = @UnidadReplicacion
	END

	DROP TABLE #SS_HC_EpisodioClinicoNew
	DROP TABLE #SS_HC_EpisodioClinicoAnt
END
GO

/****** Object:  StoredProcedure [dbo].[SP_HCE_EliminarEpisodios]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [SP_HCE_EliminarEpisodios]
@IDPACIENTE INT,
@IDEPISODIOCLINICO INT,
@episodioatencion bigint
AS
BEGIN

	DELETE FROM SS_HC_EpisodioAtencion
	WHERE idpaciente= @IDPACIENTE and EpisodioClinico= @IDEPISODIOCLINICO and EpisodioAtencion=@episodioatencion
	
	DELETE FROM SS_HC_EpisodioAtencionMaster
	WHERE idpaciente= @IDPACIENTE and EpisodioClinico= @IDEPISODIOCLINICO and EpisodioAtencion=@episodioatencion

END


GO
/****** Object:  StoredProcedure [dbo].[SP_HCE_GenerarCondicion]    Script Date: 17/04/2025 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP PROCEDURE SP_HCE_GenerarCondicion

CREATE OR ALTER PROCEDURE [SP_HCE_GenerarCondicion]
	@al_IdContrato int
AS

--TipoCondicion
--2 --> Exclusion
--6 --> Auditoria
--10--> Carta de Garantia



--CampoCondicion
--7 --> Clasificacion
--1 --> Prestación
--2 --> Linea
--3 --> Familia
--4 --> Subfamilia
--5 --> Articulo

CREATE TABLE #Proceso(
IdCondicion int,
UnidadReplicacion varchar(4),
IdContrato int,
TipoCondicion int,
CampoCondicion int,
IdClasificacion int,
LineaFamilia varchar(6),
Familia varchar(6),
SubFamilia varchar(6),
Componente varchar(25)
)


INSERT INTO #Proceso
SELECT SS_SG_CondicionRelacional.IdCondicion,
SS_SG_CondicionRelacional.UnidadReplicacion,
IdContrato = SS_SG_CondicionRelacional.IdTablaRelacional,
SS_SG_CondicionRelacional.TipoCondicion,
SS_SG_CondicionRelacional.CampoCondicion,
SS_SG_CondicionRelacional.IdClasificacion,
SS_SG_CondicionRelacional.LineaFamilia,
SS_SG_CondicionRelacional.Familia,
SS_SG_CondicionRelacional.SubFamilia,
SS_SG_CondicionRelacional.Componente
FROM SS_SG_CondicionRelacional
WHERE SS_SG_CondicionRelacional.TablaRelacional = 1
AND SS_SG_CondicionRelacional.TipoCondicion IN (2, 6, 10, 8,11,12,13,14)   --AGREGA 8,11,DO A PEDIDO DEL CLIENTE12,13,14
AND SS_SG_CondicionRelacional.IdTablaRelacional = @al_IdContrato
AND SS_SG_CondicionRelacional.Estado = 2


DELETE FROM SS_SG_RestriccionContrato WHERE SS_SG_RestriccionContrato.IdContrato = @al_IdContrato


INSERT INTO SS_SG_RestriccionContrato(UnidadReplicacion, IdContrato, TipoComponente, Componente, IndicadorEPS)
SELECT #Proceso.UnidadReplicacion,
#Proceso.IdContrato,
'C',
CM_CO_Componente.CodigoComponente,
(CASE #Proceso.TipoCondicion WHEN 2 THEN 1 WHEN 6 THEN 3 WHEN 10 THEN 4 END)
FROM #Proceso INNER JOIN CM_CO_Componente ON #Proceso.IdClasificacion = CM_CO_Componente.IdClasificacion
WHERE #Proceso.CampoCondicion = 7


INSERT INTO SS_SG_RestriccionContrato(UnidadReplicacion, IdContrato, TipoComponente, Componente, IndicadorEPS)
SELECT #Proceso.UnidadReplicacion,
#Proceso.IdContrato,
'C',
#Proceso.Componente,
(CASE #Proceso.TipoCondicion WHEN 2 THEN 1 WHEN 6 THEN 3 WHEN 10 THEN 4 END)
FROM #Proceso
WHERE #Proceso.CampoCondicion = 1


INSERT INTO SS_SG_RestriccionContrato(UnidadReplicacion, IdContrato, TipoComponente, Componente, IndicadorEPS)
SELECT #Proceso.UnidadReplicacion,
#Proceso.IdContrato,
'A',
RTRIM(LTRIM(WH_ItemMast.Item)),
(CASE #Proceso.TipoCondicion WHEN 2 THEN 1 WHEN 6 THEN 3 WHEN 10 THEN 4 END)
FROM #Proceso INNER JOIN WH_ItemMast ON #Proceso.LineaFamilia = WH_ItemMast.Linea COLLATE Latin1_General_CI_AS
WHERE #Proceso.CampoCondicion = 2


INSERT INTO SS_SG_RestriccionContrato(UnidadReplicacion, IdContrato, TipoComponente, Componente, IndicadorEPS)
SELECT #Proceso.UnidadReplicacion,
#Proceso.IdContrato,
'A',
RTRIM(LTRIM(WH_ItemMast.Item)),
(CASE #Proceso.TipoCondicion WHEN 2 THEN 1 WHEN 6 THEN 3 WHEN 10 THEN 4 END)
FROM #Proceso INNER JOIN WH_ItemMast ON #Proceso.LineaFamilia = WH_ItemMast.Linea COLLATE Latin1_General_CI_AS
	AND #Proceso.Familia = WH_ItemMast.Familia COLLATE Latin1_General_CI_AS
WHERE #Proceso.CampoCondicion = 3


INSERT INTO SS_SG_RestriccionContrato(UnidadReplicacion, IdContrato, TipoComponente, Componente, IndicadorEPS)
SELECT #Proceso.UnidadReplicacion,
#Proceso.IdContrato,
'A',
RTRIM(LTRIM(WH_ItemMast.Item)),
(CASE #Proceso.TipoCondicion WHEN 2 THEN 1 WHEN 6 THEN 3 WHEN 10 THEN 4 END)
FROM #Proceso INNER JOIN WH_ItemMast ON #Proceso.LineaFamilia = WH_ItemMast.Linea COLLATE Latin1_General_CI_AS
	AND #Proceso.Familia = WH_ItemMast.Familia COLLATE Latin1_General_CI_AS
	AND #Proceso.SubFamilia = WH_ItemMast.SubFamilia COLLATE Latin1_General_CI_AS
WHERE #Proceso.CampoCondicion = 4



INSERT INTO SS_SG_RestriccionContrato(UnidadReplicacion, IdContrato, TipoComponente, Componente, IndicadorEPS)
SELECT #Proceso.UnidadReplicacion,
#Proceso.IdContrato,
'A',
#Proceso.Componente,
(CASE #Proceso.TipoCondicion WHEN 2 THEN 1 WHEN 6 THEN 3 WHEN 10 THEN 4 END)
FROM #Proceso
WHERE #Proceso.CampoCondicion = 5


--SELECT *
--FROM SS_SG_RestriccionContrato


DROP TABLE #Proceso

/*
SELECT SS_SG_CondicionRelacional.IdClasificacion
FROM SS_SG_CondicionRelacional
--UPDATE SS_SG_CondicionRelacional SET Estado = Estado
WHERE SS_SG_CondicionRelacional.TablaRelacional = 1

SELECT *
FROM SS_SG_CondicionRelacional
SELECT *
--UPDATE SS_IT_SaludCondicionRelacionalSalida SET IndicadorMigrado = 1
FROM SS_IT_SaludCondicionRelacionalSalida

*/
GO

