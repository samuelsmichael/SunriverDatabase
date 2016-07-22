SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 7/07/2015
-- Description:	Get a Ballot Verify
-- exec uspBallotVerifyGet '26005'

-- =============================================
alter PROCEDURE uspBallotVerifyGet 
	@PropertyId nvarchar(10)
AS
BEGIN
	SET NOCOUNT ON;
	select * FROM tblBallotVerify where PropID=@PropertyId
END
GO
