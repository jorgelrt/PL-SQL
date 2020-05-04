CREATE SEQUENCE error_seq
START WITH 1
INCREMENT BY 1;

CREATE TABLE errors (
  modulo VARCHAR2(50),
  seq_number NUMBER,
  error_number NUMBER,
  error_message VARCHAR2(100),
  error_stack VARCHAR2(2000),
  call_stack VARCHAR2(2000),
  carimbo_tempo DATE,
  PRIMARY KEY(modulo, seq_number)
);

CREATE TABLE call_stacks (
  call_order NUMBER ,
  seq_number NUMBER,
  modulo VARCHAR2(50),
  object_handler VARCHAR2(10),
  line_num NUMBER,
  nome_objeto VARCHAR2(80),
  PRIMARY KEY(call_order, seq_number, modulo),
  FOREIGN KEY (modulo, seq_number) REFERENCES ERRORS ON DELETE CASCADE
);

CREATE TABLE error_stacks (
  error_order NUMBER  ,
  seq_number NUMBER,
  modulo VARCHAR2(50),
  facility CHAR(3),
  error_number NUMBER(5),
  error_message VARCHAR2(100),
  PRIMARY KEY(error_order, seq_number, modulo),
  FOREIGN KEY (modulo, seq_number) REFERENCES errors ON DELETE CASCADE
);


