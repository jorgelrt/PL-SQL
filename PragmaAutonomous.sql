CREATE OR REPLACE PROCEDURE AutonomousInsert AS
	PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
	INSERT INTO temp_table
	VALUES(10,'Hello from Autonomous');
	COMMIT;
END;


xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


BEGIN
	INSERT INTO temp_table
	VALUES(20,'Hello from the parent');
	AutonomousInsert;
	--ROLLBACK;
END;