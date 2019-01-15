
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* =============================================
	select dbo.[udfBarDelimitedRepresentationOfFollowUpDescriptions](10)
   ============================================= */
USE SRSellCheck
GO
alter FUNCTION [dbo].[udfBarDelimitedRepresentationOfFollowUpDescriptions]
(
	@scInspectionID int
)
RETURNS varchar(max)
AS
BEGIN
	DECLARE @ResultVar varchar(max), 
			@Bar char,
			@SellCheckFollowUpDescription nvarchar(max),
			@SellCheckFollowUpId int,
			@DidOne bit
	SET @ResultVar='';
	set @DidOne=0;
	set @Bar='';
	declare @tab table (
		[Description] nvarchar(max),
		SellCheckFollowUpId int
	)
	insert into @tab 
		SELECT [description],SellCheckFollowUpId FROM tblSellCheckFollowUp WHERE fk_scInspectionID=@scInspectionID
	while exists (select * from @tab) begin
		Set @DidOne=1
		select top 1 @SellCheckFollowUpDescription=[description], @SellCheckFollowUpId=SellCheckFollowUpId from @tab
		set @ResultVar=@ResultVar + @Bar + @SellCheckFollowUpDescription 
		SET @Bar='|'
		delete from @tab where SellCheckFollowUpId=@SellCheckFollowUpId
		
	end
	if @DidOne=1 Set @ResultVar=@ResultVar
	RETURN @ResultVar

END
GO

