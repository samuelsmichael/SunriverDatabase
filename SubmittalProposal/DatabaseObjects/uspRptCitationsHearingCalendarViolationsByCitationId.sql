SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 4/23/2016
-- Description:	Gets Data Set that drives Citations Hearing Calendar sub-report
/*
	Exec uspRptCitationsHearingCalendarViolationsByCitationId 31501
*/
-- =============================================
alter PROCEDURE uspRptCitationsHearingCalendarViolationsByCitationId 
	@CitationId int
AS
BEGIN	
	SET NOCOUNT ON;
	SELECT 
		v.ViolationID, v.fkCitationID, v.fkRuleID, r.RuleDescription, v.ScheduleFine, v.ViolationNotes, v.IssueAsWarning
	FROM 
		[tblRuleType{LU}] r INNER JOIN tblViolations v ON r.RuleID = v.fkRuleID
	WHERE 
		v.IssueAsWarning=0 and fkCitationID=@CitationId
END
GO
