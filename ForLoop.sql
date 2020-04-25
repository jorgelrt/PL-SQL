BEGIN
	FOR v_LoopCounter IN 1..50 LOOP
		INSERT INTO temp_table(num_col)
		VALUES(v_LoopCounter);
	END LOOP;
END;