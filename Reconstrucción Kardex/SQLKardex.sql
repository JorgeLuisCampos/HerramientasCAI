
/****** Object:  View [dbo].[zRTAFECTACIONESINVENTARIO]    Script Date: 10/09/2019 06:23:02 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[zRTAFECTACIONESINVENTARIO]
AS
SELECT        dbo.engModuleParameter.ModuleID, dbo.engModule.ModuleName, dbo.engModuleParameter.ParameterKey, dbo.engModuleParameter.Value
FROM            dbo.engModuleParameter INNER JOIN
                         dbo.engModule ON dbo.engModuleParameter.ModuleID = dbo.engModule.ModuleID
GROUP BY dbo.engModuleParameter.ModuleID, dbo.engModule.ModuleName, dbo.engModuleParameter.ParameterKey, dbo.engModuleParameter.Value
HAVING        (dbo.engModuleParameter.ParameterKey = 'StockAffectation') AND (dbo.engModuleParameter.Value <> 0)

GO



/****** Object:  View [dbo].[ZRTKARDEXBASE]    Script Date: 10/09/2019 06:24:45 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ZRTKARDEXBASE]
AS
SELECT        dbo.zRTAFECTACIONESINVENTARIO.ModuleName, dbo.docDocument.DateDocument, dbo.docDocumentItem.Quantity, dbo.docDocumentItem.UnitPrice, dbo.docDocumentItem.CostPrice, 
                         dbo.zRTAFECTACIONESINVENTARIO.Value, dbo.orgProductKardex.DepotID, dbo.orgProductKardex.ProductID, dbo.docDocumentItem.DocumentID, dbo.docDocumentItem.DocumentItemID, 
                         dbo.orgProductKardex.Quantity AS Expr1, dbo.orgProductKardex.QuantityToBeDelivered, dbo.orgProductKardex.AmountPrice, dbo.orgProductKardex.ProductImportID, dbo.orgProductKardex.QuantityImport, 
                         dbo.docDocument.CancelledOn, dbo.docDocument.DeletedOn, dbo.orgProductKardex.DepotValueAverage, dbo.orgProductKardex.StockTransactionID
FROM            dbo.docDocument INNER JOIN
                         dbo.docDocumentItem ON dbo.docDocument.DocumentID = dbo.docDocumentItem.DocumentID INNER JOIN
                         dbo.zRTAFECTACIONESINVENTARIO ON dbo.docDocument.ModuleID = dbo.zRTAFECTACIONESINVENTARIO.ModuleID LEFT OUTER JOIN
                         dbo.orgProductKardex ON dbo.docDocumentItem.DocumentID = dbo.orgProductKardex.DocumentID AND dbo.docDocumentItem.DocumentItemID = dbo.orgProductKardex.DocumentItemID
WHERE        (dbo.docDocument.CancelledOn IS NULL) AND (dbo.docDocument.DeletedOn IS NULL) AND (dbo.orgProductKardex.StockTransactionID > 0)

GO


--kardex1
INSERT INTO orgProductKardex ( DateTransaction, DepotID, ProductID, DocumentID, DocumentItemID, Quantity, QuantityToBeDelivered, AmountPrice, QuantityImport )
SELECT docDocument.DateDocument, docDocument.DepotID, docDocumentItem.ProductID, docDocumentItem.DocumentID, docDocumentItem.DocumentItemID, docDocumentItem.Quantity AS Quantity, 0 AS QuantityToBeDelivered, docDocumentItem.UnitPrice, 0 AS QuantityImport
FROM (((docDocument INNER JOIN docDocumentItem ON docDocument.DocumentID = docDocumentItem.DocumentID) INNER JOIN zRTAFECTACIONESINVENTARIO ON docDocument.ModuleID = zRTAFECTACIONESINVENTARIO.ModuleID) LEFT JOIN orgProductKardex ON (docDocumentItem.DocumentID = orgProductKardex.DocumentID) AND (docDocumentItem.DocumentItemID = orgProductKardex.DocumentItemID)) INNER JOIN orgProduct ON docDocumentItem.ProductID = orgProduct.ProductID
WHERE (((zRTAFECTACIONESINVENTARIO.Value)='1') AND ((docDocument.CancelledOn) Is Null) AND ((docDocumentItem.DeletedOn) Is Null) AND ((docDocument.DeletedOn) Is Null) AND ((orgProductKardex.StockTransactionID) Is Null)) AND (dbo.orgProduct.ProductTypeID <> 4)



--kardex1-1
INSERT INTO orgProductKardex ( DateTransaction, DepotID, ProductID, DocumentID, DocumentItemID, Quantity, QuantityToBeDelivered, AmountPrice, QuantityImport )
SELECT docDocument.DateDocument, docDocument.DepotID, docDocumentItem.ProductID, docDocumentItem.DocumentID, docDocumentItem.DocumentItemID, -docDocumentItem.Quantity AS Quantity, 0 AS QuantityToBeDelivered, docDocumentItem.UnitPrice, 0 AS QuantityImport
FROM (((docDocument INNER JOIN docDocumentItem ON docDocument.DocumentID = docDocumentItem.DocumentID) INNER JOIN zRTAFECTACIONESINVENTARIO ON docDocument.ModuleID = zRTAFECTACIONESINVENTARIO.ModuleID) LEFT JOIN orgProductKardex ON (docDocumentItem.DocumentID = orgProductKardex.DocumentID) AND (docDocumentItem.DocumentItemID = orgProductKardex.DocumentItemID)) INNER JOIN orgProduct ON docDocumentItem.ProductID = orgProduct.ProductID
WHERE (((zRTAFECTACIONESINVENTARIO.Value)='-1') AND ((docDocument.CancelledOn) Is Null) AND ((docDocumentItem.DeletedOn) Is Null) AND ((docDocument.DeletedOn) Is Null) AND ((orgProductKardex.StockTransactionID) Is Null)) AND (dbo.orgProduct.ProductTypeID <> 4)

--kardex2
INSERT INTO orgProductKardex ( DateTransaction, DepotID, AmountPrice, ProductID, DocumentID, DocumentItemID, Quantity, QuantityToBeDelivered, QuantityImport )
SELECT docDocument.DateDocument, docDocument.DepotID, docDocumentItem.UnitPrice, docDocumentItem.ProductID, docDocumentItem.DocumentID, docDocumentItem.DocumentItemID, 0 AS Quantity, docDocumentItem.Quantity AS QuantityToBeDelivered, 0 AS QuantityImport
FROM (((docDocument INNER JOIN docDocumentItem ON docDocument.DocumentID = docDocumentItem.DocumentID) INNER JOIN zRTAFECTACIONESINVENTARIO ON docDocument.ModuleID = zRTAFECTACIONESINVENTARIO.ModuleID) LEFT JOIN orgProductKardex ON (docDocumentItem.DocumentID = orgProductKardex.DocumentID) AND (docDocumentItem.DocumentItemID = orgProductKardex.DocumentItemID)) INNER JOIN orgProduct ON docDocumentItem.ProductID = orgProduct.ProductID
WHERE (((zRTAFECTACIONESINVENTARIO.Value)='2') AND ((docDocument.CancelledOn) Is Null) AND ((docDocumentItem.DeletedOn) Is Null) AND ((docDocument.DeletedOn) Is Null) AND ((orgProductKardex.StockTransactionID) Is Null)) AND (dbo.orgProduct.ProductTypeID <> 4)


--kardex-2
INSERT INTO orgProductKardex ( DateTransaction, DepotID, AmountPrice, ProductID, DocumentID, DocumentItemID, Quantity, QuantityToBeDelivered, QuantityImport )
SELECT docDocument.DateDocument, docDocument.DepotID, docDocumentItem.UnitPrice, docDocumentItem.ProductID, docDocumentItem.DocumentID, docDocumentItem.DocumentItemID, 0 AS Quantity, -docDocumentItem.Quantity AS QuantityToBeDelivered, 0 AS QuantityImport
FROM (((docDocument INNER JOIN docDocumentItem ON docDocument.DocumentID = docDocumentItem.DocumentID) INNER JOIN zRTAFECTACIONESINVENTARIO ON docDocument.ModuleID = zRTAFECTACIONESINVENTARIO.ModuleID) LEFT JOIN orgProductKardex ON (docDocumentItem.DocumentID = orgProductKardex.DocumentID) AND (docDocumentItem.DocumentItemID = orgProductKardex.DocumentItemID)) INNER JOIN orgProduct ON docDocumentItem.ProductID = orgProduct.ProductID
WHERE (((zRTAFECTACIONESINVENTARIO.Value)='-2') AND ((docDocument.CancelledOn) Is Null) AND ((docDocumentItem.DeletedOn) Is Null) AND ((docDocument.DeletedOn) Is Null) AND ((orgProductKardex.StockTransactionID) Is Null)) AND (dbo.orgProduct.ProductTypeID <> 4)

--kardex3
INSERT INTO orgProductKardex ( DateTransaction, DepotID, AmountPrice, ProductID, DocumentID, DocumentItemID, Quantity, QuantityToBeDelivered, QuantityImport )
SELECT docDocument.DateDocument, docDocument.DepotID, docDocumentItem.UnitPrice, docDocumentItem.ProductID, docDocumentItem.DocumentID, docDocumentItem.DocumentItemID, docDocumentItem.Quantity, -docDocumentItem.Quantity AS QuantityToBeDelivered, 0 AS QuantityImport
FROM (((docDocument INNER JOIN docDocumentItem ON docDocument.DocumentID = docDocumentItem.DocumentID) INNER JOIN zRTAFECTACIONESINVENTARIO ON docDocument.ModuleID = zRTAFECTACIONESINVENTARIO.ModuleID) LEFT JOIN orgProductKardex ON (docDocumentItem.DocumentID = orgProductKardex.DocumentID) AND (docDocumentItem.DocumentItemID = orgProductKardex.DocumentItemID)) INNER JOIN orgProduct ON docDocumentItem.ProductID = orgProduct.ProductID
WHERE (((zRTAFECTACIONESINVENTARIO.Value)='3') AND ((docDocument.CancelledOn) Is Null) AND ((docDocumentItem.DeletedOn) Is Null) AND ((docDocument.DeletedOn) Is Null) AND ((orgProductKardex.StockTransactionID) Is Null)) AND (dbo.orgProduct.ProductTypeID <> 4)

--kardex-3
INSERT INTO orgProductKardex ( DateTransaction, DepotID, AmountPrice, ProductID, DocumentID, DocumentItemID, Quantity, QuantityToBeDelivered, QuantityImport )
SELECT docDocument.DateDocument, docDocument.DepotID, docDocumentItem.UnitPrice, docDocumentItem.ProductID, docDocumentItem.DocumentID, docDocumentItem.DocumentItemID, -docDocumentItem.Quantity AS Quantity, docDocumentItem.Quantity AS QuantityToBeDelivered, -docDocumentItem.Quantity AS QuantityImport
FROM (((docDocument INNER JOIN docDocumentItem ON docDocument.DocumentID = docDocumentItem.DocumentID) INNER JOIN zRTAFECTACIONESINVENTARIO ON docDocument.ModuleID = zRTAFECTACIONESINVENTARIO.ModuleID) LEFT JOIN orgProductKardex ON (docDocumentItem.DocumentID = orgProductKardex.DocumentID) AND (docDocumentItem.DocumentItemID = orgProductKardex.DocumentItemID)) INNER JOIN orgProduct ON docDocumentItem.ProductID = orgProduct.ProductID
WHERE (((zRTAFECTACIONESINVENTARIO.Value)='-3') AND ((docDocument.CancelledOn) Is Null) AND ((docDocument.DeletedOn) Is Null) AND ((orgProductKardex.StockTransactionID) Is Null) AND ((docDocumentItem.DeletedOn) Is Null)) AND (dbo.orgProduct.ProductTypeID <> 4)







