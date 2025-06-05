
GO
CREATE OR ALTER FUNCTION [dbo].[FUN_DetalleIndicaciones](@IdConsultaExterna INT =NULL,@Secuendial INT =NULL )
        returns varchar(max)
            as
            begin                    
            declare @variable varchar(max)
			SELECT @variable=Descripcion FROM SS_CE_CEDetalleIndicaciones A
			INNER JOIN 
			(	SELECT IdConsultaExterna,MAX(Secuencial)Secuencial FROM  SS_CE_CEDetalleIndicaciones 
				WHERE IdConsultaExterna=@IdConsultaExterna and Secuencial= @Secuendial
				GROUP BY IdConsultaExterna  ) B ON  A.IdConsultaExterna = B.IdConsultaExterna AND A.Secuencial=B.Secuencial
			WHERE A.IdConsultaExterna=@IdConsultaExterna and A.Secuencial= @Secuendial
            return @variable
        end

GO
CREATE OR ALTER FUNCTION [dbo].[UFN_DIAGNOSTICO_FE]
(
    @IdConsultaExterna INT = NULL
)
RETURNS VARCHAR(MAX)
AS
BEGIN 
    DECLARE @Diagnosticos VARCHAR(MAX);

    IF @IdConsultaExterna IS NULL
        RETURN NULL;

    SELECT 
        @Diagnosticos = STUFF((
            SELECT 
                ', [' + RTRIM(D.CodigoDiagnostico) + '] ' + D.Descripcion
            FROM 
                SS_CE_ConsultaExternaDiagnostico AS CED
            INNER JOIN 
                SS_GE_Diagnostico AS D ON CED.IdDiagnostico = D.IdDiagnostico
            WHERE 
                CED.IdConsultaExterna = @IdConsultaExterna
            FOR XML PATH(''), TYPE
        ).value('.', 'VARCHAR(MAX)'), 1, 2, '');

    RETURN @Diagnosticos;
END;
GO

CREATE OR ALTER VIEW [dbo].[VW_SS_HCE_VisorDescansoMedico] 
AS 
	SELECT 'CONSULTA' TAB, EXT.IdOrdenAtencion,EXT.LineaOrdenAtencion, EXT.IdConsultaExterna, DA.IdDescanso, OA.IdPaciente,
		DA.FechaInicio,DA.FechaFinal, DA.Observaciones, DA.TxtObservaciones Dia,DBO.UFN_DIAGNOSTICO_FE(EXT.IdConsultaExterna) Diagnostico
		, DA.Estado, ''  UsuarioCreacion,OA.Sucursal,
		DA.FechaCreacion,	  OA.UnidadReplicacion UsuarioModificacion,	 DA.FechaModificacion, per.Documento,per.TipoDocumento
	FROM SS_CE_DescansoMedico DA			
	  INNER JOIN SS_CE_ConsultaExterna EXT		WITH(NOLOCK)	ON EXT.IdConsultaExterna= DA.IdConsultaExterna
	  INNER JOIN SS_AD_OrdenAtencion OA			WITH(NOLOCK)	ON EXT.IdOrdenAtencion  = OA.IdOrdenAtencion
	  INNER JOIN PersonaMast per				WITH(NOLOCK)	ON OA.IdPaciente		= per.Persona 
	--  LEFT JOIN SS_GE_Especialidad	ESP			WITH(NOLOCK)	ON ESP.IdEspecialidad	= IsNull(EXT.Especialidad, OA.Especialidad)
	  WHERE LEN(DA.TxtObservaciones)>0

GO

CREATE OR ALTER VIEW [dbo].[VW_SS_HCE_VisorProcedimiento] 
AS 
SELECT 'INFORME' TAB, EXT.IdOrdenAtencion,EXT.LineaOrdenAtencion, EXT.IdProcedimiento,det.IdInforme, det.Secuencial, det.IdConcepto, 
	det.IdPlantilla, det.SecuencialPlantilla,co.Descripcion, isnull(det.ValorNumerico,0.000000)ValorNumerico,
	isnull( det.ValorCadena,'')ValorCadena, 	det.ValorFecha, det.Estado, 
	det.UsuarioCreacion, det.FechaCreacion, det.UsuarioModificacion,	 det.FechaModificacion, CO.Codigo, CO.TipoDato, 
	OA.IdPaciente,per.documento,per.tipodocumento, OA.Sucursal
