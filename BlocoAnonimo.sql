SET SERVEROUTPUT ON;
DECLARE
	v_Num1 NUMBER := 1;
	v_Num2 NUMBER := 2;
	v_String1 VARCHAR2(50) := 'Hello world';
	v_String2 VARCHAR2(50) := '-- esta mensagem foi gerada pela PLSQL';
	v_OutPutStr VARCHAR2(50);
BEGIN
--insere duas linhas na tabela temp_table, utilizando os valores das variáveis
	INSERT INTO temp_table
	VALUES(v_Num1, v_String1);
	INSERT INTO temp_table
	VALUES(v_Num2, v_String2);
--consulta temp_table as duas linhas e imprime na tela
	SELECT char_col INTO v_OutPutStr FROM temp_table
	WHERE num_col = v_Num1;
	DBMS_OUTPUT.PUT_LINE(v_OutPutStr);
	SELECT char_col INTO v_OutPutStr FROM temp_table
	WHERE num_col = v_Num2;
	DBMS_OUTPUT.PUT_LINE(v_OutPutStr);
--revertendo as alterações executadas
	ROLLBACK;	
END;
	
	