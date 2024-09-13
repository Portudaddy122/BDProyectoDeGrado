-- Tabla Dirección
CREATE TABLE Direccion (
    idDireccion TEXT PRIMARY KEY,
    Zona VARCHAR(100),
    Calle VARCHAR(100),
    Num_Puerta VARCHAR(10)
);


-- Tabla Persona
CREATE TABLE Persona (
    idPersona TEXT PRIMARY KEY,
    idDireccion TEXT REFERENCES Direccion(idDireccion), -- Llave foránea hacia Dirección
    Nombres VARCHAR(100),
    Apellido_Paterno VARCHAR(100),
    Apellido_Materno VARCHAR(100),
    email VARCHAR(100),
    Rol VARCHAR(50),
    Num_Celular VARCHAR(15),
    Fecha_De_Nacimiento DATE
);



-- Tabla Profesor
CREATE TABLE Profesor (
    idProfesor TEXT PRIMARY KEY,
    idPersona TEXT REFERENCES Persona(idPersona), -- Llave foránea hacia Persona
    Contrasenia VARCHAR(100),
    Usuario VARCHAR(100)
);

-- Tabla Psicólogo
CREATE TABLE Psicologo (
    idPsicologo TEXT PRIMARY KEY,
    idPersona TEXT REFERENCES Persona(idPersona), -- Llave foránea hacia Persona
    Contrasenia VARCHAR(100),
    Usuario VARCHAR(100)
);
-- Tabla Padre de Familia
CREATE TABLE Padre_De_Familia (
    idPadre TEXT PRIMARY KEY,
    idPersona TEXT REFERENCES Persona(idPersona), -- Llave foránea hacia Persona
    Contrasenia VARCHAR(100),
    Usuario VARCHAR (100)
);
-- Tabla Curso
CREATE TABLE Curso (
    idCurso TEXT PRIMARY KEY,
    Paralelo VARCHAR(5),
    Nivel VARCHAR(50),
    Nombre VARCHAR(100),
    horaInicio TIME,
    horaFin TIME
);


-- Tabla Estudiante
CREATE TABLE Estudiante (
    idEstudiante TEXT PRIMARY KEY,
    idPersona TEXT REFERENCES Persona(idPersona), -- Llave foránea hacia Persona
    idPadre TEXT REFERENCES Padre_De_Familia(idPadre), -- Llave foránea hacia Padre de Familia
    idCurso TEXT REFERENCES Curso(idCurso) -- Llave foránea hacia Curso
);


--Tabla Administrador 
CREATE TABLE Administrador(
    idAdministrador TEXT PRIMARY KEY,
    Usuario VARCHAR(50),
    Contrasenia VARCHAR(100)
);
CREATE TABLE Materia(
    idMateria TEXT PRIMARY KEY,
    Nombre VARCHAR(50)  
);

CREATE TABLE Profesor_Dicta_Materia(
    idMateria TEXT REFERENCES Materia(idMateria),
    idProfesor TEXT REFERENCES Profesor(idProfesor ) -- Llave foránea hacia Persona
    
);
CREATE TABLE Materia_Pertenece_Curso(
    idMateria TEXT REFERENCES Materia(idMateria),
    idCurso TEXT REFERENCES Curso(idCurso) -- Llave foránea hacia Persona
    
);
CREATE TABLE Reservar_Cita(
    idReservarCita TEXT PRIMARY KEY,
    idProfesor TEXT REFERENCES Profesor(idProfesor), -- Llave foránea hacia Profesor
    idPsicologo TEXT REFERENCES Psicologo(idPsicologo ),  --Llave foranea  
    idPadre TEXT REFERENCES Padre_De_Familia(idPadre), -- Llave foránea hacia Padre de Familia
    Fecha DATE,
    Descripcion VARCHAR(200) 
);

CREATE TABLE ActaDeReunion(
    idReservarCita TEXT REFERENCES Reservar_Cita(idReservarCita),
    Descripcion VARCHAR(500),
    fechaDeCreacion DATE
    
);

