
ALTER PROCEDURE zRTRECALCULOINV 
@1 BIGINT
AS
BEGIN
DELETE orgProductKardex WHERE ProductID=@1

--kardex1
INSERT INTO orgProductKardex ( DateTransaction, DepotID, ProductID, DocumentID, DocumentItemID, Quantity, QuantityToBeDelivered, AmountPrice, QuantityImport )
SELECT docDocument.DateDocument, docDocument.DepotID, docDocumentItem.ProductID, docDocumentItem.DocumentID, docDocumentItem.DocumentItemID, docDocumentItem.Quantity AS Quantity, 0 AS QuantityToBeDelivered, docDocumentItem.UnitPrice, 0 AS QuantityImport
FROM (((docDocument INNER JOIN docDocumentItem ON docDocument.DocumentID = docDocumentItem.DocumentID) INNER JOIN zRTAFECTACIONESINVENTARIO ON docDocument.ModuleID = zRTAFECTACIONESINVENTARIO.ModuleID) LEFT JOIN orgProductKardex ON (docDocumentItem.DocumentID = orgProductKardex.DocumentID) AND (docDocumentItem.DocumentItemID = orgProductKardex.DocumentItemID)) INNER JOIN orgProduct ON docDocumentItem.ProductID = orgProduct.ProductID
WHERE (((zRTAFECTACIONESINVENTARIO.Value)='1') AND ((docDocument.CancelledOn) Is Null) AND ((docDocumentItem.DeletedOn) Is Null) AND ((docDocument.DeletedOn) Is Null) AND ((orgProductKardex.StockTransactionID) Is Null)) AND (dbo.orgProduct.ProductTypeID <> 4)
AND docDocumentItem.ProductID=@1

--kardex-1
INSERT INTO orgProductKardex ( DateTransaction, DepotID, ProductID, DocumentID, DocumentItemID, Quantity, QuantityToBeDelivered, AmountPrice, QuantityImport )
SELECT docDocument.DateDocument, docDocument.DepotID, docDocumentItem.ProductID, docDocumentItem.DocumentID, docDocumentItem.DocumentItemID, -docDocumentItem.Quantity AS Quantity, 0 AS QuantityToBeDelivered, docDocumentItem.UnitPrice, 0 AS QuantityImport
FROM (((docDocument INNER JOIN docDocumentItem ON docDocument.DocumentID = docDocumentItem.DocumentID) INNER JOIN zRTAFECTACIONESINVENTARIO ON docDocument.ModuleID = zRTAFECTACIONESINVENTARIO.ModuleID) LEFT JOIN orgProductKardex 
ON (docDocumentItem.DocumentID = orgProductKardex.DocumentID) AND (docDocumentItem.DocumentItemID = orgProductKardex.DocumentItemID)) INNER JOIN orgProduct 
ON docDocumentItem.ProductID = orgProduct.ProductID
WHERE (((zRTAFECTACIONESINVENTARIO.Value)='-1') AND ((docDocument.CancelledOn) Is Null) AND ((docDocumentItem.DeletedOn) Is Null) AND ((docDocument.DeletedOn) Is Null) AND ((orgProductKardex.StockTransactionID) Is Null)) AND (dbo.orgProduct.ProductTypeID <> 4)
AND docDocumentItem.ProductID=@1

--kardex2
INSERT INTO orgProductKardex ( DateTransaction, DepotID, AmountPrice, ProductID, DocumentID, DocumentItemID, Quantity, QuantityToBeDelivered, QuantityImport )
SELECT docDocument.DateDocument, docDocument.DepotID, docDocumentItem.UnitPrice, docDocumentItem.ProductID, docDocumentItem.DocumentID, docDocumentItem.DocumentItemID, 0 AS Quantity, docDocumentItem.Quantity AS QuantityToBeDelivered, 0 AS QuantityImport
FROM (((docDocument INNER JOIN docDocumentItem ON docDocument.DocumentID = docDocumentItem.DocumentID) INNER JOIN zRTAFECTACIONESINVENTARIO ON docDocument.ModuleID = zRTAFECTACIONESINVENTARIO.ModuleID) LEFT JOIN orgProductKardex ON (docDocumentItem.DocumentID = orgProductKardex.DocumentID) AND (docDocumentItem.DocumentItemID = orgProductKardex.DocumentItemID)) INNER JOIN orgProduct ON docDocumentItem.ProductID = orgProduct.ProductID
WHERE (((zRTAFECTACIONESINVENTARIO.Value)='2') AND ((docDocument.CancelledOn) Is Null) AND ((docDocumentItem.DeletedOn) Is Null) AND ((docDocument.DeletedOn) Is Null) AND ((orgProductKardex.StockTransactionID) Is Null)) AND (dbo.orgProduct.ProductTypeID <> 4)
AND docDocumentItem.ProductID=@1

