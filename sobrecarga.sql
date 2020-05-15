CREATE OR REPLACE TYPE t1 AS OBJECT(
	f NUMBER
);
/
CREATE OR REPLACE TYPE t2 AS OBJECT(
	f NUMBER
);
/
CREATE OR REPLACE PACKAGE OverLoad AS
	PROCEDURE Proc(p_Parametro1 IN t1);
	PROCEDURE Proc(p_Parametro1 IN t2);
END OverLoad;
/
CREATE OR REPLACE PACKAGE BODY OverLoad AS
	PROCEDURE Proc(p_Parametro1 IN t1) IS
	BEGIN
		DBMS_OUTPUT.PUT_LINE('Proc(t1): '||p_Parametro1.f);
	END Proc;
	
	PROCEDURE Proc(p_Parametro1 IN t2) IS
	BEGIN
		DBMS_OUTPUT.PUT_LINE('Proc(t2): '||p_Parametro1.f);
	END Proc;
END OverLoad;
/	
DECLARE
	v_Obj1 t1 := t1(1);
	v_Obj2 t2 := t2(1);
BEGIN
	OverLoad.Proc1(v_Obj1);
	OverLoad.Proc1(v_Obj2);
END;