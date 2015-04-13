SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 3/11/2015
-- Description:	Query for Submittal report: Admin Approval
/*
	exec uspRptSubmittalAdminApproval '1/9/2014', '1/9/2015', @ReportingHeading='My Report Heading'
*/
-- =============================================
alter PROCEDURE uspRptSubmittalAdminApproval 
	@StartDate datetime,
	@EndDate datetime,
	@ReportingHeading varchar(256)

AS
BEGIN
	SET NOCOUNT ON;
	with qrySubmittal as (
		SELECT 
			tblSubmittal.SubmittalID, tblBPData.BPermitID, tblBPData.fkSubmittalID_PD, tblSubmittal.Own_Name, tblSubmittal.Add_1, 
			tblSubmittal.Own_Add, tblSubmittal.Own_City, tblSubmittal.Own_State, tblSubmittal.Own_ZIP, tblSubmittal.Applicant, 
			tblSubmittal.Block, tblSubmittal.Village, tblSubmittal.Mtg_Date, tblSubmittal.App_Exp_Dt, tblSubmittal.ProjectType, 
			tblSubmittal.Submittal, tblSubmittal.Project, tblSubmittal.ProjectDecision, tblSubmittal.Conditions, tblSubmittal.ProjectFee, 
			tblSubmittal.[FeeDate], tblSubmittal.Contractor, tblSubmittal.Reg_Number, [Lot] + ' ' + [Lane] AS LotLane, tblSubmittal.Lot, tblSubmittal.Lane
		FROM tblBPData RIGHT JOIN tblSubmittal ON tblBPData.fkSubmittalID_PD = tblSubmittal.SubmittalID
	)

	SELECT 
		qrySubmittal.SubmittalID, qrySubmittal.ProjectType, qrySubmittal.ProjectDecision, qrySubmittal.Lot, qrySubmittal.Lane, qrySubmittal.Mtg_Date, qrySubmittal.Submittal, 
		qrySubmittal.Conditions, [tblProjectDecision{LU}].DecisionDescription, @ReportingHeading AS MonthAndYear, qrySubmittal.ProjectFee
	FROM 
		qrySubmittal LEFT JOIN [tblProjectDecision{LU}] ON qrySubmittal.ProjectDecision = [tblProjectDecision{LU}].ProjectDecision
	WHERE 
		(((qrySubmittal.ProjectType)='AA') AND ((qrySubmittal.Mtg_Date) Between @StartDate And @EndDate))
	ORDER BY qrySubmittal.ProjectDecision, qrySubmittal.Lane;
END
GO


