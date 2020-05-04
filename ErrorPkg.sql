/*
Package genérica de tratamento de erro,que armazenará informações gerais sobre erros
	DBMS_UTILITY.FORMAT_ERROR_STACK 
	DBMS_UTILITY.FORMAT_CALL_STACK
*/
CREATE OR REPLACE PACKAGE ErrorPkg AS
/*
ponto de entrada p/ tratamento erros. 
	HandlerAll 	-	deve ser chamado a partir de todos os handlers de exceção
	p_Top 		-	deve ser TRUE apenas no nível mais superior da Procedure aninhada
*/
PROCEDURE HandlerAll(p_Top BOOLEAN);
/* imprime o erro e as pilhas de chamadas p/ dado módulo e número de sequencia */
PROCEDURE PrintStacks(p_Modulo IN errors.modulo%TYPE, p_SeqNum IN errors.seq_number%TYPE);
/*
Retrocede as pilhas de chamadas e de erros e armazena-as nas tabelas errors e call_stacks. Retorna o número
de sequencia sob o qual o erro é armazenado.
Se p_CommitFlag = TRUE então as inserções são confirmadas
A fim de utilizar StoreStacks, um erro deve ser sido confirmado.
Portanto, HandlerAll deveria ter sido chamado com p_Top = TRUE.
*/
PROCEDURE StoreStacks(p_Modulo IN errors.modulo%TYPE,p_SeqNum OUT errors.seq_number%TYPE,p_CommitFlag BOOLEAN DEFAULT FALSE);
END ErrorPkg;
/
CREATE OR REPLACE PACKAGE BODY ErrorPkg AS
	v_NewLine CONSTANT CHAR(1) := CHR(10);
	v_Handled BOOLEAN := FALSE;
	v_ErrorStack VARCHAR2(2000);
	v_CallStack VARCHAR2(2000);
	
PROCEDURE HandlerAll(p_Top BOOLEAN) IS
BEGIN
	IF p_Top THEN	
		v_Handled := FALSE;
	ELSIF NOT v_Handled THEN
		v_Handled := TRUE;
		v_ErrorStack := DBMS_UTILITY.FORMAT_ERROR_STACK; 
		v_CallStack := DBMS_UTILITY.FORMAT_CALL_STACK;
	END IF;	
END HandlerAll;

PROCEDURE PrintStacks(p_Modulo IN errors.modulo%TYPE, p_SeqNum IN errors.seq_number%TYPE) IS
	v_CarimboTempo errors.carimbo_tempo%TYPE ;
	v_ErrorMessage errors.error_message%TYPE ;
	CURSOR c_CallCur IS
		SELECT object_handler, line_num, nome_objeto FROM call_stacks
		WHERE modulo = p_Modulo
		AND seq_number = p_SeqNum
		ORDER BY call_order;
		
	CURSOR c_ErrorCur IS
		SELECT facility, error_number, error_message FROM error_stacks
		WHERE modulo = p_Modulo
		AND seq_number = p_SeqNum
		ORDER BY error_order;
		
BEGIN
	SELECT carimbo_tempo, error_message INTO v_CarimboTempo, v_ErrorMessage FROM errors
	WHERE modulo = p_Modulo
	AND seq_number = p_SeqNum ;
	--Envia p/ saída as informações gerais sobre os erros
	DBMS_OUTPUT.PUT(TO_CHAR(v_CarimboTempo,'DD/MM/YYYY HH24:MI:SS'));
	DBMS_OUTPUT.PUT('Modulo: '||p_Modulo);
	DBMS_OUTPUT.PUT('Erro # '||p_SeqNum||': ');
	DBMS_OUTPUT.PUT_LINE(v_ErrorMessage);
	--Envia p/ saída a pilha de chamadas
	DBMS_OUTPUT.PUT_LINE('Chamada de Pilha:');
	DBMS_OUTPUT.PUT_LINE(' Objeto Handler Numero Linha Nome Objeto');
	DBMS_OUTPUT.PUT_LINE(' -------------- ------------ -----------');
	
	FOR v_CallRec in c_CallCur LOOP
		DBMS_OUTPUT.PUT(RPAD(' '||v_CallRec.object_handler, 15));
		DBMS_OUTPUT.PUT(RPAD(' '||TO_CHAR(v_CallRec.line_num), 13));
		DBMS_OUTPUT.PUT_LINE(' '||v_CallRec.nome_objeto);
	END LOOP;
	--Envia p/ saída a pilha de erros
	DBMS_OUTPUT.PUT_LINE('Pilha de Erro: ');
	
	FOR v_ErrorRec in c_ErrorCur LOOP
		DBMS_OUTPUT.PUT(' '||v_ErrorRec.facility||'-');
		DBMS_OUTPUT.PUT(TO_CHAR(v_ErrorRec.error_number)||': ');
		DBMS_OUTPUT.PUT_LINE(v_ErrorRec.error_message);
	END LOOP;
END PrintStacks;

PROCEDURE StoreStacks(p_Modulo IN errors.modulo%TYPE,p_SeqNum OUT errors.seq_number%TYPE,p_CommitFlag BOOLEAN DEFAULT FALSE) IS
	v_SeqNum NUMBER;
	v_Index NUMBER;
	v_Length NUMBER;
	v_End NUMBER;
	
	v_Call VARCHAR2(100);
	v_CallOrder NUMBER := 1;
	v_Handle call_stacks.object_handler%TYPE;
	v_LineNum call_stacks.line_num%TYPE;
	v_ObjectName call_stacks.nome_objeto%TYPE;
	
	v_Error VARCHAR2(120);
	v_ErrorOrder NUMBER := 1;
	v_Facility error_stacks.facility%TYPE;
	v_ErrNum error_stacks.error_number%TYPE;
	v_ErrMsg error_stacks.error_message%TYPE;
	
	v_FirstErrNum errors.error_number%TYPE;
	v_FirstErrMsg errors.error_message%TYPE;
