DECLARE
	CURSOR c_Student IS
		SELECT * FROM students WHERE id = 56;
		
	v_Student c_Student%ROWTYPE;
BEGIN
	OPEN c_Student;
	FETCH c_Student INTO v_Student;
	IF c_Student%NOTFOUND THEN
		DBMS_OUTPUT.PUT_LINE('NAO HA DADOS');
	ELSE 
		WHILE c_Student%FOUND LOOP
			DBMS_OUTPUT.PUT_LINE(v_Student.id||' - '||v_Student.first_name);
			FETCH c_Student INTO v_Student ;
		END LOOP;
	END IF;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND');
	CLOSE c_Student;
END;


