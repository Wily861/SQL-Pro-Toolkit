-- Alterar temporalmente la columna 'fecha_fin_poliza' a tipo VARCHAR(8)
ALTER TABLE dbo.Temp_Hdi_Generales_ETL
ALTER COLUMN fecha_fin_poliza VARCHAR(8);

-- Convertir los datos de la columna 'fecha_fin_poliza' al formato 'YYYYMMDD'
UPDATE dbo.Temp_Hdi_Generales_ETL
SET fecha_fin_poliza = CONVERT(VARCHAR(8), CONVERT(DATE, fecha_fin_poliza), 112);

-- Alterar la columna 'fecha_fin_poliza' nuevamente a tipo NUMERIC(8, 0)
ALTER TABLE dbo.Temp_Hdi_Generales_ETL
ALTER COLUMN fecha_fin_poliza NUMERIC(8, 0);

-- Cambiar el tipo de la columna 'FechaFin' a DATETIME
ALTER TABLE cAfiliadoHDI
ALTER COLUMN FechaFin DATETIME;

-- Convertir los datos de la columna 'FechaFin' al tipo DATETIME
-- Asumiendo que los valores están en formato 'YYYYMMDD'
UPDATE cAfiliadoHDI
SET FechaFin = TRY_CONVERT(DATETIME, FechaFin);
