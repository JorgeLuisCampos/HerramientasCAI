Script:
gl['MasDeUnProveedor'] = 0
if gl['tbl'].Rows.Count > 1:
	id_cliente = 0
	for reg in gl['tbl'].Rows:
		if id_cliente == 0:
			id_cliente = reg['BusinessEntityID'] 
		else:
			if id_cliente != reg['BusinessEntityID']:
				gl['MasDeUnProveedor'] = 1
				break