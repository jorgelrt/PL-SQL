CREATE OR REPLACE PACKAGE ClassPackage2 AS
	--add um novo aluno na classe especificada
	PROCEDURE AddStudent(p_StudentID IN students.id%TYPE, 
						 p_Department IN classes.department%TYPE, 
						 p_Course IN classes.course%TYPE);
						 
	PROCEDURE AddStudent(p_FirstName IN students.first_name%TYPE,
						 p_LastName IN students.last_name%TYPE,
						 p_Department IN classes.department%TYPE, 
						 p_Course IN classes.course%TYPE);
						 
	--remove o aluno especificado
	PROCEDURE RemStudent(p_StudentID IN students.id%TYPE,
						 p_Department IN classes.department%TYPE,
						 p_Course IN classes.course%TYPE);
						 
	--EXCEPTION levantada por RemStudent
	e_StudentNotRegistered EXCEPTION;

	--Recurso que atualiza os alunos e as classes p/ refletir a alteração. Se p_Add for TRUE, então as tabelas são 
	--atualizadas p/ adição do aluno à classe. Se for FALSE, então elas são atualizadas p/ a remoção do aluno
	PROCEDURE UpdateStudentAndClasses(
						p_Add IN BOOLEAN,
						p_StudentID IN students.id%TYPE,
						p_Department IN classes.department%TYPE,
						p_Course IN classes.course%TYPE);
END ClassPackage2;
/
CREATE OR REPLACE PACKAGE BODY ClassPackage2 AS
	--add um novo aluno na classe especificada
	PROCEDURE AddStudent(p_StudentID IN students.id%TYPE, 
						 p_Department IN classes.department%TYPE, 
						 p_Course IN classes.course%TYPE) IS
	BEGIN
		INSERT INTO registered_students(student_id, department, course)
		VALUES(p_StudentID, p_Department, p_Course);
		
		UpdateStudentAndClasses(TRUE, p_StudentID, p_Department, p_Course);
		
	END AddStudent;
	
	PROCEDURE AddStudent(p_FirstName IN students.first_name%TYPE,
						 p_LastName IN students.last_name%TYPE,
						 p_Department IN classes.department%TYPE, 
						 p_Course IN classes.course%TYPE) IS
	v_StudentID students.id%TYPE;
	BEGIN
		SELECT id INTO v_StudentID FROM students
		WHERE first_name = p_FirstName
		AND last_name = p_LastName;
		
		--Agora podemos add o aluno por meio do ID
		INSERT INTO registered_students(student_id, department, course)
		VALUES(v_StudentID, p_Department, p_Course);
		
		UpdateStudentAndClasses(TRUE, v_StudentID, p_Department, p_Course);
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
		
		UpdateStudentAndClasses(FALSE, p_StudentID, p_Department, p_Course);
		
	END RemStudent;
	
	--Atualiza tabelas classes e students
	PROCEDURE UpdateStudentAndClasses(
						p_Add IN BOOLEAN,
						p_StudentID IN students.id%TYPE,
						p_Department IN classes.department%TYPE,
						p_Course IN classes.course%TYPE) IS
		--Numeros de créditos p/ classe solicitada
	v_NumCredits classes.num_credits%TYPE;
	BEGIN
		SELECT num_credits INTO v_NumCredits FROM classes
		WHERE department = p_Department
		AND course = p_Course;
		
		IF(p_Add) THEN
			--add NumCredits à carga de curso do aluno
			UPDATE students
			SET current_credits = current_credits + v_NumCredits
			WHERE ID = p_StudentID;
			
			--Aumenta current_students
			UPDATE classes
			SET current_students = current_students + 1
			WHERE department = p_Department
			AND course = p_Course;
		ELSE
			--remove NumCRedits da carga de curso dos alunos
			UPDATE students
			SET current_credits = current_credits - v_NumCredits 
			WHERE ID = p_StudentID;
			
			--diminui current_students
			UPDATE classes
			SET current_students = current_students - 1
			WHERE department = p_Department
			AND course = p_Course;
		END IF;		
	END UpdateStudentAndClasses;
	
END ClassPackage2;