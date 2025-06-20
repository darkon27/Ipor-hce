
/*ALTER*/

ALTER VIEW [dbo].[rptViewDiagnostico_FE]
AS
SELECT			D_FE.UnidadReplicacion,
				D_FE.IdPaciente,D_FE.EpisodioClinico,
				D_FE.IdEpisodioAtencion,
				D_FE.Secuencia,
				D_FE.IdDiagnostico,
				D_FE.DeterminacionDiagnostica,
				D_FE.IdDiagnosticoPrincipal,
				D_FE.GradoAfeccion,
				D_FE.Observacion,
				D_FE.IndicadorAntecedente,
				D_FE.TipoAntecedente,
				D_FE.IndicadorPreExistencia,
				D_FE.IndicadorCronico,
				D_FE.IndicadorNuevo,
				D_FE.Estado,
				D_FE.Accion as Expr01,
				D_FE.Version as Expr02,
				D_FE.UsuarioCreacion as Expr03,
				D_FE.UsuarioModificacion as Expr04,
				dbo.SS_GE_Diagnostico.CodigoDiagnostico,
				dbo.SS_GE_Diagnostico.Descripcion as DiagnosticoDesc,				
					TAB_DETERMDIAGDET.Nombre as DeterminacionDiagnosticaDesc,
					TAB_DIAGPRINCDET.Nombre   as DiagnosticoPrincipalDesc,
					TAB_GRADOAFECDET.Nombre  as GradoAfeccionDesc,
					TAB_ANTECDET.Nombre  as TipoAntecedenteDesc,
					TAB_PREXDET.Nombre  as IndicadorPreExistenciaDesc,
					TAB_CRONDET.Nombre  as IndicadorCronicoDesc,
					TAB_NUEVODET.Nombre  as IndicadorNuevoDesc,
                      /***************************************/
                      /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.Nombres, dbo.PERSONAMAST.NombreCompleto, 
                      dbo.PERSONAMAST.Busqueda, dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.FechaNacimiento, 
                      dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.edad as PersonaEdad
                      --EPI ATENCIÓN
                      ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoAtencion
                      ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                      ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio
                      ,SS_HC_EpisodioAtencion.IdPersonalSalud
                      ,SS_HC_EpisodioAtencion.FechaRegistro
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      ,SS_HC_EpisodioAtencion.IdEspecialidad
                      ,SS_HC_EpisodioAtencion.IdTipoOrden
                      ,SS_HC_EpisodioAtencion.Estado as estadoEpiAtencion
                      ,SS_HC_EpisodioAtencion.Accion as Expr101  --AUX
                      ,SS_HC_EpisodioAtencion.ObservacionProxima as Expr102 --AUX
                      ,SS_HC_EpisodioAtencion.Accion as Expr103 --AUX                      
                      --
                      ,SS_GE_TipoAtencion.Descripcion as TipoAtencionDesc
                      ,SS_TipoTrabajador.DescripcionLocal as TipoTrabajadorDesc
                      ,CM_CO_Establecimiento.Codigo as EstablecimientoCodigo
                      ,CM_CO_Establecimiento.Nombre as EstablecimientoDesc
                      ,SS_HC_UnidadServicio.Codigo as UnidadServicioCodigo
                      ,SS_HC_UnidadServicio.Descripcion as UnidadServicioDesc
                      ,PERSONA_PERSSALUD.NombreCompleto as PersMedicoNombreCompleto
                      ,PERSONA_PERSSALUD.Documento as PersMedicoNombreDocumento
                      ,SS_GE_Especialidad.Codigo as EspecialidadCodigo
                      ,SS_GE_Especialidad.Nombre as EspecialidadDesc
                      ----ADD AUX
                      ,PERSONA_PERSSALUD.NombreCompleto+
						(case when  EMPLEADO_PERSSALUD.CMP IS null 
							then ''
							else '/CMP: '+EMPLEADO_PERSSALUD.CMP  end)
						+                      
						'/'+SS_GE_Especialidad.Nombre
						+
						(case when  ESPECIALIDAD_MED.NumeroRegistroEspecialidad IS null 
							then ''
							else '- RNE: '+ESPECIALIDAD_MED.NumeroRegistroEspecialidad end)						                 
                      as Expr104  --AUX                      

                      
                      
