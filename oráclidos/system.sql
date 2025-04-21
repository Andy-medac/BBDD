DECLARE
    mensaje VARCHAR2(100);
BEGIN
    mensaje := 'Hola clase DAM!';
    dbms_output.put_line(mensaje);
END;

/*Suma las cantidasdes 4 y 7 y devuelve el resultado por consola*/

DECLARE
    num1 NUMBER(1);
    num2 NUMBER(1);
    resultado NUMBER(2);
BEGIN
    num1 := 4;
    num2 := 7;
    resultado:= num1+num2;
    dbms_output.put_line('El resultado es ' || resultado);
END;