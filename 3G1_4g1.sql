DECLARE
	/*Declaração das variáveis*/
	v_NovaMateria VARCHAR2(10) := 'HTML';
	v_Nome VARCHAR2(100) := 'Alex Lendel';
BEGIN
	/*Atualiza a tabela de alunos*/
	UPDATE alunos
	SET materia = v_NovaMateria
	WHERE Nome = v_Nome;
	/*Verifica se o registro foi localizado. Se não foi, então realiza o insert do registro*/
	IF SQL%NOTFOUND THEN
		INSERT INTO alunos(ID, nome, materia)
		VALUES(alunos_sequence.NEXTVAL, v_Nome, v_NovaMateria);
	END IF;	
END;