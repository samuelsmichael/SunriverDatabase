SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 9/06/2015
-- Description:	Updates SellCheck.tblSellCheck

--	uspSellCheckRequestUpdate
-- =============================================
create PROCEDURE uspSellCheckInspectionUpdate 
	@scInspectionID int=null,
	@fkscRequestID int,
	@scDate DateTime=null,
	@scFee money,
	@scPaid bit,
	@scPaidMemo nvarchar(10),
	@scDateClosed Datetime=null,
	@scLadderFuel nvarchar(30),
	@scNoxWeeds nvarchar(30),
	@scComments nvarchar(max),
	@scFollowUp nvarchar(max),
	@NewID int out
AS
BEGIN	
	SET NOCOUNT ON;
	if @scInspectionID is not null begin
		set @NewID=@scInspectionID
		update tblSellCheck
		set
			scDate=@scDate,
			scFee=@scFee,
			scPaid=@scPaid,
			scPaidMemo=@scPaidMemo,
			scDateClosed=@scDateClosed,
			scLadderFuel=@scLadderFuel,
			scNoxWeeds=@scNoxWeeds,
			scComments=@scComments,
			scFollowUp=@scFollowUp
			
		where scInspectionID=@scInspectionID 
	end else begin
		INSERT INTO [dbo].tblSellCheck
           (	
			fkscRequestID,		
			scDate,
			scFee,
			scPaid,
			scPaidMemo,
			scDateClosed,
			scLadderFuel,
			scNoxWeeds,
			scComments,
			scFollowUp
		)
		VALUES
           (
			@fkscRequestID,		
			@scDate,
			@scFee,
			@scPaid,
			@scPaidMemo,
			@scDateClosed,
			@scLadderFuel,
			@scNoxWeeds,
			@scComments,
			@scFollowUp
		   )
		set @NewID=scope_identity()
	end
END
GO
