SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 9/07/2015
-- Description:	Sell Check report History
/*
	exec uspRptSellCheckHistory 3,'Quail'
*/
-- =============================================
Use SRSellCheck
go
alter PROCEDURE uspRptSellCheckHistory
	@Lot varchar(10),
	@Lane varchar(28)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT sc.*, @Lot as Lot, @Lane as Lane
	FROM [SRSellCheck].[dbo].tblsellcheck sc inner join tblRequest r on r.scRequestId=sc.fkscRequestId where scLot=@lot and scLane=@lane
END
GO