FROM      SS_HC_Diagnostico_FE as   D_FE                       
                      INNER JOIN
                      dbo.PERSONAMAST ON D_FE.IdPaciente = dbo.PERSONAMAST.Persona
						INNER JOIN
                      dbo.SS_HC_EpisodioAtencion 
                      ON D_FE.UnidadReplicacion = dbo.SS_HC_EpisodioAtencion.UnidadReplicacion
                      AND D_FE.IdEpisodioAtencion = dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion 
                      AND D_FE.IdPaciente = dbo.SS_HC_EpisodioAtencion.IdPaciente 
                      AND D_FE.EpisodioClinico = dbo.SS_HC_EpisodioAtencion.EpisodioClinico                                             
					LEFT JOIN
                      dbo.SS_GE_TipoAtencion
                      ON dbo.SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
					LEFT JOIN
                      dbo.SS_TipoTrabajador
                      ON dbo.SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
					LEFT JOIN
                      dbo.CM_CO_Establecimiento
                      ON dbo.CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
						LEFT JOIN    SS_HC_UnidadServicio    
					     ON dbo.CM_CO_Establecimiento.IdEstablecimiento =SS_HC_UnidadServicio.IdEstablecimientoSalud and   dbo.SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                      



                    LEFT JOIN
                      dbo.PERSONAMAST  as PERSONA_PERSSALUD
                      ON PERSONA_PERSSALUD.Persona = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
                    LEFT JOIN
                      dbo.SS_GE_Especialidad  
                      ON SS_GE_Especialidad.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad     
                    LEFT JOIN
                      dbo.SS_GE_Diagnostico  
                      ON SS_GE_Diagnostico.IdDiagnostico = D_FE.IdDiagnostico     		
					 left join 
					 CM_CO_TablaMaestro  as TAB_DETERMDIAG
					 on 
					 (
						TAB_DETERMDIAG.CodigoTabla = 'TABDIAGNOSTICO'						 
					 )
					 left join  CM_CO_TablaMaestroDetalle TAB_DETERMDIAGDET
					 on(
						TAB_DETERMDIAGDET.IdTablaMaestro = TAB_DETERMDIAG.IdTablaMaestro
						and TAB_DETERMDIAGDET.IdCodigo = D_FE.DeterminacionDiagnostica
					 )						
					 left join 
					 CM_CO_TablaMaestro  as TAB_DIAGPRINC
					 on 
					 (
						TAB_DIAGPRINC.CodigoTabla = 'TABCOLABORACION'						 
					 )
					 left join  CM_CO_TablaMaestroDetalle TAB_DIAGPRINCDET
					 on(
						TAB_DIAGPRINCDET.IdTablaMaestro = TAB_DIAGPRINC.IdTablaMaestro
						and TAB_DIAGPRINCDET.IdCodigo = D_FE.IdDiagnosticoPrincipal
					 )
					 left join 
					 CM_CO_TablaMaestro  as TAB_GRADOAFEC
					 on 
					 (
						TAB_GRADOAFEC.CodigoTabla = 'DIAGAFECCION'						 
					 )
					 left join  CM_CO_TablaMaestroDetalle TAB_GRADOAFECDET
					 on(
						TAB_GRADOAFECDET.IdTablaMaestro = TAB_GRADOAFEC.IdTablaMaestro
						and TAB_GRADOAFECDET.IdCodigo = D_FE.GradoAfeccion
					 )		
					 left join 
					 CM_CO_TablaMaestro  as TAB_ANTEC
					 on 
					 (
						TAB_ANTEC.CodigoTabla = 'DIAGANTECED'						 
					 )
					 left join  CM_CO_TablaMaestroDetalle TAB_ANTECDET
					 on(
						TAB_ANTECDET.IdTablaMaestro = TAB_ANTEC.IdTablaMaestro
						and TAB_ANTECDET.IdCodigo = D_FE.TipoAntecedente
					 )	
					 left join 
					 CM_CO_TablaMaestro  as TAB_PREX
					 on 
					 (
						TAB_PREX.CodigoTabla = 'TABCOLABORACION'						 
					 )
					 left join  CM_CO_TablaMaestroDetalle TAB_PREXDET
					 on(
						TAB_PREXDET.IdTablaMaestro = TAB_PREX.IdTablaMaestro
						and TAB_PREXDET.IdCodigo = D_FE.IndicadorPreExistencia
					 )						 
					 left join 
					 CM_CO_TablaMaestro  as TAB_CRON
					 on 
					 (
						TAB_CRON.CodigoTabla = 'TABCOLABORACION'						 
					 )
					 left join  CM_CO_TablaMaestroDetalle TAB_CRONDET
					 on(
						TAB_CRONDET.IdTablaMaestro = TAB_CRON.IdTablaMaestro
						and TAB_CRONDET.IdCodigo = D_FE.IndicadorCronico
					 )						 
					 left join 
					 CM_CO_TablaMaestro  as TAB_NUEVO
					 on 
					 (
						TAB_NUEVO.CodigoTabla = 'TABCOLABORACION'						 
					 )
					 left join  CM_CO_TablaMaestroDetalle TAB_NUEVODET
					 on(
						TAB_NUEVODET.IdTablaMaestro = TAB_NUEVO.IdTablaMaestro
						and TAB_NUEVODET.IdCodigo = D_FE.IndicadorNuevo
					 )						 
                      --ADD CMP  y RNE
                    LEFT JOIN
                      dbo.EMPLEADOMAST  as EMPLEADO_PERSSALUD
                      ON EMPLEADO_PERSSALUD.Empleado = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
                    LEFT JOIN
                      dbo.SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED
                      ON (ESPECIALIDAD_MED.IdMedico = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
						And ESPECIALIDAD_MED.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad
						)










