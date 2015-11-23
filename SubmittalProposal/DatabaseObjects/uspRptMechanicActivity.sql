SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/20/2015
-- Description:	Get Data for Report: Mechanic Activity 
/*
	EXEC uspRptMechanicActivity @FromDate='1/1/2014', @ToDate='12/31/2015'
*/
-- =============================================
alter PROCEDURE uspRptMechanicActivity 
	@FromDate datetime,
	@ToDate datetime
AS
BEGIN
set @ToDate=DateAdd(ss,60,@ToDate)
SELECT v.*,l.*,vl.[Description] as VehicleName
FROM qry_VehicleMaintenanceHistory v inner join tblVWOLabor l on l.fkVWOL_ID=VWOID
	inner join [tblVehicleList{LU}] vl on vl.Number = v.fkNumber
WHERE v.[Date Out] Between @FromDate And @ToDate
ORDER BY l.MechName,v.fkNumber;
END
GO
