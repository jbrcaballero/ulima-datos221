--PROCEDURE
CREATE OR REPLACE PROCEDURE SALUDAR(nombre VARCHAR2)
AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hola ' || nombre);
END;

BEGIN 
    SALUDAR('Mariana');
END;

--PACKAGE SPECIFICATION
CREATE OR REPLACE PACKAGE PRUEBA_PQ1 AS
    PROCEDURE SALUDAR(nombre VARCHAR2);
END PRUEBA_PQ1;

--PACKAGE BODY
CREATE OR REPLACE PACKAGE BODY PRUEBA_PQ1 AS
    PROCEDURE PRUEBA
    AS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('En procedure de prueba');
    END;

    PROCEDURE SALUDAR(nombre VARCHAR2)
    AS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Hola ' || nombre);
    END;
END PRUEBA_PQ1;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Prueba paquete');
    PRUEBA_PQ1.PRUEBA();
END;

--Obtener el tipo de triangulo dadas las longitudes de sus lados
CREATE OR REPLACE FUNCTION OBTENER_TIPO_TRIANGULO(a NUMBER, b NUMBER, c NUMBER)
RETURN VARCHAR2
AS
    tipo VARCHAR2(20);    
BEGIN
    IF a = b AND b = c THEN
        tipo := 'EQ';
    ELSIF a = b OR b = c OR a = c THEN
        tipo := 'IS';
    ELSE
        tipo := 'ES';
    END IF;
    
    RETURN tipo;
END;

CREATE OR REPLACE PACKAGE MATEMATICA AS
    --OBTENER TIPO TRIANGULO
    FUNCTION OBTENER_TIPO_TRIANGULO(a NUMBER, b NUMBER, c NUMBER)
    RETURN VARCHAR2;
    
    --CALCULAR EL VALOR DE LA EXPRESION X^3 + Y^6 + XYZ
    FUNCTION CALCULAR(x NUMBER, y NUMBER, z NUMBER)
    RETURN NUMBER;
    
    --DADO UN VALOR N, CALCULAR LA SUMA DE LOS NUMEROS [1, N] UTILIZANDO UN BUCLE.
    --EL PROCEDURE DEBE MOSTRAR EL RESULTADO;
    PROCEDURE CALCULAR_SUMA(n NUMBER);    
END MATEMATICA;

CREATE OR REPLACE PACKAGE BODY MATEMATICA AS
    FUNCTION OBTENER_TIPO_TRIANGULO(a NUMBER, b NUMBER, c NUMBER)
    RETURN VARCHAR2
    AS
        tipo VARCHAR2(20);    
    BEGIN
        IF a = b AND b = c THEN
            tipo := 'Equilatero';
        ELSIF a = b OR b = c OR a = c THEN
            tipo := 'Isosceles';
        ELSE
            tipo := 'Escaleno';
        END IF;
        
        RETURN tipo;
    END OBTENER_TIPO_TRIANGULO;
    
    FUNCTION CALCULAR(x NUMBER, y NUMBER, z NUMBER)
    RETURN NUMBER
    AS
        resultado NUMBER;
    BEGIN
        resultado := POWER(x, 3) + POWER(y, 6) + x * y * z;
        RETURN resultado;
    END;
    
    PROCEDURE CALCULAR_SUMA(n NUMBER)
    AS
        resultado NUMBER := 0;
    BEGIN
        FOR X IN 1..N LOOP
            resultado := resultado + X;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('La suma es: ' || resultado);
    END CALCULAR_SUMA;    
END MATEMATICA;

--Pruebas
DECLARE
    tipoTriangulo VARCHAR2(20);
    tipoTriangulo2 VARCHAR2(20);
    resultado NUMBER;
BEGIN
    tipoTriangulo := MATEMATICA.OBTENER_TIPO_TRIANGULO(5, 5, 5);
    tipoTriangulo2 := OBTENER_TIPO_TRIANGULO(5, 5, 5);
    DBMS_OUTPUT.PUT_LINE(tipoTriangulo || '-' || tipoTriangulo2);
    resultado := MATEMATICA.CALCULAR(2, 1, 8);
    DBMS_OUTPUT.PUT_LINE('Resultado de la operacion: ' || resultado);
    MATEMATICA.CALCULAR_SUMA(10);
END;

CREATE OR REPLACE PACKAGE RRHH AS
    FUNCTION OBTENER_NOMBRE_COMPLETO(codEmp EMPLOYEES.EMPLOYEE_ID%TYPE)
    RETURN VARCHAR2;
    
    PROCEDURE MOSTRAR_BONO(codEmp EMPLOYEES.EMPLOYEE_ID%TYPE);
    
    PROCEDURE MOSTRAR_REPORTE_DPTO(codDpto DEPARTMENTS.DEPARTMENT_ID%TYPE);
END RRHH;

CREATE OR REPLACE PACKAGE BODY RRHH AS
    FUNCTION OBTENER_NOMBRE_COMPLETO(codEmp EMPLOYEES.EMPLOYEE_ID%TYPE)
    RETURN VARCHAR2
    AS
        nombre VARCHAR2(100);
    BEGIN
        SELECT FIRST_NAME || ' ' || LAST_NAME
        INTO nombre
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID = codEmp;
        
        RETURN nombre;
    END OBTENER_NOMBRE_COMPLETO;

    PROCEDURE MOSTRAR_BONO(codEmp EMPLOYEES.EMPLOYEE_ID%TYPE)
    AS
        cantEmp number;
    BEGIN
        SELECT COUNT(*)
        INTO cantEmp
        FROM EMPLOYEES
        WHERE MANAGER_ID = codEmp;
        
        IF cantEmp > 5 THEN
            DBMS_OUTPUT.PUT_LINE('Empleado recibira bono');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Empleado no recibira bono');
        END IF;
    END MOSTRAR_BONO;

    PROCEDURE MOSTRAR_REPORTE_DPTO(codDpto DEPARTMENTS.DEPARTMENT_ID%TYPE)
    AS
        CURSOR curEmp IS    SELECT EMPLOYEE_ID, LAST_NAME, SALARY
                            FROM EMPLOYEES
                            WHERE DEPARTMENT_ID = codDpto
                            AND JOB_ID <> 'SA_MAN';
        nomDpto DEPARTMENTS.DEPARTMENT_NAME%TYPE;
    BEGIN
        SELECT DEPARTMENT_NAME 
        INTO nomDpto
        FROM DEPARTMENTS
        WHERE DEPARTMENT_ID = codDpto;
        
        DBMS_OUTPUT.PUT_LINE('Reporte del Departamento de ' || nomDpto);
        DBMS_OUTPUT.PUT_LINE('********************');
        FOR X IN curEmp LOOP
            DBMS_OUTPUT.PUT_LINE('Codigo Empleado: ' || X.EMPLOYEE_ID);
            DBMS_OUTPUT.PUT_LINE('Apellido Empleado: ' || X.LAST_NAME);
            DBMS_OUTPUT.PUT_LINE('Salario: ' || X.SALARY);
            DBMS_OUTPUT.PUT_LINE('********************');
        END LOOP;
    END MOSTRAR_REPORTE_DPTO;
   
END RRHH;

BEGIN
    DBMS_OUTPUT.PUT_LINE(RRHH.OBTENER_NOMBRE_COMPLETO(102));
    RRHH.MOSTRAR_BONO(100);
    RRHH.MOSTRAR_REPORTE_DPTO(60);
END;






