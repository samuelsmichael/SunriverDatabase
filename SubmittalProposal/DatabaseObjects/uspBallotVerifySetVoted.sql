SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 7/07/2015
-- Description:	Get a Ballot Verify
-- exec uspBallotVerifySetVoted '26005'

-- =============================================
create PROCEDURE uspBallotVerifySetVoted 
	@PropertyId nvarchar(10)
AS
BEGIN
	SET NOCOUNT ON;
	update tblBallotVerify set Voted='X' where PropID=@PropertyId
END
GO
