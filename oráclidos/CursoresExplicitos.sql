//1. Descripción de los modelos de coche correspondientes a una marca específica, por ejemplo marca con id = 3. 
DECLARE
    v_id_marca    modelo_coche.id_marca%TYPE := &marca;
    v_descripcion modelo_coche.descripcion%TYPE;
    CURSOR c_modelos IS -- declaramos
    SELECT
        ma.descripcion
    INTO v_descripcion
    FROM
        modelo_coche ma
    WHERE
        ma.id_marca = v_id_marca; -- termina el cursor

BEGIN
    OPEN c_modelos; -- abres el cursor
    LOOP
        FETCH c_modelos INTO v_descripcion; -- obtiene un valor
        EXIT WHEN c_modelos%notfound; -- finaliza cuando no encuentra más filas
        dbms_output.put_line('Descripcion: ' || v_descripcion); -- muestra el valor
    END LOOP;

    CLOSE c_modelos;
END;

// 2. Igual que el anterior pero que también nos muestre el número total de modelos con %ROWCOUNT.
DECLARE
    v_id_marca    modelo_coche.id_marca%TYPE := &marca;
    v_descripcion modelo_coche.descripcion%TYPE;
    CURSOR c_modelos IS -- declaramos el cursor
    SELECT
        descripcion
    INTO v_descripcion
    FROM
        modelo_coche
    WHERE
        id_marca = v_id_marca;

BEGIN
    OPEN c_modelos;
    LOOP
        FETCH c_modelos INTO v_descripcion;
        EXIT WHEN c_modelos%notfound; -- finaliza cuando no encuentra más filas
        dbms_output.put_line('Descripcion: ' || v_descripcion);
    END LOOP;

    dbms_output.put_line('Cantidad total de modelos: ' || c_modelos%rowcount); -- cuenta la cantidad de filas
    CLOSE c_modelos;
END;

// 3. Listar los empleados que tienen una antigüedad antes del año 2010
DECLARE
    v_nombre empleado.nombre%TYPE;
    CURSOR nombresempleados IS
    SELECT
        nombre
    INTO v_nombre
    FROM
        empleado
    WHERE
        anio_incorporacion < 2010-01-01;

BEGIN
    OPEN nombresempleados;
    LOOP
        FETCH nombresempleados INTO v_nombre;
        EXIT WHEN nombresempleados%notfound;
        dbms_output.put_line('Empleado: ' || v_nombre);
    END LOOP;

    CLOSE nombresempleados;
END;
