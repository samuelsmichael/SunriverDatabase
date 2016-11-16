SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/15/2016
-- Description:	Updates OnwerConcern's DateFormPrinted
/*
	exec uspOwnerConcernsDateFormPrintedUpdate
*/
-- =============================================
create PROCEDURE uspOwnerConcernsDateFormPrintedUpdate 
	@OCCase# int
AS
BEGIN
	SET NOCOUNT ON;
		update tblOCData
		set
			DateFormPrinted=getdate()
		where [OCCase#]=@OCCase#
END
GO
