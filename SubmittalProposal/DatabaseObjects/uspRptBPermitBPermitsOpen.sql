SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 4/14/2015
-- Description:	Query for Submittal report: Admin Approval
/*
	exec uspRptBPermitBPermitsOpen '1/9/2014', '1/9/2015'
*/
-- =============================================
alter PROCEDURE uspRptBPermitBPermitsOpen 
	@StartDate datetime,
	@EndDate datetime

AS
BEGIN
	SET NOCOUNT ON;
	if @StartDate is null begin
		SELECT
			cast(0 as int) as SubmittalID,
			cast(0 as int) as BPermitID,
			cast('' as nvarchar(10)) as Lot,
			cast('' as nvarchar(30)) as Lane,
			cast(getdate() as datetime) as BPClosed,
			cast('' as nvarchar(40)) as Own_Name,
			cast(getdate() as datetime) as BPIssueDate,
			cast(getdate() as datetime) as BPExipres,
			cast('' as nvarchar(7)) as BPStatus,
			cast('' as nvarchar(3)) as ProjectType
	end else begin
		SELECT s.SubmittalID, s.BPermitID, s.Lot, s.Lane, bp.BPClosed, s.Own_Name, bp.BPIssueDate, bp.BPExpires, 
		BPStatus, s.ProjectType
		FROM tblBPData bp LEFT OUTER JOIN qrySubmittal s ON bp.fkSubmittalID_PD = s.SubmittalID
		WHERE bp.BPClosed Is Null AND bp.BPIssueDate Between @StartDate And @EndDate
		ORDER BY s.BPermitID
	end

END
GO


