DECLARE
	/*variáveis de saída para armazenar os resultados da consulta*/
	v_studentId students.id%TYPE;
	v_FirstName students.first_name%TYPE;
	v_LastName students.last_name%TYPE;
	/*variável de vinculação utilizada na consulta*/
	v_Major students.major%TYPE := 'Computer Science';
	/*declaração do cursor*/
	CURSOR c_Students IS
		SELECT id, first_name, last_name FROM students
		WHERE major = p_Major;
BEGIN
	/*identifica as linhas no conjunto ativo e prepara p outros processamentos de dados*/
	OPEN c_Students;
	LOOP
		/*Recupera CADA LINHA do conjunto ativo em variáveis PL/SQL*/
		FETCH c_Students INTO v_studentId, v_FirstName, v_LastName;
		/*Se não houver outras linhas p buscar, sai do loop*/
		EXIT WHEN c_Students%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(v_studentId||': '||v_FirstName||' '||v_LastName);
	END LOOP;
	/*libera os recursos utilizados pela consulta*/
	CLOSE c_Students;
END;