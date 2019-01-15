
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* =============================================
	select dbo.[udfCommaDelimitedRepresentationOfFollowUpIDs](10)
   ============================================= */
USE SRSellCheck
GO
create FUNCTION [dbo].[udfCommaDelimitedRepresentationOfFollowUpIDs]
(
	@scInspectionID int
)
RETURNS varchar(50)
AS
BEGIN
	DECLARE @ResultVar varchar(50), 
			@Comma char,
			@SellCheckFollowUpId int,
			@DidOne bit
	SET @ResultVar='';
	set @DidOne=0;
	set @Comma='';
	declare @tab table (
		SellCheckFollowUpId int
	)
	insert into @tab 
		SELECT SellCheckFollowUpId FROM tblSellCheckFollowUp WHERE fk_scInspectionID=@scInspectionID
	while exists (select * from @tab) begin
		Set @DidOne=1
		select top 1 @SellCheckFollowUpId=SellCheckFollowUpId from @tab
		set @ResultVar=@ResultVar + @Comma + cast(@SellCheckFollowUpId as varchar) 
		set @Comma=','
		delete from @tab where SellCheckFollowUpId=@SellCheckFollowUpId
		
	end
	if @DidOne=1 Set @ResultVar=@ResultVar
	RETURN @ResultVar

END
GO

