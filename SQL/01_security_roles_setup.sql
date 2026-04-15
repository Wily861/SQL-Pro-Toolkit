-- Otorga privilegios SELECT sobre TABLAS y VISTAS del esquema PRDN
SELECT
   'GRANT SELECT ON ' || owner || '.' || object_name || ' TO "SERV_APP";' AS grant_stmt
FROM
   dba_objects
WHERE
   owner = 'PRDN'
   AND object_type IN ('TABLE', 'VIEW');

-- Otorga privilegios EXECUTE sobre PROCEDIMIENTOS del esquema PRDN
SELECT
   'GRANT EXECUTE ON ' || owner || '.' || object_name || ' TO "SERV_APP";' AS grant_stmt
FROM
   dba_objects
WHERE
   owner = 'PRDN'
   AND object_type = 'PROCEDURE';
