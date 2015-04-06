SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 4/05/2015
-- Description:	Updates Submittal
/*
	exec uspComplianceReviewUpdate
*/
-- =============================================
alter PROCEDURE uspComplianceReviewUpdate 
	@crReviewID int = null,
	@crDate datetime=null,
	@crLot nvarchar(10),
	@crLane nvarchar(30),
	@crComments nvarchar(max),
	@crRule nvarchar(max),
	@crCorrection nvarchar(max),
	@crFollowUp nvarchar(max),
	@crCloseDate datetime=null,
--	@crSubmittalId int,
	@crReviewIDOut int out
AS
BEGIN
	SET NOCOUNT ON;
	if(@crReviewId is not null) begin
		set @crReviewIDOut=@crReviewID
		UPDATE [dbo].[tblComplianceReview]
		   SET [crDate] = @crDate
			  ,[crLOT] = @crLot
			  ,[crLANE] = @crLane
			  ,[crComments] = @crComments
			  ,[crRule] = @crRule
			  ,[crCorrection] = @crCorrection
			  ,[crFollowUp] = @crFollowUp
			  ,[crCloseDate] = @crCloseDate
--			  ,[crSubmittalID] = @crSubmittalId
		 WHERE crReviewID=@crReviewID
	end else begin
		INSERT INTO [dbo].[tblComplianceReview]
				   ([crDate]
				   ,[crLOT]
				   ,[crLANE]
				   ,[crComments]
				   ,[crRule]
				   ,[crCorrection]
				   ,[crFollowUp]
				   ,[crCloseDate]
--				   ,[crSubmittalID]
				)
			 VALUES
				   (@crDate
				   ,@crLot
				   ,@crLane
				   ,@crComments
				   ,@crRule
				   ,@crCorrection
				   ,@crFollowUp
				   ,@crCloseDate
	--			   ,@crSubmittalId
			)
		set @crReviewIDOut=scope_identity()
	end
END
GO
