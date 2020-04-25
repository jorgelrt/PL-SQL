DECLARE
	v_Department VARCHAR2(3);
	v_TotalRegistros NUMBER;
BEGIN
	v_Department := 'CS';
	SELECT count(*) INTO v_TotalRegistros FROM classes;
	DBMS_OUTPUT.PUT_LINE('Total de registros ANTES delete: '||v_TotalRegistros);
	DELETE FROM classes
	WHERE department = v_Department;
	DBMS_OUTPUT.PUT_LINE('Total de registros DEPOIS delete: '||v_TotalRegistros);
END;

--FALSO DELETE, pois o TIPO são diferentes na coluna WHERE (CHAR != VARCHAR)


/*
SQL> desc classes;
 Nome                                      Nulo?    Tipo
 ----------------------------------------- -------- ----------------------------
 DEPARTMENT                                NOT NULL CHAR(3)
 COURSE                                    NOT NULL NUMBER(3)
 DESCRIPTION                                        VARCHAR2(2000)
 MAX_STUDENTS                                       NUMBER(3)
 CURRENT_STUDENTS                                   NUMBER(3)
 NUM_CREDITS                                        NUMBER(1)
 ROOM_ID                                            NUMBER(5)
*/