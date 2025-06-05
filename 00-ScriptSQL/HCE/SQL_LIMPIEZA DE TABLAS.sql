


--TRUNCATE TABLE V_EpisodioAtenciones

--TRUNCATE TABLE V_EpisodioAtencion

SELECT 
    s.name AS SchemaName,
    t.name AS TableName,
    p.rows AS RowCounts,
    CAST((SUM(a.total_pages) * 8.0) / 1024 AS DECIMAL(18,2)) AS TotalSpaceMB,
    CAST((SUM(a.used_pages) * 8.0) / 1024 AS DECIMAL(18,2)) AS UsedSpaceMB,
    CAST((SUM(a.data_pages) * 8.0) / 1024 AS DECIMAL(18,2)) AS DataSpaceMB
FROM 
    sys.tables t
INNER JOIN      
    sys.indexes i ON t.object_id = i.object_id
INNER JOIN 
    sys.partitions p ON i.object_id = p.object_id AND i.index_id = p.index_id
INNER JOIN 
    sys.allocation_units a ON p.partition_id = a.container_id
INNER JOIN 
    sys.schemas s ON t.schema_id = s.schema_id
WHERE 
    t.is_ms_shipped = 0 and  p.rows>0
GROUP BY 
    s.name, t.name, p.rows
ORDER BY 
     p.rows DESC;

	 select * from SS_HC_ExamenSolicitadoDet_FE
	 select * from SS_HC_ExamenSolicitadoFE
	 select * from SS_HC_ExamenSolicitado_Diagnostico_FE
	 
		delete from SS_HC_ExamenSolicitadoFE
	    delete from SS_HC_EnfermedadActualDetalle_FE
		delete from SS_HC_EnfermedadActual_FE
		delete from  SS_HC_AntecedentesPersonalesIAdul_FE
		delete from SS_HC_HojaRecienNacidoDetalle_FE
		delete from SS_HC_HojaRecienNacido_FE
		delete from  SS_AD_OrdenAtencionDetalle
		delete from  SS_AD_OrdenAtencion
		delete from SS_HC_AntePerGinecoObstetricos_FE
		delete from SS_HC_DescansoMedico_Diagnostico_FE
		delete from SS_HC_DescansoMedico_FE
		delete from SS_HC_EpisodioClinico
		delete from SS_HC_CONTRARREFERENCIA_FE
		delete from SS_HC_EpisodioAtencion
		delete from SS_HC_EpisodioAtencionMaster

		TRUNCATE TABLE SS_HC_ImpresionHC_Detalle
		TRUNCATE TABLE  SS_HC_BalanceHidroElectDetalle_FE
		TRUNCATE TABLE  SS_HC_BalanceHidroElect_FE

		TRUNCATE TABLE SS_HC_ProcedimientoInformeSPRING		
		TRUNCATE TABLE SS_HC_ExamenSolicitadoDet_FE	
		TRUNCATE TABLE SS_HC_Medicamento_FE
		TRUNCATE TABLE SS_HC_IMPRESIONHC
		TRUNCATE TABLE SS_HC_Diagnostico_FE
		TRUNCATE TABLE SS_HC_Anamnesis_AFAM_FE
		TRUNCATE TABLE SS_HC_ApoyoDiagnosticoFile_FE
		TRUNCATE TABLE SS_HC_Oftalmologico_FE
		TRUNCATE TABLE SS_HC_EnfermedadActualDetalle_FE	
		TRUNCATE TABLE SS_HC_ExamenClinico_FE
		TRUNCATE TABLE SS_HC_FuncionesVitales_FE		
		TRUNCATE TABLE SS_HC_Apoyo_Diagnostico_FE
		TRUNCATE TABLE SS_HC_Anamnesis_AFAM_CAB_FE
		TRUNCATE TABLE SS_HC_ValoracionSocioFamAM_FE
		TRUNCATE TABLE SS_HC_Examen_Kardex_FE
		TRUNCATE TABLE SS_HC_InterConsulta_Kardex_FE
		TRUNCATE TABLE SS_HC_EpisodioNotificaciones_FE
		TRUNCATE TABLE SS_HC_EpisodioAtencion_Anulado
		TRUNCATE TABLE SS_HC_EvolucionMedica_FE
		TRUNCATE TABLE SS_HC_PacienteDocumentos
		TRUNCATE TABLE SS_HC_HojaRecienNacidoDetalle_FE
		TRUNCATE TABLE SS_HC_Anestesia_Farmaco_FE
		TRUNCATE TABLE SS_HC_Anestesia_Farmacos_Detalle_FE
		TRUNCATE TABLE SS_HC_Monitoreo_Obs_Diagnostico_FE
		TRUNCATE TABLE  SS_SG_CondicionRelacional
	

	TRUNCATE TABLE SS_HA_HomologacionDiagnostico
	TRUNCATE TABLE SS_HA_HomologacionEspecialidad
	TRUNCATE TABLE SS_HA_HomologacionMedico
	TRUNCATE TABLE SS_HA_HomologacionPaciente
	TRUNCATE TABLE SS_HA_HomologacionServicio
	TRUNCATE TABLE SS_HA_HomologacionSucursal






