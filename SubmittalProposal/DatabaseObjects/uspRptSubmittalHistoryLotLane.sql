SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 4/12/2015
-- Description:	Query driving Submittal History Lot/Lane
/*
	exec uspRptSubmittalHistoryLotLane @Lot='1', @Lane='Squirrel'
	exec uspRptSubmittalHistoryLotLane @Lot=null, @Lane=null
*/
-- =============================================
use srpropertysql
go
ALTER PROCEDURE uspRptSubmittalHistoryLotLane 
	@Lot varchar(10)=null, 
	@Lane varchar(30)=null 
AS
BEGIN
	SET NOCOUNT ON;
	if @Lot is null begin
		select 
			cast (1 as int) as SubmittalID,
			cast (1 as int) as BPermitID,
			cast ('' as nvarchar(100)) as Lot,
			cast ('' as nvarchar(100)) as Lane,
			cast ('' as nvarchar(40)) as Own_Name,
			cast ('' as nvarchar(3)) as ProjectType,
			cast ('' as nvarchar(max)) as Submittal,
			cast (getdate() as DateTime) as Mtg_Date,
			cast ('' as nvarchar(3)) as ProjectDecision,
			cast ('' as nvarchar(max)) as Conditions,
			cast (getDate() as DateTime) as BPIssueDate,
			cast ('' as nvarchar(25)) as Applicant,
			cast ('' as nvarchar(30)) as Contractor,
			cast (getDate() as DateTime) as BPClosed,
			cast ('' as nvarchar(10)) as Lot,
			cast ('' as nvarchar(30)) as Laned
	end else begin
		SELECT 
			s.SubmittalID, b.BPermitID, s.Lot, s.Lane, s.Own_Name, s.ProjectType, 
			s.Submittal, s.Mtg_Date, s.ProjectDecision, s.Conditions, b.BPIssueDate, 
			s.Applicant, s.Contractor, b.BPClosed, @Lot as Lot, @Lane as Lane
		FROM 
			tblSubmittal s INNER JOIN tblBPData b ON s.SubmittalID = b.fkSubmittalID_PD
		WHERE 
			s.Lot=@Lot and s.Lane=@Lane
		ORDER BY s.Mtg_Date;
	END
END
GO
