clr.AddReference('System.Windows.Forms')
from System.Windows.Forms import MessageBox

Conexion = gl['conn']
tbsCtl = Conexion.TablaBase('engRibbonControl')
tbsMnu = Conexion.TablaBase('engRibbonMenu')

ctlAgr = tbsCtl.Añade()

ctlAgr.Asignar('ControlIDBase', 0)
ctlAgr.Asignar('ProductID', 0)
ctlAgr.Asignar('ModuleID', 0)
ctlAgr.Asignar('ControlCaption', '{[cNombre]}')
ctlAgr.Asignar('ControlExecute', 'AccesoFacil.{[cAppKey]}')
ctlAgr.Asignar('IconFile', '{[cIcono]}')
ctlAgr.Asignar('SystemButtonOrder', '{[cOrden]}')	# Para agregar el orden

ctlAgr.Ejecutar()
ControlID = tbsCtl.UltimoID('ControlID')

ModuleID = clsMain.Aplicacion.clsMainInstance.ModuleID
	
mnuAgr = tbsMnu.Añade()

mnuAgr.Asignar('RibbonGroupID', gl['RibbonGroupID'])
mnuAgr.Asignar('ControlID', ControlID)
mnuAgr.Asignar('ControlType', 1)
mnuAgr.Asignar('ExtraMenuModuleID', ModuleID)
mnuAgr.asignar('ControlOrder', '{[cOrden]}')		# Para agregar el orden

mnuAgr.Ejecutar()

mensaje = "{0} se creo en el grupo: {1}, pestaña {2}.".format(
	'{[cNombre]}',
	'{[cGrupo]}',
	'{[cPestana]}'
)

MessageBox.Show(mensaje)