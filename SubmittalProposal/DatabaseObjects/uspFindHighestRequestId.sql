SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 3/11/2015
-- Description:	Gets Data Set that drives GridView
/*
	Exec uspFindHighestRequestId
*/
-- =============================================
alter PROCEDURE uspFindHighestRequestId 
AS
BEGIN	
	SET NOCOUNT ON;
	select Max(scRequestID) as RequestID from tblRequest
END
GO
