CREATE OR REPLACE PROCEDURE RaiseError2 (
				p_Raise IN BOOLEAN,
				p_ParametroA OUT NOCOPY NUMBER)  AS
BEGIN
	p_ParametroA := 7;
	IF p_Raise THEN
		RAISE DUP_VAL_ON_INDEX;
	ELSE
		RETURN;
	END IF;
END RaiseError2;


--p_ParametroA será passado por referência

DECLARE
	v_TempVar NUMBER := 1;
BEGIN
	DBMS_OUTPUT.PUT_LINE('Valor inicial: '||v_TempVar);
	RaiseError2(FALSE,v_TempVar);
	DBMS_OUTPUT.PUT_LINE('Valor antes da chamada procedure: '||v_TempVar);
	
	v_TempVar := 2;
	DBMS_OUTPUT.PUT_LINE('Valor antes de realizar a procedure: '||v_TempVar);
	RaiseError2(TRUE,v_TempVar);
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Valor após a exceção da procedure: '||v_TempVar);
END;