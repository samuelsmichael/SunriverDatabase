SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* =============================================
	exec uspRptCommitteeRoster_Liaison @CommitteeID=2
   ============================================= */
   use comroster;
   go
alter PROCEDURE uspRptCommitteeRoster_Liaison
	@CommitteeID int
AS
BEGIN
select
	CommitteeID, IsNull([LiaisonNRMail],[LiaisonSRMail1]) as [LiaisonNRMail],
	CASE WHEN Left([LiaisonSRMail1],3)='PMB' then '18160 Cottonwood Rd' else '' end as LiaisonSRMail,
	IsNull(LiaisonNRMail,LiaisonSRMail1) as LiaisonNRMailFormatted,
	LiaisonName, LiaisonType, LiaisonSRPhone, LiaisonEmail, LiaisonRepresents, LiaisonNRPhone
from
	tblRosterLiaison rl inner join 
	tblLiaisonData ld on ld.LiaisonID=rl.LiaisonID 
WHERE ld.LiaisonName is not null
	and rl.CommitteeId=@CommitteeID
END