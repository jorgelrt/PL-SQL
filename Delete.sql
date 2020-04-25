DECLARE
	v_StudentCutoff NUMBER := 10;
BEGIN
	DELETE FROM classes
	WHERE current_students < v_StudentCutoff;
	
	DELETE FROM students
	WHERE current_credits = 0
	AND major = 'Economics';
END;