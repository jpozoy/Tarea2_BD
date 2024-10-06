CREATE DATABASE IF NOT EXISTS clinica;

use clinica;

-- Tabla de Pacientes 
CREATE TABLE IF NOT EXISTS Pacientes (
	n_carnet INT PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	apellido1 VARCHAR(50) NOT NULL,
	apellido2 VARCHAR(50),
	telefono VARCHAR(20),
	correo VARCHAR(100),
	sexo ENUM('M', 'F', 'O'),
	padecimientos int
);


create table if not exists Padecimientos (
	nombre_padecimiento varchar(100) not null,
    fecha_diagnostico date,
    gravedad enum('leve', 'moderado', 'severo'),
    estado enum('activo', 'inactivo'),
    paciente int,
    primary key (nombre_padecimiento, paciente),
    foreign key (paciente) references Pacientes(n_carnet)
);

create table if not exists Personal_Medico (
	cedula int not null primary key,
	nombre varchar(50) not null,
	apellido1 varchar(50) not null,
	apellido2 varchar(50),
	telefono varchar(50),
	correo varchar(100),
	especialidad varchar(50),
	experiencia  varchar(50)
);
 
CREATE TABLE IF NOT EXISTS Cita (
    id_cita INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fecha_hora DATETIME,
    hora_fin DATETIME,
    motivo VARCHAR(100),
    resultados VARCHAR(200),
    paciente INT,
    medico INT,
    FOREIGN KEY (paciente) REFERENCES Pacientes(n_carnet),
    FOREIGN KEY (medico) REFERENCES Personal_Medico(cedula)
);

create table if not exists Tratamiento_Cita (
	id_tratamiento int not null auto_increment primary key,
	tipo varchar(50) not null,
	tratamiento varchar(200) not null,
	fecha_inicio date,
	fecha_fin date,
    cita int not null,
    foreign key (cita) references Cita(id_cita)
);

create table if not exists Procedimiento (
	id_procedimiento int not null auto_increment primary key,
	fecha_hora datetime,
	hora_fin datetime,
	epicrisis varchar(200),
	paciente int not null,
	medico int not null,
	foreign key (paciente) references Pacientes(n_carnet),
	foreign key (medico) references Personal_Medico(cedula)
);

create table if not exists Tratamiento_Procedimiento (
	id_tratamiento int not null auto_increment primary key,
	tipo varchar(50) not null,
	tratamiento varchar(200) not null,
	fecha_inicio date,
	fecha_fin date,
    procedimiento int not null,
    foreign key (procedimiento) references Procedimiento(id_procedimiento)
);
 
 -- Tabla intermedia para indicar personal adicional en un procedimiento
create table if not exists Procedimiento_Personal (
	id_medico int not null,
	id_procedimiento int not null,
    primary key (id_medico, id_procedimiento),
    foreign key (id_medico) references Personal_Medico(cedula),
    foreign key (id_procedimiento) references Procedimiento(id_procedimiento)
);
  
-- Tabla de medicamentos
create table if not exists Medicamento (
	id_medicamento int not null primary key,
	nombre varchar(50) not null,
    compuesto_activo varchar(50),
    dosificacion varchar(50)
);

-- Tabla de efectos secundarios
create table if not exists Efecto_Secundario (
	medicamento int not null,
    efecto varchar(50) not null,
    primary key (medicamento, efecto),
    foreign key (medicamento) references Medicamento(id_medicamento)
);

-- Tabla intermedia de Procedimiento_Medicamentos
create table if not exists Procedimiento_Medicamentos (
	id_procedimiento int not null,
    id_medicamento int not null, 
    dosificacion varchar(100) not null,
    primary key (id_procedimiento, id_medicamento),
    foreign key (id_procedimiento) references Procedimiento(id_procedimiento),
    foreign key (id_medicamento) references Medicamento(id_medicamento)
);

-- Tabla intermedia de Cita_Medicamentos
create table if not exists Cita_Medicamentos (
	id_cita int not null,
    id_medicamento int not null, 
    dosificacion varchar(100) not null,
    primary key (id_cita, id_medicamento),
    foreign key (id_cita) references Cita(id_cita),
    foreign key (id_medicamento) references Medicamento(id_medicamento)
);

  
  
 
 
 
 
  

