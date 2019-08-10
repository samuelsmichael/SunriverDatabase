USE RVStorage
go
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
	SELECT r.*,
			c.[Member Code] as CustId,
			c.GroupCode,
			c.FamiliarName as CustName,
			c.AddressLine1 as Addr1,
			c.AddressLine2 as Addr2,
			c.City,
			c.[State] as Region,
			c.PhoneNumber as Phone,
			c.FacsimileNumber as Fax,
			c.AddressLine5 as Attn,
			c.EmailAddress as Email 
 
	FROM tblRVData r LEFT OUTER JOIN
		[ID-Card_Split_FE]..Member c ON r.CustomerID = c.[Member Code]
	order by RVLeaseID
	SELECT * FROM vFindRent v order by tSISpace
	SELECT * FROM [tblSpaceRent{LU}]
	exec uspAvailableSpaces
END
GO
