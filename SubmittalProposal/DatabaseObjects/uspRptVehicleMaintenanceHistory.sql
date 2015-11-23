SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/20/2015
-- Description:	Get Data for Report: Vehicle Maintenance History 
/*
	EXEC uspRptVehicleMaintenanceHistory @Number='1002', @FromDate='1/1/2014', @ToDate='12/31/2015'
*/
-- =============================================
alter PROCEDURE uspRptVehicleMaintenanceHistory 
	@Number nvarchar(12),
	@FromDate datetime,
	@ToDate datetime,
	@VehicleName nvarchar(40)=null
AS
BEGIN
	SET NOCOUNT ON;
	set @ToDate=dateadd(ss,60,@Todate)
	print cast(@todate as varchar)
	SELECT q.*
	FROM qry_VehicleMaintenanceHistory q
	WHERE q.fkNumber=@Number AND q.[Date Out] Between @FromDate And @ToDate
	ORDER BY q.fkNumber;
END
GO
