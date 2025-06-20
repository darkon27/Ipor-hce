
/*  
Object:  Table [dbo].[AC_Sucursal]    
Script Date: 17/01/2017 10:47:44 a.m. 
Autor : Aquiles
*/

CREATE TABLE [dbo].[SY_HCE_MODELODATOS](
	[MODELOID] [int] NOT NULL,
	[VERSIONID] [int] NULL,
	[NOMBRE] [varchar](200) NULL,
	[DESCRIPCION] [varchar](200) NULL,
	[ESTADO] [int] NULL,
 CONSTRAINT [PK_SY_HCE_MODELODATOS] PRIMARY KEY CLUSTERED 
(
	[MODELOID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]



/*TABLA PARA CREAR*/


CREATE TABLE [dbo].[SS_HC_SeguridadCirugia_Pausa_FE](
	[UnidadReplicacion] [char](4) NOT NULL,
	[IdEpisodioAtencion] [bigint] NOT NULL,
	[IdPaciente] [int] NOT NULL,
	[EpisodioClinico] [int] NOT NULL,
	[IdSeguridadPausa] [int] NOT NULL,
	[EquipoProgramado] [char](2) NULL,
	[EquipoConfirmado] [char](2) NULL,
	[EquipoCumplio] [char](2) NULL,
	[AdministradoProfilaxis] [char](2) NULL,
	[Antibiotico] [varchar](25) NULL,
	[Pasos] [char](2) NULL,
	[Operacion] [char](2) NULL,
	[PerdidaSangrePrevista] [char](2) NULL,
	[ProblemaEspecifico] [char](2) NULL,
	[Esterilidad] [char](2) NULL,
	[ProblemasEstirilidad] [char](2) NULL,
	[VisualizaImagenes] [char](2) NULL,
	[UsuarioCreacion] [varchar](25) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioModificacion] [varchar](25) NULL,
	[FechaModificacion] [datetime] NULL,
	[Accion] [varchar](25) NULL,
	[Version] [varchar](25) NULL,
 CONSTRAINT [pk_SS_HC_SeguridadCirugia_Pausa_FE] PRIMARY KEY CLUSTERED 
(
	[UnidadReplicacion] ASC,
	[IdEpisodioAtencion] ASC,
	[IdPaciente] ASC,
	[EpisodioClinico] ASC,
	[IdSeguridadPausa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO




--***************************************
-- PENDIENTE Joel Sebastian 26/01/2017

IF EXISTS (
SELECT * 
FROM SYS.TABLES
WHERE NAME = 'SS_HC_AntecedentesPersonalesFisiologicos_FE'
)

DROP TABLE [dbo].[SS_HC_AntecedentesPersonalesFisiologicos_FE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[SS_HC_AntecedentesPersonalesFisiologicos_FE](
        [UnidadReplicacion] [char](4) NOT NULL,
        [IdEpisodioAtencion] [bigint] NOT NULL,
        [IdPaciente] [int] NOT NULL,
        [EpisodioClinico] [int] NOT NULL,
        [IdSecuencia] [int] NOT NULL,
        [GrupoSanguineo] [varchar](25) NOT NULL,
        [FactorRH] [varchar](25) NULL,
        [AlimentacionA_flag] [char](2) NULL,
        [Alcohol] [char](2) NULL,
        [Alcohol_EspecificarCantidad] [varchar](150) NULL,
        [Tabaco_flag] [char](2) NULL,
        [Tabaco_NroCigarrillos] [varchar](100) NULL,
        [TiempoConsumo] [varchar](100) NULL,
        [Drogas_flag] [char](2) NULL,
        [Drogas_Especificar] [varchar](150) NULL,
        [Cafe_flag] [char](2) NULL,
        [Otros] [varchar](250) NULL,
        [ActividadFisica_flag] [char](2) NULL,
        [ActividadFisica_subflag] [char](2) NULL,
        [ConsumoVerduras_flag] [char](2) NULL,
        [ConsumoVerduras_subflag] [char](2) NULL,
        [ConsumoFrutas_flag] [char](2) NULL,
        [ConsumoFrutas_subflag] [char](2) NULL,
        [InmunizacionesAdultoObservaciones] [text] NULL,
        [Accion] [varchar](25) NULL,
        [Version] [varchar](25) NULL,
        [Estado] [int] NULL,
        [UsuarioCreacion] [varchar](15) NULL,
        [FechaCreacion] [datetime] NULL,
        [UsuarioModificacion] [varchar](15) NULL,
        [FechaModificacion] [datetime] NULL,
 CONSTRAINT [PK_SS_HC_AntecedentesPersonalesFisiologicos_FE] PRIMARY KEY CLUSTERED
(
        [UnidadReplicacion] ASC,
        [IdEpisodioAtencion] ASC,
        [IdPaciente] ASC,
        [EpisodioClinico] ASC,
        [IdSecuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO




/*TABLA PARA CREAR*/
--fecha: 27/01/2017  Nombre:Alan Gastelu  Estado:PENDIENTE


CREATE TABLE [dbo].[SS_HC_Ant_Fisiologico_Pediatrico_FE](
	[UnidadReplicacion] [char](4) NOT NULL,
	[IdEpisodioAtencion] [bigint] NOT NULL,
	[IdPaciente] [int] NOT NULL,
	[EpisodioClinico] [int] NOT NULL,
	[IdAntFiPediatrico] [int] NOT NULL,
	[EdadMaterna] [int] NULL,
	[Paridad_1] [int] NULL,
	[Paridad_2] [int] NULL,
	[Paridad_3] [int] NULL,
	[Paridad_4] [int] NULL,
	[Gravidez] [int] NULL,
	[ControlPrenatal] [int] NULL,
	[Complicaciones] [varchar](100) NULL,
	[TipoParto] [int] NULL,
	[MotivoCesarea] [varchar](100) NULL,
	[LugarNacimiento] [varchar](100) NULL,
	[Peso] [decimal](10, 3) NULL,
	[PesoNR] [int] NULL,
	[Talla] [decimal](10, 3) NULL,
	[TallaNR] [int] NULL,
	[PCNacer] [decimal](10, 3) NULL,
	[PCNacerNR] [int] NULL,
	[APGAR] [int] NULL,
	[Reanimacion] [int] NULL,
	[Lactancia] [int] NULL,
	[InicioAblactansia] [datetime] NULL,
	[AlimentosActuales] [varchar](100) NULL,
	[Vigilancia] [int] NULL,
	[Psicomotor] [int] NULL,
	[DetallarPsicomotor] [varchar](100) NULL,
	[Estado] [int] NULL,
	[UsuarioCreacion] [varchar](100) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioModificacion] [varchar](100) NULL,
	[FechaModificacion] [datetime] NULL,
	[Accion] [varchar](100) NULL,
	[Version] [varchar](100) NULL,
 CONSTRAINT [pk_SS_HC_Ant_Fisiologico_Pediatrico_FE] PRIMARY KEY CLUSTERED 
(
	[UnidadReplicacion] ASC,
	[IdEpisodioAtencion] ASC,
	[IdPaciente] ASC,
	[EpisodioClinico] ASC,
	[IdAntFiPediatrico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[SS_HC_Ant_Fisiologico_Pediatrico_FE]  WITH CHECK ADD  CONSTRAINT [FK_SS_HC_Ant_Fisiologico_Pediatrico_FE] FOREIGN KEY([UnidadReplicacion], [IdPaciente], [EpisodioClinico], [IdEpisodioAtencion])
REFERENCES [dbo].[SS_HC_EpisodioAtencion] ([UnidadReplicacion], [IdPaciente], [EpisodioClinico], [IdEpisodioAtencion])
GO

ALTER TABLE [dbo].[SS_HC_Ant_Fisiologico_Pediatrico_FE] CHECK CONSTRAINT [FK_SS_HC_Ant_Fisiologico_Pediatrico_FE]
GO






/*ALTER TABLE*/
--fecha: 27/01/2017  Nombre:Alan Gastelu  Estado:PENDIENTE

ALTER TABLE [dbo].[SS_HC_EvolucionMedica_FE]
ALTER COLUMN [EvolucionObjetiva] VARCHAR(2000) NOT NULL

--**********************************************************************************


--fecha: 27/01/2017  Nombre:lEONARDO BONILLA  Estado:PUBLICADO
--**********************************************************************************

CREATE TABLE [dbo].SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE(
	[UnidadReplicacion] [char](4) NOT NULL,
	[IdEpisodioAtencion] [bigint] NOT NULL,
	[IdPaciente] [int] NOT NULL,
	[EpisodioClinico] [int] NOT NULL,
	[Secuencia] [int] NOT NULL,
	[OtrasEnfermedades] [varchar](100) NULL,
	[UsuarioCreacion] [varchar](25) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioModificacion] [varchar](25) NULL,
	[FechaModificacion] [datetime] NULL,
	[Accion] [varchar](25) NULL,
	[Version] [varchar](25) NULL,
 CONSTRAINT PK_SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE PRIMARY KEY CLUSTERED 
(
	[UnidadReplicacion] ASC,
	[IdEpisodioAtencion] ASC,
	[IdPaciente] ASC,
	[EpisodioClinico] ASC,
	[Secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[SS_HC_AntecedentesPersonalesIAdulDetalle_FE]  WITH CHECK ADD  CONSTRAINT [FK_SS_HC_AntecedentesPersonalesIAdulDetalleAntecedentesPersonalesIA_FE] FOREIGN KEY([UnidadReplicacion], [IdEpisodioAtencion], [IdPaciente], [EpisodioClinico])
REFERENCES [dbo].[SS_HC_AntecedentesPersonalesIAdul_FE] ([UnidadReplicacion], [IdEpisodioAtencion], [IdPaciente], [EpisodioClinico])
GO

ALTER TABLE [dbo].[SS_HC_AntecedentesPersonalesIAdulDetalle_FE] CHECK CONSTRAINT [FK_SS_HC_AntecedentesPersonalesIAdulDetalleAntecedentesPersonalesIA_FE]
GO

--fecha: 27/01/2017  Nombre:lEONARDO BONILLA  Estado:PUBLICADO
--**********************************************************************************

CREATE TABLE [dbo].[SS_HC_Anam_AP_PatologicosGenerales_FE](
	[UnidadReplicacion] [char](4) NOT NULL,
	[IdEpisodioAtencion] [bigint] NOT NULL,
	[IdPaciente] [int] NOT NULL,
	[EpisodioClinico] [int] NOT NULL,
	[IdPatologicosGenerales] [int] NOT NULL,
	[EnfermedadesAnteriores_rb] [char](1) NULL,
	[HipertensionSeleccion_ckb] [char](1) NULL,
	[HipertensionTiempoenfermedad_list] [char](1) NULL,
	[HipertensionMedicacion_rb] [char](1) NULL,
	[HipertensionMedicacion_txt] [varchar](100) NULL,
	[HipertensionTipoDiagn_list] [char](1) NULL,
	[DiabetesSeleccion_ckb] [char](1) NULL,
	[DiabetesTiempoenfermedad_list] [char](1) NULL,
	[DiabetesMedicacion_rb] [char](1) NULL,
	[DiabetesMedicacion_txt] [varchar](100) NULL,
	[DiabetesTipoDiagn_list] [char](1) NULL,
	[AsmaSeleccion_ckb] [char](1) NULL,
	[AsmaTiempoenfermedad_list] [char](1) NULL,
	[AsmaMedicacion_rb] [char](1) NULL,
	[AsmaMedicacion_txt] [varchar](100) NULL,
	[AsmaTipoDiagn_list] [char](1) NULL,
	[SindromeCSeleccion_ckb] [char](1) NULL,
	[SindromeCTiempoenfermedad_list] [char](1) NULL,
	[SindromeCMedicacion_rb] [char](1) NULL,
	[SindromeCMedicacion_txt] [varchar](100) NULL,
	[SindromeCTipoDiagn_list] [char](1) NULL,
	[SindromeRSeleccion_ckb] [char](1) NULL,
	[SindromeRTiempoenfermedad_list] [char](1) NULL,
	[SindromeRMedicacion_rb] [char](1) NULL,
	[SindromeRMedicacion_txt] [varchar](100) NULL,
	[SindromeRTipoDiagn_list] [char](1) NULL,
	[GastritisSeleccion_ckb] [char](1) NULL,
	[GastritisTiempoenfermedad_list] [char](1) NULL,
	[GastritisMedicacion_rb] [char](1) NULL,
	[GastritisMedicacion_txt] [varchar](100) NULL,
	[GastritisTipoDiagn_list] [char](1) NULL,
	[ArritmiaSeleccion_ckb] [char](1) NULL,
	[ArritmiaTiempoenfermedad_list] [char](1) NULL,
	[ArritmiaMedicacion_rb] [char](1) NULL,
	[ArritmiaMedicacion_txt] [varchar](100) NULL,
	[ArritmiaTipoDiagn_list] [char](1) NULL,
	[HepatitisSeleccion_ckb] [char](1) NULL,
	[HepatitisTiempoenfermedad_list] [char](1) NULL,
	[HepatitisMedicacion_rb] [char](1) NULL,
	[HepatitisMedicacion_txt] [varchar](100) NULL,
	[HepatitisTipoDiagn_list] [char](1) NULL,
	[TuberculosisSeleccion_ckb] [char](1) NULL,
	[TuberculosisTiempoenfermedad_list] [char](1) NULL,
	[TuberculosisMedicacion_rb] [char](1) NULL,
	[TuberculosisMedicacion_txt] [varchar](100) NULL,
	[TuberculosisTipoDiagn_list] [char](1) NULL,
	[HipertiroidismoSeleccion_ckb] [char](1) NULL,
	[HipertiroidismoTiempoenfermedad_list] [char](1) NULL,
	[HipertiroidismoMedicacion_rb] [char](1) NULL,
	[HipertiroidismoMedicacion_txt] [varchar](100) NULL,
	[HipertiroidismoTipoDiagn_list] [char](1) NULL,
	[HipotiroidismoSeleccion_ckb] [char](1) NULL,
	[HipotiroidismoTiempoenfermedad_list] [char](1) NULL,
	[HipotiroidismoMedicacion_rb] [char](1) NULL,
	[HipotiroidismoMedicacion_txt] [varchar](100) NULL,
	[HipotiroidismoTipoDiagn_list] [char](1) NULL,
	[InfeccionSeleccion_ckb] [char](1) NULL,
	[InfeccionTiempoenfermedad_list] [char](1) NULL,
	[InfeccionMedicacion_rb] [char](1) NULL,
	[InfeccionMedicacion_txt] [varchar](100) NULL,
	[InfeccionTipoDiagn_list] [char](1) NULL,
	[CardiopatiasSeleccion_ckb] [char](1) NULL,
	[CardiopatiasTiempoenfermedad_list] [char](1) NULL,
	[CardiopatiasMedicacion_rb] [char](1) NULL,
	[CardiopatiasMedicacion_txt] [varchar](100) NULL,
	[CardiopatiasTipoDiagn_list] [char](1) NULL,
	[EtransmisionSSeleccion_ckb] [char](1) NULL,
	[EtransmisionSTiempoenfermedad_list] [char](1) NULL,
	[EtransmisionSMedicacion_rb] [char](1) NULL,
	[EtransmisionSMedicacion_txt] [varchar](100) NULL,
	[EtransmisionSTipoDiagn_list] [char](1) NULL,
	[DShipoacusiaSeleccion_ckb] [char](1) NULL,
	[DShipoacusiaTiempoenfermedad_list] [char](1) NULL,
	[DShipoacusiaMedicacion_rb] [char](1) NULL,
	[DShipoacusiaMedicacion_txt] [varchar](100) NULL,
	[DShipoacusiaTipoDiagn_list] [char](1) NULL,
	[DScegueraSeleccion_ckb] [char](1) NULL,
	[DScegueraTiempoenfermedad_list] [char](1) NULL,
	[DScegueraMedicacion_rb] [char](1) NULL,
	[DScegueraMedicacion_txt] [varchar](100) NULL,
	[DScegueraTipoDiagn_list] [char](1) NULL,
	[DSSordoMudoSeleccion_ckb] [char](1) NULL,
	[DSSordoMudoTiempoenfermedad_list] [char](1) NULL,
	[DSSordoMudoMedicacion_rb] [char](1) NULL,
	[DSSordoMudoMedicacion_txt] [varchar](100) NULL,
	[DSSordoMudoTipoDiagn_list] [char](1) NULL,
	[DSMiopiaAltaSeleccion_ckb] [char](1) NULL,
	[DSMiopiaAltaTiempoenfermedad_list] [char](1) NULL,
	[DSMiopiaAltaMedicacion_rb] [char](1) NULL,
	[DSMiopiaAltaMedicacion_txt] [varchar](100) NULL,
	[DSMiopiaAltaTipoDiagn_list] [char](1) NULL,
	[CancerSeleccion_ckb] [char](1) NULL,
	[CancerTiempoenfermedad_list] [char](1) NULL,
	[CancerMedicacion_rb] [char](1) NULL,
	[CancerMedicacion_txt] [varchar](100) NULL,
	[CancerTipoDiagn_list] [char](1) NULL,
	[Estado] [int] NULL,
	[UsuarioCreacion] [varchar](25) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioModificacion] [varchar](25) NULL,
	[FechaModificacion] [datetime] NULL,
	[Accion] [varchar](25) NULL,
	[Version] [varchar](25) NULL,
 CONSTRAINT [PK_SS_HC_Anam_AP_PatologicosGenerales_FE] PRIMARY KEY CLUSTERED 
(
	[UnidadReplicacion] ASC,
	[IdEpisodioAtencion] ASC,
	[IdPaciente] ASC,
	[EpisodioClinico] ASC,
	[IdPatologicosGenerales] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[SS_HC_Anam_AP_PatologicosGenerales_FE]  WITH CHECK ADD  CONSTRAINT [FK_SS_HC_Anam_AP_PatologicosGenerales_FE] FOREIGN KEY([UnidadReplicacion], [IdPaciente], [EpisodioClinico], [IdEpisodioAtencion])
REFERENCES [dbo].[SS_HC_EpisodioAtencion] ([UnidadReplicacion], [IdPaciente], [EpisodioClinico], [IdEpisodioAtencion])
GO

ALTER TABLE [dbo].[SS_HC_Anam_AP_PatologicosGenerales_FE] CHECK CONSTRAINT [FK_SS_HC_Anam_AP_PatologicosGenerales_FE]
GO
--**********************************************************************************


--fecha: 30/01/2017  Nombre:lEONARDO BONILLA  Estado:PUBLICADO
--***********************************	inicio ***********************************************
Update [SS_HC_Formato] set 
	[Descripcion] = 'ANTECEDENTES PERSONALES - FISIOLOGICOS FE',
	[DescripcionExtranjera] = 'ANTECEDENTES PERSONALES - FISIOLOGICOS'
where [IdFormato] = 142 and [CodigoFormato] ='CCEP00F3'

INSERT [dbo].[SS_HC_Formato] ([IdFormato], [IdFormatoPadre], [CodigoFormato], [CodigoFormatoPadre], [CadenaRecursividad], [Nivel], [Descripcion], [DescripcionExtranjera], [TipoFormato], [VersionFormatoFijo], [IdFormatoDinamico], [Estado], [UsuarioCreacion], [FechaCreacion], [UsuarioModificacion], [FechaModificacion], [Accion], [Version], [Modulo], [IndCompartido]) 
		VALUES (187, 23, N'CCEPF004', N'CCEP0001       ', NULL, NULL, N'ANTECEDENTES PERSONALES - FISIOLOGICO PEDIATRICO FE', N'ANTECEDENTES PERSONALES - FISIOLOGICO PEDIATRICO FE', 2, NULL, NULL, 2, N'ROYAL', CAST(N'2017-01-20 17:31:28.070' AS DateTime), N'ROYAL', CAST(N'2017-01-20 17:31:28.070' AS DateTime), N'INSERT', NULL, N'HC', NULL)
INSERT [dbo].[SS_HC_Formato] ([IdFormato], [IdFormatoPadre], [CodigoFormato], [CodigoFormatoPadre], [CadenaRecursividad], [Nivel], [Descripcion], [DescripcionExtranjera], [TipoFormato], [VersionFormatoFijo], [IdFormatoDinamico], [Estado], [UsuarioCreacion], [FechaCreacion], [UsuarioModificacion], [FechaModificacion], [Accion], [Version], [Modulo], [IndCompartido]) 
	 VALUES (188, 23, N'CCEPF006', N'CCEP0001       ', NULL, NULL, N'ANTECEDENTES PERSONALES – PATOLOGICOS GENERALES FE', N'ANTECEDENTES PERSONALES – PATOLOGICOS GENERALES FE', 2, NULL, NULL, 2, N'ROYAL', CAST(N'2017-01-20 18:13:42.030' AS DateTime), N'ROYAL', CAST(N'2017-01-20 18:13:42.030' AS DateTime), N'INSERT', NULL, N'HC', NULL)


--***************************************** fin *****************************************
