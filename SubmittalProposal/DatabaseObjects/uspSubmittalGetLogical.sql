SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 3/11/2015
-- Description:	Access Logical Submittals (includes SubmittalId)
/*
	exec uspSubmittalsGetLogical
*/
-- =============================================
use srpropertysql
go
ALTER PROCEDURE uspSubmittalsGetLogical 

AS
BEGIN
	SET NOCOUNT ON;
	select s.*, b.BPermitID, b.BPermit# from tblSubmittal s left outer join tblBPData b on s.SubmittalId=b.fkSubmittalID_PD 
END
GO
