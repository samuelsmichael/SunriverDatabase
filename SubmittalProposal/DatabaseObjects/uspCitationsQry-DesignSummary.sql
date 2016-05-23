SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 5/20/2016
-- Description:	Citations Open
/*
	exec [uspCitationsQry-DesignSummary] @StartDate='1/1/2014', @EndDate='6/1/2016'
*/
-- =============================================
alter PROCEDURE [uspCitationsQry-DesignSummary] 
	@StartDate datetime,
	@EndDate datetime
AS
BEGIN

SELECT 
	c.CitationID, v.fkRuleID, v.IssueAsWarning, v.ScheduleFine, v.ViolationNotes, r.RuleDescription, c.OffenseDate, c.FineStatus, c.VLastName, c.VFirstName, 
	c.OffenseLocation, c.HearingDate, c.MagistrateFine, c.AssessedFine, c.JudicialFine, c.WriteOff, c.FineBalToAcctg, c.MagistrateNotes, c.CitingOfficer, r.RuleIndex,
	CASE WHEN v.IssueAsWarning = 1 then 1 else 0 end as Warning,
	CASE WHEN v.IssueAsWarning = 0 then 1 else 0 end as Fine,
	isnull(c.VFirstName,'') + case when isnull(c.VFirstName,'')='' then '' else ' ' end + isnull(c.VLastName,'') as vFullName

FROM 
	[tblRuleType{LU}] r INNER JOIN 
	tblViolations v ON v.fkRuleID=r.RuleID INNER JOIN
	tblCitations c ON c.CitationID = v.fkCitationID
WHERE v.fkRuleID Like 'D%' AND c.OffenseDate Between @StartDate And @EndDate
ORDER BY r.RuleIndex, c.HearingDate DESC




END
GO
