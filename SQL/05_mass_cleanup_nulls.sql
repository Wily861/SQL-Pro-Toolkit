-- Eliminar registros saltos de linea
delete t1
from [dbo].[Temp_HDI_SEGUROS_Base_AUTOS_ETL] t1 where 
   t1.codigo_plan_negocio_especial is null and
   t1.cod_sucursal is null and
   t1.cod_ramo is null and
   t1.ramo is null and
   t1.poliza is null and
   t1.certificado is null and
   t1.fecha_inicio_poliza is null and
   t1.fecha_fin_poliza is null and
   t1.nro_identificacion_tomador is null and
   t1.nombre_tomador is null and
   t1.nro_identificacion_asegurado is null and
   t1.nombre_asegurado is null and
   t1.amparo_garantia is null and
   t1.descripcion_amparo_garantia is null and
   t1.Placa is null and
   t1.modelo is null and
   t1.marca is null and
   t1.clase is null and
   t1.tipo_de_vehiculo is null and
   t1.chasis is null and
   t1.direccion_riesgo is null and
   t1.departamento_riesgo is null and
   t1.ciudad_riesgo is null and
   t1.intermediario is null;
