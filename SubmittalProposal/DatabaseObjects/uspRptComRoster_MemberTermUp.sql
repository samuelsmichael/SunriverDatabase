SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* =============================================
	exec uspRptComRoster_MemberTermUp @TermEnd='9/1/2016'
   ============================================= */
alter PROCEDURE uspRptComRoster_MemberTermUp 
	@TermEnd DateTime
AS
BEGIN
	SET NOCOUNT ON;
	SELECT 
		rm.[MemberID], [FirstName] + ' ' + [LastName] AS MemberName, rm.[MTitle], rm.[TAppointed], rm.[TEnd], cd.[CommitteeID], rm.[TTerm], 
		cd.[TermLimit], cd.[TermLimitNote], cd.[CommitteeName], rm.[RosterMemberID], md.[LastName]
	FROM 
		tblRosterMembers rm Inner Join
		tblMemberData md ON md.[MemberID]=rm.[MemberID] INNER JOIN
		tblCommitteeData cd ON cd.[CommitteeID]=rm.[CommitteeID] 
	WHERE rm.[TEnd]=@TermEnd Or (cd.[CommitteeID]=9 And Year([TEnd])=Year(@TermEnd))
	ORDER BY CommitteeID, rm.[MTitle];
END
GO
