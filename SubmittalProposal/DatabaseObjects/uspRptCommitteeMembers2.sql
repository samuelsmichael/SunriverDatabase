SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* =============================================
	exec uspRptCommitteeMembers2 @ReportDate='9/1/2016'
   ============================================= */
USE COMROSTER;
GO
alter PROCEDURE uspRptCommitteeMembers2
	@ReportDate datetime = null
AS
BEGIN

	SELECT * FROM
	(select
		cd.[CommitteeID], cd.[CommitteeName], cd.[#OfMembers], cd.[#OfMembersNote], cd.[Term], cd.[TermLimit], cd.[TermLimitNote], 
		cd.[AlternateMembers], Case when [AlternateMembers]=0 THEN 'No' ELSE 'Yes' END AS [AlternatesY\N], cd.[AssociateMembers], 
		Case when [AssociateMembers]=0 then 'No' else 'Yes' end AS [AssociatesY\N], cd.[CharterDate], cd.[Status],@ReportDate as ReportDate,
		case when cast([#OfMembers] as int)!=0 then [#OfMembers] + ' members ' else '' end + [#OfMembersNote] as MembersInfo,
		Cast(Term as varchar) + 
		case when Term>1 then ' years ' else ' year ' end + 
		case when isnull(TermLimit,0)>0 then 'with a limit of ' + cast(TermLimit as varchar) + ' year' + 
			case when TermLimit>1 then 's' else '' end
		 else '' end as TermInfo
		FROM tblCommitteeData cd
	) com INNER JOIN (
	SELECT
		CommitteeID as CommitteeID_Mem,
		[FirstName] + ' ' + LastName +
		CASE MTitle 
			WHEN 1 then ': Chr'
			WHEN 2 THEN ': Co-Chr'
			WHEN 3 THEN ': V Chr'
			WHEN 4 THEN ': Sec'
			WHEN 5 THEN ': Alt'
		ELSE '' END AS MemberName_and_Title, SRPhone, NRPhone,
		IsNull([NRMailAddr],[SRMailAddr1]) as Addr, 
		Email,
		case when Left([SRMailAddr1],3)='PMB' then '18160 Cottonwood Rd' else ' ' end as SRMailAddr,
		null as CommitteeID_Li, null as LiaisonNRMail, null as LiaisonSRMail, null as LiaisonName, null as LiaisonType, null as LiaisonSRPhone, null as LiaisonEmail, null as LiaisonRepresents, null LiaisonNRPhone
	FROM 
		tblRostermembers rm  INNER JOIN 
		tblMemberData md ON md.MemberID=rm.MemberID
	) mem ON mem.CommitteeID_Mem=com.CommitteeID 
union 
	select * from
	(select
		cd.[CommitteeID], cd.[CommitteeName], cd.[#OfMembers], cd.[#OfMembersNote], cd.[Term], cd.[TermLimit], cd.[TermLimitNote], 
		cd.[AlternateMembers], Case when [AlternateMembers]=0 THEN 'No' ELSE 'Yes' END AS [AlternatesY\N], cd.[AssociateMembers], 
		Case when [AssociateMembers]=0 then 'No' else 'Yes' end AS [AssociatesY\N], cd.[CharterDate], cd.[Status], @ReportDate as ReportDate,
		case when cast([#OfMembers] as int)!=0 then [#OfMembers] + ' members ' else '' end + [#OfMembersNote] as MembersInfo,
		Cast(Term as varchar) + 
		case when Term>1 then ' years ' else ' year ' end + 
		case when isnull(TermLimit,0)>0 then 'with a limit of ' + cast(TermLimit as varchar) + ' year' + 
			case when TermLimit>1 then 's' else '' end
		 else '' end as TermInfo
		FROM tblCommitteeData cd
	) com2 INNER JOIN (
		select
			null as CommitteeID_Mem,null as MemberName_and_Title, null as SRPhone, null as NRPhone, null as Addr, null as Email, null as SRMailAddr,
			CommitteeID as CommitteeID_Li, 
			IsNull([LiaisonNRMail],[LiaisonSRMail1]) as [LiaisonNRMail],
			CASE WHEN Left([LiaisonSRMail1],3)='PMB' then '18160 Cottonwood Rd' else '' end as LiaisonSRMail,
			LiaisonName, LiaisonType, LiaisonSRPhone, LiaisonEmail, LiaisonRepresents, LiaisonNRPhone
		from
			tblRosterLiaison rl inner join 
			tblLiaisonData ld on ld.LiaisonID=rl.LiaisonID 
		WHERE ld.LiaisonName is not null
	) li ON li.CommitteeID_Li=Com2.CommitteeID


ORDER BY [CommitteeID]
END
GO
