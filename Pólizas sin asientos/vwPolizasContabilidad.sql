USE [cspCursoPolizas]
GO

/****** Object:  View [dbo].[zRTPOLIZASCONTABILIDAD]    Script Date: 15/03/2021 05:19:11 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[zRTPOLIZASCONTABILIDAD]
AS
SELECT        ctCURSOPOLIZAS.dbo.Polizas.Ejercicio, ctCURSOPOLIZAS.dbo.Polizas.Periodo, ctCURSOPOLIZAS.dbo.Polizas.Folio, ctCURSOPOLIZAS.dbo.Polizas.Concepto, ctCURSOPOLIZAS.dbo.Polizas.Fecha, 
                         ctCURSOPOLIZAS.dbo.Polizas.Abonos, ctCURSOPOLIZAS.dbo.Polizas.Cargos, ctCURSOPOLIZAS.dbo.Cuentas.Codigo, ctCURSOPOLIZAS.dbo.Cuentas.Nombre, ctCURSOPOLIZAS.dbo.MovimientosPoliza.Importe, 
                         ctCURSOPOLIZAS.dbo.MovimientosPoliza.ImporteME, ctCURSOPOLIZAS.dbo.MovimientosPoliza.TipoMovto, ctCURSOPOLIZAS.dbo.Cuentas.IdMoneda, ctCURSOPOLIZAS.dbo.Cuentas.Afectable, 
                         ctCURSOPOLIZAS.dbo.TiposPolizas.Nombre AS TipoPol, ctCURSOPOLIZAS.dbo.Polizas.Id, SUBSTRING(ctCURSOPOLIZAS.dbo.Cuentas.Codigo, 1, 3) + '-' + SUBSTRING(ctCURSOPOLIZAS.dbo.Cuentas.Codigo, 4, 2) 
                         + '-' + SUBSTRING(ctCURSOPOLIZAS.dbo.Cuentas.Codigo, 6, 3) AS AliasAccountNumber, CASE WHEN TipoMovto = 0 THEN Importe ELSE 0 END AS Cargo, 
                         CASE WHEN TipoMovto = 1 THEN Importe ELSE 0 END AS Abono, CASE WHEN TipoMovto = 0 THEN ImporteME ELSE 0 END AS CargoME, CASE WHEN TipoMovto = 1 THEN ImporteME ELSE 0 END AS AbonoME, 
                         ISNULL(dbo.zRTPOLEJEPERVIVAS.PolizaID, 0) AS PolizaID, ctCURSOPOLIZAS.dbo.MovimientosPoliza.Id AS IDMP, CASE WHEN idMoneda <> 2 OR
                         ISNULL(ImporteME, 0) = 0 THEN 0 ELSE ABS(Importe / ImporteME) END AS TCME
FROM            ctCURSOPOLIZAS.dbo.Polizas LEFT OUTER JOIN
                         dbo.zRTPOLEJEPERVIVAS ON ctCURSOPOLIZAS.dbo.Polizas.Ejercicio = dbo.zRTPOLEJEPERVIVAS.Ejercicio AND ctCURSOPOLIZAS.dbo.Polizas.Periodo = dbo.zRTPOLEJEPERVIVAS.Periodo AND 
                         ctCURSOPOLIZAS.dbo.Polizas.TipoPol = dbo.zRTPOLEJEPERVIVAS.Tipo AND ctCURSOPOLIZAS.dbo.Polizas.Folio = dbo.zRTPOLEJEPERVIVAS.Num LEFT OUTER JOIN
                         ctCURSOPOLIZAS.dbo.MovimientosPoliza ON ctCURSOPOLIZAS.dbo.Polizas.Id = ctCURSOPOLIZAS.dbo.MovimientosPoliza.IdPoliza LEFT OUTER JOIN
                         ctCURSOPOLIZAS.dbo.TiposPolizas ON ctCURSOPOLIZAS.dbo.Polizas.TipoPol = ctCURSOPOLIZAS.dbo.TiposPolizas.Codigo LEFT OUTER JOIN
                         ctCURSOPOLIZAS.dbo.Cuentas ON ctCURSOPOLIZAS.dbo.MovimientosPoliza.IdCuenta = ctCURSOPOLIZAS.dbo.Cuentas.Id
GO                       -- ctCursoPolizas es una BD de CONTPAQi Contabilidad