--EJERCICIO1: VISUALIZAR INCICIALES DE UN NOMBRE
SET SERVEROUTPUT ON
DECLARE
    Nombre varchar2(50):=UPPER('yensi') ;
    Apellido1 varchar2(50):= UPPER('armijo');
    Apellido2 varchar2(50):= UPPER('maradiaga');
    
BEGIN
    dbms_output.put_line(SUBSTR(Nombre,1,1)||'.'||SUBSTR(Apellido1,1,1)||'.'||SUBSTR(Apellido2,1,1)||'.');
    --dbms_output.put_line(Nombre||Apellido1||Apellido2);
    --dbms_output.put_line(SUBSTR(Nombre,1,1)||'.');
END;