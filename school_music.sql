CREATE TABLE STUDENTS
(
    id_student INT NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    birthdate DATE NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone_number INT(10)NOT NULL,
    email_address VARCHAR(100) NOT NULL
);

CREATE TABLE COURSES
(
    id_course INT NOT NULL AUTO_INCREMENT,
    name_course VARCHAR(50) NOT NULL,
    skill_level VARCHAR(45) NOT NULL,
    instrument_type VARCHAR(50) NOT NULL,
    PRIMARY KEY(id_course)
);

CREATE TABLE REGISTRATIONS
(
    id_registration INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_student INT NOT NULL,
    id_course INT NOT NULL,
    Foreign Key (id_student) REFERENCES STUDENTS(id_student),
    Foreign Key (id_course) REFERENCES COURSES(id_course),
    registration_date DATE NOT NULL,
    registration_payment BOOLEAN NOT NULL,
);

INSERT INTO students
    (id_student, name, lastname, birthdate, address, phone_number, email_address)
VALUES
    (1712995632, 'Jaime', 'García', '2003-04-15', 'Calle Falsa 123, Madrid', 605143456, 'jaime.garcia@example.com'),
    (1756871852, 'Carlos', 'Martínez', '2001-09-23', 'Avenida Siempre Viva 742, Barcelona', 601234567, 'carlos.martinez@example.com'),
    (1745998534, 'Lucía', 'López', '2002-01-12', 'Plaza Mayor 10, Sevilla', 602345678, 'lucia.lopez@example.com'),
    (1756412378, 'Pedro', 'Gómez', '2000-07-05', 'Calle del Sol 45, Valencia', 603456789, 'pedro.gomez@example.com'),
    (1789234521, 'María', 'Fernández', '2004-11-30', 'Gran Vía 120, Bilbao', 604567890, 'maria.fernandez@example.com');

INSERT INTO COURSES
    (name_course, skill_level, instrument_type)
VALUES
    ('Violín Avanzado', 'Avanzado', 'Violín'),
    ('Guitarra Clásica', 'Principiante', 'Cuerda'),
    ('Piano Avanzado', 'Avanzado', 'Teclado'),
    ('Violín Intermedio', 'Intermedio', 'Cuerda'),
    ('Batería Básica', 'Principiante', 'Percusión'),
    ('Canto Moderno', 'Intermedio', 'Voz');



INSERT INTO REGISTRATIONS
    (id_student, id_course, registration_date, registration_payment)
VALUES
    (1789234521, 5, '2024-07-15', TRUE),
    (1756412378, 3, '2024-06-01', TRUE),
    (1745998534, 1, '2024-05-22', FALSE),
    (1756871852, 3, '2024-02-20', FALSE),
    (1728995632, 1, '2024-01-15', TRUE),
    (1789234521, 3, '2024-02-20', FALSE),
    (1756412378, 2, '2024-03-10', TRUE),
    (1756871852, 4, '2024-04-05', TRUE),
    (1745998534, 5, '2024-05-12', FALSE)
;
