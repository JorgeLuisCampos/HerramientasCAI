# Se genera un diccionario con la información recibida desde
# Comercial SP.

pars = {
	par.split('=')[0]:par.split('=')[1] 
	for par in gl['main'].Value.split(';') 
	if len(par.split('=')) > 1
}

# Se deben realizar los cambios requeridos a la partida desde
# el diccionario anteriomente generado.

pars['ProductID'] = {[cProductoID]}
pars['Description'] = '{[cProducto]}'

# Se genera una lista con la información conetenida en el 
# diccionario ya modificado, con el formato requerido.

lst = ['{0}={1}'.format(p, pars[p]) for p in pars.keys()]

# Se asigna al valor esperado por ComercialSP una cadena de
# información separada por ';'.

gl['main'].Value = ';'.join(lst)
