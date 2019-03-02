Use SRPropertySQL
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 01/25/2019
-- Description:	Gets the data associated with a PropID
/*
	exec uspPropertyInfoGet  @PropID='28226'
*/
-- =============================================

Alter Procedure uspPropertyInfoGet 
	@PropID nvarchar(10)
AS BEGIN
	SELECT 
	/******************* Property Info *******************/
		SRPropID as PropID,
		SRLot as Lot,
		SRLane as Lane,
		idc.SRAddress,
		SRLegalDescription as LegalDescription,
		LastSaleDate,
		CustId,
		PrimaryOwner,
		CustName,
		Addr1 as CustAddr1,
		Addr2 as CustAddr2,
		City as CustCity,
		Region as CustStateOrProvince,
		PostalCode as CustPostalCode,
		Country as CustCountry,
		Phone as CustPhone,
		Email as CustEmail,
		DC_TaxLotID,
		DC_Address,
	/******************* Submittal Info *******************/
		s.SubmittalID as Submittal_SubmittalID,
		s.Applicant as Submittal_Applicant,
		s.Mtg_Date as Submittal_Metting_Date,
		s.App_Exp_dt as Submittal_Application_Ext_Date,
		s.ProjectType as Submittal_ProjectType,
		s.Submittal as Submittal_Submittal,
		s.Project as Submittal_Project,
		s.ProjectDecision as Submittal_ProjectDecision,
		s.Conditions as Submittal_Conditions,
		s.Contractor as Submittal_Contractor,
		s.ProjectFee as Submittal_ProjectFee,
		s.FeeDate as Submittal_FeeDate,
	/******************* BPermit Info *******************/
		b.BPermitID as BPermit_BPermitID,
		b.BPermit# as BPermit_BPermit#,
		b.BPermitReqd as BPermit_BPermitReqd,
		b.BPIssueDate as BPermit_BPIssueDate,
		b.BPClosed as BPermit_BPClosed,
		b.BPDelay as BPermit_BPDelay,
		b.BPExpires as BPermit_Expires,
		b.BPStatus as BPermit_BPStatus,
	/******************* IDCard Info *******************/
		p.CardID as CardID_CardID,
		c.cdFirstName as CardID_First_Name,
		c.cdLastName as CardID_LastName,
		c.cdClass as CardID_Class,
		c.cdStatus as CardID_Status,
		c.cdIssueDate as CardID_IssueDate,
	/****************** Citations *********************/
		ci.CitationID as Citations_CitationID,
		ci.VFirstName as Citations_FirstName,
		ci.VLastName as Citations_LastName,
		ci.OffenseDate as Citations_OffenseDate,
		ci.OffenseLocation as Citations_OffectLocation,
		ci.FineStatus as Citations_FineStatus,
	/****************** OwnerConcerns ****************/
		oc.OCCase# as OwnerConcers_Case#,
		oc.SubmitDate as OwnerConcerns_SubmitDate,
		oc.OwnerID# as OwnerConcerns_OwnerID#,
		oc.OwnerPhone# as OwnerConcerns_OwnerPhone#,
		oc.FirstName as OwnerConcerns_FirstName,
		oc.LastName as OwnerConcerns_LastName,
		oc.DeptReferred1 as OwnerConcerns_DeptReferred1,
		oc.DeptReferred2 as OwnerConcerns_DeptReferred2,
		oc.Category as OwnerConcerns_Category,
		oc.[Description] as OwnerConcerns_Description,
		oc.Resolution as OwnerConcerns_Resolution,
		oc.ResolutionDate as OwnerConcerns_ResolutionDate,
		oc.StartFormBy as OwnerConcerns_StartFormBy,
		oc.CloseFormBy as OwnerConcerns_CloseFormBy,
		oc.ApprovedBy as OwnerConcerns_ApprovedBy,
		oc.NotifyDate as OwnerConcerns_NotifyDate

	FROM
		[ID-Card_Split_FE].[dbo].[qryLotLaneWithOwners_Master] idc	LEFT OUTER JOIN
		tblSubmittal s ON idc.SRLot=s.Lot and idc.SRLane=s.Lane LEFT OUTER JOIN
		tblBPData b ON b.fkSubmittalID_PD = s.SubmittalID LEFT OUTER JOIN
		[ID-Card_Split_FE].[dbo].[luPropertyByCardholderName] p ON p.fkISPropID=@PropID inner join 
		[ID-Card_Split_FE].[dbo].[tblInput-IDCard] c on c.CardID=p.CardID LEFT OUTER JOIN
		SRCitations..tblCitations ci ON  ci.OffenseLocation like '%'+srlot+'%'
			and ci.OffenseLocation LIKE '%'+srLane+'%' LEFT OUTER JOIN
		OwnerConcerns..tblOCData oc ON idc.CustId = oc.[OwnerID#]
		
	Where 
		SRPropID=@PropID

END
GO
