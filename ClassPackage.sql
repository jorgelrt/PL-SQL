CREATE OR REPLACE PACKAGE ClassPackage AS
	--add um novo aluno na classe especificada
	PROCEDURE AddStudent(p_StudentID IN students.id%TYPE, 
						 p_Department IN classes.department%TYPE, 
						 p_Course IN classes.course%TYPE);
						 
	--remove o aluno especificado
	PROCEDURE RemStudent(p_StudentID IN students.id%TYPE,
						 p_Department IN classes.department%TYPE,
						 p_Course IN classes.course%TYPE);
						 
	--EXCEPTION levantada por RemStudent
	e_StudentNotRegistered EXCEPTION;
	
	--Tipo de tabela utilizada p/ manter as informações sobre o aluno
	TYPE t_StudentIDTable IS TABLE OF students.id%TYPE
		INDEX BY BINARY_INTEGER;
		
	--Retorna uma tabela PLSQL contendo os alunos atualmente na classe especificada
	PROCEDURE ClassList(p_Department IN classes.department%TYPE,
						p_Course IN classes.course%TYPE,
						p_IDs	OUT t_StudentIDTable,
						p_NumStudents IN OUT BINARY_INTEGER);
END ClassPackage;
/
CREATE OR REPLACE PACKAGE BODY ClassPackage AS
	--add um novo aluno na classe especificada
	PROCEDURE AddStudent(p_StudentID IN students.id%TYPE, 
						 p_Department IN classes.department%TYPE, 
						 p_Course IN classes.course%TYPE) IS
	BEGIN
		INSERT INTO registered_students(student_id, department, course)
		VALUES(p_StudentID, p_Department, p_Course);
	END AddStudent;
	
	--remove o aluno especificado
	PROCEDURE RemStudent(p_StudentID IN students.id%TYPE,
						 p_Department IN classes.department%TYPE,
						 p_Course IN classes.course%TYPE) IS
	BEGIN
		DELETE FROM registered_students
		WHERE student_id = p_StudentID
		AND department = p_Department
		AND course = p_Course;
		--verifica se a operação DELETE foi bem sucedida. Se não houver correspondencia c/ nenhuma linha, levanta um erro
		IF SQL%NOTFOUND THEN	
			RAISE e_StudentNotRegistered;
		END IF;
	END RemStudent;
	
	--Retorna uma tabela PLSQL contendo os alunos atualmente na classe especificada
	PROCEDURE ClassList(p_Department IN classes.department%TYPE,
						p_Course IN classes.course%TYPE,
						p_IDs OUT t_StudentIDTable,
						p_NumStudents IN OUT BINARY_INTEGER) IS
	v_StudentID registered_students.student_id%TYPE;
	
	--Cursor local p/ buscar os alunos inscritos
	CURSOR c_RegisteredStudents IS
		SELECT student_id FROM registered_students
		WHERE department = p_Department
		AND course = p_Course;
	BEGIN
		/*
		p_NumStudents será o índice de tabela. Ele iniciará em 0 e será incrementado a cada passagem pelo loop
		de busca. No final do loop, ele terá o número de linhas buscadas e, portanto o número de linhas retornadas
		em p_IDs
		*/
		p_NumStudents := 0;
		OPEN c_RegisteredStudents;
		LOOP
			FETCH c_RegisteredStudents INTO v_StudentID;
			EXIT WHEN c_RegisteredStudents%NOTFOUND;
			
			p_NumStudents := p_NumStudents + 1;
			p_IDs(p_NumStudents) := v_StudentID;
		END LOOP;
	END ClassList;
	
END ClassPackage;

AdvertÛncia: Package Body criado com erros de compilaþÒo.

SQL> show errors;
Erros para PACKAGE BODY CLASSPACKAGE:

LINE/COL ERROR
-------- -----------------------------------------------------------------
20/11    PLS-00323: o subprograma ou o cursor 'CLASSLIST' estß declarado
         em uma especificaþÒo de pacote e deve ser definido no texto do
         pacote