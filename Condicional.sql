DECLARE
	v_totalAlunos number;
BEGIN
	--recupera a qtd de alunos
	SELECT count(*) INTO v_totalAlunos FROM alunos;
	--Com base nesse valor, insere a linha apropriada em temp_table
	IF v_totalAlunos = 0 THEN
		INSERT INTO temp_table(char_col)
		VALUES('Nao existe alunos registrados');
		ELSIF v_totalAlunos < 5 THEN
			INSERT INTO temp_table(char_col)
			VALUES('Existem poucos alunos registrados');
		ELSIF v_totalAlunos < 10 THEN
			INSERT INTO temp_table(char_col)
			VALUES('Existem alguns alunos registrados');
		ELSE
			INSERT INTO temp_table(char_col)
			VALUES('Existem o esperado de alunos registrados');
	END IF;
END;	