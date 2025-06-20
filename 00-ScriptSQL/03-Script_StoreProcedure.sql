 --Fecha 25/01/2017 (Estado : Publicado)

/****** Object:  StoredProcedure [dbo].[SP_LISTARSERVICIOS]    Script Date: 25/01/2017 05:43:46 p.m. ******/
ALTER PROCEDURE [dbo].[SP_LISTARSERVICIOS]      
  @AplicacionCodigo  VARCHAR(2) = null ,      
  @CodigoTabla  VARCHAR(20) = null ,      
  @Compania  VARCHAR(6) = null ,      
  @CodigoElemento  VARCHAR(20) = null ,      
  @DescripcionLocal  VARCHAR(80)= null ,      
  @DescripcionExtranjera  VARCHAR(80)= null ,      
  @ValorNumerico  float= null ,      
  @ValorCodigo1  VARCHAR(250)= null ,      
  @ValorCodigo2  VARCHAR(250)= null ,      
  @ValorCodigo3  VARCHAR(250)= null ,      
  @ValorCodigo4  VARCHAR(250)= null ,      
  @ValorCodigo5  VARCHAR(250)= null ,      
  @ValorFecha  datetime= null ,      
  @Estado  VARCHAR(1)= null ,      
  @ACCION  VARCHAR(50)  = null       
AS      
BEGIN      
 SET NOCOUNT ON;  
     
 DECLARE  @MA_MiscelaneosDetalle TABLE(      
  AplicacionCodigo  VARCHAR(4) NULL,      
  CodigoTabla  VARCHAR(100) NULL,      
  Compania  VARCHAR(6) NULL,      
  CodigoElemento  VARCHAR(100) NULL,      
  DescripcionLocal  VARCHAR(max) NULL,      
  DescripcionExtranjera  VARCHAR(max)NULL,      
  ValorNumerico  float NULL,      
  ValorCodigo1  VARCHAR(250) NULL,      
  ValorCodigo2  VARCHAR(250) NULL,      
  ValorCodigo3  VARCHAR(250) NULL,      
  ValorCodigo4  VARCHAR(250) NULL,      
  ValorCodigo5  VARCHAR(250) NULL,      
  ValorCodigo6  VARCHAR(250) NULL,      
  ValorCodigo7  VARCHAR(250) NULL,      
  ValorEntero1  int NULL,      
  ValorEntero2  int NULL,      
  ValorEntero3  int NULL,      
  ValorEntero4  int NULL,      
  ValorEntero5  int NULL,      
  ValorEntero6  int NULL,      
  ValorEntero7  int NULL,      
  ValorFecha  datetime NULL,      
  Estado  VARCHAR(1) NULL,      
  UltimoUsuario varchar(25) null,      
  UltimaFechaModif date null,      
  Timestamp datetime null,      
  ACCION  VARCHAR(25)  null,      
  RowID INT IDENTITY(1,1) PRIMARY KEY      
 )      
      
 DECLARE @GeneraId as INTEGER, @ExisteCodigo as VARCHAR(10),  @IdEpisodioAtencionId as int      
     
 IF @ACCION ='VISTA_FORM'      
 BEGIN      
    insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,       
     CodigoElemento , DescripcionLocal, ValorNumerico,ValorEntero1)      
   SELECT  'CG','999999' ,CodigoFormato,     
    CodigoFormato,Descripcion, TipoFormato , IdFormatoDinamico    
    FROM dbo.SS_HC_Formato WHERE CodigoFormato = @ValorCodigo1    
  select * from @MA_MiscelaneosDetalle         
    --SELECT * FROM MA_MiscelaneosDetalle    
    --SELECT * FROM SS_HC_Formato    
 END    
         
  IF @ACCION ='CODIGO_FORM'      
  BEGIN      
      insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico,ValorCodigo1,DescripcionExtranjera)      
            SELECT  'CG','999999' ,@CodigoTabla, [VERSION], Nombre,  Estado  ,'REG0000','RECURSOS DISPONIBLES'      
   FROM          CM_CO_TablaMaestro        
   WHERE  CM_CO_TablaMaestro.CodigoTabla = @CodigoTabla       
   AND  CM_CO_TablaMaestro.Estado = 2      
   select * from @MA_MiscelaneosDetalle      
   /*     
   insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico,ValorCodigo1,DescripcionExtranjera)      
            SELECT  'CG','999999' ,Accion, IdEpisodioAtencion,persona, Estado_EpisodioAten  ,'REG0000','RECURSOS DISPONIBLES'      
      from  V_EpisodioAtenciones         
      where persona = convert(int,@ValorCodigo1)       
      and IdEpisodioAtencion = convert(int,@ValorCodigo2)    
      */      
   --select * from @MA_MiscelaneosDetalle      
   --select * from SS_HC_Anamnesis_EA      
         
 END 
       
  IF @ACCION ='TITULO_FORM'      
 BEGIN      
    declare @Url as varchar(300), @NombreConcepto as varchar(300),@TipoReg as varchar(100)    
  declare @Remote as varchar(200), @Regtros as integer, @TipoFile as integer    
  select top 1 @Remote =  ValorCodigo1 from dbo.MA_MiscelaneosDetalle     
  where CodigoTabla = 'WSFORM'     
  and CodigoElemento = 'FORMVISTA'    
    
    
  ---select * from SEGURIDADCONCEPTO    
  --  select * from MA_MiscelaneosDetalle    
  select top 1 @Url = WebPage, @NombreConcepto= Descripcion, @TipoReg= Objeto , @TipoFile = TipodeObjeto    
  from SEGURIDADCONCEPTO where Grupo = 'GRUPO018' and Concepto = @CodigoTabla;    
    
  Select @Regtros = isnull(count(*),0) FROM CM_CO_TablaMaestro        
    WHERE  CM_CO_TablaMaestro.CodigoTabla = @CodigoTabla       
    AND  CM_CO_TablaMaestro.Estado = 2     
        
     if (@Regtros > 0)    
      begin    
       insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,       
     CodigoElemento , DescripcionLocal, ValorNumerico,    
     ValorCodigo1,DescripcionExtranjera,    
     ValorCodigo2, ValorCodigo3, ValorCodigo4, ValorEntero1)      
    SELECT  'CG','999999' ,@CodigoTabla,    
        [VERSION], @NombreConcepto,  2,    
      'REG0000','RECURSOS DISPONIBLES' ,    
      @Remote, @Url, @TipoReg, @TipoFile    
    FROM   CM_CO_TablaMaestro        
    WHERE  CM_CO_TablaMaestro.CodigoTabla = @CodigoTabla       
       AND  CM_CO_TablaMaestro.Estado = 2      
      end    
     else    
      begin    
       insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,       
     CodigoElemento , DescripcionLocal, ValorNumerico,    
     ValorCodigo1,DescripcionExtranjera,    
     ValorCodigo2, ValorCodigo3, ValorCodigo4)      
    SELECT  'CG','999999' ,@CodigoTabla, '1', @NombreConcepto,  2,    
      'REG0000','RECURSOS DISPONIBLES' ,    
      @Remote, @Url, @TipoReg    
         
      end    
    
    select * from @MA_MiscelaneosDetalle     
 END 
      
  IF @ACCION ='NIVEL1'      
  BEGIN      
   insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico)      
             SELECT  'CG', '999999', @CodigoTabla,  CM_CO_TablaMaestroConcepto.Concepto,  CM_CO_TablaMaestroConcepto.Nombre ,       
                       CM_CO_TablaMaestroDetalleConcepto.IndicadorConcepto      
   FROM          CM_CO_TablaMaestro INNER JOIN      
          CM_CO_TablaMaestroConcepto ON  CM_CO_TablaMaestro.IdTablaMaestro =  CM_CO_TablaMaestroConcepto.IdTablaMaestro INNER JOIN      
          CM_CO_TablaMaestroDetalle ON  CM_CO_TablaMaestro.IdTablaMaestro =  CM_CO_TablaMaestroDetalle.IdTablaMaestro INNER JOIN      
          CM_CO_TablaMaestroDetalleConcepto ON  CM_CO_TablaMaestroConcepto.IdTablaMaestro =  CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro AND       
          CM_CO_TablaMaestroConcepto.IdConcepto =  CM_CO_TablaMaestroDetalleConcepto.IdConcepto AND       
          CM_CO_TablaMaestroDetalle.IdCodigo =  CM_CO_TablaMaestroDetalleConcepto.IdCodigo AND       
          CM_CO_TablaMaestroDetalle.IdTablaMaestro =  CM_CO_TablaMaestroDetalleConcepto.IdTablaMaestro      
   WHERE  CM_CO_TablaMaestro.CodigoTabla = @CodigoTabla       
   AND     CM_CO_TablaMaestroDetalle.Codigo =  @CodigoElemento       
   AND  CM_CO_TablaMaestroDetalleConcepto.IndicadorConcepto = 1      
   select * from @MA_MiscelaneosDetalle      
          
  END 
       
  IF @ACCION ='NIVEL2'      
  BEGIN      
         
   insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico)      
   Select top 200 'CG','99999', CodigoPadre,CodigoDiagnostico, case tipofolder       
   when 1 then  ltrim(rtrim(Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),IdDiagnostico)))+']'       
   else ltrim(rtrim(Nombre)) end as nombre, tipofolder       
   From SS_GE_Diagnostico  where CodigoPadre = @CodigoElemento --and nombretabla='DD000'      
   AND nombretabla = @CodigoTabla    
      
   insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico , DescripcionExtranjera)      
   Select top 200 'CG','99999', CodigoPadre,CodigoProcedimiento, case tipofolder       
   when 1 then  ltrim(rtrim(Nombre))     
   else ltrim(rtrim(Nombre)) end as nombre,  tipofolder      ,IdProcedimiento 
   From SS_GE_ProcedimientoMedico  where CodigoPadre = @CodigoElemento --and nombretabla='PP000'      
   and nombretabla  = @CodigoTabla     
         
   insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico)      
   Select top 200 'CG','99999', CodigoPadre,CodigoProcedimientoDos ,  case tipofolder       
   when 1 then  ltrim(rtrim(Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),IdProcedimientoDos)))+']'       
   else ltrim(rtrim(Nombre)) end as nombre,  tipofolder       
   From SS_GE_ProcedimientoMedicoDos  where CodigoPadre = @CodigoElemento --and nombretabla='PD000'      
   AND nombretabla = @CodigoTabla    
     
      -- select * from SS_GE_ProcedimientoMedicoDos      
   insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico)      
   Select top 50 'CG','99999', MedicamentoCodigoPadre,MedicamentoCodigo ,  case tipofolder       
   when 1 then  ltrim(rtrim(DescripcionLocal))+'|['+ ltrim(rtrim(Linea))+'-'+ltrim(rtrim(Familia))+'-'+ltrim(rtrim(SubFamilia))+']'       
   else ltrim(rtrim(DescripcionLocal)) end as nombre,  tipofolder       
   From WH_ItemMastTemp      
   where MedicamentoCodigoPadre = @CodigoElemento --and nombretabla='PD000'      
   AND nombretabla = @CodigoTabla    
 --select * from WH_ItemMastTemp WHERE TIPOFOLDER = 1    
    
 insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal, ValorNumerico)      
      Select top 200 'CG','99999', CodigoPadre,Codigo ,  case tipofolder       
      when 1 then  ltrim(rtrim(Descripcion))+'|['+ ltrim(rtrim(Convert(varchar(10),IdCuerpoHumano)))+']'       
      else ltrim(rtrim(Descripcion)) end as nombre,  tipofolder       
      From  SS_HC_CuerpoHumano where CodigoPadre = @CodigoElemento --and nombretabla='PD000'      
   AND nombretabla = @CodigoTabla    
             
    select * from @MA_MiscelaneosDetalle         
    where     
    (    
  (@DescripcionLocal is null  OR @DescripcionLocal =''     
  OR  upper(DescripcionLocal) like '%'+upper(@DescripcionLocal)+'%')     
  and ValorNumerico = 1    
     )    
     OR (ValorNumerico <> 1)    
            
  END       
       
 IF @ACCION ='COMBOSGENERICOS'      
  BEGIN      
   IF (@CodigoTabla='ORDENCERUGIA')      
    BEGIN      
     insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,       
      DescripcionLocal,ValorCodigo1)      
     Select 'CG','99999',  'H', 'H',        
      'Orden de Hospital.', 1      
      union      
      Select 'CG','99999',  'C', 'C',        
      'Cirugía Menor', 2      
    END      
  ELSE IF (@CodigoTabla='IDIOMAVALI')      
  BEGIN      
   select * from MA_MiscelaneosDetalle     
   WHERE Compania='999999'        
   AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
   AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla    
  END        
  ELSE IF (@CodigoTabla='TIPOFLAG')      
  BEGIN      
   select * from MA_MiscelaneosDetalle     
   WHERE Compania='999999'        
   AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
   AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla    
  END         
  ELSE IF (@CodigoTabla='TIPOVALIDA')      
  BEGIN      
   select * from MA_MiscelaneosDetalle     
   WHERE Compania='999999'        
   AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
   AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla    
  END        
  ELSE IF (@CodigoTabla='TIPOAUD')      
  BEGIN      
   select * from MA_MiscelaneosDetalle     
   WHERE Compania='999999'        
   AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
   AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla    
  END        
     ELSE IF (@CodigoTabla='FORMATOS')      
  BEGIN      
   select * from MA_MiscelaneosDetalle     
   WHERE Compania='999999'        
   AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
   AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla     
  END     
  ELSE IF (@CodigoTabla='OBJETOIE')      
  BEGIN      
 select * from MA_MiscelaneosDetalle     
   WHERE Compania='999999'        
   AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
   AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla     
  END     
  ELSE IF (@CodigoTabla='TIPOOBJETO')      
  BEGIN      
   SELECT * FROM MA_MiscelaneosDetalle     
   WHERE Compania='999999'        
   AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
   AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla     
  END       
  ELSE IF (@CodigoTabla='TIPOTABLA')      
  BEGIN      
   SELECT * FROM MA_MiscelaneosDetalle     
   WHERE Compania='999999'        
   AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
   AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla     
  END         
  ELSE IF (@CodigoTabla='TIPOSEXO')      
  BEGIN      
   SELECT * FROM MA_MiscelaneosDetalle     
   WHERE Compania='999999'        
   AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
   AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla      
  END        
  ELSE IF (@CodigoTabla='ESTADOCIVI')      
  BEGIN      
   SELECT * FROM MA_MiscelaneosDetalle     
   WHERE Compania='999999'        
   AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
   AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla      
  END      
  ELSE IF (@CodigoTabla='OBJETOTIPO')      
  BEGIN      
   SELECT * FROM MA_MiscelaneosDetalle     
   WHERE Compania='999999'        
   AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
   AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla      
  END          
   ELSE IF (@CodigoTabla='ESTABLECI')      
   BEGIN      
    insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
    Select 'CG','99999',  CODIGO, IdEstablecimiento, NOMBRE, IdEstablecimiento from CM_CO_Establecimiento       
    select * from @MA_MiscelaneosDetalle      
   END       
   ELSE IF (@CodigoTabla='MEDTRATANTE')      
   BEGIN      
    insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
    Select 'CG','99999',  'H', 'H',  'CALDERON RONDON, Albeto.', 1      
    select * from @MA_MiscelaneosDetalle      
   END           
   ELSE IF (@CodigoTabla='ESPECIALI')      
   BEGIN      
    insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
    Select  'CG','99999',  CODIGO, IdEspecialidad ,  Nombre, IdEspecialidad from dbo.SS_GE_Especialidad   order by  Nombre asc 
    select * from @MA_MiscelaneosDetalle   
   END
   /*****************************/
   
  
   
   ELSE IF (@CodigoTabla='ESPECIALII')      
   BEGIN      
    insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
    Select  'CG','99999',  CODIGO, IdEspecialidad ,  Nombre, IdEspecialidad from SpringSalud_Produccion_Desarrollo.dbo.SS_GE_Especialidad       
    select * from @MA_MiscelaneosDetalle      
   END  
   
   
   
   
   
   /*****************************/      
    --FORMATOCAMPO    
   ELSE IF (@CodigoTabla='SUCURSAL')      
   BEGIN      
    insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
    Select  'CG','99999',  Sucursal, Sucursal ,    DescripcionLocal, Sucursal from ac_sucursal      
    select * from @MA_MiscelaneosDetalle      
   END     
   ELSE IF (@CodigoTabla='SISTEMA')      
   BEGIN      
    insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
    Select  'CG','99999',  Sistema, Sistema ,    Sistema, Sistema from SG_Sistema      
    select * from @MA_MiscelaneosDetalle      
   END     
   ELSE IF (@CodigoTabla='COMPANIA')      
   BEGIN      
    insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
    Select  'CG','999999',  CompaniaCodigo, CompaniaCodigo ,    DescripcionLarga, CompaniaCodigo from companiamast      
    select * from @MA_MiscelaneosDetalle      
   END     
   ELSE IF (@CodigoTabla='FORMATOVALIDADOS')      
   BEGIN      
    insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
    Select  'CG','99999',  IdFormato, IdFormato ,    Descripcion, IdFormato from SS_HC_Formato       
    select * from @MA_MiscelaneosDetalle      
   END     
   ELSE IF (@CodigoTabla='FORMATOCAMPO')      
   BEGIN      
    insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
    Select  'CG','99999',  IdFormato, IdFormato ,    Descripcion, IdFormato from SS_HC_Formato   where modulo = 'hc'    
    select * from @MA_MiscelaneosDetalle      
 END    
 ELSE IF (@CodigoTabla='NUMEROCOMBO')      
 BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
  Select  'CG','99999',  IdFavorito, NumeroFavorito,    Mnemotecnico, NumeroFavorito from SS_HC_FavoritoNumero     
  Where IdFavorito = @ValorCodigo1      
  select * from @MA_MiscelaneosDetalle      
 END      
    ELSE IF (@CodigoTabla='FORMATOCAMPO1')      
 BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
  Select  'CG','99999',  IdFormato, SecuenciaCampo,    ValorPorDefecto, SecuenciaCampo from SS_HC_FormatoCampo      
  Where IdFormato = @ValorCodigo1      
  select * from @MA_MiscelaneosDetalle      
 END                
 ELSE IF (@CodigoTabla='TABLACAMPOFAV')      
    BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
  Select  'CG','99999',  IdFavoritoTabla, IdFavoritoTabla ,    Descripcion, IdFavoritoTabla from SS_HC_Tabla  where tipotabla=1    
  select * from @MA_MiscelaneosDetalle      
    END     
 ELSE IF (@CodigoTabla='TABLACAMPOFAV2')      
    BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
  Select  'CG','99999',  IdFavoritoTabla, IdFavoritoTabla ,    Descripcion, IdFavoritoTabla from SS_HC_Tabla      
  select * from @MA_MiscelaneosDetalle      
    END         
    ELSE IF (@CodigoTabla='TABLACAMPO')      
    BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
  Select  'CG','99999',  IdFavoritoTabla, IdFavoritoTabla ,    Descripcion, NombreTabla from SS_HC_Tabla  where tipotabla=1    
  select * from @MA_MiscelaneosDetalle      
    END    
    ELSE IF (@CodigoTabla='TABLACAMPO1')      
 BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
  Select  'CG','99999',  IdFavoritoTabla, IdCampo,    NombreCampo, IdCampo from SS_HC_TablaCampo      
  Where IdFavoritoTabla = @ValorCodigo1      
  select * from @MA_MiscelaneosDetalle      
 END      
    ELSE IF (@CodigoTabla='COMPONENTEVA')      
    BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
  Select  'CG','99999',  IdComponente, IdComponente ,    Nombre , IdComponente from SS_HC_ControlComponente      
  select * from @MA_MiscelaneosDetalle      
    END        
    ELSE IF (@CodigoTabla='ATRIBUTOVA')      
 BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
  Select  'CG','99999',  IdComponente, IdAtributo ,    NombreAtributo , IdAtributo from VW_SS_HC_TABLAFORMATO_VALIDACION      
  Where IdComponente = @ValorCodigo1      
  select * from @MA_MiscelaneosDetalle      
 END       
 ELSE IF (@CodigoTabla='MEDLINEADOS')      
    BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
  Select  'CG','99999',  Linea, Linea ,    Linea + '' + DescripcionLocal  , Linea from WH_ClaseLinea    
  select * from @MA_MiscelaneosDetalle      
    END    
    ELSE IF (@CodigoTabla='MEDLINEA')      
    BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
  Select  'CG','99999',  Linea, Linea ,    Linea + '' + DescripcionLocal   , Linea     
  from WH_ClaseLinea  where linea in ('04' ,'13')    
  select * from @MA_MiscelaneosDetalle      
    END        
    ELSE IF (@CodigoTabla='MEDFAMILIA')      
 BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
  Select  'CG','99999',  Linea, Familia ,    Familia + '' + DescripcionLocal   , Familia from WH_ClaseFamilia      
  Where Linea = @ValorCodigo1      
  select * from @MA_MiscelaneosDetalle      
 END      
    ELSE IF (@CodigoTabla='MEDUNIDAMED')      
 BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,  DescripcionLocal,ValorCodigo1)      
  SELECT  distinct 'CG','99999',wh_ItemMast.UnidadCodigo, GE_UnidadMedida.IdUnidadMedida,GE_UnidadMedida.Descripcion,GE_UnidadMedida.IdUnidadMedida    
  from wh_ItemMast inner join GE_UnidadMedida     
  ON wh_ItemMast.UnidadCodigo = GE_UnidadMedida.CodigoUnidadMedida    
  WHERE wh_ItemMast.Linea = @ValorCodigo1    
  AND wh_ItemMast.Familia = @ValorCodigo2    
  and wh_ItemMast.SubFamilia = @ValorCodigo3     
  select * from @MA_MiscelaneosDetalle      
 END     
 ELSE IF (@CodigoTabla='MEDSUBFAMILIA')      
    BEGIN      
  if len(@ValorCodigo3)=0 SET @ValorCodigo3 = NULL      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal, ValorCodigo1, ValorCodigo2, ValorCodigo3, ValorCodigo4, ValorCodigo5, ValorCodigo6, ValorCodigo7)      
  Select  'CG','99999',  WH_ClaseSubFamilia.Linea, WH_ClaseSubFamilia.SubFamilia ,    WH_ClaseSubFamilia.DescripcionLocal, WH_ClaseSubFamilia.Linea, WH_ClaseSubFamilia.Familia, WH_ClaseSubFamilia.SubFamilia, WH_ClaseSubFamilia.ItemTipo, WH_ClaseSubFamilia
