DECLARE
	v_StudentRecord students%ROWTYPE;
	v_Department classes.department%TYPE;
	v_Course classes.course%TYPE;
BEGIN
	SELECT * INTO v_StudentRecord FROM students
	WHERE id = 10000;
	
	SELECT department, course INTO v_Department, v_Course FROM classes
	WHERE room_id = 20003;
	
	DBMS_OUTPUT.PUT_LINE(v_StudentRecord.id||','||v_StudentRecord.first_name);
	DBMS_OUTPUT.PUT_LINE(v_Department||' - '||v_Course);
END;