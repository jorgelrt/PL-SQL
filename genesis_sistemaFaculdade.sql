--drop table students cascade constraints;
create table students(
id number(5) primary key,
first_name varchar2(20),
last_name varchar2(20),
major varchar2(30),
current_credits number(3));

--drop sequence student_sequence;
create sequence student_sequence
increment by 1
start with 10000;

--truncate table students;
--armazena informações sobre os alunos q estão na instituição de ensino
insert into students
values(student_sequence.nextval, 'Scott', 'Smith','Computer Science',11);
insert into students
values(student_sequence.nextval, 'Margaret', 'Mason', 'History', 4);
insert into students
values(student_sequence.nextval, 'Joane', 'Junebug', 'Computer Science', 8);
insert into students
values(student_sequence.nextval, 'Manish', 'Murgratoid', 'Economics', 8);
insert into students
values(student_sequence.nextval, 'Patrick', 'Poll', 'History', 4);
insert into students
values(student_sequence.nextval, 'Timothy', 'Taller', 'History', 4);
insert into students
values(student_sequence.nextval, 'Barbara', 'Blues', 'Economics', 7);
insert into students
values(student_sequence.nextval, 'David', 'Dinsmore', 'Music', 4);
insert into students
values(student_sequence.nextval, 'Ester', 'Elegant', 'Nutricion', 8);
insert into students
values(student_sequence.nextval, 'Rose', 'Riznit', 'Music', 7);
insert into students
values(student_sequence.nextval, 'Rita', 'Razmataz', 'Nutricion', 8);
insert into students
values(student_sequence.nextval, 'Shay', 'Shariatpanahy', 'Computer Science', 3);
--commit;
--armazena estatisticas sobre os diferentes cursos
create table major_stats(
major varchar2(30),
total_credits number,
total_students number);
insert into major_stats
values('Computer Science',22,3);
insert into major_stats
values('History',12,3);
insert into major_stats
values('Economics',15,2);
insert into major_stats
values('Music',11,2);
insert into major_stats
values('Nutricion',16,2);
--commit
--armazena informações sobre as salas de aulas disponiveis
create table rooms(
room_id number(5) primary key,
building varchar2(15),
room_number number(4),
number_seats number(4),
description varchar2(50));

create sequence room_sequence
start with 20000
increment by 1;

Insert into ROOMS (ROOM_ID,BUILDING,ROOM_NUMBER,NUMBER_SEATS,DESCRIPTION) values (room_sequence.nextval,'Building 7','201','1000','Large lecture hall');
Insert into ROOMS (ROOM_ID,BUILDING,ROOM_NUMBER,NUMBER_SEATS,DESCRIPTION) values (room_sequence.nextval,'Building 6','101','500','Small lecture hall');
Insert into ROOMS (ROOM_ID,BUILDING,ROOM_NUMBER,NUMBER_SEATS,DESCRIPTION) values (room_sequence.nextval,'Building 6','150','50','Discussion Room A');
Insert into ROOMS (ROOM_ID,BUILDING,ROOM_NUMBER,NUMBER_SEATS,DESCRIPTION) values (room_sequence.nextval,'Building 6','160','50','Discussion Room B');
Insert into ROOMS (ROOM_ID,BUILDING,ROOM_NUMBER,NUMBER_SEATS,DESCRIPTION) values (room_sequence.nextval,'Building 6','170','50','Discussion Room C');
Insert into ROOMS (ROOM_ID,BUILDING,ROOM_NUMBER,NUMBER_SEATS,DESCRIPTION) values (room_sequence.nextval,'Music Building','100','10','Music Practic Room');
Insert into ROOMS (ROOM_ID,BUILDING,ROOM_NUMBER,NUMBER_SEATS,DESCRIPTION) values (room_sequence.nextval,'Music Building','200','1000','Concert Room');
Insert into ROOMS (ROOM_ID,BUILDING,ROOM_NUMBER,NUMBER_SEATS,DESCRIPTION) values (room_sequence.nextval,'Building 7','300','75','Discussion Room D');
Insert into ROOMS (ROOM_ID,BUILDING,ROOM_NUMBER,NUMBER_SEATS,DESCRIPTION) values (room_sequence.nextval,'Building 7','310','50','Discussion Room E');



