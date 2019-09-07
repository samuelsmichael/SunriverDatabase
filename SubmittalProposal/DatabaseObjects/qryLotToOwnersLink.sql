USE [ID-Card_Split_FE]
GO

/****** Object:  View [dbo].[qryLotToOwnersLink]    Script Date: 9/7/2019 3:23:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER VIEW [dbo].[qryLotToOwnersLink]
AS
SELECT        [Member Code2] as CustId, PropID AS fkSRPropID, DeschLegalDesc AS LegalPropertyName, AddressLine5 AS SRLotLane, JoinDate AS LastSaleDate
FROM            dbo.sunowa_Club_Member_qryMember



GO


