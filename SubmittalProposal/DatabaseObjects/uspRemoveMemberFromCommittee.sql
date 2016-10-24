SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 10/22/2016
-- Description:	Removes a Member from Committee

-- =============================================
alter PROCEDURE uspRemoveMemberFromCommittee 
	@RosterMemberID int
as BEGIN
	DELETE FROM tblRosterMembers
	WHERE 
		RosterMemberID=@RosterMemberID
END
GO