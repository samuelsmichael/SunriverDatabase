SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 4/11/2016
-- Description:	Data for Compliance History report
/*
	exec uspRptComplianceReviewsOpen @FromDate='1/1/2014', @ToDate='12/31/2014'
*/
-- =============================================
use srpropertysql;
go
alter PROCEDURE uspRptComplianceReviewsOpen 
	@FromDate datetime = null, 
	@ToDate datetime = null
AS
BEGIN
	SET NOCOUNT ON;
	if @FromDate is null begin -- null values for Crystal Reports so that it sets the lengths correctly
		SELECT
			cast(0 as int) as crReviewID,
			cast(null as datetime) as crDate,
			cast('' as nvarchar(6)) as crOpenClosed,
			cast('' as nvarchar(10)) as crLOT,
			cast('' as nvarchar(30)) as crLANE,
			cast(0 as int) as crSubmittalID,
			cast('' as nvarchar(max)) as crComments,
			cast('' as nvarchar(max)) as crCorrection,
			cast('' as nvarchar(max)) as crRule,
			cast('' as nvarchar(max)) as crFollowUp,
			cast(null as datetime) as crCloseDate,
			cast(null as datetime) as crLTActionDate,
			cast ('4/19/2016' as datetime) as FromDate,
			cast ('4/19/2016' as datetime) as ToDate
	end else begin
		SELECT 
			cr.crReviewID, cr.crDate, 
			CASE WHEN IsDate(crCloseDate)=1 THEN 'CLOSED' ELSE 'OPEN' END as crOpenClosed,
			cr.crLOT, cr.crLANE, cr.crSubmittalID, cr.crComments, cr.crCorrection, cr.crRule, 
			cr.crFollowUp, cr.crCloseDate, cld.crLTActionDate
			, @FromDate as FromDate, @ToDate as ToDate
		FROM 
			tblComplianceLetterData cld RIGHT OUTER JOIN tblComplianceReview cr ON cld.fkcrReviewID = cr.crReviewID
		WHERE cr.crDate Between @FromDate and @ToDate AND CASE WHEN IsDate(crCloseDate)=1 THEN 'CLOSED' ELSE 'OPEN' END ='OPEN'
		ORDER BY cr.crReviewID;
	END
END
GO
