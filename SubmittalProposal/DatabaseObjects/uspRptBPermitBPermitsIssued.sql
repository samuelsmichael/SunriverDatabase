SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 3/11/2015
-- Description:	Query for Submittal report: Admin Approval
/*
	exec uspRptBPermitBPermitsIssued '1/9/2014', '1/9/2015', @ReportingHeading='My Report Heading'
*/
-- =============================================
alter PROCEDURE uspRptBPermitBPermitsIssued 
	@StartDate datetime,
	@EndDate datetime,
	@ReportingHeading varchar(256)

AS
BEGIN
	SET NOCOUNT ON;
	with qrySubmittal as (
		SELECT 
			s.SubmittalID, b.fkSubmittalID_PD, b.BPermitID, s.Lot, s.Lane, 
			b.BPClosed, s.Own_Name, b.BPIssueDate, b.BPExpires,
			case when b.BPClosed is not null then 'CLOSED' 
				else 
					CASE WHEN BPExpires<getdate() THEN 'EXPIRED' else 'VALID' END 
			END as BPStatus,
			s.ProjectType, s.Project, s.Mtg_Date, s.Submittal, s.Conditions, s.ProjectFee, s.ProjectDecision
		FROM tblBPData b INNER JOIN tblSubmittal s ON b.fkSubmittalID_PD = s.SubmittalID
		WHERE (((b.BPermitID)>0) AND ((b.BPIssueDate) Between @StartDate And @Enddate))

	)
	SELECT 
		qrySubmittal.BPermitID, qrySubmittal.Lot, qrySubmittal.Lane, qrySubmittal.BPIssueDate, qrySubmittal.BPExpires, 
		qrySubmittal.BPStatus, qrySubmittal.SubmittalID, qrySubmittal.Submittal as ProjectDescription, qrySubmittal.ProjectType, cast(TypeDescription as varchar(25)) as TypeDescription,
		case when BPStatus='CLOSED' then 1 else 0 end as CountClosed,
		case when BPStatus!='CLOSED' then 1 else 0 end as CountOpen
	FROM 
		qrySubmittal inner join [tblProjectType{LU}] pt ON qrySubmittal.ProjectType =pt.ProjectType
	ORDER BY ProjectType,qrySubmittal.Lane;

END
GO


