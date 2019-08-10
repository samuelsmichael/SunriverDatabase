SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 10/20/2015
-- Description:	Get Client Info  
-- =============================================
ALTER PROCEDURE [dbo].[uspRVOwnersPropertyGet] {
	@ClientID nvarchar(1)
AS
BEGIN	
	SET NOCOUNT ON;
	SELECT q.SRPropID,q.LotLane,q.SRAddress,q.SRLot,q.SRLane,q.CustId as OwnerID,q.PrimaryOwner,
			c.* 
	FROM [ID-Card_Split_FE].[dbo].[qryLotLaneWithOwners_Master] q LEFT OUTER JOIN
		[ID-Card_Split_FE]..tblArCust c ON c.CustId = q.CustId
END
GO
