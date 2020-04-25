--especificação da package
CREATE OR REPLACE PACKAGE RoomsPkg AS
	PROCEDURE NewRoom(p_Building rooms.building%TYPE,
					  p_RoomNum rooms.room_number%TYPE,
					  p_NumSeats rooms.number_seats%TYPE,
					  p_Description rooms.description%TYPE);
	PROCEDURE DeleteRoom(p_RoomID IN rooms.room_id%TYPE);
END RoomsPkg;

--espcificação do corpo da package
CREATE OR REPLACE PACKAGE BODY RoomsPkg AS
	PROCEDURE NewRoom(p_Building rooms.building%TYPE,
					  p_RoomNum rooms.room_number%TYPE,
					  p_NumSeats rooms.number_seats%TYPE,
					  p_Description rooms.description%TYPE) IS
	BEGIN
		INSERT INTO rooms
		VALUES(room_sequence.nextval, p_Building, p_RoomNum, p_NumSeats, p_Description);
	END NewRoom;
	
	PROCEDURE DeleteRoom(p_RoomID IN rooms.room_id%TYPE) IS
	BEGIN
		DELETE FROM rooms
		WHERE room_id = p_RoomID;
	END DeleteRoom;
END RoomsPkg;

--forma de execução
SQL> DECLARE
  2  v_Building VARCHAR2(15) := 'Building 10';
  3  v_RoomNum NUMBER(4) := 404;
  4  v_NumSeats NUMBER(4) := 10;
  5  v_Description VARCHAR2(50) := 'Sala do Erro';
  6  BEGIN
  7  RoomsPkg.NewRoom(v_Building, v_RoomNum, v_NumSeats, v_Description);
  8  END;
  9  /