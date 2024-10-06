-- Consulta 2 
CREATE VIEW MedicamentosUtilizadosPorMesAnio AS
SELECT 
    m.nombre AS medicamento,
    YEAR(c.fecha_hora) AS anio,
    MONTH(c.fecha_hora) AS mes,
    COUNT(cm.id_medicamento) AS total_cantidad_utilizada
FROM 
    Cita c
JOIN 
    Cita_Medicamentos cm ON c.id_cita = cm.id_cita
JOIN 
    Medicamento m ON cm.id_medicamento = m.id_medicamento
GROUP BY 
    m.nombre, anio, mes

UNION ALL

SELECT 
    m.nombre AS medicamento,
    YEAR(p.fecha_hora) AS anio,
    MONTH(p.fecha_hora) AS mes,
    COUNT(pm.id_medicamento) AS total_cantidad_utilizada
FROM 
    Procedimiento p
JOIN 
    Procedimiento_Medicamentos pm ON p.id_procedimiento = pm.id_procedimiento
JOIN 
    Medicamento m ON pm.id_medicamento = m.id_medicamento
GROUP BY 
    m.nombre, anio, mes
ORDER BY 
    anio DESC, mes DESC, medicamento;
    
SELECT * FROM MedicamentosUtilizadosPorMesAnio;

-- Consulta #3
CREATE OR REPLACE VIEW InformePadecimientosPorAno AS
SELECT 
    pad.nombre_padecimiento,
    YEAR(pad.fecha_diagnostico) AS año,
    COUNT(DISTINCT pad.paciente) AS cantidad_personas
FROM 
    Padecimientos pad
GROUP BY 
    pad.nombre_padecimiento, año
ORDER BY 
    pad.nombre_padecimiento, año;

SELECT * FROM InformePadecimientosPorAno;

-- Consulta #4
CREATE OR REPLACE VIEW InformeAtencionesPorPersonal AS
SELECT 
    pm.cedula AS personal_medico,
    pm.nombre AS nombre_medico,
    COALESCE(SUM(citas.citas_atendidas), 0) AS total_citas,
    COALESCE(SUM(procedimientos.procedimientos_atendidos), 0) AS total_procedimientos,
    COALESCE(SUM(medicamentos.cantidad_medicamentos), 0) AS total_medicamentos
FROM 
    Personal_Medico pm
LEFT JOIN (
    SELECT 
        c.medico,
        COUNT(*) AS citas_atendidas
    FROM 
        Cita c
    GROUP BY 
        c.medico
) citas ON pm.cedula = citas.medico
LEFT JOIN (
    SELECT 
        p.medico,
        COUNT(*) AS procedimientos_atendidos
    FROM 
        Procedimiento p
    GROUP BY 
        p.medico
) procedimientos ON pm.cedula = procedimientos.medico
LEFT JOIN (
    SELECT 
        c.medico,
        COUNT(cm.id_medicamento) AS cantidad_medicamentos
    FROM 
        Cita_Medicamentos cm
    JOIN 
        Cita c ON cm.id_cita = c.id_cita
    GROUP BY 
        c.medico
    UNION ALL
    SELECT 
        p.medico,
        COUNT(pm.id_medicamento) AS cantidad_medicamentos
    FROM 
        Procedimiento_Medicamentos pm
    JOIN 
        Procedimiento p ON pm.id_procedimiento = p.id_procedimiento
    GROUP BY 
        p.medico
) medicamentos ON pm.cedula = medicamentos.medico
GROUP BY 
    pm.cedula, pm.nombre;
    
SELECT * FROM InformeAtencionesPorPersonal;

-- Consulta #5
CREATE OR REPLACE VIEW InformePacientes AS
SELECT 
    p.n_carnet,
    p.nombre,
    p.apellido1,
    p.apellido2,
    p.telefono,
    p.correo,
    p.sexo,
    COUNT(DISTINCT pad.nombre_padecimiento) AS cantidad_padecimientos,
    COUNT(DISTINCT c.id_cita) + COUNT(DISTINCT proc.id_procedimiento) AS cantidad_citas_procedimientos,
    COUNT(DISTINCT cm.id_medicamento) + COUNT(DISTINCT pm.id_medicamento) AS cantidad_medicamentos,
    MAX(c.fecha_hora) AS fecha_ultima_cita
FROM 
    Pacientes p
LEFT JOIN 
    Padecimientos pad ON p.n_carnet = pad.paciente
LEFT JOIN 
    Cita c ON p.n_carnet = c.paciente
LEFT JOIN 
    Procedimiento proc ON p.n_carnet = proc.paciente
LEFT JOIN 
    Cita_Medicamentos cm ON c.id_cita = cm.id_cita
LEFT JOIN 
    Procedimiento_Medicamentos pm ON proc.id_procedimiento = pm.id_procedimiento
GROUP BY 
    p.n_carnet, p.nombre, p.apellido1, p.apellido2, p.telefono, p.correo, p.sexo;


CREATE VIEW VistaCitaCompleta AS
SELECT 
    C.id_cita,
    P.nombre AS Nombre_Paciente,
    M.nombre AS Nombre_Medico,
    T.tratamiento AS Tratamiento,
    T.tipo AS Tipo_Tratamiento,
    C.resultados AS Resultados,
    GROUP_CONCAT(DISTINCT Med.nombre SEPARATOR ', ') AS Medicamentos
FROM 
    Cita C
JOIN Pacientes P ON C.paciente = P.n_carnet
JOIN Personal_Medico M ON C.medico = M.cedula
JOIN Tratamiento_Cita T ON C.id_cita = T.cita
LEFT JOIN Cita_Medicamentos CM ON C.id_cita = CM.id_cita
LEFT JOIN Medicamento Med ON CM.id_medicamento = Med.id_medicamento
GROUP BY C.id_cita, P.nombre, M.nombre, T.tratamiento, T.tipo, C.resultados;

SELECT * FROM VistaCitaCompleta;

CREATE VIEW VistaProcedimientoCompleto AS
SELECT 
    P.id_procedimiento,
    Pac.nombre AS Nombre_Paciente,
    Med.nombre AS Nombre_Medico,
    TP.tratamiento AS Tratamiento,
    TP.tipo AS Tipo_Tratamiento,
    P.epicrisis AS Epicrisis,
    GROUP_CONCAT(DISTINCT MedProc.nombre SEPARATOR ', ') AS Medicamentos
FROM 
    Procedimiento P
JOIN Pacientes Pac ON P.paciente = Pac.n_carnet
JOIN Personal_Medico Med ON P.medico = Med.cedula
JOIN Tratamiento_Procedimiento TP ON P.id_procedimiento = TP.procedimiento
LEFT JOIN Procedimiento_Medicamentos PM ON P.id_procedimiento = PM.id_procedimiento
LEFT JOIN Medicamento MedProc ON PM.id_medicamento = MedProc.id_medicamento
GROUP BY P.id_procedimiento, Pac.nombre, Med.nombre, TP.tratamiento, TP.tipo, P.epicrisis;

SELECT * FROM VistaProcedimientoCompleto;

SELECT * FROM InformePacientes;

select * from Pacientes;
select * from Personal_Medico;
Select * from Cita;
Select * from Tratamiento_Cita;
Select * from Cita_Medicamentos;
Select * from Procedimiento;
Select * from Procedimiento_Personal;

 
