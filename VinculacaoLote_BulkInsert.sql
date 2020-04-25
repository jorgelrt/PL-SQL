--realiza a inserção 500 vezes(cada insert é feito individualmente)
--Esse bloco utiliza um índice por tabela, que é semelhante a um array
DECLARE
	TYPE t_Numbers IS TABLE OF temp_table.num_col%TYPE
		INDEX BY BINARY_INTEGER;
	TYPE t_Chars IS TABLE OF temp_table.char_col%TYPE
		INDEX BY BINARY_INTEGER;
	
	v_Numbers t_Numbers;
	v_Chars t_Chars;
BEGIN
	--preencher os arrays com 500 linhas
	FOR v_Count IN 1..500 LOOP
		v_Numbers(v_Count) := v_Count;
		v_Chars(v_Count) := 'Row number: '||v_Count;
	END LOOP;
	--e insere no BD
	FOR v_Count IN 1..500 LOOP
		INSERT INTO temp_table
		VALUES(v_Numbers(v_Count),v_Chars(v_Count));
	END LOOP;
END;

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--abaixo passamos a TABELA INTEIRA PL/SQL para SQL por meio de um ÚNICO passo
--conhecido como VINCULAÇÃO EM LOTE (Bulk)
DECLARE
	TYPE t_Numbers IS TABLE OF temp_table.num_col%TYPE
		INDEX BY BINARY_INTEGER;
	TYPE t_Chars IS TABLE OF temp_table.char_col%TYPE
		INDEX BY BINARY_INTEGER;
		
	v_Numbers t_Numbers;
	v_Chars t_Chars;
BEGIN
	--preenche o array com 500 linhas
	FOR v_Count IN 1..500 LOOP
		v_Numbers(v_Count) := v_Count;
		v_Chars(v_Count) := 'Row number: '||v_Count;
	END LOOP;
	--inserção no BD utilizando vinculação de volume BULK
	FORALL v_Count IN 1..500
		INSERT INTO temp_table
		VALUES(v_Numbers(v_Count),v_Chars(v_Count));
END;