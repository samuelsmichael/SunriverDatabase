SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 4/05/2015
-- Description:	Updates Submittal
/*
	exec uspComplianceLetterUpdate
*/
-- =============================================
alter PROCEDURE uspComplianceLetterUpdate 
	@crLTID int = null,
	@fkcrReviewID int,
	@crLTDate datetime=null,
	@crLTActionDate datetime=null,
	@crLTRecipient nvarchar(30),
	@crLTMailAddr nvarchar(30),
	@crLTMailAddr2 nvarchar(30),
	@crLTCityStateZip nvarchar(40),
	@crLTAttachType nvarchar(15),
	@crLTAttachDescription nvarchar(30),
	@crLTCCopy1 nvarchar(30),
	@crLTCCopy2 nvarchar(30),
	@crLTCCopy3 nvarchar(30),
	@crLTSigner nvarchar(20),
	@crLTSignerTitle nvarchar(35),
	@crLTIDOut int out
AS
BEGIN
	SET NOCOUNT ON;
	if(@crLTID is not null) begin
		set @crLTIDOut=@crLTID
		UPDATE [dbo].[tblComplianceLetterData]
		   SET [fkcrReviewID] = @fkcrReviewID
			  ,[crLTDate] = @crLTDate
			  ,[crLTActionDate] =@crLTActionDate
			  ,[crLTRecipient] = @crLTRecipient
			  ,[crLTMailAddr] = @crLTMailAddr
			  ,[crLTMailAddr2] = @crLTMailAddr2
			  ,[crLTCity+State+Zip] = @crLTCityStateZip
			  ,[crLTAttachType] = @crLTAttachType
			  ,[crLTAttachDescription] = @crLTAttachDescription
			  ,[crLTCCopy1] = @crLTCCopy1
			  ,[crLTCCopy2] = @crLTCCopy2
			  ,[crLTCCopy3] = @crLTCCopy3
			  ,[crLTSigner] = @crLTSigner
			  ,[crLTSignerTitle] = @crLTSignerTitle
		 WHERE crLTID=@crLTID
	end else begin
		INSERT INTO [dbo].[tblComplianceLetterData]
				   ([fkcrReviewID]
				   ,[crLTDate]
				   ,[crLTActionDate]
				   ,[crLTRecipient]
				   ,[crLTMailAddr]
				   ,[crLTMailAddr2]
				   ,[crLTCity+State+Zip]
				   ,[crLTAttachType]
				   ,[crLTAttachDescription]
				   ,[crLTCCopy1]
				   ,[crLTCCopy2]
				   ,[crLTCCopy3]
				   ,[crLTSigner]
				   ,[crLTSignerTitle])
			 VALUES
				   (@fkcrReviewID
				   ,@crLTDate
				   ,@crLTActionDate
				   ,@crLTRecipient
				   ,@crLTMailAddr
				   , @crLTMailAddr2
				   ,@crLTCityStateZip
				   ,@crLTAttachType
				   ,@crLTAttachDescription
				   ,@crLTCCopy1
				   ,@crLTCCopy2
				   ,@crLTCCopy3
				   ,@crLTSigner
				   ,@crLTSignerTitle)
		set @crLTIDOut=scope_identity()
	end
END
GO
