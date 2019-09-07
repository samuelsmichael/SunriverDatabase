USE [ID-Card_Split_FE]
GO
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 06/11/2015
-- Description:	Gets the data to populate the Find by Cardholder Name dropdown
/*
	exec uspOwnerGet @CustId='000939'
*/
-- =============================================
alter PROCEDURE uspOwnerGet (
	@CustId nvarchar(10)
)
AS
BEGIN
	SET NOCOUNT ON;
	select FamiliarName as CustName,AddressLine4 as Addr1, City, [State] as Region, PostalCode, PhoneNumber as Phone, [Member Code2] as CustID, ad.GuestPass1Nbr, ad.GuestPass2Nbr 
	from sunowa_Club_Member_qryMember a LEFT OUTER JOIN
		 tblArCustAddendum ad ON a.[Member Code2]=ad.CustID
	where [Member Code2]=@CustId
end
GO
