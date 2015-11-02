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
	exec uspRptRVBillingRenewNow 12

	select cast('12/1/2015' as datetime)
*/
alter PROCEDURE uspRptRVBillingRenewNow
	@Month int
AS
BEGIN
	SET NOCOUNT ON;
SELECT r.CustomerID, r.LeaseCancelled, r.LastName, r.FirstName, r.tRVDSpace, fr.AnnualRent, r.LeasePaid, r.LeaseStartDate, r.Notes, r.RVLeaseID,
cast(cast(@Month as varchar) + '/1/' + cast(DatePart(yy,getdate()) as varchar) as DateTime) as CutoffDate
FROM tblRVData r LEFT JOIN vFindRent fr ON r.tRVDSpace=fr.tSISpace
WHERE (((r.LeaseCancelled)=0) And ((r.FirstName)<>'Public Works') And ((Month([LeaseStartDate]))=@Month))
ORDER BY r.CustomerID;
END
GO