--descreve as aulas disponiveis para os alunos
create table classes(
department char(3),
course number(3),
description varchar2(2000),
max_students number(3),
current_students number(3),
num_credits number(1),
room_id number(5),
constraint classes_department_course
primary key(department, course),
constraint classes_room_id
foreign key(room_id) references rooms(room_id));

insert into classes
values('HIS',101,'History 101', 30, 11, 4, 20000);
insert into classes
values('HIS',301,'History 301', 30, 0, 4, 20004);
insert into classes
values('CS',101,'Computer Science 101', 50, 0, 4, 20001);
insert into classes
values('ECN',203,'Economics 203', 15, 0, 3, 20002);
insert into classes
values('CS',102,'Computer Science 102', 35, 3, 4, 20003);
insert into classes
values('MUS',410,'Music 410', 5, 4, 3, 20005);
insert into classes
values('ECN',101,'Economics 101', 50, 0, 4, 20007);
insert into classes
values('NUT',307,'Nutricion 307', 20, 2, 4, 20008);
insert into classes
values('MUS',100,'Music 100', 100, 0, 3, null);

--armazena as informações sobre as aulas que os alunos estão atualmente participando
create table registered_students(
student_id number(5) not null,
department char(3) not null,
course number(3) not null,
grade char(1),
constraint rs_grade
check(grade in ('A','B','C','D','E')),
constraint rs_student_id
foreign key(student_id) references students(id),
constraint rs_department_coourse
foreign key(department, course)
references classes(department, course));

insert into registered_students
values(10000,'CS',102,'A');
insert into registered_students
values(10002,'CS',102,'B');
insert into registered_students
values(10003,'CS',102,'C');
insert into registered_students
values(10000,'HIS',101,'A');
insert into registered_students
values(10001,'HIS',101,'B');
insert into registered_students
values(10002,'HIS',101,'B');
insert into registered_students
values(10003,'HIS',101,'A');
insert into registered_students
values(10004,'HIS',101,'C');
insert into registered_students
values(10005,'HIS',101,'C');
insert into registered_students
values(10006,'HIS',101,'E');
insert into registered_students
values(10007,'HIS',101,'B');
insert into registered_students
values(10008,'HIS',101,'A');
insert into registered_students
values(10009,'HIS',101,'D');
insert into registered_students
values(10010,'HIS',101,'A');
insert into registered_students
values(10008,'NUT',307,'A');
insert into registered_students
values(10010,'NUT',307,'A');
insert into registered_students
values(10009,'MUS',410,'B');
insert into registered_students
values(10006,'MUS',410,'E');
insert into registered_students
values(10011,'MUS',410,'B');
insert into registered_students
values(10000,'MUS',410,'B');

--utilizada para registrar as alterações realizadas em registered_students
create table RS_audit(
change_type char(1) not null,
changed_by varchar2(8) not null,
timestampp date  not null,
old_student_id number(5),
old_department char(3),
old_course number(3),
old_grade char(1),
new_student_id number(5),
new_department char(3),
new_course number(3),
new_grade char(1));

--utilizada para registrar erros do oracle
create table log_table(
code number,
message varchar2(200),
info varchar2(100));

--utilizada para armazenar dados temporarios que não são necessariamente relevantes às outras informações
create table temp_table(
num_col number,
char_col varchar2(60));

--tipos e objetos que modelarão a biblioteca utilizadas pelos alunos
CREATE TABLE books(
catalog_number NUMBER(4) PRIMARY KEY,
title VARCHAR2(40),
author1 VARCHAR2(40),
author2 VARCHAR2(40),
author3 VARCHAR2(40),
author4 VARCHAR2(40));

--author1 à author4 -> last_name, first_name
INSERT INTO books(catalog_number,title,author1)
VALUES(1000,'Oracle8i Advanced PL/SQL Programming','Urman, Scott');
INSERT INTO books(catalog_number,title,author1,author2,author3)
VALUES(1001,'Oracle8i: A Beginner Guide','Abbey, Michael','Corey, Michael J.','Abranson, Ian');
INSERT INTO books(catalog_number,title,author1,author2,author3)
VALUES(1002,'Oracle8 Tuning','Corey, Michael J.','Abbey, Michael','Dechichio, Daniel J.');
INSERT INTO books(catalog_number,title,author1,author2)
VALUES(2001,'A History of the World','Arlington, Arlene','Verity, Victor');
INSERT INTO books(catalog_number,title,author1)
VALUES(3001,'Bach and the Modern World','Foo, Fred');
INSERT INTO books(catalog_number,title,author1)
VALUES(3002,'Introduction to the Piano','Morenson, Mary');