CREATE TABLE Prioridad(
    idPrioridad TEXT PRIMARY KEY,
    tipoPrioridad VARCHAR (15)
);

CREATE TABLE Motivo(
    idMotivo TEXT PRIMARY KEY,
    idPrioridad TEXT REFERENCES Prioridad(idPrioridad), -- Llave foránea hacia Prioridad
    idReservarCita TEXT REFERENCES Reservar_Cita(idReservarCita),
    nombreMotivo VARCHAR(100)
    
);


CREATE TABLE Estado(
    idEstado TEXT PRIMARY KEY,
    TipoEstado VARCHAR(30)
    
);

CREATE TABLE Horario(
    idMateria TEXT PRIMARY KEY,
    idEstado TEXT REFERENCES Estado(idEstado),
    horaInicio TIME,
    horaFin TIME,
    Fecha DATE
    
);







DROP SEQUENCE IF EXISTS direccion_id_seq;
DROP SEQUENCE IF EXISTS persona_id_seq;
DROP SEQUENCE IF EXISTS profesor_id_seq;
DROP SEQUENCE IF EXISTS psicologo_id_seq;
DROP SEQUENCE IF EXISTS estudiante_id_seq;
DROP SEQUENCE IF EXISTS padre_id_seq;
DROP SEQUENCE IF EXISTS administrador_id_seq;
DROP SEQUENCE IF EXISTS materia_id_seq;
DROP SEQUENCE IF EXISTS profesor_dicta_materia_id_seq;
DROP SEQUENCE IF EXISTS materia_pertenece_curso_id_seq;
DROP SEQUENCE IF EXISTS reservar_cita_id_seq;
DROP SEQUENCE IF EXISTS acta_reunion_id_seq;
DROP SEQUENCE IF EXISTS prioridad_id_seq;
DROP SEQUENCE IF EXISTS motivo_id_seq;
DROP SEQUENCE IF EXISTS estado_id_seq;
DROP SEQUENCE IF EXISTS horario_id_seq;





-- Dirección
CREATE SEQUENCE direccion_id_seq START WITH 1;

-- Persona
CREATE SEQUENCE persona_id_seq START WITH 1;

-- Profesor
CREATE SEQUENCE profesor_id_seq START WITH 1;

-- Psicólogo
CREATE SEQUENCE psicologo_id_seq START WITH 1;

-- Estudiante
CREATE SEQUENCE estudiante_id_seq START WITH 1;

-- Padre de Familia
CREATE SEQUENCE padre_id_seq START WITH 1;

-- Administrador
CREATE SEQUENCE administrador_id_seq START WITH 1;

-- Materia
CREATE SEQUENCE materia_id_seq START WITH 1;

-- Profesor Dicta Materia
CREATE SEQUENCE profesor_dicta_materia_id_seq START WITH 1;

-- Materia Pertenece Curso
CREATE SEQUENCE materia_pertenece_curso_id_seq START WITH 1;

-- Reservar Cita
CREATE SEQUENCE reservar_cita_id_seq START WITH 1;

-- Acta de Reunión
CREATE SEQUENCE acta_reunion_id_seq START WITH 1;

-- Prioridad
CREATE SEQUENCE prioridad_id_seq START WITH 1;

-- Motivo
CREATE SEQUENCE motivo_id_seq START WITH 1;

-- Estado
CREATE SEQUENCE estado_id_seq START WITH 1;

-- Horario
CREATE SEQUENCE horario_id_seq START WITH 1;

--Curso
CREATE SEQUENCE Curso_id_seq START WITH 1;








-- Dirección
CREATE OR REPLACE FUNCTION generate_direccion_id()
RETURNS TRIGGER AS $$
BEGIN
  NEW.idDireccion := 'DIR_' || LPAD(nextval('direccion_id_seq')::text, 5, '0');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_generate_direccion_id
