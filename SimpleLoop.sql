--igual ao While
DECLARE
	v_LoopCounter BINARY_INTEGER := 1;
BEGIN
	LOOP
		INSERT INTO temp_table(num_col)
		VALUES(v_LoopCounter);
		v_LoopCounter := v_LoopCounter + 1;
		EXIT WHEN v_LoopCounter > 50;
	END LOOP;
END;