set serveroutput on
DECLARE
	name employees.last_name%TYPE; 
	v_ErrorCode NUMBER; --código do erro
	v_ErrorMsg VARCHAR2(200); --texto da mensagem do erro
	v_CurrentUser VARCHAR2(10); --usuário atual do BD
	v_Information  VARCHAR2(200); --informações sobre o erro
BEGIN
	SELECT last_name INTO name FROM employees WHERE employee_id = 1000;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
	v_ErrorCode := SQLCODE; --função prédefinida
	v_ErrorMsg := SQLERRM; --função prédefinida
	v_CurrentUser := USER; --função prédefinida
	v_Information := 'Error encountered on '||TO_CHAR(SYSDATE)||' by database user '||v_CurrentUser;
	INSERT INTO log_table(code, message, info)
	VALUES(v_ErrorCode, v_ErrorMsg, v_Information);
	WHEN OTHERS THEN
	--atribui valores as variáveis de log
	v_ErrorCode := SQLCODE;
	v_ErrorMsg := SQLERRM;
	v_CurrentUser := USER;
	v_Information := 'Error encountered on '||TO_CHAR(SYSDATE)||' by database user '||v_CurrentUser;
	INSERT INTO log_table(code, message, info)
	VALUES(v_ErrorCode, v_ErrorMsg, v_Information);
END;

xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

set serveroutput on
DECLARE
	name employees.last_name%TYPE;
	v_code NUMBER;
	v_errm VARCHAR2(64);
BEGIN
	SELECT last_name INTO name FROM employees WHERE employee_id = 1000;
	
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    --DBMS_OUTPUT.PUT_LINE('SEM DADOS');
	v_code := SQLCODE;
		v_errm := SUBSTR(SQLERRM, 1, 64);
		DBMS_OUTPUT.PUT_LINE('The error code is '||v_code||' - '||v_errm);
	WHEN OTHERS THEN
		v_code := SQLCODE;
		v_errm := SUBSTR(SQLERRM, 1, 64);
		DBMS_OUTPUT.PUT_LINE('The error code is '||v_code||' - '||v_errm);
END;
/



