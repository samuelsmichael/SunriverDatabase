SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 3/11/2015
-- Description:	Gets the tables of LRFDVehicleMaintenance
-- =============================================
create PROCEDURE uspLRFDVehicleMaintenanceTablesGet 
AS
BEGIN
	SET NOCOUNT ON;
	Select * from tblVWOData;
	select * from tblVWOLabor;
	select * from tblVWOParts;
	select * from tblVWOServices
END
GO
