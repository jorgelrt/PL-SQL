DECLARE
	v_NewRowID rowid;
	v_FirstName students.first_name%TYPE;
	v_LastName students.last_name%TYPE;
	v_Id students.id%TYPE;
BEGIN
	--rowid nova linha
	INSERT INTO students(id, first_name, last_name, major, current_credits)
	VALUES(student_sequence.NEXTVAL, 'Xavier', 'Xemes', 'Nutricion', 0)
	RETURNING rowid INTO v_NewRowID;
	
	DBMS_OUTPUT.PUT_LINE('Newly inserted rowid is '||v_NewRowID);
	--atualiza a nova linha e retorna nome e sobrenome
	UPDATE students
	SET current_credits = current_credits + 3
	WHERE rowid = v_NewRowID
	RETURNING first_name, last_name INTO v_FirstName, v_LastName;
	
	DBMS_OUTPUT.PUT_LINE('Nome: '||v_FirstName||' '||v_LastName);
	--Exclui a linha e retorna o ID
	DELETE FROM students
	WHERE rowid = v_NewRowID
	RETURNING ID INTO v_Id;
	
	DBMS_OUTPUT.PUT_LINE('ID of new row was '||v_Id);
END;