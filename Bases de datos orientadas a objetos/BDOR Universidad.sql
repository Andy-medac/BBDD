DROP TYPE persona FORCE;

DROP TYPE direccion FORCE;

-- Definicion de un tipo para direccion
CREATE OR REPLACE TYPE direccion AS OBJECT (
        calle         VARCHAR2(50),
        ciudad        VARCHAR2(20),
        codigo_postal NUMBER(5)
);

-- Definición de un tipo de objeto persona
CREATE OR REPLACE TYPE persona AS OBJECT (
        nombre           VARCHAR2(50),
        apellidos        VARCHAR2(100),
        domicilio        direccion,-- el tipo de dato de un atributo puede ser un objeto
        fecha_nacimiento DATE,
        MEMBER FUNCTION calcularedad RETURN NUMBER
) NOT FINAL; -- se puede heredar de este objeto

CREATE OR REPLACE TYPE alumno UNDER persona ( -- UNDER indica que hereda de la clase persona
        matricula    VARCHAR2(20),
        calificacion NUMBER
);

ALTER TYPE persona DROP ATTRIBUTE FECHA_NACIMIENTO
cascade;  --Elimina el atributo de fecha_nacimiento en persona
ALTER TYPE persona ADD ATTRIBUTE fecha_nacimiento DATE
    CASCADE; --Lo añade

CREATE OR REPLACE TYPE profesor UNDER persona (
        asignatura VARCHAR2(50),
        salario    NUMBER,
        MEMBER PROCEDURE aumentosalario (
               salario NUMBER
           )
);

CREATE OR REPLACE TYPE BODY persona AS -- para declarar una funcion se hace en el bloque cuerpo
    MEMBER FUNCTION calcularedad RETURN NUMBER IS
    BEGIN
        RETURN months_between(sysdate, fecha_nacimiento) / 12;
    END calcularedad;

END;

CREATE OR REPLACE TYPE BODY profesor AS
    MEMBER PROCEDURE aumentosalario (
        salario NUMBER
    ) IS
    BEGIN
        self.salario := self.salario + salario; -- self indica que es el atributo de profesor, ya que tienen el mismo nombre
    END aumentosalario;

END;

-- Creación de tablas para almacenar objetos alumno y profesor
CREATE TABLE alumnos OF alumno;

CREATE TABLE profesores OF profesor;

--Crear o modificar objeto en memoria y hacerlo persistente
DECLARE
    alumno1 alumno;
BEGIN
    alumno1 := NEW alumno('Ana', 'Garcia', direccion('Calle Madrid', 'Jaén', 23600), '07-11-1985', '123456', 9);

    alumno1.nombre := 'Marta';
    INSERT INTO alumnos VALUES ( alumno1 );

    dbms_output.put_line('Alumno:'
                         || alumno1.nombre
                         || '| calificacion: '
                         || alumno1.calificacion);

    dbms_output.put_line('Su edad es: ' || alumno1.calcularedad());
END;

DECLARE
    profesor1 profesor;
BEGIN
    profesor1 := NEW profesor('Juan', 'Expóxito', direccion('Avenida Barcelona', 'Jaén', 23002), '09-11-1976', 'Física', 180);

    INSERT INTO profesores VALUES ( profesor1 );

    dbms_output.put_line('Profesor:'
                         || profesor1.nombre
                         || ' | asignatura: '
                         || profesor1.asignatura);

END;

-- Consultar edad de un alumno de la tabla
DECLARE
    a alumno; -- asegurate de que alumno es el tipo correcto y calcularEdad() exista.
BEGIN
    SELECT
        value(al)
    INTO a
    FROM
        alumnos al
    WHERE
        al.nombre = 'Marta';

    dbms_output.put_line('La edad es: ' || a.calcularedad());
END;

-- Insertar datos profesores utilizando un constructor (por defecto) ESTE MÉTODO ES MUCHO MÁS SENCILLO
INSERT INTO profesores VALUES ( profesor('Pablo',
                                         'Martinez',
                                         direccion('Avenida Salamanca', 'Sevilla', 41000),
                                         '12-04-1980',
                                         'Matemáticas',
                                         1000) );

INSERT INTO profesores VALUES ( profesor('Carlos',
                                         'Fernández',
                                         direccion('Calle Andalucía', 'Jaén', 23401),
                                         '07-04-1990',
                                         'Informática',
                                         1000) );                                    

-- Hacemos un select del profesor 
DECLARE
    p profesor; -- asegurate de que alumno es el tipo correcto y calcularEdad() exista.
BEGIN
    SELECT
        value(pr)
    INTO p
    FROM
        profesores pr
    WHERE
        pr.asignatura = 'Informática';

    p.aumentosalario(100); -- llamamos a la funcion y el salario aumenta 100€, pero no se actualiza la tabla
    UPDATE profesores pr -- entonces hacemos un update para que se actualice
    SET VALUE ( pr ) = p
    WHERE
        pr.asignatura = 'Informática';

    dbms_output.put_line('El salario es de: ' || p.salario);
END;