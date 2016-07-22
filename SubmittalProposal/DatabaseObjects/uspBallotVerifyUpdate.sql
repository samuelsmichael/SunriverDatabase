SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 7/07/2015
-- Description:	Updates Ballot Verify Voted
-- =============================================
alter PROCEDURE uspBallotVerifyUpdate 
	@BallotVerifyId int,
	@Voted bit
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE tblBallotVerify
	SET Voted=case when @Voted = 1 THEN 'X' ELSE NULL END
	WHERE BallotVerifyId=@BallotVerifyId
END
GO
