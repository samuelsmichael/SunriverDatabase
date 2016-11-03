SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* =============================================
	exec uspRptCommitteeRoster_Committee @CommitteeID=2
   ============================================= */
alter PROCEDURE uspRptCommitteeRoster_Committee
	@CommitteeID int
AS
BEGIN
	SELECT
		cd.[CommitteeID], cd.[CommitteeName], cd.[#OfMembers], cd.[#OfMembersNote], cd.[Term], cd.[TermLimit], cd.[TermLimitNote], 
		cd.[AlternateMembers], Case when [AlternateMembers]=0 THEN 'No' ELSE 'Yes' END AS [AlternatesY\N], cd.[AssociateMembers], 
		Case when [AssociateMembers]=0 then 'No' else 'Yes' end AS [AssociatesY\N], cd.[CharterDate], cd.[Status],

	Cast(Term as varchar) + 
		case when Term>1 then ' years ' else ' year ' end + 
		case when isnull(TermLimit,0)>0 then 'with a limit of ' + cast(TermLimit as varchar) + ' year' + 
			case when TermLimit>1 then 's' else '' end
		 else '' end as TermInfo

FROM tblCommitteeData cd
WHERE @CommitteeId is null or CommitteeID=@CommitteeID 
ORDER BY cd.[CommitteeID]
END
GO
