SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 5/20/2016
-- Description:	Parking Warning
/*
	exec [uspCitationsQry-DesignWarning] @StartDate='1/1/2010', @EndDate='6/1/2017'
*/
-- =============================================
use srcitations;
go
alter PROCEDURE [uspCitationsQry-DesignWarning] 
	@StartDate datetime,
	@EndDate datetime
AS
BEGIN

SELECT 
	c.CitationID, v.fkRuleID, v.IssueAsWarning, v.ViolationNotes, [r].RuleDescription, c.OffenseDate, c.FineStatus, c.VLastName, c.VFirstName, c.OffenseLocation, c.CitingOfficer, [r].RuleIndex,
	isnull(c.VFirstName,'') + case when isnull(c.VFirstName,'')='' then '' else ' ' end + isnull(c.VLastName,'') as vFullName,
	@EndDate as EndDate, @StartDate as StartDate
FROM 
	[tblRuleType{LU}] r RIGHT JOIN (tblCitations c LEFT JOIN tblViolations v ON c.CitationID = v.fkCitationID) ON [r].RuleID = v.fkRuleID
WHERE 
	v.fkRuleID Like 'D%' AND v.IssueAsWarning=1 AND c.OffenseDate Between @StartDate And @EndDate
ORDER BY [r].RuleIndex, c.VLastName, c.VFirstName, c.OffenseDate;










END
GO