GO


/*ALTER*/


ALTER VIEW [dbo].[rptViewDieta_FE]
AS

SELECT	   SS_HC_Medicamento_FE.*,
				case 
				when SS_HC_Medicamento_FE.TipoMedicamento = 2 
				then 					
				( case when (MED.DescripcionLocal IS NOT null OR MED.DescripcionLocal <> '') 
								then MED.DescripcionLocal else DCI.DescripcionLocal end  
				) 
				ELSE ''
				END
			    AS DietaMedicamento ,
				case
				when SS_HC_Medicamento_FE.TipoMedicamento = 3
				then 					
				MED.DescripcionLocal
				ELSE ''
				END
			    AS MicroNutriente ,
				
				case
				when SS_HC_Medicamento_FE.TipoMedicamento = 3
				then 					
				DCI.DescripcionLocal 
				ELSE ''
				END
			    AS DCI ,
				
				case
				when SS_HC_Medicamento_FE.TipoMedicamento = 3
				then 					
				SS_HC_Medicamento_FE.Dosis 
				ELSE ''
				END
			    AS DosisComplementoDieta ,
				

				DETUNI.Nombre  UndTiempoFre, DETTIE.Nombre	UndTiempoPeri, DETTOR.Nombre TipRecetaDes,		
				Via.Descripcion as ViaDesc,
				UniMed.Descripcion as UnidMedDesc,
				'GRUPO_'+convert(varchar,SS_HC_Medicamento_FE.Secuencia) as GrupoMed,				
				SS_HC_Indicaciones_FE.Descripcion as IndicacionesDesc, 
				SS_HC_Indicaciones_FE.SecuenciaMedicamento as SecuenciaMedIndicacion, 
				SS_HC_Indicaciones_FE.Secuencia as SecuenciaIndicacion, 
				TAB_INDIRECETA.Descripcion as IndicadorRecetaDesc,
				TAB_TIPOREGMED.DescripcionLocal as TipoRegistroMedDesc,
                      /***************************************/
                      /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      PERSONAMAST.ApellidoPaterno, PERSONAMAST.ApellidoMaterno, PERSONAMAST.Nombres, PERSONAMAST.NombreCompleto, 
                      PERSONAMAST.Busqueda, PERSONAMAST.TipoDocumento, PERSONAMAST.Documento, PERSONAMAST.FechaNacimiento, 
                      PERSONAMAST.Sexo, PERSONAMAST.EstadoCivil, PERSONAMAST.edad as PersonaEdad
                      --EPI ATENCIÓN
                      ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoAtencion
					  ,SS_GE_TipoAtencion.Nombre
                      ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                      ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio
                      ,SS_HC_EpisodioAtencion.IdPersonalSalud
                      ,SS_HC_EpisodioAtencion.FechaRegistro
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      ,SS_HC_EpisodioAtencion.IdEspecialidad
                      ,SS_HC_EpisodioAtencion.IdTipoOrden
                      ,SS_HC_EpisodioAtencion.Estado as estadoEpiAtencion
                      ,SS_HC_EpisodioAtencion.Accion as Expr101  --AUX
                      ,SS_HC_EpisodioAtencion.ObservacionProxima as Expr102 --AUX
                      ,SS_HC_EpisodioAtencion.Accion as Expr103 --AUX                      
                      --
                      ,SS_GE_TipoAtencion.Descripcion as TipoAtencionDesc
                      ,SS_TipoTrabajador.DescripcionLocal as TipoTrabajadorDesc
                      ,CM_CO_Establecimiento.Codigo as EstablecimientoCodigo
                      ,CM_CO_Establecimiento.Nombre as EstablecimientoDesc
                      ,SS_HC_UnidadServicio.Codigo as UnidadServicioCodigo
                      ,SS_HC_UnidadServicio.Descripcion as UnidadServicioDesc
                      ,PERSONA_PERSSALUD.NombreCompleto as PersMedicoNombreCompleto
                      ,PERSONA_PERSSALUD.Documento as PersMedicoNombreDocumento
                      ,SS_GE_Especialidad.Codigo as EspecialidadCodigo
                      ,SS_GE_Especialidad.Nombre as EspecialidadDesc
                      ----ADD AUX
                      ,PERSONA_PERSSALUD.NombreCompleto+
						(case when  EMPLEADO_PERSSALUD.CMP IS null 
							then ''
							else '/CMP: '+EMPLEADO_PERSSALUD.CMP  end)
						+                      
						'/'+SS_GE_Especialidad.Nombre
						+
						(case when  ESPECIALIDAD_MED.NumeroRegistroEspecialidad IS null 
							then ''
							else '- RNE: '+ESPECIALIDAD_MED.NumeroRegistroEspecialidad end)						                 
                      as Expr104 , --AUX 
					   
					 
					  --Datos Medicamento
					  EMPLEADO_PERSSALUD.CMP AS CMP,
					  ESPECIALIDAD_MED.NumeroRegistroEspecialidad AS RNE,

					  --Datos comunes
					  CASE  SS_HC_Medicamento_FE.TIPOMEDICAMENTO WHEN 2 
					  THEN Via.Descripcion 
					  ELSE ''
					  END
					  as ViaDescDieta,
						CASE  SS_HC_Medicamento_FE.TIPOMEDICAMENTO WHEN 3
					  THEN Via.Descripcion 
					  ELSE ''
					  END
					  as ViaDescComplementoDieta,
					   CASE  SS_HC_Medicamento_FE.TIPOMEDICAMENTO WHEN 2 
					  THEN SS_HC_Medicamento_FE.Comentario 
					  ELSE ''
					  END
					  as ComentarioDieta,
						CASE  SS_HC_Medicamento_FE.TIPOMEDICAMENTO WHEN 3
					  THEN SS_HC_Medicamento_FE.Comentario 
					  ELSE ''
					  END
					  as ComentarioComplementoDieta,
					   
					   --Datos Compania
						  Compania.CompaniaCodigo,
						  Compania.DescripcionCorta,
						  Compania.DescripcionLarga,
						  Compania.DireccionComun,
						  Compania.DocumentoFiscal,
						  Compania.PropietarioPorDefecto,
						  Compania.DescripcionPSF,
						  Compania.CIIU,
						  Compania.DireccionAdicional,
						  Sucursal.sucursal,
						  Sucursal.sucursalGrupo,
						  Sucursal.DescripcionLocal

