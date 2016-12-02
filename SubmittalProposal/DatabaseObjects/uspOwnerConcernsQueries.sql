USE OwnerConcerns

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 10/14/2016
-- Description:	Gets the data for OwnerConcerns Queries
/*
	exec uspOwnerConcernsQueries  @SRLotLane='5 Shadow'
*/
-- =============================================
alter PROCEDURE uspOwnerConcernsQueries 
	@DeptReferred nvarchar(30)=null
	,@StartDate datetime=null
	,@EndDate datetime=null
	,@ConcernsOpen bit = null
	,@Category nvarchar(30) = null
	,@ForceSortByCategory bit = null
	,@ButIncludeBothOpensAndClosedInTheDataSet bit = null
	,@JustDoingCategorySummary bit = null
	,@SRLotLane nvarchar(50) = null
	
AS
BEGIN
	SET NOCOUNT ON;
SELECT c.[OCCase#], c.DeptReferred1,  c.SubmitDate, c.ResolutionDate, c.FirstName, c.LastName, case when c.ResolutionDate is null then 'Yes' else 'No' end as [Open],
	 a.Addr1 AS SRLane, c.Category, c.[Description], c.Resolution, c.CloseFormBy, c.DeptReferred2
FROM [ID-Card_Split_FE]..tblArShipTo a INNER JOIN tblOCData c ON a.CustId = c.[OwnerID#]
WHERE 
	(@DeptReferred is null or c.DeptReferred1=@DeptReferred) 
	AND (@StartDate is null or c.SubmitDate>=@StartDate)
	AND (@EndDate is null or c.SubmitDate<DateAdd(d,1,@EndDate))
	AND (@Category is null or @Category=Category)
	AND (@ConcernsOpen is null or @ButIncludeBothOpensAndClosedInTheDataSet=1 or (
		((@ConcernsOpen=1 and ResolutionDate is null) or
		(@ConcernsOpen=0 and ResolutionDate is not null))
	))                                                                   
	AND (@SRLotLane is null or a.Addr1 like @SRLotLane + '%'
ORDER BY 
	CASE WHEN @ForceSortByCategory=1 then c.Category end,
	CASE WHEN @DeptReferred is null and @ForceSortByCategory is null then c.DeptReferred1 end,
	case when @Category is null then c.Category end,
	c.[OCCase#]
END
GO
