/*
Ilustra o comportamento de exceções não-tratadas e de variáveis OUT. Se p_RAISE for TRUE, então um erro não-tratado
é levantado. Se p_RAISE for FALSE, a procedure é concluida
*/
CREATE OR REPLACE PROCEDURE RaiseError(
				p_Raise in BOOLEAN, 
				p_ParametroA OUT NUMBER) AS
BEGIN
	p_ParametroA := 7;
	
	--Mesmo se atribuissemos 7 a p_ParametroA, essa exceção não-tratada faria com que o controle retornasse imediatamente
	--sem retornar 7 para o parametro real associado com p_ParametroA
	IF (p_Raise) THEN
		RAISE DUP_VAL_ON_INDEX;
	ELSE
		--simplesmente retorna sem erro. Isso retornará 7 para o parametro real
		RETURN;
	END IF;
END RaiseError;
	
--Se chamássemos RaiseError com o seguinte bloco
DECLARE
	v_TempVar NUMBER := 1;
BEGIN
	DBMS_OUTPUT.PUT_LINE('Valor inicial = '||v_TempVar);
	RaiseError(FALSE,v_TempVar);
	DBMS_OUTPUT.PUT_LINE('Valor após sucesso da chamada a procedure: '||v_TempVar);
	
	v_TempVar := 2;
	DBMS_OUTPUT.PUT_LINE('Valor antes da 2º chamada da procedure = '||v_TempVar);
	RaiseError(TRUE,v_TempVar);
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Valor após a exceção na 2º chamada = '||v_TempVar);
END;
	