FROM SS_PR_InformeDetalle det				WITH(NOLOCK)
	INNER JOIN SS_PR_Informe inf			WITH(NOLOCK)	ON inf.IdInforme		= det.IdInforme AND inf.IdPlantilla=40
	INNER JOIN SS_PR_Procedimiento EXT	WITH(NOLOCK)		ON EXT.IdProcedimiento  = inf.IdProcedimiento  
	INNER JOIN SS_AD_OrdenAtencionDetalle OAD		WITH(NOLOCK)	ON EXT.IdOrdenAtencion  = OAD.IdOrdenAtencion and EXT.LineaOrdenAtencion= OAD.Linea
	INNER JOIN SS_AD_OrdenAtencion OA		WITH(NOLOCK)	ON OAD.IdOrdenAtencion  = OA.IdOrdenAtencion 
	INNER JOIN PersonaMast per				WITH(NOLOCK)	ON OA.IdPaciente		= per.Persona 
	LEFT  JOIN SS_GE_PlantillaConcepto CO	WITH(NOLOCK)	ON CO.IdConcepto		= det.IdConcepto 

GO

CREATE OR ALTER VIEW [dbo].[VW_SS_HCE_GestorInformes]  
AS  
SELECT DISTINCT 
  SS_AD_OrdenAtencion.Sucursal,
  SS_AD_OrdenAtencion.IdOrdenAtencion,
  SS_AD_OrdenAtencion.CodigoOA,
  SS_GE_TipoAtencion.Descripcion,
  SS_AD_OrdenAtencion.IdPaciente,
  PersonaMast.TipoDocumento,
  PersonaMast.Documento,
  PersonaMast.NombreCompleto PacienteNombre,
  PersonaMast.Nombres,
  PersonaMast.ApellidoPaterno,
  PersonaMast.ApellidoMaterno,
  PersonaMast.Sexo,
  PersonaMast.FechaNacimiento,
  '' Especialidad_Nombre,
  SS_GE_Servicio.Descripcion TipoOrdenAtencion_Nombre,
  0 IdEspecialidad,
  SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion,
  SS_AD_OrdenAtencionDetalle.TipoComponente,
  SS_AD_OrdenAtencion.FechaInicio,
  SS_AD_OrdenAtencion.FechaFinal,
  SS_AD_OrdenAtencion.TipoAtencion
FROM SS_AD_OrdenAtencion WITH (NOLOCK)
INNER JOIN PersonaMast WITH (NOLOCK)
  ON SS_AD_OrdenAtencion.IDPACIENTE = PersonaMast.PERSONA
INNER JOIN SS_GE_TipoAtencion WITH (NOLOCK)
  ON (SS_GE_TipoAtencion.IdTipoAtencion = SS_AD_OrdenAtencion.TipoAtencion)
INNER JOIN SS_AD_OrdenAtencionDetalle  WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_AD_OrdenAtencion.IdOrdenAtencion
LEFT JOIN SS_GE_Servicio WITH (NOLOCK) ON (SS_GE_Servicio.IdServicio = SS_AD_OrdenAtencionDetalle.IdServicio)
LEFT JOIN SS_GE_Especialidad WITH (NOLOCK) ON (SS_GE_Especialidad.IdEspecialidad = SS_AD_OrdenAtencionDetalle.Especialidad)
WHERE SS_AD_OrdenAtencionDetalle.TipoComponente = 'C'
AND SS_AD_OrdenAtencion.Estado = 2
AND SS_GE_Servicio.IdGrupoAtencion IN (2, 4, 8,15, 16, 17, 18, 19)
AND SS_AD_OrdenAtencionDetalle.IndicadorDisponible = 2
AND SS_AD_OrdenAtencionDetalle.Estado = 2
	  
GO

CREATE OR ALTER VIEW [dbo].[VW_SS_HCE_VisorAnamnesis] 
AS 
SELECT 'ANAMNESIS' TAB, EXT.IdOrdenAtencion,EXT.LineaOrdenAtencion, det.IdInforme, det.Secuencial, det.IdConcepto, 
	det.IdPlantilla, det.SecuencialPlantilla,co.Descripcion, isnull(det.ValorNumerico,0.000000)ValorNumerico,
	isnull( det.ValorCadena,'')ValorCadena, 	det.ValorFecha, det.Estado, 
	det.UsuarioCreacion, det.FechaCreacion, det.UsuarioModificacion,	 det.FechaModificacion, CO.Codigo, CO.TipoDato, 
	0 IndAutosize, 0 IndAjustarCampo ,OA.IdPaciente,per.documento,inf.TipoInforme,per.tipodocumento, OA.Sucursal
