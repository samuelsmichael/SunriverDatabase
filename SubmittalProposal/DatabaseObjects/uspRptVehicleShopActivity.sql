SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/20/2015
-- Description:	Get Data for Report: Vehicle Shop Activity 
/*
	EXEC uspRptVehicleShopActivity @FromDate='1/1/2014', @ToDate='12/31/2015'
*/
-- =============================================
alter PROCEDURE uspRptVehicleShopActivity 
	@FromDate datetime,
	@ToDate datetime
AS
BEGIN
set @ToDate=DateAdd(ss,60,@ToDate)
SELECT v.*
FROM qry_VehicleMaintenanceHistory v
WHERE v.[Date Out] Between @FromDate And @ToDate
ORDER BY v.[Date Out]
END
GO
