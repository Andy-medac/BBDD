// 1. Trigger que impide registrar una venta si el precio es menor que 1000 
CREATE OR REPLACE TRIGGER verificarprecio BEFORE
    INSERT ON vende
    FOR EACH ROW
BEGIN
    IF :new.precio < 1000 THEN
        raise_application_error(-20001, 'El precio de compra no es válido.');
    END IF;
END;
// 2. Crear un trigger que verifique el precio de compra de un coche antes de insertarlo en la tabla coche. 
// Si el precio es nulo o cero, el trigger debe evitar la inserción y lanzar una excepción.

CREATE OR REPLACE TRIGGER checkpreciocompra BEFORE
    INSERT ON coche -- antes de un insert en la tabla coche
    FOR EACH ROW
BEGIN
    IF :new.precio_compra IS NULL OR :new.precio_compra <= 0 THEN
        raise_application_error(-20001, 'El precio de compra no es válido.');
    END IF;
END;

//3. Crear un trigger que automáticamente inserte la fecha actual en la columna fecha_insercion
//cada vez que se añade un nuevo registro en la tabla coche: 
ALTER TABLE coche ADD fecha_insercion DATE;
/

CREATE OR REPLACE TRIGGER fechaactual BEFORE
    INSERT ON coche
    FOR EACH ROW
BEGIN
    :new.fecha_insercion := sysdate;
END;