DELETE accPoliza
DELETE accPolizaTransaccion
DELETE accPolizaTransaccionComprobante
DELETE accPolizaTransaccionMetodoPago
DELETE accPolizasPorDocumentID
DBCC CHECKIDENT (accPoliza, RESEED, 0)
DBCC CHECKIDENT (accPolizaTransaccion, RESEED, 0)
DBCC CHECKIDENT (accPolizaTransaccionComprobante, RESEED, 0)
DBCC CHECKIDENT (accPolizaTransaccionMetodoPago, RESEED, 0)


---DELETE engrefAccountingCatalog
---DBCC CHECKIDENT (engrefAccountingCatalog, RESEED, 0)