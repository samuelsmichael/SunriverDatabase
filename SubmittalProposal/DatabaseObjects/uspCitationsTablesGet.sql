USE SRCitations

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 9/07/2015
-- Description:	Gets the tables of Citations
-- =============================================
alter PROCEDURE uspCitationsTablesGet 
AS
BEGIN
	SET NOCOUNT ON;
	select * FROM tblCitations 
	Select * from tblViolations v LEFT OUTER JOIN [tblRuleType{LU}] r ON v.fkRuleID=r.RuleID
	Select * from [tblFineStatus{LU}]
	select * from [tblRuleType{LU}]
	select * from [tblSunriverStatus{LU}]
END
GO
