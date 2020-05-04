BEGIN
	UPDATE students
	SET first_name = 'Dr. Enéas'
	WHERE id = 56;
	--Se a instrução acima não corresponder a nenhuma linha
	IF SQL%NOTFOUND THEN
		DBMS_OUTPUT.PUT_LINE('Caiu no NOTFOUND - Atributo');
	END IF;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('Caiu no NO_DATA_FOUND - Exceção');
END;