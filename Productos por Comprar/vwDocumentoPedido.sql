Create VIEW vwDocumentoPedido AS
SELECT d.DocumentID, d.Title Titulo, 
        i.DocumentItemID, i.Quantity Cantidad, i.ProductKey Producto, i. UnitPrice [Precio Unitario]
FROM docDocument d
    Inner Join docDocumentItem i
    ON d.DocumentID = i.DocumentID
GO  