SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 9/07/2015
-- Description:	Sell Check report 
/*
	exec uspRptSellCheck '1/1/2015','12/31/2015'
*/
-- =============================================
alter PROCEDURE uspRptSellCheck
	@FromDate datetime,
	@ToDate datetime
AS
BEGIN
	SET NOCOUNT ON;
	SELECT r.scLot, r.scLane,sc.*
	FROM [SRSellCheck].[dbo].tblsellcheck sc inner join tblRequest r on r.scRequestId=sc.fkscRequestId
	WHERE scDate>=@FromDate and scDate <= @ToDate
END
GO
