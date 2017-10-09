SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 5/20/2016
-- Description:	Rpt Fine Bal to Acctg
/*
	exec [uspCitationsQry-StdBasedOnFineStatus] @StartDate='1/1/2014', @EndDate='12/31/2016', @WhereFineStatus='Issued as a Warning', @EqualvsNotEqual = 0 -- Fine Summary
	exec [uspCitationsQry-StdBasedOnFineStatus] @StartDate='1/1/2014', @EndDate='12/31/2016', @WhereFineStatus='Balance To Accounting', @EqualvsNotEqual = 1 -- Balance to Acctg
	exec [uspCitationsQry-StdBasedOnFineStatus] @StartDate='1/1/2014', @EndDate='12/31/2016', @WhereFineStatus='Open', @EqualvsNotEqual = 1 -- Open
	
*/
-- =============================================
Use SRCitations;
go
ALTER PROCEDURE [uspCitationsQry-StdBasedOnFineStatus] 
	@StartDate datetime,
	@EndDate datetime,
	@WhereFineStatus varchar(50),
	@EqualvsNotEqual bit
AS
BEGIN
SELECT 
	c.CitationID, c.OffenseDate, c.FineBalToAcctg, c.FineStatus, 
	CASE WHEN FineStatus = 'Open' then 1 ELSE 0 END AS CitationOpen,
	isnull(c.VFirstName,'') + case when isnull(c.VLastName,'')='' then '' else ' ' end + isnull(c.VFirstName,'') as vFullName,
	c.VMailAddr1, 
	c.VMailAddr2, c.VCity, c.VState, c.VZip, c.VSunriverStatus, 
	c.OffenseLocation, c.CitingOfficer, c.HearingDate, c.MagistrateFine, c.JudicialFine, 
	c.AssessedFine, c.WriteOff, c.MagistrateNotes, f.TotalCitationFine, f.PrePayAmount, 
--	IIf([FineStatus]="Assessed Fine - Paid",[AssessedFine],IIf([FineStatus]="PrePay Amount - Paid",[PrePayAmount],0)) AS FinePaid
	case when FineStatus='Assessed Fine - Paid' then AssessedFine else case when FineStatus='PrePay Amount - Paid' then PrePayAmount else 0 end end as FinePaid,
	@EndDate as EndDate, @StartDate as StartDate, c.Citation#

FROM qryTotalCitationFine f inner JOIN tblCitations c ON f.fkCitationID=c.CitationID 
WHERE c.OffenseDate Between @StartDate And @EndDate AND 
	(
		(@EqualvsNotEqual=1 and c.FineStatus = @WhereFineStatus) 
		or
		(@EqualvsNotEqual=0 and c.FineStatus != @WhereFineStatus) 
	)
ORDER BY FineStatus,c.Citation#;




END
GO
