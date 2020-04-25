DECLARE
	v_Major students.major%TYPE;
	v_CreditIncrease NUMBER := 3;
BEGIN
	v_Major := 'History';
	UPDATE students
	SET current_credits = current_credits + v_CreditIncrease
	WHERE major = v_Major;
	--atualiza TODOS registros na tabela, pois não há cláusula WHERE
	UPDATE temp_table
	SET num_col = 1,
	    char_col = 'abcd';
END;

