

GO

CREATE OR ALTER TRIGGER [TGR_SS_IT_PersonaMast_Insert]
ON [dbo].[PersonaMast]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO WEB_ERPSALUD.dbo.PersonaMast (
        Persona, Origen, ApellidoPaterno, ApellidoMaterno, 
        Nombres, NombreCompleto, Busqueda, TipoDocumento,
        Documento, Sexo, Direccion, Telefono, 
        FechaNacimiento, Estado
    )
    SELECT 
        i.Persona,
        i.Origen,
        i.ApellidoPaterno,
        i.ApellidoMaterno,
        i.Nombres,
        i.NombreCompleto,
        i.NombreCompleto, -- Busqueda = NombreCompleto (como en tu trigger original)
        i.TipoDocumento,
        i.Documento,
        i.Sexo,
        i.Direccion,
        i.Telefono,
        i.FechaNacimiento,
        i.Estado
    FROM INSERTED i;
END
GO

CREATE OR ALTER TRIGGER [TGR_SS_IT_PersonaMast_Update] 
ON [dbo].[PersonaMast]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE(Persona) OR UPDATE(Origen) OR UPDATE(ApellidoPaterno) OR UPDATE(ApellidoMaterno) OR UPDATE(Nombres) OR UPDATE(NombreCompleto) 
       OR UPDATE(TipoDocumento) OR UPDATE(Documento) OR UPDATE(Sexo) OR UPDATE(Direccion) OR UPDATE(Telefono) OR UPDATE(FechaNacimiento) 
       OR UPDATE(Estado)
    BEGIN
        -- Primero ACTUALIZAR los que ya existen
        UPDATE Destino
        SET
            Destino.Origen = Origen.Origen,
            Destino.ApellidoPaterno = Origen.ApellidoPaterno,
            Destino.ApellidoMaterno = Origen.ApellidoMaterno,
            Destino.Nombres = Origen.Nombres,
            Destino.NombreCompleto = Origen.NombreCompleto,
            Destino.Busqueda = Origen.NombreCompleto, -- Asumiendo que quieres igualarlo siempre
            Destino.TipoDocumento = Origen.TipoDocumento,
            Destino.Documento = Origen.Documento,
            Destino.Sexo = Origen.Sexo,
            Destino.Direccion = Origen.Direccion,
            Destino.Telefono = Origen.Telefono,
            Destino.FechaNacimiento = Origen.FechaNacimiento,
            Destino.Estado = Origen.Estado
        FROM WEB_ERPSALUD.dbo.PersonaMast Destino
        INNER JOIN INSERTED Origen ON Destino.Persona = Origen.Persona;

        -- Luego INSERTAR los que no existen
        INSERT INTO WEB_ERPSALUD.dbo.PersonaMast (
            Persona, Origen, ApellidoPaterno, ApellidoMaterno, Nombres, NombreCompleto, Busqueda, 
            TipoDocumento, Documento, Sexo, Direccion, Telefono, FechaNacimiento, Estado
        )
        SELECT 
            Origen.Persona, Origen.Origen, Origen.ApellidoPaterno, Origen.ApellidoMaterno, Origen.Nombres, 
            Origen.NombreCompleto, Origen.NombreCompleto, -- Busqueda = NombreCompleto
            Origen.TipoDocumento, Origen.Documento, Origen.Sexo, Origen.Direccion, Origen.Telefono, 
            Origen.FechaNacimiento, Origen.Estado
        FROM INSERTED Origen
        LEFT JOIN WEB_ERPSALUD.dbo.PersonaMast Destino ON Destino.Persona = Origen.Persona
        WHERE Destino.Persona IS NULL;
    END
END
GO

CREATE OR ALTER TRIGGER [TGR_SS_IT_Empleado_Insert_New]
ON [dbo].[EmpleadoMast]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO WEB_ERPSALUD.dbo.EmpleadoMast (
        Empleado,
        TipoTrabajadorSalud,
        UnidadNegocioAsignada,
        CodigoUsuario,
        Foto,
        Perfil,
        UnidadReplicacion,
        CMP,
        TipoMedico,
        ClaveFirmaDigital,
        FirmaDigital,
        CompaniaSocio,
        Estado
    )
    SELECT 
        i.Empleado,
        i.TipoTrabajadorSalud,
        i.UnidadNegocioAsignada,
        i.CodigoUsuario,
        i.Foto,
        i.Perfil,
        i.UnidadReplicacion,
        i.CMP,
        i.TipoMedico,
        i.ClaveFirmaDigital,
        i.FirmaDigital,
        i.CompaniaSocio,
        i.Estado
    FROM INSERTED i;
