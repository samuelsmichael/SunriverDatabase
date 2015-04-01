SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 3/11/2015
-- Description:	Gets Data Set that drives GridView
/*
	Exec uspFindHighestSubmittalId
*/
-- =============================================
alter PROCEDURE uspFindHighestSubmittalId 
AS
BEGIN	
	SET NOCOUNT ON;
	select Max(SubmittalId) as SubmittalId from tblSubmittal
END
GO