.Estado,WH_ClaseLinea.DescripcionLocal, WH_ClaseFamilia.DescripcionLocal FROM         dbo.WH_ClaseFamilia INNER JOIN    
  dbo.WH_ClaseLinea ON dbo.WH_ClaseFamilia.Linea = dbo.WH_ClaseLinea.Linea INNER JOIN    
  dbo.WH_ClaseSubFamilia ON dbo.WH_ClaseFamilia.Linea = dbo.WH_ClaseSubFamilia.Linea     
  AND dbo.WH_ClaseFamilia.Familia = dbo.WH_ClaseSubFamilia.Familia    
  Where WH_ClaseSubFamilia.Linea = @ValorCodigo1      
  and  WH_ClaseSubFamilia.Familia = @ValorCodigo2      
  and exists(select 1 from wh_itemmast where wh_itemmast.Linea = WH_ClaseSubFamilia.Linea    
  and wh_itemmast.Familia = WH_ClaseSubFamilia.Familia    
  and wh_itemmast.SubFamilia = WH_ClaseSubFamilia.SubFamilia)    
  and  (@ValorCodigo3 IS NULL OR WH_ClaseSubFamilia.DescripcionLocal LIKE '%'+@ValorCodigo3 + '%')         
  select * from @MA_MiscelaneosDetalle      
    END       
    ELSE IF (@CodigoTabla='RECURSOS')      
    BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
  select 'AS','000',Concepto,IdConcepto, Nombre, IdConcepto  from dbo.CM_CO_TablaMaestroConcepto      
  select * from @MA_MiscelaneosDetalle      
    END     
 ELSE IF (@CodigoTabla='GEVARIOS')      
    BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
  select 'AS','000',Descripcion,Descripcion, CodigoTabla, Descripcion  from dbo.GE_VARIOS      
  select * from @MA_MiscelaneosDetalle      
    END     
    ELSE IF (@CodigoTabla='GRUPO')      
    BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
  Select  'CG','99999',APLICACIONCODIGO,APLICACIONCODIGO,GRUPO,APLICACIONCODIGO from dbo.SEGURIDADGRUPO      
  select * from @MA_MiscelaneosDetalle      
    END     
    ELSE IF (@CodigoTabla='TIPOVIA')      
    BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
  Select  'CG','99999',CodigoTabla, Secuencial,Descripcion,  Secuencial from GE_VARIOS where CodigoTabla = @CodigoTabla     
  and Secuencial <> 0  
  select * from @MA_MiscelaneosDetalle      
    END   
 ELSE IF (@CodigoTabla='TIPALERGIA')      
  BEGIN      
	  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
	  Select  'CG','99999',CodigoTabla, Secuencial,Descripcion,  Secuencial from GE_VARIOS where CodigoTabla = @CodigoTabla     
	  and Secuencial <> 0  
	  select * from @MA_MiscelaneosDetalle      
  END     

 ELSE IF (@CodigoTabla='TIPPARTO')      
  BEGIN      
	  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
	  Select 'CG','99999', CodigoTabla, Secuencial, Descripcion,  Secuencial from GE_VARIOS where CodigoTabla = @CodigoTabla     
	  and Secuencial <> 0  
	  Union 
	  Select 'CG', '99999', 'Seleccione', 0, 'Seleccione', 0 

	  select * from @MA_MiscelaneosDetalle      
  END     	

 ELSE IF (@CodigoTabla='LUGPARTO')      
  BEGIN      
	  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
	  Select  'CG','99999',CodigoTabla, Secuencial,Descripcion,  Secuencial from GE_VARIOS where CodigoTabla = @CodigoTabla     
	  and Secuencial <> 0  
	  select * from @MA_MiscelaneosDetalle      
  END  	  

 ELSE IF (@CodigoTabla='ATENDIDOPOR')      
  BEGIN      
	  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
	  Select  'CG','99999',CodigoTabla, Secuencial,Descripcion,  Secuencial from GE_VARIOS where CodigoTabla = @CodigoTabla     
	  and Secuencial <> 0  
	  select * from @MA_MiscelaneosDetalle      
  END  	 

 ELSE IF (@CodigoTabla='TIPOUNID')      
    BEGIN      
  select * from MA_MiscelaneosDetalle     
  WHERE Compania='999999'        
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla        
 END    
    ELSE IF (@CodigoTabla='ESTADOINT')      
 BEGIN      
  select * from MA_MiscelaneosDetalle     
  WHERE Compania='999999'        
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla        
 END    
 ELSE IF (@CodigoTabla='ESTADOVAR')      
 BEGIN      
  select * from MA_MiscelaneosDetalle     
  WHERE Compania='999999'        
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla        
 END    
 ELSE IF (@CodigoTabla='TIPOSEGURO')      
 BEGIN      
  select * from MA_MiscelaneosDetalle     
  WHERE Compania='999999'        
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla        
 END    
 ELSE IF (@CodigoTabla='TIPOEMPRES')      
 BEGIN      
  select * from MA_MiscelaneosDetalle     
  WHERE Compania='999999'        
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla        
 END    
 ELSE IF (@CodigoTabla='CORREC')      
    BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
  Select  'AW','99999','PAISSELECC', IdSeccionFormato,Descripcion,  IdSeccionFormato from SS_HC_SeccionFormato    
  select * from @MA_MiscelaneosDetalle      
    END     
 ELSE IF (@CodigoTabla='PAISSELECC')      
    BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
  Select  'AW','999999','PAISSELECC', PAIS,DescripcionCorta,  PAIS from pais    
  select * from @MA_MiscelaneosDetalle      
    END     
    ELSE IF (@CodigoTabla='DEPARTAMEN')      
    BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
  Select  'AW','999999','DEPARTAMEN', departamento,departamento + ' - ' + DescripcionCorta,  departamento from departamento    
  select * from @MA_MiscelaneosDetalle      
    END     
    ELSE IF (@CodigoTabla='PROVINCIAS')      
    BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
  Select  'AW','999999','PROVINCIAS', provincia,DescripcionCorta,  provincia from provincia    
  select * from @MA_MiscelaneosDetalle      
    END     
    ELSE IF (@CodigoTabla='DISTRITO')      
    BEGIN      
    insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
    Select  'AW','999999','DISTRITO', Provincia,DescripcionCorta,  CODIGOPOSTAL from ZONAPOSTAL    
    --  select * from @MA_MiscelaneosDetalle      
    END     
    ELSE IF (@CodigoTabla='FAVORITOLISTA')      
    BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
  Select 'AW','99999', 'FAVORITOLISTA', IdFavorito, Descripcion, IdFavorito  FROM ss_hc_favorito        
  where (@ValorCodigo3 is null or IdAgente =  @ValorCodigo3)    
  select * from @MA_MiscelaneosDetalle      
    END    
    ELSE IF (@CodigoTabla='TIPOMEDICO')      
 BEGIN      
  select * from MA_MiscelaneosDetalle     
  WHERE Compania='999999'        
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla        
 END    
 ELSE IF (@CodigoTabla='SITUACIONE')      
 BEGIN      
  select * from MA_MiscelaneosDetalle     
  WHERE Compania='999999'        
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla        
 END    
    ELSE IF (@CodigoTabla='TIPOCOBERT')      
 BEGIN      
  select * from MA_MiscelaneosDetalle     
  WHERE Compania='999999'        
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla        
 END    
 ELSE IF (@CodigoTabla='INDICADORE')      
 BEGIN      
  select * from MA_MiscelaneosDetalle     
  WHERE Compania='999999'        
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla        
 END    
 ELSE IF (@CodigoTabla='TIPOFORMAT')      
 BEGIN      
  select * from MA_MiscelaneosDetalle     
  WHERE Compania='999999'        
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla        
 END    
 ELSE IF (@CodigoTabla='TIPOPERSON')      
 BEGIN      
  select * from MA_MiscelaneosDetalle     
  WHERE Compania='999999'        
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla        
 END    
 ELSE IF (@CodigoTabla='TIPODOCUME')      
 BEGIN      
  select * from MA_MiscelaneosDetalle     
  WHERE Compania='999999'        
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla        
 END    
 ELSE IF (@CodigoTabla='TIPOSEXO')      
 BEGIN      
  select * from MA_MiscelaneosDetalle     
  WHERE Compania='999999'        
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla        
 END    
 ELSE IF (@CodigoTabla='TIPOASIGNA')      
 BEGIN      
  select * from MA_MiscelaneosDetalle     
  WHERE Compania='999999'        
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla        
 END    
 ELSE IF (@CodigoTabla='NIVELENTER')      
 BEGIN      
  select * from MA_MiscelaneosDetalle     
  WHERE Compania='999999'        
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla        
 END      
 ELSE IF (@CodigoTabla='TIPOFAVORI')      
    BEGIN      
  SELECT * FROM MA_MiscelaneosDetalle     
  WHERE Compania='999999'        
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla    
    END     
    ELSE IF (@CodigoTabla='TIPOAGENTE')      
    BEGIN      
  SELECT * FROM MA_MiscelaneosDetalle     
  WHERE Compania='999999'        
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla    
    END     
    ELSE IF (@CodigoTabla='TIPOREGMED')      
    BEGIN      
  SELECT * FROM MA_MiscelaneosDetalle     
  WHERE Compania='999999'        
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla     
    END     
    ELSE IF (@CodigoTabla='INDIRECETA')      
    BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
  Select  'CG','99999',CodigoTabla, Secuencial,Descripcion,  Secuencial    
  from GE_VARIOS where CodigoTabla = @CodigoTabla     
  select * from @MA_MiscelaneosDetalle      
    END     
  ELSE IF (@CodigoTabla='MEDPARENTES')      
	 BEGIN      
	  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal, ValorCodigo1 )      
	  Select  'CG', '99999',  CodigoTabla, Secuencial,  Descripcion,  Secuencial  FROM GE_Varios    
	  WHERE CodigoTabla = 'TIPOPARENTESCO' 	       
	  and  Secuencial <>0 
	  Union 
	  Select 'CG', '99999', 'Seleccione', 0, 'Seleccione', 0    
	  select * from @MA_MiscelaneosDetalle      
	 END       
    ELSE IF (@CodigoTabla='TPOPCIONVA')      
 BEGIN      
  SELECT * FROM MA_MiscelaneosDetalle     
  WHERE Compania='999999'        
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla    
 END              
    ELSE IF (@CodigoTabla='TPOPCIONIC')      
 BEGIN      
  SELECT * FROM MA_MiscelaneosDetalle     
  WHERE Compania='999999'        
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla    
 END         
    ELSE IF (@CodigoTabla='TPOPCIONPR')      
 BEGIN      
  SELECT * FROM MA_MiscelaneosDetalle     
  WHERE Compania='999999'        
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla    
 END                       
    ELSE IF (@CodigoTabla='TIPODATO')      
 BEGIN      
  SELECT * FROM MA_MiscelaneosDetalle     
  WHERE Compania='999999'        
  AND (MA_MiscelaneosDetalle.AplicacionCodigo = 'WA')    
  AND MA_MiscelaneosDetalle.CodigoTabla = @CodigoTabla    
 END      
    ELSE IF (@CodigoTabla='SISTEMA')      
 BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
  Select  'CG','99999',Sistema, Sistema,Nombre,  Sistema from dbo.SG_Sistema     
  where Estado =2    
  select * from @MA_MiscelaneosDetalle      
 END       
    ELSE IF (@CodigoTabla='MODULO')      
 BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
  Select  'CG','99999',Sistema,Modulo,Nombre,  Modulo from dbo.SG_Modulo     
  where Estado =2    
  and (@ValorCodigo1 is null or Sistema = @ValorCodigo1 or @ValorCodigo1 = '')    
  select * from @MA_MiscelaneosDetalle      
 END                     
    ELSE IF (@CodigoTabla='COMPANY')      
 BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
  Select  'CG','99999',company,companyowner,description,  companyowner    
  from companyowner     
  inner join CompaniaMast on (substring(CompaniaMast.CompaniaCodigo,1,6)=substring(companyowner.companyowner,1,6) )    
  where CompaniaMast.Estado ='A'       
  select * from @MA_MiscelaneosDetalle      
 END 
 ELSE IF (@CodigoTabla='COMBMINSA')      
 BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
  Select  'CG','99999',codigo,IdUnidadMedida,Nombre, IdUnidadMedida from SS_HC_UnidadMedidaMinsa         
  where Estado =2     
  select * from @MA_MiscelaneosDetalle   
  
  End                         
    ELSE IF (@CodigoTabla='TIPOATENCION')      
 BEGIN         
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
  Select  'CG','99999',codigo,IdTipoAtencion,Descripcion,  IdTipoAtencion from SS_GE_TipoAtencion         
  where Estado =2         
  select * from @MA_MiscelaneosDetalle      
 END    
    ELSE IF (@CodigoTabla='TIPOTRABAJADOR')      
 BEGIN         
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,CodigoElemento ,   DescripcionLocal,ValorCodigo1)      
  Select  'CG','99999',TipoTrabajador,TipoTrabajador,DescripcionLocal,  TipoTrabajador from SS_TipoTrabajador         
  where Estado ='A'         
  select * from @MA_MiscelaneosDetalle      
 END           
    ELSE                  
    BEGIN      
	insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal,ValorCodigo1)      
	  Select 'CG','99999',  CM_CO_TablaMaestro.CodigoTabla,  CM_CO_TablaMaestroDetalle.Codigo,   CM_CO_TablaMaestroDetalle.Nombre, CM_CO_TablaMaestroDetalle.IdCodigo   FROM   CM_CO_TablaMaestro INNER JOIN      
	  CM_CO_TablaMaestroDetalle ON CM_CO_TablaMaestro.IdTablaMaestro = CM_CO_TablaMaestroDetalle.IdTablaMaestro      
	  Where  CodigoTabla =@CodigoTabla and CM_CO_TablaMaestroDetalle.Estado = 2   
		union 
		 Select 'CG','99999', 'Seleccione', 'Seleccione', 'Seleccione', 0  
	  order by 6 asc   
    END      
  select * from @MA_MiscelaneosDetalle      
 END   
    
 IF @ACCION ='UNIDADPRESENTACION'      
 BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,     CodigoElemento , DescripcionLocal,ValorCodigo1)      
  SELECT  distinct 'CG','99999',wh_ItemMast.UnidadCodigo, GE_UnidadMedida.IdUnidadMedida,GE_UnidadMedida.Descripcion,GE_UnidadMedida.IdUnidadMedida from wh_ItemMast inner join     
  GE_UnidadMedida ON wh_ItemMast.UnidadCodigo = GE_UnidadMedida.CodigoUnidadMedida    
  select * from @MA_MiscelaneosDetalle      
 END 
      
 IF @ACCION ='UNIDADTIEMPO'      
 BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento , DescripcionLocal,ValorCodigo1)      
  Select 'CG','99999', 'UNIDAPRESENT',    CodigoUnidadMedida, Descripcion, IdUnidadMedida  from dbo.SS_HC_UnidadMedida       
  WHERE IdUnidadMedida >=81  AND IdUnidadMedida<= 85      
  AND   ESTADO = 2      
  select * from @MA_MiscelaneosDetalle      
 END   
   
 IF @ACCION ='DIAGNOSTICO'      
 BEGIN      
  insert into @MA_MiscelaneosDetalle (  AplicacionCodigo, ValorEntero1,   ValorEntero2, ValorEntero3,  ValorCodigo1,  ValorCodigo2, ValorCodigo3,  ValorCodigo4, ValorCodigo5,  ValorEntero5, ValorEntero6,  ValorEntero7, ValorCodigo6,  Estado, CodigoTabla, 
  
Compania,CodigoElemento)      
  SELECT      SS_HC_Diagnostico.UnidadReplicacion,  SS_HC_Diagnostico.IdPaciente,  SS_HC_Diagnostico.EpisodioClinico,   SS_HC_Diagnostico.IdEpisodioAtencion,     
  ltrim(rtrim(SS_GE_Diagnostico.Descripcion))+'|['+ ltrim(rtrim(Convert(varchar(10),SS_HC_Diagnostico.IdDiagnostico)))+']',   DeterminacionDiagnostica,IdDiagnosticoPrincipal,  GradoAfeccion, TipoAntecedente, IndicadorPreExistencia, IndicadorCronico, IndicadorNuevo, SS_HC_Diagnostico.Observacion,  SS_HC_Diagnostico.Estado,  SS_HC_Diagnostico.Accion,'0000', SS_HC_Diagnostico.Secuencia  FROM        SS_GE_Diagnostico INNER JOIN      SS_HC_Diagnostico ON  SS_GE_Diagnostico.IdDiagnostico =  SS_HC_Diagnostico.IdDiagnostico      
  WHERE   SS_HC_Diagnostico.IdPaciente =@ValorCodigo1       
  AND   SS_HC_Diagnostico.EpisodioClinico = @ValorCodigo2        
  AND   SS_HC_Diagnostico.IdEpisodioAtencion = @ValorCodigo3      
  AND   ltrim(rtrim(SS_HC_Diagnostico.UnidadReplicacion)) = ltrim(rtrim(@ValorCodigo5))  
  select * from @MA_MiscelaneosDetalle      
 END  
 IF @ACCION ='DIAGNOSTICONANDAPAE'      
 BEGIN      
  insert into @MA_MiscelaneosDetalle (  AplicacionCodigo, ValorEntero1,   ValorEntero2, ValorEntero3,  ValorCodigo1,  ValorCodigo2, ValorCodigo3,  ValorCodigo4, ValorCodigo5,  ValorEntero5, ValorEntero6,  ValorEntero7, ValorCodigo6,  Estado, CodigoTabla, 
  
Compania,CodigoElemento)      
  SELECT   SS_HC_PAE_Diagnostico.UnidadReplicacion,  SS_HC_PAE_Diagnostico.IdPaciente,  SS_HC_PAE_Diagnostico.EpisodioClinico,   SS_HC_PAE_Diagnostico.IdEpisodioAtencion,     
  ltrim(rtrim(SS_HC_PAE_Diagnostico.Observacion))+'|['+ ltrim(rtrim(Convert(varchar(10),
  SS_HC_PAE_Diagnostico.SecuenciaPAE)))+']',
  UnidadReplicacion,IdPaciente, 
  EpisodioClinico, IdEpisodioAtencion, IdClasePAE,
  IdNanda, IdDominioPAE, 
  SS_HC_PAE_Diagnostico.Observacion, 
  SS_HC_PAE_Diagnostico.Estado, 
  'CCEP9915','0000',
  SS_HC_PAE_Diagnostico.SecuenciaPAE  FROM     
  SS_HC_PAE_Diagnostico    
  WHERE   SS_HC_PAE_Diagnostico.IdPaciente =@ValorCodigo1       
  AND   SS_HC_PAE_Diagnostico.EpisodioClinico = @ValorCodigo2        
  AND   SS_HC_PAE_Diagnostico.IdEpisodioAtencion = @ValorCodigo3      
  AND   ltrim(rtrim(SS_HC_PAE_Diagnostico.UnidadReplicacion)) = ltrim(rtrim(@ValorCodigo5))  
  select * from @MA_MiscelaneosDetalle      
 END  

