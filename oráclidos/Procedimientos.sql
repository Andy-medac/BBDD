// 1. Realizar un procedimiento que muestre cuantos modelos de coches hay de la marca 'Citroen'.

CREATE OR REPLACE PROCEDURE mostrar_modelos AS
    cantidad   NUMBER;
    v_id_marca modelo_coche.id_marca%TYPE;
    v_marca    marcas_coche.marca%TYPE := &marca;
BEGIN
    SELECT
        COUNT(mo.id_marca)
    INTO cantidad
    FROM
             modelo_coche mo
        JOIN marcas_coche ma ON mo.id_marca = ma.id_marca
    WHERE
        v_marca = ma.marca;

    dbms_output.put_line('N�mero total de coches: ' || cantidad);
END;

EXEC mostrar_modelos;

CREATE OR REPLACE PROCEDURE mostrar_modelos (
    v_marca marcas_coche.marca%TYPE
) AS
    cantidad NUMBER;
BEGIN
    SELECT
        COUNT(mo.id_marca)
    INTO cantidad
    FROM
             modelo_coche mo
        JOIN marcas_coche ma ON mo.id_marca = ma.id_marca
    WHERE
        v_marca = ma.marca;

    dbms_output.put_line('N�mero total de coches: ' || cantidad);
END;

/* EJECUTARLO */
DECLARE
    v_marca marcas_coche.marca%TYPE := &marca;
BEGIN
    mostrar_modelos(v_marca);
END;

/*4. Crear un procedimiento ActualizarPrecioCoche que acepte un nuevo_precio y matr�cula como par�metro.
Antes de realizar la actualizaci�n, se verifica si la matr�cula existe en la tabla coche. 
Si el la matr�cula no existe, guardar una excepci�n controlada personalizada con RAISE y mostrar un mensaje de error usando DBMS_OUTPUT. 
(Pod�is hacer un select que cuenta los coches con la matr�cula pasada por par�metro, en caso de que sea 0 ya sabes que no existe por lo que se puede generar la excepci�n)
Utilizar una estructura de control de flujo para verificar si el nuevo_precio es v�lido, por ejemplo mayor que 0 y menos que 10000.
Si el precio es v�lido, actualizar la columna precio_compra de la tabla coche cuya matr�cula sea la que hemos pasado por par�metro.
Si el precio no es v�lido, guardar una excepci�n controlada personalizada con RAISE y mostrar un mensaje de error usando DBMS_OUTPUT.*/

DECLARE
    v_precio    coche.precio_compra%TYPE := &precio;
    v_matricula coche.matricula%TYPE := &matricula;
BEGIN
    actualizarpreciocoche(v_precio, v_matricula);
END;

CREATE OR REPLACE PROCEDURE ActualizarPrecioCoche (nuevo_precio coche.precio_compra%TYPE, 
                                                                                            v_matricula coche.matricula%TYPE) AS
v_count NUMBER;
errorCoche EXCEPTION;
errorPrecio EXCEPTION;
BEGIN
SELECT COUNT(*) INTO v_count FROM coche WHERE
    matricula = v_matricula;
    IF v_count = 0 THEN
        RAISE errorcoche;
    END IF;
    IF nuevo_precio > 0 AND nuevo_precio < 10000 THEN 
    UPDATE coche SET precio_compra = nuevo_precio WHERE matricula = v_matricula;
            dbms_output.put_line('Precio actualizado');
            ELSE 
            RAISE errorPrecio;
    END IF; EXCEPTION
    WHEN errorcoche THEN
        dbms_output.put_line('No se encontr� esa matr�cula || v_matricula');
    WHEN errorprecio THEN
        dbms_output.put_line('El nuevo precio '
                             || nuevo_precio
                             || ' no es correcto');
    WHEN OTHERS THEN 
            dbms_output.put_line('Error: ' || SQLERRM);
END;

select * from coche;