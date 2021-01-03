import clr
clr.AddReference('System.Windows.Forms')
from System.Windows.Forms import MessageBox

Conexion = gl['conn']
tbsTab = Conexion.TablaBase('engRibbonTab')

selTab = tbsTab.Selecciona() 					# Equivalente a: <-- Select * from enrRibbonTab -->
selTab.Donde('ModuleID', 0)  					# Equivalente a: <-- Where ModuleId = 0 -->
selTab.YTambien('TabCaption', '{[cPestana]}')	# Equivalente a: <-- AND TabCaption = cPestana -->

if selTab.HayResultados():	
	gl['RibbonTabID'] = selTab.Tabla().Rows[0]['RibbonTabID']
else:
	agrTab = tbsTab.Añade()
	
	agrTab.Asignar('RibbonTabIDBase', 0)
	agrTab.Asignar('ProductID', 1)
	agrTab.Asignar('ModuleID', 0)
	agrTab.Asignar('TabCaption', '{[cPestana]}')
	
	agrTab.Ejecutar()
	gl['RibbonTabID'] = tbsTab.UltimoID('RibbonTabID')

# MessageBox.Show(str(gl['RibbonTabID']))