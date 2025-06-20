
GO
/****** Object:  View [dbo].[V_EpisodioAtencionesALTA]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[V_EpisodioAtencionesALTA]
AS
			  SELECT     PERSONAMAST.Persona,
			  PERSONAMAST.ApellidoPaterno,
			  PERSONAMAST.ApellidoMaterno,
			  PERSONAMAST.Nombres, 
                      PERSONAMAST.NombreCompleto,
					  SS_HC_EpisodioClinico.UnidadReplicacion,
					  SS_HC_EpisodioClinico.IdPaciente, 
                      SS_HC_EpisodioClinico.FechaCierre,
					  (case when SS_HC_EpisodioAtencion.TipoAtencion in (2,3) then SS_HC_Epicrisis_3_Diagnostico.IdEpisodioAtencion else
					  SS_HC_EpisodioAtencion.EpisodioAtencion end) AS Episodio_Atencion, 
                      SS_HC_EpisodioAtencion.FechaRegistro AS FechaReg_EpisoAtencon,
					  SS_HC_EpisodioAtencion.FechaAtencion, 
					  SS_HC_EpisodioAtencion.TipoAtencion, 
                      SS_HC_EpisodioAtencion.IdOrdenAtencion, 
					  SS_HC_EpisodioAtencion.LineaOrdenAtencion, 
					  SS_HC_EpisodioAtencion.TipoOrdenAtencion, 
                      SS_HC_EpisodioAtencion.Estado AS Estado_EpisodioAten,
					  SS_HC_EpisodioAtencion.UsuarioCreacion, 
                      SS_HC_Epicrisis_3_Diagnostico.FechaCreacion, 
                      SS_HC_EpisodioAtencion.UsuarioModificacion,
					  SS_HC_EpisodioAtencion.FechaModificacion,
					  SS_HC_Epicrisis_3_Diagnostico.DiagnosticoDescripcion  AS MotivoConsulta, 
                      SS_HC_EpisodioClinico.FechaRegistro, 
					  SS_HC_Epicrisis_3_Diagnostico.Version Accion,
					  SS_HC_EpisodioAtencion.EpisodioClinico,				
                      (case when SS_HC_EpisodioAtencion.TipoAtencion in (2,3) then SS_HC_Epicrisis_3_Diagnostico.IdEpisodioAtencion else
					  SS_HC_Epicrisis_3_Diagnostico.IdEpisodioAtencion end) as IdEpisodioAtencion ,
					  SS_HC_EpisodioAtencion.UnidadReplicacionEC,
					  SS_HC_EpisodioAtencion.IdEstablecimientoSalud,
					  SS_HC_EpisodioAtencion.IdUnidadServicio, 
                      SS_HC_EpisodioAtencion.IdPersonalSalud,
					  medico.NombreCompleto AS PersonalSaludNombre, 
					  SS_HC_EpisodioAtencion.IdEspecialidad, 
                      SS_GE_Especialidad.Nombre AS especialidadNombre
                      ---AGREGADOS ---                      
                      ,SS_HC_EpisodioClinico.CodigoEpisodioClinico
                      ,SS_HC_EpisodioAtencion.IdEpisodioAtencionCodigo
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.TipoTrabajador
                      ,'000' as TipoTrabajador_Desc
                      ,SS_HC_Epicrisis_3_Diagnostico.IdEpicrisis3 as Id001
                      ,SS_HC_Epicrisis_3_Diagnostico.Secuencia as Id002
                      ,SS_HC_Epicrisis_3_Diagnostico.Codigo as Codigo001
                      ,'000' as Codigo002
                      ,'000'  as Codigo003
                      ,'000' as Codigo004
                      ,SS_HC_Epicrisis_3_Diagnostico.DiagnosticoDescripcion as Descripcion001
                      ,SS_HC_Epicrisis_3_Diagnostico.Version  as Descripcion002
                      ,SS_HC_Epicrisis_3_Diagnostico.DiagnosticoDescripcion as Descripcion003
                      ,isnull(SS_HC_Epicrisis_3_Diagnostico.Version,'')  as Descripcion004
                      ,PERSONAMAST.Documento as Documento_Paciente
                      ,medico.Documento as Documento_Medico
                      --INFO FORMATO
                      ,SS_HC_Formato.CodigoFormato as Formato_Codigo
                      ,isnull(SS_HC_Formato.IdFormato,0) as Formato_Id
                      ,isnull(SS_HC_Formato.TipoFormato,0) as Formato_Tipo
                      ,isnull(SS_HC_Formato.IndCompartido,0) as Formato_Uso
                      ,SS_HC_Formato.Descripcion as Formato_Descripcion    
                      ,0 as contador_filas                      
			FROM         PERSONAMAST  WITH(NOLOCK) 
					INNER JOIN SS_HC_EpisodioClinico  WITH(NOLOCK) 
					INNER JOIN SS_GE_Paciente  WITH(NOLOCK) ON SS_HC_EpisodioClinico.IdPaciente = SS_GE_Paciente.IdPaciente 
					INNER JOIN SS_HC_EpisodioAtencion  WITH(NOLOCK) ON SS_HC_EpisodioClinico.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacionEC AND 
                      SS_HC_EpisodioClinico.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND 
                      SS_HC_EpisodioClinico.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico ON 
                      PERSONAMAST.Persona = SS_GE_Paciente.IdPaciente 
                    INNER JOIN   SS_HC_Epicrisis_3_Diagnostico   WITH(NOLOCK) ON SS_HC_EpisodioAtencion.UnidadReplicacion = SS_HC_Epicrisis_3_Diagnostico.UnidadReplicacion AND 
                    (case when  SS_HC_EpisodioAtencion.TipoAtencion in (2,3)
							then dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion
							else dbo.SS_HC_EpisodioAtencion.EpisodioAtencion  end) =  (case when  SS_HC_EpisodioAtencion.TipoAtencion in (2,3)
							then dbo.SS_HC_Epicrisis_3_Diagnostico.IdEpisodioAtencion
							else dbo.SS_HC_EpisodioAtencion.EpisodioAtencion  end)  AND 
                      SS_HC_EpisodioAtencion.IdPaciente = SS_HC_Epicrisis_3_Diagnostico.IdPaciente AND 
                      SS_HC_EpisodioAtencion.EpisodioClinico = SS_HC_Epicrisis_3_Diagnostico.EpisodioClinico 
                    LEFT OUTER JOIN  SS_GE_Especialidad  WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad 
					LEFT OUTER JOIN  PERSONAMAST AS medico  WITH(NOLOCK) ON medico.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
                      ----------------
                    INNER JOIN SS_HC_Formato on (SS_HC_Formato.CodigoFormato = 'CCEPF200')  

GO
/****** Object:  View [dbo].[v_SS_GE_EMPRESASEGURO]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE OR ALTER VIEW [dbo].[v_SS_GE_EMPRESASEGURO] 
 AS
 SELECT*FROM SS_GE_EMPRESASEGURO
GO
/****** Object:  View [dbo].[VW_ATENCIONPACIENTE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[VW_ATENCIONPACIENTE]  
AS  
SELECT     SS_HC_EpisodioAtencion.UnidadReplicacion, SS_HC_EpisodioAtencion.IdEpisodioAtencion, SS_HC_EpisodioAtencion.UnidadReplicacionEC,   
                      SS_HC_EpisodioAtencion.IdPaciente, SS_HC_EpisodioAtencion.EpisodioClinico, SS_HC_EpisodioAtencion.EpisodioAtencion,   
                      SS_HC_EpisodioAtencion.IdEstablecimientoSalud, SS_HC_EpisodioAtencion.IdUnidadServicio, SS_HC_EpisodioAtencion.IdPersonalSalud,   
                      SS_HC_EpisodioAtencion.FechaRegistro, SS_HC_EpisodioAtencion.FechaAtencion, SS_HC_EpisodioAtencion.TipoAtencion,   
                      SS_HC_EpisodioAtencion.IdOrdenAtencion, SS_HC_EpisodioAtencion.LineaOrdenAtencion, SS_HC_EpisodioAtencion.TipoOrdenAtencion,   
                      SS_HC_EpisodioAtencion.UsuarioCreacion, SS_HC_EpisodioAtencion.FechaCreacion, SS_HC_EpisodioAtencion.UsuarioModificacion,   
                      SS_HC_EpisodioAtencion.FechaModificacion, SS_HC_EpisodioAtencion.IdEspecialidad, SS_HC_EpisodioAtencion.CodigoOA,   
                      SS_HC_EpisodioAtencion.ProximaAtencionFlag, SS_HC_EpisodioAtencion.IdEpisodioAtencionCodigo AS IdEspecialidadProxima,   
                      SS_HC_EpisodioAtencion.IdEstablecimientoSaludProxima, SS_HC_EpisodioAtencion.IdTipoInterConsulta, SS_HC_EpisodioAtencion.IdTipoReferencia,   
                      SS_HC_EpisodioAtencion.ObservacionProxima, SS_HC_EpisodioAtencion.TipoTrabajador as DescansoMedico, SS_HC_EpisodioAtencion.DiasDescansoMedico,   
                      SS_HC_EpisodioAtencion.FechaInicioDescansoMedico,  
					  SS_HC_EpisodioAtencion.FechaFirma as FechaFinDescansoMedico,  --OBS*** AUX para fecha firma add 2017-08
					  -- SS_HC_EpisodioAtencion.FechaFinDescansoMedico, 
					  SS_HC_EpisodioAtencion.FechaOrden,   
                      SS_HC_EpisodioAtencion.IdProcedimiento, SS_HC_EpisodioAtencion.ObservacionOrden, SS_HC_EpisodioAtencion.IdTipoOrden,   
                      SS_HC_EpisodioAtencion.Accion, SS_HC_EpisodioAtencion.Version, SS_HC_EpisodioClinico.FechaRegistro AS FechaRegistroEpiClinico,   
                      SS_HC_EpisodioClinico.FechaCierre AS FechaCierreEpiClinico, SS_GE_Paciente.TipoPaciente, SS_GE_Paciente.Edad, SS_GE_Paciente.Raza,   
                      SS_GE_Paciente.Religion, SS_GE_Paciente.Cargo, SS_GE_Paciente.AreaLaboral, SS_GE_Paciente.Ocupacion, SS_GE_Paciente.CodigoHC,   
                      SS_GE_Paciente.CodigoHCAnterior, SS_GE_Paciente.CodigoHCSecundario, SS_GE_Paciente.TipoAlmacenamiento, SS_GE_Paciente.TipoHistoria,   
                      SS_GE_Paciente.TipoSituacion, SS_HC_EpisodioAtencion.IdUbicacion, SS_GE_Paciente.LugarProcedencia, SS_GE_Paciente.RutaFoto,   
                      SS_GE_Paciente.FechaIngreso, SS_GE_Paciente.IndicadorNuevo, SS_GE_Paciente.Estado AS EstadoPaciente, SS_GE_Paciente.NumeroFile,   
                      SS_GE_Paciente.Servicio, SS_GE_Paciente.UsuarioAlmacenamiento, SS_GE_Paciente.FechaAlmacenamiento, SS_GE_Paciente.Observacion,   
                      SS_GE_Paciente.IndicadorAsistencia, SS_GE_Paciente.CantidadAsistencia, SS_GE_Paciente.UbicacionHHCC,   
                      SS_GE_Paciente.IndicadorMigradoSiteds, SS_GE_Paciente.NumeroCaja, SS_GE_Paciente.IndicadorCodigoBarras,   
                      SS_GE_Paciente.IDPACIENTE_OK, SS_GE_Paciente.CodigoAsegurado, SS_GE_Paciente.NumeroPoliza, SS_GE_Paciente.CodigoProducto,   
                      SS_GE_Paciente.CodigoPlan, SS_GE_Paciente.TipoParentesco, SS_GE_Paciente.CodigoBeneficio, SS_GE_Paciente.Situacion,   
                      SS_GE_Paciente.TomoActual, SS_GE_Paciente.IndicadorHistoriaFisica, SS_GE_Paciente.DescripcionHistoria, SS_GE_Paciente.NumeroCertificado,   
                      PERSONAMAST.Persona, PERSONAMAST.Origen, PERSONAMAST.ApellidoPaterno, PERSONAMAST.ApellidoMaterno,   
					  PERSONAMAST.NombreCompleto, PERSONAMAST.TipoDocumento, PERSONAMAST.Documento, PERSONAMAST.CodigoBarras,   
                      PERSONAMAST.EsCliente, PERSONAMAST.EsProveedor, PERSONAMAST.EsEmpleado, PERSONAMAST.EsOtro, PERSONAMAST.TipoPersona,   
                      PERSONAMAST.FechaNacimiento, PERSONAMAST.Sexo, PERSONAMAST.CiudadNacimiento, PERSONAMAST.Nacionalidad,   
                      PERSONAMAST.EstadoCivil, PERSONAMAST.NivelInstruccion, PERSONAMAST.Direccion, PERSONAMAST.CodigoPostal,   
                      PERSONAMAST.Provincia, PERSONAMAST.Departamento, PERSONAMAST.Telefono, PERSONAMAST.Fax, PERSONAMAST.DocumentoFiscal,   
                      PERSONAMAST.DocumentoIdentidad, PERSONAMAST.CarnetExtranjeria, PERSONAMAST.DocumentoMilitarFA, PERSONAMAST.TipoBrevete,   
                      PERSONAMAST.Brevete, PERSONAMAST.Pasaporte, MEDICO.NombreCompleto  NombreEmergencia, PERSONAMAST.DireccionEmergencia,   
                      PERSONAMAST.TelefonoEmergencia, PERSONAMAST.PersonaAnt, PERSONAMAST.CorreoElectronico, PERSONAMAST.EnfermedadGraveFlag,   
                      PERSONAMAST.IngresoFechaRegistro, PERSONAMAST.IngresoAplicacionCodigo, PERSONAMAST.IngresoUsuario, PERSONAMAST.Celular,   
                      PERSONAMAST.ParentescoEmergencia, PERSONAMAST.CelularEmergencia, PERSONAMAST.LugarNacimiento,   
                      PERSONAMAST.SuspensionFonaviFlag, PERSONAMAST.FlagRepetido, PERSONAMAST.CodDiscamec, PERSONAMAST.FecIniDiscamec,   
                      PERSONAMAST.FecFinDiscamec, PERSONAMAST.Pais, PERSONAMAST.EsPaciente, PERSONAMAST.EsEmpresa, PERSONAMAST.Persona_Old,   
                      PERSONAMAST.personanew, PERSONAMAST.Estado AS EstadoPersona, SS_HC_EpisodioAtencion.Estado,   
                      SS_HC_AsignacionMedico.IdAsignacionMedico, SS_HC_AsignacionMedico.TipoAsignacion,   
                      SS_HC_AsignacionMedico.Observaciones AS ObservacionesAsigMed, SS_HC_AsignacionMedico.Estado AS EstadoAsigMed,   
                      SS_HC_EpisodioClinico.Estado AS EstadoEpiClinico, SS_HC_EpisodioAtencion.IdUbicacion AS SecAsigMed,   
                      SS_HC_AsignacionMedico.SecuenciaReferida AS SecReferidaAsigMed  
FROM    PERSONAMAST   
        INNER JOIN    SS_GE_Paciente			 WITH(NOLOCK) ON PERSONAMAST.Persona = SS_GE_Paciente.IdPaciente   
        LEFT JOIN     SS_HC_EpisodioAtencion	 WITH(NOLOCK) ON     SS_GE_Paciente.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente   
        LEFT JOIN     SS_HC_EpisodioClinico		 WITH(NOLOCK) ON SS_HC_EpisodioAtencion.UnidadReplicacionEC = SS_HC_EpisodioClinico.UnidadReplicacion AND   
                      SS_HC_EpisodioAtencion.IdPaciente = SS_HC_EpisodioClinico.IdPaciente AND   
                      SS_HC_EpisodioAtencion.EpisodioClinico = SS_HC_EpisodioClinico.EpisodioClinico   
        LEFT JOIN     PERSONAMAST MEDICO		 WITH(NOLOCK) ON SS_HC_EpisodioAtencion.IdPersonalSalud = MEDICO.Persona   
        LEFT  JOIN    SS_HC_AsignacionMedico	 WITH(NOLOCK) ON SS_HC_AsignacionMedico.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente  

GO
/****** Object:  View [dbo].[VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[VW_ATENCIONPACIENTE_DISPENSACION_MEDICAMENTOS]  
AS  

SELECT     dbo.SS_HC_EpisodioAtencion.UnidadReplicacion, dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion, dbo.SS_HC_EpisodioAtencion.UnidadReplicacionEC,   
                      dbo.SS_HC_EpisodioAtencion.IdPaciente, dbo.SS_HC_EpisodioAtencion.EpisodioClinico, dbo.SS_HC_EpisodioAtencion.EpisodioAtencion,   
                      dbo.SS_HC_EpisodioAtencion.IdEstablecimientoSalud, dbo.SS_HC_EpisodioAtencion.IdUnidadServicio, dbo.SS_HC_EpisodioAtencion.IdPersonalSalud,   
                      dbo.SS_HC_EpisodioAtencion.FechaRegistro, dbo.SS_FA_SolicitudProductoDetalle.FechaCreacion as FechaAtencion, dbo.SS_HC_EpisodioAtencion.TipoAtencion,   
                      dbo.SS_HC_EpisodioAtencion.IdOrdenAtencion, dbo.SS_HC_EpisodioAtencion.LineaOrdenAtencion, dbo.SS_HC_EpisodioAtencion.TipoOrdenAtencion,   
                      dbo.SS_HC_EpisodioAtencion.UsuarioCreacion, dbo.SS_HC_EpisodioAtencion.FechaCreacion, dbo.SS_HC_EpisodioAtencion.UsuarioModificacion,   
                      dbo.SS_HC_EpisodioAtencion.FechaModificacion, dbo.SS_HC_EpisodioAtencion.IdEspecialidad, dbo.SS_HC_EpisodioAtencion.CodigoOA,   
                      dbo.SS_HC_EpisodioAtencion.ProximaAtencionFlag, dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencionCodigo AS IdEspecialidadProxima,   
                      dbo.SS_HC_EpisodioAtencion.IdEstablecimientoSaludProxima, dbo.SS_HC_EpisodioAtencion.IdTipoInterConsulta, dbo.SS_HC_EpisodioAtencion.IdTipoReferencia,   
                      SS_FA_SolicitudProductoDetalle.Medicamento AS ObservacionProxima, dbo.SS_HC_EpisodioAtencion.DescansoMedico, dbo.SS_HC_EpisodioAtencion.DiasDescansoMedico,   
                      dbo.SS_HC_EpisodioAtencion.FechaInicioDescansoMedico,  
					  dbo.SS_HC_EpisodioAtencion.FechaFirma as FechaFinDescansoMedico,  --OBS*** AUX para fecha firma add 2017-08
					  dbo.SS_HC_EpisodioAtencion.FechaOrden,   
                      dbo.SS_HC_EpisodioAtencion.IdProcedimiento, dbo.SS_HC_EpisodioAtencion.ObservacionOrden, dbo.SS_HC_EpisodioAtencion.IdTipoOrden,   
                      dbo.SS_HC_EpisodioAtencion.Accion, dbo.SS_HC_EpisodioAtencion.Version, dbo.SS_HC_EpisodioClinico.FechaRegistro AS FechaRegistroEpiClinico,   
                      dbo.SS_HC_EpisodioClinico.FechaCierre AS FechaCierreEpiClinico, dbo.SS_GE_Paciente.TipoPaciente, dbo.SS_GE_Paciente.Edad, dbo.SS_GE_Paciente.Raza,   
                      dbo.SS_GE_Paciente.Religion, dbo.SS_GE_Paciente.Cargo, dbo.SS_GE_Paciente.AreaLaboral, dbo.SS_GE_Paciente.Ocupacion, dbo.SS_GE_Paciente.CodigoHC,   
                      dbo.SS_GE_Paciente.CodigoHCAnterior, dbo.SS_GE_Paciente.CodigoHCSecundario, dbo.SS_GE_Paciente.TipoAlmacenamiento, dbo.SS_GE_Paciente.TipoHistoria,   
                      dbo.SS_GE_Paciente.TipoSituacion, dbo.SS_HC_EpisodioAtencion.IdUbicacion, dbo.SS_GE_Paciente.LugarProcedencia, dbo.SS_GE_Paciente.RutaFoto,   
                      dbo.SS_GE_Paciente.FechaIngreso, dbo.SS_GE_Paciente.IndicadorNuevo, dbo.SS_GE_Paciente.Estado AS EstadoPaciente, dbo.SS_GE_Paciente.NumeroFile,   
                      dbo.SS_GE_Paciente.Servicio, dbo.SS_GE_Paciente.UsuarioAlmacenamiento, dbo.SS_GE_Paciente.FechaAlmacenamiento, dbo.SS_GE_Paciente.Observacion,   
                      dbo.SS_GE_Paciente.IndicadorAsistencia, dbo.SS_GE_Paciente.CantidadAsistencia, dbo.SS_GE_Paciente.UbicacionHHCC,   
                      dbo.SS_GE_Paciente.IndicadorMigradoSiteds, dbo.SS_GE_Paciente.NumeroCaja, dbo.SS_GE_Paciente.IndicadorCodigoBarras,   
                      dbo.SS_GE_Paciente.IDPACIENTE_OK, dbo.SS_GE_Paciente.CodigoAsegurado, dbo.SS_GE_Paciente.NumeroPoliza, dbo.SS_GE_Paciente.CodigoProducto,   
                      dbo.SS_GE_Paciente.CodigoPlan, dbo.SS_GE_Paciente.TipoParentesco, dbo.SS_GE_Paciente.CodigoBeneficio, dbo.SS_GE_Paciente.Situacion,   
                      dbo.SS_GE_Paciente.TomoActual, dbo.SS_GE_Paciente.IndicadorHistoriaFisica, dbo.SS_GE_Paciente.DescripcionHistoria, dbo.SS_GE_Paciente.NumeroCertificado,   
                      dbo.PERSONAMAST.Persona, dbo.PERSONAMAST.Origen, dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno,   
                dbo.PERSONAMAST.NombreCompleto, dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.CodigoBarras,   
                      dbo.PERSONAMAST.EsCliente, dbo.PERSONAMAST.EsProveedor, dbo.PERSONAMAST.EsEmpleado, dbo.PERSONAMAST.EsOtro, dbo.PERSONAMAST.TipoPersona,   
                      dbo.PERSONAMAST.FechaNacimiento, dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.CiudadNacimiento, dbo.PERSONAMAST.Nacionalidad,   
                      dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.NivelInstruccion, dbo.PERSONAMAST.Direccion, dbo.PERSONAMAST.CodigoPostal,   
                      dbo.PERSONAMAST.Provincia, dbo.PERSONAMAST.Departamento, dbo.PERSONAMAST.Telefono, dbo.PERSONAMAST.Fax, dbo.PERSONAMAST.DocumentoFiscal,   
                      dbo.PERSONAMAST.DocumentoIdentidad, dbo.PERSONAMAST.CarnetExtranjeria, dbo.PERSONAMAST.DocumentoMilitarFA, dbo.PERSONAMAST.TipoBrevete,   
                      dbo.PERSONAMAST.Brevete, dbo.PERSONAMAST.Pasaporte, dbo.PERSONAMAST.NombreEmergencia, dbo.PERSONAMAST.DireccionEmergencia,   
                      dbo.PERSONAMAST.TelefonoEmergencia, dbo.PERSONAMAST.PersonaAnt, dbo.PERSONAMAST.CorreoElectronico, dbo.PERSONAMAST.EnfermedadGraveFlag,   
                      dbo.PERSONAMAST.IngresoFechaRegistro, dbo.PERSONAMAST.IngresoAplicacionCodigo, dbo.PERSONAMAST.IngresoUsuario, dbo.PERSONAMAST.Celular,   
                      dbo.PERSONAMAST.ParentescoEmergencia, dbo.SS_FA_SolicitudProductoDetalle.SecuencialHCE as "celularemergencia", dbo.PERSONAMAST.LugarNacimiento,   
                      dbo.PERSONAMAST.SuspensionFonaviFlag, dbo.PERSONAMAST.FlagRepetido, dbo.PERSONAMAST.CodDiscamec, dbo.PERSONAMAST.FecIniDiscamec,   
                      dbo.PERSONAMAST.FecFinDiscamec, dbo.PERSONAMAST.Pais, dbo.PERSONAMAST.EsPaciente, dbo.PERSONAMAST.EsEmpresa, dbo.PERSONAMAST.Persona_Old,   
                      dbo.PERSONAMAST.personanew, dbo.PERSONAMAST.Estado AS EstadoPersona, dbo.SS_HC_EpisodioAtencion.Estado,   
                      Convert(INTEGER,dbo.SS_FA_SolicitudProductoDetalle.Cantidad) as  IdAsignacionMedico, Convert(INTEGER,dbo.SS_FA_SolicitudProductoDetalle.IdOrdenAtencion) as TipoAsignacion,   
                      dbo.SS_HC_AsignacionMedico.Observaciones AS ObservacionesAsigMed, dbo.SS_HC_AsignacionMedico.Estado AS EstadoAsigMed,   
                      dbo.SS_HC_EpisodioClinico.Estado AS EstadoEpiClinico, dbo.SS_HC_AsignacionMedico.Secuencia AS SecAsigMed,   
                      dbo.SS_HC_AsignacionMedico.SecuenciaReferida AS SecReferidaAsigMed  
FROM     dbo.PERSONAMAST    WITH(NOLOCK) 
        INNER JOIN   SS_GE_Paciente  WITH(NOLOCK) ON dbo.PERSONAMAST.Persona = dbo.SS_GE_Paciente.IdPaciente   
        left join  SS_HC_EpisodioAtencion  WITH(NOLOCK) on  
                       dbo.SS_GE_Paciente.IdPaciente = dbo.SS_HC_EpisodioAtencion.IdPaciente   
		LEFT JOIN SS_FA_SolicitudProductoDetalle  WITH(NOLOCK) ON SS_FA_SolicitudProductoDetalle.IdPaciente=dbo.SS_HC_EpisodioAtencion.IdPaciente  
					   and SS_FA_SolicitudProductoDetalle.EpisodioClinico= SS_HC_EpisodioAtencion.EpisodioClinico
					   and SS_FA_SolicitudProductoDetalle.IdEpisodioAtencion= SS_HC_EpisodioAtencion.IdEpisodioAtencion
        left JOIN   SS_HC_EpisodioClinico  WITH(NOLOCK) ON dbo.SS_HC_EpisodioAtencion.UnidadReplicacionEC = dbo.SS_HC_EpisodioClinico.UnidadReplicacion AND   
                      dbo.SS_HC_EpisodioAtencion.IdPaciente = dbo.SS_HC_EpisodioClinico.IdPaciente AND   
                      dbo.SS_HC_EpisodioAtencion.EpisodioClinico = dbo.SS_HC_EpisodioClinico.EpisodioClinico   
       LEFT OUTER JOIN   SS_HC_AsignacionMedico  WITH(NOLOCK) ON dbo.SS_HC_AsignacionMedico.IdPaciente = dbo.SS_HC_EpisodioAtencion.IdPaciente  


GO
/****** Object:  View [dbo].[VW_ATENCIONPACIENTE_EVOLUCION_MEDICA]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[VW_ATENCIONPACIENTE_EVOLUCION_MEDICA]  
AS  

		SELECT     dbo.SS_HC_EpisodioAtencion.UnidadReplicacion, dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion, dbo.SS_HC_EpisodioAtencion.UnidadReplicacionEC,   
                      dbo.SS_HC_EpisodioAtencion.IdPaciente, dbo.SS_HC_EpisodioAtencion.EpisodioClinico, dbo.SS_HC_EpisodioAtencion.EpisodioAtencion,   
                      dbo.SS_HC_EpisodioAtencion.IdEstablecimientoSalud, dbo.SS_HC_EpisodioAtencion.IdUnidadServicio, dbo.SS_HC_EpisodioAtencion.IdPersonalSalud,   
                      dbo.SS_HC_EpisodioAtencion.FechaRegistro, dbo.SS_HC_EpisodioAtencion.FechaAtencion, dbo.SS_HC_EpisodioAtencion.TipoAtencion,   
                      dbo.SS_HC_EpisodioAtencion.IdOrdenAtencion, dbo.SS_HC_EpisodioAtencion.LineaOrdenAtencion, dbo.SS_HC_EpisodioAtencion.TipoOrdenAtencion,   
                      dbo.SS_HC_EpisodioAtencion.UsuarioCreacion, dbo.SS_HC_EpisodioAtencion.FechaCreacion, dbo.SS_HC_EpisodioAtencion.UsuarioModificacion,   
                      dbo.SS_HC_EpisodioAtencion.FechaModificacion, dbo.SS_HC_EpisodioAtencion.IdEspecialidad, dbo.SS_HC_EpisodioAtencion.CodigoOA,   
                      dbo.SS_HC_EpisodioAtencion.ProximaAtencionFlag, dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencionCodigo AS IdEspecialidadProxima,   
                      dbo.SS_HC_EpisodioAtencion.IdEstablecimientoSaludProxima, dbo.SS_HC_EpisodioAtencion.IdTipoInterConsulta, dbo.SS_HC_EpisodioAtencion.IdTipoReferencia,   
                      SS_HC_EvolucionMedica_FE.EvolucionObjetiva AS ObservacionProxima, dbo.SS_HC_EpisodioAtencion.DescansoMedico, dbo.SS_HC_EpisodioAtencion.DiasDescansoMedico,   
                      dbo.SS_HC_EpisodioAtencion.FechaInicioDescansoMedico,  
					  dbo.SS_HC_EpisodioAtencion.FechaFirma as FechaFinDescansoMedico,  --OBS*** AUX para fecha firma add 2017-08
					  -- dbo.SS_HC_EpisodioAtencion.FechaFinDescansoMedico, 
					  dbo.SS_HC_EpisodioAtencion.FechaOrden,   
                      dbo.SS_HC_EpisodioAtencion.IdProcedimiento, dbo.SS_HC_EpisodioAtencion.ObservacionOrden, dbo.SS_HC_EpisodioAtencion.IdTipoOrden,   
                      dbo.SS_HC_EpisodioAtencion.Accion, dbo.SS_HC_EpisodioAtencion.Version, dbo.SS_HC_EpisodioClinico.FechaRegistro AS FechaRegistroEpiClinico,   
                      dbo.SS_HC_EpisodioClinico.FechaCierre AS FechaCierreEpiClinico, dbo.SS_GE_Paciente.TipoPaciente, dbo.SS_GE_Paciente.Edad, dbo.SS_GE_Paciente.Raza,   
                      dbo.SS_GE_Paciente.Religion, dbo.SS_GE_Paciente.Cargo, dbo.SS_GE_Paciente.AreaLaboral, dbo.SS_GE_Paciente.Ocupacion, dbo.SS_GE_Paciente.CodigoHC,   
                      dbo.SS_GE_Paciente.CodigoHCAnterior, dbo.SS_GE_Paciente.CodigoHCSecundario, dbo.SS_GE_Paciente.TipoAlmacenamiento, dbo.SS_GE_Paciente.TipoHistoria,   
                      dbo.SS_GE_Paciente.TipoSituacion, dbo.SS_HC_EpisodioAtencion.IdUbicacion, dbo.SS_GE_Paciente.LugarProcedencia, dbo.SS_GE_Paciente.RutaFoto,   
                      dbo.SS_GE_Paciente.FechaIngreso, dbo.SS_GE_Paciente.IndicadorNuevo, dbo.SS_GE_Paciente.Estado AS EstadoPaciente, dbo.SS_GE_Paciente.NumeroFile,   
                      dbo.SS_GE_Paciente.Servicio, dbo.SS_GE_Paciente.UsuarioAlmacenamiento, dbo.SS_GE_Paciente.FechaAlmacenamiento, dbo.SS_GE_Paciente.Observacion,   
                      dbo.SS_GE_Paciente.IndicadorAsistencia, dbo.SS_GE_Paciente.CantidadAsistencia, dbo.SS_GE_Paciente.UbicacionHHCC,   
                      dbo.SS_GE_Paciente.IndicadorMigradoSiteds, dbo.SS_GE_Paciente.NumeroCaja, dbo.SS_GE_Paciente.IndicadorCodigoBarras,   
                      dbo.SS_GE_Paciente.IDPACIENTE_OK, dbo.SS_GE_Paciente.CodigoAsegurado, dbo.SS_GE_Paciente.NumeroPoliza, dbo.SS_GE_Paciente.CodigoProducto,   
                      dbo.SS_GE_Paciente.CodigoPlan, dbo.SS_GE_Paciente.TipoParentesco, dbo.SS_GE_Paciente.CodigoBeneficio, dbo.SS_GE_Paciente.Situacion,   
                      dbo.SS_GE_Paciente.TomoActual, dbo.SS_GE_Paciente.IndicadorHistoriaFisica, dbo.SS_GE_Paciente.DescripcionHistoria, dbo.SS_GE_Paciente.NumeroCertificado,   
                      dbo.PERSONAMAST.Persona, dbo.PERSONAMAST.Origen, dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno,   
                dbo.PERSONAMAST.NombreCompleto, dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.CodigoBarras,   
                      dbo.PERSONAMAST.EsCliente, dbo.PERSONAMAST.EsProveedor, dbo.PERSONAMAST.EsEmpleado, dbo.PERSONAMAST.EsOtro, dbo.PERSONAMAST.TipoPersona,   
                      dbo.PERSONAMAST.FechaNacimiento, dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.CiudadNacimiento, dbo.PERSONAMAST.Nacionalidad,   
                      dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.NivelInstruccion, dbo.PERSONAMAST.Direccion, dbo.PERSONAMAST.CodigoPostal,   
                      dbo.PERSONAMAST.Provincia, dbo.PERSONAMAST.Departamento, dbo.PERSONAMAST.Telefono, dbo.PERSONAMAST.Fax, dbo.PERSONAMAST.DocumentoFiscal,   
                      dbo.PERSONAMAST.DocumentoIdentidad, dbo.PERSONAMAST.CarnetExtranjeria, dbo.PERSONAMAST.DocumentoMilitarFA, dbo.PERSONAMAST.TipoBrevete,   
                      dbo.PERSONAMAST.Brevete, dbo.PERSONAMAST.Pasaporte, dbo.PERSONAMAST.NombreEmergencia, dbo.PERSONAMAST.DireccionEmergencia,   
                      dbo.PERSONAMAST.TelefonoEmergencia, dbo.PERSONAMAST.PersonaAnt, dbo.PERSONAMAST.CorreoElectronico, dbo.PERSONAMAST.EnfermedadGraveFlag,   
                      dbo.PERSONAMAST.IngresoFechaRegistro, dbo.PERSONAMAST.IngresoAplicacionCodigo, dbo.PERSONAMAST.IngresoUsuario, dbo.PERSONAMAST.Celular,   
                      dbo.PERSONAMAST.ParentescoEmergencia, dbo.PERSONAMAST.CelularEmergencia, dbo.PERSONAMAST.LugarNacimiento,   
                      dbo.PERSONAMAST.SuspensionFonaviFlag, dbo.PERSONAMAST.FlagRepetido, dbo.PERSONAMAST.CodDiscamec, dbo.PERSONAMAST.FecIniDiscamec,   
                      dbo.PERSONAMAST.FecFinDiscamec, dbo.PERSONAMAST.Pais, dbo.PERSONAMAST.EsPaciente, dbo.PERSONAMAST.EsEmpresa, dbo.PERSONAMAST.Persona_Old,   
                      dbo.PERSONAMAST.personanew, dbo.PERSONAMAST.Estado AS EstadoPersona, dbo.SS_HC_EpisodioAtencion.Estado,   
                      dbo.SS_HC_AsignacionMedico.IdAsignacionMedico, dbo.SS_HC_AsignacionMedico.TipoAsignacion,   
                      dbo.SS_HC_AsignacionMedico.Observaciones AS ObservacionesAsigMed, dbo.SS_HC_AsignacionMedico.Estado AS EstadoAsigMed,   
                      dbo.SS_HC_EpisodioClinico.Estado AS EstadoEpiClinico, dbo.SS_HC_AsignacionMedico.Secuencia AS SecAsigMed,   
                      dbo.SS_HC_AsignacionMedico.SecuenciaReferida AS SecReferidaAsigMed  
FROM     dbo.PERSONAMAST    WITH(NOLOCK) 
       LEFT JOIN     SS_GE_Paciente  WITH(NOLOCK) ON dbo.PERSONAMAST.Persona = dbo.SS_GE_Paciente.IdPaciente   
       left join     SS_HC_EpisodioAtencion  WITH(NOLOCK) on  
                       dbo.SS_GE_Paciente.IdPaciente = dbo.SS_HC_EpisodioAtencion.IdPaciente   
	   LEFT JOIN     SS_HC_EvolucionMedica_FE WITH(NOLOCK) 
					   ON SS_HC_EvolucionMedica_FE.IdPaciente=dbo.SS_HC_EpisodioAtencion.IdPaciente and
					   SS_HC_EvolucionMedica_FE.EpisodioClinico=SS_HC_EpisodioAtencion.EpisodioClinico
					   AND SS_HC_EvolucionMedica_FE.IdEpisodioAtencion=SS_HC_EpisodioAtencion.IdEpisodioAtencion
       left JOIN     SS_HC_EpisodioClinico  WITH(NOLOCK) ON dbo.SS_HC_EpisodioAtencion.UnidadReplicacionEC 
					  = dbo.SS_HC_EpisodioClinico.UnidadReplicacion AND   
                      dbo.SS_HC_EpisodioAtencion.IdPaciente = dbo.SS_HC_EpisodioClinico.IdPaciente AND   
                      dbo.SS_HC_EpisodioAtencion.EpisodioClinico = dbo.SS_HC_EpisodioClinico.EpisodioClinico 
					  AND  dbo.SS_HC_EpisodioAtencion.IdOrdenAtencion= dbo.SS_HC_EpisodioClinico.IdOrdenAtencion 
       LEFT  JOIN    SS_HC_AsignacionMedico  WITH(NOLOCK) ON dbo.SS_HC_AsignacionMedico.IdPaciente = dbo.SS_HC_EpisodioAtencion.IdPaciente  
GO
/****** Object:  View [dbo].[VW_ATENCIONPACIENTE_GENERAL]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	
CREATE OR ALTER VIEW [dbo].[VW_ATENCIONPACIENTE_GENERAL]
AS

select 
VW_GENERAL_ATENCIONES.* ,
SS_HC_EpisodioClinico.FechaCierre as FechaCierreEpiClinico,
SS_HC_EpisodioClinico.Estado as EstadoEpiClinico,
SS_HC_EpisodioAtencion.UnidadReplicacion,
SS_HC_EpisodioAtencion.UnidadReplicacionEC,
SS_HC_EpisodioAtencion.IdEpisodioAtencion,
SS_HC_EpisodioAtencion.EpisodioClinico,
SS_HC_EpisodioAtencion.IdEstablecimientoSalud,
SS_HC_EpisodioAtencion.IdUnidadServicio,
SS_HC_EpisodioAtencion.IdPersonalSalud,
SS_HC_EpisodioAtencion.EpisodioAtencion,
SS_HC_EpisodioAtencion.FechaRegistro,
SS_HC_EpisodioAtencion.FechaAtencion,
SS_HC_EpisodioAtencion.Estado as EstadoEpiAtencion,
SS_HC_EpisodioAtencion.UsuarioCreacion ,
SS_HC_EpisodioAtencion.UsuarioModificacion,
SS_HC_EpisodioAtencion.FechaCreacion,
SS_HC_EpisodioAtencion.FechaModificacion,
SS_HC_EpisodioAtencion.Accion,
SS_HC_EpisodioAtencion.Version,
--SS_HC_EpisodioAtencion.FechaInicioDescansoMedico as FechaInicio,
SS_HC_EpisodioAtencion.FechaFinDescansoMedico as FechaFin,
SS_HC_EpisodioAtencion.FechaOrden,
NULL as Comentarios,
NULL as Observaciones,
NULL as Diagnostico,
-------------
SS_HC_EpisodioAtencion.UnidadReplicacion as UnidadReplicacionHCE,
SS_HC_EpisodioAtencion.IdPaciente as IdPacienteHCE,
SS_HC_EpisodioAtencion.EpisodioClinico as EpisodioClinicoHCE,
SS_HC_EpisodioAtencion.IdEpisodioAtencion as IdEpisodioAtencionHCE,
SS_HC_EpisodioClinico.Estado as SecuenciaHCE,
SS_HC_EpisodioClinico.Estado as CodigoEpisodioClinico,
-------------
0 as Contador,
0 as NumeroFila

from
(
/********************************************************************/
	--MÉDICOS
