SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/2/2015
-- Description: Get RV Billing Info
-- =============================================
/*
	exec uspRptRVBillingInfo

	select cast('12/1/2015' as datetime)
*/
create PROCEDURE uspRptRVBillingInfo
AS
BEGIN
	SET NOCOUNT ON;
SELECT r.RVLeaseID, r.CustomerID, [LastName] + ', ' + [FirstName] AS Name, r.LastName, r.FirstName, r.LeaseCancelled, r.tRVDSpace, r.LeasePaid, fr.AnnualRent, r.LeaseStartDate, r.LeaseCancelDate, r.Notes
FROM tblRVData  r INNER JOIN vFindRent fr ON r.tRVDSpace=fr.tSISpace
WHERE (((r.LastName)<>'Department') And ((r.FirstName)<>'Sunriver PD') And ((r.LeaseCancelled)=0))
ORDER BY r.LastName;
END
GO
