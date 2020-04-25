DECLARE
	v_StudentID students.id%TYPE;
BEGIN
	SELECT student_sequence.nextval INTO v_StudentID FROM dual;
	
	INSERT INTO students(id,first_name,last_name)
	VALUES(v_StudentID, 'Timothy', 'Taller');
	
	INSERT INTO students(id,first_name,last_name)
	VALUES(student_sequence.nextval, 'Patrick', 'Poll');
END;

xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

INSERT INTO temp_table
	SELECT * FROM temp_table;