USE [ID-Card_Split_FE]
GO

/****** Object:  View [dbo].[qryLotLaneWithOwners_Master]    Script Date: 3/16/2016 7:21:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[qryLotLaneWithOwners_Master]
AS
SELECT        dbo.tblLotLane_Master.SRPropID, ISNULL(dbo.tblLotLane_Master.SRLot, N'') + ' ' + ISNULL(dbo.tblLotLane_Master.SRLane, N'') + ' ' + ISNULL(dbo.tblLotLane_Master.SRSuffix, N'') AS LotLane, 
                         dbo.tblLotLane_Master.SRAddress, dbo.tblLotLane_Master.SRLot, dbo.tblLotLane_Master.SRLane, dbo.tblLotLane_Master.SRLegalDescription, dbo.qryLotToOwnersLink.LegalPropertyName, 
                         dbo.qryLotToOwnersLink.LastSaleDate, dbo.tblArCust.CustId, dbo.tblArCust.CustName AS PrimaryOwner, dbo.tblArCust.CustName, dbo.tblArCust.Addr1, dbo.tblArCust.Addr2, dbo.tblArCust.City, dbo.tblArCust.Region, 
                         dbo.tblArCust.PostalCode, dbo.tblArCust.Country, dbo.tblArCust.Phone, dbo.tblLotLane_Master.SRSuffix, dbo.tblLotLane_Master.SRSubDivCode, dbo.tblLotLane_Master.DC_TaxLotID, dbo.tblLotLane_Master.DC_Address, 
                         dbo.tblLotLane_Master.DC_HouseNo, dbo.tblLotLane_Master.DC_Street, dbo.tblLotLane_Master.DC_StreetNoSuffix, dbo.tblLotLane_Master.DC_Lot, dbo.tblLotLane_Master.[DC_Cons/W], dbo.tblLotLane_Master.DC_SubDiv, 
                         dbo.tblLotLane_Master.DC_SubDivCode, dbo.tblArCust.Contact, dbo.tblArCust.Email, dbo.tblArCust.Internet, dbo.tblArCust.Fax,
						 cast(case when isnumeric(SRLot)=1 then RIGHT('00000'+ISNULL(SRLot,''),5) else '99999'+isnull(srLot,'') end as varchar(30))  as SRLotSortable
FROM            dbo.tblLotLane_Master INNER JOIN
                         dbo.qryLotToOwnersLink ON dbo.tblLotLane_Master.SRPropID = dbo.qryLotToOwnersLink.fkSRPropID INNER JOIN
                         dbo.tblArCust ON dbo.qryLotToOwnersLink.CustId = dbo.tblArCust.CustId

GO


