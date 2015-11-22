SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/11/2015
-- Description:	Deletes Service
/*
	exec uspLRFDServiceDelete
*/
-- =============================================
alter PROCEDURE uspLRFDServiceDelete 
	@VWOServiceID int
AS
BEGIN
	delete from tblVWOServices where VWOCtrServID=@VWOServiceID
END
GO
