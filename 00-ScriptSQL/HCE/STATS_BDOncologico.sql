USE msdb;
GO

-- Elimina el job si ya existe
IF EXISTS (SELECT 1 FROM msdb.dbo.sysjobs WHERE name = N'JOB_UPDATE_STATS_BDOncologico')
BEGIN
    EXEC sp_delete_job @job_name = N'JOB_UPDATE_STATS_BDOncologico';
END
GO

EXEC sp_add_job @job_name = N'JOB_UPDATE_STATS_BDOncologico', @enabled = 1, @description = N'Actualiza estadísticas';

EXEC sp_add_jobstep @job_name = N'JOB_UPDATE_STATS_BDOncologico',
    @step_name = N'Update Stats',
    @subsystem = N'TSQL',
    @command = N'USE [BDOncologico]; EXEC sp_updatestats;';

EXEC sp_add_schedule @schedule_name = N'Diario_1AM',
    @freq_type = 4, @freq_interval = 1, @active_start_time = 010000;

EXEC sp_attach_schedule @job_name = N'JOB_UPDATE_STATS_BDOncologico', @schedule_name = N'Diario_1AM';
EXEC sp_add_jobserver @job_name = N'JOB_UPDATE_STATS_BDOncologico', @server_name =  'DARKON';