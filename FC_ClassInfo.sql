/*
Retorna FULL se a classe estiver completamente cheia
Retorna SOME ROOM se a classe estiver mais de 80%
Retorna MORE ROOM se a classe estiver mais de 60%
Retorna LOTS OF ROOM se a classe estiver menos de 60%
Retorna EMPTY se não houver alunos inscritos
*/
CREATE OR REPLACE FUNCTION ClassInfo(p_Department classes.department%TYPE,
                                     p_Course classes.course%TYPE) RETURN VARCHAR2 IS
	v_CurrentStudents NUMBER;
	v_MaxStudents NUMBER;
	v_PercentFull NUMBER;
BEGIN
--obtém os alunos atuais e o máximo p/ o curso solicitado
	SELECT current_students, max_students INTO v_CurrentStudents, v_MaxStudents FROM classes
	WHERE department = p_Department 
	AND course = p_Course;
	
	--calcula a porcentagem atual
	v_PercentFull := v_CurrentStudents / v_MaxStudents * 100;
	
	IF v_PercentFull = 100 THEN
		RETURN 'FULL';
	ELSIF v_PercentFull > 80 THEN
		RETURN 'SOME ROOM';
	ELSIF v_PercentFull > 60 THEN
		RETURN 'MORE ROOM';
	ELSIF v_PercentFull > 0 THEN
		RETURN 'LOTS OF ROOM';
	ELSE
		RETURN 'EMPTY';	
END ClassInfo;