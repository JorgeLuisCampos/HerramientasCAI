clr.AddReference('System.Windows.Forms')
clr.AddReference ("System.Data")
clr.AddReference("System.Data.Common")


from System.Data.SqlClient import SqlConnection, SqlCommand, SqlParameter
from System.Data import CommandType
from System.Windows.Forms import MessageBox

cadConexion = "Server=VersionTI-vps\Compac;Database=cspVersionTI;UserId=sa;password=password;"
Conexion = SqlConnection(cadConexion)
try:
    Conexion.Open()  
except:
    MessageBox.Show("Ocurrió un error al conectar con la base de datos.")

try:
    cmd = SqlCommand("_VTI_spPrueba", Conexion)
    cmd.CommandType = CommandType.StoreProcedure
    cmd.Parameters.AddWithValue("@1",{[pID]})
    cmd.Parameters.AddWithValue("@2",'{[cDescripcion]}')
    cmd.ExecuteNonQuery()
    MessageBox.Show("Proceso ejecutado correctamente")
except Exception as ex:
    MessageBox.Show("Ocurrió un error al ejecutar la instrucción")
    MessageBox.show(str(ex))
finally:
    Conexion.Close()