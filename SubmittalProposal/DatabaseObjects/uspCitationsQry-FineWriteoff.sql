SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 5/20/2016
-- Description:	rpt Fine Writeoff
/*
	exec [uspCitationsQry-FineWriteoff] @StartDate='1/1/2014', @EndDate='6/1/2017'
*/
-- =============================================
use SRCitations;
go
alter PROCEDURE [uspCitationsQry-FineWriteoff] 
	@StartDate datetime,
	@EndDate datetime
AS
BEGIN
SELECT 
	c.CitationID, c.OffenseDate, c.WriteOff, c.FineStatus, 
	CASE WHEN FineStatus = 'Open' then 1 ELSE 0 END AS CitationOpen,
	--IIf([FineStatus]="Open","1","0") AS CitationOpen, 
	c.VLastName, c.VFirstName, 
	isnull(c.VFirstName,'') + case when isnull(c.VFirstName,'')='' then '' else ' ' end + isnull(c.VLastName,'') as vFullName,

	c.VMailAddr1, 
	c.VMailAddr2, c.VCity, c.VState, c.VZip, c.VSunriverStatus, 
	c.OffenseLocation, c.CitingOfficer, c.HearingDate, c.MagistrateFine, 
	c.JudicialFine, c.AssessedFine, c.FineBalToAcctg, c.MagistrateNotes, 
	f.TotalCitationFine, f.PrePayAmount, 
	case when FineStatus='Assessed Fine - Paid' then AssessedFine else case when FineStatus='PrePay Amount - Paid' then PrePayAmount else 0 end end as FinePaid,
	@StartDate as StartDate, @EndDate as EndDate, c.Citation#
--	IIf([FineStatus]="Assessed Fine - Paid",[AssessedFine],IIf([FineStatus]="PrePay Amount - Paid",[PrePayAmount],0)) AS FinePaid
FROM qryTotalCitationFine f RIGHT outer JOIN tblCitations c ON f.fkCitationID = c.CitationID
WHERE c.OffenseDate Between @StartDate And @EndDate AND c.WriteOff>0
ORDER BY c.Citation#



END
GO