IF @ACCION ='DIAGNOSTICOFE'      
 BEGIN      
  insert into @MA_MiscelaneosDetalle (  AplicacionCodigo, ValorEntero1,   ValorEntero2, ValorEntero3,  ValorCodigo1,  ValorCodigo2, ValorCodigo3,  ValorCodigo4, ValorCodigo5,  
  ValorEntero5, ValorEntero6,  ValorEntero7, ValorCodigo6,  Estado, CodigoTabla,  ValorCodigo7 , 
  Compania,CodigoElemento)      
  SELECT      SS_HC_Diagnostico.UnidadReplicacion,  SS_HC_Diagnostico.IdPaciente,  SS_HC_Diagnostico.EpisodioClinico,   SS_HC_Diagnostico.IdEpisodioAtencion,     
  ltrim(rtrim(SS_GE_Diagnostico.Descripcion))+'|['+ ltrim(rtrim(Convert(varchar(10),SS_HC_Diagnostico.IdDiagnostico)))+']',   DeterminacionDiagnostica,IdDiagnosticoPrincipal,  
  GradoAfeccion, TipoAntecedente, IndicadorPreExistencia, IndicadorCronico, IndicadorNuevo, 
  SS_HC_Diagnostico.Observacion,  SS_HC_Diagnostico.Estado,  SS_HC_Diagnostico.Accion, ltrim(rtrim(SS_GE_Diagnostico.Descripcion))+'|['+ ltrim(rtrim(Convert(varchar(10),SS_GE_Diagnostico.CodigoDiagnostico)))+']' ,'0000', SS_HC_Diagnostico.Secuencia 
  FROM        SS_GE_Diagnostico 
  INNER JOIN   SS_HC_Diagnostico_FE  AS SS_HC_Diagnostico ON  SS_GE_Diagnostico.IdDiagnostico =  SS_HC_Diagnostico.IdDiagnostico      
  WHERE   SS_HC_Diagnostico.IdPaciente =@ValorCodigo1       
  AND   SS_HC_Diagnostico.EpisodioClinico = @ValorCodigo2        
  AND   SS_HC_Diagnostico.IdEpisodioAtencion = @ValorCodigo3      
  AND   ltrim(rtrim(SS_HC_Diagnostico.UnidadReplicacion)) = ltrim(rtrim(@ValorCodigo5))  
  select * from @MA_MiscelaneosDetalle      
 END  
