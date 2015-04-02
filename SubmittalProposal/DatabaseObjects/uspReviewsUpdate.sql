SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 4/01/2015
-- Description:	Updates Payments
/*
	exec uspReviewsUpdate
*/
-- =============================================
create PROCEDURE uspReviewsUpdate 
	@BPReviewID int = null,
	@BPermitId int = null,
	@BPReviewDate DateTime=null,
	@BPRActionDate DateTime=null,
	@BPRLetterDate DateTime=null,
	@BPRLetterRef nvarchar(25),
	@BPRComments nvarchar(max),
	@NewBPReviewID int out
AS
BEGIN
	declare @newRevNbr int
	SET NOCOUNT ON;
	if(@BPReviewID is not null) begin
		set @NewBPReviewID=@BPReviewID
		update tblBPReviews
		set
			BPReviewDate=@BPReviewDate,
			BPRActionDate=@BPRActionDate,
			BPRLetterDate=@BPRLetterDate,
			BPRLetterRef=@BPRLetterRef,
			BPRComments=@BPRComments
		where BPReviewID=@BPReviewID 
	end else begin
		set @newRevNbr=((select count(*) from tblBPReviews where fkBPermitID_PR=@BPermitId)+1)

		INSERT INTO [dbo].[tblBPReviews]
           (
			[fkBPermitID_PR]
           ,[BPReviewDate]
           ,[BPRActionDate]
           ,[BPRLetterDate]
           ,[BPRLetterRef]
           ,[BPRComments]
           ,[BPRevw]
		   )
		VALUES (
			@BPermitId,@BPReviewDate,@BPRActionDate,@BPRLetterDate,@BPRLetterRef,@BPRComments,@newRevNbr
		   )

		set @NewBPReviewID=scope_identity()
	end
END
GO
