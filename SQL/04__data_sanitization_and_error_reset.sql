-- Inicializar la columna 'DESCERROR' donde su valor sea 'Ok'
UPDATE [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL]
SET DESCERROR = NULL
WHERE DESCERROR = 'Ok';


--Inicializar columnas 'DESCERROR' y 'NUMERROR' con valores vacíos
UPDATE t1 
SET DESCERROR = ''
FROM [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL] t1;

UPDATE t1 
SET NUMERROR = ''
FROM [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL] t1;
