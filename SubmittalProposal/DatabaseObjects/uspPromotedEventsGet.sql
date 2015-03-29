SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: March 14, 2015
-- Description:	Returns a dataset of Promoted Events information
/*
	exec uspPromotedEventsGet
*/
-- =============================================
ALTER PROCEDURE uspPromotedEventsGet 
AS
BEGIN
	SET NOCOUNT ON;
	select 
		pe.*,pc.*
			,ped.promotedEventOrderId
			,ped.promotedEventsDetailsID
			,ped.promotedEventsDetailsTitle
			,ped.promotedEventsDetailsDescription
			,ped.promotedEventsDetailsURLDocDownload
			,ped.promotedEventsDetailsAddress
			,ped.promotedEventsDetailsTelephone
			,ped.promotedEventsDetailsWebsite
			,ped.promotedEventDetailIconURL
	FROM
		SRPromotedEvents pe INNER JOIN
		SRPromotedEventsDetails ped ON pe.promotedEventsId=ped.promotedEventID_FK INNER JOIN
		SRPromotedCategory pc ON ped.promtedEventDetailsCategoryNumber=pc.promotedCatID
	WHERE
		isnull(pe.isOnPromotedEvents,0)=1
	ORDER BY pe.promotedEventsId, pc.promotedCatSortOrder, ped.promotedEventOrderId
END
GO
