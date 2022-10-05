                                                                         /*TAREA #3*/
                                      -------------------------------  BLOQUES ANÓNIMOS    ---------------------------
--A)NOMBRE Y SUELDO DE EMPLEADOS POR MEDIO DE CURSOR:

SET SERVEROUTPUT ON
DECLARE
    CURSOR c_empleados IS SELECT * FROM employees;
BEGIN
    DBMS_OUTPUT.PUT_LINE('NOMBRE      '  || 'SALARIO' );
    FOR i IN c_empleados LOOP
        IF i.FIRST_NAME= 'Peter' AND i.LAST_NAME='Tucker' THEN --comprobación del nombre del jefe
            RAISE_APPLICATION_ERROR(-20000,'NO SE PUEDE VISUALIZAR EL SUELDO DEL JEFE');
        END IF;
        DBMS_OUTPUT.PUT_LINE(i.FIRST_NAME || i.LAST_NAME||'----->'|| i.SALARY );
    END LOOP;
END;

--B) NUMERO DE EMPLEADOS DE DEPARTAMENTOS
--(USANDO CLAUSULA COUNT)
SET SERVEROUTPUT ON
DECLARE
    cantidadEmp NUMBER;
    ID_DEP NUMBER := 50;
    CURSOR c_num(ID_DEP NUMBER) IS SELECT COUNT(employee_id) FROM employees WHERE department_id= ID_DEP;
BEGIN
    OPEN c_num(ID_DEP);
        FETCH c_num INTO cantidadEmp;--almacenando la consulta(COUNT) del puntero en la variable numérica
        DBMS_OUTPUT.PUT_LINE('Cantidad de empleados en el departamento '|| ID_DEP||' :'||cantidadEmp);
    CLOSE c_num;
END;

--USANDO UNA VARIABLE CONTADORA(también funciona)
SET SERVEROUTPUT ON
DECLARE
    cantidadEmp NUMBER:=0;--CONTADOR
    ID_DEP NUMBER:=50;
    CURSOR c_num(ID_DEP NUMBER) IS SELECT * FROM employees WHERE department_id= ID_DEP;
BEGIN
    FOR i IN c_num(ID_DEP) LOOP
        cantidadEmp := cantidadEmp+1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Cantidad de empleados en el departamento '|| ID_DEP||' :'||cantidadEmp);
END;

--C) CURSOR DE TABLA EMPLOYEES
SET SERVEROUTPUT ON
DECLARE
    CURSOR c_emp IS SELECT * FROM employees FOR UPDATE;--for update para modificar atributos
BEGIN
    FOR i IN c_emp LOOP
        IF i.salary > 8000 THEN
            UPDATE employees set salary=salary*1.20 WHERE CURRENT OF c_emp;
        ELSE
             UPDATE employees set salary=salary*1.30 WHERE CURRENT OF c_emp;
        END IF;
    END LOOP;
END;

/*Codigo para probar el inciso C */
--EJECUTAR CADA CONSULTA ANTES DE HACER LA PRUEBA Y VOLVER A EJECUTAR UNA VEZ EJECUTADO EL BLOQUE
SELECT EMPLOYEE_ID, SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID=132;--SALARIO MAS BAJO (2100 )CAMBIA A 2730 (0.30%)
SELECT EMPLOYEE_ID, SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID=100;--SALARIO MAS ALTO (24000) CAMBIA A 28800 (0.20%)

