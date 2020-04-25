DECLARE
	--cursor p recuperar as informações sobre alunos de História
	CURSOR c_HistoryStudents IS
		SELECT id, first_name, last_name FROM students
		WHERE major = 'History';
		
	--declarar um registro p/ armazenar as informações buscadas
	v_StudentData c_HistoryStudents%ROWTYPE;		
BEGIN
	--abre o cursor e inicializa o conjunto ativo
	OPEN c_HistoryStudents;
	--recupera a primeira linha, para configurar o LOOP WHILE
	FETCH c_HistoryStudents INTO v_StudentData;
	
	--continua a fazer o loop enquanto houver outras linhas a serem buscadas
	WHILE c_HistoryStudents%FOUND LOOP
		--o processamento consiste em inscrever cada aluno na History 301 inserindo-os na tabela
		--registered_students. Também registra o primeiro e último nome em temp_table
		INSERT INTO registered_students(student_id, department, course)
		VALUES(v_StudentData.id, 'HIS', 301);
		INSERT INTO temp_table
		VALUES(v_StudentData.id, v_StudentData.first_name||' '||v_StudentData.last_name);
		--recupera a próxima linha. A condição %FOUND será verificada antes do LOOP continuar novamente
		FETCH c_HistoryStudents INTO v_StudentData;
	END LOOP;
	--libera recursos utilizados pelo cursor
	CLOSE c_HistoryStudents;
END;