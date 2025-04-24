//1. Mostrar la marca dado su id de la marca

SELECT
    *
FROM
    marcas_coche;

DECLARE
    v_id    marcas_coche.id_marca%TYPE := &id_marca1;
    v_marca marcas_coche.marca%TYPE;
BEGIN
    SELECT
        marca
    INTO v_marca
    FROM
        marcas_coche
    WHERE
        id_marca = v_id;

    dbms_output.put_line('La marca es ' || v_marca);
END;

//2. Igual que el anterior pero capturando una excepción en caso de que no exista el id

SELECT
    *
FROM
    marcas_coche;

DECLARE
    v_id    marcas_coche.id_marca%TYPE := &id_marca1;
    v_marca marcas_coche.marca%TYPE;
BEGIN
    SELECT
        marca
    INTO v_marca
    FROM
        marcas_coche
    WHERE
        id_marca = v_id;

    dbms_output.put_line('La marca es ' || v_marca);
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Marca no encontrada');
    WHEN OTHERS THEN
        dbms_output.put_line('Error desconocido');
END;

//3. Mostrar el nombre y teléfono de un cliente dado su dni. (al tratarse de un varchar2 tenéis que poner el dni entre comillas simples)

DECLARE
    v_dni    cliente.dni%TYPE := &v_dni1;
    v_nombre cliente.nombre%TYPE;
    v_telef  cliente.telef%TYPE;
BEGIN
    SELECT
        nombre,
        telef
    INTO
        v_nombre,
        v_telef
    FROM
        cliente
    WHERE
        v_dni = dni;

    dbms_output.put_line('El nombre es '
                         || v_nombre
                         || ' y su telefono es '
                         || v_telef);
END;

// 4. Mostrar el nombre y teléfono de un cliente dado su dni. (lo mismo que el ejercicio anterior pero ahora utilizando %rowtype)

DECLARE
    v_dni     cliente.dni%TYPE := &v_dni1;
    v_cliente cliente%rowtype;
BEGIN
    SELECT
        nombre,
        telef
    INTO v_cliente
    FROM
        cliente
    WHERE
        v_dni = dni;

    dbms_output.put_line('El nombre es '
                         || v_nombre
                         || ' y su telefono es '
                         || v_telef);
END;

//5. Mostrar toda la información de un coche dada la matrícula (MATRICULA, ID_MODELO, PRECIO_COMPRA)

DECLARE
    v_matricula coche.matricula%TYPE := &v_matricula1;
    v_coche     coche%rowtype;
BEGIN
    SELECT
        *
    INTO v_coche
    FROM
        coche
    WHERE
        v_matricula = matricula;

    dbms_output.put_line('Matricula: '
                         || v_matricula
                         || ', id del modelo: '
                         || v_coche.id_modelo
                         || ' precio de compra: '
                         || v_coche.precio_compra);

END;

// 6. Mostrar toda la información del modelo de un coche dado un id incluida el nombre de la marca)

DECLARE
    v_id_modelo    modelo_coche.id_modelo%TYPE := &id_modelo1;
    v_modelo_coche modelo_coche%rowtype;
    v_marca        marcas_coche.marca%TYPE;
BEGIN
    SELECT
        m.id_modelo,
        m.descripcion,
        m.id_marca,
        ma.marca
    INTO
        v_modelo_coche.id_modelo,
        v_modelo_coche.descripcion,
        v_modelo_coche.id_marca,
        v_marca
    FROM
             modelo_coche m
        JOIN marcas_coche ma ON m.id_marca = ma.id_marca
    WHERE
        m.id_modelo = v_id_modelo;

    dbms_output.put_line('id_modelo: '
                         || v_id_modelo
                         || ' descripcion: '
                         || v_modelo_coche.descripcion
                         || '  id_marca: '
                         || v_modelo_coche.id_marca
                         || ' marca: '
                         || v_marca);

END;

// 7. Mostrar la suma de ventas. Pasa el dni del empleado por parámetro.

DECLARE
    v_dni_empleado vende.dni_empleado%TYPE := &dni_empleado;
    v_precio       vende.precio%TYPE;
BEGIN
    SELECT
        SUM(precio)
    INTO v_precio
    FROM
        vende
    WHERE
        v_dni_empleado = dni_empleado;

    dbms_output.put_line('Suma total de ventas: ' || v_precio);
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('No se ha encontrado ese empleado.');
END;

// 8. Mostrar cuantos modelos de coches hay de la marca 'Citroen'.
DECLARE
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

// 9. 
DECLARE
    v_dni_empleado vende.dni_empleado%TYPE := &dni_empleado;
    v_precio       vende.precio%TYPE;
BEGIN
    SELECT
        SUM(precio)
    INTO v_precio
    FROM vende
    WHERE
        v_dni_empleado = dni_empleado;
IF v_precio IS NULL THEN   
    dbms_output.put_line('Precio de ventas nulo.');
ELSE 
dbms_output.put_line('Suma total de ventas: ' || v_precio);
END IF; 
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('No se ha encontrado ese empleado.');
END;
