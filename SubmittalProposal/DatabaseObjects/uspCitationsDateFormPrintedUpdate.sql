SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 9/06/2015
-- Description:	Updates Citations's DateFormPrinted
/*
	exec uspCitationsDateFormPrintedUpdate
*/
-- =============================================
create PROCEDURE uspCitationsDateFormPrintedUpdate 
	@CitationID int
AS
BEGIN
	SET NOCOUNT ON;
		update tblCitations
		set
			DateFormPrinted=getdate()
		where CitationID=@CitationID
END
GO