BEFORE INSERT ON Direccion
FOR EACH ROW
EXECUTE FUNCTION generate_direccion_id();


INSERT INTO Direccion (Zona, Calle, Num_Puerta) VALUES
('Centro', 'Av. 16 de Julio', '123'),
('Sur', 'Calle 4', '45'),
('Norte', 'Calle 18', '78'),
('Este', 'Av. Arce', '232'),
('Oeste', 'Calle Bolívar', '5'),
('Centro', 'Av. Illimani', '678'),
('Sur', 'Calle San Pedro', '11'),
('Norte', 'Calle 12', '56'),
('Este', 'Av. Buenos Aires', '321'),
('Oeste', 'Calle Grau', '98'),
('Centro', 'Av. Camacho', '345'),
('Sur', 'Calle Flores', '22'),
('Norte', 'Calle Miraflores', '33'),
('Este', 'Av. Perú', '66'),
('Oeste', 'Calle Colón', '88');

-- Persona
CREATE OR REPLACE FUNCTION generate_persona_id()
RETURNS TRIGGER AS $$
BEGIN
  NEW.idPersona := 'PER_' || LPAD(nextval('persona_id_seq')::text, 5, '0');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_generate_persona_id
BEFORE INSERT ON Persona
FOR EACH ROW
EXECUTE FUNCTION generate_persona_id();


INSERT INTO Persona (idDireccion, Nombres, Apellido_Paterno, Apellido_Materno, email, Rol, Num_Celular, Fecha_De_Nacimiento) VALUES
('DIR_00001', 'Juan', 'Pérez', 'González', 'juan.perez@gmail.com', 'Profesor', '71234567', '1980-01-01'),
('DIR_00002', 'María', 'Ramírez', 'Soto', 'maria.ramirez@gmail.com', 'Psicólogo', '71234568', '1985-02-02'),
('DIR_00003', 'Carlos', 'Hernández', 'Lopez', 'carlos.hernandez@gmail.com', 'Estudiante', '71234569', '2002-03-03'),
('DIR_00004', 'Ana', 'Rojas', 'Mejía', 'ana.rojas@gmail.com', 'Padre de familia', '71234570', '1970-04-04'),
('DIR_00005', 'Jorge', 'Martínez', 'Lara', 'jorge.martinez@gmail.com', 'Administrador', '71234571', '1965-05-05'),
('DIR_00006', 'Laura', 'Zamora', 'Torres', 'laura.zamora@gmail.com', 'Profesor', '71234572', '1983-06-06'),
('DIR_00007', 'Luis', 'Ortega', 'Vega', 'luis.ortega@gmail.com', 'Psicólogo', '71234573', '1988-07-07'),
('DIR_00008', 'Sofía', 'Fernández', 'Quiroz', 'sofia.fernandez@gmail.com', 'Estudiante', '71234574', '2003-08-08'),
('DIR_00009', 'Pedro', 'Campos', 'Hurtado', 'pedro.campos@gmail.com', 'Padre de familia', '71234575', '1975-09-09'),
('DIR_00010', 'Paola', 'Reyes', 'Salinas', 'paola.reyes@gmail.com', 'Administrador', '71234576', '1973-10-10'),
('DIR_00011', 'Martín', 'Gutiérrez', 'Becerra', 'martin.gutierrez@gmail.com', 'Profesor', '71234577', '1990-11-11'),
('DIR_00012', 'Mónica', 'Fuentes', 'Delgado', 'monica.fuentes@gmail.com', 'Psicólogo', '71234578', '1992-12-12'),
('DIR_00013', 'Rodrigo', 'Suárez', 'Velasco', 'rodrigo.suarez@gmail.com', 'Estudiante', '71234579', '2004-01-13'),
('DIR_00014', 'Carmen', 'Muñoz', 'Carrillo', 'carmen.munoz@gmail.com', 'Padre de familia', '71234580', '1968-02-14'),
('DIR_00015', 'Ricardo', 'Rivas', 'Aguirre', 'ricardo.rivas@gmail.com', 'Administrador', '71234581', '1960-03-15');