IF @ACCION ='HOJANACIDO'      
 BEGIN      
  insert into @MA_MiscelaneosDetalle (  AplicacionCodigo, ValorEntero1,   ValorEntero2, ValorEntero3,  ValorCodigo1,  
ValorCodigo2, ValorCodigo3,  ValorEntero4,   ValorEntero5, ValorEntero6, ValorEntero7,  
  Estado, CodigoTabla,   Compania,CodigoElemento)      
 SELECT      B.UnidadReplicacion,  B.IdPaciente,  B.EpisodioClinico,   B.IdEpisodioAtencion, A.TIEMPO,  
  A.FRECUENCIA,A.ESFUERZO,A.TONO,A.IRRITABILIDAD,A.COLOR,A.TOTAL,
  A.Estado,  B.Accion,'0000', A.IDSecuencia 
  FROM     SS_HC_HojaRecienNacidoDetalle_FE  A   
  INNER JOIN   SS_HC_HojaRecienNacido_FE  AS B ON  A.IdRecienNacido =  B.IdRecienNacido 
	AND A.UnidadReplicacion	=B.UnidadReplicacion	AND A.IdPaciente		= B.IdPaciente 
	AND A.EpisodioClinico	=B.EpisodioClinico		AND A.IdEpisodioAtencion= B.IdEpisodioAtencion
	  WHERE   B.IdPaciente =@ValorCodigo1       
  AND   B.EpisodioClinico = @ValorCodigo2        
  AND   B.IdEpisodioAtencion = @ValorCodigo3      
  AND   ltrim(rtrim(B.UnidadReplicacion)) = ltrim(rtrim(@ValorCodigo5))  
  select * from @MA_MiscelaneosDetalle      
 END  

 IF @ACCION ='ANTEC_FAMILIARES'      
 BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, ValorEntero1,   ValorEntero2, ValorEntero3,  ValorEntero7, ValorEntero4,   ValorCodigo1,ValorCodigo2,  ValorCodigo3,ValorCodigo4,  CodigoTabla, Compania,CodigoElemento)      
  SELECT SS_HC_Anamnesis_AF_Enfermedad.UnidadReplicacion,  SS_HC_Anamnesis_AF_Enfermedad.IdPaciente,  SS_HC_Anamnesis_AF_Enfermedad.EpisodioClinico,   SS_HC_Anamnesis_AF_Enfermedad.IdEpisodioAtencion,     
  SS_HC_Anamnesis_AF_Enfermedad.Secuencia,  SS_HC_Anamnesis_AF_Enfermedad.IdDiagnostico,   SS_HC_Anamnesis_AF_Enfermedad.Secuencia,  ltrim(rtrim(SS_GE_Diagnostico.Descripcion))+'|['+ ltrim(rtrim(Convert(varchar(10),SS_HC_Anamnesis_AF_Enfermedad.IdDiagnostico)))+']',   SS_HC_Anamnesis_AF_Enfermedad.Observaciones,'', 'CCEP0005','0000', SS_HC_Anamnesis_AF_Enfermedad.Secuencia      
  FROM        SS_HC_Anamnesis_AF_Enfermedad INNER JOIN      
  SS_GE_Diagnostico ON  SS_GE_Diagnostico.IdDiagnostico =  SS_HC_Anamnesis_AF_Enfermedad.IdDiagnostico      
  WHERE SS_HC_Anamnesis_AF_Enfermedad.IdPaciente =@ValorCodigo1       
  AND  SS_HC_Anamnesis_AF_Enfermedad.EpisodioClinico = @ValorCodigo2        
  AND  SS_HC_Anamnesis_AF_Enfermedad.IdEpisodioAtencion = @ValorCodigo3        
  AND   SS_HC_Anamnesis_AF_Enfermedad.UnidadReplicacion = @ValorCodigo4    
  select * from @MA_MiscelaneosDetalle      
 END   
     
 IF @ACCION ='ANTEC_FAMILIARES_ALT'      
 BEGIN       
  insert into @MA_MiscelaneosDetalle 
  (AplicacionCodigo, ValorEntero1,   ValorEntero2, ValorEntero3,  
  ValorEntero7, ValorEntero4,   ValorCodigo1,ValorCodigo2,  
  ValorCodigo3,ValorCodigo4,  CodigoTabla, Compania,CodigoElemento,
  ValorEntero5
  )      
  SELECT SS_HC_Anamnesis_AFAM_Enfermedad.UnidadReplicacion,  
  SS_HC_Anamnesis_AFAM_Enfermedad.IdPaciente,  
  SS_HC_Anamnesis_AFAM_Enfermedad.EpisodioClinico,   SS_HC_Anamnesis_AFAM_Enfermedad.IdEpisodioAtencion,     
  SS_HC_Anamnesis_AFAM_Enfermedad.Secuencia,  SS_HC_Anamnesis_AFAM_Enfermedad.IdDiagnostico,   
  SS_HC_Anamnesis_AFAM_Enfermedad.Secuencia,    
  ltrim(rtrim(SS_GE_Diagnostico.Descripcion))+'|['+ ltrim(rtrim(Convert(varchar(10),SS_HC_Anamnesis_AFAM_Enfermedad.IdDiagnostico)))+']',   SS_HC_Anamnesis_AFAM_Enfermedad.Observaciones,'', 
  'CCEPF014','0000', SS_HC_Anamnesis_AFAM_Enfermedad.Secuencia,
  SS_HC_Anamnesis_AFAM_Enfermedad.SecuenciaFamilia
  FROM        SS_HC_Anamnesis_AFAM_Enfermedad INNER JOIN      
  SS_GE_Diagnostico ON  (SS_GE_Diagnostico.IdDiagnostico =  SS_HC_Anamnesis_AFAM_Enfermedad.IdDiagnostico  )   
  WHERE SS_HC_Anamnesis_AFAM_Enfermedad.IdPaciente =@ValorCodigo1       
  AND  SS_HC_Anamnesis_AFAM_Enfermedad.EpisodioClinico = @ValorCodigo2        
  AND  SS_HC_Anamnesis_AFAM_Enfermedad.IdEpisodioAtencion = @ValorCodigo3        
  AND   SS_HC_Anamnesis_AFAM_Enfermedad.UnidadReplicacion = @ValorCodigo4    
  AND  SS_HC_Anamnesis_AFAM_Enfermedad.SecuenciaFamilia = @ValorNumerico



  
  select * from @MA_MiscelaneosDetalle      
 END   
 
 IF @ACCION ='ANTEC_FAMILIARES_ALT_FE'      
 BEGIN       
  insert into @MA_MiscelaneosDetalle 
  (
	  AplicacionCodigo, 
	  ValorEntero1, ValorEntero2, ValorEntero3,  
	  ValorEntero7, ValorEntero4, 
	  ValorCodigo1,
	  ValorCodigo2,  
	  ValorCodigo5, 
	  ValorCodigo3, ValorCodigo4,  
	  CodigoTabla, Compania, CodigoElemento,
	  ValorEntero5
  )      
  SELECT 
	  SS_HC_Anamnesis_AFAM_Enfermedad_FE.UnidadReplicacion,  
	  SS_HC_Anamnesis_AFAM_Enfermedad_FE.IdPaciente, SS_HC_Anamnesis_AFAM_Enfermedad_FE.EpisodioClinico, SS_HC_Anamnesis_AFAM_Enfermedad_FE.IdEpisodioAtencion,     
	  SS_HC_Anamnesis_AFAM_Enfermedad_FE.Secuencia,  SS_HC_Anamnesis_AFAM_Enfermedad_FE.IdDiagnostico,   
	  SS_HC_Anamnesis_AFAM_Enfermedad_FE.Secuencia,    
	  ltrim(rtrim(SS_GE_Diagnostico.Descripcion))+'|['+ ltrim(rtrim(Convert(varchar(10), SS_GE_Diagnostico.IdDiagnostico )))+']', 
	  ltrim(rtrim(SS_GE_Diagnostico.Descripcion))+'|['+ ltrim(rtrim(Convert(varchar(10), SS_GE_Diagnostico.CodigoDiagnostico)))+']', 
	  SS_HC_Anamnesis_AFAM_Enfermedad_FE.Observaciones,'', 
	  'CCEP0005','0000', SS_HC_Anamnesis_AFAM_Enfermedad_FE.Secuencia,
	  SS_HC_Anamnesis_AFAM_Enfermedad_FE.SecuenciaFamilia
  FROM  SS_HC_Anamnesis_AFAM_Enfermedad_FE 
	INNER JOIN SS_GE_Diagnostico 
		ON  SS_GE_Diagnostico.IdDiagnostico =  SS_HC_Anamnesis_AFAM_Enfermedad_FE.IdDiagnostico      
  WHERE SS_HC_Anamnesis_AFAM_Enfermedad_FE.IdPaciente =@ValorCodigo1       
	  AND  SS_HC_Anamnesis_AFAM_Enfermedad_FE.EpisodioClinico = @ValorCodigo2        
	  AND  SS_HC_Anamnesis_AFAM_Enfermedad_FE.IdEpisodioAtencion = @ValorCodigo3        
	  AND  SS_HC_Anamnesis_AFAM_Enfermedad_FE.UnidadReplicacion = @ValorCodigo4    
	  AND  SS_HC_Anamnesis_AFAM_Enfermedad_FE.SecuenciaFamilia = @ValorNumerico
  
  select * from @MA_MiscelaneosDetalle      
 END 
 IF @ACCION ='ENFERMEACTUAL'      
 BEGIN                          
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, ValorEntero1,   ValorEntero2, ValorEntero3,  ValorCodigo1,    CodigoTabla, Compania,CodigoElemento)      
  SELECT  SS_HC_Anamnesis_EA_Sintoma.UnidadReplicacion,  SS_HC_Anamnesis_EA_Sintoma.IdPaciente,  SS_HC_Anamnesis_EA_Sintoma.EpisodioClinico,   SS_HC_Anamnesis_EA_Sintoma.IdEpisodioAtencion,   ltrim(rtrim(SS_GE_ProcedimientoMedicoDos.Nombre))
  +'|['+ ltrim(rtrim(Convert(varchar(10),SS_HC_Anamnesis_EA_Sintoma.IdCIAP2)))+']',   'CCEP0003','0000', SS_HC_Anamnesis_EA_Sintoma.Secuencia      
  FROM SS_HC_Anamnesis_EA_Sintoma INNER JOIN      
  SS_GE_ProcedimientoMedicoDos ON        
  SS_GE_ProcedimientoMedicoDos.IdProcedimientoDos =  SS_HC_Anamnesis_EA_Sintoma.IdCIAP2      
  WHERE  SS_HC_Anamnesis_EA_Sintoma.IdPaciente =@ValorCodigo1       
  AND  SS_HC_Anamnesis_EA_Sintoma.IdEpisodioAtencion = @ValorCodigo2       
  AND  SS_HC_Anamnesis_EA_Sintoma.EpisodioClinico = @ValorCodigo3       
  AND  substring(SS_HC_Anamnesis_EA_Sintoma.UnidadReplicacion,1,4) = substring(@ValorCodigo4,1,4)    
  select * from @MA_MiscelaneosDetalle      
 END

 -- Formulario Extras -> Visualizar grilla
 -- F2 -Alergia
IF @ACCION ='ALERGIA'          
 BEGIN                          
  Insert into @MA_MiscelaneosDetalle (
	  CodigoElemento,
	  ValorEntero1, 
	  ValorCodigo1,  
	  ValorFecha,
	  ValorEntero2, 
	  ValorCodigo2,

	  AplicacionCodigo,
	  ValorEntero3,   
	  ValorEntero4,
	  ValorEntero5,    
	  CodigoTabla, 
	  Compania)      
  Select  
	  SS_HC_AlergiaDetalle_FE.Secuencia,
	  SS_HC_AlergiaDetalle_FE.IdTipoAlergia,
	  (case when SS_HC_AlergiaDetalle_FE.TipoRegistro  ='RE' 
		then 
			(case when WH_ItemMast.Item IS NOT NULL 
			then 
				ltrim(rtrim(WH_ItemMast.DescripcionLocal)) +'|[' + ltrim(rtrim(WH_ItemMast.Linea))+'-'+ ltrim(rtrim(WH_ItemMast.Familia))+'-'+ ltrim(rtrim(WH_ItemMast.SubFamilia))+'-'+ ltrim(rtrim(WH_ItemMast.Item))+']' 
			else
				ltrim(rtrim(WH_ClaseSubFamilia.DescripcionLocal)) +'|[' + ltrim(rtrim(WH_ClaseSubFamilia.Linea))+'-'+ ltrim(rtrim(WH_ClaseSubFamilia.Familia))+'-'+ ltrim(rtrim(WH_ClaseSubFamilia.SubFamilia))+']' 
			end
			)
		else 
			SS_HC_AlergiaDetalle_FE.DescripcionManual
		end
	  ),
	  SS_HC_AlergiaDetalle_FE.DesdeCuando,
	  SS_HC_AlergiaDetalle_FE.EstudioAlegista,
	  SS_HC_AlergiaDetalle_FE.Observaciones,

	  SS_HC_AlergiaDetalle_FE.UnidadReplicacion, 
	  SS_HC_AlergiaDetalle_FE.IdPaciente,  
	  SS_HC_AlergiaDetalle_FE.EpisodioClinico, 
	  SS_HC_AlergiaDetalle_FE.IdEpisodioAtencion,	  
	  'CCEP00F2',
	  '0000'
  From SS_HC_AlergiaDetalle_FE 
		left join    WH_ItemMast 
			ON 	WH_ItemMast.Item =  SS_HC_AlergiaDetalle_FE.CodigoComponente
		left join    WH_ClaseSubFamilia 
			ON 	WH_ClaseSubFamilia.Linea =  SS_HC_AlergiaDetalle_FE.Linea and WH_ClaseSubFamilia.Familia =  SS_HC_AlergiaDetalle_FE.Familia and WH_ClaseSubFamilia.SubFamilia =  SS_HC_AlergiaDetalle_FE.SubFamilia
   
  Where  SS_HC_AlergiaDetalle_FE.IdPaciente =@ValorCodigo1       
	  And SS_HC_AlergiaDetalle_FE.IdEpisodioAtencion = @ValorCodigo2       
	  And SS_HC_AlergiaDetalle_FE.EpisodioClinico = @ValorCodigo3       
	  And substring(SS_HC_AlergiaDetalle_FE.UnidadReplicacion,1,4) = substring(@ValorCodigo4,1,4)  
	  And ( @ValorCodigo5 is null or SS_HC_AlergiaDetalle_FE.TipoRegistro = @ValorCodigo5 )
	    
  Select * from @MA_MiscelaneosDetalle     
 END

           
 IF @ACCION ='PROBLEMAS'      
 BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, ValorEntero1,   ValorEntero2, ValorEntero3,  ValorFecha,  ValorCodigo2, ValorCodigo3, ValorCodigo4,ValorCodigo5,  CodigoTabla, Compania,CodigoElemento)      
  SELECT      SS_HC_Problema.UnidadReplicacion,  SS_HC_Problema.IdPaciente, SS_HC_Problema.EpisodioClinico,   SS_HC_Problema.IdEpisodioAtencion,   SS_HC_Problema.Fecha,  SS_HC_Problema.IdTipoProblemaDiag, ltrim(rtrim(SS_GE_Diagnostico.Descripcion))+'|['+ 
  