/********************************************************************/
/**AMBULATORIO*/
/*********************CONSULTAS*******************************************************
1. Necesidad de identificar las prestaciones asociadas a un medico
2. Como va a el manejo de las ordenes de spring salud y los episodios de atención
3. Identificar los estado de visualización (no visualizamos anulados?)

**************************************************************************************/
SELECT --top 1
'MED_AMBULATORIO' as tipoListado,
---------7
CitaTipo = (CASE SS_CC_Cita.TipoCita WHEN 1 THEN 'Normal' WHEN 2 THEN 'Adicional' ELSE 'Ninguno' END),
CitaFecha = IsNull(IsNull(SS_CC_Cita.FechaCita, SS_CE_ConsultaExterna.FechaConsulta), SS_PR_Procedimiento.FechaProcedimiento),
CitaHora = IsNull(IsNull(SS_CC_Cita.FechaCita, SS_CE_ConsultaExterna.FechaConsulta), SS_PR_Procedimiento.FechaProcedimiento),
Origen = (CASE WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 11) THEN 'Cosulta' ELSE 'Procedimiento' END),
NombreEspecialidad = SS_GE_Especialidad.Nombre,
TipoPacienteNombre = TipoPaciente.Nombre,
SS_AD_OrdenAtencion.CodigoOA,
----------
SS_AD_OrdenAtencion.FechaInicio,
NULL as Cama,
TipoOrdenAtencionNombre = TipoOrdenAtencion.Nombre,
SS_GE_Paciente.CodigoHC,
SS_GE_Paciente.CodigoHCAnterior,
PacienteNombre = PersonaMast.NombreCompleto,
NULL as MedicoNombre,
SS_AD_OrdenAtencionDetalle.IdOrdenAtencion,
LineaOrdenAtencion = SS_AD_OrdenAtencionDetalle.Linea,
0 as IdHospitalizacion,
0 as LineaHospitalizacion ,
SS_CE_ConsultaExterna.IdConsultaExterna,
SS_PR_Procedimiento.IdProcedimiento,
SS_AD_OrdenAtencion.Modalidad,
IndicadorSeguro = (	SELECT IsNull(CM_CO_TablaMaestroDetalleConcepto.IndicadorConcepto,1)
					FROM CM_CO_TablaMaestroDetalleConcepto WITH(NOLOCK) INNER JOIN CM_CO_TablaMaestroConcepto WITH(NOLOCK) ON CM_CO_TablaMaestroConcepto.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
						AND CM_CO_TablaMaestroConcepto.IdConcepto = CM_CO_TablaMaestroDetalleConcepto.IdConcepto
						AND CM_CO_TablaMaestroConcepto.Concepto = 'APLICA_SEGURO'
					WHERE TipoPaciente.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
						AND TipoPaciente.IdCodigo = CM_CO_TablaMaestroDetalleConcepto.IdCodigo),

SS_CC_Cita.IdCita,
---------------------	11
SS_GE_Paciente.IdPaciente,
SS_AD_OrdenAtencion.TipoPaciente,
SS_AD_OrdenAtencion.TipoAtencion,
IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_AD_OrdenAtencion.Especialidad),
SS_AD_OrdenAtencion.IdEmpresaAseguradora,
SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion,
SS_AD_OrdenAtencionDetalle.Componente,
ComponenteNombre = CM_CO_Componente.Nombre,
SS_AD_OrdenAtencion.Compania,
SS_AD_OrdenAtencion.Sucursal,
IdMedico = IsNull(IsNull(SS_CE_ConsultaExterna.Medico, SS_PR_Procedimiento.Medico), SS_CC_Horario.Medico),
------------------------
0 as IndicadorCirugia,
0 as IndicadorExamenPrincipal,
---------------------------
PersonaMast.PersonaAnt,
PersonaMast.sexo,
PersonaMast.FechaNacimiento,
PersonaMast.EstadoCivil,
PersonaMast.NivelInstruccion,
PersonaMast.Direccion,
PersonaMast.TipoDocumento,
PersonaMast.Documento,
PersonaMast.ApellidoPaterno,
PersonaMast.ApellidoMaterno,
PersonaMast.Nombres,
PersonaMast.LugarNacimiento,
PersonaMast.CodigoPostal,
PersonaMast.Provincia,
PersonaMast.Departamento,
PersonaMast.Telefono,
PersonaMast.CorreoElectronico,
PersonaMast.EsPaciente,
PersonaMast.EsEmpresa,
PersonaMast.Pais,
PersonaMast.Estado as EstadoPersona

FROM SS_AD_OrdenAtencionDetalle WITH(NOLOCK) LEFT JOIN SS_AD_OrdenAtencion  WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_AD_OrdenAtencion.IdOrdenAtencion
LEFT JOIN PersonaMast WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdPaciente = PersonaMast.Persona
LEFT JOIN SS_GE_Paciente WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdPaciente = SS_GE_Paciente.IdPaciente
LEFT JOIN SS_CC_Cita WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdCita = SS_CC_Cita.IdCita
LEFT JOIN SS_CC_Horario WITH(NOLOCK) ON SS_CC_Cita.IdHorario = SS_CC_Horario.IdHorario
LEFT JOIN SS_CE_ConsultaExterna WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_CE_ConsultaExterna.IdOrdenAtencion
	AND SS_AD_OrdenAtencionDetalle.Linea = SS_CE_ConsultaExterna.LineaOrdenAtencion
LEFT JOIN SS_PR_Procedimiento WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_PR_Procedimiento.IdOrdenAtencion
	AND SS_AD_OrdenAtencionDetalle.Linea = SS_PR_Procedimiento.LineaOrdenAtencion
LEFT JOIN SS_GE_Especialidad WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_AD_OrdenAtencion.Especialidad)
LEFT JOIN CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK) ON TipoPaciente.IdTablaMaestro = 106
	AND TipoPaciente.IdCodigo = SS_AD_OrdenAtencion.TipoPaciente
LEFT JOIN CM_CO_TablaMaestroDetalle TipoOrdenAtencion WITH(NOLOCK) ON TipoOrdenAtencion.IdTablaMaestro = 101
	AND TipoOrdenAtencion.IdCodigo = SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion
LEFT JOIN CM_CO_Componente WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.Componente = CM_CO_Componente.CodigoComponente
WHERE SS_AD_OrdenAtencionDetalle.IndicadorDisponible = 2
--and SS_AD_OrdenAtencion.IdPaciente = 3
AND SS_AD_OrdenAtencionDetalle.IndicadorCobrado = 2
AND SS_AD_OrdenAtencionDetalle.Estado = 2
AND SS_AD_OrdenAtencion.TipoAtencion = 1
AND SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 12, 11)
--AND SS_AD_OrdenAtencion.FechaInicio >= '2014-03-01'