FROM     SS_HC_Medicamento_FE    SS_HC_Medicamento_FE                       
            
	INNER JOIN	PERSONAMAST ON SS_HC_Medicamento_FE.IdPaciente = PERSONAMAST.Persona
	INNER JOIN	SS_HC_EpisodioAtencion 
                      ON SS_HC_Medicamento_FE.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion
                      AND SS_HC_Medicamento_FE.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion 
                      AND SS_HC_Medicamento_FE.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente 
                      AND SS_HC_Medicamento_FE.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico                                             
	LEFT JOIN	SS_GE_TipoAtencion						ON SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
	LEFT JOIN	SS_TipoTrabajador						ON SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
	LEFT JOIN	CM_CO_Establecimiento                     ON CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
	LEFT JOIN	SS_HC_UnidadServicio                      ON SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                      
    LEFT JOIN	PERSONAMAST  as PERSONA_PERSSALUD         ON PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
    LEFT JOIN	SS_GE_Especialidad                        ON SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad     
                      --- 									
	LEFT JOIN	WH_ClaseSubFamilia DCI on 
							(DCI.Linea = SS_HC_Medicamento_FE.Linea
							AND DCI.Familia = SS_HC_Medicamento_FE.Familia
							AND DCI.SubFamilia = SS_HC_Medicamento_FE.SubFamilia
							AND (SS_HC_Medicamento_FE.CodigoComponente  = '' OR SS_HC_Medicamento_FE.CodigoComponente is null)
							)
	LEFT JOIN	WH_ItemMast MED on 
							(MED.Linea = SS_HC_Medicamento_FE.Linea
							AND MED.Familia = SS_HC_Medicamento_FE.Familia
							AND MED.SubFamilia = SS_HC_Medicamento_FE.SubFamilia
							AND ( rtrim(MED.Item)  =  SS_HC_Medicamento_FE.CodigoComponente )
							)	
	LEFT JOIN	GE_UnidadMedida UniMed on (UniMed.IdUnidadMedida = SS_HC_Medicamento_FE.IdUnidadMedida)
	LEFT JOIN	GE_VARIOS Via on 
							(Via.CodigoTabla = 'TIPOVIA'
							AND Via.Secuencial = SS_HC_Medicamento_FE.IdVia			
							)
	LEFT JOIN	CM_CO_TablaMaestroDetalle DETUNI ON 			(DETUNI.IdTablaMaestro = 102	AND DETUNI.IdCodigo = SS_HC_Medicamento_FE.UnidadTiempo)	
	LEFT JOIN	CM_CO_TablaMaestroDetalle DETTIE ON 			(DETTIE.IdTablaMaestro = 102	AND DETTIE.IdCodigo = SS_HC_Medicamento_FE.TipoComida)	
	LEFT JOIN	CM_CO_TablaMaestroDetalle DETTOR ON 			(DETTOR.IdTablaMaestro = 46		AND DETTOR.IdCodigo = SS_HC_Medicamento_FE.TipoReceta)	
	LEFT JOIN	SS_HC_Indicaciones_FE
                      ON (
						SS_HC_Medicamento_FE.UnidadReplicacion = SS_HC_Indicaciones_FE.UnidadReplicacion
						AND SS_HC_Medicamento_FE.IdEpisodioAtencion = SS_HC_Indicaciones_FE.IdEpisodioAtencion 
						AND SS_HC_Medicamento_FE.IdPaciente = SS_HC_Indicaciones_FE.IdPaciente 
						AND SS_HC_Medicamento_FE.EpisodioClinico = SS_HC_Indicaciones_FE.EpisodioClinico 
						AND SS_HC_Medicamento_FE.Secuencia = SS_HC_Indicaciones_FE.SecuenciaMedicamento 							
						)
						 left join 
						 MA_MiscelaneosDetalle  as TAB_TIPOREGMED
						 on 
						 (
							rtrim(TAB_TIPOREGMED.CodigoTabla) = 'TIPOREGMED'	
							and rtrim(TAB_TIPOREGMED.ValorCodigo1) = rtrim(SS_HC_Indicaciones_FE.TipoRegistro)
						 )
						 left join 
						 GE_VARIOS  as TAB_INDIRECETA
						 on 
						 (
							TAB_INDIRECETA.CodigoTabla = 'INDIRECETA'	
							and TAB_INDIRECETA.Secuencial = SS_HC_Indicaciones_FE.IdTipoIndicacion
						 )					
                      --ADD CMP  y RNE
                    LEFT JOIN
                      EMPLEADOMAST  as EMPLEADO_PERSSALUD
                      ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud
					 left join CompaniaMast as Compania
					on EMPLEADO_PERSSALUD.companiasocio  = Compania.PropietarioPorDefecto+Compania.companiacodigo 
					left join AC_Sucursal  AS Sucursal
					 on  Compania.CompaniaCodigo+ Compania.PropietarioPorDefecto = Sucursal.Compania and Sucursal.Sucursal = SS_HC_Medicamento_FE.UnidadReplicacion			
					 LEFT JOIN
                      SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED
                      ON (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud
						And ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad
						)
						where SS_HC_Medicamento_FE.TipoMedicamento in(2,3) 
   go                     
