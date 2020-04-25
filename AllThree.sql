DECLARE
	v_StudentId NUMBER(5) := 1;
	v_FirstName VARCHAR2(20);
BEGIN
	SELECT first_name INTO v_FirstName FROM students
	WHERE id = v_StudentId;
EXCEPTION	
	WHEN NO_DATA_FOUND THEN
		INSERT INTO log_table(info)
		VALUES('Student of id 1 does not exist');
END;