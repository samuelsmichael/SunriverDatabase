SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 5/20/2016
-- Description:	Violations ORS
/*
	exec [uspCitationsQry-Warnings-ORS] @StartDate='1/1/2005', @EndDate='6/1/2016'
*/
-- =============================================
use srcitations;
go
alter PROCEDURE [uspCitationsQry-Warnings-ORS] 
	@StartDate datetime,
	@EndDate datetime
AS
BEGIN

SELECT 
	c.CitationID, v.fkRuleID, v.[ORS#], v.IssueAsWarning, v.ViolationNotes, r.RuleDescription, c.OffenseDate, c.FineStatus, c.VLastName, c.VFirstName, 
	c.OffenseLocation, c.CitingOfficer,
	isnull(c.VFirstName,'') + case when isnull(c.VFirstName,'')='' then '' else ' ' end + isnull(c.VLastName,'') as vFullName,
	@EndDate as EndDate, @StartDate as StartDate
FROM 
	[tblRuleType{LU}] r INNER JOIN 
	tblViolations v ON r.RuleID = v.fkRuleID inner join
	tblCitations c on c.CitationID = v.fkCitationID
WHERE v.[ORS#] Like '8%' AND v.IssueAsWarning=1 AND c.OffenseDate Between @StartDate And @EndDate
ORDER BY v.[ORS#], vLastName, vFirstName;



END
GO