FROM SS_CE_InformeDetalle det				WITH(NOLOCK)
	INNER JOIN SS_CE_Informe inf			WITH(NOLOCK)	ON inf.IdInforme		= det.IdInforme 
	INNER JOIN SS_CE_ConsultaExterna EXT	WITH(NOLOCK)	ON EXT.IdConsultaExterna= inf.IdConsultaExterna
	INNER JOIN SS_AD_OrdenAtencion OA		WITH(NOLOCK)	ON EXT.IdOrdenAtencion  = OA.IdOrdenAtencion
	INNER JOIN PersonaMast per				WITH(NOLOCK)	ON OA.IdPaciente		= per.Persona 
	LEFT  JOIN SS_GE_PlantillaConcepto CO	WITH(NOLOCK)	ON CO.IdConcepto		= det.IdConcepto 
GO

CREATE OR ALTER VIEW [dbo].[VW_SS_HCE_VisorDiagnostico] 
AS 
	SELECT 'CONSULTA' TAB, EXT.IdOrdenAtencion,EXT.LineaOrdenAtencion, det.IdConsultaExterna, det.iddiagnostico, OA.IdPaciente,
		DA.Nombre,DA.CodigoDiagnostico, det.TipoDiagnostico, det.TipoAntecedente, det.IndicadorAntecedente, det.DetalleDiagnostico,	 
		det.Estado, ESP.Nombre  UsuarioCreacion, det.FechaCreacion,	 CASE  WHEN OA.UnidadReplicacion='LIMA' THEN '0001' ELSE OA.UnidadReplicacion END  UsuarioModificacion,	 det.FechaModificacion,per.documento,per.tipodocumento
	FROM SS_CE_ConsultaExternaDiagnostico det	WITH(NOLOCK)
	  INNER JOIN SS_GE_Diagnostico DA			WITH(NOLOCK)	ON det.iddiagnostico=DA.IdDiagnostico
	  INNER JOIN SS_CE_ConsultaExterna EXT		WITH(NOLOCK)	ON EXT.IdConsultaExterna= det.IdConsultaExterna
	  INNER JOIN SS_AD_OrdenAtencion OA			WITH(NOLOCK)	ON EXT.IdOrdenAtencion  = OA.IdOrdenAtencion
	  INNER JOIN PersonaMast per				WITH(NOLOCK)	ON OA.IdPaciente		= per.Persona 
	  LEFT JOIN SS_GE_Especialidad	ESP		WITH(NOLOCK)	ON ESP.IdEspecialidad	= IsNull(EXT.Especialidad, OA.Especialidad)
	UNION

	SELECT 'PROCEDIMIENTO' TAB, EXT.IdOrdenAtencion,EXT.LineaOrdenAtencion, det.IdProcedimiento IdConsultaExterna, det.iddiagnostico, OA.IdPaciente,
		DA.Nombre,DA.CodigoDiagnostico, det.TipoDiagnostico, '' TipoAntecedente, '' IndicadorAntecedente, '' DetalleDiagnostico,	 
		det.Estado, ESP.Nombre UsuarioCreacion, det.FechaCreacion,	CASE  WHEN OA.UnidadReplicacion='LIMA' THEN '0001' ELSE OA.UnidadReplicacion END   UsuarioModificacion,	 det.FechaModificacion,per.documento,per.tipodocumento
	FROM SS_PR_ProcedimientoDiagnostico det	WITH(NOLOCK)
	  INNER JOIN SS_GE_Diagnostico DA		WITH(NOLOCK)	ON det.iddiagnostico=DA.IdDiagnostico
	  INNER JOIN SS_PR_Procedimiento EXT	WITH(NOLOCK)	ON EXT.IdProcedimiento= det.IdProcedimiento
	  INNER JOIN SS_AD_OrdenAtencion OA		WITH(NOLOCK)	ON EXT.IdOrdenAtencion  = OA.IdOrdenAtencion
	  INNER JOIN PersonaMast per			WITH(NOLOCK)	ON OA.IdPaciente		= per.Persona 
	  LEFT JOIN SS_GE_Especialidad	ESP		WITH(NOLOCK)	ON ESP.IdEspecialidad	= IsNull(EXT.Especialidad, OA.Especialidad)
GO

CREATE OR ALTER VIEW [dbo].[VW_SS_HCE_VisorExamen] 
AS 
	SELECT 'EXAMEN' TAB, det.Componente  Nombre, OAD.IdOrdenAtencion,
	det.Linea, OAD.TipoOrdenAtencion, det.IdConsultaExterna, 
	det.Linea as lineaconsulta, OA.CodigoOA, OA.FechaPreparacion, OA.FechaInicio, 
	OA.FechaFinal, OA.TipoAtencion, OA.TipoPaciente, OAD.IdServicio, 
	OA.IdEmpresaAseguradora, OA.EstadoDocumento, 
	OA.EstadoDocumentoAnterior, OA.Estado, SS_GE_Servicio.Descripcion
	as IdServicio_Nombre, SS_GE_GrupoAtencion.Nombre as IdGrupoAtencion_Nombre, SS_GE_GrupoAtencion.IdGrupoAtencion, 
	SS_GE_Especialidad.Nombre as IdEspecialidad_Nombre, OAD.Especialidad, DA.Nombre as Componente_Nombre,
	det.IndicadorEPS, Observacion = convert(varchar(10) ,OA.FechaPreparacion,103) ,OA.IdPaciente ,per.documento,per.tipodocumento, OA.Sucursal,
	OAD.Estado EstDet,OAD.FechaCreacion,OAD.GrupoInterfase,OAD.SituacionInterfase,pr.IdProcedimiento,pr.EstadoDocumento EstadoDocPro
