SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 9/06/2015
-- Description:	Updates Request's DateFormPrinted
/*
	exec uspSellCheckRequestDateFormPrintedUpdate
*/
-- =============================================
alter PROCEDURE uspSellCheckRequestDateFormPrintedUpdate 
	@scRequestID int
AS
BEGIN
	SET NOCOUNT ON;
		update tblRequest
		set
			DateFormPrinted=getdate()
		where scRequestID=@scRequestID
END
GO
