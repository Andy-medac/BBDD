DECLARE
    num1      NUMBER(1);
    num2      NUMBER(1);
    resultado NUMBER(2);
BEGIN
    num1 := 4;
    num2 := 7;
    resultado := num1 + num2;
    dbms_output.put_line('El resultado es ' || resultado);
END;

// 2
DECLARE
    num1      NUMBER(1);
    num2      NUMBER(1);
    resultado NUMBER(2);
BEGIN
    num1 := 6;
    num2 := 7;
    resultado := num1 * num2;
    dbms_output.put_line('El resultado es ' || resultado);
END;

//3
DECLARE
    num1 NUMBER(1);
BEGIN
    num1 := 18;
    IF num1 = 18 THEN
        dbms_output.put_line('Tiene 18');
    ELSE
        dbms_output.put_line('No tiene 18');
    END IF;

END;

//4
DECLARE
    num1 NUMBER(2);
    num2 NUMBER(1);
BEGIN
    num1 := 10;
    num2 := 5;
    IF num1 > num2 THEN
        dbms_output.put_line(num1
                             || ' es mayor que '
                             || num2);
    END IF;

END;

//5 
BEGIN
    dbms_output.put_line(to_char(sysdate));
END;

//6
DECLARE
    nombre1 VARCHAR2(20);
    nombre2 nombre1%TYPE;
BEGIN
    nombre2 := 'Mamayema';
    dbms_output.put_line(nombre2);
END;

//7
 DECLARE
    edad NUMBER(2);
BEGIN
    edad := 23;
    dbms_output.put_line(edad);
END;

//8
    DECLARE
        num1 NUMBER(2);
        num2 NUMBER(1);
    BEGIN
        num1 := 10;
        num2 := 5;
        IF num2 < num1 THEN
            dbms_output.put_line(num2
                                 || ' es menor que '
                                 || num1);
        END IF;

    END;

//9
    DECLARE
        num1 NUMBER(1);
        num2 NUMBER(1);
    BEGIN
        num1 := 8;
        num2 := 7;
        IF num1 <> num2 THEN
            dbms_output.put_line(num1
                                 || ' es distinto a '
                                 || num2);
        END IF;

    END;

//10
    DECLARE
        num1 NUMBER(1);
        num2 NUMBER(1);
    BEGIN
        num1 := 7;
        num2 := 8;
        IF num1 <= num2 THEN
            dbms_output.put_line(num1
                                 || ' es menor o igual que '
                                 || num2);
        ELSE
            dbms_output.put_line(num1
                                 || ' no es menor o igual que '
                                 || num2);
        END IF;

    END;

//11
    DECLARE
        saludo VARCHAR2(20);
    BEGIN
        saludo := 'Hola caracola';
        dbms_output.put_line(saludo);
    END;

//12
    DECLARE
        saludo VARCHAR2(20);
    BEGIN
        saludo := 'Hola caracola';
        dbms_output.put_line(saludo || ' pa ti mi cola');
    END;

//13
    DECLARE
        saludo VARCHAR2(20);
    BEGIN
        << muestrasaludo >> saludo := 'Hola caracola';
        dbms_output.put_line(saludo || ' pa ti mi cola');
    END;

//14
    DECLARE
        saludo VARCHAR2(20);
/*Aquí se va a mostrar un saludo*/
    BEGIN
        saludo := 'Hola caracola';
        dbms_output.put_line(saludo || ' pa ti mi cola');
    END;

//15
    DECLARE
        saludo VARCHAR2(20);
-- Aquí se va a mostrar un saludo
    BEGIN
        saludo := 'Hola caracola';
        dbms_output.put_line(saludo || ' pa ti mi cola');
    END;

//16 
    DECLARE
        num1      NUMBER(1);
        num2      NUMBER(1);
        resultado NUMBER(2);
    BEGIN
        num1 := 4;
        num2 := 7;
        resultado := num1 - num2;
        dbms_output.put_line('El resultado es ' || resultado);
    END;

//17
    DECLARE
        num1      NUMBER(2);
        num2      NUMBER(1);
        resultado NUMBER(2);
    BEGIN
        num1 := 20;
        num2 := 4;
        resultado := num1 / num2;
        dbms_output.put_line('El resultado es ' || resultado);
    END;

//18 
    DECLARE
        num1      NUMBER(1);
        num2      NUMBER(1);
        resultado NUMBER(2);
    BEGIN
        num1 := 2;
        num2 := 3;
        resultado := num1 * * num2;
        dbms_output.put_line('El resultado es ' || resultado);
    END;

//19
    DECLARE
        num1 NUMBER(1);
        num2 NUMBER(1);
    BEGIN
        num1 := 8;
        num2 := 8;
        IF num1 >= num2 THEN
            dbms_output.put_line(num1
                                 || ' es menor o igual que '
                                 || num2);
        ELSE
            dbms_output.put_line(num1
                                 || ' no es menor o igual que '
                                 || num2);
        END IF;

    END;

//20 
    DECLARE
        nombre1 VARCHAR2(10);

        FUNCTION saludo (
            nombre2 IN VARCHAR2
        ) RETURN VARCHAR2 IS
        BEGIN
            RETURN 'Hola ' || nombre2;
        END saludo;

    BEGIN
        nombre1 := 'Pablo';
        dbms_output.put_line(saludo(nombre2 => nombre1));
    END;

//21
    DECLARE BEGIN
        dbms_output.put_line('jeloudah');
    END;


//22 
/*Para ejecutar un script, usamos @ seguido de la ruta del script, ya sea completa o relativa
Por ejemplo: @/ruta/del/archivo/script.sql*/

//23
    DECLARE
        num1      NUMBER(1);
        num2      NUMBER(1);
        resultado NUMBER(2);
    BEGIN
        num1 := 2;
        num2 := 3;
        resultado := num1 * * num2;
        dbms_output.put_line('El resultado es ' || resultado);
    END;
