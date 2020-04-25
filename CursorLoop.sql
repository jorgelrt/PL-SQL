DECLARE
	v_FirstName VARCHAR2(100);
	v_LastName VARCHAR2(100);
	--declaração do cursor
	CURSOR c_Employees IS
		SELECT first_name, last_name FROM employees;
BEGIN
	--Inicia o processamento do cursor
	OPEN c_Employees;
	LOOP
	--recuperar a linha
		FETCH c_Employees INTO v_FirstName, v_LastName;
		EXIT WHEN c_Employees%NOTFOUND;
			dbms_output.put_line('Nome: '||v_FirstName||' '||v_LastName);
	END LOOP;
	--fecho o cursor
	CLOSE c_Employees;
END;