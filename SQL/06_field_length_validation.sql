-- codigo_plan_negocio_especial
IF EXISTS (SELECT 1 
           FROM [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL] t1 
           WHERE LEN(CAST(t1.codigo_plan_negocio_especial AS VARCHAR)) > 4)
BEGIN
    UPDATE [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL]
    SET codigo_plan_negocio_especial = CAST(LEFT(CAST(codigo_plan_negocio_especial AS VARCHAR), 4) AS NUMERIC)
    WHERE LEN(CAST(codigo_plan_negocio_especial AS VARCHAR)) > 4
END


-- poliza
IF EXISTS (SELECT 1 
           FROM [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL] t1 
           WHERE LEN(CAST(t1.poliza AS VARCHAR(50))) > 50)
BEGIN
    UPDATE [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL]
    SET poliza = CAST(LEFT(CAST(poliza AS VARCHAR(50)), 50) AS NUMERIC)
    WHERE LEN(CAST(poliza AS VARCHAR(50))) > 50
END

-- certificado
IF EXISTS (SELECT 1 
           FROM [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL] t1 
           WHERE LEN(t1.certificado) > 50)
BEGIN
    UPDATE [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL]
    SET certificado = SUBSTRING(certificado, 1, 50)
    WHERE LEN(certificado) > 50
END


 -- fecha_inicio_poliza
IF EXISTS (SELECT 1 
           FROM [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL] 
           WHERE LEN(CAST(fecha_inicio_poliza AS VARCHAR(8))) > 8)
BEGIN
    UPDATE [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL]
    SET fecha_inicio_poliza = CAST(SUBSTRING(CAST(fecha_inicio_poliza AS VARCHAR(8)), 1, 8) AS NUMERIC)
    WHERE LEN(CAST(fecha_inicio_poliza AS VARCHAR(8))) > 8
END


-- fecha_fin_poliza
IF EXISTS (SELECT 1 
           FROM [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL] 
           WHERE LEN(CAST(fecha_fin_poliza AS VARCHAR(8))) > 8)
BEGIN
    UPDATE [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL]
    SET fecha_fin_poliza = CAST(SUBSTRING(CAST(fecha_fin_poliza AS VARCHAR(8)), 1, 8) AS NUMERIC)
    WHERE LEN(CAST(fecha_fin_poliza AS VARCHAR(8))) > 8
END
  

-- Placa
IF EXISTS (SELECT 1 
           FROM [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL] 
           WHERE LEN(Placa) > 50)
BEGIN
    UPDATE [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL]
    SET Placa = SUBSTRING(Placa, 1, 50)
    WHERE LEN(Placa) > 50
END
