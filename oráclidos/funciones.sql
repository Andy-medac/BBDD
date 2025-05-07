/*1. Realizar una función que devuelva la suma de ventas. Pasa el dni del empleado por parámetro */
-- Crea la función que devuelve la suma de precios de un empleado
CREATE OR REPLACE FUNCTION precio_ventas (v_dni vende.dni_empleado%TYPE) -- se le pasa un dni de parámetro
RETURN NUMBER -- retorna un numero
AS
    v_suma vende.precio%TYPE; -- que se almacena aquí
BEGIN
    -- Suma los precios de las ventas del empleado
    SELECT SUM(precio) INTO v_suma
    FROM vende
    WHERE dni_empleado = v_dni;
    
    RETURN v_suma; -- Devuelve la suma
END; -- todo esto se ejecuta antes

-- Bloque para llamar a la función y mostrar el resultado
DECLARE
    v_dni vende.dni_empleado%TYPE := &dni; -- DNI del empleado
    v_suma_precio vende.precio%TYPE; -- Variable para la suma
BEGIN
    v_suma_precio := precio_ventas(v_dni); -- Llama a la función
    dbms_output.put_line('La suma de ventas es: ' || v_suma_precio); -- Muestra el resultado
END;


/*2. Función que devuelve el número de coches vendidos por un empleado*/
CREATE OR REPLACE FUNCTION coches_vendidos (v_dni vende.dni_empleado%TYPE)
    RETURN NUMBER
    AS 
        v_total vende.precio%TYPE;
    
BEGIN
    SELECT
        COUNT(precio)
        INTO v_total
        FROM vende
        WHERE dni_empleado = v_dni;
        
    RETURN v_total;

END;

/*EJECUTARLA*/
DECLARE
    v_total vende.precio%TYPE;
    v_dni vende.dni_empleado%TYPE := &dni;
BEGIN
    v_total := coches_vendidos(v_dni);
    dbms_output.put_line('total de ventas: ' || v_total || ' del empleado con DNI ' || v_dni);
END;

/* EJERCICIO 3: Obtener el nombre de un cliente por su DNI (en caso de NO_DATA_FOUND lanzar excepción) */
CREATE OR REPLACE FUNCTION nombre_cliente (v_dni cliente.dni%TYPE) 
RETURN VARCHAR2
    AS
        v_nombre cliente.nombre%TYPE;
BEGIN
    SELECT
        nombre
        INTO v_nombre
        FROM cliente
        WHERE dni = v_dni;
    RETURN v_nombre;
END;

/*EJECUTARLO*/

DECLARE
    v_nombre cliente.nombre%TYPE;
    v_dni cliente.dni%TYPE := &dni;

BEGIN
    
    v_nombre := nombre_cliente(v_dni);
    
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('No existe el cliente');
    WHEN OTHERS THEN
        dbms_output.put_line('nombre: ' || v_nombre 
                                        || ' del cliente con DNI: ' 
                                        || v_dni);
END;

SELECT * FROM cliente;
