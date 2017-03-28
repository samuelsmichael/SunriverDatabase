USE [SRPropertySQL]
GO
/****** Object:  StoredProcedure [dbo].[uspRptBPermitBPermitsIssued]    Script Date: 3/26/2017 2:01:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 3/11/2015
-- Description:	Query for Submittal report: Admin Approval
/*
	exec uspRptBPermitBPermitsIssued '1/1/2016', '12/31/2017', @ReportingHeading='My Report Heading'
	exec uspRptBPermitBPermitsIssued @Lot='3', @Lane='Fairway'
*/
-- =============================================
USE SRPropertySQL;
GO
ALTER PROCEDURE [dbo].[uspRptBPermitBPermitsIssued] 
	@StartDate datetime = null,
	@EndDate datetime = null,
	@ReportingHeading varchar(256)=null,
	@Lot varchar(50)=null,
	@Lane varchar(50)=null
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
		FROM tblBPData b RIGHT JOIN tblSubmittal s ON b.fkSubmittalID_PD = s.SubmittalID
		WHERE 
			b.BPermitID>0 AND
			(@Lot is null or s.Lot=@Lot)
			AND (@Lane is null or s.Lane=@Lane)
			AND (@StartDate is null or b.BPIssueDate Between @StartDate And @Enddate)

	)
	SELECT 
		qrySubmittal.BPermitID, qrySubmittal.Lot, qrySubmittal.Lane, qrySubmittal.BPIssueDate, qrySubmittal.BPExpires, 
		qrySubmittal.BPStatus, qrySubmittal.SubmittalID, qrySubmittal.Submittal as ProjectDescription, qrySubmittal.ProjectType, cast(TypeDescription as varchar(25)) as TypeDescription,
		case when qrySubmittal.BPStatus='CLOSED' then 1 else 0 end as CountClosed,
		case when qrySubmittal.BPStatus!='CLOSED' then 1 else 0 end as CountOpen,Own_Name, @StartDate as StartDate, @EndDate as EndDate, @ReportingHeading as RepoingrtHeading, @Lot as Lot, @Lane as Lane
	FROM 
		tblBPData LEFT JOIN qrySubmittal ON tblBPData.fkSubmittalID_PD = qrySubmittal.SubmittalID
		inner join [tblProjectType{LU}] pt ON qrySubmittal.ProjectType =pt.ProjectType
	ORDER BY ProjectType,qrySubmittal.Lane,qrySubmittal.Lot;

END
