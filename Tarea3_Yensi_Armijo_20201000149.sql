                                                                         /*TAREA #3*/
                                      -------------------------------  BLOQUES AN�NIMOS    ---------------------------
                                                    --A)NOMBRE Y SUELDO DE EMPLEADOS POR MEDIO DE CURSOR:

SET SERVEROUTPUT ON
DECLARE
    CURSOR c_empleados IS SELECT * FROM EMPLOYEES_COPIA;
BEGIN
    DBMS_OUTPUT.PUT_LINE('NOMBRE      '  || 'SALARIO' );
    FOR i IN c_empleados LOOP
        IF i.FIRST_NAME= 'Peter' AND i.LAST_NAME='Tucker' THEN --comprobaci�n del nombre del jefe
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
    CURSOR c_num(ID_DEP NUMBER) IS SELECT COUNT(employee_id) FROM EMPLOYEES_COPIA WHERE department_id= ID_DEP;
BEGIN
    OPEN c_num(ID_DEP);
        FETCH c_num INTO cantidadEmp;--almacenando la consulta(COUNT) del puntero en la variable num�rica
        DBMS_OUTPUT.PUT_LINE('Cantidad de empleados en el departamento '|| ID_DEP||' :'||cantidadEmp);
    CLOSE c_num;
END;

--USANDO UNA VARIABLE CONTADORA(tambi�n funciona)
SET SERVEROUTPUT ON
DECLARE
    cantidadEmp NUMBER:=0;--CONTADOR
    ID_DEP NUMBER:=50;
    CURSOR c_num(ID_DEP NUMBER) IS SELECT * FROM EMPLOYEES_COPIA WHERE department_id= ID_DEP;
BEGIN
    FOR i IN c_num(ID_DEP) LOOP
        cantidadEmp := cantidadEmp+1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Cantidad de empleados en el departamento '|| ID_DEP||' :'||cantidadEmp);
END;

                                                            --C) CURSOR DE TABLA EMPLOYEES_COPIA
SET SERVEROUTPUT ON
DECLARE
    CURSOR c_emp IS SELECT * FROM EMPLOYEES_COPIA FOR UPDATE;--for update para modificar atributos
BEGIN
    FOR i IN c_emp LOOP
        IF i.salary > 8000 THEN
            UPDATE EMPLOYEES_COPIA set salary=salary*1.20 WHERE CURRENT OF c_emp;
        ELSE
             UPDATE EMPLOYEES_COPIA set salary=salary*1.30 WHERE CURRENT OF c_emp;
        END IF;
    END LOOP;
END;

/*Codigo para probar el inciso C */
--EJECUTAR CADA CONSULTA ANTES DE HACER LA PRUEBA Y VOLVER A EJECUTAR UNA VEZ EJECUTADO EL BLOQUE
SELECT EMPLOYEE_ID, SALARY FROM EMPLOYEES_COPIA WHERE EMPLOYEE_ID=132;--SALARIO MAS BAJO (2100 )CAMBIA A 2730 (0.30%)
SELECT EMPLOYEE_ID, SALARY FROM EMPLOYEES_COPIA WHERE EMPLOYEE_ID=100;--SALARIO MAS ALTO (24000) CAMBIA A 28800 (0.20%)

                                            -------------------------------  FUNCIONES    ---------------------------
                            --A) FUNCION CREAR REGI�N(falta implementarle los errores, solo tiene una excepcion global por el momento)
CREATE OR REPLACE FUNCTION CREAR_REGION
    (nombreRegion IN REGIONS.REGION_NAME%TYPE)
RETURN NUMBER
IS
    codigoAlto NUMBER;
    codigoRegion NUMBER;
BEGIN
    --IF nombreRegion='' THEN
        -- RAISE_APPLICATION_ERROR(-20000,'NO SE PUEDE INGRESAR UNA REGION VACIA');
    --END IF;
    SELECT MAX(REGION_ID) INTO codigoAlto FROM REGIONS;
    codigoRegion:= codigoAlto+1;
    INSERT INTO REGIONS VALUES (codigoRegion,nombreRegion);
    RETURN codigoRegion;

    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR INESPERADO');
END;

--DELETE  FROM REGIONS WHERE REGION_ID>4;
--LLAMADO A LA FUNCI�N CREADA :
SET SERVEROUTPUT ON
DECLARE
    Region REGIONS.REGION_NAME%type;
    Resultado NUMBER;