-- Materia
CREATE OR REPLACE FUNCTION generate_materia_id()
RETURNS TRIGGER AS $$
BEGIN
  NEW.idMateria := 'MATER_' || LPAD(nextval('materia_id_seq')::text, 5, '0');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_generate_materia_id
BEFORE INSERT ON Materia
FOR EACH ROW
EXECUTE FUNCTION generate_materia_id();


INSERT INTO Materia (Nombre) VALUES
('Matemáticas'),
('Lenguaje'),
('Ciencias'),
('Historia'),
('Geografía'),
('Física'),
('Química'),
('Biología'),
('Literatura'),
('Arte'),
('Música'),
('Informática'),
('Educación Física'),
('Filosofía'),
('Economía');
SELECT * FROM Materia


-- Profesor
CREATE OR REPLACE FUNCTION generate_profesor_id()
RETURNS TRIGGER AS $$
BEGIN
  NEW.idProfesor := 'PROF_' || LPAD(nextval('profesor_id_seq')::text, 5, '0');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_generate_profesor_id
BEFORE INSERT ON Profesor
FOR EACH ROW
EXECUTE FUNCTION generate_profesor_id();

INSERT INTO Profesor (idPersona, Contrasenia, Usuario) VALUES
('PER_00001', 'password1', 'juanp'),
('PER_00006', 'password2', 'lauraz'),
('PER_00011', 'password3', 'marting'),
('PER_00015', 'password4', 'ricardor'),
('PER_00012', 'password5', 'monica'),
('PER_00007', 'password6', 'luisov'),
('PER_00013', 'password7', 'rodrigo');


-- Psicólogo
CREATE OR REPLACE FUNCTION generate_psicologo_id()
RETURNS TRIGGER AS $$
BEGIN
  NEW.idPsicologo := 'PSI_' || LPAD(nextval('psicologo_id_seq')::text, 5, '0');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_generate_psicologo_id
BEFORE INSERT ON Psicologo
FOR EACH ROW
EXECUTE FUNCTION generate_psicologo_id();

INSERT INTO Psicologo (idPersona, Contrasenia, Usuario) VALUES
('PER_00002', 'password8', 'mariar'),
('PER_00007', 'password9', 'luiso'),
('PER_00012', 'password10', 'monicaf'),
('PER_00003', 'password11', 'carlosh'),
('PER_00008', 'password12', 'sofiaf'),
('PER_00013', 'password13', 'rodrigos');



-- Curso
CREATE OR REPLACE FUNCTION generate_curso_id()
RETURNS TRIGGER AS $$
BEGIN
  NEW.idCurso := 'CURS_' || LPAD(nextval('curso_id_seq')::text, 5, '0');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_generate_curso_id
BEFORE INSERT ON Curso
FOR EACH ROW
EXECUTE FUNCTION generate_curso_id();


INSERT INTO Curso (Paralelo, Nivel, Nombre, horaInicio, horaFin) VALUES
('A', 'Primero', 'Matemáticas Básicas', '08:00:00', '10:00:00'),
('B', 'Primero', 'Lenguaje', '10:00:00', '12:00:00'),
('C', 'Primero', 'Ciencias', '13:00:00', '15:00:00'),
('A', 'Segundo', 'Matemáticas Avanzadas', '08:00:00', '10:00:00'),
('B', 'Segundo', 'Historia', '10:00:00', '12:00:00'),
('C', 'Segundo', 'Geografía', '13:00:00', '15:00:00'),
('A', 'Tercero', 'Física', '08:00:00', '10:00:00'),
('B', 'Tercero', 'Química', '10:00:00', '12:00:00'),
('C', 'Tercero', 'Biología', '13:00:00', '15:00:00'),
('A', 'Cuarto', 'Literatura', '08:00:00', '10:00:00'),
('B', 'Cuarto', 'Arte', '10:00:00', '12:00:00'),
('C', 'Cuarto', 'Música', '13:00:00', '15:00:00'),
('A', 'Quinto', 'Informática', '08:00:00', '10:00:00'),
('B', 'Quinto', 'Educación Física', '10:00:00', '12:00:00'),
('C', 'Quinto', 'Filosofía', '13:00:00', '15:00:00');

