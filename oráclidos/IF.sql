DECLARE
    nota NUMBER(2);
    resultado VARCHAR2(20);
BEGIN
    nota := 7;  -- Puedes cambiar el valor para probar diferentes casos

    IF nota < 5 THEN
        resultado := 'Suspenso';
    ELSIF nota >= 5 AND nota <= 6 THEN
        resultado := 'Aprobado';
    ELSIF nota >= 7 AND nota <= 8 THEN
        resultado := 'Notable';
    ELSIF nota >= 9 AND nota <= 10 THEN
        resultado := 'Sobresaliente';
    ELSE
        resultado := 'No existe esa nota';
    END IF;

    dbms_output.put_line('Resultado: ' || resultado);
END;

