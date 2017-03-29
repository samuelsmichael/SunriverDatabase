USE [SROAVehicleMaintenance]
GO
/****** Object:  StoredProcedure [dbo].[uspRptSROAInvoices]    Script Date: 11/27/2016 3:49:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/24/2016
-- Description:	Get Data for Report: SROA Vehicle Invoices 
/*
	EXEC uspRptSROAInvoices @StartDate='1/1/2014', @EndDate='12/31/2015'
*/
-- =============================================
use SROaVehicleMaintenance;
go
alter PROCEDURE [dbo].[uspRptSROAInvoices]
	@StartDate datetime,
	@EndDate datetime

AS
BEGIN
set @Enddate=dateadd(ss,55,@EndDate)
SELECT v.*, @StartDate as StartDate, @EndDate as EndDate
FROM qry_VehicleMaintenanceHistorySROA v
WHERE v.[Date Out] Between @StartDate And @Enddate
ORDER BY v.fkNumber;

END

