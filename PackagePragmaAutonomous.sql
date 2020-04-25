CREATE OR REPLACE PACKAGE Auto2 AS	
	PROCEDURE P;
END Auto2;

CREATE OR REPLACE PACKAGE BODY Auto2 AS
	PROCEDURE P IS	
		PRAGMA AUTONOMOUS_TRANSACTION;
	BEGIN
		INSERT INTO temp_table
		VALUES(13,'PT');
		COMMIT;
	END P;
END Auto2;

xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

BEGIN
	Auto2.P;
	INSERT INTO temp_table
	VALUES(45,'PTB');
	ROLLBACK;
END;


xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

--Abaixo irá dar erro, pois a package não é independente
CREATE OR REPLACE PACKAGE Auto3 AS
	PRAGMA AUTONOMOUS_TRANSACTION;
	PROCEDURE P;
	PROCEDURE Q;
END Auto3;