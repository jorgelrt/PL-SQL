set serveroutput on;
CREATE OR REPLACE PROCEDURE PrintEmployees(
	p_JobId IN employees.job_id%TYPE) AS
	CURSOR c_Employees IS
		SELECT first_name, last_name from employees
		WHERE job_id = p_JobId;
BEGIN
	FOR v_regEmployee IN c_Employees LOOP
		dbms_output.put_line(v_regEmployee.first_name||' - '||
							 v_regEmployee.last_name);
	END LOOP;
END;