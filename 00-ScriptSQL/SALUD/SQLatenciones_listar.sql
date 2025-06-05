GO

CREATE OR ALTER   PROCEDURE [dbo].[SP_V_EpisodioAtenciones_LISTAR_v1]
(
	@Persona	int
	,@NombreCompleto	varchar(100)	
	,@UnidadReplicacion		char(4)
	,@IdEpisodioAtencion		bigint
	,@UnidadReplicacionEC		char(4)	
	,@IdPaciente		int
	,@EpisodioClinico		int
	,@IdEstablecimientoSalud		int
	,@IdUnidadServicio		int
	,@IdPersonalSalud		int		
	,@EpisodioAtencion		bigint
	,@TipoAtencion		int
	,@IdOrdenAtencion	int
	,@TipoOrdenAtencion		int	
	,@Estado_EpisodioAten	int	
	,@FechaRegistroDesde		datetime
	,@FechaRegistroHasta		datetime
	,@FechaAtencion		datetime
	,@FechaCierre		datetime	
	,@UsuarioModificacion		varchar(25)--AUX  ACCION FORM
	--AGREGADOS
	,@CodigoEpisodioClinico		integer
	,@IdEpisodioAtencionCodigo		varchar(100)
	,@CODIGOOA		varchar(25)
	,@TipoTrabajador		varchar(25)	
	,@IdOpcion		integer	
	,@IdFormato		integer
	,@Id001		integer
	,@Id002		integer
	,@Codigo001		varchar(100)
	,@Codigo002		varchar(100)	
	,@Descripcion001	varchar(200)                                      			
	,@INICIO		int= null,  
	@NUMEROFILAS		int = null ,
	@Version		VARCHAR(25)	,--AUX CODIGO OA
	@ACCION		VARCHAR(25)
)

