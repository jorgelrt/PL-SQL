DECLARE
	TYPE t_SampleRecord IS RECORD(
		Contador NUMBER(4),
		Name VARCHAR2(10) := 'Scott',
		EffectiveDate Date,
		Description VARCHAR2(45) NOT NULL := 'Unknown'
	);
	
	v_Sample1 t_SampleRecord;
	v_Sample2 t_SampleRecord;
		
BEGIN
	v_Sample1.EffectiveDate := SYSDATE;
	v_Sample2.Description := 'Pesto Pizza';
	
	DBMS_OUTPUT.PUT_LINE(TO_CHAR(v_Sample1.EffectiveDate,'DD/MM/YYYY HH:MI:SS'));
	--DBMS_OUTPUT.PUT_LINE(v_Sample1);
	DBMS_OUTPUT.PUT_LINE(v_Sample2.Description);
	
	v_Sample1 := v_Sample2;
	
	DBMS_OUTPUT.PUT_LINE(TO_CHAR(v_Sample1.EffectiveDate,'DD/MM/YYYY HH:MI:SS'));
	DBMS_OUTPUT.PUT_LINE(v_Sample2.Description);
END;


xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


DECLARE
	TYPE t_Rec1Type IS RECORD(
		field1 NUMBER,
		field2 VARCHAR2(5)
	);
	TYPE t_Rec2Type IS RECORD(
		field1 NUMBER,
		field2 VARCHAR2(5)
	);
	
	v_Rec1 t_Rec1Type;
	v_Rec2 t_Rec2Type;
BEGIN
	v_Rec1.field1 := 1;
	v_Rec1.field2 := 'JLRT';
	v_Rec2.field1 := 2;
	v_Rec2.field2 := 'AL';
	DBMS_OUTPUT.PUT_LINE(v_Rec1.field1||' - '||v_Rec1.field2);
	DBMS_OUTPUT.PUT_LINE(v_Rec2.field1||' - '||v_Rec2.field2);
	
	v_Rec1 := v_Rec2; --Dá erro!
	
	v_Rec1.field1 := v_Rec2.field1;
	
	DBMS_OUTPUT.PUT_LINE(v_Rec1.field1||' - '||v_Rec1.field2);
	DBMS_OUTPUT.PUT_LINE(v_Rec2.field1||' - '||v_Rec2.field2);
END;