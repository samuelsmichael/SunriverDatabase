SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 4/15/2015
-- Description:	Returns crOpenClosed
-- =============================================
alter FUNCTION udfComputeCrOpenClosed 
(
	-- Add the parameters for the function here
	@CrReviewID int
)
RETURNS varchar(6)
AS
BEGIN
	DECLARE @Result varchar(6)

	SELECT @Result = CASE WHEN IsDate([crCloseDate])=1 THEN 'CLOSED' ELSE 'OPEN' END
	FROM tblComplianceReview WHERE crReviewID=@CrReviewID

	RETURN @Result

END
GO

