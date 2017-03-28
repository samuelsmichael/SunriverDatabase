SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 5/20/2016
-- Description:	Citations Open
/*
	exec [uspCitationsQry-Open] @StartDate='1/1/2016', @EndDate='6/1/2016'
*/
-- =============================================
use SRCitations;
go
alter PROCEDURE [uspCitationsQry-Open] 
	@StartDate datetime,
	@EndDate datetime
AS
BEGIN
SELECT 


	c.CitationID, c.OffenseDate, c.FineStatus, 
	--IIf([FineStatus]="Open","1","0") AS CitationOpen
	case when FineStatus='Open' then '1' else '0' end AS CitationOpen, 
	c.VLastName, c.VFirstName, c.VMailAddr1, c.VMailAddr2, 
	c.VCity, c.VState, c.VZip, c.VSunriverStatus, c.OffenseLocation, c.CitingOfficer, c.HearingDate, c.MagistrateFine, c.JudicialFine, 
	isnull(c.VFirstName,'') + case when isnull(c.VFirstName,'')='' then '' else ' ' end + isnull(c.VLastName,'') as vFullName,
	c.AssessedFine, c.WriteOff, c.FineBalToAcctg, c.MagistrateNotes, f.TotalCitationFine, f.PrePayAmount, 
	--IIf([FineStatus]="Assessed Fine - Paid",[AssessedFine],IIf([FineStatus]="PrePay Amount - Paid",[PrePayAmount],0)) AS FinePaid
	case when FineStatus='Assessed Fine - Paid' then AssessedFine else case when FineStatus='PrePay Amount - Paid' then PrePayAmount else 0 end end as FinePaid,
	@EndDate as EndDate, @StartDate as StartDate
FROM 
	qryTotalCitationFine f RIGHT JOIN tblCitations c ON f.fkCitationID = c.CitationID
WHERE 
	c.OffenseDate Between @StartDate And @EndDate 
	AND c.FineStatus='Open'
ORDER BY c.CitationID;



END
GO
