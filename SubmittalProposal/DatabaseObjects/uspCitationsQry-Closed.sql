SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 4/22/2016
-- Description:	Updates Citations
/*
	exec [uspCitationsQry-Closed] @StartDate='1/1/2014', @EndDate='1/1/2017'
*/
-- =============================================
Use SRCitations;
go

alter PROCEDURE [uspCitationsQry-Closed] 
	@StartDate datetime,
	@EndDate datetime
AS
BEGIN
SELECT 
	c.CitationID, c.OffenseDate, c.FineStatus, 
	--IIf([FineStatus]="Open","1","0") AS CitationOpen
	case when FineStatus='Open' THEN '1' else '0' end as CitationOpen,
	c.VLastName, c.VFirstName, 
	isnull(c.VFirstName,'') + case when isnull(c.VFirstName,'')='' then '' else ' ' end + isnull(c.VLastName,'') as vFullName,
	c.VMailAddr1, c.VMailAddr2, c.VCity, c.VState, c.VZip, c.VSunriverStatus, c.OffenseLocation, c.CitingOfficer, c.HearingDate, c.MagistrateFine, c.JudicialFine, 
	c.AssessedFine, c.WriteOff, c.FineBalToAcctg, c.MagistrateNotes, f.TotalCitationFine, f.PrePayAmount, 
--	IIf([FineStatus]="Assessed Fine - Paid",[AssessedFine],
	--	IIf([FineStatus]="PrePay Amount - Paid",[PrePayAmount],0)) AS FinePaid
	case when FineStatus='Assessed Fine - Paid' then AssessedFine else case when FineStatus='PrePay Amount - Paid' then PrePayAmount else 0 end end as FinePaid,
	@EndDate as EndDate, @StartDate as StartDate

FROM 
	qryTotalCitationFine f RIGHT JOIN tblCitations c ON f.fkCitationID = c.CitationID
WHERE 
	c.OffenseDate Between @StartDate And @EndDate 
	AND c.FineStatus in (
		'Assessed Fine - Paid',
	    'Balance To Accounting',
		'Dismissed',
		'PrePay Amount - Paid',
		'Reduced to a Warning',
		'WriteOff\Uncollectable')
ORDER BY FineStatus,c.CitationID;

END
GO