SELECT * FROM Curso


-- Padre de Familia
CREATE OR REPLACE FUNCTION generate_padre_id()
RETURNS TRIGGER AS $$
BEGIN
  NEW.idPadre := 'PADR_' || LPAD(nextval('padre_id_seq')::text, 5, '0');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_generate_padre_id
BEFORE INSERT ON Padre_De_Familia
FOR EACH ROW
EXECUTE FUNCTION generate_padre_id();

INSERT INTO Padre_De_Familia (idPersona, Contrasenia, Usuario) VALUES
('PER_00004', 'password14', 'ana'),
('PER_00009', 'password15', 'pedro'),
('PER_00014', 'password16', 'carmen');

SELECT * FROM Padre_De_Familia


-- Estudiante
CREATE OR REPLACE FUNCTION generate_estudiante_id()
RETURNS TRIGGER AS $$
BEGIN
  NEW.idEstudiante := 'ESTU_' || LPAD(nextval('estudiante_id_seq')::text, 5, '0');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_generate_estudiante_id
BEFORE INSERT ON Estudiante
FOR EACH ROW
EXECUTE FUNCTION generate_estudiante_id();

INSERT INTO Estudiante (idPersona, idPadre, idCurso) VALUES
('PER_00003', 'PADR_00001', 'CURS_00001'),
('PER_00008', 'PADR_00002', 'CURS_00002'),
('PER_00013', 'PADR_00003', 'CURS_00003'),
('PER_00001', 'PADR_00003', 'CURS_00004'),
('PER_00004', 'PADR_00002', 'CURS_00005'),
('PER_00005', 'PADR_00001', 'CURS_00006'),
('PER_00006', 'PADR_00002', 'CURS_00007'),
('PER_00007', 'PADR_00001', 'CURS_00008'),
('PER_00009', 'PADR_00003', 'CURS_00009'),
('PER_00010', 'PADR_00001', 'CURS_00010'),
('PER_00011', 'PADR_00003', 'CURS_00011'),
('PER_00012', 'PADR_00001', 'CURS_00012'),
('PER_00014', 'PADR_00002', 'CURS_00013'),
('PER_00015', 'PADR_00003', 'CURS_00014'),
('PER_00013', 'PADR_00003', 'CURS_00015');



-- Administrador
CREATE OR REPLACE FUNCTION generate_administrador_id()
RETURNS TRIGGER AS $$
BEGIN
  NEW.idAdministrador := 'ADM_' || LPAD(nextval('administrador_id_seq')::text, 5, '0');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_generate_administrador_id
BEFORE INSERT ON Administrador
FOR EACH ROW
EXECUTE FUNCTION generate_administrador_id();

INSERT INTO Administrador (Usuario, Contrasenia) VALUES
('admin1', 'adminpass1'),
('admin2', 'adminpass2'),
('admin3', 'adminpass3'),
('admin4', 'adminpass4'),
('admin5', 'adminpass5'),
('admin6', 'adminpass6'),
('admin7', 'adminpass7'),
('admin8', 'adminpass8'),
('admin9', 'adminpass9'),
('admin10', 'adminpass10'),
('admin11', 'adminpass11'),
('admin12', 'adminpass12'),
('admin13', 'adminpass13'),
('admin14', 'adminpass14'),
('admin15', 'adminpass15');


-- Prioridad
CREATE OR REPLACE FUNCTION generate_prioridad_id()
RETURNS TRIGGER AS $$
BEGIN
  NEW.idPrioridad := 'PRI_' || LPAD(nextval('prioridad_id_seq')::text, 5, '0');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_generate_prioridad_id
