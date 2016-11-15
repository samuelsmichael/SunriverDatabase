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
	select oc.*,ll.SRLotLane, ar.Addr1 as MailAddr1, ar.Addr2 as MailAddr2, ar.city as MailCity, ar.Region as MailState, ar.PostalCode as MailZip, ar.Phone as CustPhone
	FROM 
		tblOCData oc Left Outer JOIN
		 [ID-Card_Split_FE]..tblArCust ar on oc.OwnerID#=ar.CustId outer apply  
		(select top 1 Custid, Region from [ID-Card_Split_FE]..tblArShipTo st where st.Custid=oc.OwnerID#) st outer apply
		(select top 1 SRLotLane from [ID-Card_Split_FE]..tblLotLane_Master ll where st.Region=ll.SRPropID ) ll
	ORDER BY OCCase#
	Select * FROM [tblCategory{LU}]
	select * from [tblDepartment{LU}]
END
GO