CREATE OR REPLACE TYPE BookList AS VARRAY(10) OF NUMBER;
/
--contém uma lista dos números do catálogo de livros requeridos p/ uma dada classe
CREATE TABLE class_material(
department CHAR(3),
course NUMBER(3),
required_reading BookList);

INSERT INTO CLASS_MATERIAL



--Da mesma maneira que o VARRAY,A tabela aninhada pode ser armazenada como uma coluna BD
--Cada linha da tabela BD pode conter uma diferente tabela aninhada
--Vamos modelar o catálogo da biblioteca
CREATE OR REPLACE TYPE StudentList AS TABLE OF NUMBER(5);
/
--A tabela library_catalog contém 4 colunas, incluindo o nro de catálogo dos livros
--na coleção e uma tabela aninhada que contém os IDS dos alunos que tem registro de emprestimo
--de cópias(checked_out)
CREATE TABLE library_catalog(
catalog_number NUMBER(4), FOREIGN KEY(catalog_number) REFERENCES books(catalog_number),
num_copies NUMBER,
num_out NUMBER,
checked_out StudentList) NESTED TABLE checked_out STORE AS co_tab;
--A clásula NESTED TABLE é requerida p/ cada tabela aninhada em uma tabela BD.
--Essa cláusula indica o nome da tabela de armazenamento "co_tab"
--A coluna checked_out armazenará um REF na tabela co_tab, onde a lista de IDS dos alunos
--serão armazenados

--Primeiramente a coleção deve ser criada e inicializada
DECLARE
	v_CSBooks BookList := BookList(1000, 1001, 1002);
	v_HistoryBooks BookList := BookList(2001);
BEGIN
	--INSERT utilizando um varray recentemente construído de 2 elemrntos
	INSERT INTO class_material
	VALUES('MUS',100,BookList(3001,3002));
	
	--INSERT utilizando um varray previamente inicializado de 3 elementos
	INSERT INTO class_material
	VALUES('CS',102,v_CSBooks);
	
	--INSERT utilizando um varray previamente inicializado de 1 elementos
	INSERT INTO class_material
	VALUES('HIS',101,v_HistoryBooks);
END;
/

DECLARE
	v_StudentList1 StudentList := StudentList(10000, 10002, 10003);
	v_StudentList2 StudentList := StudentList(10000, 10002, 10003);
	v_StudentList3 StudentList := StudentList(10000, 10002, 10003);
BEGIN
	--Primeiramente insere as linhas com as tabelas aninhadas NULL
	INSERT INTO library_catalog(catalog_number, num_copies, num_out)
	VALUES(1000, 20, 3);
	INSERT INTO library_catalog(catalog_number, num_copies, num_out)
	VALUES(1001, 20, 3);
	INSERT INTO library_catalog(catalog_number, num_copies, num_out)
	VALUES(1002, 10, 3);
	INSERT INTO library_catalog(catalog_number, num_copies, num_out)
	VALUES(2001, 50, 0);
	INSERT INTO library_catalog(catalog_number, num_copies, num_out)
	VALUES(3001, 5, 0);
	INSERT INTO library_catalog(catalog_number, num_copies, num_out)
	VALUES(3002, 5, 1);
	
	--Agora atualiza utilizando variáveis PLSQL
	UPDATE library_catalog
	SET checked_out = v_StudentList1
	WHERE catalog_number = 1000;
	UPDATE library_catalog
	SET checked_out = v_StudentList2
	WHERE catalog_number = 1001;
	UPDATE library_catalog
	SET checked_out = v_StudentList3
	WHERE catalog_number = 1002;
	--e atualiza a última linha utilizando uma nova variável
	UPDATE library_catalog
	SET checked_out = StudentList(10009)
	WHERE catalog_number = 3002;
END;


--A procedure PrintRequired - demonstra como fazer um SELECT de um VARRAY
CREATE OR REPLACE PROCEDURE PrintRequired(p_Department IN class_material.department%TYPE,
p_Course IN class_material.course%TYPE) IS
	v_Books class_material.required_reading%TYPE;
	v_Title books.title%TYPE;