ltrim(rtrim(Convert(varchar(10),SS_HC_Problema.IdDiagnostico)))+']',   SS_HC_Problema.IdControlado, SS_HC_Problema.Observacion,  SS_HC_Problema.Accion,'0000', SS_HC_Problema.Secuencia      
  FROM        SS_HC_Problema INNER JOIN      
  SS_GE_Diagnostico ON  SS_GE_Diagnostico.IdDiagnostico =  SS_HC_Problema.IdDiagnostico      
  WHERE   SS_HC_Problema.IdPaciente =@ValorCodigo1       
  AND   SS_HC_Problema.EpisodioClinico = @ValorCodigo2        
  AND   SS_HC_Problema.IdEpisodioAtencion = @ValorCodigo3       
  AND   SS_HC_Problema.TipoProblema = @ValorCodigo4       
  select * from @MA_MiscelaneosDetalle      
 END  
       
 IF @ACCION ='EXAMENES'      
	 BEGIN      
	 if(@ValorCodigo5='C')
	 begin
		 insert into @MA_MiscelaneosDetalle 
		  (  AplicacionCodigo, ValorEntero1,   ValorEntero2, ValorEntero3,  ValorFecha,  ValorCodigo1,  ValorCodigo3,  ValorCodigo4,  CodigoTabla, Compania,
		  CodigoElemento
		  ,ValorCodigo5, ValorEntero6
		  ,ValorEntero7, ValorCodigo6,ValorCodigo7,
		  ValorCodigo2
		  )      
		  SELECT      
		  SS_HC_ExamenSolicitado.UnidadReplicacion,  SS_HC_ExamenSolicitado.IdPaciente, SS_HC_ExamenSolicitado.EpisodioClinico,   SS_HC_ExamenSolicitado.IdEpisodioAtencion,   SS_HC_ExamenSolicitado.FechaSolitada,     
		  ltrim(rtrim(SS_GE_ProcedimientoMedico.Descripcion))+'|['+ ltrim(rtrim(Convert(varchar(10),SS_HC_ExamenSolicitado.IdProcedimiento)))+']',   SS_HC_ExamenSolicitado.IdEspecialidad,  SS_HC_ExamenSolicitado.Observacion,  
		  SS_HC_ExamenSolicitado.Accion,'0000',
		  SS_HC_ExamenSolicitado.Secuencia  
		  ,SS_HC_ExamenSolicitado.IdProcedimiento,  SS_HC_ExamenSolicitado.Cantidad    
		  ,SS_HC_ExamenSolicitado.IndicadorEPS,SS_HC_ExamenSolicitado.TipoCodigo,SS_HC_ExamenSolicitado.CodigoSegus,
		  SS_HC_ExamenSolicitado.CodigoComponente
		  FROM        SS_HC_ExamenSolicitado INNER JOIN      
		  SS_GE_ProcedimientoMedico ON  SS_GE_ProcedimientoMedico.IdProcedimiento =  SS_HC_ExamenSolicitado.IdProcedimiento      
		  WHERE   SS_HC_ExamenSolicitado.IdPaciente =@ValorCodigo1       
		  AND   SS_HC_ExamenSolicitado.EpisodioClinico = @ValorCodigo2        
		  AND   SS_HC_ExamenSolicitado.IdEpisodioAtencion = @ValorCodigo3      
		  AND   SS_HC_ExamenSolicitado.UnidadReplicacion = @ValorCodigo4    
		  AND   SS_HC_ExamenSolicitado.TipoCodigo = 'C'
	 end
	 else
	 begin
		
		  insert into @MA_MiscelaneosDetalle 
		  (  AplicacionCodigo, ValorEntero1,   ValorEntero2, ValorEntero3,  ValorFecha,  ValorCodigo1,  ValorCodigo3,  ValorCodigo4,  CodigoTabla, Compania,
		  CodigoElemento
		  ,ValorCodigo5, ValorEntero6
		  ,ValorEntero7, ValorCodigo6,ValorCodigo7
		  )      
		  SELECT      
		  SS_HC_ExamenSolicitado.UnidadReplicacion,  SS_HC_ExamenSolicitado.IdPaciente, SS_HC_ExamenSolicitado.EpisodioClinico,   SS_HC_ExamenSolicitado.IdEpisodioAtencion,   SS_HC_ExamenSolicitado.FechaSolitada,     
		  ltrim(rtrim(CM_CO_Componente.Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),SS_HC_ExamenSolicitado.IdProcedimiento)))+']',   SS_HC_ExamenSolicitado.IdEspecialidad,  SS_HC_ExamenSolicitado.Observacion,  
		  SS_HC_ExamenSolicitado.Accion,'0000',
		  SS_HC_ExamenSolicitado.Secuencia  
		  ,SS_HC_ExamenSolicitado.IdProcedimiento,  SS_HC_ExamenSolicitado.Cantidad    
		  ,SS_HC_ExamenSolicitado.IndicadorEPS,SS_HC_ExamenSolicitado.TipoCodigo,SS_HC_ExamenSolicitado.CodigoSegus
		  FROM        SS_HC_ExamenSolicitado INNER JOIN      
		  CM_CO_Componente ON  CM_CO_Componente.CodigoComponente =  
			(case when SS_HC_ExamenSolicitado.CodigoComponente  IS NULL OR SS_HC_ExamenSolicitado.CodigoComponente  ='' 
				then SS_HC_ExamenSolicitado.CodigoSegus  
				else SS_HC_ExamenSolicitado.CodigoComponente     
				end
			)
		  WHERE   SS_HC_ExamenSolicitado.IdPaciente =@ValorCodigo1       
		  AND   SS_HC_ExamenSolicitado.EpisodioClinico = @ValorCodigo2        
		  AND   SS_HC_ExamenSolicitado.IdEpisodioAtencion = @ValorCodigo3      
		  AND   SS_HC_ExamenSolicitado.UnidadReplicacion = @ValorCodigo4    
		  AND   SS_HC_ExamenSolicitado.TipoCodigo = 'S'
	 end      
		
		select * from @MA_MiscelaneosDetalle      
    END   

 IF @ACCION ='EXAMENESLIST'      
	 BEGIN      
	 if(@ValorCodigo5='C')
	 begin
		 insert into @MA_MiscelaneosDetalle 
		  (  
		  AplicacionCodigo, ValorEntero1,   ValorEntero2, ValorEntero3,  
		  ValorFecha,  
		  ValorCodigo1,  
		  ValorCodigo3,  ValorCodigo4,  CodigoTabla, Compania,
		  CodigoElemento,
		  ValorCodigo5, ValorEntero6 ,ValorEntero7, 
		  ValorCodigo6, ValorCodigo7, ValorCodigo2, DescripcionExtranjera
		  )      
		  SELECT      
		  SS_HC_ExamenSolicitadoDet_FE.UnidadReplicacion,  SS_HC_ExamenSolicitadoDet_FE.IdPaciente, SS_HC_ExamenSolicitadoDet_FE.EpisodioClinico,   SS_HC_ExamenSolicitadoDet_FE.IdEpisodioAtencion,   
		  SS_HC_ExamenSolicitadoDet_FE.FechaSolitada,     
		  ltrim(rtrim(SS_GE_ProcedimientoMedico.Descripcion))+'|['+ ltrim(rtrim(Convert(varchar(10),SS_HC_ExamenSolicitadoDet_FE.IdProcedimiento)))+']',   
		  SS_HC_ExamenSolicitadoDet_FE.IdEspecialidad,  SS_HC_ExamenSolicitadoDet_FE.Observacion,  
		  SS_HC_ExamenSolicitadoDet_FE.Accion,'0000',
		  SS_HC_ExamenSolicitadoDet_FE.Secuencia  
		  ,SS_HC_ExamenSolicitadoDet_FE.IdProcedimiento,  SS_HC_ExamenSolicitadoDet_FE.Cantidad, SS_HC_ExamenSolicitadoDet_FE.IndicadorEPS,
		  SS_HC_ExamenSolicitadoDet_FE.TipoCodigo, SS_HC_ExamenSolicitadoDet_FE.CodigoSegus,SS_HC_ExamenSolicitadoDet_FE.CodigoComponente, SS_HC_ExamenSolicitadoDet_FE.Especificaciones
		  FROM  SS_HC_ExamenSolicitadoDet_FE 
					INNER JOIN    	  SS_GE_ProcedimientoMedico 
					ON  SS_GE_ProcedimientoMedico.IdProcedimiento =  SS_HC_ExamenSolicitadoDet_FE.IdProcedimiento      
		  WHERE   SS_HC_ExamenSolicitadoDet_FE.IdPaciente =@ValorCodigo1       
		  AND   SS_HC_ExamenSolicitadoDet_FE.EpisodioClinico = @ValorCodigo2        
		  AND   SS_HC_ExamenSolicitadoDet_FE.IdEpisodioAtencion = @ValorCodigo3      
		  AND   SS_HC_ExamenSolicitadoDet_FE.UnidadReplicacion = @ValorCodigo4    
		  AND   SS_HC_ExamenSolicitadoDet_FE.TipoCodigo = 'C'
	 end
	 else
	 begin
		
		  insert into @MA_MiscelaneosDetalle 
		  (  AplicacionCodigo, 
		  ValorEntero1,   ValorEntero2, ValorEntero3,  
		  ValorFecha,  
		  ValorCodigo1,  
		  ValorCodigo3,  ValorCodigo4,  
		  CodigoTabla, Compania,ValorCodigo2,  
		  CodigoElemento,
		  ValorCodigo5, 
		  ValorEntero6 ,ValorEntero7, 
		  ValorCodigo6, ValorCodigo7, DescripcionExtranjera
		  )      
		  SELECT      
		  SS_HC_ExamenSolicitadoDet_FE.UnidadReplicacion,  
		  SS_HC_ExamenSolicitadoDet_FE.IdPaciente, SS_HC_ExamenSolicitadoDet_FE.EpisodioClinico,   SS_HC_ExamenSolicitadoDet_FE.IdEpisodioAtencion,   
		  SS_HC_ExamenSolicitadoDet_FE.FechaSolitada,     
		  ltrim(rtrim(CM_CO_Componente.Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),SS_HC_ExamenSolicitadoDet_FE.IdProcedimiento)))+']',   
		  SS_HC_ExamenSolicitadoDet_FE.IdEspecialidad,  SS_HC_ExamenSolicitadoDet_FE.Observacion,  
		  SS_HC_ExamenSolicitadoDet_FE.Accion,'0000',
		    ltrim(rtrim(CM_CO_Componente.Nombre))+'|['+ ltrim(rtrim(Convert(varchar(10),CM_CO_Componente.CodigoComponente)))+']',
		  SS_HC_ExamenSolicitadoDet_FE.Secuencia, 
		  SS_HC_ExamenSolicitadoDet_FE.IdProcedimiento,  
		  SS_HC_ExamenSolicitadoDet_FE.Cantidad, SS_HC_ExamenSolicitadoDet_FE.IndicadorEPS,
		  SS_HC_ExamenSolicitadoDet_FE.TipoCodigo, SS_HC_ExamenSolicitadoDet_FE.CodigoSegus, SS_HC_ExamenSolicitadoDet_FE.Especificaciones
		  FROM        SS_HC_ExamenSolicitadoDet_FE 
			INNER JOIN  CM_CO_Componente ON  CM_CO_Componente.CodigoComponente =  
					(case when SS_HC_ExamenSolicitadoDet_FE.CodigoComponente  IS NULL OR SS_HC_ExamenSolicitadoDet_FE.CodigoComponente  ='' 
						then SS_HC_ExamenSolicitadoDet_FE.CodigoSegus  
						else SS_HC_ExamenSolicitadoDet_FE.CodigoComponente     
						end
					)
		  WHERE   SS_HC_ExamenSolicitadoDet_FE.IdPaciente =@ValorCodigo1       
		  AND   SS_HC_ExamenSolicitadoDet_FE.EpisodioClinico = @ValorCodigo2        
		  AND   SS_HC_ExamenSolicitadoDet_FE.IdEpisodioAtencion = @ValorCodigo3      
		  AND   SS_HC_ExamenSolicitadoDet_FE.UnidadReplicacion = @ValorCodigo4    
		  AND   SS_HC_ExamenSolicitadoDet_FE.TipoCodigo = 'S'
	 end      
		
		select * from @MA_MiscelaneosDetalle      
    END   
	 
 IF @ACCION ='RESULTADOS'      
 BEGIN                                  
  insert into @MA_MiscelaneosDetalle ( AplicacionCodigo, ValorEntero1, ValorEntero2, ValorEntero3,  ValorFecha, ValorCodigo1,  ValorCodigo2, ValorNumerico,ValorCodigo5,ValorCodigo3, ValorCodigo4,        CodigoTabla, Compania,CodigoElemento)      
  select 'AP', laboResult.Secuencia,laboResult.IdPaciente, laboResult.EpisodioClinico,laboResult.FechaResultado, laboResult.DescripcionExamenPrincipal,laboResult.Rango,  laboResult.Resultado,laboResult.unidadMedida,  
  convert(varchar, laboResult.FechaResultado, 103), '', 'RESULT', '0000',laboResult.Secuencia     
  from  dbo.SS_LA_LaboratorioResultado laboResult    
  inner join (    
  select DescripcionExamenPrincipal,max(FechaResultado) as FechaResultadoMax,convert(varchar, max(FechaResultado), 112) as FechaResultadoMaxCod    
  from  dbo.SS_LA_LaboratorioResultado as laboResAux          
  WHERE   laboResAux.IdPaciente = @ValorCodigo1       
  AND   laboResAux.EpisodioClinico = @ValorCodigo2        
  AND   laboResAux.IdEpisodioAtencion = @ValorCodigo3    
  AND   laboResAux.IdDiagnostico = @ValorNumerico    
  group by  DescripcionExamenPrincipal)AUX     
  on (rtrim(AUX.DescripcionExamenPrincipal) = rtrim(laboResult.DescripcionExamenPrincipal)    
  and AUX.FechaResultadoMaxCod = convert(varchar, laboResult.FechaResultado, 112))                   
  WHERE laboResult.IdPaciente = @ValorCodigo1       
  AND   laboResult.EpisodioClinico = @ValorCodigo2        
  AND   laboResult.IdEpisodioAtencion = @ValorCodigo3       
  AND   laboResult.IdDiagnostico = @ValorNumerico    
  select * from @MA_MiscelaneosDetalle      
 END  
      
 IF @ACCION ='RESULTADOSGRAFICA'      
 BEGIN      
  insert into @MA_MiscelaneosDetalle (  AplicacionCodigo, ValorEntero1, ValorEntero2, ValorEntero3,  ValorFecha, ValorCodigo1,  ValorCodigo2, ValorNumerico,ValorCodigo5,ValorCodigo3, ValorCodigo4,CodigoTabla, Compania,CodigoElemento)      
  select 'AP', Secuencia,IdPaciente, EpisodioClinico,FechaResultado, DescripcionExamenPrincipal,Rango,  Resultado,UnidadMedida,convert(varchar, FechaResultado, 103), '', 'RESULT', '0000',Secuencia from  dbo.SS_LA_LaboratorioResultado    
  WHERE   SS_LA_LaboratorioResultado.IdPaciente =@ValorCodigo1       
  AND   SS_LA_LaboratorioResultado.IdDiagnostico = @ValorNumerico    
  AND   rtrim(SS_LA_LaboratorioResultado.DescripcionExamenPrincipal)= rtrim(@ValorCodigo5)    
  select * from @MA_MiscelaneosDetalle      
 END
      
 IF @ACCION ='EXAMENCUERPO'      
 BEGIN      
  insert into @MA_MiscelaneosDetalle (  AplicacionCodigo, ValorEntero1,   ValorEntero2, ValorEntero3,  ValorCodigo1, ValorCodigo2, Estado, CodigoTabla, Compania,CodigoElemento, ACCION)      
  SELECT    SS_HC_ExamenFisico_Regional.UnidadReplicacion, SS_HC_ExamenFisico_Regional.IdPaciente, SS_HC_ExamenFisico_Regional.IdEpisodioAtencion,  SS_HC_ExamenFisico_Regional.EpisodioClinico, ltrim(rtrim(SS_HC_CuerpoHumano.Descripcion))+'|['+ ltrim(rtrim
  
(Convert(varchar(10),SS_HC_ExamenFisico_Regional.IdCuerpoHumano)))+']', SS_HC_ExamenFisico_Regional.Comentarios, SS_HC_ExamenFisico_Regional.Estado,  'CCEP0104','0000', SS_HC_ExamenFisico_Regional.Secuencia, 'UPDATE'    
  FROM  SS_HC_CuerpoHumano INNER JOIN    
  SS_HC_ExamenFisico_Regional ON  SS_HC_CuerpoHumano.IdCuerpoHumano =  SS_HC_ExamenFisico_Regional.IdCuerpoHumano    
  WHERE   SS_HC_ExamenFisico_Regional.IdPaciente =@ValorCodigo1       
  AND   SS_HC_ExamenFisico_Regional.EpisodioClinico = @ValorCodigo2        
  AND   SS_HC_ExamenFisico_Regional.IdEpisodioAtencion = @ValorCodigo3      
  select * from @MA_MiscelaneosDetalle      
 END   
   
 IF @ACCION ='APERSONALDETALLE'      
 BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, ValorEntero1,   ValorEntero2, ValorEntero3,  ValorCodigo1,    CodigoTabla, Compania,CodigoElemento,   ValorFecha, ValorCodigo2 )      
  SELECT  SS_HC_Anamnesis_AP_Detalle.UnidadReplicacion,  SS_HC_Anamnesis_AP_Detalle.IdPaciente,  SS_HC_Anamnesis_AP_Detalle.EpisodioClinico,   SS_HC_Anamnesis_AP_Detalle.IdEpisodioAtencion,  SS_HC_Anamnesis_AP_Detalle.Nombre,  'CCEP0003','0000',   
  SS_HC_Anamnesis_AP_Detalle.Secuencia,  Fecha, Observaciones      
  FROM SS_HC_Anamnesis_AP_Detalle        
  WHERE  SS_HC_Anamnesis_AP_Detalle.IdPaciente =@ValorCodigo1       
  AND  SS_HC_Anamnesis_AP_Detalle.IdEpisodioAtencion = @ValorCodigo2        
  AND  SS_HC_Anamnesis_AP_Detalle.EpisodioClinico = @ValorCodigo3      
  AND     SS_HC_Anamnesis_AP_Detalle.TipoRegistro = @ValorCodigo4      
  select * from @MA_MiscelaneosDetalle      
 END   

  
     
 IF @ACCION ='DIAGPROCITA'      
 BEGIN      
  insert into @MA_MiscelaneosDetalle (AplicacionCodigo, ValorEntero1,   ValorEntero2, ValorEntero3,  ValorCodigo1, CodigoTabla, Compania,CodigoElemento  )      
  SELECT     dbo.SS_HC_ProximaAtencionDiagnostico.UnidadReplicacion, dbo.SS_HC_ProximaAtencionDiagnostico.IdPaciente,   dbo.SS_HC_ProximaAtencionDiagnostico.EpisodioClinico, dbo.SS_HC_ProximaAtencionDiagnostico.IdEpisodioAtencion,     
  LTRIM(RTRIM(dbo.SS_GE_Diagnostico.Descripcion)) + '|[' + LTRIM(RTRIM(CONVERT(varchar(10), dbo.SS_HC_ProximaAtencionDiagnostico.IdDiagnostico)))   + ']' AS Expr1, 'CCEP00311' AS Expr2, '0000' AS Expr3, dbo.SS_HC_ProximaAtencionDiagnostico.Secuencia      
  FROM  dbo.SS_HC_ProximaAtencionDiagnostico INNER JOIN      
  dbo.SS_GE_Diagnostico ON dbo.SS_GE_Diagnostico.IdDiagnostico = dbo.SS_HC_ProximaAtencionDiagnostico.IdDiagnostico INNER JOIN      
  dbo.SS_HC_ProximaAtencion ON dbo.SS_HC_ProximaAtencionDiagnostico.UnidadReplicacion = dbo.SS_HC_ProximaAtencion.UnidadReplicacion AND       
  dbo.SS_HC_ProximaAtencionDiagnostico.IdEpisodioAtencion = dbo.SS_HC_ProximaAtencion.IdEpisodioAtencion AND       
  dbo.SS_HC_ProximaAtencionDiagnostico.IdPaciente = dbo.SS_HC_ProximaAtencion.IdPaciente AND       
  dbo.SS_HC_ProximaAtencionDiagnostico.EpisodioClinico = dbo.SS_HC_ProximaAtencion.EpisodioClinico AND       
  dbo.SS_HC_ProximaAtencionDiagnostico.SecuenciaProximaAtencion = dbo.SS_HC_ProximaAtencion.Secuencia      
  WHERE   SS_HC_ProximaAtencion.IdPaciente =@ValorCodigo1       
  AND   SS_HC_ProximaAtencion.IdEpisodioAtencion = @ValorCodigo2        
  AND   SS_HC_ProximaAtencion.EpisodioClinico = @ValorCodigo3       
  AND   SS_HC_ProximaAtencion.ProximaAtencionFlag = @ValorCodigo4      
  AND   ltrim(rtrim(SS_HC_ProximaAtencion.UnidadReplicacion)) = ltrim(rtrim(@ValorCodigo5))  
  select * from @MA_MiscelaneosDetalle      
 END  
  IF @ACCION ='PROXATENCIONFE'      
	 BEGIN                          
		  insert into @MA_MiscelaneosDetalle 
				 (AplicacionCodigo,		ValorEntero1,   ValorEntero2,		ValorEntero3,			ValorFecha,			ValorCodigo1,ValorCodigo2,	ValorCodigo3,		ValorCodigo4,	CodigoTabla, Compania,		CodigoElemento)      
		  SELECT  AA.UnidadReplicacion,  AA.IdPaciente,  AA.EpisodioClinico,   AA.IdEpisodioAtencion,  FechaSolicitada,AA.IdEspecialidad,AA.IdPersonalSalud,B.NombreCompleto, Observacion, 'CCEPF151',	'0000',		 AA.Secuencia      
		  FROM SS_HC_ProximaAtencion_FE AS AA 
			 LEFT JOIN PERSONAMAST B WITH(NOLOCK) ON B.PERSONA = AA.IDPERSONALSALUD
			 LEFT JOIN SS_GE_ESPECIALIDADMEDICO C WITH(NOLOCK) ON B.PERSONA = C.IDMEDICO
			 LEFT JOIN SS_GE_ESPECIALIDAD D WITH(NOLOCK) ON C.IDESPECIALIDAD = D.IDESPECIALIDAD 		  
		  WHERE  AA.IdPaciente =@ValorCodigo1       
		  AND  AA.IdEpisodioAtencion = @ValorCodigo2       
		  AND  AA.EpisodioClinico = @ValorCodigo3       
		  AND  ltrim(rtrim(AA.UnidadReplicacion)) = ltrim(rtrim(@ValorCodigo4))
		  select * from @MA_MiscelaneosDetalle      
	 END
  IF @ACCION ='INTERCONSUFE'      
	 BEGIN                          
		  insert into @MA_MiscelaneosDetalle 
				 (AplicacionCodigo,		ValorEntero1,   ValorEntero2,		ValorEntero3,			ValorFecha,			ValorCodigo1,ValorCodigo2,	ValorCodigo3,		ValorCodigo4,	CodigoTabla, Compania,		CodigoElemento)      
		  SELECT  AA.UnidadReplicacion,  AA.IdPaciente,  AA.EpisodioClinico,   AA.IdEpisodioAtencion,  FechaSolicitada,convert(char(8),FechaPlaneada, 108) FechaPlaneada,IdEspecialidad,IdTipoInterConsulta,  Observacion, 'CCEPF151',	'0000',		 AA.Secuencia      
		  FROM SS_HC_INTERCONSULTA_FE AS AA   
		  WHERE  AA.IdPaciente =@ValorCodigo1       
		  AND  AA.IdEpisodioAtencion = @ValorCodigo2       
		  AND  AA.EpisodioClinico = @ValorCodigo3       
		  AND  ltrim(rtrim(AA.UnidadReplicacion)) = ltrim(rtrim(@ValorCodigo4))
		  select * from @MA_MiscelaneosDetalle      
	 END
