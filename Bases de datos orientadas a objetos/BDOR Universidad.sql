DROP TYPE persona FORCE;

DROP TYPE direccion FORCE;

DROP TYPE alumno FORCE;

DROP TYPE profesor FORCE;

-- Definicion de un tipo para direccion
CREATE OR REPLACE TYPE direccion AS OBJECT (
        calle         VARCHAR2(50),
        ciudad        VARCHAR2(20),
        codigo_postal NUMBER(5)
);

-- Definici�n de un tipo de objeto persona
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
    CASCADE; --Lo a�ade

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

-- Creaci�n de tablas para almacenar objetos alumno y profesor
CREATE TABLE alumnos OF alumno;


CREATE TABLE profesores OF profesor;

--Crear o modificar objeto en memoria y hacerlo persistente
DECLARE
    alumno1 alumno;
BEGIN
    alumno1 := NEW alumno('Ana', 'Garcia', direccion('Calle Madrid', 'Ja�n', 23600), '07-11-1985', '123456', 9);

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
    profesor1 := NEW profesor('Juan', 'Exp�xito', direccion('Avenida Barcelona', 'Ja�n', 23002), '09-11-1976', 'F�sica', 180);

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

-- Insertar datos profesores utilizando un constructor (por defecto) ESTE M�TODO ES MUCHO M�S SENCILLO
INSERT INTO profesores VALUES ( profesor('Pablo',
                                         'Martinez',
                                         direccion('Avenida Salamanca', 'Sevilla', 41000),
                                         '12-04-1980',
                                         'Matem�ticas',
                                         1000) );

INSERT INTO profesores VALUES ( profesor('Carlos',
                                         'Fern�ndez',
                                         direccion('Calle Andaluc�a', 'Ja�n', 23401),
                                         '07-04-1990',
                                         'Inform�tica',
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
        pr.asignatura = 'Inform�tica';

    p.aumentosalario(100); -- llamamos a la funcion y el salario aumenta 100�, pero no se actualiza la tabla
    UPDATE profesores pr -- entonces hacemos un update para que se actualice
    SET VALUE ( pr ) = p
    WHERE
        pr.asignatura = 'Inform�tica';

    dbms_output.put_line('El salario es de: ' || p.salario);
END;

-- CREAR UN ARRAY
CREATE OR REPLACE TYPE telefonoVArray as varray(3) of varchar2(9);

CREATE OR REPLACE TYPE administrativo UNDER Persona (
    categoria VARCHAR2(50),
    telefonos telefonoVArray,
    MEMBER FUNCTION bonus(base NUMBER) RETURN NUMBER,
    -- MEMBER FUCTION bonus(base NUMBER) RETURN NUMBER  esta sobrecarga no ser�a v�lida, porque tiene el mismo nombre, mismo par�metro que recibe y retorna el mismo tipo de dato
    -- MEMBER FUCTION bonus(hola NUMBER) RETURN NUMBER tampoco ser�a v�lido
    -- MEMBER FUCTION bonus(hola NUMBER, base NUMBER) RETURN NUMBER
    -- MEMBER FUCTION bonus(base NUMBER, hola NUMBER) RETURN NUMBER estas dos tampoco ser�an v�lidas
    MEMBER FUNCTION bonus(base NUMBER, base1 NUMBER) RETURN NUMBER -- esto ser�a v�lido
    
);

CREATE OR REPLACE TYPE Becario UNDER Persona (
    universidad VARCHAR(50),
    telefonos telefonoVArray,
    -- POLIMORFISMO CON OVERRIDING
    OVERRIDING MEMBER FUNCTION calcularEdad RETURN Number
);

CREATE OR REPLACE TYPE BODY Administrativo AS
    MEMBER FUNCTION bonus(base NUMBER) RETURN NUMBER IS
    BEGIN
    -- SE USA EL SELF PARA DIFERENCIAR EL ATRIBUTO DE LA VARIABLE
        RETURN base*1.1;
    END;
    
    MEMBER FUNCTION bonus(base NUMBER, base1 NUMBER) RETURN NUMBER IS
    BEGIN
        RETURN (base + base1);
    END;
END;

CREATE OR REPLACE TYPE BODY becario AS OVERRIDING
    MEMBER FUNCTION calcularedad RETURN NUMBER IS
    BEGIN
        RETURN floor(months_between(sysdate, fecha_nacimiento) / 12);
    END calcularedad;

END;

CREATE TABLE becarios OF becario;
CREATE TABLE administrativos OF administrativo;

-- bloque de prueba, crear objeto y comprobar funciones

DECLARE
    a administrativo;
    b becario;
BEGIN
    a := NEW administrativo('Adri�n', 'Segura', direccion('Calle oficina', 'Madrid', 20100), '01-06-1985', 'ugr', telefonovarray('123456789'
    , '987654321', '999999999'));

    b := NEW becario('Carlos', 'Ramos', direccion('Calle oficina', 'Madrid', 20100), '25-03-1999', 'UJA', telefonovarray('123456789')
    );

    dbms_output.put_line('Sueldo base del administrativo: ' || a.bonus(1000));
    dbms_output.put_line('Sueldo base + extra del administrativo: '
                         || a.bonus(1000, 200));
    dbms_output.put_line('Edad del becario: ' || b.calcularedad);
END;


-- M�TODOS EST�TICOS

CREATE OR REPLACE TYPE dispositivo AS OBJECT (
        modelo  VARCHAR2(50),
        consumo NUMBER,
        CONSTRUCTOR FUNCTION dispositivo (
               cosumo NUMBER,
               modelo VARCHAR2
           ) RETURN SELF AS RESULT,
-- MAP se usa para ordenar de mayor a menor
        MAP MEMBER FUNCTION mapconsumo RETURN NUMBER,
        STATIC FUNCTION tipouso RETURN VARCHAR2
);

CREATE OR replace type body dispositivo as 
constructor
    FUNCTION dispositivo (
        consumo NUMBER,
        modelo  VARCHAR2
    ) RETURN SELF AS RESULT IS
    BEGIN
        self.consumo := consumo;
        self.modelo := modelo;
        RETURN;
    END;
map member
    FUNCTION mapconsumo RETURN NUMBER IS
    BEGIN
        RETURN self.consumo;
    END;
STATIC FUNCTION tipouso RETURN VARCHAR2 is
    begin
        RETURN 'Electr�nico';
     end;
end;

drop type dispositivo force;
-- crear un bloque an�nimo para la estructura de arriba
DECLARE
    d1 dispositivo := NEW dispositivo(1200, 'Aire Acondicionado');
    d2 dispositivo := NEW dispositivo(75, 'Aspiradora');
BEGIN
    dbms_output.put_line('El dispositivo '
                         || d1.modelo
                         || ' es de tipo '
                         || dispositivo.tipouso);
END;