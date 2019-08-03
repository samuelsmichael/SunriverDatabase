USE [ID-Card_Split_FE]
GO

/*
	select top 10 * from qryLotToOwnersLink
*/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER VIEW [dbo].[qryLotToOwnersLink]
AS
SELECT        [Member Code] as CustId, PropID AS fkSRPropID, DeschLegalDesc AS LegalPropertyName, AddressLine5 AS SRLotLane, JoinDate AS LastSaleDate
FROM            dbo.Member


GO


