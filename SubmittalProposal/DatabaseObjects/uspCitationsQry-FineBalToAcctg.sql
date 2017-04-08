SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 5/20/2016
-- Description:	Rpt Fine Bal to Acctg
/*
	exec [uspCitationsQry-FineBalToAcctg] @StartDate='1/1/2014', @EndDate='6/1/2016'
*/
-- =============================================
use srcitations
go
alter PROCEDURE [uspCitationsQry-FineBalToAcctg] 
	@StartDate datetime,
	@EndDate datetime
AS
BEGIN
SELECT 
	c.CitationID, c.OffenseDate, c.FineBalToAcctg, c.FineStatus, 
	CASE WHEN FineStatus = 'Open' then 1 ELSE 0 END AS CitationOpen,
	isnull(c.VFirstName,'') + case when isnull(c.VFirstName,'')='' then '' else ' ' end + isnull(c.VLastName,'') as vFullName,
	c.VMailAddr1, 
	c.VMailAddr2, c.VCity, c.VState, c.VZip, c.VSunriverStatus, 
	c.OffenseLocation, c.CitingOfficer, c.HearingDate, c.MagistrateFine, c.JudicialFine, 
	c.AssessedFine, c.WriteOff, c.MagistrateNotes, f.TotalCitationFine, f.PrePayAmount, 
--	IIf([FineStatus]="Assessed Fine - Paid",[AssessedFine],IIf([FineStatus]="PrePay Amount - Paid",[PrePayAmount],0)) AS FinePaid
	case when FineStatus='Assessed Fine - Paid' then AssessedFine else case when FineStatus='PrePay Amount - Paid' then PrePayAmount else 0 end end as FinePaid,
	c.Citation#

FROM qryTotalCitationFine f RIGHT JOIN tblCitations c ON f.fkCitationID=c.CitationID
WHERE c.OffenseDate Between @StartDate And @EndDate AND c.FineStatus='Balance To Accounting'
ORDER BY c.Citation#;




END
GO
