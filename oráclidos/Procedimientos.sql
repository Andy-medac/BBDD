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

CREATE OR REPLACE PROCEDURE mostrar_modelos (v_marca   marcas_coche.marca%TYPE)
AS
    cantidad   NUMBER;
    
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
    v_marca   marcas_coche.marca%TYPE := &marca;
BEGIN
    mostrar_modelos(v_marca);
END;
