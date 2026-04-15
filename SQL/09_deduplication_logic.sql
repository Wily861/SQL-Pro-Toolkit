-- Duplicidad se acepta un solo registro
IF EXISTS (
    SELECT 1
    FROM [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL] AS t1
    WHERE EXISTS (
        SELECT 1
        FROM [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL] AS t2
        WHERE t2.Placa = t1.Placa
          AND t2.codigo_plan_negocio_especial = t1.codigo_plan_negocio_especial
          AND t2.poliza = t1.poliza
        GROUP BY t2.Placa, t2.codigo_plan_negocio_especial, t2.poliza
        HAVING COUNT(*) > 1
    )
)
BEGIN
    -- Actualiza todos los registros 
    UPDATE t1
    SET t1.NUMERROR = 1, t1.DESCERROR = 'Duplicidad'
    FROM [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL] t1
    WHERE EXISTS (
        SELECT 1
        FROM [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL] AS t2
        WHERE t2.Placa = t1.Placa
          AND t2.codigo_plan_negocio_especial = t1.codigo_plan_negocio_especial
          AND t2.poliza = t1.poliza
        GROUP BY t2.Placa, t2.codigo_plan_negocio_especial, t2.poliza
        HAVING COUNT(*) > 1
    );

    -- Nos quedamos solo con el último registro 
    UPDATE t1
    SET t1.NUMERROR = 0, t1.DESCERROR = 'Ok'
    FROM [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL] t1
    WHERE t1.ID IN (
        SELECT MAX(t2.ID)
        FROM [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL] t2
        WHERE t2.Placa = t1.Placa
          AND t2.codigo_plan_negocio_especial = t1.codigo_plan_negocio_especial
          AND t2.poliza = t1.poliza
        GROUP BY t2.Placa, t2.codigo_plan_negocio_especial, t2.poliza
    );
END
ELSE
BEGIN
    -- Si no hay duplicados, actualiza todos los registros con NUMERROR = 0 y DESCERROR = 'Ok'
    UPDATE t1
    SET t1.NUMERROR = 0, t1.DESCERROR = 'Ok'
    FROM [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL] t1;
END

END;