union
/**EMERGENCIA*/
/*********************CONSULTAS*******************************************************
1. Necesidad de identificar las prestaciones asociadas a un medico
2. Como va a el manejo de las ordenes de spring salud y los episodios de atención
3. verificar el proceso de asignación de médico, es alli donde se define el codigo segús a utilizar, 
   dependiendo de si es emergencistao especialista
4. Como va a realizarse el manejo de la interconsulta
5. Identificar los estado de visualización (no visualizamos anulados?)
**************************************************************************************/
SELECT  --top 1
'MED_EMERGENCIA' as tipoListado,
---------7
NULL as CitaTipo,
CitaFecha = IsNull(SS_CE_ConsultaExterna.FechaConsulta, SS_PR_Procedimiento.FechaProcedimiento),
CitaHora = IsNull(SS_CE_ConsultaExterna.FechaConsulta, SS_PR_Procedimiento.FechaProcedimiento),
Origen = (CASE WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 11) THEN 'Cosulta' ELSE 'Procedimiento' END),
NombreEspecialidad = SS_GE_Especialidad.Nombre,
TipoPacienteNombre = TipoPaciente.Nombre,
SS_AD_OrdenAtencion.CodigoOA,
----------------
SS_AD_OrdenAtencion.FechaInicio,
NULL as Cama,
TipoOrdenAtencionNombre = TipoOrdenAtencion.Nombre,
SS_GE_Paciente.CodigoHC,
SS_GE_Paciente.CodigoHCAnterior,
PacienteNombre = PersonaMast.NombreCompleto,
NULL as MedicoNombre,
SS_AD_OrdenAtencionDetalle.IdOrdenAtencion,
LineaOrdenAtencion = SS_AD_OrdenAtencionDetalle.Linea,
0 as IdHospitalizacion,
0 as LineaHospitalizacion ,
SS_CE_ConsultaExterna.IdConsultaExterna,
SS_PR_Procedimiento.IdProcedimiento,
SS_AD_OrdenAtencion.Modalidad,
IndicadorSeguro = (	SELECT IsNull(CM_CO_TablaMaestroDetalleConcepto.IndicadorConcepto,1)
					FROM CM_CO_TablaMaestroDetalleConcepto WITH(NOLOCK) INNER JOIN CM_CO_TablaMaestroConcepto WITH(NOLOCK) ON CM_CO_TablaMaestroConcepto.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
						AND CM_CO_TablaMaestroConcepto.IdConcepto = CM_CO_TablaMaestroDetalleConcepto.IdConcepto
						AND CM_CO_TablaMaestroConcepto.Concepto = 'APLICA_SEGURO'
					WHERE TipoPaciente.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
						AND TipoPaciente.IdCodigo = CM_CO_TablaMaestroDetalleConcepto.IdCodigo),
0 as IdCita,						
---------------------	11					
SS_GE_Paciente.IdPaciente,
SS_AD_OrdenAtencion.TipoPaciente,
SS_AD_OrdenAtencion.TipoAtencion,
IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_AD_OrdenAtencion.Especialidad),
SS_AD_OrdenAtencion.IdEmpresaAseguradora,
SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion,
SS_AD_OrdenAtencionDetalle.Componente,
ComponenteNombre = CM_CO_Componente.Nombre,
SS_AD_OrdenAtencion.Compania,
SS_AD_OrdenAtencion.Sucursal,
IdMedico = (CASE WHEN IsNull(SS_CE_ConsultaExterna.Medico, SS_PR_Procedimiento.Medico) = 0 THEN NULL ELSE IsNull(SS_CE_ConsultaExterna.Medico, SS_PR_Procedimiento.Medico) END),
------------------------
0 as IndicadorCirugia,
0 as IndicadorExamenPrincipal,
---------------------------
PersonaMast.PersonaAnt,
PersonaMast.sexo,
PersonaMast.FechaNacimiento,
PersonaMast.EstadoCivil,
PersonaMast.NivelInstruccion,
PersonaMast.Direccion,
PersonaMast.TipoDocumento,
PersonaMast.Documento,
PersonaMast.ApellidoPaterno,
PersonaMast.ApellidoMaterno,
PersonaMast.Nombres,
PersonaMast.LugarNacimiento,
PersonaMast.CodigoPostal,
PersonaMast.Provincia,
PersonaMast.Departamento,
PersonaMast.Telefono,
PersonaMast.CorreoElectronico,
PersonaMast.EsPaciente,
PersonaMast.EsEmpresa,
PersonaMast.Pais,
PersonaMast.Estado as EstadoPersona
FROM SS_AD_OrdenAtencionDetalle WITH(NOLOCK) LEFT JOIN SS_AD_OrdenAtencion  WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_AD_OrdenAtencion.IdOrdenAtencion
LEFT JOIN PersonaMast WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdPaciente = PersonaMast.Persona
LEFT JOIN SS_GE_Paciente WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdPaciente = SS_GE_Paciente.IdPaciente
LEFT JOIN SS_CE_ConsultaExterna WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_CE_ConsultaExterna.IdOrdenAtencion
	AND SS_AD_OrdenAtencionDetalle.Linea = SS_CE_ConsultaExterna.LineaOrdenAtencion
LEFT JOIN SS_PR_Procedimiento WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_PR_Procedimiento.IdOrdenAtencion
	AND SS_AD_OrdenAtencionDetalle.Linea = SS_PR_Procedimiento.LineaOrdenAtencion
LEFT JOIN SS_GE_Especialidad WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_AD_OrdenAtencion.Especialidad)
LEFT JOIN CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK) ON TipoPaciente.IdTablaMaestro = 106
	AND TipoPaciente.IdCodigo = SS_AD_OrdenAtencion.TipoPaciente
LEFT JOIN CM_CO_TablaMaestroDetalle TipoOrdenAtencion WITH(NOLOCK) ON TipoOrdenAtencion.IdTablaMaestro = 101
	AND TipoOrdenAtencion.IdCodigo = SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion
LEFT JOIN CM_CO_Componente WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.Componente = CM_CO_Componente.CodigoComponente
WHERE SS_AD_OrdenAtencionDetalle.IndicadorDisponible = 2
AND SS_AD_OrdenAtencionDetalle.Estado = 2
AND SS_AD_OrdenAtencion.TipoAtencion = 2
AND SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 12, 11)
AND IsNull(SS_AD_OrdenAtencionDetalle.IndicadorOcultarConsulta,1) = 1 
--AND SS_AD_OrdenAtencion.FechaInicio >= '2014-01-01'

union
/**HOSPITALIZACIOPN - CIRUGIA*/
/*********************CONSULTAS*******************************************************
1. Necesidad de identificar las prestaciones asociadas a un medico
2. Como va a el manejo de las ordenes de spring salud y los episodios de atención
3. Como va a realizarse el manejo de la interconsulta
4. Como se va a manejar el proceso de asignación de médicos "Clinica el Golf", "Intervensionista El Golf", "Anestesilogo El Golf"
5. Como identificar la cirugia principal del médico
6. En caso de existir mas de dos cirugias, como sera el manejo?
**************************************************************************************/
SELECT --top 1
'MED_HOSP_CIRUGIA' as tipoListado,
---------7
NULL as CitaTipo,
CitaFecha = IsNull(SS_PR_Procedimiento.FechaProcedimiento, SS_HO_HospitalizacionDetalle.FechaAplicacion),
CitaHora = IsNull(SS_PR_Procedimiento.FechaProcedimiento, SS_AD_OrdenAtencionDetalle.FechaCreacion),
Origen = (CASE WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 11) THEN 'Cosulta' ELSE 'Procedimiento' END),
NombreEspecialidad = SS_GE_Especialidad.Nombre,
TipoPacienteNombre = TipoPaciente.Nombre,
SS_AD_OrdenAtencion.CodigoOA,
-----------
SS_AD_OrdenAtencion.FechaInicio,
Cama = SS_GE_Consultorio.Nombre,
TipoOrdenAtencionNombre = TipoOrdenAtencion.Nombre,
SS_GE_Paciente.CodigoHC,
SS_GE_Paciente.CodigoHCAnterior,
PacienteNombre = PersonaMast.NombreCompleto,
MedicoNombre = Medico.NombreCompleto,
SS_AD_OrdenAtencionDetalle.IdOrdenAtencion,
LineaOrdenAtencion = SS_AD_OrdenAtencionDetalle.Linea,
SS_HO_Hospitalizacion.IdHospitalizacion,
LineaHospitalizacion = SS_HO_HospitalizacionDetalle.Secuencial,
0 as IdConsultaExterna,
SS_PR_Procedimiento.IdProcedimiento,
SS_AD_OrdenAtencion.Modalidad,
IndicadorSeguro = (	SELECT IsNull(CM_CO_TablaMaestroDetalleConcepto.IndicadorConcepto,1)
					FROM CM_CO_TablaMaestroDetalleConcepto WITH(NOLOCK) INNER JOIN CM_CO_TablaMaestroConcepto WITH(NOLOCK) ON CM_CO_TablaMaestroConcepto.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
						AND CM_CO_TablaMaestroConcepto.IdConcepto = CM_CO_TablaMaestroDetalleConcepto.IdConcepto
						AND CM_CO_TablaMaestroConcepto.Concepto = 'APLICA_SEGURO'
					WHERE TipoPaciente.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
						AND TipoPaciente.IdCodigo = CM_CO_TablaMaestroDetalleConcepto.IdCodigo),
0 as IdCita,
---------------------	11		
SS_GE_Paciente.IdPaciente,
SS_AD_OrdenAtencion.TipoPaciente,
SS_AD_OrdenAtencion.TipoAtencion,
IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_AD_OrdenAtencion.Especialidad),
SS_AD_OrdenAtencion.IdEmpresaAseguradora,
SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion,
SS_AD_OrdenAtencionDetalle.Componente,
ComponenteNombre = CM_CO_Componente.Nombre,
SS_AD_OrdenAtencion.Compania,
SS_AD_OrdenAtencion.Sucursal,
IdMedico = (CASE WHEN IsNull(SS_PR_Procedimiento.Medico, SS_HO_HospitalizacionDetalle.Medico) = 0 THEN NULL ELSE IsNull(SS_PR_Procedimiento.Medico, SS_HO_HospitalizacionDetalle.Medico) END),
---------------------------
IndicadorCirugia = IsNull(SS_HO_Hospitalizacion.IndRequiereCirugia,1),
IndicadorExamenPrincipal = (CASE WHEN SS_HO_HospitalizacionPrestacion.IdHospitalizacion IS NOT NULL THEN 2 ELSE 1 END),
---------------------------
PersonaMast.PersonaAnt,
PersonaMast.sexo,
PersonaMast.FechaNacimiento,
PersonaMast.EstadoCivil,
PersonaMast.NivelInstruccion,
PersonaMast.Direccion,
PersonaMast.TipoDocumento,
PersonaMast.Documento,
PersonaMast.ApellidoPaterno,
PersonaMast.ApellidoMaterno,
PersonaMast.Nombres,
PersonaMast.LugarNacimiento,
PersonaMast.CodigoPostal,
PersonaMast.Provincia,
PersonaMast.Departamento,
PersonaMast.Telefono,
PersonaMast.CorreoElectronico,
PersonaMast.EsPaciente,
PersonaMast.EsEmpresa,
PersonaMast.Pais,
PersonaMast.Estado as EstadoPersona

FROM SS_AD_OrdenAtencionDetalle WITH(NOLOCK) INNER JOIN SS_AD_OrdenAtencion  WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_AD_OrdenAtencion.IdOrdenAtencion
INNER JOIN SS_HO_Hospitalizacion WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdOrdenAtencion = SS_HO_Hospitalizacion.IdOrdenAtencion
INNER JOIN SS_HO_HospitalizacionDetalle WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_HO_HospitalizacionDetalle.IdOrdenAtencion
	AND SS_AD_OrdenAtencionDetalle.Linea = SS_HO_HospitalizacionDetalle.LineaOrdenAtencion
	AND SS_HO_Hospitalizacion.IdHospitalizacion = SS_HO_HospitalizacionDetalle.IdHospitalizacion
LEFT JOIN SS_HO_HospitalizacionPrestacion WITH(NOLOCK) ON SS_HO_HospitalizacionPrestacion.IdOrdenAtencion = SS_AD_OrdenAtencionDetalle.IdOrdenAtencion
	AND SS_HO_HospitalizacionPrestacion.LineaOrdenAtencion = SS_AD_OrdenAtencionDetalle.Linea
	AND SS_HO_HospitalizacionPrestacion.IdHospitalizacion = SS_HO_Hospitalizacion.IdHospitalizacion
LEFT JOIN PersonaMast WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdPaciente = PersonaMast.Persona
LEFT JOIN SS_GE_Paciente WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdPaciente = SS_GE_Paciente.IdPaciente
LEFT JOIN SS_PR_Procedimiento WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_PR_Procedimiento.IdOrdenAtencion
	AND SS_AD_OrdenAtencionDetalle.Linea = SS_PR_Procedimiento.LineaOrdenAtencion
LEFT JOIN SS_GE_Especialidad WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_AD_OrdenAtencion.Especialidad)
LEFT JOIN CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK) ON TipoPaciente.IdTablaMaestro = 106
	AND TipoPaciente.IdCodigo = SS_AD_OrdenAtencion.TipoPaciente
LEFT JOIN CM_CO_TablaMaestroDetalle TipoOrdenAtencion WITH(NOLOCK) ON TipoOrdenAtencion.IdTablaMaestro = 101
	AND TipoOrdenAtencion.IdCodigo = SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion
LEFT JOIN CM_CO_Componente WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.Componente = CM_CO_Componente.CodigoComponente
LEFT JOIN SS_GE_Consultorio WITH(NOLOCK) ON SS_GE_Consultorio.IdConsultorio = SS_HO_Hospitalizacion.Cama
LEFT JOIN PersonaMast Medico WITH(NOLOCK) ON Medico.Persona = (CASE WHEN IsNull(SS_PR_Procedimiento.Medico, SS_HO_HospitalizacionDetalle.Medico) = 0 THEN NULL ELSE IsNull(SS_PR_Procedimiento.Medico, SS_HO_HospitalizacionDetalle.Medico) END)
WHERE SS_AD_OrdenAtencionDetalle.IndicadorDisponible = 2
--AND SS_AD_OrdenAtencion.IdPaciente = 3
AND SS_AD_OrdenAtencionDetalle.Estado = 2
AND SS_HO_Hospitalizacion.EstadoDocumento NOT IN (1, 2, 13)
AND SS_AD_OrdenAtencion.TipoAtencion = 3
AND SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 12, 11)
AND IsNull(SS_AD_OrdenAtencionDetalle.IndicadorOcultarConsulta,1) = 1 
--AND SS_AD_OrdenAtencion.FechaInicio >= '2010-01-01'

union
/********************************************************************/
	--ENFERMERAS
/********************************************************************/
/**EMERGENCIAS**/
SELECT --top 1
'ENFERM_EMERGENCIAS' as tipoListado,
------7
NULL as CitaTipo,
CitaFecha = IsNull(SS_CE_ConsultaExterna.FechaConsulta, SS_PR_Procedimiento.FechaProcedimiento),
CitaHora = IsNull(SS_CE_ConsultaExterna.FechaConsulta, SS_PR_Procedimiento.FechaProcedimiento),
Origen = (CASE WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 11) THEN 'Cosulta' ELSE 'Procedimiento' END),
NombreEspecialidad = SS_GE_Especialidad.Nombre,
TipoPacienteNombre = TipoPaciente.Nombre,
SS_AD_OrdenAtencion.CodigoOA,
---------------
SS_AD_OrdenAtencion.FechaInicio,
NULL as Cama,
TipoOrdenAtencionNombre = TipoOrdenAtencion.Nombre,
SS_GE_Paciente.CodigoHC,
SS_GE_Paciente.CodigoHCAnterior,
PacienteNombre = PersonaMast.NombreCompleto,
NULL as MedicoNombre,
SS_AD_OrdenAtencionDetalle.IdOrdenAtencion,
LineaOrdenAtencion = SS_AD_OrdenAtencionDetalle.Linea,
0 as IdHospitalizacion,
0 as LineaHospitalizacion ,
SS_CE_ConsultaExterna.IdConsultaExterna,
SS_PR_Procedimiento.IdProcedimiento,
SS_AD_OrdenAtencion.Modalidad,
IndicadorSeguro = (	SELECT IsNull(CM_CO_TablaMaestroDetalleConcepto.IndicadorConcepto,1)
					FROM CM_CO_TablaMaestroDetalleConcepto WITH(NOLOCK) INNER JOIN CM_CO_TablaMaestroConcepto WITH(NOLOCK) ON CM_CO_TablaMaestroConcepto.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
						AND CM_CO_TablaMaestroConcepto.IdConcepto = CM_CO_TablaMaestroDetalleConcepto.IdConcepto
						AND CM_CO_TablaMaestroConcepto.Concepto = 'APLICA_SEGURO'
					WHERE TipoPaciente.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
						AND TipoPaciente.IdCodigo = CM_CO_TablaMaestroDetalleConcepto.IdCodigo),
0 as IdCita,
---------------------	11	
SS_GE_Paciente.IdPaciente,
SS_AD_OrdenAtencion.TipoPaciente,
SS_AD_OrdenAtencion.TipoAtencion,
IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_AD_OrdenAtencion.Especialidad),
SS_AD_OrdenAtencion.IdEmpresaAseguradora,
SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion,
SS_AD_OrdenAtencionDetalle.Componente,
ComponenteNombre = CM_CO_Componente.Nombre,
SS_AD_OrdenAtencion.Compania,
SS_AD_OrdenAtencion.Sucursal,
IdMedico = (CASE WHEN IsNull(SS_CE_ConsultaExterna.Medico, SS_PR_Procedimiento.Medico) = 0 THEN NULL ELSE IsNull(SS_CE_ConsultaExterna.Medico, SS_PR_Procedimiento.Medico) END),
------------
0 as IndicadorCirugia,
0 as IndicadorExamenPrincipal,
---------------------------
PersonaMast.PersonaAnt,
PersonaMast.sexo,
PersonaMast.FechaNacimiento,
PersonaMast.EstadoCivil,
PersonaMast.NivelInstruccion,
PersonaMast.Direccion,
PersonaMast.TipoDocumento,
PersonaMast.Documento,
PersonaMast.ApellidoPaterno,
PersonaMast.ApellidoMaterno,
PersonaMast.Nombres,
PersonaMast.LugarNacimiento,
PersonaMast.CodigoPostal,
PersonaMast.Provincia,
PersonaMast.Departamento,
PersonaMast.Telefono,
PersonaMast.CorreoElectronico,
PersonaMast.EsPaciente,
PersonaMast.EsEmpresa,
PersonaMast.Pais,
PersonaMast.Estado as EstadoPersona
FROM SS_AD_OrdenAtencionDetalle WITH(NOLOCK) LEFT JOIN SS_AD_OrdenAtencion  WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_AD_OrdenAtencion.IdOrdenAtencion
LEFT JOIN PersonaMast WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdPaciente = PersonaMast.Persona
LEFT JOIN SS_GE_Paciente WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdPaciente = SS_GE_Paciente.IdPaciente
LEFT JOIN SS_CE_ConsultaExterna WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_CE_ConsultaExterna.IdOrdenAtencion
	AND SS_AD_OrdenAtencionDetalle.Linea = SS_CE_ConsultaExterna.LineaOrdenAtencion
LEFT JOIN SS_PR_Procedimiento WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_PR_Procedimiento.IdOrdenAtencion
	AND SS_AD_OrdenAtencionDetalle.Linea = SS_PR_Procedimiento.LineaOrdenAtencion
LEFT JOIN SS_GE_Especialidad WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_AD_OrdenAtencion.Especialidad)
LEFT JOIN CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK) ON TipoPaciente.IdTablaMaestro = 106
	AND TipoPaciente.IdCodigo = SS_AD_OrdenAtencion.TipoPaciente
LEFT JOIN CM_CO_TablaMaestroDetalle TipoOrdenAtencion WITH(NOLOCK) ON TipoOrdenAtencion.IdTablaMaestro = 101
	AND TipoOrdenAtencion.IdCodigo = SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion
LEFT JOIN CM_CO_Componente WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.Componente = CM_CO_Componente.CodigoComponente
WHERE SS_AD_OrdenAtencionDetalle.IndicadorDisponible = 2
AND SS_AD_OrdenAtencionDetalle.Estado = 2
AND SS_AD_OrdenAtencion.TipoAtencion = 2
AND SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 11)
AND IsNull(SS_AD_OrdenAtencionDetalle.IndicadorOcultarConsulta,1) = 1 
--AND SS_AD_OrdenAtencion.FechaInicio >= '2014-01-01'

union

/**HOSPITALIZACIOPN - CIRUGIA*/
SELECT --top 1
'ENFERM_HOSP_CIRUGIAS' as tipoListado,
---------7
NULL as CitaTipo,
CitaFecha = IsNull(SS_PR_Procedimiento.FechaProcedimiento, SS_HO_HospitalizacionDetalle.FechaAplicacion),
CitaHora = IsNull(SS_PR_Procedimiento.FechaProcedimiento, SS_AD_OrdenAtencionDetalle.FechaCreacion),
Origen = (CASE WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 11) THEN 'Cosulta' ELSE 'Procedimiento' END),
NombreEspecialidad = SS_GE_Especialidad.Nombre,
TipoPacienteNombre = TipoPaciente.Nombre,
SS_AD_OrdenAtencion.CodigoOA,
-----------
SS_AD_OrdenAtencion.FechaInicio,
Cama = SS_GE_Consultorio.Nombre,
TipoOrdenAtencionNombre = TipoOrdenAtencion.Nombre,
SS_GE_Paciente.CodigoHC,
SS_GE_Paciente.CodigoHCAnterior,
PacienteNombre = PersonaMast.NombreCompleto,
MedicoNombre = Medico.NombreCompleto,
SS_AD_OrdenAtencionDetalle.IdOrdenAtencion,
LineaOrdenAtencion = SS_AD_OrdenAtencionDetalle.Linea,
SS_HO_Hospitalizacion.IdHospitalizacion,
LineaHospitalizacion = SS_HO_HospitalizacionDetalle.Secuencial,
0 as IdConsultaExterna,
SS_PR_Procedimiento.IdProcedimiento,
SS_AD_OrdenAtencion.Modalidad,
IndicadorSeguro = (	SELECT IsNull(CM_CO_TablaMaestroDetalleConcepto.IndicadorConcepto,1)
					FROM CM_CO_TablaMaestroDetalleConcepto WITH(NOLOCK) INNER JOIN CM_CO_TablaMaestroConcepto WITH(NOLOCK) ON CM_CO_TablaMaestroConcepto.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
						AND CM_CO_TablaMaestroConcepto.IdConcepto = CM_CO_TablaMaestroDetalleConcepto.IdConcepto
						AND CM_CO_TablaMaestroConcepto.Concepto = 'APLICA_SEGURO'
					WHERE TipoPaciente.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
						AND TipoPaciente.IdCodigo = CM_CO_TablaMaestroDetalleConcepto.IdCodigo),
0 as IdCita,

---------------------	11	
SS_GE_Paciente.IdPaciente,
SS_AD_OrdenAtencion.TipoPaciente,
SS_AD_OrdenAtencion.TipoAtencion,
IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_AD_OrdenAtencion.Especialidad),
SS_AD_OrdenAtencion.IdEmpresaAseguradora,
SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion,
SS_AD_OrdenAtencionDetalle.Componente,
ComponenteNombre = CM_CO_Componente.Nombre,
SS_AD_OrdenAtencion.Compania,
SS_AD_OrdenAtencion.Sucursal,
IdMedico = (CASE WHEN IsNull(SS_PR_Procedimiento.Medico, SS_HO_HospitalizacionDetalle.Medico) = 0 THEN NULL ELSE IsNull(SS_PR_Procedimiento.Medico, SS_HO_HospitalizacionDetalle.Medico) END),
--------------------
IndicadorCirugia = IsNull(SS_HO_Hospitalizacion.IndRequiereCirugia,1),
IndicadorExamenPrincipal = (CASE WHEN SS_HO_HospitalizacionPrestacion.IdHospitalizacion IS NOT NULL THEN 2 ELSE 1 END),
---------------------------
PersonaMast.PersonaAnt,
PersonaMast.sexo,
PersonaMast.FechaNacimiento,
PersonaMast.EstadoCivil,
PersonaMast.NivelInstruccion,
PersonaMast.Direccion,
PersonaMast.TipoDocumento,
PersonaMast.Documento,
PersonaMast.ApellidoPaterno,
PersonaMast.ApellidoMaterno,
PersonaMast.Nombres,
PersonaMast.LugarNacimiento,
PersonaMast.CodigoPostal,
PersonaMast.Provincia,
PersonaMast.Departamento,
PersonaMast.Telefono,
PersonaMast.CorreoElectronico,
PersonaMast.EsPaciente,
PersonaMast.EsEmpresa,
PersonaMast.Pais,
PersonaMast.Estado as EstadoPersona

