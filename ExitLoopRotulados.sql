DECLARE
	Text VARCHAR(2000);
BEGIN
	<<l_Outer>>
	FOR v_OuterIndex IN 1..4 LOOP
		Text:='';
		DBMS_OUTPUT.PUT_LINE(' |'||v_OuterIndex||'| ');
		<<l_Inner>>
		FOR v_InnerIndex IN 2..4 LOOP
			Text:='|'||Text||'|'||v_InnerIndex;
			--DBMS_OUTPUT.PUT_LINE(' |'||v_InnerIndex||'| ');
			DBMS_OUTPUT.PUT_LINE(Text);
			IF v_OuterIndex > 2 THEN
				EXIT l_Outer;
			END IF;
		END LOOP l_Inner;
	END LOOP l_Outer;
END;