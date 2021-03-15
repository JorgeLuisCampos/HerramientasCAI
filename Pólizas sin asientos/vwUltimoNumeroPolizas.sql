USE [cspCursoPolizas]
GO

/****** Object:  View [dbo].[zRTULTNUMPOL]    Script Date: 15/03/2021 05:22:27 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[zRTULTNUMPOL]
AS
SELECT        MAX(ISNULL(Num, 0)) AS UltNoPol, Tipo, Ejercicio, Periodo
FROM            dbo.accPoliza
WHERE        (DeletedOn IS NULL)
GROUP BY Ejercicio, Periodo, Tipo
GO