BEGIN
	--Primeiro obtém o número de sequencia do erro
	SELECT error_seq.NEXTVAL INTO v_SeqNum FROM DUAL;
	p_SeqNum := v_SeqNum;
	--Insere a primeira parte das informações de cabeçalho na tabela errors
	INSERT INTO errors(modulo, seq_number, error_stack, call_stack, carimbo_tempo)
	VALUES(p_Modulo, v_SeqNum, v_ErrorStack, v_CallStack, SYSDATE);
	--Retrocede a pilha de erro p/ obter cada erro. Fazemos isso varrendo a string da pilha de erro.
	--Inicia com o índice no começo da string
	v_Index := 1;
	--Faz um loop pela string, localizando cada linha nova. Uma nova linha termina cada erro na pilha
	WHILE v_Index < LENGTH(v_ErrorStack) LOOP
		--v_End é a posição da nova linha
		v_End := INSTR(v_ErrorStack, v_NewLine, v_Index);
		--Portanto, o erro está entre o índice atual e a nova linha
		v_Error := SUBSTR(v_ErrorStack, v_Index, v_End - v_Index);
		--Na próxima iteração pula o erro atual
		v_Index := v_Index + LENGTH(v_Error)+1;
		--Um erro se parece com 'facility-number: mesg'. Precisamos obter cada pedaço da inserção
		--Primeiro, o recurso são os primeiros 3 caracteres do erro
		v_Facility := SUBSTR(v_Error, 1, 3);
		--Remove facility e o traço (sempre 4 caracteres)
		v_Error := SUBSTR(v_Error, 5);
		--Agora podemos obter o número do erro
		v_ErrNum := TO_NUMBER(SUBSTR(v_Error, 1, INSTR(v_Error, ':') -1));
		--Remove o número do erro, dois ponto e espaço(sempre 7 caracteres)
		v_Error := SUBSTR(v_Error, 8);
		--O que permaneceu na mensagem de erro
		v_ErrMsg := v_Error;
		--Insere os erros e obtém o número do primeiro erro e de mensagem enquanto estamos nele
		INSERT INTO error_stacks(modulo, seq_number, error_order, facility, error_number, error_message)
		VALUES(p_Modulo, p_SeqNum, v_ErrorOrder, v_Facility, v_ErrNum, v_ErrMsg);
		IF v_ErrorOrder = 1 THEN
			v_FirstErrNum := v_ErrNum;
			v_FirstErrMsg := v_Facility||'-'||TO_NUMBER(v_ErrNum)||': '||v_ErrMsg;
		END IF;
		v_ErrorOrder := v_ErrorOrder +1;
	END LOOP;
	--Atualiza a tabela de erros com a mensagem e o código
	UPDATE errors
	SET error_number = v_FirstErrNum,
	    error_message = v_FirstErrMsg
	WHERE modulo = p_Modulo
	AND seq_number = v_SeqNum;
	--Agora precisamos retroceder a pilha de chamadas, para retirar cada chamada
	--fazemos isso varrendo a string da pilha de chamadas. Inicia com o índice
	--depois da primeira ocorrência de 'nome' e da nova linha
	v_Index := INSTR(v_CallStack, 'name') + 5;
	--Fazer um loop pela string, localizando cada linha nova. Uma nova linha termina cada chamada na pilha
	WHILE v_Index < LENGTH(v_CallStack) LOOP
		--v_End é a posição da nova linha
		v_End := INSTR(v_CallStack, v_NewLine, v_Index);
		--Portanto, a chamada está entre o índice atual e a nova linha
		v_Call := SUBSTR(v_CallStack, v_Index, v_End - v_Index);
		--Pula a chamada atual
		v_Index := v_Index + LENGTH(v_Call)+1;
		--Dentro de uma chamada, temos o handler de objeto, depois o número da linha, em seguida o nome de objeto
		--separado por espaços. Na inserção, precisamos separá-los
		
		--Remove os espaços em branco da chamada
		v_Call := LTRIM(v_Call);
		--Primeiro, obtém o handler de objeto
		v_Handle := SUBSTR(v_Call, 1, INSTR(v_Call, ' '));
		--Agora, remove o handle de objeto, em seguida os espaços em branco da chamada
		v_Call := SUBSTR(v_Call, LENGTH(v_Handle)+1);
		v_Call := LTRIM(v_Call);
		--Agora podemos obter o número da linha
		v_LineNum := TO_NUMBER(SUBSTR(v_Call, 1, INSTR(V_Call,' ')));
		--Remove o número da linha e os espaços em branco
		v_Call := SUBSTR(v_Call, LENGTH(v_LineNum)+1);
		v_Call := LTRIM(v_Call);
		--O que permaneceu é o nome de objeto
		v_ObjectName := v_Call;
		--Insere todas as chamadas exceto a chamada p/ ErrorPkg
		IF v_CallOrder > 1 THEN
			INSERT INTO call_stacks(modulo, seq_number, call_order, object_handler, line_num, nome_objeto)
			VALUES(p_Modulo, v_SeqNum, v_CallOrder, v_Handle, v_LineNum, v_ObjectName);
		END IF;
		v_CallOrder := v_CallOrder +1;
	END LOOP;
	IF p_CommitFlag THEN
		COMMIT;
	END IF;
END StoreStacks;
END ErrorPkg;	
/