--kardex-2
INSERT INTO orgProductKardex ( DateTransaction, DepotID, AmountPrice, ProductID, DocumentID, DocumentItemID, Quantity, QuantityToBeDelivered, QuantityImport )
SELECT docDocument.DateDocument, docDocument.DepotID, docDocumentItem.UnitPrice, docDocumentItem.ProductID, docDocumentItem.DocumentID, docDocumentItem.DocumentItemID, 0 AS Quantity, -docDocumentItem.Quantity AS QuantityToBeDelivered, 0 AS QuantityImport
FROM (((docDocument INNER JOIN docDocumentItem ON docDocument.DocumentID = docDocumentItem.DocumentID) INNER JOIN zRTAFECTACIONESINVENTARIO ON docDocument.ModuleID = zRTAFECTACIONESINVENTARIO.ModuleID) LEFT JOIN orgProductKardex ON (docDocumentItem.DocumentID = orgProductKardex.DocumentID) AND (docDocumentItem.DocumentItemID = orgProductKardex.DocumentItemID)) INNER JOIN orgProduct ON docDocumentItem.ProductID = orgProduct.ProductID
WHERE (((zRTAFECTACIONESINVENTARIO.Value)='-2') AND ((docDocument.CancelledOn) Is Null) AND ((docDocumentItem.DeletedOn) Is Null) AND ((docDocument.DeletedOn) Is Null) AND ((orgProductKardex.StockTransactionID) Is Null)) AND (dbo.orgProduct.ProductTypeID <> 4)
AND docDocumentItem.ProductID=@1

--kardex3
INSERT INTO orgProductKardex ( DateTransaction, DepotID, AmountPrice, ProductID, DocumentID, DocumentItemID, Quantity, QuantityToBeDelivered, QuantityImport )
SELECT docDocument.DateDocument, docDocument.DepotID, docDocumentItem.UnitPrice, docDocumentItem.ProductID, docDocumentItem.DocumentID, docDocumentItem.DocumentItemID, docDocumentItem.Quantity, -docDocumentItem.Quantity AS QuantityToBeDelivered, 0 AS QuantityImport
FROM (((docDocument INNER JOIN docDocumentItem ON docDocument.DocumentID = docDocumentItem.DocumentID) INNER JOIN zRTAFECTACIONESINVENTARIO ON docDocument.ModuleID = zRTAFECTACIONESINVENTARIO.ModuleID) LEFT JOIN orgProductKardex ON (docDocumentItem.DocumentID = orgProductKardex.DocumentID) AND (docDocumentItem.DocumentItemID = orgProductKardex.DocumentItemID)) INNER JOIN orgProduct ON docDocumentItem.ProductID = orgProduct.ProductID
WHERE (((zRTAFECTACIONESINVENTARIO.Value)='3') AND ((docDocument.CancelledOn) Is Null) AND ((docDocumentItem.DeletedOn) Is Null) AND ((docDocument.DeletedOn) Is Null) AND ((orgProductKardex.StockTransactionID) Is Null)) AND (dbo.orgProduct.ProductTypeID <> 4)
AND docDocumentItem.ProductID=@1

--kardex-3
INSERT INTO orgProductKardex ( DateTransaction, DepotID, AmountPrice, ProductID, DocumentID, DocumentItemID, Quantity, QuantityToBeDelivered, QuantityImport )
SELECT docDocument.DateDocument, docDocument.DepotID, docDocumentItem.UnitPrice, docDocumentItem.ProductID, docDocumentItem.DocumentID, docDocumentItem.DocumentItemID, -docDocumentItem.Quantity AS Quantity, docDocumentItem.Quantity AS QuantityToBeDelivered, -docDocumentItem.Quantity AS QuantityImport
FROM (((docDocument INNER JOIN docDocumentItem ON docDocument.DocumentID = docDocumentItem.DocumentID) INNER JOIN zRTAFECTACIONESINVENTARIO ON docDocument.ModuleID = zRTAFECTACIONESINVENTARIO.ModuleID) LEFT JOIN orgProductKardex ON (docDocumentItem.DocumentID = orgProductKardex.DocumentID) AND (docDocumentItem.DocumentItemID = orgProductKardex.DocumentItemID)) INNER JOIN orgProduct ON docDocumentItem.ProductID = orgProduct.ProductID
WHERE (((zRTAFECTACIONESINVENTARIO.Value)='-3') AND ((docDocument.CancelledOn) Is Null) AND ((docDocument.DeletedOn) Is Null) AND ((orgProductKardex.StockTransactionID) Is Null) AND ((docDocumentItem.DeletedOn) Is Null)) AND (dbo.orgProduct.ProductTypeID <> 4)
AND docDocumentItem.ProductID=@1





END
GO
