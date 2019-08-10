SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 10/20/2015
-- Description:	Main table access for RV Storage Page  
-- =============================================
ALTER PROCEDURE uspRVStorageTablesGet 
AS
BEGIN
	SET NOCOUNT ON;
	SELECT r.*,c.* FROM tblRVData r LEFT OUTER JOIN
		[ID-Card_Split_FE]..tblArCust c ON r.CustomerID = c.CustId
	order by RVLeaseID
	SELECT * FROM vFindRent v order by tSISpace
	SELECT * FROM [tblSpaceRent{LU}]
	exec uspAvailableSpaces
END
GO
