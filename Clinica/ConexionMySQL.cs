using MySql.Data.MySqlClient;

namespace Clinica
{
    // Clase para manejar la conexión a MySQL
    public class ConexionMySQL
    {
        // Cadena de conexión definida dentro de la clase
        private string connectionString = "server=localhost;port=3306;database=clinica;uid=root;password=1234";

        // Constructor de la clase
        public ConexionMySQL()
        {
            // Puedes inicializar otras propiedades si es necesario
        }

        // Método para abrir una conexión a la base de datos
        public MySqlConnection AbrirConexion()
        {
            MySqlConnection connection = new MySqlConnection(connectionString);
            try
            {
                connection.Open();
                Console.WriteLine("Conexión a MySQL exitosa.");
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error al abrir la conexión: " + ex.Message);
            }

            return connection;
        }

        // Método para cerrar la conexión
        public void CerrarConexion(MySqlConnection connection)
        {
            try
            {
                if (connection.State == System.Data.ConnectionState.Open)
                {
                    connection.Close();
                    Console.WriteLine("Conexión cerrada.");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error al cerrar la conexión: " + ex.Message);
            }
        }
    }
}
