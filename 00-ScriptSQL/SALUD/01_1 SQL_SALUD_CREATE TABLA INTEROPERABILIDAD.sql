GO
ALTER TABLE SS_AD_OrdenAtencionDetalle ADD  SECUENCIALHCE varchar(25);  
ALTER TABLE SS_AD_OrdenAtencionDetalle ADD  flg_SEGUIMIENTO varchar(20);  

GO
CREATE TABLE [dbo].[SS_IT_SaludATENDIDOConsultaExternaIngreso](
	[IdOrdenAtencion] [int] NULL,
	[LineaOrdenAtencionConsulta] [int] NULL,
	[UnidadReplicacion] [varchar](15) NULL,
	[IdEpisodioAtencion] [int] NULL,
	[IdPaciente] [int] NULL,
	[EpisodioClinico] [int] NULL,
	[Secuencia] [int] NULL,
	[Estado] [int] NULL,
	[UsuarioCreacion] [char](15) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioModificacion] [char](15) NULL,
	[FechaModificacion] [datetime] NULL,
	[IndicadorProcesado] [int] NULL,
	[FechaProcesado] [datetime] NULL,
	[TipoOrdenAtencion] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[SS_IT_SaludInformePROCIngreso](
	[IdOrdenAtencion] [int] NULL,
	[LineaOrdenAtencion] [int] NULL,
	[UnidadReplicacion] [varchar](15) NULL,
	[IdEpisodioAtencion] [int] NULL,
	[IdPaciente] [int] NULL,
	[EpisodioClinico] [int] NULL,
	[Informe] [varchar](8000) NULL,
	[Estado] [int] NULL,
	[UsuarioCreacion] [char](15) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioModificacion] [char](15) NULL,
	[FechaModificacion] [datetime] NULL,
	[IndicadorRecepcion] [int] NULL,
	[FechaRecepcion] [datetime] NULL,
	[IndicadorProcesado] [int] NULL,
	[FechaProcesado] [datetime] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[SS_IT_SaludInformeRutaIngreso](
	[IdOrdenAtencion] [int] NULL,
	[LineaOrdenAtencion] [int] NULL,
	[UnidadReplicacion] [varchar](15) NULL,
	[IdEpisodioAtencion] [int] NULL,
	[IdPaciente] [int] NULL,
	[EpisodioClinico] [int] NULL,
	[RutaInforme] [varchar](250) NULL,
	[Observacion] [varchar](250) NULL,
	[Estado] [int] NULL,
	[UsuarioCreacion] [char](15) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioModificacion] [char](15) NULL,
	[FechaModificacion] [datetime] NULL,
	[IndicadorRecepcion] [int] NULL,
	[FechaRecepcion] [datetime] NULL,
	[IndicadorProcesado] [int] NULL,
	[FechaProcesado] [datetime] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[SS_IT_SaludAnamnesisIngreso](
	[IdOrdenAtencion] [int] NOT NULL,
	[LineaOrdenAtencion] [int] NULL,
	[UnidadReplicacion] [varchar](15) NULL,
	[IdEpisodioAtencion] [int] NOT NULL,
	[IdPaciente] [int] NOT NULL,
	[EpisodioClinico] [int] NULL,
	[Secuencia] [nchar](10) NULL,
	[TiempoEnfermedad] [varchar](15) NULL,
	[TiempoEnfermedadUnidad] [varchar](15) NULL,
	[RelatoCronologico] [varchar](8000) NULL,
	[PresionArterialMSD1] [varchar](15) NULL,
	[PresionArterialMSD2] [int] NULL,
	[PresionArterialMSI1] [varchar](15) NULL,
	[PresionArterialMSI2] [varchar](5) NULL,
	[FrecuenciaCardiaca] [varchar](10) NULL,
	[FrecuenciaRespiratoria] [int] NULL,
	[Temperatura] [varchar](5) NULL,
	[SaturacionOxigeno] [int] NULL,
	[Peso] [varchar](10) NULL,
	[Talla] [varchar](100) NULL,
	[Estado] [int] NULL,
	[UsuarioCreacion] [char](15) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioModificacion] [char](15) NULL,
	[FechaModificacion] [datetime] NULL,
	[IndicadorProcesado] [int] NULL,
	[FechaProcesado] [datetime] NULL,
	[EXAMENCLINICOOBS] [varchar](8000) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[SS_IT_SaludConsultaExternaIngreso](
	[IdOrdenAtencion] [int] NULL,
	[LineaOrdenAtencionConsulta] [int] NULL,
	[UnidadReplicacion] [varchar](15) NULL,
	[IdEpisodioAtencion] [int] NULL,
	[IdPaciente] [int] NULL,
	[EpisodioClinico] [int] NULL,
	[Secuencia] [int] NULL,
	[Estado] [int] NULL,
	[UsuarioCreacion] [char](15) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioModificacion] [char](15) NULL,
	[FechaModificacion] [datetime] NULL,
	[IndicadorProcesado] [int] NULL,
	[FechaProcesado] [datetime] NULL,
	[TipoOrdenAtencion] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[SS_IT_SaludDiagnosticoIngreso](
	[IdOrdenAtencion] [int] NULL,
	[LineaOrdenAtencionConsulta] [int] NULL,
	[IdDiagnostico] [int] NULL,
	[UnidadReplicacion] [varchar](15) NULL,
	[IdEpisodioAtencion] [int] NULL,
	[IdPaciente] [int] NULL,
	[EpisodioClinico] [int] NULL,
	[Secuencia] [int] NULL,
	[Estado] [int] NULL,
	[UsuarioCreacion] [char](15) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioModificacion] [char](15) NULL,
	[FechaModificacion] [datetime] NULL,
	[IndicadorRecepcion] [int] NULL,
	[FechaRecepcion] [datetime] NULL,
	[IndicadorProcesado] [int] NULL,
	[FechaProcesado] [datetime] NULL,
	[Determinacion] [char](2) NULL,
	[TIPOORDENATENCION] [int] NULL,
	[ObservacionDIAGNOSTICO] [varchar](200) NULL,
	[TIPOIT] [varchar](5) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[SS_IT_SaludOFTALMOLOGICOIngreso](
	[IdOrdenAtencion] [int] NOT NULL,
	[LineaOrdenAtencion] [int] NULL,
	[UnidadReplicacion] [varchar](15) NULL,
	[IdEpisodioAtencion] [int] NOT NULL,
	[IdPaciente] [int] NOT NULL,
	[EpisodioClinico] [int] NULL,
	[Secuencia] [nchar](10) NULL,
	[ENFACTUAL] [varchar](4000) NULL,
	[ANTIMPORTANCIA] [varchar](25) NULL,
	[AVscOD] [varchar](25) NULL,
	[AvCCOD] [varchar](25) NULL,
	[AEAVODPIN] [varchar](25) NULL,
	[CERCAVAD] [varchar](25) NULL,
	[AVSCOI] [varchar](25) NULL,
	[AVCCOI] [varchar](25) NULL,
	[AEAVOIDPIN] [varchar](25) NULL,
	[CERCAVAOI] [varchar](25) NULL,
	[SPHodREFRA] [varchar](25) NULL,
	[CILodREFA] [varchar](25) NULL,
	[EJEodREFRA] [varchar](25) NULL,
	[AVodREFRA] [varchar](25) NULL,
	[ADDodREFRA] [varchar](25) NULL,
	[DIPodREFRA] [varchar](25) NULL,
	[SPHoiSCICLO] [varchar](25) NULL,
	[CILoiSCICLO] [varchar](25) NULL,
	[EJEoiSCICLO] [varchar](25) NULL,
	[AVoiSCICLO] [varchar](25) NULL,
	[ADDoiSCICLO] [varchar](25) NULL,
	[DIPoiSCICLO] [varchar](25) NULL,
	[PAPARPADOSANEXOS] [varchar](500) NULL,
	[CORNEACRISTESCLERA] [varchar](500) NULL,
	[IRISPUPILA] [varchar](500) NULL,
	[TonoOD] [varchar](25) NULL,
	[TonoOI] [varchar](25) NULL,
	[MMHHTonShiotz] [varchar](25) NULL,
	[MMHHTonAplanacion] [varchar](25) NULL,
	[MMHHTonOtra] [varchar](25) NULL,
	[FONDOJOyG] [varchar](500) NULL,
	[Estado] [int] NULL,
	[UsuarioCreacion] [varchar](15) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioModificacion] [varchar](15) NULL,
	[FechaModificacion] [datetime] NULL,
	[IndicadorProcesado] [int] NULL,
	[FechaProcesado] [datetime] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[SS_IT_SaludProcedimientoIngreso](
	[IdOrdenAtencion] [int] NULL,
	[LineaOrdenAtencionConsulta] [int] NULL,
	[LineaOrdenAtencion] [int] NULL,
	[Componente] [char](15) NULL,
	[Cantidad] [int] NULL,
	[IndicadorEPS] [int] NULL,
	[Especialidad] [int] NULL,
	[IdMedico] [int] NULL,
	[FechaProcedimiento] [datetime] NULL,
	[IdCita] [int] NULL,
	[EstadoDocumento] [int] NULL,
	[UnidadReplicacion] [varchar](15) NULL,
	[IdEpisodioAtencion] [int] NULL,
	[IdPaciente] [int] NULL,
	[EpisodioClinico] [int] NULL,
	[Secuencia] [int] NULL,
	[Estado] [int] NULL,
	[UsuarioCreacion] [char](15) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioModificacion] [char](15) NULL,
	[FechaModificacion] [datetime] NULL,
	[IndicadorRecepcion] [int] NULL,
	[FechaRecepcion] [datetime] NULL,
	[IndicadorProcesado] [int] NULL,
	[FechaProcesado] [datetime] NULL,
	[idtipoordenatencion] [int] NULL,
	[Observacion] [varchar](500) NULL,
	[SecuencialHCE] [varchar](15) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[SS_IT_SaludRecetaIngreso](
	[IdOrdenAtencion] [int] NULL,
	[LineaOrdenAtencionConsulta] [int] NULL,
	[LineaOrdenAtencion] [int] NULL,
	[Componente] [varchar](25) NULL,
	[SubFamilia] [char](6) NULL,
	[Familia] [char](6) NULL,
	[Linea] [char](6) NULL,
	[UnidadMedida] [int] NULL,
	[Cantidad] [decimal](20, 6) NULL,
	[FechaAplicacion] [datetime] NULL,
	[Via] [varchar](15) NULL,
	[Dosis] [varchar](150) NULL,
	[DiasTratamiento] [varchar](15) NULL,
	[Frecuencia] [varchar](15) NULL,
	[IndicadorEPS] [int] NULL,
	[TipoReceta] [int] NULL,
	[UnidadReplicacion] [varchar](15) NULL,
	[IdEpisodioAtencion] [int] NULL,
	[IdPaciente] [int] NULL,
	[EpisodioClinico] [int] NULL,
	[Secuencia] [int] NULL,
	[Estado] [int] NULL,
	[UsuarioCreacion] [char](15) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioModificacion] [char](15) NULL,
	[FechaModificacion] [datetime] NULL,
	[IndicadorRecepcion] [int] NULL,
	[FechaRecepcion] [datetime] NULL,
	[IndicadorProcesado] [int] NULL,
	[FechaProcesado] [datetime] NULL,
	[INDICACIONESPECIFICA] [varchar](500) NULL,
	[TipoOrdenAtencion] [int] NULL,
	[SECUENCIALHCE] [varchar](20) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[SS_IT_SaludRecetaIndicacionesGENIngreso](
	[IdOrdenAtencion] [int] NULL,
	[LineaOrdenAtencionConsulta] [int] NULL,
	[TipoIndicacion] [int] NULL,
	[Descripcion] [varchar](1500) NULL,
	[UnidadReplicacion] [varchar](15) NULL,
	[IdEpisodioAtencion] [int] NULL,
	[IdPaciente] [int] NULL,
	[EpisodioClinico] [int] NULL,
	[Secuencia] [int] NULL,
	[Estado] [int] NULL,
	[UsuarioCreacion] [char](15) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioModificacion] [char](15) NULL,
	[FechaModificacion] [datetime] NULL,
	[IndicadorRecepcion] [int] NULL,
	[FechaRecepcion] [datetime] NULL,
	[IndicadorProcesado] [int] NULL,
	[FechaProcesado] [datetime] NULL
) ON [PRIMARY]
GO



