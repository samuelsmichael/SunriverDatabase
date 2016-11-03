Use ComRoster

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* =============================================
Finds a legitimate LiaisonID, trying to adhere to the rules:
SROA Board 2 - 9
SROA Staff 21-39
SSD STAFF 41-49
Associate 51-69

We need to find a vacant LiaisonId (per the rules) that is empty,
or create a new one (per the rules).  If this fails, then 
a new number is created at the end.

/*
	Test:
		declare @NewLiaisonID int
		exec uspFindLegitmateLiaisonID @OrignalLiaisonID=60, @OriginalLiaisonType='Associate', @NewLiaisonType='sroa staff',@NewLiaisonID=@NewLiaisonID out
		print 'New LiaisonID='
		print cast (@NewLiaisonID as varchar)

	Test2:
		declare @NewLiaisonID int
		exec uspFindLegitmateLiaisonID @OrignalLiaisonID=null, @OriginalLiaisonType='', @NewLiaisonType='ssd staff',@NewLiaisonID=@NewLiaisonID out
		print 'New LiaisonID='
		print cast (@NewLiaisonID as varchar)


*/

-- ============================================= */
alter PROCEDURE uspFindLegitmateLiaisonID
	@OrignalLiaisonID int,
	@OriginalLiaisonType nvarchar(15),
	@NewLiaisonType nvarchar(15),
	@NewLiaisonID int out
AS
BEGIN
	SET NOCOUNT ON;
	declare 
		@UpperBound int,
		@LowerBound int
	if @OriginalLiaisonType is not null and @OriginalLiaisonType = @NewLiaisonType begin
		set @NewLiaisonID=@OrignalLiaisonID
	end else begin
		if @NewLiaisonType = 'SROA Board' begin
			set @LowerBound=2
			set @UpperBound=9
		end else begin
			if @NewLiaisonType = 'SROA Staff' begin
				set @LowerBound=21
				set @UpperBound=39
			end else begin
				if @NewLiaisonType = 'SSD Staff' begin
					set @LowerBound=41
					set @UpperBound=49
				end else begin
					set @LowerBound=51
					set @UpperBound=69
				end
			end
		end
		print '@LowerBound='+cast(@LowerBound as varchar)
		print '@UpperBound='+Cast(@UpperBound as varchar)
		-- Try to find an existiong one in the range whose LiaisonName is null
			declare @WorkingLiaisonID2 int
			select @WorkingLiaisonID2=LiaisonID from tblLiaisonData where LiaisonName is null and LiaisonID >= @LowerBound and LiaisonID <= @UpperBound
			print 'I got one in the range:'
			print Cast (@WorkingLiaisonID2 as varchar)
			if @WorkingLiaisonID2 is null begin
				declare @WorkingLiaisonID int
				set @WorkingLiaisonID=@LowerBound
				while @WorkingLiaisonID <= @UpperBound begin
					if not exists (select * from tblLiaisonData where LiaisonID=@WorkingLiaisonID) begin
						set @NewLiaisonID=@WorkingLiaisonID
						break
					end
					set @WorkingLiaisonID = @WorkingLiaisonID + 1
				end
				if @NewLiaisonID is /*still*/ null begin
					select top 1 @NewLiaisonID = LiaisonID from tblLiaisonData order by LiaisonID desc
					set @NewLiaisonID = @NewLiaisonID + 1
				end
			end else begin
				set @NewLiaisonID=@WorkingLiaisonID2
			end
	end
	print 'FindLegitimateID='
	print cast(@NewLiaisonId as varchar)
END
GO
