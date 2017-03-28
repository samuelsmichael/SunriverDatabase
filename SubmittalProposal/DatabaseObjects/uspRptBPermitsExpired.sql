SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 4/14/2015
-- Description:	Query for BPermits Expired
/*
	exec uspRptBPermitsExpired '1/9/2014', '1/9/2015'
*/
-- =============================================
use SRPropertySQL;
go
alter PROCEDURE uspRptBPermitsExpired 
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
			cast('' as nvarchar(7)) as BPStatus,
			cast(getdate() as datetime) as BPIssueDate,
			cast(getdate() as datetime) as BPExipres,
			cast('' as nvarchar(40)) as Own_Name,
			cast('' as nvarchar(3)) as ProjectType,
			cast('1/1/2015' as datetime) as StartDate,
			cast('12/31/2017' as datetime) as EndDate
	end else begin
		SELECT s.SubmittalID, s.BPermitID, s.Lot, s.Lane, bp.BPClosed, 
		BPStatus, bp.BPIssueDate, bp.BPExpires, s.Own_Name, s.ProjectType, @StartDate as StartDate, @EndDate as EndDate
		FROM tblBPData bp LEFT JOIN qrySubmittal s ON bp.fkSubmittalID_PD = s.SubmittalID
		WHERE 
			BPStatus='Expired' AND 
			bp.BPIssueDate Between @StartDate And @EndDate

	end

END
GO


