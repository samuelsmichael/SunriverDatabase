use RVStorage
go
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 10/20/2015
-- Description:	Get Client Info  
-- =============================================
ALTER PROCEDURE [dbo].[uspRVOwnersPropertyGet] 
	@ClientID nvarchar(10)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT q.SRPropID,q.LotLane,q.SRAddress,q.SRLot,q.SRLane,q.CustId as OwnerID,q.PrimaryOwner,
			c.[Member Code2] as CustId,
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
	FROM [ID-Card_Split_FE].[dbo].[qryLotLaneWithOwners_Master] q LEFT OUTER JOIN
		[ID-Card_Split_FE]..sunowa_Club_Member_qryMember c ON c.[Member Code2] = q.CustId
	WHERE @ClientID=c.[Member Code2]
	END
GO
