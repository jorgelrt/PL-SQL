DECLARE
	--declara as variáveis para conter as informações sobre os alunos que estão se especializando em história
	v_Id students.id%TYPE;
	v_FirstName students.first_name%TYPE;
	v_LastName students.last_name%TYPE;
	--Cursor para recuperar as informações sobre alunos de História
	CURSOR c_HistoryStudents IS
		SELECT id, first_name, last_name FROM students
		WHERE major = 'History';
BEGIN
	--Abre o cursor e inicializa o conjunto ativo
	OPEN c_HistoryStudents;
	LOOP
		--recupera as informações sobre o próximo alunos
		FETCH c_HistoryStudents INTO v_Id, v_FirstName, v_LastName;
		--sai do loop qdo não houver outras linhas p buscar
		EXIT WHEN c_HistoryStudents%NOTFOUND;
		--o processamento consiste em inscrever cada aluno na History 301 inserindo-os na tabela
		--registered_students. Também registra o primeiro e último nome em temp_table
		INSERT INTO registered_students(student_id, department, course)
		VALUES(v_Id,'HIS',301);
		INSERT INTO temp_table
		VALUES(v_Id,v_FirstName||' '||v_LastName);
	END LOOP;
	--libera os recursos alocados pelo cursor
	CLOSE c_HistoryStudents;
END;


xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--o código abaixo é muito semelhante ao anterior, exceto que a instrução EXIT WHEN foi movida 
--p o final do loop, o que significa q o último registro do cursor será inserido 2 vezes
DECLARE
	--declara as variáveis para conter as informações sobre os alunos que estão se especializando em história
	v_Id students.id%TYPE;
	v_FirstName students.first_name%TYPE;
	v_LastName students.last_name%TYPE;
	--Cursor para recuperar as informações sobre alunos de História
	CURSOR c_HistoryStudents IS
		SELECT id, first_name, last_name FROM students
		WHERE major = 'History';
BEGIN
	OPEN c_HistoryStudents;
	LOOP
		--recupera as informações sobre o próximo alunos
		FETCH c_HistoryStudents INTO v_Id, v_FirstName, v_LastName;
		--o processamento consiste em inscrever cada aluno na History 301 inserindo-os na tabela
		--registered_students. Também registra o primeiro e último nome em temp_table
		INSERT INTO registered_students(student_id, department, course)
		VALUES(v_Id,'HIS',301);
		INSERT INTO temp_table
		VALUES(v_Id,v_FirstName||' '||v_LastName);
		--sai do loop qdo não houver outras linhas p buscar
		EXIT WHEN c_HistoryStudents%NOTFOUND;
	END LOOP;
	--libera os recursos alocados pelo cursor
	CLOSE c_HistoryStudents;
END;