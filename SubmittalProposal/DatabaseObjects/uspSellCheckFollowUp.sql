-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 01/15/2019
-- Description:	Updates/Creates a Followup
/*
	DECLARE @NewSellCheckFollowUpId int
	exec uspSellCheckFollowUpUpdate 
		@SellCheckFollowUp=
		,@fkscRequestID=
		,@Description='Hello world'
		,@NewSellCheckFollowUpId = @NewSellCheckFollowUpId OUT
*/
-- =============================================
use SRSellCheck
go
create PROCEDURE uspSellCheckFollowUpUpdate (
	@SellCheckFollowUpId int = null,
	@fkscRequestID int=null,
	@Description nvarchar(max) = null,
	@NewSellCheckFollowUpId int out
)
AS
BEGIN
	SET NOCOUNT ON;
	if @SellCheckFollowUpId is not null begin
		if @Description is null begin
			DELETE FROM tblSellCheckFollowUp WHERE SellCheckFollowUpId=@SellCheckFollowUpId
		end else begin
		set @NewSellCheckFollowUpId=@SellCheckFollowUpId
		UPDATE [dbo].[tblSellCheckFollowUp]
		   SET [Description] = @Description
		   WHERE SellCheckFollowUpId=@SellCheckFollowUpId
		END
	end else 
	begin
		INSERT INTO [dbo].[tblSellCheckFollowUp]
				   ([fk_scInspectionID]
				   ,[Description]
				   ,[DateRecordCreated]
				   )
			 VALUES
				   (@SellCheckFollowUpId
				   ,@Description
				   ,getdate()
				   )
		set @NewSellCheckFollowUpId=scope_identity()
	end
end
GO
