SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 5/20/2016
-- Description:	Vegetation
/*
	exec [uspCitationsQry-Vegetation] @StartDate='1/1/2014', @EndDate='6/1/2016'
*/
-- =============================================
use SRCitations;
go
alter PROCEDURE [uspCitationsQry-Vegetation] 
	@StartDate datetime,
	@EndDate datetime
AS
BEGIN
SELECT 
	c.CitationID, v.fkRuleID, v.IssueAsWarning, v.ScheduleFine, v.ViolationNotes, [r].RuleDescription, c.OffenseDate, c.FineStatus, c.VLastName, c.VFirstName, c.OffenseLocation, 
	c.HearingDate, c.MagistrateFine, c.AssessedFine, c.JudicialFine, c.WriteOff, c.FineBalToAcctg, c.MagistrateNotes, c.CitingOfficer, [r].RuleIndex, 
	case when FineStatus='Dismissed' THEN 0 else AssessedFine end as PaidAssessedFine,
	case when FineStatus='Dissmissed' then 0 else case when FineStatus='PrePay Amount - Paid' then ScheduleFine/2 else 0 end end as PaidPrePayFine,
	isnull(c.VFirstName,'') + case when isnull(c.VFirstName,'')='' then '' else ' ' end + isnull(c.VLastName,'') as vFullName,
	((case when FineStatus='Dismissed' THEN 0 else AssessedFine end) + (case when FineStatus='Dissmissed' then 0 else case when FineStatus='PrePay Amount - Paid' then ScheduleFine/2 else 0 end end)) as TotalFine,
	@StartDate as StartDate, @EndDate as EndDate
FROM [tblRuleType{LU}] r INNER JOIN (tblCitations c LEFT JOIN tblViolations v ON c.CitationID = v.fkCitationID) ON [r].RuleID = v.fkRuleID
WHERE v.fkRuleID Like '4.01%' AND v.IssueAsWarning=0 AND c.OffenseDate Between @StartDate And @EndDate
ORDER BY [r].RuleIndex, c.CitationID





END
GO
