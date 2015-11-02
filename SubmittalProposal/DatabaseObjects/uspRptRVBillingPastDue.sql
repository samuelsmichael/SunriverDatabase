SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/2/2015
-- Description: Get RV Billing Past Due or RenewNow
-- =============================================
/*
	exec uspRptRVBillingPastDueAndRenewNow 12, 0

	select cast('12/1/2015' as datetime)
*/
alter PROCEDURE uspRptRVBillingPastDueAndRenewNow
	@Month int,
	@IsPastDueReport bit
AS
BEGIN
	SET NOCOUNT ON;
	if @IsPastDueReport=1 begin
		SELECT c.CustomerID, c.RVLeaseID, c.LeaseCancelled, c.LastName, c.FirstName, c.tRVDSpace, r.AnnualRent, c.LeasePaid, Month([LeaseStartDate]) AS LeaseMonth, c.LeaseStartDate, c.Notes,
			cast(cast(@Month as varchar) + '/1/' + cast(DatePart(yy,getdate()) as varchar) as DateTime) as CutoffDate
		FROM tblRVData c INNER JOIN vFindRent r ON c.tRVDSpace=r.tSISpace 
		where
			(((c.LeaseCancelled)=0) And ((c.FirstName)<>'Public Works') And ((c.LeasePaid)=0) And ((Month([LeaseStartDate]))<@Month))
		ORDER BY c.CustomerID;
	end else begin
		SELECT r.CustomerID, r.LeaseCancelled, r.LastName, r.FirstName, r.tRVDSpace, fr.AnnualRent, r.LeasePaid, r.LeaseStartDate, r.Notes, r.RVLeaseID,
			cast(cast(@Month as varchar) + '/1/' + cast(DatePart(yy,getdate()) as varchar) as DateTime) as CutoffDate
		FROM tblRVData r LEFT JOIN vFindRent fr ON r.tRVDSpace=fr.tSISpace
		WHERE (((r.LeaseCancelled)=0) And ((r.FirstName)<>'Public Works') And ((Month([LeaseStartDate]))=@Month))
		ORDER BY r.CustomerID;
	end

END
GO