--********************************************************************
--Fecha : 26-01-2017  (Estado: PUBLICADO)
CREATE view rptViewAntecedentesPersonalesFisiologicos_FE
AS
SELECT 
UnidadReplicacion,
IdEpisodioAtencion,
IdPaciente,
EpisodioClinico,
IdSecuencia,
ISNULL (GrupoSanguineo,'') AS GrupoSanguineo,
ISNULL (FactorRH,'') AS FactorRH,
ISNULL (AlimentacionA_flag,'') AS AlimentacionA_flag,
ISNULL (Alcohol,'') AS Alcohol,
ISNULL (Alcohol_EspecificarCantidad,'') AS Alcohol_EspecificarCantidad,
ISNULL (Tabaco_flag,'') AS Tabaco_flag,
ISNULL (Tabaco_NroCigarrillos,'') AS Tabaco_NroCigarrillos,
ISNULL (TiempoConsumo,'') AS TiempoConsumo,
ISNULL (Drogas_flag,'') AS Drogas_flag,
ISNULL (Drogas_Especificar,'') AS Drogas_Especificar,
ISNULL (Cafe_flag,'') AS Cafe_flag,
ISNULL (Otros,'') AS Otros,
ISNULL (ActividadFisica_flag,'') AS ActividadFisica_flag,
ISNULL (ActividadFisica_subflag,'') AS ActividadFisica_subflag,
ISNULL (ConsumoVerduras_flag,'') AS ConsumoVerduras_flag,
ISNULL (ConsumoVerduras_subflag,'') AS ConsumoVerduras_subflag,
ISNULL (ConsumoFrutas_flag,'') AS ConsumoFrutas_flag,
ISNULL (ConsumoFrutas_subflag,'') AS ConsumoFrutas_subflag,
ISNULL (InmunizacionesAdultoObservaciones,'') AS InmunizacionesAdultoObservaciones,
ISNULL (Accion,'') AS Accion,
Version,
ISNULL(Estado,'')AS Estado,
UsuarioCreacion,
FechaCreacion,
UsuarioModificacion,
FechaModificacion
FROM dbo.SS
GO

