CREATE OR REPLACE PROCEDURE CallProc1(p_ParametroA IN VARCHAR2 := NULL) AS
BEGIN
	DBMS_OUTPUT.PUT_LINE('CallProc1 called with '||p_ParametroA);
END CallProc1;

CREATE OR REPLACE PROCEDURE CallProc2(p_ParametroA IN OUT VARCHAR2) AS
BEGIN
	DBMS_OUTPUT.PUT_LINE('CallProc2 called with '||p_ParametroA);
	p_ParametroA := p_ParametroA||' returned!';
END CallProc2;

CREATE OR REPLACE FUNCTION CallFunc(p_ParametroA IN VARCHAR2)
	RETURN VARCHAR2 AS
BEGIN
	DBMS_OUTPUT.PUT_LINE('CallFunc called with '||p_ParametroA);
	RETURN p_ParametroA;
END CallFunc;


VÁLIDOS
CALL CallProc1('Hello!');

CALL CallProc1();

variable v_Output VARCHAR2(50);
CALL CallFunc('Hello!') INTO :v_Output;

PRINT v_Output;

CALL CallProc2(:v_Output);

PRINT v_Output;

DECLARE
	v_Result VARCHAR2(50);
BEGIN
	EXECUTE IMMEDIATE 'CALL CallProc1(''Hello from PLSQL'')';
	EXECUTE IMMEDIATE
		'CALL CallFunc(''Hello from PLSQL'') INTO :v_REsult'
		USING OUT v_Result;
END;
