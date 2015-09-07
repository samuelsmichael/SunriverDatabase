SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 9/06/2015
-- Description:	Updates tblRequest
/*
	exec uspSellCheckRequestUpdate
*/
-- =============================================
alter PROCEDURE uspSellCheckRequestUpdate 
	@scRequestID int=null,
	@scLot nvarchar(10),
	@scLane nvarchar(28),
	@fkscPropID nvarchar(20),
	@scRealtor nvarchar(30),
	@scLTDate datetime=null,
	@scLTRecipient nvarchar(35),
	@scLTMailAddr1 nvarchar(30),
	@scLTMailAddr2 nvarchar(30),
	@scLTCity nvarchar(30),
	@scLTState nvarchar(3),
	@scLTZip nvarchar(10),
	@scLTCCopy1 nvarchar(40),
	@scLTCCopy2 nvarchar(40),
	@scLTCCopy3 nvarchar(40),
	@NewscRequestID int out
AS
BEGIN
	SET NOCOUNT ON;
	if @scRequestID is not null begin
		set @NewscRequestID=@scRequestID
		update tblRequest
		set
			scRealtor=@scRealtor,
			scLTDate=@scLTDate,
			scLTRecipient=@scLTRecipient,
			scLTMailAddr1=@scLTMailAddr1,
			scLTMailAddr2=@scLTMailAddr2,
			scLTCity=@scLTCity,
			scLTState=@scLTState,
			scLTZip=@scLTZip,
			scLTCCopy1=@scLTCCopy1,
			scLTCCopy2=@scLTCCopy2,
			scLTCCopy3=@scLTCCopy3
		where scRequestID=@scRequestID 
	end else begin
		INSERT INTO [dbo].tblRequest
           (			
		    scRealtor,
			scLTDate,
			scLTRecipient,
			scLTMailAddr1,
			scLTMailAddr2,
			scLTCity,
			scLTState,
			scLTZip,
			scLTCCopy1,
			scLTCCopy2,
			scLTCCopy3,
			scLot,
			scLane,
			fkscPropID
		)
		VALUES
           (
			@scRealtor,
			@scLTDate,
			@scLTRecipient,
			@scLTMailAddr1,
			@scLTMailAddr2,
			@scLTCity,
			@scLTState,
			@scLTZip,
			@scLTCCopy1,
			@scLTCCopy2,
			@scLTCCopy3,
			@scLot,
			@scLane,
			@fkscPropID
		   )
		set @NewscRequestID=scope_identity()
	end
END
GO
