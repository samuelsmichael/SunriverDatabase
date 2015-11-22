SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/11/2015
-- Description:	Deletes Labor
/*
	exec uspLRFDLaborDelete
*/
-- =============================================
create PROCEDURE uspLRFDLaborDelete 
	@VWOLaborID int
AS
BEGIN
	delete from tblVWOLabor where VWOLaborID=@VWOLaborID
END
GO
