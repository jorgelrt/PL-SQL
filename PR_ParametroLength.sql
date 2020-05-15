CREATE OR REPLACE PROCEDURE ParametroLength(
	p_Parametro1 IN OUT VARCHAR2, 
	p_Parametro2 IN OUT NUMBER) AS
BEGIN
	p_Parametro1 := 'abcdefghijklmno'; --tamanho 15 caracteres
	p_Parametro2 := 12.3;
END ParametroLength;



DECLARE
	v_Variavel1 VARCHAR2(40);
	v_Variavel2 NUMBER(7,3);
BEGIN
	ParametroLength(v_Variavel1, v_Variavel2);
END;


DECLARE
	v_Variavel1 VARCHAR2(10);
	v_Variavel2 NUMBER(7,3);
BEGIN
	ParametroLength(v_Variavel1, v_Variavel2);
END;

ERRO na linha 1:
ORA-06502: PL/SQL: erro: buffer de string de caracteres pequeno demais numÚrico
ou de valor
ORA-06512: em "C##HR.PARAMETROLENGTH", line 5
ORA-06512: em line 5