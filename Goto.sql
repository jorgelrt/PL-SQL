DECLARE
	v_Counter BINARY_INTEGER := 1;
BEGIN
	LOOP
		INSERT INTO temp_table
		VALUES(v_Counter,'Loop count');
		v_Counter := v_Counter + 1;
		IF v_Counter >= 50 THEN
			GOTO l_EndOfLoop;
		END IF;
	END LOOP;
	
	<<l_EndOfLoop>>
	INSERT INTO temp_table(char_col)
	VALUES('Done!');
	DBMS_OUTPUT.PUT_LINE('INSERT DONE');
END;
