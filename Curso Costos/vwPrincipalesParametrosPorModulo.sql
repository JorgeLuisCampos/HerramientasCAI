USE [cspCursoCostos]
GO

/****** Object:  View [dbo].[zRTPRINCPALESPARAMETROSPORMODULO]    Script Date: 15/03/2021 04:54:41 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[zRTPrincipalesParametrosporModulo]
AS
SELECT        dbo.vwLBSDocumentMainParameters.ModuleID, dbo.vwLBSDocumentMainParameters.DocumentTypeID, dbo.vwLBSDocumentMainParameters.CustomerDoc, dbo.vwLBSDocumentMainParameters.SupplierDoc, 
                         dbo.vwLBSDocumentMainParameters.DocRecipient, dbo.vwLBSDocumentMainParameters.FinancialAffectation, dbo.vwLBSDocumentMainParameters.StockAffectation, 
                         dbo.vwLBSDocumentMainParameters.CostAffectation, dbo.vwLBSDocumentMainParameters.CostAffectationComercial, dbo.vwLBSDocumentMainParameters.PrimaryKey, 
                         dbo.vwLBSDocumentMainParameters.AlwaysDeliver, dbo.vwLBSDocumentMainParameters.Payment, dbo.vwLBSDocumentMainParameters.CashFlowCoef, dbo.vwLBSDocumentMainParameters.CreditLimitCoef, 
                         dbo.vwLBSDocumentMainParameters.ShowAuthorization, dbo.vwLBSDocumentMainParameters.GroupDocument, dbo.vwLBSDocumentMainParameters.AccountingPolizaFinancial, 
                         dbo.engModule.ModuleName
FROM            dbo.vwLBSDocumentMainParameters INNER JOIN
                         dbo.engModule ON dbo.vwLBSDocumentMainParameters.ModuleID = dbo.engModule.ModuleID
GO