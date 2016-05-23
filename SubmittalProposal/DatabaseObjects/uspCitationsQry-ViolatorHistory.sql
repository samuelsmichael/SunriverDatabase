SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 5/20/2016
-- Description:	Violator History
/*
	exec [uspCitationsQry-ViolatorHistory] @LastName='duffy'
*/
-- =============================================
alter PROCEDURE [uspCitationsQry-ViolatorHistory] 
	@LastName nvarchar(20)
AS
BEGIN
SELECT 
	c.CitationID, c.OffenseDate, 
	case when FineStatus='Open' then 1 else 0 end as CitationOpen,
--	IIf([FineStatus]="Open","1","0") AS CitationOpen, 
	c.VLastName, c.VFirstName, c.VMailAddr1, c.VMailAddr2, c.VCity, c.VState, c.VZip, c.VSunriverStatus, 
	c.OffenseLocation, c.CitingOfficer, c.HearingDate, c.MagistrateFine, c.JudicialFine, c.AssessedFine, c.WriteOff, 
	c.FineBalToAcctg, c.FineStatus, c.MagistrateNotes, f.TotalCitationFine, f.PrePayAmount, 
	case when FineStatus='Assessed Fine - Paid' then AssessedFine else case when FineStatus='PrePay Amount - Paid' then PrePayAmount else 0 end end as FinePaid,
--	IIf([FineStatus]="Assessed Fine - Paid",[AssessedFine],IIf([FineStatus]="PrePay Amount - Paid",[PrePayAmount],0)) AS FinePaid,
	isnull(c.VFirstName,'') + case when isnull(c.VFirstName,'')='' then '' else ' ' end + isnull(c.VLastName,'') as vFullName

FROM 
	qryTotalCitationFine f INNER JOIN tblCitations c ON f.fkCitationID=c.CitationID
WHERE 
	c.VLastName like '%'+ @LastName+'%'

ORDER BY c.OffenseDate



END
GO