--*******************************************************
--Fecha: 27/01/2014     Estado (PUBLICADO)

CREATE VIEW [dbo].[rptViewAntecedentesPersonalesPatologicosGenerales_FE]
AS
SELECT P_CAB.*, P_DET.Secuencia, P_DET.OtrasEnfermedades
FROM dbo.SS_HC_Anam_AP_PatologicosGenerales_FE P_CAB
	 left join	dbo.SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE P_DET
	 on P_CAB.UnidadReplicacion = P_DET.UnidadReplicacion and
	 P_CAB.IdEpisodioAtencion = P_DET.IdEpisodioAtencion and
	 P_CAB.IdPaciente = P_DET.IdPaciente and
	 P_CAB.EpisodioClinico = P_DET.EpisodioClinico

--*******************************************************







/* ALTER VIEW */

--fecha: 27/01/2017  Nombre:Alan Gastelu  Estado:PUBLICADO



ALTER VIEW [dbo].[rptViewAnamnesis_AFAM_FE]
as
SELECT        
	SS_HC_Anamnesis_AFAM_CAB_FE.AntecedenteFami_flag,
	SS_HC_Anamnesis_AFAM_FE.UnidadReplicacion, 
	SS_HC_Anamnesis_AFAM_FE.IdEpisodioAtencion, 
	SS_HC_Anamnesis_AFAM_FE.IdPaciente, 
	SS_HC_Anamnesis_AFAM_FE.EpisodioClinico, 
	SS_HC_Anamnesis_AFAM_FE.IdTipoParentesco, 
	SS_HC_Anamnesis_AFAM_FE.Edad, 
	SS_HC_Anamnesis_AFAM_FE.IdVivo, 
	SS_HC_Anamnesis_AFAM_FE.Estado, 
	SS_HC_Anamnesis_AFAM_FE.UsuarioCreacion, 
	SS_HC_Anamnesis_AFAM_FE.FechaCreacion, 
	SS_HC_Anamnesis_AFAM_FE.UsuarioModificacion, 
	SS_HC_Anamnesis_AFAM_FE.FechaModificacion, 
	SS_HC_Anamnesis_AFAM_FE.Accion, 
	SS_HC_Anamnesis_AFAM_FE.Version, 
	SS_HC_Anamnesis_AFAM_FE.SecuenciaFamilia AS Expr1, 
	'GRUPO_' + CONVERT(varchar, SS_HC_Anamnesis_AFAM_FE.SecuenciaFamilia) AS Expr103, 

	isnull(SS_HC_Anamnesis_AFAM_Enfermedad_FE.Secuencia,0) as Secuencia, 
	isnull(SS_HC_Anamnesis_AFAM_Enfermedad_FE.IdDiagnostico,0) IdDiagnostico, 
	SS_HC_Anamnesis_AFAM_Enfermedad_FE.Observaciones, 

	SS_GE_Diagnostico.CodigoDiagnostico, 
	SS_GE_Diagnostico.CodigoPadre, 
	SS_GE_Diagnostico.Nombre, 
	SS_GE_Diagnostico.Descripcion, 
	SS_GE_Diagnostico.Estado AS Expr2, 
	SS_GE_Diagnostico.FechaCreacion AS Expr4, 
	SS_GE_Diagnostico.UsuarioModificacion AS Expr5, 
	SS_GE_Diagnostico.FechaModificacion AS Expr6, 
	SS_GE_Diagnostico.IdDiagnosticoPadre, 
	SS_GE_Diagnostico.Orden, 
	SS_GE_Diagnostico.CadenaRecursividad, 
	SS_GE_Diagnostico.Nivel, 
	SS_GE_Diagnostico.DiagnosticoSiteds, 
	SS_GE_Diagnostico.IndicadorPermitido, 
	SS_GE_Diagnostico.tipoFolder, 
	SS_GE_Diagnostico.NombreTabla, 

	PERSONAMAST.ApellidoPaterno, 
	PERSONAMAST.ApellidoMaterno, 
	PERSONAMAST.Nombres, 
	PERSONAMAST.NombreCompleto, 
	PERSONAMAST.Busqueda, 
	PERSONAMAST.TipoDocumento, 
	PERSONAMAST.Documento, 
	PERSONAMAST.FechaNacimiento, 
	PERSONAMAST.Sexo, 
	PERSONAMAST.EstadoCivil, 
	PERSONAMAST.edad AS PersonaEdad, 

		
	SS_HC_EpisodioAtencion.IdOrdenAtencion, 
	SS_HC_EpisodioAtencion.CodigoOA, 
	SS_HC_EpisodioAtencion.LineaOrdenAtencion, 
	SS_HC_EpisodioAtencion.TipoOrdenAtencion, 
	SS_HC_EpisodioAtencion.TipoAtencion, 
	SS_HC_EpisodioAtencion.TipoTrabajador, 
	SS_HC_EpisodioAtencion.IdEstablecimientoSalud, 
	SS_HC_EpisodioAtencion.IdUnidadServicio, 
	SS_HC_EpisodioAtencion.IdPersonalSalud, 
	SS_HC_EpisodioAtencion.FechaRegistro, 
	SS_HC_EpisodioAtencion.FechaAtencion, 
	SS_HC_EpisodioAtencion.IdEspecialidad, 
	SS_HC_EpisodioAtencion.IdTipoOrden, 
	SS_HC_EpisodioAtencion.Estado AS estadoEpiAtencion,
	SS_HC_EpisodioAtencion.ObservacionProxima AS Expr102, 
	
	SS_GE_TipoAtencion.Descripcion AS TipoAtencionDesc, 

	SS_TipoTrabajador.DescripcionLocal AS TipoTrabajadorDesc, 

	CM_CO_Establecimiento.Codigo AS EstablecimientoCodigo, 
	CM_CO_Establecimiento.Nombre AS EstablecimientoDesc,
	 
	SS_HC_UnidadServicio.Codigo AS UnidadServicioCodigo, 
	SS_HC_UnidadServicio.Descripcion AS UnidadServicioDesc, 

	PERSONA_PERSSALUD.NombreCompleto AS PersMedicoNombreCompleto, 
	PERSONA_PERSSALUD.Documento AS PersMedicoNombreDocumento,  
	PERSONA_PERSSALUD.NombreCompleto + (CASE WHEN EMPLEADO_PERSSALUD.CMP IS NULL 
		THEN '' ELSE '/CMP: ' + EMPLEADO_PERSSALUD.CMP END) 
		+ '/' + SS_GE_Especialidad.Nombre + (CASE WHEN ESPECIALIDAD_MED.NumeroRegistroEspecialidad IS NULL 
		THEN '' ELSE '- RNE: ' + ESPECIALIDAD_MED.NumeroRegistroEspecialidad END) AS Expr104,

	SS_GE_Especialidad.Codigo AS EspecialidadCodigo, 
	SS_GE_Especialidad.Nombre AS EspecialidadDesc,

	TIPOPAREN.Descripcion AS Expr101, 

	TAB_ESTAVIVODET.Nombre AS Expr3



	FROM		SS_HC_Anamnesis_AFAM_CAB_FE 
				
			    
				INNER JOIN	SS_HC_Anamnesis_AFAM_FE 
					ON SS_HC_Anamnesis_AFAM_CAB_FE.UnidadReplicacion = SS_HC_Anamnesis_AFAM_FE.UnidadReplicacion AND 
					SS_HC_Anamnesis_AFAM_CAB_FE.IdPaciente = SS_HC_Anamnesis_AFAM_FE.IdPaciente AND 
					SS_HC_Anamnesis_AFAM_CAB_FE.EpisodioClinico = SS_HC_Anamnesis_AFAM_FE.EpisodioClinico AND 
					SS_HC_Anamnesis_AFAM_CAB_FE.IdEpisodioAtencion = SS_HC_Anamnesis_AFAM_FE.IdEpisodioAtencion  
				

				LEFT JOIN	SS_HC_Anamnesis_AFAM_Enfermedad_FE 
					ON SS_HC_Anamnesis_AFAM_FE.UnidadReplicacion = SS_HC_Anamnesis_AFAM_Enfermedad_FE.UnidadReplicacion AND 
					SS_HC_Anamnesis_AFAM_FE.IdPaciente = SS_HC_Anamnesis_AFAM_Enfermedad_FE.IdPaciente AND 
					SS_HC_Anamnesis_AFAM_FE.EpisodioClinico = SS_HC_Anamnesis_AFAM_Enfermedad_FE.EpisodioClinico AND 
					SS_HC_Anamnesis_AFAM_FE.IdEpisodioAtencion = SS_HC_Anamnesis_AFAM_Enfermedad_FE.IdEpisodioAtencion AND 
					SS_HC_Anamnesis_AFAM_FE.SecuenciaFamilia = SS_HC_Anamnesis_AFAM_Enfermedad_FE.SecuenciaFamilia 
					
				LEFT JOIN	SS_GE_Diagnostico 
					ON SS_HC_Anamnesis_AFAM_Enfermedad_FE.IdDiagnostico = SS_GE_Diagnostico.IdDiagnostico
					 
				INNER JOIN PERSONAMAST 
					ON SS_HC_Anamnesis_AFAM_FE.IdPaciente = PERSONAMAST.Persona 
				INNER JOIN SS_HC_EpisodioAtencion 
					ON SS_HC_Anamnesis_AFAM_FE.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion AND 
					SS_HC_Anamnesis_AFAM_FE.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND 
					SS_HC_Anamnesis_AFAM_FE.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND 
					SS_HC_Anamnesis_AFAM_FE.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
				LEFT OUTER JOIN	SS_GE_TipoAtencion 
					ON SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion 
				LEFT OUTER JOIN SS_TipoTrabajador 
					ON SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador 
				LEFT OUTER JOIN	CM_CO_Establecimiento 
					ON CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud 
				LEFT OUTER JOIN SS_HC_UnidadServicio 
					ON SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio 
				LEFT OUTER JOIN PERSONAMAST AS PERSONA_PERSSALUD 
					ON PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud 
				LEFT OUTER JOIN SS_GE_Especialidad 
					ON SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad 
				LEFT OUTER JOIN GE_Varios AS TIPOPAREN 
					ON TIPOPAREN.CodigoTabla = 'TIPOPARENTESCO' AND SS_HC_Anamnesis_AFAM_FE.IdTipoParentesco = TIPOPAREN.Secuencial 
				LEFT OUTER JOIN CM_CO_TablaMaestro AS TAB_ESTAVIVO 
					ON TAB_ESTAVIVO.CodigoTabla = 'TABCOLABORACION' 
				LEFT OUTER JOIN CM_CO_TablaMaestroDetalle AS TAB_ESTAVIVODET 
					ON TAB_ESTAVIVODET.IdTablaMaestro = TAB_ESTAVIVO.IdTablaMaestro AND 
					TAB_ESTAVIVODET.IdCodigo = SS_HC_Anamnesis_AFAM_FE.IdVivo 
				LEFT OUTER JOIN EMPLEADOMAST AS EMPLEADO_PERSSALUD 
					ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud 
				LEFT OUTER JOIN	SS_GE_EspecialidadMedico AS ESPECIALIDAD_MED 
					ON ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud AND 
					ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad


