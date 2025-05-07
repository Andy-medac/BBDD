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

    dbms_output.put_line('Número total de coches: ' || cantidad);
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

    dbms_output.put_line('Número total de coches: ' || cantidad);
END;

/* EJECUTARLO */
DECLARE
    v_marca marcas_coche.marca%TYPE := &marca;
BEGIN
    mostrar_modelos(v_marca);
END;

-- 2. Crear un procedimiento que utilice un cursor para listar 
-- los empleados que tienen una antigüedad antes del año 2010
CREATE OR REPLACE PROCEDURE listar_empleados_antiguos IS
    -- Declaración de la variable para almacenar el nombre
    v_nombre empleado.nombre%TYPE;
    -- Declaración del cursor que selecciona los empleados con fecha de incorporación antes de 2010
    CURSOR nombresempleados IS
        SELECT nombre
        FROM empleado
        WHERE anio_incorporacion < 2010-01-01;
BEGIN
    -- Abrir el cursor
    OPEN nombresempleados;
    -- Recorrer el cursor
    LOOP
        FETCH nombresempleados INTO v_nombre; -- Obtener el siguiente nombre
        EXIT WHEN nombresempleados%NOTFOUND; -- Salir cuando no haya más filas
        DBMS_OUTPUT.PUT_LINE('Empleado: ' || v_nombre); -- Mostrar el nombre
    END LOOP;

    -- Cerrar el cursor
    CLOSE nombresempleados;
END listar_empleados_antiguos;

-- 3 Crear un procedimiento que utilice un cursor para listar la 
-- descripción y el precio de compra de cada coche en la tabla coche
CREATE OR REPLACE PROCEDURE listar_coches IS
    -- Declaración del cursor que selecciona la descripción y el precio de compra de los coches
    CURSOR c_coches IS
        SELECT descripcion, precio_compra
        FROM coche;

    -- Variables para almacenar los resultados del cursor
    v_descripcion coche.descripcion%TYPE;
    v_precio_compra coche.precio_compra%TYPE;
BEGIN
    -- Abrir el cursor
    OPEN c_coches;

    -- Recorrer el cursor
    LOOP
        FETCH c_coches INTO v_descripcion, v_precio_compra; -- Obtener la descripción y el precio
        EXIT WHEN c_coches%NOTFOUND; -- Salir cuando no haya más filas

        -- Mostrar los resultados
        DBMS_OUTPUT.PUT_LINE('Descripción: ' || v_descripcion || ', Precio de compra: ' || v_precio_compra);
    END LOOP;

    -- Cerrar el cursor
    CLOSE c_coches;
END listar_coches;


/*4. Crear un procedimiento ActualizarPrecioCoche que acepte un nuevo_precio y matrícula como parámetro.
Antes de realizar la actualización, se verifica si la matrícula existe en la tabla coche. 
Si el la matrícula no existe, guardar una excepción controlada personalizada con RAISE y mostrar un mensaje de error usando DBMS_OUTPUT. 
(Podéis hacer un select que cuenta los coches con la matrícula pasada por parámetro, en caso de que sea 0 ya sabes que no existe por lo que se puede generar la excepción)
Utilizar una estructura de control de flujo para verificar si el nuevo_precio es válido, por ejemplo mayor que 0 y menos que 10000.
Si el precio es válido, actualizar la columna precio_compra de la tabla coche cuya matrícula sea la que hemos pasado por parámetro.
Si el precio no es válido, guardar una excepción controlada personalizada con RAISE y mostrar un mensaje de error usando DBMS_OUTPUT.*/

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
        dbms_output.put_line('No se encontró esa matrícula || v_matricula');
    WHEN errorprecio THEN
        dbms_output.put_line('El nuevo precio '
                             || nuevo_precio
                             || ' no es correcto');
    WHEN OTHERS THEN 
            dbms_output.put_line('Error: ' || SQLERRM);
END;

select * from coche;
