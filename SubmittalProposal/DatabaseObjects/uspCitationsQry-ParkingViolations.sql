SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 5/20/2016
-- Description:	Violator History
/*
	exec [uspCitationsQry-ParkingViolations] @StartDate='1/1/2005', @EndDate='1/21/2016'
*/
-- =============================================
use srcitations;
go
alter PROCEDURE [uspCitationsQry-ParkingViolations] 
	@StartDate datetime,
	@EndDate datetime
AS
BEGIN

SELECT 
	c.CitationID, v.fkRuleID, v.IssueAsWarning, v.ScheduleFine, v.ViolationNotes, r.RuleDescription, c.OffenseDate, c.FineStatus, c.VLastName, 
	c.VFirstName, c.OffenseLocation, c.HearingDate, c.MagistrateFine, c.AssessedFine, 
	case when FineStatus='Dismissed' then 0 else AssessedFine end AS PaidAssessedFine, 
	case when FineStatus='Dismissed' THEN 0 else case when FineStatus='PrePay Amount - Paid' then ScheduleFine/2 else 0 end end as PaidPrePayFine,
	c.JudicialFine, c.WriteOff, c.FineBalToAcctg, c.MagistrateNotes, c.CitingOfficer, r.RuleIndex,
	((case when FineStatus='Dismissed' then 0 else AssessedFine end) + (case when FineStatus='Dismissed' THEN 0 else case when FineStatus='PrePay Amount - Paid' then ScheduleFine/2 else 0 end end)) as TotalFine,
	isnull(c.VFirstName,'') + case when isnull(c.VFirstName,'')='' then '' else ' ' end + isnull(c.VLastName,'') as vFullName,
	@EndDate as EndDate, @StartDate as StartDate, c.Citation#
FROM 
	[tblRuleType{LU}] r RIGHT JOIN (tblCitations c LEFT JOIN tblViolations v ON c.CitationID=v.fkCitationID) ON r.RuleID=v.fkRuleID
WHERE 
	v.fkRuleID Like '2.02%' AND v.IssueAsWarning=0 AND c.OffenseDate Between @StartDate And @EndDate
ORDER BY r.RuleIndex, c.Citation# ;




END
GO