begin
    Region:='Wakanda';
    Resultado:= CREAR_REGION(Region);
    DBMS_OUTPUT.PUT_LINE('El nuevo c�digo generado es: '||Resultado);
end;

                                        -------------------------------  PROCEDIMIENTOS    ---------------------------
                                                                        --A) CALCULADORA
CREATE OR REPLACE PROCEDURE CALCULADORA
(operacion IN VARCHAR2,
    num1 IN NUMBER, num2 IN NUMBER)
IS
  Resultado NUMBER:= 0;
BEGIN
    CASE operacion
        WHEN 'SUMA' THEN 
            Resultado:= (num1+num2);
        WHEN 'RESTA' THEN 
            Resultado:= (num1-num2) ;
        WHEN 'MULTIPLICACION' THEN 
            Resultado:= (num1*num2);
        WHEN 'DIVISION' THEN 
            IF num2=0 THEN
                RAISE_APPLICATION_ERROR(-20000,'EL DENOMINADOR DE LA DIVISION NO PUEDE SER CERO');
            ELSE
                Resultado:= (num1/num2) ;
            END IF;
        ELSE 
            RAISE_APPLICATION_ERROR(-20001,'INGRESE UN NOMBRE DE OPERACION VALIDO: SUMA, RESTA, MULTIPLICACION, DIVISION');
    END CASE;
    DBMS_OUTPUT.PUT_line('EL RESULTADO DE LA ' || operacion||' es: '||resultado);
END;

--LLAMADO DEL PROCEDIMIENTO (CALCULADORA)
set serveroutput on
DECLARE
  A NUMBER;
  B NUMBER;
  OPERACION VARCHAR2(50);
BEGIN
  A:=5;
  B:=5;
  OPERACION:= 'DIVISION';
  CALCULADORA(OPERACION,A,B);
END;

                                                                --B) COPIA DE EMPLOYEES
 
CREATE OR REPLACE PROCEDURE INSERTS_EMPLOYEE
    IS
        mensaje VARCHAR2(50):= 'Carga Finalizada :)';
BEGIN    
    INSERT INTO EMPLOYEES_COPIA VALUES( 100, 'Steven', 'King', 'SKING', '515.123.4567', TO_DATE('17-06-2003', 'dd-MM-yyyy'), 'AD_PRES', 24000, NULL, NULL, 90);
    INSERT INTO EMPLOYEES_COPIA VALUES( 101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', TO_DATE('21-09-2005', 'dd-MM-yyyy'), 'AD_VP', 1700, NULL, 10, 9);    
    INSERT INTO EMPLOYEES_COPIA VALUES( 102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', TO_DATE('13-01-2001', 'dd-MM-yyyy'), 'AD_VP', 1700, NULL, 10, 9);    
    INSERT INTO EMPLOYEES_COPIA VALUES( 103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', TO_DATE('03-01-2006', 'dd-MM-yyyy'), 'IT_PROG', 900, NULL, 10, 6);    
    INSERT INTO EMPLOYEES_COPIA VALUES( 104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', TO_DATE('21-05-2007', 'dd-MM-yyyy'), 'IT_PROG', 600, NULL, 10, 6);    
    INSERT INTO EMPLOYEES_COPIA VALUES( 105, 'David', 'Austin', 'DAUSTIN', '590.423.4569', TO_DATE('25-06-2005', 'dd-MM-yyyy'), 'IT_PROG', 480, NULL, 10, 6);    
    INSERT INTO EMPLOYEES_COPIA VALUES( 106, 'Valli', 'Pataballa', 'VPATABAL', '590.423.4560', TO_DATE('05-02-2006', 'dd-MM-yyyy'), 'IT_PROG', 480, NULL, 10, 6);    
    INSERT INTO EMPLOYEES_COPIA VALUES( 107, 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', TO_DATE('07-02-2007', 'dd-MM-yyyy'), 'IT_PROG', 420, NULL, 10, 6);   
    DBMS_OUTPUT.PUT_LINE(mensaje);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR INESPERADO CON CODIGO: '|| SQLCODE); 
            DBMS_OUTPUT.PUT_LINE('DESCRIPCION: '|| SQLERRM); 
END; 

--llamado del procedimiento:
    BEGIN
        INSERTS_EMPLOYEE;
    END;