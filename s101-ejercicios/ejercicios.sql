/*
Muestre todos los empleados de la region "Americas". Excluya
del listado a los que cumplan con el rol "Accountant".
Revise la tabla JOB_ID, la tabla COUNTRIES y la tabla REGIONS.
*/

SELECT E.*
FROM EMPLOYEES E
INNER JOIN JOBS J
ON E.JOB_ID = J.JOB_ID
INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
INNER JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID
INNER JOIN COUNTRIES C
ON L.COUNTRY_ID = C.COUNTRY_ID
INNER JOIN REGIONS R
ON C.REGION_ID = R.REGION_ID
WHERE J.JOB_TITLE <> 'Accountant'
AND R.REGION_NAME = 'Americas';


/*
Muestre los datos de los empleados que trabajan en Estados Unidos (United States of America).
Presente los apellidos del empleado en mayusculas y su fecha de contratacion en
formato mes-dia-anio.
*/
SELECT UPPER(E.LAST_NAME), TO_CHAR(HIRE_DATE, 'MM-DD-YYYY') AS "HIRE DATE"
FROM EMPLOYEES E
INNER JOIN JOBS J
ON E.JOB_ID = J.JOB_ID
INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
INNER JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID
INNER JOIN COUNTRIES C
ON L.COUNTRY_ID = C.COUNTRY_ID
WHERE C.COUNTRY_NAME = 'United States of America';

/*
Muestre el promedio de salarios de los empleados q hayan desempeñado el rol 
de codigo "ST_CLERK" en el pasado. Considere solo 2 decimales (trunque)
Utilice la tabla JOB_HISTORY.
*/
SELECT TRUNC(AVG(SALARY), 2) 
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM JOB_HISTORY WHERE JOB_ID = 'ST_CLERK');