FROM SS_CE_ConsultaExternaOrdenMedica  det	WITH(NOLOCK)
INNER JOIN SS_AD_OrdenAtencionDetalle OAD	WITH(NOLOCK) ON ( det.IdOrdenAtencion = OAD.IdOrdenAtencion 
			AND det.LineaOrdenAtencion = OAD.Linea )  AND OAD.TipoComponente = 'C' 
INNER JOIN SS_AD_OrdenAtencion  OA			WITH(NOLOCK) ON ( OA.IdOrdenAtencion = OAD.IdOrdenAtencion )
LEFT JOIN SS_PR_Procedimiento  pr			WITH(NOLOCK) ON ( pr.IdOrdenAtencion = OAD.IdOrdenAtencion and pr.LineaOrdenAtencion=OAD.Linea)
INNER JOIN PersonaMast per					WITH(NOLOCK) ON OA.IdPaciente		= per.Persona
INNER JOIN CM_CO_TablaMaestroDetalle		WITH(NOLOCK) ON ( CM_CO_TablaMaestroDetalle.idcodigo = OAD.TipoOrdenAtencion ) 
INNER JOIN CM_CO_TablaMaestroDetalleConcepto WITH(NOLOCK) ON ( CM_CO_TablaMaestroDetalleConcepto.idcodigo = CM_CO_TablaMaestroDetalle.idcodigo 
AND CM_CO_TablaMaestroDetalleConcepto.idtablamaestro = CM_CO_TablaMaestroDetalle.idtablamaestro ) 
INNER JOIN GE_Varios						WITH(NOLOCK) ON ( CM_CO_TablaMaestroDetalleConcepto.idtablamaestro = 101 AND CM_CO_TablaMaestroDetalleConcepto.Secuencial = 2 
AND CM_CO_TablaMaestroDetalleConcepto.ValorInicialN = GE_Varios.Secuencial	) 
LEFT JOIN SS_GE_Servicio					WITH(NOLOCK) ON ( SS_GE_Servicio.IdServicio = OAD.IdServicio ) 
LEFT JOIN SS_GE_GrupoAtencion				WITH(NOLOCK) ON ( SS_GE_GrupoAtencion.IdGrupoAtencion = SS_GE_Servicio.IdGrupoAtencion ) 
LEFT JOIN SS_GE_Especialidad				WITH(NOLOCK) ON ( SS_GE_Especialidad.IdEspecialidad = OAD.Especialidad )
LEFT JOIN CM_CO_Componente DA				WITH(NOLOCK) ON ( DA.CodigoComponente = OAD.Componente ) 
WHERE GE_Varios.codigotabla = 'GRUPOORDMED' AND GE_Varios.Secuencial > 0
GO

CREATE OR ALTER VIEW [dbo].[VW_SS_HCE_VisorHistoria] 
AS 

