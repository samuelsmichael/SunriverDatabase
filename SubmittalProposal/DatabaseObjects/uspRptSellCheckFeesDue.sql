SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 9/07/2015
-- Description:	Sell Check report Fees Due
/*
	exec uspRptSellCheckFeesDue '1/1/2015', '9/20/2015'
*/
-- =============================================
Use SRSellCheck
go
alter PROCEDURE uspRptSellCheckFeesDue
	@StartDate DateTime,
	@EndDate DateTime
AS
BEGIN
	declare @OriginalEndDate datetime
	set @OriginalEndDate=@EndDate
	SET NOCOUNT ON;
	set @EndDate=DateAdd(dd,1,@EndDate)
	set @EndDate=DateAdd(mi,-1,@EndDate)
	
	select sc.*, r.scLot, r.scLane, r.scRealtor, @StartDate as StartDate, @OriginalEndDate as EndDate
	from tblSellCheck sc INNER JOIN 
		tblRequest r ON sc.fkscRequestID = r.scRequestID
	where scPaid=0 and scDate>=@StartDate and scDate<=@EndDate
	order by scLane
END
GO
