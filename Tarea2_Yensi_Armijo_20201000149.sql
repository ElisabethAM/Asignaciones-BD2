--EJERCICIO1: VISUALIZAR INCICIALES DE UN NOMBRE
SET SERVEROUTPUT ON
DECLARE
    Nombre varchar2(50):=UPPER('yensi') ;
    Apellido1 varchar2(50):= UPPER('armijo');
    Apellido2 varchar2(50):= UPPER('maradiaga');
    
BEGIN
    dbms_output.put_line(SUBSTR(Nombre,1,1)||'.'||SUBSTR(Apellido1,1,1)||'.'||SUBSTR(Apellido2,1,1)||'.');--Impresion del resultado con las variables concatenadad
END;

--EJERCICIO2: PAR O IMPAR
SET SERVEROUTPUT ON
DECLARE
    Numero number:=-5;
BEGIN
    IF
        MOD(Numero,2)=0 --dividiendo el numero entre 2 y evaluando el residuo
    THEN
         dbms_output.put_line('El valor del número es Par');
    ELSE
        dbms_output.put_line('El valor del número es Impar');
    END IF;
END;

--EJERCICIO3: SALARIO MAXIMO DEL DEP 100
SET SERVEROUTPUT ON
DECLARE
     salario_maximo employees.salary%type;--copiando el tipo de dato en la nueva variable
BEGIN
   SELECT MAX(salary) INTO salario_maximo FROM Employees WHERE department_id=100;--consulta para filtrar el empleado deseado
   dbms_output.put_line('El salario máximo del departamento 100 es: '|| salario_maximo);--resultado
END;

--EJERCICIO4:
SET SERVEROUTPUT ON
DECLARE
    idDepartamento departments.department_id%type:=50;--variable del departamento
    nombreDep departments.department_name%type;
    cantidadEmp number;
BEGIN
    SELECT department_name INTO nombreDep FROM departments WHERE department_id= idDepartamento;--obteniendo el nombre del departamento
    SELECT COUNT(employee_id) INTO cantidadEmp FROM employees WHERE department_id= iddepartamento;--obteniendo la cantidad de empleados
    dbms_output.put_line('El nombre del departamento es '|| nombreDep||' con '||cantidadEmp ||' empleados' );
END;