IF @ACCION ='DESC_MEDICO'      
 BEGIN                          
  insert into @MA_MiscelaneosDetalle 
  (AplicacionCodigo, 
  ValorEntero1,   ValorEntero2, ValorEntero3,  
  ValorCodigo1, 
  ValorCodigo5,     
  CodigoTabla, Compania, CodigoElemento, ValorCodigo2)      
  SELECT  
  SS_HC_DescansoMedico_Diagnostico_FE.UnidadReplicacion,  
  SS_HC_DescansoMedico_Diagnostico_FE.IdPaciente,  SS_HC_DescansoMedico_Diagnostico_FE.EpisodioClinico,   SS_HC_DescansoMedico_Diagnostico_FE.IdEpisodioAtencion,  
  ltrim(rtrim(SS_GE_Diagnostico.Nombre)) +'|['+ ltrim(rtrim(Convert(varchar(10),SS_GE_Diagnostico.IdDiagnostico)))+']', 
  ltrim(rtrim(SS_GE_Diagnostico.Nombre)) +'|['+ ltrim(rtrim(Convert(varchar(10),SS_GE_Diagnostico.CodigoDiagnostico)))+']',
  'CCEPF300','0000', SS_HC_DescansoMedico_Diagnostico_FE.Secuencia, ltrim(rtrim(SS_GE_Diagnostico.Nombre))      
  FROM SS_HC_DescansoMedico_Diagnostico_FE 
            INNER JOIN  SS_GE_Diagnostico 
            ON    SS_GE_Diagnostico.IdDiagnostico =  SS_HC_DescansoMedico_Diagnostico_FE.IdDiagnostico      
  WHERE  SS_HC_DescansoMedico_Diagnostico_FE.IdPaciente =@ValorCodigo1       
  AND  SS_HC_DescansoMedico_Diagnostico_FE.IdEpisodioAtencion = @ValorCodigo2       
  AND  SS_HC_DescansoMedico_Diagnostico_FE.EpisodioClinico = @ValorCodigo3       
  AND  substring(SS_HC_DescansoMedico_Diagnostico_FE.UnidadReplicacion,1,4) = substring(@ValorCodigo4,1,4)    
  select * from @MA_MiscelaneosDetalle      
 END

 IF @ACCION ='DESC_MEDICO_NUEVO'      
 BEGIN                          
  insert into @MA_MiscelaneosDetalle 
  (AplicacionCodigo, 
  ValorEntero1,   ValorEntero2, ValorEntero3,  
  ValorCodigo1, 
  ValorCodigo5,     
  CodigoTabla, Compania, CodigoElemento, ValorCodigo2)      
  SELECT  
  SS_HC_Diagnostico_FE.UnidadReplicacion,  
  SS_HC_Diagnostico_FE.IdPaciente,  SS_HC_Diagnostico_FE.EpisodioClinico,   SS_HC_Diagnostico_FE.IdEpisodioAtencion,  
  ltrim(rtrim(SS_GE_Diagnostico.Nombre)) +'|['+ ltrim(rtrim(Convert(varchar(10),SS_GE_Diagnostico.IdDiagnostico)))+']', 
  ltrim(rtrim(SS_GE_Diagnostico.Nombre)) +'|['+ ltrim(rtrim(Convert(varchar(10),SS_GE_Diagnostico.CodigoDiagnostico)))+']',
  'CCEPF300','0000', SS_HC_Diagnostico_FE.Secuencia, ltrim(rtrim(SS_GE_Diagnostico.Nombre))      
  FROM SS_HC_Diagnostico_FE 
            INNER JOIN  SS_GE_Diagnostico 
            ON    SS_GE_Diagnostico.IdDiagnostico =  SS_HC_Diagnostico_FE.IdDiagnostico      
  WHERE  SS_HC_Diagnostico_FE.IdPaciente =@ValorCodigo1       
  AND  SS_HC_Diagnostico_FE.IdEpisodioAtencion = @ValorCodigo2       
  AND  SS_HC_Diagnostico_FE.EpisodioClinico = @ValorCodigo3       
  AND  substring(SS_HC_Diagnostico_FE.UnidadReplicacion,1,4) = substring(@ValorCodigo4,1,4)    
  select * from @MA_MiscelaneosDetalle      
 END


 IF @ACCION ='TRANSFUSIONAL'      
 BEGIN                          
  insert into @MA_MiscelaneosDetalle 
  (AplicacionCodigo, 
  ValorEntero1,   ValorEntero2, ValorEntero3,  
  ValorCodigo1,    
  ValorCodigo2,
  CodigoTabla, Compania, CodigoElemento)      
  SELECT  
  SS_HC_SolucitudTransfusionalDiagnostico_FE.UnidadReplicacion,  
  SS_HC_SolucitudTransfusionalDiagnostico_FE.IdPaciente,  SS_HC_SolucitudTransfusionalDiagnostico_FE.EpisodioClinico,   SS_HC_SolucitudTransfusionalDiagnostico_FE.IdEpisodioAtencion,  
  ltrim(rtrim(SS_GE_Diagnostico.Nombre)) +'|['+ ltrim(rtrim(Convert(varchar(10),SS_GE_Diagnostico.IdDiagnostico)))+']',  
  ltrim(rtrim(SS_GE_Diagnostico.Nombre)) +'|['+ ltrim(rtrim(Convert(varchar(10),SS_GE_Diagnostico.CodigoDiagnostico)))+']',
  'CCEPF301','0000', SS_HC_SolucitudTransfusionalDiagnostico_FE.Secuencia      
  FROM SS_HC_SolucitudTransfusionalDiagnostico_FE 
		INNER JOIN  SS_GE_Diagnostico 
		ON 	SS_GE_Diagnostico.IdDiagnostico =  SS_HC_SolucitudTransfusionalDiagnostico_FE.IdDiagnostico      
  WHERE  SS_HC_SolucitudTransfusionalDiagnostico_FE.IdPaciente =@ValorCodigo1       
  AND  SS_HC_SolucitudTransfusionalDiagnostico_FE.IdEpisodioAtencion = @ValorCodigo2       
  AND  SS_HC_SolucitudTransfusionalDiagnostico_FE.EpisodioClinico = @ValorCodigo3       
  AND  substring(SS_HC_SolucitudTransfusionalDiagnostico_FE.UnidadReplicacion,1,4) = substring(@ValorCodigo4,1,4)    
  select * from @MA_MiscelaneosDetalle      
 END

 IF @ACCION ='CONTRARREFERENCIA'      
 BEGIN      
  insert into @MA_MiscelaneosDetalle (
  AplicacionCodigo, 
  ValorEntero1,   ValorEntero2,  ValorEntero3,  
  ValorCodigo1, 
  ValorCodigo5,      
  CodigoTabla, Compania, CodigoElemento)      
  SELECT  
  SS_HC_CONTRARREFERENCIA_Diagnostico_FE.UnidadReplicacion,  
  SS_HC_CONTRARREFERENCIA_Diagnostico_FE.IdPaciente,  SS_HC_CONTRARREFERENCIA_Diagnostico_FE.EpisodioClinico,     SS_HC_CONTRARREFERENCIA_Diagnostico_FE.IdEpisodioAtencion, 
  ltrim(rtrim(SS_GE_Diagnostico.Nombre)) +'|['+ ltrim(rtrim(Convert(varchar(10), SS_GE_Diagnostico.IdDiagnostico)))+']', 
  ltrim(rtrim(SS_GE_Diagnostico.Nombre)) +'|['+ ltrim(rtrim(Convert(varchar(10), SS_GE_Diagnostico.CodigoDiagnostico)))+']',
  'CCEPF203','0000', SS_HC_CONTRARREFERENCIA_Diagnostico_FE.Secuencia      
  FROM SS_HC_CONTRARREFERENCIA_Diagnostico_FE  
		INNER JOIN  SS_GE_Diagnostico 
		ON 	SS_GE_Diagnostico.IdDiagnostico =  SS_HC_CONTRARREFERENCIA_Diagnostico_FE.IdDiagnostico         
  WHERE  SS_HC_CONTRARREFERENCIA_Diagnostico_FE.IdPaciente =@ValorCodigo1       
  AND  SS_HC_CONTRARREFERENCIA_Diagnostico_FE.IdEpisodioAtencion = @ValorCodigo2        
  AND  SS_HC_CONTRARREFERENCIA_Diagnostico_FE.EpisodioClinico = @ValorCodigo3      
  AND     SS_HC_CONTRARREFERENCIA_Diagnostico_FE.TipoRegistro = @ValorCodigo4      
  select * from @MA_MiscelaneosDetalle      
 END 

 IF @ACCION ='REFERENCIA'      
 BEGIN      
	  insert into @MA_MiscelaneosDetalle (
	  AplicacionCodigo, 
	  ValorEntero1,   ValorEntero2,  ValorEntero3,  
	  ValorCodigo1,    
	  CodigoTabla, Compania, CodigoElemento)      
	  SELECT   A.UnidadReplicacion,   A.IdPaciente,  A.EpisodioClinico,     A.IdEpisodioAtencion, 
	  ltrim(rtrim(B.Nombre)) +'|['+ ltrim(rtrim(Convert(varchar(10),A.IdDiagnostico)))+']', 
	  'CCEPF202','0000', A.Secuencia  FROM SS_HC_ReferenciaDetalle_FE A 
		INNER JOIN  SS_GE_Diagnostico  B	ON 	B.IdDiagnostico =  A.IdDiagnostico         
	  WHERE  A.IdPaciente =@ValorCodigo1
	  AND  A.IdEpisodioAtencion = @ValorCodigo2
	  AND  A.EpisodioClinico = @ValorCodigo3
	  AND  A.IdReferencia = @ValorCodigo4
	  select * from @MA_MiscelaneosDetalle
 END 
  IF @ACCION ='GINECOOBSTETRICOS'      
 BEGIN      
  insert into @MA_MiscelaneosDetalle (
  AplicacionCodigo, 
  ValorEntero1,   ValorEntero2,  ValorEntero3,  
  ValorCodigo1,
  ValorCodigo2, 
  ValorEntero4, ValorEntero5, ValorEntero6, ValorEntero7,
  CodigoTabla, Compania, CodigoElemento)      
  SELECT  
  SS_HC_GINECOOBSTETRICOS_Diagnostico_FE.UnidadReplicacion,  
  SS_HC_GINECOOBSTETRICOS_Diagnostico_FE.IdAtendidoPor,  SS_HC_GINECOOBSTETRICOS_Diagnostico_FE.IdComplicacionesParto,     SS_HC_GINECOOBSTETRICOS_Diagnostico_FE.PesoNacer, 
  ltrim(rtrim(SS_GE_Diagnostico.Nombre)) +'|['+ ltrim(rtrim(Convert(varchar(10),SS_GE_Diagnostico.CodigoDiagnostico)))+']', 
  SS_HC_GINECOOBSTETRICOS_Diagnostico_FE.Sexo, 
  SS_HC_GINECOOBSTETRICOS_Diagnostico_FE.Anio, SS_HC_GINECOOBSTETRICOS_Diagnostico_FE.IdNacidoVivo, SS_HC_GINECOOBSTETRICOS_Diagnostico_FE.IdTipoParto,SS_HC_GINECOOBSTETRICOS_Diagnostico_FE.IdLugarParto,
  'CCEPF005','0000', SS_HC_GINECOOBSTETRICOS_Diagnostico_FE.Secuencia      
  FROM SS_HC_GINECOOBSTETRICOS_Diagnostico_FE  
		INNER JOIN  SS_GE_Diagnostico 
		ON 	SS_GE_Diagnostico.IdDiagnostico =  SS_HC_GINECOOBSTETRICOS_Diagnostico_FE.IdDiagnostico         
  WHERE  SS_HC_GINECOOBSTETRICOS_Diagnostico_FE.IdPaciente =@ValorCodigo1       
  AND  SS_HC_GINECOOBSTETRICOS_Diagnostico_FE.IdEpisodioAtencion = @ValorCodigo2        
  AND  SS_HC_GINECOOBSTETRICOS_Diagnostico_FE.EpisodioClinico = @ValorCodigo3      
  AND     SS_HC_GINECOOBSTETRICOS_Diagnostico_FE.UnidadReplicacion = @ValorCodigo4    
    
  select * from @MA_MiscelaneosDetalle      
 END 



 IF @ACCION ='APOYODIAG'      
 BEGIN      
  insert into @MA_MiscelaneosDetalle (  AplicacionCodigo, ValorEntero1,   ValorEntero2, ValorEntero3,  ValorCodigo1, ValorCodigo3, ValorCodigo2,  Estado, CodigoTabla,Compania,CodigoElemento)      
  SELECT      AA.UnidadReplicacion,  AA.IdPaciente,  AA.EpisodioClinico,   AA.IdEpisodioAtencion,     
  ltrim(rtrim(BB.Descripcion))+'|['+ ltrim(rtrim(Convert(varchar(10),BB.IdDiagnostico)))+']',  
    ltrim(rtrim(BB.Descripcion))+'|['+ ltrim(rtrim(Convert(varchar(10),BB.CodigoDiagnostico)))+']',
     AA.Observacion,  AA.Estado,  AA.Accion,'0000', AA.Secuencia  
  FROM   SS_HC_ApoyoDiagnostico_FE AA
  INNER JOIN SS_GE_Diagnostico BB ON       BB.IdDiagnostico =  AA.IdDiagnostico    
  WHERE  
				AA.IdPaciente =@ValorCodigo1       
		  AND   AA.EpisodioClinico = @ValorCodigo2        
		  AND   AA.IdEpisodioAtencion = @ValorCodigo3      
		  AND   ltrim(rtrim(AA.UnidadReplicacion)) = ltrim(rtrim(@ValorCodigo5))  
  select * from @MA_MiscelaneosDetalle      
 END  

 IF @ACCION ='MEDICAMENTOS'      
 BEGIN      
  if len(@ValorCodigo3)=0 SET @ValorCodigo3 = NULL      
  if(@CodigoElemento is not null )
  begin
	  insert into @MA_MiscelaneosDetalle 
	  (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal, 
	  ValorCodigo1, ValorCodigo2, ValorCodigo3, ValorCodigo4, 
	  ValorCodigo5, 
	  ValorCodigo6, ValorCodigo7,ACCION)      
	  Select  
	  'CG','99999',  WH_ItemMast.Linea, WH_ItemMast.Item ,    WH_ItemMast.DescripcionLocal, 
	  WH_ClaseSubFamilia.Linea, WH_ClaseSubFamilia.Familia, WH_ClaseSubFamilia.SubFamilia,WH_ClaseSubFamilia.Estado,
	  WH_ClaseSubFamilia.DescripcionLocal,
	  WH_ClaseLinea.DescripcionLocal, WH_ClaseFamilia.DescripcionLocal,'MED'     
	  FROM   WH_ItemMast
	  INNER JOIN 
	  dbo.WH_ClaseLinea ON dbo.WH_ItemMast.Linea = dbo.WH_ClaseLinea.Linea 
	  INNER JOIN    
	  dbo.WH_ClaseFamilia ON( dbo.WH_ItemMast.Linea = dbo.WH_ClaseFamilia.Linea
	  and dbo.WH_ItemMast.FAmilia = dbo.WH_ClaseFamilia.Familia  )
	  INNER JOIN    	  
	  dbo.WH_ClaseSubFamilia ON (dbo.WH_ClaseFamilia.Linea = dbo.WH_ClaseSubFamilia.Linea     
	  and dbo.WH_ItemMast.FAmilia = dbo.WH_ClaseSubFamilia.Familia  
	  AND dbo.WH_ItemMast.SubFamilia = dbo.WH_ClaseSubFamilia.SubFamilia)    
	  Where  rtrim(WH_ItemMast.Linea) = @ValorCodigo1    
	  and  rtrim(WH_ItemMast.Familia) = @ValorCodigo2    
	  and rtrim(WH_ItemMast.SubFamilia)= @ValorCodigo3    
	  and rtrim(WH_ItemMast.Item)= @CodigoElemento    
	
  end
  else
  begin
	  insert into @MA_MiscelaneosDetalle 
	  (AplicacionCodigo, Compania, CodigoTabla,   CodigoElemento ,   DescripcionLocal, 
	  ValorCodigo1, ValorCodigo2, ValorCodigo3, ValorCodigo4, 
	  ValorCodigo5, 
	  ValorCodigo6, ValorCodigo7,ACCION)      
	  Select  
	  'CG','99999',  WH_ClaseSubFamilia.Linea, WH_ClaseSubFamilia.SubFamilia ,WH_ClaseSubFamilia.DescripcionLocal, 
	  WH_ClaseSubFamilia.Linea, WH_ClaseSubFamilia.Familia,WH_ClaseSubFamilia.SubFamilia, WH_ClaseSubFamilia.Estado,
	  WH_ClaseSubFamilia.DescripcionLocal,
	  WH_ClaseLinea.DescripcionLocal, WH_ClaseFamilia.DescripcionLocal ,'DCI'             
	  FROM   dbo.WH_ClaseFamilia INNER JOIN    
	  dbo.WH_ClaseLinea ON dbo.WH_ClaseFamilia.Linea = dbo.WH_ClaseLinea.Linea INNER JOIN    
	  dbo.WH_ClaseSubFamilia ON dbo.WH_ClaseFamilia.Linea = dbo.WH_ClaseSubFamilia.Linea     
	  AND dbo.WH_ClaseFamilia.Familia = dbo.WH_ClaseSubFamilia.Familia    
	  Where  WH_ClaseSubFamilia.Linea = @ValorCodigo1    
	  and  WH_ClaseSubFamilia.Familia = @ValorCodigo2    
	  and WH_ClaseSubFamilia.SubFamilia= @ValorCodigo3    
	
 
  end
  select * from @MA_MiscelaneosDetalle  
  
         
 END     
