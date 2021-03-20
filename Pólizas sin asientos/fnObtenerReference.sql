-- ================================================
-- Template generated from Template Explorer using:
-- Create Scalar Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jorge Luis Campos Medina
-- Create date: 20/03/2021
-- Description:	Crea una referencia usando 8 dígitos para la fecha, 2 dígitos para el tipo de póliza y 1 dígito para la divisa
-- =============================================
Create FUNCTION dbo.fnObtenerReference
(
	-- Add the parameters for the function here
	@pFecha Datetime2(0), 
	@pTipoPoliza int, 
	@pDivisa int
)
RETURNS nvarchar (15)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Reference nvarchar(15)

	-- Add the T-SQL statements to compute the return value here
	SET @Reference = LTRIM(FORMAT(@pFecha,'yyyyMMdd'))+dbo.FORMAT_RIGHT_LEADING_ZERO(@pTipoPoliza, '00')+CONVERT(NVARCHAR(1),@pDivisa)

	-- Return the result of the function
	RETURN @Reference

END
GO