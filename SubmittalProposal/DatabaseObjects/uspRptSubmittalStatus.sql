SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 4/11/2015
-- Description:	Query for Submittal Status Report
/*
	exec uspRptSubmittalStatus @FromDate='1/1/2014', @ToDate='12/31/2014'
*/
-- =============================================
Use srpropertysql
go
alter PROCEDURE uspRptSubmittalStatus 
	-- Add the parameters for the stored procedure here
	@FromDate Datetime = null, 
	@ToDate DateTime = null
AS
BEGIN
	SET NOCOUNT ON;
	if @FromDate is null begin
		select 
			cast(1 as int) as SubmittalID,
			cast('' as nvarchar(10)) as Lot,
			cast('' as nvarchar(30)) as Lane,
			cast ('' as nvarchar(40)) as Own_Name,
			cast ('' as nvarchar(100)) as Project,
			cast (getdate() as DateTime) as Mtg_Date,
			cast ('' as nvarchar(3)) as ProjectType,
			cast ('' as nvarchar(3)) as ProjectDecision,
			cast ('' as nvarchar(max)) as Conditions,
			cast ('' as nvarchar(25)) as TypeDescription,
			cast ('' as nvarchar(25)) as DecisionDescription,
			cast (0 as int) as CountApproved,
			cast (0 AS int) as CountApprovedWithConditions,
			cast (0 as int) as CountDeferred,
			cast (0 as int) as CountDenied,
			cast ('4/19/2016' as datetime) as FromDate,
			cast ('5/19/2017' as datetime) as ToDate
	end else begin
		SELECT s.SubmittalID, s.Lot, s.Lane, s.Own_Name, s.Project, s.Mtg_Date, s.ProjectType, s.ProjectDecision, s.Conditions, pt.TypeDescription, pd.DecisionDescription,
				CASE WHEN s.ProjectDecision='A' THEN 1 else 0 END as CountApproved,
				CASE WHEN s.ProjectDecision='AWC' THEN 1 else 0 END as CountApprovedWithConditions,
				CASE WHEN s.ProjectDecision='DEF' THEN 1 else 0 END as CountDeferred,
				CASE WHEN s.ProjectDecision='DEN' THEN 1 else 0 END as CountDenied,
				@FromDate as FromDate, @ToDate as ToDate
		FROM 
		    tblBPData bp right JOIN 
			tblSubmittal s ON bp.fkSubmittalID_PD = s.SubmittalID INNER JOIN
			[tblProjectType{LU}] pt ON s.ProjectType = pt.ProjectType LEFT OUTER JOIN 
			[tblProjectDecision{LU}] pd ON s.ProjectDecision = pd.ProjectDecision
		WHERE s.Mtg_Date Between @FromDate And @ToDate
		ORDER BY TypeDescription, SubmittalID
	end

END
GO
