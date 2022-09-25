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
