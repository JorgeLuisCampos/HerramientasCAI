USE [cspCursoPolizas]
GO

/****** Object:  View [dbo].[zRTPOLEJEPERVIVAS]    Script Date: 15/03/2021 05:17:13 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[zRTPOLEJEPERVIVAS]
AS
SELECT        PolizaID, Ejercicio, Periodo, Tipo, Num
FROM            dbo.accPoliza
WHERE        (DeletedOn IS NULL)
GO