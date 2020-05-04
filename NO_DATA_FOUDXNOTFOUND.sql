DECLARE
	--registro p/ armazenar as informações da sala
	v_StudentReg students%ROWTYPE;
BEGIN
	--recupera as informações (cursor implícito – SELECT … INTO)
	SELECT * INTO v_StudentReg FROM students
	WHERE id = 56;
	--a instrução a seguir nunca será executada, uma vez que o controle passa imediatamente
	-- para o handler de exceção
	IF SQL%NOTFOUND THEN
		DBMS_OUTPUT.PUT_LINE('SQL%NOTFOUND is true');
	END IF;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND levantado');
END;