AS
BEGIN
	
	DECLARE @CONTADOR INT
	DECLARE @COD_FORMATO_AUX varchar(30)

	if(@ACCION = 'LISTARPAG')
	begin	
	
				select @COD_FORMATO_AUX = SS_HC_Formato.CodigoFormato from SG_Opcion
				left join SS_HC_Formato on (SS_HC_Formato.IdFormato = SG_Opcion.IdFormato)
				where SG_Opcion.IdOpcion = 3427

				IF @COD_FORMATO_AUX='CCEP0F90'	--DIAGNOSTICO
					BEGIN
						SELECT ROW_NUMBER() OVER (ORDER BY IdEpisodioAtencion asc ) AS RowNumber , * FROM rptViewDiagnostico_FE WHERE IdPaciente=88916
							(@Persona is null or (@Persona =0 ) OR IdPaciente = @Persona)
						AND (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
						AND ((@FechaRegistroDesde is null or  fechaRegistro >= @FechaRegistroDesde)    
						AND (@FechaRegistroHasta is null or  fechaRegistro < DATEADD(DAY,1,@FechaRegistroHasta)))
					END
				IF @COD_FORMATO_AUX='CCEPF004'	--ANTECEDENTES PERSONALES - FISIOLOGICO PEDIATRICO
					BEGIN
						SELECT * FROM rptViewAntecedentesPersonalesFisiologicos_FE WHERE IdPaciente=9807375
							(@Persona is null or (@Persona =0 ) OR IdPaciente = @Persona)
						AND (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
						AND ((@FechaRegistroDesde is null or  fechaRegistro >= @FechaRegistroDesde)    
						AND (@FechaRegistroHasta is null or  fechaRegistro < DATEADD(DAY,1,@FechaRegistroHasta)))
					END
				IF @COD_FORMATO_AUX='CCEP00F2'	--ANTECEDENTE PER. ALERGIAS
					BEGIN
						SELECT * FROM rptViewAlergias_FE WHERE IdPaciente=88916
							(@Persona is null or (@Persona =0 ) OR IdPaciente = @Persona)
						AND (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
						AND ((@FechaRegistroDesde is null or  fechaRegistro >= @FechaRegistroDesde)    
						AND (@FechaRegistroHasta is null or  fechaRegistro < DATEADD(DAY,1,@FechaRegistroHasta)))
					END
				IF @COD_FORMATO_AUX='CCEPF014' -- ANTECEDENTES FAMILIARES
					BEGIN
						SELECT * FROM rptViewAnamnesis_AFAM_FE WHERE IdPaciente=5009674
							(@Persona is null or (@Persona =0 ) OR IdPaciente = @Persona)
						AND (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
						AND ((@FechaRegistroDesde is null or  fechaRegistro >= @FechaRegistroDesde)    
						AND (@FechaRegistroHasta is null or  fechaRegistro < DATEADD(DAY,1,@FechaRegistroHasta)))
					END
				IF @COD_FORMATO_AUX='CCEP00F3' -- ANTECEDENTES PERSONALES - FISIOLOGICOS FE
					BEGIN
						SELECT * FROM rptViewAntecedentesPersonalesFisiologicos_FE WHERE IdPaciente=88916
							(@Persona is null or (@Persona =0 ) OR IdPaciente = @Persona)
						AND (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
						AND ((@FechaRegistroDesde is null or  fechaRegistro >= @FechaRegistroDesde)    
						AND (@FechaRegistroHasta is null or  fechaRegistro < DATEADD(DAY,1,@FechaRegistroHasta)))
					END
				IF @COD_FORMATO_AUX='CCEPF300' -- ANTECEDENTES PERSONALES - FISIOLOGICOS FE
					BEGIN
						SELECT * FROM rptViewEmitirDescansoMedico_FE WHERE IdPaciente=62941
							(@Persona is null or (@Persona =0 ) OR IdPaciente = @Persona)
						AND (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
						AND ((@FechaRegistroDesde is null or  fechaRegistro >= @FechaRegistroDesde)    
						AND (@FechaRegistroHasta is null or  fechaRegistro < DATEADD(DAY,1,@FechaRegistroHasta)))
					END
				IF @COD_FORMATO_AUX='CCEPF300' -- ANTECEDENTES PERSONALES - FISIOLOGICOS FE
					BEGIN
						SELECT * FROM rptViewEmitirDescansoMedico_FE WHERE IdPaciente=62941
							(@Persona is null or (@Persona =0 ) OR IdPaciente = @Persona)
						AND (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
						AND ((@FechaRegistroDesde is null or  fechaRegistro >= @FechaRegistroDesde)    
						AND (@FechaRegistroHasta is null or  fechaRegistro < DATEADD(DAY,1,@FechaRegistroHasta)))
					END
				IF @COD_FORMATO_AUX='CCEPF100' -- ANTECEDENTES PERSONALES - FISIOLOGICOS FE
					BEGIN
						SELECT * FROM rptViewDieta_FE WHERE IdPaciente=1224472
							(@Persona is null or (@Persona =0 ) OR IdPaciente = @Persona)
						AND (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
						AND ((@FechaRegistroDesde is null or  fechaRegistro >= @FechaRegistroDesde)    
						AND (@FechaRegistroHasta is null or  fechaRegistro < DATEADD(DAY,1,@FechaRegistroHasta)))
					END
				IF @COD_FORMATO_AUX='CCEPF150' -- ANTECEDENTES PERSONALES - FISIOLOGICOS FE
					BEGIN
						SELECT * FROM rptViewExamenApoyoDiagnostico_FE WHERE IdPaciente=88916
							(@Persona is null or (@Persona =0 ) OR IdPaciente = @Persona)
						AND (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
						AND ((@FechaRegistroDesde is null or  fechaRegistro >= @FechaRegistroDesde)    
						AND (@FechaRegistroHasta is null or  fechaRegistro < DATEADD(DAY,1,@FechaRegistroHasta)))
					END
				IF @COD_FORMATO_AUX='CCEPF005' -- ANTECEDENTES PERSONALES - FISIOLOGICOS FE
					BEGIN
						SELECT * FROM rptViewAntecedentesPersGinecObstetrico_FE WHERE IdPaciente=9704463
							(@Persona is null or (@Persona =0 ) OR IdPaciente = @Persona)
						AND (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
						AND ((@FechaRegistroDesde is null or  fechaRegistro >= @FechaRegistroDesde)    
						AND (@FechaRegistroHasta is null or  fechaRegistro < DATEADD(DAY,1,@FechaRegistroHasta)))
					END				
				IF @COD_FORMATO_AUX='CCEPF006' -- ANTECEDENTES PERSONALES - FISIOLOGICOS FE
					BEGIN
						SELECT * FROM rptViewAntecedentesPersonalesPatologicosGenerales_FE WHERE IdPaciente=7582812	
							(@Persona is null or (@Persona =0 ) OR IdPaciente = @Persona)
						AND (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
						AND ((@FechaRegistroDesde is null or  fechaRegistro >= @FechaRegistroDesde)    
						AND (@FechaRegistroHasta is null or  fechaRegistro < DATEADD(DAY,1,@FechaRegistroHasta)))
					END
				IF @COD_FORMATO_AUX='CCEPF001' -- ANTECEDENTES PERSONALES - FISIOLOGICOS FE
					BEGIN
						SELECT * FROM rptViewEnfermedadActual_FE WHERE IdPaciente=88916
							(@Persona is null or (@Persona =0 ) OR IdPaciente = @Persona)
						AND (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
						AND ((@FechaRegistroDesde is null or  fechaRegistro >= @FechaRegistroDesde)    
						AND (@FechaRegistroHasta is null or  fechaRegistro < DATEADD(DAY,1,@FechaRegistroHasta)))
					END							
				IF @COD_FORMATO_AUX='CCEPF080' -- ANTECEDENTES PERSONALES - FISIOLOGICOS FE
					BEGIN
						SELECT * FROM rptViewEvolucionMedica_FE WHERE IdPaciente=1164810
							(@Persona is null or (@Persona =0 ) OR IdPaciente = @Persona)
						AND (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
						AND ((@FechaRegistroDesde is null or  fechaRegistro >= @FechaRegistroDesde)    
						AND (@FechaRegistroHasta is null or  fechaRegistro < DATEADD(DAY,1,@FechaRegistroHasta)))
					END					
				IF @COD_FORMATO_AUX='CCEPF153' -- ANTECEDENTES PERSONALES - FISIOLOGICOS FE
					BEGIN
						SELECT * FROM rptViewExamenClinico_FE WHERE IdPaciente=88916
							(@Persona is null or (@Persona =0 ) OR IdPaciente = @Persona)
						AND (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
						AND ((@FechaRegistroDesde is null or  fechaRegistro >= @FechaRegistroDesde)    
						AND (@FechaRegistroHasta is null or  fechaRegistro < DATEADD(DAY,1,@FechaRegistroHasta)))
					END					
				IF @COD_FORMATO_AUX='CCEPF051' -- ANTECEDENTES PERSONALES - FISIOLOGICOS FE
					BEGIN
						SELECT * FROM rptViewFuncionesVitales_FE WHERE IdPaciente=1438840
							(@Persona is null or (@Persona =0 ) OR IdPaciente = @Persona)
						AND (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
						AND ((@FechaRegistroDesde is null or  fechaRegistro >= @FechaRegistroDesde)    
						AND (@FechaRegistroHasta is null or  fechaRegistro < DATEADD(DAY,1,@FechaRegistroHasta)))
					END	
				IF @COD_FORMATO_AUX='CCEPF200' -- ANTECEDENTES PERSONALES - FISIOLOGICOS FE
					BEGIN
						SELECT * FROM rptViewInformeAlta_DatosGenerales_FE WHERE IdPaciente=1017346
							(@Persona is null or (@Persona =0 ) OR IdPaciente = @Persona)
						AND (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
						AND ((@FechaRegistroDesde is null or  fechaRegistro >= @FechaRegistroDesde)    
						AND (@FechaRegistroHasta is null or  fechaRegistro < DATEADD(DAY,1,@FechaRegistroHasta)))
					END					
				IF @COD_FORMATO_AUX='CCEPF151' -- ANTECEDENTES PERSONALES - FISIOLOGICOS FE
					BEGIN
						SELECT * FROM rptViewInterconsulta_FE WHERE IdPaciente=7581906
							(@Persona is null or (@Persona =0 ) OR IdPaciente = @Persona)
						AND (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
						AND ((@FechaRegistroDesde is null or  fechaRegistro >= @FechaRegistroDesde)    
						AND (@FechaRegistroHasta is null or  fechaRegistro < DATEADD(DAY,1,@FechaRegistroHasta)))
					END					
				IF @COD_FORMATO_AUX='CCEPF101' -- ANTECEDENTES PERSONALES - FISIOLOGICOS FE
					BEGIN
						SELECT * FROM rptViewMedicamentos_FE WHERE IdPaciente=88916
							(@Persona is null or (@Persona =0 ) OR IdPaciente = @Persona)
						AND (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(CodigoOA) like '%'+upper(@CODIGOOA)+'%')
						AND ((@FechaRegistroDesde is null or  fechaRegistro >= @FechaRegistroDesde)    
						AND (@FechaRegistroHasta is null or  fechaRegistro < DATEADD(DAY,1,@FechaRegistroHasta)))
					END			
				IF @COD_FORMATO_AUX='CCEPF328' -- ANTECEDENTES PERSONALES - FISIOLOGICOS FE
					BEGIN
						SELECT * FROM rptViewNotaEnfermeria_FE WHERE IdPaciente=9751688
							(@Persona is null or (@Persona =0 ) OR IdPaciente = @Persona)
						AND (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
						AND ((@FechaRegistroDesde is null or  fechaRegistro >= @FechaRegistroDesde)    
						AND (@FechaRegistroHasta is null or  fechaRegistro < DATEADD(DAY,1,@FechaRegistroHasta)))
					END			
	

		--set @CODIGOOA = @Version
		--if(@UsuarioModificacion is not null)
		--begin
		--	select @COD_FORMATO_AUX = SS_HC_Formato.CodigoFormato from SG_Opcion
		--	left join SS_HC_Formato on (SS_HC_Formato.IdFormato = SG_Opcion.IdFormato)
		--	where SG_Opcion.IdOpcion = convert(int ,@UsuarioModificacion)
		--end
		--declare @CONTADOR_DIN int =0			
		--	select @CONTADOR_DIN= count(*)
		--		from SS_HC_EpisodioAtencionFormato EpiAtencionFormato											
		--		where 
		--		EpiAtencionFormato.UnidadReplicacion= @UnidadReplicacion
		--				and  EpiAtencionFormato.EpisodioClinico= @EpisodioClinico
		--					and EpiAtencionFormato.IdEpisodioAtencion= @IdEpisodioAtencion
		--					and  EpiAtencionFormato.IdPaciente= @IdPaciente	
		--SELECT @CONTADOR= COUNT(*) 					
		--			FROM dbo.V_EpisodioAtenciones
		--				left join SS_HC_EpisodioAtencion epiAtencion
		--				on (epiAtencion.EpisodioClinico = V_EpisodioAtenciones.EpisodioClinico
		--					and epiAtencion.IdEpisodioAtencion = V_EpisodioAtenciones.IdEpisodioAtencion
		--					and epiAtencion.UnidadReplicacion = V_EpisodioAtenciones.UnidadReplicacion
		--					and epiAtencion.IdPaciente = V_EpisodioAtenciones.IdPaciente
		--					and epiAtencion.IdOrdenAtencion = V_EpisodioAtenciones.IdOrdenAtencion
		--				)											
		--			WHERE 
		--			(@Persona is null or (@Persona =0 ) OR Persona = @Persona)
		--			and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones.IdPaciente = @IdPaciente)
		--			and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
		--			and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
		--			and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones.IdOrdenAtencion = @IdOrdenAtencion)
		--			and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones.Accion = @COD_FORMATO_AUX)
		--			and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
		--			AND ((@FechaRegistroDesde is null or  V_EpisodioAtenciones.FechaCreacion >= @FechaRegistroDesde)    
	 --               and (@FechaRegistroHasta is null or  V_EpisodioAtenciones.FechaCreacion < DATEADD(DAY,1,@FechaRegistroHasta)))
	 	 
 
		--SELECT 
		--		convert(int,RowNumber) as [Persona]  --OBS: persona == idPaciente
		--	  ,[ApellidoPaterno]
		--	  ,[ApellidoMaterno]
		--	  ,[Nombres]
		--	  ,[NombreCompleto]
		--	  ,[UnidadReplicacion]
		--	  ,[IdPaciente]
		--	  ,[FechaCierre]
		--	  ,[Episodio_Atencion]
		--	  ,[FechaReg_EpisoAtencon]
		--	  ,[FechaAtencion]
		--	  ,[TipoAtencion]
		--	  ,[IdOrdenAtencion]
		--	  ,[LineaOrdenAtencion]
		--	  ,[TipoOrdenAtencion]
		--	  ,[Estado_EpisodioAten]
		--	  ,[UsuarioCreacion]
		--	  ,[FechaCreacion]
		--	  ,CodigoOAX as UsuarioModificacion ---AUX cod OA
		--	  ,[FechaModificacion]
		--	  ,RIGHT('0000'+CAST(Episodio_Atencion AS VARCHAR(4)),4) +
		--		'.'+RIGHT('0000'+CAST(IdEpisodioAtencion AS VARCHAR(4)),4) +
		--		' - ' + ISNULL(MotivoConsulta,'Episodio')  as MotivoConsulta
		--	  ,[FechaRegistro]
		--	  ,[Accion]
		--	  ,[EpisodioClinico]
		--	  ,[IdEpisodioAtencion]
		--	  ,[UnidadReplicacionEC]
		--	  ,[IdEstablecimientoSalud]
		--	  ,[IdUnidadServicio]
		--	  ,[IdPersonalSalud]
		--	  ,NombreMedicoUserX as PersonalSaludNombre
		--	  ,[IdEspecialidad]
		--	  ,[especialidadNombre]			  
  --                    ---AGREGADOS ---                      
		--		  ,[CodigoEpisodioClinico]
		--		  ,[IdEpisodioAtencionCodigo]
		--		  ,[CodigoOA]
		--		  ,[TipoTrabajador]
		--		  ,[TipoTrabajador_Desc]
		--		  ,[Id001]
		--		  ,[Id002]
		--		  ,[Codigo001]
		--		  ,[Codigo002]
		--		  ,[Codigo003]
		--		  ,[Codigo004]
		--		  ,[Descripcion001]
		--		  ,[Descripcion002]
		--		  ,[Descripcion003]
		--		  ,[Descripcion004]
		--		  ,[Documento_Paciente]
		--		  ,[Documento_Medico]
		--		  ,[Formato_Codigo]
		--		  ,[Formato_Id]
		--		  ,[Formato_Tipo]
		--		  ,[Formato_Uso]
		--		  ,[Formato_Descripcion]
		--		  ,(@CONTADOR + @CONTADOR_DIN) as contador_filas
		--FROM (	 
		--		SELECT V_EpisodioAtenciones_MAIN.*,	
		--			--V_EpisodioAtenciones_MAIN.CodigoOAX ,
		--			medicoUser.NombreCompleto AS NombreMedicoUserX ,
		--			@CONTADOR AS Contador,
		--			ROW_NUMBER() OVER (ORDER BY /*V_EpisodioAtenciones_MAIN.CodigoOA DESC,*/V_EpisodioAtenciones_MAIN.IdEpisodioAtencion asc ) AS RowNumber    						
		--			FROM 
		--			(
		--				select V_EpisodioAtenciones.*, 
		--				epiAtencion.CodigoOA AS CodigoOAX 
		--				 from 
		--				dbo.V_EpisodioAtenciones
		--				left join SS_HC_EpisodioAtencion epiAtencion
		--				on (epiAtencion.EpisodioClinico = V_EpisodioAtenciones.EpisodioClinico
		--					and epiAtencion.IdEpisodioAtencion = V_EpisodioAtenciones.IdEpisodioAtencion
		--					and epiAtencion.UnidadReplicacion = V_EpisodioAtenciones.UnidadReplicacion
		--					and epiAtencion.IdPaciente = V_EpisodioAtenciones.IdPaciente
		--					and epiAtencion.IdOrdenAtencion = V_EpisodioAtenciones.IdOrdenAtencion
		--				)				
		--				WHERE 
		--				(@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones.Persona = @Persona)
		--				and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones.IdPaciente = @IdPaciente)
		--				and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(V_EpisodioAtenciones.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
		--				and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
		--				and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones.IdOrdenAtencion = @IdOrdenAtencion)
		--				and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones.Accion = @COD_FORMATO_AUX)					
		--				and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
		--				AND ((@FechaRegistroDesde is null or  V_EpisodioAtenciones.FechaCreacion >= @FechaRegistroDesde)    
	 --                   and (@FechaRegistroHasta is null or  V_EpisodioAtenciones.FechaCreacion < DATEADD(DAY,1,@FechaRegistroHasta))
	                    
	 --                   )

		--				UNION
		--				select 
		--					EpiAtencionFormato.IdPaciente as Persona,paciente.ApellidoPaterno as ApellidoPaterno,paciente.ApellidoMaterno as ApellidoMaterno,null as Nombres,paciente.NombreCompleto as NombreCompleto,
		--					EpiAtencionFormato.UnidadReplicacion,IdPaciente,null as FechaCierre,0 as Episodio_Atencion,null as FechaReg_EpisoAtencon,
		--					null as FechaAtencion,0 as TipoAtencion,0 as IdOrdenAtencion,0 as LineaOrdenAtencion, 0 as TipoOrdenAtencion,
		--					EpiAtencionFormato.Estado as Estado_EpisodioAten,EpiAtencionFormato.UsuarioCreacion,EpiAtencionFormato.FechaCreacion,EpiAtencionFormato.UsuarioModificacion,EpiAtencionFormato.FechaModificacion,
		--					ConceptoFormulario as MotivoConsulta,null as FechaRegistro,convert(varchar,IdTransacciones) as Accion,EpisodioClinico as EpisodioClinico,IdEpisodioAtencion as IdEpisodioAtencion,
		--					'CEG' as UnidadReplicacionEC,IdOpcion as IdEstablecimientoSalud,IdForm as IdUnidadServicio,0 as IdPersonalSalud,null as PersonalSaludNombre,  --AUX OPCION Y FORM
		--					0 as IdEspecialidad,null as especialidadNombre,	
  --                    ---AGREGADOS ---                      
  --                    '000' as CodigoEpisodioClinico
  --                    ,'000' as  IdEpisodioAtencionCodigo
  --                    ,null as  CodigoOA
  --                    ,'000' as  TipoTrabajador
  --                    ,'000' as TipoTrabajador_Desc
  --                    ,0 as Id001
  --                    ,0 as Id002
  --                    ,'000' as Codigo001
  --                    ,'000' as Codigo002
  --                    ,'000' as Codigo003
  --                    ,'000' as Codigo004
  --                    ,'000' as Descripcion001
  --                    ,'000' as Descripcion002
  --                    ,'000' as Descripcion003
  --                    ,'000' as Descripcion004
  --                    ,'000' as  Documento_Paciente
  --                    ,'000' as  Documento_Medico
  --                    --INFO FORMATO
  --                    ,'000' as Formato_Codigo
  --                    ,0 as Formato_Id
  --                    ,0 as Formato_Tipo
  --                    ,0 as Formato_Uso
  --                    ,'000' as Formato_Descripcion       
  --                    ,0 as contador_filas  ,
                      												
		--					null as  CodigoOAX
		--				 from SS_HC_EpisodioAtencionFormato EpiAtencionFormato				
		--					left join PERSONAMAST paciente on (paciente.Persona = EpiAtencionFormato.IdPaciente)
		--				 where 
		--					EpiAtencionFormato.UnidadReplicacion= @UnidadReplicacion
		--					and  EpiAtencionFormato.EpisodioClinico= @EpisodioClinico
		--					and EpiAtencionFormato.IdEpisodioAtencion= @IdEpisodioAtencion
		--					and  EpiAtencionFormato.IdPaciente= @IdPaciente	

														
		--			)as V_EpisodioAtenciones_MAIN
		--				left join SG_Agente agente 
		--				on (agente.CodigoAgente = V_EpisodioAtenciones_MAIN.UsuarioCreacion)
		--				left join PERSONAMAST medicoUser 
		--				on (medicoUser.persona = agente.IdEmpleado)						
		--			--					
		--			) AS LISTADO
		--			WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
		--			       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
		--			order by  FechaCreacion 

							   				       
	end
	else 
	if(@ACCION='LISTARPAGTRIAJE')
		begin		
		DECLARE @TRIAJEEMER VARCHAR(12)
			DECLARE @TRIAJEALER VARCHAR(12)
			SET @TRIAJEEMER='CCEPF630'
			SET @TRIAJEALER='CCEPF631'
		set @CODIGOOA = @Version
		if(@UsuarioModificacion is not null)
		begin
			select @COD_FORMATO_AUX = SS_HC_Formato.CodigoFormato from SG_Opcion
			left join SS_HC_Formato on (SS_HC_Formato.IdFormato = SG_Opcion.IdFormato)
			where SG_Opcion.IdOpcion = convert(int ,@UsuarioModificacion)
		end
declare @CONTADOR_DINT int =0			
			select @CONTADOR_DINT= count(*)
				from SS_HC_EpisodioAtencionFormato EpiAtencionFormato											
				where 
				EpiAtencionFormato.UnidadReplicacion= @UnidadReplicacion
						and  EpiAtencionFormato.EpisodioClinico= @EpisodioClinico
							--and EpiAtencionFormato.IdEpisodioAtencion= @IdEpisodioAtencion
							and  EpiAtencionFormato.IdPaciente= @IdPaciente	
		SELECT @CONTADOR= COUNT(*) 					
					FROM dbo.V_EpisodioAtenciones
						left join SS_HC_EpisodioTriaje epiAtencion
						on (epiAtencion.IdEpisodioTriaje = V_EpisodioAtenciones.EpisodioClinico			
							and epiAtencion.UnidadReplicacion = V_EpisodioAtenciones.UnidadReplicacion
							and epiAtencion.IdPaciente = V_EpisodioAtenciones.IdPaciente
					
						)											
					WHERE 
					(@Persona is null or (@Persona =0 ) OR Persona = @Persona)
					and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones.IdPaciente = @IdPaciente)
					and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
					and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
					--and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones.IdOrdenAtencion = @IdOrdenAtencion)
					and (V_EpisodioAtenciones.Accion IN (case when @UsuarioModificacion='0' then @TRIAJEEMER else @COD_FORMATO_AUX end ,case when @UsuarioModificacion='0' then @TRIAJEALER else '' end))
					--and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones.Accion = @COD_FORMATO_AUX)
					and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOT) like '%'+upper(@CODIGOOA)+'%')
					AND ((@FechaRegistroDesde is null or  V_EpisodioAtenciones.FechaCreacion >= @FechaRegistroDesde)    
	                and (@FechaRegistroHasta is null or  V_EpisodioAtenciones.FechaCreacion < DATEADD(DAY,1,@FechaRegistroHasta)))
	 
 
		SELECT 
				convert(int,RowNumber) as [Persona]  --OBS: persona == idPaciente
			  ,[ApellidoPaterno]
			  ,[ApellidoMaterno]
			  ,[Nombres]
			  ,[NombreCompleto]
			  ,[UnidadReplicacion]
			  ,[IdPaciente]
			  ,[FechaCierre]
			  ,[Episodio_Atencion]
			  ,[FechaReg_EpisoAtencon]
			  ,[FechaAtencion]
			  ,(case when IdEstablecimientoSalud=null then 0 else IdEstablecimientoSalud end)as TipoAtencion--[TipoAtencion]
			  ,[IdOrdenAtencion]
			  ,(case when IdEstablecimientoSalud=null then 0 else IdEstablecimientoSalud end)as LineaOrdenAtencion --[LineaOrdenAtencion]
			  ,(case when IdEstablecimientoSalud=null then 0 else IdEstablecimientoSalud end) as TipoOrdenAtencion --[TipoOrdenAtencion]
			  ,[Estado_EpisodioAten]
			  ,[UsuarioCreacion]
			  ,[FechaCreacion]
			  ,CodigoOAX as UsuarioModificacion ---AUX cod OA
			  ,[FechaModificacion]
			  ,RIGHT('0000'+CAST(Episodio_Atencion AS VARCHAR(4)),4) +
				'.'+RIGHT('0000'+CAST(IdEpisodioAtencion AS VARCHAR(4)),4) +
				' - ' + ISNULL(MotivoConsulta,'Episodio')  as MotivoConsulta
			  --,[MotivoConsulta]
			  ,[FechaRegistro]
			  ,[Accion]
			  ,[EpisodioClinico]
			  ,IdEpisodioAtencion
			  ,[UnidadReplicacionEC]
			  ,[IdEstablecimientoSalud]
			  ,[IdUnidadServicio]
			  ,[IdPersonalSalud]
			  ,PersonalSaludNombre
			  ,(case when IdEstablecimientoSalud=null then 0 else IdEstablecimientoSalud end)as IdEspecialidad --IdEspecialidad
			  ,[especialidadNombre]			  
                      ---AGREGADOS ---                      
				  ,[CodigoEpisodioClinico]
				  ,CodigoOA as IdEpisodioAtencionCodigo
				  ,[CodigoOA]
				  ,[TipoTrabajador]
				  ,[TipoTrabajador_Desc]
				  ,[Id001]
				  ,[Id002]
				  ,[Codigo001]
				  ,[Codigo002]
				  ,[Codigo003]
				  ,[Codigo004]
				  ,[Descripcion001]
				  ,[Descripcion002]
				  ,[Descripcion003]
				  ,[Descripcion004]
				  ,[Documento_Paciente]
				  ,[Documento_Medico]
				  ,[Formato_Codigo]
				  ,[Formato_Id]
				  ,[Formato_Tipo]
				  ,[Formato_Uso]
				  ,[Formato_Descripcion]
				  ,(@CONTADOR + @CONTADOR_DINT) as contador_filas
		FROM (	 
				SELECT V_EpisodioAtenciones_MAIN.*,	
					--V_EpisodioAtenciones_MAIN.CodigoOAX ,
					medicoUser.NombreCompleto AS NombreMedicoUserX ,
					@CONTADOR AS Contador,
					ROW_NUMBER() OVER (ORDER BY /*V_EpisodioAtenciones_MAIN.CodigoOA DESC,*/V_EpisodioAtenciones_MAIN.IdEpisodioAtencion asc ) AS RowNumber    						
					FROM 
					(
						select V_EpisodioAtenciones.*, 
						epiAtencion.CodigoOT AS CodigoOAX 
						 from 
						dbo.V_EpisodioAtenciones
						left join SS_HC_EpisodioTriaje epiAtencion
						on (
						epiAtencion.CodigoOT = V_EpisodioAtenciones.CodigoOA and
							
							 epiAtencion.UnidadReplicacion = V_EpisodioAtenciones.UnidadReplicacion
							and epiAtencion.IdPaciente = V_EpisodioAtenciones.IdPaciente
							
						)				
						WHERE 
						(@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones.Persona = @Persona)
						and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones.IdPaciente = @IdPaciente)
						and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(V_EpisodioAtenciones.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
						and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
						and (V_EpisodioAtenciones.Accion IN (case when @UsuarioModificacion='0' then @TRIAJEEMER else @COD_FORMATO_AUX end ,case when @UsuarioModificacion='0' then @TRIAJEALER else '' end))				
						and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(epiAtencion.CodigoOT) like '%'+upper(@CODIGOOA)+'%')
						AND ((@FechaRegistroDesde is null or  V_EpisodioAtenciones.FechaCreacion >= @FechaRegistroDesde)    
	                    and (@FechaRegistroHasta is null or  V_EpisodioAtenciones.FechaCreacion < DATEADD(DAY,1,@FechaRegistroHasta))									
	                    )																		
					)as V_EpisodioAtenciones_MAIN
						left join SG_Agente agente 
						on (agente.CodigoAgente = V_EpisodioAtenciones_MAIN.UsuarioCreacion)
						left join PERSONAMAST medicoUser 
						on (medicoUser.persona = agente.IdEmpleado)						
					--					
					) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
					order by /*CodigoOA DESC,*/ FechaCreacion /*DESC */    
							   				       
	end
	else
		if(@ACCION = 'LISTARPAGOBLIGATORIO')
	begin		
		set @CODIGOOA = @Version
		if(@UsuarioModificacion is not null)
		begin
			select @COD_FORMATO_AUX = SS_HC_Formato.CodigoFormato from SG_Opcion
			left join SS_HC_Formato on (SS_HC_Formato.IdFormato = SG_Opcion.IdFormato)
			where SG_Opcion.IdOpcion = convert(int ,@UsuarioModificacion)
		end
	
	--	declare @CONTADOR_DIN int =0			
			select @CONTADOR_DIN= count(*)
				from SS_HC_EpisodioAtencionFormato EpiAtencionFormato											
				where 
				EpiAtencionFormato.UnidadReplicacion= @UnidadReplicacion
						and  EpiAtencionFormato.EpisodioClinico= @EpisodioClinico
							and EpiAtencionFormato.IdEpisodioAtencion= @IdEpisodioAtencion
							and  EpiAtencionFormato.IdPaciente= @IdPaciente					
							AND EpiAtencionFormato.IdOpcion =@UsuarioModificacion
										
			
		SELECT @CONTADOR= COUNT(*) 					
					FROM dbo.V_EpisodioAtenciones
						left join SS_HC_EpisodioAtencion epiAtencion
						on (epiAtencion.EpisodioClinico = V_EpisodioAtenciones.EpisodioClinico
							and epiAtencion.IdEpisodioAtencion = V_EpisodioAtenciones.Episodio_Atencion
							and epiAtencion.UnidadReplicacion = V_EpisodioAtenciones.UnidadReplicacion
							and epiAtencion.IdPaciente = V_EpisodioAtenciones.IdPaciente
							and epiAtencion.IdOrdenAtencion = V_EpisodioAtenciones.IdOrdenAtencion
						)											
					WHERE 
					  (@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones.Persona = @Persona)
						and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones.IdPaciente = @IdPaciente)
						and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones.Accion = @COD_FORMATO_AUX)					
					    and (@UnidadReplicacion is null  OR  upper(V_EpisodioAtenciones.UnidadReplicacion) like '%'+upper(@UnidadReplicacion)+'%')							
					    and (@IdEpisodioAtencion is null OR  V_EpisodioAtenciones.Episodio_Atencion = @IdEpisodioAtencion)
					    and (@EpisodioClinico  is null OR V_EpisodioAtenciones.EpisodioClinico = @EpisodioClinico)
	 	 
 
		SELECT 
				convert(int,RowNumber) as [Persona]  --OBS: persona == idPaciente
			  ,[ApellidoPaterno]
			  ,[ApellidoMaterno]
			  ,[Nombres]
			  ,[NombreCompleto]
			  ,[UnidadReplicacion]
			  ,[IdPaciente]
			  ,[FechaCierre]
			  ,[Episodio_Atencion]
			  ,[FechaReg_EpisoAtencon]
			  ,[FechaAtencion]
			  ,[TipoAtencion]
			  ,[IdOrdenAtencion]
			  ,[LineaOrdenAtencion]
			  ,[TipoOrdenAtencion]
			  ,[Estado_EpisodioAten]
			  ,[UsuarioCreacion]
			  ,[FechaCreacion]
			  ,CodigoOAX as UsuarioModificacion ---AUX cod OA
			  ,[FechaModificacion]
			  ,RIGHT('0000'+CAST(Episodio_Atencion AS VARCHAR(4)),4) +
				'.'+RIGHT('0000'+CAST(IdEpisodioAtencion AS VARCHAR(4)),4) +
				' - ' + ISNULL(MotivoConsulta,'Episodio')  as MotivoConsulta
			  --,[MotivoConsulta]
			  ,[FechaRegistro]
			  ,[Accion]
			  ,[EpisodioClinico]
			  ,[IdEpisodioAtencion]
			  ,[UnidadReplicacionEC]
			  ,[IdEstablecimientoSalud]
			  ,[IdUnidadServicio]
			  ,[IdPersonalSalud]
			  ,NombreMedicoUserX as PersonalSaludNombre
			  ,[IdEspecialidad]
			  ,[especialidadNombre]			  
                      ---AGREGADOS ---                      
				  ,[CodigoEpisodioClinico]
				  ,[IdEpisodioAtencionCodigo]
				  ,[CodigoOA]
				  ,[TipoTrabajador]
				  ,[TipoTrabajador_Desc]
				  ,[Id001]
				  ,[Id002]
				  ,[Codigo001]
				  ,[Codigo002]
				  ,[Codigo003]
				  ,[Codigo004]
				  ,[Descripcion001]
				  ,[Descripcion002]
				  ,[Descripcion003]
				  ,[Descripcion004]
				  ,[Documento_Paciente]
				  ,[Documento_Medico]
				  ,[Formato_Codigo]
				  ,[Formato_Id]
				  ,[Formato_Tipo]
				  ,[Formato_Uso]
				  ,[Formato_Descripcion]
				  ,(@CONTADOR + @CONTADOR_DIN) as contador_filas
		FROM (	 
				SELECT V_EpisodioAtenciones_MAIN.*,	
					--V_EpisodioAtenciones_MAIN.CodigoOAX ,
					medicoUser.NombreCompleto AS NombreMedicoUserX ,
					
					@CONTADOR AS Contador,
					ROW_NUMBER() OVER (ORDER BY /*V_EpisodioAtenciones_MAIN.CodigoOA DESC,*/V_EpisodioAtenciones_MAIN.IdEpisodioAtencion asc ) AS RowNumber    						
					FROM 
					(
						select V_EpisodioAtenciones.*, 
						epiAtencion.CodigoOA AS CodigoOAX 
						 from 
						dbo.V_EpisodioAtenciones
						left join SS_HC_EpisodioAtencion epiAtencion
						on (epiAtencion.EpisodioClinico = V_EpisodioAtenciones.EpisodioClinico
							and epiAtencion.IdEpisodioAtencion = V_EpisodioAtenciones.Episodio_Atencion
							and epiAtencion.UnidadReplicacion = V_EpisodioAtenciones.UnidadReplicacion
							and epiAtencion.IdPaciente = V_EpisodioAtenciones.IdPaciente
							and epiAtencion.IdOrdenAtencion = V_EpisodioAtenciones.IdOrdenAtencion
						)
											
						WHERE 
						    (@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones.Persona = @Persona)
						and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones.IdPaciente = @IdPaciente)
						and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones.Accion = @COD_FORMATO_AUX)					
                 
					    and (@UnidadReplicacion is null  OR  upper(V_EpisodioAtenciones.UnidadReplicacion) like '%'+upper(@UnidadReplicacion)+'%')							
					    and (@IdEpisodioAtencion is null OR  V_EpisodioAtenciones.Episodio_Atencion = @IdEpisodioAtencion)
					    and (@EpisodioClinico  is null OR V_EpisodioAtenciones.EpisodioClinico = @EpisodioClinico)								
	                    
						UNION
						select 
							EpiAtencionFormato.IdPaciente as Persona,paciente.ApellidoPaterno as ApellidoPaterno,paciente.ApellidoMaterno as ApellidoMaterno,null as Nombres,paciente.NombreCompleto as NombreCompleto,
							EpiAtencionFormato.UnidadReplicacion,IdPaciente,null as FechaCierre,0 as Episodio_Atencion,null as FechaReg_EpisoAtencon,
							null as FechaAtencion,0 as TipoAtencion,0 as IdOrdenAtencion,0 as LineaOrdenAtencion, 0 as TipoOrdenAtencion,
							EpiAtencionFormato.Estado as Estado_EpisodioAten,EpiAtencionFormato.UsuarioCreacion,EpiAtencionFormato.FechaCreacion,EpiAtencionFormato.UsuarioModificacion,EpiAtencionFormato.FechaModificacion,
							ConceptoFormulario as MotivoConsulta,null as FechaRegistro,convert(varchar,IdTransacciones) as Accion,EpisodioClinico as EpisodioClinico,IdEpisodioAtencion as IdEpisodioAtencion,
							'CEG' as UnidadReplicacionEC,IdOpcion as IdEstablecimientoSalud,IdForm as IdUnidadServicio,0 as IdPersonalSalud,null as PersonalSaludNombre,  --AUX OPCION Y FORM
							0 as IdEspecialidad,null as especialidadNombre,	
                      ---AGREGADOS ---                      
                      '000' as CodigoEpisodioClinico
                      ,'000' as  IdEpisodioAtencionCodigo
                      ,null as  CodigoOA
                      ,'000' as  TipoTrabajador
                      ,'000' as TipoTrabajador_Desc
                      ,0 as Id001
                      ,0 as Id002
                      ,'000' as Codigo001
                      ,'000' as Codigo002
                      ,'000' as Codigo003
                      ,'000' as Codigo004
                      ,'000' as Descripcion001
                      ,'000' as Descripcion002
                      ,'000' as Descripcion003
                      ,'000' as Descripcion004
                      ,'000' as  Documento_Paciente
                      ,'000' as  Documento_Medico
                      --INFO FORMATO
                      ,'000' as Formato_Codigo
                      ,0 as Formato_Id
                      ,0 as Formato_Tipo
                      ,0 as Formato_Uso
                      ,'000' as Formato_Descripcion       
                      ,0 as contador_filas  ,
                      												
							null as  CodigoOAX
						 from SS_HC_EpisodioAtencionFormato EpiAtencionFormato				
							left join PERSONAMAST paciente on (paciente.Persona = EpiAtencionFormato.IdPaciente)
						 where 
							EpiAtencionFormato.UnidadReplicacion= @UnidadReplicacion
							and  EpiAtencionFormato.EpisodioClinico= @EpisodioClinico
							and EpiAtencionFormato.IdEpisodioAtencion= @IdEpisodioAtencion
							and  EpiAtencionFormato.IdPaciente= @IdPaciente	
							--ADD 13.06.2017 OES
							and EpiAtencionFormato.IdOpcion=@UsuarioModificacion				
														
					)as V_EpisodioAtenciones_MAIN
						left join SG_Agente agente 
						on (agente.CodigoAgente = V_EpisodioAtenciones_MAIN.UsuarioCreacion)
						left join PERSONAMAST medicoUser 
						on (medicoUser.persona = agente.IdEmpleado)						
					--					
					) AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       RowNumber BETWEEN @Inicio  AND @NumeroFilas 
					order by /*CodigoOA DESC,*/ FechaCreacion /*DESC */  
		 
							   				       
	end
	ELSE
	if(@ACCION = 'LISTAR')
	begin
		SELECT *				
		FROM dbo.V_EpisodioAtenciones
					WHERE 
					(@Persona is null or (@Persona =0 ) OR Persona = @Persona)
					and (@IdPaciente is null  or (@IdPaciente =0 ) OR IdPaciente = @IdPaciente)
					and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
					and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
					and (@IdOrdenAtencion  is null OR IdOrdenAtencion = @IdOrdenAtencion)
					and (@UsuarioModificacion  is null OR V_EpisodioAtenciones.Accion = @UsuarioModificacion)
					
	end	
	ELSE
if(@ACCION = 'LISTARCOPYPAG')
	begin		
		 set @COD_FORMATO_AUX = @Codigo002		 
		 if(@Codigo002 is not null)
			begin
				select @COD_FORMATO_AUX = SS_HC_Formato.CodigoFormato from SG_Opcion
				left join SS_HC_Formato on (SS_HC_Formato.IdFormato = SG_Opcion.IdFormato)
				where SG_Opcion.IdOpcion = convert(int ,@Codigo002)
			end			 
		--@CONTADOR = 
		SELECT @CONTADOR = COUNT(*)
		FROM		
			V_EpisodioAtenciones AS V_EpisodioAtenciones_MAIN
			--where V_EpisodioAtenciones_MAIN.IdPaciente=1076942		
			WHERE 
				(@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones_MAIN.Persona = @Persona)
				and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones_MAIN.IdPaciente = @IdPaciente)
				and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(V_EpisodioAtenciones_MAIN.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
				and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
				and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones_MAIN.IdOrdenAtencion = @IdOrdenAtencion)
				and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Formato_Codigo = @COD_FORMATO_AUX)					
				and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
							

	
		SELECT LISTADO.* FROM
		(
			select 
		      convert(integer,ROW_NUMBER() OVER (ORDER BY V_EpisodioAtenciones_MAIN.FechaCreacion DESC ) )			  
			  AS Persona ,   
			  ApellidoPaterno,
			  ApellidoMaterno,
			  Nombres,
			  NombreCompleto,
			  UnidadReplicacion,
			  IdPaciente,
			  FechaCierre,
			  Episodio_Atencion,
			  FechaReg_EpisoAtencon,
			  FechaAtencion,
			  TipoAtencion,
			  IdOrdenAtencion,
			  LineaOrdenAtencion,
			  TipoOrdenAtencion,
			  Estado_EpisodioAten,
			  UsuarioCreacion,
			  FechaCreacion,
			  UsuarioModificacion,
			  FechaModificacion,
			  MotivoConsulta,
			  FechaRegistro,
			  Accion,
			  EpisodioClinico,
			  IdEpisodioAtencion,
			  UnidadReplicacionEC,
			  IdEstablecimientoSalud,
			  IdUnidadServicio,
			  IdPersonalSalud,
			  PersonalSaludNombre,
			  IdEspecialidad,
			  especialidadNombre,
			  CodigoEpisodioClinico,	
			  '['+right('0000000'+isnull(convert(varchar,CodigoEpisodioClinico),'No Def'),6)+']'+ + '.'+
			  right('0000000'+isnull(convert(varchar,IdEpisodioAtencion),'No Def'),6) as IdEpisodioAtencionCodigo,
			  CodigoOA,
			  TipoTrabajador,
			  TipoTrabajador_Desc,
			  Id001,
			  Id002,
			  Codigo001,
			  Codigo002,
			  Codigo003,
			  Codigo004,
			  Descripcion001,
			  Descripcion002,
			  Descripcion003,
			  right('0000000'+isnull(convert(varchar,CodigoEpisodioClinico),'No Def'),6) as Descripcion004,
			  Documento_Paciente,
			  Documento_Medico,
			  Formato_Codigo,
			  Formato_Id,
			  Formato_Tipo,
			  Formato_Uso,
			  Formato_Descripcion
			  ,	
			  @CONTADOR as contador_filas	
			from V_EpisodioAtenciones as V_EpisodioAtenciones_MAIN
		--	where 
		--	V_EpisodioAtenciones_MAIN.Persona=14
		--	AND V_EpisodioAtenciones_MAIN.IdPaciente=14
		----	AND V_EpisodioAtenciones_MAIN.EpisodioClinico=168
		--	AND V_EpisodioAtenciones_MAIN.Formato_Codigo='CCEPF200D'
			
		WHERE 
				(@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones_MAIN.Persona = @Persona)
				and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones_MAIN.IdPaciente = @IdPaciente)
				and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(V_EpisodioAtenciones_MAIN.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
				and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
				and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones_MAIN.IdOrdenAtencion = @IdOrdenAtencion)
				and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Formato_Codigo = @COD_FORMATO_AUX)					
				and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')


				  			
		)AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       LISTADO.Persona BETWEEN @Inicio  AND @NumeroFilas 	
		
	END
	


	
