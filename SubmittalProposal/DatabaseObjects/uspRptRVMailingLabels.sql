SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 10/20/2015
-- Description: Get RV Mailing Labels
-- =============================================
alter PROCEDURE uspRptRVMailingLabels 
AS
BEGIN
	SET NOCOUNT ON;
	SELECT r.[RVLeaseID], r.[LeaseCancelled], [FirstName] + ' ' + [LastName] AS RenterName, o.Addr1 AS [LU-Addr1], o.[Addr2] AS [LU-Addr2], o.[City] AS [LU-City], o.Region AS [LU-State], o.[PostalCode] AS [LU-Zip], r.[FirstName], r.[LastName],
		isnull(o.City,'') + ' ' + isnull(o.Region,'') + ' ' + isnull(o.PostalCode,'') as CityStateZip
	FROM tblRVData r LEFT JOIN [vOwnerPlusProperty] o ON r.[CustomerID]=o.CustId
	WHERE (((r.[LeaseCancelled])=0) And ((r.[LastName])<>'Department'))
	ORDER BY r.[RVLeaseID] DESC;

END
GO
