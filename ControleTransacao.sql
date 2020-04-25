--implementa controle de transação
DECLARE
	v_NumFinal NUMBER ;
BEGIN
	FOR cont IN 1..50 LOOP
		INSERT INTO temp_table(num_col)
		VALUES(cont);
		v_NumFinal := v_NumFinal + 1;
		IF v_NumFinal = 50 THEN
			COMMIT;
			v_NumFinal := 0;
		END IF;
	END LOOP;
END;