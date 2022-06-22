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
--Mostrar el nombre y salario del empleado dado su codigo








