USE [SROAVehicleMaintenance]
GO
/****** Object:  StoredProcedure [dbo].[uspRptSROAVehicles]    Script Date: 11/27/2016 3:49:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/24/2016
-- Description:	Get Data for Report: Lapine RFD Vehicles 
/*
	EXEC uspRptSROAVehicles 
*/
-- =============================================
create PROCEDURE [dbo].[uspRptSROAVehicles]

AS
BEGIN
SELECT v.Number, v.fkDeptID, v.Department, v.[Description], v.UnitID, v.Engine, v.Decommissioned
FROM [tblVehicleList{LU}] v

END

