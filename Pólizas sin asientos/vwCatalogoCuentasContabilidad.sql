USE [cspCursoPolizas]
GO

/****** Object:  View [dbo].[zRTCATALOGOCUENTASCONTABILIDAD]    Script Date: 15/03/2021 05:14:37 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[zRTCATALOGOCUENTASCONTABILIDAD]
AS
SELECT        Id, RowVersion, Codigo, Nombre, NomIdioma, Tipo, EsBaja, CtaMayor, CtaEfectivo, FechaRegistro, SistOrigen, IdMoneda, DigAgrup, IdSegNeg, SegNegMovtos, Afectable, TimeStamp, IdRubro, Consume, 
                         IdAgrupadorSAT, ConceptosConsume, SUBSTRING(Codigo, 1, 3) + '-' + SUBSTRING(Codigo, 4, 2) + '-' + SUBSTRING(Codigo, 6, 3) AS AliasAccountNumber
FROM            ctCURSOPOLIZAS.dbo.Cuentas    -- ctCursoPolizas es una DB de CONTPAQi Contabilidad
WHERE        (Id > 10)
GO