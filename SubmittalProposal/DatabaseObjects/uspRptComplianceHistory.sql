SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 4/11/2016
-- Description:	Data for Compliance History report
/*
	exec uspRptComplianceHistory @Lot='6', @Lane='Sisters'
*/
-- =============================================
use srpropertysql;
go
alter PROCEDURE uspRptComplianceHistory 
	@Lot varchar(100) = null, 
	@Lane varchar(100) = null
AS
BEGIN
	SET NOCOUNT ON;
	if @Lot is null begin -- null values for Crystal Reports so that it sets the lengths correctly
		SELECT 
			cast(0 as int) as crReviewId, -- ReviewId
			cast (getdate() as DateTime) as crDate, -- crDate
			cast ('' as varchar(100)) as crLot, -- crLot
			cast ('' as varchar(100)) as crLane, -- crLane
			cast (0 as int) as crSubmittalID, -- SubmittalID
			cast ('' as varchar(max)) as crComments,
			cast ('' as varchar(max)) as crCorrection,
			cast ('' as varchar(max)) as crRule,
			cast ('' as varchar(max)) as crFollowUp,
			cast (getdate() as DateTime) as crCloseDate,
			cast ('' as varchar(6)) as crOpenClosed,
			cast ('' as varchar(100)) as Lot,
			cast ('' as varchar(100)) as Lane
		SELECT 
			cr.crReviewID, cr.crDate, cr.crLOT, cr.crLANE, cr.crSubmittalID, 
			cr.crComments, cr.crCorrection, cr.crRule, cr.crFollowUp, cr.crCloseDate, 
			CASE WHEN crCloseDate is null then 'OPEN' ELSE 'CLOSED' END as crOpenClosed,
			@Lot as Lot, @Lane as Lane
		FROM tblComplianceReview cr
		WHERE (((cr.crLOT)=@Lot) AND ((cr.crLANE)=@Lane))
		ORDER BY cr.crReviewID;
	END
END
GO