END
GO

CREATE OR ALTER TRIGGER [TGR_SS_IT_Empleado_Update_New] 
ON [dbo].[EmpleadoMast]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE(Empleado) OR UPDATE(TipoTrabajadorSalud) OR UPDATE(UnidadNegocioAsignada) OR UPDATE(CodigoUsuario) 
       OR UPDATE(Foto) OR UPDATE(Perfil) OR UPDATE(UnidadReplicacion) OR UPDATE(CMP) 
       OR UPDATE(TipoMedico) OR UPDATE(ClaveFirmaDigital) OR UPDATE(FirmaDigital) 
       OR UPDATE(CompaniaSocio) OR UPDATE(Estado)
    BEGIN 
        DECLARE @ldt_fecha DATETIME = GETDATE();

        -- Actualizar los empleados que ya existen
        UPDATE T
        SET
            T.TipoTrabajadorSalud = I.TipoTrabajadorSalud,
            T.UnidadNegocioAsignada = I.UnidadNegocioAsignada,
            T.CodigoUsuario = I.CodigoUsuario,
            T.Foto = I.Foto,
            T.Perfil = I.Perfil,
            T.UnidadReplicacion = I.UnidadReplicacion,
            T.CMP = I.CMP,
            T.TipoMedico = I.TipoMedico,
            T.ClaveFirmaDigital = I.ClaveFirmaDigital,
            T.FirmaDigital = I.FirmaDigital,
            T.CompaniaSocio = I.CompaniaSocio,
            T.TipoPago = I.TipoPago,
            T.TipoTrabajador = I.TipoTrabajador,
            T.TipoPlanilla = I.TipoPlanilla,
            T.Estado = I.Estado
        FROM WEB_ERPSALUD.dbo.EmpleadoMast T
        INNER JOIN INSERTED I ON T.Empleado = I.Empleado;

        -- Insertar los empleados nuevos que no existen
        INSERT INTO WEB_ERPSALUD.dbo.EmpleadoMast (
            Empleado, TipoTrabajadorSalud, UnidadNegocioAsignada, CodigoUsuario, Foto,
            Perfil, UnidadReplicacion, CMP, TipoMedico, ClaveFirmaDigital, FirmaDigital, 
            CompaniaSocio, TipoPago, TipoTrabajador, TipoPlanilla, Estado
        )
        SELECT 
            I.Empleado, I.TipoTrabajadorSalud, I.UnidadNegocioAsignada, I.CodigoUsuario, I.Foto,
            I.Perfil, I.UnidadReplicacion, I.CMP, I.TipoMedico, I.ClaveFirmaDigital, I.FirmaDigital,
            I.CompaniaSocio, I.TipoPago, I.TipoTrabajador, I.TipoPlanilla, I.Estado
        FROM INSERTED I
        LEFT JOIN WEB_ERPSALUD.dbo.EmpleadoMast T ON T.Empleado = I.Empleado
        WHERE T.Empleado IS NULL;

    END
END
GO

CREATE OR ALTER TRIGGER [TGR_SS_IT_Paciente_Insert_New]
ON [dbo].[SS_GE_Paciente]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO WEB_ERPSALUD.dbo.SS_GE_Paciente (
        IdPaciente,
        CodigoHC,
        CodigoHCAnterior,
        RutaFoto,
        Estado
    )
    SELECT 
        i.IdPaciente,
        i.CodigoHC,
        i.CodigoHCAnterior,
        i.RutaFoto,
        i.Estado
    FROM INSERTED i;
END
GO

