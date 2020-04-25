CREATE OR REPLACE TRIGGER SomenteNumerosPositivos
	BEFORE INSERT OR UPDATE OF num_col
	ON temp_table
	FOR EACH ROW
	BEGIN
		IF :new.num_col < 0 THEN
			RAISE_APPLICATION_ERROR(-20100, 'Por favor inserir valor positivo');
		END IF;
	END SomenteNumerosPositivos;