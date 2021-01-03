clr.AddReference('System.Data')
clr.AddReference('System.Windows.Forms')

from System.Data import DataTable
from System.Data.OleDb import *
from System.Windows.Forms import *
from CAI.Base.NucleoCAI import *

# Abre la conexión con Excel
conExl = OleDbConnection("provider=Microsoft.ACE.OLEDB.12.0;Data Source= C:\Users\Usuario1\Desktop\prueba.xlsx; Extended Properties=Excel 12.0;")
conExl.Open()

# dtSch = conExl.GetSchema('Tables')
# Matrices.Mostrar(dtSch.DefaultView())

dstExl = DataTable('frutas')
cmdExl = OleDbCommand('select * from [frutas$]', conExl)
adpExl = OleDbDataAdapter(cmdExl)
adpExl.Fill(dstExl)

# Despliega en un mensaje cada uno de los renglones del archivo
for reg in dstExl.Rows:	
	MessageBox.Show(reg['Fruta'].ToString())