CREATE OR ALTER TRIGGER [TGR_SS_IT_Paciente_Update_New] 
ON [dbo].[SS_GE_Paciente]
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;

	IF UPDATE(IdPaciente) OR UPDATE(CodigoHC) OR UPDATE(CodigoHCAnterior) OR UPDATE(RutaFoto) OR UPDATE(Estado)
	BEGIN
		DECLARE @ldt_fecha DATETIME = GETDATE();

		-- Primero, actualizar los registros que ya existen
		UPDATE P
		SET 
			P.CodigoHC = I.CodigoHC,
			P.CodigoHCAnterior = I.CodigoHCAnterior,
			P.RutaFoto = I.RutaFoto,
			P.Estado = I.Estado
		FROM WEB_ERPSALUD.dbo.SS_GE_Paciente P
		INNER JOIN INSERTED I ON P.IdPaciente = I.IdPaciente;

		-- Luego, insertar los registros que no existen
		INSERT INTO WEB_ERPSALUD.dbo.SS_GE_Paciente (IdPaciente, CodigoHC, CodigoHCAnterior, RutaFoto, Estado)
		SELECT 
			I.IdPaciente,
			I.CodigoHC,
			I.CodigoHCAnterior,
			I.RutaFoto,
			I.Estado
		FROM INSERTED I
		LEFT JOIN WEB_ERPSALUD.dbo.SS_GE_Paciente P ON P.IdPaciente = I.IdPaciente
		WHERE P.IdPaciente IS NULL;

	END
END
GO

