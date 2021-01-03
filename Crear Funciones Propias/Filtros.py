#__XEngineLib__ = None
#__BaseDatos__ = None
#__ClsMain__ = None

class __filtros__:
    '''Proporciona funciones para realizar filtros en el sistema CONTAPQi Comercial Start/Pro'''

    def EstablecerFiltrosDatos(self):
        '''Establece los filtros de los datos de la aplicacion'''

        intModuleId = __XEngineLib__.ActiveModuleID
        tbbEngModuleParameter = __BaseDatos__.TablaBase('engModuleParameter')
        dttDatos = __ClsMain__.Aplicacion.TablaParametros
        regDatos = dttDatos.Rows[0]
        for columna in dttDatos.Columns:

            col = columna.ColumnName
            cmdRegistro = tbbEngModuleParameter.Registra(
                (
                    ('ParameterKey', col),
                    ('ModuleID', intModuleId)
                )
            )

            cmdRegistro.Asignar('Value', regDatos[col])
            cmdRegistro.Asignar('ParameterKey', col)
            cmdRegistro.Asignar('ModuleID', intModuleId)
            cmdRegistro.Asignar('Section', 'AccesoFacil')
            cmdRegistro.Asignar('ParameterCaption', col)

            cmdRegistro.Ejecutar()

filtro = __filtros__()