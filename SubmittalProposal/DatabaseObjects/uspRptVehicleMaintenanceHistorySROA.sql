USE [SROAVehicleMaintenance]
GO
/****** Object:  StoredProcedure [dbo].[uspRptVehicleMaintenanceHistorySROA]    Script Date: 11/27/2016 3:53:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/24/2016
-- Description:	Get Data for Report: Vehicle Maintenance History 
/*
	EXEC uspRptVehicleMaintenanceHistorySROA @Number='1000', @FromDate='1/1/2014', @ToDate='12/31/2016'
*/
-- =============================================
use sroavehiclemaintenance
go
alter PROCEDURE [dbo].[uspRptVehicleMaintenanceHistorySROA] 
	@Number nvarchar(12),	
	@FromDate datetime,
	@ToDate datetime,
	@VehicleName nvarchar(40)=null
AS
BEGIN
	SET NOCOUNT ON;
	set @ToDate=dateadd(ss,60,@Todate)
	print cast(@todate as varchar)
	SELECT q.*,@Number as Number, @FromDate as FromDate, @ToDate as ToDate, @VehicleName as VehicleName
	FROM qry_VehicleMaintenanceHistorySROA q
	WHERE q.fkNumber=@Number AND q.[Date Out] Between @FromDate And @ToDate
	ORDER BY q.fkNumber;
END

