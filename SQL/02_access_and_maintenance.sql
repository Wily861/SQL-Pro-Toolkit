-- 🧑‍💻 Crear usuario Leadpasivos
CREATE USER Leadpasivos WITH PASSWORD 'h8A2WuDS';

-- 🔑 Permitir conexión a la base de datos "dbOzono"
GRANT CONNECT ON DATABASE "dbOzono" TO "usrDivisasRead";

-- 📦 Otorgar uso sobre el esquema flujodivisasgiros
GRANT USAGE ON SCHEMA flujodivisasgiros TO "usrDivisasRead";

-- 👁️ Otorgar permiso de lectura sobre todas las tablas del esquema
GRANT SELECT ON ALL TABLES IN SCHEMA "flujodivisasgiros" TO "usrDivisasRead";

-- 🧹 Eliminar función ya no requerida
DROP FUNCTION IF EXISTS flujos_cdt.registrotipo1(VARCHAR);
