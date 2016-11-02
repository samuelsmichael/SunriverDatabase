SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* =============================================
	exec uspRptCommitteeRoster_Member @CommitteeID=2
   ============================================= */
alter PROCEDURE uspRptCommitteeRoster_Member
	@CommitteeID int
AS
BEGIN
SELECT
CommitteeID, [FirstName] + ' ' + LastName +
	CASE MTitle 
		WHEN 1 then ': Chr'
		WHEN 2 THEN ': Co-Chr'
		WHEN 3 THEN ': V Chr'
		WHEN 4 THEN ': Sec'
		WHEN 5 THEN ': Alt'
	ELSE '' END AS MemberName_and_Title,
TAppointed, TStart, TEnd, SRPhone, NRPhone, TTerm,
case when TEND is null then '' else '{'+TTerm +'}' end as MiddlePartOfTermDescription,

IsNull([NRMailAddr],[SRMailAddr1]) as Addr, Email,
case when Left([SRMailAddr1],3)='PMB' then '18160 Cottonwood Rd' else ' ' end as SRMailAddr
FROM 
	tblRostermembers rm  INNER JOIN 
	tblMemberData md ON md.MemberID=rm.MemberID
WHERE rm.CommitteeId=@CommitteeID
END
GO
