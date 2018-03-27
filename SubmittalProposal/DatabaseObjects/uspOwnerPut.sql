USE [ID-Card_Split_FE]
GO
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 10/23/2017
-- Description:	Updates tblArCust information
/*
	exec uspOwnerPut @CustId='065177'
*/
-- =============================================
alter PROCEDURE uspOwnerPut (
	@CustId nvarchar(10),
	@GuestPass1Nbr nvarchar(30),
	@GuestPass2Nbr nvarchar(30)
)
AS
BEGIN
	SET NOCOUNT ON;
	if exists (select 'a' from tblArCustAddendum where CustId=@CustId) begin
		Update tblArCustAddendum
		Set 
			GuestPass1Nbr = @GuestPass1Nbr,
			GuestPass2Nbr = @GuestPass2Nbr
		where
			CustID=@CustId
	end else begin
		Insert into tblArCustAddendum (CustId, GuestPass1Nbr, GuestPass2Nbr)
		values (@CustId, @GuestPass1Nbr, @GuestPass2Nbr)
	end
end
GO
