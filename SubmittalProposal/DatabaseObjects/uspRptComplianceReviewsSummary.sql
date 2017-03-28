SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 4/15/2016
-- Description:	Data for Compliance Review Summary report
/*
	exec uspRptComplianceReviewsSummary @FromDate='1/1/2014', @ToDate='12/31/2014'
*/
-- =============================================
use srpropertysql;
go
alter PROCEDURE uspRptComplianceReviewsSummary 
	@FromDate datetime = null, 
	@ToDate datetime = null
AS
BEGIN
	SET NOCOUNT ON;
	if @FromDate is null begin -- null values for Crystal Reports so that it sets the lengths correctly
		SELECT
			cast(0 as int) as crReviewID,
			cast(null as datetime) as crDate,
			cast('' as nvarchar(10)) as crLOT,
			cast('' as nvarchar(30)) as crLANE,
			cast(0 as int) as crSubmittalID,
			cast('' as nvarchar(max)) as crComments,
			cast('' as nvarchar(max)) as crCorrection,
			cast('' as nvarchar(max)) as crRule,
			cast('' as nvarchar(max)) as crFollowUp,
			cast('' as nvarchar(6)) as crOpenClosed,
			cast(null as datetime) as crCloseDate,
			cast(null as datetime) as crLTActionDate,
			cast(0 as int) as fkcrReviewID,
			cast ('4/19/2016' as datetime) as FromDate,
			cast ('4/19/2016' as datetime) as ToDate
	end else begin
		SELECT cr.crReviewID, cr.crDate, cr.crLOT, cr.crLANE, cr.crSubmittalID, cr.crComments, cr.crCorrection, cr.crRule, cr.crFollowUp, 
		crOpenClosed, cr.crCloseDate, cl.crLTActionDate, cl.fkcrReviewID
		, @FromDate as FromDate, @ToDate as ToDate
		FROM tblComplianceReview cr LEFT OUTER JOIN tblComplianceLetterData cl ON cr.crReviewID = cl.fkcrReviewID
		WHERE cr.crDate Between @FromDate And @ToDate
		ORDER BY cr.crReviewID

	END
END
GO
