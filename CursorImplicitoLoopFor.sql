BEGIN
	--inicia o loop. Um OPEN implícito é feito aqui.
	FOR v_StudentData IN (SELECT id, first_name, last_name FROM students
						  WHERE major = 'History';) LOOP
		--um FETCH implícito é feito aqui e %NOTFOUND é verificado
		INSERT INTO registered_students(student_id, department, course)
		VALUES(v_StudentData.id, 'HIS', 301);
		INSERT INTO temp_table
		VALUES(v_StudentData.id, v_StudentData.first_name||' '||v_StudentData.last_name);
	END LOOP;
	--agora que o loop foi concluído, um CLOSE implícito é feito		
END;