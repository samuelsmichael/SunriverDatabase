USE [RVStorage]
GO

/****** Object:  View [dbo].[vOwnerPlusProperty]    Script Date: 8/3/2019 4:34:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[vOwnerPlusProperty]
AS
SELECT DISTINCT 
                         c.CustId, c.CustName, c.Contact, c.Addr1, c.Addr2, c.City, c.Region, c.Country, c.PostalCode, c.IntlPrefix, c.Phone, c.Fax, c.Email, c.Internet, s.CustId AS Expr1, 
                         m.SRAddress, s.Region AS Expr2, s.City AS Expr3
FROM            [ID-Card_Split_FE].dbo.tblArCust AS c INNER JOIN
                         [ID-Card_Split_FE].dbo.tblArShipTo AS s ON c.CustId = s.CustId LEFT OUTER JOIN
                         [ID-Card_Split_FE].dbo.tblLotLane_Master AS m ON s.Region = m.SRPropID

GO


