USE ComRoster

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 10/14/2016
-- Description:	Gets the tables of ComRoster
-- =============================================
alter PROCEDURE uspComRosterTablesGet 
AS
BEGIN
	SET NOCOUNT ON;
	select * FROM tblCommitteeData ORDER BY CommitteeID
	Select * from tblMemberData WHERE MemberID!=1 ORDER BY MemberID
	Select rm.RosterMemberID, CommitteeID, MemberID,TAppointed,TStart, TEnd, TTerm,ts.MTitle from tblRostermembers rm LEFT OUTER JOIN [tblTitleSort{LU}] ts ON ts.TitleSort=rm.MTitle ORDER BY RosterMemberID
	select *, LiaisonName+' ('+LiaisonType+')' as LiaisonNameAndType from tblLiaisonData ORDER BY LiaisonID
	select * from tblRosterLiaison
	select * from tblRosterMembers ORDER BY RosterMemberID
	select * from [tblCommitteeTerms{LU}]
	select * from [tblTitleSort{LU}]
	select distinct LiaisonType from tblLiaisonData where LiaisonType is not null
END
GO
