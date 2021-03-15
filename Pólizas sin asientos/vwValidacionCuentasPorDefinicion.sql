USE [cspCursoPolizas]
GO

/****** Object:  View [dbo].[zRTVALIDACIONCUENTASPORDEFINICION]    Script Date: 15/03/2021 05:23:26 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[zRTVALIDACIONCUENTASPORDEFINICION]
AS
SELECT        dbo.accPolizaDefinition.NombrePoliza, dbo.accPolizaDefinitionItem.Concepto, dbo.accPolizaDefinitionItem.NombrePartida, dbo.accPolizaDefinitionItem.Cuenta, dbo.engrefAccountingCatalog.AccountName, 
                         dbo.vwcboAccountingTipoPoliza.Value AS [Tipo Póliza], dbo.accPolizaDefinition.PolizaDefinitionID, CASE WHEN LEN(ISNULL(Cuenta, '')) < 8 THEN 1268 ELSE CASE WHEN LEN(Cuenta) = 13 AND 
                         AccountName IS NOT NULL THEN 1268 ELSE 1 END END AS Validar, dbo.accPolizaDefinitionItem.PolizaDefinitionItemID, dbo._AIModulosPorDefinicionContable.ModuleName AS Módulo
FROM            dbo.accPolizaDefinitionItem INNER JOIN
                         dbo.accPolizaDefinition ON dbo.accPolizaDefinitionItem.PolizaDefinitionID = dbo.accPolizaDefinition.PolizaDefinitionID INNER JOIN
                         dbo.vwcboAccountingTipoPoliza ON dbo.accPolizaDefinition.TipoPolizaID = dbo.vwcboAccountingTipoPoliza.ID LEFT OUTER JOIN
                         dbo._AIModulosPorDefinicionContable ON dbo.accPolizaDefinition.PolizaDefinitionID = dbo._AIModulosPorDefinicionContable.PolizaDefinitionID LEFT OUTER JOIN
                         dbo.engrefAccountingCatalog ON SUBSTRING(dbo.accPolizaDefinitionItem.Cuenta, 2, 11) = dbo.engrefAccountingCatalog.AliasAccountNumber
WHERE        (dbo.accPolizaDefinition.DeletedOn IS NULL)
GO