FROM SS_AD_OrdenAtencionDetalle WITH(NOLOCK) INNER JOIN SS_AD_OrdenAtencion  WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_AD_OrdenAtencion.IdOrdenAtencion
INNER JOIN SS_HO_Hospitalizacion WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdOrdenAtencion = SS_HO_Hospitalizacion.IdOrdenAtencion
INNER JOIN SS_HO_HospitalizacionDetalle WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_HO_HospitalizacionDetalle.IdOrdenAtencion
	AND SS_AD_OrdenAtencionDetalle.Linea = SS_HO_HospitalizacionDetalle.LineaOrdenAtencion
	AND SS_HO_Hospitalizacion.IdHospitalizacion = SS_HO_HospitalizacionDetalle.IdHospitalizacion
LEFT JOIN SS_HO_HospitalizacionPrestacion WITH(NOLOCK) ON SS_HO_HospitalizacionPrestacion.IdOrdenAtencion = SS_AD_OrdenAtencionDetalle.IdOrdenAtencion
	AND SS_HO_HospitalizacionPrestacion.LineaOrdenAtencion = SS_AD_OrdenAtencionDetalle.Linea
	AND SS_HO_HospitalizacionPrestacion.IdHospitalizacion = SS_HO_Hospitalizacion.IdHospitalizacion
LEFT JOIN PersonaMast WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdPaciente = PersonaMast.Persona
LEFT JOIN SS_GE_Paciente WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdPaciente = SS_GE_Paciente.IdPaciente
LEFT JOIN SS_PR_Procedimiento WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_PR_Procedimiento.IdOrdenAtencion
	AND SS_AD_OrdenAtencionDetalle.Linea = SS_PR_Procedimiento.LineaOrdenAtencion
LEFT JOIN SS_GE_Especialidad WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_AD_OrdenAtencion.Especialidad)
LEFT JOIN CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK) ON TipoPaciente.IdTablaMaestro = 106
	AND TipoPaciente.IdCodigo = SS_AD_OrdenAtencion.TipoPaciente
LEFT JOIN CM_CO_TablaMaestroDetalle TipoOrdenAtencion WITH(NOLOCK) ON TipoOrdenAtencion.IdTablaMaestro = 101
	AND TipoOrdenAtencion.IdCodigo = SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion
LEFT JOIN CM_CO_Componente WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.Componente = CM_CO_Componente.CodigoComponente
LEFT JOIN SS_GE_Consultorio WITH(NOLOCK) ON SS_GE_Consultorio.IdConsultorio = SS_HO_Hospitalizacion.Cama
LEFT JOIN PersonaMast Medico WITH(NOLOCK) ON Medico.Persona = (CASE WHEN IsNull(SS_PR_Procedimiento.Medico, SS_HO_HospitalizacionDetalle.Medico) = 0 THEN NULL ELSE IsNull(SS_PR_Procedimiento.Medico, SS_HO_HospitalizacionDetalle.Medico) END)
WHERE SS_AD_OrdenAtencionDetalle.IndicadorDisponible = 2
AND SS_AD_OrdenAtencionDetalle.Estado = 2
AND SS_HO_Hospitalizacion.EstadoDocumento NOT IN (1, 2, 13)
AND SS_AD_OrdenAtencion.TipoAtencion = 3
AND SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 11)
AND IsNull(SS_AD_OrdenAtencionDetalle.IndicadorOcultarConsulta,1) = 1 
--AND SS_AD_OrdenAtencion.FechaInicio >= '2010-01-01'

union

/********************************************************************/
	--OBSTETRIZ
/********************************************************************/
/**EMERGENCIA*/

SELECT --top 1
'OBSTET_EMERGENCIAS' as tipoListado,
------7
NULL as CitaTipo,
CitaFecha = IsNull(SS_CE_ConsultaExterna.FechaConsulta, SS_PR_Procedimiento.FechaProcedimiento),
CitaHora = IsNull(SS_CE_ConsultaExterna.FechaConsulta, SS_PR_Procedimiento.FechaProcedimiento),
Origen = (CASE WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 11) THEN 'Cosulta' ELSE 'Procedimiento' END),
NombreEspecialidad = SS_GE_Especialidad.Nombre,
TipoPacienteNombre = TipoPaciente.Nombre,
SS_AD_OrdenAtencion.CodigoOA,
---------------
SS_AD_OrdenAtencion.FechaInicio,
NULL as Cama,
TipoOrdenAtencionNombre = TipoOrdenAtencion.Nombre,
SS_GE_Paciente.CodigoHC,
SS_GE_Paciente.CodigoHCAnterior,
PacienteNombre = PersonaMast.NombreCompleto,
NULL as MedicoNombre,
SS_AD_OrdenAtencionDetalle.IdOrdenAtencion,
LineaOrdenAtencion = SS_AD_OrdenAtencionDetalle.Linea,
0 as IdHospitalizacion,
0 as LineaHospitalizacion ,
SS_CE_ConsultaExterna.IdConsultaExterna,
SS_PR_Procedimiento.IdProcedimiento,
SS_AD_OrdenAtencion.Modalidad,
IndicadorSeguro = (	SELECT IsNull(CM_CO_TablaMaestroDetalleConcepto.IndicadorConcepto,1)
					FROM CM_CO_TablaMaestroDetalleConcepto WITH(NOLOCK) INNER JOIN CM_CO_TablaMaestroConcepto WITH(NOLOCK) ON CM_CO_TablaMaestroConcepto.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
						AND CM_CO_TablaMaestroConcepto.IdConcepto = CM_CO_TablaMaestroDetalleConcepto.IdConcepto
						AND CM_CO_TablaMaestroConcepto.Concepto = 'APLICA_SEGURO'
					WHERE TipoPaciente.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
						AND TipoPaciente.IdCodigo = CM_CO_TablaMaestroDetalleConcepto.IdCodigo),
0 as IdCita,
---------------------	11	
SS_GE_Paciente.IdPaciente,
SS_AD_OrdenAtencion.TipoPaciente,
SS_AD_OrdenAtencion.TipoAtencion,
IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_AD_OrdenAtencion.Especialidad),
SS_AD_OrdenAtencion.IdEmpresaAseguradora,
SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion,
SS_AD_OrdenAtencionDetalle.Componente,
ComponenteNombre = CM_CO_Componente.Nombre,
SS_AD_OrdenAtencion.Compania,
SS_AD_OrdenAtencion.Sucursal,
IdMedico = (CASE WHEN IsNull(SS_CE_ConsultaExterna.Medico, SS_PR_Procedimiento.Medico) = 0 THEN NULL ELSE IsNull(SS_CE_ConsultaExterna.Medico, SS_PR_Procedimiento.Medico) END),
------------
0 as IndicadorCirugia,
0 as IndicadorExamenPrincipal,
---------------------------
PersonaMast.PersonaAnt,
PersonaMast.sexo,
PersonaMast.FechaNacimiento,
PersonaMast.EstadoCivil,
PersonaMast.NivelInstruccion,
PersonaMast.Direccion,
PersonaMast.TipoDocumento,
PersonaMast.Documento,
PersonaMast.ApellidoPaterno,
PersonaMast.ApellidoMaterno,
PersonaMast.Nombres,
PersonaMast.LugarNacimiento,
PersonaMast.CodigoPostal,
PersonaMast.Provincia,
PersonaMast.Departamento,
PersonaMast.Telefono,
PersonaMast.CorreoElectronico,
PersonaMast.EsPaciente,
PersonaMast.EsEmpresa,
PersonaMast.Pais,
PersonaMast.Estado as EstadoPersona

FROM SS_AD_OrdenAtencionDetalle WITH(NOLOCK) LEFT JOIN SS_AD_OrdenAtencion  WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_AD_OrdenAtencion.IdOrdenAtencion
LEFT JOIN PersonaMast WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdPaciente = PersonaMast.Persona
LEFT JOIN SS_GE_Paciente WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdPaciente = SS_GE_Paciente.IdPaciente
LEFT JOIN SS_CE_ConsultaExterna WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_CE_ConsultaExterna.IdOrdenAtencion
	AND SS_AD_OrdenAtencionDetalle.Linea = SS_CE_ConsultaExterna.LineaOrdenAtencion
LEFT JOIN SS_PR_Procedimiento WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_PR_Procedimiento.IdOrdenAtencion
	AND SS_AD_OrdenAtencionDetalle.Linea = SS_PR_Procedimiento.LineaOrdenAtencion
LEFT JOIN SS_GE_Especialidad WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_AD_OrdenAtencion.Especialidad)
LEFT JOIN CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK) ON TipoPaciente.IdTablaMaestro = 106
	AND TipoPaciente.IdCodigo = SS_AD_OrdenAtencion.TipoPaciente
LEFT JOIN CM_CO_TablaMaestroDetalle TipoOrdenAtencion WITH(NOLOCK) ON TipoOrdenAtencion.IdTablaMaestro = 101
	AND TipoOrdenAtencion.IdCodigo = SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion
LEFT JOIN CM_CO_Componente WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.Componente = CM_CO_Componente.CodigoComponente
WHERE SS_AD_OrdenAtencionDetalle.IndicadorDisponible = 2
AND SS_AD_OrdenAtencionDetalle.Estado = 2
AND SS_AD_OrdenAtencion.TipoAtencion = 2
AND SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 11)
AND IsNull(SS_AD_OrdenAtencionDetalle.IndicadorOcultarConsulta,1) = 1 
AND SS_GE_Especialidad.IdEspecialidad IN (9, 48)
--AND SS_AD_OrdenAtencion.FechaInicio >= '2013-01-01'

union

/**HOSPITALIZACIOPN - CIRUGIA*/
SELECT --top 1
'OBSTET_HOSP_CIRUGIAS' as tipoListado,
---------7
NULL as CitaTipo,
CitaFecha = IsNull(SS_PR_Procedimiento.FechaProcedimiento, SS_HO_HospitalizacionDetalle.FechaAplicacion),
CitaHora = IsNull(SS_PR_Procedimiento.FechaProcedimiento, SS_AD_OrdenAtencionDetalle.FechaCreacion),
Origen = (CASE WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 11) THEN 'Cosulta' ELSE 'Procedimiento' END),
NombreEspecialidad = SS_GE_Especialidad.Nombre,
TipoPacienteNombre = TipoPaciente.Nombre,
SS_AD_OrdenAtencion.CodigoOA,
-----------
SS_AD_OrdenAtencion.FechaInicio,
Cama = SS_GE_Consultorio.Nombre,
TipoOrdenAtencionNombre = TipoOrdenAtencion.Nombre,
SS_GE_Paciente.CodigoHC,
SS_GE_Paciente.CodigoHCAnterior,
PacienteNombre = PersonaMast.NombreCompleto,
MedicoNombre = Medico.NombreCompleto,
SS_AD_OrdenAtencionDetalle.IdOrdenAtencion,
LineaOrdenAtencion = SS_AD_OrdenAtencionDetalle.Linea,
SS_HO_Hospitalizacion.IdHospitalizacion,
LineaHospitalizacion = SS_HO_HospitalizacionDetalle.Secuencial,
0 as IdConsultaExterna,
SS_PR_Procedimiento.IdProcedimiento,
SS_AD_OrdenAtencion.Modalidad,
IndicadorSeguro = (	SELECT IsNull(CM_CO_TablaMaestroDetalleConcepto.IndicadorConcepto,1)
					FROM CM_CO_TablaMaestroDetalleConcepto WITH(NOLOCK) INNER JOIN CM_CO_TablaMaestroConcepto WITH(NOLOCK) ON CM_CO_TablaMaestroConcepto.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
						AND CM_CO_TablaMaestroConcepto.IdConcepto = CM_CO_TablaMaestroDetalleConcepto.IdConcepto
						AND CM_CO_TablaMaestroConcepto.Concepto = 'APLICA_SEGURO'
					WHERE TipoPaciente.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
						AND TipoPaciente.IdCodigo = CM_CO_TablaMaestroDetalleConcepto.IdCodigo),
0 as IdCita,
------------11
SS_GE_Paciente.IdPaciente,
SS_AD_OrdenAtencion.TipoPaciente,
SS_AD_OrdenAtencion.TipoAtencion,
IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_AD_OrdenAtencion.Especialidad),
SS_AD_OrdenAtencion.IdEmpresaAseguradora,
SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion,
SS_AD_OrdenAtencionDetalle.Componente,
ComponenteNombre = CM_CO_Componente.Nombre,
SS_AD_OrdenAtencion.Compania,
SS_AD_OrdenAtencion.Sucursal,
IdMedico = (CASE WHEN IsNull(SS_PR_Procedimiento.Medico, SS_HO_HospitalizacionDetalle.Medico) = 0 THEN NULL ELSE IsNull(SS_PR_Procedimiento.Medico, SS_HO_HospitalizacionDetalle.Medico) END),
---
IndicadorCirugia = IsNull(SS_HO_Hospitalizacion.IndRequiereCirugia,1),
IndicadorExamenPrincipal = (CASE WHEN SS_HO_HospitalizacionPrestacion.IdHospitalizacion IS NOT NULL THEN 2 ELSE 1 END),
---------------------------
PersonaMast.PersonaAnt,
PersonaMast.sexo,
PersonaMast.FechaNacimiento,
PersonaMast.EstadoCivil,
PersonaMast.NivelInstruccion,
PersonaMast.Direccion,
PersonaMast.TipoDocumento,
PersonaMast.Documento,
PersonaMast.ApellidoPaterno,
PersonaMast.ApellidoMaterno,
PersonaMast.Nombres,
PersonaMast.LugarNacimiento,
PersonaMast.CodigoPostal,
PersonaMast.Provincia,
PersonaMast.Departamento,
PersonaMast.Telefono,
PersonaMast.CorreoElectronico,
PersonaMast.EsPaciente,
PersonaMast.EsEmpresa,
PersonaMast.Pais,
PersonaMast.Estado as EstadoPersona

FROM SS_AD_OrdenAtencionDetalle WITH(NOLOCK) INNER JOIN SS_AD_OrdenAtencion  WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_AD_OrdenAtencion.IdOrdenAtencion
INNER JOIN SS_HO_Hospitalizacion WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdOrdenAtencion = SS_HO_Hospitalizacion.IdOrdenAtencion
INNER JOIN SS_HO_HospitalizacionDetalle WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_HO_HospitalizacionDetalle.IdOrdenAtencion
	AND SS_AD_OrdenAtencionDetalle.Linea = SS_HO_HospitalizacionDetalle.LineaOrdenAtencion
	AND SS_HO_Hospitalizacion.IdHospitalizacion = SS_HO_HospitalizacionDetalle.IdHospitalizacion
LEFT JOIN SS_HO_HospitalizacionPrestacion WITH(NOLOCK) ON SS_HO_HospitalizacionPrestacion.IdOrdenAtencion = SS_AD_OrdenAtencionDetalle.IdOrdenAtencion
	AND SS_HO_HospitalizacionPrestacion.LineaOrdenAtencion = SS_AD_OrdenAtencionDetalle.Linea
	AND SS_HO_HospitalizacionPrestacion.IdHospitalizacion = SS_HO_Hospitalizacion.IdHospitalizacion
LEFT JOIN PersonaMast WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdPaciente = PersonaMast.Persona
LEFT JOIN SS_GE_Paciente WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdPaciente = SS_GE_Paciente.IdPaciente
LEFT JOIN SS_PR_Procedimiento WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_PR_Procedimiento.IdOrdenAtencion
	AND SS_AD_OrdenAtencionDetalle.Linea = SS_PR_Procedimiento.LineaOrdenAtencion
LEFT JOIN SS_GE_Especialidad WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_AD_OrdenAtencion.Especialidad)
LEFT JOIN CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK) ON TipoPaciente.IdTablaMaestro = 106
	AND TipoPaciente.IdCodigo = SS_AD_OrdenAtencion.TipoPaciente
LEFT JOIN CM_CO_TablaMaestroDetalle TipoOrdenAtencion WITH(NOLOCK) ON TipoOrdenAtencion.IdTablaMaestro = 101
	AND TipoOrdenAtencion.IdCodigo = SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion
LEFT JOIN CM_CO_Componente WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.Componente = CM_CO_Componente.CodigoComponente
LEFT JOIN SS_GE_Consultorio WITH(NOLOCK) ON SS_GE_Consultorio.IdConsultorio = SS_HO_Hospitalizacion.Cama
LEFT JOIN PersonaMast Medico WITH(NOLOCK) ON Medico.Persona = (CASE WHEN IsNull(SS_PR_Procedimiento.Medico, SS_HO_HospitalizacionDetalle.Medico) = 0 THEN NULL ELSE IsNull(SS_PR_Procedimiento.Medico, SS_HO_HospitalizacionDetalle.Medico) END)
WHERE SS_AD_OrdenAtencionDetalle.IndicadorDisponible = 2
AND SS_AD_OrdenAtencionDetalle.Estado = 2
AND SS_HO_Hospitalizacion.EstadoDocumento NOT IN (1, 2, 13)
AND SS_AD_OrdenAtencion.TipoAtencion = 3
AND SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 11)
AND IsNull(SS_AD_OrdenAtencionDetalle.IndicadorOcultarConsulta,1) = 1 
AND SS_GE_Especialidad.IdEspecialidad IN (9, 48)
--AND SS_AD_OrdenAtencion.FechaInicio >= '2010-01-01'

union 
/********************************************************************/
	--TECNOÓLOGO MÉDICO
/********************************************************************/
/**AMBULATORIO*/

SELECT --top 1
'TECNOMED_AMBULATORIO' as tipoListado,
---------7
CitaTipo = (CASE SS_CC_Cita.TipoCita WHEN 1 THEN 'Normal' WHEN 2 THEN 'Adicional' ELSE 'Ninguno' END),
CitaFecha = IsNull(SS_CC_Cita.FechaCita,SS_PR_Procedimiento.FechaProcedimiento),
CitaHora = IsNull(SS_CC_Cita.FechaCita,SS_PR_Procedimiento.FechaProcedimiento),
Origen = (CASE WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 11) THEN 'Cosulta' ELSE 'Procedimiento' END),
NombreEspecialidad = SS_GE_Especialidad.Nombre,
TipoPacienteNombre = TipoPaciente.Nombre,
SS_AD_OrdenAtencion.CodigoOA,
----------
SS_AD_OrdenAtencion.FechaInicio,
NULL as Cama,
TipoOrdenAtencionNombre = TipoOrdenAtencion.Nombre,
SS_GE_Paciente.CodigoHC,
SS_GE_Paciente.CodigoHCAnterior,
PacienteNombre = PersonaMast.NombreCompleto,
NULL as MedicoNombre,
SS_AD_OrdenAtencionDetalle.IdOrdenAtencion,
LineaOrdenAtencion = SS_AD_OrdenAtencionDetalle.Linea,
0 as IdHospitalizacion,
0 as LineaHospitalizacion ,
0 as IdConsultaExterna,
SS_PR_Procedimiento.IdProcedimiento,
SS_AD_OrdenAtencion.Modalidad,
IndicadorSeguro = (	SELECT IsNull(CM_CO_TablaMaestroDetalleConcepto.IndicadorConcepto,1)
					FROM CM_CO_TablaMaestroDetalleConcepto WITH(NOLOCK) INNER JOIN CM_CO_TablaMaestroConcepto WITH(NOLOCK) ON CM_CO_TablaMaestroConcepto.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
						AND CM_CO_TablaMaestroConcepto.IdConcepto = CM_CO_TablaMaestroDetalleConcepto.IdConcepto
						AND CM_CO_TablaMaestroConcepto.Concepto = 'APLICA_SEGURO'
					WHERE TipoPaciente.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
						AND TipoPaciente.IdCodigo = CM_CO_TablaMaestroDetalleConcepto.IdCodigo),

SS_CC_Cita.IdCita,
---------------------	11
SS_GE_Paciente.IdPaciente,
SS_AD_OrdenAtencion.TipoPaciente,
SS_AD_OrdenAtencion.TipoAtencion,
IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_AD_OrdenAtencion.Especialidad),
SS_AD_OrdenAtencion.IdEmpresaAseguradora,
SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion,
SS_AD_OrdenAtencionDetalle.Componente,
ComponenteNombre = CM_CO_Componente.Nombre,
SS_AD_OrdenAtencion.Compania,
SS_AD_OrdenAtencion.Sucursal,
IdMedico = IsNull(SS_PR_Procedimiento.Medico, SS_CC_Horario.Medico),
------------------------
0 as IndicadorCirugia,
0 as IndicadorExamenPrincipal,
---------------------------
PersonaMast.PersonaAnt,
PersonaMast.sexo,
PersonaMast.FechaNacimiento,
PersonaMast.EstadoCivil,
PersonaMast.NivelInstruccion,
PersonaMast.Direccion,
PersonaMast.TipoDocumento,
PersonaMast.Documento,
PersonaMast.ApellidoPaterno,
PersonaMast.ApellidoMaterno,
PersonaMast.Nombres,
PersonaMast.LugarNacimiento,
PersonaMast.CodigoPostal,
PersonaMast.Provincia,
PersonaMast.Departamento,
PersonaMast.Telefono,
PersonaMast.CorreoElectronico,
PersonaMast.EsPaciente,
PersonaMast.EsEmpresa,
PersonaMast.Pais,
PersonaMast.Estado as EstadoPersona

FROM SS_AD_OrdenAtencionDetalle WITH(NOLOCK) LEFT JOIN SS_AD_OrdenAtencion  WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_AD_OrdenAtencion.IdOrdenAtencion
LEFT JOIN PersonaMast WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdPaciente = PersonaMast.Persona
LEFT JOIN SS_GE_Paciente WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdPaciente = SS_GE_Paciente.IdPaciente
LEFT JOIN SS_CC_Cita WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdCita = SS_CC_Cita.IdCita
LEFT JOIN SS_CC_Horario WITH(NOLOCK) ON SS_CC_Cita.IdHorario = SS_CC_Horario.IdHorario
LEFT JOIN SS_PR_Procedimiento WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_PR_Procedimiento.IdOrdenAtencion
	AND SS_AD_OrdenAtencionDetalle.Linea = SS_PR_Procedimiento.LineaOrdenAtencion
LEFT JOIN SS_GE_Especialidad WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_AD_OrdenAtencion.Especialidad)
LEFT JOIN CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK) ON TipoPaciente.IdTablaMaestro = 106
	AND TipoPaciente.IdCodigo = SS_AD_OrdenAtencion.TipoPaciente
LEFT JOIN CM_CO_TablaMaestroDetalle TipoOrdenAtencion WITH(NOLOCK) ON TipoOrdenAtencion.IdTablaMaestro = 101
	AND TipoOrdenAtencion.IdCodigo = SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion
