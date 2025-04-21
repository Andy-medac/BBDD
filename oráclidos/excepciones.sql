// 1. Excepcion interna
DECLARE
    prueba    NUMBER := 5;
    resultado NUMBER;
BEGIN
    resultado := prueba / 0;
    dbms_output.put_line('El resultado es ' || resultado);
EXCEPTION
    WHEN zero_divide THEN
        dbms_output.put_line('División por 0 ' || sqlerrm);
END;

// 2. Excepcion personalizada
DECLARE
    edad NUMBER := -1;
    excepcion_edad EXCEPTION;
BEGIN
    IF edad < 0 OR edad > 99 THEN
        RAISE excepcion_edad;
    END IF;
EXCEPTION
    WHEN excepcion_edad THEN
        dbms_output.put_line('Edad incorrecta introducida');
END;

// 3. Mostrar los numeros del 1 al 10 con while
DECLARE
    i NUMBER := 1;
BEGIN
    WHILE ( i <= 10 ) LOOP
        dbms_output.put_line(i);
        i := i + 1;
    END LOOP;
END;

// 4. FOR
DECLARE
    i NUMBER := 1;
BEGIN
    FOR i IN 1..10 LOOP
        dbms_output.put_line(i);
    END LOOP;
END;

// DEL REVÉS
DECLARE
    i NUMBER := 1;
BEGIN
    FOR i IN REVERSE 1..10 LOOP
        dbms_output.put_line(i);
    END LOOP;
END;

// 5. lo mismo pero con loop
DECLARE
    i NUMBER := 1;
BEGIN
    LOOP
        dbms_output.put_line(i);
        EXIT WHEN i = 10;
        i := i + 1;
    END LOOP;
END;

// 6. video 1. uso de clase
DECLARE
    nota NUMBER(3, 1);
BEGIN
    nota := 4.9; -- 3 digitos, 1 decimal
    CASE
        WHEN nota < 5 THEN
            dbms_output.put_line('NO APTO');
        WHEN nota > 5 THEN
            dbms_output.put_line('APTO');
        ELSE
            dbms_output.put_line('Nota errónea');
    END CASE;

END;

