SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/20/2015
-- Description:	Get Data for Report: Lapine RFD Vehicles 
/*
	EXEC uspRptLapineRFDVehicles 
*/
-- =============================================
create PROCEDURE uspRptLapineRFDVehicles

AS
BEGIN
SELECT v.Number, v.fkDeptID, v.Department, v.[Description], v.UnitID, v.Engine, v.Decommissioned
FROM [tblVehicleList{LU}] v

END
GO