BEGIN
	SELECT required_reading INTO v_Books FROM class_material 
	WHERE department = p_Department
	AND course = p_Course;
	
	DBMS_OUTPUT.PUT('Required reading for '||RTRIM(p_Department));
	DBMS_OUTPUT.PUT_LINE(' '||p_Course||': ');
	
	FOR v_Index IN 1..v_Books.COUNT LOOP
		SELECT title INTO v_Title FROM books
		WHERE catalog_number = v_Books(v_Index);
		
		DBMS_OUTPUT.PUT_LINE(' '||v_Books(v_Index)||': '||v_Title);
	END LOOP;
END PrintRequired;

--Dando saída em toda a tabela
DECLARE
	CURSOR c_Course IS
		SELECT department, course FROM class_material
		ORDER BY department;
BEGIN
	FOR v_Rec IN c_Course LOOP
		PrintRequired(v_Rec.department, v_Rec.course);
	END LOOP;
END;
	
--CONSULTANDO TABELAS ANINHADAS
CREATE OR REPLACE PACKAGE Library AS
--imprime os alunos que devolveram um livro em particular
PROCEDURE PrintCheckedOut(p_CatalogNumber IN library_catalog.catalog_number%TYPE);
--Faz o registro de saída do livro com p_CatalogNumber do aluno com P_StudentID
PROCEDURE CheckOut(p_CatalogNumber IN library_catalog.catalog_number%TYPE, p_StudentID IN NUMBER);
--Faz o registro de entrada do livro com p_CatalogNumber do aluno com P_StudentID
PROCEDURE CheckIn(p_CatalogNumber IN library_catalog.catalog_number%TYPE, p_StudentID IN NUMBER);
END Library;
/
CREATE OR REPLACE PACKAGE BODY Library AS
PROCEDURE PrintCheckedOut(p_CatalogNumber IN library_catalog.catalog_number%TYPE) IS
	v_StudentList StudentList;
	v_Student students%ROWTYPE;
	v_Book books%ROWTYPE;
	v_FoundOne BOOLEAN := FALSE;
BEGIN
	--select tabela aninhada
	SELECT checked_out INTO v_StudentList FROM library_catalog
	WHERE catalog_number = p_CatalogNumber;
	
	SELECT * INTO v_Book FROM books
	WHERE catalog_number = p_CatalogNumber;
	
	DBMS_OUTPUT.PUT_LINE('Students who have '||v_Book.catalog_number||': '||v_Book.title||' checked out: ');
	--faz um loop pela tabela aninhada e imprime os nomes dos alunos
	IF v_StudentList IS NOT NULL THEN
		FOR v_Index IN 1..v_StudentList.COUNT LOOP	
			v_FoundOne := TRUE;
			SELECT * INTO v_Student FROM students
			WHERE ID = v_StudentList(v_Index);
			
			DBMS_OUTPUT.PUT_LINE(' '||v_Student.first_name||' '||v_Student.last_name);
		END LOOP;
	END IF;
	
	IF NOT v_FoundOne THEN
		DBMS_OUTPUT.PUT_LINE(' nada');
	END IF;
			
END PrintCheckedOut;
--Faz o registro de saída do livro com p_CatalogNumber do aluno com P_StudentID
PROCEDURE CheckOut(p_CatalogNumber IN library_catalog.catalog_number%TYPE, p_StudentID IN NUMBER) IS
	v_NumCopies library_catalog.num_copies%TYPE;
	v_NumOut library_catalog.num_out%TYPE;
	v_CheckedOut library_catalog.checked_out%TYPE;
