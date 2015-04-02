SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 3/11/2015
-- Description:	Gets Data Set that drives GridView
/*
	Exec uspBPermitDataGridViewDataGet
*/
-- =============================================
ALTER PROCEDURE uspBPermitDataGridViewDataGet 
AS
BEGIN	
	SET NOCOUNT ON;
	with p as (
		SELECT 
			b.BPermitId,
			b.BPermitID as fkBPermitID_PR,
			s.SubmittalId,
			b.fkSubmittalID_Pd,
			s.Lot,
			s.Lane,
			b.BPIssueDate,
			b.BPClosed,
			s.Own_Name as OwnersName,
			s.Applicant,
			s.Contractor,
			b.BPermitReqd,
			s.ProjectType,
			s.Project,
			b.BPDelay
		FROM
			tblBPData b inner JOIN
			tblSubmittal s on s.SubmittalId=b.fkSubmittalID_PD),
	e as (
		SELECT 
			fkBPermitID_PP as BPermitID, sum(isnull(BPMonths,0)) as Months 
		FROM 
			tblBPPayments
		GROUP BY fkBPermitID_PP
	)
	select p.*,isnull(e.Months,0) as Months,DATEADD(month,isnull(e.Months,0),BPIssueDate) as BPExpires 
	from 
 		p left outer join e on p.BPermitID=e.BPermitID
END
GO
