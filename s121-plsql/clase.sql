--Habilitar salida por consola
SET SERVEROUTPUT ON;

--Primer programa PL/SQL
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hola mundo');
END;

--Manejo de variables
DECLARE
    --Declaracion
    name VARCHAR2(60);
    --Declaracion y asignacion
    lastName VARCHAR2(80) := 'Perez';
BEGIN
    --Asignacion
    name := 'Juan';
    --Operaciones
    DBMS_OUTPUT.PUT_LINE('Hola ' || name || ' ' || lastName);
END;

--Variables numericas: Potencia
DECLARE
    base NUMBER := 2;
    exponent NUMBER := 6;
    result NUMBER;
BEGIN
    result := POWER(base, exponent);
    DBMS_OUTPUT.PUT_LINE(base || ' elevado al exponente ' || exponent 
    || ' es: ' || result);
END;

--UTILIZAR SQL
--Mostrar el nombre completo y salario del empleado dado su codigo
DECLARE
    employeeId EMPLOYEES.EMPLOYEE_ID%TYPE := 667;
    fullName VARCHAR2(100);
    salary EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT FIRST_NAME || ' ' || LAST_NAME, SALARY
    INTO fullName, salary
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = employeeId;
    
    DBMS_OUTPUT.PUT_LINE('Nombre completo: ' || fullName);
    DBMS_OUTPUT.PUT_LINE('Salario: ' || salary);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encuentra el empleado');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error desconocido');
END;

--Estructuras selectivas
--Implemente un programa que evalue la calificacion de un alumno
--y muestre en pantalla si esta aprobado o desaprobado

DECLARE
    grade NUMBER := 8;
BEGIN
    IF grade > 10 THEN
        DBMS_OUTPUT.PUT_LINE('Alumno aprobado');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Alumno desaprobado');
    END IF;
END;

/*
    Un banco clasifica a sus clientes en 3 niveles en funcion del salario
    que perciben:
    - Nivel 3: Salarios menores o iguales que 4000.
    - Nivel 2: Salarios mayores que 4000 pero menor que 10000.
    - Nivel 1: Salarios mayores o iguales que 10000.
    Implemente un programa que reciba un codigo de empleado (esquema HR)
    e imprima el pantalla el nivel correspondiente del empleado en el
    banco mencionado
*/
DECLARE
    employeeId EMPLOYEES.EMPLOYEE_ID%TYPE := 107;
    level NUMBER;
    salary EMPLOYEES.SALARY%TYPE;
BEGIN
    --Obtenemos el salario del empleado
    SELECT SALARY
    INTO salary
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = employeeId;
    
    IF salary <= 4000 THEN
        level := 3;
    ELSIF salary < 10000 THEN
        level := 2;
    ELSE
        level := 3;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('El nivel del empleado es: ' || level);
END;

--ESTRUCTURAS REPETITIVAS
--Implemente un programa que imprima los numeros naturales del 1 al 100
BEGIN
    FOR i IN 1..100 LOOP
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;

--Implemente un programa que calcule la suma de los "n" primeros numeros
--naturales (el valor de "n" debe estar en una variable)
DECLARE
    n NUMBER := 10;
    result NUMBER := 0;
BEGIN
    FOR i IN 1..n LOOP
        result := result + i;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('El resultado es: ' || result);
END;

--HR: Implemente un programa que muestre los nombres completos de los empleados con
--codigos en el intervalo [valorInicial, valorFinal] (ambos deben ser variables)
DECLARE
    first EMPLOYEES.EMPLOYEE_ID%TYPE := 101;
    last EMPLOYEES.EMPLOYEE_ID%TYPE := 106;
    fullName VARCHAR2(100);
BEGIN
    FOR i IN first..last LOOP
        SELECT FIRST_NAME || ' ' || LAST_NAME
        INTO fullName
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID = i;
        
        DBMS_OUTPUT.PUT_LINE(i || ': ' || fullName);
    END LOOP;
END;

--FUNCIONES
--Funcion para obtener el nombre completo del empleado
CREATE OR REPLACE FUNCTION getFullName(empId EMPLOYEES.EMPLOYEE_ID%TYPE)
RETURN VARCHAR2
AS
    fullName VARCHAR2(100);
BEGIN
    SELECT FIRST_NAME || ' ' || LAST_NAME
    INTO fullName
    FROM EMPLOYEES 
    WHERE EMPLOYEE_ID = empId;
    
    RETURN fullName;
END;

--Pruebas de la funcion
BEGIN
    DBMS_OUTPUT.PUT_LINE(UPPER(getFullName(102)));
END;

--PROCEDURE
--Procedure que muestra los datos de los empleados en un intervalo
--(bloque anonimo convertido a procedure)

CREATE OR REPLACE PROCEDURE getEmpInfo(first EMPLOYEES.EMPLOYEE_ID%TYPE, last EMPLOYEES.EMPLOYEE_ID%TYPE)
AS
    fullName VARCHAR2(100);
BEGIN
    FOR i IN first..last LOOP
        SELECT FIRST_NAME || ' ' || LAST_NAME
        INTO fullName
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID = i;
        
        DBMS_OUTPUT.PUT_LINE(i || ': ' || fullName);
    END LOOP;
END;

--Pruebas del procedure
BEGIN
    getEmpInfo(101, 106);
END;






