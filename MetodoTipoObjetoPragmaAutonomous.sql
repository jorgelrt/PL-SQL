CREATE OR REPLACE PROCEDURE Auto1 AS
	PRAGMA AUTONOMOUS_TRANSACTION;
	
	PROCEDURE local IS
		PRAGMA AUTONOMOUS_TRANSACTION;
	BEGIN
		INSERT INTO temp_table(num_col,char_col)
		VALUES(15,'Rodrigo Maia');
		COMMIT;
	END;
BEGIN
	local;
		INSERT INTO temp_table(num_col,char_col)
		VALUES(13,'Lula');
	ROLLBACK;
END;

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

BEGIN
	INSERT INTO temp_table
	VALUES(56, 'Dr. Eneas');
	Auto1;
	COMMIT;
END;