BEFORE INSERT ON Prioridad
FOR EACH ROW
EXECUTE FUNCTION generate_prioridad_id();


INSERT INTO Prioridad (tipoPrioridad) VALUES
('Alta'),
('Media'),
('Baja'),
('Alta'),
('Media'),
('Baja'),
('Baja'),
('Media'),
('Media'),
('Alta'),
('Media'),
('Naja'),
('Baja'),
('Media'),
('alta');

-- Estado
CREATE OR REPLACE FUNCTION generate_estado_id()
RETURNS TRIGGER AS $$
BEGIN
  NEW.idEstado := 'ESTA_' || LPAD(nextval('estado_id_seq')::text, 5, '0');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_generate_estado_id
BEFORE INSERT ON Estado
FOR EACH ROW
EXECUTE FUNCTION generate_estado_id();

INSERT INTO Estado (TipoEstado) VALUES
('Dsiponible'),
('Reservado'),
('Cancelado'),
('Completado');

-- Horario
CREATE OR REPLACE FUNCTION generate_horario_id()
RETURNS TRIGGER AS $$
BEGIN
  NEW.idMateria := 'HOR_' || LPAD(nextval('horario_id_seq')::text, 5, '0');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_generate_horario_id
BEFORE INSERT ON Horario
FOR EACH ROW
EXECUTE FUNCTION generate_horario_id();

INSERT INTO Horario (idMateria, idEstado, horaInicio, horaFin, Fecha) VALUES
('MATER_00001', 'ESTA_00001', '08:00:00', '10:00:00', '2024-09-01'),
('MATER_00002', 'ESTA_00002', '10:00:00', '12:00:00', '2024-09-02'),
('MATER_00003', 'ESTA_00003', '13:00:00', '15:00:00', '2024-09-03'),
('MATER_00004', 'ESTA_00001', '08:00:00', '10:00:00', '2024-09-04'),
('MATER_00005', 'ESTA_00002', '10:00:00', '12:00:00', '2024-09-05'),
('MATER_00006', 'ESTA_00002', '13:00:00', '15:00:00', '2024-09-06'),
('MATER_00007', 'ESTA_00002', '08:00:00', '10:00:00', '2024-09-07'),
('MATER_00008', 'ESTA_00002', '10:00:00', '12:00:00', '2024-09-08'),
('MATER_00009', 'ESTA_00001', '13:00:00', '15:00:00', '2024-09-09'),
('MATER_00010', 'ESTA_00001', '08:00:00', '10:00:00', '2024-09-10'),
('MATER_00011', 'ESTA_00001', '10:00:00', '12:00:00', '2024-09-11'),
('MATER_00012', 'ESTA_00002', '13:00:00', '15:00:00', '2024-09-12'),
('MATER_00013', 'ESTA_00002', '08:00:00', '10:00:00', '2024-09-13'),
('MATER_00014', 'ESTA_00003', '10:00:00', '12:00:00', '2024-09-14'),
('MATER_00015', 'ESTA_00003', '13:00:00', '15:00:00', '2024-09-15');

-- Reservar Cita
CREATE OR REPLACE FUNCTION generate_reservar_cita_id()
RETURNS TRIGGER AS $$
BEGIN
  NEW.idReservarCita := 'RECI_' || LPAD(nextval('reservar_cita_id_seq')::text, 5, '0');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_generate_reservar_cita_id
BEFORE INSERT ON Reservar_Cita
FOR EACH ROW
EXECUTE FUNCTION generate_reservar_cita_id();

