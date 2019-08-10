USE [BallotVerify]
GO

/****** Object:  View [dbo].[qrytblBallotVerify_MakeNew]    Script Date: 8/3/2019 5:27:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[qrytblBallotVerify_MakeNew]
AS
SELECT DISTINCT c.GroupCode, s.CustId, s.Region AS PropID, s.Addr1, s.Internet AS Voted, c.PostalCode, c.CustName AS OwnerName, c.Contact, c.Addr1 AS CustAddr1, c.Addr2 AS CustAddr2
FROM            [ID-Card_Split_FE].dbo.tblArCust AS c RIGHT OUTER JOIN
                         [ID-Card_Split_FE].dbo.tblArShipTo AS s ON c.CustId = s.CustId
WHERE        (c.GroupCode BETWEEN '1' AND '9') AND (s.Region > '0')

GO


