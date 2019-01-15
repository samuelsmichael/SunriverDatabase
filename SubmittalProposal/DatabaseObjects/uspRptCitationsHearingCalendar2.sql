SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 4/23/2016
-- Description:	Gets Data Set that drives Citations Hearing Calendar report
/*
	Exec uspRptCitationsHearingCalendar2 '9/8/2015'
*/
-- =============================================
use SRCitations;
go
alter PROCEDURE uspRptCitationsHearingCalendar2 
	@HearingDate datetime
AS
BEGIN	
	SET NOCOUNT ON;

	
	SELECT * FROM (
		SELECT 
			c.CitationID, c.OffenseDate, c.HearingDate, c.FineStatus, 
			case when [FineStatus]='Open' then 1 else 0 end AS CitationOpen, 
			c.VLastName, c.VFirstName, c.VMailAddr1, c.VMailAddr2, c.VCity, c.VState, c.VZip, c.VSunriverStatus, c.OffenseLocation, 
			c.CitingOfficer, c.MagistrateFine, c.JudicialFine, c.WriteOff, c.FineBalToAcctg, c.MagistrateNotes, f.TotalCitationFine, 
			f.PrePayAmount, 
			case when [FineStatus]='Assessed Fine - Paid' then [AssessedFine] else 0 end as AssessedFine,
			case when [FineStatus]='PrePay Amount - Paid' then [PrePayAmount] else 0 end AS FinePaid,
			c.Citation#
		FROM 
			qryTotalCitationFine f RIGHT JOIN 
			tblCitations c ON f.fkCitationID = c.CitationID
		WHERE c.HearingDate=@HearingDate
	) cit  LEFT OUTER JOIN (
		SELECT 
			v.ViolationID, v.fkCitationID, v.fkRuleID, r.RuleDescription, v.ScheduleFine, v.ViolationNotes, v.IssueAsWarning
		FROM 
			[tblRuleType{LU}] r INNER JOIN tblViolations v ON r.RuleID = v.fkRuleID
		WHERE 
			v.IssueAsWarning=0
	) vio ON vio.fkCitationID = cit.CitationID

	ORDER BY Citation#, ViolationID ;
END
GO