INSERT INTO Reservar_Cita (idProfesor, idPsicologo, idPadre, Fecha, Descripcion) VALUES
('PROF_00001', 'PSI_00002', 'PADR_00001', '2024-09-01', 'Consulta inicial'),
('PROF_00006', 'PSI_00003', 'PADR_00001', '2024-09-02', 'Revisión de avance'),
('PROF_00001', 'PSI_00004', 'PADR_00002', '2024-09-03', 'Evaluación psicológica'),
('PROF_00001', 'PSI_00002', 'PADR_00003', '2024-09-04', 'Seguimiento de tratamiento'),
('PROF_00006', 'PSI_00003', 'PADR_00002', '2024-09-05', 'Consulta de rutina'),
('PROF_00005', 'PSI_00001', 'PADR_00001', '2024-09-06', 'Informe de progreso'),
('PROF_00001', 'PSI_00005', 'PADR_00003', '2024-09-07', 'Entrevista con los padres'),
('PROF_00006', 'PSI_00001', 'PADR_00003', '2024-09-08', 'Ajustes en la terapia'),
('PROF_00007', 'PSI_00002', 'PADR_00001', '2024-09-09', 'Planificación de intervención'),
('PROF_00001', 'PSI_00003', 'PADR_00002', '2024-09-10', 'Asesoramiento'),
('PROF_00006', 'PSI_00004', 'PADR_00001', '2024-09-11', 'Sesión de grupo'),
('PROF_00003', 'PSI_00005', 'PADR_00002', '2024-09-12', 'Terapia familiar'),
('PROF_00001', 'PSI_00006', 'PADR_00002', '2024-09-13', 'Consulta final'),
('PROF_00006', 'PSI_00002', 'PADR_00003', '2024-09-14', 'Reevaluación'),
('PROF_00004', 'PSI_00001', 'PADR_00001', '2024-09-15', 'Despedida');


SELECT * FROM Reservar_cita









--PRESENTAN ALGUNOS PROBLEMAS




-- Motivo
CREATE OR REPLACE FUNCTION generate_motivo_id()
RETURNS TRIGGER AS $$
BEGIN
  NEW.idMotivo := 'MOTI_' || LPAD(nextval('motivo_id_seq')::text, 5, '0');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_generate_motivo_id
BEFORE INSERT ON Motivo
FOR EACH ROW
EXECUTE FUNCTION generate_motivo_id();

INSERT INTO Motivo (idPrioridad, idReservarCita, nombreMotivo) VALUES
('PRI_00001', 'RECI_00001', 'Problema de conducta'),
('PRI_00002', 'RECI_00002', 'Revisión de progreso académico'),
('PRI_00003', 'RECI_00003', 'Intervención psicológica'),
('PRI_00004', 'RECI_00004', 'Planificación de terapia'),
('PRI_00005', 'RECI_00005', 'Ajustes en el tratamiento'),
('PRI_00006', 'RECI_00006', 'Informe de avance'),
('PRI_00007', 'RECI_00007', 'Consulta con los padres'),
('PRI_00008', 'RECI_00008', 'Ajuste de terapia'),
('PRI_00009', 'RECI_00009', 'Planificación de intervención'),
('PRI_00010', 'RECI_00010', 'Asesoramiento educativo'),
('PRI_00011', 'RECI_00011', 'Sesión de grupo'),
('PRI_00012', 'RECI_00012', 'Terapia familiar'),
('PRI_00013', 'RECI_00013', 'Consulta final'),
('PRI_00014', 'RECI_00014', 'Reevaluación'),
('PRI_00015', 'RECI_00015', 'Despedida');





-- Acta de Reunión
CREATE OR REPLACE FUNCTION generate_acta_reunion_id()
RETURNS TRIGGER AS $$
BEGIN
  NEW.idReservarCita := 'ACRE_' || LPAD(nextval('acta_reunion_id_seq')::text, 5, '0');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_generate_acta_reunion_id
BEFORE INSERT ON ActaDeReunion
FOR EACH ROW
EXECUTE FUNCTION generate_acta_reunion_id();

SELECT * FROM reservar_cita

