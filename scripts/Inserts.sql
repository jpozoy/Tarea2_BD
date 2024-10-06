-- Carga de Pacientes 
INSERT INTO Pacientes (n_carnet, nombre, apellido1, apellido2, telefono, correo, sexo, padecimientos) 
VALUES 
(1001, 'Juan', 'Perez', 'Gomez', '0987654321', 'juan.perez@example.com', 'M', 1),
(1002, 'Maria', 'Lopez', 'Diaz', '0981234567', 'maria.lopez@example.com', 'F', 2),
(1003, 'Pedro', 'Ramirez', 'Abdul', '0989876543', 'pedro.ramirez@example.com', 'M', 1),
(1004, 'Carlos', 'Hernandez', 'Lopez', '0987654322', 'carlos.hernandez@example.com', 'M', 3),
(1005, 'Lucia', 'Martinez', 'Gomez', '0987654323', 'lucia.martinez@example.com', 'F', 2),
(1006, 'Miguel', 'Sanchez', 'Perez', '0987654324', 'miguel.sanchez@example.com', 'M', 1),
(1007, 'Laura', 'Diaz', 'Ramirez', '0987654325', 'laura.diaz@example.com', 'F', 4),
(1008, 'Jorge', 'Gonzalez', 'Martinez', '0987654326', 'jorge.gonzalez@example.com', 'M', 2),
(1009, 'Ana', 'Rodriguez', 'Hernandez', '0987654327', 'ana.rodriguez@example.com', 'F', 3),
(1010, 'Pablo', 'Fernandez', 'Lopez', '0987654328', 'pablo.fernandez@example.com', 'M', 1),
(1011, 'Elena', 'Garcia', 'Sanchez', '0987654329', 'elena.garcia@example.com', 'F', 2),
(1012, 'Raul', 'Lopez', 'Diaz', '0987654330', 'raul.lopez@example.com', 'M', 4),
(1013, 'Marta', 'Perez', 'Gonzalez', '0987654331', 'marta.perez@example.com', 'F', 3),
(1014, 'Sergio', 'Ramirez', 'Rodriguez', '0987654332', 'sergio.ramirez@example.com', 'M', 1),
(1015, 'Isabel', 'Gomez', 'Fernandez', '0987654333', 'isabel.gomez@example.com', 'F', 2);

-- Carga de Padecimientos
INSERT INTO Padecimientos (nombre_padecimiento, fecha_diagnostico, gravedad, estado, paciente) 
VALUES 
('Diabetes', '2023-01-10', 'moderado', 'activo', 1001),
('Hipertensión', '2022-06-15', 'severo', 'activo', 1002),
('Asma', '2021-03-20', 'leve', 'inactivo', 1003),
-- Padecimientos para paciente 1004
('Diabetes', '2022-05-10', 'moderado', 'activo', 1004),
('Hipertensión', '2021-11-15', 'severo', 'activo', 1004),
('Asma', '2020-03-20', 'leve', 'inactivo', 1004),
-- Padecimientos para paciente 1005
('Artritis', '2023-02-10', 'moderado', 'activo', 1005),
('Migraña', '2022-07-15', 'leve', 'activo', 1005),
('Gastritis', '2021-04-20', 'moderado', 'inactivo', 1005),
('Hipotiroidismo', '2020-09-25', 'leve', 'activo', 1005),
-- Padecimientos para paciente 1006
('Diabetes', '2023-01-10', 'moderado', 'activo', 1006),
('Hipertensión', '2022-06-15', 'severo', 'activo', 1006),
('Asma', '2021-03-20', 'leve', 'inactivo', 1006),
-- Padecimientos para paciente 1007
('Asma', '2023-03-10', 'leve', 'activo', 1007),
('Hipertensión', '2022-08-15', 'moderado', 'activo', 1007),
('Diabetes', '2021-05-20', 'severo', 'inactivo', 1007),
('Artritis', '2020-10-25', 'moderado', 'activo', 1007),
-- Padecimientos para paciente 1008
('Gastritis', '2023-04-10', 'moderado', 'activo', 1008),
('Migraña', '2022-09-15', 'leve', 'activo', 1008),
('Hipotiroidismo', '2021-06-20', 'leve', 'inactivo', 1008),
-- Padecimientos para paciente 1009
('Diabetes', '2023-01-10', 'moderado', 'activo', 1009),
('Hipertensión', '2022-06-15', 'severo', 'activo', 1009),
('Asma', '2021-03-20', 'leve', 'inactivo', 1009),
-- Padecimientos para paciente 1010
('Artritis', '2023-02-10', 'moderado', 'activo', 1010),
('Migraña', '2022-07-15', 'leve', 'activo', 1010),
('Gastritis', '2021-04-20', 'moderado', 'inactivo', 1010),
('Hipotiroidismo', '2020-09-25', 'leve', 'activo', 1010),
-- Padecimientos para paciente 1011
('Asma', '2023-03-10', 'leve', 'activo', 1011),
('Hipertensión', '2022-08-15', 'moderado', 'activo', 1011),
('Diabetes', '2021-05-20', 'severo', 'inactivo', 1011),
-- Padecimientos para paciente 1012
('Gastritis', '2023-04-10', 'moderado', 'activo', 1012),
('Migraña', '2022-09-15', 'leve', 'activo', 1012),
('Hipotiroidismo', '2021-06-20', 'leve', 'inactivo', 1012),
-- Padecimientos para paciente 1013
('Diabetes', '2023-01-10', 'moderado', 'activo', 1013),
('Hipertensión', '2022-06-15', 'severo', 'activo', 1013),
('Asma', '2021-03-20', 'leve', 'inactivo', 1013),
-- Padecimientos para paciente 1014
('Artritis', '2023-02-10', 'moderado', 'activo', 1014),
('Migraña', '2022-07-15', 'leve', 'activo', 1014),
('Gastritis', '2021-04-20', 'moderado', 'inactivo', 1014),
('Hipotiroidismo', '2020-09-25', 'leve', 'activo', 1014),
-- Padecimientos para paciente 1015
('Asma', '2023-03-10', 'leve', 'activo', 1015),
('Hipertensión', '2022-08-15', 'moderado', 'activo', 1015),
('Diabetes', '2021-05-20', 'severo', 'inactivo', 1015);

