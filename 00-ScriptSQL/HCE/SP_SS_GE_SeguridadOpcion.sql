
GO
/****** Object:  StoredProcedure [dbo].[SP_SS_GE_SeguridadOpcion]    Script Date: 18/04/2025 12:37:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE  [dbo].[SP_SS_GE_SeguridadOpcion]
    @Sistema      Varchar(4),
	@Nombre      Varchar(30),
	@Modulo      Varchar(2),
	@Orden      int,
	@NombreModulo      Varchar(50),
	@IdOpcion      int,
	@IdOpcionPadre     int,
	@CodigoOpcion      Varchar(15),
	@CadenaRecursividad      Varchar(15),--AUX UNID REPLICACION
	@NivelOpcion     int,
	@NombreOpcion      Varchar(80),
	@Descripcion      Varchar(80),
	@SubModulo      Varchar(2),
	@OrdenOpcion      int,
	@TipoOpcion      Varchar(1),
	@TipoIcono      int,
	@IndicadorPrioridad      int,	--AUX EPI CLINICO
	@IndicadorObjeto     int, 
	@IdObjetoAsociado     int,	--AUX ID UNIDAD DE SERVICIO
	@TipoDato      Varchar(2),
	@Compania      Varchar(15),
	@IndicadorCompania     int,
	@idTipoAtencion     int,
	@TipoTrabajador      Varchar(2),
	@IndicadorFormato     int,
	@IndicadorAsignacion   int,
	@TipoProceso    int,
	@Accion      Varchar(50),
	@Version      Varchar(50),  --AUX EPI ATENCIION
	@Estado      int,
	@IdAgente     int,
	@IdGrupo     int, --AUX ID ESPECIALIDAD
	@IdOrganizacion     int,--AUX ID ESTABLECIMIENTO
	@TipoAgente      int,
	@CodigoAgente    Varchar(20),
	@IdEmpleado     int,	--AUX IDPACIENTE
	@IndicadorMultiple    int,
	@Clave      Varchar(20),
	@NombreAgente      Varchar(60),
	@EstadoAgente       int,
	@Plataforma      Varchar(50),
 	@EstadoAgenteOpcion      int,
	@IdFormato      int,
	@IdFormatoPadre     int,
	@CodigoFormato      Varchar(50),
 
	@Nivel       int,
 	@TipoFormato      int,
	@VersionFormatoFijo      Varchar(50),
	@IdFormatoDinamico     int,
	@EstadoFormato       int
   
AS    
BEGIN    


	 DECLARE @TABLA_OPCIONESAGENTE_VALIDAS table       
	 (      
	  SECUENCIA   int  NOT NULL   IDENTITY PRIMARY KEY,      
	  idAgente int  null ,
	  TipoAgente int null,
	  idOpcion int null,
	  ESTADOAGENTE  int null,
	  INDICADOR varchar(30) null,
	  orden	int ,
	  NivelOpcion	int null,
	  TipoOpcion	varchar(1) null
	 )   
 	declare @cuenta int =1
	declare @ContadorOrden int =0
	declare @IdAgenteMax int =0
	declare @IdOpcionAux int =0
	declare @FechaAgenteMax datetime =null				
	declare @Total int =0
	
	declare @IndicadorVAL_AUX varchar(30)=null
	declare @IndicaTabla_AUX varchar(100)=null
	declare @IndicaTipo_AUX varchar(100)=null
	declare @CampoCodigoID_AUX int=0
	declare @ValorCODIGO_AUX varchar(30)=null
	declare @INDICA_AUX int=0
	
	declare @FormatoID_AUX int =0
	declare @FormatoDinamicoID_AUX int =0
	declare @FormatoCodigo_AUX varchar(30)=null
	
	if(@ACCION = 'LISTAPROCESOS' OR @ACCION = 'LISTAROPCIONESCAGENTE' OR @ACCION ='LISTAROPCIONESCAGENTEOBLIGATORIO' OR @ACCION = 'LISTAPROCESOGENERAL' or @ACCION = 'LISTAPROCESOSBITACORA')
		begin
		
			/*****************************************************************/
			/**CARGAR TABLA TEMPORAL CON LAS OPCIONES Y LOS PERFILES VALIDOS**/
			/*****************************************************************/
			---CARGAR AGENTES USUARIOS
			insert into @TABLA_OPCIONESAGENTE_VALIDAS					
			(idAgente,TipoAgente,idOpcion,ESTADOAGENTE,INDICADOR,orden,NivelOpcion,TipoOpcion)
				select IdAgente,TipoAgente,IdOpcion,EstadoAgente,'VALIDO',0 ,NivelOpcion,TipoOpcion
				from
				(
					select  
					seg.IdAgente,
					seg.TipoAgente,
					seg.NombreAgente,IdOpcion,seg.EstadoAgente,
					seg.NivelOpcion,seg.TipoOpcion
					from SS_CHE_VistaSeguridad as seg						 						 
					where			
						seg.IdAgente in(
							select IdPerfil from SG_PerfilUsuario where IdUsuario =@IdAgente
								and Estado=2
								union select @IdAgente
						)		
						and seg.TipoAgente= 2 --PRIMERO SOLAMENTE USUARIOS						
				)AS SEG_AUX				
				order by SEG_AUX.IdOpcion
			---CARGAR AGENTES PERFILES
			insert into @TABLA_OPCIONESAGENTE_VALIDAS					
			(idAgente,TipoAgente,idOpcion,ESTADOAGENTE,INDICADOR,orden,NivelOpcion,TipoOpcion)
				select IdAgente,TipoAgente,IdOpcion,EstadoAgente,'NO VALIDO',
				ROW_NUMBER() OVER (ORDER BY IdOpcion ASC ) AS RowNumber ,
				NivelOpcion,TipoOpcion
				from
				(
					select  
					seg.IdAgente,
					seg.TipoAgente,
					seg.NombreAgente,IdOpcion,seg.EstadoAgente,
					seg.NivelOpcion,seg.TipoOpcion
					--ROW_NUMBER() OVER (ORDER BY IdOpcion ASC ) AS RowNumber   			
					from SS_CHE_VistaSeguridad as seg						 						 
					where					
						seg.IdAgente in(
							select IdPerfil from SG_PerfilUsuario where IdUsuario =@IdAgente
								and Estado=2
								union select @IdAgente
						)		
						and seg.TipoAgente= 1 --SEGUNDO PERFILES
					
				)AS SEG_AUX
				where 
				SEG_AUX.IdOpcion Not in(select idOpcion from @TABLA_OPCIONESAGENTE_VALIDAS)
				order by SEG_AUX.IdOpcion, SEG_AUX.IdAgente	
												
				---ACTUALIZAMOS IDENTIFICANDO LOS VÁLIDOS Y LOS NO VÁLIDOS (criterio por definir mejor)				
				---CRITERIO: Tienen mayor prioridad los USUARIOS sobre los PERFILES
				---en el caso hubieran más de un PERFIL, se escoge el de mayor IDAgente

				select @Total= COUNT(*) from @TABLA_OPCIONESAGENTE_VALIDAS
					
				set @cuenta  =1			
				while(@cuenta <= @Total)
				begin										 
					select @IdAgenteMax	   = MAX(idagente) 
									from @TABLA_OPCIONESAGENTE_VALIDAS as AUX
									where AUX.idOpcion =
									 (select idOpcion from @TABLA_OPCIONESAGENTE_VALIDAS
										where SECUENCIA = @cuenta
									 )									 															
					
					update @TABLA_OPCIONESAGENTE_VALIDAS 
					set INDICADOR = 'VALIDO'					
					where idAgente = @IdAgenteMax					
					and idOpcion =
						(select idOpcion from @TABLA_OPCIONESAGENTE_VALIDAS
							where SECUENCIA = @cuenta
						)
					
					set @cuenta= @cuenta+1
					-------------
				end					
				
				/***********************************************************************/	
	end
 
	if(@ACCION = 'LISTAPROCESOS')
		BEGIN
			/*************************************************/
			/******CONFIGURACION DE ASIGNACIONES OPCION*****/
			/*************************************************/
			
				select @Total= COUNT(*) from @TABLA_OPCIONESAGENTE_VALIDAS
				set @cuenta  =1						
				
				while(@cuenta <= @Total)
				begin														 
					select @IndicadorVAL_AUX  = INDICADOR,
							@IdOpcionAux= idOpcion
						from @TABLA_OPCIONESAGENTE_VALIDAS as AUX
						where AUX.SECUENCIA = @cuenta
									 									 															
					if(@IndicadorVAL_AUX = 'VALIDO')
					begin
						select @INDICA_AUX =IndicadorAsignacion from SG_Opcion	
						where IdOpcion = @IdOpcionAux
						if(@INDICA_AUX = 2)
						begin						
							/***VALIDACIONES ASIGNADAS:**/
							--------------------------------
							--(1) ESPECIALIDAD
							--------------------------------
							set @CampoCodigoID_AUX = 4 -- 4: INDICA TABLA ESPECIALIDAD
							select @INDICA_AUX = count(*)
							from SS_HC_FormatoCodigoId
							where CampoCodigoId = @CampoCodigoID_AUX  --TABLA ESPECIALIDAD
							and IdOpcion=@IdOpcionAux
							if(@INDICA_AUX > 0) --POSEE ASIGNACIONES
							begin
								select @INDICA_AUX = count(*)
								from SS_HC_FormatoCodigoId
								where CampoCodigoId = @CampoCodigoID_AUX -- TABLA ESPECIALIDAD
								and IdOpcion=@IdOpcionAux	
								and IndicadorCodigoId=1	--1:INDICA TODOS
								
								if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES GENERALES (debe poseer específicas)
								begin
									select @INDICA_AUX = count(*)
									from SS_HC_FormatoCodigoId
									where CampoCodigoId = @CampoCodigoID_AUX -- TABLA ESPECIALIDAD
									and IdOpcion=@IdOpcionAux	
									and IndicadorCodigoId=2	--1:INDICA ESPECIFICOS
									and ValorId= @IdGrupo  --1:ID DE ESPECIALIDAD ESPECÍFICO
									
									if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES PARA TAL VALOR (NO VALIDO)
									begin
										update @TABLA_OPCIONESAGENTE_VALIDAS 
										set INDICADOR = 'NO VALIDO'					
										where SECUENCIA = @cuenta																	
									end
								end							
							end
							
							--------------------------------
							--(2) COMPANIA
							--------------------------------
							set @CampoCodigoID_AUX = 1 -- 1: INDICA TABLA COMPANIA
							select @INDICA_AUX = count(*)
							from SS_HC_FormatoCodigoId
							where CampoCodigoId = @CampoCodigoID_AUX  --TABLA COMPANIA
							and IdOpcion=@IdOpcionAux
							if(@INDICA_AUX > 0) --POSEE ASIGNACIONES
							begin
								select @INDICA_AUX = count(*)
								from SS_HC_FormatoCodigoId
								where CampoCodigoId = @CampoCodigoID_AUX -- TABLA COMPANIA
								and IdOpcion=@IdOpcionAux	
								and IndicadorCodigoId=1	--1:INDICA TODOS
								
								if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES GENERALES (debe poseer específicas)
								begin
									select @INDICA_AUX = count(*)
									from SS_HC_FormatoCodigoId
									where CampoCodigoId = @CampoCodigoID_AUX -- TABLA COMPANIA
									and IdOpcion=@IdOpcionAux	
									and IndicadorCodigoId=2	--1:INDICA ESPECIFICOS
									and ValorTexto= @Compania  --1:COD DE COMPANIA ESPECÍFICO
									
									if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES PARA TAL VALOR (NO VALIDO)
									begin
										update @TABLA_OPCIONESAGENTE_VALIDAS 
										set INDICADOR = 'NO VALIDO'					
										where SECUENCIA = @cuenta																	
									end
								end							
							end						
							--------------------------------
							--(3) ESTABLECIMIENTO
							--------------------------------
							set @CampoCodigoID_AUX = 2 -- 1: INDICA TABLA ESTABLECIMIENTO
							select @INDICA_AUX = count(*)
							from SS_HC_FormatoCodigoId
							where CampoCodigoId = @CampoCodigoID_AUX  --TABLA ESTABLECIMIENTO
							and IdOpcion=@IdOpcionAux
							if(@INDICA_AUX > 0) --POSEE ASIGNACIONES
							begin
								select @INDICA_AUX = count(*)
								from SS_HC_FormatoCodigoId
								where CampoCodigoId = @CampoCodigoID_AUX -- TABLA ESTABLECIMIENTO
								and IdOpcion=@IdOpcionAux	
								and IndicadorCodigoId=1	--1:INDICA TODOS
								
								if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES GENERALES (debe poseer específicas)
								begin
									select @INDICA_AUX = count(*)
									from SS_HC_FormatoCodigoId
									where CampoCodigoId = @CampoCodigoID_AUX -- TABLA ESTABLECIMIENTO
									and IdOpcion=@IdOpcionAux	
									and IndicadorCodigoId=2	--1:INDICA ESPECIFICOS
									and ValorId= @IdOrganizacion  --:ID DE ESTABLECIMIENTO ESPECÍFICO
									
									if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES PARA TAL VALOR (NO VALIDO)
									begin
										update @TABLA_OPCIONESAGENTE_VALIDAS 
										set INDICADOR = 'NO VALIDO'					
										where SECUENCIA = @cuenta																	
									end
								end							
							end									
							--------------------------------
							--(4) AGENTE
							--------------------------------	
							set @CampoCodigoID_AUX = 8 -- 1: INDICA TABLA AGENTE
							select @INDICA_AUX = count(*)
							from SS_HC_FormatoCodigoId
							where CampoCodigoId = @CampoCodigoID_AUX  --TABLA AGENTE
							and IdOpcion=@IdOpcionAux
							if(@INDICA_AUX > 0) --POSEE ASIGNACIONES
							begin
								select @INDICA_AUX = count(*)
								from SS_HC_FormatoCodigoId
								where CampoCodigoId = @CampoCodigoID_AUX -- TABLA AGENTE
								and IdOpcion=@IdOpcionAux	
								and IndicadorCodigoId=1	--1:INDICA TODOS
								
								if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES GENERALES (debe poseer específicas)
								begin
									select @INDICA_AUX = count(*)
									from SS_HC_FormatoCodigoId
									where CampoCodigoId = @CampoCodigoID_AUX -- TABLA 
									and IdOpcion=@IdOpcionAux	
									and IndicadorCodigoId=2	--1:INDICA ESPECIFICOS
									and ValorId= @IdAgente  --:ID DE AGENTE ESPECÍFICO
									
									if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES PARA TAL VALOR (NO VALIDO)
									begin
										update @TABLA_OPCIONESAGENTE_VALIDAS 
										set INDICADOR = 'NO VALIDO'					
										where SECUENCIA = @cuenta																	
									end
								end							
							end																																				
							--------------------------------
							--(5) UNIDAD DE SERVICIO
							--------------------------------	
							set @CampoCodigoID_AUX = 10 -- 1: INDICA TABLA UNID. SERVICIO
							select @INDICA_AUX = count(*)
							from SS_HC_FormatoCodigoId
							where CampoCodigoId = @CampoCodigoID_AUX  --TABLA 
							and IdOpcion=@IdOpcionAux
							if(@INDICA_AUX > 0) --POSEE ASIGNACIONES
							begin
								select @INDICA_AUX = count(*)
								from SS_HC_FormatoCodigoId
								where CampoCodigoId = @CampoCodigoID_AUX -- TABLA 
								and IdOpcion=@IdOpcionAux	
								and IndicadorCodigoId=1	--1:INDICA TODOS
								
								if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES GENERALES (debe poseer específicas)
								begin
								
									select @INDICA_AUX = count(*)
									from SS_HC_FormatoCodigoId
									where CampoCodigoId = @CampoCodigoID_AUX -- TABLA 
									and IdOpcion=@IdOpcionAux	
									and IndicadorCodigoId=2	--1:INDICA ESPECIFICOS
									and rtrim(ValorTexto)= 
										convert(varchar,@IdOrganizacion)   --:IDs  ESPECÍFICOs(Estable)
										+'|'+
										convert(varchar,@IdObjetoAsociado) --:IDs  ESPECÍFICOs (Unid. Serv)
																													
									if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES PARA TAL VALOR (NO VALIDO)
									begin
										update @TABLA_OPCIONESAGENTE_VALIDAS 
										set INDICADOR = 'NO VALIDO'					
										where SECUENCIA = @cuenta																	
									end
								end							
							end	
						end					
					
					end																		
					set @cuenta= @cuenta+1
					-------------
				end
				/*************************************************/
				/*************************************************/
		
			if (@Nivel=1)
				begin
					Select * from dbo.SS_CHE_VistaSeguridad as seguridad
					where 
					seguridad.TipoOpcion <> 'N'
					and		(seguridad.IdAgente in (
								select IdAgente from @TABLA_OPCIONESAGENTE_VALIDAS as AgtVal
								where AgtVal.IdOpcion = seguridad.IdOpcion
								and INDICADOR = 'VALIDO'
								and TipoOpcion <> 'N'
								and NivelOpcion = 1

							)
					)
					and		(seguridad.NivelOpcion = 1)					
					
				end
			else
				begin

				if (@IndicadorMultiple=999)
				begin
				select * from dbo.SS_CHE_VistaSeguridad as seguridad					
					where	
					 seguridad.TipoOpcion <> 'N'
					and		seguridad.IdAgente in (		
					select IdPerfil from SG_PerfilUsuario where IdUsuario =@IdAgente and Estado=2)						
						and		seguridad.IdOpcionPadre = @IdOpcionPadre and seguridad.EstadoAgente=2
					order by seguridad.OrdenOpcion
				end

				else
				begin
				select * from dbo.SS_CHE_VistaSeguridad as seguridad
					where	
					 seguridad.TipoOpcion <> 'N'				
					and		seguridad.IdAgente in (		
								select IdAgente from @TABLA_OPCIONESAGENTE_VALIDAS as AgtVal
								where AgtVal.IdOpcion = seguridad.IdOpcion
								and INDICADOR = 'VALIDO'
								and TipoOpcion <> 'N'																														
					)						
						and		seguridad.IdOpcionPadre = @IdOpcionPadre and seguridad.EstadoAgente=2
					order by seguridad.OrdenOpcion
				end				
				end
			
		 END
	if(@ACCION = 'DATOSRECURSOS')
		BEGIN
			SELECT  'W4G' as Sistema, dbo.SS_HC_Tabla.NombreTabla  as Nombre, 'HC'  as Modulo, 0  as Orden, 
					SS_HC_FormatoRecursoCampo.NombreCampoRecurso  as NombreModulo, 
					dbo.SS_HC_Tabla.IdFavoritoTabla  as IdOpcion, 
					SS_HC_FormatoCampo.SecuenciaCampo  as IdOpcionPadre, 
					''  as   CodigoOpcion,
					''  as  CadenaRecursividad, 
					SS_HC_Tabla.TipoTabla  as NivelOpcion, 
					SS_HC_Tabla.Condicion  as NombreOpcion, 
					SS_HC_TablaCampo.NombreCampo  as Descripcion, 
					''  as  SubModulo, 0  as  
				  OrdenOpcion, ''  as TipoOpcion, 0  as TipoIcono, 0  as IndicadorPrioridad, 0  as IndicadorObjeto, 0  as IdObjetoAsociado, ''  as 
				  TipoDato,
				   SS_HC_TablaCampo.Descripcion  as ValorTexto, 0.0  as ValorNumerico, getdate()  as  ValorFecha, ''  as  UrlOpcion, ''  as  UsuarioCreacion, 
				   getdate()  as  FechaCreacion, ''  as  UsuarioModificacion, 
				  getdate()  as  FechaModificacion, ''  as  Compania, 0  as  IndicadorCompania, 0  as  idTipoAtencion, ''  as  
				  TipoTrabajador, 0  as  IndicadorFormato, 0  as  IndicadorAsignacion, 0  as  TipoProceso, ''  as  Accion, '' as  Version, 0  as  
				  Estado, 0  as  IdAgente, 0  as  IdGrupo, 0  as  IdOrganizacion, 0  as  TipoAgente, ''  as  CodigoAgente, 0  as  IdEmpleado, 0  as  
				  IndicadorMultiple, ''  as  Clave, getdate()  as  FechaInicio, getdate()  as  FechaFin, getdate()  as  FechaExpiracion, ''  as  NombreAgente, 0  as  ExpiraClave, 
				  dbo.SS_HC_Tabla.Descripcion   as DescripcionAgente, 0  as  EstadoAgente, 0  as  IdGrupoTransaccion, 0  as  TipoTransaccion, 0  as  IdOpcionDefecto,''  as  
				  Plataforma, getdate()  as  ValorFechaAgOpcion, 0.0  as  ValorNumericoAgOpcion, ''  as  ValorTextAgOpcion, 0  as  IndicadorAcceso, 0  as  
				  IndicadorHabilitado, 0  as  IndicadorObligatorio, 0  as  IndicadorVisible, 0  as  IndicarPrioridadAgOpcion, 0  as  
				  IndicadorNuevo, 0  as  IndicadorModificar, 0  as  IndicadorEliminar,0 as IndicadorImprimir, 0  as  IndicadorIngreso, 0  as  EstadoAgenteOpcion, 
				  dbo.SS_HC_Formato.IdFormato  as  IdFormato, 0  as IdFormatoPadre, SS_HC_Formato.CodigoFormato  as CodigoFormato, ''  as  CodigoFormatoPadre, '' as  CadenaRecursividadFormato, 
				  0  as  Nivel, ''  as  DescripcionFormato, '' as  DescripcionExtranjera, 0  as TipoFormato, ''  as  VersionFormatoFijo, 0  as 
				  IdFormatoDinamico, 0  as EstadoFormato 
	 		FROM        SS_HC_FormatoRecursoCampo 
			INNER JOIN SS_HC_Formato 		ON  SS_HC_FormatoRecursoCampo.IdFormato=SS_HC_Formato.IdFormato 
			INNER JOIN SS_HC_Tabla 		ON SS_HC_Tabla.IdFavoritoTabla = SS_HC_FormatoRecursoCampo.IdFavoritoTabla 
			INNER JOIN SS_HC_FormatoCampo  ON SS_HC_Formato.IdFormato = SS_HC_FormatoCampo.IdFormato AND    SS_HC_FormatoRecursoCampo.SecuenciaCampo = SS_HC_FormatoCampo.SecuenciaCampo  
			INNER JOIN SS_HC_TablaCampo 	ON    SS_HC_FormatoCampo.IdCampo = SS_HC_TablaCampo.IdCampo
			where	SS_HC_Tabla.TipoTabla = 1
			and		 SS_HC_FormatoRecursoCampo.Estado = 2
			and		 CodigoFormato = @CodigoFormato
			
		END		 
	if(@ACCION = 'DATOSFORMULARIO')
		BEGIN
			/**VERIFICAR ASIGNACION DE FORMATO ALTERNATIVO*/
					--------------------------------
					--(1) FORMATO
					--------------------------------
					set @CampoCodigoID_AUX = 9 -- 4: INDICA TABLA FORMATO
					select @INDICA_AUX = count(*)
					from SS_HC_FormatoCodigoId
					where CampoCodigoId = @CampoCodigoID_AUX  --TABLA FORMATO
					and IdOpcion=@IdOpcion
					
					if(@INDICA_AUX > 0) --POSEE ASIGNACIONES
							begin
								select @INDICA_AUX = count(*)
								from SS_HC_FormatoCodigoId
								where CampoCodigoId = @CampoCodigoID_AUX -- TABLA FORMATO
								and IdOpcion=@IdOpcion	
								and IndicadorCodigoId=1	--1:INDICA TODOS
								
								if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES GENERALES (debe poseer específicas)
								begin
								
									select top 1 @FormatoID_AUX= ValorId  --SOLO UNO
									from SS_HC_FormatoCodigoId
									where CampoCodigoId = @CampoCodigoID_AUX -- TABLA FORMATO
									and IdOpcion=@IdOpcion	
									and IndicadorCodigoId=2	--1:INDICA ESPECIFICOS
																		
									if(@FormatoID_AUX > 0) -- POSEE FORMATO ASIGNADO (OBTENER CODIGO E ID FORM DINAMICO)
									begin
										select @FormatoCodigo_AUX = CodigoFormato,
											@FormatoDinamicoID_AUX = IdFormatoDinamico
										 from SS_HC_Formato
										where IdFormato = @FormatoID_AUX								
									end
								end							
					end
			---------------------			
		
		  Select Sistema, Nombre, Modulo, Orden, NombreModulo, IdOpcion, IdOpcionPadre, 
			  CodigoOpcion, CadenaRecursividad, NivelOpcion, NombreOpcion, Descripcion, SubModulo, 
			  OrdenOpcion, TipoOpcion, TipoIcono, IndicadorPrioridad, IndicadorObjeto, IdObjetoAsociado, 
			  TipoDato, ValorTexto, ValorNumerico, ValorFecha, UrlOpcion, UsuarioCreacion, FechaCreacion, 
			  UsuarioModificacion, FechaModificacion, Compania, IndicadorCompania, idTipoAtencion, 
			  TipoTrabajador, IndicadorFormato, IndicadorAsignacion, TipoProceso, Accion, Version, 
			  Estado, IdAgente, IdGrupo, IdOrganizacion, TipoAgente, CodigoAgente, IdEmpleado, 
			  IndicadorMultiple, Clave, FechaInicio, FechaFin, FechaExpiracion, NombreAgente, ExpiraClave, 
			  DescripcionAgente, EstadoAgente, IdGrupoTransaccion, TipoTransaccion, IdOpcionDefecto, 
			  Plataforma, ValorFechaAgOpcion, ValorNumericoAgOpcion, ValorTextAgOpcion, IndicadorAcceso, 
			  IndicadorHabilitado, IndicadorObligatorio, IndicadorVisible, IndicarPrioridadAgOpcion, 
			  IndicadorNuevo, IndicadorModificar, IndicadorEliminar,IndicadorImprimir ,IndicadorIngreso, EstadoAgenteOpcion, 
			  (case when @FormatoID_AUX>0 then @FormatoID_AUX else IdFormato end) as IdFormato,     
			  IdFormatoPadre, 
			  (case when @FormatoID_AUX>0 then @FormatoCodigo_AUX else CodigoFormato end) as CodigoFormato,   
			  CodigoFormatoPadre, CadenaRecursividadFormato, 
			  Nivel, DescripcionFormato, DescripcionExtranjera, TipoFormato, VersionFormatoFijo, 
			  (case when @FormatoID_AUX>0 then @FormatoDinamicoID_AUX else IdFormatoDinamico end) as IdFormatoDinamico, 
			  EstadoFormato 
			  from dbo.SS_CHE_VistaSeguridad 
			where	
			IdAgente = -2  --OBS:  -2: ADMIN GENERAL
			and		IdOpcion = 	@IdOpcion							
			
		 END		
		 
	if(@ACCION = 'LISTAROPCIONESCAGENTE')
		BEGIN												

			if(@IdOpcionPadre is null and @IdOpcion is not null)
			begin			
				select @IdOpcionPadre = IdOpcionPadre from SG_Opcion where IdOpcion = @IdOpcion
			end			
			
			if (@NivelOpcion=1)
			begin
					select 
						seguridad.Sistema,seguridad.Nombre,seguridad.Modulo,seguridad.Orden,seguridad.NombreModulo,seguridad.IdOpcion,seguridad.IdOpcionPadre,seguridad.CodigoOpcion,seguridad.CadenaRecursividad
						  ,seguridad.NivelOpcion,seguridad.NombreOpcion,seguridad.Descripcion,seguridad.SubModulo,seguridad.OrdenOpcion,seguridad.TipoOpcion
						  ,seguridad.TipoIcono,seguridad.IndicadorPrioridad,seguridad.IndicadorObjeto,seguridad.IdObjetoAsociado,seguridad.TipoDato
						  ,seguridad.ValorTexto,seguridad.ValorNumerico,seguridad.ValorFecha,seguridad.UrlOpcion,seguridad.UsuarioCreacion
						  ,seguridad.FechaCreacion,seguridad.UsuarioModificacion,seguridad.FechaModificacion,seguridad.Compania,seguridad.IndicadorCompania
						  ,seguridad.idTipoAtencion,seguridad.TipoTrabajador,seguridad.IndicadorFormato
						  ,2 as IndicadorAsignacion --OBS: ASIGNADO
						  ,seguridad.TipoProceso,
						  seguridad.Accion,
						  seguridad.Version,seguridad.Estado
							,seguridad.IdAgente,seguridad.IdGrupo,seguridad.IdOrganizacion,seguridad.TipoAgente,seguridad.CodigoAgente
						  ,seguridad.IdEmpleado,seguridad.IndicadorMultiple,seguridad.Clave,seguridad.FechaInicio,seguridad.FechaFin,seguridad.FechaExpiracion,seguridad.NombreAgente,
						  seguridad.ExpiraClave,seguridad.DescripcionAgente,seguridad.EstadoAgente,seguridad.IdGrupoTransaccion,seguridad.TipoTransaccion,seguridad.IdOpcionDefecto,seguridad.Plataforma
						  ,seguridad.ValorFechaAgOpcion,seguridad.ValorNumericoAgOpcion,seguridad.ValorTextAgOpcion
						  ,seguridad.IndicadorAcceso,seguridad.IndicadorHabilitado,seguridad.IndicadorObligatorio,seguridad.IndicadorVisible
						  ,seguridad.IndicarPrioridadAgOpcion,seguridad.IndicadorNuevo,seguridad.IndicadorModificar
						  ,seguridad.IndicadorEliminar,seguridad.IndicadorImprimir,seguridad.IndicadorIngreso,seguridad.EstadoAgenteOpcion,seguridad.IdFormato
						  ,seguridad.IdFormatoPadre,seguridad.CodigoFormato,seguridad.CodigoFormatoPadre,seguridad.CadenaRecursividadFormato
						  ,seguridad.Nivel,seguridad.DescripcionFormato,seguridad.DescripcionExtranjera,seguridad.TipoFormato
						  ,seguridad.VersionFormatoFijo,seguridad.IdFormatoDinamico,seguridad.EstadoFormato															
					from 
					(
						select vistaSeg.* 	from dbo.SS_CHE_VistaSeguridad vistaSeg	 where	
						vistaSeg.IdAgente in (
							select IdAgente from @TABLA_OPCIONESAGENTE_VALIDAS as AgtVal
							where AgtVal.IdOpcion = vistaSeg.IdOpcion
							and INDICADOR = 'VALIDO'
						)						
						and		NivelOpcion = 1					
					) as seguridad																				
					union
					select 
						seguridad.Sistema,seguridad.Nombre,seguridad.Modulo,seguridad.Orden,seguridad.NombreModulo,seguridad.IdOpcion,seguridad.IdOpcionPadre,seguridad.CodigoOpcion,seguridad.CadenaRecursividad
						  ,seguridad.NivelOpcion,seguridad.NombreOpcion,seguridad.Descripcion,seguridad.SubModulo,seguridad.OrdenOpcion,seguridad.TipoOpcion
						  ,seguridad.TipoIcono,seguridad.IndicadorPrioridad,seguridad.IndicadorObjeto,seguridad.IdObjetoAsociado,seguridad.TipoDato
						  ,seguridad.ValorTexto,seguridad.ValorNumerico,seguridad.ValorFecha,seguridad.UrlOpcion,seguridad.UsuarioCreacion
						  ,seguridad.FechaCreacion,seguridad.UsuarioModificacion,seguridad.FechaModificacion,seguridad.Compania,seguridad.IndicadorCompania
						  ,seguridad.idTipoAtencion,seguridad.TipoTrabajador,seguridad.IndicadorFormato
						  ,1 as IndicadorAsignacion --OBS: NO ASIGNADO
						  ,seguridad.TipoProceso,
						  seguridad.Accion,
						  seguridad.Version,seguridad.Estado
							,seguridad.IdAgente,seguridad.IdGrupo,seguridad.IdOrganizacion,
							0 as TipoAgente,
							seguridad.CodigoAgente
						  ,seguridad.IdEmpleado,seguridad.IndicadorMultiple,seguridad.Clave,seguridad.FechaInicio,seguridad.FechaFin,seguridad.FechaExpiracion,
						  seguridad.NombreAgente,
						  seguridad.ExpiraClave,seguridad.DescripcionAgente,seguridad.EstadoAgente,seguridad.IdGrupoTransaccion,seguridad.TipoTransaccion,seguridad.IdOpcionDefecto,seguridad.Plataforma
						  ,seguridad.ValorFechaAgOpcion,seguridad.ValorNumericoAgOpcion,seguridad.ValorTextAgOpcion
						  , 1 as IndicadorAcceso,
						  1 as IndicadorHabilitado,1 as IndicadorObligatorio,1 as IndicadorVisible
						  ,1 as IndicarPrioridadAgOpcion,
						  1 as IndicadorNuevo,1 as IndicadorModificar
						  ,1 as IndicadorEliminar,1 as IndicadorImprimir,1 as IndicadorIngreso,
						  seguridad.EstadoAgenteOpcion,seguridad.IdFormato
						  ,seguridad.IdFormatoPadre,seguridad.CodigoFormato,seguridad.CodigoFormatoPadre,seguridad.CadenaRecursividadFormato
						  ,seguridad.Nivel,seguridad.DescripcionFormato,seguridad.DescripcionExtranjera,seguridad.TipoFormato
						  ,seguridad.VersionFormatoFijo,seguridad.IdFormatoDinamico,seguridad.EstadoFormato					
					from SS_CHE_VistaSeguridad as seguridad		
					where					
					IdAgente = -2  --OBS: hardcode
					and		NivelOpcion = 1	
					and (seguridad.IdOpcion not 
					 in (select idOPcion from SG_AgenteOpcion
						where --IdAgente = @IdAgente
							-----
							seguridad.IdAgente in (		
								select IdAgente from @TABLA_OPCIONESAGENTE_VALIDAS as AgtVal
								where AgtVal.IdOpcion = seguridad.IdOpcion	
								and INDICADOR = 'VALIDO'	
							)						
					 ))					
				end
				
			else
				begin
				Select 
						seguridad.Sistema
						  ,seguridad.Nombre
						  ,seguridad.Modulo
						  ,seguridad.Orden
						  ,seguridad.NombreModulo
						  ,seguridad.IdOpcion
						  ,seguridad.IdOpcionPadre
						  ,seguridad.CodigoOpcion
						  ,seguridad.CadenaRecursividad
						  ,seguridad.NivelOpcion
						  ,seguridad.NombreOpcion
						  ,seguridad.Descripcion
						  ,seguridad.SubModulo
						  ,seguridad.OrdenOpcion
						  ,seguridad.TipoOpcion
						  ,seguridad.TipoIcono
						  ,seguridad.IndicadorPrioridad
						  ,seguridad.IndicadorObjeto
						  ,seguridad.IdObjetoAsociado
						  ,seguridad.TipoDato
						  ,seguridad.ValorTexto
						  ,seguridad.ValorNumerico
						  ,seguridad.ValorFecha
						  ,seguridad.UrlOpcion
						  ,seguridad.UsuarioCreacion
						  ,seguridad.FechaCreacion
						  ,seguridad.UsuarioModificacion
						  ,seguridad.FechaModificacion
						  ,seguridad.Compania
						  ,seguridad.IndicadorCompania
						  ,seguridad.idTipoAtencion
						  ,seguridad.TipoTrabajador
						  ,seguridad.IndicadorFormato
						  ,2 as IndicadorAsignacion --OBS: ASIGNADO
						  ,seguridad.TipoProceso
						  ,seguridad.Accion
						  ,seguridad.Version
						  ,seguridad.Estado
						  ,seguridad.IdAgente
						  ,seguridad.IdGrupo
						  ,seguridad.IdOrganizacion
						  ,seguridad.TipoAgente
						  ,seguridad.CodigoAgente
						  ,seguridad.IdEmpleado
						  ,seguridad.IndicadorMultiple
						  ,seguridad.Clave
						  ,seguridad.FechaInicio
						  ,seguridad.FechaFin
						  ,seguridad.FechaExpiracion
						  ,seguridad.NombreAgente
						  ,seguridad.ExpiraClave
						  ,seguridad.DescripcionAgente
						  ,seguridad.EstadoAgente
						  ,seguridad.IdGrupoTransaccion
						  ,seguridad.TipoTransaccion
						  ,seguridad.IdOpcionDefecto
						  ,seguridad.Plataforma
						  ,seguridad.ValorFechaAgOpcion
						  ,seguridad.ValorNumericoAgOpcion
						  ,seguridad.ValorTextAgOpcion
						  ,seguridad.IndicadorAcceso
						  ,seguridad.IndicadorHabilitado
						  ,seguridad.IndicadorObligatorio
						  ,seguridad.IndicadorVisible
						  ,seguridad.IndicarPrioridadAgOpcion
						  ,seguridad.IndicadorNuevo
						  ,seguridad.IndicadorModificar
						  ,seguridad.IndicadorEliminar
						  ,seguridad.IndicadorImprimir
						  ,seguridad.IndicadorIngreso
						  ,seguridad.EstadoAgenteOpcion
						  ,seguridad.IdFormato
						  ,seguridad.IdFormatoPadre
						  ,seguridad.CodigoFormato
						  ,seguridad.CodigoFormatoPadre
						  ,seguridad.CadenaRecursividadFormato
						  ,seguridad.Nivel
						  ,seguridad.DescripcionFormato
						  ,seguridad.DescripcionExtranjera
						  ,seguridad.TipoFormato
						  ,seguridad.VersionFormatoFijo
						  ,seguridad.IdFormatoDinamico
						  ,seguridad.EstadoFormato
					
					from dbo.SS_CHE_VistaSeguridad as seguridad									
					where				
					IdOpcionPadre = @IdOpcionPadre
					-----
					and		seguridad.IdAgente in (		
								select IdAgente from @TABLA_OPCIONESAGENTE_VALIDAS as AgtVal
								where AgtVal.IdOpcion = seguridad.IdOpcion																	
								and INDICADOR = 'VALIDO'
							)
					and (@IdOpcion is null or (@IdOpcion=IdOpcion) or (@IdOpcion=0))
					union
					select 
						seguridad.Sistema,seguridad.Nombre,seguridad.Modulo,seguridad.Orden,seguridad.NombreModulo,seguridad.IdOpcion,seguridad.IdOpcionPadre,seguridad.CodigoOpcion,seguridad.CadenaRecursividad
						  ,seguridad.NivelOpcion,seguridad.NombreOpcion,seguridad.Descripcion,seguridad.SubModulo,seguridad.OrdenOpcion,seguridad.TipoOpcion
						  ,seguridad.TipoIcono,seguridad.IndicadorPrioridad,seguridad.IndicadorObjeto,seguridad.IdObjetoAsociado,seguridad.TipoDato
						  ,seguridad.ValorTexto,seguridad.ValorNumerico,seguridad.ValorFecha,seguridad.UrlOpcion,seguridad.UsuarioCreacion
						  ,seguridad.FechaCreacion,seguridad.UsuarioModificacion,seguridad.FechaModificacion,seguridad.Compania,seguridad.IndicadorCompania
						  ,seguridad.idTipoAtencion,seguridad.TipoTrabajador,seguridad.IndicadorFormato
						  ,1 as IndicadorAsignacion --OBS: NO ASIGNADO
						  ,seguridad.TipoProceso,seguridad.Accion,seguridad.Version,seguridad.Estado
							,seguridad.IdAgente,seguridad.IdGrupo,seguridad.IdOrganizacion,
							0 as TipoAgente,
							seguridad.CodigoAgente
						  ,seguridad.IdEmpleado,seguridad.IndicadorMultiple,seguridad.Clave,seguridad.FechaInicio,seguridad.FechaFin,seguridad.FechaExpiracion,
						  seguridad.NombreAgente,
						  seguridad.ExpiraClave,seguridad.DescripcionAgente,seguridad.EstadoAgente,seguridad.IdGrupoTransaccion,seguridad.TipoTransaccion,seguridad.IdOpcionDefecto,seguridad.Plataforma
						  ,seguridad.ValorFechaAgOpcion,seguridad.ValorNumericoAgOpcion,seguridad.ValorTextAgOpcion
						  , 1 as IndicadorAcceso,
						  1 as IndicadorHabilitado,1 as IndicadorObligatorio,1 as IndicadorVisible
						  ,1 as IndicarPrioridadAgOpcion,
						  1 as IndicadorNuevo,1 as IndicadorModificar
						  ,1 as IndicadorEliminar,
						  1 as IndicadorImprimir,
						  1 as IndicadorIngreso,
						  seguridad.EstadoAgenteOpcion,seguridad.IdFormato
						  ,seguridad.IdFormatoPadre,seguridad.CodigoFormato,seguridad.CodigoFormatoPadre,seguridad.CadenaRecursividadFormato
						  ,seguridad.Nivel,seguridad.DescripcionFormato,seguridad.DescripcionExtranjera,seguridad.TipoFormato
						  ,seguridad.VersionFormatoFijo,seguridad.IdFormatoDinamico,seguridad.EstadoFormato					
					from SS_CHE_VistaSeguridad as seguridad		
					where					
					IdAgente = -2  --OBS: hardcode: ADMINSYS
					and (	IdOpcionPadre = @IdOpcionPadre)
					and (seguridad.IdOpcion not 
					 in (select idOPcion from SG_AgenteOpcion
						where --IdAgente = @IdAgente
							-----
							seguridad.IdAgente in (		
								select IdAgente from @TABLA_OPCIONESAGENTE_VALIDAS as AgtVal
								where AgtVal.IdOpcion = seguridad.IdOpcion
								and INDICADOR = 'VALIDO'
							)
					 ))
					 ---
					 and (@IdOpcion is null or (@IdOpcion=IdOpcion) or (@IdOpcion=0))
					 and (@NivelOpcion >0 or @NivelOpcion is null)
					-----		
				end

		 END
		 ELSE
		if(@ACCION = 'LISTAROPCIONESCAGENTEOBLIGATORIO')
		BEGIN	
			
			if(@IdOpcionPadre is null and @IdOpcion is not null)
			begin			
				select @IdOpcionPadre = IdOpcionPadre from SG_Opcion where IdOpcion = @IdOpcion
			end			
			
			if (@NivelOpcion=1)
			begin
					select 
						seguridad.Sistema,seguridad.Nombre,seguridad.Modulo,seguridad.Orden,seguridad.NombreModulo,seguridad.IdOpcion,seguridad.IdOpcionPadre,seguridad.CodigoOpcion,seguridad.CadenaRecursividad
						  ,seguridad.NivelOpcion,seguridad.NombreOpcion,seguridad.Descripcion,seguridad.SubModulo,seguridad.OrdenOpcion,seguridad.TipoOpcion
						  ,seguridad.TipoIcono,seguridad.IndicadorPrioridad,seguridad.IndicadorObjeto,seguridad.IdObjetoAsociado,seguridad.TipoDato
						  ,seguridad.ValorTexto,seguridad.ValorNumerico,seguridad.ValorFecha,seguridad.UrlOpcion,seguridad.UsuarioCreacion
						  ,seguridad.FechaCreacion,seguridad.UsuarioModificacion,seguridad.FechaModificacion,seguridad.Compania,seguridad.IndicadorCompania
						  ,seguridad.idTipoAtencion,seguridad.TipoTrabajador,seguridad.IndicadorFormato
						  ,2 as IndicadorAsignacion --OBS: ASIGNADO
						  ,seguridad.TipoProceso,
						  seguridad.Accion,
						  seguridad.Version,seguridad.Estado
							,seguridad.IdAgente,seguridad.IdGrupo,seguridad.IdOrganizacion,seguridad.TipoAgente,seguridad.CodigoAgente
						  ,seguridad.IdEmpleado,seguridad.IndicadorMultiple,seguridad.Clave,seguridad.FechaInicio,seguridad.FechaFin,seguridad.FechaExpiracion,seguridad.NombreAgente,
						  seguridad.ExpiraClave,seguridad.DescripcionAgente,seguridad.EstadoAgente,seguridad.IdGrupoTransaccion,seguridad.TipoTransaccion,seguridad.IdOpcionDefecto,seguridad.Plataforma
						  ,seguridad.ValorFechaAgOpcion,seguridad.ValorNumericoAgOpcion,seguridad.ValorTextAgOpcion
						  ,seguridad.IndicadorAcceso,seguridad.IndicadorHabilitado,seguridad.IndicadorObligatorio,seguridad.IndicadorVisible
						  ,seguridad.IndicarPrioridadAgOpcion,seguridad.IndicadorNuevo,seguridad.IndicadorModificar
						  ,seguridad.IndicadorEliminar,seguridad.IndicadorImprimir,seguridad.IndicadorIngreso,seguridad.EstadoAgenteOpcion,seguridad.IdFormato
						  ,seguridad.IdFormatoPadre,seguridad.CodigoFormato,seguridad.CodigoFormatoPadre,seguridad.CadenaRecursividadFormato
						  ,seguridad.Nivel,seguridad.DescripcionFormato,seguridad.DescripcionExtranjera,seguridad.TipoFormato
						  ,seguridad.VersionFormatoFijo,seguridad.IdFormatoDinamico,seguridad.EstadoFormato															
					from 
					(
						select vistaSeg.* 	from dbo.SS_CHE_VistaSeguridad vistaSeg						
						where	
						IndicadorObligatorio=2 AND
						vistaSeg.IdAgente in (
							select IdAgente from @TABLA_OPCIONESAGENTE_VALIDAS as AgtVal
							where AgtVal.IdOpcion = vistaSeg.IdOpcion
							and INDICADOR = 'VALIDO'
						)						
						and		NivelOpcion = 1					
					) as seguridad																				
					union
					select 
						seguridad.Sistema,seguridad.Nombre,seguridad.Modulo,seguridad.Orden,seguridad.NombreModulo,seguridad.IdOpcion,seguridad.IdOpcionPadre,seguridad.CodigoOpcion,seguridad.CadenaRecursividad
						  ,seguridad.NivelOpcion,seguridad.NombreOpcion,seguridad.Descripcion,seguridad.SubModulo,seguridad.OrdenOpcion,seguridad.TipoOpcion
						  ,seguridad.TipoIcono,seguridad.IndicadorPrioridad,seguridad.IndicadorObjeto,seguridad.IdObjetoAsociado,seguridad.TipoDato
						  ,seguridad.ValorTexto,seguridad.ValorNumerico,seguridad.ValorFecha,seguridad.UrlOpcion,seguridad.UsuarioCreacion
						  ,seguridad.FechaCreacion,seguridad.UsuarioModificacion,seguridad.FechaModificacion,seguridad.Compania,seguridad.IndicadorCompania
						  ,seguridad.idTipoAtencion,seguridad.TipoTrabajador,seguridad.IndicadorFormato
						  ,1 as IndicadorAsignacion --OBS: NO ASIGNADO
						  ,seguridad.TipoProceso,
						  seguridad.Accion,
						  seguridad.Version,seguridad.Estado
							,seguridad.IdAgente,seguridad.IdGrupo,seguridad.IdOrganizacion,
							0 as TipoAgente,
							seguridad.CodigoAgente
						  ,seguridad.IdEmpleado,seguridad.IndicadorMultiple,seguridad.Clave,seguridad.FechaInicio,seguridad.FechaFin,seguridad.FechaExpiracion,
						  seguridad.NombreAgente,
						  seguridad.ExpiraClave,seguridad.DescripcionAgente,seguridad.EstadoAgente,seguridad.IdGrupoTransaccion,seguridad.TipoTransaccion,seguridad.IdOpcionDefecto,seguridad.Plataforma
						  ,seguridad.ValorFechaAgOpcion,seguridad.ValorNumericoAgOpcion,seguridad.ValorTextAgOpcion
						  , 1 as IndicadorAcceso,
						  1 as IndicadorHabilitado,1 as IndicadorObligatorio,1 as IndicadorVisible
						  ,1 as IndicarPrioridadAgOpcion,
						  1 as IndicadorNuevo,1 as IndicadorModificar
						  ,1 as IndicadorEliminar,1 as IndicadorImprimir,1 as IndicadorIngreso,
						  seguridad.EstadoAgenteOpcion,seguridad.IdFormato
						  ,seguridad.IdFormatoPadre,seguridad.CodigoFormato,seguridad.CodigoFormatoPadre,seguridad.CadenaRecursividadFormato
						  ,seguridad.Nivel,seguridad.DescripcionFormato,seguridad.DescripcionExtranjera,seguridad.TipoFormato
						  ,seguridad.VersionFormatoFijo,seguridad.IdFormatoDinamico,seguridad.EstadoFormato					
					from SS_CHE_VistaSeguridad as seguridad		
					where					
					IdAgente = -2  --OBS: hardcode 
					and IndicadorObligatorio=2 
					and		NivelOpcion = 1	
					and (seguridad.IdOpcion not 
					 in (select idOPcion from SG_AgenteOpcion
						where --IdAgente = @IdAgente
							-----
							seguridad.IdAgente in (		
								select IdAgente from @TABLA_OPCIONESAGENTE_VALIDAS as AgtVal
								where AgtVal.IdOpcion = seguridad.IdOpcion	
								and INDICADOR = 'VALIDO'																

							)						
					 ))					
				end
				
			else
				begin
				Select 
						seguridad.Sistema
						  ,seguridad.Nombre
						  ,seguridad.Modulo
						  ,seguridad.Orden
						  ,seguridad.NombreModulo
						  ,seguridad.IdOpcion
						  ,seguridad.IdOpcionPadre
						  ,seguridad.CodigoOpcion
						  ,seguridad.CadenaRecursividad
						  ,seguridad.NivelOpcion
						  ,seguridad.NombreOpcion
						  ,seguridad.Descripcion
						  ,seguridad.SubModulo
						  ,seguridad.OrdenOpcion
						  ,seguridad.TipoOpcion
						  ,seguridad.TipoIcono
						  ,seguridad.IndicadorPrioridad
						  ,seguridad.IndicadorObjeto
						  ,seguridad.IdObjetoAsociado
						  ,seguridad.TipoDato
						  ,seguridad.ValorTexto
						  ,seguridad.ValorNumerico
						  ,seguridad.ValorFecha
						  ,seguridad.UrlOpcion
						  ,seguridad.UsuarioCreacion
						  ,seguridad.FechaCreacion
						  ,seguridad.UsuarioModificacion
						  ,seguridad.FechaModificacion
						  ,seguridad.Compania
						  ,seguridad.IndicadorCompania
						  ,seguridad.idTipoAtencion
						  ,seguridad.TipoTrabajador
						  ,seguridad.IndicadorFormato
						  ,2 as IndicadorAsignacion --OBS: ASIGNADO
						  ,seguridad.TipoProceso
						  ,seguridad.Accion
						  ,seguridad.Version
						  ,seguridad.Estado
						  ,seguridad.IdAgente
						  ,seguridad.IdGrupo
						  ,seguridad.IdOrganizacion
						  ,seguridad.TipoAgente
						  ,seguridad.CodigoAgente
						  ,seguridad.IdEmpleado
						  ,seguridad.IndicadorMultiple
						  ,seguridad.Clave
						  ,seguridad.FechaInicio
						  ,seguridad.FechaFin
						  ,seguridad.FechaExpiracion
						  ,seguridad.NombreAgente
						  ,seguridad.ExpiraClave
						  ,seguridad.DescripcionAgente
						  ,seguridad.EstadoAgente
						  ,seguridad.IdGrupoTransaccion
						  ,seguridad.TipoTransaccion
						  ,seguridad.IdOpcionDefecto
						  ,seguridad.Plataforma
						  ,seguridad.ValorFechaAgOpcion
						  ,seguridad.ValorNumericoAgOpcion
						  ,seguridad.ValorTextAgOpcion
						  ,seguridad.IndicadorAcceso
						  ,seguridad.IndicadorHabilitado
						  ,seguridad.IndicadorObligatorio
						  ,seguridad.IndicadorVisible
						  ,seguridad.IndicarPrioridadAgOpcion
						  ,seguridad.IndicadorNuevo
						  ,seguridad.IndicadorModificar
						  ,seguridad.IndicadorEliminar
						  ,seguridad.IndicadorImprimir
						  ,seguridad.IndicadorIngreso
						  ,seguridad.EstadoAgenteOpcion
						  ,seguridad.IdFormato
						  ,seguridad.IdFormatoPadre
						  ,seguridad.CodigoFormato
						  ,seguridad.CodigoFormatoPadre
						  ,seguridad.CadenaRecursividadFormato
						  ,seguridad.Nivel
						  ,seguridad.DescripcionFormato
						  ,seguridad.DescripcionExtranjera
						  ,seguridad.TipoFormato
						  ,seguridad.VersionFormatoFijo
						  ,seguridad.IdFormatoDinamico
						  ,seguridad.EstadoFormato
					
					from dbo.SS_CHE_VistaSeguridad as seguridad									
					where					
					IndicadorObligatorio=2 AND				
					Modulo = @Modulo
					-----
					and		seguridad.IdAgente in (		
								select IdAgente from @TABLA_OPCIONESAGENTE_VALIDAS as AgtVal
								where AgtVal.IdOpcion = seguridad.IdOpcion																	
								and INDICADOR = 'VALIDO'
	
							)
					and (@IdOpcion is null or (@IdOpcion=IdOpcion) or (@IdOpcion=0))
					union
					select 
						seguridad.Sistema,seguridad.Nombre,seguridad.Modulo,seguridad.Orden,seguridad.NombreModulo,seguridad.IdOpcion,seguridad.IdOpcionPadre,seguridad.CodigoOpcion,seguridad.CadenaRecursividad
						  ,seguridad.NivelOpcion,seguridad.NombreOpcion,seguridad.Descripcion,seguridad.SubModulo,seguridad.OrdenOpcion,seguridad.TipoOpcion
						  ,seguridad.TipoIcono,seguridad.IndicadorPrioridad,seguridad.IndicadorObjeto,seguridad.IdObjetoAsociado,seguridad.TipoDato
						  ,seguridad.ValorTexto,seguridad.ValorNumerico,seguridad.ValorFecha,seguridad.UrlOpcion,seguridad.UsuarioCreacion
						  ,seguridad.FechaCreacion,seguridad.UsuarioModificacion,seguridad.FechaModificacion,seguridad.Compania,seguridad.IndicadorCompania
						  ,seguridad.idTipoAtencion,seguridad.TipoTrabajador,seguridad.IndicadorFormato
						  ,1 as IndicadorAsignacion --OBS: NO ASIGNADO
						  ,seguridad.TipoProceso,seguridad.Accion,seguridad.Version,seguridad.Estado
							,seguridad.IdAgente,seguridad.IdGrupo,seguridad.IdOrganizacion,
							0 as TipoAgente,
							seguridad.CodigoAgente
						  ,seguridad.IdEmpleado,seguridad.IndicadorMultiple,seguridad.Clave,seguridad.FechaInicio,seguridad.FechaFin,seguridad.FechaExpiracion,
						  seguridad.NombreAgente,
						  seguridad.ExpiraClave,seguridad.DescripcionAgente,seguridad.EstadoAgente,seguridad.IdGrupoTransaccion,seguridad.TipoTransaccion,seguridad.IdOpcionDefecto,seguridad.Plataforma
						  ,seguridad.ValorFechaAgOpcion,seguridad.ValorNumericoAgOpcion,seguridad.ValorTextAgOpcion
						  , 1 as IndicadorAcceso,
						  1 as IndicadorHabilitado,1 as IndicadorObligatorio,1 as IndicadorVisible
						  ,1 as IndicarPrioridadAgOpcion,
						  1 as IndicadorNuevo,1 as IndicadorModificar
						  ,1 as IndicadorEliminar,
						  1 as IndicadorImprimir,
						  1 as IndicadorIngreso,
						  seguridad.EstadoAgenteOpcion,seguridad.IdFormato
						  ,seguridad.IdFormatoPadre,seguridad.CodigoFormato,seguridad.CodigoFormatoPadre,seguridad.CadenaRecursividadFormato
						  ,seguridad.Nivel,seguridad.DescripcionFormato,seguridad.DescripcionExtranjera,seguridad.TipoFormato
						  ,seguridad.VersionFormatoFijo,seguridad.IdFormatoDinamico,seguridad.EstadoFormato					
					from SS_CHE_VistaSeguridad as seguridad		
					where					
					IdAgente = -2  --OBS: hardcode: ADMINSYS
					and IndicadorObligatorio=2 
					and (	Modulo = @Modulo)
					and (seguridad.IdOpcion not 
					 in (select idOPcion from SG_AgenteOpcion
						where --IdAgente = @IdAgente
							-----
							seguridad.IdAgente in (		
								select IdAgente from @TABLA_OPCIONESAGENTE_VALIDAS as AgtVal
								where AgtVal.IdOpcion = seguridad.IdOpcion
								and INDICADOR = 'VALIDO'
							)
					 ))
					 ---
					 and (@IdOpcion is null or (@IdOpcion=IdOpcion) or (@IdOpcion=0))
					 and (@NivelOpcion >0 or @NivelOpcion is null)
					-----	
				end

		 END

	ELSE
		 
	 if(@ACCION = 'LISTAROPCIONESCAG')
		BEGIN	
			
	         if (@NivelOpcion=1)
			begin
			    select 					seguridad.Sistema,seguridad.Nombre,seguridad.Modulo,seguridad.Orden,seguridad.NombreModulo,seguridad.IdOpcion,seguridad.IdOpcionPadre,seguridad.CodigoOpcion,seguridad.CadenaRecursividad
						  ,seguridad.NivelOpcion,seguridad.NombreOpcion,seguridad.Descripcion,seguridad.SubModulo,seguridad.OrdenOpcion,seguridad.TipoOpcion
						  ,seguridad.TipoIcono,seguridad.IndicadorPrioridad,seguridad.IndicadorObjeto,seguridad.IdObjetoAsociado,seguridad.TipoDato
						  ,seguridad.ValorTexto,seguridad.ValorNumerico,seguridad.ValorFecha,seguridad.UrlOpcion,seguridad.UsuarioCreacion
						  ,seguridad.FechaCreacion,seguridad.UsuarioModificacion,seguridad.FechaModificacion,seguridad.Compania,seguridad.IndicadorCompania
						  ,seguridad.idTipoAtencion,seguridad.TipoTrabajador,seguridad.IndicadorFormato
						  ,1 as IndicadorAsignacion --OBS: NO ASIGNADO
						  ,seguridad.TipoProceso,seguridad.Accion,seguridad.Version,seguridad.Estado
							,seguridad.IdAgente,seguridad.IdGrupo,seguridad.IdOrganizacion,
							0 as TipoAgente,
							seguridad.CodigoAgente
						  ,seguridad.IdEmpleado,seguridad.IndicadorMultiple,seguridad.Clave,seguridad.FechaInicio,seguridad.FechaFin,seguridad.FechaExpiracion,
						  seguridad.NombreAgente,
						  seguridad.ExpiraClave,seguridad.DescripcionAgente,seguridad.EstadoAgente,seguridad.IdGrupoTransaccion,seguridad.TipoTransaccion,seguridad.IdOpcionDefecto,seguridad.Plataforma
						  ,seguridad.ValorFechaAgOpcion,seguridad.ValorNumericoAgOpcion,seguridad.ValorTextAgOpcion
						  , 1 as IndicadorAcceso,
						  1 as IndicadorHabilitado,1 as IndicadorObligatorio,1 as IndicadorVisible
						  ,1 as IndicarPrioridadAgOpcion,
						  1 as IndicadorNuevo,1 as IndicadorModificar
						  ,1 as IndicadorEliminar,
						  1 as IndicadorImprimir,
						  1 as IndicadorIngreso,
						  seguridad.EstadoAgenteOpcion,seguridad.IdFormato
						  ,seguridad.IdFormatoPadre,seguridad.CodigoFormato,seguridad.CodigoFormatoPadre,seguridad.CadenaRecursividadFormato
						  ,seguridad.Nivel,seguridad.DescripcionFormato,seguridad.DescripcionExtranjera,seguridad.TipoFormato
						  ,seguridad.VersionFormatoFijo,seguridad.IdFormatoDinamico,seguridad.EstadoFormato					
					from SS_CHE_VistaSeguridad as seguridad		
					where					
				IdAgente = @IdAgente
				and IndicadorObligatorio=2
			    and CodigoFormato is not null

			end
	         
	END	
				 
	if(@ACCION = 'LISTAPROCESOGENERAL')
		BEGIN			
					Select * from dbo.SS_CHE_VistaSeguridad  as VistaSeg
					where 
					VistaSeg.TipoOpcion <> 'N' and
					VistaSeg.IdAgente in (
						select DISTINCT IdAgente from @TABLA_OPCIONESAGENTE_VALIDAS as AgtVal
						where AgtVal.IdOpcion = VistaSeg.IdOpcion
						and INDICADOR = 'VALIDO'
						and TipoOpcion <> 'N'
						and IdAgente NOT IN(@IdAgente) 	
				
					)					
					and VistaSeg.EstadoAgenteOpcion = 2
					and VistaSeg.Modulo = 'HC'		
					and VistaSeg.EstadoFormato=@EstadoFormato
					and VistaSeg.NombreOpcion in (Select distinct NombreOpcion from SS_CHE_VistaSeguridad)
					and VistaSeg.UrlOpcion is null		
					
		 END	
		
		 if(@ACCION = 'LISTAPROCESOSBITACORA')
		BEGIN
			/*************************************************/
			/******CONFIGURACION DE ASIGNACIONES OPCION*****/
			/*************************************************/
			
				select @Total= COUNT(*) from @TABLA_OPCIONESAGENTE_VALIDAS
				set @cuenta  =1						
				
				while(@cuenta <= @Total)
				begin														 
					select @IndicadorVAL_AUX  = INDICADOR,
							@IdOpcionAux= idOpcion
						from @TABLA_OPCIONESAGENTE_VALIDAS as AUX
						where AUX.SECUENCIA = @cuenta
									 									 															
					if(@IndicadorVAL_AUX = 'VALIDO')
					begin
						select @INDICA_AUX =IndicadorAsignacion from SG_Opcion	
						where IdOpcion = @IdOpcionAux
						if(@INDICA_AUX = 2)
						begin						
							/***VALIDACIONES ASIGNADAS:**/
							--------------------------------
							--(1) ESPECIALIDAD
							--------------------------------
							set @CampoCodigoID_AUX = 4 -- 4: INDICA TABLA ESPECIALIDAD
							select @INDICA_AUX = count(*)
							from SS_HC_FormatoCodigoId
							where CampoCodigoId = @CampoCodigoID_AUX  --TABLA ESPECIALIDAD
							and IdOpcion=@IdOpcionAux
							if(@INDICA_AUX > 0) --POSEE ASIGNACIONES
							begin
								select @INDICA_AUX = count(*)
								from SS_HC_FormatoCodigoId
								where CampoCodigoId = @CampoCodigoID_AUX -- TABLA ESPECIALIDAD
								and IdOpcion=@IdOpcionAux	
								and IndicadorCodigoId=1	--1:INDICA TODOS
								
								if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES GENERALES (debe poseer específicas)
								begin
									select @INDICA_AUX = count(*)
									from SS_HC_FormatoCodigoId
									where CampoCodigoId = @CampoCodigoID_AUX -- TABLA ESPECIALIDAD
									and IdOpcion=@IdOpcionAux	
									and IndicadorCodigoId=2	--1:INDICA ESPECIFICOS
									and ValorId= @IdGrupo  --1:ID DE ESPECIALIDAD ESPECÍFICO
									
									if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES PARA TAL VALOR (NO VALIDO)
									begin
										update @TABLA_OPCIONESAGENTE_VALIDAS 
										set INDICADOR = 'NO VALIDO'					
										where SECUENCIA = @cuenta																	
									end
								end							
							end
							
							--------------------------------
							--(2) COMPANIA
							--------------------------------
							set @CampoCodigoID_AUX = 1 -- 1: INDICA TABLA COMPANIA
							select @INDICA_AUX = count(*)
							from SS_HC_FormatoCodigoId
							where CampoCodigoId = @CampoCodigoID_AUX  --TABLA COMPANIA
							and IdOpcion=@IdOpcionAux
							if(@INDICA_AUX > 0) --POSEE ASIGNACIONES
							begin
								select @INDICA_AUX = count(*)
								from SS_HC_FormatoCodigoId
								where CampoCodigoId = @CampoCodigoID_AUX -- TABLA COMPANIA
								and IdOpcion=@IdOpcionAux	
								and IndicadorCodigoId=1	--1:INDICA TODOS
								
								if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES GENERALES (debe poseer específicas)
								begin
									select @INDICA_AUX = count(*)
									from SS_HC_FormatoCodigoId
									where CampoCodigoId = @CampoCodigoID_AUX -- TABLA COMPANIA
									and IdOpcion=@IdOpcionAux	
									and IndicadorCodigoId=2	--1:INDICA ESPECIFICOS
									and ValorTexto= @Compania  --1:COD DE COMPANIA ESPECÍFICO
									
									if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES PARA TAL VALOR (NO VALIDO)
									begin
										update @TABLA_OPCIONESAGENTE_VALIDAS 
										set INDICADOR = 'NO VALIDO'					
										where SECUENCIA = @cuenta																	
									end
								end							
							end						
							--------------------------------
							--(3) ESTABLECIMIENTO
							--------------------------------
							set @CampoCodigoID_AUX = 2 -- 1: INDICA TABLA ESTABLECIMIENTO
							select @INDICA_AUX = count(*)
							from SS_HC_FormatoCodigoId
							where CampoCodigoId = @CampoCodigoID_AUX  --TABLA ESTABLECIMIENTO
							and IdOpcion=@IdOpcionAux
							if(@INDICA_AUX > 0) --POSEE ASIGNACIONES
							begin
								select @INDICA_AUX = count(*)
								from SS_HC_FormatoCodigoId
								where CampoCodigoId = @CampoCodigoID_AUX -- TABLA ESTABLECIMIENTO
								and IdOpcion=@IdOpcionAux	
								and IndicadorCodigoId=1	--1:INDICA TODOS
								
								if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES GENERALES (debe poseer específicas)
								begin
									select @INDICA_AUX = count(*)
									from SS_HC_FormatoCodigoId
									where CampoCodigoId = @CampoCodigoID_AUX -- TABLA ESTABLECIMIENTO
									and IdOpcion=@IdOpcionAux	
									and IndicadorCodigoId=2	--1:INDICA ESPECIFICOS
									and ValorId= @IdOrganizacion  --:ID DE ESTABLECIMIENTO ESPECÍFICO
									
									if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES PARA TAL VALOR (NO VALIDO)
									begin
										update @TABLA_OPCIONESAGENTE_VALIDAS 
										set INDICADOR = 'NO VALIDO'					
										where SECUENCIA = @cuenta																	
									end
								end							
							end									
							--------------------------------
							--(4) AGENTE
							--------------------------------	
							set @CampoCodigoID_AUX = 8 -- 1: INDICA TABLA AGENTE
							select @INDICA_AUX = count(*)
							from SS_HC_FormatoCodigoId
							where CampoCodigoId = @CampoCodigoID_AUX  --TABLA AGENTE
							and IdOpcion=@IdOpcionAux
							if(@INDICA_AUX > 0) --POSEE ASIGNACIONES
							begin
								select @INDICA_AUX = count(*)
								from SS_HC_FormatoCodigoId
								where CampoCodigoId = @CampoCodigoID_AUX -- TABLA AGENTE
								and IdOpcion=@IdOpcionAux	
								and IndicadorCodigoId=1	--1:INDICA TODOS
								
								if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES GENERALES (debe poseer específicas)
								begin
									select @INDICA_AUX = count(*)
									from SS_HC_FormatoCodigoId
									where CampoCodigoId = @CampoCodigoID_AUX -- TABLA 
									and IdOpcion=@IdOpcionAux	
									and IndicadorCodigoId=2	--1:INDICA ESPECIFICOS
									and ValorId= @IdAgente  --:ID DE AGENTE ESPECÍFICO
									
									if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES PARA TAL VALOR (NO VALIDO)
									begin
										update @TABLA_OPCIONESAGENTE_VALIDAS 
										set INDICADOR = 'NO VALIDO'					
										where SECUENCIA = @cuenta																	
									end
								end							
							end																																				
							--------------------------------
							--(5) UNIDAD DE SERVICIO
							--------------------------------	
							set @CampoCodigoID_AUX = 10 -- 1: INDICA TABLA UNID. SERVICIO
							select @INDICA_AUX = count(*)
							from SS_HC_FormatoCodigoId
							where CampoCodigoId = @CampoCodigoID_AUX  --TABLA 
							and IdOpcion=@IdOpcionAux
							if(@INDICA_AUX > 0) --POSEE ASIGNACIONES
							begin
								select @INDICA_AUX = count(*)
								from SS_HC_FormatoCodigoId
								where CampoCodigoId = @CampoCodigoID_AUX -- TABLA 
								and IdOpcion=@IdOpcionAux	
								and IndicadorCodigoId=1	--1:INDICA TODOS
								
								if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES GENERALES (debe poseer específicas)
								begin
								
									select @INDICA_AUX = count(*)
									from SS_HC_FormatoCodigoId
									where CampoCodigoId = @CampoCodigoID_AUX -- TABLA 
									and IdOpcion=@IdOpcionAux	
									and IndicadorCodigoId=2	--1:INDICA ESPECIFICOS
									and rtrim(ValorTexto)= 
										convert(varchar,@IdOrganizacion)   --:IDs  ESPECÍFICOs(Estable)
										+'|'+
										convert(varchar,@IdObjetoAsociado) --:IDs  ESPECÍFICOs (Unid. Serv)
																													
									if(@INDICA_AUX = 0) --NO POSEE ASIGNACIONES PARA TAL VALOR (NO VALIDO)
									begin
										update @TABLA_OPCIONESAGENTE_VALIDAS 
										set INDICADOR = 'NO VALIDO'					
										where SECUENCIA = @cuenta																	
									end
								end							
							end	

						end					
					
					end																		
					set @cuenta= @cuenta+1
					-------------
				end
				/*************************************************/
				/*************************************************/
		
			if (@Nivel=1)
				begin
					Select * from dbo.SS_CHE_VistaSeguridad as seguridad	where 
					seguridad.TipoOpcion <> 'N'					
					and		(seguridad.IdAgente in (
								select IdAgente from @TABLA_OPCIONESAGENTE_VALIDAS as AgtVal
								where AgtVal.IdOpcion = seguridad.IdOpcion
								and INDICADOR = 'VALIDO'
								and TipoOpcion <> 'N'
								and NivelOpcion = 1
							)
					)
					and		(seguridad.NivelOpcion = 1)					
					
				end
			else
				begin
					select * from (		
						Select vs.* from dbo.SS_CHE_VistaSeguridad vs where 
						vs.CodigoFormato IN(
						SELECT Formato_Codigo FROM v_EPISODIOATENCIONES V 
						WHERE V.IdPaciente=@IdEmpleado AND V.Episodio_Atencion=Convert(bigInt,isnull(@Version,0))/*V.IdEpisodioAtencion=Convert(bigInt,isnull(@Version,0))VERSION*/  
						AND V.UnidadReplicacion=@CadenaRecursividad and v.TipoTrabajador=@TipoTrabajador 
						AND V.CodigoOA IN(select CodigoOA from SS_HC_EpisodioAtencion EpiAtencion	inner join SS_HC_EpisodioClinico EpiClinico
								on (EpiClinico.UnidadReplicacion = EpiAtencion.UnidadReplicacion
							and EpiClinico.IdPaciente = EpiAtencion.IdPaciente
							and EpiClinico.EpisodioClinico = EpiAtencion.EpisodioClinico)
						where	(	(@CadenaRecursividad is null or EpiAtencion.UnidadReplicacion= @CadenaRecursividad)		
						and @Version is null or @Version= 0  or EpiAtencion.EpisodioAtencion= Convert(bigInt,@Version))		
						and (@IdEmpleado is null or  EpiAtencion.IdPaciente= @IdEmpleado)		
						and (@IndicadorPrioridad is null or @IndicadorPrioridad =0 or  EpiAtencion.EpisodioClinico= @IndicadorPrioridad)		
						and (@idTipoAtencion is null or @idTipoAtencion = 0 or  EpiAtencion.TipoAtencion= @idTipoAtencion)	)
						) AND VS.IdOpcionPadre= @IdOpcionPadre			
					)as seguridad
					where	
					 seguridad.TipoOpcion <> 'N'					
					and		seguridad.IdAgente in (																			
								select IdAgente from @TABLA_OPCIONESAGENTE_VALIDAS as AgtVal
								where AgtVal.IdOpcion = seguridad.IdOpcion
								and INDICADOR = 'VALIDO'
								and TipoOpcion <> 'N'
					)						
					and		seguridad.IdOpcionPadre = @IdOpcionPadre	
					order by seguridad.OrdenOpcion
				end

		 END
		 	
END