if(@ACCION = 'LISTARCOPYREC')
	begin		
		 set @COD_FORMATO_AUX = @Codigo002		 
		 if(@Codigo002 is not null)
			begin
				select @COD_FORMATO_AUX = SS_HC_Formato.CodigoFormato from SG_Opcion
				left join SS_HC_Formato on (SS_HC_Formato.IdFormato = SG_Opcion.IdFormato)
				where SG_Opcion.IdOpcion = convert(int ,@Codigo002)
			end			 
		--@CONTADOR = 
		SELECT @CONTADOR = COUNT(*)
		FROM		
			V_EpisodioAtenciones AS V_EpisodioAtenciones_MAIN
			--where V_EpisodioAtenciones_MAIN.IdPaciente=1076942		
			WHERE 
				(@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones_MAIN.Persona = @Persona)
				and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones_MAIN.IdPaciente = @IdPaciente)
				and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(V_EpisodioAtenciones_MAIN.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
				and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
				and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones_MAIN.IdOrdenAtencion = @IdOrdenAtencion)
				and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Formato_Codigo = @COD_FORMATO_AUX)
				and (@UsuarioModificacion  is null OR V_EpisodioAtenciones_MAIN.Formato_Codigo = @UsuarioModificacion)
				and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
							

	
		SELECT LISTADO.* FROM
		(
			select 
		      convert(integer,ROW_NUMBER() OVER (ORDER BY V_EpisodioAtenciones_MAIN.FechaCreacion DESC ) )			  
			  AS Persona ,   
			  ApellidoPaterno,
			  ApellidoMaterno,
			  Nombres,
			  NombreCompleto,
			  UnidadReplicacion,
			  IdPaciente,
			  FechaCierre,
			  Episodio_Atencion,
			  FechaReg_EpisoAtencon,
			  FechaAtencion,
			  TipoAtencion,
			  IdOrdenAtencion,
			  LineaOrdenAtencion,
			  TipoOrdenAtencion,
			  Estado_EpisodioAten,
			  UsuarioCreacion,
			  FechaCreacion,
			  UsuarioModificacion,
			  FechaModificacion,
			  MotivoConsulta,
			  FechaRegistro,
			  Accion,
			  EpisodioClinico,
			  IdEpisodioAtencion,
			  UnidadReplicacionEC,
			  IdEstablecimientoSalud,
			  IdUnidadServicio,
			  IdPersonalSalud,
			  PersonalSaludNombre,
			  IdEspecialidad,
			  especialidadNombre,
			  CodigoEpisodioClinico,	
			  '['+right('0000000'+isnull(convert(varchar,CodigoEpisodioClinico),'No Def'),6)+']'+ + '.'+
			  right('0000000'+isnull(convert(varchar,IdEpisodioAtencion),'No Def'),6) as IdEpisodioAtencionCodigo,
			  CodigoOA,
			  TipoTrabajador,
			  TipoTrabajador_Desc,
			  Id001,
			  Id002,
			  Codigo001,
			  Codigo002,
			  Codigo003,
			  Codigo004,
			  Descripcion001,
			  Descripcion002,
			  Descripcion003,
			  right('0000000'+isnull(convert(varchar,CodigoEpisodioClinico),'No Def'),6) as Descripcion004,
			  Documento_Paciente,
			  Documento_Medico,
			  Formato_Codigo,
			  Formato_Id,
			  Formato_Tipo,
			  Formato_Uso,
			  Formato_Descripcion
			  ,	
			  @CONTADOR as contador_filas	
			from V_EpisodioAtenciones as V_EpisodioAtenciones_MAIN
			
		WHERE 
				(@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones_MAIN.Persona = @Persona)
				and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones_MAIN.IdPaciente = @IdPaciente)
				and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(V_EpisodioAtenciones_MAIN.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
				and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
				and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones_MAIN.IdOrdenAtencion = @IdOrdenAtencion)
				and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Formato_Codigo = @COD_FORMATO_AUX)					
				and (@UsuarioModificacion  is null OR V_EpisodioAtenciones_MAIN.Formato_Codigo = @UsuarioModificacion)
				and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
				  			
		)AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       LISTADO.Persona BETWEEN @Inicio  AND @NumeroFilas 	
		
	END
   
	if(@ACCION = 'LISTARGLASGOWPAG')
	begin		
		 set @COD_FORMATO_AUX = @Codigo002		 
		 if(@Codigo002 is not null)
			begin
				select @COD_FORMATO_AUX = SS_HC_Formato.CodigoFormato from SG_Opcion
				left join SS_HC_Formato on (SS_HC_Formato.IdFormato = SG_Opcion.IdFormato)
				where SG_Opcion.IdOpcion = convert(int ,@Codigo002)
			end			 
		--@CONTADOR = 
		SELECT @CONTADOR = COUNT(*)		FROM		V_EpisodioAtenciones AS V_EpisodioAtenciones_MAIN	
			WHERE 
				 (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Formato_Codigo = @COD_FORMATO_AUX)					
				and 
				(@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')

		SELECT LISTADO.* FROM
		(
			select 
		      convert(integer,ROW_NUMBER() OVER (ORDER BY V_EpisodioAtenciones_MAIN.FechaCreacion DESC ) )			  
			  AS Persona ,   
			  ApellidoPaterno,
			  ApellidoMaterno,
			  Nombres,
			  NombreCompleto,
			  UnidadReplicacion,
			  IdPaciente,
			  FechaCierre,
			  Episodio_Atencion,
			  FechaReg_EpisoAtencon,
			  FechaAtencion,
			  TipoAtencion,
			  IdOrdenAtencion,
			  LineaOrdenAtencion,
			  TipoOrdenAtencion,
			  Estado_EpisodioAten,
			  UsuarioCreacion,
			  FechaCreacion,
			  UsuarioModificacion,
			  FechaModificacion,
			  MotivoConsulta,
			  FechaRegistro,
			  Accion,
			  EpisodioClinico,
			  IdEpisodioAtencion,
			  UnidadReplicacionEC,
			  IdEstablecimientoSalud,
			  IdUnidadServicio,
			  IdPersonalSalud,
			  PersonalSaludNombre,
			  IdEspecialidad,
			  especialidadNombre,
			  CodigoEpisodioClinico,	
			  '['+right('0000000'+isnull(convert(varchar,CodigoEpisodioClinico),'No Def'),6)+']'+ + '.'+
			  right('0000000'+isnull(convert(varchar,IdEpisodioAtencion),'No Def'),6) as IdEpisodioAtencionCodigo,
			  CodigoOA,
			  TipoTrabajador,
			  TipoTrabajador_Desc,
			  Id001,
			  Id002,
			  Codigo001,
			  Codigo002,
			  Codigo003,
			  Codigo004,
			  Descripcion001,
			  Descripcion002,
			  Descripcion003,
			  right('0000000'+isnull(convert(varchar,CodigoEpisodioClinico),'No Def'),6) as Descripcion004,
			  Documento_Paciente,
			  Documento_Medico,
			  Formato_Codigo,
			  Formato_Id,
			  Formato_Tipo,
			  Formato_Uso,
			  Formato_Descripcion
			  ,	
			 @CONTADOR as contador_filas	
			from V_EpisodioAtenciones as V_EpisodioAtenciones_MAIN			
		WHERE 
				(@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Formato_Codigo = @COD_FORMATO_AUX)					
				and 
				(@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
				  			
		)AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       LISTADO.Persona BETWEEN @Inicio  AND @NumeroFilas 			
	END

	if(@ACCION = 'LISTARFARMACO')
	begin		
		 set @COD_FORMATO_AUX = @Codigo002		 
		 if(@Codigo002 is not null)
			begin
				select @COD_FORMATO_AUX = SS_HC_Formato.CodigoFormato from SG_Opcion
				left join SS_HC_Formato on (SS_HC_Formato.IdFormato = SG_Opcion.IdFormato)
				where SG_Opcion.IdOpcion = convert(int ,@Codigo002)
			end			 
		--@CONTADOR = 
		SELECT @CONTADOR = COUNT(*)		FROM	V_EpisodioAtenciones AS V_EpisodioAtenciones_MAIN
			WHERE 
				(@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones_MAIN.Persona = @Persona)
				and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones_MAIN.IdPaciente = @IdPaciente)
				and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(V_EpisodioAtenciones_MAIN.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
				and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
				and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones_MAIN.IdOrdenAtencion = @IdOrdenAtencion)
				and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Formato_Codigo = @COD_FORMATO_AUX)					
				and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
							

	
		SELECT LISTADO.* FROM
		(
			select 
		      convert(integer,ROW_NUMBER() OVER (ORDER BY V_EpisodioAtenciones_MAIN.Persona ASC ) )			  
			  AS Persona ,   
			  ApellidoPaterno,
			  ApellidoMaterno,
			  Nombres,
			  NombreCompleto,
			  UnidadReplicacion,
			  IdPaciente,
			  FechaCierre,
			  Episodio_Atencion,
			  FechaReg_EpisoAtencon,
			  FechaAtencion,
			  TipoAtencion,
			  IdOrdenAtencion,
			  LineaOrdenAtencion,
			  TipoOrdenAtencion,
			  Estado_EpisodioAten,
			  UsuarioCreacion,
			  FechaCreacion,
			  UsuarioModificacion,
			  FechaModificacion,
			  MotivoConsulta,
			  FechaRegistro,
			  Accion,
			  EpisodioClinico,
			  IdEpisodioAtencion,
			  UnidadReplicacionEC,
			  IdEstablecimientoSalud,
			  IdUnidadServicio,
			  IdPersonalSalud,
			  PersonalSaludNombre,
			  IdEspecialidad,
			  especialidadNombre,
			  CodigoEpisodioClinico,	
			  '['+right('0000000'+isnull(convert(varchar,CodigoEpisodioClinico),'No Def'),6)+']'+ + '.'+
			  right('0000000'+isnull(convert(varchar,IdEpisodioAtencion),'No Def'),6) as IdEpisodioAtencionCodigo,
			  CodigoOA,
			  TipoTrabajador,
			  TipoTrabajador_Desc,
			  Id001,
			  Id002,
			  Codigo001,
			  Codigo002,
			  Codigo003,
			  Codigo004,
			  Descripcion001,
			  Descripcion002,
			  Descripcion003,
			  right('0000000'+isnull(convert(varchar,CodigoEpisodioClinico),'No Def'),6) as Descripcion004,
			  Documento_Paciente,
			  Documento_Medico,
			  Formato_Codigo,
			  Formato_Id,
			  Formato_Tipo,
			  Formato_Uso,
			  Formato_Descripcion
			  ,
			 @CONTADOR as contador_filas	
			from V_EpisodioAtenciones as V_EpisodioAtenciones_MAIN
			
			WHERE 
				(@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones_MAIN.Persona = @Persona)
				and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones_MAIN.IdPaciente = @IdPaciente)
				and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(V_EpisodioAtenciones_MAIN.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
				and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
				and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones_MAIN.IdOrdenAtencion = @IdOrdenAtencion)
				and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Formato_Codigo = @COD_FORMATO_AUX)					
				and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
				  			
		)AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       LISTADO.Persona BETWEEN @Inicio  AND @NumeroFilas 
						  
					order by IdEpisodioAtencion desc, FechaCreacion desc 		
		
	END

	ELSE
	if(@ACCION = 'LISTAR_GRUPO')
	begin	
	
		 set @COD_FORMATO_AUX = @Codigo002
		 
		 if(@Codigo002 is not null)
			begin
				select @COD_FORMATO_AUX = SS_HC_Formato.CodigoFormato from SG_Opcion
				left join SS_HC_Formato on (SS_HC_Formato.IdFormato = SG_Opcion.IdFormato)
				where SG_Opcion.IdOpcion = convert(int ,@Codigo002)
			end			 
		--@CONTADOR = 
		SELECT @CONTADOR = COUNT(Accion) FROM
		(
			SELECT V_EpisodioAtenciones_MAIN.Accion FROM		V_EpisodioAtenciones AS V_EpisodioAtenciones_MAIN	
			WHERE 
				(@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones_MAIN.Persona = @Persona)
				and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones_MAIN.IdPaciente = @IdPaciente)
				and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(V_EpisodioAtenciones_MAIN.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
				and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
				and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones_MAIN.IdOrdenAtencion = @IdOrdenAtencion)
				and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Accion = @COD_FORMATO_AUX)					
				and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')				
						
			group by		
			  UnidadReplicacion,
			  IdPaciente,			
			  Accion,
			  EpisodioClinico,
			  IdEpisodioAtencion
		)	LISTA 

	
		SELECT LISTADO.* FROM
		(
			select 
		      convert(integer,ROW_NUMBER() OVER (ORDER BY V_EpisodioAtenciones_MAIN.Persona ASC ) )
			  
			  AS Persona ,   
			  ApellidoPaterno,
			  ApellidoMaterno,
			  Nombres,
			  NombreCompleto,
			  UnidadReplicacion,
			  IdPaciente,
			  FechaCierre,
			  Episodio_Atencion,
			  FechaReg_EpisoAtencon,
			  FechaAtencion,
			  TipoAtencion,
			  IdOrdenAtencion,
			  LineaOrdenAtencion,
			  TipoOrdenAtencion,
			  Estado_EpisodioAten,
			  UsuarioCreacion,
			  MAX(FechaCreacion) as FechaCreacion,
			  UsuarioModificacion,
			  FechaModificacion,
			  '' as MotivoConsulta,
			  FechaRegistro,
			  Accion,
			  EpisodioClinico,
			  IdEpisodioAtencion,
			  UnidadReplicacionEC,
			  IdEstablecimientoSalud,
			  IdUnidadServicio,
			  IdPersonalSalud,
			  PersonalSaludNombre,
			  IdEspecialidad,
			  especialidadNombre,
			  CodigoEpisodioClinico,
			  IdEpisodioAtencionCodigo,
			  CodigoOA,
			  TipoTrabajador,
			  TipoTrabajador_Desc,
			  0 as Id001,
			  0 as Id002,
			  '00' Codigo001,
			  '00' as Codigo002,
			  '00' as Codigo003,
			  '00' as Codigo004,
			  '00' as Descripcion001,
			  '00' as Descripcion002,
			  '00' as Descripcion003,
			  '00' as Descripcion004,
			  Documento_Paciente,
			  Documento_Medico,
			  Formato_Codigo,
			  Formato_Id,
			  Formato_Tipo,
			  Formato_Uso,
			  Formato_Descripcion,
			  @CONTADOR as contador_filas	
			from V_EpisodioAtenciones as V_EpisodioAtenciones_MAIN
			--where V_EpisodioAtenciones_MAIN.IdPaciente=1076942
			
			WHERE 
				(@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones_MAIN.Persona = @Persona)
				and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones_MAIN.IdPaciente = @IdPaciente)
				and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(V_EpisodioAtenciones_MAIN.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
				and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
				and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones_MAIN.IdOrdenAtencion = @IdOrdenAtencion)
				and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Accion = @COD_FORMATO_AUX)					
				and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
		
			
			group by
				Persona,
			  ApellidoPaterno,
			  ApellidoMaterno,
			  Nombres,
			  NombreCompleto,
			  UnidadReplicacion,
			  IdPaciente,
			  FechaCierre,
			  Episodio_Atencion,
			  FechaReg_EpisoAtencon,
			  FechaAtencion,
			  TipoAtencion,
			  IdOrdenAtencion,
			  LineaOrdenAtencion,
			  TipoOrdenAtencion,
			  Estado_EpisodioAten,
			  UsuarioCreacion,
			  --FechaCreacion,
			  UsuarioModificacion,
			  FechaModificacion,
			  --MotivoConsulta,
			  FechaRegistro,
			  Accion,
			  EpisodioClinico,
			  IdEpisodioAtencion,
			  UnidadReplicacionEC,
			  IdEstablecimientoSalud,
			  IdUnidadServicio,
			  IdPersonalSalud,
			  PersonalSaludNombre,
			  IdEspecialidad,
			  especialidadNombre,
			  CodigoEpisodioClinico,
			  IdEpisodioAtencionCodigo,
			  CodigoOA,
			  TipoTrabajador,
			  TipoTrabajador_Desc,			
				-----
			  Documento_Paciente,
			  Documento_Medico,
			  Formato_Codigo,
			  Formato_Id,
			  Formato_Tipo,
			  Formato_Uso,
			  Formato_Descripcion,			 
			  contador_filas	
			  
			  
		)AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       LISTADO.Persona BETWEEN @Inicio  AND @NumeroFilas 
					order by  LISTADO.FechaRegistro desc 		
				
	end

	ELSE
	if(@ACCION = 'LISTAR_COMP')
	begin	
	
		 set @COD_FORMATO_AUX = @Codigo002
		 
		 if(@Codigo002 is not null)
			begin
				select @COD_FORMATO_AUX = SS_HC_Formato.CodigoFormato from SG_Opcion
				left join SS_HC_Formato on (SS_HC_Formato.IdFormato = SG_Opcion.IdFormato)
				where SG_Opcion.IdOpcion = convert(int ,@Codigo002)
			end			 
		--@CONTADOR = 
		SELECT @CONTADOR = COUNT(Accion) FROM
		(
			SELECT V_EpisodioAtenciones_MAIN.Accion FROM			V_EpisodioAtenciones AS V_EpisodioAtenciones_MAIN
			WHERE 				
				 (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones_MAIN.IdPaciente = @IdPaciente)			
				and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Codigo003 = @COD_FORMATO_AUX)					
				and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
						
			group by		
			  UnidadReplicacion,
			  IdPaciente,			
			  Accion,
			  EpisodioClinico,
			  IdEpisodioAtencion
		)	LISTA 

	
		SELECT LISTADO.* FROM
		(
			select 
		      convert(integer,ROW_NUMBER() OVER (ORDER BY V_EpisodioAtenciones_MAIN.Persona ASC ) )
			  
			  AS Persona ,   
			  ApellidoPaterno,
			  ApellidoMaterno,
			  Nombres,
			  NombreCompleto,
			  UnidadReplicacion,
			  IdPaciente,
			  FechaCierre,
			  Episodio_Atencion,
			  FechaReg_EpisoAtencon,
			  FechaAtencion,
			  TipoAtencion,
			  IdOrdenAtencion,
			  LineaOrdenAtencion,
			  TipoOrdenAtencion,
			  Estado_EpisodioAten,
			  UsuarioCreacion,
			  MAX(FechaCreacion) as FechaCreacion,
			  UsuarioModificacion,
			  FechaModificacion,
			  '' as MotivoConsulta,
			  FechaRegistro,
			  Accion,
			  EpisodioClinico,
			  IdEpisodioAtencion,
			  UnidadReplicacionEC,
			  IdEstablecimientoSalud,
			  IdUnidadServicio,
			  IdPersonalSalud,
			  PersonalSaludNombre,
			  IdEspecialidad,
			  especialidadNombre,
			  CodigoEpisodioClinico,
			  IdEpisodioAtencionCodigo,
			  CodigoOA,
			  TipoTrabajador,
			  TipoTrabajador_Desc,
			  0 as Id001,
			  0 as Id002,
			  '00' Codigo001,
			  '00' as Codigo002,
			  '00' as Codigo003,
			   Codigo004,
			   Descripcion001,
			  Descripcion002,
			  Descripcion003,
			  Descripcion004,
			  Documento_Paciente,
			  Documento_Medico,
			  Formato_Codigo,
			  Formato_Id,
			  Formato_Tipo,
			  Formato_Uso,
			  Formato_Descripcion			 
			from V_EpisodioAtenciones as V_EpisodioAtenciones_MAIN
			WHERE 			
				(@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones_MAIN.IdPaciente = @IdPaciente)			
				and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Formato_Codigo = @COD_FORMATO_AUX)					
				and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')				
			
		
			
			group by
				Persona,
			  ApellidoPaterno,
			  ApellidoMaterno,
			  Nombres,
			  NombreCompleto,
			  UnidadReplicacion,
			  IdPaciente,
			  FechaCierre,
			  Episodio_Atencion,
			  FechaReg_EpisoAtencon,
			  FechaAtencion,
			  TipoAtencion,
			  IdOrdenAtencion,
			  LineaOrdenAtencion,
			  TipoOrdenAtencion,
			  Estado_EpisodioAten,
			  UsuarioCreacion,
			  --FechaCreacion,
			  UsuarioModificacion,
			  FechaModificacion,
			  --MotivoConsulta,
			  FechaRegistro,
			  Accion,
			  EpisodioClinico,
			  IdEpisodioAtencion,
			  UnidadReplicacionEC,
			  IdEstablecimientoSalud,
			  IdUnidadServicio,
			  IdPersonalSalud,
			  PersonalSaludNombre,
			  IdEspecialidad,
			  especialidadNombre,
			  CodigoEpisodioClinico,
			  IdEpisodioAtencionCodigo,
			  CodigoOA,
			  TipoTrabajador,
			  TipoTrabajador_Desc,			
				-----
			  Documento_Paciente,
			  Documento_Medico,
			  Formato_Codigo,
			  Formato_Id,
			  Formato_Tipo,
			  Formato_Uso,
			  Formato_Descripcion,
			  Descripcion003,
			  Descripcion004,
			  Codigo004,
			  Descripcion001,
			  Descripcion002,
			  contador_filas				  			
		)AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       LISTADO.Persona BETWEEN @Inicio  AND @NumeroFilas 
					order by IdPersonalSalud, FechaCreacion desc   		
				
	end	
	else
	if(@ACCION = 'LISTAR_DIN')
	begin	
	
		 set @COD_FORMATO_AUX = @Codigo002
		 
		 if(@Codigo002 is not null)
			begin
				select @COD_FORMATO_AUX = SS_HC_Formato.CodigoFormato from SG_Opcion
				left join SS_HC_Formato on (SS_HC_Formato.IdFormato = SG_Opcion.IdFormato)
				where SG_Opcion.IdOpcion = convert(int ,@Codigo002)
			end			 
		--@CONTADOR = 
		SELECT @CONTADOR = COUNT(Accion) FROM
		(
			SELECT V_EpisodioAtenciones_MAIN.Accion FROM	V_EpisodioAtenciones AS V_EpisodioAtenciones_MAIN
	
			WHERE 
				(@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones_MAIN.Persona = @Persona)
				and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones_MAIN.IdPaciente = @IdPaciente)
				and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(V_EpisodioAtenciones_MAIN.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
				and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
				and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones_MAIN.IdOrdenAtencion = @IdOrdenAtencion)
				and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Accion = @COD_FORMATO_AUX)					
				and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
				and (@IdOpcion is null or V_EpisodioAtenciones_MAIN.Id002 = @Id001)
						
			group by		
			  UnidadReplicacion,
			  IdPaciente,			
			  Accion,
			  EpisodioClinico,
			  IdEpisodioAtencion/*,Id001*/
		)	LISTA 

	
		SELECT LISTADO.* FROM
		(
			select 
		      convert(integer,ROW_NUMBER() OVER (ORDER BY V_EpisodioAtenciones_MAIN.Persona ASC ) )
			  
			  AS Persona ,   
			  ApellidoPaterno,
			  ApellidoMaterno,
			  Nombres,
			  NombreCompleto,
			  UnidadReplicacion,
			  IdPaciente,
			  FechaCierre,
			  Episodio_Atencion,
			  FechaReg_EpisoAtencon,
			  FechaAtencion,
			  TipoAtencion,
			  IdOrdenAtencion,
			  LineaOrdenAtencion,
			  TipoOrdenAtencion,
			  Estado_EpisodioAten,
			  UsuarioCreacion,
			  MAX(FechaCreacion) as FechaCreacion,
			  UsuarioModificacion,
			  FechaModificacion,
			  '' as MotivoConsulta,
			  FechaRegistro,
			  Accion,
			  EpisodioClinico,
			  IdEpisodioAtencion,
			  UnidadReplicacionEC,
			  IdEstablecimientoSalud,
			  IdUnidadServicio,
			  IdPersonalSalud,
			  PersonalSaludNombre,
			  IdEspecialidad,
			  especialidadNombre,
			  CodigoEpisodioClinico,
			  IdEpisodioAtencionCodigo,
			  CodigoOA,
			  TipoTrabajador,
			  TipoTrabajador_Desc,
			  Id001,
			  Id002,
			  Codigo001,
			  '00' as Codigo002,
			  '00' as Codigo003,
			  '00' as Codigo004,
			  '00' as Descripcion001,
			  '00' as Descripcion002,
			  '00' as Descripcion003,
			  '00' as Descripcion004,
			  Documento_Paciente,
			  Documento_Medico,
			  Formato_Codigo,
			  Formato_Id,
			  Formato_Tipo,
			  Formato_Uso,
			  Formato_Descripcion,
			  @CONTADOR as contador_filas	
			from V_EpisodioAtenciones as V_EpisodioAtenciones_MAIN
			--where V_EpisodioAtenciones_MAIN.IdPaciente=1076942
			
			WHERE 
				(@Persona is null or (@Persona =0 ) OR V_EpisodioAtenciones_MAIN.Persona = @Persona)
				and (@IdPaciente is null  or (@IdPaciente =0 ) OR V_EpisodioAtenciones_MAIN.IdPaciente = @IdPaciente)
				and (@NombreCompleto is null  OR @NombreCompleto =''  OR  upper(V_EpisodioAtenciones_MAIN.NombreCompleto) like '%'+upper(@NombreCompleto)+'%')							
				and (@Estado_EpisodioAten is null OR Estado_EpisodioAten = @Estado_EpisodioAten)
				and (@IdOrdenAtencion  is null OR V_EpisodioAtenciones_MAIN.IdOrdenAtencion = @IdOrdenAtencion)
				and (@COD_FORMATO_AUX  is null OR V_EpisodioAtenciones_MAIN.Accion = @COD_FORMATO_AUX)					
				and (@CODIGOOA is null  OR @CODIGOOA =''  OR  upper(V_EpisodioAtenciones_MAIN.CodigoOA) like '%'+upper(@CODIGOOA)+'%')
		and (@IdOpcion is null or V_EpisodioAtenciones_MAIN.Id002 = @Id001)
			
			group by
				Persona,
			  ApellidoPaterno,
			  ApellidoMaterno,
			  Nombres,
			  NombreCompleto,
			  UnidadReplicacion,
			  IdPaciente,
			  FechaCierre,
			  Episodio_Atencion,
			  FechaReg_EpisoAtencon,
			  FechaAtencion,
			  TipoAtencion,
			  IdOrdenAtencion,
			  LineaOrdenAtencion,
			  TipoOrdenAtencion,
			  Estado_EpisodioAten,
			  UsuarioCreacion,
			  --FechaCreacion,
			  UsuarioModificacion,
			  FechaModificacion,
			  --MotivoConsulta,
			  FechaRegistro,
			  Accion,
			  EpisodioClinico,
			  IdEpisodioAtencion,
			  UnidadReplicacionEC,
			  IdEstablecimientoSalud,
			  IdUnidadServicio,
			  IdPersonalSalud,
			  PersonalSaludNombre,
			  IdEspecialidad,
			  especialidadNombre,
			  CodigoEpisodioClinico,
			  IdEpisodioAtencionCodigo,
			  CodigoOA,
			  Id001,
			  Id002,
			  Codigo001,
			  TipoTrabajador,
			  TipoTrabajador_Desc,			
				-----
			  Documento_Paciente,
			  Documento_Medico,
			  Formato_Codigo,
			  Formato_Id,
			  Formato_Tipo,
			  Formato_Uso,
			  Formato_Descripcion,			 
			  contador_filas				  			
		)AS LISTADO
					WHERE (@Inicio  Is null AND @NumeroFilas Is null) OR  
					       LISTADO.Persona BETWEEN @Inicio  AND @NumeroFilas 
					order by IdPersonalSalud, FechaCreacion desc   		
				
	end
	--------------------------------------------------------------------------------------------------
  
END



