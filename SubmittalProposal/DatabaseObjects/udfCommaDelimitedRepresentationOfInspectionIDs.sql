
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* =============================================
	select dbo.[udfCommaDelimitedRepresentationOfInspectionIDs](1985)
   ============================================= */
USE SRSellCheck
GO
create FUNCTION [dbo].[udfCommaDelimitedRepresentationOfInspectionIDs] 
(
	@RequestID int
)
RETURNS varchar(50)
AS
BEGIN
	DECLARE @ResultVar varchar(50), 
			@Comma char,
			@InspectionID int,
			@DidOne bit
	SET @ResultVar='';
	set @DidOne=0;
	set @Comma=',';
	declare @tab table (
		InspectionID int
	)
	insert into @tab 
		SELECT scInspectionID FROM tblSellCheck WHERE fkscRequestID=@RequestID
	while exists (select * from @tab) begin
		Set @DidOne=1
		select top 1 @InspectionID=InspectionID from @tab
		set @ResultVar=@ResultVar + @Comma + cast(@InspectionID as varchar) 
		delete from @tab where InspectionID=@InspectionId
		
	end
	if @DidOne=1 Set @ResultVar=@ResultVar+@Comma
	RETURN @ResultVar

END
GO

