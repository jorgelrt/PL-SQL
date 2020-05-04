CREATE OR REPLACE PROCEDURE AddNewStudent(p_FirstName students.first_name%TYPE, 
                                          p_LastName students.last_name%TYPE,
                                          p_Major students.major%TYPE) AS
BEGIN
	INSERT INTO students(id,first_name,last_name,major,current_credits)
	VALUES(student_sequence.NEXTVAL,p_FirstName,p_LastName,p_Major,0);
END;