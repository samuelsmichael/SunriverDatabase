USE [BallotVerify]
GO

/****** Object:  View [dbo].[qrytblBallotVerify_MakeNew]    Script Date: 8/3/2019 5:27:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[qrytblBallotVerify_MakeNew]
AS
SELECT DISTINCT m.GroupCode, m.[Member Code2] as CustId, m.[PropID] AS PropID, m.AddressLine1 as Addr1, m.Voted, m.PostalCode, m.FamiliarName AS OwnerName, null as Contact, m.AddressLine1 AS CustAddr1, m.AddressLine2 AS CustAddr2
FROM            [ID-Card_Split_FE].dbo.sunowa_Club_Member_qryMember AS m
WHERE        (m.GroupCode BETWEEN '1' AND '9') AND (m.PropID > '0')

GO


