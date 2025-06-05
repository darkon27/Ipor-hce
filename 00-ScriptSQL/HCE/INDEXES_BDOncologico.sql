USE msdb;
GO

-- Elimina el job si ya existe
IF EXISTS (SELECT 1 FROM msdb.dbo.sysjobs WHERE name = N'JOB_REBUILD_INDEXES_BDOncologico')
BEGIN
    EXEC sp_delete_job @job_name = N'JOB_REBUILD_INDEXES_BDOncologico';
END
GO

-- Ahora crea el job
EXEC sp_add_job @job_name = N'JOB_REBUILD_INDEXES_BDOncologico', @enabled = 1, 
@description = N'Reconstruye índices semanalmente';

-- Agrega el paso
EXEC sp_add_jobstep @job_name = N'JOB_REBUILD_INDEXES_BDOncologico',
    @step_name = N'Rebuild Indexes',
    @subsystem = N'TSQL',
    @command = N'
        DECLARE @table NVARCHAR(MAX);
        DECLARE cur CURSOR FOR
        SELECT QUOTENAME(SCHEMA_NAME(schema_id)) + ''.'' + QUOTENAME(name)
        FROM sys.tables
        WHERE is_ms_shipped = 0;

        OPEN cur;
        FETCH NEXT FROM cur INTO @table;
        WHILE @@FETCH_STATUS = 0
        BEGIN
            EXEC(''ALTER INDEX ALL ON '' + @table + '' REBUILD'');
            FETCH NEXT FROM cur INTO @table;
        END
        CLOSE cur;
        DEALLOCATE cur;';

-- Elimina el schedule si ya existe
IF EXISTS (SELECT 1 FROM msdb.dbo.sysschedules WHERE name = N'Semanal_Domingo_3AM')
BEGIN
    EXEC sp_delete_schedule @schedule_name = N'Semanal_Domingo_3AM';
END
GO

-- Agrega el nuevo schedule (corrigiendo el parámetro faltante)
EXEC sp_add_schedule @schedule_name = N'Semanal_Domingo_3AM',
    @freq_type = 8,  -- Semanal
    @freq_interval = 1,  -- Domingo
    @freq_recurrence_factor = 1,  -- <- Faltaba esto
    @active_start_time = 030000;
GO

-- Asocia el schedule al job
EXEC sp_attach_schedule @job_name = N'JOB_REBUILD_INDEXES_BDOncologico', @schedule_name = N'Semanal_Domingo_3AM';

-- Asigna el job al servidor
EXEC sp_add_jobserver @job_name = N'JOB_REBUILD_INDEXES_BDOncologico', @server_name = 'DARKON';



SELECT 
    OBJECT_NAME(i.object_id) AS TableName,
    i.name AS IndexName,
    i.type_desc AS IndexType,
    i.is_disabled,
    i.fill_factor,
    s.avg_fragmentation_in_percent
FROM sys.indexes i
JOIN sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') s
    ON i.object_id = s.object_id AND i.index_id = s.index_id
WHERE i.type > 0 AND i.is_disabled = 0
ORDER BY s.avg_fragmentation_in_percent DESC;









