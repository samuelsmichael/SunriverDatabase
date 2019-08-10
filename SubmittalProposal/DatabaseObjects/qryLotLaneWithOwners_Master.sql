USE [ID-Card_Split_FE]
GO
/*
	select * from [qryLotLaneWithOwners_Master] where CustId='007773'
*/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[qryLotLaneWithOwners_Master]
AS
SELECT        dbo.tblLotLane_Master.SRPropID, ISNULL(dbo.tblLotLane_Master.SRLot, N'') + ' ' + ISNULL(dbo.tblLotLane_Master.SRLane, N'') + ' ' + ISNULL(dbo.tblLotLane_Master.SRSuffix, N'') AS LotLane, 
                         dbo.tblLotLane_Master.SRAddress, dbo.tblLotLane_Master.SRLot, dbo.tblLotLane_Master.SRLane, dbo.tblLotLane_Master.SRLegalDescription, dbo.qryLotToOwnersLink.LegalPropertyName, 
                         dbo.qryLotToOwnersLink.LastSaleDate, 
							 dbo.Member.[Member Code] as CustId, 
							 dbo.Member.FamilarName AS PrimaryOwner, 
							 dbo.Member.FamilarName as CustName, 
							 dbo.Member.AddressLine1 as Addr1, 
							 dbo.Member.AddressLine2 as Addr2, 
							 dbo.Member.City, 
							 dbo.Member.[State] as Region, 
							 dbo.Member.PostalCode, 
														 null as Country, 
							 dbo.Member.PhoneNumber as Phone, 
						 dbo.tblLotLane_Master.SRSuffix, dbo.tblLotLane_Master.SRSubDivCode, dbo.tblLotLane_Master.DC_TaxLotID, dbo.tblLotLane_Master.DC_Address, 
                         dbo.tblLotLane_Master.DC_HouseNo, dbo.tblLotLane_Master.DC_Street, dbo.tblLotLane_Master.DC_StreetNoSuffix, dbo.tblLotLane_Master.DC_Lot, dbo.tblLotLane_Master.[DC_Cons/W], dbo.tblLotLane_Master.DC_SubDiv, 
                         dbo.tblLotLane_Master.DC_SubDivCode, 
							 null as Contact, 
							 dbo.Member.EmailAddress as Email, 
							 null as Internet, 
							 dbo.Member.FacsimileNumber as Fax,
						 cast(case when isnumeric(SRLot)=1 then RIGHT('00000'+ISNULL(SRLot,''),5) else '99999'+isnull(srLot,'') end as varchar(30))  as SRLotSortable
FROM            dbo.tblLotLane_Master INNER JOIN
                         dbo.qryLotToOwnersLink ON dbo.tblLotLane_Master.SRPropID = dbo.qryLotToOwnersLink.fkSRPropID INNER JOIN
                         dbo.Member ON dbo.qryLotToOwnersLink.CustId = dbo.Member.[Member Code]

GO