LEFT JOIN CM_CO_Componente WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.Componente = CM_CO_Componente.CodigoComponente
WHERE SS_AD_OrdenAtencionDetalle.IndicadorDisponible = 2
AND SS_AD_OrdenAtencionDetalle.IndicadorCobrado = 2
AND SS_AD_OrdenAtencionDetalle.Estado = 2
AND SS_AD_OrdenAtencion.TipoAtencion = 1
AND SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion NOT IN (1, 12, 11)
AND EXISTS(	SELECT 1
			FROM CM_CO_TablaMaestroDetalleConcepto WITH(NOLOCK) INNER JOIN CM_CO_TablaMaestroConcepto WITH(NOLOCK) ON CM_CO_TablaMaestroConcepto.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
				AND CM_CO_TablaMaestroConcepto.IdConcepto = CM_CO_TablaMaestroDetalleConcepto.IdConcepto
				AND CM_CO_TablaMaestroConcepto.Concepto = 'APLICAPROCE'
			WHERE TipoOrdenAtencion.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
				AND TipoOrdenAtencion.IdCodigo = CM_CO_TablaMaestroDetalleConcepto.IdCodigo
				AND IsNull(CM_CO_TablaMaestroDetalleConcepto.IndicadorConcepto,1) = 2)
--AND SS_AD_OrdenAtencion.FechaInicio >= '2014-01-01'

union

/**EMERGENCIA*/
SELECT  --top 1
'TECNOMED_EMERGENCIA' as tipoListado,
---------7
NULL as CitaTipo,
CitaFecha = IsNull(SS_CE_ConsultaExterna.FechaConsulta, SS_PR_Procedimiento.FechaProcedimiento),
CitaHora = IsNull(SS_CE_ConsultaExterna.FechaConsulta, SS_PR_Procedimiento.FechaProcedimiento),
Origen = (CASE WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 11) THEN 'Cosulta' ELSE 'Procedimiento' END),
NombreEspecialidad = SS_GE_Especialidad.Nombre,
TipoPacienteNombre = TipoPaciente.Nombre,
SS_AD_OrdenAtencion.CodigoOA,
----------------
SS_AD_OrdenAtencion.FechaInicio,
NULL as Cama,
TipoOrdenAtencionNombre = TipoOrdenAtencion.Nombre,
SS_GE_Paciente.CodigoHC,
SS_GE_Paciente.CodigoHCAnterior,
PacienteNombre = PersonaMast.NombreCompleto,
NULL as MedicoNombre,
SS_AD_OrdenAtencionDetalle.IdOrdenAtencion,
LineaOrdenAtencion = SS_AD_OrdenAtencionDetalle.Linea,
0 as IdHospitalizacion,
0 as LineaHospitalizacion ,
SS_CE_ConsultaExterna.IdConsultaExterna,
SS_PR_Procedimiento.IdProcedimiento,
SS_AD_OrdenAtencion.Modalidad,
IndicadorSeguro = (	SELECT IsNull(CM_CO_TablaMaestroDetalleConcepto.IndicadorConcepto,1)
					FROM CM_CO_TablaMaestroDetalleConcepto WITH(NOLOCK) INNER JOIN CM_CO_TablaMaestroConcepto WITH(NOLOCK) ON CM_CO_TablaMaestroConcepto.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
						AND CM_CO_TablaMaestroConcepto.IdConcepto = CM_CO_TablaMaestroDetalleConcepto.IdConcepto
						AND CM_CO_TablaMaestroConcepto.Concepto = 'APLICA_SEGURO'
					WHERE TipoPaciente.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
						AND TipoPaciente.IdCodigo = CM_CO_TablaMaestroDetalleConcepto.IdCodigo),
0 as IdCita,
-------
SS_GE_Paciente.IdPaciente,
SS_AD_OrdenAtencion.TipoPaciente,
SS_AD_OrdenAtencion.TipoAtencion,
IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_AD_OrdenAtencion.Especialidad),
SS_AD_OrdenAtencion.IdEmpresaAseguradora,
SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion,
SS_AD_OrdenAtencionDetalle.Componente,
ComponenteNombre = CM_CO_Componente.Nombre,
SS_AD_OrdenAtencion.Compania,
SS_AD_OrdenAtencion.Sucursal,
IdMedico = (CASE WHEN IsNull(SS_CE_ConsultaExterna.Medico, SS_PR_Procedimiento.Medico) = 0 THEN NULL ELSE IsNull(SS_CE_ConsultaExterna.Medico, SS_PR_Procedimiento.Medico) END),
---
0 as IndicadorCirugia,
0 as IndicadorExamenPrincipal,
---------------------------
PersonaMast.PersonaAnt,
PersonaMast.sexo,
PersonaMast.FechaNacimiento,
PersonaMast.EstadoCivil,
PersonaMast.NivelInstruccion,
PersonaMast.Direccion,
PersonaMast.TipoDocumento,
PersonaMast.Documento,
PersonaMast.ApellidoPaterno,
PersonaMast.ApellidoMaterno,
PersonaMast.Nombres,
PersonaMast.LugarNacimiento,
PersonaMast.CodigoPostal,
PersonaMast.Provincia,
PersonaMast.Departamento,
PersonaMast.Telefono,
PersonaMast.CorreoElectronico,
PersonaMast.EsPaciente,
PersonaMast.EsEmpresa,
PersonaMast.Pais,
PersonaMast.Estado as EstadoPersona

FROM SS_AD_OrdenAtencionDetalle WITH(NOLOCK) LEFT JOIN SS_AD_OrdenAtencion  WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_AD_OrdenAtencion.IdOrdenAtencion
LEFT JOIN PersonaMast WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdPaciente = PersonaMast.Persona
LEFT JOIN SS_GE_Paciente WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdPaciente = SS_GE_Paciente.IdPaciente
LEFT JOIN SS_CE_ConsultaExterna WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_CE_ConsultaExterna.IdOrdenAtencion
	AND SS_AD_OrdenAtencionDetalle.Linea = SS_CE_ConsultaExterna.LineaOrdenAtencion
LEFT JOIN SS_PR_Procedimiento WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_PR_Procedimiento.IdOrdenAtencion
	AND SS_AD_OrdenAtencionDetalle.Linea = SS_PR_Procedimiento.LineaOrdenAtencion
LEFT JOIN SS_GE_Especialidad WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_AD_OrdenAtencion.Especialidad)
LEFT JOIN CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK) ON TipoPaciente.IdTablaMaestro = 106
	AND TipoPaciente.IdCodigo = SS_AD_OrdenAtencion.TipoPaciente
LEFT JOIN CM_CO_TablaMaestroDetalle TipoOrdenAtencion WITH(NOLOCK) ON TipoOrdenAtencion.IdTablaMaestro = 101
	AND TipoOrdenAtencion.IdCodigo = SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion
LEFT JOIN CM_CO_Componente WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.Componente = CM_CO_Componente.CodigoComponente
WHERE SS_AD_OrdenAtencionDetalle.IndicadorDisponible = 2
AND SS_AD_OrdenAtencionDetalle.Estado = 2
AND SS_AD_OrdenAtencion.TipoAtencion = 2
AND SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion NOT IN (1, 12, 11)
AND IsNull(SS_AD_OrdenAtencionDetalle.IndicadorOcultarConsulta,1) = 1
AND EXISTS(	SELECT 1
			FROM CM_CO_TablaMaestroDetalleConcepto WITH(NOLOCK) INNER JOIN CM_CO_TablaMaestroConcepto WITH(NOLOCK) ON CM_CO_TablaMaestroConcepto.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
				AND CM_CO_TablaMaestroConcepto.IdConcepto = CM_CO_TablaMaestroDetalleConcepto.IdConcepto
				AND CM_CO_TablaMaestroConcepto.Concepto = 'APLICAPROCE'
			WHERE TipoOrdenAtencion.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
				AND TipoOrdenAtencion.IdCodigo = CM_CO_TablaMaestroDetalleConcepto.IdCodigo
				AND IsNull(CM_CO_TablaMaestroDetalleConcepto.IndicadorConcepto,1) = 2)
--AND SS_AD_OrdenAtencion.FechaInicio >= '2014-01-01'

union
/**HOSPI.CIRUGIAS*/

SELECT  --top 1 
'TECNOMED_HOSP_CIRUGIA' as tipoListado,
---------7
NULL as CitaTipo,
CitaFecha = IsNull(SS_PR_Procedimiento.FechaProcedimiento, SS_HO_HospitalizacionDetalle.FechaAplicacion),
CitaHora = IsNull(SS_PR_Procedimiento.FechaProcedimiento, SS_AD_OrdenAtencionDetalle.FechaCreacion),
Origen = (CASE WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 11) THEN 'Cosulta' ELSE 'Procedimiento' END),
NombreEspecialidad = SS_GE_Especialidad.Nombre,
TipoPacienteNombre = TipoPaciente.Nombre,
SS_AD_OrdenAtencion.CodigoOA,
-----------
SS_AD_OrdenAtencion.FechaInicio,
Cama = SS_GE_Consultorio.Nombre,
TipoOrdenAtencionNombre = TipoOrdenAtencion.Nombre,
SS_GE_Paciente.CodigoHC,
SS_GE_Paciente.CodigoHCAnterior,
PacienteNombre = PersonaMast.NombreCompleto,
MedicoNombre = Medico.NombreCompleto,
SS_AD_OrdenAtencionDetalle.IdOrdenAtencion,
LineaOrdenAtencion = SS_AD_OrdenAtencionDetalle.Linea,
SS_HO_Hospitalizacion.IdHospitalizacion,
LineaHospitalizacion = SS_HO_HospitalizacionDetalle.Secuencial,
0 as IdConsultaExterna,
SS_PR_Procedimiento.IdProcedimiento,
SS_AD_OrdenAtencion.Modalidad,
IndicadorSeguro = (	SELECT IsNull(CM_CO_TablaMaestroDetalleConcepto.IndicadorConcepto,1)
					FROM CM_CO_TablaMaestroDetalleConcepto WITH(NOLOCK) INNER JOIN CM_CO_TablaMaestroConcepto WITH(NOLOCK) ON CM_CO_TablaMaestroConcepto.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
						AND CM_CO_TablaMaestroConcepto.IdConcepto = CM_CO_TablaMaestroDetalleConcepto.IdConcepto
						AND CM_CO_TablaMaestroConcepto.Concepto = 'APLICA_SEGURO'
					WHERE TipoPaciente.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
						AND TipoPaciente.IdCodigo = CM_CO_TablaMaestroDetalleConcepto.IdCodigo),
0 as IdCita,
----------11
SS_GE_Paciente.IdPaciente,
SS_AD_OrdenAtencion.TipoPaciente,
SS_AD_OrdenAtencion.TipoAtencion,
IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_AD_OrdenAtencion.Especialidad),
SS_AD_OrdenAtencion.IdEmpresaAseguradora,
SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion,
SS_AD_OrdenAtencionDetalle.Componente,
ComponenteNombre = CM_CO_Componente.Nombre,
SS_AD_OrdenAtencion.Compania,
SS_AD_OrdenAtencion.Sucursal,
IdMedico = (CASE WHEN IsNull(SS_PR_Procedimiento.Medico, SS_HO_HospitalizacionDetalle.Medico) = 0 THEN NULL ELSE IsNull(SS_PR_Procedimiento.Medico, SS_HO_HospitalizacionDetalle.Medico) END),
----
IndicadorCirugia = IsNull(SS_HO_Hospitalizacion.IndRequiereCirugia,1),
IndicadorExamenPrincipal = (CASE WHEN SS_HO_HospitalizacionPrestacion.IdHospitalizacion IS NOT NULL THEN 2 ELSE 1 END),
---------------------------
PersonaMast.PersonaAnt,
PersonaMast.sexo,
PersonaMast.FechaNacimiento,
PersonaMast.EstadoCivil,
PersonaMast.NivelInstruccion,
PersonaMast.Direccion,
PersonaMast.TipoDocumento,
PersonaMast.Documento,
PersonaMast.ApellidoPaterno,
PersonaMast.ApellidoMaterno,
PersonaMast.Nombres,
PersonaMast.LugarNacimiento,
PersonaMast.CodigoPostal,
PersonaMast.Provincia,
PersonaMast.Departamento,
PersonaMast.Telefono,
PersonaMast.CorreoElectronico,
PersonaMast.EsPaciente,
PersonaMast.EsEmpresa,
PersonaMast.Pais,
PersonaMast.Estado as EstadoPersona

FROM SS_AD_OrdenAtencionDetalle WITH(NOLOCK) INNER JOIN SS_AD_OrdenAtencion  WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_AD_OrdenAtencion.IdOrdenAtencion
INNER JOIN SS_HO_Hospitalizacion WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdOrdenAtencion = SS_HO_Hospitalizacion.IdOrdenAtencion
INNER JOIN SS_HO_HospitalizacionDetalle WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_HO_HospitalizacionDetalle.IdOrdenAtencion
	AND SS_AD_OrdenAtencionDetalle.Linea = SS_HO_HospitalizacionDetalle.LineaOrdenAtencion
	AND SS_HO_Hospitalizacion.IdHospitalizacion = SS_HO_HospitalizacionDetalle.IdHospitalizacion
LEFT JOIN SS_HO_HospitalizacionPrestacion WITH(NOLOCK) ON SS_HO_HospitalizacionPrestacion.IdOrdenAtencion = SS_AD_OrdenAtencionDetalle.IdOrdenAtencion
	AND SS_HO_HospitalizacionPrestacion.LineaOrdenAtencion = SS_AD_OrdenAtencionDetalle.Linea
	AND SS_HO_HospitalizacionPrestacion.IdHospitalizacion = SS_HO_Hospitalizacion.IdHospitalizacion
LEFT JOIN PersonaMast WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdPaciente = PersonaMast.Persona
LEFT JOIN SS_GE_Paciente WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdPaciente = SS_GE_Paciente.IdPaciente
LEFT JOIN SS_PR_Procedimiento WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_PR_Procedimiento.IdOrdenAtencion
	AND SS_AD_OrdenAtencionDetalle.Linea = SS_PR_Procedimiento.LineaOrdenAtencion
LEFT JOIN SS_GE_Especialidad WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_AD_OrdenAtencion.Especialidad)
LEFT JOIN CM_CO_TablaMaestroDetalle TipoPaciente WITH(NOLOCK) ON TipoPaciente.IdTablaMaestro = 106
	AND TipoPaciente.IdCodigo = SS_AD_OrdenAtencion.TipoPaciente
LEFT JOIN CM_CO_TablaMaestroDetalle TipoOrdenAtencion WITH(NOLOCK) ON TipoOrdenAtencion.IdTablaMaestro = 101
	AND TipoOrdenAtencion.IdCodigo = SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion
LEFT JOIN CM_CO_Componente WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.Componente = CM_CO_Componente.CodigoComponente
LEFT JOIN SS_GE_Consultorio WITH(NOLOCK) ON SS_GE_Consultorio.IdConsultorio = SS_HO_Hospitalizacion.Cama
LEFT JOIN PersonaMast Medico WITH(NOLOCK) ON Medico.Persona = (CASE WHEN IsNull(SS_PR_Procedimiento.Medico, SS_HO_HospitalizacionDetalle.Medico) = 0 THEN NULL ELSE IsNull(SS_PR_Procedimiento.Medico, SS_HO_HospitalizacionDetalle.Medico) END)
WHERE SS_AD_OrdenAtencionDetalle.IndicadorDisponible = 2
AND SS_AD_OrdenAtencionDetalle.Estado = 2
AND SS_HO_Hospitalizacion.EstadoDocumento NOT IN (1, 2, 13)
AND SS_AD_OrdenAtencion.TipoAtencion = 3
AND SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion NOT IN (1, 12, 11)
AND EXISTS(	SELECT 1
			FROM CM_CO_TablaMaestroDetalleConcepto WITH(NOLOCK) INNER JOIN CM_CO_TablaMaestroConcepto WITH(NOLOCK) ON CM_CO_TablaMaestroConcepto.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
				AND CM_CO_TablaMaestroConcepto.IdConcepto = CM_CO_TablaMaestroDetalleConcepto.IdConcepto
				AND CM_CO_TablaMaestroConcepto.Concepto = 'APLICAPROCE'
			WHERE TipoOrdenAtencion.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
				AND TipoOrdenAtencion.IdCodigo = CM_CO_TablaMaestroDetalleConcepto.IdCodigo
				AND IsNull(CM_CO_TablaMaestroDetalleConcepto.IndicadorConcepto,1) = 2)
AND IsNull(SS_AD_OrdenAtencionDetalle.IndicadorOcultarConsulta,1) = 1 
--AND SS_AD_OrdenAtencion.FechaInicio >= '2014-01-01'

) AS VW_GENERAL_ATENCIONES 
left join 
 dbo.SS_HC_EpisodioAtencion on (SS_HC_EpisodioAtencion.CodigoOA = VW_GENERAL_ATENCIONES.CodigoOA
		AND SS_HC_EpisodioAtencion.IdPaciente = VW_GENERAL_ATENCIONES.IdPaciente)
 
left JOIN
dbo.SS_HC_EpisodioClinico on(dbo.SS_HC_EpisodioAtencion.UnidadReplicacionEC = dbo.SS_HC_EpisodioClinico.UnidadReplicacion 
AND dbo.SS_HC_EpisodioAtencion.IdPaciente = dbo.SS_HC_EpisodioClinico.IdPaciente 
AND dbo.SS_HC_EpisodioAtencion.EpisodioClinico = SS_HC_EpisodioClinico.EpisodioClinico
)






