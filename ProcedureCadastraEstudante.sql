CREATE OR REPLACE PROCEDURE CadastraEstudante(p_FirstName students.first_name%TYPE,
											  p_LastName students.last_name%TYPE,
											  p_major students.major%TYPE,
											  p_current_credits students.current_credits%TYPE) AS
	v_ID students.ID%TYPE;										  
	v_RegStudent students%ROWTYPE;
BEGIN
	SELECT student_sequence.NEXTVAL INTO v_ID FROM DUAL;
	
	INSERT INTO students
	VALUES(v_ID, p_FirstName, p_LastName, p_major, p_current_credits) 
	RETURNING v_ID, p_FirstName, p_LastName, p_major, p_current_credits INTO  v_RegStudent;
	
	DBMS_OUTPUT.PUT_LINE('Estudante: '||v_RegStudent.first_name||' '||v_RegStudent.last_name||' cadastrado com sucesso');
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('EXCEÇÃO LEVANTADA');
END;