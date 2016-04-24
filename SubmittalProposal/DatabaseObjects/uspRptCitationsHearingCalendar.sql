SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 4/23/2016
-- Description:	Gets Data Set that drives Citations Hearing Calendar report
/*
	Exec uspRptCitationsHearingCalendar '4/19/2016'
*/
-- =============================================
CREATE PROCEDURE uspRptCitationsHearingCalendar 
	@HearingDate datetime
AS
BEGIN	
	SET NOCOUNT ON;
	SELECT 
		c.CitationID, c.OffenseDate, c.HearingDate, c.FineStatus, case when [FineStatus]='Open' then 1 else 0 end AS CitationOpen, 
		c.VLastName, c.VFirstName, c.VMailAddr1, c.VMailAddr2, c.VCity, c.VState, c.VZip, c.VSunriverStatus, c.OffenseLocation, 
		c.CitingOfficer, c.MagistrateFine, c.JudicialFine, c.AssessedFine, c.WriteOff, c.FineBalToAcctg, c.MagistrateNotes, f.TotalCitationFine, 
		f.PrePayAmount, case when [FineStatus]='Assessed Fine - Paid' then [AssessedFine] else 0 end as AssessedFine,case when [FineStatus]='PrePay Amount - Paid' then [PrePayAmount] else 0 end AS FinePaid
	FROM 
		qryTotalCitationFine f RIGHT JOIN 
		tblCitations c ON f.fkCitationID = c.CitationID
	WHERE c.HearingDate=@HearingDate
	ORDER BY c.CitationID;
END
GO
