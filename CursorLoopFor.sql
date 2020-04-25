DECLARE
	--cursor p recuperar as informações sobre alunos de História
	CURSOR c_HistoryStudents IS
		SELECT id, first_name, last_name FROM students
		WHERE major = 'History';
BEGIN
	--Inicia o loop. Um OPEN implícito de c_HistoryStudents é feito AQUI
	FOR v_StudentData IN c_HistoryStudents LOOP
		--um FETCH implícito é feito aqui. c_HistoryStudents%NOTFOUND também são implicitamente
		INSERT INTO registered_students(student_id, department, course)
		VALUES(v_StudentData.id, 'HIS', 301);
		INSERT INTO temp_table
		VALUES(v_StudentData.id, v_StudentData.first_name||' '||v_StudentData.last_name); 
	END LOOP;
	--agora que o loop foi concluído, um CLOSE implícito de c_HistoryStudents é feito
END;