CREATE OR ALTER TRIGGER TR_WH_ItemMast_SYNC
ON dbo.WH_ItemMast
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- INSERT
    IF EXISTS (SELECT 1 FROM inserted) AND NOT EXISTS (SELECT 1 FROM deleted)
    BEGIN
        INSERT INTO WEB_ERPSALUD.dbo.WH_ItemMast (
            Item, ItemTipo, Linea, Familia, SubFamilia,
            DescripcionLocal, DescripcionIngles, DescripcionCompleta,
            CodigoInterno, UnidadCodigo, UnidadCompra, UnidadEmbalaje,
            MonedaCodigo, PrecioUnitarioLocal, PrecioUnitarioDolares,
            DisponibleVentaFlag, ManejoxLoteFlag,
            AfectoImpuestoVentasFlag, AfectoImpuesto2Flag, ControlCalidadFlag,
            DisponibleTransferenciaFlag, DisponibleConsumoFlag,
            FormularioFlag, ISOAplicableFlag, CantidadDobleFlag,
            CantidadDobleFactor, UnidadReplicacion,
            CuentaInventario, CuentaGasto, CuentaServicioTecnico,
            CuentaSalidaTerceros, CuentaVentas, CuentaTransito,
            FactorEquivalenciaComercial, StockMinimo, StockMaximo,
            Estado, UltimaFechaModif, UltimoUsuario,
            Centrocosto, UsuarioCreacion, FechaCreacion,
            CuentaCompras, ACCION
        )
        SELECT
            Item, ItemTipo, Linea, Familia, SubFamilia,
            DescripcionLocal, DescripcionIngles, DescripcionCompleta,
            CodigoInterno, UnidadCodigo, UnidadCompra, UnidadEmbalaje,
            MonedaCodigo, PrecioUnitarioLocal, PrecioUnitarioDolares,
            DisponibleVentaFlag, ManejoxLoteFlag,
            AfectoImpuestoVentasFlag, AfectoImpuesto2Flag, ControlCalidadFlag,
            DisponibleTransferenciaFlag, DisponibleConsumoFlag,
            FormularioFlag, ISOAplicableFlag, CantidadDobleFlag,
            CantidadDobleFactor, UnidadReplicacion,
            CuentaInventario, CuentaGasto, CuentaServicioTecnico,
            CuentaSalidaTerceros, CuentaVentas, CuentaTransito,
            FactorEquivalenciaComercial, StockMinimo, StockMaximo,
            Estado, UltimaFechaModif, UltimoUsuario,
            Centrocosto, UsuarioCreacion, FechaCreacion,
            CuentaCompras, 'INSERT'
        FROM inserted;
    END

    -- UPDATE (solo si cambian campos clave)
    IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
    BEGIN
        -- Insertar si no existe
        INSERT INTO WEB_ERPSALUD.dbo.WH_ItemMast (
            Item, ItemTipo, Linea, Familia, SubFamilia, DescripcionLocal,
            DescripcionIngles, DescripcionCompleta, CodigoInterno, UnidadCodigo,
            UnidadCompra, UnidadEmbalaje, MonedaCodigo, PrecioUnitarioLocal,
            PrecioUnitarioDolares, DisponibleVentaFlag, ManejoxLoteFlag,
            AfectoImpuestoVentasFlag, AfectoImpuesto2Flag, ControlCalidadFlag,
            DisponibleTransferenciaFlag, DisponibleConsumoFlag, FormularioFlag,
            ISOAplicableFlag, CantidadDobleFlag, CantidadDobleFactor,
            UnidadReplicacion, CuentaInventario, CuentaGasto, CuentaServicioTecnico,
            CuentaSalidaTerceros, CuentaVentas, CuentaTransito,
            FactorEquivalenciaComercial, StockMinimo, StockMaximo, Estado,
            UltimaFechaModif, UltimoUsuario, Centrocosto, UsuarioCreacion,
            FechaCreacion, CuentaCompras, ACCION
        )
        SELECT 
            I.Item, I.ItemTipo, I.Linea, I.Familia, I.SubFamilia, I.DescripcionLocal,
            I.DescripcionIngles, I.DescripcionCompleta, I.CodigoInterno, I.UnidadCodigo,
            I.UnidadCompra, I.UnidadEmbalaje, I.MonedaCodigo, I.PrecioUnitarioLocal,
            I.PrecioUnitarioDolares, I.DisponibleVentaFlag, I.ManejoxLoteFlag,
            I.AfectoImpuestoVentasFlag, I.AfectoImpuesto2Flag, I.ControlCalidadFlag,
            I.DisponibleTransferenciaFlag, I.DisponibleConsumoFlag, I.FormularioFlag,
            I.ISOAplicableFlag, I.CantidadDobleFlag, I.CantidadDobleFactor,
            I.UnidadReplicacion, I.CuentaInventario, I.CuentaGasto, I.CuentaServicioTecnico,
            I.CuentaSalidaTerceros, I.CuentaVentas, I.CuentaTransito,
            I.FactorEquivalenciaComercial, I.StockMinimo, I.StockMaximo, I.Estado,
            I.UltimaFechaModif, I.UltimoUsuario, I.Centrocosto, I.UsuarioCreacion,
            I.FechaCreacion, I.CuentaCompras, 'INSERT'
        FROM INSERTED I
        WHERE NOT EXISTS (
            SELECT 1
            FROM WEB_ERPSALUD.dbo.WH_ItemMast TGT
            WHERE TGT.Item = I.Item COLLATE Latin1_General_CI_AS
        );

        -- UPDATE si hay cambios en campos específicos
        UPDATE T
        SET
            T.ItemTipo = I.ItemTipo,
            T.Linea = I.Linea,
            T.Familia = I.Familia,
            T.SubFamilia = I.SubFamilia,
            T.DescripcionLocal = I.DescripcionLocal,
            T.DescripcionIngles = I.DescripcionIngles,
            T.DescripcionCompleta = I.DescripcionCompleta,
            T.Estado = I.Estado,
            T.UltimaFechaModif = I.UltimaFechaModif,
            T.UltimoUsuario = I.UltimoUsuario,
            T.ACCION = 'UPDATE'
        FROM WEB_ERPSALUD.dbo.WH_ItemMast T
        INNER JOIN INSERTED I ON T.Item = I.Item COLLATE Latin1_General_CI_AS
        INNER JOIN DELETED D ON I.Item = D.Item
        WHERE
            ISNULL(I.ItemTipo, '') <> ISNULL(D.ItemTipo, '') OR
            ISNULL(I.Linea, '') <> ISNULL(D.Linea, '') OR
            ISNULL(I.Familia, '') <> ISNULL(D.Familia, '') OR
            ISNULL(I.SubFamilia, '') <> ISNULL(D.SubFamilia, '') OR
            ISNULL(I.DescripcionLocal, '') <> ISNULL(D.DescripcionLocal, '') OR
            ISNULL(I.DescripcionIngles, '') <> ISNULL(D.DescripcionIngles, '') OR
            ISNULL(I.DescripcionCompleta, '') <> ISNULL(D.DescripcionCompleta, '') OR
            ISNULL(I.Estado, '') <> ISNULL(D.Estado, '');
    END

    -- DELETE
    IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
    BEGIN
        DELETE T
        FROM WEB_ERPSALUD.dbo.WH_ItemMast T
        INNER JOIN deleted D ON T.Item = D.Item COLLATE Latin1_General_CI_AS;
    END
END;
GO



