
GO
/****** Object:  UserDefinedFunction [dbo].[FUN_DIAGNOSTICOFE_EPISODIO]    Script Date: 16/04/2025 17:45:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER FUNCTION [dbo].[FUN_DIAGNOSTICOFE_EPISODIO] 
(
    @UnidadReplicacion CHAR(4),
    @idPaciente INT = NULL,
    @EpisodioClinico INT = NULL
)
RETURNS VARCHAR(MAX)
AS
BEGIN
    DECLARE @resultado VARCHAR(MAX);

    SELECT @resultado = STUFF((
        SELECT 
            ', [' + RTRIM(LTRIM(A.CodigoDiagnostico)) + '] ' + LTRIM(RTRIM(A.Descripcion))
        FROM SS_HC_Diagnostico_FE B
        INNER JOIN SS_GE_Diagnostico A ON A.IdDiagnostico = B.IdDiagnostico
        WHERE 
            B.IdPaciente = @idPaciente
            AND B.UnidadReplicacion = @UnidadReplicacion
            AND (@EpisodioClinico IS NULL OR B.EpisodioClinico = @EpisodioClinico)
        FOR XML PATH(''), TYPE
    ).value('.', 'VARCHAR(MAX)'), 1, 2, '');

    RETURN @resultado;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[ObtenerEdad]    Script Date: 16/04/2025 17:45:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER function [dbo].[ObtenerEdad](@FechaNacimiento date)
returns int
Begin

declare @hoy date, @Edad int
 set @hoy = GETDATE() 

set 

@Edad = CASE WHEN MONTH(@FechaNacimiento) > MONTH(@hoy) THEN (YEAR(@hoy) 
 - YEAR(@FechaNacimiento) - 1) WHEN MONTH(@hoy) = MONTH(@FechaNacimiento) 
 AND DAY(@FechaNacimiento) > DAY(@hoy) THEN YEAR(@hoy) - YEAR(@FechaNacimiento) 
 - 1 ELSE YEAR(@hoy) - YEAR(@FechaNacimiento) END
return @Edad
End
GO
/****** Object:  UserDefinedFunction [dbo].[UFN_Agente]    Script Date: 16/04/2025 17:45:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER function [dbo].[UFN_Agente](@IdUsuario int =null )
		   returns varchar(max)
			as
			begin
			
			declare @variable varchar(max)

			SELECT @variable=CodigoAgente FROM SG_Agente where IdAgente =@IdUsuario

			 return @variable
		   end
GO
/****** Object:  UserDefinedFunction [dbo].[UFN_Diagnostico_ApoyoDiagnostico_FE]    Script Date: 16/04/2025 17:45:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER FUNCTION [dbo].[UFN_Diagnostico_ApoyoDiagnostico_FE] 
(
    @UnidadReplicacion CHAR(4),
    @idEpisodioAtencion INT,
    @idPaciente INT,
    @EpisodioClinico INT
)
RETURNS VARCHAR(MAX)
AS
BEGIN
    DECLARE @resultado VARCHAR(MAX);

    SELECT @resultado = STUFF((
        SELECT 
            ', [' + RTRIM(LTRIM(C.CodigoDiagnostico)) + '] ' + LTRIM(RTRIM(C.Descripcion))
        FROM SS_HC_ApoyoDiagnosticoDet_FE B
        INNER JOIN SS_GE_Diagnostico C ON C.IdDiagnostico = B.IdDiagnostico
        WHERE 
            B.IdPaciente = @idPaciente
            AND B.EpisodioClinico = @EpisodioClinico
            AND B.IdEpisodioAtencion = @idEpisodioAtencion
            AND B.UnidadReplicacion = @UnidadReplicacion
        FOR XML PATH(''), TYPE
    ).value('.', 'VARCHAR(MAX)'), 1, 2, '');

    RETURN @resultado;
END;

GO
/****** Object:  UserDefinedFunction [dbo].[UFN_Diagnostico_CONTRARREFERENCIA_FE]    Script Date: 16/04/2025 17:45:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER FUNCTION [dbo].[UFN_Diagnostico_CONTRARREFERENCIA_FE] 
(
    @UnidadReplicacion CHAR(4),
    @idEpisodioAtencion INT,
    @idPaciente INT,
    @EpisodioClinico INT,
    @tipo VARCHAR(2)
)
RETURNS VARCHAR(MAX)
AS 
BEGIN
    DECLARE @resultado VARCHAR(MAX);

    SELECT @resultado = STUFF((
        SELECT 
            ', ' + LTRIM(RTRIM(C.Descripcion))
        FROM SS_HC_CONTRARREFERENCIA_Diagnostico_FE B
        INNER JOIN SS_GE_Diagnostico C ON C.IdDiagnostico = B.IdDiagnostico
        WHERE 
            B.IdPaciente = @idPaciente
            AND B.EpisodioClinico = @EpisodioClinico
            AND B.IdEpisodioAtencion = @idEpisodioAtencion
            AND B.UnidadReplicacion = @UnidadReplicacion
            AND B.TipoRegistro = @tipo
        FOR XML PATH(''), TYPE
    ).value('.', 'VARCHAR(MAX)'), 1, 2, '');

    RETURN @resultado;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[UFN_DIAGNOSTICO_FE]    Script Date: 16/04/2025 17:45:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER FUNCTION [dbo].[UFN_DIAGNOSTICO_FE]
(
    @UnidadReplicacion CHAR(4),
    @idEpisodioAtencion INT = NULL,
    @idPaciente INT = NULL,
    @EpisodioClinico INT = NULL
)
RETURNS VARCHAR(MAX)
AS
BEGIN
    DECLARE @resultado VARCHAR(MAX);

    SELECT @resultado = STUFF((
        SELECT 
            ', [' + RTRIM(A.CodigoDiagnostico) + '] ' + LTRIM(RTRIM(A.Descripcion))
        FROM SS_HC_Diagnostico_FE B
        INNER JOIN SS_GE_Diagnostico A ON A.IdDiagnostico = B.IdDiagnostico
        WHERE 
            B.UnidadReplicacion = @UnidadReplicacion
            AND (@idPaciente IS NULL OR B.IdPaciente = @idPaciente)
            AND (@EpisodioClinico IS NULL OR B.EpisodioClinico = @EpisodioClinico)
            AND (@idEpisodioAtencion IS NULL OR B.IdEpisodioAtencion = @idEpisodioAtencion)
        FOR XML PATH(''), TYPE
    ).value('.', 'VARCHAR(MAX)'), 1, 2, '');

    RETURN @resultado;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[UFN_DIAGNOSTICO_RECETA]    Script Date: 16/04/2025 17:45:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER FUNCTION [dbo].[UFN_DIAGNOSTICO_RECETA]
(
    @UnidadReplicacion CHAR(4),
    @idEpisodioAtencion INT,
    @idPaciente INT,
    @EpisodioClinico INT
)
RETURNS VARCHAR(MAX)
AS
BEGIN
    DECLARE @resultado VARCHAR(MAX);

    SELECT @resultado = STUFF((
        SELECT 
            ', ' + LTRIM(RTRIM(C.Descripcion))
        FROM SS_HC_DescansoMedico_Diagnostico_FE B
        INNER JOIN SS_GE_Diagnostico C ON C.IdDiagnostico = B.IdDiagnostico
        WHERE 
            B.IdPaciente = @idPaciente
            AND B.EpisodioClinico = @EpisodioClinico
            AND B.IdEpisodioAtencion = @idEpisodioAtencion
            AND B.UnidadReplicacion = @UnidadReplicacion
        FOR XML PATH(''), TYPE
    ).value('.', 'VARCHAR(MAX)'), 1, 2, '');

    RETURN @resultado;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[UFN_DIAGNOSTICODescansoMedico_FE]    Script Date: 16/04/2025 17:45:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER FUNCTION [dbo].[UFN_DIAGNOSTICODescansoMedico_FE]
(
    @UnidadReplicacion CHAR(4),
    @idEpisodioAtencion INT = NULL,
    @idPaciente INT = NULL,
    @EpisodioClinico INT = NULL
)
RETURNS VARCHAR(MAX)
AS
BEGIN
    DECLARE @resultado VARCHAR(MAX);

    SELECT @resultado = STUFF((
        SELECT 
            ', [' + RTRIM(A.CodigoDiagnostico) + '] ' + LTRIM(RTRIM(A.Descripcion))
        FROM SS_HC_DescansoMedico_Diagnostico_FE B
        INNER JOIN SS_GE_Diagnostico A ON A.IdDiagnostico = B.IdDiagnostico
        WHERE 
            B.UnidadReplicacion = @UnidadReplicacion
            AND (@idPaciente IS NULL OR B.IdPaciente = @idPaciente)
            AND (@EpisodioClinico IS NULL OR B.EpisodioClinico = @EpisodioClinico)
            AND (@idEpisodioAtencion IS NULL OR B.IdEpisodioAtencion = @idEpisodioAtencion)
        FOR XML PATH(''), TYPE
    ).value('.', 'VARCHAR(MAX)'), 1, 2, '');

    RETURN @resultado;
END;
GO

/****** Object:  UserDefinedFunction [dbo].[UFN_DATOS_SEDE]    Script Date: 16/04/2025 17:45:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER FUNCTION [dbo].[UFN_DATOS_SEDE](@Sucursal char(4))
RETURNS TABLE
AS
RETURN (Select  distinct  A.DescripcionLarga,B.DescripcionLocal,A.DireccionComun,A.DocumentoFiscal,B.Sucursal from CompaniaMast AS A
inner join AC_Sucursal  AS B on  A.CompaniaCodigo+ A.PropietarioPorDefecto = B.Compania
where B.Sucursal= @Sucursal)


GO
/****** Object:  UserDefinedFunction [dbo].[ufnDiagnostico]    Script Date: 16/04/2025 17:45:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE OR ALTER FUNCTION [dbo].[ufnDiagnostico]
(
    @UnidadReplicacion CHAR(4),
    @idEpisodioAtencion INT,
    @idPaciente INT,
    @EpisodioClinico INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        Diagnostico = STUFF((
            SELECT 
                ', ' + C.Descripcion
            FROM SS_HC_DescansoMedico_Diagnostico_FE B
            INNER JOIN SS_GE_Diagnostico C ON C.IdDiagnostico = B.IdDiagnostico
            WHERE 
                B.UnidadReplicacion = @UnidadReplicacion
                AND B.IdPaciente = @idPaciente
                AND B.EpisodioClinico = @EpisodioClinico
                AND B.IdEpisodioAtencion = @idEpisodioAtencion
            FOR XML PATH(''), TYPE
        ).value('.', 'VARCHAR(MAX)'), 1, 2, '')
);

GO