GO
/****** Object:  View [dbo].[VW_ATENCIONPACIENTE_NOFARMACOLOGICO]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[VW_ATENCIONPACIENTE_NOFARMACOLOGICO]  
AS  

			SELECT     dbo.SS_HC_EpisodioAtencion.UnidadReplicacion, dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion, dbo.SS_HC_EpisodioAtencion.UnidadReplicacionEC,   
                      dbo.SS_HC_EpisodioAtencion.IdPaciente, dbo.SS_HC_EpisodioAtencion.EpisodioClinico, dbo.SS_HC_EpisodioAtencion.EpisodioAtencion,   
                      dbo.SS_HC_EpisodioAtencion.IdEstablecimientoSalud, dbo.SS_HC_EpisodioAtencion.IdUnidadServicio, dbo.SS_HC_EpisodioAtencion.IdPersonalSalud,   
                      dbo.SS_HC_EpisodioAtencion.FechaRegistro, dbo.SS_HC_Medicamento_NoFarmacologico_FE.FechaCreacion AS FechaAtencion, dbo.SS_HC_EpisodioAtencion.TipoAtencion,   
                      dbo.SS_HC_EpisodioAtencion.IdOrdenAtencion, dbo.SS_HC_EpisodioAtencion.LineaOrdenAtencion, dbo.SS_HC_EpisodioAtencion.TipoOrdenAtencion,   
                      dbo.SS_HC_EpisodioAtencion.UsuarioCreacion, dbo.SS_HC_EpisodioAtencion.FechaCreacion, dbo.SS_HC_EpisodioAtencion.UsuarioModificacion,   
                      dbo.SS_HC_EpisodioAtencion.FechaModificacion, dbo.SS_HC_EpisodioAtencion.IdEspecialidad, dbo.SS_HC_EpisodioAtencion.CodigoOA,   
                      dbo.SS_HC_EpisodioAtencion.ProximaAtencionFlag, dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencionCodigo AS IdEspecialidadProxima,   
                      dbo.SS_HC_EpisodioAtencion.IdEstablecimientoSaludProxima, dbo.SS_HC_EpisodioAtencion.IdTipoInterConsulta, dbo.SS_HC_EpisodioAtencion.IdTipoReferencia,   
                      SS_HC_Medicamento_NoFarmacologico_FE.DescripcionMedicamento AS ObservacionProxima, dbo.SS_HC_EpisodioAtencion.DescansoMedico, dbo.SS_HC_EpisodioAtencion.DiasDescansoMedico,   
                      dbo.SS_HC_EpisodioAtencion.FechaInicioDescansoMedico,  
					  dbo.SS_HC_EpisodioAtencion.FechaFirma as FechaFinDescansoMedico,  --OBS*** AUX para fecha firma add 2017-08
					  -- dbo.SS_HC_EpisodioAtencion.FechaFinDescansoMedico, 
					  dbo.SS_HC_EpisodioAtencion.FechaOrden,   
                      dbo.SS_HC_EpisodioAtencion.IdProcedimiento, dbo.SS_HC_EpisodioAtencion.ObservacionOrden, dbo.SS_HC_EpisodioAtencion.IdTipoOrden,   
                      dbo.SS_HC_EpisodioAtencion.Accion, dbo.SS_HC_EpisodioAtencion.Version, dbo.SS_HC_EpisodioClinico.FechaRegistro AS FechaRegistroEpiClinico,   
                      dbo.SS_HC_EpisodioClinico.FechaCierre AS FechaCierreEpiClinico, dbo.SS_GE_Paciente.TipoPaciente, dbo.SS_GE_Paciente.Edad, dbo.SS_GE_Paciente.Raza,   
                      dbo.SS_GE_Paciente.Religion, dbo.SS_GE_Paciente.Cargo, dbo.SS_GE_Paciente.AreaLaboral, dbo.SS_GE_Paciente.Ocupacion, dbo.SS_GE_Paciente.CodigoHC,   
                      dbo.SS_GE_Paciente.CodigoHCAnterior, dbo.SS_GE_Paciente.CodigoHCSecundario, dbo.SS_GE_Paciente.TipoAlmacenamiento, dbo.SS_GE_Paciente.TipoHistoria,   
                      dbo.SS_GE_Paciente.TipoSituacion, dbo.SS_HC_EpisodioAtencion.IdUbicacion, dbo.SS_GE_Paciente.LugarProcedencia, dbo.SS_GE_Paciente.RutaFoto,   
                      dbo.SS_GE_Paciente.FechaIngreso, dbo.SS_GE_Paciente.IndicadorNuevo, dbo.SS_GE_Paciente.Estado AS EstadoPaciente, dbo.SS_GE_Paciente.NumeroFile,   
                      dbo.SS_GE_Paciente.Servicio, dbo.SS_GE_Paciente.UsuarioAlmacenamiento, dbo.SS_GE_Paciente.FechaAlmacenamiento, dbo.SS_GE_Paciente.Observacion,   
                      dbo.SS_GE_Paciente.IndicadorAsistencia, dbo.SS_GE_Paciente.CantidadAsistencia, dbo.SS_GE_Paciente.UbicacionHHCC,   
                      dbo.SS_GE_Paciente.IndicadorMigradoSiteds, dbo.SS_GE_Paciente.NumeroCaja, dbo.SS_GE_Paciente.IndicadorCodigoBarras,   
                      dbo.SS_GE_Paciente.IDPACIENTE_OK, dbo.SS_GE_Paciente.CodigoAsegurado, dbo.SS_GE_Paciente.NumeroPoliza, dbo.SS_GE_Paciente.CodigoProducto,   
                      dbo.SS_GE_Paciente.CodigoPlan, dbo.SS_GE_Paciente.TipoParentesco, dbo.SS_GE_Paciente.CodigoBeneficio, dbo.SS_GE_Paciente.Situacion,   
                      dbo.SS_GE_Paciente.TomoActual, dbo.SS_GE_Paciente.IndicadorHistoriaFisica, dbo.SS_GE_Paciente.DescripcionHistoria, dbo.SS_GE_Paciente.NumeroCertificado,   
                      dbo.PERSONAMAST.Persona, dbo.PERSONAMAST.Origen, dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno,   
                dbo.PERSONAMAST.NombreCompleto, dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.CodigoBarras,   
                      dbo.PERSONAMAST.EsCliente, dbo.PERSONAMAST.EsProveedor, dbo.PERSONAMAST.EsEmpleado, dbo.PERSONAMAST.EsOtro, dbo.PERSONAMAST.TipoPersona,   
                      dbo.PERSONAMAST.FechaNacimiento, dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.CiudadNacimiento, dbo.PERSONAMAST.Nacionalidad,   
                      dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.NivelInstruccion, dbo.PERSONAMAST.Direccion, dbo.PERSONAMAST.CodigoPostal,   
                      dbo.PERSONAMAST.Provincia, dbo.PERSONAMAST.Departamento, dbo.PERSONAMAST.Telefono, dbo.PERSONAMAST.Fax, dbo.PERSONAMAST.DocumentoFiscal,   
                      dbo.PERSONAMAST.DocumentoIdentidad, dbo.PERSONAMAST.CarnetExtranjeria, dbo.PERSONAMAST.DocumentoMilitarFA, dbo.PERSONAMAST.TipoBrevete,   
                      dbo.PERSONAMAST.Brevete, dbo.PERSONAMAST.Pasaporte, dbo.PERSONAMAST.NombreEmergencia, dbo.PERSONAMAST.DireccionEmergencia,   
                      dbo.PERSONAMAST.TelefonoEmergencia, dbo.PERSONAMAST.PersonaAnt, dbo.PERSONAMAST.CorreoElectronico, dbo.PERSONAMAST.EnfermedadGraveFlag,   
                      dbo.PERSONAMAST.IngresoFechaRegistro, dbo.PERSONAMAST.IngresoAplicacionCodigo, dbo.PERSONAMAST.IngresoUsuario, dbo.PERSONAMAST.Celular,   
                      dbo.PERSONAMAST.ParentescoEmergencia, dbo.PERSONAMAST.CelularEmergencia, dbo.PERSONAMAST.LugarNacimiento,   
                      dbo.PERSONAMAST.SuspensionFonaviFlag, dbo.PERSONAMAST.FlagRepetido, dbo.PERSONAMAST.CodDiscamec, dbo.PERSONAMAST.FecIniDiscamec,   
                      dbo.PERSONAMAST.FecFinDiscamec, dbo.PERSONAMAST.Pais, dbo.PERSONAMAST.EsPaciente, dbo.PERSONAMAST.EsEmpresa, dbo.PERSONAMAST.Persona_Old,   
                      dbo.PERSONAMAST.personanew, dbo.PERSONAMAST.Estado AS EstadoPersona, dbo.SS_HC_EpisodioAtencion.Estado,   
                      dbo.SS_HC_AsignacionMedico.IdAsignacionMedico, dbo.SS_HC_AsignacionMedico.TipoAsignacion,   
                      dbo.SS_HC_AsignacionMedico.Observaciones AS ObservacionesAsigMed, dbo.SS_HC_AsignacionMedico.Estado AS EstadoAsigMed,   
                      dbo.SS_HC_EpisodioClinico.Estado AS EstadoEpiClinico, dbo.SS_HC_AsignacionMedico.Secuencia AS SecAsigMed,   
                      dbo.SS_HC_AsignacionMedico.SecuenciaReferida AS SecReferidaAsigMed  
		FROM   PERSONAMAST    WITH(NOLOCK) 
       INNER JOIN   SS_GE_Paciente  WITH(NOLOCK) 
					  ON dbo.PERSONAMAST.Persona = dbo.SS_GE_Paciente.IdPaciente   
       left join dbo.SS_HC_EpisodioAtencion  WITH(NOLOCK) on  
                       dbo.SS_GE_Paciente.IdPaciente = dbo.SS_HC_EpisodioAtencion.IdPaciente   
		LEFT JOIN SS_HC_Medicamento_NoFarmacologico_FE  WITH(NOLOCK) 
					   ON SS_HC_Medicamento_NoFarmacologico_FE.IdPaciente=dbo.SS_HC_EpisodioAtencion.IdPaciente  
					   and SS_HC_Medicamento_NoFarmacologico_FE.EpisodioClinico=SS_HC_EpisodioAtencion.EpisodioClinico 
					   and  SS_HC_Medicamento_NoFarmacologico_FE.IdEpisodioAtencion=SS_HC_EpisodioAtencion.IdEpisodioAtencion
       left JOIN   SS_HC_EpisodioClinico  WITH(NOLOCK) 
					  ON dbo.SS_HC_EpisodioAtencion.UnidadReplicacionEC = dbo.SS_HC_EpisodioClinico.UnidadReplicacion AND   
                      dbo.SS_HC_EpisodioAtencion.IdPaciente = dbo.SS_HC_EpisodioClinico.IdPaciente AND   
                      dbo.SS_HC_EpisodioAtencion.EpisodioClinico = dbo.SS_HC_EpisodioClinico.EpisodioClinico   
        LEFT OUTER JOIN   SS_HC_AsignacionMedico  WITH(NOLOCK) ON dbo.SS_HC_AsignacionMedico.IdPaciente = dbo.SS_HC_EpisodioAtencion.IdPaciente  

GO
/****** Object:  View [dbo].[VW_ATENCIONPACIENTEMEDICAMENTO]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[VW_ATENCIONPACIENTEMEDICAMENTO]  
AS 
SELECT     dbo.SS_HC_Medicamento_FE.UnidadReplicacion,
          dbo.SS_HC_Medicamento_FE.IdEpisodioAtencion,         
                  dbo.SS_HC_Medicamento_FE.IdPaciente,
             dbo.SS_HC_Medicamento_FE.EpisodioClinico,
                   dbo.SS_HC_Medicamento_FE.Secuencia,
              dbo.SS_HC_Medicamento_FE.IdUnidadMedida,
                       dbo.SS_HC_Medicamento_FE.Linea,  
                     dbo.SS_HC_Medicamento_FE.Familia,
                  dbo.SS_HC_Medicamento_FE.SubFamilia,
              dbo.SS_HC_Medicamento_FE.TipoComponente,  
            dbo.SS_HC_Medicamento_FE.CodigoComponente,
                       dbo.SS_HC_Medicamento_FE.IdVia,
                       dbo.SS_HC_Medicamento_FE.Dosis,                    
             dbo.SS_HC_Medicamento_FE.DiasTratamiento,
                  dbo.SS_HC_Medicamento_FE.Frecuencia,
                    dbo.SS_HC_Medicamento_FE.Cantidad,  
                dbo.SS_HC_Medicamento_FE.IndicadorEPS,
                  dbo.SS_HC_Medicamento_FE.TipoReceta,
                   SS_HC_Medicamento_FE.Forma,  
            dbo.SS_HC_Medicamento_FE.GrupoMedicamento,
                  dbo.SS_HC_Medicamento_FE.Comentario,  
          dbo.SS_HC_Medicamento_FE.TipoMedicamento as IndicadorAuditoria,
            dbo.SS_HC_Medicamento_FE.SecuencialHCE AS  UsuarioAuditoria,
            dbo.SS_HC_Medicamento_FE.FechaCreacion,
                         dbo.SS_HC_Medicamento_FE.Accion,
                      dbo.SS_HC_Medicamento_FE.Estado,                      
      dbo.PERSONAMAST.Persona, dbo.PERSONAMAST.Origen,
                       dbo.PERSONAMAST.NombreCompleto,  
                 dbo.PERSONAMAST.IngresoFechaRegistro,
              dbo.PERSONAMAST.IngresoAplicacionCodigo,
                +(case when Presentacion IS null OR Presentacion=''
						then ''else +'Presentacion : '+ SS_HC_Medicamento_FE.Presentacion    end)
				+(case when Dosis IS null OR Dosis=''
							then ''else + ' Dosis : '+ SS_HC_Medicamento_FE.Dosis   end)                 
				+(case when  UniMed.DescripcionCorta IS null 
							then ''else ' U.Medida : '+UniMed.DescripcionCorta  end) 
				+(case when Frecuencia is null  
							then '' else ' Frecuencia : '     + CONVERT(VARCHAR,SS_HC_Medicamento_FE.Frecuencia) end)
				+(case when  DETUNI.Nombre IS null 
							then ''else ' Und.Tiempo : '+ DETUNI.Nombre  end)  
				+(case when  SS_HC_Medicamento_FE.Periodo IS null 
							then ''else ' Periodo : '+ SS_HC_Medicamento_FE.Periodo   end) 
				+(case when  DETTIE.Nombre IS null 
							then ''else ' Und.Tiempo : '+ DETTIE.Nombre  end)  
				+(case when  Via.Descripcion is null 
							then '' else ' Vía : '+ Via.Descripcion end) 
				+(case when Cantidad is null  
					then ''else ' Cantidad : '+ CONVERT(VARCHAR,Cantidad) end)
				+(case when DETTOR.Nombre IS null 
							then ''else ' T.Receta : '+ DETTOR.Nombre   end) 
				+(case when Indicacion IS null OR Indicacion=''
							then ''else ' Indicacion : '+ Indicacion   end) as IngresoUsuario,
                             dbo.PERSONAMAST.Celular,  							
              dbo.PERSONAMAST.Estado AS EstadoPersona,
         ( case when (MED.DescripcionLocal IS NOT null OR MED.DescripcionLocal <> '')
                   then MED.DescripcionLocal else DCI.DescripcionLocal end  ) as Medicamento
                   , disp.NumeroDocumento as Cama
                   , SS_HC_Medicamento_FE.SecuencialHCE as CodigoOA
                   , SS_HC_Medicamento_FE.TipoMedicamento as Medico                                             
FROM            SS_HC_Medicamento_FE WITH(NOLOCK) 
        LEFT JOIN WH_ClaseSubFamilia DCI  WITH(NOLOCK) ON
                (DCI.Linea = SS_HC_Medicamento_FE.Linea
                AND DCI.Familia = SS_HC_Medicamento_FE.Familia
                AND DCI.SubFamilia = SS_HC_Medicamento_FE.SubFamilia
                AND (SS_HC_Medicamento_FE.CodigoComponente  = '' OR SS_HC_Medicamento_FE.CodigoComponente is null)
                )
        LEFT JOIN WH_ItemMast MED  WITH(NOLOCK) ON
                (MED.Linea = SS_HC_Medicamento_FE.Linea
                AND MED.Familia = SS_HC_Medicamento_FE.Familia
                AND MED.SubFamilia = SS_HC_Medicamento_FE.SubFamilia
                AND ( rtrim(MED.Item)  =  SS_HC_Medicamento_FE.CodigoComponente )
                ) 
        LEFT JOIN dbo.PERSONAMAST   WITH(NOLOCK) ON   PERSONAMAST.persona =  SS_HC_Medicamento_FE.IdPaciente
		LEFT JOIN SS_FA_SolicitudProducto disp on disp.IdPaciente= SS_HC_Medicamento_FE.IdPaciente
		LEFT JOIN  UnidadesMast UniMed					 WITH(NOLOCK) ON	   (UniMed.IdUnidadMedida = SS_HC_Medicamento_FE.IdUnidadMedida)
		LEFT JOIN  GE_VARIOS Via						 WITH(NOLOCK) ON     (Via.CodigoTabla = 'TIPOVIA'    AND Via.Secuencial = SS_HC_Medicamento_FE.IdVia)
		LEFT JOIN  CM_CO_TablaMaestroDetalle DETUNI		 WITH(NOLOCK) ON     (DETUNI.IdTablaMaestro = 102    AND DETUNI.IdCodigo = SS_HC_Medicamento_FE.UnidadTiempo)     
		LEFT JOIN  CM_CO_TablaMaestroDetalle DETTIE		 WITH(NOLOCK) ON     (DETTIE.IdTablaMaestro = 102    AND DETTIE.IdCodigo = SS_HC_Medicamento_FE.TipoComida)       
		LEFT JOIN  CM_CO_TablaMaestroDetalle DETTOR		 WITH(NOLOCK) ON     (DETTOR.IdTablaMaestro = 46     AND DETTOR.IdCodigo = SS_HC_Medicamento_FE.TipoReceta)   

GO
/****** Object:  View [dbo].[vw_favoritos]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[vw_favoritos]  
as  
select   
SS_HC_Favorito.IdFavorito,  
ss_hc_favoritonumero.NumeroFavorito,  
ss_hc_favoritonumero.Mnemotecnico,  
SS_HC_Favorito.Descripcion,  
SS_HC_favoritonumero.Descripcion as DescripcionExtranjera,  
SS_HC_Favorito.IdAgente,  
SS_HC_Favorito.IdFavoritoTabla,  
SS_HC_Favoritonumero.Estado,  
ss_hc_favoritonumero.Accion,  
ss_hc_favoritonumero.Version,  
SS_HC_Tabla.NombreTabla,
SS_HC_Tabla.Descripcion as DescripTabla,
SG_Agente.CodigoAgente,
SG_Agente.Nombre,
SS_HC_Favorito.TipoFavorito

from SS_HC_Favorito  
left join ss_hc_favoritonumero on SS_HC_Favorito.IdFavorito = ss_hc_favoritonumero.IdFavorito  
left join SS_HC_Tabla on SS_HC_Favorito.IdFavoritoTabla = SS_HC_Tabla.IdFavoritoTabla  
left join SG_Agente on SS_HC_Favorito.IdAgente = SG_Agente.IdAgente  


GO
/****** Object:  View [dbo].[VW_FORMATOCAMPO]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[VW_FORMATOCAMPO]    
AS    
SELECT				dbo.SS_HC_Formato.IdFormato, dbo.SS_HC_Formato.CodigoFormato,
					dbo.SS_HC_Formato.Descripcion as DescripcionFormato, 
					dbo.SS_HC_FormatoCampo.SecuenciaCampo, 
					dbo.SS_HC_FormatoCampo.ValorPorDefecto as DescripFormatoCampo, 
					dbo.SS_HC_FormatoCampo.Formula, 
					dbo.SS_HC_Formato.Modulo,
					dbo.SS_HC_FormatoCampo.IndicadorObligatorio,
					dbo.SS_HC_FormatoCampo.Estado, dbo.SS_HC_FormatoCampo.Accion,
					dbo.SS_HC_FormatoCampo.Version

FROM				dbo.SS_HC_Formato		INNER JOIN    
                    dbo.SS_HC_FormatoCampo 
				ON  dbo.SS_HC_Formato.IdFormato = dbo.SS_HC_FormatoCampo.IdFormato 

GO
/****** Object:  View [dbo].[VW_FORMATORECURSOCAMPO]    Script Date: 16/04/2025 17:07:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
  
CREATE OR ALTER VIEW [dbo].[VW_FORMATORECURSOCAMPO]      
AS      
    
SELECT    dbo.SS_HC_Formato.IdFormato,   
     dbo.SS_HC_Formato.CodigoFormato,  
     dbo.SS_HC_Formato.Descripcion as DescripcionFormato,   
       
     dbo.SS_HC_FormatoCampo.SecuenciaCampo,   
     dbo.SS_HC_FormatoCampo.ValorPorDefecto as DescripFormatoCampo,   
     dbo.SS_HC_FormatoCampo.Formula,    
       
                    dbo.SS_HC_Tabla.IdFavoritoTabla,  
                    dbo.SS_HC_Tabla.Descripcion as DescripcionTabla,   
                      
                    dbo.SS_HC_FormatoRecursoCampo.NombreCampoRecurso as DescripTablaCampo,   
                    dbo.SS_HC_FormatoRecursoCampo.Estado,  
                    dbo.SS_HC_FormatoRecursoCampo.Accion      
  
FROM       SS_HC_FormatoRecursoCampo   
     INNER JOIN SS_HC_FormatoCampo ON SS_HC_FormatoCampo.SecuenciaCampo = SS_HC_FormatoRecursoCampo.SecuenciaCampo  AND SS_HC_FormatoCampo.IdFormato = SS_HC_FormatoRecursoCampo.IdFormato
     INNER JOIN  SS_HC_Formato ON SS_HC_Formato.IdFormato = SS_HC_FormatoRecursoCampo.IdFormato  
     INNER JOIN  SS_HC_Tabla ON SS_HC_Tabla.IdFavoritoTabla = SS_HC_FormatoRecursoCampo.IdFavoritoTabla  
  
  
GO
/****** Object:  View [dbo].[VW_GRUPORECURSOS]    Script Date: 16/04/2025 17:07:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[VW_GRUPORECURSOS]
AS
SELECT     CodigoDiagnostico, CodigoPadre
FROM         dbo.SS_GE_Diagnostico
GO
/****** Object:  View [dbo].[vw_Imprimir_HC]    Script Date: 16/04/2025 17:07:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[vw_Imprimir_HC]
as
select 
IH.IdImpresion as IdImpresionHeader,
IH.UnidadReplicacion as UnidadReplicacionHeader,
IH.IdPaciente as IdPacienteHeader,

IH.HostImpresion as HostImpresionHeader,
IH.UsuarioImpresion as UsuarioImpresionHeader,
IH.FechaImpresion as FechaImpresionHeader,
IH.Accion as AccionHeader,



ID.IdImpresion as IdImpresionDetalle,
ID.Secuencial as SecuencialDetalle,
ID.IdPaciente as IdPacienteDetalle,
ID.IdEpisodioAtencion as IdEpisodioAtencionDetalle,
ID.IdOpcion as IdOpcionDetalle,
ID.EpisodioClinico as EpisodioClinicoDetalle,
ID.EpisodioAtencion as EpisodioAtencionDetalle,
ID.CodigoOpcion as CodigoOpcionDetalle,
ID.IdFormato as IdFormatoDetalle,
ID.TipoAtencion as TipoAtencionDetalle,
ID.IdUnidadServicio as  IdUnidadServicioDetalle,
ID.IdPersonalSalud as IdPersonalSaludDetalle,
ID.HostImpresion as HostImpresionDetalle,
ID.UsuarioImpresion as UsuarioImpresionDetalle,
ID.FechaImpresion as FechaImpresionDetalle


from SS_HC_ImpresionHC IH inner join SS_HC_ImpresionHC_Detalle ID on
IH.IdImpresion = ID.IdImpresion and IH.IdPaciente = ID.IdPaciente 




GO
/****** Object:  View [dbo].[vw_Imprimir_HC_DETALLE_GRILLA]    Script Date: 16/04/2025 17:07:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[vw_Imprimir_HC_DETALLE_GRILLA]
as
select 
 IH.IdImpresion,
 IH.Secuencial, 
 IH.IdPaciente,
 IH.IdEpisodioAtencion,
 IH.IdOpcion,
 IH.EpisodioClinico,
 IH.EpisodioAtencion,
 T.Nombre as accion,
 IH.IdFormato,
 IH.TipoAtencion,
 IH.IdUnidadServicio,
 IH.IdPersonalSalud,
 IH.HostImpresion,
 IH.UsuarioImpresion,
 IH.FechaImpresion,
 P.NombreCompleto,
 PC.CodigoHC,
 F.Descripcion as CodigoOpcion

from SS_HC_ImpresionHC_Detalle IH inner join PERSONAMAST  P on
IH.IdPaciente = P.Persona left join
SS_GE_Paciente  PC on
PC.IdPaciente = IH.IdPaciente  
left join dbo.SS_HC_Formato F on  
F.CodigoFormato = IH.CodigoOpcion

left join dbo.SS_GE_TipoAtencion T on
T.IdTipoAtencion = IH.TipoAtencion












GO
/****** Object:  View [dbo].[vw_Imprimir_HC_GRILLA]    Script Date: 16/04/2025 17:07:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[vw_Imprimir_HC_GRILLA]
as
select 
 P.NombreCompleto,
 PC.CodigoHC,
 IH.IdImpresion,
 IH.FechaImpresion,
 IH.UnidadReplicacion,
 IH.HostImpresion,
 IH.UsuarioImpresion,
 IH.IdPaciente,
 IH.Descripcion,
 IH.Accion,
 IH.Contador_filas



from SS_HC_ImpresionHC IH inner join PERSONAMAST  P on
IH.IdPaciente = P.Persona left join
SS_GE_Paciente  PC on

PC.IdPaciente = IH.IdPaciente  







GO
/****** Object:  View [dbo].[vw_Imprimir_HC_GRILLANOTIFICACION]    Script Date: 16/04/2025 17:07:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[vw_Imprimir_HC_GRILLANOTIFICACION]
as
 SELECT                  W.IdNotificacion,
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
                         W.Estado,                  
                         Usuario, 
                         W.UltimaFechaModif, 
                         IdOpcion,                         
                         W.Accion, 
                         U.NombreCompleto AS version
      
 FROM SS_HC_BANDEJA_NOTIFI_HEADER W inner join PersonaMast U    
       ON W.IdPaciente = U.Persona  






GO
/****** Object:  View [dbo].[vw_Imprimir_HC_GRILLANOTIFICACION_EPISODIO]    Script Date: 16/04/2025 17:07:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[vw_Imprimir_HC_GRILLANOTIFICACION_EPISODIO]
as
			SELECT      W.CodigoOA,
                UnidadReplicacion,                          
                IdPaciente,                          
                IdOrdenAtencion,
				Tipo,
				IdEspecialidad,
				Secuencia,
				TipoMedicamento, 
				IdUnidadMedida,
                Linea,
				Familia,
				SubFamilia,
				CodigoComponente,
				IdVia,
				Dosis,
				DiasTratamiento,
                Frecuencia,
				Cantidad,
				IndicadorEPS,
				TipoReceta,
				GrupoMedicamento,
				Comentario,
				TipoComida,
				VolumenDia,
				FrecuenciaToma,
				Presentacion,
				Hora,
				Periodo,
				W.UnidadTiempo,
				UsuarioAuditoria,
				Indicacion,
                W.Estado,    
				UsuarioCreacion,
				FechaCreacion,
                UsuarioModificacion, 
                W.FechaModificacion,                                      
                W.Accion,						
				INDICADORTI,
				IdPadreNutriente,
				IdHijoNutriente,
				SecuencialHCE,
				CodAlmacen,
                U.NombreCompleto AS version    
 FROM SS_HC_EpisodioNotificaciones_FE W  WITH(NOLOCK) 
	inner join PersonaMast U    WITH(NOLOCK)  ON W.IdPaciente = U.Persona  
GO
/****** Object:  View [dbo].[vw_Miscelaneos]    Script Date: 16/04/2025 17:07:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[vw_Miscelaneos]
as
select 
MH.AplicacionCodigo as AplicacionHeader,
MH.CodigoTabla as CodigoHeader,
MH.Compania as CompaniaHeader,
MH.DescripcionLocal as DescLocalHeader,
MH.DescripcionExtranjera as DescExtHeader,
MH.Estado as EstadoHeader,
MH.UltimoUsuario as UsuarioHeader,
MH.UltimaFechaModif as FechaHeader,
MH.Timestamp as TimeHeader,
MH.ACCION as AccionHeader,
MD.AplicacionCodigo as AplicacionDetalle,
MD.CodigoTabla as CodigoDetalle,
MD.Compania as CompaniaDetalle,
MD.CodigoElemento as ElementoDetalle,
MD.DescripcionLocal as DescDetalle,
MD.DescripcionExtranjera as DescextDetalle,
MD.ValorCodigo1 as ValorCodigoDetalle,
MD.Estado as EstadoDetalle,
MD.UltimoUsuario as UsuarioDetalle,
MD.UltimaFechaModif as FechaDetalle,
MD.Timestamp as TimeDetalle,
MD.ValorCodigo2,
MD.ValorCodigo3,
MD.ValorCodigo4,
MD.ValorEntero1,
MD.ValorEntero2,
MD.ValorEntero3,
MD.ValorEntero4

from MA_MiscelaneosHeader MH inner join MA_MiscelaneosDetalle MD on
mh.AplicacionCodigo = md.AplicacionCodigo and mh.CodigoTabla = md.CodigoTabla and mh.Compania = md.Compania



GO
/****** Object:  View [dbo].[VW_PERSONA_USUARIO]    Script Date: 16/04/2025 17:07:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[VW_PERSONA_USUARIO]
AS
SELECT     dbo.PERSONAMAST.Persona, dbo.PERSONAMAST.Origen, dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.Nombres, 
                      dbo.PERSONAMAST.NombreCompleto, dbo.PERSONAMAST.Busqueda, dbo.PERSONAMAST.GrupoEmpresarial, dbo.PERSONAMAST.TipoDocumento, 
                      dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.CodigoBarras, dbo.PERSONAMAST.EsCliente, dbo.PERSONAMAST.EsProveedor, 
                      dbo.PERSONAMAST.EsEmpleado, dbo.PERSONAMAST.EsOtro, dbo.PERSONAMAST.TipoPersona, dbo.PERSONAMAST.FechaNacimiento, 
                      dbo.PERSONAMAST.CiudadNacimiento, dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.Nacionalidad, dbo.PERSONAMAST.EstadoCivil, 
                      dbo.PERSONAMAST.NivelInstruccion, dbo.PERSONAMAST.Direccion, dbo.PERSONAMAST.CodigoPostal, dbo.PERSONAMAST.Provincia, 
                      dbo.PERSONAMAST.Departamento, dbo.PERSONAMAST.Telefono, dbo.PERSONAMAST.Fax, dbo.PERSONAMAST.DocumentoFiscal, 
                      dbo.PERSONAMAST.DocumentoIdentidad, dbo.PERSONAMAST.CarnetExtranjeria, dbo.PERSONAMAST.DocumentoMilitarFA, dbo.PERSONAMAST.TipoBrevete, 
                      dbo.PERSONAMAST.Brevete, dbo.PERSONAMAST.Pasaporte, dbo.PERSONAMAST.NombreEmergencia, dbo.PERSONAMAST.DireccionEmergencia, 
                      dbo.PERSONAMAST.TelefonoEmergencia, dbo.PERSONAMAST.BancoMonedaLocal, dbo.PERSONAMAST.TipoCuentaLocal, dbo.PERSONAMAST.CuentaMonedaLocal, 
                      dbo.PERSONAMAST.BancoMonedaExtranjera, dbo.PERSONAMAST.TipoCuentaExtranjera, dbo.PERSONAMAST.CuentaMonedaExtranjera, 
                      dbo.PERSONAMAST.PersonaAnt, dbo.PERSONAMAST.CorreoElectronico, dbo.PERSONAMAST.ClasePersonaCodigo, dbo.PERSONAMAST.PersonaClasificacion, 
                      dbo.PERSONAMAST.EnfermedadGraveFlag, dbo.PERSONAMAST.IngresoFechaRegistro, dbo.PERSONAMAST.IngresoAplicacionCodigo, 
                      dbo.PERSONAMAST.IngresoUsuario, dbo.PERSONAMAST.PYMEFlag, dbo.PERSONAMAST.Estado, dbo.PERSONAMAST.UltimoUsuario, 
                      dbo.PERSONAMAST.UltimaFechaModif, dbo.PERSONAMAST.TipoPersonaUsuario, dbo.PERSONAMAST.DireccionReferencia, dbo.PERSONAMAST.Celular, 
                      dbo.PERSONAMAST.ParentescoEmergencia, dbo.PERSONAMAST.CelularEmergencia, dbo.PERSONAMAST.LugarNacimiento, 
                      dbo.PERSONAMAST.SuspensionFonaviFlag, dbo.PERSONAMAST.FlagRepetido, dbo.PERSONAMAST.CodDiscamec, dbo.PERSONAMAST.FecIniDiscamec, 
                      dbo.PERSONAMAST.FecFinDiscamec, dbo.PERSONAMAST.CodLicArma, dbo.PERSONAMAST.MarcaArma, dbo.PERSONAMAST.SerieArma, 
                      dbo.PERSONAMAST.InicioArma, dbo.PERSONAMAST.VencimientoArma, dbo.PERSONAMAST.SeguroDiscamec, dbo.PERSONAMAST.CorrelativoSCTR, 
                      dbo.PERSONAMAST.CuentaMonedaExtranjera_tmp, dbo.PERSONAMAST.CuentaMonedaLocal_tmp, dbo.PERSONAMAST.FlagActualizacion, 
                      dbo.PERSONAMAST.TarjetadeCredito, dbo.PERSONAMAST.Pais, dbo.PERSONAMAST.EsPaciente, dbo.PERSONAMAST.EsEmpresa, dbo.PERSONAMAST.Persona_Old, 
                      dbo.PERSONAMAST.personanew, dbo.PERSONAMAST.cmp, dbo.PERSONAMAST.SUNATNacionalidad, dbo.PERSONAMAST.SUNATVia, 
                      dbo.PERSONAMAST.SUNATZona, dbo.PERSONAMAST.SUNATUbigeo, dbo.PERSONAMAST.SUNATDomiciliado, dbo.PERSONAMAST.IndicadorAutogenerado, 
                      dbo.PERSONAMAST.RutaFirma, dbo.PERSONAMAST.TipoDocumentoIdentidad, dbo.PERSONAMAST.IdPersonaUnificado, dbo.PERSONAMAST.idpersona_ok, 
                      dbo.PERSONAMAST.edad, dbo.PERSONAMAST.rangoEtario, dbo.PERSONAMAST.TipoMedico, dbo.PERSONAMAST.Correcion, 
                      dbo.PERSONAMAST.IdEmpresaAnteriorUnificacion, dbo.PERSONAMAST.brevete_fecvcto, dbo.PERSONAMAST.carnetextranjeria_fecvcto, 
                      dbo.PERSONAMAST.Estado_BK, dbo.PERSONAMAST.Estado_Bks, dbo.PERSONAMAST.IndicadorVinculada, dbo.PERSONAMAST.PaisEmisor, 
                      dbo.PERSONAMAST.CodigoLDN, dbo.PERSONAMAST.SunatConvenio, dbo.PERSONAMAST.IndicadorRegistroManual, dbo.PERSONAMAST.IndicadorFallecido, 
                      dbo.PERSONAMAST.IndicadorSinCorreo, dbo.PERSONAMAST.ACCION, dbo.USUARIO.USUARIO, dbo.USUARIO.USUARIOPERFIL, dbo.USUARIO.NOMBRE, 
                      dbo.USUARIO.ESTADO AS Expr3
FROM         dbo.PERSONAMAST LEFT OUTER JOIN
                      dbo.USUARIO ON dbo.PERSONAMAST.Persona = dbo.USUARIO.PERSONA
GO
/****** Object:  View [dbo].[VW_PERSONAPACIENTE]    Script Date: 16/04/2025 17:07:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[VW_PERSONAPACIENTE]  
AS   
  SELECT     dbo.PERSONAMAST.Persona, dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.NombreCompleto,   
                      dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.CodigoBarras, dbo.PERSONAMAST.EsCliente,   
                      dbo.PERSONAMAST.EsEmpleado, dbo.PERSONAMAST.EsOtro, dbo.PERSONAMAST.TipoPersona, dbo.PERSONAMAST.EsProveedor,   
                      dbo.PERSONAMAST.FechaNacimiento, dbo.PERSONAMAST.CiudadNacimiento, dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.Nacionalidad,   
                      dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.NivelInstruccion, dbo.PERSONAMAST.Direccion, dbo.PERSONAMAST.CodigoPostal,   
                      dbo.PERSONAMAST.Provincia, dbo.PERSONAMAST.Departamento, dbo.PERSONAMAST.Telefono, dbo.PERSONAMAST.DocumentoFiscal,   
                      dbo.PERSONAMAST.DocumentoIdentidad, dbo.PERSONAMAST.ACCION, dbo.PERSONAMAST.edad, dbo.PERSONAMAST.rangoEtario, dbo.PERSONAMAST.TipoMedico,   
                      dbo.PERSONAMAST.Correcion, dbo.PERSONAMAST.EsPaciente, dbo.PERSONAMAST.EsEmpresa, dbo.PERSONAMAST.Pais, dbo.PERSONAMAST.FlagActualizacion,   
                      dbo.PERSONAMAST.CuentaMonedaLocal_tmp, dbo.PERSONAMAST.CuentaMonedaExtranjera_tmp, dbo.PERSONAMAST.CorrelativoSCTR,   
                      dbo.PERSONAMAST.SeguroDiscamec, dbo.PERSONAMAST.CodDiscamec, dbo.PERSONAMAST.FecIniDiscamec, dbo.PERSONAMAST.FecFinDiscamec,   
                      dbo.PERSONAMAST.LugarNacimiento, dbo.PERSONAMAST.Celular, dbo.PERSONAMAST.CelularEmergencia, dbo.PERSONAMAST.ParentescoEmergencia,   
                      dbo.PERSONAMAST.DireccionReferencia, dbo.PERSONAMAST.UltimaFechaModif, dbo.PERSONAMAST.TipoPersonaUsuario, dbo.PERSONAMAST.UltimoUsuario,   
                      dbo.PERSONAMAST.Estado, dbo.PERSONAMAST.DireccionEmergencia, dbo.PERSONAMAST.TelefonoEmergencia, dbo.PERSONAMAST.BancoMonedaLocal,   
                      dbo.PERSONAMAST.TipoCuentaLocal, dbo.PERSONAMAST.CuentaMonedaLocal, dbo.PERSONAMAST.BancoMonedaExtranjera,   
                      dbo.PERSONAMAST.TipoCuentaExtranjera, dbo.PERSONAMAST.CuentaMonedaExtranjera, dbo.PERSONAMAST.CorreoElectronico,   
                      dbo.PERSONAMAST.EnfermedadGraveFlag, dbo.PERSONAMAST.IngresoFechaRegistro, dbo.PERSONAMAST.IngresoAplicacionCodigo,   
                      dbo.PERSONAMAST.IngresoUsuario, dbo.PERSONAMAST.PYMEFlag, dbo.EMPLEADOMAST.TipoPago, dbo.EMPLEADOMAST.TipoTrabajadorSalud as TipoTrabajador,   
                      dbo.EMPLEADOMAST.Religion, dbo.EMPLEADOMAST.TipoVisa, dbo.EMPLEADOMAST.VisaFechaInicio, dbo.EMPLEADOMAST.VisaFechaExpiracion,   
                      dbo.EMPLEADOMAST.CodigoAFP, dbo.EMPLEADOMAST.NumeroAFP, dbo.EMPLEADOMAST.BancoCTS, dbo.EMPLEADOMAST.TipoCuentaCTS,   
                      dbo.EMPLEADOMAST.TipoMonedaCTS, dbo.EMPLEADOMAST.NumeroCuentaCTS, dbo.EMPLEADOMAST.EstadoEmpleado, dbo.EMPLEADOMAST.TipoPlanilla,   
                      dbo.EMPLEADOMAST.FechaIngreso, dbo.EMPLEADOMAST.FechaUltimaPlanilla, dbo.EMPLEADOMAST.TipoContrato, dbo.EMPLEADOMAST.FechaInicioContrato,   
                      dbo.EMPLEADOMAST.FechaFinContrato, dbo.EMPLEADOMAST.FechaCese, dbo.EMPLEADOMAST.RazonCese, dbo.EMPLEADOMAST.Contratista,   
                      dbo.EMPLEADOMAST.CompaniaSocio, dbo.EMPLEADOMAST.CentroCostos, dbo.EMPLEADOMAST.AFE, dbo.EMPLEADOMAST.DeptoOrganizacion,   
                      dbo.EMPLEADOMAST.TipoHorario, dbo.EMPLEADOMAST.GradoSalario, dbo.EMPLEADOMAST.Cargo, dbo.EMPLEADOMAST.Posicion,   
                      dbo.EMPLEADOMAST.NivelAcceso, dbo.EMPLEADOMAST.FlagIPSSVIDA, dbo.EMPLEADOMAST.FlagSindicato, dbo.EMPLEADOMAST.FlagAccTrabajo,   
                      dbo.EMPLEADOMAST.FlagCooperativa, dbo.EMPLEADOMAST.FlagRetencionJudicial, dbo.EMPLEADOMAST.FlagReingresos, dbo.EMPLEADOMAST.FlagComision,   
                      dbo.EMPLEADOMAST.FlagImpuestoRenta, dbo.EMPLEADOMAST.SueldoActualLocal, dbo.EMPLEADOMAST.SueldoActualDolar,   
         dbo.EMPLEADOMAST.SueldoAnteriorLocal, dbo.EMPLEADOMAST.SueldoAnteriorDolar, dbo.EMPLEADOMAST.MonedaPago,   
                      dbo.EMPLEADOMAST.TarjetadeCredito AS TarjetaCredito, dbo.EMPLEADOMAST.MotivoCese, dbo.EMPLEADOMAST.DepartamentoOrganizacional,   
                      dbo.EMPLEADOMAST.DepartamentoOperacional, dbo.EMPLEADOMAST.Perfil, dbo.EMPLEADOMAST.NivelSalario, dbo.EMPLEADOMAST.FechaLiquidacion,   
                      dbo.EMPLEADOMAST.FechaReingreso, dbo.EMPLEADOMAST.UnidadReplicacion, dbo.EMPLEADOMAST.CodigoCargo,   
                      dbo.EMPLEADOMAST.UltimaFechaPagoVacacion, dbo.EMPLEADOMAST.Gerencia, dbo.EMPLEADOMAST.SubGerencia, dbo.EMPLEADOMAST.RedondeoACuenta,   
                      dbo.EMPLEADOMAST.PlantillaConcepto, dbo.EMPLEADOMAST.RUCCentroAsistenciaSocial, dbo.EMPLEADOMAST.Sucursal, dbo.EMPLEADOMAST.Actividad,   
                      dbo.EMPLEADOMAST.Cliente, dbo.EMPLEADOMAST.ClienteUnidad, dbo.EMPLEADOMAST.EmpleadoNivel, dbo.EMPLEADOMAST.TipoPuesto, dbo.USUARIO.USUARIO,   
                      dbo.USUARIO.USUARIOPERFIL, dbo.USUARIO.PERSONA AS PERSONAUSUARIO, dbo.USUARIO.CLAVE, dbo.USUARIO.EXPIRARPASSWORDFLAG,   
                      dbo.USUARIO.FECHAEXPIRACION, dbo.USUARIO.ULTIMOLOGIN, dbo.SS_GE_Paciente.IdPaciente AS Paciente, dbo.SS_GE_Paciente.TipoPaciente,   
                      dbo.SS_GE_Paciente.Raza, dbo.SS_GE_Paciente.AreaLaboral, dbo.SS_GE_Paciente.Ocupacion, dbo.SS_GE_Paciente.CodigoHC,   
                      dbo.SS_GE_Paciente.CodigoHCAnterior, dbo.SS_GE_Paciente.CodigoHCSecundario, dbo.SS_GE_Paciente.TipoAlmacenamiento, dbo.SS_GE_Paciente.TipoHistoria,   
                      dbo.SS_GE_Paciente.TipoSituacion, dbo.SS_GE_Paciente.IdUbicacion, dbo.SS_GE_Paciente.LugarProcedencia, dbo.SS_GE_Paciente.RutaFoto,   
                      dbo.SS_GE_Paciente.Estado AS EstadoPaciente, dbo.SS_GE_Paciente.NumeroFile, dbo.SS_GE_Paciente.Servicio, dbo.SS_GE_Paciente.Observacion,   
                      dbo.SS_GE_Paciente.IndicadorAsistencia, dbo.SS_GE_Paciente.CantidadAsistencia, dbo.SS_GE_Paciente.UbicacionHHCC,   
                      dbo.SS_GE_Paciente.IndicadorMigradoSiteds, dbo.SS_GE_Paciente.NumeroCaja, dbo.SS_GE_Paciente.IndicadorCodigoBarras,   
                      dbo.SS_GE_Paciente.IDPACIENTE_OK, dbo.SS_GE_Paciente.CodigoAsegurado, dbo.SS_GE_Paciente.NumeroPoliza, dbo.SS_GE_Paciente.NumeroCertificado,   
                      dbo.SS_GE_Paciente.CodigoProducto, dbo.SS_GE_Paciente.CodigoPlan, dbo.SS_GE_Paciente.TipoParentesco, dbo.SS_GE_Paciente.CodigoBeneficio,   
                      dbo.SS_GE_Paciente.Situacion, dbo.SS_GE_Paciente.TomoActual, dbo.SS_GE_Paciente.IndicadorHistoriaFisica, dbo.SS_GE_Paciente.DescripcionHistoria,   
                      dbo.PERSONAMAST.PersonaAnt, dbo.PERSONAMAST.Nombres, dbo.PERSONAMAST.Busqueda
                     
FROM         dbo.PERSONAMAST LEFT OUTER JOIN  
                      dbo.EMPLEADOMAST ON dbo.EMPLEADOMAST.Empleado = dbo.PERSONAMAST.Persona LEFT OUTER JOIN  
                      dbo.USUARIO ON dbo.PERSONAMAST.Persona = dbo.USUARIO.PERSONA LEFT OUTER JOIN  
                      dbo.SS_GE_Paciente ON dbo.PERSONAMAST.Persona = dbo.SS_GE_Paciente.IdPaciente; 


GO
/****** Object:  View [dbo].[VW_PERSONAPACIENTETRIAJE]    Script Date: 16/04/2025 17:07:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[VW_PERSONAPACIENTETRIAJE]  
AS   
			SELECT     dbo.PERSONAMAST.Persona, dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.NombreCompleto,   
                      dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.CodigoBarras, dbo.PERSONAMAST.EsCliente,   
                      dbo.PERSONAMAST.EsEmpleado, dbo.PERSONAMAST.EsOtro, dbo.PERSONAMAST.TipoPersona, dbo.PERSONAMAST.EsProveedor,   
                      dbo.PERSONAMAST.FechaNacimiento, dbo.PERSONAMAST.CiudadNacimiento, dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.Nacionalidad,   
                      dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.NivelInstruccion, dbo.PERSONAMAST.Direccion, dbo.PERSONAMAST.CodigoPostal,   
                      dbo.PERSONAMAST.Provincia, dbo.PERSONAMAST.Departamento, dbo.PERSONAMAST.Telefono, dbo.PERSONAMAST.DocumentoFiscal,   
                      dbo.PERSONAMAST.DocumentoIdentidad, dbo.PERSONAMAST.ACCION, dbo.PERSONAMAST.edad, dbo.PERSONAMAST.rangoEtario, dbo.PERSONAMAST.TipoMedico,   
                      dbo.PERSONAMAST.Correcion, dbo.PERSONAMAST.EsPaciente, dbo.PERSONAMAST.EsEmpresa, dbo.PERSONAMAST.Pais, dbo.PERSONAMAST.FlagActualizacion,   
                      dbo.PERSONAMAST.CuentaMonedaLocal_tmp, dbo.PERSONAMAST.CuentaMonedaExtranjera_tmp, dbo.PERSONAMAST.CorrelativoSCTR,   
                      dbo.PERSONAMAST.SeguroDiscamec, dbo.PERSONAMAST.CodDiscamec, dbo.PERSONAMAST.FecIniDiscamec, dbo.PERSONAMAST.FecFinDiscamec,   
                      dbo.PERSONAMAST.LugarNacimiento, dbo.PERSONAMAST.Celular, dbo.PERSONAMAST.CelularEmergencia, dbo.PERSONAMAST.ParentescoEmergencia,   
                      dbo.PERSONAMAST.DireccionReferencia, dbo.PERSONAMAST.UltimaFechaModif, dbo.PERSONAMAST.TipoPersonaUsuario, dbo.PERSONAMAST.UltimoUsuario,   
                      dbo.PERSONAMAST.Estado, dbo.PERSONAMAST.DireccionEmergencia, dbo.PERSONAMAST.TelefonoEmergencia, dbo.PERSONAMAST.BancoMonedaLocal,   
                      dbo.PERSONAMAST.TipoCuentaLocal, dbo.PERSONAMAST.CuentaMonedaLocal, dbo.PERSONAMAST.BancoMonedaExtranjera,   
                      dbo.PERSONAMAST.TipoCuentaExtranjera, dbo.PERSONAMAST.CuentaMonedaExtranjera, dbo.PERSONAMAST.CorreoElectronico,   
                      dbo.PERSONAMAST.EnfermedadGraveFlag, dbo.PERSONAMAST.IngresoFechaRegistro, dbo.PERSONAMAST.IngresoAplicacionCodigo,   
                      dbo.PERSONAMAST.IngresoUsuario, dbo.PERSONAMAST.PYMEFlag, dbo.EMPLEADOMAST.TipoPago, dbo.EMPLEADOMAST.TipoTrabajadorSalud as TipoTrabajador,   
                      dbo.EMPLEADOMAST.Religion, dbo.EMPLEADOMAST.TipoVisa, dbo.EMPLEADOMAST.VisaFechaInicio, dbo.EMPLEADOMAST.VisaFechaExpiracion,   
                      dbo.EMPLEADOMAST.CodigoAFP, dbo.EMPLEADOMAST.NumeroAFP, dbo.EMPLEADOMAST.BancoCTS, dbo.EMPLEADOMAST.TipoCuentaCTS,   
                      dbo.EMPLEADOMAST.TipoMonedaCTS, dbo.EMPLEADOMAST.NumeroCuentaCTS, dbo.EMPLEADOMAST.EstadoEmpleado, dbo.EMPLEADOMAST.TipoPlanilla,   
                      dbo.EMPLEADOMAST.FechaIngreso, dbo.EMPLEADOMAST.FechaUltimaPlanilla, dbo.EMPLEADOMAST.TipoContrato, dbo.EMPLEADOMAST.FechaInicioContrato,   
                      dbo.EMPLEADOMAST.FechaFinContrato, dbo.EMPLEADOMAST.FechaCese, dbo.EMPLEADOMAST.RazonCese, dbo.EMPLEADOMAST.Contratista,   
                      dbo.EMPLEADOMAST.CompaniaSocio, dbo.EMPLEADOMAST.CentroCostos, dbo.EMPLEADOMAST.AFE, dbo.EMPLEADOMAST.DeptoOrganizacion,   
                      dbo.EMPLEADOMAST.TipoHorario, dbo.EMPLEADOMAST.GradoSalario, dbo.EMPLEADOMAST.Cargo, dbo.EMPLEADOMAST.Posicion,   
                      dbo.EMPLEADOMAST.NivelAcceso, dbo.EMPLEADOMAST.FlagIPSSVIDA, dbo.EMPLEADOMAST.FlagSindicato, dbo.EMPLEADOMAST.FlagAccTrabajo,   
                      dbo.EMPLEADOMAST.FlagCooperativa, dbo.EMPLEADOMAST.FlagRetencionJudicial, dbo.EMPLEADOMAST.FlagReingresos, dbo.EMPLEADOMAST.FlagComision,   
                      dbo.EMPLEADOMAST.FlagImpuestoRenta, dbo.EMPLEADOMAST.SueldoActualLocal, dbo.EMPLEADOMAST.SueldoActualDolar,   
         dbo.EMPLEADOMAST.SueldoAnteriorLocal, dbo.EMPLEADOMAST.SueldoAnteriorDolar, dbo.EMPLEADOMAST.MonedaPago,   
                      dbo.EMPLEADOMAST.TarjetadeCredito AS TarjetaCredito, dbo.EMPLEADOMAST.MotivoCese, dbo.EMPLEADOMAST.DepartamentoOrganizacional,   
                      dbo.EMPLEADOMAST.DepartamentoOperacional, dbo.EMPLEADOMAST.Perfil, dbo.EMPLEADOMAST.NivelSalario, dbo.EMPLEADOMAST.FechaLiquidacion,   
                      dbo.EMPLEADOMAST.FechaReingreso, dbo.EMPLEADOMAST.UnidadReplicacion, dbo.EMPLEADOMAST.CodigoCargo,   
                      dbo.EMPLEADOMAST.UltimaFechaPagoVacacion, dbo.EMPLEADOMAST.Gerencia, dbo.EMPLEADOMAST.SubGerencia, dbo.EMPLEADOMAST.RedondeoACuenta,   
                      dbo.EMPLEADOMAST.PlantillaConcepto, dbo.EMPLEADOMAST.RUCCentroAsistenciaSocial, dbo.EMPLEADOMAST.Sucursal, dbo.EMPLEADOMAST.Actividad,   
                      dbo.EMPLEADOMAST.Cliente, dbo.EMPLEADOMAST.ClienteUnidad, dbo.EMPLEADOMAST.EmpleadoNivel, dbo.EMPLEADOMAST.TipoPuesto, dbo.USUARIO.USUARIO,   
                      dbo.USUARIO.USUARIOPERFIL, dbo.USUARIO.PERSONA AS PERSONAUSUARIO, dbo.USUARIO.CLAVE, dbo.USUARIO.EXPIRARPASSWORDFLAG,   
                      dbo.USUARIO.FECHAEXPIRACION, dbo.USUARIO.ULTIMOLOGIN, dbo.SS_GE_Paciente.IdPaciente AS Paciente, dbo.SS_GE_Paciente.TipoPaciente,   
                      dbo.SS_GE_Paciente.Raza, dbo.SS_GE_Paciente.AreaLaboral, dbo.SS_GE_Paciente.Ocupacion, dbo.SS_GE_Paciente.CodigoHC,   
                      dbo.SS_GE_Paciente.CodigoHCAnterior, dbo.SS_GE_Paciente.CodigoHCSecundario, dbo.SS_GE_Paciente.TipoAlmacenamiento, dbo.SS_GE_Paciente.TipoHistoria,   
                      dbo.SS_GE_Paciente.TipoSituacion, dbo.SS_GE_Paciente.IdUbicacion, dbo.SS_GE_Paciente.LugarProcedencia, dbo.SS_GE_Paciente.RutaFoto,   
                      dbo.SS_GE_Paciente.Estado AS EstadoPaciente, dbo.SS_GE_Paciente.NumeroFile, dbo.SS_GE_Paciente.Servicio, dbo.SS_GE_Paciente.Observacion,   
                      dbo.SS_GE_Paciente.IndicadorAsistencia, dbo.SS_GE_Paciente.CantidadAsistencia, dbo.SS_GE_Paciente.UbicacionHHCC,   
                      dbo.SS_GE_Paciente.IndicadorMigradoSiteds, dbo.SS_GE_Paciente.NumeroCaja, dbo.SS_GE_Paciente.IndicadorCodigoBarras,   
                      dbo.SS_GE_Paciente.IDPACIENTE_OK, dbo.SS_GE_Paciente.CodigoAsegurado, dbo.SS_GE_Paciente.NumeroPoliza, dbo.SS_GE_Paciente.NumeroCertificado,   
                      dbo.SS_GE_Paciente.CodigoProducto, dbo.SS_GE_Paciente.CodigoPlan, dbo.SS_GE_Paciente.TipoParentesco, dbo.SS_GE_Paciente.CodigoBeneficio,   
                      dbo.SS_GE_Paciente.Situacion, dbo.SS_HC_EpisodioTriaje.IdEpisodioTriaje as TomoActual,
					  dbo.SS_HC_EpisodioTriaje.IdEspecialidad as IndicadorHistoriaFisica, SS_GE_Paciente.DescripcionHistoria,   
                      SS_HC_EpisodioTriaje.CodigoOT as PersonaAnt, dbo.PERSONAMAST.Nombres, dbo.PERSONAMAST.Busqueda				  
                     
FROM         dbo.PERSONAMAST  WITH(NOLOCK) 
		LEFT OUTER JOIN   EMPLEADOMAST  WITH(NOLOCK) ON dbo.EMPLEADOMAST.Empleado = dbo.PERSONAMAST.Persona 
		LEFT OUTER JOIN   USUARIO  WITH(NOLOCK) ON dbo.PERSONAMAST.Persona = dbo.USUARIO.PERSONA 
		LEFT OUTER JOIN   SS_GE_Paciente  WITH(NOLOCK) ON dbo.PERSONAMAST.Persona = dbo.SS_GE_Paciente.IdPaciente 
		LEFT OUTER JOIN	  SS_HC_EpisodioTriaje  WITH(NOLOCK) on SS_HC_EpisodioTriaje.IdPaciente= PERSONAMAST.Persona

GO
/****** Object:  View [dbo].[VW_ServicioPrestacion]    Script Date: 16/04/2025 17:07:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[VW_ServicioPrestacion]
AS
SELECT 
 SS_GE_ComponentePrestacion.Componente, 
SS_GE_ComponentePrestacion.ValorMedida, 
SS_GE_ComponentePrestacion.CantidadAsistentes, 
SS_GE_ComponentePrestacion.Instrumentistas, 
SS_GE_ComponentePrestacion.DiasHospitalizacion, 
SS_GE_ComponentePrestacion.CodigoSegus, 
SS_GE_ComponentePrestacion.CodigoNuevo, 
SS_GE_ComponentePrestacion.Estado, 
CM_CO_Componente.Nombre, 
CM_CO_Componente.Descripcion, 
CM_CO_Componente.Compania, 
CM_CO_Componente.CentroCosto, 
CM_CO_Componente.ClasificadorMovimiento, 
CM_CO_Componente.ConceptoGasto, 
CM_CO_Componente.IndicadorImpuesto, 
CM_CO_ClasificacionComponente.IdClasificacion, 
CM_CO_ClasificacionComponente.Codigo CodClasificacion, 
CM_CO_ClasificacionComponente.Nombre NomClasificacion, 
CM_CO_ClasificacionComponente.Orden, 
SS_GE_ComponentePrestacion.TipoPrestacion, 
IsNull(SS_GE_ComponentePrestacion.IndicadorCita,1)IndicadorCita, 
IsNull(SS_GE_ComponentePrestacion.IndicadorHC,1)IndicadorHC, 
CM_CO_ClasificacionComponente.CadenaRecursividad, 
SS_GE_ComponentePrestacion.IndicadorPrestacionPrincipal, 
SS_GE_ComponentePrestacion.IndicadorRequierePersonal, 
SS_GE_Servicio.IdServicio,
SS_GE_Servicio.IdGrupoAtencion, 
SS_GE_Servicio.Codigo, 
SS_GE_Servicio.TipoOrdenAtencion,'                         ' ACCION
FROM SS_GE_ComponentePrestacion 
INNER JOIN CM_CO_Componente ON CM_CO_Componente.CodigoComponente =  SS_GE_ComponentePrestacion.Componente 
INNER JOIN CM_CO_ClasificacionComponente ON CM_CO_Componente.IdClasificacion = CM_CO_ClasificacionComponente.IdClasificacion 
LEFT JOIN SS_GE_ServicioPrestacion ON SS_GE_ComponentePrestacion.Componente = SS_GE_ServicioPrestacion.Componente 
LEFT JOIN SS_GE_Servicio ON SS_GE_ServicioPrestacion.IdServicio = SS_GE_Servicio.IdServicio ;



GO
/****** Object:  View [dbo].[VW_SS_GE_EMPRESASEGURO]    Script Date: 16/04/2025 17:07:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[VW_SS_GE_EMPRESASEGURO]
AS
SELECT  
SS_GE_EMPRESASEGURO.IDEMPRESA, 
SS_GE_EMPRESASEGURO.CODIGO, 
SS_GE_EMPRESASEGURO.DESCRIPCION,
SS_GE_EMPRESASEGURO.TIPOEMPRESA, 
SS_GE_EMPRESASEGURO.TIPOSEGURO, 
SS_GE_EMPRESASEGURO.ESTADO, SS_GE_EMPRESASEGURO.USUARIOCREACION, 
SS_GE_EMPRESASEGURO.FECHACREACION, 
SS_GE_EMPRESASEGURO.USUARIOMODIFICACION, 
SS_GE_EMPRESASEGURO.FECHAMODIFICACION,
SS_GE_EMPRESASEGURO.ACCION,
PERSONAMAST.PERSONA,
PERSONAMAST.NOMBRECOMPLETO,
PERSONAMAST.DOCUMENTOFISCAL,
PERSONAMAST.DIRECCION,
PERSONAMAST.TELEFONO,
GE_TIPOEMPRESA.DESCRIPCION AS TIPOEMPRESANOMBRE,
GE_TIPOSEGURO.DESCRIPCION AS TIPOSEGURONOMBRE
FROM SS_GE_EMPRESASEGURO WITH(NOLOCK) INNER JOIN 
PERSONAMAST WITH(NOLOCK) ON SS_GE_EMPRESASEGURO.IDEMPRESA = PERSONAMAST.PERSONA
LEFT JOIN GE_VARIOS AS GE_TIPOEMPRESA WITH(NOLOCK) 
ON GE_TIPOEMPRESA.CODIGOTABLA = 'TIPOEMPRESA'
AND SS_GE_EMPRESASEGURO.TIPOEMPRESA = GE_TIPOEMPRESA.NEMONICO
LEFT JOIN GE_VARIOS AS GE_TIPOSEGURO WITH(NOLOCK) 
ON GE_TIPOSEGURO.CODIGOTABLA = 'TIPOSEGURO'
AND SS_GE_EMPRESASEGURO.TIPOSEGURO = GE_TIPOSEGURO.SECUENCIAL;
GO
/****** Object:  View [dbo].[VW_SS_GE_ESPECIALIDADMEDICO]    Script Date: 16/04/2025 17:07:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[VW_SS_GE_ESPECIALIDADMEDICO]
AS
SELECT PERSONAMAST.PERSONA, PERSONAMAST.ORIGEN, PERSONAMAST.NOMBRES, PERSONAMAST.NOMBRECOMPLETO, PERSONAMAST.BUSQUEDA, PERSONAMAST.TIPODOCUMENTOIDENTIDAD, PERSONAMAST.DOCUMENTOIDENTIDAD, PERSONAMAST.ESCLIENTE, PERSONAMAST.ESPROVEEDOR, PERSONAMAST.ESEMPLEADO, PERSONAMAST.ESOTRO, PERSONAMAST.TIPOPERSONA, PERSONAMAST.FECHANACIMIENTO, PERSONAMAST.CIUDADNACIMIENTO, PERSONAMAST.DOCUMENTOFISCAL, PERSONAMAST.DOCUMENTO, PERSONAMAST.PERSONAANT, PERSONAMAST.CORREOELECTRONICO, PERSONAMAST.CLASEPERSONACODIGO, PERSONAMAST.ESTADO, PERSONAMAST.ULTIMOUSUARIO, PERSONAMAST.ULTIMAFECHAMODIF, PERSONAMAST.TIPOPERSONAUSUARIO,EMPLEADOMAST.CMP,EMPLEADOMAST.FOTO,SS_GE_ESPECIALIDADMEDICO.NUMEROREGISTROESPECIALIDAD,SS_GE_ESPECIALIDADMEDICO.TIPOGENERACIONCITA,SS_GE_ESPECIALIDADMEDICO.TIEMPOPROMEDIOATENCION,SS_GE_ESPECIALIDAD.IDESPECIALIDAD,SS_GE_ESPECIALIDAD.NOMBRE,SS_GE_ESPECIALIDADMEDICO.ACCION,PERSONAMAST.SEXO,PERSONAMAST.DIRECCION,PERSONAMAST.TELEFONO,1 AS PROGRAMADO,0 AS SERVICIO,'XXX' AS TIPOHORARIO,0 AS IDHORARIO,EMPLEADOMAST.CODIGOUSUARIOFROM EMPLEADOMAST WITH(NOLOCK) INNER JOIN PERSONAMAST WITH(NOLOCK) ON EMPLEADOMAST.EMPLEADO = PERSONAMAST.PERSONA AND EMPLEADOMAST.TIPOTRABAJADORSALUD = '08'LEFT JOIN SS_GE_ESPECIALIDADMEDICO WITH(NOLOCK) ON EMPLEADOMAST.EMPLEADO = SS_GE_ESPECIALIDADMEDICO.IDMEDICOLEFT JOIN SS_GE_ESPECIALIDAD WITH(NOLOCK) 
ON SS_GE_ESPECIALIDADMEDICO.IDESPECIALIDAD = SS_GE_ESPECIALIDAD.IDESPECIALIDAD 
WHERE PERSONAMAST.ESTADO = 'A';
GO
/****** Object:  View [dbo].[VW_SS_HC_ASIGNACIONMEDICO]    Script Date: 16/04/2025 17:07:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[VW_SS_HC_ASIGNACIONMEDICO]  
AS 
  SELECT personamast.persona AS empleado, 
         personamast.origen, 
         personamast.busqueda, 
         personamast.tipodocumentoidentidad, 
         personamast.documentoidentidad, 
         personamast.escliente, 
         personamast.esproveedor, 
         personamast.esempleado, 
         personamast.esotro, 
         personamast.tipopersona, 
         personamast.fechanacimiento, 
         personamast.ciudadnacimiento, 
         personamast.documentofiscal, 
         personamast.documento, 
         personamast.personaant, 
         personamast.correoelectronico, 
         personamast.clasepersonacodigo, 
         personamast.estado  AS estadopersona, 
         personamast.ultimousuario, 
         personamast.ultimafechamodif, 
         personamast.tipopersonausuario, 
         personamast.fecfindiscamec, 
         personamast.fecinidiscamec, 
         empleadomast.cmp, 
         empleadomast.foto, 
         personamast.sexo, 
         personamast.direccion, 
         personamast.telefono, 
         empleadomast.codigousuario, 
         ss_hc_asignacionmedico.unidadreplicacion, 
         ss_hc_asignacionmedico.idpaciente, 
         personamast.nombres, 
         personamast.nombrecompleto, 
         ss_hc_asignacionmedico.idasignacionmedico, 
         P2.nombrecompleto   AS medico1, 
         ss_hc_asignacionmedico.tipoasignacion, 
         ss_hc_asignacionmedico.observaciones, 
         ss_hc_asignacionmedico.estado, 
         ss_hc_asignacionmedico.usuariocreacion, 
         ss_hc_asignacionmedico.fechacreacion, 
         ss_hc_asignacionmedico.usuariomodificacion, 
         ss_hc_asignacionmedico.fechamodificacion, 
         ss_hc_asignacionmedico.secuencia,
         ss_hc_asignacionmedico.secuenciaReferida,
         ss_hc_asignacionmedico.accion, 
         ss_ge_paciente.codigohc, 
         ss_ge_paciente.codigohcanterior, 
         ss_ge_paciente.servicio,
         ss_ge_paciente.TipoPaciente,
         SS_HC_EpisodioAtencion.IdPersonalSalud,
         ss_hc_episodioatencion.CodigoOA,
         ss_hc_episodioatencion.FechaAtencion
       FROM  dbo.SS_HC_EpisodioAtencion INNER JOIN
                      dbo.SS_HC_EpisodioClinico ON dbo.SS_HC_EpisodioAtencion.UnidadReplicacionEC = dbo.SS_HC_EpisodioClinico.UnidadReplicacion AND 
                      dbo.SS_HC_EpisodioAtencion.IdPaciente = dbo.SS_HC_EpisodioClinico.IdPaciente AND 
                      dbo.SS_HC_EpisodioAtencion.EpisodioClinico = dbo.SS_HC_EpisodioClinico.EpisodioClinico INNER JOIN
                      dbo.SS_GE_Paciente ON dbo.SS_HC_EpisodioClinico.IdPaciente = dbo.SS_GE_Paciente.IdPaciente RIGHT OUTER JOIN
                      dbo.PERSONAMAST ON dbo.SS_GE_Paciente.IdPaciente = dbo.PERSONAMAST.Persona LEFT OUTER JOIN
                      dbo.SS_HC_AsignacionMedico ON dbo.SS_HC_AsignacionMedico.IdPaciente = dbo.SS_HC_EpisodioAtencion.IdPaciente LEFT JOIN 
                      personamast p2 WITH(nolock) ON p2.persona = ss_hc_asignacionmedico.idasignacionmedico LEFT JOIN 
                      empleadomast ON ( empleadomast.empleado = personamast.persona ) 

; 
  
  
  
GO
/****** Object:  View [dbo].[VW_SS_HC_TABLAFORMATO_VALIDACION]    Script Date: 16/04/2025 17:07:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[VW_SS_HC_TABLAFORMATO_VALIDACION]
AS
SELECT        dbo.SS_HC_Formato.IdFormato, dbo.SS_HC_Formato.Nivel AS FormatoNivelID, dbo.SS_HC_Formato.IdFormatoPadre, dbo.SS_HC_Formato.CodigoFormato, 
                         dbo.SS_HC_Formato.CodigoFormatoPadre, dbo.SS_HC_Formato.Descripcion AS DescripcionFormato, dbo.SS_HC_Formato.TipoFormato, 
                         dbo.SS_HC_Formato.Estado AS EstadoFormato, dbo.SS_HC_Tabla.IdFavoritoTabla, dbo.SS_HC_Tabla.NombreTabla, 
                         dbo.SS_HC_Tabla.Descripcion AS DescripcionTabla, dbo.SS_HC_Tabla.TipoTabla, dbo.SS_HC_Tabla.Estado AS EstadoTabla, dbo.SS_HC_TablaCampo.IdCampo, 
                         dbo.SS_HC_TablaCampo.NombreCampo, dbo.SS_HC_TablaCampo.Descripcion AS DescripcionCampo, dbo.SS_HC_TablaCampo.TipoCampo, 
                         dbo.SS_HC_TablaCampo.Longitud, dbo.SS_HC_TablaCampo.Decimales, dbo.SS_HC_TablaCampo.Estado AS EstadoTablaCampo, 
                         dbo.SS_HC_FormatoCampo.SecuenciaCampo, dbo.SS_HC_FormatoCampo.IdSeccionFormato, dbo.SS_HC_FormatoCampo.ValorPorDefecto, 
                         dbo.SS_HC_FormatoCampo.IndicadorObligatorio, dbo.SS_HC_FormatoCampo.IndicadorCampoCalculado, dbo.SS_HC_FormatoCampo.Formula, 
                         dbo.SS_HC_FormatoCampo.IndicadorValoresVarios, dbo.SS_HC_FormatoCampo.TablaValoresVarios, dbo.SS_HC_FormatoCampo.IndicadorRango, 
                         dbo.SS_HC_FormatoCampo.RangoDesde, dbo.SS_HC_FormatoCampo.RangoHasta, dbo.SS_HC_FormatoCampo.IndicadorReglaNegocio, 
                         dbo.SS_HC_FormatoCampo.ReglaNegocio, dbo.SS_HC_FormatoCampo.Observaciones, dbo.SS_HC_FormatoCampo.Estado AS EstadoFormatoCampo, 
                         dbo.SS_HC_FormatoCampo.IdConcepto, dbo.SS_HC_FormatoCampo.IdAgrupadorNivel, dbo.SS_HC_FormatoCampo.IdObjetoAgrupador, 
                         dbo.SS_HC_FormatoCampo.IdColumna, dbo.SS_HC_FormatoCampo.IdFila, dbo.SS_HC_FormatoCampo.IdEvento, dbo.SS_HC_FormatoCampo.IdParameterEnvio, 
                         dbo.SS_HC_FormatoCampo.Orden, dbo.SS_HC_FormatoCampo.IdAgrupadorNivelPadre, dbo.SS_HC_ControlValidacion.SecuenciaValidacion, 
                         dbo.SS_HC_ControlValidacion.IdComponente, dbo.SS_HC_ControlValidacion.IdAtributo, dbo.SS_HC_ControlValidacion.TipoValidacion, 
                         dbo.SS_HC_ControlValidacion.FlagTipoDato, dbo.SS_HC_ControlValidacion.ValorTexto, dbo.SS_HC_ControlValidacion.ValorNumerico, 
                         dbo.SS_HC_ControlValidacion.ValorDate, dbo.SS_HC_ControlValidacion.SecuenciaValidacionRef, dbo.SS_HC_ControlValidacion.Estado AS EstadoValidacion, 
                         dbo.SS_HC_ControlValidacion.UsuarioCreacion, dbo.SS_HC_ControlValidacion.FechaCreacion, dbo.SS_HC_ControlValidacion.UsuarioModificacion, 
                         dbo.SS_HC_ControlValidacion.FechaModificacion, dbo.SS_HC_ControlValidacion.Accion, dbo.SS_HC_ControlValidacion.Version, 
                         dbo.SS_HC_ControlComponente.Nombre AS NombreComponente, dbo.SS_HC_ControlComponente.Tipo AS TipoComponente, 
                         dbo.SS_HC_ControlComponente.Estado AS EstadoComponente, dbo.SS_HC_ControlAtributo.Nombre AS NombreAtributo, 
                         dbo.SS_HC_ControlAtributo.Estado AS EstadoAtributo, dbo.SS_HC_ControlValidacion.Idioma AS IdiomaProperty
FROM            dbo.SS_HC_FormatoCampo INNER JOIN
                         dbo.SS_HC_Formato ON dbo.SS_HC_Formato.IdFormato = dbo.SS_HC_FormatoCampo.IdFormato INNER JOIN
                         dbo.SS_HC_Tabla ON dbo.SS_HC_FormatoCampo.IdFavoritoTabla = dbo.SS_HC_Tabla.IdFavoritoTabla INNER JOIN
                         dbo.SS_HC_TablaCampo ON dbo.SS_HC_FormatoCampo.IdFavoritoTabla = dbo.SS_HC_TablaCampo.IdFavoritoTabla AND 
                         dbo.SS_HC_FormatoCampo.IdCampo = dbo.SS_HC_TablaCampo.IdCampo AND 
                         dbo.SS_HC_Tabla.IdFavoritoTabla = dbo.SS_HC_TablaCampo.IdFavoritoTabla LEFT OUTER JOIN
                         dbo.SS_HC_ControlValidacion ON dbo.SS_HC_ControlValidacion.IdFormato = dbo.SS_HC_FormatoCampo.IdFormato AND 
                         dbo.SS_HC_ControlValidacion.SecuenciaCampo = dbo.SS_HC_FormatoCampo.SecuenciaCampo AND 
                         dbo.SS_HC_ControlValidacion.IdSeccionFormato = dbo.SS_HC_FormatoCampo.IdSeccionFormato LEFT OUTER JOIN
                         dbo.SS_HC_ControlComponente ON dbo.SS_HC_ControlComponente.IdComponente = dbo.SS_HC_ControlValidacion.IdComponente LEFT OUTER JOIN
                         dbo.SS_HC_ControlAtributo ON dbo.SS_HC_ControlAtributo.IdAtributo = dbo.SS_HC_ControlValidacion.IdAtributo
GO
/****** Object:  View [dbo].[VW_SS_IT_ProcesoHistoriaAdjunta]    Script Date: 16/04/2025 17:07:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[VW_SS_IT_ProcesoHistoriaAdjunta]
AS
SELECT
0 as idsecuencia,
CodigoSucursal, 
UnidadReplicacion, 
IdAplicativo, 
CodigoReferencia, 
CodigoHHCC, 
DNI, 
IdPaciente, 
TipoAtencion, 
Fecha, 
Especialidad, 
IdEspecialidad, 
Servicio, 
IdServicio, 
CodigoMedico, 
IdMedico, 
CodigoAdmision, 
CodigoOA, 
CodigoDiagnostico, 
IdDiagnostico, 
NumeroPagina, 
RutaImagen, 
FechaRecepcion, 
IndicadorProcesado, 
IndicadorError, 
DescripcionError, 
Accion,
Row_number() OVER( ORDER BY IdPaciente desc) AS Rownumber
FROM
SS_IT_ProcesoHistoriaAdjunta
GO
/****** Object:  View [dbo].[VW_TABLACAMPO]    Script Date: 16/04/2025 17:07:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[VW_TABLACAMPO]            
AS            
SELECT          
                    dbo.SS_HC_Tabla.IdFavoritoTabla,   
                    dbo.SS_HC_TablaCampo.IdCampo,   
                    dbo.SS_HC_Tabla.Descripcion as DescripcionTabla,   
                    dbo.SS_HC_TablaCampo.NombreCampo as DescripTablaCampo,        
                    dbo.SS_HC_TablaCampo.NumeroClavePrimaria,    
                    dbo.SS_HC_TablaCampo.Estado,   
                    dbo.SS_HC_TablaCampo.Accion,   
                    dbo. SS_HC_Tabla.TipoTabla      
        
FROM     dbo.SS_HC_Tabla INNER JOIN            
         dbo.SS_HC_TablaCampo               
      ON dbo.SS_HC_Tabla.IdFavoritoTabla = dbo.SS_HC_TablaCampo.IdFavoritoTabla         


GO

