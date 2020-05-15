CREATE OR REPLACE PACKAGE CopyFast AS
--Tabela PLSQL dos alunos
TYPE StudentArray IS
	TABLE OF students%ROWTYPE;
	
	--tres procedures que recebem um parâmetro de StudentArray, de maneiras diferentes. Todas elas não fazem nada
	PROCEDURE PassStudents1(p_Parametro IN StudentArray);
	PROCEDURE PassStudents2(p_Parametro IN OUT StudentArray);
	PROCEDURE PassStudents3(p_Parametro IN OUT NOCOPY StudentArray);
	
	--Procedure de teste
	PROCEDURE Go;
END CopyFast;
/
CREATE OR REPLACE PACKAGE BODY CopyFast AS
PROCEDURE PassStudents1(p_Parametro IN StudentArray) IS
BEGIN
	NULL;
END;

PROCEDURE PassStudents2(p_Parametro IN OUT StudentArray) IS
BEGIN
	NULL;
END;

PROCEDURE PassStudents3(p_Parametro IN OUT NOCOPY StudentArray) IS
BEGIN
	NULL;
END;

PROCEDURE Go IS
	v_StudentArray StudentArray := StudentArray(NULL);
	v_StudentRec students%ROWTYPE;
	v_Time1 NUMBER;
	v_Time2 NUMBER;
	v_Time3 NUMBER;
	v_Time4 NUMBER;
BEGIN
	--Preenche o array com 50.001 cópias de registro de David Dinsmore
	SELECT * INTO v_StudentArray(1) FROM students
	WHERE id = 10007;
	v_StudentArray.EXTEND(50000,1);
	
	--chama cada versão de PassStudents e as cronometra. DBMS_UTILITY.GET_TIME retorna o tempo em centésimos de segundo
	v_Time1 := DBMS_UTILITY.GET_TIME;
	PassStudents1(v_StudentArray);
	v_Time2 := DBMS_UTILITY.GET_TIME;
	PassStudents2(v_StudentArray);
	v_Time3 := DBMS_UTILITY.GET_TIME;
	PassStudents3(v_StudentArray);
	v_Time4 := DBMS_UTILITY.GET_TIME;
	
	--Dá a saida dos resultados
	DBMS_OUTPUT.PUT_LINE('Tempo total IN: '||TO_CHAR((v_Time2 - v_Time1) / 100));
	DBMS_OUTPUT.PUT_LINE('Tempo total IN OUT: '||TO_CHAR((v_Time3 - v_Time2)/100));
	DBMS_OUTPUT.PUT_LINE('Tempo total IN OUT NOCOPY: '||TO_CHAR((v_Time4 - v_Time3)/100));
END Go;
END CopyFast;
	
	
	
END;