END      



/******************************************************************************************  ******/
--Fecha ( 26-01-2016) / Estado (PUBLICADO)
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
ALTER PROCEDURE  [dbo].[SP_AnamnesisAF_FE]
	@UnidadReplicacion char(4) ,
	@IdEpisodioAtencion bigint  ,
	@IdPaciente int  ,
	@EpisodioClinico int  ,
	@Secuencia int  ,
	@IdTipoParentesco int  ,
	@Edad int  ,
	@IdVivo int  ,
	@Estado int  ,
	@UsuarioCreacion varchar(25) ,
	@FechaCreacion datetime  ,
	@UsuarioModificacion varchar(200) ,
	@FechaModificacion datetime  ,
	@Accion varchar(25) ,
	@Version varchar(25)
	
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @IdEpisodioAtencionId as INTEGER,@SecuenciaID as INTEGER,
	 @EpisodioClinicoID as INTEGER, @ExisteCodigo as VARCHAR(10)
	 
	 SET @IdEpisodioAtencionId = @IdEpisodioAtencion;
	 
	 IF @Accion = 'NUEVO'
		BEGIN
		 
				-- select @SecuenciaID = ISNULL(max(Secuencia),0)+1  from SS_HC_Anamnesis_AF_FE
				INSERT INTO  SS_HC_Anamnesis_AF_FE(UnidadReplicacion, IdEpisodioAtencion, IdPaciente, EpisodioClinico, 
								  IdTipoParentesco, Edad, IdVivo, Estado, UsuarioCreacion, 
								FechaCreacion, UsuarioModificacion, 
								FechaModificacion, Accion, Version)
				VALUES(@UnidadReplicacion,	@IdEpisodioAtencionId,	@IdPaciente, 	@EpisodioClinico,	
								 	@IdTipoParentesco,	@Edad,	@IdVivo,	@Estado,	@UsuarioCreacion,	
								@FechaCreacion,	@UsuarioModificacion,	
								@FechaModificacion,	@Accion,	@Version)
				--   SELECT * FROM SS_HC_Anamnesis_AF_FE
				--   delete FROM SS_HC_Anamnesis_AF_FE
				 --		delete from SS_HC_Anamnesis_AF_Enfermedad_FE
			select @IdEpisodioAtencionId;
		END

	 IF @Accion = 'UPDATE'
		BEGIN
		 
					update SS_HC_Anamnesis_AF_FE
					set 
					IdTipoParentesco = @IdTipoParentesco,
					Edad = @Edad,
					IdVivo = @IdVivo,
					 Accion=@Accion , Version=@Version ,
					--Estado = @Estado,
					UsuarioModificacion = @UsuarioModificacion,
					FechaModificacion = @FechaModificacion
					Where	IdPaciente =@IdPaciente
					and		EpisodioClinico =@EpisodioClinico
					and		IdEpisodioAtencion = @IdEpisodioAtencion
					--  and		Secuencia = @Secuencia					
				--   SELECT * FROM SS_HC_Anamnesis_AF_FE
				 
			select @IdEpisodioAtencionId;
		END
 	
		IF @Accion ='UPDATEDETALLE'
			BEGIN
				update SS_HC_Anamnesis_AF_Enfermedad_FE
				set IdDiagnostico = @IdTipoParentesco, Observaciones = @UsuarioModificacion,  Accion=@Accion , Version=@Version 
				where	IdPaciente =@IdPaciente
				AND		EpisodioClinico = @EpisodioClinico
				AND		IdEpisodioAtencion=@IdEpisodioAtencion
				and		Secuencia = @Secuencia

				select @IdEpisodioAtencionId
				 /*
				 
				Insert into dbo.SS_HC_Anamnesis_AF_Enfermedad_FE(UnidadReplicacion, IdPaciente, 
						 EpisodioClinico, IdEpisodioAtencion, 
						 Secuencia, IdDiagnostico, Observaciones )
				values(@UnidadReplicacion,	@IdPaciente, 
						@EpisodioClinico, @IdEpisodioAtencionId, 
						 @Secuencia,	@IdTipoParentesco,	@UsuarioModificacion)	 
				;*/
				-- delete from SS_HC_Anamnesis_AF_Enfermedad_FE
				-- select * from SS_HC_Anamnesis_AF_Enfermedad_FE
			END

		IF @Accion ='DETALLE'
			BEGIN
			select @SecuenciaID = ISNULL(max(Secuencia),0)+1  from SS_HC_Anamnesis_AF_Enfermedad_FE
			 Insert into dbo.SS_HC_Anamnesis_AF_Enfermedad_FE(UnidadReplicacion, IdPaciente, 
					 EpisodioClinico, IdEpisodioAtencion, 
					 Secuencia, IdDiagnostico, Observaciones , Accion, Version)
			values(@UnidadReplicacion,	@IdPaciente, 
					@EpisodioClinico, @IdEpisodioAtencionId, 
					 @SecuenciaID,	@IdTipoParentesco,	@UsuarioModificacion,	@Accion,	@Version)	 
			select @IdEpisodioAtencionId;
			-- SELECT * FROM SS_HC_Anamnesis_AF_Enfermedad_FE
			END
 
		 IF @ACCION ='DELETE'
			BEGIN
		 
			 DELETE SS_HC_Anamnesis_AF_Enfermedad_FE 
			where		
				UnidadReplicacion= @UnidadReplicacion
				AND  IdPaciente =@IdPaciente
				AND		EpisodioClinico = @EpisodioClinico
				AND		IdEpisodioAtencion=@IdEpisodioAtencion
				and		Secuencia = @Secuencia
				and		IdDiagnostico = @IdTipoParentesco
				
				select @IdEpisodioAtencionId;
			END				
END





/******************************************************************************************  ******/
--Fecha ( 27-01-2016) / Estado (Publicado) /Alan Gastelu

ALTER PROCEDURE  [dbo].[SP_SS_GE_Medicamento_FEListar]
	@UnidadReplicacion  char(4) ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@IdEpisodioAtencion  bigint ,
	@Secuencia  int ,
	@TipoMedicamento int,
	@IdUnidadMedida  int,
	@Linea  char(6),
	@Familia  char(6),
	@SubFamilia  char(6),
	@TipoComponente  char(1),
	@CodigoComponente  varchar(25),
	@IdVia  int,
	@Dosis  varchar(250),
	@DiasTratamiento  decimal(9, 2),
	@Frecuencia  decimal(9, 2),
	@Cantidad  decimal(20, 6),
	@IndicadorEPS  int,
	@TipoReceta  int,
	@Forma int,
	@GrupoMedicamento int,
	@Comentario  varchar(250),
	@IndicadorAuditoria int,
	@UsuarioAuditoria varchar(25),
	@TipoComida int,
	@VolumenDia [varchar](250) ,
	@FrecuenciaToma [varchar](250) ,
	@Presentacion [varchar](250) ,
	@Hora [datetime] ,
	@Periodo VARCHAR(10) ,
	@UnidadTiempo INT  ,
	@Indicacion [varchar](250) ,
	@Estado  int,
	@UsuarioCreacion  varchar(25),
	@FechaCreacion  datetime,
	@UsuarioModificacion  varchar(25),
	@FechaModificacion  datetime,
	@Accion	varchar(50),
	@Version varchar(50)
