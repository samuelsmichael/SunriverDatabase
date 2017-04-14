SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 5/20/2016
-- Description:	Violator History
/*
	exec [uspCitationGet] @CitationID=
	select * from tblcitations
*/
-- =============================================
USE SRCitations;
go
alter PROCEDURE [uspCitationGet] 
	@CitationID int = null,
	@Citation# nvarchar(20) = null
AS
BEGIN
select * from tblCitations c
left outer join tblViolations v on c.CitationId=v.fkCitationID
inner join [tblRuleType{LU}] r on r.RuleID=v.fkRuleID
where
	(@CitationID is null or CitationID=@CitationID) and
	(@Citation# is null or Citation#=@Citation#)


END
GO
