USE [SROAVehicleMaintenance]
GO
/****** Object:  StoredProcedure [dbo].[uspSROAVehicleMaintenanceTablesGet]    Script Date: 11/27/2016 3:47:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/24/2016
-- Description:	Gets the tables of SROAVehicleMaintenance
-- =============================================
create PROCEDURE [dbo].[uspSROAVehicleMaintenanceTablesGet] 
AS
BEGIN
	SET NOCOUNT ON;
	Select * from tblVWOData;
	select * from tblVWOLabor;
	select * from tblVWOParts;
	select * from tblVWOServices
	select * from [tblDepartment{LU}]
	select * from [tblMechanicInfo{LU}]
	select * from [tblVehicleList{LU}]
END

