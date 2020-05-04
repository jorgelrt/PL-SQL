--bloco abaixo, atualizará os créditos atuais de TODOS os alunos inscritos em HIS 101
DECLARE
	--Numero de créditos a ser adicionado ao total de cada aluno
	v_NumCredits classes.num_credits%TYPE ;
	
	--Este cursor selecionará apenas aqueles alunos que estão atualmente inscritos em HIS 101
	CURSOR c_RegisteredStudents IS
		SELECT * FROM students
		WHERE id IN (SELECT student_id FROM registered_students
					 WHERE department = 'HIS'
					 AND course = 101)
		FOR UPDATE OF current_credits;
BEGIN
	--OPEN
	--configurar o cursor de loop de busca 
	FOR v_StudentInfo IN c_RegisteredStudents LOOP
		SELECT num_credits INTO v_NumCredits FROM classes
		WHERE department = 'HIS'
		AND course = 101;
		--FETCH
		--atualiza a linha que acabamos de recuperar do cursor
		UPDATE students
		SET current_credits = current_credits + v_NumCredits
		WHERE CURRENT OF c_RegisteredStudents;		
	END LOOP;
	--confirma o nosso trabalho e libera o bloqueio
	COMMIT;
END;

select first_name,current_credits from students where id in (select student_id from registered_students where department='HIS' and course=101);
FIRST_NAME           CURRENT_CREDITS
-------------------- ---------------
Scott                             11
Margaret                           4
Joane                              8
Manish                             8
Patrick                            4
Timothy                            4
Barbara                            7
David                              4
Ester                              8
Rose                               7
Rita                               8

11 linhas selecionadas.