INSERT INTO ActaDeReunion (idReservarCita, Descripcion, fechaDeCreacion) VALUES
('RECI_00001', 'Reunión para discutir avance del tratamiento', '2024-09-01'),
('RECI_00002', 'Evaluación del progreso del estudiante', '2024-09-02'),
('RECI_00003', 'Revisión de la intervención psicológica', '2024-09-03'),
('RECI_00004', 'Planificación de la siguiente etapa de terapia', '2024-09-04'),
('RECI_00005', 'Consulta sobre ajuste de tratamiento', '2024-09-05'),
('RECI_00006', 'Informe sobre progreso del estudiante', '2024-09-06'),
('RECI_00007', 'Entrevista con padres sobre el desarrollo', '2024-09-07'),
('RECI_00008', 'Revisión de los ajustes necesarios en la terapia', '2024-09-08'),
('RECI_00009', 'Planificación de la próxima intervención', '2024-09-09'),
('RECI_00010', 'Asesoramiento sobre necesidades educativas', '2024-09-10'),
('RECI_00011', 'Sesión de grupo para estudiantes', '2024-09-11'),
('RECI_00012', 'Terapia familiar para mejorar la dinámica', '2024-09-12'),
('RECI_00013', 'Consulta final para cerrar el caso', '2024-09-13'),
('RECI_00014', 'Reevaluación final del progreso', '2024-09-14'),
('RECI_00015', 'Reunión de despedida y cierre de caso', '2024-09-15');


-- Profesor Dicta Materia
CREATE OR REPLACE FUNCTION generate_profesor_dicta_materia_id()
RETURNS TRIGGER AS $$
BEGIN
  NEW.idmateria := 'PRODIM_' || LPAD(nextval('profesor_dicta_materia_id_seq')::text, 5, '0');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_generate_profesor_dicta_materia_id
BEFORE INSERT ON Profesor_Dicta_Materia
FOR EACH ROW
EXECUTE FUNCTION generate_profesor_dicta_materia_id();

INSERT INTO Profesor_Dicta_Materia (idMateria, idProfesor) VALUES
('MATER_00001', 'PROF_00001'),
('MATER_00002', 'PROF_00001'),
('MATER_00003', 'PROF_00002'),
('MATER_00004', 'PROF_00003'),
('MATER_00005', 'PROF_00003'),
('MATER_00006', 'PROF_00004'),
('MATER_00007', 'PROF_00005'),
('MATER_00008', 'PROF_00006'),
('MATER_00009', 'PROF_00007'),
('MATER_00010', 'PROF_00008'),
('MATER_00011', 'PROF_00009'),
('MATER_00012', 'PROF_00010'),
('MATER_00013', 'PROF_00011'),
('MATER_00014', 'PROF_00012'),
('MATER_00015', 'PROF_00013');



-- Materia Pertenece Curso
CREATE OR REPLACE FUNCTION generate_materia_pertenece_curso_id()
RETURNS TRIGGER AS $$
BEGIN
  NEW.idMateriaPerteneceCurso := 'MATPERC_' || LPAD(nextval('materia_pertenece_curso_id_seq')::text, 5, '0');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_generate_materia_pertenece_curso_id
BEFORE INSERT ON Materia_Pertenece_Curso
FOR EACH ROW
EXECUTE FUNCTION generate_materia_pertenece_curso_id();


INSERT INTO Materia_Pertenece_Curso (idMateria, idCurso) VALUES
('MATER_00001', 'CURS_00001'),
('MATER_00002', 'CURS_00002'),
('MATER_00003', 'CURS_00003'),
('MATER_00004', 'CURS_00004'),
('MATER_00005', 'CURS_00005'),
('MATER_00006', 'CURS_00006'),
('MATER_00007', 'CURS_00007'),
('MATER_00008', 'CURS_00008'),
('MATER_00009', 'CURS_00009'),
('MATER_00010', 'CURS_00010'),
('MATER_00011', 'CURS_00011'),
('MATER_00012', 'CURS_00012'),
('MATER_00013', 'CURS_00013'),
('MATER_00014', 'CURS_00014'),
('MATER_00015', 'CURS_00015');























