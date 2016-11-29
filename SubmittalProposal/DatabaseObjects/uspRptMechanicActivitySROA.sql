USE [SROAVehicleMaintenance]
GO
/****** Object:  StoredProcedure [dbo].[uspRptMechanicActivitySROA]    Script Date: 11/27/2016 3:51:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/20/2015
-- Description:	Get Data for Report: Mechanic Activity 
/*
	EXEC uspRptMechanicActivitySROA @FromDate='1/1/2014', @ToDate='12/31/2016'
*/
-- =============================================
ALTER PROCEDURE [dbo].[uspRptMechanicActivitySROA] 
	@FromDate datetime,
	@ToDate datetime
AS
BEGIN
set @ToDate=DateAdd(ss,60,@ToDate)
SELECT v.*,l.*,vl.[Description] as VehicleName
FROM qry_VehicleMaintenanceHistorySROA v inner join tblVWOLabor l on l.fkVWOL_ID=VWOID
	inner join [tblVehicleList{LU}] vl on vl.Number = v.fkNumber
WHERE v.[Date Out] Between @FromDate And @ToDate
ORDER BY l.MechName,v.fkNumber;
END

