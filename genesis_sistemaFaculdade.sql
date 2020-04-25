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