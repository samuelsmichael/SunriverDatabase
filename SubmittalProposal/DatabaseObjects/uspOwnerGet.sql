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
	exec uspOwnerGet @CustId='065177'
*/
-- =============================================
alter PROCEDURE uspOwnerGet (
	@CustId nvarchar(10)
)
AS
BEGIN
	SET NOCOUNT ON;
	select a.CustName,a.Addr1, a.City, a.Region, a.PostalCode, a.Phone, a.CustID, a.GuestPass1Nbr, a.GuestPass2Nbr from tblArCust a where a.CustID=@CustId
end
GO