-- Carga de Personal_Medico
INSERT INTO Personal_Medico (cedula, nombre, apellido1, apellido2, telefono, correo, especialidad, experiencia)
VALUES 
(2002, 'Pedro', 'Gonzalez', 'Lopez', '0987651235', 'pedro.gonzalez@example.com', 'Neurología', '8 años'),
(2003, 'Maria', 'Sanchez', 'Ramirez', '0987651236', 'maria.sanchez@example.com', 'Pediatría', '12 años'),
(2004, 'Juan', 'Diaz', 'Fernandez', '0987651237', 'juan.diaz@example.com', 'Dermatología', '7 años'),
(2005, 'Laura', 'Rodriguez', 'Gomez', '0987651238', 'laura.rodriguez@example.com', 'Ginecología', '15 años'),
(2006, 'Sofia', 'Hernandez', 'Garcia', '0987651239', 'sofia.hernandez@example.com', 'Psiquiatría', '9 años'),
(2007, 'Miguel', 'Lopez', 'Martinez', '0987651240', 'miguel.lopez@example.com', 'Oftalmología', '11 años'),
(2008, 'Carlos', 'Perez', 'Diaz', '0987651241', 'carlos.perez@example.com', 'Oncología', '13 años'),
(2009, 'Elena', 'Gomez', 'Sanchez', '0987651242', 'elena.gomez@example.com', 'Endocrinología', '6 años'),
(2010, 'Jorge', 'Ramirez', 'Lopez', '0987651243', 'jorge.ramirez@example.com', 'Reumatología', '14 años'),
(2011, 'Lucia', 'Fernandez', 'Gonzalez', '0987651244', 'lucia.fernandez@example.com', 'Nefrología', '10 años');

-- Carga de Medicamentos
INSERT INTO Medicamento (id_medicamento, nombre, compuesto_activo, dosificacion)
VALUES 
(3001, 'Paracetamol', 'Acetaminofén', '500mg'),
(3002, 'Insulina', 'Insulina Humana', '10 unidades'),
(3003, 'Salbutamol', 'Salbutamol', '2mg'),
(3004, 'Ibuprofeno', 'Ibuprofeno', '400mg'),
(3005, 'Amoxicilina', 'Amoxicilina', '500mg'),
(3006, 'Loratadina', 'Loratadina', '10mg'),
(3007, 'Metformina', 'Metformina', '850mg'),
(3008, 'Omeprazol', 'Omeprazol', '20mg'),
(3009, 'Aspirina', 'Ácido Acetilsalicílico', '100mg'),
(3010, 'Clonazepam', 'Clonazepam', '2mg');

-- Carga de Efectos Secundarios
INSERT INTO Efecto_Secundario (medicamento, efecto)
VALUES 
-- Efectos secundarios para Paracetamol
(3001, 'Náuseas'),
(3001, 'Dolor de cabeza'),
-- Efectos secundarios para Insulina
(3002, 'Hipoglucemia'),
(3002, 'Aumento de peso'),
-- Efectos secundarios para Salbutamol
(3003, 'Temblor'),
(3003, 'Aceleración del pulso'),
-- Efectos secundarios para Ibuprofeno
(3004, 'Dolor de estómago'),
(3004, 'Mareos'),
(3004, 'Erupciones cutáneas'),
-- Efectos secundarios para Amoxicilina
(3005, 'Diarrea'),
(3005, 'Erupciones cutáneas'),
(3005, 'Náuseas'),
-- Efectos secundarios para Loratadina
(3006, 'Somnolencia'),
(3006, 'Dolor de cabeza'),
-- Efectos secundarios para Metformina
(3007, 'Náuseas'),
(3007, 'Diarrea'),
-- Efectos secundarios para Omeprazol
(3008, 'Dolor de cabeza'),
(3008, 'Diarrea'),
-- Efectos secundarios para Aspirina
(3009, 'Sangrado gastrointestinal'),
(3009, 'Náuseas'),
-- Efectos secundarios para Clonazepam
(3010, 'Somnolencia'),
(3010, 'Mareos');





