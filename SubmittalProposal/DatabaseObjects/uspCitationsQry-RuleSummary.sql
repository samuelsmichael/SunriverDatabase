SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 5/20/2016
-- Description:	Citations Open
/*
	exec [uspCitationsQry-RuleSummary] @StartDate='1/1/2014', @EndDate='6/1/2016'
*/
-- =============================================
ALTER PROCEDURE [uspCitationsQry-RuleSummary] 
	@StartDate datetime,
	@EndDate datetime
AS
BEGIN

SELECT 
	r.RuleID, CASE WHEN RuleSource='SRR&R' THEN 'Sunriver Rules & Regulations' ELSE CASE WHEN RuleSource='SRDC' THEN 'Sunriver Design Committee' ELSE 'Unknown' END END AS RuleSourceDescription, r.RuleDescription, count(r.RuleID) as Total, sum(CASE WHEN v.IssueAsWarning=0 THEN 1 ELSE 0 END) AS Magistrate, sum(CASE WHEN v.IssueAsWarning=1 THEN 1 ELSE 0 END) AS Warning
/*	c.CitationID, r.RuleIndex, r.RuleID, r.RuleDescription, v.ViolationID, v.ScheduleFine, v.IssueAsWarning, c.AssessedFine, c.OffenseDate, c.FineStatus, r.RuleSource, 
	CASE WHEN FineStatus='Dismissed' THEN 0 ELSE AssessedFine END AS PaidAssessedFine, 
	CASE WHEN FineStatus='Dismissed' THEN 0 ELSE CASE WHEN FineStatus='PrePay Amount - Paid' THEN ScheduleFine/2 ELSE 0 END END as PaidPrePayFine,
	CASE WHEN RuleSource='SRR&R' THEN 'Sunriver Rules & Regulations' ELSE CASE WHEN RuleSource='SRDC' THEN 'Sunriver Design Committee' ELSE 'Unknown' END END AS RuleSourceDescription
*/
FROM 
	[tblRuleType{LU}] r INNER JOIN 
	tblViolations v on r.RuleID=v.fkRuleID INNER JOIN
	tblCitations c ON c.CitationID = v.fkCitationID
WHERE c.OffenseDate Between @StartDate And @EndDate
Group BY 
	r.RuleID, 
	CASE WHEN RuleSource='SRR&R' THEN 'Sunriver Rules & Regulations' ELSE CASE WHEN RuleSource='SRDC' THEN 'Sunriver Design Committee' ELSE 'Unknown' END END, 
	r.RuleDescription
ORDER BY RuleSourceDescription,r.RuleID



END
GO
