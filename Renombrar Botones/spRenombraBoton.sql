SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jorge Luis Campos Medina
-- Create date: 01/04/2021
-- Description:	Renombra, cambia el icono y la función que ejecuta un botón
-- =============================================
CREATE PROCEDURE _VTI_spRenombraBoton 
	-- Add the parameters for the stored procedure here
	@pControlID int, 
    @pNombre nvarchar(50),
    @pDescripcion nvarchar(255),
    @pEjecutar nvarchar(50),
    @pIcono nvarchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Update engRibbonControl
		SET		ControlCaption = @pNombre,
                ControlDescription = @pDescripcion,
                ControlExecute =  @pEjecutar,
                IconFile = @pIcono
        WHERE ControlId = @pControlID
END
GO

Prueba