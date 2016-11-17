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
	exec uspOwnerConcernsQueries @DeptReferred='Community Development'
*/
-- =============================================
alter PROCEDURE uspOwnerConcernsQueries 
	@DeptReferred nvarchar(30)=null
	,@StartDate datetime=null
	,@EndDate datetime=null
	,@ConcernsOpen bit = null
	,@Category nvarchar(30) = null
	
AS
BEGIN
	SET NOCOUNT ON;
declare @cmd nvarchar(max)
set @cmd='
SELECT c.[OCCase#], c.DeptReferred1,  c.SubmitDate, c.ResolutionDate, c.FirstName, c.LastName, a.Addr1 AS SRLane, c.Category, c.[Description], c.Resolution, c.CloseFormBy, c.DeptReferred2
FROM [ID-Card_Split_FE]..tblArShipTo a INNER JOIN tblOCData c ON a.CustId = c.[OwnerID#]
WHERE 
	(@DeptReferred is null or c.DeptReferred1=@DeptReferred) 
	AND (@StartDate is null or c.SubmitDate>=@StartDate)
	AND (@EndDate is null or c.SubmitDate<DateAdd(d,1,@EndDate))
	AND (@Category is null or @Category=Category)
	AND (@ConcernsOpen is null or (
		((@ConcernsOpen=1 and ResolutionDate is null) or
		(@ConcernsOpen=0 and ResolutionDate is not null))
	)) 
ORDER BY '
if @DeptReferred is null and @Category is null begin
	set @cmd=@cmd+' c.DeptReferred1,c.Category,c.[OCCase#] '
end else begin
	if @DeptReferred is null begin
		set @cmd=@cmd + ' c.DeptReferred1,c.[OCCase#]'
	end else begin
		if @Category is null begin
			set @cmd=@cmd + ' c.Category,c.[OCCase#]'
		end else begin
			set @cmd=@cmd + ' c.[OCCase#]'
		end
	end
end
print @cmd
exec (@cmd)

END
GO
