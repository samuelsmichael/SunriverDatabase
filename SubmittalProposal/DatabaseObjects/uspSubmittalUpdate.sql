SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 3/30/2015
-- Description:	Updates Submittal
/*
	exec uspSubmittalUpdate
*/
-- =============================================
ALTER PROCEDURE uspSubmittalUpdate 
	@SubmittalId int,
	@Own_Name varchar(40)
AS
BEGIN
	SET NOCOUNT ON;
	update tblSubmittal
	set
		Own_Name=isnull(@Own_Name,Own_Name)
	where SubmittalId=@SubmittalId 
END
GO
