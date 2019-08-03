USE [RVStorage]
GO

/****** Object:  View [dbo].[vOwnerPlusProperty]    Script Date: 8/3/2019 4:38:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[vOwnerPlusProperty]
AS
SELECT DISTINCT 
                         m.[Member Code] as CustId, m.FamilarName as CustName, null as Contact, m.AddressLine1 as Addr1, m.AddressLine2 as Addr2, m.City, m.[State] as Region, null as Country, m.PostalCode, 
						 null as IntlPrefix, m.PhoneNumber as Phone, m.FacsimileNumber as Fax, m.EmailAddress as Email, null as Internet, m.[Member Code] AS Expr1, 
                         ma.SRAddress, m.PropID AS Expr2, m.City AS Expr3
FROM            [ID-Card_Split_FE].dbo.Member AS m  LEFT OUTER JOIN
                         [ID-Card_Split_FE].dbo.tblLotLane_Master AS ma ON m.PropID = ma.SRPropID

GO


