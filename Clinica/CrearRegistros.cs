using MySql.Data.MySqlClient;
using System.Collections.Generic;

namespace Clinica
{
    public class CrearRegistros
    {
        private readonly ConexionMySQL _conexion;

        public CrearRegistros()
        {
            _conexion = new ConexionMySQL();
        }

        public List<dynamic> ObtenerPacientes()
        {
            List<dynamic> pacientes = new List<dynamic>();
            using (var conn = _conexion.AbrirConexion())
            {
                string query = "SELECT n_carnet, nombre FROM Pacientes";
                using (var command = new MySqlCommand(query, conn))
                {
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            pacientes.Add(new
                            {
                                Id = reader.GetInt32("n_carnet"),
                                Nombre = reader.GetString("nombre")
                            });
                        }
                    }
                }
            }
            return pacientes;
        }

        public List<dynamic> ObtenerMedicos()
        {
            List<dynamic> medicos = new List<dynamic>();
            using (var conn = _conexion.AbrirConexion())
            {
                string query = "SELECT Cedula, Nombre FROM Personal_Medico";
                using (var command = new MySqlCommand(query, conn))
                {
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            medicos.Add(new
                            {
                                Id = reader.GetInt32("Cedula"),
                                Nombre = reader.GetString("Nombre")
                            });
                        }
                    }
                }
            }
            return medicos;
        }

        public List<dynamic> ObtenerMedicamentos()
        {
            List<dynamic> medicamentos = new List<dynamic>();
            using (var conn = _conexion.AbrirConexion())
            {
                string query = "SELECT id_medicamento, nombre FROM Medicamento";
                using (var command = new MySqlCommand(query, conn))
                {
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            medicamentos.Add(new
                            {
                                Id = reader.GetInt32("id_medicamento"),
                                Nombre = reader.GetString("nombre")
                            });
                        }
                    }
                }
            }
            return medicamentos;
        }

        public void RegistrarCita(int pacienteId, int medicoId, List<int> medicamentosSeleccionados, string motivo, string resultados, DateTime fechaInicio, DateTime fechaFin, string tipoTratamiento, string descripcionTratamiento, DateTime fechaInicioTratamiento, DateTime fechaFinTratamiento, Dictionary<int, string> dosificaciones)
        {
            using (var conn = _conexion.AbrirConexion())
            {
                using (var transaction = conn.BeginTransaction())
                {
                    try
                    {
                        // Insertar la información básica de la cita
                        string queryCita = @"INSERT INTO Cita (fecha_hora, hora_fin, motivo, resultados,  paciente, medico)
                     VALUES (@fechaInicio, @fechaFin, @motivo, @resultados, @pacienteId, @medicoId)";
                        MySqlCommand command = new MySqlCommand(queryCita, conn, transaction);
                        command.Parameters.AddWithValue("@fechaInicio", fechaInicio);
                        command.Parameters.AddWithValue("@fechaFin", fechaFin);
                        command.Parameters.AddWithValue("@motivo", motivo);
                        command.Parameters.AddWithValue("@resultados", resultados);
                        command.Parameters.AddWithValue("@pacienteId", pacienteId);
                        command.Parameters.AddWithValue("@medicoId", medicoId);

                        // Ejecutar el insert
                        int rowsAffected = command.ExecuteNonQuery();  // Este es el comando que ejecuta el query
                        // Obtener el ID de la cita recién insertada
                        long citaId = command.LastInsertedId;

                        // Insertar el tratamiento asociado a la cita
                        string queryTratamiento = @"INSERT INTO Tratamiento_Cita (tipo, tratamiento, fecha_inicio, fecha_fin, cita)
                            VALUES (@tipoTratamiento, @descripcionTratamiento, @fechaInicioTratamiento, @fechaFinTratamiento, @citaId)";
                        MySqlCommand commandTratamiento = new MySqlCommand(queryTratamiento, conn, transaction);
                        commandTratamiento.Parameters.AddWithValue("@tipoTratamiento", tipoTratamiento);
                        commandTratamiento.Parameters.AddWithValue("@descripcionTratamiento", descripcionTratamiento);
                        commandTratamiento.Parameters.AddWithValue("@fechaInicioTratamiento", fechaInicioTratamiento);
                        commandTratamiento.Parameters.AddWithValue("@fechaFinTratamiento", fechaFinTratamiento);
                        commandTratamiento.Parameters.AddWithValue("@citaId", citaId); // ID de la cita

                        int rowsAffectedTratamiento = commandTratamiento.ExecuteNonQuery();

                        // Insertar los medicamentos seleccionados
                        foreach (var medicamentoId in medicamentosSeleccionados)
                        {
                            string dosificacion = dosificaciones[medicamentoId]; // Obtener la dosificación para el medicamento
                            string queryMedicamento = @"INSERT INTO Cita_Medicamentos (id_cita, id_medicamento, dosificacion)
                                                 VALUES (@citaId, @medicamentoId, @dosificacion)";
                            using (var commandMedicamento = new MySqlCommand(queryMedicamento, conn, transaction))
                            {
                                commandMedicamento.Parameters.AddWithValue("@citaId", citaId);
                                commandMedicamento.Parameters.AddWithValue("@medicamentoId", medicamentoId);
                                commandMedicamento.Parameters.AddWithValue("@dosificacion", dosificacion);

                                commandMedicamento.ExecuteNonQuery();
                            }
                        }

                        // Verificar si se insertó algo
                        if (rowsAffected > 0)
                        {
                            Console.WriteLine("Inserción exitosa. Filas afectadas: " + rowsAffected);
                        }
                        else
                        {
                            Console.WriteLine("No se insertaron filas.");
                        }


                        transaction.Commit();
                    }
                    catch (Exception)
                    {
                        Console.WriteLine("Se hizo rollback");
                        transaction.Rollback();
                        throw;
                    }
                }
            }

        }
        public void RegistrarProcedimiento(int pacienteId, int medicoId, List<int> medicosSeleccionados, string epicrisis, DateTime fechaInicio, DateTime fechaFin, string tipoTratamiento, string descripcionTratamiento, DateTime fechaInicioTratamiento, DateTime fechaFinTratamiento, List<int> medicamentosSeleccionados, Dictionary<int, string> dosificaciones, List<int> personalAdicional)
        {

            using (var conn = _conexion.AbrirConexion())
            {
                using (var transaction = conn.BeginTransaction())
                {
                    try
                    {
                        // Insertar la información básica del procedimiento
                        string queryProcedimiento = @"INSERT INTO Procedimiento (fecha_hora, hora_fin, epicrisis, paciente, medico)
                                           VALUES (@fechaInicio, @fechaFin,  @epicrisis, @pacienteId, @medicoId);";
                        MySqlCommand command = new MySqlCommand(queryProcedimiento, conn, transaction);
                        command.Parameters.AddWithValue("@fechaInicio", fechaInicio);
                        command.Parameters.AddWithValue("@fechaFin", fechaFin);
                        command.Parameters.AddWithValue("@epicrisis", epicrisis);
                        command.Parameters.AddWithValue("@pacienteId", pacienteId);
                        command.Parameters.AddWithValue("@medicoId", medicoId);

                        // Ejecutar el insert
                        command.ExecuteNonQuery();
                        long procedimientoId = command.LastInsertedId;

                        // Insertar el tratamiento asociado a la cita
                        string queryTratamiento = @"INSERT INTO Tratamiento_Procedimiento (tipo, tratamiento, fecha_inicio, fecha_fin, procedimiento)
                            VALUES (@tipoTratamiento, @descripcionTratamiento, @fechaInicioTratamiento, @fechaFinTratamiento, @procedimientoId)";
                        MySqlCommand commandTratamiento = new MySqlCommand(queryTratamiento, conn, transaction);
                        commandTratamiento.Parameters.AddWithValue("@tipoTratamiento", tipoTratamiento);
                        commandTratamiento.Parameters.AddWithValue("@descripcionTratamiento", descripcionTratamiento);
                        commandTratamiento.Parameters.AddWithValue("@fechaInicioTratamiento", fechaInicioTratamiento);
                        commandTratamiento.Parameters.AddWithValue("@fechaFinTratamiento", fechaFinTratamiento);
                        commandTratamiento.Parameters.AddWithValue("@procedimientoId", procedimientoId); // ID del procedimiento

                        commandTratamiento.ExecuteNonQuery();

                        foreach (var medicamentoId in medicamentosSeleccionados)
                        {
                            string dosificacion = dosificaciones[medicamentoId]; // Obtener la dosificación para el medicamento
                            string queryMedicamento = @"INSERT INTO Procedimiento_Medicamentos (id_procedimiento, id_medicamento, dosificacion)
                                                 VALUES (@procedimientoId, @medicamentoId, @dosificacion)";
                            using (var commandMedicamento = new MySqlCommand(queryMedicamento, conn, transaction))
                            {
                                commandMedicamento.Parameters.AddWithValue("@procedimientoId", procedimientoId);
                                commandMedicamento.Parameters.AddWithValue("@medicamentoId", medicamentoId);
                                commandMedicamento.Parameters.AddWithValue("@dosificacion", dosificacion);

                                commandMedicamento.ExecuteNonQuery();
                            }
                        }

                        // Insertar personal adicional en Procedimiento_Personal
                        foreach (var personalId in personalAdicional)
                        {
                            string queryPersonal = @"INSERT INTO Procedimiento_Personal (id_procedimiento, id_medico)
                                             VALUES (@procedimientoId, @personalId)";
                            using (var commandPersonal = new MySqlCommand(queryPersonal, conn, transaction))
                            {
                                commandPersonal.Parameters.AddWithValue("@procedimientoId", procedimientoId);
                                commandPersonal.Parameters.AddWithValue("@personalId", personalId);

                                commandPersonal.ExecuteNonQuery();
                            }
                        }


                        transaction.Commit();
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine("Se hizo rollback");
                        Console.WriteLine($"Error: {ex.Message}");
                        if (ex.InnerException != null)
                        {
                            Console.WriteLine($"Inner Exception: {ex.InnerException.Message}");
                        }
                        transaction.Rollback();
                        throw;
                    }
                }
            }
        }
    }
}
