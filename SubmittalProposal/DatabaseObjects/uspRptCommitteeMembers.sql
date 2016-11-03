SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* =============================================
	exec uspRptCommitteeMembers @ReportDate='9/1/2016'
   ============================================= */
alter PROCEDURE uspRptCommitteeMembers
	@ReportDate datetime
AS
BEGIN
	select
		cd.[CommitteeID], cd.[CommitteeName], cd.[#OfMembers], cd.[#OfMembersNote], cd.[Term], cd.[TermLimit], cd.[TermLimitNote], 
		cd.[AlternateMembers], Case when [AlternateMembers]=0 THEN 'No' ELSE 'Yes' END AS [AlternatesY\N], cd.[AssociateMembers], 
		Case when [AssociateMembers]=0 then 'No' else 'Yes' end AS [AssociatesY\N], cd.[CharterDate], cd.[Status]


FROM tblCommitteeData cd
ORDER BY cd.[CommitteeID]
END
GO
