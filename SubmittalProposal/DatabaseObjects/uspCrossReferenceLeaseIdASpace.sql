SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/2/2015
-- Description: qry cross references LeaseId and Space
-- =============================================
/*
	exec uspCrossReferenceLeaseIdASpace
*/
create PROCEDURE uspCrossReferenceLeaseIdASpace
AS
BEGIN
	SELECT tblRVData.RVLeaseID, tblRVData.tRVDSpace
	FROM tblRVData;

END
GO