BEGIN
	--Primeiro verifica se o livro existe e se há uma cópia disponível de saída a ser registrada
	BEGIN
		SELECT num_copies, num_out, checked_out INTO v_NumCopies, v_NumOut, v_CheckedOut FROM library_catalog
		WHERE catalog_number = p_CatalogNumber
		FOR UPDATE;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RAISE_APPLICATION_ERROR(-20000,'Nao há livro catalogado com este número '||p_CatalogNumber||' na biblioteca');		
	END;
	
	IF v_NumCopies = v_NumOut THEN
		RAISE_APPLICATION_ERROR(-20001,'Todas as cópias do livro '||p_CatalogNumber||' estão emprestadas');
	END IF;
	
	--Pesquisa a lista p/ verificar se esse aluno já tem esse livro
	IF v_CheckedOut IS NOT NULL THEN
		FOR v_Counter IN 1..v_CheckedOut.COUNT LOOP
			IF v_CheckedOut(v_Counter) = p_StudentID THEN
				RAISE_APPLICATION_ERROR(-20002,'Student '||p_StudentID||' já tekm op livro '||p_CatalogNumber);
			END IF;
		END LOOP;
	END IF;
	--Abre espaço na lista
	IF v_CheckedOut IS NULL THEN
		v_CheckedOut := StudentList(NULL);
	ELSE	
		v_CheckedOut.EXTEND;
	END IF;
	--Faz o registro de saída do livro adicionando-o à lista
	v_CheckedOut(v_CheckedOut.COUNT) := p_StudentID;
	--e devolve ao BD adicionando +1
	UPDATE library_catalog
	SET checked_out = v_CheckedOut,
	    num_out = num_out + 1
	WHERE catalog_number = p_CatalogNumber;
END CheckOut;
--Faz o registro de entrada do livro com p_CatalogNumber do aluno com p_StudentID
PROCEDURE CheckIn(p_CatalogNumber IN library_catalog.catalog_number%TYPE, p_StudentID IN NUMBER) IS
	v_NumCopies library_catalog.num_copies%TYPE;
	v_NumOut library_catalog.num_out%TYPE;
	v_CheckedOut library_catalog.checked_out%TYPE;
	v_AlreadyCheckedOut BOOLEAN := FALSE;
BEGIN
	--Primeiro verifica se o livro existe
	BEGIN
		SELECT num_copies, num_out, checked_out INTO v_NumCopies, v_NumOut, v_CheckedOut FROM library_catalog
		WHERE catalog_number = p_CatalogNumber
		FOR UPDATE;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RAISE_APPLICATION_ERROR(-20000,'Não há livro catalogado p/ '||p_CatalogNumber||' na biblioteca');
	END;
	--Pesquisa a lista p/ verificar se esse aluno já não tem um registro de saída desse livro
	IF v_CheckedOut IS NOT NULL THEN
		FOR v_Counter IN 1..v_CheckedOut.COUNT LOOP
			IF v_CheckedOut(v_Counter) = p_StudentID THEN
				v_AlreadyCheckedOut := TRUE;
				--exclue-o da lista
				v_CheckedOut.DELETE(v_Counter);
			END IF;
		END LOOP;
	END IF;
	
	IF NOT v_AlreadyCheckedOut THEN
		RAISE_APPLICATION_ERROR(-20003,'Student '||p_StudentID||' Nçao possui o livro '||p_CatalogNumber);
	END IF;
	--devolve p/ o BD, subitraindo de num_out
	UPDATE library_catalog
	SET checked_out = v_CheckedOut,
	    num_out = num_out -1
	WHERE catalog_number = p_CatalogNumber;
END CheckIn;
END Library;
	
--saida de Library.PrintCheckedOut
BEGIN
	Library.PrintCheckedOut(1000);
END;

--utilizando as procedures CheckIn e CheckOut
DECLARE
	CURSOR c_History101Students IS
		SELECT student_id FROM registered_students
		WHERE department = 'HIS'
		AND course = 101;
	
	v_RequiredReading class_material.required_reading%TYPE;
BEGIN
	--Faz o registro de saída dos livros requeridos p/ todos os alunos em HIS 101
	--Obtém os livros requeridos p/ HIS 101
	SELECT required_reading INTO v_RequiredReading FROM class_material
	WHERE department = 'HIS'
	AND course = 101;
	--Faz um loop pelos alunos de History 101
	FOR v_Rec IN c_History101Students LOOP
		--Faz um loop pela lista de leitura requerida
		FOR v_Index IN 1..v_RequiredReading.COUNT LOOP
			--e realiza a saida do livro
			Library.CheckOut(v_RequiredReading(v_Index),v_Rec.student_id);
		END LOOP;
	END LOOP;
	--Imprime os alunos que agora retiraram o livro
	Library.PrintCheckedOut(2001);
	--Faz o registro de entrada do livro p/ alguns alunos
	Library.CheckIn(2001,10001);
	Library.CheckIn(2001,10002);
	Library.CheckIn(2001,10003);
	
	--imprime novamente
	Library.PrintCheckedOut(2001);
END;




