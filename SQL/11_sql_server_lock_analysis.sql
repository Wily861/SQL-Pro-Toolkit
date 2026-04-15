SELECT
    L.request_session_id AS [ID de sesión bloqueada],
    L.resource_type AS [Tipo de recurso bloqueado],
    L.resource_database_id AS [ID de base de datos],
    DB_NAME(L.resource_database_id) AS [Nombre de base de datos],
    L.resource_description AS [Descripción del recurso bloqueado],
    L.request_mode AS [Modo de bloqueo],
    ST.text AS [Consulta bloqueada],
    AT.name AS [Nombre de la tabla bloqueada],
    P.program_name AS [Nombre del programa bloqueado]
FROM
    sys.dm_tran_locks L
JOIN
    sys.dm_exec_requests R ON L.request_session_id = R.session_id
CROSS APPLY
    sys.dm_exec_sql_text(R.sql_handle) AS ST
JOIN
    sys.dm_exec_sessions S ON R.session_id = S.session_id
JOIN
    sys.dm_tran_active_transactions AT ON R.transaction_id = AT.transaction_id
LEFT JOIN
    sys.sysprocesses P ON R.session_id = P.spid
WHERE
    L.request_session_id <> @@SPID
ORDER BY
    L.request_session_id,
    L.resource_type;
