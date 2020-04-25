DECLARE
	TYPE t_StudentRecord IS RECORD(
		Id students.ID%TYPE ,
		FirstName students.first_name%TYPE,
		LastName students.last_name%TYPE);
	
	v_Student t_StudentRecord;
BEGIN
	SELECT id, first_name, last_name INTO v_Student FROM students
	WHERE id = 10000;
	DBMS_OUTPUT.PUT_LINE('ID: '||v_Student.Id||' - Nome:'||v_Student.FirstName||' Sobrenome:'||v_Student.LastName);

END;
