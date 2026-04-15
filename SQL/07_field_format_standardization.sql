-- codigo_plan_negocio_especial 
IF((SELECT COUNT(*) FROM [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL] t1 WHERE (ISNUMERIC(t1.codigo_plan_negocio_especial) = 0) ) > 0)
BEGIN 
    UPDATE t1 
    SET t1.NUMERROR = 1, t1.DESCERROR = DESCERROR + 'motivo: formato incorrecto' 
    FROM [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL] t1 WHERE ISNUMERIC(t1.codigo_plan_negocio_especial) = 0
END

  
-- poliza 
IF((SELECT COUNT(*) FROM [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL] t1  WHERE (ISNUMERIC(t1.poliza) = 0) ) > 0)
BEGIN 
    UPDATE t1 
    SET t1.NUMERROR = 1,  t1.DESCERROR = DESCERROR + 'motivo: formato incorrecto' 
    FROM [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL] t1 WHERE ISNUMERIC(t1.poliza) = 0
END

  
-- certificado 
IF((SELECT COUNT(*) FROM [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL] t1  WHERE (ISNUMERIC(t1.certificado) = 0) ) > 0)
BEGIN 
    UPDATE t1 
    SET t1.NUMERROR = 1,  t1.DESCERROR = DESCERROR + 'motivo: formato incorrecto' 
    FROM [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL] t1 WHERE ISNUMERIC(t1.certificado) = 0
END

  
-- fecha_inicio_poliza 
IF((SELECT COUNT(*) FROM [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL] t1 WHERE (ISDATE(t1.fecha_inicio_poliza) = 0) )> 0)
BEGIN 
    UPDATE t1 
    SET t1.NUMERROR = 1, t1.DESCERROR = DESCERROR + 'motivo: formato incorrecto' 
    FROM [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL] t1 WHERE ISDATE(t1.fecha_inicio_poliza) = 0
END
