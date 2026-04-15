SET LINESIZE 700 PAGESIZE 0 FEEDBACK OFF
SET SERVEROUTPUT ON SIZE 20000

DECLARE
  CURSOR c1 IS
    SELECT * FROM gv$lock WHERE request != 0 ORDER BY id1, id2;
    
  wid1             NUMBER := -999999;
  wid2             NUMBER := -999999;
  wholder_detail   VARCHAR2(500);
  sentenciaLock    VARCHAR2(4000);
  procesoId        VARCHAR2(12);
  wsid             NUMBER;
  wtype            VARCHAR2(10);
  wthread          NUMBER;
  wlock_type       VARCHAR2(50);
  wobject_name     VARCHAR2(180);
  sidID, threadID  NUMBER;

BEGIN
  FOR rec IN c1 LOOP
    IF rec.id1 = wid1 AND rec.id2 = wid2 THEN
      NULL;
    ELSE
      -- Identificar sesión bloqueante
      SELECT sid, type, inst_id
        INTO wsid, wtype, wthread
        FROM gv$lock
       WHERE id1 = rec.id1
         AND id2 = rec.id2
         AND request = 0
         AND lmode != 4
         AND ROWNUM = 1;

      DBMS_OUTPUT.PUT_LINE('─' || RPAD('─', 100, '─'));

      -- Detalles de la sesión bloqueante
      SELECT 'SESION BLOQUEANTE: THREAD:0' || s.inst_id ||
             ' DBUSER:' || UPPER(s.username) ||
             ' SPID:' || p.spid ||
             ' SID:' || s.sid ||
             ' STATUS:' || UPPER(s.status) ||
             ' (ET:' || FLOOR(s.last_call_et/3600) || ':' ||
             FLOOR(MOD(s.last_call_et,3600)/60) || ':' ||
             MOD(MOD(s.last_call_et,3600),60) || ')' ||
             ' MACHINE:' || UPPER(SUBSTR(REPLACE(s.machine,'LOCALHOST',NULL),1,30)),
             p.spid, s.sid
        INTO wholder_detail, procesoId, sidID
        FROM gv$session s
        JOIN gv$process p
          ON s.paddr = p.addr
         AND s.inst_id = p.inst_id
       WHERE s.sid = wsid
         AND s.inst_id = wthread
         AND ROWNUM = 1;

      DBMS_OUTPUT.PUT_LINE(wholder_detail);

      -- Código para identificar tipo de bloqueo y objeto
      -- [Lógica para wlock_type, objeto, etc.]

      -- Consulta SQL de la sesión bloqueante
      SELECT 'SQL_ID ' || a.SQL_ID || ' @ ' || a.SQL_TEXT
        INTO sentenciaLock
        FROM gv$sqlarea a
        JOIN gv$session s
          ON a.SQL_ID = s.prev_sql_id
         AND a.inst_id = s.inst_id
       WHERE s.sid = sidID
         AND ROWNUM = 1;
      DBMS_OUTPUT.PUT_LINE('QUERY BLOQUEANTE: ' || sentenciaLock);
    END IF;

    -- Procesamiento de la sesión bloqueada análogo al anterior...
    wid1 := rec.id1;
    wid2 := rec.id2;
  END LOOP;

  IF wid1 = -999999 THEN
    DBMS_OUTPUT.PUT_LINE('No hay usuarios bloqueados por otros usuarios');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error o no se detectaron bloqueos de usuarios');
END;