SELECT 
        SS_AD_OrdenAtencion.UnidadReplicacion as UnidadReplicacionEC,        
        TipoAtencion.Nombre as TipoAtencionDescX,
		CitaTipo = (CASE SS_CC_Cita.TipoCita WHEN 1 THEN 'Normal' WHEN 2 THEN 'Adicional' ELSE 'Normal' END),
        CitaFecha = convert(varchar(10) ,SS_CC_Cita.FechaCita,103)  , 
        CitaHora = convert(varchar(10) ,SS_CC_Cita.FechaCita,108) ,
        Origen = (CASE WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 11) THEN 'C' ELSE 'P' END),
        NombreEspecialidad = SS_GE_Especialidad.Nombre  ,  --IsNull(SS_GE_Especialidad.Nombre ,   espec.Nombre ) 
        TipoPacienteNombre = TipoPaciente.Nombre,
        SS_AD_OrdenAtencion.CodigoOA,
		IsNull(SS_CC_CITA.Comentario,'') as Cama,
		SS_AD_OrdenAtencion.FechaInicio, 
		TipoOrdenAtencionNombre = TipoOrdenAtencion.Nombre,
        SS_GE_Paciente.CodigoHC,
		Aseg.NombreCompleto  as Aseguradora,
        SS_GE_Paciente.CodigoHCAnterior,
        PacienteNombre = PersonaMast.NombreCompleto,				
            --NOMBRE DE MEDICO ASIGNADO
		IsNull(Medico.NombreCompleto,medik.NombreCompleto)   as MedicoNombre,				
		SS_AD_OrdenAtencionDetalle.IdOrdenAtencion,
            LineaOrdenAtencion = SS_AD_OrdenAtencionDetalle.Linea,
            IsNull(SS_AD_OrdenAtencion.IdContrato,0) as IdHospitalizacion,
            0 AS LineaHospitalizacion ,
            SS_CE_ConsultaExterna.IdConsultaExterna,
            SS_PR_Procedimiento.IdProcedimiento,
            case 
				when SS_AD_OrdenAtencion.TipoPaciente='19' then '19'
				when SS_AD_OrdenAtencion.TipoPaciente='4' then '4'
				when SS_AD_OrdenAtencion.modalidad='1' then '1'
				when  SS_AD_OrdenAtencion.modalidad='2' then '2'
				else
				SS_AD_OrdenAtencion.tipopaciente
			end as Modalidad,
        IndicadorSeguro = ( 				
		SELECT IsNull(CM_CO_TablaMaestroDetalleConcepto.IndicadorConcepto,1)
                FROM CM_CO_TablaMaestroDetalleConcepto WITH(NOLOCK) INNER JOIN CM_CO_TablaMaestroConcepto WITH(NOLOCK) ON CM_CO_TablaMaestroConcepto.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
                        AND CM_CO_TablaMaestroConcepto.IdConcepto = CM_CO_TablaMaestroDetalleConcepto.IdConcepto
                        AND CM_CO_TablaMaestroConcepto.Concepto = 'APLICA_SEGURO'
                WHERE TipoPaciente.IdTablaMaestro = CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro
                        AND TipoPaciente.IdCodigo = CM_CO_TablaMaestroDetalleConcepto.IdCodigo),
            SS_CC_Cita.IdCita,
            SS_AD_OrdenAtencion.FechaFinal as FechaFin,
            SS_GE_Paciente.IdPaciente,
            SS_AD_OrdenAtencion.TipoPaciente,
            SS_AD_OrdenAtencion.TipoAtencion,
            IdEspecialidad = IsNull(SS_AD_OrdenAtencionDetalle.Especialidad, SS_AD_OrdenAtencion.Especialidad),
            SS_AD_OrdenAtencion.IdEmpresaAseguradora,
            SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion,
            SS_AD_OrdenAtencionDetalle.Componente,
            ComponenteNombre = '',--CM_CO_Componente.Nombre,
            SS_AD_OrdenAtencion.Compania,
            SS_AD_OrdenAtencion.Sucursal,	
			--IDMEDICO ASIGNADO
        IdMedico =     IsNull(SS_PR_Procedimiento.Medico,SS_CC_Cita.IdMedico) ,-- Medico.Persona,	
            ------------------------
            0 as IndicadorCirugia,
            0 as IndicadorExamenPrincipal,
            ---------------------------ADD ORIGEN HCE --OBS                  
            SS_AD_OrdenAtencion.UnidadReplicacion AS UnidadReplicacionHCE,
			CASE 
			WHEN  SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (1, 11, 21 ) THEN 
					case 
						WHEN ss_cc_cita.estadodocumento = 2 then 1 --PROGRAMADO
						WHEN ss_cc_cita.estadodocumento = 3 then 0 --PENDIENTE
						WHEN ss_cc_cita.estadodocumento = 8 then 3 -- ATENDIDO		
						WHEN SS_CC_CITA.EstadoDocumento=4 then case when SS_AD_OrdenAtencionDetalle.IndicadorProcedimiento=2 then 3
						else 2
						end	
					Else
					ss_cc_cita.estadodocumento
					end						
			WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion IN (  2, 4, 5, 6, 7, 8, 9, 10, 12, 16, 17, 18, 19, 25, 26, 27, 23, 15, 33, 34, 37, 38, 39, 29, 30, 31, 32, 28 ) THEN 
				case  when IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) = -99 AND SS_CC_Cita.EstadoDocumento IS NULL THEN 0
					when IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) = -99 AND SS_CC_Cita.EstadoDocumento = 3 THEN 0
					when IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) = -99 AND SS_CC_Cita.EstadoDocumento = 2 THEN 1
					when IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) = -99 AND SS_CC_Cita.EstadoDocumento = 8 THEN 0
					when IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) = -99 AND SS_CC_Cita.EstadoDocumento = 4 THEN 0
					when IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) <> -99 AND SS_PR_Procedimiento.EstadoDocumento = 2 THEN 3
					when IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) <> -99 AND SS_PR_Procedimiento.EstadoDocumento = 4 THEN 3							
					when IsNull(SS_PR_Procedimiento.EstadoDocumento,-99) <> -99 AND SS_PR_Procedimiento.EstadoDocumento = 1 THEN 2
					Else 
						-99	
			END   
            Else
                SS_AD_OrdenAtencionDetalle.Estado -- ss_cc_cita.estadodocumento //POR NICK PASCO 02/08/2020
            end  AS EstadoEpiAtencion,  
			
			CASE WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion in (12,11,7)   THEN    
		CASE WHEN isnull(XX1.PR_Secu,0) + isnull(XX2.CE_Secu,0) >0 THEN 3					
				ELSE CASE WHEN SS_CE_ConsultaExternaOrdenMedica.IdConsultaExterna is not null THEN 1 ELSE 2 END 
				END
		ELSE 0
		END AS  EpisodioClinicoHCE,
            CASE WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion in (5,9)   THEN    
		CASE WHEN isnull(XX1.PR_Secu,0) + isnull(XX2.CE_Secu,0) >0 THEN 3					
				ELSE CASE WHEN SS_CE_ConsultaExternaOrdenMedica.IdConsultaExterna is not null THEN 1 ELSE 2 END 
				END
		ELSE 0
		END AS IDEPISODIOAtencionHCE,
            CASE WHEN SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion in (17,18,16,8,7,6)   THEN    
			CASE WHEN isnull(XX1.PR_Secu,0) + isnull(XX2.CE_Secu,0) >0 THEN 3					
					ELSE CASE WHEN SS_CE_ConsultaExternaOrdenMedica.IdConsultaExterna is not null THEN 1 ELSE 2 END 
					END
			ELSE 0
			END AS IdPacienteHCE, 
            SS_CC_Cita.EstadoDocumento	 AS SecuenciaHCE,            
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
			'' As Pais,
			(case when SS_CC_Cita.EstadoDocumento = 8 then  CONVERT(varchar(20),3,108) else  PersonaMast.Estado end )
             as EstadoPersona --reemplazar por PersonaMast.Estado
	FROM	SS_AD_OrdenAtencionDetalle				WITH(NOLOCK) 
		INNER JOIN SS_AD_OrdenAtencion				WITH(NOLOCK) ON SS_AD_OrdenAtencion.IdOrdenAtencion = SS_AD_OrdenAtencionDetalle.IdOrdenAtencion 
		INNER JOIN SS_GE_Paciente					WITH(NOLOCK) ON SS_GE_Paciente.IdPaciente = SS_AD_OrdenAtencion.IdPaciente 
		INNER JOIN PersonaMast						WITH(NOLOCK) ON SS_GE_Paciente.IdPaciente = PersonaMast.Persona 
		LEFT JOIN CM_CO_Componente					WITH(NOLOCK) ON ( CM_CO_Componente.CodigoComponente = SS_AD_OrdenAtencionDetalle.Componente ) 
		LEFT JOIN SS_CE_ConsultaExternaOrdenMedica	WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.Idordenatencion = SS_CE_ConsultaExternaOrdenMedica.IdOrdenAtencion
			  AND SS_AD_OrdenAtencionDetalle.Linea = SS_CE_ConsultaExternaOrdenMedica.LineaOrdenAtencion
		LEFT JOIN SS_CE_ConsultaExterna				WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.IdOrdenAtencion = SS_CE_ConsultaExterna.IdOrdenAtencion   AND SS_AD_OrdenAtencionDetalle.Linea = SS_CE_ConsultaExterna.LineaOrdenAtencion 
		LEFT JOIN (SELECT CE_INFORME.IdConsultaExterna,COUNT(CE_INFORME_DET.Secuencial) CE_Secu  
					FROM 	  SS_CE_Informe AS CE_INFORME  WITH(NOLOCK)		
					LEFT JOIN SS_CE_InformeDetalle AS CE_INFORME_DET WITH(NOLOCK) ON CE_INFORME.IdInforme = CE_INFORME_DET.IdInforme
			 GROUP BY 	CE_INFORME.IdConsultaExterna
				) XX2	ON SS_CE_ConsultaExterna.IdConsultaExterna = XX2.IdConsultaExterna		
		LEFT JOIN SS_GE_ComponentePrestacion		WITH(NOLOCK) ON SS_AD_OrdenAtencionDetalle.Componente = SS_GE_ComponentePrestacion.Componente 
		LEFT JOIN SS_GE_Turno						WITH(NOLOCK) ON SS_GE_Turno.IdTurno = SS_AD_OrdenAtencionDetalle.IdTurno 
		LEFT JOIN SS_GE_Servicio					WITH(NOLOCK) ON ( SS_GE_Servicio.IdServicio = SS_AD_OrdenAtencionDetalle.IdServicio ) 
		LEFT JOIN SS_GE_GrupoAtencion				WITH(NOLOCK) ON ( SS_GE_GrupoAtencion.IdGrupoAtencion = SS_GE_Servicio.IdGrupoAtencion )
		LEFT JOIN CM_CO_TablaMaestroDetalle TipoPaciente			WITH(NOLOCK)  ON TipoPaciente.IdTablaMaestro = 106  AND TipoPaciente.IdCodigo = SS_AD_OrdenAtencion.TipoPaciente
		LEFT JOIN CM_CO_TablaMaestroDetalle	AS TipoOrdenAtencion	WITH (NOLOCK) ON TipoOrdenAtencion.IdTablaMaestro = 101 AND TipoOrdenAtencion.IdCodigo = SS_AD_OrdenAtencionDetalle.TipoOrdenAtencion
		LEFT JOIN SS_GE_TipoAtencion TipoAtencion	WITH(NOLOCK) ON ( TipoAtencion.IdTipoAtencion = SS_AD_OrdenAtencion.TipoAtencion ) 
		LEFT JOIN GE_Varios as modalid				WITH(NOLOCK) ON ( modalid.CodigoTabla = 'TIPOMODALIDAD' and modalid.Secuencial = SS_AD_OrdenAtencion.Modalidad ) 
		LEFT JOIN GE_Varios as Topico				WITH(NOLOCK) ON ( Topico.CodigoTabla = 'TOPICO' and Topico.Secuencial = SS_AD_OrdenAtencion.IdTopico ) 
		LEFT JOIN SS_PR_Procedimiento				WITH(NOLOCK) ON ( SS_PR_Procedimiento.IdOrdenAtencion = SS_AD_OrdenAtencionDetalle.IdOrdenAtencion AND SS_PR_Procedimiento.LineaOrdenAtencion = SS_AD_OrdenAtencionDetalle.Linea ) 
		LEFT JOIN (SELECT PR_INFORME.IdProcedimiento,COUNT(PR_INFORME_ASOC.IdProcedimiento) PR_Secu  
				FROM SS_PR_Informe AS PR_INFORME	WITH(NOLOCK)		
				LEFT JOIN SS_PR_ProcedimientoInforme AS PR_INFORME_ASOC WITH(NOLOCK) ON 
						 PR_INFORME.IdProcedimiento = PR_INFORME_ASOC.IdProcedimiento 
			 GROUP BY 	PR_INFORME.IdProcedimiento 
				) XX1	ON SS_PR_Procedimiento.IdProcedimiento = XX1.IdProcedimiento		
		LEFT JOIN PersonaMast as medico				WITH(NOLOCK) ON medico.Persona = SS_PR_Procedimiento.Medico 
		LEFT JOIN SS_CC_Cita						WITH(NOLOCK) ON SS_CC_Cita.IdCita = SS_AD_OrdenAtencionDetalle.IdCita 
		LEFT JOIN SS_CC_Horario						WITH(NOLOCK) ON SS_CC_Horario.IdHorario = SS_CC_Cita.IdHorario 
		LEFT JOIN PersonaMast as medik				WITH(NOLOCK) ON medik.Persona = SS_CC_Horario.Medico 
		LEFT JOIN PersonaMast as Aseg				WITH(NOLOCK) ON Aseg.Persona = SS_AD_OrdenAtencion.IdEmpresaAseguradora 
		LEFT JOIN SS_GE_Consultorio					WITH(NOLOCK) ON ( SS_GE_Consultorio.IdConsultorio = SS_CC_Horario.IdConsultorio ) 
		LEFT JOIN SS_GE_Especialidad				WITH(NOLOCK) ON ( SS_GE_Especialidad.IdEspecialidad = SS_AD_OrdenAtencionDetalle.Especialidad ) 
		LEFT JOIN SS_HO_Hospitalizacion				WITH(NOLOCK) ON SS_HO_Hospitalizacion.IdOrdenAtencion = SS_AD_OrdenAtencion.IdOrdenAtencion AND ss_ad_OrdenAtencion.TipoAtencion = 3
		LEFT JOIN SS_GE_Ubicacion					WITH(NOLOCK) ON SS_GE_Ubicacion.IdUbicacion = SS_HO_Hospitalizacion.Ubicacion 
		LEFT JOIN SS_GE_Consultorio CAMA			WITH(NOLOCK) ON CAMA.IdConsultorio = SS_HO_Hospitalizacion.Cama 
	WHERE 
	 SS_AD_OrdenAtencionDetalle.IndicadorDisponible = 2
	 AND SS_CC_Cita.EstadoDocumento IN ( 3, 8, 4 )  

