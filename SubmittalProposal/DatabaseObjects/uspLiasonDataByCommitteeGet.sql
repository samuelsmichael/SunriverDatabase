SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 4/22/2016
-- Description:	Gets Liaison Data given CommitteeID
/*
	exec uspLiasonDataByCommitteeGet @CommitteeID=3
*/
-- =============================================
alter PROCEDURE uspLiasonDataByCommitteeGet 
	@CommitteeID int
as BEGIN
	SELECT  l.*,c.*,rl.*
	FROM
		tblLiaisonData l INNER JOIN
		tblRosterLiaison rl ON l.LiaisonID=rl.LiaisonID INNER JOIN
		tblCommitteeData c ON c.CommitteeID=rl.CommitteeID
	WHERE
		@CommitteeID=c.CommitteeID

END
GO
