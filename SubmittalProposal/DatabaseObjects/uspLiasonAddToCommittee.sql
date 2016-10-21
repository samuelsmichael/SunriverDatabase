SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 4/22/2016
-- Description:	Adds a new Liaison to Committee
/*
	exec uspLiasonAddToCommittee @LiaisonID = 3,@CommitteeID=7
*/
-- =============================================
alter PROCEDURE uspLiasonAddToCommittee 
	@CommitteeID int,
	@LiaisonID int
as BEGIN
	INSERT INTO tblRosterLiaison
	SELECT @CommitteeID, @LiaisonID
END
GO
