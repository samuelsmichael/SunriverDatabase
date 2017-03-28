SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/20/2015
-- Description:	Get Data for Report: Lapine RFD Invoices 
/*
	EXEC uspRptLRFDInvoices @StartDate='1/1/2014', @EndDate='12/31/2015'
*/
-- =============================================
use lrfdvehiclemaintenance;
go
alter PROCEDURE uspRptLRFDInvoices
	@StartDate datetime,
	@EndDate datetime

AS
BEGIN
set @Enddate=dateadd(ss,55,@EndDate)
SELECT v.*, @StartDate as StartDate, @EndDate as EndDate
FROM qry_VehicleMaintenanceHistory v
WHERE v.[Date Out] Between @StartDate And @Enddate
ORDER BY v.fkNumber;

END
GO
