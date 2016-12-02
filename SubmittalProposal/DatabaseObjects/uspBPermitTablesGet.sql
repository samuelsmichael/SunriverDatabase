USE [SRPropertySQL]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 3/11/2015
-- Description:	Gets all three of the main tables in the BPPermit part of the database
/*
	exec uspBPermitTablesGet
*/
-- =============================================
ALTER PROCEDURE uspBPermitTablesGet 

AS
BEGIN
	SET NOCOUNT ON;
	select * from tblBPData;
	with pm as (
		select * from tblBPPayments
			where fkbpermitid_pp in (select b.BPermitID from tblSubmittal s left outer join tblBPData b on s.SubmittalId=b.fkSubmittalID_PD)
		),
	f as (
		select fkBPermitID_PP as BPermitID, sum(isnull(BPMonths,0)) as monthsTotal, sum(isnull(BPFee$,0)) as feeTotal
		from tblBPPayments
		Group BY fkBPermitID_PP
	)
	select pm.*,pm.fkBPermitID_PP as BPermitID,monthsTotal,feeTotal 
	from
		pm inner join f on pm.fkBPermitID_PP=f.BPermitID;

	select r.*,fkBPermitID_PR as BPermitID,fkSubmittalID_PD from tblBPReviews r inner join tblBPData p on r.fkBPermitID_PR=p.BPermitId
		where fkbpermitid_pr in (select b.BPermitID from tblSubmittal s left outer join tblBPData b on s.SubmittalId=b.fkSubmittalID_PD);
end
GO
