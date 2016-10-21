SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 10/22/2016
-- Description:	Removes a Liaison from Committee

-- =============================================
alter PROCEDURE uspLiasonRemoveFromCommittee 
	@RosterLiaisonID int
as BEGIN
	DELETE FROM tblRosterLiaison
	WHERE 
		RosterLiaisonID=@RosterLiaisonID
END
GO