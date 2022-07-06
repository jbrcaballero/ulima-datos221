--TRIGGERS
--CREACION DE TRIGGER (A NIVEL DE SENTENCIA)
CREATE OR REPLACE TRIGGER trigEmp
BEFORE INSERT OR UPDATE OR DELETE ON EMPLOYEES
BEGIN
    --SI EL DIA DE LA SEMANA ES SABADO O DOMINGO
    IF TO_CHAR(SYSDATE, 'D') IN (7, 1) 
        --O SI ESTAMOS FUERA DE HORARIO DE OFICINA
        OR TO_CHAR(SYSDATE, 'hh24:mi') NOT BETWEEN '09:00' AND '18:00' THEN
        --LANZAMOS UN ERROR
        RAISE_APPLICATION_ERROR(-20100, 'Operacion no permitida en este horario');
    END IF;
END;

--PRUEBAS: ANTES DE EJECUTAR LA ACTUALIZACION
SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 100;
--REVISAR MENSAJE
UPDATE EMPLOYEES SET SALARY = SALARY + 1000 WHERE EMPLOYEE_ID = 100;
--DESPUES DE LA ACTUALIZACION
SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 100;


--TABLA DE AUDITORIA
CREATE TABLE EMP_AUDITORIA(
    TIPO_OPERACION VARCHAR2(10),
    COD_EMPLEADO NUMBER(6),
    SALARIO_ANTES NUMBER(8,2),
    SALARIO_DESPUES NUMBER(8,2),
    FECHA DATE,
    USUARIO VARCHAR2(30)
);

CREATE OR REPLACE TRIGGER trigEmp2
AFTER INSERT OR UPDATE OR DELETE ON EMPLOYEES
FOR EACH ROW
DECLARE
    operacion VARCHAR2(10);
    codEmp EMPLOYEES.EMPLOYEE_ID%TYPE;
    salarioAntes EMPLOYEES.SALARY%TYPE;
    salarioDespues EMPLOYEES.SALARY%TYPE;
BEGIN
    IF DELETING THEN
        operacion := 'DELETE';
        codEmp := :old.EMPLOYEE_ID;
        salarioAntes := :old.SALARY;
        salarioDespues := NULL;
    ELSIF INSERTING THEN
        operacion := 'INSERT';
        codEmp := :new.EMPLOYEE_ID;
        salarioAntes := NULL;
        salarioDespues := :new.SALARY;
    ELSIF UPDATING THEN
        operacion := 'UPDATE';
        codEmp := :old.EMPLOYEE_ID;
        salarioAntes := :old.SALARY;
        salarioDespues := :new.SALARY;
    END IF;

    INSERT INTO EMP_AUDITORIA VALUES(operacion, codEmp, salarioAntes,
                                     salarioDespues, SYSDATE, USER);   
END;

--Deshabilitar Trigger anterior
ALTER TRIGGER trigEmp DISABLE;

--Pruebas
UPDATE EMPLOYEES SET SALARY = SALARY - 100 WHERE EMPLOYEE_ID = 100;
UPDATE EMPLOYEES SET SALARY = SALARY - 100 WHERE EMPLOYEE_ID IN (101, 102, 103);

UPDATE EMPLOYEES SET SALARY = SALARY + 100 WHERE EMPLOYEE_ID = 100;
UPDATE EMPLOYEES SET SALARY = SALARY + 100 WHERE EMPLOYEE_ID IN (101, 102, 103);

INSERT INTO EMPLOYEES VALUES(1000, 'JUAN','PEREZ','JPEREZ', '994859566',SYSDATE, 'IT_PROG', 30000,NULL,100,60);
DELETE FROM EMPLOYEES WHERE EMPLOYEE_ID = 1000;

--Revision de registros de auditoria
SELECT * FROM EMP_AUDITORIA;