GO

/* ALTER VIEW */

--fecha: 30/01/2017  Nombre:Joel Sebastián  Estado: PUBLICADO
ALTER view [dbo].[rptViewInterconsulta_FE]
AS
SELECT 
	  A.UnidadReplicacion,
	  A.IdEpisodioAtencion
      ,A.IdPaciente
      ,A.EpisodioClinico
      ,A.Secuencia
      ,A.ProximaAtencionFlag
      ,A.FechaSolicitada
      ,A.FechaPlaneada
      ,A.IdEspecialidad
      ,A.IdEstablecimientoSalud
      ,A.IdTipoInterConsulta
      ,A.IdTipoReferencia
      ,A.Observacion
      ,A.IdProcedimiento,
      --,A.CodigoComponente
      ISNULL( MIS.DescripcionLocal,'') AS CodigoComponente
      ,A.TipoOrdenAtencion
      ,A.IndicadorEPS
      ,A.IdPersonalSalud
      ,A.IdDiagnostico
      ,A.ProcedimientoText
      ,A.DiagnosticoText
      ,A.Accion
      ,A.Version
      ,A.Estado
      ,A.UsuarioCreacion
      ,A.FechaCreacion
      ,A.UsuarioModificacion
      ,A.FechaModificacion
	  ,B.Descripcion as EspecialidadDesc,
	dbo.UFN_DIAGNOSTICO_FE(a.UnidadReplicacion,a.IdEpisodioAtencion,a.IdPaciente,a.EpisodioClinico) as diagnostico

FROM SS_HC_InterConsulta_FE AS A   LEFT JOIN SS_GE_Especialidad  AS B
       ON A.IdEspecialidad = B.IdEspecialidad 
       INNER JOIN MA_MiscelaneosDetalle MIS ON MIS.CodigoElemento = A.IdTipoInterConsulta AND
       MIS.CodigoTabla ='INTERCONFE'