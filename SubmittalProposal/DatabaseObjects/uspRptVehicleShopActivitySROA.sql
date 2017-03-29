USE [SROAVehicleMaintenance]
GO
/****** Object:  StoredProcedure [dbo].[uspRptVehicleShopActivitySROA]    Script Date: 11/27/2016 3:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/24/2016
-- Description:	Get Data for Report: Vehicle Shop Activity SROA 
/*
	EXEC uspRptVehicleShopActivitySROA @FromDate='1/1/2014', @ToDate='12/31/2016'
*/
-- =============================================
ALTER PROCEDURE [dbo].[uspRptVehicleShopActivitySROA] 
	@FromDate datetime,
	@ToDate datetime
AS
BEGIN
set @ToDate=DateAdd(ss,60,@ToDate)
SELECT v.*, @FromDate as FromDate, @ToDate as ToDate
FROM qry_VehicleMaintenanceHistorySROA v
WHERE v.[Date Out] Between @FromDate And @ToDate
ORDER BY v.fkNumber;
END

