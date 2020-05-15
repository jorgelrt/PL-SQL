CREATE OR REPLACE PROCEDURE ParametroLength2(
	p_Parametro1 IN OUT VARCHAR2, 
	p_Parametro2 IN OUT students.current_credits%TYPE) AS
BEGIN
	p_Parametro1 := 'abcdefghijklmno'; --tamanho 15 caracteres
	p_Parametro2 := 12345;
END ParametroLength2;



DECLARE
	v_Variavel1 VARCHAR2(1);
	v_Variavel2 NUMBER; --sem restrições
BEGIN
	ParametroLength2(v_Variavel1, v_Variavel2);
END;


ERRO na linha 1:
ORA-06502: PL/SQL: erro: buffer de string de caracteres pequeno demais numÚrico
ou de valor
ORA-06512: em "C##HR.PARAMETROLENGTH2", line 5
ORA-06512: em line 5
