DECLARE
	v_StudentId NUMBER(5) := 1;
	v_FirstName VARCHAR2(20);
BEGIN
	SELECT first_name INTO v_FirstName FROM students
	WHERE id = v_StudentId;
	BEGIN
		INSERT INTO log_table(info)
		VALUES('Hello from a nested block');
	END;
EXCEPTION	
	WHEN NO_DATA_FOUND THEN
	BEGIN
		INSERT INTO log_table(info)
		VALUES('Student id 1 does not exist');
	EXCEPTION
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('Error inserting into log_table');
	END;
END;