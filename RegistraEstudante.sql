/*Registra o aluno identificado pelo parâmetro p_StudentID na classe identificada pelos parâmetros
p_Department e p_Course*/
CREATE OR REPLACE PROCEDURE RegistraEstudante( p_StudentID IN students.id%TYPE,
											   p_Department IN classes.department%TYPE,
											   p_Course IN classes.course%TYPE) AS
	v_CurrentStudents classes.max_students%TYPE;
	v_MaxStudents classes.max_students%TYPE;
	v_NumCredits classes.num_credits%TYPE;
	--v_Count NUMBER;
	--v_MsgError VARCHAR2(200);
BEGIN
		/*Determina o número atual de alunos inscritos e o número máximo de alunos que tem permissão
		de inscrição*/
		BEGIN
			SELECT current_students, max_students, num_credits 
				INTO v_CurrentStudents, v_MaxStudents, v_NumCredits FROM classes
			WHERE course = p_Course
			AND department = p_Department;
			
			/*Certifica-se de que há lugar suficiente p esse aluno adicional*/
			IF v_CurrentStudents + 1 > v_MaxStudents THEN
				RAISE_APPLICATION_ERROR(-20000,'Não há vaga disponível no '||p_Department||' '||p_Course);
			END IF;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				/*Não existem informações sobre a classe passada*/
				RAISE_APPLICATION_ERROR(-20001,p_Department||' '||p_Course||' não existe');
		END;
		
		/*Assegura que o aluno não esta atualmente inscrito*/
		SELECT COUNT(*) INTO v_Count FROM registered_students
		WHERE student_id = p_StudentID
		AND department = p_Department
		AND course = p_Course;
		IF v_Count = 1 THEN
			RAISE_APPLICATION_ERROR(-20002,'Estudante '||p_StudentID||' já esta cadastrado para '||p_Department||' '||p_Course);
		END IF;
		/*Há vagas e o aluno ainda não está matriculado na classe. Atualização das tabelas envolvidas*/
		INSERT INTO registered_students(student_id, department, course)
		VALUES(p_StudentID, p_Department, p_Course);
		
		UPDATE students
		SET current_credits = current_credits + v_NumCredits
		WHERE id = p_StudentID;
		
		UPDATE classes
		SET current_students = current_students + 1
		WHERE course = p_Course
		AND department = p_Department;

EXCEPTION
	WHEN OTHERS THEN
		v_MsgError := SUBSTR(SQLERRM,1,199);
		DBMS_OUTPUT.PUT_LINE(v_MsgError);
			
END RegistraEstudante;