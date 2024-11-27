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

-- Encuentra los estudiantes que están registrados en el curso de "Piano Avanzado".

SELECT st.id_student, CONCAT(st.name,' ',st.lastname) as student_name, name_course
from students as st, registrations as rg, courses as cr
WHERE st.id_student=rg.id_student and cr.id_course= rg.id_course AND cr.name_course='Piano Avanzado';


SELECT st.id_student, CONCAT(st.name,' ',st.lastname) as student_name, name_course
from students as st JOIN registrations as rg ON st.id_student=rg.id_student JOIN courses as cr ON cr.id_course=rg.id_course
WHERE name_course='Piano Avanzado';

-- Muestra solo los nombres de todos los cursos ofrecidos.
SELECT name_course
FROM courses;

-- Calcula cuántas inscripciones hay en total.
SELECT COUNT(*) AS total_registrations
FROM registrations;

-- Muestra los estudiantes que se registraron después del 1 de abril de 2024.
SELECT st.id_student, CONCAT(st.name,' ',st.lastname), id_registration, registration_date
from students st JOIN registrations rg ON st.id_student=rg.id_student
WHERE registration_date>'2024-04-01';

-- Contar la cantidad de alumnos que han abonado la inscripción

SELECT COUNT(*) as number_registered_students
from registrations
WHERE registration_payment=TRUE;

-- Lista las inscripciones donde el pago ha sido realizado 
SELECT *
from registrations
WHERE registration_payment=TRUE;

-- Encuentra todos los cursos que tienen el nivel de habilidad 'Principiante'.

SELECT *
FROM courses
WHERE skill_level='Principiante';

-- Encuentra estudiantes cuyos números de teléfono terminen en '567'.

SELECT id_student, CONCAT(name,' ',lastname) as student_name, phone_number
FROM students
WHERE phone_number LIKE '%567';


-- Mostrar los nombres de los estudiantes y los cursos en los que están inscritos
SELECT CONCAT(name,' ',lastname) as student_name, name_course
from students st JOIN registrations rg ON st.id_student=rg.id_student JOIN courses cr on rg.id_course=cr.id_course;

-- Obtener el nombre y apellido de los alumnos que están inscritos en más de un curso
SELECT st.id_student, CONCAT(name,' ',lastname) as student_name, COUNT(*) as number_courses_registered
from students st JOIN registrations rg ON st.id_student=rg.id_student JOIN courses cr on rg.id_course=cr.id_course
GROUP BY st.id_student
HAVING COUNT(*)>1;

-- Muestra el nombre del estudiante junto con la cantidad de cursos en los que está inscrito.
SELECT st.id_student, CONCAT(name,' ',lastname) as student_name, COUNT(*) as number_courses_registered
from students st JOIN registrations rg ON st.id_student=rg.id_student JOIN courses cr on rg.id_course=cr.id_course
GROUP BY st.id_student;

-- Estudiantes no registrados en ningún curso:
SELECT *
FROM students
WHERE id_student NOT IN ( SELECT id_student
FROM registrations);

-- Encuentra los cursos que no tienen ninguna inscripción.
SELECT *
FROM courses
WHERE id_course NOT IN( SELECT id_course
FROM registrations);

-- Buscar el curso con más inscripciones
SELECT c.id_course, c.name_course, COUNT(*) as number_registrations
FROM courses c JOIN registrations r on c.id_course=r.id_course
GROUP BY c.id_course
ORDER BY number_registrations DESC
LIMIT 1;

-- Estudiantes que han realizado pagos en todos sus cursos:
SELECT id_student, CONCAT(name,' ',lastname)
FROM students
WHERE id_student NOT IN(SELECT id_student
from registrations
WHERE registration_payment=FALSE);

SELECT id_student, CONCAT(name,' ',lastname)
FROM STUDENTS S
WHERE NOT EXISTS (
    SELECT 1
FROM REGISTRATIONS R
WHERE R.id_student = S.id_student
    AND R.registration_payment = FALSE
);

-- Inscripciones con la fecha más reciente:
SELECT *
FROM REGISTRATIONS
WHERE registration_date = (SELECT MAX(registration_date)
FROM REGISTRATIONS);


