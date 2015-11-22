SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/11/2015
-- Description:	Deletes Parts
/*
	exec uspLRFDPartsDelete
*/
-- =============================================
create PROCEDURE uspLRFDPartsDelete 
	@VWOPartID int
AS
BEGIN
	delete from tblVWOParts where VWOPartID=@VWOPartID
END
GO
