# La clase debe tener dos guiones bajos al principio y al final

class __operaciones__:
    '''Proporciona funciones para realizar operaciones aritmeticas'''

    # El "*" indica que se trata de un argumento de longitud variable o lista.
    def Suma(self, *valores):
        '''Sumo los -valores-'''
        buffer = 0

        for numero in valores:

            # Siempre Acceso Facil envia cadenas, por lo cual es necesario realizar la conversion.
            buffer += int(numero)

        return buffer

    # Reemplaza el guion bajo, por espacio y covierte el estilo de escritura en capital.
    # por ejemplo primer_valor = Primer Valor.
    def Resta(self, primer_valor, segundo_valor):
        '''Resta al -Primer Valor- el -Segundo Valor-'''

        return int(primer_valor) - int(segundo_valor)

# Es necesario, declarar una variable sin dos guiones bajos al principio, ni al final, para
# indicar a Acceso Facil que la debe usar como instancia.
operaciones = __operaciones__()