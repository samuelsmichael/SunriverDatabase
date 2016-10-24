USE ComRoster

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 10/14/2016
-- Description:	Updates tblRosterMembers
-- =============================================
create PROCEDURE uspRosterMemberSet 
	@RosterMemberID int=null,
	@CommitteeID int,
	@MemberID int,
	@MTitle nvarchar(15),
	@TAppointed datetime = null,
	@TStart datetime =null,
	@TEnd datetime=null,
	@TTerm nvarchar(2),
	@NewRosterMemberID int out
AS
BEGIN
	SET NOCOUNT ON;
	if @RosterMemberID is not null and exists (select @RosterMemberID from tblRosterMembers where RosterMemberID=@RosterMemberID) begin
		UPDATE tblRosterMembers
		SET
			CommitteeID=@CommitteeID,
			MemberID=@MemberID,
			MTitle=@MTitle,
			TAppointed=@TAppointed,
			TStart=@TStart,
			TEnd=@TEnd,
			TTerm=@TTerm
		WHERE RosterMemberID=@RosterMemberID
		set @NewRosterMemberID=@RosterMemberID
	end else begin
		insert into tblRosterMembers (CommitteeID,MemberID,MTitle,TAppointed,TStart,TEnd,TTerm)
		SELECT
			@CommitteeID,@MemberID,@MTitle,@TAppointed,@TStart,@TEnd,@TTerm
		Set @NewRosterMemberID=scope_identity()
	end
END
GO
