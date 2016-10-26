
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* =============================================
	select dbo.udfCommitteesForMember(260)
   ============================================= */
alter FUNCTION dbo.udfCommitteesForMember(@MemberID int)
RETURNS varchar(100)
AS
BEGIN
	Declare @Result varchar(100),
			@CommitteeID int
	Declare @table table (
		CommitteeID int
	)
	set @Result=''
	insert into @table
		select CommitteeID from tblRosterMembers where MemberID=@MemberID
	while exists(select * from @table) begin
		select top 1 @CommitteeID=CommitteeID from @table
		set @Result=@Result+'|'+cast(@CommitteeID as varchar)+'|'
		delete from @table where CommitteeID=@CommitteeID
	end
	RETURN @Result

END
GO

