SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* =============================================
	exec uspRptCommitteeRoster_Committee
   ============================================= */
alter PROCEDURE uspRptCommitteeRoster_Committee
AS
BEGIN
SELECT cd.[CommitteeID], cd.[CommitteeName], cd.[#OfMembers], cd.[#OfMembersNote], cd.[Term], cd.[TermLimit], cd.[TermLimitNote], cd.[AlternateMembers], 
	case when cast([#OfMembers] as int)!=0 then [#OfMembers] + ' members ' else '' end + [#OfMembersNote] as MembersInfo,
	case when [AlternateMembers]=0 then 'No' else 'Yes' end AS [AlternatesY\N], cd.[AssociateMembers], 
	case when [AssociateMembers]=0 then 'No' else 'Yes' end AS [AssociatesY\N], cd.[CharterDate], 
	case when cd.[Status]='Inactive' then 'Currently Inactive' else '' end as [Status],

	Cast(Term as varchar) + 
		case when Term>1 then ' years ' else ' year ' end + 
		case when isnull(TermLimit,0)>0 then 'with a limit of ' + cast(TermLimit as varchar) + ' year' + 
			case when TermLimit>1 then 's' else '' end
		 else '' end as TermInfo

FROM tblCommitteeData cd
ORDER BY cd.[CommitteeID]
END
GO
