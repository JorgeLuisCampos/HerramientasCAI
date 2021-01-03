Conexion = gl['conn']
tbsTab = Conexion.TablaBase('engRibbonGroup')

selTab = tbsTab.Selecciona()
selTab.Donde('RibbonTabID', gl['RibbonTabID'])
selTab.YTambien('GroupCaption', '{[cGrupo]}')

if selTab.HayResultados():	
	gl['RibbonGroupID'] = selTab.Tabla().Rows[0]['RibbonGroupID']
else:
	agrGpo = tbsTab.Añade()
	
	agrGpo.Asignar('RibbonGroupIDBase', 0)
	agrGpo.Asignar('RibbonTabID', gl['RibbonTabID'])
	agrGpo.Asignar('GroupCaption', '{[cGrupo]}')
	agrGpo.Asignar('GroupOrder', 100)
	
	agrGpo.Ejecutar()
	gl['RibbonGroupID'] = tbsTab.UltimoID('RibbonGroupID')