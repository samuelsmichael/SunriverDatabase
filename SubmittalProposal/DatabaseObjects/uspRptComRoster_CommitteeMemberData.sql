SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* =============================================
	exec uspRptComRoster_CommitteeMemberData @ReportDate='9/1/2016'
   ============================================= */
alter PROCEDURE uspRptComRoster_CommitteeMemberData 
	@ReportDate DateTime
AS
BEGIN
	SET NOCOUNT ON;
	SELECT 
		cd.[CommitteeID], cd.[CommitteeName], cd.[#OfMembers], cd.[#OfMembersNote], cd.[Term], cd.[TermLimit], cd.[TermLimitNote], 
		cd.[AlternateMembers], Case when [AlternateMembers]=0 THEN 'No' ELSE 'Yes' END AS [AlternatesY\N], cd.[AssociateMembers], 
		Case when [AssociateMembers]=0 then 'No' else 'Yes' end AS [AssociatesY\N], cd.[CharterDate], cd.[Status],

		rm.MemberID, [FirstName] + ' ' + [LastName] AS MemberName, rm.MTitle, rm.TAppointed, rm.TStart, rm.TEnd, 
		rm.TTerm, md.FirstName, md.LastName, md.SRMailAddr1, md.SRMailAddr2, md.SRPhone, md.SRFax, md.Email, 
		md.NRMailAddr, md.NRPhone, md.Comments, rm.RosterMemberID, rm.CommitteeID, ts.MTitle as TitleName,
		IsNull([NRMailAddr],[SRMailAddr1]) as Addr,
		isnull(SRPhone,NRPhone) as ReportedPhone,
		case when Left([SRMailAddr1],3)='PMB' then '18160 Cottonwood Rd' else ' ' end as SecondLineAddress,
		case when NRMailAddr is null then [SRMailAddr1] + '      ' +  ' Sunriver, OR 97707' else [NRMailAddr] end as FirstLineAddress
		

	FROM 
		tblCommitteeData cd INNER JOIN
		tblRosterMembers rm ON cd.CommitteeID=rm.CommitteeID INNER JOIN
		tblMemberData md ON rm.MemberID=md.MemberID INNER JOIN
		[tblTitleSort{LU}] ts ON rm.MTitle=ts.TitleSort
	ORDER BY cd.[CommitteeID],rm.MTitle, md.LastName, md.FirstName
END
GO
