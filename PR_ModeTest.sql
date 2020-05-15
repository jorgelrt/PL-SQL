CREATE OR REPLACE PROCEDURE ModeTest(p_ParametroEntradaIn IN NUMBER,
                                      p_ParametroSaidaOut OUT NUMBER,
									  p_ParametroMistoInOut IN OUT NUMBER) IS
	v_VariavelLocal NUMBER := 0;
BEGIN
	DBMS_OUTPUT.PUT_LINE('Exec ModeTeste: ');
	
	IF (p_ParametroEntradaIn IS NULL) THEN
		DBMS_OUTPUT.PUT('  p_ParametroEntradaIn IS NULL');
	ELSE
		DBMS_OUTPUT.PUT('  p_ParametroEntradaIn = '||p_ParametroEntradaIn);
	END IF;
	
	IF (p_ParametroSaidaOut IS NULL) THEN
		DBMS_OUTPUT.PUT('  p_ParametroSaidaOut IS NULL');
	ELSE
		DBMS_OUTPUT.PUT('  p_ParametroSaidaOut = '||p_ParametroSaidaOut);
	END IF;
	
	IF (p_ParametroMistoInOut IS NULL) THEN
		DBMS_OUTPUT.PUT_LINE('  p_ParametroMistoInOut IS NULL');
	ELSE
		DBMS_OUTPUT.PUT_LINE('  p_ParametroMistoInOut = '||p_ParametroMistoInOut);
	END IF;
	
	--válido - uma vez que estamos lendo do parâmetro IN e não gravando com ele
	v_VariavelLocal := p_ParametroEntradaIn;
	
	--inválido/ilegal - uma vez que estamos gravando no parametro IN
	-- p_ParametroEntradaIn := 7;
	
	--válido - uma vez que estamos gravando no parametro OUT
	p_ParametroSaidaOut := 7;
	
	--Possivelmente ilegal - pode ser ilegal ler a partir de um parametro OUT
	v_VariavelLocal := p_ParametroSaidaOut;
	
	--Válido - uma vez que estamos lendo de um parâmetro IN OUT
	v_VariavelLocal := p_ParametroMistoInOut;
	
	--Válido - uma vez uq estamos gravando
	p_ParametroMistoInOut := 8;
	
	DBMS_OUTPUT.PUT_LINE('Após processamento ModeTeste');
	IF (p_ParametroEntradaIn IS NULL) THEN
		DBMS_OUTPUT.PUT_LINE('p_ParametroEntradaIn IS NULL');
	ELSE
		DBMS_OUTPUT.PUT('p_ParametroEntradaIn = '||p_ParametroEntradaIn);
	END IF;
	
	IF (p_ParametroSaidaOut IS NULL) THEN
		DBMS_OUTPUT.PUT(' p_ParametroSaidaOut IS NULL');
	ELSE
		DBMS_OUTPUT.PUT(' p_ParametroSaidaOut = '||p_ParametroSaidaOut);
	END IF;
	
	IF (p_ParametroMistoInOut IS NULL) THEN
		DBMS_OUTPUT.PUT_LINE('  p_ParametroMistoInOut IS NULL');
	ELSE
		DBMS_OUTPUT.PUT_LINE('  p_ParametroMistoInOut = '||p_ParametroMistoInOut);
	END IF;
END ModeTest;


--Passando valores entre parâmetros formais e reais

DECLARE
	v_In NUMBER := 1;
	v_Out NUMBER := 2;
	v_InOut NUMBER := 3;
BEGIN
	DBMS_OUTPUT.PUT_LINE('Antes de chamar ModeTest: ');
	DBMS_OUTPUT.PUT_LINE('v_In = '||v_In||' v_Out = '||v_Out||' v_InOut = '||v_InOut);
	ModeTest(v_In, v_Out, v_InOut);
	DBMS_OUTPUT.PUT_LINE('Depois de chamar ModeTest: ');
	DBMS_OUTPUT.PUT_LINE('v_In = '||v_In||' v_Out = '||v_Out||' v_InOut = '||v_InOut);
END;