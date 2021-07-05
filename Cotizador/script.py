# Si por algún motivo clsMain.DocumentItems es nulo, se crea.

if gl['main'].DocumentItems is None:
	gl['main'].DocumentItems = Interaction.CreateObject('Document.clsDocumentItems')

# Se agregan 5 partidas con datos falsos para ilustrar el
# funcionamiento de esta caracteristica con un ciclo.

for n in [1,2,3,4,5]:

	nDocItm = gl['main'].DocumentItems.Add("IDNew")
	#nDocItm.CreateNewProduct = 1
	nDocItm.ProductID = n
	nDocItm.ApplyGlobalDiscount = -1
	nDocItm.TaxTypeID = 1
	nDocItm.TaxPerc = 0.16
	nDocItm.MustBeDelivered = bool(0)
	nDocItm.Description = 'Producto_{0}'.format(n)
	nDocItm.Quantity = 10
	nDocItm.UnitPrice = 1000
	nDocItm.Total = 10000
