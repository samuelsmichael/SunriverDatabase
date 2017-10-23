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
create PROCEDURE uspOwnerPut (
	@CustId nvarchar(10),
	@GuestPass1Nbr nvarchar(30),
	@GuestPass2Nbr nvarchar(30)
)
AS
BEGIN
	SET NOCOUNT ON;
	Update tblArCust
	Set 
		GuestPass1Nbr = @GuestPass1Nbr,
		GuestPass2Nbr = @GuestPass2Nbr
	where
		CustID=@CustId
end
GO
