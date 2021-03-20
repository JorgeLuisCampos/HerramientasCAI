USE [cspCursoPolizas]
GO

/****** Object:  StoredProcedure [dbo].[zRTPOLIZASPORFECHA]    Script Date: 20/03/2021 02:15:43 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- JAIME RODRIGUEZ POLIZA DE INGRESOS POR FECHA 15/03/2021


CREATE PROCEDURE [dbo].[zRTPOLIZASPORFECHA] 
@1 BIGINT, @2 INT, @3 INT, @4 DATETIME2(0), @5 VARCHAR(15), @6 INT
-- @1 Id Seleccionado, @2 ID Usuario, @3 ID Empresa Propietaria, @4 Fecha de la poliza, @5 Divisa, @6 CurrencyID
AS
BEGIN
    DECLARE @UNP BIGINT, @PID BIGINT, @REF NVARCHAR(15)
    -- @UNP Ultimo Numero de Póliza, @FECHP, @REF AñoPeriodoTipoPolizaDivisa  AAAA0P0TD
    SELECT @UNP=UltNoPol FROM zRTULTNUMPOL WHERE Tipo=3 AND Ejercicio=YEAR(@4) AND Periodo=MONTH(@4)
    SET @UNP=ISNULL(@UNP,0)+1
    SET @REF= dbo.fnObtenerReference (@4, 3, @6)
    SELECT @PID=polizaID FROM accpoliza WHERE Reference=@REF
    -- Inserta encabezado de Poliza
    IF NOT EXISTS (SELECT * FROM accPoliza WHERE Reference=@REF AND DeletedOn IS NULL) BEGIN
        INSERT INTO accPoliza (Reference, Tipo, Num, Fecha, Concepto, OwnedBusinessEntityID, EntityName, Ejercicio, Periodo, CreatedOn, CreatedBy, CurrencyID, Rate, PolizaManual, PolizaDefinitionID)
        VALUES(@REF, 3, @UNP, @4, 'Ingresos del día '+LTRIM(FORMAT(@4,'dd/MM/yyyy'))+' '+@5, @3, 'INGRESOS VARIOS CLIENTES', YEAR(@4),MONTH(@4), GETDATE(), @2, @6, 1, 1,31)
        SET @PID=SCOPE_IDENTITY()
    END

    -- Inserta la cuenta de Clientes por facturar
    INSERT INTO accPolizaTransaccion (PolizaID, NumCta, NombreCta, Concepto, Debe, Moneda, TipCamb, NumCtaAlias, AccountingCatalogID)
    SELECT       @PID, dbo.zRTPOLIZACLIENTES.FullAccountNumber, dbo.zRTPOLIZACLIENTES.AccountName, dbo.zRTPOLIZACLIENTES.BusinessEntityName, dbo.zRTPOLIZACLIENTES.Total, @5, dbo.zRTPOLIZACLIENTES.Rate, 
                            dbo.zRTPOLIZACLIENTES.AliasAccountNumber, dbo.zRTPOLIZACLIENTES.AccountingCatalogID
        FROM     dbo.zRTPOLIZACLIENTES LEFT OUTER JOIN
                            dbo.zRTPOLIZASDETALLEVIVAS ON dbo.zRTPOLIZACLIENTES.Reference = dbo.zRTPOLIZASDETALLEVIVAS.Reference AND 
                            dbo.zRTPOLIZACLIENTES.BusinessEntityName = dbo.zRTPOLIZASDETALLEVIVAS.Concepto AND dbo.zRTPOLIZACLIENTES.Total = dbo.zRTPOLIZASDETALLEVIVAS.Debe
        WHERE    (dbo.zRTPOLIZASDETALLEVIVAS.PolizaTransaccionID IS NULL) AND (dbo.zRTPOLIZASDETALLEVIVAS.PolizaTransaccionID IS NULL) AND (dbo.zRTPOLIZACLIENTES.Reference = @REF)
    -- Inserta documentos relacionados
    INSERT INTO accPolizaTransaccionComprobante (PolizaTransaccionID,DocumentID)
    SELECT        dbo.zRTPOLIZASDETALLEVIVAS.PolizaTransaccionID, dbo.zRTPOLIZACLIENTESDOCUMENTOS.DocumentID
        FROM      dbo.zRTPOLIZACLIENTESDOCUMENTOS INNER JOIN
                            dbo.zRTPOLIZASDETALLEVIVAS ON dbo.zRTPOLIZACLIENTESDOCUMENTOS.Reference = dbo.zRTPOLIZASDETALLEVIVAS.Reference AND 
                            dbo.zRTPOLIZACLIENTESDOCUMENTOS.BusinessEntityName = dbo.zRTPOLIZASDETALLEVIVAS.Concepto LEFT OUTER JOIN
                            dbo.zRTPOLIZASDETALLEVIVASPTC ON dbo.zRTPOLIZASDETALLEVIVAS.Reference = dbo.zRTPOLIZASDETALLEVIVASPTC.Reference AND 
                            dbo.zRTPOLIZASDETALLEVIVAS.PolizaTransaccionID = dbo.zRTPOLIZASDETALLEVIVASPTC.PolizaTransaccionID
        WHERE     (dbo.zRTPOLIZASDETALLEVIVASPTC.DocumentID IS NULL)


END
GO