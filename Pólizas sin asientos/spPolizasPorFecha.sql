USE [cspCursoPolizas]
GO

/****** Object:  StoredProcedure [dbo].[zRTPOLIZASPORFECHA]    Script Date: 15/03/2021 05:29:29 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- JAIME RODRIGUEZ POLIZA DE INGRESOS POR FECHA 15/03/2021


CREATE PROCEDURE [dbo].[zRTPOLIZASPORFECHA] 
@1 BIGINT, @2 INT, @3 INT, @4 DATETIME2(0), @5 VARCHAR(10), @6 INT
-- @1 Id Seleccionado, @2 ID Usuario, @3 ID Empresa Propietaria, @4 Fecha de la poliza
AS
BEGIN
DECLARE @UNP BIGINT, @PID BIGINT, @REF NVARCHAR(10)
-- @UNP Ultimo Numero de Póliza, @FECHP, @REF AñoPeriodoTipoPolizaDivisa  AAAA0P0TD
SELECT @UNP=UltNoPol FROM zRTULTNUMPOL WHERE Tipo=3 AND Ejercicio=YEAR(@4) AND Periodo=MONTH(@4)
SET @UNP=ISNULL(@UNP,0)+1
SET @REF= LTRIM(FORMAT(@4,'yyyy'))+LTRIM(FORMAT(@4,'MM'))+'03'+CONVERT(NVARCHAR(1),@6)
-- Inserta encabezado de Poliza
IF NOT EXISTS (SELECT * FROM accPoliza WHERE Reference=@REF AND DeletedOn IS NULL) BEGIN
INSERT INTO accPoliza (Reference, Tipo, Num, Fecha, Concepto, OwnedBusinessEntityID, EntityName, Ejercicio, Periodo, CreatedOn, CreatedBy, CurrencyID, Rate, PolizaManual, PolizaDefinitionID)
VALUES(@REF, 3, @UNP, @4, 'Ingresos del día '+LTRIM(FORMAT(@4,'dd/MM/yyyy')), @3, 'INGRESOS VARIOS CLIENTES', YEAR(@4),MONTH(@4), GETDATE(), @2, @6, 1, 1,31)
SET @PID=SCOPE_IDENTITY()
END


END
GO