SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 10/20/2015
-- Description: Get RV Billing Past Due
-- =============================================
/*
	exec uspRptRVBillingPastDue 12

	select cast('12/1/2015' as datetime)
*/
alter PROCEDURE uspRptRVBillingPastDue
	@Month int
AS
BEGIN
	SET NOCOUNT ON;
SELECT c.CustomerID, c.RVLeaseID, c.LeaseCancelled, c.LastName, c.FirstName, c.tRVDSpace, r.AnnualRent, c.LeasePaid, Month([LeaseStartDate]) AS LeaseMonth, c.LeaseStartDate, c.Notes,
cast(cast(@Month as varchar) + '/1/' + cast(DatePart(yy,getdate()) as varchar) as DateTime) as CutoffDate
FROM tblRVData c INNER JOIN vFindRent r ON c.tRVDSpace=r.tSISpace 
WHERE (((c.LeaseCancelled)=0) And ((c.FirstName)<>'Public Works') And ((c.LeasePaid)=0) And ((Month([LeaseStartDate]))<@Month))
ORDER BY c.CustomerID;
END
GO
