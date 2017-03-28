SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 5/20/2016
-- Description:	Violations ORS
/*
	exec [uspCitationsQry-Violations-ORS] @StartDate='1/1/2005', @EndDate='6/1/2016'
*/
-- =============================================
use srcitations;
go
alter PROCEDURE [uspCitationsQry-Violations-ORS] 
	@StartDate datetime,
	@EndDate datetime
AS
BEGIN

SELECT 
	c.CitationID, v.fkRuleID, v.[ORS#], v.IssueAsWarning, v.ScheduleFine, v.ViolationNotes, [r].RuleDescription, c.OffenseDate, c.FineStatus, 
	c.VLastName, c.VFirstName, c.OffenseLocation, c.HearingDate, c.MagistrateFine, c.AssessedFine, c.JudicialFine, c.WriteOff, 
	c.FineBalToAcctg, c.MagistrateNotes, c.CitingOfficer, 
	case when FineStatus='Dismissed' THEN 0 else AssessedFine end as PaidAssessedFine,
	case when FineStatus='Dissmissed' then 0 else case when FineStatus='PrePay Amount - Paid' then ScheduleFine/2 else 0 end end as PaidPrePayFine,
	isnull(c.VFirstName,'') + case when isnull(c.VFirstName,'')='' then '' else ' ' end + isnull(c.VLastName,'') as vFullName,
	((case when FineStatus='Dismissed' THEN 0 else AssessedFine end) +
		(case when FineStatus='Dissmissed' then 0 else case when FineStatus='PrePay Amount - Paid' then ScheduleFine/2 else 0 end end)) as TotalPaidFine,
	@EndDate as EndDate, @StartDate as StartDate

FROM [tblRuleType{LU}] r INNER JOIN (tblCitations c Inner Join tblViolations v ON c.CitationID = v.fkCitationID) ON [r].RuleID = v.fkRuleID
WHERE v.[ORS#] Like '8%' AND v.IssueAsWarning=0 AND c.OffenseDate Between @StartDate And @EndDate
ORDER BY v.[ORS#], c.CitationID DESC;


END
GO
