--apaga os registros que condiz a clausula WHERE
DECLARE
	v_Department CHAR(3);
	v_totalRegistros NUMBER;
BEGIN
	v_Department := 'CS';
	SELECT COUNT(*) INTO v_totalRegistros FROM classes_copy;
	
	DELETE FROM classes_copy
	WHERE department = v_Department;
	
	DBMS_OUTPUT.PUT_LINE('Total de registros antes do DELETE: '||v_totalRegistros);
	SELECT COUNT(*) INTO v_totalRegistros FROM classes_copy;
	DBMS_OUTPUT.PUT_LINE('Total de registros depois do DELETE: '||v_totalRegistros);
	ROLLBACK;
END;

xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

--apaga TODOS os registros, pois PL/SQL não diferencia maiusculas de minusculas. Logo NUNCA utilize variáveis com o mesmo nome da coluna

DECLARE
	Department CHAR(3);
	v_totalRegistros NUMBER;
BEGIN
	Department := 'CS';
	SELECT COUNT(*) INTO v_totalRegistros FROM classes_copy;
	
	DELETE FROM classes_copy
	WHERE department = Department;
	
	DBMS_OUTPUT.PUT_LINE('Total de registros antes do DELETE: '||v_totalRegistros);
	SELECT COUNT(*) INTO v_totalRegistros FROM classes_copy;
	DBMS_OUTPUT.PUT_LINE('Total de registros depois do DELETE: '||v_totalRegistros);
	ROLLBACK;
END;

xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

--rotulando o bloco suicídio profissional, o mesmo funciona como o primeiro, porém NÃO É RECOMENDADO!

<<l_suicidioProfissional>>
DECLARE
	Department CHAR(3);
	v_totalRegistros NUMBER;
BEGIN
	Department := 'CS';
	SELECT COUNT(*) INTO v_totalRegistros FROM classes_copy;
	
	DELETE FROM classes_copy
	WHERE department = l_suicidioProfissional.Department;
	
	DBMS_OUTPUT.PUT_LINE('Total de registros antes do DELETE: '||v_totalRegistros);
	SELECT COUNT(*) INTO v_totalRegistros FROM classes_copy;
	DBMS_OUTPUT.PUT_LINE('Total de registros depois do DELETE: '||v_totalRegistros);
	ROLLBACK;
END ;