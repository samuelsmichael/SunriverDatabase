SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 5/20/2016
-- Description:	Violator History
/*
	exec [uspCitationGet] @LastName='smith'
*/
-- =============================================
USE SRCitations;
go
create PROCEDURE [uspCitationGet] 
	@CitationID int = null,
	@Citation# nvarchar(20) = null
AS
BEGIN
select * from tblCitations
where
	(@CitationID is null or CitationID=@CitationID) and
	(@Citation# is null or Citation#=@Citation#)


END
GO
