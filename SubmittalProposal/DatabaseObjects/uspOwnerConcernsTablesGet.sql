USE OwnerConcerns

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 10/14/2016
-- Description:	Gets the tables of OwnerConcerns
-- =============================================
alter PROCEDURE uspOwnerConcernsTablesGet 
AS
BEGIN
	SET NOCOUNT ON;
	select oc.*,ll.SRLotLane, ar.AddressLine1 as MailAddr1, ar.AddressLine2 as MailAddr2, ar.city as MailCity, ar.[State] as MailState, ar.PostalCode as MailZip, ar.PhoneNumber as CustPhone
	FROM 
		tblOCData oc Left Outer JOIN
		 [ID-Card_Split_FE].sunowa_Club_Member_qryMember ar on oc.OwnerID#=ar.[Member Code2] outer apply  
		(select top 1 [Member Code2] as Custid, [State] as Region from [ID-Card_Split_FE].sunowa_Club_Member_qryMember st where st.[Member Code2]=oc.OwnerID#) st outer apply
		(select top 1 SRLotLane from [ID-Card_Split_FE]..tblLotLane_Master ll where st.Region=ll.SRPropID ) ll
	ORDER BY OCCase#
	Select * FROM [tblCategory{LU}]
	select * from [tblDepartment{LU}] where IsInOwnerConcernList=1
END
GO
