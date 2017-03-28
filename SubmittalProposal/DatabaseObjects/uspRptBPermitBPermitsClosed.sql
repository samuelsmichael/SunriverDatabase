SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 4/14/2015
-- Description:	Query for Submittal report: Admin Approval
/*
	exec uspRptBPermitBPermitsClosed '1/1/2016', '12/31/2017'
*/
-- =============================================
USE SRPropertySQL;
go
alter PROCEDURE uspRptBPermitBPermitsClosed 
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
			cast('' as nvarchar(3)) as ProjectType,
			cast('' as nvarchar(255)) as BPDelay,
			cast('4/19/2017' as datetime) as StartDate,
			cast('4/19/2017' as datetime) as EndDate
	end else begin
		SELECT 
			s.SubmittalID, s.BPermitID, s.Lot, s.Lane, bp.BPClosed, s.Own_Name, bp.BPIssueDate, bp.BPExpires, bp.BPStatus,
			s.ProjectType, bp.BPDelay,@StartDate as StartDate, @EndDate as EndDate
		FROM tblBPData bp left outer JOIN qrySubmittal s ON bp.fkSubmittalID_PD = s.SubmittalID
		WHERE bp.BPClosed>0 AND bp.BPIssueDate Between @StartDate And @EndDate
		ORDER BY s.BPermitID
	end

END
GO


