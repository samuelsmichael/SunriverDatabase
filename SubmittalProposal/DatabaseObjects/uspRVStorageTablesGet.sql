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
	SELECT * FROM tblRVData r LEFT OUTER JOIN
		[ID-Card_Split_FE]..tblArCust c ON r.CustomerID = c.CustId
	SELECT * FROM [tblSpaceInfo{LU}] order by tSISpace
	SELECT * FROM [tblSpaceRent{LU}]
END
GO
