
GO
/****** Object:  View [dbo].[GE_UnidadMedida]    Script Date: 16/04/2025 17:07:35 ******/

GO
CREATE OR ALTER VIEW [dbo].[GE_UnidadMedida]
AS 
SELECT IdUnidadMedida,
      UnidadTipo AS TipoMedida,
      IndicadorMedidaBase,
      FactorConversion,
      UnidadCodigo AS CodigoUnidadMedida,
      DescripcionCorta AS Descripcion,
      DescripcionExtranjera AS DescripcionExtranjera,
      NumeroDecimales,
      (CASE Estado WHEN 'A'THEN 2 ELSE 1 END) AS Estado,
      UsuarioCreacion,
      FechaCreacion,
      UltimoUsuario AS UsuarioModificacion,
      UltimaFechaModif AS FechaModificacion,
      indAfectocalculocantidad AS indAfectocalculocantidad
FROM UnidadesMast

GO
/****** Object:  View [dbo].[rptViewInformeAlta_Med]    Script Date: 16/04/2025 17:07:35 ******/
GO

CREATE OR ALTER VIEW [dbo].[rptViewInformeAlta_Med]
AS

SELECT             
					   SS_HC_Medicamento_FE.UnidadReplicacion,
					   SS_HC_Medicamento_FE.IdEpisodioAtencion,
					   SS_HC_Medicamento_FE.IdPaciente,
					   SS_HC_Medicamento_FE.EpisodioClinico,
					   SS_HC_Medicamento_FE.Secuencia,
					   SS_HC_Medicamento_FE.TipoMedicamento,
					   SS_HC_Medicamento_FE.IdUnidadMedida,
					   UM.Descripcion AS DescripcionUnidadMedida,
					   SS_HC_Medicamento_FE.Linea,
					   SS_HC_Medicamento_FE.Familia,
					   SS_HC_Medicamento_FE.SubFamilia,
					   SS_HC_Medicamento_FE.TipoComponente,
					   SS_HC_Medicamento_FE.CodigoComponente,
					   SS_HC_Medicamento_FE.IdVia,
					   SS_HC_Medicamento_FE.Dosis,
					   SS_HC_Medicamento_FE.DiasTratamiento,
					   SS_HC_Medicamento_FE.Frecuencia,
					   SS_HC_Medicamento_FE.Cantidad,
					   SS_HC_Medicamento_FE.IndicadorEPS,
					   SS_HC_Medicamento_FE.TipoReceta,
					   SS_HC_Medicamento_FE.Forma,
					   SS_HC_Medicamento_FE.GrupoMedicamento,
					   SS_HC_Medicamento_FE.Comentario,
					   SS_HC_Medicamento_FE.TipoComida,
					   SS_HC_Medicamento_FE.VolumenDia,
					   SS_HC_Medicamento_FE.FrecuenciaToma,
                       
					   SS_HC_Medicamento_FE.Presentacion,
					   SS_HC_Medicamento_FE.Hora,
					   SS_HC_Medicamento_FE.Periodo,
					   SS_HC_Medicamento_FE.UnidadTiempo,
					   SS_HC_Medicamento_FE.IndicadorAuditoria,
					   SS_HC_Medicamento_FE.UsuarioAuditoria,
					   SS_HC_Medicamento_FE.Indicacion,
					   SS_HC_Medicamento_FE.Estado,
					   SS_HC_Medicamento_FE.UsuarioCreacion,
					   SS_HC_Medicamento_FE.FechaCreacion,
					   SS_HC_Medicamento_FE.UsuarioModificacion,
					   SS_HC_Medicamento_FE.FechaModificacion,
					   SS_HC_Medicamento_FE.Accion,
					   SS_HC_Medicamento_FE.Version,
                       DETUNI.Nombre  UndTiempoFre, DETTIE.Nombre     UndTiempoPeri, DETTOR.Nombre TipRecetaDes,           
                           ( case when (MED.DescripcionLocal IS NOT null OR MED.DescripcionLocal <> '')
                                    then MED.DescripcionLocal else DCI.DescripcionLocal end 

                           ) as MED_DCI ,

                           Via.Descripcion as ViaDesc,

                           UniMed.Descripcion as UnidMedDesc,

                           'GRUPO_'+convert(varchar,SS_HC_Medicamento_FE.Secuencia) as GrupoMed,                        

                           SS_HC_Indicaciones_FE.Descripcion as IndicacionesDesc,

                           0 as SecuenciaMedIndicacion,

                           SS_HC_Indicaciones_FE.Secuencia as SecuenciaIndicacion,

                           TAB_INDIRECETA.Descripcion as IndicadorRecetaDesc,

                           TAB_TIPOREGMED.DescripcionLocal as TipoRegistroMedDesc,

                      /***************************************/

                      /**********ADD GENERALES****************/                     

                      --(PERSONAS)

                      PERSONAMAST.ApellidoPaterno, PERSONAMAST.ApellidoMaterno, PERSONAMAST.Nombres, PERSONAMAST.NombreCompleto,

                      PERSONAMAST.Busqueda, PERSONAMAST.TipoDocumento, PERSONAMAST.Documento, PERSONAMAST.FechaNacimiento,

                      PERSONAMAST.Sexo, PERSONAMAST.EstadoCivil, dbo.[ObtenerEdad](PERSONAMAST.FechaNacimiento)as PersonaEdad

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

                      ,SS_GE_TipoAtencion.Descripcion as TipoAtencionDesc

                      ,SS_TipoTrabajador.DescripcionLocal as TipoTrabajadorDesc

                      ,CM_CO_Establecimiento.Codigo as EstablecimientoCodigo

                      ,AP.CodigoHC as EstablecimientoDesc

                      ,SS_HC_UnidadServicio.Codigo as UnidadServicioCodigo

                      ,SS_HC_UnidadServicio.Descripcion as UnidadServicioDesc

                      ,PERSONA_PERSSALUD.NombreCompleto as PersMedicoNombreCompleto

                      ,PERSONA_PERSSALUD.Documento as PersMedicoNombreDocumento

                      ,SS_GE_Especialidad.Codigo as EspecialidadCodigo

                      ,SS_GE_Especialidad.Nombre as EspecialidadDesc

                      ----ADD AUX

                      ,PERSONA_PERSSALUD.NombreCompleto +
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

                                     --Datos Diagnostico
                                     dbo.UFN_DIAGNOSTICO_FE(SS_HC_Medicamento_FE.UnidadReplicacion,SS_HC_Medicamento_FE.IdEpisodioAtencion,SS_HC_Medicamento_FE.IdPaciente,SS_HC_Medicamento_FE.EpisodioClinico) as DiagnosticoDesc,
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

                                         Compania.DescripcionExtranjera DescripcionLocal, 
                                    --Datos Receta
                                    '' AS TITULAR,

                              ISNULL(  ' del ' + convert(varchar,SS_AD_ORDENATENCION.FechaInicio,103) + ' al ' + convert(varchar,SS_AD_ORDENATENCION.FechaFinal,103),'') 
							    AS VIGENCIA,

                                    '' AS POLIZA,
                                ISNULL(  Aseguradora.Descripcion,'')      AS ASEGURADORA,--
                               ISNULL(  Empleadora.Busqueda,'')    AS EMPLEADORA, -- 
                                    --Datos Medicamento
                                    DCI.DescripcionLocal AS DCI
									
               

FROM    SS_HC_MedicamentoAlta_FE     SS_HC_Medicamento_FE
        INNER JOIN GE_UNIDADMedida UM ON SS_HC_Medicamento_FE.IdUnidadMedida = UM.IdUnidadMedida
       INNER JOIN   PERSONAMAST ON SS_HC_Medicamento_FE.IdPaciente = PERSONAMAST.Persona
       INNER JOIN   SS_HC_EpisodioAtencion     ON SS_HC_Medicamento_FE.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion
                      AND SS_HC_Medicamento_FE.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion
                      AND SS_HC_Medicamento_FE.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente
                      AND SS_HC_Medicamento_FE.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico AND  SS_HC_Medicamento_FE.GrupoMedicamento =0
       LEFT JOIN    SS_GE_TipoAtencion         ON SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
       LEFT JOIN    SS_TipoTrabajador          ON SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                     
       LEFT JOIN    CM_CO_Establecimiento      ON CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                     
       LEFT JOIN    SS_HC_UnidadServicio       ON SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                     
       /****** Object:  Joel   Script Date: 01/02/2017 08:10:07 p.m. ******/           AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
	   LEFT JOIN PERSONAMAST  as PERSONA_PERSSALUD         ON PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
	   
	/****** Object:  Jordan   Script Date: 16/03/2017 08:10:07 p.m. ******/ 
	   INNER JOIN	SS_AD_ORDENATENCION					ON SS_AD_ORDENATENCION.IdOrdenAtencion =SS_HC_EpisodioAtencion.IdOrdenAtencion 	
	   LEFT JOIN	SS_GE_EmpresaSeguro	AS Aseguradora		ON SS_AD_ORDENATENCION.IdEmpresaAseguradora = Aseguradora.IdEmpresa
	   LEFT JOIN	PERSONAMAST			AS Empleadora	ON SS_AD_ORDENATENCION.IdEmpresaEmpleadora = Empleadora.Persona
	/****/  
	   LEFT JOIN	SS_GE_Especialidad				ON SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad    
       LEFT JOIN	WH_ClaseSubFamilia DCI			ON (DCI.Linea = SS_HC_Medicamento_FE.Linea    AND DCI.Familia = SS_HC_Medicamento_FE.Familia
                                      AND DCI.SubFamilia = SS_HC_Medicamento_FE.SubFamilia )
		/****** Object:  Joel   Script Date: 02/02/2017 08:10:07 p.m. ******/ 
             -- AND (SS_HC_Medicamento_FE.CodigoComponente  = '' OR SS_HC_Medicamento_FE.CodigoComponente is null)
       LEFT JOIN    WH_ItemMast MED			ON   (MED.Linea = SS_HC_Medicamento_FE.Linea           AND MED.Familia = SS_HC_Medicamento_FE.Familia
                                      AND MED.SubFamilia = SS_HC_Medicamento_FE.SubFamilia AND ( rtrim(MED.Item)  =  SS_HC_Medicamento_FE.CodigoComponente ) )     
       LEFT JOIN    GE_UnidadMedida UniMed	ON (UniMed.IdUnidadMedida = SS_HC_Medicamento_FE.IdUnidadMedida)
       LEFT JOIN    GE_VARIOS Via			ON   (Via.CodigoTabla = 'TIPOVIA'  AND Via.Secuencial = SS_HC_Medicamento_FE.IdVia   )  
       LEFT JOIN    CM_CO_TablaMaestroDetalle DETUNI ON                   (DETUNI.IdTablaMaestro = 102       AND DETUNI.IdCodigo = SS_HC_Medicamento_FE.UnidadTiempo)   
       LEFT JOIN    CM_CO_TablaMaestroDetalle DETTIE ON                   (DETTIE.IdTablaMaestro = 102       AND DETTIE.IdCodigo = SS_HC_Medicamento_FE.TipoComida)     
       LEFT JOIN    CM_CO_TablaMaestroDetalle DETTOR ON                   (DETTOR.IdTablaMaestro = 46             AND DETTOR.IdCodigo = SS_HC_Medicamento_FE.TipoReceta)     
       LEFT JOIN    SS_HC_Indicaciones_FE
            ON (
                    SS_HC_Medicamento_FE.UnidadReplicacion = SS_HC_Indicaciones_FE.UnidadReplicacion
                    AND SS_HC_Medicamento_FE.IdEpisodioAtencion = SS_HC_Indicaciones_FE.IdEpisodioAtencion
                    AND SS_HC_Medicamento_FE.IdPaciente = SS_HC_Indicaciones_FE.IdPaciente
                    AND SS_HC_Medicamento_FE.EpisodioClinico = SS_HC_Indicaciones_FE.EpisodioClinico
                    AND SS_HC_Medicamento_FE.Secuencia = SS_HC_Indicaciones_FE.SecuenciaMedicamento --AND    SS_HC_Medicamento_FE.GrupoMedicamento=0                                           
			)
		left join    MA_MiscelaneosDetalle  as TAB_TIPOREGMED  on  (  rtrim(TAB_TIPOREGMED.CodigoTabla) = 'TIPOREGMED'    and rtrim(TAB_TIPOREGMED.ValorCodigo1) = rtrim(SS_HC_Indicaciones_FE.TipoRegistro) )
		left join  GE_VARIOS  as TAB_INDIRECETA  on  ( TAB_INDIRECETA.CodigoTabla = 'INDIRECETA'   and TAB_INDIRECETA.Secuencial = SS_HC_Indicaciones_FE.IdTipoIndicacion     )                               

                      --ADD CMP  y RNE

                    LEFT JOIN      EMPLEADOMAST  as EMPLEADO_PERSSALUD      ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud
					LEFT JOIN	   CompaniaMast as Compania                 on EMPLEADO_PERSSALUD.companiasocio  = Compania.PropietarioPorDefecto+Compania.companiacodigo
					left join		AC_Sucursal  AS Sucursal    on  Compania.CompaniaCodigo+ Compania.PropietarioPorDefecto = Sucursal.Compania and Sucursal.Sucursal = SS_HC_Medicamento_FE.UnidadReplicacion             
					LEFT JOIN      SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED    ON (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud
  And ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad  )
 INNER JOIN  SS_GE_Paciente as AP  ON   SS_HC_Medicamento_FE.IdPaciente = AP.IdPaciente 
 WHERE SS_HC_Medicamento_FE.TipoMedicamento = 1
GO
/****** Object:  View [dbo].[rptViewMedicamentos]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewMedicamentos]
AS
SELECT			dbo.SS_HC_Medicamento.UnidadReplicacion,
				dbo.SS_HC_Medicamento.IdPaciente,dbo.SS_HC_Medicamento.EpisodioClinico,
				dbo.SS_HC_Medicamento.IdEpisodioAtencion,
				convert(Integer,ROW_NUMBER() OVER (ORDER BY dbo.SS_HC_Medicamento.Secuencia ASC ))as Secuencia,
				dbo.SS_HC_Medicamento.Linea,
				--dbo.SS_HC_ExamenSolicitado.IdEspecialidad,
				dbo.SS_HC_Medicamento.Familia,
				dbo.SS_HC_Medicamento.SubFamilia,
				dbo.SS_HC_Medicamento.CodigoComponente,
				dbo.SS_HC_Medicamento.TipoComponente,								
				dbo.SS_HC_Medicamento.IdVia,
				dbo.SS_HC_Medicamento.Dosis,
				dbo.SS_HC_Medicamento.DiasTratamiento,
				dbo.SS_HC_Medicamento.Frecuencia,
				dbo.SS_HC_Medicamento.Cantidad,
				dbo.SS_HC_Medicamento.IndicadorEPS,
				dbo.SS_HC_Medicamento.Comentario,
				dbo.SS_HC_Medicamento.TipoComida,
				dbo.SS_HC_Medicamento.Estado,
				dbo.SS_HC_Medicamento.TipoMedicamento,				
				( case when (MED.DescripcionLocal IS NOT null OR MED.DescripcionLocal <> '') 
								then MED.DescripcionLocal else DCI.DescripcionLocal end  
				) as MED_DCI ,
				Via.Descripcion as ViaDesc,
				UniMed.Descripcion as UnidMedDesc,
				'GRUPO_'+convert(varchar,dbo.SS_HC_Medicamento.Secuencia) as GrupoMed,				
				SS_HC_Indicaciones.Descripcion as IndicacionesDesc, 
				SS_HC_Indicaciones.SecuenciaMedicamento as SecuenciaMedIndicacion, 
				SS_HC_Indicaciones.Secuencia as SecuenciaIndicacion, 
				TAB_INDIRECETA.Descripcion as IndicadorRecetaDesc,
				TAB_TIPOREGMED.DescripcionLocal as TipoRegistroMedDesc,
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
                                            
FROM         dbo.SS_HC_Medicamento                       
                      LEFT JOIN
                      dbo.PERSONAMAST ON dbo.SS_HC_Medicamento.IdPaciente = dbo.PERSONAMAST.Persona
						INNER JOIN
                      dbo.SS_HC_EpisodioAtencion 
                      ON dbo.SS_HC_Medicamento.UnidadReplicacion = dbo.SS_HC_EpisodioAtencion.UnidadReplicacion
                      AND dbo.SS_HC_Medicamento.IdEpisodioAtencion = dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion 
                      AND dbo.SS_HC_Medicamento.IdPaciente = dbo.SS_HC_EpisodioAtencion.IdPaciente 
                      AND dbo.SS_HC_Medicamento.EpisodioClinico = dbo.SS_HC_EpisodioAtencion.EpisodioClinico                                             
					LEFT outer JOIN
                      dbo.SS_GE_TipoAtencion
                      ON dbo.SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
					LEFT outer JOIN
                      dbo.SS_TipoTrabajador
                      ON dbo.SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
					LEFT outer JOIN
                      dbo.CM_CO_Establecimiento
                      ON dbo.CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
					LEFT outer JOIN
                      dbo.SS_HC_UnidadServicio
                      ON dbo.SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                      
                    LEFT outer JOIN
                      dbo.PERSONAMAST  as PERSONA_PERSSALUD
                      ON PERSONA_PERSSALUD.Persona = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
                    LEFT outer JOIN
                      dbo.SS_GE_Especialidad  
                      ON SS_GE_Especialidad.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad     
                      --- 									
						Left outer join WH_ClaseSubFamilia DCI on 
							(DCI.Linea = SS_HC_Medicamento.Linea
							AND DCI.Familia = SS_HC_Medicamento.Familia
							AND DCI.SubFamilia = SS_HC_Medicamento.SubFamilia
							AND (SS_HC_Medicamento.CodigoComponente  = '' OR SS_HC_Medicamento.CodigoComponente is null)
							)
						Left outer join WH_ItemMast MED on 
							(MED.Linea = SS_HC_Medicamento.Linea
							AND MED.Familia = SS_HC_Medicamento.Familia
							AND MED.SubFamilia = SS_HC_Medicamento.SubFamilia
							AND ( rtrim(MED.Item)  =  SS_HC_Medicamento.CodigoComponente )
							)	
						Left outer join GE_UnidadMedida UniMed on (UniMed.IdUnidadMedida = SS_HC_Medicamento.IdUnidadMedida)
						Left outer join GE_VARIOS Via on 
							(Via.CodigoTabla = 'TIPOVIA'
							AND Via.Secuencial = SS_HC_Medicamento.IdVia			
							)	
						LEFT outer JOIN	
                      dbo.SS_HC_Indicaciones 
                      ON (
						dbo.SS_HC_Medicamento.UnidadReplicacion = dbo.SS_HC_Indicaciones.UnidadReplicacion
						AND dbo.SS_HC_Medicamento.IdEpisodioAtencion = dbo.SS_HC_Indicaciones.IdEpisodioAtencion 
						AND dbo.SS_HC_Medicamento.IdPaciente = dbo.SS_HC_Indicaciones.IdPaciente 
						AND dbo.SS_HC_Medicamento.EpisodioClinico = dbo.SS_HC_Indicaciones.EpisodioClinico 
						AND dbo.SS_HC_Medicamento.Secuencia = dbo.SS_HC_Indicaciones.SecuenciaMedicamento 							
						)
						 left outer join 
						 MA_MiscelaneosDetalle  as TAB_TIPOREGMED
						 on 
						 (
							rtrim(TAB_TIPOREGMED.CodigoTabla) = 'TIPOREGMED'	
							and rtrim(TAB_TIPOREGMED.ValorCodigo1) = rtrim(SS_HC_Indicaciones.TipoRegistro)
						 )
						 left outer join 
						 GE_VARIOS  as TAB_INDIRECETA
						 on 
						 (
							TAB_INDIRECETA.CodigoTabla = 'INDIRECETA'	
							and TAB_INDIRECETA.Secuencial = SS_HC_Indicaciones.IdTipoIndicacion
						 )					
                      --ADD CMP  y RNE
                    LEFT outer JOIN
                      dbo.EMPLEADOMAST  as EMPLEADO_PERSSALUD
                      ON EMPLEADO_PERSSALUD.Empleado = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
                    LEFT outer JOIN
                      dbo.SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED
                      ON (ESPECIALIDAD_MED.IdMedico = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
						And ESPECIALIDAD_MED.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad
						)							 
						/*	
						Left join AC_Sucursal Suc on (Suc.Sucursal = SS_HC_Medicamento.UnidadReplicacion)			
						Left join companyowner Compania on (Compania.companyowner = Suc.Compania)			
						Left join CompaniaMast Compa on (Compa.CompaniaCodigo = Compania.company)								
						Left join @TABLA_INDICACIONES_MED indMedEspecif on 
							(
								Medicamento.UnidadReplicacion = indMedEspecif.UnidadReplicacion
								and Medicamento.IdPaciente = indMedEspecif.IdPaciente
								and Medicamento.EpisodioClinico = indMedEspecif.EpisodioClinico
								and Medicamento.IdEpisodioAtencion = indMedEspecif.IdEpisodioAtencion			
								and Medicamento.Secuencia = indMedEspecif.SecuenciaMed			
								and indMedEspecif.TipoRegistro = 1
							)		
						Left join @TABLA_INDICACIONES_MED indMedGen on 
							(
								Medicamento.UnidadReplicacion = indMedGen.UnidadReplicacion
								and Medicamento.IdPaciente = indMedGen.IdPaciente
								and Medicamento.EpisodioClinico = indMedGen.EpisodioClinico
								and Medicamento.IdEpisodioAtencion = indMedGen.IdEpisodioAtencion			
								and Medicamento.Secuencia = indMedGen.SecuenciaMed			
								and indMedGen.TipoRegistro = 2
							)	
						*/
			
                    /*LEFT JOIN
                      dbo.CM_CO_Componente  
                      ON (CM_CO_Componente.CodigoComponente = dbo.SS_HC_ExamenSolicitado.CodigoSegus    
                      and dbo.SS_HC_ExamenSolicitado.TipoCodigo = 'S' 
                      )*/
				
		--order by Secuencia,SecuenciaMedIndicacion,SecuenciaIndicacion asc






GO


/****** Object:  View [dbo].[rptViewInformeAlta_Mat]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewInformeAlta_Mat]

AS

SELECT                --SS_HC_Medicamento_FE.*,
                       /*Se está llamando a cada campo Individual para poder cambiar datos del campo presentación debido
					   a que no se está utilizando y poder almacenar el nombre de unidad de medida para Materiales
					    y de esta manera  no alterar nada*/
					   --
					   SS_HC_Medicamento_FE.UnidadReplicacion,
					   SS_HC_Medicamento_FE.IdEpisodioAtencion,
					   SS_HC_Medicamento_FE.IdPaciente,
					   SS_HC_Medicamento_FE.EpisodioClinico,
					   SS_HC_Medicamento_FE.Secuencia,
					   SS_HC_Medicamento_FE.TipoMedicamento,
					   SS_HC_Medicamento_FE.IdUnidadMedida,
					   UM.Descripcion AS DescripcionUnidadMedida,
					   SS_HC_Medicamento_FE.Linea,
					   SS_HC_Medicamento_FE.Familia,
					   SS_HC_Medicamento_FE.SubFamilia,
					   SS_HC_Medicamento_FE.TipoComponente,
					   SS_HC_Medicamento_FE.CodigoComponente,
					   SS_HC_Medicamento_FE.IdVia,
					   SS_HC_Medicamento_FE.Dosis,
					   SS_HC_Medicamento_FE.DiasTratamiento,
					   SS_HC_Medicamento_FE.Frecuencia,
					   SS_HC_Medicamento_FE.Cantidad,
					   SS_HC_Medicamento_FE.IndicadorEPS,
					   SS_HC_Medicamento_FE.TipoReceta,
					   SS_HC_Medicamento_FE.Forma,
					   SS_HC_Medicamento_FE.GrupoMedicamento,
					   SS_HC_Medicamento_FE.Comentario,
					   SS_HC_Medicamento_FE.TipoComida,
					   SS_HC_Medicamento_FE.VolumenDia,
					   SS_HC_Medicamento_FE.FrecuenciaToma,
                       
					   SS_HC_Medicamento_FE.Presentacion,
					   SS_HC_Medicamento_FE.Hora,
					   SS_HC_Medicamento_FE.Periodo,
					   SS_HC_Medicamento_FE.UnidadTiempo,
					   SS_HC_Medicamento_FE.IndicadorAuditoria,
					   SS_HC_Medicamento_FE.UsuarioAuditoria,
					   SS_HC_Medicamento_FE.Indicacion,
					   SS_HC_Medicamento_FE.Estado,
					   SS_HC_Medicamento_FE.UsuarioCreacion,
					   SS_HC_Medicamento_FE.FechaCreacion,
					   SS_HC_Medicamento_FE.UsuarioModificacion,
					   SS_HC_Medicamento_FE.FechaModificacion,
					   SS_HC_Medicamento_FE.Accion,
					   SS_HC_Medicamento_FE.Version,
                       --
                           DETUNI.Nombre  UndTiempoFre, DETTIE.Nombre     UndTiempoPeri, DETTOR.Nombre TipRecetaDes, 
                           ( case when (MED.DescripcionLocal IS NOT null OR MED.DescripcionLocal <> '')
                                                      then MED.DescripcionLocal else DCI.DescripcionLocal end 
                           ) as MED_DCI ,
                           Via.Descripcion as ViaDesc,
                           UniMed.Descripcion as UnidMedDesc,
                           'GRUPO_'+convert(varchar,SS_HC_Medicamento_FE.Secuencia) as GrupoMed, 
                           SS_HC_Indicaciones_FE.Descripcion as IndicacionesDesc,
                           0 as SecuenciaMedIndicacion,
                           SS_HC_Indicaciones_FE.Secuencia as SecuenciaIndicacion,
                           TAB_INDIRECETA.Descripcion as IndicadorRecetaDesc,
                           TAB_TIPOREGMED.DescripcionLocal as TipoRegistroMedDesc,
                      /**********ADD GENERALES****************/ 
                      --(PERSONAS)
                      PERSONAMAST.ApellidoPaterno, PERSONAMAST.ApellidoMaterno, PERSONAMAST.Nombres, PERSONAMAST.NombreCompleto,
                      PERSONAMAST.Busqueda, PERSONAMAST.TipoDocumento, PERSONAMAST.Documento, PERSONAMAST.FechaNacimiento,
                      PERSONAMAST.Sexo, PERSONAMAST.EstadoCivil, dbo.[ObtenerEdad](PERSONAMAST.FechaNacimiento)as PersonaEdad
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

                      ,SS_GE_TipoAtencion.Descripcion as TipoAtencionDesc

                      ,SS_TipoTrabajador.DescripcionLocal as TipoTrabajadorDesc

                      ,CM_CO_Establecimiento.Codigo as EstablecimientoCodigo

                      ,AP.CodigoHC as EstablecimientoDesc

                      ,SS_HC_UnidadServicio.Codigo as UnidadServicioCodigo

                      ,SS_HC_UnidadServicio.Descripcion as UnidadServicioDesc

                      ,PERSONA_PERSSALUD.NombreCompleto as PersMedicoNombreCompleto

                      ,PERSONA_PERSSALUD.Documento as PersMedicoNombreDocumento

                      ,SS_GE_Especialidad.Codigo as EspecialidadCodigo

                      ,SS_GE_Especialidad.Nombre as EspecialidadDesc
                      ----ADD AUX
                      ,PERSONA_PERSSALUD.NombreCompleto +
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

                      --Datos Diagnostico
                        dbo.UFN_DIAGNOSTICO_FE(SS_HC_Medicamento_FE.UnidadReplicacion,SS_HC_Medicamento_FE.IdEpisodioAtencion,SS_HC_Medicamento_FE.IdPaciente,SS_HC_Medicamento_FE.EpisodioClinico) as DiagnosticoDesc,
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

                            Compania.DescripcionExtranjera DescripcionLocal, 
                                --Datos Receta
                                '' AS TITULAR,

                            ISNULL(  ' del ' + convert(varchar,SS_AD_ORDENATENCION.FechaInicio,103) + ' al ' + convert(varchar,SS_AD_ORDENATENCION.FechaFinal,103),'') 
							AS VIGENCIA,

                                '' AS POLIZA,
                            ISNULL(  Aseguradora.Descripcion,'')      AS ASEGURADORA,--
                            ISNULL(  Empleadora.Busqueda,'')    AS EMPLEADORA, -- 
                                --Datos Medicamento
                                DCI.DescripcionLocal AS DCI	
FROM    SS_HC_MedicamentoAlta_FE     SS_HC_Medicamento_FE WITH(NOLOCK) 
        INNER JOIN GE_UNIDADMedida UM			WITH(NOLOCK) ON SS_HC_Medicamento_FE.IdUnidadMedida = UM.IdUnidadMedida
       INNER JOIN   PERSONAMAST					WITH(NOLOCK) ON SS_HC_Medicamento_FE.IdPaciente = PERSONAMAST.Persona
       INNER JOIN   SS_HC_EpisodioAtencion      WITH(NOLOCK) ON SS_HC_Medicamento_FE.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion
                      AND SS_HC_Medicamento_FE.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion
                      AND SS_HC_Medicamento_FE.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente
                      AND SS_HC_Medicamento_FE.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico AND  SS_HC_Medicamento_FE.GrupoMedicamento =0
       LEFT JOIN    SS_GE_TipoAtencion          WITH(NOLOCK) ON SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
       LEFT JOIN    SS_TipoTrabajador           WITH(NOLOCK) ON SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                     
       LEFT JOIN    CM_CO_Establecimiento       WITH(NOLOCK) ON CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                     
       LEFT JOIN    SS_HC_UnidadServicio        WITH(NOLOCK) ON SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                     
       /****** Object:  Joel   Script Date: 01/02/2017 08:10:07 p.m. ******/           AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
	   LEFT JOIN PERSONAMAST  as PERSONA_PERSSALUD      WITH(NOLOCK) ON PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud	   
	/****** Object:  Jordan   Script Date: 16/03/2017 08:10:07 p.m. ******/ 
	   INNER JOIN	SS_AD_ORDENATENCION					WITH(NOLOCK) ON SS_AD_ORDENATENCION.IdOrdenAtencion =SS_HC_EpisodioAtencion.IdOrdenAtencion 	
	   LEFT JOIN	SS_GE_EmpresaSeguro	AS Aseguradora	WITH(NOLOCK) ON SS_AD_ORDENATENCION.IdEmpresaAseguradora = Aseguradora.IdEmpresa
	   LEFT JOIN	PERSONAMAST			AS Empleadora	ON SS_AD_ORDENATENCION.IdEmpresaEmpleadora = Empleadora.Persona
	/****/  
	   LEFT JOIN	SS_GE_Especialidad			WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad    
       LEFT JOIN	WH_ClaseSubFamilia DCI		WITH(NOLOCK) ON (DCI.Linea = SS_HC_Medicamento_FE.Linea    AND DCI.Familia = SS_HC_Medicamento_FE.Familia
                                      AND DCI.SubFamilia = SS_HC_Medicamento_FE.SubFamilia )
		/****** Object:  Joel   Script Date: 02/02/2017 08:10:07 p.m. ******/ 
             -- AND (SS_HC_Medicamento_FE.CodigoComponente  = '' OR SS_HC_Medicamento_FE.CodigoComponente is null)
       LEFT JOIN    WH_ItemMast MED				WITH(NOLOCK) ON   (MED.Linea = SS_HC_Medicamento_FE.Linea           AND MED.Familia = SS_HC_Medicamento_FE.Familia
                                      AND MED.SubFamilia = SS_HC_Medicamento_FE.SubFamilia AND ( rtrim(MED.Item)  =  SS_HC_Medicamento_FE.CodigoComponente ) )     
       LEFT JOIN    GE_UnidadMedida UniMed		WITH(NOLOCK) ON   (UniMed.IdUnidadMedida = SS_HC_Medicamento_FE.IdUnidadMedida)
       LEFT JOIN    GE_VARIOS Via				WITH(NOLOCK) ON   (Via.CodigoTabla = 'TIPOVIA'  AND Via.Secuencial = SS_HC_Medicamento_FE.IdVia   )  
       LEFT JOIN    CM_CO_TablaMaestroDetalle DETUNI  WITH(NOLOCK) ON     (DETUNI.IdTablaMaestro = 102       AND DETUNI.IdCodigo = SS_HC_Medicamento_FE.UnidadTiempo)   
       LEFT JOIN    CM_CO_TablaMaestroDetalle DETTIE  WITH(NOLOCK) ON     (DETTIE.IdTablaMaestro = 102       AND DETTIE.IdCodigo = SS_HC_Medicamento_FE.TipoComida)     
       LEFT JOIN    CM_CO_TablaMaestroDetalle DETTOR  WITH(NOLOCK) ON     (DETTOR.IdTablaMaestro = 46        AND DETTOR.IdCodigo = SS_HC_Medicamento_FE.TipoReceta)     
       LEFT JOIN    SS_HC_Indicaciones_FE WITH(NOLOCK) 
            ON (
                    SS_HC_Medicamento_FE.UnidadReplicacion = SS_HC_Indicaciones_FE.UnidadReplicacion
                    AND SS_HC_Medicamento_FE.IdEpisodioAtencion = SS_HC_Indicaciones_FE.IdEpisodioAtencion
                    AND SS_HC_Medicamento_FE.IdPaciente = SS_HC_Indicaciones_FE.IdPaciente
                    AND SS_HC_Medicamento_FE.EpisodioClinico = SS_HC_Indicaciones_FE.EpisodioClinico
                    AND SS_HC_Medicamento_FE.Secuencia = SS_HC_Indicaciones_FE.SecuenciaMedicamento --AND    SS_HC_Medicamento_FE.GrupoMedicamento=0                                           
			)
		LEFT JOIN    MA_MiscelaneosDetalle  as TAB_TIPOREGMED   WITH(NOLOCK) on  (  rtrim(TAB_TIPOREGMED.CodigoTabla) = 'TIPOREGMED'    and rtrim(TAB_TIPOREGMED.ValorCodigo1) = rtrim(SS_HC_Indicaciones_FE.TipoRegistro) )
		LEFT JOIN    GE_VARIOS  as TAB_INDIRECETA				WITH(NOLOCK) on  ( TAB_INDIRECETA.CodigoTabla = 'INDIRECETA'   and TAB_INDIRECETA.Secuencial = SS_HC_Indicaciones_FE.IdTipoIndicacion     )  
                      --ADD CMP  y RNE
        LEFT JOIN      EMPLEADOMAST  as EMPLEADO_PERSSALUD       WITH(NOLOCK) ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud
		LEFT JOIN	   CompaniaMast as Compania                  WITH(NOLOCK) on EMPLEADO_PERSSALUD.companiasocio  = Compania.PropietarioPorDefecto+Compania.companiacodigo
		left join	  AC_Sucursal  AS Sucursal					WITH(NOLOCK) on  Compania.CompaniaCodigo+ Compania.PropietarioPorDefecto = Sucursal.Compania and Sucursal.Sucursal = SS_HC_Medicamento_FE.UnidadReplicacion             
		LEFT JOIN      SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED     WITH(NOLOCK) ON (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud
					And ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad  )
	   INNER JOIN  SS_GE_Paciente as AP   WITH(NOLOCK) ON   SS_HC_Medicamento_FE.IdPaciente = AP.IdPaciente 
	 WHERE SS_HC_Medicamento_FE.TipoMedicamento = 4

GO
/****** Object:  View [dbo].[rptViewMedicamentos_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewMedicamentos_FE]
AS
SELECT                SS_HC_Medicamento_FE.*,

                           DETUNI.Nombre  UndTiempoFre, DETTIE.Nombre     UndTiempoPeri, DETTOR.Nombre TipRecetaDes,  
                           ( case when (MED.DescripcionLocal IS NOT null OR MED.DescripcionLocal <> '')
                                                      then MED.DescripcionLocal else DCI.DescripcionLocal end 
                           ) as MED_DCI ,
                           Via.Descripcion as ViaDesc,
                           UniMed.Descripcion as UnidMedDesc,
                           'GRUPO_'+convert(varchar,SS_HC_Medicamento_FE.Secuencia) as GrupoMed,     
                           SS_HC_Indicaciones_FE.Descripcion as IndicacionesDesc,

                         CONVERT(int, 0) as SecuenciaMedIndicacion,

                           SS_HC_Indicaciones_FE.Secuencia as SecuenciaIndicacion,

                           TAB_INDIRECETA.Descripcion as IndicadorRecetaDesc,

                           TAB_TIPOREGMED.DescripcionLocal as TipoRegistroMedDesc,

                      /***************************************/

                      /**********ADD GENERALES****************/                     

                      --(PERSONAS)

                      PERSONAMAST.ApellidoPaterno, PERSONAMAST.ApellidoMaterno, PERSONAMAST.Nombres, PERSONAMAST.NombreCompleto,

                      PERSONAMAST.Busqueda, PERSONAMAST.TipoDocumento, PERSONAMAST.Documento, PERSONAMAST.FechaNacimiento,

                      PERSONAMAST.Sexo, PERSONAMAST.EstadoCivil, dbo.[ObtenerEdad](PERSONAMAST.FechaNacimiento)as PersonaEdad

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

                      ,AP.CodigoHC as EstablecimientoDesc

					 ,EMPLEADO_PERSSALUD.FirmaDigital  as UnidadServicioCodigo
                   --   ,SS_HC_UnidadServicio.Codigo as UnidadServicioCodigo

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

                                     

                                     --Datos Diagnostico

                                     dbo.UFN_DIAGNOSTICO_FE(SS_HC_Medicamento_FE.UnidadReplicacion,SS_HC_Medicamento_FE.IdEpisodioAtencion,SS_HC_Medicamento_FE.IdPaciente,SS_HC_Medicamento_FE.EpisodioClinico) as DiagnosticoDesc,

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

                                          Sucursal.DescripcionLocal,
                                     '' AS TITULAR,

                              ISNULL(  ' del ' + convert(varchar,SS_AD_ORDENATENCION.FechaInicio,103) + ' al ' + convert(varchar,SS_AD_ORDENATENCION.FechaFinal,103),'') 
							    AS VIGENCIA,

                                    '.' AS POLIZA,
                                ISNULL(  Aseguradora.Descripcion,'')      AS ASEGURADORA,--
                               ISNULL(  Empleadora.Busqueda,'')    AS EMPLEADORA, -- 
                                    --Datos Medicamento
                                    DCI.DescripcionLocal AS DCI
               

FROM     SS_HC_Medicamento_FE    SS_HC_Medicamento_FE WITH(NOLOCK) 
       LEFT JOIN   PERSONAMAST WITH(NOLOCK) ON SS_HC_Medicamento_FE.IdPaciente = PERSONAMAST.Persona
       INNER JOIN   SS_HC_EpisodioAtencion     WITH(NOLOCK) ON SS_HC_Medicamento_FE.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion
                      AND SS_HC_Medicamento_FE.IdEpisodioAtencion =(CASE WHEN SS_HC_EpisodioAtencion.TipoAtencion in (2,3) THEN
					 SS_HC_EpisodioAtencion.IdEpisodioAtencion ELSE SS_HC_EpisodioAtencion.EpisodioAtencion END )
                      AND SS_HC_Medicamento_FE.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente
                      AND SS_HC_Medicamento_FE.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico AND  SS_HC_Medicamento_FE.GrupoMedicamento =0
       LEFT JOIN    SS_GE_TipoAtencion         WITH(NOLOCK) ON SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
       LEFT JOIN    SS_TipoTrabajador          WITH(NOLOCK) ON SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                    
       LEFT JOIN    CM_CO_Establecimiento      WITH(NOLOCK) ON CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                     
       LEFT JOIN    SS_HC_UnidadServicio       WITH(NOLOCK) ON SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                     
       /****** Object:  Joel   Script Date: 01/02/2017 08:10:07 p.m. ******/           AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
	   LEFT JOIN PERSONAMAST  as PERSONA_PERSSALUD	WITH(NOLOCK) ON PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
	   LEFT JOIN SS_GE_Especialidad                 WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad    
       LEFT JOIN    WH_ClaseSubFamilia DCI		WITH(NOLOCK) ON (DCI.Linea = SS_HC_Medicamento_FE.Linea    AND DCI.Familia = SS_HC_Medicamento_FE.Familia
                                      AND DCI.SubFamilia = SS_HC_Medicamento_FE.SubFamilia )
	  /****** Object:  Jordan   Script Date: 16/03/2017 08:10:07 p.m. ******/ 
	   INNER JOIN	SS_AD_ORDENATENCION					WITH(NOLOCK) ON SS_AD_ORDENATENCION.IdOrdenAtencion =SS_HC_EpisodioAtencion.IdOrdenAtencion 	
	   LEFT JOIN	SS_GE_EmpresaSeguro	AS Aseguradora	WITH(NOLOCK) ON SS_AD_ORDENATENCION.IdEmpresaAseguradora = Aseguradora.IdEmpresa
	   LEFT JOIN	PERSONAMAST			AS Empleadora	WITH(NOLOCK) ON SS_AD_ORDENATENCION.IdEmpresaEmpleadora = Empleadora.Persona
       LEFT JOIN    WH_ItemMast MED			WITH(NOLOCK) ON   (MED.Linea = SS_HC_Medicamento_FE.Linea           AND MED.Familia = SS_HC_Medicamento_FE.Familia
                                      AND MED.SubFamilia = SS_HC_Medicamento_FE.SubFamilia AND ( rtrim(MED.Item)  =  SS_HC_Medicamento_FE.CodigoComponente ) )     
       LEFT JOIN    GE_UnidadMedida UniMed	WITH(NOLOCK) ON (UniMed.IdUnidadMedida = SS_HC_Medicamento_FE.IdUnidadMedida)
       LEFT JOIN    GE_VARIOS Via			WITH(NOLOCK) ON   (Via.CodigoTabla = 'TIPOVIA'  AND Via.Secuencial = SS_HC_Medicamento_FE.IdVia   )  
       LEFT JOIN    CM_CO_TablaMaestroDetalle DETUNI WITH(NOLOCK) ON                   (DETUNI.IdTablaMaestro = 102       AND DETUNI.IdCodigo = SS_HC_Medicamento_FE.UnidadTiempo)   
       LEFT JOIN    CM_CO_TablaMaestroDetalle DETTIE WITH(NOLOCK) ON                   (DETTIE.IdTablaMaestro = 102       AND DETTIE.IdCodigo = SS_HC_Medicamento_FE.TipoComida)     
       LEFT JOIN    CM_CO_TablaMaestroDetalle DETTOR WITH(NOLOCK) ON                   (DETTOR.IdTablaMaestro = 46             AND DETTOR.IdCodigo = SS_HC_Medicamento_FE.TipoReceta)     
       LEFT JOIN    SS_HC_Indicaciones_FE
            WITH(NOLOCK) ON (
                    SS_HC_Medicamento_FE.UnidadReplicacion = SS_HC_Indicaciones_FE.UnidadReplicacion
                    AND SS_HC_Medicamento_FE.IdEpisodioAtencion = SS_HC_Indicaciones_FE.IdEpisodioAtencion
                    AND SS_HC_Medicamento_FE.IdPaciente = SS_HC_Indicaciones_FE.IdPaciente
                    AND SS_HC_Medicamento_FE.EpisodioClinico = SS_HC_Indicaciones_FE.EpisodioClinico
                    AND SS_HC_Medicamento_FE.Secuencia = SS_HC_Indicaciones_FE.SecuenciaMedicamento --AND    SS_HC_Medicamento_FE.GrupoMedicamento=0                                           
			)
		left join    MA_MiscelaneosDetalle  as TAB_TIPOREGMED  WITH(NOLOCK) on  (  rtrim(TAB_TIPOREGMED.CodigoTabla) = 'TIPOREGMED'    and rtrim(TAB_TIPOREGMED.ValorCodigo1) = rtrim(SS_HC_Indicaciones_FE.TipoRegistro) )
		left join  GE_VARIOS  as TAB_INDIRECETA					WITH(NOLOCK) on  ( TAB_INDIRECETA.CodigoTabla = 'INDIRECETA'   and TAB_INDIRECETA.Secuencial = SS_HC_Indicaciones_FE.IdTipoIndicacion     )                               
                      --ADD CMP  y RNE
        LEFT JOIN      EMPLEADOMAST  as EMPLEADO_PERSSALUD      WITH(NOLOCK) ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud
		LEFT JOIN	   CompaniaMast as Compania                 WITH(NOLOCK) on EMPLEADO_PERSSALUD.companiasocio  = Compania.PropietarioPorDefecto+Compania.companiacodigo
		left join		AC_Sucursal  AS Sucursal				WITH(NOLOCK) on  Compania.CompaniaCodigo+ Compania.PropietarioPorDefecto = Sucursal.Compania and Sucursal.Sucursal = SS_HC_Medicamento_FE.UnidadReplicacion             
		LEFT JOIN      SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED    WITH(NOLOCK) ON (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud
						And ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad  )
		LEFT JOIN  SS_GE_Paciente as AP							WITH(NOLOCK) ON   SS_HC_Medicamento_FE.IdPaciente = AP.IdPaciente

GO
/****** Object:  View [dbo].[vw_Imprimir_HC_GRILLAMEDICAMENTO]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[vw_Imprimir_HC_GRILLAMEDICAMENTO]
as
SELECT   
  Item,  
  ItemTipo,  
  Linea,  
  Familia,  
  SubFamilia,  
  SubFamiliaInferior,  
  DescripcionLocal,  
  DescripcionIngles,  
  DescripcionCompleta,  
  NumeroDeParte,  
  CodigoInterno,  
  UnidadCodigo,  
  UnidadCompra,  
  UnidadEmbalaje,  
  U.Descripcion as Color ,  
  Modelo,  
  MarcaCodigo,  
  ItemProcedencia,  
  ClasificacionComercial,  
  PartidaArancelaria,  
  CodigoBarras,  
  CodigoBarrasFabricante,  
  CodigoBarras2,  
  MonedaCodigo,  
  PrecioCosto,  
  PrecioUnitarioLocal,  
  PrecioUnitarioDolares,  
  ItemPrecioFlag,  
  ItemPrecioCodigo,  
  DisponibleVentaFlag,  
  ManejoxLoteFlag,  
  ManejoxSerieFlag,  
  ManejoxKitFlag,  
  ManejoxKitSplitFlag,  
  ManejoxUnidadFlag,  
  AfectoImpuestoVentasFlag,  
  AfectoImpuesto2Flag,  
  RequisicionamientoAutomaticoFl,  
  ControlCalidadFlag,  
  DisponibleTransferenciaFlag,  
  DisponibleConsumoFlag,  
  FormularioFlag,  
  FormularioNroJuegos,  
  ISOAplicableFlag,  
  ISONormaInterna,  
  CantidadDobleFlag,  
  CantidadDobleFactor,  
  UnidadCodigoDoble,  
  UnidadReplicacion,  
  ImageFile,  
  MapaFile,  
  CuentaInventario,  
  CuentaGasto,  
  CuentaInversion,  
  CuentaServicioTecnico,  
  CuentaSalidaTerceros,  
  CuentaVentas,  
  CuentaTransito,  
  ElementoGasto,  
  ElementoInversion,  
  PartidaPresupuestal,  
  FlujodeCaja,  
  LotedeCompra,  
  LotedeDespacho,  
  LotedeCompraM3,  
  LotedeCompraKG,  
  PeriodicidadCompraMeses,  
  EspecificacionTecnica,  
  Dimensiones,  
  FactorEquivalenciaComercial,  
  ABCCodigo,  
  InventarioTolerancia,  
  StockMinimo,  
  StockMaximo,  
  LotedeVenta,  
  DescripcionAdicional,  
  CodigoPrecio,  
  CaracteristicaValor01,  
  CaracteristicaValor02,  
  CaracteristicaValor03,  
  CaracteristicaValor04,  
  CaracteristicaValor05,  
  ReferenciaFiscal02,  
  ReferenciaFiscalIngreso02,  
  DetraccionCodigo,  
  W.Estado,  
  PeriodicidadCompra,  
  UltimaFechaModif,  
  UltimoUsuario,  
  Centrocosto,  
  ConceptoGasto,  
  ClasificadorMovimiento,  
  FlujodeCajaIngreso,  
  MapaCodigo,  
  paisfabricacion,  
  ABCCodigoIN,  
  Lectura,  
  IdGrupoComponente,  
  IdRegimenVenta,  
  IndicadorReemplazo,  
  W.UsuarioCreacion,  
  W.FechaCreacion,  
  CuentaVentaComercial,  
  CuentaDescuentoVentaComercial,  
  IndicadorCuentaVenta,  
  TipoRepuesto,  
  Cantidadkit,  
  PeriodoInicioReposicion,  
  PeriodosReposicion,  
  IndicadorClasificacion,  
  PeridoInicioReposicion,  
  IdClasificacion,  
  cantidadReposicion,  
  grupoReposicion,  
  IndicadorReposicion,  
  IndicadorPrecioManual,  
  IndicadorConsumoFraccionado,  
  nombreLaboratorio,  
  estadoAnterior,  
  CuentaCompras,  
  PrecioCostoAnt,  
  UltimaOC,  
  PreviaOC,  
  tipomedicamento,  
  CodigoDigemid,  
  EAN13,  
  MedicamentoCodigo,  
  MedicamentoCodigoPadre,  
  NombreTabla,  
  tipofolder,  
  Accion    
  
      
 FROM wh_ItemMast W inner join GE_UnidadMedida U    
       ON W.UnidadCodigo = U.CodigoUnidadMedida  





GO
/****** Object:  View [dbo].[rptViewDieta_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[rptViewDieta_FE]
AS

SELECT	        SS_HC_Medicamento_FE.*,
					  (case when SS_HC_EpisodioAtencion.TipoAtencion in (2,3) then  SS_HC_EpisodioAtencion.IdEpisodioAtencion  else
					  SS_HC_EpisodioAtencion.EpisodioAtencion end)as EpisodioAtencion,
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
				convert(varchar ,SS_HC_Indicaciones_FE.SecuenciaMedicamento) as SecuenciaMedIndicacion, --ANGEL 13/08/2019 CONVERTIMOS A VARCHAR EL SS_HC_Indicaciones_FE.SecuenciaMedicamento
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
                    --  ,SS_HC_UnidadServicio.Codigo as UnidadServicioCodigo
					,EMPLEADO_PERSSALUD.FirmaDigital as UnidadServicioCodigo
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
					  THEN SS_HC_Medicamento_FE.Indicacion  --cambio Angel 03/09/2019 Para mostrar detalle la Indicacion
					  ELSE ''
					  END
					  as ComentarioDieta,
						CASE  SS_HC_Medicamento_FE.TIPOMEDICAMENTO WHEN 3
					  THEN SS_HC_Medicamento_FE.Indicacion --cambio Angel 03/09/2019 Para mostrar detalle la Indicacion
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
						  Sucursal.DescripcionLocal,
					  PADRE.Descripcion PadreDescripcion, 
					  HIJO.Descripcion HijoDescripcion

FROM     SS_HC_Medicamento_FE  SS_HC_Medicamento_FE                       
            
	INNER JOIN	PERSONAMAST 
		WITH(NOLOCK) ON SS_HC_Medicamento_FE.IdPaciente = PERSONAMAST.Persona
	INNER JOIN	SS_HC_EpisodioAtencion 
        WITH(NOLOCK) ON SS_HC_Medicamento_FE.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion AND
                -- AND SS_HC_Medicamento_FE.IdEpisodioAtencion = SS_HC_EpisodioAtencion.EpisodioAtencion --IdEpisodioAtencion 05/06/2017	
					SS_HC_Medicamento_FE.IdEpisodioAtencion=(CASE WHEN SS_HC_EpisodioAtencion.TipoAtencion in (2,3) THEN
					SS_HC_EpisodioAtencion.IdEpisodioAtencion  
					ELSE SS_HC_EpisodioAtencion.EpisodioAtencion END )
					----ANGEL 05/05/2020
					--  AND   SS_HC_EpisodioAtencion.EpisodioAtencion = 
					-- (case when SS_HC_EpisodioAtencion.TipoAtencion in (2,3) then SS_HC_EpisodioAtencion.IdEpisodioAtencion else
					-- SS_HC_Medicamento_FE.IdEpisodioAtencion end) 
                    AND SS_HC_Medicamento_FE.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente 
                    AND SS_HC_Medicamento_FE.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico                                             
	LEFT JOIN	SS_GE_TipoAtencion						
					WITH(NOLOCK) ON SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
	LEFT JOIN	SS_TipoTrabajador						
					WITH(NOLOCK) ON SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
	LEFT JOIN	CM_CO_Establecimiento                     
					WITH(NOLOCK) ON CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
	LEFT JOIN	SS_HC_UnidadServicio                      
					WITH(NOLOCK) ON SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                      
      		AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud	
	LEFT JOIN	PERSONAMAST  as PERSONA_PERSSALUD         
					WITH(NOLOCK) ON PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
    LEFT JOIN	SS_GE_Especialidad                        
					WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad    						
	LEFT JOIN	WH_ClaseSubFamilia DCI 
					WITH(NOLOCK) on (DCI.Linea = SS_HC_Medicamento_FE.Linea
							AND DCI.Familia = SS_HC_Medicamento_FE.Familia
							AND DCI.SubFamilia = SS_HC_Medicamento_FE.SubFamilia
						--	AND (SS_HC_Medicamento_FE.CodigoComponente  = '' OR SS_HC_Medicamento_FE.CodigoComponente is null)
							)
	LEFT JOIN	WH_ItemMast MED 
				WITH(NOLOCK) on			(MED.Linea = SS_HC_Medicamento_FE.Linea
							AND MED.Familia = SS_HC_Medicamento_FE.Familia
							AND MED.SubFamilia = SS_HC_Medicamento_FE.SubFamilia
							AND ( rtrim(MED.Item)  =  SS_HC_Medicamento_FE.CodigoComponente )
							)	
	LEFT JOIN	GE_UnidadMedida UniMed 
				WITH(NOLOCK) on (UniMed.IdUnidadMedida = SS_HC_Medicamento_FE.IdUnidadMedida)
	LEFT JOIN	GE_VARIOS Via 
				WITH(NOLOCK) on 			(Via.CodigoTabla = 'TIPODIETA1'
							AND Via.Secuencial = SS_HC_Medicamento_FE.IdVia			
							)
	LEFT JOIN	CM_CO_TablaMaestroDetalle DETUNI 
				WITH(NOLOCK) ON 			(DETUNI.IdTablaMaestro = 102	AND DETUNI.IdCodigo = SS_HC_Medicamento_FE.UnidadTiempo)	
	LEFT JOIN	CM_CO_TablaMaestroDetalle DETTIE 
				WITH(NOLOCK) ON 			(DETTIE.IdTablaMaestro = 102	AND DETTIE.IdCodigo = SS_HC_Medicamento_FE.TipoComida)	
	LEFT JOIN	CM_CO_TablaMaestroDetalle DETTOR 
				WITH(NOLOCK) ON 			(DETTOR.IdTablaMaestro = 46		AND DETTOR.IdCodigo = SS_HC_Medicamento_FE.TipoReceta)	
	LEFT JOIN	SS_HC_Indicaciones_FE
                WITH(NOLOCK) ON (
						SS_HC_Medicamento_FE.UnidadReplicacion = SS_HC_Indicaciones_FE.UnidadReplicacion
						AND SS_HC_Medicamento_FE.IdEpisodioAtencion = SS_HC_Indicaciones_FE.IdEpisodioAtencion 
						AND SS_HC_Medicamento_FE.IdPaciente = SS_HC_Indicaciones_FE.IdPaciente 
						AND SS_HC_Medicamento_FE.EpisodioClinico = SS_HC_Indicaciones_FE.EpisodioClinico 
						AND SS_HC_Medicamento_FE.Secuencia = SS_HC_Indicaciones_FE.SecuenciaMedicamento 							
						)
	left join  MA_MiscelaneosDetalle  as TAB_TIPOREGMED
				WITH(NOLOCK) on  (
							rtrim(TAB_TIPOREGMED.CodigoTabla) = 'TIPOREGMED'	
							and rtrim(TAB_TIPOREGMED.ValorCodigo1) = rtrim(SS_HC_Indicaciones_FE.TipoRegistro)
						 )
	left join  GE_VARIOS  as TAB_INDIRECETA
				WITH(NOLOCK) on  (
							TAB_INDIRECETA.CodigoTabla = 'INDIRECETA'	
							and TAB_INDIRECETA.Secuencial = SS_HC_Indicaciones_FE.IdTipoIndicacion
						 )					
                      --ADD CMP  y RNE
    LEFT JOIN      EMPLEADOMAST  as EMPLEADO_PERSSALUD
                WITH(NOLOCK) ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud
	left join CompaniaMast as Compania
				WITH(NOLOCK) on EMPLEADO_PERSSALUD.companiasocio  = Compania.PropietarioPorDefecto+Compania.companiacodigo 
	 left join AC_Sucursal  AS Sucursal
				WITH(NOLOCK) on  Compania.CompaniaCodigo+ Compania.PropietarioPorDefecto = Sucursal.Compania and 
					 Sucursal.Sucursal = SS_HC_Medicamento_FE.UnidadReplicacion			
	LEFT JOIN     SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED
                WITH(NOLOCK) ON (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud
						And ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad
						)
		LEFT JOIN  SS_HC_CATALOGODIETA PADRE ON PADRE.Nivel =1  AND PADRE.IdDieta =  IdPadreNutriente
		LEFT JOIN  SS_HC_CATALOGODIETA HIJO  ON HIJO.Nivel  =2   AND HIJO.IdDieta  =  IdHijoNutriente

WHERE SS_HC_Medicamento_FE.TipoMedicamento in(2,3) 

GO
/****** Object:  View [dbo].[rptHojaRecienNacido_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptHojaRecienNacido_FE]
AS
SELECT RN.*,
 /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.Nombres, dbo.PERSONAMAST.NombreCompleto, 
                      dbo.PERSONAMAST.Busqueda, dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.FechaNacimiento AS FechaNacimientoPac, 
                      dbo.PERSONAMAST.Sexo AS SexoPac , dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.edad as PersonaEdad
                      --EPI ATENCIÓN
                      ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoOrdenAtencion  AS TipoOrdenAtencionPac
                      ,SS_HC_EpisodioAtencion.TipoAtencion
                      ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                      ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio
                      ,SS_HC_EpisodioAtencion.IdPersonalSalud
                      ,SS_HC_EpisodioAtencion.FechaRegistro AS FechaRegistroPac
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      ,SS_HC_EpisodioAtencion.IdEspecialidad AS IdEspecialidadPac
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

FROM [dbo].[SS_HC_HojaRecienNacido_FE] RN
LEFT JOIN SS_HC_HojaRecienNacidoDetalle_FE RND ON

		RN.UnidadReplicacion = RND.UnidadReplicacion AND
		RN.IdEpisodioAtencion =RND.IdEpisodioAtencion AND
		RN.IdPaciente = RND.IdPaciente AND
		RN.EpisodioClinico = RND.EpisodioClinico

INNER JOIN  SS_HC_EpisodioAtencion ON 
                    SS_HC_EpisodioAtencion.UnidadReplicacion = RN.UnidadReplicacion   AND
                    RN.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND
                    RN.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND
                    RN.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico
INNER JOIN  PERSONAMAST ON RN.IdPaciente = PERSONAMAST.Persona                    
LEFT JOIN SS_GE_TipoAtencion ON 
                    SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
LEFT JOIN
                    SS_TipoTrabajador ON 
                    SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador
LEFT JOIN  CM_CO_Establecimiento ON
                    CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud

LEFT JOIN  SS_HC_UnidadServicio ON 
                    SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
                               /****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/           AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
                    LEFT JOIN  PERSONAMAST AS PERSONA_PERSSALUD ON 
                    PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
                    
                    LEFT JOIN  SS_GE_Especialidad ON 
                    SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad 
                    
                    --LEFT JOIN
                    --SS_GE_ProcedimientoMedico ON 
                    --(SS_GE_ProcedimientoMedico.IdProcedimiento = SC.IdProcedimiento AND SC.TipoCodigo = 'C')
                    
                    LEFT JOIN
                    EMPLEADOMAST AS EMPLEADO_PERSSALUD ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud 
                    
                    LEFT JOIN
                    SS_GE_EspecialidadMedico AS ESPECIALIDAD_MED ON 
                    (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud AND
                    ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad)



GO
/****** Object:  View [dbo].[rptView_ValoracionFuncionalAM_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

CREATE OR ALTER VIEW [dbo].[rptView_ValoracionFuncionalAM_FE]
AS


SELECT
Unidadreplicacion,
idEpisodioAtencion,
Idpaciente,
EpisodioClinico,
CASE LAVARSE WHEN 'D' 
THEN 'X' 
ELSE ''
END AS LD,
CASE LAVARSE WHEN 'I' 
THEN 'X' 
ELSE ''
END AS LI,
CASE Vestirse WHEN 'D' 
THEN 'X' 
ELSE ''
END AS VD,
CASE Vestirse WHEN 'I' 
THEN 'X' 
ELSE ''
END AS VI,
CASE UsoServHigienico WHEN 'D' 
THEN 'X' 
ELSE ''
END AS SHD,
CASE UsoServHigienico WHEN 'I' 
THEN 'X' 
ELSE ''
END AS SHI,

CASE Movilizarse WHEN 'D' 
THEN 'X' 
ELSE ''
END AS MD,
CASE Movilizarse WHEN 'I' 
THEN 'X' 
ELSE ''
END AS MI,

CASE Continencia WHEN 'D' 
THEN 'X' 
ELSE ''
END AS CD,
CASE Continencia WHEN 'I' 
THEN 'X' 
ELSE ''
END AS CI,


CASE Alimentarse WHEN 'D' 
THEN 'X' 
ELSE ''
END AS AD,
CASE Alimentarse WHEN 'I' 
THEN 'X' 
ELSE ''
END AS AI,
DiagnosticoFuncional,
estado,
UsuarioCreacion,
UsuarioModificacion,
FechaModificacion,
Accion,
version
FROM [SS_HC_ValoracionFuncionalAM_FE]

GO
/****** Object:  View [dbo].[rptViewAgrupador]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE OR ALTER VIEW [dbo].[rptViewAgrupador]
AS
SELECT    SS_HC_EpisodioAtencion.UnidadReplicacion, SS_HC_EpisodioAtencion.IdPaciente, SS_HC_EpisodioAtencion.EpisodioClinico, 
                      SS_HC_EpisodioAtencion.EpisodioAtencion,(CASE WHEN SS_HC_EpisodioAtencion.TipoAtencion=1 THEN
					   SS_HC_EpisodioAtencion.EpisodioAtencion ELSE SS_HC_EpisodioAtencion.IdEpisodioAtencion END)AS IdEpisodioAtencion ,-- SS_HC_EpisodioAtencion.IdEpisodioAtencion,                                             
                      SS_HC_EpisodioAtencion.UnidadReplicacionEC, 
                      SS_HC_EpisodioAtencion.TipoEpisodio, SS_HC_EpisodioAtencion.IdEpisodioAtencionCodigo,                       
                     /***************************************/
                      /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      PERSONAMAST.ApellidoPaterno, PERSONAMAST.ApellidoMaterno, PERSONAMAST.Nombres, PERSONAMAST.NombreCompleto, 
                      PERSONAMAST.Busqueda, PERSONAMAST.TipoDocumento, PERSONAMAST.Documento, PERSONAMAST.FechaNacimiento, 
                      PERSONAMAST.Sexo, PERSONAMAST.EstadoCivil, 
					   (SELECT DATEDIFF([year], PERSONAMAST.FechaNacimiento, GETDATE()) - 
	CASE 
	WHEN (MONTH(GETDATE()) * 100) + DAY(GETDATE()) < (MONTH(PERSONAMAST.FechaNacimiento) * 100) + DAY(PERSONAMAST.FechaNacimiento) THEN 1
	ELSE 0
	END) as edad
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
                      ,SS_HC_EpisodioAtencion.ObservacionProxima as CodigoHC --AUX
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
                      , RTRIM(PERSONA_PERSSALUD.NombreCompleto) +
						(case when  ( EMPLEADO_PERSSALUD.CMP IS null OR EMPLEADO_PERSSALUD.CMP='')
							then ''
							else ' /CMP: '+RTRIM(EMPLEADO_PERSSALUD.CMP)  end)
						+                      
						' /'
						+SS_GE_Especialidad.Nombre
						+
						(case when  ESPECIALIDAD_MED.NumeroRegistroEspecialidad IS null 
							then ''
							else '- RNE: '+ESPECIALIDAD_MED.NumeroRegistroEspecialidad end)						                 
                      as
					   ServicioExtra  --AUX
		FROM		SS_HC_EpisodioAtencion 		WITH(NOLOCK)			
        INNER JOIN   PERSONAMAST								WITH(NOLOCK) ON SS_HC_EpisodioAtencion.IdPaciente = PERSONAMAST.Persona
		LEFT JOIN    SS_GE_TipoAtencion							WITH(NOLOCK) ON SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
		LEFT JOIN    SS_TipoTrabajador							WITH(NOLOCK) ON SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
		LEFT JOIN    CM_CO_Establecimiento						WITH(NOLOCK) ON CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
		LEFT JOIN    SS_HC_UnidadServicio                       WITH(NOLOCK) ON SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                      
        LEFT JOIN    PERSONAMAST  as PERSONA_PERSSALUD          WITH(NOLOCK) ON PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
        LEFT JOIN    SS_GE_Especialidad                         WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad                      									 	                      
                      --ADD CMP  y RNE
        LEFT JOIN    EMPLEADOMAST  as EMPLEADO_PERSSALUD        WITH(NOLOCK) ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud
        LEFT JOIN    SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED     WITH(NOLOCK) ON   ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud AND ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad   

GO

CREATE OR ALTER VIEW [dbo].[rptViewAgrupadorTriaje]
AS
SELECT    dbo.SS_HC_EpisodioTriaje.UnidadReplicacion, dbo.SS_HC_EpisodioTriaje.IdPaciente,  
        dbo.SS_HC_EpisodioTriaje.IdEpisodioTriaje,                      
        /***************************************/
        /**********ADD GENERALES****************/                      
        --(PERSONAS)
        dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.Nombres, dbo.PERSONAMAST.NombreCompleto, 
        dbo.PERSONAMAST.Busqueda, dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.FechaNacimiento, 
        dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.EstadoCivil, 
		(SELECT DATEDIFF([year], dbo.PERSONAMAST.FechaNacimiento, GETDATE()) - 
		CASE 
		WHEN (MONTH(GETDATE()) * 100) + DAY(GETDATE()) < (MONTH(dbo.PERSONAMAST.FechaNacimiento) * 100) + DAY(dbo.PERSONAMAST.FechaNacimiento) THEN 1
		ELSE 0
		END) as edad
        --EPI ATENCIÓN
        ,SS_HC_EpisodioTriaje.CodigoOT as CodigoOA
        ,SS_HC_EpisodioTriaje.IdPersonalSalud
        ,SS_HC_EpisodioTriaje.FechaAtencion
        ,SS_HC_EpisodioTriaje.IdEspecialidad
        ,SS_HC_EpisodioTriaje.Estado as estadoEpiAtencion                      
        ,PERSONA_PERSSALUD.NombreCompleto as PersMedicoNombreCompleto
        ,PERSONA_PERSSALUD.Documento as PersMedicoNombreDocumento
        ,SS_GE_Especialidad.Codigo as EspecialidadCodigo
        ,SS_GE_Especialidad.Nombre as EspecialidadDesc
        ----ADD AUX
        ,CONCAT('Medico Tratante: ',PERSONA_PERSSALUD.NombreCompleto+
		(case when  EMPLEADO_PERSSALUD.CMP IS null 
			then ''
			else '/CMP: '+EMPLEADO_PERSSALUD.CMP  end)
		+                      
		'/'+SS_GE_Especialidad.Nombre
		+
		(case when  ESPECIALIDAD_MED.NumeroRegistroEspecialidad IS null 
			then ''
			else '- RNE: '+ESPECIALIDAD_MED.NumeroRegistroEspecialidad end))						                 
        as ServicioExtra  --AUX

FROM         dbo.SS_HC_EpisodioTriaje 					
    INNER JOIN	PERSONAMAST ON dbo.SS_HC_EpisodioTriaje.IdPaciente = dbo.PERSONAMAST.Persona	                 
    LEFT JOIN   PERSONAMAST  as PERSONA_PERSSALUD    ON PERSONA_PERSSALUD.Persona = dbo.SS_HC_EpisodioTriaje.IdPersonalSalud  
	LEFT JOIN   SS_GE_Especialidad                   ON SS_GE_Especialidad.IdEspecialidad = dbo.SS_HC_EpisodioTriaje.IdEspecialidad                      									 	                      
                      --ADD CMP  y RNE
    LEFT JOIN	EMPLEADOMAST  as EMPLEADO_PERSSALUD  ON EMPLEADO_PERSSALUD.Empleado = dbo.SS_HC_EpisodioTriaje.IdPersonalSalud
    LEFT JOIN	SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED              ON (ESPECIALIDAD_MED.IdMedico = dbo.SS_HC_EpisodioTriaje.IdPersonalSalud
				And ESPECIALIDAD_MED.IdEspecialidad = dbo.SS_HC_EpisodioTriaje.IdEspecialidad )


GO
/****** Object:  View [dbo].[rptViewAlergias_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewAlergias_FE]
AS

SELECT        B.Secuencia, B.IdTipoAlergia, 
		 (case when B.TipoRegistro  ='RE' 
		then 
			(case when WH_ItemMast.Item IS NOT NULL 
			then 
				ltrim(rtrim(WH_ItemMast.DescripcionLocal)) 
			else
				ltrim(rtrim(WH_ClaseSubFamilia.DescripcionLocal)) 
			end
			)
		else 
			B.DescripcionManual
		end
	  ) as Nombre,
		B.DesdeCuando, B.EstudioAlegista, ISNULL(B.Observaciones,'') AS Observaciones,  
        A.UnidadReplicacion, A.IdPaciente, A.EpisodioClinico,A.IdEpisodioAtencion, G.Descripcion AS TipoAlergiaDesc, 
        (CASE A.TieneHistoria WHEN 'S' THEN 'X' ELSE '' END) AS SI, (CASE A.TieneHistoria WHEN 'N' THEN 'X' ELSE '' END) AS NO, MD.Nombre AS EstudioAlergista, 
        B.TipoRegistro AS Accion
FROM            SS_HC_Alergia_FE AS A WITH(NOLOCK) 
	LEFT JOIN  SS_HC_AlergiaDetalle_FE AS B WITH(NOLOCK) ON A.UnidadReplicacion = B.UnidadReplicacion 	 AND A.IdEpisodioAtencion = B.IdEpisodioAtencion 
				AND  A.IdPaciente = B.IdPaciente AND A.EpisodioClinico = B.EpisodioClinico 
	left join   WH_ItemMast 		WITH(NOLOCK) ON 	WH_ItemMast.Item =  B.CodigoComponente
	left join   WH_ClaseSubFamilia	WITH(NOLOCK) ON 	WH_ClaseSubFamilia.Linea =  B.Linea and WH_ClaseSubFamilia.Familia =  B.Familia 
				AND WH_ClaseSubFamilia.SubFamilia =  B.SubFamilia  
	LEFT OUTER JOIN   GE_Varios AS G WITH(NOLOCK) ON G.CodigoTabla = 'TIPALERGIA' AND B.IdTipoAlergia = G.Secuencial 
	LEFT OUTER JOIN   CM_CO_TablaMaestroDetalle AS MD WITH(NOLOCK) ON MD.IdTablaMaestro = 35 AND B.EstudioAlegista = MD.IdCodigo	


GO

/****** Object:  View [dbo].[rptViewAnamnesis_AFAM_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewAnamnesis_AFAM_FE]

as

SELECT        
       SS_HC_Anamnesis_AFAM_CAB_FE.AntecedenteFami_flag,
       SS_HC_Anamnesis_AFAM_CAB_FE.UnidadReplicacion, 
       SS_HC_Anamnesis_AFAM_CAB_FE.IdEpisodioAtencion, 
       SS_HC_Anamnesis_AFAM_CAB_FE.IdPaciente, 
       SS_HC_Anamnesis_AFAM_CAB_FE.EpisodioClinico, 
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
       SS_HC_Anamnesis_AFAM_FE.flagDiabetes,
       SS_HC_Anamnesis_AFAM_FE.ObsDiabetes,
       ISNULL(SS_HC_Anamnesis_AFAM_FE.SecuenciaFamilia,0) AS Expr1, 
       CONVERT(varchar, SS_HC_Anamnesis_AFAM_FE.SecuenciaFamilia) AS Expr103, 
       ISNULL(SS_HC_Anamnesis_AFAM_FE.SecuenciaFamilia,0) as Secuencia, 
       0 IdDiagnostico, 
       SS_HC_Anamnesis_AFAM_FE.ObsDiabetes AS Observaciones, 

       0 AS IDAntecedentePat, 
       '' AS CodigoAntecedentePat, 
       SS_HC_Anamnesis_AFAM_FE.flagDiabetes AS Descripcion, 
       '' AS Adicional1,
       '' AS Adicional2, 
       0 AS Expr2,
       SS_HC_Anamnesis_AFAM_FE.FechaCreacion AS Expr5, 
       SS_HC_Anamnesis_AFAM_FE.UsuarioModificacion AS Expr6, 
       SS_HC_Anamnesis_AFAM_FE.FechaModificacion AS Expr7, 
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
        (SELECT DATEDIFF([year], dbo.PERSONAMAST.FechaNacimiento, GETDATE()) - 
       CASE 
       WHEN (MONTH(GETDATE()) * 100) + DAY(GETDATE()) < (MONTH(dbo.PERSONAMAST.FechaNacimiento) * 100) + DAY(dbo.PERSONAMAST.FechaNacimiento) THEN 1
       ELSE 0
       END) AS PersonaEdad,              
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
       --TIPOPAREN.Descripcion AS Expr101, 
	   '' AS Expr101, 
	   '' AS Expr3
       --TAB_ESTAVIVODET.Nombre AS Expr3
       FROM         SS_HC_Anamnesis_AFAM_CAB_FE       
                    LEFT JOIN   SS_HC_Anamnesis_AFAM_FE 
                            ON SS_HC_Anamnesis_AFAM_CAB_FE.UnidadReplicacion = SS_HC_Anamnesis_AFAM_FE.UnidadReplicacion AND 
                            SS_HC_Anamnesis_AFAM_CAB_FE.IdPaciente = SS_HC_Anamnesis_AFAM_FE.IdPaciente AND 
                            SS_HC_Anamnesis_AFAM_CAB_FE.EpisodioClinico = SS_HC_Anamnesis_AFAM_FE.EpisodioClinico  AND							 
         /****** Object:  Jordan Mateo   Script Date: 01/02/2018 08:10:07 p.m. ******/        SS_HC_Anamnesis_AFAM_CAB_FE.IdEpisodioAtencion = SS_HC_Anamnesis_AFAM_FE.IdEpisodioAtencion
                    INNER JOIN PERSONAMAST 
                            ON SS_HC_Anamnesis_AFAM_CAB_FE.IdPaciente = PERSONAMAST.Persona 
                                  
                    INNER JOIN SS_HC_EpisodioAtencion 
                            ON SS_HC_Anamnesis_AFAM_CAB_FE.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion AND 
                            SS_HC_Anamnesis_AFAM_CAB_FE.IdEpisodioAtencion = SS_HC_EpisodioAtencion.EpisodioAtencion AND 
                            SS_HC_Anamnesis_AFAM_CAB_FE.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND 
                            SS_HC_Anamnesis_AFAM_CAB_FE.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 

                    LEFT OUTER JOIN     SS_GE_TipoAtencion 
                            ON SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion 
                    LEFT OUTER JOIN SS_TipoTrabajador 
                            ON SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador 
                    LEFT OUTER JOIN     CM_CO_Establecimiento 
                            ON CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud 
                    LEFT OUTER JOIN SS_HC_UnidadServicio 
                            ON SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio 
            /****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/           AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
                    LEFT OUTER JOIN PERSONAMAST AS PERSONA_PERSSALUD 
                            ON PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud 
                    LEFT OUTER JOIN SS_GE_Especialidad             ON SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad 
                    --LEFT OUTER JOIN GE_Varios AS TIPOPAREN ON TIPOPAREN.CodigoTabla = 'TIPOPARENTESCO' 
                    --       AND SS_HC_Anamnesis_AFAM_FE.IdTipoParentesco = TIPOPAREN.Secuencial 
                    --LEFT OUTER JOIN CM_CO_TablaMaestro AS TAB_ESTAVIVO          ON TAB_ESTAVIVO.CodigoTabla = 'TABCOLABORACION' 
                    --LEFT OUTER JOIN CM_CO_TablaMaestroDetalle AS TAB_ESTAVIVODET ON TAB_ESTAVIVODET.IdTablaMaestro = TAB_ESTAVIVO.IdTablaMaestro 
                            --AND TAB_ESTAVIVODET.IdCodigo = SS_HC_Anamnesis_AFAM_FE.IdVivo 
                    LEFT OUTER JOIN EMPLEADOMAST AS EMPLEADO_PERSSALUD 
                            ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud 
                    LEFT OUTER JOIN     SS_GE_EspecialidadMedico AS ESPECIALIDAD_MED 
                            ON ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud AND 
                            ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad


GO
/****** Object:  View [dbo].[rptViewAnamnesisAF]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewAnamnesisAF]
AS
SELECT     dbo.SS_HC_Anamnesis_AFAM.UnidadReplicacion, dbo.SS_HC_Anamnesis_AFAM.IdEpisodioAtencion, dbo.SS_HC_Anamnesis_AFAM.IdPaciente, 
                      dbo.SS_HC_Anamnesis_AFAM.EpisodioClinico, dbo.SS_HC_Anamnesis_AFAM.IdTipoParentesco, dbo.SS_HC_Anamnesis_AFAM.Edad, dbo.SS_HC_Anamnesis_AFAM.IdVivo, 
                      dbo.SS_HC_Anamnesis_AFAM.Estado, dbo.SS_HC_Anamnesis_AFAM.UsuarioCreacion, dbo.SS_HC_Anamnesis_AFAM.FechaCreacion, 
                      dbo.SS_HC_Anamnesis_AFAM.UsuarioModificacion, dbo.SS_HC_Anamnesis_AFAM.FechaModificacion, dbo.SS_HC_Anamnesis_AFAM.Accion, 
                      dbo.SS_HC_Anamnesis_AFAM.Version, 
                      dbo.SS_HC_Anamnesis_AFAM.SecuenciaFamilia AS Expr1, 
                      dbo.SS_HC_Anamnesis_AFAM_Enfermedad.Secuencia, 
                      dbo.SS_HC_Anamnesis_AFAM_Enfermedad.IdDiagnostico, dbo.SS_HC_Anamnesis_AFAM_Enfermedad.Observaciones, dbo.SS_GE_Diagnostico.CodigoDiagnostico, 
                      dbo.SS_GE_Diagnostico.CodigoPadre, dbo.SS_GE_Diagnostico.Nombre, dbo.SS_GE_Diagnostico.Descripcion, dbo.SS_GE_Diagnostico.Estado AS Expr2, 
                      TAB_ESTAVIVODET.Nombre AS Expr3, dbo.SS_GE_Diagnostico.FechaCreacion AS Expr4, dbo.SS_GE_Diagnostico.UsuarioModificacion AS Expr5, 
                      dbo.SS_GE_Diagnostico.FechaModificacion AS Expr6, dbo.SS_GE_Diagnostico.IdDiagnosticoPadre, dbo.SS_GE_Diagnostico.Orden, 
                      dbo.SS_GE_Diagnostico.CadenaRecursividad, dbo.SS_GE_Diagnostico.Nivel, dbo.SS_GE_Diagnostico.DiagnosticoSiteds, 
                      dbo.SS_GE_Diagnostico.IndicadorPermitido, dbo.SS_GE_Diagnostico.tipoFolder, dbo.SS_GE_Diagnostico.NombreTabla, 
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
                      ,TIPOPAREN.Descripcion as Expr101  --AUX
                      ,SS_HC_EpisodioAtencion.ObservacionProxima as Expr102 --AUX
                      ,'GRUPO_'+convert(varchar,dbo.SS_HC_Anamnesis_AFAM.SecuenciaFamilia) as Expr103 --AUX                      
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
                                            
FROM         dbo.SS_HC_Anamnesis_AFAM INNER JOIN
                      dbo.SS_HC_Anamnesis_AFAM_Enfermedad
                      ON 
                      dbo.SS_HC_Anamnesis_AFAM.UnidadReplicacion = dbo.SS_HC_Anamnesis_AFAM_Enfermedad.UnidadReplicacion 
                      and dbo.SS_HC_Anamnesis_AFAM.IdPaciente = dbo.SS_HC_Anamnesis_AFAM_Enfermedad.IdPaciente 
                      and dbo.SS_HC_Anamnesis_AFAM.EpisodioClinico = dbo.SS_HC_Anamnesis_AFAM_Enfermedad.EpisodioClinico 
                      and dbo.SS_HC_Anamnesis_AFAM.IdEpisodioAtencion = dbo.SS_HC_Anamnesis_AFAM_Enfermedad.IdEpisodioAtencion 
                      and dbo.SS_HC_Anamnesis_AFAM.SecuenciaFamilia = dbo.SS_HC_Anamnesis_AFAM_Enfermedad.SecuenciaFamilia 
                      INNER JOIN
                      dbo.SS_GE_Diagnostico 
                      ON dbo.SS_HC_Anamnesis_AFAM_Enfermedad.IdDiagnostico = dbo.SS_GE_Diagnostico.IdDiagnostico 
                      INNER JOIN
                      dbo.PERSONAMAST ON dbo.SS_HC_Anamnesis_AFAM.IdPaciente = dbo.PERSONAMAST.Persona
						INNER JOIN
                      dbo.SS_HC_EpisodioAtencion 
                      ON dbo.SS_HC_Anamnesis_AFAM.UnidadReplicacion = dbo.SS_HC_EpisodioAtencion.UnidadReplicacion
                      AND dbo.SS_HC_Anamnesis_AFAM.IdEpisodioAtencion = dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion 
                      AND dbo.SS_HC_Anamnesis_AFAM.IdPaciente = dbo.SS_HC_EpisodioAtencion.IdPaciente 
                      AND dbo.SS_HC_Anamnesis_AFAM.EpisodioClinico = dbo.SS_HC_EpisodioAtencion.EpisodioClinico                                             
					LEFT JOIN
                      dbo.SS_GE_TipoAtencion
                      ON dbo.SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
					LEFT JOIN
                      dbo.SS_TipoTrabajador
                      ON dbo.SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
					LEFT JOIN
                      dbo.CM_CO_Establecimiento
                      ON dbo.CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
					LEFT JOIN
                      dbo.SS_HC_UnidadServicio
                      ON dbo.SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                      
                    LEFT JOIN
                      dbo.PERSONAMAST  as PERSONA_PERSSALUD
                      ON PERSONA_PERSSALUD.Persona = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
                    LEFT JOIN
                      dbo.SS_GE_Especialidad  
                      ON SS_GE_Especialidad.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad     
					 left join 
					 GE_Varios  as TIPOPAREN on 
					 (TIPOPAREN.CodigoTabla = 'TIPOPARENTESCO'
						and SS_HC_Anamnesis_AFAM.IdTipoParentesco = TIPOPAREN.Secuencial
					 )
					 left join 
					 CM_CO_TablaMaestro  as TAB_ESTAVIVO
					 on 
					 (
						TAB_ESTAVIVO.CodigoTabla = 'TABCOLABORACION'						 
					 )
					 left join  CM_CO_TablaMaestroDetalle TAB_ESTAVIVODET
					 on(
						TAB_ESTAVIVODET.IdTablaMaestro = TAB_ESTAVIVO.IdTablaMaestro
						and TAB_ESTAVIVODET.IdCodigo = SS_HC_Anamnesis_AFAM.IdVivo
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
/****** Object:  View [dbo].[rptViewAnamnesisAP]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[rptViewAnamnesisAP]
AS
SELECT     dbo.SS_HC_Anamnesis_AP.UnidadReplicacion, dbo.SS_HC_Anamnesis_AP.IdEpisodioAtencion, dbo.SS_HC_Anamnesis_AP.IdPaciente, 
                      dbo.SS_HC_Anamnesis_AP.EpisodioClinico, dbo.SS_HC_Anamnesis_AP.IdTipoEmbarazo, dbo.SS_HC_Anamnesis_AP.PatologiaGestacion, 
                      dbo.SS_HC_Anamnesis_AP.IdControlPrenatal, dbo.SS_HC_Anamnesis_AP.CPnumeroControles, dbo.SS_HC_Anamnesis_AP.CPnumeroEmbarazos, 
                      dbo.SS_HC_Anamnesis_AP.LugarControl, dbo.SS_HC_Anamnesis_AP.IdTipoParto, dbo.SS_HC_Anamnesis_AP.ComplicacionesParto, 
                      dbo.SS_HC_Anamnesis_AP.IdLugarParto, dbo.SS_HC_Anamnesis_AP.IdPartoAtendidoPor, dbo.SS_HC_Anamnesis_AP.AntecentesPatologicos, 
                      dbo.SS_HC_Anamnesis_AP.SemanasGestacionNacer, dbo.SS_HC_Anamnesis_AP.PesoAlNacerGR, dbo.SS_HC_Anamnesis_AP.TallaAlNacerCM, 
                      dbo.SS_HC_Anamnesis_AP.PerimetroCefalicoCM, dbo.SS_HC_Anamnesis_AP.PatologiasPernatales, dbo.SS_HC_Anamnesis_AP.DiasHospitalizacion, 
                      dbo.SS_HC_Anamnesis_AP.IdTipoLecheHasta6meses, dbo.SS_HC_Anamnesis_AP.AntecLactancia, dbo.SS_HC_Anamnesis_AP.EdadInicioAblactanciaMeses, 
                      dbo.SS_HC_Anamnesis_AP.DesarrolloSicomotriz, dbo.SS_HC_Anamnesis_AP.FechaUltimaRegla, dbo.SS_HC_Anamnesis_AP.FechaUltimoPeriodo, 
                      dbo.SS_HC_Anamnesis_AP.MetodosAnticonceptivos, dbo.SS_HC_Anamnesis_AP.Menarquia, dbo.SS_HC_Anamnesis_AP.Menopausia, 
                      dbo.SS_HC_Anamnesis_AP.CaracteristicasMenstruaciones, dbo.SS_HC_Anamnesis_AP.InformacionEmbarazos, dbo.SS_HC_Anamnesis_AP.Transfusiones, 
                      dbo.SS_HC_Anamnesis_AP.DeinmunizFechaAproximada, dbo.SS_HC_Anamnesis_AP.DeinmunizEdadAproximada, dbo.SS_HC_Anamnesis_AP.Alcohol, 
                      dbo.SS_HC_Anamnesis_AP.Tabaco, dbo.SS_HC_Anamnesis_AP.Drogas, dbo.SS_HC_Anamnesis_AP.ActividadFisica, dbo.SS_HC_Anamnesis_AP.ConsumoVerduras, 
                      dbo.SS_HC_Anamnesis_AP.ConsumoFrutas, dbo.SS_HC_Anamnesis_AP.Medicamentos, dbo.SS_HC_Anamnesis_AP.Alimentos, 
                      dbo.SS_HC_Anamnesis_AP.SustanciasEnElAmbiente, dbo.SS_HC_Anamnesis_AP.SustanciasContactoConPiel, dbo.SS_HC_Anamnesis_AP.ContactoPersonaEnferma, 
                      dbo.SS_HC_Anamnesis_AP.CrianzaAnimalesDomesticos, dbo.SS_HC_Anamnesis_AP.AguaPotable, dbo.SS_HC_Anamnesis_AP.DisposicionExcretas, 
                      dbo.SS_HC_Anamnesis_AP.ReaccionAdversaMedicamentos, dbo.SS_HC_Anamnesis_AP.SaludBucal, dbo.SS_HC_Anamnesis_AP.VigilanciaDeCrecimiento, 
                      dbo.SS_HC_Anamnesis_AP.VigilanciaDelDesarrollo, dbo.SS_HC_Anamnesis_AP.IdValoracionFuncional1, dbo.SS_HC_Anamnesis_AP.IdValoracionFuncional2, 
                      dbo.SS_HC_Anamnesis_AP.IdValoracionFuncional3, dbo.SS_HC_Anamnesis_AP.IdValoracionFuncional4, dbo.SS_HC_Anamnesis_AP.IdValoracionFuncional5, 
                      dbo.SS_HC_Anamnesis_AP.IdValoracionFuncional6, dbo.SS_HC_Anamnesis_AP.DiagnosticoFuncional, dbo.SS_HC_Anamnesis_AP.IdEstadoCognitivo1, 
                      dbo.SS_HC_Anamnesis_AP.IdEstadoCognitivo2, dbo.SS_HC_Anamnesis_AP.IdEstadoCognitivo3, dbo.SS_HC_Anamnesis_AP.IdEstadoCognitivo4, 
                      dbo.SS_HC_Anamnesis_AP.IdEstadoCognitivo5, dbo.SS_HC_Anamnesis_AP.IdEstadoCognitivo6, dbo.SS_HC_Anamnesis_AP.IdEstadoCognitivo7, 
                      dbo.SS_HC_Anamnesis_AP.IdEstadoCognitivo8, dbo.SS_HC_Anamnesis_AP.IdEstadoCognitivo9, dbo.SS_HC_Anamnesis_AP.IdEstadoCognitivo10, 
                      dbo.SS_HC_Anamnesis_AP.ValoracionCognitiva, dbo.SS_HC_Anamnesis_AP.IdEstadoAfectivo1, dbo.SS_HC_Anamnesis_AP.IdEstadoAfectivo2, 
                      dbo.SS_HC_Anamnesis_AP.IdEstadoAfectivo3, dbo.SS_HC_Anamnesis_AP.IdEstadoAfectivo4, dbo.SS_HC_Anamnesis_AP.ConManifestacionesDepresivas, 
                      dbo.SS_HC_Anamnesis_AP.ValoracionSocioFamiliar1, dbo.SS_HC_Anamnesis_AP.ValoracionSocioFamiliar2, dbo.SS_HC_Anamnesis_AP.ValoracionSocioFamiliar3, 
                      dbo.SS_HC_Anamnesis_AP.ValoracionSocioFamiliar4, dbo.SS_HC_Anamnesis_AP.ValoracionSocioFamiliar5, dbo.SS_HC_Anamnesis_AP.ValoracionSocioFamiliar, 
                      dbo.SS_HC_Anamnesis_AP.IdCategoriaAdutoMayor, dbo.SS_HC_Anamnesis_AP.Estado, dbo.SS_HC_Anamnesis_AP.UsuarioCreacion, 
                      dbo.SS_HC_Anamnesis_AP.FechaCreacion, dbo.SS_HC_Anamnesis_AP.UsuarioModificacion, dbo.SS_HC_Anamnesis_AP.FechaModificacion, 
                      dbo.SS_HC_Anamnesis_AP.Accion, 
                      
                      dbo.SS_HC_Anamnesis_AP_Detalle.Secuencia, 
                      dbo.SS_HC_Anamnesis_AP_Detalle.Fecha, 
                      dbo.SS_HC_Anamnesis_AP_Detalle.IdTabla, 
                      dbo.SS_HC_Anamnesis_AP_Detalle.IdTipoAlergia, 
                      dbo.SS_HC_Anamnesis_AP_Detalle.Nombre, dbo.SS_HC_Anamnesis_AP_Detalle.Lugar, 
                      dbo.SS_HC_Anamnesis_AP_Detalle.Dosis, 
                      dbo.SS_HC_Anamnesis_AP_Detalle.Observaciones, 
                      dbo.SS_HC_Anamnesis_AP_Detalle.Estado AS Expr5, 
                      dbo.SS_HC_Anamnesis_AP_Detalle.UsuarioCreacion AS Expr6, 
                      dbo.SS_HC_Anamnesis_AP_Detalle.FechaCreacion AS Expr7, 
                      dbo.SS_HC_Anamnesis_AP_Detalle.UsuarioModificacion AS Expr8, 
                      dbo.SS_HC_Anamnesis_AP_Detalle.FechaModificacion AS Expr9,
                      dbo.SS_HC_Anamnesis_AP_Detalle.TipoRegistro, 
                      (case dbo.SS_HC_Anamnesis_AP_Detalle.TipoRegistro
						when 'AE' then 'Antecedentes Epidemiológicos' 
						when 'AG' then 'Antecedentes Generales' 
						when 'AP' then 'Antecedentes Patológicos' 
						when 'AT' then 'Antecedentes de Trabajo' 
						when 'AQ' then 'Antecedentes Quirúrgicos' 					
						else  '--'
						end)as GrupoTipoDiagnosticoDesc,                       
                      'GRUPO_'+dbo.SS_HC_Anamnesis_AP_Detalle.TipoRegistro as GrupoTipoDiagnostico, 
                      dbo.SS_GE_Diagnostico.Nombre as DiagnosticoDesc ,
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
                      ,'A' as Expr101  --AUX
                      ,SS_HC_EpisodioAtencion.ObservacionProxima as Expr102 --AUX
                      ,'GRUPO_' as Expr103 --AUX                      
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
                      
FROM         dbo.SS_HC_Anamnesis_AP LEFT JOIN
                      dbo.SS_HC_Anamnesis_AP_Detalle ON dbo.SS_HC_Anamnesis_AP.UnidadReplicacion = dbo.SS_HC_Anamnesis_AP_Detalle.UnidadReplicacion AND 
                      dbo.SS_HC_Anamnesis_AP.IdEpisodioAtencion = dbo.SS_HC_Anamnesis_AP_Detalle.IdEpisodioAtencion AND 
                      dbo.SS_HC_Anamnesis_AP.IdPaciente = dbo.SS_HC_Anamnesis_AP_Detalle.IdPaciente AND 
                      dbo.SS_HC_Anamnesis_AP.EpisodioClinico = dbo.SS_HC_Anamnesis_AP_Detalle.EpisodioClinico
                      LEFT JOIN
                      dbo.SS_GE_Diagnostico 
                      ON dbo.SS_HC_Anamnesis_AP_Detalle.IdTabla = dbo.SS_GE_Diagnostico.IdDiagnostico 
                      INNER JOIN
                      dbo.PERSONAMAST ON dbo.SS_HC_Anamnesis_AP.IdPaciente = dbo.PERSONAMAST.Persona
						INNER JOIN
                      dbo.SS_HC_EpisodioAtencion 
                      ON dbo.SS_HC_Anamnesis_AP.UnidadReplicacion = dbo.SS_HC_EpisodioAtencion.UnidadReplicacion
                      AND dbo.SS_HC_Anamnesis_AP.IdEpisodioAtencion = dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion 
                      AND dbo.SS_HC_Anamnesis_AP.IdPaciente = dbo.SS_HC_EpisodioAtencion.IdPaciente 
                      AND dbo.SS_HC_Anamnesis_AP.EpisodioClinico = dbo.SS_HC_EpisodioAtencion.EpisodioClinico                                             
					LEFT JOIN
                      dbo.SS_GE_TipoAtencion
                      ON dbo.SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
					LEFT JOIN
                      dbo.SS_TipoTrabajador
                      ON dbo.SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
					LEFT JOIN
                      dbo.CM_CO_Establecimiento
                      ON dbo.CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
					LEFT JOIN
                      dbo.SS_HC_UnidadServicio
                      ON dbo.SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                      
                    LEFT JOIN
                      dbo.PERSONAMAST  as PERSONA_PERSSALUD
                      ON PERSONA_PERSSALUD.Persona = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
                    LEFT JOIN
                      dbo.SS_GE_Especialidad  
                      ON SS_GE_Especialidad.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad     
					 
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
/****** Object:  View [dbo].[rptViewAnamnesisEA]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewAnamnesisEA]
AS
SELECT     dbo.SS_HC_Anamnesis_EA.UnidadReplicacion, dbo.SS_HC_Anamnesis_EA.IdEpisodioAtencion, dbo.SS_HC_Anamnesis_EA.IdPaciente, 
                      dbo.SS_HC_Anamnesis_EA.EpisodioClinico, dbo.SS_HC_Anamnesis_EA.IdFormaInicio, dbo.SS_HC_Anamnesis_EA.IdCursoEnfermedad, 
                      dbo.SS_HC_Anamnesis_EA.TiempoEnfermedad, dbo.SS_HC_Anamnesis_EA.RelatoCronologico, dbo.SS_HC_Anamnesis_EA.Apetito, dbo.SS_HC_Anamnesis_EA.Sed, 
                      dbo.SS_HC_Anamnesis_EA.Orina, dbo.SS_HC_Anamnesis_EA.Deposiciones, dbo.SS_HC_Anamnesis_EA.Sueno, dbo.SS_HC_Anamnesis_EA.PesoAnterior, 
                      dbo.SS_HC_Anamnesis_EA.Infancia, dbo.SS_HC_Anamnesis_EA.EvaluacionAlimentacionActual, dbo.SS_HC_Anamnesis_EA.Estado, 
                      dbo.SS_HC_Anamnesis_EA.UsuarioCreacion, dbo.SS_HC_Anamnesis_EA.FechaCreacion, dbo.SS_HC_Anamnesis_EA.UsuarioModificacion, 
                      dbo.SS_HC_Anamnesis_EA.FechaModificacion, dbo.SS_HC_Anamnesis_EA.Accion, dbo.SS_HC_Anamnesis_EA.Version, dbo.SS_HC_Anamnesis_EA.MotivoConsulta, 
                      dbo.SS_HC_Anamnesis_EA.ComentarioAdicional, dbo.SS_HC_Anamnesis_EA.Prioridad, dbo.SS_HC_Anamnesis_EA_Sintoma.Secuencia, 
                      dbo.SS_HC_Anamnesis_EA_Sintoma.IdCIAP2, dbo.SS_HC_Anamnesis_EA_Sintoma.Accion AS Expr5, dbo.SS_HC_Anamnesis_EA_Sintoma.Version AS Expr6, 
                      dbo.SS_GE_ProcedimientoMedicoDos.CodigoProcedimientoDos, dbo.SS_GE_ProcedimientoMedicoDos.CodigoPadre, dbo.SS_GE_ProcedimientoMedicoDos.Nombre, 
                      dbo.SS_GE_ProcedimientoMedicoDos.Descripcion, dbo.SS_GE_ProcedimientoMedicoDos.Estado AS Expr1, dbo.SS_GE_ProcedimientoMedicoDos.Orden, 
                      dbo.SS_GE_ProcedimientoMedicoDos.CadenaRecursividad, dbo.SS_GE_ProcedimientoMedicoDos.Nivel, dbo.SS_GE_ProcedimientoMedicoDos.DiagnosticoSiteds, 
                      dbo.SS_GE_ProcedimientoMedicoDos.IndicadorPermitido, dbo.SS_GE_ProcedimientoMedicoDos.tipofolder, dbo.SS_GE_ProcedimientoMedicoDos.NombreTabla, 
                      
                      TAB_FORMINICIODET.Nombre AS Expr7, 
                      TAB_CURSOENFDET.Nombre AS Expr8, 
                      TAB_TIPAPETITODET.Nombre AS Exprapetito,
                      TAB_TIPSEDDET.Nombre AS Exprsed,
                      TAB_TIPSUENODET.Nombre AS Exprorina,
                      /***************************************/
                      /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.Nombres, dbo.PERSONAMAST.NombreCompleto, 
                      dbo.PERSONAMAST.Busqueda, dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.FechaNacimiento, 
                      dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.edad
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
                      --,'C:\Jose Arauco\jaav\trabajo\_PROYECTOS\HCE\RecursosVarios\logoSanna.jpg' as ServicioExtra  --AUX
                      ,SS_HC_EpisodioAtencion.ObservacionProxima as codigoHC --AUX
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
                      as ServicioExtra  --AUX
                      
                      
FROM         dbo.SS_HC_Anamnesis_EA left JOIN
                      dbo.SS_HC_Anamnesis_EA_Sintoma 
                      ON dbo.SS_HC_Anamnesis_EA.UnidadReplicacion = dbo.SS_HC_Anamnesis_EA_Sintoma.UnidadReplicacion
                      AND dbo.SS_HC_Anamnesis_EA.IdEpisodioAtencion = dbo.SS_HC_Anamnesis_EA_Sintoma.IdEpisodioAtencion 
                      AND dbo.SS_HC_Anamnesis_EA.IdPaciente = dbo.SS_HC_Anamnesis_EA_Sintoma.IdPaciente 
                      AND dbo.SS_HC_Anamnesis_EA.EpisodioClinico = dbo.SS_HC_Anamnesis_EA_Sintoma.EpisodioClinico 
                      left JOIN
                      dbo.SS_GE_ProcedimientoMedicoDos ON 
                      dbo.SS_HC_Anamnesis_EA_Sintoma.IdCIAP2 = dbo.SS_GE_ProcedimientoMedicoDos.IdProcedimientoDos 
                      INNER JOIN
                      dbo.PERSONAMAST ON dbo.SS_HC_Anamnesis_EA.IdPaciente = dbo.PERSONAMAST.Persona
						INNER JOIN
                      dbo.SS_HC_EpisodioAtencion 
                      ON dbo.SS_HC_Anamnesis_EA.UnidadReplicacion = dbo.SS_HC_EpisodioAtencion.UnidadReplicacion
                      AND dbo.SS_HC_Anamnesis_EA.IdEpisodioAtencion = dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion 
                      AND dbo.SS_HC_Anamnesis_EA.IdPaciente = dbo.SS_HC_EpisodioAtencion.IdPaciente 
                      AND dbo.SS_HC_Anamnesis_EA.EpisodioClinico = dbo.SS_HC_EpisodioAtencion.EpisodioClinico                                             
					LEFT JOIN
                      dbo.SS_GE_TipoAtencion
                      ON dbo.SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
					LEFT JOIN
                      dbo.SS_TipoTrabajador
                      ON dbo.SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
					LEFT JOIN
                      dbo.CM_CO_Establecimiento
                      ON dbo.CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
					LEFT JOIN
                      dbo.SS_HC_UnidadServicio
                      ON dbo.SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                      
                    LEFT JOIN
                      dbo.PERSONAMAST  as PERSONA_PERSSALUD
                      ON PERSONA_PERSSALUD.Persona = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
                    LEFT JOIN
                      dbo.SS_GE_Especialidad  
                      ON SS_GE_Especialidad.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad                      

                    left join 
					 CM_CO_TablaMaestro  as TAB_FORMINICIO
					 on 
					 (
						TAB_FORMINICIO.CodigoTabla = 'HCC_FORMAINICIO'						 
					 )
					 left join  CM_CO_TablaMaestroDetalle TAB_FORMINICIODET
					 on(
						TAB_FORMINICIODET.IdTablaMaestro = TAB_FORMINICIO.IdTablaMaestro
						and TAB_FORMINICIODET.IdCodigo = SS_HC_Anamnesis_EA.IdFormaInicio
					 )
					 left join 
					 CM_CO_TablaMaestro  as TAB_TIPAPETITO
					 on 
					 (
						TAB_TIPAPETITO.CodigoTabla = 'TIPOAPSEDSUEN'						 
					 )
					 left join 
					 CM_CO_TablaMaestro  as TAB_CURSOENF
					 on 
					 (
						TAB_CURSOENF.CodigoTabla = 'HCC_CURSOENF'						 
					 )
					 
					 left join  CM_CO_TablaMaestroDetalle TAB_CURSOENFDET
					 on(
						TAB_CURSOENFDET.IdTablaMaestro = TAB_CURSOENF.IdTablaMaestro
						and TAB_CURSOENFDET.IdCodigo = SS_HC_Anamnesis_EA.IdCursoEnfermedad
					 )	
					 
					 left join  CM_CO_TablaMaestroDetalle TAB_TIPAPETITODET
					 on(
						TAB_TIPAPETITODET.IdTablaMaestro = TAB_TIPAPETITO.IdTablaMaestro
						and TAB_TIPAPETITODET.IdCodigo = SS_HC_Anamnesis_EA.Apetito
					 )
					 left join 
					 CM_CO_TablaMaestro  as TAB_TIPSED
					 on 
					 (
						TAB_TIPSED.CodigoTabla = 'TIPOAPSEDSUEN'						 
					 )
					  left join  CM_CO_TablaMaestroDetalle TAB_TIPSEDDET
					 on(
						TAB_TIPSEDDET.IdTablaMaestro = TAB_TIPSED.IdTablaMaestro
						and TAB_TIPSEDDET.IdCodigo = SS_HC_Anamnesis_EA.Sed
					 )
					 left join 
					 CM_CO_TablaMaestro  as TAB_TIPSUENO
					 on 
					 (
						TAB_TIPSUENO.CodigoTabla = 'TIPOAPSEDSUEN'						 
					 )
					 left join  CM_CO_TablaMaestroDetalle TAB_TIPSUENODET
					 on(
						TAB_TIPSUENODET.IdTablaMaestro = TAB_TIPSUENO.IdTablaMaestro
						and TAB_TIPSUENODET.IdCodigo = SS_HC_Anamnesis_EA.Orina
					 )
                     LEFT JOIN
                      dbo.EMPLEADOMAST  as EMPLEADO_PERSSALUD
                      ON EMPLEADO_PERSSALUD.Empleado = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
                       LEFT JOIN
                      dbo.SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED
                      ON (ESPECIALIDAD_MED.IdMedico = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
						And ESPECIALIDAD_MED.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad
						)


GO

/****** Object:  View [dbo].[rptViewAnestesia4_Farmacos_Detalle_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewAnestesia4_Farmacos_Detalle_FE]

AS
SELECT 
      U2.DescripcionLocal,
      SS_HC_Anestesia_Farmacos_Detalle_FE.UnidadReplicacion,
      SS_HC_Anestesia_Farmacos_Detalle_FE.IdEpisodioAtencion,
      SS_HC_Anestesia_Farmacos_Detalle_FE.IdPaciente,
      SS_HC_Anestesia_Farmacos_Detalle_FE.EpisodioClinico,
      SS_HC_Anestesia_Farmacos_Detalle_FE.Secuencia,
      SS_HC_Anestesia_Farmacos_Detalle_FE.Tipo,
      SS_HC_Anestesia_Farmacos_Detalle_FE.TipoVia,
      SS_HC_Anestesia_Farmacos_Detalle_FE.FarmacoDescripcion,
      SS_HC_Anestesia_Farmacos_Detalle_FE.Dosis,
      SS_HC_Anestesia_Farmacos_Detalle_FE.Horario,
      SS_HC_Anestesia_Farmacos_Detalle_FE.UsuarioCreacion,
      SS_HC_Anestesia_Farmacos_Detalle_FE.FechaCreacion,
      SS_HC_Anestesia_Farmacos_Detalle_FE.UsuarioModificacion,
      SS_HC_Anestesia_Farmacos_Detalle_FE.FechaModificacion,
      SS_HC_Anestesia_Farmacos_Detalle_FE.Accion,
      SS_HC_Anestesia_Farmacos_Detalle_FE.Version,      
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
		SS_HC_EpisodioAtencion.ObservacionProxima AS ObservacionProximaEpiAtencion,
		SS_GE_TipoAtencion.Descripcion AS TipoAtencionDesc,
		SS_TipoTrabajador.DescripcionLocal AS TipoTrabajadorDesc,
		CM_CO_Establecimiento.Codigo AS EstablecimientoCodigo, 
		CM_CO_Establecimiento.Nombre AS EstablecimientoDesc,	 
		u1.Codigo AS UnidadServicioCodigo, 
		u1.Descripcion AS UnidadServicioDesc       
      FROM SS_HC_Anestesia_Farmacos_Detalle_FE
      	LEFT JOIN PERSONAMAST 
			ON SS_HC_Anestesia_Farmacos_Detalle_FE.IdPaciente = PERSONAMAST.Persona 
		INNER JOIN SS_HC_EpisodioAtencion 
			ON SS_HC_Anestesia_Farmacos_Detalle_FE.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion AND 
				SS_HC_Anestesia_Farmacos_Detalle_FE.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND 
				SS_HC_Anestesia_Farmacos_Detalle_FE.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND 
				SS_HC_Anestesia_Farmacos_Detalle_FE.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
		LEFT outer JOIN	SS_GE_TipoAtencion 
			on SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion 
		LEFT outer JOIN SS_TipoTrabajador 
			on SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador 
		LEFT outer JOIN	CM_CO_Establecimiento 
			on CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud 
		LEFT outer JOIN SS_HC_UnidadServicio u1
            on u1.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
               and CM_CO_Establecimiento.IdEstablecimiento=u1.IdEstablecimientoSalud
        LEFT outer JOIN MA_MiscelaneosDetalle u2 on u2.CodigoElemento=SS_HC_Anestesia_Farmacos_Detalle_FE.TipoVia
            and u2.CodigoTabla='TIPOSOLUCI'and u2.AplicacionCodigo='WA' AND U2.Compania='999999'	

GO
/****** Object:  View [dbo].[rptViewAnestesia4_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[rptViewAnestesia4_FE]
AS
SELECT	
		SS_HC_Anestesia_Farmaco_FE.UnidadReplicacion,
      SS_HC_Anestesia_Farmaco_FE.IdEpisodioAtencion,
      SS_HC_Anestesia_Farmaco_FE.IdPaciente,
      SS_HC_Anestesia_Farmaco_FE.EpisodioClinico,
      SS_HC_Anestesia_Farmaco_FE.Ingresos1,
      SS_HC_Anestesia_Farmaco_FE.Ingresos2,
      SS_HC_Anestesia_Farmaco_FE.Ingresos3,
      SS_HC_Anestesia_Farmaco_FE.Ingresos4,
      SS_HC_Anestesia_Farmaco_FE.Ingresos5,
      SS_HC_Anestesia_Farmaco_FE.Ingresos6,
      SS_HC_Anestesia_Farmaco_FE.Ingresos7,
      SS_HC_Anestesia_Farmaco_FE.Ingresos8,
      SS_HC_Anestesia_Farmaco_FE.IngresosCantidad1,
      SS_HC_Anestesia_Farmaco_FE.IngresosCantidad2,
      SS_HC_Anestesia_Farmaco_FE.IngresosCantidad3,
      SS_HC_Anestesia_Farmaco_FE.IngresosCantidad4,
      SS_HC_Anestesia_Farmaco_FE.IngresosCantidad5,
      SS_HC_Anestesia_Farmaco_FE.IngresosCantidad6,
      SS_HC_Anestesia_Farmaco_FE.IngresosCantidad7,
      SS_HC_Anestesia_Farmaco_FE.IngresosCantidad8,
      SS_HC_Anestesia_Farmaco_FE.IngresosHorario1,
      SS_HC_Anestesia_Farmaco_FE.IngresosHorario2,
      SS_HC_Anestesia_Farmaco_FE.IngresosHorario3,
      SS_HC_Anestesia_Farmaco_FE.IngresosHorario4,
      SS_HC_Anestesia_Farmaco_FE.IngresosHorario5,
      SS_HC_Anestesia_Farmaco_FE.IngresosHorario6,
      SS_HC_Anestesia_Farmaco_FE.IngresosHorario7,
      SS_HC_Anestesia_Farmaco_FE.IngresosHorario8,
      SS_HC_Anestesia_Farmaco_FE.TotalIngresos,
      SS_HC_Anestesia_Farmaco_FE.Perdidas1,
      SS_HC_Anestesia_Farmaco_FE.Perdidas2,
      SS_HC_Anestesia_Farmaco_FE.Perdidas3,
      SS_HC_Anestesia_Farmaco_FE.Perdidas4,
      SS_HC_Anestesia_Farmaco_FE.Perdidas5,
      SS_HC_Anestesia_Farmaco_FE.Perdidas6,
      SS_HC_Anestesia_Farmaco_FE.PerdidasCantidad1,
      SS_HC_Anestesia_Farmaco_FE.PerdidasCantidad2,
      SS_HC_Anestesia_Farmaco_FE.PerdidasCantidad3,
      SS_HC_Anestesia_Farmaco_FE.PerdidasCantidad4,
      SS_HC_Anestesia_Farmaco_FE.PerdidasCantidad5,
      SS_HC_Anestesia_Farmaco_FE.PerdidasCantidad6,
      SS_HC_Anestesia_Farmaco_FE.PerdidasHorario1,
      SS_HC_Anestesia_Farmaco_FE.PerdidasHorario2,
      SS_HC_Anestesia_Farmaco_FE.PerdidasHorario3,
      SS_HC_Anestesia_Farmaco_FE.PerdidasHorario4,
      SS_HC_Anestesia_Farmaco_FE.PerdidasHorario5,
      SS_HC_Anestesia_Farmaco_FE.PerdidasHorario6,
      SS_HC_Anestesia_Farmaco_FE.TotalPerdidas,
      SS_HC_Anestesia_Farmaco_FE.BalanceHidrico,
      SS_HC_Anestesia_Farmaco_FE.UsuarioCreacion,
      SS_HC_Anestesia_Farmaco_FE.FechaCreacion,
      SS_HC_Anestesia_Farmaco_FE.UsuarioModificacion,
      SS_HC_Anestesia_Farmaco_FE.FechaModificacion,
      SS_HC_Anestesia_Farmaco_FE.Accion,
      SS_HC_Anestesia_Farmaco_FE.Version,
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
		SS_HC_EpisodioAtencion.ObservacionProxima AS ObservacionProximaEpiAtencion,
		SS_GE_TipoAtencion.Descripcion AS TipoAtencionDesc,
		SS_TipoTrabajador.DescripcionLocal AS TipoTrabajadorDesc,
		CM_CO_Establecimiento.Codigo AS EstablecimientoCodigo, 
		CM_CO_Establecimiento.Nombre AS EstablecimientoDesc,	 
		u1.Codigo AS UnidadServicioCodigo, 
		u1.Descripcion AS UnidadServicioDesc	
FROM dbo.SS_HC_Anestesia_Farmaco_FE  WITH(NOLOCK) 
		LEFT JOIN PERSONAMAST  WITH(NOLOCK) 
			ON SS_HC_Anestesia_Farmaco_FE.IdPaciente = PERSONAMAST.Persona 
		INNER JOIN SS_HC_EpisodioAtencion  WITH(NOLOCK) 
			ON SS_HC_Anestesia_Farmaco_FE.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion AND 
				SS_HC_Anestesia_Farmaco_FE.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND 
				SS_HC_Anestesia_Farmaco_FE.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND 
				SS_HC_Anestesia_Farmaco_FE.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
		LEFT outer JOIN	SS_GE_TipoAtencion  WITH(NOLOCK) 
			on SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion 
		LEFT outer JOIN SS_TipoTrabajador  WITH(NOLOCK) 
			on SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador 
		LEFT outer JOIN	CM_CO_Establecimiento  WITH(NOLOCK) 
			on CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud 
		LEFT outer JOIN SS_HC_UnidadServicio u1 WITH(NOLOCK) 
            on u1.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
               and CM_CO_Establecimiento.IdEstablecimiento=u1.IdEstablecimientoSalud

GO
/****** Object:  View [dbo].[rptViewAntecedentesPersGinecObstetrico_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[rptViewAntecedentesPersGinecObstetrico_FE]
AS
	SELECT EAD.*,
	 stuff  ((SELECT ', ' + B.CirugiaGO
            FROM SS_HC_GINECOOBSTETRICOS_Diagnostico_FE A INNER JOIN SS_HC_AntePerGinecoObstetricosCatalogoCirugia_FE B
            ON    A.UnidadReplicacion = B.UnidadReplicacion AND	  A.IdEpisodioAtencion = B.IdEpisodioAtencion AND
				  A.IdPaciente = B.IdPaciente AND	  A.EpisodioClinico = B.EpisodioClinico
		WHERE EA.IdPaciente = B.IdPaciente AND EA.EpisodioClinico = B.EpisodioClinico AND EA.IdEpisodioAtencion = B.IdEpisodioAtencion
	  FOR XML PATH(''), TYPE ).value('.', 'varchar(max)'), 1, 1, '') AS CirugiaGO
	   , '['+ rtrim(D.CodigoDiagnostico)+'] '+ D.Descripcion  Diax,
	   Secuencia,
		Anio,
		EA.Sexo DxSexo,
		IdNacidoVivo,
		PesoNacer,
		IdTipoParto,
		IdLugarParto,
		IdAtendidoPor,
		IdComplicacionesParto,
		EA.IdDiagnostico,   
   /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      
            PERSONAMAST.ApellidoPaterno, PERSONAMAST.ApellidoMaterno, PERSONAMAST.Nombres, PERSONAMAST.NombreCompleto, 
            PERSONAMAST.Busqueda, PERSONAMAST.TipoDocumento, PERSONAMAST.Documento, PERSONAMAST.FechaNacimiento, 
            PERSONAMAST.Sexo as PersonaSexo, PERSONAMAST.EstadoCivil, PERSONAMAST.edad as PersonaEdad
            --EPI ATENCIÓN
            ,SS_HC_EpisodioAtencion.IdOrdenAtencion
            ,SS_HC_EpisodioAtencion.CodigoOA
            ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
            --,SS_HC_EpisodioAtencion.TipoOrdenAtencion
            ,SS_HC_EpisodioAtencion.TipoAtencion
            ,SS_HC_EpisodioAtencion.TipoTrabajador                      
            ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
            ,SS_HC_EpisodioAtencion.IdUnidadServicio
            ,SS_HC_EpisodioAtencion.IdPersonalSalud
            ,SS_HC_EpisodioAtencion.FechaRegistro
            ,SS_HC_EpisodioAtencion.FechaAtencion
            --,SS_HC_EpisodioAtencion.IdEspecialidad
            ,SS_HC_EpisodioAtencion.IdTipoOrden
            ,EMPLEADO_PERSSALUD.CMP as estadoEpiAtencion --CMP
            ,SS_HC_EpisodioAtencion.Accion as Expr101  --AUX
            ,SS_HC_EpisodioAtencion.ObservacionProxima as Expr102 --AUX
			,left(CONVERT (time, FechaAtencion),8) as Expr103 --HORA ATENCION        
            --    
            ,SS_GE_TipoAtencion.Descripcion as TipoAtencionDesc
            ,EMPLEADO_PERSSALUD.CMP as TipoTrabajadorDesc  --CMP
            ,CM_CO_Establecimiento.Codigo as EstablecimientoCodigo
            ,CM_CO_Establecimiento.Nombre as EstablecimientoDesc
            ,SS_HC_UnidadServicio.Codigo as UnidadServicioCodigo
            ,SS_GE_Paciente.CodigoHC as UnidadServicioDesc --CODIGOHC
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
		else '- RNE: '+ESPECIALIDAD_MED.NumeroRegistroEspecialidad end)    as Expr104  --AUX                    
	FROM		SS_HC_AntePerGinecoObstetricos_FE EAD 
	INNER JOIN  SS_HC_EpisodioAtencion    WITH(NOLOCK)  ON EAD.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion
								AND EAD.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion 
								AND EAD.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente 
								AND EAD.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
	LEFT JOIN  SS_HC_GINECOOBSTETRICOS_Diagnostico_FE EA WITH(NOLOCK) ON EAD.UnidadReplicacion = EA.UnidadReplicacion
								AND EAD.IdEpisodioAtencion = EA.IdEpisodioAtencion 
								AND EAD.IdPaciente = EA.IdPaciente 
								AND EAD.EpisodioClinico = EA.EpisodioClinico 
	LEFT JOIN  PERSONAMAST				WITH(NOLOCK) ON EA.IdPaciente = dbo.PERSONAMAST.Persona
	LEFT JOIN  SS_GE_Diagnostico D		WITH(NOLOCK) ON EA.IdDiagnostico = D.IdDiagnostico --ANGEL	
	LEFT JOIN  SS_GE_Paciente			WITH(NOLOCK) on EAD.IdPaciente =  SS_GE_Paciente.IdPaciente                                           
	LEFT JOIN  SS_GE_TipoAtencion		WITH(NOLOCK) ON SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
	LEFT JOIN  SS_TipoTrabajador		WITH(NOLOCK) ON SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
	LEFT JOIN  CM_CO_Establecimiento	WITH(NOLOCK) ON CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
	LEFT JOIN  SS_HC_UnidadServicio     WITH(NOLOCK) ON SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                      
	LEFT JOIN  PERSONAMAST as PERSONA_PERSSALUD     WITH(NOLOCK) ON PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
	LEFT JOIN  SS_GE_Especialidad                   WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad     
						  --ADD CMP  y RNE
	LEFT JOIN   EMPLEADOMAST  as EMPLEADO_PERSSALUD				WITH(NOLOCK) ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud
	LEFT JOIN   SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED   WITH(NOLOCK) ON ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud
																	And ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad
	-----------
	LEFT JOIN	MA_MiscelaneosDetalle COLAB WITH(NOLOCK) ON    COLAB.Compania='999999'  AND COLAB.AplicacionCodigo = 'WA' AND COLAB.CodigoTabla='TABCOLABORACION' 
	AND COLAB.CodigoElemento=EA.IdNacidoVivo 
	LEFT JOIN 	CM_CO_TablaMaestroDetalle COLABO WITH(NOLOCK) ON COLABO.IdTablaMaestro=  35 AND COLABO.IDCODIGO=EA.IdNacidoVivo 

	LEFT JOIN	MA_MiscelaneosDetalle ATENDIDOPO WITH(NOLOCK) ON    ATENDIDOPO.Compania='999999'  AND ATENDIDOPO.AplicacionCodigo = 'WA' AND ATENDIDOPO.CodigoTabla='ATENDIDOPOR' 
	AND ATENDIDOPO.CodigoElemento=EA.IdAtendidoPor 
	LEFT JOIN 	GE_VARIOS ATENDIDOPOD WITH(NOLOCK) ON ATENDIDOPOD.CodigoTabla=  'ATENDIDOPOR' AND ATENDIDOPOD.Secuencial=EA.IdAtendidoPor 

	LEFT JOIN	MA_MiscelaneosDetalle LUGPART WITH(NOLOCK) ON    LUGPART.Compania='999999'  AND LUGPART.AplicacionCodigo = 'WA' AND LUGPART.CodigoTabla='LUGPARTO' 
	AND LUGPART.CodigoElemento=EA.IdLugarParto
	LEFT JOIN 	GE_VARIOS LUGPARTOD WITH(NOLOCK) ON LUGPARTOD.CodigoTabla=  'LUGPARTO' AND LUGPARTOD.Secuencial=EA.IdLugarParto 

	LEFT JOIN	MA_MiscelaneosDetalle TIPPART WITH(NOLOCK) ON    TIPPART.Compania='999999'  AND TIPPART.AplicacionCodigo = 'WA' AND TIPPART.CodigoTabla='TIPPARTO' 
	AND TIPPART.CodigoElemento=EA.IdTipoParto
	LEFT JOIN 	GE_VARIOS TIPPARTD WITH(NOLOCK) ON TIPPARTD.CodigoTabla=  'TIPPARTO' AND TIPPARTD.Secuencial=EA.IdTipoParto 

	LEFT JOIN	MA_MiscelaneosDetalle TABCOLABORACIO WITH(NOLOCK) ON    TABCOLABORACIO.Compania='999999'  AND TABCOLABORACIO.AplicacionCodigo = 'WA' AND TABCOLABORACIO.CodigoTabla='TABCOLABORACION' 
	AND TABCOLABORACIO.CodigoElemento=EA.IdComplicacionesParto
	LEFT JOIN 	CM_CO_TablaMaestroDetalle TABCOLABORACIOD WITH(NOLOCK) ON TABCOLABORACIOD.IdTablaMaestro=  35 AND TABCOLABORACIOD.IDCODIGO=EA.IdComplicacionesParto 

	LEFT JOIN	MA_MiscelaneosDetalle TIPOSEX WITH(NOLOCK) ON    TIPOSEX.Compania='999999'  AND TIPOSEX.AplicacionCodigo = 'WA' AND TIPOSEX.CodigoTabla='TIPOSEXO' 
	AND TIPOSEX.CodigoElemento=EA.Sexo 

GO

/****** Object:  View [dbo].[rptViewAntecedentesPersonalesFisiologicos_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[rptViewAntecedentesPersonalesFisiologicos_FE]
AS
	SELECT 
		UnidadReplicacion,
		IdEpisodioAtencion,
		IdPaciente,
		EpisodioClinico,
		IdSecuencia,
		ISNULL (TAB_ESTAVIVODET1.DescripcionLocal,'') AS GrupoSanguineo,
		ISNULL (TAB_ESTAVIVODET2.DescripcionLocal,'') AS FactorRH,
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
		ISNULL (SS_HC_AntecedentesPersonalesFisiologicos_FE.Accion,'') AS Accion,
		Version,
		ISNULL(SS_HC_AntecedentesPersonalesFisiologicos_FE.Estado,'')AS Estado,
		UsuarioCreacion,
		FechaCreacion,
		UsuarioModificacion,
		FechaModificacion
	FROM dbo.SS_HC_AntecedentesPersonalesFisiologicos_FE	WITH(NOLOCK) 
		LEFT OUTER JOIN MA_MiscelaneosDetalle AS TAB_ESTAVIVODET1 WITH(NOLOCK) ON TAB_ESTAVIVODET1.CodigoTabla =  'TIPSAN'  AND TAB_ESTAVIVODET1.ValorCodigo1=SS_HC_AntecedentesPersonalesFisiologicos_FE.GrupoSanguineo
		LEFT OUTER JOIN MA_MiscelaneosDetalle AS TAB_ESTAVIVODET2 WITH(NOLOCK) ON TAB_ESTAVIVODET2.CodigoTabla =  'TIPSANVAL'  AND TAB_ESTAVIVODET2.ValorCodigo1=SS_HC_AntecedentesPersonalesFisiologicos_FE.FactorRH

GO

/****** Object:  View [dbo].[rptViewAntecedentesPersonalesPatologicosGenerales_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[rptViewAntecedentesPersonalesPatologicosGenerales_FE]

AS
SELECT	
		SS_HC_Anam_AP_PatologicosGenerales_FE.IdPatologicosGenerales,
		SS_HC_Anam_AP_PatologicosGenerales_FE.EnfermedadesAnteriores_rb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.HipertensionSeleccion_ckb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.HipertensionTiempoenfermedad_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.HipertensionMedicacion_rb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.HipertensionMedicacion_txt,
		SS_HC_Anam_AP_PatologicosGenerales_FE.HipertensionTipoDiagn_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.DiabetesSeleccion_ckb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.DiabetesTiempoenfermedad_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.DiabetesMedicacion_rb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.DiabetesMedicacion_txt,
		SS_HC_Anam_AP_PatologicosGenerales_FE.DiabetesTipoDiagn_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.AsmaSeleccion_ckb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.AsmaTiempoenfermedad_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.AsmaMedicacion_rb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.AsmaMedicacion_txt,
		SS_HC_Anam_AP_PatologicosGenerales_FE.AsmaTipoDiagn_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.SindromeCSeleccion_ckb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.SindromeCTiempoenfermedad_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.SindromeCMedicacion_rb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.SindromeCMedicacion_txt,
		SS_HC_Anam_AP_PatologicosGenerales_FE.SindromeCTipoDiagn_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.SindromeRSeleccion_ckb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.SindromeRTiempoenfermedad_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.SindromeRMedicacion_rb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.SindromeRMedicacion_txt,
		SS_HC_Anam_AP_PatologicosGenerales_FE.SindromeRTipoDiagn_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.GastritisSeleccion_ckb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.GastritisTiempoenfermedad_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.GastritisMedicacion_rb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.GastritisMedicacion_txt,
		SS_HC_Anam_AP_PatologicosGenerales_FE.GastritisTipoDiagn_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.ArritmiaSeleccion_ckb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.ArritmiaTiempoenfermedad_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.ArritmiaMedicacion_rb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.ArritmiaMedicacion_txt,
		SS_HC_Anam_AP_PatologicosGenerales_FE.ArritmiaTipoDiagn_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.HepatitisSeleccion_ckb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.HepatitisTiempoenfermedad_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.HepatitisMedicacion_rb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.HepatitisMedicacion_txt,
		SS_HC_Anam_AP_PatologicosGenerales_FE.HepatitisTipoDiagn_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.TuberculosisSeleccion_ckb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.TuberculosisTiempoenfermedad_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.TuberculosisMedicacion_rb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.TuberculosisMedicacion_txt,
		SS_HC_Anam_AP_PatologicosGenerales_FE.TuberculosisTipoDiagn_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.HipertiroidismoSeleccion_ckb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.HipertiroidismoTiempoenfermedad_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.HipertiroidismoMedicacion_rb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.HipertiroidismoMedicacion_txt,
		SS_HC_Anam_AP_PatologicosGenerales_FE.HipertiroidismoTipoDiagn_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.HipotiroidismoSeleccion_ckb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.HipotiroidismoTiempoenfermedad_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.HipotiroidismoMedicacion_rb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.HipotiroidismoMedicacion_txt,
		SS_HC_Anam_AP_PatologicosGenerales_FE.HipotiroidismoTipoDiagn_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.InfeccionSeleccion_ckb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.InfeccionTiempoenfermedad_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.InfeccionMedicacion_rb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.InfeccionMedicacion_txt,
		SS_HC_Anam_AP_PatologicosGenerales_FE.InfeccionTipoDiagn_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.CardiopatiasSeleccion_ckb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.CardiopatiasTiempoenfermedad_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.CardiopatiasMedicacion_rb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.CardiopatiasMedicacion_txt,
		SS_HC_Anam_AP_PatologicosGenerales_FE.CardiopatiasTipoDiagn_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.EtransmisionSSeleccion_ckb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.EtransmisionSTiempoenfermedad_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.EtransmisionSMedicacion_rb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.EtransmisionSMedicacion_txt,
		SS_HC_Anam_AP_PatologicosGenerales_FE.EtransmisionSTipoDiagn_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.DShipoacusiaSeleccion_ckb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.DShipoacusiaTiempoenfermedad_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.DShipoacusiaMedicacion_rb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.DShipoacusiaMedicacion_txt,
		SS_HC_Anam_AP_PatologicosGenerales_FE.DShipoacusiaTipoDiagn_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.DScegueraSeleccion_ckb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.DScegueraTiempoenfermedad_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.DScegueraMedicacion_rb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.DScegueraMedicacion_txt,
		SS_HC_Anam_AP_PatologicosGenerales_FE.DScegueraTipoDiagn_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.DSSordoMudoSeleccion_ckb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.DSSordoMudoTiempoenfermedad_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.DSSordoMudoMedicacion_rb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.DSSordoMudoMedicacion_txt,
		SS_HC_Anam_AP_PatologicosGenerales_FE.DSSordoMudoTipoDiagn_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.DSMiopiaAltaSeleccion_ckb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.DSMiopiaAltaTiempoenfermedad_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.DSMiopiaAltaMedicacion_rb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.DSMiopiaAltaMedicacion_txt,
		SS_HC_Anam_AP_PatologicosGenerales_FE.DSMiopiaAltaTipoDiagn_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.CancerSeleccion_ckb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.CancerTiempoenfermedad_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.CancerMedicacion_rb,
		SS_HC_Anam_AP_PatologicosGenerales_FE.CancerMedicacion_txt,
		SS_HC_Anam_AP_PatologicosGenerales_FE.CancerTipoDiagn_list,
		SS_HC_Anam_AP_PatologicosGenerales_FE.Estado,
		SS_HC_Anam_AP_PatologicosGenerales_FE.UsuarioCreacion,
		SS_HC_Anam_AP_PatologicosGenerales_FE.FechaCreacion,
		SS_HC_Anam_AP_PatologicosGenerales_FE.UsuarioModificacion,
		SS_HC_Anam_AP_PatologicosGenerales_FE.FechaModificacion,
		SS_HC_Anam_AP_PatologicosGenerales_FE.Accion,
		SS_HC_Anam_AP_PatologicosGenerales_FE.Version,
		
		SS_HC_Anam_AP_PatologicosGenerales_FE.UnidadReplicacion,
		SS_HC_Anam_AP_PatologicosGenerales_FE.IdEpisodioAtencion,
		SS_HC_Anam_AP_PatologicosGenerales_FE.IdPaciente,
		SS_HC_Anam_AP_PatologicosGenerales_FE.EpisodioClinico,
		SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE.Secuencia, 
		SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE.OtrasEnfermedades, 
		SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE.IdDiagnostico as IdDiagnostico, 
		SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE.DiagnosticoText,
		CASE SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE.TiempoEnfermedad_list
			 when 0 then SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE.DiagnosticoText
			else SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE.TiempoEnfermedad_list
		 END
		 as TiempoEnfermedad_list,
		SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE.Medicacion_txt,
		CASE SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE.TiempoEnfermedad_list
			 when '1' then '0-1' 
			 when '2' then '1 a 5' 
			 when '3' then '5 a 10' 
			 when '4' then '10 a 15' 
			 when '5' then '15 a 20' 
			 when '6' then '20 a más'
			 else ''
		 END
	   as Adicional1,
		
	    CASE 	SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE.TipoDiagn_list 
			when '1' then 'Presuntivo'
			when '2' then 'Definitivo'
		else ''
		
	    end
	  as Adicional2,

		/**********ADD GENERALES****************/ 
		0 IDAntecedentePat, 
		'' CodigoAntecedentePat,
		'' Descripcion,

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
		SS_HC_EpisodioAtencion.ObservacionProxima AS ObservacionProximaEpiAtencion,
		SS_GE_TipoAtencion.Descripcion AS TipoAtencionDesc,
		SS_TipoTrabajador.DescripcionLocal AS TipoTrabajadorDesc,
		CM_CO_Establecimiento.Codigo AS EstablecimientoCodigo, 
		CM_CO_Establecimiento.Nombre AS EstablecimientoDesc,	 
		SS_HC_UnidadServicio.Codigo AS UnidadServicioCodigo, 
		SS_HC_UnidadServicio.Descripcion AS UnidadServicioDesc
FROM dbo.SS_HC_Anam_AP_PatologicosGenerales_FE WITH(NOLOCK) 
		left join	dbo.SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE 
			WITH(NOLOCK)  on SS_HC_Anam_AP_PatologicosGenerales_FE.UnidadReplicacion = SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE.UnidadReplicacion and
				 SS_HC_Anam_AP_PatologicosGenerales_FE.IdEpisodioAtencion = SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE.IdEpisodioAtencion and
				 SS_HC_Anam_AP_PatologicosGenerales_FE.IdPaciente = SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE.IdPaciente and
				 SS_HC_Anam_AP_PatologicosGenerales_FE.EpisodioClinico = SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE.EpisodioClinico
		/**********ADD GENERALES************  15/02/2017 SE QUITO ****/ 
		left JOIN PERSONAMAST 
			WITH(NOLOCK) ON SS_HC_Anam_AP_PatologicosGenerales_FE.IdPaciente = PERSONAMAST.Persona 
		INNER JOIN SS_HC_EpisodioAtencion 
			WITH(NOLOCK) ON SS_HC_Anam_AP_PatologicosGenerales_FE.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion AND 
				(case when SS_HC_EpisodioAtencion.TipoAtencion in (2,3) then SS_HC_EpisodioAtencion.IdEpisodioAtencion else
				 SS_HC_EpisodioAtencion.EpisodioAtencion end) 
					 = SS_HC_Anam_AP_PatologicosGenerales_FE.IdEpisodioAtencion and
				SS_HC_Anam_AP_PatologicosGenerales_FE.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND 
				SS_HC_Anam_AP_PatologicosGenerales_FE.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
		left outer join	SS_GE_TipoAtencion 
			WITH(NOLOCK) on SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion 
		left outer join SS_TipoTrabajador 
			WITH(NOLOCK) on SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador 
		left outer join	CM_CO_Establecimiento 
			WITH(NOLOCK) on CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud 
		left outer join SS_HC_UnidadServicio
            WITH(NOLOCK) on SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
               and CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud

GO

/****** Object:  View [dbo].[rptViewAntFisiologicoPediatricoFE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[rptViewAntFisiologicoPediatricoFE]
as
SELECT           UnidadReplicacion, 
                           IdEpisodioAtencion, 
                           IdPaciente, 
                           EpisodioClinico, 
                           IdAntFiPediatrico, 
                           EdadMaterna, 
                           Paridad_1,
                           Paridad_2, 
                           Paridad_3, 
                           Paridad_4, 
                Gravidez, 
                           ControlPrenatal, 
                           Complicaciones, 
                           TipoParto, 
                           MotivoCesarea, 
                           LugarNacimiento, 
                           Peso, 
                           PesoNR, 
                           Talla, 
                           TallaNR, 
                           PCNacer, 
                           PCNacerNR,
                           APGAR, 
                        CASE  WHEN  APGAR=15 THEN CONCAT(DesApgar1 , ' ') ELSE ' ' END  DesApgar1,
                           CASE  WHEN  APGAR=16 THEN CONCAT(DesApgar2 , ' ') ELSE ' ' END  DesApgar2,
                           CASE  WHEN  APGAR=17 THEN CONCAT(DesApgar3 , ' ') ELSE ' ' END  DesApgar3,
                           CASE  WHEN  APGAR=18 THEN CONCAT(DesApgar4 , ' ') ELSE ' ' END  DesApgar4,
                           Reanimacion,
                Lactancia,
                           InicioAblactansia,
                           AlimentosActuales,
                           Vigilancia, 
                           Psicomotor, 
                           DetallarPsicomotor, 
                           Estado, 
                           UsuarioCreacion, 
                           FechaCreacion, 
                           UsuarioModificacion, 
                FechaModificacion, 
                           Accion, Version
FROM            SS_HC_Ant_Fisiologico_Pediatrico_FE

GO

/****** Object:  View [dbo].[rptViewApoyoDiagnostico_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE OR ALTER VIEW [dbo].[rptViewApoyoDiagnostico_FE] AS
		SELECT       
		AD.UnidadReplicacion, 
		AD.IdEpisodioAtencion, 
		AD.IdPaciente,
		AD.EpisodioClinico, 
		AD.NroInforme,
		AD.FechaSolicitada,
		0 IdEspecialidad,
		0 IdProcedimiento,
		0 TipoOrdenAtencion,
		' ' CodigoComponente,
		' ' ProcedimientoText,
		' ' DiagnosticoText,
		--ADDe.IdEspecialidad,
		--ADDe.IdProcedimiento,
		--ADDe.TipoOrdenAtencion,
		--ADDe.CodigoComponente,
		--ADDe.ProcedimientoText,
		--Adde.DiagnosticoText,
		AD.Observacion AS Observacion,
		AD.Accion,
		AD.Version,
		AD.Estado,
		AD.UsuarioCreacion,
		AD.UsuarioModificacion,
		AD.Nombre,
		AD.RutaInforme,
		DBO.[UFN_Diagnostico_ApoyoDiagnostico_FE](AD.UnidadReplicacion, 
		AD.IdEpisodioAtencion, 
		AD.IdPaciente,
		AD.EpisodioClinico) as Diagnostico,
   /**********ADD GENERALES****************/	--(PERSONAS) 
                      PERSONAMAST.ApellidoPaterno, PERSONAMAST.ApellidoMaterno, PERSONAMAST.Nombres, PERSONAMAST.NombreCompleto, 
                      PERSONAMAST.Busqueda, PERSONAMAST.TipoDocumento, PERSONAMAST.Documento, PERSONAMAST.FechaNacimiento, 
                      PERSONAMAST.Sexo, PERSONAMAST.EstadoCivil, PERSONAMAST.edad as PersonaEdad
                      ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                      --,SS_HC_EpisodioAtencion.TipoOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoAtencion
                      ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                      ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio
                      ,SS_HC_EpisodioAtencion.IdPersonalSalud
                      ,SS_HC_EpisodioAtencion.FechaRegistro
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      ,SS_HC_EpisodioAtencion.IdTipoOrden
                      ,EMPLEADO_PERSSALUD.CMP as estadoEpiAtencion --CMP
                      ,SS_HC_EpisodioAtencion.Accion as Expr101  --AUX
                      ,SS_HC_EpisodioAtencion.ObservacionProxima as Expr102 --AUX
			         ,left(CONVERT (time, FechaAtencion),8) as Expr103 --HORA ATENCION       
                      ,SS_GE_TipoAtencion.Descripcion as TipoAtencionDesc
                      ,EMPLEADO_PERSSALUD.CMP as TipoTrabajadorDesc  --CMP
                      ,CM_CO_Establecimiento.Codigo as EstablecimientoCodigo
                      ,CM_CO_Establecimiento.Nombre as EstablecimientoDesc
                      ,SS_HC_UnidadServicio.Codigo as UnidadServicioCodigo
                      ,SS_GE_Paciente.CodigoHC as UnidadServicioDesc --CODIGOHC
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
	FROM SS_HC_ApoyoDiagnostico_FE AD 
	--	LEFT JOIN SS_HC_ApoyoDiagnosticoDet_FE  ADDe	 WITH(NOLOCK)  ON AD.UnidadReplicacion = ADDe.UnidadReplicacion 
	--			AND AD.IdEpisodioAtencion = ADDe.IdEpisodioAtencion AND AD.IdPaciente = ADDe.IdPaciente 
	--			AND AD.EpisodioClinico = ADDe.EpisodioClinico
	INNER JOIN PERSONAMAST				WITH(NOLOCK) ON AD.IdPaciente = PERSONAMAST.Persona
	--LEFT JOIN SS_GE_Diagnostico D		WITH(NOLOCK) ON ADDe.IdDiagnostico = D.IdDiagnostico    
	LEFT JOIN SS_HC_EpisodioAtencion	WITH(NOLOCK) ON AD.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion
				AND AD.IdEpisodioAtencion = SS_HC_EpisodioAtencion.EpisodioAtencion  AND AD.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente 
				AND AD.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
	LEFT JOIN SS_GE_Paciente			WITH(NOLOCK) ON AD.IdPaciente = SS_GE_Paciente.IdPaciente                                           
	LEFT JOIN SS_GE_TipoAtencion		WITH(NOLOCK) ON SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
	LEFT JOIN SS_TipoTrabajador			WITH(NOLOCK) ON SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
	LEFT JOIN CM_CO_Establecimiento		WITH(NOLOCK) ON CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
	LEFT JOIN SS_HC_UnidadServicio		WITH(NOLOCK) ON SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                      
    LEFT JOIN PERSONAMAST  as PERSONA_PERSSALUD  WITH(NOLOCK) ON PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
    LEFT JOIN SS_GE_Especialidad		WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad     
    LEFT JOIN EMPLEADOMAST  as EMPLEADO_PERSSALUD			WITH(NOLOCK) ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud
    LEFT JOIN SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED WITH(NOLOCK) ON ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud
				AND ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad	

GO

/****** Object:  View [dbo].[rptViewBalanceHidroElectrolitico_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[rptViewBalanceHidroElectrolitico_FE]
AS
SELECT BH.*,CASE TipoBalance 
            WHEN 1 THEN 'BALANCE HIDRO ELECTROLÍTICO NEO'
			WHEN 2 THEN 'BALANCE HIDRO ELECTROLÍTICO EN SOP' 
			WHEN 3 THEN 'BALANCE HIDRO ELECTROLÍTICO PEDIATRICO' 
			WHEN 4 THEN 'BALANCE HIDRO ELECTROLÍTICO' 
			END AS DescripTipoBalance,
			CASE Turno
			WHEN 1 then 'Mañana'
			WHEN 2 then 'Tarde'
			WHEN 3 then 'Noche'
			--WHEN 4 then 'Tiempo Completo'
			END AS DescripTurno
FROM [dbo].[SS_HC_BalanceHidroElect_FE] BH

GO

/****** Object:  View [dbo].[rptViewBalanceHidroElectrolitico_PEDIATRICO_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewBalanceHidroElectrolitico_PEDIATRICO_FE]
AS
select * from [dbo].[SS_HC_BalanceHidroElect_FE]

GO
/****** Object:  View [dbo].[rptViewBalanceHidroElectroliticoDetalle1_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewBalanceHidroElectroliticoDetalle1_FE]
AS
select * from [dbo].[SS_HC_BalanceHidroElectDetalle_FE]

GO
/****** Object:  View [dbo].[rptViewBalanceHidroElectroliticoDetalle2_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewBalanceHidroElectroliticoDetalle2_FE]
AS
select BE.*, CASE TipoSolucion WHEN 1 THEN 'DERIVADOS'
                               WHEN 2 THEN 'OTROS'
							   WHEN 3 THEN 'EPIDURA'
							   WHEN 4 THEN 'DRENAJE'
							   WHEN 5 THEN 'BLOQUEO'
							   END  AS DescripTipoSolucion
 from [dbo].[SS_HC_BalanceHidroElectDetalle_FE] BE 
 
GO
/****** Object:  View [dbo].[rptViewCabezeraAntecedenAlergias_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewCabezeraAntecedenAlergias_FE]
AS
SELECT FV.*,
 /**********ADD GENERALES****************/                      
                --(PERSONAS)
                dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.Nombres, 
				dbo.PERSONAMAST.NombreCompleto, 
                dbo.PERSONAMAST.Busqueda, dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, 
				dbo.PERSONAMAST.FechaNacimiento, 
                dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.edad as PersonaEdad
                --EPI ATENCIÓN
                ,SS_HC_EpisodioTriaje.CodigoOT as idordenatencion
                ,SS_HC_EpisodioTriaje.CodigoOT 
                ,SS_HC_EpisodioTriaje.IdPersonalSalud
                ,SS_HC_EpisodioTriaje.FechaAtencion
                ,SS_HC_EpisodioTriaje.IdEspecialidad AS IdEspecialidadPac
                ,SS_HC_EpisodioTriaje.Estado as estadoEpiAtencion
                ,SS_HC_EpisodioTriaje.Accion as Expr101  --AUX
                ,SS_HC_EpisodioTriaje.Accion as Expr103 --AUX                      
                ,PERSONA_PERSSALUD.NombreCompleto as PersMedicoNombreCompleto
                ,PERSONA_PERSSALUD.Documento as PersMedicoNombreDocumento
                ,SS_GE_Especialidad.Codigo as EspecialidadCodigo
                ,SS_GE_Especialidad.Nombre as EspecialidadDesc
	FROM SS_HC_Triaje_Ant_Alergia_FE FV WITH(NOLOCK) 
	INNER JOIN  SS_HC_EpisodioTriaje  WITH(NOLOCK) 
		ON   SS_HC_EpisodioTriaje.UnidadReplicacion = FV.UnidadReplicacion 
				AND FV.IdPaciente = SS_HC_EpisodioTriaje.IdPaciente 
				AND FV.EpisodioTriaje = SS_HC_EpisodioTriaje.IdEpisodioTriaje
	INNER JOIN  PERSONAMAST  WITH(NOLOCK) ON FV.IdPaciente = PERSONAMAST.Persona 
    LEFT JOIN  PERSONAMAST AS PERSONA_PERSSALUD  WITH(NOLOCK) 
		ON   PERSONA_PERSSALUD.Persona = SS_HC_EpisodioTriaje.IdPersonalSalud
    LEFT JOIN  SS_GE_Especialidad  WITH(NOLOCK) 
		ON   SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioTriaje.IdEspecialidad 
    LEFT JOIN  EMPLEADOMAST AS EMPLEADO_PERSSALUD  WITH(NOLOCK) ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioTriaje.IdPersonalSalud 
GO
/****** Object:  View [dbo].[rptViewContrarReferencia_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewContrarReferencia_FE]
as
select distinct
--datos generales
a.UnidadReplicacion,
a.idEpisodioAtencion,
a.IdPaciente,
a.EpisodioClinico,

a.NroContrarreferencia,
a.FechaContrarreferencia,
a.HoraContrarreferencia,
a.establecimientoOrigen,
a.servicioOrigen,
a.EstablecimientoDestino,
a.ServicioDestino,

--identificacion usuario
a.IdentificacionUsuario,

--resumen de la historia clinica
a.FechaIngreso,
a.FechaEgreso,
dbo.UFN_Diagnostico_CONTRARREFERENCIA_FE(a.UnidadReplicacion,a.IdEpisodioAtencion,a.IdPaciente,a.EpisodioClinico,'IN') AS DiagnosticoIN,
dbo.UFN_Diagnostico_CONTRARREFERENCIA_FE(a.UnidadReplicacion,a.IdEpisodioAtencion,a.IdPaciente,a.EpisodioClinico,'EG') AS DiagnosticoEG,
a.TratamientoRealizados,
a.ProcedimientosRealizados,
--datos contrareferencia
case A.Origen when 'D'
then 'X'
else ''
end  as OrigenD,
case A.origen when 'E'
then 'X'
else ''
end  as OrigenE,
case A.origen when 'A'
then 'X'
else ''
end  as OrigenA,
case A.Calificacion when 'J'
then 'X'
else ''
end  as CalificacionJ,
case A.Calificacion when 'N'
then 'X'
else ''
end  as CalificacionNJ,
case A.UPSContrarreferencia when 'C'
then 'X'
else ''
end  as UPSC,
case A.UPSContrarreferencia when 'E'
then 'X'
else ''
end  as UPSE,
case A.UPSContrarreferencia when 'A'
then 'X'
else ''
end  as UPSA,
case A.UPSContrarreferencia when 'H'
then 'X'
else ''
end  as UPSH,
C.Descripcion as EspecialidadDesc,
a.Recomendaciones,

----Responsable de Contrareferencia
D.NombreCompleto,
E.CMP,

--Condicion del Paciente
CASE A.CondicionPaciente WHEN 'C' 
THEN 'X'
ELSE ''
END AS CPC,
CASE A.CondicionPaciente WHEN 'M' 
THEN 'X'
ELSE ''
END AS CPM,
CASE A.CondicionPaciente WHEN 'A' 
THEN 'X'
ELSE ''
END AS CPA,
CASE A.CondicionPaciente WHEN 'D' 
THEN 'X'
ELSE ''
END AS CPD,
CASE A.CondicionPaciente WHEN 'R' 
THEN 'X'
ELSE ''
END AS CPR,
CASE A.CondicionPaciente WHEN 'F' 
THEN 'X'
ELSE ''
END AS CPF,
a.version		
	
FROM SS_HC_CONTRARREFERENCIA_FE a
INNER JOIN SS_HC_CONTRARREFERENCIA_Diagnostico_FE b 
ON A.IdEpisodioAtencion = B.IdEpisodioAtencion  AND 
A.UnidadReplicacion=B.UnidadReplicacion AND A.IdPaciente=B.IdPaciente AND  A.EpisodioClinico=A.EpisodioClinico
left JOIN SS_GE_Especialidad  AS c
ON A.IdEspecialidad = C.IdEspecialidad 
left JOIN PERSONAMAST AS D ON A.IdPersonalSalud = D.Persona
left JOIN EMPLEADOMAST AS E ON D.PERSONA = E.EMPLEADO

GO
/****** Object:  View [dbo].[rptViewCuidadosPreventivos]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewCuidadosPreventivos]
AS

SELECT			

                dbo.SS_HC_SeguimientoRiesgo.UnidadReplicacion,
				dbo.SS_HC_SeguimientoRiesgo.IdPaciente,
				dbo.SS_HC_SeguimientoRiesgo.EpisodioClinico,
				dbo.SS_HC_SeguimientoRiesgo.IdEpisodioAtencion,										
				dbo.CM_CO_TablaMaestroDetalle.Nombre,
				dbo.SS_HC_CuidadoPreventivo.Descripcion	,
				dbo.SS_HC_CuidadoPreventivo.IdCuidadoPreventivo,
				dbo.SS_HC_SeguimientoRiesgoDetalle.Comentario,
				dbo.SS_HC_SeguimientoRiesgo.FechaSeguimiento , 
				dbo.SS_HC_SeguimientoRiesgo.Secuencia,
				
								
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
                      
FROM         dbo.SS_HC_SeguimientoRiesgo                       
                    INNER JOIN
                      dbo.PERSONAMAST ON dbo.SS_HC_SeguimientoRiesgo.IdPaciente = dbo.PERSONAMAST.Persona
					INNER JOIN
                      dbo.SS_HC_EpisodioAtencion 
                      ON dbo.SS_HC_SeguimientoRiesgo.UnidadReplicacion = dbo.SS_HC_EpisodioAtencion.UnidadReplicacion
                      AND dbo.SS_HC_SeguimientoRiesgo.IdEpisodioAtencion = dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion 
                      AND dbo.SS_HC_SeguimientoRiesgo.IdPaciente = dbo.SS_HC_EpisodioAtencion.IdPaciente 
                      AND dbo.SS_HC_SeguimientoRiesgo.EpisodioClinico = dbo.SS_HC_EpisodioAtencion.EpisodioClinico  
                                                               
					inner join
					
					
                      dbo.SS_GE_TipoAtencion
                      ON dbo.SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
					LEFT JOIN
                      dbo.SS_TipoTrabajador
                      ON dbo.SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
					LEFT JOIN
                      dbo.CM_CO_Establecimiento
                      ON dbo.CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
					LEFT JOIN
                      dbo.SS_HC_UnidadServicio
                      ON dbo.SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                      
                    LEFT JOIN
                      dbo.PERSONAMAST  as PERSONA_PERSSALUD
                      ON PERSONA_PERSSALUD.Persona = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
                    LEFT JOIN
                      dbo.SS_GE_Especialidad  
                      ON SS_GE_Especialidad.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad     
                      --ADD CMP  y RNE
                    LEFT JOIN
                      dbo.EMPLEADOMAST  as EMPLEADO_PERSSALUD
                      ON EMPLEADO_PERSSALUD.Empleado = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
                    LEFT JOIN
                      dbo.SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED
                      ON (ESPECIALIDAD_MED.IdMedico = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
						And ESPECIALIDAD_MED.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad
						)					
					LEFT JOIN
					
					dbo.SS_HC_SeguimientoRiesgoDetalle
					ON
					(
					        dbo.SS_HC_SeguimientoRiesgo.UnidadReplicacion = dbo.SS_HC_SeguimientoRiesgoDetalle.UnidadReplicacion
						AND dbo.SS_HC_SeguimientoRiesgo.IdEpisodioAtencion = dbo.SS_HC_SeguimientoRiesgoDetalle.IdEpisodioAtencion 
						AND dbo.SS_HC_SeguimientoRiesgo.IdPaciente = dbo.SS_HC_SeguimientoRiesgoDetalle.IdPaciente 
						AND dbo.SS_HC_SeguimientoRiesgo.EpisodioClinico = dbo.SS_HC_SeguimientoRiesgoDetalle.EpisodioClinico 
                        AND dbo.SS_HC_SeguimientoRiesgo.Secuencia = SS_HC_SeguimientoRiesgoDetalle.Secuencia
						
						)
					
					LEFT JOIN
                
                   dbo.SS_HC_CuidadoPreventivo
						on 						
						(dbo.SS_HC_CuidadoPreventivo.IdCuidadoPreventivo = SS_HC_SeguimientoRiesgoDetalle.IdCuidadoPreventivo
						)
                  LEFT JOIN
                     
                     dbo.CM_CO_TablaMaestroDetalle
                     
                     on
                     (
                       
                        CM_CO_TablaMaestroDetalle.IdTablaMaestro = 44 and
                        dbo.CM_CO_TablaMaestroDetalle.IdCodigo = SS_HC_SeguimientoRiesgo.IdTipoCuidadoPreventivo
                        
                        
                        
                        )
                       LEFT JOIN
                       dbo.CM_CO_TablaMaestro
                       on
                       (
                         CM_CO_TablaMaestro.CodigoTabla = 'TIPOPREVENTIVO' and
                         CM_CO_TablaMaestro.IdTablaMaestro =CM_CO_TablaMaestroDetalle.IdTablaMaestro
                    )
GO
/****** Object:  View [dbo].[rptViewDatosFirma_Medico]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewDatosFirma_Medico]
AS
SELECT    dbo.SS_HC_EpisodioAtencion.UnidadReplicacion, dbo.SS_HC_EpisodioAtencion.IdPaciente, dbo.SS_HC_EpisodioAtencion.EpisodioClinico, 
					SS_HC_EpisodioAtencion.EpisodioAtencion ,
					  dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion,                                             
                      dbo.SS_HC_EpisodioAtencion.UnidadReplicacionEC, 
                      dbo.SS_HC_EpisodioAtencion.TipoEpisodio, dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencionCodigo,                       
                      /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.Nombres, dbo.PERSONAMAST.NombreCompleto, 
                      dbo.PERSONAMAST.Busqueda, dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.FechaNacimiento, 
                      dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.EstadoCivil, 
					   (SELECT DATEDIFF([year], dbo.PERSONAMAST.FechaNacimiento, GETDATE()) - 
						CASE 
						WHEN (MONTH(GETDATE()) * 100) + DAY(GETDATE()) < (MONTH(dbo.PERSONAMAST.FechaNacimiento) * 100) + DAY(dbo.PERSONAMAST.FechaNacimiento) THEN 1
						ELSE 0
						END) as edad
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
                      ,SS_HC_EpisodioAtencion.ObservacionProxima as codigoHC --AUX
                      --
                      ,SS_GE_TipoAtencion.Descripcion as TipoAtencionDesc
                      ,SS_TipoTrabajador.DescripcionLocal as TipoTrabajadorDesc
                      ,CM_CO_Establecimiento.Codigo as EstablecimientoCodigo
                      ,CM_CO_Establecimiento.Nombre as EstablecimientoDesc
                      ,EMPLEADO_PERSSALUD.FirmaDigital as UnidadServicioCodigo
                      ,'' as UnidadServicioDesc
                      ,PERSONA_PERSSALUD.NombreCompleto as PersMedicoNombreCompleto
                      ,PERSONA_PERSSALUD.Documento as PersMedicoNombreDocumento
                      ,SS_GE_Especialidad.Codigo as EspecialidadCodigo
                      ,SS_GE_Especialidad.Nombre as EspecialidadDesc
					  ,EMPLEADO_PERSSALUD.CMP AS CMP,
					  ESPECIALIDAD_MED.NumeroRegistroEspecialidad AS RNE
                      ----ADD AUX
                      ,			                 
                     '' as ServicioExtra  --AUX

FROM    SS_HC_EpisodioAtencion 	WITH(NOLOCK) 				
        INNER JOIN
                      dbo.PERSONAMAST WITH(NOLOCK) ON dbo.SS_HC_EpisodioAtencion.IdPaciente = dbo.PERSONAMAST.Persona
		LEFT JOIN
                      dbo.SS_GE_TipoAtencion
                      WITH(NOLOCK) ON dbo.SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
		LEFT JOIN
                      dbo.SS_TipoTrabajador
                      WITH(NOLOCK) ON dbo.SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
		LEFT JOIN
                      dbo.CM_CO_Establecimiento
                      WITH(NOLOCK) ON dbo.CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
        LEFT JOIN
                      dbo.PERSONAMAST  as PERSONA_PERSSALUD
                      WITH(NOLOCK) ON PERSONA_PERSSALUD.Persona = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
        LEFT JOIN
                      dbo.SS_GE_Especialidad  
                      WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad                      									 	                      
                      --ADD CMP  y RNE
        LEFT JOIN
                      dbo.EMPLEADOMAST  as EMPLEADO_PERSSALUD
                      WITH(NOLOCK) ON EMPLEADO_PERSSALUD.Empleado = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
        LEFT JOIN
                      dbo.SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED
                      WITH(NOLOCK) ON (ESPECIALIDAD_MED.IdMedico = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
						And ESPECIALIDAD_MED.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad
						)

GO
/****** Object:  View [dbo].[rptViewDatosPaciente_Medico]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[rptViewDatosPaciente_Medico]
AS
SELECT    dbo.SS_HC_EpisodioAtencion.UnidadReplicacion, dbo.SS_HC_EpisodioAtencion.IdPaciente, dbo.SS_HC_EpisodioAtencion.EpisodioClinico, 
					  (case when SS_HC_EpisodioAtencion.TipoAtencion in (2,3) then MED.IdEpisodioAtencion else SS_HC_EpisodioAtencion.EpisodioAtencion end) as EpisodioAtencion ,
					  dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion,                                             
                      dbo.SS_HC_EpisodioAtencion.UnidadReplicacionEC, 
                      dbo.SS_HC_EpisodioAtencion.TipoEpisodio, dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencionCodigo,                       
                      /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.Nombres, dbo.PERSONAMAST.NombreCompleto, 
                      dbo.PERSONAMAST.Busqueda, dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.FechaNacimiento, 
                      dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.EstadoCivil, 
					   (SELECT DATEDIFF([year], dbo.PERSONAMAST.FechaNacimiento, GETDATE()) - 
						CASE 
						WHEN (MONTH(GETDATE()) * 100) + DAY(GETDATE()) < (MONTH(dbo.PERSONAMAST.FechaNacimiento) * 100) + DAY(dbo.PERSONAMAST.FechaNacimiento) THEN 1
						ELSE 0
						END) as edad
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
                      ,SS_HC_EpisodioAtencion.ObservacionProxima as codigoHC --AUX
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
					  ,EMPLEADO_PERSSALUD.CMP AS CMP,
					  ESPECIALIDAD_MED.NumeroRegistroEspecialidad AS RNE
                      ----ADD AUX
                      ,			                 
                     MED.Comentario as ServicioExtra  --AUX

FROM    SS_HC_EpisodioAtencion 	WITH(NOLOCK) 				
        INNER JOIN
                      dbo.PERSONAMAST WITH(NOLOCK) ON dbo.SS_HC_EpisodioAtencion.IdPaciente = dbo.PERSONAMAST.Persona
		INNER JOIN SS_HC_Medicamento_FE MED 
					  WITH(NOLOCK) ON MED.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion AND
					  MED.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente and MED.EpisodioClinico=SS_HC_EpisodioAtencion.EpisodioClinico
					  and  
					  MED.IdEpisodioAtencion =(case when SS_HC_EpisodioAtencion.TipoAtencion in (2,3) then SS_HC_EpisodioAtencion.IdEpisodioAtencion else
					  SS_HC_EpisodioAtencion.EpisodioAtencion end)  and 
					  MED.GrupoMedicamento =0
		LEFT JOIN
                      dbo.SS_GE_TipoAtencion
                      WITH(NOLOCK) ON dbo.SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
		LEFT JOIN
                      dbo.SS_TipoTrabajador
                      WITH(NOLOCK) ON dbo.SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
		LEFT JOIN
                      dbo.CM_CO_Establecimiento
                      WITH(NOLOCK) ON dbo.CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
		LEFT JOIN
                      dbo.SS_HC_UnidadServicio
                      WITH(NOLOCK) ON dbo.SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                      
        LEFT JOIN
                      dbo.PERSONAMAST  as PERSONA_PERSSALUD
                      WITH(NOLOCK) ON PERSONA_PERSSALUD.Persona = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
        LEFT JOIN
                      dbo.SS_GE_Especialidad  
                      WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad                      									 	                      
                      --ADD CMP  y RNE
        LEFT JOIN
                      dbo.EMPLEADOMAST  as EMPLEADO_PERSSALUD
                      WITH(NOLOCK) ON EMPLEADO_PERSSALUD.Empleado = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
        LEFT JOIN
                      dbo.SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED
                      WITH(NOLOCK) ON (ESPECIALIDAD_MED.IdMedico = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
						And ESPECIALIDAD_MED.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad
						)

GO

/****** Object:  View [dbo].[rptViewDiagnostico]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewDiagnostico]
AS
SELECT			dbo.SS_HC_Diagnostico.UnidadReplicacion,
				dbo.SS_HC_Diagnostico.IdPaciente,dbo.SS_HC_Diagnostico.EpisodioClinico,
				dbo.SS_HC_Diagnostico.IdEpisodioAtencion,
				dbo.SS_HC_Diagnostico.IdDiagnostico,
				dbo.SS_HC_Diagnostico.DeterminacionDiagnostica,
				dbo.SS_HC_Diagnostico.IdDiagnosticoPrincipal,
				dbo.SS_HC_Diagnostico.GradoAfeccion,
				dbo.SS_HC_Diagnostico.Observacion,
				dbo.SS_HC_Diagnostico.IndicadorAntecedente,
				dbo.SS_HC_Diagnostico.TipoAntecedente,
				dbo.SS_HC_Diagnostico.IndicadorPreExistencia,
				dbo.SS_HC_Diagnostico.IndicadorCronico,
				dbo.SS_HC_Diagnostico.IndicadorNuevo,
				dbo.SS_HC_Diagnostico.Estado,
				dbo.SS_HC_Diagnostico.Accion as Expr01,
				dbo.SS_HC_Diagnostico.Version as Expr02,
				dbo.SS_HC_Diagnostico.UsuarioCreacion as Expr03,
				dbo.SS_HC_Diagnostico.UsuarioModificacion as Expr04,
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

                      
                      
FROM         dbo.SS_HC_Diagnostico                       
                      INNER JOIN
                      dbo.PERSONAMAST ON dbo.SS_HC_Diagnostico.IdPaciente = dbo.PERSONAMAST.Persona
						INNER JOIN
                      dbo.SS_HC_EpisodioAtencion 
                      ON dbo.SS_HC_Diagnostico.UnidadReplicacion = dbo.SS_HC_EpisodioAtencion.UnidadReplicacion
                      AND dbo.SS_HC_Diagnostico.IdEpisodioAtencion = dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion 
                      AND dbo.SS_HC_Diagnostico.IdPaciente = dbo.SS_HC_EpisodioAtencion.IdPaciente 
                      AND dbo.SS_HC_Diagnostico.EpisodioClinico = dbo.SS_HC_EpisodioAtencion.EpisodioClinico                                             
					LEFT JOIN
                      dbo.SS_GE_TipoAtencion
                      ON dbo.SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
					LEFT JOIN
                      dbo.SS_TipoTrabajador
                      ON dbo.SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
					LEFT JOIN
                      dbo.CM_CO_Establecimiento
                      ON dbo.CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
					LEFT JOIN
                      dbo.SS_HC_UnidadServicio
                      ON dbo.SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                      
                    LEFT JOIN
                      dbo.PERSONAMAST  as PERSONA_PERSSALUD
                      ON PERSONA_PERSSALUD.Persona = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
                    LEFT JOIN
                      dbo.SS_GE_Especialidad  
                      ON SS_GE_Especialidad.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad     
                    LEFT JOIN
                      dbo.SS_GE_Diagnostico  
                      ON SS_GE_Diagnostico.IdDiagnostico = dbo.SS_HC_Diagnostico.IdDiagnostico     		
					 left join 
					 CM_CO_TablaMaestro  as TAB_DETERMDIAG
					 on 
					 (
						TAB_DETERMDIAG.CodigoTabla = 'TABDIAGNOSTICO'						 
					 )
					 left join  CM_CO_TablaMaestroDetalle TAB_DETERMDIAGDET
					 on(
						TAB_DETERMDIAGDET.IdTablaMaestro = TAB_DETERMDIAG.IdTablaMaestro
						and TAB_DETERMDIAGDET.IdCodigo = SS_HC_Diagnostico.DeterminacionDiagnostica
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
						and TAB_DIAGPRINCDET.IdCodigo = SS_HC_Diagnostico.IdDiagnosticoPrincipal
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
						and TAB_GRADOAFECDET.IdCodigo = SS_HC_Diagnostico.GradoAfeccion
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
						and TAB_ANTECDET.IdCodigo = SS_HC_Diagnostico.TipoAntecedente
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
						and TAB_PREXDET.IdCodigo = SS_HC_Diagnostico.IndicadorPreExistencia
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
						and TAB_CRONDET.IdCodigo = SS_HC_Diagnostico.IndicadorCronico
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
						and TAB_NUEVODET.IdCodigo = SS_HC_Diagnostico.IndicadorNuevo
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
/****** Object:  View [dbo].[rptViewDiagnostico_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[rptViewDiagnostico_FE]
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
				('['+ rtrim(dbo.SS_GE_Diagnostico.CodigoDiagnostico)+'] ' +dbo.SS_GE_Diagnostico.Descripcion) as DiagnosticoDesc ,				
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
                      dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.EstadoCivil, (SELECT DATEDIFF([year], dbo.PERSONAMAST.FechaNacimiento, GETDATE()) - 
					CASE 
					WHEN (MONTH(GETDATE()) * 100) + DAY(GETDATE()) < (MONTH(dbo.PERSONAMAST.FechaNacimiento) * 100) + DAY(dbo.PERSONAMAST.FechaNacimiento) THEN 1
					ELSE 0
					END)/*, dbo.PERSONAMAST.edad*/ as PersonaEdad
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
                      
	FROM      SS_HC_Diagnostico_FE as   D_FE   WITH(NOLOCK) 
        INNER JOIN PERSONAMAST WITH(NOLOCK) ON D_FE.IdPaciente = dbo.PERSONAMAST.Persona
		INNER JOIN SS_HC_EpisodioAtencion 
                      WITH(NOLOCK) ON D_FE.UnidadReplicacion = dbo.SS_HC_EpisodioAtencion.UnidadReplicacion
                      AND D_FE.IdEpisodioAtencion = (case when dbo.SS_HC_EpisodioAtencion.TipoAtencion IN(2,3) then dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion
					  else dbo.SS_HC_EpisodioAtencion.EpisodioAtencion end)-- dbo.SS_HC_EpisodioAtencion.EpisodioAtencion /*IdEpisodioAtencion*/ 
                      AND D_FE.IdPaciente = dbo.SS_HC_EpisodioAtencion.IdPaciente 
                      AND D_FE.EpisodioClinico = dbo.SS_HC_EpisodioAtencion.EpisodioClinico                                             
		LEFT JOIN SS_GE_TipoAtencion
                      WITH(NOLOCK) ON dbo.SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
		LEFT JOIN SS_TipoTrabajador
                      WITH(NOLOCK) ON dbo.SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
		LEFT JOIN CM_CO_Establecimiento
                      WITH(NOLOCK) ON dbo.CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
		LEFT JOIN SS_HC_UnidadServicio    
					  WITH(NOLOCK) ON  dbo.SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                      
	/****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/		AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud	

        LEFT JOIN	PERSONAMAST  as PERSONA_PERSSALUD
                      WITH(NOLOCK) ON PERSONA_PERSSALUD.Persona = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
        LEFT JOIN	SS_GE_Especialidad  
                      WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad     
        LEFT JOIN	SS_GE_Diagnostico  
                      WITH(NOLOCK) ON SS_GE_Diagnostico.IdDiagnostico = D_FE.IdDiagnostico     		
		left join	CM_CO_TablaMaestro  as TAB_DETERMDIAG
					 WITH(NOLOCK) on TAB_DETERMDIAG.CodigoTabla = 'TABDIAGNOSTICO'	
		left join  CM_CO_TablaMaestroDetalle TAB_DETERMDIAGDET
					 WITH(NOLOCK) on TAB_DETERMDIAGDET.IdTablaMaestro = TAB_DETERMDIAG.IdTablaMaestro
						and TAB_DETERMDIAGDET.IdCodigo = D_FE.DeterminacionDiagnostica										
		left join  CM_CO_TablaMaestro  as TAB_DIAGPRINC
					 WITH(NOLOCK) on TAB_DIAGPRINC.CodigoTabla = 'TABCOLABORACION'						
		left join  CM_CO_TablaMaestroDetalle TAB_DIAGPRINCDET
					 WITH(NOLOCK) on 	TAB_DIAGPRINCDET.IdTablaMaestro = TAB_DIAGPRINC.IdTablaMaestro
						and TAB_DIAGPRINCDET.IdCodigo = D_FE.IdDiagnosticoPrincipal					 
		left join  CM_CO_TablaMaestro  as TAB_GRADOAFEC
					 WITH(NOLOCK) on 	TAB_GRADOAFEC.CodigoTabla = 'DIAGAFECCION'						 
		left join  CM_CO_TablaMaestroDetalle TAB_GRADOAFECDET
					 WITH(NOLOCK) on		TAB_GRADOAFECDET.IdTablaMaestro = TAB_GRADOAFEC.IdTablaMaestro
						and TAB_GRADOAFECDET.IdCodigo = D_FE.GradoAfeccion					  	
		left join  CM_CO_TablaMaestro  as TAB_ANTEC
					 WITH(NOLOCK) on 	TAB_ANTEC.CodigoTabla = 'DIAGANTECED'							  
		left join  CM_CO_TablaMaestroDetalle TAB_ANTECDET
					 WITH(NOLOCK) on 	TAB_ANTECDET.IdTablaMaestro = TAB_ANTEC.IdTablaMaestro
						and TAB_ANTECDET.IdCodigo = D_FE.TipoAntecedente					  
		left join  CM_CO_TablaMaestro  as TAB_PREX
					 WITH(NOLOCK) on 	TAB_PREX.CodigoTabla = 'TABCOLABORACION'							 
		left join  CM_CO_TablaMaestroDetalle TAB_PREXDET
					 WITH(NOLOCK) on 	TAB_PREXDET.IdTablaMaestro = TAB_PREX.IdTablaMaestro
						and TAB_PREXDET.IdCodigo = D_FE.IndicadorPreExistencia					 					 
		left join  CM_CO_TablaMaestro  as TAB_CRON
					 WITH(NOLOCK) on TAB_CRON.CodigoTabla = 'TABCOLABORACION'							  
		left join  CM_CO_TablaMaestroDetalle TAB_CRONDET
					 WITH(NOLOCK) on 	TAB_CRONDET.IdTablaMaestro = TAB_CRON.IdTablaMaestro
						and TAB_CRONDET.IdCodigo = D_FE.IndicadorCronico					 					 
		left join  CM_CO_TablaMaestro  as TAB_NUEVO
					 WITH(NOLOCK) on 	TAB_NUEVO.CodigoTabla = 'TABCOLABORACION'						 
		left join  CM_CO_TablaMaestroDetalle TAB_NUEVODET
					 WITH(NOLOCK) on 	TAB_NUEVODET.IdTablaMaestro = TAB_NUEVO.IdTablaMaestro
						and TAB_NUEVODET.IdCodigo = D_FE.IndicadorNuevo					 						 
                      --ADD CMP  y RNE
        LEFT JOIN	EMPLEADOMAST  as EMPLEADO_PERSSALUD
                     WITH(NOLOCK) ON EMPLEADO_PERSSALUD.Empleado = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
        LEFT JOIN	SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED
                     WITH(NOLOCK) ON ESPECIALIDAD_MED.IdMedico = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
						And ESPECIALIDAD_MED.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad					
GO
 
/****** Object:  View [dbo].[rptViewDolorEvaAdulto_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewDolorEvaAdulto_FE]
AS

SELECT        SS_HC_Evaluacion_DolorEvaAdultos_FE.UnidadReplicacion, SS_HC_Evaluacion_DolorEvaAdultos_FE.IdEpisodioAtencion, SS_HC_Evaluacion_DolorEvaAdultos_FE.IdPaciente, SS_HC_Evaluacion_DolorEvaAdultos_FE.EpisodioClinico, IdDolorEvaAdultos, Fecha, Hora, Turno, EscalaDolorDescripcion, EscalaDolorValor, 
                         SS_HC_Evaluacion_DolorEvaAdultos_FE.Estado, SS_HC_Evaluacion_DolorEvaAdultos_FE.UsuarioCreacion, SS_HC_Evaluacion_DolorEvaAdultos_FE.FechaCreacion, SS_HC_Evaluacion_DolorEvaAdultos_FE.UsuarioModificacion, SS_HC_Evaluacion_DolorEvaAdultos_FE.FechaModificacion, SS_HC_Evaluacion_DolorEvaAdultos_FE.Accion, SS_HC_Evaluacion_DolorEvaAdultos_FE.Version,
						 CASE SS_HC_Evaluacion_DolorEvaAdultos_FE.Turno 
		WHEN '1' THEN 'Mañana' 
		WHEN '2' THEN 'Tarde' 
		WHEN '3' THEN 'Noche' 
		End
		AS TurnoDescripcion,
		
						 /**********ADD GENERALES****************/ 
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
		SS_HC_EpisodioAtencion.ObservacionProxima AS ObservacionProximaEpiAtencion,

		SS_GE_TipoAtencion.Descripcion AS TipoAtencionDesc,
		SS_TipoTrabajador.DescripcionLocal AS TipoTrabajadorDesc,

		CM_CO_Establecimiento.Codigo AS EstablecimientoCodigo, 
		CM_CO_Establecimiento.Nombre AS EstablecimientoDesc,
	 
		SS_HC_UnidadServicio.Codigo AS UnidadServicioCodigo, 
		SS_HC_UnidadServicio.Descripcion AS UnidadServicioDesc



		




FROM            SS_HC_Evaluacion_DolorEvaAdultos_FE
		/**********ADD GENERALES****************/ 
		left JOIN PERSONAMAST 
			ON SS_HC_Evaluacion_DolorEvaAdultos_FE.IdPaciente = PERSONAMAST.Persona 
		INNER JOIN SS_HC_EpisodioAtencion 
			ON SS_HC_Evaluacion_DolorEvaAdultos_FE.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion AND 
				SS_HC_Evaluacion_DolorEvaAdultos_FE.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND 
				SS_HC_Evaluacion_DolorEvaAdultos_FE.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND 
				SS_HC_Evaluacion_DolorEvaAdultos_FE.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
		left outer join	SS_GE_TipoAtencion 
			on SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion 
		left outer join SS_TipoTrabajador 
			on SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador 
		left outer join	CM_CO_Establecimiento 
			on CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud 
		left outer join SS_HC_UnidadServicio
            on SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
               and CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud -- Validacion

GO
/****** Object:  View [dbo].[rptViewDolorEvaNinios_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewDolorEvaNinios_FE]
AS
SELECT 
		SS_HC_Evaluacion_DolorEvaNinios_FE.UnidadReplicacion,
		SS_HC_Evaluacion_DolorEvaNinios_FE.IdEpisodioAtencion,
		SS_HC_Evaluacion_DolorEvaNinios_FE.IdPaciente,
		SS_HC_Evaluacion_DolorEvaNinios_FE.EpisodioClinico,
		SS_HC_Evaluacion_DolorEvaNinios_FE.IdDolorEvaNinios,
		SS_HC_Evaluacion_DolorEvaNinios_FE.Fecha,
		SS_HC_Evaluacion_DolorEvaNinios_FE.Hora,
		SS_HC_Evaluacion_DolorEvaNinios_FE.Turno,
		SS_HC_Evaluacion_DolorEvaNinios_FE.EscalaDolorDescripcion,
		SS_HC_Evaluacion_DolorEvaNinios_FE.EscalaDolorValor,
		SS_HC_Evaluacion_DolorEvaNinios_FE.Estado,
		SS_HC_Evaluacion_DolorEvaNinios_FE.UsuarioCreacion,
		SS_HC_Evaluacion_DolorEvaNinios_FE.FechaCreacion,
		SS_HC_Evaluacion_DolorEvaNinios_FE.UsuarioModificacion,
		SS_HC_Evaluacion_DolorEvaNinios_FE.FechaModificacion,
		SS_HC_Evaluacion_DolorEvaNinios_FE.Accion,
		SS_HC_Evaluacion_DolorEvaNinios_FE.Version,


		/**********ADD GENERALES****************/ 
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
		SS_HC_EpisodioAtencion.ObservacionProxima AS ObservacionProximaEpiAtencion,

		SS_GE_TipoAtencion.Descripcion AS TipoAtencionDesc,
		SS_TipoTrabajador.DescripcionLocal AS TipoTrabajadorDesc,

		CM_CO_Establecimiento.Codigo AS EstablecimientoCodigo, 
		CM_CO_Establecimiento.Nombre AS EstablecimientoDesc,
	 
		SS_HC_UnidadServicio.Codigo AS UnidadServicioCodigo, 
		SS_HC_UnidadServicio.Descripcion AS UnidadServicioDesc

FROM [dbo].SS_HC_Evaluacion_DolorEvaNinios_FE
		/**********ADD GENERALES****************/ 
		left JOIN PERSONAMAST 
			ON SS_HC_Evaluacion_DolorEvaNinios_FE.IdPaciente = PERSONAMAST.Persona 
		INNER JOIN SS_HC_EpisodioAtencion 
			ON SS_HC_Evaluacion_DolorEvaNinios_FE.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion AND 
				SS_HC_Evaluacion_DolorEvaNinios_FE.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND 
				SS_HC_Evaluacion_DolorEvaNinios_FE.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND 
				SS_HC_Evaluacion_DolorEvaNinios_FE.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
		left outer join	SS_GE_TipoAtencion 
			on SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion 
		left outer join SS_TipoTrabajador 
			on SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador 
		left outer join	CM_CO_Establecimiento 
			on CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud 
		left outer join SS_HC_UnidadServicio
            on SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
               and CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud -- Validacion



GO
/****** Object:  View [dbo].[rptViewEmitirDescansoMedico]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewEmitirDescansoMedico]
AS
SELECT			dbo.SS_HC_DescansoMedico.UnidadReplicacion,
				dbo.SS_HC_DescansoMedico.IdPaciente,dbo.SS_HC_DescansoMedico.EpisodioClinico,
				dbo.SS_HC_DescansoMedico.IdEpisodioAtencion,
				dbo.SS_HC_DescansoMedico.FechaInicioDescanso,
				dbo.SS_HC_DescansoMedico.FechaFinDescanso,
				dbo.SS_HC_DescansoMedico.Observacion,
				dbo.SS_HC_DescansoMedico.Estado,
				dbo.SS_HC_DescansoMedico.UsuarioCreacion,
				dbo.SS_HC_DescansoMedico.FechaCreacion,
				dbo.SS_HC_DescansoMedico.UsuarioModificacion,
				dbo.SS_HC_DescansoMedico.FechaModificacion,
				dbo.SS_HC_DescansoMedico.Accion,
				dbo.SS_HC_DescansoMedico.Version,				
				dbo.SS_HC_DescansoMedico.Dias,
				
				
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
                      
FROM         dbo.SS_HC_DescansoMedico                       
                      INNER JOIN
                      dbo.PERSONAMAST ON dbo.SS_HC_DescansoMedico.IdPaciente = dbo.PERSONAMAST.Persona
						INNER JOIN
                      dbo.SS_HC_EpisodioAtencion 
                      ON dbo.SS_HC_DescansoMedico.UnidadReplicacion = dbo.SS_HC_EpisodioAtencion.UnidadReplicacion
                      AND dbo.SS_HC_DescansoMedico.IdEpisodioAtencion = dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion 
                      AND dbo.SS_HC_DescansoMedico.IdPaciente = dbo.SS_HC_EpisodioAtencion.IdPaciente 
                      AND dbo.SS_HC_DescansoMedico.EpisodioClinico = dbo.SS_HC_EpisodioAtencion.EpisodioClinico                                             
					LEFT JOIN
                      dbo.SS_GE_TipoAtencion
                      ON dbo.SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
					LEFT JOIN
                      dbo.SS_TipoTrabajador
                      ON dbo.SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
					LEFT JOIN
                      dbo.CM_CO_Establecimiento
                      ON dbo.CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
					LEFT JOIN
                      dbo.SS_HC_UnidadServicio
                      ON dbo.SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                      
                    LEFT JOIN
                      dbo.PERSONAMAST  as PERSONA_PERSSALUD
                      ON PERSONA_PERSSALUD.Persona = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
                    LEFT JOIN
                      dbo.SS_GE_Especialidad  
                      ON SS_GE_Especialidad.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad     
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
/****** Object:  View [dbo].[rptViewEmitirDescansoMedico_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewEmitirDescansoMedico_FE]
AS
SELECT			DM.UnidadReplicacion,
				DM.IdPaciente,DM.EpisodioClinico,
				DM.IdEpisodioAtencion,
				DM.FechaInicioDescanso,
				DM.FechaFinDescanso,
				DM.Observacion,
				DM.Estado,
				DM.UsuarioCreacion,
				DM.FechaCreacion,
				DM.UsuarioModificacion,
				DM.FechaModificacion,
				DM.Accion,
				DM.Version,				
				DM.Dias,
			    
				
                      /***************************************/
                      /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      PERSONAMAST.ApellidoPaterno, PERSONAMAST.ApellidoMaterno, PERSONAMAST.Nombres, PERSONAMAST.NombreCompleto, 
                      PERSONAMAST.Busqueda, PERSONAMAST.TipoDocumento, PERSONAMAST.Documento, PERSONAMAST.FechaNacimiento, 
                      PERSONAMAST.Sexo, PERSONAMAST.EstadoCivil, (cast(datediff(dd,PERSONAMAST.FechaNacimiento,GETDATE()) / 365.25 as int)) AS PersonaEdad--PERSONAMAST.edad as PersonaEdad
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
                      ,EMPLEADO_PERSSALUD.CMP as estadoEpiAtencion --CMP
                      ,SS_HC_EpisodioAtencion.Accion as Expr101  --AUX
                      
					  ,(case when  ESPECIALIDAD_MED.NumeroRegistroEspecialidad IS null 
							then ''
							else ESPECIALIDAD_MED.NumeroRegistroEspecialidad end) AS Expr102
					  --,SS_HC_EpisodioAtencion.ObservacionProxima as Expr102 --AUX
			         ,left(CONVERT (time, FechaAtencion),8) as Expr103 --HORA ATENCION        
                      --    
                      ,SS_GE_TipoAtencion.Descripcion as TipoAtencionDesc
                      ,EMPLEADO_PERSSALUD.CMP as TipoTrabajadorDesc  --CMP
                      ,CM_CO_Establecimiento.Codigo as EstablecimientoCodigo
                      ,CM_CO_Establecimiento.Nombre as EstablecimientoDesc
                      ,/*SS_HC_UnidadServicio.Codigo */ EMPLEADO_PERSSALUD.FirmaDigital  as UnidadServicioCodigo
                      ,SS_GE_Paciente.CodigoHC as UnidadServicioDesc --CODIGOHC
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
                      as Expr104,  --AUX
					  DBO.UFN_DIAGNOSTICODescansoMedico_FE(DM.UnidadReplicacion,DM.idEpisodioAtencion,DM.idPaciente ,DM.EpisodioClinico) as DiagnosticoDesc    
FROM        dbo.SS_HC_DescansoMedico_FE   as DM                
                      INNER JOIN
                      dbo.PERSONAMAST ON DM.IdPaciente = dbo.PERSONAMAST.Persona
			INNER JOIN SS_HC_EpisodioAtencion 
                      WITH(NOLOCK) ON DM.UnidadReplicacion = dbo.SS_HC_EpisodioAtencion.UnidadReplicacion
                      AND DM.IdEpisodioAtencion = (case when dbo.SS_HC_EpisodioAtencion.TipoAtencion IN(2,3) then dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion
					  else dbo.SS_HC_EpisodioAtencion.EpisodioAtencion end)-- dbo.SS_HC_EpisodioAtencion.EpisodioAtencion /*IdEpisodioAtencion*/ 
                      AND DM.IdPaciente = dbo.SS_HC_EpisodioAtencion.IdPaciente 
                      AND DM.EpisodioClinico = dbo.SS_HC_EpisodioAtencion.EpisodioClinico     				   
					  LEFT JOIN SS_GE_Paciente 
					  on DM.IdPaciente =  SS_GE_Paciente.IdPaciente                                           
					 LEFT JOIN
                      SS_GE_TipoAtencion
                      ON SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
					LEFT JOIN
                      SS_TipoTrabajador
                      ON SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
					LEFT JOIN
                      CM_CO_Establecimiento
                      ON CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
					--LEFT JOIN
     --                 SS_HC_UnidadServicio
     --                 ON SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                      
                    LEFT JOIN
                      PERSONAMAST  as PERSONA_PERSSALUD
                      ON PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
                    LEFT JOIN
                      SS_GE_Especialidad  
                      ON SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad     
                      --ADD CMP  y RNE
                    LEFT JOIN
                      EMPLEADOMAST  as EMPLEADO_PERSSALUD
                      ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud
                    LEFT JOIN
                      SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED
                      ON (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud
						And ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad
						)					
					

GO
/****** Object:  View [dbo].[rptViewEnfermedadActual_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewEnfermedadActual_FE]
AS
SELECT EA.*,
	   stuff  ((SELECT ', ' + B.Sintomas
	            FROM SS_HC_EnfermedadActual_FE A INNER JOIN SS_HC_EnfermedadActualDetalle_FE B
	            ON    A.UnidadReplicacion = B.UnidadReplicacion AND
				      A.IdEpisodioAtencion = B.IdEpisodioAtencion AND
				      A.IdPaciente = B.IdPaciente AND
					  A.EpisodioClinico = B.EpisodioClinico
			    WHERE EA.IdPaciente = B.IdPaciente AND EA.EpisodioClinico = B.EpisodioClinico AND EA.IdEpisodioAtencion = B.IdEpisodioAtencion
					   AND EA.UnidadReplicacion=B.UnidadReplicacion
					  FOR XML PATH(''), TYPE ).value('.', 'varchar(max)'), 1, 1, '') AS Sintomas
						   ,
   /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      PERSONAMAST.ApellidoPaterno, PERSONAMAST.ApellidoMaterno, PERSONAMAST.Nombres, PERSONAMAST.NombreCompleto, 
                      PERSONAMAST.Busqueda, PERSONAMAST.TipoDocumento, PERSONAMAST.Documento, PERSONAMAST.FechaNacimiento, 
                      PERSONAMAST.Sexo, PERSONAMAST.EstadoCivil, PERSONAMAST.edad as PersonaEdad
                      --EPI ATENCIÓN
                      ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                      --,SS_HC_EpisodioAtencion.TipoOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoAtencion
                      ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                      ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio
                      ,SS_HC_EpisodioAtencion.IdPersonalSalud
                      ,SS_HC_EpisodioAtencion.FechaRegistro
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      --,SS_HC_EpisodioAtencion.IdEspecialidad
                      ,SS_HC_EpisodioAtencion.IdTipoOrden
                      ,EMPLEADO_PERSSALUD.CMP as estadoEpiAtencion --CMP
                      ,SS_HC_EpisodioAtencion.Accion as Expr101  --AUX
                      ,(case when EA.TipoAnamnesisDescrip is null then '' else concat('Informante: ',EA.TipoAnamnesisDescrip ) end )  as Expr102 --AUX
			         ,left(CONVERT (time, FechaAtencion),8) as Expr103 --HORA ATENCION        
                      --    
                      ,SS_GE_TipoAtencion.Descripcion as TipoAtencionDesc
                      ,EMPLEADO_PERSSALUD.CMP as TipoTrabajadorDesc  --CMP
                      ,CM_CO_Establecimiento.Codigo as EstablecimientoCodigo
                      ,CM_CO_Establecimiento.Nombre as EstablecimientoDesc
                      ,SS_HC_UnidadServicio.Codigo as UnidadServicioCodigo
                      ,SS_GE_Paciente.CodigoHC as UnidadServicioDesc --CODIGOHC
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

	FROM     SS_HC_EnfermedadActual_FE EA WITH(NOLOCK) 
		left JOIN SS_HC_EnfermedadActualDetalle_FE  EAD WITH(NOLOCK)	
	   			 ON EA.UnidadReplicacion = EAD.UnidadReplicacion AND EA.IdEpisodioAtencion = EAD.IdEpisodioAtencion AND
					EA.IdPaciente = EAD.IdPaciente AND EA.EpisodioClinico = EAD.EpisodioClinico
		INNER JOIN
                dbo.PERSONAMAST WITH(NOLOCK) ON EA.IdPaciente = dbo.PERSONAMAST.Persona
		left JOIN
                SS_HC_EpisodioAtencion  WITH(NOLOCK)
                ON EAD.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion AND
                --AND EAD.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion 

				EAD.IdEpisodioAtencion =(case when SS_HC_EpisodioAtencion.TipoAtencion IN (2,3) then
			SS_HC_EpisodioAtencion.IdEpisodioAtencion else SS_HC_EpisodioAtencion.EpisodioAtencion end) 

                AND EAD.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente 
                AND EAD.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
				LEFT JOIN SS_GE_Paciente  WITH(NOLOCK)
				on EAD.IdPaciente =  SS_GE_Paciente.IdPaciente                                           
				LEFT JOIN 
                SS_GE_TipoAtencion WITH(NOLOCK)
                ON SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
			LEFT JOIN
                SS_TipoTrabajador WITH(NOLOCK)
                ON SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
			LEFT JOIN
                CM_CO_Establecimiento WITH(NOLOCK)
                ON CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
			LEFT JOIN
                SS_HC_UnidadServicio WITH(NOLOCK)
                ON SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                      
            LEFT JOIN
                PERSONAMAST  as PERSONA_PERSSALUD WITH(NOLOCK)
                ON PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
            LEFT JOIN
                SS_GE_Especialidad   WITH(NOLOCK)
                ON SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad     
                --ADD CMP  y RNE
            LEFT JOIN
                EMPLEADOMAST  as EMPLEADO_PERSSALUD WITH(NOLOCK)
                ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud
            LEFT JOIN
                SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED WITH(NOLOCK)
                ON (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud
				And ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad
				)

GO

/****** Object:  View [dbo].[rptViewEscalaAldrete_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewEscalaAldrete_FE]
AS
SELECT 
		SS_HC_EscalaAldrete_FE.UnidadReplicacion,
		SS_HC_EscalaAldrete_FE.IdEpisodioAtencion,
		SS_HC_EscalaAldrete_FE.IdPaciente,
		SS_HC_EscalaAldrete_FE.EpisodioClinico,
		SS_HC_EscalaAldrete_FE.IdEscalaAldrete,
		SS_HC_EscalaAldrete_FE.FechaIngreso,
		SS_HC_EscalaAldrete_FE.HoraIngreso,
		SS_HC_EscalaAldrete_FE.FlagParametro1,
		SS_HC_EscalaAldrete_FE.FlagParametro2,
		SS_HC_EscalaAldrete_FE.FlagParametro3,
		SS_HC_EscalaAldrete_FE.FlagParametro4,
		SS_HC_EscalaAldrete_FE.FlagParametro5,
		SS_HC_EscalaAldrete_FE.Total,
		SS_HC_EscalaAldrete_FE.UsuarioCreacion,
		SS_HC_EscalaAldrete_FE.FechaCreacion,
		SS_HC_EscalaAldrete_FE.UsuarioModificacion,
		SS_HC_EscalaAldrete_FE.FechaModificacion,
		SS_HC_EscalaAldrete_FE.Accion,
		SS_HC_EscalaAldrete_FE.Version,


		/**********ADD GENERALES****************/ 
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
		SS_HC_EpisodioAtencion.ObservacionProxima AS ObservacionProximaEpiAtencion,

		SS_GE_TipoAtencion.Descripcion AS TipoAtencionDesc,
		SS_TipoTrabajador.DescripcionLocal AS TipoTrabajadorDesc,

		CM_CO_Establecimiento.Codigo AS EstablecimientoCodigo, 
		CM_CO_Establecimiento.Nombre AS EstablecimientoDesc,
	 
		SS_HC_UnidadServicio.Codigo AS UnidadServicioCodigo, 
		SS_HC_UnidadServicio.Descripcion AS UnidadServicioDesc

FROM [dbo].SS_HC_EscalaAldrete_FE
		/**********ADD GENERALES****************/ 
		left JOIN PERSONAMAST 
			ON SS_HC_EscalaAldrete_FE.IdPaciente = PERSONAMAST.Persona 
		INNER JOIN SS_HC_EpisodioAtencion 
			ON SS_HC_EscalaAldrete_FE.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion AND 
				SS_HC_EscalaAldrete_FE.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND 
				SS_HC_EscalaAldrete_FE.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND 
				SS_HC_EscalaAldrete_FE.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
		left outer join	SS_GE_TipoAtencion 
			on SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion 
		left outer join SS_TipoTrabajador 
			on SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador 
		left outer join	CM_CO_Establecimiento 
			on CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud 
		left outer join SS_HC_UnidadServicio
            on SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
               and CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud -- Validacion


GO
/****** Object:  View [dbo].[rptViewEscalaAltaCirugiaAmbulatoria_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewEscalaAltaCirugiaAmbulatoria_FE]
AS
SELECT ESCALA.*,
 /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.Nombres, dbo.PERSONAMAST.NombreCompleto, 
                      dbo.PERSONAMAST.Busqueda, dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.FechaNacimiento, 
                      dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.edad as PersonaEdad
                      --EPI ATENCIÓN
                      ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoOrdenAtencion  AS TipoOrdenAtencionPac
                      ,SS_HC_EpisodioAtencion.TipoAtencion
                      ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                      ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio
                      ,SS_HC_EpisodioAtencion.IdPersonalSalud
                      ,SS_HC_EpisodioAtencion.FechaRegistro AS FechaRegistroPac
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      ,SS_HC_EpisodioAtencion.IdEspecialidad AS IdEspecialidadPac
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
                           
FROM [dbo].[SS_HC_EscalaAltaCirugiaAmbulatoria_FE] ESCALA
INNER JOIN  SS_HC_EpisodioAtencion ON 
                    SS_HC_EpisodioAtencion.UnidadReplicacion = ESCALA.UnidadReplicacion   AND
                    ESCALA.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND
                    ESCALA.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND
                    ESCALA.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico
INNER JOIN  PERSONAMAST ON ESCALA.IdPaciente = PERSONAMAST.Persona                    
LEFT JOIN SS_GE_TipoAtencion ON 
                    SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
LEFT JOIN
                    SS_TipoTrabajador ON 
                    SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador
LEFT JOIN  CM_CO_Establecimiento ON
                    CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud

LEFT JOIN  SS_HC_UnidadServicio ON 
                    SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
                               /****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/           AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
                    LEFT JOIN  PERSONAMAST AS PERSONA_PERSSALUD ON 
                    PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
                    
                    LEFT JOIN  SS_GE_Especialidad ON 
                    SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad 
                    
                    --LEFT JOIN
                    --SS_GE_ProcedimientoMedico ON 
                    --(SS_GE_ProcedimientoMedico.IdProcedimiento = SC.IdProcedimiento AND SC.TipoCodigo = 'C')
                    
                    LEFT JOIN
                    EMPLEADOMAST AS EMPLEADO_PERSSALUD ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud 
                    
                    LEFT JOIN
                    SS_GE_EspecialidadMedico AS ESPECIALIDAD_MED ON 
                    (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud AND
                    ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad)





GO
/****** Object:  View [dbo].[rptViewEscalaBromage_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewEscalaBromage_FE]
as

SELECT        SS_HC_EscalaBromage_FE.UnidadReplicacion,SS_HC_EscalaBromage_FE.IdEpisodioAtencion,SS_HC_EscalaBromage_FE.IdPaciente,SS_HC_EscalaBromage_FE. EpisodioClinico, IdEscalaBromage, SS_HC_EscalaBromage_FE.FechaIngreso, HoraIngreso, FlagParametro1, FlagParametro2, 
                         FlagParametro3, FlagParametro4, Total, SS_HC_EscalaBromage_FE.UsuarioCreacion,SS_HC_EscalaBromage_FE.FechaCreacion,SS_HC_EscalaBromage_FE.UsuarioModificacion, SS_HC_EscalaBromage_FE.FechaModificacion, SS_HC_EscalaBromage_FE.Accion, SS_HC_EscalaBromage_FE.Version,
						   /***************************************/
                      /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      PERSONAMAST.ApellidoPaterno, PERSONAMAST.ApellidoMaterno, PERSONAMAST.Nombres, PERSONAMAST.NombreCompleto, 
                      PERSONAMAST.Busqueda, PERSONAMAST.TipoDocumento, PERSONAMAST.Documento, PERSONAMAST.FechaNacimiento, 
                      PERSONAMAST.Sexo, PERSONAMAST.EstadoCivil, PERSONAMAST.edad as PersonaEdad,
					   (SELECT DATEDIFF([year], dbo.PERSONAMAST.FechaNacimiento, GETDATE()) - 
						CASE 
						WHEN (MONTH(GETDATE()) * 100) + DAY(GETDATE()) < (MONTH(dbo.PERSONAMAST.FechaNacimiento) * 100) + DAY(dbo.PERSONAMAST.FechaNacimiento) THEN 1
						ELSE 0
						END) AS Edad
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
                      ,EMPLEADO_PERSSALUD.CMP as estadoEpiAtencion --CMP
                      ,SS_HC_EpisodioAtencion.Accion as Expr101  --AUX
                      ,SS_HC_EpisodioAtencion.ObservacionProxima as Expr102 --AUX
			         ,left(CONVERT (time, FechaAtencion),8) as Expr103 --HORA ATENCION        
                      --    
                      ,SS_GE_TipoAtencion.Descripcion as TipoAtencionDesc
                      ,EMPLEADO_PERSSALUD.CMP as TipoTrabajadorDesc  --CMP
                      ,CM_CO_Establecimiento.Codigo as EstablecimientoCodigo
                      ,CM_CO_Establecimiento.Nombre as EstablecimientoDesc
                      ,SS_HC_UnidadServicio.Codigo as UnidadServicioCodigo
                      ,SS_GE_Paciente.CodigoHC as UnidadServicioDesc --CODIGOHC
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
                   
FROM            SS_HC_EscalaBromage_FE
INNER JOIN PERSONAMAST 
					ON SS_HC_EscalaBromage_FE.IdPaciente = PERSONAMAST.Persona 
					
				INNER JOIN SS_HC_EpisodioAtencion 
					ON SS_HC_EscalaBromage_FE.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion AND 
					SS_HC_EscalaBromage_FE.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND 
					SS_HC_EscalaBromage_FE.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND 
					SS_HC_EscalaBromage_FE.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
					  LEFT JOIN SS_GE_Paciente 
					  on SS_HC_EscalaBromage_FE.IdPaciente =  SS_GE_Paciente.IdPaciente    
				LEFT OUTER JOIN	SS_GE_TipoAtencion 
					ON SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion 
				LEFT OUTER JOIN SS_TipoTrabajador 
					ON SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador 
				LEFT OUTER JOIN	CM_CO_Establecimiento 
					ON CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud 
				LEFT OUTER JOIN SS_HC_UnidadServicio 
					ON SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio 
			/****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/		AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
				LEFT OUTER JOIN PERSONAMAST AS PERSONA_PERSSALUD 
					ON PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud 
				LEFT OUTER JOIN SS_GE_Especialidad 		ON SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad 
				LEFT OUTER JOIN EMPLEADOMAST AS EMPLEADO_PERSSALUD 
					ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud 
				LEFT OUTER JOIN	SS_GE_EspecialidadMedico AS ESPECIALIDAD_MED 
					ON ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud AND 
					ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad

GO
/****** Object:  View [dbo].[rptViewEscalaGlasgow_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[rptViewEscalaGlasgow_FE]
AS
SELECT SG.*,
 /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.Nombres, dbo.PERSONAMAST.NombreCompleto, 
                      dbo.PERSONAMAST.Busqueda, dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.FechaNacimiento, 
                      dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.edad as PersonaEdad
                      --EPI ATENCIÓN
                      ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoOrdenAtencion  AS TipoOrdenAtencionPac
                      ,SS_HC_EpisodioAtencion.TipoAtencion
                      ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                      ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio
                      ,SS_HC_EpisodioAtencion.IdPersonalSalud
                      ,SS_HC_EpisodioAtencion.FechaRegistro AS FechaRegistroPac
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      ,SS_HC_EpisodioAtencion.IdEspecialidad AS IdEspecialidadPac
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
                           
FROM [dbo].[SS_HC_Escala_Glasgow_FE] SG
INNER JOIN  SS_HC_EpisodioAtencion ON 
                    SS_HC_EpisodioAtencion.UnidadReplicacion = SG.UnidadReplicacion   AND
                    SG.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND
                    SG.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND
                    SG.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico
INNER JOIN  PERSONAMAST ON SG.IdPaciente = PERSONAMAST.Persona                    
LEFT JOIN SS_GE_TipoAtencion ON 
                    SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
LEFT JOIN
                    SS_TipoTrabajador ON 
                    SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador
LEFT JOIN  CM_CO_Establecimiento ON
                    CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud

LEFT JOIN  SS_HC_UnidadServicio ON 
                    SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
                               /****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/           AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
                    LEFT JOIN  PERSONAMAST AS PERSONA_PERSSALUD ON 
                    PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
                    
                    LEFT JOIN  SS_GE_Especialidad ON 
                    SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad 
                    
                    --LEFT JOIN
                    --SS_GE_ProcedimientoMedico ON 
                    --(SS_GE_ProcedimientoMedico.IdProcedimiento = SC.IdProcedimiento AND SC.TipoCodigo = 'C')
                    
                    LEFT JOIN
                    EMPLEADOMAST AS EMPLEADO_PERSSALUD ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud 
                    
                    LEFT JOIN
                    SS_GE_EspecialidadMedico AS ESPECIALIDAD_MED ON 
                    (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud AND
                    ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad)

GO
/****** Object:  View [dbo].[rptViewEscalaNorton_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[rptViewEscalaNorton_FE]
AS
SELECT EN.*,
 /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.Nombres, dbo.PERSONAMAST.NombreCompleto, 
                      dbo.PERSONAMAST.Busqueda, dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.FechaNacimiento, 
                      dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.edad as PersonaEdad
                      --EPI ATENCIÓN
                      ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoOrdenAtencion  AS TipoOrdenAtencionPac
                      ,SS_HC_EpisodioAtencion.TipoAtencion
                      ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                      ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio
                      ,SS_HC_EpisodioAtencion.IdPersonalSalud
                      ,SS_HC_EpisodioAtencion.FechaRegistro AS FechaRegistroPac
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      ,SS_HC_EpisodioAtencion.IdEspecialidad AS IdEspecialidadPac
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
                           
FROM [dbo].[SS_HC_EscalaNorton_FE] EN
INNER JOIN  SS_HC_EpisodioAtencion ON 
                    SS_HC_EpisodioAtencion.UnidadReplicacion = EN.UnidadReplicacion   AND
                    EN.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND
                    EN.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND
                    EN.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico
INNER JOIN  PERSONAMAST ON EN.IdPaciente = PERSONAMAST.Persona                    
LEFT JOIN SS_GE_TipoAtencion ON 
                    SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
LEFT JOIN
                    SS_TipoTrabajador ON 
                    SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador
LEFT JOIN  CM_CO_Establecimiento ON
                    CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud

LEFT JOIN  SS_HC_UnidadServicio ON 
                    SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
                               /****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/           AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
                    LEFT JOIN  PERSONAMAST AS PERSONA_PERSSALUD ON 
                    PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
                    
                    LEFT JOIN  SS_GE_Especialidad ON 
                    SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad 
                    
                    --LEFT JOIN
                    --SS_GE_ProcedimientoMedico ON 
                    --(SS_GE_ProcedimientoMedico.IdProcedimiento = SC.IdProcedimiento AND SC.TipoCodigo = 'C')
                    
                    LEFT JOIN
                    EMPLEADOMAST AS EMPLEADO_PERSSALUD ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud 
                    
                    LEFT JOIN
                    SS_GE_EspecialidadMedico AS ESPECIALIDAD_MED ON 
                    (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud AND
                    ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad)






GO
/****** Object:  View [dbo].[rptViewEscalaRamsay_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewEscalaRamsay_FE]
AS
SELECT 
		SS_HC_EscalaRamsay_FE.UnidadReplicacion,
		SS_HC_EscalaRamsay_FE.IdEpisodioAtencion,
		SS_HC_EscalaRamsay_FE.IdPaciente,
		SS_HC_EscalaRamsay_FE.EpisodioClinico,
		SS_HC_EscalaRamsay_FE.IdEscalaRamsay,
		SS_HC_EscalaRamsay_FE.FechaIngreso,
		SS_HC_EscalaRamsay_FE.HoraIngreso,
		SS_HC_EscalaRamsay_FE.Turno,
		SS_HC_EscalaRamsay_FE.FlagParametro1,
		SS_HC_EscalaRamsay_FE.FlagParametro2,
		SS_HC_EscalaRamsay_FE.FlagParametro3,
		SS_HC_EscalaRamsay_FE.FlagParametro4,
		SS_HC_EscalaRamsay_FE.FlagParametro5,
		SS_HC_EscalaRamsay_FE.DescripcionSedacion,
		SS_HC_EscalaRamsay_FE.Total,
		SS_HC_EscalaRamsay_FE.UsuarioCreacion,
		SS_HC_EscalaRamsay_FE.FechaCreacion,
		SS_HC_EscalaRamsay_FE.UsuarioModificacion,
		SS_HC_EscalaRamsay_FE.FechaModificacion,
		SS_HC_EscalaRamsay_FE.Accion,
		SS_HC_EscalaRamsay_FE.Version,

		/**********ADD GENERALES****************/ 
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
		SS_HC_EpisodioAtencion.ObservacionProxima AS ObservacionProximaEpiAtencion,

		SS_GE_TipoAtencion.Descripcion AS TipoAtencionDesc,
		SS_TipoTrabajador.DescripcionLocal AS TipoTrabajadorDesc,

		CM_CO_Establecimiento.Codigo AS EstablecimientoCodigo, 
		CM_CO_Establecimiento.Nombre AS EstablecimientoDesc,
	 
		SS_HC_UnidadServicio.Codigo AS UnidadServicioCodigo, 
		SS_HC_UnidadServicio.Descripcion AS UnidadServicioDesc

FROM [dbo].SS_HC_EscalaRamsay_FE
		/**********ADD GENERALES****************/ 
		left JOIN PERSONAMAST 
			ON SS_HC_EscalaRamsay_FE.IdPaciente = PERSONAMAST.Persona 
		INNER JOIN SS_HC_EpisodioAtencion 
			ON SS_HC_EscalaRamsay_FE.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion AND 
				SS_HC_EscalaRamsay_FE.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND 
				SS_HC_EscalaRamsay_FE.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND 
				SS_HC_EscalaRamsay_FE.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
		left outer join	SS_GE_TipoAtencion 
			on SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion 
		left outer join SS_TipoTrabajador 
			on SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador 
		left outer join	CM_CO_Establecimiento 
			on CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud 
		left outer join SS_HC_UnidadServicio
            on SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
               and CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud -- Validacion



GO
/****** Object:  View [dbo].[rptViewEscalaSedacionRass_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[rptViewEscalaSedacionRass_FE]
AS
SELECT ESR.*,
 /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.Nombres, dbo.PERSONAMAST.NombreCompleto, 
                      dbo.PERSONAMAST.Busqueda, dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.FechaNacimiento, 
                      dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.edad as PersonaEdad
                      --EPI ATENCIÓN
                      ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoOrdenAtencion  AS TipoOrdenAtencionPac
                      ,SS_HC_EpisodioAtencion.TipoAtencion
                      ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                      ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio
                      ,SS_HC_EpisodioAtencion.IdPersonalSalud
                      ,SS_HC_EpisodioAtencion.FechaRegistro AS FechaRegistroPac
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      ,SS_HC_EpisodioAtencion.IdEspecialidad AS IdEspecialidadPac
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
                           
FROM [dbo].[SS_HC_EscalaSedacionRass_FE] ESR
INNER JOIN  SS_HC_EpisodioAtencion ON 
                    SS_HC_EpisodioAtencion.UnidadReplicacion = ESR.UnidadReplicacion   AND
                    ESR.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND
                    ESR.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND
                    ESR.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico
INNER JOIN  PERSONAMAST ON ESR.IdPaciente = PERSONAMAST.Persona                    
LEFT JOIN SS_GE_TipoAtencion ON 
                    SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
LEFT JOIN
                    SS_TipoTrabajador ON 
                    SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador
LEFT JOIN  CM_CO_Establecimiento ON
                    CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud

LEFT JOIN  SS_HC_UnidadServicio ON 
                    SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
                               /****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/           AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
                    LEFT JOIN  PERSONAMAST AS PERSONA_PERSSALUD ON 
                    PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
                    
                    LEFT JOIN  SS_GE_Especialidad ON 
                    SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad 
                    
                    --LEFT JOIN
                    --SS_GE_ProcedimientoMedico ON 
                    --(SS_GE_ProcedimientoMedico.IdProcedimiento = SC.IdProcedimiento AND SC.TipoCodigo = 'C')
                    
                    LEFT JOIN
                    EMPLEADOMAST AS EMPLEADO_PERSSALUD ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud 
                    
                    LEFT JOIN
                    SS_GE_EspecialidadMedico AS ESPECIALIDAD_MED ON 
                    (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud AND
                    ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad)





GO
/****** Object:  View [dbo].[rptViewEscalaStewart_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[rptViewEscalaStewart_FE]
AS
SELECT * FROM [dbo].[SS_HC_EscalaStewart_FE]


GO
/****** Object:  View [dbo].[rptViewEscalaWoodDownes_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewEscalaWoodDownes_FE]
AS
SELECT EWD.*,
 /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.Nombres, dbo.PERSONAMAST.NombreCompleto, 
                      dbo.PERSONAMAST.Busqueda, dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.FechaNacimiento, 
                      dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.edad as PersonaEdad
                      --EPI ATENCIÓN
                      ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoOrdenAtencion  AS TipoOrdenAtencionPac
                      ,SS_HC_EpisodioAtencion.TipoAtencion
                      ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                      ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio
                      ,SS_HC_EpisodioAtencion.IdPersonalSalud
                      ,SS_HC_EpisodioAtencion.FechaRegistro AS FechaRegistroPac
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      ,SS_HC_EpisodioAtencion.IdEspecialidad AS IdEspecialidadPac
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
                           
FROM [dbo].[SS_HC_EscalaWoodDownes_FE]	EWD
INNER JOIN  SS_HC_EpisodioAtencion ON 
                    SS_HC_EpisodioAtencion.UnidadReplicacion = EWD.UnidadReplicacion   AND
                    EWD.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND
                    EWD.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND
                    EWD.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico
INNER JOIN  PERSONAMAST ON EWD.IdPaciente = PERSONAMAST.Persona                    
LEFT JOIN SS_GE_TipoAtencion ON 
                    SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
LEFT JOIN
                    SS_TipoTrabajador ON 
                    SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador
LEFT JOIN  CM_CO_Establecimiento ON
                    CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud

LEFT JOIN  SS_HC_UnidadServicio ON 
                    SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
                               /****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/           AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
                    LEFT JOIN  PERSONAMAST AS PERSONA_PERSSALUD ON 
                    PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
                    
                    LEFT JOIN  SS_GE_Especialidad ON 
                    SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad 
                    
                    --LEFT JOIN
                    --SS_GE_ProcedimientoMedico ON 
                    --(SS_GE_ProcedimientoMedico.IdProcedimiento = SC.IdProcedimiento AND SC.TipoCodigo = 'C')
                    
                    LEFT JOIN
                    EMPLEADOMAST AS EMPLEADO_PERSSALUD ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud 
                    
                    LEFT JOIN
                    SS_GE_EspecialidadMedico AS ESPECIALIDAD_MED ON 
                    (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud AND
                    ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad)






GO
/****** Object:  View [dbo].[rptViewEvaluacionDolorEvaNeonatosPrematuros_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewEvaluacionDolorEvaNeonatosPrematuros_FE]
AS
SELECT EDNP.*,
 /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.Nombres, dbo.PERSONAMAST.NombreCompleto, 
                      dbo.PERSONAMAST.Busqueda, dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.FechaNacimiento, 
                      dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.edad as PersonaEdad
                      --EPI ATENCIÓN
                      ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoOrdenAtencion  AS TipoOrdenAtencionPac
                      ,SS_HC_EpisodioAtencion.TipoAtencion
                      ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                      ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio
                      ,SS_HC_EpisodioAtencion.IdPersonalSalud
                      ,SS_HC_EpisodioAtencion.FechaRegistro AS FechaRegistroPac
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      ,SS_HC_EpisodioAtencion.IdEspecialidad AS IdEspecialidadPac
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
                           
FROM [dbo].[SS_HC_Evaluacion_DolorEvaNeonatosPrematuros_FE] EDNP
INNER JOIN  SS_HC_EpisodioAtencion ON 
                    SS_HC_EpisodioAtencion.UnidadReplicacion = EDNP.UnidadReplicacion   AND
                    EDNP.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND
                    EDNP.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND
                    EDNP.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico
INNER JOIN  PERSONAMAST ON EDNP.IdPaciente = PERSONAMAST.Persona                    
LEFT JOIN SS_GE_TipoAtencion ON 
                    SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
LEFT JOIN
                    SS_TipoTrabajador ON 
                    SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador
LEFT JOIN  CM_CO_Establecimiento ON
                    CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud

LEFT JOIN  SS_HC_UnidadServicio ON 
                    SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
                               /****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/           AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
                    LEFT JOIN  PERSONAMAST AS PERSONA_PERSSALUD ON 
                    PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
                    
                    LEFT JOIN  SS_GE_Especialidad ON 
                    SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad 
                    
                    --LEFT JOIN
                    --SS_GE_ProcedimientoMedico ON 
                    --(SS_GE_ProcedimientoMedico.IdProcedimiento = SC.IdProcedimiento AND SC.TipoCodigo = 'C')
                    
                    LEFT JOIN
                    EMPLEADOMAST AS EMPLEADO_PERSSALUD ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud 
                    
                    LEFT JOIN
                    SS_GE_EspecialidadMedico AS ESPECIALIDAD_MED ON 
                    (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud AND
                    ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad)






GO
/****** Object:  View [dbo].[rptViewEvolucionMedica_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[rptViewEvolucionMedica_FE]
as
SELECT        A.UnidadReplicacion, A.IdPaciente, A.EpisodioClinico, 
                         A.IdEpisodioAtencion, A.CodigoSecuencia, A.EvolucionObjetiva, 
                         A.FechaIngreso,A.fechacreacion as Hora, A.Accion AS Expr01, A.Version AS Expr02, 
                         PERSONAMAST.ApellidoPaterno, PERSONAMAST.ApellidoMaterno, PERSONAMAST.Nombres, PERSONAMAST.NombreCompleto, 
                         PERSONAMAST.Busqueda, PERSONAMAST.TipoDocumento, PERSONAMAST.Documento, PERSONAMAST.FechaNacimiento, 
                         PERSONAMAST.Sexo, PERSONAMAST.EstadoCivil, PERSONAMAST.edad AS PersonaEdad, SS_HC_EpisodioAtencion.IdOrdenAtencion, 
                         SS_HC_EpisodioAtencion.CodigoOA, SS_HC_EpisodioAtencion.LineaOrdenAtencion, SS_HC_EpisodioAtencion.TipoOrdenAtencion, 
                         SS_HC_EpisodioAtencion.TipoAtencion, SS_HC_EpisodioAtencion.TipoTrabajador, SS_HC_EpisodioAtencion.IdEstablecimientoSalud, 
                         SS_HC_EpisodioAtencion.IdUnidadServicio, SS_HC_EpisodioAtencion.IdPersonalSalud, SS_HC_EpisodioAtencion.FechaRegistro, 
                         SS_HC_EpisodioAtencion.FechaAtencion, SS_HC_EpisodioAtencion.IdEspecialidad, SS_HC_EpisodioAtencion.IdTipoOrden, 
                         SS_HC_EpisodioAtencion.Estado AS estadoEpiAtencion, SS_HC_EpisodioAtencion.Accion AS Expr101, 
                         SS_HC_EpisodioAtencion.ObservacionProxima AS Expr102, SS_HC_EpisodioAtencion.Accion AS Expr103, 
                         SS_GE_TipoAtencion.Descripcion AS TipoAtencionDesc, SS_TipoTrabajador.DescripcionLocal AS TipoTrabajadorDesc, 
                         CM_CO_Establecimiento.Codigo AS EstablecimientoCodigo, CM_CO_Establecimiento.Nombre AS EstablecimientoDesc, 
                         SS_HC_UnidadServicio.Codigo AS UnidadServicioCodigo, SS_HC_UnidadServicio.Descripcion AS UnidadServicioDesc, 
                         PERSONA_PERSSALUD.NombreCompleto AS PersMedicoNombreCompleto, PERSONA_PERSSALUD.Documento AS PersMedicoNombreDocumento, 
                         SS_GE_Especialidad.Codigo AS EspecialidadCodigo, SS_GE_Especialidad.Nombre AS EspecialidadDesc, 
                         PERSONA_PERSSALUD.NombreCompleto + (CASE WHEN EMPLEADO_PERSSALUD.CMP IS NULL THEN '' ELSE '/CMP: ' + EMPLEADO_PERSSALUD.CMP END) 
                         + '/' + SS_GE_Especialidad.Nombre + (CASE WHEN ESPECIALIDAD_MED.NumeroRegistroEspecialidad IS NULL 
                         THEN '' ELSE '- RNE: ' + ESPECIALIDAD_MED.NumeroRegistroEspecialidad END) AS Expr104
FROM             SS_HC_EvolucionMedica_FE A WITH(NOLOCK) 
		INNER JOIN        PERSONAMAST WITH(NOLOCK) ON A.IdPaciente = PERSONAMAST.Persona 
		INNER JOIN        SS_HC_EpisodioAtencion WITH(NOLOCK) ON A.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion AND 
        A.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND 
        A.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND 
        A.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
		LEFT OUTER JOIN   SS_GE_TipoAtencion WITH(NOLOCK) ON SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion 
		LEFT OUTER JOIN   SS_TipoTrabajador WITH(NOLOCK) ON SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador 
		LEFT OUTER JOIN   CM_CO_Establecimiento WITH(NOLOCK) ON CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud 
		LEFT OUTER JOIN   SS_HC_UnidadServicio WITH(NOLOCK) ON SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio 
		LEFT OUTER JOIN   PERSONAMAST AS PERSONA_PERSSALUD WITH(NOLOCK) ON PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud 
		LEFT OUTER JOIN   SS_GE_Especialidad WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad 
		LEFT OUTER JOIN   EMPLEADOMAST AS EMPLEADO_PERSSALUD WITH(NOLOCK) ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud 
		LEFT OUTER JOIN   SS_GE_EspecialidadMedico AS ESPECIALIDAD_MED WITH(NOLOCK) ON ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud AND 
        ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad
		
GO
/****** Object:  View [dbo].[rptViewEvolucionObjetiva]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewEvolucionObjetiva]
AS
SELECT			dbo.SS_HC_EvolucionObjetiva.UnidadReplicacion,
				dbo.SS_HC_EvolucionObjetiva.IdPaciente,dbo.SS_HC_EvolucionObjetiva.EpisodioClinico,
				dbo.SS_HC_EvolucionObjetiva.IdEpisodioAtencion,
				dbo.SS_HC_EvolucionObjetiva.CodigoSecuencia,
				dbo.SS_HC_EvolucionObjetiva.EvolucionObjetiva,
				dbo.SS_HC_EvolucionObjetiva.FechaIngreso,
				dbo.SS_HC_EvolucionObjetiva.Accion as Expr01,
				dbo.SS_HC_EvolucionObjetiva.Version as Expr02,
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
                                            
FROM         dbo.SS_HC_EvolucionObjetiva                       
                      INNER JOIN
                      dbo.PERSONAMAST ON dbo.SS_HC_EvolucionObjetiva.IdPaciente = dbo.PERSONAMAST.Persona
						INNER JOIN
                      dbo.SS_HC_EpisodioAtencion 
                      ON dbo.SS_HC_EvolucionObjetiva.UnidadReplicacion = dbo.SS_HC_EpisodioAtencion.UnidadReplicacion
                      AND dbo.SS_HC_EvolucionObjetiva.IdEpisodioAtencion = dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion 
                      AND dbo.SS_HC_EvolucionObjetiva.IdPaciente = dbo.SS_HC_EpisodioAtencion.IdPaciente 
                      AND dbo.SS_HC_EvolucionObjetiva.EpisodioClinico = dbo.SS_HC_EpisodioAtencion.EpisodioClinico                                             
					LEFT JOIN
                      dbo.SS_GE_TipoAtencion
                      ON dbo.SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
					LEFT JOIN
                      dbo.SS_TipoTrabajador
                      ON dbo.SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
					LEFT JOIN
                      dbo.CM_CO_Establecimiento
                      ON dbo.CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
					LEFT JOIN
                      dbo.SS_HC_UnidadServicio
                      ON dbo.SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                      
                    LEFT JOIN
                      dbo.PERSONAMAST  as PERSONA_PERSSALUD
                      ON PERSONA_PERSSALUD.Persona = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
                    LEFT JOIN
                      dbo.SS_GE_Especialidad  
                      ON SS_GE_Especialidad.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad     
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
/****** Object:  View [dbo].[rptViewExamen_Kardex_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewExamen_Kardex_FE]
as
  Select	
        U1.Nombre as Especialidad,
      U3.DescripcionLocal AS RealizadoDesc,
      SS_HC_Examen_Kardex_FE.UnidadReplicacion,
      SS_HC_Examen_Kardex_FE.IdEpisodioAtencion,
      SS_HC_Examen_Kardex_FE.IdPaciente,
      SS_HC_Examen_Kardex_FE.EpisodioClinico,
      SS_HC_Examen_Kardex_FE.IdKardex,
      SS_HC_Examen_Kardex_FE.Secuencia,
      convert(varchar(10),SS_HC_Examen_Kardex_FE.FechaSolicitada,103) as FechaSolicitada,
      
      SS_HC_Examen_Kardex_FE.Observacion,
      SS_HC_Examen_Kardex_FE.Realizado,
      SS_HC_Examen_Kardex_FE.Detalle,
      SS_HC_Examen_Kardex_FE.Accion,
      SS_HC_Examen_Kardex_FE.DescripcionCodigo,
      SS_HC_Examen_Kardex_FE.IdProcedimiento,
      SS_HC_Examen_Kardex_FE.Cantidad,
      SS_HC_Examen_Kardex_FE.IndicadorEPS,
      SS_HC_Examen_Kardex_FE.TipoCodigo,
      SS_HC_Examen_Kardex_FE.CodigoSegus,
      SS_HC_Examen_Kardex_FE.Especificaciones,
      SS_HC_Examen_Kardex_FE.Version,
      SS_HC_Examen_Kardex_FE.UsuarioCreacion,
      SS_HC_Examen_Kardex_FE.FechaCreacion,
      SS_HC_Examen_Kardex_FE.UsuarioModificacion,
      SS_HC_Examen_Kardex_FE.FechaModificacion,

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
		SS_HC_EpisodioAtencion.ObservacionProxima AS ObservacionProximaEpiAtencion,
		SS_GE_TipoAtencion.Descripcion AS TipoAtencionDesc,
		SS_TipoTrabajador.DescripcionLocal AS TipoTrabajadorDesc,
		CM_CO_Establecimiento.Codigo AS EstablecimientoCodigo, 
		CM_CO_Establecimiento.Nombre AS EstablecimientoDesc,
	 	SS_HC_UnidadServicio.Codigo AS UnidadServicioCodigo, 
		SS_HC_UnidadServicio.Descripcion AS UnidadServicioDesc
  
  	 from  SS_HC_Examen_Kardex_FE 

		left JOIN PERSONAMAST 
			ON SS_HC_Examen_Kardex_FE.IdPaciente = PERSONAMAST.Persona 
		INNER JOIN SS_HC_EpisodioAtencion 
			ON SS_HC_Examen_Kardex_FE.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion AND 
				SS_HC_Examen_Kardex_FE.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND 
				SS_HC_Examen_Kardex_FE.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND 
				SS_HC_Examen_Kardex_FE.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
		left outer join	SS_GE_TipoAtencion 
			on SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion 
		left outer join SS_TipoTrabajador 
			on SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador 
		left outer join	CM_CO_Establecimiento 
			on CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud 
		left outer join SS_HC_UnidadServicio
            on SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
               and CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud -- Validacion
              		left JOIN PERSONAMAST MED
			ON SS_HC_EpisodioAtencion.IdPersonalSalud = MED.Persona  
      left outer join SS_GE_Especialidad u1 on u1.IdEspecialidad=SS_HC_Examen_Kardex_FE.IdEspecialidad
         left outer join MA_MiscelaneosDetalle u3 on u3.CodigoElemento=SS_HC_Examen_Kardex_FE.Realizado
         and u3.CodigoTabla='EXAKAR2'and u3.AplicacionCodigo='WA' AND U3.Compania='999999'

                  







GO
/****** Object:  View [dbo].[rptViewExamenApoyoDiagnostico_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[rptViewExamenApoyoDiagnostico_FE]
AS

/****** Object:  Jordan Mateo   Script Date: 01/02/2017 04:28:48 p.m. ******/
/****** Ultima modificación:  Joel Sebastian   Script Date: 06/02/2017 02:40:00 p.m. ******/
SELECT      A.UnidadReplicacion,
            A.IdPaciente,
            A.EpisodioClinico, 
            A.IdEpisodioAtencion,
            B.Secuencia, 
            A.Resumen,
            A.Motivo,
            D.nombre as TipoExamen,
            A.Estado,
            A.UsuarioCreacion,
            A.FechaCreacion,
            A.UsuarioModificacion,
            A.FechaModificacion,
            A.Accion,
            A.Version,
            A.IdProcedimientoCab,
            A.FechaSolitadaCab,
            A.CantidadCab,
            A.ObservacionCab,
            A.IndicadorEPSCab,
            A.TipoCodigoCab,
            A.CodigoSegusCab,
            A.CodigoComponenteCab,
            A.IdEspecialidadCab,
            A.SecuenciaCab,
            A.EspecificacionesCab,
            B.IdProcedimiento,
            B.IdEspecialidad,
            --D.IDCODIGO AS IdTipoExamen,
            CM_CO_Componente.Nombre AS Examen,
            B.FechaSolicitada,
            B.CodigoComponente,
            B.Observacion,
            B.TipoOrdenAtencion,
            B.IndicadorEPS,
            B.Cantidad,
            B.TipoCodigo,
            B.CodigoSegus,
            B.Especificaciones,
           dbo.UFN_DIAGNOSTICO_FE(a.UnidadReplicacion,a.IdEpisodioAtencion,a.IdPaciente,a.EpisodioClinico) as Diagnostico,
                      /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.Nombres, dbo.PERSONAMAST.NombreCompleto, 
                      dbo.PERSONAMAST.Busqueda, dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.FechaNacimiento, 
                      dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.edad as PersonaEdad
                      --EPI ATENCIÓN
                      ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoOrdenAtencion  AS TipoOrdenAtencionPac
                      ,SS_HC_EpisodioAtencion.TipoAtencion
                      ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                      ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio
                      ,SS_HC_EpisodioAtencion.IdPersonalSalud
                      ,SS_HC_EpisodioAtencion.FechaRegistro
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      ,SS_HC_EpisodioAtencion.IdEspecialidad AS IdEspecialidadPac
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

		FROM       SS_HC_ExamenSolicitadoFE A
                INNER JOIN    SS_HC_ExamenSolicitadoDet_FE B WITH(NOLOCK) ON B.UnidadReplicacion = A.UnidadReplicacion AND B.IdEpisodioAtencion = A.IdEpisodioAtencion AND
					B.IdPaciente = A.IdPaciente AND B.EpisodioClinico = A.EpisodioClinico
                INNER JOIN  PERSONAMAST WITH(NOLOCK) ON B.IdPaciente = PERSONAMAST.Persona
                INNER JOIN  SS_HC_EpisodioAtencion WITH(NOLOCK) ON 
					SS_HC_EpisodioAtencion.UnidadReplicacion = B.UnidadReplicacion   AND
					B.IdEpisodioAtencion = ( case WHEN  SS_HC_EpisodioAtencion.TipoAtencion in (2,3) then SS_HC_EpisodioAtencion.IdEpisodioAtencion
				    else  SS_HC_EpisodioAtencion.EpisodioAtencion END) AND  --SS_HC_EpisodioAtencion.EpisodioAtencion AND--IdEpisodioAtencion AND
					B.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND
					B.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico                    
                LEFT JOIN    CM_CO_Componente WITH(NOLOCK) ON 
					CM_CO_Componente.CodigoComponente =B.CodigoComponente                    
                LEFT JOIN CM_CO_TablaMaestroDetalle D WITH(NOLOCK) ON
					D.IdCodigo=CM_CO_Componente.IDTipoOrdenAtencion AND D.idtablamaestro=101                     
                LEFT JOIN SS_GE_TipoAtencion WITH(NOLOCK) ON 
					SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion                    
                LEFT JOIN SS_TipoTrabajador WITH(NOLOCK) ON 
					SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                    
                LEFT JOIN  CM_CO_Establecimiento WITH(NOLOCK) ON
					CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                    
                LEFT JOIN  SS_HC_UnidadServicio WITH(NOLOCK) ON 
					SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
                            /****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/           AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
                LEFT JOIN  PERSONAMAST AS PERSONA_PERSSALUD WITH(NOLOCK) ON 
					PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud                    
                LEFT JOIN  SS_GE_Especialidad WITH(NOLOCK) ON 
					SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad                     
                LEFT JOIN SS_GE_ProcedimientoMedico WITH(NOLOCK) ON 
					(SS_GE_ProcedimientoMedico.IdProcedimiento = B.IdProcedimiento AND B.TipoCodigo = 'C')                    
                LEFT JOIN EMPLEADOMAST AS EMPLEADO_PERSSALUD WITH(NOLOCK) ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud                     
                LEFT JOIN SS_GE_EspecialidadMedico AS ESPECIALIDAD_MED WITH(NOLOCK) ON 
					(ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud AND
					ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad)

GO

/****** Object:  View [dbo].[rptViewExamenClinico_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[rptViewExamenClinico_FE]
AS
SELECT			EC.UnidadReplicacion,
				EC.IdPaciente,
				EC.EpisodioClinico,
				EC.IdEpisodioAtencion,
			--	EC.IdExamenClinico,
				EC.Observacion,
				EC.Estado,
				EC.UsuarioCreacion,
				EC.FechaCreacion,
				EC.UsuarioModificacion,
				EC.FechaModificacion,
				EC.Accion,
				EC.Version,
			    
                      /***************************************/
                      /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      PERSONAMAST.ApellidoPaterno, PERSONAMAST.ApellidoMaterno, PERSONAMAST.Nombres, PERSONAMAST.NombreCompleto, 
                      PERSONAMAST.Busqueda, PERSONAMAST.TipoDocumento, PERSONAMAST.Documento, PERSONAMAST.FechaNacimiento, 
                      PERSONAMAST.Sexo, PERSONAMAST.EstadoCivil, (cast(datediff(dd,PERSONAMAST.FechaNacimiento,GETDATE()) / 365.25 as int)) AS PersonaEdad--PERSONAMAST.edad as PersonaEdad
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
                      ,EMPLEADO_PERSSALUD.CMP as estadoEpiAtencion --CMP
                      ,SS_HC_EpisodioAtencion.Accion as Expr101  --AUX
                      
					  ,(case when  ESPECIALIDAD_MED.NumeroRegistroEspecialidad IS null 
							then ''
							else ESPECIALIDAD_MED.NumeroRegistroEspecialidad end) AS Expr102
					  --,SS_HC_EpisodioAtencion.ObservacionProxima as Expr102 --AUX
			         ,left(CONVERT (time, FechaAtencion),8) as Expr103 --HORA ATENCION        
                      --    
                      ,SS_GE_TipoAtencion.Descripcion as TipoAtencionDesc
                      ,EMPLEADO_PERSSALUD.CMP as TipoTrabajadorDesc  --CMP
                      ,CM_CO_Establecimiento.Codigo as EstablecimientoCodigo
                      ,CM_CO_Establecimiento.Nombre as EstablecimientoDesc
                      ,/*SS_HC_UnidadServicio.Codigo */ EMPLEADO_PERSSALUD.FirmaDigital  as UnidadServicioCodigo
                      ,SS_GE_Paciente.CodigoHC as UnidadServicioDesc --CODIGOHC
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
                      as Expr104 
	FROM        dbo.SS_HC_ExamenClinico_FE   as EC     WITH(NOLOCK)            
			INNER JOIN PERSONAMAST WITH(NOLOCK) ON EC.IdPaciente = dbo.PERSONAMAST.Persona
			LEFT JOIN  SS_HC_EpisodioAtencion 
					WITH(NOLOCK) ON EC.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion
				--  AND EC.IdEpisodioAtencion = SS_HC_EpisodioAtencion.EpisodioAtencion--IdEpisodioAtencion 
				AND
					(case when SS_HC_EpisodioAtencion.TipoAtencion in (2,3) then SS_HC_EpisodioAtencion.IdEpisodioAtencion else
				SS_HC_EpisodioAtencion.EpisodioAtencion end) 
					= EC.IdEpisodioAtencion 

					AND EC.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente 
					AND EC.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
			LEFT JOIN SS_GE_Paciente 
					WITH(NOLOCK) on EC.IdPaciente =  SS_GE_Paciente.IdPaciente                                           
			LEFT JOIN
					SS_GE_TipoAtencion
					WITH(NOLOCK) ON SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
			LEFT JOIN
					SS_TipoTrabajador
					WITH(NOLOCK) ON SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
			LEFT JOIN
					CM_CO_Establecimiento
					WITH(NOLOCK) ON CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
			LEFT JOIN
					SS_HC_UnidadServicio
					WITH(NOLOCK) ON SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                      
			LEFT JOIN
					PERSONAMAST  as PERSONA_PERSSALUD
					WITH(NOLOCK) ON PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
			LEFT JOIN
					SS_GE_Especialidad  
					WITH(NOLOCK) ON SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad     
					--ADD CMP  y RNE
			LEFT JOIN
					EMPLEADOMAST  as EMPLEADO_PERSSALUD
					WITH(NOLOCK) ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud
			LEFT JOIN
					SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED
					WITH(NOLOCK) ON (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud
					And ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad
					)	

GO


CREATE OR ALTER VIEW [dbo].[rptViewExamenFisicoRegional]
AS
SELECT			dbo.SS_HC_ExamenFisico_Regional.UnidadReplicacion,
				dbo.SS_HC_ExamenFisico_Regional.IdPaciente,dbo.SS_HC_ExamenFisico_Regional.EpisodioClinico,
				dbo.SS_HC_ExamenFisico_Regional.IdEpisodioAtencion,
				dbo.SS_HC_ExamenFisico_Regional.Secuencia,
				dbo.SS_HC_ExamenFisico_Regional.IdCuerpoHumano,
				dbo.SS_HC_ExamenFisico_Regional.Comentarios,
				dbo.SS_HC_ExamenFisico_Regional.Estado,
				dbo.SS_HC_ExamenFisico_Regional.Accion as Expr01,
				dbo.SS_HC_ExamenFisico_Regional.Version as Expr02,
				dbo.SS_HC_ExamenFisico_Regional.UsuarioCreacion as Expr03,
				dbo.SS_HC_ExamenFisico_Regional.UsuarioModificacion as Expr04,
				dbo.SS_HC_CuerpoHumano.Descripcion as CuerpoHumanoDesc,
				dbo.SS_HC_CuerpoHumano.IdCuerpoHumanoPadre,
				dbo.SS_HC_CuerpoHumano.Codigo,
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
                      
FROM         dbo.SS_HC_ExamenFisico_Regional                       
                      INNER JOIN
                      dbo.PERSONAMAST ON dbo.SS_HC_ExamenFisico_Regional.IdPaciente = dbo.PERSONAMAST.Persona
						INNER JOIN
                      dbo.SS_HC_EpisodioAtencion 
                      ON dbo.SS_HC_ExamenFisico_Regional.UnidadReplicacion = dbo.SS_HC_EpisodioAtencion.UnidadReplicacion
                      AND dbo.SS_HC_ExamenFisico_Regional.IdEpisodioAtencion = dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion 
                      AND dbo.SS_HC_ExamenFisico_Regional.IdPaciente = dbo.SS_HC_EpisodioAtencion.IdPaciente 
                      AND dbo.SS_HC_ExamenFisico_Regional.EpisodioClinico = dbo.SS_HC_EpisodioAtencion.EpisodioClinico                                             
					LEFT JOIN
                      dbo.SS_GE_TipoAtencion
                      ON dbo.SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
					LEFT JOIN
                      dbo.SS_TipoTrabajador
                      ON dbo.SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
					LEFT JOIN
                      dbo.CM_CO_Establecimiento
                      ON dbo.CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
					LEFT JOIN
                      dbo.SS_HC_UnidadServicio
                      ON dbo.SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                      
                    LEFT JOIN
                      dbo.PERSONAMAST  as PERSONA_PERSSALUD
                      ON PERSONA_PERSSALUD.Persona = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
                    LEFT JOIN
                      dbo.SS_GE_Especialidad  
                      ON SS_GE_Especialidad.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad     
					 left join 
					 SS_HC_CuerpoHumano  
					 on 
					 (
						SS_HC_CuerpoHumano.IdCuerpoHumano = SS_HC_ExamenFisico_Regional.IdCuerpoHumano						 
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
/****** Object:  View [dbo].[rptViewExamenSolicitado]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewExamenSolicitado]
AS
SELECT			dbo.SS_HC_ExamenSolicitado.UnidadReplicacion,
				dbo.SS_HC_ExamenSolicitado.IdPaciente,dbo.SS_HC_ExamenSolicitado.EpisodioClinico,
				dbo.SS_HC_ExamenSolicitado.IdEpisodioAtencion,
				dbo.SS_HC_ExamenSolicitado.Secuencia,
				dbo.SS_HC_ExamenSolicitado.IdProcedimiento,
				--dbo.SS_HC_ExamenSolicitado.IdEspecialidad,
				dbo.SS_HC_ExamenSolicitado.IdTipoExamen,
				dbo.SS_HC_ExamenSolicitado.FechaSolitada,
				dbo.SS_HC_ExamenSolicitado.CodigoComponente,
				dbo.SS_HC_ExamenSolicitado.Observacion,				
				dbo.SS_HC_ExamenSolicitado.IndicadorEPS,
				dbo.SS_HC_ExamenSolicitado.Cantidad,
				dbo.SS_HC_ExamenSolicitado.TipoCodigo,
				dbo.SS_HC_ExamenSolicitado.CodigoSegus,				
				/*(case when dbo.SS_HC_ExamenSolicitado.TipoCodigo = 'S' 
					then SS_GE_ProcedimientoMedico.Descripcion
					else CM_CO_Componente.Descripcion
					end
				) as ProcedimientoMedicoDesc,
				*/
				SS_GE_ProcedimientoMedico.Descripcion as ProcedimientoMedicoDesc,
				SS_GE_ProcedimientoMedico.Accion as Expr02,
				SS_HC_ExamenSolicitado.Version as Expr03,
				SS_HC_ExamenSolicitado.Accion as Expr04,
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
                                            
FROM         dbo.SS_HC_ExamenSolicitado                       
                      INNER JOIN
                      dbo.PERSONAMAST ON dbo.SS_HC_ExamenSolicitado.IdPaciente = dbo.PERSONAMAST.Persona
						INNER JOIN
                      dbo.SS_HC_EpisodioAtencion 
                      ON dbo.SS_HC_ExamenSolicitado.UnidadReplicacion = dbo.SS_HC_EpisodioAtencion.UnidadReplicacion
                      AND dbo.SS_HC_ExamenSolicitado.IdEpisodioAtencion = dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion 
                      AND dbo.SS_HC_ExamenSolicitado.IdPaciente = dbo.SS_HC_EpisodioAtencion.IdPaciente 
                      AND dbo.SS_HC_ExamenSolicitado.EpisodioClinico = dbo.SS_HC_EpisodioAtencion.EpisodioClinico                                             
					LEFT JOIN
                      dbo.SS_GE_TipoAtencion
                      ON dbo.SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
					LEFT JOIN
                      dbo.SS_TipoTrabajador
                      ON dbo.SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
					LEFT JOIN
                      dbo.CM_CO_Establecimiento
                      ON dbo.CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
					LEFT JOIN
                      dbo.SS_HC_UnidadServicio
                      ON dbo.SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                      
                    LEFT JOIN
                      dbo.PERSONAMAST  as PERSONA_PERSSALUD
                      ON PERSONA_PERSSALUD.Persona = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
                    LEFT JOIN
                      dbo.SS_GE_Especialidad  
                      ON SS_GE_Especialidad.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad     
                      
                    LEFT JOIN
                      dbo.SS_GE_ProcedimientoMedico  
                      ON (SS_GE_ProcedimientoMedico.IdProcedimiento = dbo.SS_HC_ExamenSolicitado.IdProcedimiento
                      and dbo.SS_HC_ExamenSolicitado.TipoCodigo = 'C' 
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
                      
                    /*LEFT JOIN
                      dbo.CM_CO_Componente  
                      ON (CM_CO_Componente.CodigoComponente = dbo.SS_HC_ExamenSolicitado.CodigoSegus    
                      and dbo.SS_HC_ExamenSolicitado.TipoCodigo = 'S' 
                      )*/
				


GO
/****** Object:  View [dbo].[rptViewExamenTriajeFisico]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewExamenTriajeFisico]
AS
SELECT			dbo.SS_HC_ExamenFisico_Triaje.UnidadReplicacion,
				dbo.SS_HC_ExamenFisico_Triaje.IdPaciente,dbo.SS_HC_ExamenFisico_Triaje.EpisodioClinico,
				dbo.SS_HC_ExamenFisico_Triaje.IdEpisodioAtencion,
				dbo.SS_HC_ExamenFisico_Triaje.PresionMinima,
				dbo.SS_HC_ExamenFisico_Triaje.PresionMaxima,
				dbo.SS_HC_ExamenFisico_Triaje.FrecuenciaRespiratoria,
				dbo.SS_HC_ExamenFisico_Triaje.FrecuenciaCardiaca,
				dbo.SS_HC_ExamenFisico_Triaje.Temperatura,
				dbo.SS_HC_ExamenFisico_Triaje.Peso,
				dbo.SS_HC_ExamenFisico_Triaje.Talla,
				dbo.SS_HC_ExamenFisico_Triaje.IndiceMasaCorporal,				
				dbo.SS_HC_ExamenFisico_Triaje.IdEstadoGeneral,
				dbo.SS_HC_ExamenFisico_Triaje.IdNutricion,
				dbo.SS_HC_ExamenFisico_Triaje.IdHidratacion,
				dbo.SS_HC_ExamenFisico_Triaje.IdColaboracion,
				dbo.SS_HC_ExamenFisico_Triaje.Estado,
				TAB_HIDRATADET.Nombre as Expr01,
				TAB_ESTGENDET.Nombre as Expr02,
				TAB_NUTRIDET.Nombre as Expr03,
				TAB_COLABDET.Nombre as Expr04,
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
                      
FROM         dbo.SS_HC_ExamenFisico_Triaje                       
                      INNER JOIN
                      dbo.PERSONAMAST ON dbo.SS_HC_ExamenFisico_Triaje.IdPaciente = dbo.PERSONAMAST.Persona
						INNER JOIN
                      dbo.SS_HC_EpisodioAtencion 
                      ON dbo.SS_HC_ExamenFisico_Triaje.UnidadReplicacion = dbo.SS_HC_EpisodioAtencion.UnidadReplicacion
                      AND dbo.SS_HC_ExamenFisico_Triaje.IdEpisodioAtencion = dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion 
                      AND dbo.SS_HC_ExamenFisico_Triaje.IdPaciente = dbo.SS_HC_EpisodioAtencion.IdPaciente 
                      AND dbo.SS_HC_ExamenFisico_Triaje.EpisodioClinico = dbo.SS_HC_EpisodioAtencion.EpisodioClinico                                             
					LEFT JOIN
                      dbo.SS_GE_TipoAtencion
                      ON dbo.SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
					LEFT JOIN
                      dbo.SS_TipoTrabajador
                      ON dbo.SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
					LEFT JOIN
                      dbo.CM_CO_Establecimiento
                      ON dbo.CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
					LEFT JOIN
                      dbo.SS_HC_UnidadServicio
                      ON dbo.SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                      
                    LEFT JOIN
                      dbo.PERSONAMAST  as PERSONA_PERSSALUD
                      ON PERSONA_PERSSALUD.Persona = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
                    LEFT JOIN
                      dbo.SS_GE_Especialidad  
                      ON SS_GE_Especialidad.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad     
					 left join 
					 CM_CO_TablaMaestro  as TAB_HIDRATA  
					 on 
					 (
						TAB_HIDRATA.CodigoTabla = 'TABHIDRATACION'						 
					 )
					 left join  CM_CO_TablaMaestroDetalle TAB_HIDRATADET
					 on(
						TAB_HIDRATADET.IdTablaMaestro = TAB_HIDRATA.IdTablaMaestro
						and TAB_HIDRATADET.IdCodigo = SS_HC_ExamenFisico_Triaje.IdHidratacion
					 )
					 left join 
					 CM_CO_TablaMaestro  as TAB_ESTGEN 
					 on 
					 (
						TAB_ESTGEN.CodigoTabla = 'TABESTADOGENERAL'						 
					 )
					 left join  CM_CO_TablaMaestroDetalle TAB_ESTGENDET
					 on(
						TAB_ESTGENDET.IdTablaMaestro = TAB_ESTGEN.IdTablaMaestro
						and TAB_ESTGENDET.IdCodigo = SS_HC_ExamenFisico_Triaje.IdEstadoGeneral
					 )		
					 left join 
					 CM_CO_TablaMaestro  as TAB_NUTRI 
					 on 
					 (
						TAB_NUTRI.CodigoTabla = 'TABNUTRICION'						 
					 )
					 left join  CM_CO_TablaMaestroDetalle TAB_NUTRIDET
					 on(
						TAB_NUTRIDET.IdTablaMaestro = TAB_NUTRI.IdTablaMaestro
						and TAB_NUTRIDET.IdCodigo = SS_HC_ExamenFisico_Triaje.IdNutricion
					 )							 			 
					 left join 
					 CM_CO_TablaMaestro  as TAB_COLAB 
					 on 
					 (
						TAB_COLAB.CodigoTabla = 'TABCOLABORACION'						 
					 )
					 left join  CM_CO_TablaMaestroDetalle TAB_COLABDET
					 on(
						TAB_COLABDET.IdTablaMaestro = TAB_COLAB.IdTablaMaestro
						and TAB_COLABDET.IdCodigo = SS_HC_ExamenFisico_Triaje.IdColaboracion
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
/****** Object:  View [dbo].[rptViewFichaAnestesia_1_DiagnosticoDetalle_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewFichaAnestesia_1_DiagnosticoDetalle_FE]
AS
SELECT
				CO.UnidadReplicacion,CO.IdEpisodioAtencion,CO.IdPaciente,CO.EpisodioClinico,CO.UsuarioCreacion,
				CO.UsuarioModificacion,CO.FechaModificacion,CO.FechaCreacion,CO.Accion,CO.Version,
				CO.Estado,CO.Secuencia,
				CO.TipoDiag,
				dbo.SS_GE_Diagnostico.CodigoDiagnostico,
				('['+ rtrim(dbo.SS_GE_Diagnostico.CodigoDiagnostico)+'] ' +dbo.SS_GE_Diagnostico.Descripcion) as DiagnosticoDesc ,
					TAB_DETERMDIAGDET.Nombre as DeterminacionDiagnosticaDesc,
					TAB_DIAGPRINCDET.Nombre   as DiagnosticoPrincipalDesc,
					TAB_GRADOAFECDET.Nombre  as GradoAfeccionDesc,
					CO.TiempoEmfer,
				/**********ADD GENERALES****************/                      
                --(PERSONAS)
                PERSONAMAST.ApellidoPaterno,PERSONAMAST.ApellidoMaterno,PERSONAMAST.Nombres,PERSONAMAST.NombreCompleto, 
                PERSONAMAST.Busqueda,PERSONAMAST.TipoDocumento,PERSONAMAST.Documento,PERSONAMAST.FechaNacimiento, 
                PERSONAMAST.Sexo,PERSONAMAST.EstadoCivil,PERSONAMAST.edad as PersonaEdad
                --EPI ATENCIÓN
                ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                ,SS_HC_EpisodioAtencion.CodigoOA
                ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                ,SS_HC_EpisodioAtencion.TipoOrdenAtencion  AS TipoOrdenAtencionPac
                ,SS_HC_EpisodioAtencion.TipoAtencion
                ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                ,SS_HC_EpisodioAtencion.IdUnidadServicio
                ,SS_HC_EpisodioAtencion.IdPersonalSalud
                ,SS_HC_EpisodioAtencion.FechaRegistro AS FechaRegistroPac
                ,SS_HC_EpisodioAtencion.FechaAtencion
                ,SS_HC_EpisodioAtencion.IdEspecialidad AS IdEspecialidadPac
                ,SS_HC_EpisodioAtencion.IdTipoOrden
                ,SS_HC_EpisodioAtencion.Estado as estadoEpiAtencion
                ,SS_HC_EpisodioAtencion.Accion as Expr101  --AUX
                ,SS_HC_EpisodioAtencion.ObservacionProxima as Expr102 --AUX
                ,SS_HC_EpisodioAtencion.Accion as Expr103 --AUX                      
                ,SS_GE_TipoAtencion.Descripcion as TipoAtencionDesc
                ,SS_TipoTrabajador.DescripcionLocal as TipoTrabajadorDesc
                ,CM_CO_Establecimiento.Codigo as EstablecimientoCodigo
                ,CM_CO_Establecimiento.Nombre as EstablecimientoDesc
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
     
		FROM SS_HC_AnestesiaDiagnosticoDetalle_FE CO WITH(NOLOCK) 
		INNER JOIN  SS_HC_EpisodioAtencion  WITH(NOLOCK) ON 
                    SS_HC_EpisodioAtencion.UnidadReplicacion = CO.UnidadReplicacion   AND
				    CO.IdEpisodioAtencion =(case when SS_HC_EpisodioAtencion.TipoAtencion IN (2,3) then
					SS_HC_EpisodioAtencion.IdEpisodioAtencion else SS_HC_EpisodioAtencion.EpisodioAtencion end) 
					AND
                    CO.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND
                    CO.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico
		INNER JOIN  PERSONAMAST  WITH(NOLOCK) ON CO.IdPaciente = PERSONAMAST.Persona                    
		LEFT JOIN   SS_GE_TipoAtencion  WITH(NOLOCK) ON 
                    SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
		LEFT JOIN   SS_TipoTrabajador  WITH(NOLOCK) ON 
                    SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador
		LEFT JOIN  CM_CO_Establecimiento  WITH(NOLOCK) ON
                    CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud
		LEFT JOIN  SS_HC_UnidadServicio  WITH(NOLOCK) ON 
                    SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
                               /****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/           
					AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
        LEFT JOIN  PERSONAMAST AS PERSONA_PERSSALUD  WITH(NOLOCK) ON 
                    PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud                    
        LEFT JOIN  SS_GE_Especialidad  WITH(NOLOCK) ON 
                    SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad                     
        LEFT JOIN  SS_GE_Diagnostico  
					        WITH(NOLOCK) ON SS_GE_Diagnostico.IdDiagnostico = CO.Codigo 
		left join  CM_CO_TablaMaestro  as TAB_DETERMDIAG WITH(NOLOCK) 
					 on 
					 (
						TAB_DETERMDIAG.CodigoTabla = 'TABDIAGNOSTICO'						 
					 )
		left join  CM_CO_TablaMaestroDetalle TAB_DETERMDIAGDET WITH(NOLOCK) 
					 on(
						TAB_DETERMDIAGDET.IdTablaMaestro = TAB_DETERMDIAG.IdTablaMaestro
						and TAB_DETERMDIAGDET.IdCodigo = CO.DeterminacionDiagnostica
					 )						
		left join  CM_CO_TablaMaestro  as TAB_DIAGPRINC WITH(NOLOCK) 
					 on 
					 (
						TAB_DIAGPRINC.CodigoTabla = 'TABCOLABORACION'						 
					 )
		left join  CM_CO_TablaMaestroDetalle TAB_DIAGPRINCDET WITH(NOLOCK) 
					 on(
						TAB_DIAGPRINCDET.IdTablaMaestro = TAB_DIAGPRINC.IdTablaMaestro
						and TAB_DIAGPRINCDET.IdCodigo = CO.IdDiagnosticoPrincipal
					 )
		left join   CM_CO_TablaMaestro  as TAB_GRADOAFEC WITH(NOLOCK) 
					 on 
					 (
						TAB_GRADOAFEC.CodigoTabla = 'DIAGAFECCION'						 
					 )
		left join  CM_CO_TablaMaestroDetalle TAB_GRADOAFECDET WITH(NOLOCK) 
					 on(
						TAB_GRADOAFECDET.IdTablaMaestro = TAB_GRADOAFEC.IdTablaMaestro
						and TAB_GRADOAFECDET.IdCodigo = CO.GradoAfeccion
					 )		
		left join   CM_CO_TablaMaestro  as TAB_ANTEC WITH(NOLOCK) 
					 on 
					 (
						TAB_ANTEC.CodigoTabla = 'DIAGANTECED'						 
					 )					
                      --ADD CMP  y RNE
        LEFT JOIN   EMPLEADOMAST  as EMPLEADO_PERSSALUD WITH(NOLOCK) 
                      ON EMPLEADO_PERSSALUD.Empleado = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
        LEFT JOIN   SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED WITH(NOLOCK) 
                      ON (ESPECIALIDAD_MED.IdMedico = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
						And ESPECIALIDAD_MED.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad
						)

GO
/****** Object:  View [dbo].[rptViewFichaAnestesia_1_ExamenesDetalle_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[rptViewFichaAnestesia_1_ExamenesDetalle_FE]
AS
			SELECT
			-- CO.CampoDescripcion,
			CO.UnidadReplicacion,
			CO.IdEpisodioAtencion,
			CO.IdPaciente,
			CO.EpisodioClinico,
			CO.UsuarioCreacion,
			CO.UsuarioModificacion,
			CO.FechaModificacion,
			CO.FechaCreacion,
			CO.Accion,
			CO.Version,
			--CO.Estado,
			 CM_CO_Componente.Nombre AS Examen,
			 CO.Codigo,
			 CO.Cantidad,
			 CO.Especificaciones,
			 CO.TipoExamen,
			CO.Secuencia,
		/**********ADD GENERALES****************/                      
            --(PERSONAS)
            PERSONAMAST.ApellidoPaterno,PERSONAMAST.ApellidoMaterno,PERSONAMAST.Nombres,PERSONAMAST.NombreCompleto, 
            PERSONAMAST.Busqueda,PERSONAMAST.TipoDocumento,PERSONAMAST.Documento,PERSONAMAST.FechaNacimiento, 
            PERSONAMAST.Sexo,PERSONAMAST.EstadoCivil,PERSONAMAST.edad as PersonaEdad
            --EPI ATENCIÓN
            ,SS_HC_EpisodioAtencion.IdOrdenAtencion
            ,SS_HC_EpisodioAtencion.CodigoOA
            ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
            ,SS_HC_EpisodioAtencion.TipoOrdenAtencion  AS TipoOrdenAtencionPac
            ,SS_HC_EpisodioAtencion.TipoAtencion
            ,SS_HC_EpisodioAtencion.TipoTrabajador                      
            ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
            ,SS_HC_EpisodioAtencion.IdUnidadServicio
            ,SS_HC_EpisodioAtencion.IdPersonalSalud
            ,SS_HC_EpisodioAtencion.FechaRegistro AS FechaRegistroPac
            ,SS_HC_EpisodioAtencion.FechaAtencion
            ,SS_HC_EpisodioAtencion.IdEspecialidad AS IdEspecialidadPac
            ,SS_HC_EpisodioAtencion.IdTipoOrden
            ,SS_HC_EpisodioAtencion.Estado as estadoEpiAtencion
            ,SS_HC_EpisodioAtencion.Accion as Expr101  --AUX
            ,SS_HC_EpisodioAtencion.ObservacionProxima as Expr102 --AUX
            ,SS_HC_EpisodioAtencion.Accion as Expr103 --AUX                      
            ,SS_GE_TipoAtencion.Descripcion as TipoAtencionDesc
            ,SS_TipoTrabajador.DescripcionLocal as TipoTrabajadorDesc
            ,CM_CO_Establecimiento.Codigo as EstablecimientoCodigo
            ,CM_CO_Establecimiento.Nombre as EstablecimientoDesc
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
		FROM SS_HC_AnestesiaExamenApoyoDetalle_FE CO WITH(NOLOCK) 
		INNER JOIN  SS_HC_EpisodioAtencion  WITH(NOLOCK) ON 
                    SS_HC_EpisodioAtencion.UnidadReplicacion = CO.UnidadReplicacion   AND
					 CO.IdEpisodioAtencion =(case when SS_HC_EpisodioAtencion.TipoAtencion IN (2,3) then
					SS_HC_EpisodioAtencion.IdEpisodioAtencion else SS_HC_EpisodioAtencion.EpisodioAtencion end) 
					AND
                    CO.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND
                    CO.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico
		INNER JOIN  PERSONAMAST  WITH(NOLOCK) ON CO.IdPaciente = PERSONAMAST.Persona                    
		LEFT JOIN   SS_GE_TipoAtencion  WITH(NOLOCK) ON 
                    SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
		LEFT JOIN  SS_TipoTrabajador  WITH(NOLOCK) ON 
                    SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador
		LEFT JOIN  CM_CO_Establecimiento  WITH(NOLOCK) ON
                    CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud
		LEFT JOIN  SS_HC_UnidadServicio  WITH(NOLOCK) ON 
                    SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
                               /****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/           
					AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
        LEFT JOIN  PERSONAMAST AS PERSONA_PERSSALUD  WITH(NOLOCK) ON 
                    PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud                    
        LEFT JOIN  SS_GE_Especialidad  WITH(NOLOCK) ON 
                    SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad 
		LEFT JOIN    CM_CO_Componente  WITH(NOLOCK) ON 
                    CM_CO_Componente.CodigoComponente =CO.Codigo
                      --ADD CMP  y RNE
        LEFT JOIN  EMPLEADOMAST  as EMPLEADO_PERSSALUD WITH(NOLOCK) 
                      ON EMPLEADO_PERSSALUD.Empleado = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
        LEFT JOIN  SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED WITH(NOLOCK) 
                      ON (ESPECIALIDAD_MED.IdMedico = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
						And ESPECIALIDAD_MED.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad
						)
GO
/****** Object:  View [dbo].[rptViewFichaAnestesia_1_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewFichaAnestesia_1_FE]
AS
SELECT    CV.*,        
                      /**********ADD GENERALES****************/                      
                      --(PERSONAS)
					 PM_RR.cmp AS Colegiatura_cirujano,
					 PM_RR.NombreCompleto AS nombrecirujano,					
					 PM_RS.cmp AS Colegiatura_Anestesiologo,
					 PM_RS.NombreCompleto AS nombreAnestesiologo,
					  PM_RA.cmp AS Colegiatura_Ayudante,
					  PM_RA.NombreCompleto AS nombreAyudante,
					    PM_INST.cmp AS Colegiatura_Instrumentista,
					  PM_INST.NombreCompleto AS nombreInstrumentista,					  
					  PM_CIRCULAN.cmp AS Colegiatura_EnfCirculante,
					  PM_CIRCULAN.NombreCompleto AS nombreEnfCirculante,					  
					    PM_NEONATOLO.cmp AS Colegiatura_Neonatologo,
					  PM_NEONATOLO.NombreCompleto AS nombreNeonatologo,
					      PM_CARDIOLOGO.cmp AS Colegiatura_Cardiologo,
					  PM_CARDIOLOGO.NombreCompleto AS nombreCardiologo,
					   dbo.PERSONAMAST.Telefono as ApellidoPaterno, 
					  dbo.PERSONAMAST.Celular as ApellidoMaterno, 
					  dbo.PERSONAMAST.Nombres, 
					  dbo.PERSONAMAST.NombreCompleto,  
					 PERSONAMAST.CorreoElectronico as Busqueda ,
					   dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.FechaNacimiento, 
                      dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.edad as PersonaEdad
                      --EPI ATENCIÓN
                      ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoOrdenAtencion  AS TipoOrdenAtencionPac
                      ,SS_HC_EpisodioAtencion.TipoAtencion
                      ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                      ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio
                      ,SS_HC_EpisodioAtencion.IdPersonalSalud
                      ,SS_HC_EpisodioAtencion.FechaRegistro
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      ,SS_HC_EpisodioAtencion.IdEspecialidad AS IdEspecialidadPac
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
		FROM       SS_HC_FichaAnestesia_1_FE CV
		INNER JOIN  SS_HC_EpisodioAtencion  WITH(NOLOCK) ON              SS_HC_EpisodioAtencion.UnidadReplicacion = CV.UnidadReplicacion   
					AND CV.IdEpisodioAtencion =(case when SS_HC_EpisodioAtencion.TipoAtencion IN (2,3) then
					SS_HC_EpisodioAtencion.IdEpisodioAtencion else SS_HC_EpisodioAtencion.EpisodioAtencion end) 
					AND CV.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente 
                    AND CV.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico
		INNER JOIN  PERSONAMAST  WITH(NOLOCK) ON CV.IdPaciente = PERSONAMAST.Persona  
		LEFT OUTER JOIN  PERSONAMAST PM_RR   WITH(NOLOCK) ON PM_RR.Persona = CV.IdMedico 
        LEFT OUTER JOIN PERSONAMAST PM_RS    WITH(NOLOCK) ON PM_RS.Persona = CV.Anestesiologo 
        LEFT OUTER JOIN PERSONAMAST PM_RA    WITH(NOLOCK) ON PM_RA.Persona = CV.Ayudante 
		LEFT OUTER JOIN PERSONAMAST PM_INST WITH(NOLOCK) 
                             ON PM_INST.Persona = CV.EnfInstrumentista
		LEFT OUTER JOIN PERSONAMAST PM_CIRCULAN WITH(NOLOCK) 
                             ON PM_CIRCULAN.Persona = CV.EnfCirculante						
		LEFT OUTER JOIN PERSONAMAST PM_NEONATOLO WITH(NOLOCK) 
                             ON PM_NEONATOLO.Persona = CV.Neonatologo							  
		LEFT OUTER JOIN PERSONAMAST PM_CARDIOLOGO WITH(NOLOCK) 
                             ON PM_CARDIOLOGO.Persona = CV.Cardiologo              
		LEFT JOIN   SS_GE_TipoAtencion  WITH(NOLOCK) ON 
                    SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
		LEFT JOIN   SS_TipoTrabajador  WITH(NOLOCK) ON 
                    SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador
		LEFT JOIN   CM_CO_Establecimiento  WITH(NOLOCK) ON
                    CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud
		LEFT JOIN   SS_HC_UnidadServicio  WITH(NOLOCK) ON 
                    SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
                               /****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/         
					 AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
        LEFT JOIN   PERSONAMAST AS PERSONA_PERSSALUD  WITH(NOLOCK) ON 
                    PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud                    
        LEFT JOIN   SS_GE_Especialidad  WITH(NOLOCK) ON 
                    SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad                     
        LEFT JOIN   EMPLEADOMAST AS EMPLEADO_PERSSALUD  WITH(NOLOCK) ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud                     
         LEFT JOIN  SS_GE_EspecialidadMedico AS ESPECIALIDAD_MED  WITH(NOLOCK) ON 
                    (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud AND
                    ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad)

GO
/****** Object:  View [dbo].[rptViewFichaAnestesia_3_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[rptViewFichaAnestesia_3_FE]
AS
SELECT    CV.*,  
                      /**********ADD GENERALES****************/                      
                      --(PERSONAS)
					   dbo.PERSONAMAST.Telefono as ApellidoPaterno, 
					  dbo.PERSONAMAST.Celular as ApellidoMaterno, 
					  dbo.PERSONAMAST.Nombres, 
					  dbo.PERSONAMAST.NombreCompleto, 
					 PERSONAMAST.CorreoElectronico as Busqueda ,
					   dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.FechaNacimiento, 
                      dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.edad as PersonaEdad
                      --EPI ATENCIÓN
                      ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoOrdenAtencion  AS TipoOrdenAtencionPac
                      ,SS_HC_EpisodioAtencion.TipoAtencion
                      ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                      ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio
                      ,SS_HC_EpisodioAtencion.IdPersonalSalud
                      ,SS_HC_EpisodioAtencion.FechaRegistro
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      ,SS_HC_EpisodioAtencion.IdEspecialidad AS IdEspecialidadPac
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
		FROM       SS_HC_FichaAnestesia_3_FE CV WITH(NOLOCK) 
		INNER JOIN  SS_HC_EpisodioAtencion  WITH(NOLOCK) ON 
                    SS_HC_EpisodioAtencion.UnidadReplicacion = CV.UnidadReplicacion   AND
				     CV.IdEpisodioAtencion =(case when SS_HC_EpisodioAtencion.TipoAtencion IN (2,3) then
					SS_HC_EpisodioAtencion.IdEpisodioAtencion else SS_HC_EpisodioAtencion.EpisodioAtencion end) 
					and                    CV.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND
                    CV.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico
		INNER JOIN  PERSONAMAST  WITH(NOLOCK) ON CV.IdPaciente = PERSONAMAST.Persona                    
		LEFT JOIN SS_GE_TipoAtencion  WITH(NOLOCK) ON 
                    SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
		LEFT JOIN
                    SS_TipoTrabajador  WITH(NOLOCK) ON 
                    SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador
		LEFT JOIN  CM_CO_Establecimiento  WITH(NOLOCK) ON
                    CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud
		LEFT JOIN  SS_HC_UnidadServicio  WITH(NOLOCK) ON 
                    SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
                               /****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/           AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
        LEFT JOIN  PERSONAMAST AS PERSONA_PERSSALUD  WITH(NOLOCK) ON 
                    PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud                    
        LEFT JOIN  SS_GE_Especialidad  WITH(NOLOCK) ON 
                    SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad                     
        LEFT JOIN
                    EMPLEADOMAST AS EMPLEADO_PERSSALUD  WITH(NOLOCK) ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud                     
        LEFT JOIN
                    SS_GE_EspecialidadMedico AS ESPECIALIDAD_MED  WITH(NOLOCK) ON 
                    (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud AND
                    ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad)

GO
/****** Object:  View [dbo].[rptViewFichaAnestesia2]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[rptViewFichaAnestesia2]
as
  Select	
		SS_HC_FichaAnestesia_2_FE.UnidadReplicacion,
		SS_HC_FichaAnestesia_2_FE.IdEpisodioAtencion,
		SS_HC_FichaAnestesia_2_FE.IdPaciente,
		SS_HC_FichaAnestesia_2_FE.EpisodioClinico,
		SS_HC_FichaAnestesia_2_FE.Respuesta1,
		SS_HC_FichaAnestesia_2_FE.Respuesta2,
		SS_HC_FichaAnestesia_2_FE.Respuesta3,
		SS_HC_FichaAnestesia_2_FE.Respuesta4,
		SS_HC_FichaAnestesia_2_FE.Respuesta5,
		SS_HC_FichaAnestesia_2_FE.Respuesta6,
		SS_HC_FichaAnestesia_2_FE.Respuesta7,
	
		SS_HC_FichaAnestesia_2_FE.Respuesta8,
		SS_HC_FichaAnestesia_2_FE.Respuesta9,
		SS_HC_FichaAnestesia_2_FE.Respuesta10,
		SS_HC_FichaAnestesia_2_FE.Respuesta11,
		SS_HC_FichaAnestesia_2_FE.Respuesta12,
		SS_HC_FichaAnestesia_2_FE.Respuesta13,
		SS_HC_FichaAnestesia_2_FE.Respuesta14,
		SS_HC_FichaAnestesia_2_FE.Respuesta15,
		SS_HC_FichaAnestesia_2_FE.Respuesta16,
		SS_HC_FichaAnestesia_2_FE.Respuesta17,
		SS_HC_FichaAnestesia_2_FE.Respuesta18,
		SS_HC_FichaAnestesia_2_FE.Respuesta19,
		SS_HC_FichaAnestesia_2_FE.Respuesta20,
		SS_HC_FichaAnestesia_2_FE.TET ,
		SS_HC_FichaAnestesia_2_FE.M_Facial ,
		SS_HC_FichaAnestesia_2_FE.M_Laringea ,
	
		SS_HC_FichaAnestesia_2_FE.Respuesta21,
		SS_HC_FichaAnestesia_2_FE.Respuesta22,
	
		SS_HC_FichaAnestesia_2_FE.Respuesta23,
		SS_HC_FichaAnestesia_2_FE.Respuesta24,
		SS_HC_FichaAnestesia_2_FE.Respuesta25,
		SS_HC_FichaAnestesia_2_FE.Respuesta26,
		SS_HC_FichaAnestesia_2_FE.Respuesta27,
		SS_HC_FichaAnestesia_2_FE.Respuesta28,
		SS_HC_FichaAnestesia_2_FE.Respuesta29,
		SS_HC_FichaAnestesia_2_FE.Respuesta30,
		SS_HC_FichaAnestesia_2_FE.Respuesta31,
		SS_HC_FichaAnestesia_2_FE.CATVenoso ,
		SS_HC_FichaAnestesia_2_FE.PVCCAT ,
		SS_HC_FichaAnestesia_2_FE.Respuesta32,
		SS_HC_FichaAnestesia_2_FE.Respuesta33,
		SS_HC_FichaAnestesia_2_FE.Respuesta34,
		SS_HC_FichaAnestesia_2_FE.Respuesta35,
		SS_HC_FichaAnestesia_2_FE.Respuesta36,
		SS_HC_FichaAnestesia_2_FE.Respuesta37,
		SS_HC_FichaAnestesia_2_FE.Respuesta38,
		SS_HC_FichaAnestesia_2_FE.Respuesta39,
		SS_HC_FichaAnestesia_2_FE.Respuesta40,
		SS_HC_FichaAnestesia_2_FE.Respuesta41,
		SS_HC_FichaAnestesia_2_FE.Posicion_Otros ,
		SS_HC_FichaAnestesia_2_FE.Fec_Ini_Anestesia ,
		convert(char(6), SS_HC_FichaAnestesia_2_FE.Hor_Ini_Anestesia, 108) as Hor_Ini_Anestesia	 ,
		SS_HC_FichaAnestesia_2_FE.Fec_Fin_Anestesia ,
		convert(char(6), SS_HC_FichaAnestesia_2_FE.Hor_Fin_Anestesia, 108) as Hor_Fin_Anestesia	 ,
		SS_HC_FichaAnestesia_2_FE.Fec_Ini_Cirugia ,
		convert(char(6), SS_HC_FichaAnestesia_2_FE.Hor_Ini_Cirugia, 108) as Hor_Ini_Cirugia	 ,
		SS_HC_FichaAnestesia_2_FE.Fec_Fin_Cirugia  ,
		convert(char(6), SS_HC_FichaAnestesia_2_FE.Hor_Fin_Cirugia, 108) as Hor_Fin_Cirugia	 ,
		SS_HC_FichaAnestesia_2_FE.Respuesta42,
		SS_HC_FichaAnestesia_2_FE.Accion,
		
		--Datos generales 
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
		SS_HC_EpisodioAtencion.ObservacionProxima AS ObservacionProximaEpiAtencion,
		SS_GE_TipoAtencion.Descripcion AS TipoAtencionDesc,
		SS_TipoTrabajador.DescripcionLocal AS TipoTrabajadorDesc,
		CM_CO_Establecimiento.Codigo AS EstablecimientoCodigo, 
		CM_CO_Establecimiento.Nombre AS EstablecimientoDesc,
	 	SS_HC_UnidadServicio.Codigo AS UnidadServicioCodigo, 
		SS_HC_UnidadServicio.Descripcion AS UnidadServicioDesc
  
  	 from  SS_HC_FichaAnestesia_2_FE 


		left JOIN PERSONAMAST 
			ON SS_HC_FichaAnestesia_2_FE.IdPaciente = PERSONAMAST.Persona 
		INNER JOIN SS_HC_EpisodioAtencion 
			ON SS_HC_FichaAnestesia_2_FE.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion AND 
				SS_HC_FichaAnestesia_2_FE.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND 
				SS_HC_FichaAnestesia_2_FE.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND 
				SS_HC_FichaAnestesia_2_FE.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
		left outer join	SS_GE_TipoAtencion 
			on SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion 
		left outer join SS_TipoTrabajador 
			on SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador 
		left outer join	CM_CO_Establecimiento 
			on CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud 
		left outer join SS_HC_UnidadServicio
            on SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
               and CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud -- Validacion
              		left JOIN PERSONAMAST MED
			ON SS_HC_EpisodioAtencion.IdPersonalSalud = MED.Persona  

                  






GO
/****** Object:  View [dbo].[rptViewFichaAnestesia5]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[rptViewFichaAnestesia5]

as
  Select	
		SS_HC_FichaAnestesia_5_FE.UnidadReplicacion,
		SS_HC_FichaAnestesia_5_FE.IdEpisodioAtencion,
		SS_HC_FichaAnestesia_5_FE.IdPaciente,
		SS_HC_FichaAnestesia_5_FE.EpisodioClinico,
		SS_HC_FichaAnestesia_5_FE.Observaciones,
		SS_HC_FichaAnestesia_5_FE.GasasCompletas,
		SS_HC_FichaAnestesia_5_FE.GasasIncompletas,
		SS_HC_FichaAnestesia_5_FE.Respuesta1,
		SS_HC_FichaAnestesia_5_FE.Respuesta2,
		SS_HC_FichaAnestesia_5_FE.Respuesta3,		
		SS_HC_FichaAnestesia_5_FE.Paciente_Dev_Otros,
		SS_HC_FichaAnestesia_5_FE.Paciente_Prov_Otros,
		SS_HC_FichaAnestesia_5_FE.Accion,				
		--Datos generales 
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
		SS_HC_EpisodioAtencion.ObservacionProxima AS ObservacionProximaEpiAtencion,
		SS_GE_TipoAtencion.Descripcion AS TipoAtencionDesc,
		SS_TipoTrabajador.DescripcionLocal AS TipoTrabajadorDesc,
		CM_CO_Establecimiento.Codigo AS EstablecimientoCodigo, 
		CM_CO_Establecimiento.Nombre AS EstablecimientoDesc,
	 	SS_HC_UnidadServicio.Codigo AS UnidadServicioCodigo, 
		SS_HC_UnidadServicio.Descripcion AS UnidadServicioDesc  
  	 from  SS_HC_FichaAnestesia_5_FE  WITH(NOLOCK) 		
	 INNER JOIN SS_HC_EpisodioAtencion  WITH(NOLOCK) 
			ON SS_HC_FichaAnestesia_5_FE.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion AND 
				SS_HC_FichaAnestesia_5_FE.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND 
				SS_HC_FichaAnestesia_5_FE.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND 
				SS_HC_FichaAnestesia_5_FE.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
		left JOIN PERSONAMAST  WITH(NOLOCK) 
			ON SS_HC_FichaAnestesia_5_FE.IdPaciente = PERSONAMAST.Persona 
		left outer join	SS_GE_TipoAtencion  WITH(NOLOCK) 
			on SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion 
		left outer join SS_TipoTrabajador  WITH(NOLOCK) 
			on SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador 
		left outer join	CM_CO_Establecimiento  WITH(NOLOCK) 
			on CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud 
		left outer join SS_HC_UnidadServicio WITH(NOLOCK) 
            on SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
               and CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud -- Validacion
        left JOIN PERSONAMAST MED WITH(NOLOCK) 
			ON SS_HC_EpisodioAtencion.IdPersonalSalud = MED.Persona  

GO
/****** Object:  View [dbo].[rptViewFuncionesVitales_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewFuncionesVitales_FE]
AS
SELECT FV.*,
 /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.Nombres, dbo.PERSONAMAST.NombreCompleto, 
                      dbo.PERSONAMAST.Busqueda, dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.FechaNacimiento, 
                      dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.edad as PersonaEdad
                      --EPI ATENCIÓN
                      ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoOrdenAtencion  AS TipoOrdenAtencionPac
                      ,SS_HC_EpisodioAtencion.TipoAtencion
                      ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                      ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio
                      ,SS_HC_EpisodioAtencion.IdPersonalSalud
                      ,SS_HC_EpisodioAtencion.FechaRegistro AS FechaRegistroPac
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      ,SS_HC_EpisodioAtencion.IdEspecialidad AS IdEspecialidadPac
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
                           
FROM SS_HC_FuncionesVitales_FE FV
INNER JOIN  SS_HC_EpisodioAtencion ON 
                    SS_HC_EpisodioAtencion.UnidadReplicacion = FV.UnidadReplicacion   AND
                    FV.IdEpisodioAtencion = SS_HC_EpisodioAtencion.EpisodioAtencion AND --IdEpisodioAtencion AND
                    FV.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND
                    FV.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico
INNER JOIN  PERSONAMAST ON FV.IdPaciente = PERSONAMAST.Persona                    
LEFT JOIN SS_GE_TipoAtencion ON 
                    SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
LEFT JOIN
                    SS_TipoTrabajador ON 
                    SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador
LEFT JOIN  CM_CO_Establecimiento ON
                    CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud

LEFT JOIN  SS_HC_UnidadServicio ON 
                    SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
                               /****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/           AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
                    LEFT JOIN  PERSONAMAST AS PERSONA_PERSSALUD ON 
                    PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
                    
                    LEFT JOIN  SS_GE_Especialidad ON 
                    SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad 
                    
                    --LEFT JOIN
                    --SS_GE_ProcedimientoMedico ON 
                    --(SS_GE_ProcedimientoMedico.IdProcedimiento = SC.IdProcedimiento AND SC.TipoCodigo = 'C')
                    
                    LEFT JOIN
                    EMPLEADOMAST AS EMPLEADO_PERSSALUD ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud 
                    
                    LEFT JOIN
                    SS_GE_EspecialidadMedico AS ESPECIALIDAD_MED ON 
                    (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud AND
                    ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad)






GO
/****** Object:  View [dbo].[rptViewGradoDependencia_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[rptViewGradoDependencia_FE]
AS
SELECT GD.*,
/**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.Nombres, dbo.PERSONAMAST.NombreCompleto, 
                      dbo.PERSONAMAST.Busqueda, dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.FechaNacimiento, 
                      dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.edad as PersonaEdad
                      --EPI ATENCIÓN
                      ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoOrdenAtencion  AS TipoOrdenAtencionPac
                      ,SS_HC_EpisodioAtencion.TipoAtencion
                      ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                      ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio
                      ,SS_HC_EpisodioAtencion.IdPersonalSalud
                      ,SS_HC_EpisodioAtencion.FechaRegistro AS FechaRegistroPac
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      ,SS_HC_EpisodioAtencion.IdEspecialidad AS IdEspecialidadPac
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
FROM SS_HC_Evaluacion_GradoDependencia_FE GD
INNER JOIN  SS_HC_EpisodioAtencion ON 
                    SS_HC_EpisodioAtencion.UnidadReplicacion = GD.UnidadReplicacion   AND
                    GD.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND
                    GD.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND
                    GD.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico
INNER JOIN  PERSONAMAST ON GD.IdPaciente = PERSONAMAST.Persona                    
LEFT JOIN SS_GE_TipoAtencion ON 
                    SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
LEFT JOIN
                    SS_TipoTrabajador ON 
                    SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador
LEFT JOIN  CM_CO_Establecimiento ON
                    CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud

LEFT JOIN  SS_HC_UnidadServicio ON 
                    SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
                               /****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/           AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
                    LEFT JOIN  PERSONAMAST AS PERSONA_PERSSALUD ON 
                    PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
                    
                    LEFT JOIN  SS_GE_Especialidad ON 
                    SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad 
                    
                    --LEFT JOIN
                    --SS_GE_ProcedimientoMedico ON 
                    --(SS_GE_ProcedimientoMedico.IdProcedimiento = SC.IdProcedimiento AND SC.TipoCodigo = 'C')
                    
                    LEFT JOIN
                    EMPLEADOMAST AS EMPLEADO_PERSSALUD ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud 
                    
                    LEFT JOIN
                    SS_GE_EspecialidadMedico AS ESPECIALIDAD_MED ON 
                    (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud AND
                    ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad)
GO
/****** Object:  View [dbo].[rptViewInformeAlta_DatosGenerales_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[rptViewInformeAlta_DatosGenerales_FE]
AS
SELECT DISTINCT 
    IA.*,

    -- Descripción de Tipo de Atención
    CASE IA.IdEspecialidad 
        WHEN '1' THEN 'Consulta'
        WHEN '2' THEN 'Eme. Médica'
        WHEN '3' THEN 'Eme. Accidental'
        WHEN '4' THEN 'Eme. Obsterica'
        WHEN '5' THEN 'Complic. Embarazo'
    END AS TipoAtencionDesc,

    -- Descripción de Tipo de Alta
    CASE IA.IdTipoAlta 
        WHEN '1' THEN 'Indicación Medica'
        WHEN '2' THEN 'Referencia'
        WHEN '3' THEN 'Voluntaria'
        WHEN '6' THEN 'Se Hospitaliza'
    END AS TipoAlta,

    -- Descripción de Pronóstico
    CASE IA.IdPronostico 
        WHEN '1' THEN 'Bueno'
        WHEN '2' THEN 'Reservado'
        WHEN '3' THEN 'Malo'
    END AS Pronostico,

    -- Diagnóstico de Ingreso
    STUFF((
        SELECT DISTINCT ', ' + B.DiagnosticoDescripcion
        FROM SS_HC_InformeAlta_FE A WITH (NOLOCK)
        INNER JOIN SS_HC_InformeAltaDiagIng_FE B WITH (NOLOCK)
            ON A.UnidadReplicacion = B.UnidadReplicacion
            AND A.IdEpisodioAtencion = B.IdEpisodioAtencion
            AND A.IdPaciente = B.IdPaciente
            AND A.EpisodioClinico = B.EpisodioClinico
        WHERE IA.IdPaciente = B.IdPaciente
            AND IA.EpisodioClinico = B.EpisodioClinico
            AND IA.IdEpisodioAtencion = B.IdEpisodioAtencion
        FOR XML PATH(''), TYPE).value('.', 'varchar(max)')
    , 1, 2, '') AS DiagnosticoIngreso,

    -- Diagnóstico de Alta
    STUFF((
        SELECT ', ' + B.DiagnosticoDescripcion
        FROM SS_HC_InformeAlta_FE A WITH (NOLOCK)
        INNER JOIN SS_HC_InformeAltaDiagAlt_FE B WITH (NOLOCK)
            ON A.UnidadReplicacion = B.UnidadReplicacion
            AND A.IdEpisodioAtencion = B.IdEpisodioAtencion
            AND A.IdPaciente = B.IdPaciente
            AND A.EpisodioClinico = B.EpisodioClinico
        WHERE IA.IdPaciente = B.IdPaciente
            AND IA.EpisodioClinico = B.EpisodioClinico
            AND IA.IdEpisodioAtencion = B.IdEpisodioAtencion
        FOR XML PATH(''), TYPE).value('.', 'varchar(max)')
    , 1, 2, '') AS DiagnosticoAlta,

    -- Apoyo Diagnóstico
    STUFF((
        SELECT DISTINCT ', ' + B.ExamenDescripcion
        FROM SS_HC_InformeAlta_FE A WITH (NOLOCK)
        INNER JOIN SS_HC_InformeAltaAPD_FE B WITH (NOLOCK)
            ON A.UnidadReplicacion = B.UnidadReplicacion
            AND A.IdEpisodioAtencion = B.IdEpisodioAtencion
            AND A.IdPaciente = B.IdPaciente
            AND A.EpisodioClinico = B.EpisodioClinico
        WHERE IA.IdPaciente = B.IdPaciente
            AND IA.EpisodioClinico = B.EpisodioClinico
            AND IA.IdEpisodioAtencion = B.IdEpisodioAtencion
        FOR XML PATH(''), TYPE).value('.', 'varchar(max)')
    , 1, 2, '') AS DiagnosticoApoyoDiag

FROM SS_HC_InformeAlta_FE AS IA WITH (NOLOCK);
GO

GO
/****** Object:  View [dbo].[rptViewInformeAlta_proxCita]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[rptViewInformeAlta_proxCita]
as
SELECT 
PA_FE.*,
ESP.Descripcion
FROM SS_HC_InformeAltaProxCita_FE AS  PA_FE  WITH(NOLOCK) 
inner join SS_GE_Especialidad AS ESP  WITH(NOLOCK) on PA_FE.IdEspecialidad= ESP.IdEspecialidad

GO
/****** Object:  View [dbo].[rptViewInmunizacionAdulto_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[rptViewInmunizacionAdulto_FE]
AS
	SELECT       
	dbo.SS_HC_AntecedentesPersonalesIAdul_FE.UnidadReplicacion, 
	dbo.SS_HC_AntecedentesPersonalesIAdul_FE.IdEpisodioAtencion, 
	dbo.SS_HC_AntecedentesPersonalesIAdul_FE.IdPaciente,
	dbo.SS_HC_AntecedentesPersonalesIAdul_FE.EpisodioClinico, 
	dbo.SS_HC_AntecedentesPersonalesIAdul_FE.CodigoSecuencia, 
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.VacunaNinioFlag WHEN 'S' THEN 'X' ELSE '' END) AS SI, 
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.VacunaNinioFlag WHEN 'N' THEN 'X' ELSE '' END) AS NO,
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.DPT_1era_flag WHEN 'S' THEN 'X' ELSE '' END) AS DPT_1era, 
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.DPT_2da_flag WHEN 'S' THEN 'X' ELSE '' END) AS DPT_2da, 
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.DPT_3era_flag WHEN 'S' THEN 'X' ELSE '' END) AS DPT_3era, 
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.DPT_NoRecuerda_flag WHEN 'S' THEN 'X' ELSE '' END) AS DPT_NoRecuerda, 
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.SRP_1era_flag WHEN 'S' THEN 'X' ELSE '' END) AS SRP_1era, 
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.SRP_NoRecuerda_flag WHEN 'S' THEN 'X' ELSE '' END) AS SRP_NoRecuerda, 
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.VARICELA_1era_flag WHEN 'S' THEN 'X' ELSE '' END) AS VARICELA_1era, 
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.VARICELA_NoRecuerda_flag WHEN 'S' THEN 'X' ELSE '' END) AS VARICELA_NoRecuerda, 
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.HEPATITISB_1era_flag WHEN 'S' THEN 'X' ELSE '' END) AS HEPATITISB_1era, 
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.HEPATITISB_2da_flag WHEN 'S' THEN 'X' ELSE '' END) AS HEPATITISB_2da, 
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.HEPATITISB_3era_flag WHEN 'S' THEN 'X' ELSE '' END) AS HEPATITISB_3era, 
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.HEPATITISB_1erRef_flag WHEN 'S' THEN 'X' ELSE '' END) AS HEPATITISB_1erRef, 
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.HEPATITISB_NoRecuerda_flag WHEN 'S' THEN 'X' ELSE '' END) AS HEPATITISB_NoRecuerda,
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.HEPATITISA_1era_flag WHEN 'S' THEN 'X' ELSE '' END) AS HEPATITISA_1era, 
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.HEPATITISA_2da_flag WHEN 'S' THEN 'X' ELSE '' END) AS HEPATITISA_2da, 
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.HEPATITISA_NoRecuerda_flag WHEN 'S' THEN 'X' ELSE '' END) AS HEPATITISA_NoRecuerda, 
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.NEUMOCOCO_1era_flag WHEN 'S' THEN 'X' ELSE '' END) AS NEUMOCOCO_1era, 
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.NEUMOCOCO_2da_flag WHEN 'S' THEN 'X' ELSE '' END) AS NEUMOCOCO_2da, 
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.NEUMOCOCO_3era_flag WHEN 'S' THEN 'X' ELSE '' END) AS NEUMOCOCO_3era, 
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.NEUMOCOCO_NoRecuerda_flag WHEN 'S' THEN 'X' ELSE '' END) AS NEUMOCOCO_NoRecuerda, 
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.[Antitetanica_1era_flag] WHEN 'S' THEN 'X' ELSE '' END) AS [Antitetanica_1era], 
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.[Antitetanica_2da_flag] WHEN 'S' THEN 'X' ELSE '' END) AS [Antitetanica_2da], 
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.[Antitetanica_3era_flag] WHEN 'S' THEN 'X' ELSE '' END) AS [Antitetanica_3era], 
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.[Antitetanica_NoRecuerda_flag] WHEN 'S' THEN 'X' ELSE '' END) AS [Antitetanica_NoRecuerda], 

	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.[Papiloma_1era_flag] WHEN 'S' THEN 'X' ELSE '' END) AS [Papiloma_1era], 
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.[Papiloma_2da_flag] WHEN 'S' THEN 'X' ELSE '' END) AS [Papiloma_2da], 
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.[Papiloma_3era_flag] WHEN 'S' THEN 'X' ELSE '' END) AS [Papiloma_3era], 
	(CASE SS_HC_AntecedentesPersonalesIAdul_FE.[Papiloma_NoRecuerda_flag] WHEN 'S' THEN 'X' ELSE '' END) AS [Papiloma_NoRecuerda], 

	(CASE  SS_HC_AntecedentesPersonalesIAdul_FE.INFLUENZA_flag_Recuerda WHEN 'S' THEN 'X' ELSE '' END) AS   INFLUENZA_SI  , 
	(CASE  SS_HC_AntecedentesPersonalesIAdul_FE.INFLUENZA_flag_Recuerda WHEN 'N' THEN 'X' ELSE '' END) AS   INFLUENZA_NO  , 
	(CASE  SS_HC_AntecedentesPersonalesIAdul_FE.INFLUENZA_flag_Recuerda WHEN 'R' THEN 'X' ELSE '' END) AS   INFLUENZA_RE  , 
	 SS_HC_AntecedentesPersonalesIAdul_FE.ValorOpcional , 

	SS_HC_AntecedentesPersonalesIAdul_FE.INFLUENZA  as INFLUENZA,
	dbo.SS_HC_AntecedentesPersonalesIAdul_FE.Estado, 
	dbo.SS_HC_AntecedentesPersonalesIAdul_FE.UsuarioCreacion, 
	dbo.SS_HC_AntecedentesPersonalesIAdul_FE.FechaCreacion, 
	dbo.SS_HC_AntecedentesPersonalesIAdul_FE.UsuarioModificacion, 
	dbo.SS_HC_AntecedentesPersonalesIAdul_FE.FechaModificacion, 
	dbo.SS_HC_AntecedentesPersonalesIAdul_FE.Accion, 
	dbo.SS_HC_AntecedentesPersonalesIAdul_FE.Version, 
	dbo.SS_HC_AntecedentesPersonalesIAdulDetalle_FE.IdEpisodioAtencion AS IdEpisodioAtencionDet, 
	dbo.SS_HC_AntecedentesPersonalesIAdulDetalle_FE.IdPaciente AS IdPacienteDet, 
	dbo.SS_HC_AntecedentesPersonalesIAdulDetalle_FE.EpisodioClinico AS EpisodioClinicoDet, 
	dbo.SS_HC_AntecedentesPersonalesIAdulDetalle_FE.UnidadReplicacion AS UnidadReplicacionDet,
	dbo.SS_HC_AntecedentesPersonalesIAdulDetalle_FE.Secuencia, 
	dbo.SS_HC_AntecedentesPersonalesIAdulDetalle_FE.OtrasVacunas, 
	dbo.SS_HC_AntecedentesPersonalesIAdulDetalle_FE.UsuarioCreacion AS UsuarioCreacionDet, 
	dbo.SS_HC_AntecedentesPersonalesIAdulDetalle_FE.FechaCreacion AS FechaCreacionDet, 
	dbo.SS_HC_AntecedentesPersonalesIAdulDetalle_FE.UsuarioModificacion AS UsuarioModificacionDet, 
	dbo.SS_HC_AntecedentesPersonalesIAdulDetalle_FE.FechaModificacion AS FechaModificacionDet, 
	dbo.SS_HC_AntecedentesPersonalesIAdulDetalle_FE.Accion AS AccionDet, 
	dbo.SS_HC_AntecedentesPersonalesIAdulDetalle_FE.Version AS VersionDet
	FROM           
        dbo.SS_HC_AntecedentesPersonalesIAdul_FE WITH(NOLOCK) 
        LEFT JOIN  dbo.SS_HC_AntecedentesPersonalesIAdulDetalle_FE 
        WITH(NOLOCK) ON  dbo.SS_HC_AntecedentesPersonalesIAdul_FE.UnidadReplicacion = dbo.SS_HC_AntecedentesPersonalesIAdulDetalle_FE.UnidadReplicacion AND 
            dbo.SS_HC_AntecedentesPersonalesIAdul_FE.IdEpisodioAtencion = dbo.SS_HC_AntecedentesPersonalesIAdulDetalle_FE.IdEpisodioAtencion AND 
            dbo.SS_HC_AntecedentesPersonalesIAdul_FE.IdPaciente = dbo.SS_HC_AntecedentesPersonalesIAdulDetalle_FE.IdPaciente AND 
            dbo.SS_HC_AntecedentesPersonalesIAdul_FE.EpisodioClinico = dbo.SS_HC_AntecedentesPersonalesIAdulDetalle_FE.EpisodioClinico

GO

/****** Object:  View [dbo].[rptViewInmunizacionNinio_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[rptViewInmunizacionNinio_FE]
AS
SELECT     dbo.SS_HC_AntecedentesPersonalesIN_FE.UnidadReplicacion, dbo.SS_HC_AntecedentesPersonalesIN_FE.IdEpisodioAtencion, 
            dbo.SS_HC_AntecedentesPersonalesIN_FE.EpisodioClinico, dbo.SS_HC_AntecedentesPersonalesIN_FE.CodigoSecuencia, 
            dbo.SS_HC_AntecedentesPersonalesIN_FE.IdPaciente, (CASE SS_HC_AntecedentesPersonalesIN_FE.VacunaNinioFlag WHEN 'S' THEN 'X' ELSE '' END) AS SI, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.VacunaNinioFlag WHEN 'N' THEN 'X' ELSE '' END) AS NO, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.BCG_RN_flag WHEN 'S' THEN 'X' ELSE '' END) AS BCG_RN, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.BCG_NoRecuerda_flag WHEN 'S' THEN 'X' ELSE '' END) AS BCG_NoRecuerda, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.HepatitisBRN_RN_flag WHEN 'S' THEN 'X' ELSE '' END) AS HepatitisBRN_RN, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.HepatitisBRN_NoRecuerda_flag WHEN 'S' THEN 'X' ELSE '' END) AS HepatitisBRN_NoRecuerda, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.DPT_1era_flag WHEN 'S' THEN 'X' ELSE '' END) AS DPT_1era, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.DPT_2da_flag WHEN 'S' THEN 'X' ELSE '' END) AS DPT_2da, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.DPT_3era_flag WHEN 'S' THEN 'X' ELSE '' END) AS DPT_3era, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.DPT_1erRef_flag WHEN 'S' THEN 'X' ELSE '' END) AS DPT_1erRef, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.DPT_2doRef_flag WHEN 'S' THEN 'X' ELSE '' END) AS DPT_2doRef, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.DPT_NoRecuerda_flag WHEN 'S' THEN 'X' ELSE '' END) AS DPT_NoRecuerda, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.POLIO_1era_flag WHEN 'S' THEN 'X' ELSE '' END) AS POLIO_1era, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.POLIO_2da_flag WHEN 'S' THEN 'X' ELSE '' END) AS POLIO_2da, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.POLIO_3era_flag WHEN 'S' THEN 'X' ELSE '' END) AS POLIO_3era, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.POLIO_1erRef_flag WHEN 'S' THEN 'X' ELSE '' END) AS POLIO_1erRef, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.POLIO_2doRef_flag WHEN 'S' THEN 'X' ELSE '' END) AS POLIO_2doRef, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.POLIO_NoRecuerda_flag WHEN 'S' THEN 'X' ELSE '' END) AS POLIO_NoRecuerda, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.HiB_1era_flag WHEN 'S' THEN 'X' ELSE '' END) AS HiB_1era, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.HiB_2da_flag WHEN 'S' THEN 'X' ELSE '' END) AS HiB_2da, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.HiB_3era_flag WHEN 'S' THEN 'X' ELSE '' END) AS HiB_3era, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.HiB_1erRef_flag WHEN 'S' THEN 'X' ELSE '' END) AS HiB_1erRef, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.HiB_2doRef_flag WHEN 'S' THEN 'X' ELSE '' END) AS HiB_2doRef, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.HiB_NoRecuerda_flag WHEN 'S' THEN 'X' ELSE '' END) AS HiB_NoRecuerda, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.HEPATITISB_1era_flag WHEN 'S' THEN 'X' ELSE '' END) AS HEPATITISB_1era, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.HEPATITISB_2da_flag WHEN 'S' THEN 'X' ELSE '' END) AS HEPATITISB_2da, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.HEPATITISB_3era_flag WHEN 'S' THEN 'X' ELSE '' END) AS HEPATITISB_3era, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.HEPATITISB_1erRef_flag WHEN 'S' THEN 'X' ELSE '' END) AS HEPATITISB_1erRef, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.HEPATITISB_NoRecuerda_flag WHEN 'S' THEN 'X' ELSE '' END) AS HEPATITISB_NoRecuerda, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.ROTAVIRUS_1era_flag WHEN 'S' THEN 'X' ELSE '' END) AS ROTAVIRUS_1era, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.ROTAVIRUS_2da_flag WHEN 'S' THEN 'X' ELSE '' END) AS ROTAVIRUS_2da, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.ROTAVIRUS_3era_flag WHEN 'S' THEN 'X' ELSE '' END) AS ROTAVIRUS_3era, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.ROTAVIRUS_1erRef_flag WHEN 'S' THEN 'X' ELSE '' END) AS ROTAVIRUS_1erRef, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.ROTAVIRUS_2doRef_flag WHEN 'S' THEN 'X' ELSE '' END) AS ROTAVIRUS_2doRef, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.ROTAVIRUS_NoRecuerda_flag WHEN 'S' THEN 'X' ELSE '' END) AS ROTAVIRUS_NoRecuerda, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.SRP_1era_flag WHEN 'S' THEN 'X' ELSE '' END) AS SRP_1era, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.SRP_2da_flag WHEN 'S' THEN 'X' ELSE '' END) AS SRP_2da, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.SRP_NoRecuerda_flag WHEN 'S' THEN 'X' ELSE '' END) AS SRP_NoRecuerda, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.VARICELA_1era_flag WHEN 'S' THEN 'X' ELSE '' END) AS VARICELA_1era, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.VARICELA_2da_flag WHEN 'S' THEN 'X' ELSE '' END) AS VARICELA_2da, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.VARICELA_NoRecuerda_flag WHEN 'S' THEN 'X' ELSE '' END) AS VARICELA_NoRecuerda, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.HEPATITISA_1era_flag WHEN 'S' THEN 'X' ELSE '' END) AS HEPATITISA_1era, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.HEPATITISA_2da_flag WHEN 'S' THEN 'X' ELSE '' END) AS HEPATITISA_2da, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.HEPATITISA_NoRecuerda_flag WHEN 'S' THEN 'X' ELSE '' END) AS HEPATITISA_NoRecuerda, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.NEUMOCOCO_1era_flag WHEN 'S' THEN 'X' ELSE '' END) AS NEUMOCOCO_1era, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.NEUMOCOCO_2da_flag WHEN 'S' THEN 'X' ELSE '' END) AS NEUMOCOCO_2da, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.NEUMOCOCO_3era_flag WHEN 'S' THEN 'X' ELSE '' END) AS NEUMOCOCO_3era, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.NEUMOCOCO_1erRef_flag WHEN 'S' THEN 'X' ELSE '' END) AS NEUMOCOCO_1erRef, 
            (CASE SS_HC_AntecedentesPersonalesIN_FE.NEUMOCOCO_NoRecuerda_flag WHEN 'S' THEN 'X' ELSE '' END) AS NEUMOCOCO_NoRecuerda, 
                        (CASE  SS_HC_AntecedentesPersonalesIN_FE.INFLUENZA_flag_Recuerda WHEN 'S' THEN 'X' ELSE '' END) AS   INFLUENZA_SI  , 
                        (CASE  SS_HC_AntecedentesPersonalesIN_FE.INFLUENZA_flag_Recuerda WHEN 'N' THEN 'X' ELSE '' END) AS   INFLUENZA_NO  , 
                            (CASE  SS_HC_AntecedentesPersonalesIN_FE.INFLUENZA_flag_Recuerda WHEN 'R' THEN 'X' ELSE '' END) AS   INFLUENZA_RE  , 
                        SS_HC_AntecedentesPersonalesIN_FE.ValorOpcional , 
            dbo.SS_HC_AntecedentesPersonalesIN_FE.INFLUENZA, dbo.SS_HC_AntecedentesPersonalesIN_FE.Estado, 
            dbo.SS_HC_AntecedentesPersonalesIN_FE.UsuarioCreacion, dbo.SS_HC_AntecedentesPersonalesIN_FE.FechaCreacion, 
            dbo.SS_HC_AntecedentesPersonalesIN_FE.UsuarioModificacion, dbo.SS_HC_AntecedentesPersonalesIN_FE.FechaModificacion, 
            dbo.SS_HC_AntecedentesPersonalesIN_FE.Accion, dbo.SS_HC_AntecedentesPersonalesIN_FE.Version,                       
            ISNULL( dbo.SS_HC_AntecedentesPersonalesINDetalle_FE.IdEpisodioAtencion,0) AS IdEpisodioAtencionDet, 
            ISNULL(dbo.SS_HC_AntecedentesPersonalesINDetalle_FE.IdPaciente,0) AS IdPacienteDet, 
            ISNULL(dbo.SS_HC_AntecedentesPersonalesINDetalle_FE.EpisodioClinico,0) AS EpisodioClinicoDet, 
            ISNULL(dbo.SS_HC_AntecedentesPersonalesINDetalle_FE.UnidadReplicacion,'') AS UnidadReplicacionDet,
            ISNULL(dbo.SS_HC_AntecedentesPersonalesINDetalle_FE.Secuencia,0) AS Secuencia, 
            dbo.SS_HC_AntecedentesPersonalesINDetalle_FE.OtrasVacunas, dbo.SS_HC_AntecedentesPersonalesINDetalle_FE.UsuarioCreacion AS UsuarioCreacionDet, 
            dbo.SS_HC_AntecedentesPersonalesINDetalle_FE.FechaCreacion AS FechaCreacionDet, 
            dbo.SS_HC_AntecedentesPersonalesINDetalle_FE.UsuarioModificacion AS UsuarioModificacionDet, 
            dbo.SS_HC_AntecedentesPersonalesINDetalle_FE.FechaModificacion AS FechaModificacionDet, 
            dbo.SS_HC_AntecedentesPersonalesINDetalle_FE.Accion AS AccionDet, dbo.SS_HC_AntecedentesPersonalesINDetalle_FE.Version AS VersionDet
FROM         dbo.SS_HC_AntecedentesPersonalesIN_FE WITH(NOLOCK) 
		LEFT JOIN    dbo.SS_HC_AntecedentesPersonalesINDetalle_FE WITH(NOLOCK) ON 
            dbo.SS_HC_AntecedentesPersonalesIN_FE.UnidadReplicacion = dbo.SS_HC_AntecedentesPersonalesINDetalle_FE.UnidadReplicacion AND 
            dbo.SS_HC_AntecedentesPersonalesIN_FE.IdEpisodioAtencion = dbo.SS_HC_AntecedentesPersonalesINDetalle_FE.IdEpisodioAtencion AND 
            dbo.SS_HC_AntecedentesPersonalesIN_FE.IdPaciente = dbo.SS_HC_AntecedentesPersonalesINDetalle_FE.IdPaciente AND 
            dbo.SS_HC_AntecedentesPersonalesIN_FE.EpisodioClinico = dbo.SS_HC_AntecedentesPersonalesINDetalle_FE.EpisodioClinico

GO

/****** Object:  View [dbo].[rptViewInterconsulta_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[rptViewInterconsulta_FE]
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
FROM SS_HC_InterConsulta_FE AS A   WITH(NOLOCK) 
	LEFT JOIN SS_GE_Especialidad  AS B   WITH(NOLOCK) ON A.IdEspecialidad = B.IdEspecialidad 
	INNER JOIN MA_MiscelaneosDetalle MIS WITH(NOLOCK) ON MIS.CodigoElemento = A.IdTipoInterConsulta AND
       MIS.CodigoTabla ='INTERCONFE'
GO

/****** Object:  View [dbo].[rptViewKardex1]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[rptViewKardex1]
as
  Select	
		SS_HC_Kardex1_FE.UnidadReplicacion,
		SS_HC_Kardex1_FE.IdEpisodioAtencion,
		SS_HC_Kardex1_FE.IdPaciente,
		SS_HC_Kardex1_FE.EpisodioClinico,
		SS_HC_Kardex1_FE.IdMedico,
		SS_HC_Kardex1_FE.CMP,
		SS_HC_Kardex1_FE.Estado,
		SS_HC_Kardex1_FE.NombreMedico,
		SS_HC_Kardex1_FE.Religion,
		SS_HC_Kardex1_FE.Ayuno,
		--Accion
		SS_HC_Kardex1_FE.Accion,
		--Datos generales 
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
		SS_HC_EpisodioAtencion.ObservacionProxima AS ObservacionProximaEpiAtencion,
		SS_GE_TipoAtencion.Descripcion AS TipoAtencionDesc,
		SS_TipoTrabajador.DescripcionLocal AS TipoTrabajadorDesc,
		CM_CO_Establecimiento.Codigo AS EstablecimientoCodigo, 
		CM_CO_Establecimiento.Nombre AS EstablecimientoDesc,
	 	SS_HC_UnidadServicio.Codigo AS UnidadServicioCodigo, 
		SS_HC_UnidadServicio.Descripcion AS UnidadServicioDesc
  
  	 from  SS_HC_Kardex1_FE 
		left JOIN PERSONAMAST 
			ON SS_HC_Kardex1_FE.IdPaciente = PERSONAMAST.Persona 
		INNER JOIN SS_HC_EpisodioAtencion 
			ON SS_HC_Kardex1_FE.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion AND 
				SS_HC_Kardex1_FE.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND 
				SS_HC_Kardex1_FE.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND 
				SS_HC_Kardex1_FE.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
		left outer join	SS_GE_TipoAtencion 
			on SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion 
		left outer join SS_TipoTrabajador 
			on SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador 
		left outer join	CM_CO_Establecimiento 
			on CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud 
		left outer join SS_HC_UnidadServicio
            on SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
               and CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud -- Validacion
              		left JOIN PERSONAMAST MED
			ON SS_HC_EpisodioAtencion.IdPersonalSalud = MED.Persona  


GO
/****** Object:  View [dbo].[rptViewKardex1_Detalle1]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[rptViewKardex1_Detalle1]

as
  Select	
		SS_HC_Medicamento_Kardex_FE.UnidadReplicacion,
		SS_HC_Medicamento_Kardex_FE.IdEpisodioAtencion,
		SS_HC_Medicamento_Kardex_FE.IdPaciente,
		SS_HC_Medicamento_Kardex_FE.EpisodioClinico,
		SS_HC_Medicamento_Kardex_FE.Secuencia,
		SS_HC_Medicamento_Kardex_FE.CodigoComponente,
		SS_HC_Medicamento_Kardex_FE.IdVia,
		SS_HC_Medicamento_Kardex_FE.Dosis,
		SS_HC_Medicamento_Kardex_FE.DiasTratamiento,
		SS_HC_Medicamento_Kardex_FE.Frecuencia,
		SS_HC_Medicamento_Kardex_FE.Cantidad,
		SS_HC_Medicamento_Kardex_FE.Descripcion,
		SS_HC_Medicamento_Kardex_FE.TipoComida,
		SS_HC_Medicamento_Kardex_FE.VolumenDia,
		SS_HC_Medicamento_Kardex_FE.FrecuenciaToma,
		SS_HC_Medicamento_Kardex_FE.Periodo,
		SS_HC_Medicamento_Kardex_FE.UnidadTiempo,
		SS_HC_Medicamento_Kardex_FE.IndicadorAuditoria,
		SS_HC_Medicamento_Kardex_FE.UsuarioAuditoria,
		convert (varchar(5),SS_HC_Medicamento_Kardex_FE.HoraInicio ,108  ) as HoraInicio ,
		convert (varchar(5),SS_HC_Medicamento_Kardex_FE.HoraAdministracion ,108  ) as HoraAdministracion ,
		SS_HC_Medicamento_Kardex_FE.Estado,
		SS_HC_Medicamento_Kardex_FE.accion,
		--Datos generales 
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
		SS_HC_EpisodioAtencion.ObservacionProxima AS ObservacionProximaEpiAtencion,
		SS_GE_TipoAtencion.Descripcion AS TipoAtencionDesc,
		SS_TipoTrabajador.DescripcionLocal AS TipoTrabajadorDesc,
		CM_CO_Establecimiento.Codigo AS EstablecimientoCodigo, 
		CM_CO_Establecimiento.Nombre AS EstablecimientoDesc,
	 	SS_HC_UnidadServicio.Codigo AS UnidadServicioCodigo, 
		SS_HC_UnidadServicio.Descripcion AS UnidadServicioDesc
  
  	 from  SS_HC_Medicamento_Kardex_FE 
		--inner join GE_VARIOS on CodigoTabla = 'VIADIETA' and 
		--			SS_HC_Medicamento_Kardex_FE.IdVia = GE_VARIOS.Secuencial
		
		--inner join SS_HC_CATALOGODIETA on 
		left JOIN PERSONAMAST 
			ON SS_HC_Medicamento_Kardex_FE.IdPaciente = PERSONAMAST.Persona 
		INNER JOIN SS_HC_EpisodioAtencion 
			ON SS_HC_Medicamento_Kardex_FE.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion AND 
				SS_HC_Medicamento_Kardex_FE.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND 
				SS_HC_Medicamento_Kardex_FE.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND 
				SS_HC_Medicamento_Kardex_FE.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
		left outer join	SS_GE_TipoAtencion 
			on SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion 
		left outer join SS_TipoTrabajador 
			on SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador 
		left outer join	CM_CO_Establecimiento 
			on CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud 
		left outer join SS_HC_UnidadServicio
            on SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
               and CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud -- Validacion
              		left JOIN PERSONAMAST MED
			ON SS_HC_EpisodioAtencion.IdPersonalSalud = MED.Persona  
  

GO
/****** Object:  View [dbo].[rptViewKardex2]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[rptViewKardex2]

as
  Select	
		SS_HC_Kardex1_FE.UnidadReplicacion,
		SS_HC_Kardex1_FE.IdEpisodioAtencion,
		SS_HC_Kardex1_FE.IdPaciente,
		SS_HC_Kardex1_FE.EpisodioClinico,
		SS_HC_Kardex1_FE.IdMedico,
		SS_HC_Kardex1_FE.CMP,
		SS_HC_Kardex1_FE.Estado,
		SS_HC_Kardex1_FE.NombreMedico,
		SS_HC_Kardex1_FE.Religion,
		SS_HC_Kardex1_FE.Ayuno,
		--Accion
		SS_HC_Kardex1_FE.Accion,
		--Datos generales 
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
		SS_HC_EpisodioAtencion.ObservacionProxima AS ObservacionProximaEpiAtencion,
		SS_GE_TipoAtencion.Descripcion AS TipoAtencionDesc,
		SS_TipoTrabajador.DescripcionLocal AS TipoTrabajadorDesc,
		CM_CO_Establecimiento.Codigo AS EstablecimientoCodigo, 
		CM_CO_Establecimiento.Nombre AS EstablecimientoDesc,
	 	SS_HC_UnidadServicio.Codigo AS UnidadServicioCodigo, 
		SS_HC_UnidadServicio.Descripcion AS UnidadServicioDesc
  
  	 from  SS_HC_Kardex1_FE 
		left JOIN PERSONAMAST ON SS_HC_Kardex1_FE.IdPaciente = PERSONAMAST.Persona 
		INNER JOIN SS_HC_EpisodioAtencion 	ON SS_HC_Kardex1_FE.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion AND 
				SS_HC_Kardex1_FE.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND 
				SS_HC_Kardex1_FE.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND 
				SS_HC_Kardex1_FE.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
		left outer join	SS_GE_TipoAtencion 	on SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion 
		left outer join SS_TipoTrabajador 	on SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador 
		left outer join	CM_CO_Establecimiento 	on CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud 
		left outer join SS_HC_UnidadServicio    on SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
               and CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud -- Validacion
              		left JOIN PERSONAMAST MED
			ON SS_HC_EpisodioAtencion.IdPersonalSalud = MED.Persona  

GO
/****** Object:  View [dbo].[rptViewKardex3]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[rptViewKardex3]
as
  Select	
		SS_HC_Medicamento_Kardex.UnidadReplicacion,
		SS_HC_Medicamento_Kardex.IdEpisodioAtencion,
		SS_HC_Medicamento_Kardex.IdPaciente,
		SS_HC_Medicamento_Kardex.EpisodioClinico,
		SS_HC_Medicamento_Kardex.Secuencia,
		SS_HC_Medicamento_Kardex.IdMedicacion,
		SS_HC_Medicamento_Kardex.Medicacion,
		SS_HC_Medicamento_Kardex.Dosis,
		SS_HC_Medicamento_Kardex.Frecuencia,
		SS_HC_Medicamento_Kardex.DiasTratamiento,
		SS_HC_Medicamento_Kardex.DiaTratamiento,
		SS_HC_Medicamento_Kardex.HoraInicio,
		SS_HC_Medicamento_Kardex.HoraAdministracion,
		SS_HC_Medicamento_Kardex.Hora0,
		SS_HC_Medicamento_Kardex.Hora1,
		SS_HC_Medicamento_Kardex.Hora2,
		SS_HC_Medicamento_Kardex.Hora3,
		SS_HC_Medicamento_Kardex.Hora4,
		SS_HC_Medicamento_Kardex.Hora5,
		SS_HC_Medicamento_Kardex.Hora6,
		SS_HC_Medicamento_Kardex.Hora7,
		SS_HC_Medicamento_Kardex.Hora8,
		SS_HC_Medicamento_Kardex.Hora9,
		SS_HC_Medicamento_Kardex.Hora10,
		SS_HC_Medicamento_Kardex.Hora11,
		SS_HC_Medicamento_Kardex.Hora12,
		SS_HC_Medicamento_Kardex.Hora13,
		SS_HC_Medicamento_Kardex.Hora14,
		SS_HC_Medicamento_Kardex.Hora15,
		SS_HC_Medicamento_Kardex.Hora16,
		SS_HC_Medicamento_Kardex.Hora17,
		SS_HC_Medicamento_Kardex.Hora18,
		SS_HC_Medicamento_Kardex.Hora19,
		SS_HC_Medicamento_Kardex.Hora20,
		SS_HC_Medicamento_Kardex.Hora21,
		SS_HC_Medicamento_Kardex.Hora22,
		SS_HC_Medicamento_Kardex.Hora23,
		SS_HC_Medicamento_Kardex.Accion,
				
		--Datos generales 
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
		SS_HC_EpisodioAtencion.ObservacionProxima AS ObservacionProximaEpiAtencion,
		SS_GE_TipoAtencion.Descripcion AS TipoAtencionDesc,
		SS_TipoTrabajador.DescripcionLocal AS TipoTrabajadorDesc,
		CM_CO_Establecimiento.Codigo AS EstablecimientoCodigo, 
		CM_CO_Establecimiento.Nombre AS EstablecimientoDesc,
	 	SS_HC_UnidadServicio.Codigo AS UnidadServicioCodigo, 
		SS_HC_UnidadServicio.Descripcion AS UnidadServicioDesc
  
  	 from  SS_HC_Medicamento_Kardex WITH(NOLOCK) 
		left JOIN PERSONAMAST 
			WITH(NOLOCK) ON SS_HC_Medicamento_Kardex.IdPaciente = PERSONAMAST.Persona 
		INNER JOIN SS_HC_EpisodioAtencion 
			WITH(NOLOCK) ON SS_HC_Medicamento_Kardex.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion AND 
				SS_HC_Medicamento_Kardex.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND 
				SS_HC_Medicamento_Kardex.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND 
				SS_HC_Medicamento_Kardex.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
		left outer join	SS_GE_TipoAtencion 
			WITH(NOLOCK) on SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion 
		left outer join SS_TipoTrabajador 
			WITH(NOLOCK) on SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador 
		left outer join	CM_CO_Establecimiento 
			WITH(NOLOCK) on CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud 
		left outer join SS_HC_UnidadServicio
            WITH(NOLOCK) on SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
               and CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud -- Validacion
        left JOIN PERSONAMAST MED
			WITH(NOLOCK) ON SS_HC_EpisodioAtencion.IdPersonalSalud = MED.Persona   

GO
/****** Object:  View [dbo].[rptViewNota_Ingreso_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewNota_Ingreso_FE]
AS
		SELECT EA.*,
	     stuff  ((SELECT ', ' + B.DiagnosticoDescripcion   FROM SS_HC_Nota_Ingreso_FE A WITH(NOLOCK) 
		INNER JOIN SS_HC_NotaIngreso_Diagnostico_FE B WITH(NOLOCK)
			ON    A.UnidadReplicacion = B.UnidadReplicacion AND
					A.IdEpisodioAtencion = B.IdEpisodioAtencion AND
					A.IdPaciente = B.IdPaciente AND
					A.EpisodioClinico = B.EpisodioClinico
		WHERE EA.IdPaciente = B.IdPaciente AND EA.EpisodioClinico = B.EpisodioClinico AND EA.IdEpisodioAtencion = B.IdEpisodioAtencion
				FOR XML PATH(''), TYPE ).value('.', 'varchar(max)'), 1, 1, '') AS Sintomas	   ,
			/**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      PERSONAMAST.ApellidoPaterno, PERSONAMAST.ApellidoMaterno, PERSONAMAST.Nombres, PERSONAMAST.NombreCompleto, 
                      PERSONAMAST.Busqueda, PERSONAMAST.TipoDocumento, PERSONAMAST.Documento, PERSONAMAST.FechaNacimiento, 
                      PERSONAMAST.Sexo, PERSONAMAST.EstadoCivil, PERSONAMAST.edad as PersonaEdad
                      --EPI ATENCIÓN
                      ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoAtencion
                      ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                      ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio
                      ,SS_HC_EpisodioAtencion.IdPersonalSalud
                      ,SS_HC_EpisodioAtencion.FechaRegistro
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      ,SS_HC_EpisodioAtencion.IdTipoOrden
                      ,EMPLEADO_PERSSALUD.CMP as estadoEpiAtencion --CMP
                      ,SS_HC_EpisodioAtencion.Accion as Expr101  --AUX
                      ,SS_HC_EpisodioAtencion.ObservacionProxima as Expr102 --AUX
			         ,left(CONVERT (time, FechaAtencion),8) as Expr103 --HORA ATENCION        
                      --    
                      ,SS_GE_TipoAtencion.Descripcion as TipoAtencionDesc
                      ,EMPLEADO_PERSSALUD.CMP as TipoTrabajadorDesc  --CMP
                      ,CM_CO_Establecimiento.Codigo as EstablecimientoCodigo
                      ,CM_CO_Establecimiento.Nombre as EstablecimientoDesc
                      ,SS_HC_UnidadServicio.Codigo as UnidadServicioCodigo
                      ,SS_GE_Paciente.CodigoHC as UnidadServicioDesc --CODIGOHC
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

FROM     SS_HC_Nota_Ingreso_FE EA WITH(NOLOCK) 
		left JOIN SS_HC_NotaIngreso_Diagnostico_FE  EAD WITH(NOLOCK)	
	   			ON EA.UnidadReplicacion = EAD.UnidadReplicacion AND EA.IdEpisodioAtencion = EAD.IdEpisodioAtencion AND
                    EA.IdPaciente = EAD.IdPaciente AND EA.EpisodioClinico = EAD.EpisodioClinico
		INNER JOIN  PERSONAMAST WITH(NOLOCK) ON EA.IdPaciente = dbo.PERSONAMAST.Persona
		left JOIN   SS_HC_EpisodioAtencion  WITH(NOLOCK)
                      ON EA.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion AND
					  EA.IdEpisodioAtencion =(case when SS_HC_EpisodioAtencion.TipoAtencion IN (2,3) then
					SS_HC_EpisodioAtencion.IdEpisodioAtencion else SS_HC_EpisodioAtencion.EpisodioAtencion end) 
                      AND EA.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente 
                      AND EA.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
		LEFT JOIN  SS_GE_Paciente  WITH(NOLOCK)
					  on EA.IdPaciente =  SS_GE_Paciente.IdPaciente                                           
		LEFT JOIN  SS_GE_TipoAtencion WITH(NOLOCK)
                      ON SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
		LEFT JOIN  SS_TipoTrabajador WITH(NOLOCK)
                      ON SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
		LEFT JOIN  CM_CO_Establecimiento WITH(NOLOCK)
                      ON CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
		LEFT JOIN  SS_HC_UnidadServicio WITH(NOLOCK)
                      ON SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio   
					  AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
        LEFT JOIN  PERSONAMAST  as PERSONA_PERSSALUD WITH(NOLOCK)
                      ON PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
        LEFT JOIN  SS_GE_Especialidad   WITH(NOLOCK)
                      ON SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad     
                      --ADD CMP  y RNE
        LEFT JOIN  EMPLEADOMAST  as EMPLEADO_PERSSALUD WITH(NOLOCK)
                      ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud
        LEFT JOIN  SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED WITH(NOLOCK)
                      ON (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud
						And ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad
						)
GO
/****** Object:  View [dbo].[rptViewNotaEnfermeria_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewNotaEnfermeria_FE]
AS
			SELECT    CV.*, 
                    /**********ADD GENERALES****************/                      
					dbo.PERSONAMAST.Telefono as ApellidoPaterno, 
					dbo.PERSONAMAST.Celular as ApellidoMaterno, 
					dbo.PERSONAMAST.Nombres, 
					dbo.PERSONAMAST.NombreCompleto, 
					PERSONAMAST.CorreoElectronico as Busqueda ,
					dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.FechaNacimiento, 
                    dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.edad as PersonaEdad
                    --EPI ATENCIÓN
                    ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                    ,SS_HC_EpisodioAtencion.CodigoOA
                    ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                    ,SS_HC_EpisodioAtencion.TipoOrdenAtencion  AS TipoOrdenAtencionPac
                    ,SS_HC_EpisodioAtencion.TipoAtencion
                    ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                    ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                    ,SS_HC_EpisodioAtencion.IdUnidadServicio
                    ,SS_HC_EpisodioAtencion.IdPersonalSalud
                    ,SS_HC_EpisodioAtencion.FechaRegistro
                    ,SS_HC_EpisodioAtencion.FechaAtencion
                    ,SS_HC_EpisodioAtencion.IdEspecialidad AS IdEspecialidadPac
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

		FROM       SS_HC_NotasEnfermeria_FE CV WITH(NOLOCK) 
			INNER JOIN  SS_HC_EpisodioAtencion  WITH(NOLOCK) ON 
                    SS_HC_EpisodioAtencion.UnidadReplicacion = CV.UnidadReplicacion   AND
				     CV.IdEpisodioAtencion =(case when SS_HC_EpisodioAtencion.TipoAtencion IN (2,3) then
					SS_HC_EpisodioAtencion.IdEpisodioAtencion else SS_HC_EpisodioAtencion.EpisodioAtencion end) 
					and
                    CV.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND
                    CV.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico
			INNER JOIN  PERSONAMAST  WITH(NOLOCK) ON CV.IdPaciente = PERSONAMAST.Persona                    
			LEFT JOIN SS_GE_TipoAtencion  WITH(NOLOCK) ON 
						SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
			LEFT JOIN  SS_TipoTrabajador  WITH(NOLOCK) ON 
						SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador
			LEFT JOIN  CM_CO_Establecimiento  WITH(NOLOCK) ON
						CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud
			LEFT JOIN  SS_HC_UnidadServicio  WITH(NOLOCK) ON 
						SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
                               /****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/           
							   AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
            LEFT JOIN  PERSONAMAST AS PERSONA_PERSSALUD  WITH(NOLOCK) ON 
						PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud                    
            LEFT JOIN  SS_GE_Especialidad			WITH(NOLOCK) ON 
						SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad 
            LEFT JOIN EMPLEADOMAST AS EMPLEADO_PERSSALUD			WITH(NOLOCK) ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud                     
            LEFT JOIN SS_GE_EspecialidadMedico AS ESPECIALIDAD_MED  WITH(NOLOCK) ON 
                    (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud AND
                    ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad)

GO
/****** Object:  View [dbo].[rptViewNotaEnfermeriaMasiva_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[rptViewNotaEnfermeriaMasiva_FE]
AS
			
SELECT	 CV.UnidadReplicacion
		,CV.IdEpisodioAtencion
		,CV.IdPaciente
		,CV.EpisodioClinico
		,CV.IdMedico
		,CV.NombreMedico
		,SS_HC_EpisodioAtencion.IdOrdenAtencion as IdEspecialidad	
		,CV.NotaEnfermeria
		,CV.NumeroVisitas		
		,PERSONA_PERSSALUD.NombreCompleto +
				ISNULL(	(case when  EMPLEADO_PERSSALUD.CMP IS null 
						then ''
						else '/CMP: '+EMPLEADO_PERSSALUD.CMP  end),'')
					+                      
					'/'+ ISNULL( SS_GE_Especialidad.Nombre,'')
					+
					ISNULL(	 (case when  ESPECIALIDAD_MED.NumeroRegistroEspecialidad IS null 
						then ''
						else '- RNE: '+ESPECIALIDAD_MED.NumeroRegistroEspecialidad end)	,'')					                 
                    as NombreEspecialista
		,EMPLEADO_PERSSALUD.FirmaDigital 	 
		,CONVERT(varchar,CV.FechaNota,20)  as FechaNota
		,SS_TipoTrabajador.DescripcionLocal as TipoTrabajador
		 , PDF.CodigoBinario,
		 CV.UsuarioCreacion,
		 CV.UsuarioModificacion,
		 CV.Version,
		  CV.Accion,
		 SS_HC_EpisodioAtencion.CodigoOA
	FROM     SS_HC_NotasEnfermeria_FE CV WITH(NOLOCK) 
	INNER JOIN  SS_HC_EpisodioAtencion  WITH(NOLOCK) ON 
                    SS_HC_EpisodioAtencion.UnidadReplicacion = CV.UnidadReplicacion   AND
				     CV.IdEpisodioAtencion =(case when SS_HC_EpisodioAtencion.TipoAtencion IN (2,3) then
					SS_HC_EpisodioAtencion.IdEpisodioAtencion else SS_HC_EpisodioAtencion.EpisodioAtencion end) 
					and
                    CV.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND
                    CV.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico	
	LEFT JOIN SS_HC_NotasPdf_FE PDF ON	CV.UnidadReplicacion  =   PDF.UnidadReplicacion 
				AND     CV.IdEpisodioAtencion = CV.IdEpisodioAtencion
				AND	   CV.IdPaciente = PDF.IdPaciente 
                AND    CV.EpisodioClinico = PDF.EpisodioClinico	
	LEFT JOIN  SS_TipoTrabajador  WITH(NOLOCK) ON 
						SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador
    LEFT JOIN  PERSONAMAST AS PERSONA_PERSSALUD  WITH(NOLOCK) ON 
						PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud                    
    LEFT JOIN  SS_GE_Especialidad			WITH(NOLOCK) ON 
						SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad 
    LEFT JOIN EMPLEADOMAST AS EMPLEADO_PERSSALUD			WITH(NOLOCK) ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud                     
    LEFT JOIN SS_GE_EspecialidadMedico AS ESPECIALIDAD_MED  WITH(NOLOCK) ON 
                    (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud AND
                    ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad)
GO
/****** Object:  View [dbo].[rptViewNotaIngreso_Diagnostico_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[rptViewNotaIngreso_Diagnostico_FE]
AS
		SELECT
		CO.UnidadReplicacion,CO.IdEpisodioAtencion,CO.IdPaciente,CO.EpisodioClinico,CO.UsuarioCreacion,
		CO.UsuarioModificacion,CO.FechaModificacion,CO.FechaCreacion,CO.Accion,CO.Version,
		CO.Secuencia,dbo.SS_GE_Diagnostico.CodigoDiagnostico,
				('['+ rtrim(dbo.SS_GE_Diagnostico.CodigoDiagnostico)+'] ' +dbo.SS_GE_Diagnostico.Descripcion) as DiagnosticoDesc ,

					TAB_DETERMDIAGDET.Nombre as DeterminacionDiagnosticaDesc,
					TAB_DIAGPRINCDET.Nombre   as DiagnosticoPrincipalDesc,
					TAB_GRADOAFECDET.Nombre  as GradoAfeccionDesc,
					--CO.TiempoEmfer,
			/**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      PERSONAMAST.ApellidoPaterno,PERSONAMAST.ApellidoMaterno,PERSONAMAST.Nombres,PERSONAMAST.NombreCompleto, 
                      PERSONAMAST.Busqueda,PERSONAMAST.TipoDocumento,PERSONAMAST.Documento,PERSONAMAST.FechaNacimiento, 
                      PERSONAMAST.Sexo,PERSONAMAST.EstadoCivil,PERSONAMAST.edad as PersonaEdad
                      --EPI ATENCIÓN
                      ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoOrdenAtencion  AS TipoOrdenAtencionPac
                      ,SS_HC_EpisodioAtencion.TipoAtencion
                      ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                      ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio
                      ,SS_HC_EpisodioAtencion.IdPersonalSalud
                      ,SS_HC_EpisodioAtencion.FechaRegistro AS FechaRegistroPac
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      ,SS_HC_EpisodioAtencion.IdEspecialidad AS IdEspecialidadPac
                      ,SS_HC_EpisodioAtencion.IdTipoOrden
                      ,SS_HC_EpisodioAtencion.Estado as estadoEpiAtencion
                      ,SS_HC_EpisodioAtencion.Accion as Expr101  --AUX
                      ,SS_HC_EpisodioAtencion.ObservacionProxima as Expr102 --AUX
                      ,SS_HC_EpisodioAtencion.Accion as Expr103 --AUX                      
                      ,SS_GE_TipoAtencion.Descripcion as TipoAtencionDesc
                      ,SS_TipoTrabajador.DescripcionLocal as TipoTrabajadorDesc
                      ,CM_CO_Establecimiento.Codigo as EstablecimientoCodigo
                      ,CM_CO_Establecimiento.Nombre as EstablecimientoDesc
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
		FROM SS_HC_NotaIngreso_Diagnostico_FE CO WITH(NOLOCK) 
		INNER JOIN  SS_HC_EpisodioAtencion  WITH(NOLOCK) ON 
                    SS_HC_EpisodioAtencion.UnidadReplicacion = CO.UnidadReplicacion   AND
				    CO.IdEpisodioAtencion =(case when SS_HC_EpisodioAtencion.TipoAtencion IN (2,3) then
					SS_HC_EpisodioAtencion.IdEpisodioAtencion else SS_HC_EpisodioAtencion.EpisodioAtencion end) 
					AND
                    CO.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND
                    CO.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico
		INNER JOIN  PERSONAMAST  WITH(NOLOCK) ON CO.IdPaciente = PERSONAMAST.Persona                    
		LEFT JOIN  SS_GE_TipoAtencion  WITH(NOLOCK) ON 
                    SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
		LEFT JOIN  SS_TipoTrabajador  WITH(NOLOCK) ON 
                    SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador
		LEFT JOIN  CM_CO_Establecimiento  WITH(NOLOCK) ON
                    CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud
		LEFT JOIN  SS_HC_UnidadServicio  WITH(NOLOCK) ON 
                    SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
                               /****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/           
							   AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
       LEFT JOIN  PERSONAMAST AS PERSONA_PERSSALUD  WITH(NOLOCK) ON 
                    PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud                    
       LEFT JOIN  SS_GE_Especialidad  WITH(NOLOCK) ON 
                    SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad                     
       LEFT JOIN  SS_GE_Diagnostico  WITH(NOLOCK) ON SS_GE_Diagnostico.CodigoDiagnostico = CO.Codigo
	   left join  CM_CO_TablaMaestro  as TAB_DETERMDIAG WITH(NOLOCK) 
					 on 
					 (
						TAB_DETERMDIAG.CodigoTabla = 'TABDIAGNOSTICO'						 
					 )
	  left join  CM_CO_TablaMaestroDetalle TAB_DETERMDIAGDET WITH(NOLOCK) 
					 on(
						TAB_DETERMDIAGDET.IdTablaMaestro = TAB_DETERMDIAG.IdTablaMaestro
						and TAB_DETERMDIAGDET.IdCodigo = CO.DeterminacionDiagnostica
					 )						
	 left join   CM_CO_TablaMaestro  as TAB_DIAGPRINC WITH(NOLOCK) 
					 on 
					 (
						TAB_DIAGPRINC.CodigoTabla = 'TABCOLABORACION'						 
					 )
	 left join  CM_CO_TablaMaestroDetalle TAB_DIAGPRINCDET WITH(NOLOCK) 
					 on(
						TAB_DIAGPRINCDET.IdTablaMaestro = TAB_DIAGPRINC.IdTablaMaestro
						and TAB_DIAGPRINCDET.IdCodigo = CO.IdDiagnosticoPrincipal
					 )
	 left join   CM_CO_TablaMaestro  as TAB_GRADOAFEC WITH(NOLOCK) 
					 on 
					 (
						TAB_GRADOAFEC.CodigoTabla = 'DIAGAFECCION'						 
					 )
	 left join  CM_CO_TablaMaestroDetalle TAB_GRADOAFECDET WITH(NOLOCK) 
					 on(
						TAB_GRADOAFECDET.IdTablaMaestro = TAB_GRADOAFEC.IdTablaMaestro
						and TAB_GRADOAFECDET.IdCodigo = CO.GradoAfeccion
					 )		
	 left join  CM_CO_TablaMaestro  as TAB_ANTEC WITH(NOLOCK) 
					 on 
					 (
						TAB_ANTEC.CodigoTabla = 'DIAGANTECED'						 
					 )					
                      --ADD CMP  y RNE
      LEFT JOIN   EMPLEADOMAST  as EMPLEADO_PERSSALUD WITH(NOLOCK) 
                      ON EMPLEADO_PERSSALUD.Empleado = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
       LEFT JOIN  SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED WITH(NOLOCK) 
                      ON (ESPECIALIDAD_MED.IdMedico = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
						And ESPECIALIDAD_MED.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad
						)
						
GO
/****** Object:  View [dbo].[rptViewNotaIngreso_ExamenApoyo_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewNotaIngreso_ExamenApoyo_FE]
AS
			SELECT
			CO.UnidadReplicacion,CO.IdEpisodioAtencion,CO.IdPaciente,CO.EpisodioClinico,CO.UsuarioCreacion,
			CO.UsuarioModificacion,CO.FechaModificacion,CO.FechaCreacion,CO.Accion,CO.Version,
			 CM_CO_Componente.Nombre AS Examen,
			 CO.CodigoSegus,
			CO.Secuencia,
			 /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      PERSONAMAST.ApellidoPaterno,PERSONAMAST.ApellidoMaterno,PERSONAMAST.Nombres,PERSONAMAST.NombreCompleto, 
                      PERSONAMAST.Busqueda,PERSONAMAST.TipoDocumento,PERSONAMAST.Documento,PERSONAMAST.FechaNacimiento, 
                      PERSONAMAST.Sexo,PERSONAMAST.EstadoCivil,PERSONAMAST.edad as PersonaEdad
                      --EPI ATENCIÓN
                      ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoOrdenAtencion  AS TipoOrdenAtencionPac
                      ,SS_HC_EpisodioAtencion.TipoAtencion
                      ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                      ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio
                      ,SS_HC_EpisodioAtencion.IdPersonalSalud
                      ,SS_HC_EpisodioAtencion.FechaRegistro AS FechaRegistroPac
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      ,SS_HC_EpisodioAtencion.IdEspecialidad AS IdEspecialidadPac
                      ,SS_HC_EpisodioAtencion.IdTipoOrden
                      ,SS_HC_EpisodioAtencion.Estado as estadoEpiAtencion
                      ,SS_HC_EpisodioAtencion.Accion as Expr101  --AUX
                      ,SS_HC_EpisodioAtencion.ObservacionProxima as Expr102 --AUX
                      ,SS_HC_EpisodioAtencion.Accion as Expr103 --AUX                      
                      ,SS_GE_TipoAtencion.Descripcion as TipoAtencionDesc
                      ,SS_TipoTrabajador.DescripcionLocal as TipoTrabajadorDesc
                      ,CM_CO_Establecimiento.Codigo as EstablecimientoCodigo
                      ,CM_CO_Establecimiento.Nombre as EstablecimientoDesc
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
		FROM SS_HC_NotaIngreso_ExamenApoyo_FE CO WITH(NOLOCK) 
		INNER JOIN  SS_HC_EpisodioAtencion  WITH(NOLOCK) ON 
                    SS_HC_EpisodioAtencion.UnidadReplicacion = CO.UnidadReplicacion   AND
					 CO.IdEpisodioAtencion =(case when SS_HC_EpisodioAtencion.TipoAtencion IN (2,3) then
					SS_HC_EpisodioAtencion.IdEpisodioAtencion else SS_HC_EpisodioAtencion.EpisodioAtencion end) 
					AND
                    CO.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND
                    CO.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico
		INNER JOIN  PERSONAMAST  WITH(NOLOCK) ON CO.IdPaciente = PERSONAMAST.Persona                    
		LEFT JOIN  SS_GE_TipoAtencion  WITH(NOLOCK) ON 
                    SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
		LEFT JOIN  SS_TipoTrabajador  WITH(NOLOCK) ON 
                    SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador
		LEFT JOIN  CM_CO_Establecimiento  WITH(NOLOCK) ON
                    CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud
		LEFT JOIN  SS_HC_UnidadServicio  WITH(NOLOCK) ON 
                    SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
                               /****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/           
							   AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
        LEFT JOIN  PERSONAMAST AS PERSONA_PERSSALUD  WITH(NOLOCK) ON 
                    PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
        LEFT JOIN  SS_GE_Especialidad  WITH(NOLOCK) ON    SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad 
		LEFT JOIN    CM_CO_Componente  WITH(NOLOCK) ON    CM_CO_Componente.CodigoComponente =CO.CodigoSegus
                      --ADD CMP  y RNE
        LEFT JOIN   EMPLEADOMAST  as EMPLEADO_PERSSALUD WITH(NOLOCK) ON EMPLEADO_PERSSALUD.Empleado = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
        LEFT JOIN   SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED
                      ON (ESPECIALIDAD_MED.IdMedico = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
						And ESPECIALIDAD_MED.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad
						)
GO
/****** Object:  View [dbo].[rptViewOftalmologia_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewOftalmologia_FE]
AS
SELECT			EC.UnidadReplicacion,
				EC.IdEpisodioAtencion,
				EC.IdPaciente,
				EC.EpisodioClinico,
				EC.AVscODerecho,
				EC.AVscOIzquierdo,
				EC.AVccODerecho,
				EC.AVccOIzquierdo,
				EC.PinHoldODerecho,
				EC.PinHoldOIzquierdo,
				EC.CercaODerecho,
				EC.CercaOIzquierdo,
				EC.RefraODerechoEsfera,
				EC.RefraODerechoCilindro,
				EC.RefraODerechoEje,
				EC.ScicloPejiaOIzqEsfera,
				EC.ScicloPejiaOIzqCilindro,
				EC.ScicloPejiaOIzqEje,
				EC.RefracODerechoAV,
				EC.RefracODerechoADD,
				EC.RefracODerechoDIP,
				EC.CciclopejiaOIzqAV,
				EC.CciclopejiaOIzqADD,
				EC.CciclopejiaOIzqDIP,
				EC.Adicion,
				EC.DistanciaPupilar,
				EC.TonShiotz,
				EC.TonAplanacion,
				EC.TonOtra,
				EC.TonODerecho,
				EC.TonOIzquierdo,
				EC.PaquimetriaODerecho,
				EC.PaquimetriaOIzquierdo,
				EC.CorreccionODerecho,
				EC.CorreccionOIzquierdo,
				EC.Parpados_anexos,
				EC.Cornea_Cristalino_Esclera,
				EC.Iris_Pupila,
				EC.FondOjo_GoniosCopia,
				EC.Estado,
				EC.UsuarioCreacion,
				EC.FechaCreacion,
				EC.UsuarioModificacion,
				EC.FechaModificacion,
				EC.Accion,
				EC.Version,
                      /***************************************/
                      /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      PERSONAMAST.ApellidoPaterno, PERSONAMAST.ApellidoMaterno, PERSONAMAST.Nombres, PERSONAMAST.NombreCompleto, 
                      PERSONAMAST.Busqueda, PERSONAMAST.TipoDocumento, PERSONAMAST.Documento, PERSONAMAST.FechaNacimiento, 
                      PERSONAMAST.Sexo, PERSONAMAST.EstadoCivil, (cast(datediff(dd,PERSONAMAST.FechaNacimiento,GETDATE()) / 365.25 as int)) AS PersonaEdad--PERSONAMAST.edad as PersonaEdad
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
                      ,EMPLEADO_PERSSALUD.CMP as estadoEpiAtencion --CMP
                      ,SS_HC_EpisodioAtencion.Accion as Expr101  --AUX
                      
					  ,(case when  ESPECIALIDAD_MED.NumeroRegistroEspecialidad IS null 
							then ''
							else ESPECIALIDAD_MED.NumeroRegistroEspecialidad end) AS Expr102
					  --,SS_HC_EpisodioAtencion.ObservacionProxima as Expr102 --AUX
			         ,left(CONVERT (time, FechaAtencion),8) as Expr103 --HORA ATENCION        
                      --    
                      ,SS_GE_TipoAtencion.Descripcion as TipoAtencionDesc
                      ,EMPLEADO_PERSSALUD.CMP as TipoTrabajadorDesc  --CMP
                      ,CM_CO_Establecimiento.Codigo as EstablecimientoCodigo
                      ,CM_CO_Establecimiento.Nombre as EstablecimientoDesc
                      ,/*SS_HC_UnidadServicio.Codigo */ EMPLEADO_PERSSALUD.FirmaDigital  as UnidadServicioCodigo
                      ,SS_GE_Paciente.CodigoHC as UnidadServicioDesc --CODIGOHC
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
                      as Expr104--,  --AUX
                      --('['+ rtrim(D.CodigoDiagnostico)+'] ' +D.Descripcion) as DiagnosticoDesc 
					  --D.Descripcion as DiagnosticoDesc                        
                    
FROM        dbo.SS_HC_Oftalmologico_FE   as EC                
                      INNER JOIN
                      dbo.PERSONAMAST ON EC.IdPaciente = dbo.PERSONAMAST.Persona
						LEFT JOIN
                      SS_HC_EpisodioAtencion 
                      ON EC.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion
                      AND EC.IdEpisodioAtencion = SS_HC_EpisodioAtencion.EpisodioAtencion--IdEpisodioAtencion 
                      AND EC.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente 
                      AND EC.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
					  LEFT JOIN SS_GE_Paciente 
					  on EC.IdPaciente =  SS_GE_Paciente.IdPaciente                                           
					 LEFT JOIN
                      SS_GE_TipoAtencion
                      ON SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
					LEFT JOIN
                      SS_TipoTrabajador
                      ON SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
					LEFT JOIN
                      CM_CO_Establecimiento
                      ON CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
					--LEFT JOIN
     --                 SS_HC_UnidadServicio
     --                 ON SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                      
                    LEFT JOIN
                      PERSONAMAST  as PERSONA_PERSSALUD
                      ON PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
                    LEFT JOIN
                      SS_GE_Especialidad  
                      ON SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad     
                      --ADD CMP  y RNE
                    LEFT JOIN
                      EMPLEADOMAST  as EMPLEADO_PERSSALUD
                      ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud
                    LEFT JOIN
                      SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED
                      ON (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud
						And ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad
						)		


GO

/****** Object:  View [dbo].[rptViewOrdenInterQuiruDiagnosticoDetalle_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewOrdenInterQuiruDiagnosticoDetalle_FE]
AS
SELECT
-- CO.CampoDescripcion,
CO.UnidadReplicacion,CO.IdEpisodioAtencion,CO.IdPaciente,CO.EpisodioClinico,CO.UsuarioCreacion,CO.UsuarioModificacion,CO.FechaModificacion,CO.FechaCreacion,CO.Accion,CO.Version,
CO.Estado,CO.Secuencia,
dbo.SS_GE_Diagnostico.CodigoDiagnostico,
				('['+ rtrim(dbo.SS_GE_Diagnostico.CodigoDiagnostico)+'] ' +dbo.SS_GE_Diagnostico.Descripcion) as DiagnosticoDesc ,

					TAB_DETERMDIAGDET.Nombre as DeterminacionDiagnosticaDesc,
					TAB_DIAGPRINCDET.Nombre   as DiagnosticoPrincipalDesc,
					TAB_GRADOAFECDET.Nombre  as GradoAfeccionDesc,
					CO.TiempoEmfer,
 /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      PERSONAMAST.ApellidoPaterno,PERSONAMAST.ApellidoMaterno,PERSONAMAST.Nombres,PERSONAMAST.NombreCompleto, 
                      PERSONAMAST.Busqueda,PERSONAMAST.TipoDocumento,PERSONAMAST.Documento,PERSONAMAST.FechaNacimiento, 
                      PERSONAMAST.Sexo,PERSONAMAST.EstadoCivil,PERSONAMAST.edad as PersonaEdad
                      --EPI ATENCIÓN
                      ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoOrdenAtencion  AS TipoOrdenAtencionPac
                      ,SS_HC_EpisodioAtencion.TipoAtencion
                      ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                      ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio
                      ,SS_HC_EpisodioAtencion.IdPersonalSalud
                      ,SS_HC_EpisodioAtencion.FechaRegistro AS FechaRegistroPac
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      ,SS_HC_EpisodioAtencion.IdEspecialidad AS IdEspecialidadPac
                      ,SS_HC_EpisodioAtencion.IdTipoOrden
                      ,SS_HC_EpisodioAtencion.Estado as estadoEpiAtencion
                      ,SS_HC_EpisodioAtencion.Accion as Expr101  --AUX
                      ,SS_HC_EpisodioAtencion.ObservacionProxima as Expr102 --AUX
                      ,SS_HC_EpisodioAtencion.Accion as Expr103 --AUX                      
                      ,SS_GE_TipoAtencion.Descripcion as TipoAtencionDesc
                      ,SS_TipoTrabajador.DescripcionLocal as TipoTrabajadorDesc
                      ,CM_CO_Establecimiento.Codigo as EstablecimientoCodigo
                      ,CM_CO_Establecimiento.Nombre as EstablecimientoDesc
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
     
FROM SS_HC_OrdenInterQuiruDiagnosticoDetalle_FE CO
INNER JOIN  SS_HC_EpisodioAtencion ON 
                    SS_HC_EpisodioAtencion.UnidadReplicacion = CO.UnidadReplicacion   AND

                   -- CO.IdEpisodioAtencion = SS_HC_EpisodioAtencion.EpisodioAtencion AND

				    CO.IdEpisodioAtencion =(case when SS_HC_EpisodioAtencion.TipoAtencion IN (2,3) then
					SS_HC_EpisodioAtencion.IdEpisodioAtencion else SS_HC_EpisodioAtencion.EpisodioAtencion end) 

					AND



                    CO.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND
                    CO.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico
INNER JOIN  PERSONAMAST ON CO.IdPaciente = PERSONAMAST.Persona                    
LEFT JOIN SS_GE_TipoAtencion ON 
                    SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
LEFT JOIN
                    SS_TipoTrabajador ON 
                    SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador
LEFT JOIN  CM_CO_Establecimiento ON
                    CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud

LEFT JOIN  SS_HC_UnidadServicio ON 
                    SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
                               /****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/           AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
                    LEFT JOIN  PERSONAMAST AS PERSONA_PERSSALUD ON 
                    PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
                    
                    LEFT JOIN  SS_GE_Especialidad ON 
                    SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad 
                    
               LEFT JOIN
                      dbo.SS_GE_Diagnostico  
                     -- ON SS_GE_Diagnostico.IdDiagnostico = CO.IdDiagnostico 

					       ON SS_GE_Diagnostico.IdDiagnostico = CO.Codigo 
					  
					    -- SELECT * FROM SS_HC_OrdenInterQuiruDiagnosticoDetalle_FE
						   --SELECT * FROM SS_GE_Diagnostico
					      		
					 left join 
					 CM_CO_TablaMaestro  as TAB_DETERMDIAG
					 on 
					 (
						TAB_DETERMDIAG.CodigoTabla = 'TABDIAGNOSTICO'						 
					 )
					 left join  CM_CO_TablaMaestroDetalle TAB_DETERMDIAGDET
					 on(
						TAB_DETERMDIAGDET.IdTablaMaestro = TAB_DETERMDIAG.IdTablaMaestro
						and TAB_DETERMDIAGDET.IdCodigo = CO.DeterminacionDiagnostica
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
						and TAB_DIAGPRINCDET.IdCodigo = CO.IdDiagnosticoPrincipal
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
						and TAB_GRADOAFECDET.IdCodigo = CO.GradoAfeccion
					 )		
					 left join 
					 CM_CO_TablaMaestro  as TAB_ANTEC
					 on 
					 (
						TAB_ANTEC.CodigoTabla = 'DIAGANTECED'						 
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

					--	where CO.IdPaciente=234




GO
/****** Object:  View [dbo].[rptViewOrdenInterQuiruExamenApoyoDetalle_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewOrdenInterQuiruExamenApoyoDetalle_FE]
AS
SELECT
		CO.UnidadReplicacion,CO.IdEpisodioAtencion,CO.IdPaciente,CO.EpisodioClinico,CO.UsuarioCreacion,
		CO.UsuarioModificacion,CO.FechaModificacion,CO.FechaCreacion,CO.Accion,CO.Version,
		--CO.Estado,
		case when  CO.TipoExamen=4
							then Item.DescripcionLocal
							else CM_CO_Componente.Nombre end   AS Examen,
		 CO.Codigo,
		 CO.Cantidad,
		 CO.Especificaciones,
		 CO.TipoExamen,
		 CO.Secuencia,
		 /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      PERSONAMAST.ApellidoPaterno,PERSONAMAST.ApellidoMaterno,PERSONAMAST.Nombres,PERSONAMAST.NombreCompleto, 
                      PERSONAMAST.Busqueda,PERSONAMAST.TipoDocumento,PERSONAMAST.Documento,PERSONAMAST.FechaNacimiento, 
                      PERSONAMAST.Sexo,PERSONAMAST.EstadoCivil,PERSONAMAST.edad as PersonaEdad
                      --EPI ATENCIÓN
                      ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoOrdenAtencion  AS TipoOrdenAtencionPac
                      ,SS_HC_EpisodioAtencion.TipoAtencion
                      ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                      ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio
                      ,SS_HC_EpisodioAtencion.IdPersonalSalud
                      ,SS_HC_EpisodioAtencion.FechaRegistro AS FechaRegistroPac
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      ,SS_HC_EpisodioAtencion.IdEspecialidad AS IdEspecialidadPac
                      ,SS_HC_EpisodioAtencion.IdTipoOrden
                      ,SS_HC_EpisodioAtencion.Estado as estadoEpiAtencion
                      ,SS_HC_EpisodioAtencion.Accion as Expr101  --AUX
                      ,SS_HC_EpisodioAtencion.ObservacionProxima as Expr102 --AUX
                      ,SS_HC_EpisodioAtencion.Accion as Expr103 --AUX                      
                      ,SS_GE_TipoAtencion.Descripcion as TipoAtencionDesc
                      ,SS_TipoTrabajador.DescripcionLocal as TipoTrabajadorDesc
                      ,CM_CO_Establecimiento.Codigo as EstablecimientoCodigo
                      ,CM_CO_Establecimiento.Nombre as EstablecimientoDesc
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
     
				FROM SS_HC_OrdenInterQuiruExamenApoyoDetalle_FE CO
				INNER JOIN  SS_HC_EpisodioAtencion ON 
                    SS_HC_EpisodioAtencion.UnidadReplicacion = CO.UnidadReplicacion   AND
					 CO.IdEpisodioAtencion =(case when SS_HC_EpisodioAtencion.TipoAtencion IN (2,3) then
					SS_HC_EpisodioAtencion.IdEpisodioAtencion else SS_HC_EpisodioAtencion.EpisodioAtencion end) 	AND 				
                    CO.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND
                    CO.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico
					INNER JOIN  PERSONAMAST ON CO.IdPaciente = PERSONAMAST.Persona                    
					LEFT JOIN SS_GE_TipoAtencion ON SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
					LEFT JOIN	SS_TipoTrabajador ON SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador
					LEFT JOIN  CM_CO_Establecimiento ON CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud
					LEFT JOIN  SS_HC_UnidadServicio ON SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
                               /****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/           AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
                    LEFT JOIN  PERSONAMAST AS PERSONA_PERSSALUD ON PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud                    
                    LEFT JOIN  SS_GE_Especialidad ON SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad 
					LEFT JOIN    CM_CO_Componente ON CM_CO_Componente.CodigoComponente =CO.Codigo
                      --ADD CMP  y RNE
					 LEFT JOIN  WH_ItemMast AS Item ON   				
						--ltrim(rtrim(Item.LINEA))+'-'+ltrim(rtrim(Item.FAMILIA))+'-'+ltrim(rtrim(Item.SUBFAMILIA))+'-'+  
						ltrim(rtrim(Item.ITEM)) =  CO.Codigo and CO.TipoExamen = 4
                    LEFT JOIN dbo.EMPLEADOMAST  as EMPLEADO_PERSSALUD ON EMPLEADO_PERSSALUD.Empleado = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
                    LEFT JOIN dbo.SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED ON (ESPECIALIDAD_MED.IdMedico = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
						And ESPECIALIDAD_MED.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad
						)


GO

/****** Object:  View [dbo].[rptViewOrdenInterQuirurgica_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewOrdenInterQuirurgica_FE]
AS
			SELECT    CV.*, 
                /**********ADD GENERALES****************/                      
                --(PERSONAS)
				dbo.PERSONAMAST.Telefono as ApellidoPaterno, 
				dbo.PERSONAMAST.Celular as ApellidoMaterno, 
				dbo.PERSONAMAST.Nombres, 
				dbo.PERSONAMAST.NombreCompleto, 
				PERSONAMAST.CorreoElectronico as Busqueda ,
				CASE dbo.PERSONAMAST.TipoDocumento
					  WHEN 'D' THEN
					  'Documento'
						WHEN 'R' THEN
					  'RUC'
					  ELSE 'NULL'
					END as TipoDocumento,					   
					    dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.FechaNacimiento, 
                      dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.edad as PersonaEdad
                      --EPI ATENCIÓN
                      ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoOrdenAtencion  AS TipoOrdenAtencionPac
                      ,SS_HC_EpisodioAtencion.TipoAtencion
                      ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                      ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio
                      ,SS_HC_EpisodioAtencion.IdPersonalSalud
                      ,SS_HC_EpisodioAtencion.FechaRegistro
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      ,SS_HC_EpisodioAtencion.IdEspecialidad AS IdEspecialidadPac
                      ,SS_HC_EpisodioAtencion.IdTipoOrden
                      ,SS_HC_EpisodioAtencion.Estado as estadoEpiAtencion  
                      ,CV.TiempoEnfermedad as Expr101  --AUX   
                      ,CONVERT(VARCHAR, CV.FechaIntervencion, 103) as Expr102 --AUX
                      ,SS_HC_EpisodioAtencion.Accion as Expr103 --AUX                      
                      --
                      ,SS_GE_TipoAtencion.Descripcion as TipoAtencionDesc
                      ,SS_TipoTrabajador.DescripcionLocal as TipoTrabajadorDesc
                      ,CM_CO_Establecimiento.Codigo as EstablecimientoCodigo
                      ,Sucursal.DescripcionLocal as EstablecimientoDesc
                      ,EMPLEADO_PERSSALUD.FirmaDigital  as UnidadServicioCodigo
                      ,SS_HC_UnidadServicio.Descripcion as UnidadServicioDesc
                      ,PERSONA_PERSSALUD.NombreCompleto as PersMedicoNombreCompleto
                      ,PERSONA_PERSSALUD.Documento as PersMedicoNombreDocumento
                      ,SS_GE_Especialidad.Codigo as EspecialidadCodigo
                      ,SS_GE_Especialidad.Nombre as EspecialidadDesc
					  ,EMPLEADO_PERSSALUD.CMP AS CMP
					  ,ESPECIALIDAD_MED.NumeroRegistroEspecialidad AS RNE
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
	FROM       SS_HC_OrdenIntervencionQuirurgicaCab_FE CV WITH(NOLOCK) 
	INNER JOIN  SS_HC_EpisodioAtencion  WITH(NOLOCK) ON 
                    SS_HC_EpisodioAtencion.UnidadReplicacion = CV.UnidadReplicacion   AND
				     CV.IdEpisodioAtencion =(case when SS_HC_EpisodioAtencion.TipoAtencion IN (2,3) then
					SS_HC_EpisodioAtencion.IdEpisodioAtencion else SS_HC_EpisodioAtencion.EpisodioAtencion end) 
					and
                    CV.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND
                    CV.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico
	INNER JOIN  PERSONAMAST  WITH(NOLOCK) ON CV.IdPaciente = PERSONAMAST.Persona                    
	LEFT JOIN SS_GE_TipoAtencion  WITH(NOLOCK) ON 
                    SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
	LEFT JOIN SS_TipoTrabajador  WITH(NOLOCK) ON 
                    SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador
	LEFT JOIN  CM_CO_Establecimiento  WITH(NOLOCK) ON
                    CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud
	LEFT JOIN  SS_HC_UnidadServicio  WITH(NOLOCK) ON 
                    SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
                               /****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/           
							   AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
    LEFT JOIN  PERSONAMAST AS PERSONA_PERSSALUD  WITH(NOLOCK) ON 
                    PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
    LEFT JOIN  SS_GE_Especialidad  WITH(NOLOCK) ON 
                    SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad 
    LEFT JOIN  EMPLEADOMAST AS EMPLEADO_PERSSALUD  WITH(NOLOCK) ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud 
    LEFT JOIN  SS_GE_EspecialidadMedico AS ESPECIALIDAD_MED  WITH(NOLOCK) ON 
                    (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud AND
                    ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad)
	LEFT JOIN		AC_Sucursal  AS Sucursal				WITH(NOLOCK) on   Sucursal.Sucursal = CV.UnidadReplicacion
GO

/****** Object:  View [dbo].[rptViewPartograma_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewPartograma_FE]
AS

SELECT       SS_HC_Partograma_FE.Accion,SS_HC_Partograma_FE.Acetona,SS_HC_Partograma_FE.ContracTEENmin,SS_HC_Partograma_FE.DescensoCefalico,SS_HC_Partograma_FE.DilatacionCuelloUt,SS_HC_Partograma_FE.DuracionContracciones,SS_HC_Partograma_FE.EpisodioClinico,
				SS_HC_Partograma_FE.FVPresionArterial,SS_HC_Partograma_FE.FVPresionArterialD,SS_HC_Partograma_FE.FVPulso,SS_HC_Partograma_FE.FVTemperatura,CAST(SS_HC_Partograma_FE.Fecha as DATE) as Fecha,convert(char(5), SS_HC_Partograma_FE.Fecha, 108) as Hora,
				SS_HC_Partograma_FE.FechaCreacion,SS_HC_Partograma_FE.FechaModificacion,SS_HC_Partograma_FE.FrecCardiacaFetal,SS_HC_Partograma_FE.IdEpisodioAtencion,SS_HC_Partograma_FE.IdPaciente,SS_HC_Partograma_FE.Liquido,SS_HC_Partograma_FE.Membranas,SS_HC_Partograma_FE.Oxitocina,
				SS_HC_Partograma_FE.Proteina,SS_HC_Partograma_FE.TactosVaginales,SS_HC_Partograma_FE.UnidadReplicacion,SS_HC_Partograma_FE.UsuarioCreacion,SS_HC_Partograma_FE.Version,SS_HC_Partograma_FE.Volumen,
				convert(char(5), SS_HC_PartogramaDetalle_FE.Hora, 108) as HoraMed,SS_HC_PartogramaDetalle_FE.Medicamento,SS_HC_PartogramaDetalle_FE.Secuencia,
						 /**********ADD GENERALES****************/ 
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
		SS_HC_EpisodioAtencion.ObservacionProxima AS ObservacionProximaEpiAtencion,

		SS_GE_TipoAtencion.Descripcion AS TipoAtencionDesc,
		SS_TipoTrabajador.DescripcionLocal AS TipoTrabajadorDesc,

		CM_CO_Establecimiento.Codigo AS EstablecimientoCodigo, 
		CM_CO_Establecimiento.Nombre AS EstablecimientoDesc,
	 
		SS_HC_UnidadServicio.Codigo AS UnidadServicioCodigo, 
		SS_HC_UnidadServicio.Descripcion AS UnidadServicioDesc

		FROM SS_HC_Partograma_FE 
		INNER JOIN SS_HC_PartogramaDetalle_FE
		ON SS_HC_Partograma_FE.UnidadReplicacion = SS_HC_PartogramaDetalle_FE.UnidadReplicacion AND 
			SS_HC_Partograma_FE.IdEpisodioAtencion = SS_HC_PartogramaDetalle_FE.IdEpisodioAtencion AND 
			SS_HC_Partograma_FE.IdPaciente = SS_HC_PartogramaDetalle_FE.IdPaciente AND 
			SS_HC_Partograma_FE.EpisodioClinico = SS_HC_PartogramaDetalle_FE.EpisodioClinico
		
		/**********ADD GENERALES****************/ 
		left JOIN PERSONAMAST 
			ON SS_HC_Partograma_FE.IdPaciente = PERSONAMAST.Persona 	
			
		INNER JOIN SS_HC_EpisodioAtencion 
			ON SS_HC_Partograma_FE.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion AND 
				SS_HC_Partograma_FE.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND 
				SS_HC_Partograma_FE.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND 
				SS_HC_Partograma_FE.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
		left outer join	SS_GE_TipoAtencion 
			on SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion 
		left outer join SS_TipoTrabajador 
			on SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador 
		left outer join	CM_CO_Establecimiento 
			on CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud 
		left outer join SS_HC_UnidadServicio
            on SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
               and CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud -- Validacion
        left JOIN PERSONAMAST MED
			ON SS_HC_EpisodioAtencion.IdPersonalSalud = MED.Persona  

GO

/****** Object:  View [dbo].[rptViewPreOperatorio_1_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewPreOperatorio_1_FE]
AS
SELECT	
		SS_HC_Pre_Operatorio_1_FE.[TipoCirugia],
		SS_HC_Pre_Operatorio_1_FE.[IdCirujano],
		SS_HC_Pre_Operatorio_1_FE.[NomCirujano],
		SS_HC_Pre_Operatorio_1_FE.[IdEnfermera],
		SS_HC_Pre_Operatorio_1_FE.[NomEnfemera],
		u2.Descripcion as Servicio,
		SS_HC_Pre_Operatorio_1_FE.[Revisado],
		SS_HC_Pre_Operatorio_1_FE.[Respuesta1],
		SS_HC_Pre_Operatorio_1_FE.[Respuesta2],
		SS_HC_Pre_Operatorio_1_FE.[Respuesta3],
		SS_HC_Pre_Operatorio_1_FE.[Respuesta4],
		SS_HC_Pre_Operatorio_1_FE.[Respuesta5],
		SS_HC_Pre_Operatorio_1_FE.[Respuesta6],
		SS_HC_Pre_Operatorio_1_FE.[Respuesta7],
		SS_HC_Pre_Operatorio_1_FE.[Respuesta8],
		SS_HC_Pre_Operatorio_1_FE.[Respuesta9],
		SS_HC_Pre_Operatorio_1_FE.[Respuesta10],
		SS_HC_Pre_Operatorio_1_FE.[Respuesta11],
		SS_HC_Pre_Operatorio_1_FE.[Respuesta12],
		SS_HC_Pre_Operatorio_1_FE.[Respuesta13],
		SS_HC_Pre_Operatorio_1_FE.[Respuesta14],
		SS_HC_Pre_Operatorio_1_FE.[Respuesta15],
		SS_HC_Pre_Operatorio_1_FE.[Respuesta16],
		SS_HC_Pre_Operatorio_1_FE.[Respuesta17],
		SS_HC_Pre_Operatorio_1_FE.[Respuesta18],
		SS_HC_Pre_Operatorio_1_FE.[Respuesta19],
		SS_HC_Pre_Operatorio_1_FE.[Respuesta20],
		SS_HC_Pre_Operatorio_1_FE.[Respuesta21],
		SS_HC_Pre_Operatorio_1_FE.Estado,
		SS_HC_Pre_Operatorio_1_FE.UsuarioCreacion,
		SS_HC_Pre_Operatorio_1_FE.FechaCreacion,
		SS_HC_Pre_Operatorio_1_FE.UsuarioModificacion,
		SS_HC_Pre_Operatorio_1_FE.FechaModificacion,
		SS_HC_Pre_Operatorio_1_FE.Accion,
		SS_HC_Pre_Operatorio_1_FE.Version,
		SS_HC_Pre_Operatorio_1_FE.UnidadReplicacion,
		SS_HC_Pre_Operatorio_1_FE.IdEpisodioAtencion,
		SS_HC_Pre_Operatorio_1_FE.IdPaciente,
		SS_HC_Pre_Operatorio_1_FE.EpisodioClinico,

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
		SS_HC_EpisodioAtencion.ObservacionProxima AS ObservacionProximaEpiAtencion,

		SS_GE_TipoAtencion.Descripcion AS TipoAtencionDesc,
		SS_TipoTrabajador.DescripcionLocal AS TipoTrabajadorDesc,

		CM_CO_Establecimiento.Codigo AS EstablecimientoCodigo, 
		CM_CO_Establecimiento.Nombre AS EstablecimientoDesc,
	 
		u1.Codigo AS UnidadServicioCodigo, 
		u1.Descripcion AS UnidadServicioDesc
		

FROM dbo.SS_HC_Pre_Operatorio_1_FE 
		left JOIN PERSONAMAST 
			ON SS_HC_Pre_Operatorio_1_FE.IdPaciente = PERSONAMAST.Persona 
		INNER JOIN SS_HC_EpisodioAtencion 
			ON SS_HC_Pre_Operatorio_1_FE.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion AND 
				SS_HC_Pre_Operatorio_1_FE.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND 
				SS_HC_Pre_Operatorio_1_FE.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND 
				SS_HC_Pre_Operatorio_1_FE.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
		left outer join	SS_GE_TipoAtencion 
			on SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion 
		left outer join SS_TipoTrabajador 
			on SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador 
		left outer join	CM_CO_Establecimiento 
			on CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud 
		left outer join SS_HC_UnidadServicio u1
            on u1.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
               and CM_CO_Establecimiento.IdEstablecimiento=u1.IdEstablecimientoSalud
		left outer join   ss_hc_unidadservicio u2
		on CONCAT(u2.IdEstablecimientoSalud,u2.IdUnidadServicio)=SS_HC_Pre_Operatorio_1_FE.Servicio

GO
/****** Object:  View [dbo].[rptViewPreOperatorio2]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewPreOperatorio2]
AS
	SELECT
		-- Identificadores del Preoperatorio
		PRE.UnidadReplicacion,
		PRE.IdEpisodioAtencion,
		PRE.IdPaciente,
		PRE.EpisodioClinico,
		PRE.IdPreOperatorio2,

		-- Respuestas del Preoperatorio
		PRE.Respuesta1, PRE.Respuesta2, PRE.Respuesta3, PRE.Respuesta4, PRE.Respuesta5,
		PRE.Respuesta6, PRE.Respuesta7, PRE.Respuesta8, PRE.Respuesta9, PRE.Respuesta10,
		PRE.Respuesta11, PRE.Respuesta12, PRE.Respuesta13, PRE.Respuesta14, PRE.Respuesta15,
		PRE.Respuesta16, PRE.Respuesta17, PRE.Respuesta18, PRE.Respuesta19,

		PRE.Lesiones,
		PRE.Accion,

		-- Datos del paciente
		PAC.ApellidoPaterno,
		PAC.ApellidoMaterno,
		PAC.Nombres,
		PAC.NombreCompleto,
		PAC.Busqueda,
		PAC.TipoDocumento,
		PAC.Documento,
		PAC.FechaNacimiento,
		PAC.Sexo,
		PAC.EstadoCivil,
		PAC.edad AS PersonaEdad,

		-- Información del episodio de atención
		EPI.IdOrdenAtencion,
		EPI.CodigoOA,
		EPI.LineaOrdenAtencion,
		EPI.TipoOrdenAtencion,
		EPI.TipoAtencion,
		EPI.TipoTrabajador,
		EPI.IdEstablecimientoSalud,
		EPI.IdUnidadServicio,
		EPI.IdPersonalSalud,
		EPI.FechaRegistro,
		EPI.FechaAtencion,
		EPI.IdEspecialidad,
		EPI.IdTipoOrden,
		EPI.Estado AS EstadoEpiAtencion,
		EPI.ObservacionProxima AS ObservacionProximaEpiAtencion,

		-- Descripciones
		TA.Descripcion AS TipoAtencionDesc,
		TT.DescripcionLocal AS TipoTrabajadorDesc,
		EST.Codigo AS EstablecimientoCodigo,
		EST.Nombre AS EstablecimientoDesc,
		US.Codigo AS UnidadServicioCodigo,
		US.Descripcion AS UnidadServicioDesc

	FROM SS_HC_Pre_Operatorio_2_FE AS PRE WITH (NOLOCK)
	LEFT JOIN PERSONAMAST AS PAC WITH (NOLOCK)
		ON PRE.IdPaciente = PAC.Persona
	INNER JOIN SS_HC_EpisodioAtencion AS EPI WITH (NOLOCK)
		ON PRE.UnidadReplicacion = EPI.UnidadReplicacion
		AND PRE.IdEpisodioAtencion = EPI.IdEpisodioAtencion
		AND PRE.IdPaciente = EPI.IdPaciente
		AND PRE.EpisodioClinico = EPI.EpisodioClinico
	LEFT JOIN SS_GE_TipoAtencion AS TA WITH (NOLOCK)
		ON TA.IdTipoAtencion = EPI.TipoAtencion
	LEFT JOIN SS_TipoTrabajador AS TT WITH (NOLOCK)
		ON TT.TipoTrabajador = EPI.TipoTrabajador
	LEFT JOIN CM_CO_Establecimiento AS EST WITH (NOLOCK)
		ON EST.IdEstablecimiento = EPI.IdEstablecimientoSalud
	LEFT JOIN SS_HC_UnidadServicio AS US WITH (NOLOCK)
		ON US.IdUnidadServicio = EPI.IdUnidadServicio
		AND EST.IdEstablecimiento = US.IdEstablecimientoSalud
	LEFT JOIN PERSONAMAST AS MED WITH (NOLOCK)
		ON EPI.IdPersonalSalud = MED.Persona
GO
/****** Object:  View [dbo].[rptViewPrevencion]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewPrevencion]

as

SELECT			

  dbo.SS_HC_SeguimientoRiesgo.UnidadReplicacion,
				dbo.SS_HC_SeguimientoRiesgo.IdPaciente,
				dbo.SS_HC_SeguimientoRiesgo.EpisodioClinico,
				dbo.SS_HC_SeguimientoRiesgo.IdEpisodioAtencion,										
				
				dbo.SS_HC_CuidadoPreventivo.Descripcion	,
				dbo.SS_HC_CuidadoPreventivo.IdCuidadoPreventivo,
				dbo.SS_HC_SeguimientoRiesgoDetalle.Comentario,
				dbo.SS_HC_SeguimientoRiesgo.FechaSeguimiento , 
				dbo.SS_HC_SeguimientoRiesgo.Secuencia,
				
								
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
                      
FROM         dbo.SS_HC_SeguimientoRiesgo                       
                    INNER JOIN
                      dbo.PERSONAMAST ON dbo.SS_HC_SeguimientoRiesgo.IdPaciente = dbo.PERSONAMAST.Persona
					INNER JOIN
                      dbo.SS_HC_EpisodioAtencion 
                      ON dbo.SS_HC_SeguimientoRiesgo.UnidadReplicacion = dbo.SS_HC_EpisodioAtencion.UnidadReplicacion
                      AND dbo.SS_HC_SeguimientoRiesgo.IdEpisodioAtencion = dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion 
                      AND dbo.SS_HC_SeguimientoRiesgo.IdPaciente = dbo.SS_HC_EpisodioAtencion.IdPaciente 
                      AND dbo.SS_HC_SeguimientoRiesgo.EpisodioClinico = dbo.SS_HC_EpisodioAtencion.EpisodioClinico  
                                                               
					inner join
					
					
                      dbo.SS_GE_TipoAtencion
                      ON dbo.SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
					LEFT JOIN
                      dbo.SS_TipoTrabajador
                      ON dbo.SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
					LEFT JOIN
                      dbo.CM_CO_Establecimiento
                      ON dbo.CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
					LEFT JOIN
                      dbo.SS_HC_UnidadServicio
                      ON dbo.SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                      
                    LEFT JOIN
                      dbo.PERSONAMAST  as PERSONA_PERSSALUD
                      ON PERSONA_PERSSALUD.Persona = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
                    LEFT JOIN
                      dbo.SS_GE_Especialidad  
                      ON SS_GE_Especialidad.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad     
                      --ADD CMP  y RNE
                    LEFT JOIN
                      dbo.EMPLEADOMAST  as EMPLEADO_PERSSALUD
                      ON EMPLEADO_PERSSALUD.Empleado = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
                    LEFT JOIN
                      dbo.SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED
                      ON (ESPECIALIDAD_MED.IdMedico = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
						And ESPECIALIDAD_MED.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad
						)					
					LEFT JOIN
					
					dbo.SS_HC_SeguimientoRiesgoDetalle
					ON
					(
					        dbo.SS_HC_SeguimientoRiesgo.UnidadReplicacion = dbo.SS_HC_SeguimientoRiesgoDetalle.UnidadReplicacion
						AND dbo.SS_HC_SeguimientoRiesgo.IdEpisodioAtencion = dbo.SS_HC_SeguimientoRiesgoDetalle.IdEpisodioAtencion 
						AND dbo.SS_HC_SeguimientoRiesgo.IdPaciente = dbo.SS_HC_SeguimientoRiesgoDetalle.IdPaciente 
						AND dbo.SS_HC_SeguimientoRiesgo.EpisodioClinico = dbo.SS_HC_SeguimientoRiesgoDetalle.EpisodioClinico 
                        AND dbo.SS_HC_SeguimientoRiesgo.Secuencia = SS_HC_SeguimientoRiesgoDetalle.Secuencia
						
						)
					
					LEFT JOIN
                
                   dbo.SS_HC_CuidadoPreventivo
						on 						
						(dbo.SS_HC_CuidadoPreventivo.IdCuidadoPreventivo = SS_HC_SeguimientoRiesgoDetalle.IdCuidadoPreventivo
						)
                  
                     
                     

                  




GO
/****** Object:  View [dbo].[rptViewProximaAtencion]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[rptViewProximaAtencion]
AS
SELECT			dbo.SS_HC_ProximaAtencion.UnidadReplicacion,
				dbo.SS_HC_ProximaAtencion.IdPaciente,
				dbo.SS_HC_ProximaAtencion.EpisodioClinico,
				dbo.SS_HC_ProximaAtencion.IdEpisodioAtencion,
				dbo.SS_HC_ProximaAtencion.Secuencia,
				dbo.SS_HC_ProximaAtencion.Estado,
				dbo.SS_HC_ProximaAtencion.FechaSolicitada,
				dbo.SS_HC_ProximaAtencion.DiagnosticoText,
				dbo.SS_HC_ProximaAtencion.FechaCreacion,
				dbo.SS_HC_ProximaAtencion.FechaPlaneada,
				dbo.SS_HC_ProximaAtencion.FechaModificacion,
				dbo.SS_HC_ProximaAtencion.IdDiagnostico,
				dbo.SS_HC_ProximaAtencion.CodigoComponente,
				dbo.SS_HC_ProximaAtencion.IdPersonalSalud,
				dbo.SS_HC_ProximaAtencion.Observacion,
				dbo.SS_HC_ProximaAtencion.ProcedimientoText,
				dbo.SS_HC_ProximaAtencion.ProximaAtencionFlag,				
				dbo.SS_HC_ProximaAtencion.IdTipoInterConsulta,				
				dbo.SS_HC_ProximaAtencion.Accion as Expr01,
				dbo.SS_HC_ProximaAtencion.Version as Expr02,
				
				
				EMPLEADO_PERSSALUD.CMP,
				
				
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
                                            
FROM         dbo.SS_HC_ProximaAtencion                       
                      INNER JOIN
                      dbo.PERSONAMAST ON dbo.SS_HC_ProximaAtencion.IdPaciente = dbo.PERSONAMAST.Persona
						INNER JOIN
                      dbo.SS_HC_EpisodioAtencion 
                      ON dbo.SS_HC_ProximaAtencion.UnidadReplicacion = dbo.SS_HC_EpisodioAtencion.UnidadReplicacion
                      AND dbo.SS_HC_ProximaAtencion.IdEpisodioAtencion = dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion 
                      AND dbo.SS_HC_ProximaAtencion.IdPaciente = dbo.SS_HC_EpisodioAtencion.IdPaciente 
                      AND dbo.SS_HC_ProximaAtencion.EpisodioClinico = dbo.SS_HC_EpisodioAtencion.EpisodioClinico                                             
					LEFT JOIN
                      dbo.SS_GE_TipoAtencion
                      ON dbo.SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
					LEFT JOIN
                      dbo.SS_TipoTrabajador
                      ON dbo.SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
					LEFT JOIN
                      dbo.CM_CO_Establecimiento
                      ON dbo.CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
					LEFT JOIN
                      dbo.SS_HC_UnidadServicio
                      ON dbo.SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                      
                    LEFT JOIN
                      dbo.PERSONAMAST  as PERSONA_PERSSALUD
                      ON PERSONA_PERSSALUD.Persona = dbo.SS_HC_ProximaAtencion.IdPersonalSalud
                    LEFT JOIN
                      dbo.SS_GE_Especialidad  
                      ON SS_GE_Especialidad.IdEspecialidad = dbo.SS_HC_ProximaAtencion.IdEspecialidad     
                      --ADD CMP  y RNE
                    LEFT JOIN
                    
                    SS_HC_PersonalSalud
                    ON SS_HC_PersonalSalud.IdPersonalSalud = SS_HC_ProximaAtencion.IdPersonalSalud
                      
                    LEFT JOIN
                      dbo.EMPLEADOMAST  as EMPLEADO_PERSSALUD
                      ON EMPLEADO_PERSSALUD.Empleado = dbo.SS_HC_ProximaAtencion.IdPersonalSalud
                    LEFT JOIN
                      dbo.SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED
                      ON (ESPECIALIDAD_MED.IdMedico = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
						And ESPECIALIDAD_MED.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad
						)					
					

GO
/****** Object:  View [dbo].[rptViewProximaAtencion_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

CREATE OR ALTER VIEW [dbo].[rptViewProximaAtencion_FE]
as
SELECT 
PA_FE.*,
ESP.Descripcion
FROM SS_HC_ProximaAtencion_FE AS  PA_FE inner join [SS_GE_Especialidad] AS ESP
on PA_FE.IdEspecialidad= ESP.IdEspecialidad

GO
/****** Object:  View [dbo].[rptViewprueba]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[rptViewprueba]
AS
SELECT     dbo.SS_HC_Anamnesis_EA.UnidadReplicacion, dbo.SS_HC_Anamnesis_EA.IdEpisodioAtencion, dbo.SS_HC_Anamnesis_EA.IdPaciente, 
                      dbo.SS_HC_Anamnesis_EA.EpisodioClinico, dbo.SS_HC_Anamnesis_EA.IdFormaInicio, dbo.SS_HC_Anamnesis_EA.IdCursoEnfermedad, 
                      dbo.SS_HC_Anamnesis_EA.TiempoEnfermedad, dbo.SS_HC_Anamnesis_EA.RelatoCronologico, dbo.SS_HC_Anamnesis_EA.Apetito, dbo.SS_HC_Anamnesis_EA.Sed, 
                      dbo.SS_HC_Anamnesis_EA.Orina, dbo.SS_HC_Anamnesis_EA.Deposiciones, dbo.SS_HC_Anamnesis_EA.Sueno, dbo.SS_HC_Anamnesis_EA.PesoAnterior, 
                      dbo.SS_HC_Anamnesis_EA.Infancia, dbo.SS_HC_Anamnesis_EA.EvaluacionAlimentacionActual, dbo.SS_HC_Anamnesis_EA.Estado, 
                      dbo.SS_HC_Anamnesis_EA.UsuarioCreacion, dbo.SS_HC_Anamnesis_EA.FechaCreacion, dbo.SS_HC_Anamnesis_EA.UsuarioModificacion, 
                      dbo.SS_HC_Anamnesis_EA.FechaModificacion, dbo.SS_HC_Anamnesis_EA.Accion, dbo.SS_HC_Anamnesis_EA.Version, dbo.SS_HC_Anamnesis_EA.MotivoConsulta, 
                      dbo.SS_HC_Anamnesis_EA.ComentarioAdicional, dbo.SS_HC_Anamnesis_EA.Prioridad, dbo.SS_HC_Anamnesis_EA_Sintoma.Secuencia, 
                      dbo.SS_HC_Anamnesis_EA_Sintoma.IdCIAP2, dbo.SS_HC_Anamnesis_EA_Sintoma.Accion AS Expr5, dbo.SS_HC_Anamnesis_EA_Sintoma.Version AS Expr6, 
                      dbo.SS_GE_ProcedimientoMedicoDos.CodigoProcedimientoDos, dbo.SS_GE_ProcedimientoMedicoDos.CodigoPadre, dbo.SS_GE_ProcedimientoMedicoDos.Nombre, 
                      dbo.SS_GE_ProcedimientoMedicoDos.Descripcion, dbo.SS_GE_ProcedimientoMedicoDos.Estado AS Expr1, dbo.SS_GE_ProcedimientoMedicoDos.Orden, 
                      dbo.SS_GE_ProcedimientoMedicoDos.CadenaRecursividad, dbo.SS_GE_ProcedimientoMedicoDos.Nivel, dbo.SS_GE_ProcedimientoMedicoDos.DiagnosticoSiteds, 
                      dbo.SS_GE_ProcedimientoMedicoDos.IndicadorPermitido, dbo.SS_GE_ProcedimientoMedicoDos.tipofolder, dbo.SS_GE_ProcedimientoMedicoDos.NombreTabla, 
                      /***************************************/
                      /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.Nombres, dbo.PERSONAMAST.NombreCompleto, 
                      dbo.PERSONAMAST.Busqueda, dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.FechaNacimiento, 
                      dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.edad
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
                      ,'C:\Jose Arauco\jaav\trabajo\_PROYECTOS\HCE\RecursosVarios\logoSanna.jpg' as ServicioExtra  --AUX
                      ,SS_HC_EpisodioAtencion.ObservacionProxima as codigoHC --AUX
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
                      
                      
                      
FROM         dbo.SS_HC_Anamnesis_EA INNER JOIN
                      dbo.SS_HC_Anamnesis_EA_Sintoma 
                      ON dbo.SS_HC_Anamnesis_EA.UnidadReplicacion = dbo.SS_HC_Anamnesis_EA_Sintoma.UnidadReplicacion
                      AND dbo.SS_HC_Anamnesis_EA.IdEpisodioAtencion = dbo.SS_HC_Anamnesis_EA_Sintoma.IdEpisodioAtencion 
                      AND dbo.SS_HC_Anamnesis_EA.IdPaciente = dbo.SS_HC_Anamnesis_EA_Sintoma.IdPaciente 
                      AND dbo.SS_HC_Anamnesis_EA.EpisodioClinico = dbo.SS_HC_Anamnesis_EA_Sintoma.EpisodioClinico 
                      INNER JOIN
                      dbo.SS_GE_ProcedimientoMedicoDos ON 
                      dbo.SS_HC_Anamnesis_EA_Sintoma.IdCIAP2 = dbo.SS_GE_ProcedimientoMedicoDos.IdProcedimientoDos 
                      INNER JOIN
                      dbo.PERSONAMAST ON dbo.SS_HC_Anamnesis_EA.IdPaciente = dbo.PERSONAMAST.Persona
						INNER JOIN
                      dbo.SS_HC_EpisodioAtencion 
                      ON dbo.SS_HC_Anamnesis_EA.UnidadReplicacion = dbo.SS_HC_EpisodioAtencion.UnidadReplicacion
                      AND dbo.SS_HC_Anamnesis_EA.IdEpisodioAtencion = dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion 
                      AND dbo.SS_HC_Anamnesis_EA.IdPaciente = dbo.SS_HC_EpisodioAtencion.IdPaciente 
                      AND dbo.SS_HC_Anamnesis_EA.EpisodioClinico = dbo.SS_HC_EpisodioAtencion.EpisodioClinico                                             
					LEFT JOIN
                      dbo.SS_GE_TipoAtencion
                      ON dbo.SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
					LEFT JOIN
                      dbo.SS_TipoTrabajador
                      ON dbo.SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
					LEFT JOIN
                      dbo.CM_CO_Establecimiento
                      ON dbo.CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud                      
					LEFT JOIN
                      dbo.SS_HC_UnidadServicio
                      ON dbo.SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                      
                    LEFT JOIN
                      dbo.PERSONAMAST  as PERSONA_PERSSALUD
                      ON PERSONA_PERSSALUD.Persona = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
                    LEFT JOIN
                      dbo.SS_GE_Especialidad  
                      ON SS_GE_Especialidad.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad                      



GO
/****** Object:  View [dbo].[rptViewReferencia_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewReferencia_FE]
AS
SELECT     A.EpisodioClinico, A.UnidadReplicacion, A.IdEpisodioAtencion, A.IdPaciente, R.NroReferencia, (CASE R.Prioridad WHEN '1' THEN 'X' ELSE '' END) AS P_UNO, 
                      (CASE R.Prioridad WHEN '2' THEN 'X' ELSE '' END) AS P_DOS, (CASE R.Prioridad WHEN '3' THEN 'X' ELSE '' END) AS P_TRES, 
                      (CASE R.Prioridad WHEN '4' THEN 'X' ELSE '' END) AS P_CUATRO, (CASE R.Prioridad WHEN '5' THEN 'X' ELSE '' END) AS P_CINCO, R.EstablecimientoOri, 
                      R.ServicioOri, R.EstablecimientoDest, R.ServicioDest, R.IdentificacionUsu, R.Anamnesis, R.EstadoGeneral, R.Glasgow, R.FV_T, R.FV_PA, R.FV_FR, R.FV_FC, 
                      R.Tratamiento AS Exam_aux, R.Motivo, (CASE R.TipoAtencionRef WHEN '1' THEN 'X' ELSE '' END) AS DR_EMERGENCIA, 
                      (CASE R.TipoAtencionRef WHEN '2' THEN 'X' ELSE '' END) AS DR_CONSULTA_EXTERNA, (CASE R.TipoAtencionRef WHEN '3' THEN 'X' ELSE '' END) 
                      AS DR_HOSPITALIZACION, CONVERT(char(10), FechaReferencia, 103) AS FechaReferencia, RIGHT(CONVERT(DATETIME, HoraReferencia, 108), 8) AS HoraReferencia, 
                      PersonaAtiende, (CASE R.CondicionSalida WHEN '1' THEN 'X' ELSE '' END) AS CS_ESTABLE, (CASE R.CondicionSalida WHEN '2' THEN 'X' ELSE '' END) 
                      AS CS_INESTABLE, R.MedicoSanna, R.MedicoAtencion, PM_RR.NombreCompleto AS Respon_ref, PM_RR.cmp AS Colegiatura_ref, 
                      PM_RS.NombreCompleto AS Respon_serv, PM_RS.cmp AS Colegiatura_ser, PM_RA.NombreCompleto AS Respon_acomp, PM_RA.cmp AS Colegiatura_acomp, 
                      PM_RE.NombreCompleto AS Respon_recibe, ISNULL( PM_RE.cmp,'') AS Colegiatura_recib, (CASE R.CondicionSalida WHEN '1' THEN 'X' ELSE '' END) AS CLL_ESTABLE, 
                      (CASE R.CondicionSalida WHEN '2' THEN 'X' ELSE '' END) AS CLL_INESTABLE, (CASE R.CondicionSalida WHEN '3' THEN 'X' ELSE '' END) AS CLL_FALLECIDO, 
                      stuff
                          ((SELECT     ', ' + C.Descripcion
                              FROM         SS_HC_DescansoMedico_FE a INNER JOIN
                                                    SS_HC_DescansoMedico_Diagnostico_FE b ON A.IdEpisodioAtencion = B.IdEpisodioAtencion AND A.UnidadReplicacion = B.UnidadReplicacion AND 
                                                    A.IdPaciente = B.IdPaciente AND A.EpisodioClinico = B.EpisodioClinico INNER JOIN
                                                    SS_GE_Diagnostico C ON C.IdDiagnostico = B.IdDiagnostico FOR XML PATH(''), TYPE ).value('.', 'varchar(MAX)'), 1, 1, '') AS DIAGNOSTICO
FROM         dbo.SS_HC_Referencia_FE R 
                        LEFT OUTER JOIN  PERSONAMAST PM_RR 
                             ON PM_RR.Persona = R.IdResponsableRef 
                        LEFT OUTER JOIN PERSONAMAST PM_RS 
                             ON PM_RS.Persona = R.IdResponsableSer 
                        LEFT OUTER JOIN PERSONAMAST PM_RA 
                             ON PM_RA.Persona = R.IdResponsableAco 
                        LEFT OUTER JOIN PERSONAMAST PM_RE 
                             ON PM_RE.Persona = R.IdResponsableRec, SS_HC_DescansoMedico_FE A 
                        LEFT OUTER JOIN SS_HC_DescansoMedico_Diagnostico_FE b 
                             ON A.IdEpisodioAtencion = B.IdEpisodioAtencion 
                                   AND A.UnidadReplicacion = B.UnidadReplicacion AND 
                                   A.IdPaciente = B.IdPaciente 
                                   AND A.EpisodioClinico = B.EpisodioClinico

GO
/****** Object:  View [dbo].[rptViewResumenParto_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewResumenParto_FE]
AS
SELECT       SS_HC_RESUMEN_PARTO_FE.Accion,SS_HC_RESUMEN_PARTO_FE.Controladora,SS_HC_RESUMEN_PARTO_FE.EpisodioClinico,SS_HC_RESUMEN_PARTO_FE.Estado,SS_HC_RESUMEN_PARTO_FE.FechaCreacion,SS_HC_RESUMEN_PARTO_FE.FechaModificacion,cast(SS_HC_RESUMEN_PARTO_FE.Fecha_Ing as DATE) as Fecha_Ing,
			 convert(char(5),SS_HC_RESUMEN_PARTO_FE.Hora_Ing,108) AS Hora_Ing,convert(char(5),SS_HC_RESUMEN_PARTO_FE.Horas_memb,108) as Horas_memb,SS_HC_RESUMEN_PARTO_FE.IdEpisodioAtencion,SS_HC_RESUMEN_PARTO_FE.IdPaciente,SS_HC_RESUMEN_PARTO_FE.IdResParto,
			 SS_HC_RESUMEN_PARTO_FE.Membranas,SS_HC_RESUMEN_PARTO_FE.Observaciones1_S,SS_HC_RESUMEN_PARTO_FE.Observaciones2_S,SS_HC_RESUMEN_PARTO_FE.P_Dur_Parto,SS_HC_RESUMEN_PARTO_FE.P_Observacion,SS_HC_RESUMEN_PARTO_FE.P_Selector1,SS_HC_RESUMEN_PARTO_FE.P_Selector2,
			 SS_HC_RESUMEN_PARTO_FE.S_Desgarro,SS_HC_RESUMEN_PARTO_FE.S_Dur_Parto,SS_HC_RESUMEN_PARTO_FE.S_Episiotomia,cast(SS_HC_RESUMEN_PARTO_FE.S_Fecha_Parto as DATE) as S_Fecha_Parto,convert(char(5),SS_HC_RESUMEN_PARTO_FE.S_Hora_Parto,108) AS S_Hora_Parto,SS_HC_RESUMEN_PARTO_FE.S_Selector1,
			 SS_HC_RESUMEN_PARTO_FE.S_Selector2,SS_HC_RESUMEN_PARTO_FE.S_Selector3,SS_HC_RESUMEN_PARTO_FE.S_Selector4,SS_HC_RESUMEN_PARTO_FE.UnidadReplicacion,SS_HC_RESUMEN_PARTO_FE.UsuarioCreacion,SS_HC_RESUMEN_PARTO_FE.UsuarioModificacion,SS_HC_RESUMEN_PARTO_FE.Version,
			 SS_HC_RESPARTO_EMB_ACT_FE.AU,SS_HC_RESPARTO_EMB_ACT_FE.EG,SS_HC_RESPARTO_EMB_ACT_FE.EGXFUR,CAST(SS_HC_RESPARTO_EMB_ACT_FE.FPP AS DATE) AS FPP,CAST(SS_HC_RESPARTO_EMB_ACT_FE.FUR AS DATE) AS FUR,SS_HC_RESPARTO_EMB_ACT_FE.PFGECO,
			-- SS_HC_RESPARTO_EMB_ANT_FE.Gravidez,SS_HC_RESPARTO_EMB_ANT_FE.Pariedad1,SS_HC_RESPARTO_EMB_ANT_FE.Pariedad2,SS_HC_RESPARTO_EMB_ANT_FE.Pariedad3,SS_HC_RESPARTO_EMB_ANT_FE.Pariedad4,
				/*SS_HC_Partograma_FE.FVPresionArterial,SS_HC_Partograma_FE.FVPresionArterialD,SS_HC_Partograma_FE.FVPulso,SS_HC_Partograma_FE.FVTemperatura,CAST(SS_HC_Partograma_FE.Fecha as DATE) as Fecha,convert(char(5), SS_HC_Partograma_FE.Fecha, 108) as Hora,
				SS_HC_Partograma_FE.FechaCreacion,SS_HC_Partograma_FE.FechaModificacion,SS_HC_Partograma_FE.FrecCardiacaFetal,SS_HC_Partograma_FE.IdEpisodioAtencion,SS_HC_Partograma_FE.IdPaciente,SS_HC_Partograma_FE.Liquido,SS_HC_Partograma_FE.Membranas,SS_HC_Partograma_FE.Oxitocina,
				SS_HC_Partograma_FE.Proteina,SS_HC_Partograma_FE.TactosVaginales,SS_HC_Partograma_FE.UnidadReplicacion,SS_HC_Partograma_FE.UsuarioCreacion,SS_HC_Partograma_FE.Version,SS_HC_Partograma_FE.Volumen,
				convert(char(5), SS_HC_PartogramaDetalle_FE.Hora, 108) as HoraMed,SS_HC_PartogramaDetalle_FE.Medicamento,SS_HC_PartogramaDetalle_FE.Secuencia,*/
						 /**********ADD GENERALES****************/ 
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
		SS_HC_EpisodioAtencion.ObservacionProxima AS ObservacionProximaEpiAtencion,

		SS_GE_TipoAtencion.Descripcion AS TipoAtencionDesc,
		SS_TipoTrabajador.DescripcionLocal AS TipoTrabajadorDesc,

		CM_CO_Establecimiento.Codigo AS EstablecimientoCodigo, 
		CM_CO_Establecimiento.Nombre AS EstablecimientoDesc,
	 
		SS_HC_UnidadServicio.Codigo AS UnidadServicioCodigo, 
		SS_HC_UnidadServicio.Descripcion AS UnidadServicioDesc

FROM            SS_HC_RESUMEN_PARTO_FE 
		INNER JOIN SS_HC_RESPARTO_EMB_ACT_FE
	ON SS_HC_RESUMEN_PARTO_FE.UnidadReplicacion = SS_HC_RESPARTO_EMB_ACT_FE.UnidadReplicacion AND 
		SS_HC_RESUMEN_PARTO_FE.IdEpisodioAtencion = SS_HC_RESPARTO_EMB_ACT_FE.IdEpisodioAtencion AND 
		SS_HC_RESUMEN_PARTO_FE.IdPaciente = SS_HC_RESPARTO_EMB_ACT_FE.IdPaciente AND 
		SS_HC_RESUMEN_PARTO_FE.EpisodioClinico = SS_HC_RESPARTO_EMB_ACT_FE.EpisodioClinico

	--	INNER JOIN SS_HC_RESPARTO_EMB_ANT_FE
	--ON SS_HC_RESUMEN_PARTO_FE.UnidadReplicacion = SS_HC_RESPARTO_EMB_ANT_FE.UnidadReplicacion AND 
	--	SS_HC_RESUMEN_PARTO_FE.IdEpisodioAtencion = SS_HC_RESPARTO_EMB_ANT_FE.IdEpisodioAtencion AND 
	--	SS_HC_RESUMEN_PARTO_FE.IdPaciente = SS_HC_RESPARTO_EMB_ANT_FE.IdPaciente AND 
	--	SS_HC_RESUMEN_PARTO_FE.EpisodioClinico = SS_HC_RESPARTO_EMB_ANT_FE.EpisodioClinico
		
		
		/**********ADD GENERALES****************/ 
		left JOIN PERSONAMAST 
			ON SS_HC_RESUMEN_PARTO_FE.IdPaciente = PERSONAMAST.Persona 
		
			
		INNER JOIN SS_HC_EpisodioAtencion 
			ON SS_HC_RESUMEN_PARTO_FE.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion AND 
				SS_HC_RESUMEN_PARTO_FE.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND 
				SS_HC_RESUMEN_PARTO_FE.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND 
				SS_HC_RESUMEN_PARTO_FE.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
		left outer join	SS_GE_TipoAtencion 
			on SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion 
		left outer join SS_TipoTrabajador 
			on SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador 
		left outer join	CM_CO_Establecimiento 
			on CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud 
		left outer join SS_HC_UnidadServicio
            on SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
               and CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud -- Validacion
              		left JOIN PERSONAMAST MED
			ON SS_HC_EpisodioAtencion.IdPersonalSalud = MED.Persona  
			
			--where SS_HC_RESPARTO_EMB_ACT_FE.Secuencia=SS_HC_RESPARTO_EMB_ANT_FE.Secuencia






GO
/****** Object:  View [dbo].[rptViewResumenParto_FE_Det]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewResumenParto_FE_Det]
AS

SELECT       SS_HC_RESUMEN_PARTO_FE.Accion,SS_HC_RESUMEN_PARTO_FE.Controladora,SS_HC_RESUMEN_PARTO_FE.EpisodioClinico,SS_HC_RESUMEN_PARTO_FE.Estado,SS_HC_RESUMEN_PARTO_FE.FechaCreacion,SS_HC_RESUMEN_PARTO_FE.FechaModificacion,cast(SS_HC_RESUMEN_PARTO_FE.Fecha_Ing as DATE) as Fecha_Ing,
			 convert(char(5),SS_HC_RESUMEN_PARTO_FE.Hora_Ing,108) AS Hora_Ing,convert(char(5),SS_HC_RESUMEN_PARTO_FE.Horas_memb,108) as Horas_memb,SS_HC_RESUMEN_PARTO_FE.IdEpisodioAtencion,SS_HC_RESUMEN_PARTO_FE.IdPaciente,SS_HC_RESUMEN_PARTO_FE.IdResParto,
			 SS_HC_RESUMEN_PARTO_FE.Membranas,SS_HC_RESUMEN_PARTO_FE.Observaciones1_S,SS_HC_RESUMEN_PARTO_FE.Observaciones2_S,SS_HC_RESUMEN_PARTO_FE.P_Dur_Parto,SS_HC_RESUMEN_PARTO_FE.P_Observacion,SS_HC_RESUMEN_PARTO_FE.P_Selector1,SS_HC_RESUMEN_PARTO_FE.P_Selector2,
			 SS_HC_RESUMEN_PARTO_FE.S_Desgarro,SS_HC_RESUMEN_PARTO_FE.S_Dur_Parto,SS_HC_RESUMEN_PARTO_FE.S_Episiotomia,cast(SS_HC_RESUMEN_PARTO_FE.S_Fecha_Parto as DATE) as S_Fecha_Parto,convert(char(5),SS_HC_RESUMEN_PARTO_FE.S_Hora_Parto,108) AS S_Hora_Parto,SS_HC_RESUMEN_PARTO_FE.S_Selector1,
			 SS_HC_RESUMEN_PARTO_FE.S_Selector2,SS_HC_RESUMEN_PARTO_FE.S_Selector3,SS_HC_RESUMEN_PARTO_FE.S_Selector4,SS_HC_RESUMEN_PARTO_FE.UnidadReplicacion,SS_HC_RESUMEN_PARTO_FE.UsuarioCreacion,SS_HC_RESUMEN_PARTO_FE.UsuarioModificacion,SS_HC_RESUMEN_PARTO_FE.Version,
			-- SS_HC_RESPARTO_EMB_ACT_FE.AU,SS_HC_RESPARTO_EMB_ACT_FE.EG,SS_HC_RESPARTO_EMB_ACT_FE.EGXFUR,CAST(SS_HC_RESPARTO_EMB_ACT_FE.FPP AS DATE) AS FPP,CAST(SS_HC_RESPARTO_EMB_ACT_FE.FUR AS DATE) AS FUR,SS_HC_RESPARTO_EMB_ACT_FE.PFGECO,
			 SS_HC_RESPARTO_EMB_ANT_FE.Gravidez,SS_HC_RESPARTO_EMB_ANT_FE.Pariedad1,SS_HC_RESPARTO_EMB_ANT_FE.Pariedad2,SS_HC_RESPARTO_EMB_ANT_FE.Pariedad3,SS_HC_RESPARTO_EMB_ANT_FE.Pariedad4,
				/*SS_HC_Partograma_FE.FVPresionArterial,SS_HC_Partograma_FE.FVPresionArterialD,SS_HC_Partograma_FE.FVPulso,SS_HC_Partograma_FE.FVTemperatura,CAST(SS_HC_Partograma_FE.Fecha as DATE) as Fecha,convert(char(5), SS_HC_Partograma_FE.Fecha, 108) as Hora,
				SS_HC_Partograma_FE.FechaCreacion,SS_HC_Partograma_FE.FechaModificacion,SS_HC_Partograma_FE.FrecCardiacaFetal,SS_HC_Partograma_FE.IdEpisodioAtencion,SS_HC_Partograma_FE.IdPaciente,SS_HC_Partograma_FE.Liquido,SS_HC_Partograma_FE.Membranas,SS_HC_Partograma_FE.Oxitocina,
				SS_HC_Partograma_FE.Proteina,SS_HC_Partograma_FE.TactosVaginales,SS_HC_Partograma_FE.UnidadReplicacion,SS_HC_Partograma_FE.UsuarioCreacion,SS_HC_Partograma_FE.Version,SS_HC_Partograma_FE.Volumen,
				convert(char(5), SS_HC_PartogramaDetalle_FE.Hora, 108) as HoraMed,SS_HC_PartogramaDetalle_FE.Medicamento,SS_HC_PartogramaDetalle_FE.Secuencia,*/
						 /**********ADD GENERALES****************/ 
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
		SS_HC_EpisodioAtencion.ObservacionProxima AS ObservacionProximaEpiAtencion,

		SS_GE_TipoAtencion.Descripcion AS TipoAtencionDesc,
		SS_TipoTrabajador.DescripcionLocal AS TipoTrabajadorDesc,

		CM_CO_Establecimiento.Codigo AS EstablecimientoCodigo, 
		CM_CO_Establecimiento.Nombre AS EstablecimientoDesc,
	 
		SS_HC_UnidadServicio.Codigo AS UnidadServicioCodigo, 
		SS_HC_UnidadServicio.Descripcion AS UnidadServicioDesc

FROM            SS_HC_RESUMEN_PARTO_FE 
	--	INNER JOIN SS_HC_RESPARTO_EMB_ACT_FE
	--ON SS_HC_RESUMEN_PARTO_FE.UnidadReplicacion = SS_HC_RESPARTO_EMB_ACT_FE.UnidadReplicacion AND 
	--	SS_HC_RESUMEN_PARTO_FE.IdEpisodioAtencion = SS_HC_RESPARTO_EMB_ACT_FE.IdEpisodioAtencion AND 
	--	SS_HC_RESUMEN_PARTO_FE.IdPaciente = SS_HC_RESPARTO_EMB_ACT_FE.IdPaciente AND 
	--	SS_HC_RESUMEN_PARTO_FE.EpisodioClinico = SS_HC_RESPARTO_EMB_ACT_FE.EpisodioClinico

		INNER JOIN SS_HC_RESPARTO_EMB_ANT_FE
	ON SS_HC_RESUMEN_PARTO_FE.UnidadReplicacion = SS_HC_RESPARTO_EMB_ANT_FE.UnidadReplicacion AND 
		SS_HC_RESUMEN_PARTO_FE.IdEpisodioAtencion = SS_HC_RESPARTO_EMB_ANT_FE.IdEpisodioAtencion AND 
		SS_HC_RESUMEN_PARTO_FE.IdPaciente = SS_HC_RESPARTO_EMB_ANT_FE.IdPaciente AND 
		SS_HC_RESUMEN_PARTO_FE.EpisodioClinico = SS_HC_RESPARTO_EMB_ANT_FE.EpisodioClinico
		
		
		/**********ADD GENERALES****************/ 
		left JOIN PERSONAMAST 
			ON SS_HC_RESUMEN_PARTO_FE.IdPaciente = PERSONAMAST.Persona 
		
			
		INNER JOIN SS_HC_EpisodioAtencion 
			ON SS_HC_RESUMEN_PARTO_FE.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion AND 
				SS_HC_RESUMEN_PARTO_FE.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND 
				SS_HC_RESUMEN_PARTO_FE.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND 
				SS_HC_RESUMEN_PARTO_FE.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
		left outer join	SS_GE_TipoAtencion 
			on SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion 
		left outer join SS_TipoTrabajador 
			on SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador 
		left outer join	CM_CO_Establecimiento 
			on CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud 
		left outer join SS_HC_UnidadServicio
            on SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
               and CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud -- Validacion
              		left JOIN PERSONAMAST MED
			ON SS_HC_EpisodioAtencion.IdPersonalSalud = MED.Persona  
			
			--where SS_HC_RESPARTO_EMB_ACT_FE.Secuencia=SS_HC_RESPARTO_EMB_ANT_FE.Secuencia






GO
/****** Object:  View [dbo].[rptViewRetiroVoluntario_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[rptViewRetiroVoluntario_FE]
AS
SELECT 

		SS_HC_RetiroVoluntario_FE.UnidadReplicacion,
		SS_HC_RetiroVoluntario_FE.IdEpisodioAtencion,
		SS_HC_RetiroVoluntario_FE.IdPaciente,
		SS_HC_RetiroVoluntario_FE.EpisodioClinico,
		SS_HC_RetiroVoluntario_FE.IdRetiroVoluntario,
		SS_HC_RetiroVoluntario_FE.FechaIngreso,
		SS_HC_RetiroVoluntario_FE.HoraIngreso,
		SS_HC_RetiroVoluntario_FE.RepresentanteLegal,
		SS_HC_RetiroVoluntario_FE.IdPersonalSalud,
		SS_HC_RetiroVoluntario_FE.UsuarioCreacion,
		SS_HC_RetiroVoluntario_FE.FechaCreacion,
		SS_HC_RetiroVoluntario_FE.UsuarioModificacion,
		SS_HC_RetiroVoluntario_FE.FechaModificacion,
		SS_HC_RetiroVoluntario_FE.Accion,
		SS_HC_RetiroVoluntario_FE.Version,

		/**********ADD GENERALES****************/ 
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
		--SS_HC_EpisodioAtencion.IdPersonalSalud, 
		SS_HC_EpisodioAtencion.FechaRegistro, 
		SS_HC_EpisodioAtencion.FechaAtencion, 
		SS_HC_EpisodioAtencion.IdEspecialidad, 
		SS_HC_EpisodioAtencion.IdTipoOrden, 
		SS_HC_EpisodioAtencion.Estado AS estadoEpiAtencion,
		SS_HC_EpisodioAtencion.ObservacionProxima AS ObservacionProximaEpiAtencion,

		SS_GE_TipoAtencion.Descripcion AS TipoAtencionDesc,
		SS_TipoTrabajador.DescripcionLocal AS TipoTrabajadorDesc,

		CM_CO_Establecimiento.Codigo AS EstablecimientoCodigo, 
		CM_CO_Establecimiento.Nombre AS EstablecimientoDesc,
	 
		SS_HC_UnidadServicio.Codigo AS UnidadServicioCodigo, 
		SS_HC_UnidadServicio.Descripcion AS UnidadServicioDesc
		, PERSONA_PERSSALUD.NombreCompleto as NombreCompletoPerSalud
		, EMPLEADO_PERSSALUD.CMP
		, SS_GE_Paciente.CodigoHC
		, '' as Cama


FROM [dbo].SS_HC_RetiroVoluntario_FE
		/**********ADD GENERALES****************/ 
		left join PERSONAMAST 
			ON SS_HC_RetiroVoluntario_FE.IdPaciente = PERSONAMAST.Persona 
		INNER JOIN SS_HC_EpisodioAtencion 
			ON SS_HC_RetiroVoluntario_FE.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion AND 
				SS_HC_RetiroVoluntario_FE.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND 
				SS_HC_RetiroVoluntario_FE.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND 
				SS_HC_RetiroVoluntario_FE.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico 
		left outer join	SS_GE_TipoAtencion 
			on SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion 
		left outer join SS_TipoTrabajador 
			on SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador 
		left outer join	CM_CO_Establecimiento 
			on CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud 
		left outer join SS_HC_UnidadServicio
            on SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
               and CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud -- Validacion
		left outer join SS_GE_Paciente
			on SS_GE_Paciente.IdPaciente = SS_HC_RetiroVoluntario_FE.IdPaciente
        left join  PERSONAMAST  as PERSONA_PERSSALUD
            ON PERSONA_PERSSALUD.Persona = SS_HC_RetiroVoluntario_FE.IdPersonalSalud
         left join EMPLEADOMAST  as EMPLEADO_PERSSALUD
            on EMPLEADO_PERSSALUD.Empleado = SS_HC_RetiroVoluntario_FE.IdPersonalSalud



GO
/****** Object:  View [dbo].[rptViewSeguridadCirugia_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewSeguridadCirugia_FE]
AS
SELECT SC.*,
 /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.Nombres, dbo.PERSONAMAST.NombreCompleto, 
                      dbo.PERSONAMAST.Busqueda, dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.FechaNacimiento, 
                      dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.edad as PersonaEdad
                      --EPI ATENCIÓN
                      ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoOrdenAtencion  AS TipoOrdenAtencionPac
                      ,SS_HC_EpisodioAtencion.TipoAtencion
                      ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                      ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio
                      ,SS_HC_EpisodioAtencion.IdPersonalSalud
                      ,SS_HC_EpisodioAtencion.FechaRegistro AS FechaRegistroPac
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      ,SS_HC_EpisodioAtencion.IdEspecialidad AS IdEspecialidadPac
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
                           
FROM dbo.SS_HC_SeguridadCirugia_FE SC
INNER JOIN  SS_HC_EpisodioAtencion ON 
                    SS_HC_EpisodioAtencion.UnidadReplicacion = SC.UnidadReplicacion   AND
                    SC.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND
                    SC.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND
                    SC.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico
INNER JOIN  PERSONAMAST ON SC.IdPaciente = PERSONAMAST.Persona                    
LEFT JOIN SS_GE_TipoAtencion ON 
                    SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
LEFT JOIN
                    SS_TipoTrabajador ON 
                    SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador
LEFT JOIN  CM_CO_Establecimiento ON
                    CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud

LEFT JOIN  SS_HC_UnidadServicio ON 
                    SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
                               /****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/           AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
                    LEFT JOIN  PERSONAMAST AS PERSONA_PERSSALUD ON 
                    PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
                    
                    LEFT JOIN  SS_GE_Especialidad ON 
                    SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad 
                    
                    --LEFT JOIN
                    --SS_GE_ProcedimientoMedico ON 
                    --(SS_GE_ProcedimientoMedico.IdProcedimiento = SC.IdProcedimiento AND SC.TipoCodigo = 'C')
                    
                    LEFT JOIN
                    EMPLEADOMAST AS EMPLEADO_PERSSALUD ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud 
                    
                    LEFT JOIN
                    SS_GE_EspecialidadMedico AS ESPECIALIDAD_MED ON 
                    (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud AND
                    ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad)




GO
/****** Object:  View [dbo].[rptViewSolicitarReferencias]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewSolicitarReferencias]
AS
SELECT			dbo.SS_HC_ProximaAtencion.UnidadReplicacion,
				dbo.SS_HC_ProximaAtencion.IdPaciente,
				dbo.SS_HC_ProximaAtencion.EpisodioClinico,
				dbo.SS_HC_ProximaAtencion.IdEpisodioAtencion,
				dbo.SS_HC_ProximaAtencion.Secuencia,
				dbo.SS_HC_ProximaAtencion.Estado,
				dbo.SS_HC_ProximaAtencion.FechaSolicitada,				
				dbo.SS_HC_ProximaAtencion.FechaCreacion,				
				dbo.SS_HC_ProximaAtencion.FechaModificacion,				
				dbo.SS_HC_ProximaAtencion.Observacion,
				dbo.SS_HC_ProximaAtencion.idEspecialidad,
				dbo.SS_HC_ProximaAtencion.IdEstablecimientoSalud,				
				dbo.SS_HC_ProximaAtencion.ProximaAtencionFlag,		
				dbo.SS_HC_ProximaAtencion.Accion as Expr01,		
				
							
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
                      
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio                      
                      ,SS_HC_EpisodioAtencion.FechaRegistro
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      
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
                                            
FROM         dbo.SS_HC_ProximaAtencion                       
                      INNER JOIN
                      dbo.PERSONAMAST ON dbo.SS_HC_ProximaAtencion.IdPaciente = dbo.PERSONAMAST.Persona
						INNER JOIN
                      dbo.SS_HC_EpisodioAtencion 
                      ON dbo.SS_HC_ProximaAtencion.UnidadReplicacion = dbo.SS_HC_EpisodioAtencion.UnidadReplicacion
                      AND dbo.SS_HC_ProximaAtencion.IdEpisodioAtencion = dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion 
                      AND dbo.SS_HC_ProximaAtencion.IdPaciente = dbo.SS_HC_EpisodioAtencion.IdPaciente 
                      AND dbo.SS_HC_ProximaAtencion.EpisodioClinico = dbo.SS_HC_EpisodioAtencion.EpisodioClinico                                             
					  AND  dbo.SS_HC_ProximaAtencion.ProximaAtencionFlag = 'R' 
					LEFT JOIN
                      dbo.SS_GE_TipoAtencion
                      ON dbo.SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
					LEFT JOIN
                      dbo.SS_TipoTrabajador
                      ON dbo.SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador                      
					LEFT JOIN
                      dbo.CM_CO_Establecimiento
                      ON dbo.CM_CO_Establecimiento.IdEstablecimiento = SS_HC_ProximaAtencion.IdEstablecimientoSalud                      
					LEFT JOIN
                      dbo.SS_HC_UnidadServicio
                      ON dbo.SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio                      
                    LEFT JOIN
                      dbo.PERSONAMAST  as PERSONA_PERSSALUD
                      ON PERSONA_PERSSALUD.Persona = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
                    LEFT JOIN
                      dbo.SS_GE_Especialidad  
                      ON SS_GE_Especialidad.IdEspecialidad = dbo.SS_HC_ProximaAtencion.IdEspecialidad     
                      --ADD CMP  y RNE
                    LEFT JOIN
                    
                    SS_HC_PersonalSalud
                    ON SS_HC_PersonalSalud.IdPersonalSalud = SS_HC_ProximaAtencion.IdPersonalSalud
                      
                    LEFT JOIN
                      dbo.EMPLEADOMAST  as EMPLEADO_PERSSALUD
                      ON EMPLEADO_PERSSALUD.Empleado = dbo.SS_HC_ProximaAtencion.IdPersonalSalud
                    LEFT JOIN
                      dbo.SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED
                      ON (ESPECIALIDAD_MED.IdMedico = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
						And ESPECIALIDAD_MED.IdEspecialidad = dbo.SS_HC_EpisodioAtencion.IdEspecialidad
						)	
						
					

GO
/****** Object:  View [dbo].[rptViewSolicitudProducto]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewSolicitudProducto]
AS
		SELECT  distinct  dbo.SS_FA_SolicitudProducto.UnidadReplicacion, dbo.SS_FA_SolicitudProducto.IdEpisodioAtencion, 
					dbo.SS_FA_SolicitudProducto.IdPaciente, 
                      dbo.SS_FA_SolicitudProducto.EpisodioClinico, dbo.SS_FA_SolicitudProducto.IdSolicitudProducto, 
					  dbo.SS_FA_SolicitudProducto.NumeroDocumento, dbo.SS_FA_SolicitudProducto.Observacion, 
                      dbo.SS_FA_SolicitudProductoDetalle.Secuencia, dbo.SS_FA_SolicitudProductoDetalle.Cantidad, 
					  dbo.SS_FA_SolicitudProductoDetalle.Linea, 
                      dbo.SS_FA_SolicitudProductoDetalle.Familia, dbo.SS_FA_SolicitudProductoDetalle.SubFamilia, 
					  dbo.SS_FA_SolicitudProductoDetalle.CodigoComponente, 
                      PERSONAMAST.NombreCompleto,SS_HC_EpisodioAtencion.CodigoOA,SS_FA_SolicitudProductoDetalle.FechaCreacion,
					  PERSONA_PERSSALUD.NombreCompleto as PersMedicoNombreCompleto
                     ,SS_TipoTrabajador.DescripcionLocal as TipoTrabajadorDesc,
                    ( case when (MED.DescripcionLocal IS NOT null OR MED.DescripcionLocal <> '') 
				     then SS_FA_SolicitudProductoDetalle.Medicamento else SS_FA_SolicitudProductoDetalle.Medicamento end  ) as Medicamento  
		FROM         SS_FA_SolicitudProducto  WITH(NOLOCK) 
		INNER JOIN   SS_FA_SolicitudProductoDetalle WITH(NOLOCK)  ON 
                      dbo.SS_FA_SolicitudProducto.UnidadReplicacion = dbo.SS_FA_SolicitudProductoDetalle.UnidadReplicacion 
                      and dbo.SS_FA_SolicitudProducto.IdPaciente = dbo.SS_FA_SolicitudProductoDetalle.IdPaciente 
                      and dbo.SS_FA_SolicitudProducto.EpisodioClinico = dbo.SS_FA_SolicitudProductoDetalle.EpisodioClinico 
                      and dbo.SS_FA_SolicitudProducto.IdEpisodioAtencion = dbo.SS_FA_SolicitudProductoDetalle.IdEpisodioAtencion 
                      and dbo.SS_FA_SolicitudProducto.IdSolicitudProducto = dbo.SS_FA_SolicitudProductoDetalle.IdSolicitudProducto 
         INNER JOIN  PERSONAMAST  WITH(NOLOCK) ON dbo.SS_FA_SolicitudProducto.IdPaciente = dbo.PERSONAMAST.Persona
		 LEFT JOIN   SS_HC_EpisodioAtencion  WITH(NOLOCK) 
                      ON dbo.SS_FA_SolicitudProducto.UnidadReplicacion = dbo.SS_HC_EpisodioAtencion.UnidadReplicacion
                      AND dbo.SS_FA_SolicitudProducto.IdEpisodioAtencion = dbo.SS_HC_EpisodioAtencion.IdEpisodioAtencion 
                      AND dbo.SS_FA_SolicitudProducto.IdPaciente = dbo.SS_HC_EpisodioAtencion.IdPaciente 
                      AND dbo.SS_FA_SolicitudProducto.EpisodioClinico = dbo.SS_HC_EpisodioAtencion.EpisodioClinico                                             
		 LEFT JOIN   SS_TipoTrabajador WITH(NOLOCK) 
                      ON dbo.SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador 
         LEFT JOIN   PERSONAMAST  as PERSONA_PERSSALUD WITH(NOLOCK) 
                      ON PERSONA_PERSSALUD.Persona = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
         LEFT JOIN   EMPLEADOMAST  as EMPLEADO_PERSSALUD WITH(NOLOCK) 
                      ON EMPLEADO_PERSSALUD.Empleado = dbo.SS_HC_EpisodioAtencion.IdPersonalSalud
         left JOIN   SS_HC_Medicamento_FE  WITH(NOLOCK) 
                      on SS_FA_SolicitudProductoDetalle.Linea = SS_HC_Medicamento_FE.Linea
                      and SS_FA_SolicitudProductoDetalle.Familia = SS_HC_Medicamento_FE.Familia
                      and SS_FA_SolicitudProductoDetalle.SubFamilia = SS_HC_Medicamento_FE.SubFamilia
                      and SS_FA_SolicitudProductoDetalle.CodigoComponente = SS_HC_Medicamento_FE.CodigoComponente
         left JOIN   WH_ClaseSubFamilia DCI  WITH(NOLOCK) on 
						(DCI.Linea = SS_HC_Medicamento_FE.Linea
						AND DCI.Familia = SS_HC_Medicamento_FE.Familia
						AND DCI.SubFamilia = SS_HC_Medicamento_FE.SubFamilia
						AND (SS_HC_Medicamento_FE.CodigoComponente  = '' OR SS_HC_Medicamento_FE.CodigoComponente is null)
						)
					Left join WH_ItemMast MED   WITH(NOLOCK) on
						(MED.Linea = SS_HC_Medicamento_FE.Linea
						AND MED.Familia = SS_HC_Medicamento_FE.Familia
						AND MED.SubFamilia = SS_HC_Medicamento_FE.SubFamilia
						AND ( rtrim(MED.Item)  =  SS_HC_Medicamento_FE.CodigoComponente )
						) 
GO
/****** Object:  View [dbo].[rptViewSolicitudTransfusional_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[rptViewSolicitudTransfusional_FE]
AS
	SELECT
		ST.UnidadReplicacion,
		ST.IdEpisodioAtencion,
		ST.IdPaciente,
		ST.EpisodioClinico,
		ST.FechaSolicitud,
		ST.HoraSolicitud,
		PM_PACIENTE.NombreCompleto AS Nombres_Paciente,
		PM_PACIENTE.Sexo AS Sexo_Paciente,
		PM_PACIENTE.edad AS Edad_paciente,
		GP.CodigoHC,
		GP.CodigoHC AS Nro_cama,
		SS_HC_UnidadServicio.Codigo AS UnidadServicioCodigo, 
		SS_HC_UnidadServicio.Descripcion AS UnidadServicioDesc, 
		ST.TransfusionesPrevias, 
		ST.ReaccionesTransfusionalesAnteriores,
		ST.EmbarazosPrevios,
		ST.EmbarazosPreviosEspecificar,
		ST.Abortos,
		ST.AbortosEspecificar,
		ST.IncompatMaternoFetal, 
		ST.IncompatMaternoFetalEspecificar,
		t_DIAGNOSTICO.Diagnostico AS DiagnosticoEnfermedad,
		ST.Hb,
		ST.Hcto,
		ST.Plaquetas,
		ST.SangreTotalFlag,
		ST.SangreTotalCantidad,
		ST.FraccionPediatricasCantidad,
		ST.FraccionPediatricasFlag,
		ST.PaqueteGlobularFlag,
		ST.PaqueteGlobularCantidad,
		ST.RequerimientoCantidad,
		ST.RequerimientoEspecialFlag,
		ST.PlasmaFrescoCongeladoFlag,
		ST.PlasmaFrescoCongeladoCantidad,
		ST.DesleucocitadoCantidad,
		ST.DesleucocitadoFlag,
		ST.CrioprecipitadoFlag, 
		ST.CrioprecipitadoCantidad,
		ST.IrradiadoCantidad,
		ST.IrradiadoFlag,
		ST.PlaquetasFlag,
		ST.PlaquetasCantidad,
		ST.OtrosCantidad,
		ST.OtrosEspecificar,
		ST.OtrosFlag,
		ST.Requisito,
		0 AS PersonaBanco,
		CONVERT(char(10), ST.FechaRecepcion, 103) AS FechaRecepcion,
		RIGHT(CONVERT(DATETIME, ST.HoraRecepcion, 108), 8) AS HoraRecepcion,
		PERSONA_PERSSALUD.NombreCompleto AS PersMedicoNombreCompleto,
		PERSONA_PERSSALUD.NombreCompleto +
			(CASE WHEN EMPLEADO_PERSSALUD.CMP IS NULL THEN '' ELSE '/CMP: ' + EMPLEADO_PERSSALUD.CMP END) +
			'/' + SS_GE_Especialidad.Nombre +
			(CASE WHEN ESPECIALIDAD_MED.NumeroRegistroEspecialidad IS NULL THEN '' ELSE '- RNE: ' + ESPECIALIDAD_MED.NumeroRegistroEspecialidad END) AS Expr104
	FROM SS_HC_SolucitudTransfusional_FE ST WITH (NOLOCK)
	INNER JOIN (
		SELECT
			A.EpisodioClinico,
			A.UnidadReplicacion,
			A.IdEpisodioAtencion,
			A.IdPaciente,
			STUFF((
				SELECT ', ' + C.Descripcion
				FROM SS_HC_SolucitudTransfusionalDiagnostico_FE A2 WITH (NOLOCK)
				INNER JOIN SS_GE_Diagnostico C WITH (NOLOCK) ON C.IdDiagnostico = A2.IdDiagnostico
				WHERE A2.EpisodioClinico = A.EpisodioClinico
					AND A2.UnidadReplicacion = A.UnidadReplicacion
					AND A2.IdEpisodioAtencion = A.IdEpisodioAtencion
					AND A2.IdPaciente = A.IdPaciente
				FOR XML PATH(''), TYPE).value('.', 'varchar(MAX)'), 1, 1, '') AS Diagnostico
		FROM SS_HC_SolucitudTransfusionalDiagnostico_FE A WITH (NOLOCK)
		GROUP BY A.EpisodioClinico, A.UnidadReplicacion, A.IdEpisodioAtencion, A.IdPaciente
	) t_DIAGNOSTICO
		ON ST.IdEpisodioAtencion = t_DIAGNOSTICO.IdEpisodioAtencion
		AND ST.UnidadReplicacion = t_DIAGNOSTICO.UnidadReplicacion
		AND ST.IdPaciente = t_DIAGNOSTICO.IdPaciente
		AND ST.EpisodioClinico = t_DIAGNOSTICO.EpisodioClinico
	LEFT JOIN PERSONAMAST PM_PACIENTE WITH (NOLOCK)
		ON ST.IdPaciente = PM_PACIENTE.Persona
	INNER JOIN SS_GE_Paciente GP WITH (NOLOCK)
		ON GP.IdPaciente = ST.IdPaciente
	INNER JOIN SS_HC_EpisodioAtencion WITH (NOLOCK)
		ON ST.UnidadReplicacion = SS_HC_EpisodioAtencion.UnidadReplicacion
		AND ST.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion
		AND ST.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente
		AND ST.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico
	LEFT JOIN PERSONAMAST AS PERSONA_PERSSALUD WITH (NOLOCK)
		ON PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
	LEFT JOIN SS_GE_Especialidad WITH (NOLOCK)
		ON SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad
	LEFT JOIN EMPLEADOMAST AS EMPLEADO_PERSSALUD WITH (NOLOCK)
		ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud
	LEFT JOIN SS_GE_EspecialidadMedico AS ESPECIALIDAD_MED WITH (NOLOCK)
		ON ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud
		AND ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad
	LEFT JOIN SS_HC_UnidadServicio WITH (NOLOCK)
		ON SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio;
GO
/****** Object:  View [dbo].[rptViewTriajeAlergias_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewTriajeAlergias_FE]
AS
		SELECT   B.Secuencia, 		G.Descripcion AS IdTipoAlergia, 
		 (case when B.Accion  ='RE' 
		then 
			(case when WH_ItemMast.Item IS NOT NULL 
			then 
				ltrim(rtrim(WH_ItemMast.DescripcionLocal)) 
			else
				ltrim(rtrim(WH_ClaseSubFamilia.DescripcionLocal)) 
			end
			)
		else 
			B.DescripcionManual
		end
	  ) as Nombre,
		B.DesdeCuando, B.EstudioAlegista, ISNULL(B.Observaciones,'') AS Observaciones,B.DescripcionManual, B.Dosis,ge.Descripcion  as via ,
		MDS.Nombre AS Frecuencia,
        A.UnidadReplicacion, A.IdPaciente, A.EpisodioTriaje, G.Descripcion AS TipoAlergiaDesc, 
        (CASE A.TieneHistoria WHEN 'S' THEN 'X' ELSE '' END) AS SI, (CASE A.TieneHistoria WHEN 'N' THEN 'X' ELSE '' END) AS NO, MD.Nombre AS EstudioAlergista, 
        B.TipoRegistro AS Accion
FROM            SS_HC_Triaje_Ant_Alergia_FE AS A  WITH(NOLOCK) 
	LEFT JOIN  SS_HC_Triaje_Ant_AlergiaDetalle_FE AS B  WITH(NOLOCK) ON A.UnidadReplicacion = B.UnidadReplicacion 	
				AND  A.IdPaciente = B.IdPaciente AND A.EpisodioTriaje = B.EpisodioTriaje 				 
	LEFT JOIN   WH_ItemMast 		 WITH(NOLOCK) ON 	WH_ItemMast.Item =  B.CodigoComponente
	LEFT JOIN   WH_ClaseSubFamilia	 WITH(NOLOCK) ON 	WH_ClaseSubFamilia.Linea =  B.Linea and WH_ClaseSubFamilia.Familia =  B.Familia 
				AND WH_ClaseSubFamilia.SubFamilia =  B.SubFamilia  					
	LEFT JOIN   GE_Varios AS G  WITH(NOLOCK) ON G.CodigoTabla = 'TIPALERGIA' AND B.IdTipoAlergia = G.Secuencial 
	LEFT JOIN   GE_Varios AS Ge  WITH(NOLOCK) ON Ge.CodigoTabla = 'TIPOVIA' AND B.via = Ge.Secuencial 
	LEFT JOIN   CM_CO_TablaMaestroDetalle AS MD  WITH(NOLOCK) ON MD.IdTablaMaestro = 35 AND B.EstudioAlegista = MD.IdCodigo
	LEFT JOIN   CM_CO_TablaMaestroDetalle AS MDS  WITH(NOLOCK) ON MDS.IdTablaMaestro = 102 AND B.Frecuencia = MDS.IdCodigo
	
GO
/****** Object:  View [dbo].[rptViewTriajeEmergencia_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewTriajeEmergencia_FE]
AS
			SELECT FV.*,
			 /**********ADD GENERALES****************/                      
            --(PERSONAS)
            dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.Nombres, dbo.PERSONAMAST.NombreCompleto, 
            dbo.PERSONAMAST.Busqueda, dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.FechaNacimiento, 
            dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.edad as PersonaEdad
            --EPI TRIAJE
            ,SS_HC_EpisodioTriaje.IdEpisodioTriaje
            ,SS_HC_EpisodioTriaje.CodigoOT
            ,SS_HC_EpisodioTriaje.IdPersonalSalud
            ,SS_HC_EpisodioTriaje.FechaAtencion                   
            ,SS_HC_EpisodioTriaje.IdEspecialidad
            ,SS_HC_EpisodioTriaje.IdPrioridad
            ,SS_HC_EpisodioTriaje.FlagFirma
			-- ,SS_HC_EpisodioTriaje.IdTipoO
            ,SS_HC_EpisodioTriaje.FechaFirma
            ,SS_HC_EpisodioTriaje.IdMedicoFirma
			,SS_HC_EpisodioTriaje.ObservacionFirma
			,SS_GE_TipoAtencion.Descripcion as TipoAtencionDesc
            ,EMPLEADO_PERSSALUD.CMP as TipoTrabajadorDesc  --CMP
            ,CM_CO_Establecimiento.Codigo as EstablecimientoCodigo
            ,CM_CO_Establecimiento.Nombre as EstablecimientoDesc
            ,SS_HC_UnidadServicio.Codigo as UnidadServicioCodigo
            ,SS_GE_Paciente.CodigoHC as UnidadServicioDesc --CODIGOHC
            ,PERSONA_PERSSALUD.NombreCompleto as PersMedicoNombreCompleto
            ,PERSONA_PERSSALUD.Documento as PersMedicoNombreDocumento
            ,SS_GE_Especialidad.Codigo as EspecialidadCodigo
            ,SS_GE_Especialidad.Nombre as EspecialidadDesc,
			 EMPLEADO_PERSSALUD.CMP as estadoEpiAtencion --CMP	 
		FROM SS_HC_TriajeEmergencia_FE FV WITH(NOLOCK) 
		INNER JOIN  SS_HC_EpisodioTriaje  WITH(NOLOCK) ON 
                    SS_HC_EpisodioTriaje.UnidadReplicacion = FV.UnidadReplicacion   AND                   
                    FV.IdPaciente = SS_HC_EpisodioTriaje.IdPaciente AND
                    FV.EpisodioTriaje = SS_HC_EpisodioTriaje.IdEpisodioTriaje
		INNER JOIN  PERSONAMAST  WITH(NOLOCK) ON FV.IdPaciente = PERSONAMAST.Persona                    
		LEFT JOIN SS_GE_TipoAtencion  WITH(NOLOCK) ON 
                    SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioTriaje.IdPaciente
		LEFT JOIN  SS_TipoTrabajador  WITH(NOLOCK) ON 
                    SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioTriaje.IdEspecialidad
		LEFT JOIN  CM_CO_Establecimiento  WITH(NOLOCK) ON
                    CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioTriaje.IdPersonalSalud
		LEFT JOIN  SS_HC_UnidadServicio  WITH(NOLOCK) ON 
                    SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioTriaje.IdPrioridad
                /****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/   
		LEFT JOIN  PERSONAMAST as PERSONA_PERSSALUD      WITH(NOLOCK) ON PERSONA_PERSSALUD.Persona = SS_HC_EpisodioTriaje.IdPersonalSalud
		LEFT JOIN  SS_GE_Paciente	 WITH(NOLOCK) 	on FV.IdPaciente =  SS_GE_Paciente.IdPaciente 							
		LEFT JOIN  SS_GE_Especialidad        WITH(NOLOCK)    ON SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioTriaje.IdEspecialidad     
								--ADD CMP  y RNE
		LEFT JOIN   EMPLEADOMAST  as EMPLEADO_PERSSALUD		 WITH(NOLOCK) ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioTriaje.IdPersonalSalud
		LEFT JOIN   SS_GE_EspecialidadMedico  as ESPECIALIDAD_MED  WITH(NOLOCK)   ON ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioTriaje.IdPersonalSalud
																		And ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioTriaje.IdEspecialidad   
	


GO
/****** Object:  View [dbo].[rptViewValoracionAM_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE OR ALTER VIEW [dbo].[rptViewValoracionAM_FE]
as
		select
		UnidadReplicacion,
		IdEpisodioAtencion,
		IdPaciente,
		EpisodioClinico,
		case Categoria when 'E' 
		THEN 'X' 
		else ''
		end AS E,
		case Categoria when 'S' 
		THEN 'X' 
		else ''
		end
		as S,
		case Categoria when 'F' 
		THEN 'X' 
		else ''
		end
		as F,
		case Categoria when 'G' 
		THEN 'X' 
		else ''
		end
		as G,
		UsuarioCreacion,
		UsuarioModificacion,
		FechaModificacion
		Accion,
		Version
		from SS_HC_ValoracionAM_FE

GO
/****** Object:  View [dbo].[rptViewValoracionMentalAM_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE OR ALTER VIEW [dbo].[rptViewValoracionMentalAM_FE]
as
	select A.*,
	(select nombre from CM_CO_TablaMaestroDetalle  AS  MD where MD.IdTablaMaestro =35 and a.Satisfecho = md.IdCodigo) AS SatisfechoDes,
	(select nombre from CM_CO_TablaMaestroDetalle  AS  MD where MD.IdTablaMaestro =35 and a.impotente = md.IdCodigo) AS ImpotenteDes,
	(select nombre from CM_CO_TablaMaestroDetalle  AS  MD where MD.IdTablaMaestro =35 and a.Memoria = md.IdCodigo) AS MemoriaDes,
	(select nombre from CM_CO_TablaMaestroDetalle  AS  MD where MD.IdTablaMaestro =35 and a.desgano = md.IdCodigo) AS DesganoDes
	 from SS_HC_ValoracionMentalAM_FE AS A

GO
/****** Object:  View [dbo].[rptViewValoracionSocioFamAM_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewValoracionSocioFamAM_FE]
as
	SELECT 
	B.*,

	IIF(SituacionSocial = '1', 'X', '') AS SS1,
	IIF(SituacionSocial = '2', 'X', '') AS SS2,
	IIF(SituacionSocial = '3', 'X', '') AS SS3,
	IIF(SituacionSocial = '4', 'X', '') AS SS4,
	IIF(SituacionSocial = '5', 'X', '') AS SS5,

	IIF(SituacionEconomica = '1', 'X', '') AS SE1,
	IIF(SituacionEconomica = '2', 'X', '') AS SE2,
	IIF(SituacionEconomica = '3', 'X', '') AS SE3,
	IIF(SituacionEconomica = '4', 'X', '') AS SE4,
	IIF(SituacionEconomica = '5', 'X', '') AS SE5,

	IIF(Vivienda = '1', 'X', '') AS V1,
	IIF(Vivienda = '2', 'X', '') AS V2,
	IIF(Vivienda = '3', 'X', '') AS V3,
	IIF(Vivienda = '4', 'X', '') AS V4,
	IIF(Vivienda = '5', 'X', '') AS V5,

	IIF(RelacionesSociales = '1', 'X', '') AS RS1,
	IIF(RelacionesSociales = '2', 'X', '') AS RS2,
	IIF(RelacionesSociales = '3', 'X', '') AS RS3,
	IIF(RelacionesSociales = '4', 'X', '') AS RS4,
	IIF(RelacionesSociales = '5', 'X', '') AS RS5,

	IIF(ApoyoRedSocial = '1', 'X', '') AS ARS1,
	IIF(ApoyoRedSocial = '2', 'X', '') AS ARS2,
	IIF(ApoyoRedSocial = '3', 'X', '') AS ARS3,
	IIF(ApoyoRedSocial = '4', 'X', '') AS ARS4,
	IIF(ApoyoRedSocial = '5', 'X', '') AS ARS5
	FROM SS_HC_ValoracionSocioFamAM_FE AS B;

GO
/****** Object:  View [dbo].[rptViewVigilanciaCateterPeriferico_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[rptViewVigilanciaCateterPeriferico_FE]
AS
SELECT VCP.Accion,VCP.ApositoGasa_flag,VCP.CambiosLinea_flag,VCP.Curacion_flag,VCP.EpisodioClinico,VCP.Estado,VCP.Extravasacion_flag,VCP.Exudado_Especificar,VCP.Exudado_flag,
			cast(VCP.Fecha as Date) AS Fecha,VCP.FechaCreacion,VCP.FechaModificacion,convert(char(5), VCP.Hora, 108) as Hora,VCP.IdCateterPeriferico,VCP.IdEpisodioAtencion,VCP.IdPaciente,
			VCP.Recanalizacion_flag,VCP.RetiroAccidental_flag,VCP.SignosInflamatorios_flag,VCP.TegademEstado_flag,VCP.UnidadReplicacion,VCP.UsuarioCreacion,VCP.UsuarioModificacion,VCP.Version,
 /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.Nombres, dbo.PERSONAMAST.NombreCompleto, 
                      dbo.PERSONAMAST.Busqueda, dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.FechaNacimiento, 
                      dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.edad as PersonaEdad
                      --EPI ATENCIÓN
                      ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoOrdenAtencion  AS TipoOrdenAtencionPac
                      ,SS_HC_EpisodioAtencion.TipoAtencion
                      ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                      ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio
                      ,SS_HC_EpisodioAtencion.IdPersonalSalud
                      ,SS_HC_EpisodioAtencion.FechaRegistro AS FechaRegistroPac
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      ,SS_HC_EpisodioAtencion.IdEspecialidad AS IdEspecialidadPac
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
                           
FROM dbo.SS_HC_ENFER_VIGI_CateterPeriferico_FE VCP
INNER JOIN  SS_HC_EpisodioAtencion ON 
                    SS_HC_EpisodioAtencion.UnidadReplicacion = VCP.UnidadReplicacion   AND
                    VCP.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND
                    VCP.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND
                    VCP.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico
INNER JOIN  PERSONAMAST ON VCP.IdPaciente = PERSONAMAST.Persona                    
LEFT JOIN SS_GE_TipoAtencion ON 
                    SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
LEFT JOIN
                    SS_TipoTrabajador ON 
                    SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador
LEFT JOIN  CM_CO_Establecimiento ON
                    CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud

LEFT JOIN  SS_HC_UnidadServicio ON 
                    SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
                               /****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/           AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
                    LEFT JOIN  PERSONAMAST AS PERSONA_PERSSALUD ON 
                    PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
                    
                    LEFT JOIN  SS_GE_Especialidad ON 
                    SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad 
                    
                    --LEFT JOIN
                    --SS_GE_ProcedimientoMedico ON 
                    --(SS_GE_ProcedimientoMedico.IdProcedimiento = SC.IdProcedimiento AND SC.TipoCodigo = 'C')
                    
                    LEFT JOIN
                    EMPLEADOMAST AS EMPLEADO_PERSSALUD ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud 
                    
                    LEFT JOIN
                    SS_GE_EspecialidadMedico AS ESPECIALIDAD_MED ON 
                    (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud AND
                    ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad)



GO
/****** Object:  View [dbo].[rptViewVigilanciaCateterUrinario_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewVigilanciaCateterUrinario_FE]
AS
SELECT VCU.Accion,VCU.BolsaEncima,VCU.BolsaEncima_Obs,VCU.BolsaFija,VCU.BolsaFija_Obs,VCU.EpisodioClinico,VCU.Estado,cast(VCU.Fecha as Date) AS Fecha,VCU.FechaCreacion,VCU.FechaModificacion,
			convert(char(5), VCU.Hora, 108) as Hora,VCU.IdCateterUrinario,VCU.IdEpisodioAtencion,VCU.IdPaciente,VCU.LavadoGenital,VCU.LavadoGenital_Obs,VCU.LavadoManos,VCU.LavadoManos_Obs,
			VCU.SistemaCerrado,VCU.SistemaCerrado_Obs,VCU.UnidadReplicacion,VCU.UsoGuantes,VCU.UsoGuantes_Obs,VCU.UsuarioCreacion,VCU.UsuarioModificacion,VCU.Version,
 /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.Nombres, dbo.PERSONAMAST.NombreCompleto, 
                      dbo.PERSONAMAST.Busqueda, dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.FechaNacimiento, 
                      dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.edad as PersonaEdad
                      --EPI ATENCIÓN
                      ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoOrdenAtencion  AS TipoOrdenAtencionPac
                      ,SS_HC_EpisodioAtencion.TipoAtencion
                      ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                      ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio
                      ,SS_HC_EpisodioAtencion.IdPersonalSalud
                      ,SS_HC_EpisodioAtencion.FechaRegistro AS FechaRegistroPac
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      ,SS_HC_EpisodioAtencion.IdEspecialidad AS IdEspecialidadPac
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
                           
FROM dbo.SS_HC_ENFER_VIGI_CATETERURINARIO_FE VCU
INNER JOIN  SS_HC_EpisodioAtencion ON 
                    SS_HC_EpisodioAtencion.UnidadReplicacion = VCU.UnidadReplicacion   AND
                    VCU.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND
                    VCU.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND
                    VCU.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico
INNER JOIN  PERSONAMAST ON VCU.IdPaciente = PERSONAMAST.Persona                    
LEFT JOIN SS_GE_TipoAtencion ON 
                    SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
LEFT JOIN
                    SS_TipoTrabajador ON 
                    SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador
LEFT JOIN  CM_CO_Establecimiento ON
                    CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud

LEFT JOIN  SS_HC_UnidadServicio ON 
                    SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
                               /****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/           AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
                    LEFT JOIN  PERSONAMAST AS PERSONA_PERSSALUD ON 
                    PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
                    
                    LEFT JOIN  SS_GE_Especialidad ON 
                    SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad 
                    
                    --LEFT JOIN
                    --SS_GE_ProcedimientoMedico ON 
                    --(SS_GE_ProcedimientoMedico.IdProcedimiento = SC.IdProcedimiento AND SC.TipoCodigo = 'C')
                    
                    LEFT JOIN
                    EMPLEADOMAST AS EMPLEADO_PERSSALUD ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud 
                    
                    LEFT JOIN
                    SS_GE_EspecialidadMedico AS ESPECIALIDAD_MED ON 
                    (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud AND
                    ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad)







GO
/****** Object:  View [dbo].[rptViewVigilanciaDispositivos_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER VIEW [dbo].[rptViewVigilanciaDispositivos_FE]
AS
SELECT VD.*,
 /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.Nombres, dbo.PERSONAMAST.NombreCompleto, 
                      dbo.PERSONAMAST.Busqueda, dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.FechaNacimiento, 
                      dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.edad as PersonaEdad
                      --EPI ATENCIÓN
                      ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoOrdenAtencion  AS TipoOrdenAtencionPac
                      ,SS_HC_EpisodioAtencion.TipoAtencion
                      ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                      ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio
                      ,SS_HC_EpisodioAtencion.IdPersonalSalud
                      ,SS_HC_EpisodioAtencion.FechaRegistro AS FechaRegistroPac
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      ,SS_HC_EpisodioAtencion.IdEspecialidad AS IdEspecialidadPac
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
                           
FROM  SS_HC_VIGILANCIA_DISPOSITIVOS_FE VD
INNER JOIN  SS_HC_EpisodioAtencion ON 
                    SS_HC_EpisodioAtencion.UnidadReplicacion = VD.UnidadReplicacion   AND
                    VD.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND
                    VD.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND
                    VD.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico
INNER JOIN  PERSONAMAST ON VD.IdPaciente = PERSONAMAST.Persona                    
LEFT JOIN SS_GE_TipoAtencion ON 
                    SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
LEFT JOIN
                    SS_TipoTrabajador ON 
                    SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador
LEFT JOIN  CM_CO_Establecimiento ON
                    CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud
LEFT JOIN  SS_HC_UnidadServicio ON 
                    SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
                               /****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/           AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
                    LEFT JOIN  PERSONAMAST AS PERSONA_PERSSALUD ON 
                    PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
                    LEFT JOIN  SS_GE_Especialidad ON 
                    SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad 
                    LEFT JOIN
                    EMPLEADOMAST AS EMPLEADO_PERSSALUD ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud 
                    
                    LEFT JOIN
                    SS_GE_EspecialidadMedico AS ESPECIALIDAD_MED ON 
                    (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud AND
                    ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad)


GO
/****** Object:  View [dbo].[rptViewVigilanciaVentilacionMecanica_FE]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[rptViewVigilanciaVentilacionMecanica_FE]
AS
SELECT VVM.Accion,VVM.AspiradoAspiradoSimple,VVM.AspiradoAspiradoSimple_Obs,VVM.AspiradoCircuitoCerrado,VVM.AspiradoCircuitoCerrado_Obs,VVM.EpisodioClinico,VVM.Estado,cast(VVM.Fecha as Date) AS Fecha,
			VVM.FechaCreacion,VVM.FechaModificacion,VVM.HigieneOral,VVM.HigieneOral_Obs,convert(char(5), VVM.Hora, 108) as Hora,VVM.IdEpisodioAtencion,VVM.IdPaciente,VVM.IdVentilacionMecanica,
			VVM.LavadoManos,VVM.LavadoManos_Obs,VVM.NivelSecreciones,VVM.NivelSecreciones_Obs,VVM.PosicionSemiFowler,VVM.PosicionSemiFowler_Obs,VVM.SecresionesTubuladuras,VVM.SecresionesTubuladuras_Obs,
			VVM.UnidadReplicacion,VVM.UsoEPP,VVM.UsoEPP_Obs,VVM.UsoSonda,VVM.UsoSonda_Obs,VVM.UsuarioCreacion,VVM.UsuarioModificacion,VVM.Version,
 /**********ADD GENERALES****************/                      
                      --(PERSONAS)
                      dbo.PERSONAMAST.ApellidoPaterno, dbo.PERSONAMAST.ApellidoMaterno, dbo.PERSONAMAST.Nombres, dbo.PERSONAMAST.NombreCompleto, 
                      dbo.PERSONAMAST.Busqueda, dbo.PERSONAMAST.TipoDocumento, dbo.PERSONAMAST.Documento, dbo.PERSONAMAST.FechaNacimiento, 
                      dbo.PERSONAMAST.Sexo, dbo.PERSONAMAST.EstadoCivil, dbo.PERSONAMAST.edad as PersonaEdad
                      --EPI ATENCIÓN
                      ,SS_HC_EpisodioAtencion.IdOrdenAtencion
                      ,SS_HC_EpisodioAtencion.CodigoOA
                      ,SS_HC_EpisodioAtencion.LineaOrdenAtencion
                      ,SS_HC_EpisodioAtencion.TipoOrdenAtencion  AS TipoOrdenAtencionPac
                      ,SS_HC_EpisodioAtencion.TipoAtencion
                      ,SS_HC_EpisodioAtencion.TipoTrabajador                      
                      ,SS_HC_EpisodioAtencion.IdEstablecimientoSalud
                      ,SS_HC_EpisodioAtencion.IdUnidadServicio
                      ,SS_HC_EpisodioAtencion.IdPersonalSalud
                      ,SS_HC_EpisodioAtencion.FechaRegistro AS FechaRegistroPac
                      ,SS_HC_EpisodioAtencion.FechaAtencion
                      ,SS_HC_EpisodioAtencion.IdEspecialidad AS IdEspecialidadPac
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
                           
FROM dbo.SS_HC_ENFER_VIGI_VentilacionMecanica_FE VVM
INNER JOIN  SS_HC_EpisodioAtencion ON 
                    SS_HC_EpisodioAtencion.UnidadReplicacion = VVM.UnidadReplicacion   AND
                    VVM.IdEpisodioAtencion = SS_HC_EpisodioAtencion.IdEpisodioAtencion AND
                    VVM.IdPaciente = SS_HC_EpisodioAtencion.IdPaciente AND
                    VVM.EpisodioClinico = SS_HC_EpisodioAtencion.EpisodioClinico
INNER JOIN  PERSONAMAST ON VVM.IdPaciente = PERSONAMAST.Persona                    
LEFT JOIN SS_GE_TipoAtencion ON 
                    SS_GE_TipoAtencion.IdTipoAtencion = SS_HC_EpisodioAtencion.TipoAtencion
LEFT JOIN
                    SS_TipoTrabajador ON 
                    SS_TipoTrabajador.TipoTrabajador = SS_HC_EpisodioAtencion.TipoTrabajador
LEFT JOIN  CM_CO_Establecimiento ON
                    CM_CO_Establecimiento.IdEstablecimiento = SS_HC_EpisodioAtencion.IdEstablecimientoSalud

LEFT JOIN  SS_HC_UnidadServicio ON 
                    SS_HC_UnidadServicio.IdUnidadServicio = SS_HC_EpisodioAtencion.IdUnidadServicio
                               /****** Object:  Jordan Mateo   Script Date: 31/01/2017 08:10:07 p.m. ******/           AND CM_CO_Establecimiento.IdEstablecimiento=SS_HC_UnidadServicio.IdEstablecimientoSalud
                    LEFT JOIN  PERSONAMAST AS PERSONA_PERSSALUD ON 
                    PERSONA_PERSSALUD.Persona = SS_HC_EpisodioAtencion.IdPersonalSalud
                    
                    LEFT JOIN  SS_GE_Especialidad ON 
                    SS_GE_Especialidad.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad 
                    
                    --LEFT JOIN
                    --SS_GE_ProcedimientoMedico ON 
                    --(SS_GE_ProcedimientoMedico.IdProcedimiento = SC.IdProcedimiento AND SC.TipoCodigo = 'C')
                    
                    LEFT JOIN
                    EMPLEADOMAST AS EMPLEADO_PERSSALUD ON EMPLEADO_PERSSALUD.Empleado = SS_HC_EpisodioAtencion.IdPersonalSalud 
                    
                    LEFT JOIN
                    SS_GE_EspecialidadMedico AS ESPECIALIDAD_MED ON 
                    (ESPECIALIDAD_MED.IdMedico = SS_HC_EpisodioAtencion.IdPersonalSalud AND
                    ESPECIALIDAD_MED.IdEspecialidad = SS_HC_EpisodioAtencion.IdEspecialidad)


GO
/****** Object:  View [dbo].[SS_CHE_VistaSeguridad]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[SS_CHE_VistaSeguridad]
AS
SELECT     dbo.SG_Sistema.Sistema, dbo.SG_Sistema.Nombre, dbo.SG_Modulo.Modulo, dbo.SG_Modulo.Orden, dbo.SG_Modulo.Nombre AS NombreModulo, 
                      dbo.SG_Opcion.IdOpcion, dbo.SG_Opcion.IdOpcionPadre, dbo.SG_Opcion.CodigoOpcion, dbo.SG_Opcion.CadenaRecursividad, dbo.SG_Opcion.NivelOpcion, 
                      dbo.SG_Opcion.Nombre AS NombreOpcion, dbo.SG_Opcion.Descripcion, dbo.SG_Opcion.SubModulo, dbo.SG_Opcion.Orden AS OrdenOpcion, 
                      dbo.SG_Opcion.TipoOpcion, dbo.SG_Opcion.TipoIcono, dbo.SG_Opcion.IndicadorPrioridad, dbo.SG_Opcion.IndicadorObjeto, dbo.SS_HC_Formato.IndCompartido as IdObjetoAsociado, 
                      dbo.SG_Opcion.TipoDato, dbo.SG_Opcion.ValorTexto, dbo.SG_Opcion.ValorNumerico, dbo.SG_Opcion.ValorFecha, dbo.SG_Opcion.UrlOpcion, 
                      dbo.SG_Opcion.UsuarioCreacion, dbo.SG_Opcion.FechaCreacion, dbo.SG_AgenteOpcion.UsuarioModificacion, dbo.SG_AgenteOpcion.FechaModificacion, dbo.SG_Opcion.Compania, 
                      dbo.SG_Opcion.IndicadorCompania, dbo.SG_Opcion.idTipoAtencion, dbo.SG_Opcion.TipoTrabajador, dbo.SG_Opcion.IndicadorFormato, 
                      dbo.SG_Opcion.IndicadorAsignacion, dbo.SG_Opcion.TipoProceso, dbo.SG_Opcion.Accion, dbo.SG_Opcion.Version, dbo.SG_Opcion.Estado, dbo.SG_Agente.IdAgente, 
                      dbo.SG_Agente.IdGrupo, dbo.SG_Agente.IdOrganizacion, dbo.SG_Agente.TipoAgente, dbo.SG_Agente.CodigoAgente, dbo.SG_Agente.IdEmpleado, 
                      dbo.SG_Agente.IndicadorMultiple, dbo.SG_Agente.Clave, dbo.SG_Agente.FechaInicio, dbo.SG_Agente.FechaFin, dbo.SG_Agente.FechaExpiracion, 
                      dbo.SG_Agente.Nombre AS NombreAgente, dbo.SG_Agente.ExpiraClave, dbo.SG_Agente.Descripcion AS DescripcionAgente, dbo.SG_Agente.Estado AS EstadoAgente, 
                      dbo.SG_Agente.IdGrupoTransaccion, dbo.SG_Agente.TipoTransaccion, dbo.SG_Agente.IdOpcionDefecto, dbo.SG_Agente.Plataforma, 
                      dbo.SG_AgenteOpcion.ValorFecha AS ValorFechaAgOpcion, dbo.SG_AgenteOpcion.ValorNumerico AS ValorNumericoAgOpcion, 
                      dbo.SG_AgenteOpcion.ValorTexto AS ValorTextAgOpcion, dbo.SG_AgenteOpcion.IndicadorAcceso, dbo.SG_AgenteOpcion.IndicadorHabilitado, 
                      dbo.SG_AgenteOpcion.IndicadorObligatorio, dbo.SG_AgenteOpcion.IndicadorVisible, dbo.SG_AgenteOpcion.IndicadorPrioridad AS IndicarPrioridadAgOpcion, 
                      dbo.SG_AgenteOpcion.IndicadorNuevo, dbo.SG_AgenteOpcion.IndicadorModificar, dbo.SG_AgenteOpcion.IndicadorEliminar,dbo.SG_AgenteOpcion.IndicadorImprimir, dbo.SG_AgenteOpcion.IndicadorIngreso, 
                      dbo.SG_AgenteOpcion.Estado AS EstadoAgenteOpcion, dbo.SS_HC_Formato.IdFormato, dbo.SS_HC_Formato.IdFormatoPadre, dbo.SS_HC_Formato.CodigoFormato, 
                      dbo.SS_HC_Formato.CodigoFormatoPadre, dbo.SS_HC_Formato.CadenaRecursividad AS CadenaRecursividadFormato, dbo.SS_HC_Formato.Nivel, 
                      dbo.SS_HC_Formato.Descripcion AS DescripcionFormato, dbo.SS_HC_Formato.DescripcionExtranjera, dbo.SS_HC_Formato.TipoFormato, 
                      dbo.SS_HC_Formato.VersionFormatoFijo, dbo.SS_HC_Formato.IdFormatoDinamico, dbo.SS_HC_Formato.Estado AS EstadoFormato
FROM         dbo.SG_Agente INNER JOIN
                      dbo.SG_AgenteOpcion ON dbo.SG_Agente.IdAgente = dbo.SG_AgenteOpcion.IdAgente INNER JOIN
                      dbo.SG_Opcion ON dbo.SG_AgenteOpcion.IdOpcion = dbo.SG_Opcion.IdOpcion INNER JOIN
                      dbo.SG_Modulo ON dbo.SG_Opcion.Sistema = dbo.SG_Modulo.Sistema AND dbo.SG_Opcion.Modulo = dbo.SG_Modulo.Modulo INNER JOIN
                      dbo.SG_Sistema ON dbo.SG_Modulo.Sistema = dbo.SG_Sistema.Sistema LEFT OUTER JOIN
                      dbo.SS_HC_Formato ON dbo.SG_Opcion.IdFormato = dbo.SS_HC_Formato.IdFormato



GO
/****** Object:  View [dbo].[SS_PRUEBA]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[SS_PRUEBA]
AS
SELECT     dbo.SG_Sistema.Sistema, dbo.SG_Sistema.Nombre, dbo.SG_Modulo.Modulo, dbo.SG_Modulo.Orden, dbo.SG_Modulo.Nombre AS NombreModulo, 
                      dbo.SG_Opcion.IdOpcion, dbo.SG_Opcion.IdOpcionPadre, dbo.SG_Opcion.CodigoOpcion, dbo.SG_Opcion.CadenaRecursividad, dbo.SG_Opcion.NivelOpcion, 
                      dbo.SG_Opcion.Nombre AS NombreOpcion, dbo.SG_Opcion.Descripcion, dbo.SG_Opcion.SubModulo, dbo.SG_Opcion.Orden AS OrdenOpcion, 
                      dbo.SG_Opcion.TipoOpcion, dbo.SG_Opcion.TipoIcono, dbo.SG_Opcion.IndicadorPrioridad, dbo.SG_Opcion.IndicadorObjeto, dbo.SG_Opcion.IdObjetoAsociado, 
                      dbo.SG_Opcion.TipoDato, dbo.SG_Opcion.ValorTexto, dbo.SG_Opcion.ValorNumerico, dbo.SG_Opcion.ValorFecha, dbo.SG_Opcion.UrlOpcion, 
                      dbo.SG_Opcion.UsuarioCreacion, dbo.SG_Opcion.FechaCreacion, dbo.SG_AgenteOpcion.UsuarioModificacion, dbo.SG_AgenteOpcion.FechaModificacion, dbo.SG_Opcion.Compania, 
                      dbo.SG_Opcion.IndicadorCompania, dbo.SG_Opcion.idTipoAtencion, dbo.SG_Opcion.TipoTrabajador, dbo.SG_Opcion.IndicadorFormato, 
                      dbo.SG_Opcion.IndicadorAsignacion, dbo.SG_Opcion.TipoProceso, dbo.SG_Opcion.Accion, dbo.SG_Opcion.Version, dbo.SG_Opcion.Estado, dbo.SG_Agente.IdAgente, 
                      dbo.SG_Agente.IdGrupo, dbo.SG_Agente.IdOrganizacion, dbo.SG_Agente.TipoAgente, dbo.SG_Agente.CodigoAgente, dbo.SG_Agente.IdEmpleado, 
                      dbo.SG_Agente.IndicadorMultiple, dbo.SG_Agente.Clave, dbo.SG_Agente.FechaInicio, dbo.SG_Agente.FechaFin, dbo.SG_Agente.FechaExpiracion, 
                      dbo.SG_Agente.Nombre AS NombreAgente, dbo.SG_Agente.ExpiraClave, dbo.SG_Agente.Descripcion AS DescripcionAgente, dbo.SG_Agente.Estado AS EstadoAgente, 
                      dbo.SG_Agente.IdGrupoTransaccion, dbo.SG_Agente.TipoTransaccion, dbo.SG_Agente.IdOpcionDefecto, dbo.SG_Agente.Plataforma, 
                      dbo.SG_AgenteOpcion.ValorFecha AS ValorFechaAgOpcion, dbo.SG_AgenteOpcion.ValorNumerico AS ValorNumericoAgOpcion, 
                      dbo.SG_AgenteOpcion.ValorTexto AS ValorTextAgOpcion, dbo.SG_AgenteOpcion.IndicadorAcceso, dbo.SG_AgenteOpcion.IndicadorHabilitado, 
                      dbo.SG_AgenteOpcion.IndicadorObligatorio, dbo.SG_AgenteOpcion.IndicadorVisible, dbo.SG_AgenteOpcion.IndicadorPrioridad AS IndicarPrioridadAgOpcion, 
                      dbo.SG_AgenteOpcion.IndicadorNuevo, dbo.SG_AgenteOpcion.IndicadorModificar, dbo.SG_AgenteOpcion.IndicadorEliminar,dbo.SG_AgenteOpcion.IndicadorImprimir, dbo.SG_AgenteOpcion.IndicadorIngreso, 
                      dbo.SG_AgenteOpcion.Estado AS EstadoAgenteOpcion, dbo.SS_HC_Formato.IdFormato, dbo.SS_HC_Formato.IdFormatoPadre, dbo.SS_HC_Formato.CodigoFormato, 
                      dbo.SS_HC_Formato.CodigoFormatoPadre, dbo.SS_HC_Formato.CadenaRecursividad AS CadenaRecursividadFormato, dbo.SS_HC_Formato.Nivel, 
                      dbo.SS_HC_Formato.Descripcion AS DescripcionFormato, dbo.SS_HC_Formato.DescripcionExtranjera, dbo.SS_HC_Formato.TipoFormato, 
                      dbo.SS_HC_Formato.VersionFormatoFijo, dbo.SS_HC_Formato.IdFormatoDinamico, dbo.SS_HC_Formato.Estado AS EstadoFormato
FROM         dbo.SG_Agente INNER JOIN
                      dbo.SG_AgenteOpcion ON dbo.SG_Agente.IdAgente = dbo.SG_AgenteOpcion.IdAgente INNER JOIN
                      dbo.SG_Opcion ON dbo.SG_AgenteOpcion.IdOpcion = dbo.SG_Opcion.IdOpcion INNER JOIN
                      dbo.SG_Modulo ON dbo.SG_Opcion.Sistema = dbo.SG_Modulo.Sistema AND dbo.SG_Opcion.Modulo = dbo.SG_Modulo.Modulo INNER JOIN
                      dbo.SG_Sistema ON dbo.SG_Modulo.Sistema = dbo.SG_Sistema.Sistema LEFT OUTER JOIN
                      dbo.SS_HC_Formato ON dbo.SG_Opcion.IdFormato = dbo.SS_HC_Formato.IdFormato



GO
/****** Object:  View [dbo].[SS_VW_VALIDA]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[SS_VW_VALIDA]
AS
SELECT 
SS_HC_ControlValidacion.IdFormato,
SS_HC_FormatoCampo.ValorPorDefecto,
SS_HC_ControlComponente.Nombre AS NombreComponente,
SS_HC_ControlComponente.Tipo AS TipoComponente,
SS_HC_ControlAtributo.Nombre AS NombreAtributo,
SS_HC_ControlValidacion.SecuenciaCampo,
SS_HC_ControlValidacion.SecuenciaValidacion,
SS_HC_ControlValidacion.Estado,
SS_HC_ControlValidacion.Accion,
SS_HC_ControlValidacion.Version

FROM SS_HC_ControlValidacion 
LEFT JOIN SS_HC_ControlComponente ON SS_HC_ControlValidacion.IdComponente = SS_HC_ControlComponente.IdComponente
LEFT JOIN SS_HC_ControlAtributo ON SS_HC_ControlValidacion.IdAtributo = SS_HC_ControlAtributo.IdAtributo
LEFT JOIN SS_HC_FormatoCampo ON SS_HC_ControlValidacion.IdFormato = SS_HC_FormatoCampo.IdFormato


GO
/****** Object:  View [dbo].[V_EpisodioAtencion]    Script Date: 16/04/2025 17:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[V_EpisodioAtencion]
AS
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
GO