GO

CREATE OR ALTER VIEW  [dbo].[VW_SS_HCE_VisorReceta] 
AS 
	SELECT  convert(varchar, det.Secuencial  ) + ' RECETA' TAB,per.documento,per.tipodocumento,det.IdConsultaExterna, det.Secuencial,
	OAD.IdOrdenAtencion, det.LineaOrdenAtencion,det.TipoComponente, det.Componente, det.UnidadMedida,  det.Cantidad, 
	det.Forma, det.Via,isnull( det.Dosis,0.0)Dosis,isnull( det.DiasTratamiento,0.0)DiasTratamiento,isnull(  det.Frecuencia,0.0)Frecuencia, 
	det.Comentario, det.Estado, det.UsuarioCreacion, det.FechaCreacion, det.UsuarioModificacion, 
	det.FechaModificacion,OA.IdPaciente, TD.Nombre AS Componente_Nombre, det.SubFamilia, DCI.DescripcionLocal AS 
	DCI, det.Familia, FAM.DescripcionLocal AS FAM, det.linea, LIN.DescripcionLocal AS LIN,
	det.IndicadorEPS,OAD.IndicadorCobrado,OA.Sucursal, Via.Descripcion DesVia , UniMed.DescripcionCorta DesUnidad,--ISNULL(DII.Descripcion,'') IndicacionesEsp
	ISNULL(DBO.FUN_DetalleIndicaciones(det.IdConsultaExterna,det.Secuencial),'') IndicacionesEsp
		FROM SS_CE_ConsultaExternaReceta det		WITH(NOLOCK)
		INNER JOIN SS_AD_OrdenAtencion OA			WITH(NOLOCK)	ON det.IdOrdenAtencion  = OA.IdOrdenAtencion
		INNER JOIN PersonaMast per					WITH(NOLOCK)	ON	OA.IdPaciente		= per.Persona
		LEFT JOIN WH_ItemMast						WITH(NOLOCK) ON ( WH_ItemMast.Item = det.Componente ) 
		LEFT JOIN WH_ClaseSubFamilia DCI			WITH(NOLOCK) ON ( DCI.linea = det.linea AND DCI.Familia = det.Familia AND DCI.SubFamilia = det.SubFamilia ) 
		LEFT JOIN WH_ClaseFamilia FAM				WITH(NOLOCK) ON ( FAM.linea = det.linea 	AND FAM.Familia = det.Familia ) 
		LEFT JOIN WH_ClaseLinea LIN					WITH(NOLOCK) ON ( LIN.linea = det.linea ) 
		LEFT JOIN SS_AD_OrdenAtencionDetalle OAD	WITH(NOLOCK) ON ( OAD.IdOrdenAtencion = det.IdOrdenAtencion AND OAD.Linea = det.LineaOrdenAtencion ) 
		LEFT JOIN  UnidadesMast UniMed				WITH(NOLOCK)	ON	(UniMed.IdUnidadMedida = det.UnidadMedida)
		LEFT JOIN  GE_VARIOS Via					WITH(NOLOCK)	ON  (Via.CodigoTabla = 'TIPOVIA'    AND Via.Secuencial = det.Via)
		LEFT JOIN CM_CA_TransaccionDetalle TD		WITH(NOLOCK) ON TD.IdOAOrigen = OAD.IdOrdenAtencion AND TD.IdOALineaOrigen = OAD.Linea 
		AND TD.LoteComponente IS NOT NULL	
		WHERE OAD.TipoComponente = 'A' AND OAD.Estado = 2
		AND IsNull(det.TipoReceta, 2 ) = 2  or det.TipoReceta = 1 

GO

CREATE OR ALTER PROC [dbo].[A_SP_SS_HCE_VisorHistoria] --'2019-05-08' ,'2019-05-08','10002094'
	@FechaInicio	datetime=null,
	@FechaFin		datetime=null,
	@Documento		varchar(20)=null,
	@codsucursal	varchar(20)=null
as
	SELECT * FROM [dbo].[VW_SS_HCE_VisorHistoria]
	where Documento = @Documento 
	and Sucursal=@codsucursal
	AND (@FechaInicio IS NULL OR FechaInicio >=  @FechaInicio)
	AND (@FechaFin IS NULL OR FechaFin < DATEADD(DAY,1,@FechaFin))
GO