AS
BEGIN
	 SET NOCOUNT ON;
 
	 IF @Accion ='LISTAR'
			BEGIN			
				SELECT SS_HC_Medicamento.UnidadReplicacion, IdEpisodioAtencion, IdPaciente, EpisodioClinico, Secuencia, 
				SS_HC_Medicamento.TipoMedicamento,
				SS_HC_Medicamento.IdUnidadMedida, SS_HC_Medicamento.Linea, SS_HC_Medicamento.Familia, 
				SS_HC_Medicamento.SubFamilia, TipoComponente, CodigoComponente, IdVia, 
				Dosis, DiasTratamiento, Frecuencia, Cantidad, IndicadorEPS, TipoReceta, Forma, GrupoMedicamento,Comentario, 
				IndicadorAuditoria, 
	+(case when Presentacion IS null OR Presentacion=''
		then ''else +'Presentacion : '+ SS_HC_Medicamento.Presentacion    end)
	+(case when Dosis IS null OR Dosis=''
			then ''else + ' Dosis : '+ SS_HC_Medicamento.Dosis   end)			
	+(case when  UniMed.DescripcionCorta IS null 
			then ''else ' U.Medida : '+UniMed.DescripcionCorta  end) 
	+(case when Frecuencia is null  
			then '' else ' Frecuencia : '	+ CONVERT(VARCHAR,SS_HC_Medicamento.Frecuencia) end)
	+(case when  DETUNI.Nombre IS null 
			then ''else ' Und.Tiempo : '+ DETUNI.Nombre  end)  
	+(case when  SS_HC_Medicamento.Periodo IS null 
			then ''else ' Periodo : '+ SS_HC_Medicamento.Periodo   end) 
	+(case when  DETTIE.Nombre IS null 
			then ''else ' Und.Tiempo : '+ DETTIE.Nombre  end)  
	+(case when  Via.Descripcion is null 
			then '' else ' Vía : '+ Via.Descripcion end) 
	+(case when Cantidad is null  
	    then ''else ' Cantidad : '+ CONVERT(VARCHAR,Cantidad) end)
	+(case when DETTOR.Nombre IS null 
			then ''else ' T.Receta : '+ DETTOR.Nombre   end) 
	+(case when Indicacion IS null OR Indicacion=''
			then ''else ' Indicacion : '+ Indicacion   end) as				UsuarioAuditoria, 
			TipoComida,VolumenDia ,	FrecuenciaToma ,	
				Presentacion,	Hora  ,	Indicacion,Periodo  ,UnidadTiempo ,
				SS_HC_Medicamento.Estado, SS_HC_Medicamento.UsuarioCreacion, SS_HC_Medicamento.FechaCreacion, 
				SS_HC_Medicamento.UsuarioModificacion,	SS_HC_Medicamento.FechaModificacion, 	SS_HC_Medicamento.Accion,
					( case when (MED.DescripcionLocal IS null OR MED.DescripcionLocal = '') 
								then LIN.DescripcionLocal +' | '+ FAM.DescripcionLocal +' | '+DCI.DescripcionLocal +' | '+  DCI.DescripcionLocal
								else LIN.DescripcionLocal +' | '+FAM.DescripcionLocal +' | '+DCI.DescripcionLocal +' | '+  MED.DescripcionLocal  end  ) as Version 
 , SS_HC_Medicamento.INDICADORTI
			FROM  SS_HC_Medicamento_FE AS SS_HC_Medicamento 
		Left join WH_ClaseSubFamilia DCI on 	DCI.Linea = SS_HC_Medicamento.Linea		AND DCI.Familia = SS_HC_Medicamento.Familia
						AND DCI.SubFamilia = SS_HC_Medicamento.SubFamilia	
		Left join WH_ItemMast MED on 	( rtrim(MED.Item)  =  SS_HC_Medicamento.CodigoComponente )						
        LEFT JOIN	UnidadesMast UniMed					ON (UniMed.IdUnidadMedida = SS_HC_Medicamento.IdUnidadMedida)
		LEFT JOIN	GE_VARIOS Via						ON 	(Via.CodigoTabla = 'TIPOVIA'	AND Via.Secuencial = SS_HC_Medicamento.IdVia)
		LEFT JOIN	CM_CO_TablaMaestroDetalle DETUNI	ON 	(DETUNI.IdTablaMaestro = 102	AND DETUNI.IdCodigo = SS_HC_Medicamento.UnidadTiempo)	
		LEFT JOIN	CM_CO_TablaMaestroDetalle DETTIE	ON 	(DETTIE.IdTablaMaestro = 102	AND DETTIE.IdCodigo = SS_HC_Medicamento.TipoComida)	
		LEFT JOIN	CM_CO_TablaMaestroDetalle DETTOR	ON 	(DETTOR.IdTablaMaestro = 46		AND DETTOR.IdCodigo = SS_HC_Medicamento.TipoReceta)	
		left JOIN  WH_ClaseFamilia FAM ON FAM.Linea = SS_HC_Medicamento.Linea AND FAM.Familia = SS_HC_Medicamento.Familia 
		left JOIN  WH_ClaseLinea LIN ON LIN.Linea =   FAM.Linea  
		Where	
				(IdPaciente is null or SS_HC_Medicamento.IdPaciente = @IdPaciente) 
				and		(@EpisodioClinico is null or EpisodioClinico =@EpisodioClinico )
			 	and		(@UnidadReplicacion is null or SS_HC_Medicamento.UnidadReplicacion =@UnidadReplicacion )
				and		(@IdEpisodioAtencion is null or IdEpisodioAtencion = @IdEpisodioAtencion)
				and		(@TipoMedicamento is null or SS_HC_Medicamento.TipoMedicamento =@TipoMedicamento)
				and		(@GrupoMedicamento is null or SS_HC_Medicamento.GrupoMedicamento =@GrupoMedicamento)
			END
	 
END
 

 --FECHA : 27/01/2017				ESTADO: Publicado			PROGRAMADOR: BONILLAL
 CREATE PROCEDURE  [dbo].[SP_Anam_AP_PatologicosGeneralesListar_FE]
	@UnidadReplicacion char(4),
	@IdEpisodioAtencion  bigint ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@CodigoSecuencia int ,
	
	@UsuarioCreacion  varchar(25) ,
	@FechaCreacion  datetime ,
	@UsuarioModificacion  varchar(25) ,
	@FechaModificacion  datetime ,
	@Version  varchar(25),
	@Accion  varchar(25) 

	
AS
BEGIN
	SET NOCOUNT ON;

	 IF @Accion ='LISTAR'
			BEGIN
				SELECT * FROM  SS_HC_Anam_AP_PatologicosGenerales_FE  
				Where	IdPaciente =@IdPaciente 
				and		EpisodioClinico = @EpisodioClinico
				and		IdEpisodioAtencion = @IdEpisodioAtencion
				and		UnidadReplicacion = @UnidadReplicacion 
 
			END
	 
END

 --FECHA : 27/01/2017				ESTADO: Publicado			PROGRAMADOR: BONILLAL

CREATE PROCEDURE  [dbo].[SP_Anam_AP_PatologicosGeneralesListar_FE]
	@UnidadReplicacion char(4),
	@IdEpisodioAtencion  bigint ,
	@IdPaciente  int ,
	@EpisodioClinico  int ,
	@CodigoSecuencia int ,
	
	@UsuarioCreacion  varchar(25) ,
	@FechaCreacion  datetime ,
	@UsuarioModificacion  varchar(25) ,
	@FechaModificacion  datetime ,
	@Version  varchar(25),
	@Accion  varchar(25) 

	
AS
BEGIN
	SET NOCOUNT ON;

	 IF @Accion ='LISTAR'
			BEGIN
				SELECT * FROM  SS_HC_Anam_AP_PatologicosGenerales_FE  
				Where	IdPaciente =@IdPaciente 
				and		EpisodioClinico = @EpisodioClinico
				and		IdEpisodioAtencion = @IdEpisodioAtencion
				and		UnidadReplicacion = @UnidadReplicacion 
 
			END
	 
END

 --FECHA : 27/01/2017				ESTADO: Publicado			PROGRAMADOR: BONILLAL

CREATE PROCEDURE [dbo].SP_Anam_AP_PatologicosGeneralesDetalleListar_FE
@UnidadReplicacion		CHAR(4),
@IdEpisodioAtencion		bigint,
@IdPaciente				int,
@EpisodioClinico		int,
@Accion		varchar(25)

AS 
  BEGIN 
   IF ( @Accion = 'LISTAR' ) 
        BEGIN 
            SELECT  /*UnidadReplicacion,
					IdEpisodioAtencion,
					IdPaciente,					
					EpisodioClinico,
					Secuencia,
					OtrasVacunas,
					UsuarioCreacion,
					FechaCreacion,
					UsuarioModificacion,
					FechaModificacion,		
					Accion,
					Version*/ *
            FROM   SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE 
            WHERE  ( UnidadReplicacion = @UnidadReplicacion ) 
					AND ( IdEpisodioAtencion =@IdEpisodioAtencion) 
					AND (IdPaciente	=@IdPaciente )
					and (EpisodioClinico = @EpisodioClinico )
        END 
  END 



   --FECHA : 31/01/2017				ESTADO: PENDIENTE			PROGRAMADOR: Alan Gastelu

  ALTER function 	 [dbo].[ufnDiagnostico](@UnidadReplicacion char (4),@idEpisodioAtencion int ,@idPaciente int,@EpisodioClinico int )
	   returns table
		as
		return(
		Select  stuff((SELECT ', ' + C.Descripcion  from SS_HC_DescansoMedico_FE a
       INNER JOIN SS_HC_DescansoMedico_Diagnostico_FE b ON A.IdEpisodioAtencion =B.IdEpisodioAtencion AND 
       A.UnidadReplicacion=B.UnidadReplicacion AND A.IdPaciente=B.IdPaciente AND A.EpisodioClinico=B.EpisodioClinico
       INNER JOIN SS_GE_Diagnostico C ON C.IdDiagnostico =B.IdDiagnostico 
	     WHERE   B.IdPaciente =@idPaciente       
			  AND   B.EpisodioClinico = @EpisodioClinico        
			  AND   B.IdEpisodioAtencion = @idEpisodioAtencion      
			  AND   B.UnidadReplicacion = @UnidadReplicacion   
             FOR XML PATH(''), TYPE).value('.','varchar(MAX)'),1,1,'') AS Diagnostico FROM SS_HC_DescansoMedico_FE a
       INNER JOIN SS_HC_DescansoMedico_Diagnostico_FE b ON A.IdEpisodioAtencion =B.IdEpisodioAtencion AND 
       A.UnidadReplicacion=B.UnidadReplicacion AND A.IdPaciente=B.IdPaciente AND A.EpisodioClinico=B.EpisodioClinico
       where A.UnidadReplicacion = @UnidadReplicacion and A.EpisodioClinico =@EpisodioClinico and A.IdPaciente = @idPaciente  and A.IdEpisodioAtencion = @idEpisodioAtencion
	   GROUP BY A.EpisodioClinico,A.UnidadReplicacion, A.IdEpisodioAtencion,A.IdPaciente 
	   )



   --FECHA : 31/01/2017				ESTADO: PENDIENTE			PROGRAMADOR: Alan Gastelu

   ALTER FUNCTION [dbo].[UFN_Diagnostico_ApoyoDiagnostico_FE](@UnidadReplicacion char (4),@idEpisodioAtencion int ,@idPaciente int,@EpisodioClinico int )
returns varchar (max)
AS 
begin
declare @variable varchar(max)
Select @variable= stuff((SELECT ', ' + C.Descripcion  from 
       SS_HC_ApoyoDiagnostico_FE B
       INNER JOIN SS_GE_Diagnostico C ON C.IdDiagnostico =B.IdDiagnostico 
	   WHERE   B.IdPaciente =@idPaciente       
			  AND   B.EpisodioClinico = @EpisodioClinico        
			  AND   B.IdEpisodioAtencion = @idEpisodioAtencion      
			  AND   B.UnidadReplicacion = @UnidadReplicacion   
	   FOR XML PATH(''), TYPE).value('.','varchar(MAX)'),1,1,'') from
	 SS_HC_ApoyoDiagnostico_FE B
       INNER JOIN SS_GE_Diagnostico C ON C.IdDiagnostico =B.IdDiagnostico
	   WHERE b.IdPaciente =@idPaciente 
return @variable
end


 --FECHA : 31/01/2017				ESTADO: PENDIENTE			PROGRAMADOR: Alan Gastelu

ALTER FUNCTION [dbo].[UFN_Diagnostico_CONTRARREFERENCIA_FE](@UnidadReplicacion char (4),@idEpisodioAtencion int ,@idPaciente int,@EpisodioClinico int ,@tipo VARCHAR(2))
returns varchar (max)
AS 
begin
declare @variable varchar(max)
Select @variable= stuff((SELECT ', ' + C.Descripcion  from SS_HC_CONTRARREFERENCIA_FE a
       INNER JOIN SS_HC_CONTRARREFERENCIA_Diagnostico_FE b ON A.IdEpisodioAtencion =B.IdEpisodioAtencion AND 
       A.UnidadReplicacion=B.UnidadReplicacion AND A.IdPaciente=B.IdPaciente AND A.EpisodioClinico=B.EpisodioClinico
       INNER JOIN SS_GE_Diagnostico C ON C.IdDiagnostico =B.IdDiagnostico 
		 wHERE   B.IdPaciente =@idPaciente       
			  AND   B.EpisodioClinico = @EpisodioClinico        
			  AND   B.IdEpisodioAtencion = @idEpisodioAtencion      
			  AND   B.UnidadReplicacion = @UnidadReplicacion  and b.TipoRegistro = @tipo
	   FOR XML PATH(''), TYPE).value('.','varchar(MAX)'),1,1,'') 
	FROM SS_HC_CONTRARREFERENCIA_FE a
       INNER JOIN SS_HC_CONTRARREFERENCIA_Diagnostico_FE b ON A.IdEpisodioAtencion =@idEpisodioAtencion  AND 
       A.UnidadReplicacion=@UnidadReplicacion AND A.IdPaciente=@idPaciente AND  A.EpisodioClinico=@EpisodioClinico AND B.TipoRegistro = @tipo
	   GROUP BY B.TipoRegistro
return @variable
end


 --FECHA : 31/01/2017				ESTADO: PENDIENTE			PROGRAMADOR: Alan Gastelu

 
	ALTER function 	 [dbo].[UFN_DIAGNOSTICO_FE](@UnidadReplicacion char (4),@idEpisodioAtencion int ,@idPaciente int,@EpisodioClinico int )
		   returns varchar(max)
			as
			begin
			declare @variable varchar(max)
			Select @variable= stuff((SELECT ', ' + A.Descripcion  
			FROM        SS_GE_Diagnostico as A
			INNER JOIN   SS_HC_Diagnostico_FE   AS B ON  A.IdDiagnostico =  B.IdDiagnostico
			wHERE   B.IdPaciente =@idPaciente       
			  AND   B.EpisodioClinico = @EpisodioClinico        
			  AND   B.IdEpisodioAtencion = @idEpisodioAtencion      
			  AND   B.UnidadReplicacion = @UnidadReplicacion   
			FOR XML PATH(''), TYPE).value('.','varchar(MAX)'),1,1,'') 
			FROM        SS_GE_Diagnostico as A
			  INNER JOIN   SS_HC_Diagnostico_FE   AS B ON  A.IdDiagnostico =  B.IdDiagnostico      
			  WHERE   B.IdPaciente =@idPaciente       
			  AND   B.EpisodioClinico = @EpisodioClinico        
			  AND   B.IdEpisodioAtencion = @idEpisodioAtencion      
			  AND   B.UnidadReplicacion = @UnidadReplicacion   
			GROUP BY B.EpisodioClinico,B.UnidadReplicacion, B.IdEpisodioAtencion,B.IdPaciente 
			 return @variable
		   end

 --FECHA : 31/01/2017				ESTADO: PENDIENTE			PROGRAMADOR: Alan Gastelu


 ALTER function 	 [dbo].[UFN_DIAGNOSTICO_RECETA](@UnidadReplicacion char (4),@idEpisodioAtencion int ,@idPaciente int,@EpisodioClinico int )
	   returns varchar(max)
		as
		begin
		declare @variable varchar(max)
		Select @variable= stuff((SELECT ', ' + C.Descripcion  from SS_HC_DescansoMedico_FE a
       INNER JOIN SS_HC_DescansoMedico_Diagnostico_FE b ON A.IdEpisodioAtencion =B.IdEpisodioAtencion AND 
       A.UnidadReplicacion=B.UnidadReplicacion AND A.IdPaciente=B.IdPaciente AND A.EpisodioClinico=B.EpisodioClinico
       INNER JOIN SS_GE_Diagnostico C ON C.IdDiagnostico =B.IdDiagnostico 
	   wHERE   B.IdPaciente =@idPaciente       
			  AND   B.EpisodioClinico = @EpisodioClinico        
			  AND   B.IdEpisodioAtencion = @idEpisodioAtencion      
			  AND   B.UnidadReplicacion = @UnidadReplicacion 
		   FOR XML PATH(''), TYPE).value('.','varchar(MAX)'),1,1,'') 
		FROM SS_HC_DescansoMedico_FE a
		INNER JOIN SS_HC_DescansoMedico_Diagnostico_FE b ON A.IdEpisodioAtencion =B.IdEpisodioAtencion AND 
       A.UnidadReplicacion=B.UnidadReplicacion AND A.IdPaciente=B.IdPaciente AND A.EpisodioClinico=B.EpisodioClinico
       where A.UnidadReplicacion = @UnidadReplicacion and A.EpisodioClinico =@EpisodioClinico and A.IdPaciente = @idPaciente  and A.IdEpisodioAtencion = @idEpisodioAtencion
	   GROUP BY A.EpisodioClinico,A.UnidadReplicacion, A.IdEpisodioAtencion,A.IdPaciente 
	   return @variable
	   end
